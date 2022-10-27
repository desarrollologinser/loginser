unit u_functions;

interface

uses
    pFIBDataSet, System.SysUtils;

type
  TIntArray = array of Integer;

  function GetFileConfig(cliente:integer):TIntArray;
  function GetRepartidorLgs(albaran:Integer):Integer;
  function GetIdAgenciaXRepartidor(repartidor:string):Integer;
  function GetAgenciaXId(id:integer):string;
  function GetProvinciaNombre(cp:string):string;
  function UdsEnPickingPte(id_articulo:integer):integer;
  function GetConexion(nombre:string):string;

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
                       'inner join g_clientes_config cl on cl.id_cliente=f.id_cliente ' +
                       'where f.id_cliente=:id and f.id_pedido_config=cl.id_file_config ');
    ParambyName('id').AsInteger := cliente;
    Open;

    if not(IsEmpty) then
    begin
         SetLength(result, fields.Count-3);

         for I := 0 to fields.Count-4 do
            Result[i] := FieldByFieldNo(i+4).Value;

//         result[0] := FieldByName('CODIGO_CLIENTE').AsInteger;
//         result[1] := FieldByName('CLIENTE_DELEG').AsInteger;
//         result[2] := FieldByName('CODIGO_ALBARAN').AsInteger;
//         result[3] := FieldByName('FECHA').AsInteger;
//         result[4] := FieldByName('REFERENCIA_ARTICULO').AsInteger;
//         result[5] := FieldByName('DESTINO_DELEGACION').AsInteger;
//         result[6] := FieldByName('DESTINO_NOMBRE').AsInteger;
//         result[7] := FieldByName('DESTINO_DIRECCION').AsInteger;
//         result[8] := FieldByName('DESTINO_LOCALIDAD').AsInteger;
//         result[9] := FieldByName('DESTINO_CP').AsInteger;
//         result[10] := FieldByName('DESTINO_PROVINCIA').AsInteger;
//         result[11] := FieldByName('DESTINO_TELEFONO').AsInteger;
//         result[12] := FieldByName('DESTINO_EMAIL').AsInteger;
//         result[13] := FieldByName('DESTINO_CONTACTO').AsInteger;
//         result[14] := FieldByName('OBSERVACIONES').AsInteger;
//         result[15] := FieldByName('PAIS').AsInteger;
//         result[16] := FieldByName('UNIDADES').AsInteger;
//         result[17] := FieldByName('DELIVERY_TIME').AsInteger;
//         result[18] := FieldByName('REEMBOLSO').AsInteger;
//         result[19] := FieldByName('PORTES_DEBIDOS').AsInteger;
//         result[20] := FieldByName('PEDIDO').AsInteger;

    end;

    Free;
  end;
end;

function GetRepartidorLgs(albaran:Integer):Integer;
begin
  dm.q_sql2.Close;
  dm.q_sql2.SQL.Clear;
  dm.q_sql2.SQL.Add('select codrepartidor from albaranes where codalbaran=:codalbaran');
  dm.q_sql2.parameters.parambyname('codalbaran').value:=albaran;
  dm.q_sql2.Open;

  if not (dm.q_sql2.FieldByName('codrepartidor').AsString='') then
  begin
    result := dm.q_sql2.FieldByName('codrepartidor').AsInteger;
  end else
        Result := 0;

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

end.
