unit u_pedidos;

interface

uses
  System.SysUtils, pFIBDataSet;

function GetAgenciaPedido(id_pedido:Integer):integer;
function GetOrderNamePedido(id_pedido:Integer):string;
function GetRefClientePedido(id_pedido:Integer):string;
function GetAlbaranPedido(id_pedido:Integer):integer;
function GetIdDestinoPedido(id_pedido:Integer):integer;
function GetIdPedido(order:string; cod_cliente:integer):integer;

implementation

uses
  u_dm;

function GetAgenciaPedido(id_pedido:Integer):integer;
begin
    with TpFIBDataSet.Create(dm) do
    begin
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select id_repartidor from c_pedidos where id_pedido=:id');
      ParamByName('id').asinteger := id_pedido;
      Open;
      First;

      result := FieldByName('id_repartidor').asinteger;

     free;
    end;
end;

function GetOrderNamePedido(id_pedido:Integer):string;
begin
    with TpFIBDataSet.Create(dm) do
    begin
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select order_name from c_pedidos where id_pedido=:id');
      ParamByName('id').asinteger := id_pedido;
      Open;
      First;

      result := FieldByName('order_name').AsString;

     free;
    end;
end;

function GetRefClientePedido(id_pedido:Integer):string;
begin
    with TpFIBDataSet.Create(dm) do
    begin
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select ref_cliente from c_pedidos where id_pedido=:id');
      ParamByName('id').asinteger := id_pedido;
      Open;
      First;

      result := FieldByName('ref_cliente').AsString;

     free;
    end;
end;

function GetAlbaranPedido(id_pedido:Integer):integer;
begin
    with TpFIBDataSet.Create(dm) do
    begin
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select codalbaran from c_pedidos where id_pedido=:id');
      ParamByName('id').asinteger := id_pedido;
      Open;
      First;

      result := FieldByName('codalbaran').asinteger;

     free;
    end;
end;

function GetIdDestinoPedido(id_pedido:Integer):integer;
begin
    with TpFIBDataSet.Create(dm) do
    begin
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select gestoras_dest from c_pedidos where id_pedido=:id');
      ParamByName('id').asinteger := id_pedido;
      Open;
      First;

      result := FieldByName('gestoras_dest').asinteger;

     free;
    end;
end;

function GetIdPedido(order:string; cod_cliente:integer):integer;
begin                                       //devuelve id de pedido a partir de codigo de pedido y cliente
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select * from c_pedidos p ' +
                       'where p.order_name=:order and p.id_cliente=:cod_cliente');
    ParambyName('order').asstring := order;
    ParambyName('cod_cliente').asinteger := cod_cliente;
    Open;

    if not(IsEmpty) then Result:=FieldByName('id_pedido').asinteger
    else result:=-1;

    Free;
  end;
end;

end.
