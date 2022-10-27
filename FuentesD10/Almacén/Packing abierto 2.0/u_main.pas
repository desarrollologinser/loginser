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
  Vcl.ImgList, Winapi.ActiveX, IdFTP, IdFTPCommon,  u_functions,
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
  acProgressBar, Winapi.MMSystem, frxExportPDF, MATH,IdBaseComponent, IdComponent,
  IdTCPClient, IdExplicitTLSClientServerBase,
  IdMessageClient, IdSMTPBase, IdTCPConnection, IdSMTP, IdMessage,IdAttachmentFile,
  sSpinEdit, Vcl.Clipbrd, Vcl.Samples.Spin;

type
  Tstock = record
    id_art:Integer;
    uds:Integer;

    id_ubic:Integer;
    id_lote:Integer;
    caducidad:TDate;
  end;

  TDatosPC   = record
    Nombre, IP, Usuario :String;
  end;

   TDatosUsuario  = record
    id: Integer;
    Nombre :String;
  end;

  Tf_main = class(TForm)
    sknmngr1: TsSkinManager;
    sknprvdr1: TsSkinProvider;
    pnCOn: TsPanel;
    ga_stat: TsGauge;
    lb_st1: TsLabel;
    ar_pick_ds_: TClientDataSet;
    intgrfld_pick_dsid_art: TIntegerField;
    strngfld_pick_dsref_art: TStringField;
    intgrfld_pick_dsuds: TIntegerField;
    intgrfld_pick_dsid_ubic: TIntegerField;
    strngfld_pick_dsnomApe: TStringField;
    strngfld_pick_dsdireccion: TStringField;
    strngfld_pick_dspoblacion: TStringField;
    strngfld_pick_dscp: TStringField;
    strngfld_pick_dsprovincia: TStringField;
    strngfld_pick_dsmail: TStringField;
    strngfld_pick_dstelefono: TStringField;
    strngfld_pick_dsubicacion: TStringField;
    strngfld_pick_dsarticulo: TStringField;
    strngfld_pick_dspedido: TStringField;
    rep_db_pick: TfrxDBDataset;
    intgrfld_pick_dscodalbaran: TIntegerField;
    rep_db_bultos: TfrxDBDataset;
    rep_log: TfrxReport;
    rep_asm: TfrxReport;
    strngfld_pick_dsdeliv_time: TStringField;
    il1: TImageList;
    lbCon: TsLabel;
    strngfld_pick_dsCodPais: TStringField;
    strngfld_pick_dsTag: TStringField;
    il2: TImageList;
    smlntfld_pick_ds_EsDevo: TSmallintField;
    q1: TpFIBDataSet;
    blbfldq1logo: TBlobField;
    ds1: TDataSource;
    db_1: TfrxDBDataset;
    intgrfld_pick_dsid_lote: TIntegerField;
    ar_pick_lotes: TClientDataSet;
    strngfld_pick_lotespedido: TStringField;
    intgrfld_pick_lotesid_art: TIntegerField;
    strngfld_pick_lotesref_art: TStringField;
    strngfld_pick_lotesnom_art: TStringField;
    strngfld_pick_loteslote: TStringField;
    strngfld_pick_lotescaducidad: TStringField;
    rep_db_lotes: TfrxDBDataset;
    rep_pick: TfrxReport;
    strngfld_pick_dscontacto: TStringField;
    strngfld_pick_dsservicio: TStringField;
    strngfld_pick_dshorario: TStringField;
    dxPDF: TdxPDFViewer;
    dxprinter: TdxComponentPrinter;
    link: TdxPDFViewerReportLink;
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
    im: TImage;
    ts_1: TsTabSheet;
    bt_lectura_manual: TsSpeedButton;
    gr_grid: TJvDBGrid;
    ts_2: TsTabSheet;
    bt_print_indiv: TsSpeedButton;
    bt1: TsSpeedButton;
    gr_grid2: TJvDBGrid;
    gb_1: TsGroupBox;
    b_picking: TsBitBtn;
    gb_12: TsGroupBox;
    sb_1: TsBitBtn;
    cb_prev: TsCheckBox;
    cb_one_read_marks_all: TsCheckBox;
    cb_art_un_bulto: TsCheckBox;
    cb_send_email: TsCheckBox;
    cb_indiv_2040: TsCheckBox;
    lbClAlm: TsLabel;
    rep_eti: TfrxReport;
    rep_db_indiv: TfrxDBDataset;
    rep_pick2: TfrxReport;
    ar_lis_ds: TClientDataSet;
    StringField1: TStringField;
    cds1: TIntegerField;
    cds2: TIntegerField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    StringField6: TStringField;
    StringField7: TStringField;
    StringField8: TStringField;
    StringField9: TStringField;
    StringField10: TStringField;
    StringField11: TStringField;
    cds3: TIntegerField;
    StringField12: TStringField;
    cds4: TIntegerField;
    strngfld_pick_dsean: TStringField;
    strngfld_pick_dsean2: TStringField;
    strngfld_pick_dsempresa: TStringField;
    strngfld_pick_dsrepartidor: TStringField;
    strngfld_pick_dsprecinto: TStringField;
    strngfld_pick_dsid_pais: TStringField;
    fltfld_pick_dsportes: TFloatField;
    fltfld_pick_dsreembolso: TFloatField;
    cds_lis_dsid_lote: TIntegerField;
    strngfld_lis_dsn_lote: TStringField;
    dtfld_lis_dscaducidad: TDateField;
    rep_db_lis: TfrxDBDataset;
    rep_lis: TfrxReport;
    pdf_export: TfrxPDFExport;
    fr_asm: TfrxReport;
    rep_mensy: TfrxReport;
    frxReport1: TfrxReport;
    rep_correos: TfrxReport;
    pnReparto: TsPanel;
    grReparto: TJvDBGrid;
    lbReparto: TsLabel;
    btPasarUds: TsSpeedButton;
    cdsreparto: TClientDataSet;
    dsReparto: TDataSource;
    cdsrepartocodalbaran: TStringField;
    cdsrepartonum_cajas: TStringField;
    strngfldcdsrepartolote: TStringField;
    cdsrepartouds: TStringField;
    cdsrepartobultos: TIntegerField;
    edIdArt: TsSpinEdit;
    edUds: TsSpinEdit;
    cdsreparton_bulto: TIntegerField;
    rep_pick_lotes: TfrxReport;
    ar_pick_ds_caducidad: TDateField;
    strngfld_pick_dslote: TStringField;
    cds_pick_dscon_retorno: TIntegerField;
    strngfld_pick_dsempresa1: TStringField;
    cds_pick_dsrepartidor: TIntegerField;
    strngfld_pick_dsreembolso: TStringField;
    cds_pick_dscantidad: TIntegerField;
    chHojaPick: TsCheckBox;
    db_eti_lgs: TfrxDBDataset;
    eti_lgs_copy: TfrxReport;
    chEtXLect: TsCheckBox;
    eti_lgs_: TfrxReport;
    chEtiqCB: TsCheckBox;
    rep_db_prev: TfrxDBDataset;
    frxPrev: TfrxReport;
    cdsPrev: TClientDataSet;
    strngfldPrevcodalbaran: TStringField;
    strngfldPrevruta: TStringField;
    strngfldPrevcaja: TStringField;
    strngfldPrevbulto: TStringField;
    strngfldPrevtipo_caja: TStringField;
    pnl1: TPanel;
    gbGrupo: TsGroupBox;
    lb_picking: TsLabel;
    sGroupBox1: TsGroupBox;
    lbNombreCl: TsLabel;
    chAdjunto: TsCheckBox;
    sGroupBox2: TsGroupBox;
    lbAgrupacion: TsLabel;
    sSpeedButton1: TsSpeedButton;
    sSpeedButton2: TsSpeedButton;
    lbLotes: TsLabel;
    btn1: TButton;
    rg1: TRadioGroup;
    eti_lgs: TfrxReport;
    rgFmtHPick: TRadioGroup;
    btImpAdj: TsSpeedButton;
    chRevLotes: TsCheckBox;
    pnInput: TPanel;
    edInput: TsEdit;
    pnLotes: TPanel;
    lbLoteArt: TsLabel;
    lbLote: TsLabel;
    lbLoteLote: TsLabel;
    lbLoteCad: TsLabel;
    lbCaja: TsLabel;
    lbLoteCaja: TsLabel;
    sLabel2: TsLabel;
    sLabel3: TsLabel;
    lbAlb: TsLabel;
    lbLoteAlb: TsLabel;
    btLoteSi: TsSpeedButton;
    sLabel4: TsLabel;
    btLoteNo: TsSpeedButton;
    btLoteTodo: TsSpeedButton;
    sLabel5: TsLabel;
    lbLoteUds: TsLabel;
    btLoteCancel: TsSpeedButton;
    lbLoteArtCod: TsLabel;
    lbLoteArtNom: TsLabel;
    edCadOculto: TsDateEdit;
    edLineaOculto: TSpinEdit;
    edIdArtOculto: TSpinEdit;
    edTipoCajaOculto: TEdit;
    edIdCajaOculto: TSpinEdit;
    edRepartOculto: TSpinEdit;
    edIdLoteOculto: TSpinEdit;
    edUdsOculto: TSpinEdit;
    btFin: TsSpeedButton;
    lbFin: TsLabel;
    cdsPrevunidades: TIntegerField;
    lbCajaGrande: TsLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure b_pickingClick(Sender: TObject);
    procedure sb_1Click(Sender: TObject);
    procedure g_agrDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure bt_cerrar_cajaClick(Sender: TObject);
    procedure bt_cambioClick(Sender: TObject);
    procedure bt_print_prevClick(Sender: TObject);
    procedure bt_imp_pickClick(Sender: TObject);
    procedure bt_print_bultosClick(Sender: TObject);
    procedure bt_cerrar_agrupClick(Sender: TObject);
    procedure ed_cbKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bt_print_indivClick(Sender: TObject);
    procedure bt_lectura_manualClick(Sender: TObject);
    procedure bt1Click(Sender: TObject);
    procedure cb_one_read_marks_allClick(Sender: TObject);
    procedure btPasarUdsClick(Sender: TObject);
    procedure gr_grid2CellClick(Column: TColumn);
    procedure grRepartoDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure gr_gridCellClick(Column: TColumn);
    procedure gr_gridTitleClick(Column: TColumn);
    procedure gr_grid2TitleClick(Column: TColumn);
    procedure chEtXLectClick(Sender: TObject);
    procedure sSpeedButton1Click(Sender: TObject);
    procedure sSpeedButton2Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure chHojaPickClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btImpAdjClick(Sender: TObject);
    procedure chRevLotesClick(Sender: TObject);
    procedure edInputKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btLoteNoClick(Sender: TObject);
    procedure btLoteSiClick(Sender: TObject);
    procedure btLoteTodoClick(Sender: TObject);
    procedure btLoteCancelClick(Sender: TObject);
    procedure btFinClick(Sender: TObject);

  private
    { Private declarations }
    procedure get_defaults;
    procedure start;
    procedure act_cajas;
    procedure print_etiq_pre(codalbaran,tipo_caja,codrepartidor,id_ruta:string; id_caja,id_packlin_bulto,n_bulto, unidades:integer);
    function mark_one(nombre,codigo,bc,tipo_caja:string;  id_caja,codalbaran,linea:Integer;  verbose,check_cierre_caja:boolean; id_lote:Integer; n_lote:string; caducidad:tdatetime; uds:integer=1):integer;    //returns id_packlin_bulto de la linea
    procedure cerrar_caja_y_nueva(codalbaran,id_packlin_bulto_old:integer; etiq_prev:Boolean=True);
    procedure nuevo_bulto(codalbaran:integer; etiq_prev:Boolean=True);
    function WriteRawDataToPrinter(PrinterName: String; Str: String): Boolean;
    procedure imprime_eti_indiv(id_packcab,id_agrupa,nivel_agr,linea:integer);
    Function calc_digcon_chrono(codbar:string):Integer;
    procedure imprime_hoja_pick(codalbaran:Integer);
    procedure imprime_hoja_pick_lis(codalbaran: Integer; send_email:boolean=false);
    procedure translate(lang:Integer=0);        //0=Spanish 1=English 2=Italian
    function pais_to_idx(pais:string):Integer;
    procedure imprime_eti_bulto_asm(codalbaran:integer);
    function limpiachar(frase: string):string;
    procedure cerrar_agrupa_error;                          //guardar errores agrupación
    procedure cerrar_albaran(codalbaran:integer);
    procedure update_sqlserver_lotes(codalbaran:integer);
    function siguiente_laboral(fecha:TDateTime):tdate;
    function es_festivo(fecha:TDateTime):Boolean;         //true=dia festivo false=dia no festivo
    function check_chrono:boolean;
    function check_dhl:Boolean;
    procedure send_chrono_file;
    procedure send_dhl_file;
    procedure genera_fichero_abierto(filename:string);          //Genera Fichero
    function get_nombrefichero_dhl:string;
    function get_nombrefichero_chrono(fecha: TDateTime):string;
    function linea_chrono_abierto(codalbaran:Integer):string;                   //Genera Linea para chronoexpres
    procedure marca_alb_abierto_enviado(codalb:Integer);
    function cadLongitudFija (cadena : string; longitud : Integer;   posicionIzquierda : boolean; valorRelleno : string) : string;
    function get_chrono_exp(codalbaran:integer; codcli:string):string;
    procedure send_hoja_pick(codalbaran:Integer);
    procedure imprime_eti_bulto(codalbaran:integer);
    function get_cp_ext(poblacion:string):string;
    function get_del_chrono(codigopostal: integer):string;
    function LeerHexa(fichero: string) : string;
    function Zeros(c: string; l: Integer): string;
    function Espacios(cadena: string; l: Integer): string;
    function codigoProducto(Pais: string):string;
    function esAduanero(Pais: string):Boolean;
    function SoloNumeros(Texto : String) : String;
    function GetPaisNombre(codigo:string):string;
    procedure lectura;
    function procesa_cb(bc:string):integer;
    procedure ejecuta_lectura(id_articulo:Integer; bc:string; codalbaran_p:integer; mark_all:boolean; id_lote:Integer = 1);
    procedure ver_imagen(id_articulo:integer);
    procedure imprime_etiqueta_x_api(codalbaran:Integer);
    function get_albaran_dest(codalbaran:Integer):integer;
    procedure reparte(id_articulo:Integer;tipo:string);
    procedure filter_ptes(orden: string);
    procedure filter_leidos(orden: string);
    procedure get_cliente_config(id_cliente:integer);
    procedure enviar_email_a_destino(id_albaran:integer);
    procedure enviar_email_pedidos(id_pedido:integer);
    procedure enviar_status_delivered(out albaranes:string);
    procedure LoadConfigCliente(items:String);
    function CreaMensaje(Sender: TObject; art,lote,uds,caja,alb:string):TModalResult;
    procedure SolucionLotesi(id_art:Integer);
    procedure SolucionLoteno(id_art:Integer);
    procedure SolucionLoteTodos(id_art:Integer);
    function RevisaLotes(art_cod,art_nom,lote,caja,alb,cad:string;id_art,uds:Integer):Integer;
    function IntroBarcode:integer;
    procedure LanzaMensajeError(bc,mensaje:string);
    procedure LecturaConLoteConfirmado(nombre,codigo,n_lote,bc:string; caducidad:TDateTime; id_art,linea,codalbaran,codrepartidor,revision:integer);
    procedure bloquea(Int:Integer); //0-desbloquea 1-bloquea
    procedure fuerzaerror;

  public
    { Public declarations }

    procedure envia_email(email_destino,email_cco,asunto,ruta_adjunto:string; cuerpo:TStrings; cuenta:Integer=1);
    procedure envia_email_multiple(email_destino,email_cco,asunto:string; ruta_adjuntos:TStringList; cuerpo:TStrings; cuenta:Integer=1);
    procedure enviar_email_albaran(codalbaran:integer);
    function TieneLecturasPendientes(id_packcab:integer):Boolean;
    function PackingFinalizado(id_packcab:integer):TDateTime;
  end;

const
  ALERTA = 'LISTO';
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
  ruta_logos = 'http://www.loginser.com/sync/imagenes/clientes/';

  v='[2.24]';
  //[2.24] Clientes padre.
  //[2.23] Bug al indicar alb en log. Recompilacion nuevos campos json lotes Pargal. Cliente padre.
  //[2.22] Indicar caja en obs estado albaran gestoras. Captura error al insertar estado albaran.
  //Envio lotes Synestia.
  //[2.21] Cambio de params a G_CLIENTES_CONFIG_
  //[2.20] Control envio email a destino. Revisar lotes para articulos sin lote.
  //[2.19] Pargal: envio de lotes de lineas sin lote
  //[2.18] Botón finalizar packing.
  //[2.17] Bug al imprimir etiqueta bulto si no hay logo cliente. Insercion de logs. Chk 1MarcaTodo config checked.
  //[2.16] Revisar lotes al pistolear. Bug titulo_zona etiqueta Loginser.
  //[2.15] Nuevo formato etiqueta Loginser
  //[2.14] Control de email de pedido
  //[2.13] Descarga attach. Envío attach en email. Botón imprimir attach.
  //[2.12.2] alias db name
  //[2.12.1] Bug al imprimir h pick lotes.
  //[2.12] H Pick en formato etiqueta. Login.
  //[2.11.1] No se canta la caja cuando la agrupación es de 1 elemento y no está
  //chequeado una lectura marca todos
  //[2.11] Impresión de etiq Loginser desde dmLabels
  //[2.10.5] Calcular por bbdd formato de etiqueta
  //[2.10.4] Insertar estado control almacen siempre que se cierre albarán.
  //[2.10.3] Insertar estado control almacen al cerrar agrup leyendo bc.
  //[2.10.2.1] Bug al enviar delivered. Parametrizar envio de delivered.
  //[2.10.2] Bug al cerrar agrup, eliminado código antiguo.
  //[2.10.1] Solo se envía email si el albarán tiene email en destino.
  //[2.10] Cambio interfaz. Enviar email con adjunto. Imprimir pick en dm.
  //Checks todos o ninguno en group box agrupación.
  //Cambiar barcode a etiqueta Loginser.
  //[2.9] Enviar delivered a Oxfam al cerrar agrupacion.
  //[2.8.1] Desplazar barcode en etiqueta loginser
  //[2.8] Cambiar fecha servicio al cerrar agrupación. Dynamic en etiqueta Loginser.
  //Para agencia Loginser, mostrar deleg destino en etiqueta.
  //[2.7] Envío de email a destino por bbdd
  //[2.6.1] Bug al cerrar albarán, no se calculan los bultos en Gestoras.
  //[2.6] Cerrar agrupación pistoleando el bc de la etiqueta previa. No se ha de cambiar la fecha
  //del albaran en cierra_albaran
  //[2.5] Cambio diseño report etiq Lgs
  //[2.4] Marcar pedidos almacen E al sacar etiqueta. Enviar email a destinatario.
  //[2.3.2] Agrup 1 elemento saca etiq al leer.
  //[2.3.1] Bug al cerrar agrupación e imprimir etiquetas
  //[2.3] Generar bultos al cerrar albarán
  //[2.2] Impresión de etiqueta de Loginser por Fast Report
  //[2.1][B]  Funcionalidad Nuevo Bulto
  //[2.0] Cambio a Delphi 10. Interfaz.

    trans : array [0..10, 0..2] of string =( ('Pedido', 'Order', 'Ordine'),    //0
                                      ('Fecha', 'Date', 'Data'),        //1
                                      ('Destino', 'Destination', 'Destinazione'),        //2
                                      ('Precinto', 'Seal', 'Sigillo'),        //3
                                      ('Reembolso', 'Cash On Delivery', 'Rimborso'),        //4
                                      ('Portes', 'Shipping Fee', 'Tasa Spedizione'),        //5
                                      ('Referencia', 'Article', 'Articolo'),        //6
                                      ('Descripción', 'Description', 'Descrizione'),        //7
                                      ('Ubicación', 'Location', 'Posizione'),        //8
                                      ('Uds', 'Qty', 'Qt'),        //9
                                      ('Lote/Cad.', 'Batch/Expiration', 'Gruppo/Scadenza')        //10
                                    );
  email_trans : array [0..8, 0..2] of string = (('Hola,', 'Hello,', 'Gentile Cliente,'),
                                                ('Tu pedido', 'Your order', 'Il tuo ordine nr'),
                                                ('ya está de camino a la siguiente dirección', 'is on the way to the next address', 'è stato spedito oggi al seguente indirizzo'),
                                                ('<b>Detalles del Pedido:</b><br>Hoja de Picking Adjunta<br><br>',
                                                 '<b>Order Details:</b><br>Picking Sheet Attached<br><br>',
                                                 '<b>Dettagli dell''ordine:</b><br>Picking Sheet Allegata<br><br>'),
                                                ('Este es tu número de seguimiento para saber en todo momento donde está tu pedido. Se ha enviado por medio de',
                                                 'This is your tracking number, it''s been sent through',
                                                 'Questo è il tuo numero di tracking per sapere in ogni momento dove si trova il tuo ordine. È stato inviato tramite'),
                                                ('Puedes conocer el estado del envío en el siguiente enlace',
                                                 'You can check the state of the shipment in the next link',
                                                 'Puoi conoscere lo stato della spedizione nel seguente link'),
                                                ('Seguimiento del Pedido', 'Tracking of Shipment', 'Tracking dell''ordine'),
                                                ('Si tienes cualquier duda escribe un email a marta@thelifeisshort.com y los chic@s de atención al cliente te atenderán',
                                                 'If you have any questions please send an email to marta@thelifeisshort.com and you will receive assistance from our costumer service',
                                                 'Se avete domande, potete scriverci una email al seguente indirizzo: marta@thelifeisshort.com per ricevere assistenza dal nosotro servizio clienti'),
                                                ('¡Gracias por comprar en Life Is Short!', 'Thanks for buying at Life Is Short!', 'Grazie per la fiducia accordata!')
                                    );
var
  f_main: Tf_main;
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
  tiene_lotes, tiene_imei, es_oxfam, envia_delivered: Boolean;
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
  id_usuario : Integer;
  en_grabacion : Integer;
  stock_min : integer;
  peds_en_cadena: Integer;
  peds_encadenados: string;
  tiene_albs_gestoras: Boolean=True;

  excel, xls, libro: Variant;
  hoja:OleVariant;


 percent_cubic: Integer;
 sys_path,pick_path,pick_email:string;
 id_packcab,id_agrupa,nivel_agr,id_ruta,uds,modo,coddel,old_codalbaran,id_cliente:integer;
 only_one:boolean=false;

 UnColor:TColor=clWhite;
 aux_alb: string;
 col: string;

 envia_correo_a_dst: Boolean=False;
 copia_oculta: string;
 mail_nombre_cli, mail_logo_cli, mail_mail_info, mail_from, mail_order_name: string;

 barcode: integer;
 etiqueta_impresa: Boolean = False;

 cliente_grupo: integer;
 tipo_adjunto, cl_nombre_gr: string;
 pie_hoja_pick: string;

 php_delivered, datos_delivered, log_delivered: string;
 marca_delivered: Integer;

 punteo_almacen_usu, punteo_almacen_est: integer;
 punteo_almacen_obs: string;

 PC: TDatosPC;
 usuario: TDatosUsuario;

 dir_temp: string;
 tiene_adjuntos: Boolean;

 logo_cli_etiq: Integer;
 revisa_lotes: Boolean;

 cli_api_user,cli_api_pass, cli_api_url:string;
 ch_1marcatodo, ch_1marcatodo_chk: Boolean;
 mail_error:string;

 bcInUse: string;

 log_cabecera, log_app: string;

 fecha_fin: TDateTime;

 lgs_api_url, lgs_api_user, lgs_api_pass, lgs_api_pedido: string;

 cl_padres, cl_hijos: TStringDynArray;

implementation

{$R *.dfm}

uses u_dm{, UGetText, ubuscapro, u_gen_gl, u_cam_gl, u_envia_mail,
  USendText,
  },
  u_globals, u_cam_gl, UDMCreaBultos, u_LstEtiquetas,u_globals_gestoras,
  u_gen_gl, u_AlbaranValidate, ubuscapro, u_envia_mail, u_barcode,
  UGetText, u_picking, u_dmLabels, u_login, u_DescargaAttach,
  u_lotes,u_dmPargal;


procedure Tf_main.bt1Click(Sender: TObject);
begin
  send_dhl_file;
end;

procedure Tf_main.btFinClick(Sender: TObject);
var
  fecha: TDateTime;
begin
  fecha := Now;

  with tpfibquery.create(Self) do                         //Actualiza Datos
  try
    Database:=dm.db;
    Transaction:=dm.t_write;
    sql.Add('update a_packcab set fecha_fin=:fecha '+
      ' where id_packcab=:id_packcab');
    parambyname('fecha').AsDateTime:=fecha;
    ParamByName('id_packcab').AsInteger:=id_packcab;

    dm.t_write.StartTransaction;
    execquery;
    dm.t_write.commit;

    insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','Packing Finalizado ' + FormatDateTime('dd.mm.yyyy hh:nn:ss',fecha),'');

    lbFin.caption := FormatDateTime('dd.mm.yyyy hh:nn:ss', fecha);
    lbFin.Visible := True;

  finally
    Free;
  end;

  f_main.Width := 1490;
end;

procedure Tf_main.btImpAdjClick(Sender: TObject);
var
  id_pedido, id_attach: Integer;
  resultado: string;
begin
       id_pedido := GetIdPedidoXAlbaran(dm.q_packagr.FieldByName('codalbaran').AsInteger,id_cliente);

       if id_pedido>0 then
       begin
            resultado := dmDescargaAttach.ObtenAttach(IntToStr(id_pedido),'pdf','P',id_attach);
            if resultado='' then
            begin
                 sShowMessage('Imprimir Adjunto','No existe adjunto asociado.');
                 insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','Boton Impr.Adj. ' + dm.q_packagr.FieldByName('codalbaran').AsString,'No existe adjunto asociado. Ped. ' + IntToStr(id_pedido) + ' ' + log_cabecera);
            end else
                insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','Boton Impr.Adj. ' + dm.q_packagr.FieldByName('codalbaran').AsString,'Ok. Ped. ' + IntToStr(id_pedido) + ' ' + resultado + ' ' + log_cabecera);
       end
       else begin
          sShowMessage('Imprimir Adjunto','No encontrado pedido asociado a este albarán.');
           insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','Boton Impr.Adj. ' + dm.q_packagr.FieldByName('codalbaran').AsString,'No encontrado pedido asociado a este albarán. Ped. ' + IntToStr(id_pedido) + ' ' + log_cabecera);
       end;
end;

procedure Tf_main.btLoteCancelClick(Sender: TObject);
begin
  pnLotes.Visible := False;
end;

procedure Tf_main.btLoteNoClick(Sender: TObject);
begin
  SolucionLoteno(edIdArtOculto.Value);
  LanzaMensajeError(bcInUse,'ARTICULO BLOQUEADO');
  pnLotes.Visible := False;
end;

procedure Tf_main.btLoteSiClick(Sender: TObject);
begin
   SolucionLotesi(edIdArtOculto.Value);
   pnLotes.Visible := False;
end;

procedure Tf_main.btLoteTodoClick(Sender: TObject);
begin
    SolucionLoteTodos(edIdArtOculto.Value);
    pnLotes.Visible := False;
end;

procedure Tf_main.btn1Click(Sender: TObject);
var
  albs_delivered: string;
  //datos: TStringDynArray;

  //i: Integer;
  //mal: string;
  //pedidos:TStringList;

begin
 { albs_delivered := GetExtraPedido(441209,'DATE_MAIL_DEST');
  showmessage(albs_delivered);

  enviar_email_pedidos(441209);

  pedidos := TStringList.Create;
  pedidos.Add('386044');
  frmLotes.EnviaLotes(pedidos,lbNombreCl.Caption,PC.Nombre,PC.IP,0, main_cli,cli_api_url,cli_api_user,cli_api_pass);
  pedidos.Free;  }
  end;

procedure Tf_main.fuerzaerror;
begin
    raise Exception.Create('Error del procedimiento forzar');
end;

procedure Tf_main.btPasarUdsClick(Sender: TObject);
begin
   if edUds.Value<=0 then
   begin
     ShowMessage('Las unidades deben ser mayor que 0.');
     exit;
   end;

   if edUds.Value>cdsreparto.FieldByName('uds').AsInteger then
   begin
     ShowMessage('Las uds. indicadas superan a las uds. del albarán seleccionado.');
     exit;
   end;

   if sMessageDlg('Va a abrir un nuevo bulto con ' + edUds.Text + ' uds. para la caja ' + cdsreparto.fieldbyname('num_cajas').AsString  + '. ¿Es correcto?',mtWarning, mbYesNo,mrNo)=mrYes then
   begin
       insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','Boton Nuevo Bulto' + cdsreparto.FieldByName('codalbaran').AsString,'Va a abrir un nuevo bulto con ' + edUds.Text + ' uds. para la caja ' + cdsreparto.fieldbyname('num_cajas').AsString  + '. ¿Es correcto? Respuesta operario: SI.' + ' ' + log_cabecera);
       nuevo_bulto(cdsreparto.fieldbyname('codalbaran').asinteger);
   end else
       insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','Boton Nuevo Bulto' + cdsreparto.FieldByName('codalbaran').AsString,'Va a abrir un nuevo bulto con ' + edUds.Text + ' uds. para la caja ' + cdsreparto.fieldbyname('num_cajas').AsString  + '. ¿Es correcto? Respuesta operario: NO.' + ' ' + log_cabecera);

end;

procedure Tf_main.bt_cambioClick(Sender: TObject);
var caja:string; id_packlin_bulto:Integer;
begin
  id_packlin_bulto:=dm.q_packagr.fieldbyname('id_packlin_bulto').asinteger;

  caja:='';
  if rg_caja.ItemIndex=0 then caja:='A';
  if rg_caja.ItemIndex=1 then caja:='B';
  if rg_caja.ItemIndex=2 then caja:='C';
  if rg_caja.ItemIndex=3 then caja:='D';
  if rg_caja.ItemIndex=4 then caja:='E';

  with tpfibquery.create(Self) do                         //Actualiza Datos
  try
    Database:=dm.db;
    Transaction:=dm.t_write;
    sql.Add('update a_packlin_bulto set tipo_caja=:tipo_caja '+
      ' where id_packlin_bulto=:id_packlin_bulto');
    parambyname('tipo_caja').asstring:=caja;
    ParamByName('id_packlin_bulto').AsInteger:=id_packlin_bulto;

    dm.t_write.StartTransaction;
    execquery;
    dm.t_write.commit;
  finally
    Free;
  end;

  dm.q_packagr.Close;
  dm.q_packagr.Open;
  act_cajas;
end;

procedure Tf_main.bt_cerrar_agrupClick(Sender: TObject);
var
  albs_enviados, albs_delivered, log, body, straux, error_aux: string;
  estado_ch, fin: Boolean;
  cb: Tf_barcode;
  pedidos, albs_aux, cuerpo: TStringList;
  i, id_pedido, id_caja:Integer;
begin

  //Screen.Cursor := crHourGlass;
  //bloquea(1);

  with tpfibdataset.Create(dm) do begin                                //Queda algo por picar
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select coalesce(sum(l.cantidad),0) as total '+
      'from a_packlin l '+
      'where l.id_packcab=:id_packcab and l.nivel_agr=:nivel_agr and l.id_agrupa=:id_agrupa and l.cantidad_i<>l.cantidad ');
    ParamByName('nivel_agr').asinteger:=nivel_agr;
    ParamByName('id_packcab').asinteger:=id_packcab;
    ParamByName('id_agrupa').asinteger:=id_agrupa;
    Open;

    if FieldByName('total').AsInteger>0 then begin                   //Uds pendientes
      if sMessageDlg('Quedan Artículos Pendientes de Pistolear, Proceder a Cerrar la Agrupación Y Descartar Los Pendientes?',mtWarning,[mbYes,mbno],0)=mryes
      then cerrar_agrupa_error
      else raise exception.Create('No Se Puede Cerrar Agrupación Con Artículos Pendientes De Leer');
    end;
    Free;
  end;

  if chRevLotes.Checked then
    log := ' Revisa lotes.'
  else
    log := '';

  if chEtiqCB.enabled and chEtiqCB.Checked then   //Se gestiona el albarán que lean en el codigo de barras de la etiqueta previa
  begin

      InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','Inicio cierre agrupacion lectura CB.',
                 lb_picking.Caption + ' ' + lbAgrupacion.Caption + log);

     { pnInput.Visible := True;
      edInput.SetFocus;   }


      fin := False;

      albs_enviados := '';

      while not fin do
      begin
        barcode := StrToIntDef(InputBox('Cierre de Albarán','Introduzca código de etiqueta previa',''),-1);

        //barcode := IntroBarcode;

        if barcode=-1 then
        begin
          if sMessageDlg('Texto vacío o inválido, ¿desea finalizar el proceso?',mtConfirmation,[mbYes,mbno],0)=mrYes then
                fin := true;
        end else begin

          with tpfibdataset.Create(dm) do begin                                   //cerrar albaran, print etiq bultos y hoja picking
            try
              database:=dm.db;
              SQLs.SelectSQL.Clear;
              SQLs.SelectSQL.Add('select l.codalbaran,b.id_caja, l.codrepartidor '+
                'from a_packlin l '+
                'inner join a_packlin_bulto b on (l.id_packlin_bulto=b.id_packlin_bulto) '+
                'where l.id_packcab=:id_packcab and l.nivel_agr=:nivel_agr and l.id_agrupa=:id_agrupa and l.codalbaran=:codalbaran '+
                'group by 1,2,3 order by b.id_caja');
              ParamByName('nivel_agr').asinteger:=nivel_agr;
              ParamByName('id_packcab').asinteger:=id_packcab;
              ParamByName('id_agrupa').asinteger:=id_agrupa;
              ParamByName('codalbaran').asinteger:=barcode;
              Open;

              first;

              if not isempty then begin

                id_caja := FieldByName('id_caja').AsInteger;

                lb_st1.Caption := 'Procesando ' + InttoStr(barcode) + '...';

                cerrar_albaran(barcode);

                if FieldByName('codrepartidor').AsInteger<46000 then
                begin

                  //if CargarDatosTablaGestoras('agencias','lstname_etiqueta','agencia='+ CargarDatosTablaGestoras('albaranes','agencia','id_albaran='+InttoStr(barcode)))='ETI_LOGINSER' then
                  if dmLabels.GetFormatoEtiqueta(barcode)='ETI_LOGINSER' then
                  begin
                     try
                       dmLabels.imp_eti := u_globals.imp_eti;
                       dmLabels.imprime_etiqueta_loginser(barcode,0, logo_cli_etiq);
                       InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','Bt.CerrarAgr. Et.Lgs ' + IntToStr(barcode),log_cabecera);
                     except on e:exception do begin
                              InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','Bt.CerrarAgr. Et.Lgs.Error ' + IntToStr(barcode) ,e.message);
                              raise Exception.Create('Error generando bultos API. ' + #13#10 + e.message);
                            end;
                     end;

                  end
                  else begin
                     try
                       imprime_etiqueta_x_api(barcode);
                       InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','Bt.CerrarAgr. Et.API ' + IntToStr(barcode),log_cabecera);
                     except
                        on e:exception do begin
                              InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','Bt.CerrarAgr. Et.API.Error ' + IntToStr(barcode) ,e.message);
                              raise Exception.Create('Error generando bultos API. ' + #13#10 + e.message);
                            end;
                     end;
                  end;

                end else begin
                  if FieldByName('codrepartidor').AsInteger=46120 then   //ASM
                         imprime_eti_bulto_asm(barcode)
                    else
                          imprime_eti_bulto(barcode);
                  InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','Bt.CerrarAgr. Et.Bulto. ' + IntToStr(barcode) + ' Repart.' + FieldByName('codrepartidor').AsString,log_cabecera);
                end;


                if chHojaPick.Checked then
                        imprime_hoja_pick(barcode);

                if cb_send_email.Checked and (get_email_albaran(barcode)<>'') then
                begin
                      enviar_email_a_destino(barcode);
                      InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','Bt.CerrarAgr. Email ' + IntToStr(barcode),log_cabecera);
                end;

                albs_enviados := albs_enviados + IntToStr(barcode) + ',';
              end else
                      id_caja := -1;

            finally
                Free;
            end;
          end;

          //if existe_albaran(barcode) then  lo comento porque ralentiza el proceso

          error_aux := '';
          error_aux := inserta_estado_albaran(barcode,punteo_almacen_usu, punteo_almacen_est,punteo_almacen_obs + ' EtXLectCB.Cj'+IntToStr(id_caja));

          if error_aux='' then
             InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','PackAb.1El.EtXLect.RevLoteTodo Est.Ped.=E Alb=' + IntToStr(barcode),log_cabecera)
          else
             InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','PackAb.1El.EtXLect.RevLoteTodo Est.Ped.=E Alb=' + IntToStr(barcode) + ' Error',log_cabecera + ' ' +  error_aux);

          dm.q_packagr.close;
          dm.q_packagr.open;
          dm.q_packagr.Locate('codalbaran',barcode,[]);
          lb_st1.Caption := 'Proceso Finalizado.';
        end;

      end;
  end
  else
  begin
      InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','Bt.CerrarAgr. Inicio cierre agrupacion ' + lbAgrupacion.Caption, log);

      estado_ch := chEtiqCB.Enabled;
      chEtiqCB.Enabled := False;

        with tpfibdataset.Create(dm) do begin                                   //cerrar albaran, print etiq bultos y hoja picking
          database:=dm.db;
          SQLs.SelectSQL.Clear;
          SQLs.SelectSQL.Add('select l.codalbaran,b.id_caja, l.codrepartidor '+
            'from a_packlin l '+
            'inner join a_packlin_bulto b on (l.id_packlin_bulto=b.id_packlin_bulto) '+
            'where l.id_packcab=:id_packcab and l.nivel_agr=:nivel_agr and l.id_agrupa=:id_agrupa '+
            'group by 1,2,3 order by b.id_caja');
          ParamByName('nivel_agr').asinteger:=nivel_agr;
          ParamByName('id_packcab').asinteger:=id_packcab;
          ParamByName('id_agrupa').asinteger:=id_agrupa;
          Open;

          first;

          albs_enviados := '';

          while not(eof) do begin

            lb_st1.Caption := 'Procesando ' + FieldByName('codalbaran').AsString + '...';
            application.processmessages;

            id_caja := FieldByName('id_caja').asinteger;

            cerrar_albaran(FieldByName('codalbaran').asinteger);
            InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','Bt.CerrarAgr. CerradoAlb. ' + FieldByName('codalbaran').asString,log_cabecera);

            if FieldByName('codrepartidor').AsInteger<46000 then
            begin

              //if CargarDatosTablaGestoras('agencias','lstname_etiqueta','agencia='+ CargarDatosTablaGestoras('albaranes','agencia','id_albaran='+FieldByName('codalbaran').AsString))='ETI_LOGINSER' then
              if dmLabels.GetFormatoEtiqueta(FieldByName('codalbaran').AsInteger)='ETI_LOGINSER' then
              begin
                   try
                      dmLabels.imp_eti := u_globals.imp_eti;
                      dmLabels.imprime_etiqueta_loginser(FieldByName('codalbaran').AsInteger,0,logo_cli_etiq);
                      InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','Bt.CerrarAgr. Et.Lgs ' + FieldByName('codalbaran').asString,log_cabecera);

                   except on e:exception do begin
                              InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','Bt.CerrarAgr. Et.Lgs.Error ' + FieldByName('codalbaran').AsString ,e.message);
                              raise Exception.Create('Error generando bultos API. ' + #13#10 + e.message);
                            end;

                   end;
              end
              else begin
                   try
                      imprime_etiqueta_x_api(FieldByName('codalbaran').AsInteger);
                      InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','Bt.CerrarAgr. Et.API ' + FieldByName('codalbaran').asString,log_cabecera);
                   except on e:exception do begin
                              InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','Bt.CerrarAgr. Et.API.Error ' + FieldByName('codalbaran').asstring ,e.message);
                              raise Exception.Create('Error generando bultos API. ' + #13#10 + e.message);
                            end;

                   end;
              end;

            end else begin
              if FieldByName('codrepartidor').AsInteger=46120 then   //ASM
                     imprime_eti_bulto_asm(FieldByName('codalbaran').AsInteger)
                else
                      imprime_eti_bulto(FieldByName('codalbaran').AsInteger);
              InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','Bt.CerrarAgr. Et.Bulto ' + FieldByName('codalbaran').asString + ' Repart.' + FieldByName('codrepartidor').AsString,log_cabecera);
            end;

            if chHojaPick.Checked then
            begin
                    imprime_hoja_pick(FieldByName('codalbaran').AsInteger);
                    //InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','Bt.CerrarAgr. HPick. ' + FieldByName('codalbaran').asString,log_cabecera);
            end;

            if cb_send_email.Checked and (get_email_albaran(FieldByName('codalbaran').AsInteger)<>'') then
            begin
                  enviar_email_a_destino(FieldByName('codalbaran').AsInteger);
                  InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','Bt.CerrarAgr. Email ' + FieldByName('codalbaran').asString,log_cabecera);
            end;

            albs_enviados := albs_enviados + FieldByName('codalbaran').AsString + ',';

            error_aux := '';
            error_aux := inserta_estado_albaran(FieldByName('codalbaran').AsInteger,punteo_almacen_usu, punteo_almacen_est,punteo_almacen_obs + ' Cierre completo.Cj'+IntToStr(id_caja));

            if error_aux='' then
              InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','Bt.CerrarAgr. Est.Alb.CierreCompleto. ' + FieldByName('codalbaran').asString,log_cabecera)
            else
              InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','Bt.CerrarAgr. Est.Alb.CierreCompleto. ' + FieldByName('codalbaran').asString + 'Error',log_cabecera + ' ' +error_aux);

            next;
          end;

          Free;
        end;

     end;

      application.processmessages;

      if envia_delivered then
      begin
       lb_st1.Caption := 'Enviando delivered...';

       enviar_status_delivered(albs_delivered);

       albs_delivered := Copy(albs_delivered,1,Length(albs_delivered)-1);

       if albs_delivered<>'' then
       begin
          with tpfibquery.create(Self) do                         //Actualiza enviado_fich a enviado delivered
          try
            Database:=dm.db;
            Transaction:=dm.t_write;
            sql.Add('update c_pedidos set enviado_fich=:marca_delivered ');
            SQL.Add(' where codalbaran in (' + albs_delivered + ') and id_cliente=:id_cliente');
            ParamByName('marca_delivered').AsInteger := marca_delivered;
            ParamByName('id_cliente').AsInteger := id_cliente;

            dm.t_write.StartTransaction;
            execquery;
            dm.t_write.commit;
            InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','Bt.CerrarAgr. EnvioDelivered ' + albs_delivered,'');
          finally
            Free;
          end;
       end;
      end;


      if revisa_lotes then straux := 'revisa_lotes=true' else straux := 'revisa_lotes=false';
      if chRevLotes.Checked then straux := straux + #13#10 + 'chRevLotes.Checked=true' else straux := straux + #13#10 + 'chRevLotes.Checked=false';
      straux := straux + #13#10 + Copy(albs_enviados,1,Length(albs_enviados)-1);

      //ShowMessage(straux);

      if revisa_lotes and chRevLotes.Checked and (Copy(albs_enviados,1,Length(albs_enviados)-1)<>'') then
      begin

         InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','Ini EnviaLotes ' + Copy(albs_enviados,1,Length(albs_enviados)-1),'');
         lb_st1.Caption := 'Enviando lotes a cliente...';
         Application.ProcessMessages;

         pedidos := TStringList.Create;
         albs_aux := TStringList.Create;
         albs_aux.Delimiter := ',';
         albs_aux.DelimitedText := Copy(albs_enviados,1,Length(albs_enviados)-1);

         for I := 0 to albs_aux.Count-1 do
         begin
             id_pedido := GetIdPedidoXAlbaran(StrToInt(albs_aux[i]),id_cliente);
             if id_pedido>0 then
                 pedidos.Add(IntToStr(id_pedido));
         end;

         InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','Ini ActualizaLotes ' + Copy(albs_enviados,1,Length(albs_enviados)-1),'');

         if StrToInt(cl_padres[0])>0 then
         begin
           i := 0;
           while (i<=High(cl_padres)) do
           begin
              frmLotes.ActualizaLotes(main_cli,StrToInt(cl_padres[i]),usuario.id,pedidos,lbNombreCl.Caption,PC.Nombre,PC.IP);
              Inc(i);
           end;
         end else
               frmLotes.ActualizaLotes(main_cli,StrToInt(cl_padres[0]),usuario.id,pedidos,lbNombreCl.Caption,PC.Nombre,PC.IP);

         InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','Fin ActualizaLotes ' + Copy(albs_enviados,1,Length(albs_enviados)-1),'');

         if StrToInt(cl_padres[0])>0 then
         begin
           i := 0;
           while (i<=High(cl_padres)) do
           begin
              cli_api_url := get_item_config_cliente(StrToInt(cl_padres[i]),'api_url');
              cli_api_user := get_item_config_cliente(StrToInt(cl_padres[i]),'api_user');
              cli_api_pass := get_item_config_cliente(StrToInt(cl_padres[i]),'api_pass');
              frmLotes.EnviaLotes(pedidos,lbNombreCl.Caption,PC.Nombre,PC.IP,0, StrToInt(cl_padres[i]),cli_api_url,cli_api_user,cli_api_pass);
              Inc(i);
           end;
         end else
                frmLotes.EnviaLotes(pedidos,lbNombreCl.Caption,PC.Nombre,PC.IP,0, main_cli,cli_api_url,cli_api_user,cli_api_pass);

         InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','Fin EnviaLotes ' + Copy(albs_enviados,1,Length(albs_enviados)-1),'');
      end;

      if revisa_lotes and not chRevLotes.Checked then
      begin
         InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','Bt.CerrarAgr.NO ENVIADO LOTES.CHK NO SELECCIONADO. Albs:' + Copy(albs_enviados,1,Length(albs_enviados)-1) ,log_cabecera);
         body := '<html><head><link rel="stylesheet" href="((imgs_ftp))estilos.css"></head>'+
                  '<body><table border=0> ' +
                  '<tr><td>El cliente tiene configurada la opción de revisión y envío de lotes.</td></tr>'+
                  '<tr><td>El check <i>Confirmar Lotes</i> no está marcado durante el cierre de la agrupación.</td></tr>'+
                  '<tr><td>Por favor, si es correcto, ignore este mensaje.</td></tr> '+
                  '<tr><td>En caso contrario, tome las medidas oportunas.</td></tr>'+
                  '<tr><td>Gracias.</td></tr>'+
                  '</table></body><html>';

          cuerpo:=tstringlist.Create;
          cuerpo.Add(body);
          f_envia_mail.Show;
          f_envia_mail.envia_email(mail_error,'','NO ENVIADO LOTES A CLIENTE ' + log_cabecera,
                                   '','', cuerpo);
          f_envia_mail.Close;
          u_functions.insertalog(usuario.id,id_packcab,0,PC.nombre,PC.ip,'','','','Bt.CierreAgr. Email no enviado lotes ' + mail_error,body);
          cuerpo.Free;
      end;

      lb_st1.Caption := 'Actualizando pedidos a Enviado...';
      Application.ProcessMessages;

      if Copy(albs_enviados,1,Length(albs_enviados)-1)<>'' then
      begin
        with tpfibquery.create(Self) do                         //Actualiza Datos
        try
          Database:=dm.db;
          Transaction:=dm.t_write;
          sql.Add('update c_pedidos set estado=:estado, fecha_fin=:fecha ');
          SQL.Add(' where codalbaran in (' + Copy(albs_enviados,1,Length(albs_enviados)-1) + ')');
          parambyname('estado').AsString := 'E';
          ParamByName('fecha').AsDateTime:=Now;

          dm.t_write.StartTransaction;
          execquery;
          dm.t_write.commit;
          InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','Bt.CierreAgr. Act.Est.Ped=E Albs:' + Copy(albs_enviados,1,Length(albs_enviados)-1) ,log_cabecera);
        finally
          Free;
        end;
      end;

     chEtiqCB.Enabled := estado_ch;

      //bloquea(0);
      //Screen.Cursor := crDefault;

      InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','Bt.CierreAgr. Fin cierre agrupacion ' + lbAgrupacion.Caption,log_cabecera);

      lb_st1.Caption := 'Proceso Finalizado.';
      If sMessageDlg('Proceso Finalizado....',mtInformation,[mbok],0)=mrOk then
          InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','Bt.CierreAgr. Bt.ProcesoFinalizado.OK ' + lbAgrupacion.Caption,log_cabecera)
      else
          InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','Bt.CierreAgr. Bt.ProcesoFinalizado.NO_OK ' + lbAgrupacion.Caption,log_cabecera);

     If not TieneLecturasPendientes(id_packcab) then
     begin
          btFin.Enabled := (packingfinalizado(id_packcab)<= EncodeDate(1900,1,1));
          if btfin.Enabled then
              width := 1549
          else
              width := 1490;
     end else
          Width := 1490;

end;

procedure Tf_main.bt_cerrar_cajaClick(Sender: TObject);
begin
    if sMessageDlg('Está Seguro de Querer Cerrar La Caja '+dm.q_packagr.fieldbyname('id_caja').asstring+', Albarán '+dm.q_packagr.fieldbyname('codalbaran').asstring+' Y Abrir Una Nueva?',mtconfirmation,[mbYes,mbno],0)=mrYes then begin
   if (dm.q_packagr.FieldByName('total').AsInteger=dm.q_packagr.FieldByName('pendiente').asinteger) then raise exception.Create('No Se Puede Cerrar Una Caja Vacia');
   cerrar_caja_y_nueva(dm.q_packagr.fieldbyname('codalbaran').asinteger,dm.q_packagr.fieldbyname('id_packlin_bulto').asinteger);
  end;
end;

procedure Tf_main.bt_imp_pickClick(Sender: TObject);
begin
    imprime_hoja_pick(dm.q_packagr.FieldByName('codalbaran').Asinteger);
    InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','Boton HPick ' + dm.q_packagr.FieldByName('codalbaran').asstring,log_cabecera);
end;

procedure Tf_main.bt_lectura_manualClick(Sender: TObject);
var
  enc: Boolean;
  i:integer;
begin
  enc := False;
  i := 0;

    with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select id_articulo '+
      'from g_articulos '+
      'where codigo=:codigo and id_cliente=:id_cliente');
    ParamByName('codigo').asstring:=dm.q_pack.FieldByName('codigo').asstring;
    if StrToInt(cl_padres[0])<0 then  begin
      ParamByName('id_cliente').AsInteger:= id_cliente;
      Open;
    end
    else begin
      while (not enc) and (i<=High(cl_padres)) do
      begin
        ParamByName('id_cliente').asInteger:= StrToInt(cl_padres[i]);
        Open;
        enc := not IsEmpty;
        if not enc then
          Close;
        Inc(i);
      end;
    end;

    if not(IsEmpty) then begin

      if ArticuloBloqueado(FieldByName('id_articulo').asinteger) then
      begin
        sShowMessage('Artículo Bloqueado','Consulte con el responsable.');
        InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','Articulo bloqueado ' + dm.q_pack.FieldByName('codigo').asstring +
                   '(id.' + FieldByName('id_articulo').asstring + ')',log_cabecera);
        Free;
        Exit
      end;

      InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','Lectura manual ' + dm.q_pack.FieldByName('codigo').asstring,log_cabecera);

      if only_one then ejecuta_lectura(FieldByName('id_articulo').asinteger,'',-1,false)
      else ejecuta_lectura(FieldByName('id_articulo').asinteger,'',dm.q_pack.FieldByName('codalbaran').asinteger,false, dm.q_pack.FieldByName('id_lote').asinteger);
    end;

    Free;
  end;
end;

procedure Tf_main.imprime_hoja_pick(codalbaran:Integer);
var
  bc, bc2: string;
  tiene_pedido_alm: Boolean;
begin
  if (id_cliente = 6702) then begin
    imprime_hoja_pick_lis(codalbaran);
  end else begin

    case rgFmtHPick.ItemIndex of
      0: begin
          dm_pick.imprime_hoja_pick('p','',tiene_lotes,codalbaran);
          insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','HPick Print ' + IntToStr(codalbaran),log_cabecera);
      end;
      1: begin
          dm_pick.imprime_hoja_pick('z','',tiene_lotes,codalbaran);
          insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','HPick Zebra ' + IntToStr(codalbaran),log_cabecera);
      end;
      2:begin
          dm_pick.imprime_hoja_pick('p','',tiene_lotes,codalbaran);
          dm_pick.imprime_hoja_pick('z','',tiene_lotes,codalbaran);
          insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','HPick PrintZebra ' + IntToStr(codalbaran),log_cabecera);
      end;
    end;

  end;
end;

procedure Tf_main.imprime_hoja_pick_lis(codalbaran: Integer; send_email:boolean=false);
var   bc,bc2:string;        path,filename,email:string;         cuerpo:tstringlist;     idx_pais:Integer;
begin
  ar_lis_ds.Close;
  ar_lis_ds.Active:=true;
  ar_lis_ds.EmptyDataSet;

  dm.q_hoja_pick.Close;
  dm.q_hoja_pick.SelectSQL.Clear;
  dm.q_hoja_pick.SelectSQL.Add('select l.id_articulo,a.nombre,a.codigo,lo.id_lote,lo.nombre as n_lote,lo.caducidad, '+
    '  sum(l.cantidad) as cantidad '+
    'from a_packlin l '+
    'inner join g_articulos a on (l.id_articulo=a.id_articulo) '+
    'inner join a_lotes lo on (lo.id_lote = l.id_lote) '+
    'where l.id_packcab=:id_packcab and l.id_agrupa=:id_agrupa and l.nivel_agr=:nivel_agr and l.codalbaran=:codalbaran '+
    'group by 1,2,3,4,5,6 '+
    'order by 2');
  dm.q_hoja_pick.ParamByName('nivel_agr').asinteger:=nivel_agr;
  dm.q_hoja_pick.ParamByName('id_packcab').asinteger:=id_packcab;
  dm.q_hoja_pick.ParamByName('id_agrupa').asinteger:=id_agrupa;
  dm.q_hoja_pick.ParamByName('codalbaran').asinteger:=codalbaran;
  dm.q_hoja_pick.Open;

  dm.q_hoja_pick.First;

  dm.q_fib2.Close;
  dm.q_fib2.SelectSQL.Clear;
  dm.q_fib2.SelectSQL.Add('select * '+
      'from c_pedidos_lis c '+
      'where c.id_order=:id_order');
  dm.q_fib2.ParamByName('id_order').AsInteger:=codalbaran;
  dm.q_fib2.Open;

  while not(dm.q_hoja_pick.eof) do begin
    ar_lis_ds.insert;
    ar_lis_ds.FieldByName('id_art').asstring:=dm.q_hoja_pick.FieldByName('id_articulo').asstring;
    ar_lis_ds.FieldByName('ref_art').AsString:=dm.q_hoja_pick.FieldByName('codigo').asstring;
    ar_lis_ds.FieldByName('uds').Asinteger:=dm.q_hoja_pick.FieldByName('cantidad').asinteger;
    ar_lis_ds.FieldByName('id_lote').Asinteger:=dm.q_hoja_pick.FieldByName('id_lote').asinteger;
    ar_lis_ds.FieldByName('n_lote').Asstring:=dm.q_hoja_pick.FieldByName('n_lote').asstring;
    ar_lis_ds.FieldByName('caducidad').Asdatetime:=dm.q_hoja_pick.FieldByName('caducidad').asdatetime;

    dm.q_fib.Close;
    dm.q_fib.SelectSQL.Clear;
    dm.q_fib.SelectSQL.Add('SELECT first 2 bc from g_articulos_bc where id_articulo=:id_articulo order by id_articulo_bc asc');
    dm.q_fib.ParamByName('id_articulo').AsInteger:=dm.q_hoja_pick.FieldByName('id_articulo').asinteger;
    dm.q_fib.Open;

    bc:='';  bc2:='NO_BARCODE';
    if not(dm.q_fib.IsEmpty) then begin
      bc:=dm.q_fib.FieldByName('bc').AsString;
      dm.q_fib.Next;
      if not(dm.q_fib.Eof) then bc2:=dm.q_fib.FieldByName('bc').AsString;
    end;

    ar_lis_ds.FieldByName('ean').AsString:=bc;
    ar_lis_ds.FieldByName('ean2').AsString:=bc2;
    ar_lis_ds.FieldByName('articulo').Asstring:=dm.q_hoja_pick.FieldByName('nombre').asstring;
    ar_lis_ds.FieldByName('codalbaran').asstring:=dm.q_fib2.FieldByName('id_order').asstring;
    ar_lis_ds.FieldByName('pedido').asstring:=dm.q_fib2.FieldByName('id_order').asstring;
    ar_lis_ds.FieldByName('empresa').AsString:=dm.q_fib2.FieldByName('empresa').asstring;
    ar_lis_ds.FieldByName('nomape').asstring:=dm.q_fib2.FieldByName('nombre').asstring;
    ar_lis_ds.FieldByName('direccion').asstring:=dm.q_fib2.FieldByName('dir_1').asstring;
    ar_lis_ds.FieldByName('poblacion').asstring:=dm.q_fib2.FieldByName('poblacion').asstring;
    ar_lis_ds.FieldByName('provincia').asstring:=dm.q_fib2.FieldByName('provincia').asstring;
    ar_lis_ds.FieldByName('cp').asstring:=dm.q_fib2.FieldByName('cp').asstring;
    ar_lis_ds.FieldByName('mail').asstring:=dm.q_fib2.FieldByName('email').asstring;
    ar_lis_ds.FieldByName('telefono').asstring:=dm.q_fib2.FieldByName('telefono').asstring;
    ar_lis_ds.fieldbyname('repartidor').asstring:=dm.q_fib2.FieldByName('repartidor').asstring;
    ar_lis_ds.fieldbyname('precinto').asstring:=dm.q_fib2.FieldByName('precinto').asstring;
    ar_lis_ds.fieldbyname('id_pais').asstring:=dm.q_fib2.FieldByName('id_pais').asstring;
    ar_lis_ds.fieldbyname('portes').asstring:=dm.q_fib2.FieldByName('portes').asstring;
    ar_lis_ds.fieldbyname('reembolso').asstring:=dm.q_fib2.FieldByName('reembolso').asstring;
    ar_lis_ds.Post;

    dm.q_hoja_pick.next;
  end;

  idx_pais := pais_to_idx(dm.q_fib2.FieldByName('id_pais').asstring);
  translate(idx_pais);

  if ((send_email) and (uppercase(dm.q_fib2.FieldByName('precinto').asstring) <> 'NEUTRO') and (uppercase(dm.q_fib2.FieldByName('repartidor').asstring) <> 'PROPIO')) then begin
    //path:=sys_path+pick_path+'\'+formatdatetime('yyyy.mm.dd',now);
    path:=u_globals.ruta_exe+'bak\'+formatdatetime('yyyy.mm.dd',now);
    filename:=path+'\'+inttostr(codalbaran)+'.pdf';

    ForceDirectories(path);
    pdf_export.FileName:=filename;

    rep_lis.PrepareReport(True);
    rep_lis.Export(pdf_export);

    email := dm.q_fib2.fieldbyname('email').asstring;
    //email := 'marta@thelifeisshort.com, gerencia@loginser.com';

    cuerpo:=tstringlist.Create;
    cuerpo.Add(email_trans[0][idx_pais] + ' ' + dm.q_fib2.fieldbyname('empresa').asstring+'<br><br>');
    cuerpo.Add(email_trans[1][idx_pais] + ' ' + dm.q_fib2.fieldbyname('id_order').asstring + ' ' + email_trans[2][idx_pais] + '.<br><br>');
    cuerpo.Add(dm.q_fib2.fieldbyname('dir_1').asstring+'<br>'+ dm.q_fib2.fieldbyname('cp').asstring+' - '+dm.q_fib2.fieldbyname('poblacion').asstring+' - '+dm.q_fib2.fieldbyname('provincia').asstring+'<br><br>');
    cuerpo.Add(email_trans[3][idx_pais]);
    if dm.q_fib2.fieldbyname('id_repartidor').asinteger = 0 then begin
      cuerpo.Add(email_trans[4][idx_pais] + ' CorreosExpress<br><b>'+
        dm.q_fib2.fieldbyname('agencia_nexp').asstring+'</b><br><br>');
      cuerpo.Add(email_trans[5][idx_pais] + ':<br>'+
       '<a href="https://www.correosexpress.com/url/v?s='+dm.q_fib2.fieldbyname('agencia_nexp').asstring+'&cp='+dm.q_fib2.fieldbyname('cp').asstring+'">'+email_trans[6][idx_pais]+'</a><br><br>');
    end;

    cuerpo.Add(email_trans[7][idx_pais] + '.<br><br>');
    cuerpo.Add(email_trans[8][idx_pais]);

    ////////////////////////////
   { f_envia_mail.Show;
    f_envia_mail.envia_email(email,'marta@thelifeisshort.com',
    //f_envia_mail.envia_email(email,'informatica@loginser.com',
        'Pedido Life Is Short '+dm.q_fib2.fieldbyname('id_order').asstring,
        filename,
        cuerpo,
        2);
    f_envia_mail.close;      }
   cuerpo.Free;
  end;

  if not(send_email) then begin
  //  if rep_lis.PrepareReport(True) then rep_lis.print;
  end;
end;

procedure Tf_main.bt_print_bultosClick(Sender: TObject);
begin

 if dm.q_packagr.FieldByName('codrepartidor').AsInteger<46000 then
 begin
   //if CargarDatosTablaGestoras('agencias','lstname_etiqueta','agencia='+ CargarDatosTablaGestoras('albaranes','agencia','id_albaran='+dm.q_packagr.FieldByName('codalbaran').AsString))='ETI_LOGINSER' then
   if dmLabels.GetFormatoEtiqueta(dm.q_packagr.FieldByName('codalbaran').AsInteger)='ETI_LOGINSER' then
   begin
     dmLabels.imp_eti := u_globals.imp_eti;
     dmLabels.imprime_etiqueta_loginser(dm.q_packagr.FieldByName('codalbaran').AsInteger,0,logo_cli_etiq);
     insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','Bt.Et.Bultos.Lgs. ' + dm.q_packagr.FieldByName('codalbaran').AsString,log_cabecera);
   end
   else begin
     imprime_etiqueta_x_api(dm.q_packagr.FieldByName('codalbaran').AsInteger);
     insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','Bt.Et.Bultos.API. ' + dm.q_packagr.FieldByName('codalbaran').AsString,log_cabecera);
   end;
 end else begin
      if dm.q_packagr.FieldByName('codrepartidor').AsInteger=46120 then
           imprime_eti_bulto_asm(dm.q_packagr.FieldByName('codalbaran').Asinteger)
      else
           imprime_eti_bulto(dm.q_packagr.FieldByName('codalbaran').Asinteger);
      insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','Bt.Et.Bultos. ' + dm.q_packagr.FieldByName('codalbaran').AsString,log_cabecera);
 end;
end;

procedure Tf_main.bt_print_indivClick(Sender: TObject);
begin
  imprime_eti_indiv(id_packcab,id_agrupa,nivel_agr,dm.q_pack_leido.FieldByName('linea').AsInteger);
end;

procedure Tf_main.bt_print_prevClick(Sender: TObject);
begin
  print_etiq_pre(dm.q_packagr.FieldByName('codalbaran').Asstring, dm.q_packagr.FieldByName('tipo_caja').Asstring,
      dm.q_packagr.FieldByName('codrepartidor').AsString, dm.q_packagr.FieldByName('id_ruta').AsString,
      dm.q_packagr.FieldByName('id_caja').asinteger,dm.q_packagr.FieldByName('id_packlin_bulto').asinteger,
      dm.q_packagr.FieldByName('n_bulto').asinteger,dm.q_packagr.FieldByName('total').asinteger);

 InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','Boton Et.Previa', log_cabecera + ' ' +
 'alb=' + dm.q_packagr.FieldByName('codalbaran').Asstring + ',tipo_caja=' + dm.q_packagr.FieldByName('tipo_caja').Asstring +
 ',repart=' + dm.q_packagr.FieldByName('codrepartidor').AsString + ',id_ruta=' + dm.q_packagr.FieldByName('id_ruta').AsString +
 'id_caja=' + dm.q_packagr.FieldByName('id_caja').AsString + ',id_bulto=' + dm.q_packagr.FieldByName('id_packlin_bulto').AsString +
 ',n_bulto=' + dm.q_packagr.FieldByName('n_bulto').AsString + ',uds=' + dm.q_packagr.FieldByName('total').AsString);

end;

procedure Tf_main.b_pickingClick(Sender: TObject);
begin

    with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;   row_height:=40;
    fields.commatext:='cp.id_packcab,sum(lp.cantidad),cp.nombre,cp.id_cliente';
    titulos.commatext:='Packing,Cantidad,Nombre,Cliente';
    from:='a_packcab cp  '+
      'inner join a_packlin lp on (lp.id_packcab=cp.id_packcab)';
    where:='cp.modo=4 and cp.id_almacen='+inttostr(u_globals.id_almacen_def);

    case rg1.ItemIndex of
       0: where := where + ' and lp.cantidad_i<lp.cantidad';  //pendientes
       1: where := where + ' and lp.cantidad_i>=lp.cantidad'; //completos
    end;

    orden[1]:=1;   orden_ini:=1;  group:='cp.id_packcab,cp.nombre,cp.id_cliente';
    busca:=1;   distinct:=0;   fillimpio:=True;

    showmodal;

    if resultado then begin
      lb_picking.Caption:=valor[3];
      id_packcab:=valor[1];
      id_cliente:=valor[4];
      modo:=4;
      gb_pack.Visible:=false;
      gb_cajas.Visible:=false;
      pnReparto.Visible:=false;

      q1.Close;
      q1.ParamByName('id').AsInteger := id_cliente;
      q1.Open;

      get_cliente_config(id_cliente);

      cb_send_email.Checked := envia_correo_a_dst;
      chAdjunto.Enabled := (tipo_adjunto<>'');
      chAdjunto.checked := (tipo_adjunto<>'') and envia_correo_a_dst;
      lbLotes.Visible := tiene_lotes;

      if cl_nombre_gr='' then
           lbNombreCl.Caption := valor[4] + ' ' + BuscaCliente(valor[4])
      else
           lbNombreCl.Caption :=  valor[4] + ' ' + BuscaCliente(valor[4]) + ' (Grupo ' + cl_nombre_gr + ')';

      main_cli := id_cliente;

      if not DirectoryExists(dir_temp) then
        CreateDir(dir_temp);

      if not DirectoryExists(dir_temp+IntToStr(main_cli)+'\') then
         CreateDir(dir_temp+IntToStr(main_cli)+'\');

      btImpAdj.Enabled := tiene_adjuntos;

      cb_one_read_marks_all.Enabled := ch_1marcatodo;
      cb_one_read_marks_all.Checked := ch_1marcatodo_chk;

      chRevLotes.Enabled := (tiene_lotes and (not cb_one_read_marks_all.Checked));
      chRevLotes.Checked := tiene_lotes and revisa_lotes and not cb_one_read_marks_all.Checked;

      InsertaLog(usuario.id,id_packcab,0,PC.Nombre,pc.IP,log_app,'id_packcab','','Ini Packing',lb_picking.Caption);

      fecha_fin := packingfinalizado(id_packcab);

      if (fecha_fin>EncodeDate(1900,1,1)) then
      begin
         lbFin.caption := FormatDateTime('dd.mm.yyyy hh:nn:ss', fecha_fin);
         lbFin.Visible := True;
      end else
            lbFin.Visible := False;

      If not TieneLecturasPendientes(id_packcab) then
      begin
         if (fecha_fin<=EncodeDate(1900,1,1)) then
         begin
          //btFin.Visible := True;
          f_main.Width := 1549;
         end else
                f_main.Width := 1490;
      end else
                f_main.Width := 1490;

    end;
  end;
end;

procedure Tf_main.FormActivate(Sender: TObject);
var
  flog: TfrmLogin;
begin
 { try
    flog := TfrmLogin.Create(Self);
    flog.edUsuario.Text := u_globals.usuario_nom;
    flog.Position := poDesktopCenter;
    flog.ShowModal;
  finally
    flog.Free;
  end;

  if usuario.id=-1 then
        Close;

  u_globals.usuario_nom := usuario.Nombre;

  f_main.Caption := 'PACKING ABIERTO ' + v + ' - ' + IntToStr(usuario.id) + ' ' + usuario.Nombre ; }
end;

procedure Tf_main.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','Cerrado Packing Abierto' ,'');
  dm.t_read.Active := False;
end;

procedure Tf_main.FormCreate(Sender: TObject);
begin
   if (ALERTA<>'LISTO') then
      ShowMessage('CUIDADO!!!!! PROYECTO EN DESARROLLO!!!! AVISA A INFORMATICA!!!');

  leer_ini;

  imp_def := u_globals.imp_def;
  imp_eti := u_globals.imp_eti;

  if u_globals.x<0 then u_globals.x:=(Screen.width-width) div 2;
  if u_globals.y<0 then u_globals.y:=(Screen.height-height) div 2;
  left:=u_globals.x;                                          //asigna posicion
  top:=u_globals.y;


  leer_ini_gestoras;
  ini_bd_simple;
  ini_bd_gestoras;
  lee_inis_def;
  if db_sql<>'' then
  begin
     // dm.con1.Connected := False;
      dm.con1.ConnectionString := db_sql;
      //dm.con1.Connected := True;
  end;

  get_defaults;

  leer_ini_bbdd(u_globals.id_usuario);

  PC.Nombre := GetComputerName;
  PC.IP := LocalIP;
  PC.Usuario := obtenerUsuarioRed;
  usuario.id := -1;
  usuario.Nombre := 'Usuario Desconocido';

  // showmessage(obtenerUsuarioRed);

  cb_maxcubic.Caption:='Cierre Automático Por Porcentaje Cúbico al '+inttostr(percent_cubic)+'%';

  lb_picking.Caption := '';
  lbNombreCl.Caption := '';
  lbAgrupacion.Caption := '';
  lbLotes.Visible := False;
  //fbuscapro.limpia_fields;


end;


procedure Tf_main.FormDblClick(Sender: TObject);
begin
 if HiWord(GetKeyState(VK_CONTROL)) <> 0 then
  btn1.Visible := not btn1.Visible;
end;

procedure Tf_main.FormDestroy(Sender: TObject);
begin
  u_globals.x:=left;                                          //guardar posicion actual
  u_globals.y:=top;
 { u_globals.w:=Width;                                        //guardar tamaño (si procede)
  u_globals.h:=Height; }
  u_globals.guardar_pos;
  if ((usuario_nom<>'') and (usuario_nom<>'Usuario Desconocido')) then
    guardar_ini;
end;

procedure Tf_main.FormShow(Sender: TObject);
var
  flog: TfrmLogin;
begin

   // api := GetConexion(api);

  with dm.q_con do
    begin
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select * from sys_conexiones where nombre=:nombre and activa=1');
      ParamByName('nombre').AsString := UpperCase(api);
      Open;
      First;

      if not (FieldByName('basedatos').AsString='') then
      begin
        api := FieldByName('basedatos').AsString;
      end else
            api :=  '';
     free;
    end;


  if api='' then
  begin
    ShowMessage('IMPORTANTE: Revise la configuración de API en su fichero Config.ini (api=API_TEST o API_PRO).' + #10#13 +
                'La aplicación se cerrará.');
    Application.Terminate;
  end;

  lbCon.Caption := dbname + ' ** ' +
                   db_gestoras + ' ** ' +
                   api;

  gb_pack.Visible:=False;
  gb_cajas.Visible:=false;
  pnReparto.Visible:=false;

  f_main.Caption := 'PACKING ABIERTO ' + v ;
  lbCon.Caption := dbname + ' ** ' +
                   db_gestoras + ' ** ' +
                   api;

  lbCLAlm.Caption := 'Centro L. ' + IntToStr(u_globals.cent_lect) + ' - Alm. ' +  IntToStr(u_globals.id_almacen_def);

  try
    flog := TfrmLogin.Create(Self);
    flog.edUsuario.Text := u_globals.usuario_nom;
    flog.Position := poDesktopCenter;
    flog.ShowModal;
  finally
    flog.Free;
  end;

  if usuario.id=-1 then
        Application.Terminate;

  u_globals.usuario_nom := usuario.Nombre;

  f_main.Caption := 'PACKING ABIERTO ' + v + ' - ' + IntToStr(usuario.id) + ' ' + usuario.Nombre + ' -- BETA';

  InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,'PA','','','Abierto Packing Abierto' ,'');

  lbCajaGrande.Caption:= '';
  lbCajaGrande.Visible := False;
end;

procedure Tf_main.get_defaults;
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
      percent_cubic:=fieldbyname('PERCENT_CERRAR').asinteger;
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

    with TpFIBDataSet.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select * from g_aux');
    Open;

    sys_path:=FieldByName('sys_path').AsString;

    Free;
  end;

  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select * from c_aux');
    Open;

    pick_path:=FieldByName('bankia_pick_path').AsString;
    pick_email:=FieldByName('bankia_pick_email').AsString;

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


procedure Tf_main.g_agrDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
    if DataCol=0 then
    with Sender as TJvDBGrid do begin
      if(dm.q_packagr.fieldbyname('impreso').asstring='S') then
           Canvas.Brush.Color:=$006DC36D
      else if (dm.q_packagr.fieldbyname('pendiente').AsInteger=0) then
              Canvas.Brush.Color:=$00FFBFBF
           else Canvas.Brush.Color:=clwhite;
      DefaultDrawColumnCell(rect,datacol,column,state);
    end;
end;

procedure Tf_main.sb_1Click(Sender: TObject);
begin
  log_cabecera := '';

  with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;    row_height:=40;
    fields.commatext:='l.id_agrupa,a.nombre,l.nivel_agr,sum(l.cantidad)';
    titulos.commatext:='Agrupación,Nombre,Nivel,Cantidad';
    from:='a_packlin l  '+
      'inner join a_agrupaciones a on (l.id_agrupa=a.id_agrupa) ';
    where:=' l.id_packcab='+inttostr(id_packcab);

    {case rg1.ItemIndex of
       0: where := where + ' and l.cantidad_i<l.cantidad';  //pendientes
       1: where := where + ' and l.cantidad_i>=l.cantidad'; //completos
    end;        }

    orden[1]:=1;  orden[2]:=2; orden_ini:=1; group:='l.id_agrupa,a.nombre,l.nivel_agr';
    busca:=1;   distinct:=0;   fillimpio:=True;

    showmodal;

    if resultado then begin

      chEtXLect.Enabled := ((valor[1]='120') or ((StrToInt(valor[1])>=120000) and (StrToInt(valor[1])<=120999)));
      chEtXLect.Checked := ((valor[1]='120') or ((StrToInt(valor[1])>=120000) and (StrToInt(valor[1])<=120999)));
      bt_cerrar_agrup.Enabled :=  not chEtXLect.Checked;

      lbAgrupacion.Caption := valor[1]+'-'+valor[2]+' N='+valor[3];
      id_agrupa:=valor[1];
      nivel_agr:=valor[3];

      gb_cajas.Visible:=true;
      pnReparto.Visible:=true;

      if ((id_agrupa=120) or ((id_agrupa>=120000) and (id_agrupa<=120999))) then begin
        gb_resto.visible:=False;
        only_one:=true;
      end else begin
        gb_resto.visible:=true;
        only_one:=false;
      end;

      //pnReparto.Visible := cb_one_read_marks_all.Checked;

      log_cabecera := 'Pack.' + inttostr(id_packcab) + ' ' + lbAgrupacion.Caption;
      InsertaLog(usuario.id,id_packcab,0,PC.Nombre,pc.IP,log_app,'id_packcab','','Agr. Abierta',log_cabecera);
      start;
    end;
  end;
end;



procedure Tf_main.sSpeedButton1Click(Sender: TObject);
var
  i: Integer;
begin
    cb_prev.Checked := True;
    cb_one_read_marks_all.Checked := True;
    cb_art_un_bulto.Checked := True;
    cb_send_email.Checked := True;
    chAdjunto.Checked := True;
    cb_indiv_2040.Checked := True;
    chHojaPick.Checked := True;
    chEtXLect.Checked := True;
    chEtiqCB.Checked := True;
    rgFmtHPick.Visible := chHojaPick.Checked;
    chRevLotes.Checked := True;
end;

procedure Tf_main.sSpeedButton2Click(Sender: TObject);
begin
    cb_prev.Checked := False;
    cb_one_read_marks_all.Checked := False;
    cb_art_un_bulto.Checked := False;
    cb_send_email.Checked := False;
    chAdjunto.Checked := False;
    cb_indiv_2040.Checked := False;
    chHojaPick.Checked := False;
    chEtXLect.Checked := False;
    chEtiqCB.Checked := False;
    rgFmtHPick.Visible := chHojaPick.Checked;
    chRevLotes.Checked := False;
end;

procedure Tf_main.start;
var id_packlin_bulto:integer;
orden: string;
begin
  gb_pack.Visible:=True;
  gb_asig.Visible:=false;
  gb_error.Visible:=false;

  dm.q_packagr.Close;
  dm.q_packagr.SQLs.SelectSQL.Clear;
  //dm.q_packagr.sqls.SelectSQL.Add('select b.id_caja,b.codalbaran,b.codalbeti,b.tipo_caja,l.codrepartidor,l.id_ruta,l.id_packlin_bulto,b.n_bulto, '+
  dm.q_packagr.sqls.SelectSQL.Add('select b.id_caja,b.codalbaran,b.tipo_caja,l.codrepartidor,l.id_ruta,l.id_packlin_bulto,b.n_bulto, b.impreso, '+
    '  sum(l.cantidad) as total,sum(l.cantidad)-sum(l.cantidad_i) as pendiente '+
    'from a_packlin l '+
    'inner join a_packlin_bulto b on (l.id_packlin_bulto=b.id_packlin_bulto) '+
    'where l.id_packcab=:id_packcab and l.id_agrupa=:id_agrupa and l.nivel_agr=:nivel_agr '+
    'group by 1,2,3,4,5,6,7,8 order by 1,2');
  dm.q_packagr.ParamByName('id_packcab').asinteger:=id_packcab;
  dm.q_packagr.ParamByName('id_agrupa').asinteger:=id_agrupa;
  dm.q_packagr.ParamByName('nivel_agr').asinteger:=nivel_agr;
  dm.q_packagr.Open;

  act_cajas;

  lb_cajas.Caption:=IntToStr(dm.q_packagr.RecordCount)+' Albarán/es';

  if ((id_agrupa=120)  or ((id_agrupa>=120000) and (id_agrupa<=120999))) then
          orden := '2,4'
      else
          orden := '1,2,4';

  filter_ptes(orden);

  filter_leidos(orden);

  ed_cb.SetFocus;

  if ((not only_one) and (cb_prev.Checked)) then
  begin                      //Saca etiquetas previas automaticamente
    dm.q_packagr.First;
    while not(dm.q_packagr.eof) do begin
      print_etiq_pre(dm.q_packagr.FieldByName('codalbaran').Asstring, dm.q_packagr.FieldByName('tipo_caja').Asstring,
        dm.q_packagr.FieldByName('codrepartidor').AsString, dm.q_packagr.FieldByName('id_ruta').AsString,
        dm.q_packagr.FieldByName('id_caja').asinteger,dm.q_packagr.FieldByName('id_packlin_bulto').asinteger,
        dm.q_packagr.FieldByName('n_bulto').asinteger,dm.q_packagr.FieldByName('total').asinteger);

      dm.q_packagr.Next;
    end;
  end;

  if ((not(only_one)) and (cb_art_un_bulto.Checked)) then begin              //Marca artículos que son 1 bulto en sí mismos
    with tpfibdataset.create(Self) do
    try
      Database:=dm.db;
      close;                                                               //lista de articulos/lineas
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select a.nombre,a.codigo,b.tipo_caja,b.id_caja,b.codalbaran,l.linea,lo.id_lote,lo.nombre as n_lote,lo.caducidad '+
        'from a_packlin l '+
        'inner join g_articulos a on (l.id_articulo=a.id_articulo) '+
        'inner join a_packlin_bulto b on (l.id_packlin_bulto=b.id_packlin_bulto) '+
        'inner join a_lotes lo on (lo.id_lote = l.id_lote) '+
        'where l.id_packcab=:id_packcab and l.id_agrupa=:id_agrupa and l.nivel_agr=:nivel_agr and a.is_bulto=''S'' and l.cantidad_i<l.cantidad ');
      ParamByName('id_packcab').asinteger:=id_packcab;
      ParamByName('id_agrupa').asinteger:=id_agrupa;
      ParamByName('nivel_agr').asinteger:=nivel_agr;
      open;
      first;

      while not(eof) do begin                                                //marca lineas y cierra bultos
        id_packlin_bulto:=mark_one(FieldByName('nombre').AsString,FieldByName('codigo').AsString,'',FieldByName('tipo_caja').AsString,
          FieldByName('id_caja').Asinteger,FieldByName('codalbaran').Asinteger,FieldByName('linea').AsInteger,false,false,
          fieldbyname('id_lote').asinteger,fieldbyname('n_lote').asstring,fieldbyname('caducidad').asdatetime,1);

        cerrar_caja_y_nueva(FieldByName('codalbaran').Asinteger,id_packlin_bulto,false);

        next;
      end;

     { dm.q_fib.Close;                                                       //albaranes distintos afectados
      dm.q_fib.SelectSQL.Clear;
      dm.q_fib.SelectSQL.Add('select distinct b.codalbaran '+
        'from a_packlin l '+
        'inner join g_articulos a on (l.id_articulo=a.id_articulo) '+
        'inner join a_packlin_bulto b on (l.id_packlin_bulto=b.id_packlin_bulto) '+
        'where l.id_packcab=:id_packcab and l.id_agrupa=:id_agrupa and l.nivel_agr=:nivel_agr and a.is_bulto=''S'' and l.cantidad_i<l.cantidad');
      dm.q_fib.ParamByName('id_packcab').asinteger:=id_packcab;
      dm.q_fib.ParamByName('id_agrupa').asinteger:=id_agrupa;
      dm.q_fib.ParamByName('nivel_agr').asinteger:=nivel_agr;
      dm.q_fib.open;
      dm.q_fib.first;


      while not(dm.q_fib.eof) do begin                                    //imprime etiqueta de bultos (definitivas) para los albaranes afectados
        imprime_eti_bulto(dm.q_fib.FieldByName('codalbaran').asinteger);
        dm.q_fib.Next;
      end;      }

    finally
      free;
    end;
  end;
end;
//
procedure Tf_main.act_cajas;
var caja_a,caja_b,caja_c,caja_d,caja_e:integer;
begin
  caja_a:=0;
  caja_b:=0;
  caja_c:=0;
  caja_d:=0;
  caja_e:=0;
  dm.q_packagr.First;
  while not(dm.q_packagr.Eof) do begin
    if dm.q_packagr.FieldByName('tipo_caja').asstring='A' then Inc(caja_a);
    if dm.q_packagr.FieldByName('tipo_caja').asstring='B' then Inc(caja_b);
    if dm.q_packagr.FieldByName('tipo_caja').asstring='C' then Inc(caja_c);
    if dm.q_packagr.FieldByName('tipo_caja').asstring='D' then Inc(caja_d);
    if dm.q_packagr.FieldByName('tipo_caja').asstring='E' then Inc(caja_e);
    dm.q_packagr.next;
  end;
  lb_caja_a.Caption:='CajA='+inttostr(caja_a);
  lb_caja_b.Caption:='CajB='+inttostr(caja_b);
  lb_caja_c.Caption:='CajC='+inttostr(caja_c);
  lb_caja_d.Caption:='CajD='+inttostr(caja_d);
  lb_caja_e.Caption:='CajE='+inttostr(caja_e);
  dm.q_packagr.First;
end;
//
procedure Tf_main.print_etiq_pre(codalbaran,tipo_caja,codrepartidor,id_ruta:string; id_caja,id_packlin_bulto,n_bulto, unidades:integer);   //etiqueta identificativa de caja
const cr=Chr(13);  lf=chr(10);
var s:string;
begin

  cdsPrev.EmptyDataSet;
  cdsPrev.Insert;
  cdsPrev.FieldByName('codalbaran').AsString := codalbaran;
  cdsPrev.FieldByName('ruta').AsString := id_ruta+'-'+codrepartidor;
  cdsPrev.FieldByName('caja').AsString := inttostr(id_caja);
  cdsPrev.FieldByName('tipo_caja').AsString := tipo_caja;
  cdsPrev.FieldByName('bulto').AsString := inttostr(n_bulto)+'-'+inttostr(id_packlin_bulto);
  cdsPrev.FieldByName('unidades').AsString := IntToStr(unidades);
  cdsPrev.Post;

  frxPrev.PrintOptions.Printer:=u_globals.imp_eti;
  frxPrev.PrintOptions.ShowDialog := False;
  if frxPrev.PrepareReport(True) then frxPrev.print;


  {
  s:='';
  s:=s+'N'+lf;
  s:=s+'OD'+lf;
  s:=s+'q816'+lf;
  s:=s+'Q?'+lf;
  s:=s+'S6'+lf;
  s:=s+'D13'+lf;
  s:=s+'ZT'+lf;
  if id_caja>9 then s:=s+'A100,150,0,5,9,9,N,"'+inttostr(id_caja)+'"'+lf
  else s:=s+'A300,150,0,5,9,9,N,"'+inttostr(id_caja)+'"'+lf;
  s:=s+'A150,700,0,5,1,1,N,"ALBARAN  '+codalbaran+'"'+lf;
  s:=s+'A150,800,0,5,1,1,N,"RUTA  '+id_ruta+'-'+codrepartidor+'"'+lf;
  s:=s+'A150,900,0,5,1,1,N,"CAJA  '+tipo_caja+'"'+lf;
  s:=s+'A150,1000,0,5,1,1,N,"BULTO  '+inttostr(n_bulto)+'-'+inttostr(id_packlin_bulto)+'"'+lf;
  s:=s+'P1'+lf;
  s:=s+'N'+lf;

  WriteRawDataToPrinter(u_globals.imp_eti,s);   }
end;
//
function Tf_main.mark_one(nombre,codigo,bc,tipo_caja:string;  id_caja,codalbaran,linea:Integer;  verbose,check_cierre_caja:boolean; id_lote:Integer; n_lote:string; caducidad:tdatetime; uds:Integer=1):integer;    //returns id_packlin_bulto de la linea
var   max_cubic:integer;  id_packlin_bulto:integer;
begin
  lb_asig.Caption:=nombre;
  lb_asig_art.Caption:='Código '+codigo+' - EAN '+bc;
  lb_asig_lote.caption:='Lote '+n_lote+' '+formatdatetime('dd/mm/yy', caducidad);

  if verbose then begin
    lb_caja.Caption:='Caja '+IntToStr(id_caja)+' - '+tipo_caja;
    lbCajaGrande.Caption:=IntToStr(id_caja);
    //lbCajaGrande.Caption:= '88';
    lb_albaran.Caption:='Albarán '+IntToStr(codalbaran);
  end;

  if cb_indiv_2040.Checked then
    imprime_eti_indiv(id_packcab,id_agrupa,nivel_agr,linea);

  with tpfibdataset.create(Self) do                                                            //AVERIGUA PACKLIN_BULTO
  try
    Database:=dm.db;
    SelectSQL.Clear;
    selectsql.Add('select id_packlin_bulto from a_packlin where id_packcab=:id_packcab and id_agrupa=:id_agrupa and nivel_agr=:nivel_agr and linea=:linea');
    ParamByName('id_packcab').AsInteger:=id_packcab;
    ParamByName('id_agrupa').AsInteger:=id_agrupa;
    ParamByName('nivel_agr').AsInteger:=nivel_agr;
    ParamByName('linea').AsInteger:=linea;
    open;
    id_packlin_bulto:=fieldbyname('id_packlin_bulto').asinteger;
    result:=id_packlin_bulto;
  finally
    Free;
  end;

  with tpfibquery.create(Self) do                                                            //ACTUALIZA INDIV
  try
    Database:=dm.db;
    Transaction:=dm.t_write;
    //sql.Add('update a_packlin set cantidad_i=cantidad_i+1, fecha_i=:fecha_i, hora_i=:hora_i, id_usuario_i=:id_usuario_i, pc=:pc, situacion=''A'' '+
    sql.Add('update a_packlin set cantidad_i=cantidad_i+:uds, fecha_i=:fecha_i, hora_i=:hora_i, id_usuario_i=:id_usuario_i, pc=:pc, situacion=''A'' '+
      'where id_packcab=:id_packcab and id_agrupa=:id_agrupa and nivel_agr=:nivel_agr and linea=:linea');
    ParamByName('id_packcab').AsInteger:=id_packcab;
    ParamByName('id_agrupa').AsInteger:=id_agrupa;
    ParamByName('nivel_agr').AsInteger:=nivel_agr;
    ParamByName('linea').AsInteger:=linea;
    ParamByName('fecha_i').AsDate:=date;
    ParamByName('hora_i').AsTime:=Time;
    //ParamByName('id_usuario_i').AsInteger:=u_globals.id_usuario;
    ParamByName('id_usuario_i').AsInteger := usuario.id;
    ParamByName('pc').AsString:= pc.Nombre;
    ParamByName('uds').AsInteger := uds;

    dm.t_write.StartTransaction;
    execquery;
    dm.t_write.commit;
  finally
    Free;
  end;

  if ((verbose) and (FileExists(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+'-'+formatfloat('00',id_caja)+'.wav'))) then
    sndPlaySound(PChar(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+'-'+formatfloat('00',id_caja)+'.wav'),SND_NODEFAULT Or SND_ASYNC);

  with tpfibdataset.Create(dm) do                                            //Cerrar caja??
  try
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select coalesce(sum(l.cantidad),0) as total '+
      'from a_packlin l '+
      'where l.id_packcab=:id_packcab and l.id_agrupa=:id_agrupa and l.nivel_agr=:nivel_agr and l.codalbaran=:codalbaran '+
      'and l.cantidad<>l.cantidad_i ');
    ParamByName('id_packcab').asinteger:=id_packcab;
    ParamByName('id_agrupa').asinteger:=id_agrupa;
    ParamByName('nivel_agr').asinteger:=nivel_agr;
    ParamByName('codalbaran').asinteger:=codalbaran;
    Open;

    if FieldByName('total').asinteger=0 then begin                                //CERRAR ULTIMA CAJA
      lb_cajas_st.Visible:=true;
      lb_cajas_st.caption:='Albarán Cerrado '+inttostr(id_Caja)+'-'+inttostr(codalbaran);
      sleep(500);
      {if FileExists(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+'-Albaran_Cerrado.wav') then
        sndPlaySound(PChar(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+'-Albaran_Cerrado.wav'),SND_NODEFAULT Or SND_ASYNC);}
    end else begin                                                             //CERRAR CAJA Y ABRIR NUEVA
      if ((check_cierre_caja) and (cb_maxcubic.checked)) then begin
        with tpfibdataset.Create(dm) do
        try
          database:=dm.db;
          SQLs.SelectSQL.Clear;
          SQLs.SelectSQL.Add('select coalesce(sum(a.cubic),0) as tot_cubic '+
            'from a_packlin l '+
            'inner join g_articulos a on (l.id_articulo=a.id_articulo) '+
            'where l.id_packcab=:id_packcab and l.id_agrupa=:id_agrupa and l.nivel_agr=:nivel_agr and l.codalbaran=:codalbaran '+
            'and l.cantidad=l.cantidad_i');
          ParamByName('id_packcab').asinteger:=id_packcab;
          ParamByName('id_agrupa').asinteger:=id_agrupa;
          ParamByName('nivel_agr').asinteger:=nivel_agr;
          ParamByName('codalbaran').asinteger:=codalbaran;
          Open;

          max_cubic:=0;
          case IndexStr(tipo_caja,['A','B','C','D','E']) of
            0:begin max_cubic:=cubic_a; end;
            1:begin max_cubic:=cubic_b; end;
            2:begin max_cubic:=cubic_c; end;
            3:begin max_cubic:=cubic_d; end;
            4:begin max_cubic:=cubic_e; end;
          end;

          if ((((FieldByName('tot_cubic').asinteger*100)/max_cubic) > percent_cubic)) then begin         //Pasa del Máximo cubicaje??
            cerrar_caja_y_nueva(codalbaran,id_packlin_bulto);
          end else lb_cajas_st.Visible:=false;                                                         //NO SE CIERRA
        finally
          free;
        end;
      end else lb_cajas_st.Visible:=false;                                                         //NO SE CIERRA
    end;
  finally
    Free;
  end;
end;



procedure Tf_main.cerrar_caja_y_nueva(codalbaran,id_packlin_bulto_old:integer; etiq_prev:Boolean=True);                                                                  //Cerrar caja actual y generar una nueva
var  cubic:real;
     id_packlin_bulto_new,bultos,n_bulto, n_uds_pend, n_linea, ruta:integer;
     caja,etiq_chrono,n_bulto_dhl,n_bulto_str:string;
     aux_alb, aux_bulto:integer;
begin
    aux_alb := dm.q_packagr.FieldByName('codalbaran').AsInteger;
    aux_bulto := dm.q_packagr.FieldByName('id_packlin_bulto').AsInteger;

    with tpfibdataset.Create(dm) do begin                                           //Verifica que haya que abrir una nueva caja (si queda algo)
      database:=dm.db;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select count(*) as n '+
        'from a_packlin l '+
        'where l.id_packlin_bulto=:id_packlin_bulto '+
        'and cantidad<>cantidad_i ');
      ParamByName('id_packlin_bulto').asinteger:=id_packlin_bulto_old;
      Open;

      n_uds_pend:=fieldbyname('n').AsInteger;
      Free;
    end;

  if (n_uds_pend>0) then begin
    with tpfibdataset.Create(dm) do begin                                           //Consigue tamaño de caja para lo que queda
      database:=dm.db;
      SQLs.SelectSQL.Clear;

      SQLs.SelectSQL.Add('select sum(a.cubic) as cubic '+
        'from a_packlin l '+
        'inner join g_articulos a on (l.id_articulo=a.id_articulo) '+
        'where l.id_packlin_bulto=:id_packlin_bulto '+
        'and cantidad<>cantidad_i ');
      ParamByName('id_packlin_bulto').asinteger:=id_packlin_bulto_old;

      Open;

      if not(IsEmpty) then begin
         cubic:=FieldByName('cubic').asfloat
      end else begin
        cubic:=0;
      end;
      Free;
    end;

    caja:='';
    if cubic>cubic_b then caja:='A'
    else if cubic>cubic_c then caja:='B'
      else if cubic>cubic_d then caja:='C'
        else if cubic>cubic_e then caja:='D'
          else caja:='E';

    with tpfibdataset.Create(dm) do begin                                //Consigue siguiente numero de bulto
      database:=dm.db;
      SQLs.SelectSQL.Clear;
      //el siguiente numero en dhl puede no ser el siguiente del albaran 1, sino del albaran 2 agrupado. Pueden intercalarse ergo necesitamos calcular cual es el ultimo numero en la agrupacion
      if(dm.q_packagr.fieldbyname('codrepartidor').asinteger=46276) then
       begin
        //averiguamos que n_bulto_chrono tiene
        SQLs.SelectSQL.Add('select n_bulto_chrono '+
                           'from a_packlin_bulto '+
                           'where id_packlin_bulto=:id_packlin_bulto');
        ParamByName('id_packlin_bulto').asinteger:=id_packlin_bulto_old;
        Open;
        if( not IsEmpty) then
         n_bulto_dhl:=FieldByName('n_bulto_chrono').AsString
        else n_bulto_dhl :='';
        Close;
        //a partir del n_bulto_chrono, averiguamos el bulto y numero de bultos
        SQLs.SelectSQL.Clear;
        SQLs.SelectSQL.Add('select max(bultos) as bultos,max(n_bulto) as n_bulto '+
                           'from a_packlin_bulto '+
                           'where n_bulto_chrono=:n_bulto_chro');
        ParamByName('n_bulto_chro').asString:=n_bulto_dhl;
       end
       else
       begin
       //si no es dhl se sigue calculando como hasta el momento
        SQLs.SelectSQL.Add('select bultos,n_bulto,codalbaran '+
                           'from a_packlin_bulto '+
                           'where id_packlin_bulto=:id_packlin_bulto');
        ParamByName('id_packlin_bulto').asinteger:=id_packlin_bulto_old;
       end;
      Open;

      if not(IsEmpty) then begin
        bultos:=FieldByName('bultos').AsInteger+1;
        n_bulto:=FieldByName('n_bulto').AsInteger+1;
      end else begin
        bultos:=1;
        n_bulto:=1;
      end;
      Free;
    end;

    etiq_chrono:='';
    if ((dm.q_packagr.fieldbyname('codrepartidor').asinteger=46172) or
         (dm.q_packagr.fieldbyname('codrepartidor').asinteger=46276)) then begin         //Num bulto de chrono o DHL
      with tpfibdataset.Create(dm) do begin                                //Consigue etiq chrono vieja
        database:=dm.db;
        SQLs.SelectSQL.Clear;
        SQLs.SelectSQL.Add('select n_bulto_chrono '+
          'from a_packlin_bulto '+
          'where id_packlin_bulto=:id_packlin_bulto');
        ParamByName('id_packlin_bulto').asinteger:=id_packlin_bulto_old;
        Open;

        if (dm.q_packagr.fieldbyname('codrepartidor').asinteger=46172) then   //chrono
        begin
          if not(IsEmpty) and (FieldByName('n_bulto_chrono').asstring<>'')  then begin
            etiq_chrono:=FieldByName('n_bulto_chrono').asstring;
          end else begin
            etiq_chrono:='00000000000000000000000';
          end;
        end else if not(IsEmpty) and (FieldByName('n_bulto_chrono').asstring<>'')  then begin
                        etiq_chrono:=FieldByName('n_bulto_chrono').asstring;
                  end;
        Free;
      end;

      if (dm.q_packagr.fieldbyname('codrepartidor').asinteger=46172) then   //chrono
      begin
        n_bulto_str:=FormatFloat('00',n_bulto);
        etiq_chrono[16]:=n_bulto_str[1];
        etiq_chrono[17]:=n_bulto_str[2];
        etiq_chrono[23]:=inttostr(calc_digcon_chrono(Copy(etiq_chrono,1,Length(etiq_chrono)-1)))[1];
      end;
    end;

    {Vamos a utilizar el mismo campo donde se guarda el código de Chrono para DHL}
   { if dm.q_packagr.fieldbyname('codrepartidor').asinteger=46276 then begin         //Num bulto de DHL
      etiq_chrono:='';
      dm.qdhl.Close;
      dm.qdhl.SelectSQl.Clear;
      dm.qdhl.SelectSQL.Add('select dhl_expedicion from C_AUX where id_empresa=1');
      dm.qdhl.Open;

      etiq_chrono:=dm.qdhl.FieldByName('dhl_expedicion').AsString;

      dm.t_write.StartTransaction;
      dm.qu_dhl.Close;
      dm.qu_dhl.SQL.Clear;
      dm.qu_dhl.SQL.Add('update c_aux set dhl_expedicion=dhl_expedicion+1');
      dm.qu_dhl.ExecQuery;
      dm.t_write.Commit;
    end;      }

    with tpfibdataset.Create(dm) do begin                              //nuevo id packlin bulto
      database:=dm.db;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('SELECT GEN_ID(GEN_A_PACKLIN_BULTO_ID,1) FROM RDB$DATABASE');
      Open;

      id_packlin_bulto_new:=FieldByName('gen_id').AsInteger;
      Free;
    end;


    with tpfibquery.create(Self) do                         //Nuevo packlin bulto
    try
      Database:=dm.db;
      Transaction:=dm.t_write;
      sql.Add('insert into a_packlin_bulto (id_packlin_bulto,codalbaran,codalbeti,tipo_caja,id_caja,paquetes,bultos,n_bulto,n_bulto_chrono,kgs,kgs_vol,'+
        ' fecha_alb,codcli,org_codcli,org_coddel,org_nombre,org_calle,org_cp,org_localidad,org_provincia,org_persona,org_tfno,dst_codcli,'+
        ' dst_coddel,dst_nombre,dst_calle,dst_cp,dst_localidad,dst_provincia,dst_persona,dst_tfno,reembolso,pdebido,cod_ruta,cod_repartidor,'+
        ' observaciones,impreso,hora,fecha,id_usuario,pc,enviado,dst_email) '+
        ' select :id_packlin_bulto_new,codalbaran,codalbeti,:tipo_caja,id_caja,paquetes,:bultos,:n_bulto,:n_bulto_chrono,kgs,kgs_vol,fecha_alb,codcli, '+
        '   org_codcli,org_coddel,org_nombre,org_calle,org_cp,org_localidad,org_provincia,org_persona,org_tfno,dst_codcli,dst_coddel,dst_nombre, '+
        '   dst_calle,dst_cp,dst_localidad,dst_provincia,dst_persona,dst_tfno,reembolso,pdebido,cod_ruta,cod_repartidor,observaciones,''N'',NULL,NULL,NULL,NULL,''N'',dst_email '+
        ' from a_packlin_bulto where id_packlin_bulto=:id_packlin_bulto_old');
      parambyname('id_packlin_bulto_new').asinteger:=id_packlin_bulto_new;
      ParamByName('id_packlin_bulto_old').asinteger:=id_packlin_bulto_old;
      ParamByName('tipo_caja').asstring:=caja;
      ParamByName('bultos').AsInteger:=bultos;
      ParamByName('n_bulto').AsInteger:=n_bulto;
      ParamByName('n_bulto_chrono').asstring:=etiq_chrono;

      dm.t_write.StartTransaction;
      execquery;
      dm.t_write.commit;
    finally
      Free;
    end;

    with tpfibquery.create(Self) do                         //Actualiza total bultos del resto de bultos del albaran
    try
      Database:=dm.db;
      Transaction:=dm.t_write;
      //si es de dhl vamos a agrupar por n_bulto_chrono porque necesitamos actualizar el numero de bultos de todos los albaranes agrupados
      if(dm.q_packagr.fieldbyname('codrepartidor').asinteger=46276) then
      begin
       sql.Add('update a_packlin_bulto b set b.bultos=:bultos '+
               'where b.n_bulto_chrono=:n_bul_chro');
      //  'where b.id_packlin_bulto in ('+
      //  ' select l.id_packlin_bulto from a_packlin_bulto l where l.n_bulto_chrono=:n_bul_chro'+
      //  ')');
        ParamByName('n_bul_chro').asString:=etiq_chrono;
        ParamByName('bultos').AsInteger:=bultos;
      end
      else
       begin
        sql.Add('update a_packlin_bulto b set b.bultos=:bultos '+
                'where b.id_packlin_bulto in ('+
                ' select l.id_packlin_bulto from a_packlin l where l.id_packcab=:id_packcab and l.id_agrupa=:id_agrupa and l.nivel_agr=:nivel_agr and l.codalbaran=:codalbaran'+
                ')');
        ParamByName('id_packcab').AsInteger:=id_packcab;
        ParamByName('id_agrupa').AsInteger:=id_agrupa;
        ParamByName('nivel_agr').AsInteger:=nivel_agr;
        ParamByName('codalbaran').AsInteger:=codalbaran;
        ParamByName('bultos').AsInteger:=bultos;
       end;

      dm.t_write.StartTransaction;
      execquery;
      dm.t_write.commit;
    finally
      Free;
    end;

    with tpfibdataset.Create(dm) do begin   //Ultima linea del packing
      database:=dm.db;
      SQLs.SelectSQL.Clear;

      SQLs.SelectSQL.Add('select max(l.linea) as linea '+
        'from a_packlin l '+
        'where l.id_packcab=:id_packcab ');
      ParamByName('id_packcab').asinteger:=id_packcab;

      Open;

      if not(IsEmpty) then begin
         n_linea := FieldByName('linea').AsInteger + 1;
      end else begin
        n_linea:=1;
      end;
      Free;
    end;

    //*  INI NUEVA LINEA EN PACKLIN POR CADA LINEA PENDIENTE *//
      //Consigue datos de las lineas a las que les queda cantidad pendiente y de las que ya se ha leido algo

      dm.qLineaPackOld.Close;
      dm.qLineaPackOld.SQLs.SelectSQL.Clear;
      dm.qLineaPackOld.SQLs.SelectSQL.Add('select * '+
        'from a_packlin l '+
        'where l.id_packlin_bulto=:id_packlin_bulto '+
        'and cantidad<>cantidad_i and cantidad_i>0 ');
      dm.qLineaPackOld.ParamByName('id_packlin_bulto').asinteger:=id_packlin_bulto_old;
      dm.qLineaPackOld.Open;

      if not(dm.qLineaPackOld.IsEmpty) then begin

          dm.t_write.StartTransaction;

          dm.qLineaPackOld.First;

          while not dm.qLineaPackOld.eof do
          begin
                dm.q_1.sql.Clear;
                dm.q_1.sql.Add('insert into a_packlin ' +
                        '(ID_PACKCAB,ID_AGRUPA,NIVEL_AGR,LINEA,ID_RUTA,ID_ARTICULO,CANTIDAD,SITUACION,CODALBARAN, ' +
                        'CODMOVIMIENTO,FECHA_I,HORA_I,ID_USUARIO_I,CANTIDAD_I,CODREPARTIDOR,PC,ID_PACKLIN_BULTO,' +
                        'SULINEA,ATT,N_PARCIAL,ID_LOTE)' +
                        ' values ' +
                        '(:ID_PACKCAB,:ID_AGRUPA,:NIVEL_AGR,:LINEA,:ID_RUTA,:ID_ARTICULO,:CANTIDAD,:SITUACION,:CODALBARAN, ' +
                        ':CODMOVIMIENTO,:FECHA_I,:HORA_I,:ID_USUARIO_I,:CANTIDAD_I,:CODREPARTIDOR,:PC,:ID_PACKLIN_BULTO,' +
                        ':SULINEA,:ATT,:N_PARCIAL,:ID_LOTE)');

                dm.q_1.ParamByName('id_packcab').AsInteger       := id_packcab;
                dm.q_1.ParamByName('id_agrupa').AsInteger        := id_agrupa;
                dm.q_1.ParamByName('nivel_agr').AsInteger        := nivel_agr;
                dm.q_1.ParamByName('linea').AsInteger            := n_linea;
                dm.q_1.ParamByName('id_ruta').AsInteger          := dm.qLineaPackOld.FieldByName('id_ruta').AsInteger;
                dm.q_1.ParamByName('id_articulo').AsInteger      := dm.qLineaPackOld.FieldByName('id_articulo').AsInteger;
                dm.q_1.ParamByName('cantidad').AsInteger         := dm.qLineaPackOld.FieldByName('cantidad').AsInteger-dm.qLineaPackOld.FieldByName('cantidad_i').AsInteger;
                dm.q_1.ParamByName('situacion').AsString         := 'P';
                dm.q_1.ParamByName('codalbaran').AsInteger       := dm.qLineaPackOld.FieldByName('codalbaran').AsInteger;
                dm.q_1.ParamByName('codmovimiento').AsInteger    := dm.qLineaPackOld.FieldByName('codmovimiento').AsInteger;
                dm.q_1.ParamByName('fecha_i').AsDate             := Date;
                dm.q_1.ParamByName('hora_i').AsTime              := Time;
                //dm.q_1.ParamByName('id_usuario_i').AsInteger     := u_globals.id_usuario;
                dm.q_1.ParamByName('id_usuario_i').AsInteger     := usuario.id;
                dm.q_1.ParamByName('cantidad_i').AsInteger       := 0;
                dm.q_1.ParamByName('codrepartidor').AsInteger    := dm.qLineaPackOld.FieldByName('codrepartidor').AsInteger;
                dm.q_1.ParamByName('pc').AsString                := pc.nombre;
                dm.q_1.ParamByName('id_packlin_bulto').AsInteger := id_packlin_bulto_new;
                dm.q_1.ParamByName('sulinea').AsString           := dm.qLineaPackOld.FieldByName('sulinea').AsString;
                dm.q_1.ParamByName('att').AsString               := dm.qLineaPackOld.FieldByName('att').AsString;
                dm.q_1.ParamByName('n_parcial').AsString         := dm.qLineaPackOld.FieldByName('n_parcial').AsString;
                dm.q_1.ParamByName('id_lote').AsInteger          := dm.qLineaPackOld.FieldByName('id_lote').AsInteger;
              {  ShowMessage('id ' + IntToStr(id_packcab));
                ShowMessage('agrupa ' + IntToStr(id_agrupa));
                ShowMessage('nivel ' + IntToStr(nivel_agr));
                ShowMessage('linea ' + IntToStr(n_linea));
                ShowMessage('ruta ' + dm.qLineaPackOld.FieldByName('id_ruta').AsString);
                ShowMessage('art ' + dm.qLineaPackOld.FieldByName('id_articulo').AsString);
                ShowMessage('cant ' + IntToStr(dm.qLineaPackOld.FieldByName('cantidad').AsInteger-dm.qLineaPackOld.FieldByName('cantidad_i').AsInteger));
                ShowMessage('alb ' + dm.qLineaPackOld.FieldByName('codalbaran').AsString);
                ShowMessage('mov ' + dm.qLineaPackOld.FieldByName('codmovimiento').AsString);

                ShowMessage('usu ' + IntToStr(u_globals.id_usuario));
                ShowMessage('rep ' + dm.qLineaPackOld.FieldByName('codrepartidor').AsString);
                ShowMessage('pc ' + dm.qLineaPackOld.FieldByName('pc').AsString);
                ShowMessage('sulinea ' + dm.qLineaPackOld.FieldByName('sulinea').AsString);
                ShowMessage('att ' + dm.qLineaPackOld.FieldByName('att').AsString);
                ShowMessage('n_parcial ' + dm.qLineaPackOld.FieldByName('n_parcial').AsString);
                ShowMessage('lote ' + dm.qLineaPackOld.FieldByName('id_lote').AsString);
                }


                dm.q_1.ExecQuery;

                dm.qLineaPackOld.Next;
                Inc(n_linea);
          end;

            dm.t_write.commit;

          ruta := dm.qLineaPackOld.FieldByName('id_ruta').AsInteger;

          dm.qLineaPackOld.Close;

      end else begin
        n_linea:=1;
      end;

    //* FIN NUEVA LINEA EN PACKLIN *//

    with tpfibquery.create(Self) do                         //Actualiza Datos de linea de packing old
    try
      Database:=dm.db;
      Transaction:=dm.t_write;
      sql.Add('update a_packlin set cantidad=cantidad_i '+
        'where id_packlin_bulto=:id_packlin_bulto and ' +
        'cantidad<>cantidad_i and cantidad_i>0 and ' +
        'id_packcab=:id_packcab and id_agrupa=:id_agrupa and ' +
        'nivel_agr=:nivel_agr');
      ParamByName('id_packcab').AsInteger := id_packcab;
      ParamByName('id_agrupa').AsInteger := id_agrupa;
      ParamByName('nivel_agr').AsInteger := nivel_agr;
      ParamByName('id_packlin_bulto').AsInteger:=id_packlin_bulto_old;
      dm.t_write.StartTransaction;
      execquery;
      dm.t_write.commit;
    finally
      Free;
    end;

        with tpfibquery.create(Self) do                         //Actualiza Datos de linea de packing old
    try
      Database:=dm.db;
      Transaction:=dm.t_write;
      sql.Add('update a_packlin set id_packlin_bulto=:id_packlin_bulto_new '+
        'where id_packlin_bulto=:id_packlin_bulto_old and ' +
        'cantidad<>cantidad_i and ' +
        'id_packcab=:id_packcab and id_agrupa=:id_agrupa and ' +
        'nivel_agr=:nivel_agr');
      ParamByName('id_packcab').AsInteger := id_packcab;
      ParamByName('id_agrupa').AsInteger := id_agrupa;
      ParamByName('nivel_agr').AsInteger := nivel_agr;
      ParamByName('id_packlin_bulto_old').AsInteger:=id_packlin_bulto_old;
      ParamByName('id_packlin_bulto_new').AsInteger:=id_packlin_bulto_new;
      dm.t_write.StartTransaction;
      execquery;
      dm.t_write.commit;
    finally
      Free;
    end;
                                                                                                         //Imprime etiq prev de caja nueva
    if etiq_prev then print_etiq_pre(IntToStr(codalbaran), caja,
                        dm.q_packagr.FieldByName('codrepartidor').AsString, dm.q_packagr.FieldByName('id_ruta').AsString,
                        dm.q_packagr.FieldByName('id_caja').asinteger,id_packlin_bulto_new,n_bulto,
                        dm.q_packagr.FieldByName('total').asinteger);

    lb_cajas_st.Visible:=true;
    lb_cajas_st.Caption:='Nueva Caja - ' + caja;

    if FileExists(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+'-Nueva_Caja.wav') then
      sndPlaySound(PChar(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+'-Nueva_Caja.wav'),SND_NODEFAULT Or SND_ASYNC);

    Sleep(1500);

    case indexstr(caja,['A','B','C','D','E']) of
      0:begin
        if FileExists(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+'-A.wav') then
          sndPlaySound(PChar(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+'-A.wav'),SND_NODEFAULT Or SND_ASYNC);
      end;
      1:begin
        if FileExists(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+'-B.wav') then
          sndPlaySound(PChar(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+'-B.wav'),SND_NODEFAULT Or SND_ASYNC);
      end;
      2:begin
        if FileExists(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+'-C.wav') then
          sndPlaySound(PChar(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+'-C.wav'),SND_NODEFAULT Or SND_ASYNC);
      end;
      3:begin
        if FileExists(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+'-D.wav') then
          sndPlaySound(PChar(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+'-D.wav'),SND_NODEFAULT Or SND_ASYNC);
      end;
      4:begin
        if FileExists(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+'-E.wav') then
          sndPlaySound(PChar(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+'-E.wav'),SND_NODEFAULT Or SND_ASYNC);
      end;
    end;
  end;

  dm.q_packagr.Close;
  dm.q_packagr.Open;
  dm.q_packagr.Locate('codalbaran;id_packlin_bulto', VarArrayOf([aux_alb, aux_bulto]),[]);

  dm.q_pack.Close;
  dm.q_pack.Open;

  dm.q_pack_leido.Close;
  dm.q_pack_leido.Open;

  act_cajas;

  ed_cb.SetFocus;
end;

//
function Tf_main.WriteRawDataToPrinter(PrinterName: String; Str: String): Boolean;
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
//
procedure Tf_main.imprime_eti_indiv(id_packcab,id_agrupa,nivel_agr,linea:integer);
var   barcode1,barcode2:tfrxbarcodeview;      i:Integer;   memo:TfrxMemoView;
begin
  if id_cliente<>6702 then begin          //life is short no saca individuales
    dm.q_etiq_indiv.Close;
    dm.q_etiq_indiv.SelectSQL.Clear;
    dm.q_etiq_indiv.SelectSQL.Add('select l.sulinea,l.id_ruta as codruta,l.codalbaran,l.att,b.dst_nombre,b.dst_calle,b.dst_localidad,b.dst_provincia,b.dst_cp, '+
      ' a.codigo as referencia,a.nombre as articulo,a.id_cliente,b.paquetes as ntot,l.n_parcial as n,l.id_packcab, l.id_agrupa,l.nivel_agr,l.linea,c.logo_ind,b.codcli,b.id_caja '+
      'from a_packlin l '+
      'inner join a_packlin_bulto b on (l.id_packlin_bulto=b.id_packlin_bulto) '+
      'inner join g_articulos a on (l.id_articulo=a.id_articulo) '+
      'left outer join g_clientes_logos c on (c.codcli=b.codcli and c.dst_codcli=b.dst_codcli) '+
      'where l.id_packcab=:id_packcab and l.id_agrupa=:id_agrupa and l.nivel_agr=:nivel_agr and l.linea=:linea');
    dm.q_etiq_indiv.ParamByName('id_packcab').AsInteger:=id_packcab;
    dm.q_etiq_indiv.ParamByName('id_agrupa').AsInteger:=id_agrupa;
    dm.q_etiq_indiv.ParamByName('nivel_agr').AsInteger:=nivel_agr;
    dm.q_etiq_indiv.ParamByName('linea').AsInteger:=linea;
    dm.q_etiq_indiv.Open;

    barcode1:=rep_eti.FindObject('BarCode1') as tfrxbarcodeview;   //inttostr(<rep_db_indiv."id_packcab">)+'$'+inttostr(<rep_db_indiv."id_agrupa">)+'$'+inttostr(<rep_db_indiv."nivel_agr">)+'$'+inttostr(<rep_db_indiv."linea">)
    barcode2:=rep_eti.FindObject('BarCode2') as tfrxbarcodeview;   //inttostr(<rep_db_indiv."sulinea">)
    memo:=rep_eti.FindObject('memo14') as TfrxMemoView;            //'PLANES DE PENSIONES'


    if (dm.q_etiq_indiv.fieldbyname('codcli').asinteger=7004) then begin       //Es bankia (codigo de barras con sulinea)
      if (dm.q_etiq_indiv.fieldbyname('id_cliente').asinteger=2044) then begin       //planes de pensiones
        barcode2.Visible:=false;
        barcode1.Visible:=false;
        memo.Visible:=true;
      end else begin
        if trystrtoint(Copy(dm.q_etiq_indiv.FieldByName('sulinea').asstring,1,5),i) then barcode2.Visible:=true
        else barcode2.Visible:=false;
        barcode1.Visible:=False;
        memo.Visible:=False;
      end;
    end
    else begin                                                             //resto
      barcode2.Visible:=false;
      barcode1.Visible:=true;
      memo.Visible:=False;
    end;

    if not(dm.q_etiq_indiv.IsEmpty) then begin
      if ((cb_indiv_2040.checked) or (Copy(dm.q_etiq_indiv.FieldByName('referencia').asstring,1,4)<>'2040')) then begin   //si está marcado o es distinto a 2040
        rep_eti.PrintOptions.Printer:=u_globals.imp_eti2;
        if rep_eti.PrepareReport(True) then rep_eti.print;
      end;
    end;
  end;
end;

//
Function Tf_main.calc_digcon_chrono(codbar:string):Integer;
var  n,l,suma:Integer;
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

procedure Tf_main.cb_one_read_marks_allClick(Sender: TObject);
begin
    pnReparto.Visible:= gb_cajas.Visible; //and cb_one_read_marks_all.Checked;
    chRevLotes.Enabled := tiene_lotes and not cb_one_read_marks_all.Checked;

    if cb_one_read_marks_all.Checked then
        chRevLotes.Checked := false ;
end;

function Tf_main.pais_to_idx(pais:string):Integer;
begin
  result := indexstr(pais, ['ES', 'EN', 'IT']);
  if Result = -1 then Result :=1;        //English by default
end;

procedure Tf_main.translate(lang:Integer=0);        //0=Spanish 1=English 2=Italian
begin
  with rep_lis.findobject('m_pedido') as TfrxMemoView do begin
    memo.text := trans[0][lang];
  end;
  with rep_lis.findobject('m_fecha') as TfrxMemoView do begin
    memo.text := trans[1][lang];
  end;
  with rep_lis.findobject('m_destino') as TfrxMemoView do begin
    memo.text := trans[2][lang];
  end;
  with rep_lis.findobject('m_precinto') as TfrxMemoView do begin
    memo.text := trans[3][lang] + ' [rep_db_lis."precinto"]';
  end;
  with rep_lis.findobject('m_reembolso') as TfrxMemoView do begin
    memo.text := trans[4][lang] + ' [rep_db_lis."reembolso"]€';
  end;
  with rep_lis.findobject('m_portes') as TfrxMemoView do begin
    memo.text := trans[5][lang] + ' [rep_db_lis."portes"]€';
  end;
  with rep_lis.findobject('m_referencia') as TfrxMemoView do begin
    memo.text := trans[6][lang];
  end;
  with rep_lis.findobject('m_descripcion') as TfrxMemoView do begin
    memo.text := trans[7][lang];
  end;
 { with rep_lis.findobject('m_ubicacion') as TfrxMemoView do begin
    memo.text := trans[8][lang];
  end; }
  with rep_lis.findobject('m_uds') as TfrxMemoView do begin
    memo.text := trans[9][lang];
  end;
  with rep_lis.findobject('m_lote') as TfrxMemoView do begin
    memo.text := trans[10][lang] + ' = [rep_db_lis."n_lote"] / [rep_db_lis."caducidad"]';
  end;
end;


procedure Tf_main.imprime_eti_bulto_asm(codalbaran:integer);
const cr=Chr(13);
      lr=Chr(10);
var   codrepartidor,dst_coddel,bulto,s1,s2,dc, cli_lgs:Integer;    pdf417,codigopostal,poblacion,ch_codbulto,cliente_chrono,producto_chrono,s, datos_ag:string;
      lf:Char;
      graf1, graf2, graf3, graf4, graf5, graf6, graf7, cadena: string;    asm_correo,asm_horario,asm_codcli,bc, cli_bc:string;
      fichero: TextFile;
      str_agencia: TStringList;
begin
  dm.qry_sql2.Close;
  dm.qry_sql2.SQL.Clear;
  dm.qry_sql2.SQL.Add('select * from albaranes where codalbaran=:codalbaran');
  dm.qry_sql2.parameters.parambyname('codalbaran').value:=codalbaran;
  dm.qry_sql2.Open;

  dm.qry_sql3.Close;
  dm.qry_sql3.SelectSQL.Clear;
  dm.qry_sql3.SelectSQL.Text:='select * from a_packlin_bulto where codalbaran='+inttostr(codalbaran);
  dm.qry_sql3.Open;

  codrepartidor:=dm.qry_sql3.FieldByName('cod_repartidor').AsInteger;
  poblacion:=dm.qry_sql3.FieldByName('dst_localidad').AsString;
  codigopostal:=Trim(dm.qry_sql3.FieldByName('dst_cp').AsString);
  dst_coddel:=dm.qry_sql3.FieldByName('dst_coddel').asinteger;
  cli_lgs:=dm.qry_sql3.FieldByName('codcli').asinteger;
  //Cada cliente tiene un código diferente para ASM

  cli_bc := '';

 datos_ag := CargarDatosAgencia('cliente_inf_ag',cli_lgs,2);

 if datos_ag = '' then
 begin
       if cli_lgs=7004 then   //Bankia
              cli_bc := '43543'
        else if cli_lgs=7078 then  //Muzybar
                  cli_bc := '41968'
             else if cli_lgs=6077 then  //G.Pastor
                        cli_bc := '42112'
                   else if cli_lgs=7111 then  //Merydeis
                             cli_bc := '43552'
                        else if ((cli_lgs>=5100) and (cli_lgs<=5199)) then  //Merydeis Logística
                                  cli_bc := '62128'
                                  else if(cli_lgs=2043) then
                                   cli_bc := '43543';
 end
 else
     cli_bc := datos_ag;

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
  if ((cli_lgs>=5100) and (cli_lgs<=5152)) then  //Merydeis Logística
         asm_codcli:='5100'
  else
         asm_codcli:='7004';
  asm_correo:='COURIER';
  asm_horario:='4';

  dm.cds_bultos.Close;
  dm.cds_bultos.Active:=true;
  dm.cds_bultos.EmptyDataSet;

  for bulto:=1 to dm.qry_sql2.FieldByName('bultos').asinteger do begin      //etiqueta para cada bulto
    dm.cds_bultos.Insert;
    dm.cds_bultos.FieldByName('id_caja').AsInteger:=0;
    dm.cds_bultos.FieldByName('tipo_caja').asstring:='';
    dm.cds_bultos.FieldByName('codcli').AsInteger:=dm.qry_sql2.FieldByName('codcli').AsInteger;
    dm.cds_bultos.FieldByName('codalbaran').AsInteger:=codalbaran;
    dm.cds_bultos.FieldByName('unidades').AsInteger:=dm.qry_sql2.FieldByName('paquetes').AsInteger;;
    dm.cds_bultos.FieldByName('fecha').AsDateTime:=dm.qry_sql2.FieldByName('fecha').AsDateTime;
    dm.cds_bultos.FieldByName('codruta').AsInteger:=dm.qry_sql2.FieldByName('codruta').AsInteger;
    dm.cds_bultos.FieldByName('coddst').AsString:=FormatFloat('0000',dm.qry_sql2.FieldByName('dst_codcli').AsInteger)+formatfloat('0000',dm.qry_sql2.FieldByName('dst_coddel').AsInteger);
    dm.cds_bultos.fieldbyname('dst_nombre').asstring:=dm.qry_sql2.fieldbyname('dst_nombre').asstring;
    dm.cds_bultos.fieldbyname('dst_calle').asstring:=dm.qry_sql2.fieldbyname('dst_calle').asstring;
    dm.cds_bultos.fieldbyname('dst_cp').asstring:=FormatFloat('00000',StrToInt(codigopostal));
    dm.cds_bultos.fieldbyname('dst_localidad').asstring:=dm.qry_sql2.fieldbyname('dst_localidad').asstring;
    dm.cds_bultos.fieldbyname('dst_provincia').asstring:=dm.qry_sql2.fieldbyname('dst_provincia').asstring;
    dm.cds_bultos.FieldByName('bultos').AsInteger:=dm.qry_sql2.fieldbyname('bultos').asinteger;;
    dm.cds_bultos.FieldByName('observaciones').AsString:=dm.qry_sql2.fieldbyname('observaciones').AsString;
    dm.cds_bultos.FieldByName('dst_tfno').AsString:=dm.qry_sql2.FieldByName('dst_tfno').AsString;
    dm.cds_bultos.FieldByName('dst_coddel').AsString:=dm.qry_sql2.FieldByName('dst_coddel').AsString;
    dm.cds_bultos.FieldByName('dst_persona').AsString:=dm.qry_sql2.FieldByName('dst_persona').AsString;
    dm.cds_bultos.FieldByName('ordenbulto').asinteger:=bulto;
    dm.cds_bultos.FieldByName('codrepartidor').AsInteger:=codrepartidor;
    dm.cds_bultos.fieldbyname('org_nombre').asstring:= dm.qry_sql2.fieldbyname('org_nombre').asstring;
    dm.cds_bultos.fieldbyname('org_calle').asstring:= dm.qry_sql2.fieldbyname('org_calle').asstring;
    dm.cds_bultos.fieldbyname('org_cp').asstring:= dm.qry_sql2.fieldbyname('org_cp').asstring;
    dm.cds_bultos.fieldbyname('org_localidad').asstring:= dm.qry_sql2.fieldbyname('org_localidad').asstring;
    dm.cds_bultos.fieldbyname('org_provincia').asstring:= dm.qry_sql2.fieldbyname('org_provincia').asstring;
    dm.cds_bultos.FieldByName('org_tfno').AsString:= dm.qry_sql2.FieldByName('org_tfno').AsString;
    dm.cds_bultos.FieldByName('reembolso').AsString:= dm.qry_sql2.FieldByName('reembolso').AsString;
    dm.cds_bultos.FieldByName('referencia').AsString:= '';
    dm.cds_bultos.FieldByName('kgs').AsString:=dm.qry_sql2.FieldByName('Kgs').AsString;
    if dm.qry_sql2.FieldByName('pdebido').AsFloat <= 0 then
       dm.cds_bultos.FieldByName('sempor').AsString:='PAGADOS' else dm.cds_bultos.FieldByName('sempor').AsString:='DEBIDOS';

    dm.cds_bultos.FieldByName('asm_correo').AsString:= asm_correo;
    dm.cds_bultos.FieldByName('asm_horario').AsString:= asm_horario;
    dm.cds_bultos.FieldByName('asm_codcli').AsString:= asm_codcli;
    dm.cds_bultos.FieldByName('asm_mnemo').AsString:= dm.qrytemp.FieldByName('id_del').AsString;
    dm.cds_bultos.FieldByName('asm_pobla').AsString:= dm.qrytemp.FieldByName('nombre').AsString;
    dm.cds_bultos.FieldByName('asm_bc_human').AsString:='31-' + cli_bc + '-'+formatfloat('0000000',codalbaran);
    dm.cds_bultos.FieldByName('asm_tracking').AsString:='31' + cli_bc + formatfloat('0000000',codalbaran);
    bc:='31' + cli_bc + formatfloat('0000000',codalbaran)+formatfloat('000',bulto);
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

  fr_asm.PrintOptions.Printer:=imp_eti;
  if fr_asm.PrepareReport(True) then fr_asm.print;

end;

function Tf_main.limpiachar(frase: string):string;
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

procedure Tf_main.cerrar_agrupa_error;                          //guardar errores agrupación
var codalbaran:integer;
begin
  with tpfibdataset.Create(dm) do begin                                //Cajas por cerrar
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select l.codalbaran,b.id_caja '+
      'from a_packlin l '+
      'inner join a_packlin_bulto b on (l.id_packlin_bulto=b.id_packlin_bulto) '+
      'where l.id_packcab=:id_packcab and l.nivel_agr=:nivel_agr and l.id_agrupa=:id_agrupa and l.cantidad_i<>l.cantidad '+
      'group by 1,2 order by 2');
    ParamByName('nivel_agr').asinteger:=nivel_agr;
    ParamByName('id_packcab').asinteger:=id_packcab;
    ParamByName('id_agrupa').asinteger:=id_agrupa;
    Open;

    if not(IsEmpty) then begin                   //Uds pendientes
      first;
      while not(eof) do begin
        codalbaran:=FieldByName('codalbaran').asinteger;

        lb_cajas_st.Visible:=true;
        lb_cajas_st.caption:='Caja Cerrada '+fieldbyname('id_caja').asstring;

        if FileExists(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+'-'+formatfloat('00',fieldbyname('id_caja').AsInteger)+'.wav') then
          sndPlaySound(PChar(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+'-'+formatfloat('00',fieldbyname('id_caja').asinteger)+'.wav'),SND_NODEFAULT Or SND_ASYNC);

        Sleep(500);

        if FileExists(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+'-Caja_Cerrada.wav') then
          sndPlaySound(PChar(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+'-Caja_Cerrada.wav'),SND_NODEFAULT Or SND_ASYNC);


        with tpfibquery.create(Self) do                         //Actualiza Datos
        try
          Database:=dm.db;
          Transaction:=dm.t_write;
          dm.t_write.StartTransaction;

          sql.Add('insert into a_packlin_error '+
            'select * '+
            'from a_packlin l '+
            'where l.id_packcab=:id_packcab and l.nivel_agr=:nivel_agr and l.id_agrupa=:id_agrupa and l.codalbaran=:codalbaran and l.cantidad_i<>l.cantidad ');
          ParamByName('nivel_agr').asinteger:=nivel_agr;
          ParamByName('id_packcab').asinteger:=id_packcab;
          ParamByName('id_agrupa').asinteger:=id_agrupa;
          ParamByName('codalbaran').asinteger:=codalbaran;
          execquery;

          SQL.Clear;
          sql.Add('delete '+
            'from a_packlin l '+
            'where l.id_packcab=:id_packcab and l.nivel_agr=:nivel_agr and l.id_agrupa=:id_agrupa and l.codalbaran=:codalbaran and l.cantidad_i<>l.cantidad ');
          ParamByName('nivel_agr').asinteger:=nivel_agr;
          ParamByName('id_packcab').asinteger:=id_packcab;
          ParamByName('id_agrupa').asinteger:=id_agrupa;
          ParamByName('codalbaran').asinteger:=codalbaran;
          ExecQuery;

          dm.t_write.commit;

          InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','Bt.CerrarAgr. PendientesDescartados. ' + IntToStr(codalbaran),
                     lb_picking.Caption + ' ' + lbAgrupacion.Caption);

        finally
          Free;
        end;

        Sleep(1500);
        next;
      end;

    end;
    Free;
  end;

  dm.q_packagr.Close;
  dm.q_packagr.Open;

  dm.q_pack.Close;
  dm.q_pack.Open;

  dm.q_pack_leido.Close;
  dm.q_pack_leido.Open;

  act_cajas;
end;

procedure Tf_main.cerrar_albaran(codalbaran:integer);
var n_fecha:tdate;     bultos, repartidor:integer;
begin
  with tpfibdataset.create(Self) do begin                  //Buscar Bultos
    Database:=dm.db;
    sqls.SelectSQL.Add('select b.bultos, b.cod_repartidor '+
      'from a_packlin l '+
      'inner join a_packlin_bulto b on (l.id_packlin_bulto=b.id_packlin_bulto) '+
      'where l.id_packcab=:id_packcab and l.id_agrupa=:id_agrupa and l.nivel_agr=:nivel_agr and l.codalbaran=:codalbaran' );
    ParamByName('id_packcab').asinteger:=id_packcab;
    ParamByName('id_agrupa').asinteger:=id_agrupa;
    ParamByName('nivel_agr').asinteger:=nivel_agr;
    ParamByName('codalbaran').asinteger:=codalbaran;
    Open;

    if isempty then begin
      bultos:=0;
      repartidor := 0;
    end else  begin
      bultos:=FieldByName('bultos').AsInteger;
      repartidor :=  FieldByName('cod_repartidor').AsInteger;
    end;
    Free;
  end;

  n_fecha:=siguiente_laboral(Date);                          //Fecha

  if repartidor<46000 then
  begin
    with tpfibquery.create(Self) do                                 //Cambia fecha y bultos en Gestoras
    try
     try
      Database:=dm.db_gestoras;
      Transaction := dm.t_write_gestoras;
      dm.t_write_gestoras.StartTransaction;
      //SQL.Clear;
      SQL.Add('update albaranes set bultos=:bultos '+
              ', fecha_servicio=:fecha ' +
              ' where id_albaran=:codalbaran');
      ParamByName('fecha').Value:=n_fecha;
      ParamByName('bultos').Value:=bultos;
      ParamByName('codalbaran').Value:=codalbaran;

      ExecQuery;

      dm.t_write_gestoras.Commit;

      DMCreaBultos.GeneraBultos(codalbaran,get_albaran_dest(codalbaran));

     except
        dm.t_write_gestoras.Rollback;
     end;
    finally
      Free;
    end;

   // DMCreaBultos.GeneraBultos(codalbaran,get_albaran_dest(codalbaran));

    with tpfibquery.create(Self) do                                 //Cambia bultos en pedido de almacén
    try
     try
      Database:=dm.db;
      Transaction := dm.t_write;
      dm.t_write.StartTransaction;
      //SQL.Clear;
      SQL.Add('update c_pedidos set bultos=:bultos '+
        ' where codalbaran=:codalbaran');
      ParamByName('bultos').Value:=bultos;
      ParamByName('codalbaran').Value:=codalbaran;

      ExecQuery;

      dm.t_write.Commit;
     except
        dm.t_write.Rollback;
     end;

    finally
      Free;
    end;
  end else begin

    if id_cliente<>6702 then begin

      with TADOQuery.create(Self) do                                 //Cambia fecha y bultos en SQL Server
      try
        Connection := dm.con1;
        SQL.Clear;
        SQL.Add('update albaranes set fecha=:fecha,bultos=:bultos '+
          ' where codalbaran=:codalbaran');
        Parameters.ParamByName('fecha').Value:=n_fecha;
        Parameters.ParamByName('bultos').Value:=bultos;
        Parameters.ParamByName('codalbaran').Value:=codalbaran;

        ExecSQL;
      finally
        Free;
      end;


      with tadoquery.create(self) do                      //Reasigna hoja de ruta
      try
        connection:= dm.con1;
        sql.Add('declare @r int');
        sql.add('exec @r=lgAsignaHoja ');
        sql.add(inttostr(codalbaran));
        sql.add('select @r');
        Open;

        if Fields[0].asinteger<>0 then sMessageDlg('Albarán '+inttostr(codalbaran)+' No Se Ha Podido Reasignar A Hoja De Ruta',mtError,[mbok],0);
      finally
        free;
      end;

      update_sqlserver_lotes(codalbaran);
    end else begin
      n_fecha:=date;
    end;

  end;

  with tpfibquery.create(Self) do                                                   //ACTUALIZA BULTO en FB
  try
    Database:=dm.db;
    Transaction:=dm.t_write;
    //Cambiado a codalbaran ya que sino, la q
    sql.Add('update a_packlin_bulto b set b.fecha_alb=:fecha_alb,b.impreso=''S'',b.fecha=:fecha, b.hora=:hora, b.id_usuario=:id_usuario, b.pc=:pc '+
    {  'where b.id_packlin_bulto in ('+
      '  select l.id_packlin_bulto from a_packlin l where l.id_packcab=:id_packcab and l.id_agrupa=:id_agrupa and l.nivel_agr=:nivel_agr and l.codalbaran=:codalbaran'+}
      'where b.codalbaran in ('+
      '  select l.codalbaran from a_packlin l where l.id_packcab=:id_packcab and l.id_agrupa=:id_agrupa and l.nivel_agr=:nivel_agr and l.codalbaran=:codalbaran'+
      ')');
    ParamByName('codalbaran').AsInteger:=codalbaran;
    ParamByName('id_packcab').asinteger:=id_packcab;
    ParamByName('id_agrupa').asinteger:=id_agrupa;
    ParamByName('nivel_agr').asinteger:=nivel_agr;
    ParamByName('fecha_alb').asdate:=n_fecha;
    ParamByName('fecha').AsDate:=date;
    ParamByName('hora').AsTime:=Time;
    //ParamByName('id_usuario').AsInteger:=u_globals.id_usuario;
    ParamByName('id_usuario').AsInteger := usuario.id;
    ParamByName('pc').AsString:= pc.Nombre;

    dm.t_write.StartTransaction;
    execquery;
    dm.t_write.commit;
  finally
    Free;
  end;
end;

procedure Tf_main.update_sqlserver_lotes(codalbaran:integer);
var old_codmov, new_codmov:Integer;     q, q_old:TADOQuery;
begin
  with tpfibdataset.create(Self) do begin                             //Todos los movimientos distintos del albaran
    Database:=dm.db;
    sqls.SelectSQL.Add('select codmovimiento '+
      'from a_packlin l '+
      'where l.id_packcab=:id_packcab and l.id_agrupa=:id_agrupa and l.nivel_agr=:nivel_agr and l.codalbaran=:codalbaran '+
      'order by codmovimiento ');
    ParamByName('id_packcab').asinteger:=id_packcab;
    ParamByName('id_agrupa').asinteger:=id_agrupa;
    ParamByName('nivel_agr').asinteger:=nivel_agr;
    ParamByName('codalbaran').asinteger:=codalbaran;
    Open;

    first;
    while not(eof) do begin
      old_codmov:=fieldbyname('codmovimiento').asinteger;

      if old_codmov > 0 then begin
        dm.q_fib.close;                                                  //Para cada movimiento doblado por lotes
        dm.q_fib.selectsql.clear;
        dm.q_fib.selectsql.add('select l.cantidad, lo.nombre as n_lote, lo.caducidad, count(*) as total from a_packlin l inner join a_lotes lo on (l.id_lote=lo.id_lote) '+
          'where l.id_packcab=:id_packcab and l.id_agrupa=:id_agrupa and l.nivel_agr=:nivel_agr and l.codalbaran=:codalbaran and codmovimiento=:codmovimiento ' +
          'group by l.cantidad, lo.nombre, lo.caducidad ');
        dm.q_fib.ParamByName('id_packcab').asinteger:=id_packcab;
        dm.q_fib.ParamByName('id_agrupa').asinteger:=id_agrupa;
        dm.q_fib.ParamByName('nivel_agr').asinteger:=nivel_agr;
        dm.q_fib.ParamByName('codalbaran').asinteger:=codalbaran;
        dm.q_fib.ParamByName('codmovimiento').asinteger:=old_codmov;
        dm.q_fib.open;

        if (dm.q_fib.fieldbyname('total').asinteger>1) then begin
          q_old := TADOQuery.create(self);                                  //Datos del movimiento viejo en sql server
          q_old.connection:=dm.con1;
          q_old.sql.clear;
          q_old.sql.add('select * from servicios_lineas where codmovimiento=:codmovimiento');
          q_old.parameters.parambyname('codmovimiento').value:=old_codmov;
          q_old.open;
          q_old.first;

          if not(q_old.eof) then begin
            dm.q_fib.first;
            while not(dm.q_fib.eof) do begin
              q := TADOQuery.Create(Self);
              q.Connection:=dm.con1;                                  //nuevo cod movimiento
              q.SQL.Clear;
              q.SQL.Add('select dbo.getCodMovimiento() as codmov');
              q.open;

              new_codmov := q.FieldByName('codmov').AsInteger;

              q.close;
              q.sql.clear;
              q.sql.add('insert into servicios_lineas (codservicio,codmovimiento,fmovimiento,codarticulo,e_s,codalbaran,unidades, '+
                'sulinea,estado,att,kgs,estadoimp, reembolso, vasegurado, lote, caducidad) '+
                ' values (:codservicio,:codmovimiento,:fmovimiento,:codarticulo,:e_s,:codalbaran,:unidades, '+
                ':sulinea,:estado,:att,:kgs,:estadoimp, :reembolso, :vasegurado, :lote, :caducidad)');
              q.parameters.parambyname('codservicio').value:=q_old.fieldbyname('codservicio').asinteger;
              q.parameters.parambyname('codmovimiento').value:=new_codmov;
              q.parameters.parambyname('fmovimiento').value:=q_old.fieldbyname('fmovimiento').asdatetime;
              q.parameters.parambyname('codarticulo').value:=q_old.fieldbyname('codarticulo').asinteger;
              q.parameters.parambyname('e_s').value:=q_old.fieldbyname('e_s').asstring;
              q.parameters.parambyname('unidades').value:=dm.q_fib.fieldbyname('cantidad').asinteger;
              q.parameters.parambyname('sulinea').value:=q_old.fieldbyname('sulinea').asstring;
              q.parameters.parambyname('estado').value:=q_old.fieldbyname('estado').asstring;
              q.parameters.parambyname('att').value:=q_old.fieldbyname('att').asstring;
              q.parameters.parambyname('kgs').value:=q_old.fieldbyname('kgs').asfloat;
              q.parameters.parambyname('estadoimp').value:=q_old.fieldbyname('estadoimp').asstring;
              q.parameters.parambyname('reembolso').value:=q_old.fieldbyname('reembolso').asfloat;
              q.parameters.parambyname('vasegurado').value:=q_old.fieldbyname('vasegurado').asfloat;
              q.parameters.parambyname('lote').value:=dm.q_fib.fieldbyname('n_lote').asstring;
              q.parameters.parambyname('caducidad').value:=q_old.fieldbyname('caducidad').asdatetime;
              q.execsql;

              dm.q_fib.next;
            end;

            q.Close;                                                             //delete old cod mov
            q.SQL.Clear;
            q.SQL.Add('delete from servicios_lineas where codmovimiento=:codmovimiento');
            q.parameters.parambyname('codmovimiento').value:=old_codmov;
            q.ExecSQL;
          end;
          freeandnil(q);
          freeandnil(q_old);
        end;
      end;
      next;
    end;
    Free;
  end;
end;


function Tf_main.siguiente_laboral(fecha:TDateTime):tdate;
var n_fecha:TDate;
begin
  n_fecha:=incday(fecha,1);

  while es_festivo(n_fecha) do n_fecha:=incday(n_fecha,1);

  result:=n_fecha;
end;

function Tf_main.es_festivo(fecha:TDateTime):Boolean;         //true=dia festivo false=dia no festivo
var fiesta:Boolean;
begin
  with tpfibdataset.create(Self) do
  try
    Database:=dm.db;
    sqls.SelectSQL.Add('select fecha '+
      'from g_festivos '+
      'where fecha=:fecha and id_empresa=:id_empresa and estado<''B'' ');
    ParamByName('fecha').Asdate:=fecha;
    ParamByName('id_empresa').AsInteger:=u_globals.id_empresa;
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


function Tf_main.check_chrono:boolean;
begin
  with tpfibdataset.Create(self) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select first 1 codrepartidor from a_packlin where id_packcab=:id_packcab and id_agrupa=:id_agrupa and nivel_agr=:nivel_agr');
    ParamByName('id_packcab').asinteger:=id_packcab;
    ParamByName('id_agrupa').asinteger:=id_agrupa;
    ParamByName('nivel_agr').asinteger:=nivel_agr;
    Open;

    First;
    if not(IsEmpty) then Result:=FieldByName('codrepartidor').AsInteger = 46172
    else result:=False;

    Free;
  end;
end;

function tf_main.check_dhl:Boolean;
begin
 with tpfibdataset.Create(self) do
  begin
   database:=dm.db;
   SQLs.SelectSQL.Clear;
   SQLs.SelectSQL.Add('select first 1 codrepartidor from a_packlin where id_packcab=:id_packcab and id_agrupa=:id_agrupa and nivel_agr=:nivel_agr');
   ParamByName('id_packcab').asinteger:=id_packcab;
   ParamByName('id_agrupa').asinteger:=id_agrupa;
   ParamByName('nivel_agr').asinteger:=nivel_agr;
   Open;
   First;
   if not(IsEmpty) then Result:=FieldByName('codrepartidor').AsInteger = 46276
   else result:=False;
   Free;
  end;
end;

procedure Tf_main.chEtXLectClick(Sender: TObject);
begin
    bt_cerrar_agrup.Enabled := not chEtXLect.Checked;
end;

procedure Tf_main.chHojaPickClick(Sender: TObject);
begin
  rgFmtHPick.Visible := chHojaPick.Checked;
end;

procedure Tf_main.chRevLotesClick(Sender: TObject);
begin
  if chRevLotes.Checked then
    cb_one_read_marks_all.Checked := False;

  cb_one_read_marks_all.Enabled := not chRevLotes.checked;
end;

procedure Tf_main.send_chrono_file;
var   cuerpo:tstrings;    ruta:string;        //////////// email:Tf_envia_mail;
begin
  ruta:=u_globals.ruta_exe + 'bak\';
  ForceDirectories(ruta);
  //ruta:=u_gen_gl.sys_path+u_cam_gl.chrono_exp_path+get_nombrefichero_chrono(date);
  ruta:=ruta + get_nombrefichero_chrono(date);
  genera_fichero_abierto(ruta);
  lb_st.Caption:='Enviando Correo';

  cuerpo:=tstringlist.Create;
  cuerpo.Add('Se Adjunta Archivo de Expediciones de Loginser');

  ////////////////
 { email:=Tf_envia_mail.create(Self);
  email.Show;
  email.envia_email(u_cam_gl.chrono_exp_email,'','Fichero Life Is Short '+formatdatetime('yymmdd',Date)+'_'+formatdatetime('hhnnss',time),
    ruta,cuerpo);
  cuerpo.Free;
  email.close;
  email.Free;   }

  lb_st.Caption:='Proceso Finalizado';
  //sMessageDlg('Proceso Finalizado, Archivo de Respaldo en '+ruta,mtInformation,[mbok],0);
end;

procedure tf_main.send_dhl_file;
var  ruta,fichero,destino:string;
begin
  //ruta:=u_globals.ruta_exe + 'bak\';
  //ForceDirectories(ruta);
  //fichero:=get_nombrefichero_dhl;
  //ruta:=ruta + fichero;
  //genera_fichero_agrupado_dhl(ruta);
  //lb_st.Caption:='Conectando a SFTP';
  //enviarFicheroSSH(ruta,fichero);
  //lb_st.Caption:='Proceso Finalizado';

end;

procedure Tf_main.genera_fichero_abierto(filename:string);          //Genera Fichero
var  f:textfile;  codrepartidor,linea:string;
begin
  codrepartidor:='46172';                          //CHRONO EXPRESS

  with tpfibdataset.Create(self) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select b.codalbaran '+
      ' from a_packlin_bulto b '+
      ' inner join a_packlin l on (b.id_packlin_bulto=l.id_packlin_bulto) '+
      ' inner join a_packcab c on (c.id_packcab=l.id_packcab) '+
      ' where c.id_packcab=:id_packcab and l.id_agrupa=:id_agrupa and l.nivel_agr=:nivel_agr and l.codrepartidor=:codrepartidor '+
      ' group by b.codalbaran order by b.codalbaran');
    ParamByName('id_packcab').asinteger:=id_packcab;
    ParamByName('id_agrupa').asinteger:=id_agrupa;
    ParamByName('nivel_agr').asinteger:=nivel_agr;
    ParamByName('codrepartidor').asinteger:=StrToInt(codrepartidor);
    Open;

    First;
    if not(IsEmpty) then begin
      try
        AssignFile(f,filename);
        Rewrite(f);
        while not(Eof) do begin
          linea:=linea_chrono_abierto(FieldByName('codalbaran').asinteger);

          if linea<>'' then begin
            Writeln(f,linea);
            marca_alb_abierto_enviado(FieldByName('codalbaran').asinteger);
          end;

          next;
        end;
      finally
        CloseFile(f);
      end;

    end else raise exception.Create('No Hay Expediciones Para Enviar');

    Free;
  end;
end;


function Tf_main.get_nombrefichero_dhl:string;
var ano,mes,dia,hor,min,seg,mseg:word;
nombre:string;
begin
  DecodeDateTime(Now(),ano,mes,dia,hor,min,seg,mseg);
  nombre:='';
  nombre:=nombre + 'T'; //T valor literal de Transmision
  nombre:=nombre+'046'+'_'; //Corresponde a la agencia de origen de la mercancia (Valencia = 46)
  nombre:=nombre+'0000007641'+'_'; //Codigo de cliente Loginser en DHL
  nombre:=nombre+Copy(IntToStr(ano) ,3, 4);
  if(mes<10) then
    nombre:=nombre+'0'+inttostr(mes)
  else nombre:=nombre+inttostr(mes);
  if(dia<10) then
    nombre:=nombre+'0'+inttostr(dia)+'_'
  else nombre:=nombre+inttostr(dia)+'_';
  // Fecha de generacion del fichero
  if(hor<10) then
   nombre:=nombre+'0'+inttostr(+hor)
  else nombre:=nombre+inttostr(hor);
  if(min<10) then
   nombre:=nombre+'0'+IntToStr(min)
  else  nombre:=nombre+IntToStr(min);
  if(seg<10) then
   nombre:=nombre+'0'+IntToStr(seg)
  else  nombre:=nombre+IntToStr(seg);
  //Hora de generacion del fichero
  nombre:=nombre+'.exp'; //Extension del archivo
  result:=nombre;
end;

procedure Tf_main.grRepartoDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);

begin

  if column.index=0 then
       col := Column.Field.Value;

  if col<>aux_alb then
  begin

    if Column.Index=0 then
    begin
      aux_alb := Column.Field.Value;
      if UnColor=16119502 then
           UnColor:=clWhite
      else
           UnColor:=16119502;
    end;
  end;

  with (Sender As TDBGrid).Canvas do
  begin
    brush.Color:=UnColor;
    FillRect(Rect);
    TextOut(Rect.Left, Rect.Top, Column.Field.AsString);
  end;
end;

procedure Tf_main.gr_grid2CellClick(Column: TColumn);
var
  id, i:integer;
begin
    lbReparto.Caption := 'Reparto COMPLETO ' + #13#10 + buscaArticuloXCod(dm.q_pack_leido.FieldByName('codigo').AsString,id);

    if dm.q_pack_leido.FieldByName('total').AsInteger<>dm.q_pack_leido.FieldByName('leidos').AsInteger then
    begin
      if not cdsreparto.Active then
         cdsreparto.CreateDataSet;
      cdsreparto.EmptyDataSet;
      cdsreparto.Append;
      cdsreparto.FieldByName('codalbaran').AsString := '';
      cdsreparto.FieldByName('num_cajas').AsString := '';
      cdsreparto.FieldByName('lote').AsString := '';
      cdsreparto.FieldByName('uds').AsString := '';
      cdsreparto.FieldByName('bultos').AsString := '';
      cdsreparto.FieldByName('n_bulto').AsString := '';
      cdsreparto.Post;
      Exit;
    end;


    reparte(id,'R');

end;

procedure Tf_main.gr_grid2TitleClick(Column: TColumn);
var
  i: integer;
begin
    if col_order=Column.index then
        order_desc := not order_desc
    else
        order_desc := False;

    col_order := Column.Index;


    filter_leidos(IntToStr(col_order+1));

    if not dm.q_pack_leido.IsEmpty then
    for I := 0 to gr_grid2.Columns.Count-1 do
      If Column.Index=i then
            gr_grid2.Columns[i].Title.Font.Color := clPurple
      else
            gr_grid2.Columns[i].Title.Font.Color := clBlack;
end;

procedure Tf_main.gr_gridCellClick(Column: TColumn);
begin
  if Column.FieldName='CODIGO' then
  begin
    Clipboard.SetTextBuf(pWideChar(dm.q_pack.FieldByName('codigo').AsString));
    gr_grid.Hint := 'Texto ' + dm.q_pack.FieldByName('codigo').AsString + '  copiado al portapapeles';
    gr_grid.ShowHint := True;
  end;

end;

procedure Tf_main.gr_gridTitleClick(Column: TColumn);
var
  i: integer;
begin
    if col_order=Column.index then
        order_desc := not order_desc
    else
        order_desc := False;

    col_order := Column.Index;

    filter_ptes(IntToStr(col_order+1));

    if not dm.q_pack.IsEmpty then
    for I := 0 to gr_grid.Columns.Count-1 do
      If Column.Index=i then
            gr_grid.Columns[i].Title.Font.Color := clPurple
      else
            gr_grid.Columns[i].Title.Font.Color := clBlack;
end;

function Tf_main.get_nombrefichero_chrono(fecha: TDateTime):string;
var contador:integer;  ano,mes,dia:word;
begin
  dm.q_fib.close;
  dm.q_fib.selectsql.Clear;
  dm.q_fib.selectsql.Add('select contador from C_CHRONO_FICENVALB where fecha = :fecha');
  dm.q_fib.ParamByName('fecha').asdatetime:=fecha;
  dm.q_fib.Open;

  try
    dm.t_write.startTransaction;

    if dm.q_fib.isempty then begin
      contador:=1;

      dm.qu_1.close;
      dm.qu_1.SQL.Clear;
      dm.qu_1.sql.Add('insert into C_CHRONO_FICENVALB (fecha,contador) values (:fecha,:contador) ');
      dm.qu_1.ParamByName('fecha').asdatetime:=fecha;
      dm.qu_1.ParamByName('contador').asinteger:=contador+1;
      dm.qu_1.ExecQuery;

    end else begin
      contador:=dm.q_fib.FieldByName('contador').AsInteger;

      dm.qu_1.close;
      dm.qu_1.sql.Clear;
      dm.qu_1.sql.Add('update C_CHRONO_FICENVALB set contador = :contador where fecha = :fecha');
      dm.qu_1.ParamByName('fecha').Value:=fecha;
      dm.qu_1.ParamByName('contador').value:=contador+1;
      dm.qu_1.execquery;
    end;

    dm.t_write.CommitRetaining;
  except
    dm.t_write.RollbackRetaining;
  end;
  DecodeDate(fecha,ano,mes,dia);
  result:='MEC519500001'+formatfloat('00',dia)+formatfloat('00',mes)+formatfloat('00',ano)+
      formatfloat('00',contador)+'.txt';
end;

function Tf_main.linea_chrono_abierto(codalbaran:Integer):string;                   //Genera Linea para chronoexpres
var   bultos,cp:integer; cliente_chrono,producto_chrono,n_bulto_chrono_ini,n_bulto_chrono_fin:string;
begin
  with tpfibdataset.create(Self) do                               //Dpto Origen
  try
    Database:=dm.db;
    sqls.SelectSQL.Add('select b.n_bulto_chrono '+
      ' from a_packlin_bulto b '+
      ' inner join a_packlin l on (b.id_packlin_bulto=l.id_packlin_bulto) '+
      ' inner join a_packcab c on (c.id_packcab=l.id_packcab) '+
      ' where c.id_packcab=:id_packcab and l.id_agrupa=:id_agrupa and l.nivel_agr=:nivel_agr '+
      ' and b.codalbaran=:codalbaran order by 1');
    ParamByName('id_packcab').asinteger:=id_packcab;
    ParamByName('id_agrupa').asinteger:=id_agrupa;
    ParamByName('nivel_agr').asinteger:=nivel_agr;
    ParamByName('codalbaran').AsInteger:=codalbaran;
    Open;

    if not(isempty) then begin
      first;
      n_bulto_chrono_ini:=FieldByName('n_bulto_chrono').AsString;
      last;
      n_bulto_chrono_fin:=FieldByName('n_bulto_chrono').AsString;
    end else begin
      n_bulto_chrono_ini:='0';
      n_bulto_chrono_fin:='0';
    end;
  finally
    Free;
  end;

  with tpfibdataset.create(Self) do
  try
    Database:=dm.db;
    sqls.SelectSQL.Add('select distinct b.dst_cp,b.dst_codcli,b.bultos,b.dst_nombre,b.dst_calle,b.dst_persona,b.dst_tfno,b.dst_localidad,b.kgs, '+
      'b.observaciones,b.fecha_alb,b.dst_coddel,0 as asegurado, reembolso '+
      ' from a_packlin_bulto b '+
      ' inner join a_packlin l on (b.id_packlin_bulto=l.id_packlin_bulto) '+
      ' inner join a_packcab c on (c.id_packcab=l.id_packcab) '+
      ' where c.id_packcab=:id_packcab and l.id_agrupa=:id_agrupa and l.nivel_agr=:nivel_agr '+
      ' and b.codalbaran=:codalbaran');
    ParamByName('id_packcab').asinteger:=id_packcab;
    ParamByName('id_agrupa').asinteger:=id_agrupa;
    ParamByName('nivel_agr').asinteger:=nivel_agr;
    ParamByName('codalbaran').AsInteger:=codalbaran;
    Open;

    if not(isempty) then begin
      cp:=fieldbyname('dst_cp').asinteger;
      if (((cp>=35000) and (cp<=35999)) or ((cp>=38000) and (cp<=38999))) then begin
        producto_chrono:='69';
      end else begin
        producto_chrono:='63';
      end;

      cliente_chrono:='519500001';
      bultos:=FieldByName('bultos').AsInteger;

      result:=cliente_chrono+     // Numero de cliente crono
        cadLongitudFija('Life Is Short',40,False,' ')+   // Nombre del Cliente de Crono
        cadLongitudFija(n_bulto_chrono_ini,23,False,'0')+ // codigo de bulto inicial
        cadLongitudFija(get_chrono_exp(codalbaran,cliente_chrono),20,False,' ') + //referencia del cliente
        cadLongitudFija(FieldByName('dst_nombre').asstring,40,false,' ') + // nombre del consignatario
        cadLongitudFija(FieldByName('dst_calle').asstring,40,false,' ') + // direccion del consignatario
        cadLongitudFija(FieldByName('dst_persona').asstring,40,false,' ') + // atencion del consignatario
        '  '+//por que piden 7 para el cp... relleno
        cadLongitudFija(FieldByName('dst_cp').asstring,5,true,'0') + // cp del consignatario
        cadLongitudFija(FieldByName('dst_tfno').asstring,15,false,' ') + // tfno del consignatario
        cadLongitudFija(FieldByName('dst_localidad').asstring,40,false,' ') + // poblacion del consignatario
        'P' + // portes pagados
        producto_chrono +   // tipo de producto
        FormatFloat('000000',bultos) +  // numero de bultos
        FormatFloat('000000.000',FieldByName('Kgs').asfloat) + // peso
        FormatFloat('000000000.00', FieldByName('reembolso').asfloat) +  //importe reembolso
        cadLongitudFija(get_chrono_exp(codalbaran,cliente_chrono),16,false,'0')+
        '    ' + // codigo pais  nacional en blanco
        cadLongitudFija(n_bulto_chrono_fin,23,False,'0')+ // codigo de bulto inicial
        cadLongitudFija(FieldByName('observaciones').AsString,40,false,' ') + // observa 1
        cadLongitudFija(' ',40,false,' ')+   // observa 2
        FormatDateTime('yyyymmdd',FieldByName('fecha_alb').AsDateTime)+ // fecha salida
        '                              '+      //Numero de serie antiguo (Solo para producto Loinex)
        '                    '+       //Modelo de Nuevo (Solo para producto Loinex)
        '                    '+       //Modelo Viejo (Solo para producto Loinex)
        '                '+          //Número de Envío de Retorno Loinex (Debe ser el estandar de ChronoExpres)
        '                              '+      //Numero de serie nuevo (Solo para producto Loinex)
        FormatFloat('000000000.00',FieldByName('asegurado').asfloat); // Valor asegurado de la mercancía
    end;
  finally
    Free;
  end;

end;

procedure Tf_main.marca_alb_abierto_enviado(codalb:Integer);
begin
  with tpfibquery.create(Self) do
  try
    Database:=dm.db;
    Transaction:=dm.t_write;
    sql.Add('update a_packlin_bulto set enviado=''S'' '+
        'where codalbaran=:codalbaran');
    ParamByName('codalbaran').asinteger:=codalb;
    dm.t_write.StartTransaction;
    try
      ExecQuery;
      dm.t_write.commitretaining;
    except
      dm.t_write.Rollbackretaining;
    end;
  finally
    Free;
  end;
end;

function Tf_main.cadLongitudFija (cadena : string; longitud : Integer;   posicionIzquierda : boolean; valorRelleno : string) : string;
var    i: integer;
begin
  if length(cadena) > longitud then
    cadena := copy(cadena, 1, longitud)
  else
  begin
    for i := 1 to longitud - Length(cadena) do
      if posicionIzquierda then
        cadena := valorRelleno + cadena
      else
        cadena := cadena + valorRelleno;
  end;
  Result := cadena;
end;

function Tf_main.get_chrono_exp(codalbaran:integer; codcli:string):string;
begin
  result:= codcli + FormatFloat('0000000',codalbaran);   //16
end;

procedure Tf_main.send_hoja_pick(codalbaran:Integer);
var  path,filename,email:string;         cuerpo:tstringlist;
begin
  dm.q_hoja_pick.Close;
  dm.q_hoja_pick.SelectSQL.Clear;
  dm.q_hoja_pick.SelectSQL.Add('select b.codalbaran,b.fecha_alb,b.dst_codcli,b.dst_coddel, '+
    '  b.cod_ruta,b.tipo_caja,b.id_caja,b.dst_nombre,b.dst_calle,b.dst_cp, '+
    '  b.dst_localidad,b.dst_provincia,iif(a.id_cliente=7004,substring(a.codigo from 7 for 6),a.codigo) as codigo, '+
    '  iif(a.id_cliente=7004,l.sulinea,0) as bc,a.nombre,l.att,l.sulinea,b.codcli, '+
    '  sum(l.cantidad) as cantidad '+
    'from a_packlin l '+
    'inner join a_packlin_bulto b on (l.id_packlin_bulto=b.id_packlin_bulto) '+
    'inner join g_articulos a on (l.id_articulo=a.id_articulo) '+
    'where l.id_packcab=:id_packcab and l.id_agrupa=:id_agrupa and l.nivel_agr=:nivel_agr and l.codalbaran=:codalbaran '+
    'group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18 '+
    'order by 16,17');
  dm.q_hoja_pick.ParamByName('nivel_agr').asinteger:=nivel_agr;
  dm.q_hoja_pick.ParamByName('id_packcab').asinteger:=id_packcab;
  dm.q_hoja_pick.ParamByName('id_agrupa').asinteger:=id_agrupa;
  dm.q_hoja_pick.ParamByName('codalbaran').asinteger:=codalbaran;
  dm.q_hoja_pick.Open;

  with rep_pick2.FindObject('memo4') as TfrxMemoView do begin
    if (dm.q_hoja_pick.FieldByName('codcli').asinteger=455) then Visible:=true
    else Visible:=false;
  end;

  //path:=sys_path+pick_path+'\'+formatdatetime('yyyy.mm.dd',now);
  path:=u_globals.ruta_exe+'temp\'+formatdatetime('yyyy.mm.dd',now);
  filename:=path+'\'+inttostr(codalbaran)+'.pdf';

  ForceDirectories(path);
  pdf_export.FileName:=filename;

  rep_pick2.PrepareReport(True);
  rep_pick2.Export(pdf_export);

  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select email from g_delegaciones where id_cliente=2038 and cod_delegacion=:coddel');
    ParamByName('coddel').AsInteger:=dm.q_hoja_pick.FieldByName('dst_coddel').AsInteger;
    Open;

    email:=FieldByName('email').AsString;
    //email := 'desarrollo@loginser.com';
    Free;
  end;

  cuerpo:=tstringlist.Create;
  cuerpo.Add('Estimado cliente:<br><br><br>');
  cuerpo.Add('En las próximas 48/72 horas recibirá en su oficina los artículos relacionados en la hoja adjunta.<br><br>');
  //cuerpo.Add('Recordamos la obligatoriedad de teclear en NOS la recepción de los regalos PUNTOS ILUSION en un máximo<br>');
  //cuerpo.Add('de 24h desde la entrega. Para cualquier duda contacte en el 902108957 o escriba al mail promocionesbankia@loginser.com<br><br>');
  cuerpo.Add('Para cualquier duda contacte en el 902108957 o escriba al mail promocionesbankia@loginser.com.<br><br>');
  cuerpo.Add('Dispone de 48 horas desde la recepción de su pedido para informar de cualquier tipo de incidencia al mail promocionesbankia@loginser.com.<br><br>');
  cuerpo.Add('Por favor, NO responda a este correo.<br><br>');
  cuerpo.Add('Un saludo<br><br><br>');
  cuerpo.Add('*Los artículos de PUNTOS ILUSION han de teclearse en NOS.');
  ///////////////////////
  f_envia_mail.Show;
  f_envia_mail.envia_email(email,pick_email,
      'Entrega Artículos Semanal '+formatdatetime('dd/mm/yyyy',date),
      filename,'',
      cuerpo,
      2);
  f_envia_mail.close;

  cuerpo.Free;
end;


procedure Tf_main.imprime_eti_bulto(codalbaran:integer);
const cr=Chr(13);
      lr=Chr(10);
var   codrepartidor,dst_coddel, aux:Integer;    pdf417,codigopostal,poblacion,ch_codbulto,cliente_chrono,producto_chrono,s, cli_nombre:string;
      lf:Char;
      graf1, graf2, graf3, graf4, graf5, graf6, graf7, cadena, temp_num_expedicion,iso_pais,car_envio,codigo_envio: string;
      fichero: TextFile;
      bulto,n_bultos:integer;      facility_dest,routing,routing_visible, license_plate,license_plate_visible, filename:string;     n_exp:integer;       fic:tstringlist;
      cp_regularizado,codigo_extra:string;
      codalbIMP:Integer;
begin
  car_envio:='';
  codigo_extra:='';
  dm.q_etiq_bulto.Close;
  //showmessage(dm.q_etiq_bulto.SelectSQL.Text);

//  if((dm.q_packagr.FieldByName('codalbeti').Asinteger<>0) and (dm.q_packagr.FieldByName('codrepartidor').Asinteger=46276)) then codalbaran:=dm.q_packagr.FieldByName('codalbeti').Asinteger;
  dm.q_etiq_bulto.SelectSQL.Text := 'select distinct b.*, l.id_pais, awb.awb '+
    'from a_packlin l '+
    'inner join a_packlin_bulto b on (l.codalbaran=b.codalbaran) '+
    'left join a_packlin_bulto_awb awb on awb.codalbaran=b.codalbaran '+
    'where l.id_packcab=:id_packcab and l.id_agrupa=:id_agrupa and l.nivel_agr=:nivel_agr and l.codalbaran=:codalbaran and b.enviado=''N''';
//    ' and b.fecha_alb between;

  dm.q_etiq_bulto.ParamByName('id_packcab').AsInteger:=id_packcab;
  dm.q_etiq_bulto.ParamByName('id_agrupa').AsInteger:=id_agrupa;
  dm.q_etiq_bulto.ParamByName('nivel_agr').AsInteger:=nivel_agr;
  dm.q_etiq_bulto.ParamByName('codalbaran').AsInteger:=codalbaran;
  dm.q_etiq_bulto.Open;

  if not dm.q_etiq_bulto.IsEmpty then
  begin

  dm.q_etiq_bulto.First;

  codrepartidor:=dm.q_etiq_bulto.FieldByName('cod_repartidor').AsInteger;
  poblacion:=dm.q_etiq_bulto.FieldByName('dst_localidad').AsString;
  codigopostal:=Trim(dm.q_etiq_bulto.FieldByName('dst_cp').AsString);
  dst_coddel:=dm.q_etiq_bulto.FieldByName('dst_coddel').asinteger;

  if codrepartidor=46172 then
  begin
    producto_chrono:= 'PAQ24';   //12/01/2016
    if ((StrToInt(codigopostal)>=7000) and (StrToInt(codigopostal)<=7999)) then begin
      producto_chrono:='BALEARES';
    end;

    if id_cliente=6702 then begin
      cliente_chrono:='519500001';
      if (((StrToInt(codigopostal)>=35000) and (StrToInt(codigopostal)<=35999)) or
          ((StrToInt(codigopostal)>=38000) and (StrToInt(codigopostal)<=38999))) then begin
        producto_chrono:='MARITIMO';
      end;
    end else begin
      cliente_chrono:='';
    end;
  end;


  //pais:=34;                                                  //envios a portugal
  if codigopostal = ''   then begin
    codigopostal:=get_cp_ext(poblacion);
    //pais:=351;
  end;

  cli_nombre := dm.q_etiq_bulto.fieldbyname('org_nombre').asstring;
  if dm.q_etiq_bulto.FieldByName('codcli').AsInteger = 6702 then begin   //just for life is short
    with tpfibdataset.Create(dm) do begin
      database:=dm.db;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select precinto from c_pedidos_lis where id_order=:codalbaran');
      ParamByName('codalbaran').asinteger:=codalbaran;
      Open;

      if (uppercase(fieldbyname('precinto').asstring) = 'NEUTRO') then begin
        cli_nombre := '';
      end;

      Free;
    end;

  end;

  dm.cds_bultos.Close;
  dm.cds_bultos.Active:=true;
  dm.cds_bultos.EmptyDataSet;

  while not(dm.q_etiq_bulto.Eof) do begin                  //etiqueta para cada bulto
    dm.cds_bultos.Insert;
    dm.cds_bultos.FieldByName('id_caja').AsInteger:=dm.q_etiq_bulto.FieldByName('id_caja').AsInteger;
    dm.cds_bultos.FieldByName('tipo_caja').asstring:=dm.q_etiq_bulto.FieldByName('tipo_caja').asstring;
    dm.cds_bultos.FieldByName('codcli').AsInteger:=dm.q_etiq_bulto.FieldByName('codcli').AsInteger;
    dm.cds_bultos.FieldByName('codalbaran').AsInteger:=codalbaran;
    dm.cds_bultos.FieldByName('codalbeti').AsInteger:=dm.q_etiq_bulto.FieldByName('codalbeti').AsInteger;
    dm.cds_bultos.FieldByName('unidades').AsInteger:=dm.q_etiq_bulto.FieldByName('paquetes').AsInteger;;
    dm.cds_bultos.FieldByName('fecha').AsDateTime:=dm.q_etiq_bulto.FieldByName('fecha_alb').AsDateTime;
    dm.cds_bultos.FieldByName('codruta').AsInteger:=dm.q_etiq_bulto.FieldByName('cod_ruta').AsInteger;
    dm.cds_bultos.FieldByName('coddst').AsString:=FormatFloat('0000',dm.q_etiq_bulto.FieldByName('dst_codcli').AsInteger)+formatfloat('0000',dm.q_etiq_bulto.FieldByName('dst_coddel').AsInteger);
    dm.cds_bultos.fieldbyname('dst_nombre').asstring:=dm.q_etiq_bulto.fieldbyname('dst_nombre').asstring;
    dm.cds_bultos.fieldbyname('dst_calle').asstring:=dm.q_etiq_bulto.fieldbyname('dst_calle').asstring;
    if TryStrToInt(codigopostal,aux) then
        dm.cds_bultos.fieldbyname('dst_cp').asstring:=FormatFloat('00000',StrToInt(codigopostal))
    else
        dm.cds_bultos.fieldbyname('dst_cp').asstring:=codigopostal;
    dm.cds_bultos.fieldbyname('dst_localidad').asstring:=dm.q_etiq_bulto.fieldbyname('dst_localidad').asstring;
    dm.cds_bultos.fieldbyname('dst_provincia').asstring:=dm.q_etiq_bulto.fieldbyname('dst_provincia').asstring;
    dm.cds_bultos.fieldbyname('dst_pais').asstring:=dm.q_etiq_bulto.fieldbyname('id_pais').asstring;
    dm.cds_bultos.FieldByName('bultos').AsInteger:=dm.q_etiq_bulto.fieldbyname('bultos').asinteger;
    dm.cds_bultos.FieldByName('observaciones').AsString:=dm.q_etiq_bulto.fieldbyname('observaciones').AsString;
    dm.cds_bultos.FieldByName('dst_tfno').AsString:=dm.q_etiq_bulto.FieldByName('dst_tfno').AsString;
    if codrepartidor=46172 then dm.cds_bultos.FieldByName('dst_coddel').AsString:=get_del_chrono(StrToInt(codigopostal))
      else dm.cds_bultos.FieldByName('dst_coddel').AsString:=dm.q_etiq_bulto.FieldByName('dst_coddel').AsString;
    dm.cds_bultos.FieldByName('dst_persona').AsString:=dm.q_etiq_bulto.FieldByName('dst_persona').AsString;
    dm.cds_bultos.FieldByName('ordenbulto').asinteger:=dm.q_etiq_bulto.FieldByName('n_bulto').Asinteger;
    dm.cds_bultos.FieldByName('codrepartidor').AsInteger:=codrepartidor;
    dm.cds_bultos.fieldbyname('org_nombre').asstring:= cli_nombre;
    dm.cds_bultos.fieldbyname('org_calle').asstring:= dm.q_etiq_bulto.fieldbyname('org_calle').asstring;
    dm.cds_bultos.fieldbyname('org_cp').asstring:= dm.q_etiq_bulto.fieldbyname('org_cp').asstring;
    dm.cds_bultos.fieldbyname('org_localidad').asstring:= dm.q_etiq_bulto.fieldbyname('org_localidad').asstring;
    dm.cds_bultos.fieldbyname('org_provincia').asstring:= dm.q_etiq_bulto.fieldbyname('org_provincia').asstring;
    dm.cds_bultos.FieldByName('org_tfno').AsString:= dm.q_etiq_bulto.FieldByName('org_tfno').AsString;
    dm.cds_bultos.FieldByName('reembolso').AsString:= dm.q_etiq_bulto.FieldByName('reembolso').AsString;
    dm.cds_bultos.FieldByName('referencia').AsString:= '';
    dm.cds_bultos.FieldByName('kgs').AsString:=dm.q_etiq_bulto.FieldByName('Kgs').AsString;
        //hector kilos
    if codrepartidor=46276 then
     begin
      dm.qry_kgs.close;
      dm.qry_kgs.SelectSQL.Text:='select pack.id_packcab,sum(pack.cantidad*art.kgs) as Total from  '+
                                 'a_packlin pack inner join g_articulos art on art.id_articulo=pack.id_articulo '+
                        //         'inner join a_packlin_bulto bul on bul.codalbaran=pack.codalbaran '+
                                 'where pack.estado=''A'' and pack.id_packcab='+inttostr(id_packcab)+' and pack.codalbaran='+inttostr(codalbaran)+'' +
                        //         ' and bul.n_bulto='+inttostr(dm.q_etiq_bulto.FieldByName('n_bulto').Asinteger)+'' +
                                 'group by id_packcab';
      dm.qry_kgs.Open;
      dm.cds_bultos.FieldByName('kgs').AsString:=formatfloat('0.00',math.max(dm.qry_kgs.FieldByName('Total').AsFloat,1));
      dm.cds_bultos.FieldByName('AWB').AsString:=dm.q_etiq_bulto.FieldByName('AWB').AsString;
     end;
    if id_cliente=6702 then begin
      dm.cds_bultos.FieldByName('sempor').AsString:='PAGADOS';
    end else begin
      if dm.q_etiq_bulto.FieldByName('pdebido').AsFloat <= 0 then
         dm.cds_bultos.FieldByName('sempor').AsString:='PAGADOS' else dm.cds_bultos.FieldByName('sempor').AsString:='DEBIDOS';
    end;

    ch_codbulto:='';
    if codrepartidor=46352 then begin    //mensytrans
      ch_codbulto:='9'+formatfloat('000000000',codalbaran)+formatfloat('0000',dm.q_etiq_bulto.FieldByName('n_bulto').Asinteger);
    end;
    if codrepartidor=46172 then begin    //chrono
      ch_codbulto:=dm.q_etiq_bulto.FieldByName('n_bulto_chrono').AsString;
      if id_cliente=6702 then begin
        dm.cds_bultos.FieldByName('chrono_exp').AsString:=get_chrono_exp(codalbaran,cliente_chrono);
        dm.cds_bultos.FieldByName('chrono_ref').AsString:=get_chrono_exp(codalbaran,cliente_chrono);
      end else begin
        dm.cds_bultos.FieldByName('chrono_exp').AsString:=IntToStr(codalbaran);
        dm.cds_bultos.FieldByName('chrono_ref').AsString:=IntToStr(codalbaran);
      end;
    end;

    if codrepartidor=46276 then begin          //DHL
       ch_codbulto:=dm.q_etiq_bulto.FieldByName('n_bulto_chrono').AsString; //este
       //dm.cds_bultos.FieldByName('chrono_exp').AsString:= ch_codbulto;
    end;

    dm.cds_bultos.FieldByName('codbulto').AsString:=ch_codbulto;


    if codrepartidor=46172 then                                                         //CHRONOEXPRESS
      pdf417:=
        FormatDateTime('dd-mm-aaaa',dm.cds_bultos.fieldbyname('fecha').AsDateTime) + cr +
        dm.cds_bultos.FieldByName('codcli').AsString + cr +
        dm.cds_bultos.fieldbyname('org_nombre').asstring + cr +
        dm.cds_bultos.fieldbyname('org_calle').asstring + cr +
        dm.cds_bultos.fieldbyname('org_cp').asstring + cr +
        dm.cds_bultos.fieldbyname('org_localidad').asstring + cr +
        dm.cds_bultos.FieldByName('org_tfno').AsString + cr +
        dm.cds_bultos.fieldbyname('dst_nombre').asstring + cr +
        dm.cds_bultos.fieldbyname('dst_calle').asstring + cr +
        codigopostal + cr +
        dm.cds_bultos.fieldbyname('dst_localidad').asstring + cr +
        dm.cds_bultos.FieldByName('dst_tfno').AsString + cr +
        dm.cds_bultos.fieldByName('dst_persona').AsString + cr +
        dm.cds_bultos.fieldbyname('codalbaran').Asstring + cr +
        ch_codbulto + cr +
        dm.cds_bultos.FieldByName('dst_coddel').AsString + cr +
        '46' + cr +// keytsy
        IntToStr(codalbaran)+ cr +
        dm.cds_bultos.FieldByName('Kgs').AsString + cr +
        dm.cds_bultos.FieldByName('ordenbulto').AsString + cr +
        dm.cds_bultos.FieldByName('bultos').AsString+ cr +
        'Pagados'+ cr +
        dm.cds_bultos.FieldByName('reembolso').AsString + cr +
        dm.cds_bultos.FieldByName('observaciones').AsString
    else                                                                                //ASM Y LGS
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

    if codrepartidor = 46360 then //Correos
    begin
       with tpfibdataset.Create(dm) do                            //Codigo Bulto y expedicion
        try
          database:=dm.db;

          SQLs.SelectSQL.Clear;
          SQLs.SelectSQL.Add('select BARCODE from CORREOS_BARCODE(:codalbaran, :dst_cp)');
          ParamByName('codalbaran').AsInteger:=codalbaran;
          ParamByName('dst_cp').asstring:=dm.q_etiq_bulto.FieldByName('dst_cp').asstring;
          Open;

          if not(IsEmpty) then begin
            dm.cds_bultos.FieldByName('codbulto').asstring:=FieldByName('barcode').asstring;
          end;

        finally
          free;
        end;
    end;

    with tpfibdataset.Create(dm) do                             //LOGO
    try
      database:=dm.db;

      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select logo_bul from g_clientes_logos where codcli=:codcli and dst_codcli=:dst_codcli');
      ParamByName('codcli').AsInteger:=dm.q_etiq_bulto.FieldByName('codcli').AsInteger;
      ParamByName('dst_codcli').AsInteger:=dm.q_etiq_bulto.FieldByName('dst_codcli').AsInteger;
      Open;

      if not(IsEmpty) then begin
        dm.cds_bultos.FieldByName('logo').AsBytes:=FieldByName('logo_bul').AsBytes;
      end else dm.cds_bultos.FieldByName('logo').AsBytes:=nil;
    finally
      free;
    end;

    dm.cds_bultos.Post;
    dm.q_etiq_bulto.Next;
  end;

  if codrepartidor=46172 then begin                                                     //etiqueta chrono
    dm.cds_bultos.First;
    while not(dm.cds_bultos.Eof) do begin
      lf:=chr(10);             //line feed
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

      WriteRawDataToPrinter(u_globals.imp_eti,s);

      dm.cds_bultos.Next;
    end;
  end else begin                                                                               //etiqueta mensytrans
    if codrepartidor=46352 then begin
      rep_mensy.PrintOptions.Printer:=u_globals.imp_eti;
      if rep_mensy.PrepareReport(True) then rep_mensy.print;
    end
    else
    begin
      if codrepartidor = 46360 then           //ETIQUETA CORREOS  PAQ 48/72
      begin
        graf1:=LeerHexa('correos.hex');
        graf2:=LeerHexa('paq72.hex');
        graf3:=LeerHexa('LOGINSER.hex');
        graf4:=LeerHexa('DOMICILIO.hex');
        graf5:=LeerHexa('paq48.hex');
        graf6:=LeerHexa('economico.hex');
        graf7:=LeerHexa('pagado.hex');
        //
        //                                  CORREOS          N O R M A L
        //
        dm.cds_bultos.First;
        while not(dm.cds_bultos.Eof) do
        begin
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
          //Writeln(fichero,'^FO700,390^XGR:PAQ72.GRF,1,1^FS');
          cadena:=cadena+'^FO700,390^XGR:PAQ48.GRF,1,1^FS'+cr+lr;
          //*********************************************************************************

          cadena:=cadena+'^FO640,540^XGR:LOGINSER.GRF,1,1^FS'+cr+lr;
          cadena:=cadena+'^FO320,940^XGR:DOMICILIO.GRF,2,2^FS'+cr+lr;

          cadena:=cadena+'^CI27'+cr+lr;; // Cambia el banco de caracteres a un banco con tildes y letras Ñ ñ

          cadena:=cadena+'^FO400,100 ^A0N,30,25^FDDestinatario         Remitente^FS'+cr+lr;   // Texto
          cadena:=cadena+'^FO678,140 ^ADR,18,10^FD'+dm.cds_bultos.fieldbyname('org_nombre').asstring+'^FS'+cr+lr;  // Remitente
          cadena:=cadena+'^FO656,140 ^ADR,18,10^FD'+dm.cds_bultos.fieldbyname('org_calle').asstring+'^FS'+cr+lr;
          cadena:=cadena+'^FO634,140 ^ADR,18,10^FD'+dm.cds_bultos.fieldbyname('org_cp').asstring+'-'+dm.cds_bultos.fieldbyname('org_localidad').asstring+'^FS'+cr+lr;   // CPOSTAL???
          cadena:=cadena+'^FO612,140 ^ADR,18,10^FD'+dm.cds_bultos.fieldbyname('org_provincia').asstring+'^FS'+cr+lr;

          cadena:=cadena+'^FO550,140 ^ADR,18,10^FD-----------------------------------------^FS';
          cadena:=cadena+'^FO495,140 ^ADR,18,10^FD'+dm.cds_bultos.fieldbyname('dst_nombre').asstring+'^FS'+cr+lr;            //Destinatario
          cadena:=cadena+'^FO473,140 ^ADR,18,10^FD'+dm.cds_bultos.fieldbyname('dst_calle').asstring+'^FS'+cr+lr;
          cadena:=cadena+'^FO451,140 ^ADR,24,18^FD'+dm.cds_bultos.fieldbyname('dst_cp').asstring+'-'+dm.cds_bultos.fieldbyname('dst_localidad').asstring+'^FS'+cr+lr;
          cadena:=cadena+'^FO429,140 ^ADR,24,18^FD'+dm.cds_bultos.fieldbyname('dst_provincia').asstring+'^FS'+cr+lr;
          cadena:=cadena+'^FO407,140 ^ADR,18,10^FDTeléfono:'+dm.cds_bultos.FieldByName('dst_tfno').AsString+'^FS'+cr+lr;
          cadena:=cadena+'^FO385,140 ^ADR,18,10^FDObservaciones^FS'+cr+lr;
          cadena:=cadena+'^FO363,140 ^ADR,18,10^FD'+dm.cds_bultos.FieldByName('observaciones').AsString+'^FS'+cr+lr;
          cadena:=cadena+'^FO340,140 ^ADR,18,10^FD-----------------------------------------^FS'+cr+lr;

          cadena:=cadena+'^FO300,130 ^A0R,30,25^FDCódigo bulto: '+dm.cds_bultos.FieldByName('codbulto').asstring+'^FS'+cr+lr;            // código de barras ser humano

          cadena:=cadena+'^FO780,770 ^A0R,30,25^FDExpedición: '+dm.cds_bultos.FieldByName('codexpedicion').asstring+'^FS'+cr+lr;            // expedición ser humano

          cadena:=cadena+'^FO310,720 ^ADN,20,12^FDValores^FS'+cr+lr;                        // Texto
          cadena:=cadena+'^FO310,740 ^ADN,20,12^FDAñadidos^FS'+cr+lr;                       // Texto
          cadena:=cadena+'^FO310,760 ^ADN,20,12^FD----------^FS'+cr+lr;                     // Texto

          cadena:=cadena+'^FO270,920 ^ADR,18,10^FDBulto:^FS'+cr+lr;                        //
          cadena:=cadena+'^FO248,920 ^ADR,18,10^FD'+dm.cds_bultos.FieldByName('ordenbulto').asstring+'^FS'+cr+lr;              //
          cadena:=cadena+'^FO216,920 ^ADR,18,10^FDPeso:^FS'+cr+lr;                    //
          cadena:=cadena+'^FO194,920 ^ADR,18,10^FD'+formatfloat('0.000',dm.cds_bultos.FieldByName('kgs').asfloat)+'Kgs.^FS'+cr+lr;   //

          cadena:=cadena+'^FWR'+cr+lr;
          cadena:=cadena+'^FO70,120'+cr+lr;
          cadena:=cadena+'^BY3'+cr+lr;
          cadena:=cadena+'^POA'+cr+lr;
          cadena:=cadena+'^BCR, 220, N, N, N, A^FD'+dm.cds_bultos.FieldByName('codbulto').asstring+'^FS'+cr+lr;                     // código de barras C128



          pdf417:='0000';                                                     // código etiquetador, 4
          pdf417:=pdf417+espacios(dm.cds_bultos.FieldByName('codbulto').asstring,23);      // Codigo envío, 23
          pdf417:=pdf417+Zeros(dm.cds_bultos.FieldByName('bultos').AsString,2);        // Número de bultos, 2
          pdf417:=pdf417+Zeros(dm.cds_bultos.FieldByName('ordenbulto').asstring,2);    // orden bulto,2
          pdf417:=pdf417+espacios(dm.cds_bultos.fieldbyname('dst_nombre').asstring,36);    // nombre destinatario, 36
          pdf417:=pdf417+espacios(' ',15);                                   // nif destinatario, 15
          pdf417:=pdf417+espacios(dm.cds_bultos.fieldbyname('dst_calle').asstring,72);     // dirección destinatario, 72
          pdf417:=pdf417+espacios(dm.cds_bultos.fieldbyname('dst_localidad').asstring,25); // localidad destinatario, 25
          pdf417:=pdf417+Zeros(dm.cds_bultos.fieldbyname('dst_cp').asstring,5);        // cp destinatario, 5
          pdf417:=pdf417+'00';                                                          // modo entrega 2
          pdf417:=pdf417+formatfloat('00.00',dm.cds_bultos.FieldByName('kgs').asfloat); // peso 5
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
          pdf417:=pdf417+espacios(dm.cds_bultos.fieldbyname('org_nombre').asstring,36);   //Nombre remitente 36
          pdf417:=pdf417+espacios(' ',15);                                                //Nif remitente
          pdf417:=pdf417+espacios(dm.cds_bultos.fieldbyname('org_calle').asstring,72);    // dirección remitente, 72
          pdf417:=pdf417+espacios(dm.cds_bultos.fieldbyname('org_localidad').asstring,25);// localidad remitente, 25
          pdf417:=pdf417+Zeros(dm.cds_bultos.fieldbyname('org_cp').asstring,5);           // cp remitente, 5
          pdf417:=pdf417+'000000';                                                        // apartado reembolso 6
          pdf417:=pdf417+'00000';                                                         // importe pagado 5
          pdf417:=Copy(pdf417,1,416);

          cadena:=cadena+'^FO590,735'+cr+lr;
          cadena:=cadena+'^BY3'+cr+lr;
          cadena:=cadena+'^B7R,7,5,,,N^FD'+pdf417+'^FS'+cr+lr;                 // código de barras 2D PDF417

          cadena:=cadena+'^XZ'+cr+lr;

          WriteRawDataToPrinter(u_globals.imp_eti,cadena);
          dm.cds_bultos.Next;
        end;

        //
        //                                  CORREOS          P A Q U E T E   E C O N O M I C O
        //

       { dm.cds_bultos.First;
        while not(dm.cds_bultos.Eof) do
        begin
          cadena:='~DGR:CORREOS.GRF,01980,9,'+graf1;        // Carga gráficos en memoria de impresora
          cadena:=cadena+'~DGR:PAQ72.GRF,0902,11,'+graf2+cr+lr;
          cadena:=cadena+'~DGR:LOGINSER.GRF,1700,10,'+graf3+cr+lr;
          cadena:=cadena+'~DGR:DOMICILIO.GRF,585,9,'+graf4+cr+lr;
          cadena:=cadena+'~DGR:PAQ48.GRF,0990,11,'+graf5+cr+lr;
          cadena:=cadena+'~DGR:ECO.GRF,0630,7,'+graf6+cr+lr;

          cadena:=cadena+'^XA^PW1000'+cr+lr;
          cadena:=cadena+'^FO720,120^XGR:CORREOS.GRF,1,1^FS'+cr+lr;  // Imprime gráficos LOGOS

          //**********************************************************************************
          //cadena:='^FO700,390^XGR:PAQ48.GRF,1,1^FS');
          //*********************************************************************************
          cadena:=cadena+'^FO740,610^XGR:ECO.GRF,1,1^FS'+cr+lr;
          //cadena:='^FO640,540^XGR:LOGINSER.GRF,1,1^FS');
          //cadena:='^FO320,940^XGR:DOMICILIO.GRF,2,2^FS');

          cadena:=cadena+'^CI27'+cr+lr; // Cambia el banco de caracteres a un banco con tildes y letras Ñ ñ

          cadena:=cadena+'^FO750,390 ^ADR,18,10^FDPaquete económico^FS'+cr+lr;
          cadena:=cadena+'^FO728,390 ^ADR,18,10^FD    Internacional^FS'+cr+lr;

          cadena:=cadena+'^FO640,730 ^ANR,15,7^FDEn caso de no entrega/In case of non delivery:^FS'+cr+lr;
          cadena:=cadena+'^FO618,730 ^ANR,15,7^FDDevolver al remitente/Return to sender:^FS'+cr+lr;

          cadena:=cadena+'^FO360,100 ^A0N,30,25^FDDestinatario/To         Remitente/From^FS'+cr+lr;   // Texto
          cadena:=cadena+'^FO678,140 ^ADR,18,10^FDWOLFNOIR^FS'+cr+lr;  // Remitente
          cadena:=cadena+'^FO656,140 ^ADR,18,10^FDPONIENTE 10 P.I. LA BASSA S 12^FS'+cr+lr;
          cadena:=cadena+'^FO634,140 ^ADR,18,10^FD46394 - RIBARROJA DEL TURIA^FS'+cr+lr;   // CPOSTAL???
          cadena:=cadena+'^FO612,140 ^ADR,18,10^FDVALENCIA                   ESPAÑA^FS'+cr+lr;
          cadena:=cadena+'^FO590,140 ^ADR,18,10^FDREF: WOLFNOIR11895^FS'+cr+lr;
          cadena:=cadena+'^FO550,140 ^ADR,18,10^FD-----------------------------------------^FS'+cr+lr;
          cadena:=cadena+'^FO495,140 ^ADR,18,10^FD'+dm.cds_bultos.fieldbyname('dst_nombre').asstring+'^FS'+cr+lr;            //Destinatario
          cadena:=cadena+'^FO473,140 ^ADR,18,10^FD'+dm.cds_bultos.fieldbyname('dst_calle').asstring+'^FS'+cr+lr;
          cadena:=cadena+'^FO451,140 ^ADR,24,18^FD'+dm.cds_bultos.fieldbyname('dst_cp').asstring+'-'+dm.cds_bultos.fieldbyname('dst_localidad').asstring+'^FS'+cr+lr;
          cadena:=cadena+'^FO429,140 ^ADR,24,18^FD'+dm.cds_bultos.fieldbyname('dst_provincia').asstring+'^FS'+cr+lr;
          cadena:=cadena+'^FO407,140 ^ADR,18,10^FDTlf/Phone:'+dm.cds_bultos.FieldByName('dst_tfno').AsString+'^FS'+cr+lr;
          cadena:=cadena+'^FO385,140 ^ADR,18,10^FDComentario/Comments^FS'+cr+lr;
          cadena:=cadena+'^FO363,140 ^ADR,18,10^FD'+dm.cds_bultos.FieldByName('observaciones').AsString+'^FS'+cr+lr;
          cadena:=cadena+'^FO340,140 ^ADR,18,10^FD-----------------------------------------^FS'+cr+lr;

          cadena:=cadena+'^FO300,130 ^A0R,30,25^FD'+dm.cds_bultos.FieldByName('codbulto').asstring+'^FS'+cr+lr;            // código de barras ser humano

          cadena:=cadena+'^FO300,820 ^ADR,18,10^FDPeso/Weight:^FS'+cr+lr;                    //
          cadena:=cadena+'^FO278,820 ^ADR,18,10^FD'+formatfloat('0.000',dm.cds_bultos.FieldByName('kgs').asfloat)+'Kgs.^FS'+cr+lr;   //

          cadena:=cadena+'^FWR'+cr+lr;
          cadena:=cadena+'^FO60,120'+cr+lr;
          cadena:=cadena+'^BY3'+cr+lr;
          cadena:=cadena+'^POA'+cr+lr;
          cadena:=cadena+'^BCR, 200, N, N, N, A^FD'+dm.cds_bultos.FieldByName('codbulto').asstring+'^FS'+cr+lr;                     // código de barras C128

          cadena:=cadena+'^XZ'+cr+lr;

          WriteRawDataToPrinter(u_globals.imp_eti,cadena);

          dm.cds_bultos.Next;
        end;              }

        //
        //                                  CORREOS          I N T E R N A C I O N A L
        //

       { dm.cds_bultos.First;
        while not(dm.cds_bultos.Eof) do
        begin
          cadena:='~DGR:CORREOS.GRF,01980,9,'+graf1;        // Carga gráficos en memoria de impresora
          cadena:=cadena+'~DGR:PAQ72.GRF,0902,11,'+graf2+cr+lr;
          cadena:=cadena+'~DGR:LOGINSER.GRF,1700,10,'+graf3+cr+lr;
          cadena:=cadena+'~DGR:DOMICILIO.GRF,585,9,'+graf4+cr+lr;
          cadena:=cadena+'~DGR:PAQ48.GRF,0990,11,'+graf5+cr+lr;
          cadena:=cadena+'~DGR:ECO.GRF,0630,7,'+graf6+cr+lr;
          cadena:=cadena+'~DGR:PAGADO.GRF,15296,32,'+graf7+cr+lr;

          cadena:=cadena+'^XA^PW1000'+cr+lr;
          cadena:=cadena+'^FO520,650^XGR:PAGADO.GRF,1,1^FS'+cr+lr;

          cadena:=cadena+'^CI27'+cr+lr; // Cambia el banco de caracteres a un banco con tildes y letras Ñ ñ

          cadena:=cadena+'^FO700,130 ^ASR,18,12^FDRetour To:^FS'+cr+lr;  // Remitente
          cadena:=cadena+'^FO660,130 ^ASR,18,12^FDWOLFNOIR^FS'+cr+lr;
          cadena:=cadena+'^FO630,130 ^ARR,18,12^FDPONIENTE 10 P.I. LA BASSA S 12^FS'+cr+lr;
          cadena:=cadena+'^FO600,130 ^ARR,18,12^FD46394 - RIBARROJA DEL TURIA-SPAIN^FS'+cr+lr;   // CPOSTAL???

          cadena:=cadena+'^FO460,130 ^ARR,18,18^FDRef WOLFNOIR12660^FS'+cr+lr;  // OOOJJJJJOOOOO FALTA LA REFERENCIA

          cadena:=cadena+'^FO250,130 ^ASR,18,18^FD'+dm.cds_bultos.fieldbyname('dst_nombre').asstring+'^FS'+cr+lr;            //Destinatario
          cadena:=cadena+'^FO215,130 ^ASR,18,18^FD'+dm.cds_bultos.fieldbyname('dst_calle').asstring+'^FS'+cr+lr;
          cadena:=cadena+'^FO180,130 ^ASR,18,18^FD'+dm.cds_bultos.fieldbyname('dst_cp').asstring+'-'+dm.cds_bultos.fieldbyname('dst_localidad').asstring+'^FS'+cr+lr;
          cadena:=cadena+'^FO135,130 ^ATR,18,18^FD'+dm.cds_bultos.fieldbyname('dst_provincia').asstring+'^FS'+cr+lr;

          cadena:=cadena+'^FO310,130 ^ATR,30,25^FD'+dm.cds_bultos.FieldByName('codbulto').asstring+'^FS'+cr+lr;            // código de barras ser humano

          cadena:=cadena+'^FWR'+cr+lr;
          cadena:=cadena+'^FO360,130'+cr+lr;
          cadena:=cadena+'^BY3'+cr+lr;
          cadena:=cadena+'^POA'+cr+lr;
          cadena:=cadena+'^BCR, 90, N, N, N, A^FD'+dm.cds_bultos.FieldByName('codbulto').asstring+'^FS'+cr+lr;                     // código de barras C128

          cadena:=cadena+'^XZ'+cr+lr;

          WriteRawDataToPrinter(u_globals.imp_eti,cadena);

          dm.cds_bultos.Next;
        end;  }
      end else begin                                                                               //etiqueta DHL
        if codrepartidor=46276 then begin
            //graf7:=LeerHexa('pagado.hex');
            {dm.qrytemp.SQL.Text:='select * from albaranes where codalbaran=:codalbaran';
            dm.qrytemp.Parameters.ParamByName('codalbaran').Value:=albaran;
            dm.qrytemp.Open;}
            if((dm.cds_bultos.fieldbyname('dst_pais').asstring='ES') AND (Length(dm.cds_bultos.fieldbyname('dst_cp').AsString)<5)) then
             cp_regularizado:='0'+dm.cds_bultos.fieldbyname('dst_cp').asString
            else if((dm.cds_bultos.fieldbyname('dst_pais').asstring='ES') AND (Length(dm.cds_bultos.fieldbyname('dst_cp').AsString)=5) and (pos('0',dm.cds_bultos.fieldbyname('dst_cp').asString)=1)) then
                  cp_regularizado:=dm.cds_bultos.fieldbyname('dst_cp').asString
                 else if(pos('0',dm.cds_bultos.fieldbyname('dst_cp').asString)=1) then
                       cp_regularizado:=RightStr(dm.cds_bultos.fieldbyname('dst_cp').asString,4)
                       else cp_regularizado:=dm.cds_bultos.fieldbyname('dst_cp').asString;
            if((dm.cds_bultos.fieldbyname('dst_pais').asstring='ES') AND (dm.cds_bultos.fieldbyname('dst_cp').AsString='AD500')) then
             cp_regularizado:='25999';

            dm.qdhl.Close;
            dm.qdhl.SelectSQl.Clear;
            dm.qdhl.SelectSQL.Add('select * from C_DHL_MDISP where pais_origen=''ES'' and service_area_origen=''VLC'' and '+
              ' cp_destino=:cp and pais_destino=:pais');

            if((pos('0',cp_regularizado)=1) and (dm.cds_bultos.fieldbyname('dst_pais').asstring='ES'))  then
             dm.qdhl.ParamByName('cp').asString:= RightStr(cp_regularizado,4)
            else dm.qdhl.ParamByName('cp').asString:= cp_regularizado;

            if((dm.cds_bultos.fieldbyname('dst_pais').asstring='ES') AND (dm.cds_bultos.fieldbyname('dst_cp').AsString='AD500')) then     //Andorra
               dm.qdhl.ParamByName('cp').asstring:='25999';

             dm.qdhl.ParamByName('pais').asstring:= dm.cds_bultos.fieldbyname('dst_pais').asstring;
            dm.qdhl.Open;
            dm.qdhl.First;
            iso_pais:=dm.qdhl.FieldByName('pais_destino').asstring;
            facility_dest:=dm.qdhl.FieldByName('facility_destino').asstring;
            dm.q_DHL_PAISES.Close;
            dm.q_DHL_PAISES.SelectSQl.Clear;
            dm.q_DHL_PAISES.SelectSQL.Add('select * from C_DHL_PAISES where PAIS='+QUOTEDSTR(ISO_PAIS));
            dm.q_DHL_PAISES.Open;
            dm.q_DHL_PAISES.First;
             if( not dm.q_DHL_PAISES.Eof) then codigo_envio:=dm.q_DHL_PAISES.FieldByName('cod_product').asstring
             else codigo_envio:='40';

            //routing:='2L' + dm.cds_bultos.fieldbyname('dst_pais').asstring + rightstr(stringofchar('0',5)+dm.cds_bultos.fieldbyname('dst_cp').asstring,5)+'+80000000';
            //routing_visible:='(2L)' + dm.cds_bultos.fieldbyname('dst_pais').asstring + rightstr(stringofchar('0',5)+dm.cds_bultos.fieldbyname('dst_cp').asstring,5)+'+80000000';

            //routing:='2L' + dm.cds_bultos.fieldbyname('dst_pais').asstring + rightstr(stringofchar('0',5)+dm.cds_bultos.fieldbyname('dst_cp').asstring,5)+'+'+codigo_envio+'000'+'000';
            //routing_visible:='(2L)' + dm.cds_bultos.fieldbyname('dst_pais').asstring + rightstr(stringofchar('0',5)+dm.cds_bultos.fieldbyname('dst_cp').asstring,5)+'+'+codigo_envio+'000'+ '000';

            if(dm.cds_bultos.FieldByName('reembolso').AsFloat>0) then  //si tiene reembolso, codigo 002
             codigo_extra:='002'
            else codigo_extra:='000';

            routing:='2L' + dm.cds_bultos.fieldbyname('dst_pais').asstring + cp_regularizado+'+'+codigo_envio+'000'+codigo_extra;
            routing_visible:='(2L)' + dm.cds_bultos.fieldbyname('dst_pais').asstring + cp_regularizado+'+'+codigo_envio+'000'+ codigo_extra;

            dm.cds_bultos.First;
            while not(dm.cds_bultos.Eof) do begin
              temp_num_expedicion:=RightStr(stringofchar('0',8)+dm.cds_bultos.fieldbyname('codbulto').asstring,8);
              license_plate:='JJD0000646'+rightstr(formatdatetime('dd/mm/yyyy',Now),1)+
                RightStr(stringofchar('0',8)+dm.cds_bultos.fieldbyname('codbulto').asstring,8)+'0'+RightStr(stringofchar('0',3)+dm.cds_bultos.fieldbyname('ordenbulto').asstring,3);
              //license_plate_visible:='(J)JD00 00 646'+rightstr(formatdatetime('dd/mm/yyyy',Now),1)+ ' '+
              // Copy(temp_num_expedicion,0,4) +' '+ Copy(temp_num_expedicion,3,4) +'0'+RightStr(stringofchar('0',3)+dm.cds_bultos.fieldbyname('ordenbulto').asstring,3);
              license_plate_visible:='(J)JD00 00 646'+rightstr(formatdatetime('dd/mm/yyyy',Now),1)+ ' '+
              // Copy(temp_num_expedicion,0,4) +''+ Copy(temp_num_expedicion,3,4) +'0'+RightStr(stringofchar('0',3)+dm.cds_bultos.fieldbyname('ordenbulto').asstring,3);
              Copy(temp_num_expedicion,0,4) +' '+ Copy(temp_num_expedicion,5,4) +' 0'+RightStr(stringofchar('0',3)+dm.cds_bultos.fieldbyname('ordenbulto').asstring,3);

              lf:=chr(10);
              s:='';
              s:=s+'I8,A,034'+lf;
              s:=s+'Q1199,024'+lf;
              s:=s+'q831'+lf;
              s:=s+'rN'+lf;
              s:=s+'S8'+lf;
              s:=s+'D12'+lf;
              s:=s+'ZB'+lf;
              s:=s+'JF'+lf;
              s:=s+'OD'+lf;
              s:=s+'R16,10'+lf;
              s:=s+'N'+lf;
              s:=s+'FE'+lf;
              s:=s+'GG530,20,"DHLX"'+lf;
              s:=s+'GG530,95,"CLIENTE3"'+lf;
              s:=s+'LO000,080,800,1'+lf;
              s:=s+'LO000,185,800,1'+lf;
              s:=s+'LO000,340,800,1'+lf;
              s:=s+'LO000,400,800,1'+lf;
              s:=s+'LO000,480,800,1'+lf;
              s:=s+'LO000,590,800,1'+lf;
              s:=s+'LO005,185,35,8'+lf;
              s:=s+'LO770,185,35,8'+lf;
              s:=s+'LO005,325,35,8'+lf;
              s:=s+'LO770,325,35,8'+lf;
              s:=s+'LE005,185,8,40'+lf;
              s:=s+'LE800,185,8,40'+lf;
              s:=s+'LE005,295,8,40'+lf;
              s:=s+'LE800,295,8,40'+lf;
              s:=s+'A030,95,0,2,1,1,N,"From:"'+lf;
              s:=s+'A030,200,0,2,1,2,N,"To:"'+lf;
              s:=s+'A010,560,0,2,1,1,N,"Shipment ID:"'+lf;
              s:=s+'A010,495,0,2,1,1,N,"Account No:"'+lf;
              s:=s+'A010,530,0,2,1,1,N,"Ref code:"'+lf;
              s:=s+'A650,415,0,2,1,1,N,"Day"'+lf;
              s:=s+'A750,415,0,2,1,1,N,"Time"'+lf;
              s:=s+'A720,495,0,2,1,1,N,"Piece"'+lf;
              //450
              s:=s+'A450,495,0,2,1,1,N,"Weight"'+lf;
              s:=s+'A688,268,0,2,1,1,N,"Phone no:"'+lf;
              s:=s+'A730,090,0,2,1,1,N,"Origin:"'+lf;
              s:=s+'A020,600,0,2,1,1,N,"Content:"'+lf;
              s:=s+'A020,620,0,2,1,1,N,"Remarks:"'+lf;
              s:=s+'A120,600,0,2,1,1,N,""'+lf;        //contenido                 31
              s:=s+'A120,620,0,2,1,1,N,"'+leftstr(dm.cds_bultos.FieldByName('observaciones').asstring,40)+'"'+lf;  //observaciones 1      34
              s:=s+'A120,640,0,2,1,1,N,""'+lf;                //observaciones 2       35
              s:=s+'A730,110,0,2,1,1,N,"VLC"'+lf;       //delegacion origen             30
              s:=s+'A450,570,0,2,1,1,N,"'+formatdatetime('dd/mm/yyyy',dm.cds_bultos.FieldByName('fecha').asdatetime)+'"'+lf;    //fecha salida                29
              //s:=s+'A750,450,0,2,1,1,N,"'+formatdatetime('HH:NN',dm.cds_bultos.FieldByName('fecha').asdatetime)+'"'+lf;
              if(dm.cds_bultos.FieldByName('kgs').asstring='0') then
               s:=s+'A450,525,0,3,1,2,N,"'+floattostr(1*dm.cds_bultos.FieldByName('bultos').asFloat)+' KG"'+lf       //peso default
              else //s:=s+'A450,525,0,3,1,2,N,"'+dm.cds_bultos.FieldByName('kgs').asstring+'KG"'+lf;       //peso total del albaran
                   s:=s+'A450,525,0,3,1,2,N,"1 KG"'+lf;       //peso                            28
//              if ((dm.cds_bultos.FieldByName('dst_pais').asstring='ES') or (dm.cds_bultos.FieldByName('dst_pais').asstring='PT')) then
//                  s:=s+'A100,020,0,4,1,2,N,"DOM ECONOMY SELECT"'+lf    //dom economy select      26
//              else begin
//                     s:=s+'A005,010,0,5,1,1,N,"CMR"'+lf;
//                     s:=s+'A150,020,0,4,1,2,N,"ECONOMY SELECT"'+lf;    //economy select  int    26
//              end;


//Isabel. A traves de codigo. Lo he sacado a C_DHL_PAISES por si cambian cosas asi no tocamos el ejecutable

             dm.qry_tmp.Close;
             dm.qry_tmp.SelectSQL.Clear;
             dm.qry_tmp.SelectSQL.Text:='select cab_product,cab_product2 from c_dhl_paises where pais='+quotedstr(dm.cds_bultos.FieldByName('dst_pais').asstring);
             dm.qry_tmp.Open;
             dm.qry_tmp.First;
             if(not dm.qry_tmp.eof) then
              begin
              //150
               s:=s+'A175,020,0,4,1,2,N,"'+dm.qry_tmp.FieldByName('CAB_PRODUCT').asString+'"'+lf;
               s:=s+'A475,020,0,4,1,2,N,"'+dm.qry_tmp.fieldbyname('CAB_PRODUCT2').asstring+'"'+lf;
               if not ((dm.cds_bultos.FieldByName('dst_pais').asstring='ES') or (dm.cds_bultos.FieldByName('dst_pais').asstring='PT')) then
                begin
                 s:=s+'A005,020,0,4,2,1,N,"CMR"'+lf;
                 //if(dm.cds_bultos.FieldByName('ADUANA').asstring='1') then //no existe el campo aduana en el cds, utilizo la tabla de bbdd
                 if(esAduanero(dm.cds_bultos.FieldByName('dst_pais').asstring)) then
                  car_envio:=car_envio+'C';
                 if(dm.cds_bultos.FieldByName('REEMBOLSO').AsFloat>0) then
                 if(car_envio='') then car_envio:=car_envio+'COD'
                 else car_envio:=car_envio+'-COD';
                 if((car_envio<>'') and (pos(car_envio,'COD')>0)) then  s:=s+'A005,420,0,4,2,1,R,"'+car_envio+'"'+lf
                  else if (car_envio<>'') then s:=s+'A005,420,0,4,2,1,R,"'+car_envio+'"'+lf;
                end
               else if ((dm.cds_bultos.FieldByName('dst_pais').asstring='ES') or (dm.cds_bultos.FieldByName('dst_pais').asstring='PT')) then
                        begin
                        if(esAduanero(dm.cds_bultos.FieldByName('dst_pais').asstring)) then
                        car_envio:=car_envio+'C';
                        if(dm.cds_bultos.FieldByName('REEMBOLSO').AsFloat>0) then
                         if(car_envio='') then car_envio:=car_envio+'COD'
                         else car_envio:=car_envio+'-COD';
                        if((car_envio<>'') and (pos(car_envio,'COD')>0)) then  s:=s+'A005,420,0,4,2,2,R,"'+car_envio+'"'+lf
                           else if (car_envio<>'') then s:=s+'A005,420,0,4,2,2,R,"'+car_envio+'"'+lf;
                        end;
             end
             else  s:=s+'A450,015,0,4,1,2,N,"ESU"'+lf;       //esu
//              if ((dm.cds_bultos.FieldByName('dst_pais').asstring='ES') or (dm.cds_bultos.FieldByName('dst_pais').asstring='PT')) then
//                  s:=s+'A418,015,0,5,1,1,N,"DES"'+lf;       //des                                   27
//              else if ((dm.cds_bultos.FieldByName('dst_pais').asstring='CH') or (dm.cds_bultos.FieldByName('dst_pais').asstring='JE') or
//                       (dm.cds_bultos.FieldByName('dst_pais').asstring='NO') or (dm.cds_bultos.FieldByName('dst_pais').asstring='RU') or
//                       (dm.cds_bultos.FieldByName('dst_pais').asstring='SM') or (dm.cds_bultos.FieldByName('dst_pais').asstring='TR')) then
//                          s:=s+'A418,015,0,5,1,1,N,"ESI"'+lf       //esi
//                    else
//                          s:=s+'A418,015,0,5,1,1,N,"ESU"'+lf;       //esu
//   version previa hector. Hacia las queries por separado.
//              with dm.qry_tmp do
//               begin
//                Close;
//                SelectSQL.Clear;
//                SelectSQL.Text:='select * from c_dhl_paises where pais='+quotedstr(dm.cds_bultos.FieldByName('dst_pais').asstring);
//                Open;
//                 if(not Eof) then
//                  s:=s+'A418,015,0,5,1,1,N,"'+dm.qry_tmp.fieldbyname('cab_product2').asstring+'"'+lf
//                 else  s:=s+'A418,015,0,5,1,1,N,"ESU"'+lf;       //esu
//               end;
              s:=s+'A666,015,0,5,1,1,N,"DHL"'+lf; //DHL   Escribe texto,  GG son gráficos pero no se como cargar la imagen en data
              //s:=s+'GG666,015,GRAF7'+LF;
//              s:=s+'GW666,015,0.139,31,000000000000000000000000000000'+
//              '000000000000000000000000000000000000000000000000000000'+
//              '001111111111001111001110011100000000000000001110011100'+
//              '111101111011110000000000000001111011110111111111011110'+
//              '000000000000000111101110011000111001111000000000111110'+
//              '111111110011100111101111111101111111110111111100011110'+
//              '111100011111100111110000000000000000000000000000000000000000'+lf;
              //s:=s+'A418,015,0,5,1,1,N,"ESU"'+lf;
              s:=s+'A418,015,0,5,1,1,R,""'+lf;        //esu/esi                                   32
              //060
              s:=s+'A250,0897,0,2,1,1,N,"'+routing_visible+'"'+lf;  //Routing barcode etiqueta       22
              s:=s+'A250,1156,0,2,1,1,N,"'+license_plate_visible+'"'+lf;   //license plate barcode etiqueta   24
              s:=s+'A100,90,0,2,1,1,N,"'+leftstr(dm.cds_bultos.FieldByName('org_nombre').asstring,40)+'"'+lf;          //remitente      08
              s:=s+'A100,115,0,2,1,1,N,"'+leftstr(dm.cds_bultos.FieldByName('org_calle').asstring,40)+'"'+lf;    //domicilio remitente    19
              s:=s+'A100,165,0,2,1,1,N,"Spain"'+lf;   //Pais Remitente                   17
              s:=s+'A100,140,0,2,1,1,N,"'+leftstr(dm.cds_bultos.FieldByName('org_cp').asstring,5)+'"'+lf;    //CP Remitente                      18
              s:=s+'A250,140,0,2,1,1,N,"'+leftstr(dm.cds_bultos.FieldByName('org_localidad').asstring,20)+'"'+lf;  //poblacion remitente     20
              s:=s+'A070,200,0,4,1,1,N,"'+leftstr(dm.cds_bultos.FieldByName('dst_nombre').asstring,40)+'"'+lf;       //Destinatario                  00
              s:=s+'A070,230,0,4,1,1,N,"'+leftstr(dm.cds_bultos.FieldByName('dst_calle').asstring,40)+'"'+lf;      //domic entrega         02
              s:=s+'A070,300,0,3,1,2,N,"'+GetPaisNombre(dm.cds_bultos.FieldByName('dst_pais').asstring)+'"'+lf;  //pais destino                       11
              //s:=s+'A070,260,0,3,1,2,N,"'+leftstr(dm.cds_bultos.FieldByName('dst_cp').asstring,5)+'"'+lf;  //CP Destino                           04
              //s:=s+'A070,260,0,3,1,2,N,"'+leftstr(cp_regularizado,5)+'"'+lf;  //CP Destino
              s:=s+'A070,260,0,3,1,2,N,"'+cp_regularizado+'"'+lf;  //CP Destino
              s:=s+'A200,260,0,3,1,2,N,"'+leftstr(dm.cds_bultos.FieldByName('dst_localidad').asstring,20)+'"'+lf;   //poblacion destino                  03
              //s:=s+'A666,290,0,3,1,1,N,"'+leftstr(StringReplace(dm.cds_bultos.FieldByName('dst_tfno').asstring, ' ', '', [rfReplaceAll]),9)+'"'+lf;  //Tel Destino                         01
              if((iso_pais='ES') OR (iso_pais='PT')) then
                s:=s+'A200,351,0,3,1,2,N,"'+facility_dest+'"'+lf  //facility                          05
              else s:=s+'A200,351,0,3,3,2,N,"'+iso_pais+'-'+facility_dest+'"'+lf;  //facility                          05
              s:=s+'A020,360,0,3,2,2,N,""'+lf;   //codigo facility                             14
              s:=s+'A700,360,0,3,2,2,N,""'+lf;  //canarias                                         10  'C.O.D.' en caso de tener reembolso
              s:=s+'A020,415,0,3,2,3,R,""'+lf;  //reembolso                                         09
              s:=s+'A640,440,0,3,1,2,N,""'+lf;  //day definite                                         15
              s:=s+'A750,440,0,3,1,2,N,""'+lf;  //time definite                                          16
              if(dm.cds_bultos.fieldbyname('codalbeti').AsInteger=0) then
                codalbimp:=dm.cds_bultos.fieldbyname('codalbaran').AsInteger
              else codalbimp:=dm.cds_bultos.fieldbyname('codalbeti').AsInteger;
              s:=s+'A120,525,0,3,1,1,N,"'+inttostr(codalbimp)+'"'+lf;  //referencia remitente                               12
              // s:=s+'A120,525,0,3,1,1,N,"'+dm.cds_bultos.fieldbyname('codalbaran').asstring+'"'+lf;  //referencia remitente                               12
              //s:=s+'A160,495,0,3,1,1,N,"46-007641"'+lf;   //cuenta cliente  13

             //el numero de cliente va a variar según el remitente del envío y nos lo tiene que proporcionar DHL
              s:=s+'A160,495,0,3,1,1,N,"46-007641"'+lf;   //cuenta cliente  13
              //ese  46 que estamos metiendo a pelo, viene de el rango facilitado por DHL. Una vez se tenga y use bien el rango, o quitamos ese 46 o no va a ir bien
              if((iso_pais='ES') or (iso_pais='PT')) then
                s:=s+'A160,550,0,2,1,2,N,"46'+RightStr(stringofchar('0',7)+dm.cds_bultos.fieldbyname('codbulto').asstring,7)+'0"'+lf //expedicion                                06
              else
                s:=s+'A160,550,0,2,1,2,N,"'+dm.cds_bultos.fieldbyname('awb').asstring+'"'+lf;
              s:=s+'A690,520,0,4,1,2,N,"'+dm.cds_bultos.fieldbyname('ordenbulto').asstring+'"'+lf;  //bulto relativo                                      33
              s:=s+'A740,520,0,4,1,2,N,"/"'+lf;
              //18/12/4 comentado para probar etiqueta sin numero total de bultos
              //s:=s+'A760,520,0,4,1,2,N,"'+dm.cds_bultos.fieldbyname('bultos').asstring+'"'+lf;  //total bultos de la expedicion                                 07
              s:=s+'A760,520,0,4,1,2,N,"X"'+lf;  //total bultos de la expedicion
              s:=s+'GG003,10,""'+lf;   //cmr                                                               25
              s:=s+'B060,660,0,1,3,8,230,N,"'+routing+'"'+lf;  //routing barcode                      21
              s:=s+'B060,917,0,1,3,8,230,N,"'+license_plate+'"'+lf;          //license plate barcode      23
              s:=s+'P1'+lf;
              s:=s+''+lf;
              s:=s+''+lf;
              s:=s+''+lf;
              s:=s+'JF'+lf;
              s:=s+''+lf;
              WriteRawDataToPrinter(u_globals.imp_eti,s);
              dm.cds_bultos.Next;
            end;
        end
        else
        begin
          rep_log.PrintOptions.Printer:=u_globals.imp_eti;
          if rep_log.PrepareReport(True) then rep_log.print;
        end;
      end;
  end;
end;
end;
end;

function Tf_main.get_cp_ext(poblacion:string):string;
var
 fin:Boolean;
 s:string;
 t:char;
 n:Integer;
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

function tf_main.get_del_chrono(codigopostal: integer):string;
begin
  with tpfibdataset.Create(self) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select plaza from g_plazas_chrono where codpos=:codigopostal');
    ParamByName('codigopostal').asinteger:=codigopostal;
    Open;

    First;
    if not(IsEmpty) then Result:=FieldByName('plaza').asstring
    else result:='';

    Free;
  end;
end;


function Tf_main.Zeros(c: string; l: Integer): string;
var i: Integer;
begin
  c:=Trim(c);
  l:=l-Length(c);
  for i := 1 to l do c:='0'+c;

  Result := c;
end;

function Tf_main.Espacios(cadena: string; l: Integer): string;
var longitud: Integer;
begin
 { cadena:=Trim(cadena);
  longitud:=Length(cadena);
  if longitud<l then
  begin
    cadena:=cadena+System.StrUtils.DupeString(' ', (l-longitud));
  end;
  cadena:=Copy(cadena,1,l); }

end;


function Tf_main.codigoProducto(Pais: string):string;
begin
 with dm.qry_tmp do
  begin
   Close;
   SelectSQL.Clear;
   SelectSQL.Text:=' select * from c_dhl_paises where pais='+quotedstr(pais);
   Open;
   if(not Eof) then
    Result:=FieldByName('cod_product2').AsString
   else result:='110';
  end;
end;

procedure Tf_main.edInputKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=13 then
  begin

  end;
end;

procedure Tf_main.ed_cbKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=13 then lectura;
end;

procedure Tf_main.lectura;
var s:string;   id_articulo:integer;
begin
  s:=ed_cb.text;
  bcInUse := ed_cb.text;
  ed_cb.text:='';
  id_articulo:=procesa_cb(s);

  if revisa_lotes then
  begin
    if ArticuloBloqueado(id_articulo) then
    begin
      sShowMessage('Artículo Bloqueado','Consulte con el responsable.');
      Exit
    end;
  end;

  if id_articulo<>-1 then ejecuta_lectura(id_articulo,s,-1,cb_one_read_marks_all.Checked);
  ed_cb.SetFocus;
end;

function Tf_main.esAduanero(Pais: string):Boolean;
begin
 with dm.qry_tmp do
  begin
  Close;
  SelectSQL.Clear;
  SelectSQL.Text:=' select * from c_dhl_paises where pais='+pais;
  if(not Eof) then
    Result:=FieldByName('aduana').AsString='1'
  else result:=False;
  end;
end;

function  Tf_main.SoloNumeros(Texto : String) : String;
var
palabra : String;
i, k : integer;
begin
k := Length(Texto);
for i := 1 to k do
if Texto[i] in ['0'..'9']
 then palabra := palabra + Texto[i]
else Break;
Result := palabra;
end;

function Tf_main.GetPaisNombre(codigo:string):string;
begin
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select * from g_paises where estado=''A'' and codigo=:codigo ');
    ParamByName('codigo').AsString := codigo;
    Open;

    result:=FieldByName('nombre').AsString;

    Free;
  end;
end;

function Tf_main.LeerHexa(fichero: string) : string;
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

function Tf_main.procesa_cb(bc:string):integer;
var i,j:integer;
  enc: Boolean;
begin
  with tpfibdataset.create(Self) do begin                  //Buscar EAN
    Database:=dm.db;
    sqls.SelectSQL.Add('select a.id_articulo, a.nombre,a.codigo '+
      'from g_articulos_bc b '+
      'inner join g_articulos a on (b.id_articulo=a.id_articulo) '+
      'where b.bc=:bc and b.estado=''A'' order by 3');
    ParamByName('bc').AsString:=bc;
    Open;

    if isempty then begin
      gb_asig.Visible:=false;
      gb_error.Visible:=true;
      bt_add.Visible:=true;
      lb_ean.Caption:=bc;        //EAN not found
      lb_st.Caption:='ERROR !!  EAN NO ENCONTRADO';
      if FileExists(ruta_exe+'Audio\Error.wav') then sndPlaySound(PChar(ruta_exe+'Audio\Error.wav'),SND_NODEFAULT Or SND_ASYNC);
      Result:=-1;
    end else begin
      first;
      i:=0;
      while not(eof) do begin
        inc(i);
        next;
      end;

      if i>1 then begin                                 //EAN en mas de un articulo
        dm.q_fib.Close;
        dm.q_fib.SelectSQL.Clear;
        dm.q_fib.SelectSQL.Add('select a.id_articulo '+
          'from g_articulos_bc b '+
          'inner join g_articulos a on (b.id_articulo=a.id_articulo) '+
          'where b.bc=:bc and a.id_cliente=:id_cliente and b.estado=''A'' ');
        dm.q_fib.ParamByName('bc').AsString:=bc;
        if StrToInt(cl_padres[0])<0 then
             dm.q_fib.ParamByName('id_cliente').Asinteger:=id_cliente
        else begin
              while (not enc) and (j<=High(cl_padres)) do
              begin
                dm.q_fib.ParamByName('id_cliente').Asinteger := StrtoInt(cl_padres[j]);
                dm.q_fib.Open;
                enc := not dm.q_fib.IsEmpty;
                if not enc then
                  dm.q_fib.Close;
                Inc(j);
              end;
        end;
        dm.q_fib.Open;

        first;
        j:=0;
        while not(eof) do begin
          inc(j);
          next;
        end;

        if j=1 then result:=dm.q_fib.FieldByName('id_articulo').AsInteger        //EAN duplicado pero unico para el cliente
        else begin
          gb_asig.Visible:=false;
          gb_error.Visible:=true;
          bt_add.Visible:=true;
          lb_ean.Caption:=bc;        //EAN doble
          lb_st.Caption:='ERROR !!  EAN DUPLICADO EN MÁS DE UN ARTÍCULO';
          if FileExists(ruta_exe+'Audio\Error.wav') then sndPlaySound(PChar(ruta_exe+'Audio\Error.wav'),SND_NODEFAULT Or SND_ASYNC);
          Result:=-1;
        end;
      end else result:=FieldByName('id_articulo').AsInteger;
    end;
    Free;
  end;
end;

procedure Tf_main.ejecuta_lectura(id_articulo:Integer; bc:string; codalbaran_p:integer; mark_all:boolean; id_lote:Integer = 1);
var
  n_arts,linea, id_pedido, i, j:Integer;
  etiqueta, pais: string;
  aux_alb: Integer;
  aux_cod, albs_enviados, qry, str_pedidos, error_aux: string;
  AMsgDialog: TForm;
  pedidos: TStringList;
  revision: integer;
  date_aux: TDate;
  hora_aux: TTime;
begin

  pedidos := TStringList.Create;

  gb_asig.Visible:=false;
  gb_error.Visible:=false;
  bt_add.Visible:=false;
  lb_ean.Caption:='';
  lb_st.Caption:='';
  lbCajaGrande.Visible := True;
  lbCajaGrande.Caption := '';

  aux_alb := dm.q_pack.FieldByName('codalbaran').AsInteger;
  aux_cod := dm.q_pack.FieldByName('codigo').asstring;

  albs_enviados := '';

  revision := -100;

  qry := '';
  date_aux := Date;
  hora_aux := Time;

  str_pedidos := '';

  with tpfibdataset.create(Self) do
  try                               //Buscar EAN
    Database:=dm.db;
    close;
    SQLs.SelectSQL.Clear;
    sqls.SelectSQL.Add('select b.id_caja,l.codalbaran,b.tipo_caja,l.linea,a.codigo,' +
      'a.nombre, l.codrepartidor, lo.id_lote, lo.nombre as n_lote, lo.caducidad, ' +
      'l.cantidad-l.cantidad_i as pte '+
      'from a_packlin l '+
      'inner join a_packlin_bulto b on (l.id_packlin_bulto=b.id_packlin_bulto) '+
      'inner join g_articulos a on (l.id_articulo=a.id_articulo) '+
      'inner join a_lotes lo on (lo.id_lote = l.id_lote) '+
      'where l.id_packcab=:id_packcab and l.id_agrupa=:id_agrupa and l.nivel_agr=:nivel_agr and l.id_articulo=:id_articulo and l.cantidad_i<l.cantidad ');
    if codalbaran_p<>-1 then sqls.SelectSQL.Add('and l.codalbaran=:codalbaran ');
    if id_lote<>1 then       sqls.SelectSQL.Add('and l.id_lote=:id_lote ');

    sqls.SelectSQL.Add('group by 1,2,3,4,5,6,7,8,9,10,11');
    ParamByName('id_packcab').asinteger:=id_packcab;
    ParamByName('id_agrupa').asinteger:=id_agrupa;
    ParamByName('nivel_agr').asinteger:=nivel_agr;
    ParamByName('id_articulo').asinteger:=id_articulo;
    if codalbaran_p<>-1 then ParamByName('codalbaran').asinteger:=codalbaran_p;
    if id_lote<>1 then ParamByName('id_lote').asinteger:=id_lote;
    Open;

    if isempty then begin

      LanzaMensajeError(bc,'ERROR !! EAN NO ESPERADO EN AGRUPACIÓN');
      {
      gb_asig.Visible:=false;
      gb_error.Visible:=true;
      bt_add.Visible:=false;
      lb_ean.Caption:=bc;
      lb_st.Caption:='ERROR !! EAN NO ESPERADO EN AGRUPACIÓN';
      if FileExists(ruta_exe+'Audio\Error.wav') then sndPlaySound(PChar(ruta_exe+'Audio\Error.wav'),SND_NODEFAULT Or SND_ASYNC);
      }
    end else begin
      edIdArtOculto.Value := id_articulo;
      edCadOculto.Date := fieldbyname('caducidad').AsDateTime;
      edLineaOculto.Value := FieldByName('linea').Asinteger;
      edTipoCajaOculto.Text := FieldByName('tipo_caja').AsString;
      edIdCajaOculto.Value := FieldByName('id_caja').Asinteger;
      edRepartOculto.Value := FieldByName('codrepartidor').AsInteger;
      edIdLoteOculto.Value := FieldByName('id_lote').Asinteger;
      edUdsOculto.Value := FieldByName('pte').Asinteger;

      gb_asig.Visible:=true;
      gb_error.Visible:=false;
      lb_asig.Caption:=FieldByName('nombre').AsString;
      lb_asig_art.Caption:='Código '+FieldByName('codigo').AsString+' - EAN '+bc;
      lb_asig_lote.caption:='Lote '+Fieldbyname('n_lote').asstring+' '+formatdatetime('dd/mm/yy', fieldbyname('caducidad').asdatetime);

      if chRevLotes.Checked then
      begin

        RevisaLotes(FieldByName('codigo').AsString,
                    FieldByName('nombre').AsString,
                    Fieldbyname('n_lote').asstring,
                    fieldbyname('id_caja').AsString,
                    fieldbyname('codalbaran').AsString,
                    FormatDateTime('dd/mm/yyyy',fieldbyname('caducidad').AsDateTime),
                    id_articulo,
                    fieldbyname('pte').AsInteger);

      end else begin

                if only_one then begin                        //******************************************de 1 sola unidad
                  first;

                  if not mark_all then
                  begin
                      linea:=FieldByName('linea').AsInteger;

                        if cb_indiv_2040.Checked then
                          imprime_eti_indiv(id_packcab,id_agrupa,nivel_agr,linea);

                        with tpfibquery.create(Self) do                                                            //ACTUALIZA INDIV
                        try
                          Database:=dm.db;
                          Transaction:=dm.t_write;
                          sql.Add('update a_packlin set cantidad_i=1, fecha_i=:fecha_i, hora_i=:hora_i, id_usuario_i=:id_usuario_i, pc=:pc, situacion=''A'' '+
                            'where id_packcab=:id_packcab and id_agrupa=:id_agrupa and nivel_agr=:nivel_agr and linea=:linea');
                          ParamByName('id_packcab').AsInteger:=id_packcab;
                          ParamByName('id_agrupa').AsInteger:=id_agrupa;
                          ParamByName('nivel_agr').AsInteger:=nivel_agr;
                          ParamByName('linea').AsInteger:=linea;
                          ParamByName('fecha_i').AsDate:=date_aux;
                          ParamByName('hora_i').AsTime:= hora_aux;
                          //ParamByName('id_usuario_i').AsInteger:=u_globals.id_usuario;
                          ParamByName('id_usuario_i').AsInteger := usuario.id;
                          ParamByName('pc').AsString:=pc.nombre;

                          qry := sql[0];

                          dm.t_write.StartTransaction;
                          execquery;
                          dm.t_write.commit;

                          insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab',
                          qry,'PackAb.1El.NoAll Lectura',
                          'id_packcab=' + IntToStr(id_packcab) + ',id_agrupa=' + InttoStr(id_agrupa) + ',nivel_agr=' + IntToStr(nivel_agr) +
                          ',linea=' + IntToStr(linea) + ',fecha_i=' + FormatDateTime('dd.mm.yy',date_aux) + ',hora_i=' +  FormatDateTime('hh:nn:ss',hora_aux) +
                          ',id_usuario_i=' + IntToStr(usuario.id) + ',pc=' + pc.nombre);

                        finally
                          Free;
                        end;

                        if chEtXLect.Checked then
                        begin
                          cerrar_albaran(FieldByName('codalbaran').asinteger);

                          insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','PackAb.1El.NoAll.EtXLect. Alb.Cerrado ' + FieldByName('codalbaran').AsString,
                          log_cabecera + ',linea=' + IntToStr(linea));

                          if FieldByName('codrepartidor').AsInteger<46000 then
                          begin
                             //if CargarDatosTablaGestoras('agencias','lstname_etiqueta','agencia='+ CargarDatosTablaGestoras('albaranes','agencia','id_albaran='+FieldByName('codalbaran').AsString))='ETI_LOGINSER' then
                             if dmLabels.GetFormatoEtiqueta(FieldByName('codalbaran').AsInteger)='ETI_LOGINSER' then
                             begin
                               dmLabels.imp_eti := u_globals.imp_eti;
                               dmLabels.imprime_etiqueta_loginser(FieldByName('codalbaran').AsInteger,0, logo_cli_etiq);
                               insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','PackAb.1El.NoAll Et.Lgs. ' + FieldByName('codalbaran').AsString,
                               log_cabecera + ',linea=' + IntToStr(linea));
                             end
                             else begin
                               imprime_etiqueta_x_api(FieldByName('codalbaran').AsInteger);
                               insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','PackAb.1El.NoAll.EtXLect. Et.API ' + FieldByName('codalbaran').AsString,
                               log_cabecera + ',linea=' + IntToStr(linea));
                             end;
                          end else begin
                                if FieldByName('codrepartidor').AsInteger=46120 then
                                     imprime_eti_bulto_asm(FieldByName('codalbaran').Asinteger)
                                else
                                     imprime_eti_bulto(FieldByName('codalbaran').Asinteger);
                                insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','PackAb.1El.NoAll.EtXLect. Et.Bulto ' + FieldByName('codalbaran').AsString,
                                log_cabecera + ',linea=' + IntToStr(linea));
                          end;

                          if chHojaPick.Checked then
                          begin
                            imprime_hoja_pick(FieldByName('codalbaran').AsInteger);
                            insertalog(usuario.id,0,0,PC.Nombre, PC.IP,'','','','PackAb.1El.NoAll.EtXLect. HPick. ' + FieldByName('codalbaran').AsString,
                            log_cabecera + ',linea=' + IntToStr(linea));
                          end;

                          if revisa_lotes and chRevLotes.Checked then
                          begin
                             id_pedido := GetIdPedidoXAlbaran(FieldByName('codalbaran').AsInteger,id_cliente);

                             if id_pedido>0 then
                             begin
                                 pedidos.Add(IntToStr(id_pedido));
                                 insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','PackAb.1El.NoAll.EtXLect. Ini.Act.Lotes Ped.' + IntToStr(id_pedido),log_cabecera + ',linea=' + IntToStr(linea));

                                 if StrToInt(cl_padres[0])>0 then
                                 begin
                                   i := 0;
                                   while (i<=High(cl_padres)) do
                                   begin
                                      frmLotes.ActualizaLotes(main_cli,StrtoInt(cl_padres[i]),usuario.id,pedidos,lbNombreCl.Caption,PC.Nombre,PC.IP);
                                      Inc(i);
                                   end;
                                 end else
                                      frmLotes.ActualizaLotes(main_cli,StrtoInt(cl_padres[0]),usuario.id,pedidos,lbNombreCl.Caption,PC.Nombre,PC.IP);

                                 insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','PackAb.1El.NoAll.EtXLect. Fin.Act.Lotes Ped.' + IntToStr(id_pedido),log_cabecera + ',linea=' + IntToStr(linea));

                                 if StrToInt(cl_padres[0])>0 then
                                 begin
                                   i := 0;
                                   while (i<=High(cl_padres)) do
                                   begin
                                      cli_api_url := get_item_config_cliente(StrToInt(cl_padres[i]),'api_url');
                                      cli_api_user := get_item_config_cliente(StrToInt(cl_padres[i]),'api_user');
                                      cli_api_pass := get_item_config_cliente(StrToInt(cl_padres[i]),'api_pass');
                                      frmLotes.EnviaLotes(pedidos,lbNombreCl.Caption,PC.Nombre,PC.IP,0, StrtoInt(cl_padres[i]), cli_api_url, cli_api_user, cli_api_pass);
                                      Inc(i);
                                   end;
                                 end else
                                       frmLotes.EnviaLotes(pedidos,lbNombreCl.Caption,PC.Nombre,PC.IP,0, main_cli, cli_api_url, cli_api_user, cli_api_pass);

                                 insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','PackAb.1El.NoAll.EtXLect. Fin.Env.Lotes Ped.' + IntToStr(id_pedido),log_cabecera + ',linea=' + IntToStr(linea));
                             end;
                          end;

                          if cb_send_email.Checked and (get_email_albaran(FieldByName('codalbaran').AsInteger)<>'') then
                          begin
                            enviar_email_a_destino(FieldByName('codalbaran').AsInteger);
                            insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','PackAb.1El.NoAll.EtXLect. email ' + FieldByName('codalbaran').AsString,log_cabecera + ',linea=' + IntToStr(linea));
                          end;

                          albs_enviados := albs_enviados + FieldByName('codalbaran').AsString + ',';

                          error_aux := inserta_estado_albaran(FieldByName('codalbaran').AsInteger,punteo_almacen_usu, punteo_almacen_est,punteo_almacen_obs + ' EtXLect.1El.');
                          if error_aux='' then
                            insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','PackAb.1El.NoAll.EtXLect.EstadoAlb.' + FieldByName('codalbaran').AsString,
                            IntToStr(punteo_almacen_usu) + ',' + IntToStr(punteo_almacen_est) + ',' + punteo_almacen_obs + ' EtXLect.1El. ' +
                            log_cabecera + ',linea=' + IntToStr(linea))
                          else
                            insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','PackAb.1El.NoAll.EtXLect.EstadoAlb.' + FieldByName('codalbaran').AsString + ' Error',
                            IntToStr(punteo_almacen_usu) + ',' + IntToStr(punteo_almacen_est) + ',' + punteo_almacen_obs + ' EtXLect.1El. ' +
                            log_cabecera + ',linea=' + IntToStr(linea) + ' ' + error_aux);
                        end;

                        lbReparto.Caption := 'Reparto COMPLETO ' + #13#10 + FieldByName('nombre').AsString;
                        reparte(id_articulo,'I');
                        insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','PackAb.1El.NoAll. VozReparto(I) ' + IntToStr(id_articulo),
                        log_cabecera + ',linea=' + IntToStr(linea));

                  end else
                  begin      //1Elemento Marca Todo
                      n_arts:=0;
                      while not(eof) do begin
                        inc(n_arts);
                        next;
                      end;
                      lb_caja.Caption:='';
                      lbCajaGrande.Caption := '';
                      lb_albaran.Caption:=IntToStr(n_arts)+' Albaranes';

                      ver_imagen(id_articulo);

                      First;
                      while not(eof) do begin
                        linea:=FieldByName('linea').AsInteger;

                        if cb_indiv_2040.Checked then
                          imprime_eti_indiv(id_packcab,id_agrupa,nivel_agr,linea);

                        with tpfibquery.create(Self) do                                                            //ACTUALIZA INDIV
                        try
                          Database:=dm.db;
                          Transaction:=dm.t_write;
                          sql.Add('update a_packlin set cantidad_i=1, fecha_i=:fecha_i, hora_i=:hora_i, id_usuario_i=:id_usuario_i, pc=:pc, situacion=''A'' '+
                            'where id_packcab=:id_packcab and id_agrupa=:id_agrupa and nivel_agr=:nivel_agr and linea=:linea');
                          ParamByName('id_packcab').AsInteger:=id_packcab;
                          ParamByName('id_agrupa').AsInteger:=id_agrupa;
                          ParamByName('nivel_agr').AsInteger:=nivel_agr;
                          ParamByName('linea').AsInteger:=linea;
                          ParamByName('fecha_i').AsDate:=date_aux;
                          ParamByName('hora_i').AsTime:=hora_aux;
                          //ParamByName('id_usuario_i').AsInteger:=u_globals.id_usuario;
                          ParamByName('id_usuario_i').AsInteger := usuario.id;
                          ParamByName('pc').AsString:=pc.nombre;

                          qry := sql[0];

                          dm.t_write.StartTransaction;
                          execquery;
                          dm.t_write.commit;

                          insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab',
                          qry,'PackAb. Lectura 1El.All. Lectura ',
                          log_cabecera +
                          ',linea=' + IntToStr(linea) + ',fecha_i=' + FormatDateTime('dd.mm.yy',date_aux) + ',hora_i=' +  FormatDateTime('hh:nn:ss',hora_aux) +
                          'id_usuario_i=' + IntToStr(usuario.id) + ',pc=' + pc.nombre);

                        finally
                          Free;
                        end;


                        if chEtXLect.Checked then
                        begin
                          cerrar_albaran(FieldByName('codalbaran').asinteger);
                          insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','PackAb.1El.All.EtXLect. Alb.Cerrado ' + FieldByName('codalbaran').AsString,
                          log_cabecera + ',linea=' + IntToStr(linea));

                          if FieldByName('codrepartidor').AsInteger<46000 then
                          begin
                             //if CargarDatosTablaGestoras('agencias','lstname_etiqueta','agencia='+ CargarDatosTablaGestoras('albaranes','agencia','id_albaran='+FieldByName('codalbaran').AsString))='ETI_LOGINSER' then
                             if dmLabels.GetFormatoEtiqueta(FieldByName('codalbaran').AsInteger)='ETI_LOGINSER' then
                             begin
                                dmLabels.imp_eti := u_globals.imp_eti;
                                dmLabels.imprime_etiqueta_loginser(FieldByName('codalbaran').AsInteger,0,logo_cli_etiq);
                                insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','PackAb.1El.All.EtXLect. Et.Lgs. ' + FieldByName('codalbaran').AsString,log_cabecera + ',linea=' + IntToStr(linea));
                             end
                             else begin
                               imprime_etiqueta_x_api(FieldByName('codalbaran').AsInteger);
                               insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','PackAb.1El.All.EtXLect. Et.API ' + FieldByName('codalbaran').AsString,log_cabecera + ',linea=' + IntToStr(linea));
                             end;
                          end else begin
                                if FieldByName('codrepartidor').AsInteger=46120 then
                                     imprime_eti_bulto_asm(FieldByName('codalbaran').Asinteger)
                                else
                                     imprime_eti_bulto(FieldByName('codalbaran').Asinteger);
                                insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','PackAb.1El.All.EtXLect. Et.Bulto. ' + FieldByName('codalbaran').AsString,log_cabecera + ',linea=' + IntToStr(linea));
                          end;

                          if chHojaPick.Checked then
                          begin
                            imprime_hoja_pick(FieldByName('codalbaran').AsInteger);
                            insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','PackAb.1El.All.EtXLect. HPick. ' + FieldByName('codalbaran').AsString,log_cabecera + ',linea=' + IntToStr(linea));
                          end;

                          if revisa_lotes and chRevLotes.Checked then
                          begin
                             id_pedido := GetIdPedidoXAlbaran(FieldByName('codalbaran').AsInteger,id_cliente);

                             if id_pedido>0 then
                             begin
                                 pedidos.Add(IntToStr(id_pedido));
                                 str_pedidos := str_pedidos + ',';
                             end;
                          end;

                          if cb_send_email.Checked and (get_email_albaran(FieldByName('codalbaran').AsInteger)<>'') then
                          begin
                              enviar_email_a_destino(FieldByName('codalbaran').AsInteger);
                              InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','Bt.CerrarAgr. Email ' + FieldByName('codalbaran').asString,log_cabecera);
                          end;

                          albs_enviados := albs_enviados + FieldByName('codalbaran').AsString + ',';

                          error_aux := '';
                          error_aux := inserta_estado_albaran(FieldByName('codalbaran').AsInteger,punteo_almacen_usu, punteo_almacen_est,punteo_almacen_obs + ' EtXLect.1El.All.');

                          if error_aux='' then
                            insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','PackAb.1El.All.EtXLect. EstadoAlb.' + FieldByName('codalbaran').AsString,
                            IntToStr(punteo_almacen_usu) + ',' + IntToStr(punteo_almacen_est) + ',' + punteo_almacen_obs + ' EtXLect.1El.All. ' +
                            log_cabecera + ',linea=' + IntToStr(linea))
                          else
                            insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','PackAb.1El.All.EtXLect. EstadoAlb.' + FieldByName('codalbaran').AsString + ' Error',
                            IntToStr(punteo_almacen_usu) + ',' + IntToStr(punteo_almacen_est) + ',' + punteo_almacen_obs + ' EtXLect.1El.All. ' +
                            log_cabecera + ',linea=' + IntToStr(linea) + ' ' + error_aux);

                        end;

                         Next;

                      end;

                     if revisa_lotes and chRevLotes.Checked then
                      begin
                         if pedidos.Count>0 then
                         begin
                             if str_pedidos <> '' then
                                 str_pedidos := Copy(str_pedidos,1,Length(str_pedidos)-1);

                             insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','PackAb.1El.All. Ini.Act.Lotes Pedidos',str_pedidos + ' ' + log_cabecera + ',linea=' + IntToStr(linea));

                             if StrToInt(cl_padres[0])>0 then
                             begin
                               j := 0;
                               while (j<=High(cl_padres)) do
                               begin
                                  frmLotes.ActualizaLotes(main_cli,StrToInt(cl_padres[j]),usuario.id,pedidos,lbNombreCl.Caption,PC.Nombre,PC.IP);
                                  Inc(j);
                               end
                             end else
                                  frmLotes.ActualizaLotes(main_cli,StrToInt(cl_padres[0]),usuario.id,pedidos,lbNombreCl.Caption,PC.Nombre,PC.IP);


                             insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','PackAb.1El.All. Fin.Act.Lotes Pedidos',str_pedidos + ' ' + log_cabecera + ',linea=' + IntToStr(linea));
                             insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','PackAb.1El.All. Ini.Env.Lotes Pedidos',str_pedidos + ' ' + log_cabecera + ',linea=' + IntToStr(linea));
                             if StrToInt(cl_padres[0])>0 then
                             begin
                               j := 0;
                               while (j<=High(cl_padres)) do
                               begin
                                  cli_api_url := get_item_config_cliente(StrToInt(cl_padres[i]),'api_url');
                                  cli_api_user := get_item_config_cliente(StrToInt(cl_padres[i]),'api_user');
                                  cli_api_pass := get_item_config_cliente(StrToInt(cl_padres[i]),'api_pass');
                                  frmLotes.EnviaLotes(pedidos,lbNombreCl.Caption,PC.Nombre,PC.IP,0, StrToInt(cl_padres[j]), cli_api_url, cli_api_user, cli_api_pass);
                                  Inc(j);
                               end
                             end else
                                  frmLotes.EnviaLotes(pedidos,lbNombreCl.Caption,PC.Nombre,PC.IP,0, main_cli, cli_api_url, cli_api_user, cli_api_pass);

                             insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','PackAb.1El.All. Ini.Env.Lotes Pedidos',str_pedidos + ' ' + log_cabecera + ',linea=' + IntToStr(linea));
                         end;
                      end;
                    end;

                end else begin           //**********************albs de mas de una unidad

                  gb_asig.Visible:=true;
                  gb_error.Visible:=false;

                  ver_imagen(id_articulo);

                  if not (mark_all) then begin                        //***********************one read and marks only one

                    if ((revision>=0) and (revision=2)) then
                          mark_one(FieldByName('nombre').AsString,FieldByName('codigo').AsString,bc,FieldByName('tipo_caja').AsString,
                        FieldByName('id_caja').Asinteger,FieldByName('codalbaran').Asinteger,FieldByName('linea').AsInteger,true,true,
                        FieldByName('id_lote').Asinteger,FieldByName('n_lote').Asstring,FieldByName('caducidad').Asdatetime,FieldByName('pte').AsInteger)
                    else if ((revision>=0) and (revision=0)) then
                          mark_one(FieldByName('nombre').AsString,FieldByName('codigo').AsString,bc,FieldByName('tipo_caja').AsString,
                        FieldByName('id_caja').Asinteger,FieldByName('codalbaran').Asinteger,FieldByName('linea').AsInteger,true,true,
                        FieldByName('id_lote').Asinteger,FieldByName('n_lote').Asstring,FieldByName('caducidad').Asdatetime,1)
                    else begin

                      first;

                      mark_one(FieldByName('nombre').AsString,FieldByName('codigo').AsString,bc,FieldByName('tipo_caja').AsString,
                        FieldByName('id_caja').Asinteger,FieldByName('codalbaran').Asinteger,FieldByName('linea').AsInteger,true,true,
                        FieldByName('id_lote').Asinteger,FieldByName('n_lote').Asstring,FieldByName('caducidad').Asdatetime,1);
                     insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','PackAb.NoAll. Lectura',
                     log_cabecera + ',linea=' + IntToStr(linea) +
                     ' nombre=' + FieldByName('nombre').AsString + ',codigo=' + FieldByName('codigo').AsString + ',bc=' + bc +
                     ',tipo_caja=' + FieldByName('tipo_caja').AsString + ', id_caja=' + FieldByName('id_caja').AsString +
                     ',codalbaran=' + FieldByName('codalbaran').AsString + ',linea=' + FieldByName('linea').asstring +
                     ',verbose=true,check_cierre_caja=true,id_lote=' + FieldByName('id_lote').AsString +
                     ',n_lote=' + FieldByName('n_lote').Asstring + ',caducidad=' + FormatDateTime('dd.mm.yy',FieldByName('caducidad').Asdatetime));
                    end;

                  end else begin                                                          //***********************one read and marks all
                    first;
                    n_arts:=0;
                    while not(eof) do begin
                      n_arts := n_arts + FieldByName('pte').AsInteger;
                      next;
                    end;
                    lb_caja.Caption:='';
                    lbCajaGrande.Caption := '';
                    lb_albaran.Caption:=IntToStr(n_arts)+' Artículos';

                    First;
                    while not(eof) do begin
                      mark_one(FieldByName('nombre').AsString,FieldByName('codigo').AsString,bc,FieldByName('tipo_caja').AsString,
                        FieldByName('id_caja').Asinteger,FieldByName('codalbaran').Asinteger,FieldByName('linea').AsInteger,false,true,
                        FieldByName('id_lote').Asinteger,FieldByName('n_lote').Asstring,FieldByName('caducidad').Asdatetime,FieldByName('pte').AsInteger);
                      insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','PackAb.All. Lectura',
                      log_cabecera + ',linea=' + FieldByName('linea').asstring +
                      ' nombre=' + FieldByName('nombre').AsString + ',codigo=' + FieldByName('codigo').AsString + ',bc=' + bc +
                      ',tipo_caja=' + FieldByName('tipo_caja').AsString + ', id_caja=' + FieldByName('id_caja').AsString +
                      ',codalbaran=' + FieldByName('codalbaran').AsString + ',linea=' + FieldByName('linea').asstring +
                      ',verbose=false,check_cierre_caja=true,id_lote=' + FieldByName('id_lote').AsString +
                      ',n_lote=' + FieldByName('n_lote').Asstring + ',caducidad=' + FormatDateTime('dd.mm.yy',FieldByName('caducidad').Asdatetime));
                      next;
                    end;

                    lbReparto.Caption := 'Reparto COMPLETO ' + #13#10 + FieldByName('nombre').AsString;
                    reparte(id_articulo,'I');
                    insertalog(usuario.id,0,0,PC.Nombre, PC.IP,'','','','PackAb.All. Reparto(I) ' + IntToStr(id_articulo),log_cabecera);
                  end;
                end;

        //Nov'18 Almacén ha pedido que no salgan las etiquetas de italiano de momento
        //comprobar destino del albaran e imprimir si necesario la etiqueta
        {if(comprobar_si_etiquetaNecesaria(FieldByName('codalbaran').asinteger,id_articulo,etiqueta)) then
         begin
          imprime_etiquetasArticulos(etiqueta);
         end;}

        lb_st1.Caption := 'Actualizando pedidos a Enviado...';

        if chEtXLect.Checked and (Copy(albs_enviados,1,Length(albs_enviados)-1)<>'') then
        begin
          with tpfibquery.create(Self) do                         //Actualiza Datos
          try
            Database:=dm.db;
            Transaction:=dm.t_write;
            sql.Add('update c_pedidos set estado=:estado, fecha_fin=:fecha '+
              ' where codalbaran in (' + Copy(albs_enviados,1,Length(albs_enviados)-1) + ')');
            parambyname('estado').AsString := 'E';
            ParamByName('fecha').AsDateTime:=Now;

            dm.t_write.StartTransaction;
            execquery;
            dm.t_write.commit;
            insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','PackAb.EtXLect. Est.Ped=E','Albs.:'+Copy(albs_enviados,1,Length(albs_enviados)-1) +
            ' ' + log_cabecera);
          finally
            Free;
          end;
        end;

        dm.q_packagr.Close;
        dm.q_packagr.Open;

        dm.q_pack.Close;
        dm.q_pack.Open;
        dm.q_pack.Locate('codalbaran;codigo',VarArrayOf([aux_alb,aux_cod]),[]);

        dm.q_pack_leido.Close;
        dm.q_pack_leido.Open;

        lb_st1.Caption := 'Esperando siguiente artículo...';
      end;
    end;
  finally
    Free;
  end;

  pedidos.Free;
end;

procedure Tf_main.ver_imagen(id_articulo:integer);
var   Jpeg: TJpegImage;
begin
  with tpfibdataset.create(Self) do
  try
    Database:=dm.db;
    SelectSQL.Add('select imagen '+
        'from g_articulos '+
        'where id_articulo=:id_articulo');
    ParamByName('id_articulo').asinteger:=id_articulo;
    Open;

    if FieldByName('imagen').IsNull then im.Picture.Graphic := nil
    else begin
      Jpeg := TJpegImage.Create;
      try
        Jpeg.Assign(FieldByName('imagen'));

        if ((jpeg.Width>470) or (jpeg.Height>330)) then begin
          im.stretch:=true;
          im.Width:=470;
          im.Height:=330;
          pn_im.Width:=474;
          pn_im.Height:=334;
        end else begin
          im.stretch:=false;
          im.Width:=jpeg.Width;
          im.Height:=jpeg.Height;
          pn_im.Width:=jpeg.width+4;
          pn_im.Height:=jpeg.Height+4;
        end;

        im.Picture.Assign(Jpeg);
      finally
        Jpeg.Free;
      end;
    end;

    pn_im.repaint;
  finally
    Free;
  end;
end;

procedure Tf_main.imprime_etiqueta_x_api(codalbaran:Integer);
var
    tracking, error:string;
    texto: string;

begin
      if get_albaran_data('expedicion_age',codalbaran)='' then
      begin
        if codalbaran>0 then
        begin
          DMCreaBultos.GeneraBultos(codalbaran,get_albaran_dest(codalbaran));

          If ValidaAlbaran(IntToStr(codalbaran),texto)  then
          begin
            DMLstEtiquetas.ObtenEtiquetas('A',IntToStr(codalbaran),True);
            //lbExpAgencia.Caption := get_albaran_data('expedicion_age',dm.q_peds.fieldbyname('codalbaran').AsInteger);
          end;
        end;
      end else
              DMLstEtiquetas.ObtenEtiquetas('A',IntToStr(codalbaran),True);

end;

function  Tf_main.get_albaran_dest(codalbaran: Integer):Integer;
begin
  result := -1;

  with tpfibdataset.create(Self) do
  try
    Database:=dm.db_gestoras;
    SelectSQL.Add('select id_albaran_det '+
        'from albaran_dest '+
        'where id_albaran=:id_alb');
    ParamByName('id_alb').asinteger:=codalbaran;
    Open;

    if not IsEmpty then
    begin
       Result := FieldByName('id_albaran_det').AsInteger;
    end;
  finally
    Free;
  end;

end;

procedure Tf_main.envia_email(email_destino,email_cco,asunto,ruta_adjunto:string; cuerpo:TStrings; cuenta:Integer=1);          //envia correo electronico
var    email_dir,email_user,email_pass,email_host:string;  email_smtp_port:integer;      mess:tidmessage;
begin
  {if cuenta=1 then begin
    email_dir:=u_gen_gl.sys_email_dir;
    email_user:=u_gen_gl.sys_email_user;
    email_pass:=u_gen_gl.sys_email_pass;
    email_host:=u_gen_gl.sys_email_host;
    email_smtp_port:=u_gen_gl.sys_email_smtp_port;
  end else begin
    email_dir:=u_gen_gl.noreply_email_dir;
    email_user:=u_gen_gl.noreply_email_user;
    email_pass:=u_gen_gl.noreply_email_pass;
    email_host:=u_gen_gl.noreply_email_host;
    email_smtp_port:=u_gen_gl.noreply_email_smtp_port;
  end;

  mess:=TIdMessage.Create();
  with mess do begin
    AttachmentEncoding:='UUE';
    charset:='us-ascii';
    //charset:='UTF-8';
    ContentType:='text/plain';

    with TIdText.Create(MessageParts, nil) do begin
      Body.assign(cuerpo);
      charset:='UTF-8';
      ContentType:='text/html';
    end;

    From.Text:=email_dir;
    ReplyTo.EMailAddresses:=email_dir;

    lb_dest.clear;
    lb_dest.Items.Add(email_destino);

    application.processmessages;

    Recipients.EMailAddresses:=email_destino;
    BccList.EMailAddresses:=email_cco;
    Subject:=asunto;

    if FileExists(ruta_adjunto) then begin
      with TIdAttachmentFile.Create(MessageParts,ruta_adjunto) do begin
        ContentType := 'text/plain';
        FileName:=ruta_adjunto;
      end;
    end;

    ContentType := 'multipart/mixed';
  end;

  smtp_1.Username:=email_user;
  smtp_1.Password:=email_pass;
  smtp_1.Host:=email_host;
  smtp_1.Port:=email_smtp_port;

  smtp_1.Connect;
  try
    smtp_1.Send(mess);
  finally
    smtp_1.Disconnect;
  end;

  FreeAndNil(mess);
  //http://www.indyproject.org/Sockets/Blogs/RLebeau/2005_08_17_A.EN.aspx        }
end;

procedure Tf_main.envia_email_multiple(email_destino,email_cco,asunto:string; ruta_adjuntos:TStringList; cuerpo:TStrings; cuenta:Integer=1);         //envia correo electronico
var    email_dir,email_user,email_pass,email_host:string;  email_smtp_port:integer;      mess:tidmessage;    i:integer;
begin
 { if cuenta=1 then begin
    email_dir:=u_gen_gl.sys_email_dir;
    email_user:=u_gen_gl.sys_email_user;
    email_pass:=u_gen_gl.sys_email_pass;
    email_host:=u_gen_gl.sys_email_host;
    email_smtp_port:=u_gen_gl.sys_email_smtp_port;
  end else begin
    email_dir:=u_gen_gl.noreply_email_dir;
    email_user:=u_gen_gl.noreply_email_user;
    email_pass:=u_gen_gl.noreply_email_pass;
    email_host:=u_gen_gl.noreply_email_host;
    email_smtp_port:=u_gen_gl.noreply_email_smtp_port;
  end;

  mess:=TIdMessage.Create();
  with mess do begin
    AttachmentEncoding:='UUE';
    charset:='us-ascii';
    ContentType:='text/plain';

    with TIdText.Create(MessageParts, nil) do begin
      Body.assign(cuerpo);
      ContentType:='text/html';
    end;

    From.Text:=email_dir;
    ReplyTo.EMailAddresses:=email_dir;

    lb_dest.clear;
    lb_dest.Items.Add(email_destino);

    application.processmessages;

    Recipients.EMailAddresses:=email_destino;
    BccList.EMailAddresses:=email_cco;
    Subject:=asunto;

    if ruta_adjuntos.count>0 then begin
      for i:=0 to ruta_adjuntos.Count-1 do begin
        if FileExists(ruta_adjuntos[i]) then begin
          with TIdAttachmentFile.Create(MessageParts,ruta_adjuntos[i]) do begin
            ContentType := 'text/plain';
            FileName:=ruta_adjuntos[i];
          end;
        end;
      end;
    end;
    ContentType := 'multipart/mixed';
  end;

  smtp_1.Username:=email_user;
  smtp_1.Password:=email_pass;
  smtp_1.Host:=email_host;
  smtp_1.Port:=email_smtp_port;

  smtp_1.Connect;
  try
    smtp_1.Send(mess);
  finally
    smtp_1.Disconnect;
  end;

  FreeAndNil(mess);
  //http://www.indyproject.org/Sockets/Blogs/RLebeau/2005_08_17_A.EN.aspx     }
end;

procedure Tf_main.filter_leidos(orden: string);
begin
  dm.q_pack_leido.Close;
  dm.q_pack_leido.SQLs.SelectSQL.Clear;
  dm.q_pack_leido.SQLs.SelectSQL.Add('select b.codalbaran,b.id_caja,b.tipo_caja,a.codigo,a.nombre,l.linea,lo.nombre as n_lote, ' + '  sum(l.cantidad) as total,sum(l.cantidad_i) as leidos ' + 'from a_packlin l ' + 'inner join g_articulos a on (l.id_articulo=a.id_articulo) ' + 'inner join a_packlin_bulto b on (b.id_packlin_bulto=l.id_packlin_bulto) ' + 'inner join a_lotes lo on (l.id_lote=lo.id_lote) ' + 'where l.id_packcab=:id_packcab and l.id_agrupa=:id_agrupa and l.nivel_agr=:nivel_agr and l.cantidad_i>0 ' + //     'group by 1,2,3,4,5,6 order by 2,4');
  'group by 1,2,3,4,5,6,7 order by ' + orden);
  if order_desc then
      dm.q_pack_leido.SQLs.SelectSQL.Add(' desc');

  dm.q_pack_leido.ParamByName('id_packcab').asinteger := id_packcab;
  dm.q_pack_leido.ParamByName('id_agrupa').asinteger := id_agrupa;
  dm.q_pack_leido.ParamByName('nivel_agr').asinteger := nivel_agr;
  dm.q_pack_leido.Open;
end;

procedure Tf_main.filter_ptes(orden: string);
begin
  dm.q_pack.Close;
  dm.q_pack.SQLs.SelectSQL.Clear;
  dm.q_pack.SQLs.SelectSQL.Add('select b.codalbaran,b.id_caja,b.tipo_caja,a.codigo,a.nombre,lo.nombre as n_lote,lo.id_lote, ' +
  '  sum(l.cantidad) as total,sum(l.cantidad)-sum(l.cantidad_i) as pdtes ' +
  'from a_packlin l ' + 'inner join g_articulos a on (l.id_articulo=a.id_articulo) ' +
  'inner join a_packlin_bulto b on (b.id_packlin_bulto=l.id_packlin_bulto) ' +
  'inner join a_lotes lo on (l.id_lote=lo.id_lote) ' +
  'where l.id_packcab=:id_packcab and l.id_agrupa=:id_agrupa and l.nivel_agr=:nivel_agr and l.cantidad_i<l.cantidad ' +
  //      'group by 1,2,3,4,5 order by 2,4');
  'group by 1,2,3,4,5,6,7 order by ' + orden);
  if order_desc then
       dm.q_pack.SQLs.SelectSQL.Add(' desc');

  dm.q_pack.ParamByName('id_packcab').asinteger := id_packcab;
  dm.q_pack.ParamByName('id_agrupa').asinteger := id_agrupa;
  dm.q_pack.ParamByName('nivel_agr').asinteger := nivel_agr;
  dm.q_pack.Open;
end;

procedure Tf_main.reparte(id_articulo:Integer; tipo:string);    //tipo: I:insertando R:leyendo
begin
    edIdArt.Value := id_articulo;
    if not cdsreparto.Active then
         cdsreparto.CreateDataSet;
    cdsreparto.EmptyDataSet;

    with dm.q_reparto do
    begin
        close;
        SelectSQL.Clear;
        SelectSQL.Add('select l.codalbaran,b.id_caja, lo.nombre, l.cantidad_i, b.bultos , b.n_bulto ' +
                      'from a_packlin_bulto b ' +
                      'inner join a_packlin l on (l.id_packlin_bulto=b.id_packlin_bulto) ' +
                      'inner join a_lotes lo on (l.id_lote=lo.id_lote) ' +
                      'where l.id_packcab=:id_packcab and l.id_agrupa=:id_agrupa and ' +
                      'l.nivel_agr=:nivel_agr and l.id_articulo=:id_articulo ' +
                      'and l.cantidad=l.cantidad_i ');
        ParamByName('id_packcab').AsInteger := id_packcab;
        ParamByName('id_agrupa').AsInteger := id_agrupa;
        ParamByName('nivel_agr').AsInteger := nivel_agr;
        ParamByName('id_articulo').AsInteger := id_articulo;
        Open;

        if not IsEmpty then
        begin
          First;
          aux_alb := FieldByName('codalbaran').AsString;
          while not Eof do
          begin
           { if cdsreparto.Locate('codalbaran',FieldByName('codalbaran').AsString,[]) then
            begin
                cdsreparto.Edit;
                cdsreparto.FieldByName('num_cajas').AsString := cdsreparto.FieldByName('num_cajas').AsString + ',' + FieldByName('n_bulto').AsString;
                cdsreparto.FieldByName('tipo_cajas').AsString := cdsreparto.FieldByName('tipo_cajas').AsString + ',' + FieldByName('tipo_caja').AsString;
                cdsreparto.Post;
            end
            else begin  }
                    cdsreparto.Append;
                    cdsreparto.FieldByName('codalbaran').AsString := FieldByName('codalbaran').AsString;
                    cdsreparto.FieldByName('num_cajas').AsString := FieldByName('id_caja').AsString;
                    cdsreparto.FieldByName('lote').AsString := FieldByName('nombre').AsString;
                    cdsreparto.FieldByName('uds').AsString := FieldByName('cantidad_i').AsString;
                    cdsreparto.FieldByName('bultos').AsString := FieldByName('bultos').AsString;
                    cdsreparto.FieldByName('n_bulto').AsString := FieldByName('n_bulto').AsString;
                    cdsreparto.Post;

                    if (tipo='I') and
                       (((id_agrupa=120) and cb_one_read_marks_all.Checked) or
                         (id_agrupa<>120)) then   //solo se dice el reparto de viva voz si se está insertando
                    begin
                      if FileExists(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+'-C.wav') then
                          sndPlaySound(PChar(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+'-C.wav'),SND_NODEFAULT Or SND_ASYNC);

                      Sleep(500);

                      if FileExists(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+ '-' + FormatFloat('00',FieldByName('id_caja').AsInteger) + '.wav') then
                          sndPlaySound(PChar(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+ '-' + FormatFloat('00',FieldByName('id_caja').AsInteger) + '.wav'),SND_NODEFAULT Or SND_ASYNC);

                      Sleep(1500);

                      if FileExists(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+ '-' + FormatFloat('00',FieldByName('cantidad_i').AsInteger) + '.wav') then
                          sndPlaySound(PChar(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+ '-' + FormatFloat('00',FieldByName('cantidad_i').AsInteger) + '.wav'),SND_NODEFAULT Or SND_ASYNC);
                      Sleep(1500);
                    end;
            {end; }
            Next;
          end;
        end;

        btPasarUds.Enabled := not IsEmpty;


    end;
end;

procedure Tf_main.nuevo_bulto(codalbaran:integer; etiq_prev:Boolean=True);                                                                  //Cerrar caja actual y generar una nueva
var
    cubic:real;
    id_packlin_bulto_new,id_packlin_bulto_old,bultos,n_bulto, n_uds_pend, n_linea, ruta, codrepartidor, uds_alb:integer;
    caja,etiq_chrono,n_bulto_dhl,n_bulto_str,qry, param_aux:string;
    date_aux: TDate;
    hora_aux: TTime;
begin
   id_packlin_bulto_old := -1;

    with tpfibdataset.Create(dm) do begin                                           //Consigue tamaño de caja para lo que queda
      database:=dm.db;
      SQLs.SelectSQL.Clear;

      SQLs.SelectSQL.Add('select first 1 b.id_packlin_bulto, l.codrepartidor ' +
                      'from a_packlin_bulto b ' +
                      'inner join a_packlin l on (l.id_packlin_bulto=b.id_packlin_bulto) ' +
                      'inner join a_lotes lo on (l.id_lote=lo.id_lote) ' +
                      'where l.id_packcab=:id_packcab and l.id_agrupa=:id_agrupa and ' +
                      'l.nivel_agr=:nivel_agr and l.id_articulo=:id_articulo ' +
                      'and l.cantidad=l.cantidad_i and l.codalbaran=:codalbaran ');
      ParamByName('id_packcab').AsInteger := id_packcab;
      ParamByName('id_agrupa').AsInteger := id_agrupa;
      ParamByName('nivel_agr').AsInteger := nivel_agr;
      ParamByName('id_articulo').AsInteger := edIdArt.Value;
      ParamByName('codalbaran').AsInteger := codalbaran;

      Open;

      if not(IsEmpty) then
      begin
         id_packlin_bulto_old := FieldByName('id_packlin_bulto').asinteger;
         codrepartidor := FieldByName('codrepartidor').asinteger;
      end;

      Free;
    end;

    if id_packlin_bulto_old<0 then
    begin
      ShowMessage('No existen bultos para repartir.');
      exit;
    end;

    with tpfibdataset.Create(dm) do begin                                           //Consigue tamaño de caja para lo que queda
      database:=dm.db;
      SQLs.SelectSQL.Clear;

      SQLs.SelectSQL.Add('select sum(a.cubic) as cubic, sum(l.cantidad) as uds '+
        'from a_packlin l '+
        'inner join g_articulos a on (l.id_articulo=a.id_articulo) '+
        'where l.id_packlin_bulto=:id_packlin_bulto '+
        'and cantidad=cantidad_i ');
      ParamByName('id_packlin_bulto').asinteger:=id_packlin_bulto_old;

      Open;

      if not(IsEmpty) then begin
         cubic:=FieldByName('cubic').asfloat;
         uds_alb := FieldByName('uds').asInteger;
      end else begin
        cubic:=0;
      end;
      Free;
    end;

    caja:='';
    if cubic>cubic_b then caja:='A'
    else if cubic>cubic_c then caja:='B'
      else if cubic>cubic_d then caja:='C'
        else if cubic>cubic_e then caja:='D'
          else caja:='E';

    with tpfibdataset.Create(dm) do begin                                //Consigue siguiente numero de bulto
      database:=dm.db;
      SQLs.SelectSQL.Clear;
      //el siguiente numero en dhl puede no ser el siguiente del albaran 1, sino del albaran 2 agrupado. Pueden intercalarse ergo necesitamos calcular cual es el ultimo numero en la agrupacion
      if(codrepartidor=46276) then      //DHL
       begin
        //averiguamos que n_bulto_chrono tiene
        SQLs.SelectSQL.Add('select n_bulto_chrono '+
                           'from a_packlin_bulto '+
                           'where id_packlin_bulto=:id_packlin_bulto');
        ParamByName('id_packlin_bulto').asinteger:=id_packlin_bulto_old;
        Open;
        if( not IsEmpty) then
         n_bulto_dhl:=FieldByName('n_bulto_chrono').AsString
        else n_bulto_dhl :='';
        Close;
        //a partir del n_bulto_chrono, averiguamos el bulto y numero de bultos
        SQLs.SelectSQL.Clear;
        SQLs.SelectSQL.Add('select max(bultos) as bultos,max(n_bulto) as n_bulto '+
                           'from a_packlin_bulto '+
                           'where n_bulto_chrono=:n_bulto_chro');
        ParamByName('n_bulto_chro').asString:=n_bulto_dhl;
       end
       else
       begin
       //si no es dhl se sigue calculando como hasta el momento
        SQLs.SelectSQL.Add('select bultos,n_bulto,codalbaran '+
                           'from a_packlin_bulto '+
                           'where id_packlin_bulto=:id_packlin_bulto');
        ParamByName('id_packlin_bulto').asinteger:=id_packlin_bulto_old;
       end;
      Open;

      if not(IsEmpty) then begin
        bultos:=FieldByName('bultos').AsInteger+1;
        n_bulto:=FieldByName('n_bulto').AsInteger+1;
      end else begin
        bultos:=1;
        n_bulto:=1;
      end;
      Free;
    end;

    etiq_chrono:='';
   { if ((codrepartidor=46172) or
         (codrepartidor=46276)) then begin         //Num bulto de chrono o DHL
      with tpfibdataset.Create(dm) do begin                                //Consigue etiq chrono vieja
        database:=dm.db;
        SQLs.SelectSQL.Clear;
        SQLs.SelectSQL.Add('select n_bulto_chrono '+
          'from a_packlin_bulto '+
          'where id_packlin_bulto=:id_packlin_bulto');
        ParamByName('id_packlin_bulto').asinteger:=id_packlin_bulto_old;
        Open;

        if (codrepartidor=46172) then   //chrono
        begin
          if not(IsEmpty) and (FieldByName('n_bulto_chrono').asstring<>'')  then begin
            etiq_chrono:=FieldByName('n_bulto_chrono').asstring;
          end else begin
            etiq_chrono:='00000000000000000000000';
          end;
        end else if not(IsEmpty) and (FieldByName('n_bulto_chrono').asstring<>'')  then begin
                        etiq_chrono:=FieldByName('n_bulto_chrono').asstring;
                  end;
        Free;
      end;

      if (codrepartidor=46172) then   //chrono
      begin
        n_bulto_str:=FormatFloat('00',n_bulto);
        etiq_chrono[16]:=n_bulto_str[1];
        etiq_chrono[17]:=n_bulto_str[2];
        etiq_chrono[23]:=inttostr(calc_digcon_chrono(Copy(etiq_chrono,1,Length(etiq_chrono)-1)))[1];
      end;
    end;  }


    with tpfibdataset.Create(dm) do begin                              //nuevo id packlin bulto
      database:=dm.db;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('SELECT GEN_ID(GEN_A_PACKLIN_BULTO_ID,1) FROM RDB$DATABASE');
      Open;

      id_packlin_bulto_new:=FieldByName('gen_id').AsInteger;
      Free;
    end;


    qry := 'insert into a_packlin_bulto (id_packlin_bulto,codalbaran,codalbeti,tipo_caja,id_caja,paquetes,bultos,n_bulto,n_bulto_chrono,kgs,kgs_vol,'+
        ' fecha_alb,codcli,org_codcli,org_coddel,org_nombre,org_calle,org_cp,org_localidad,org_provincia,org_persona,org_tfno,dst_codcli,'+
        ' dst_coddel,dst_nombre,dst_calle,dst_cp,dst_localidad,dst_provincia,dst_persona,dst_tfno,reembolso,pdebido,cod_ruta,cod_repartidor,'+
        ' observaciones,impreso,hora,fecha,id_usuario,pc,enviado,dst_email) '+
        ' select :id_packlin_bulto_new,codalbaran,codalbeti,:tipo_caja,id_caja,paquetes,:bultos,:n_bulto,:n_bulto_chrono,kgs,kgs_vol,fecha_alb,codcli, '+
        '   org_codcli,org_coddel,org_nombre,org_calle,org_cp,org_localidad,org_provincia,org_persona,org_tfno,dst_codcli,dst_coddel,dst_nombre, '+
        '   dst_calle,dst_cp,dst_localidad,dst_provincia,dst_persona,dst_tfno,reembolso,pdebido,cod_ruta,cod_repartidor,observaciones,''N'',NULL,NULL,NULL,NULL,''N'',dst_email '+
        ' from a_packlin_bulto where id_packlin_bulto=:id_packlin_bulto_old';

    with tpfibquery.create(Self) do                         //Nuevo packlin bulto
    try
      Database:=dm.db;
      Transaction:=dm.t_write;
      sql.Add(qry);
      parambyname('id_packlin_bulto_new').asinteger:=id_packlin_bulto_new;
      ParamByName('id_packlin_bulto_old').asinteger:=id_packlin_bulto_old;
      ParamByName('tipo_caja').asstring:=caja;
      ParamByName('bultos').AsInteger:=bultos;
      ParamByName('n_bulto').AsInteger:=n_bulto;
      ParamByName('n_bulto_chrono').asstring:=etiq_chrono;

      dm.t_write.StartTransaction;
      execquery;
      dm.t_write.commit;

      insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab',qry,'Insert Bulto' + cdsreparto.FieldByName('codalbaran').AsString, log_cabecera +
      'id_packlin_bulto_new=' + IntToStr(id_packlin_bulto_new) + ',id_packlin_bulto_old='+ IntToStr(id_packlin_bulto_old) +
      'tipo_caja=' + caja + ',bultos=' + IntToStr(bultos) + ',n_bulto=' + IntToStr(n_bulto) + ',n_bulto_chrono=' + etiq_chrono);
    finally
      Free;
    end;


    with tpfibquery.create(Self) do                         //Actualiza total bultos del resto de bultos del albaran
    try
      Database:=dm.db;
      Transaction:=dm.t_write;

      //si es de dhl vamos a agrupar por n_bulto_chrono porque necesitamos actualizar el numero de bultos de todos los albaranes agrupados
      if(codrepartidor=46276) then
      begin
       qry := 'update a_packlin_bulto b set b.bultos=:bultos '+
               'where b.n_bulto_chrono=:n_bul_chro';

       sql.Add(qry);
      //  'where b.id_packlin_bulto in ('+
      //  ' select l.id_packlin_bulto from a_packlin_bulto l where l.n_bulto_chrono=:n_bul_chro'+
      //  ')');
        ParamByName('n_bul_chro').asString:=etiq_chrono;
        ParamByName('bultos').AsInteger:=bultos;

        param_aux := 'n_bul_chro=' + etiq_chrono + ',bultos' + IntToStr(bultos);
      end
      else
       begin
        qry :=  'update a_packlin_bulto b set b.bultos=:bultos '+
                'where b.id_packlin_bulto in ('+
                ' select l.id_packlin_bulto from a_packlin l where l.id_packcab=:id_packcab and l.id_agrupa=:id_agrupa and l.nivel_agr=:nivel_agr and l.codalbaran=:codalbaran'+
                ')';
        sql.Add(qry);
        ParamByName('id_packcab').AsInteger := id_packcab;
        ParamByName('id_agrupa').AsInteger  := id_agrupa;
        ParamByName('nivel_agr').AsInteger  := nivel_agr;
        ParamByName('codalbaran').AsInteger := codalbaran;
        ParamByName('bultos').AsInteger     := bultos;

        param_aux := 'codalbaran=' + IntToStr(codalbaran) + ',bultos' + IntToStr(bultos);
       end;

      dm.t_write.StartTransaction;
      execquery;
      dm.t_write.commit;

      insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab',qry,'Update Bulto' + cdsreparto.FieldByName('codalbaran').AsString, log_cabecera +
      param_aux);
    finally
      Free;
    end;

    with tpfibdataset.Create(dm) do begin   //Ultima linea del packing
      database:=dm.db;
      SQLs.SelectSQL.Clear;

      SQLs.SelectSQL.Add('select max(l.linea) as linea '+
        'from a_packlin l '+
        'where l.id_packcab=:id_packcab ');
      ParamByName('id_packcab').asinteger:=id_packcab;

      Open;

      if not(IsEmpty) then begin
         n_linea := FieldByName('linea').AsInteger + 1;
      end else begin
        n_linea:=1;
      end;
      Free;
    end;

    //*  INI NUEVA LINEA EN PACKLIN *//
                                       //Consigue datos de la linea de la que se va a repartir cantidad
      dm.qLineaPackOld.Close;
      dm.qLineaPackOld.SQLs.SelectSQL.Clear;

      dm.qLineaPackOld.SQLs.SelectSQL.Add('select * '+
        'from a_packlin l '+
        'inner join g_articulos a on (l.id_articulo=a.id_articulo) ' +
        'where l.id_packlin_bulto=:id_packlin_bulto ' +
        'and l.id_articulo=:id_articulo ' +
        'and cantidad=cantidad_i ');
      dm.qLineaPackOld.ParamByName('id_packlin_bulto').asinteger:=id_packlin_bulto_old;
      dm.qLineaPackOld.ParamByName('id_articulo').asinteger:=edIdArt.Value;
      dm.qLineaPackOld.Open;

      if not(dm.qLineaPackOld.IsEmpty) then begin
         //Solo insertamos una nueva linea se se pasa una cantidad menor de la que hay leida. Si
         //se va a pasar todo nos quedamos con la misma linea y solo hay que cambiar el numero de bulto
         if dm.qLineaPackOld.FieldByName('cantidad_i').AsInteger<>edUds.Value then
         begin
           qry := 'insert into a_packlin ' +
                  '(ID_PACKCAB,ID_AGRUPA,NIVEL_AGR,LINEA,ID_RUTA,ID_ARTICULO,CANTIDAD,SITUACION,CODALBARAN, ' +
                  'CODMOVIMIENTO,FECHA_I,HORA_I,ID_USUARIO_I,CANTIDAD_I,CODREPARTIDOR,PC,ID_PACKLIN_BULTO,' +
                  'SULINEA,ATT,N_PARCIAL,ID_LOTE)' +
                  ' values ' +
                  '(:ID_PACKCAB,:ID_AGRUPA,:NIVEL_AGR,:LINEA,:ID_RUTA,:ID_ARTICULO,:CANTIDAD,:SITUACION,:CODALBARAN, ' +
                  ':CODMOVIMIENTO,:FECHA_I,:HORA_I,:ID_USUARIO_I,:CANTIDAD_I,:CODREPARTIDOR,:PC,:ID_PACKLIN_BULTO,' +
                  ':SULINEA,:ATT,:N_PARCIAL,:ID_LOTE)';

           date_aux := Date;
           hora_aux := Time;

           with tpfibquery.create(Self) do                         //Inserta nueva linea de packing
           try
              Database:=dm.db;
              Transaction:=dm.t_write;
              sql.Add(qry);

              ParamByName('id_packcab').AsInteger       := id_packcab;
              ParamByName('id_agrupa').AsInteger        := id_agrupa;
              ParamByName('nivel_agr').AsInteger        := nivel_agr;
              ParamByName('linea').AsInteger            := n_linea;
              ParamByName('id_ruta').AsInteger          := dm.qLineaPackOld.FieldByName('id_ruta').AsInteger;
              ParamByName('id_articulo').AsInteger      := edIdArt.Value;
              ParamByName('cantidad').AsInteger         := edUds.Value;
              ParamByName('situacion').AsString         := dm.qLineaPackOld.FieldByName('situacion').AsString;
              ParamByName('codalbaran').AsInteger       := codalbaran;
              ParamByName('codmovimiento').AsInteger    := dm.qLineaPackOld.FieldByName('codmovimiento').AsInteger;
              ParamByName('fecha_i').AsDate             := Date_aux;
              ParamByName('hora_i').AsTime              := hora_aux;
              //ParamByName('id_usuario_i').AsInteger     := u_globals.id_usuario;
              ParamByName('id_usuario_i').AsInteger     := usuario.id;
              ParamByName('cantidad_i').AsInteger       := edUds.Value;
              ParamByName('codrepartidor').AsInteger    := dm.qLineaPackOld.FieldByName('codrepartidor').AsInteger;
              ParamByName('pc').AsString                := pc.nombre;
              ParamByName('id_packlin_bulto').AsInteger := id_packlin_bulto_new;
              ParamByName('sulinea').AsString           := dm.qLineaPackOld.FieldByName('sulinea').AsString;
              ParamByName('att').AsString               := dm.qLineaPackOld.FieldByName('att').AsString;
              ParamByName('n_parcial').AsString         := dm.qLineaPackOld.FieldByName('n_parcial').AsString;
              ParamByName('id_lote').AsInteger          := dm.qLineaPackOld.FieldByName('id_lote').AsInteger;

              dm.t_write.StartTransaction;
              execquery;
              dm.t_write.commit;

              ruta := dm.qLineaPackOld.FieldByName('id_ruta').AsInteger;

              insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab',qry,'Insert Packlin. Devuelve ruta=' +dm.qLineaPackOld.FieldByName('id_ruta').asstring,
              log_cabecera +
              ' linea=' + IntToStr(n_linea) + ',id_ruta=' + dm.qLineaPackOld.FieldByName('id_ruta').asstring +
              ',id_articulo=' + IntToStr(edIdArt.Value) + ',cantidad=' + IntToStr(edUds.Value) +
              ',situacion=' + dm.qLineaPackOld.FieldByName('situacion').AsString +
              ',codalbaran' + IntToStr(codalbaran) + ',codmovimiento=' + dm.qLineaPackOld.FieldByName('codmovimiento').Asstring +
              ',fecha_i=' + formatDateTime('dd.mm.yy',date_aux) + ',hora_i=' + formatDateTime('hh:nn:ss',hora_aux) +
              ',id_usuario_i=' + IntToStr(usuario.id) + ',cantidad_i=' + IntToStr(edUds.Value) +
              ',codrepartidor=' + dm.qLineaPackOld.FieldByName('codrepartidor').asString +
              ',pc=' + pc.nombre + ',id_packlin_bulto=' + IntToStr(id_packlin_bulto_new) +
              ',sulinea=' + dm.qLineaPackOld.FieldByName('sulinea').AsString +
              ',att=' + dm.qLineaPackOld.FieldByName('att').AsString +
              ',n_parcial=' + dm.qLineaPackOld.FieldByName('n_parcial').AsString +
              ',id_lote=' + dm.qLineaPackOld.FieldByName('id_lote').asstring);
           finally
              Free;
           end;
         end;

      end else begin
        n_linea:=1;
      end;

    //* FIN NUEVA LINEA EN PACKLIN *//

        qry := '';

        with tpfibquery.create(Self) do                         //Actualiza Datos de linea de packing old
        try
          Database:=dm.db;
          Transaction:=dm.t_write;

          qry := 'update a_packlin ';

          if dm.qLineaPackOld.FieldByName('cantidad_i').AsInteger<>edUds.Value then
            qry := qry + 'set cantidad=cantidad-:cantidad, cantidad_i=cantidad_i-:cantidad '
          else
            qry := qry + 'set id_packlin_bulto=:id_packlin_bulto_new ';

          qry := qry +
            'where id_packlin_bulto=:id_packlin_bulto and id_articulo=:id_articulo and cantidad=cantidad_i and ' +
            'id_packcab=:id_packcab and id_agrupa=:id_agrupa and ' +
            'nivel_agr=:nivel_agr';

          sql.add(qry);

          ParamByName('id_packcab').AsInteger := id_packcab;
          ParamByName('id_agrupa').AsInteger := id_agrupa;
          ParamByName('nivel_agr').AsInteger := nivel_agr;
          ParamByName('id_packlin_bulto').AsInteger:=id_packlin_bulto_old;
          ParamByName('id_articulo').AsInteger:=edIdArt.Value;
          if dm.qLineaPackOld.FieldByName('cantidad_i').AsInteger=edUds.Value then
               ParamByName('id_packlin_bulto_new').AsInteger:=id_packlin_bulto_new
          else
               ParamByName('cantidad').AsInteger:= edUds.Value;
          dm.t_write.StartTransaction;
          execquery;
          dm.t_write.commit;

          insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab',qry,'Update Packlin Old',
          log_cabecera +
          ' id_packlin_bulto=' + IntToStr(id_packlin_bulto_old) + 'id_articulo=' + IntToStr(edIdArt.Value) +
          ',id_packlin_bulto_new=' + IntToStr(id_packlin_bulto_new) + ',cantidad=' + IntToStr(eduds.Value));
        finally
          Free;
        end;


    with tpfibquery.create(Self) do                         //Actualiza Datos de lineas de packing
    try
      Database:=dm.db;
      Transaction:=dm.t_write;

      qry := 'update a_packlin l set l.id_packlin_bulto=:id_packlin_bulto_new '+
             'where l.id_packcab=:id_packcab and l.id_agrupa=:id_agrupa and l.nivel_agr=:nivel_agr '+
             'and l.codalbaran=:codalbaran and cantidad<>cantidad_i';
      sql.Add(qry);
      ParamByName('id_packlin_bulto_new').AsInteger:=id_packlin_bulto_new;
      ParamByName('id_packcab').AsInteger:=id_packcab;
      ParamByName('id_agrupa').AsInteger:=id_agrupa;
      ParamByName('nivel_agr').AsInteger:=nivel_agr;
      ParamByName('codalbaran').AsInteger:=codalbaran;

      dm.t_write.StartTransaction;
      execquery;
      dm.t_write.commit;

      insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab',qry,'Update Packlin',
      log_cabecera +
      ' id_packlin_bulto_new=' + intToStr(id_packlin_bulto_new) +
      ',codalbaran=' + intToSTR(codalbaran));
    finally
      Free;
    end;
                                                                                                         //Imprime etiq prev de caja nueva
    if etiq_prev then print_etiq_pre(IntToStr(codalbaran), caja,
                        IntToStr(codrepartidor), IntToStr(ruta),
                        cdsreparto.FieldByName('num_cajas').asinteger,id_packlin_bulto_new,n_bulto,uds_alb);

    lb_cajas_st.Visible:=true;
    lb_cajas_st.Caption:='Nueva Caja - ' + caja;

    if FileExists(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+'-Nueva_Caja.wav') then
      sndPlaySound(PChar(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+'-Nueva_Caja.wav'),SND_NODEFAULT Or SND_ASYNC);

    Sleep(1500);

    case indexstr(caja,['A','B','C','D','E']) of
      0:begin
        if FileExists(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+'-A.wav') then
          sndPlaySound(PChar(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+'-A.wav'),SND_NODEFAULT Or SND_ASYNC);
      end;
      1:begin
        if FileExists(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+'-B.wav') then
          sndPlaySound(PChar(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+'-B.wav'),SND_NODEFAULT Or SND_ASYNC);
      end;
      2:begin
        if FileExists(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+'-C.wav') then
          sndPlaySound(PChar(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+'-C.wav'),SND_NODEFAULT Or SND_ASYNC);
      end;
      3:begin
        if FileExists(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+'-D.wav') then
          sndPlaySound(PChar(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+'-D.wav'),SND_NODEFAULT Or SND_ASYNC);
      end;
      4:begin
        if FileExists(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+'-E.wav') then
          sndPlaySound(PChar(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+'-E.wav'),SND_NODEFAULT Or SND_ASYNC);
      end;
    end;


  dm.q_packagr.Close;
  dm.q_packagr.Open;

  dm.q_pack.Close;
  dm.q_pack.Open;

  dm.q_pack_leido.Close;
  dm.q_pack_leido.Open;

  act_cajas;

  dm.q_pack_leido.First;
  reparte(edIdArt.Value,'R');
  insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','PackAb.NewBulto.Reparto(R) ' + IntToStr(edIdArt.Value),
             log_cabecera);
  ed_cb.SetFocus;
end;

procedure Tf_main.get_cliente_config(id_cliente:integer);
begin

      with TpFIBDataSet.Create(self) do
      try
        Database:=dm.db;
        SQLs.SelectSQL.Clear;
        sqls.SelectSQL.Add('select * from get_clientes_config(:id_cliente)');
        ParamByName('id_cliente').AsInteger := id_cliente;
        Open;
        First;

        if not IsEmpty then
        begin
           tipo_adjunto := FieldByName('tipo_adjunto').AsString;
           cliente_grupo := FieldByName('cliente_grupo').AsInteger;
           cl_nombre_gr := FieldByName('cl_nombre_gr').AsString;
           pie_hoja_pick := FieldByName('pie_hoja_pick').AsString;
           envia_delivered := (FieldByName('envia_delivered').AsInteger=1);
           php_delivered := FieldByName('php_delivered').AsString;
           datos_delivered := FieldByName('datos_delivered').AsString;
           log_delivered := FieldByName('log_delivered').AsString;
           marca_delivered := FieldByName('marca_delivered').AsInteger;
           if usuario.id>-1 then
               punteo_almacen_usu := usuario.id
           else
               punteo_almacen_usu := FieldByName('punteo_almacen_usu').AsInteger;
           punteo_almacen_est := FieldByName('punteo_almacen_est').AsInteger;
           punteo_almacen_obs := FieldByName('punteo_almacen_obs').AsString;

           dir_temp := FieldByName('dir_temp').AsString;
           LoadConfigCliente(FieldByName('items').AsString);
        end;
      finally
        free;
      end;
end;

procedure Tf_main.LoadConfigCliente(items: string);
var
  f_type, order_ok, datos_ag: string;
  i: integer;
  stream: TStream;
  str_agencia: TStringDynArray;
  item_list, par: TStringList;
  item_name, item_value: string;
begin

  item_list := TStringList.Create;
  item_list.Delimiter := '$';
  item_list.DelimitedText := items;

  if item_list.Count > 0 then
  begin
    par := TStringList.Create;
    par.Delimiter := '|';

    for i := 0 to item_list.Count - 1 do
    begin
      par.DelimitedText := item_list[i];

      if UpperCase(par[0]) = 'TIENE_ADJUNTOS' then
        tiene_adjuntos := (par[1] = '1');
      if UpperCase(par[0]) = 'LOGO_ETIQ' then
        logo_cli_etiq := StrToInt(par[1]);
      if UpperCase(par[0]) = 'REVISA_LOTES' then
        revisa_lotes := (par[1] = '1');
      if UpperCase(par[0]) = 'API_USER' then
        cli_api_user := (par[1]);
      if UpperCase(par[0]) = 'API_PASS' then
        cli_api_pass := (par[1]);
      if UpperCase(par[0]) = 'API_URL' then
        cli_api_url := (par[1]);
      if UpperCase(par[0]) = 'PACK_CH_1MARCATODO' then
        ch_1marcatodo := (par[1] = '1');
      if UpperCase(par[0]) = 'PACK_CH_1MARKALL_CHK' then
        ch_1marcatodo_chk := (par[1] = '1');
      if UpperCase(par[0]) = 'MAIL_ERROR' then
        mail_error := (par[1]);
      if UpperCase(par[0]) = 'LOG_PA' then
        log_app := (par[1]);
      if UpperCase(par[0]) = 'ENVIA_EMAIL' then
        envia_correo_a_dst := (par[1]='1');
      if UpperCase(par[0]) = 'MAIL_LOGO_CLI' then
        mail_logo_cli:= par[1];
      if UpperCase(par[0]) = 'MAIL_NOMBRE_CLI' then
        mail_nombre_cli:= par[1];
      if UpperCase(par[0]) = 'MAIL_MAIL_INFO' then
        mail_mail_info:= par[1];
      if UpperCase(par[0]) = 'MAIL_ORDER_NAME' then
        mail_order_name := par[1];
      if UpperCase(par[0]) = 'MAIL_FROM' then
        mail_from := par[1];
      if UpperCase(par[0]) = 'COPIA_OCULTA' then
        copia_oculta := par[1];
      if UpperCase(par[0]) = 'TIENE_LOTES' then
        tiene_lotes := (par[1]='1');
      if UpperCase(par[0]) = 'TIENE_IMEI' then
        tiene_imei := (par[1]='1');
      if UpperCase(par[0]) = 'LGS_API_URL' then
        lgs_api_url := par[1];
      if UpperCase(par[0]) = 'LGS_API_USER' then
        lgs_api_user := par[1];
      if UpperCase(par[0]) = 'LGS_API_PASS' then
        lgs_api_pass := par[1];
      if UpperCase(par[0]) = 'LGS_API_PEDIDO' then
        lgs_api_pedido := par[1];
      if UpperCase(par[0]) = 'CL_PADRES' then
        cl_padres := splitstring(par[1],',');
      if UpperCase(par[0]) = 'CL_HIJOS' then
        cl_hijos := splitstring(par[1],',');
    end;
  end;
end;

procedure Tf_main.enviar_email_a_destino(id_albaran:integer);
var
  ruta, dest, asunto, path, filename:string;
  cuerpo:tstrings;
  mail: Tf_envia_mail;
  id_pedido: Integer;
begin

       //Si existe un pedido de almacen con este albarán podemos usar el procedimiento GET_EMAIL_PEDIDO
       id_pedido := GetIdPedidoXAlbaran(id_albaran,id_cliente);

       if id_pedido>0 then
       begin
           if GetExtraPedido(id_pedido,'DATE_MAIL_DEST')='' then
                enviar_email_pedidos(id_pedido);
       end
       else
       begin
            enviar_email_albaran(id_albaran);
       end;

end;


procedure Tf_main.enviar_email_pedidos(id_pedido:integer);
var
  dest, asunto, path, filename, attach:string;
  email:Tf_envia_mail;
  cuerpo:tstrings;
  nombre: string;
  codalbaran, id_attach: Integer;
begin
    try
        cuerpo:=tstringlist.Create;

        with dm.spGetEmail do
        begin
           Close;
           ParamByName('id_pedido').AsInteger := id_pedido;
           ExecProc;
           dest := ParamByName('email_dest').AsString;
           asunto := ParamByName('email_subject').AsString;
           cuerpo.Add(ParamByName('email_body').AsString);
        end;

        if cuerpo[0]<>'' then
        begin

          codalbaran := GetAlbaranPedido(id_pedido);

          if chAdjunto.Checked then
          begin

             path:=u_globals.ruta_exe+'temp\'+formatdatetime('yyyy.mm.dd',now);
             filename:=path+'\'+inttostr(codalbaran)+'.pdf';

             ForceDirectories(path);

             dm_pick.imprime_hoja_pick('f',filename,tiene_lotes,codalbaran);
          end;

          if tiene_adjuntos then
             attach := dmDescargaAttach.ObtenAttach(IntToStr(id_pedido),'pdf','S',id_attach);

          if attach='' then
          begin
            email:=Tf_envia_mail.create(self);
            email.Show;
            email.envia_email(dest,copia_oculta,asunto,filename,mail_from,cuerpo);

            inserta_pedido_extra(id_pedido,'DATE_MAIL_DEST',
            'dest='+dest+'|cco='+copia_oculta+'|asunto='+asunto+'|file='+filename+'|cuerpo='+cuerpo[0]);

            insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','EnvioMailDest.Ped='+inttostr(id_pedido)+ ' Alb=' + inttostr(codalbaran),
            'dest='+dest+'|cco='+copia_oculta+'|asunto='+asunto+'|file='+filename+'|cuerpo='+cuerpo[0]);
          end else begin
                      email:=Tf_envia_mail.create(self);
                      email.Show;
                      email.envia_email(dest,copia_oculta,asunto,attach,mail_from,cuerpo);

                      inserta_pedido_extra(id_pedido,'DATE_MAIL_DEST',
                      'dest='+dest+'|cco='+copia_oculta+'|asunto='+asunto+'|attach='+attach+'|cuerpo='+cuerpo[0]);

                      insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','EnvioMailDest.Ped='+inttostr(id_pedido)+ ' Alb=' + inttostr(codalbaran),
                      'dest='+dest+'|cco='+copia_oculta+'|asunto='+asunto+'|attach='+attach+'|cuerpo='+cuerpo[0]);
                   end;

         if chAdjunto.Checked then
               DeleteFile(filename);

         if FileExists(dir_temp+IntToStr(main_cli)+'\'+IntToStr(id_pedido)+'.pdf') then
            DeleteFile(dir_temp+IntToStr(main_cli)+'\'+IntToStr(id_pedido)+'.pdf');

         email.close;
         email.Free;

         IntToStr(barcode)
        end;
    finally
        cuerpo.Free;
    end;
end;


procedure Tf_main.enviar_email_albaran(codalbaran:integer);
var
  path, filename, dest, asunto:string;
  email:Tf_envia_mail;
  cuerpo:tstrings;
  nombre: string;
begin
    try
        filename := '';

        if chAdjunto.Checked then
        begin
           path:=u_globals.ruta_exe+'temp\'+formatdatetime('yyyy.mm.dd',now);
           filename:=path+'\'+inttostr(codalbaran)+'.pdf';

           ForceDirectories(path);

           if tipo_adjunto='HP' then
                dm_pick.imprime_hoja_pick('f',filename,tiene_lotes,codalbaran);
        end;

        cuerpo:=tstringlist.Create;

        with dm.spGetEmailAlbaran do
        begin
           Close;
           ParamByName('id_albaran').AsInteger := codalbaran;
           ExecProc;
           dest := ParamByName('email_dest').AsString;
           asunto := ParamByName('email_subject').AsString;
           cuerpo.Add(ParamByName('email_body').AsString);
           //copia_oculta := 'desarrollo@loginser.com;sistemas@loginser.com;gerencia@loginser.com';

        end;

        email:=Tf_envia_mail.create(self);

        if dest<>'' then
        begin
          email.Show;
          email.envia_email(dest,copia_oculta,asunto,filename,mail_from,cuerpo);
          insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','EnvioMailDestAlb ' + inttostr(codalbaran),
          'dest='+dest+'|cco='+copia_oculta+'|asunto='+asunto+'|file='+filename+'|cuerpo='+cuerpo[0]);
        end;

        if chAdjunto.Checked then
            DeleteFile(filename);
    finally
        cuerpo.Free;
        email.close;
        email.Free;
    end;
end;

procedure Tf_main.enviar_status_delivered(out albaranes:string);
var  GetText:thSelecthilo; codalb, i:Integer;  s, php_status_copy:string;     log:tstringlist;
     datos: TStringDynArray;
begin
  log:=tstringlist.create();
  albaranes := '';
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select codalbaran,order_name '+
      'from c_pedidos '+
      'where estado in (''G'',''E'') and enviado_fich=1 and id_cliente=:id_cliente');

    ParamByName('id_cliente').AsInteger:=id_cliente;
    Open;

    first;
    while not(eof) do begin
      codalb:=FieldByName('codalbaran').AsInteger;
      dm.qtempgest.Close;
      dm.qtempgest.SelectSQL.clear;
      dm.qtempgest.SelectSQL.add('select first 1 id_tracking  '+
        'from alb_tracking ae '+
        'where ae.id_albaran=:id_albaran '+
        '  and ae.estado in (2,9,12,15,23,36,39,53,54,55,56,57,58,66,82,95,151) order by fecha desc');
      dm.qtempgest.ParamByName('id_albaran').value:=codalb;
      dm.qtempgest.open;

      if not(dm.qtempgest.IsEmpty) then begin

        php_status_copy := php_delivered;
        //Sustituir valores (())
        php_status_copy := StringReplace(php_status_copy,'((order_name))',fieldbyname('order_name').AsString,[rfReplaceAll]);

        GetText:=ThSelectHilo.Create(true);
        GetText.FreeOnTerminate:=True;
        s := php_status_copy;
        GetText.strurl:=s;
        hiloactivo:=True;
        GetText.Resume;
        while hiloactivo do Application.ProcessMessages;

        datos:=splitstring(datos_delivered,'|');
        for I := Low(datos) to High(datos) do
        begin
          datos[i] := StringReplace(datos[i],'((now))',formatdatetime('dd/mm/yyyy hh:nn:ss',now),[rfReplaceAll]) + fieldbyname('order_name').AsString;
          datos[i] := StringReplace(datos[i],'((php_delivered))',php_status_copy,[rfReplaceAll]);
          datos[i] := StringReplace(datos[i],'((html_devuelto))',htmldevuelto,[rfReplaceAll]);
          log.add(datos[i]);
        end;

        albaranes := albaranes + FieldByName('codalbaran').AsString + ',';

      end;

      next;
    end;

    Free;
  end;

  if log.Count>0 then
     log.savetofile(StringReplace(log_delivered,'((now))',formatdatetime('ddmmyyyy-hhnnsszzz',now),[rfReplaceAll]));
  log.free;
end;


function Tf_main.CreaMensaje(Sender: TObject; art,lote,uds,caja,alb:string):TModalResult;
var
  AMsgDialog: TForm;
  lbl:Tlabel;
  btn:TButton;
  img:TImage;
  chk:TCheckBox;
  msg:string;
begin
  //SetWindowPos(handle, hwnd_topmost,0,0,0,0, swp_nomove or swp_nosize);

  msg := 'Caja: ' + caja + '       Alb.:' + alb + #10#13 + #10#13 +
         'Lote:' + #10#13 + '     ' + lote + #10#13 + #10#13 +
         'Uds.: 1 (Previsto ' + uds + ' uds.)' + #10#13 + #10#13 +
         '¿ES CORRECTO?';

  AMsgDialog := CreateMessageDialog(msg, mtWarning, [mbYes, mbNo, mbAll]) ;
  //AMsgDialog.BorderIcons := [];
  AMsgDialog.Caption := 'ARTICULO: ' + art ;
  //AMsgDialog.Top := Top + 200;
 // AMsgDialog.Left := Left + 200;

  // Cambiar el ancho
  AMsgDialog.Width := 580;
  AMsgDialog.Height := AMsgDialog.Height * 2;

  // Modificar el mensaje
  lbl := TLabel(AMsgDialog.FindComponent('Message'));
  lbl.Font.Style := lbl.Font.Style + [fsBold];
  lbl.Font.Size := 20;
  lbl.Font.Color := clRed;
  lbl.Width := AMsgDialog.Width -50;

  // Modificar el YES
  btn := TButton(AMsgDialog.FindComponent('YES'));
  btn.Font.Style := btn.Font.Style + [fsBold] ;
  btn.Font.Size := 14;
  btn.Caption := 'SI';
  btn.Top := btn.Top + 190;
  btn.Left := 75;
  btn.Width := 50;
  btn.Height := 50;

  // Modificar el Todos
  btn := TButton(AMsgDialog.FindComponent('ALL'));
  btn.Font.Style := btn.Font.Style + [fsBold];
  btn.Font.Size := 14;
  btn.Caption := 'Confirmar ' + uds + ' uds.';
  btn.Top := btn.Top + 190;
  btn.Left := 275;
  btn.Width := 250;
  btn.Height := 50;

    // Modificar el NO
  btn := TButton(AMsgDialog.FindComponent('NO'));
  btn.Font.Style := btn.Font.Style + [fsBold];
  btn.Font.Size := 14;
  btn.Caption := 'NO';
  btn.Top := btn.Top + 190;
  btn.Left := 175;
  btn.Width := 50;
  btn.Height := 50;


  // Modificar la imagen
 { img := TImage(AMsgDialog.FindComponent('Image'));
  img.Stretch := true;
  img.Picture.LoadFromFile('r:\neftali.bmp');    }

  // Añadir un CheckBox
  {chk := TCheckBox.Create(AMsgDialog);
  chk.Parent := AMsgDialog;
  chk.Caption := 'No volver a &recordarmelo.';
  chk.Width := 200;
  AMsgDialog.Height := AMsgDialog.Height + 30;
  chk.Left := 15;
  chk.Top := AMsgDialog.Height - 20 - 30;    }

  AMsgDialog.FormStyle := fsStayOnTop;
  result := AMsgDialog.ShowModal;

  AMsgDialog.Free;

end;


procedure Tf_main.SolucionLoteSI(id_art:Integer);
begin
    insertalog(usuario.id,id_packcab,0,pc.nombre,pc.ip,log_app,'id_packcab','','PackAb. Pulsado botón SI al confirmar lotes. Art: ' + IntToStr(id_art),
               log_cabecera + '  ' + LbLoteArtCod.Caption + ' ' + LbLoteArtNom.Caption+ ' Lote:' + lbLoteLote.Caption + ' ' + lbLoteCad.Caption + ' Uds.:' + lbLoteUds.Caption);

    LecturaConLoteConfirmado(LbLoteArtNom.Caption,
                             LbLoteArtCod.Caption,
                             lbLoteLote.Caption,
                             bcInUse,
                             edCadOculto.Date,
                             id_art,
                             edLineaOculto.Value,
                             StrToInt(lbLoteAlb.Caption),
                             edRepartOculto.Value,
                             0);


end;

procedure Tf_main.SolucionLoteNO(id_art:Integer);
begin
  try
    insertalog(usuario.id,id_packcab,0,pc.nombre,pc.ip,log_app,'id_packcab','','PackAb. Pulsado botón NO al confirmar lotes. Art: ' + IntToStr(id_art),
               LbLoteArt.Caption + ' Lote:' + lbLoteLote.Caption + ' ' + lbLoteCad.Caption + lbLoteUds.Caption +
               log_cabecera);
    UpdateArtBloqueado(id_art,1);

  except on e:Exception do
    raise Exception.Create('Error al bloquear artículo.');
  end;

end;

procedure Tf_main.SolucionLoteTodos(id_art:Integer);
begin
   insertalog(usuario.id,id_packcab,0,pc.nombre,pc.ip,log_app,'id_packcab','','PackAb. Pulsado botón TODOS al confirmar lotes. Art: ' + IntToStr(id_art),
              log_cabecera + ' ' + LbLoteArtCod.Caption + ' Lote:' + lbLoteLote.Caption + ' ' + lbLoteCad.Caption + ' Uds:' + lbLoteUds.Caption);

       LecturaConLoteConfirmado(LbLoteArtNom.Caption,
                             LbLoteArtCod.Caption,
                             lbLoteLote.Caption,
                             bcInUse,
                             edCadOculto.Date,
                             id_art,
                             edLineaOculto.Value,
                             StrToInt(lbLoteAlb.Caption),
                             edRepartOculto.Value,
                             2)
end;

function Tf_main.RevisaLotes(art_cod,art_nom,lote,caja,alb,cad:string;id_art,uds:Integer):Integer;
var
  res:TmodalResult;
begin
  Result := -2;

  pnLotes.Visible := True;

  lbLoteCaja.caption := caja;
  lbLoteAlb.Caption := alb;
  lbLoteArtCod.caption := art_cod;
  lbLoteArtNom.caption := art_nom;
  lbLoteLote.Caption := lote;
  lbLoteCad.Caption := cad;
  lbLoteUds.Caption := '1     (Previsto ' + IntToStr(uds) + ' uds.)';
  btLoteTodo.Caption := 'Confirmar ' + IntToStr(uds) + ' uds.';
  edIdArt.Text := IntToStr(id_art);

  {res := CreaMensaje(Self,art,lote,IntToStr(uds),caja,alb);

  case res of
    mrYes: begin
            SolucionLoteSI;
            Result := 0;
    end;
    mrNo: begin
            SolucionLoteNO(id_art);
            Result := -1;
    end;
    mrAll: begin
            SolucionLoteTodos;
            Result := 2;
    end;
    mrCancel: begin
            Result := 3;
    end;
  end;   }



end;


function Tf_main.IntroBarcode: Integer;
var
  valido: Boolean;
begin
  valido := false;

  while not valido do


        edInput.BoundLabel.Caption := '';
        pnInput.Visible := True;

end;

procedure TF_main.LanzaMensajeError(bc,mensaje:string);
begin
  gb_asig.Visible  := false;
  gb_error.Visible := true;
  bt_add.Visible   := false;
  lb_ean.Caption   := bc;
  lb_st.Caption    := mensaje;
  if FileExists(ruta_exe+'Audio\Error.wav') then sndPlaySound(PChar(ruta_exe+'Audio\Error.wav'),SND_NODEFAULT Or SND_ASYNC);
end;

procedure Tf_main.LecturaConLoteConfirmado(nombre,codigo,n_lote,bc:string; caducidad:TDateTime; id_art,linea,codalbaran,codrepartidor,revision:integer);
var
  id_pedido, i: integer;
  pedidos: TStringList;
  date_aux: TDateTime;
  hora_aux: TTime;
  qry, rev_aux, error_aux: string;
begin
  pedidos := TStringList.Create;

  date_aux := Date;
  hora_aux := Time;
  qry := '';

  case revision of
     0: rev_aux := 'Si';
     2: rev_aux := 'Todo';
     else rev_aux := '';
  end;

  if only_one then begin                        //**********************de 1 sola unidad
    gb_asig.Visible:=true;
    gb_error.Visible:=false;
    lb_asig.Caption:= nombre;
    lb_asig_art.Caption:='Código '+ codigo +' - EAN '+bc;
    lb_asig_lote.caption:='Lote '+ n_lote +' '+formatdatetime('dd/mm/yy', caducidad);

    with tpfibquery.create(Self) do                 //ACTUALIZA INDIV
    try
      Database:=dm.db;
      Transaction:=dm.t_write;
      sql.Add('update a_packlin set cantidad_i=1, fecha_i=:fecha_i, hora_i=:hora_i, id_usuario_i=:id_usuario_i, pc=:pc, situacion=''A'' '+
        'where id_packcab=:id_packcab and id_agrupa=:id_agrupa and nivel_agr=:nivel_agr and linea=:linea');
      ParamByName('id_packcab').AsInteger:=id_packcab;
      ParamByName('id_agrupa').AsInteger:=id_agrupa;
      ParamByName('nivel_agr').AsInteger:=nivel_agr;
      ParamByName('linea').AsInteger:=linea;
      ParamByName('fecha_i').AsDate:=date_aux;
      ParamByName('hora_i').AsTime:=hora_aux;
      //ParamByName('id_usuario_i').AsInteger:=u_globals.id_usuario;
      ParamByName('id_usuario_i').AsInteger := usuario.id;
      ParamByName('pc').AsString:=pc.nombre;

      qry := sql[0];

      dm.t_write.StartTransaction;
      execquery;
      dm.t_write.commit;
      insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab',
      qry,'PackAb.1El.RevLote' + rev_aux + '. Lectura ',
      log_cabecera +
      '|linea=' + IntToStr(linea) + '|fecha_i=' + FormatDateTime('dd.mm.yy',date_aux) + '|hora_i=' +  FormatDateTime('hh:nn:ss',hora_aux) +
      '|id_usuario_i=' + IntToStr(usuario.id) + '|pc=' + pc.nombre);
    finally
      Free;
    end;

    if chEtXLect.Checked then
    begin
      cerrar_albaran(codalbaran);

      if codrepartidor<46000 then
      begin
         //if CargarDatosTablaGestoras('agencias','lstname_etiqueta','agencia='+ CargarDatosTablaGestoras('albaranes','agencia','id_albaran='+FieldByName('codalbaran').AsString))='ETI_LOGINSER' then
         if dmLabels.GetFormatoEtiqueta(codalbaran)='ETI_LOGINSER' then
         begin
           dmLabels.imp_eti := u_globals.imp_eti;
           try
            dmLabels.imprime_etiqueta_loginser(codalbaran,0, logo_cli_etiq);
            insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','PackAb.1El.EtXLect.RevLote' + rev_aux + '. EtLgs. ' + IntToStr(codalbaran),log_cabecera + '|linea=' + IntToStr(linea));
           except on e:exception do begin
                    InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','PackAb.1El.EtXLect.RevLote Et.Lgs.Error ' + IntToStr(codalbaran) ,e.message);
                    raise Exception.Create('Error Et.Lgs ' + #13#10 + e.message);
                  end;
           end;

         end
         else begin
           try
             imprime_etiqueta_x_api(codalbaran);
             insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','PackAb.1El.EtXLect.RevLote' + rev_aux + '. EtAPI. ' + IntToStr(codalbaran),log_cabecera + '|linea=' + IntToStr(linea));
           except on e:exception do begin
                  InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','PackAb.1El.EtXLect.RevLote Et.API.Error ' + IntToStr(codalbaran) ,e.message);
                  raise Exception.Create('Error generando bultos API. ' + #13#10 + e.message);
                end;
           end;
         end;
      end else begin
            if codrepartidor=46120 then
                 imprime_eti_bulto_asm(codalbaran)
            else
                 imprime_eti_bulto(codalbaran);
            insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','PackAb.1El.EtXLect.RevLote' + rev_aux + '. EtBulto. ' + IntToStr(codalbaran),log_cabecera + '|linea=' + IntToStr(linea));
      end;

      if chHojaPick.Checked then
      begin
        imprime_hoja_pick(codalbaran);
        //insertalog(usuario.id,0,0,PC.Nombre, PC.IP,'','','','PackAb.1El.EtXLect.RevLote' + rev_aux + '. HPick. ' + IntToStr(codalbaran),log_cabecera + ',linea=' + IntToStr(linea));
      end;

      if revisa_lotes and chRevLotes.Checked then
      begin
         id_pedido := GetIdPedidoXAlbaran(codalbaran,id_cliente);

         if id_pedido>0 then
         begin
             pedidos.Add(IntToStr(id_pedido));

             insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','PackAb.1El.EtXLect.RevLote' + rev_aux + '. Ini.Act.Lotes Ped.' + IntToStr(id_pedido),log_cabecera + '|linea=' + IntToStr(linea));
             if StrToInt(cl_padres[0])>0 then
             begin
               i := 0;
               while (i<=High(cl_padres)) do
               begin
                  frmLotes.ActualizaLotes(main_cli,STrToInt(cl_padres[i]),usuario.id,pedidos,lbNombreCl.Caption,PC.Nombre,PC.IP);
                  Inc(i);
               end;
             end else
                   frmLotes.ActualizaLotes(main_cli,StrToInt(cl_padres[0]),usuario.id,pedidos,lbNombreCl.Caption,PC.Nombre,PC.IP);
             insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','PackAb.1El.EtXLect.RevLote' + rev_aux + '. Fin.Act.Lotes Ped.' + IntToStr(id_pedido),log_cabecera + '|linea=' + IntToStr(linea));

             insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','PackAb.1El.EtXLect.RevLote' + rev_aux + '. Ini.Env.Lotes Ped.' + IntToStr(id_pedido),log_cabecera + '|linea=' + IntToStr(linea));
             if StrToInt(cl_padres[0])>0 then
             begin
               i := 0;
               while (i<=High(cl_padres)) do
               begin
                  cli_api_url := get_item_config_cliente(StrToInt(cl_padres[i]),'api_url');
                  cli_api_user := get_item_config_cliente(StrToInt(cl_padres[i]),'api_user');
                  cli_api_pass := get_item_config_cliente(StrToInt(cl_padres[i]),'api_pass');
                  frmlotes.EnviaLotes(pedidos,lbNombreCl.Caption,PC.Nombre,PC.IP,0,StrToInt(cl_padres[i]),cli_api_url,cli_api_user,cli_api_pass);
                  Inc(i);
               end;
             end else
                  frmlotes.EnviaLotes(pedidos,lbNombreCl.Caption,PC.Nombre,PC.IP,0, main_cli,cli_api_url,cli_api_user,cli_api_pass);
             insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','PackAb.1El.EtXLect.RevLote' + rev_aux + '. Fin.Env.Lotes Ped.' + IntToStr(id_pedido),log_cabecera + '|linea=' + IntToStr(linea));
         end;
      end;

      if cb_send_email.Checked and (get_email_albaran(codalbaran)<>'') then
      begin
        enviar_email_a_destino(codalbaran);
        InsertaLog(usuario.id,id_packcab,0,PC.Nombre,PC.IP,log_app,'id_packcab','','PackAb.1El.EtXLect.RevLote Email ' + IntToStr(codalbaran) ,log_cabecera);
      end;

      with tpfibquery.create(Self) do                         //Actualiza Datos
          try
            Database:=dm.db;
            Transaction:=dm.t_write;
            sql.Add('update c_pedidos set estado=:estado, fecha_fin=:fecha '+
              ' where id_cliente=:id_cliente and codalbaran=:codalbaran ');
            ParamByName('codalbaran').AsInteger := codalbaran;
            ParamByName('id_cliente').AsInteger := main_cli;
            parambyname('estado').AsString := 'E';
            ParamByName('fecha').AsDateTime:=Now;

            dm.t_write.StartTransaction;
            execquery;
            dm.t_write.commit;

            insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','PackAb.1El.EtXLect.RevLote' + rev_aux + ' Est.Ped.=E Alb=' + IntToStr(codalbaran),
            log_cabecera + '|linea=' + IntToStr(linea))
          finally
            Free;
          end;

        error_aux := '';
        error_aux := inserta_estado_albaran(codalbaran,punteo_almacen_usu, punteo_almacen_est,punteo_almacen_obs + ' EtXLect.1El.LtOk.');

        if error_aux = '' then
          insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','PackAb.1El.NoAll.EtXLect.RevLote. EstadoAlb.' + IntToStr(codalbaran),
                    'user:' + IntToStr(punteo_almacen_usu) + '|estado:' + IntToStr(punteo_almacen_est) + '|obs:' + punteo_almacen_obs + '|EtXLect.1El.LtOk.'
                     + '|' + log_cabecera + '|linea=' + IntToStr(linea))
        else
          insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','PackAb.1El.NoAll.EtXLect.RevLote. EstadoAlb.' + IntToStr(codalbaran) + ' Error',
                   'user:' + IntToStr(punteo_almacen_usu) + '|estado:' + IntToStr(punteo_almacen_est) + '|obs:' + punteo_almacen_obs + '|EtXLect.1El.LtOk.'
                   + '|' + log_cabecera + '|linea=' + IntToStr(linea) + ' ' + error_aux);

    end;

    lbReparto.Caption := 'Reparto COMPLETO ' + #13#10 + nombre;
    reparte(id_art,'I');
    insertalog(usuario.id,id_packcab,0,PC.Nombre, PC.IP,log_app,'id_packcab','','PackAb.1El.RevLote. Reparto(I) Art:' + IntToStr(id_art),
                        log_cabecera);

  end else begin                                                    //***********************albs de mas de una unidad

              gb_asig.Visible:=true;
              gb_error.Visible:=false;

              ver_imagen(id_art);

              if (revision=2) then
                      mark_one(nombre,codigo,bc,edTipoCajaOculto.Text,
                    edIdCajaOculto.Value,codalbaran,linea,true,true,
                    edIdLoteOculto.Value,n_lote,caducidad,edUdsOculto.Value)
              else if (revision=0) then
                    mark_one(nombre,codigo,bc,edTipoCajaOculto.Text,
                  edIdCajaOculto.Value,codalbaran,linea,true,true,
                  edIdLoteOculto.Value,n_lote,caducidad,1);
           end;


        dm.q_packagr.Close;
        dm.q_packagr.Open;

        dm.q_pack.Close;
        dm.q_pack.Open;
        dm.q_pack.Locate('codalbaran;codigo',VarArrayOf([codalbaran,codigo]),[]);

        dm.q_pack_leido.Close;
        dm.q_pack_leido.Open;

        lb_st1.Caption := 'Esperando siguiente artículo...';

  pedidos.Free;
end;

procedure Tf_main.bloquea(int:Integer);
begin
    bt_cerrar_caja.enabled := (int=1);
    bt_cambio.enabled := (int=1);
    bt_print_prev.enabled := (int=1);
    bt_imp_pick.enabled := (int=1);
    bt_print_bultos.enabled := (int=1);
    btImpAdj.enabled := (int=1);
    btPasarUds.enabled := (int=1);
    b_picking.enabled := (int=1);
    sb_1.enabled := (int=1);
    bt_cerrar_agrup.enabled := (int=1);
    ed_cb.enabled := (int=1);
    gb_12.enabled := (int=1);
    rg1.enabled := (int=1);
end;

function Tf_main.TieneLecturasPendientes(id_packcab:integer):Boolean;
begin
  with tpfibdataset.Create(dm) do begin                                //Queda algo por picar
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select coalesce(sum(l.cantidad),0) as total '+
      'from a_packlin l '+
      'where l.id_packcab=:id_packcab and l.cantidad_i<>l.cantidad ');
    ParamByName('id_packcab').asinteger:=id_packcab;
    Open;

    Result := (FieldByName('total').AsInteger>0);                   //Uds pendientes

    Free;
  end;
end;

function Tf_main.PackingFinalizado(id_packcab:integer):TDateTime;
begin
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select fecha_fin '+
      'from a_packcab '+
      'where id_packcab=:id_packcab ');
    ParamByName('id_packcab').asinteger:=id_packcab;
    Open;

    Result := FieldByName('fecha_fin').asdatetime;

    Free;
  end;
end;

end.
