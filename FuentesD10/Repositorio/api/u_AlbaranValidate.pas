unit u_AlbaranValidate;

interface

uses
  System.SysUtils, System.Classes,REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, IdMultipartFormData, IPPeerClient,
  REST.Types,system.Json.readers,system.Json.types ,Dialogs, System.JSON;

  procedure GeneraUrl(albaran:string);
  procedure DameRespuesta(var texto: string);
  function ValidaAlbaran(const  albaran: String; var texto: String):Boolean;

implementation

uses
    u_dm, u_globals;

{%CLASSGROUP 'Vcl.Controls.TControl'}

procedure GeneraUrl(albaran:string);

var
  BaseUrl:string;
begin
    if api='' then
     begin
        BaseUrl := 'https://server.loginser.com/loginser-back/api/';
     end
     else
        BaseUrl := api;

  BaseURL:= BaseUrl + 'albaran/' + albaran + '/validate';

  dm.RESTClient1.BaseURL:=BaseUrl;

end;


function ValidaAlbaran(const albaran: String; var texto: String):Boolean;
var
  contentResult, BaseName:String;
  p:TRESTRequestParameter;
  vFormData: TIdMultiPartFormDataStream;
  path_api:string;
  jsbody: TJSONObject;
  estado: integer;
begin
   GeneraUrl(albaran);
   try
       dm.RESTRequest1.ClearBody;
       jsbody:=TJSONObject.Create();
       dm.RESTRequest1.addbody(jsbody);
       dm.RESTRequest1.Execute;
       estado:=dm.RESTResponse1.StatusCode;


       //GuardaLogApi(rentorno.Nombre, RESTClient1.BaseURL,inttostr(estado),RESTResponse1.StatusText,now);

       Result := ((estado=200) or (estado=201));
       if result then
            DameRespuesta(texto);
       jsbody.Free;
      except

      end;
end;

procedure DameRespuesta(var texto:string);
var
  Sr: TStringReader;
  Reader: TJsonTextReader;
  respuesta   : TJsonValue;
  originalObject : TJsonObject;
  jsPair : TJsonPair;
  jsArrErrores: TJsonArray;
  i:integer;
  jso  : TJsonObject;
begin
  texto:='';
  if dm.restResponse1.Content<>'' then
  begin
      respuesta := TJSONObject.ParseJSONValue(dm.restResponse1.Content);
      try
            //value as object
            originalObject := respuesta as TJsonObject;

            //get pair, wich contains Array of objects
            jspair := originalObject.Get('errores');
            //pair value as array
            jsArrErrores := jsPair.jsonValue as  TJsonArray;

            for i := 0 to jsArrErrores.Size - 1 do begin
                texto:=texto+jsArrErrores.Get(i).value
            end;
        finally
            respuesta.Free();
        end;
  end;

end;


end.
