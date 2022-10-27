unit u_restclient;

interface

uses
  System.SysUtils, System.Classes,REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, IdMultipartFormData, IPPeerClient,
  REST.Types,system.Json.readers,system.Json.types ,Dialogs;

  procedure GeneraUrl(url:string);
  procedure DameRespuesta(var id_attachment :integer; var url: string);
  procedure Ejecuta(url: String);

implementation

uses
  u_dm;

{%CLASSGROUP 'Vcl.Controls.TControl'}

procedure TDMLogoCli.GeneraUrl(url:string);
var
  BaseUrl:string;
begin
  //BaseURL:='https://servertest.loginser.com:5443/loginser-back/api/attachment-articulo';

  BaseUrl := url;
  dm.RESTClient1.BaseURL:=BaseUrl;
  dm.RESTClient1.ContentType := 'multipart/form-data';
end;


procedure TDMLogoCli.Ejecuta(url: String);
var
  StreamContent: TMemoryStream;
  contentResult, BaseName:String;
  p:TRESTRequestParameter;

begin
  GeneraUrl(url);

  try
    dm.RESTRequest1.Params.Clear;

    dm.RESTRequest1.ClearBody;
    dm.RESTRequest1.AddBody(vFormData, ctNone);
    dm.RESTRequest1.Params.Delete('Content-Type');
    dm.RESTRequest1.Params.AddItem('Content-Type', vFormData.RequestContentType,
         TREstRequestParameterKind.pkHTTPHEADER, [poDoNotEncode], TRESTContentType.ctIMAGE_JPEG);
    dm.RESTRequest1.Execute;

    if((dm.RESTResponse1.StatusCode=200)or(dm.RESTResponse1.StatusCode=201))then
    begin
          DameRespuesta(id_attachment,url);
          //Actualizar tabla a_matriculas
    end
    else
       showmessage('Han ocurrido errores al generar el logo');

  finally
    StreamContent.Free;                              //
    vFormData.Free;
  end;

end;

procedure TDMLogoCli.DameRespuesta(var id_attachment:integer; var url:string);
var
  Sr: TStringReader;
  Reader: TJsonTextReader;
begin
  if dm.restResponse1.Content<>'' then
  begin
      Sr := TStringReader.Create(dm.restResponse1.Content);
      Reader := TJsonTextReader.Create(Sr);
      while reader.read do
      begin
       case Reader.TokenType of
        TJsonToken.String: begin
          if Reader.Path='url' then
             url:=Reader.Value.ToString;
        end;
        TJsonToken.integer:begin
         if Reader.Path='attachmentId' then
             id_attachment:=strtoint(Reader.Value.ToString);
        end;
      end;
     end;
     reader.Free;
     sr.Free;
  end;

end;


end.
