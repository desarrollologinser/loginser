unit u_DescargaAttach;

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
  IdTCPConnection, IdTCPClient, REST.Authenticator.Simple,  IdSSLOpenSSLHeaders,
  Winapi.ShellAPI;


type
  TdmDescargaAttach = class(TDataModule)
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
    procedure GeneraUrl(id_pedido: integer);
    procedure GeneraBody(tipo:string);
    procedure GeneraBodyUna(tipo,albaran:string);
    procedure Descarga;
    function Guarda(id_pedido,url,tipo:string):string;
    function GuardaEn(ruta,id_pedido,url,tipo:string):string;
    Procedure Imprime(url,tipo:string);
    procedure ImprimePdf(fichero:string);
    procedure DameRespuesta(var url:string; var attachId:integer);
  public
    { Public declarations }
    function ObtenAttach(id_pedido,tipo,act:string; var attachId:integer):string; overload; //act= P:print S:save L:link
    function ObtenAttach(id_pedido,tipo,act,ruta:string):string; overload; //act= P:print S:save  L:link
    function CreateTempFile(prefijo:string): string;
  end;

const
  _AcceptReferer='https://apptest.loginser.com/';

var
  dmDescargaAttach: TdmDescargaAttach;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses u_dm, u_main, u_globals;

{uses  u_main, u_globals, u_dm; }

{$R *.dfm}

procedure TdmDescargaAttach.DataModuleCreate(Sender: TObject);
begin

   //u_main.ActivaConfigApp;
end;

procedure TdmDescargaAttach.GeneraBody(tipo:String);
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

procedure TdmDescargaAttach.GeneraBodyUna(tipo,albaran:string);
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

procedure TdmDescargaAttach.GeneraUrl(id_pedido: integer);
var
  BaseUrl:string;
begin
     if u_globals.api='' then
     begin
        BaseUrl := 'https://server.loginser.com/loginser-back/api/';
     end
     else
        BaseUrl := api;

   BaseURL:= BaseUrl + 'pedido-adjunto?pedido-id=' + IntToStr(id_pedido);

   RESTClient1.BaseURL:=BaseUrl;
end;

function TdmDescargaAttach.ObtenAttach(id_pedido,tipo,act:string; var attachId:integer):string;
var
  i,estado:integer;
  bultos_alb,bultos_eti:integer;
  jsbody: TJSONObject;
  url:String;
begin
   { if una then
      GeneraBodyUna(tipo,albaran)
    else
      GeneraBody(tipo);    }

    result := '';

    GeneraUrl(StrToInt(id_pedido));
    try
       RESTRequest1.ClearBody;
       jsbody:=TJSONObject.Create();
       RESTRequest1.addbody(jsbody);
       RESTRequest1.Execute;
       estado:=RESTResponse1.StatusCode;
       //GuardaLogApi(rentorno.Nombre, RESTClient1.BaseURL,inttostr(estado),RESTResponse1.StatusText,now);

       if estado<>200 then
       begin
         showmessage('Han ocurrido errores al descargar adjunto: ' + RESTResponse1.StatusText);
       end
       else
       begin
             DameRespuesta(url, attachId);
             if url<>'' then
                if act='P' then   //print
                begin
                    Imprime(url,tipo);
                    result := url;
                end
                else if act='S' then   //save
                        result := Guarda(id_pedido,url,tipo)
                     else if act='L' then    //link
                             Result := url;
       end;
    except

    end;
    jsbody.Free;
end;

function TdmDescargaAttach.ObtenAttach(id_pedido,tipo,act,ruta:string):string;
var
  i,estado:integer;
  bultos_alb,bultos_eti, attachId:integer;
  jsbody: TJSONObject;
  texto:String;
begin
   { if una then
      GeneraBodyUna(tipo,albaran)
    else
      GeneraBody(tipo);    }

    result := '';

    GeneraUrl(StrToInt(id_pedido));
    try
       RESTRequest1.ClearBody;
       jsbody:=TJSONObject.Create();
       RESTRequest1.addbody(jsbody);
       RESTRequest1.Execute;
       estado:=RESTResponse1.StatusCode;
       //GuardaLogApi(rentorno.Nombre, RESTClient1.BaseURL,inttostr(estado),RESTResponse1.StatusText,now);

       if estado<>200 then
       begin
         showmessage('Han ocurrido errores al descargar adjuntos: ' + RESTResponse1.StatusText);
       end
       else
       begin
             DameRespuesta(texto, attachId);
             result := GuardaEn(ruta,id_pedido,texto,tipo);
       end;
    except

    end;
    jsbody.Free;
end;

Procedure TdmDescargaAttach.Descarga;
var
  s: string;
  FileStream: TFileStream;
  fichero:string;

  texto:string;
  Writer: TWriter;
  myStringBuilder: TStringBuilder;
  NFic: textFile;
begin
   {
 "tipo":"a",
 "limit":"2100",
 "ids":["18015450"]
}

  { DameRespuesta(texto);
   if texto<>'' then

     Guarda(texto,'pdf');  }
end;


procedure TdmDescargaAttach.DameRespuesta(var url:string; var attachId:integer);
var
  Sr: TStringReader;
  Reader: TJsonTextReader;
  lista: TStringList;
begin
  url:='';
  attachId := -1;

  if restResponse1.Content<>'' then
  begin
      Sr := TStringReader.Create(restResponse1.Content);
      Reader := TJsonTextReader.Create(Sr);
      while reader.read do
      begin
       case Reader.TokenType of
        TJsonToken.String: begin
          if Pos('url',Reader.Path)>0 then
             url:=Reader.Value.ToString;
          if Pos('attachmentId',Reader.Path)>0 then
             attachId:=StrToInt(Reader.Value.ToString);
       end;

      end;
     end;
     reader.Free;
     sr.Free;
  end;

end;


function TdmDescargaAttach.Guarda(id_pedido,url,tipo:string):string;
var
  MS1: TMemoryStream;
  fichero:string;
  IdHTTP1: TIdHTTP;
begin
  Result := '';
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
        //fichero:=CreateTempFile('');
        fichero:=id_pedido +'.'+tipo;
        try
          ms1.SaveToFile(u_main.dir_temp+IntToStr(u_main.main_cli)+'\'+fichero);
          //shellexecute(Application.handle,'open',Pchar(fichero),nil,nil,sw_show);
          //shellexecute(Application.handle,'print',Pchar(fichero),nil,nil,SW_HIDE);
         //imprimePdf(fichero);
        finally
         //  deletefile(PWidechar(fichero));
        end;
      end;

      Result := u_main.dir_temp+IntToStr(u_main.main_cli)+'\'+fichero;
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

function TdmDescargaAttach.GuardaEn(ruta,id_pedido,url,tipo:string):string;
var
  MS1: TMemoryStream;
  fichero:string;
  IdHTTP1: TIdHTTP;
begin
  Result := '';
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
        //fichero:=CreateTempFile('');
        fichero:=id_pedido +'.'+tipo;
        try
          ms1.SaveToFile(ruta+'\'+fichero);
          //shellexecute(Application.handle,'open',Pchar(fichero),nil,nil,sw_show);
          //shellexecute(Application.handle,'print',Pchar(fichero),nil,nil,SW_HIDE);
         //imprimePdf(fichero);
        finally
         //  deletefile(PWidechar(fichero));
        end;
      end;

      Result := ruta+'\'+fichero;
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

Procedure TdmDescargaAttach.Imprime(url,tipo:string);
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
        //fichero:=CreateTempFile('');
        fichero:=extractfileName(fichero)+'.'+tipo;
        try
          ms1.SaveToFile(fichero);
          //shellexecute(Application.handle,'open',Pchar(fichero),nil,nil,sw_show);
          //shellexecute(Application.handle,'print',Pchar(fichero),nil,nil,SW_HIDE);
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


procedure TdmDescargaAttach.ImprimePdf(fichero:string);
var
  indice:integer;
  OldPrintDialog:TdxPreviewEnableOptions;
begin

  OldPrintDialog:=f_main.dxPrinter.PreviewOptions.EnableOptions;
  f_main.dxPrinter.PreviewOptions.EnableOptions:= [peoCanChangeMargins,peoPageBackground,peoPageSetup,peoPreferences,peoPrint,peoReportDesign];

  if f_main.dxPDF.IsDocumentLoaded then
     f_main.dxPDF.Document.Clear;
  f_main.dxPdf.LoadFromFile(fichero);
  indice:=dxPrintDevice.Printers.IndexOf(u_globals.imp_def);
  dxPrintDevice.PrinterIndex := indice;
  f_main.dxPrinter.Print(false,nil,nil);
  //f_main.dxPrinter.Preview(true);
  deletefile(PWideChar(fichero));
  f_main.dxPrinter.PreviewOptions.EnableOptions:=OldPrintDialog;
end;


function TdmDescargaAttach.CreateTempFile(prefijo:string): string;
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
