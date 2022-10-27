unit u_main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, FIBDataSet, pFIBDataSet, FIBQuery, pFIBQuery, FIBDatabase,
  pFIBDatabase, StdCtrls, sButton, Mask, sMaskEdit, sCustomComboEdit, sTooledit,
  sLabel, Vcl.ComCtrls, sStatusBar, System.Win.ComObj, Datasnap.DBClient,
  sSkinProvider, sSkinManager, sGroupBox, inifiles, jpeg, JvDBGrid, IdHTTP,
  Winapi.ShellAPI, sEdit, sBitBtn, IdMultipartFormData, sGauge, sPanel, sdialogs,
  strutils, types, System.DateUtils, sPageControl, Data.DBXJSONCommon, Data.DBXJSON,
  sRadioButton, registry, sCheckBox, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, Vcl.Buttons,
  Vcl.ExtCtrls, sComboBox, frxClass, frxDBSet, frxBarcode, sSpeedButton, adodb,
  printers, winspool, Vcl.ImgList, Winapi.ActiveX, IdFTP, IdFTPCommon,
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
  acProgressBar, dxGDIPlusClasses, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdFTPList, sDBComboBox, Vcl.Menus, IdMessage,
  WinInet, Vcl.Imaging.pngimage, ScDataHandler, ScSFTPUtils, ScSFTPClient,
  ScBridge, ScSSHClient, JvBaseDlg, JvSelectDirectory, Vcl.FileCtrl, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, sSpinEdit;

type
  Tstock = record
    id_art: Integer;
    uds: Integer;
    id_ubic: Integer;
    id_lote: Integer;
    caducidad: TDate;
  end;

type
  TStockArt = record
     id_ubic, cant, id_alm, id_lote:Integer;
  end;

type
  TStock2 = array of TStockArt;

type
  TPedCabecera = record
    fechaImp, fechaPedido, nombreOrder, nombre, dir1, poblacion, provincia, cp, pais, paisCode, telefono, email, company, observaciones, clienteId, ceco, refCliente, delegDst, tipoServ, horario, bultos, peso, codAlb, estado, transporte, repartidor, contacto, reembolso, retorno, remitente: string;
  end;


  TPedLine = record
    line, id_articulo, cantidad: integer;
    sku, nombre_art: string;
  end;

    TDatosPC   = record
    Nombre, IP, Usuario :String;
  end;

   TDatosUsuario  = record
    id: Integer;
    Nombre :String;
  end;

  TReservaLote = record
    id_lote: integer;
    uds: Integer;
  end;

  TArtHerencia = record
    art_main: Integer;
    art_padre: Integer;
    id_padre: Integer;
  end;

  Tf_main = class(TForm)
    sknmngr1: TsSkinManager;
    sknprvdr1: TsSkinProvider;
    pnCOn: TsPanel;
    ga_stat: TsGauge;
    lb_st1: TsLabel;
    gr_envs: TJvDBGrid;
    lb_n: TsLabel;
    ar_pick_ds: TClientDataSet;
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
    pnCliente: TsPanel;
    pnFiltro: TsPanel;
    rg_state: TsRadioGroup;
    gb_date: TsGroupBox;
    rb_alldate: TsRadioButton;
    rb_adate: TsRadioButton;
    de_ini: TsDateEdit;
    de_fin: TsDateEdit;
    gb_search: TsGroupBox;
    bt_art1: TsSpeedButton;
    lb_art1: TsLabel;
    ed_search_order: TsEdit;
    ch_order_name: TsCheckBox;
    ed_search_albaran: TsEdit;
    ch_albaran: TsCheckBox;
    ch_articulo: TsCheckBox;
    ed_art: TsEdit;
    rg_order: TsRadioGroup;
    il1: TImageList;
    btLock: TsSpeedButton;
    pnTools: TsPanel;
    bt_nuevo: TsBitBtn;
    bt_reexp: TsBitBtn;
    gb1: TsGroupBox;
    lb_1: TsLabel;
    bt_2: TsButton;
    bt_1158: TsBitBtn;
    bt_1: TsBitBtn;
    gb2: TsGroupBox;
    bt_import_mdb: TsBitBtn;
    bt_import: TsBitBtn;
    ed_csv: TsFilenameEdit;
    gb3: TsGroupBox;
    bt_genera: TsBitBtn;
    ed_folder: TsDirectoryEdit;
    gb4: TsGroupBox;
    bt_3: TsBitBtn;
    de_1: TsDateEdit;
    bt_anular: TsBitBtn;
    lbCon: TsLabel;
    btCorreos: TsBitBtn;
    chTodos: TsCheckBox;
    devo_nac: TfrxReport;
    devo_int: TfrxReport;
    strngfld_pick_dsCodPais: TStringField;
    strngfld_pick_dsTag: TStringField;
    il2: TImageList;
    frdevo: TfrxReport;
    ar_pick_dsEsDevo: TSmallintField;
    btDevos: TsBitBtn;
    sImage1: TsImage;
    q1: TpFIBDataSet;
    blbfldq1logo: TBlobField;
    ds1: TDataSource;
    db_1: TfrxDBDataset;
    intgrfld_pick_dsid_lote: TIntegerField;
    gb5: TsGroupBox;
    btLotes: TsBitBtn;
    ar_pick_lotes: TClientDataSet;
    strngfld_pick_lotespedido: TStringField;
    intgrfld_pick_lotesid_art: TIntegerField;
    strngfld_pick_lotesref_art: TStringField;
    strngfld_pick_lotesnom_art: TStringField;
    strngfld_pick_loteslote: TStringField;
    strngfld_pick_lotescaducidad: TStringField;
    rep_db_lotes: TfrxDBDataset;
    rep_pick: TfrxReport;
    chPicking: TsCheckBox;
    btCarrito: TsBitBtn;
    rgTipoGes: TsRadioGroup;
    lb_cli: TsLabel;
    gbCliente: TsGroupBox;
    edCliente: TsEdit;
    btCliente: TsSpeedButton;
    lbCliente: TsLabel;
    gbGrupo: TsGroupBox;
    btGrupo: TsSpeedButton;
    lbgrupo: TsLabel;
    edGrupo: TsEdit;
    chPackAb: TsCheckBox;
    ed_search_idorder: TsEdit;
    ch_idorder: TsCheckBox;
    btPrintPick: TsBitBtn;
    strngfld_pick_dscontacto: TStringField;
    strngfld_pick_dsservicio: TStringField;
    strngfld_pick_dshorario: TStringField;
    dxPDF: TdxPDFViewer;
    dxprinter: TdxComponentPrinter;
    link: TdxPDFViewerReportLink;
    btEnvAgencias: TsBitBtn;
    deDir: TsDirectoryEdit;
    dl_open: TsOpenDialog;
    gb_date_gen: TsGroupBox;
    rb_alldate_gen: TsRadioButton;
    rb_date_gen: TsRadioButton;
    de_ini_gen: TsDateEdit;
    de_fin_gen: TsDateEdit;
    tmr1: TTimer;
    btFtp: TsBitBtn;
    ftp_1: TIdFTP;
    xml_1: TXMLDocument;
    cds1: TClientDataSet;
    sGroupBox1: TsGroupBox;
    rb_alldate_env: TsRadioButton;
    rb_date_env: TsRadioButton;
    de_ini_env: TsDateEdit;
    de_fin_env: TsDateEdit;
    chConRetorno: TsCheckBox;
    f2: TIdFTP;
    btSeur: TsBitBtn;
    cbAgencias: TsComboBox;
    cbPaises: TsComboBox;
    pm1: TPopupMenu;
    F5: TMenuItem;
    cbAlmacenes: TsComboBox;
    IdMessage1: TIdMessage;
    lbNoPick: TsLabel;
    img1: TImage;
    D1: TMenuItem;
    chRefCli: TsCheckBox;
    edRefCliente: TsEdit;
    btRegenerar: TsBitBtn;
    btSinStock: TsBitBtn;
    ftp: TIdFTP;
    ch1: TCheckBox;
    ch2: TCheckBox;
    frxReport1: TfrxReport;
    imgIncidencias: TImage;
    tmr2: TTimer;
    pnPtes: TsPanel;
    gr_detalle: TJvDBGrid;
    lb_n_detalle: TsLabel;
    cl: TScSSHClient;
    st: TScFileStorage;
    f: TScSFTPClient;
    btImpAdj: TsBitBtn;
    fopen: TJvSelectDirectory;
    btActExp: TsBitBtn;
    imgNuevaVer: TImage;
    tmr3: TTimer;
    tmr4: TTimer;
    chEnviarLotes: TsCheckBox;
    btEnviarLotes: TsBitBtn;
    btImpEtiq: TsBitBtn;
    edIdPedido: TsEdit;
    chIdPedido: TsCheckBox;
    bt2: TButton;
    gb6: TsGroupBox;
    chFPedTodo: TsCheckBox;
    edDiasAtras: TsSpinEdit;
    edRegIni: TsEdit;
    edRegFin: TsEdit;
    chConIncidencia: TsCheckBox;
    btAplicaFiltro: TsButton;
    btResetFiltro: TsButton;
    btConfigCliente: TsSpeedButton;
    btStock0: TsButton;
    imgs16: TImageList;
    mm1: TMainMenu;
    mnUtils: TMenuItem;
    mnAnulaStock: TMenuItem;
    dialog2: TTaskDialog;
    edNombre: TsEdit;
    mnArchivaHist: TMenuItem;
    mnPedidos: TMenuItem;
    mnModoHist: TMenuItem;
    mnAlmacen: TMenuItem;
    mnUbicsArts: TMenuItem;
    mnClientes: TMenuItem;
    mnAdjuntos: TMenuItem;
    mnActExp: TMenuItem;
    mnL1: TMenuItem;
    mnA1: TMenuItem;
    mnN1: TMenuItem;
    mnAsignaPAV: TMenuItem;
    mdAsignaPAV: TMenuItem;
    mdDesasignaPAV: TMenuItem;
    chAntonio: TCheckBox;
    lbAlertas: TsLabel;
    sPanel1: TsPanel;
    procedure rg_stateClick(Sender: TObject);
    procedure bt_import_mdbClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure servicio(Sender: TObject);
    procedure filter(modo_historico:Boolean);
    function busca_art(cod_cli: string; id_cliente: integer): integer; overload;
    function busca_art_nom(id: integer): string;
    procedure limpiar_stock;
    procedure get_stock(pedidos: string);
    function verif_stock(pedido: Integer): boolean;
    procedure descuenta_stock(pedido: Integer);
    procedure informe_sin_stock(pedidos: string);
    procedure informe_generados;
    function ruta_escritorio: string;
    function genera_picking(pedidos, peds_sin_alb: string; out errores_pick: TStringList): Boolean;
    function genera_picking_abierto(pedidos, peds_sin_alb: string; out errores_pick: TStringList): Boolean;
    function genera_picking_abierto_old(pedidos: string): Boolean;
    procedure bt_importClick(Sender: TObject);
    function format_cp(cp: string): string;
    function genera_albaranes(pedidos: string; out errores_albs, msgs_error: TStringList): Boolean;
    procedure genera_recogidas;
    function busca_art_ref(id: integer): string;
    function get_stock_x_art(id_art: Integer; id_alm:Integer=-1; id_hijo:Integer=-1): integer;
    function get_total_x_art_y_ped(id_art, id_pedido: Integer): integer;
    function gestiona_stock(pedidos: string; out errores_stock: TStringList): Boolean;
    procedure imprime_bultos;
    function siguiente_laboral(fecha: TDateTime): tdate;
    function es_festivo(fecha: TDateTime): Boolean;
    procedure envia_ficheros(todos: boolean = false);
    procedure asigna_repartidor(pedidos: string);
    function enviar_status_sent(pedidos, peds_sin_alb: string): boolean;
    procedure enviar_status_delivered(pedidos: string);
    procedure bt_1158Click(Sender: TObject);
    procedure bt_1Click(Sender: TObject);
    procedure ed_artExit(Sender: TObject);
    function busca_art_nom_cod(codigo: string): string;
    procedure bt_art1Click(Sender: TObject);
    procedure gr_envsDblClick(Sender: TObject);
    procedure bt_reexpClick(Sender: TObject);
    procedure bt_nuevoClick(Sender: TObject);
    procedure bt_anularClick(Sender: TObject);
    procedure imprime_eti_bulto_lgs(codalbaran: integer);
    function imprime_eti_bulto_asm(codalbaran, delivery_time: integer): string;
    function limpiachar(frase: string): string;
    function genera_fichero_asm(ruta: string; todos: boolean): integer;
    function linea_asm(codalbaran, delivery_time: Integer): string;
    function get_cp_ext(poblacion: string): string;
    procedure bt_2Click(Sender: TObject);
    function imprime_eti_bulto_correos(codalbaran: integer): string;
    function imprime_eti_bulto_chrono(codalbaran, delivery_time: integer): string;
    function LeerHexa(fichero: string): string;
    function Zeros(c: string; l: Integer): string;
    function Espacios(cadena: string; l: Integer): string;
    function WriteRawDataToPrinter(PrinterName: string; Str: string): Boolean;
    function genera_fichero_correos(ruta: string; todos: boolean): integer;
    function linea_correos(codalbaran: Integer): string;
    procedure bt_3Click(Sender: TObject);
    procedure rg_orderClick(Sender: TObject);
    procedure btClienteClick(Sender: TObject);
    procedure edClienteChange(Sender: TObject);
    procedure btLockClick(Sender: TObject);
    procedure btCorreosClick(Sender: TObject);
    procedure bt2Click(Sender: TObject);
    procedure btDevosClick(Sender: TObject);
    procedure btLotesClick(Sender: TObject);
    procedure btCarritoClick(Sender: TObject);
    procedure rgTipoGesClick(Sender: TObject);
    procedure btGrupoClick(Sender: TObject);
    procedure edGrupoChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btPrintPickClick(Sender: TObject);
    procedure btArchivarHistClick(Sender: TObject);
    procedure gr_envsTitleClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure deDirChange(Sender: TObject);
    procedure btEnvAgenciasClick(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure btAplicaFiltroClick(Sender: TObject);
    procedure ClickLabels(Sender: TObject);
    procedure btFtpClick(Sender: TObject);
    procedure gb3Click(Sender: TObject);
    procedure gr_envsDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btSeurClick(Sender: TObject);
    procedure cbPaisesClick(Sender: TObject);
    procedure cbAgenciasClick(Sender: TObject);
    procedure F5Click(Sender: TObject);
    procedure cbAlmacenesChange(Sender: TObject);
    procedure D1Click(Sender: TObject);
    procedure btRegenerarClick(Sender: TObject);
    procedure btSinStockClick(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure pnCOnDblClick(Sender: TObject);
    procedure tmr2Timer(Sender: TObject);
    procedure imgIncidenciasDblClick(Sender: TObject);
    procedure gr_detalleDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure fDirectoryList(Sender: TObject; const Path: string;
      const Handle: TArray<System.Byte>; FileInfo: TScSFTPFileInfo;
      EOF: Boolean);
    procedure clServerKeyValidate(Sender: TObject; NewServerKey: TScKey;
      var Accept: Boolean);
    procedure btImpAdjClick(Sender: TObject);
    procedure btActExpClick(Sender: TObject);
    procedure tmr3Timer(Sender: TObject);
    procedure tmr4Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btEnviarLotesClick(Sender: TObject);
    procedure btImpEtiqClick(Sender: TObject);
    procedure edIdPedidoChange(Sender: TObject);
    procedure chFPedTodoClick(Sender: TObject);
    procedure edDiasAtrasKeyPress(Sender: TObject; var Key: Char);
    procedure btModoHistClick(Sender: TObject);
    procedure btResetFiltroClick(Sender: TObject);
    procedure lbClienteDblClick(Sender: TObject);
    procedure btConfigClienteClick(Sender: TObject);
    procedure btStock0Click(Sender: TObject);
    procedure mnAnulaStockClick(Sender: TObject);
    procedure mnUtilsClick(Sender: TObject);
    procedure dialog2ButtonClicked(Sender: TObject; ModalResult: TModalResult;
      var CanClose: Boolean);
    procedure dialog2VerificationClicked(Sender: TObject);
    procedure mnArchivaHistClick(Sender: TObject);
    procedure mnModoHistClick(Sender: TObject);
    procedure mnUbicsArtsClick(Sender: TObject);
    procedure gr_envsEndDock(Sender, Target: TObject; X, Y: Integer);
    procedure gr_envsCellClick(Column: TColumn);
    procedure gr_envsKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pm1Popup(Sender: TObject);
    procedure mdAsignaPAVClick(Sender: TObject);
    procedure mdDesasignaPAVClick(Sender: TObject);
    procedure lbAlertasDblClick(Sender: TObject);
    //procedure cxGrid1DBTableView1DblClick(Sender: TObject);
    {procedure cxGrid1DBTableView1EditDblClick(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit);
    procedure cxGrid1DBTableView1CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);   }
  private
    { Private declarations }
    function busca_art(codigo: string): integer; overload;
    procedure CargaInterfaz;
    function JSONPost(text: string; LI: boolean): string;
    procedure EnviaACorreos;
    procedure SendEstado(id_order, albaran, estado: string);
    //function EsPedidoValido:Boolean;

    function GetMainCliGrupo(id_grupo: Integer): Integer;
    function DescargaCarrito(id_cliente: Integer): Integer;
    procedure GeneraPedidos(pedidos: string);
    procedure AbreFichero(ruta: string);
    procedure abre_detalle(modo: integer);
    //procedure ActualizaLotes(id_cliente,usu:integer;pedidos:TStringList;nom_cli,nom_pc,ip:string);
    procedure habilita_modo_historico(activar:Boolean);
    procedure filter_reset;
    procedure abre_config_cliente;
    procedure DeleteLinesStock0;
    function busca_articulo_heredado(id_art:Integer):Integer;

  public
    { Public declarations }
    procedure ImprimeEtiqueta(f, orientacion: string);
    procedure Imprime(f, orientacion: string);
    function rellena_detalle_pedido: string;
    procedure enviar_email_pedidos(id_pedido: integer);
    procedure CargarDatosCorreos;
    procedure ImprimirHojasPicking(peds: string);
    function CargarDatosAgencia(campos: string; cliente, agencia: Integer): string;
    function BuscaClienteGesFile(codigo: integer): string;
    procedure LoadConfigCliente(items: string);
    function LoadFieldConfigCLiente(campos: string; cliente: Integer): string;
    procedure act_albs(id_pickcab, id_packcab, id_agrupa, nivel_agr, cod_albaran, id_caja, id_packlin_bulto: integer);
    procedure get_pick;
    procedure add_pick(id_pedido, id_order, id_pickcab, id_packcab, id_agrupa: Integer; id_pais: string; var line_pick, line_pack: integer);
    procedure asigna_cajas(id_packcab: Integer);
    procedure agrupa_cajas(id_pickcab, id_packcab, id_agrupa: Integer);
    function get_chrono_bulto(cp: integer): string;
    function get_art_from_pick(id_art, id_ubic, uds: Integer; var lote: integer): Integer;
    procedure update_lote(id_pedido, id_articulo, id_picking, id_line, id_lote, uds: Integer);
    procedure limpiar_pick;
    function calc_digcon_chrono(codbar: string): Integer;
    function get_chrono_exp(codalbaran: integer): string;
    procedure get_defaults;
    function ubic_entrada(id_alm: Integer): Integer;
    procedure agrupa_picking_x_cajas(new_pick_cab, new_pack_cab: integer);
    procedure calcula_agrupa(new_pick_cab, new_pack_cab, id_agrupa: integer);
    procedure InsertaPedido(id_pedido, id_cliente, deliv_time, trans_propio, id_repartidor, deleg, service_ref, con_retorno: Integer; id_order, order_name, nombre, dir, poblacion, provincia, prov_code, cp, pais, pais_code, telefono, email, text, track, observaciones, financial_status, fulfillment_status, gateway, company, tags, note, cancel_reason, estado, contacto, ceco: string; fecha_ped, cancel_date: TDateTime; reemb: Double);
    procedure InsertaPedidoLine(id_pedido, id_line, id_articulo, cantidad, item_id: integer; sku, nombre_art: string);
    function BuscaReexpedicion(id_cliente: Integer; order_name: string): Integer;
    procedure send_order(pedido: Integer);
    procedure GeneraUrlValidate(id_albaran: integer);
    procedure RegeneraBultos(id_albaran: integer);
    procedure CrearFicheroSeur;
    procedure CalculaPendientes;
    procedure RecalculaPendientes;
    function gestiona_errores(pedidos: string): string;
    function busca_stock(id_art: Integer): integer;
    procedure CreaExcel;
    procedure GuardaEtiqueta(pedidos: string; txt: string; agencia: integer);
    function EnviaPedidos(pedidos: string): string;
    function EnviaPedido(pedido: integer): string;
    procedure RellenaRepartidores;
    procedure RellenaPaises;
    procedure RellenaAgencias;
    procedure RellenaAlmacenes;
    function DescuentaStockBBDD(pedidos, peds_sin_alb: string): Boolean;
    function DownloadToStream(Url: string; Stream: TStream): Boolean;
    function DownloadToBmp(Url: string; Bitmap: TBitmap): Boolean;
    function FechaPedidoMasAntiguo(pedidos: string): TDateTime;
    procedure CambiaAlbaranPedido(pedido, codalbaran, id_destino: integer);
    function mensaje(s: string): Boolean;
    //function GeneraPicking: Boolean;
    procedure borrar;
    procedure imprime_doc_cliente(pedidos,peds_sin_alb:string);
    procedure CambiaEstadoPedido(pedidos, estado_ini, estado_fin: string);
    procedure ProcesaPedidosEnTemp(sociedad:Integer; strlist:TStringList);
    procedure insertar_adjuntos(pedidos, peds_sin_alb:string);
    procedure RevisaVersion;
    procedure EnviaLotes(peds: string);
    procedure ActualizaLotes(id_cliente,usu:integer;pedidos:TStringList;nom_cli,nom_pc,ip:string);
    function ControlesCliente(cli:Integer; out resultado:string):Boolean;
   //procedure cargar_lineas_pedido;
   function ArchivarAHistorico(pedidos:string; hasta_fecha:TDate):string;
   procedure AnulaStock;
   function crea_pick_anula_stock(id_pedido:integer; ar_lines:TStringList;out errores_pick: string): Boolean;
   procedure habilita_menus(locked,modo_hist:Boolean);
   procedure informe_ubics_arts(id_cliente:Integer);
   procedure AsignaPAV(pav:string);
   function assign_pav(pav,pedidos:string):boolean;
   function gestiona_alertas:string;
  end;

const
  ALERTA = 'LISTO';
  {Listo: puede crearse exe
   Vacio: hay algo en desarrollo y no se puede crear exe}

  ln = #10#13;
  sep2 = '|';
  sep1 = '$';
  tab = Chr(9);
  cli_inf_asm = '99999';
  delivery_default = 24;
  path_pdf_correos = 'http://www.loginser.com/sync/Operadores/Correos/labels/';
  error_no_version = 'Este pedido no puede ser gestionado desde esta versión de la aplicación.';

  v = '[6.9]';
  //[6.9] Log al importar xls (no existe art). Bug lotes impr hoja pick.
  //[6.8.1] Calcular agencia para Haya al importar excel Antonio. Param aviso_pedidos_antiguos a g_clientes_config_.
  //Import fichero Antonio poner 1 ud. si no haya stock
  //[6.8] Param import_xls_agr_art. Agrupa articulos al importar excel. Params tiene_gp e import_type.
  //Comprueba cod art al importar ftp. Gestion stock padre-hijo.
  //[6.7] Capturar error api guardar pedido. Contador registros seleccionados grid main.
  //[6.6] Utilidad anular stock. Filtro por nombre. Majora interfaz botones habilitados.
  //Menu. Utilidad exportar ubicaciones de artículos.
  //[6.5.1.1] Fecha nula en edFinEnv
  //[6.5.1] Comprobar pedidos pistoleo n_serie solo 12 horas atrás. Bug filter al cerrar detalle.
  //[6.5] Cambio calculo stock para control stock 0 en importar fichero y boton eliminar lineas
  //[6.4] Param gestion_cola. Rest EstadoPedido. Param tiene_ctrl_stock_0
  //Importar fichero control tiene_ctrl_stock_0. Visualizar config cliente.
  //[6.3] Paso de algunos params en g_clientes_config_
  //[6.2] Bug al guardar detalle.
  //[6.1] Bug al guardar detalle. Sacar solo fichero Muzybar, sin enviar.
  //Param delay_ptes.
  //[6] Histórico de pedidos. Acortar nombre art al importar ftp.
  //[5.X] Label Picking anulado. Packing abierto por base de datos EN DESARROLLO
  //[5.22.2] Bug al dibujar celdas en grid main
  //[5.22.1] Bug Fanessi importar fichero
  //[5.22] Control de clientes tras generar. Cliente padre.
  //[5.21] Insertar id_almacen en pedido al importar xls. Bug al guardar detalle, se perdia text.
  //Reajuste ventana detalle. Params envia_sent, envia_delivered y almacenes pasados a g_clientes_config_
  //[5.20.1] Bug al importar pedidos por ftp
  //[5.20] Cambio param almacenes cliente.
  //[5.19.1] Bug al enviar fichero Muz
  //[5.19] Mensaje update pedido al final de todo. Bug al guardar serv y horario.
  //Control cp descarga ftp
  //Param arts a ignorar, uso en importar ftp. Guardar almacen en detalle. Buscador id_pedido.
  //[5.18] Param marca reexp, fecha minima envio email dest. Control envio email dest.
  //Log en bt guardar linea en detalle. Pistolear n_serie pistoleando ean solo una vez
  //[5.17.3] Pargal: Enviar lotes de lineas sin lote. Bug al guardar cambios en detalle, dir en albaran
  //[5.17.2.2] Bug al enviar fichero Muz, se imprime et de otro pedido
  //[5.17.2.1] Bug al guardar, se sobreescriben unos pedidos en otros
  //[5.17.2] No guardar detalle pedidos grandes. Ref cliente y CECO en detalle permite letras. Log bt guardar detalle.
  //[5.17.1] Muzybar, Importacion de pedidos paises extranjeros
  //[5.17] Bugs varios al guardar. Label date_file_send.
  //[5.16] Muzybar lectura n serie x articulo (a medias). Bug al crear picking abierto lotes.
  //[5.15] Boton enviar lotes a cliente. Inserta log al enviar lotes a cliente.
  //[5.14] Bug titulo_zona etiq Loginser. Agrandar panel pendientes.
  //Bug al generar pedidos.
  //[5.13] Nuevo formato etiqueta Loginser.
  //[5.12] Importar fichero xls con formato general si el cliente no tiene definido uno propio.
  //En detalle, mostrar en los combo servicios y horarios de la agencia según la configuracion de gestoras
  //Aviso de nueva version.
  //[5.11.1] Bug al imprimir adjunto. Control envío email pedido.
  //[5.11] Expedicion UPS UK y US Flam.
  //[5.10.3] En detalle, cargar solo servicios de la agencia.
  //[5.10.2] Bug al enviar fichero de Muzybar. Bug al guardar pedido. Colores en n serie.
  //[5.10.1] Bug al enviar fichero de Muzybar
  //[5.10] Import ftp: mostrar agencia del xml en obs del pedido
  //[5.9.2] Descarga ficheros ftp con Indy. Quitar sensibilidad mayusculas al procesar devos.
  //[5.9.1] Modificaciones Muzybar. Envio email si error al actualizar estado en web (Oxfam)
  //[5.9] Gestión de Muzybar. Groupbox extras en detalle.
  //[5.8] Detalle pedido en main. Print sin_stock al final de generar.
  //[5.7] Interfaz detalle con horas. Grid de extras. Control de except al importar pedidos web.
  //[5.6] Impresión y funciones de etiquetas fmt Loginser sacadas a repo, u_dmLabels.
  //Reajuste de diseño etiqueta de Loginser.
  //[5.5] Img warning. Pedidos en estado Incidencia al importar de web. php update pedidos vacios en web.
  //Envio sent y delivered revisando todo lo pendiente.
  //Activar uso de clientes no configurados. Bug serv/hora al actualizar alb Gestoras.
  //[5.4.6] Calcular formato de etiqueta por bbdd. Bug al calcular sin stock.
  //[5.4.5.1] Bug al reexpedir.
  //[5.4.5] En pack ab, buscar ubicacion usando sp ubics_con_stock
  //[5.4.4] Devoluciones Flamingos.
  //[5.4.3.1] Bug sin stock al generar.
  //[5.4.3] Mostrar expedicion_age para todos, no solo para origen_web=1.
  //Cambio de código de barras en etiqueta loginser. Imprimir hoja pick desde detalle usando u_picking.
  //Botón imprimir hojas de picking. Añadido u_picking.
  //[5.4.2.1] Bug al calcular dias atrás al imprimir.
  //[5.4.2] Parámetro pie de página hoja de picking.
  //[5.4.1] Update id_destino en c_pedidos al crear albarán. Param pack_abierto en GET_CLIENTES_CONFIG.
  //        Marcas enviado_sent y enviado_delivered. Campo enviado_fich en c_pedidos.
  //        Cambio enviar_status_delivered a botón generar.
  //[5.4] Aviso de imprimir etiquetas de pedidos antiguos. Parametrizar Importar Web (Oxfam).
  //      Enviar sent y delivered. Al generar los albaranes se crean uno a uno.
  //      Log de errores al generar.
  //[5.3] Parametrizar importar web por cliente. Control enabled menu contextual.
  //      Gestión docu EEUU para Flamingos. Filtro por ref cliente.
  //[5.2] Detalle personalizado 7551(llaves). Generar pedidos sin picking.
  //[5.1.1] Cambio en control de botón guardar de detalle.
  //[5.1] Envio de email montado por bbdd. From del email parametrizado. Restaurar tamaño panel pendientes.
  //[5.0] Reposicionar panel pendientes.
  //[5] Las etiquetas se imprimen una a una. Petición de etiquetas con todos o selección.
  //Cambio en el procedure de imprimir etiquetas. Control de almacenes. Botón fichero Seur.
  //[4.9.2.1] Bug al imprimir picking con lotes diferentes.
  //[4.9.2] Bug al marcar rojo en detalle de sin stock. Cambio cálculo de stock al generar.
  // Email personalizado para Zapato Feroz
  //[4.9.1.1] Bug al hacer get_stock, result no iniciado.
  //[4.9.1] Cambio en el control de stock al generar
  //[4.9] Dioxilife envia ref cliente en lugar de order name en el email
  //[4.8] Revisión de posibles errores al generar pedido. Nuevo diseño report etiq Lgs.
  //[4.7] Envío de email al destinatario con copia oculta. Cambio en la forma de calcular stock de un artículo.
  //[4.6.1] Bug al imprimir etiq Lgs, no se imprime el nombre de agencia si no es Lgs.
  //[4.6] Cambio en la forma de calcular el stock al generar pedidos.
  //[4.5.1] Bug al crear pick abi con 1 elemento.
  //[4.5] Generar bultos al imprimir etiqueta de Loginser
  //[4.4.2] Cambiar impresion de etiquetas de preview a print
  //[4.4.1] Bug al registrar pedidos e imprimir etiqueta de Loginser.
  //[4.4] Impresion de la etiqueta de Loginser por Fast Report. Mostrar hora de pedido en detalle.
  //Filtro Retorno, fecha de enviado y estado Incidencia. Incidencia en agrupación de 1 elemento
  //en pack abi solucionado. Control de errores y cambio de estado a E cuando registran pedidos en agencias.
  //[4.3] Nuevos estados Enviado e Incidencia. Filtro. Control de estado Enviado. Check Con Retorno.
  //Bug en agrupar 1 elemento en pack abierto. Generar pedido seleccionado o todo.
  //[4.2] Importacion de pedidos por ftp. Guardar repartidor en pack abierto. Reajuste en el cálculo
  //de los lotes para los pickings cuando se reparte en varios lotes y alguno es SIN LOTE.
  //Configurar cajas por agrupación en el cliente. Permitir actualizar lotes solo del pedido seleccionado.
  //Actualizar zona y repartidor en lineas de pick y pack. Agrupación de cajas en packing.
  //Formato de eamil para Alto Rendimiento. Referencia de artículo en rojo si no tiene stock disponible.
  //[4.1.6] Email seguimiento para Dioxilife
  //[4.1.5.3.1] Error de ejecución de versión anterior
  //[4.1.5.3] Insertar en albaran_picking de gestoras al generar
  //[4.1.5.2] Error al enviar correo.
  //[4.1.5.1] Enviar correo a destinatario cuando se envía un pedido solo.
  //[4.1.5] Guardar reembolso al guardar pedido desde detalle.
  //[4.1.4] Actualizar lotes en packing desde botón Actualizar Lotes
  //[4.1.3] No se limita la gestión de pedidos solo a origen_web=1. Resuelto nombre org en etiqueta = Life.
  //Enviar email a dst del pedido, configurable y personalizado.
  //[4.1.2] Pasar observaciones a gestoras cuando se guarda o crea un albarán. Reembolso en detalle.
  //[4.1.1] Control de tamaño de pendientes
  //[4.1] Chivato pedidos pendientes.
  //[4.0] Cambio a Delphi 10. Interfaz. Pedidos en cadena. Gestión por medio del api para
  //crear, modificar pedidos, imprimir etiquetas. Artículos relacionados.

  //[3.3] Control de una sola ejecución del programa. Packing abierto.
  //[3.2] Mensaje "no responda" al enviar el email del pedido. Conexión a gestoras.
  //Optimización de código al generar pedidos, búsqueda de ubicaciones y lanzar impresiones.
  //Carga de ruta de escritorio para carpeta de ficheros. Control de IMEI en detalle a nivel
  //de artículo y no de cliente. No es necesario estar en Pendientes para poder generar. Actualizar albaran LGS viejo
  //al guardar detalle.

var
  f_main: Tf_main;
  hiloactivo: Boolean;
  htmldevuelto: string;
  imp_eti: string;
  imp_def: string;
  ar_stock: array of Tstock;                    //stock
  idx_stock: Integer = 0;
  locked: Boolean; //0,1
  delivery_time, id_almacen: integer;
  default_deleg: string;
  path_files_imp, cli_inf_asm_cl, email_asm: string;
  transporte_propio, repartidor, estado_alb: integer;
  email_reexp, prefijo_reexp, path_reexp: string;
  tiene_lotes, tiene_imei, es_oxfam: Boolean;
  main_cli: integer;  //Cliente que se va a usar para calcular los parametros durante todo el proceso,
                     //Si se trabaja por cliente será el id del cliente y si se trabaja por grupo
                     //será el principal del grupo (tabla g_grupos_cliente)

  correos_etiquetador, correos_contrato, correos_cliente, txt_tpropio: string;
  jpg: TJPEGImage;
  db_sql: string;
  ar_pick: array of Tstock;                      //pick
  idx_pick: Integer = 0;
  cubic_a, cubic_b, cubic_c, cubic_d, cubic_e: integer;
  ncajas_a, ncajas_b, ncajas_c, ncajas_d, ncajas_e, ncajas_x: integer;
  uds_resto: integer;
  col_order: Integer;
  order_desc: Boolean = False;
  desktop: string;
  pack_abierto: integer;
  id_usuario: Integer;
  en_grabacion: Integer;
  stock_min: integer;
  peds_en_cadena: Integer;
  peds_encadenados: string;
  tiene_albs_gestoras: Boolean = True;
  envia_correo_a_dst: Boolean = False;
  cuenta_caja, cjs_x_agr: Integer;
  excel, xls, libro: Variant;
  hoja: OleVariant;
  horario_cl, servicio_cl: integer;
  PedCab: TPedCabecera;
  PedLines: array of TPedLine;
  copia_oculta: string;
  mail_nombre_cli: string;
  mail_logo_cli: string;
  mail_mail_info: string;
  mail_order_name: string;
  imgs_ftp, ftp_in, ftp_out, path_copy_out, path_copy_in, httpweb, php_get, php_update, php_update_vacios, php_send: string;
  ruta_fichero_seur, ruta_fichero_seur_copia: string;
  agencia_correos, agencia_seur: Integer;
  prod_seur: string;
  link_spa, link_eng, qry_detail: string;
  alm_cliente: string;
  form_a_medida: TForm;
  tiene_detalle_a_medida: boolean;
  mail_from: string;
  clientes_no_10: string;
  id_columnas_web: integer;
  envia_error_import: Boolean;
  email_error_import, oculta_error_import, asunto_error_import: string;
  envia_sent: Boolean;
  php_sent, datos_sent, log_sent: string;
  envia_delivered: Boolean;
  php_delivered, datos_delivered, log_delivered, estados_delivered: string;
  marca_sent, marca_delivered: Integer;
  aviso_pedidos_antiguos: integer;
  pie_hoja_pick: string;
  titulo_sin_stock: string;
  tiene_devos: boolean;
  ftp_devo_host: string;
  ftp_devo_user: string;
  ftp_devo_pass: string;
  ftp_devo_dir: string;
  ftp_devo_prefijo: string;
  tipo_devo_reco, tipo_devo_reco_cli, dir_cliente_reco: string;
  dir_temp, dir_temp_devo: string;
  ip, hostname: string;
  control_imei: Boolean;
  aviso_incidencias: Boolean;
  ar_arts_sin_stock: array of integer;
  idx_arts_sin_stock: Integer = 0;
  print_doc_cliente: Boolean;
  extra_doc_cliente: string;
  tiene_n_serie, tiene_adjuntos: Boolean;
  ftp_100, ftp_200, ftp_300, ftp_400: TStringList;
  ftp_actual: string;
  ftp_sociedad: Integer;
  tit_file_ups, ftp_dir_ups: string;
  pos_tit_ups: integer;
  act_envios: Boolean;
  FicheroServer:string;
  logo_cli_etiq:integer;
  cli_api_url, cli_api_user, cli_api_pass: string;
  revisa_lotes, pick_con_lote_asignado: Boolean;
  mail_error:string;
  usuario: TDatosUsuario;
  PC: TDatosPC;
  log_app: string;
  lotes_reservados: array of TReservaLote;
  max_ln_det: integer;
  date_mail_dest: TDate;
  marca_ped_reexp: string;
  arts_ignorar: string;
  modo_historico:Boolean=false;
  delay_ptes: Integer = 300000;
  lgs_api_url, lgs_api_user, lgs_api_pass: string;
  lgs_api_pedido, lgs_api_estped: string;
  gestion_cola, tiene_control_stock_0:Boolean;
  util_anula_stock, util_anula_stock_baja_art: Boolean;
  util_anula_stock_params, util_anula_stock_copia:string;
  import_xls_agr_art: Boolean;
  import_type: string;
  util_pav: Boolean;
  asignado_a_pav: array of Integer;
  cl_padres: TStringDynArray;
  cl_hijos: TStringDynArray;
  arts_heredados: array of TArtHerencia;
implementation

uses
  u_dm, UGetText, ubuscapro, u_detail, u_gen_gl, u_cam_gl, u_envia_mail,
  u_globals, u_correos, u_devos, u_orders, u_dm_oxfam, u_privalia, USendText,
  u_globals_gestoras, u_AlbaranValidate, u_LstEtiquetas, UDMCreaBultos,
  u_UpdatePedido, Documento, u_muzybar, u_get_pdf, u_seur, u_pedidos, u_llaves,
  u_picking, u_CreateExpedicion, u_login, u_dmLabels, u_DescargaAttach,
  u_flams, userverupdate,u_functions, u_dmPargal, u_lotes, u_cli_config,
  u_EstadoPedido, u_ontinyent;

{$R *.dfm}


{$REGION 'Ini-Close'}
procedure Tf_main.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dm.t_read.Active := False;
end;

procedure Tf_main.FormCreate(Sender: TObject);
begin
  if (ALERTA <> 'LISTO') then
    ShowMessage('CUIDADO!!!!! PROYECTO EN DESARROLLO!!!! AVISA A INFORMATICA!!!');

  leer_ini;

  leer_ini_gestoras;
  ini_bd_simple;
  ini_bd_gestoras;
  lee_inis_def;
  if db_sql <> '' then
  begin
     // dm.con1.Connected := False;
    dm.con1.ConnectionString := db_sql;
      //dm.con1.Connected := True;
  end;

  get_defaults;

  leer_ini_bbdd(u_globals.id_usuario);

  FicheroServer:=DameRutaExeServerdeIni(GetDefaultIniName(Application.exename));

  PC.Nombre := ComputerName;
  PC.IP := LocalIP;
  PC.Usuario := obtenerUsuarioRed;
  usuario.id := -1;
  usuario.Nombre := 'Usuario Desconocido';

end;

procedure Tf_main.FormDblClick(Sender: TObject);
begin
  if HiWord(GetKeyState(VK_CONTROL)) <> 0 then
    bt2.Visible := not bt2.Visible;
end;

procedure Tf_main.FormDestroy(Sender: TObject);
begin
  if ((usuario_nom<>'') and (usuario_nom<>'Usuario Desconocido')) then
    guardar_ini;
end;

procedure Tf_main.FormShow(Sender: TObject);
var
  usu, r: string;
  flog: TfrmLogin;
begin

  //if not(dm.db.Connected) then dm.db.Connected:=true;

  api := GetConexion(api);

  if api = '' then
  begin
    ShowMessage('IMPORTANTE: Revise la configuración de API en su fichero Config.ini (api=API_TEST o API_PRO).' + ln + 'La aplicación se cerrará.');
    Application.Terminate;
  end;

  de_ini.Date := now;
  de_fin.Date := now;
  de_1.Date := now;

  usu := GetEnvironmentVariable('UserName');
  desktop := ruta_escritorio;

  if desktop = '' then
  begin
    r := GetEnvironmentVariable('HOMEDRIVE') + GetEnvironmentVariable('HOMEPATH');
    if DirectoryExists(r + '\Escritorio') then
      ed_folder.Text := r + '\Escritorio'
    else
    begin
      if DirectoryExists(r + '\Desktop') then
        ed_folder.Text := r + '\Desktop'
      else
        ed_folder.Text := ruta_escritorio;
    end
  end
  else begin
    ed_folder.Text := desktop;
    deDir.Text := desktop;
  end;

  locked := False;

  lbCon.Caption := dbname + ' ** ' + db_gestoras + ' ** ' + api;

  jpg := TJPEGImage.Create;
  //filter;

  en_grabacion := get_estado_valor('en_grabacion');

  //SOLO PARA HAYA, DESHABILITAR CUANDO SE METAN MÁS CLIENTES EN ESTE EXE
 { edCliente.Text := '7386';
  edClienteChange(self);
  btLockClick(self);     }

  lb_n.Caption := '0 pedido/s';
  lb_n_detalle.Caption := '';
  edCliente.SetFocus;

  //log('probando', ruta_log+ FormatDateTime('yyymmdd',Now) + '_' + ChangeFileExt(ExtractFileName(ParamStr(0)),'.log'));

  CalculaPendientes;

  u_gen_gl.lee_inis_def;      //lee defs de tablas aux

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

  Caption := 'GESTIÓN PEDIDOS DE ALMACÉN ' + v + ' ' + IntToStr(usuario.id) + ' ' + usuario.Nombre;

end;

procedure Tf_main.gb3Click(Sender: TObject);
begin

end;

{$ENDREGION}

{$REGION 'Filters'}
procedure Tf_main.rgTipoGesClick(Sender: TObject);
begin
  case rgTipoGes.ItemIndex of
    0:
      begin
        edGrupo.Text := '';
        lbgrupo.Caption := '(Seleccione un grupo de clientes)';
        gr_envs.Columns[0].Visible := False;
        lb_cli.Visible := False;
        gbGrupo.Visible := False;
        gbCliente.Visible := True;
        edCliente.SetFocus;
      end;
    1:
      begin
        gr_envs.Columns[0].Visible := True;
        lb_cli.Visible := True;
        gbGrupo.Visible := True;
        gbCliente.Visible := False;
        edGrupo.SetFocus;
      end;
  end;
end;

procedure Tf_main.rg_orderClick(Sender: TObject);
begin
  {if locked then
      filter(modo_historico);    }
end;

procedure Tf_main.rg_stateClick(Sender: TObject);                        //CAMBIA RADIOGROUP ESTADOS DE VISUALIZACION
begin
 { gr_envs.MultiSelect := ((rg_state.ItemIndex = 0) or (rg_state.ItemIndex = 1) or (rg_state.ItemIndex = 2) or (rg_state.ItemIndex = 3));

  btPrintPick.Enabled := ((rg_state.ItemIndex = 2) or (rg_state.ItemIndex = 3));

  bt_genera.Enabled := ((rg_state.ItemIndex = 0) or (rg_state.ItemIndex = 1));

  btEnvAgencias.Enabled := (rg_state.ItemIndex = 2);

  btRegenerar.Enabled := (rg_state.ItemIndex = 3);

  btSinStock.Enabled := (rg_state.ItemIndex = 1);

  btStock0.Enabled := (rg_state.ItemIndex = 1);

  if rg_state.ItemIndex=1 then
      gr_detalle.Height := 543
  else
      gr_detalle.Height := 561;
 }

 { if locked then
      filter(modo_historico);   }

  gr_envs.MultiSelect := false;

  btPrintPick.Enabled := false;

  bt_genera.Enabled := false;

  btEnvAgencias.Enabled := false;

  btRegenerar.Enabled := false;

  btSinStock.Enabled := false;
  btImpEtiq.Enabled := false;
  btStock0.Enabled := false;

end;

procedure Tf_main.edClienteChange(Sender: TObject);
begin

  if edCliente.Text <> '' then
  begin
    lbCliente.Caption := UpperCase(BuscaClienteGesFile(StrToInt(edCliente.Text)));
        //filter;
  end;

  if lbCliente.Caption = '' then
    lbCliente.Caption := '(Seleccione un cliente)';

  btLock.Enabled := (lbCliente.Caption <> '(Seleccione un cliente)');
end;

procedure Tf_main.edDiasAtrasKeyPress(Sender: TObject; var Key: Char);
begin
   { if Key=Char(13) then
      filter(modo_historico);   }
end;

procedure Tf_main.edGrupoChange(Sender: TObject);
begin
  if edGrupo.Text <> '' then
  begin
    lbgrupo.Caption := BuscaClienteGesFile(GetMainCliGrupo(StrToInt(edGrupo.Text)));
        //filter;
  end;

  if lbGrupo.Caption = '' then
    lbGrupo.Caption := '(Seleccione un grupo de clientes)';

  btLock.Enabled := (lbgrupo.Caption <> '(Seleccione un grupo de clientes)');
end;

procedure Tf_main.edIdPedidoChange(Sender: TObject);
begin
   { if ch_albaran.Checked then
      if locked then
           filter(modo_historico);  }
end;

procedure Tf_main.ed_artExit(Sender: TObject);
var
  s: string;
begin
  if ed_art.Text <> '' then
  begin
    s := busca_art_nom_cod(ed_art.Text);
    if s <> '' then
      lb_art1.caption  := s
    else
      lb_art1.Caption := 'No Encontrado';
  end
  else
    lb_art1.Caption := 'Tipo Erróneo';
end;

procedure Tf_main.bt_art1Click(Sender: TObject);
begin
  with fbuscapro do
  begin
    limpia_fields;
    multiselect := false;
    livekey := false;
    fields.commatext := 'a.id_articulo,a.codigo,a.nombre';
    titulos.commatext := 'Artículo,Referencia,Nombre';
    from := 'g_articulos a ';
    where := 'a.id_cliente=' + edCliente.Text + ' and a.estado<''B''';
    orden[1] := 2;
    busca := 3;
    distinct := 0;
    fillimpio := True;
    row_height := 17;

    showmodal;

    if resultado then
    begin
      with Sender as TsSpeedButton do
      begin
        ed_art.text := valor[2];
        lb_art1.caption := valor[3];
      end;
    end;
  end;

  //if cb_articulo.Checked then filter;
end;

procedure Tf_main.filter(modo_historico:Boolean);
var
  s: string;
  cbPais, cbAgencia: string;
begin
  if cbPaises.Text = '' then
    cbPais := 'TODOS'
  else
    cbPais := cbPaises.Text;

  if cbAgencias.Text = '' then
    cbAgencia := 'TODOS'
  else
    cbAgencia := cbAgencias.Text;

  dm.q_peds.Close;
  dm.q_peds.SelectSQL.Clear;
  //dm.q_peds.SelectSQL.Add('select * ');

  {if (StrToIntDef(edRegIni.Text,-1)>0) and (StrToIntDef(edRegFin.Text,-1)>0) then
  begin
    dm.q_peds.SelectSQL.Add('select first :cuenta skip :primero * ');
    dm.q_peds.ParamByName('cuenta').AsInteger := StrToInt(edRegFin.Text)-StrToInt(edRegIni.Text)+1;
    dm.q_peds.ParamByName('primero').AsInteger := StrToInt(edRegIni.Text)-1;
  end
  else }
   dm.q_peds.SelectSQL.Add('select * ');

  if not modo_historico then
     dm.q_peds.SelectSQL.Add(' from c_pedidos p ')
  else
     dm.q_peds.SelectSQL.Add(' from c_pedidos_hist p ');

  dm.q_peds_count.Close;
  dm.q_peds_count.SelectSQL.Clear;
  dm.q_peds_count.SelectSQL.Add('select count(*) as tot ');

  if not modo_historico then
     dm.q_peds_count.SelectSQL.Add(' from c_pedidos p ')
  else
     dm.q_peds_count.SelectSQL.Add(' from c_pedidos_hist p ');

  {if rgTipoGes.ItemIndex = 1 then
  begin
    dm.q_peds.SelectSQL.Add('inner join g_clientes cl on cl.id_cliente=p.id_cliente ');
    dm.q_peds_count.SelectSQL.Add('inner join g_clientes cl on cl.id_cliente=p.id_cliente ');
  end;  }

  dm.q_peds.SelectSQL.Add('where id_almacen=:id_almacen ');
  dm.q_peds.ParamByName('id_almacen').AsInteger := id_almacen;

  dm.q_peds_count.SelectSQL.Add('where id_almacen=:id_almacen ');
  dm.q_peds_count.ParamByName('id_almacen').AsInteger := id_almacen;

  if not chFPedTodo.checked and (edDiasAtras.Value>0) then
  begin
    dm.q_peds.SelectSQL.Add(' and cast(fecha_ped as date) >= :f1_ped ');
    dm.q_peds.ParamByName('f1_ped').AsDate := Date - edDiasAtras.Value;

    dm.q_peds_count.SelectSQL.Add(' and cast(fecha_ped as date) >= :f1_ped ');
    dm.q_peds_count.ParamByName('f1_ped').AsDate := Date - edDiasAtras.Value;
  end;

  if not rb_alldate.checked then
  begin
    dm.q_peds.SelectSQL.Add('and cast(fecha_imp as date) between :f1 and :f2 ');
    dm.q_peds.ParamByName('f1').AsDate := de_ini.Date;
    dm.q_peds.ParamByName('f2').AsDate := de_fin.Date;

    dm.q_peds_count.SelectSQL.Add('and cast(fecha_imp as date) between :f1 and :f2 ');
    dm.q_peds_count.ParamByName('f1').AsDate := de_ini.Date;
    dm.q_peds_count.ParamByName('f2').AsDate := de_fin.Date;
  end;

  if not rb_alldate_gen.checked then
  begin
    dm.q_peds.SelectSQL.Add(' and cast(fecha_gen as date) between :f1_gen and :f2_gen ');
    dm.q_peds.ParamByName('f1_gen').AsDate := de_ini_gen.Date;
    dm.q_peds.ParamByName('f2_gen').AsDate := de_fin_gen.Date;

    dm.q_peds_count.SelectSQL.Add(' and cast(fecha_gen as date) between :f1_gen and :f2_gen ');
    dm.q_peds_count.ParamByName('f1_gen').AsDate := de_ini_gen.Date;
    dm.q_peds_count.ParamByName('f2_gen').AsDate := de_fin_gen.Date;
  end;

  if not rb_alldate_env.checked then
  begin
    dm.q_peds.SelectSQL.Add(' and cast(fecha_fin as date) between :f1_fin and :f2_fin ');
    dm.q_peds.ParamByName('f1_fin').AsDate := de_ini_env.Date;
    dm.q_peds.ParamByName('f2_fin').AsDate := de_fin_env.Date;

    dm.q_peds_count.SelectSQL.Add(' and cast(fecha_fin as date) between :f1_fin and :f2_fin ');
    dm.q_peds_count.ParamByName('f1_fin').AsDate := de_ini_env.Date;
    dm.q_peds_count.ParamByName('f2_fin').AsDate := de_fin_env.Date;
  end;

  case rgTipoGes.ItemIndex of
    0:
      begin
        dm.q_peds.SelectSQL.Add(' and id_cliente=:cli ');
        dm.q_peds.ParamByName('cli').AsString := edCliente.Text;
        dm.q_peds_count.SelectSQL.Add(' and id_cliente=:cli ');
        dm.q_peds_count.ParamByName('cli').AsString := edCliente.Text;
      end;

    1:
      begin
        dm.q_peds.SelectSQL.Add(' and cl.id_grupo_cliente=:gru ');
        dm.q_peds.ParamByName('gru').AsString := edGrupo.Text;
        dm.q_peds_count.SelectSQL.Add(' and cl.id_grupo_cliente=:gru ');
        dm.q_peds_count.ParamByName('gru').AsString := edGrupo.Text;
      end;
  end;

  s := '';
  case (rg_state.ItemIndex) of
    0:
      s := 'and p.estado=''P'' ';          //Pendientes
    1:
      s := 'and p.estado=''X'' ';          //sin stock
    2:
      s := 'and p.estado=''G'' ';          //generados
    3:
      s := 'and p.estado=''E'' ';          //finalizados/enviados
    4:
      s := 'and p.estado=''A'' ';          //anulados
    5:
      s := 'and p.estado=''C'' ';          //cancelados por cliente
    //6: s:='and p.estado=''D'' ';          //devoluciones
    6:
      s := 'and p.estado=''I'' ';          //incidencias
  end;

  if ch_order_name.Checked then
  begin
    dm.q_peds.SelectSQL.Add('and order_name like :busc ');
    dm.q_peds.ParamByName('busc').AsString := '%' + ed_search_order.Text + '%';

    dm.q_peds_count.SelectSQL.Add('and order_name like :busc ');
    dm.q_peds_count.ParamByName('busc').AsString := '%' + ed_search_order.Text + '%';
  end;

  if ch_albaran.Checked and (StrToIntDef(ed_search_albaran.Text, -1) <> -1) then
  begin
    dm.q_peds.SelectSQL.Add('and codalbaran like :busc2 ');
    dm.q_peds.ParamByName('busc2').AsString := '%' + ed_search_albaran.Text + '%';

    dm.q_peds_count.SelectSQL.Add('and codalbaran like :busc2 ');
    dm.q_peds_count.ParamByName('busc2').AsString := '%' + ed_search_albaran.Text + '%';
  end;

  if ch_articulo.Checked then
  begin
    if not modo_historico then
        dm.q_peds.SelectSQL.Add('and id_pedido in (select id_pedido from c_pedidos_lines where id_articulo=:id_art) ')
    else
        dm.q_peds.SelectSQL.Add('and id_pedido in (select id_pedido from c_pedidos_lines_hist where id_articulo=:id_art) ');
    dm.q_peds.ParamByName('id_art').asinteger := busca_art(ed_art.Text);

    if not modo_historico then
        dm.q_peds_count.SelectSQL.Add('and id_pedido in (select id_pedido from c_pedidos_lines where id_articulo=:id_art) ')
    else
        dm.q_peds_count.SelectSQL.Add('and id_pedido in (select id_pedido from c_pedidos_lines_hist where id_articulo=:id_art) ');
    dm.q_peds_count.ParamByName('id_art').asinteger := busca_art(ed_art.Text);
  end;

  if ch_idorder.Checked then
  begin
    dm.q_peds.SelectSQL.Add('and id_order like :busc ');
    dm.q_peds.ParamByName('busc').AsString := '%' + ed_search_idorder.Text + '%';

    dm.q_peds_count.SelectSQL.Add('and id_order like :busc ');
    dm.q_peds_count.ParamByName('busc').AsString := '%' + ed_search_idorder.Text + '%';
  end;

  if chConRetorno.Checked then
  begin
    dm.q_peds.SelectSQL.Add('and con_retorno=1 ');
    dm.q_peds_count.SelectSQL.Add('and con_retorno=1 ');
  end;

  if chRefCli.Checked then
  begin
    dm.q_peds.SelectSQL.Add('and ref_cliente like :ref_cliente ');
    dm.q_peds.ParamByName('ref_cliente').AsString := '%' + edRefCliente.Text + '%';

    dm.q_peds_count.SelectSQL.Add('and ref_cliente like :ref_cliente ');
    dm.q_peds_count.ParamByName('ref_cliente').AsString := '%' + edRefCliente.Text + '%';
  end;

  if chIdPedido.Checked and (StrToIntDef(edIdPedido.Text, -1) <> -1) then
  begin
    dm.q_peds.SelectSQL.Add('and id_pedido=:busc2 ');
    dm.q_peds.ParamByName('busc2').AsString := edIdPedido.Text;

    dm.q_peds_count.SelectSQL.Add('and id_pedido=:busc2 ');
    dm.q_peds_count.ParamByName('busc2').AsString := edIdPedido.Text;
  end;

  if edNombre.Text<>'' then
  begin
    dm.q_peds.SelectSQL.Add('and upper(nombre) like :nombre ');
    dm.q_peds.ParamByName('nombre').AsString := '%' + UpperCase(edNombre.Text) + '%';

    dm.q_peds_count.SelectSQL.Add('and upper(nombre) like :nombre ');
    dm.q_peds_count.ParamByName('nombre').AsString := '%' + UpperCase(edNombre.Text) + '%';
  end;

  dm.q_peds.SelectSQL.Add(s);

  dm.q_peds_count.SelectSQL.Add(s);

  s := '';
  if cbPaises.ItemIndex > 0 then
  begin
    s := ' and pais_code=' + QuotedStr(Copy(cbPaises.Text, Pos('|', cbPaises.Text) + 1, Length(cbPaises.Text)));
    dm.q_peds.SelectSQL.Add(s);
    dm.q_peds_count.SelectSQL.Add(s);
  end;

  s := '';
  if cbAgencias.ItemIndex > 0 then
  begin
    s := ' and id_repartidor=' + Copy(cbAgencias.Text, Pos('|', cbAgencias.Text) + 1, Length(cbAgencias.Text));
    dm.q_peds.SelectSQL.Add(s);
    dm.q_peds_count.SelectSQL.Add(s);
  end;

  dm.q_peds_count.Open;

  s := '';
  if gr_envs.Columns[col_order].Title.Caption = 'AGENCIA' then
    s := ' order by p.id_repartidor'
  else
    s := ' order by p.' + gr_envs.Columns[col_order].Title.Caption;

  if order_desc then
    s := s + ' desc';

  dm.q_peds.SelectSQL.Add(s);
  dm.q_peds.Open;

  if ((rg_state.ItemIndex = 0) or (rg_state.ItemIndex = 1)) then
  begin
    gr_envs.SelectedRows.CurrentRowSelected := True;
  end;

  RellenaAgencias;
  RellenaPaises;

  if dm.q_peds.IsEmpty then
  begin
    cbPaises.ItemIndex := 0;
    cbAgencias.ItemIndex := 0;
  end
  else
  begin
    cbPaises.ItemIndex := cbPaises.IndexOf(cbPais);
    cbAgencias.ItemIndex := cbAgencias.IndexOf(cbAgencia);
  end;

  dm.cargar_lineas_pedido;

  //dm.q_peds_lines.Open;
  //dm.q_peds_lines_count.Open;

  lb_n.Caption := IntToStr(gr_envs.SelectedRows.Count) + ' / ' + dm.q_peds_count.FieldByName('tot').asstring + ' pedido/s';
  //lb_n.Caption := dm.q_peds_count.FieldByName('tot').asstring + ' pedido/s';
  lb_n_detalle.Caption := IntToStr(dm.q_peds_lines_count.FieldByName('tot').asinteger) + ' lineas detalle';
end;


procedure Tf_main.gr_envsCellClick(Column: TColumn);
begin
 lb_n.Caption := IntToStr(gr_envs.SelCount) + ' / ' + dm.q_peds_count.FieldByName('tot').asstring + ' pedido/s';
end;

procedure Tf_main.gr_envsDblClick(Sender: TObject);
begin
  abre_detalle(0);
end;

procedure Tf_main.gr_envsDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin

  if not modo_historico then
  begin
      if revisa_lotes and (dm.q_peds.FieldByName('incidencia').AsInteger=0) then
        if (Column.FieldName='ORDER_NAME') and (dm.q_peds.FieldByName('estado').AsString = 'E') then
        begin
             gr_envs.Canvas.Brush.Color :=clRed;
             gr_envs.DefaultDrawColumnCell(Rect,datacol,column,State);
        end

      //if util_pav and es_asignado_a_pav  then


  end else begin
              gr_envs.canvas.Font.Color := clRed;
              gr_envs.DefaultDrawColumnCell(Rect,datacol,column,State);
            end;
end;

procedure Tf_main.gr_envsEndDock(Sender, Target: TObject; X, Y: Integer);
begin
  lb_n.Caption := IntToStr(gr_envs.SelCount) + ' / ' + dm.q_peds_count.FieldByName('tot').asstring + ' pedido/s';
end;

procedure Tf_main.gr_envsKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  lb_n.Caption := IntToStr(gr_envs.SelCount) + ' / ' + dm.q_peds_count.FieldByName('tot').asstring + ' pedido/s';
end;

procedure Tf_main.gr_envsTitleClick(Column: TColumn);
var
  i: integer;
begin
 // if gr_envs.Columns[column.index].Title.Caption<>'AGENCIA' then
 // begin
  if col_order = Column.index then
    order_desc := not order_desc
  else
    order_desc := False;

  col_order := Column.Index;

  filter(modo_historico);
  for i := 0 to gr_envs.Columns.Count - 1 do
    if Column.Index = i then
      gr_envs.Columns[i].Title.Font.Color := clPurple
    else
      gr_envs.Columns[i].Title.Font.Color := clBlack;
 // end else
 //       col_order := Column.Index;
end;

procedure Tf_main.bt_reexpClick(Sender: TObject);
begin
  if BuscaReexpedicion(dm.q_peds.FieldByName('id_cliente').AsInteger, dm.q_peds.FieldByName('order_name').AsString) <> -1 then
    raise Exception.Create('Pedido ya reexpedido con anterioridad.');

  abre_detalle(2);
end;

procedure Tf_main.bt_nuevoClick(Sender: TObject);
begin
  abre_detalle(1);
end;

procedure Tf_main.bt_anularClick(Sender: TObject);
begin
  dm.t_write.StartTransaction;
  try
    dm.q_1.Close;
    dm.q_1.sql.Clear;
    dm.q_1.sql.Add('update c_pedidos set estado=''A'' where id_pedido=:id_pedido');
    dm.q_1.ParamByName('id_pedido').AsInteger := dm.q_peds.fieldbyname('id_pedido').asinteger;
    dm.q_1.ExecQuery;
    dm.t_write.Commit;
  except
    dm.t_write.rollback;
  end;

  if locked then
      filter(modo_historico);
end;
{$ENDREGION}

{$REGION 'Importar'}
//IMPORTAR PEDIDOS DESDE WEB

procedure Tf_main.bt_import_mdbClick(Sender: TObject);
var
  GetText: thSelecthilo;
  str_lista, str_linea: TStringDynArray;
  i, id_pedido, id_line, n, j, k, l, id_articulo: integer;
  order_list: tstringlist;
  telefono, cp, estado, financial_status, fulfillment_status, gateway, order_name: string;
  fin, art_tiene_imei: boolean;
  fileConfigC, fileConfigL: u_functions.TIntArray;
  col_codigo_cliente, col_cliente_deleg, col_codigo_albaran, col_fecha, col_referencia_articulo, col_destino_delegacion, col_destino_nombre, col_destino_direccion, col_destino_localidad, col_destino_cp, col_destino_provincia, col_destino_telefono, col_destino_email, col_destino_contacto, col_observaciones, col_pais, col_unidades, col_delivery_time, col_reembolso, col_portes_debidos, col_pedido, col_item_id, col_nombre_art, col_id_order, col_pais_code, col_financial, col_tags, col_note, col_gateway, col_fulfillment, col_company, col_f_cancel, col_cancel_reason, col_text, col_destino_prov_code: Integer;
  deleg, deliv_time, cantidad, item_id: Integer;
  reembolso: Double;
  observaciones, pais, email, direccion, nombre_art, pais_code, text, contacto, note: string;
  tags, company, cancel_reason, errors, lista_descargados: string;
  fecha_ped, fecha_cancel: TDateTime;
  mail: Tf_envia_mail;
  cuerpo: tstrings;
  asunto_error_import_copy: string;

  function encontrado(order: string): Boolean;
  var
    i: integer;
    enc: Boolean;
  begin
    enc := False;
    for i := 0 to order_list.Count - 1 do
    begin
      if order_list[i] = order then
        enc := true;
    end;
    Result := enc;
  end;

begin
  bt_import_mdb.Enabled := False;

  if main_cli<>2045 then
  begin

    id_pedido := 999999;
    id_line := 1;
    n := 0;
    order_list := tstringlist.Create();

    errors := '';
    lista_descargados := '';

    lb_st1.Caption := 'Consultando Pedidos en Web';
    application.ProcessMessages;

    GetText := ThSelectHilo.Create(true);
    GetText.FreeOnTerminate := True;


    //GetText.strurl:= httpweb+'sync_get_orders.php';
    GetText.strurl := httpweb + php_get;
    hiloactivo := True;
    GetText.Resume;
    while hiloactivo do
      Application.ProcessMessages;

    str_lista := splitstring(htmldevuelto, sep1);                    //Separa lineas por sep1 $

    dm.t_write.StartTransaction;

    fileConfigC := u_functions.GetFileConfig((StrToInt(edCliente.Text) * 1000) + 1);
    fileConfigL := u_functions.GetFileConfig((StrToInt(edCliente.Text) * 1000) + 2);

    if fileConfigC[0] >= 0 then
      col_codigo_cliente := fileConfigC[0]
    else
      col_codigo_cliente := fileConfigC[0];

    if fileConfigC[1] >= 0 then
      col_cliente_deleg := fileConfigC[1]
    else
      col_cliente_deleg := fileConfigC[1];

    if fileConfigC[2] >= 0 then
      col_codigo_albaran := fileConfigC[2]
    else
      col_codigo_albaran := fileConfigC[2];

    if fileConfigC[3] >= 0 then
      col_fecha := fileConfigC[3]
    else
      col_fecha := fileConfigC[3];

    if fileConfigL[4] >= 0 then
      col_referencia_articulo := fileConfigL[4]
    else
      col_referencia_articulo := fileConfigL[4];

    if fileConfigC[5] >= 0 then
      col_destino_delegacion := fileConfigC[5]
    else
      col_destino_delegacion := fileConfigC[5];

    if fileConfigC[6] >= 0 then
      col_destino_nombre := fileConfigC[6]
    else
      col_destino_nombre := fileConfigC[6];

    if fileConfigC[7] >= 0 then
      col_destino_direccion := fileConfigC[7]
    else
      col_destino_direccion := fileConfigC[7];

    if fileConfigC[8] >= 0 then
      col_destino_localidad := fileConfigC[8]
    else
      col_destino_localidad := fileConfigC[8];

    if fileConfigC[9] >= 0 then
      col_destino_cp := fileConfigC[9]
    else
      col_destino_cp := fileConfigC[9];

    if fileConfigC[10] >= 0 then
      col_destino_provincia := fileConfigC[10]
    else
      col_destino_provincia := fileConfigC[10];

    if fileConfigC[11] >= 0 then
      col_destino_telefono := fileConfigC[11]
    else
      col_destino_telefono := fileConfigC[11];

    if fileConfigC[12] >= 0 then
      col_destino_email := fileConfigC[12]
    else
      col_destino_email := fileConfigC[12];

    if fileConfigC[13] >= 0 then
      col_destino_contacto := fileConfigC[13]
    else
      col_destino_contacto := fileConfigC[13];

    if fileConfigC[14] >= 0 then
      col_observaciones := fileConfigC[14]
    else
      col_observaciones := fileConfigC[14];

    if fileConfigC[15] >= 0 then
      col_pais := fileConfigC[15]
    else
      col_pais := fileConfigC[15];

    if fileConfigL[16] >= 0 then
      col_unidades := fileConfigL[16]
    else
      col_unidades := fileConfigL[16];

    if fileConfigC[17] >= 0 then
      col_delivery_time := fileConfigC[17]
    else
      col_delivery_time := fileConfigC[17];

    if fileConfigC[18] >= 0 then
      col_reembolso := fileConfigC[18]
    else
      col_reembolso := fileConfigC[18];

    if fileConfigC[19] >= 0 then
      col_portes_debidos := fileConfigC[19]
    else
      col_portes_debidos := fileConfigC[19];

    if fileConfigC[20] >= 0 then
      col_pedido := fileConfigC[20]
    else
      col_pedido := fileConfigC[20];

    col_id_order := fileConfigC[21];
    col_item_id := fileConfigL[22];
    col_nombre_art := fileConfigL[23];
    col_pais_code := fileConfigC[24];
    col_financial := fileConfigC[25];
    col_gateway := fileConfigC[26];
    col_fulfillment := fileConfigC[27];
    col_tags := fileConfigC[28];
    col_f_cancel := fileConfigC[29];
    col_cancel_reason := fileConfigC[30];
    col_company := fileConfigC[31];
    col_note := fileConfigC[32];
    col_text := fileConfigC[33];
    col_destino_prov_code := fileConfigC[34];

    for i := Low(str_lista) to High(str_lista) - 1 do
    begin

      str_linea := splitstring(str_lista[i], sep2);

      if (str_linea[0] = 'C') and (str_linea[col_codigo_cliente] = edCliente.Text) then
      begin                      //Cabecera

        if not encontrado(str_linea[col_pedido]) then
        begin

          with TpFIBDataSet.Create(self) do
          try
            Database := dm.db;
            sqls.SelectSQL.Add('SELECT GEN_ID(GEN_C_PEDIDOS_ID,1) FROM RDB$DATABASE');
            Open;
            id_pedido := FieldByName('gen_id').AsInteger;
          finally
            free;
          end;

          id_line := 1;
          order_list.Add(str_linea[col_id_order]);

          if col_destino_delegacion = -1 then
            deleg := -1
          else if str_linea[col_destino_delegacion] = '' then
            deleg := -1
          else
            deleg := StrToInt(str_linea[col_destino_delegacion]);

          if col_delivery_time = -1 then
            deliv_time := delivery_default
          else if str_linea[col_delivery_time] <> '' then
            deliv_time := StrToInt(str_linea[col_delivery_time])
          else
            deliv_time := delivery_default;

          if col_pais = -1 then
            pais := 'ES'
          else
            pais := str_linea[col_pais];

          if col_pais_code = -1 then
            pais_code := ''
          else
            pais_code := str_linea[col_pais_code];

          if pais_code = 'ES' then
            cp := format_cp(str_linea[col_destino_cp])
          else
          begin
            cp := ReplaceStr(str_linea[col_destino_cp], ' ', '');
            cp := ReplaceStr(cp, '-', '');
          end;

          telefono := ReplaceStr(str_linea[col_destino_telefono], ' ', '');
          telefono := ReplaceStr(telefono, '-', '');
          telefono := ReplaceStr(telefono, ',', '');
          telefono := ReplaceStr(telefono, '+', '');
          telefono := ReplaceStr(telefono, '.', '');

          if col_reembolso <> -1 then
            reembolso := StrToFloat(str_linea[col_reembolso])
          else
            reembolso := 0;

          if col_observaciones = -1 then
            observaciones := ''
          else
            observaciones := str_linea[col_observaciones];

          if col_destino_email = -1 then
            email := ''
          else
            email := str_linea[col_destino_email];

          direccion := str_linea[col_destino_direccion] + ' ' + str_linea[col_destino_direccion + 1];

          fecha_ped := encodedatetime(strtoint(Copy(str_linea[col_fecha], 1, 4)), strtoint(Copy(str_linea[col_fecha], 6, 2)), StrToInt(Copy(str_linea[col_fecha], 9, 2)), strtoint(Copy(str_linea[col_fecha], 12, 2)), strtoint(Copy(str_linea[col_fecha], 15, 2)), strtoint(Copy(str_linea[col_fecha], 18, 2)), 0);

          if (col_f_cancel <> -1) and (((str_linea[col_f_cancel] <> '0000-00-00 00:00:00') and (str_linea[col_f_cancel] <> '')) or (StrToDateDef(str_linea[col_f_cancel], -1) <> -1)) then
            fecha_cancel := encodedatetime(strtoint(Copy(str_linea[col_f_cancel], 1, 4)), strtoint(Copy(str_linea[col_f_cancel], 6, 2)), StrToInt(Copy(str_linea[col_f_cancel], 9, 2)), strtoint(Copy(str_linea[col_f_cancel], 12, 2)), strtoint(Copy(str_linea[col_f_cancel], 15, 2)), strtoint(Copy(str_linea[col_f_cancel], 18, 2)), 0);

          estado := 'P';
          if (col_f_cancel <> -1) and (str_linea[col_f_cancel] <> '') and (str_linea[col_f_cancel] <> '0000-00-00 00:00:00') then
            estado := 'C'
          else if (edCliente.Text = '7252') and ((((str_linea[col_fulfillment] <> 'fulfilled') and (str_linea[col_fulfillment] <> '')) or (str_linea[col_financial] <> 'paid') or (str_linea[col_financial] = ''))) then
            estado := 'A';

          if col_text <> -1 then
            text := str_linea[col_text]
          else
            text := '';

          if col_destino_contacto <> -1 then
            contacto := str_linea[col_destino_contacto]
          else
            contacto := '';

          if col_fulfillment <> -1 then
            fulfillment_status := str_linea[col_fulfillment]
          else
            fulfillment_status := '';

          if col_financial <> -1 then
            financial_status := str_linea[col_financial]
          else
            financial_status := '';

          if col_gateway <> -1 then
            gateway := str_linea[col_gateway]
          else
            gateway := '';

          if col_note <> -1 then
            note := str_linea[col_note]
          else
            note := '';

          if col_tags <> -1 then
            tags := str_linea[col_tags]
          else
            tags := '';

          if col_company <> -1 then
            company := str_linea[col_company]
          else
            company := '';

          if col_cancel_reason <> -1 then
            cancel_reason := str_linea[col_cancel_reason]
          else
            cancel_reason := '';

          if str_linea[col_pedido] = '' then
            estado := 'I';

          order_name := str_linea[col_pedido];

          if order_name<>'' then
             lista_descargados := lista_descargados + order_name + ' OK <br>'
          else
             lista_descargados := lista_descargados + ' Warning!! Pedido en blanco.<br>';

          if (estado<>'I') or ((estado='I') and (aviso_incidencias)) then
              InsertaPedido(id_pedido, StrToInt(edCliente.Text), deliv_time, transporte_propio, repartidor, deleg, 0, 0, str_linea[col_id_order], order_name, str_linea[col_destino_nombre], direccion, str_linea[col_destino_localidad], str_linea[col_destino_provincia],
                            //str_linea[col_destino_prov_code],
                            '', cp, pais, pais_code, telefono, str_linea[col_destino_email], text, '', observaciones, financial_status, fulfillment_status, gateway, company, tags, note, cancel_reason, estado, contacto, '', fecha_ped, fecha_cancel, reembolso);

          Inc(n);

        end
        else
          id_pedido := -1;
      end;

      if (str_linea[0] = 'L') and (id_pedido <> -1) then
      begin                       //Linea
        //Si el artículo tiene IMEI ha de crearse tantas lineas con cantidad=1 como cantidad esté pedida de este artículo,
        //para que luego puedan poner en cada linea el IMEI cogido en el picking
        id_articulo := busca_art(str_linea[col_referencia_articulo]);
        art_tiene_imei := articulo_con_imei(id_articulo);

        if art_tiene_imei then
          j := StrToInt(str_linea[col_unidades])
        else
          j := 1;

        for k := 1 to j do
        begin

          if str_linea[col_nombre_art] <> '' then
            nombre_art := str_linea[col_nombre_art]
          else if id_articulo <> -1 then
            nombre_art := busca_art_nom(id_articulo)
          else
            nombre_art := '';

          if art_tiene_imei then
            cantidad := 1
          else
            cantidad := StrToInt(str_linea[col_unidades]);

          if col_item_id <> -1 then
            item_id := StrToInt(str_linea[col_item_id])
          else
            item_id := 0;

          if (estado<>'I') or ((estado='I') and (aviso_incidencias)) then
             InsertaPedidoLine(id_pedido, id_line, id_articulo, cantidad, item_id, str_linea[col_referencia_articulo], nombre_art);

          {for l := 5 to 7 do
          begin
             if str_linea[l]<>'' then
             begin
                dm.q_1.Close;
                dm.q_1.sql.Clear;
                dm.q_1.sql.Add('insert into c_pedidos_lines_extras '+
                  '(id_pedido, line, extra, valor) ' + //,item_id) '+
                  'values (:id_pedido, :id_line, :extra, :valor)'); //,:item_id)');
                dm.q_1.ParamByName('id_pedido').AsInteger:=id_pedido;
                dm.q_1.ParamByName('id_line').AsInteger:=id_line;
                case l of
                   5: dm.q_1.ParamByName('extra').AsString:='';      //extra1 en web
                   6: dm.q_1.ParamByName('extra').AsString:='';      //extra2 en web
                   7: dm.q_1.ParamByName('extra').AsString:='';      //extra3 en web
                end;
                dm.q_1.ParamByName('valor').AsString:=str_linea[l];
                dm.q_1.ExecQuery;
             end;
          end  }
        end;

        Inc(id_line);
      end;
    end;

    dm.t_write.Commit;

    lb_st1.Caption := 'Importación Finalizada, ' + inttostr(n) + ' Pedidos Importados';
    application.ProcessMessages;


  lb_st1.Caption := 'Marcando Pedidos Como Recibidos en Web';
  ga_stat.MaxValue := n;
  ga_stat.Progress := 0;
  application.ProcessMessages;

  for i := 0 to order_list.count - 1 do
  begin
    GetText := ThSelectHilo.Create(true);
    GetText.FreeOnTerminate := True;
    if order_list[i] <> '' then
      GetText.strurl := httpweb + php_update + order_list[i]
    else
    begin
      GetText.strurl := httpweb + php_update_vacios;
      errors := errors + ' Warning!! Existen pedidos en blanco.<br><br>';
    end;
    hiloactivo := True;
    GetText.Resume;
    while hiloactivo do
      Application.ProcessMessages;

    if (htmldevuelto <> 'HTTP/1.1 200 OK') then
    begin
      //raise exception.Create('Error Actualizando Pedidos.... Avise al Administrador del Sistema, Pedido Nº ' + order_list[i]);

      cuerpo := tstringlist.Create;
      cuerpo.Add('Error actualizando estado en web '+order_list[i] + ':' + htmldevuelto);

      mail := Tf_envia_mail.create(Self);
      mail.Show;
      mail.envia_email('desarrollo@loginser.com', '', 'Error Actualizando Web', '','', cuerpo);
      cuerpo.Free;
      mail.close;
      mail.Free;
    end;
    ga_stat.Progress := ga_stat.Progress + 1;
    Application.ProcessMessages;
  end;


  if envia_error_import and (errors <> '') then
  begin

    if lista_descargados<>'' then
       errors := errors + lista_descargados;

    asunto_error_import_copy := asunto_error_import;
    asunto_error_import_copy := StringReplace(asunto_error_import_copy, '((fecha))', FormatDateTime('yymmdd', Now), [rfReplaceAll]);
    asunto_error_import_copy := StringReplace(asunto_error_import_copy, '((hora))', FormatDateTime('hhnnss', Time), [rfReplaceAll]);

    application.ProcessMessages;
    filter(modo_historico);

    lb_st1.Caption := 'Enviando Correo de Errores';

    cuerpo := tstringlist.Create;
    cuerpo.Add(errors);

    mail := Tf_envia_mail.create(Self);
    mail.Show;
    mail.envia_email(email_error_import, oculta_error_import, asunto_error_import_copy, '', '', cuerpo);
    cuerpo.Free;
    mail.close;
    mail.Free;

    lb_st1.Caption := 'Importación Finalizada con Errores, ' + inttostr(n) + ' Pedidos Importados, ' + ' Error Procesando: ' + errors;

    sMessageDlg('Importación Finalizada, ' + inttostr(n) + ' Pedidos Importados, ' + #13#10 + 'Error Procesando: ' + errors, mtInformation, [mbok], 0);
  end
  else
  begin
    lb_st1.Caption := 'Importación Finalizada, ' + inttostr(n) + ' Pedidos Importados';
    filter(modo_historico);
    sMessageDlg('Importación Finalizada, ' + inttostr(n) + ' Pedidos Importados', mtInformation, [mbok], 0);
  end;

  FreeAndNil(order_list);

  end else
        ImportaCOntinyent;

  bt_import_mdb.Enabled := True;
end;


//IMPORTAR PEDIDOS DESDE CARRITO
procedure Tf_main.btCarritoClick(Sender: TObject);
var
   n: integer;
begin
  btCarrito.Enabled := False;

  n := 0;

  lb_st1.Caption := 'Consultando Pedidos del Carrito';
  application.ProcessMessages;

  {Si se trabaja por grupo hay que recorrer todos los clientes del grupo y descargar los pedidos de cada uno}
  if rgTipoGes.ItemIndex = 1 then
  begin
    with tpfibdataset.Create(dm) do
    begin
      database := dm.db;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select distinct c.id_cliente from g_clientes_config_ c ' + 
                         'inner join g_clientes cl on cl.id_cliente=c.id_cliente ' + 
                         'inner join g_grupos_clientes g on g.id_grupo_cliente=cl.id_grupo_cliente ' + 
                         'where g.id_grupo_cliente=:id_grupo and ((c.item=''tiene_gp'') and (c.valor=''1'')) order by c.id_cliente');
      ParambyName('id_grupo').asinteger := StrToInt(edGrupo.Text);
      Open;

      if not (IsEmpty) then
      begin
        First;
        while not Eof do
        begin
          n := n + DescargaCarrito(FieldByName('id_cliente').AsInteger);
          Next;
        end;
      end;
      Free;
    end;
  end
  else
    DescargaCarrito(StrToInt(edCliente.Text));

  lb_st1.Caption := 'Importación Finalizada, ' + inttostr(n) + ' Pedidos de Carrito Importados';
  application.ProcessMessages;

  if es_oxfam then
    filter(modo_historico);

  btCarrito.Enabled := True;
end;

function Tf_main.DescargaCarrito(id_cliente: Integer): integer;
var
  GetText: thSelecthilo;
  str_lista, str_linea: TStringDynArray;
  i, id_pedido, id_line, n, j, k, tr_propio, rep: integer;
  order_list: tstringlist;
  telefono, cp, estado, cancel_reason: string;
  fin, tiene_imei: boolean;
  cancel_date: TDateTime;

  function encontrado(order: string): Boolean;
  var
    i: integer;
    enc: Boolean;
  begin
    enc := False;
    for i := 0 to order_list.Count - 1 do
    begin
      if order_list[i] = order then
        enc := true;
    end;
    Result := enc;
  end;

begin
  id_pedido := 999999;
  id_line := 1;
  n := 0;
  order_list := tstringlist.Create();

  GetText := ThSelectHilo.Create(true);
  GetText.FreeOnTerminate := True;
  GetText.strurl := httpweb + 'sync_get_ordersCART.php?id_cliente=' + IntToStr(id_cliente);
  hiloactivo := True;
  GetText.Resume;
  while hiloactivo do
    Application.ProcessMessages;

  str_lista := splitstring(htmldevuelto, sep1);                    //Separa lineas por sep1 $

  dm.t_write.StartTransaction;
  try
    for i := Low(str_lista) to High(str_lista) - 1 do
    begin

      str_linea := splitstring(str_lista[i], sep2);

      if (str_linea[0] = 'C') and (str_linea[1] = IntToStr(id_cliente)) then
      begin                      //Cabecera

        if not encontrado(str_linea[2]) then
        begin
          with TpFIBDataSet.Create(self) do
          try
            Database := dm.db;
            sqls.SelectSQL.Add('SELECT GEN_ID(GEN_C_PEDIDOS_ID,1) FROM RDB$DATABASE');
            Open;
            id_pedido := FieldByName('gen_id').AsInteger;
          finally
            free;
          end;

          id_line := 1;
          order_list.Add(str_linea[2]);

            //Código Postal
          if str_linea[11] = 'ES' then
            cp := format_cp(str_linea[9])
          else
            cp := str_linea[9];

            //Teléfono
          telefono := ReplaceStr(str_linea[13], ' ', '');
          telefono := ReplaceStr(telefono, '.', '');
          telefono := ReplaceStr(telefono, '-', '');
          telefono := ReplaceStr(telefono, ',', '');
          telefono := ReplaceStr(telefono, '+', '');
          if str_linea[11] = 'ES' then
            if Length(telefono) > 9 then
              telefono := copy(telefono, Length(telefono) - 8, 9);

            //Cancelación
          if ((str_linea[19] <> '0000-00-00 00:00:00') and (str_linea[19] <> '')) then
          begin
            cancel_date := encodedatetime(strtoint(Copy(str_linea[19], 1, 4)), strtoint(Copy(str_linea[19], 6, 2)), StrToInt(Copy(str_linea[19], 9, 2)), strtoint(Copy(str_linea[19], 12, 2)), strtoint(Copy(str_linea[19], 15, 2)), strtoint(Copy(str_linea[19], 18, 2)), 0);
            cancel_reason := str_linea[20];
          end;

            //Estado
          estado := 'P';
          if (str_linea[20] <> '') then
            estado := 'C'
          else if id_cliente = 7252 then
            if (((str_linea[17] <> 'fulfilled') and (str_linea[17] <> '')) or (str_linea[14] <> 'paid') or (str_linea[14] = '')) then
              estado := 'A';

          tr_propio := StrToInt(LoadFieldConfigCliente('transporte_propio', id_cliente));
          if tr_propio = 1 then
            rep := 0
          else
            rep := repartidor;

          InsertaPedido(id_pedido, StrToInt(str_linea[1]), delivery_time, tr_propio, rep, 9999, StrToInt(str_linea[24]), StrToInt(str_linea[25]), str_linea[2], str_linea[3], str_linea[4], str_linea[5] + ' ' + str_linea[6], str_linea[7], str_linea[8], '', cp, str_linea[10], str_linea[11], telefono, str_linea[16], str_linea[15], '', str_linea[23], str_linea[14], str_linea[17], str_linea[15], str_linea[21], str_linea[18], str_linea[22], cancel_reason, estado, str_linea[26],'', encodedatetime(strtoint(Copy(str_linea[12], 1, 4)), strtoint(Copy(str_linea[12], 6, 2)), StrToInt(Copy(str_linea[12], 9, 2)), strtoint(Copy(str_linea[12], 12, 2)), strtoint(Copy(str_linea[12], 15, 2)), strtoint(Copy(str_linea[12], 18, 2)), 0), cancel_date, 0);
          Inc(n);
        end
        else
          id_pedido := -1;

      end;

      if (str_linea[0] = 'L') and (id_pedido <> -1) then
      begin                       //Linea
        //Si el artículo tiene IMEI ha de crearse tantas lineas con cantidad=1 como cantidad esté pedida de este artículo,
        //para que luego puedan poner en cada linea el IMEI cogido en el picking
        tiene_imei := articulo_con_imei(busca_art(str_linea[3], id_cliente));
        if tiene_imei then
          j := StrToInt(str_linea[4])
        else
          j := 1;

        for k := 1 to j do
        begin
          dm.q_1.Close;
          dm.q_1.sql.Clear;
          dm.q_1.sql.Add('insert into c_pedidos_lines ' + '(id_pedido, id_line, id_articulo, cantidad,sku,nombre_art) ' + //,item_id) '+
            'values (:id_pedido, :id_line, :id_articulo, :cantidad, :sku, :nombre_art)'); //,:item_id)');
          dm.q_1.ParamByName('id_pedido').AsInteger := id_pedido;
          dm.q_1.ParamByName('id_line').AsInteger := id_line;
          dm.q_1.ParamByName('id_articulo').asinteger := busca_art(str_linea[3], id_cliente);

          if tiene_imei then
            dm.q_1.ParamByName('cantidad').asinteger := 1
          else
            dm.q_1.ParamByName('cantidad').asinteger := StrToInt(str_linea[4]);

          dm.q_1.ParamByName('sku').AsString := str_linea[3];
          dm.q_1.ParamByName('nombre_art').AsString := str_linea[2];
          //dm.q_1.ParamByName('item_id').AsString:=str_linea[5];
          dm.q_1.ExecQuery;

          Inc(id_line);
        end;

        //Inc(id_line);
      end;
    end;

    dm.t_write.Commit;

    ga_stat.MaxValue := n;
    ga_stat.Progress := 0;
    application.ProcessMessages;

    for i := 0 to order_list.count - 1 do
    begin
      lb_st1.Caption := 'Marcando Pedidos Como Recibidos en Carrito ' + order_list[i];
      GetText := ThSelectHilo.Create(true);
      GetText.FreeOnTerminate := True;
      GetText.strurl := httpweb + 'sync_update_ordersCART.php?id_order=' + order_list[i];
      hiloactivo := True;
      GetText.Resume;
      while hiloactivo do
        Application.ProcessMessages;

      if (htmldevuelto <> 'HTTP/1.1 200 OK') then
        raise exception.Create('Error Actualizando Carrito.... Avise al Administrador del Sistema, Pedido Nº ' + order_list[i]);

      ga_stat.Progress := ga_stat.Progress + 1;
      Application.ProcessMessages;
    end;
  except
    dm.t_write.Rollback;
  end;

  FreeAndNil(order_list);

  Result := n;
end;


//IMPORTA PEDIDOS DESDE CSV o excel
procedure Tf_main.bt_importClick(Sender: TObject);
type
  TLineas = record
    id_pedido, id_line, id_articulo, uds: Integer;
    sku, nom: string;
  end;
type
  TPeso = record
    id_pedido: Integer;
    peso: double;
  end;
var
  fic: tstringlist;
  i,j,l, id_articulo: integer;
  order_name_old, cp, telefono, nombre_art, pais, observaciones, email, pedidos, ref_aux, ceco: string;
  str_dyn: TStringDynArray;
  id_pedido, id_line, n, deliv_time, r, deleg, ag_gestoras, agencia, idx_ln, idx_peso: Integer;
  fin: Boolean;
  fileConfig: u_functions.TIntArray;
  reembolso, reemb_value, pd_value: Double;
  col_codigo_cliente, col_cliente_deleg, col_codigo_albaran, col_fecha, col_referencia_articulo, col_destino_delegacion,
  col_destino_nombre, col_destino_direccion, col_destino_localidad, col_destino_cp, col_destino_provincia,
  col_destino_telefono, col_destino_email, col_destino_contacto, col_observaciones, col_pais, col_unidades,
  col_delivery_time, col_reembolso, col_portes_debidos, col_pedido, col_peso, col_ceco, col_idx: Integer;
  lineas: array of TLineas;
  enc: Boolean;
  pesos: array of TPeso;
  uds_ped: integer;
  import_log: TStringList;
  file_name: string;
  Dialog: TForm;
  msg_error: string;
function calcula_peso_haya(num_arts:Integer): integer;
var
  i, cont, cont_peso:integer;
  enc: Boolean;
begin
    enc := false;
    cont := 10;
    cont_peso := 0;
    uds_ped := 0;

    while not enc do
    begin
       Inc(cont_peso);
       enc := (num_arts>=cont-9) and (num_arts<=cont);
       if not enc then
          cont := cont + 10;
    end;

    Result := cont_peso;
end;

begin
  Screen.Cursor := crHourglass;

  pedidos := '';
  idx_ln := 1;
  idx_peso := 1;
  id_pedido := -1;
  agencia := -1;
  file_name := '';
  import_log := TStringList.Create;
  msg_error := '';

  {if import_xls_agr_art then
       SetLength(lineas,idx_ln);  }


  if FileExists(ed_csv.filename) then
  begin
    if edCliente.Text = '7252' then
      u_privalia.importa_fichero_privalia
    else
    begin

      try
        fic := tstringlist.create();
        fic.LoadFromFile(ed_csv.filename);

        AbreFichero(ed_csv.FileName);
        Hoja := excel.Worksheets.Item[1];
        //hoja.cells[0, 0] := '';

        order_name_old := '9999999';
        n := 0;

        if not chAntonio.Checked then
            fileConfig := u_functions.GetFileConfig(StrToInt(edCliente.Text))
        else
            fileConfig := u_functions.GetFileConfig(74282);

        if fileConfig[0] >= 0 then
          col_codigo_cliente := fileConfig[0] + 1
        else
          col_codigo_cliente := fileConfig[0];

        if fileConfig[1] >= 0 then
          col_cliente_deleg := fileConfig[1] + 1
        else
          col_cliente_deleg := fileConfig[1];

        if fileConfig[2] >= 0 then
          col_codigo_albaran := fileConfig[2] + 1
        else
          col_codigo_albaran := fileConfig[2];

        if fileConfig[3] >= 0 then
          col_fecha := fileConfig[3] + 1
        else
          col_fecha := fileConfig[3];

        if fileConfig[4] >= 0 then
          col_referencia_articulo := fileConfig[4] + 1
        else
          col_referencia_articulo := fileConfig[4];

        if fileConfig[5] >= 0 then
          col_destino_delegacion := fileConfig[5] + 1
        else
          col_destino_delegacion := fileConfig[5];

        if fileConfig[6] >= 0 then
          col_destino_nombre := fileConfig[6] + 1
        else
          col_destino_nombre := fileConfig[6];

        if fileConfig[7] >= 0 then
          col_destino_direccion := fileConfig[7] + 1
        else
          col_destino_direccion := fileConfig[7];

        if fileConfig[8] >= 0 then
          col_destino_localidad := fileConfig[8] + 1
        else
          col_destino_localidad := fileConfig[8];

        if fileConfig[9] >= 0 then
          col_destino_cp := fileConfig[9] + 1
        else
          col_destino_cp := fileConfig[9];

        if fileConfig[10] >= 0 then
          col_destino_provincia := fileConfig[10] + 1
        else
          col_destino_provincia := fileConfig[10];

        if fileConfig[11] >= 0 then
          col_destino_telefono := fileConfig[11] + 1
        else
          col_destino_telefono := fileConfig[11];

        if fileConfig[12] >= 0 then
          col_destino_email := fileConfig[12] + 1
        else
          col_destino_email := fileConfig[12];

        if fileConfig[13] >= 0 then
          col_destino_contacto := fileConfig[13] + 1
        else
          col_destino_contacto := fileConfig[13];

        if fileConfig[14] >= 0 then
          col_observaciones := fileConfig[14] + 1
        else
          col_observaciones := fileConfig[14];

        if fileConfig[15] >= 0 then
          col_pais := fileConfig[15] + 1
        else
          col_pais := fileConfig[15];

        if fileConfig[16] >= 0 then
          col_unidades := fileConfig[16] + 1
        else
          col_unidades := fileConfig[16];

        if fileConfig[17] >= 0 then
          col_delivery_time := fileConfig[17] + 1
        else
          col_delivery_time := fileConfig[17];

        if fileConfig[18] >= 0 then
          col_reembolso := fileConfig[18] + 1
        else
          col_reembolso := fileConfig[18];

        if fileConfig[19] >= 0 then
          col_portes_debidos := fileConfig[19] + 1
        else
          col_portes_debidos := fileConfig[19];

        if fileConfig[20] >= 0 then
          col_pedido := fileConfig[20] + 1
        else
          col_pedido := fileConfig[20];

        if fileConfig[35] >= 0 then
          col_peso := fileConfig[35] + 1
        else
          col_peso := fileConfig[35];

        if fileConfig[36] >= 0 then
          col_idx := fileConfig[36] + 1
        else
          col_idx := fileConfig[36];

        if fileConfig[37] >= 0 then
          col_ceco := fileConfig[37] + 1
        else
          col_ceco := fileConfig[37];

        for i := 0 to fic.Count - 1 do
        begin

          if ExtractFileExt(ed_csv.FileName) = '.csv' then      //CSV
          begin
            str_dyn := splitstring(fic[i], ';');

            if order_name_old <> str_dyn[1] then
            begin              //new cabecera

              if (uds_ped>=0) and (id_pedido>0) then
              begin
                SetLength(pesos,idx_peso);
                pesos[idx_peso-1].id_pedido := id_pedido;
                pesos[idx_peso-1].peso:= Double(calcula_peso_haya(uds_ped));
                Inc(idx_peso);
              end;

              uds_ped := 0;

              order_name_old := str_dyn[1];

              with TpFIBDataSet.Create(self) do
              try
                Database := dm.db;
                sqls.SelectSQL.Add('SELECT GEN_ID(GEN_C_PEDIDOS_ID,1) FROM RDB$DATABASE');
                Open;
                id_pedido := FieldByName('gen_id').AsInteger;
              finally
                free;
              end;

              pedidos := pedidos + InttoStr(id_pedido) + ',';

              id_line := 1;

              if col_destino_delegacion = -1 then
                deleg := -1
              else if str_dyn[col_destino_delegacion, r] = '' then
                deleg := -1
              else
                deleg := StrToInt(str_dyn[col_destino_delegacion, r]);

              if col_delivery_time = -1 then
                deliv_time := delivery_default
              else if str_dyn[col_delivery_time] <> '' then
                deliv_time := StrToInt(str_dyn[col_delivery_time])
              else
                deliv_time := delivery_default;

              if col_pais = -1 then
                pais := 'ES'
              else
                pais := str_dyn[col_pais];

              if pais = 'ES' then
                cp := format_cp(str_dyn[col_destino_cp])
              else
                cp := str_dyn[col_destino_cp];

              if pais = 'ES' then
              begin
                if Length(str_dyn[col_destino_telefono]) > 9 then
                  telefono := copy(str_dyn[col_destino_telefono], Length(str_dyn[col_destino_telefono]) - 8, 9)
                else
                  telefono := str_dyn[col_destino_telefono];
              end
              else
                telefono := str_dyn[col_destino_telefono];

              if col_reembolso <> -1 then
                reembolso := StrToFloat(str_dyn[col_reembolso, r])
              else
                reembolso := 0;

              if col_observaciones = -1 then
                observaciones := ''
              else
                observaciones := str_dyn[col_observaciones, r];

              if col_destino_email = -1 then
                email := ''
              else
                email := str_dyn[col_destino_email];

              if col_ceco = -1 then
                ceco := ''
              else
                ceco := str_dyn[col_ceco];
                                                                                                                       //order_name        //nombre
              InsertaPedido(id_pedido, StrToInt(edCliente.Text), deliv_time, transporte_propio, repartidor, deleg, 0, 0, '', str_dyn[col_pedido], str_dyn[col_destino_nombre],
                            //dir                          //poblacion                    //provincia                                         //email                   //text
                str_dyn[col_destino_direccion], str_dyn[col_destino_localidad], str_dyn[col_destino_provincia], '', cp, pais, null, telefono, str_dyn[col_destino_email], '',
                            //track             //observaciones                                  //fecha_ped
                str_dyn[col_pedido], observaciones, '', '', '', '', '', '', '', 'P', Trim(hoja.cells[r, col_destino_contacto]),ceco, StrToDate(str_dyn[col_fecha]), StrToDate('30/12/1899'), reembolso);

              Inc(n);
            end;

            id_articulo := busca_art(str_dyn[col_referencia_articulo],main_cli);

            if id_articulo <> -1 then
               nombre_art := busca_art_nom(id_articulo)
            else
              nombre_art := '';

            if import_xls_agr_art then
            begin
                enc := false;
                
                for j := 0 to High(lineas) do
                begin
                   if ((lineas[j].id_pedido=id_pedido) and
                       (lineas[j].id_articulo=id_articulo)) then
                   begin
                         lineas[j].uds := lineas[j].uds + StrToInt(str_dyn[col_unidades]);
                         enc := true;
                   end;
                end;

                if not enc then
                begin
                  SetLength(lineas,idx_ln);
                  lineas[idx_ln].id_pedido := id_pedido;
                  lineas[idx_ln].id_line := id_line;
                  lineas[idx_ln].id_articulo := id_articulo;
                  lineas[idx_ln].uds := StrToInt(str_dyn[col_unidades]);
                  lineas[idx_ln].sku := str_dyn[col_referencia_articulo];
                  lineas[idx_ln].nom := nombre_art;
                  Inc(id_line);
                end;
            end else begin
              if ((not tiene_control_stock_0)
                    or
                  (tiene_control_stock_0 and (GetStock(id_articulo)>0)))
              then                                                            //cantidad   //sku
                  InsertaPedidoLine(id_pedido, id_line, id_articulo, StrToInt(str_dyn[col_unidades]), -1, str_dyn[col_referencia_articulo], nombre_art);

              Inc(id_line);
            end;    
          end
          else if ((ExtractFileExt(ed_csv.FileName) = '.xls') or (ExtractFileExt(ed_csv.FileName) = '.xlsx')) then      //XLS
          begin

            fin := False;
            r := 2; //Empezamos desde la fila 2 ignoramos las cabeceras

                      //CopyFile(PWideChar(ed_csv.FileName),PWideChar(ChangeFileExt(ed_csv.FileName,'.xlsx')),False);

                      //xls.Filename := ChangeFileExt(ed_csv.FileName,'.xlsx');
                      //xls.Read;

            //Primero recorremos las lineas buscando errores:
            //- Articulos no existentes en bd
            while not (Trim(hoja.cells[r, 1]) = '') do
            begin
              if main_cli=6695 then
                   id_articulo := busca_art(Trim(hoja.cells[r, col_referencia_articulo]))
              else
                   id_articulo := busca_art(Trim(hoja.cells[r, col_referencia_articulo]),main_cli);

              if id_articulo<0 then
                import_log.Add(IntToStr(r) + ': ' + Trim(hoja.cells[r, col_referencia_articulo]) + ' No existe');
              Inc(r);
            end;

            if (import_log.Count <= 0) then
            begin

              dm.t_write.StartTransaction;

              fin := False;
              r := 2; //Empezamos desde la fila 2 ignoramos las cabeceras

              while not (Trim(hoja.cells[r, 1]) = '') do
              begin

                if ((col_idx<0) and (order_name_old <> Trim(hoja.cells[r, col_pedido])))
                   or
                   ((col_idx>=0) and (order_name_old <> Trim(hoja.cells[r, col_idx])))
                then
                begin              //new cabecera

                  if (uds_ped>=0) and (id_pedido>0) then
                  begin
                    SetLength(pesos,idx_peso);
                    pesos[idx_peso-1].id_pedido := id_pedido;
                    pesos[idx_peso-1].peso:= calcula_peso_haya(uds_ped);
                    Inc(idx_peso);
                  end;

                  uds_ped := 0;

                  if col_idx<0 then
                        order_name_old := Trim(hoja.cells[r, col_pedido])
                  else
                        order_name_old := Trim(hoja.cells[r, col_idx]);

                  with TpFIBDataSet.Create(self) do
                  try
                    Database := dm.db;
                    sqls.SelectSQL.Add('SELECT GEN_ID(GEN_C_PEDIDOS_ID,1) FROM RDB$DATABASE');
                    Open;
                    id_pedido := FieldByName('gen_id').AsInteger;
                  finally
                    free;
                  end;

                  pedidos := pedidos + InttoStr(id_pedido) + ',';

                  id_line := 1;

                  if col_delivery_time = -1 then
                    deliv_time := delivery_default
                  else if trim(hoja.cells[r, col_delivery_time]) <> '' then
                    deliv_time := StrToInt(hoja.cells[r, col_delivery_time])
                  else
                    deliv_time := delivery_default;

                  if col_pais = -1 then
                    pais := 'ES'
                  else
                    pais := Trim(hoja.cells[r, col_pais]);

                  if pais = 'ES' then
                    cp := format_cp(Trim(hoja.cells[r, col_destino_cp]))
                  else
                    cp := Trim(hoja.cells[r, col_destino_cp]);

                  if pais = 'ES' then
                  begin
                    if Length(Trim(hoja.cells[r, col_destino_telefono])) > 9 then
                      telefono := copy(Trim(hoja.cells[r, col_destino_telefono]), Length(Trim(hoja.cells[r, col_destino_telefono])) - 8, 9)
                    else
                      telefono := Trim(hoja.cells[r, col_destino_telefono]);
                  end
                  else
                    telefono := Trim(hoja.cells[r, col_destino_telefono]);

                  if col_destino_delegacion = -1 then
                    deleg := -1
                  else if Trim(hoja.cells[r, col_destino_delegacion]) = '' then
                    deleg := -1
                  else
                    deleg := StrToInt(Trim(hoja.cells[r, col_destino_delegacion]));

                              //Fanessi Reembolso= mayor entre reembolso y portes debidos
                              //        Observaciones= cobrar reembolso + observaciones
                  if edCliente.Text = '6695' then
                  begin
                    if Trim(hoja.cells[r, col_reembolso]) = '' then
                      reemb_value := 0
                    else
                      reemb_value := StrToFloat(Trim(hoja.cells[r, col_reembolso]));

                    if Trim(hoja.cells[r, col_portes_debidos]) = '' then
                      pd_value := 0
                    else
                      pd_value := StrToFloat(Trim(hoja.cells[r, col_portes_debidos]));

                    if reemb_value > pd_value then
                      reembolso := reemb_value
                    else
                      reembolso := pd_value;

                    if reembolso > 0 then
                      observaciones := 'COBRAR ' + FloatToStr(reembolso) + '€. ' + Trim(hoja.cells[r, col_observaciones])
                    else
                      observaciones := Trim(hoja.cells[r, col_observaciones]);

                  end
                  else
                  begin
                    if col_reembolso <> -1 then
                    begin
                      if Trim(hoja.cells[r, col_reembolso]) = '' then
                        reembolso := 0
                      else
                        reembolso := StrToFloat(Trim(hoja.cells[r, col_reembolso]));
                    end
                    else
                      reembolso := 0;

                    if col_observaciones = -1 then
                      observaciones := ''
                    else
                      observaciones := Trim(hoja.cells[r, col_observaciones]);
                  end;

                  if col_destino_email = -1 then
                    email := ''
                  else
                    email := Trim(hoja.cells[r, col_destino_email]);

                  if col_ceco = -1 then
                    ceco := ''
                  else
                    ceco := Trim(hoja.cells[r, col_ceco]);

                  if col_pedido>=0 then                                                                                                                       //order_name           //nombre
                    InsertaPedido(id_pedido, StrToInt(edCliente.Text), deliv_time, transporte_propio, repartidor, deleg, 0, 0, '', Trim(hoja.cells[r, col_pedido]), Trim(hoja.cells[r, col_destino_nombre]),
                                //dir                              //poblacion                        //provincia
                      Trim(hoja.cells[r, col_destino_direccion]), Trim(hoja.cells[r, col_destino_localidad]), Trim(hoja.cells[r, col_destino_provincia]), '', cp, pais, '', telefono,
                                //email                       //text //track              //observaciones                                                        //fecha_ped
                      email, '', Trim(hoja.cells[r, col_pedido]), observaciones, '', '', '', '', '', '', '', 'P', Trim(hoja.cells[r, col_destino_contacto]),ceco, Now, StrToDate('30/12/1899'), reembolso)
                  else
                      InsertaPedido(id_pedido, StrToInt(edCliente.Text), deliv_time, transporte_propio, repartidor, deleg, 0, 0, '', IntToStr(id_pedido), Trim(hoja.cells[r, col_destino_nombre]),
                              //dir                              //poblacion                        //provincia
                    Trim(hoja.cells[r, col_destino_direccion]), Trim(hoja.cells[r, col_destino_localidad]), Trim(hoja.cells[r, col_destino_provincia]), '', cp, pais, '', telefono,
                              //email                       //text //track              //observaciones                                             //fecha_ped
                    email, '', IntToStr(id_pedido), observaciones, '', '', '', '', '', '', '', 'P', Trim(hoja.cells[r, col_destino_contacto]),ceco, Now, StrToDate('30/12/1899'), reembolso);

                  Inc(n);

                end;

                if main_cli=6695 then
                    id_articulo := busca_art(Trim(hoja.cells[r, col_referencia_articulo]))
                else
                    id_articulo := busca_art(Trim(hoja.cells[r, col_referencia_articulo]),main_cli);

                nombre_art := busca_art_nom(id_articulo);

                if id_articulo <> -1 then
                  nombre_art := busca_art_nom(id_articulo)
                else
                  nombre_art := '';

                if import_xls_agr_art then
                begin
                  enc := false;
                
                  for j := 0 to High(lineas) do
                  begin
                     if ((lineas[j].id_pedido=id_pedido) and
                         (lineas[j].id_articulo=id_articulo)) then
                     begin
                         if col_unidades>=0 then
                             lineas[j].uds := lineas[j].uds + StrToInt(Trim(hoja.cells[r, col_unidades]))
                         else
                             lineas[j].uds := lineas[j].uds + 1;

                         enc := true;
                     end;
                  end;

                  if not enc then
                  begin
                    SetLength(lineas,idx_ln);
                    lineas[idx_ln-1].id_pedido := id_pedido;
                    lineas[idx_ln-1].id_line := id_line;
                    lineas[idx_ln-1].id_articulo := id_articulo;
                    if col_unidades>0 then
                         lineas[idx_ln-1].uds := StrToInt(Trim(hoja.cells[r, col_unidades]))
                    else
                         lineas[idx_ln-1].uds := 1;
                    ref_aux := Trim(hoja.cells[r, col_referencia_articulo]);
                    lineas[idx_ln-1].nom := nombre_art;
                    lineas[idx_ln-1].sku := ref_aux;

                    uds_ped := uds_ped + lineas[idx_ln-1].uds;

                    Inc(idx_ln);
                    Inc(id_line);
                  end;
                end else begin

                  if ((not tiene_control_stock_0)
                      or
                      (tiene_control_stock_0 and (get_stock_x_art(id_articulo,id_almacen)>0)))
                  then                                                                                      //cantidad                //sku
                      InsertaPedidoLine(id_pedido, id_line, id_articulo, StrToInt(Trim(hoja.cells[r, col_unidades])), -1, Trim(hoja.cells[r, col_referencia_articulo]), nombre_art);

                  Inc(id_line);
                
                end;
                Inc(r);
              end;

              //Si se ha terminado de recorrer las lineas se guarda el peso y cp del último pedido
              //porque ya no vuelve a entrar en el while y no lo guarda
              if (Trim(hoja.cells[r, 1]) = '') and  (uds_ped>=0) and (id_pedido>0) then
              begin
                SetLength(pesos,idx_peso);
                pesos[idx_peso-1].id_pedido := id_pedido;
                pesos[idx_peso-1].peso:= Double(calcula_peso_haya(uds_ped));
                Inc(idx_peso);
              end;
                      //DeleteFile(ChangeFileExt(ed_csv.FileName,'.xlsx'));

            end else begin

                      Dialog := CreateMessageDialog('Existen datos a revisar. ¿Desea verlos en pantalla o exportar a fichero?', mtWarning, [mbYes, mbNo, mbCancel]);

                      TButton(Dialog.Controls[2]).Caption := 'Pantalla';
                      TButton(Dialog.Controls[3]).Caption := 'Fichero';
                      TButton(Dialog.Controls[4]).Caption := 'Cancelar';

                      msg_error := '';
                      if import_log.Count > 0 then
                        for l := 0 to import_log.Count - 1 do
                          msg_error := msg_error + import_log[l] + ln;

                      try
                        case Dialog.ShowModal of
                          mrYes:
                            begin
                              InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','ImportPeds.ErroresPantalla',msg_error);
                              sShowMessage('Log Importación Pedidos', msg_error);
                            end;

                          mrNo: begin
                            file_name := IncludeTrailingPathDelimiter(ed_folder.text) + 'LOG_IMPORT_' + formatdatetime('dd_mm_yyyy__hh_nn', Now) + '.txt';
                            import_log.SaveToFile(file_name);
                            InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','ImportPeds.ErroresFichero',file_name + '|' + msg_error);
                          end;

                          mrCancel: begin
                            InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','ImportPeds.ErroresCancel',msg_error);
                            Dialog.Close;
                          end;
                        end;
                      finally
                        Dialog.Free;
                      end;

                end;
          end;
        end;

        if import_log.Count<=0 then
        begin
          if import_xls_agr_art then
          begin
            for i := 0 to High(lineas) do
            begin
               if ((not tiene_control_stock_0)
                      or
                   (tiene_control_stock_0 and (get_stock_x_art(lineas[i].id_articulo,id_almacen)>0)))
               then                                                                                      //cantidad                //sku
                      InsertaPedidoLine(lineas[i].id_pedido, lineas[i].id_line, lineas[i].id_articulo, lineas[i].uds, -1, lineas[i].sku, lineas[i].nom);
            end;
          end;

          if (main_cli=7428) and (chAntonio.Checked) then
          begin
            for i := 0 to High(pesos) do
            begin
               try
                  dm.q_1.Close;
                  dm.q_1.sql.Clear;
                  dm.q_1.sql.Add('update c_pedidos set peso=:peso where id_pedido=:id_pedido');
                  dm.q_1.ParamByName('id_pedido').AsInteger := pesos[i].id_pedido;
                  dm.q_1.ParamByName('peso').AsFloat := pesos[i].peso;
                  dm.q_1.ExecQuery;
                except
                  dm.t_write.rollback;
                end;
            end;
          end;

          dm.t_write.Commit;

        end;


      except
        on e: Exception do
        begin
          sMessageDlg('Error Importando Fichero ' + e.message, mtError, [mbok], 0);
          dm.t_write.Rollback;

          if FileExists(ChangeFileExt(ed_csv.FileName, '.xlsx')) then
            DeleteFile(ChangeFileExt(ed_csv.FileName, '.xlsx'));

          //excel.activeworkbook.save;
          Excel.Quit;
          Excel := Unassigned;

          Screen.Cursor := crDefault;

          exit;
        end;
      end;

      //excel.activeworkbook.save;
      Excel.Quit;
      Excel := Unassigned;

      if import_xls_agr_art then
       lineas := nil;

      if col_peso>=0 then
       pesos := nil;

      lb_st1.Caption := 'Asignando agencias ...';

      asigna_repartidor(Copy(pedidos, 1, Length(pedidos) - 1));

      lb_st1.Caption := 'Importación Finalizada, ' + inttostr(n) + ' Pedidos Importados';
      application.ProcessMessages;

      if es_oxfam then
        filter(modo_historico);

      Screen.Cursor := crDefault;

      sMessageDlg('Importación Finalizada, ' + inttostr(n) + ' Pedidos Importados', mtInformation, [mbok], 0);

    end;
  end
  else
    ShowMessage('Debe insertar un fichero válido.');
end;
{$ENDREGION}

{$REGION 'Generar'}
//GENERA ENVIOS

procedure Tf_main.servicio(Sender: TObject);
var
  pedidos: string;
  Dialog: TForm;
  i: integer;
  todos, cancelado: boolean;
begin

  Screen.Cursor := crHourglass;

  pnPtes.Enabled := False;

   {Si se trabaja por grupo hay que recorrer todos los clientes del grupo y descargar los pedidos de cada uno}
  if rgTipoGes.ItemIndex = 1 then
  begin
    with tpfibdataset.Create(dm) do
    begin
      database := dm.db;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select distinct c.id_cliente from g_clientes_config_ c ' +
                         'inner join g_clientes cl on cl.id_cliente=c.id_cliente ' +
                         'inner join g_grupos_clientes g on g.id_grupo_cliente=cl.id_grupo_cliente ' +
                         'inner join c_pedidos p on p.id_cliente=cl.id_cliente ' +
                         'where ((c.item=''tiene_gp'') and (c.valor=''1'')) and  ((p.estado=''X'') or (p.estado=''P'')) and g.id_grupo_cliente=:id_grupo');
      ParambyName('id_grupo').asinteger := StrToInt(edGrupo.Text);
      Open;

      if not (IsEmpty) then
      begin
        First;
        while not Eof do
        begin
          edCliente.Text := FieldByName('id_cliente').AsString;
          GeneraPedidos('');
          Next;
        end;
      end
      else
        ShowMessage('No existen pedidos a generar.');
      Free;
    end;
  end
  else
  begin
    peds_encadenados := '';
    todos := true;
    cancelado := False;

    if gr_envs.SelCount > 0 then
    begin
      todos := false;
      Dialog := CreateMessageDialog('Existe una multiselección. ¿Qué pedidos desea generar?', mtWarning, [mbYes, mbNo, mbCancel]);

      TButton(Dialog.Controls[2]).Caption := 'Todo';
      TButton(Dialog.Controls[3]).Caption := 'Selección';
      TButton(Dialog.Controls[4]).Caption := 'Cancelar';

      try
        case Dialog.ShowModal of
          mrYes:
            begin
              if (MessageDlg('Va a generar TODOS los pedidos PENDIENTES y SIN STOCK, ¿desea continuar?', mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes) then
                todos := True
              else
                cancelado := true;
            end;
          mrNo:
            begin
              if (MessageDlg('Va a generar los pedidos SELECCIONADOS, ¿desea continuar?', mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes) then
                todos := False
              else
                cancelado := true;
            end;
          mrCancel:
            cancelado := true;
        end;
      finally
        Dialog.Free;
      end;
    end;

    if not cancelado then
    begin
      if todos then    //generar todos los pedidos
      begin
        with TpFIBDataSet.Create(self) do
        try
          Database := dm.db;
          sqls.SelectSQL.Add('select id_pedido ' +
                             'from c_pedidos ' +
                             'where ((estado=''X'') or (estado=''P'')) ' +
                             'and id_cliente=:id_cliente order by id_pedido');
          ParamByName('id_cliente').AsInteger := StrToInt(edCliente.Text);
          Open;

          if not IsEmpty then
          begin
            pedidos := '';
            First;
            while not eof do
            begin
              pedidos := pedidos + FieldByName('id_pedido').AsString + ',';
              Next;
            end;
          end
          else
            ShowMessage('No existen pedidos a generar.');
        finally
          free;
        end;
      end
      else
      begin  //generar solo seleccionados
        pedidos := '';

        for i := 0 to gr_envs.SelCount - 1 do
        begin
          gr_envs.GotoSelection(i);
          pedidos := pedidos + dm.q_peds.FieldByName('id_pedido').AsString + ',';
        end;
      end;

      dm.t_write.StartTransaction;

      try

        GeneraPedidos(Copy(pedidos, 1, Length(pedidos) - 1));

        if peds_encadenados <> '' then
          GeneraPedidos(Copy(peds_encadenados, 1, Length(peds_encadenados) - 1));

        dm.t_write.Commit;

      except on e:Exception do begin
        dm.t_write.rollback;
        InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','',
                   'Error GeneraPeds',e.Message + '|' + Copy(pedidos, 1, Length(pedidos) - 1));
      end;
      end;

     filter(modo_historico);

                    //sMessageDlg('Proceso Finalizado',mtInformation,[mbok],0);
    end
    else
      lb_st1.Caption := 'Proceso cancelado.';
  end;

  pnPtes.Enabled := True;

  Screen.Cursor := crDefault;
end;
{$ENDREGION}

{$REGION 'Aux'}

function Tf_main.format_cp(cp: string): string;
begin
  if Length(cp) < 5 then
    result := '0' + cp
  else
    result := cp;
end;

function Tf_main.busca_art(cod_cli: string; id_cliente: integer): integer;
begin                                       //devuelve id de articulo a partir de codigo de cliente y cliente
  with tpfibdataset.Create(dm) do
  begin
    database := dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select id_articulo from g_articulos where codigo_cli=:codigo_cli ' +
                       ' and id_cliente=:id_cliente');
    ParambyName('codigo_cli').asstring := cod_cli;
    ParambyName('id_cliente').asinteger := id_cliente;
    Open;

    if not (IsEmpty) then
      Result := FieldByName('id_articulo').asinteger
    else
      result := -1;

    Free;
  end;
end;

function Tf_main.busca_art(codigo: string): integer;
begin                                       //devuelve id de articulo a partir de codigo
  with tpfibdataset.Create(dm) do
  begin
    database := dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select id_articulo from g_articulos where codigo=:codigo');
    ParambyName('codigo').asstring := codigo;
    Open;

    if not (IsEmpty) then
      Result := FieldByName('id_articulo').asinteger
    else
      result := -1;

    Free;
  end;
end;

function tf_main.busca_art_ref(id: integer): string;
begin                                       //devuelve referencia de articulo a partir de id
  with tpfibdataset.Create(dm) do
  begin
    database := dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select codigo from g_articulos where id_articulo=' + inttostr(id));
    Open;

    if not (IsEmpty) then
      Result := FieldByName('codigo').asstring
    else
      result := 'ERR';

    Free;
  end;
end;

function tf_main.busca_art_nom(id: integer): string;
begin                                       //devuelve nombre de articulo a partir de id
  with tpfibdataset.Create(dm) do
  begin
    database := dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select nombre from g_articulos where id_articulo=' + inttostr(id));
    Open;

    if not (IsEmpty) then
      Result := FieldByName('nombre').asstring
    else
      result := 'ERR';

    Free;
  end;
end;

function Tf_main.busca_art_nom_cod(codigo: string): string;
begin                                       //devuelve nombre de articulo a partir de referencia
  with tpfibdataset.Create(dm) do
  begin
    database := dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select nombre from g_articulos where codigo=:codigo');
    ParambyName('codigo').asstring := codigo;
    Open;

    if not (IsEmpty) then
      Result := FieldByName('nombre').asstring
    else
      result := '';

    Free;
  end;
end;

function tf_main.ruta_escritorio: string;
var
  sEscritorio: string;
  Registro: TRegistry;
begin
  sEscritorio := '';
  Registro := TRegistry.Create;

  // Leemos la ruta del escritorio
  try
    Registro.RootKey := HKEY_CURRENT_USER;

    if Registro.OpenKey('\Software\Microsoft\Windows\CurrentVersion\explorer\Shell Folders', True) then
      sEscritorio := Registro.ReadString('Desktop');
  finally
    Registro.CloseKey;
    Registro.Free;
  end;

  result := sEscritorio;
end;

procedure Tf_main.btAplicaFiltroClick(Sender: TObject);
begin
  gr_envs.MultiSelect := ((rg_state.ItemIndex = 0) or (rg_state.ItemIndex = 1) or (rg_state.ItemIndex = 2) or (rg_state.ItemIndex = 3));

  btPrintPick.Enabled := ((rg_state.ItemIndex = 2) or (rg_state.ItemIndex = 3));

  bt_genera.Enabled := ((rg_state.ItemIndex = 0) or (rg_state.ItemIndex = 1));

  btEnvAgencias.Enabled := (rg_state.ItemIndex = 2);

  btRegenerar.Enabled := (rg_state.ItemIndex = 3);

  btSinStock.Enabled := (rg_state.ItemIndex = 1);

  btStock0.Enabled := (rg_state.ItemIndex = 1);

 { if rg_state.ItemIndex=1 then
      gr_detalle.Height := 543
  else
      gr_detalle.Height := 561;
  }

  if locked then
      filter(modo_historico);

end;


procedure Tf_main.btResetFiltroClick(Sender: TObject);
begin
  filter_reset;

end;

function Tf_main.WriteRawDataToPrinter(PrinterName: string; Str: string): Boolean;
var
  PrinterHandle: THandle;
  DocInfo: TDocInfo1;
  i: Integer;
  B: Byte;
  Escritos: DWORD;
begin
  Result := FALSE;
  if OpenPrinter(PChar(PrinterName), PrinterHandle, nil) then
  try
    FillChar(DocInfo, Sizeof(DocInfo), #0);
    with DocInfo do
    begin
      pDocName := PChar('Printer Test');
      pOutputFile := nil;
      pDataType := 'RAW';
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
              Str[2] := '$';
            if not TryStrToInt(Copy(Str, 2, 3), i) then
              Exit;
            B := Byte(i);
            Delete(Str, 1, 3);
          end
          else
            B := Byte(Str[1]);
          Delete(Str, 1, 1);
          WritePrinter(PrinterHandle, @B, 1, Escritos);
        end;
        Result := TRUE;
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

procedure Tf_main.ImprimeEtiqueta(f, orientacion: string);
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
      Host := '217.160.237.154';
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

    if not (f = '') then
    begin
      ClienteFTP.Get('/sync/Operadores/Correos/labels/' + f, 'c:\temp\' + f, True);
      Imprime('c:\temp\' + f, orientacion);
         //shellExecute(0, 'open', 'acrord32', PChar('/p /h ' + 'c:\temp\' + f), nil, SW_HIDE);
         //shellExecute(0, 'Printto', PChar('/h /t ' + 'c:\temp\' + f),'ZDesigner', 0, SW_HIDE);
         //DeleteFile('c:\temp\' + s);
    end
    else
    begin
          // Por cada fichero...
      for i := 0 to ClienteFTP.DirectoryListing.Count - 1 do
      begin
        if ExtractFileExt(ClienteFTP.DirectoryListing.Items[i].FileName) = '.pdf' then
        begin
          s := ClienteFTP.DirectoryListing.Items[i].FileName;
          ClienteFTP.Get('/sync/Operadores/Correos/labels/' + s, 'c:\temp\' + s, True);
          Imprime('c:\temp\' + s, orientacion);
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

function Tf_main.siguiente_laboral(fecha: TDateTime): tdate;
var
  n_fecha: TDate;
begin
  n_fecha := incday(fecha, 1);

  while es_festivo(n_fecha) do
    n_fecha := incday(n_fecha, 1);

  result := n_fecha;
end;

procedure Tf_main.lbAlertasDblClick(Sender: TObject);
begin
   //pnAlertas.Visible := not pnAlertas.Visible;
   pnPtes.Visible := not pnPtes.Visible;
end;

function Tf_main.es_festivo(fecha: TDateTime): Boolean;         //true=dia festivo false=dia no festivo
var
  fiesta: Boolean;
begin
  with tpfibdataset.create(Self) do
  try
    Database := dm.db;
    sqls.SelectSQL.Add('select fecha ' + 'from g_festivos ' + 'where fecha=:fecha and id_empresa=:id_empresa and estado<''B'' ');
    ParamByName('fecha').Asdate := fecha;
    ParamByName('id_empresa').AsInteger := 1;
    Open;

    if isempty then
      fiesta := false
    else
      fiesta := true;
  finally
    Free;
  end;

  if not (fiesta) then
    if ((DayOfWeek(fecha) = 1) or (DayOfWeek(fecha) = 7)) then
      fiesta := true;           //domingo o sabado

  result := fiesta;
end;

procedure Tf_main.F5Click(Sender: TObject);
var
  fichero: TStringDynArray;
  resultado_guardar_fichero: string;
begin
  if not DirectoryExists(ruta_fichero_seur) then
  begin
    ShowMessage('La ruta de ficheros de SEUR GO no existe en su equipo. Por favor, creela e inténtelo de nuevo:' + ln + ruta_fichero_seur);
    Exit;
  end
  else
    deDir.Text := ruta_fichero_seur;

  if MessageDlg('Va a crear el fichero Seur. ¿Desea continuar?', mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes then
  begin
    resultado_guardar_fichero := crear_fichero_uno;
    if resultado_guardar_fichero <> '' then
      fichero := SplitString(resultado_guardar_fichero, '|');
  end;

  if (High(fichero) >= 0) and (fichero[1] <> 'error') then
  begin
       //GuardaEtiqueta(fichero[1],'0|'+fichero[0], agencia_seur);

    sMessageDlg('Fichero Seur creado correctamente. ' + fichero[0], mtInformation, [mbok], 0);
    lb_st1.Caption := 'Proceso Finalizado';

  end
  else if (High(fichero) >= 0) and (fichero[1] = 'error') then
  begin
    sMessageDlg('Error al crear fichero de Seur. ' + fichero[0], mtError, [mbok], 0);
    lb_st1.Caption := 'Error al crear fichero.';
  end;
end;

procedure Tf_main.fDirectoryList(Sender: TObject; const Path: string;
  const Handle: TArray<System.Byte>; FileInfo: TScSFTPFileInfo; EOF: Boolean);
begin

  if (FileInfo = nil) or (FileInfo.Filename = '.') or (FileInfo.Filename = '..') then
    Exit;

  if ((ExtractFileExt(FileInfo.filename) = '.xml') or (ExtractFileExt(FileInfo.filename) = '.pdf')) then
  begin
      if FileExists(dir_temp+fileinfo.Filename) then
            DeleteFile(dir_temp+fileinfo.Filename);

      ShowMessage('antes download');
      ShowMessage(path+FileInfo.Filename);
      f.DownloadFile(path+FileInfo.Filename, dir_temp + fileinfo.filename,True,0);
      ShowMessage('despues download');

      if (ExtractFileExt(FileInfo.filename) = '.xml') then
      begin
        case ftp_sociedad of
           100: ftp_100.Add(FileInfo.Filename);
           200: ftp_200.Add(FileInfo.Filename);
           300: ftp_300.Add(FileInfo.Filename);
           400: ftp_400.Add(FileInfo.Filename);
        end;

      end;
      f.RenameFile(path+FileInfo.Filename,'/sync/muzybar/in/' + IntToStr(ftp_sociedad) + '/bak/'+FileInfo.Filename);
  end;
end;



procedure Tf_main.tmr1Timer(Sender: TObject);
begin
  Calculapendientes;
end;

procedure Tf_main.tmr2Timer(Sender: TObject);
begin
  imgIncidencias.Visible := not imgIncidencias.Visible;
end;

procedure Tf_main.tmr3Timer(Sender: TObject);
begin

  RevisaVersion;

  end;

procedure Tf_main.tmr4Timer(Sender: TObject);
begin
  imgNuevaVer.Visible := not imgNuevaVer.Visible;
end;

procedure Tf_main.EnviaACorreos;
var
  i: Integer;
  strRead: string;
  str_js, producto: string;
  Http1: TIdHTTP;
  datosPost: TStringList;
  solo_ida, envia_email: Boolean;
begin
  try
    //PARA FLAMINGOS  "NO"  se saca la etiqueta de logística inversa (pero si la de envío) en los siguientes casos:
    // - INTERNACIONAL
    // - RETAIL NACIONAL
    // - EXTRA
    // - ECI (EL CORTE INGLES)
    // - PRIVALIA
    // - Es un cambio o devolución
    // - Es una reexpedición
    {solo_ida := (((dm.q_peds.FieldByName('pais_code').AsString <> 'ES') and (dm.q_peds.FieldByName('pais_code').AsString <> 'PT')) or
                 ((dm.q_peds.FieldByName('tags').AsString = 'RETAIL') and (dm.q_peds.FieldByName('pais_code').AsString = 'ES')) or
                 (dm.q_peds.FieldByName('tags').AsString = 'EXTRA') or
                 (dm.q_peds.FieldByName('tags').AsString = 'ECI') or
                 (dm.q_peds.FieldByName('tags').AsString = 'PRIVALIA') or
                 (dm.q_peds.FieldByName('es_devo').asinteger = 1) or
                 (Pos('-R',dm.q_peds.FieldByName('order_name').AsString)>0));

    envia_email := ( (not (dm.q_peds.FieldByName('tags').AsString = 'ECI'))       and
                     (not (dm.q_peds.FieldByName('tags').AsString = 'PRIVALIA'))
                   ); }

    // 22/05/2018 el procedimiento almacenado cl_flam_params_envios nos devuelve estos datos
    with TpFIBDataSet.Create(dm) do
    try
      Database := dm.db;
      sqls.SelectSQL.Add('select solo_ida, envia_email, producto ' + 'from cl_flam_params_envio(:pedido) ');
      ParamByName('pedido').AsInteger := dm.q_peds.FieldByName('id_pedido').AsInteger;
      Open;
      solo_ida := (FieldByName('solo_ida').AsInteger = 1);
      envia_email := (FieldByName('envia_email').AsInteger = 1);
      producto := FieldByName('producto').Asstring;
    finally
      Free;
    end;

    //esta linea creo que se ha colado, eliminar si no falla 29/05/2018
    //Http1 := TIdHTTP.Create(nil);

    //datosPost := TStringStream.Create('{"FechaOperacion": "18-19-2025"}');
    datosPost := TStringList.Create;
    if solo_ida then
      datosPost := CreaPreRegistroEnvio(dm.q_peds, false, producto)
    else
      datosPost := CreaPreRegistroEnvio(dm.q_peds, true, producto);
    for i := 0 to datosPost.Count - 1 do
      str_js := str_js + datosPost[i];
    datosPost.Clear;
    datosPost.Add(str_js);
    strRead := '';
    if solo_ida then
      strRead := JSONPost(str_js, false)
    else
      strRead := JSONPost(str_js, true);

    if Copy(strRead, 0, 1) = '0' then
    begin
      GuardaEtiqueta(dm.q_peds.FieldByName('id_pedido').AsString, strRead, agencia_correos);
      if envia_email then
        enviar_email_pedidos(dm.q_peds.FieldByName('id_pedido').asinteger);
    end
    else
      ShowMessage('No se ha podido crear la etiqueta para el pedido ' + dm.q_peds.FieldByName('order_name').AsString + '.' + #13#10 + '(' + strRead + ')');
  finally
    datosPost.Free;

  end;
end;

procedure Tf_main.get_defaults;
begin
  with tpfibdataset.Create(dm) do
  begin
    database := dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select * from a_aux');
    Open;

    if not (IsEmpty) then
    begin
      cubic_a := FieldByName('cubic_a').asinteger;
      cubic_b := FieldByName('cubic_b').asinteger;
      cubic_c := FieldByName('cubic_c').asinteger;
      cubic_d := FieldByName('cubic_d').asinteger;
      cubic_e := FieldByName('cubic_e').asinteger;
      ncajas_a := FieldByName('cajas_a_agrup').asinteger;
      ncajas_b := FieldByName('cajas_b_agrup').asinteger;
      ncajas_c := FieldByName('cajas_c_agrup').asinteger;
      ncajas_d := FieldByName('cajas_d_agrup').asinteger;
      ncajas_e := FieldByName('cajas_e_agrup').asinteger;
      ncajas_x := FieldByName('cajas_x_agrup').asinteger;
      uds_resto := fieldbyname('uds_resto').AsInteger;
    end
    else
    begin
      cubic_a := 69000;
      cubic_b := 28500;
      cubic_c := 22500;
      cubic_d := 18200;
      cubic_e := 9100;
      ncajas_a := 36;
      ncajas_b := 54;
      ncajas_c := 54;
      ncajas_d := 54;
      ncajas_e := 54;
      ncajas_x := 40;
      uds_resto := 200;
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

function Tf_main.ubic_entrada(id_alm: Integer): Integer;
begin
  case id_alm of
    1:
      Result := 361;          //W-1-1 en alm1
    2:
      result := 3758;          //W-1-1 en alm2
    3:
      result := 4802;          //W-1-1 en alm2
    4:
      Result := 3778;          //W-1-1 en alm4
    5:
      result := 3776;          //W-1-1 en alm5
    6:
      result := 5532;          //W-1-1 en alm6
    7:
      result := 9579;          //W-1-1 en alm7
  end;
end;

function Tf_main.BuscaReexpedicion(id_cliente: integer; order_name: string): Integer;
begin
                            //devuelve id de reexpedicion a partir de order_name y cliente
  with tpfibdataset.Create(dm) do
  begin
    database := dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select id_pedido from c_pedidos where order_name=:order_name ' + ' and id_cliente=:id_cliente');
    ParambyName('order_name').asstring := order_name + '-R';
    ParambyName('id_cliente').asinteger := id_cliente;
    Open;

    if not (IsEmpty) then
      Result := FieldByName('id_pedido').asinteger
    else
      result := -1;

    Free;
  end;
end;
{$ENDREGION}

{$REGION 'Stock'}

function Tf_main.gestiona_stock(pedidos: string; out errores_stock: TStringList): Boolean;
var
  new_ped, json, resultado: string;
begin
  Result := True;
  resultado := '';

  get_stock(pedidos);

  idx_arts_sin_stock := 0;
  setlength(ar_arts_sin_stock, idx_arts_sin_stock);

  with TpFIBDataSet.Create(self) do
  try
    Database := dm.db;
    sqls.SelectSQL.Add('select id_pedido ' +
                       'from c_pedidos ' +
                       'where ((estado=''X'') or (estado=''P'')) ' +
                       //'where id_pedido= ' + pedidos +
                       ' and id_cliente=:id_cliente ');

    if pedidos <> '' then
      SQLs.SelectSQL.Add(' and id_pedido in (' + pedidos + ') ');

    SQLs.SelectSQL.Add(' order by id_pedido');

    ParamByName('id_cliente').AsInteger := StrToInt(edCliente.Text);
    Open;

    Result := not Eof;

    first;
    while not (Eof) do
    begin
      if verif_stock(FieldByName('id_pedido').asinteger) then
      begin                 //si tiene stock
        if (StrToInt(cl_padres[0])<0) then
              InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','GenPeds.StockOk','Ped.'+FieldByName('id_pedido').AsString)
        else
              InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','GenPeds.StockOkPadre','Ped.'+FieldByName('id_pedido').AsString);

        descuenta_stock(FieldByName('id_pedido').asinteger);
        dm.t_write.StartTransaction;
        try
          dm.q_1.Close;
          dm.q_1.sql.Clear;
          dm.q_1.sql.Add('update c_pedidos set estado=''P'' where id_pedido=:id_pedido ');

          dm.q_1.ParamByName('id_pedido').AsInteger := FieldByName('id_pedido').asinteger;
          dm.q_1.ExecQuery;
          dm.t_write.Commit;
          dm.t_write.CommitRetaining;
        except
          dm.t_write.rollback;
          dm.t_write.RollbackRetaining;
          Result := False;
          errores_stock.Add(FieldByName('id_pedido').AsString);
        end;

      end
      else
      begin
        If (StrToInt(cl_padres[0])<0) then
            InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','GenPeds.SinStock','Ped.'+FieldByName('id_pedido').AsString)
        else
            InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','GenPeds.SinStockPadre','Ped.'+FieldByName('id_pedido').AsString);

        dm.t_write.StartTransaction;

        try
          new_ped := '';
          if peds_en_cadena >= 0 then
            new_ped := dmupdatePedido.updatepedido(2, FieldByName('id_pedido').asinteger,json,resultado);

          dm.q_1.Close;
          dm.q_1.sql.Clear;
          dm.q_1.sql.Add('update c_pedidos set estado=''X'' ');
          if new_ped <> '' then
          begin
            dm.q_1.sql.Add(',text=' + quotedstr('LL' + new_ped));
            peds_encadenados := new_ped + ',';
          end;
          dm.q_1.sql.Add(' where id_pedido=:id_pedido');
          dm.q_1.ParamByName('id_pedido').AsInteger := FieldByName('id_pedido').asinteger;
          dm.q_1.ExecQuery;
          dm.t_write.Commit;
          dm.t_write.CommitRetaining;
          errores_stock.Add(FieldByName('id_pedido').AsString);
        except
          dm.t_write.rollback;
          dm.t_write.RollbackRetaining;
          Result := False;
          errores_stock.Add(FieldByName('id_pedido').AsString);
        end;
      end;
      next;
    end;
  finally
    free;
  end;

  //lb_st1.Caption:='Generando Informe Sin Stock';
  application.ProcessMessages;

  //26-11-20 el informe lo sacaremos al final de generar para que descuente las uds. que hayan ido a picking.
  //Esto resuelve lo casos en los que hay stock pero no para todos los pedidos pendientes.
  //Si sacamos el informe ahora, no se descuenta el picking y no salen los ** en el excel.
  //informe_sin_stock(pedidos);

  if resultado<>'' then
       ShowMessage(resultado);
end;

procedure Tf_main.limpiar_stock;
begin
  idx_stock := 0;
  setlength(ar_stock, idx_stock);
end;

procedure Tf_main.get_stock(pedidos: string);
var
  str_st:string;
  stock, id_art_padre, i, idx: Integer;
begin

  stock := 0;
  id_art_padre := 0;
  str_st := '';
  limpiar_stock;

  idx := 0;
  setlength(arts_heredados, idx);

  with TpFIBDataSet.Create(self) do
  try
    Database := dm.db;
    //SQLs.SelectSQL.Clear;
    sqls.SelectSQL.Add('select distinct id_articulo ' +
                       'from c_pedidos_lines  ' +
                       'where cantidad>0 ');

    if pedidos <> '' then
      SQLs.SelectSQL.Add(' and id_pedido in (' + pedidos + ')');

    Open;

    first;
    while not (Eof) do
    begin
      Inc(idx_stock);
      setlength(ar_stock, idx_stock);

      if ((StrToInt(cl_hijos[0])<0) and (StrToInt(cl_padres[0])<0)) then
          begin
              stock := get_stock_x_art(fieldbyname('id_articulo').AsInteger, id_almacen);
          end
          else   //gestión padre-hijo
          begin
             //Si se saca el calculo para un padre hay que descontar los picks ptes del hijo
             if StrToInt(cl_hijos[0])>0 then
             begin
                i := 0;
                while ((id_art_padre<=0) and (i<=High(cl_padres))) do
                begin
                  stock := get_stock_x_art(fieldbyname('id_articulo').AsInteger, id_almacen, StrToInt(cl_hijos[i]));
                  Inc(i);
                end;
             end else begin //Si se calcula para el hijo
                    i := 0;
                    id_art_padre := 0;
                    while ((id_art_padre<=0) and (i<=High(cl_padres))) do
                    begin
                      id_art_padre := busca_art(get_codcli_art(FieldByName('id_articulo').asinteger),StrToInt(cl_padres[i]));
                      Inc(i);
                    end;

                    if id_art_padre>0 then begin
                      stock := get_stock_x_art(id_art_padre, id_almacen, main_cli);
                      InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','',
                      'GeneraPeds.ArtHijoPadre','IdHijo.'+FieldByName('id_articulo').AsString + ' IdPadre.' + IntToStr(id_art_padre));

                      Inc(idx);
                      setlength(arts_heredados, idx);

                      arts_heredados[idx-1].art_main := FieldByName('id_articulo').AsInteger;
                      arts_heredados[idx-1].art_padre := id_art_padre;
                      arts_heredados[idx-1].id_padre := StrToInt(cl_padres[i-1]);

                    end
                    else begin
                      stock := 0;
                      InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','',
                      'GeneraPeds.ArtHijoPadre','IdHijo.'+FieldByName('id_articulo').AsString + ' IdPadre.No encontrado');
                    end;


                 end;
          end;
      //pick_pte := UdsEnPickingPte(FieldByName('id_articulo').asinteger);

      ar_stock[idx_stock - 1].id_art := FieldByName('id_articulo').asinteger;
      //ar_stock[idx_stock-1].uds:=FieldByName('uds').asinteger;
      //ar_stock[idx_stock - 1].uds := get_stock_x_art(FieldByName('id_articulo').asinteger, id_almacen);
      ar_stock[idx_stock - 1].uds := stock;

      str_st := str_st + IntToStr(ar_stock[idx_stock - 1].id_art) + ':' + IntToStr(ar_stock[idx_stock - 1].uds)+'|';

      next;
    end;

    InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','GeneraPeds.GetStock',str_st);
  finally
    free;
  end;
end;


function Tf_main.verif_stock(pedido: Integer): boolean;
var
  ok: Boolean;
begin
  ok := true;
  with TpFIBDataSet.Create(self) do
  try
    Database := dm.db;
    sqls.SelectSQL.Add('select l.id_articulo,sum(l.cantidad) as uds ' +
                       'from c_pedidos_lines l ' +
                       'where l.id_pedido=:id_pedido and l.cantidad>0 ' +
                       'group by l.id_articulo');
    parambyname('id_pedido').AsInteger := pedido;
    Open;

    first;
    while (not (Eof) and (ok)) do
    begin
      ok := busca_stock(FieldByName('id_articulo').AsInteger) >= FieldByName('uds').AsInteger;

      if not ok then
      begin
        Inc(idx_arts_sin_stock);
        SetLength(ar_arts_sin_stock, idx_arts_sin_stock);

        ar_arts_sin_stock[idx_arts_sin_stock-1] := FieldByName('id_articulo').AsInteger;
      end;
      Next;
    end;
  finally
    free;
  end;

  result := ok;
end;


function Tf_main.get_stock_x_art(id_art: Integer; id_alm:Integer=-1; id_hijo:Integer=-1): integer;
begin
  with TpFIBDataSet.Create(self) do
  try
    Database := dm.db;

    if id_hijo>=0 then
    begin
      sqls.SelectSQL.Add('select stock from get_stock_sin_peds_padre(:id_articulo, :id_almacen,:id_hijo) ');
      parambyname('id_hijo').AsInteger := id_hijo;
    end
    else
      sqls.SelectSQL.Add('select stock from get_stock_sin_pedidos(:id_articulo, :id_almacen) ');
    parambyname('id_articulo').AsInteger := id_art;
    parambyname('id_almacen').AsInteger := id_alm;
    Open;

    Result := FieldByName('stock').AsInteger;

  finally
    free;
  end;

  if (Result=0) and (main_cli=7428) and (chAntonio.Checked) then
        Result := 1;

end;

function Tf_main.get_total_x_art_y_ped(id_art, id_pedido: Integer): integer;
begin
  with TpFIBDataSet.Create(self) do
  try
    Database := dm.db;
    sqls.SelectSQL.Add('select sum(cantidad) as total from c_pedidos_lines ' +
                       'where id_articulo=:id_art and id_pedido=:id_pedido');
    parambyname('id_art').AsInteger := id_art;
    parambyname('id_pedido').AsInteger := id_pedido;
    Open;

    Result := FieldByName('total').AsInteger;

  finally
    free;
  end;

end;

procedure Tf_main.descuenta_stock(pedido: Integer);
var
  enc: Boolean;
  i, id_art: integer;
begin
  with TpFIBDataSet.Create(self) do
  try
    Database := dm.db;
    sqls.SelectSQL.Add('select l.id_articulo,sum(l.cantidad) as uds ' +
                       'from c_pedidos_lines l ' +
                       'where l.id_pedido=:id_pedido and l.cantidad>0 ' +
                       'group by l.id_articulo');
    parambyname('id_pedido').AsInteger := pedido;
    Open;

    first;
    while not (Eof) do
    begin
      enc := False;
      i := 0;

      while (not (enc) and (i < idx_stock)) do
      begin                                //se encuentra
        if (ar_stock[i].id_art = FieldByName('id_articulo').asinteger) then
        begin
          ar_stock[i].uds := ar_stock[i].uds - FieldByName('uds').asinteger;
          enc := True;
        end;
        Inc(i);
      end;

      next;
    end;
  finally
    free;
  end;
end;

procedure Tf_main.dialog2ButtonClicked(Sender: TObject;
  ModalResult: TModalResult; var CanClose: Boolean);
begin
   if TTaskDialog(Sender).Button.Index=0 then
  begin
    ShowMessage('Demo button clicked.');
    CanClose := False;
  end;
end;

procedure Tf_main.dialog2VerificationClicked(Sender: TObject);
begin
   if tfVerificationFlagChecked in TTaskDialog(Sender).Flags then
      util_anula_stock_baja_art := true
   else
      util_anula_stock_baja_art := false;
end;

function Tf_main.busca_stock(id_art: Integer): integer;
var
  enc: Boolean;
  i: integer;
begin
  result := 0;
  enc := False;
  i := 0;
  while (not (enc) and (i < idx_stock)) do
  begin                                //se encuentra
    if (ar_stock[i].id_art = id_art) then
    begin
      enc := True;
      Result := ar_stock[i].uds;
    end;
    Inc(i);
  end;
end;

procedure Tf_main.informe_sin_stock(pedidos: string);
var
  line, id_art_padre, stock, i: integer;
  exist: Boolean;
  titulo: string;
begin
  id_art_padre := -1;
  stock := 0;

  if pedidos <> '' then
  begin

    CreaExcel;

    Hoja := excel.Worksheets.Item[1];
    //AbreFichero(deDirSeur.Text + '\seur.xls');

    exist := false;

    with TpFIBDataSet.Create(self) do
    try
      Database := dm.db;
      sqls.SelectSQL.Add('select * ' +
                         'from c_pedidos where ' +
                         'id_cliente=:id_cliente and estado=''X'' and ');
      SQLs.SelectSQL.Add('id_pedido in (' + pedidos + ')');
      ParamByName('id_cliente').AsInteger := main_cli;
      Open;

      first;

      Hoja := excel.Worksheets.Item[1];

      line := 1;

      excel.cells[line, 1] := 'PEDIDOS PENDIENTES SIN STOCK ' + formatdatetime('dd/mm/yyyy hh:nn', Now);
      inc(line);

      if (StrToInt(cl_padres[0])>=0) then
      begin
         for i := 0 to High(cl_padres) do
         begin
          excel.cells[line, 1] := 'CLIENTE PADRE ' + get_nombre_cliente(StrToInt(cl_padres[i]));
          inc(line);
         end;
      end;

      while not (Eof) do
      begin
        exist := true;
        inc(line);
        excel.cells[line, 1] := fieldbyname('id_order').AsString;
        excel.cells[line, 2] := fieldbyname('order_name').AsString;
        excel.cells[line, 3] := fieldbyname('nombre').AsString;
        excel.cells[line, 4] := fieldbyname('dir_1').AsString;
        excel.cells[line, 5] := '';
        excel.cells[line, 6] := fieldbyname('poblacion').AsString;
        excel.cells[line, 7] := fieldbyname('provincia').AsString;
        excel.cells[line, 8] := fieldbyname('cp').AsString;
        excel.cells[line, 9] := fieldbyname('pais').AsString;
        excel.cells[line, 10] := fieldbyname('pais').AsString;
        excel.cells[line, 11] := fieldbyname('fecha_ped').AsString;
        excel.cells[line, 12] := fieldbyname('telefono').AsString;
        excel.cells[line, 13] := fieldbyname('email').AsString;
        excel.cells[line, 14] := fieldbyname('delivery_time').AsString;
        excel.cells[line, 15] := fieldbyname('text').AsString;
        inc(line);

        dm.ds_1.close;
        dm.ds_1.SelectSQL.Clear;
        dm.ds_1.SelectSQL.Add('select * from c_pedidos_lines where id_pedido=:id_pedido order by id_line');
        dm.ds_1.ParamByName('id_pedido').AsInteger := FieldByName('id_pedido').AsInteger;
        dm.ds_1.Open;

        excel.cells[line, 2] := 'ID_ART';
        excel.cells[line, 3] := 'SKU';
        excel.cells[line, 4] := 'NOMBRE';
        excel.cells[line, 5] := 'QTY';
        excel.cells[line, 6] := 'ITEM_ID';
        Inc(line);

        dm.ds_1.First;
        while not (dm.ds_1.Eof) do
        begin
          excel.cells[line, 3] := dm.ds_1.fieldbyname('sku').AsString;
          excel.cells[line, 4] := dm.ds_1.fieldbyname('nombre_art').AsString;
          excel.cells[line, 5] := dm.ds_1.fieldbyname('cantidad').AsString;
          excel.cells[line, 6] := dm.ds_1.fieldbyname('item_id').AsString;

          if ((StrToInt(cl_hijos[0])<0) and (StrToInt(cl_padres[0])<0)) then
          begin
              stock := get_stock_x_art(dm.ds_1.fieldbyname('id_articulo').AsInteger, id_almacen);
          end
          else   //gestión padre-hijo
          begin
             //Si se saca el informe para un padre hay que quitar los picks ptes de los hijos
             if StrToInt(cl_hijos[0])>0 then
             begin
              stock := get_stock_x_art(dm.ds_1.fieldbyname('id_articulo').AsInteger, id_almacen, StrToInt(cl_hijos[0]));
             end else begin //Si se saca el informe para el hijo
                    i := 0;
                    while ((id_art_padre<=0) and (i<=High(cl_padres))) do
                    begin
                        id_art_padre := busca_art(get_codcli_art(FieldByName('id_articulo').asinteger),StrToInt(cl_padres[i]));
                        Inc(i);
                    end;
                    stock := get_stock_x_art(id_art_padre, id_almacen, main_cli);
                 end;
          end;

          if (stock < get_total_x_art_y_ped(dm.ds_1.fieldbyname('id_articulo').AsInteger, dm.ds_1.FieldByName('id_pedido').AsInteger)) then
            excel.cells[line, 2] := '**' + dm.ds_1.fieldbyname('id_articulo').AsString
          else
            excel.cells[line, 2] := dm.ds_1.fieldbyname('id_articulo').AsString;
          inc(line);

          dm.ds_1.Next;
        end;

        next;
      end;
    finally
      free;
    end;

    if exist then
    begin
      titulo := titulo_sin_stock;
      titulo := StringReplace(titulo, '((now))', FormatDateTime('dd_mm_yyyy__hh_nn', now), [rfReplaceAll]) + '.xls';

      excel.activeworkbook.saveas(IncludeTrailingPathDelimiter(ed_folder.text) + titulo);
      ShowMessage('Fichero Sin Stock Guardado en ' + IncludeTrailingPathDelimiter(ed_folder.text));
    end;

    Excel.Quit;
    Excel := Unassigned;
  end;

 { exist:=false;

  with TpFIBDataSet.Create(self) do
  try
    Database:=dm.db;
    sqls.SelectSQL.Add('select * '+
      'from c_pedidos '+
      'where estado=''X'' ' +
      'and id_cliente=:id_cliente');
    ParamByName('id_cliente').AsInteger := StrToInt(edCliente.Text);
    Open;

    first;
    line:=0;
    xls_1.Clear;
    xls_1.Sheets[0].AsString[0,line]:='PEDIDOS PENDIENTES SIN STOCK '+formatdatetime('dd/mm/yyyy hh:nn',Now);
    inc(line,2);
    while not(Eof) do begin
      exist:=true;
      xls_1.Sheets[0].AsString[0,line]:=fieldbyname('id_order').AsString;
      xls_1.Sheets[0].AsString[1,line]:=fieldbyname('order_name').AsString;
      xls_1.Sheets[0].AsString[2,line]:=fieldbyname('nombre').AsString;
      xls_1.Sheets[0].AsString[3,line]:=fieldbyname('dir_1').AsString;
      xls_1.Sheets[0].AsString[5,line]:=fieldbyname('poblacion').AsString;
      xls_1.Sheets[0].AsString[6,line]:=fieldbyname('provincia').AsString;
      xls_1.Sheets[0].AsString[7,line]:=fieldbyname('cp').AsString;
      xls_1.Sheets[0].AsString[8,line]:=fieldbyname('pais').AsString;
      xls_1.Sheets[0].AsString[10,line]:=fieldbyname('fecha_ped').AsString;
      xls_1.Sheets[0].AsString[11,line]:=fieldbyname('telefono').AsString;
      xls_1.Sheets[0].AsString[12,line]:=fieldbyname('email').AsString;
      xls_1.Sheets[0].AsString[13,line]:=fieldbyname('delivery_time').AsString;
      xls_1.Sheets[0].AsString[14,line]:=fieldbyname('text').AsString;
      inc(line);

      dm.ds_1.close;
      dm.ds_1.SelectSQL.Clear;
      dm.ds_1.SelectSQL.Add('select * from c_pedidos_lines where id_pedido=:id_pedido order by id_line');
      dm.ds_1.ParamByName('id_pedido').AsInteger:=FieldByName('id_pedido').AsInteger;
      dm.ds_1.Open;

      xls_1.Sheets[0].AsString[1,line]:='ID_ART';
      xls_1.Sheets[0].AsString[2,line]:='SKU';
      xls_1.Sheets[0].AsString[3,line]:='NOMBRE';
      xls_1.Sheets[0].AsString[4,line]:='QTY';
      xls_1.Sheets[0].AsString[5,line]:='ITEM_ID';
      Inc(line);

      dm.ds_1.First;
      while not(dm.ds_1.Eof) do begin
        xls_1.Sheets[0].AsString[1,line]:=dm.ds_1.fieldbyname('id_articulo').AsString;
        xls_1.Sheets[0].AsString[2,line]:=dm.ds_1.fieldbyname('sku').AsString;
        xls_1.Sheets[0].AsString[3,line]:=dm.ds_1.fieldbyname('nombre_art').AsString;
        xls_1.Sheets[0].AsString[4,line]:=dm.ds_1.fieldbyname('cantidad').AsString;
        xls_1.Sheets[0].AsString[5,line]:=dm.ds_1.fieldbyname('item_id').AsString;
        if not(verif_stock_x_art(dm.ds_1.fieldbyname('id_articulo').AsInteger,dm.ds_1.fieldbyname('cantidad').AsInteger)) then
          xls_1.Sheets[0].Cell[1,line].FillPatternForeColor:=xcRed;
        inc(line);

        dm.ds_1.Next;
      end;

      next;
    end;
  finally
    free;
  end;

  if exist then begin
    xls_1.Filename:=IncludeTrailingPathDelimiter(ed_folder.text)+'PEDIDO_NO_STOCK_'+formatdatetime('dd_mm_yyyy__hh_nn',Now)+'.xls';
    xls_1.Write;
    sMessageDlg('Fichero Sin Stock Guardado en '+xls_1.Filename,mtWarning,[mbok],0);
  end;  }
end;

procedure Tf_main.informe_generados;
{var
  line: integer;
  exist: Boolean;}
begin
 { exist:=false;

  with TpFIBDataSet.Create(self) do
  try
    Database:=dm.db;
    sqls.SelectSQL.Add('select * '+
      'from c_pedidos '+
      'where estado=''P'' and id_cliente=' + edCliente.Text);
    Open;

    first;
    line:=0;
    xls_1.Clear;
    xls_1.Sheets[0].Name := 'PEDIDOS';
    xls_1.Sheets[0].AsString[0,line]:='PEDIDOS GENERADOS '+formatdatetime('dd/mm/yyyy hh:nn',Now);
    inc(line,2);

    while not(Eof) do begin
      exist:=true;
      xls_1.Sheets[0].AsString[0,line]:=fieldbyname('id_order').AsString;
      xls_1.Sheets[0].AsString[1,line]:=fieldbyname('order_name').AsString;
      xls_1.Sheets[0].AsString[2,line]:=fieldbyname('nombre').AsString;
      xls_1.Sheets[0].AsString[3,line]:=fieldbyname('dir_1').AsString;
      xls_1.Sheets[0].AsString[5,line]:=fieldbyname('poblacion').AsString;
      xls_1.Sheets[0].AsString[6,line]:=fieldbyname('provincia').AsString;
      xls_1.Sheets[0].AsString[7,line]:=fieldbyname('cp').AsString;
      xls_1.Sheets[0].AsString[8,line]:=fieldbyname('pais').AsString;
      xls_1.Sheets[0].AsString[10,line]:=fieldbyname('fecha_ped').AsString;
      xls_1.Sheets[0].AsString[11,line]:=fieldbyname('telefono').AsString;
      xls_1.Sheets[0].AsString[12,line]:=fieldbyname('email').AsString;
      xls_1.Sheets[0].AsString[13,line]:=fieldbyname('delivery_time').AsString;
      xls_1.Sheets[0].AsString[14,line]:=fieldbyname('text').AsString;
      inc(line);

      dm.ds_1.close;
      dm.ds_1.SelectSQL.Clear;
      dm.ds_1.SelectSQL.Add('select * from c_pedidos_lines where id_pedido=:id_pedido order by id_line');
      dm.ds_1.ParamByName('id_pedido').AsInteger:=FieldByName('id_pedido').AsInteger;
      dm.ds_1.Open;

      xls_1.Sheets[0].AsString[1,line]:='ID_ART';
      xls_1.Sheets[0].AsString[2,line]:='SKU';
      xls_1.Sheets[0].AsString[3,line]:='NOMBRE';
      xls_1.Sheets[0].AsString[4,line]:='QTY';
      xls_1.Sheets[0].AsString[5,line]:='ITEM_ID';
      Inc(line);

      dm.ds_1.First;
      while not(dm.ds_1.Eof) do begin
        xls_1.Sheets[0].AsString[1,line]:=dm.ds_1.fieldbyname('id_articulo').AsString;
        xls_1.Sheets[0].AsString[2,line]:=dm.ds_1.fieldbyname('sku').AsString;
        xls_1.Sheets[0].AsString[3,line]:=dm.ds_1.fieldbyname('nombre_art').AsString;
        xls_1.Sheets[0].AsString[4,line]:=dm.ds_1.fieldbyname('cantidad').AsString;
        xls_1.Sheets[0].AsString[5,line]:=dm.ds_1.fieldbyname('item_id').AsString;
        inc(line);

        dm.ds_1.Next;
      end;

      next;
    end;

    //STOCK
    Close;
    sqls.SelectSQL.Clear;
    sqls.SelectSQL.Add('select a.codigo, a.nombre,sum(s.cantidad) as uds ' +
                       'from a_stock s ' +
                       'inner join g_articulos a on (s.id_articulo=a.id_articulo) ' +
                       'inner join a_ubicaciones u on (s.id_ubicacion=u.id_ubicacion) ' +
                       'where a.id_cliente=' + edCliente.Text + ' and u.id_almacen=' + IntToStr(id_almacen) + ' and u.id_zona=0 and u.id_ubicacion<>361 ' +
                       'group by a.codigo, a.nombre');
    Open;
    first;
    line:=0;

    //xls_1.
    //xls_1.Sheets.Name := 'STOCK';


  finally
    free;
  end;

  if exist then begin
    xls_1.Filename:=IncludeTrailingPathDelimiter(ed_folder.text)+'PEDIDO_GENERADO_'+formatdatetime('dd_mm_yyyy__hh_nn',Now)+'.xls';
    xls_1.Write;
    sMessageDlg('Fichero Generados Guardado en '+xls_1.Filename,mtWarning,[mbok],0);
  end; }
end;
{$ENDREGION}

{$REGION 'Albaranes'}

function Tf_main.genera_albaranes(pedidos: string; out errores_albs, msgs_error: TStringList): Boolean;
var
  id_albaran, error, id_destino: integer;
  titulo_error, error_exe: string;
begin
  error_exe := '';
  error := -1;
  Result := True;

  dm.ds_2.close;                                                 //recoge pedidos
  dm.ds_2.SelectSQL.clear;
  dm.ds_2.SelectSQL.Add('select distinct p.* ' + 'from c_pedidos p ' + 'inner join c_pedidos_lines l on l.id_pedido=p.id_pedido ' + 'where p.estado=''P'' ' + ' and p.id_cliente=:id_cliente and l.cantidad>0 ');

  if pedidos <> '' then
    dm.ds_2.SelectSQL.Add(' and p.id_pedido in (' + pedidos + ')');

  dm.ds_2.ParamByName('id_cliente').AsInteger := StrToInt(edCliente.Text);
  dm.ds_2.Open;

  Result := not dm.ds_2.IsEmpty;

  dm.ds_2.First;

  if not (dm.ds_2.IsEmpty) then
  begin

    while not (dm.ds_2.Eof) do
    begin
      //Crear albaran con el sp CREA_ALBARAN_PEDIDOS en Gestoras
      dm.t_write_gestoras.StartTransaction;

      try
        dm.stpGrabaAlb.Database := dm.db_gestoras;
        dm.stpGrabaAlb.SQL.Clear;
        dm.stpGrabaAlb.SQL.Add('execute procedure crea_albaran_pedido(:pedido,:id_almacen)');
        dm.stpGrabaAlb.ParamByName('pedido').Value := dm.ds_2.FieldByName('id_pedido').AsInteger;
        dm.stpGrabaAlb.ParamByName('id_almacen').Value := id_almacen;
        dm.stpGrabaAlb.ExecProc;
        dm.t_write_gestoras.Commit;

        error := dm.stpGrabaAlb.ParamByName('error').Value;
        titulo_error := dm.stpGrabaAlb.ParamByName('titulo_error').Value;
        if error = 0 then
        begin
          id_albaran := dm.stpGrabaAlb.ParamByName('id_albaran').Value;
          id_destino := dm.stpGrabaAlb.ParamByName('id_albaran_det').Value;
          InsertaLog(usuario.id,dm.ds_2.FieldByName('id_pedido').asinteger,0,PC.Nombre,PC.IP,log_app,'pedido','','GenPeds.Alb ' + IntToStr(id_albaran) ,'Ped.'+dm.ds_2.FieldByName('id_pedido').AsString);
        end
        else
        begin
          errores_albs.Add(dm.ds_2.FieldByName('id_pedido').AsString);
          msgs_error.Add(titulo_error);
          InsertaLog(usuario.id,dm.ds_2.FieldByName('id_pedido').asinteger,0,PC.Nombre,PC.IP,log_app,'pedido','','GenPeds.AlbError','Ped.'+dm.ds_2.FieldByName('id_pedido').AsString+'|'+titulo_error);
        end;
      except
        on E: Exception do
        begin
          error := -1;
          errores_albs.Add(dm.ds_2.FieldByName('id_pedido').AsString);
                   //error_exe := 'Error creando albaranes. ' + titulo_error + ' ' + e.Message;
          msgs_error.Add(titulo_error + ' ' + e.Message);
                   //result := False;
          dm.t_write_gestoras.Rollback;
                   //raise;
        end;
      end;

      if error = 0 then   //Si todo ha ido bien, actualizar pedido con los datos obtenidos del albarán y cambio de estado
      begin

        try
          CambiaEstadoPedido(dm.ds_2.FieldByName('id_pedido').AsString, 'P', 'G');
          CambiaAlbaranPedido(dm.ds_2.FieldByName('id_pedido').AsInteger, id_albaran, id_destino);
        except
          on E: Exception do
          begin
            errores_albs.Add(dm.ds_2.FieldByName('id_pedido').AsString);
            msgs_error.Add('Alb.' + IntToStr(id_albaran) + 'creado en Gestoras. Error al actualizar BBDD almacén. ' + E.Message);
                 //error_exe := 'Error actualizando albaranes en pedidos.';
                 //result := False;
                 //raise;
          end;
        end;
      end {else begin
                   result := False;
                   raise Exception.Create(titulo_error);
            end};

      dm.ds_2.Next;
    end;

      //dm.t_write.Commit;
      //dm.t_write_gestoras.Commit;
  end;
end;

procedure Tf_main.SendEstado(id_order, albaran, estado: string);
var
  Http1: TIdHTTP;
  datosPost: TIdMultiPartFormDataStream;
  strRead: string;
  resultado: Boolean;
begin
  resultado := False;
  Http1 := TIdHTTP.Create(nil);
  datosPost := TIdMultiPartFormDataStream.Create;
  try
    datosPost.AddFormField('pedido', id_order);
    datosPost.AddFormField('albaran', albaran);
    datosPost.AddFormField('estado', estado);
    Http1 := TIdHTTP.Create(nil);
    try
      try
        strRead := Http1.Post(httpweb + 'shopcart/put.albaran.php', datosPost);
      except
        ShowMessage('No se ha podido subir los datos a la web.')
      end;
    finally
      Http1.Free;
    end;
  finally
    datosPost.Free;
  end;
end;

procedure Tf_main.genera_recogidas;
{var
  codalb, codservicio, codmovimiento, ruta, bultos: integer;
  s: string;
  kgs, kgsVol: double; }
begin
  {
  dm.ds_2.close;                                                 //recoge pedidos
  dm.ds_2.SelectSQL.clear;
  dm.ds_2.SelectSQL.Add('select distinct p.* '+
    'from c_pedidos p '+
    'inner join c_pedidos_lines l on l.id_pedido=p.id_pedido ' +
    'where p.estado=''P'' ' +
    ' and p.id_cliente=:id_cliente and l.cantidad<0');
  dm.ds_2.ParamByName('id_cliente').AsInteger := StrToInt(edCliente.Text);
  dm.ds_2.Open;

  dm.ds_2.First;
  while not(dm.ds_2.Eof) do begin
    dm.qryTemp.sql.clear;                                                  //nuevo codigo de albarán
    dm.qryTemp.sql.add('select dbo.getcodalbaran() as codalb');
    dm.qryTemp.open;

    codalb:=dm.qrytemp.fieldbyname('codalb').AsInteger;

    dm.stpGrabaSrv.parameters.ParamByName('@codservicio').Value:= null;
    dm.stpGrabaSrv.parameters.ParamByName('@tipo_servicio').Value:= 'P';
    dm.stpGrabaSrv.parameters.ParamByName('@codcli').Value:= edCliente.Text;
    dm.stpGrabaSrv.parameters.ParamByName('@falta').Value:= Date;
    dm.stpGrabaSrv.parameters.ParamByName('@sureferencia').Value:= null;
    dm.stpGrabaSrv.parameters.ParamByName('@observaciones').Value:= '';
    dm.stpGrabaSrv.parameters.ParamByName('@codcli_paga').Value:=edCliente.Text;
    dm.stpGrabaSrv.parameters.ParamByName('@e_s_r').Value:='R';

    dm.stpGrabaSrv.parameters.ParamByName('@org_coddel').Value:= 9999;
    dm.stpGrabaSrv.parameters.ParamByName('@codremitente').Value:= edCliente.Text + '9999';

    dm.stpGrabaSrv.parameters.ParamByName('@org_codcli').Value := edCliente.Text;
    dm.stpGrabaSrv.parameters.ParamByName('@org_nombre').Value := dm.ds_2.FieldByName('nombre').asstring;
    dm.stpGrabaSrv.parameters.ParamByName('@org_calle').Value := Trim(dm.ds_2.FieldByName('dir_1').asstring);
    dm.stpGrabaSrv.parameters.ParamByName('@org_cp').Value := dm.ds_2.FieldByName('cp').asstring;
    dm.stpGrabaSrv.parameters.ParamByName('@org_localidad').Value := dm.ds_2.FieldByName('poblacion').asstring;
    dm.stpGrabaSrv.parameters.ParamByName('@org_provincia').Value := dm.ds_2.FieldByName('provincia').asstring;
    dm.stpGrabaSrv.parameters.ParamByName('@org_persona').Value := dm.ds_2.FieldByName('nombre').asstring;
    dm.stpGrabaSrv.parameters.ParamByName('@org_tfno').Value := dm.ds_2.FieldByName('telefono').asstring;

    dm.stpGrabaSrv.parameters.ParamByName('@coddestinatario').Value := StringReplace(default_deleg,'-','',[rfReplaceAll]);
    dm.stpGrabaSrv.parameters.ParamByName('@dst_codcli').Value := edCliente.Text;
    dm.stpGrabaSrv.parameters.ParamByName('@dst_coddel').Value := Copy(default_deleg,Pos('-',default_deleg)+1, Length(default_deleg));
    dm.stpGrabaSrv.parameters.ParamByName('@dst_nombre').Value := 'LOGINSER-ALMACEN';
    dm.stpGrabaSrv.parameters.ParamByName('@dst_calle').Value := 'Poniente, 10';
    dm.stpGrabaSrv.parameters.ParamByName('@dst_cp').Value := 46394;
    dm.stpGrabaSrv.parameters.ParamByName('@dst_localidad').Value := 'Ribarroja Del Turia';
    dm.stpGrabaSrv.parameters.ParamByName('@dst_provincia').Value := 'VALENCIA';
    dm.stpGrabaSrv.parameters.ParamByName('@dst_persona').Value:= '';
    dm.stpGrabaSrv.parameters.ParamByName('@dst_tfno').Value:= '902108957';

    dm.stpGrabaSrv.parameters.ParamByName('@codalbaran').Value:= codalb;
    dm.stpGrabaSrv.parameters.ParamByName('@codarticulo').Value:= null;

    if (dm.ds_2.FieldByName('delivery_time').asinteger=24) then
      dm.stpGrabaSrv.parameters.ParamByName('@refarticulo').Value:= edCliente.Text + '01'
    else
      dm.stpGrabaSrv.parameters.ParamByName('@refarticulo').Value:= edCliente.Text + '04'; //economy

    dm.stpGrabaSrv.parameters.ParamByName('@unidades').Value:= 1;
    dm.stpGrabaSrv.parameters.ParamByName('@sulinea').Value:= null;
    dm.stpGrabaSrv.parameters.ParamByName('@kgs').Value:= 1;
    dm.stpGrabaSrv.parameters.ParamByName('@att').Value:= null;
    dm.stpGrabaSrv.parameters.ParamByName('@DATOSVAERSA').Value:= null;
    dm.stpGrabaSrv.parameters.ParamByName('@CIFVAERSA').Value:= null;
    dm.stpGrabaSrv.parameters.ParamByName('@TelVAERSA').Value:= null;
    dm.stpGrabaSrv.parameters.ParamByName('@REEMBOLSO').Value:= null;
    dm.stpGrabaSrv.parameters.ParamByName('@VASEGURADO').Value:= null;
    dm.stpGrabaSrv.ExecProc;

    codservicio:=dm.stpGrabaSrv.Parameters.ParamByName('@codservicio').Value;

    dm.ds_1.close;                                                 //recoge lineas
    dm.ds_1.SelectSQL.clear;
    dm.ds_1.SelectSQL.Add('select * '+
      'from c_pedidos_lines '+
      'where id_pedido=:id_pedido and cantidad<0 ');
    dm.ds_1.ParamByName('id_pedido').AsInteger:=dm.ds_2.FieldByName('id_pedido').AsInteger;
    dm.ds_1.Open;

    dm.ds_1.First;
    while not(dm.ds_1.Eof) do begin
      dm.qryTemp.sql.clear;                                                  //nuevo codigo de movimiento
      dm.qryTemp.sql.add('select dbo.getCodMovimiento() as codmov');
      dm.qryTemp.open;

      codmovimiento:=dm.qryTemp.FieldByName('codmov').AsInteger;

      dm.q_sql5.Close;
      dm.q_sql5.SQL.Clear;
      dm.q_sql5.SQL.Add('insert into servicios_lineas (codservicio,codmovimiento,fmovimiento,codarticulo,e_s,codalbaran,unidades,sulinea) '+
      ' values (:codservicio,:codmovimiento,:fmovimiento,:codarticulo,:es,:codalbaran,:unidades,:sulinea) ');
      dm.q_sql5.Parameters.ParamByName('codservicio').value:=codservicio;
      dm.q_sql5.Parameters.ParamByName('codmovimiento').value:=codmovimiento;
      dm.q_sql5.Parameters.ParamByName('fmovimiento').Value:= Now;
      dm.q_sql5.Parameters.ParamByName('sulinea').Value:= dm.ds_2.FieldByName('order_name').asstring;

      dm.qryTemp.sql.clear;
      dm.qryTemp.sql.add('select codarticulo,articulo from articulos where referencia='+quotedstr(busca_art_ref(dm.ds_1.FieldByName('id_articulo').AsInteger)));
      dm.qryTemp.open;

      dm.q_sql5.Parameters.ParamByName('codarticulo').value := dm.qrytemp.FieldByName('codarticulo').AsInteger;
      dm.q_sql5.Parameters.ParamByName('es').value := 'R';
      dm.q_sql5.Parameters.ParamByName('codalbaran').value := codalb;
      dm.q_sql5.Parameters.ParamByName('unidades').value := Abs(dm.ds_1.FieldByName('cantidad').AsInteger);
      dm.q_sql5.ExecSQL;

      dm.ds_1.Next;
    end;

    dm.qryAlbEdit.open;
    dm.qryAlbEdit.append;
    dm.qryAlbEdit.fieldbyname('codalbaran').asstring:=IntToStr(codalb);
    dm.qryAlbEdit.fieldbyname('serie').asstring := '02';
    dm.qryAlbEdit.fieldbyname('fecha').asdatetime:=siguiente_laboral(date);
    dm.qryAlbEdit.fieldbyname('codcli').asstring:=edCliente.Text;

    dm.qryTemp.sql.clear;
    dm.qryTemp.sql.add('select * from dbo.getUnidadesAlbaranxServicio('+inttostr(codservicio)+')');
    dm.qryTemp.open;
    bultos:=dm.qryTemp.FieldByName('bultos').AsInteger;
    kgs:=dm.qryTemp.FieldByName('kgs').Asfloat;
    if kgs<=0 then kgs:=1;
    kgsVol := dm.qryTemp.FieldByName('kgsvol').Asfloat;

    dm.qryAlbEdit.fieldbyname('paquetes').asinteger:=dm.qryTemp.FieldByName('paquetes').AsInteger;
    dm.qryAlbEdit.fieldbyname('bultos').asinteger:=bultos;
    dm.qryAlbEdit.fieldbyname('kgs').AsFloat:=kgs;
    dm.qryTemp.close;

    if dm.ds_2.FieldByName('transporte').asinteger=1 then    //Medios del Cliente
    begin
        dm.qryAlbEdit.fieldbyname('codruta').asinteger:=0;
        dm.qryAlbEdit.fieldbyname('codrepartidor').asinteger:=0;
    end else begin
                dm.qryTemp.sql.clear;
                dm.qryTemp.sql.add('select dbo.getRutaxServicio('+inttostr(codservicio)+')');
                dm.qryTemp.open;
                ruta:=dm.qryTemp.fields[0].asinteger;
                dm.qryAlbEdit.fieldbyname('codruta').asinteger:=ruta;
                dm.qryTemp.close;

                dm.qryTemp.sql.clear;
                dm.qryTemp.sql.add('select codrepartidor from rutas where codruta='+inttostr(ruta));
                dm.qryTemp.open;
                dm.qryAlbEdit.fieldbyname('codrepartidor').asinteger:=dm.qryTemp.fields[0].asinteger;
                dm.qryTemp.close;
    end;

    dm.qryAlbEdit.fieldbyname('org_coddel').asstring:= '9999';
    dm.qryAlbEdit.fieldbyname('codremitente').asstring := edCliente.Text + '9999';

    dm.qryAlbEdit.fieldbyname('org_codcli').asstring := edCliente.Text;
    dm.qryAlbEdit.fieldbyname('org_nombre').asstring := dm.ds_2.FieldByName('nombre').asstring;
    dm.qryAlbEdit.fieldbyname('org_calle').asstring := Trim(dm.ds_2.FieldByName('dir_1').asstring);
    dm.qryAlbEdit.fieldbyname('org_cp').asstring := dm.ds_2.FieldByName('cp').asstring;
    dm.qryAlbEdit.fieldbyname('org_localidad').asstring := dm.ds_2.FieldByName('poblacion').asstring;
    dm.qryAlbEdit.fieldbyname('org_provincia').asstring := dm.ds_2.FieldByName('provincia').asstring;
    dm.qryAlbEdit.fieldbyname('org_persona').asstring := dm.ds_2.FieldByName('nombre').asstring;
    dm.qryAlbEdit.fieldbyname('org_tfno').asstring := dm.ds_2.FieldByName('telefono').asstring;

    dm.qryAlbEdit.fieldbyname('coddestinatario').asstring := edCliente.Text + '1';
    dm.qryAlbEdit.fieldbyname('dst_codcli').asstring :=edCliente.Text;
    dm.qryAlbEdit.fieldbyname('dst_coddel').asstring := '2';
    dm.qryAlbEdit.fieldbyname('dst_nombre').asstring := 'LOGINSER-ALMACEN';
    dm.qryAlbEdit.fieldbyname('dst_calle').asstring := 'Poniente, 10';
    dm.qryAlbEdit.fieldbyname('dst_cp').asstring :=  '46394';
    dm.qryAlbEdit.fieldbyname('dst_localidad').asstring := 'Ribarroja Del Turia';
    dm.qryAlbEdit.fieldbyname('dst_provincia').asstring := 'VALENCIA';
    dm.qryAlbEdit.fieldbyname('dst_persona').asstring := '';
    dm.qryAlbEdit.fieldbyname('dst_tfno').asstring := '902108957';

    dm.qryAlbEdit.fieldbyname('observaciones').asstring := '';
    dm.qryAlbEdit.fieldbyname('asegurado').asinteger:=0;
    dm.qryAlbEdit.fieldbyname('pdebido').asinteger:=0;
    dm.qryAlbEdit.fieldbyname('reembolso').asinteger:=0;
    dm.qryAlbEdit.fieldbyname('km').asinteger:=0;
    dm.qryAlbEdit.fieldbyname('e_s_r').asstring:='R';

    dm.qryTemp.sql.clear;
    dm.qryTemp.sql.add('select min(fmovimiento) from servicios_lineas (NOLOCK)');
    dm.qryTemp.sql.add(' where codservicio='+inttostr(codservicio));
    dm.qryTemp.open;



    s:= 'insert into albaranes_estados';
    s:= s+' (codalbaran,festado,codestado,persona,observaciones,ultimo)';
    s:= s+' values(';
    s:= s+ IntToStr(codalb) + ',';
    s:= s+ quotedstr(dm.qrytemp.Fields[0].asstring) + ',';
    s:= s+ IntToStr(estado_alb) + ',null,''Insertado por grabación de albarán'',''S'')';
    dm.qryTemp.close;
    dm.con1.execute(s);

    dm.con1.execute('exec lgAjustaMedidasAlbaran ' + IntToStr(codalb));

    dm.qryAlbEdit.post;

    dm.t_write.StartTransaction;
    try
      dm.q_1.Close;
      dm.q_1.sql.Clear;
      dm.q_1.sql.Add('update c_pedidos set albaran_r=:codalbaran,bultos=:bultos where id_pedido=:id_pedido');
      dm.q_1.ParamByName('codalbaran').AsInteger:=codalb;
      dm.q_1.ParamByName('id_pedido').AsInteger:=dm.ds_2.FieldByName('id_pedido').asinteger;
      dm.q_1.ParamByName('bultos').AsInteger:=bultos;
      dm.q_1.ExecQuery;
      dm.t_write.Commit;
    except
      dm.t_write.rollback;
    end;

    dm.ds_2.Next;
  end;   }
end;

procedure Tf_main.asigna_repartidor(pedidos: string);
var
  id_repartidor, rep_lgs, id_agencia: integer;
begin
  dm.ds_2.close;                                                 //recoge pedidos
  dm.ds_2.SelectSQL.clear;
  dm.ds_2.SelectSQL.Add('select * ' + 'from c_pedidos ' + 'where estado=''P'' and id_cliente=:id_cliente and origen_web=0 and transporte=0 ');
    //'where id_pedido between 7546 and 7571 and id_cliente=:id_cliente ');

  if pedidos <> '' then
    dm.ds_2.SelectSQL.Add(' and id_pedido in (' + pedidos + ')');

  dm.ds_2.ParamByName('id_cliente').AsInteger := StrToInt(edCliente.Text);
  dm.ds_2.Open;
  dm.ds_2.First;

  while not (dm.ds_2.Eof) do
  begin
    id_repartidor := -1;

    {id_agencia := get_agencia(dm.ds_2.FieldByName('id_cliente').AsInteger, dm.ds_2.FieldByName('peso').AsFloat, calcula_pais(dm.ds_2.FieldByName('pais').AsString), Copy(dm.ds_2.FieldByName('cp').AsString, 1, 2), dm.ds_2.FieldByName('cp').AsString);

    //rep_lgs := StrToInt(CargarDatosTabla('g_agencias','id_agencia','agencia_gestoras=' + IntToStr(id_agencia)));
    rep_lgs := GetRepartidorLgs(id_agencia);

    if rep_lgs >= 1 then
      id_repartidor := rep_lgs;
     }

    id_repartidor := calcula_agencia_gestoras(dm.ds_2.FieldByName('id_cliente').AsInteger,dm.ds_2.FieldByName('pais').AsString,Copy(dm.ds_2.FieldByName('cp').AsString, 1, 2),dm.ds_2.FieldByName('cp').AsString,dm.ds_2.FieldByName('peso').AsFloat);

    if id_repartidor < 0 then
    begin
      if repartidor > 0 then        //Si el cliente tiene repartidor por defecto
        id_repartidor := repartidor
      else
      begin
        rep_lgs := GetRepartidorLgs(dm.ds_2.FieldByName('codalbaran').AsInteger);
        if rep_lgs <> 0 then
        begin
          id_agencia := GetIdAgenciaXRepartidor(IntToStr(rep_lgs));
          if id_agencia <> 0 then
            id_repartidor := id_agencia;
        end;
        if id_repartidor = -1 then
          if ((dm.ds_2.FieldByName('pais').asstring = 'ES') and                                             //España y (
            (((dm.ds_2.FieldByName('cp').asstring[1] = '0') and (dm.ds_2.FieldByName('cp').asstring[2] = '7'))         //baleares 07
            or ((dm.ds_2.FieldByName('cp').asstring[1] = '3') and (dm.ds_2.FieldByName('cp').asstring[2] = '5'))      // o las palmas 35
            or ((dm.ds_2.FieldByName('cp').asstring[1] = '3') and (dm.ds_2.FieldByName('cp').asstring[2] = '8'))      // o  tenerife  38
            or ((dm.ds_2.FieldByName('cp').asstring[1] = '5') and (dm.ds_2.FieldByName('cp').asstring[2] = '1'))      // o ceuta      51
            or ((dm.ds_2.FieldByName('cp').asstring[1] = '5') and (dm.ds_2.FieldByName('cp').asstring[2] = '2'))      // o melilla)   52
            )) then
            id_repartidor := 2
          else
            id_repartidor := 1;
      end;
    end;

    dm.t_write.StartTransaction;
    try
      dm.q_1.Close;
      dm.q_1.sql.Clear;
      dm.q_1.sql.Add('update c_pedidos set id_repartidor=:id_repartidor where id_pedido=:id_pedido');
      dm.q_1.ParamByName('id_pedido').asinteger := dm.ds_2.FieldByName('id_pedido').asinteger;
      dm.q_1.ParamByName('id_repartidor').asinteger := id_repartidor;
      dm.q_1.ExecQuery;
      dm.t_write.Commit;
    except
      dm.t_write.rollback;
    end;

    dm.ds_2.Next;
  end;
end;


{$ENDREGION}

{$REGION 'Picking'}
function Tf_main.genera_picking(pedidos, peds_sin_alb: string; out errores_pick: TStringList): Boolean;
var
  pick_cab, id_articulo, id_ubicacion, id_lote, uds_lote: integer;
  nom_pick, old_order_name, filename, ubicacion_name, est,
  posi, alt, sub1, sub2, agencia_txt, lote, caducidad, imei, order_name, art_ref, art_nom: string;
  linea, codalb, codalb_ultimo: Integer;
begin

  errores_pick.Clear;

  codalb_ultimo := -1;

  result := True;

  ar_pick_ds.Close;
  ar_pick_ds.Active := true;
  ar_pick_ds.EmptyDataSet;

  f_detail.ar_pick_ds.Close;
  f_detail.ar_pick_ds.Active := true;
  f_detail.ar_pick_ds.EmptyDataSet;

  linea := 1;
  dm.t_write.StartTransaction;

  try
    dm.ds_2.close;                                                 //recoge picking
    dm.ds_2.SelectSQL.clear;

    if tiene_albs_gestoras then
    begin
      dm.ds_2.SelectSQL.Add('select s.codalbaran,l.id_pedido,s.order_name,s.observaciones, ' +
                            's.deliv_time_txt,l.id_articulo,l.sku,l.nombre_art, delivery_time, s.id_repartidor, ' +
                            'sum(l.cantidad) as uds ' +
                            'from c_pedidos s ' +
                            'inner join c_pedidos_lines l on (s.id_pedido=l.id_pedido) ' +
                            'where estado=''G'' and s.id_cliente=:id_cliente and l.cantidad>0 '
        //'where s.id_pedido>=8469 and s.id_cliente=:id_cliente and l.cantidad>0' +
      );

      if pedidos <> '' then
        dm.ds_2.SelectSQL.Add(' and s.id_pedido in (' + pedidos + ') ');

      if peds_sin_alb <> '' then
        dm.ds_2.SelectSQL.Add(' and s.id_pedido not in (' + peds_sin_alb + ') ');

      dm.ds_2.SelectSQL.Add('group by s.codalbaran,l.id_pedido,s.order_name, s.observaciones,s.deliv_time_txt,l.id_articulo,l.sku,l.nombre_art, delivery_time,s.id_repartidor ');

      dm.ds_2.ParamByName('id_cliente').AsInteger := StrToInt(edCliente.Text);
      dm.ds_2.Open;
    end
    else
    begin
      dm.ds_2.SelectSQL.Add('select l.id_pedido,s.order_name,s.observaciones, ' +
      's.deliv_time_txt,l.id_articulo,l.sku,l.nombre_art, delivery_time, s.id_repartidor, ' +
      'sum(l.cantidad) as uds ' +
      'from c_pedidos s ' +
      'inner join c_pedidos_lines l on (s.id_pedido=l.id_pedido) ' +
      'where estado=''G'' and s.id_cliente=:id_cliente and l.cantidad>0 '
                    //'where s.id_pedido>=8469 and s.id_cliente=:id_cliente and l.cantidad>0' +
      );

      if pedidos <> '' then
        dm.ds_2.SelectSQL.Add(' and s.id_pedido in (' + pedidos + ') ');

      if peds_sin_alb <> '' then
        dm.ds_2.SelectSQL.Add(' and s.id_pedido not in (' + peds_sin_alb + ') ');

      dm.ds_2.SelectSQL.Add('group by l.id_pedido,s.order_name, s.observaciones, ' + 's.deliv_time_txt,l.id_articulo,l.sku,l.nombre_art, delivery_time,s.id_repartidor ');

      dm.ds_2.ParamByName('id_cliente').AsInteger := StrToInt(edCliente.Text);
      dm.ds_2.Open;
    end;

    result := not dm.ds_2.IsEmpty;

    //Si hay lineas creamos el picking
    if not dm.ds_2.IsEmpty then
    begin
      dm.ds_2.First;

      order_name := dm.ds_2.FieldByName('order_name').AsString;

      dm.ds_1.Close;                                                            //id cabecera
      dm.ds_1.SQLs.SelectSQL.Clear;
      dm.ds_1.SQLs.SelectSQL.Add('SELECT GEN_ID(gen_a_pickcab_id,1) FROM RDB$DATABASE');
      dm.ds_1.Open;

      pick_cab := dm.ds_1.FieldByName('gen_id').AsInteger;

      InsertaLog(u_main.usuario.id,pick_cab,0,PC.Nombre,PC.IP,log_app,'picking','','IniGenPick ' + IntToStr(main_cli),'Peds.' + pedidos+'-'+peds_sin_alb);

      dm.q_1.Close;                                                                   //genera cabecera
      dm.q_1.SQL.Clear;
      dm.q_1.SQL.Add('insert into a_pickcab (ID_PICKCAB,ID_DOC,ID_CLIENTE,NOMBRE,FECHA,HORA,ID_USUARIO,ID_EMPRESA,ESTADO,ID_ALMACEN) ' + ' values (:ID_PICKCAB,:ID_DOC,:ID_CLIENTE,:NOMBRE,:FECHA,:HORA,:ID_USUARIO,:ID_EMPRESA,:ESTADO,:ID_ALMACEN)');
      dm.q_1.ParamByName('id_pickcab').AsInteger := pick_cab;
      dm.q_1.ParamByName('id_doc').AsInteger := 1;
      dm.q_1.ParamByName('id_cliente').AsInteger := StrToInt(edCliente.Text);
      if main_cli=7078 then
        nom_pick := 'Pick ' + order_name + ' ' + lbCliente.Caption + ' ' + edCliente.Text + '-' + formatdatetime('dd/mm/yy', date)
      else if (StrToInt(cl_padres[0])<0) then
              nom_pick := 'Pick ' + lbCliente.Caption + ' ' + edCliente.Text + '-' + formatdatetime('dd/mm/yy', date)
           else
              nom_pick := 'PickH ' + lbCliente.Caption  + ' ' + edCliente.Text + '-' + formatdatetime('dd/mm/yy', date);

      dm.q_1.ParamByName('nombre').asstring := nom_pick;
      dm.q_1.ParamByName('fecha').asdate := date;
      dm.q_1.ParamByName('hora').astime := time;
      dm.q_1.ParamByName('id_usuario').AsInteger := usuario.id;
      dm.q_1.ParamByName('id_empresa').AsInteger := 1;
      dm.q_1.ParamByName('estado').asstring := 'A';
      dm.q_1.ParamByName('id_almacen').AsInteger := id_almacen;
      dm.q_1.ExecQuery;
      dm.t_write.CommitRetaining;

      InsertaLog(usuario.id,pick_cab,0,PC.Nombre,PC.IP,log_app,'picking','','InsertPickCab',nom_pick);

      while not (dm.ds_2.Eof) do
      begin           //para cada pedido
        if StrToInt(cl_padres[0])<0 then
            id_articulo := dm.ds_2.FieldByName('id_articulo').asinteger
        else
            id_articulo := busca_articulo_heredado(dm.ds_2.FieldByName('id_articulo').asinteger);
            //id_articulo := busca_art(get_codcli_art(dm.ds_2.FieldByName('id_articulo').asinteger),cl_padre);

        BuscarUbicacionDeArticulo(id_articulo, id_almacen, id_ubicacion, est, posi, alt, sub1, sub2, id_lote);

        dm.q_1.Close;
        dm.q_1.SQL.Clear;
        dm.q_1.SQL.Add('insert into a_picklin (ID_PICKCAB,ID_AGRUPA,NIVEL_AGR,LINEA,ID_RUTA,ID_ARTICULO,ID_UBICACION,CANTIDAD,ID_EMPRESA,ESTADO,CODALBARAN,CODMOVIMIENTO,SULINEA, ID_LOTE) ' + ' values (:ID_PICKCAB,:ID_AGRUPA,:NIVEL_AGR,:LINEA,:ID_RUTA,:ID_ARTICULO,:ID_UBICACION,:CANTIDAD,:ID_EMPRESA,:ESTADO,:CODALBARAN,:CODMOVIMIENTO,:SULINEA, :ID_LOTE)');
        dm.q_1.ParamByName('id_pickcab').AsInteger := pick_cab;
        dm.q_1.ParamByName('id_agrupa').AsInteger := 0;
        dm.q_1.ParamByName('nivel_agr').AsInteger := 1;
        dm.q_1.ParamByName('linea').AsInteger := linea;
        Inc(linea);
        dm.q_1.ParamByName('id_ruta').AsInteger := 0;
        dm.q_1.ParamByName('id_articulo').AsInteger := id_articulo;
        dm.q_1.ParamByName('id_ubicacion').AsInteger := id_ubicacion;
        dm.q_1.ParamByName('cantidad').AsInteger := dm.ds_2.FieldByName('uds').asinteger;
        dm.q_1.ParamByName('id_empresa').AsInteger := 1;
        dm.q_1.ParamByName('estado').asstring := 'A';
        if tiene_albs_gestoras then
          dm.q_1.ParamByName('codalbaran').AsInteger := dm.ds_2.FieldByName('codalbaran').asinteger
        else
          dm.q_1.ParamByName('codalbaran').AsInteger := dm.ds_2.FieldByName('id_pedido').asinteger;
        dm.q_1.ParamByName('codmovimiento').AsInteger := 0;
        dm.q_1.ParamByName('sulinea').AsString := '';
        dm.q_1.ParamByName('id_lote').AsInteger := id_lote;
        dm.q_1.ExecQuery;

        if StrToInt(cl_padres[0])<0 then
          InsertaLog(usuario.id,pick_cab,0,PC.Nombre,PC.IP,log_app,'picking','','InsertPickLin','Art.'+IntToStr(id_articulo) + ' Uds.'+dm.ds_2.FieldByName('uds').AsString + ' Alb.'+dm.ds_2.FieldByName('codalbaran').asstring + ' Ped.' + dm.ds_2.FieldByName('id_pedido').AsString)
        else
          InsertaLog(usuario.id,pick_cab,0,PC.Nombre,PC.IP,log_app,'picking','','InsertPickLinPadre','Art.'+IntToStr(id_articulo) + ' Uds.'+dm.ds_2.FieldByName('uds').AsString + ' Alb.'+dm.ds_2.FieldByName('codalbaran').asstring + ' Ped.' + dm.ds_2.FieldByName('id_pedido').AsString);

        {Al generar no se guarda el lote en c_pedidos_lines_lotes, por lo que el lote que se
         coge de la ubicación no es definitivo. Es después del picking cuando actualizan los lotes
         pinchando el botón Actualizar Lotes.
         Por lo tanto, de momento no gastamos recursos buscando datos innecesarios. No quito la
         linea por si en un futuro calculamos aquí el lote definitivo.}
        //GetLoteCaducidad(id_lote,lote,caducidad);

        {De la misma forma, habrá que controlar la cantidad que se coge de cada lote para cada linea }
        //uds_lote := dm.ds_2.FieldByName('uds').asinteger;

        lote := '';
        caducidad := '';
        uds_lote := 0;

        ubicacion_name := est + '-' + posi + '-' + alt + '-' + sub1;

        dm.ds_1.Close;                                                            //datos de cabecera (es una burrada hacerlo por linea)
        dm.ds_1.SQLs.SelectSQL.Clear;
        dm.ds_1.SQLs.SelectSQL.Add('SELECT * ' + ' from c_pedidos ' + ' where id_pedido=:id_pedido');
        dm.ds_1.ParamByName('id_pedido').AsInteger := dm.ds_2.FieldByName('id_pedido').asinteger;
        dm.ds_1.Open;

        if dm.ds_1.fieldbyname('transporte').AsInteger = 0 then
          agencia_txt := GetNombreAgencia(dm.ds_1.fieldbyname('id_repartidor').AsInteger)
        else
          agencia_txt := '';

        uds_lote := dm.ds_2.FieldByName('uds').asinteger;

        if tiene_albs_gestoras then
          codalb := dm.ds_1.FieldByName('codalbaran').asinteger
        else
          codalb := dm.ds_1.FieldByName('id_pedido').asinteger;

        f_detail.InsertLinePicking(id_articulo,                             //id_art
          busca_art_ref(id_articulo),                                           //ref_art
          dm.ds_2.FieldByName('uds').asinteger,             //uds
          imei,                                             //imei
          Integer(tiene_lotes),                             //tiene_lotes
          lote, caducidad, uds_lote,                        //lote, caducidad, uds_lote
          id_ubicacion, ubicacion_name,                                   //ubicacion
          UpperCase(busca_art_nom(id_articulo)),            //artículo
          dm.ds_1.FieldByName('order_name').asstring,       //pedido
          dm.ds_1.FieldByName('nombre').asstring,           //nombre
          Trim(dm.ds_1.FieldByName('dir_1').asstring),      //direccion
          dm.ds_1.FieldByName('poblacion').asstring,        //poblacion
          dm.ds_1.FieldByName('provincia').asstring,        //provincia
          dm.ds_1.FieldByName('cp').asstring,               //cp
          dm.ds_1.FieldByName('email').asstring,            //email
          dm.ds_1.FieldByName('telefono').asstring,         //telefono
          codalb,                                           //codalbaran
                          //dm.ds_2.FieldByName('delivery_time').AsString,  //deliv_time
          dm.ds_1.FieldByName('pais_code').asstring,        //cod_pais
          UpperCase(dm.ds_1.FieldByName('tags').asstring),  //tag
          dm.ds_1.FieldByName('es_devo').AsInteger,         //es_devo
          dm.ds_1.FieldByName('observaciones').asstring,    //observaciones
          agencia_txt,                                      //agencia_txt
          dm.ds_1.FieldByName('deliv_time_txt').AsString,   //dt_txt
          dm.ds_1.FieldByName('contacto').AsString,         //contacto
          (dm.ds_1.FieldByName('con_retorno').AsInteger = 1), //con retorno
          dm.ds_1.FieldByName('tipo_servicio').AsString,    //servicio
          dm.ds_1.FieldByName('horario').AsString);         //horario

        if tiene_albs_gestoras and (codalb <> codalb_ultimo) then
        begin
          dm.t_write_gestoras.StartTransaction;
          dm.tmpGest.Close;
          dm.tmpGest.SQL.Clear;
          dm.tmpGest.SQL.Add('insert into albaran_picking(ID_ALBARAN,ID_PICKING,USUARIO,FECHA,BORRADO) values (' +
                             ':ID_ALBARAN,:ID_PICKING,:USUARIO,:FECHA,:BORRADO)');
          dm.tmpGest.ParamByName('id_albaran').AsInteger := codalb;
          dm.tmpGest.ParamByName('id_picking').AsInteger := pick_cab;
          dm.tmpGest.ParamByName('usuario').AsInteger := usuario.id;
          dm.tmpGest.ParamByName('fecha').AsDate := Now;
          dm.tmpGest.ParamByName('borrado').AsInteger := 0;
          dm.tmpGest.ExecQuery;
          dm.t_write_gestoras.CommitRetaining;
          codalb_ultimo := codalb;
        end;

        dm.ds_2.Next;
      end;

      lb_st1.Caption := 'Actualizando pick en pedidos...';
      dm.q_1.Close;
      dm.q_1.SQL.Clear;
      dm.q_1.SQL.Add('update c_pedidos set picking=:id_pick ' + 'where id_pedido in (' + pedidos + ')');
      dm.q_1.ParamByName('id_pick').AsInteger := pick_cab;
      dm.q_1.ExecQuery;
      InsertaLog(usuario.id,pick_cab,0,PC.Nombre,PC.IP,log_app,'picking','','UpdatePick ' + IntToStr(pick_cab) + ' EnPedidos' ,pedidos);
    end;

    dm.t_write.Commit;

    if tiene_albs_gestoras then
      dm.t_write_gestoras.Commit;

    lb_st1.Caption := 'Picking Generado ' + inttostr(pick_cab);
    application.ProcessMessages;

    if (f_detail.ar_pick_ds.RecordCount > 0) and (main_cli<>7078) then
      f_detail.LanzaImpresion;
  except
    on E: exception do
    begin
      errores_pick.Add('Error creando picking ' + IntToStr(pick_cab) + ': ' + E.Message);
      dm.t_write.Rollback;
      if tiene_albs_gestoras then
        dm.t_write_gestoras.Rollback;
      result := False;
    end;
  end;
      InsertaLog(u_main.usuario.id,pick_cab,0,PC.Nombre,PC.IP,log_app,'picking','','FinGenPick','Peds.' + pedidos);
end;

function Tf_main.genera_picking_abierto_old(pedidos: string): Boolean;
var
  error, error_exe, titulo_error: string;
begin
  dm.t_write.StartTransaction;

  try
    if tiene_albs_gestoras then
    begin
      dm.ds_2.close;                                                 //recoge picking
      dm.ds_2.SelectSQL.clear;
      dm.ds_2.SelectSQL.Add('select * ' + 'from tmp_picking ' + 'where codalbaran in (' + pedidos + ')');
      dm.ds_2.Open;

      dm.ds_2.SelectSQL.Add('select codalbaran ' + 'from c_pedidos ' + 'where id_pedido in (' + pedidos + ')');
      dm.ds_2.Open;

      if not dm.ds_2.IsEmpty then
      begin

      end;
    end;

    dm.t_write.Commit;
  except
    dm.t_write.Rollback;
  end;

  try
    dm.genera_pick_abierto.Database := dm.db;
    dm.genera_pick_abierto.SQL.Clear;
    dm.genera_pick_abierto.SQL.Add('execute procedure c_picking()');
    dm.genera_pick_abierto.ParamByName('pedido').Value := dm.ds_2.FieldByName('id_pedido').AsInteger;
    dm.genera_pick_abierto.ParamByName('id_almacen').Value := id_almacen;
    dm.genera_pick_abierto.ExecProc;
    dm.t_write_gestoras.CommitRetaining;

    error := dm.genera_pick_abierto.ParamByName('error').Value;
  except
    on E: Exception do
    begin
      error_exe := 'Error creando picking. ' + titulo_error;
      result := False;
      dm.t_write.RollbackRetaining;
      raise;
    end;
  end;

end;

function Tf_main.genera_picking_abierto(pedidos, peds_sin_alb: string; out errores_pick: TStringList): Boolean;
var
  id_pickcab, id_packcab, line_pick, line_pack, id_agrupa, i, idx: integer;
  todo_ok: Boolean;
  peds_1_elem: string;
begin
  line_pick := 0;
  line_pack := 0;
  get_pick;

  todo_ok := True;
  pick_con_lote_asignado := False;

  try
    dm.t_write.StartTransaction;

    dm.ds_1.Close;
    dm.ds_1.SQLs.SelectSQL.Clear;
    dm.ds_1.SQLs.SelectSQL.Add('SELECT p.codalbaran,p.id_order,sum(l.cantidad) ' +
                               'from c_pedidos_lines l ' +
                               'inner join c_pedidos p on p.id_pedido=l.id_pedido ' +
                               'where p.estado=''G'' and id_cliente=' + edCliente.Text);
                               //'where id_cliente='+ edCliente.Text);

    if pedidos <> '' then
      dm.ds_1.SelectSQL.Add(' and l.id_pedido in (' + pedidos + ') ');

    if peds_sin_alb <> '' then
      dm.ds_1.SelectSQL.Add(' and l.id_pedido not in (' + peds_sin_alb + ') ');

    dm.ds_1.SQLs.SelectSQL.Add('group by codalbaran, id_order having sum(l.cantidad)>0');

    dm.ds_1.Open;

    if dm.ds_1.IsEmpty then
      Exit;


    dm.ds_1.Close;                                                            //id cabecera
    dm.ds_1.SQLs.SelectSQL.Clear;
    dm.ds_1.SQLs.SelectSQL.Add('SELECT GEN_ID(gen_a_pickcab_id,1) FROM RDB$DATABASE');
    dm.ds_1.Open;

    id_pickcab := dm.ds_1.FieldByName('gen_id').AsInteger;

    InsertaLog(u_main.usuario.id,id_pickcab,0,PC.Nombre,PC.IP,log_app,'picking','','IniGenPickAb ' + IntToStr(main_cli),'Peds.' + pedidos+'-'+peds_sin_alb);

    dm.q_1.Close;                                                                   //genera cabecera
    dm.q_1.SQL.Clear;
    dm.q_1.SQL.Add('insert into a_pickcab (ID_PICKCAB,ID_DOC,ID_CLIENTE,NOMBRE,FECHA,HORA,ID_USUARIO,ID_EMPRESA,ESTADO,modo,preprocessed) ' +
                   ' values (:ID_PICKCAB,:ID_DOC,:ID_CLIENTE,:NOMBRE,:FECHA,:HORA,:ID_USUARIO,:ID_EMPRESA,:ESTADO,:modo,1)');
    dm.q_1.ParamByName('id_pickcab').AsInteger := id_pickcab;
    dm.q_1.ParamByName('id_doc').AsInteger := 1;

    if StrToInt(cl_padres[0])<0 then
        dm.q_1.ParamByName('nombre').asstring := 'Pick Ab. ' + lbCliente.Caption + ' ' + edCliente.Text + '-' + formatdatetime('dd/mm/yy', date)
     else
        dm.q_1.ParamByName('nombre').asstring := 'PickH Ab. ' + edCliente.Text + ' ' + lbCliente.Caption + ' ' + formatdatetime('dd/mm/yy', date);
;

    dm.q_1.ParamByName('id_cliente').AsInteger := StrToInt(edCliente.Text);

    //dm.q_1.ParamByName('nombre').asstring:='PRUEBAS NO TOCAR';
    dm.q_1.ParamByName('fecha').asdate := date;
    dm.q_1.ParamByName('hora').astime := time;
    dm.q_1.ParamByName('id_usuario').AsInteger := usuario.id;
    dm.q_1.ParamByName('id_empresa').AsInteger := 1;
    dm.q_1.ParamByName('estado').asstring := 'A';
    dm.q_1.ParamByName('modo').AsInteger := 1;
    dm.q_1.ExecQuery;
    dm.t_write.CommitRetaining;

    dm.ds_1.Close;
    dm.ds_1.SQLs.SelectSQL.Clear;
    dm.ds_1.SQLs.SelectSQL.Add('SELECT GEN_ID(gen_a_packcab_id,1) FROM RDB$DATABASE');
    dm.ds_1.Open;

    id_packcab := dm.ds_1.FieldByName('gen_id').AsInteger;

    dm.q_1.Close;                                                                   //genera cabecera
    dm.q_1.SQL.Clear;
    dm.q_1.SQL.Add('insert into a_packcab (ID_PACKCAB,ID_DOC,ID_CLIENTE,NOMBRE,FECHA,HORA,ID_USUARIO,ID_EMPRESA,ESTADO,ID_PICKCAB,MODO,ID_ALMACEN) ' + ' values (:ID_PACKCAB,:ID_DOC,:ID_CLIENTE,:NOMBRE,:FECHA,:HORA,:ID_USUARIO,:ID_EMPRESA,:ESTADO,:ID_PICKCAB,:MODO,:ID_ALMACEN)');
    dm.q_1.ParamByName('id_packcab').AsInteger := id_packcab;
    dm.q_1.ParamByName('id_doc').AsInteger := 1;
    dm.q_1.ParamByName('id_cliente').AsInteger := StrToInt(edCliente.Text);
    if StrToInt(cl_padres[0])<0 then
        dm.q_1.ParamByName('nombre').asstring := 'Pack Ab. ' + BuscaCliente(edCliente.Text) + ' ' + inttostr(id_pickcab) + ' Pack ' + inttostr(id_packcab) + ' ' + formatdatetime('dd/mm/yy', date)
    else
        dm.q_1.ParamByName('nombre').asstring := 'PackH Ab. ' + BuscaCliente(edCliente.Text) + ' ' + inttostr(id_pickcab) + ' Pack ' + inttostr(id_packcab) + ' ' + formatdatetime('dd/mm/yy', date);
    //dm.q_1.ParamByName('nombre').asstring:='PRUEBAS NO TOCAR';
    dm.q_1.ParamByName('fecha').asdate := date;
    dm.q_1.ParamByName('hora').astime := time;
    dm.q_1.ParamByName('id_usuario').AsInteger := usuario.id;
    dm.q_1.ParamByName('id_empresa').AsInteger := 1;
    dm.q_1.ParamByName('estado').asstring := 'A';
    dm.q_1.ParamByName('id_pickcab').AsInteger := id_pickcab;
    dm.q_1.ParamByName('modo').AsInteger := 4;
    dm.q_1.ParamByName('id_almacen').asinteger := id_almacen;
    dm.q_1.ExecQuery;
    dm.t_write.CommitRetaining;

    //Si el cliente trabaja con lotes, recogemos lotes asignados a pedidos
    if tiene_lotes then
    begin
        dm.ds_1.Close;
        dm.ds_1.SQLs.SelectSQL.Clear;
        dm.ds_1.SQLs.SelectSQL.Add('select l.id_lote, sum(l.cantidad) as uds ' +
                                   'from c_pedidos_lines l ' +
                                   'inner join c_pedidos p on p.id_pedido=l.id_pedido ' +
                                   'where l.id_lote>1 and p.estado=''P'' and picking is null and p.fecha_ped>=:fecha ' +
                                   ' and id_cliente=' + edCliente.Text);

        if pedidos <> '' then
            dm.ds_1.SelectSQL.Add(' and l.id_pedido in (' + pedidos + ') ');

        if peds_sin_alb <> '' then
            dm.ds_1.SelectSQL.Add(' and l.id_pedido not in (' + peds_sin_alb + ') ');

        dm.ds_1.SelectSQL.Add(' group by 1');

        dm.ds_1.ParamByName('fecha').AsDate := StrToDate('07/01/2021'); //01.07.2021

        dm.ds_1.Open;

        pick_con_lote_asignado := not dm.ds_1.IsEmpty;

        if not dm.ds_1.IsEmpty then
        begin

            idx := 0;
            setlength(lotes_reservados, idx);

            dm.ds_1.First;
            while not dm.ds_1.Eof do
            begin
              Inc(idx);
              setlength(lotes_reservados, idx);

              lotes_reservados[idx-1].id_lote := dm.ds_1.FieldByName('id_lote').AsInteger;
              lotes_reservados[idx-1].uds := dm.ds_1.FieldByName('uds').AsInteger;
              dm.ds_1.Next;
            end;
        end;
    end;

    cuenta_caja := 0;

    dm.ds_1.Close;                                                           //Primera Pasada 1 Elemento
    dm.ds_1.SQLs.SelectSQL.Clear;
    dm.ds_1.SQLs.SelectSQL.Add('SELECT p.codalbaran,p.id_order, p.id_pedido ,sum(l.cantidad) ' +
                               'from c_pedidos_lines l ' +
                               'inner join c_pedidos p on p.id_pedido=l.id_pedido ' +
                               'where p.estado=''G'' and id_cliente=' + edCliente.Text);
                               //'where id_cliente='+ edCliente.Text);
    if pedidos <> '' then
      dm.ds_1.SelectSQL.Add(' and l.id_pedido in (' + pedidos + ') ');

    if peds_sin_alb <> '' then
      dm.ds_1.SelectSQL.Add(' and l.id_pedido not in (' + peds_sin_alb + ') ');

    dm.ds_1.SelectSQL.Add('group by codalbaran, id_order, id_pedido having sum(l.cantidad)=1');
    dm.ds_1.Open;

    lb_st1.Caption := 'Primera Pasada 1 Elemento';
    Application.ProcessMessages;

    dm.ds_1.First;

    peds_1_elem := '';

    while not (dm.ds_1.Eof) do
    begin
      Inc(cuenta_caja);
      try
        add_pick(dm.ds_1.FieldByName('id_pedido').AsInteger, dm.ds_1.FieldByName('codalbaran').AsInteger, id_pickcab, id_packcab, 120, 'ES', line_pick, line_pack);
      except
        on e: Exception do
          errores_pick.Add('1 elem. ' + e.Message);
      end;
      peds_1_elem := peds_1_elem + dm.ds_1.FieldByName('id_pedido').AsString + ',';
      dm.ds_1.next;
    end;

    peds_1_elem := Copy(peds_1_elem, 1, Length(peds_1_elem) - 1);

    //*****************************************************VERIFICA CANTIDAD DE PENDIENTES
    lb_st1.Caption := 'Verificando Pendientes';
    application.ProcessMessages;

    dm.ds_3.Close;
    dm.ds_3.SelectSQL.Clear;
    dm.ds_3.SelectSQL.add('select sum(cantidad) as tot_resto from ( ' +
                            'select codalbaran,sum(cantidad) as cantidad ' +
                            'from c_pedidos_lines l ' +
                            'inner join c_pedidos p on p.id_pedido=l.id_pedido ' +
                            'where p.estado=''G'' and id_cliente=' + edCliente.Text);
      //'where id_cliente='+ edCliente.Text);
    if pedidos <> '' then
      dm.ds_3.SelectSQL.Add(' and l.id_pedido in (' + pedidos + ') ');

    if peds_sin_alb <> '' then
      dm.ds_3.SelectSQL.Add(' and l.id_pedido not in (' + peds_sin_alb + ') ');

    dm.ds_3.SelectSQL.Add(' group by codalbaran ' + 'having sum(cantidad)>1) ');
    dm.ds_3.Open;

    //*****************************************************TODO EL RESTO A LA AGRUPACION DE OTROS
    if (dm.ds_3.fieldbyname('tot_resto').asinteger < uds_resto) then
    begin
      lb_st1.Caption := 'Segunda Pasada, Resto Albs';
      application.ProcessMessages;

      dm.ds_1.Close;
      dm.ds_1.SelectSQL.clear;
      dm.ds_1.SelectSQL.add('select codalbaran,p.id_order, p.id_pedido,sum(cantidad) as cantidad ' +
                            'from c_pedidos_lines l ' +
                            'inner join c_pedidos p on p.id_pedido=l.id_pedido ' +
                            'where p.estado=''G'' and id_cliente=' + edCliente.Text);
                            //'where id_cliente='+ edCliente.Text);
      if pedidos <> '' then
        dm.ds_1.SelectSQL.Add(' and l.id_pedido in (' + pedidos + ') ');

      if peds_sin_alb <> '' then
        dm.ds_1.SelectSQL.Add(' and l.id_pedido not in (' + peds_sin_alb + ') ');

      dm.ds_1.SelectSQL.Add('group by codalbaran, id_order, id_pedido ' + 'having sum(cantidad)>1');
      dm.ds_1.Open;
      dm.ds_1.First;

      cuenta_caja := 0;

      while not (dm.ds_1.Eof) do
      begin
        Inc(cuenta_caja);
        try
          add_pick(dm.ds_1.FieldByName('id_pedido').AsInteger, dm.ds_1.FieldByName('codalbaran').AsInteger, id_pickcab, id_packcab, 126, 'ES', line_pick, line_pack);
        except
          on e: Exception do
            errores_pick.Add('Resto ' + e.Message);
        end;
        dm.ds_1.Next;
      end;
    end
    else
    begin   //*****************************************************AGRUPA POR RUTA/REPARTIDOR

      lb_st1.Caption := 'Recorriendo Agencias';
      application.ProcessMessages;

      dm.qAgencias.Close;
      dm.qAgencias.SelectSQL.Clear;
      dm.qAgencias.SelectSQL.add('select * from g_agencias where agencia_gestoras>=0');
      dm.qAgencias.Open;
      dm.qAgencias.first;

      while not dm.qAgencias.eof do
      begin
        id_agrupa := get_agrup_agencia(dm.qAgencias.FieldByName('agencia_gestoras').AsInteger);

        if id_agrupa >= 0 then
        begin
          lb_st1.Caption := UpperCase(dm.qAgencias.FieldByName('nombre').AsString);
          Application.ProcessMessages;

          dm.ds_1.Close;
          dm.ds_1.SQLs.SelectSQL.Clear;
          dm.ds_1.SQLs.SelectSQL.Add('SELECT * from c_pedidos where estado=''G'' and id_repartidor=:agencia and id_cliente=' + edCliente.Text);

          if pedidos <> '' then
            dm.ds_1.SelectSQL.Add(' and id_pedido in (' + pedidos + ') ');

          if peds_1_elem <> '' then
            dm.ds_1.SelectSQL.Add(' and id_pedido not in (' + peds_1_elem + ') ');

          if peds_sin_alb <> '' then
            dm.ds_1.SelectSQL.Add(' and id_pedido not in (' + peds_sin_alb + ') ');

          dm.ds_1.ParamByName('agencia').AsInteger := dm.qAgencias.FieldByName('id_agencia').AsInteger;
          dm.ds_1.Open;
          dm.ds_1.First;

          cuenta_caja := 0;

          while not (dm.ds_1.Eof) do
          begin
            Inc(cuenta_caja);
            try
              add_pick(dm.ds_1.FieldByName('id_pedido').AsInteger, dm.ds_1.FieldByName('codalbaran').AsInteger, id_pickcab, id_packcab, id_agrupa, 'ES', line_pick, line_pack);
            except
              on e: Exception do
                errores_pick.Add(UpperCase(dm.qAgencias.FieldByName('nombre').AsString) + e.Message);
            end;
            dm.ds_1.next;
          end;
        end;
        dm.qAgencias.Next;
      end;

        {  lb_st1.Caption:='Tercera Pasada ASM';
          Application.ProcessMessages;

          dm.ds_1.Close;                                                           //Tercera Pasada ASM
          dm.ds_1.SQLs.SelectSQL.Clear;
          dm.ds_1.SQLs.SelectSQL.Add('SELECT * from c_pedidos where estado=''G'' and id_repartidor=2 and id_cliente='+ edCliente.Text);

          if pedidos <> '' then
              dm.ds_1.SelectSQL.Add(' and id_pedido in (' + pedidos + ') ');

          if peds_1_elem <> '' then
              dm.ds_1.SelectSQL.Add(' and id_pedido not in (' + peds_1_elem + ') ');

          if peds_sin_alb <> '' then
              dm.ds_1.SelectSQL.Add(' and id_pedido not in (' + peds_sin_alb + ') ');

          dm.ds_1.Open;
          dm.ds_1.First;

          cuenta_caja := 0;

          while not(dm.ds_1.Eof) do begin
            Inc(cuenta_caja);
            try
               add_pick(dm.ds_1.FieldByName('id_pedido').AsInteger, dm.ds_1.FieldByName('codalbaran').AsInteger, id_pickcab, id_packcab, 130, 'ES',line_pick,line_pack);
            except on e:Exception do
               errores_pick.Add('GLS ' + e.Message);
            end;
            dm.ds_1.next;
          end;

          lb_st1.Caption:='Cuarta Pasada Mensytrans';
          Application.ProcessMessages;

          dm.ds_1.Close;                                                           //Cuarta Pasada Mensytrans
          dm.ds_1.SQLs.SelectSQL.Clear;
          dm.ds_1.SQLs.SelectSQL.Add('SELECT * from c_pedidos where estado=''G'' and id_repartidor=4 and id_cliente='+ edCliente.Text);

          if pedidos <> '' then
              dm.ds_1.SelectSQL.Add(' and id_pedido in (' + pedidos + ') ');

          if peds_1_elem <> '' then
              dm.ds_1.SelectSQL.Add(' and id_pedido not in (' + peds_1_elem + ') ');

          if peds_sin_alb <> '' then
              dm.ds_1.SelectSQL.Add(' and id_pedido not in (' + peds_sin_alb + ') ');

          dm.ds_1.Open;
          dm.ds_1.First;

          cuenta_caja := 0;

          while not(dm.ds_1.Eof) do begin
            Inc(cuenta_caja);
            try
             add_pick(dm.ds_1.FieldByName('id_pedido').AsInteger, dm.ds_1.FieldByName('codalbaran').AsInteger, id_pickcab, id_packcab, 122, 'ES',line_pick,line_pack);
            except on e:Exception do
               errores_pick.Add('Mensy ' + e.Message);
            end;
            dm.ds_1.next;
          end;

          lb_st1.Caption:='Quinta Pasada Loginser';
          Application.ProcessMessages;

          dm.ds_1.Close;                                                           //Quinta Pasada Loginser
          dm.ds_1.SQLs.SelectSQL.Clear;
          dm.ds_1.SQLs.SelectSQL.Add('SELECT * from c_pedidos where estado=''G'' and id_repartidor=1 and id_cliente='+ edCliente.Text);

          if pedidos <> '' then
              dm.ds_1.SelectSQL.Add(' and id_pedido in (' + pedidos + ') ');

          if peds_1_elem <> '' then
              dm.ds_1.SelectSQL.Add(' and id_pedido not in (' + peds_1_elem + ') ');

          if peds_sin_alb <> '' then
              dm.ds_1.SelectSQL.Add(' and id_pedido not in (' + peds_sin_alb + ') ');

          dm.ds_1.Open;
          dm.ds_1.First;

          cuenta_caja := 0;

          while not(dm.ds_1.Eof) do begin
            Inc(cuenta_caja);
            try
              add_pick(dm.ds_1.FieldByName('id_pedido').AsInteger, dm.ds_1.FieldByName('codalbaran').AsInteger, id_pickcab, id_packcab, 137, 'ES',line_pick,line_pack);
            except on e:Exception do
               errores_pick.Add('Lgs ' + e.Message);
            end;
            dm.ds_1.next;
          end;

          lb_st1.Caption:='Quinta Pasada Loginser';
          Application.ProcessMessages;

          dm.ds_1.Close;                                                           //Sexta Pasada Dynamic
          dm.ds_1.SQLs.SelectSQL.Clear;
          dm.ds_1.SQLs.SelectSQL.Add('SELECT * from c_pedidos where estado=''G'' and id_repartidor=20 and id_cliente='+ edCliente.Text);

          if pedidos <> '' then
              dm.ds_1.SelectSQL.Add(' and id_pedido in (' + pedidos + ') ');

          if peds_1_elem <> '' then
              dm.ds_1.SelectSQL.Add(' and id_pedido not in (' + peds_1_elem + ') ');

          if peds_sin_alb <> '' then
              dm.ds_1.SelectSQL.Add(' and id_pedido not in (' + peds_sin_alb + ') ');

          dm.ds_1.Open;
          dm.ds_1.First;

          cuenta_caja := 0;

          while not(dm.ds_1.Eof) do begin
            Inc(cuenta_caja);
            try
              add_pick(dm.ds_1.FieldByName('id_pedido').AsInteger, dm.ds_1.FieldByName('codalbaran').AsInteger, id_pickcab, id_packcab, 139, 'ES',line_pick,line_pack);
            except on e:Exception do
               errores_pick.Add('Dynamic ' + e.Message);
            end;
            dm.ds_1.next;
          end;
          }
    end;

    agrupa_picking_x_cajas(id_pickcab, id_packcab);

    for i := 121 to 150 do
    begin
      calcula_agrupa(id_pickcab, id_packcab, i);
    end;

    lb_st1.Caption := 'Proceso Finalizado...';
    application.ProcessMessages;

    dm.t_write.Commit;
  except
    on e: Exception do
    begin
      todo_ok := false;
      dm.t_write.Rollback;
    end;
  end;

  if todo_ok then
  begin
    try
      dm.t_write.StartTransaction;

      lb_st1.Caption := 'Asignando Cajas...';
      Application.ProcessMessages;

      asigna_cajas(id_packcab);

      dm.t_write.Commit;
    except
      dm.t_write.Rollback;
    end;

    try
      dm.t_write.StartTransaction;

      lb_st1.Caption := 'Agrupando Pedidos Por Cajas...';
      Application.ProcessMessages;

      agrupa_cajas(id_pickcab, id_packcab, 121);
      agrupa_cajas(id_pickcab, id_packcab, 132);
      agrupa_cajas(id_pickcab, id_packcab, 133);
      agrupa_cajas(id_pickcab, id_packcab, 134);
      agrupa_cajas(id_pickcab, id_packcab, 135);

      lb_st1.Caption := 'Actualizando pick y pack en pedidos...';
      dm.q_1.Close;
      dm.q_1.SQL.Clear;
      dm.q_1.SQL.Add('update c_pedidos set picking=:id_pick, pack_ab=:id_pack ' + 'where id_pedido in (' + pedidos + ')');
      dm.q_1.ParamByName('id_pick').AsInteger := id_pickcab;
      dm.q_1.ParamByName('id_pack').AsInteger := id_packcab;
      dm.q_1.ExecQuery;

      dm.t_write.Commit;
    except
      dm.t_write.Rollback;
    end;
  end;

  InsertaLog(u_main.usuario.id,id_pickcab,0,PC.Nombre,PC.IP,log_app,'picking','','FinGenPickAb ' + IntToStr(main_cli),'Peds.' + pedidos+'-'+peds_sin_alb);

  result := todo_ok;


end;

procedure Tf_main.calcula_agrupa(new_pick_cab, new_pack_cab, id_agrupa: integer);
var
  nivel_agr, cajas_x_nivel, n_cajas: integer;
begin
  //*****************************************************AGRUPA CAJAS POR NIVEL_AGR
  lb_st1.Caption := 'Niveles de Agrupación de Cajas ' + inttostr(id_agrupa);
  application.ProcessMessages;

  if (id_agrupa = 123) or (id_agrupa = 137) then
  begin                //VLC  ordenada por ruta
    dm.q_fib.Close;
    dm.q_fib.SelectSQL.Clear;
    dm.q_fib.SelectSQL.Add('select l.codalbaran,l.id_ruta,b.tipo_Caja,l.id_packlin_bulto ' +
                           'from a_packlin l ' +
                           'inner join a_packlin_bulto b on (l.id_packlin_bulto=b.id_packlin_bulto) ' +
                           'where l.id_packcab=:id_packcab and l.id_agrupa=:id_agrupa ' +
                           'group by 1,2,3,4 ' +
                           'order by l.id_ruta,b.tipo_caja,l.codalbaran');
    dm.q_fib.ParamByName('id_packcab').AsInteger := new_pack_cab;
    dm.q_fib.ParamByName('id_agrupa').AsInteger := id_agrupa;
    dm.q_fib.open;
    dm.q_fib.first;

    n_cajas := ncajas_x;
    nivel_agr := 1;
    cajas_x_nivel := 0;

    try
      dm.t_write.StartTransaction;

      while not (dm.q_fib.Eof) do
      begin
        if (cajas_x_nivel >= n_cajas) then
        begin
          Inc(nivel_agr);
          cajas_x_nivel := 1;
        end
        else
          inc(cajas_x_nivel);

        act_albs(new_pick_cab, new_pack_cab, id_agrupa, nivel_agr, dm.q_fib.FieldByName('codalbaran').AsInteger, cajas_x_nivel, dm.q_fib.FieldByName('id_packlin_bulto').AsInteger);

        dm.q_fib.Next;
      end;

      dm.t_write.CommitRetaining;
    except
      dm.t_write.Rollback;
    end;
  end
  else
  begin                                                    //LAS DEMAS ORDENADAS POR TAMAÑO DE CAJA
    dm.q_fib.Close;
    dm.q_fib.SelectSQL.Clear;
    dm.q_fib.SelectSQL.Add('select l.codalbaran,b.tipo_Caja,l.id_packlin_bulto ' +
                           'from a_packlin l ' +
                           'inner join a_packlin_bulto b on (l.id_packlin_bulto=b.id_packlin_bulto) ' +
                           'where l.id_packcab=:id_packcab and l.id_agrupa=:id_agrupa and b.id_caja=1 ' +
                           'group by 1,2,3 ' +
                           'order by b.tipo_caja,l.codalbaran');
    dm.q_fib.ParamByName('id_packcab').AsInteger := new_pack_cab;
    dm.q_fib.ParamByName('id_agrupa').AsInteger := id_agrupa;
    dm.q_fib.open;
    dm.q_fib.first;

    n_cajas := 9999;
    if dm.q_fib.FieldByName('tipo_caja').AsString = 'A' then
      n_cajas := ncajas_a;
    if dm.q_fib.FieldByName('tipo_caja').AsString = 'B' then
      n_cajas := ncajas_b;
    if dm.q_fib.FieldByName('tipo_caja').AsString = 'C' then
      n_cajas := ncajas_c;
    if dm.q_fib.FieldByName('tipo_caja').AsString = 'D' then
      n_cajas := ncajas_d;
    if dm.q_fib.FieldByName('tipo_caja').AsString = 'E' then
      n_cajas := ncajas_e;

    if cjs_x_agr > 0 then
      n_cajas := cjs_x_agr;

    nivel_agr := 1;
    cajas_x_nivel := 0;

    try
      dm.t_write.StartTransaction;

      while not (dm.q_fib.Eof) do
      begin
        if (cajas_x_nivel >= n_cajas) then
        begin
          Inc(nivel_agr);
          cajas_x_nivel := 1;
          if dm.q_fib.FieldByName('tipo_caja').AsString = 'A' then
            n_cajas := ncajas_a;
          if dm.q_fib.FieldByName('tipo_caja').AsString = 'B' then
            n_cajas := ncajas_b;
          if dm.q_fib.FieldByName('tipo_caja').AsString = 'C' then
            n_cajas := ncajas_c;
          if dm.q_fib.FieldByName('tipo_caja').AsString = 'D' then
            n_cajas := ncajas_d;
          if dm.q_fib.FieldByName('tipo_caja').AsString = 'E' then
            n_cajas := ncajas_e;
          if cjs_x_agr > 0 then
            n_cajas := cjs_x_agr;
        end
        else
          inc(cajas_x_nivel);

        act_albs(new_pick_cab, new_pack_cab, id_agrupa, nivel_agr, dm.q_fib.FieldByName('codalbaran').AsInteger, cajas_x_nivel, dm.q_fib.FieldByName('id_packlin_bulto').AsInteger);

        dm.q_fib.Next;
      end;

      dm.t_write.CommitRetaining;
    except
      dm.t_write.Rollback;
    end;
  end;
end;

procedure Tf_main.agrupa_picking_x_cajas(new_pick_cab, new_pack_cab: integer);
var
  tipo_caja: string;
  cubic: integer;
begin
  //*****************************************************GENERAR TIPO DE CAJA INICIAL
  lb_st1.Caption := 'Generando Tipos de Caja Iniciales para Albaranes';
  application.ProcessMessages;

  dm.q_fib.Close;
  dm.q_fib.SelectSQL.Clear;
  dm.q_fib.SelectSQL.Add('select l.codalbaran,sum(a.cubic) as cubic ' + 'from a_packlin l ' + 'inner join g_articulos a on (l.id_articulo=a.id_articulo) ' + 'where l.id_packcab=:id_packcab and l.id_agrupa!=120 and a.is_bulto=''N'' ' + 'group by 1');
  dm.q_fib.ParamByName('id_packcab').AsInteger := new_pack_cab;
  dm.q_fib.open;

  try
    dm.t_write.StartTransaction;
    dm.q_fib.First;
    while not (dm.q_fib.Eof) do
    begin
      tipo_caja := 'A';
      cubic := dm.q_fib.fieldbyname('cubic').asinteger;

      if (cubic <= cubic_b) then
        tipo_caja := 'B';
      if (cubic <= cubic_c) then
        tipo_caja := 'C';
      if (cubic <= cubic_d) then
        tipo_caja := 'D';
      if (cubic <= cubic_e) then
        tipo_caja := 'E';

      dm.qu_1.Close;
      dm.qu_1.SQL.Clear;
      dm.qu_1.SQL.Add('update a_packlin_bulto set tipo_caja=:tipo_caja where codalbaran=:codalbaran and id_caja=1');
      dm.qu_1.ParamByName('codalbaran').AsInteger := dm.q_fib.FieldByName('codalbaran').AsInteger;
      dm.qu_1.ParamByName('tipo_caja').AsString := tipo_caja;
      dm.qu_1.ExecQuery;

      dm.q_fib.Next;
    end;
    dm.t_write.CommitRetaining;
  except
    dm.t_write.rollback;
  end;
end;

procedure Tf_main.add_pick(id_pedido, id_order, id_pickcab, id_packcab, id_agrupa: Integer; id_pais: string; var line_pick, line_pack: integer);
var
  nivel_agr, id_bulto, paquetes, id_art, uds_curr, uds_tot, uds, id_lote_aux, ruta, repartidor: integer;
  order_name, lotes_no_usar: string;
begin
  try

    lotes_no_usar := '';
    nivel_agr := 0;

    dm.ds_2.Close;                                                   //GENERA BULTO DE PACKING
    dm.ds_2.selectSQL.Clear;
    dm.ds_2.selectSQL.Add('SELECT GEN_ID(gen_a_packlin_bulto_id,1) FROM RDB$DATABASE');
    dm.ds_2.Open;

    id_bulto := dm.ds_2.FieldByName('gen_id').AsInteger;

    dm.ds_2.close;                                                 //total picking
    dm.ds_2.SelectSQL.clear;
    dm.ds_2.SelectSQL.Add('select sum(l.cantidad) as total ' +
                          'from c_pedidos_lines l ' +
                          'where id_pedido=:id_pedido');
    dm.ds_2.ParamByName('id_pedido').AsInteger := id_pedido;
    dm.ds_2.Open;
    paquetes := dm.ds_2.FieldByName('total').AsInteger;

    dm.ds_2.close;                                                 //datos de cabecera
    dm.ds_2.SelectSQL.clear;
    dm.ds_2.SelectSQL.Add('select * ' + 'from c_pedidos l ' + 'where id_pedido=:id_pedido');
    dm.ds_2.ParamByName('id_pedido').AsInteger := id_pedido;
    dm.ds_2.Open;

    order_name := dm.ds_2.FieldByName('order_name').AsString;

    ruta := StrToInt(get_albaran_data('zona', id_order));
    repartidor := StrToInt(get_albaran_data('repartidor', id_order));

    dm.q_1.Close;
    dm.q_1.SQL.Clear;
    dm.q_1.SQL.Add('insert into a_packlin_bulto (id_packlin_bulto,codalbaran,tipo_caja,id_caja,PAQUETES,BULTOS,KGS,KGS_VOL,FECHA_ALB,CODCLI,ORG_CODCLI, ' + 'ORG_CODDEL,ORG_NOMBRE,ORG_CALLE,ORG_CP,ORG_LOCALIDAD,ORG_PROVINCIA,ORG_PERSONA,ORG_TFNO,DST_CODCLI,DST_CODDEL,DST_NOMBRE,DST_CALLE,DST_CP,DST_LOCALIDAD, ' + 'DST_PROVINCIA,DST_PERSONA,DST_TFNO,DST_EMAIL,REEMBOLSO,PDEBIDO,COD_RUTA,COD_REPARTIDOR,OBSERVACIONES,N_BULTO,N_BULTO_CHRONO) ' +
      '   values (:id_packlin_bulto,:codalbaran,:tipo_caja,:id_caja,:PAQUETES,:BULTOS,:KGS,:KGS_VOL,:FECHA_ALB,:CODCLI,:ORG_CODCLI, ' + ':ORG_CODDEL,:ORG_NOMBRE,:ORG_CALLE,:ORG_CP,:ORG_LOCALIDAD,:ORG_PROVINCIA,:ORG_PERSONA,:ORG_TFNO,:DST_CODCLI,:DST_CODDEL,:DST_NOMBRE,:DST_CALLE,:DST_CP,:DST_LOCALIDAD, ' + ':DST_PROVINCIA,:DST_PERSONA,:DST_TFNO,:DST_EMAIL,:REEMBOLSO,:PDEBIDO,:COD_RUTA,:COD_REPARTIDOR,:OBSERVACIONES,:N_BULTO,:N_BULTO_CHRONO)');
    dm.q_1.ParamByName('id_packlin_bulto').AsInteger := id_bulto;
    dm.q_1.ParamByName('codalbaran').AsInteger := id_order;
    dm.q_1.ParamByName('tipo_caja').AsString := 'D';
    dm.q_1.ParamByName('id_caja').Asinteger := 1;  //cuenta_caja;
    dm.q_1.ParamByName('paquetes').Asinteger := paquetes;
    dm.q_1.ParamByName('BULTOS').Asinteger := 1;
    dm.q_1.ParamByName('KGS').asfloat := 0;                                                  //TODO
    dm.q_1.ParamByName('KGS_VOL').asfloat := 0;                                              //TODO
    dm.q_1.ParamByName('FECHA_ALB').asdatetime := now;
    dm.q_1.ParamByName('CODCLI').Asinteger := StrToInt(edCliente.Text);
    dm.q_1.ParamByName('ORG_CODCLI').Asinteger := StrToInt(edCliente.Text);
    dm.q_1.ParamByName('ORG_CODDEL').Asinteger := 1;
    dm.q_1.ParamByName('ORG_NOMBRE').asstring := 'LOGINSER';
    dm.q_1.ParamByName('ORG_CALLE').asstring := 'C/PONIENTE 10';
    dm.q_1.ParamByName('ORG_CP').asstring := '46394';
    dm.q_1.ParamByName('ORG_LOCALIDAD').asstring := 'RIBARROJA DEL TURIA';
    dm.q_1.ParamByName('ORG_PROVINCIA').asstring := 'VALENCIA';
    dm.q_1.ParamByName('ORG_PERSONA').asstring := '';
    dm.q_1.ParamByName('ORG_TFNO').asstring := '902108957';
    dm.q_1.ParamByName('DST_CODCLI').Asinteger := StrToInt(edCliente.Text);
    dm.q_1.ParamByName('DST_CODDEL').Asinteger := 9999;

    if dm.ds_2.FieldByName('company').AsString = '' then
      dm.q_1.ParamByName('DST_NOMBRE').asstring := dm.ds_2.FieldByName('nombre').asstring
    else
      dm.q_1.ParamByName('DST_NOMBRE').asstring := dm.ds_2.FieldByName('company').AsString + '-' + dm.ds_2.FieldByName('nombre').asstring;

    dm.q_1.ParamByName('DST_CALLE').asstring := dm.ds_2.fieldbyname('dir_1').asstring;
    dm.q_1.ParamByName('DST_CP').asstring := dm.ds_2.FieldByName('CP').asstring;
    dm.q_1.ParamByName('DST_LOCALIDAD').asstring := dm.ds_2.FieldByName('poblacion').asstring;
    dm.q_1.ParamByName('DST_PROVINCIA').asstring := dm.ds_2.FieldByName('provincia').asstring;
    dm.q_1.ParamByName('DST_PERSONA').asstring := '';
    dm.q_1.ParamByName('DST_TFNO').asstring := dm.ds_2.FieldByName('telefono').asstring;
    dm.q_1.ParamByName('DST_EMAIL').asstring := dm.ds_2.FieldByName('email').asstring;
    dm.q_1.ParamByName('REEMBOLSO').asfloat := dm.ds_2.FieldByName('REEMBOLSO').asfloat;
    dm.q_1.ParamByName('PDEBIDO').asfloat := 0;
    dm.q_1.ParamByName('COD_RUTA').Asinteger := ruta;
    dm.q_1.ParamByName('COD_REPARTIDOR').Asinteger := repartidor;
    dm.q_1.ParamByName('N_BULTO_CHRONO').asstring := '';
    dm.q_1.ParamByName('OBSERVACIONES').asstring := dm.ds_2.FieldByName('OBSERVACIONES').asstring;
    dm.q_1.ParamByName('N_BULTO').Asinteger := 1;

    dm.q_1.ExecQuery;

    dm.t_write.CommitRetaining;

    dm.ds_2.close;                                                 //recoge picking
    dm.ds_2.SelectSQL.clear;
    dm.ds_2.SelectSQL.Add('select l.id_pedido,l.id_line,l.id_articulo,l.sku,l.nombre_art,l.cantidad, l.id_lote ' +
                          'from c_pedidos_lines l ' +
                          'where id_pedido=:id_pedido ' +
                          'order by id_lote desc');
    dm.ds_2.ParamByName('id_pedido').AsInteger := id_pedido;
    dm.ds_2.Open;

    dm.ds_2.First;
    while not (dm.ds_2.Eof) do
    begin
      if StrToInt(cl_padres[0])<0 then
          id_art := dm.ds_2.FieldByName('id_articulo').AsInteger
      else
          //id_art := busca_art(get_codcli_art(dm.ds_2.FieldByName('id_articulo').asinteger),cl_padre);
          id_art := busca_articulo_heredado(dm.ds_2.FieldByName('id_articulo').asinteger);

      uds_curr := 0;
      uds_tot := dm.ds_2.FieldByName('cantidad').AsInteger;

      dm.ds_3.Close;
      dm.ds_3.SelectSQL.Clear;
      {dm.ds_3.SelectSQL.Add(
          ' select 1 as orden,u.id_ubicacion,u.id_estanteria,u.id_posicion,u.id_altura,s.id_lote,l.caducidad '+
          ' from a_stock s '+
          '   inner join a_ubicaciones u on (s.id_ubicacion=u.id_ubicacion) '+
          '   inner join a_lotes l on (s.id_lote=l.id_lote) '+
          ' where s.id_articulo=:id_articulo and s.cantidad>0 and u.id_zona=0 and s.id_ubicacion<>361 and s.id_empresa=1 '+
          '   and s.id_almacen=:id_almacen '+
          ' order by 1,5,3,4,7 ');   }

      dm.ds_3.SelectSQL.Add('select * from ubics_con_stock where id_articulo=:id_articulo and id_almacen=:id_almacen ');

      if dm.ds_2.FieldByName('id_lote').AsInteger>1 then
          dm.ds_3.SelectSQL.Add('and lote=:id_lote ')
      else begin

      end;

      dm.ds_3.SelectSQL.Add('order by caducidad, id_altura');

      dm.ds_3.ParamByName('id_articulo').AsInteger := id_art;
      dm.ds_3.ParamByName('id_almacen').AsInteger := id_almacen;
      dm.ds_3.Open;
      dm.ds_3.First;


      while ((uds_curr < uds_tot) and not (dm.ds_3.eof)) do
      begin

        if dm.ds_2.FieldByName('id_lote').AsInteger>1 then
              id_lote_aux := dm.ds_2.FieldByName('id_lote').AsInteger
        else
              id_lote_aux := 1;

        uds := get_art_from_pick(id_art, dm.ds_3.FieldByName('id_ubicacion').AsInteger, uds_tot - uds_curr, id_lote_aux);

        if id_lote_aux = 0 then
          id_lote_aux := 1;

        if uds > 0 then
        begin
          uds_curr := uds_curr + uds;

          dm.q_1.Close;                                                    //GENERA PICKING
          dm.q_1.SQL.Clear;
          dm.q_1.SQL.Add('insert into a_picklin (ID_PICKCAB,ID_AGRUPA,NIVEL_AGR,LINEA,ID_RUTA,ID_ARTICULO,ID_UBICACION,CANTIDAD,ID_EMPRESA,ESTADO,CODALBARAN,CODMOVIMIENTO,SULINEA,ID_LOTE) ' + ' values (:ID_PICKCAB,:ID_AGRUPA,:NIVEL_AGR,:LINEA,:ID_RUTA,:ID_ARTICULO,:ID_UBICACION,:CANTIDAD,:ID_EMPRESA,:ESTADO,:CODALBARAN,:CODMOVIMIENTO,:SULINEA,:ID_LOTE)');
          dm.q_1.ParamByName('id_pickcab').AsInteger := id_pickcab;
          dm.q_1.ParamByName('id_agrupa').AsInteger := id_agrupa;
          dm.q_1.ParamByName('nivel_agr').AsInteger := nivel_agr;
          dm.q_1.ParamByName('linea').AsInteger := line_pick;
          dm.q_1.ParamByName('id_ruta').AsInteger := ruta;
          dm.q_1.ParamByName('id_articulo').AsInteger := id_art;
          dm.q_1.ParamByName('id_ubicacion').AsInteger := dm.ds_3.FieldByName('id_ubicacion').AsInteger;
          dm.q_1.ParamByName('cantidad').AsInteger := uds;
          dm.q_1.ParamByName('id_empresa').AsInteger := 1;
          dm.q_1.ParamByName('estado').asstring := 'A';
          dm.q_1.ParamByName('codalbaran').AsInteger := id_order;
          dm.q_1.ParamByName('codmovimiento').AsInteger := 0;
          dm.q_1.ParamByName('sulinea').AsString := IntToStr(id_order);
          //dm.q_1.parambyname('id_lote').asinteger:=dm.ds_3.FieldByName('id_lote').AsInteger;
          dm.q_1.parambyname('id_lote').asinteger := id_lote_aux;
          dm.q_1.ExecQuery;

          if StrToInt(cl_padres[0])<0 then
            InsertaLog(u_main.usuario.id,id_pickcab,0,PC.Nombre,PC.IP,log_app,'picking','','InsLinPickAb Ped.' + IntToStr(id_pedido),
             'Art.' + IntToStr(id_art) + ' Uds.'+ IntToStr(uds) + ' Alb.' + IntToStr(id_order) +  ' Agr.' + IntToStr(id_agrupa) + 'Ln.'+ IntToStr(line_pick))
          else
            InsertaLog(u_main.usuario.id,id_pickcab,0,PC.Nombre,PC.IP,log_app,'picking','','InsLinPickAbPadre Ped.' + IntToStr(id_pedido),
             'Art.' + IntToStr(id_art) + ' Uds.'+ IntToStr(uds) + ' Alb.' + IntToStr(id_order) +  ' Agr.' + IntToStr(id_agrupa) + 'Ln.'+ IntToStr(line_pick));

          dm.q_1.Close;                                                    //GENERA PACKING
          dm.q_1.SQL.Clear;
          dm.q_1.SQL.Add('insert into a_packlin (ID_PACKCAB,ID_AGRUPA,NIVEL_AGR,LINEA,ID_RUTA,ID_ARTICULO,CANTIDAD,ID_EMPRESA,ESTADO,CODALBARAN,CODMOVIMIENTO,CODREPARTIDOR,ID_PACKLIN_BULTO,SULINEA,ATT,N_PARCIAL,ID_LOTE, ID_PAIS) ' + ' values (:ID_PACKCAB,:ID_AGRUPA,:NIVEL_AGR,:LINEA,:ID_RUTA,:ID_ARTICULO,:CANTIDAD,:ID_EMPRESA,:ESTADO,:CODALBARAN,:CODMOVIMIENTO,:CODREPARTIDOR,:ID_PACKLIN_BULTO,:SULINEA,:ATT,:N_PARCIAL,:ID_LOTE,:ID_PAIS)');
          dm.q_1.ParamByName('id_packcab').AsInteger := id_packcab;
          dm.q_1.ParamByName('id_agrupa').AsInteger := id_agrupa;
          dm.q_1.ParamByName('nivel_agr').AsInteger := nivel_agr;
          dm.q_1.ParamByName('linea').AsInteger := line_pack;
          dm.q_1.ParamByName('id_ruta').AsInteger := ruta;
          dm.q_1.ParamByName('id_articulo').AsInteger := id_art;
          dm.q_1.ParamByName('cantidad').AsInteger := uds;
          dm.q_1.ParamByName('id_empresa').AsInteger := 1;
          dm.q_1.ParamByName('estado').asstring := 'A';
          dm.q_1.ParamByName('codalbaran').AsInteger := id_order;
          dm.q_1.ParamByName('codmovimiento').AsInteger := 0;
          dm.q_1.ParamByName('codrepartidor').AsInteger := repartidor;
          dm.q_1.ParamByName('ID_PACKLIN_BULTO').asinteger := id_bulto;
          dm.q_1.ParamByName('sulinea').AsString := order_name;
          dm.q_1.ParamByName('att').AsString := '';
          dm.q_1.ParamByName('n_parcial').AsInteger := line_pack;
          //dm.q_1.parambyname('id_lote').asinteger:=dm.ds_3.FieldByName('id_lote').AsInteger;
          dm.q_1.parambyname('id_lote').asinteger := id_lote_aux;
          dm.q_1.parambyname('id_pais').asstring := id_pais;
          dm.q_1.ExecQuery;

          If StrToInt(cl_padres[0])<0 then
            InsertaLog(u_main.usuario.id,id_pickcab,0,PC.Nombre,PC.IP,log_app,'picking','','InsLinPackAb Ped.' + IntToStr(id_pedido),
             'Art.' + IntToStr(id_art) + ' Uds.'+ IntToStr(uds) + ' Alb.' + IntToStr(id_order) +  ' Agr.' + IntToStr(id_agrupa) + 'Ln.'+ IntToStr(line_pack))
          else
            InsertaLog(u_main.usuario.id,id_pickcab,0,PC.Nombre,PC.IP,log_app,'picking','','InsLinPickAbPadre Ped.' + IntToStr(id_pedido),
             'Art.' + IntToStr(id_art) + ' Uds.'+ IntToStr(uds) + ' Alb.' + IntToStr(id_order) +  ' Agr.' + IntToStr(id_agrupa) + 'Ln.'+ IntToStr(line_pick));

         { if tiene_lotes then
            update_lote(dm.ds_2.FieldByName('id_pedido').AsInteger, dm.ds_2.FieldByName('id_articulo').AsInteger,
            id_pickcab, line_pick, id_lote_aux, uds); }

          Inc(line_pick);
          Inc(line_pack);
        end;
        dm.ds_3.Next;
      end;

      dm.ds_2.Next;
    end   ;
  except
    on e: Exception do
      raise Exception.Create(e.Message);
  end;

end;

procedure Tf_main.asigna_cajas(id_packcab: Integer);
var
  cubic_a, cubic_b, cubic_c, cubic_d, cubic: Integer;
  tipo_caja: string;
begin
  dm.ds_1.Close;
  dm.ds_1.SelectSQL.Clear;
  dm.ds_1.SelectSQL.Add('select * ' +
                        'from a_cajas ' +
                        'where id_cliente=6702 ' +
                        'order by tipo');
  dm.ds_1.Open;

  cubic_a := dm.ds_1.FieldByName('cubic').AsInteger;            //TODO Find a better way to do this
  dm.ds_1.Next;
  cubic_b := dm.ds_1.FieldByName('cubic').AsInteger;
  dm.ds_1.Next;
  cubic_c := dm.ds_1.FieldByName('cubic').AsInteger;
  dm.ds_1.Next;
  cubic_d := dm.ds_1.FieldByName('cubic').AsInteger;

  dm.ds_1.Close;
  dm.ds_1.SelectSQL.Clear;
  dm.ds_1.SelectSQL.Add('select l.codalbaran,sum(a.cubic*l.cantidad) as cubic ' +
                        'from a_packlin l ' +
                        'inner join g_articulos a on (l.id_articulo=a.id_articulo) ' +
                        'where l.id_packcab=:id_packcab ' +
                        'group by 1');
  dm.ds_1.ParamByName('id_packcab').AsInteger := id_packcab;
  dm.ds_1.Open;

  dm.ds_1.First;

  while not (dm.ds_1.Eof) do
  begin
    tipo_caja := 'A';     //caja A
    cubic := dm.ds_1.FieldByName('cubic').AsInteger;

    if (cubic <= cubic_b) then
      tipo_caja := 'B';   //caja B
    if (cubic <= cubic_c) then
      tipo_caja := 'C';   //caja C
    if (cubic <= cubic_d) then
      tipo_caja := 'D';   //caja D

    dm.q_1.Close;
    dm.q_1.SQL.Clear;
    dm.q_1.SQL.Add('update a_packlin_bulto set tipo_caja=:tipo_caja where codalbaran=:codalbaran and id_caja=1');
    dm.q_1.ParamByName('codalbaran').AsInteger := dm.ds_1.FieldByName('codalbaran').AsInteger;
    dm.q_1.ParamByName('tipo_caja').AsString := tipo_caja;
    dm.q_1.ExecQuery;

    dm.ds_1.Next;
  end;
end;

procedure Tf_main.agrupa_cajas(id_pickcab, id_packcab, id_agrupa: Integer);
var
  max_long, curr_long, long_a, long_b, long_c, long_d, nivel_agr, caja_x_nivel: integer;
begin
  dm.ds_1.Close;
  dm.ds_1.SelectSQL.Clear;
  dm.ds_1.SelectSQL.Add('select * ' + 'from a_cajas ' + 'where id_cliente=6702 ' +      //Se usan las medidas de las cajas de LIS para todos
    'order by tipo');
  dm.ds_1.Open;

  long_a := dm.ds_1.FieldByName('ancho').AsInteger;            //TODO Find a better way to do this
  dm.ds_1.Next;
  long_b := dm.ds_1.FieldByName('ancho').AsInteger;
  dm.ds_1.Next;
  long_c := dm.ds_1.FieldByName('ancho').AsInteger;
  dm.ds_1.Next;
  long_d := dm.ds_1.FieldByName('ancho').AsInteger;

  dm.ds_1.Close;
  dm.ds_1.SelectSQL.Clear;
  dm.ds_1.SelectSQL.Add('select l.codalbaran,b.tipo_Caja,l.id_packlin_bulto ' + 'from a_packlin l ' + 'inner join a_packlin_bulto b on (l.id_packlin_bulto=b.id_packlin_bulto) ' + 'where l.id_packcab=:id_packcab and l.id_agrupa=:id_agrupa and b.id_caja=1 ' + 'group by 1,2,3 ' + 'order by b.tipo_caja,l.codalbaran');
  dm.ds_1.ParamByName('id_packcab').AsInteger := id_packcab;
  dm.ds_1.ParamByName('id_agrupa').AsInteger := id_agrupa;
  dm.ds_1.open;

  max_long := 1761;
  curr_long := 0;
  nivel_agr := 0;
  caja_x_nivel := 0;
  dm.ds_1.first;

  while not (dm.ds_1.Eof) do
  begin
    if (curr_long >= max_long) then
    begin
      Inc(nivel_agr);
      curr_long := 0;
      caja_x_nivel := 0;
    end
    else
    begin
      if dm.ds_1.FieldByName('tipo_caja').AsString = 'A' then
        curr_long := curr_long + long_a;
      if dm.ds_1.FieldByName('tipo_caja').AsString = 'B' then
        curr_long := curr_long + long_b;
      if dm.ds_1.FieldByName('tipo_caja').AsString = 'C' then
        curr_long := curr_long + long_c;
      if dm.ds_1.FieldByName('tipo_caja').AsString = 'D' then
        curr_long := curr_long + long_d;
      Inc(caja_x_nivel);
    end;

    act_albs(id_pickcab, id_packcab, id_agrupa, nivel_agr, dm.ds_1.FieldByName('codalbaran').AsInteger, caja_x_nivel, dm.ds_1.FieldByName('id_packlin_bulto').AsInteger);

    dm.ds_1.Next;
  end;
end;

procedure Tf_main.act_albs(id_pickcab, id_packcab, id_agrupa, nivel_agr, cod_albaran, id_caja, id_packlin_bulto: integer);
begin
  dm.q_1.Close;
  dm.q_1.SQL.Clear;
  dm.q_1.SQL.Add('update a_packlin set nivel_agr=:nivel_agr where id_packcab=:id_packcab and id_agrupa=:id_agrupa and codalbaran=:codalbaran');
  dm.q_1.ParamByName('nivel_agr').AsInteger := nivel_agr;
  dm.q_1.ParamByName('id_packcab').AsInteger := id_packcab;
  dm.q_1.ParamByName('id_agrupa').AsInteger := id_agrupa;
  dm.q_1.ParamByName('codalbaran').AsInteger := cod_albaran;
  dm.q_1.ExecQuery;

  dm.q_1.Close;
  dm.q_1.SQL.Clear;
  dm.q_1.SQL.Add('update a_picklin set nivel_agr=:nivel_agr where id_pickcab=:id_pickcab and id_agrupa=:id_agrupa and codalbaran=:codalbaran');
  dm.q_1.ParamByName('nivel_agr').AsInteger := nivel_agr;
  dm.q_1.ParamByName('id_pickcab').AsInteger := id_pickcab;
  dm.q_1.ParamByName('id_agrupa').AsInteger := id_agrupa;
  dm.q_1.ParamByName('codalbaran').AsInteger := cod_albaran;
  dm.q_1.ExecQuery;

  dm.q_1.Close;
  dm.q_1.SQL.Clear;
  dm.q_1.SQL.Add('update a_packlin_bulto set id_caja=:id_caja where id_packlin_bulto=:id_packlin_bulto');
  dm.q_1.ParamByName('id_caja').AsInteger := id_caja;
  dm.q_1.ParamByName('id_packlin_bulto').AsInteger := id_packlin_bulto;
  dm.q_1.ExecQuery;
end;

procedure Tf_main.get_pick;
var
  i: Integer;
begin
  limpiar_pick;

 { qry := get_query(156);

  if qry = '' then
    qry := 'select u.id_articulo, id_ubicacion, lote, u.caducidad, iif((' +
           'select sum(p.cantidad) '+
           'from a_picklin p '+
           'inner join a_pickcab c on c.id_pickcab=p.id_pickcab '+
           'where p.situacion=:situacion and p.id_articulo=u.id_articulo and p.id_ubicacion=u.id_ubicacion and p.id_lote=u.lote and c.id_almacen=:almacen '+
           ')>0,uds-(select sum(p.cantidad) from a_picklin p inner join a_pickcab c on c.id_pickcab=p.id_pickcab ' +
           'where p.situacion=:situacion and p.id_articulo=u.id_articulo and p.id_ubicacion=u.id_ubicacion and p.id_lote=u.lote and c.id_almacen=:almacen '+
           '),uds) as uds ' +
           'from ubics_con_stock u inner join g_articulos ar on ar.id_articulo=u.id_articulo where id_almacen=:almacen and ar.id_cliente=:id_cliente ' +
           'and iif((select sum(p.cantidad) from a_picklin p inner join a_pickcab c on c.id_pickcab=p.id_pickcab ' +
           'where p.situacion=:situacion and p.id_articulo=u.id_articulo and p.id_ubicacion=u.id_ubicacion and p.id_lote=u.lote and c.id_almacen=:almacen '+
           ')>0,uds-(select sum(p.cantidad) from a_picklin p inner join a_pickcab c on c.id_pickcab=p.id_pickcab ' +
           'where p.situacion=:situacion and p.id_articulo=u.id_articulo and p.id_ubicacion=u.id_ubicacion and p.id_lote=u.lote and c.id_almacen=:almacen ' +
           '),uds)>0 order by u.caducidad, u.id_altura';  }

  with TpFIBDataSet.Create(self) do
  try
    Database := dm.db;

    {sqls.SelectSQL.Add('select s.id_articulo,s.id_ubicacion,s.id_lote,l.caducidad,sum(s.cantidad) as uds ' +
    'from a_stock s ' +
    'inner join g_articulos a on (s.id_articulo=a.id_articulo) ' +
    'inner join a_ubicaciones u on (s.id_ubicacion=u.id_ubicacion) ' +
    'inner join a_lotes l on (l.id_lote=s.id_lote) ' +
    'where a.id_cliente=:id_cliente and u.id_almacen=:almacen and u.id_zona=0 and u.id_ubicacion<>361 and s.cantidad>0 and s.id_departamento=0 ' +
    'group by s.id_articulo,s.id_ubicacion,s.id_lote,l.caducidad' +
    'order by l.caducidad, u.id_altura'); }

    //sqls.SelectSQL.Add(qry);

    sqls.SelectSQL.Add('select s.id_articulo,s.id_ubicacion,s.lote,s.caducidad, s.uds ' +
                       'from ubics_con_stock s ' +
                       'inner join g_articulos a on (s.id_articulo=a.id_articulo) ' +
                       'where a.id_cliente=:id_cliente and s.id_almacen=:almacen ' +
                       'order by s.caducidad, s.id_altura' );

    if StrToInt(cl_padres[0])<0 then
    begin
          ParamByName('id_cliente').AsInteger := StrToInt(edCliente.Text);
          ParamByName('almacen').AsInteger := id_almacen;
          //ParamByName('situacion').ASString := 'P';
          Open;

          first;
          while not (Eof) do
          begin
            Inc(idx_pick);
            setlength(ar_pick, idx_pick);

            ar_pick[idx_pick - 1].id_art := FieldByName('id_articulo').asinteger;
            ar_pick[idx_pick - 1].uds := FieldByName('uds').asinteger;
            ar_pick[idx_pick - 1].id_ubic := FieldByName('id_ubicacion').asinteger;
            ar_pick[idx_pick - 1].id_lote := FieldByName('lote').asinteger;     //id_lote
            ar_pick[idx_pick - 1].caducidad := FieldByName('caducidad').asdatetime;

            next;
          end;
    end
    else begin

          for i := 0 to High(cl_padres) do
          begin
             Close;
             ParamByName('id_cliente').AsInteger := StrToInt(cl_padres[i]);
             ParamByName('almacen').AsInteger := id_almacen;
             Open;

             first;
             while not (Eof) do
             begin
                Inc(idx_pick);
                setlength(ar_pick, idx_pick);

                ar_pick[idx_pick - 1].id_art := FieldByName('id_articulo').asinteger;
                ar_pick[idx_pick - 1].uds := FieldByName('uds').asinteger;
                ar_pick[idx_pick - 1].id_ubic := FieldByName('id_ubicacion').asinteger;
                ar_pick[idx_pick - 1].id_lote := FieldByName('lote').asinteger;     //id_lote
                ar_pick[idx_pick - 1].caducidad := FieldByName('caducidad').asdatetime;

                next;
             end;
          end;
    end;

  finally
    free;
  end;
end;

function Tf_main.get_art_from_pick(id_art, id_ubic, uds: Integer; var lote: integer): Integer;    //devuelve las uds que puede coger de esa ubicacion y actualiza las restantes
var
  enc: Boolean;
  i, curr_uds: integer;
begin
  enc := False;
  i := 0;
  curr_uds := 0;
  //lote := 1;
  while (not (enc) and (i < idx_pick)) do
  begin                                    //se encuentra
    if (((lote=1) and (ar_pick[i].id_art = id_art) and (ar_pick[i].id_ubic = id_ubic))
        or
        ((lote>1) and (ar_pick[i].id_art = id_art) and (ar_pick[i].id_ubic = id_ubic) and (ar_pick[i].id_lote = lote))) then
    begin
      if (ar_pick[i].uds > 0) then
      begin
        if (ar_pick[i].uds < uds) then
        begin
          curr_uds := ar_pick[i].uds;
          lote := ar_pick[i].id_lote;
          ar_pick[i].uds := 0;
          enc := True;
        end
        else
        begin
          curr_uds := uds;
          ar_pick[i].uds := ar_pick[i].uds - uds;
          lote := ar_pick[i].id_lote;
          enc := True;
        end;
      end;
    end;


    Inc(i);
  end;

  result := curr_uds;
end;

procedure Tf_main.limpiar_pick;
begin
  idx_pick := 0;
  setlength(ar_pick, idx_pick);
end;

procedure Tf_main.update_lote(id_pedido, id_articulo, id_picking, id_line, id_lote, uds: Integer);
begin
  dm.ds_4.Close;
  dm.ds_4.SelectSQL.Clear;
  dm.ds_4.SelectSQL.Add('select * from c_pedidos_lines_lotes ' + 'where id_pedido=:id_pedido and id_articulo=:id_articulo and id_lote=:id_lote and id_picking=:id_pick and linea_pick=:linea_pick');
  dm.ds_4.ParamByName('id_pedido').AsInteger := id_pedido;
  dm.ds_4.ParamByName('id_articulo').AsInteger := id_articulo;
  dm.ds_4.ParamByName('id_pick').AsInteger := id_picking;
  dm.ds_4.ParamByName('linea_pick').AsInteger := id_line;
  dm.ds_4.ParamByName('id_lote').AsInteger := id_lote;
  dm.ds_4.Open;
  if dm.ds_4.isempty then
  begin
    dm.q_1.Close;
    dm.q_1.SQL.Clear;
    dm.q_1.SQL.Add('insert into c_pedidos_lines_lotes (id_pedido, id_articulo, id_picking, linea_pick, id_lote, cantidad) ' + ' values (:id_pedido, :id_articulo, :id_pick, :id_line, :id_lote, :cantidad)');
    dm.q_1.ParamByName('id_pedido').AsInteger := id_pedido;
    dm.q_1.ParamByName('id_articulo').AsInteger := id_articulo;
    dm.q_1.ParamByName('id_pick').AsInteger := id_picking;
    dm.q_1.ParamByName('id_line').AsInteger := id_line;
    dm.q_1.ParamByName('id_lote').AsInteger := id_lote;
    dm.q_1.ParamByName('cantidad').AsInteger := uds;
    dm.q_1.ExecQuery;
  end
  else
  begin
    dm.q_1.Close;
    dm.q_1.SQL.Clear;
    dm.q_1.SQL.Add('update c_pedidos_lines_lotes set cantidad = cantidad + :cantidad ' + ' where id_pedido = :id_pedido and linea_pick = :id_line and id_lote = :id_lote and id_articulo=:id_articulo and id_picking=:id_pick');
    dm.q_1.ParamByName('id_pedido').AsInteger := id_pedido;
    dm.q_1.ParamByName('id_articulo').AsInteger := id_articulo;
    dm.q_1.ParamByName('id_pick').AsInteger := id_picking;
    dm.q_1.ParamByName('id_line').AsInteger := id_line;
    dm.q_1.ParamByName('id_lote').AsInteger := id_lote;
    dm.q_1.ParamByName('cantidad').AsInteger := uds;
    dm.q_1.ExecQuery;
  end;
end;


function Tf_main.crea_pick_anula_stock(id_pedido:integer;ar_lines:TStringList;out errores_pick: string): Boolean;
var
  pick_cab: integer;
  nom_pick: string;
  linea, i, j: Integer;
  ar_ubics, lin_pick: TStringList;
begin

  errores_pick := '';
  result := True;

  linea := 1;
  dm.t_write.StartTransaction;

  try
    dm.ds_2.close;                                                 //recoge picking
    dm.ds_2.SelectSQL.clear;

    result := (High(PedLines)>0);

    dm.ds_1.Close;                                                            //id cabecera
    dm.ds_1.SQLs.SelectSQL.Clear;
    dm.ds_1.SQLs.SelectSQL.Add('SELECT GEN_ID(gen_a_pickcab_id,1) FROM RDB$DATABASE');
    dm.ds_1.Open;

    pick_cab := dm.ds_1.FieldByName('gen_id').AsInteger;

    InsertaLog(usuario.id,pick_cab,0,PC.Nombre,PC.IP,log_app,'picking','','IniGenPickAnulaStock. ' + IntToStr(main_cli),'');

    dm.q_1.Close;                                                                   //genera cabecera
    dm.q_1.SQL.Clear;
    dm.q_1.SQL.Add('insert into a_pickcab (ID_PICKCAB,ID_DOC,ID_CLIENTE,NOMBRE,FECHA,HORA,ID_USUARIO,ID_EMPRESA,ESTADO,ID_ALMACEN) ' +
                   ' values (:ID_PICKCAB,:ID_DOC,:ID_CLIENTE,:NOMBRE,:FECHA,:HORA,:ID_USUARIO,:ID_EMPRESA,:ESTADO,:ID_ALMACEN)');
    dm.q_1.ParamByName('id_pickcab').AsInteger := pick_cab;
    dm.q_1.ParamByName('id_doc').AsInteger := 1;
    dm.q_1.ParamByName('id_cliente').AsInteger := main_cli;
    nom_pick := 'Pick Por Anulación Stock ' + Copy(lbCliente.Caption,0,50) + ' ' + IntToStr(main_cli) + '-' + formatdatetime('dd/mm/yy', date);
    dm.q_1.ParamByName('nombre').asstring := nom_pick;
    dm.q_1.ParamByName('fecha').asdate := date;
    dm.q_1.ParamByName('hora').astime := time;
    dm.q_1.ParamByName('id_usuario').AsInteger := usuario.id;
    dm.q_1.ParamByName('id_empresa').AsInteger := 1;
    dm.q_1.ParamByName('estado').asstring := 'A';
    dm.q_1.ParamByName('id_almacen').AsInteger := id_almacen;
    dm.q_1.ExecQuery;
    dm.t_write.CommitRetaining;

    InsertaLog(usuario.id,pick_cab,0,PC.Nombre,PC.IP,log_app,'picking','','InsertPickCab',nom_pick);

    ar_ubics := TStringList.Create;
    ar_ubics.Delimiter := '$';

    lin_pick := TStringList.Create;
    lin_pick.Delimiter := '|';
    //art|alm|ubic|cant|lote

    for i:= 0 to ar_lines.Count-1 do
    begin

      ar_ubics.DelimitedText := ar_lines[i];

      for j:= 0 to ar_ubics.Count-1 do
      begin
        lin_pick.DelimitedText := ar_ubics[j];

        if lin_pick.Count>0 then
        begin
            if StrToInt(lin_pick[1])=id_almacen then
            begin
              dm.q_1.Close;
              dm.q_1.SQL.Clear;
              dm.q_1.SQL.Add('insert into a_picklin (ID_PICKCAB,ID_AGRUPA,NIVEL_AGR,LINEA,ID_RUTA,ID_ARTICULO,ID_UBICACION,CANTIDAD,ID_EMPRESA,ESTADO,CODALBARAN,CODMOVIMIENTO,SULINEA, ID_LOTE, SITUACION) ' +
                             ' values (:ID_PICKCAB,:ID_AGRUPA,:NIVEL_AGR,:LINEA,:ID_RUTA,:ID_ARTICULO,:ID_UBICACION,:CANTIDAD,:ID_EMPRESA,:ESTADO,:CODALBARAN,:CODMOVIMIENTO,:SULINEA, :ID_LOTE, :SITUACION)');
              dm.q_1.ParamByName('id_pickcab').AsInteger := pick_cab;
              dm.q_1.ParamByName('id_agrupa').AsInteger := 0;
              dm.q_1.ParamByName('nivel_agr').AsInteger := 1;
              dm.q_1.ParamByName('linea').AsInteger := linea;
              Inc(linea);
              dm.q_1.ParamByName('id_ruta').AsInteger := 0;
              dm.q_1.ParamByName('id_articulo').AsInteger := StrToInt(lin_pick[0]);
              dm.q_1.ParamByName('id_ubicacion').AsInteger := StrToInt(lin_pick[2]);
              dm.q_1.ParamByName('cantidad').AsInteger := StrToInt(lin_pick[3]);
              dm.q_1.ParamByName('id_empresa').AsInteger := 1;
              dm.q_1.ParamByName('estado').asstring := 'A';
              dm.q_1.ParamByName('codalbaran').AsInteger := id_pedido;
              dm.q_1.ParamByName('codmovimiento').AsInteger := 0;
              dm.q_1.ParamByName('sulinea').AsString := '';
              dm.q_1.ParamByName('id_lote').AsInteger := StrToInt(lin_pick[4]);
              dm.q_1.ParamByName('situacion').asstring := 'A';
              dm.q_1.ExecQuery;
              dm.t_write.CommitRetaining;

              InsertaLog(usuario.id,pick_cab,0,PC.Nombre,PC.IP,log_app,'picking','','InsertPickLinPadre','Art.'+ lin_pick[0] + ' Uds.' + lin_pick[3] + ' Alb/Ped.'+ IntToStr(id_pedido));
            end;
        end;
      end;
    end;

    ar_ubics.Free;
    lin_pick.Free;

    lb_st1.Caption := 'Actualizando pick en pedidos...';
    dm.q_1.Close;
    dm.q_1.SQL.Clear;
    dm.q_1.SQL.Add('update c_pedidos set picking=:id_pick, estado=:estado where id_pedido=:id_pedido');
    dm.q_1.ParamByName('id_pick').AsInteger := pick_cab;
    dm.q_1.ParamByName('id_pedido').AsInteger := id_pedido;
    dm.q_1.ParamByName('estado').AsString := PedCab.estado;
    dm.q_1.ExecQuery;
    InsertaLog(usuario.id,pick_cab,0,PC.Nombre,PC.IP,log_app,'picking','','UpdatePick ' + IntToStr(pick_cab) + ' EnPedido ' + IntToStr(id_pedido),'');

    dm.t_write.Commit;

    lb_st1.Caption := 'Picking Generado ' + inttostr(pick_cab);
    application.ProcessMessages;

  except
    on E: exception do
    begin
      errores_pick := errores_pick + ('Error creando picking ' + IntToStr(pick_cab) + ': ' + E.Message);
      dm.t_write.Rollback;
      result := False;
    end;
  end;
      InsertaLog(u_main.usuario.id,pick_cab,0,PC.Nombre,PC.IP,log_app,'picking','','FinGenPick','Ped.' + IntToStr(id_pedido));
end;
{$ENDREGION}

{$REGION 'Bultos'}

procedure Tf_main.imprime_bultos;
var
  tracking: string;
begin
  dm.ds_1.close;                                                 //recoge pedidos de lgs
  dm.ds_1.SelectSQL.clear;
  dm.ds_1.SelectSQL.Add('select * ' + 'from c_pedidos ' + 'where estado=''P'' and id_repartidor=0 and id_cliente=:id_cliente');
  dm.ds_1.ParamByName('id_cliente').AsInteger := StrToInt(edCliente.Text);
  dm.ds_1.Open;

  dm.ds_1.First;
  while not (dm.ds_1.Eof) do
  begin
    imprime_eti_bulto_lgs(dm.ds_1.FieldByName('codalbaran').AsInteger);

    dm.t_write.StartTransaction;
    try
      dm.q_1.Close;
      dm.q_1.sql.Clear;
      dm.q_1.sql.Add('update c_pedidos set tracking_number=:tracking where id_pedido=:id_pedido');
      dm.q_1.ParamByName('tracking').asstring := dm.ds_1.FieldByName('codalbaran').Asstring;
      dm.q_1.ParamByName('id_pedido').asinteger := dm.ds_1.fieldbyname('id_pedido').AsInteger;
      dm.q_1.ExecQuery;
      dm.t_write.Commit;
    except
      dm.t_write.rollback;
    end;

    dm.ds_1.Next;
  end;

  dm.ds_1.close;                                                 //recoge pedidos de asm
  dm.ds_1.SelectSQL.clear;
  dm.ds_1.SelectSQL.Add('select * ' + 'from c_pedidos ' + 'where estado=''P'' and id_repartidor=1 and id_cliente=:id_cliente');
  dm.ds_1.ParamByName('id_cliente').AsInteger := StrToInt(edCliente.Text);
  dm.ds_1.Open;

  dm.ds_1.First;
  while not (dm.ds_1.Eof) do
  begin
    tracking := imprime_eti_bulto_asm(dm.ds_1.FieldByName('codalbaran').AsInteger, dm.ds_1.FieldByName('delivery_time').AsInteger);

    dm.t_write.StartTransaction;
    try
      dm.q_1.Close;
      dm.q_1.sql.Clear;
      dm.q_1.sql.Add('update c_pedidos set tracking_number=:tracking where id_pedido=:id_pedido');
      dm.q_1.ParamByName('tracking').asstring := tracking;
      dm.q_1.ParamByName('id_pedido').asinteger := dm.ds_1.fieldbyname('id_pedido').AsInteger;
      dm.q_1.ExecQuery;
      dm.t_write.Commit;
    except
      dm.t_write.rollback;
    end;

    dm.ds_1.Next;
  end;

  dm.ds_1.close;                                                 //recoge pedidos de correos
  dm.ds_1.SelectSQL.clear;
  dm.ds_1.SelectSQL.Add('select * ' + 'from c_pedidos ' + 'where estado=''P'' and id_repartidor=2 and id_cliente=:id_cliente');
  dm.ds_1.FieldByName('id_cliente').AsInteger := StrToInt(edCliente.Text);
  dm.ds_1.Open;

  dm.ds_1.First;
  while not (dm.ds_1.Eof) do
  begin
    tracking := imprime_eti_bulto_correos(dm.ds_1.FieldByName('codalbaran').AsInteger);

    dm.t_write.StartTransaction;
    try
      dm.q_1.Close;
      dm.q_1.sql.Clear;
      dm.q_1.sql.Add('update c_pedidos set tracking_number=:tracking where id_pedido=:id_pedido');
      dm.q_1.ParamByName('tracking').asstring := tracking;
      dm.q_1.ParamByName('id_pedido').asinteger := dm.ds_1.fieldbyname('id_pedido').AsInteger;
      dm.q_1.ExecQuery;
      dm.t_write.Commit;
    except
      dm.t_write.rollback;
    end;

    dm.ds_1.Next;
  end;
end;

procedure Tf_main.imprime_eti_bulto_lgs(codalbaran: integer);
const
  cr = Chr(13);
  lr = Chr(10);
var
  codrepartidor, dst_coddel, bulto: Integer;
  pdf417, codigopostal, poblacion: string;
begin
  dm.q_sql2.Close;
  dm.q_sql2.Connection := dm.con1;
  dm.q_sql2.SQL.Clear;
  dm.q_sql2.SQL.Add('select * from albaranes where codalbaran=:codalbaran');
  dm.q_sql2.parameters.parambyname('codalbaran').value := codalbaran;
  dm.q_sql2.Open;

  codrepartidor := dm.q_sql2.FieldByName('codrepartidor').AsInteger;
  poblacion := dm.q_sql2.FieldByName('dst_localidad').AsString;
  codigopostal := Trim(dm.q_sql2.FieldByName('dst_cp').AsString);
  dst_coddel := dm.q_sql2.FieldByName('dst_coddel').asinteger;

  dm.cds_bultos.Close;
  dm.cds_bultos.Active := true;
  dm.cds_bultos.EmptyDataSet;

  for bulto := 1 to dm.q_sql2.FieldByName('bultos').asinteger do
  begin      //etiqueta para cada bulto
    dm.cds_bultos.Insert;

    dm.cds_bultos.FieldByName('id_caja').AsInteger := 0;
    dm.cds_bultos.FieldByName('tipo_caja').asstring := '';
    dm.cds_bultos.FieldByName('codcli').AsInteger := dm.q_sql2.FieldByName('codcli').AsInteger;
    dm.cds_bultos.FieldByName('codalbaran').AsInteger := codalbaran;
    dm.cds_bultos.FieldByName('unidades').AsInteger := dm.q_sql2.FieldByName('paquetes').AsInteger;
    ;
    dm.cds_bultos.FieldByName('fecha').AsDateTime := dm.q_sql2.FieldByName('fecha').AsDateTime;
    dm.cds_bultos.FieldByName('codruta').AsInteger := dm.q_sql2.FieldByName('codruta').AsInteger;
    dm.cds_bultos.FieldByName('coddst').AsString := FormatFloat('0000', dm.q_sql2.FieldByName('dst_codcli').AsInteger) + formatfloat('0000', dm.q_sql2.FieldByName('dst_coddel').AsInteger);
    dm.cds_bultos.fieldbyname('dst_nombre').asstring := dm.q_sql2.fieldbyname('dst_nombre').asstring;
    dm.cds_bultos.fieldbyname('dst_calle').asstring := dm.q_sql2.fieldbyname('dst_calle').asstring;
    dm.cds_bultos.fieldbyname('dst_cp').asstring := FormatFloat('00000', StrToInt(codigopostal));
    dm.cds_bultos.fieldbyname('dst_localidad').asstring := dm.q_sql2.fieldbyname('dst_localidad').asstring;
    dm.cds_bultos.fieldbyname('dst_provincia').asstring := dm.q_sql2.fieldbyname('dst_provincia').asstring;
    dm.cds_bultos.FieldByName('bultos').AsInteger := dm.q_sql2.fieldbyname('bultos').asinteger;
    ;
    dm.cds_bultos.FieldByName('observaciones').AsString := dm.q_sql2.fieldbyname('observaciones').AsString;
    dm.cds_bultos.FieldByName('dst_tfno').AsString := dm.q_sql2.FieldByName('dst_tfno').AsString;
    dm.cds_bultos.FieldByName('dst_coddel').AsString := dm.q_sql2.FieldByName('dst_coddel').AsString;
    dm.cds_bultos.FieldByName('dst_persona').AsString := dm.q_sql2.FieldByName('dst_persona').AsString;
    dm.cds_bultos.FieldByName('ordenbulto').asinteger := bulto;
    dm.cds_bultos.FieldByName('codrepartidor').AsInteger := codrepartidor;
    dm.cds_bultos.fieldbyname('org_nombre').asstring := dm.q_sql2.fieldbyname('org_nombre').asstring;
    dm.cds_bultos.fieldbyname('org_calle').asstring := dm.q_sql2.fieldbyname('org_calle').asstring;
    dm.cds_bultos.fieldbyname('org_cp').asstring := dm.q_sql2.fieldbyname('org_cp').asstring;
    dm.cds_bultos.fieldbyname('org_localidad').asstring := dm.q_sql2.fieldbyname('org_localidad').asstring;
    dm.cds_bultos.fieldbyname('org_provincia').asstring := dm.q_sql2.fieldbyname('org_provincia').asstring;
    dm.cds_bultos.FieldByName('org_tfno').AsString := dm.q_sql2.FieldByName('org_tfno').AsString;
    dm.cds_bultos.FieldByName('reembolso').AsString := dm.q_sql2.FieldByName('reembolso').AsString;
    dm.cds_bultos.FieldByName('referencia').AsString := '';
    dm.cds_bultos.FieldByName('kgs').AsString := dm.q_sql2.FieldByName('Kgs').AsString;
    if dm.q_sql2.FieldByName('pdebido').AsFloat <= 0 then
      dm.cds_bultos.FieldByName('sempor').AsString := 'PAGADOS'
    else
      dm.cds_bultos.FieldByName('sempor').AsString := 'DEBIDOS';

    dm.cds_bultos.FieldByName('codbulto').AsString := '';

    pdf417 := limpiachar(FormatDateTime('dd-mm-aaaa', dm.cds_bultos.FieldByName('fecha').AsDateTime)) + cr + limpiachar(dm.cds_bultos.FieldByName('codcli').AsString) + cr + limpiachar(dm.cds_bultos.fieldbyname('org_nombre').asstring) + cr + limpiachar(dm.cds_bultos.fieldbyname('org_calle').asstring) + cr + limpiachar(dm.cds_bultos.fieldbyname('org_cp').asstring) + cr + limpiachar(dm.cds_bultos.fieldbyname('org_localidad').asstring) + cr + limpiachar(dm.cds_bultos.FieldByName('org_tfno').AsString) + cr +
      limpiachar(dm.cds_bultos.fieldbyname('dst_nombre').asstring) + cr + limpiachar(dm.cds_bultos.fieldbyname('dst_calle').asstring) + cr + limpiachar(codigopostal) + cr + limpiachar(dm.cds_bultos.fieldbyname('dst_localidad').asstring) + cr + limpiachar(dm.cds_bultos.FieldByName('dst_tfno').AsString) + cr + limpiachar(dm.cds_bultos.FieldByName('dst_persona').AsString) + cr + limpiachar(dm.cds_bultos.fieldbyname('codalbaran').Asstring) + cr + limpiachar(dm.cds_bultos.FieldByName('dst_coddel').AsString) + cr + limpiachar(dm.cds_bultos.FieldByName('kgs').AsString) + cr + dm.cds_bultos.FieldByName('ordenbulto').AsString + cr + dm.cds_bultos.FieldByName('bultos').AsString;

    dm.cds_bultos.FieldByName('pdf417').AsString := pdf417;

    dm.cds_bultos.Post;
  end;

  rep_log.PrintOptions.Printer := imp_eti;
  if rep_log.PrepareReport(True) then
    rep_log.print;
end;

function Tf_main.imprime_eti_bulto_asm(codalbaran, delivery_time: integer): string;
const
  cr = Chr(13);
  lr = Chr(10);
var
  codrepartidor, dst_coddel, bulto, s1, s2, dc: Integer;
  pdf417, codigopostal, poblacion, cli_bc: string; 
  asm_correo, asm_horario, asm_codcli, bc: string;
begin
  dm.q_sql2.Close;

  dm.q_sql2.SQL.Clear;
  dm.q_sql2.SQL.Add('select * from albaranes where codalbaran=:codalbaran');
  dm.q_sql2.parameters.ParamByName('codalbaran').Value := codalbaran;
  dm.q_sql2.Open;

  if not dm.q_sql2.IsEmpty then
  begin
    codrepartidor := dm.q_sql2.FieldByName('codrepartidor').AsInteger;
    poblacion := dm.q_sql2.FieldByName('dst_localidad').AsString;
    codigopostal := Trim(dm.q_sql2.FieldByName('dst_cp').AsString);
    dst_coddel := dm.q_sql2.FieldByName('dst_coddel').asinteger;
    // obtengo delegacion para ASM
    //
    dm.qrytemp.Close;
    dm.qrytemp.SQLs.SelectSQL.Clear;
    dm.qrytemp.SQLs.SelectSQL.Add('select top 1 d.id_del as id_del,d.nombre as nombre ' +                    //qrym
      ' from asm_deleg d ' + ' inner join asm_cp c on ((d.id_del = c.id_del) and (d.id_subdel=c.id_subdel)) ' + ' where c.cp = ' + codigopostal + ' and c.pais = 34');
    dm.qrytemp.Open;
    //
    // obtengo tipo de envio para ASM
    //

    asm_codcli := IntToStr(main_cli);
    asm_correo := 'COURIER';

    case delivery_time of
      10:
        asm_horario := 'ASM10';
      14:
        asm_horario := 'ASM14';
      24:
        asm_horario := 'ASM24';
      72:
        asm_horario := 'ECONOMY';
    end;

    cli_bc := '';

    dm.cds_bultos.Close;
    dm.cds_bultos.Active := true;
    dm.cds_bultos.EmptyDataSet;

    for bulto := 1 to dm.q_sql2.FieldByName('bultos').asinteger do
    begin      //etiqueta para cada bulto
      dm.cds_bultos.Insert;

      dm.cds_bultos.FieldByName('id_caja').AsInteger := 0;
      dm.cds_bultos.FieldByName('tipo_caja').asstring := '';
      dm.cds_bultos.FieldByName('codcli').AsInteger := dm.q_sql2.FieldByName('codcli').AsInteger;
      dm.cds_bultos.FieldByName('codalbaran').AsInteger := codalbaran;
      dm.cds_bultos.FieldByName('unidades').AsInteger := dm.q_sql2.FieldByName('paquetes').AsInteger;
      ;
      dm.cds_bultos.FieldByName('fecha').AsDateTime := dm.q_sql2.FieldByName('fecha').AsDateTime;
      dm.cds_bultos.FieldByName('codruta').AsInteger := dm.q_sql2.FieldByName('codruta').AsInteger;
        //dm.cds_bultos.FieldByName('coddst').AsString:=FormatFloat('0000',dm.q_sql2.FieldByName('dst_codcli').AsInteger)+formatfloat('0000',dm.q_sql2.FieldByName('dst_coddel').AsInteger);
      dm.cds_bultos.FieldByName('coddst').AsString := asm_codcli + formatfloat('0000', dm.q_sql2.FieldByName('dst_coddel').AsInteger);
      dm.cds_bultos.fieldbyname('dst_nombre').asstring := dm.q_sql2.fieldbyname('dst_nombre').asstring;
      dm.cds_bultos.fieldbyname('dst_calle').asstring := dm.q_sql2.fieldbyname('dst_calle').asstring;
      dm.cds_bultos.fieldbyname('dst_cp').asstring := FormatFloat('00000', StrToInt(codigopostal));
      dm.cds_bultos.fieldbyname('dst_localidad').asstring := dm.q_sql2.fieldbyname('dst_localidad').asstring;
      dm.cds_bultos.fieldbyname('dst_provincia').asstring := dm.q_sql2.fieldbyname('dst_provincia').asstring;
      dm.cds_bultos.FieldByName('bultos').AsInteger := dm.q_sql2.fieldbyname('bultos').asinteger;
      ;
      dm.cds_bultos.FieldByName('observaciones').AsString := dm.q_sql2.fieldbyname('observaciones').AsString;
      dm.cds_bultos.FieldByName('dst_tfno').AsString := dm.q_sql2.FieldByName('dst_tfno').AsString;
      dm.cds_bultos.FieldByName('dst_coddel').AsString := dm.q_sql2.FieldByName('dst_coddel').AsString;
      dm.cds_bultos.FieldByName('dst_persona').AsString := dm.q_sql2.FieldByName('dst_persona').AsString;
      dm.cds_bultos.FieldByName('ordenbulto').asinteger := bulto;
      dm.cds_bultos.FieldByName('codrepartidor').AsInteger := codrepartidor;
      dm.cds_bultos.fieldbyname('org_nombre').asstring := dm.q_sql2.fieldbyname('org_nombre').asstring;
      dm.cds_bultos.fieldbyname('org_calle').asstring := dm.q_sql2.fieldbyname('org_calle').asstring;
      dm.cds_bultos.fieldbyname('org_cp').asstring := dm.q_sql2.fieldbyname('org_cp').asstring;
      dm.cds_bultos.fieldbyname('org_localidad').asstring := dm.q_sql2.fieldbyname('org_localidad').asstring;
      dm.cds_bultos.fieldbyname('org_provincia').asstring := dm.q_sql2.fieldbyname('org_provincia').asstring;
      dm.cds_bultos.FieldByName('org_tfno').AsString := dm.q_sql2.FieldByName('org_tfno').AsString;
      dm.cds_bultos.FieldByName('reembolso').AsString := dm.q_sql2.FieldByName('reembolso').AsString;
      dm.cds_bultos.FieldByName('referencia').AsString := '';
      dm.cds_bultos.FieldByName('kgs').AsString := dm.q_sql2.FieldByName('Kgs').AsString;
      if dm.q_sql2.FieldByName('pdebido').AsFloat <= 0 then
        dm.cds_bultos.FieldByName('sempor').AsString := 'PAGADOS'
      else
        dm.cds_bultos.FieldByName('sempor').AsString := 'DEBIDOS';

      dm.cds_bultos.FieldByName('asm_correo').AsString := asm_correo;
      dm.cds_bultos.FieldByName('asm_horario').AsString := asm_horario;
      dm.cds_bultos.FieldByName('asm_codcli').AsString := asm_codcli;
      dm.cds_bultos.FieldByName('asm_mnemo').AsString := dm.qrytemp.FieldByName('id_del').AsString;
      dm.cds_bultos.FieldByName('asm_pobla').AsString := dm.qrytemp.FieldByName('nombre').AsString;
      dm.cds_bultos.FieldByName('asm_bc_human').AsString := '31-' + cli_inf_asm_cl + '-' + formatfloat('0000000', codalbaran);
      dm.cds_bultos.FieldByName('asm_tracking').AsString := '31' + cli_inf_asm_cl + formatfloat('0000000', codalbaran);
      bc := '31' + cli_inf_asm_cl + formatfloat('0000000', codalbaran) + formatfloat('000', bulto);
      s1 := strtoint(bc[1]) + strtoint(bc[3]) + strtoint(bc[5]) + strtoint(bc[7]) + strtoint(bc[9]) + strtoint(bc[11]) + strtoint(bc[13]) + strtoint(bc[15]) + strtoint(bc[17]);
      s2 := strtoint(bc[2]) + strtoint(bc[4]) + strtoint(bc[6]) + strtoint(bc[8]) + strtoint(bc[10]) + strtoint(bc[12]) + strtoint(bc[14]) + strtoint(bc[16]);
      s1 := s1 * 3;
      s1 := s1 + s2;
      dc := 0;
      while ((s1 + dc) mod 10) <> 0 do
        inc(dc);
      dm.cds_bultos.FieldByName('asm_bc').AsString := bc + formatfloat('0', dc);

      dm.cds_bultos.FieldByName('codbulto').AsString := '';

      pdf417 := limpiachar(FormatDateTime('dd-mm-aaaa', dm.cds_bultos.FieldByName('fecha').AsDateTime)) + cr + limpiachar(dm.cds_bultos.FieldByName('codcli').AsString) + cr + limpiachar(dm.cds_bultos.fieldbyname('org_nombre').asstring) + cr + limpiachar(dm.cds_bultos.fieldbyname('org_calle').asstring) + cr + limpiachar(dm.cds_bultos.fieldbyname('org_cp').asstring) + cr + limpiachar(dm.cds_bultos.fieldbyname('org_localidad').asstring) + cr + limpiachar(dm.cds_bultos.FieldByName('org_tfno').AsString) + cr +
        limpiachar(dm.cds_bultos.fieldbyname('dst_nombre').asstring) + cr + limpiachar(dm.cds_bultos.fieldbyname('dst_calle').asstring) + cr + limpiachar(codigopostal) + cr + limpiachar(dm.cds_bultos.fieldbyname('dst_localidad').asstring) + cr + limpiachar(dm.cds_bultos.FieldByName('dst_tfno').AsString) + cr + limpiachar(dm.cds_bultos.FieldByName('dst_persona').AsString) + cr + limpiachar(dm.cds_bultos.fieldbyname('codalbaran').Asstring) + cr + limpiachar(dm.cds_bultos.FieldByName('dst_coddel').AsString) + cr + limpiachar(dm.cds_bultos.FieldByName('kgs').AsString) + cr + dm.cds_bultos.FieldByName('ordenbulto').AsString + cr + dm.cds_bultos.FieldByName('bultos').AsString;

      dm.cds_bultos.FieldByName('pdf417').AsString := pdf417;

      dm.cds_bultos.Post;
    end;

    rep_db_bultos.DataSet := dm.cds_bultos;
      //rep_asm.DataSet := rep_db_bultos;
    rep_asm.PrintOptions.Printer := imp_eti;
    if rep_asm.PrepareReport(True) then
      rep_asm.print;

    result := dm.cds_bultos.FieldByName('asm_tracking').AsString;
  end
  else
    ShowMessage('No existe el albarán ' + IntToStr(codalbaran));
end;

function Tf_main.imprime_eti_bulto_chrono(codalbaran, delivery_time: integer): string;
{var
  lf, s: string;}
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

function Tf_main.imprime_eti_bulto_correos(codalbaran: integer): string;
const
  cr = Chr(13);
  lr = Chr(10);
var
  bulto: Integer;
  pdf417, cod_bulto: string;
  graf1, graf2, graf3, graf4, graf5, graf6, graf7, cadena: string;
begin
  graf1 := LeerHexa('correos.hex');                   //lee logos hexadecimal
  graf2 := LeerHexa('paq72.hex');
  graf3 := LeerHexa('LOGINSER.hex');
  graf4 := LeerHexa('DOMICILIO.hex');
  graf5 := LeerHexa('paq48.hex');
  graf6 := LeerHexa('economico.hex');
  graf7 := LeerHexa('pagado.hex');

  dm.q_sql2.Close;
  dm.q_sql2.SQL.Clear;
  dm.q_sql2.SQL.Add('select * from albaranes where codalbaran=:codalbaran');
  dm.q_sql2.parameters.parambyname('codalbaran').value := codalbaran;
  dm.q_sql2.Open;

  with tpfibdataset.Create(dm) do                            //Codigo Bulto y expedicion
  try
    database := dm.db;

    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select BARCODE from CORREOS_BARCODE(:codalbaran, :dst_cp)');
    ParamByName('codalbaran').AsInteger := codalbaran;
    ParamByName('dst_cp').asstring := dm.q_sql2.FieldByName('dst_cp').asstring;
    Open;

    if not (IsEmpty) then
    begin
      cod_bulto := FieldByName('barcode').asstring;
    end
    else
      cod_bulto := '';

  finally
    free;
  end;

  dm.cds_bultos.Close;
  dm.cds_bultos.Active := true;
  dm.cds_bultos.EmptyDataSet;

  for bulto := 1 to dm.q_sql2.fieldbyname('bultos').asinteger do
  begin                  //etiqueta para cada bulto
      // Asignar impresora de red si es USB
    cadena := '~DGR:CORREOS.GRF,01980,9,' + graf1;        // Carga gráficos en memoria de impresora
    cadena := cadena + '~DGR:PAQ72.GRF,0902,11,' + graf2 + cr + lr;
    cadena := cadena + '~DGR:LOGINSER.GRF,1700,10,' + graf3 + cr + lr;
    cadena := cadena + '~DGR:DOMICILIO.GRF,585,9,' + graf4 + cr + lr;
    cadena := cadena + '~DGR:PAQ48.GRF,0990,11,' + graf5 + cr + lr;
    cadena := cadena + '~DGR:ECO.GRF,0630,7,' + graf6 + cr + lr;
    cadena := cadena + '~DGR:PAGADO.GRF,15296,32,' + graf7 + cr + lr;

    cadena := cadena + '^XA^PW1000' + cr + lr;
    cadena := cadena + '^FO720,120^XGR:CORREOS.GRF,1,1^FS' + cr + lr;  // Imprime gráficos LOGOS

    //**********************************************************************************
    cadena := cadena + '^FO700,390^XGR:PAQ72.GRF,1,1^FS' + cr + lr;
    //cadena:=cadena+'^FO700,390^XGR:PAQ48.GRF,1,1^FS'+cr+lr;
    //*********************************************************************************

    cadena := cadena + '^FO640,540^XGR:LOGINSER.GRF,1,1^FS' + cr + lr;
    cadena := cadena + '^FO320,940^XGR:DOMICILIO.GRF,2,2^FS' + cr + lr;

    cadena := cadena + '^CI27' + cr + lr;
    ; // Cambia el banco de caracteres a un banco con tildes y letras Ñ ñ

    cadena := cadena + '^FO400,100 ^A0N,30,25^FDDestinatario         Remitente^FS' + cr + lr;   // Texto
    cadena := cadena + '^FO678,140 ^ADR,18,10^FD' + dm.q_sql2.fieldbyname('org_nombre').asstring + '^FS' + cr + lr;  // Remitente
    cadena := cadena + '^FO656,140 ^ADR,18,10^FD' + dm.q_sql2.fieldbyname('org_calle').asstring + '^FS' + cr + lr;
    cadena := cadena + '^FO634,140 ^ADR,18,10^FD' + dm.q_sql2.fieldbyname('org_cp').asstring + '-' + dm.q_sql2.fieldbyname('org_localidad').asstring + '^FS' + cr + lr;   // CPOSTAL???
    cadena := cadena + '^FO612,140 ^ADR,18,10^FD' + dm.q_sql2.fieldbyname('org_provincia').asstring + '^FS' + cr + lr;

    cadena := cadena + '^FO550,140 ^ADR,18,10^FD-----------------------------------------^FS';
    cadena := cadena + '^FO495,140 ^ADR,18,10^FD' + dm.q_sql2.fieldbyname('dst_nombre').asstring + '^FS' + cr + lr;            //Destinatario
    cadena := cadena + '^FO473,140 ^ADR,18,10^FD' + dm.q_sql2.fieldbyname('dst_calle').asstring + '^FS' + cr + lr;
    cadena := cadena + '^FO451,140 ^ADR,24,18^FD' + dm.q_sql2.fieldbyname('dst_cp').asstring + '-' + dm.q_sql2.fieldbyname('dst_localidad').asstring + '^FS' + cr + lr;
    cadena := cadena + '^FO429,140 ^ADR,24,18^FD' + dm.q_sql2.fieldbyname('dst_provincia').asstring + '^FS' + cr + lr;
    cadena := cadena + '^FO407,140 ^ADR,18,10^FDTeléfono:' + dm.q_sql2.FieldByName('dst_tfno').AsString + '^FS' + cr + lr;
    cadena := cadena + '^FO385,140 ^ADR,18,10^FDObservaciones^FS' + cr + lr;
    cadena := cadena + '^FO363,140 ^ADR,18,10^FD' + dm.q_sql2.FieldByName('observaciones').AsString + '^FS' + cr + lr;
    cadena := cadena + '^FO340,140 ^ADR,18,10^FD-----------------------------------------^FS' + cr + lr;

    cadena := cadena + '^FO300,130 ^A0R,30,25^FDCódigo bulto: ' + cod_bulto + '^FS' + cr + lr;            // código de barras ser humano
    cadena := cadena + '^FO780,770 ^A0R,30,25^FDExpedición: ' + ''{dm.cds_bultos.FieldByName('codexpedicion').asstring} + '^FS' + cr + lr;            // expedición ser humano

    cadena := cadena + '^FO310,720 ^ADN,20,12^FDValores^FS' + cr + lr;                        // Texto
    cadena := cadena + '^FO310,740 ^ADN,20,12^FDAñadidos^FS' + cr + lr;                       // Texto
    cadena := cadena + '^FO310,760 ^ADN,20,12^FD----------^FS' + cr + lr;                     // Texto

    cadena := cadena + '^FO270,920 ^ADR,18,10^FDBulto:^FS' + cr + lr;                        //
    cadena := cadena + '^FO248,920 ^ADR,18,10^FD' + inttostr(bulto) + '^FS' + cr + lr;              //
    cadena := cadena + '^FO216,920 ^ADR,18,10^FDPeso:^FS' + cr + lr;                    //
    cadena := cadena + '^FO194,920 ^ADR,18,10^FD' + formatfloat('0.000', dm.q_sql2.FieldByName('kgs').asfloat) + 'Kgs.^FS' + cr + lr;   //

    cadena := cadena + '^FWR' + cr + lr;
    cadena := cadena + '^FO70,120' + cr + lr;
    cadena := cadena + '^BY3' + cr + lr;
    cadena := cadena + '^POA' + cr + lr;
    cadena := cadena + '^BCR, 220, N, N, N, A^FD' + cod_bulto + '^FS' + cr + lr;                     // código de barras C128

    pdf417 := '0000';                                                     // código etiquetador, 4
    pdf417 := pdf417 + espacios(cod_bulto, 23);      // Codigo envío, 23
    pdf417 := pdf417 + Zeros(dm.q_sql2.FieldByName('bultos').AsString, 2);        // Número de bultos, 2
    pdf417 := pdf417 + Zeros(inttostr(bulto), 2);    // orden bulto,2
    pdf417 := pdf417 + espacios(dm.q_sql2.fieldbyname('dst_nombre').asstring, 36);    // nombre destinatario, 36
    pdf417 := pdf417 + espacios(' ', 15);                                   // nif destinatario, 15
    pdf417 := pdf417 + espacios(dm.q_sql2.fieldbyname('dst_calle').asstring, 72);     // dirección destinatario, 72
    pdf417 := pdf417 + espacios(dm.q_sql2.fieldbyname('dst_localidad').asstring, 25); // localidad destinatario, 25
    pdf417 := pdf417 + Zeros(dm.q_sql2.fieldbyname('dst_cp').asstring, 5);        // cp destinatario, 5
    pdf417 := pdf417 + '00';                                                          // modo entrega 2
    pdf417 := pdf417 + formatfloat('00.00', dm.q_sql2.FieldByName('kgs').asfloat); // peso 5
    pdf417 := pdf417 + '000000';                                                        // importe seguro 6
    pdf417 := pdf417 + '000000';                                                        // importe reembolso 6
    pdf417 := pdf417 + '00000000000000000000';                                          // número cuenta 20
    pdf417 := pdf417 + ' ';                                                             // Entrega exclusiva  1
    pdf417 := pdf417 + '  ';                                                            // formato de prueba 2
    pdf417 := pdf417 + '000000000';                                                     // SMS destinatario 9
    pdf417 := pdf417 + '000000000';                                                     // SMS remitente 9
    pdf417 := pdf417 + '0';                                                             // idioma remitente 1
    pdf417 := pdf417 + '0';                                                             // idioma destinatario 1
    pdf417 := pdf417 + '   ';                                                           // Devolucion, reparto, entrega 3
    pdf417 := pdf417 + '0';                                                             // tipo menvío 1
    pdf417 := pdf417 + '  ';                                                            // DUA 2
    pdf417 := pdf417 + espacios(dm.q_sql2.fieldbyname('org_nombre').asstring, 36);   //Nombre remitente 36
    pdf417 := pdf417 + espacios(' ', 15);                                                //Nif remitente
    pdf417 := pdf417 + espacios(dm.q_sql2.fieldbyname('org_calle').asstring, 72);    // dirección remitente, 72
    pdf417 := pdf417 + espacios(dm.q_sql2.fieldbyname('org_localidad').asstring, 25); // localidad remitente, 25
    pdf417 := pdf417 + Zeros(dm.q_sql2.fieldbyname('org_cp').asstring, 5);           // cp remitente, 5
    pdf417 := pdf417 + '000000';                                                        // apartado reembolso 6
    pdf417 := pdf417 + '00000';                                                         // importe pagado 5
    pdf417 := Copy(pdf417, 1, 416);

    cadena := cadena + '^FO590,735' + cr + lr;
    cadena := cadena + '^BY3' + cr + lr;
    cadena := cadena + '^B7R,7,5,,,N^FD' + pdf417 + '^FS' + cr + lr;                 // código de barras 2D PDF417

    cadena := cadena + '^XZ' + cr + lr;

    WriteRawDataToPrinter(imp_eti, cadena);
  end;

  result := cod_bulto;
end;

function Tf_main.limpiachar(frase: string): string;
var
  s: string;
  i: integer;
begin
  s := '';
  for i := 1 to Length(frase) do
    if (((ord(frase[i]) >= 40) and (ord(frase[i]) <= 57)) or ((ord(frase[i]) >= 65) and (ord(frase[i]) <= 90)) or ((ord(frase[i]) >= 97) and (ord(frase[i]) <= 122))) then
      s := s + frase[i]
    else
      s := s + ' ';
  result := s;
end;

function tf_main.LeerHexa(fichero: string): string;
var
  F: TextFile;
  sLinea, temp, parte, resultado, hexa: string;
  puntero, contador: Integer;
begin
  // Todas las imágenes son bitmaps de un solo color convertidos a valores decimales separados por comas
  // Esta función convierte los decimales a hexadecimales para enviarlos a la impresora
  //
  fichero := ExtractFilePath(Application.ExeName) + 'logos\' + fichero;
  AssignFile(F, fichero);
  Reset(F);
  temp := '';
  while not Eof(F) do
  begin
    ReadLn(F, sLinea);
    temp := temp + sLinea;
  end;
  CloseFile(F);
  resultado := '';
  contador := 1;
  while True do
  begin
    puntero := Pos(',', temp);
    if puntero > 0 then
    begin
      parte := Trim(Copy(temp, 1, puntero - 1));
    end
    else
    begin
      parte := Trim(Copy(temp, 1, Length(temp)));
    end;
    hexa := IntToHex(strtoint(parte), 2);
    resultado := resultado + hexa;
    if puntero = 0 then
      Break;
    Delete(temp, 1, puntero);
    Inc(contador);
  end;
  //
  Result := resultado;
end;

function tf_main.Zeros(c: string; l: Integer): string;
var
  i: Integer;
begin
  c := Trim(c);
  l := l - Length(c);
  for i := 1 to l do
    c := '0' + c;

  Result := c;
end;

function Tf_main.Espacios(cadena: string; l: Integer): string;
var
  longitud: Integer;
begin
  cadena := Trim(cadena);
  longitud := Length(cadena);
  if longitud < l then
  begin
    //cadena:=cadena+System.StrUtils.DupeString(' ', (l-longitud));                     ****************
  end;
  cadena := Copy(cadena, 1, l);
end;


{$ENDREGION}

{$REGION 'Envia Ficheros'}
procedure Tf_main.bt_3Click(Sender: TObject);
begin
  lb_st1.Caption := 'Enviando....';
  application.ProcessMessages;
  envia_ficheros(true);                   //todos los del día

  lb_st1.Caption := 'Finalizado';
  sMessageDlg('Finalizado', mtInformation, [mbok], 0);
end;

procedure Tf_main.bt_2Click(Sender: TObject);
begin
  //ShowMessage(imprime_eti_bulto_correos(481093));
  envia_ficheros;
end;

procedure Tf_main.envia_ficheros(todos: boolean = false);
var
  ruta: string;
  email: Tf_envia_mail;
  cuerpo: tstrings;
  n: integer;
begin
  try
    u_gen_gl.lee_inis_def;      //lee defs de tablas aux

    n := 0;
                                                                                  //Envia fichero ASM
    ruta := u_gen_gl.sys_path + u_cam_gl.asm_exp_path + 'ASM_LGS_' + formatdatetime('yymmdd', Date) + '_' + formatdatetime('hhnnss', time) + '.txt';
    n := genera_fichero_asm(ruta, todos);

    //CopyFile(PChar(ruta),PChar(IncludeTrailingPathDelimiter(de_folder.text)+extractfilename(ruta)),False);

    if n > 0 then
    begin
      cuerpo := tstringlist.Create;
      cuerpo.Add('Se Adjunta Archivo de Expediciones de Loginser');

      email := Tf_envia_mail.create(self);
      email.Show;
      if email_asm <> '' then
        email.envia_email(email_asm, '', 'Fichero Loginser ' + IntToStr(main_cli) + '-' + formatdatetime('yymmdd', Date) + '_' + formatdatetime('hhnnss', time), ruta, mail_from, cuerpo)
      else
        email.envia_email(u_cam_gl.asm_exp_email, '', 'Fichero Loginser ' + edCliente.Text + '-' + formatdatetime('yymmdd', Date) + '_' + formatdatetime('hhnnss', time), ruta, mail_from, cuerpo);
      cuerpo.Free;
      email.close;
      email.Free;
    end;

  except
    ShowMessage('Error al enviar email.');
  end;

  n := 0;
                                                                               //Envia fichero Correos
 { ruta:=u_gen_gl.sys_path+u_cam_gl.correos_exp_path+'FD13X5'+formatdatetime('yyyymmddhhnnss',Now)+'.TXT';
  n:=genera_fichero_correos(ruta,todos);

  if n>0 then begin

    CopyFile(PChar(ruta),PChar(IncludeTrailingPathDelimiter(ed_folder.text)+extractfilename(ruta)),False);

    //ENVIAR FICHERO POR SFTP
  end;   }

end;

function Tf_main.genera_fichero_asm(ruta: string; todos: boolean): integer;
var
  f: textfile;
  linea: string;
  n: integer;
begin
  n := 0;
  dm.ds_1.close;                                                 //recoge pedidos de asm
  dm.ds_1.SelectSQL.clear;
  if todos then
  begin
    dm.ds_1.SelectSQL.Add('select * ' + 'from c_pedidos ' + 'where estado in (''G'',''E'') and transporte=0 and id_repartidor=2 and cast(fecha_gen as date)=:fecha and id_cliente in (');

    case rgTipoGes.ItemIndex of
      0:
        dm.ds_1.SelectSQL.Add(edCliente.Text);
      1:
        dm.ds_1.SelectSQL.Add('select distinct c.id_cliente from g_clientes cl ' + 
                              'inner join g_clientes_config_ c on cl.id_cliente=c.id_cliente ' + 
                              'where cl.id_grupo_cliente=' + edGrupo.Text + 
                              ' and ((c.item=''tiene_gp'') and (c.valor=''1''))');
    end;
    dm.ds_1.SelectSQL.Add(') order by id_cliente, id_pedido');

    dm.ds_1.parambyname('fecha').AsDatetime := de_1.Date;
  end
  else
  begin
    dm.ds_1.SelectSQL.Add('select * ' + 'from c_pedidos ' +
  //   'where estado=''G'' and id_repartidor=1');
      'where estado=''P'' and transporte=0 and id_repartidor=2 and id_cliente=:id_cliente');
    dm.ds_1.ParamByName('id_cliente').AsInteger := StrToInt(edCliente.Text);
  end;
  dm.ds_1.Open;

  if not (dm.ds_1.isempty) then
  begin
    try
      AssignFile(f, ruta);
      Rewrite(f);

      dm.ds_1.First;
      while not (dm.ds_1.Eof) do
      begin
        linea := linea_asm(dm.ds_1.FieldByName('codalbaran').asinteger, dm.ds_1.FieldByName('delivery_time').asinteger);
        Writeln(f, linea);

        if ((dm.ds_1.FieldByName('id_cliente').AsInteger >= 5100) and (dm.ds_1.FieldByName('id_cliente').AsInteger <= 5199)) then
          SendEstado(dm.ds_1.FieldByName('id_order').AsString, dm.ds_1.FieldByName('codalbaran').AsString, 'T');

        dm.ds_1.Next;
        inc(n);
      end;
    finally
      closefile(f);
    end;
  end;
  result := n;
end;

function Tf_main.linea_asm(codalbaran, delivery_time: Integer): string;                   //Genera Linea para ASM
var
  s, su_linea, tmp: string;
  dst_pais, dst_cp, asm_codcli, asm_servicio, asm_horario: integer;
begin
  s := '';

  asm_codcli := main_cli;

  if delivery_time = 24 then
  begin
    asm_servicio := 1;
    asm_horario := 3;
  end
  else if delivery_time = 14 then
  begin
    asm_servicio := 1;
    asm_horario := 2;
  end
  else if delivery_time = 10 then
  begin
    asm_servicio := 1;
    asm_horario := 0;
  end
  else if delivery_time = 72 then
  begin
    asm_servicio := 37;
    asm_horario := 4;
  end
  else
  begin
    asm_servicio := 37;
    asm_horario := 4;
  end;

  with tadoquery.create(self) do                                      //Su Linea
  try
    connection := dm.con1;
    sql.Add('select sulinea ' + 'from servicios_lineas ' + 'where codalbaran=:codalbaran');
    Parameters.ParamByName('codalbaran').Value := codalbaran;
    Open;

    if not (IsEmpty) then
      su_linea := FieldByName('sulinea').asstring
    else
      su_linea := '';
  finally
    free;
  end;

  with tadoquery.create(self) do                         //Genera Linea
  try
    connection := dm.con1;
    sql.Add('select * from albaranes where codalbaran=:codalbaran');
    Parameters.ParamByName('codalbaran').Value := codalbaran;
    Open;

    if not (IsEmpty) then
    begin
      dst_pais := 34;
      if Trim(FieldByName('dst_cp').asstring) = '' then
      begin
        tmp := get_cp_ext(FieldByName('dst_localidad').asstring);
        if Trim(tmp) = '' then
          dst_cp := 0
        else
          dst_cp := strtoint(tmp);
        dst_pais := 351;
      end
      else
        dst_cp := StrToInt(Trim(FieldByName('dst_cp').AsString));

      s := '1|' +                                                                  //Tipo
        '31' + cli_inf_asm_cl + formatfloat('0000000', codalbaran) + '|' +                       //Cod Barras
        '461|' +                                                                //Cod Plaza Origen
        FormatFloat('000000', codalbaran) + '|' +                                  //Albaran
        Copy(FieldByName('org_nombre').AsString, 1, 40) + '|' +                     //Org Nombre
        Copy(FieldByName('org_calle').AsString, 1, 40) + '|' +                      //Org Calle
        Copy(FieldByName('org_localidad').AsString, 1, 40) + '|' +                  //Org Localidad
        Copy(FieldByName('org_provincia').AsString, 1, 40) + '|' +                  //Org Provincia
        '34|' +                                                                 //Org Pais
        FormatFloat('00000', FieldByName('org_cp').asinteger) + '|' +              //Org CP
        Copy(FieldByName('org_tfno').AsString, 1, 10) + '|' +                       //Org Telefono
        Copy(FieldByName('org_coddel').AsString, 1, 4) + '|' +                      //Org Dpto
        '|' +                                                                   //Org NIF
        '|' +                                                                   //Org Observaciones
        FormatDateTime('dd/mm/yyyy', date) + '|' +                                 //Fecha
        '461|' +                                                                //PlzCli
        formatfloat('000000', asm_codcli) + '|' +                                  //CodCli
        'P|' +                                                                  //Portes
        '0,00|' +                                                               //Deb
        '0,00|' +                                                               //Reem
        Copy(FieldByName('dst_nombre').AsString, 1, 40) + '|' +                     //Dst Nombre
        Copy(FieldByName('dst_calle').AsString, 1, 40) + '|' +                      //Dst Direc
        Copy(FieldByName('dst_localidad').AsString, 1, 40) + '|' +                  //Dst Poblac
        Copy(FieldByName('dst_provincia').AsString, 1, 40) + '|' +                  //Dst Provin
        IntToStr(dst_pais) + '|' +                                                //Dst Pais
        FormatFloat('00000', dst_cp) + '|' +                                       //Dst CP
        Copy(FieldByName('dst_tfno').AsString, 1, 10) + '|' +                       //Dst Telefono
        '|' +                                                                   //Dst Dpto
        '|' +                                                                   //Dst NIF
        Copy(su_linea + '-' + trimleft(FieldByName('observaciones').AsString), 1, 100) + '|' +    //Dst Observaciones
        IntToStr(asm_servicio) + '|' +                                            //Servicio
        IntToStr(asm_horario) + '|' +                                             //Horario
        FormatFloat('0000', FieldByName('bultos').asinteger) + '|' +               //Bultos
        FormatFloat('0.000', FieldByName('kgs').asfloat) + '|' +                   //Kgs
        '0.0000|' +                                                             //m3
        '0|' +                                                                  //CodValija
        '5315||N||||||||||||N|||' +                                             //Agente y varios....
        '31' + cli_inf_asm_cl + formatfloat('0000000', codalbaran) + '||0|0|||||||';            //Cod Barras Agrupacion y varios...
    end
    else
      s := 'ERROR LEYENDO ALBARAN ' + inttostr(codalbaran);
  finally
    free;
  end;

  result := s;
end;

function Tf_main.genera_fichero_correos(ruta: string; todos: boolean): integer;
var
  f: textfile;
  linea: string;
  total, n: integer;
begin
  dm.ds_1.close;                                                 //recoge pedidos de correos
  dm.ds_1.SelectSQL.clear;
  if todos then
  begin
    dm.ds_1.SelectSQL.Add('select count(*) as total ' + 'from c_pedidos ' + 'where estado in (''G'',''E'') and id_repartidor=6 and cast(fecha_gen as date)=:fecha and id_cliente=:id_cliente');
    dm.ds_1.parambyname('fecha').AsDatetime := de_1.Date;
    dm.ds_1.ParamByName('id_cliente').AsInteger := StrToInt(edCliente.Text);
  end
  else
  begin
    dm.ds_1.SelectSQL.Add('select count(*) as total ' + 'from c_pedidos ' +
  //   'where estado=''G'' and id_repartidor=1');
      'where estado=''P'' and id_repartidor=6 and id_cliente=:id_cliente');
    dm.ds_1.ParamByName('id_cliente').AsInteger := StrToInt(edCliente.Text);
  end;
  dm.ds_1.Open;

  total := dm.ds_1.FieldByName('total').AsInteger;

  dm.ds_1.close;                                                 //recoge pedidos de correos
  dm.ds_1.SelectSQL.clear;
  if todos then
  begin
    dm.ds_1.SelectSQL.Add('select * ' + 'from c_pedidos ' + 'where estado in (''G'',''E''sync_oxfam_get_pedidos.php) and id_repartidor=6 and cast(fecha_gen as date)=:fecha and id_cliente=:id_cliente ');
    dm.ds_1.parambyname('fecha').AsDatetime := de_1.Date;
    dm.ds_1.ParamByName('id_cliente').AsInteger := StrToInt(edCliente.Text);
  end
  else
  begin
    dm.ds_1.SelectSQL.Add('select * ' + 'from c_pedidos ' +
  //   'where estado=''G'' and id_repartidor=1');
      'where estado=''P'' and id_repartidor=6 and id_cliente=:id_cliente');
    dm.ds_1.ParamByName('id_cliente').AsInteger := StrToInt(edCliente.Text);
  end;
  dm.ds_1.Open;

  n := 0;
  if not (dm.ds_1.isempty) then
  begin
    try
      AssignFile(f, ruta);
      Rewrite(f);

      dm.ds_1.First;
      while not (dm.ds_1.Eof) do
      begin
        linea := linea_correos(dm.ds_1.FieldByName('codalbaran').asinteger);

                // C=el primer reg R=el resto F=el ultimo - U=solo hay uno
        if total = 1 then
          linea := 'U' + Chr(9) + linea
        else
        begin
          if n = 0 then
            linea := 'C' + Chr(9) + linea
          else if n = total - 1 then
            linea := 'F' + Chr(9) + linea
          else
            linea := 'R' + Chr(9) + linea;
        end;

        Writeln(f, linea);
        dm.ds_1.Next;
        Inc(n);
      end;
    finally
      closefile(f);
    end;
  end;

  result := n;
end;

function Tf_main.linea_correos(codalbaran: Integer): string;
const
  sep = char(9);
var
  s, cod_bulto, dst_cp, n_exp, manif: string;
begin

  with tadoquery.create(self) do                         //Genera Linea
  try
    connection := dm.con1;
    sql.Add('select * from albaranes where codalbaran=:codalbaran');
    Parameters.ParamByName('codalbaran').Value := codalbaran;
    Open;
    dst_cp := FieldByName('dst_cp').AsString;

    with tpfibdataset.Create(dm) do                            //Codigo Bulto y expedicion
    try
      database := dm.db;

      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select BARCODE from CORREOS_BARCODE(:codalbaran, :dst_cp)');
      ParamByName('codalbaran').AsInteger := codalbaran;
      ParamByName('dst_cp').asstring := dst_cp;
      Open;

      if not (IsEmpty) then
      begin
        cod_bulto := FieldByName('barcode').asstring;
      end
      else
        cod_bulto := '';

      close;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('SELECT codexpedicion FROM correos_codexpedicion(:codalbaran)');
      ParamByName('codalbaran').AsInteger := codalbaran;
      Open;

      if not (IsEmpty) then
      begin
        n_exp := FieldByName('codexpedicion').asstring;
      end
      else
        n_exp := '';

      close;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('SELECT manifiesto FROM CORREOS_MANIFIESTO(current_date)');
      Open;

      if not (IsEmpty) then
      begin
        manif := FieldByName('manifiesto').asstring;
      end
      else
        n_exp := '';
    finally
      free;
    end;

    if not (IsEmpty) then
    begin
      s := '2013v001' + sep +                                      //formato fichero
        'S0132' + sep +                                        //codigo producto
        'FP' + sep +                                           //tipo franqueo
        '13X5' + sep +                                         //codigo etiquetador
        sep + sep + sep + sep + cod_bulto + sep +                                      //codigo envio
        n_exp + sep +                                          //n expedicion
        sep + sep + FieldByName('bultos').AsString + sep +                 //total bultos
        '1' + sep +                                            //numero de bulto (confuso)
        manif + sep +                                          //num manifiesto
        sep + sep + Copy(FieldByName('dst_nombre').AsString, 1, 50) + sep +  //nombre destino
        sep + sep + sep + sep + sep + sep + Copy(FieldByName('dst_calle').AsString, 1, 50) + sep +     //direccion
        sep + sep + sep + sep + sep + sep + Copy(FieldByName('dst_localidad').AsString, 1, 25) + sep +  //localidad
        Copy(FieldByName('dst_provincia').AsString, 1, 50) + sep +  //provincia
        dst_cp + sep +                                             //cp
        sep + sep + sep + sep + sep + Copy(FieldByName('dst_tfno').AsString, 1, 12) + sep +  //telefono
        sep + IntToStr(codalbaran) + sep +                             //referencia cliente
        'ST' + sep +                                           //modalidad entrega
        IntToStr(Round(FieldByName('kgs').asfloat * 1000)) + sep + //kgs en gramos
        StringOfChar(sep, 61) + Copy(FieldByName('org_nombre').AsString, 1, 50) + sep +  //nombre origen
        sep + sep + sep + sep + sep + sep + Copy(FieldByName('org_calle').AsString, 1, 50) + sep +     //direccion
        sep + sep + sep + sep + sep + sep + Copy(FieldByName('org_localidad').AsString, 1, 25) + sep +  //localidad
        Copy(FieldByName('org_provincia').AsString, 1, 50) + sep +  //provincia
        Copy(FieldByName('org_cp').AsString, 1, 5) + sep +  //cp
        sep + sep + sep + 'E';
    end
    else
      s := 'ERROR LEYENDO ALBARAN ' + inttostr(codalbaran);
  finally
    free;
  end;

  result := s;
end;

function Tf_main.get_cp_ext(poblacion: string): string;               //Saca CP de la poblacion (para envios al extranjero)
var
  fin: Boolean;
  s: string;
  t: char;
  n: Integer;
begin
  s := '';
  fin := False;
  n := 1;
  while not (fin) do
  begin
    t := poblacion[n];
    if ((Ord(t) >= 48) and (Ord(t) <= 57)) then
      s := s + copy(poblacion, n, 1);
    if n = Length(poblacion) then
      fin := True;
    if Length(s) = 5 then
      fin := True;
    inc(n);
  end;
  Result := s;
end;
{$ENDREGION}

{$REGION 'Web'}

function Tf_main.enviar_status_sent(pedidos, peds_sin_alb: string): Boolean;
var
  GetText: thSelecthilo;
  s: string;
  log: tstringlist;
  datos: TStringDynArray;
  i: Integer;
  php_status_copy: string;
begin
  result := True;
  try
    log := tstringlist.create();
    with tpfibdataset.Create(dm) do
    begin
      database := dm.db;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select * ' +
                         'from c_pedidos p ' +
                         'inner join c_pedidos_lines l on (p.id_pedido=l.id_pedido and l.id_line=1) ' + 'where p.estado in (''G'',''E'') and p.enviado_fich=0 and p.id_cliente=:id_cliente');

      {if pedidos <> '' then
          SQLs.SelectSQL.Add(' and p.id_pedido in (' + pedidos + ')');

      if peds_sin_alb <> '' then
          SQLs.SelectSQL.Add(' and id_pedido not in (' + peds_sin_alb + ') ');   }

      ParamByName('id_cliente').AsInteger := main_cli;
      Open;

      first;
      while not (eof) do
      begin

        php_status_copy := php_sent;
        //Sustituir valores (())
        php_status_copy := StringReplace(php_status_copy, '((order_name))', fieldbyname('order_name').AsString, [rfReplaceAll]);
        php_status_copy := StringReplace(php_status_copy, '((item_id))', fieldbyname('item_id').AsString, [rfReplaceAll]);
        php_status_copy := StringReplace(php_status_copy, '((cp))', fieldbyname('cp').AsString, [rfReplaceAll]);
        php_status_copy := StringReplace(php_status_copy, '((codalbaran))', fieldbyname('codalbaran').AsString, [rfReplaceAll]);

        GetText := ThSelectHilo.Create(true);
        GetText.FreeOnTerminate := True;
        s := php_status_copy;
        GetText.strurl := s;
        hiloactivo := True;
        GetText.Resume;
        while hiloactivo do
          Application.ProcessMessages;

        lb_1.Caption := htmldevuelto;

        dm.t_write.StartTransaction;
        try
          dm.q_1.Sql.Clear;
          dm.q_1.SQL.Add('update c_pedidos set enviado_fich=:marca_sent where id_pedido=:id_pedido');
          dm.q_1.ParamByName('id_pedido').AsInteger := FieldByName('id_pedido').AsInteger;
          dm.q_1.ParamByName('marca_sent').AsInteger := marca_sent;
          dm.q_1.ExecQuery;

          dm.t_write.Commit;
        except
          dm.t_write.Rollback;
        end;

        next;

        datos := splitstring(datos_sent, '|');
        for i := Low(datos) to High(datos) do
        begin
          datos[i] := StringReplace(datos[i], '((now))', formatdatetime('dd/mm/yyyy hh:nn:ss', now), [rfReplaceAll]);
          datos[i] := StringReplace(datos[i], '((php_status))', php_status_copy, [rfReplaceAll]);
          datos[i] := StringReplace(datos[i], '((html_devuelto))', htmldevuelto, [rfReplaceAll]);
          log.add(datos[i]);
        end;

      end;

      Free;
    end;

    if log.Count > 0 then
      log.savetofile(StringReplace(log_sent, '((now))', formatdatetime('ddmmyyyy-hhnnss', now), [rfReplaceAll]));
    log.free;
  except
    Result := False;
  end;
end;

procedure Tf_main.enviar_status_delivered(pedidos: string);
var
  GetText: thSelecthilo;
  codalb, i: Integer;
  s, php_status_copy: string;
  log: tstringlist;
  datos: TStringDynArray;
begin
  log := tstringlist.create();
  with tpfibdataset.Create(dm) do
  begin
    database := dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select codalbaran,order_name,id_pedido, cp ' +
                       'from c_pedidos ' +
                       'where estado=''E'' and enviado_fich=1 and id_cliente=:id_cliente');
    {if pedidos <> '' then
          SQLs.SelectSQL.Add(' and id_pedido in (' + pedidos + ')'); }
    {if peds_sin_alb <> '' then
          SQLs.SelectSQL.Add(' and id_pedido not in (' + peds_sin_alb + ') ');  }
    ParamByName('id_cliente').AsInteger := StrToInt(edCliente.Text);
    Open;

    first;
    while not (eof) do
    begin
      codalb := FieldByName('codalbaran').AsInteger;
      dm.qtempgest.Close;
      dm.qtempgest.SelectSQL.clear;
      dm.qtempgest.SelectSQL.add('select first 1 id_tracking  ' + 'from alb_tracking ae ' + 'where ae.id_albaran=:id_albaran ' + '  and ae.estado in (' + estados_delivered + ') order by fecha desc');
      dm.qtempgest.ParamByName('id_albaran').value := codalb;
      dm.qtempgest.open;

      if not (dm.qtempgest.IsEmpty) then
      begin
        php_status_copy := php_delivered;
        //Sustituir valores (())
        php_status_copy := StringReplace(php_status_copy, '((order_name))', fieldbyname('order_name').AsString, [rfReplaceAll]);
        php_status_copy := StringReplace(php_status_copy, '((cp))', fieldbyname('cp').AsString, [rfReplaceAll]);
        php_status_copy := StringReplace(php_status_copy, '((codalbaran))', fieldbyname('codalbaran').AsString, [rfReplaceAll]);

        GetText := ThSelectHilo.Create(true);
        GetText.FreeOnTerminate := True;
        s := php_status_copy;
        GetText.strurl := s;
        hiloactivo := True;
        GetText.Resume;
        while hiloactivo do
          Application.ProcessMessages;

        lb_1.Caption := htmldevuelto;

        dm.t_write.StartTransaction;
        try
          dm.q_1.Sql.Clear;
          dm.q_1.SQL.Add('update c_pedidos set enviado_fich=:marca_delivered where id_pedido=:id_pedido');
          dm.q_1.ParamByName('id_pedido').AsInteger := FieldByName('id_pedido').AsInteger;
          dm.q_1.ParamByName('marca_delivered').AsInteger := marca_delivered;
          dm.q_1.ExecQuery;

          dm.t_write.Commit;
        except
          dm.t_write.Rollback;
        end;

        datos := splitstring(datos_delivered, '|');

        for i := Low(datos) to High(datos) do
        begin
          datos[i] := StringReplace(datos[i], '((now))', formatdatetime('dd/mm/yyyy hh:nn:ss', now), [rfReplaceAll]);
          datos[i] := StringReplace(datos[i], '((php_delivered))', php_status_copy, [rfReplaceAll]);
          datos[i] := StringReplace(datos[i], '((html_devuelto))', htmldevuelto, [rfReplaceAll]);
          log.add(datos[i]);
        end;
      end;
      next;
    end;

    Free;
  end;

  if log.Count > 0 then
    log.savetofile(StringReplace(log_delivered, '((now))', formatdatetime('ddmmyyyy-hhnnss', now), [rfReplaceAll]));
  log.free;
end;

procedure Tf_main.btConfigClienteClick(Sender: TObject);
begin
    if locked then
         abre_config_cliente;
end;

procedure Tf_main.btCorreosClick(Sender: TObject);
var
  resultado: Boolean;
begin
  resultado := False;

  if rg_state.ItemIndex <> 2 then
  begin
    ShowMessage('Solo puede enviar pedidos En Preparación.');
    Exit;
  end;

  if dm.q_peds.IsEmpty then
  begin
    ShowMessage('No hay pedidos para enviar.');
    Exit;
  end;

  if chTodos.Checked then
  begin
    if MessageDlg('Va a enviar todos los pedidos a Correos. ¿Está seguro?', mtWarning, mbYesNo, 0) = mrNo then
      Exit
    else
    begin
      with dm.q_peds do
      begin
        First;
        ga_stat.MaxValue := dm.q_peds.RecordCount;
        ga_stat.Progress := 0;
        application.ProcessMessages;
        while not Eof do
        begin
                  // SI SE MODIFICA, MODIFICAR TAMBIEN EN q_pedsAfterScroll DEL dm

          if ((FieldByName('estado').asstring = 'G') and (FieldByName('id_repartidor').AsInteger = agencia_correos) and
(not tiene_etiquetas(FieldByName('id_pedido').AsInteger)) and    //No se han sacado las etiquetas anteriormente
  (
                        //22/12/2017 Vegaffinity sale por Correos
                        //((FieldByName('tags').asstring<>'AMAZON') and (FieldByName('tags').asstring<>'RETAIL') and (FieldByName('tags').asstring<>'VEGAFFINITY')) //EXTRA
                        //02/01/2018 Vegaffinity vuelve a salir por SEUR
                        //((FieldByName('tags').asstring<>'AMAZON') and (FieldByName('tags').asstring<>'RETAIL'))
  ((FieldByName('id_cliente').AsInteger = 7252) and (FieldByName('tags').asstring <> 'AMAZON') and (FieldByName('tags').asstring <> 'RETAIL') and (FieldByName('tags').asstring <> 'VEGAFFINITY')) //EXTRA
  or ((FieldByName('id_cliente').AsInteger = 7252) and (FieldByName('tags').asstring = 'RETAIL') and (FieldByName('pais_code').asstring = 'ES'))  //RETAIL nacionales
  or (FieldByName('id_cliente').AsInteger <> 7252))) then
          begin
            lb_st1.Caption := 'Enviando a Correos pedido ' + FieldByName('order_name').AsString;

            EnviaACorreos;
          end;

          ga_stat.Progress := ga_stat.Progress + 1;
          application.ProcessMessages;
          Next;
        end;

      end;
    end;
  end
  else
  begin
    if MessageDlg('Va a enviar a Correos el pedido ' + dm.q_peds.FieldByName('order_name').AsString + '. ¿Está seguro?', mtWarning, mbYesNo, 0) = mrNo then
      Exit
    else
    begin
      lb_st1.Caption := 'Enviando pedidos a Correos.';
      EnviaACorreos;
    end;
  end;

  lb_st1.Caption := 'Envío a Correos realizado.';
  btCorreos.Enabled := False;

end;

procedure Tf_main.btDevosClick(Sender: TObject);
begin
 // ShowMessage('Funcionalidad en desarrollo.');
 // Exit;

  pnPtes.Enabled := False;
  u_devos.cod_cli := StrToInt(edCliente.Text);
  frmDevos.ShowModal;
  pnPtes.Enabled := true;
end;

procedure Tf_main.btGrupoClick(Sender: TObject);
begin
  with fbuscapro do
  begin
    limpia_fields;
    multiselect := false;
    livekey := false;
    fields.commatext := 'g.id_grupo_cliente,g.nombre ';
    titulos.commatext := 'Código,Nombre';
    from := 'g_grupos_clientes g, g_clientes cl, g_clientes_config_ c ';
    where := 'g.id_grupo_cliente=cl.id_grupo_cliente and cl.id_cliente=c.id_cliente and ((c.item=''tiene_gp'') and (c.valor=''1'')) ';
    orden[1] := 1;
    busca := 2;
    distinct := 1;
    fillimpio := True;
    row_height := 17;

    showmodal;

    if resultado then
    begin
      with Sender as TsSpeedButton do
      begin
        edGrupo.text := valor[1];
        lbgrupo.caption := valor[2];
        filter(modo_historico);
      end;
    end;
  end;

  btLock.Enabled := (lbGrupo.Caption <> '(Seleccione un grupo de clientes)');
end;

procedure Tf_main.btImpAdjClick(Sender: TObject);
var
  ruta: string;
  todos, cancelado, imprimir, descargar: Boolean;
  Dialog: TForm;
  i, attachId: Integer;
begin

  pnPtes.Enabled := False;

  if dm.q_peds.IsEmpty then
  begin
    ShowMessage('No hay pedidos para enviar.');
    Exit;
  end;

  todos := true;
  cancelado := False;

  if gr_envs.SelCount > 0 then
  begin
    todos := false;
    Dialog := CreateMessageDialog('Existe una multiselección. ¿Qué adjuntos desea imprimir/descargar?', mtWarning, [mbYes, mbNo, mbCancel]);

    TButton(Dialog.Controls[2]).Caption := 'Todo';
    TButton(Dialog.Controls[3]).Caption := 'Selección';
    TButton(Dialog.Controls[4]).Caption := 'Cancelar';

    try
      case Dialog.ShowModal of
        mrYes: todos := True;
        mrNo: todos := False;
        mrCancel: cancelado := true;
      end;
    finally
      Dialog.Free;
    end;
  end;

  if not cancelado then
  begin

    Dialog := CreateMessageDialog('Seleccione la opción deseada', mtInformation, [mbYes, mbNo, mbOK, mbCancel]);

    TButton(Dialog.Controls[2]).Caption := 'Imprimir';
    TButton(Dialog.Controls[3]).Caption := 'Descargar';
    TButton(Dialog.Controls[4]).Caption := 'Ambos';
    TButton(Dialog.Controls[5]).Caption := 'Cancelar';

    try
      case Dialog.ShowModal of
        mrYes:
          begin
            imprimir := True;
            descargar := False;
          end;
        mrNo:
          begin
            imprimir := False;
            descargar := true;
          end;
        mrOk:
          begin
            imprimir := true;
            descargar := true;
          end;
        mrCancel:
          cancelado := true;
      end;
    finally
      Dialog.Free;
    end;

    if cancelado then
    begin
     lb_st1.Caption := 'Proceso cancelado.';
     Exit;
    end;

    if descargar then
    begin
      fopen.Title := 'Seleccione carpeta destino para guardar adjuntos:';
      fopen.ClassicDialog := False;
      if fopen.Execute then
        ruta := fopen.Directory;
    end;

    if todos then
    begin
      with dm.q_peds do
      begin
        First;

        if not IsEmpty then
        begin
          First;
          while not eof do
          begin
            if imprimir then
                dmDescargaAttach.ObtenAttach(IntToStr(dm.q_peds.FieldByName('id_pedido').asinteger),'pdf','P',attachId);
            if descargar then
                   dmDescargaAttach.ObtenAttach(IntToStr(dm.q_peds.FieldByName('id_pedido').asinteger),'pdf','S',ruta);
            next;
          end;
        end
        else
          ShowMessage('No existen pedidos a imprimir/descargar.');
      end;
    end
    else
    begin
      for i := 0 to gr_envs.SelCount - 1 do
      begin
        gr_envs.GotoSelection(i);

        if imprimir then
             dmDescargaAttach.ObtenAttach(IntToStr(dm.q_peds.FieldByName('id_pedido').asinteger),'pdf','P', attachId);
        if descargar then
             dmDescargaAttach.ObtenAttach(IntToStr(dm.q_peds.FieldByName('id_pedido').asinteger),'pdf','S', attachId);

      end;
    end;

   sShowMessage('Proceso Finalizado.');
   lb_st1.Caption := 'Proceso finalizado.';
  end
  else
    begin
      sShowMessage('Proceso Cancelado.');
      lb_st1.Caption := 'Proceso cancelado.';
    end;

  pnPtes.Enabled := True;

end;

procedure Tf_main.btPrintPickClick(Sender: TObject);
var
  pedidos: string;
  todos, cancelado: Boolean;
  Dialog: TForm;
  i: Integer;
begin

  pnPtes.Enabled := False;

  if (rg_state.ItemIndex <> 2) and (rg_state.ItemIndex <> 3) then
  begin
    ShowMessage('Solo puede imprimir pedidos Generados o Finalizados.');
    Exit;
  end;

  if dm.q_peds.IsEmpty then
  begin
    ShowMessage('No hay pedidos para enviar.');
    Exit;
  end;

  todos := true;
  cancelado := False;

  if gr_envs.SelCount > 0 then
  begin
    todos := false;
    Dialog := CreateMessageDialog('Existe una multiselección. ¿Qué pedidos desea imprimir?', mtWarning, [mbYes, mbNo, mbCancel]);

    TButton(Dialog.Controls[2]).Caption := 'Todo';
    TButton(Dialog.Controls[3]).Caption := 'Selección';
    TButton(Dialog.Controls[4]).Caption := 'Cancelar';

    try
      case Dialog.ShowModal of
        mrYes:
          begin
            if (MessageDlg('Va a imprimir TODOS los pedidos en pantalla, ¿desea continuar?', mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes) then
              todos := True
            else
              cancelado := true;
          end;
        mrNo:
          begin
            if (MessageDlg('Va a imprimir los pedidos SELECCIONADOS, ¿desea continuar?', mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes) then
              todos := False
            else
              cancelado := true;
          end;
        mrCancel:
          cancelado := true;
      end;
    finally
      Dialog.Free;
    end;
  end;

  if not cancelado then
  begin
    if todos then    //generar todos los pedidos
    begin
      with dm.q_peds do
      begin
        First;

        if not IsEmpty then
        begin
          pedidos := '';
          First;
          while not eof do
          begin
            dm_pick.imprime_hoja_pick('p', '', tiene_lotes, dm.q_peds.FieldByName('codalbaran').asinteger);
            next;
          end;

                //pedidos := Copy(pedidos,1,Length(pedidos)-1);
        end
        else
          ShowMessage('No existen pedidos a generar.');

      end;
    end
    else
    begin  //generar solo seleccionados
      pedidos := '';

      for i := 0 to gr_envs.SelCount - 1 do
      begin
        gr_envs.GotoSelection(i);

        dm_pick.imprime_hoja_pick('p', '', tiene_lotes, dm.q_peds.FieldByName('codalbaran').asinteger);
      end;
    end;

  end
  else
    lb_st1.Caption := 'Proceso cancelado.';

  lb_st1.Caption := 'Proceso de impresión finalizado.';

  pnPtes.Enabled := True;

end;

procedure Tf_main.send_order(pedido: Integer);
var
  cadena, tx, p: string;
  SendText: ThSendTextHilo;
begin
  cadena := '';
  p := '|';
  tx := '';

  with TpFIBDataSet.Create(self) do
  try
    Database := dm.db;
    SelectSQL.Clear;
    SelectSQL.Add('select * ' + 'from c_pedidos p ' + 'where id_pedido=:pedido');
    ParamByName('pedido').AsInteger := pedido;
    Open;

    tx := 'C' + p + FieldByName('id_cliente').AsString + p + FieldByName('id_order').AsString + p + FieldByName('order_name').AsString + p + FieldByName('nombre').AsString + p + Trim(Copy(FieldByName('dir_1').AsString, 0, 250)) + p + Trim(Copy(FieldByName('dir_1').AsString, 251, Length(FieldByName('dir_1').AsString))) + p + FieldByName('poblacion').AsString + p + FieldByName('provincia').AsString + p + FieldByName('cp').AsString + p + FieldByName('pais').AsString + p + FieldByName('pais_code').AsString + p + FormatDateTime('yyyy-mm-dd', FieldByName('fecha_ped').AsDateTime) + p + FieldByName('telefono').AsString + p + 'O' + p +  //estado
      FieldByName('email').AsString + p + FieldByName('company').AsString + p + FieldByName('tags').AsString + p + FieldByName('note').AsString + '#';

    cadena := cadena + tx;

    Close;
    SelectSQL.Clear;
    SelectSQL.Add('select * ' + 'from c_pedidos_lines p ' + 'where id_pedido=:pedido');
    ParamByName('pedido').AsInteger := pedido;
    Open;

    if RecordCount <> 0 then
    begin
      First;
      while not eof do
      begin
        tx := 'L' + p + FieldByName('id_pedido').AsString + p + FieldByName('id_line').AsString + p + FieldByName('sku').AsString + p + FieldByName('nombre_art').AsString + p + FieldByName('cantidad').AsString + '#';

        cadena := cadena + tx;
        Next;
      end;
      SetLength(cadena, Length(cadena) - 1);
    end;
  finally
    Free;
  end;

  SendText := ThSendTextHilo.create(true);
  SendText.launcher := 0;
  SendText.freeonterminate := true;
  SendText.varname := 'cadena';
  SendText.cadena := cadena;
  SendText.url := httpweb;
  SendText.nomphp := 'sync_insert_order.php';
  hiloactivo := true;
  SendText.Resume;
  while hiloactivo do
    Application.ProcessMessages;

  if Pos('OK', htmldevuelto) > 0 then
  begin                     //Han subido ok se marcan

    dm.t_write.StartTransaction;
    try
      dm.qu_1.Close;
      dm.qu_1.SQL.Clear;
      dm.qu_1.SQL.Add('update c_pedidos set sync_web=1 where id_pedido=:id');
      dm.qu_1.ParamByName('id').AsInteger := pedido;
      dm.qu_1.ExecQuery;

      dm.t_write.CommitRetaining;
    except
      dm.t_write.RollbackRetaining;
    end;

  end
  else
    lb_st1.Caption := 'Error Enviando Pedido a Web';

end;

procedure Tf_main.btActExpClick(Sender: TObject);
begin
  lb_st1.Caption := 'Revisando etiquetas US y UK ...';
  Screen.Cursor := crHourGlass;
  dm_flam.cod_cli := main_cli;
  dm_flam.procesaficheros;
  Screen.Cursor := crDefault;
  lb_st1.Caption := 'Proceso finalizado.';
end;

procedure Tf_main.btImpEtiqClick(Sender: TObject);
var
  pedidos, log_envio: string;
  resultado, todos, cancelado: Boolean;
  Dialog: TForm;
  i, codalbaran, gestoras_dest: Integer;
  pedidos_array: TStringDynArray;
begin
  pnPtes.Enabled := False;

  resultado := True;

  if rg_state.ItemIndex <> 3 then
  begin
    ShowMessage('Solo puede regenerar pedidos Enviados.');
    Exit;
  end;

  if dm.q_peds.IsEmpty then
  begin
    ShowMessage('No hay pedidos para enviar.');
    Exit;
  end;

  todos := true;
  cancelado := False;

  if gr_envs.SelCount > 0 then
  begin
    todos := false;
    Dialog := CreateMessageDialog('Existe una multiselección. ¿Qué pedidos desea regenerar?', mtWarning, [mbYes, mbNo, mbCancel]);

    TButton(Dialog.Controls[2]).Caption := 'Todo';
    TButton(Dialog.Controls[3]).Caption := 'Selección';
    TButton(Dialog.Controls[4]).Caption := 'Cancelar';

    try
      case Dialog.ShowModal of
        mrYes:
          begin
            if (MessageDlg('Va a imprimir las etiquetas de TODOS los pedidos filtrados, ¿desea continuar?', mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes) then
              todos := True
            else
              cancelado := true;
          end;
        mrNo:
          begin
            if (MessageDlg('Va a imprimir las etiquetas de los pedidos SELECCIONADOS, ¿desea continuar?', mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes) then
              todos := False
            else
              cancelado := true;
          end;
        mrCancel:
          cancelado := true;
      end;
    finally
      Dialog.Free;
    end;
  end;

  if not cancelado then
  begin
    if todos then    //generar todos los pedidos
    begin
      with dm.q_peds do
      try
        First;

        if not IsEmpty then
        begin
          pedidos := '';
          First;
          while not eof do
          begin
            pedidos := pedidos + FieldByName('id_pedido').AsString + ',';
            Next;
          end;

                //pedidos := Copy(pedidos,1,Length(pedidos)-1);
        end
        else
          ShowMessage('No existen pedidos a generar.');
      finally
        free;
      end;
    end
    else
    begin  //generar solo seleccionados
      pedidos := '';

      for i := 0 to gr_envs.SelCount - 1 do
      begin
        gr_envs.GotoSelection(i);
        pedidos := pedidos + dm.q_peds.FieldByName('id_pedido').AsString + ',';
      end;
    end;

    pedidos := Copy(pedidos, 1, Length(pedidos) - 1);

    if pedidos <> '' then
    begin

      pedidos_array := SplitString(pedidos, ',');
      log_envio := '';

      for i := Low(pedidos_array) to High(pedidos_array) do
      begin
        codalbaran := GetAlbaranPedido(StrToInt(pedidos_array[i]));
        

        if codalbaran > 0 then       
        begin

          gestoras_dest := GetAlbaranDestPedido(StrToInt(pedidos_array[i]));
          
          //if CargarDatosTablaGestoras('agencias','lstname_etiqueta','agencia='+ InttoStr(GetRelacionAgencia(dm.q_peds.fieldbyname('id_repartidor').AsInteger)) )='ETI_LOGINSER' then
          if dmLabels.GetFormatoEtiqueta(codalbaran)='ETI_LOGINSER' then
          begin
             dmLabels.imp_eti := u_globals.imp_eti;
             dmLabels.imprime_etiqueta_loginser(codalbaran,gestoras_dest, logo_cli_etiq);
             InsertaLog(u_main.usuario.id,StrToInt(pedidos_array[i]),0,PC.Nombre,PC.IP,log_app,'pedido','',
                       'Et.Lgs. ' + IntToStr(codalbaran),'');
          end
          else begin
             f_detail.imprime_etiqueta_x_api(codalbaran);
             InsertaLog(u_main.usuario.id,StrToInt(pedidos_array[i]),0,PC.Nombre,PC.IP,log_app,'pedido','',
                       'Et.API ' + IntToStr(codalbaran),'');
          end;

         CambiaEstadoPedido(pedidos_array[i], 'G', 'E');
        end;
      end;

    end;

  end
  else
    lb_st1.Caption := 'Proceso cancelado.';

  if log_envio = '' then
    ShowMessage('Proceso de etiquetas finalizado sin errores.')
  else
    ShowMessage(log_envio);

  filter(modo_historico);

  lb_st1.Caption := 'Proceso de etiquetas finalizado.';

  pnPtes.Enabled := True;

end;

procedure Tf_main.btModoHistClick(Sender: TObject);
begin
   // if (HiWord(GetKeyState(VK_CONTROL)) <> 0)then
   // begin


        {  habilita_modo_historico(not modo_historico);
          if not modo_historico then
               mnModoHist.Caption := 'Activa Modo &Histórico'
          else
               mnModoHist.Caption := 'Desactiva Modo &Histórico';
          filter(modo_historico);    }
   // end;

end;

procedure Tf_main.bt2Click(Sender: TObject);
BEGIN
  enviar_email_pedidos(dm.q_peds.FieldByName('id_pedido').asinteger);
  //lb_1.Caption := IntToStr(gr_envs.SelectedRows.Count);
end;

procedure Tf_main.mdAsignaPAVClick(Sender: TObject);
begin
   assign_pav('S', dm.q_peds.FieldByName('id_pedido').asstring);
end;

procedure Tf_main.mdDesasignaPAVClick(Sender: TObject);
begin
   assign_pav('N', dm.q_peds.FieldByName('id_pedido').asstring);
end;


function Tf_main.mensaje(s: string): Boolean;
begin
  try
    if s = '2' then
      raise Exception.Create('kk')
    else
      ShowMessage(s);
  except
    on e: Exception do
      raise Exception.Create('a' + e.Message);

  end;
end;

{
var
  i:integer;
begin
  if gr_envs.SelCount>0 then
     if MessageDlg('Seleccione la opción',mtInformation,[) then


  for I := 0 to gr_envs.SelCount-1 do
  begin
      gr_envs.GotoSelection(i);


      ShowMessage(dm.q_peds.fieldbyname('id_pedido').asstring);
  end;
end;        }

procedure Tf_main.btArchivarHistClick(Sender: TObject);
var
  pedidos, log_archivo: string;
  resultado, todos, cancelado, hasta_fecha: Boolean;
  Dialog: TForm;
  i: Integer;
begin
  if (HiWord(GetKeyState(VK_CONTROL)) <> 0)then
  begin

  If modo_historico then
  begin
     ShowMessage('Desactive el modo histórico para poder realizar esta operación.');
     Exit;
  end;

  InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','Ini.EnvioHist','');

  pnPtes.Enabled := False;

  resultado := True;

  cancelado := False;
  todos := false;
  hasta_fecha := false;

  Dialog := CreateMessageDialog('¿Qué pedidos desea archivar?', mtWarning, [mbYes, mbNo, mbAll, mbCancel]);
  Dialog.Width := 265;
  Dialog.Height := 170;
  TButton(Dialog.Controls[2]).Enabled := not (dm.q_peds.isempty);
  TButton(Dialog.Controls[2]).Caption := 'Filtro';

  TButton(Dialog.Controls[3]).Enabled :=  (gr_envs.SelectedRows.Count>0);
  TButton(Dialog.Controls[3]).Caption := 'Selección';

  TButton(Dialog.Controls[5]).Width := 237;
  TButton(Dialog.Controls[5]).left := 12;
  TButton(Dialog.Controls[5]).top := 100;
  TButton(Dialog.Controls[5]).Caption := 'Todo hasta el ' + FormatDateTime('dd/mm/yyyy',Today-edDiasAtras.Value);

  //TButton(Dialog.Controls[4]).Left := 330;
  TButton(Dialog.Controls[4]).Caption := 'Cancelar';

  try
    case Dialog.ShowModal of
      mrYes:
        begin
          if (MessageDlg('Va a archivar TODOS los pedidos filtrados, ¿desea continuar?', mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes) then
            todos := True
          else
            cancelado := true;
        end;
      mrNo:
        begin
          if (MessageDlg('Va a archivar los pedidos SELECCIONADOS, ¿desea continuar?', mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes) then
            todos := False
          else
            cancelado := true;
        end;
      mrAll:
        begin
          if (MessageDlg('Va a archivar los pedidos hasta el ' + FormatDateTime('dd/mm/yyyy',Today-edDiasAtras.Value) + ' , ¿desea continuar?', mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes) then
            hasta_fecha := true
          else
            cancelado := true;
        end;
      mrCancel:
        cancelado := true;
    end;
  finally
    Dialog.Free;
  end;

  if not cancelado then
  begin
    if todos then    //generar todos los pedidos
    begin
      with dm.q_peds do
      try
        First;

        if not IsEmpty then
        begin
          pedidos := '';
          First;
          while not eof do
          begin
            pedidos := pedidos + FieldByName('id_pedido').AsString + ',';
            Next;
          end;

                //pedidos := Copy(pedidos,1,Length(pedidos)-1);
        end
        else
          ShowMessage('No existen pedidos a generar.');
      finally
        //free;
      end;
    end
    else if not hasta_fecha then
         begin  //generar solo seleccionados
            pedidos := '';

            for i := 0 to gr_envs.SelCount - 1 do
            begin
              gr_envs.GotoSelection(i);
              pedidos := pedidos + dm.q_peds.FieldByName('id_pedido').AsString + ',';
            end;
         end;

    pedidos := Copy(pedidos, 1, Length(pedidos) - 1);

    log_archivo := '';

    Screen.Cursor := crHourGlass;

    if pedidos <> '' then
         log_archivo := ArchivarAHistorico(pedidos,Today-edDiasAtras.Value)
    else if hasta_fecha then
         log_archivo := ArchivarAHistorico('',Today-edDiasAtras.Value);

    Screen.Cursor := crDefault;
  end
  else begin
    InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','EnvioHist.CanceladoPorUsuario','');
    lb_st1.Caption := 'Proceso cancelado.';
  end;

  if cancelado then
      ShowMessage('Proceso de archivado cancelado.')
  else if log_archivo = '' then
          ShowMessage('Proceso de archivado finalizado sin errores.')
       else
          ShowMessage(log_archivo);

  InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','Fin.EnvioHist',log_archivo);

  filter(modo_historico);

  lb_st1.Caption := 'Proceso de archivado finalizado.';

  pnPtes.Enabled := True;

  end;
end;


procedure Tf_main.enviar_email_pedidos(id_pedido: integer);
var
  ruta, dest, asunto: string;
  email: Tf_envia_mail;
  cuerpo: tstrings;
begin
  try
    ruta := '';

    cuerpo := tstringlist.Create;

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
      email := Tf_envia_mail.create(self);
      email.Show;
      email.envia_email(dest, copia_oculta, asunto, ruta, mail_from, cuerpo);

      inserta_pedido_extra(id_pedido,'DATE_MAIL_DEST',Copy(
            'dest='+dest+'|cco='+copia_oculta+'|asunto='+asunto+'|ruta='+ruta+'|cuerpo='+cuerpo[0],1,200));

      insertalog(usuario.id,id_pedido,0,PC.Nombre, PC.IP,log_app,'pedido','','EnvioMailDest.Ped='+inttostr(id_pedido),
            'dest='+dest+'|cco='+copia_oculta+'|asunto='+asunto+'|ruta='+ruta+'|cuerpo='+cuerpo[0]);
    end;
  finally
    cuerpo.Free;
    email.close;
    email.Free;
  end;
end;

procedure Tf_main.InsertaPedidoLine(id_pedido, id_line, id_articulo, cantidad, item_id: integer; sku, nombre_art: string);
begin
  dm.q_1.Close;
  dm.q_1.sql.Clear;
  dm.q_1.sql.Add('insert into c_pedidos_lines (id_pedido, id_line, id_articulo, cantidad,sku,nombre_art,item_id, kgs) ' + 'values (:id_pedido, :id_line, :id_articulo, :cantidad, :sku, :nombre_art,:item_id,0)');
  dm.q_1.ParamByName('id_pedido').AsInteger := id_pedido;
  dm.q_1.ParamByName('id_line').AsInteger := id_line;
  dm.q_1.ParamByName('id_articulo').asinteger := id_articulo;
  dm.q_1.ParamByName('cantidad').asinteger := cantidad;
  dm.q_1.ParamByName('sku').AsString := sku;
  dm.q_1.ParamByName('nombre_art').AsString := nombre_art;
  dm.q_1.ParamByName('item_id').AsInteger := item_id;
  dm.q_1.ExecQuery;
end;

procedure Tf_main.InsertaPedido(id_pedido, id_cliente, deliv_time, trans_propio, id_repartidor, deleg, service_ref, con_retorno: Integer; id_order, order_name, nombre, dir, poblacion, provincia, prov_code, cp, pais, pais_code, telefono, email, text, track, observaciones, financial_status, fulfillment_status, gateway, company, tags, note, cancel_reason, estado, contacto, ceco: string; fecha_ped, cancel_date: TDateTime; reemb: Double);
begin
  dm.q_1.Close;
  dm.q_1.sql.Clear;
  dm.q_1.sql.Add('insert into c_pedidos ' +
    '(id_pedido,id_cliente, id_order, order_name, nombre, dir_1, poblacion, provincia, prov_code, cp, pais, pais_code, ' +
    ' fecha_ped, telefono, email, delivery_time,text, tracking_number, ' +
    'transporte, id_repartidor, reembolso, observaciones, delegacion_dst, ' +
    'financial_status, fulfillment_status, gateway, company, tags, note, service_ref, cancelled_at, cancel_reason, estado, con_retorno, contacto, id_almacen, ceco) ' +
    'values (:id_pedido,:id_cliente, :id_order, :order_name, :nombre, :dir_1, :poblacion, :provincia, :prov_code, :cp, :pais, :pais_code, ' +
    ':fecha_ped, :telefono, :email, :delivery_time, :text, :tracking_number, ' + 
    ':transporte, :id_repartidor, :reemb, :observaciones, :deleg, ' +
    ':financial_status, :fulfillment_status, :gateway, :company, :tags, :note, :service_ref,  ' +
    ':cancelled_at, :cancel_reason, :estado, :con_retorno, :contacto, :id_almacen, :ceco)');
  dm.q_1.ParamByName('id_cliente').AsInteger := id_cliente;
  dm.q_1.ParamByName('id_pedido').AsInteger := id_pedido;
  dm.q_1.ParamByName('id_order').asstring := id_order;
  dm.q_1.ParamByName('order_name').asstring := order_name;
  dm.q_1.ParamByName('nombre').asstring := nombre;
  dm.q_1.ParamByName('dir_1').asstring := dir;
  dm.q_1.ParamByName('poblacion').asstring := poblacion;
  dm.q_1.ParamByName('provincia').asstring := provincia;
  dm.q_1.ParamByName('prov_code').asstring := prov_code;
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
  if estado = '' then
    estado := 'P';
  dm.q_1.ParamByName('estado').asstring := estado;
  dm.q_1.ParamByName('service_ref').AsInteger := service_ref;
  dm.q_1.ParamByName('con_retorno').AsInteger := con_retorno;
  dm.q_1.ParamByName('contacto').asstring := contacto;
  dm.q_1.ParamByName('id_almacen').AsInteger := id_almacen;
  dm.q_1.ParamByName('ceco').asstring := ceco;
  dm.q_1.ExecQuery;
end;

function Tf_main.rellena_detalle_pedido: string;
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
      Stream := dm.q_detail.CreateBlobStream(dm.q_detail.FieldByName('imagen'), TBlobStreamMode.bmRead);

      imagen.LoadFromStream(Stream);
      imagen.SaveToFile('c:\temp\img.jpg');
       //Megacutre, pero... :(
       //Si el artículo es zapatilla, al artículo incluirá la palabra "talla"
      if Pos('Talla', dm.q_detail.FieldByName('nombre').AsString) > 0 then
      begin
        detail := detail +
                   //'<img src="c:\temp\img.jpg" width=100 align="center"> ' +
          Copy(dm.q_detail.FieldByName('nombre').AsString, 0, Length(dm.q_detail.FieldByName('nombre').AsString) - 8) + ' - ' + Copy(dm.q_detail.FieldByName('nombre').AsString, Length(dm.q_detail.FieldByName('nombre').AsString) - 1, Length(dm.q_detail.FieldByName('nombre').AsString)) + ' - ' + dm.q_detail.FieldByName('cantidad').AsString + '<br>';
      end
      else //Si el artículo es mochila, al artículo incluirá la palabra "Ualabi" (indicado por Flamnigos)
if Pos('Ualabi', dm.q_detail.FieldByName('nombre').AsString) > 0 then
      begin
        detail := detail +
                             //'<img src="c:\temp\img.jpg" width=100 align="center"> ' +
          Copy(dm.q_detail.FieldByName('nombre').AsString, 0, Pos('-', dm.q_detail.FieldByName('nombre').AsString) - 1) + ' - ' + dm.q_detail.FieldByName('cantidad').AsString + '<br>';
      end
      else
      begin
        detail := detail +
                             //'<img src="c:\temp\img.jpg" width=100 align="center"> ' +
          dm.q_detail.FieldByName('nombre').AsString + ' - ' + dm.q_detail.FieldByName('cantidad').AsString + '<br>';
      end;

      dm.q_detail.Next;
    end;

    if FieldByName('pais_code').AsString = 'ES' then
    begin
      detail := detail + '<br>Este es tu número de seguimiento para saber en todo momento donde está tu pedido. Se ha enviado por medio de Correos: <br> ' + '<b>' + dm.q_detail.FieldByName('cod_envio').AsString + '</b><br><br> ' + 'Puedes conocer el estado del envío en el siguiente enlace:<br>' + '<a href="http://www.correos.es/ss/Satellite/site/aplicacion-4000003383089-herramientas_y_apps/detalle_app-sidioma=es_ES?numero=' + dm.q_detail.FieldByName('cod_envio').AsString + '">Seguimiento del pedido</a>';
    end
    else
    begin
      detail := detail + '<br>This is the tracking number in order to know at any time the status of your order. Your order has been dispatched by the shipping company Correos: <br> ' + '<b>' + dm.q_detail.FieldByName('cod_envio').AsString + '</b><br><br> ' + 'You can check the order status through the following link:<br>' + '<a href="http://www.correos.es/ss/Satellite/site/aplicacion-4000003383089-herramientas_y_apps/detalle_app-sidioma=es_ES?numero=' + dm.q_detail.FieldByName('cod_envio').AsString + '">Order tracking</a>';
    end;

    Stream.Free;
  end;

  Result := detail;

end;

procedure Tf_main.Imprime(f, orientacion: string);
{var
  MemoryStream1: TMemoryStream;  }
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

function Tf_main.JSONPost(text: string; LI: boolean): string;
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
        result := ResponseBody;
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

procedure Tf_main.lbClienteDblClick(Sender: TObject);
begin
    if locked then
      abre_config_cliente;
end;

procedure Tf_main.gr_detalleDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if not modo_historico then
  begin
    if (Column.FieldName='SKU') and (dm.q_peds.FieldByName('estado').AsString = 'X') then
    begin
       If (get_stock_x_art(Column.Field.DataSet.FieldByName('id_articulo').AsInteger,id_almacen,StrToInt(cl_hijos[0]))<f_main.get_total_x_art_y_ped(Column.Field.DataSet.FieldByName('id_articulo').AsInteger,dm.q_peds.FieldByName('id_pedido').AsInteger)) then
           (Sender as TDBGrid).canvas.Font.Color := clRed
       else
           (Sender as TDBGrid).canvas.Font.Color := clBlack;
    end else
           (Sender as TDBGrid).canvas.Font.Color := clBlack;

       gr_detalle.DefaultDrawColumnCell(Rect,DataCol,Column,State);
  end else begin
            (Sender as TDBGrid).canvas.Font.Color := clRed;
            gr_detalle.DefaultDrawColumnCell(Rect,DataCol,Column,State);
      end;
end;

procedure Tf_main.GuardaEtiqueta(pedidos: string; txt: string; agencia: integer);
var
  linea, pedido: TStringDynArray;
  i: Integer;
  datos: string;
begin

  linea := splitstring(txt, '|');
  pedido := splitstring(pedidos, ',');
  datos := '';

  if linea[0] <> '0' then
  begin
      { case StrToInt(linea[0]) of
          //null: ShowMessage('Se ha producido un error (' + linea[0] + ').');

       end;  }

    Exit;
  end;

  dm.t_write.StartTransaction;
  try
    for i := Low(pedido) to High(pedido) do
    begin

      dm.q_1.Close;
      dm.q_1.sql.Clear;
      dm.q_1.sql.Add('insert into c_pedidos_etiquetas ' + '(id_pedido, num_bulto, fecha_operacion, cod_expedicion, cod_etiquetador, cod_envio, ruta_pdf) ' + 'values (:id_pedido, :num_bulto, :fecha_operacion, :cod_expedicion, :cod_etiquetador, :cod_envio, :ruta_pdf)');
      dm.q_1.ParamByName('id_pedido').AsInteger := StrToInt(pedido[i]);
      dm.q_1.ParamByName('num_bulto').AsInteger := 1; //StrToInt(linea[0000000]);

      datos := 'id_ped:' + pedido[i];

      if agencia = agencia_correos then
      begin
        dm.q_1.ParamByName('fecha_operacion').AsDateTime := encodedatetime(strtoint(Copy(linea[2], 7, 4)), strtoint(Copy(linea[2], 4, 2)), StrToInt(Copy(linea[2], 1, 2)), StrToInt(Copy(linea[2], 12, 2)), StrToInt(Copy(linea[2], 15, 2)), StrToInt(Copy(linea[2], 18, 2)), 0); //StrToDate(linea[3]);
        dm.q_1.ParamByName('cod_etiquetador').AsString := '4BCC'; //Copy(linea[2],4,4);
        dm.q_1.ParamByName('cod_expedicion').AsString := linea[1];
        dm.q_1.ParamByName('cod_envio').AsString := linea[3];
        dm.q_1.ParamByName('ruta_pdf').AsString := path_pdf_correos + linea[3] + '.pdf';
        dm.q_1.ExecQuery;

        datos := datos + ',cod_expedicion:' + linea[1] + '|cod_envio:' + linea[3] + '|ruta_pdf:' + path_pdf_correos + linea[3] + '.pdf';

        if linea[4] <> '' then
        begin
          dm.q_1.ParamByName('cod_envio').AsString := linea[4];
          dm.q_1.ParamByName('ruta_pdf').AsString := path_pdf_correos + linea[4] + '.pdf';
          dm.q_1.ExecQuery;

          datos := datos + '|cod_envio:' + linea[4] + '|ruta_pdf:' + path_pdf_correos + linea[4] + '.pdf';
        end;
      end
      else
      begin
        dm.q_1.ParamByName('fecha_operacion').AsDateTime := Now;
        dm.q_1.ParamByName('ruta_pdf').AsString := linea[1];
        dm.q_1.ExecQuery;

        datos := datos + '|ruta_pdf:' + linea[1];
      end;
    end;

    dm.t_write.CommitRetaining;

    InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','Et.InsertBBDD.Ped:' + pedido[i],datos)

       {  if ((dm.q_peds.FieldByName('PAIS_CODE').AsString='ES') or (dm.q_peds.FieldByName('PAIS_CODE').AsString='PT')) then
         begin
            ImprimeEtiqueta(linea[3] + '.pdf','H');
            if linea[4]<>'' then
                  ImprimeEtiqueta(linea[4] + '.pdf','H');
         end else
            ImprimeEtiqueta(linea[3] + '.pdf','V');  }
  except
    dm.t_write.RollbackRetaining;
  end;
end;

procedure Tf_main.imgIncidenciasDblClick(Sender: TObject);
begin
  imgIncidencias.Visible := false;
  tmr2.Enabled := False;
end;

procedure Tf_main.btClienteClick(Sender: TObject);
begin
  with fbuscapro do
  begin
    limpia_fields;
    multiselect := false;
    livekey := false;
    fields.commatext := 'id_cliente,nombre';
    titulos.commatext := 'Código,Nombre';
    from := 'g_clientes ';
    //where := '((estado=''A'') or ((id_cliente=) and (id_cliente<=5199)))';
    //where := '(estado=''A'')';
    orden[1] := 1;
    busca := 2;
    distinct := 0;
    fillimpio := True;
    row_height := 17;

    showmodal;

    if resultado then
    begin
      with Sender as TsSpeedButton do
      begin
        edCliente.text := valor[1];
        //lbCliente.caption := UpperCase(valor[2]);
        lbCliente.caption := get_nombre_cliente(StrToInt(valor[1]));

        filter(modo_historico);
      end;
    end;
  end;

  btLock.Enabled := (lbCliente.Caption <> '(Seleccione un cliente)');

end;

procedure Tf_main.btLockClick(Sender: TObject);
begin
  locked := not locked;
  btLock.ImageIndex := Integer(locked);
  rgTipoGes.Enabled := not locked;
  gbGrupo.Enabled := not locked;
  gbCliente.Enabled := not locked;
//  edCliente.Enabled := not locked;
//  btCliente.Enabled := not locked;
  pnFiltro.Enabled := locked;
  gr_envs.Enabled := locked;
  pnTools.Enabled := locked;
  btStock0.Enabled := locked;

  habilita_menus(locked,modo_historico);


  if locked then
  begin
    case rgTipoGes.ItemIndex of
      0:
        lbCliente.Font.Color := 16;
      1:
        lbgrupo.Font.Color := 16;
    end;


    CargaInterfaz;

    lbCliente.Hint := '';
    lbCliente.ShowHint := False;

    if StrToInt(cl_padres[0])>=0 then
    begin
       lbCliente.Font.Color := clYellow;
       lbCliente.Hint := get_nombre_cliente(StrToInt(cl_padres[0]));
       lbCliente.ShowHint := True;
    end;

    if StrToInt(cl_hijos[0])>=0 then
    begin
       lbCliente.Font.Color := clGreen;
       lbCliente.Hint := get_nombre_cliente(StrToInt(cl_hijos[0]));
       lbCliente.ShowHint := True;
    end;

   { if main_cli=7252 then
    begin
       if (MessageDlg('Se van a actualizar el seguiminto de UPS para UK y US, ¿desea continuar?', mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes) then
       begin
           Screen.Cursor := crHourglass;
           dm_flam.cod_cli := main_cli;
           dm_flam.procesaficheros;
           Screen.Cursor := crDefault;
       end;
    end;  }

    filter(modo_historico);
  end
  else
  begin
    case rgTipoGes.ItemIndex of
      0:
        lbCliente.Font.Color := 255;
      1:
        lbgrupo.Font.Color := 255;
    end;
    dm.q_peds.Close;

  end;

  cbAlmacenes.Visible := locked;

  if not cbAlmacenes.Visible then
    id_almacen := -1;

  btConfigCliente.Enabled := locked;
end;

procedure Tf_main.btLotesClick(Sender: TObject);
var
  art_actual, alb_actual, i, j: Integer;
  peds_act, peds_list: string;
  Dialog: TForm;
  todos, cancelado: boolean;
  pedidos: TStringList;
  id_art_padre: Integer;
begin
  InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','Ini.BtActLt.','');

  pnPtes.Enabled := False;

  todos := true;
  cancelado := False;

  peds_list := '';

  if gr_envs.SelCount > 0 then
  begin
    todos := false;
    Dialog := CreateMessageDialog('Existe una selección. ¿Para qué pedidos desea actualizar lotes?', mtWarning, [mbYes, mbNo, mbCancel]);

    TButton(Dialog.Controls[2]).Caption := 'Todo';
    TButton(Dialog.Controls[3]).Caption := 'Selección';
    TButton(Dialog.Controls[4]).Caption := 'Cancelar';

    try
      case Dialog.ShowModal of
        mrYes:
          begin
            if (MessageDlg('Va a actualizar los lotes de TODOS los pedidos, ¿desea continuar?', mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes) then
              todos := True
            else
              cancelado := true;
          end;
        mrNo:
          begin
            if (MessageDlg('Va a actualizar los lotes del pedido SELECCIONADO, ¿desea continuar?', mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes) then
              todos := False
            else
              cancelado := true;
          end;
        mrCancel:
          cancelado := true;
      end;
    finally
      Dialog.Free;
    end;
  end;

  if not cancelado then
  begin
    try

      with dm.ds_1 do
      begin
        close;
        SelectSQL.Clear;
        SelectSQL.Add('select distinct p.id_pedido, p.codalbaran, l.id_articulo ' +
                      'from c_pedidos p ' +
                      'inner join c_pedidos_lines l on p.id_pedido=l.id_pedido ' +
                      'left outer join c_pedidos_lines_lotes lt on l.id_pedido=lt.id_pedido and l.id_articulo=lt.id_articulo ' +
                      'where p.id_cliente=:id_cliente and p.codalbaran>0 and ' +
                      'lt.id_pedido is null and lt.id_articulo is null and p.codalbaran>19000000 ');
        if not todos then
        begin
           peds_list := '';

          for i := 0 to gr_envs.SelCount - 1 do
          begin
            gr_envs.GotoSelection(i);
            peds_list := peds_list + dm.q_peds.FieldByName('id_pedido').AsString + ',';
          end;

          if peds_list<>'' then
              peds_list := Copy(peds_list, 0, Length(peds_list) - 1);

          {SelectSQL.Add(' and p.id_pedido=:id_pedido');
          ParamByName('id_pedido').AsInteger := dm.q_peds.FieldByName('id_pedido').AsInteger;
          }
          SelectSQL.Add(' and p.id_pedido in (' + peds_list + ')');

        end;

        SelectSQL.Add('order by 1');

        ParamByName('id_cliente').AsInteger := StrToInt(edCliente.Text);
        Open;

        peds_act := '';
        art_actual := -1;
        alb_actual := -1;

        if not IsEmpty then
        begin
          dm.t_write.StartTransaction;

          First;

          while not Eof do
          begin
            if ((art_actual <> FieldByName('id_articulo').AsInteger) or (alb_actual <> FieldByName('codalbaran').AsInteger)) then
            begin
              art_actual := FieldByName('id_articulo').AsInteger;
              alb_actual := FieldByName('codalbaran').AsInteger;

              if FieldByName('codalbaran').AsInteger > 0 then
              begin
               InsertaLog(usuario.id,dm.q_peds.FieldByName('id_pedido').AsInteger,0,PC.Nombre,PC.IP,log_app,'pedido','','BtActLt.CopiaLtDePick.',
                         'Ped.'+FieldByName('id_pedido').AsString+'|Alb.'+FieldByName('codalbaran').AsString+'|Art.'+FieldByName('id_articulo').AsString);

                if StrToInt(cl_padres[0])<0 then
                    peds_act := CopiaLoteDePicking(FieldByName('id_pedido').AsInteger,FieldByName('codalbaran').AsInteger,FieldByName('id_articulo').AsInteger,-1)
                else begin
                  i := 0;
                  id_art_padre := -1;
                  while ((id_art_padre<=0) and (i<=High(cl_padres))) do
                   begin
                      id_art_padre := busca_art(get_codcli_art(FieldByName('id_articulo').asinteger),StrToInt(cl_padres[i]));
                      Inc(i);
                   end;

                    if id_art_padre>=0 then
                      peds_act := CopiaLoteDePicking(FieldByName('id_pedido').AsInteger,FieldByName('codalbaran').AsInteger,FieldByName('id_articulo').asinteger,id_art_padre);
                end;

              end;
            end;
            Next;
          end;

          dm.t_write.Commit;

          if peds_act <> '' then
          begin
            if chPicking.Checked then
            begin
              InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','BtActLt.ImprHP',Copy(peds_act, 0, Length(peds_act) - 1));
              ImprimirHojasPicking(Copy(peds_act, 0, Length(peds_act) - 1));
            end;

            if revisa_lotes and chEnviarLotes.Checked then
            begin
                lb_st1.Caption := 'Enviando lotes pedidos ' + Copy(peds_act, 0, Length(peds_act) - 1) + ' ...';
                pedidos := TStringList.Create;
                pedidos.Delimiter := ',';
                pedidos.DelimitedText := Copy(peds_act, 0, Length(peds_act) - 1);

                j := 0;
                while (j<=High(cl_padres)) do
                begin
                  frmlotes.EnviaLotes(pedidos,lbCliente.Caption,PC.Nombre,PC.IP,0, StrToInt(cl_padres[j]), cli_api_url, cli_api_user, cli_api_pass);
                  Inc(j);
                end;

                pedidos.Free;
                InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','BtActLt.EnvLts=OK',Copy(peds_act, 0, Length(peds_act) - 1));
                lb_st1.Caption := 'Lotes enviados.';
            end else
                InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','BtActLt.EnvLts=NO_ENVIADOS',Copy(peds_act, 0, Length(peds_act) - 1) + '|' +
                'Param revisa_lotes='+BoolToStr(revisa_lotes,true) + '|' + 'chEnviarLotes.Checked=' + BoolToStr(chEnviarLotes.Checked,true));

            ShowMessage('Lotes actualizados correctamente.');

          end
          else begin
            InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','BtActLt.NoExistenLtParaActualizar','');
            ShowMessage('No existen lotes por actualizar.');
          end;
        end
        else begin
          InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','BtActLt.NoExistenPedsParaActualizar','');
          ShowMessage('No existen pedidos por actualizar.');
        end;
      end;

    except
      dm.t_write.Rollback;
      ShowMessage('Error al actualizar lotes.');
    end;

  end
  else
    lb_st1.Caption := 'Proceso cancelado.';

  pnPtes.Enabled := true;

  InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','Fin.BtActLt.','');

end;

procedure Tf_main.btRegenerarClick(Sender: TObject);
var
  pedidos, log_envio, texto: string;
  resultado, todos, cancelado: Boolean;
  Dialog: TForm;
  i, codalbaran: Integer;
  pedidos_array: TStringDynArray;
  continua: Boolean;
begin
  InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','Ini.BtRegeneraEtiq','');

  pnPtes.Enabled := False;

  resultado := True;

  if rg_state.ItemIndex <> 3 then
  begin
    ShowMessage('Solo puede regenerar pedidos Enviados.');
    Exit;
  end;

  if dm.q_peds.IsEmpty then
  begin
    ShowMessage('No hay pedidos para enviar.');
    Exit;
  end;

  todos := true;
  cancelado := False;

  if gr_envs.SelCount > 0 then
  begin
    todos := false;
    Dialog := CreateMessageDialog('Existe una multiselección. ¿Qué pedidos desea regenerar?', mtWarning, [mbYes, mbNo, mbCancel]);

    TButton(Dialog.Controls[2]).Caption := 'Todo';
    TButton(Dialog.Controls[3]).Caption := 'Selección';
    TButton(Dialog.Controls[4]).Caption := 'Cancelar';

    try
      case Dialog.ShowModal of
        mrYes:
          begin
            if (MessageDlg('Va a regenerar TODOS los pedidos filtrados, ¿desea continuar?', mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes) then
              todos := True
            else
              cancelado := true;
          end;
        mrNo:
          begin
            if (MessageDlg('Va a regenerar los pedidos SELECCIONADOS, ¿desea continuar?', mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes) then
              todos := False
            else
              cancelado := true;
          end;
        mrCancel:
          cancelado := true;
      end;
    finally
      Dialog.Free;
    end;
  end;

  if not cancelado then
  begin
    if todos then    //generar todos los pedidos
    begin
      with dm.q_peds do
      try
        First;

        if not IsEmpty then
        begin
          pedidos := '';
          First;
          while not eof do
          begin
            pedidos := pedidos + FieldByName('id_pedido').AsString + ',';
            Next;
          end;

                //pedidos := Copy(pedidos,1,Length(pedidos)-1);
        end
        else
          ShowMessage('No existen pedidos a generar.');
      finally
        free;
      end;
    end
    else
    begin  //generar solo seleccionados
      pedidos := '';

      for i := 0 to gr_envs.SelCount - 1 do
      begin
        gr_envs.GotoSelection(i);
        pedidos := pedidos + dm.q_peds.FieldByName('id_pedido').AsString + ',';
      end;
    end;

    pedidos := Copy(pedidos, 1, Length(pedidos) - 1);

    if pedidos <> '' then
    begin

      if FechaPedidoMasAntiguo(pedidos) < (Now - aviso_pedidos_antiguos) then
      begin
        continua := (MessageDlg('Va a enviar pedidos generados hace más de ' + IntToStr(aviso_pedidos_antiguos) + ' días, ¿desea continuar?', mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes);
        If continua then
            InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','BtRegeneraEtiq.PreguntaPedsAntiguos.Resp=SI','Anteriores a ' + IntToStr(aviso_pedidos_antiguos) + ' dias. Pedidos:' + pedidos)
        else
            InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','BtRegeneraEtiq.PreguntaPedsAntiguos.Resp=NO','Anteriores a ' + IntToStr(aviso_pedidos_antiguos) + ' dias. Pedidos:' + pedidos)
      end;

      if continua then
      begin
        pedidos_array := SplitString(pedidos, ',');
        log_envio := '';

        for i := Low(pedidos_array) to High(pedidos_array) do
        begin
          codalbaran := GetAlbaranPedido(StrToInt(pedidos[i]));

          if codalbaran > 0 then
          begin

            InsertaLog(usuario.id,StrToInt(pedidos_array[i]),0,PC.Nombre,PC.IP,log_app,'pedido','','BtRegImpr.RegenerandoEtPed.' + pedidos[i],'');

            if u_cam_gl.existe_etiq_tmp(usuario.id, codalbaran) = 0 then
            begin
                  //DMCreaBultos.GeneraBultos(dm.q_peds.FieldByName('codalbaran').AsInteger,dm.q_peds.FieldByName('gestoras_dest').AsInteger);
              dm.t_write_gestoras.StartTransaction;
              try
                u_cam_gl.inserta_etiq_tmp(usuario.id, codalbaran);
                dm.t_write_gestoras.Commit;
              except
                dm.t_write_gestoras.Rollback;
              end;
            end;

            if ValidaAlbaran(IntToStr(codalbaran), texto) then
            begin
              DMLstEtiquetas.ObtenEtiquetas('A', IntToStr(codalbaran), True);

              if texto <> '' then
                raise Exception.Create(texto);
                     // ShowMessage(texto);
            end;
          end;
        end;
      end;
    end;

  end
  else
    lb_st1.Caption := 'Proceso cancelado.';

  if log_envio = '' then
    ShowMessage('Proceso de etiquetas finalizado sin errores.')
  else
    ShowMessage(log_envio);

  InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','Fin.BtRegeneraEtiq','LogErrores=' + log_envio);

  filter(modo_historico);

  lb_st1.Caption := 'Proceso de etiquetas finalizado.';

  pnPtes.Enabled := True;
end;

procedure Tf_main.btSeurClick(Sender: TObject);
var
  fichero: TStringDynArray;
  resultado_guardar_fichero: string;
  enviado_antes: Boolean;
begin

 { if rg_state.ItemIndex <> 2 then
  begin
    ShowMessage('Solo puede enviar pedidos En Preparación.');
    Exit;
  end;
 }
  if dm.q_peds.IsEmpty then
  begin
    ShowMessage('No hay pedidos para enviar.');
    Exit;
  end;

  if not DirectoryExists(ruta_fichero_seur) then
  begin
    ShowMessage('La ruta de ficheros de SEUR GO no existe en su equipo. Por favor, creela e inténtelo de nuevo:' + ln + ruta_fichero_seur);
    Exit;
  end
  else
    deDir.Text := ruta_fichero_seur;

  enviado_antes := False;

  if (gr_envs.SelCount = 1) and tiene_etiquetas(dm.q_peds.FieldByName('id_pedido').AsInteger) then
  begin
    if MessageDlg('El pedido seleccionado ha sido enviado con anterioridad. ¿Desea continuar?', mtWarning, [mbYes, mbNo], 0, mbNo) = mrNo then
      Exit;
  end;

  if MessageDlg('Va a crear el fichero Seur. ¿Desea continuar?', mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes then
  begin
    resultado_guardar_fichero := crear_fichero;
    if resultado_guardar_fichero <> '' then
      fichero := SplitString(resultado_guardar_fichero, '|');
  end;

  if (High(fichero) >= 0) and (fichero[1] <> 'error') then
  begin
    GuardaEtiqueta(fichero[1], '0|' + fichero[0], agencia_seur);

    sMessageDlg('Fichero Seur creado correctamente. ' + fichero[0], mtInformation, [mbok], 0);
    lb_st1.Caption := 'Proceso Finalizado';

  end
  else if (High(fichero) >= 0) and (fichero[1] = 'error') then
  begin
    sMessageDlg('Error al crear fichero de Seur. ' + fichero[0], mtError, [mbok], 0);
    lb_st1.Caption := 'Error al crear fichero.';
  end;

 { if main_cli = 7252 then
   begin
     with TpFIBDataSet.Create(dm) do
     try
       Database:=dm.db;
       sqls.SelectSQL.Add('select * ' +
                          'from cl_flam_params_envio(:pedido) ');
       ParamByName('pedido').AsInteger := dm.q_peds.FieldByName('id_pedido').AsInteger;
       Open;
       envia_email := (FieldByName('envia_email').AsInteger=1);
       link_spa := FieldByName('link_spa').Asstring;
       link_eng := FieldByName('link_eng').Asstring;
       qry_detail := FieldByName('qry_detail').Asstring;
     finally
       Free;
     end;

   end;   }

   {if envia_email and (fieldbyname('email').AsString<>'') then
       f_main.enviar_email_pedidos;}
end;

procedure Tf_main.btSinStockClick(Sender: TObject);
var
  todos, cancelado: Boolean;
  Dialog: TForm;
  pedidos: string;
  i: Integer;
begin
  pnPtes.Enabled := False;

  if (rg_state.ItemIndex <> 1) then
  begin
    ShowMessage('Solo puede imprimir pedidos Sin Stock.');
    Exit;
  end;

  if dm.q_peds.IsEmpty then
  begin
    ShowMessage('No hay pedidos para imprimir.');
    Exit;
  end;

  todos := true;
  cancelado := False;

  if gr_envs.SelCount > 0 then
  begin
    todos := false;
    Dialog := CreateMessageDialog('Existe una multiselección. ¿Qué pedidos desea imprimir?', mtWarning, [mbYes, mbNo, mbCancel]);

    TButton(Dialog.Controls[2]).Caption := 'Todo';
    TButton(Dialog.Controls[3]).Caption := 'Selección';
    TButton(Dialog.Controls[4]).Caption := 'Cancelar';

    try
      case Dialog.ShowModal of
        mrYes:
          begin
            if (MessageDlg('Va a imprimir TODOS los pedidos en pantalla, ¿desea continuar?', mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes) then
              todos := True
            else
              cancelado := true;
          end;
        mrNo:
          begin
            if (MessageDlg('Va a imprimir los pedidos SELECCIONADOS, ¿desea continuar?', mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes) then
              todos := False
            else
              cancelado := true;
          end;
        mrCancel:
          cancelado := true;
      end;
    finally
      Dialog.Free;
    end;
  end;

  if not cancelado then
  begin
    if todos then    //generar todos los pedidos
    begin
      with dm.q_peds do
      begin
        First;

        if not IsEmpty then
        begin
          pedidos := '';
          First;
          while not eof do
          begin
            pedidos := pedidos + dm.q_peds.FieldByName('id_pedido').AsString + ',';
            next;
          end;
        end
        else
          ShowMessage('No existen pedidos a imprimir.');

      end;
    end
    else
    begin  //generar solo seleccionados
      pedidos := '';

      for i := 0 to gr_envs.SelCount - 1 do
      begin
        gr_envs.GotoSelection(i);

        pedidos := pedidos + dm.q_peds.FieldByName('id_pedido').AsString + ',';
      end;
    end;

    pedidos := Copy(pedidos, 1, Length(pedidos) - 1);
    informe_sin_stock(pedidos);

  end
  else
    lb_st1.Caption := 'Proceso cancelado.';

  lb_st1.Caption := 'Proceso de impresión finalizado.';

  pnPtes.Enabled := True;
end;

procedure Tf_main.btStock0Click(Sender: TObject);
begin
    if (MessageDlg('Se eliminarán las lineas definitivamente. ¿Desea continuar?',mtWarning, [mbYes, mbNo], 0, mbNo) = mrNo) then
    begin
        InsertaLog(usuario.id,dm.q_peds.fieldbyname('id_pedido').asinteger,0,PC.Nombre,PC.IP,log_app,'','','Bt.DelLinesStk0.Resp=No','Se eliminaran las lineas definitivamente. ¿Desea continuar?');
        Exit;
    end else
        InsertaLog(usuario.id,dm.q_peds.fieldbyname('id_pedido').asinteger,0,PC.Nombre,PC.IP,log_app,'','','Bt.DelLinesStk0.Resp=Si','Se eliminaran las lineas definitivamente. ¿Desea continuar?');

    DeleteLinesStock0;
end;

procedure Tf_main.btEnvAgenciasClick(Sender: TObject);
var
  pedidos, okerror_envio, log_envio: string;
  resultado, todos, cancelado, pedir_etiq: Boolean;
  Dialog: TForm;
  i: Integer;
  pedidos_array: TStringDynArray;
  continua: Boolean;
  pedidos_list: TStringList;
begin

  InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','Ini.BtRegImprEtiq','');

  pnPtes.Enabled := False;

  resultado := True;

  if rg_state.ItemIndex <> 2 then
  begin
    ShowMessage('Solo puede enviar pedidos Generados.');
    Exit;
  end;

  if dm.q_peds.IsEmpty then
  begin
    ShowMessage('No hay pedidos para enviar.');
    Exit;
  end;

  todos := true;
  cancelado := False;

  if gr_envs.SelCount > 0 then
  begin
    todos := false;
    Dialog := CreateMessageDialog('Existe una multiselección. ¿Qué pedidos desea enviar?', mtWarning, [mbYes, mbNo, mbCancel]);

    TButton(Dialog.Controls[2]).Caption := 'Todo';
    TButton(Dialog.Controls[3]).Caption := 'Selección';
    TButton(Dialog.Controls[4]).Caption := 'Cancelar';

    try
      case Dialog.ShowModal of
        mrYes:
          begin
            if (MessageDlg('Va a enviar TODOS los pedidos En preparación, ¿desea continuar?', mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes) then
              todos := True
            else
              cancelado := true;
          end;
        mrNo:
          begin
            if (MessageDlg('Va a enviar los pedidos SELECCIONADOS, ¿desea continuar?', mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes) then
              todos := False
            else
              cancelado := true;
          end;
        mrCancel:
          cancelado := true;
      end;
    finally
      Dialog.Free;
    end;
  end;

  if not cancelado then
  begin

    if todos then    //imprimir todos los pedidos
    begin
      with dm.q_peds do
      try
        First;

        if not IsEmpty then
        begin
          pedidos := '';
          First;
          while not eof do
          begin
                   //es_flam_eeuu := ((FieldByName('id_cliente').AsInteger=7252) and (FieldByName('pais_code').AsString='US'));

                   //if not es_flam_eeuu then
                   //begin
            dm.dsPedirEtiqueta.Close;
            dm.dsPedirEtiqueta.ParamByName('id_pedido').AsInteger := FieldByName('id_pedido').AsInteger;
            dm.dsPedirEtiqueta.Open;
            pedir_etiq := (dm.dsPedirEtiqueta.FieldByName('ok').AsInteger > 0);
            if pedir_etiq then
              pedidos := pedidos + FieldByName('id_pedido').AsString + ',';
                   //end;
            Next;
          end;

                //pedidos := Copy(pedidos,1,Length(pedidos)-1);
        end
        else
          ShowMessage('No existen pedidos a generar.');
      finally
        //free;
      end;
    end
    else
    begin  //generar solo seleccionados
      pedidos := '';

      for i := 0 to gr_envs.SelCount - 1 do
      begin

        gr_envs.GotoSelection(i);

                        //es_flam_eeuu := ((dm.q_peds.FieldByName('id_cliente').AsInteger=7252) and (dm.q_peds.FieldByName('pais_code').AsString='US'));

                        //if not es_flam_eeuu then
                        //begin
        dm.dsPedirEtiqueta.Close;
        dm.dsPedirEtiqueta.ParamByName('id_pedido').AsInteger := dm.q_peds.FieldByName('id_pedido').AsInteger;
        dm.dsPedirEtiqueta.Open;
        pedir_etiq := (dm.dsPedirEtiqueta.FieldByName('ok').AsInteger > 0);
        if pedir_etiq then
          pedidos := pedidos + dm.q_peds.FieldByName('id_pedido').AsString + ',';
                        //end;
      end;
    end;

    pedidos := Copy(pedidos, 1, Length(pedidos) - 1);

    continua := True;
    if (pedidos='') then
       continua := False
    else
    if FechaPedidoMasAntiguo(pedidos) < (Now - aviso_pedidos_antiguos) then
    begin
      continua := (MessageDlg('Va a enviar pedidos generados hace más de ' + IntToStr(aviso_pedidos_antiguos) + ' días, ¿desea continuar?', mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes);
      If continua then
          InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','BtRegImpr.PreguntaPedsAntiguos.Resp=SI','Anteriores a ' + IntToStr(aviso_pedidos_antiguos) + ' dias. Pedidos:' + pedidos)
      else
          InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','BtRegImpr.PreguntaPedsAntiguos.Resp=NO','Anteriores a ' + IntToStr(aviso_pedidos_antiguos) + ' dias. Pedidos:' + pedidos)
    end;

    if continua then
    begin

      pedidos_array := SplitString(pedidos, ',');
      log_envio := '';
      pedidos_list := tstringlist.Create();

      for i := Low(pedidos_array) to High(pedidos_array) do
      begin
        dm.t_write.StartTransaction;

        InsertaLog(usuario.id,StrToInt(pedidos_array[i]),0,PC.Nombre,PC.IP,log_app,'pedido','','BtRegImpr.EnviandoPed.' + pedidos_array[i],'');

        okerror_envio := EnviaPedido(StrToInt(pedidos_array[i])) + '#13#10';

        if (Pos('OK', okerror_envio) > 0) then
        begin

          pedidos_list.Add(pedidos_array[i]);

          InsertaLog(usuario.id,StrToInt(pedidos_array[i]),0,PC.Nombre,PC.IP,log_app,'pedido','','BtRegImpr.GuardaEt.' + pedidos_array[i],'');

          GuardaEtiqueta(pedidos_array[i], '0|Etiqueta en Gestoras o en detalle del pedido.', -1);

          dm.q_1.Close;
          dm.q_1.sql.Clear;
          dm.q_1.sql.Add('update c_pedidos set estado=''E'',fecha_fin=:fecha_fin, enviado=''S'' where estado=''G'' and id_cliente=:id_cliente ');

          if pedidos_array[i] <> '' then
            dm.q_1.sql.Add('and id_pedido in (' + pedidos_array[i] + ')');

          dm.q_1.ParamByName('fecha_fin').asdatetime := now;
          dm.q_1.ParamByName('id_cliente').AsInteger := StrToInt(edCliente.Text);
          dm.q_1.ExecQuery;

          dm.t_write.Commit;

          InsertaLog(usuario.id,StrToInt(pedidos_array[i]),0,PC.Nombre,PC.IP,log_app,'pedido','','BtRegImpr.ActEst=E.' + pedidos_array[i],'');

          lb_st1.Caption := GetOrderNamePedido(StrToInt(pedidos_array[i])) + ' enviado correctamente.';

        end
        else if Pos('EXISTE', okerror_envio) > 0 then
        begin
          log_envio := log_envio + GetOrderNamePedido(StrToInt(pedidos_array[i])) + ' EXISTE' + #13#10;
          dm.t_write.Commit;
          InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','BtRegImpr.EnvErrorPed.' + pedidos_array[i],'Ya existe la etiqueta en BBDD');
        end
        else
        begin
          dm.t_write.rollback;
          lb_st1.Caption := 'ERROR' + pedidos_array[i];
          log_envio := log_envio + GetOrderNamePedido(StrToInt(pedidos_array[i])) + ' ERROR' + #13#10;
          InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','BtRegImpr.EnvErrorPed.' + pedidos_array[i],okerror_envio);
        end;
      end;

      if revisa_lotes then
      begin

        try
          InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','BtRegImpr.IniActLts.','Peds:' + pedidos);
          i := 0;
          while (i<=High(cl_padres)) do
          begin
            frmLotes.ActualizaLotes(main_cli,StrToInt(cl_padres[i]),usuario.id,pedidos_list,'',PC.Nombre,PC.IP);
            Inc(i);
          end;
          InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','BtRegImpr.FinActLts.','Peds:' + pedidos);
        except on e:exception do
          begin
            InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','',
                       'BtRegImpr.ErrorActLts',pedidos + ' Error: ' + e.Message);
            dm.t_write.rollback;
          end;
        end;

        dm.t_write.StartTransaction;
        try
          InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','',
                     'BtRegImpr.Ini envio lotes a cliente',pedidos);

          i := 0;
          while (i<=High(cl_padres)) do
          begin
            frmlotes.EnviaLotes(pedidos_list,lbCliente.Caption,PC.Nombre,PC.IP,1,StrToInt(cl_padres[i]),cli_api_url, cli_api_user, cli_api_pass);
            Inc(i);
          end;

          dm.t_write.Commit;

          InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','',
                     'BtRegImpr.Fin envio lotes a cliente',pedidos);
        except on e:exception do
          begin
            InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','',
                       'BtRegImpr.Error envio lotes a cliente',pedidos + ' Error: ' + e.Message);
            dm.t_write.rollback;
          end;
        end;
      end;

      FreeAndNil(pedidos_list);
      end;
  end
  else begin
    lb_st1.Caption := 'Proceso cancelado.';
    InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','BtRegImpr.Proceso Cancelado por usuario','');
    ShowMessage('Proceso cancelado.');
  end;

  if log_envio = '' then begin
    InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','Fin.BtRegImpr.OK.','');
    ShowMessage('Proceso de etiquetas finalizado sin errores.');
  end
  else begin
    InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','BtRegImpr.Informe errores',log_envio);
    ShowMessage(log_envio);
  end;

  filter(modo_historico);

  lb_st1.Caption := 'Proceso de etiquetas finalizado.';

  pnPtes.Enabled := True;
end;


procedure Tf_main.btEnviarLotesClick(Sender: TObject);
var
  pedidos: string;
  Dialog: TForm;
  i: integer;
  todos, cancelado: boolean;
  peds: TStringList;
begin
Screen.Cursor := crHourglass;

  pnPtes.Enabled := False;

   {Si se trabaja por grupo hay que recorrer todos los clientes del grupo y descargar los pedidos de cada uno}
  if rgTipoGes.ItemIndex = 1 then
  begin
    with tpfibdataset.Create(dm) do
    begin
      database := dm.db;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select distinct c.id_cliente from g_clientes_config_ c ' +
                         'inner join g_clientes cl on cl.id_cliente=c.id_cliente ' +
                         'inner join g_grupos_clientes g on g.id_grupo_cliente=cl.id_grupo_cliente ' +
                         'inner join c_pedidos p on p.id_cliente=cl.id_cliente ' +
                         'where ((c.item=''tiene_gp'') and (c.valor=''1'')) and ((p.estado=''X'') or (p.estado=''P'')) and g.id_grupo_cliente=:id_grupo');
      ParambyName('id_grupo').asinteger := StrToInt(edGrupo.Text);
      Open;

      if not (IsEmpty) then
      begin
        First;
        while not Eof do
        begin
          edCliente.Text := FieldByName('id_cliente').AsString;
          //GeneraPedidos('');
          Next;
        end;
      end
      else
        ShowMessage('No existen pedidos a enviar.');
      Free;
    end;
  end
  else
  begin
    peds_encadenados := '';
    todos := true;
    cancelado := False;

    if gr_envs.SelCount > 0 then
    begin
      todos := false;
      Dialog := CreateMessageDialog('Existe una multiselección. ¿Qué pedidos desea enviar?', mtWarning, [mbYes, mbNo, mbCancel]);

      TButton(Dialog.Controls[2]).Caption := 'Todo';
      TButton(Dialog.Controls[3]).Caption := 'Selección';
      TButton(Dialog.Controls[4]).Caption := 'Cancelar';

      try
        case Dialog.ShowModal of
          mrYes:
            begin
              if (MessageDlg('Va a enviar TODOS los pedidos PENDIENTES y SIN STOCK, ¿desea continuar?', mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes) then
                todos := True
              else
                cancelado := true;
            end;
          mrNo:
            begin
              if (MessageDlg('Va a enviar los pedidos SELECCIONADOS, ¿desea continuar?', mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes) then
                todos := False
              else
                cancelado := true;
            end;
          mrCancel:
            cancelado := true;
        end;
      finally
        Dialog.Free;
      end;
    end;

    if not cancelado then
    begin
      if todos then    //enviar todos los pedidos
      begin
        with dm.q_peds do
        try
            pedidos := '';
            First;
            while not eof do
            begin
              pedidos := pedidos + FieldByName('id_pedido').AsString + ',';
              Next;
            end;

        finally

        end;
      end
      else
      begin  //generar solo seleccionados
        pedidos := '';

        for i := 0 to gr_envs.SelCount - 1 do
        begin
          gr_envs.GotoSelection(i);
          pedidos := pedidos + dm.q_peds.FieldByName('id_pedido').AsString + ',';
        end;
      end;

      dm.t_write.StartTransaction;

      try
        if StrToInt(cl_padres[0])<0 then
          InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','',
                     'Bt.EnviaLotes Ini envio lotes a cliente',Copy(pedidos, 0, Length(pedidos) - 1))
        else
          InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','',
                     'Bt.EnviaLotes Ini envio lotes a clientes padre','(' + edCliente.Text + ') ' + Copy(pedidos, 0, Length(pedidos) - 1));

        peds := TStringList.Create;
        peds.Delimiter := ',';
        peds.DelimitedText := Copy(pedidos, 0, Length(pedidos) - 1);


        if StrToInt(cl_padres[0])<0 then
          frmlotes.EnviaLotes(peds,lbCliente.Caption,PC.Nombre,PC.IP,1,StrToInt(cl_padres[0]),cli_api_url,cli_api_user,cli_api_pass)
        else begin
          i := 0;
          while (i<=High(cl_padres)) do
          begin
            frmlotes.EnviaLotes(peds,lbCliente.Caption,PC.Nombre,PC.IP,1,StrToInt(cl_padres[i]),cli_api_url,cli_api_user,cli_api_pass);
            Inc(i);
          end;
        end;

        peds.Free;

        dm.t_write.Commit;

        if StrToInt(cl_padres[0])<0 then
             InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','',
                        'Bt.EnviaLotes Fin envio lotes a cliente',Copy(pedidos, 0, Length(pedidos) - 1))
        else
             InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','',
                        'Bt.EnviaLotes Fin envio lotes a clientes padre','(' + edCliente.Text + ') ' + Copy(pedidos, 0, Length(pedidos) - 1));

      except on e:exception do
        begin
          if StrToInt(cl_padres[0])<0 then
                InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','',
                           'Bt.EnviaLotes Error envio lotes a cliente',Copy(pedidos, 0, Length(pedidos) - 1) + ' Error: ' + e.Message)
          else
                InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','',
                           'Bt.EnviaLotes Error envio lotes a clientes padre','(' + edCliente.Text + ') ' + Copy(pedidos, 0, Length(pedidos) - 1) + ' Error: ' + e.Message);
          dm.t_write.rollback;
        end;
      end;

     filter(modo_historico);
                    //sMessageDlg('Proceso Finalizado',mtInformation,[mbok],0);
    end
    else
      lb_st1.Caption := 'Proceso cancelado.';
  end;

  pnPtes.Enabled := True;

  Screen.Cursor := crDefault;
end;

procedure Tf_main.btFtpClick(Sender: TObject);
var
  i, j, id_order, trans, id_line, id_articulo, id_pedido, sociedad, cont, cont_no: integer;
  dirs_in, dirs_out: TStringList;
  xml_path, pdf_path, codigo_art, cp, pedidos, json, resultado, msg_datos: string;
  exp_xml:IXMLDocumento;
  email: Tf_envia_mail;  cuerpo: TStrings;
  encontrado_error: Boolean;
begin

   pedidos := '';
   resultado := '';
   msg_datos := '';
   cont := 0;
   cont_no := 0;
   encontrado_error := False;

   if not DirectoryExists(dir_temp + IntToStr(main_cli) + '\') then
         CreateDirectory(PChar(dir_temp + IntToStr(main_cli) + '\'),0);

   lb_st1.Caption:='Consultando Pedidos Muzybar en FTP';
   application.ProcessMessages;

   dirs_in := TStringList.Create;
   dirs_in.Delimiter := ',';
   dirs_in.StrictDelimiter := True;
   dirs_in.DelimitedText := ftp_in;

   ftp_1.Connect;

   InsertaLog(u_main.usuario.id,0,0,PC.Nombre,PC.IP,log_app,'pedido','',
              'DescargaFTP ' + IntToStr(main_cli) + ' Ini','');

   try

     for j := 0 to dirs_in.Count - 1 do
     begin

       ftp_1.ChangeDir(dirs_in[j]);
       ftp_1.List('*.*',false);

       sociedad := StrToInt(Copy(dirs_in[j],LastDelimiter('/',Copy(dirs_in[j],0,Length(dirs_in[j])-1))+1,3));

       for i:=0 to ftp_1.DirectoryListing.Count-1 do begin
          if ((ftp_1.DirectoryListing[i].ItemType=ditFile) and (ExtractFileExt(ftp_1.DirectoryListing[i].FileName)='.xml')) then
          begin
             xml_path :=  path_copy_in +ftp_1.DirectoryListing[i].FileName;

             lb_st1.Caption:='Descargando ' + xml_path;

             ftp_1.Get(ftp_1.DirectoryListing[i].FileName,xml_path,True,false);

             xml_1.FileName:=xml_path;
             xml_1.Active:=true;
             exp_xml:=GetDocumento(xml_1);

             if (((exp_xml.InfGeneral.InfAlb.PaiEnv='ESPANA') and existe_cod_postal(exp_xml.InfGeneral.InfAlb.CPEnv)) or
                  (exp_xml.InfGeneral.InfAlb.PaiEnv<>'ESPANA')) then
             begin
                 encontrado_error := False;

                 //Primero revisamos las lineas por si hay algún art no encontrado en bbdd
                 SetLength(PedLines,0);
                  //SetLength(PedLines, exp_xml.InfGeneral.InfAlb.InfDetAlb.NLinsAlb);

                  for id_line := 0 to exp_xml.InfGeneral.InfAlb.InfDetAlb.NLinsAlb-1 do
                  begin
                    if IndexStr(IntToStr(exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[id_line].IdArt),[arts_ignorar])<0 then
                    begin
                      SetLength(PedLines,id_line+1);
                      //codigo_art := IntToStr(main_cli) + rightstr(StringOfChar('0', 5) + IntToStr(exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[id_line].IdArt), 5);
                      codigo_art := IntToStr(exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[id_line].IdArt);
                      id_articulo := busca_art(codigo_art,main_cli);

                      //30.09.21 Se van a cambia las referencias de Muzybar para que coincidan con sus códigos
                      //id_articulo := busca_art(IntToStr(exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[id_line].IdArt));

                      if id_articulo>=0 then
                      begin
                        PedLines[id_line].line := exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[id_line].IdLin;
                        PedLines[id_line].id_articulo := id_articulo;
                        PedLines[id_line].cantidad := exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[id_line].Unidades div 1000000;
                        PedLines[id_line].sku := IntToStr(exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[id_line].IdArt);
                        PedLines[id_line].nombre_art := Copy(exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[id_line].Articulo, 1, 60);
                      end else begin
                              msg_datos := msg_datos + IntToStr(exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[id_line].IdArt) +
                                          ':CodCli.Art.No encontrado. ' +  Copy(exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[id_line].Articulo, 1, 20) + ' (L.' + IntToStr(exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[id_line].IdLin) + ' ' + IntToStr(exp_xml.InfGeneral.InfAlb.IdAlb) + ')' + #13#10;
                              Inc(cont_no);

                              InsertaLog(u_main.usuario.id,id_pedido,0,PC.Nombre,PC.IP,log_app,'pedido','','ImpFtp.Art.NoEncontradoEn ' + IntToStr(exp_xml.InfGeneral.InfAlb.IdAlb), msg_datos);

                              encontrado_error := true;
                      end;
                    end;
                  end;

               if not encontrado_error then
               begin

                 id_order:=exp_xml.InfGeneral.InfAlb.IdAlb;

                 pdf_path:= path_copy_in + 'PreExpedicion' + IntToStr(id_order)+'.pdf';

                 lb_st1.Caption:='Descargando ' + pdf_path;

                 if ftp_1.Size('PreExpedicion'+IntToStr(id_order)+'.pdf')<>-1 then
                  ftp_1.Get('PreExpedicion'+IntToStr(id_order)+'.pdf',pdf_path,True);

                 if ftp_1.Size('PreExpedicion'+IntToStr(id_order)+'.pdf')<>-1 then
                ftp_1.Get('PreExpedicion'+IntToStr(id_order)+'.pdf',dir_temp + IntToStr(main_cli) + '\'+'PreExpedicion'+IntToStr(id_order)+'.pdf',True);

                  PedCab.clienteId := IntToStr(main_cli);
                  PedCab.fechaImp := FormatDateTime('yyyymmddhhnnss', Now);
                  PedCab.fechaPedido := FormatDateTime('yyyymmddhhnnss', EncodeDate(strtoint(Copy(exp_xml.InfGeneral.InfAlb.Fecha, 1, 4)), strtoint(Copy(exp_xml.InfGeneral.InfAlb.Fecha, 6, 2)), StrToInt(Copy(exp_xml.InfGeneral.InfAlb.Fecha, 9, 2))));
                  PedCab.nombreOrder := IntToStr(id_order);
                  PedCab.nombre := exp_xml.InfGeneral.InfAlb.NomEnv;
                  PedCab.dir1 := exp_xml.InfGeneral.InfAlb.DirEnv;
                  PedCab.poblacion := exp_xml.InfGeneral.InfAlb.PobEnv;
                  PedCab.provincia := exp_xml.InfGeneral.InfAlb.ProEnv;
                  PedCab.cp := exp_xml.InfGeneral.InfAlb.CPEnv;
                  PedCab.telefono := LeftStr(ReplaceStr(exp_xml.InfGeneral.InfAlb.TlfEnv,' ',''),20);
                  PedCab.pais := exp_xml.InfGeneral.InfAlb.PaiEnv;
                  PedCab.observaciones := IntToStr(exp_xml.InfGeneral.InfAlb.IdTrans) + ' ' + exp_xml.InfGeneral.InfAlb.Transpor;
                  PedCab.email := Copy(Trim(exp_xml.InfGeneral.InfAlb.emailEnv),0,100);
                  PedCab.contacto := '.';
                  PedCab.company := exp_xml.InfGeneral.InfAlb.Remitente;

                  if main_cli = 7078 then
                  begin

                    if exp_xml.InfGeneral.InfAlb.PaiEnv='PORTUGAL' then begin
                      PedCab.repartidor := '14';
                      PedCab.tipoServ := '36';
                      PedCab.horario := '23';
                      trans := 1;
                    end
                    else  if exp_xml.InfGeneral.InfAlb.PaiEnv<>'ESPANA' then begin
                      PedCab.repartidor := '35';
                      PedCab.tipoServ := '36';
                      PedCab.horario := '24';
                      trans := 1;
                    end
                    else begin
                      PedCab.repartidor := IntToStr(CalculaTransporteMuzybar(exp_xml.InfGeneral.InfAlb.IdTrans, trans));
                      PedCab.tipoServ := '';
                      PedCab.horario := '';
                    end;
                    PedCab.transporte := IntToStr(trans);

                  end
                  else
                  begin
                    PedCab.repartidor := '';
                    PedCab.transporte := '';
                  end;
                    //PedCab.repartidor  :=exp_xml.InfGeneral.InfAlb.IdTrans;
                    //dm.q_1.ParamByName('REPARTIDOR').asstring:=exp_xml.InfGeneral.InfAlb.Transpor;
                  PedCab.bultos := IntToStr(exp_xml.InfGeneral.InfAlb.Bultos);
                  PedCab.Remitente := exp_xml.InfGeneral.InfAlb.Remitente;

                  {Se quita este trozo para revisar las lineas antes de nada, por si hay algun art no existente en bbdd
                  SetLength(PedLines,0);
                  //SetLength(PedLines, exp_xml.InfGeneral.InfAlb.InfDetAlb.NLinsAlb);

                  for id_line := 0 to exp_xml.InfGeneral.InfAlb.InfDetAlb.NLinsAlb-1 do
                  begin
                    if IndexStr(IntToStr(exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[id_line].IdArt),[arts_ignorar])<0 then
                    begin
                      SetLength(PedLines,id_line+1);
                      //codigo_art := IntToStr(main_cli) + rightstr(StringOfChar('0', 5) + IntToStr(exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[id_line].IdArt), 5);
                      codigo_art := IntToStr(exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[id_line].IdArt);
                      id_articulo := busca_art(codigo_art,main_cli);

                      //30.09.21 Se van a cambia las referencias de Muzybar para que coincidan con sus códigos
                      //id_articulo := busca_art(IntToStr(exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[id_line].IdArt));

                      PedLines[id_line].line := exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[id_line].IdLin;
                      PedLines[id_line].id_articulo := id_articulo;
                      PedLines[id_line].cantidad := exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[id_line].Unidades div 1000000;
                      PedLines[id_line].sku := IntToStr(exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[id_line].IdArt);
                      PedLines[id_line].nombre_art := Copy(exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[id_line].Articulo, 1, 60);
                    end;
                  end;  }

                  PedCab.paisCode := calcula_pais_lgs_x_titulo(exp_xml.InfGeneral.InfAlb.PaiEnv);

                  if PedCab.paisCode = 'ES' then
                    cp := format_cp(exp_xml.InfGeneral.InfAlb.CPEnv)
                  else
                    cp := exp_xml.InfGeneral.InfAlb.CPEnv;

                  lb_st1.Caption:='Creando pedido ' + PedCab.nombreOrder;

                  id_pedido := StrToInt(dmupdatePedido.updatepedido(3, 0,json, resultado));      //VER N_SERIE EN LINEAS DE DETALLE

                   InsertaLog(u_main.usuario.id,id_pedido,0,PC.Nombre,PC.IP,log_app,'pedido','','CreadoPed.' + IntToStr(main_cli),
                   'Soc:'+ IntToStr(sociedad)+ ' xml:' + ftp_1.DirectoryListing[i].FileName + ' pdf:' + 'PreExpedicion'+IntToStr(id_order)+'.pdf'  );

                  if id_pedido > 0 then
                  begin
                    try
                      dm.t_write.StartTransaction;

                      if (xml_path <> '') then
                      begin
                        dm.q_1.Close;
                        dm.q_1.sql.Clear;
                        dm.q_1.sql.Add('insert into c_pedidos_extras ' + '(ID_PEDIDO,DESCRIPCION,VALOR) ' + 'values (:ID_PEDIDO,:DESCRIPCION,:VALOR)');
                        dm.q_1.ParamByName('ID_PEDIDO').AsInteger := id_pedido;
                        dm.q_1.ParamByName('DESCRIPCION').AsString := 'XML_PATH';
                        dm.q_1.ParamByName('VALOR').asstring := xml_path;
                        dm.q_1.ExecQuery;
                      end;

                      if (pdf_path <> '') then
                      begin
                        dm.q_1.Close;
                        dm.q_1.ParamByName('ID_PEDIDO').AsInteger := id_pedido;
                        dm.q_1.ParamByName('DESCRIPCION').AsString := 'PDF_PATH';
                        dm.q_1.ParamByName('VALOR').asstring := pdf_path;
                        dm.q_1.ExecQuery;
                        pedidos := pedidos + IntToStr(id_pedido) + ',';
                      end;

                      if (IntToStr(sociedad) <> '') then
                      begin
                        dm.q_1.Close;
                        dm.q_1.ParamByName('ID_PEDIDO').AsInteger := id_pedido;
                        dm.q_1.ParamByName('DESCRIPCION').AsString := 'SOCIEDAD';
                        dm.q_1.ParamByName('VALOR').asstring := IntToStr(sociedad);
                        dm.q_1.ExecQuery;
                      end;

                      if ((IntToStr(exp_xml.InfGeneral.InfAlb.IdTrans) <> '') or (exp_xml.InfGeneral.InfAlb.Transpor <> '')) then
                      begin
                        dm.q_1.Close;
                        dm.q_1.ParamByName('ID_PEDIDO').AsInteger := id_pedido;
                        dm.q_1.ParamByName('DESCRIPCION').AsString := 'REPARTIDOR';
                        dm.q_1.ParamByName('VALOR').asstring :=  IntToStr(exp_xml.InfGeneral.InfAlb.IdTrans) + ' ' + exp_xml.InfGeneral.InfAlb.Transpor;
                        dm.q_1.ExecQuery;
                      end;

                      dm.t_write.CommitRetaining;
                    except
                      dm.t_write.Rollback;
                    end;

                    ftp_1.Rename(ftp_1.DirectoryListing[i].FileName,'./bak/'+ftp_1.DirectoryListing[i].FileName);               //Move Files to Bak in FTP

                    InsertaLog(u_main.usuario.id,id_pedido,0,PC.Nombre,PC.IP,log_app,'pedido','','MovidoABak.' + IntToStr(main_cli),
                   'De: '+ ftp_1.DirectoryListing[i].FileName + ' a: ' + './bak/'+ftp_1.DirectoryListing[i].FileName);

                    if FileExists(pdf_path) then
                    begin
                        //lb_st1.Caption:='Imprimiendo ' + pdf_path;
                        //ShellExecute(Handle, 'Print', PChar(pdf_path), nil,  nil, SW_HIDE);
                        ftp_1.Rename('PreExpedicion'+IntToStr(id_order)+'.pdf','./bak/PreExpedicion'+IntToStr(id_order)+'.pdf');
                        InsertaLog(u_main.usuario.id,id_pedido,0,PC.Nombre,PC.IP,log_app,'pedido','','MovidoABak.' + IntToStr(main_cli),
                                   'De: '+ 'PreExpedicion'+IntToStr(id_order)+'.pdf' + ' a: ' + './bak/PreExpedicion'+IntToStr(id_order)+'.pdf');
                    end else begin
                                cuerpo := tstringlist.Create;
                                cuerpo.Add('Este es un mensaje automático.<br>');
                                cuerpo.Add('No encontrado el fichero pdf del pedido ' + IntToStr(id_order) +  ' en la carpeta ' + IntToStr(sociedad)+ ' del FTP.<br>');
                                cuerpo.Add('Archivo esperado: PreExpedicion'+IntToStr(id_order)+ '.pdf<br>');
                                //cuerpo.Add('Por favor, enviar a Loginser via email. ');
                                //cuerpo.Add('Gracias por su colaboración.');

                                email := Tf_envia_mail.create(self);
                                email.Show;
                                email.envia_email('almacen3@loginser.com,desarrollo@loginser.com',
                                                  '', 'Aviso de incidencia Ped.' + IntToStr(id_order),'','', cuerpo);

                                inserta_pedido_extra(id_pedido,'AVISO_MAIL_PDF',cuerpo[2]);

                                insertalog(usuario.id,id_pedido,0,PC.Nombre, PC.IP,log_app,'pedido','','AvisoPdf ',
                                      cuerpo[1]+cuerpo[2]);

                                cuerpo.Free;
                                email.close;
                                email.Free;
                    end;
                    Inc(cont);
                  end;
                end;
             end else begin
                        msg_datos := msg_datos + IntToStr(exp_xml.InfGeneral.InfAlb.IdAlb) + ':CP erroneo' + #13#10;
                        Inc(cont_no);
                      end

          end;
       end;

     end;

   finally
     ftp_1.Disconnect;
   end;

   lb_st1.Caption := 'Imprimiendo documentos ...';
   if print_doc_cliente and (pedidos<>'')  then
      imprime_doc_cliente(Copy(pedidos, 1, Length(pedidos) - 1), '');

   filter(modo_historico);

   lb_st1.Caption := 'Descarga finalizada.';

   if msg_datos<>'' then
      msg_datos := #13#10 + #13#10 + 'Pedidos NO descargados: ' + IntToStr(cont_no) + #13#10 + msg_datos;

   resultado := resultado + #13#10 + #13#10 + 'Descargados ' + IntToStr(cont) + ' pedidos.';

   InsertaLog(u_main.usuario.id,0,0,PC.Nombre,PC.IP,log_app,'pedido','',
              'DescargaFTP ' + IntToStr(main_cli) + ' Fin',Copy(pedidos, 1, Length(pedidos) - 1));
   showmessage('Descarga finalizada. ' + resultado + msg_datos);
end;

{ Este procedimiento descarga usando el componente SecureBridge, que es de pago
y no hemos renovado la licencia

procedure Tf_main.btFtpClick(Sender: TObject);
var

  id_pedido, id_line, n, i, j, id_order, id_muzybar, id_articulo, trans: integer;
  dirs_in, dirs_out: TStringList;
  Handle:  TScSFTPFileHandle;
begin
  n := 0;

  lb_st1.Caption := 'Consultando Pedidos en FTP';
  application.ProcessMessages;

  lb_st1.Caption :=  'ConectaNdo al servidor FTP';
  cl.Connect;
  lb_st1.Caption :=  'Conectado al servidor FTP';

  ShowMessage('Antes initialize');
  ShowMessage(cl.HostName + #13#10 + cl.User + #13#10 + cl.Password);
  f.Initialize;
  ShowMessage('Despues initialize');

  //dm.ftp_1.Connect;
  //ftp_1.Connect;

  try
    dirs_in := TStringList.Create;
    dirs_in.Delimiter := '|';
    dirs_in.StrictDelimiter := True;
    dirs_in.DelimitedText := ftp_in;

    ftp_100 := TStringList.Create;
    ftp_200 := TStringList.Create;
    ftp_300 := TStringList.Create;
    ftp_400 := TStringList.Create;

    for j := 0 to dirs_in.Count - 1 do
    begin
     ftp_sociedad := StrToInt(Copy(dirs_in[j],LastDelimiter('/',Copy(dirs_in[j],0,Length(dirs_in[j])-1))+1,3));

     ShowMessage('Antes abrir dir');
     ShowMessage(dirs_in[j]);
     Handle := f.OpenDirectory(dirs_in[j]);
     ShowMessage('Despues dir');

     while not f.EOF do
     begin
           ShowMessage('Antes read');
            f.ReadDirectory(handle);
            ShowMessage('Despues read');
            Inc(n);
     end;
    end;

    ShowMessage('Antes procesar');
    if (ftp_100.Count>0) then
        ProcesaPedidosEnTemp(100,ftp_100);
    if (ftp_200.Count>0) then
        ProcesaPedidosEnTemp(200,ftp_200);
    if (ftp_300.Count>0) then
        ProcesaPedidosEnTemp(300,ftp_300);
    if (ftp_400.Count>0) then
        ProcesaPedidosEnTemp(400,ftp_400);
    ShowMessage('Despues procesar');
    filter;
  finally
    f.CloseHandle(Handle);
    f.Disconnect;
    ftp_100.Free;
    ftp_200.Free;
    ftp_300.Free;
    ftp_400.Free;
    dirs_in.Free;
  end;

  lb_st1.Caption := 'Importación Finalizada, ' + inttostr(n) + ' Pedidos Importados';
  application.ProcessMessages;
  filter;
  sMessageDlg('Importación Finalizada, ' + inttostr(n) + ' Pedidos Importados', mtInformation, [mbok], 0);

end;
}

procedure Tf_main.ProcesaPedidosEnTemp(sociedad:Integer; strlist:TStringList);
var
  i, id_order, trans, id_line, id_articulo, id_pedido, todo_ok:integer;
  xml_path, pdf_path, codigo_art, cp, json, resultado: string;
  exp_xml:IXMLDocumento;

begin
   todo_ok := 1;
   resultado := '';

   for I := 0 to strlist.Count-1 do
  begin
        try
            xml_path := path_copy_in + strlist[i];
            //xml_path := path_copy_in + 'prueba_xml.xml';

            //xml_1.FileName := xml_path;
            xml_1.FileName := dir_temp+strlist[i];
            xml_1.Active := true;

            exp_xml := GetDocumento(xml_1);

            id_order := exp_xml.InfGeneral.InfAlb.IdAlb;

             pdf_path := path_copy_in + 'PreExpedicion' + IntToStr(id_order)+ '.pdf';
             //pdf_path :=path_copy_in + 'prueba_pdf.pdf';
           { if FileExists(dir_temp+strlist[i]) then
                 DeleteFile(dir_temp+strlist[i]);

            if FileExists(dir_temp + 'PreExpedicion' + IntToStr(id_order)+'.pdf') then
                 DeleteFile(dir_temp + 'PreExpedicion' + IntToStr(id_order)+'.pdf');  }

            PedCab.clienteId := IntToStr(main_cli);
            PedCab.fechaImp := FormatDateTime('yyyymmddhhnnss', Now);
            PedCab.fechaPedido := FormatDateTime('yyyymmddhhnnss', EncodeDate(strtoint(Copy(exp_xml.InfGeneral.InfAlb.Fecha, 1, 4)), strtoint(Copy(exp_xml.InfGeneral.InfAlb.Fecha, 6, 2)), StrToInt(Copy(exp_xml.InfGeneral.InfAlb.Fecha, 9, 2))));
            PedCab.nombreOrder := IntToStr(id_order);
            PedCab.nombre := exp_xml.InfGeneral.InfAlb.NomEnv;
            PedCab.dir1 := exp_xml.InfGeneral.InfAlb.DirEnv;
            PedCab.poblacion := exp_xml.InfGeneral.InfAlb.PobEnv;
            PedCab.provincia := exp_xml.InfGeneral.InfAlb.ProEnv;
            PedCab.cp := exp_xml.InfGeneral.InfAlb.CPEnv;
            PedCab.telefono := LeftStr(ReplaceStr(exp_xml.InfGeneral.InfAlb.TlfEnv,' ',''),20);
            PedCab.pais := exp_xml.InfGeneral.InfAlb.PaiEnv;

            if main_cli = 7078 then
            begin
              PedCab.repartidor := IntToStr(CalculaTransporteMuzybar(exp_xml.InfGeneral.InfAlb.IdTrans, trans));
              PedCab.transporte := IntToStr(trans);
            end
            else
            begin
              PedCab.repartidor := '';
              PedCab.transporte := '';
            end;
              //PedCab.repartidor  :=exp_xml.InfGeneral.InfAlb.IdTrans;
              //dm.q_1.ParamByName('REPARTIDOR').asstring:=exp_xml.InfGeneral.InfAlb.Transpor;
            PedCab.bultos := IntToStr(exp_xml.InfGeneral.InfAlb.Bultos);
            PedCab.Remitente := exp_xml.InfGeneral.InfAlb.Remitente;

            SetLength(PedLines, exp_xml.InfGeneral.InfAlb.InfDetAlb.NLinsAlb);

            for id_line := 0 to exp_xml.InfGeneral.InfAlb.InfDetAlb.NLinsAlb-1 do
            begin
              codigo_art := IntToStr(main_cli) + rightstr(StringOfChar('0', 5) + IntToStr(exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[id_line].IdArt), 5);
              id_articulo := busca_art(codigo_art,main_cli);

              PedLines[id_line].line := exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[id_line].IdLin;
              PedLines[id_line].id_articulo := id_articulo;
              PedLines[id_line].cantidad := exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[id_line].Unidades div 1000000;
              PedLines[id_line].sku := IntToStr(exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[id_line].IdArt);
              PedLines[id_line].nombre_art := Copy(exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[id_line].Articulo, 1, 100);
            end;

            PedCab.paisCode := calcula_pais_lgs_x_titulo(exp_xml.InfGeneral.InfAlb.PaiEnv);

            if PedCab.paisCode = 'ES' then
              cp := format_cp(exp_xml.InfGeneral.InfAlb.CPEnv)
            else
              cp := exp_xml.InfGeneral.InfAlb.CPEnv;

            id_pedido := StrToInt(dmupdatePedido.updatepedido(3, 0, json,resultado));      //VER N_SERIE EN LINEAS DE DETALLE

            if id_pedido > 0 then
            begin
              try
                dm.t_write.StartTransaction;

                if (xml_path <> '') then
                begin
                RenameFile(dir_temp+strlist[i], xml_path);
                  dm.q_1.Close;
                  dm.q_1.sql.Clear;
                  dm.q_1.sql.Add('insert into c_pedidos_extras ' + '(ID_PEDIDO,DESCRIPCION,VALOR) ' + 'values (:ID_PEDIDO,:DESCRIPCION,:VALOR)');
                  dm.q_1.ParamByName('ID_PEDIDO').AsInteger := id_pedido;
                  dm.q_1.ParamByName('DESCRIPCION').AsString := 'XML_PATH';
                  dm.q_1.ParamByName('VALOR').asstring := xml_path;
                  dm.q_1.ExecQuery;
                end;

                if (pdf_path <> '') then
                begin
                RenameFile(dir_temp+ 'PreExpedicion' + IntToStr(id_order)+'.pdf',pdf_path);
                  dm.q_1.Close;
                  dm.q_1.ParamByName('ID_PEDIDO').AsInteger := id_pedido;
                  dm.q_1.ParamByName('DESCRIPCION').AsString := 'PDF_PATH';
                  dm.q_1.ParamByName('VALOR').asstring := pdf_path;
                  dm.q_1.ExecQuery;
                end;

                if (IntToStr(sociedad) <> '') then
                begin
                  dm.q_1.Close;
                  dm.q_1.ParamByName('ID_PEDIDO').AsInteger := id_pedido;
                  dm.q_1.ParamByName('DESCRIPCION').AsString := 'SOCIEDAD';
                  dm.q_1.ParamByName('VALOR').asstring := IntToStr(sociedad);
                  dm.q_1.ExecQuery;
                end;

                if ((IntToStr(exp_xml.InfGeneral.InfAlb.IdTrans) <> '') or (exp_xml.InfGeneral.InfAlb.Transpor <> '')) then
                begin
                  dm.q_1.Close;
                  dm.q_1.ParamByName('ID_PEDIDO').AsInteger := id_pedido;
                  dm.q_1.ParamByName('DESCRIPCION').AsString := 'REPARTIDOR';
                  dm.q_1.ParamByName('VALOR').asstring := IntToStr(exp_xml.InfGeneral.InfAlb.IdTrans) + ' ' + exp_xml.InfGeneral.InfAlb.Transpor;
                  dm.q_1.ExecQuery;
                end;

                dm.t_write.CommitRetaining;
              except
                dm.t_write.Rollback;
              end;
            end;
      except
        todo_ok := 0;
      end;

      if todo_ok=1 then
      begin

      end;

   end;
end;
function Tf_main.BuscaClienteGesFile(codigo: integer): string;
begin                                       //devuelve nombre de cliente a partir de codigo
  with tpfibdataset.Create(dm) do
  begin
    database := dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select nombre from g_clientes cl, g_clientes_config_ c where cl.id_cliente=c.id_cliente and ((c.item=''tiene_gp'') and (c.valor=''1'')) and cl.id_cliente=:id ');
    ParambyName('id').AsInteger := codigo;
    Open;

    if not (IsEmpty) then
      Result := FieldByName('nombre').asstring
    else
      result := '';

    Free;
  end;
end;

procedure Tf_main.bt_1158Click(Sender: TObject);
begin
  //enviar_status_delivered('');

  lb_1.Caption := 'FINISHED';
  ShowMessage('FINISHED');
end;

procedure Tf_main.bt_1Click(Sender: TObject);
begin
 //enviar_status_sent;
end;

procedure Tf_main.CargaInterfaz;
var
  order_ok, datos_ag: string;
  i: integer;
  str_agencia: TStringDynArray;
begin

  case rgTipoGes.ItemIndex of
    0:
      main_cli := StrToInt(edCliente.Text);
    1:
      main_cli := GetMainCliGrupo(StrToInt(edGrupo.Text));
  end;

  with tpfibdataset.Create(dm) do
  begin
    database := dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select * ' +
                       'from g_clientes_config where id_cliente=:id ');
    ParambyName('id').AsInteger := main_cli;
    Open;

    if not (IsEmpty) then
    begin
      //f_type := FieldByName('file_type').asstring;  cambiado por import_type
      if FieldByName('delivery_time').AsInteger >= 0 then
        delivery_time := FieldByName('delivery_time').AsInteger
      else
        delivery_time := delivery_default;

       //u_detail.f_detail.rep_pick.FindObject('picture2') as TfrxPictureView;

      if FieldByName('default_deleg').AsString = '' then
        default_deleg := edCliente.Text + '1'
      else
        default_deleg := FieldByName('default_deleg').AsString;

      path_files_imp := FieldByName('path_files_imp').AsString;

      transporte_propio := FieldByName('transporte_propio').AsInteger;

      repartidor := FieldByName('id_repartidor').AsInteger;

      if repartidor = 6 then
        CargarDatosCorreos
      else
      begin
        datos_ag := CargarDatosAgencia('cliente_inf_ag,email_asm', main_cli, repartidor);

        if datos_ag = '' then
        begin
          cli_inf_asm_cl := cli_inf_asm;
          email_asm := '';
        end
        else
        begin
          str_agencia := SplitString(datos_ag, '#');
          cli_inf_asm_cl := str_agencia[0];
          email_asm := str_agencia[1];
        end;
      end;

      order_ok := FieldByName('order_ok').AsString;
      email_reexp := FieldByName('email_reexp').AsString;
      path_reexp := FieldByName('path_files_reexp').AsString;
      prefijo_reexp := FieldByName('prefijo_reexp').AsString;

      if FieldByName('estado_alb').AsString = '' then
        estado_alb := 0
      else
        estado_alb := FieldByName('estado_alb').AsInteger;

       id_almacen := FieldByName('id_almacen').AsInteger;

      txt_tpropio := FieldByName('txt_tpropio').AsString;

       //pack_abierto := FieldByName('pack_abierto').AsInteger;

      q1.Close;
      q1.ParamByName('id').AsInteger := main_cli;
      q1.Open;

      stock_min := FieldByName('stock_min').AsInteger;
      peds_en_cadena := FieldByName('peds_en_cadena').AsInteger;
      cjs_x_agr := FieldByName('cajas_x_agrup').AsInteger;

      if cjs_x_agr > 0 then
        ncajas_x := cjs_x_agr;
    end;

    Free;
  end;

  with TpFIBDataSet.Create(self) do
  try
    Database := dm.db;
    SQLs.SelectSQL.Clear;
    sqls.SelectSQL.Add('select * from get_clientes_config(:id_cliente)');
    ParamByName('id_cliente').AsInteger := StrToInt(edCliente.text);
    Open;
    First;

    if not IsEmpty then
    begin
      if not modo_historico then
          Caption := 'GESTIÓN PEDIDOS DE ALMACÉN ' + v + '  -  ' + IntToStr(usuario.id) + ' ' + usuario.nombre
      else
          Caption := 'GESTIÓN PEDIDOS DE ALMACÉN ' + v + ' ' + IntToStr(usuario.id) + ' ' + usuario.Nombre + '     MODO HISTORICO ACTIVADO';

      repartidor := FieldByName('agencia').AsInteger;
      horario_cl := FieldByName('horario').AsInteger;
      servicio_cl := FieldByName('servicio').AsInteger;
      imgs_ftp := FieldByName('imgs_ftp').AsString;
      ftp_in := FieldByName('ftp_in').AsString;
      ftp_out := FieldByName('ftp_out').AsString;

      ruta_fichero_seur := FieldByName('ruta_fichero_seur').AsString;
      ruta_fichero_seur_copia := FieldByName('ruta_fichero_seur_copia').AsString;

      prod_seur := FieldByName('prod_seur').AsString;

      tiene_detalle_a_medida := (FieldByName('detalle_a_medida').AsInteger = 1);

      clientes_no_10 := FieldByName('clientes_no_10').AsString;

      httpweb := FieldByName('httpweb').AsString;
      php_get := FieldByName('php_get').AsString;
      php_update := FieldByName('php_update').AsString;
      php_send := FieldByName('php_send').AsString;
      id_columnas_web := FieldByName('id_columnas_web').AsInteger;

      envia_error_import := (FieldByName('envia_error_import').AsInteger = 1);
      email_error_import := FieldByName('email_error_import').AsString;
      oculta_error_import := FieldByName('oculta_error_import').AsString;
      asunto_error_import := FieldByName('asunto_error_import').AsString;

      envia_sent := (FieldByName('envia_sent').AsInteger = 1);
      php_sent := FieldByName('php_sent').AsString;
      datos_sent := FieldByName('datos_sent').AsString;
      log_sent := FieldByName('log_sent').AsString;

      envia_delivered := (FieldByName('envia_delivered').AsInteger = 1);
      php_delivered := FieldByName('php_delivered').AsString;
      datos_delivered := FieldByName('datos_delivered').AsString;
      log_delivered := FieldByName('log_delivered').AsString;
      estados_delivered := FieldByName('estados_delivered').AsString;

      //aviso_pedidos_antiguos := FieldByName('aviso_pedidos_antiguos').AsInteger;

      marca_sent := FieldByName('marca_sent').AsInteger;
      marca_delivered := FieldByName('marca_delivered').AsInteger;

      pie_hoja_pick := FieldByName('pie_hoja_pick').AsString;

      titulo_sin_stock := FieldByName('titulo_sin_stock').AsString;

      tiene_devos := (FieldByName('tiene_devos').AsInteger = 1);
      ftp_devo_host := FieldByName('ftp_devo_host').AsString;
      ftp_devo_user := FieldByName('ftp_devo_user').AsString;
      ftp_devo_pass := FieldByName('ftp_devo_pass').AsString;
      ftp_devo_dir := FieldByName('ftp_devo_path').AsString;
      ftp_devo_prefijo := FieldByName('ftp_devo_prefijo').AsString;

      dir_temp := FieldByName('dir_temp').AsString;
      dir_temp_devo := FieldByName('dir_temp_devo').AsString;

      LoadConfigCliente(FieldByName('items').AsString);

      chEnviarLotes.Enabled := revisa_lotes;
      chEnviarLotes.Checked := revisa_lotes;
      btEnviarLotes.Enabled := revisa_lotes;

      if delay_ptes>0 then
          tmr1.Interval := delay_ptes;

      { Actualizar configuraciones rest }

      dmUpdatePedido.lgs_api_url := lgs_api_url;
      dmUpdatePedido.lgs_api_llamada := lgs_api_pedido;
      dmUpdatePedido.auth.Username := lgs_api_user;
      dmUpdatePedido.auth.Password := lgs_api_pass;
      dmUpdatePedido.peds_en_cadena := peds_en_cadena;

      dmEstadoPedido.lgs_api_url := lgs_api_url;
      dmEstadoPedido.lgs_api_llamada := lgs_api_estped;
      dmEstadoPedido.auth.Username := lgs_api_user;
      dmEstadoPedido.auth.Password := lgs_api_pass;

      mnAnulaStock.Enabled := util_anula_stock and (StrToInt(cl_padres[0])<0); //No se puede anular el stock de un cliente padre desde el hijo
    end;

  finally
    free;
  end;

  bt_import.Enabled := False;
  bt_import_mdb.Enabled := False;

  if locked then
  begin
    bt_import.Enabled := False;
    bt_import_mdb.Enabled := False;
    btDevos.Enabled := False;
    btCarrito.Enabled := False;
    btFtp.Enabled := False;

    for i := 1 to Length(import_type) do
    begin
      if not bt_import.Enabled then
        bt_import.Enabled := (Copy(import_type, i, 1) = 'C');
      if not bt_import.Enabled then
        bt_import.Enabled := (Copy(import_type, i, 1) = 'X');
      if not bt_import_mdb.Enabled then
        bt_import_mdb.Enabled := (Copy(import_type, i, 1) = 'W');
      if not btDevos.Enabled then
        btDevos.Enabled := (Copy(import_type, i, 1) = 'D');
      if not btCarrito.Enabled then
        btCarrito.Enabled := (Copy(import_type, i, 1) = 'R');
      if not btFtp.Enabled then
        btFtp.Enabled := (Copy(import_type, i, 1) = 'F');

      if (Copy(import_type, i, 1) = 'C') then
        ed_csv.FilterIndex := 1
      else if (Copy(import_type, i, 1) = 'X') then
        ed_csv.FilterIndex := 2;

      //  if not edPDF.Enabled then
      //    edPDF.Enabled := (Copy(f_type,i,1)='P');
    end;

    ed_csv.Enabled := bt_import.Enabled;
    btLotes.Enabled := tiene_lotes;
    chPicking.Enabled := tiene_lotes;

    chPackAb.Visible := not (pack_abierto = 3);
    chPackAb.Enabled := ((pack_abierto <> 0) and (pack_abierto <> 3));
    chPackAb.Checked := (pack_abierto = 2);

    lbNoPick.Visible := (pack_abierto = 3);

    RellenaAlmacenes;
  end;

  btEnvAgencias.Enabled := locked;
  deDir.Enabled := locked;
  deDir.Text := u_globals.xls_seur;

  cbAlmacenes.Visible := locked;

  if cbAlmacenes.Visible then
  begin
    //id_almacen := StrToInt(Copy(cbAlmacenes.Text, Pos('|', cbAlmacenes.Text) + 1, Length(cbAlmacenes.Text)))
    if Pos(',',alm_cliente)=0 then
      id_almacen := StrToInt(alm_cliente)
    else
      id_almacen := StrToInt(Copy(alm_cliente,0, Pos('', cbAlmacenes.Text) + 1));

    for i:=0 to cbAlmacenes.Items.Count do
      if Pos('|'+IntToStr(id_almacen),cbAlmacenes.Items[i])>0 then
          cbAlmacenes.ItemIndex := i;
  end
  else
    id_almacen := -1;

  gr_envs.Columns[4].Visible := (main_cli = 7551);
  gr_envs.Columns[7].Visible := (main_cli = 7252);
  gr_envs.Columns[1].Visible := (main_cli <> 7551);
  gr_envs.Columns[11].Visible := (main_cli <> 7551);
  gr_envs.Columns[13].Visible := (main_cli <> 7551);
  gr_envs.Columns[14].Visible := (main_cli <> 7551);
  gr_envs.Columns[15].Visible := (main_cli <> 7551);
  gr_envs.Columns[16].Visible := (main_cli <> 7551);
  gr_envs.Columns[17].Visible := (main_cli <> 7551);
  gr_envs.Columns[20].Visible := (main_cli <> 7551);
  gr_envs.Columns[21].Visible := (main_cli <> 7551);
  gr_envs.Columns[22].Visible := (main_cli <> 7551);
  gr_envs.Columns[9].Visible := (main_cli <> 7551);
  gr_envs.Columns[10].Visible := (main_cli <> 7551);

  with TpFIBDataSet.Create(self) do
  try
    Database := dm.db;
    SQLs.SelectSQL.Clear;
    sqls.SelectSQL.Add('select count(*) as cuenta from c_pedidos where id_cliente=:id_cliente and estado=:estado');
    ParamByName('id_cliente').AsInteger := StrToInt(edCliente.text);
    ParamByName('estado').AsString := 'I';
    Open;

    if not IsEmpty and (FieldByName('cuenta').AsInteger > 0) then
      sMessageDlg('Existe/n ' + FieldByName('cuenta').AsString + ' pedido/s en Incidencias', mtWarning, [mbOK], 0);

    imgIncidencias.Visible := (FieldByName('cuenta').AsInteger > 0);
    tmr2.Enabled := (FieldByName('cuenta').AsInteger > 0);
  finally
    free;
  end;

 { resultado := '';
  ControlesCliente(main_cli,resultado);

  if resultado<>'' then
      ShowMessage(resultado);
  }

  btImpAdj.Enabled := locked and tiene_adjuntos;
  btActExp.Enabled := act_envios;

  SetLength(asignado_a_pav,0);

  chAntonio.Visible := (main_cli=7428);
  chAntonio.Checked := False;
end;

procedure Tf_main.LoadConfigCliente(items: string);
var
  i: integer;
  item_list, par: TStringList;
begin

  item_list := TStringList.Create;
  item_list.QuoteChar := ' ';
  item_list.Delimiter := '$';
  item_list.DelimitedText := items;

  if item_list.Count > 0 then
  begin
    par := TStringList.Create;
    par.Delimiter := '|';

    for i := 0 to item_list.Count - 1 do
    begin
      par.DelimitedText := item_list[i];

      if UpperCase(par[0]) = 'CONTROL_IMEI' then
        control_imei := (par[1] = '1');
      if UpperCase(par[0]) = 'FTP_IN' then
        ftp_in := par[1];
      if UpperCase(par[0]) = 'FTP_OUT' then
        ftp_out := par[1];
      if UpperCase(par[0]) = 'PATH_COPY_IN' then
        path_copy_in := par[1];
      if UpperCase(par[0]) = 'PATH_COPY_OUT' then
        path_copy_out := par[1];
      if UpperCase(par[0]) = 'PHP_UPDATE_VACIOS' then
        php_update_vacios := par[1];
      if UpperCase(par[0]) = 'TIPO_DEVO_RECO' then
        tipo_devo_reco := par[1];
      if UpperCase(par[0]) = 'TIPO_DEVO_RECO_CLI' then
        tipo_devo_reco_cli := par[1];
      if UpperCase(par[0]) = 'DIR_CLIENTE_RECO' then
        dir_cliente_reco := par[1];
      if UpperCase(par[0]) = 'AVISO_INCIDENCIAS' then
        aviso_incidencias := (par[1]='1');
      if UpperCase(par[0]) = 'PRINT_DOC_CLIENTE' then
        print_doc_cliente := (par[1]='1');
      if UpperCase(par[0]) = 'EXTRA_DOC_CLIENTE' then
        extra_doc_cliente := par[1];
      if UpperCase(par[0]) = 'TIENE_N_SERIE' then
        tiene_n_serie := (par[1]='1');
      if UpperCase(par[0]) = 'TIENE_ADJUNTOS' then
        tiene_adjuntos := (par[1]='1');
      if UpperCase(par[0]) = 'TIT_FILE_UPS' then
        tit_file_ups := par[1];
      if UpperCase(par[0]) = 'FTP_DIR_UPS' then
        ftp_dir_ups := par[1];
      if UpperCase(par[0]) = 'POS_TIT_UPS' then
        pos_tit_ups := StrToInt(par[1]);
      if UpperCase(par[0]) = 'ACT_ENVIOS' then
        act_envios := (par[1]='1');
      {if UpperCase(par[0]) = 'LOGO_ETIQ' then
        logo_cli_etiq := StrToInt(par[1]); }
      if UpperCase(par[0]) = 'API_USER' then
        cli_api_user := par[1];
      if UpperCase(par[0]) = 'API_PASS' then
        cli_api_pass := par[1];
      if UpperCase(par[0]) = 'API_URL' then
        cli_api_url := par[1];
      if UpperCase(par[0]) = 'REVISA_LOTES' then
        revisa_lotes := (par[1]='1');
      if UpperCase(par[0]) = 'MAIL_ERROR' then
        mail_error := par[1];
      if UpperCase(par[0]) = 'LOG_GP' then
        log_app := par[1];
      if UpperCase(par[0]) = 'MAX_LN_DET' then
        max_ln_det := StrToInt(par[1]);
      if UpperCase(par[0]) = 'DATE_MAIL_DEST' then
        date_mail_dest := StrToDate(par[1]);
      if UpperCase(par[0]) = 'MARCA_PED_REEXP' then
        marca_ped_reexp := par[1];
      if UpperCase(par[0]) = 'ARTS_IGNORAR' then
        arts_ignorar := par[1];
      if UpperCase(par[0]) = 'ALMACENES' then
        alm_cliente:= par[1];
      if UpperCase(par[0]) = 'ENVIA_SENT' then
        envia_sent := (par[1]='1');
      if UpperCase(par[0]) = 'ENVIA_DELIVERED' then
        envia_delivered := (par[1]='1');
      if UpperCase(par[0]) = 'DELAY_PTES' then
        delay_ptes := StrToInt(par[1]);
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
      if UpperCase(par[0]) = 'PACK_ABIERTO' then
        pack_abierto := StrToInt(par[1]);
      if UpperCase(par[0]) = 'LGS_API_URL' then
        lgs_api_url := par[1];
      if UpperCase(par[0]) = 'LGS_API_USER' then
        lgs_api_user := par[1];
      if UpperCase(par[0]) = 'LGS_API_PASS' then
        lgs_api_pass := par[1];
      if UpperCase(par[0]) = 'LGS_API_PEDIDO' then
        lgs_api_pedido := par[1];
      if UpperCase(par[0]) = 'LGS_API_ESTPED' then
        lgs_api_estped := par[1];
      if UpperCase(par[0]) = 'AGENCIA' then
        repartidor := StrToInt(par[1]);
      if UpperCase(par[0]) = 'SERVICIO' then
        servicio_cl := StrToInt(par[1]);
      if UpperCase(par[0]) = 'HORARIO' then
        horario_cl := StrToInt(par[1]);
      if UpperCase(par[0]) = 'GESTION_COLA' then
        gestion_cola := (par[1]='1');
      if UpperCase(par[0]) = 'ALBS_GESTORAS' then
        tiene_albs_gestoras := (par[1]='1');
      if UpperCase(par[0]) = 'AGENCIA_SEUR' then
        agencia_seur := StrToInt(par[1]);
      if UpperCase(par[0]) = 'AGENCIA_CORREOS' then
        agencia_correos := StrToInt(par[1]);
      if UpperCase(par[0]) = 'TIENE_CTRL_STOCK_0' then
        tiene_control_stock_0 := (par[1]='1');
      if UpperCase(par[0]) = 'UTIL_ANULAR_STOCK' then
        util_anula_stock := (par[1]='1');
      if UpperCase(par[0]) = 'UTIL_ANUL_ST_PARAMS' then
        util_anula_stock_params := par[1];
      if UpperCase(par[0]) = 'UTIL_ANUL_ST_COPIA' then
        util_anula_stock_copia := par[1];
      if UpperCase(par[0]) = 'UTIL_ANUL_ST_BAJAART' then
        util_anula_stock_baja_art := (par[1]='1');
      if UpperCase(par[0]) = 'IMPORT_XLS_AGR_ART' then
        import_xls_agr_art := (par[1]='1');
      if UpperCase(par[0]) = 'IMPORT_TYPE' then
        import_type := par[1];
      if UpperCase(par[0]) = 'UTIL_PAV' then
        util_pav := (par[1]='1');
      if UpperCase(par[0]) = 'AVISO_PEDS_ANTIGUOS' then
        aviso_pedidos_antiguos := StrToInt(par[1]);
      if UpperCase(par[0]) = 'CL_PADRES' then
        cl_padres := splitstring(par[1],',');
      if UpperCase(par[0]) = 'CL_HIJOS' then
        cl_hijos := splitstring(par[1],',');
    end;
  end;

  if alm_cliente='' then alm_cliente:='1';
end;

procedure Tf_main.cbAgenciasClick(Sender: TObject);
begin
  //filter(modo_historico);
end;

procedure Tf_main.cbAlmacenesChange(Sender: TObject);
begin
  id_almacen := StrToInt(Copy(cbAlmacenes.Text, Pos('|', cbAlmacenes.Text) + 1, Length(cbAlmacenes.Text)));
  //filter(modo_historico);
end;

procedure Tf_main.cbPaisesClick(Sender: TObject);
begin
  //filter(modo_historico);
end;

procedure Tf_main.chFPedTodoClick(Sender: TObject);
begin
  edDiasAtras.Enabled := not chFPedTodo.Checked;
  //filter(modo_historico);
end;

procedure Tf_main.deDirChange(Sender: TObject);
begin
  { if u_globals.xls_seur<>deDir.Text then
   begin
     if MessageDlg('¿Desea actualizar la ruta por defecto para el fichero de Seur?',
                   mtWarning,mbYesNo,0,mbNo)=mrYes then
        guarda_ini_bbdd(u_globals.id_usuario,'xls_seur',deDir.Text,-1);

   end;        }
end;

procedure Tf_main.CargarDatosCorreos;
var
  str_dyn: TStringDynArray;
begin
  with tpfibdataset.Create(dm) do
  begin
    try
      database := dm.db;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select * ' + 'from g_agencias_clientes where id_cliente=:cliente and id_agencia=:agencia ');
      ParambyName('cliente').AsInteger := main_cli;
      ParambyName('agencia').AsInteger := agencia_correos;
      Open;

      if not (IsEmpty) then
      begin
        str_dyn := SplitString(fieldByName('correos').AsString, '|');

        correos_etiquetador := str_dyn[0];
        correos_contrato := str_dyn[1];
        correos_cliente := str_dyn[2];

      end;
    finally
      free;
    end;
  end;
end;

function Tf_main.CargarDatosAgencia(campos: string; cliente, agencia: Integer): string;
var
  i: integer;
begin

  Result := '';
  with tpfibdataset.Create(dm) do
  begin
    try
      database := dm.db;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select ' + campos + ' from g_agencias_clientes where id_cliente=:cliente and id_agencia=:agencia ');
      ParambyName('cliente').AsInteger := cliente;
      ParambyName('agencia').AsInteger := agencia;
      Open;

      if not (IsEmpty) then
      begin
        for i := 0 to fields.Count - 1 do
        begin
          result := Result + fields[i].text + '#';
        end;
      end;

      Result := Copy(Result, 0, Length(result) - 1);
    finally
      free;
    end;
  end;
end;

function Tf_main.LoadFieldConfigCLiente(campos: string; cliente: Integer): string;
var
  i: integer;
begin

  Result := '';
  with tpfibdataset.Create(dm) do
  begin
    try
      database := dm.db;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select ' + campos + ' from g_clientes_config where id_cliente=:cliente');
      ParambyName('cliente').AsInteger := cliente;
      Open;

      if not (IsEmpty) then
      begin
        for i := 0 to fields.Count - 1 do
        begin
          result := Result + fields[i].text + '#';
        end;
      end;

      Result := Copy(Result, 0, Length(result) - 1);
    finally
      free;
    end;
  end;
end;

procedure Tf_main.pm1Popup(Sender: TObject);
begin
    mdAsignaPAV.Enabled := not assign_pav('C',dm.q_peds.FieldByName('id_pedido').AsString);
    mdDesasignaPAV.Enabled := not mdAsignaPAV.Enabled;
end;

procedure Tf_main.pnCOnDblClick(Sender: TObject);
begin
  if HiWord(GetKeyState(VK_CONTROL)) <> 0 then
    bt2.Visible := not bt2.Visible;
end;



procedure Tf_main.ImprimirHojasPicking(peds: string);
var
  pick_cab: integer;
begin

  dm.ds_2.Close;                                                            //datos de lotes
  dm.ds_2.SQLs.SelectSQL.Clear;
  dm.ds_2.SQLs.SelectSQL.Add('SELECT pl.id_articulo as id_articulo, a.codigo, l.cantidad as uds, lt.nombre as lote, lt.caducidad,  a.nombre as nom_art,   ' + ' p.order_name, p.nombre, p.dir_1, p.poblacion, p.provincia, p.cp, p.pais, p.email, p.delivery_time, p.codalbaran, p.telefono, p.tags, ' + ' pl.cantidad as cantidad' + ' from c_pedidos p ' + ' inner join c_pedidos_lines pl on pl.id_pedido=p.id_pedido ' + ' inner join c_pedidos_lines_lotes l on l.id_pedido=p.id_pedido and pl.id_articulo=l.id_articulo ' + ' left outer join a_lotes lt on lt.id_lote=l.id_lote ' + ' left outer join g_articulos a on a.id_articulo=l.id_articulo ' + ' where p.id_pedido in (' + peds + ') ');
  dm.ds_2.Open;

  if dm.ds_2.Eof then
  begin
    ShowMessage('No se han actualizado los lotes de este pedido.');
    Exit;
  end;

  dm.ds_2.First;
  while not dm.ds_2.eof do
  begin
    f_detail.ar_pick_ds.insert;
    f_detail.ar_pick_ds.FieldByName('id_art').AsInteger := dm.ds_2.FieldByName('id_articulo').AsInteger;
    f_detail.ar_pick_ds.FieldByName('ref_art').AsString := dm.ds_2.FieldByName('codigo').AsString;
    f_detail.ar_pick_ds.FieldByName('uds').Asinteger := dm.ds_2.FieldByName('uds').AsInteger;

    dm.ds_1.Close;                                                            //ubicacion de picking
    dm.ds_1.SQLs.SelectSQL.Clear;
    dm.ds_1.SQLs.SelectSQL.Add('SELECT u.id_ubicacion,u.id_estanteria,u.id_posicion,u.id_altura,u.id_sub1,u.id_sub2 ' + ' from a_stock s ' + '   inner join a_ubicaciones u on (s.id_ubicacion=u.id_ubicacion) ' + ' where s.id_articulo=' + dm.ds_2.FieldByName('id_articulo').AsString + ' and s.cantidad>0 and u.id_zona=0 and s.id_ubicacion<>361 and s.id_empresa=1 and s.id_almacen=' + IntToStr(id_almacen) + ' order by 4,2,3');
    dm.ds_1.Open;

    f_detail.ar_pick_ds.FieldByName('id_ubic').Asinteger := dm.ds_1.FieldByName('id_ubicacion').asinteger;
    f_detail.ar_pick_ds.FieldByName('ubicacion').Asstring := dm.ds_1.FieldByName('id_estanteria').asstring + '-' + dm.ds_1.FieldByName('id_posicion').asstring + '-' + dm.ds_1.FieldByName('id_altura').asstring + '-' + dm.ds_1.FieldByName('id_sub1').asstring;
    f_detail.ar_pick_ds.FieldByName('articulo').Asstring := dm.ds_2.FieldByName('nom_art').AsString;

    f_detail.ar_pick_ds.FieldByName('pedido').asstring := dm.ds_2.FieldByName('order_name').AsString;
    f_detail.ar_pick_ds.FieldByName('nomape').asstring := dm.ds_2.FieldByName('nombre').AsString;
    f_detail.ar_pick_ds.FieldByName('direccion').asstring := dm.ds_2.FieldByName('dir_1').AsString;
    f_detail.ar_pick_ds.FieldByName('poblacion').asstring := dm.ds_2.FieldByName('poblacion').AsString;
    f_detail.ar_pick_ds.FieldByName('provincia').asstring := dm.ds_2.FieldByName('provincia').AsString;
    f_detail.ar_pick_ds.FieldByName('cp').asstring := dm.ds_2.FieldByName('cp').AsString;
    f_detail.ar_pick_ds.FieldByName('mail').asstring := dm.ds_2.FieldByName('email').AsString;
    f_detail.ar_pick_ds.FieldByName('telefono').asstring := dm.ds_2.FieldByName('telefono').AsString;
    f_detail.ar_pick_ds.FieldByName('codalbaran').AsInteger := dm.ds_2.FieldByName('codalbaran').AsInteger;
    f_detail.ar_pick_ds.FieldByName('deliv_time').Asstring := dm.ds_2.FieldByName('delivery_time').AsString;
    f_detail.ar_pick_ds.FieldByName('CodPais').Asstring := dm.ds_2.FieldByName('pais').AsString;
    f_detail.ar_pick_ds.FieldByName('Tag').asstring := UpperCase(dm.ds_2.FieldByName('tags').AsString);

    f_detail.ar_pick_ds.FieldByName('lote').asstring := Trim(dm.ds_2.FieldByName('lote').asstring);
    f_detail.ar_pick_ds.FieldByName('caducidad').asstring := dm.ds_2.FieldByName('caducidad').asstring;
    f_detail.ar_pick_ds.FieldByName('cantidad').AsInteger := dm.ds_2.FieldByName('cantidad').AsInteger;
    f_detail.ar_pick_ds.Post;
    dm.ds_2.Next;
  end;

  lb_st1.Caption := 'Picking Generado ' + inttostr(pick_cab);
  application.ProcessMessages;

  //Para Flamingos se saca en la hoja de picking el texto de devolución.
  if f_main.edCliente.Text = '7252' then
  begin
    if frdevo.PrepareReport(True) then
      frdevo.ShowPreparedReport;
  end
  else if f_detail.rep_pick.PrepareReport(True) then
    f_detail.rep_pick.ShowPreparedReport;
end;


procedure Tf_main.GeneraPedidos(pedidos: string);
var
  todo_ok: Boolean;
  errores, peds_sin_alb, msg_error, file_name, result_control, alertas: string;
  gen_log, errores_stock, errores_albs, msgs_error, errores_pick: TStringList;
  i: Integer;
  Dialog: TForm;
  strlst_peds: TStringDynArray;
begin

  InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','Ini GenPeds ' + IntToStr(main_cli),pedidos);

  lb_st1.Caption := 'Verificando Errores...';

  errores := gestiona_errores(pedidos);

  todo_ok := (errores = '');

  gen_log := TStringList.Create;
  errores_stock := TStringList.Create;
  errores_albs := TStringList.Create;
  msgs_error := TStringList.Create;
  errores_pick := TStringList.Create;
  peds_sin_alb := '';
  result_control := '';

  {if todo_ok and print_doc_cliente and (pedidos<>peds_sin_alb)  then
      imprime_doc_cliente(pedidos, peds_sin_alb);       }

  //********************************************************************* VERIFICA STOCK
  if todo_ok then
  begin
    lb_st1.Caption := 'Verificando Stock...';
    application.ProcessMessages;
    todo_ok := gestiona_stock(pedidos, errores_stock);

    if errores_stock.Count > 0 then
    begin
      for i := 0 to errores_stock.Count - 1 do
      begin
        if (mail_order_name = '') or (mail_order_name = 'order_name') then
          gen_log.Add(GetOrderNamePedido(StrToInt(errores_stock[i])) + ' Sin Stock')
        else if (mail_order_name = 'ref_cliente') then
          gen_log.Add(GetRefClientePedido(StrToInt(errores_stock[i])) + ' Sin Stock')
        else
          gen_log.Add('Id ' + errores_stock[i] + ' Sin Stock')
      end;
    end;
  end;

  //********************************************************************* GENERA ALBARANES
  if todo_ok and tiene_albs_gestoras then
  begin
    lb_st1.Caption := 'Generando Albaranes...';
    application.ProcessMessages;
    todo_ok := todo_ok and genera_albaranes(pedidos, errores_albs, msgs_error);

    if errores_albs.Count > 0 then
    begin
      for i := 0 to errores_albs.Count - 1 do
      begin
        if (mail_order_name = '') or (mail_order_name = 'order_name') then
          gen_log.Add(GetOrderNamePedido(StrToInt(errores_albs[i])) + ' Error Albarán')
        else if (mail_order_name = 'ref_cliente') then
          gen_log.Add(GetRefClientePedido(StrToInt(errores_albs[i])) + ' Error Albarán')
        else
          gen_log.Add('Id ' + errores_albs[i] + ' Error Albarán');

        gen_log.Add('        Error: ' + msgs_error[i]);
        peds_sin_alb := peds_sin_alb + errores_albs[i] + ',';
      end;
    end;

    if peds_sin_alb <> '' then
      peds_sin_alb := Copy(peds_sin_alb, 1, Length(peds_sin_alb) - 1);
  end;

  //********************************************************************* GENERA PICKING

  if todo_ok and (pack_abierto <> 3) and (pedidos<>peds_sin_alb) then    //pack_abierto=3 no genera picking
  begin
    lb_st1.Caption := 'Generando Picking...';
    application.ProcessMessages;

    try
    if not chPackAb.Checked then
    begin
      if main_cli=7078 then
      begin
         strlst_peds := SplitString(pedidos, ',');
         for I := Low(strlst_peds) to High(strlst_peds) do
           todo_ok := todo_ok and genera_picking(strlst_peds[i], peds_sin_alb, errores_pick);
      end else
          todo_ok := todo_ok and genera_picking(pedidos, peds_sin_alb, errores_pick);
    end
    else
      todo_ok := todo_ok and genera_picking_abierto(pedidos, peds_sin_alb, errores_pick);

    except on e:Exception do begin
          todo_ok := false;
          errores_pick.Add('Error generando picking. ' + e.message);
        end;
    end;

    if errores_pick.Count > 0 then
    begin
      for i := 0 to errores_pick.Count - 1 do
      begin
        gen_log.Add(errores_pick[i]);
      end;
    end;
  end;

  if todo_ok and (pack_abierto = 3) and (pedidos<>peds_sin_alb)  then  //No se genera picking, se descuenta directamente de bbdd
  begin
    lb_st1.Caption := 'Descontando cantidades de base de datos...';
    DescuentaStockBBDD(pedidos, peds_sin_alb);
  end;

  //********************************************************************* ENVIAR STATUS SENT
  if todo_ok and envia_sent then
  begin
    lb_st1.Caption := 'Enviando Status Sent...';
    todo_ok := enviar_status_sent(pedidos, peds_sin_alb);
  end;

  //********************************************************************* ENVIAR STATUS DELIVERED
  if todo_ok and envia_delivered then
  begin
    lb_st1.Caption := 'Enviando Status Delivered...';
    enviar_status_delivered('');
  end;

  //********************************************************************* INFORME SIN STOCK
  if todo_ok then
  begin
    lb_st1.Caption := 'Creando informe Sin Stock...';
    informe_sin_stock(pedidos);
  end;

  //********************************************************************* INSERTAR ADJUNTOS
  if todo_ok and tiene_adjuntos then
  begin
    lb_st1.Caption := 'Insertando adjuntos...';
    insertar_adjuntos(pedidos, peds_sin_alb);
  end
  else if errores <> '' then
    sMessageDlg('Pedidos NO generados. Revise los siguientes datos: ' + ln + errores, mtError, [mbok], 0);

  {if todo_ok and print_doc_cliente and (pedidos<>peds_sin_alb)  then
      imprime_doc_cliente(pedidos, peds_sin_alb); }

  //********************************************************************* CONTROL CLIENTE
  lb_st1.Caption := 'Pasando controles...';
  result_control := '';
  ControlesCliente(main_cli,result_control);

  if result_control<>'' then
    gen_log.Add(result_control);

  if (gen_log.Count > 0) then
  begin
    Dialog := CreateMessageDialog('Existe datos a revisar. ¿Desea verlos en pantalla o exportar a fichero?', mtWarning, [mbYes, mbNo, mbCancel]);

    TButton(Dialog.Controls[2]).Caption := 'Pantalla';
    TButton(Dialog.Controls[3]).Caption := 'Fichero';
    TButton(Dialog.Controls[4]).Caption := 'Cancelar';

    msg_error := '';
    if gen_log.Count > 0 then
      for i := 0 to gen_log.Count - 1 do
        msg_error := msg_error + gen_log[i] + ln;

    try
      case Dialog.ShowModal of
        mrYes:
          begin
            InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','GenPeds.ErroresPantalla',msg_error);
            sShowMessage('Log Generación Pedidos', msg_error);
          end;

        mrNo: begin
          file_name := IncludeTrailingPathDelimiter(ed_folder.text) + 'LOG_GENERACION_' + formatdatetime('dd_mm_yyyy__hh_nn', Now) + '.txt';
          gen_log.SaveToFile(file_name);
          InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','GenPeds.ErroresFichero',file_name + '|' + msg_error);
        end;

        mrCancel: begin
          InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','GenPeds.ErroresCancel',msg_error);
          Dialog.Close;
        end;
      end;
    finally
      Dialog.Free;
    end;
  end;

  gen_log.Free;
  errores_stock.Free;
  errores_albs.Free;
  msgs_error.Free;
  errores_pick.Free;

  if act_envios then
  begin
     InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','GenPeds.RevEtiqUS-UK','');
     lb_st1.Caption := 'Revisando etiquetas US y UK ...';
     dm_flam.cod_cli := main_cli;
     dm_flam.procesaficheros;
  end;

  InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','Fin GenPeds ' + IntToStr(main_cli),pedidos);

  lb_st1.Caption := 'Proceso Finalizado.';
  sMessageDlg('Proceso Finalizado', mtInformation, [mbok], 0);
end;

function Tf_main.GetMainCliGrupo(id_grupo: Integer): Integer;
begin
  dm.ds_2.Close;                                                            //datos de lotes
  dm.ds_2.SQLs.SelectSQL.Clear;
  dm.ds_2.SQLs.SelectSQL.Add('select principal from g_grupos_clientes where id_grupo_cliente=:id_grupo ');
  dm.ds_2.ParamByName('id_grupo').AsInteger := StrToInt(edGrupo.Text);
  dm.ds_2.Open;

  Result := dm.ds_2.FieldByName('principal').AsInteger;

end;

function Tf_main.FechaPedidoMasAntiguo(pedidos: string): TDateTime;
begin
  dm.ds_2.Close;                                                            //datos de lotes
  dm.ds_2.SQLs.SelectSQL.Clear;
  dm.ds_2.SQLs.SelectSQL.Add('select min(fecha_gen) as fecha from c_pedidos where id_pedido in (' + pedidos + ')');
  dm.ds_2.Open;

  Result := dm.ds_2.FieldByName('fecha').AsDateTime;

end;

{$ENDREGION}

{$REGION 'Chrono'}
function Tf_main.get_chrono_bulto(cp: integer): string;
var
  cliente_chrono, ch_codbulto: string;
  producto_chrono_id, ch_numbulto: integer;
begin
  if (((cp >= 35000) and (cp <= 35999)) or ((cp >= 38000) and (cp <= 38999))) then
  begin
    producto_chrono_id := 69;
  end
  else
  begin
    producto_chrono_id := 63;
  end;

  cliente_chrono := '519500001';

  with tpfibdataset.create(dm) do                                     //numero de expedicion de ChronoExpress
  try
    database := dm.db;
    close;
    sqls.SelectSQL.Clear;
    sqls.selectsql.Add('select chrono_lis_bulto ' + 'from c_aux ' + 'where id_empresa=' + inttostr(u_globals.id_empresa));
    open;

    if not (isempty) then
    begin
      ch_numbulto := fieldbyname('chrono_lis_bulto').asinteger;

      dm.q2.close;
      dm.q2.sql.clear;
      dm.q2.SQL.Add('update c_aux set chrono_lis_bulto=chrono_lis_bulto+1 where id_empresa=' + inttostr(u_globals.id_empresa));

      dm.t_write.StartTransaction;
      dm.q2.ExecQuery;
      dm.t_write.CommitRetaining;

    end
    else
      ch_numbulto := 1;
  finally
    free;
  end;

  ch_codbulto := inttostr(producto_chrono_id) + '7094' + FormatFloat('000000000', ch_numbulto) + formatfloat('00', 1) + formatfloat('00000', cp);
  ch_codbulto := ch_codbulto + inttostr(calc_digcon_chrono(ch_codbulto));

  result := ch_codbulto;
end;

function Tf_main.get_chrono_exp(codalbaran: integer): string;
var
  s: string;
begin
  s := '519500001';      //9
  s := s + FormatFloat('0000000', codalbaran);   //7
  result := s;
end;

function Tf_main.calc_digcon_chrono(codbar: string): Integer;
var
  n, l, suma: Integer;
begin
  suma := 0;
  for n := 1 to 22 do
  begin
    l := StrToInt(Copy(codbar, n, 1));
    if n / 2 = Int(n / 2) then
      suma := suma + (l * 3)
    else
      suma := suma + l;
  end;
  codbar := IntToStr(suma);
  codbar := Copy(codbar, length(codbar), 1);
  result := 10 - strtoint(codbar);
  if Result = 10 then
    Result := 0;
end;
{$ENDREGION}

{$REGION 'API'}

procedure Tf_main.GeneraUrlValidate(id_albaran: integer);
var
  BaseUrl: string;
begin
  BaseUrl := 'https://servertest.loginser.com:5443/loginser-back/api/albaran/' + inttostr(id_albaran) + '/validate';

  dm.client.BaseURL := BaseUrl;
end;

procedure Tf_main.RegeneraBultos(id_albaran: integer);
var
  estado: integer;
  jsbody: TJSONObject;
  //bultos_alb,bultos_eti:integer;
begin
  GeneraUrlValidate(id_albaran);
  try
    dm.request.ClearBody;
    jsbody := TJSONObject.Create();
    dm.request.addbody(jsbody);
    dm.request.Execute;
    estado := dm.response.StatusCode;
       //GuardaLogApi(rentorno.Nombre, client.BaseURL,inttostr(estado),response.StatusText,now);

    if estado <> 200 then
    begin
      showmessage('Han ocurrido errores al generar los bultos');
    end
    else
    begin

    end;
    jsbody.Free;
  except

  end;
end;

procedure Tf_main.CrearFicheroSeur;
begin
  CreaExcel;

  Hoja := excel.Worksheets.Item[1];
  //AbreFichero(deDirSeur.Text + '\seur.xls');

  crear_fichero;

  excel.activeworkbook.saveas(deDir.Text + '\resumen' + FormatDateTime('yyyymmddhhnnss', Now) + '.xlsx');
  Excel.Quit;
  Excel := Unassigned;

end;

{procedure Tf_main.cxGrid1DBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
    AViewInfo.GridRecord.Values[cxGrid1Level1.Index]
end;

procedure Tf_main.cxGrid1DBTableView1DblClick(Sender: TObject);
begin
    abre_detalle(0);
end;

procedure Tf_main.cxGrid1DBTableView1EditDblClick(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit);
begin
    abre_detalle(0);
end;   }

procedure Tf_main.D1Click(Sender: TObject);
begin

  dm.t_write.StartTransaction;

  try
    GuardaEtiqueta(dm.q_peds.FieldByName('id_pedido').AsString, '0|Etiqueta recibida por correo desde cliente.', -1);

    dm.q_1.Close;
    dm.q_1.sql.Clear;
    dm.q_1.sql.Add('update c_pedidos set estado=''E'',fecha_fin=:fecha_fin, enviado=''S'' where id_cliente=:id_cliente ');

    if dm.q_peds.FieldByName('id_pedido').AsString <> '' then
      dm.q_1.sql.Add('and id_pedido in (' + dm.q_peds.FieldByName('id_pedido').AsString + ')');

    dm.q_1.ParamByName('fecha_fin').asdatetime := now;
    dm.q_1.ParamByName('id_cliente').AsInteger := StrToInt(edCliente.Text);
    dm.q_1.ExecQuery;

    dm.t_write.Commit;

    if envia_correo_a_dst and (dm.q_peds.FieldByName('fecha_ped').AsDateTime>=date_mail_dest) then
      if GetExtraPedido(dm.q_peds.FieldByName('id_pedido').AsInteger,'DATE_MAIL_DEST')='' then
            enviar_email_pedidos(dm.q_peds.FieldByName('id_pedido').AsInteger);
  except
    dm.t_write.Rollback;
  end;

  filter(modo_historico);
end;

{$ENDREGION 'API'}

procedure Tf_main.AbreFichero(ruta: string);
begin
  Excel := CreateOleObject('Excel.Application');
  try
    Excel.Visible := False;
    Excel.DisplayAlerts := False;
    Excel.WorkBooks.Open(ruta); //fichero que queremos leer
  except
    Excel.Quit;
    Excel := Unassigned;
  end;
end;

procedure Tf_main.CalculaPendientes;
var
  lbl1, lbl2: TsLabel;
  pn: TsPanel;
  img: TImage;
  ruta_logo: string;
  top_pn, left_pn, cont, i: integer;
begin
  lb_st1.Caption := 'Calculando pendientes...';

  for i := 0 to pnPtes.ControlCount - 1 do
  begin
    pnPtes.Controls[0].Free;
  end;

  with dm.q_pendientes do
  begin
    Close;
    database := dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select p.id_cliente, substring (cl.nombre from 1 for 5), count(*) as cuenta ' +
                       'from c_pedidos p ' + 'inner join g_clientes cl on cl.id_cliente=p.id_cliente ' +
                       'where p.estado in (''P'') ' +
                       'group by 1,2 ' +
                       'having count(*)>0');
    Open;

    if not (IsEmpty) then
    begin
      pnPtes.Caption := '';
      First;

      top_pn := 10;
      left_pn := 10;
      cont := 1;

      while not Eof do
      begin
        pn := TsPanel.Create(f_main);
        pn.Parent := pnPtes;
        pn.Name := 'pn' + FieldByName('id_cliente').AsString;
        pn.Top := top_pn;
        pn.Left := left_pn;
        pn.Width := 120;
        pn.Height := 30;
        pn.SkinData.ColorTone := clYellow;
        pn.Caption := '';
             //pn.AutoSize := True;

             //ruta_logo := CargarDatosTablaGestoras('clientes','ruta_logo','cliente='+FieldByName('id_cliente').AsString);
        ruta_logo := '';
        ruta_logo := ReplaceStr(ruta_logo, 'seth', '192.168.0.6');

        if (ruta_logo <> '') and (FileExists(ruta_logo)) then
        begin
          img := TImage.Create(f_main);
          img.Parent := pn;
          img.Name := 'img' + FieldByName('id_cliente').AsString;
          img.Top := 1;
          img.Left := 1;
          img.Width := 50;
          img.Height := 30;
          img.Picture.LoadFromFile(ruta_logo);
          img.AutoSize := false;
          img.Stretch := True;
          img.Proportional := True;
          img.Transparent := True;
        end
        else
        begin
          lbl1 := TsLabel.Create(f_main);
          lbl1.Parent := pn;
          lbl1.Name := 'lb' + FieldByName('id_cliente').AsString;
          lbl1.Top := 5;
          lbl1.Left := 5;
          lbl1.Width := 50;
          lbl1.Caption := FieldByName('id_cliente').AsString;
          lbl1.Font.Color := clred;
          lbl1.Font.Style := [fsbold];
          lbl1.Alignment := taLeftJustify;
          if Length(FieldByName('id_cliente').AsString)<=4 then
              lbl1.Font.Size := 15
          else
              lbl1.Font.Size := 13;
          lbl1.UseSkinColor := False;
          lbl1.Transparent := true;
          lbl1.Hint := BuscaCliente(FieldByName('id_cliente').AsString);
          lbl1.ShowHint := True;
          if Pos(FieldByName('id_cliente').AsString, clientes_no_10) = 0 then
            lbl1.OnDblClick := ClickLabels;

        end;

        lbl2 := TsLabel.Create(f_main);
        lbl2.Parent := pn;
        lbl2.Name := 'lbcount' + FieldByName('id_cliente').AsString;
        lbl2.Top := 5;
        lbl2.Left := 75;
        lbl2.Width := 80;
        lbl2.Caption := FieldByName('cuenta').AsString;
        lbl2.Font.Color := clGreen;
        lbl2.Font.Style := [fsbold];
        lbl2.Alignment := taRightJustify;
        lbl2.Font.Size := 15;
        lbl2.UseSkinColor := False;
        lbl2.Transparent := true;

        top_pn := top_pn + 35;

        Next;
        Inc(cont);

        if (cont = 4) or (cont = 7) or (cont = 10) or (cont = 13) or (cont = 16) then
        begin
          top_pn := 10;
          left_pn := left_pn + 125;
        end;
      end;

      if cont > 3 then
      begin
                //pnPtes.Width := round(cont/3)*120+20;
        pnPtes.Width := 640;
        pnptes.Height := 120;
      end
      else
      begin
                //pnPtes.Width := 130;
        pnPtes.Width := 640;
                //pnPtes.Height := 40 * (cont-1);
        pnptes.Height := 120;
      end;
    end
    else
      pnPtes.Caption := 'No existen pedidos pendientes.';
  end;
  lb_st1.Caption := '';
end;

procedure Tf_main.RecalculaPendientes;
var
  lbl2: Tcomponent;
begin
  dm.q_aux.Close;
  dm.q_aux.database := dm.db;
  dm.q_aux.SQLs.SelectSQL.Clear;
  dm.q_aux.SQLs.SelectSQL.Add('select p.id_cliente, substring (cl.nombre from 1 for 5), count(*) as cuenta ' +
  'from c_pedidos p ' +
  'inner join g_clientes cl on cl.id_cliente=p.id_cliente ' +
  'where p.estado in (''P'') ' +
  'group by 1,2 ' +
  'having count(*)>0');
  dm.q_aux.Open;

  if not (dm.q_aux.IsEmpty) then
  begin
    dm.q_aux.First;

    while not dm.q_aux.Eof do
    begin

             //pn.Name := 'pn'+FieldByName('id_cliente').AsString;
             //lbl1.Name := 'lb'+FieldByName('id_cliente').AsString;
      lbl2 := FindComponent('pn' + dm.q_aux.FieldByName('id_cliente').AsString);

      if Assigned(lbl2) then
        Tspanel(lbl2).Free;
                //TsLabel(lbl2).Caption := dm.q_aux.FieldByName('cuenta').AsString;
      dm.q_aux.Next;

    end;

  end;

  ShowMessage(pnPtes.ComponentCount.ToString);

end;

procedure Tf_main.ClickLabels(Sender: TObject);
begin
  if not modo_historico then
  begin

  with tpfibdataset.Create(dm) do
  begin
    database := dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select * from g_clientes_config_ where id_cliente=:id_cliente and ((item=''tiene_gp'') and (valor=''1'')) ');
    ParambyName('id_cliente').asinteger := StrToInt(TsLabel(Sender).Caption);
    Open;

    if (IsEmpty) then
    begin
      if MessageDlg('Cliente NO configurado para su uso en esta aplicación. ¿desea activarlo?',mtWarning,mbYesNo,0)=mrYes then
      begin
         If MessageDlg('Se va a activar el cliente ' + TsLabel(Sender).Caption + ' con la configuración básica. ¿desea continuar?',mtWarning,mbYesNo,0)=mrYes then
         begin

             with TpFIBQuery.Create(dm) do
             try
               Close;
               database := dm.db;
               transaction := dm.t_write;
               sql.Clear;
               sql.Add('insert into g_clientes_config_(id_cliente,item,valor,descripcion,tipo) values (:id_cliente,''tiene_gp'',''1'',''Tiene pedidos de almacén. Activado desde G.Pedidos'',''CHK'')');
               ParamByName('id_cliente').asinteger := StrToInt(TsLabel(Sender).Caption);
               dm.t_write.StartTransaction;
               try
                ExecQuery;

                dm.t_write.Commit;
                ShowMessage('Cliente activado correctamente.');
               except
                  dm.t_write.Rollback;
                  ShowMessage('Error al activar el cliente. Contacte con Sistemas.');
                  Exit;
               end;
             finally
                Free;
             end;

         end else
                Exit;
      end else
            Exit;
    end;

    Free;
  end;

  edCliente.Text := TsLabel(Sender).Caption;
  edClienteChange(self);
  if not locked then
    btLockClick(Self)
  else
  begin
    case rgTipoGes.ItemIndex of
      0:
        lbCliente.Font.Color := 16;
      1:
        lbgrupo.Font.Color := 16;
    end;

    CargaInterfaz;

    if main_cli=7252 then
    begin
       if (MessageDlg('Se van a actualizar el seguiminto de UPS para UK y US, ¿desea continuar?', mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes) then
       begin
           Screen.Cursor := crHourglass;
           dm_flam.cod_cli := main_cli;
           dm_flam.procesaficheros;
           Screen.Cursor := crDefault;
       end;
    end;

    filter(modo_historico);
  end;
  end else
        ShowMessage('Desactive el modo histórico para continuar.');

end;

procedure Tf_main.clServerKeyValidate(Sender: TObject; NewServerKey: TScKey;
  var Accept: Boolean);
begin
   Accept:=True;
end;



function Tf_main.gestiona_errores(pedidos: string): string;
var
  lst_peds: TStringList;
  j: integer;
begin
  InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','',
                   'Ini GenPeds.GestErrores',pedidos);

  lst_peds := TStringList.Create;
  lst_peds.Delimiter := ',';
  lst_peds.DelimitedText := pedidos;

  with tpfibdataset.Create(dm) do
  begin

    database := dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select resultado from get_pedido_errores(:pedido)');

    for j := 0 to lst_peds.Count - 1 do
    begin
      Close;
      ParambyName('pedido').asinteger := StrToInt(lst_peds[j]);
      try
      Open;
      except on E:Exception do
      begin
         Result := Result + GetOrderNamePedido(StrToInt(lst_peds[j])) + ': ' + e.Message;
         InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','',
                   'Error GenPeds.GestErrores',pedidos + ' ' + result);
      end;

      end;

      if FieldByName('resultado').AsString <> '' then
        Result := Result + GetOrderNamePedido(StrToInt(lst_peds[j])) + ': ' + FieldByName('resultado').AsString + ln;
    end;

    Free;
  end;

  FreeAndNil(lst_peds);

  InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','',
                   'Fin GenPeds.GestErrores',pedidos + ' ' + result);
end;

procedure Tf_main.CreaExcel;
begin
  excel := CreateOleObject('Excel.Application');
  try
    excel.Visible := False;
    excel.DisplayAlerts := False;
    excel.WorkBooks.add;
  except
    excel.Quit;
    excel := Unassigned;
  end;

end;

function Tf_main.EnviaPedidos(pedidos: string): string;
var
  pedido: TStringDynArray;
  pedidos_enviados: string;
  i, codalbaran, id_dest: Integer;
begin
  pedido := SplitString(pedidos, ',');

  for i := Low(pedido) to High(pedido) do
  begin
    if not tiene_etiquetas(StrToInt(pedido[i])) then
    begin
      //agencia := StrToInt(CargarDatosTabla('c_pedidos', 'id_repartidor', 'id_pedido=' + pedido[i]));
      lb_st1.Caption := 'Enviando pedido ' + pedido[i] + '...';

      codalbaran := GetAlbaranPedido(StrToInt(pedido[i]));
      id_dest := GetIdDestinoPedido(StrToInt(pedido[i]));

      //if CargarDatosTablaGestoras('agencias','lstname_etiqueta','agencia='+ InttoStr(GetRelacionAgencia(agencia)) )='ETI_LOGINSER' then
      if dmLabels.GetFormatoEtiqueta(codalbaran) = 'ETI_LOGINSER' then
        begin
         dmLabels.imp_eti := u_globals.imp_eti;
         dmLabels.imprime_etiqueta_loginser(codalbaran, id_dest, logo_cli_etiq);
        end
      else
        f_detail.imprime_etiqueta_x_api(codalbaran);

      if envia_correo_a_dst and (GetFechaPedido(StrToInt(pedido[i]))>date_mail_dest) then
        if GetExtraPedido(StrToInt(pedido[i]),'DATE_MAIL_DEST')='' then
            enviar_email_pedidos(StrToInt(pedido[i]));

      pedidos_enviados := pedidos_enviados + dm.q_peds.FieldByName('id_pedido').AsString + ',';

    end;
  end;

  Result := Copy(pedidos_enviados, 0, Length(pedidos_enviados) - 1);
end;

function Tf_main.EnviaPedido(pedido: integer): string;
var
  pedidos_enviados: string;
  agencia, codalbaran, id_dest: Integer;
begin
  try
    if not tiene_etiquetas(pedido) then
    begin
      agencia := GetAgenciaPedido(pedido);

      lb_st1.Caption := 'Enviando pedido ' + IntToStr(pedido) + ' a ' + GetNombreAgencia(agencia) + '...';

      codalbaran := GetAlbaranPedido(pedido);
      id_dest := GetIdDestinoPedido(pedido);

      {if (CargarDatosTablaGestoras('agencias','lstname_etiqueta','agencia='+ InttoStr(GetRelacionAgencia(agencia)) )='ETI_LOGINSER')
         and (agencia<>20) then  }
      if dmLabels.GetFormatoEtiqueta(codalbaran) = 'ETI_LOGINSER' then
        begin
         dmLabels.imp_eti := u_globals.imp_eti;
         dmLabels.imprime_etiqueta_loginser(codalbaran, id_dest, logo_cli_etiq);
         InsertaLog(usuario.id,pedido,0,PC.Nombre,PC.IP,log_app,'pedido','','Et.Loginser ' + IntToStr(pedido),'Alb.'+IntToStr(codalbaran));
        end
      else
      begin
        try
          f_detail.imprime_etiqueta_x_api(codalbaran);
          InsertaLog(usuario.id,pedido,0,PC.Nombre,PC.IP,log_app,'pedido','','Et.API ' + IntToStr(pedido),'Alb.'+IntToStr(codalbaran));
        except
          on e: exception do
          begin
            raise exception.create(e.message);
          end;

        end;
      end;

      if envia_correo_a_dst and (GetExtraPedido(pedido,'DATE_MAIL_DEST')='') then
          enviar_email_pedidos(pedido);

      pedidos_enviados := pedidos_enviados + IntToStr(pedido) + ',';

      Result := 'OK';
    end
    else
      result := 'EXISTE';
  except on e:exception do
    Result := 'ERROR ' + e.message;
  end;

end;

procedure Tf_main.RellenaPaises;
var
  s: string;
begin
  with TpFIBDataSet.Create(self) do
  try
    Database := dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select distinct pais_code, pais ');

    SelectSQL.Add(' from c_pedidos p ');

    if rgTipoGes.ItemIndex = 1 then
      SelectSQL.Add('inner join g_clientes cl on cl.id_cliente=p.id_cliente ');

    if rb_alldate.checked then
      SQLs.SelectSQL.Add('where 1=1 ')
    else
    begin
      SQLs.SelectSQL.Add('where cast(fecha_imp as date) between :f1 and :f2 ');
      ParamByName('f1').AsDate := de_ini.Date;
      ParamByName('f2').AsDate := de_fin.Date;

    end;

    if not rb_alldate_gen.checked then
    begin
      SQLs.SelectSQL.Add(' and cast(fecha_gen as date) between :f1_gen and :f2_gen ');
      ParamByName('f1_gen').AsDate := de_ini_gen.Date;
      ParamByName('f2_gen').AsDate := de_fin_gen.Date;
    end;

    if not rb_alldate_env.checked then
    begin
      SQLs.SelectSQL.Add(' and cast(fecha_fin as date) between :f1_fin and :f2_fin ');
      ParamByName('f1_fin').AsDate := de_ini_env.Date;
      ParamByName('f2_fin').AsDate := de_fin_env.Date;
    end;

    case rgTipoGes.ItemIndex of
      0:
        begin
          SQLs.SelectSQL.Add(' and id_cliente=:cli ');
          ParamByName('cli').AsString := edCliente.Text;
        end;

      1:
        begin
          SQLs.SelectSQL.Add(' and cl.id_grupo_cliente=:gru ');
          ParamByName('gru').AsString := edGrupo.Text;
        end;
    end;

    s := '';
    case (rg_state.ItemIndex) of
      0:
        s := 'and p.estado=''P'' ';          //Pendientes
      1:
        s := 'and p.estado=''X'' ';          //sin stock
      2:
        s := 'and p.estado=''G'' ';          //generados
      3:
        s := 'and p.estado=''E'' ';          //finalizados/enviados
      4:
        s := 'and p.estado=''A'' ';          //anulados
      5:
        s := 'and p.estado=''C'' ';          //cancelados por cliente
        //6: s:='and p.estado=''D'' ';          //devoluciones
      6:
        s := 'and p.estado=''I'' ';          //incidencias
    end;

    if ch_order_name.Checked then
    begin
      SQLs.SelectSQL.Add('and order_name like :busc ');
      ParamByName('busc').AsString := '%' + ed_search_order.Text + '%';

    end;

    if ch_albaran.Checked and (StrToIntDef(ed_search_albaran.Text, -1) <> -1) then
    begin
      SQLs.SelectSQL.Add('and codalbaran like :busc2 ');
      ParamByName('busc2').AsString := '%' + ed_search_albaran.Text + '%';
    end;

    if ch_articulo.Checked then
    begin
      SQLs.SelectSQL.Add('and id_pedido in (select id_pedido from c_pedidos_lines where id_articulo=:id_art) ');
      ParamByName('id_art').asinteger := busca_art(ed_art.Text,main_cli);

    end;

    if ch_idorder.Checked then
    begin
      SQLs.SelectSQL.Add('and id_order like :busc ');
      ParamByName('busc').AsString := '%' + ed_search_idorder.Text + '%';
    end;

    if chConRetorno.Checked then
    begin
      SQLs.SelectSQL.Add('and con_retorno=1 ');
    end;

    SelectSQL.Add(s);

    s := '';
    if cbAgencias.ItemIndex > 0 then
    begin
      s := ' and id_repartidor=' + Copy(cbAgencias.Text, Pos('|', cbAgencias.Text) + 1, Length(cbAgencias.Text));
      SelectSQL.Add(s);
    end;

    s := 'order by pais';

    SQLs.SelectSQL.Add(s);

    Open;
    First;
    cbPaises.Items.Clear;
    cbPaises.Items.Add('TODOS');
    while not Eof do
    begin
      cbPaises.Items.add(FieldByName('PAIS').AsString + '|' + FieldByName('PAIS_CODE').AsString);
      Next;
    end;

  finally
    free;
  end;
end;

procedure Tf_main.RellenaAgencias;
var
  s: string;
begin
  with TpFIBDataSet.Create(self) do
  try
    Database := dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select distinct a.id_agencia, a.nombre ');

    SelectSQL.Add(' from c_pedidos p ');
    SelectSQL.Add(' inner join g_agencias a on a.id_agencia=p.id_repartidor  ');

    if rgTipoGes.ItemIndex = 1 then
      SelectSQL.Add('inner join g_clientes cl on cl.id_cliente=p.id_cliente ');

    if rb_alldate.checked then
      SQLs.SelectSQL.Add('where 1=1 ')
    else
    begin
      SQLs.SelectSQL.Add('where cast(fecha_imp as date) between :f1 and :f2 ');
      ParamByName('f1').AsDate := de_ini.Date;
      ParamByName('f2').AsDate := de_fin.Date;

    end;

    if not rb_alldate_gen.checked then
    begin
      SQLs.SelectSQL.Add(' and cast(fecha_gen as date) between :f1_gen and :f2_gen ');
      ParamByName('f1_gen').AsDate := de_ini_gen.Date;
      ParamByName('f2_gen').AsDate := de_fin_gen.Date;
    end;

    if not rb_alldate_env.checked then
    begin
      SQLs.SelectSQL.Add(' and cast(fecha_fin as date) between :f1_fin and :f2_fin ');
      ParamByName('f1_fin').AsDate := de_ini_gen.Date;
      ParamByName('f2_fin').AsDate := de_fin_gen.Date;
    end;

    case rgTipoGes.ItemIndex of
      0:
        begin
          SQLs.SelectSQL.Add(' and id_cliente=:cli ');
          ParamByName('cli').AsString := edCliente.Text;
        end;

      1:
        begin
          SQLs.SelectSQL.Add(' and cl.id_grupo_cliente=:gru ');
          ParamByName('gru').AsString := edGrupo.Text;
        end;
    end;

    s := '';
    case (rg_state.ItemIndex) of
      0:
        s := 'and p.estado=''P'' ';          //Pendientes
      1:
        s := 'and p.estado=''X'' ';          //sin stock
      2:
        s := 'and p.estado=''G'' ';          //generados
      3:
        s := 'and p.estado=''E'' ';          //finalizados/enviados
      4:
        s := 'and p.estado=''A'' ';          //anulados
      5:
        s := 'and p.estado=''C'' ';          //cancelados por cliente
        //6: s:='and p.estado=''D'' ';          //devoluciones
      6:
        s := 'and p.estado=''I'' ';          //incidencias
    end;

    if ch_order_name.Checked then
    begin
      SQLs.SelectSQL.Add('and order_name like :busc ');
      ParamByName('busc').AsString := '%' + ed_search_order.Text + '%';

    end;

    if ch_albaran.Checked and (StrToIntDef(ed_search_albaran.Text, -1) <> -1) then
    begin
      SQLs.SelectSQL.Add('and codalbaran like :busc2 ');
      ParamByName('busc2').AsString := '%' + ed_search_albaran.Text + '%';
    end;

    if ch_articulo.Checked then
    begin
      SQLs.SelectSQL.Add('and id_pedido in (select id_pedido from c_pedidos_lines where id_articulo=:id_art) ');
      ParamByName('id_art').asinteger := busca_art(ed_art.Text,main_cli);

    end;

    if ch_idorder.Checked then
    begin
      SQLs.SelectSQL.Add('and id_order like :busc ');
      ParamByName('busc').AsString := '%' + ed_search_idorder.Text + '%';
    end;

    if chConRetorno.Checked then
    begin
      SQLs.SelectSQL.Add('and con_retorno=1 ');
    end;

    SelectSQL.Add(s);

    s := '';
    if cbPaises.ItemIndex > 0 then
    begin
      s := ' and pais_code=' + QuotedStr(Copy(cbPaises.Text, Pos('|', cbPaises.Text) + 1, Length(cbPaises.Text)));
      SelectSQL.Add(s);
    end;

    s := 'order by pais';

    SQLs.SelectSQL.Add(s);

    Open;
    First;
    cbAgencias.Items.Clear;
    cbAgencias.Items.Add('TODOS');
    while not Eof do
    begin
      cbAgencias.Items.add(FieldByName('NOMBRE').AsString + '|' + FieldByName('id_agencia').AsString);
      Next;
    end;

  finally
    free;
  end;
end;

procedure Tf_main.RellenaRepartidores;
begin
  with TpFIBDataSet.Create(self) do
  try
    Database := dm.db;
    SQLs.SelectSQL.Clear;
    sqls.SelectSQL.Add('select * from g_agencias order by nombre');
    Open;
    First;
    cbAgencias.Items.Clear;
    cbAgencias.Items.Add('TODOS');
    while not Eof do
    begin
      cbAgencias.Items.Add(FieldByName('NOMBRE').AsString + '|' + FieldByName('id_agencia').AsString);
      Next;
    end;

  finally
    free;
  end;
end;

procedure Tf_main.RellenaAlmacenes;
begin

  with TpFIBDataSet.Create(self) do
  try
    Database := dm.db;
    SQLs.SelectSQL.Clear;
    sqls.SelectSQL.Add('select * from a_almacenes ');
    sqls.SelectSQL.Add('where id_almacen in (' + alm_cliente + ') ');

    if alm_usuario <> '' then
      sqls.SelectSQL.Add('and id_almacen in (' + alm_usuario + ') ');

      //sqls.SelectSQL.Add('order by nombre');
    Open;
    First;
    cbAlmacenes.Items.Clear;
      //cbAgencias.Items.Add('TODOS');
    while not Eof do
    begin
      cbAlmacenes.Items.Append(FieldByName('NOMBRE').AsString + '|' + FieldByName('id_almacen').AsString);
      Next;
    end;

    cbAlmacenes.ItemIndex := 0;
  finally
    free;
  end;
end;

procedure Tf_main.abre_detalle(modo: integer);
var
  form1: TForm;
begin
  if not tiene_detalle_a_medida then
  begin
    u_detail.mode := modo;
    f_detail.ShowModal;

    {Form1 := u_detail.Tf_detail.Create(Self);
    form1.Caption := 'Detalle de Expedición ';
    Form1.ShowModal;     }

  end
  else
  begin
    if main_cli = 7551 then
    begin
      u_llaves.mode := modo;
      form1 := u_llaves.Tf_llaves.Create(Self);
      form1.Caption := edCliente.Text + ' ' + lbCliente.Caption;
      form1.ShowModal;
      form1.Free;
    end;
  end;

end;

function Tf_main.DescuentaStockBBDD(pedidos, peds_sin_alb: string): Boolean;
type
  Tstk = record
    id_art, id_ubi, id_mat, id_lote, cantidad: integer;
  end;
var
  descontado, art_actual, id_matricula, id_ubicacion, stock, id_lote, descontar, idx_stk, i: integer;
  stk: array of tstk;
begin
  result := True;

  with TpFIBDataSet.Create(self) do
  try
    Database := dm.db;
    sqls.SelectSQL.Add('select l.id_articulo,sum(l.cantidad) as uds ' + 'from c_pedidos_lines l ' + 'where l.cantidad>0 ');

    if pedidos <> '' then
      sqls.SelectSQL.Add(' and l.id_pedido in (' + pedidos + ') ');

    if peds_sin_alb <> '' then
      sqls.SelectSQL.Add(' and l.id_pedido not in (' + peds_sin_alb + ') ');

    sqls.SelectSQL.Add(' group by l.id_articulo');
    Open;

    first;

    art_actual := 0;
    idx_stk := 0;
    setlength(stk, idx_stk);

    while (not (Eof)) do
    begin
      if art_actual <> FieldByName('id_articulo').AsInteger then
      begin
        descontado := 0;

        art_actual := FieldByName('id_articulo').AsInteger;

        dm.q_2.Close;
        dm.q_2.SQLs.SelectSQL.Clear;
        dm.q_2.SQLs.SelectSQL.Add('select id_matricula, id_ubicacion, id_lote, cantidad ');
        dm.q_2.SQLs.SelectSQL.Add('from a_stock ');
        dm.q_2.SQLs.SelectSQL.Add('where (id_departamento = 0 or id_departamento is null) ');
        dm.q_2.SQLs.SelectSQL.Add('and id_articulo = :id_art and id_almacen=:id_almacen ');
        dm.q_2.SQLs.SelectSQL.Add('and id_ubicacion NOT IN (SELECT aa.ubic_entrada FROM A_ALMACENES aa WHERE aa.ubic_entrada IS NOT null)');
        dm.q_2.SQLs.SelectSQL.Add('order by cantidad');
        if StrToInt(cl_padres[0])<0 then
             dm.q_2.ParamByName('id_art').AsInteger := FieldByName('id_articulo').AsInteger
        else
             //dm.q_2.ParamByName('id_art').AsInteger := busca_art(get_codcli_art(FieldByName('id_articulo').asinteger),cl_padre);
             dm.q_2.ParamByName('id_art').AsInteger := busca_articulo_heredado(FieldByName('id_articulo').asinteger);
        dm.q_2.ParamByName('id_almacen').AsInteger := id_almacen;
        dm.q_2.Open;
        dm.q_2.First;
      end;

      id_matricula := dm.q_2.FieldByName('id_matricula').AsInteger;
      id_ubicacion := dm.q_2.FieldByName('id_ubicacion').AsInteger;
      id_lote := dm.q_2.FieldByName('id_lote').AsInteger;
      stock := dm.q_2.FieldByName('cantidad').AsInteger;

      if stock >= (FieldByName('uds').AsInteger - descontado) then
        descontar := (FieldByName('uds').AsInteger - descontado)
      else
      begin
        descontar := stock;
        dm.q_2.Next;
      end;

      descontado := descontado + descontar;

      Inc(idx_stk);
      setlength(stk, idx_stk);
      if StrToInt(cl_padres[0])<0 then
           stk[idx_stk - 1].id_art := FieldByName('id_articulo').asinteger
        else
           stk[idx_stk - 1].id_art := busca_articulo_heredado(FieldByName('id_articulo').asinteger);
      stk[idx_stk - 1].id_ubi := id_ubicacion;
      stk[idx_stk - 1].id_mat := id_matricula;
      stk[idx_stk - 1].id_lote := id_lote;
      stk[idx_stk - 1].cantidad := descontar;

      if descontado = FieldByName('uds').AsInteger then
        Next;
    end;

    i := 0;

    dm.t_write.StartTransaction;
    try
      while (i < idx_stk) do
      begin
        dm.q_1.Close;
        dm.q_1.SQL.Clear;
        dm.q_1.SQL.Add('update a_stock set cantidad=cantidad-:cantidad ');
        dm.q_1.SQL.Add('where id_articulo=:id_art and id_matricula=:id_mat ');
        dm.q_1.SQL.Add('and id_ubicacion=:id_ubi and id_lote=:id_lote and id_almacen=:id_almacen');
        dm.q_1.ParamByName('id_art').AsInteger := stk[i].id_art;
        dm.q_1.ParamByName('id_mat').AsInteger := stk[i].id_mat;
        dm.q_1.ParamByName('id_ubi').AsInteger := stk[i].id_ubi;
        dm.q_1.ParamByName('id_lote').asInteger := stk[i].id_lote;
        dm.q_1.ParamByName('id_almacen').AsInteger := id_almacen;
        dm.q_1.ParamByName('cantidad').AsInteger := stk[i].cantidad;
        dm.q_1.ExecQuery;
        Inc(i);
      end;

      dm.t_write.Commit;
    except
      dm.t_write.Rollback;
      result := False;
    end;
  finally
    free;
  end;

end;

function Tf_main.DownloadToStream(Url: string; Stream: TStream): Boolean;
var
  hNet: HINTERNET;
  hUrl: HINTERNET;
  Buffer: array[0..10240] of Char;
  BytesRead: DWORD;
begin
  Result := FALSE;
  hNet := InternetOpen('agent', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
  if (hNet <> nil) then
  begin
    hUrl := InternetOpenUrl(hNet, PChar(Url), nil, 0, INTERNET_FLAG_RELOAD, 0);
    if (hUrl <> nil) then
    begin
      while (InternetReadFile(hUrl, @Buffer, sizeof(Buffer), BytesRead)) do
      begin
        if (BytesRead = 0) then
        begin
          Result := TRUE;
          break;
        end;
        Stream.WriteBuffer(Buffer, BytesRead);
      end;
      InternetCloseHandle(hUrl);
    end;
    InternetCloseHandle(hNet);
  end;
end;

function Tf_main.DownloadToBmp(Url: string; Bitmap: TBitmap): Boolean;
var
  Stream: TMemoryStream;
  Jpg: TJPEGImage;
begin
  Result := FALSE;
  Stream := TMemoryStream.Create;
  try
    try
      if DownloadToStream(Url, Stream) then
      begin
        Jpg := TJPEGImage.Create;
        try
          Stream.Seek(0, soFromBeginning);
          Jpg.LoadFromStream(Stream);
          Bitmap.Assign(Jpg);
          Result := TRUE;
        finally
          Jpg.Free;
        end;
      end;
    finally
      Stream.Free;
    end;
  except
  end;
end;

procedure Tf_main.CambiaEstadoPedido(pedidos, estado_ini, estado_fin: string);
begin
  dm.t_write.StartTransaction;
  try
    dm.q_1.Close;
    dm.q_1.sql.Clear;
    dm.q_1.sql.Add('update c_pedidos set estado=:estado ');

    if estado_fin = 'G' then
      dm.q_1.sql.Add(',fecha_gen=:fecha_gen ');

    if ((pack_abierto = 3) or (estado_fin = 'E')) then
      dm.q_1.sql.Add(',fecha_fin=:fecha_fin ');

    if estado_fin = 'E' then
      dm.q_1.sql.Add(',enviado=''S'' ');

    dm.q_1.sql.Add(' where estado=:estado_ini and id_cliente=:id_cliente ');

    if pedidos <> '' then
      dm.q_1.sql.Add('and id_pedido in (' + pedidos + ')');
    dm.q_1.ParamByName('estado_ini').Asstring := estado_ini;

    if estado_fin = 'G' then
      dm.q_1.ParamByName('fecha_gen').asdatetime := now;

    if ((pack_abierto = 3) or (estado_fin = 'E')) then //Si no se genera un picking se finaliza directamente
      dm.q_1.ParamByName('fecha_fin').asdatetime := now;

    dm.q_1.ParamByName('id_cliente').AsInteger := StrToInt(edCliente.Text);
    dm.q_1.ParamByName('estado').AsString := estado_fin;
    dm.q_1.ExecQuery;
    dm.t_write.Commit;

    InsertaLog(u_main.usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','',
               'Cambio Est.=' + estado_fin + ' Peds.' + pedidos,'');
  except
    on e: Exception do
    begin
      dm.t_write.rollback;
      lb_st1.Caption := 'Proceso no realizado.';
      InsertaLog(u_main.usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','',
               'Error Cambio Est.=' + estado_fin + ' Peds.' + pedidos,'');
      raise Exception.Create(E.Message);
    end;
  end;
end;

procedure Tf_main.CambiaAlbaranPedido(pedido, codalbaran, id_destino: integer);
begin
  dm.t_write.StartTransaction;
  try
    dm.q_1.Close;
    dm.q_1.sql.Clear;
    dm.q_1.sql.Add('update c_pedidos set codalbaran=:codalbaran, gestoras_dest=:id_destino ');
    dm.q_1.sql.Add('where id_pedido=:id_pedido ');
    dm.q_1.ParamByName('id_pedido').asinteger := pedido;
    dm.q_1.ParamByName('codalbaran').AsInteger := codalbaran;
    dm.q_1.ParamByName('id_destino').AsInteger := id_destino;
    dm.q_1.ExecQuery;
    dm.t_write.Commit;
        InsertaLog(u_main.usuario.id,pedido,0,PC.Nombre,PC.IP,log_app,'pedido','',
               'UpdAlbEnPed.' + IntToStr(pedido),IntToStr(codalbaran));
  except
    on e: Exception do
    begin
      dm.t_write.rollback;
      raise Exception.Create(E.Message);
    end;
  end;
end;


procedure Tf_main.borrar;
var
  line, col: Integer;
begin
  CreaExcel;

  Hoja := excel.Worksheets.Item[1];

  with TpFIBDataSet.Create(self) do
  try
    Database := dm.db_gestoras;
    sqls.SelectSQL.Add('select * ' + 'from albaranes  ' + 'where cliente=:id_cliente and fecha_albaran between ''10/01/2020'' and ''10/31/2020'' order by id_albaran ');
    ParamByName('id_cliente').AsInteger := 7542;
    Open;

    first;

    Hoja := excel.Worksheets.Item[1];

    line := 1;

    excel.cells[1, 1] := 'ALBARAN';
    excel.cells[1, 2] := 'FECHA';
    excel.cells[1, 3] := 'REF_CLIENTE';
    excel.cells[1, 4] := 'NOMBRE';
    excel.cells[1, 5] := 'DIRECCION';
    excel.cells[1, 6] := 'CP';
    excel.cells[1, 7] := 'LOCALIDAD';
    excel.cells[1, 8] := 'PROVINCIA';
    excel.cells[1, 9] := 'PAIS';

    while not (Eof) do
    begin
      inc(line);
      excel.cells[line, 1] := fieldbyname('id_albaran').AsString;
      excel.cells[line, 2] := fieldbyname('fecha_albaran').AsDateTime;
      excel.cells[line, 3] := fieldbyname('ref_cliente').AsString;

      dm.ds_1.close;
      dm.ds_1.Database := dm.db_gestoras;
      dm.ds_1.Transaction := dm.t_write_gestoras;
      dm.ds_1.SelectSQL.Clear;
      dm.ds_1.SelectSQL.Add('select * from albaran_dest where id_albaran=:id_albaran');
      dm.ds_1.ParamByName('id_albaran').AsInteger := FieldByName('id_albaran').AsInteger;
      dm.ds_1.Open;
      dm.ds_1.First;

      excel.cells[line, 4] := dm.ds_1.FieldByName('nombre').AsString;
      excel.cells[line, 5] := dm.ds_1.FieldByName('calle').AsString;
      excel.cells[line, 6] := dm.ds_1.FieldByName('cod_postal').AsString;
      excel.cells[line, 7] := dm.ds_1.FieldByName('localidad').AsString;
      excel.cells[line, 8] := dm.ds_1.FieldByName('provincia').AsString;
      excel.cells[line, 9] := dm.ds_1.FieldByName('pais').AsString;

      dm.ds_1.close;
      dm.ds_1.SelectSQL.Clear;
      dm.ds_1.SelectSQL.Add('select * from albaran_articulos where id_albaran=:id_albaran');
      dm.ds_1.ParamByName('id_albaran').AsInteger := FieldByName('id_albaran').AsInteger;
      dm.ds_1.Open;

      dm.ds_1.First;
      col := 10;
      while not (dm.ds_1.Eof) do
      begin
        excel.cells[1, col] := 'CODIGO';
        excel.cells[line, col] := dm.ds_1.fieldbyname('codigo').AsString;
        Inc(col);
        excel.cells[1, col] := 'NOMBRE';
        excel.cells[line, col] := busca_art_nom(dm.ds_1.fieldbyname('id_articulo').AsInteger);
        Inc(col);
        excel.cells[1, col] := 'UNIDADES';
        excel.cells[line, col] := dm.ds_1.fieldbyname('unidades').asinteger;
        Inc(col);
        excel.cells[1, col] := 'LOTE';
        excel.cells[line, col] := dm.ds_1.fieldbyname('lote').AsString;
        Inc(col);
        excel.cells[1, col] := 'CADUCIDAD';
        excel.cells[line, col] := dm.ds_1.fieldbyname('caducidad').asdatetime;
        Inc(col);

        dm.ds_1.Next;
      end;

      next;
    end;
  finally
    free;
  end;

  excel.activeworkbook.saveas('c:\temp\paeller.xlsx');

  Excel.Quit;
  Excel := Unassigned;

end;

procedure Tf_main.imprime_doc_cliente(pedidos,peds_sin_alb: string);
begin
    with tpfibdataset.create(dm) do
  try
    database:=dm.db;
    close;
    sqls.SelectSQL.Clear;
    sqls.selectsql.Add('select valor from c_pedidos_extras ' +
                       'where upper(descripcion)=upper(:extra) ' );

    if pedidos<>'' then
           sqls.selectsql.Add(' and id_pedido in (' + pedidos + ')');

    if peds_sin_alb<>'' then
           sqls.selectsql.Add(' and id_pedido not in (' + peds_sin_alb + ')');

    ParamByName('extra').AsString := extra_doc_cliente;
    open;

    if not(isempty) then begin

      First;

      while not eof do begin
         ShellExecute(Handle, 'Print', PChar(FieldByName('valor').asstring), nil,  nil, SW_HIDE);
         Next;
      end;
    end;

  finally
    free;
  end;
end;

procedure Tf_main.insertar_adjuntos(pedidos, peds_sin_alb: string);
var
  attachId: Integer;
  link: string;
begin
    with tpfibdataset.Create(dm) do
    begin
      database := dm.db;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select * ' +
                         'from c_pedidos p ' +
                         'where p.estado in (''G'',''E'') and p.id_cliente=:id_cliente and p.codalbaran>0 ');

      if pedidos <> '' then
          SQLs.SelectSQL.Add(' and p.id_pedido in (' + pedidos + ')');

      if peds_sin_alb <> '' then
          SQLs.SelectSQL.Add(' and id_pedido not in (' + peds_sin_alb + ') ');

      ParamByName('id_cliente').AsInteger := main_cli;
      Open;

      first;
      while not (eof) do
      begin
        link := dmDescargaAttach.ObtenAttach(IntToStr(FieldByName('id_pedido').asinteger),'','L', attachId);

        if link<>'' then
            inserta_adjunto_albaran(FieldByName('id_pedido').asinteger,attachId,'','','','','');
        Next;
      end;

      Free;
    end;
end;

procedure Tf_main.RevisaVersion;
begin
     if FicheroServer<>'' then
      tmr4.Enabled :=  (GetCreationFileDate(FicheroServer)>GetCreationFileDate(Application.ExeName))
     else begin
        tmr4.Enabled := False;
        imgNuevaVer.Visible := False;
     end;

end;

procedure Tf_main.EnviaLotes(peds: string);
var
  pedidos: TStringList;
  token, log: string;
  i: integer;
  resultado: string;
begin
   resultado := '';
   token := dmPargal.Login(cli_api_url, cli_api_user,cli_api_pass);

   pedidos := TStringList.Create;
   pedidos.Delimiter := ',';
   pedidos.DelimitedText := peds;

   for I := 0 to pedidos.Count-1 do
   begin

        resultado := resultado + dmPargal.EnviaPedido(token,cli_api_url,StrToInt(pedidos[i]),StrToInt(cl_padres[i]),log);
   end;

   showmessage(resultado);
   pedidos.Free;

end;

procedure Tf_main.ActualizaLotes(id_cliente,usu:integer;pedidos:TStringList;nom_cli,nom_pc,ip:string);
var
  art_actual, alb_actual: Integer;
  peds_act: string;
  i: integer;
begin
    peds_act := '';
    art_actual := -1;
    alb_actual := -1;

    try
      with tpfibdataset.Create(dm) do
      begin
        for I := 0 to pedidos.Count-1 do
        begin
          close;
          database := dm.db;
          SelectSQL.Clear;
          SelectSQL.Add('select distinct p.id_pedido, p.codalbaran, l.id_articulo ' +
                        'from c_pedidos p ' +
                        'inner join c_pedidos_lines l on p.id_pedido=l.id_pedido ' +
                        'left outer join c_pedidos_lines_lotes lt on l.id_pedido=lt.id_pedido and l.id_articulo=lt.id_articulo ' +
                        'where p.id_cliente=:id_cliente and p.codalbaran>0 and ' +
                        'lt.id_pedido is null and lt.id_articulo is null ');
          SelectSQL.Add(' and p.id_pedido=:id_pedido');

          ParamByName('id_pedido').AsInteger := StrToInt(pedidos[i]);
          ParamByName('id_cliente').AsInteger := id_cliente;
          Open;

          if not IsEmpty then
          begin
            dm.t_write.StartTransaction;

            First;

            while not Eof do
            begin

              if Pos(FieldByName('id_pedido').AsString,peds_act)=0 then
                        peds_act := peds_act + FieldByName('id_pedido').AsString + ',';

              if ((art_actual <> FieldByName('id_articulo').AsInteger) or (alb_actual <> FieldByName('codalbaran').AsInteger)) then
              begin
                art_actual := FieldByName('id_articulo').AsInteger;
                alb_actual := FieldByName('codalbaran').AsInteger;

                if FieldByName('codalbaran').AsInteger > 0 then
                begin

                  dm.q_pick_lotes.Close;
                  dm.q_pick_lotes.ParamByName('albaran').AsInteger := FieldByName('codalbaran').AsInteger;
                  dm.q_pick_lotes.ParamByName('articulo').AsInteger := FieldByName('id_articulo').AsInteger;
                  dm.q_pick_lotes.Open;
                  dm.q_pick_lotes.First;

                  while not dm.q_pick_lotes.eof do
                  begin
                    InsertaLote(FieldByName('id_pedido').AsInteger, FieldByName('id_articulo').AsInteger, dm.q_pick_lotes.FieldByName('id_lote').AsInteger, dm.q_pick_lotes.FieldByName('cantidad').AsInteger, dm.q_pick_lotes.FieldByName('id_pickcab').AsInteger, dm.q_pick_lotes.FieldByName('linea').AsInteger);
                    //ActualizaPackLote(dm.q_pick_lotes.FieldByName('id_pickcab').AsInteger, dm.q_pick_lotes.FieldByName('linea').AsInteger, FieldByName('codalbaran').AsInteger, FieldByName('id_articulo').AsInteger, dm.q_pick_lotes.FieldByName('cantidad').AsInteger, dm.q_pick_lotes.FieldByName('id_lote').AsInteger);
                    InsertaLog(usu,0,0,nom_pc,ip,'c_pedidos_lines_lotes','',
                               'insert into c_pedidos_lines_lotes (id_pedido, id_articulo, id_lote, cantidad, id_picking, linea_pick) ' +
                               'values (' + FieldByName('id_pedido').AsString + ',' +
                               FieldByName('id_articulo').asstring + ',' +
                               dm.q_pick_lotes.FieldByName('id_lote').asstring + ',' +
                               dm.q_pick_lotes.FieldByName('cantidad').asstring + ',' +
                               dm.q_pick_lotes.FieldByName('id_pickcab').AsString + ',' +
                               dm.q_pick_lotes.FieldByName('linea').AsString + ')',
                               'Lote Insertado (' + ExtractFileName(Application.ExeName)+')','');
                    dm.q_pick_lotes.Next;
                  end;

                end;
              end;
              Next;
            end;

            dm.t_write.Commit;
          end;
        end;
      end;

    except
      dm.t_write.Rollback;
      ShowMessage('Error al actualizar lotes.');
    end;


end;

function Tf_main.controlesCliente(cli:Integer; out resultado: string): Boolean;
var
  i: integer;
begin
  result := True;

  resultado := '';

  with TpFIBDataSet.Create(self) do
  try
    try
      Database := dm.db;
      sqls.SelectSQL.Add('select distinct qry, c.descripcion, q.query ' +
                         'from g_clientes_control c ' +
                         'inner join g_queries q on q.id=c.qry ' +
                         'where ((id_cliente=:id_cliente) or (id_cliente=-1000)) ' +
                         'order by id_cliente desc' );
      ParamByName('id_cliente').AsInteger := cli;
      Open;

      first;

      while (not (Eof)) do
      begin
        if resultado<>'' then
           resultado := resultado + #13#10;

        dm.ds_2.Close;
        dm.ds_2.SQLs.SelectSQL.Clear;
        dm.ds_2.SQLs.SelectSQL.Add(FieldByName('query').AsString);
        if Pos(':id_cliente',FieldByName('query').AsString)>0 then
            dm.ds_2.ParamByName('id_cliente').AsInteger := main_cli;
        dm.ds_2.Open;

        if not dm.ds_2.IsEmpty then
        begin
          resultado := resultado + FieldByName('descripcion').AsString + #13#10;

          dm.ds_2.First;

          for I := 0 to dm.ds_2.Fields.Count-1 do
              resultado := resultado + dm.ds_2.FieldName(i) + '_' ;

          resultado := Copy(resultado,0,Length(resultado)-1);
          resultado := resultado + #13#10;

          while not dm.ds_2.Eof do
          begin

            for I := 0 to dm.ds_2.Fields.Count-1 do
                 resultado := resultado + dm.ds_2.fields[i].Text + '_' ;

            resultado := Copy(resultado,0,Length(resultado)-1);
            resultado := resultado + #13#10;
            dm.ds_2.Next;
          end;
        end;

        Next;
      end;

    except
       Result := False;
    end;

  finally
     free;
  end;

  end;

procedure Tf_main.habilita_modo_historico(activar: Boolean);
begin
  if activar then  //Modo normal -> activar modo historico
  begin
    Caption := 'GESTIÓN PEDIDOS DE ALMACÉN ' + v + ' ' + IntToStr(usuario.id) + ' ' + usuario.Nombre + '     MODO HISTORICO ACTIVADO';

    mnModoHist.Caption := 'Desactiva Modo &Histórico';
    modo_historico := True;

    gbCliente.Brush.Color := clDefault;
  end else begin      //Modo historico -> desactivar modo historico
    Caption := 'GESTIÓN PEDIDOS DE ALMACÉN ' + v + ' ' + IntToStr(usuario.id) + ' ' + usuario.Nombre ;

    mnModoHist.Caption := 'Activa Modo &Histórico';

    modo_historico := false;
    gbCliente.Brush.Color := clRed;
  end;

  gb2.Visible := not modo_historico;
  gb3.Visible := not modo_historico;
  gb4.Visible := not modo_historico;
  gb5.Visible := not modo_historico;
  bt_nuevo.Visible := not modo_historico;
  bt_reexp.Visible := not modo_historico;
  bt_anular.Visible := not modo_historico;
  btDevos.Visible := not modo_historico;
  gb1.Visible := not modo_historico;
  btStock0.Visible := not modo_historico;

  edDiasAtras.Value := 30;
  habilita_menus(locked,modo_historico);
end;

procedure Tf_main.mnAnulaStockClick(Sender: TObject);
begin
  AnulaStock;
end;

procedure Tf_main.mnArchivaHistClick(Sender: TObject);
var
  pedidos, log_archivo: string;
  resultado, todos, cancelado, hasta_fecha: Boolean;
  Dialog: TForm;
  i: Integer;
begin
  if (HiWord(GetKeyState(VK_CONTROL)) <> 0)then
  begin

    If modo_historico then
    begin
       ShowMessage('Desactive el modo histórico para poder realizar esta operación.');
       Exit;
    end;

    InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','Ini.EnvioHist','');

    pnPtes.Enabled := False;

    resultado := True;

    cancelado := False;
    todos := false;
    hasta_fecha := false;

    Dialog := CreateMessageDialog('¿Qué pedidos desea archivar?', mtWarning, [mbYes, mbNo, mbAll, mbCancel]);
    Dialog.Width := 265;
    Dialog.Height := 170;
    TButton(Dialog.Controls[2]).Enabled := not (dm.q_peds.isempty);
    TButton(Dialog.Controls[2]).Caption := 'Filtro';

    TButton(Dialog.Controls[3]).Enabled :=  (gr_envs.SelectedRows.Count>0);
    TButton(Dialog.Controls[3]).Caption := 'Selección';

    TButton(Dialog.Controls[5]).Width := 237;
    TButton(Dialog.Controls[5]).left := 12;
    TButton(Dialog.Controls[5]).top := 100;
    TButton(Dialog.Controls[5]).Caption := 'Todo hasta el ' + FormatDateTime('dd/mm/yyyy',Today-edDiasAtras.Value);

    //TButton(Dialog.Controls[4]).Left := 330;
    TButton(Dialog.Controls[4]).Caption := 'Cancelar';

    try
      case Dialog.ShowModal of
        mrYes:
          begin
            if (MessageDlg('Va a archivar TODOS los pedidos filtrados, ¿desea continuar?', mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes) then
              todos := True
            else
              cancelado := true;
          end;
        mrNo:
          begin
            if (MessageDlg('Va a archivar los pedidos SELECCIONADOS, ¿desea continuar?', mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes) then
              todos := False
            else
              cancelado := true;
          end;
        mrAll:
          begin
            if (MessageDlg('Va a archivar los pedidos hasta el ' + FormatDateTime('dd/mm/yyyy',Today-edDiasAtras.Value) + ' , ¿desea continuar?', mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes) then
              hasta_fecha := true
            else
              cancelado := true;
          end;
        mrCancel:
          cancelado := true;
      end;
    finally
      Dialog.Free;
    end;

    if not cancelado then
    begin
      if todos then    //generar todos los pedidos
      begin
        with dm.q_peds do
        try
          First;

          if not IsEmpty then
          begin
            pedidos := '';
            First;
            while not eof do
            begin
              pedidos := pedidos + FieldByName('id_pedido').AsString + ',';
              Next;
            end;

                  //pedidos := Copy(pedidos,1,Length(pedidos)-1);
          end
          else
            ShowMessage('No existen pedidos a generar.');
        finally
          //free;
        end;
      end
      else if not hasta_fecha then
           begin  //generar solo seleccionados
              pedidos := '';

              for i := 0 to gr_envs.SelCount - 1 do
              begin
                gr_envs.GotoSelection(i);
                pedidos := pedidos + dm.q_peds.FieldByName('id_pedido').AsString + ',';
              end;
           end;

      pedidos := Copy(pedidos, 1, Length(pedidos) - 1);

      log_archivo := '';

      Screen.Cursor := crHourGlass;

      if pedidos <> '' then
           log_archivo := ArchivarAHistorico(pedidos,Today-edDiasAtras.Value)
      else if hasta_fecha then
           log_archivo := ArchivarAHistorico('',Today-edDiasAtras.Value);

      Screen.Cursor := crDefault;
    end
    else begin
      InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','EnvioHist.CanceladoPorUsuario','');
      lb_st1.Caption := 'Proceso cancelado.';
    end;

    if cancelado then
        ShowMessage('Proceso de archivado cancelado.')
    else if log_archivo = '' then
            ShowMessage('Proceso de archivado finalizado sin errores.')
         else
            ShowMessage(log_archivo);

    InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','Fin.EnvioHist',log_archivo);

    filter(modo_historico);

    lb_st1.Caption := 'Proceso de archivado finalizado.';

    pnPtes.Enabled := True;

  end;

end;

procedure Tf_main.mnModoHistClick(Sender: TObject);
begin
    habilita_modo_historico(not modo_historico);

    filter(modo_historico);
end;

procedure Tf_main.mnUbicsArtsClick(Sender: TObject);
begin
  informe_ubics_arts(main_cli);
end;

procedure Tf_main.mnUtilsClick(Sender: TObject);
begin

end;

{
procedure Tf_main.cargar_lineas_pedido;
begin
  if not modo_historico then
  begin
      with dm.q_peds_lines do
      begin
         close;
         SelectSQL.Clear;
         SelectSQL.Add('select l.*,a.codigo,l.nombre_art as nombre,l.sku as codigo_cli, lt.nombre as lote, lt.caducidad ' +
                       'from c_pedidos_lines l ' +
                       'left outer join g_articulos a on (l.id_articulo=a.id_articulo) ' +
                       'left outer join a_lotes lt on (lt.id_lote=l.id_lote) ' +
                       'where l.id_pedido=:id_pedido');
         Open;
      end;

      with dm.q_peds_lines_count do
      begin
         close;
         SelectSQL.Clear;
         SelectSQL.Add('select count(*) as tot ' +
                       'from c_pedidos_lines l ' +
                       'where l.id_pedido=:id_pedido');
         Open;
      end;
  end else begin
              with dm.q_peds_lines do
              begin
                 close;
                 SelectSQL.Clear;
                 SelectSQL.Add('select l.*,a.codigo,l.nombre_art as nombre,l.sku as codigo_cli, lt.nombre as lote, lt.caducidad ' +
                               'from c_pedidos_lines_hist l ' +
                               'left outer join g_articulos a on (l.id_articulo=a.id_articulo) ' +
                               'left outer join a_lotes lt on (lt.id_lote=l.id_lote) ' +
                               'where l.id_pedido=:id_pedido');
                 Open;
              end;

              with dm.q_peds_lines_count do
              begin
                 close;
                 SelectSQL.Clear;
                 SelectSQL.Add('select count(*) as tot ' +
                               'from c_pedidos_lines_hist l ' +
                               'where l.id_pedido=:id_pedido');
                 Open;
              end;
           end

end;
}

function Tf_main.ArchivarAHistorico(pedidos:string; hasta_fecha:TDate):string;
var
  resultado: string;
  continua: boolean;
begin
  result := '';
  resultado := '';
  continua := false;

  dm.t_write.StartTransaction;

  lb_st1.Caption := 'Traspasando datos...';

  with dm.q_4 do
  begin
    try
        //Traspaso C_PEDIDOS

        Close;
        sql.Clear;

        if pedidos<>'' then
        begin
          SQL.Add('insert into c_pedidos_hist ' +
                  'select :fecha,p.* from c_pedidos p ' +
                  'where id_cliente=:id_cliente and id_pedido in (' + pedidos +') ' +
                  ' and fecha_ped<:fecha_ped');
          ParamByName('fecha').AsDateTime := Now;
          ParamByName('fecha_ped').AsDateTime := hasta_fecha;
          ParamByName('id_cliente').AsInteger := main_cli;
        end else begin
                    SQL.Add('insert into c_pedidos_hist ' +
                            'select :fecha,p.* from c_pedidos p ' +
                            'where id_cliente=:id_cliente and fecha_ped<:fecha_ped');
                    ParamByName('fecha').AsDateTime := Now;
                    ParamByName('fecha_ped').AsDateTime := hasta_fecha;
                    ParamByName('id_cliente').AsInteger := main_cli;
                 end;

        ExecQuery;
        //dm.t_write.CommitRetaining;

        resultado := 'Traspaso PEDIDOS Ok...';
        //InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','EnvioHist.Traspaso c_pedidos Ok','');

        //Traspaso C_PEDIDOS_LINES
        Close;
        sql.Clear;

        if pedidos<>'' then
        begin
          SQL.Add('insert into c_pedidos_lines_hist ' +
                  'select :fecha,l.* from c_pedidos_lines l ' +
                  'inner join c_pedidos p on p.id_pedido=l.id_pedido ' +
                  'where p.id_cliente=:id_cliente and p.id_pedido in (' + pedidos +') ' +
                  ' and p.fecha_ped<:fecha_ped');
          ParamByName('fecha').AsDateTime := Now;
          ParamByName('fecha_ped').AsDateTime := hasta_fecha;
          ParamByName('id_cliente').AsInteger := main_cli;
        end else begin
                    SQL.Add('insert into c_pedidos_lines_hist ' +
                            'select :fecha,l.* from c_pedidos_lines l ' +
                            'inner join c_pedidos p on p.id_pedido=l.id_pedido ' +
                            'where p.id_cliente=:id_cliente and p.fecha_ped<:fecha_ped');
                    ParamByName('fecha').AsDateTime := Now;
                    ParamByName('fecha_ped').AsDateTime := hasta_fecha;
                    ParamByName('id_cliente').AsInteger := main_cli;
                 end;

        ExecQuery;
        //dm.t_write.CommitRetaining;

        resultado := resultado + #10#13 + 'Traspaso PEDIDOS LINES Ok...';
        //InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','EnvioHist.Traspaso c_pedidos_lines Ok','');

        //Traspaso C_PEDIDOS_EXTRAS
        Close;
        sql.Clear;

        if pedidos<>'' then
        begin
          SQL.Add('insert into c_pedidos_extras_hist ' +
                  'select :fecha,e.* from c_pedidos_extras e ' +
                  'inner join c_pedidos p on p.id_pedido=e.id_pedido ' +
                  'where p.id_cliente=:id_cliente and p.id_pedido in (' + pedidos +') ' +
                  ' and p.fecha_ped<:fecha_ped');
          ParamByName('fecha').AsDateTime := Now;
          ParamByName('fecha_ped').AsDateTime := hasta_fecha;
          ParamByName('id_cliente').AsInteger := main_cli;
        end else begin
                    SQL.Add('insert into c_pedidos_extras_hist ' +
                            'select :fecha,e.* from c_pedidos_extras e ' +
                            'inner join c_pedidos p on p.id_pedido=e.id_pedido ' +
                            'where p.id_cliente=:id_cliente and p.fecha_ped<:fecha_ped');
                    ParamByName('fecha').AsDateTime := Now;
                    ParamByName('fecha_ped').AsDateTime := hasta_fecha;
                    ParamByName('id_cliente').AsInteger := main_cli;
                 end;

        ExecQuery;
        //dm.t_write.CommitRetaining;

        resultado := resultado + #10#13 + 'Traspaso PEDIDOS EXTRAS Ok...';
        //InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','EnvioHist.Traspaso c_pedidos_extras Ok','');

        //Traspaso C_PEDIDOS_LINES_LOTES
        Close;
        sql.Clear;

        if pedidos<>'' then
        begin
          SQL.Add('insert into c_pedidos_lines_lotes_hist ' +
                  'select :fecha,lt.* from c_pedidos_lines_lotes lt ' +
                  'inner join c_pedidos p on p.id_pedido=lt.id_pedido ' +
                  'where p.id_cliente=:id_cliente and p.id_pedido in (' + pedidos +') ' +
                  ' and p.fecha_ped<:fecha_ped');
          ParamByName('fecha').AsDateTime := Now;
          ParamByName('fecha_ped').AsDateTime := hasta_fecha;
          ParamByName('id_cliente').AsInteger := main_cli;
        end else begin
                    SQL.Add('insert into c_pedidos_lines_lotes_hist ' +
                            'select :fecha,lt.* from c_pedidos_lines_lotes lt ' +
                            'inner join c_pedidos p on p.id_pedido=lt.id_pedido ' +
                            'where p.id_cliente=:id_cliente and p.fecha_ped<:fecha_ped');
                    ParamByName('fecha').AsDateTime := Now;
                    ParamByName('fecha_ped').AsDateTime := hasta_fecha;
                    ParamByName('id_cliente').AsInteger := main_cli;
                 end;

        ExecQuery;
        //dm.t_write.CommitRetaining;

        resultado := resultado + #10#13 + 'Traspaso PEDIDOS LINES LOTES Ok...';
        //InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','EnvioHist.Traspaso c_pedidos_lines_lotes Ok','');

        //Traspaso C_PEDIDOS_LINES_EXTRAS
        Close;
        sql.Clear;

        if pedidos<>'' then
        begin
          SQL.Add('insert into c_pedidos_lines_extras_hist ' +
                  'select :fecha,le.* from c_pedidos_lines_extras le ' +
                  'inner join c_pedidos p on p.id_pedido=le.id_pedido ' +
                  'where p.id_cliente=:id_cliente and p.id_pedido in (' + pedidos +') ' +
                  ' and p.fecha_ped<:fecha_ped');
          ParamByName('fecha').AsDateTime := Now;
          ParamByName('fecha_ped').AsDateTime := hasta_fecha;
          ParamByName('id_cliente').AsInteger := main_cli;
        end else begin
                    SQL.Add('insert into c_pedidos_lines_extras_hist ' +
                            'select :fecha,le.* from c_pedidos_lines_extras le ' +
                            'inner join c_pedidos p on p.id_pedido=le.id_pedido ' +
                            'where p.id_cliente=:id_cliente and p.fecha_ped<:fecha_ped');
                    ParamByName('fecha').AsDateTime := Now;
                    ParamByName('fecha_ped').AsDateTime := hasta_fecha;
                    ParamByName('id_cliente').AsInteger := main_cli;
                 end;

        ExecQuery;
        //dm.t_write.CommitRetaining;

        resultado := resultado + #10#13 + 'Traspaso PEDIDOS LINES EXTRAS Ok...';
        //InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','EnvioHist.Traspaso c_pedidos_lines_extras Ok','');

        //Traspaso C_PEDIDOS_LINES_DEVOS
        Close;
        sql.Clear;

        if pedidos<>'' then
        begin
          SQL.Add('insert into c_pedidos_devos_hist ' +
                  'select :fecha,d.* from c_pedidos_devos d ' +
                  'inner join c_pedidos p on p.id_pedido=d.id_pedido ' +
                  'where p.id_cliente=:id_cliente and p.id_pedido in (' + pedidos +') ' +
                  ' and p.fecha_ped<:fecha_ped');
          ParamByName('fecha').AsDateTime := Now;
          ParamByName('fecha_ped').AsDateTime := hasta_fecha;
          ParamByName('id_cliente').AsInteger := main_cli;
        end else begin
                    SQL.Add('insert into c_pedidos_devos_hist ' +
                            'select :fecha,d.* from c_pedidos_devos d ' +
                            'inner join c_pedidos p on p.id_pedido=d.id_pedido ' +
                            'where p.id_cliente=:id_cliente and p.fecha_ped<:fecha_ped');
                    ParamByName('fecha').AsDateTime := Now;
                    ParamByName('fecha_ped').AsDateTime := hasta_fecha;
                    ParamByName('id_cliente').AsInteger := main_cli;
                 end;

        ExecQuery;

        resultado := resultado + #10#13 + 'Traspaso PEDIDOS DEVOS Ok...';


        //Traspaso C_PEDIDOS_ETIQUETAS
        Close;
        sql.Clear;

        if pedidos<>'' then
        begin
          SQL.Add('insert into c_pedidos_etiquetas_hist ' +
                  'select :fecha,e.* from c_pedidos_etiquetas e ' +
                  'inner join c_pedidos p on p.id_pedido=e.id_pedido ' +
                  'where p.id_cliente=:id_cliente and p.id_pedido in (' + pedidos +') ' +
                  ' and p.fecha_ped<:fecha_ped');
          ParamByName('fecha').AsDateTime := Now;
          ParamByName('fecha_ped').AsDateTime := hasta_fecha;
          ParamByName('id_cliente').AsInteger := main_cli;
        end else begin
                    SQL.Add('insert into c_pedidos_etiquetas_hist ' +
                            'select :fecha,e.* from c_pedidos_etiquetas e ' +
                            'inner join c_pedidos p on p.id_pedido=e.id_pedido ' +
                            'where p.id_cliente=:id_cliente and p.fecha_ped<:fecha_ped');
                    ParamByName('fecha').AsDateTime := Now;
                    ParamByName('fecha_ped').AsDateTime := hasta_fecha;
                    ParamByName('id_cliente').AsInteger := main_cli;
                 end;

        ExecQuery;

        //dm.t_write.CommitRetaining;

        resultado := resultado + #10#13 + 'Traspaso PEDIDOS ETIQUETAS Ok...';
        //InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','EnvioHist.Traspaso c_pedidos_devos Ok','');

       dm.t_write.Commit;
       //InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','EnvioHist.TraspasoOk',resultado);

       continua := True;
    except on e:Exception do begin
          resultado := resultado + #13#10 + ' Error: ' + e.Message;
          dm.t_write.Rollback;
          InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','EnvioHist.TraspasoError',resultado);
      end;
    end;

  end;

  if not continua then
  begin
    result := 'Error durante el traslado de datos: ' + #13#10 + resultado;
    lb_st1.Caption := 'Proceso cancelado por errores.';
    exit
  end;

  //////////// ELIMINAR REGISTROS /////////////////////

  //dm.t_write.StartTransaction;

  lb_st1.Caption := 'Eliminando datos...';

  with dm.q_4 do
  begin
    try
        //Borrado C_PEDIDOS_LINES
        Close;
        sql.Clear;

        if pedidos<>'' then
        begin
          SQL.Add('delete from c_pedidos_lines ' +
                  'where id_pedido in (select id_pedido from c_pedidos where ' +
                                       ' id_cliente=:id_cliente and fecha_ped<:fecha_ped ' +
                                       ' and id_pedido in (' + pedidos +'))');
          ParamByName('fecha_ped').AsDateTime := hasta_fecha;
          ParamByName('id_cliente').AsInteger := main_cli;
        end else begin
                    SQL.Add('delete from c_pedidos_lines ' +
                            'where id_pedido in (select id_pedido from c_pedidos where ' +
                                                  'id_cliente=:id_cliente and fecha_ped<:fecha_ped)');
                    ParamByName('fecha_ped').AsDateTime := hasta_fecha;
                    ParamByName('id_cliente').AsInteger := main_cli;
                 end;

        ExecQuery;

        resultado := resultado + #10#13 + 'Borrado PEDIDOS LINES Ok...';
        //InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','EnvioHist.Delete c_pedidos_lines Ok','');

        //Borrado C_PEDIDOS_EXTRAS
        Close;
        sql.Clear;

        if pedidos<>'' then
        begin
          SQL.Add('delete from c_pedidos_extras ' +
                  'where id_pedido in (select id_pedido from c_pedidos where ' +
                                       ' id_cliente=:id_cliente and fecha_ped<:fecha_ped ' +
                                       ' and id_pedido in (' + pedidos +'))');
          ParamByName('fecha_ped').AsDateTime := hasta_fecha;
          ParamByName('id_cliente').AsInteger := main_cli;
        end else begin
                    SQL.Add('delete from c_pedidos_extras ' +
                            'where id_pedido in (select id_pedido from c_pedidos where ' +
                                       ' id_cliente=:id_cliente and fecha_ped<:fecha_ped)');
                    ParamByName('fecha_ped').AsDateTime := hasta_fecha;
                    ParamByName('id_cliente').AsInteger := main_cli;
                 end;

        ExecQuery;

        resultado := resultado + #10#13 + 'Borrado PEDIDOS EXTRAS Ok...';
        //InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','EnvioHist.Delete c_pedidos_extras Ok','');

        //Borrado C_PEDIDOS_LINES_LOTES
        Close;
        sql.Clear;

        if pedidos<>'' then
        begin
          SQL.Add('delete from c_pedidos_lines_lotes ' +
                  'where id_pedido in (select id_pedido from c_pedidos where ' +
                                       ' id_cliente=:id_cliente and fecha_ped<:fecha_ped ' +
                                       ' and id_pedido in (' + pedidos +'))');
          ParamByName('fecha_ped').AsDateTime := hasta_fecha;
          ParamByName('id_cliente').AsInteger := main_cli;
        end else begin
                    SQL.Add('delete from c_pedidos_lines_lotes ' +
                            'where id_pedido in (select id_pedido from c_pedidos where ' +
                                       ' id_cliente=:id_cliente and fecha_ped<:fecha_ped)');
                    ParamByName('fecha_ped').AsDateTime := hasta_fecha;
                    ParamByName('id_cliente').AsInteger := main_cli;
                 end;

        ExecQuery;

        resultado := resultado + #10#13 + 'Borrado PEDIDOS LINES LOTES Ok...';
        //InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','EnvioHist.Delete c_pedidos_lines_lotes Ok','');

        //Borrado C_PEDIDOS_LINES_EXTRAS
        Close;
        sql.Clear;

        if pedidos<>'' then
        begin
          SQL.Add('delete from c_pedidos_lines_extras ' +
                  'where id_pedido in (select id_pedido from c_pedidos where ' +
                                       ' id_cliente=:id_cliente and fecha_ped<:fecha_ped ' +
                                       ' and id_pedido in (' + pedidos +'))');
          ParamByName('fecha_ped').AsDateTime := hasta_fecha;
          ParamByName('id_cliente').AsInteger := main_cli;
        end else begin
                    SQL.Add('delete from c_pedidos_lines_extras ' +
                            'where id_pedido in (select id_pedido from c_pedidos where ' +
                                       ' id_cliente=:id_cliente and fecha_ped<:fecha_ped)');
                    ParamByName('fecha_ped').AsDateTime := hasta_fecha;
                    ParamByName('id_cliente').AsInteger := main_cli;
                 end;

        ExecQuery;

        resultado := resultado + #10#13 + 'Borrado PEDIDOS LINES EXTRAS Ok...';
        //InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','EnvioHist.Delete c_pedidos_lines_extras Ok','');

        //Borrado C_PEDIDOS_LINES_DEVOS
        close;
        sql.Clear;

        if pedidos<>'' then
        begin
          SQL.Add('delete from c_pedidos_devos ' +
                  'where id_pedido in (select id_pedido from c_pedidos where ' +
                                       ' id_cliente=:id_cliente and fecha_ped<:fecha_ped ' +
                                       ' and id_pedido in (' + pedidos +'))');
          ParamByName('fecha_ped').AsDateTime := hasta_fecha;
          ParamByName('id_cliente').AsInteger := main_cli;
        end else begin
                    SQL.Add('delete from c_pedidos_devos ' +
                            'where id_pedido in (select id_pedido from c_pedidos where ' +
                                       ' id_cliente=:id_cliente and fecha_ped<:fecha_ped)');
                    ParamByName('fecha_ped').AsDateTime := hasta_fecha;
                    ParamByName('id_cliente').AsInteger := main_cli;
                 end;

        ExecQuery;
        resultado := resultado + #10#13 + 'Borrado PEDIDOS DEVOS Ok...';

        //Borrado C_PEDIDOS_ETIQUETAS
        close;
        sql.Clear;

        if pedidos<>'' then
        begin
          SQL.Add('delete from c_pedidos_etiquetas ' +
                  'where id_pedido in (select id_pedido from c_pedidos where ' +
                                       ' id_cliente=:id_cliente and fecha_ped<:fecha_ped ' +
                                       ' and id_pedido in (' + pedidos +'))');
          ParamByName('fecha_ped').AsDateTime := hasta_fecha;
          ParamByName('id_cliente').AsInteger := main_cli;
        end else begin
                    SQL.Add('delete from c_pedidos_etiquetas ' +
                            'where id_pedido in (select id_pedido from c_pedidos where ' +
                                       ' id_cliente=:id_cliente and fecha_ped<:fecha_ped)');
                    ParamByName('fecha_ped').AsDateTime := hasta_fecha;
                    ParamByName('id_cliente').AsInteger := main_cli;
                 end;

        ExecQuery;

        resultado := resultado + #10#13 + 'Borrado PEDIDOS ETIQUETAS Ok...';
        //InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','EnvioHist.Delete c_pedidos_devos Ok','');

      //Borrado C_PEDIDOS
      Close;
      sql.Clear;

      if pedidos<>'' then
      begin
        SQL.Add('delete from c_pedidos ' +
                'where id_cliente=:id_cliente and id_pedido in (' + pedidos +') ' +
                ' and fecha_ped<:fecha_ped');
        ParamByName('fecha_ped').AsDateTime := hasta_fecha;
        ParamByName('id_cliente').AsInteger := main_cli;
      end else begin
                  SQL.Add('delete from c_pedidos ' +
                          'where id_cliente=:id_cliente and fecha_ped<:fecha_ped');
                  ParamByName('fecha_ped').AsDateTime := hasta_fecha;
                  ParamByName('id_cliente').AsInteger := main_cli;
               end;

      ExecQuery;

      resultado := resultado + #13#10 +'Borrado PEDIDOS Ok...';
      //InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','EnvioHist.Delete c_pedidos Ok','');

       dm.t_write.Commit;

       InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','EnvioHist.DeleteOk',resultado);

    except on e:Exception do begin
          resultado := 'POR FAVOR, COMUNICA ESTE ERROR A SISTEMAS. GRACIAS.' + #13#10 +
                       'Params:' + FormatDateTime('dd/mm/yy',hasta_fecha) + ' Cl.:' + IntToStr(main_cli) +
                       ' Peds.:' + pedidos + #13#10 + resultado + #13#10 + ' Error: ' + e.Message;
          dm.t_write.Rollback;
          InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','','EnvioHist.DeleteError',resultado);
      end;
    end;

  end;

  result := resultado;
  lb_st1.Caption := 'Proceso finalizado.';

end;

procedure Tf_main.filter_reset;
begin

  if locked then
  begin

    rb_alldate.Checked := False;
    rb_adate.Checked := True;
    de_ini.Date := now;
    de_fin.Date := now;

    rb_alldate_gen.Checked := True;
    rb_date_gen.Checked := False;
    de_ini_gen.Date := now;
    de_fin_gen.Date := now;

    rb_alldate_env.Checked := True;
    rb_date_env.Checked := False;
    de_ini_env.Date := now;
    de_fin_env.Date := now;

    edDiasAtras.Value := 30;
    edDiasAtras.Enabled := True;
    chFPedTodo.Checked := False;

    ch_order_name.Checked := False;
    ed_search_order.Text := '';
    ch_idorder.Checked := False;
    ed_search_idorder.Text := '';
    ch_albaran.Checked := False;
    ed_search_albaran.Text := '';
    ch_articulo.Checked := False;
    ed_art.Text := '';
    lb_art1.Caption := '';
    edRefCliente.Text := '';
    chIdPedido.Checked := True;
    edIdPedido.Text := '';
    chConRetorno.Checked := False;
    chConIncidencia.Checked := False;

    cbPaises.ItemIndex := 0;
    cbAgencias.ItemIndex := 0;

    filter(modo_historico)
  end;

end;


procedure Tf_main.abre_config_cliente;
begin;
    u_cli_config.id_cliente := main_cli;
    fCliConfig.Caption := 'Configuración de Almacén para ' + lbCliente.Caption;
    fCliConfig.ShowModal;
end;

procedure Tf_main.DeleteLinesStock0;
var
  lineas:string;
  cant_aux, stock, id_art_padre, i: Integer;
begin

  lineas := '';
  cant_aux := 0;
  stock := 0;
  id_art_padre := -1;

  //Chequeo de lineas
  with TpFIBDataSet.Create(self) do
  try
    Database := dm.db;

    sqls.SelectSQL.Add('select * from c_pedidos_lines where id_pedido=:id_pedido');
    dm.q_1.ParamByName('id_pedido').AsInteger := dm.q_peds.fieldbyname('id_pedido').asinteger;
    Open;

    if not IsEmpty then
    begin
        First;

        while not Eof do
        begin
           if ((StrToInt(cl_hijos[0])<0) and (StrToInt(cl_padres[0])<0)) then
          begin
              stock := get_stock_x_art(dm.ds_1.fieldbyname('id_articulo').AsInteger, id_almacen);
          end
          else   //gestión padre-hijo
          begin
             //Si main_cli es el padre hay que quitar los picks ptes del hijo para calcular el stock
             if StrToInt(cl_hijos[0])>0 then
             begin
              stock := get_stock_x_art(dm.ds_1.fieldbyname('id_articulo').AsInteger, id_almacen, StrToInt(cl_hijos[0]));
             end else begin //Si se esta borrando para el hijo
                    i := 0;
                    while ((id_art_padre<=0) and (i<=High(cl_padres))) do
                    begin
                      id_art_padre := busca_art(get_codcli_art(FieldByName('id_articulo').asinteger),StrToInt(cl_padres[i]));
                      Inc(i);
                    end;

                    if id_art_padre>=0 then
                      stock := get_stock_x_art(id_art_padre, id_almacen, main_cli)
                    else
                      stock := 1;
                 end;
          end;

           if stock<=0 then
           begin
              lineas := lineas + FieldByName('id_line').AsString + ',';
              InsertaLog(usuario.id,dm.q_peds.fieldbyname('id_pedido').asinteger,0,PC.Nombre,PC.IP,log_app,'','',
              'DelLinesStk0.Line ' + FieldByName('id_line').AsString + ' SinStock',
              FieldByName('id_articulo').AsString + '|' + FieldByName('cantidad').AsString + '|' + FieldByName('sku').AsString  + '|' +
              FieldByName('nombre_art').AsString + '|' + FieldByName('id_lote').AsString);
           end;
        end;
    end;
  finally
    free;
  end;

  if lineas='' then
  begin
    ShowMessage('No existen lineas sin stock');
    Exit;
  end else
         lineas := Copy(lineas, 1, Length(lineas) - 1);

  //Borrado de lineas
  dm.t_write.StartTransaction;
  try
    dm.q_1.Close;
    dm.q_1.sql.Clear;
    dm.q_1.sql.Add('delete from c_pedidos_lines where id_pedido=:id_pedido and id_line in (' + lineas + ')');
    dm.q_1.ParamByName('id_pedido').AsInteger := dm.q_peds.fieldbyname('id_pedido').asinteger;
    dm.q_1.ExecQuery;
    dm.t_write.Commit;

    InsertaLog(usuario.id,dm.q_peds.fieldbyname('id_pedido').asinteger,0,PC.Nombre,PC.IP,log_app,'','','Ok.DelLinesStk0.Lines ' + lineas,'');
  except
    dm.t_write.rollback;
    InsertaLog(usuario.id,dm.q_peds.fieldbyname('id_pedido').asinteger,0,PC.Nombre,PC.IP,log_app,'','','Error.DelLinesStk0.Lines ' + lineas,'');
  end;

  if locked then
      filter(modo_historico);
end;


procedure Tf_main.AnulaStock;
type
  Tarticulo = record
    id, stock: integer;
    nombre, sku: string;
  end;

var
  fin, todo, cancelado: Boolean;
  r, id_articulo, l_total, l_upd, i, idx_art: Integer;
  log, dir, ar_ubics: TStringList;
  dialog: TForm;
  msg_error, file_name, resp, resultado, json, sku, errores_pick, ar_ubics_aux: string;
  articulos: array of Tarticulo;
begin

  l_upd := 0;

  cancelado := False;
  todo := false;

  with TTaskDialog.Create(self) do
  begin
    try
      Title := '¿Qué stock desea anular?';
      Caption := lbCliente.Caption;
      Text := '';
      CommonButtons := [];
      with TTaskDialogButtonItem(Buttons.Add) do
      begin
        Caption := 'Todo';
        ModalResult := mrNone;
      end;
      with TTaskDialogButtonItem(Buttons.Add) do
      begin
        Caption := 'Excel';
        ModalResult := mrYes;
      end;
      with TTaskDialogButtonItem(Buttons.Add) do
      begin
        Caption := 'Cancelar';
        ModalResult := mrNo;
      end;
      //OnButtonClicked := Dialog2ButtonClicked;
      MainIcon := tdiInformation;

      VerificationText := 'Dar de baja los artículos.';
      if util_anula_stock_baja_art then
           Flags := [tfVerificationFlagChecked];
      OnVerificationClicked := dialog2VerificationClicked;

      if Execute then
      begin
        if ModalResult = mrNone then
        begin
          if (MessageDlg('Va a anular el STOCK COMPLETO de ' + lbCliente.Caption + ' en almacén ' + cbAlmacenes.Text + ', ¿desea continuar?', mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes) then
            todo := True
          else
            cancelado := true;
        end;
        if ModalResult = mrYes then
        begin
          if (MessageDlg('Va a anular el stock de los artículos de ' + lbCliente.Caption + ' en almacén ' + cbAlmacenes.Text + ' incluidos en el fichero, ¿desea continuar?', mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes) then
            todo := False
          else
            cancelado := true;
        end;

        if ModalResult = mrNo then
            cancelado := True;
      end;

    finally
      Free;
    end;

  end;

  {
  Dialog := CreateMessageDialog('¿Qué stock desea anular?', mtInformation, [mbYes, mbNo, mbCancel]);
  dialog.Caption := lbCliente.Caption;
  TButton(Dialog.Controls[2]).Caption := 'Todo';
  TButton(Dialog.Controls[3]).Caption := 'Fichero Excel';
  TButton(Dialog.Controls[4]).Caption := 'Cancelar';

  try
    case Dialog.ShowModal of
      mrYes:
        begin
          if (MessageDlg('Va a anular el STOCK COMPLETO de ' + lbCliente.Caption + ' en almacén ' + cbAlmacenes.Text + ', ¿desea continuar?', mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes) then
            todo := True
          else
            cancelado := true;
        end;
      mrNo:
        begin
          if (MessageDlg('Va a anular el stock de los artículos de ' + lbCliente.Caption + ' en almacén ' + cbAlmacenes.Text + ' incluidos en el fichero, ¿desea continuar?', mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes) then
            todo := False
          else
            cancelado := true;
        end;
      mrCancel:
        cancelado := true;
    end;
  finally
    Dialog.Free;
  end;
  }
  If cancelado then
  begin
    InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'util','','UtilAnulaStock.Cancelado.' + IntToStr(main_cli),'');
    lb_st1.Caption := 'Anulación stock cancelada.';
    Exit;
  end;

  log := TStringList.Create;
  ar_ubics := TStringList.Create;
  //ar_ubics.Delimiter := '$';
  
  fin := False;

  l_total := 0;

  idx_art := 0;
  setlength(articulos, idx_art);

  if todo then
  begin
      with TpFIBDataSet.Create(self) do
      try
        Database := dm.db;
        sqls.SelectSQL.Add('select distinct ar.id_articulo from g_articulos ar ');
        sqls.SelectSQL.Add('inner join a_stock s on s.id_articulo=ar.id_articulo ');
        sqls.SelectSQL.Add('where ar.id_cliente=:id_cliente and s.id_almacen=:id_almacen and s.cantidad>0');
        ParamByName('id_cliente').AsInteger := main_cli;
        ParamByName('id_almacen').AsInteger := id_almacen;
        Open;
        if not IsEmpty then
        begin
          First;
          while not eof do
          begin
              if art_en_ped_pte(FieldByName('id_articulo').AsInteger,id_almacen) then
                  log.Add('Existe pedido pendiente con art. id. ' + IntToStr(FieldByName('id_articulo').AsInteger))
              else if art_en_pick_pte(FieldByName('id_articulo').AsInteger,id_almacen) then
                        log.Add('Existe picking pendiente con art. id. ' + IntToStr(FieldByName('id_articulo').AsInteger))
                   else begin
                          Inc(idx_art);
                          setlength(articulos, idx_art);

                          articulos[idx_art-1].id     := FieldByName('id_articulo').AsInteger;
                          articulos[idx_art-1].stock  := get_stock_x_art(FieldByName('id_articulo').AsInteger, id_almacen);
                          articulos[idx_art-1].nombre := BuscaArticulo(FieldByName('id_articulo').AsInteger,sku);
                          articulos[idx_art-1].sku    := sku;
              end;

              Inc(l_total);
              Next;
          end;
        end;
      finally
        free;
      end;

     InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'util','','UtilAnulaStock.Todo.' + IntToStr(main_cli) + 'Alm.' + IntToStr(id_almacen),'');
  end else
      begin

          dl_open.InitialDir := desktop;
          dl_open.Filter := 'Excel (*.xls,*.xlsx)|*.xls;*.xlsx';

          fin := not dl_open.Execute;

          if ((not fin) and FileExists(dl_open.FileName)) then
          begin
            if IndexStr(extractfileExt(dl_open.FileName),['.xls','.xlsx'])>0 then
            begin
              CopyFile(PChar(dl_open.FileName),PChar(util_anula_stock_copia + IntToStr(main_cli) + '_' + IntToStr(id_almacen) + '_' + ExtractFileName(dl_open.Filename)),False);

              Screen.Cursor := crHourglass;

              //dm.t_write.StartTransaction;
              try
                AbreFichero(dl_open.FileName);
                Hoja := excel.Worksheets.Item[1];

                r := 1; //Empezamos desde la fila 1, no hay cabeceras

                SetLength(PedLines,0);

                while not (Trim(hoja.cells[r, 1]) = '') do
                begin

                  id_articulo := busca_art(Trim(hoja.cells[r, 1]),main_cli);

                  if id_articulo>=0 then
                  begin
                      if art_en_ped_pte(id_articulo,id_almacen) then
                          log.Add('Existe pedido pendiente con art. ' + Trim(hoja.cells[r, 1]))
                      else if art_en_pick_pte(id_articulo,id_almacen) then
                                log.Add('Existe picking pendiente con art. ' + Trim(hoja.cells[r, 1]))
                           else begin
                                  Inc(idx_art);
                                  setlength(articulos, idx_art);

                                  articulos[idx_art-1].id     := id_articulo;
                                  articulos[idx_art-1].stock  := get_stock_x_art(id_articulo,id_almacen);
                                  articulos[idx_art-1].nombre := BuscaArticulo(id_articulo,sku);
                                  articulos[idx_art-1].sku    := sku;
                           end;
                  end else
                        log.Add('No encontrado ' + Trim(hoja.cells[r, 1]));

                  Inc(l_total);

                  Inc(r);
                end;
              except
                on e: Exception do
                begin
                  fin := true;
                  log.Add('Error Leyendo Articulos ' + e.Message);
                  sMessageDlg('Error Leyendo Articulos ' + e.message, mtError, [mbok], 0);
                  //dm.t_write.Rollback;

                  Excel.Quit;
                  Excel := Unassigned;

                  exit;
                end;
              end;

              //excel.activeworkbook.save;
              Excel.Quit;
              Excel := Unassigned;

              Screen.Cursor := crDefault;
            end else begin
                  ShowMessage('El fichero debe ser xls o xlsx.');
                  fin := True;
                end;
          end
          else if not fin then begin
            ShowMessage('Debe insertar un fichero válido.');
            fin := True;
          end;

          //dm.t_write.Commit;
      end;

      if ((not fin) and (High(articulos)>0)) then
      begin

        SetLength(PedLines,l_upd);
        
        for I := Low(articulos) to High(articulos) do
        begin
          ar_ubics_aux := get_ubics_art(articulos[i].id, true);

          If UpdateStockArt(articulos[i].id,0)>=0 then
          begin
              ar_ubics.Add(ar_ubics_aux);
              
              if util_anula_stock_baja_art then
                  dar_baja_articulo(articulos[i].id,now);

              Inc(l_upd);
              SetLength(PedLines,l_upd);

              PedLines[l_upd-1].line := l_upd;
              PedLines[l_upd-1].id_articulo := articulos[i].id;
              PedLines[l_upd-1].cantidad := articulos[i].stock;
              PedLines[l_upd-1].nombre_art := articulos[i].nombre;
              PedLines[l_upd-1].sku := articulos[i].sku;
          end
          else
              log.Add('No actualizado id.' + IntToStr(articulos[i].id));
        end;

        dir := TStringList.Create;
        dir.Delimiter := ',';
        dir.DelimitedText := util_anula_stock_params; {0-nombre 1-cp 2-estado}

        PedCab.clienteId     := IntToStr(main_cli);
        PedCab.fechaImp      := FormatDateTime('yyyymmddhhnnss', Now);
        PedCab.fechaPedido   := FormatDateTime('yyyymmddhhnnss', Now);
        PedCab.nombreOrder   := dir[0];
        PedCab.nombre        := dir[0];
        PedCab.dir1          := '.';
        PedCab.poblacion     := '.';
        PedCab.provincia     := '.';
        PedCab.cp            := dir[1];
        PedCab.telefono      := '';
        PedCab.pais          := 'España';
        if todo  then
          PedCab.observaciones := 'Anulación stock completo'
        else
          PedCab.observaciones := 'Anulación stock por fichero';
        PedCab.email         := '';
        PedCab.contacto      := '';
        PedCab.company       := '';
        PedCab.repartidor    := '1';
        PedCab.tipoServ      := '';
        PedCab.horario       := '';
        PedCab.transporte    := '0';
        PedCab.bultos        := '1';
        PedCab.Remitente     := '';
        PedCab.paisCode      := 'ES';
        PedCab.estado        := dir[2];

        resp := '';
        resultado := '';
        json := '';

        resp := dmupdatePedido.updatepedido(3,0, json, resultado);

        InsertaLog(usuario.id,StrToInt(resp),0,PC.Nombre,PC.IP,log_app,'pedido','',
                 'UtilAnulaStock.PedCreadoxAPI',resp + '|' + json + '|' + resultado);

        If not crea_pick_anula_stock(StrToInt(resp), ar_ubics, errores_pick) then
            log.Add(errores_pick);
      end;

      if (log.Count > 0) then
      begin
        Dialog := CreateMessageDialog('Existen datos a revisar. ¿Desea verlos en pantalla o exportar a fichero?', mtWarning, [mbYes, mbNo, mbCancel]);

        TButton(Dialog.Controls[2]).Caption := 'Pantalla';
        TButton(Dialog.Controls[3]).Caption := 'Fichero';
        TButton(Dialog.Controls[4]).Caption := 'Cancelar';

        msg_error := '';
        if log.Count > 0 then
          for i := 0 to log.Count - 1 do
            msg_error := msg_error + log[i] + ln;

        try
          case Dialog.ShowModal of
            mrYes: begin
              if todo then
                  InsertaLog(usuario.id,0,0,'','',log_app,'','','UpdAnulaStock.Todo.ErroresPantalla',msg_error)
              else
                  InsertaLog(usuario.id,0,0,'','',log_app,'','','UpdAnulaStock.Fichero.ErroresPantalla',msg_error);
                sShowMessage('Log Anula Stock', msg_error);
            end;

            mrNo: begin
              file_name := ExtractFileDir(dl_open.FileName) + '\LOG_ANULA_STOCK_' + formatdatetime('dd_mm_yyyy__hh_nn', Now) + '.txt';
              log.SaveToFile(file_name);
              if todo then
                  InsertaLog(usuario.id,0,0,'','',log_app,'','','UpdAnulaStock.Todo.ErroresFichero',file_name + '|' + msg_error)
              else
                  InsertaLog(usuario.id,0,0,'','',log_app,'','','UpdAnulaStock.Fichero.ErroresFichero',file_name + '|' + msg_error);
            end;

            mrCancel: begin
              if todo then
                   InsertaLog(usuario.id,0,0,'','',log_app,'','','UpdAnulaStock.Todo.ErroresCancel',msg_error)
              else
                   InsertaLog(usuario.id,0,0,'','',log_app,'','','UpdAnulaStock.Fichero.ErroresCancel',msg_error);
              Dialog.Close;
            end;
          end;
        finally
          Dialog.Free;
        end;

        log.SaveToFile(util_anula_stock_copia + IntToStr(main_cli) + '_' + IntToStr(id_almacen) + '_log_' + ExtractFileName(dl_open.Filename) + '.txt');
      end;

      lb_st1.Caption := 'Actualizado ' + IntToStr(l_upd) + ' de ' + IntToStr(l_total) + '. Proceso finalizado.';

      sMessageDlg('Actualizado ' + IntToStr(l_upd) + ' de ' + IntToStr(l_total) + '. Proceso finalizado.', mtInformation, [mbok], 0);

      log.Free;
      ar_ubics.Free;
end;


procedure Tf_main.informe_ubics_arts(id_cliente: integer);
var
  line, n_regs: integer;
  exist, stock_0, cancelado: Boolean;
  titulo: string;
begin
    stock_0 := false;
    cancelado := false;
    n_regs := 0;

  with TTaskDialog.Create(self) do
  begin
    try
      Title := '¿Incluir artículos sin stock?';
      Caption := lbCliente.Caption;
      Text := '';
      CommonButtons := [];
      with TTaskDialogButtonItem(Buttons.Add) do
      begin
        Caption := 'Sí';
        ModalResult := mrYes;
      end;
      with TTaskDialogButtonItem(Buttons.Add) do
      begin
        Caption := 'No';
        ModalResult := mrNo;
      end;
       with TTaskDialogButtonItem(Buttons.Add) do
      begin
        Caption := 'Cancelar';
        ModalResult := mrCancel;
      end;
      //OnButtonClicked := Dialog2ButtonClicked;
      MainIcon := tdiInformation;

      if Execute then
      begin
        stock_0 := (ModalResult = mrYes);
        cancelado := (ModalResult = mrCancel);
      end;

    finally
      Free;
    end;

  end;

  if cancelado then Exit;

  with TpFIBDataSet.Create(self) do
    try
      Database := dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select count(*) as cuenta from g_articulos ar ' +
                         'left outer join a_stock s on s.id_articulo=ar.id_articulo ' +
                         'left outer join a_ubicaciones u on u.id_ubicacion=s.id_ubicacion ' +
                         'where id_cliente=:id_cliente and ar.fecha_baja is null ');
      if not stock_0 then
         SQLs.SelectSQL.Add('and s.cantidad>0');
      ParamByName('id_cliente').AsInteger := main_cli;
      Open;

      n_regs := FieldByName('cuenta').AsInteger;

      if n_regs>2000 then
      begin
        with TTaskDialog.Create(self) do
        begin
          try
            Title := 'Se exportarán ' + IntToStr(n_regs) + ' registros. El proceso podría tardar.';
            Caption := lbCliente.Caption;
            Text :=  '¿Desea continuar?';
            CommonButtons := [];
            with TTaskDialogButtonItem(Buttons.Add) do
            begin
              Caption := 'Sí';
              ModalResult := mrYes;
            end;
            with TTaskDialogButtonItem(Buttons.Add) do
            begin
              Caption := 'No';
              ModalResult := mrNo;
            end;
            MainIcon := tdiInformation;

            if Execute then
              cancelado := (ModalResult = mrNo);

          finally
            Free;
          end;

        end;
      end;
    finally
      Free;
    end;

     if cancelado then Exit;

    ga_stat.MaxValue := n_regs;
    ga_stat.Progress := 0;
    Screen.Cursor := crHourGlass;
    CreaExcel;

    Hoja := excel.Worksheets.Item[1];
    //AbreFichero(deDirSeur.Text + '\seur.xls');

    exist := false;

    with TpFIBDataSet.Create(self) do
    try
      Database := dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select * from g_articulos ar ' +
                         'left outer join a_stock s on s.id_articulo=ar.id_articulo ' +
                         'left outer join a_ubicaciones u on u.id_ubicacion=s.id_ubicacion ' +
                         'where id_cliente=:id_cliente and ar.fecha_baja is null ');
      if not stock_0 then
         SQLs.SelectSQL.Add('and s.cantidad>0');
      ParamByName('id_cliente').AsInteger := main_cli;
      Open;

      first;

      Hoja := excel.Worksheets.Item[1];

      line := 1;

      excel.cells[line, 1] := 'CODIGO';
      excel.cells[line, 2] := 'NOMBRE';
      excel.cells[line, 3] := 'UDS';
      excel.cells[line, 4] := 'EST';
      excel.cells[line, 5] := 'POS';
      excel.cells[line, 6] := 'ALT';
      excel.cells[line, 7] := 'SUB1';
      excel.cells[line, 8] := 'SUB2';
      excel.cells[line, 9] := 'ZONA';
      excel.cells[line, 10] := 'ALMACEN';
      excel.cells[line, 11] := '';
      excel.cells[line, 12] := '';
      excel.cells[line, 13] := 'ID_UBICACION';
      excel.cells[line, 14] := 'ID_ARTICULO';
      excel.cells[line, 15] := 'ID_CLIENTE';
      inc(line);

      while not (Eof) do
      begin

        lb_st1.Caption := 'Exportando ' + IntToStr(line-1) + '/' + IntToStr(n_regs);
        exist := true;
        excel.cells[line, 1] := fieldbyname('codigo').AsString;
        excel.cells[line, 2] := fieldbyname('nombre').AsString;
        excel.cells[line, 3] := fieldbyname('cantidad').AsString;
        excel.cells[line, 4] := fieldbyname('id_estanteria').AsString;
        excel.cells[line, 5] := fieldbyname('id_posicion').AsString;
        excel.cells[line, 6] := fieldbyname('id_altura').AsString;
        excel.cells[line, 7] := fieldbyname('id_sub1').AsString;
        excel.cells[line, 8] := fieldbyname('id_sub2').AsString;
        excel.cells[line, 9] := fieldbyname('id_zona').AsString;
        excel.cells[line, 10] := fieldbyname('id_almacen').AsString;
        excel.cells[line, 11] := '';
        excel.cells[line, 12] := '';
        excel.cells[line, 13] := fieldbyname('id_ubicacion').AsString;
        excel.cells[line, 14] := fieldbyname('id_articulo').AsString;
        excel.cells[line, 15] := fieldbyname('id_cliente').AsString;
        inc(line);

        ga_stat.Progress := ga_stat.Progress + 1;
        next;
      end;
    finally
      free;
    end;

     Screen.Cursor := crDefault;

    if exist then
    begin
      titulo := 'ubicaciones_'  + IntToStr(main_cli) + '.xlsx';

      excel.activeworkbook.saveas(IncludeTrailingPathDelimiter(ruta_escritorio) + titulo);
      ShowMessage('Fichero Ubicaciones Guardado en ' + IncludeTrailingPathDelimiter(ruta_escritorio));
    end;

    Excel.Quit;
    Excel := Unassigned;
end;


procedure Tf_main.habilita_menus(locked: Boolean; modo_hist: Boolean);
begin
  mnUtils.Enabled       := (not modo_historico) and locked;
    mnArchivaHist.Enabled := (not modo_historico) and locked;
  mnPedidos.Enabled     := locked;
    mnModoHist.Enabled    := locked;
  mnAlmacen.Enabled     := locked;
    mnUbicsArts.Enabled   := locked;
end;

procedure Tf_main.AsignaPAV(pav:string);
var
  todos, cancelado: Boolean;
  Dialog: TForm;
  i, ped_actual: Integer;
  pedidos: string;
begin
  Screen.Cursor := crHourglass;

  ped_actual := dm.q_peds.FieldByName('id_pedido').AsInteger;

  pnPtes.Enabled := False;

  todos := true;
  cancelado := False;

  if gr_envs.SelCount > 0 then
  begin
    todos := false;
    Dialog := CreateMessageDialog('Existe una multiselección. ¿Qué pedidos desea asignar a PAV?', mtWarning, [mbYes, mbNo, mbCancel]);

    TButton(Dialog.Controls[2]).Caption := 'Todo';
    TButton(Dialog.Controls[3]).Caption := 'Selección';
    TButton(Dialog.Controls[4]).Caption := 'Cancelar';

    try
      case Dialog.ShowModal of
        mrYes:
          begin
            if (MessageDlg('Va a asignar a PAV TODOS los pedidos de la lista, ¿desea continuar?', mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes) then
              todos := True
            else
              cancelado := true;
          end;
        mrNo:
          begin
            if (MessageDlg('Va a asignar a PAV los pedidos SELECCIONADOS, ¿desea continuar?', mtWarning, [mbYes, mbNo], 0, mbNo) = mrYes) then
              todos := False
            else
              cancelado := true;
          end;
        mrCancel:
          cancelado := true;
      end;
    finally
      Dialog.Free;
    end;
  end;

  if not cancelado then
  begin
    if todos then    //generar todos los pedidos
    begin
      with TpFIBDataSet.Create(self) do
      try
        Database := dm.db;
        sqls.SelectSQL.Add('select id_pedido ' +
                           'from c_pedidos ' +
                           'where ((estado=''X'') or (estado=''P'')) ' +
                           'and id_cliente=:id_cliente order by id_pedido');
        ParamByName('id_cliente').AsInteger := StrToInt(edCliente.Text);
        Open;

        if not IsEmpty then
        begin
          pedidos := '';
          First;
          while not eof do
          begin
            pedidos := pedidos + FieldByName('id_pedido').AsString + ',';
            Next;
          end;
        end
        else
          ShowMessage('No existen pedidos a generar.');
      finally
        free;
      end;
    end
    else
    begin  //generar solo seleccionados
      pedidos := '';

      for i := 0 to gr_envs.SelCount - 1 do
      begin
        gr_envs.GotoSelection(i);
        pedidos := pedidos + dm.q_peds.FieldByName('id_pedido').AsString + ',';
      end;
    end;

    dm.t_write.StartTransaction;

    try
      assign_pav(pav,Copy(pedidos, 1, Length(pedidos) - 1));

      dm.t_write.Commit;

    except on e:Exception do begin
      dm.t_write.rollback;
      InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','',
                 'Error AsignPAV',e.Message + '|' + Copy(pedidos, 1, Length(pedidos) - 1));
    end;
    end;

  end
  else
    lb_st1.Caption := 'Proceso cancelado.';

  pnPtes.Enabled := True;

  dm.q_peds.Locate('id_pedido',ped_actual,[]);

  Screen.Cursor := crDefault;
end;

function Tf_main.assign_pav(pav,pedidos:string):boolean;  //pav S-Si N-No C-Consulta
var
  enc: Boolean;
  i, j, pos: Integer;
  peds: TStringList;
begin
    enc := false;
    pos := -1;

    peds := TStringList.Create;
    peds.Delimiter := ',';
    peds.DelimitedText := pedidos;

    if pav='C' then
    begin
      if High(asignado_a_pav)>=0 then
      begin
          for I := 0 to peds.count-1 do
              for j := 0 to High(asignado_a_pav) do
                   if ((asignado_a_pav[j]<>-1) and (StrToInt(peds[i])=asignado_a_pav[j])) then
                        enc := true;
      end;
    end  else if pav='S' then begin
                 i := 0;
                 if High(asignado_a_pav)>=0 then
                 begin
                    while ((not enc) and (i<=peds.Count-1)) do
                    begin
                      for j := 0 to High(asignado_a_pav)+1 do
                           if ((asignado_a_pav[j]<>-1) and (StrToInt(peds[i])=asignado_a_pav[j])) then
                                enc := true;
                      Inc(i);
                    end;
                 end;

                 if ((not enc) and (pos>=0)) then
                 begin
                    SetLength(asignado_a_pav,Length(asignado_a_pav)+1);
                    asignado_a_pav[Length(asignado_a_pav)-1] := StrToInt(peds[pos]);
                 end;
             end else if pav='N' then begin
                     i := 0;

                     if High(asignado_a_pav)>=0 then
                     begin
                        while ((not enc) and (i<=peds.Count-1)) do
                        begin
                          for j := 0 to High(asignado_a_pav)+1 do
                               if ((asignado_a_pav[j]<>-1) and (StrToInt(peds[i])=asignado_a_pav[j])) then
                               begin
                                  asignado_a_pav[j] := -1;
                                  enc := true;
                               end
                               else Inc(i);
                        end;
                     end;

                 end;

    Result := enc;

    peds.Free;
end;

function Tf_main.gestiona_alertas:string;
var
  j: integer;
begin
  InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','',
                   'Ini GenPeds.GestAlertas','');

  with tpfibdataset.Create(dm) do
  begin

    database := dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select resultado from get_pedido_alertas(:id_cliente)');

    Close;
    ParambyName('id_cliente').asinteger := main_cli;

    try
      Open;

      if FieldByName('resultado').AsString<>'' then
      begin
        Result := FieldByName('resultado').AsString;
        //sMessageDlg(FieldByName('resultado').AsString, mtWarning, [mbok], 0);
      end;

    except on E:Exception do
           begin
              InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','',
                         'Error GenPeds.GestAlertas',IntToStr(main_cli) + ' ' + result);
           end;
    end;

    Free;
  end;

  InsertaLog(usuario.id,0,0,PC.Nombre,PC.IP,log_app,'','',
                   'Fin GenPeds.GestAlertas', ' ' + result);
end;


function Tf_main.busca_articulo_heredado(id_art:Integer):Integer;
var
  enc: Boolean;
  i: integer;
begin
  enc := false;
  i := 0;

  while (not enc) and (i<=High(arts_heredados)) do
  begin
    enc := (id_art=arts_heredados[i].art_main);
    Inc(i);
  end;

  Result := arts_heredados[i-1].art_padre;
end;

end.

