unit u_CreateExpedicion;

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
  IdMultipartFormData, System.Types, System.StrUtils;


type
  TdmCreateExpedicion = class(TDataModule)
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
    procedure GeneraBody(tipo:string;id_pedido:integer; dir_dest:string);
    //procedure GeneraBodyUna(tipo,albaran:string);
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
    function CreaExpedicion(const tipo: String; const id_pedido:Integer; dir_dest:string; var texto: String):Boolean;

  end;

const
  _AcceptReferer='https://apptest.loginser.com/';

var
  dmCreateExpedicion: TdmCreateExpedicion;


implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses  u_main, u_globals, u_dm, u_detail, u_functions, u_globals_gestoras;

{$R *.dfm}

procedure TdmCreateExpedicion.DataModuleCreate(Sender: TObject);
begin

   //u_main.ActivaConfigApp;
end;

procedure TdmCreateExpedicion.GeneraBody(tipo:string; id_pedido:integer; dir_dest:string);
var
  jsdests:TJSONArray;
  jsdest:TJSONObject;
  jsbultos:TJSONArray;
  jsbulto:TJSONObject;
  jsdet_bulto:TJSONObject;
  i: integer;
  direccion: TStringDynArray;
begin

   with dm.qUnPedido do
   begin

   Close;
   ParamByName('id_pedido').AsInteger := id_pedido;
   Open;

   jsbody:=TJSONObject.Create();
   jsbody.addPair('fechaServicio', FormatDateTime('yyyymmdd', Now));
   jsbody.AddPair('clienteId',     FieldByName('id_cliente').AsString);
   jsbody.addPair('sedeId','1');
   jsbody.addPair('tipo', tipo);
   jsbody.AddPair('bultos',        TJSONNumber.Create(FieldByName('bultos').AsInteger));
   jsbody.AddPair('peso',          TJSONNumber.Create(FieldByName('peso').AsInteger));
   if tipo='0' then
   begin
      jsbody.AddPair('horarioId',     TJSONNumber.Create(26));
      jsbody.AddPair('tipoServicioId',TJSONNumber.Create(97));
   end else begin

   jsbody.AddPair('horarioId',     TJSONNumber.Create(FieldByName('horario').AsInteger));
   jsbody.AddPair('tipoServicioId',TJSONNumber.Create(FieldByName('tipo_servicio').AsInteger));
   end;

   jsbody.AddPair('orgNombre',      FieldByName('nombre').AsString);
   jsbody.AddPair('orgCalle',       FieldByName('dir_1').AsString);
   jsbody.AddPair('orgPais',       GetPaisGestoras(Trim(FieldByName('pais_code').AsString)));
   jsbody.AddPair('orgLocalidad',  FieldByName('poblacion').AsString);
   //jsbody.AddPair('orgIdlocal',    );
   jsbody.AddPair('orgCodigo',       '-1');
   jsbody.AddPair('orgCodPostal',    FieldByName('cp').AsString);
   jsbody.AddPair('orgContacto',    FieldByName('contacto').AsString);
   jsbody.AddPair('orgProvincia',    FieldByName('provincia').AsString);
   jsbody.AddPair('orgCodProvincia', Copy(FieldByName('cp').AsString,0,2));
   jsbody.AddPair('orgTelefono',     FieldByName('telefono').AsString   );
   jsbody.AddPair('orgNif',          '');
   jsbody.AddPair('orgId',           '');
   jsbody.AddPair('orgDepartamento', '');
   jsbody.AddPair('orgEmail',        FieldByName('email').AsString);
   jsbody.AddPair('orgNotas',        '');
   jsbody.AddPair('orgHDesde',       FormatDateTime('yyyymmdd', Now+1)+'000000');
   jsbody.AddPair('orgHHasta',       FormatDateTime('yyyymmdd', Now+1)+'235959');
   jsbody.AddPair('orgHDesde2',      FormatDateTime('yyyymmdd', Now+1)+'000000');
   jsbody.AddPair('orgHHasta2',      FormatDateTime('yyyymmdd', Now+1)+'235959');
   jsbody.AddPair('reservaAlbaran',  '');
   jsbody.AddPair('albaranCliente',  '');
   jsbody.AddPair('refCliente',      FieldByName('order_name').AsString);
   jsbody.AddPair('refCliente2',      FieldByName('order_name').AsString);
   jsbody.AddPair('importeReembolso', nil );
   jsbody.AddPair('importeDesembolso', nil );
   jsbody.AddPair('importeAsegurado', nil );
   jsbody.AddPair('importePortes', nil );
   jsbody.AddPair('dac', '0'  );
   jsbody.AddPair('pod', '0' );
   jsbody.AddPair('retorno', '0' );
   jsbody.AddPair('contenido', nil );
   jsbody.AddPair('dniNombre', '0' );
   jsbody.AddPair('rcs', '0' );
   jsbody.AddPair('reembolso', nil );

   jsdest:=TJSONObject.Create();

   if tipo='0' then    //recogida
   begin
      if  dir_dest<>'' then
      begin
        direccion := splitstring(get_direccion_completa(u_main.main_cli,StrToInt(dir_dest)),'|');
        jsdest.AddPair('codigo',      dir_dest);
      end
      else begin
        direccion := splitstring(get_direccion_completa(22,-1),'|');
        jsdest.AddPair('codigo',      '-1');
      end;

     jsdest.AddPair('nombre',      direccion[0]);
     jsdest.AddPair('calle',       direccion[1]);
     jsdest.AddPair('codPostal',   direccion[2]);
     jsdest.AddPair('contacto',    direccion[8]);
     jsdest.AddPair('email',       direccion[7]);
     jsdest.AddPair('localidad',   direccion[3]);
     jsdest.AddPair('provincia',   direccion[4]);
     jsdest.AddPair('codProvincia',direccion[10]);
     jsdest.AddPair('telefono',    direccion[5]);
     jsdest.AddPair('telefono2',   direccion[6]);
     jsdest.AddPair('pais',        direccion[9]);    //3 digitos
                    { FieldByName('nombre').AsString        + '|' +
                      FieldByName('calle').AsString         + '|' +
                      FieldByName('cod_postal').AsString    + '|' +
                      FieldByName('localidad').AsString     + '|' +
                      FieldByName('provincia').AsString     + '|' +
                      FieldByName('telefono01').AsString    + '|' +
                      FieldByName('telefono02').AsString    + '|' +
                      FieldByName('email').AsString         + '|' +
                      FieldByName('contacto').AsString      + '|' +
                      FieldByName('pais').AsString          + '|' +
                      FieldByName('cod_provincia').AsString + '|'; }
   end else begin    //envio
     {jsdest.AddPair('nombre',    'Loginser');
     jsdest.AddPair('calle',     'Calle Poniente 10');
     jsdest.AddPair('codPostal', '46394');
     jsdest.AddPair('codigo',    '-1');
     jsdest.AddPair('contacto', 'Almacen');
     jsdest.AddPair('departamento', nil);
     jsdest.AddPair('email', 'desarrollo@loginser.com');
     jsdest.AddPair('localidad', 'Ribarroja del Turia');
     jsdest.AddPair('provincia',        'Valencia');
     //jsdest.AddPair('codProvincia',   '44'    );
     jsdest.AddPair('telefono',         '902108957');
     jsdest.AddPair('telefono2',   nil     );
     jsdest.AddPair('pais',             'ESP');    //3 digitos }
   end;

   jsdest.AddPair('departamento', nil);
   jsdest.AddPair('localId', nil);
   jsdest.AddPair('nif',  nil);
   jsdest.AddPair('observaciones',    FieldByName('observaciones').AsString);
   jsdest.AddPair('importeReembolso', nil );
   jsdest.AddPair('importeDesembolso', nil );
   jsdest.AddPair('importeAsegurado', nil );
   jsdest.AddPair('importePortes', nil );
   jsdest.AddPair('dac', nil  );
   jsdest.AddPair('pod', '0' );
   jsdest.AddPair('retorno', '0' );
   jsdest.AddPair('contenido', nil );
   jsdest.AddPair('dniNombre', '0' );
   jsdest.AddPair('rcs', '0' );

   jsbulto:=TJSONObject.Create();
   jsdet_bulto:=TJSONObject.Create();

   jsbulto.AddPair('numBulto','1');
   jsdet_bulto.addPair('peso',FieldByName('peso').AsString);
   jsdet_bulto.addPair('m3',nil);
   jsdet_bulto.addPair('referencia',nil);
   jsdet_bulto.addPair('codBarras',nil);
   jsdet_bulto.addPair('estadoId','0');
   jsdet_bulto.addPair('x',nil);
   jsdet_bulto.addPair('y',nil);
   jsdet_bulto.addPair('z',nil);
   jsbulto.AddPair('bulto',jsdet_bulto);

   jsdests:= TJSONArray.Create;
   jsbultos:= TJSONArray.Create;
   jsdests.Add(jsdest);
   jsbultos.Add(jsbulto);

   jsdest.addPair('expeditionBultos', jsbultos);
   jsbody.addPair('expeditionDests', jsdests);

  // showmessage(jsbody.ToString);
  end;
end;



procedure TdmCreateExpedicion.ObtenEtiquetas(tipo,albaran:string;una:Boolean=False);
var
  i,estado:integer;
  bultos_alb,bultos_eti:integer;
begin
    //GeneraBody(tipo);

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

Procedure TdmCreateExpedicion.ImprimeEtiquetas;
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




procedure TdmCreateExpedicion.ObtenEtiquetasBack(const tipo:string;const Total_Bultos:Integer; Var Error:String);
var
  i,estado:integer;
  bultos_alb,bultos_eti:integer;
begin
  Error:='';
  try
      //GeneraBody(tipo);
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

Procedure TdmCreateExpedicion.ImprimeEtiquetasBack(const Tipo:String; const Total_Bultos:Integer; var Error:String);
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

Procedure TdmCreateExpedicion.ImprimeEtiqueta(url,tipo:string);
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


procedure TdmCreateExpedicion.ImprimePdf(fichero:string);
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


function TdmCreateExpedicion.CreateTempFile(prefijo:string): string;
// Crea un directorio temporal y devuelve su nombre y camino
 var NewTempName, PathName : array [0..MAX_PATH] of char;
begin
    if (Length (Prefijo) = 0) then
        Prefijo := 'Tmp';
    GetTempPath (MAX_PATH, @PathName); // busca el directorio temporal de Windows
    GetTempFileName (PathName, PChar (Prefijo),0, @NewTempName);//Devuelve el nombre de fichero único
    result := NewTempName;
end;





function TdmCreateExpedicion.CreaExpedicion(const tipo: String; const id_pedido:Integer; dir_dest:string; var texto: String):Boolean;
var
  contentResult, BaseName:String;
  p:TRESTRequestParameter;
  vFormData: TIdMultiPartFormDataStream;
  path_api:string;

  estado: integer;
begin

   GeneraBody(tipo,id_pedido,dir_dest);

   GeneraUrl;

   try
       RESTRequest1.ClearBody;
       RESTRequest1.addbody(jsbody);
       RESTRequest1.Execute;
       estado:=RESTResponse1.StatusCode;

       //GuardaLogApi(rentorno.Nombre, RESTClient1.BaseURL,inttostr(estado),RESTResponse1.StatusText,now);

       Result := ((estado=200) or (estado=201));
       if result then
            DameRespuesta(texto);
       jsbody.Free;
      except

      end;
end;

procedure TdmCreateExpedicion.DameRespuesta(var texto:string);
var
  Sr: TStringReader;
  Reader: TJsonTextReader;
begin
  texto:='';
  if restResponse1.Content<>'' then
  begin
      Sr := TStringReader.Create(dm.restResponse1.Content);
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

procedure TdmCreateExpedicion.GeneraUrl;
var
  BaseUrl:string;
begin
     if api='' then
     begin
        BaseUrl := 'https://server.loginser.com/loginser-back/api/';
     end
     else
        BaseUrl := api;

   BaseURL:= BaseUrl + 'albaran';

   RESTClient1.BaseURL:=BaseUrl;
end;

end.
