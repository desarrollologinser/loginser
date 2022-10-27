unit u_cam_gl;

interface

uses pfibdataset,sysutils, pFIBQuery, FIBQuery,FIBDataSet,
  pFIBDatabase, data.db;

procedure lee_inis_def;
procedure GetLoteCaducidad(id_lote:integer; out lote,caducidad:string);
function inserta_etiq_tmp(id_usuario,id_albaran:Integer):string;
function imprime_etiq_tmp(id_usuario:integer):string;
function PedidoPendiente(id_articulo:Integer): Boolean;
function existe_etiq_tmp(id_usuario,id_albaran:Integer):integer;
function GetImeiPedido(id_pedido,id_articulo:Integer):string;

  //lee datos iniciales por defecto para trabajar con campañas desde C_AUX

var
  asm_exp_email:string;         //Email para enviar archivos de expediciones a ASM
  asm_exp_path:string;          //Ruta desde SYS_PATH a carpeta de envios de ASM
  chrono_exp_email:string;      //Email para enviar archivos de expediciones a Chrono
  chrono_exp_path:string;       //Ruta desde SYS_PATH a carpeta de envios de Chrono
  magal_exp_email:string;       //Email para enviar archivos de expediciones a Magal
  magal_exp_path:string;        //Ruta desde SYS_PATH a carpeta de envios de Magal
  mensytrans_exp_email:string;  //Email para enviar archivos de expediciones a Magal
  mensytrans_exp_path:string;   //Ruta desde SYS_PATH a carpeta de envios de Magal
  correos_exp_path:string;      //Ruta desde SYS_PATH a carpeta de envios de Correos
  ruta_log: string;             //Ruta donde se guardan los logs de campanyas

implementation

uses u_dm,u_globals, u_LstEtiquetas;

{$REGION 'Inis'}
procedure lee_inis_def;                  //Lee inis de la tabla C_AUX para campañas
begin
  with tpfibdataset.create(dm) do
  try
    database:=dm.db;
    close;
    sqls.SelectSQL.Clear;
    sqls.selectsql.Add('select asm_exp_email,asm_exp_path,chrono_exp_email,chrono_exp_path,' +
                       'magal_exp_email,magal_exp_path,mensytrans_exp_email,mensytrans_exp_path,' +
                       'correos_exp_path, logs_campanyas '+
                       'from c_aux '+
                       'where id_empresa='+inttostr(u_globals.id_empresa));
    open;

    if not(isempty) then begin
      asm_exp_email:=fieldbyname('asm_exp_email').asstring;
      asm_exp_path:=FieldByName('asm_exp_path').asstring;
      chrono_exp_email:=fieldbyname('chrono_exp_email').asstring;
      chrono_exp_path:=FieldByName('chrono_exp_path').asstring;
      magal_exp_email:=fieldbyname('magal_exp_email').asstring;
      magal_exp_path:=FieldByName('magal_exp_path').asstring;
      mensytrans_exp_email:=fieldbyname('mensytrans_exp_email').asstring;
      mensytrans_exp_path:=FieldByName('mensytrans_exp_path').asstring;
      correos_exp_path:=FieldByName('correos_exp_path').asstring;
      ruta_log:=FieldByName('logs_campanyas').asstring;
    end else raise exception.Create('Error Cargando Valores Iniciales Desde BD');

  finally
    free;
  end;
end;
{$ENDREGION}

procedure GetLoteCaducidad(id_lote:integer; out lote,caducidad:string);
begin
  lote := '';
  caducidad := '';

  with tpfibdataset.create(dm) do
  try
    database:=dm.db;
    close;
    sqls.SelectSQL.Clear;
    sqls.selectsql.Add('select id_lote,caducidad from a_lotes where id_lote=:id_lote and estado=''A'' ');
    ParamByName('id_lote').AsInteger := id_lote;
    open;

    if not(isempty) then begin
      lote := fieldbyname('id_lote').asstring;
      caducidad := FormatDateTime('dd/mm/yyyy',FieldByName('caducidad').AsDateTime);
    end;

  finally
    free;
  end;
end;

function inserta_etiq_tmp(id_usuario,id_albaran:Integer):string;
begin
   Result := '';

   try
     with tpFIBQuery.Create(dm) do
     begin
       try
         dbname := dm.db_gestoras.DBName;
         Transaction := dm.t_write_gestoras;
         sql.Clear;
         sql.Add('insert into tmp_lst_etiquetas (USUARIO, ID_ALBARAN) values (:usuario,:albaran)');
         ParamByName('usuario').AsInteger:= id_usuario;
         ParamByName('albaran').AsInteger:= id_albaran;
         ExecQuery;

       finally
         Free;
       end;
     end;
   except
     Result := 'Error insertando etiqueta temporal.';
   end;
end;

function imprime_etiq_tmp(id_usuario:Integer):string;
begin
    result := '';

    try

      try
        DMLstEtiquetas.ObtenEtiquetas('A','');
      except on E:Exception do
             begin
               result := 'Error obteniendo etiquetas.';
               raise;
             end;
      end;

    finally
      dm.q_1.Database := dm.db;
      dm.q_1.Close;
      dm.q_1.sql.Clear;
      dm.q_1.sql.Add('delete from tmp_lst_etiquetas where usuario=:usuario');
      dm.q_1.ParamByName('usuario').AsInteger:= id_usuario;
      dm.q_1.ExecQuery;
    end;
end;

function existe_etiq_tmp(id_usuario,id_albaran:Integer):integer;
begin
   try
      with tpfibdataset.create(dm) do
     begin
       try
         dbname := dm.db_gestoras.DBName;
         Transaction := dm.t_write_gestoras;
         sqls.SelectSQL.Clear;
         sqls.SelectSQL.Add('select * from tmp_lst_etiquetas where id_albaran=:albaran and usuario=:usuario');
         ParamByName('usuario').AsInteger:= id_usuario;
         ParamByName('albaran').AsInteger:= id_albaran;
         open;

         if IsEmpty then
            Result := 0
         else
            Result := 1;

       finally
         Free;
       end;
     end;
   except
     Result := -1;
   end;
end;

function PedidoPendiente(id_articulo:Integer):Boolean;
begin
with tpfibdataset.create(dm) do
  try
    database:=dm.db;
    close;
    sqls.SelectSQL.Clear;
    sqls.selectsql.Add('select p.id_pedido from c_pedidos_lines l ' +
                       'inner join c_pedidos p on p.id_pedido=l.id_pedido ' +
                       ' where l.id_articulo=:id_articulo and p.estado in (''P'',''X'') ');
    ParamByName('id_articulo').AsInteger := id_articulo;
    open;

    result := not IsEmpty;
  finally
    free;
  end;
end;

function GetImeiPedido(id_pedido,id_articulo:integer):string;
begin

  result := '';
  with tpfibdataset.create(dm) do
  try
    database:=dm.db;
    close;
    sqls.SelectSQL.Clear;
    sqls.selectsql.Add('select imei from c_pedidos_lines where id_pedido=:id_pedido and id_articulo=:id_articulo ');
    ParamByName('id_pedido').AsInteger := id_pedido;
    ParamByName('id_articulo').AsInteger := id_articulo;
    open;

    if not(isempty) then begin
      result := fieldbyname('imei').asstring;
    end;

  finally
    free;
  end;
end;

end.
