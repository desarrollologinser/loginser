unit u_orders;

interface

uses
    Winapi.Windows, System.SysUtils, System.Classes, FIBDataSet,
    pFIBDataSet, Data.DBXJSON, IdHTTP, Vcl.Dialogs;

function CreaJson(id_pedido:integer):TStringList;
function EnviaJson(json:string):string;
function EnviaReexp(id_pedido:integer):Boolean;

implementation

uses
  u_dm, u_envia_mail, u_gen_gl;

function EnviaReexp(id_pedido:integer):Boolean;
var
  json: TStringList;
  i: integer;
  str_js: string;
begin
   try
      json := CreaJson(id_pedido);

      for I := 0 to json.Count - 1 do
        str_js := str_js + json[i];

      EnviaJson(str_js);

      result := true;
   except
      Result := false;
   end;
end;


function CreaJson(id_pedido:integer):TStringList;
var
  json: TStringList;
  items: string;
begin

      with TpFIBDataSet.Create(dm) do
      try
        Database:=dm.db;
        SQLs.SelectSQL.Clear;
        sqls.SelectSQL.Add('select * from c_pedidos where id_pedido=:pedido');
        ParamByName('pedido').AsInteger := id_pedido;
        Open;
        First;

        if not isEmpty then
        begin
            json := TStringlist.Create;

            json.Text := '{';

            json.Append('"status" : "R"' + ',');
            json.Append('"id" : "' + FieldByName('id_order').AsString + '",');
            json.Append('"email" : "' + FieldByName('email').AsString + '",');
            //...
            json.Append('"gateway" : "' + FieldByName('gateway').AsString + '",');
            //...
            json.Append('"financial_status" : "' + FieldByName('financial_status').AsString + '",');
            //...
            json.Append('"name" : "' + FieldByName('order_name').AsString + '",');
            //...
            json.Append('"cancelled_at" : null,');
            json.Append('"cancel_reason" : "",');
            //...
            json.Append('"fulfillment_status" : "' + FieldByName('fulfillment_status').AsString + '",');
            //...
            json.Append('"tags" : "",');
            //...

            //********************************************************LINE_ITEMS
            json.Append('"line_items" : [ ');
            dm.q_3.Close;
            dm.q_3.SelectSQL.Clear;
            dm.q_3.SQLs.SelectSQL.Add('select * from c_pedidos_lines where id_pedido=:id_pedido ');
            dm.q_3.ParambyName('id_pedido').AsInteger := id_pedido;
            dm.q_3.Open;
            dm.q_3.First;

            items := '';

            while not dm.q_3.eof do
            begin
                 items := items + '{';
                 //...
                 items := items + '"quantity" : "' + dm.q_3.FieldByName('nombre_art').AsString + '",';
                 //...
                 items := items + '"sku" : "' + dm.q_3.FieldByName('sku').AsString + '",';
                 //...
                 items := items + '"name" : "' + UpperCase(dm.q_3.FieldByName('nombre_art').AsString) + '"';
                 //...
                 items := items + '},';
                 dm.q_3.Next;
            end;

            json.Append(Copy(items,0, Length(items)-1) + '], ');

            //...

            // ******************************************************** SHIPPING_ADDRESS

            json.Append('"shipping_address" : { ');
              //...
              json.Append('"address1" : "' + FieldByName('dir_1').AsString + '",');
              json.Append('"phone" : "' + FieldByName('telefono').AsString + '",');
              json.Append('"city" : "' + FieldByName('poblacion').AsString + '",');
              json.Append('"zip" : "' + FieldByName('cp').AsString + '",');
              json.Append('"province" : "' + FieldByName('provincia').AsString + '",');
              json.Append('"country" : "' + FieldByName('pais').AsString + '",');
              //...
              json.Append('"address2" : "",');
              json.Append('"company" : "' + FieldByName('company').AsString + '",');
              //...
              json.Append('"name" : "' + FieldByName('nombre').AsString + '",');
              json.Append('"country_code" : "' + FieldByName('pais_code').AsString + '"');
              json.Append('}');  //end shipping address

              json.Append('}'); //end json

            Result := json;
        end;

      finally
        free;
      end;

end;

function EnviaJson(json:string): string;
    var
    HTTP: TIdHTTP;
    RequestBody: TStream;
    ResponseBody: string;
begin
    HTTP := TIdHTTP.Create;
    try
      try
        //RequestBody := TStringStream.Create('{"FechaOperacion":'25-09-2017 12:00'}', TEncoding.UTF8);
        RequestBody := TStringStream.Create(json, TEncoding.UTF8);
        try
          HTTP.Request.Accept := 'application/json';
          HTTP.Request.ContentType := 'application/json';
          ResponseBody := HTTP.Post('http://www.loginser.com/sync/shopify/sync_shopify_webhook.php', RequestBody);
          result:= ResponseBody;
        finally
          RequestBody.Free;
        end;
      except
        on E: EIdHTTPProtocolException do
        begin
          showmessage(E.Message);
          showmessage(E.ErrorMessage);
        end;
        on E: Exception do
        begin
          showmessage(E.Message);
        end;
      end;
    finally
      HTTP.Free;
    end;
    //ReadLn;
    ReportMemoryLeaksOnShutdown := True;
end;



end.
