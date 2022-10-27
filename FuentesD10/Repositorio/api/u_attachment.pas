unit u_attachment;

interface

uses
  System.SysUtils, System.Classes,REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, IdMultipartFormData, IPPeerClient,
  REST.Types,system.Json.readers,system.Json.types ,Dialogs;

  procedure GeneraUrl;
  procedure DameRespuesta(var id_attachment :integer; var url: string);
  procedure SubeAdjunto(const  filename,fichero_final, path, AContentTypeFile: String;
      var id_attachment: Integer; var Url: String);

implementation

uses
    u_dm, u_globals;

{%CLASSGROUP 'Vcl.Controls.TControl'}

procedure GeneraUrl;
var
  BaseUrl, api:string;
begin
    if api='' then
     begin
        BaseUrl := 'https://server.loginser.com/loginser-back/api/';
     end
     else
        BaseUrl := api;

  BaseURL:=BaseUrl + 'attachment';

  dm.client.BaseURL:=BaseUrl;
  dm.client.ContentType := 'multipart/form-data';
end;

                                                             //'imagen/jpeg'
procedure SubeAdjunto(const filename,fichero_final,path, AContentTypeFile: String;
  var Id_attachment: Integer; var Url: String);
var
  StreamContent: TMemoryStream;
  BaseName:String;
  p:TRESTRequestParameter;
  vFormData: TIdMultiPartFormDataStream;
  path_api:string;
begin
  GeneraUrl;
  path_api:=path;
   try
        StreamContent := TMemoryStream.Create;
        try
          StreamContent.LoadFromFile(filename);
          StreamContent.Position:= 0;
          BaseName:=EXtractFileName(FileName);

          dm.request.Params.Clear;

          vFormData := TIdMultiPartFormDataStream.Create;
          vFormData.AddFormField('path', path_api);
          vFormData.AddFormField('filename', BaseName);
          vFormData.AddFormField('file', AContentTypeFile, 'utf-8', StreamContent, BaseName );
          vFormData.Seek(0, TSeekOrigin.soBeginning);
          dm.request.ClearBody;
          dm.request.AddBody(vFormData, ctNone);
          dm.request.Params.Delete('Content-Type');
          dm.request.Params.AddItem('Content-Type', vFormData.RequestContentType,
               TREstRequestParameterKind.pkHTTPHEADER, [poDoNotEncode], TRESTContentType.ctIMAGE_JPEG);
          dm.request.Execute;

         //GuardaLogApi(rentorno.Nombre, RESTClient1.BaseURL,inttostr(response.StatusCode),response.StatusText,now);

          if((dm.response.StatusCode=200)or(dm.response.StatusCode=201))then
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
  except
       // Settings.Logg('Creando documento adjunto genérico.');
  end;
end;

procedure DameRespuesta(var id_attachment:integer; var url:string);
var
  Sr: TStringReader;
  Reader: TJsonTextReader;
begin
  if dm.response.Content<>'' then
  begin
      Sr := TStringReader.Create(dm.response.Content);
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
