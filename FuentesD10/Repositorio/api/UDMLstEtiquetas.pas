unit UDMLstEtiquetas;

interface

uses
  System.SysUtils, System.Classes, IPPeerClient, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, FireDAC.Stan.Intf,
  FireDAC.Comp.Client,System.json, FireDAC.Stan.StorageJSON,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet,Dialogs, REST.Authenticator.Basic,
  system.Json.readers,system.Json.types;


type
  TDMLstEtiquetas = class(TDataModule)
    TLocal: TFDTransaction;
    TUpdate: TFDTransaction;
    xEtiquetas: TFDQuery;
    xEtiquetasUSUARIO: TIntegerField;
    xEtiquetasID_ALBARAN: TIntegerField;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
     jsbody:TJSONObject;
    procedure GeneraUrl;
    procedure GeneraBody(tipo:string);
    procedure ImprimeEtiquetas;
    procedure DameRespuesta(var texto: string);
    Procedure ImprimeEtiquetasBack(const Tipo:String; const Total_Bultos:Integer; var Error:String);
  public
    { Public declarations }
    procedure ObtenEtiquetas(tipo:string);
    //
    procedure ObtenEtiquetasBack(const tipo:string; const Total_Bultos:Integer; Var Error:String);

  end;

var
  DMLstEtiquetas: TDMLstEtiquetas;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses UDMMain, UEntorno, UALbaranesUtils, USerEnviosMail, UUtiles, IdHTTP;

{$R *.dfm}

procedure TDMLstEtiquetas.DataModuleCreate(Sender: TObject);
begin
   DMMain.ActivaConfigApp;
end;

procedure TDMLstEtiquetas.GeneraBody(tipo:String);
var
  jsalbaran:TJSONObject;
  jsalbaranes:TJSONArray;
begin
   with xEtiquetas do
   begin
     close;
       Parambyname('usuario').asinteger:=rentorno.Usuario;
     open;
   end;
   jsbody:=TJSONObject.Create();

   jsalbaranes:= TJSONArray.Create;
   while not xEtiquetas.eof do
   begin
     jsalbaranes.Add(inttostr(xEtiquetasId_albaran.asinteger));
     xEtiquetas.next;
   end;

   jsbody.addPair('tipo', tipo);
   jsbody.addPair(TJSONPair.Create('ids', jsalbaranes));

  // showmessage(jsbody.ToString);
end;

procedure TDMLstEtiquetas.GeneraUrl;
var
  BaseUrl:string;
begin
   BaseURL:=DMMain.xConfiguracion.FieldByName('server').AsString+'loginser-back/api/print/print-json';

   RESTClient1.BaseURL:=BaseUrl;
end;

procedure TDMLstEtiquetas.ObtenEtiquetas(tipo:string);
var
  i,estado:integer;
  bultos_alb,bultos_eti:integer;
begin
    GeneraBody(tipo);
    GeneraUrl;
    try
       RESTRequest1.ClearBody;
       RESTRequest1.addbody(jsbody);
       RESTRequest1.Execute;
       estado:=RESTResponse1.StatusCode;
       GuardaLogApi(rentorno.Nombre, RESTClient1.BaseURL,inttostr(estado),RESTResponse1.StatusText,now);

       if estado<>200 then
       begin
         showmessage('Han ocurrido errores al generar los bultos: ' + RESTResponse1.StatusText);
       end
       else
       begin
          ImprimeEtiquetas;
       end;
      except

      end;
    jsbody.Free;
end;

Procedure TDMLstEtiquetas.ImprimeEtiquetas;
var
  s: string;
  FileStream: TFileStream;
  fichero:string;

  texto:String;
  Writer: TWriter;
  myStringBuilder: TStringBuilder;
  NFic: textFile;
begin
   DameRespuesta(texto);
   if texto<>'' then
     ImprimeEtiqueta(texto,'pdf');
end;


procedure TDMLstEtiquetas.DameRespuesta(var texto:string);
var
  Sr: TStringReader;
  Reader: TJsonTextReader;
begin
  texto:='';
  if restResponse1.Content<>'' then
  begin
      Sr := TStringReader.Create(restResponse1.Content);
      Reader := TJsonTextReader.Create(Sr);
      while reader.read do
      begin
       case Reader.TokenType of
        TJsonToken.String: begin
          if Reader.Path='url' then
             texto:=Reader.Value.ToString;
       end
      end;
     end;
     reader.Free;
     sr.Free;
  end;

end;

procedure TDMLstEtiquetas.ObtenEtiquetasBack(const tipo:string;const Total_Bultos:Integer; Var Error:String);
var
  i,estado:integer;
  bultos_alb,bultos_eti:integer;
begin
  Error:='';
  try
      GeneraBody(tipo);
      GeneraUrl;
      try
         RESTRequest1.ClearBody;
         RESTRequest1.addbody(jsbody);
         RESTRequest1.timeout:=(Total_Bultos*4000)+20000;
         RESTRequest1.Execute;
         estado:=RESTResponse1.StatusCode;
         GuardaLogApi(rentorno.Nombre, RESTClient1.BaseURL,inttostr(estado),RESTResponse1.StatusText,now);
         if estado<>200 then
             Error:='Error descargando etiquetas ('+estado.tostring+') '+ RESTResponse1.StatusText
         else
             ImprimeEtiquetasBack('pdf', Total_bultos, Error);
      except
         on e:exception do
             Error:='Error desconocido descargando etiqueta: '+ e.Message;
      end;
  finally
      jsbody.Free;
  end;

end;

Procedure TDMLstEtiquetas.ImprimeEtiquetasBack(const Tipo:String; const Total_Bultos:Integer; var Error:String);
var
   url_eti:String;
   //
   s: string;
   MS1: TMemoryStream;
   fichero:string;
   IdHTTP1: TIdHTTP;
begin
   DameRespuesta(url_eti);
   if url_eti<>'' then
   begin
          try
            ms1 := TMemoryStream.Create;
            try
              IdHTTP1:=TIdHTTP.Create;
              IdHttp1.Request.Referer:=_AcceptReferer;
              IdHttp1.ReadTimeout:=(Total_Bultos*4000)+20000;
              IdHTTP1.Get(url_eti, ms1);
              if ms1.Size > 0 then
              begin
                    ms1.Position := 0;
                    fichero:=CreateTempFile('');
                    fichero:=extractfileName(fichero)+'.'+tipo;
                    ms1.SaveToFile(fichero);
                    imprimePdf(fichero);
              end;
            finally
              ms1.Free;
              IdHTTP1.Free;
            end;
          except
            on e:exception do
              Error:='Error descargando etiqueta fichero ('+extractfilename(fichero)+'): ' + E.Message;
          end;
   end
   else
      error:='No se ha encontrado la ruta de descarga de la etiqueta.';
end;


end.
