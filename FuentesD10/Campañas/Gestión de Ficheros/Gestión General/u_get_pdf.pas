unit u_get_pdf;

interface

uses
  Winapi.Windows,System.SysUtils, System.Classes, system.IOUtils, IPPeerClient, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, FireDAC.Stan.Intf,
  FireDAC.Comp.Client,System.json, FireDAC.Stan.StorageJSON,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet,Dialogs, REST.Authenticator.Basic,
  system.Json.readers,system.Json.types, Vcl.Forms, Vcl.Controls,
  dxPDFViewer, IdHTTPHeaderInfo, IdHTTP, dxPrnDev, cxClasses, dxPrnDlg,
  dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPSCompsProvider,
  dxPSFillPatterns, dxPSEdgePatterns, dxPSPDFExportCore, dxPSPDFExport,
  cxDrawTextUtils, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinOffice2016Colorful, dxSkinOffice2016Dark,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, dxPSPrVwStd, dxPSPrVwAdv, dxPSPrVwRibbon,
  dxPScxPageControlProducer, dxPSdxPDFViewerLnk, dxPScxEditorProducers,
  dxPScxExtEditorProducers, dxPSCore, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, REST.Authenticator.Simple,  IdSSLOpenSSLHeaders;


type
  Tdm_pdf = class(TDataModule)
    TLocal: TFDTransaction;
    TUpdate: TFDTransaction;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    dxPrintDialog1: TdxPrintDialog;
    IdHTTP1: TIdHTTP;
    auth: THTTPBasicAuthenticator;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
     jsbody:TJSONObject;
    procedure GeneraUrl;
    procedure GeneraBody(tipo:string);
    procedure GeneraBodyUna(tipo,albaran:string);
    procedure ImprimeEtiquetas;
    Procedure ImprimeEtiqueta(url,tipo:string);
    procedure ImprimePdf(fichero:string);
    procedure DameRespuesta(var texto: string);
    Procedure ImprimeEtiquetasBack(const Tipo:String; const Total_Bultos:Integer; var Error:String);
  public
    { Public declarations }
    procedure ObtenEtiquetas(tipo,albaran:string;una:Boolean=False);
    function CreateTempFile(prefijo:string): string;
    //
    procedure ObtenEtiquetasBack(const tipo:string; const Total_Bultos:Integer; Var Error:String);

  end;

const
  _AcceptReferer='https://apptest.loginser.com/';

var
  dm_pdf: Tdm_pdf;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses u_dm, u_main, u_globals;

{uses  u_main, u_globals, u_dm; }

{$R *.dfm}

procedure Tdm_pdf.DataModuleCreate(Sender: TObject);
begin

   //u_main.ActivaConfigApp;
end;

procedure Tdm_pdf.GeneraBody(tipo:String);
var
  jsalbaran:TJSONObject;
  jsalbaranes:TJSONArray;
begin
   with dm.xEtiquetas do
   begin
     close;
       Parambyname('usuario').asinteger:= 4;
     open;
   end;
   jsbody:=TJSONObject.Create();

   jsalbaranes:= TJSONArray.Create;
   while not dm.xEtiquetas.eof do
   begin
     jsalbaranes.Add(inttostr(dm.xEtiquetasId_albaran.asinteger));
     dm.xEtiquetas.next;
   end;

   jsbody.addPair('tipo', tipo);
   jsbody.addPair(TJSONPair.Create('ids', jsalbaranes));

  // showmessage(jsbody.ToString);
end;

procedure Tdm_pdf.GeneraBodyUna(tipo,albaran:string);
var
  jsalbaran:TJSONObject;
  jsalbaranes:TJSONArray;
begin
   jsbody:=TJSONObject.Create();

   jsalbaranes:= TJSONArray.Create;
   jsalbaranes.Add(albaran);

   jsbody.addPair('tipo', tipo);
   jsbody.addPair(TJSONPair.Create('ids', jsalbaranes));

  // showmessage(jsbody.ToString);
end;

procedure Tdm_pdf.GeneraUrl;
var
  BaseUrl:string;
begin
     if u_globals.api='' then
     begin
        BaseUrl := 'https://www.dioxilife.com/admin093xf/';
     end
     else
        BaseUrl := api;

   //BaseURL:= BaseUrl + 'print/print-json';

   RESTClient1.BaseURL:=BaseUrl;
end;

procedure Tdm_pdf.ObtenEtiquetas(tipo,albaran:string;una:Boolean=False);
var
  i,estado:integer;
  bultos_alb,bultos_eti:integer;
begin
    if una then
      GeneraBodyUna(tipo,albaran)
    else
      GeneraBody(tipo);

    GeneraUrl;
    try
       RESTRequest1.ClearBody;
       RESTRequest1.addbody(jsbody);
       RESTRequest1.Execute;
       estado:=RESTResponse1.StatusCode;
       //GuardaLogApi(rentorno.Nombre, RESTClient1.BaseURL,inttostr(estado),RESTResponse1.StatusText,now);

       if estado<>200 then
       begin
         showmessage('Han ocurrido errores al descargar pdf: ' + RESTResponse1.StatusText);
       end
       else
       begin
          ImprimeEtiquetas;
       end;
      except

      end;
    jsbody.Free;
end;

Procedure Tdm_pdf.ImprimeEtiquetas;
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


procedure Tdm_pdf.DameRespuesta(var texto:string);
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

procedure Tdm_pdf.ObtenEtiquetasBack(const tipo:string;const Total_Bultos:Integer; Var Error:String);
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
         //GuardaLogApi(rentorno.Nombre, RESTClient1.BaseURL,inttostr(estado),RESTResponse1.StatusText,now);
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

Procedure Tdm_pdf.ImprimeEtiquetasBack(const Tipo:String; const Total_Bultos:Integer; var Error:String);
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
              IdSSLOpenSSLHeaders.Load;

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

Procedure Tdm_pdf.ImprimeEtiqueta(url,tipo:string);
var
  MS1: TMemoryStream;
  fichero:string;
  IdHTTP1: TIdHTTP;
begin
  try
    ms1 := TMemoryStream.Create;
    screen.Cursor:=crhourglass;
    try
      IdHTTP1:=TIdHTTP.Create;
      IdHttp1.Request.Referer:=_AcceptReferer;
      IdHTTP1.Get(url, ms1);
      if ms1.Size > 0 then
      begin
        ms1.Position := 0;
        fichero:=CreateTempFile('');
        fichero:=extractfileName(fichero)+'.'+tipo;
        try
          ms1.SaveToFile(fichero);
          //shellexecute(Application.handle,'open',Pchar(fichero),nil,nil,sw_show);
         // shellexecute(Application.handle,'print',Pchar(fichero),nil,nil,SW_HIDE);
         imprimePdf(fichero);
        finally
         //  deletefile(PWidechar(fichero));
        end;
      end;
    finally
      ms1.Free;
      IdHTTP1.Free;
      screen.Cursor:=crdefault;
    end;
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;


procedure Tdm_pdf.ImprimePdf(fichero:string);
var
  indice:integer;
  OldPrintDialog:TdxPreviewEnableOptions;
begin

  OldPrintDialog:=f_main.dxPrinter.PreviewOptions.EnableOptions;
  f_main.dxPrinter.PreviewOptions.EnableOptions:= [peoCanChangeMargins,peoPageBackground,peoPageSetup,peoPreferences,peoPrint,peoReportDesign];

  if f_main.dxPDF.IsDocumentLoaded then
     f_main.dxPDF.Document.Clear;
  f_main.dxPdf.LoadFromFile(fichero);
  indice:=dxPrintDevice.Printers.IndexOf(u_globals.imp_eti);
  dxPrintDevice.PrinterIndex := indice;
  f_main.dxPrinter.Print(false,nil,nil);
  deletefile(PWideChar(fichero));
  f_main.dxPrinter.PreviewOptions.EnableOptions:=OldPrintDialog;
end;


function Tdm_pdf.CreateTempFile(prefijo:string): string;
// Crea un directorio temporal y devuelve su nombre y camino
 var NewTempName, PathName : array [0..MAX_PATH] of char;
begin
    if (Length (Prefijo) = 0) then
        Prefijo := 'Tmp';
    GetTempPath (MAX_PATH, @PathName); // busca el directorio temporal de Windows
    GetTempFileName (PathName, PChar (Prefijo),0, @NewTempName);//Devuelve el nombre de fichero único
    result := NewTempName;
end;

end.
