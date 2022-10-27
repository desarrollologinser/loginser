unit u_gen_gl;

interface

uses pfibdataset,sysutils, System.Types, pFIBQuery;

procedure lee_inis_def;
  //lee datos iniciales por defecto para trabajar desde G_AUX
function BuscaCliente(codigo:string):string;
function BuscaGrupoCliente(codigo:integer):Integer;
function CargarDatosAgencia(campos: string; cliente, agencia:Integer):string;
procedure BuscarUbicacionDeArticulo(id_articulo, id_almacen:integer; out ubi:Integer; out est, pos, alt, sub1, sub2:string; out id_lote:integer);
function GetNombreAgencia(id_agencia:Integer):string;
function GetUsuario(id_usuario:Integer):string;
function CargarDatosTabla(tabla,campos, criterios: string):string;
function UpdateDatosTabla(tabla,campos, criterios: string):string;
function ArtsRelacionados(id_articulo:integer):string;
procedure GuardarRelacionArts(art1, art2:integer);
function BuscaArticulo(id_articulo:integer; out codigo:string):string;
function BuscaArticuloXCod(codigo:string; out id_articulo:integer):string;
function GetRepartidorLgs(id_gestoras:Integer):Integer;
function GetRelacionAgencia(id_agencia:Integer):Integer;
function GetIdLote(lote:string):Integer;
function GetUbiPick(id_pick, id_art:Integer):string;

var
  sys_path:string;       //Ruta Inicial de la carpeta de Archivos del Sistema
  sys_email_dir:string;    //config del correo del sistema
  sys_email_user:string;
  sys_email_pass:string;
  sys_email_host:string;
  sys_email_smtp_port:integer;
  noreply_email_dir:string;    //config del correo del noreply
  noreply_email_user:string;
  noreply_email_pass:string;
  noreply_email_host:string;
  noreply_email_smtp_port:integer;

implementation

uses u_dm,u_globals;

{$REGION 'Inis'}
procedure lee_inis_def;                  //Lee inis de la tabla G_AUX para almacen
begin
  with dm.q_aux do
  try
    database:=dm.db;
    close;
    sqls.SelectSQL.Clear;
    sqls.selectsql.Add('select sys_path,sys_email_dir,sys_email_user,sys_email_pass,sys_email_host,sys_email_smtp_port, '+
      ' noreply_email_dir,noreply_email_user,noreply_email_pass,noreply_email_host,noreply_email_smtp_port '+
      'from g_aux '+
      'where id_empresa='+inttostr(u_globals.id_empresa));
    open;

    if not(isempty) then begin
      sys_path:=fieldbyname('sys_path').asstring;
      sys_email_dir:=fieldbyname('sys_email_dir').asstring;
      sys_email_user:=fieldbyname('sys_email_user').asstring;
      sys_email_pass:=fieldbyname('sys_email_pass').asstring;
      sys_email_host:=fieldbyname('sys_email_host').asstring;
      sys_email_smtp_port:=FieldByName('sys_email_smtp_port').AsInteger;
      noreply_email_dir:=fieldbyname('noreply_email_dir').asstring;
      noreply_email_user:=fieldbyname('noreply_email_user').asstring;
      noreply_email_pass:=fieldbyname('noreply_email_pass').asstring;
      noreply_email_host:=fieldbyname('noreply_email_host').asstring;
      noreply_email_smtp_port:=FieldByName('noreply_email_smtp_port').AsInteger;
    end else raise exception.Create('Error Cargando Valores Iniciales Desde BD');

  finally
    free;
  end;
end;
{$ENDREGION}


{$REGION 'MASTER TABLES'}

function  BuscaCliente(codigo:string):string;
begin                                       //devuelve nombre de cliente a partir de codigo
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select nombre from g_clientes where id_cliente=:id');
    ParambyName('id').asstring:=codigo;
    Open;

    if not(IsEmpty) then Result:=FieldByName('nombre').asstring
    else result:='';

    Free;
  end;
end;

function  BuscaGrupoCliente(codigo:integer):integer;
begin                                       //devuelve nombre de cliente a partir de codigo
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select id_grupo_cliente from g_clientes where id_cliente=:id');
    ParambyName('id').AsInteger:=codigo;
    Open;

    if not(IsEmpty) then Result:=FieldByName('id_grupo_cliente').AsInteger
    else result:=-1;

    Free;
  end;
end;


function BuscaArticulo(id_articulo:integer; out codigo:string):string;
begin                                       //devuelve codigo y nombre de articulo a partir de id
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select codigo,nombre from g_articulos where id_articulo=:id');
    ParambyName('id').AsInteger:=id_articulo;
    Open;

    codigo := '';

    if not(IsEmpty) then
    begin
      Result:=FieldByName('nombre').AsString;
      codigo := FieldByName('codigo').AsString;
    end
    else result:='';

    Free;
  end;
end;

function BuscaArticuloXCod(codigo:string; out id_articulo:integer):string;
begin                                       //devuelve id de artículo a partir de codigo
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select id_articulo,nombre from g_articulos where codigo=:codigo');
    ParambyName('codigo').AsString := codigo;
    Open;

    id_articulo := -1;

    if not(IsEmpty) then
    begin
      Result:=FieldByName('nombre').AsString;
      id_articulo := FieldByName('id_articulo').AsInteger;
    end
    else result:='';

    Free;
  end;
end;

function CargarDatosAgencia(campos: string; cliente, agencia:Integer):string;
var
  str_dyn:TStringDynArray;
  i: integer;
begin

   Result := '';
   with tpfibdataset.Create(dm) do begin
    try
      database:=dm.db;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select ' + campos +
                         ' from g_agencias_clientes where id_cliente=:cliente and id_agencia=:agencia ');
      ParambyName('cliente').AsInteger := cliente;
      ParambyName('agencia').AsInteger := agencia;
      Open;

      if not(IsEmpty) then
      begin
        for i:=0 to fields.Count-1 do
        begin
          result := Result + fields[i].Text + '#';
        end;
      end;

      Result := Copy(Result,0,Length(result)-1);

    finally
        free;
    end;
   end;
end;

procedure BuscarUbicacionDeArticulo(id_articulo, id_almacen:integer; out ubi:Integer; out est, pos, alt, sub1, sub2:string; out id_lote:integer);
begin
   with tpfibdataset.Create(dm) do begin
    try
      database:=dm.db;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select u.id_ubicacion,u.id_estanteria,u.id_posicion,u.id_altura,u.id_sub1,u.id_sub2, s.id_lote ' +
                         ' from a_stock s ' +
                         '   inner join a_ubicaciones u on (s.id_ubicacion=u.id_ubicacion) ' +
                         ' where s.id_articulo=:id_articulo ' +
                         ' and s.cantidad>0 and u.id_zona=0 ' +
                         ' and s.id_ubicacion<>361 and s.id_empresa=1 and s.id_almacen=:id_almacen and s.id_departamento=0 ' +
                         ' order by 4,2,3');
      ParambyName('id_articulo').AsInteger := id_articulo;
      ParambyName('id_almacen').AsInteger := id_almacen;
      Open;

      if not(IsEmpty) then
      begin
        ubi := FieldByName('id_ubicacion').AsInteger; //id_ubic
        est := FieldByName('id_estanteria').asstring; //ubicacion
        pos := FieldByName('id_posicion').asstring;   //posicion
        alt := FieldByName('id_altura').asstring;     //altura
        sub1 := FieldByName('id_sub1').asstring;      //sub1
        sub2 := FieldByName('id_sub2').asstring;      //sub2
        id_lote := FieldByName('id_lote').AsInteger;  //id_lote
      end;
    finally
        free;
    end;
   end;
end;

function GetNombreAgencia(id_agencia:Integer):string;
begin
    result  := '';
    with TpFIBDataSet.Create(nil) do
    try
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select * from g_agencias where id_agencia=:id_agencia');
      ParamByName('id_agencia').AsInteger := id_agencia;
      Open;

      if not isempty then
          result := FieldByName('nombre').AsString;

      if ((Result='CHRONO') or (Result='CEX')) then
         Result := 'CORREOS EXPRESS';
    finally
      free;
    end;
end;

function Getusuario(id_usuario:Integer):string;
begin
    result  := '';
    with TpFIBDataSet.Create(nil) do
    try
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select * from g_usuarios where id_usuario=:id_usuario');
      ParamByName('id_usuario').AsInteger := id_usuario;
      Open;

      if not isempty then
          result := FieldByName('usuario').AsString;
    finally
      free;
    end;
end;

{$ENDREGION 'MASTER TABLES'}

function CargarDatosTabla(tabla,campos,criterios: string):string;
var
  i: integer;
begin

   Result := '';
   with TpFIBDataSet.Create(dm) do begin
    try
      database:=dm.db;
      SelectSQL.Clear;
      SelectSQL.Add('select ' + campos +
                         ' from ' + tabla);
      if criterios<>'' then
         SelectSQL.Add(' where ' + criterios);
      Open;

      if not(IsEmpty) then
      begin
        for i:=0 to fields.Count-1 do
        begin
          result := Result + fields[i].Text + '#';
        end;
      end;

      Result := Copy(Result,0,Length(result)-1);
    finally
        free;
    end;
   end;
end;

function UpdateDatosTabla(tabla,campos,criterios: string):string;
begin

   Result := 'ok';

   with tpFIBQuery.Create(dm) do begin
      dm.t_write.StartTransaction;
       try
         try
          database:=dm.db;
          Transaction := dm.t_write;
          sql.Clear;
          sql.add('update ' + tabla +
                             ' set '  + campos);
          if criterios<>'' then
             sql.Add(' where ' + criterios);

          ExecQuery;
         except on E:Exception do
                begin
                 result := e.Message;
                 dm.t_write.rollback;
                 raise;
                end;
         end;
       finally
          Free;
          dm.t_write.commit;
       end;
   end;
end;


function ArtsRelacionados(id_articulo:integer):string;
begin
   result := '';
    with dm.q_aux do
    try
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select id_art_relacionado from g_articulos_relaciones where id_articulo=:id_articulo and estado=''A''');
      ParamByName('id_articulo').AsInteger := id_articulo;
      Open;

      if not isempty then
      begin
        First;
        while not eof do
        begin
          result := result + FieldByName('id_art_relacionado').AsString + '#';
          Next;
        end;
      end;

      if result<>'' then
          result := Copy(result,0,Length(result)-1);
    finally
      //
    end;
end;

procedure GuardarRelacionArts(art1, art2:Integer);
begin

    with tpFIBQuery.Create(dm) do
    begin
      database:=dm.db;
      Transaction:=dm.t_write;
      sql.add('insert into g_articulos_relaciones(id_articulo, id_art_relacionado) ');
      sql.Add('values (:id_articulo,:id_art_relacionado)');
      ParamByName('id_articulo').AsInteger := art1;
      ParamByName('id_art_relacionado').AsInteger := art2;
      ExecQuery;
    end;
end;

function getRepartidorLgs(id_gestoras:Integer):integer;
begin                                       //devuelve id de agencia a partir del id de la agencia en gestoras
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select id_agencia from g_agencias where agencia_gestoras=:id_gestoras');
    ParambyName('id_gestoras').AsInteger:=id_gestoras;
    Open;

    if not(IsEmpty) then Result:=FieldByName('id_agencia').asinteger
    else result:=-1;

    Free;
  end;
end;

function getRelacionAgencia(id_agencia:Integer):integer;
begin                                       //devuelve id de agencia de gestoras a partir del id de la agencia en lgs
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select agencia_gestoras from g_agencias where id_agencia=:id');
    ParambyName('id').AsInteger:=id_agencia;
    Open;

    if not(IsEmpty) then Result:=FieldByName('agencia_gestoras').asinteger
    else result:=-1;

    Free;
  end;
end;

function GetIdLote(lote:string):Integer;
begin                                       //devuelve id de lote
  with tpfibdataset.Create(dm) do
    try
        Database:=dm.db;
        SQLs.SelectSQL.Clear;
        sqls.SelectSQL.Add('select id_lote from a_lotes where nombre=:lote');
        ParambyName('lote').AsString:=lote;
        Open;

        if not(IsEmpty) then Result:=FieldByName('id_lote').asinteger
        else result:=-1;

        Free;
    finally

    end;
end;

function GetUbiPick(id_pick,id_art:integer):string;
begin                                       //devuelve descripcion de ubicación de un articulo en un picking
  with tpfibdataset.Create(dm) do
    try
        Database:=dm.db;
        SQLs.SelectSQL.Clear;
        sqls.SelectSQL.Add('select u.* from a_ubicaciones u ' +
                           'inner join a_picklin p on p.id_ubicacion=u.id_ubicacion ' +
                           'where p.id_pickcab=:id_pick and p.id_articulo=:id_art');
        ParambyName('id_pick').AsInteger:=id_pick;
        ParambyName('id_art').AsInteger:=id_art;
        Open;

        if not(IsEmpty) then
            Result := FieldByName('id_estanteria').AsString + '-' +
                      FieldByName('id_posicion').AsString + '-' +
                      FieldByName('id_altura').AsString + '-' +
                      FieldByName('id_sub1').AsString
        else result:='';

        Free;
    finally

    end;
end;


end.


