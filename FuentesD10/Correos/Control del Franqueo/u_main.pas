unit u_main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, sDialogs,
  sToolEdit, sSkinProvider, sSkinManager, Vcl.ImgList, Vcl.StdCtrls, sButton,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls, acImage, Vcl.Grids, sSpinEdit, sEdit,
  Vcl.Mask, sMaskEdit, sCustomComboEdit, sGroupBox, sLabel, Vcl.Buttons,
  sSpeedButton, sPanel, Vcl.ComCtrls, sPageControl, frxClass, frxDBSet, Data.DB,
  Datasnap.DBClient, pFIBDataSet, Vcl.DBGrids, acDBGrid, sCheckBox, frxBarcode,
  sStatusBar,
  Vcl.DBCtrls, sDBComboBox, sComboBox,Shlobj, System.Types, system.StrUtils, System.Math, MidasLib,
  System.ImageList, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
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
  dxSkinXmas2008Blue, dxBarCode, System.Win.ComObj, Vcl.Clipbrd, dxPDFDocument,
  dxBarBuiltInMenu, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap,
  dxPrnDev, dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns,
  dxPSPDFExportCore, dxPSPDFExport, cxDrawTextUtils, dxPSPrVwStd, dxPSPrVwAdv,
  dxPSPrVwRibbon, dxPScxPageControlProducer, dxPScxEditorProducers,
  dxPScxExtEditorProducers, cxClasses, dxPSCore, dxCustomPreview, dxPDFViewer,
  sGauge, dxPSdxPDFViewerLnk;


type
  Tf_main = class(TForm)
    pg_1: TsPageControl;
    tsFranqueo: TsTabSheet;
    tsPaqueteria: TsTabSheet;
    pnFiltro: TsPanel;
    btGuardar: TsSpeedButton;
    btLimpiar: TsSpeedButton;
    btCancel: TsSpeedButton;
    grData: TStringGrid;
    il1: TImageList;
    sknmngr1: TsSkinManager;
    sknprvdr1: TsSkinProvider;
    ar_bonificacion: TClientDataSet;
    intgrfld_resumenid_cliente: TIntegerField;
    strngfld_resumennombre: TStringField;
    strngfld_resumenfecha_desde: TStringField;
    strngfld_resumenfecha_hasta: TStringField;
    intgrfld_resumenuds_local: TIntegerField;
    intgrfld_resumenuds_d1: TIntegerField;
    intgrfld_resumenuds_d2: TIntegerField;
    intgrfld_resumenuds_int_eur: TIntegerField;
    intgrfld_resumenuds_int_resto: TIntegerField;
    fltfld_resumenimp_local: TFloatField;
    fltfld_resumenimp_d1: TFloatField;
    fltfld_resumenimp_d2: TFloatField;
    fltfld_resumenimp_int_eur: TFloatField;
    fltfld_resumenimp_int_resto: TFloatField;
    rep_db_bonificacion: TfrxDBDataset;
    repBonificacion: TfrxReport;
    pnBts: TsPanel;
    btAdd: TsSpeedButton;
    btUpdate: TsSpeedButton;
    btDelete: TsSpeedButton;
    lbModo: TsLabel;
    btConsulta: TsSpeedButton;
    lbLineas: TsLabel;
    gb1: TsGroupBox;
    chTodosCl: TsCheckBox;
    chTodosCC: TsCheckBox;
    edTXT: TsDirectoryEdit;
    btTXT: TsSpeedButton;
    grCertificadas: TsDBGrid;
    gbDetalle: TsGroupBox;
    edEmpresa: TsEdit;
    edDireccion: TsEdit;
    edLocalidad: TsEdit;
    edProvincia: TsEdit;
    edCP: TsEdit;
    edPais: TsEdit;
    edReferencia: TsEdit;
    edPeso: TsDecimalSpinEdit;
    rgSobre: TsRadioGroup;
    edAlto: TsDecimalSpinEdit;
    edAncho: TsDecimalSpinEdit;
    edLargo: TsDecimalSpinEdit;
    btCancelPaq: TsSpeedButton;
    btGuardaCert: TsSpeedButton;
    edIdCert: TsSpinEdit;
    rgProdCert: TsRadioGroup;
    rgPeso: TsRadioGroup;
    gbInformes: TsGroupBox;
    btXls: TsSpeedButton;
    btReport: TsSpeedButton;
    edFDesde: TsDateEdit;
    edFHasta: TsDateEdit;
    rgCliente: TsRadioGroup;
    rgCeco: TsRadioGroup;
    edXls: TsDirectoryEdit;
    rgTipo: TsRadioGroup;
    repCert: TfrxReport;
    rep_cert: TfrxDBDataset;
    btCP: TsSpeedButton;
    tsConfig: TsTabSheet;
    edCtoRmt: TsEdit;
    gb2: TsGroupBox;
    edMinCert: TsSpinEdit;
    edMaxCert: TsSpinEdit;
    rgZona: TsRadioGroup;
    lbFrEnc: TsLabel;
    ar_resumen: TClientDataSet;
    rep_db_resumen: TfrxDBDataset;
    represumen: TfrxReport;
    intgrfld_resumenid_cliente1: TIntegerField;
    strngfld_resumennombre1: TStringField;
    strngfld_resumenceco: TStringField;
    strngfld_resumenfecha_desde1: TStringField;
    strngfld_resumenfecha_hasta1: TStringField;
    intgrfld_resumenuds_20: TIntegerField;
    intgrfld_resumenuds_50: TIntegerField;
    intgrfld_resumenuds_100: TIntegerField;
    intgrfld_resumenuds_500: TIntegerField;
    intgrfld_resumenuds_1000: TIntegerField;
    intgrfld_resumenuds_2000: TIntegerField;
    fltfld_resumenimp_20: TFloatField;
    fltfld_resumenimp_50: TFloatField;
    fltfld_resumenimp_100: TFloatField;
    fltfld_resumenimp_500: TFloatField;
    fltfld_resumenimp_1000: TFloatField;
    fltfld_resumenimp_2000: TFloatField;
    rep_db_detalle: TfrxDBDataset;
    ar_detalle: TClientDataSet;
    repDetalle: TfrxReport;
    gbTCliente: TsGroupBox;
    lb4: TsLabel;
    lb5: TsLabel;
    lb3: TsLabel;
    pnl1: TPanel;
    pnl2: TPanel;
    pnl3: TPanel;
    pnl4: TPanel;
    pnl5: TPanel;
    pnl6: TPanel;
    pnl7: TPanel;
    pnl8: TPanel;
    pnl9: TPanel;
    pnl10: TPanel;
    pnl11: TPanel;
    pnl12: TPanel;
    lb1: TsLabel;
    lb6: TsLabel;
    lb7: TsLabel;
    lb8: TsLabel;
    pnl13: TPanel;
    pnl14: TPanel;
    lb9: TsLabel;
    lb10: TsLabel;
    pnl15: TPanel;
    pnl16: TPanel;
    pnl17: TPanel;
    pnl18: TPanel;
    lbTClienteUds: TsLabel;
    lbTClienteImp: TsLabel;
    lbT20Uds: TsLabel;
    lbT50Imp: TsLabel;
    lbT50Uds: TsLabel;
    lbT100Imp: TsLabel;
    lbT20Imp: TsLabel;
    lbT500Uds: TsLabel;
    lbT1000Uds: TsLabel;
    lbT500Imp: TsLabel;
    lbT1000Imp: TsLabel;
    lbT2000Imp: TsLabel;
    lbT100Uds: TsLabel;
    lbT2000Uds: TsLabel;
    lb18: TsLabel;
    gb3: TsGroupBox;
    lbTotal: TsLabel;
    cbCP: TsComboBox;
    btCambiaCl: TsSpeedButton;
    pn1: TsPanel;
    gbClCambia: TsGroupBox;
    edClCambia: TsEdit;
    btClCambia: TsSpeedButton;
    lbClCambia: TsLabel;
    edIdClCambia: TsSpinEdit;
    ts1: TsTabSheet;
    gr1: TsDBGrid;
    gbRetorno: TsGroupBox;
    bt3: TsSpeedButton;
    ed_file: TsFilenameEdit;
    ed1: TsEdit;
    gb4: TsGroupBox;
    edFiltroEstado: TsEdit;
    chEstClTodos: TsCheckBox;
    chEstCCTodos: TsCheckBox;
    edEstFDesde: TsDateEdit;
    edEstFHasta: TsDateEdit;
    chEstFTodas: TsCheckBox;
    lbCertEstado: TsLabel;
    pn2: TsPanel;
    edFiltroTexto: TsEdit;
    bt1: TsSpeedButton;
    spnGrupoGuardarTXT: TsPanel;
    btFTXT: TsSpeedButton;
    dtDesde: TsDateEdit;
    edtTXT: TsDirectoryEdit;
    dthasta: TsDateEdit;
    cds: TClientDataSet;
    ANEXO: TStringField;
    PRODUCTO: TStringField;
    REFERENCIA: TStringField;
    CLIENTE: TStringField;
    NACIONAL: TStringField;
    MODALIDAD: TStringField;
    PESO: TStringField;
    DESTINO: TStringField;
    ENVIOS: TIntegerField;
    VALOR: TStringField;
    rgProducto: TsRadioGroup;
    btTodos: TsButton;
    btCertif: TsSpeedButton;
    btBuscarTxt: TsSpeedButton;
    stat: TStatusBar;
    lbAlbaran: TsLabel;
    lbExpAgencia: TsLabel;
    dxPDF: TdxPDFViewer;
    btGenerar: TsSpeedButton;
    lbRegistro: TLabel;
    ga_stat: TsGauge;
    dxprinter: TdxComponentPrinter;
    dxpdfvwrprtlnklink: TdxPDFViewerReportLink;
    cds_detalleid_cliente: TIntegerField;
    strngfld_detallenombre: TStringField;
    strngfld_detallececo: TStringField;
    ar_detallefecha: TDateField;
    strngfld_detalleproducto: TStringField;
    strngfld_detallezona: TStringField;
    cds_detallepeso: TIntegerField;
    ar_detalletarifa: TCurrencyField;
    cds_detalleuds: TIntegerField;
    ar_detallesubtotal: TCurrencyField;
    cds_cert: TClientDataSet;
    cds_certfecha: TDateField;
    strngfld_certempresa: TStringField;
    strngfld_certlocalidad: TStringField;
    strngfld_certdireccion: TStringField;
    strngfld_certcp: TStringField;
    strngfld_certacuse: TStringField;
    strngfld_certceco: TStringField;
    lbAuxprov: TLabel;
    strngfld_certbarcode: TStringField;
    grp1: TGroupBox;
    sPanel3: TsPanel;
    edFecha: TsDateEdit;
    pnCliente: TsPanel;
    btCliente: TsSpeedButton;
    lbCliente: TsLabel;
    btLock: TsSpeedButton;
    edCliente: TsEdit;
    bt2: TsButton;
    edIdcliente: TsSpinEdit;
    sPanel2: TsPanel;
    pnCECO: TsPanel;
    bpCeco: TsSpeedButton;
    lbCeco: TsLabel;
    edCeco: TsEdit;
    edIdCeco: TsSpinEdit;
    btImportVend: TsSpeedButton;
    edFile: TsFilenameEdit;
    lbProgreso: TsLabel;
    cds_bonificacionbon_fr_loc: TIntegerField;
    cds_bonificacionbon_fr_d1: TIntegerField;
    cds_bonificacionbon_fr_d2: TIntegerField;
    cds_bonificacionbon_fr_int_eur: TIntegerField;
    cds_bonificacionbon_fr_int_resto: TIntegerField;
    sPanel1: TsPanel;
    sSpinEdit1: TsSpinEdit;
    btAplicaFiltro: TsButton;
    procedure bpCecoClick(Sender: TObject);
    procedure btLimpiarClick(Sender: TObject);
    procedure btReportClick(Sender: TObject);
    procedure btUpdateClick(Sender: TObject);
    procedure btConsultaClick(Sender: TObject);
    procedure btAddClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure btGuardarClick(Sender: TObject);
    procedure btClienteClick(Sender: TObject);
    procedure edFechaChange(Sender: TObject);
    procedure edFechaClick(Sender: TObject);
    procedure btLockClick(Sender: TObject);
    procedure btXlsClick(Sender: TObject);
    procedure rgClienteChange(Sender: TObject);
    procedure rgProductoChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pg_1Change(Sender: TObject);
    procedure btGuardaCertClick(Sender: TObject);
    procedure grCertificadasCellClick(Column: TColumn);
    procedure btCancelPaqClick(Sender: TObject);
    procedure rgSobreChange(Sender: TObject);
    procedure grCertificadasAfterScroll(Sender: TObject; ScrollBar: Cardinal);
    procedure btTXTClick(Sender: TObject);
    procedure btCertifClick(Sender: TObject);
    procedure btCPClick(Sender: TObject);
    procedure rgProdCertClick(Sender: TObject);
    procedure edCPExit(Sender: TObject);
    procedure rgZonaChange(Sender: TObject);
    procedure rgZonaClick(Sender: TObject);
    procedure rgPesoClick(Sender: TObject);
    procedure btDeleteClick(Sender: TObject);
    procedure grDataKeyPress(Sender: TObject; var Key: Char);
    procedure cbCPClick(Sender: TObject);
    procedure rgTipoClick(Sender: TObject);
    procedure btCambiaClClick(Sender: TObject);
    procedure btClCambiaClick(Sender: TObject);
    procedure bt3Click(Sender: TObject);
    procedure chEstFTodasClick(Sender: TObject);
    procedure edFiltroEstadoChange(Sender: TObject);
    procedure chEstClTodosClick(Sender: TObject);
    procedure chEstCCTodosClick(Sender: TObject);
    procedure edEstFDesdeChange(Sender: TObject);
    procedure edEstFHastaChange(Sender: TObject);
    procedure rgEstOrdenChange(Sender: TObject);
    procedure gr1TitleClick(Column: TColumn);
    procedure edFiltroTextoChange(Sender: TObject);
    procedure bt1Click(Sender: TObject);
    procedure btFTXTClick(Sender: TObject);
    procedure btTodosClick(Sender: TObject);
    procedure edCPKeyPress(Sender: TObject; var Key: Char);
    procedure btBuscarTxtClick(Sender: TObject);
    procedure bt2Click(Sender: TObject);
    procedure lbAlbaranDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btGenerarClick(Sender: TObject);
    procedure edClienteExit(Sender: TObject);
    procedure edCecoExit(Sender: TObject);
    procedure edClienteChange(Sender: TObject);
    procedure lbExpAgenciaDblClick(Sender: TObject);
    procedure btImportVendClick(Sender: TObject);
    procedure btAplicaFiltroClick(Sender: TObject);
  private
    { Private declarations }
    function BuscaCliente(codigo:string):string;
    function BuscaClientePorId(id:integer):string;
    function BuscaClienteId(codigo:string):Integer;
    function BuscaCeco(codigo:string):string;
    function BuscaCecoPorId(id:Integer):string;
    function BuscaCecoId(codigo:string):Integer;
    procedure filter;
    procedure CargaInterfaz;
    procedure ReportDetalle;
    procedure ReportBonificacion;
    procedure ReportResumen;
    procedure XLSResumen;
    procedure XLSBonificacion;
    procedure XLSDetalle;
    procedure XLSDestinatarios;
    function RellenaCabecerasDetalle(fila:Integer):integer;
    function RellenaCabecerasDestinatarios(fila:integer):integer;
    function RellenaCabecerasResumen(col,fila:Integer):integer;
    procedure RellenaCabecerasBonificacion(fila:Integer);
    function BuscaFranqueoPorFechas(cliente, ceco, peso, producto, zona:integer; f1,f2:TDateTime; out importe:Double):Integer;
    function BuscaFranqueo(cliente, ceco, peso, producto, zona:integer; fecha:TDateTime):Integer;
    function ExisteFranqueo(cliente, ceco, peso, producto, zona:integer; fecha:TDateTime; out uds:Integer):Integer;
    function ExisteEstado(id:integer; fecha:TDateTime; estado: string):Integer;
    procedure AddFranqueo(cliente, ceco, peso, producto, zona, cantidad, suma:integer; fecha:TDateTime);
    function BuscaTarifa(cliente, ceco, peso, producto, zona:integer):Double;
    procedure HabilitaDatos(habilitar:Boolean);
    function GetTotalCliente(cliente:Integer; out uds:integer):Double;
    function GetTotalClienteProducto(cliente,producto:Integer; out uds:integer):Double;
    function GetTotalClientePeso(cliente, peso:Integer; out uds:integer):Double;
    function GetTotalClientePesoProducto(cliente, peso,producto:Integer; out uds:integer):Double;
    function CreaTXT:string;
    procedure filter_certificadas;
    procedure filter_estados;
    procedure VaciaCertificada;
    procedure GetMedidasSobre;
    procedure ActualizaLogFile(ids,nombre:string);
    function CalculaBarcode:string;
    function CalculaCol(peso:Integer):integer;
    procedure RellenaComboCP(cp:string);
    function SpecialFolder(Folder: Integer): String;
    function BuscaId(ref:string):integer;
    procedure vuelcaInformacion(Sender: TObject);
    procedure GenerarTXT;
    procedure InsertaCabecera(cliente:string);
    procedure InsertaModalidad;
    procedure InsertaEnvioYValor;
    procedure CreaTXTSDA(nombre, producto,orden:string);
    procedure CargarLimiteCertificadas;
    procedure carga_maestros;
    function busca_en_clientes(id:integer):integer;
    function busca_en_cecos(id:integer):integer;
    procedure LoadConfigCliente(cli: Integer);
  public
    { Public declarations }
    procedure RellenaCertificada;
    procedure GetCertEstado(id:Integer);
    procedure AbreFichero(nombre:string);
    Procedure CreaExcel;
    procedure imprime_etiqueta_x_api(id_albaran, id_dest:integer);
    function genera_albaranes(pedidos:string):Boolean;
    procedure registro_y_etiqueta(id_albaran, id_dest:integer);
    function tiene_etiquetas(codalbaran:integer):Boolean;
    function get_grupos:TStringList;
  end;


type
  TMaestros = record
    id: integer;
    id2: integer;
    codigo: string;
    nombre: string;

  end;

var
  f_main: Tf_main;
  locked:Boolean=True;
  modo: Integer=0; //0-consulta 1-edición 2-inserción
  txt: TextFile;
  col_estado: integer;

  excel, libro: Variant;
  hoja:OleVariant;
  excel_d: Variant;

  grupo_gih: string;
  grupo_santalucia: string;

  clientes : array of TMaestros;
  cecos: array of TMaestros;

  bon_franq_loc, bon_franq_d1, bon_franq_d2, bon_franq_int_eur, bon_franq_int_resto: Integer;

const
    main_cli = 7428;
    log_app = 'FR';
    tab = #9;
    ln = #13#10;
    bc_ini = 3247512001;
    bc_fin = 3247512500;
    matricula='DIMV007529';
    version = '[5.7]';
    //[5.7] Boton aplicar filtro
    //[5.6] Parametros porcentajes bonificacion
    //[5.5] Indices bbdd. Optimizacion buscadores. Importar vendidos.
    //[5.4] Cambio bbdd SXXI
    //[5.3.1] alias db quitado
    //[5.3] Alto fijo. Control de longitud de empresa al guardar certificada.
    //Listado ordinarias no busca en gestoras (se cargan los maestros en array previo)
    //[5.2.2] Cambio interfaz filtro fecha, cliente y ceco. Control de contacto vacio en certificadas GIH (paqueteria).
    //[5.2.1] Cambiar index en cds de certificadas. Cambio botón filtro de Franqueo.
    //[5.2] Bug: vaciar cds al calcular reports
    //[5.1] Cálculo de barcode en certificadas de santalucia
    //[5] Versión en D10. Api.
    //[4.2.5] Botón buscador de texto, quitado de onChange.
    //[4.2.4] Redondeos a dos decimales en excel bonifiación. Uso de importes como float en
    //cálculo de imp. total en excel bonificacion (se trataban como enteros).
    //Mutex-control de aplicación abierta. Versión.
implementation

 {4.2.3 Permitir la introducción de texto libre en cp, localidad y provincia. Abrir buscapro
  con enter en edcp y mostrar las localidades de ese cp, si las hay. }
 {4.2.2.1 Añadir 3200 a calculo de barcode en certificadas. Excluir 3200 de listados que no
  son de Santalucia }
 {4.2.2 Añadir 3200 a listado de certificadas }
 {4.2.1 Cambio de matrícula de máquina franqueadora y control de clasificación y
        producto según sea nacional o internacional al sacar el fichero para Correos. }
 {Version 4.2 - Piden modificacion del filtro de totales. Ahora se filtra por cliente y producto}

uses
  ubuscapro, u_dm, u_globals, ubuscapro_ss, u_globals_gestoras, u_gen_gl, ubuscapro_gest,
  u_cam_gl, u_LstEtiquetas, u_AlbaranValidate, u_functions, UDMCreaBultos;

{$R *.dfm}

{$REGION 'INTERFAZ'}

procedure Tf_main.FormCreate(Sender: TObject);
begin
  //ShowMessage('leyendo ini');
  leer_ini;
  //ShowMessage(u_globals.ruta_exe);
  //ShowMessage(u_globals.dbname);
  leer_ini_gestoras;
  ini_bd_simple;
  ini_bd_gestoras;
  lee_inis_def;

  stat.Panels[0].Text := get_nombre_usuario(u_globals.id_usuario);
  stat.Panels[1].Text := u_globals.dbname + ' ' + u_globals_gestoras.db_gestoras;

  //ShowMessage(db_sql);
  if db_sql<>'' then
  begin
     // dm.con1.Connected := False;
      dm.con1.ConnectionString := db_sql;
      //dm.con1.Connected := True;
  end;

  //ShowMessage('');
  grData.Rows[1].Text := 'Nacional Local';
  grData.Rows[2].Text := 'Nacional D1';
  grData.Rows[3].Text := 'Nacional D2';
  grData.Rows[4].Text := 'Int. Europa';
  grData.Rows[5].Text := 'Int. Resto Mundo';
  grData.Cols[1].Text := '20';
  grData.Cols[2].Text := '50';
  grData.Cols[3].Text := '100';
  grData.Cols[4].Text := '500';
  grData.Cols[5].Text := '1000';
  grData.Cols[6].Text := '2000';

  grData.ColWidths[0] := 100;

  edTXT.Text := SpecialFolder(CSIDL_DESKTOP);
  edXls.Text := SpecialFolder(CSIDL_DESKTOP);

  lbModo.Caption := '';
  lbTotal.Caption := '';
  modo := 0;

  pg_1.ActivePageIndex := 0;
  Width := 1178;
  Height := 922;
  Caption := 'Control de Franqueo ' + version;

  lbProgreso.Caption := '';

  get_grupos;

  LoadConfigCliente(-1000);

  carga_maestros;

  filter_estados;

end;

procedure Tf_main.FormShow(Sender: TObject);
begin
  api := GetConexion(api);

  if api='' then
  begin
    ShowMessage('IMPORTANTE: Revise la configuración de API en su fichero Config.ini (api=API_TEST o API_PRO).' + #10#13 +
                'La aplicación se cerrará.');
    Application.Terminate;
  end;
end;

function Tf_main.SpecialFolder(Folder: Integer): String;
var
  SFolder : pItemIDList;
  SpecialPath : Array[0..MAX_PATH] Of Char;
begin
  SHGetSpecialFolderLocation(f_main.Handle, Folder, SFolder);
  SHGetPathFromIDList(SFolder, SpecialPath);
  Result := StrPas(SpecialPath);
end;

procedure Tf_main.btGenerarClick(Sender: TObject);
var
  titulo_error, error_exe: string;
  id_albaran,id_destino, error, i, id_actual: Integer;
  albaranes, destinos: TStringList;

begin
if ((not chTodosCl.Checked) and ( not (StrtoInt(edIdCliente.Text)>0))) then
      raise Exception.Create('Debe indicar un cliente o seleccionar todos.');

  if ((not chTodosCC.Checked) and ( not (edIdCeco.Value>0))) then
      raise Exception.Create('Debe indicar un CECO o seleccionar todos.');

  if edTXT.Text='' then
       raise Exception.Create('Debe indicar una carpeta destino.');

  if not DirectoryExists(edTXT.Text) then
       raise Exception.Create('La carpeta indicada no existe.');


  pnBts.Enabled := False;
  tspaqueteria.enabled := False;

  try
    with dm.qfile do
    begin
      Close;
      SelectSQL.Clear;
      SelectSQL.Add('select * from mv_correos_certificadas c ' +
                    'where fecha=:fecha and gest_albaran is null and tipo=''P'' '+
                    ' and id_cliente in (' +  grupo_gih + ') ');   //Solo GIH (3205 a 3211)

      if not chTodosCl.checked then
           SelectSQL.Add(' and id_cliente=' + edIdCliente.Text);
      if not chTodosCC.Checked then
           SelectSQL.Add(' and id_ceco=' + edIdCeco.Text);

      ParamByName('fecha').AsDate := edFecha.Date;
      Open;

      if not IsEmpty then
      begin

        First;

        ga_stat.MaxValue := dm.qfile.RecordCount;
        ga_stat.Progress:=0;
        application.ProcessMessages;

        dm.t_write.StartTransaction;
        dm.t_write_gestoras.StartTransaction;

        albaranes := TStringList.Create;
        destinos := TStringList.Create;

        try

          while not Eof do begin
               lbRegistro.Caption := 'Creando albarán ... ';

               try
                dm.stpGrabaAlb.Database := dm.db_gestoras;
                dm.stpGrabaAlb.Transaction := dm.t_write_gestoras;
                dm.stpGrabaAlb.SQL.Clear;
                dm.stpGrabaAlb.SQL.Add('execute procedure lgs_crea_albaran_certificada(:id_certificada)');
                dm.stpGrabaAlb.ParamByName('id_certificada').Value := FieldByName('id_correos_certificadas').AsInteger;
                dm.stpGrabaAlb.ExecProc;
                dm.t_write_gestoras.CommitRetaining;

                error := dm.stpGrabaAlb.ParamByName('error').Value;
                titulo_error := dm.stpGrabaAlb.ParamByName('titulo_error').Value;
                id_albaran := dm.stpGrabaAlb.ParamByName('id_albaran').Value;
                id_destino := dm.stpGrabaAlb.ParamByName('id_albaran_det').Value;
               except on E:Exception do
                      begin
                       error_exe := 'Error creando albaranes. ' + titulo_error;
                       dm.t_write.RollbackRetaining;
                       raise;
                      end;
               end;

            albaranes.Add(IntToStr(id_albaran));
            destinos.Add(IntToStr(id_destino));

            Next;

            ga_stat.Progress := ga_stat.Progress + 1;

          end;

          dm.t_write.Commit;
          dm.t_write_gestoras.Commit;

          i := 0;
          for i := 0 to albaranes.Count-1 do
              registro_y_etiqueta(StrToInt(albaranes[i]),StrToInt(destinos[i]));

          albaranes.Free;
          destinos.Free;

          lbRegistro.Caption := 'Proceso finalizado. ';
          ShowMessage('Albaranes creados correctamente.');

        except
          dm.t_write.rollback;
          dm.t_write_gestoras.Rollback;
          ShowMessage(error_exe);
        end;

      end else
             ShowMessage('No existen albranes para crear.');
    end;

    pnBts.Enabled := True;
    tspaqueteria.enabled := True;

    filter_certificadas;

    dm.qfiltro_certif.Locate('id_correos_certificadas',dm.qfiltro_certif.FieldByName('id_correos_certificadas').AsInteger,[]);
  except
      on e:Exception do
      begin
          lbRegistro.Caption := 'Error creando albaranes. ';
          ShowMessage('Error creando albaranes.' + e.Message);
      end;
  end;

end;

procedure Tf_main.CargaInterfaz;
var
  f_type, order_ok: string;
  i, uds: integer;
  total : Double;
  stream: TStream;
begin

  pnFiltro.Enabled := locked;
  pnCECO.Enabled := locked;

  if pg_1.ActivePageIndex = 1 then
      pnBts.Enabled := locked
  else
      pnBts.Enabled := False;

  lbCeco.Caption := '(Seleccione un CECO válido)';
  rgCeco.Items.Strings[1] := 'CECO por seleccionar';
  edCeco.Text := '';
  lbTotal.Caption := '';

  {
  filter;
  filter_certificadas;
  filter_estados;
  }

  if not locked then
  begin
     lbTClienteUds.Caption := '0';
     lbTClienteImp.Caption := '0,00';
     lbT20Uds.Caption := '0';
     lbT20Imp.Caption := '0,00';
     lbT50Uds.Caption := '0';
     lbT50Imp.Caption := '0,00';
     lbT100Uds.Caption := '0';
     lbT100Imp.Caption := '0,00';
     lbT500Uds.Caption := '0';
     lbT500Imp.Caption := '0,00';
     lbT1000Uds.Caption := '0';
     lbT1000Imp.Caption := '0,00';
     lbT2000Uds.Caption := '0';
     lbT2000Imp.Caption := '0,00';
  end;


end;

procedure Tf_main.cbCPClick(Sender: TObject);
begin
  //edProvincia.Text := String(cbCP.Items.Objects[cbCP.ItemIndex]);
end;

procedure Tf_main.chEstCCTodosClick(Sender: TObject);
begin
   filter_estados;
end;

procedure Tf_main.chEstClTodosClick(Sender: TObject);
begin
  filter_estados;
end;

procedure Tf_main.chEstFTodasClick(Sender: TObject);
begin
    edEstFDesde.Enabled := not chEstFTodas.Checked;
    edEstFHasta.Enabled := not chEstFTodas.Checked;
    filter_estados;
end;

procedure Tf_main.pg_1Change(Sender: TObject);
begin
  case pg_1.ActivePageIndex of
     0: begin
          f_main.Width := 1178;
          //f_main.Height := 824;
          pnBts.Enabled := False;
          btAdd.Grayed := True;
          btDelete.Grayed := True;
          btUpdate.Grayed := True;
        end;
     1: begin
          f_main.Width := 1603;
          //f_main.Height := 880;
          pnBts.Enabled := locked;
          btAdd.Grayed := False;
          btDelete.Grayed := False;
          btUpdate.Grayed := False;
        end;
     2: begin
          f_main.Width := 1152;
          //f_main.Height := 875;
          pnBts.Enabled := False;
          btAdd.Grayed := True;
          btDelete.Grayed := True;
          btUpdate.Grayed := True;
        end;
  end;
end;

procedure Tf_main.HabilitaDatos(habilitar:Boolean);
begin
 { grData.Enabled := habilitar;
  btLimpiar.Enabled := habilitar;
  btGuardar.Enabled := habilitar;
  btCancel.Enabled := habilitar;  }
  btLock.Enabled := not habilitar;
  //btConsulta.Enabled := not habilitar;

  grCertificadas.Enabled := not habilitar;
  gbDetalle.Enabled := habilitar;
  btCambiaCl.Enabled := habilitar;
  //btGuardaCert.Enabled := habilitar;
  //btCancelPaq.Enabled := habilitar;

  btAdd.Enabled := not habilitar;
  btDelete.Enabled := not habilitar;
  btUpdate.Enabled := not habilitar;


 { rgProdCert.Enabled := habilitar;
  rgPeso.Enabled := habilitar;
  rgZona.Enabled := habilitar;    }

end;

procedure Tf_main.bpCecoClick(Sender: TObject);
begin
   with fbuscapro_gest do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='ceco,titulo,id_cli_ceo';
    titulos.commatext:='Código,Nombre, Id';
    from:='cli_cecos ';
    where:='id_cliente=' + edIdCliente.Text;
    orden[1]:=1;  busca:=2;   distinct:=0;   fillimpio:=True;   row_height:=17;

    showmodal;

    if resultado then begin
      with Sender as TsSpeedButton do begin
        edCeco.text:=valor[1];
        lbCeco.caption:=valor[2];
        edIdCeco.Text := valor[3];
       { if modo=0 then
        begin
          filter;
          filter_certificadas;
          if not chEstCCTodos.Checked then
            filter_estados;
        end; }
      end;
    end;
  end;

end;

procedure Tf_main.btUpdateClick(Sender: TObject);
begin
  if not (edIdCert.Value>0) then
     raise Exception.Create('No existe registro a modificar.');

  HabilitaDatos(true);
  btAdd.Enabled := False;
  btDelete.Enabled := False;
  btUpdate.Enabled := False;
  btLimpiar.Enabled := False;
  lbModo.Caption := 'Modificando registro ...';

  modo := 1;
end;


procedure Tf_main.btConsultaClick(Sender: TObject);
begin
  modo := 0;
  HabilitaDatos(false);
  btAdd.Visible := True;
  btUpdate.Visible := True;
  btAdd.Enabled := True;
  btUpdate.Enabled := True;
  lbModo.Caption := '';
  grCertificadas.Enabled := True;

  rgProducto.Items.Clear;
  rgProducto.Items.Add('Ordinarias');
  rgProducto.Items.Add('Certificadas');
  rgProducto.Items.Add('Cert. con A.R.');
  rgProducto.ItemIndex := 0;

  filter;
  filter_certificadas;
  filter_estados;
end;


procedure Tf_main.btCPClick(Sender: TObject);
begin
  with fbuscapro_gest do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    titulos.commatext:='C.Postal, Localidad, Provincia';
    fields.commatext:='l.codigo_postal,l.titulo,p.titulo ';
    from:='sys_localidades l inner join sys_provincias p on p.provincia=l.provincia and p.pais=l.pais ';
    if edCP.Text<>'' then
       where:='l.codigo_postal='''+edCp.Text + ''''
    else
       where:='';
    orden[1]:=1;  busca:=1;   distinct:=0;   fillimpio:=True;   row_height:=17;

    showmodal;

    if resultado then begin
      with Sender as TsSpeedButton do begin
        edCP.Text:=valor[1];
        edLocalidad.Text:=valor[2];
        edProvincia.Text := valor[3];
      end;

      RellenaComboCP(valor[1]);
      cbCP.ItemIndex := cbCP.IndexOf(valor[2]);

    end;
  end;
end;


procedure Tf_main.RellenaComboCP(cp: string);
begin
    with dm.qCP do
      begin
           Close;
           ParamByName('cp').AsString := cp;
           Open;
           First;

           cbCP.Clear;
           while not eof do
           begin
             cbCP.AddItem(FieldByName('titulo').AsString,nil);
             lbAuxprov.Caption := FieldByName('titulo1').AsString;
             Next;
           end;
           cbCP.ItemIndex := 0;
      end;
end;

procedure Tf_main.btDeleteClick(Sender: TObject);
begin
  if dm.qfiltro_certif.IsEmpty then
    raise Exception.Create('No existen registros a eliminar.');

  if edIdCert.Value<=0 then
    raise Exception.Create('Debe seleccionar un registro.');

  if MessageDlg('Va a eliminar el registro seleccionado, ¿desea continuar?',mtWarning,mbYesNo,mrNo)=mrYes then
  begin
      with dm.q_1 do
      begin
        try
           dm.t_write.StartTransaction;

           Close;
           SQL.Clear;
           sql.add('update m_correos_certificadas set ' +
                   'estado=:estado ' +
                   'where id_correos_certificadas=:id_correos_certificada');

           ParamByName('id_correos_certificada').asinteger := edIdCert.Value;
           ParamByName('estado').AsString := 'B';

           ExecQuery;

           dm.t_write.CommitRetaining;
           filter;
           filter_certificadas;
           filter_estados;
           ShowMessage('Registro eliminado correctamente.');
        except
           dm.t_write.RollbackRetaining;
           ShowMessage('Error al eliminar el registro seleccionado.');
        end;
      end;
  end;
end;

procedure Tf_main.btFTXTClick(Sender: TObject);
begin
 vuelcaInformacion(self);
 if(cds.RecordCount<=0) then
  ShowMessage('No existen datos a volcar para ese periodo')
 else GenerarTXT;
end;

procedure Tf_main.bt1Click(Sender: TObject);
begin
  pg_1.ActivePageIndex := 2;
end;

procedure Tf_main.bt2Click(Sender: TObject);
var
  albaranes, destinos: TStringList; i:integer;
begin
  albaranes := TStringList.Create;
  albaranes.Add('18017434');


  destinos := TStringList.Create;
  destinos.Add('7795');


  for i := 0 to albaranes.Count-1 do
      imprime_etiqueta_x_api(StrToInt(albaranes[i]),StrToInt(destinos[i]));

  albaranes.Clear;
  albaranes.Free;
  destinos.Clear;
  destinos.Free;

end;

procedure Tf_main.bt3Click(Sender: TObject);
var
  fic: TStringList;
  str_dyn:TStringDynArray;
  n,i, id: integer;
  fecha: string;
begin
  if FileExists(ed_file.filename) then begin
    fic:=tstringlist.create();
    fic.LoadFromFile(ed_file.filename);

    n:=0;

    try

      for i:=0 to fic.Count-1 do begin

        str_dyn:=splitstring(fic[i],#9);

        fecha := Copy(Trim(str_dyn[6]),7,2) + '/' + Copy(Trim(str_dyn[6]),5,2) + '/' + Copy(Trim(str_dyn[6]),0,4);
        id := BuscaId(str_dyn[3]);

        if (id>0) and (ExisteEstado(id,StrToDateTime(fecha + ' ' + str_dyn[7]),str_dyn[5])=-1) then
        begin              //new cabecera

          dm.t_write.StartTransaction;
          dm.q_1.Close;
          dm.q_1.sql.Clear;
          dm.q_1.sql.Add('insert into m_correos_certificadas_estados '+
            '(id_correos_certificada, referencia, fecha, estado, linea) '+
            'values (:id_correos_certificada, :referencia, :fecha, :estado, :linea)');
          dm.q_1.ParamByName('id_correos_certificada').AsInteger:=id;
          dm.q_1.ParamByName('referencia').AsString:= Copy(str_dyn[3],0,Pos('*',str_dyn[3])-2);
          dm.q_1.ParamByName('fecha').AsDateTime := StrToDateTime(fecha + ' ' + str_dyn[7]);
          dm.q_1.ParamByName('estado').asstring:=str_dyn[5];
          dm.q_1.ParamByName('linea').asstring:= fic[i];
          dm.q_1.ExecQuery;

          dm.t_write.Commit;

          Inc(n);
        end;
       end;

    except
      on ed_file:Exception do begin
        sMessageDlg('Error Importando Fichero '+ed_file.message, mtError,[mbok],0);
        dm.t_write.Rollback;
        exit;
      end;
    end;

    ShowMessage('Importación Finalizada Correctamente. Actualizado/s ' + IntToStr(n) + ' estado/s.');
    //filter_certificadas;
  end;
end;


procedure Tf_main.btBuscarTxtClick(Sender: TObject);
begin
  if modo=0 then
  begin
    filter_certificadas;
    filter_estados;
  end;
end;

function Tf_main.ExisteEstado(id:integer; fecha:TDateTime; estado:string):Integer;
begin
  result  := -1;
   with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select id_correos_cert_estado from m_correos_certificadas_estados ' +
                       'where id_correos_certificada=:id and fecha=:fecha and ' +
                       'estado=:estado');
    ParamByName('id').AsInteger := id;
    ParamByName('fecha').AsDateTime := fecha;
    ParamByName('estado').AsString := estado;
    Open;

    if not(IsEmpty) then
    begin
      Result :=FieldByName('id_correos_cert_estado').AsInteger;
    end;

    Free;
  end;
end;

function Tf_main.BuscaId(ref: string):Integer;
var
  i: integer;
  id: string;
begin
   Result := -1;
   if Pos('*',ref)>0 then
     for i := Pos('*',ref)+1 to Length(ref) do
        if (Copy(ref,i,1)='*') then
        begin
            Result := StrToIntDef(id,-1);
            Exit;
        end
        else
            id := id + Copy(ref,i,1);
end;

procedure Tf_main.btAddClick(Sender: TObject);
begin
  HabilitaDatos(true);
  btUpdate.Enabled := False;
  btAdd.Enabled := False;
  btDelete.Enabled := False;
  lbModo.Caption := 'Insertando nuevo registro ...';

  //btLimpiarClick(Self);
  VaciaCertificada;
  grCertificadas.Enabled := False;

  modo := 2;

  //  rgProducto.Items.Clear;
//  rgProducto.Items.Add('Ordinarias');
//  rgProducto.ItemIndex := 0;
end;

procedure Tf_main.btAplicaFiltroClick(Sender: TObject);
begin
    if modo=0 then
    begin
      filter;
      filter_certificadas;
      if not chEstCCTodos.Checked then
        filter_estados;
    end;
end;

procedure Tf_main.btCambiaClClick(Sender: TObject);
begin
  gbClCambia.Visible := not gbClCambia.Visible;
end;

procedure Tf_main.btCancelClick(Sender: TObject);
begin
  HabilitaDatos(false);
  filter;
end;


procedure Tf_main.btCancelPaqClick(Sender: TObject);
var
  id:integer;
begin
   id := dm.qfiltro_certif.FieldByName('id_correos_certificadas').AsInteger;
   filter_certificadas;
   HabilitaDatos(false);
   if not  dm.qfiltro_certif.IsEmpty then
   begin
     dm.qfiltro_certif.Locate('id_correos_certificadas',id,[]);
     RellenaCertificada;
   end;
   modo := 0;
   lbModo.Caption := '';

   filter_estados;
end;

procedure Tf_main.btCertifClick(Sender: TObject);
begin
  if ((not chTodosCl.Checked) and ( not (StrToInt(edIdCliente.Text)>0))) then
      raise Exception.Create('Debe indicar un cliente o seleccionar todos.');

  if ((not chTodosCC.Checked) and ( not (edIdCeco.Value>0))) then
      raise Exception.Create('Debe indicar un CECO o seleccionar todos.');

  try
    with dm.qRepCert do
    begin
      Close;
      SelectSQL.Clear;
      SelectSQL.Add('select c.* ' +
                    'from mv_correos_certificadas c ' +
                    //'inner join g_clientes cl on cl.id_cliente=c.id_cliente ' +
                    //'inner join g_clientes_cecos cc on cc.id_cliente_ceco=c.id_ceco ' +
                    'where c.barcode<>'''' and c.fecha=:fecha ' +
                    'and c.id_cliente in (' + grupo_santalucia + ') ');   //Solo Santa Lucia

      if not chTodosCl.checked then
           SelectSQL.Add(' and id_cliente=' + edIdCliente.Text);
      if not chTodosCC.Checked then
           SelectSQL.Add(' and id_ceco=' + edIdCeco.Text);

      ParamByName('fecha').AsDate := edFecha.Date;
      Open;

      If not IsEmpty then
      begin
        First;

        cds_cert.EmptyDataSet;

        while not Eof do
        begin
          cds_cert.Insert;
          cds_cert.FieldByName('fecha').AsDateTime := FieldByName('fecha').AsDateTime;
          cds_cert.FieldByName('empresa').AsString := FieldByName('empresa').AsString;
          cds_cert.FieldByName('direccion').AsString := FieldByName('direccion').AsString;
          cds_cert.FieldByName('localidad').AsString := FieldByName('localidad').AsString;
          cds_cert.FieldByName('cp').AsString := FieldByName('cp').AsString;
          cds_cert.FieldByName('acuse').AsString := FieldByName('acuse').AsString;
          cds_cert.FieldByName('ceco').AsString := CargarDatosTablaGestoras('cli_cecos','ceco','id_cli_ceo='+FieldByName('id_ceco').AsString);
          cds_cert.FieldByName('barcode').AsString := FieldByName('barcode').AsString;
          cds_cert.Post;
          Next;
        end;

        if repCert.PrepareReport then repCert.ShowPreparedReport;
      end else
            showmessage('No existen datos a mostrar.');
    end;

  except
      on e:Exception do
          ShowMessage('Error al crear fichero. ' + e.Message);
  end;


end;

procedure Tf_main.btClCambiaClick(Sender: TObject);
begin
   with fbuscapro_gest do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='cl.cliente,cl.nombre,cl.id_cliente';
    titulos.commatext:='Código,Nombre, Id';
    from:='clientes cl ';
    where := 'baja=0 and cl.grupo=7 ';
    orden[1]:=1;  busca:=2;   distinct:=0;   fillimpio:=True;   row_height:=17;

    showmodal;

    if resultado then begin
      with Sender as TsSpeedButton do begin
        edClCambia.text:=valor[1];
        lbClCambia.caption:=valor[2];
        edIdClCambia.Value :=  valor[3];
        //filter;
      end;
    end;
  end;

  //btLock.Enabled := (lbCliente.Caption<>'(Seleccione un cliente)');
end;

procedure Tf_main.btClienteClick(Sender: TObject);
begin
   with fbuscapro_gest do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='cl.cliente,cl.nombre_r_social, cl.id_cliente';
    titulos.commatext:='Código,Nombre,Id';
    from:='clientes cl ';
    where:='baja=0 and ' +
           'cl.id_cliente in (' + grupo_santalucia + ',' + grupo_gih + ')';
    orden[1]:=1;  busca:=2;   distinct:=0;   fillimpio:=True;   row_height:=17;

    showmodal;

    if resultado then begin
      with Sender as TsSpeedButton do begin
          edCliente.text:=valor[1];
          lbCliente.caption:=valor[2];
          edIdcliente.Text := valor[3];

          {if modo=0 then
          begin
            filter;
            filter_certificadas;
            if not chEstClTodos.Checked then
                filter_estados;
          end;  }
        end;
    end;
  end;

  //btLock.Enabled := (lbCliente.Caption<>'(Seleccione un cliente)');
  //btLockClick(self);
end;

procedure Tf_main.btGuardaCertClick(Sender: TObject);
var
  producto, zona, id, id_actual: integer;
begin
 // if ((modo=2) or (modo=1)) then
 // begin
     { if (modo=1) and (edIdCert.Text='') then
         raise Exception.Create('No existe registro a guardar.');  }
      if StrToInt(edCliente.Text)<=0 then
        raise Exception.Create('Cliente Inválido');

      if edIdCeco.Value<=0 then
        raise Exception.Create('CECO Inválido');

      if edEmpresa.Text='' then
        raise Exception.Create('Dato Empresa Vacío.');

      if edDireccion.Text='' then
        raise Exception.Create('Dato Dirección Vacío.');

      if cbCP.Text='' then
        raise Exception.Create('Dato Localidad Vacío.');

      if edProvincia.Text='' then
        raise Exception.Create('Dato Provincia Vacío.');

      if edCP.Text='' then
        raise Exception.Create('Dato C. Postal Vacío.');

      if edPais.Text='' then
        raise Exception.Create('Dato Pais Vacío.');

      if (Pos(edIdcliente.Text,grupo_gih)>0) and
         (edCtoRmt.Text='') then
            raise Exception.Create('Dato Contacto Remitente Vacío.');

       if Length(edEmpresa.Text)>60 then
        raise Exception.Create('Longitud Empresa (Máx. 60 caracteres)');

      with dm.q_1 do
      begin
        try
           dm.t_write.StartTransaction;

           Close;
           SQL.Clear;

           if modo=2 then
               sql.add('insert into m_correos_certificadas ' +
                       '(id_cliente, id_ceco, id_producto, fecha, empresa, direccion, ' +
                       'localidad, provincia, cp, pais, referencia, peso, alto, ancho, largo, idx_sobre, ' +
                       'barcode, acuse, tipo, cto_rmt, id_zona, fecha_insert, usuario_insert) values ' +
                       '(:cliente, :ceco, :producto, :fecha, :empresa, :direccion, :localidad, :provincia, ' +
                       ':cp, :pais, :referencia, :peso, :alto, :ancho, :largo, :idx_sobre, ' +
                       ':barcode, :acuse , :tipo, :cto_rmt, :zona, :fecha, :usuario) returning id_correos_certificadas')
           else
               sql.add('update m_correos_certificadas set ' +
                     'id_cliente=:cliente, id_ceco=:ceco, id_producto=:producto, empresa=:empresa, ' +
                     'direccion=:direccion, localidad=:localidad, provincia=:provincia, ' +
                     'cp=:cp, pais=:pais, referencia=:referencia, peso=:peso, alto=:alto, ' +
                     'ancho=:ancho, largo=:largo, idx_sobre=:idx_sobre, acuse=:acuse, tipo=:tipo, ' +
                     'cto_rmt=:cto_rmt, id_zona=:zona, fecha_update=:fecha, usuario_update=:usuario ' +
                     'where id_correos_certificadas=:id_correos_certificadas');

           ParamByName('cliente').asinteger := StrToInt(edIdCliente.Text);
           ParamByName('fecha').AsDateTime := edFecha.Date;
           ParamByName('ceco').asinteger := edIdCeco.Value;

           case rgProdCert.ItemIndex of
              0: begin
                  producto := 240;
                  ParamByName('producto').asinteger := 240;
                  ParamByName('acuse').AsString := '';
                 end;
              1: begin
                  producto := 325;
                  ParamByName('producto').asinteger := 325;
                  ParamByName('acuse').asstring:= 'A/R';
                 end;
           end;

           case rgZona.ItemIndex of
            0: zona := 1;     //Nacional
            1: zona := 4;     //Nacional D1
            2: zona := 5;     //Nacional D2
            3: zona := 2;     //Int. Europa
            4: zona := 3;     //Int. Resto
            end;
           ParamByName('zona').asinteger := zona;

           ParamByName('empresa').AsString := edEmpresa.Text;
           ParamByName('direccion').AsString := edDireccion.Text;
           ParamByName('localidad').AsString := cbCP.Text;
           ParamByName('provincia').AsString := edProvincia.Text;
           ParamByName('cp').AsString := edCP.Text;
           ParamByName('pais').AsString := edPais.Text;
           ParamByName('referencia').AsString := edReferencia.Text;
           ParamByName('cto_rmt').AsString := edCtoRmt.Text;
           ParamByName('peso').AsInteger := StrToInt(rgPeso.Items[rgPeso.ItemIndex]);
           ParamByName('alto').AsFloat := edAlto.Value;
           ParamByName('ancho').AsFloat := edAncho.Value;
           ParamByName('largo').AsFloat := edLargo.Value;
           ParamByName('idx_sobre').asinteger := rgSobre.ItemIndex;
           if (modo=2) then
              if ((edCliente.Text='3203') or (edCliente.Text='3200')) then
                ParamByName('barcode').AsString := 'CD' + CalculaBarcode
              else
                ParamByName('barcode').AsString := '';

           case StrToInt(edCliente.Text) of
              3203, 3200: ParamByName('tipo').AsString := 'C';
              else ParamByName('tipo').AsString := 'P';
           end;

           if modo<>2 then
           begin
              ParamByName('id_correos_certificadas').AsInteger := edIdCert.Value;
              ParamByName('fecha').asdatetime := Now;
              ParamByName('usuario').AsInteger := u_globals.id_usuario;
           end;
           execquery;

           if modo<>2 then
                id_actual := edIdCert.Value
           else
                id_actual := FieldByName('id_correos_certificadas').AsInteger;

          dm.t_write.CommitRetaining;

         { if modo=1 then   //editando
          begin      }
              //HabilitaDatos(false);
              filter;
              filter_certificadas;
              filter_estados;
              dm.qfiltro_certif.Locate('id_correos_certificadas',id_actual,[]);
              RellenaCertificada;
         { end
          else if modo=2 then begin   //insertando, borramos para seguir con otro CECO

              //Si ya existe franqueo en la bbdd con estos criterios se modificará, sino, se insertará un nuevo registro
              AddFranqueo(StrToInt(edCliente.Text),
                          StrToInt(edIdCeco.Text),
                          StrToInt(edPeso.Text),
                          producto,
                          zona,
                          1,0,
                          edFecha.Date);

              lbFrEnc.Caption := 'Encontrado ' +  IntToStr(BuscaFranqueo(edCliente.Value,edIdCeco.Value,StrToInt(rgPeso.Items[rgPeso.ItemIndex]),
                                                   producto, zona, edFecha.Date)) + ' franqueos.';

              VaciaCertificada;
              dm.qfiltro_certif.Close;
              dm.qfiltro_certif.Open;

              edEmpresa.SetFocus;
          end;     }
          modo := 0;
          lbModo.Caption := '';
          ShowMessage('Datos guardados correctamente.');
          HabilitaDatos(false);
        except
           dm.t_write.RollbackRetaining;
           ShowMessage('Error al guardar datos.');
        end;
      end;
 // end;
end;

procedure Tf_main.btGuardarClick(Sender: TObject);
var
  x, y, total, uds, producto, zona, id: integer;
  total_cl: Double;
begin
    if edIdCeco.Value<=0 then
    raise Exception.Create('CECO Inválido');

    with dm.q_1 do
    begin
      try
         dm.t_write.StartTransaction;

         SQL.Clear;

        total := 0;

        case rgProducto.ItemIndex of
                      0: producto := 239;   //Carta Ordinaria
                      1: producto := 240;   //Carta Certificada
                      2: producto := 325;   //Carta Certificada con AR
        end;

        for x := 1 to grData.RowCount-1 do
          for y := 1 to grData.ColCount-1 do
          begin
               case x of
                    1: zona := 1;     //Nacional
                    2: zona := 4;     //Nacional D1
                    3: zona := 5;     //Nacional D2
                    4: zona := 2;     //Int. Europa
                    5: zona := 3;     //Int. Resto
               end;

               id := ExisteFranqueo(StrToInt(edIdCliente.Text),edIdCeco.Value,StrToInt(grData.Cells[y,0]),producto,zona,edFecha.Date,uds);
               sql.Clear;
               if id>0 then
                    sql.add('update m_correos_reports set uds=:uds ' +
                   'where id_correos_report=:id')
               else
                    sql.add('insert into m_correos_reports (id_cliente, fecha, id_ceco, id_producto, id_zona, peso, uds) values ' +
                   '(:cliente, :fecha, :ceco, :producto, :zona, :peso, :uds)');

               if ((grData.Cells[y,x]<>'')  or ((grData.Cells[y,x]='') and (id>0))) then
               begin
                   Close;

                   if id>0 then
                       ParamByName('id').asinteger := id
                   else begin
                       ParamByName('cliente').asinteger := StrToInt(edIdCliente.Text);
                       ParamByName('fecha').AsDateTime := edFecha.Date;
                       ParamByName('ceco').asinteger := edIdCeco.Value;
                       ParamByName('producto').asinteger := producto;
                       ParamByName('zona').asinteger := zona;
                       ParamByName('peso').asinteger := StrToInt(grData.Cells[y,0]);
                   end;

                   if grData.Cells[y,x]='' then
                       ParamByName('uds').asinteger := 0
                   else
                       ParamByName('uds').asinteger := StrToInt(grData.Cells[y,x]);
                   execquery;

                   if grData.Cells[y,x]<>'' then
                      total := total + StrToInt(grData.Cells[y,x]);
               end;
          end;

        dm.t_write.CommitRetaining;
        ShowMessage('Datos guardados correctamente.');

      {  if modo=1 then   //editando
        begin
            lbTotal.Caption := IntToStr(total);
            //HabilitaDatos(false);
            filter;
        end
        else if modo=2 then begin   //insertando, borramos para seguir con otro CECO
                  for x := 1 to grData.RowCount-1 do
                  for y := 1 to grData.ColCount-1 do
                  begin
                      grData.Cells[y,x] := '';
                  end;

                  edCeco.text:='';
                  lbCeco.caption:='(Seleccione un CECO válido)';
                  edIdCeco.Text := '';
                  filter;     }
                  edCeco.SetFocus;

                  //bpCeco.Click;
                  uds := 0;
                  total_cl := GetTotalCliente(StrToInt(edIdCliente.Text),uds);
                  lbTClienteUds.Caption := IntToStr(uds);
                  lbTClienteImp.Caption := formatfloat('#,##0.00', total_cl);
                  total_cl := GetTotalClientePeso(StrToInt(edIdCliente.Text),20,uds);
                  lbT20Uds.Caption := IntToStr(uds);
                  lbT20Imp.Caption := formatfloat('#,##0.00', total_cl);
                  total_cl := GetTotalClientePeso(StrToInt(edIdCliente.Text),50,uds);
                  lbT50Uds.Caption := IntToStr(uds);
                  lbT50Imp.Caption := formatfloat('#,##0.00', total_cl);
                  total_cl := GetTotalClientePeso(StrToInt(edIdCliente.Text),100,uds);
                  lbT100Uds.Caption := IntToStr(uds);
                  lbT100Imp.Caption := formatfloat('#,##0.00', total_cl);
                  total_cl := GetTotalClientePeso(StrToInt(edIdCliente.Text),500,uds);
                  lbT500Uds.Caption := IntToStr(uds);
                  lbT500Imp.Caption := formatfloat('#,##0.00', total_cl);
                  total_cl := GetTotalClientePeso(StrToInt(edIdCliente.Text),1000,uds);
                  lbT1000Uds.Caption := IntToStr(uds);
                  lbT1000Imp.Caption := formatfloat('#,##0.00', total_cl);
                  total_cl := GetTotalClientePeso(StrToInt(edIdCliente.Text),2000,uds);
                  lbT2000Uds.Caption := IntToStr(uds);
                  lbT2000Imp.Caption := formatfloat('#,##0.00', total_cl);
       // end;

      except
         dm.t_write.RollbackRetaining;
         ShowMessage('Error al guardar datos.');
      end;
    end;
end;


procedure Tf_main.btImportVendClick(Sender: TObject);
var
  fin: Boolean;
  r, id_articulo, l_total, l_upd, i: Integer;
  log: TStringList;
  dialog: TForm;
  msg_error, file_name: string;
begin
  if FileExists(edFile.filename) then
  begin
    if IndexStr(extractfileExt(edFile.FileName),['.xls','.xlsx'])>0 then
    begin
      l_total := 0;
      l_upd := 0;

      log := TStringList.Create;

      dm.t_write.StartTransaction;
      try

        AbreFichero(edFile.FileName);
        Hoja := excel.Worksheets.Item[1];

        fin := False;
        r := 1; //Empezamos desde la fila 1, no hay cabeceras

        while not (Trim(hoja.cells[r, 1]) = '') do
        begin

          id_articulo := busca_art(Trim(hoja.cells[r, 1]),main_cli);

          if id_articulo>=0 then
          begin
            If UpdateStockArt(id_articulo,0)>=0 then
                  Inc(l_upd)
            else
                log.Add('No actualizado ' + Trim(hoja.cells[r, 1]));
          end else
                log.Add('No encontrado ' + Trim(hoja.cells[r, 1]));

          Inc(l_total);

          Inc(r);
        end;

        dm.t_write.Commit;
      except
        on e: Exception do
        begin
          sMessageDlg('Error Actualizando Stock ' + e.message, mtError, [mbok], 0);
          dm.t_write.Rollback;

          Excel.Quit;
          Excel := Unassigned;

          exit;
        end;
      end;

      //excel.activeworkbook.save;
      Excel.Quit;
      Excel := Unassigned;

      lbProgreso.Caption := 'Actualizado ' + IntToStr(l_upd) + ' de ' + IntToStr(l_total) + '. Proceso finalizado.';

     sMessageDlg('Actualizado ' + IntToStr(l_upd) + ' de ' + IntToStr(l_total) + '. Proceso finalizado.', mtInformation, [mbok], 0);
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
            mrYes:
              begin
                InsertaLog(100,0,0,'','',log_app,'','','UpdVendidosHaya.ErroresPantalla',msg_error);
                sShowMessage('Log Vendidos', msg_error);
              end;

            mrNo: begin
              file_name := ExtractFileDir(edFile.FileName) + '\LOG_VENDIDOS_' + formatdatetime('dd_mm_yyyy__hh_nn', Now) + '.txt';
              log.SaveToFile(file_name);
              InsertaLog(100,0,0,'','',log_app,'','','UpdVendidosHaya.ErroresFichero',file_name + '|' + msg_error);
            end;

            mrCancel: begin
              InsertaLog(100,0,0,'','',log_app,'','','UpdVendidosHaya.ErroresCancel',msg_error);
              Dialog.Close;
            end;
          end;
        finally
          Dialog.Free;
        end;
      end;

      log.Free;
    end else
          ShowMessage('El fichero debe ser xls o xlsx.');
  end
  else
    ShowMessage('Debe insertar un fichero válido.');
end;

procedure Tf_main.edCecoExit(Sender: TObject);
begin
  If (edCeco.Text<>'') and (StrToIntDef(edCeco.Text,0)>0) then
     begin
        lbCeco.Caption := CargarDatosTablaGestoras('cli_cecos','titulo','ceco='+ QuotedStr(edCeco.Text));
        rgCeco.Items.Strings[1] := lbCeco.Caption;
        edIdCeco.Value := BuscaCecoId(edCeco.Text);
       { if modo=0 then
        begin
          filter;
          filter_certificadas;
          if not chEstCCTodos.Checked then
            filter_estados;
        end;     }
     end;

     if lbCeco.Caption='' then
     begin
         lbCeco.Caption := '(Seleccione un CECO válido)';
         rgCeco.Items.Strings[1] := 'CECO por seleccionar';
     end;
end;

procedure Tf_main.edClienteChange(Sender: TObject);
var
  datos: TStringList;
begin
   If (edCliente.Text<>'') and (StrToIntDef(edCliente.Text,0)>0) then
    CargaInterfaz;
end;

procedure Tf_main.edClienteExit(Sender: TObject);
var
  datos: TStringList;
begin

end;

procedure Tf_main.edCPExit(Sender: TObject);
begin
  RellenaComboCP(edCP.Text);
  edProvincia.Text := lbAuxprov.Caption;

end;

procedure Tf_main.edCPKeyPress(Sender: TObject; var Key: Char);
begin
  if (((Key=Char(13)) OR (Key=Char(9))) and (edCP.Text<>'')) then
  begin
    with fbuscapro_ss do begin
      limpia_fields;     multiselect:=false;    livekey:=false;
      titulos.commatext:='C.Postal, Localidad, Provincia';
      fields.commatext:='l.codigo_postal,l.titulo,p.titulo ';
      from:='sys_localidades l inner join sys_provincias p on p.provincia=l.provincia and p.pais=l.pais ';
      where:='l.codigo_postal='+ QuotedStr(edCp.Text);
      orden[1]:=1;  busca:=2;   distinct:=0;   fillimpio:=True;   row_height:=17;

      showmodal;

      if resultado then begin
          edCP.Text:=valor[1];
          edLocalidad.Text:=valor[2];
          edProvincia.Text := valor[3];
        end;
    end;
  end;
end;

procedure Tf_main.edEstFDesdeChange(Sender: TObject);
begin
 filter_estados;
end;

procedure Tf_main.edEstFHastaChange(Sender: TObject);
begin
  filter_estados;
end;

procedure Tf_main.edFechaChange(Sender: TObject);
var
  fecha_ok: Boolean;
begin
   Try
    if edFecha.Text<>'  /  /    ' then
    begin
      StrToDate(edFecha.Text);
      fecha_ok := True;
    end else
          fecha_ok := False;
   except
     fecha_ok := false;
   end;

  if (modo=0) and fecha_ok then
  begin
    filter;
    filter_certificadas;
    if not chEstFTodas.Checked then
        filter_estados;
  end;
end;


procedure Tf_main.edFechaClick(Sender: TObject);
begin
  if modo=0 then
  begin
    filter;
    filter_certificadas;
    if not chEstFTodas.Checked then
        filter_estados;
  end;
end;

procedure Tf_main.edFiltroEstadoChange(Sender: TObject);
begin
  filter_estados;
end;

procedure Tf_main.edFiltroTextoChange(Sender: TObject);
begin
 { if modo=0 then
  begin
    filter_certificadas;
    filter_estados;
  end;      }
end;

procedure Tf_main.btLockClick(Sender: TObject);
begin
  //locked := not locked;

 { if locked then
  begin
    lbCliente.Font.Color := 16;
    //CargaInterfaz;

    //filter;
  end
  else begin
        lbCliente.Font.Color := 255;
        //edCliente.SetFocus;
        //dm.q_peds.Close;
       end;   }

  CargaInterfaz;
end;

procedure Tf_main.btLimpiarClick(Sender: TObject);
var
  x, y: integer;
begin
  lbtotal.Caption := '';

  for x := 1 to grData.RowCount-1 do
    for y := 1 to grData.ColCount-1 do
    begin
        grData.Cells[y,x] := '';
    end;

    grData.Cells[1,1];

end;

procedure Tf_main.rgClienteChange(Sender: TObject);
var
  id_ceco_act, fila, col, fila_tit, prod_act, uds_total, fila_prod: integer;
begin
  id_ceco_act := -1;
  prod_act := -1;
  fila := 0;
  fila_tit := 0;
  fila_prod := 0;

  with dm.qReportResumen do
  try
    Close;
    case rgCliente.ItemIndex of
      0: begin
          ParamByName('cliente').AsInteger:=StrToInt(edIdCliente.Text);
          ParamByName('todo_cl').AsInteger:=1;
      end;
      1: begin
          ParamByName('cliente').AsInteger:=StrToInt(edIdCliente.Text);
          ParamByName('todo_cl').AsInteger:=0;
      end;
    end;

    case rgCECO.ItemIndex of
      0: begin
          ParamByName('ceco').AsInteger:=edIdCeco.Value;
          ParamByName('todo_cc').AsInteger:=1;
      end;
      1: begin
          ParamByName('ceco').AsInteger:=edIdCeco.Value;
          ParamByName('todo_cc').AsInteger:=0;
      end;
    end;

    ParamByName('f1').AsDate:=edFDesde.Date;
    ParamByName('f2').AsDate:=edFHasta.Date;

    Open;

    if not IsEmpty then
    begin
        First;

        AbreFichero(edXls.Text + '\resumen' + FormatDateTime('yyyymmddhhnnss',Now) + '.xlsx');

        Hoja := excel.Worksheets.Item[1];

        //xls.Filename := edXls.Text + '\resumen' + FormatDateTime('yyyymmddhhnnss',Now) + '.xlsx';

        while not Eof do
        begin

          if FieldByName('id_ceco').AsInteger<>id_ceco_act then
          begin
              id_ceco_act := FieldByName('id_ceco').AsInteger;
              hoja.cells[fila,1] := BuscaClientePorId(FieldByName('id_cliente').AsInteger) + ' - ' + BuscaCecoPorId(FieldByName('id_ceco').AsInteger);
              Inc(fila);

              if FieldByName('id_producto').AsInteger<>prod_act then
              begin
                prod_act := FieldByName('id_producto').AsInteger;
                case prod_act of
                  239: hoja.cells[fila,1] := 'CARTAS ORDINARIAS';
                  240: hoja.cells[fila,1] := 'CARTAS CERTIFICADAS';
                  325: hoja.cells[fila,1] := 'CARTAS CERTIFICADAS CON A.R.';
                end;
                Inc(fila);
              end;

              fila_tit := RellenaCabecerasDetalle(fila);
              Inc(fila);
          end;

          if FieldByName('id_producto').AsInteger<>prod_act then
          begin
            prod_act := FieldByName('id_producto').AsInteger;
            case prod_act of
              239: hoja.cells[fila,1] := 'CARTAS ORDINARIAS';
              240: hoja.cells[fila,1] := 'CARTAS CERTIFICADAS';
              325: hoja.cells[fila,1] := 'CARTAS CERTIFICADAS CON A.R.';
            end;
            Inc(fila);
          end;

          //fila := fila + 2;

          uds_total := 0;
          for col := 1 to 33 do
          begin
             case col of
                0: hoja.cells[fila, col] := FieldByName('fecha').AsString;
                1..6: begin
                          hoja.cells[fila, col] := BuscaFranqueo(FieldByName('id_cliente').AsInteger,FieldByName('id_ceco').AsInteger,
                                                               hoja.cells[fila_tit, col],prod_act,
                                                               1,FieldByName('fecha').AsDateTime);
                          uds_total := uds_total + hoja.cells[fila, col];
                      end;
                7..12: begin
                          hoja.cells[fila, col] := BuscaFranqueo(FieldByName('id_cliente').AsInteger,FieldByName('id_ceco').AsInteger,
                                                               hoja.cells[fila_tit, col],prod_act,
                                                               4,FieldByName('fecha').AsDateTime);
                          uds_total := uds_total + hoja.cells[fila, col];
                       end;
                13..18: begin
                          hoja.cells[fila, col] := BuscaFranqueo(FieldByName('id_cliente').AsInteger,FieldByName('id_ceco').AsInteger,
                                                               hoja.cells[fila_tit, col],prod_act,
                                                               5,FieldByName('fecha').AsDateTime);
                          uds_total := uds_total + hoja.cells[fila, col];
                        end;
                21: hoja.cells[fila, col] := uds_total;
                22: hoja.cells[fila, col] := 0;
             end;
          end;
          Inc(fila);
          Next;
        end;
    end;

    //xls.Write;
    excel.activeworkbook.save;
    Excel.Quit ;
    Excel := Unassigned;
  finally

  end;

end;

procedure Tf_main.rgEstOrdenChange(Sender: TObject);
begin
    filter_estados;
end;

procedure Tf_main.rgPesoClick(Sender: TObject);
begin
  edPeso.Value := StrToFloat(rgPeso.Items[rgPeso.ItemIndex]);
  if modo=0 then
     filter_certificadas;
end;

procedure Tf_main.rgProdCertClick(Sender: TObject);
var
    producto, zona:Integer;
begin
  lbFrEnc.Caption := 'Encontrado ' +  IntToStr(BuscaFranqueo(StrToInt(edCliente.Text),edIdCeco.Value,StrToInt(rgPeso.Items[rgPeso.ItemIndex]),
                                                   producto, zona, edFecha.Date)) + ' franqueos.';
  if modo=0 then
     filter_certificadas;
end;

procedure Tf_main.rgProductoChange(Sender: TObject);
begin
  btLimpiar.Enabled := (rgProducto.ItemIndex=0);
  btGuardar.Enabled := (rgProducto.ItemIndex=0);
  btCancel.Enabled :=  (rgProducto.ItemIndex=0);
  filter;
end;

procedure Tf_main.rgSobreChange(Sender: TObject);
begin
  GetMedidasSobre;
end;

procedure Tf_main.rgTipoClick(Sender: TObject);
begin
  btReport.Enabled := not (rgTipo.ItemIndex=4);

end;

procedure Tf_main.rgZonaChange(Sender: TObject);
begin
  if modo=0 then
     filter_certificadas;
end;

procedure Tf_main.rgZonaClick(Sender: TObject);
begin
  if modo=0 then
     filter_certificadas;
end;

procedure Tf_main.carga_maestros;
var
  i, cont: Integer;
  clientes_aux, cecos_aux, cli, cc: TStringList;
begin
   with tpfibdataset.Create(dm) do begin
    try
      database:=dm.db_gestoras;

      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select count(*) as cantidad from clientes where baja=0 and id_cliente in (' + grupo_santalucia + ',' + grupo_gih + ')');
      Open;

      cont := FieldByName('cantidad').AsInteger;

      Close;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select id_cliente,cliente,nombre_r_social ' +
                         ' from clientes where baja=0 and id_cliente in (' + grupo_santalucia + ',' + grupo_gih + ')');
      Open;

      if not(IsEmpty) then
      begin
       First;
       i := 0;

       SetLength(clientes,cont);
       while not eof do
       begin
          clientes[i].id := FieldByName('id_cliente').AsInteger;
          clientes[i].id2 := -1;
          clientes[i].codigo := FieldByName('cliente').AsString;
          clientes[i].nombre := FieldByName('nombre_r_social').AsString;

          Next;
          Inc(i);
       end;
      end;

      Close;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select count(*) as cantidad ' +
                         ' from cli_cecos where id_cliente in (' + grupo_santalucia + ',' + grupo_gih + ')');
      Open;

      cont := FieldByName('cantidad').AsInteger;

      Close;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select * ' +
                         ' from cli_cecos where id_cliente in (' + grupo_santalucia + ',' + grupo_gih + ')');
      Open;

      if not(IsEmpty) then
      begin
       First;
       i := 0;

       SetLength(cecos,cont);
       while not eof do
       begin
          cecos[i].id := FieldByName('id_cli_ceo').AsInteger;
          cecos[i].id2 := FieldByName('id_cliente').AsInteger;
          cecos[i].codigo := FieldByName('ceco').AsString;
          cecos[i].nombre := FieldByName('titulo').AsString;

          Next;
          Inc(i);
       end;
      end;


    finally
        free;
    end;
   end;

end;



procedure Tf_main.LoadConfigCliente(cli: integer);
var
  f_type, order_ok, datos_ag: string;
  i: integer;
  stream: TStream;
  str_agencia: TStringDynArray;
  item_list, par: TStringList;
  item_name, item_value, items: string;
begin

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
       items := FieldByName('items').AsString;
    end;

  finally
    free;
  end;

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

      if UpperCase(par[0]) = 'BON_FRANQ_LOC' then
        bon_franq_loc := StrToInt(par[1]);
      if UpperCase(par[0]) = 'BON_FRANQ_D1' then
        bon_franq_d1 := StrToInt(par[1]);
      if UpperCase(par[0]) = 'BON_FRANQ_D2' then
        bon_franq_d2 := StrToInt(par[1]);
      if UpperCase(par[0]) = 'BON_FRANQ_INT_EUR' then
        bon_franq_int_eur := StrToInt(par[1]);
      if UpperCase(par[0]) = 'BON_FRANQ_INT_RESTO' then
        bon_franq_int_resto := StrToInt(par[1]);
    end;
  end;

end;

{$ENDREGION 'INTERFAZ'}

{$REGION 'FRANQUEO'}

function CountFranqueo(cli,cc,prod,peso:integer):Integer;
begin

end;

procedure Tf_main.AddFranqueo(cliente, ceco, peso, producto, zona, cantidad, suma:integer; fecha:TDateTime);
var
  id_franqueo, existen:integer;
begin
  try
    id_franqueo := -1;
    existen := 0;
    id_franqueo := ExisteFranqueo(cliente,ceco, peso, producto, zona,fecha, existen);

    with dm.q_1 do
    begin
       dm.t_write.StartTransaction;

       SQL.Clear;
       Close;

       if id_franqueo=-1 then
       begin
         sql.add('insert into m_correos_reports (id_cliente, fecha, id_ceco, id_producto, id_zona, peso, uds) values ' +
                 '(:cliente, :fecha, :ceco, :producto, :zona, :peso, :uds)');
         ParamByName('cliente').asinteger := StrToInt(edIdCliente.Text);
         ParamByName('fecha').AsDateTime := edFecha.Date;
         ParamByName('ceco').asinteger := edIdCeco.Value;
         ParamByName('producto').asinteger := producto;
         ParamByName('zona').asinteger := zona;
         ParamByName('peso').asinteger := peso;
         ParamByName('uds').asinteger := cantidad;
       end
       else begin
         sql.add('update m_correos_reports set uds=:uds ' +
                 'where id_correos_report=:id');
         ParamByName('id').asinteger := id_franqueo;
         if suma=0 then
              ParamByName('uds').asinteger := cantidad
         else
              ParamByName('uds').asinteger := existen + cantidad;
       end;

       execquery;

      dm.t_write.CommitRetaining;
      //ShowMessage('Datos guardados correctamente.');

    end;

  except
     dm.t_write.RollbackRetaining;
     //ShowMessage('Error al guardar datos.');
  end;
end;


function Tf_main.ExisteFranqueo(cliente, ceco, peso, producto, zona:integer; fecha:TDateTime; out uds:Integer):Integer;
begin
   with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select id_correos_report, uds from m_correos_reports ' +
                       'where id_cliente=:cliente and peso=:peso and id_producto=:producto and ' +
                             'id_ceco=:ceco and fecha=:fecha and id_zona=:zona and estado=''A''');
    ParamByName('cliente').AsInteger := cliente;
    ParamByName('ceco').AsInteger := ceco;
    ParamByName('fecha').AsDateTime := fecha;
    ParamByName('peso').AsInteger := peso;
    ParamByName('producto').AsInteger := producto;
    ParamByName('zona').AsInteger := zona;
    Open;

    if not(IsEmpty) then
    begin
      uds := FieldByName('uds').AsInteger;
      Result :=FieldByName('id_correos_report').AsInteger;
    end
    else result:=-1;

    Free;
  end;
end;

{$ENDREGION 'FRANQUEO'}

{$REGION 'INFORMES'}

function Tf_main.CreaTXT:string;
var
  nom: string;
begin
   if edTXT.Text='' then
   begin
          MessageDlg('Debe introducir un directorio destino.', mtInformation, [mbOK],0);
          Exit;
   end;

   if not DirectoryExists(edTXT.text) then
   begin
          MessageDlg('No existe el directorio destino.', mtInformation, [mbOK],0);
          Exit;
   end;

   nom := edTXT.Text+ '\paqueteria_' + FormatDateTime('yyyymmdd',edFecha.Date) + '.txt';

   AssignFile(txt,nom);
   Rewrite(txt);

   result := nom;
end;

procedure Tf_main.btReportClick(Sender: TObject);
begin
    case rgTipo.ItemIndex of
       0: ReportBonificacion;
       1: ReportResumen;
       2,3: ReportDetalle;
    end;
end;

procedure Tf_main.ReportResumen;
var
  ceco_act, fila, col, fila_tit, zona_act, uds_total, fila_prod, cli_actual, uds_total_fila, uds_total_20, uds_total_50, uds_total_100, uds_total_500, uds_total_1000, uds_total_2000: integer;
  imp_total_fila, imp_total: Double;
begin
  if ((rgCliente.ItemIndex=1) and not (StrToInt(edCliente.Text)>0)) then
       raise Exception.Create('Debe seleccionar un cliente o cambiar filtro.');

  ceco_act := -1;
  zona_act := -1;
  cli_actual := -1;
  fila := 0;
  fila_tit := 0;
  fila_prod := 0;

  uds_total_fila := 0;
  uds_total_20 := 0;
  uds_total_50 := 0;
  uds_total_100 := 0;
  uds_total_500 := 0;
  uds_total_1000 := 0;
  uds_total_2000 := 0;

  imp_total_fila := 0;
  imp_total := 0;

  with dm.qReportResumen do
  try
    Close;
    SelectSQL.Clear;

    SelectSQL.Add('SELECT id_cliente,id_ceco, peso, sum(uds) as uds, sum(uds*tarifa) as subtotal ' +
                  'FROM mv_correos_reports r WHERE ');

    case rgCliente.ItemIndex of
      0: SelectSQL.Add('');
      1: SelectSQL.Add(' r.id_cliente=' + edIdCliente.Text + ' and ');
      2: SelectSQL.Add(' r.id_cliente in (' +  grupo_gih + ') and ');
    end;

    SelectSQL.Add(' ((r.id_ceco=:ceco) or (:todo_cc=1)) and ' +
                  ' r.fecha between :f1 and :f2 ' +
                  ' group by id_cliente, id_ceco, peso ' +
                  ' order by id_cliente, id_ceco');

    case rgCECO.ItemIndex of
      0: begin
          ParamByName('ceco').AsInteger:=edIdCeco.Value;
          ParamByName('todo_cc').AsInteger:=1;
      end;
      1: begin
          ParamByName('ceco').AsInteger:=edIdCeco.Value;
          ParamByName('todo_cc').AsInteger:=0;
      end;
    end;

    ParamByName('f1').AsDate:=edFDesde.Date;
    ParamByName('f2').AsDate:=edFHasta.Date;

    Open;
    ar_resumen.EmptyDataSet;

    if not IsEmpty then
    begin
        First;

        while not Eof do
        begin
          uds_total := 0;
          imp_total := 0;

          if ar_resumen.Locate('id_cliente;ceco',VarArrayOf([FieldByName('id_cliente').AsString,CargarDatosTablaGestoras('cli_cecos','titulo','id_cli_ceo='+FieldByName('id_ceco').AsString)]),[]) then
          begin
              ar_resumen.Edit;

              case FieldByName('peso').AsInteger of
                 20: begin
                      ar_resumen.FieldByName('uds_20').AsInteger := ar_resumen.FieldByName('uds_20').AsInteger + FieldByName('uds').AsInteger;
                      ar_resumen.FieldByName('imp_20').AsFloat := ar_resumen.FieldByName('imp_20').AsFloat + FieldByName('subtotal').AsFloat;
                     end;
                 50: begin
                      ar_resumen.FieldByName('uds_50').AsInteger := ar_resumen.FieldByName('uds_50').AsInteger +  FieldByName('uds').AsInteger;
                      ar_resumen.FieldByName('imp_20').AsFloat := ar_resumen.FieldByName('imp_50').AsFloat + FieldByName('subtotal').AsFloat;
                     end;
                 100: begin
                      ar_resumen.FieldByName('uds_100').AsInteger := ar_resumen.FieldByName('uds_100').AsInteger +  FieldByName('uds').AsInteger;
                      ar_resumen.FieldByName('imp_100').AsFloat := ar_resumen.FieldByName('imp_100').AsFloat + FieldByName('subtotal').AsFloat;
                     end;
                 500: begin
                      ar_resumen.FieldByName('uds_500').AsInteger :=  ar_resumen.FieldByName('uds_500').AsInteger + FieldByName('uds').AsInteger;
                      ar_resumen.FieldByName('imp_500').AsFloat := ar_resumen.FieldByName('imp_500').AsFloat + FieldByName('subtotal').AsFloat;
                     end;
                 1000: begin
                      ar_resumen.FieldByName('uds_1000').AsInteger := ar_resumen.FieldByName('uds_1000').AsInteger +  FieldByName('uds').AsInteger;
                      ar_resumen.FieldByName('imp_1000').AsFloat := ar_resumen.FieldByName('imp_1000').AsFloat + FieldByName('subtotal').AsFloat;
                     end;
                 2000: begin
                      ar_resumen.FieldByName('uds_2000').AsInteger := ar_resumen.FieldByName('uds_2000').AsInteger +  FieldByName('uds').AsInteger;
                      ar_resumen.FieldByName('imp_2000').AsFloat := ar_resumen.FieldByName('imp_2000').AsFloat +  FieldByName('subtotal').AsFloat;
                     end;
              end;

          end else
          begin
              ar_resumen.Insert;
              ar_resumen.FieldByName('id_cliente').AsInteger := FieldByName('id_cliente').AsInteger;
              ar_resumen.FieldByName('nombre').AsString := CargarDatosTablaGestoras('clientes','nombre_r_social','id_cliente='+FieldByName('id_cliente').AsString);
              ar_resumen.FieldByName('ceco').AsString := CargarDatosTablaGestoras('cli_cecos','titulo','id_cli_ceo='+FieldByName('id_ceco').AsString);
              ar_resumen.FieldByName('fecha_desde').AsString := FormatDateTime('dd/mm/yyyy', edFDesde.Date);
              ar_resumen.FieldByName('fecha_hasta').AsString := FormatDateTime('dd/mm/yyyy', edFHasta.Date);

              case FieldByName('peso').AsInteger of
                 20: begin
                      ar_resumen.FieldByName('uds_20').AsInteger := FieldByName('uds').AsInteger;
                      ar_resumen.FieldByName('imp_20').AsFloat := FieldByName('subtotal').AsFloat;
                     end;
                 50: begin
                      ar_resumen.FieldByName('uds_50').AsInteger := FieldByName('uds').AsInteger;
                      ar_resumen.FieldByName('imp_20').AsFloat := FieldByName('subtotal').AsFloat;
                     end;
                 100: begin
                      ar_resumen.FieldByName('uds_100').AsInteger := FieldByName('uds').AsInteger;
                      ar_resumen.FieldByName('imp_100').AsFloat := FieldByName('subtotal').AsFloat;
                     end;
                 500: begin
                      ar_resumen.FieldByName('uds_500').AsInteger := FieldByName('uds').AsInteger;
                      ar_resumen.FieldByName('imp_500').AsFloat := FieldByName('subtotal').AsFloat;
                     end;
                 1000: begin
                      ar_resumen.FieldByName('uds_1000').AsInteger := FieldByName('uds').AsInteger;
                      ar_resumen.FieldByName('imp_1000').AsFloat := FieldByName('subtotal').AsFloat;
                     end;
                 2000: begin
                      ar_resumen.FieldByName('uds_2000').AsInteger := FieldByName('uds').AsInteger;
                      ar_resumen.FieldByName('imp_2000').AsFloat := FieldByName('subtotal').AsFloat;
                     end;
              end;


          end;

          ar_resumen.Post;
          Next;
        end;

        if repResumen.PrepareReport then repResumen.ShowPreparedReport;
    end else
          raise Exception.Create('No existen datos a mostrar.');

  except
     ShowMessage('Error Generando Documento.');
  end;

end;


procedure Tf_main.btTodosClick(Sender: TObject);
var
  x, y, total, uds: Integer;
  total_cl: Double;
begin
      If btTodos.Caption = 'Filtrar' then
      begin
          rgProducto.Enabled :=  True;
          filter;
          btTodos.Caption := 'Todo';
      end
      else begin
              uds := 0;
              total_cl := GetTotalCliente(StrToInt(edIdCliente.Text),uds);
              lbTClienteUds.Caption := IntToStr(uds);
              lbTClienteImp.Caption := formatfloat('#,##0.00', total_cl);
              total_cl := GetTotalClientePeso(StrToInt(edIdCliente.Text),20,uds);
              lbT20Uds.Caption := IntToStr(uds);
              lbT20Imp.Caption := formatfloat('#,##0.00', total_cl);
              total_cl := GetTotalClientePeso(StrToInt(edIdCliente.Text),50,uds);
              lbT50Uds.Caption := IntToStr(uds);
              lbT50Imp.Caption := formatfloat('#,##0.00', total_cl);
              total_cl := GetTotalClientePeso(StrToInt(edIdCliente.Text),100,uds);
              lbT100Uds.Caption := IntToStr(uds);
              lbT100Imp.Caption := formatfloat('#,##0.00', total_cl);
              total_cl := GetTotalClientePeso(StrToInt(edIdCliente.Text),500,uds);
              lbT500Uds.Caption := IntToStr(uds);
              lbT500Imp.Caption := formatfloat('#,##0.00', total_cl);
              total_cl := GetTotalClientePeso(StrToInt(edIdCliente.Text),1000,uds);
              lbT1000Uds.Caption := IntToStr(uds);
              lbT1000Imp.Caption := formatfloat('#,##0.00', total_cl);
              total_cl := GetTotalClientePeso(StrToInt(edIdCliente.Text),2000,uds);
              lbT2000Uds.Caption := IntToStr(uds);
              lbT2000Imp.Caption := formatfloat('#,##0.00', total_cl);

              btTodos.Caption := 'Filtrar';
              rgProducto.Enabled :=  False;
      end;

end;


procedure Tf_main.btTXTClick(Sender: TObject);
const
  tab = Char(9);

var
  n_linea: integer;
  linea, posicion, ids, nom_file: string;
begin
  if ((not chTodosCl.Checked) and ( not (StrtoInt(edCliente.Text)>0))) then
      raise Exception.Create('Debe indicar un cliente o seleccionar todos.');

  if ((not chTodosCC.Checked) and ( not (edIdCeco.Value>0))) then
      raise Exception.Create('Debe indicar un CECO o seleccionar todos.');

  if edTXT.Text='' then
       raise Exception.Create('Debe indicar una carpeta destino.');

  if not DirectoryExists(edTXT.Text) then
       raise Exception.Create('La carpeta indicada no existe.');

  try
    with dm.qfile do
    begin
      Close;
      SelectSQL.Clear;
      SelectSQL.Add('select * from mv_correos_certificadas where fecha=:fecha ' +
                    ' and id_cliente in (' + grupo_gih + ')');   //Solo GIH (3205 a 3211)

      if not chTodosCl.checked then
           SelectSQL.Add(' and id_cliente=' + edIdCliente.Text);
      if not chTodosCC.Checked then
           SelectSQL.Add(' and id_ceco=' + edIdCeco.Text);

      ParamByName('fecha').AsDate := edFecha.Date;
      Open;

      If not IsEmpty then
      begin

        nom_file := CreaTXT;

        n_linea := 1;
        linea := '';
        ids := '';

        Last;
        First;

        while not eof do
        begin
            if RecordCount=1 then
                posicion := 'U'
            else if RecNo=1 then
                     posicion := 'C'
                  else if RecNo=RecordCount then
                          posicion := 'F'
                        else
                            posicion := 'R';

           linea := posicion + tab +                                             //1
                     FieldByName('version').AsString + tab +                     //2
                     FieldByName('producto_paq').AsString + tab +                //3
                     tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + //4-13
                     FieldByName('bultos').AsString + tab +                      //14
                     '1' + tab +                                                 //15
                     tab + tab + tab + tab + tab + tab + tab +                   //16-22
                     FieldByName('empresa').AsString + tab +                     //23
                     tab + tab +                                                 //24-25
                     FieldByName('direccion').AsString + tab +                   //26
                     tab + tab + tab + tab + tab + tab + tab +                   //27-33
                     FieldByName('localidad').AsString + tab +                   //34
                     FieldByName('provincia').AsString + tab +                   //35
                     FieldByName('cp').AsString + tab +                          //36
                     tab +                                                       //37
                     FieldByName('pais').AsString + tab +                        //38
                     tab + tab + tab + tab + tab + tab + tab +                   //39-45
                     FieldByName('referencia').AsString + ' *'+ FieldByName('id_correos_certificadas').AsString + '*' + tab + //46
                     tab +                                                       //47
                     tab +                                                       //48
                     FieldByName('modalidad').AsString + tab +                   //49
                     FieldByName('peso').AsString + tab +                        //50
                     FieldByName('largo').AsString + tab +                       //51
                     FieldByName('alto').AsString + tab +                        //52
                     FieldByName('ancho').AsString + tab +                       //53
                     tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + //  54-89
                     tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + //
                     tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + //
                     tab + tab + tab + tab + tab + tab +                         //
                     FieldByName('pto_admision').AsString + tab +                //90
                     tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + //91-162
                     tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + //
                     tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + //
                     tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + //
                     tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + //
                     tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + //
                     tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + //
                     tab + tab +                                                 //
                     FieldByName('cto_rmt').AsString + tab +                     //163
                     tab + tab + tab +                                           //164-166
                     FieldByName('emp_rmt').AsString + tab +                     //167
                     FieldByName('cto_rmt').AsString + tab +                     //168
                     FieldByName('via_rmt').AsString + tab +                     //169
                     FieldByName('dir_rmt').AsString + tab +                     //170
                     tab + tab + tab + tab + tab + tab +                         //171-176
                     FieldByName('loc_rmt').AsString + tab +                     //177
                     FieldByName('prv_rmt').AsString + tab +                     //178
                     FieldByName('cp_rmt').AsString + tab +                      //179
                     tab + tab + tab + tab + tab + tab +                         //180-185
                     'E'; //fin de linea

            Writeln(txt,linea);

            ids := ids + fieldbyname('id_correos_certificadas').AsString + ',';
            Next;
        end;

        CloseFile(txt);

        ActualizaLogFile(ids, nom_file);

        ShowMessage('Fichero creado correctamente.');
      end else
             ShowMessage('No existen datos a mostrar.');
    end;
  except
      on e:Exception do
          ShowMessage('Error al crear fichero. ' + e.Message);
  end;
end;

procedure Tf_main.btXlsClick(Sender: TObject);
begin
    case rgTipo.ItemIndex of
       0: XLSBonificacion;
       1: XLSResumen;
       2,3: XLSDetalle;
       4: XLSDestinatarios;
    end;

end;

procedure Tf_main.XLSBonificacion;
var
  id_ceco_act, fila, col, fila_tit, prod_act, uds_total, uds_total_fila, fila_prod, prod: integer;
  imp_total_fila, imp_total, importe: Double;
begin
  if ((rgCliente.ItemIndex=1) and not (StrtoInt(edCliente.Text)>0)) then
       raise Exception.Create('Debe seleccionar un cliente o cambiar filtro.');

    if edXls.Text='' then
      raise Exception.Create('Debe especificar una ruta de destino.');

  if not DirectoryExists(edXls.Text) then
      raise Exception.Create('Destino especificado no válido.');

  id_ceco_act := -1;
  prod_act := -1;
  fila := 1;
  fila_tit := 0;
  fila_prod := 0;

  with dm.qReportBonificacion do
  try
    Close;
    SelectSQL.Clear;

    SelectSQL.Add('SELECT distinct id_cliente FROM mv_correos_reports r WHERE ' +
                  '((r.id_ceco=:ceco) or (:todo_cc=1)) and ' +
                  'r.fecha between :f1 and :f2 ');

    case rgCliente.ItemIndex of
      0: SelectSQL.Add('');
      1: SelectSQL.Add('and r.id_cliente=' + edIdCliente.Text);
      2: SelectSQL.Add('and r.id_cliente in (' +  grupo_gih + ') and r.id_producto=239 ');
    end;

    SelectSQL.Add(' order by id_ceco,id_producto, fecha');

    case rgCECO.ItemIndex of
      0: begin
          ParamByName('ceco').AsInteger:=edIdCeco.Value;
          ParamByName('todo_cc').AsInteger:=1;
      end;
      1: begin
          ParamByName('ceco').AsInteger:=edIdCeco.Value;
          ParamByName('todo_cc').AsInteger:=0;
      end;
    end;

    ParamByName('f1').AsDate:=edFDesde.Date;
    ParamByName('f2').AsDate:=edFHasta.Date;

    Open;

    if not IsEmpty then
    begin

        First;

        CreaExcel;

        //AbreFichero(edXls.Text + '\bonificacion' + FormatDateTime('yyyymmddhhnnss',Now) + '.xlsx');

        Hoja := excel.Worksheets.Item[1];

        //xls.clear;
        //xls.Filename := edXls.Text + '\bonificacion' + FormatDateTime('yyyymmddhhnnss',Now) + '.xlsx';

        while not Eof do
        begin
          uds_total := 0;
          imp_total := 0;

          if FieldByName('id_cliente').AsInteger<>id_ceco_act then
          begin
              id_ceco_act := FieldByName('id_cliente').AsInteger;
              excel.Cells[fila, 1].Value := BuscaClientePorId(FieldByName('id_cliente').AsInteger);// + ' - ' + BuscaCecoPorId(FieldByName('id_ceco').AsInteger);
              //xls.Sheets[0].Cell[0,fila].CellColorRGB:= RGB(51,168,255) ;
              //xls.Sheets[0].Cell[0,fila].FontColor := clBlue ;
              excel.cells[fila,1].Font.colorindex := 5; //azul
              Inc(fila);

              RellenaCabecerasBonificacion(fila);
              fila_tit := fila;
              Inc(fila);
          end;

          uds_total_fila:= 0;
          imp_total_fila := 0;

          if rgCliente.ItemIndex=2 then
              prod := 239
          else
              prod := -1;

          for col := 2 to 7 do
          begin
             case col of
                2: excel.Cells[fila, col].value := BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,-1,
                                                                                -1,prod,1,edFDesde.Date, edFHasta.Date, importe);
                3: excel.Cells[fila, col].value := BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,-1,
                                                                                -1,prod,4,edFDesde.Date, edFHasta.Date, importe);
                4: excel.Cells[fila, col].value := BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,-1,
                                                                                -1,prod,5,edFDesde.Date, edFHasta.Date, importe);
                5: excel.Cells[fila, col].value := BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,-1,
                                                                                -1,prod,2,edFDesde.Date, edFHasta.Date, importe);
                6: excel.Cells[fila, col].value := BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,-1,
                                                                                -1,prod,3,edFDesde.Date, edFHasta.Date, importe);
                7: begin
                      excel.Cells[fila, col].value := uds_total_fila;
                      excel.Cells[fila+1, col].value := imp_total_fila;
                   end;
             end;
               If col<7 then excel.Cells[fila+1, col].value := RoundTo(importe,-2);
               uds_total_fila := uds_total_fila + excel.Cells[fila, col].value;
               uds_total := uds_total + excel.Cells[fila, col].value;
               imp_total_fila := imp_total_fila + RoundTo(importe,-2);

          end;

          fila := fila + 3;

          for col := 2 to 6 do
          begin
                excel.Cells[fila, col].value :=  RoundTo(excel.Cells[fila-2, col].value*excel.Cells[fila-1, col].value/100,-2);
                imp_total := imp_total + RoundTo(excel.Cells[fila, col].value,-2);
          end;
          Inc(fila);
          excel.Cells[fila, 7].value := imp_total;
          Inc(fila);
          excel.Cells[fila, 7].value := RoundTo(imp_total * 0.21,-2);
          Inc(fila);
          excel.Cells[fila, 7].value := imp_total + RoundTo((imp_total * 0.21),-2);

          //excel.cells[1,10].formula := '=SUM(B3:C3)';
          Inc(fila);

          Next;
        end;
        //xls.Write;

        //excel.activeworkbook.save;
        excel.activeworkbook.saveas(edXls.Text + '\bonificacion' + FormatDateTime('yyyymmddhhnnss',Now) + '.xlsx');
        Excel.Quit ;
        Excel := Unassigned;
        ShowMessage('XLS Generado Correctamente.');
    end else ShowMessage('No existen datos con estos criterios de búsqueda.');

  except
     Excel.Quit ;
     Excel := Unassigned;
     ShowMessage('Error Generando XLS.');
  end;
end;

{procedure Tf_main.XLSDetalle;
var
  id_ceco_act, fila, col, fila_tit, prod_act, uds_total, fila_prod: integer;
begin
  id_ceco_act := -1;
  prod_act := -1;
  fila := 0;
  fila_tit := 0;
  fila_prod := 0;

  with dm.qReportDetalle do
  try
    Close;
    case rgCliente.ItemIndex of
      0: begin
          ParamByName('cliente').AsInteger:=edCliente.Value;
          ParamByName('todo_cl').AsInteger:=1;
      end;
      1: begin
          ParamByName('cliente').AsInteger:=edCliente.Value;
          ParamByName('todo_cl').AsInteger:=0;
      end;
    end;

    case rgCECO.ItemIndex of
      0: begin
          ParamByName('ceco').AsInteger:=edIdCeco.Value;
          ParamByName('todo_cc').AsInteger:=1;
      end;
      1: begin
          ParamByName('ceco').AsInteger:=edIdCeco.Value;
          ParamByName('todo_cc').AsInteger:=0;
      end;
    end;

    ParamByName('f1').AsDate:=edFDesde.Date;
    ParamByName('f2').AsDate:=edFHasta.Date;

    Open;

    if not IsEmpty then
    begin
        First;

        xls.Filename := edXls.Text + '\detalle' + FormatDateTime('yyyymmddhhnnss',Now) + '.xlsx';

        while not Eof do
        begin

          if FieldByName('id_ceco').AsInteger<>id_ceco_act then
          begin
              id_ceco_act := FieldByName('id_ceco').AsInteger;
              Hoja.Cells[0, fila] := BuscaClientePorId(FieldByName('id_cliente').AsInteger) + ' - ' + BuscaCecoPorId(FieldByName('id_ceco').AsInteger);
              Inc(fila);

              if FieldByName('id_producto').AsInteger<>prod_act then
              begin
                prod_act := FieldByName('id_producto').AsInteger;
                case prod_act of
                  239: Hoja.Cells[0, fila] := 'CARTAS ORDINARIAS';
                  240: Hoja.Cells[0, fila] := 'CARTAS CERTIFICADAS';
                  325: Hoja.Cells[0, fila] := 'CARTAS CERTIFICADAS CON A.R.';
                end;
                Inc(fila);
              end;

              fila_tit := RellenaCabecerasDetalle(fila);
              Inc(fila);
          end;

          if FieldByName('id_producto').AsInteger<>prod_act then
          begin
            prod_act := FieldByName('id_producto').AsInteger;
            case prod_act of
              239: Hoja.Cells[0, fila] := 'CARTAS ORDINARIAS';
              240: Hoja.Cells[0, fila] := 'CARTAS CERTIFICADAS';
              325: Hoja.Cells[0, fila] := 'CARTAS CERTIFICADAS CON A.R.';
            end;
            Inc(fila);
          end;

          //fila := fila + 2;

          uds_total := 0;
          for col := 0 to 32 do
          begin
             case col of
                0: Hoja.Cells[col, fila] := FieldByName('fecha').AsString;
                1..6: begin
                          xls.Sheets[0].AsInteger[col, fila] := BuscaFranqueo(FieldByName('id_cliente').AsInteger,FieldByName('id_ceco').AsInteger,
                                                               xls.Sheets[0].AsInteger[col, fila_tit],prod_act,
                                                               1,FieldByName('fecha').AsDateTime);
                          uds_total := uds_total + xls.Sheets[0].AsInteger[col, fila];
                      end;
                7..12: begin
                          xls.Sheets[0].AsInteger[col, fila] := BuscaFranqueo(FieldByName('id_cliente').AsInteger,FieldByName('id_ceco').AsInteger,
                                                               xls.Sheets[0].AsInteger[col, fila_tit],prod_act,
                                                               4,FieldByName('fecha').AsDateTime);
                          uds_total := uds_total + xls.Sheets[0].AsInteger[col, fila];
                       end;
                13..18: begin
                          xls.Sheets[0].AsInteger[col, fila] := BuscaFranqueo(FieldByName('id_cliente').AsInteger,FieldByName('id_ceco').AsInteger,
                                                               xls.Sheets[0].AsInteger[col, fila_tit],prod_act,
                                                               5,FieldByName('fecha').AsDateTime);
                          uds_total := uds_total + xls.Sheets[0].AsInteger[col, fila];
                        end;
                21: xls.Sheets[0].AsInteger[col, fila] := uds_total;
                22: Hoja.Cells[col, fila] := 0;
             end;
          end;
          Inc(fila);
          Next;
        end;
    end;

    xls.Write;

    ShowMessage('Generado XLS correctamente.');
  except
     ShowMessage('Error Generando XLS.');
  end;

end;   }

procedure Tf_main.XLSDetalle;
var
  id_ceco_act, fila, col, fila_tit, prod_act, uds_total, fila_prod, posicion: integer;
begin
  Screen.Cursor := crHourglass;

  if ((rgCliente.ItemIndex=1) and not (StrtoInt(edCliente.Text)>0)) then
       raise Exception.Create('Debe seleccionar un cliente o cambiar filtro.');

    if edXls.Text='' then
      raise Exception.Create('Debe especificar una ruta de destino.');

  if not DirectoryExists(edXls.Text) then
      raise Exception.Create('Destino especificado no válido.');

  id_ceco_act := -1;
  prod_act := -1;
  fila := 1;
  fila_tit := 0;
  fila_prod := 0;
  //xls.Clear;

  with dm.qReportDetalle do
  try
    Close;
    SelectSQL.Clear;
    SelectSQL.Add('SELECT * FROM mv_correos_reports r ' +
                  'WHERE ((r.id_ceco=:ceco) or (:todo_cc=1)) and ' +
                  'r.fecha between :f1 and :f2 ');

    case rgTipo.ItemIndex of
      2: SelectSQL.Add('and id_producto=239');
      3: SelectSQL.Add('and id_producto<>239');
    end;

    case rgCliente.ItemIndex of
      0: SelectSQL.Add('');
      1: SelectSQL.Add(' and r.id_cliente=' + edIdCliente.Text);
      2: SelectSQL.Add(' and r.id_cliente in (' +  grupo_gih + ') ');
    end;

    SelectSQL.Add('order by id_ceco,id_producto, fecha');

    case rgCECO.ItemIndex of
      0: begin
          ParamByName('ceco').AsInteger:=edIdCeco.Value;
          ParamByName('todo_cc').AsInteger:=1;
      end;
      1: begin
          ParamByName('ceco').AsInteger:=edIdCeco.Value;
          ParamByName('todo_cc').AsInteger:=0;
      end;
    end;

    ParamByName('f1').AsDate:=edFDesde.Date;
    ParamByName('f2').AsDate:=edFHasta.Date;

    Open;

    if not IsEmpty then
    begin
        First;

        CreaExcel;

        //xls.clear;

        Hoja := excel.Worksheets.Item[1];

        fila := RellenaCabecerasDetalle(fila);

        case rgTipo.ItemIndex of
          2: hoja.Name := 'DETALLE ORDINARIAS'; //xls.Sheets[0].Name := 'DETALLE ORDINARIAS';
          3: hoja.name := 'DETALLE CERTIFICADAS'; //xls.Sheets[0].Name := 'DETALLE CERTIFICADAS';
        end;

        Inc(fila);

        while not Eof do
        begin
          excel.Cells[fila,1] := StrToDate(FormatDateTime('dd/mm/yyyy',FieldByName('FECHA').AsDateTime));

          posicion := busca_en_clientes(FieldByName('id_cliente').AsInteger);
          excel.Cells[fila,2] := clientes[posicion].codigo;
          excel.Cells[fila,3] := clientes[posicion].nombre;
          //excel.Cells[fila,2] := CargarDatosTablaGestoras('clientes','cliente','id_cliente='+FieldByName('id_cliente').AsString);
          //excel.Cells[fila,3]  := CargarDatosTablaGestoras('clientes','nombre_r_social','id_cliente='+FieldByName('id_cliente').AsString);

          posicion := busca_en_cecos(FieldByName('id_ceco').AsInteger);

          excel.Cells[fila,4] := cecos[posicion].codigo;
          excel.Cells[fila,5] := cecos[posicion].nombre;
          //excel.Cells[fila,4]  := CargarDatosTablaGestoras('cli_cecos','ceco','id_cli_ceo='+FieldByName('id_ceco').AsString);
          //excel.Cells[fila,5]  := CargarDatosTablaGestoras('cli_cecos','titulo','id_cli_ceo='+FieldByName('id_ceco').AsString);

          excel.Cells[fila,6]  := FieldByName('PROD_NOM').AsString;
          excel.Cells[fila,7]  := FieldByName('ZONA_NOM').AsString;
          excel.Cells[fila,8] := FieldByName('PESO').AsInteger;
          excel.Cells[fila,9] := FieldByName('TARIFA').AsCurrency;
          //xls.Sheets[0].cell[8,fila].Items[8,fila].NumberFormat := '#,##0.00 €';
          excel.Cells[fila,10] := FieldByName('UDS').AsInteger;
          excel.Cells[fila,11] := FieldByName('SUBTOTAL').AsCurrency;
          //xls.Sheets[0].cell[10,fila].Items[10,fila].NumberFormat := '#,##0.00 €';
          Inc(fila);
          Next;
        end;


        case rgTipo.ItemIndex of
          2: excel.activeworkbook.saveas(edXls.Text + '\detalle_Ord_' + FormatDateTime('yyyymmddhhnnss',Now) + '.xlsx'); //xls.Filename := edXls.Text + '\detalle_Ord_' + FormatDateTime('yyyymmddhhnnss',Now) + '.xlsx';
          3: excel.activeworkbook.saveas(edXls.Text + '\detalle_Cerf_' + FormatDateTime('yyyymmddhhnnss',Now) + '.xlsx'); //xls.Filename := edXls.Text + '\detalle_Cerf_' + FormatDateTime('yyyymmddhhnnss',Now) + '.xlsx';
        end;
        excel.activeworkbook.save;
        Excel.Quit ;
        Excel := Unassigned;

        ShowMessage('Generado XLS correctamente.');
    end else
          ShowMessage('No existen datos con los criterios seleccionados.');

  except
     ShowMessage('Error Generando XLS.');
  end;
  Screen.Cursor := crDefault;

end;


procedure Tf_main.XLSDestinatarios;
var
  id_ceco_act, fila, col, fila_tit, prod_act, uds_total, fila_prod: integer;
begin

  if ((rgCliente.ItemIndex=1) and not (StrtoInt(edCliente.Text)>0)) then
       raise Exception.Create('Debe seleccionar un cliente o cambiar filtro.');

    if edXls.Text='' then
      raise Exception.Create('Debe especificar una ruta de destino.');

  if not DirectoryExists(edXls.Text) then
      raise Exception.Create('Destino especificado no válido.');

  id_ceco_act := -1;
  prod_act := -1;
  fila := 1;
  fila_tit := 0;
  fila_prod := 0;
  //xls.Clear;



  with dm.qReportDestinatario do
  try
    Close;
    SelectSQL.Clear;
    SelectSQL.Add('SELECT * FROM mv_correos_certificadas r ' +
                  'WHERE ((r.id_ceco=:ceco) or (:todo_cc=1)) and ' +
                  'r.fecha between :f1 and :f2 ');

    case rgTipo.ItemIndex of
      2: SelectSQL.Add('and id_producto=239');
      3: SelectSQL.Add('and id_producto<>239');
    end;

    case rgCliente.ItemIndex of
      0: SelectSQL.Add('');
      1: SelectSQL.Add(' and r.id_cliente=' + edIdCliente.Text);
      2: SelectSQL.Add(' and r.id_cliente in (' +  grupo_gih + ')');
    end;

    SelectSQL.Add(' order by id_ceco,id_producto, fecha');

    case rgCECO.ItemIndex of
      0: begin
          ParamByName('ceco').AsInteger:=edIdCeco.Value;
          ParamByName('todo_cc').AsInteger:=1;
      end;
      1: begin
          ParamByName('ceco').AsInteger:=edIdCeco.Value;
          ParamByName('todo_cc').AsInteger:=0;
      end;
    end;

    ParamByName('f1').AsDate:=edFDesde.Date;
    ParamByName('f2').AsDate:=edFHasta.Date;

    Open;

    if not IsEmpty then
    begin
        First;

        CreaExcel;

        Hoja := excel.Worksheets.Item[1];

        fila := RellenaCabecerasDestinatarios(fila);

        case rgTipo.ItemIndex of
          2: hoja.Name := 'DETALLE ORDINARIAS';   //xls.Sheets[0].Name := 'DETALLE ORDINARIAS';
          3: hoja.Name := 'DETALLE CERTIFICADAS'; //xls.Sheets[0].Name := 'DETALLE CERTIFICADAS';
          4: hoja.Name := 'DESTINATARIOS';            //xls.Sheets[0].Name := 'DESTINATARIOS';
        end;

        Inc(fila);

        while not Eof do
        begin
          excel.Cells[fila, 1] := StrToDate(FormatDateTime('dd/mm/yyyy',FieldByName('FECHA').AsDateTime));
          excel.Cells[fila, 2] := CargarDatosTablaGestoras('clientes','cliente','id_cliente='+FieldByName('id_cliente').Text);
          excel.Cells[fila, 3] := CargarDatosTablaGestoras('clientes','nombre_r_social','id_cliente='+FieldByName('id_cliente').Text);
          excel.Cells[fila, 4] := CargarDatosTablaGestoras('cli_cecos','ceco','id_cli_ceo='+FieldByName('id_ceco').AsString);
          excel.Cells[fila, 5] := CargarDatosTablaGestoras('cli_cecos','titulo','id_cli_ceo='+FieldByName('id_ceco').AsString);
          excel.Cells[fila, 6] := FieldByName('PROD_NOM').AsString;
          excel.Cells[fila, 7] := FieldByName('ZONA_NOM').AsString;
          excel.Cells[fila, 8] := FieldByName('PESO').AsInteger;
          excel.Cells[fila, 9] := FieldByName('ALTO').AsString +'-'+FieldByName('ancho').AsString +'-'+FieldByName('LARGO').AsString;
          excel.Cells[fila, 10] := FieldByName('EMPRESA').AsString;
          excel.Cells[fila, 11] := FieldByName('DIRECCION').AsString;
          excel.Cells[fila, 12] := FieldByName('LOCALIDAD').AsString;
          excel.Cells[fila, 13] := FieldByName('PROVINCIA').AsString;
          excel.Cells[fila, 14] := FieldByName('CP').AsString;
          excel.Cells[fila, 15] := FieldByName('PAIS').AsString;
          excel.Cells[fila, 16] := FieldByName('REFERENCIA').AsString;
          excel.Cells[fila, 17] := FieldByName('CTO_RMT').AsString;
          excel.Cells[fila, 18] := FieldByName('BARCODE').AsString;

          Inc(fila);
          Next;
        end;

       case rgTipo.ItemIndex of
          2: excel.activeworkbook.saveas(edXls.Text + '\detalle_Ord_' + FormatDateTime('yyyymmddhhnnss',Now) + '.xlsx');
          3: excel.activeworkbook.saveas(edXls.Text + '\detalle_Cerf_' + FormatDateTime('yyyymmddhhnnss',Now) + '.xlsx');
          4: excel.activeworkbook.saveas(edXls.Text + '\destinatarios_' + FormatDateTime('yyyymmddhhnnss',Now) + '.xlsx');
       end;

      Excel.Quit ;
      Excel := Unassigned;
      ShowMessage('Generado XLS correctamente.');

    end else
          ShowMessage('No existen datos con los criterios seleccionados.');

  except
     ShowMessage('Error Generando XLS.');
  end;

end;

{procedure Tf_main.XLSResumen;
var
  id_ceco_act, fila, col, fila_tit, prod_act, uds_total, fila_prod, cli_actual: integer;
  importe,imp_total_nac, imp_total_int: Double;
begin
  id_ceco_act := -1;
  prod_act := -1;
  cli_actual := -1;
  fila := 0;
  fila_tit := 0;
  fila_prod := 0;

  with dm.qReportResumen do
  try
    Close;
    case rgCliente.ItemIndex of
      0: begin
          ParamByName('cliente').AsInteger:=edCliente.Value;
          ParamByName('todo_cl').AsInteger:=1;
      end;
      1: begin
          ParamByName('cliente').AsInteger:=edCliente.Value;
          ParamByName('todo_cl').AsInteger:=0;
      end;
    end;

    case rgCECO.ItemIndex of
      0: begin
          ParamByName('ceco').AsInteger:=edIdCeco.Value;
          ParamByName('todo_cc').AsInteger:=1;
      end;
      1: begin
          ParamByName('ceco').AsInteger:=edIdCeco.Value;
          ParamByName('todo_cc').AsInteger:=0;
      end;
    end;

    ParamByName('f1').AsDate:=edFDesde.Date;
    ParamByName('f2').AsDate:=edFHasta.Date;

    Open;

    if not IsEmpty then
    begin
        First;

        xls.Filename := edXls.Text + '\resumen' + FormatDateTime('yyyymmddhhnnss',Now) + '.xlsx';

        RellenaCabecerasResumen(fila);
        fila_tit := fila;
        Inc(fila);

        while not Eof do
        begin

          if FieldByName('id_ceco').AsInteger<>id_ceco_act then
          begin
              id_ceco_act := FieldByName('id_ceco').AsInteger;
              Hoja.Cells[0, fila] := BuscaCecoPorId(FieldByName('id_ceco').AsInteger);
              Hoja.Cells[1, fila] := 'NACIONAL';
              Hoja.Cells[1, fila+1] := 'INTERNACIONAL';
          end;

          uds_total := 0;
          imp_total_nac := 0;
          imp_total_int := 0;
          importe := 0;

          for col := 2 to 8 do
          begin
             case col of
                0: Hoja.Cells[col, fila] := FieldByName('fecha').AsString;
                2..7: begin
                          uds_total := uds_total + BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,FieldByName('id_ceco').AsInteger,
                                                               xls.Sheets[0].AsInteger[col, fila_tit],-1,
                                                               1,edFDesde.Date, edFHasta.Date, importe);
                          imp_total_nac := imp_total_nac + importe;
                          uds_total := uds_total + BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,FieldByName('id_ceco').AsInteger,
                                                               xls.Sheets[0].AsInteger[col, fila_tit],-1,
                                                               4,edFDesde.Date, edFHasta.Date, importe);
                          imp_total_nac := imp_total_nac + importe;
                          uds_total := uds_total + BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,FieldByName('id_ceco').AsInteger,
                                                               xls.Sheets[0].AsInteger[col, fila_tit],-1,
                                                               5,edFDesde.Date, edFHasta.Date, importe);
                          imp_total_nac := imp_total_nac + importe;

                          xls.Sheets[0].AsInteger[col, fila] := uds_total;
                          uds_total := 0;


                          uds_total := uds_total + BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,FieldByName('id_ceco').AsInteger,
                                                               xls.Sheets[0].AsInteger[col, fila_tit],-1,
                                                               2,edFDesde.Date, edFHasta.Date, importe);
                          imp_total_int := imp_total_int + importe;
                          uds_total := uds_total + BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,FieldByName('id_ceco').AsInteger,
                                                               xls.Sheets[0].AsInteger[col, fila_tit],-1,
                                                               3,edFDesde.Date, edFHasta.Date, importe);
                          imp_total_int := imp_total_int + importe;

                          xls.Sheets[0].AsInteger[col, fila+1] := uds_total;
                      end;
                8: begin
                      Hoja.Cells[col, fila] := imp_total_nac;
                      Hoja.Cells[col, fila+1] := imp_total_int;
                   end;
             end;
          end;
          fila := fila + 2;
          Next;
        end;
    end;


    xls.Write;
    ShowMessage('XLS Generado Correctamente.');
  except
     ShowMessage('Error Generando XLS.');
  end;

end;   }


procedure Tf_main.XLSResumen;
var
  ceco_act, fila, col, fila_tit, zona_act, uds_total, fila_prod, cli_actual, uds_total_fila, uds_total_20, uds_total_50, uds_total_100, uds_total_500, uds_total_1000, uds_total_2000: integer;
  imp_total_fila, imp_total: Double;
begin
  if ((rgCliente.ItemIndex=1) and not (StrtoInt(edCliente.Text)>0)) then
       raise Exception.Create('Debe seleccionar un cliente o cambiar filtro.');

  if edXls.Text='' then
      raise Exception.Create('Debe especificar una ruta de destino.');

  if not DirectoryExists(edXls.Text) then
      raise Exception.Create('Destino especificado no válido.');


  ceco_act := -1;
  zona_act := -1;
  cli_actual := -1;
  fila := 1;
  fila_tit := 0;
  fila_prod := 0;

  uds_total_fila := 0;
  uds_total_20 := 0;
  uds_total_50 := 0;
  uds_total_100 := 0;
  uds_total_500 := 0;
  uds_total_1000 := 0;
  uds_total_2000 := 0;

  imp_total_fila := 0;
  imp_total := 0;

  with dm.qReportResumen do
  try
    Close;
    SelectSQL.Clear;

    SelectSQL.Add('SELECT id_cliente,id_ceco, peso, sum(uds) as uds, sum(uds*tarifa) as subtotal ' +
                  'FROM mv_correos_reports r WHERE ');

    case rgCliente.ItemIndex of
      0: SelectSQL.Add('');
      1: SelectSQL.Add(' r.id_cliente=' + edIdCliente.Text + ' and ');
      2: SelectSQL.Add(' r.id_cliente in (' +  grupo_gih + ') and ');
    end;

    SelectSQL.Add(' ((r.id_ceco=:ceco) or (:todo_cc=1)) and ' +
                  ' r.fecha between :f1 and :f2 ' +
                  ' group by id_cliente,id_ceco, peso ' +
                  ' order by id_cliente, id_ceco');

    case rgCECO.ItemIndex of
      0: begin
          ParamByName('ceco').AsInteger:=edIdCeco.Value;
          ParamByName('todo_cc').AsInteger:=1;
      end;
      1: begin
          ParamByName('ceco').AsInteger:=edIdCeco.Value;
          ParamByName('todo_cc').AsInteger:=0;
      end;
    end;

    ParamByName('f1').AsDate:=edFDesde.Date;
    ParamByName('f2').AsDate:=edFHasta.Date;

    Open;

    if not IsEmpty then
    begin
        First;

        //xls.Clear;

        CreaExcel;

        Hoja := excel.Worksheets.Item[1];

        fila := RellenaCabecerasResumen(1,fila);

        //Inc(fila);

        while not Eof do
        begin
          if cli_actual<>FieldByName('id_cliente').AsInteger then
          begin
              cli_actual := FieldByName('id_cliente').AsInteger;
              if uds_total_fila>0 then
                       excel.cells[fila,9] := uds_total_fila;
               if imp_total_fila>0 then
               begin
                       excel.Cells[fila,10] := imp_total_fila;
                       //xls.Sheets[0].cell[9,fila].Items[9,fila].NumberFormat := '#,##0.00 €';
               end;
               uds_total_fila := 0;
               imp_total_fila := 0;
               Inc(fila);
              excel.Cells[fila,1] := CargarDatosTablaGestoras('clientes','nombre_r_social','id_cliente='+FieldByName('id_cliente').Text);
          end;

          if ceco_act<>FieldByName('id_ceco').AsInteger then
          begin
              ceco_act := FieldByName('id_ceco').AsInteger;
              if uds_total_fila>0 then
                       excel.Cells[fila,9] := uds_total_fila;
               if imp_total_fila>0 then
               begin
                       excel.Cells[fila,10] := imp_total_fila;
                       //xls.Sheets[0].cell[9,fila].Items[9,fila].NumberFormat := '#,##0.00 €';
               end;
              uds_total_fila := 0;
              imp_total_fila := 0;
              zona_act := -1;
              Inc(fila);
              excel.Cells[fila,2] := CargarDatosTablaGestoras('cli_cecos','titulo','id_cli_ceo='+FieldByName('id_ceco').Text);
              excel.Cells[fila, CalculaCol(FieldByName('peso').AsInteger)] := FieldByName('uds').AsInteger;
               case FieldByName('peso').AsInteger of
                  20: uds_total_20 := uds_total_20 + FieldByName('uds').AsInteger;
                  50: uds_total_50 := uds_total_50 + FieldByName('uds').AsInteger;
                  100: uds_total_100 := uds_total_100 + FieldByName('uds').AsInteger;
                  500: uds_total_500 := uds_total_500 + FieldByName('uds').AsInteger;
                  1000: uds_total_1000 := uds_total_1000 + FieldByName('uds').AsInteger;
                  2000: uds_total_2000 := uds_total_2000 + FieldByName('uds').AsInteger;
               end;
               uds_total_fila := uds_total_fila + FieldByName('uds').AsInteger;
               imp_total_fila := imp_total_fila + FieldByName('subtotal').AsFloat;
               imp_total := imp_total + FieldByName('subtotal').AsFloat;
          end else begin
                       excel.Cells[fila, CalculaCol(FieldByName('peso').AsInteger)] := FieldByName('uds').AsInteger;
                       case FieldByName('peso').AsInteger of
                          20: uds_total_20 := uds_total_20 + FieldByName('uds').AsInteger;
                          50: uds_total_50 := uds_total_50 + FieldByName('uds').AsInteger;
                          100: uds_total_100 := uds_total_100 + FieldByName('uds').AsInteger;
                          500: uds_total_500 := uds_total_500 + FieldByName('uds').AsInteger;
                          1000: uds_total_1000 := uds_total_1000 + FieldByName('uds').AsInteger;
                          2000: uds_total_2000 := uds_total_2000 + FieldByName('uds').AsInteger;
                       end;
                       uds_total_fila := uds_total_fila + FieldByName('uds').AsInteger;
                       imp_total_fila := imp_total_fila + FieldByName('subtotal').AsFloat;
                       imp_total := imp_total + FieldByName('subtotal').AsFloat;
                   end;

         { if zona_act<>FieldByName('id_zona').AsInteger then
          begin
               zona_act := FieldByName('id_zona').AsInteger;
               if uds_total_fila>0 then
                       xls.Sheets[0].AsInteger[9,fila] := uds_total_fila;
               if imp_total_fila>0 then
                       excel.Cells[10,fila] := imp_total_fila;
               uds_total_fila := 0;
               imp_total_fila := 0;

               Inc(fila);
               excel.Cells[2,fila] := FieldByName('zona_nom').AsString;
               xls.Sheets[0].AsInteger[CalculaCol(FieldByName('peso').AsInteger),fila] := FieldByName('uds').AsInteger;
               case FieldByName('peso').AsInteger of
                  20: uds_total_20 := uds_total_20 + FieldByName('uds').AsInteger;
                  50: uds_total_50 := uds_total_50 + FieldByName('uds').AsInteger;
                  100: uds_total_100 := uds_total_100 + FieldByName('uds').AsInteger;
                  500: uds_total_500 := uds_total_500 + FieldByName('uds').AsInteger;
                  1000: uds_total_1000 := uds_total_1000 + FieldByName('uds').AsInteger;
                  2000: uds_total_2000 := uds_total_2000 + FieldByName('uds').AsInteger;
               end;
               uds_total_fila := uds_total_fila + FieldByName('uds').AsInteger;
               imp_total_fila := imp_total_fila + FieldByName('subtotal').AsFloat;
               imp_total := imp_total + FieldByName('subtotal').AsFloat;
          end else begin
                       xls.Sheets[0].AsInteger[CalculaCol(FieldByName('peso').AsInteger),fila] := FieldByName('uds').AsInteger;
                       case FieldByName('peso').AsInteger of
                          20: uds_total_20 := uds_total_20 + FieldByName('uds').AsInteger;
                          50: uds_total_50 := uds_total_50 + FieldByName('uds').AsInteger;
                          100: uds_total_100 := uds_total_100 + FieldByName('uds').AsInteger;
                          500: uds_total_500 := uds_total_500 + FieldByName('uds').AsInteger;
                          1000: uds_total_1000 := uds_total_1000 + FieldByName('uds').AsInteger;
                          2000: uds_total_2000 := uds_total_2000 + FieldByName('uds').AsInteger;
                       end;
                       uds_total_fila := uds_total_fila + FieldByName('uds').AsInteger;
                       imp_total_fila := imp_total_fila + FieldByName('subtotal').AsFloat;
                       imp_total := imp_total + FieldByName('subtotal').AsFloat;
                   end;    }

          //Inc(fila);
          Next;
        end;

        if uds_total_fila>0 then
                       excel.Cells[fila,9] := uds_total_fila;
               if imp_total_fila>0 then
                       excel.Cells[fila,10] := imp_total_fila;

        Inc(fila);
        excel.Cells[fila,1] := 'Total General';
        excel.Cells[fila,3] := uds_total_20;
        excel.Cells[fila,4] := uds_total_50;
        excel.Cells[fila,5] := uds_total_100;
        excel.Cells[fila,6] := uds_total_500;
        excel.Cells[fila,7] := uds_total_1000;
        excel.Cells[fila,8] := uds_total_2000;
        excel.Cells[fila,9] := uds_total_20 + uds_total_50 + uds_total_100 + uds_total_500 + uds_total_1000 + uds_total_2000;
        excel.Cells[fila,10] := imp_total;
        //xls.Sheets[0].cell[9,fila].Items[9,fila].NumberFormat := '#,##0.00 €';
    end;

   { xls.Sheets[0].AutoWidthCol(0);
    xls.Sheets[0].AutoWidthCol(1);
    xls.Sheets[0].AutoWidthCol(2);
    xls.Sheets[0].AutoWidthCol(3);
    xls.Sheets[0].AutoWidthCol(4);
    xls.Sheets[0].AutoWidthCol(5);
    xls.Sheets[0].AutoWidthCol(6);
    xls.Sheets[0].AutoWidthCol(7);
    xls.Sheets[0].AutoWidthCol(8);
    xls.Sheets[0].AutoWidthCol(9);
    xls.Sheets[0].AutoWidthCol(10); }

    //xls.Write;

    excel.activeworkbook.saveas(edXls.Text + '\resumen' + FormatDateTime('yyyymmddhhnnss',Now) + '.xlsx');
    Excel.Quit ;
    Excel := Unassigned;

    ShowMessage('XLS Generado Correctamente.');
  except
     ShowMessage('Error Generando XLS.');
  end;

end;


function  Tf_main.CalculaCol(peso: Integer):integer;
begin
   case peso of
      20: Result := 3;
      50: Result := 4;
      100: Result := 5;
      500: Result := 6;
      1000: Result := 7;
      2000: Result := 8;
   end;
end;

procedure Tf_main.ReportBonificacion;
var
  id_ceco_act, fila, col, fila_tit, prod_act, uds_total, uds_total_fila, fila_prod, prod: integer;
  imp_total_fila, imp_total, importe: Double;
begin
  if ((rgCliente.ItemIndex=1) and not (StrtoInt(edCliente.Text)>0)) then
       raise Exception.Create('Debe seleccionar un cliente o cambiar filtro.');

  id_ceco_act := -1;
  prod_act := -1;
  fila := 0;
  fila_tit := 0;
  fila_prod := 0;

  ar_bonificacion.EmptyDataSet;

  with dm.qReportBonificacion do
  try
    Close;
    SelectSQL.Clear;

    SelectSQL.Add('SELECT distinct id_cliente FROM mv_correos_reports r WHERE ' +
                  '((r.id_ceco=:ceco) or (:todo_cc=1)) and ' +
                  'r.fecha between :f1 and :f2 ');

    case rgCliente.ItemIndex of
      0: SelectSQL.Add('');
      1: SelectSQL.Add('and r.id_cliente=' + edIdCliente.Text);
      2: SelectSQL.Add('and r.id_cliente in (' +  grupo_gih + ') and r.id_producto=239 ');
    end;

    SelectSQL.Add(' order by id_ceco,id_producto, fecha');

    case rgCECO.ItemIndex of
      0: begin
          ParamByName('ceco').AsInteger:=edIdCeco.Value;
          ParamByName('todo_cc').AsInteger:=1;
      end;
      1: begin
          ParamByName('ceco').AsInteger:=edIdCeco.Value;
          ParamByName('todo_cc').AsInteger:=0;
      end;
    end;

    ParamByName('f1').AsDate:=edFDesde.Date;
    ParamByName('f2').AsDate:=edFHasta.Date;

    Open;
    ar_bonificacion.EmptyDataSet;

    if not IsEmpty then
    begin

        First;

        while not Eof do
        begin
          uds_total := 0;
          imp_total := 0;

          ar_bonificacion.Insert;
          ar_bonificacion.FieldByName('id_cliente').AsInteger := FieldByName('id_cliente').AsInteger;
          ar_bonificacion.FieldByName('nombre').AsString := BuscaClientePorId(FieldByName('id_cliente').AsInteger);
          ar_bonificacion.FieldByName('fecha_desde').AsString := FormatDateTime('dd/mm/yyyy', edFDesde.Date);
          ar_bonificacion.FieldByName('fecha_hasta').AsString := FormatDateTime('dd/mm/yyyy', edFHasta.Date);

          uds_total_fila:= 0;
          imp_total_fila := 0;

          if rgCliente.ItemIndex=2 then
              prod := 239
          else
              prod := -1;

          ar_bonificacion.FieldByName('uds_local').AsInteger := BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,-1,-1,prod,1,edFDesde.Date, edFHasta.Date, importe);
          ar_bonificacion.FieldByName('imp_local').AsFloat := importe;
          ar_bonificacion.FieldByName('uds_int_eur').AsInteger := BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,-1,-1,prod,2,edFDesde.Date, edFHasta.Date, importe);
          ar_bonificacion.FieldByName('imp_int_eur').AsFloat := importe;
          ar_bonificacion.FieldByName('uds_int_resto').AsInteger := BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,-1,-1,prod,3,edFDesde.Date, edFHasta.Date, importe);
          ar_bonificacion.FieldByName('imp_int_resto').AsFloat := importe;
          ar_bonificacion.FieldByName('uds_d1').AsInteger := BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,-1,-1,prod,4,edFDesde.Date, edFHasta.Date, importe);
          ar_bonificacion.FieldByName('imp_d1').AsFloat := importe;
          ar_bonificacion.FieldByName('uds_d2').AsInteger := BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,-1,-1,prod,5,edFDesde.Date, edFHasta.Date, importe);
          ar_bonificacion.FieldByName('imp_d2').AsFloat := importe;
          ar_bonificacion.FieldByName('bon_fr_loc').AsInteger := bon_franq_loc;
          ar_bonificacion.FieldByName('bon_fr_d1').AsInteger := bon_franq_d1;
          ar_bonificacion.FieldByName('bon_fr_d2').AsInteger := bon_franq_d2;
          ar_bonificacion.FieldByName('bon_fr_int_eur').AsInteger := bon_franq_int_eur;
          ar_bonificacion.FieldByName('bon_fr_int_resto').AsInteger := bon_franq_int_resto;


          Next;
        end;
        ar_bonificacion.Post;


        if repBonificacion.PrepareReport then repBonificacion.ShowPreparedReport;

    end;
  except
       ShowMessage('Error Generando Documento.');
  end;
end;

procedure Tf_main.ReportDetalle;
var
  id_ceco_act, fila, col, fila_tit, prod_act, uds_total, fila_prod: integer;
  importe: Double;
begin
  if ((rgCliente.ItemIndex=1) and not (StrtoInt(edCliente.Text)>0)) then
       raise Exception.Create('Debe seleccionar un cliente o cambiar filtro.');

  id_ceco_act := -1;
  prod_act := -1;
  fila := 0;
  fila_tit := 0;
  fila_prod := 0;

  with dm.qReportDetalle do
  try
    Close;
    SelectSQL.Clear;
    SelectSQL.Add('SELECT * FROM mv_correos_reports r ' +
                  'WHERE ((r.id_ceco=:ceco) or (:todo_cc=1)) and ' +
                  'r.fecha between :f1 and :f2 ');

    case rgTipo.ItemIndex of
      2: SelectSQL.Add('and id_producto=239');
      3: SelectSQL.Add('and id_producto<>239');
    end;

    case rgCliente.ItemIndex of
      0: SelectSQL.Add('');
      1: SelectSQL.Add(' and r.id_cliente=' + edIdCliente.Text);
      2: SelectSQL.Add(' and r.id_cliente in (' +  grupo_gih + ')');
    end;

    SelectSQL.Add(' order by id_ceco,id_producto, fecha');


    case rgCECO.ItemIndex of
      0: begin
          ParamByName('ceco').AsInteger:=edIdCeco.Value;
          ParamByName('todo_cc').AsInteger:=1;
      end;
      1: begin
          ParamByName('ceco').AsInteger:=edIdCeco.Value;
          ParamByName('todo_cc').AsInteger:=0;
      end;
    end;

    ParamByName('f1').AsDate:=edFDesde.Date;
    ParamByName('f2').AsDate:=edFHasta.Date;

    Open;
    ar_detalle.EmptyDataSet;

    if not IsEmpty then
    begin
        First;

        while not Eof do
        begin

          ar_detalle.Insert;
          ar_detalle.FieldByName('id_cliente').AsInteger := StrToInt(CargarDatosTablaGestoras('clientes','cliente','id_cliente='+FieldByName('id_cliente').AsString));
          ar_detalle.FieldByName('nombre').AsString := CargarDatosTablaGestoras('clientes','nombre_r_social','id_cliente='+FieldByName('id_cliente').AsString);
          ar_detalle.FieldByName('ceco').AsString := CargarDatosTablaGestoras('cli_cecos','titulo','id_cli_ceo='+FieldByName('id_ceco').asstring);
          ar_detalle.FieldByName('fecha').AsString := FormatDateTime('dd/mm/yyyy', FieldByName('fecha').asdatetime);
          ar_detalle.FieldByName('producto').AsString := FieldByName('PROD_NOM').AsString;
          ar_detalle.FieldByName('zona').AsString := FieldByName('ZONA_NOM').AsString;
          ar_detalle.FieldByName('peso').AsInteger := FieldByName('PESO').AsInteger;
          ar_detalle.FieldByName('tarifa').AsCurrency := FieldByName('TARIFA').AsCurrency;
          ar_detalle.FieldByName('uds').AsInteger := FieldByName('UDS').AsInteger;
          ar_detalle.FieldByName('subtotal').AsCurrency := FieldByName('SUBTOTAL').AsCurrency;

          ar_detalle.Post;
          Next;
        end;

        if repDetalle.PrepareReport then repDetalle.ShowPreparedReport;
    end else
            ShowMessage('No existen datos con los criterios seleccionados.');

  except
       ShowMessage('Error Generando Documento.');
  end;
end;

{function Tf_main.RellenaCabecerasDetalle(fila:integer):integer;
begin
    Hoja.Cells[1, fila] := 'LOCAL';
    Hoja.Cells[7, fila] := 'D - 1';
    Hoja.Cells[13, fila] := 'D - 2';
    Hoja.Cells[19, fila] := 'INT. EUR.';
    Hoja.Cells[20, fila] := 'INT. RESTO';
    Hoja.Cells[31, fila] := 'TOTAL ENVIO';
    Hoja.Cells[32, fila] := 'TOTAL €';
    Inc(fila);
    Hoja.Cells[0, fila] := 'DIA';
    Hoja.Cells[1, fila] := '20';    //Pesos Local
    Hoja.Cells[2, fila] := '50';
    Hoja.Cells[3, fila] := '100';
    Hoja.Cells[4, fila] := '500';
    Hoja.Cells[5, fila] := '1000';
    Hoja.Cells[6, fila] := '2000';
    Hoja.Cells[7, fila] := '20';     //Pesos D1
    Hoja.Cells[8, fila] := '50';
    Hoja.Cells[9, fila] := '100';
    Hoja.Cells[10, fila] := '500';
    Hoja.Cells[11, fila] := '1000';
    Hoja.Cells[12, fila] := '2000';
    Hoja.Cells[13, fila] := '20';     //Pesos D2
    Hoja.Cells[14, fila] := '50';
    Hoja.Cells[15, fila] := '100';
    Hoja.Cells[16, fila] := '500';
    Hoja.Cells[17, fila] := '1000';
    Hoja.Cells[18, fila] := '2000';
    Hoja.Cells[19, fila] := '20';     //Pesos Int. Europa
    Hoja.Cells[20, fila] := '50';
    Hoja.Cells[21, fila] := '100';
    Hoja.Cells[22, fila] := '500';
    Hoja.Cells[23, fila] := '1000';
    Hoja.Cells[24, fila] := '2000';
    Hoja.Cells[25, fila] := '20';     //Pesos Int. Resto
    Hoja.Cells[26, fila] := '50';
    Hoja.Cells[27, fila] := '100';
    Hoja.Cells[28, fila] := '500';
    Hoja.Cells[29, fila] := '1000';
    Hoja.Cells[30, fila] := '2000';

    result := fila;
end; }


function Tf_main.RellenaCabecerasDetalle(fila:integer):integer;
begin
    excel.Cells[fila,1] := 'FECHA';
    excel.Cells[fila,2] := 'COD';
    excel.Cells[fila,3] := 'CLIENTE';
    excel.Cells[fila,4] := 'CECO';
    excel.Cells[fila,5] := 'CC_NOMBRE';
    excel.Cells[fila,6] := 'PRODUCTO';
    excel.Cells[fila,7] := 'ZONA';
    excel.Cells[fila,8] := 'PESO';
    excel.Cells[fila,9] := 'TARIFA';
    excel.Cells[fila,10] := 'UDS';
    excel.Cells[fila,11] := 'TOTAL';

    result := fila;
end;

function Tf_main.RellenaCabecerasDestinatarios(fila:integer):integer;
begin
    excel.Cells[fila,1] := 'FECHA';
    excel.Cells[fila,2] := 'COD';
    excel.Cells[fila,3] := 'CLIENTE';
    excel.Cells[fila,4] := 'CECO';
    excel.Cells[fila,5] := 'CC_NOMBRE';
    excel.Cells[fila,6] := 'PRODUCTO';
    excel.Cells[fila,7] := 'ZONA';
    excel.Cells[fila,8] := 'PESO';
    excel.Cells[fila,9] := 'ALTO-ANCHO-LARGO';
    //excel.Cells[9, fila] := 'TARIFA';
    excel.Cells[fila,10] := 'EMPRESA';
    excel.Cells[fila,11] := 'DIRECCION';
    excel.Cells[fila,12] := 'LOCALIDAD';
    excel.Cells[fila,13] := 'PROVINCIA';
    excel.Cells[fila,14] := 'C. POSTAL';
    excel.Cells[fila,15] := 'PAIS';
    excel.Cells[fila,16] := 'REFERENCIA';
    excel.Cells[fila,17] := 'CONTACTO';
    excel.Cells[fila,18] := 'BARCODE';
    result := fila;
end;


function Tf_main.RellenaCabecerasResumen(col,fila:integer):integer;
begin
    excel.Cells[fila, col+2] := 'PESO';
    //xls.Sheets[0].Cell[3, fila].FontColor := xcBlue;
    //xls.Sheets[0].Cell[3, fila].FontStyle := Xc12DataStyleSheet5.tXc12FontStyles(xfsBold);
    //xls.Sheets[0].Cell[3,fila].FillPatternBackColor := xcBlue;

    Inc(fila);

    excel.Cells[fila, col+2] := '20';
    excel.Cells[fila, col+3] := '50';
    excel.Cells[fila, col+4] := '100';
    excel.Cells[fila, col+5] := '500';
    excel.Cells[fila, col+6] := '1000';
    excel.Cells[fila, col+7] := '2000';
    excel.Cells[fila, col+8] := 'Total UNIDADES';
    excel.Cells[fila, col+9] := 'Total IMPORTE';


    Inc(fila);
    excel.Cells[fila, col] := 'CLIENTE';
    excel.Cells[fila, col+1] := 'CC_NOMBRE';
    //excel.Cells[col+2] := 'ZONA';
    excel.Cells[fila, col+2] := 'UNIDADES';
    excel.Cells[fila, col+3] := 'UNIDADES';
    excel.Cells[fila, col+4] := 'UNIDADES';
    excel.Cells[fila, col+5] := 'UNIDADES';
    excel.Cells[fila, col+6] := 'UNIDADES';
    excel.Cells[fila, col+7] := 'UNIDADES';

    result := fila;
end;

procedure Tf_main.RellenaCabecerasBonificacion(fila:integer);
begin
    excel.Cells[fila, 2] := 'LOCAL';
    excel.Cells[fila, 3] := 'D - 1';
    excel.Cells[fila, 4] := 'D - 2';
    excel.Cells[fila, 5] := 'INT. EUR.';
    excel.Cells[fila, 6] := 'INT. RESTO';
    excel.Cells[fila, 7] := 'TOTAL';
    Inc(fila);
    excel.Cells[fila, 1] := 'Uds.';
    Inc(fila);
    excel.Cells[fila, 1] := 'Importe';
    Inc(fila);
    excel.Cells[fila, 1] := '% Dto.';
    excel.Cells[fila, 2] := bon_franq_loc;
    excel.Cells[fila, 3] := bon_franq_d1;
    excel.Cells[fila, 4] := bon_franq_d2;
    excel.Cells[fila, 5] := bon_franq_int_eur;
    excel.Cells[fila, 6] := bon_franq_int_resto;
    Inc(fila);
    excel.Cells[fila, 1] := 'Imp. Total';
    Inc(fila);
    excel.Cells[fila, 6] := 'Total';
    Inc(fila);
    excel.Cells[fila, 6] := 'I.V.A. 21%';
    Inc(fila);
    excel.Cells[fila, 6] := 'TOTAL';
end;
{$ENDREGION 'INFORMES'}

{$REGION 'DATOS'}

function Tf_main.GetTotalCliente(cliente:Integer; out uds:integer):Double;
begin
   with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select sum(uds) as uds,sum(uds*tarifa) as total ' +
                       'from m_correos_reports r ' +
                       'where id_cliente=:cliente and fecha=:fecha and estado=''A'' ');
    ParamByName('cliente').AsInteger := cliente;
    ParamByName('fecha').AsDateTime := edFecha.Date;
    Open;

    if not(IsEmpty) then
    begin
        uds := FieldByName('uds').AsInteger;
        Result:=FieldByName('total').AsFloat;
    end
    else result:=0;

    Free;
  end;
end;

function Tf_main.GetTotalClienteProducto(cliente,producto:Integer; out uds:integer):Double;
begin
   with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select sum(uds) as uds,sum(uds*tarifa) as total ' +
                       'from m_correos_reports r ' +
                       'where id_cliente=:cliente and fecha=:fecha and id_producto=:producto and estado=''A'' ');
    ParamByName('cliente').AsInteger := cliente;
    ParamByName('producto').AsInteger := producto;
    ParamByName('fecha').AsDateTime := edFecha.Date;
    Open;

    if not(IsEmpty) then
    begin
        uds := FieldByName('uds').AsInteger;
        Result:=FieldByName('total').AsFloat;
    end
    else result:=0;

    Free;
  end;
end;

function Tf_main.GetTotalClientePeso(cliente, peso:Integer; out uds:integer):Double;
begin
   with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select sum(uds) as uds,sum(uds*tarifa) as total ' +
                       'from m_correos_reports r ' +
                       'where id_cliente=:cliente and peso=:peso and fecha=:fecha and estado=''A'' ');
    ParamByName('cliente').AsInteger := cliente;
    ParamByName('peso').AsInteger := peso;
    ParamByName('fecha').AsDateTime := edFecha.Date;
    Open;

    if not(IsEmpty) then
    begin
        uds := FieldByName('uds').AsInteger;
        Result:=FieldByName('total').AsFloat;
    end
    else result:=0;

    Free;
  end;
end;

function Tf_main.GetTotalClientePesoProducto(cliente, peso,producto:Integer; out uds:integer):Double;
begin
   with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select sum(uds) as uds,sum(uds*tarifa) as total ' +
                       'from m_correos_reports r ' +
                       'where id_cliente=:cliente and peso=:peso and id_producto=:producto and fecha=:fecha and estado=''A'' ');
    ParamByName('cliente').AsInteger := cliente;
    ParamByName('peso').AsInteger := peso;
    ParamByName('producto').AsInteger := producto;
    ParamByName('fecha').AsDateTime := edFecha.Date;
    Open;

    if not(IsEmpty) then
    begin
        uds := FieldByName('uds').AsInteger;
        Result:=FieldByName('total').AsFloat;
    end
    else result:=0;

    Free;
  end;
end;

function Tf_main.BuscaCliente(codigo:string):string;
begin                                       //devuelve nombre de cliente a partir de codigo
  with tpfibdataset.Create(dm) do begin
    database:=dm.db_gestoras;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select nombre from clientes cl where cl.grupo=7 and cl.cliente=:codigo');
    ParamByName('codigo').AsInteger := StrToInt(codigo);
    Open;

    if not(IsEmpty) then Result:=FieldByName('nombre').asstring
    else result:='';

    Free;
  end;
end;


function Tf_main.BuscaClientePorId(id:integer):string;
begin                                       //devuelve nombre de cliente a partir de id
  with tpfibdataset.Create(dm) do begin
    database:=dm.db_gestoras;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select nombre_r_social from clientes cl where cl.id_cliente=:id');
    ParamByName('id').AsInteger := id;
    Open;

    if not(IsEmpty) then Result:=FieldByName('nombre_r_social').asstring
    else result:='';

    Free;
  end;
end;

function Tf_main.BuscaClienteId(codigo:string):Integer;
begin                                       //devuelve id de cliente a partir de codigo
  with tpfibdataset.Create(dm) do begin
    database:=dm.db_gestoras;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select id_cliente from clientes cl where cl.grupo=7 and cl.cliente=:codigo');
    ParamByName('codigo').AsInteger := StrToInt(codigo);
    Open;

    if not(IsEmpty) then Result:=FieldByName('id_cliente').AsInteger
    else result:=-1;

    Free;
  end;
end;


function Tf_main.BuscaCeco(codigo:string):string;
begin                                       //devuelve nombre de ceco a partir de codigo
  with tpfibdataset.Create(dm) do begin
    database:=dm.db_gestoras;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select titulo from cli_cecos c where c.ceco=:codigo and c.id_cliente=:cliente');
    ParamByName('codigo').AsString := codigo;
    ParamByName('cliente').AsInteger := StrtoInt(edIdCliente.Text);
    Open;

    if not(IsEmpty) then Result:=FieldByName('titulo').asstring
    else result:='';

    Free;
  end;
end;

function Tf_main.BuscaCecoPorId(id:integer):string;
begin                                       //devuelve nombre de ceco a partir de id
  with tpfibdataset.Create(dm) do begin
    database:=dm.db_gestoras;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select nombre from cli_cecos c where c.id_cli_ceo=:id');
    ParamByName('id').AsInteger := id;
    Open;

    if not(IsEmpty) then Result:=FieldByName('titulo').asstring
    else result:='';

    Free;
  end;
end;

function Tf_main.BuscaCecoId(codigo:string):Integer;
begin                                       //devuelve id de ceco a partir de codigo
  with tpfibdataset.Create(dm) do begin
    database:=dm.db_gestoras;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select id_cli_ceo from cli_cecos c where c.ceco=:codigo and c.id_cliente=:cliente');
    ParamByName('codigo').AsString := codigo;
    ParamByName('cliente').AsInteger := StrtoInt(edIdCliente.Text);
    Open;

    if not(IsEmpty) then Result:=FieldByName('id_cli_ceo').AsInteger
    else result:=-1;

    Free;
  end;
end;


procedure Tf_main.filter;
var
  x, y, total, uds: Integer;
  total_cl: Double;
  producto:Integer;
begin

   case rgProducto.ItemIndex of
                    0: producto:= 239;  //Carta Ordinaria
                    1: producto:= 240;  //Carta Certificada
                    2: producto:= 325;  //Carta Certificada con AR
   end ;

  //total por producto seleccionado
      uds := 0;
      total_cl := GetTotalClienteProducto(StrToInt(edIdCliente.Text),producto,uds);
      lbTClienteUds.Caption := IntToStr(uds);
      lbTClienteImp.Caption := formatfloat('#,##0.00', total_cl);
      total_cl := GetTotalClientePesoProducto(StrToInt(edIdCliente.Text),20,producto,uds);
      lbT20Uds.Caption := IntToStr(uds);
      lbT20Imp.Caption := formatfloat('#,##0.00', total_cl);
      total_cl := GetTotalClientePesoProducto(StrToInt(edIdCliente.Text),50,producto,uds);
      lbT50Uds.Caption := IntToStr(uds);
      lbT50Imp.Caption := formatfloat('#,##0.00', total_cl);
      total_cl := GetTotalClientePesoProducto(StrToInt(edIdCliente.Text),100,producto,uds);
      lbT100Uds.Caption := IntToStr(uds);
      lbT100Imp.Caption := formatfloat('#,##0.00', total_cl);
      total_cl := GetTotalClientePesoProducto(StrToInt(edIdCliente.Text),500,producto,uds);
      lbT500Uds.Caption := IntToStr(uds);
      lbT500Imp.Caption := formatfloat('#,##0.00', total_cl);
      total_cl := GetTotalClientePesoProducto(StrToInt(edIdCliente.Text),1000,producto,uds);
      lbT1000Uds.Caption := IntToStr(uds);
      lbT1000Imp.Caption := formatfloat('#,##0.00', total_cl);
      total_cl := GetTotalClientePesoProducto(StrToInt(edIdCliente.Text),2000,producto,uds);
      lbT2000Uds.Caption := IntToStr(uds);
      lbT2000Imp.Caption := formatfloat('#,##0.00', total_cl);


     if ((rgTipo.ItemIndex=-1) or (edCeco.Text='') or (edCliente.Text='') or (edIdCeco.Text='') {or (modo=2)})  then
          Exit;

      btLimpiarClick(self);
      total := 0;

      with dm.qfiltro do
      begin
        try
           Close;
           SelectSQL.Clear;
           SelectSQL.add('select uds from m_correos_reports ' +
                         'where id_cliente=:cliente and fecha=:fecha and ' +
                         'id_ceco=:ceco and id_producto=:producto and id_zona=:zona and ' +
                         'peso=:peso');

          for x := 1 to grData.RowCount-1 do
            for y := 1 to grData.ColCount-1 do
            begin
                 Close;

                 ParamByName('cliente').asinteger := StrtoInt(edIdCliente.Text);
                 ParamByName('fecha').AsDateTime := edFecha.Date;
                 ParamByName('ceco').asinteger := edIdCeco.Value;
                 case rgProducto.ItemIndex of
                    0: ParamByName('producto').asinteger := 239;   //Carta Ordinaria
                    1: ParamByName('producto').asinteger := 240;   //Carta Certificada
                    2: ParamByName('producto').asinteger := 325;   //Carta Certificada con AR
                 end;
                 case x of
                    1: ParamByName('zona').asinteger := 1;     //Nacional
                    2: ParamByName('zona').asinteger := 4;     //Nacional D1
                    3: ParamByName('zona').asinteger := 5;     //Nacional D2
                    4: ParamByName('zona').asinteger := 2;     //Int. Europa
                    5: ParamByName('zona').asinteger := 3;     //Int. Resto
                 end;
                 ParamByName('peso').asinteger := StrToInt(grData.Cells[y,0]);
                 open;

                 if not IsEmpty then
                 begin
                       grData.Cells[y,x] := FieldByName('uds').AsString;
                       total := total + FieldByName('uds').AsInteger;
                 end;
            end;

            lbTotal.Caption := IntToStr(total);

        except
           ShowMessage('Error al cargar datos.');
        end;
      end;

end;


function Tf_main.BuscaFranqueoPorFechas(cliente, ceco, peso, producto, zona:integer; f1,f2:TDateTime; out importe:Double):Integer;
begin
  importe := 0;

  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('SELECT id_zona, sum(uds) as uds, sum(r.uds*r.tarifa) as importe FROM m_correos_reports r ' +
                       'WHERE ((r.id_cliente=:cliente) or (:todo_cl=1)) and ' +
                       '      ((r.id_ceco=:ceco) or (:todo_cc=1)) and ' +
                       '      ((r.id_producto=:producto) or (:todo_pr=1)) and ' +
                       '      ((r.id_zona=:zona) or (:todo_zn=1)) and ' +
                       '      ((r.peso=:peso) or (:todo_ps=1)) and ' +
                       '      r.fecha between :f1 and :f2 and estado=''A''' +
                       '      group by id_zona');

    if cliente=-1 then ParamByName('todo_cl').AsInteger := 1;
    if ceco=-1 then ParamByName('todo_cc').AsInteger := 1;
    if producto=-1 then ParamByName('todo_pr').AsInteger := 1;
    if peso=-1 then ParamByName('todo_ps').AsInteger := 1;
    if zona=-1 then ParamByName('todo_zn').AsInteger := 1;

    ParamByName('cliente').AsInteger := cliente;
    ParamByName('ceco').AsInteger := ceco;
    ParamByName('f1').AsDateTime := f1;
    ParamByName('f2').AsDateTime := f2;
    ParamByName('peso').AsInteger := peso;
    ParamByName('producto').AsInteger := producto;
    ParamByName('zona').AsInteger := zona;
    Open;

    if not(IsEmpty) then
    begin
        Result:=FieldByName('uds').AsInteger;
        importe := FieldByName('importe').AsFloat;
    end
    else result:=0;

    Free;
  end;
end;

function Tf_main.BuscaFranqueo(cliente, ceco, peso, producto, zona:integer; fecha:TDateTime):Integer;
begin
   with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select sum(uds) as uds from mv_correos_reports ' +
                       'where id_cliente=:cliente and peso=:peso and id_producto=:producto and ' +
                             'id_ceco=:ceco and fecha=:fecha and id_zona=:zona ');
    ParamByName('cliente').AsInteger := cliente;
    ParamByName('ceco').AsInteger := ceco;
    ParamByName('fecha').AsDateTime := fecha;
    ParamByName('peso').AsInteger := peso;
    ParamByName('producto').AsInteger := producto;
    ParamByName('zona').AsInteger := zona;
    Open;

    if not(IsEmpty) then Result:=FieldByName('uds').AsInteger
    else result:=-1;

    Free;
  end;
end;


function Tf_main.BuscaTarifa(cliente, ceco, peso, producto, zona:integer):Double;
begin
   with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select sum(uds) from m_tarifas_clientes ' +
                       'where id_cliente=:cliente and peso=:peso and id_producto=:producto and ' +
                             'id_ceco=:ceco and fecha=:f1 and id_zona=:zona and estado=''A''');
    ParamByName('cliente').AsInteger := cliente;
    ParamByName('ceco').AsInteger := ceco;
    ParamByName('peso').AsInteger := peso;
    ParamByName('producto').AsInteger := producto;
    ParamByName('zona').AsInteger := zona;
    Open;

    if not(IsEmpty) then Result:=FieldByName('uds').AsInteger
    else result:=-1;

    Free;
  end;
end;

{$ENDREGION 'DATOS'}


procedure Tf_main.lbAlbaranDblClick(Sender: TObject);
begin
  Clipboard.SetTextBuf(pWideChar(lbAlbaran.Caption));
  lbAlbaran.Hint := 'Texto copiado al portapapeles';
  lbAlbaran.ShowHint := True;
end;

procedure Tf_main.lbExpAgenciaDblClick(Sender: TObject);
begin
  Clipboard.SetTextBuf(pWideChar(lbExpAgencia.Caption));
  lbExpAgencia.Hint := 'Texto copiado al portapapeles';
  lbExpAgencia.ShowHint := True;
end;

function Tf_main.get_grupos;
var
  gr_santalucia, gr_gih: integer;
begin
  grupo_santalucia := '';
  grupo_gih := '';

  with dm.q_aux do
  begin
       Close;
       SelectSQL.Clear;
       SelectSQL.Add('select grupo_gih, grupo_santalucia from get_clientes_config(:id)');
       ParamByName('id').AsInteger := 3200;
       Open;

       if not IsEmpty then
       begin
          gr_santalucia := FieldByName('grupo_santalucia').asinteger;
          gr_gih := FieldByName('grupo_gih').asinteger;
       end;
  end;

  with dm.qTempGest do
  begin
      Close;
      SelectSQL.Clear;
      SelectSQL.Add('select id_cliente from clientes where grupo=:grupo');

      ParamByName('grupo').AsInteger := gr_santalucia;
      Open;

      if not IsEmpty then
      begin
        First;
        while not Eof do
        begin
           grupo_santalucia := grupo_santalucia + FieldByName('id_cliente').AsString + ',';
           Next;
        end;
      end;

      Close;
      ParamByName('grupo').AsInteger := gr_gih;
      Open;

      if not IsEmpty then
      begin
        First;
        while not Eof do
        begin
           grupo_gih := grupo_gih + FieldByName('id_cliente').AsString + ',';
           Next;
        end;
      end;

      grupo_santalucia :=  Copy(grupo_santalucia,0,Length(grupo_santalucia)-1);
      grupo_gih :=  Copy(grupo_gih,0,Length(grupo_gih)-1);

  end;
end;
{$REGION 'CERTIFICADA'}

procedure Tf_main.gr1TitleClick(Column: TColumn);
var
  i: integer;
begin
      col_estado := Column.Index;
      filter_estados;
      for I := 0 to gr1.Columns.Count-1 do
        If Column.Index=i then
              gr1.Columns[i].Title.Font.Color := clPurple
        else
              gr1.Columns[i].Title.Font.Color := clBlack;

end;

procedure Tf_main.grCertificadasAfterScroll(Sender: TObject;
  ScrollBar: Cardinal);
begin
   if modo=0 then
   if lbAlbaran.Caption<>'' then
   begin
       RellenaCertificada;
       GetCertEstado(StrToInt(lbAlbaran.Caption));
   end;

end;

procedure Tf_main.grCertificadasCellClick(Column: TColumn);
begin
   if modo=0 then
     RellenaCertificada;
end;

procedure Tf_main.grDataKeyPress(Sender: TObject; var Key: Char);
begin
  if ((Key<>Char(48)) and (Key<>Char(49)) and (Key<>Char(50)) and (Key<>Char(51)) and (Key<>Char(52)) and
      (Key<>Char(53)) and (Key<>Char(54)) and (Key<>Char(55)) and (Key<>Char(56)) and (Key<>Char(57)) and (Key<>Char(8))) then
     raise Exception.Create('Carácter no permitido');
end;

procedure Tf_main.filter_certificadas;
var
  producto, zona: Integer;
begin
   if ((rgTipo.ItemIndex=-1) or (edCeco.Text='') or (edCliente.Text='') or (edIdCeco.Text='') {or (modo=2)})  then
          Exit;

    with dm.qfiltro_certif do
    begin
      try
         Close;
         SelectSQL.Clear;
         SelectSQL.add('select c.* ' +
                       'from mv_correos_certificadas c ' +
                       'where fecha=:fecha and c.id_producto=:producto and c.id_zona=:zona and c.peso=:peso ');

         if StrtoInt(edCliente.Text)>0 then
             SelectSQL.Add(' and c.id_cliente=' + edIdCliente.Text);
         if edIdCeco.Value>0 then
             SelectSQL.Add(' and c.id_ceco=' + edIdCeco.Text);

         if edFiltroTexto.Text<>'' then
            SelectSQL.Add(' and ((c.empresa like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.direccion like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.localidad like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.provincia like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.cp like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.referencia like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.barcode like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.cto_rmt like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.acuse like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.id_cliente=' + CargarDatosTablaGestoras('clientes','id_cliente','cliente=' + edFiltroTexto.Text) + ') or ' +
                                '(c.id_cliente=' + CargarDatosTablaGestoras('clientes','id_cliente','nombre_r_social like ''%' + edFiltroTexto.Text + '%''') + ') or ' +
                                '(c.id_ceco=' + CargarDatosTablaGestoras('cli_cecos','id_cli_ceo','ceco like ''%' + edFiltroTexto.Text + '%''') + ') or ' +
                                '(c.id_ceco=' + CargarDatosTablaGestoras('cli_cecos','id_cli_ceo','titulo like ''%' + edFiltroTexto.Text + '%''') + ') or ' +
                                '(c.prod_nom like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.zona_nom like ''%' +  edFiltroTexto.Text + '%'' ) ' +
                                ')');

         case rgProdCert.ItemIndex of
                    0: ParamByName('producto').asinteger := 240;   //Carta Certificada
                    1: ParamByName('producto').asinteger := 325;   //Carta Certificada con AR
                 end;

         case rgZona.ItemIndex of
            0: ParamByName('zona').asinteger := 1;     //Nacional
            1: ParamByName('zona').asinteger := 4;     //Nacional D1
            2: ParamByName('zona').asinteger := 5;     //Nacional D2
            3: ParamByName('zona').asinteger := 2;     //Int. Europa
            4: ParamByName('zona').asinteger := 3;     //Int. Resto
         end;

         ParamByName('peso').asinteger := StrToInt(rgPeso.Items[rgPeso.ItemIndex]);
         ParamByName('fecha').AsDateTime := edFecha.Date;

         Open;

         First;
         if not eof then
          RellenaCertificada
         else
          VaciaCertificada;

         lbLineas.Caption := IntToStr(RecordCount) + ' líneas.';

         lbFrEnc.Caption := 'Encontrado ' +  IntToStr(BuscaFranqueo(StrtoInt(edIdCliente.Text),edIdCeco.Value,StrToInt(rgPeso.Items[rgPeso.ItemIndex]),
                                                      FieldByName('id_producto').AsInteger, FieldByName('id_zona').AsInteger, edFecha.Date)) + ' franqueos.';


         lbFrEnc.font.Color := clRed;
      except
         ShowMessage('Error al cargar datos.');
      end;
    end;
end;

procedure Tf_main.RellenaCertificada;
begin
    edIdCert.Text := dm.qfiltro_certif.FieldByName('id_correos_certificadas').AsString;
    edEmpresa.Text := dm.qfiltro_certif.FieldByName('empresa').AsString;
    edDireccion.Text := dm.qfiltro_certif.FieldByName('direccion').AsString;
    edLocalidad.Text := dm.qfiltro_certif.FieldByName('localidad').AsString;
    edProvincia.Text := dm.qfiltro_certif.FieldByName('provincia').AsString;
    edCP.Text := dm.qfiltro_certif.FieldByName('cp').AsString;
    edPais.Text := dm.qfiltro_certif.FieldByName('pais').AsString;
    edReferencia.Text := dm.qfiltro_certif.FieldByName('referencia').AsString;
    edCtoRmt.Text := dm.qfiltro_certif.FieldByName('cto_rmt').AsString;

    if edCP.Text<>'' then
    begin
      RellenaComboCP(edCP.Text);
      cbCP.ItemIndex := cbCP.IndexOf(edLocalidad.Text)
    end else
            cbCP.Clear;

    if ((cbCP.ItemIndex=-1) and (edLocalidad.Text<>'')) then cbCP.Text := edLocalidad.Text;

    if not dm.qfiltro_certif.IsEmpty then
    begin
      edAlto.Text := dm.qfiltro_certif.FieldByName('alto').AsString;
      edAncho.Text := dm.qfiltro_certif.FieldByName('ancho').AsString;
      edLargo.Text := dm.qfiltro_certif.FieldByName('largo').AsString;
      rgSobre.ItemIndex := dm.qfiltro_certif.FieldByName('idx_sobre').AsInteger;
    end;

    if dm.qfiltro_certif.FieldByName('peso').AsString<>'' then
    begin
        rgPeso.ItemIndex := rgPeso.Items.IndexOf(dm.qfiltro_certif.FieldByName('peso').AsString);
        edPeso.Text := dm.qfiltro_certif.FieldByName('peso').AsString;
    end;
   { else begin
        rgPeso.ItemIndex := 0;
        edPeso.Text := '20';
    end;    }

    case dm.qfiltro_certif.FieldByName('id_producto').AsInteger of
         240: rgProdCert.ItemIndex := 0;
         325: rgProdCert.ItemIndex := 1;
    end;

    if (dm.qfiltro_certif.FieldByName('gest_albaran').AsString<>'') then
        lbAlbaran.Caption := dm.qfiltro_certif.FieldByName('gest_albaran').AsString
    else if dm.qfiltro_certif.FieldByName('barcode').AsString<>'' then
              lbAlbaran.Caption := dm.qfiltro_certif.FieldByName('barcode').AsString
         else
                lbAlbaran.Caption := '';

    if dm.qfiltro_certif.FieldByName('gest_albaran').asinteger>0 then
       lbExpAgencia.Caption := CargarDatosTablaGestoras('albaranes','expedicion_age','id_albaran='+dm.qfiltro_certif.FieldByName('gest_albaran').AsString)
    else
       lbExpAgencia.Caption := '';

    GetCertEstado(dm.qfiltro_certif.FieldByName('gest_albaran').AsInteger);
end;


procedure Tf_main.filter_estados;
var
  producto, zona: Integer;
begin
    with dm.qfiltro_estados do
    begin
      try
         Close;
         SelectSQL.Clear;
         SelectSQL.add('select e.* ' +
                       'from m_correos_certificadas_estados e ' +
                       'inner join mv_correos_certificadas c on e.id_correos_certificada=c.id_correos_certificadas ' +
                       'where 1=1 ');

         if not chEstFTodas.Checked then
         begin
            SelectSQL.Add('and e.fecha between :ini and :fin ');
            ParamByName('ini').AsDateTime := edEstFDesde.Date;
            ParamByName('fin').AsDateTime := edEstFHasta.Date;
         end;

         if not chEstClTodos.Checked then
                 SelectSQL.Add(' and c.id_cliente=' + edIdCliente.Text);

         if not chEstCCTodos.Checked then
                 SelectSQL.Add(' and c.id_ceco=' + edIdCeco.Text);

         if edFiltroTexto.Text<>'' then
            SelectSQL.Add(' and ((e.referencia like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(e.estado like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(e.linea like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.empresa like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.direccion like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.localidad like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.provincia like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.cp like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.referencia like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.barcode like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.cto_rmt like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.acuse like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.id_cliente=' + CargarDatosTablaGestoras('clientes','id_cliente','cliente=' + edFiltroTexto.Text) + ') or ' +
                                '(c.id_cliente=' + CargarDatosTablaGestoras('clientes','id_cliente','nombre_r_social like ''%' + edFiltroTexto.Text) + '%'') or ' +
                                '(c.id_ceco=' + CargarDatosTablaGestoras('cli_cecos','id_cli_ceo','ceco like ''%' + edFiltroTexto.Text) + '%'') or ' +
                                '(c.id_ceco=' + CargarDatosTablaGestoras('cli_cecos','id_cli_ceo','titulo like ''%' + edFiltroTexto.Text) + '%'') or ' +
                                '(c.prod_nom like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.zona_nom like ''%' +  edFiltroTexto.Text + '%'' ) ' +
                                ')');

        { case col_estado of
            0: SelectSQL.Add(' order by e.'+ gr1.Columns[col_estado].Title.Caption );
            1: SelectSQL.Add(' order by e.referencia');
            2: SelectSQL.Add(' order by e.estado');
         end;                  }

         SelectSQL.Add(' order by e.'+ gr1.Columns[col_estado].Title.Caption );

         Open;

      except
         ShowMessage('Error al cargar datos.');
      end;
    end;
end;


procedure Tf_main.VaciaCertificada;
begin
    edIdCert.Text := '';
    //edCeco.text:='';
    //lbCeco.caption:='(Seleccione un CECO válido)';
    //edIdCeco.Text := '';

    edEmpresa.Text := '';
    edDireccion.Text := '';
    edLocalidad.Text := '';
    edProvincia.Text := '';
    edCP.Text := '';
    edPais.Text := 'ES';
    edReferencia.Text := '';
    edCtoRmt.Text := '';
    //edPeso.Text := '';
    if rgSobre.ItemIndex=3 then
    begin
         edAlto.Text := '';
         edAncho.Text := '';
         edLargo.Text := '';
    end;

    lbCertEstado.Caption := '(Sin estado)';
    lbAlbaran.Caption := '(Albarán)';

end;

procedure Tf_main.GetMedidasSobre;
begin
  with TpFIBDataSet.Create(dm) do
  try
     Database := dm.db;
     Close;
     SelectSQL.Add('select * from m_correos_sobres(' + IntToStr(rgSobre.ItemIndex) + ')');
     Open;

     edAlto.Value := FieldByName('alto').AsFloat;
     edAncho.Value := FieldByName('ancho').AsFloat;
     edLargo.Value := FieldByName('largo').AsFloat;

  finally
     Free;
  end;
end;

procedure Tf_main.GetCertEstado(id:Integer);
begin
  with TpFIBDataSet.Create(dm) do
  try
     Database := dm.db_gestoras;
     Close;
     SelectSQL.Add('select first 1 descripcion from alb_tracking where id_albaran=:id order by id_tracking desc ');
     ParamByName('id').AsInteger := id;
     Open;

     if not IsEmpty then
          lbCertEstado.Caption := FieldByName('descripcion').AsString
     else
          lbCertEstado.Caption := '(Sin estado)';
  finally
     Free;
  end;
end;

procedure Tf_main.ActualizaLogFile(ids, nombre:string);
begin
    with dm.q_1 do
      begin
        try
           dm.t_write.StartTransaction;

           Close;
           SQL.Clear;

           sql.add('update m_correos_certificadas set ' +
                   'file_date=:fecha, file_name=:nombre, file_path=:path ' +
                   'where id_correos_certificadas in (' + Copy(ids,0, Length(ids)-1) + ')');

           Close;

           ParamByName('fecha').AsDateTime := Now;
           ParamByName('nombre').AsString := ExtractFileName(nombre);
           ParamByName('path').AsString := ExtractFilePath(nombre);

           execquery;

           dm.t_write.CommitRetaining;
           //ShowMessage('Datos guardados correctamente.');

        except
           dm.t_write.RollbackRetaining;
           raise Exception.Create('Error al actualizar log del fichero.');
        end;
      end;


end;

function Tf_main.CalculaBarcode:string;
begin
  with TpFIBDataSet.Create(dm) do
  try
     Database := dm.db;
     Close;
     SelectSQL.Add('select * from m_get_cont_cert ');

     //ParamByName('ini').AsInt64 := bc_ini;
    // ParamByName('fin').AsInt64 := bc_fin;
     Open;

     if FieldByName('dif').AsInteger<=100 then
         ShowMessage('Quedan ' + IntToStr(FieldByName('dif').AsInteger) + ' etiquetas.');

     if FieldByName('cont').AsString='' then
          result := StringOfChar('0',11-length(IntToStr(bc_ini))) + IntToStr(bc_ini)
     else
          result := StringOfChar('0',11-length(FieldByName('cont').AsString)) + FieldByName('cont').AsString;


  finally
     Free;
  end;
end;


procedure Tf_main.CargarLimiteCertificadas;
begin
  with TpFIBDataSet.Create(dm) do
  try
     Database := dm.db;
     Close;
     SelectSQL.Add('select cont_correos_cert_min as min, cont_correos_cert_max as max from c_agencias_aux ');
     Open;

     if FieldByName('min').AsString='' then
          edMinCert.Value := FieldByName('min').AsLargeInt;
     if FieldByName('max').AsString='' then
          edMaxCert.Value := FieldByName('max').AsLargeInt;
  finally
     Free;
  end;
end;

{$ENDREGION 'CERTIFICADA'}

{$region 'TXT CORREOS'}
procedure Tf_main.vuelcaInformacion(Sender: TObject);
var
  i, peso, cont, etapa: integer;
  codigos: TStringList;
  leido, ProdOk: Boolean;
  inicio,fin: TDateTime;
begin
    leido := False;
    cont := 0;

    try
     etapa := 0;
     etapa := 1;
     // Vuelca de BBDD
     if(dtDesde.Date=EncodeDate(1899, 12, 30)) or (dthasta.Date=EncodeDate(1899, 12, 30)) then
      begin
       ShowMessage('Introduce una fecha válida');
       Exit;
      end
     else
      begin
       inicio:=dtDesde.date;
       fin:=dthasta.Date;
      end;
      cds.EmptyDataSet;
     with dm.qryCDS do
      begin
       Close;
       SQLs.SelectSQL.Text:='select * from mv_correos_reports rep where fecha between :ini and :fin and uds>0';
       ParamByName('ini').AsDate:= inicio;
       ParamByName('fin').AsDate:= fin;
       Open;
       while not eof do
        begin
         cds.Insert;
         cds.FieldByName('CLIENTE').AsString := CargarDatosTablaGestoras('clientes','cliente','id_cliente='+FieldByName('id_cliente').AsString);
         dm.qryProdCorr.Close;
         dm.qryProdCorr.SelectSQL.Text:='select * from m_correos_productos where id_corr_prod=(select id_corr_prod from m_correos_prod_general where id_santa_lucia=:santa and id_zona=:zona)';
         if(FieldByName('id_producto').AsInteger=325) then
          dm.qryProdCorr.ParamByName('santa').asInteger:= 240
         else dm.qryProdCorr.ParamByName('santa').asInteger:= FieldByName('id_producto').AsInteger;
         dm.qryProdCorr.ParamByName('zona').asInteger:=FieldByName('id_zona').AsInteger;
         dm.qryProdCorr.Open;
         if( not dm.qryProdCorr.Eof) then
          begin
           cds.FieldByName('PRODUCTO').ASString := dm.qryProdCorr.FieldByName('COD_PRODUCTO').AsString;
           cds.FieldByName('NACIONAL').ASString := dm.qryProdCorr.FieldByName('cod_nacional').AsString;
           cds.FieldByName('DESTINO').ASString :=dm.qryProdCorr.FieldByName('cod_destino').AsString;
           cds.FieldByName('ANEXO').ASString :=dm.qryProdCorr.FieldByName('cod_anexo').AsString;
          end;
          cds.FieldByName('REFERENCIA').AsString := FieldByName('fecha').AsString;
         {IF( FieldByName('referencia').AsString='') then
           cds.FieldByName('REFERENCIA').AsString := FieldByName('fecha').AsString
          else  cds.FieldByName('REFERENCIA').AsString := FieldByName('referencia').AsString;
          if(FieldByName('reembolso').AsString='0') then
           cds.FieldByName('MODALIDAD').ASString := ''
          else cds.FieldByName('MODALIDAD').ASString := FieldByName('reembolso').AsString;
          if( FieldByName('acuse').AsString='0') then
           cds.FieldByName('VALOR').ASString :=''
          else cds.FieldByName('VALOR').ASString := FieldByName('acuse').AsString;
          }
          if(FieldByName('id_producto').AsInteger=325) then
           begin
            if((FieldByName('id_zona').AsInteger=1) or (FieldByName('id_zona').AsInteger=4) or (FieldByName('id_zona').AsInteger=5)) then   cds.FieldByName('VALOR').ASString :='3000'
            else  cds.FieldByName('VALOR').ASString :='3010';
           end
          else cds.FieldByName('VALOR').ASString :='';
          cds.FieldByName('PESO').ASString := FieldByName('peso').AsString;
          cds.FieldByName('ENVIOS').AsInteger :=FieldByName('uds').asInteger;
          cds.Post;
          next;
        end;
      end;
    except
//   On E : Exception do ShowMessage(E.Message + IntToStr(etapa));
     ShowMessage('Ocurrió un error');
    end;

end;
procedure Tf_main.GenerarTXT;
var
  i, acum, cont: integer;
  codigos: TStringList;
  mensaje,anx_actual, prd_actual, cl_actual, linea, nac_actual, peso_actual, mod_actual, ref_actual: string;
  cabecera: Boolean;
  inicio,fin :TDateTime;
begin
  // ESCRIBE TXT
    try
     mensaje:='';
      acum := 2;
      cont := 0;

      if cds.RecordCount>=1 then
      begin
        cds.First;

        CreaTXTSDA(FormatDateTime('yyyymmdd_hhnnss',Now)+'_',cds.FieldByName('PRODUCTO').ASString,'0');

        anx_actual := cds.FieldByName('ANEXO').AsString;
        prd_actual := cds.FieldByName('PRODUCTO').AsString;
        cl_actual := cds.FieldByName('CLIENTE').AsString;
        nac_actual := cds.FieldByName('NACIONAL').AsString;
        peso_actual := cds.FieldByName('PESO').AsString;
        mod_actual := cds.FieldByName('MODALIDAD').AsString;
        ref_actual := cds.FieldByName('REFERENCIA').AsString;

        linea := '0' + tab + anx_actual + tab + prd_actual;
        Writeln(txt,linea);
        cabecera := True;

        for i := 0 to cds.RecordCount - 1 do
        begin

          //Criterios para cambiar de fichero
          If (((anx_actual=cds.FieldByName('ANEXO').AsString) and (prd_actual=cds.FieldByName('PRODUCTO').AsString) and
               (cds.FieldByName('PRODUCTO').AsString<>'2283')) or

              ((anx_actual=cds.FieldByName('ANEXO').AsString) and (prd_actual=cds.FieldByName('PRODUCTO').AsString) and
              (cds.FieldByName('PRODUCTO').AsString='2283') and (peso_actual=cds.FieldByName('PESO').AsString)) or

              ((anx_actual=cds.FieldByName('ANEXO').AsString) and (prd_actual=cds.FieldByName('PRODUCTO').AsString) and
              (cds.FieldByName('PRODUCTO').AsString='2283') and (nac_actual=cds.FieldByName('NACIONAL').AsString))) then
          begin
             if cabecera then
             begin
                 InsertaCabecera(cl_actual);
                 cabecera := False;

                 InsertaModalidad;
             end;

             //Criterios para cambiar de albarán
             if ((cl_actual=cds.FieldByName('CLIENTE').AsString) and (nac_actual=cds.FieldByName('NACIONAL').AsString) and
                 (mod_actual=cds.FieldByName('MODALIDAD').AsString) and (ref_actual=cds.FieldByName('REFERENCIA').AsString)) then
             begin
                 InsertaEnvioYValor;
                 cds.Next;
             end else
             begin
                 linea := '-1' + tab + ref_actual + tab + cl_actual + tab + Matricula;
                 Writeln(txt,linea);

                 anx_actual := cds.FieldByName('ANEXO').AsString;
                 prd_actual := cds.FieldByName('PRODUCTO').AsString;
                 cl_actual := cds.FieldByName('CLIENTE').AsString;
                 nac_actual := cds.FieldByName('NACIONAL').AsString;
                 peso_actual := cds.FieldByName('PESO').AsString;
                 mod_actual := cds.FieldByName('MODALIDAD').AsString;
                 ref_actual := cds.FieldByName('REFERENCIA').AsString;

                 InsertaCabecera(cl_actual);
                 InsertaModalidad;
                 InsertaEnvioYValor;
                 cds.Next;
             end;
          end
          else
          begin
            linea := '-1' + tab + ref_actual + tab + cl_actual + tab + matricula;
            Writeln(txt,linea);
            CloseFile(txt);

            if (cds.FieldByName('ANEXO').ASString=anx_actual) and (cds.FieldByName('PRODUCTO').ASString=prd_actual) then
            begin
                CreaTXTSDA(FormatDateTime('yyyymmdd_hhnnss',Now)+'_',cds.FieldByName('PRODUCTO').ASString,IntToStr(acum));
                Inc(acum);
            end
            else
            begin
                CreaTXTSDA(FormatDateTime('yyyymmdd_hhnnss',Now)+'_',cds.FieldByName('PRODUCTO').ASString,'0');
                acum := 2;
            end;

            anx_actual := cds.FieldByName('ANEXO').AsString;
            prd_actual := cds.FieldByName('PRODUCTO').AsString;
            cl_actual := cds.FieldByName('CLIENTE').AsString;
            nac_actual := cds.FieldByName('NACIONAL').AsString;
            peso_actual := cds.FieldByName('PESO').AsString;
            mod_actual := cds.FieldByName('MODALIDAD').AsString;
            ref_actual := cds.FieldByName('REFERENCIA').AsString;

            linea := '0' + tab + anx_actual + tab + prd_actual;
            Writeln(txt,linea);

            InsertaCabecera(cl_actual);
            InsertaModalidad;
            InsertaEnvioYValor;
            cds.Next;
          end;
          Inc(cont);
        end;

        linea := '-1' + tab + ref_actual + tab + cl_actual + tab + Matricula;
        Writeln(txt,linea);

        CloseFile(txt);
      end;
        inicio:=dtDesde.date;
        fin:=dthasta.Date;
     { with dm.qrySinReferencia do
       begin
        SQLs.SelectSQL.Text:='select count(*) as contador from m_correos_reports where fecha between :ini and :fin and uds>0 ';
        ParamByName('ini').AsDate:= inicio;
        ParamByName('fin').AsDate:= fin;
        Open;
        if(FieldByName('contador').AsInteger>0) then
         mensaje:=' Existen productos sin equivalencia para correos. Avisad a Dpto. Informática';
        end;
      }
      codigos.Free;
      MessageDlg('Fichero TXT generado con éxito.'+Mensaje,mtInformation,[mbOk],0);
    except
          MessageDlg('Error generando TXT.'+Mensaje,mtError,[mbOk],0);
    end;
end;

procedure Tf_main.InsertaCabecera(cliente:string);
var
linea: string;
begin
 linea := '1' + tab + cds.FieldByName('REFERENCIA').AsString + tab + cliente + tab + Matricula + tab + cds.FieldByName('NACIONAL').AsString + tab + tab;
 Writeln(txt,linea);
end;

procedure Tf_main.InsertaEnvioYValor;
var
linea,norma, clasificacion: string;
begin
if cds.FieldByName('PESO').AsString='20' then norma := '1' else norma := '0';
if cds.FieldByName('NACIONAL').AsString='0' then clasificacion := '1' else clasificacion := '0';
//PARA ORDINARIAS
if ((cds.FieldByName('PRODUCTO').AsString='2010') AND (cds.FieldByName('NACIONAL').AsString='0')) then clasificacion := '2';
//PARA CERTIFICADAS
if ((cds.FieldByName('PRODUCTO').AsString='2015') AND (cds.FieldByName('NACIONAL').AsString='0')) then clasificacion := '3';
linea := '3' + tab + cds.FieldByName('PESO').AsString + tab + norma + tab + tab + cds.FieldByName('DESTINO').AsString + tab + clasificacion + tab + cds.FieldByName('ENVIOS').AsString;
Writeln(txt,linea);
if cds.FieldByName('VALOR').AsString<>'' then
 begin
  linea := '4' + tab + cds.FieldByName('VALOR').AsString + tab;
  Writeln(txt,linea);
 end;
end;

procedure Tf_main.InsertaModalidad;
var
  linea: string;
begin
  if cds.FieldByName('MODALIDAD').AsString <> '' then
  begin
    linea := '2' + tab + cds.FieldByName('MODALIDAD').AsString;
    Writeln(txt, linea);
  end;
end;

procedure Tf_main.CreaTXTSDA(nombre, producto,orden:string);
begin
   if edtTXT.Text='' then
   begin
          MessageDlg('Debe introducir un directorio destino.', mtInformation, [mbOK],0);
          Exit;
   end;

   if not DirectoryExists(edtTXT.text) then
   begin
          MessageDlg('No existe el directorio destino.', mtInformation, [mbOK],0);
          Exit;
   end;

   case StrToInt(producto) of
      2010: nombre := nombre + 'ORDINARIAS';
      2015: nombre := nombre + 'CERTIFICADAS';
      2016: nombre := nombre + 'NOTIFICACIONES';
      2025: nombre := nombre + 'CARTA_URG_CERT';
      2021: nombre := nombre + 'CARTA_URG_NAC';
      2022: nombre := nombre + 'CARTA_URG_INT';
      2026: nombre := nombre + 'CUI';
      2100: nombre := nombre + 'LIBROS_INT_AV';
      2110: nombre := nombre + 'LIBROS_INT_SUP';
      2120: nombre := nombre + 'LIBROS_NAC';
      2130: nombre := nombre + 'LIBROS_INT';
      2140: nombre := nombre + 'PAQ_AZUL';
      2150: nombre := nombre + 'PAQ_POSTAL_INT_PRI';
      2160: nombre := nombre + 'PAQ_POSTAL_INT_ECO';
      2170: nombre := nombre + 'PAQ_POSTAL_NAC';
      2210: nombre := nombre + 'P_SUSCRIPTORES_INT_AV';
      2230: nombre := nombre + 'P_SUSCRIPTORES_INT_SUP';
      2240: nombre := nombre + 'PERIODICO_NAC';
      2242: nombre := nombre + 'PERIODICO_INT';
      2241: nombre := nombre + 'PERIODICO_TEMP';
      2250: nombre := nombre + 'PUBL_POLIT_SIND_NAC';
      2251: nombre := nombre + 'PUBL_POLIT_INT_SUP';
      2252: nombre := nombre + 'PUBL_POLIT_INT_AV';
      2260: nombre := nombre + 'POSTAL_EXPRESS_INT';
      2270: nombre := nombre + 'POSTAL_EXPRESS_NAC';
      2253: nombre := nombre + 'PUBL_POLIT_INT';
      2283: nombre := nombre + 'PUBLICORREO';
      2286: nombre := nombre + 'IMPRESO_SIN_DIRECC';
      else
            nombre := nombre;
   end;

   if orden<>'0' then
        nombre := nombre + '_' + orden;

   AssignFile(txt,edtTXT.Text+ '\' + nombre + '.txt');
   Rewrite(txt);
end;
{$ENDREGION}

{$REGION 'API'}

procedure Tf_main.registro_y_etiqueta(id_albaran, id_dest:integer);
begin

   if not tiene_etiquetas(id_albaran) then
   begin
          {  if CargarDatosTablaGestoras('agencias','lstname_etiqueta','agencia=4')='ETI_LOGINSER' then
               imprime_etiqueta_loginser
            else   }
               imprime_etiqueta_x_api(id_albaran, id_dest);
   end;

end;


procedure Tf_main.imprime_etiqueta_x_api(id_albaran, id_dest:integer);
var
    tracking, error:string;
    texto: string;

begin
        try
            if get_albaran_data('expedicion_age',id_albaran)='' then
            begin
              if id_albaran>0 then
              begin
                //DMCreaBultos.GeneraBultos(id_albaran,id_dest);
                dm.t_write_gestoras.StartTransaction;
                try
                  u_cam_gl.inserta_etiq_tmp(id_usuario,id_albaran);
                  dm.t_write_gestoras.Commit;
                except
                  dm.t_write_gestoras.Rollback;
                end;

                If ValidaAlbaran(IntToStr(id_albaran),texto)  then
                begin
                  DMLstEtiquetas.ObtenEtiquetas('A',IntToStr(id_albaran),True);
                  lbExpAgencia.Caption := get_albaran_data('expedicion_age',id_albaran);
                  if texto<>'' then
                      ShowMessage(texto);
                end;
              end;
            end else
                    DMLstEtiquetas.ObtenEtiquetas('A',IntToStr(id_albaran),True);

          //Imprimir más de una
          {  DMCreaBultos.GeneraBultos(dm.q_peds.FieldByName('codalbaran').AsInteger,dm.q_peds.FieldByName('gestoras_dest').AsInteger);

            error := u_cam_gl.inserta_etiq_tmp(id_usuario,dm.q_peds.FieldByName('codalbaran').AsInteger);

            if error<>'' then
            begin
               imprime_etiq_tmp(u_main.id_usuario);
            end;      }
        except
             raise Exception.Create('Error generando bultos.');
        end;
end;

{$ENDREGION 'API'}

{$REGION 'XLS'}

procedure Tf_main.AbreFichero(nombre:string);
begin

   Excel:=CreateOleObject('Excel.Application');
   try
     Excel.Visible := False;
     Excel.DisplayAlerts:= False;
     Excel.WorkBooks.Open(nombre);//fichero que queremos leer
   except
     Excel.Quit ;
     Excel := Unassigned;
   end;
end;

Procedure Tf_main.CreaExcel;
begin
    excel:=CreateOleObject('Excel.Application');
  try
   excel.Visible := False;
   excel.DisplayAlerts:= False;
   excel.WorkBooks.add;
   except
     excel.Quit ;
     excel := Unassigned;
   end;

end;



{$ENDREGION 'XLS'}

{$REGION 'GESTORAS'}




function Tf_main.genera_albaranes(pedidos:string):Boolean;
var
  id_albaran,codservicio,codmovimiento,ruta,bultos, error, id_destino:integer;
  s, peds_generados:string;
  kgs:double;
  titulo_error, texto, error_exe: string;
begin
  if ((not chTodosCl.Checked) and ( not (StrtoInt(edCliente.Text)>0))) then
      raise Exception.Create('Debe indicar un cliente o seleccionar todos.');

  if ((not chTodosCC.Checked) and ( not (edIdCeco.Value>0))) then
      raise Exception.Create('Debe indicar un CECO o seleccionar todos.');

  error_exe := '';
  Result := True;

  dm.q_aux.close;                                                 //recoge pedidos
  dm.q_aux.SelectSQL.clear;
  dm.q_aux.SelectSQL.Add('select * from mv_correos_certificadas where fecha=:fecha and gest_albaran is null ' +
                         ' and id_cliente in (461097,461098,461099,461100,461101,461102,461106)');   //Solo GIH (3205 a 3211)
  dm.q_aux.Open;

  Result := not dm.q_aux.IsEmpty;

  dm.q_aux.First;

  if not (dm.q_aux.IsEmpty) then
  begin
    dm.t_write.StartTransaction;
    dm.t_write_gestoras.StartTransaction;

    try

      while not(dm.q_aux.Eof) do begin

           try
            dm.stpGrabaAlb.Database := dm.db_gestoras;
            dm.stpGrabaAlb.SQL.Clear;
            dm.stpGrabaAlb.SQL.Add('execute procedure crea_albaran_certificada(:id_cert)');
            dm.stpGrabaAlb.ParamByName('id_cert').Value:= edIdCert.Value;
            dm.stpGrabaAlb.ExecProc;
            dm.t_write_gestoras.CommitRetaining;

            error := dm.stpGrabaAlb.ParamByName('error').Value;
            titulo_error := dm.stpGrabaAlb.ParamByName('titulo_error').Value;
            id_albaran := dm.stpGrabaAlb.ParamByName('id_albaran').Value;
            id_destino := dm.stpGrabaAlb.ParamByName('id_albaran_det').Value;
           except on E:Exception do
                  begin
                   error_exe := 'Error creando albaranes. ' + titulo_error;
                   result := False;
                   dm.t_write.RollbackRetaining;
                   raise;
                  end;
           end;

        if error=0 then
        begin
            try
              dm.q_1.Database := dm.db;
              dm.q_1.Close;
              dm.q_1.sql.Clear;
              dm.q_1.sql.Add('update c_pedidos set codalbaran=:albaran, gestoras_dest=:dest where id_pedido=:pedido');
              dm.q_1.ParamByName('albaran').AsInteger:= id_albaran;
              dm.q_1.ParamByName('dest').AsInteger:= id_destino;
              dm.q_1.ParamByName('pedido').AsInteger:= dm.q_aux.FieldByName('id_pedido').AsInteger;
              dm.q_1.ExecQuery;
              dm.t_write.CommitRetaining;
            except on E:Exception do
                begin
                 error_exe := 'Error actualizando albaranes en pedidos.';
                 result := False;
                 dm.t_write.RollbackRetaining;
                 raise;
                end;
            end;
        end else begin
                   result := False;
                   raise Exception.Create(titulo_error);
        end;

        dm.q_aux.Next;
      end;

      dm.t_write.Commit;
      dm.t_write_gestoras.Commit;

    except
      dm.t_write.rollback;
      dm.t_write_gestoras.Rollback;
      result := False;
      ShowMessage(error_exe);
    end;
  end;
end;

function Tf_main.tiene_etiquetas(codalbaran: Integer):Boolean;
begin

   result := (CargarDatosTablaGestoras('albaranes','expedicion_age','id_albaran='+IntToStr(codalbaran))<>'');

end;

{$ENDREGION 'GESTORAS'}

{$REGION 'FUNCTIONS'}

function TF_main.busca_en_clientes(id:integer):integer;
var
  i: Integer;
  enc: Boolean;
begin
  i:= -1;
  enc := False;
  while not enc do
  begin
     Inc(i);
     enc := clientes[i].id = id;
  end;

  Result := i;
end;

function TF_main.busca_en_cecos(id:integer):integer;
var
  i: Integer;
  enc: Boolean;
begin
  i:= -1;
  enc := False;
  while not enc do
  begin
     Inc(i);
     enc := cecos[i].id = id;
  end;

  Result := i;
end;


{$ENDREGION 'FUNCTIONS'}
end.

