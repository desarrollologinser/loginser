unit u_main;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, FIBDataSet, pFIBDataSet, FIBQuery, pFIBQuery, FIBDatabase,
  pFIBDatabase, StdCtrls, sButton, Mask, sMaskEdit, sCustomComboEdit, sTooledit,
  sLabel, Vcl.ComCtrls, sStatusBar, System.Win.ComObj, Datasnap.DBClient,


  sSkinProvider, sSkinManager, sGroupBox, inifiles,jpeg,
  JvDBGrid, IdHTTP, Winapi.ShellAPI, sEdit, sBitBtn, IdMultipartFormData,
  sGauge, sPanel, sdialogs,strutils,types,System.DateUtils,
  sPageControl,Data.DBXJSONCommon, Data.DBXJSON,
  sRadioButton,registry, sCheckBox,  Vcl.Grids, Vcl.DBGrids,
  JvExDBGrids, Vcl.Buttons, Vcl.ExtCtrls,
  sComboBox, frxClass, frxDBSet, frxBarcode,
  sSpeedButton,adodb,printers,winspool,
  Vcl.ImgList, Winapi.ActiveX, IdFTP, IdFTPCommon,
  acImage, Vcl.DBCtrls, JvDBImage, System.ImageList, json,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinOffice2016Colorful,
  dxSkinOffice2016Dark, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, dxPDFDocument, dxBarBuiltInMenu, dxPSGlbl, dxPSUtl,
  dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider,
  dxPSFillPatterns, dxPSEdgePatterns, dxPSPDFExportCore, dxPSPDFExport,
  cxDrawTextUtils, dxPSPrVwStd, dxPSPrVwAdv, dxPSPrVwRibbon,
  dxPScxPageControlProducer, dxPSdxPDFViewerLnk, dxPScxEditorProducers,
  dxPScxExtEditorProducers, dxPSCore, cxClasses, dxCustomPreview, dxPDFViewer,
  acProgressBar, frxExportPDF;

type
  Tstock = record
    id_art:Integer;
    uds:Integer;

    id_ubic:Integer;
    id_lote:Integer;
    caducidad:TDate;
  end;

  Tform1 = class(TForm)
    sknmngr1: TsSkinManager;
    sknprvdr1: TsSkinProvider;
    rep_db_pick: TfrxDBDataset;
    rep_db_bultos: TfrxDBDataset;
    rep_log: TfrxReport;
    rep_asm: TfrxReport;
    il1: TImageList;
    devo_nac: TfrxReport;
    devo_int: TfrxReport;
    il2: TImageList;
    frdevo: TfrxReport;
    q1: TpFIBDataSet;
    blbfldq1logo: TBlobField;
    ds1: TDataSource;
    db_1: TfrxDBDataset;
    rep_db_lotes: TfrxDBDataset;
    rep_pick: TfrxReport;
    dxprinter: TdxComponentPrinter;
    link: TdxPDFViewerReportLink;
    dl_open: TsOpenDialog;
    dxPDF: TdxPDFViewer;
    stat1: TStatusBar;
    gb_1: TsGroupBox;
    lb_picking: TsLabel;
    b_picking: TsBitBtn;
    gb_12: TsGroupBox;
    lb_agrupa: TsLabel;
    sb_1: TsBitBtn;
    cb_prev: TsCheckBox;
    cb_one_read_marks_all: TsCheckBox;
    cb_art_un_bulto: TsCheckBox;
    cb_send_email: TsCheckBox;
    cb_indiv_2040: TsCheckBox;
    gb_cajas: TsGroupBox;
    lb_cajas: TsLabel;
    lb_caja_a: TsLabel;
    lb_caja_b: TsLabel;
    lb_caja_c: TsLabel;
    lb_3: TsLabel;
    lb_caja_d: TsLabel;
    bt_cerrar_agrup: TsSpeedButton;
    bt_print_bultos: TsSpeedButton;
    lb_caja_e: TsLabel;
    g_agr: TJvDBGrid;
    gb_resto: TsGroupBox;
    bt_cerrar_caja: TsSpeedButton;
    bt_print_prev: TsSpeedButton;
    bt_cambio: TsSpeedButton;
    bt_imp_pick: TsSpeedButton;
    rg_caja: TsRadioGroup;
    cb_maxcubic: TsCheckBox;
    btnHECTOR: TsButton;
    gb_pack: TsGroupBox;
    ed_cb: TsEdit;
    gb_error: TsGroupBox;
    lb_ean: TsLabel;
    lb_st: TsLabel;
    bt_add: TsBitBtn;
    gb_asig: TsGroupBox;
    lb_asig: TsLabel;
    lb_asig_art: TsLabel;
    lb_caja: TsLabel;
    lb_albaran: TsLabel;
    lb_cajas_st: TsLabel;
    lb_asig_lote: TsLabel;
    pg_1: TsPageControl;
    ts_3: TsTabSheet;
    pn_im: TsPanel;
    gestim: TImage;
    ts_1: TsTabSheet;
    bt_lectura_manual: TsSpeedButton;
    gr_grid: TJvDBGrid;
    ts_2: TsTabSheet;
    bt_print_indiv: TsSpeedButton;
    bt1: TsSpeedButton;
    gr_grid2: TJvDBGrid;
    rep_db_indiv: TfrxDBDataset;
    rep_eti: TfrxReport;
    rep_mensy: TfrxReport;
    frxDBDataset1: TfrxDBDataset;
    frxReport1: TfrxReport;
    frxReport2: TfrxReport;
    frxDBDataset2: TfrxDBDataset;
    rep_correos: TfrxReport;
    rep_pick2: TfrxReport;
    pdf_export: TfrxPDFExport;
    fr_asm: TfrxReport;
    procedure FormShow(Sender: TObject);
    function busca_art(cod_cli:string; id_cliente:integer):integer;   overload;
    function busca_art_nom(id:integer):string;
    function ruta_escritorio:string;
    function format_cp(cp:string):string;
    function busca_art_ref(id:integer):string;
    function siguiente_laboral(fecha:TDateTime):tdate;
    function es_festivo(fecha:TDateTime):Boolean;
    function busca_art_nom_cod(codigo:string):string;
    procedure imprime_eti_bulto_lgs(codalbaran:integer);
    function imprime_eti_bulto_asm(codalbaran,delivery_time:integer):string;
    function limpiachar(frase: string):string;
    function linea_asm(codalbaran,delivery_time:Integer):string;
    function get_cp_ext(poblacion:string):string;
    procedure bt_2Click(Sender: TObject);
    function imprime_eti_bulto_correos(codalbaran:integer):string;
    function imprime_eti_bulto_chrono(codalbaran,delivery_time:integer):string;
    function LeerHexa(fichero: string) : string;
    function Zeros(c: string; l: Integer): string;
    function Espacios(cadena: string; l: Integer): string;
    function WriteRawDataToPrinter(PrinterName: String; Str: String): Boolean;
    function linea_correos(codalbaran: Integer): string;
    procedure bt2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    function busca_art(codigo:string):integer;  overload;
    function JSONPost(text:string;LI:boolean):string;
    procedure GuardaEtiqueta(pedido:Integer;txt:string);
    procedure InsertaLote(pedido, art, lote, cantidad, id_pick, l_pick: Integer);
    procedure AbreFichero(ruta:string);
    function GetConexion(nombre:string):string;
  public
    { Public declarations }
    procedure ImprimeEtiqueta(f,orientacion:string);
    procedure Imprime(f,orientacion:string);
    function rellena_detalle_pedido:string;
    procedure enviar_email_pedidos;
    procedure CargarDatosCorreos;
    function Articulo_con_IMEI(id_articulo:Integer):Boolean;
    function CargarDatosAgencia(campos: string; cliente, agencia:Integer):string;
    function BuscaClienteGesFile(codigo:integer):string;
    function LoadFieldConfigCLiente(campos: string; cliente:Integer):string;
    function get_chrono_bulto(cp:integer):string;
    Function calc_digcon_chrono(codbar:string):Integer;
    function get_chrono_exp(codalbaran:integer):string;
    procedure get_defaults;
    function ubic_entrada(id_alm:Integer):Integer;
    procedure InsertaPedido(id_pedido,id_cliente, deliv_time, trans_propio, id_repartidor, deleg, service_ref, con_retorno:Integer;
                                id_order,order_name,nombre,dir,poblacion,provincia,cp,pais,pais_code,telefono,email,text,track,observaciones,
                                financial_status, fulfillment_status, gateway, company, tags, note, cancel_reason, estado, contacto:string;
                                fecha_ped, cancel_date:TDateTime; reemb:Double);
    procedure InsertaPedidoLine(id_pedido,id_line,id_articulo,cantidad:integer; sku, nombre_art:string);
    procedure GeneraUrlValidate(id_albaran:integer);
    procedure RegeneraBultos(id_albaran: integer);
  end;

const
  ALERTA = '';
  {Listo: puede crearse exe
   Vacio: hay algo en desarrollo y no se puede crear exe}

  sep2='|';
  sep1='$';
  httpweb='http://www.loginser.com/sync/';
  tab=Chr(9);
  cli_inf_asm = '99999';
  delivery_default = 24;
  path_pdf_correos = 'http://www.loginser.com/sync/Operadores/Correos/labels/';
  agencia_correos = 6;
  error_no_version = 'Este pedido no puede ser gestionado desde esta versión de la aplicación.';

  v='[2.0]';
  //[2.0] Cambio a Delphi 10. Interfaz.


var
  form1: Tform1;
  hiloactivo:Boolean;
  htmldevuelto:string;

  imp_eti: string;
  imp_def: string;

  ar_stock:array of Tstock;                    //stock
  idx_stock:Integer=0;

  locked:Boolean; //0,1
  delivery_time, id_almacen: integer;
  default_deleg: string;
  path_files_imp, cli_inf_asm_cl, email_asm: string;
  transporte_propio, repartidor, estado_alb:integer;
  email_reexp, prefijo_reexp, path_reexp: string;
  tiene_lotes, tiene_imei, es_oxfam: Boolean;
  main_cli:integer;  //Cliente que se va a usar para calcular los parametros durante todo el proceso,
                     //Si se trabaja por cliente será el id del cliente y si se trabaja por grupo
                     //será el principal del grupo (tabla g_grupos_cliente)

  correos_etiquetador, correos_contrato, correos_cliente, txt_tpropio: string;
  jpg: TJPEGImage;

  db_sql: string;

  ar_pick:array of Tstock;                      //pick
  idx_pick:Integer=0;

  cubic_a,cubic_b,cubic_c,cubic_d,cubic_e:integer;
  ncajas_a,ncajas_b,ncajas_c,ncajas_d,ncajas_e,ncajas_x:integer;
  uds_resto:integer;
  col_order: Integer;
  order_desc: Boolean=False;
  desktop: string;
  pack_abierto: integer;
  id_usuario : Integer;
  en_grabacion : Integer;
  stock_min : integer;
  peds_en_cadena: Integer;
  peds_encadenados: string;
  tiene_albs_gestoras: Boolean=True;

  excel, xls, libro: Variant;
  hoja:OleVariant;

  horario_cl, servicio_cl: integer;

  percent_cubic: integer;
implementation

uses u_dm,  u_gen_gl, u_envia_mail, u_globals_gestoras,
  u_globals;

{$R *.dfm}


{$REGION 'Ini-Close'}
procedure Tform1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dm.t_read.Active := False;
end;

procedure Tform1.FormCreate(Sender: TObject);
begin
  if (ALERTA<>'LISTO') then
      ShowMessage('CUIDADO!!!!! PROYECTO EN DESARROLLO!!!! AVISA A INFORMATICA!!!');

  leer_ini;

  ini_bd_simple;

  lee_inis_def;
  if db_sql<>'' then
  begin
     // dm.con1.Connected := False;
      dm.con1.ConnectionString := db_sql;
      //dm.con1.Connected := True;
  end;

  get_defaults;

  leer_ini_bbdd(u_globals.id_usuario);

                                                            //si no tiene posicion por defecto
  if u_globals.x<0 then u_globals.x:=(Screen.width-width) div 2;
  if u_globals.y<0 then u_globals.y:=(Screen.height-height) div 2;
  {if u_globals.w<0 then u_globals.w:=Width;
  if u_globals.h<0 then u_globals.h:=height;   }

  left:=u_globals.x;                                          //asigna posicion
  top:=u_globals.y;
 { Width:=u_globals.w;
  Height:=u_globals.h;   }

  caption:=u_globals.hint+' - '+u_globals.usuario+' ('+u_globals.permiso+')'+' - '+u_globals.empresa + ' ' + v;

  u_globals.pc_name:=u_globals.GetComputerName;

  cb_maxcubic.Caption:='Cierre Automático Por Porcentaje Cúbico al '+inttostr(percent_cubic)+'%';
end;

procedure Tform1.FormShow(Sender: TObject);
var
  usuario,r: string;
begin

  //if not(dm.db.Connected) then dm.db.Connected:=true;


  api := GetConexion(api);

  if api='' then
  begin
    ShowMessage('IMPORTANTE: Revise la configuración de API en su fichero Config.ini (api=API_TEST o API_PRO).' + #10#13 +
                'La aplicación se cerrará.');
    Application.Terminate;
  end;

  usuario := GetEnvironmentVariable('UserName');


  locked := False;

  form1.Caption := 'GESTIÓN PEDIDOS DE ALMACÉN ' + v;
  stat1.Panels[0].Text := dbname + ' ** ' +
                   db_gestoras + ' ** ' +
                   api;

  jpg := TJPEGImage.Create;
  //filter;

  en_grabacion := get_estado_valor('en_grabacion');

end;


{$ENDREGION}

{$REGION 'Aux'}
function Tform1.format_cp(cp:string):string;
begin
  if Length(cp)<5 then result:='0'+cp
  else result:=cp;
end;

function Tform1.busca_art(cod_cli:string; id_cliente:integer):integer;
begin                                       //devuelve id de articulo a partir de codigo de cliente y cliente
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select id_articulo from g_articulos where codigo_cli=:codigo_cli '+
      ' and id_cliente=:id_cliente');
    ParambyName('codigo_cli').asstring:=cod_cli;
    ParambyName('id_cliente').asinteger:=id_cliente;
    Open;

    if not(IsEmpty) then Result:=FieldByName('id_articulo').asinteger
    else result:=-1;

    Free;
  end;
end;

function Tform1.busca_art(codigo:string):integer;
begin                                       //devuelve id de articulo a partir de codigo
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select id_articulo from g_articulos where codigo=:codigo');
    ParambyName('codigo').asstring:=codigo;
    Open;

    if not(IsEmpty) then Result:=FieldByName('id_articulo').asinteger
    else result:=-1;

    Free;
  end;
end;

function tform1.busca_art_ref(id:integer):string;
begin                                       //devuelve referencia de articulo a partir de id
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select codigo from g_articulos where id_articulo='+inttostr(id));
    Open;

    if not(IsEmpty) then Result:=FieldByName('codigo').asstring
    else result:='ERR';

    Free;
  end;
end;

function tform1.busca_art_nom(id:integer):string;
begin                                       //devuelve nombre de articulo a partir de id
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select nombre from g_articulos where id_articulo='+inttostr(id));
    Open;

    if not(IsEmpty) then Result:=FieldByName('nombre').asstring
    else result:='ERR';

    Free;
  end;
end;

function Tform1.busca_art_nom_cod(codigo:string):string;
begin                                       //devuelve nombre de articulo a partir de referencia
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select nombre from g_articulos where codigo=:codigo');
    ParambyName('codigo').asstring:=codigo;
    Open;

    if not(IsEmpty) then Result:=FieldByName('nombre').asstring
    else result:='';

    Free;
  end;
end;

function tform1.ruta_escritorio:string;
var
  sEscritorio: String;
  Registro: TRegistry;
begin
  sEscritorio:='';
  Registro := TRegistry.Create;

  // Leemos la ruta del escritorio
  try
    Registro.RootKey := HKEY_CURRENT_USER;                                     

    if Registro.OpenKey( '\Software\Microsoft\Windows\CurrentVersion\explorer\Shell Folders', True ) then
      sEscritorio := Registro.ReadString( 'Desktop' );
  finally
    Registro.CloseKey;
    Registro.Free;
  end;

  result:=sEscritorio;
end;



function Tform1.WriteRawDataToPrinter(PrinterName: String; Str: String): Boolean;
var
  PrinterHandle: THandle;
  DocInfo: TDocInfo1;
  i: Integer;
  B: Byte;
  Escritos: DWORD;
begin
  Result:= FALSE;
  if OpenPrinter(PChar(PrinterName), PrinterHandle, nil) then
  try
    FillChar(DocInfo,Sizeof(DocInfo),#0);
    with DocInfo do
    begin
      pDocName:= PChar('Printer Test');
      pOutputFile:= nil;
      pDataType:= 'RAW';
    end;
    if StartDocPrinter(PrinterHandle, 1, @DocInfo) <> 0 then
    try
      if StartPagePrinter(PrinterHandle) then
      try
        while Length(Str) > 0 do
        begin
          if Copy(Str, 1, 1) = '\' then
          begin
            if Uppercase(Copy(Str, 2, 1)) = 'X' then
              Str[2]:= '$';
            if not TryStrToInt(Copy(Str, 2, 3),i) then
              Exit;
            B:= Byte(i);
            Delete(Str, 1, 3);
          end else B:= Byte(Str[1]);
          Delete(Str,1,1);
          WritePrinter(PrinterHandle, @B, 1, Escritos);
        end;
        Result:= TRUE;
      finally
        EndPagePrinter(PrinterHandle);
      end;
    finally
      EndDocPrinter(PrinterHandle);
    end;
  finally
    ClosePrinter(PrinterHandle);
  end;
end;


procedure Tform1.ImprimeEtiqueta(f, orientacion:string);
var
   ClienteFTP: TIdFTP;
   i: Integer;
   s: string;
begin
  try
  ClienteFTP := TIdFTP.Create(nil);
      with ClienteFTP do
      begin
        Passive := True;
        TransferType := ftBinary;
        Host :=  '217.160.237.154';
        Username := 'u62588198';
        Password := 'xzj2004MN4+';
        //if (Username = '') or (Password = '') then
        //	Result := 'No se han encontrado los datos de acceso en la configuración global de la tarea';
      end;
     // ClientesFTP.AddOrSetValue(Tarea.Id, ClienteFTP);

     // ClienteFTP := ClientesFTP[Tarea.Id];
      if ClienteFTP.Connected then
        ClienteFTP.Disconnect;

      // Conectamos al FTP y obtenemos la lista de ficheros pendientes
      ClienteFTP.Connect;
      ClienteFTP.ChangeDir('/sync/Operadores/Correos/labels/');
      ClienteFTP.DirectoryListing.DirectoryName := '/sync/Operadores/Correos/labels/';
      ClienteFTP.List();

      if not (f='') then
      begin
         ClienteFTP.Get('/sync/Operadores/Correos/labels/' + f,'c:\temp\'+ f,True);
         Imprime('c:\temp\' + f, orientacion);
         //shellExecute(0, 'open', 'acrord32', PChar('/p /h ' + 'c:\temp\' + f), nil, SW_HIDE);
         //shellExecute(0, 'Printto', PChar('/h /t ' + 'c:\temp\' + f),'ZDesigner', 0, SW_HIDE);
         //DeleteFile('c:\temp\' + s);
      end else begin
          // Por cada fichero...
          for i := 0 to ClienteFTP.DirectoryListing.Count - 1 do
          begin
             if ExtractFileExt(ClienteFTP.DirectoryListing.Items[i].FileName)='.pdf' then
             begin
                s := ClienteFTP.DirectoryListing.Items[i].FileName;
                ClienteFTP.Get('/sync/Operadores/Correos/labels/' + s,'c:\temp\' + s,True);
                Imprime('c:\temp\' + s,orientacion);
                //shellExecute(0, 'open', 'acrord32', PChar('/p /h ' + 'c:\temp\' + s), nil, SW_HIDE);
                //shellExecute(0, 'Printto', PChar('/h /t ' + 'c:\temp\' + s),'ZDesigner', 0, SW_HIDE);
             end;
          end;
      end;

      //pdf.FileName :=   'http://www.loginser.com/sync/Operadores/Correos/labels/PQ13X50700000490146394K.pdf';
      //WriteRawDataToPrinter('ZDesigner','N A0,0,0,1,1,1,N,"hola mundo"');
      //CopyFile('http://www.loginser.com/sync/Operadores/Correos/labels/PQ13X50700000490146394K.pdf','c:\isa.pdf',false);
      //shellExecute(0, 'open', 'acrord32', PChar('/p /h ' + 'c:\isa.pdf'), nil, SW_HIDE);
      //shellExecute(0, 'open', 'acrord32', PChar('/p /h ' +'c:\example.pdf'), nil, SW_HIDE);
  finally
     ClienteFTP.Free;
  end;

end;

function Tform1.siguiente_laboral(fecha:TDateTime):tdate;
var n_fecha:TDate;
begin
  n_fecha:=incday(fecha,1);

  while es_festivo(n_fecha) do n_fecha:=incday(n_fecha,1);

  result:=n_fecha;
end;

function Tform1.es_festivo(fecha:TDateTime):Boolean;         //true=dia festivo false=dia no festivo
var fiesta:Boolean;
begin
  with tpfibdataset.create(Self) do
  try
    Database:=dm.db;
    sqls.SelectSQL.Add('select fecha '+
      'from g_festivos '+
      'where fecha=:fecha and id_empresa=:id_empresa and estado<''B'' ');
    ParamByName('fecha').Asdate:=fecha;
    ParamByName('id_empresa').AsInteger:=1;
    Open;

    if isempty then fiesta:=false
      else fiesta:=true;
  finally
    Free;
  end;

  if not(fiesta) then
    if ((DayOfWeek(fecha)=1) or (DayOfWeek(fecha)=7)) then fiesta:=true;           //domingo o sabado

  result:=fiesta;
end;



procedure Tform1.get_defaults;
begin
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select * from a_aux');
    Open;

    if not(IsEmpty) then begin
      cubic_a:=FieldByName('cubic_a').asinteger;
      cubic_b:=FieldByName('cubic_b').asinteger;
      cubic_c:=FieldByName('cubic_c').asinteger;
      cubic_d:=FieldByName('cubic_d').asinteger;
      cubic_e:=FieldByName('cubic_e').asinteger;
      ncajas_a:=FieldByName('cajas_a_agrup').asinteger;
      ncajas_b:=FieldByName('cajas_b_agrup').asinteger;
      ncajas_c:=FieldByName('cajas_c_agrup').asinteger;
      ncajas_d:=FieldByName('cajas_d_agrup').asinteger;
      ncajas_e:=FieldByName('cajas_e_agrup').asinteger;
      ncajas_x:=FieldByName('cajas_x_agrup').asinteger;
      uds_resto:=fieldbyname('uds_resto').AsInteger;
    end else begin
      cubic_a:=69000;
      cubic_b:=28500;
      cubic_c:=22500;
      cubic_d:=18200;
      cubic_e:=9100;
      ncajas_a:=36;
      ncajas_b:=54;
      ncajas_c:=54;
      ncajas_d:=54;
      ncajas_e:=54;
      ncajas_x:=40;
      uds_resto:=200;
    end;
    Free;
  end;

//  lb_max_a.caption:=IntToStr(cubic_a);
//  lb_max_b.caption:=IntToStr(cubic_b);
//  lb_max_c.caption:=IntToStr(cubic_c);
//  lb_max_d.caption:=IntToStr(cubic_d);
//  lb_max_e.caption:=IntToStr(cubic_e);
//  lb_cajas_a.caption:=IntToStr(ncajas_a);
//  lb_cajas_b.caption:=IntToStr(ncajas_b);
//  lb_cajas_c.caption:=IntToStr(ncajas_c);
//  lb_cajas_d.caption:=IntToStr(ncajas_d);
//  lb_cajas_e.caption:=IntToStr(ncajas_e);
//  lb_cajas_x.caption:=IntToStr(ncajas_x);
//  lb_resto.Caption:=IntToStr(uds_resto);
end;

function Tform1.ubic_entrada(id_alm:Integer):Integer;
begin
  case id_alm of
    1:Result:=361;          //W-1-1 en alm1
    2:result:=3758;          //W-1-1 en alm2
    3:result:=4802;          //W-1-1 en alm2
    4:Result:=3778;          //W-1-1 en alm4
    5:result:=3776;          //W-1-1 en alm5
    6:result:=5532;          //W-1-1 en alm6
    7:result:=9579;          //W-1-1 en alm7
  end;
end;

{$ENDREGION}



{$REGION 'Bultos'}
procedure Tform1.imprime_eti_bulto_lgs(codalbaran:integer);
const cr=Chr(13);
      lr=Chr(10);
var   codrepartidor,dst_coddel,bulto:Integer;    pdf417,codigopostal,poblacion,ch_codbulto,cliente_chrono,producto_chrono,s:string;
      lf:Char;
      graf1, graf2, graf3, graf4, graf5, graf6, graf7, cadena: string;
      fichero: TextFile;
begin
  dm.q_sql2.Close;
  dm.q_sql2.Connection := dm.con1;
  dm.q_sql2.SQL.Clear;
  dm.q_sql2.SQL.Add('select * from albaranes where codalbaran=:codalbaran');
  dm.q_sql2.parameters.parambyname('codalbaran').value:=codalbaran;
  dm.q_sql2.Open;

  codrepartidor:=dm.q_sql2.FieldByName('codrepartidor').AsInteger;
  poblacion:=dm.q_sql2.FieldByName('dst_localidad').AsString;
  codigopostal:=Trim(dm.q_sql2.FieldByName('dst_cp').AsString);
  dst_coddel:=dm.q_sql2.FieldByName('dst_coddel').asinteger;

  dm.cds_bultos.Close;
  dm.cds_bultos.Active:=true;
  dm.cds_bultos.EmptyDataSet;

  for bulto:=1 to dm.q_sql2.FieldByName('bultos').asinteger do begin      //etiqueta para cada bulto
    dm.cds_bultos.Insert;

    dm.cds_bultos.FieldByName('id_caja').AsInteger:=0;
    dm.cds_bultos.FieldByName('tipo_caja').asstring:='';
    dm.cds_bultos.FieldByName('codcli').AsInteger:=dm.q_sql2.FieldByName('codcli').AsInteger;
    dm.cds_bultos.FieldByName('codalbaran').AsInteger:=codalbaran;
    dm.cds_bultos.FieldByName('unidades').AsInteger:=dm.q_sql2.FieldByName('paquetes').AsInteger;;
    dm.cds_bultos.FieldByName('fecha').AsDateTime:=dm.q_sql2.FieldByName('fecha').AsDateTime;
    dm.cds_bultos.FieldByName('codruta').AsInteger:=dm.q_sql2.FieldByName('codruta').AsInteger;
    dm.cds_bultos.FieldByName('coddst').AsString:=FormatFloat('0000',dm.q_sql2.FieldByName('dst_codcli').AsInteger)+formatfloat('0000',dm.q_sql2.FieldByName('dst_coddel').AsInteger);
    dm.cds_bultos.fieldbyname('dst_nombre').asstring:=dm.q_sql2.fieldbyname('dst_nombre').asstring;
    dm.cds_bultos.fieldbyname('dst_calle').asstring:=dm.q_sql2.fieldbyname('dst_calle').asstring;
    dm.cds_bultos.fieldbyname('dst_cp').asstring:=FormatFloat('00000',StrToInt(codigopostal));
    dm.cds_bultos.fieldbyname('dst_localidad').asstring:=dm.q_sql2.fieldbyname('dst_localidad').asstring;
    dm.cds_bultos.fieldbyname('dst_provincia').asstring:=dm.q_sql2.fieldbyname('dst_provincia').asstring;
    dm.cds_bultos.FieldByName('bultos').AsInteger:=dm.q_sql2.fieldbyname('bultos').asinteger;;
    dm.cds_bultos.FieldByName('observaciones').AsString:=dm.q_sql2.fieldbyname('observaciones').AsString;
    dm.cds_bultos.FieldByName('dst_tfno').AsString:=dm.q_sql2.FieldByName('dst_tfno').AsString;
    dm.cds_bultos.FieldByName('dst_coddel').AsString:=dm.q_sql2.FieldByName('dst_coddel').AsString;
    dm.cds_bultos.FieldByName('dst_persona').AsString:=dm.q_sql2.FieldByName('dst_persona').AsString;
    dm.cds_bultos.FieldByName('ordenbulto').asinteger:=bulto;
    dm.cds_bultos.FieldByName('codrepartidor').AsInteger:=codrepartidor;
    dm.cds_bultos.fieldbyname('org_nombre').asstring:= dm.q_sql2.fieldbyname('org_nombre').asstring;
    dm.cds_bultos.fieldbyname('org_calle').asstring:= dm.q_sql2.fieldbyname('org_calle').asstring;
    dm.cds_bultos.fieldbyname('org_cp').asstring:= dm.q_sql2.fieldbyname('org_cp').asstring;
    dm.cds_bultos.fieldbyname('org_localidad').asstring:= dm.q_sql2.fieldbyname('org_localidad').asstring;
    dm.cds_bultos.fieldbyname('org_provincia').asstring:= dm.q_sql2.fieldbyname('org_provincia').asstring;
    dm.cds_bultos.FieldByName('org_tfno').AsString:= dm.q_sql2.FieldByName('org_tfno').AsString;
    dm.cds_bultos.FieldByName('reembolso').AsString:= dm.q_sql2.FieldByName('reembolso').AsString;
    dm.cds_bultos.FieldByName('referencia').AsString:= '';
    dm.cds_bultos.FieldByName('kgs').AsString:=dm.q_sql2.FieldByName('Kgs').AsString;
    if dm.q_sql2.FieldByName('pdebido').AsFloat <= 0 then
       dm.cds_bultos.FieldByName('sempor').AsString:='PAGADOS' else dm.cds_bultos.FieldByName('sempor').AsString:='DEBIDOS';

    dm.cds_bultos.FieldByName('codbulto').AsString:='';

    pdf417:=
        limpiachar(FormatDateTime('dd-mm-aaaa',dm.cds_bultos.FieldByName('fecha').AsDateTime)) + cr +
        limpiachar(dm.cds_bultos.FieldByName('codcli').AsString) + cr +
        limpiachar(dm.cds_bultos.fieldbyname('org_nombre').asstring) + cr +
        limpiachar(dm.cds_bultos.fieldbyname('org_calle').asstring) + cr +
        limpiachar(dm.cds_bultos.fieldbyname('org_cp').asstring) + cr +
        limpiachar(dm.cds_bultos.fieldbyname('org_localidad').asstring) + cr +
        limpiachar(dm.cds_bultos.FieldByName('org_tfno').AsString) + cr +
        limpiachar(dm.cds_bultos.fieldbyname('dst_nombre').asstring) + cr +
        limpiachar(dm.cds_bultos.fieldbyname('dst_calle').asstring) + cr +
        limpiachar(codigopostal) + cr +
        limpiachar(dm.cds_bultos.fieldbyname('dst_localidad').asstring) + cr +
        limpiachar(dm.cds_bultos.FieldByName('dst_tfno').AsString) + cr +
        limpiachar(dm.cds_bultos.FieldByName('dst_persona').AsString) + cr +
        limpiachar(dm.cds_bultos.fieldbyname('codalbaran').Asstring) + cr +
        limpiachar(dm.cds_bultos.FieldByName('dst_coddel').AsString) + cr +
        limpiachar(dm.cds_bultos.FieldByName('kgs').AsString) + cr +
        dm.cds_bultos.FieldByName('ordenbulto').AsString + cr +
        dm.cds_bultos.FieldByName('bultos').AsString;

    dm.cds_bultos.FieldByName('pdf417').AsString:=pdf417;

    dm.cds_bultos.Post;
  end;

  rep_log.PrintOptions.Printer:=imp_eti;
  if rep_log.PrepareReport(True) then rep_log.print;
end;


function Tform1.imprime_eti_bulto_asm(codalbaran,delivery_time:integer):string;
const cr=Chr(13);
      lr=Chr(10);
var   codrepartidor,dst_coddel,bulto,s1,s2,dc:Integer;    pdf417,codigopostal,poblacion,ch_codbulto,cliente_chrono,producto_chrono,s, cli_bc:string;
      lf:Char;
      graf1, graf2, graf3, graf4, graf5, graf6, graf7, cadena: string;    asm_correo,asm_horario,asm_codcli,bc:string;
      fichero: TextFile;
begin
  dm.q_sql2.Close;

  dm.q_sql2.SQL.Clear;
  dm.q_sql2.SQL.Add('select * from albaranes where codalbaran=:codalbaran');
  dm.q_sql2.parameters.ParamByName('codalbaran').Value:=codalbaran;
  dm.q_sql2.Open;

  if not dm.q_sql2.IsEmpty then
  begin
      codrepartidor:=dm.q_sql2.FieldByName('codrepartidor').AsInteger;
      poblacion:=dm.q_sql2.FieldByName('dst_localidad').AsString;
      codigopostal:=Trim(dm.q_sql2.FieldByName('dst_cp').AsString);
      dst_coddel:=dm.q_sql2.FieldByName('dst_coddel').asinteger;
    // obtengo delegacion para ASM
    //
      dm.qrytemp.Close;
      dm.qrytemp.SQLs.SelectSQL.Clear;
      dm.qrytemp.SQLs.SelectSQL.Add('select top 1 d.id_del as id_del,d.nombre as nombre '+                    //qrym
      ' from asm_deleg d '+
      ' inner join asm_cp c on ((d.id_del = c.id_del) and (d.id_subdel=c.id_subdel)) '+
      ' where c.cp = '+codigopostal+' and c.pais = 34');
      dm.qrytemp.Open;
    //
    // obtengo tipo de envio para ASM
    //

      asm_codcli:= IntToStr(main_cli);
      asm_correo:='COURIER';

      case delivery_time of
        10: asm_horario:='ASM10';
        14: asm_horario:='ASM14';
        24: asm_horario:='ASM24';
        72: asm_horario:='ECONOMY';
      end;

      cli_bc := '';

      dm.cds_bultos.Close;
      dm.cds_bultos.Active:=true;
      dm.cds_bultos.EmptyDataSet;

      for bulto:=1 to dm.q_sql2.FieldByName('bultos').asinteger do begin      //etiqueta para cada bulto
        dm.cds_bultos.Insert;

        dm.cds_bultos.FieldByName('id_caja').AsInteger:=0;
        dm.cds_bultos.FieldByName('tipo_caja').asstring:='';
        dm.cds_bultos.FieldByName('codcli').AsInteger:=dm.q_sql2.FieldByName('codcli').AsInteger;
        dm.cds_bultos.FieldByName('codalbaran').AsInteger:=codalbaran;
        dm.cds_bultos.FieldByName('unidades').AsInteger:=dm.q_sql2.FieldByName('paquetes').AsInteger;;
        dm.cds_bultos.FieldByName('fecha').AsDateTime:=dm.q_sql2.FieldByName('fecha').AsDateTime;
        dm.cds_bultos.FieldByName('codruta').AsInteger:=dm.q_sql2.FieldByName('codruta').AsInteger;
        //dm.cds_bultos.FieldByName('coddst').AsString:=FormatFloat('0000',dm.q_sql2.FieldByName('dst_codcli').AsInteger)+formatfloat('0000',dm.q_sql2.FieldByName('dst_coddel').AsInteger);
        dm.cds_bultos.FieldByName('coddst').AsString:=asm_codcli+formatfloat('0000',dm.q_sql2.FieldByName('dst_coddel').AsInteger);
        dm.cds_bultos.fieldbyname('dst_nombre').asstring:=dm.q_sql2.fieldbyname('dst_nombre').asstring;
        dm.cds_bultos.fieldbyname('dst_calle').asstring:=dm.q_sql2.fieldbyname('dst_calle').asstring;
        dm.cds_bultos.fieldbyname('dst_cp').asstring:=FormatFloat('00000',StrToInt(codigopostal));
        dm.cds_bultos.fieldbyname('dst_localidad').asstring:=dm.q_sql2.fieldbyname('dst_localidad').asstring;
        dm.cds_bultos.fieldbyname('dst_provincia').asstring:=dm.q_sql2.fieldbyname('dst_provincia').asstring;
        dm.cds_bultos.FieldByName('bultos').AsInteger:=dm.q_sql2.fieldbyname('bultos').asinteger;;
        dm.cds_bultos.FieldByName('observaciones').AsString:=dm.q_sql2.fieldbyname('observaciones').AsString;
        dm.cds_bultos.FieldByName('dst_tfno').AsString:=dm.q_sql2.FieldByName('dst_tfno').AsString;
        dm.cds_bultos.FieldByName('dst_coddel').AsString:=dm.q_sql2.FieldByName('dst_coddel').AsString;
        dm.cds_bultos.FieldByName('dst_persona').AsString:=dm.q_sql2.FieldByName('dst_persona').AsString;
        dm.cds_bultos.FieldByName('ordenbulto').asinteger:=bulto;
        dm.cds_bultos.FieldByName('codrepartidor').AsInteger:=codrepartidor;
        dm.cds_bultos.fieldbyname('org_nombre').asstring:= dm.q_sql2.fieldbyname('org_nombre').asstring;
        dm.cds_bultos.fieldbyname('org_calle').asstring:= dm.q_sql2.fieldbyname('org_calle').asstring;
        dm.cds_bultos.fieldbyname('org_cp').asstring:= dm.q_sql2.fieldbyname('org_cp').asstring;
        dm.cds_bultos.fieldbyname('org_localidad').asstring:= dm.q_sql2.fieldbyname('org_localidad').asstring;
        dm.cds_bultos.fieldbyname('org_provincia').asstring:= dm.q_sql2.fieldbyname('org_provincia').asstring;
        dm.cds_bultos.FieldByName('org_tfno').AsString:= dm.q_sql2.FieldByName('org_tfno').AsString;
        dm.cds_bultos.FieldByName('reembolso').AsString:= dm.q_sql2.FieldByName('reembolso').AsString;
        dm.cds_bultos.FieldByName('referencia').AsString:= '';
        dm.cds_bultos.FieldByName('kgs').AsString:=dm.q_sql2.FieldByName('Kgs').AsString;
        if dm.q_sql2.FieldByName('pdebido').AsFloat <= 0 then
           dm.cds_bultos.FieldByName('sempor').AsString:='PAGADOS' else dm.cds_bultos.FieldByName('sempor').AsString:='DEBIDOS';

        dm.cds_bultos.FieldByName('asm_correo').AsString:= asm_correo;
        dm.cds_bultos.FieldByName('asm_horario').AsString:= asm_horario;
        dm.cds_bultos.FieldByName('asm_codcli').AsString:= asm_codcli;
        dm.cds_bultos.FieldByName('asm_mnemo').AsString:= dm.qrytemp.FieldByName('id_del').AsString;
        dm.cds_bultos.FieldByName('asm_pobla').AsString:= dm.qrytemp.FieldByName('nombre').AsString;
        dm.cds_bultos.FieldByName('asm_bc_human').AsString:='31-' + cli_inf_asm_cl + '-' +formatfloat('0000000',codalbaran);
        dm.cds_bultos.FieldByName('asm_tracking').AsString:='31' + cli_inf_asm_cl + formatfloat('0000000',codalbaran);
        bc:='31'+cli_inf_asm_cl+formatfloat('0000000',codalbaran)+formatfloat('000',bulto);
        s1:=strtoint(bc[1])+strtoint(bc[3])+strtoint(bc[5])+strtoint(bc[7])+strtoint(bc[9])+strtoint(bc[11])+strtoint(bc[13])+strtoint(bc[15])+strtoint(bc[17]);
        s2:=strtoint(bc[2])+strtoint(bc[4])+strtoint(bc[6])+strtoint(bc[8])+strtoint(bc[10])+strtoint(bc[12])+strtoint(bc[14])+strtoint(bc[16]);
        s1:=s1*3;
        s1:=s1+s2;
        dc:=0;
        while ((s1+dc) mod 10)<>0 do inc(dc);
        dm.cds_bultos.FieldByName('asm_bc').AsString:=bc+formatfloat('0',dc);

        dm.cds_bultos.FieldByName('codbulto').AsString:='';

        pdf417:=
            limpiachar(FormatDateTime('dd-mm-aaaa',dm.cds_bultos.FieldByName('fecha').AsDateTime)) + cr +
            limpiachar(dm.cds_bultos.FieldByName('codcli').AsString) + cr +
            limpiachar(dm.cds_bultos.fieldbyname('org_nombre').asstring) + cr +
            limpiachar(dm.cds_bultos.fieldbyname('org_calle').asstring) + cr +
            limpiachar(dm.cds_bultos.fieldbyname('org_cp').asstring) + cr +
            limpiachar(dm.cds_bultos.fieldbyname('org_localidad').asstring) + cr +
            limpiachar(dm.cds_bultos.FieldByName('org_tfno').AsString) + cr +
            limpiachar(dm.cds_bultos.fieldbyname('dst_nombre').asstring) + cr +
            limpiachar(dm.cds_bultos.fieldbyname('dst_calle').asstring) + cr +
            limpiachar(codigopostal) + cr +
            limpiachar(dm.cds_bultos.fieldbyname('dst_localidad').asstring) + cr +
            limpiachar(dm.cds_bultos.FieldByName('dst_tfno').AsString) + cr +
            limpiachar(dm.cds_bultos.FieldByName('dst_persona').AsString) + cr +
            limpiachar(dm.cds_bultos.fieldbyname('codalbaran').Asstring) + cr +
            limpiachar(dm.cds_bultos.FieldByName('dst_coddel').AsString) + cr +
            limpiachar(dm.cds_bultos.FieldByName('kgs').AsString) + cr +
            dm.cds_bultos.FieldByName('ordenbulto').AsString + cr +
            dm.cds_bultos.FieldByName('bultos').AsString;

        dm.cds_bultos.FieldByName('pdf417').AsString:=pdf417;

        dm.cds_bultos.Post;
      end;


      rep_db_bultos.DataSet:= dm.cds_bultos;
      //rep_asm.DataSet := rep_db_bultos;
      rep_asm.PrintOptions.Printer:=imp_eti;
      if rep_asm.PrepareReport(True) then rep_asm.print;

      result:=dm.cds_bultos.FieldByName('asm_tracking').AsString;
  end else
        ShowMessage('No existe el albarán ' + IntToStr(codalbaran));
end;


function Tform1.imprime_eti_bulto_chrono(codalbaran,delivery_time:integer):string;
var
  lf, s: string;

begin
 {     lf:=chr(10);             //line feed
      s:='';
      s:=s+'N'+lf;
      s:=s+'OD'+lf;
      s:=s+'q816'+lf;
      s:=s+'Q?'+lf;
      s:=s+'S6'+lf;
      s:=s+'D13'+lf;
      s:=s+'ZT'+lf;
      s:=s+'A150,100,3,1,2,2,N,"'+dm.cds_bultos.FieldByName('id_caja').asstring+'-'+dm.cds_bultos.FieldByName('tipo_caja').asstring+'"'+lf;
      s:=s+'A460,1155,3,1,2,2,N,"COD.BULTO:'+dm.cds_bultos.FieldByName('codbulto').asstring+'"'+lf;
      s:=s+'B770,410,1,1,4,2,256,N,"'+dm.cds_bultos.FieldByName('codbulto').asstring+'"'+lf;
      s:=s+'A30,1155,3,1,2,1,N,"'+cliente_chrono+' LOGINSER '+dm.cds_bultos.fieldbyname('org_nombre').asstring+'"'+lf;
      s:=s+'A60,1155,3,1,1,1,N,"'+dm.cds_bultos.fieldbyname('org_calle').asstring+'"'+lf;
      s:=s+'A80,1155,3,1,1,1,N,"'+dm.cds_bultos.fieldbyname('org_localidad').asstring+'"'+lf;
      s:=s+'A80,830,3,1,1,1,N,"Telf.:'+dm.cds_bultos.FieldByName('org_tfno').AsString+'"'+lf;
      s:=s+'LO95,650,4,500'+lf;
      s:=s+'A120,1155,3,3,2,3,N,"DESTINATARIO"'+lf;
      s:=s+'A160,1155,3,1,2,1,N,"'+dm.cds_bultos.fieldbyname('dst_nombre').asstring+'"'+lf;
      s:=s+'A200,1155,3,1,1,1,N,"ATT: '+dm.cds_bultos.FieldByName('dst_persona').AsString+'"'+lf;
      s:=s+'A220,1155,3,1,1,1,N,"TELF.: '+dm.cds_bultos.FieldByName('dst_tfno').AsString+'"'+lf;
      s:=s+'A240,1155,3,2,2,1,N,"'+dm.cds_bultos.fieldbyname('dst_calle').asstring+'"'+lf;
      s:=s+'A280,1155,3,3,3,6,N,"'+dm.cds_bultos.fieldbyname('dst_cp').asstring+'"'+lf;

      s:=s+'A400,1155,3,1,2,1,N,"'+dm.cds_bultos.fieldbyname('dst_localidad').asstring+'"'+lf;
      s:=s+'A440,1155,3,1,1,2,N,"REF: '+dm.cds_bultos.FieldByName('chrono_ref').AsString+'"'+lf;
      s:=s+'A340,1155,3,3,2,3,N,"'+dm.cds_bultos.FieldByName('dst_coddel').AsString+'"'+lf;
     // s:=s+'A340,1155,3,3,2,3,N,"<<PAIS>>"'+lf;
      s:=s+'LO430,590,4,600'+lf;
      s:=s+'A350,500,3,1,1,1,N,"OBSERVACIONES:"'+lf;
      s:=s+'A380,500,3,1,1,1,N,"'+dm.cds_bultos.FieldByName('observaciones').AsString+'"'+lf;
    //  writeln(f,'A410,500,3,1,1,1,N,"<<OBSER2>>"'+lf;

      s:=s+'A50,550,3,1,2,2,N,"EXP:'+dm.cds_bultos.FieldByName('chrono_exp').AsString+'"'+lf;
      s:=s+'A700,360,3,1,1,1,N,"PESO:"'+lf;
      s:=s+'A730,360,3,1,1,2,N,"'+formatfloat('0.000',dm.cds_bultos.FieldByName('kgs').asfloat)+' Kgs."'+lf;
      s:=s+'A640,360,3,1,1,1,N,"BULTOS:"'+lf;
      s:=s+'A670,360,3,1,2,2,N,"'+dm.cds_bultos.FieldByName('ordenbulto').asstring+' de '+dm.cds_bultos.FieldByName('bultos').Asstring+'"'+lf;
      s:=s+'A460,360,3,1,1,1,N,"PRODUCTO: "'+lf;
      s:=s+'A490,360,3,1,1,2,N,"'+producto_chrono+'"'+lf;
      s:=s+'A520,360,3,1,1,1,N,"REEMBOLSO:"'+lf;
      s:=s+'A550,360,3,1,1,2,N,"'+dm.cds_bultos.FieldByName('reembolso').AsString+'"'+lf;
      s:=s+'A580,360,3,1,1,1,N,"TIPO DE PORTES:"'+lf;
      s:=s+'A610,360,3,1,2,2,N,"'+dm.cds_bultos.FieldByName('sempor').AsString+'"'+lf;
      s:=s+'A80,520,3,1,1,1,N,"Envio retorno: "'+lf;
      s:=s+'A760,360,3,3,1,1,N,"FECHA:'+formatdatetime('dd/mm/yyyy',dm.cds_bultos.FieldByName('fecha').AsDateTime)+'"'+lf;
      s:=s+'A250,41,0,3,2,2,N,"'+producto_chrono+'"'+lf;
      s:=s+'b100,600,P,800,600,s5,f0,x2,y7,l9,t0,o3,"'+dm.cds_bultos.FieldByName('pdf417').AsString+'"'+lf;
      s:=s+'P1'+lf;
      s:=s+'N'+lf;

      WriteRawDataToPrinter(u_globals.imp_eti,s);   }

      end;

function Tform1.imprime_eti_bulto_correos(codalbaran:integer):string;
const cr=Chr(13);
      lr=Chr(10);
var   codrepartidor,dst_coddel,bulto:Integer;    pdf417,codigopostal,poblacion,ch_codbulto,cliente_chrono,producto_chrono,s,cod_bulto:string;
      lf:Char;
      graf1, graf2, graf3, graf4, graf5, graf6, graf7, cadena: string;
      fichero: TextFile;
begin
  graf1:=LeerHexa('correos.hex');                   //lee logos hexadecimal
  graf2:=LeerHexa('paq72.hex');
  graf3:=LeerHexa('LOGINSER.hex');
  graf4:=LeerHexa('DOMICILIO.hex');
  graf5:=LeerHexa('paq48.hex');
  graf6:=LeerHexa('economico.hex');
  graf7:=LeerHexa('pagado.hex');

  dm.q_sql2.Close;
  dm.q_sql2.SQL.Clear;
  dm.q_sql2.SQL.Add('select * from albaranes where codalbaran=:codalbaran');
  dm.q_sql2.parameters.parambyname('codalbaran').value:=codalbaran;
  dm.q_sql2.Open;

  with tpfibdataset.Create(dm) do                            //Codigo Bulto y expedicion
  try
    database:=dm.db;

    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select BARCODE from CORREOS_BARCODE(:codalbaran, :dst_cp)');
    ParamByName('codalbaran').AsInteger:=codalbaran;
    ParamByName('dst_cp').asstring:=dm.q_sql2.FieldByName('dst_cp').asstring;
    Open;

    if not(IsEmpty) then begin
      cod_bulto:=FieldByName('barcode').asstring;
    end else cod_bulto:='';

  finally
    free;
  end;

  dm.cds_bultos.Close;
  dm.cds_bultos.Active:=true;
  dm.cds_bultos.EmptyDataSet;

  for bulto:=1 to dm.q_sql2.fieldbyname('bultos').asinteger do begin                  //etiqueta para cada bulto
      // Asignar impresora de red si es USB
    cadena:='~DGR:CORREOS.GRF,01980,9,'+graf1;        // Carga gráficos en memoria de impresora
    cadena:=cadena+'~DGR:PAQ72.GRF,0902,11,'+graf2+cr+lr;
    cadena:=cadena+'~DGR:LOGINSER.GRF,1700,10,'+graf3+cr+lr;
    cadena:=cadena+'~DGR:DOMICILIO.GRF,585,9,'+graf4+cr+lr;
    cadena:=cadena+'~DGR:PAQ48.GRF,0990,11,'+graf5+cr+lr;
    cadena:=cadena+'~DGR:ECO.GRF,0630,7,'+graf6+cr+lr;
    cadena:=cadena+'~DGR:PAGADO.GRF,15296,32,'+graf7+cr+lr;

    cadena:=cadena+'^XA^PW1000'+cr+lr;
    cadena:=cadena+'^FO720,120^XGR:CORREOS.GRF,1,1^FS'+cr+lr;  // Imprime gráficos LOGOS

    //**********************************************************************************
    cadena:=cadena+'^FO700,390^XGR:PAQ72.GRF,1,1^FS'+cr+lr;
    //cadena:=cadena+'^FO700,390^XGR:PAQ48.GRF,1,1^FS'+cr+lr;
    //*********************************************************************************

    cadena:=cadena+'^FO640,540^XGR:LOGINSER.GRF,1,1^FS'+cr+lr;
    cadena:=cadena+'^FO320,940^XGR:DOMICILIO.GRF,2,2^FS'+cr+lr;

    cadena:=cadena+'^CI27'+cr+lr;; // Cambia el banco de caracteres a un banco con tildes y letras Ñ ñ

    cadena:=cadena+'^FO400,100 ^A0N,30,25^FDDestinatario         Remitente^FS'+cr+lr;   // Texto
    cadena:=cadena+'^FO678,140 ^ADR,18,10^FD'+dm.q_sql2.fieldbyname('org_nombre').asstring+'^FS'+cr+lr;  // Remitente
    cadena:=cadena+'^FO656,140 ^ADR,18,10^FD'+dm.q_sql2.fieldbyname('org_calle').asstring+'^FS'+cr+lr;
    cadena:=cadena+'^FO634,140 ^ADR,18,10^FD'+dm.q_sql2.fieldbyname('org_cp').asstring+'-'+dm.q_sql2.fieldbyname('org_localidad').asstring+'^FS'+cr+lr;   // CPOSTAL???
    cadena:=cadena+'^FO612,140 ^ADR,18,10^FD'+dm.q_sql2.fieldbyname('org_provincia').asstring+'^FS'+cr+lr;

    cadena:=cadena+'^FO550,140 ^ADR,18,10^FD-----------------------------------------^FS';
    cadena:=cadena+'^FO495,140 ^ADR,18,10^FD'+dm.q_sql2.fieldbyname('dst_nombre').asstring+'^FS'+cr+lr;            //Destinatario
    cadena:=cadena+'^FO473,140 ^ADR,18,10^FD'+dm.q_sql2.fieldbyname('dst_calle').asstring+'^FS'+cr+lr;
    cadena:=cadena+'^FO451,140 ^ADR,24,18^FD'+dm.q_sql2.fieldbyname('dst_cp').asstring+'-'+dm.q_sql2.fieldbyname('dst_localidad').asstring+'^FS'+cr+lr;
    cadena:=cadena+'^FO429,140 ^ADR,24,18^FD'+dm.q_sql2.fieldbyname('dst_provincia').asstring+'^FS'+cr+lr;
    cadena:=cadena+'^FO407,140 ^ADR,18,10^FDTeléfono:'+dm.q_sql2.FieldByName('dst_tfno').AsString+'^FS'+cr+lr;
    cadena:=cadena+'^FO385,140 ^ADR,18,10^FDObservaciones^FS'+cr+lr;
    cadena:=cadena+'^FO363,140 ^ADR,18,10^FD'+dm.q_sql2.FieldByName('observaciones').AsString+'^FS'+cr+lr;
    cadena:=cadena+'^FO340,140 ^ADR,18,10^FD-----------------------------------------^FS'+cr+lr;

    cadena:=cadena+'^FO300,130 ^A0R,30,25^FDCódigo bulto: '+cod_bulto+'^FS'+cr+lr;            // código de barras ser humano
    cadena:=cadena+'^FO780,770 ^A0R,30,25^FDExpedición: '+''{dm.cds_bultos.FieldByName('codexpedicion').asstring}+'^FS'+cr+lr;            // expedición ser humano

    cadena:=cadena+'^FO310,720 ^ADN,20,12^FDValores^FS'+cr+lr;                        // Texto
    cadena:=cadena+'^FO310,740 ^ADN,20,12^FDAñadidos^FS'+cr+lr;                       // Texto
    cadena:=cadena+'^FO310,760 ^ADN,20,12^FD----------^FS'+cr+lr;                     // Texto

    cadena:=cadena+'^FO270,920 ^ADR,18,10^FDBulto:^FS'+cr+lr;                        //
    cadena:=cadena+'^FO248,920 ^ADR,18,10^FD'+inttostr(bulto)+'^FS'+cr+lr;              //
    cadena:=cadena+'^FO216,920 ^ADR,18,10^FDPeso:^FS'+cr+lr;                    //
    cadena:=cadena+'^FO194,920 ^ADR,18,10^FD'+formatfloat('0.000',dm.q_sql2.FieldByName('kgs').asfloat)+'Kgs.^FS'+cr+lr;   //

    cadena:=cadena+'^FWR'+cr+lr;
    cadena:=cadena+'^FO70,120'+cr+lr;
    cadena:=cadena+'^BY3'+cr+lr;
    cadena:=cadena+'^POA'+cr+lr;
    cadena:=cadena+'^BCR, 220, N, N, N, A^FD'+cod_bulto+'^FS'+cr+lr;                     // código de barras C128

    pdf417:='0000';                                                     // código etiquetador, 4
    pdf417:=pdf417+espacios(cod_bulto,23);      // Codigo envío, 23
    pdf417:=pdf417+Zeros(dm.q_sql2.FieldByName('bultos').AsString,2);        // Número de bultos, 2
    pdf417:=pdf417+Zeros(inttostr(bulto),2);    // orden bulto,2
    pdf417:=pdf417+espacios(dm.q_sql2.fieldbyname('dst_nombre').asstring,36);    // nombre destinatario, 36
    pdf417:=pdf417+espacios(' ',15);                                   // nif destinatario, 15
    pdf417:=pdf417+espacios(dm.q_sql2.fieldbyname('dst_calle').asstring,72);     // dirección destinatario, 72
    pdf417:=pdf417+espacios(dm.q_sql2.fieldbyname('dst_localidad').asstring,25); // localidad destinatario, 25
    pdf417:=pdf417+Zeros(dm.q_sql2.fieldbyname('dst_cp').asstring,5);        // cp destinatario, 5
    pdf417:=pdf417+'00';                                                          // modo entrega 2
    pdf417:=pdf417+formatfloat('00.00',dm.q_sql2.FieldByName('kgs').asfloat); // peso 5
    pdf417:=pdf417+'000000';                                                        // importe seguro 6
    pdf417:=pdf417+'000000';                                                        // importe reembolso 6
    pdf417:=pdf417+'00000000000000000000';                                          // número cuenta 20
    pdf417:=pdf417+' ';                                                             // Entrega exclusiva  1
    pdf417:=pdf417+'  ';                                                            // formato de prueba 2
    pdf417:=pdf417+'000000000';                                                     // SMS destinatario 9
    pdf417:=pdf417+'000000000';                                                     // SMS remitente 9
    pdf417:=pdf417+'0';                                                             // idioma remitente 1
    pdf417:=pdf417+'0';                                                             // idioma destinatario 1
    pdf417:=pdf417+'   ';                                                           // Devolucion, reparto, entrega 3
    pdf417:=pdf417+'0';                                                             // tipo menvío 1
    pdf417:=pdf417+'  ';                                                            // DUA 2
    pdf417:=pdf417+espacios(dm.q_sql2.fieldbyname('org_nombre').asstring,36);   //Nombre remitente 36
    pdf417:=pdf417+espacios(' ',15);                                                //Nif remitente
    pdf417:=pdf417+espacios(dm.q_sql2.fieldbyname('org_calle').asstring,72);    // dirección remitente, 72
    pdf417:=pdf417+espacios(dm.q_sql2.fieldbyname('org_localidad').asstring,25);// localidad remitente, 25
    pdf417:=pdf417+Zeros(dm.q_sql2.fieldbyname('org_cp').asstring,5);           // cp remitente, 5
    pdf417:=pdf417+'000000';                                                        // apartado reembolso 6
    pdf417:=pdf417+'00000';                                                         // importe pagado 5
    pdf417:=Copy(pdf417,1,416);

    cadena:=cadena+'^FO590,735'+cr+lr;
    cadena:=cadena+'^BY3'+cr+lr;
    cadena:=cadena+'^B7R,7,5,,,N^FD'+pdf417+'^FS'+cr+lr;                 // código de barras 2D PDF417

    cadena:=cadena+'^XZ'+cr+lr;

    WriteRawDataToPrinter(imp_eti,cadena);
  end;

  result:=cod_bulto;
end;

function Tform1.limpiachar(frase: string):string;
var  s:string; i:integer;
begin
  s:='';
  for i:=1 to Length(frase) do
    if (((ord(frase[i])>=40) and (ord(frase[i])<=57)) or
        ((ord(frase[i])>=65) and (ord(frase[i])<=90)) or
        ((ord(frase[i])>=97) and (ord(frase[i])<=122))) then s:=s+frase[i]
    else s:=s+' ';
  result:=s;
end;

function tform1.LeerHexa(fichero: string) : string;
var F:TextFile;
  sLinea, temp, parte, resultado, hexa: string;
  puntero, contador: Integer;
begin
  // Todas las imágenes son bitmaps de un solo color convertidos a valores decimales separados por comas
  // Esta función convierte los decimales a hexadecimales para enviarlos a la impresora
  //
  fichero:=ExtractFilePath(Application.ExeName)+'logos\'+fichero;
  AssignFile( F, fichero);
  Reset( F );
  temp:='';
  while not Eof( F ) do
  begin
    ReadLn( F, sLinea );
    temp:=temp+sLinea;
  end;
  CloseFile( F );
  resultado:='';
  contador:=1;
  while True do
  begin
    puntero:=Pos(',',temp);
    if puntero>0 then
    begin
      parte:=Trim(Copy(temp,1,puntero-1));
    end else
    begin
      parte:=Trim(Copy(temp,1,Length(temp)));
    end;
    hexa:=IntToHex(strtoint(parte),2);
    resultado:=resultado+hexa;
    if puntero=0 then Break;
    Delete(temp,1,puntero);
    Inc(contador);
  end;
  //
  Result:=resultado;
end;

function tform1.Zeros(c: string; l: Integer): string;
var i: Integer;
begin
  c:=Trim(c);
  l:=l-Length(c);
  for i := 1 to l do c:='0'+c;

  Result := c;
end;

function Tform1.Espacios(cadena: string; l: Integer): string;
var longitud: Integer;
begin
  cadena:=Trim(cadena);
  longitud:=Length(cadena);
  if longitud<l then
  begin
    //cadena:=cadena+System.StrUtils.DupeString(' ', (l-longitud));                     ****************
  end;
  cadena:=Copy(cadena,1,l);
end;


{$ENDREGION}

{$REGION 'Envia Ficheros'}
procedure Tform1.bt_2Click(Sender: TObject);
begin
  //ShowMessage(imprime_eti_bulto_correos(481093));
end;


function Tform1.linea_asm(codalbaran,delivery_time:Integer):string;                   //Genera Linea para ASM
var   s,su_linea,tmp:string;  dst_pais,dst_cp,asm_codcli,asm_servicio,asm_horario:integer;
begin
  s:='';

  asm_codcli := main_cli;

  if delivery_time=24 then begin
    asm_servicio:=1;
    asm_horario:=3;
  end else if delivery_time=14 then begin
              asm_servicio:=1;
              asm_horario:=2;
           end else if delivery_time=10 then begin
                        asm_servicio:=1;
                        asm_horario:=0;
                     end else if delivery_time=72 then begin
                                asm_servicio:=37;
                                asm_horario:=4;
                              end else begin
                                          asm_servicio:=37;
                                          asm_horario:=4;
                                        end;

  with tadoquery.create(self) do                                      //Su Linea
  try
    connection:= dm.con1;
    sql.Add('select sulinea '+
		  'from servicios_lineas '+
		  'where codalbaran=:codalbaran');
    Parameters.ParamByName('codalbaran').Value:=codalbaran;
    Open;

    if not(IsEmpty) then su_linea:=FieldByName('sulinea').asstring
      else su_linea:='';
  finally
    free;
  end;

  with tadoquery.create(self) do                         //Genera Linea
  try
    connection:= dm.con1;
    sql.Add('select * from albaranes where codalbaran=:codalbaran');
    Parameters.ParamByName('codalbaran').Value:=codalbaran;
    Open;

    if not(IsEmpty) then begin
      dst_pais:=34;
      if Trim(FieldByName('dst_cp').asstring)='' then begin
        tmp:=get_cp_ext(FieldByName('dst_localidad').asstring);
        if Trim(tmp)='' then dst_cp:=0
          else dst_cp:=strtoint(tmp);
        dst_pais:=351;
      end else dst_cp:=StrToInt(Trim(FieldByName('dst_cp').AsString));

      s:='1|'+                                                                  //Tipo
         '31' + cli_inf_asm_cl + formatfloat('0000000',codalbaran)+'|'+                       //Cod Barras
         '461|'+                                                                //Cod Plaza Origen
         FormatFloat('000000',codalbaran)+'|'+                                  //Albaran
         Copy(FieldByName('org_nombre').AsString,1,40)+'|'+                     //Org Nombre
         Copy(FieldByName('org_calle').AsString,1,40)+'|'+                      //Org Calle
         Copy(FieldByName('org_localidad').AsString,1,40)+'|'+                  //Org Localidad
         Copy(FieldByName('org_provincia').AsString,1,40)+'|'+                  //Org Provincia
         '34|'+                                                                 //Org Pais
         FormatFloat('00000',FieldByName('org_cp').asinteger)+'|'+              //Org CP
         Copy(FieldByName('org_tfno').AsString,1,10)+'|'+                       //Org Telefono
         Copy(FieldByName('org_coddel').AsString,1,4)+'|'+                      //Org Dpto
         '|'+                                                                   //Org NIF
         '|'+                                                                   //Org Observaciones
         FormatDateTime('dd/mm/yyyy',date)+'|'+                                 //Fecha
         '461|'+                                                                //PlzCli
         formatfloat('000000',asm_codcli)+'|'+                                  //CodCli
         'P|'+                                                                  //Portes
         '0,00|'+                                                               //Deb
         '0,00|'+                                                               //Reem
         Copy(FieldByName('dst_nombre').AsString,1,40)+'|'+                     //Dst Nombre
         Copy(FieldByName('dst_calle').AsString,1,40)+'|'+                      //Dst Direc
         Copy(FieldByName('dst_localidad').AsString,1,40)+'|'+                  //Dst Poblac
         Copy(FieldByName('dst_provincia').AsString,1,40)+'|'+                  //Dst Provin
         IntToStr(dst_pais)+'|'+                                                //Dst Pais
         FormatFloat('00000',dst_cp)+'|'+                                       //Dst CP
         Copy(FieldByName('dst_tfno').AsString,1,10)+'|'+                       //Dst Telefono
         '|'+                                                                   //Dst Dpto
         '|'+                                                                   //Dst NIF
         Copy(su_linea+'-'+trimleft(FieldByName('observaciones').AsString),1,100)+'|'+    //Dst Observaciones
         IntToStr(asm_servicio)+'|'+                                            //Servicio
         IntToStr(asm_horario)+'|'+                                             //Horario
         FormatFloat('0000',FieldByName('bultos').asinteger)+'|'+               //Bultos
         FormatFloat('0.000',FieldByName('kgs').asfloat)+'|'+                   //Kgs
         '0.0000|'+                                                             //m3
         '0|'+                                                                  //CodValija
         '5315||N||||||||||||N|||'+                                             //Agente y varios....
         '31' + cli_inf_asm_cl +formatfloat('0000000',codalbaran)+'||0|0|||||||';            //Cod Barras Agrupacion y varios...
    end else s:='ERROR LEYENDO ALBARAN '+inttostr(codalbaran);
  finally
    free;
  end;

  result:=s;
end;


function Tform1.linea_correos(codalbaran: Integer): string;
const sep=char(9);
var s,cod_bulto,dst_cp,n_exp,manif:string;
begin


  with tadoquery.create(self) do                         //Genera Linea
  try
    connection:= dm.con1;
    sql.Add('select * from albaranes where codalbaran=:codalbaran');
    Parameters.ParamByName('codalbaran').Value:=codalbaran;
    Open;
    dst_cp:=FieldByName('dst_cp').AsString;

    with tpfibdataset.Create(dm) do                            //Codigo Bulto y expedicion
    try
      database:=dm.db;

      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select BARCODE from CORREOS_BARCODE(:codalbaran, :dst_cp)');
      ParamByName('codalbaran').AsInteger:=codalbaran;
      ParamByName('dst_cp').asstring:=dst_cp;
      Open;

      if not(IsEmpty) then begin
        cod_bulto:=FieldByName('barcode').asstring;
      end else cod_bulto:='';

      close;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('SELECT codexpedicion FROM correos_codexpedicion(:codalbaran)');
      ParamByName('codalbaran').AsInteger:=codalbaran;
      Open;

      if not(IsEmpty) then begin
        n_exp:=FieldByName('codexpedicion').asstring;
      end else n_exp:='';

      close;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('SELECT manifiesto FROM CORREOS_MANIFIESTO(current_date)');
      Open;

      if not(IsEmpty) then begin
        manif:=FieldByName('manifiesto').asstring;
      end else n_exp:='';
    finally
      free;
    end;

    if not(IsEmpty) then begin
      s:='2013v001'+sep+                                      //formato fichero
          'S0132'+sep+                                        //codigo producto
          'FP'+sep+                                           //tipo franqueo
          '13X5'+sep+                                         //codigo etiquetador
          sep+sep+sep+sep+
          cod_bulto+sep+                                      //codigo envio
          n_exp+sep+                                          //n expedicion
          sep+sep+
          FieldByName('bultos').AsString+sep+                 //total bultos
          '1'+sep+                                            //numero de bulto (confuso)
          manif+sep+                                          //num manifiesto
          sep+sep+
          Copy(FieldByName('dst_nombre').AsString,1,50)+sep+  //nombre destino
          sep+sep+sep+sep+sep+sep+
          Copy(FieldByName('dst_calle').AsString,1,50)+sep+     //direccion
          sep+sep+sep+sep+sep+sep+
          Copy(FieldByName('dst_localidad').AsString,1,25)+sep+  //localidad
          Copy(FieldByName('dst_provincia').AsString,1,50)+sep+  //provincia
          dst_cp+sep+                                             //cp
          sep+sep+sep+sep+sep+
          Copy(FieldByName('dst_tfno').AsString,1,12)+sep+  //telefono
          sep+
          IntToStr(codalbaran)+sep+                             //referencia cliente
          'ST'+sep+                                           //modalidad entrega
          IntToStr(Round(FieldByName('kgs').asfloat*1000))+sep+ //kgs en gramos
          StringOfChar(sep,61)+
          Copy(FieldByName('org_nombre').AsString,1,50)+sep+  //nombre origen
          sep+sep+sep+sep+sep+sep+
          Copy(FieldByName('org_calle').AsString,1,50)+sep+     //direccion
          sep+sep+sep+sep+sep+sep+
          Copy(FieldByName('org_localidad').AsString,1,25)+sep+  //localidad
          Copy(FieldByName('org_provincia').AsString,1,50)+sep+  //provincia
          Copy(FieldByName('org_cp').AsString,1,5)+sep+  //cp
          sep+sep+sep+'E';
    end else s:='ERROR LEYENDO ALBARAN '+inttostr(codalbaran);
  finally
    free;
  end;

  result:=s;
end;

function Tform1.get_cp_ext(poblacion:string):string;               //Saca CP de la poblacion (para envios al extranjero)
var
 fin:Boolean;
 s:string;
 t:char;
 n,i:Integer;
begin
  s:='';
  fin:=False;
  n:=1;
  while not(fin) do begin
    t:=poblacion[n];
    if ((Ord(t) >= 48) and (Ord(t) <= 57)) then
      s:=s+copy(poblacion,n,1);
    if n = Length(poblacion) then fin:=True;
    if Length(s)=5 then fin:=True;
    inc(n);
  end;
  Result:=s;
end;
{$ENDREGION}

{$REGION 'Web'}

procedure Tform1.bt2Click(Sender: TObject);
var      codalb,codservicio,codmovimiento,ruta,bultos:integer;       s, texto:string;    kgs:double;
begin

end;


procedure Tform1.enviar_email_pedidos;
var
  ruta, dest, asunto:string;         email:Tf_envia_mail;      cuerpo:tstrings;
begin
    try
        u_gen_gl.lee_inis_def;      //lee defs de tablas aux

        cuerpo:=tstringlist.Create;
        cuerpo.add('<head><meta charset="UTF-8">' +
                     '<style>' +
                       'table {font-family: "Quicksand", "Trebuchet MS";}' +
                       'tbody th {color: #0B2161;font-family: "Quicksand", "Trebuchet MS";font-size: 18px;}' +
                       'tbody td {color: #0B0B61; font-family: "Quicksand", "Trebuchet MS";font-size: 14px;}' +
                       'h5 {color: black;font-family: "Quicksand", "Trebuchet MS";font-size: 10px;} ' +
                     '</style>' +
                   '</head>' +
                   '<table width=720 border=0>' +
                          '<thead>' +
                            '<tr>' +
                              '<img src="http://www.loginser.com/sync/imagenes/clientes/flam_banner_logo.jpg"><br>' +
                            '</tr>'
                   );

        ruta := '';
        dest := dm.q_peds.FieldByName('email').AsString;
        //dest := 'desarrollo@loginser.com';

        if dm.q_peds.FieldByName('pais_code').AsString='ES' then    //EMAIL NACIONAL
        begin
            asunto := 'Confirmación de envío. Pedido ' + dm.q_peds.FieldByName('order_name').AsString;
            cuerpo.Add( '<tr>' +
                              '<img src="http://www.loginser.com/sync/imagenes/clientes/flam_email_nac.jpg"><br>' +
                         '</tr>' +
                        '</thead>' +
                        '<tbody width=200>' +
                        '<tr>' +
                         '<th align=left><br>Hola ' + dm.q_peds.FieldByName('nombre').AsString + '!</th>' +
                        '</tr>' +
                        '<tr>' +
                         '<td><br>Tu pedido <b>' + dm.q_peds.FieldByName('order_name').AsString + '</b> ya está de camino a la siguiente dirección:</td>' +
                        '</tr>' +
                        '<tr>' +
                         '<th align=left><br>Dirección de envío:<br><br></th>' +
                        '</tr>' +
                        '<tr>' +
                         '<td>' + dm.q_peds.FieldByName('dir_1').AsString + '<br>' +
                                  dm.q_peds.FieldByName('cp').AsString + ' ' + dm.q_peds.FieldByName('poblacion').AsString + '<br>' +
                                  dm.q_peds.FieldByName('provincia').AsString + '<br>' +
                                  dm.q_peds.FieldByName('pais').AsString + ' </td>' +
                        '</tr>' +
                        '<tr>' +
                         '<th align=left><br>Detalles del pedido: </th>' +
                        '</tr>' +
                        '<tr>' +
                          '<td width=720><br>' + rellena_detalle_pedido + '<br></td>' +
                        '</tr>' +
                        '<tr>' +
                          '<td><br>Si tienes cualquier duda escribe un email a contact@flamingoslife.com y los chicos de atención al cliente te atenderán.<br><br> ' +
                                  '¡Gracias por comprar en Flamingos Life! <br><br>' +
                          '</td> ' +
                         '</tr>'+
                         '<tr>' +
                          '<td><br><font size=1>Por favor, <b>NO</b> responda a este mensaje, es un envío automático. ' +
                                               'El correo enviado a esta dirección no puede ser contestado. ' +
                                               'Si necesita contactar, escriba a la dirección indicada arriba.</font></td> ' +
                         '</tr>'+
                        '</tbody></table>'
                       //'<h5>CAMBIOS Y DEVOLUCIONES GRATUITOS - ENVIOS GRATUITOS A PARTIR DE 59€ A ESPAÑA Y 100€ A EUROPA</h5> '
                       //	{artículos del pedido} - Listado de los artículos que se han enviado. Con foto del producto en miniatura, nombre del producto, talla y cantidad. Si no es posible la foto decídnoslo. También nos gustaría, si se pudiera, que la imágen o la línea sea un enlace a la web del producto. Decidnos también si esto es posible.
                       //	{enlace a seguimiento} - URL hacia el seguimiento del pedido.
                       );
        end else begin    //EMAIL INTERNACIONAL
                   asunto := 'Shipping confirmation. Order ' + dm.q_peds.FieldByName('order_name').AsString;
                   cuerpo.Add('<tr>' +
                              '<img src="http://www.loginser.com/sync/imagenes/clientes/flam_email_int.jpg"><br>' +
                               '</tr>' +
                              '</thead>' +
                              '<tbody width=200>' +
                              '<tr>' +
                               '<th align=left><br>' + dm.q_peds.FieldByName('nombre').AsString + '!</th>' +
                              '</tr>' +
                              '<tr>' +
                               '<td><br>Your purchase <b>' + dm.q_peds.FieldByName('order_name').AsString + '</b> is on the way to the following address:</td>' +
                              '</tr>' +
                              '<tr>' +
                               '<th align=left><br>Shipping details:<br><br></th>' +
                              '</tr>' +
                              '<tr>' +
                               '<td>' + dm.q_peds.FieldByName('dir_1').AsString + '<br>' +
                                        dm.q_peds.FieldByName('cp').AsString + ' ' + dm.q_peds.FieldByName('poblacion').AsString + '<br>' +
                                        dm.q_peds.FieldByName('provincia').AsString + '<br>' +
                                        dm.q_peds.FieldByName('pais').AsString + ' </td>' +
                              '</tr>' +
                              '<tr>' +
                               '<th align=left><br>Order details: </th>' +
                              '</tr>' +
                              '<tr>' +
                                '<td width=720><br>' + rellena_detalle_pedido + '<br></td>' +
                              '</tr>' +
                              '<tr>' +
                                '<td><br>If you have any doubt contact us to contact@flamingoslife.com and the customer service team will solve your problems.<br><br> ' +
                                        'Thank you for buying in flamingos life! <br><br>' +
                                '</td> ' +
                               '</tr>'+
                               '<tr>' +
                                '<td><br><font size=1>Please, <b>DO NOT</b> reply this message, it is an automatic sending. Mail sent to this address cannot be answered.  ' +
                                        'If you need to contact, write to the address above.</font></td> ' +
                               '</tr>'+
                              '</tbody></table>'
                             //'<h5>CAMBIOS Y DEVOLUCIONES GRATUITOS - ENVIOS GRATUITOS A PARTIR DE 59€ A ESPAÑA Y 100€ A EUROPA</h5> '
                             //	{artículos del pedido} - Listado de los artículos que se han enviado. Con foto del producto en miniatura, nombre del producto, talla y cantidad. Si no es posible la foto decídnoslo. También nos gustaría, si se pudiera, que la imágen o la línea sea un enlace a la web del producto. Decidnos también si esto es posible.
                             //	{enlace a seguimiento} - URL hacia el seguimiento del pedido.
                             );
        end;

        email:=Tf_envia_mail.create(self);
        email.Show;
        email.envia_email(dest,'',asunto,ruta,cuerpo);
    finally
        cuerpo.Free;
        email.close;
        email.Free;
    end;
end;

procedure Tform1.InsertaPedidoLine(id_pedido,id_line,id_articulo,cantidad:integer; sku, nombre_art:string);
begin
  dm.q_1.Close;
  dm.q_1.sql.Clear;
  dm.q_1.sql.Add('insert into c_pedidos_lines ' + '(id_pedido, id_line, id_articulo, cantidad,sku,nombre_art,item_id) ' + 'values (:id_pedido, :id_line, :id_articulo, :cantidad, :sku, :nombre_art,:item_id)');
  dm.q_1.ParamByName('id_pedido').AsInteger := id_pedido;
  dm.q_1.ParamByName('id_line').AsInteger := id_line;
  dm.q_1.ParamByName('id_articulo').asinteger := id_articulo;
  dm.q_1.ParamByName('cantidad').asinteger := cantidad;
  dm.q_1.ParamByName('sku').AsString := sku;
  dm.q_1.ParamByName('nombre_art').AsString := nombre_art;
  dm.q_1.ExecQuery;
end;

procedure Tform1.InsertaPedido(id_pedido,id_cliente, deliv_time, trans_propio, id_repartidor, deleg, service_ref, con_retorno:Integer;
                                id_order,order_name,nombre,dir,poblacion,provincia,cp,pais,pais_code,telefono,email,text,track,observaciones,
                                financial_status, fulfillment_status, gateway, company, tags, note, cancel_reason, estado, contacto:string;
                                fecha_ped, cancel_date:TDateTime; reemb:Double);
begin
  dm.q_1.Close;
  dm.q_1.sql.Clear;
  dm.q_1.sql.Add('insert into c_pedidos ' +
                 '(id_pedido,id_cliente, id_order, order_name, nombre, dir_1, poblacion, provincia, cp, pais, pais_code, ' +
                 ' fecha_ped, telefono, email, delivery_time,text, tracking_number, ' +
                 'transporte, id_, reembolso, observaciones, delegacion_dst, ' +
                 'financial_status, fulfillment_status, gateway, company, tags, note, service_ref, cancelled_at, cancel_reason, estado, con_retorno, contacto) ' +
                 'values (:id_pedido,:id_cliente, :id_order, :order_name, :nombre, :dir_1, :poblacion, :provincia, :cp, :pais, :pais_code, '+
                 ':fecha_ped, :telefono, :email, :delivery_time, :text, :tracking_number, ' +
                 ':transporte, :id_repartidor, :reemb, :observaciones, :deleg, ' +
                 ':financial_status, :fulfillment_status, :gateway, :company, :tags, :note, :service_ref,  ' +
                 ':cancelled_at, :cancel_reason, :estado, :con_retorno, :contacto)');
  dm.q_1.ParamByName('id_cliente').AsInteger := id_cliente;
  dm.q_1.ParamByName('id_pedido').AsInteger := id_pedido;
  dm.q_1.ParamByName('id_order').asstring := id_order;
  dm.q_1.ParamByName('order_name').asstring := order_name;
  dm.q_1.ParamByName('nombre').asstring := nombre;
  dm.q_1.ParamByName('dir_1').asstring := dir;
  dm.q_1.ParamByName('poblacion').asstring := poblacion;
  dm.q_1.ParamByName('provincia').asstring := provincia;
  dm.q_1.ParamByName('cp').asstring := cp;
  dm.q_1.ParamByName('pais').asstring := pais;
  dm.q_1.ParamByName('pais_code').asstring := pais_code;
  dm.q_1.ParamByName('fecha_ped').AsDateTime := fecha_ped;
  dm.q_1.ParamByName('telefono').asstring := telefono;
  dm.q_1.ParamByName('email').asstring := email;
  dm.q_1.ParamByName('delivery_time').asinteger := deliv_time;
  dm.q_1.ParamByName('text').asstring := text;
  dm.q_1.ParamByName('tracking_number').asstring := track;
  dm.q_1.ParamByName('transporte').asinteger := transporte_propio;
  dm.q_1.ParamByName('id_repartidor').asinteger := id_repartidor;
  dm.q_1.ParamByName('reemb').asfloat := reemb;
  dm.q_1.ParamByName('observaciones').asstring := observaciones;
  dm.q_1.ParamByName('deleg').AsInteger := deleg;
  dm.q_1.ParamByName('financial_status').asstring := financial_status;
  dm.q_1.ParamByName('fulfillment_status').asstring := fulfillment_status;
  dm.q_1.ParamByName('gateway').asstring := gateway;
  dm.q_1.ParamByName('company').asstring := company;
  dm.q_1.ParamByName('tags').asstring := tags;
  dm.q_1.ParamByName('note').asstring := note;
  dm.q_1.ParamByName('cancelled_at').AsDateTime := cancel_date;
  dm.q_1.ParamByName('cancel_reason').AsString := cancel_reason;
  if estado='' then estado := 'P';
  dm.q_1.ParamByName('estado').asstring := estado;
  dm.q_1.ParamByName('service_ref').AsInteger := service_ref;
  dm.q_1.ParamByName('con_retorno').AsInteger := con_retorno;
  dm.q_1.ParamByName('contacto').asstring := contacto;
  dm.q_1.ExecQuery;
end;


function Tform1.rellena_detalle_pedido:string;
var
  detail: string;
  imagen: TJPEGImage;
  Stream: TStream;
begin
  if dm.q_peds.IsEmpty then
  begin
    ShowMessage('No existen pedidos.');
    Exit;
  end;

  imagen := TJPEGImage.Create;
  with dm.q_peds do
  begin

    detail := '';

    Stream := TMemoryStream.Create;


    imagen.LoadFromStream(Stream);

    dm.q_detail.Close;
    dm.q_detail.ParamByName('id_pedido').AsInteger := FieldByName('id_pedido').AsInteger;
    dm.q_detail.Open;
    dm.q_detail.First;
    while not dm.q_detail.Eof do
    begin
       Stream := dm.q_detail.CreateBlobStream(dm.q_detail.FieldByName('imagen'), bmRead);

       imagen.LoadFromStream(Stream);
       imagen.SaveToFile('c:\temp\img.jpg');
       //Megacutre, pero... :(
       //Si el artículo es zapatilla, al artículo incluirá la palabra "talla"
       if Pos('Talla',dm.q_detail.FieldByName('nombre').AsString)>0 then
       begin
         detail := detail +
                   //'<img src="c:\temp\img.jpg" width=100 align="center"> ' +
                   Copy(dm.q_detail.FieldByName('nombre').AsString,0,Length(dm.q_detail.FieldByName('nombre').AsString)-8) + ' - ' +
                   Copy(dm.q_detail.FieldByName('nombre').AsString,Length(dm.q_detail.FieldByName('nombre').AsString)-1,Length(dm.q_detail.FieldByName('nombre').AsString))
                   + ' - ' + dm.q_detail.FieldByName('cantidad').AsString + '<br>';
       end else //Si el artículo es mochila, al artículo incluirá la palabra "Ualabi" (indicado por Flamnigos)
               if Pos('Ualabi',dm.q_detail.FieldByName('nombre').AsString)>0 then
               begin
                   detail := detail +
                             //'<img src="c:\temp\img.jpg" width=100 align="center"> ' +
                             Copy(dm.q_detail.FieldByName('nombre').AsString,0,Pos('-',dm.q_detail.FieldByName('nombre').AsString)-1) + ' - ' +
                             dm.q_detail.FieldByName('cantidad').AsString + '<br>';
               end else begin
                          detail := detail +
                             //'<img src="c:\temp\img.jpg" width=100 align="center"> ' +
                             dm.q_detail.FieldByName('nombre').AsString + ' - ' +
                             dm.q_detail.FieldByName('cantidad').AsString + '<br>';
                        end;


       dm.q_detail.Next;
    end;

    if FieldByName('pais_code').AsString = 'ES' then
    begin
      detail := detail +
      '<br>Este es tu número de seguimiento para saber en todo momento donde está tu pedido. Se ha enviado por medio de Correos: <br> ' +
      '<b>' + dm.q_detail.FieldByName('cod_envio').AsString + '</b><br><br> ' +
      'Puedes conocer el estado del envío en el siguiente enlace:<br>' +
      '<a href="http://www.correos.es/ss/Satellite/site/aplicacion-4000003383089-herramientas_y_apps/detalle_app-sidioma=es_ES?numero=' +
               dm.q_detail.FieldByName('cod_envio').AsString + '">Seguimiento del pedido</a>';
    end else begin
                detail := detail +
                '<br>This is the tracking number in order to know at any time the status of your order. Your order has been dispatched by the shipping company Correos: <br> ' +
                '<b>' + dm.q_detail.FieldByName('cod_envio').AsString + '</b><br><br> ' +
                'You can check the order status through the following link:<br>' +
                '<a href="http://www.correos.es/ss/Satellite/site/aplicacion-4000003383089-herramientas_y_apps/detalle_app-sidioma=es_ES?numero=' +
                         dm.q_detail.FieldByName('cod_envio').AsString + '">Order tracking</a>';
    end;

    Stream.Free;
  end;

  Result := detail;

end;


procedure Tform1.Imprime(f,orientacion:string);
var
  MemoryStream1: TMemoryStream;
begin
  {
  MemoryStream1 := TMemoryStream.Create;
  MemoryStream1.LoadFromFile(f);

  gtPDFDocument1 := TgtPDFDocument.Create(Nil);
  gtPDFDocument1.LoadFromStream(MemoryStream1);

  gtPDFPrinter1 := TgtPDFPrinter.Create(Nil);
  gtPDFPrinter1.PDFDocument := gtPDFDocument1;

  //gtPDFPrinter1.SelectPrinterByName(gtPDFPrinter1.GetInstalledPrinters[0]);
  gtPDFPrinter1.SelectPrinterByName(imp_eti);
  gtPDFPrinter1.ShowSetupDialog := False;
  gtPDFPrinter1.Options := [poPageNums];
  gtPDFPrinter1.PrintRange := prPageNums;

  if orientacion='H' then
      gtPDFPrinter1.AdvancedPrinterSettings.Orientation := potLandScape
  else
      gtPDFPrinter1.AdvancedPrinterSettings.Orientation := potPortrait;

//  gtPDFPrinter1.FromPage := gtPDFDocument1.PageCount div 2;
//  gtPDFPrinter1.ToPage := gtPDFDocument1.PageCount;
  gtPDFPrinter1.FromPage := 1;
  gtPDFPrinter1.ToPage := 1;


  gtPDFPrinter1.PrintDoc;

  gtPDFPrinter1.Destroy;

  gtPDFDocument1.Reset;
  FreeAndNil(gtPDFDocument1);
  MemoryStream1.Free;   }
end;

function Tform1.JSONPost(text:string;LI:boolean):string;
var
  HTTP: TIdHTTP;
  RequestBody: TStream;
  ResponseBody: string;
begin
  HTTP := TIdHTTP.Create;
  try
    try
      //RequestBody := TStringStream.Create('{"FechaOperacion":'25-09-2017 12:00'}', TEncoding.UTF8);
      RequestBody := TStringStream.Create(text, TEncoding.UTF8);
      try
        HTTP.Request.Accept := 'application/json';
        HTTP.Request.ContentType := 'application/json';
        if LI then
          ResponseBody := HTTP.Post('http://www.loginser.com/sync/Operadores/Correos/ws/ws.registerLI.php', RequestBody)
        else
          ResponseBody := HTTP.Post('http://www.loginser.com/sync/Operadores/Correos/ws/ws.register.php', RequestBody);
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


procedure Tform1.GuardaEtiqueta(pedido:Integer;txt:string);
var
  linea: TStringDynArray;
begin

    linea := splitstring(txt,'|');

    if linea[0]<>'0' then
    begin
      { case StrToInt(linea[0]) of
          //null: ShowMessage('Se ha producido un error (' + linea[0] + ').');

       end;  }

     Exit;
    end;

    dm.t_write.StartTransaction;
    try
        dm.q_1.Close;
        dm.q_1.sql.Clear;
        dm.q_1.sql.Add('insert into c_pedidos_etiquetas ' +
          '(id_pedido, num_bulto, fecha_operacion, cod_expedicion, cod_etiquetador, cod_envio, ruta_pdf) '+
          'values (:id_pedido, :num_bulto, :fecha_operacion, :cod_expedicion, :cod_etiquetador, :cod_envio, :ruta_pdf)');
        dm.q_1.ParamByName('id_pedido').AsInteger := pedido;
        dm.q_1.ParamByName('num_bulto').AsInteger := 1; //StrToInt(linea[0000000]);
        dm.q_1.ParamByName('fecha_operacion').AsDateTime :=
        encodedatetime(strtoint(Copy(linea[2],7,4)),strtoint(Copy(linea[2],4,2)),StrToInt(Copy(linea[2],1,2)),StrToInt(Copy(linea[2],12,2)),StrToInt(Copy(linea[2],15,2)),StrToInt(Copy(linea[2],18,2)),0); //StrToDate(linea[3]);
        dm.q_1.ParamByName('cod_etiquetador').AsString := '4BCC'; //Copy(linea[2],4,4);
        dm.q_1.ParamByName('cod_expedicion').AsString := linea[1];
        dm.q_1.ParamByName('cod_envio').AsString := linea[3];
        dm.q_1.ParamByName('ruta_pdf').AsString := path_pdf_correos + linea[3] + '.pdf';
        dm.q_1.ExecQuery;

        if linea[4]<>'' then
        begin
          dm.q_1.ParamByName('cod_envio').AsString := linea[4];
          dm.q_1.ParamByName('ruta_pdf').AsString := path_pdf_correos + linea[4] + '.pdf';
          dm.q_1.ExecQuery;
        end;

        dm.t_write.CommitRetaining;
    except
        dm.t_write.RollbackRetaining;
    end;

     if ((dm.q_peds.FieldByName('PAIS_CODE').AsString='ES') or (dm.q_peds.FieldByName('PAIS_CODE').AsString='PT')) then
     begin
        ImprimeEtiqueta(linea[3] + '.pdf','H');
        if linea[4]<>'' then
              ImprimeEtiqueta(linea[4] + '.pdf','H');
     end else
            ImprimeEtiqueta(linea[3] + '.pdf','V');
end;


function Tform1.BuscaClienteGesFile(codigo:integer):string;
begin                                       //devuelve nombre de cliente a partir de codigo
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select nombre from g_clientes cl, g_clientes_config c where cl.id_cliente=c.id_cliente and c.ges_file=1 and cl.id_cliente=:id ');
    ParambyName('id').AsInteger:=codigo;
    Open;

    if not(IsEmpty) then Result:=FieldByName('nombre').asstring
    else result:='';

    Free;
  end;
end;

procedure Tform1.CargarDatosCorreos;
var
  str_dyn:TStringDynArray;
begin
   with tpfibdataset.Create(dm) do begin
    try
      database:=dm.db;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select * ' +
                         'from g_agencias_clientes where id_cliente=:cliente and id_agencia=:agencia ');
      ParambyName('cliente').AsInteger := main_cli;
      ParambyName('agencia').AsInteger := agencia_correos;
      Open;

      if not(IsEmpty) then
      begin
        str_dyn := SplitString(fieldByName('correos').AsString,'|');

        correos_etiquetador := str_dyn[0];
        correos_contrato := str_dyn[1];
        correos_cliente := str_dyn[2];

      end;
    finally
        free;
    end;
   end;
end;

function Tform1.CargarDatosAgencia(campos: string; cliente, agencia:Integer):string;
var
  str_dyn:TStringDynArray;
  i: integer;
begin

   Result := '';
   with tpfibdataset.Create(dm) do begin
    try
      database:=dm.db;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select ' + campos +
                         ' from g_agencias_clientes where id_cliente=:cliente and id_agencia=:agencia ');
      ParambyName('cliente').AsInteger := cliente;
      ParambyName('agencia').AsInteger := agencia;
      Open;

      if not(IsEmpty) then
      begin
        for i:=0 to fields.Count-1 do
        begin
          result := Result + fields[i].Text + '#';
        end;
      end;

      Result := Copy(Result,0,Length(result)-1);
    finally
        free;
    end;
   end;
end;

function Tform1.LoadFieldConfigCLiente(campos: string; cliente:Integer):string;
var
  str_dyn:TStringDynArray;
  i: integer;
begin

   Result := '';
   with tpfibdataset.Create(dm) do begin
    try
      database:=dm.db;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select ' + campos +
                         ' from g_clientes_config where id_cliente=:cliente');
      ParambyName('cliente').AsInteger := cliente;
      Open;

      if not(IsEmpty) then
      begin
        for i:=0 to fields.Count-1 do
        begin
          result := Result + fields[i].Text + '#';
        end;
      end;

      Result := Copy(Result,0,Length(result)-1);
    finally
        free;
    end;
   end;
end;


procedure Tform1.InsertaLote(pedido, art, lote, cantidad, id_pick, l_pick: Integer);
begin
  dm.q_1.Close;
  dm.q_1.sql.Clear;
  dm.q_1.sql.Add('insert into c_pedidos_lines_lotes (id_pedido, id_articulo, id_lote, cantidad, id_picking, linea_pick) ' +
                 'values (:id_pedido, :id_articulo, :id_lote, :cantidad, :id_picking, :linea)');
  dm.q_1.ParamByName('id_pedido').AsInteger := pedido;
  dm.q_1.ParamByName('id_articulo').AsInteger := art;
  dm.q_1.ParamByName('id_lote').asinteger := lote;
  dm.q_1.ParamByName('cantidad').asinteger := cantidad;
  dm.q_1.ParamByName('id_picking').asinteger := id_pick;
  dm.q_1.ParamByName('linea').asinteger := l_pick;

  dm.q_1.ExecQuery;
end;


function Tform1.Articulo_con_IMEI(id_articulo:Integer):Boolean;
begin
  dm.ds_2.Close;                                                            //datos de lotes
  dm.ds_2.SQLs.SelectSQL.Clear;
  dm.ds_2.SQLs.SelectSQL.Add('select tiene_imei from g_articulos where id_articulo=:id_articulo ');
  dm.ds_2.ParamByName('id_articulo').AsInteger:=id_articulo;
  dm.ds_2.Open;

  Result := (dm.ds_2.FieldByName('tiene_imei').AsInteger<>0);

end;


{$ENDREGION}

{$REGION 'Chrono'}
function Tform1.get_chrono_bulto(cp:integer):string;
var  producto_chrono,cliente_chrono,ch_codbulto:string;    producto_chrono_id,ch_numbulto:integer;
begin
  if (((cp>=35000) and (cp<=35999)) or ((cp>=38000) and (cp<=38999))) then begin
    producto_chrono_id:=69;
  end else begin
    producto_chrono_id:=63;
  end;

  cliente_chrono:='519500001';

  with tpfibdataset.create(dm) do                                     //numero de expedicion de ChronoExpress
  try
    database:=dm.db;
    close;
    sqls.SelectSQL.Clear;
    sqls.selectsql.Add('select chrono_lis_bulto '+
      'from c_aux '+
      'where id_empresa='+inttostr(u_globals.id_empresa));
    open;

    if not(isempty) then begin
      ch_numbulto:=fieldbyname('chrono_lis_bulto').asinteger;

      dm.q2.close;
      dm.q2.sql.clear;
      dm.q2.SQL.Add('update c_aux set chrono_lis_bulto=chrono_lis_bulto+1 where id_empresa='+inttostr(u_globals.id_empresa));

      dm.t_write.StartTransaction;
      dm.q2.ExecQuery;
      dm.t_write.CommitRetaining;

    end else ch_numbulto:=1;
  finally
    free;
  end;

  ch_codbulto:=inttostr(producto_chrono_id)+'7094'+FormatFloat('000000000',ch_numbulto)+formatfloat('00',1)+formatfloat('00000',cp);
  ch_codbulto:=ch_codbulto+inttostr(calc_digcon_chrono(ch_codbulto));

  result:=ch_codbulto;
end;

function Tform1.get_chrono_exp(codalbaran:integer):string;
var s:string;
begin
  s:= '519500001';      //9
  s:= s + FormatFloat('0000000',codalbaran);   //7
  result :=s;
end;

Function Tform1.calc_digcon_chrono(codbar:string):Integer;
var
  n,l,suma:Integer;
begin
  suma:=0;
  for n := 1 to 22 do begin
     l:=StrToInt(Copy(codbar,n,1));
     if n/2 = Int(n/2) then
       suma:=suma+(l*3)
     else
       suma:=suma+l;
  end;
  codbar:=IntToStr(suma);
  codbar:=Copy(codbar,length(codbar),1);
  result:=10-strtoint(codbar);
  if Result=10 then Result:=0;
end;
{$ENDREGION}

{$REGION 'API'}
procedure Tform1.GeneraUrlValidate(id_albaran:integer);
var
  BaseUrl:string;
begin
  BaseURL:='https://servertest.loginser.com:5443/loginser-back/api/albaran/'+inttostr(id_albaran)+'/validate';

  dm.client.BaseURL:=BaseUrl;
end;

procedure Tform1.RegeneraBultos(id_albaran: integer);
var
  i,estado:integer;
  jsbody: TJSONObject;
  //bultos_alb,bultos_eti:integer;
begin
    GeneraUrlValidate(id_albaran);
    try
       dm.request.ClearBody;
       jsbody:=TJSONObject.Create();
       dm.request.addbody(jsbody);
       dm.request.Execute;
       estado:=dm.response.StatusCode;
       //GuardaLogApi(rentorno.Nombre, client.BaseURL,inttostr(estado),response.StatusText,now);

       if estado<>200 then
       begin
         showmessage('Han ocurrido errores al generar los bultos');
       end
       else begin

       end;
       jsbody.Free;
      except

      end;
end;


{$ENDREGION 'API'}

procedure Tform1.AbreFichero(ruta:string);
begin
   Excel:=CreateOleObject('Excel.Application');
   try
     Excel.Visible := False;
     Excel.DisplayAlerts:= False;
     //Excel.WorkBooks.Open(ed_csv.text);//fichero que queremos leer
   except
     Excel.Quit ;
     Excel := Unassigned;
   end;
end;


function Tform1.GetConexion(nombre:string):string;
begin
    with dm.q_cons do
    begin
      Close;
      ParamByName('nombre').AsString := UpperCase(nombre);
      Open;
      First;

      if not (FieldByName('basedatos').AsString='') then
      begin
        result := FieldByName('basedatos').AsString;
      end else
            Result :=  '';
     free;
    end;
end;

end.
