unit u_functions;

interface

uses
    Winapi.Windows, Winapi.ShellAPI, pFIBDataSet, System.SysUtils, Data.Win.ADODB, Classes, Winapi.WinSock,
    pFIBQuery;

type
  TIntArray = array of Integer;

  function GetFileConfig(cliente:integer):TIntArray;
  function GetRepartidorLgs(albaran:Integer):Integer;
  function GetIdAgenciaXRepartidor(repartidor:string):Integer;
  function GetAgenciaXId(id:integer):string;
  function GetProvinciaNombre(cp:string):string;
  function UdsEnPickingPte(id_articulo:integer):integer;
  function GetConexion(nombre:string):string;
  function CargarDatosTabla(tabla,campos,criterios: string):string;
  function GetNombreAlmacen(id:integer):string;
  function GetIdPedidoXAlbaran(codalbaran, id_cliente:integer):integer;
  function suma_cantidad_art_en_pedido(id_pedido,id_articulo: integer):integer;
  function GetImeiPedido(id_pedido,id_articulo:Integer):string;
  function GetAlbaranPedido(id_pedido:Integer):integer;
  function GetTagPedido(id_pedido:Integer):string;
  function GetPaisCodePedido(id_pedido:Integer):string;
  function EsDevo(id_pedido:Integer):boolean;
  function suma_cantidad_art_en_gestoras(id_albaran,id_articulo: integer):integer;
  function ListaArchivos(directorioPadre: string) : TStringList;
  function LocalIP : string;
  function ComputerName():String;
  function GetPaisGestoras(pais:string):string;
  function GetExtraPedido(id_pedido:Integer; extra:string):string;
  //function GetFormatoEtiqueta(id_albaran:Integer):string;
  function GetStock(id_articulo:Integer):Integer;
  procedure InsertaLog(id_usuario,id,tipo:Integer; pc_name,ip,tabla,campo_id,qry,datos,datos_extra:string);
  procedure print_doc(doc:string);
  function art_tiene_n_serie(id_articulo:Integer):Boolean;
  procedure inserta_pedido_lines_extra(id_pedido,id_line:Integer; extra,valor:string);
  procedure elimina_pedido_lines_extra(id_pedido,id_line:Integer; extra,valor:string; usu: Integer; ip,pc_nom,app:string);
  function existe_n_serie(n_serie:string):Boolean;
  function GetPedLineExtra(id_pedido, id_line:Integer;extra:string):string;
  function GetCreationFileDate(FileName: String): TDateTime;
  function ArticuloBloqueado(id_articulo:Integer):Boolean;
  function UpdateArtBloqueado(id_articulo,locked:Integer):integer;
  procedure inserta_pedido_extra(id_pedido:Integer; extra,valor:string);
  function PedidoFaltaNSerie(id_pedido:Integer):Boolean;
  function get_art_x_bc(bc:string; id_cliente:integer):integer;
  function existe_art_en_pedido(id_pedido, id_articulo:integer):Boolean;
  function get_query(id:integer):string;
  function GetAlbaranDestPedido(id_pedido:integer):integer;
  function cuenta_lineas_pedido(id_pedido:integer):integer;
  function articulo_con_IMEI(id_articulo: Integer): Boolean;
  function tiene_etiquetas(pedido: integer): Boolean;
  procedure InsertaLote(pedido, art, lote, cantidad, id_pick, l_pick: Integer);
  procedure ActualizaPackLote(id_pickcab, linea, codalbaran, id_articulo, cantidad, id_lote: Integer);
  function EncuentraPackLote(id_pickcab, linea, codalbaran, id_articulo, cantidad, id_lote: Integer): Boolean;
  function CopiaLoteDePicking(id_pedido,codalbaran,id_articulo,id_art_padre:integer):string;
  function GetFechaPedido(id_pedido:Integer):TDateTime;
  function cuenta_lineas_con_n_serie(id_pedido:integer):integer;
  function cuenta_lineas_con_n_serie_pistoleado(id_pedido:integer):integer;
  function cuenta_lineas_con_n_serie_x_art(id_pedido,id_articulo:integer):integer;
  function cuenta_lineas_con_n_serie_pistoleado_x_art(id_pedido,id_articulo:integer):integer;
  function get_nserie_lines_x_art(id_pedido,id_articulo:Integer):TStringList;
  function get_codcli_art(id_art:Integer):string;
  function GetFileTimes(FileName, tipo : string; var Fecha: TDateTime) : boolean;
  procedure GetServHoraPedido(id_pedido: Integer; out serv,hora, ret:Integer);
  function busca_art(cod_cli: string; id_cliente: integer): integer;
  function UpdateStockArt(id_articulo,uds:Integer):integer;
  function obtenerUsuarioRed : Ansistring;
  function n_serie_en_otro_pedido(id_cliente,id_pedido:Integer; n_serie:string):string;
  function dar_baja_articulo(id_articulo:Integer;fecha:TDateTime):integer;
  function art_en_ped_pte(id_articulo, id_almacen:integer):boolean;
  function art_en_pick_pte(id_articulo, id_almacen:integer):boolean;
  function get_ubics_art(id_articulo:Integer;ignora_0:Boolean):string;
  function calcula_agencia_gestoras(id_cliente:Integer;pais,provincia,cp:string;peso:double):Integer;
  function get_item_config_cliente(id_cliente:Integer;item:string):string;

implementation

uses
  u_dm;

{ Tabla: C_PEDIDOS_FILE_CONFIG
  Campo->Posición en array:
  ID_PEDIDO_CONFIG
  ID_CLIENTE
  DESCRIPCION
  CODIGO_CLIENTE -> 0
  CLIENTE_DELEG -> 1
  CODIGO_ALBARAN -> 2
  FECHA -> 3
  REFERENCIA_ARTICULO -> 4
  DESTINO_DELEGACION -> 5
  DESTINO_NOMBRE -> 6
  DESTINO_DIRECCION -> 7
  DESTINO_LOCALIDAD -> 8
  DESTINO_CP -> 9
  DESTINO_PROVINCIA -> 10
  DESTINO_TELEFONO -> 11
  DESTINO_EMAIL -> 12
  DESTINO_CONTACTO -> 13
  OBSERVACIONES -> 14
  PAIS -> 15
  UNIDADES -> 16
  DELIVERY_TIME -> 17
  REEMBOLSO -> 18
  PORTES_DEBIDOS -> 19
  PEDIDO -> 20
}
function GetFileConfig(cliente:integer):TIntArray;
var
  i:Integer;
begin
    with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select f.* ' +
                       'from c_pedidos_file_config f ' +
                       //'inner join g_clientes_config cl on cl.id_cliente=f.id_cliente ' +
                       //'where f.id_cliente=:id and f.id_pedido_config=cl.id_file_config ');
                       'where ((f.id_cliente=:id) or (f.id_cliente=-1)) order by f.id_cliente desc');
    ParambyName('id').AsInteger := cliente;
    Open;

    if not(IsEmpty) then
    begin
         first;
         SetLength(result, fields.Count-3);

         for I := 0 to fields.Count-4 do
            Result[i] := FieldByFieldNo(i+4).Value;
    end;

    Free;
  end;
end;

function get_item_config_cliente(id_cliente:integer; item:string):string;
var
  i:Integer;
begin
    with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select fist 1 valor ' +
                       'from g_clientes_config_ c ' +
                       'where ((c.id_cliente=:id) or (c.id_cliente=-1000)) ' +
                       'and c.item=:item ' +
                       'order by c.id_cliente desc');
    ParambyName('id').AsInteger := id_cliente;
    ParambyName('item').AsString := item;
    Open;

    if not(IsEmpty) then
    begin
         first;
         Result := FieldByName('valor').AsString;
    end;

    Free;
  end;
end;

function GetRepartidorLgs(albaran:Integer):Integer;
begin
   { dm.q_sql2.Close;
    dm.q_sql2.SQL.Clear;
    dm.q_sql2.SQL.Add('select codrepartidor from albaranes where codalbaran=:codalbaran');
    dm.q_sql2.parameters.parambyname('codalbaran').value:=albaran;
    dm.q_sql2.Open;

    if not (dm.q_sql2.FieldByName('codrepartidor').AsString='') then
    begin
      result := dm.q_sql2.FieldByName('codrepartidor').AsInteger;
    end else
          Result := 0;  }
end;

function GetIdAgenciaXRepartidor(repartidor:string):integer;
begin
    with TpFIBDataSet.Create(dm) do
    begin
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select id_agencia from g_agencias where repartidor like ' + QuotedStr('%' + repartidor + '%'));
      //ParamByName('repartidor').AsInteger := repartidor;
      Open;
      First;

      if not (FieldByName('id_agencia').AsString='') then
      begin
        result := FieldByName('id_agencia').AsInteger;
      end else
            Result := 1; //Si no se ha encontrado repartidor, será Loginser por defecto (id=1 en g_agencias)

     free;
    end;
end;

function GetAgenciaXId(id:integer):string;
begin
    with TpFIBDataSet.Create(dm) do
    begin
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select nombre from g_agencias where id_agencia=:id');
      ParamByName('id').AsInteger := id;
      Open;
      First;

      if not (FieldByName('nombre').AsString='') then
      begin
        result := FieldByName('nombre').asstring;
      end else
            Result := '';

     free;
    end;
end;

function GetProvinciaNombre(cp:string):string;
begin
    with TpFIBDataSet.Create(dm) do
    begin
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select nombre from g_provincias where codigo =' + QuotedStr(cp));
      //ParamByName('repartidor').AsInteger := repartidor;
      Open;
      First;

      if not (FieldByName('nombre').AsString='') then
      begin
        result := FieldByName('nombre').AsString;
      end else
            Result := '';
     free;
    end;
end;

function UdsEnPickingPte(id_articulo:integer):integer;
begin                                       //devuelve total
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select sum(cantidad) as total ' +
                       'from a_picklin ' +
                       'where id_articulo=:id_articulo '+
                       '      and estado=:estado');
    ParambyName('id_articulo').AsInteger:=id_articulo;
    ParambyName('estado').AsString:='P';
    Open;

    if not(IsEmpty) then Result:=FieldByName('total').asinteger
    else result:=0;

    Free;
  end;
end;

function GetConexion(nombre:string):string;
begin
    with TpFIBDataSet.Create(dm) do
    begin
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select * from sys_conexiones where nombre=:nombre and activa=1');
      ParamByName('nombre').AsString := UpperCase(nombre);
      Open;
      First;

      if not (FieldByName('basedatos').AsString='') then
      begin
        result := FieldByName('basedatos').AsString;
      end else
            Result :=  '';
     free;
    end;
end;


function CargarDatosTabla(tabla,campos,criterios: string):string;
var
  i: integer;
begin

   Result := '';
   with tpfibdataset.Create(dm) do begin
      database:=dm.db;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select ' + campos +
                         ' from ' + tabla);
      if criterios<>'' then
         SQLs.SelectSQL.Add(' where ' + criterios);
      Open;

      if not(IsEmpty) then
      begin
        for i:=0 to fields.Count-1 do
        begin
          result := Result + fields[i].Text + '#';
        end;
      end;

      Result := Copy(Result,0,Length(result)-1);
      free;
   end;
end;

function GetNombreAlmacen(id:integer):string;
begin
    with TpFIBDataSet.Create(dm) do
    begin
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select nombre from a_almacenes where id_almacen=:id');
      ParamByName('id').AsInteger := id;
      Open;
      First;

      if not (FieldByName('nombre').AsString='') then
      begin
        result := FieldByName('nombre').asstring;
      end else
            Result := '';

     free;
    end;
end;


function GetIdPedidoXAlbaran(codalbaran,id_cliente:integer):integer;
begin
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select id_pedido ' +
                       'from c_pedidos ' +
                       'where codalbaran=:albaran '+
                       '      and id_cliente=:id_cliente');
    ParambyName('albaran').AsInteger    := codalbaran;
    ParambyName('id_cliente').AsInteger := id_cliente;
    Open;

    if not(IsEmpty) then Result:=FieldByName('id_pedido').asinteger
    else result:=0;

    Free;
  end;
end;

function suma_cantidad_art_en_pedido(id_pedido,id_articulo: integer):integer;
begin
    result  := -1;
    with TpFIBDataSet.Create(nil) do
    try
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select sum(cantidad) as uds from c_pedidos_lines_lotes ' +
                         ' where id_pedido=:id_pedido and id_articulo=:id_articulo');
      ParamByName('id_pedido').AsInteger := id_pedido;
      ParamByName('id_articulo').AsInteger := id_articulo;
      Open;

      if not isempty then
          result := FieldByName('uds').asinteger;

    finally
      free;
    end;
end;

function suma_cantidad_art_en_gestoras(id_albaran,id_articulo: integer):integer;
begin
    result  := -1;
    with TpFIBDataSet.Create(nil) do
    try
      Database:=dm.db_gestoras;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select sum(unidades) as uds from albaran_articulos ' +
                         ' where id_albaran=:id_albaran and id_articulo=:id_articulo');
      ParamByName('id_albaran').AsInteger := id_albaran;
      ParamByName('id_articulo').AsInteger := id_articulo;
      Open;

      if not isempty then
          result := FieldByName('uds').asinteger;

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

function GetAlbaranPedido(id_pedido:integer):integer;
begin

  result := -1;
  with tpfibdataset.create(dm) do
  try
    database:=dm.db;
    close;
    sqls.SelectSQL.Clear;
    sqls.selectsql.Add('select codalbaran from c_pedidos where id_pedido=:id_pedido');
    ParamByName('id_pedido').AsInteger := id_pedido;
    open;

    if not(isempty) then begin
      result := fieldbyname('codalbaran').asinteger;
    end;

  finally
    free;
  end;
end;

function GetAlbaranDestPedido(id_pedido:integer):integer;
begin

  result := -1;
  with tpfibdataset.create(dm) do
  try
    database:=dm.db;
    close;
    sqls.SelectSQL.Clear;
    sqls.selectsql.Add('select gestoras_dest from c_pedidos where id_pedido=:id_pedido');
    ParamByName('id_pedido').AsInteger := id_pedido;
    open;

    if not(isempty) then begin
      result := fieldbyname('gestoras_dest').asinteger;
    end;

  finally
    free;
  end;
end;

function cuenta_lineas_pedido(id_pedido:integer):integer;
begin

  result := -1;
  with tpfibdataset.create(dm) do
  try
    database:=dm.db;
    close;
    sqls.SelectSQL.Clear;
    sqls.selectsql.Add('select count(*) as cuenta from c_pedidos_lines where id_pedido=:id_pedido');
    ParamByName('id_pedido').AsInteger := id_pedido;
    open;

    if not(isempty) then begin
      result := fieldbyname('cuenta').asinteger;
    end;

  finally
    free;
  end;
end;

function GetTagPedido(id_pedido:integer):string;
begin

  result := '';
  with tpfibdataset.create(dm) do
  try
    database:=dm.db;
    close;
    sqls.SelectSQL.Clear;
    sqls.selectsql.Add('select tags from c_pedidos where id_pedido=:id_pedido');
    ParamByName('id_pedido').AsInteger := id_pedido;
    open;

    if not(isempty) then begin
      result := fieldbyname('tags').asstring;
    end;

  finally
    free;
  end;
end;

function GetPaisCodePedido(id_pedido:integer):string;
begin

  result := '';
  with tpfibdataset.create(dm) do
  try
    database:=dm.db;
    close;
    sqls.SelectSQL.Clear;
    sqls.selectsql.Add('select Upper(trim(pais_code)) as pais_code from c_pedidos where id_pedido=:id_pedido');
    ParamByName('id_pedido').AsInteger := id_pedido;
    open;

    if not(isempty) then begin
      result := fieldbyname('pais_code').asstring;
    end;

  finally
    free;
  end;
end;

function GetFechaPedido(id_pedido:integer):TDateTime;
begin

  with tpfibdataset.create(dm) do
  try
    database:=dm.db;
    close;
    sqls.SelectSQL.Clear;
    sqls.selectsql.Add('select fecha_ped from c_pedidos where id_pedido=:id_pedido');
    ParamByName('id_pedido').AsInteger := id_pedido;
    open;

    if not(isempty) then begin
      result := fieldbyname('fecha_ped').AsDateTime;
    end;

  finally
    free;
  end;
end;

function EsDevo(id_pedido:integer):boolean;
begin

  result := false;
  with tpfibdataset.create(dm) do
  try
    database:=dm.db;
    close;
    sqls.SelectSQL.Clear;
    sqls.selectsql.Add('select es_devo from c_pedidos where id_pedido=:id_pedido');
    ParamByName('id_pedido').AsInteger := id_pedido;
    open;

    if not(isempty) then begin
      result := (fieldbyname('es_devo').asinteger = 1);
    end;

  finally
    free;
  end;
end;

function GetPaisGestoras(pais:string):string;
begin

  result := '';
  with tpfibdataset.create(dm) do
  try
    database:=dm.db;
    close;
    sqls.SelectSQL.Clear;
    sqls.selectsql.Add('select codigo_pais from get_pais_gestoras(:pais)');
    ParamByName('pais').AsString := pais;
    open;

    if not(isempty) then begin
      result := fieldbyname('codigo_pais').asstring;
    end;

  finally
    free;
  end;
end;


function GetExtraPedido(id_pedido:integer; extra:string):string;
begin

  result := '';
  with tpfibdataset.create(dm) do
  try
    database:=dm.db;
    close;
    sqls.SelectSQL.Clear;
    sqls.selectsql.Add('select valor from c_pedidos_extras where id_pedido=:id_pedido and upper(descripcion)=upper(:extra)');
    ParamByName('id_pedido').AsInteger := id_pedido;
    ParamByName('extra').AsString := extra;
    open;

    if not(isempty) then begin
      result := fieldbyname('valor').asstring;
    end;

  finally
    Free;
  end;
end;


function ListaArchivos(directorioPadre: string) : TStringList;
  var
    sr: TSearchRec;
  begin
    Result := TStringList.Create;
    if FindFirst(directorioPadre + '*', faAnyFile, sr) = 0 then
      repeat
        if (sr.Attr and faDirectory = 0) or (sr.Name <> '.')
          and (sr.Name <> '..') then
            Result.Add(sr.Name);
      until FindNext(sr) <> 0;
    FindClose(sr);
  end;


function LocalIP : string;
type
  TaPInAddr = array [0..10] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  phe : PHostEnt;
  pptr : PaPInAddr;
  Buffer : array [0..63] of ansichar;
  I : Integer;
  GInitData : TWSADATA;
begin
  WSAStartup($101, GInitData);
  Result := '';
  GetHostName(Buffer, SizeOf(Buffer));
  phe := GetHostByName(buffer);
  if phe = nil then Exit;
    pptr := PaPInAddr(Phe^.h_addr_list);
  I := 0;
  while pptr^[I] <> nil do
  begin
    result:=StrPas(inet_ntoa(pptr^[I]^));
    Inc(I);
  end;
  WSACleanup;
end;

function ComputerName():String;
var
  ComputerName: Array [0 .. 256] of ansichar;
begin
  GetHostName(ComputerName, SizeOf(ComputerName));
  Result := ComputerName;
end;

{
function GetFormatoEtiqueta(id_albaran:Integer):string;
begin
    with TpFIBDataSet.Create(nil) do
    try
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select formato from calcula_formato_etiqueta(:id_albaran) ');
      ParamByName('id_albaran').AsInteger := id_albaran;
      Open;

      if not isempty then
          result := FieldByName('formato').asstring;

    finally
      free;
    end;
end;     }

procedure InsertaLog(id_usuario,id,tipo:Integer; pc_name,ip,tabla,campo_id,qry,datos,datos_extra:string);
begin
   with tpFIBQuery.Create(dm) do
   try
      Close;
      database := dm.db;
      transaction := dm.t_write;
      sql.Clear;
      sql.Add('insert into s_log (id_usuario, pc_name, ip, datos, tabla, campo_id, id, tipo, datos_extra,sql) ' +
              'values (:id_usuario, :pc_name, :ip, :datos, :tabla, :campo_id, :id, :tipo, :datos_extra, :sql)');
      ParamByName('id_usuario').AsInteger := id_usuario;
      ParamByName('pc_name').AsString := pc_name;
      ParamByName('ip').AsString := ip;
      ParamByName('datos').AsString := datos;
      ParamByName('tabla').AsString := tabla;
      ParamByName('campo_id').AsString := campo_id;
      ParamByName('id').AsInteger := id;
      ParamByName('tipo').asinteger := tipo;
      ParamByName('datos_extra').AsString := datos_extra;
      ParamByName('sql').AsString := qry;

      dm.t_write.StartTransaction;
      ExecQuery;
      dm.t_write.Commit;
   finally
      Free;
   end;
end;


function GetStock(id_articulo:Integer):integer;
begin
  with TpFIBDataSet.Create(dm) do
  try
    Database := dm.db;
    sqls.SelectSQL.Add('select stock from get_stock(:id_articulo) ');
    parambyname('id_articulo').AsInteger := id_articulo;
    Open;

    Result := FieldByName('stock').AsInteger;

  finally
    free;
  end;

end;

procedure print_doc(doc:string);
begin
 // ShellExecute(Handle, 'Print', PChar(doc), nil,  nil, SW_HIDE);
end;

function art_tiene_n_serie(id_articulo:integer):Boolean;
begin
    with TpFIBDataSet.Create(dm) do
    begin
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select tiene_n_serie from g_articulos where id_articulo=:id_art ');
      ParamByName('id_art').AsInteger := id_articulo;
      Open;

     result := (FieldByName('tiene_n_serie').AsInteger=1);

     free;
    end;
end;

function cuenta_lineas_con_n_serie(id_pedido:integer):integer;
begin
    with TpFIBDataSet.Create(dm) do
    begin
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select count(*) as cuenta from c_pedidos_lines l  inner join g_articulos ar on ar.id_articulo=l.id_articulo ' +
                         'where l.id_pedido=:id_pedido and ar.tiene_n_serie=1 ');
      ParamByName('id_pedido').AsInteger := id_pedido;
      Open;

     result := FieldByName('cuenta').AsInteger;

     free;
    end;
end;

function cuenta_lineas_con_n_serie_x_art(id_pedido,id_articulo:integer):integer;
begin
    with TpFIBDataSet.Create(dm) do
    begin
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select count(*) as cuenta from c_pedidos_lines l  inner join g_articulos ar on ar.id_articulo=l.id_articulo ' +
                         'where l.id_pedido=:id_pedido and l.id_articulo=:id_articulo and ar.tiene_n_serie=1 ');
      ParamByName('id_pedido').AsInteger := id_pedido;
      ParamByName('id_articulo').AsInteger := id_articulo;
      Open;

     result := FieldByName('cuenta').AsInteger;

     free;
    end;
end;

function cuenta_lineas_con_n_serie_pistoleado(id_pedido:integer):integer;
begin
    with TpFIBDataSet.Create(dm) do
    begin
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select count(*) as cuenta from c_pedidos_lines l inner join g_articulos ar on ar.id_articulo=l.id_articulo ' +
                         'where l.id_pedido=:id_pedido and ar.tiene_n_serie=1 and l.n_serie<>''''');
      ParamByName('id_pedido').AsInteger := id_pedido;
      Open;

     result := FieldByName('cuenta').AsInteger;

     free;
    end;
end;

function cuenta_lineas_con_n_serie_pistoleado_x_art(id_pedido, id_articulo:integer):integer;
begin
    with TpFIBDataSet.Create(dm) do
    begin
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select count(*) as cuenta from c_pedidos_lines l inner join g_articulos ar on ar.id_articulo=l.id_articulo ' +
                         'where l.id_pedido=:id_pedido and l.id_articulo=:id_articulo and ar.tiene_n_serie=1 and l.n_serie<>''''');
      ParamByName('id_pedido').AsInteger := id_pedido;
      ParamByName('id_articulo').AsInteger := id_articulo;
      Open;

     result := FieldByName('cuenta').AsInteger;

     free;
    end;
end;

function get_nserie_lines_x_art(id_pedido,id_articulo:Integer):TStringList;
var
  lista:TStringList;
begin
   lista := TStringList.Create;
   with TpFIBDataSet.Create(dm) do
    begin
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select n_serie from c_pedidos_lines l inner join g_articulos ar on ar.id_articulo=l.id_articulo ' +
                         'where l.id_pedido=:id_pedido and l.id_articulo=:id_articulo and ar.tiene_n_serie=1 and l.n_serie<>''''');
      ParamByName('id_pedido').AsInteger := id_pedido;
      ParamByName('id_articulo').AsInteger := id_articulo;
      Open;
      if not IsEmpty then
      begin
        First;
        while not Eof do
        begin
          lista.Add(fieldbyname('n_serie').Asstring);
          Next;
        end;
      end;

     result := lista;

     Free;
    end;

   lista.free;
end;

procedure inserta_pedido_extra(id_pedido:Integer; extra,valor:string);
begin
   with tpFIBQuery.Create(dm) do
   try
      Close;
      database := dm.db;
      transaction := dm.t_write;
      sql.Clear;
      sql.Add('insert into c_pedidos_extras (id_pedido, descripcion, valor) ' +
              'values (:id_pedido, :extra, :valor)');
      ParamByName('id_pedido').AsInteger := id_pedido;
      ParamByName('extra').AsString := extra;
      ParamByName('valor').AsString := valor;

      dm.t_write.StartTransaction;
      try
       ExecQuery;
       dm.t_write.Commit;
      except
       dm.t_write.Rollback;
      end;

   finally
      Free;
   end;
end;

procedure inserta_pedido_lines_extra(id_pedido,id_line:Integer; extra,valor:string);
begin
   with tpFIBQuery.Create(dm) do
   try
      Close;
      database := dm.db;
      transaction := dm.t_write;
      sql.Clear;
      sql.Add('insert into c_pedidos_lines_extras (id_pedido, line, extra, valor) ' +
              'values (:id_pedido, :line, :extra, :valor)');
      ParamByName('id_pedido').AsInteger := id_pedido;
      ParamByName('line').AsInteger := id_line;
      ParamByName('extra').AsString := extra;
      ParamByName('valor').AsString := valor;

      dm.t_write.StartTransaction;
      try
       ExecQuery;
       dm.t_write.Commit;
      except
       dm.t_write.Rollback;
      end;

   finally
      Free;
   end;
end;

procedure elimina_pedido_lines_extra(id_pedido,id_line:Integer; extra,valor:string; usu: Integer; ip,pc_nom,app:string);
begin
   with tpFIBQuery.Create(dm) do
   try
      Close;
      database := dm.db;
      transaction := dm.t_write;
      sql.Clear;
      sql.Add('delete from c_pedidos_lines_extras where ' +
              ' id_pedido=:id_pedido and line=:id_line and extra=:extra and valor=:valor');
      ParamByName('id_pedido').AsInteger := id_pedido;
      ParamByName('id_line').AsInteger := id_line;
      ParamByName('extra').AsString := extra;
      ParamByName('valor').AsString := valor;

      dm.t_write.StartTransaction;
      try
       ExecQuery;
       dm.t_write.Commit;
       InsertaLog(usu,id_pedido,0,pc_nom,ip,app,'pedido','',
                  'delete c_pedidos_lines_extras','L.' + IntToStr(id_line) + ' Extra=' + extra + ' Valor=' + valor);
      except
       dm.t_write.Rollback;
      end;

   finally
      Free;
   end;
end;

function existe_n_serie(n_serie:string):Boolean;
begin
    with TpFIBDataSet.Create(dm) do
    begin
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select * from c_pedidos_lines_extras where Upper(extra)=''N_SERIE'' and valor=:n_serie ');
      ParamByName('n_serie').AsString := n_serie;
      Open;

     result := not IsEmpty;

     free;
    end;
end;

function GetPedLineExtra(id_pedido, id_line:Integer;extra:string):string;
begin
    with TpFIBDataSet.Create(dm) do
    begin
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select * from c_pedidos_lines_extras where id_pedido=:id_pedido and line=:id_line and Upper(extra)=Upper(:extra) ');
      ParamByName('id_pedido').AsInteger := id_pedido;
      ParamByName('id_line').AsInteger := id_line;
      ParamByName('extra').AsString := extra;
      Open;

     result := FieldByName('valor').AsString;

     free;
    end;
end;

function GetCreationFileDate(FileName: String): TDateTime;
var
   FileData:   WIN32_FILE_ATTRIBUTE_DATA;
   SystemTime: TSYSTEMTIME;
   created: TDateTime;
begin
   GetFileAttributesEx(PCHAR(FileName), GetFileExInfoStandard, @FileData);
   FileTimeToSystemTime(FileData.ftLastWriteTime, SystemTime);
   created := EncodeDate(SystemTime.wYear, SystemTime.wMonth, SystemTime.wDay);

   created := created + EncodeTime(SystemTime.wHour+2, SystemTime.wMinute, SystemTime.wSecond, SystemTime.wMilliseconds);
   result := created;
end;


function ArticuloBloqueado(id_articulo:Integer):Boolean;
begin
  with TpFIBDataSet.Create(dm) do
  try
    Database := dm.db;
    sqls.SelectSQL.Add('select locked from g_articulos where id_articulo=:id_articulo');
    parambyname('id_articulo').AsInteger := id_articulo;
    Open;

    Result := (FieldByName('locked').AsInteger=1);

  finally
    free;
  end;

end;

function UpdateArtBloqueado(id_articulo,locked:Integer):integer;
begin
   with tpFIBQuery.Create(dm) do
   try
      Close;
      database := dm.db;
      transaction := dm.t_write;
      sql.Clear;
      sql.Add('update g_articulos set locked=:locked where id_articulo=:id_articulo');
      ParamByName('id_articulo').AsInteger := id_articulo;
      ParamByName('locked').AsInteger := locked;

      dm.t_write.StartTransaction;
      try
       ExecQuery;
       dm.t_write.Commit;
       Result := 1;
       InsertaLog(100,0,0,'','','g_articulos','locked',
                  'update g_articulos set locked='+ IntToStr(locked)+' where id_articulo='+IntToStr(id_articulo),
                  'Bloqueo de artículo','');
      except
       dm.t_write.Rollback;
       Result := -1;
      end;

   finally
      Free;
   end;

end;

function PedidoFaltaNSerie(id_pedido:Integer):Boolean;
begin
  with TpFIBDataSet.Create(dm) do
  try
    Database := dm.db;
    SQLs.SelectSQL.Clear;
    sqls.SelectSQL.Add('select * from c_pedidos_lines l ' +
                       'inner join g_articulos ar on ar.id_articulo=l.id_articulo ' +
                       'where id_pedido=:id_pedido and ar.tiene_n_serie=1 and ((l.n_serie='''') or (l.n_serie is null))');
    parambyname('id_pedido').AsInteger := id_pedido;
    Open;

    Result := not isempty;

  finally
    free;
  end;

end;

function get_art_x_bc(bc:string;id_cliente:integer):integer;
begin
  with tpfibdataset.create(dm) do begin                  //Buscar EAN
    Database:=dm.db;
    SQLs.SelectSQL.Clear;

    //Paso 1. Ver si esta el ean en mas de un articulo
    sqls.SelectSQL.Add('select b.bc, count(*) as cuenta '+
          'from g_articulos_bc b '+
          'inner join g_articulos a on (b.id_articulo=a.id_articulo) '+
          'where b.bc=:bc and a.id_cliente=:id_cliente and b.estado=''A'' ' +
          'group by 1');
    ParamByName('bc').AsString:=bc;
    ParamByName('id_cliente').AsInteger := id_cliente;
    Open;

    if isempty then
       Result := -1
    else if FieldByName('cuenta').AsInteger>1 then
        Result := -2
         else begin
            Close;
            SQLs.SelectSQL.Clear;

            //Paso 2. Ver si este el ean en mas de un articulo
            sqls.SelectSQL.Add('select b.id_articulo '+
                  'from g_articulos_bc b '+
                  'inner join g_articulos a on (b.id_articulo=a.id_articulo) '+
                  'where b.bc=:bc and a.id_cliente=:id_cliente and b.estado=''A'' ' +
                  'group by 1');
            ParamByName('bc').AsString:=bc;
            ParamByName('id_cliente').AsInteger := id_cliente;
            Open;

            Result := FieldByName('id_articulo').AsInteger;
         end;

    Free;
  end;
end;

function existe_art_en_pedido(id_pedido,id_articulo:integer):Boolean;
begin
    with TpFIBDataSet.Create(dm) do
    begin
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select * from c_pedidos_lines where id_pedido=:id_pedido and id_articulo=:id_articulo ');
      ParamByName('id_pedido').AsInteger := id_pedido;
      ParamByName('id_articulo').AsInteger := id_articulo;
      Open;

     result := not IsEmpty;

     free;
    end;
end;

function get_query(id:integer):string;
begin
    with TpFIBDataSet.Create(dm) do
    begin
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select query from g_queries where id=:id');
      ParamByName('id').AsInteger := id;
      Open;
      First;

      if not (FieldByName('query').AsString='') then
      begin
        result := FieldByName('query').asstring;
      end else
            Result := '';

     free;
    end;
end;

function articulo_con_IMEI(id_articulo:Integer):Boolean;
begin
  with TpFIBDataSet.Create(dm) do
  try
    Database := dm.db;
    sqls.SelectSQL.Add('select tiene_imei from g_articulos where id_articulo=:id_articulo');
    parambyname('id_articulo').AsInteger := id_articulo;
    Open;

    Result := (FieldByName('tiene_imei').AsInteger=1);

  finally
    free;
  end;

end;

function tiene_etiquetas(pedido: integer): Boolean;
begin
  Result := False;

  with TpFIBDataSet.Create(dm) do
  try
    Database := dm.db;
    SQLs.SelectSQL.Clear;
    sqls.SelectSQL.Add('select * from c_pedidos_etiquetas where id_pedido=:pedido and estado=''A'' ');
    ParamByName('pedido').AsInteger := pedido;
    Open;

    Result := (RecordCount > 0);
  finally
    free;
  end;
end;

{procedure InsertaLote(pedido, art, lote, cantidad, id_pick, l_pick: Integer);
begin
  dm.q_1.Close;
  dm.q_1.sql.Clear;
  dm.q_1.sql.Add('insert into c_pedidos_lines_lotes (id_pedido, id_articulo, id_lote, cantidad, id_picking, linea_pick) ' + 'values (:id_pedido, :id_articulo, :id_lote, :cantidad, :id_picking, :linea)');
  dm.q_1.ParamByName('id_pedido').AsInteger := pedido;
  dm.q_1.ParamByName('id_articulo').AsInteger := art;
  dm.q_1.ParamByName('id_lote').asinteger := lote;
  dm.q_1.ParamByName('cantidad').asinteger := cantidad;
  dm.q_1.ParamByName('id_picking').asinteger := id_pick;
  dm.q_1.ParamByName('linea').asinteger := l_pick;

  dm.q_1.ExecQuery;
end; }

procedure InsertaLote(pedido, art, lote, cantidad, id_pick, l_pick: Integer);
begin

  with tpFIBQuery.Create(dm) do
  begin
    Close;
    Database := dm.db;
    Transaction := dm.t_write;
    sql.Clear;
    sql.Add('insert into c_pedidos_lines_lotes (id_pedido, id_articulo, id_lote, cantidad, id_picking, linea_pick) ' + 'values (:id_pedido, :id_articulo, :id_lote, :cantidad, :id_picking, :linea)');
    ParamByName('id_pedido').AsInteger := pedido;
    ParamByName('id_articulo').AsInteger := art;
    ParamByName('id_lote').asinteger := lote;
    ParamByName('cantidad').asinteger := cantidad;
    ParamByName('id_picking').asinteger := id_pick;
    ParamByName('linea').asinteger := l_pick;

    ExecQuery;
  end;
end;

{
procedure ActualizaPackLote(id_pickcab, linea, codalbaran, id_articulo, cantidad, id_lote: Integer);
begin
  dm.q_1.Close;
  dm.q_1.sql.Clear;
  dm.q_1.sql.Add('update a_packlin ' +
                  'set id_lote=:id_lote ' +
                  'where id_packcab=:id_packcab and ' +
                  'linea=:linea and codalbaran=:codalbaran and ' +
                  'id_articulo=:id_articulo and cantidad=:cantidad and id_lote<>:id_lote');
  dm.q_1.ParamByName('id_packcab').AsInteger := id_pickcab;
  dm.q_1.ParamByName('linea').AsInteger := linea;
  dm.q_1.ParamByName('codalbaran').AsInteger := codalbaran;
  dm.q_1.ParamByName('id_articulo').AsInteger := id_articulo;
  dm.q_1.ParamByName('cantidad').AsInteger := cantidad;
  dm.q_1.ParamByName('id_lote').AsInteger := id_lote;

  dm.q_1.ExecQuery;
end;
}

procedure ActualizaPackLote(id_pickcab, linea, codalbaran, id_articulo, cantidad, id_lote: Integer);
begin
  with tpFIBQuery.Create(dm) do
  begin
    Close;
    Database := dm.db;
    Transaction := dm.t_write;
    SQL.Clear;
    sql.Add('update a_packlin ' +
                    'set id_lote=:id_lote ' +
                    'where id_packcab=:id_packcab and ' +
                    'linea=:linea and codalbaran=:codalbaran and ' +
                    'id_articulo=:id_articulo and cantidad=:cantidad and id_lote<>:id_lote');
    ParamByName('id_packcab').AsInteger := id_pickcab;
    ParamByName('linea').AsInteger := linea;
    ParamByName('codalbaran').AsInteger := codalbaran;
    ParamByName('id_articulo').AsInteger := id_articulo;
    ParamByName('cantidad').AsInteger := cantidad;
    ParamByName('id_lote').AsInteger := id_lote;
    ExecQuery;
  end;
end;

function EncuentraPackLote(id_pickcab, linea, codalbaran, id_articulo, cantidad, id_lote: Integer): Boolean;
begin
  {dm.q_packs_lotes.Close;
  dm.q_packs_lotes.ParamByName('id_packcab').AsInteger := id_pickcab;
  dm.q_packs_lotes.ParamByName('linea').AsInteger := linea;
  dm.q_packs_lotes.ParamByName('codalbaran').AsInteger := codalbaran;
  dm.q_packs_lotes.ParamByName('id_articulo').AsInteger := id_articulo;
  dm.q_packs_lotes.ParamByName('cantidad').AsInteger := cantidad;
  dm.q_packs_lotes.ParamByName('id_lote').AsInteger := id_lote;
  dm.q_packs_lotes.Open;

  if not dm.q_packs_lotes.IsEmpty then
  begin
    result := True;
    dm.q_packs_lotes.First;
    ActualizaPackLote(id_pickcab, linea, codalbaran, id_articulo, cantidad, id_lote);
    dm.q_packs_lotes.Next;
  end else
          Result := False; }
end;

function CopiaLoteDePicking(id_pedido,codalbaran,id_articulo,id_art_padre:integer):string;
var
  peds_act: string;
begin
    peds_act := '';

    dm.q_picks_lotes.Close;
    dm.q_picks_lotes.ParamByName('albaran').AsInteger := codalbaran;
    if id_art_padre<0 then
      dm.q_picks_lotes.ParamByName('articulo').AsInteger := id_articulo
    else
      dm.q_picks_lotes.ParamByName('articulo').AsInteger := id_art_padre;
    dm.q_picks_lotes.Open;
    dm.q_picks_lotes.First;

    while not dm.q_picks_lotes.eof do
    begin

      InsertaLote(id_pedido,id_articulo, dm.q_picks_lotes.FieldByName('id_lote').AsInteger, dm.q_picks_lotes.FieldByName('cantidad').AsInteger, dm.q_picks_lotes.FieldByName('id_pickcab').AsInteger, dm.q_picks_lotes.FieldByName('linea').AsInteger);

      if Pos(IntToStr(id_pedido),peds_act)=0 then
          peds_act := peds_act + IntToStr(id_pedido) + ',';

      if id_art_padre<0 then
        ActualizaPackLote(dm.q_picks_lotes.FieldByName('id_pickcab').AsInteger, dm.q_picks_lotes.FieldByName('linea').AsInteger, codalbaran, id_articulo, dm.q_picks_lotes.FieldByName('cantidad').AsInteger, dm.q_picks_lotes.FieldByName('id_lote').AsInteger)
      else
        ActualizaPackLote(dm.q_picks_lotes.FieldByName('id_pickcab').AsInteger, dm.q_picks_lotes.FieldByName('linea').AsInteger, codalbaran, id_art_padre, dm.q_picks_lotes.FieldByName('cantidad').AsInteger, dm.q_picks_lotes.FieldByName('id_lote').AsInteger);

      dm.q_picks_lotes.Next;
    end;

    result := peds_act;
end;

function get_codcli_art(id_art:Integer):string;
begin
  Result := '';

  with TpFIBDataSet.Create(dm) do
  try
    Database := dm.db;
    sqls.SelectSQL.Add('select codigo_cli from g_articulos where id_articulo=:id_art');
    parambyname('id_art').AsInteger := id_art;
    Open;

    Result := FieldByName('codigo_cli').AsString;

  finally
    free;
  end;

end;


function GetFileTimes(FileName, tipo : string; var Fecha : TDateTime) : boolean;
//tipo: C:creacion M:modificacion A:ultimo acceso
var
   FileHandle : integer;
   Retvar : boolean;
   FTimeC,FTimeA,FTimeM : TFileTime;
   LTime : TFileTime;
   STime : TSystemTime;
begin
  // Abrir el fichero
  FileHandle := FileOpen(FileName,fmShareDenyNone);
  // inicializar
  fecha := 0.0;
  // Ha tenido acceso al fichero?
  if FileHandle < 0 then
    RetVar := false
  else begin

    // Obtener las fechas
    RetVar := true;
    GetFileTime(FileHandle,@FTimeC,@FTimeA,@FTimeM);
    // Cerrar
    FileClose(FileHandle);

    if tipo='C' then // Creado
          FileTimeToLocalFileTime(FTimeC,LTime)
    else if tipo='M' then  // Modificado
              FileTimeToLocalFileTime(FTimeM,LTime)
         else if tipo='A' then // Accedido
                  FileTimeToLocalFileTime(FTimeA,LTime);

    if FileTimeToSystemTime(LTime,STime) then begin

      Fecha := EncodeDate(STime.wYear,STime.wMonth,STime.wDay);
      Fecha := Fecha + EncodeTime(STime.wHour,STime.wMinute,
              STime.wSecond, STime.wMilliSeconds);
    end;

  end;
  Result := RetVar;
end;

procedure GetServHoraPedido(id_pedido:integer; out serv,hora,ret:integer);
begin

  serv := -1;
  hora := -1;
  ret := -1;

  with tpfibdataset.create(dm) do
  try
    database:=dm.db;
    close;
    sqls.SelectSQL.Clear;
    sqls.selectsql.Add('select tipo_servicio, horario, con_retorno from c_pedidos where id_pedido=:id_pedido');
    ParamByName('id_pedido').AsInteger := id_pedido;
    open;

    if not IsEmpty then
    begin
      serv := FieldByName('tipo_servicio').AsInteger;
      hora := FieldByName('horario').AsInteger;
      ret := FieldByName('con_retorno').AsInteger;
    end;

  finally
    free;
  end;
end;

function busca_art(cod_cli: string; id_cliente: integer): integer;
begin                                       //devuelve id de articulo a partir de codigo de cliente y cliente
  with tpfibdataset.Create(dm) do
  begin
    database := dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select id_articulo from g_articulos where codigo_cli=:codigo_cli ' +
                       ' and id_cliente=:id_cliente');
    ParambyName('codigo_cli').asstring := cod_cli;
    ParambyName('id_cliente').asinteger := id_cliente;
    Open;

    if not (IsEmpty) then
      Result := FieldByName('id_articulo').asinteger
    else
      result := -1;

    Free;
  end;
end;

function UpdateStockArt(id_articulo,uds:Integer):integer;
begin
   with tpFIBQuery.Create(dm) do
   try
      Close;
      database := dm.db;
      transaction := dm.t_write;
      sql.Clear;
      sql.Add('update a_stock set cantidad=:uds where id_articulo=:id_articulo');
      ParamByName('id_articulo').AsInteger := id_articulo;
      ParamByName('uds').AsInteger := uds;

      dm.t_write.StartTransaction;
      try
       ExecQuery;
       dm.t_write.Commit;
       Result := 1;
       InsertaLog(100,0,0,'','','a_stock','cantidad',
                  'update a_stock set cantidad='+ IntToStr(uds)+' where id_articulo='+IntToStr(id_articulo),
                  'Upd stock','');
      except

       dm.t_write.Rollback;
       Result := -1;
      end;

   finally
      Free;
   end;

end;


function obtenerUsuarioRed : Ansistring;
var
  dwI : DWord;
begin
  dwI := MAX_PATH;
  SetLength (Result, dwI + 1);
  if WNetGetUser (Nil, PChar (Result), dwI) = NO_ERROR then
   Result := PChar (Result)
  else
    SetLength (Result, 0)
end;

function n_serie_en_otro_pedido(id_cliente, id_pedido:integer; n_serie:string):string;
begin
    with TpFIBDataSet.Create(dm) do
    begin
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select p.id_pedido, order_name from c_pedidos p ' +
                         'inner join c_pedidos_lines l on l.id_pedido=p.id_pedido ' +
                         'where p.id_cliente=:id_cliente and p.id_pedido<>:id_pedido ' +
                         'and p.fecha_ped >=:fecha and l.n_serie=:n_serie');
      ParamByName('id_pedido').AsInteger := id_pedido;
      ParamByName('id_cliente').AsInteger := id_cliente;
      ParamByName('n_serie').AsString := n_serie;
      ParamByName('fecha').AsDateTime := Now-0.5;
      Open;

      If (not isEmpty) then
      begin
         Result := FieldByName('order_name').AsString + ' (Id.' + FieldByName('id_pedido').AsString + ')';
      end;
     free;
    end;
end;

function dar_baja_articulo(id_articulo:Integer;fecha:TDateTime):integer;
begin
   with tpFIBQuery.Create(dm) do
   try
      Close;
      database := dm.db;
      transaction := dm.t_write;
      sql.Clear;
      sql.Add('update g_articulos set fecha_baja=:fecha where id_articulo=:id_articulo and fecha_baja is null');
      ParamByName('id_articulo').AsInteger := id_articulo;
      ParamByName('fecha').AsDateTime := fecha;

      dm.t_write.StartTransaction;
      try
       ExecQuery;
       dm.t_write.Commit;

       Result := 1;
       InsertaLog(100,id_articulo,0,'','','g_articulos','fecha_baja',
                  'update g_articulos set fecha_baja=' + FormatDateTime('dd.mm.yyyy',fecha) + ' where id_articulo='+IntToStr(id_articulo) + ' and fecha_baja is null',
                  'BajaArt.' + IntToStr(id_articulo),'');
      except
       dm.t_write.Rollback;
       Result := -1;
      end;

   finally
      Free;
   end;

end;

function art_en_pick_pte(id_articulo,id_almacen:integer):boolean;
begin
    with TpFIBDataSet.Create(dm) do
    begin
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select * from a_picklin l ');
      sqls.SelectSQL.Add('inner join a_pickcab p on p.id_pickcab=l.id_pickcab ');
      sqls.SelectSQL.Add('where l.id_articulo=:id_articulo and l.situacion=''P'' and p.id_almacen=:id_almacen ');
      ParamByName('id_articulo').AsInteger := id_articulo;
      ParamByName('id_almacen').AsInteger := id_almacen;
      Open;

      Result := not isEmpty;

     free;
    end;
end;

function art_en_ped_pte(id_articulo, id_almacen:integer):boolean;
begin
    with TpFIBDataSet.Create(dm) do
    begin
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select * from c_pedidos_lines l ');
      sqls.SelectSQL.Add('inner join c_pedidos p on p.id_pedido=l.id_pedido ');
      sqls.SelectSQL.Add('where l.id_articulo=:id_articulo and p.estado=''P'' and p.id_almacen=:id_almacen ');
      ParamByName('id_articulo').AsInteger := id_articulo;
      ParamByName('id_almacen').AsInteger := id_almacen;
      Open;

      Result := not isEmpty;

     free;
    end;
end;

function get_ubics_art(id_articulo:Integer; ignora_0:Boolean):string;
begin
    result := '';

    with TpFIBDataSet.Create(dm) do
    begin
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select * from a_stock s ' +
                         'where s.id_articulo=:id_articulo');
      if not ignora_0 then
           sqls.SelectSQL.Add(' and s.cantidad>0');
      ParamByName('id_articulo').AsInteger := id_articulo;
      Open;

      if not IsEmpty then
      begin
         First;

         while not Eof do
         begin
             Result := Result +
                       FieldByName('id_articulo').AsString + '|' +
                       FieldByName('id_almacen').AsString + '|' +
                       FieldByName('id_ubicacion').AsString + '|' +
                       FieldByName('cantidad').AsString + '|' +
                       FieldByName('id_lote').AsString + '$';
            Next;
         end;
      end;

     free;
    end;

    if Result<>'' then
          Result := Copy(Result,0,Length(result)-1);
end;

function calcula_agencia_gestoras(id_cliente:Integer;pais,provincia,cp:string;peso:double):Integer;
begin

  result := -1;

  with tpfibdataset.create(dm) do
  try
    database:=dm.db;
    close;
    sqls.SelectSQL.Clear;
    sqls.selectsql.Add('select agencia from get_agencia_gestoras(:id_cliente,:pais,:peso,:provincia,:cp)');
    ParamByName('id_cliente').AsInteger := id_cliente;
    ParamByName('pais').AsString := pais;
    ParamByName('provincia').AsString := provincia;
    ParamByName('cp').AsString := cp;
    ParamByName('peso').AsFloat := peso;
    open;

    if not(isempty) then begin
      result := fieldbyname('agencia').AsInteger;
    end;

  finally
    free;
  end;
end;

end.

