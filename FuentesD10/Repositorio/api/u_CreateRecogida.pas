unit u_CreateRecogida;

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
  TdmCreateRecogida = class(TDataModule)
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
  dmCreateRecogida: TdmCreateRecogida;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses  u_main, u_globals, u_dm, u_detail;

{$R *.dfm}

procedure TdmCreateRecogida.DataModuleCreate(Sender: TObject);
begin

   //u_main.ActivaConfigApp;
end;

procedure TdmCreateRecogida.GeneraBody(tipo:String);
var
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

procedure TdmCreateRecogida.GeneraBodyUna(tipo,albaran:string);
var
  jsdests:TJSONArray;
  jsdest:TJSONObject;
  jsbultos:TJSONArray;
  jsbulto:TJSONObject;
  jsdet_bulto:TJSONObject;
  i: integer;
begin
   jsbody:=TJSONObject.Create();

   jsdests:= TJSONArray.Create;
   jsbultos:= TJSONArray.Create;

   jsbody.addPair('fechaServicio', FormatDateTime('yyyymmdd', Now));
   jsbody.AddPair('clienteId',        f_detail.edCliente.Text);
   //jsbody.addPair('sedeId', );
   jsbody.addPair('tipo', '0');
   jsbody.AddPair('bultos',1);
   jsbody.AddPair('peso',1);
   jsbody.AddPair('horarioId',1);
   jsbody.AddPair('tipoServicioId',7);
   jsbody.AddPair('orgNombre',        );
   jsbody.AddPair('orgCalle',        );
   jsbody.AddPair('orgPais',        );
   jsbody.AddPair('orgLocalidad',        );
   jsbody.AddPair('orgIdlocal',        );
   jsbody.AddPair('orgCodigo',        );
   jsbody.AddPair('orgCodPostal',        );
   jsbody.AddPair('orgProvincia',        );
   jsbody.AddPair('orgCodProvincia',        );
   jsbody.AddPair('orgTelefono',        );
   jsbody.AddPair('orgNif',        );
   jsbody.AddPair('orgDepartamento',        );
   jsbody.AddPair('orgEmail',        );
   jsbody.AddPair('orgHDesde',        );
   jsbody.AddPair('orgHHasta',        );
   jsbody.AddPair('orgHDesde2',        );
   jsbody.AddPair('orgHHasta2',        );
   jsbody.AddPair('reservaAlbaran',        );
   jsbody.AddPair('albaranCliente',        );
   jsbody.AddPair('refCliente',        );
   jsbody.AddPair('refCliente2',        );

   jsdest:=TJSONObject.Create();
   jsdest.AddPair('calle', f_detail.ed_dir_1.text);
   jsdest.AddPair('codPostal', f_detail.ed_cp.text);
   //jsdest.AddPair('codigo', );
   //jsdest.AddPair('contacto', );
   jsdest.AddPair('departamento', f_detail.ed_dir_1.text);
   jsdest.AddPair('email', f_detail.ed_cp.text);
   jsdest.AddPair('localidad', f_detail.ed_dir_1.text);
   jsdest.AddPair('localId', f_detail.ed_cp.text);
   //jsdest.AddPair('nif',           );
   jsdest.AddPair('nombre',           f_detail.ed_nombre.text);
   jsdest.AddPair('observaciones',    f_detail.ed_obs.Text);
  // jsdest.AddPair('pais',     usa 3 digitos como en gesrtoras        );
   jsdest.AddPair('provincia',        f_detail.ed_provincia.text);
  //jsdest.AddPair('codProvincia',       );
   jsdest.AddPair('provincia',        f_detail.ed_provincia.text);
   jsdest.AddPair('telefono',         f_detail.ed_telefono.Text);
   //jsdest.AddPair('telefono2',        );
   jsdest.AddPair('telefono',         f_detail.ed_telefono.Text);
   jsdest.AddPair('importeReembolso', nil );
   jsdest.AddPair('importeDesembolso', nil );
  { jsdest.AddPair('importePortes',  );
   jsdest.AddPair('dac',  );
   jsdest.AddPair('pod',  );
   jsdest.AddPair('retorno',  );
   jsdest.AddPair('contenido',  );
   jsdest.AddPair('dniNombre',  );
   jsdest.AddPair('rcs',  );   }

   jsbulto:=TJSONObject.Create();
   jsdet_bulto:=TJSONObject.Create();

   jsbulto.AddPair('numBulto','1');
   jsdet_bulto.addPair('peso',f_detail.edKgs.Text);
   //jsdet_bulto.addPair('m3',);
   //jsdet_bulto.addPair('referencia',);
   //jsdet_bulto.addPair('codBarras',);
   //jsdet_bulto.addPair('estadoId',);
   //jsdet_bulto.addPair('x',);
   //jsdet_bulto.addPair('y',));
   //jsdet_bulto.addPair('z',);


   jsdests.Add(jsdest);



   jsbultos.Add(jsbulto);

   jsbody.AddPair('nombreOrder',      f_detail.ed_order_name.text);

     //jsbody.AddPair('dir1',             );
     jsbody.AddPair('poblacion',        f_detail.ed_poblacion.Text);

    // jsbody.AddPair('cp',               );
     jsbody.AddPair('pais',             f_detail.edPais.Text);
     jsbody.AddPair('paisCode',         f_detail.edCodPais.Text);

     jsbody.AddPair('email',            f_detail.ed_email.Text);
     jsbody.AddPair('company',          f_detail.edCompany.Text);


     jsbody.AddPair('ceco',             f_detail.edCeco.Text);
     jsbody.AddPair('refCliente',       f_detail.edRefCliente.Text);
     jsbody.AddPair('delegacionDestino',f_detail.edDeleg.Text);



     jsbody.AddPair('codAlbaran',       f_detail.ed_codalbaran.text);
     jsbody.AddPair('estado',           f_detail.cb_estado.Text[1]);
     jsbody.AddPair('transporte',       IntToStr(f_detail.rgTransporte.ItemIndex));



   jsbody.addPair('expeditionDests', jsdests);

  // showmessage(jsbody.ToString);
end;

procedure TdmCreateRecogida.GeneraUrl;
var
  BaseUrl:string;
begin
     if api='' then
     begin
        BaseUrl := 'https://servertest.loginser.com:5443/loginser-back/api/';
     end
     else
        BaseUrl := api;

   BaseURL:= BaseUrl + 'albaran';

   RESTClient1.BaseURL:=BaseUrl;
end;

procedure TdmCreateRecogida.ObtenEtiquetas(tipo,albaran:string;una:Boolean=False);
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

Procedure TdmCreateRecogida.ImprimeEtiquetas;
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


procedure TdmCreateRecogida.DameRespuesta(var texto:string);
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

procedure TdmCreateRecogida.ObtenEtiquetasBack(const tipo:string;const Total_Bultos:Integer; Var Error:String);
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

Procedure TdmCreateRecogida.ImprimeEtiquetasBack(const Tipo:String; const Total_Bultos:Integer; var Error:String);
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

Procedure TdmCreateRecogida.ImprimeEtiqueta(url,tipo:string);
var
  s: string;
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


procedure TdmCreateRecogida.ImprimePdf(fichero:string);
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


function TdmCreateRecogida.CreateTempFile(prefijo:string): string;
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
