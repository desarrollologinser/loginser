unit u_detail;

interface

uses
  System.SysUtils, System.Variants, System.Classes, System.Math,
  Vcl.Controls, Vcl.Forms, system.Types,
  Vcl.StdCtrls, sComboBox, Vcl.Buttons, sBitBtn, sEdit, sGroupBox,
  system.AnsiStrings, sLabel,StrUtils, IdHTTP,
  sSpeedButton, IdMultipartFormData,
  NxGrid6,pFIBDataSet, system.json,
  Data.DB, Winapi.ShellAPI, Winapi.Windows, pFIBQuery,
  Datasnap.DBClient, frxClass, frxDBSet,  NxColumns6,
  NxCustomGrid6, Vcl.Mask, sMaskEdit, sCustomComboEdit,sdialogs,dialogs,
  Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, sMemo, sToolEdit, sButton,
  acPNG, Vcl.ExtCtrls, acImage, sCheckBox, NxGridView6, NxControls6,
  NxVirtualGrid6, dxGDIPlusClasses, Vcl.DBCtrls, JvDBControls, sDBEdit,
  Vcl.Clipbrd, sSpinEdit, Vcl.ComCtrls, Vcl.Graphics,
  frxChBox, sPageControl, Winapi.MMSystem;

type
  TProcedimiento = procedure;

type
  Tf_detail = class(TForm)
    sGroupBox4: TsGroupBox;
    bt_guardar: TsBitBtn;
    cb_estado: TsComboBox;
    ed_id_pedido: TsEdit;
    ed_id_order: TsEdit;
    ed_nombre: TsEdit;
    ed_dir_1: TsEdit;
    ed_poblacion: TsEdit;
    ed_provincia: TsEdit;
    ed_cp: TsEdit;
    de_fecha_ped: TsDateEdit;
    de_fecha_imp: TsDateEdit;
    ed_codalbaran: TsEdit;
    bt_hoja_pick: TsBitBtn;
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
    intgrfld_pick_dscodalbaran: TIntegerField;
    rep_db_pick: TfrxDBDataset;
    rep_pick_old: TfrxReport;
    ed_telefono: TsEdit;
    ed_email: TsEdit;
    ed_text: TsEdit;
    cb_delivery: TsComboBox;
    ed_order_name: TsEdit;
    cb_repartidor: TsComboBox;
    ed_tracking: TsEdit;
    bt_print_eti: TsBitBtn;
    ed_bultos: TsEdit;
    strngfld_pick_dsdeliv_time: TStringField;
    rgTransporte: TsRadioGroup;
    edPDF: TsFilenameEdit;
    bt_pdf: TsBitBtn;
    btLoadFile: TsBitBtn;
    lbPath: TsLabel;
    btFinPedido: TsBitBtn;
    lbTag: TsLabel;
    edPais: TsEdit;
    lbCancelado: TsLabel;
    edCodPais: TsEdit;
    btDelEtiq: TsBitBtn;
    lbfinancial_status: TsLabel;
    lbfulfillment_status: TsLabel;
    devo_nac: TfrxReport;
    devo_int: TfrxReport;
    strngfld_pick_dsCodPais: TStringField;
    strngfld_pick_dsTag: TStringField;
    ar_pick_dsEsDevo: TSmallintField;
    edCompany: TsEdit;
    edNote: TsEdit;
    edRecogida: TsEdit;
    edDeleg: TsEdit;
    edKgs: TsEdit;
    rep_pick_2: TfrxReport;
    rep_db_lotes: TfrxDBDataset;
    ar_pick_lotes: TClientDataSet;
    strngfld_pick_lotespedido: TStringField;
    intgrfld_pick_lotesid_art: TIntegerField;
    strngfld_pick_lotesref_art: TStringField;
    strngfld_pick_lotesnom_art: TStringField;
    strngfld_pick_loteslote: TStringField;
    strngfld_pick_lotescaducidad: TStringField;
    intgrfld_pick_lotescantidad: TIntegerField;
    strngfld_pick_dslote: TStringField;
    strngfld_pick_dscaducidad: TStringField;
    intgrfld_pick_dscantidad: TIntegerField;
    rep_pick_lotes: TfrxReport;
    lb3: TsLabel;
    lb4: TsLabel;
    ar_pick_dstiene_lotes: TSmallintField;
    strngfld_pick_dsimei: TStringField;
    rep_pick_imei: TfrxReport;
    lbCli: TsLabel;
    strngfld_pick_dsobservaciones: TStringField;
    ed_obs: TsMemo;
    edCliente: TsEdit;
    strngfld_pick_dsdt_txt: TStringField;
    strngfld_pick_dsagencia_txt: TStringField;
    bt1: TsButton;
    btCliente: TsSpeedButton;
    btSolicEtiq: TsBitBtn;
    rep1: TfrxReport;
    imgRetorno: TsImage;
    chRetorno: TsCheckBox;
    blnfld_pick_dscon_retorno: TBooleanField;
    edContacto: TsEdit;
    strngfld_pick_dscontacto: TStringField;
    cbServicio: TsComboBox;
    cbHorario: TsComboBox;
    strngfld_pick_dsservicio: TStringField;
    strngfld_pick_dshorario: TStringField;
    rep_pick: TfrxReport;
    cdsLines: TClientDataSet;
    cdsLineslinea: TIntegerField;
    cdsLinesid_articulo: TIntegerField;
    cdsLinesreferencia: TStringField;
    cdsLinessku: TStringField;
    cdsLinesnombre: TStringField;
    cdsLinescantidad: TIntegerField;
    cdsLineskgs: TFloatField;
    cdsLinesimei: TStringField;
    dslines: TDataSource;
    lbEstadoGest: TsLabel;
    gest_ico: TImage;
    lgs_ico: TImage;
    edCeco: TsEdit;
    edRefCliente: TsEdit;
    rep_todos: TfrxReport;
    ar_pick_dsSERV_TXT: TStringField;
    ar_pick_dsHORA_TXT: TStringField;
    grp1: TGroupBox;
    lbPick: TsLabel;
    grp2: TGroupBox;
    lbPack: TsLabel;
    grp3: TGroupBox;
    lbExpAgencia: TsLabel;
    edReembolso: TsDecimalSpinEdit;
    imgReemb: TImage;
    edHora: TsEdit;
    de_fecha_gen: TsDateEdit;
    de_fecha_env: TsDateEdit;
    eti_lgs: TfrxReport;
    eti_lgs_copy: TfrxReport;
    sLabel1: TsLabel;
    btRegeneraEtiq: TsBitBtn;
    frdevo: TfrxReport;
    cdsLinesitem_id: TIntegerField;
    strngfld_pick_dspie_hoja_pick: TStringField;
    r2: TfrxReport;
    gbLotes: TsGroupBox;
    lbArtLote: TsLabel;
    gr_1: TJvDBGrid;
    pcDetail: TsPageControl;
    sTabSheet1: TsTabSheet;
    tsExtras: TsTabSheet;
    gbLine: TsGroupBox;
    lb_id_line: TsLabel;
    lb_1: TsLabel;
    bt_save_line: TsBitBtn;
    ed_cantidad: TsEdit;
    gb_2: TsGroupBox;
    lb_sku: TsLabel;
    lb_nombre_art: TsLabel;
    lb_id_art: TsLabel;
    lb_2: TsLabel;
    lb_3: TsLabel;
    lb_4: TsLabel;
    lb_11: TsLabel;
    lb_ref_art: TsLabel;
    lb1: TsLabel;
    lbKgs: TsLabel;
    bt__as_art_entra: TsSpeedButton;
    edIMEI: TsEdit;
    btIMEI: TsBitBtn;
    btCancelLine: TsBitBtn;
    bt_delete: TsBitBtn;
    bt_new: TsBitBtn;
    grLines: TJvDBGrid;
    tsRelacionados: TsTabSheet;
    tsLotes: TsTabSheet;
    lbArtRel: TsLabel;
    edArtRel: TsEdit;
    bpArtRel: TsSpeedButton;
    lb_art_rel: TsLabel;
    nav_art_rel: TJvDBNavigator;
    JvDBGrid1: TJvDBGrid;
    edHGen: TsEdit;
    edHEnv: TsEdit;
    edHImp: TsEdit;
    JvDBGrid2: TJvDBGrid;
    gbExtras: TsGroupBox;
    lbArtExtra: TsLabel;
    JvDBGrid3: TJvDBGrid;
    btAddNSerie: TsSpeedButton;
    btDelNSerie: TsSpeedButton;
    btFicheroMuzy: TsSpeedButton;
    strngfldLinesn_serie: TStringField;
    gbNSerie: TsGroupBox;
    edEanNSerie: TsEdit;
    lbEan: TsLabel;
    edNSerie: TsEdit;
    edIdArtNSerie: TsSpinEdit;
    grLotes: TJvDBGrid;
    cdsLotes: TClientDataSet;
    cds2: TIntegerField;
    cds3: TIntegerField;
    strngfld1: TStringField;
    strngfld2: TStringField;
    strngfld3: TStringField;
    cds4: TIntegerField;
    strngfldLoteslote: TStringField;
    cdsLotescaducidad: TDateField;
    cdsLotesid_lote: TIntegerField;
    dsLotes: TDataSource;
    JvDBGrid5: TJvDBGrid;
    dsStock: TDataSource;
    cdsStock: TClientDataSet;
    cdsLinesid_lote: TIntegerField;
    strngfldLineslote: TStringField;
    cdsLinescaducidad: TDateField;
    gbStockLote: TsGroupBox;
    sSpeedButton1: TsSpeedButton;
    sSpeedButton2: TsSpeedButton;
    JvDBGrid4: TJvDBGrid;
    strngfldStocklote: TStringField;
    cdsStockcaducidad: TDateField;
    cdsStockcantidad: TIntegerField;
    strngfldStockubicacion: TStringField;
    cdsStockid_lote: TIntegerField;
    btAsignaLote: TsSpeedButton;
    lbFileSend: TsLabel;
    gbNSList: TsGroupBox;
    lbNSerieArt: TLabel;
    lbNSCont: TLabel;
    lbNSContTotal: TLabel;
    grNSList: TJvDBGrid;
    bt2: TsBitBtn;
    status: TStatusBar;
    cbAlmacen: TsComboBox;
    chNSerieSelecc: TCheckBox;
    pnMsg: TPanel;
    lbMensaje: TsLabel;
    btMsg1: TsButton;
    btMsg2: TsButton;
    btMsg3: TsButton;
    ch1: TCheckBox;
    chSoloFichero: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure bt_guardarClick(Sender: TObject);
    procedure bt__as_art_entraClick(Sender: TObject);
    procedure bt_save_lineClick(Sender: TObject);
    procedure bt_deleteClick(Sender: TObject);
    procedure read_lines;
    procedure bt_newClick(Sender: TObject);
    procedure save_exp;
    procedure get_line_data;
    function guarda_line:integer;
    procedure bt_hoja_pickClick(Sender: TObject);
    procedure bt_print_etiClick(Sender: TObject);
    procedure rgTransporteChange(Sender: TObject);
    procedure btFinPedidoClick(Sender: TObject);
    procedure bt_pdfClick(Sender: TObject);
    procedure btLoadFileClick(Sender: TObject);
    procedure btDelEtiqClick(Sender: TObject);
    procedure edIMEIKeyPress(Sender: TObject; var Key: Char);
    procedure edClienteChange(Sender: TObject);
    procedure cb_repartidorClick(Sender: TObject);
    procedure bt1Click(Sender: TObject);
    procedure cb_deliveryClick(Sender: TObject);
    procedure btClienteClick(Sender: TObject);
    procedure btIMEIClick(Sender: TObject);
    procedure btSolicEtiqClick(Sender: TObject);
    procedure chRetornoClick(Sender: TObject);
    procedure cbServicioClick(Sender: TObject);
    procedure cbHorarioClick(Sender: TObject);
    procedure grLinesCellClick(Column: TColumn);
    procedure btCancelLineClick(Sender: TObject);
    procedure nav_art_relBeforeAction(Sender: TObject; Button: TNavigateBtn);
    procedure bpArtRelClick(Sender: TObject);
    procedure lbExpAgenciaDblClick(Sender: TObject);
    procedure edReembolsoExit(Sender: TObject);
    procedure grLinesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btRegeneraEtiqClick(Sender: TObject);
    procedure pcDetailChange(Sender: TObject);
    procedure grLinesDblClick(Sender: TObject);
    procedure btAddNSerieClick(Sender: TObject);
    procedure btDelNSerieClick(Sender: TObject);
    procedure btFicheroMuzyClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btImpAdjClick(Sender: TObject);
    procedure edEanNSerieKeyPress(Sender: TObject; var Key: Char);
    procedure edNSerieKeyPress(Sender: TObject; var Key: Char);
    procedure btAsignaLoteClick(Sender: TObject);
    procedure chNSerieSeleccClick(Sender: TObject);
    procedure btMsg1Click(Sender: TObject);
    procedure btMsg3Click(Sender: TObject);
    procedure btMsg2Click(Sender: TObject);
  private
    { Private declarations }
    procedure CargaFichero;
    procedure RellenaRepartidores;
    procedure filter_lotes;
    function check_nserie(nserie:string; nline:integer):Boolean;
    procedure RellenaDeliveryTime(t,cliente,agencia:Integer);
    function CreaJsonImei:TstringList;
    procedure EnviarIMEIaWeb;
    procedure SendEstado(id_order, albaran,estado:string);
    function JSONPostIMEI(text:string):string;
    procedure ActualizaAlbaran(codalbaran:Integer);
    function CreaCadenaIMEI:string;
    function CreaCadenaEstado:string;
    function SendIMEI(text:string):string;
    procedure ActualizaKgs;
    procedure RellenaTipoServicio;
    procedure RellenaHorario(servicio:Integer);
    function BuscaHorarioGestoras(horario,cliente,agencia:integer):string;
    function VerificaHorarioGestoras(horario,cliente,agencia:integer; dt:string):Boolean;
    procedure empty_data_lines;
    procedure habilitar_botones_detalle(estado:Boolean);
    procedure filter_extras;
    function tiene_lote_forzado(id_pedido:Integer):Boolean;
    procedure RellenaAlmacenes;
    procedure ejecuta_comprobacion_articulo(modo,id_articulo:Integer);
    procedure carga_datasets(modo_historico:Boolean);

  public
    { Public declarations }
    function IMEIUtilizado(imei:string; out order_name:string):integer;
    procedure InsertLinePicking(id_art:Integer; ref_art:string; uds:Integer; imei:string; tiene_lotes:integer; lote, caducidad:string; uds_lote,id_ubic: Integer;
                        ubic,articulo,pedido,nomape,direccion,poblacion,provincia,cp,mail,telefono:string; codalbaran:Integer; cod_pais, tag:string;
                        es_devo: Integer; observaciones, agencia_txt, dt_txt, contacto: string; con_retorno:Boolean;
                        servicio, horario:string);
    function art_tiene_imei(id:integer):boolean;
    procedure SolicitarEtiquetaCorreos(fecha:TDateTime;envio:string);
    function EsOtroArticulo(imei:string):Boolean;
    procedure ActualizaAlbaranGestoras(codalbaran:integer);
    procedure LanzaImpresion;
    procedure filter_relaciones;
    procedure imprime_etiqueta_x_api(codalbaran:Integer);
    //procedure imprime_etiqueta_loginser(codalbaran, id_dest:Integer);
    function suma_cantidad_art_en_pedido(id_pedido,id_articulo:integer):integer;
    procedure actualiza_pistoleo;
    procedure CierraFormulario(Sender: TObject);
    function LanzaMensaje(msg, bt1, bt2, bt3: string; ev1, ev2, ev3: TNotifyEvent):string;
    procedure MensajeVisible(estado:Boolean);
  end;

const
  http_estado = '';

var
  f_detail: Tf_detail;
  mode:integer;              //0 = modo edicion    1 = modo nueva     2 = modo reexp
  max_line:integer;
  id_agencia_en_gestoras, id_repartidor_actual, serv_act, hora_act: integer;
  pos_tabc: Integer;
  lote_forzado:Boolean;
  id_pedido_actual: Integer;
  codalbaran_actual, gestdest_actual: integer;
  lines_n_serie_total:Integer=0;
  lines_n_serie_pistoleadas:Integer=0;
  lines_n_serie_total_x_art:Integer=0;
  lines_n_serie_pistoleadas_x_art:Integer=0;
  pdf_act, pais_code_act: string;
  estado_actual:string;

implementation

uses
  u_dm, u_main, ubuscapro, u_orders, u_globals, u_correos, USendText, u_gen_gl,
  u_globals_gestoras,UDMCreaBultos, u_LstEtiquetas, u_cam_gl,
  u_UpdatePedido, u_AlbaranValidate, u_picking, u_functions, u_dmLabels,
  u_muzybar, u_EstadoPedido;

{$R *.dfm}

function Tf_detail.LanzaMensaje(msg, bt1, bt2, bt3: string; ev1, ev2, ev3: TNotifyEvent):string;
begin

    lbMensaje.Caption := msg;

    if bt1<>'' then
    begin
        btMsg1.Caption := bt1;
        btMsg1.OnClick := ev1;
        btMsg1.Visible := True;
    end else
           btMsg1.Visible := False;

    if bt2<>'' then
    begin
        btMsg2.Caption := bt2;
        btMsg2.OnClick := ev2;
        btMsg2.Visible := True;
    end else
           btMsg2.Visible := False;

    if bt3<>'' then
    begin
        btMsg3.Caption := bt3;
        btMsg3.OnClick := ev3;
        btMsg3.Visible := True;
    end else
           btMsg3.Visible := False;

    MensajeVisible(true);

end;

procedure Tf_detail.CierraFormulario(Sender: TObject);
begin
  if main_cli<>7078 then
      f_detail.Close;

  MensajeVisible(false);
end;

procedure Tf_detail.MensajeVisible(estado:Boolean);
begin
     pnMsg.Visible := estado;
end;

{$REGION 'Ini-Close'}
procedure Tf_detail.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   //if (main_cli=7078) then
   //begin
     // ShowMessage('antes de filter 7078');
     f_main.filter(u_main.modo_historico);
     // ShowMessage('despues filter 7078');
     // ShowMessage('ini locate ' + ed_id_pedido.Text);
     ////dm.q_peds.Locate('id_pedido',VarArrayOf([ed_id_pedido.Text]),[]);
      dm.q_peds.Locate('id_pedido',VarArrayOf([id_pedido_actual]),[]);
     // ShowMessage('fin locate ' + ed_id_pedido.Text);
   //end;
end;

procedure Tf_detail.FormShow(Sender: TObject);
var
  serv_hora:TStringDynArray;
  estado: TStringDynArray;
begin
  //f_detail.bringToFront;

  tsRelacionados.Enabled := (u_main.peds_en_cadena>=0);
  tsExtras.Enabled := True;
  tsLotes.Enabled := False;

  id_pedido_actual := dm.q_peds.fieldbyname('id_pedido').AsInteger;

  if dm.q_peds.fieldbyname('codalbaran').asinteger>0 then
  begin
      codalbaran_actual := dm.q_peds.fieldbyname('codalbaran').asinteger;
      gestdest_actual := dm.q_peds.fieldbyname('gestoras_dest').asinteger;
  end
  else begin
      codalbaran_actual := 0;
      gestdest_actual := 0;
  end;

  RellenaRepartidores;
  RellenaAlmacenes;

  pdf_act := '';
  pais_code_act := '';

  if mode=0 then begin                                         //modo edicion
    ed_id_pedido.Text:=dm.q_peds.fieldbyname('id_pedido').asstring;
    ed_id_order.Text:=dm.q_peds.fieldbyname('id_order').asstring;
    ed_order_name.Text:=dm.q_peds.fieldbyname('order_name').asstring;
    ed_nombre.Text:=dm.q_peds.fieldbyname('nombre').asstring;
    ed_dir_1.Text:=dm.q_peds.fieldbyname('dir_1').asstring;
    ed_poblacion.Text:=dm.q_peds.fieldbyname('poblacion').asstring;
    ed_provincia.Text:=dm.q_peds.fieldbyname('provincia').asstring;
    ed_cp.Text:=dm.q_peds.fieldbyname('cp').asstring;
    de_fecha_ped.Date:=dm.q_peds.FieldByName('fecha_ped').AsDateTime;
    edHora.Text := FormatDateTime('hh:nn',dm.q_peds.FieldByName('fecha_ped').AsDateTime);
    de_fecha_imp.Date:=dm.q_peds.FieldByName('fecha_imp').AsDateTime;
    edHImp.Text := FormatDateTime('hh:nn',dm.q_peds.FieldByName('fecha_imp').AsDateTime);
    ed_codalbaran.Text:= IntToStr(codalbaran_actual);
    edRecogida.Text:=dm.q_peds.fieldbyname('albaran_r').asstring;
    ed_telefono.Text:=dm.q_peds.fieldbyname('telefono').asstring;
    ed_email.Text:=dm.q_peds.fieldbyname('email').asstring;
    ed_text.Text:=dm.q_peds.fieldbyname('text').asstring;
    ed_obs.Text:=dm.q_peds.fieldbyname('observaciones').asstring;
    ed_tracking.Text:=dm.q_peds.fieldbyname('tracking_number').asstring;
    ed_bultos.Text:=dm.q_peds.fieldbyname('bultos').asstring;

    If dm.q_peds.fieldbyname('peso').asstring<>'' then
        edKgs.Text := dm.q_peds.fieldbyname('peso').asstring
    else
        edKgs.Text := '0';

    edDeleg.Text:=dm.q_peds.fieldbyname('delegacion_dst').AsString;

    case indexstr(dm.q_peds.fieldbyname('estado').asstring,['P','X','G','E','A','C','I']) of
      0:cb_estado.ItemIndex:=0;
      1:cb_estado.ItemIndex:=1;
      2:cb_estado.ItemIndex:=2;
      3:cb_estado.ItemIndex:=3;
      4:cb_estado.ItemIndex:=4;
      5:cb_estado.ItemIndex:=5;
      6:cb_estado.ItemIndex:=6;
    end;

    rgTransporte.ItemIndex := dm.q_peds.fieldbyname('transporte').AsInteger;

    cb_repartidor.ItemIndex := dm.q_peds.fieldbyname('id_repartidor').AsInteger;

//    case indexstr(dm.q_peds.fieldbyname('delivery_time').asstring,['24','72']) of
//      0:cb_delivery.ItemIndex:=0;
//      1:cb_delivery.ItemIndex:=1;
//      else cb_delivery.ItemIndex:=1;
//    end;

    pdf_act :=  dm.q_peds.FieldByName('pdf').AsString;

    If (pdf_act='') then
    begin
        bt_pdf.Visible := False;
        lbPath.Visible := False;
        //edPDF.Visible := True;
    end
    else begin
         lbPath.Caption := pdf_act;
         if not FileExists(pdf_act) then
         begin
              bt_pdf.ImageIndex := 2;
              bt_pdf.Visible := True;
              lbPath.Visible := True;
              //edPDF.Visible := True;
         end else begin
              bt_pdf.ImageIndex := 3;
              bt_pdf.Visible := True;
              lbPath.Visible := True;
             end;
    end;

    edPais.Text := dm.q_peds.fieldbyname('pais').asstring;
    edCodPais.Text := dm.q_peds.fieldbyname('pais_code').asstring;
    lbTag.Caption := dm.q_peds.fieldbyname('tags').asstring;
    lbCancelado.Caption := dm.q_peds.fieldbyname('cancelled_at').asstring + ' ' + dm.q_peds.fieldbyname('cancel_reason').asstring;
    lbfinancial_status.Caption := dm.q_peds.fieldbyname('financial_status').asstring;
    lbfulfillment_status.Caption := dm.q_peds.fieldbyname('fulfillment_status').asstring;

    edCompany.Text := dm.q_peds.fieldbyname('company').asstring;
    edNote.Text := dm.q_peds.fieldbyname('note').asstring;

    edCliente.Text := dm.q_peds.fieldbyname('id_cliente').asstring;
    case f_main.rgTipoGes.ItemIndex of
      0: lbCli.Caption := f_main.lbCliente.Caption;
      1: lbCli.Caption := f_main.lb_cli.Caption;
    end;

    btDelEtiq.Visible := tiene_etiquetas(id_pedido_actual);
    read_lines;

    if cdsLines.RecordCount>0 then
    begin
       //ng_lines.SelectCell(0,0);
       //ng_linesCellClick(f_detail,0,1);
       //empty_data_lines;
       cdslines.Locate('linea',1,[]);
       cdslotes.Locate('linea',1,[]);
    end;

    chRetorno.Checked := (dm.q_peds.FieldByName('con_retorno').AsInteger=1);
    imgRetorno.Visible := (dm.q_peds.FieldByName('con_retorno').AsInteger=1);

    edContacto.Text := dm.q_peds.fieldbyname('contacto').asstring;

    {cbServicio.Enabled := (BuscaGrupoCliente(StrToInt(edCliente.Text))=6);  //Solo para Merydeis de momento
    cbHorario.Enabled := (BuscaGrupoCliente(StrToInt(edCliente.Text))=6); }
    id_repartidor_actual := dm.q_peds.fieldbyname('id_repartidor').AsInteger;
    id_agencia_en_gestoras := GetRelacionAgencia(dm.q_peds.fieldbyname('id_repartidor').AsInteger);
    RellenaTipoServicio;
    cbServicio.ItemIndex := Integer(cbServicio.Items.IndexOfObject(TObject(dm.q_peds.fieldbyname('tipo_servicio').AsInteger)));
    if cbServicio.ItemIndex=-1 then cbServicio.ItemIndex := 0;

    RellenaHorario(dm.q_peds.fieldbyname('tipo_servicio').asinteger);
    cbHorario.ItemIndex := Integer(cbHorario.Items.IndexOfObject(TObject(dm.q_peds.fieldbyname('horario').AsInteger)));
    if cbHorario.ItemIndex=-1 then cbHorario.ItemIndex := 0;

    if (dm.q_peds.fieldbyname('gest_nuevo').asinteger=0) and (codalbaran_actual>0) then
    begin
       lbEstadoGest.Caption := get_estado_albaran(codalbaran_actual);
       if lbEstadoGest.Caption<>'' then
       begin
         estado := SplitString(lbEstadoGest.Caption,'|');
         bt_guardar.Enabled := (codalbaran_actual=0) or
                               ((codalbaran_actual>0) and
                               (estado[2]='1'));

         lbEstadoGest.Caption := estado[0] + '|' + estado[1];
       end else begin
          bt_guardar.Enabled := True;
       end;
    end else begin
        lbEstadoGest.Caption := '';
        bt_guardar.Enabled := True;
    end;


    lgs_ico.Visible := (dm.q_peds.fieldbyname('gest_nuevo').asinteger=1) and (codalbaran_actual>0);
    gest_ico.Visible := (dm.q_peds.fieldbyname('gest_nuevo').asinteger=0) and (codalbaran_actual>0);
    lbEstadoGest.Visible := (dm.q_peds.fieldbyname('gest_nuevo').asinteger=0) and (codalbaran_actual>0);

    if not modo_historico then
       habilitar_botones_detalle(not((codalbaran_actual>0) and (dm.q_peds.fieldbyname('gest_nuevo').asinteger=0)))
    else
       habilitar_botones_detalle(false);

    edCeco.Text := dm.q_peds.fieldbyname('ceco').asstring;
    edRefCliente.Text := dm.q_peds.fieldbyname('ref_cliente').asstring;


    {if (dm.q_peds.fieldbyname('origen_web').AsInteger=1) then
       lbExpAgencia.Caption := get_albaran_data('expedicion_age',dm.q_peds.fieldbyname('codalbaran').AsInteger)
    else

       lbExpAgencia.Caption := '';}
    lbExpAgencia.Caption := get_albaran_data('expedicion_age',codalbaran_actual);

    lbPick.Caption := dm.q_peds.fieldbyname('picking').asstring;
    lbPack.Caption := dm.q_peds.fieldbyname('pack_ab').asstring;

    edReembolso.Value := dm.q_peds.fieldbyname('reembolso').AsFloat;

    de_fecha_gen.Date:=dm.q_peds.FieldByName('fecha_gen').AsDateTime;
    edHGen.Text := FormatDateTime('hh:nn',dm.q_peds.FieldByName('fecha_gen').AsDateTime);
    de_fecha_env.Date:=dm.q_peds.FieldByName('fecha_fin').AsDateTime;
    edHEnv.Text := FormatDateTime('hh:nn',dm.q_peds.FieldByName('fecha_fin').AsDateTime);

    btRegeneraEtiq.Enabled := (codalbaran_actual>0);

    gbLotes.Enabled := u_main.tiene_lotes;
    gbExtras.Enabled := u_main.tiene_n_serie;

    btFicheroMuzy.Visible := (main_cli=7078);
    chSoloFichero.Visible := (main_cli=7078);

    pcDetail.ActivePageIndex := 0;
    grLines.Columns[7].Visible := True;
    grLines.Columns[8].Visible := True;
    grLines.Columns[9].Visible := True;
    grLines.OnCellClick(grLines.Columns[0]);

    dm.qExtras.Open;

    cbAlmacen.ItemIndex:=dm.q_peds.fieldbyname('id_almacen').asinteger;

    rgTransporte.Enabled := not modo_historico;
    cb_repartidor.Enabled := not modo_historico;
    cbServicio.Enabled := not modo_historico;
    cbHorario.Enabled := not modo_historico;
    btFinPedido.Enabled := not modo_historico;
    btFicheroMuzy.Enabled := not modo_historico;
    btSolicEtiq.Enabled := not modo_historico;
    gbLine.Visible := not modo_historico;
    btRegeneraEtiq.Enabled := not modo_historico;
    btLoadFile.Enabled := not modo_historico;

  end;

  if mode=1 then begin                                         //modo nuevo
    ed_id_pedido.Text:='0';
    ed_id_order.Text:='0';
    ed_order_name.Text:='0';
    ed_nombre.Text:='';
    edDeleg.Text:= '';
    ed_dir_1.Text:='';
    ed_poblacion.Text:='';
    ed_provincia.Text:='';
    ed_cp.Text:='';
    edPais.Text := 'España';
    edCodPais.Text := 'ES';
    de_fecha_ped.Date:=date;
    edHora.Text := FormatDateTime('hh:nn',date);
    de_fecha_imp.Date:=date;
    edHImp.Text := FormatDateTime('hh:nn',date);
    ed_codalbaran.Text:='';
    edRecogida.Text:='';
    cb_estado.ItemIndex:=0;
    ed_bultos.text:='1';
    ed_telefono.Text:='';
    ed_email.Text:='';
    edContacto.Text := '';
    ed_text.Text:='';
    ed_obs.Text:='';
    ed_tracking.text:='';
    rgTransporte.ItemIndex := -1;
    rgTransporte.ItemIndex := u_main.transporte_propio;

    if u_main.repartidor>0 then
       cb_repartidor.ItemIndex := u_main.repartidor
    else
       cb_repartidor.ItemIndex:=-1;

    //RellenaDeliveryTime(0,main_cli,cb_repartidor.ItemIndex);
    //cb_delivery.ItemIndex := cb_delivery.IndexOf(IntToStr(u_main.delivery_default));

    lbTag.Caption := '';
    lbCancelado.Caption := '';
    btDelEtiq.Visible := False;

    bt_pdf.Visible := False;
    lbPath.Visible := False;

    edCompany.Text := '';
    edNote.Text := '';

    case f_main.rgTipoGes.ItemIndex of
       0: begin
           edCliente.Text := f_main.edCliente.Text;
           lbCli.Caption := f_main.lbCliente.Caption;
           serv_hora := SplitString(get_serv_hor_cliente(StrToInt(edCliente.text)),'|');

            with TpFIBDataSet.Create(self) do
            try
              Database:=dm.db;
              SQLs.SelectSQL.Clear;
              sqls.SelectSQL.Add('select * from get_clientes_config(:id_cliente)');
              ParamByName('id_cliente').AsInteger := StrToInt(edCliente.text);
              Open;
              First;

              if not IsEmpty then
              begin
                 ed_nombre.Text := FieldByName('nombre').AsString;
                 ed_dir_1.Text  := FieldByName('direccion').AsString;
                 ed_cp.Text := FieldByName('cp').AsString;
                 ed_poblacion.Text := FieldByName('poblacion').AsString;
                 ed_provincia.Text := FieldByName('provincia').AsString;
                 ed_email.Text := FieldByName('email').AsString;
                 edContacto.Text := FieldByName('contacto_1').AsString;
                 ed_telefono.Text := FieldByName('telefono').AsString;
              end;

            finally
              free;
            end;
       end;

       1: begin
           edCliente.Text := '';
           lbCli.Caption := '';
       end;
    end;

    max_line:=0;
    //ng_lines.ClearRows;

    cdsLines.EmptyDataSet;

    chRetorno.Checked := False;
    imgRetorno.Visible := chRetorno.Checked;

    id_repartidor_actual := dm.q_peds.fieldbyname('id_repartidor').AsInteger;
    id_agencia_en_gestoras := GetRelacionAgencia(dm.q_peds.fieldbyname('id_repartidor').AsInteger);

    RellenaTipoServicio;
    cbServicio.ItemIndex := Integer(cbServicio.Items.IndexOfObject(TObject(StrToInt(serv_hora[0]))));
    if cbServicio.ItemIndex=-1 then cbServicio.ItemIndex := 0;

    RellenaHorario(StrToInt(serv_hora[0]));

    cbHorario.ItemIndex :=  Integer(cbHorario.Items.IndexOfObject(TObject(StrToInt(serv_hora[1]))));
    if cbHorario.ItemIndex=-1 then cbHorario.ItemIndex := 0;

    lbEstadoGest.Caption := '';

    edCeco.Text := '';
    edRefCliente.Text := '';

    gbLine.Visible := True;
    habilitar_botones_detalle(true);

    lbExpAgencia.Caption := '';

    tsRelacionados.Enabled := (u_main.peds_en_cadena>=0);
    tsExtras.Enabled := False;
    tsExtras.Enabled := False;

    lbPick.Caption := '';
    lbPack.Caption := '';

    edReembolso.Value := 0;

    de_fecha_gen.Text := '  /  /    ';
    de_fecha_env.Text := '  /  /    ';
    edHGen.Text := '  :  ';
    edHEnv.Text := '  :  ';

    cbAlmacen.ItemIndex := 0;
  end;

  if mode=2 then begin                                         //modo reexpedicion
    ed_id_pedido.Text:='0';
    ed_id_order.Text:=dm.q_peds.fieldbyname('id_order').asstring+marca_ped_reexp;
    ed_order_name.Text:=dm.q_peds.fieldbyname('order_name').asstring+marca_ped_reexp;
    ed_nombre.Text:=dm.q_peds.fieldbyname('nombre').asstring;
    edDeleg.Text:=dm.q_peds.fieldbyname('delegacion_dst').AsString;
    ed_dir_1.Text:=dm.q_peds.fieldbyname('dir_1').asstring;
    ed_poblacion.Text:=dm.q_peds.fieldbyname('poblacion').asstring;
    ed_provincia.Text:=dm.q_peds.fieldbyname('provincia').asstring;
    ed_cp.Text:=dm.q_peds.fieldbyname('cp').asstring;
    ed_telefono.Text:=dm.q_peds.fieldbyname('telefono').asstring;
    ed_email.Text:=dm.q_peds.fieldbyname('email').asstring;
    ed_text.Text:=dm.q_peds.fieldbyname('text').asstring;
    ed_obs.Text:=dm.q_peds.fieldbyname('observaciones').asstring;
    ed_bultos.Text:=dm.q_peds.fieldbyname('bultos').asstring;
    ed_tracking.Text:='';
    de_fecha_ped.Date:=date;
    de_fecha_imp.Date:=date;
    edHora.Text := FormatDateTime('hh:nn',date);
    edHImp.Text := FormatDateTime('hh:nn',date);

    ed_codalbaran.Text:='';
    edRecogida.Text:='';
    cb_estado.ItemIndex:=0;
    //cb_delivery.ItemIndex:=0;
    rgTransporte.ItemIndex := dm.q_peds.FieldByName('transporte').AsInteger;

    cb_repartidor.ItemIndex:=dm.q_peds.fieldbyname('id_repartidor').asinteger;

    edPais.Text := dm.q_peds.fieldbyname('pais').asstring;
    edCodPais.Text := dm.q_peds.fieldbyname('pais_code').asstring;
    lbTag.Caption := dm.q_peds.fieldbyname('tags').asstring;
    lbCancelado.Caption := dm.q_peds.fieldbyname('cancelled_at').asstring + ' ' + dm.q_peds.fieldbyname('cancel_reason').asstring;

    edCompany.Text := dm.q_peds.fieldbyname('company').asstring;
    edNote.Text := dm.q_peds.fieldbyname('note').asstring;

    edCliente.Text := dm.q_peds.fieldbyname('id_cliente').asstring;
    case f_main.rgTipoGes.ItemIndex of
      0: lbCli.Caption := f_main.lbCliente.Caption;
      1: lbCli.Caption := f_main.lb_cli.Caption;
    end;

    btDelEtiq.Visible := False;
    read_lines;

    chRetorno.Checked := (dm.q_peds.FieldByName('con_retorno').AsInteger=1);
    imgRetorno.Visible := chRetorno.Checked;

    edContacto.Text := dm.q_peds.fieldbyname('contacto').asstring;

    id_repartidor_actual := dm.q_peds.fieldbyname('id_repartidor').AsInteger;
    id_agencia_en_gestoras := GetRelacionAgencia(dm.q_peds.fieldbyname('id_repartidor').asinteger);

    RellenaTipoServicio;
    //cbServicio.ItemIndex := Integer(cbservicio.Items.Objects[dm.q_peds.fieldbyname('tipo_servicio').asinteger]);

    cbServicio.ItemIndex := Integer(cbServicio.Items.IndexOfObject(TObject(dm.q_peds.fieldbyname('tipo_servicio').AsInteger)));
    if cbServicio.ItemIndex=-1 then cbServicio.ItemIndex := 0;

    RellenaHorario(dm.q_peds.fieldbyname('tipo_servicio').asinteger);
    cbHorario.ItemIndex := Integer(cbHorario.Items.IndexOfObject(TObject(dm.q_peds.fieldbyname('horario').AsInteger)));
    if cbHorario.ItemIndex=-1 then cbHorario.ItemIndex := 0;

    //RellenaHorario(dm.q_peds.fieldbyname('tipo_servicio').asinteger);
    //cbHorario.ItemIndex := Integer(cbHorario.Items.Objects[dm.q_peds.fieldbyname('horario').asInteger]);

    lbEstadoGest.Caption := '';

    edCeco.Text := dm.q_peds.fieldbyname('ceco').asstring;
    edRefCliente.Text := dm.q_peds.fieldbyname('ref_cliente').asstring + marca_ped_reexp;

    habilitar_botones_detalle(true);

    lbExpAgencia.Caption := '';

    if dm.q_peds.fieldbyname('reembolso').AsFloat>0 then
        if MessageDlg('Este pedido lleva reembolso,¿desea copiarlo?',mtWarning,mbYesNo,0,mbNo)=mrYes then
               edReembolso.Value := dm.q_peds.fieldbyname('reembolso').AsFloat
        else
               edReembolso.Value := 0;

    de_fecha_gen.Text := '  /  /    ';
    de_fecha_env.Text := '  /  /    ';
    edHGen.Text := '  :  ';
    edHEnv.Text := '  :  ';

    cbAlmacen.ItemIndex:=dm.q_peds.fieldbyname('id_almacen').asinteger;
  end;

  if not (mode=0) then
  begin
    empty_data_lines;

    dm.q_peds_lines_lotes.Close;
    lbArtLote.Caption := '';

    lbPick.Caption := '';
    lbPack.Caption := '';

    id_repartidor_actual := -1;
    id_agencia_en_gestoras := -1;

  end;

  lbExpAgencia.Hint := 'Doble click para copiar';

  imgReemb.Visible := (edReembolso.Value>0);

  pcDetail.ActivePageIndex := 0;
  pos_tabc := 0;

  edIMEI.Visible := tiene_imei or tiene_n_serie;
  btIMEI.Visible := tiene_imei;

  if tiene_n_serie then
  begin
       edIMEI.BoundLabel.Caption := 'NSerie';
       edIMEI.MaxLength := 50;
       edIMEI.Width := 175;
       edIMEI.NumbersOnly := False;
  end
  else begin
       edIMEI.BoundLabel.Caption := 'IMEI';
       edIMEI.MaxLength := 15;
       edIMEI.Width := 144;
       edIMEI.NumbersOnly := True;
  end;

  chNSerieSelecc.Checked := False;
  gbNSerie.Visible := (not modo_historico) and tiene_n_serie;
  edEanNSerie.Enabled := PedidoFaltaNSerie(id_pedido_actual);
  gbNSList.Visible := tiene_n_serie;
  lbNSContTotal.Visible := tiene_n_serie;

  if tiene_n_serie then
  begin
    gbNSList.Caption := 'Informe pistoleados';
    lines_n_serie_total := cuenta_lineas_con_n_serie(id_pedido_actual);
    lines_n_serie_pistoleadas := cuenta_lineas_con_n_serie_pistoleado(id_pedido_actual);
    lbNSContTotal.Caption := 'Nºs Serie: ' + IntToStr(lines_n_serie_pistoleadas) + '/' + IntToStr(lines_n_serie_total);
  end;

  gbStockLote.Visible := (not modo_historico) and u_main.tiene_lotes;
  btAsignaLote.Enabled := (not modo_historico) and (dm.q_peds.FieldByName('estado').AsString = 'P');
  gbLotes.Visible := u_main.tiene_lotes;

  lote_forzado := tiene_lote_forzado(id_pedido_actual);

  lbEan.Caption := '';
  status.Panels[0].Text := '';

  if main_cli=7078 then
  begin
     with TpFIBDataSet.Create(self) do
      try
        Database:=dm.db;
        SQLs.SelectSQL.Clear;
        sqls.SelectSQL.Add('select valor from c_pedidos_extras where id_pedido=:pedido and descripcion=''DATE_FILE_SEND'' ');
        ParamByName('pedido').AsInteger := id_pedido_actual;
        Open;
        First;

        if FieldByName('valor').AsString<>'' then
          lbFileSend.Caption := FieldByName('valor').AsString
        else
          lbFileSend.Caption := '';

      finally
        free;
      end;
  end else
        lbFileSend.Caption := '';

  bt_guardar.Enabled := not modo_historico and (cuenta_lineas_pedido(id_pedido_actual)<max_ln_det);


   estado_actual := dm.q_peds.fieldbyname('estado').AsString;

  carga_datasets(modo_historico);

  edCliente.SetFocus;
end;


{$ENDREGION}


{$REGION 'Process'}
procedure Tf_detail.save_exp;
var
    id_pedido,i, new_ped, linea:integer;
    json, resp,resultado: string;
    fecha_gen,fecha_imp, fecha_fin: TDateTime;

begin

  json := '';
  resp := '';
  linea := cdsLines.fieldbyname('linea').AsInteger;
  resultado := '';

  dm.q_peds.Locate('id_pedido',VarArrayOf([id_pedido_actual]),[]);

  fecha_gen := de_fecha_gen.Date;
  fecha_imp := de_fecha_imp.Date;
  fecha_fin := de_fecha_env.Date;

  if mode=0 then begin                                  //modo edicion
    //ShowMessage('ini mode 0');
    id_pedido := id_pedido_actual;

    status.Panels[0].Text := 'Guardando pedido ' + IntToStr(id_pedido_actual) + ' ...';;

    try
    resp := dmupdatePedido.updatepedido(1,id_pedido_actual, json, resultado);

    except on e:exception do
    begin
        InsertaLog(u_main.usuario.id,id_pedido_actual,0,PC.Nombre,PC.IP,log_app,'pedido','',
             'ErrorGuardadoAPI',e.Message);
    end;
    end;

    try
    InsertaLog(u_main.usuario.id,id_pedido_actual,0,PC.Nombre,PC.IP,log_app,'pedido','',
             'Ped.Guardado x API','Modo Edit|' + resp);
     except on e:exception do
     begin
        InsertaLog(u_main.usuario.id,id_pedido_actual,0,PC.Nombre,PC.IP,log_app,'pedido','',
             'ErrorGuardadoAPI.InsertandoLog',e.Message);
     end;
    end;

    //f_main.filter(u_main.modo_historico);
    //dm.q_peds.Locate('id_pedido',VarArrayOf([id_pedido_actual]),[]);
    //ShowMessage('fin mode 0');
  end;

  if ((mode=1) or (mode=2)) then begin                                  //modo new/reexpedicion
    //ShowMessage('ini mode ' + IntToStr(mode));
    status.Panels[0].Text := 'Creando nuevo pedido ... ';
    new_ped := StrToInt(dmupdatePedido.updatepedido(0,0,json,resultado));

    InsertaLog(u_main.usuario.id,id_pedido_actual,0,PC.Nombre,PC.IP,log_app,'pedido','',
             'Ped.Nuevo/Reexp x API','Modo New/Reexp|NewPed.' + IntToStr(new_ped) + '|' + json);
  end;

  if tiene_n_serie then
  begin

      cdsLines.DisableControls;
      dm.t_write.StartTransaction;
      try
        dm.q_1.Close;
        dm.q_1.sql.Clear;
        dm.q_1.sql.Add('update c_pedidos_lines set n_serie=:n_serie where id_pedido=:id_pedido and id_line=:linea');
        cdsLines.First;

        while not cdsLines.Eof do
        begin
          status.Panels[0].Text := 'Actualizando NSerie Ped.' + IntToStr(id_pedido_actual) +
          ' Ln.' + cdsLines.fieldbyname('linea').AsString;

          if cdsLines.fieldbyname('n_serie').AsString<>'' then
          begin
            dm.q_1.ParamByName('id_pedido').AsInteger := id_pedido_actual;
            dm.q_1.ParamByName('linea').AsInteger := cdsLines.fieldbyname('linea').AsInteger;
            dm.q_1.ParamByName('n_serie').AsString := cdsLines.fieldbyname('n_serie').AsString;
            dm.q_1.ExecQuery;
          end;
          cdsLines.Next;
        end;

        dm.t_write.Commit;

      except begin
        dm.t_write.rollback;

      end;
      end;
      cdsLines.EnableControls;

      cdsLines.Locate('linea',linea,[]);

      dm.q_peds.Locate('id_pedido',VarArrayOf([id_pedido_actual]),[]);

      edEanNSerie.Enabled := PedidoFaltaNSerie(id_pedido_actual);

  end;

   // ShowMessage('ini guarda fechas');
   status.Panels[0].Text := 'Actualizando Fechas Ped.' + IntToStr(id_pedido_actual);

  dm.t_write.StartTransaction;
  try
    dm.q_1.Close;
    dm.q_1.sql.Clear;
    dm.q_1.sql.Add('update c_pedidos set ');
    if fecha_gen>StrToDate('01/01/1900') then dm.q_1.sql.Add('fecha_gen=:fecha_gen,');
    if fecha_imp>StrToDate('01/01/1900') then dm.q_1.sql.Add('fecha_imp=:fecha_imp,');
    if fecha_fin>StrToDate('01/01/1900') then dm.q_1.sql.Add('fecha_fin=:fecha_fin,');
    dm.q_1.sql.Add('id_almacen=:id_almacen where id_pedido=:ID_PEDIDO');
    dm.q_1.ParamByName('ID_PEDIDO').AsInteger := id_pedido_actual;

    if fecha_gen>StrToDate('01/01/1900') then dm.q_1.ParamByName('fecha_gen').AsDateTime := fecha_gen;
    if fecha_imp>StrToDate('01/01/1900') then dm.q_1.ParamByName('fecha_imp').AsDateTime := fecha_imp;
    if fecha_fin>StrToDate('01/01/1900') then dm.q_1.ParamByName('fecha_fin').AsDateTime := fecha_fin;
    dm.q_1.ParamByName('id_almacen').AsInteger := cbAlmacen.ItemIndex;
    dm.q_1.ExecQuery;
    dm.t_write.Commit;

  except begin
     dm.t_write.Rollback;

  end;
  end;

  status.Panels[0].Text := '';

  if ((mode=0) and (codalbaran_actual>0) and (dm.q_peds.FieldByName('origen_web').AsInteger=1)) then
  begin
    dm.t_write_gestoras.StartTransaction;
    try

          status.Panels[0].Text := 'Actualizando Gestoras Alb.' + IntToStr(codalbaran_actual);
          //dm.q_peds.Locate('id_pedido',VarArrayOf([id_pedido_actual]),[]);
          ActualizaAlbaranGestoras(codalbaran_actual);

          dm.t_write_gestoras.Commit;
        //  ShowMessage('fin actualiza gestoras');

          InsertaLog(u_main.usuario.id,id_pedido_actual,0,PC.Nombre,PC.IP,log_app,'pedido','',
             'Alb.Actualizado ' + IntToStr(codalbaran_actual) ,'Tras guardar pedido con Bt. Guardar pedido');
    except
            on e: Exception do begin

               InsertaLog(u_main.usuario.id,id_pedido_actual,0,PC.Nombre,PC.IP,log_app,'pedido','',
               'Error Upd.Alb. ' + IntToStr(codalbaran_actual) ,'Tras guardar pedido con Bt. Guardar Cambios. ' + e.Message);

               status.Panels[0].Text := 'Error Actualizando Gestoras Alb.' + IntToStr(codalbaran_actual);

               dm.t_write_gestoras.Rollback;

               raise Exception.Create('Error Actualizando Gestoras (' + e.Message + ')');

            end;
    end;
  end;


  if gestion_cola and (estado_actual<>cb_estado.Text[1]) then
  begin
      dmEstadoPedido.estadopedido(id_pedido_actual);
      InsertaLog(u_main.usuario.id,id_pedido_actual,0,PC.Nombre,PC.IP,log_app,'pedido','',
                       'BtGuardaPed.EnvColaEst.' + estado_actual + '->' + cb_estado.Text[1],'');
      estado_actual := cb_estado.Text[1];
  end;

  if resultado<>'' then
       //ShowMessage(resultado);
       LanzaMensaje(resultado,'Ok','','',CierraFormulario,nil,nil);
end;

procedure Tf_detail.btRegeneraEtiqClick(Sender: TObject);
var
    tracking, error:string;
    texto: string;
    codalbaran: Integer;
begin
 codalbaran := codalbaran_actual;

  if codalbaran>0 then
  begin

    if u_cam_gl.existe_etiq_tmp (id_usuario,codalbaran)=0 then
      begin
      //DMCreaBultos.GeneraBultos(dm.q_peds.FieldByName('codalbaran').AsInteger,dm.q_peds.FieldByName('gestoras_dest').AsInteger);
      dm.t_write_gestoras.StartTransaction;
      try
        u_cam_gl.inserta_etiq_tmp(id_usuario,codalbaran);
        dm.t_write_gestoras.Commit;
      except
        dm.t_write_gestoras.Rollback;
      end;
    end;

    If ValidaAlbaran(IntToStr(codalbaran),texto)  then
    begin
      DMLstEtiquetas.ObtenEtiquetas('A',IntToStr(codalbaran),True);
      lbExpAgencia.Caption := get_albaran_data('expedicion_age',codalbaran);
      if texto<>'' then
         raise Exception.Create(texto);
         // ShowMessage(texto);
    end;

  end;
end;

procedure Tf_detail.bt1Click(Sender: TObject);
begin
    ShowMessage(estado_actual);
    ShowMessage(cb_estado.Text[1]);
end;

procedure Tf_detail.ActualizaAlbaran(codalbaran:Integer);
var
  s: string;
begin
  {  dm.qryAlbEdit.Connection := dm.con1;
    dm.qryAlbEdit.open;
    //dm.qryAlbEdit.Locate('codalbaran',codalbaran);
    dm.qryAlbEdit.fieldbyname('fecha').asdatetime:=f_main.siguiente_laboral(de_fecha_ped.Date);
    dm.qryAlbEdit.fieldbyname('codcli').asstring:=edCliente.Text;
    dm.qryAlbEdit.fieldbyname('bultos').asinteger:=StrToInt(ed_bultos.Text);
    dm.qryAlbEdit.fieldbyname('kgs').AsFloat:=StrToFloat(edkgs.Text);
    dm.qryTemp.close;

    if rgTransporte.ItemIndex=1 then    //Medios del Cliente
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

    dm.qryTemp.sql.clear;                                                  //nuevo codigo de movimiento
    dm.qryTemp.sql.add('select * from delegaciones where codcli=' + dm.ds_2.FieldByName('id_cliente').asstring +
                       ' and coddel=' + Copy(default_deleg,Pos('-',default_deleg)+1, Length(default_deleg)));
    dm.qryTemp.open;

    dm.qryAlbEdit.fieldbyname('codremitente').asstring := dm.qrytemp.FieldByName('coddelegacion').AsString;
    dm.qryAlbEdit.fieldbyname('org_codcli').asstring := dm.qrytemp.FieldByName('codcli').AsString;
    dm.qryAlbEdit.fieldbyname('org_coddel').asstring := dm.qrytemp.FieldByName('coddel').AsString;
    dm.qryAlbEdit.fieldbyname('org_nombre').asstring := dm.qrytemp.FieldByName('nombre').AsString;
    dm.qryAlbEdit.fieldbyname('org_calle').asstring := dm.qrytemp.FieldByName('calle').AsString;
    dm.qryAlbEdit.fieldbyname('org_cp').asstring := dm.qrytemp.FieldByName('cp').AsString;
    dm.qryAlbEdit.fieldbyname('org_localidad').asstring := dm.qrytemp.FieldByName('localidad').AsString;
    dm.qryAlbEdit.fieldbyname('org_provincia').asstring :=dm.qrytemp.FieldByName('provincia').AsString;
    dm.qryAlbEdit.fieldbyname('org_persona').asstring :='';
    dm.qryAlbEdit.fieldbyname('org_tfno').asstring := dm.qrytemp.FieldByName('tfno').AsString;

    {if dm.ds_2.FieldByName('delegacion_dst').AsString='' then
    begin
         dm.qryAlbEdit.fieldbyname('dst_coddel').asstring:= '9999';
         dm.qryAlbEdit.fieldbyname('coddestinatario').asstring := edCliente.Text + '9999';
    end
    else begin
          dm.qryAlbEdit.fieldbyname('dst_coddel').asstring := dm.ds_2.FieldByName('delegacion_dst').AsString;
          dm.qryAlbEdit.fieldbyname('coddestinatario').asstring := edCliente.Text + dm.ds_2.FieldByName('delegacion_dst').AsString;
         end;  }
  {  dm.qryAlbEdit.fieldbyname('dst_coddel').asstring:= '9999';
    dm.qryAlbEdit.fieldbyname('coddestinatario').asstring := edCliente.Text + '9999';

    dm.qryAlbEdit.fieldbyname('dst_codcli').asstring := dm.qrytemp.FieldByName('codcli').AsString;
    dm.qryAlbEdit.fieldbyname('dst_nombre').asstring :=dm.ds_2.FieldByName('nombre').asstring;
    dm.qryAlbEdit.fieldbyname('dst_calle').asstring :=Trim(dm.ds_2.FieldByName('dir_1').asstring);
    dm.qryAlbEdit.fieldbyname('dst_cp').asstring :=dm.ds_2.FieldByName('cp').asstring;
    dm.qryAlbEdit.fieldbyname('dst_localidad').asstring :=dm.ds_2.FieldByName('poblacion').asstring;
    dm.qryAlbEdit.fieldbyname('dst_provincia').asstring :=dm.ds_2.FieldByName('provincia').asstring;
    dm.qryAlbEdit.fieldbyname('dst_persona').asstring :=dm.ds_2.FieldByName('nombre').asstring;
    dm.qryAlbEdit.fieldbyname('dst_tfno').asstring :=dm.ds_2.FieldByName('telefono').asstring;
    dm.qryAlbEdit.fieldbyname('observaciones').asstring := dm.ds_2.FieldByName('observaciones').asstring + ' ' + dm.ds_2.FieldByName('text').asstring;
    dm.qryAlbEdit.fieldbyname('asegurado').asinteger:=0;
    dm.qryAlbEdit.fieldbyname('pdebido').asinteger:=0;
    dm.qryAlbEdit.fieldbyname('reembolso').AsFloat := dm.ds_2.FieldByName('reembolso').AsFloat;
    dm.qryAlbEdit.fieldbyname('km').asinteger:=0;
    dm.qryAlbEdit.fieldbyname('e_s_r').asstring:='S';

    dm.qryTemp.sql.clear;
    dm.qryTemp.sql.add('select min(fmovimiento) from servicios_lineas (NOLOCK)');
    dm.qryTemp.sql.add(' where codservicio='+inttostr(codservicio));
    dm.qryTemp.open;



    s:= 'insert into albaranes_estados';
    s:= s+' (codalbaran,festado,codestado,persona,observaciones,ultimo)';
    s:= s+' values(';
    s:= s+ IntToStr(codalbaran) + ',';
    s:= s+ FormatDateTime('dd/mm/yyyy',Now) + ',';
    s:= s+ '54' + ',null,''Inserción automática'',''S'')';
    dm.qryTemp.close;
    dm.con1.execute(s);

    dm.con1.execute('exec lgAjustaMedidasAlbaran ' + IntToStr(codalbaran));

    dm.qryAlbEdit.post;    }
end;

procedure Tf_detail.btSolicEtiqClick(Sender: TObject);
begin
    with TpFIBDataSet.Create(self) do
    try
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select * from c_pedidos_etiquetas where id_pedido=:pedido');
      ParamByName('pedido').AsInteger := id_pedido_actual;
      Open;
      First;

      while not Eof do
      begin
         SolicitarEtiquetaCorreos(FieldByName('fecha_operacion').AsDateTime,FieldByName('cod_envio').AsString);

         Next;
      end;

    finally
      free;
    end;
end;

procedure Tf_detail.SolicitarEtiquetaCorreos(fecha:TDateTime;envio:string);
var
  datosPost: TStringList;
  i:Integer;
  str_js, strRead: string;
begin
    datosPost := TStringList.Create;
    datosPost := CreaSolicitudEtiquetaCorreos(fecha, envio);
    for I := 0 to datosPost.Count - 1 do
      str_js := str_js + datosPost[i];
    datosPost.Clear;
    datosPost.Add(str_js);
    strRead := '';
    strRead := u_correos.JSONPostCorreos(2,str_js);
end;


procedure Tf_detail.bpArtRelClick(Sender: TObject);
begin
    with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;   row_height:=40;
    fields.commatext:='ar.id_articulo,ar.codigo,ar.nombre';
    titulos.commatext:='Id_Articulo,Referencia,Nombre';
    from:='g_articulos ar inner join g_clientes_config c on c.peds_en_cadena=ar.id_cliente ';

    where:=' estado=''A''';
    orden[1]:=2;   orden_ini:=0;  group:='';
    busca:=2;   distinct:=0;   fillimpio:=True;    row_height:=17;

    showmodal;

    if resultado then begin

      edArtRel.Text:=valor[2];
      lb_art_rel.caption:=valor[3];

      dm.q_arts_relacionados.FieldByName('id_art_relacionado').AsInteger := StrToInt(valor[1]);
      dm.q_arts_relacionados.FieldByName('cod_art_rel').AsString := valor[2];
      dm.q_arts_relacionados.FieldByName('id_articulo').AsInteger := StrToInt(lb_id_art.Caption);
    end;
  end;
end;

{$ENDREGION}

{$REGION 'Lines'}
procedure Tf_detail.read_lines;
begin
    dm.q_peds_lines.Open;
    max_line:=0;

   cdsLines.EmptyDataSet;
   cdsLotes.EmptyDataSet;

    dm.q_peds_lines.First;
    while not(dm.q_peds_lines.Eof) do begin

      if dm.q_peds_lines.FieldByName('id_line').AsInteger>max_line then
        max_line:=dm.q_peds_lines.FieldByName('id_line').AsInteger;

      cdsLines.Insert;
      cdsLines.FieldByName('linea').AsInteger := dm.q_peds_lines.FieldByName('id_line').AsInteger;
      cdsLines.FieldByName('id_articulo').AsInteger := dm.q_peds_lines.FieldByName('id_articulo').AsInteger;
      cdsLines.FieldByName('referencia').AsString := dm.q_peds_lines.FieldByName('codigo').AsString;
      cdsLines.FieldByName('sku').AsString := dm.q_peds_lines.FieldByName('codigo_cli').AsString;
      cdsLines.FieldByName('nombre').AsString := dm.q_peds_lines.FieldByName('nombre').AsString;
      cdsLines.FieldByName('cantidad').AsInteger := dm.q_peds_lines.FieldByName('cantidad').AsInteger;
      cdsLines.FieldByName('kgs').AsFloat := RoundTo(StrToFloat(dm.q_peds_lines.FieldByName('kgs').asstring),-2);
      cdsLines.FieldByName('imei').AsString := dm.q_peds_lines.FieldByName('imei').AsString;
      cdsLines.FieldByName('item_id').AsInteger := dm.q_peds_lines.FieldByName('item_id').AsInteger;
      cdsLines.FieldByName('n_serie').AsString := dm.q_peds_lines.FieldByName('n_serie').AsString;
      cdsLines.FieldByName('id_lote').AsInteger := dm.q_peds_lines.FieldByName('id_lote').AsInteger;
      if dm.q_peds_lines.FieldByName('id_lote').AsInteger=1 then begin
         cdsLines.FieldByName('lote').AsString := '';
         cdsLines.FieldByName('caducidad').AsString := '';
      end
      else begin
         cdsLines.FieldByName('lote').AsString := dm.q_peds_lines.FieldByName('lote').AsString;
         cdsLines.FieldByName('caducidad').AsDateTime := dm.q_peds_lines.FieldByName('caducidad').AsDateTime;
      end;
      cdsLines.Post;

      cdsLotes.Insert;
      cdsLotes.FieldByName('linea').AsInteger := dm.q_peds_lines.FieldByName('id_line').AsInteger;
      cdsLotes.FieldByName('id_articulo').AsInteger := dm.q_peds_lines.FieldByName('id_articulo').AsInteger;
      cdsLotes.FieldByName('referencia').AsString := dm.q_peds_lines.FieldByName('codigo').AsString;
      cdsLotes.FieldByName('sku').AsString := dm.q_peds_lines.FieldByName('codigo_cli').AsString;
      cdsLotes.FieldByName('nombre').AsString := dm.q_peds_lines.FieldByName('nombre').AsString;
      cdsLotes.FieldByName('cantidad').AsInteger := dm.q_peds_lines.FieldByName('cantidad').AsInteger;
      cdsLotes.FieldByName('id_lote').AsInteger := dm.q_peds_lines.FieldByName('id_lote').AsInteger;
      cdsLotes.FieldByName('lote').AsString := dm.q_peds_lines.FieldByName('lote').AsString;
      cdsLotes.FieldByName('caducidad').AsDateTime := dm.q_peds_lines.FieldByName('caducidad').AsDateTime;
      cdsLotes.Post;

      dm.q_peds_lines.Next;
    end;

    //cdsLines.IndexFieldNames := 'id_articulo';

    //dm.q_peds_lines.close;
    //ng_lines.endupdate;
end;

procedure Tf_detail.rgTransporteChange(Sender: TObject);
var
  texto_cb_deliv: string;
begin
 { texto_cb_deliv := cb_delivery.Text;

  RellenaDeliveryTime(rgTransporte.ItemIndex,
                      main_cli,
                      dm.q_peds.FieldByName('id_repartidor').AsInteger);

  case cb_delivery.IndexOf(IntToStr(dm.q_peds.FieldByName('delivery_time').AsInteger)) of
     -1: if rgTransporte.ItemIndex=0 then cb_delivery.ItemIndex := cb_delivery.IndexOf(texto_cb_deliv) else cb_delivery.ItemIndex := cb_delivery.IndexOf(txt_tpropio);
     0..100: cb_delivery.ItemIndex := cb_delivery.IndexOf(IntToStr(dm.q_peds.FieldByName('deliv_time_txt').AsInteger));
  end; }

  //cb_repartidor.Visible := (rgTransporte.ItemIndex=0);
  //bt_print_eti.enabled := (rgTransporte.ItemIndex=0);

end;

procedure Tf_detail.bt_newClick(Sender: TObject);
begin
  gbLine.Visible := True;  //(mode=1);

  inc(max_line);
  lb_id_line.Caption:=IntToStr(max_line);
  lb_sku.caption:='';
  lb_id_art.caption:='';
  lb_nombre_art.caption:='';
  ed_cantidad.text:='1';
  lb_ref_art.caption:='';

  bt_save_line.Enabled := True;
  btCancelLine.Enabled := True;
  bt_delete.Enabled := False;
end;

procedure Tf_detail.btCancelLineClick(Sender: TObject);
begin
  cdsLines.Locate('linea',1,[]);
  get_line_data;

  bt_delete.Enabled := False;
end;

procedure Tf_detail.btClienteClick(Sender: TObject);
begin
   with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='cl.id_cliente,cl.nombre';
    titulos.commatext:='Código,Nombre';
    from:='g_clientes cl, g_clientes_config c ';
    where:='cl.id_cliente=c.id_cliente and c.ges_file=1';
    orden[1]:=1;  busca:=2;   distinct:=0;   fillimpio:=True;   row_height:=17;

    showmodal;

    if resultado then begin
      with Sender as TsSpeedButton do begin
        edCliente.text:=valor[1];
        lbCli.caption:=valor[2];
      end;
    end;
  end;

end;

procedure Tf_detail.btDelEtiqClick(Sender: TObject);
begin
   if MessageDlg('Se eliminará la etiqueta para este pedido,¿desea continuar?',mtWarning,mbYesNo,0,mbNo)=mrYes then
   begin
      dm.t_write.StartTransaction;
      try
        dm.q_1.Close;
        dm.q_1.sql.Clear;
        dm.q_1.sql.Add('update c_pedidos_etiquetas set estado=:estado where id_pedido=:id_pedido');
        dm.q_1.ParamByName('estado').asstring:='B';
        dm.q_1.ParamByName('id_pedido').asinteger:=StrToInt(ed_id_pedido.Text);
        dm.q_1.ExecQuery;
        dm.t_write.Commit;
      except
        dm.t_write.rollback;
      end;
   end;
end;

procedure Tf_detail.btFinPedidoClick(Sender: TObject);
begin
    dm.t_write.StartTransaction;
    try
      dm.q_1.Close;
      dm.q_1.sql.Clear;
      dm.q_1.sql.Add('update c_pedidos set estado=:estado where id_pedido=:id_pedido');
      dm.q_1.ParamByName('estado').asstring:='E';
      dm.q_1.ParamByName('id_pedido').asinteger:=StrToInt(ed_id_pedido.Text);
      dm.q_1.ExecQuery;
      dm.t_write.Commit;
    except
      dm.t_write.rollback;
    end;
end;

procedure Tf_detail.btIMEIClick(Sender: TObject);
begin
    dm.t_write.StartTransaction;
    try
      with TpFIBQuery.Create(dm) do
      try
        database:=dm.db;
        Transaction:=dm.t_write;
        sql.add('update g_articulos set tiene_imei=:tiene_imei where id_articulo=:id_articulo');
        ParamByName('id_articulo').AsInteger:=StrToInt(lb_id_art.caption);
        ParamByName('tiene_imei').asinteger:=1;

        ExecQuery;
      finally
        free;
      end;
    except
      dm.t_write.Rollback;
      raise exception.Create('Error Actualizando');
    end;
    dm.t_write.Commit;

    btIMEI.Visible := False;
    edIMEI.Enabled := True;
end;

procedure Tf_detail.btImpAdjClick(Sender: TObject);
var
  todos, cancelado, imprimir, descargar: Boolean;
  dialog: TForm;
begin

end;

procedure Tf_detail.btLoadFileClick(Sender: TObject);
begin
  if not FileExists(edPDF.Text) then
  begin
      ShowMessage('No se encuentra el fichero ' + edPDF.Text);
      Exit;
  end
  else If (lbPath.Caption<>edPDF.Text) then
            if MessageDlg('Va a sustituir el fichero existente, ¿desea continuar?',mtWarning,mbYesNo,0)=mrNo then
                Exit
            else
                CargaFichero
       else
            CargaFichero;

end;

procedure Tf_detail.btMsg1Click(Sender: TObject);
begin
   MensajeVisible(false);
end;

procedure Tf_detail.btMsg2Click(Sender: TObject);
begin
  MensajeVisible(false);
end;

procedure Tf_detail.btMsg3Click(Sender: TObject);
begin
  MensajeVisible(false);
end;

procedure Tf_detail.CargaFichero;
begin

end;


procedure Tf_detail.bt_deleteClick(Sender: TObject);
var i:Integer;
begin
  bt_save_line.Enabled := False;
  btCancelLine.Enabled := False;

  cdsLines.Delete;
  cdsLines.Locate('linea',1,[]);
  grLinesCellClick(grLines.columns[0]);

end;

procedure Tf_detail.bt__as_art_entraClick(Sender: TObject);
begin
  with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;   row_height:=40;
    fields.commatext:='id_articulo,codigo,nombre, codigo_cli, kgs';
    titulos.commatext:='Id_Articulo,Referencia,Nombre,SKU, Kilos';
    from:='g_articulos ';

    where:=' id_cliente=' + edCliente.Text +  ' and estado=''A'' ';
    orden[1]:=4;   orden_ini:=0;  group:='';
    busca:=4;   distinct:=0;   fillimpio:=True;    row_height:=17;

    showmodal;

    if resultado then begin
      lb_sku.Caption := valor[4];
      lb_id_art.Caption := valor[1];
      lb_nombre_art.Caption := valor[3];
      lb_ref_art.Caption := valor[2];
      lbKgs.caption:=valor[5];
    end;
  end;
end;


procedure Tf_detail.get_line_data;
begin

  lb_sku.caption := cdsLines.FieldByName('sku').AsString;
  lb_id_art.Caption := cdsLines.FieldByName('id_articulo').AsString;
  lb_nombre_art.Caption := cdsLines.FieldByName('nombre').AsString;
  ed_cantidad.text := cdsLines.FieldByName('cantidad').AsString;
  lb_id_line.caption := cdsLines.FieldByName('linea').AsString;
  lb_ref_art.Caption := cdsLines.FieldByName('referencia').AsString;
  lbKgs.Caption := cdsLines.FieldByName('kgs').AsString;
  lbArtLote.Caption := cdsLines.FieldByName('referencia').AsString + ' - ' + cdsLines.FieldByName('nombre').AsString;
  lbArtExtra.caption := cdsLines.FieldByName('referencia').AsString + ' - ' + cdsLines.FieldByName('nombre').AsString;
  lbArtRel.Caption := cdsLines.FieldByName('nombre').AsString;
  edIMEI.Enabled := articulo_con_IMEI(cdsLines.FieldByName('id_articulo').AsInteger) or
                    art_tiene_n_serie(cdsLines.FieldByName('id_articulo').AsInteger);

  if tiene_imei then
      edIMEI.Text := cdsLines.FieldByName('imei').AsString
  else if tiene_n_serie then begin
           edIMEI.Text := cdsLines.FieldByName('n_serie').AsString;
           actualiza_pistoleo;
  end;

  btIMEI.Visible := tiene_imei and not art_tiene_imei(cdsLines.FieldByName('id_articulo').AsInteger);

  bt_save_line.Enabled:=true;
  if not modo_historico and (cdsLines.recordcount>0) and gbLine.Visible then
     ed_cantidad.SetFocus;
end;

procedure Tf_detail.bt_save_lineClick(Sender: TObject);
var
  linea: Integer;
begin
    InsertaLog(u_main.usuario.id,id_pedido_actual,0,PC.Nombre,PC.IP,log_app,'pedido','',
             'Bt.GuardarLinea','line='+inttoStr(linea)+'|id_art='+lb_id_art.caption+
             '|sku='+lb_sku.caption+
             '|ref='+lb_ref_art.caption+'|nom='+lb_nombre_art.caption+
             '|uds='+ed_cantidad.text+
             '|kgs='+lbKgs.Caption+'|nserie/imei='+edIMEI.Text);

  linea := cdsLines.FieldByName('linea').AsInteger;

  guarda_line;

  cdsLines.Locate('linea',linea,[]);

  bt_delete.Enabled := True;
end;

function Tf_detail.guarda_line:integer;
var
    kgs: Double;
    enc, es_nueva, enc_n_serie: Boolean;
    linea: Integer;
    resultado: string;
begin
 es_nueva := false;
 enc_n_serie := False;

 linea := cdsLines.FieldByName('linea').AsInteger;

 if tiene_n_serie then
 begin
   cdsLines.DisableControls;
   if ((edIMEI.Text<>'') and  not(check_nserie(edIMEI.text,linea))) then
   begin
    cdsLines.EnableControls;
    cdsLines.Locate('linea',linea,[]);
    enc_n_serie := True;
    raise exception.Create('Nº Serie Ya Pistoleado En Esta Expedición');
   end;
   cdsLines.EnableControls;

    //Luego se busca en cualquier pedido
    if not enc_n_serie then
    begin
      resultado := n_serie_en_otro_pedido(main_cli,id_pedido_actual,edIMEI.text);

      if resultado<>'' then
         raise exception.Create('Nº Serie Ya Pistoleado En Pedido ' + resultado);

    end;
 end;

  cdsLines.Locate('linea',linea,[]);

  bt_save_line.Enabled := False;
  btCancelLine.Enabled := False;

  enc := False;

  cdsLines.First;

  while (not enc) and (not cdsLines.Eof) do
  begin
     if cdsLines.FieldByName('linea').AsString=lb_id_line.Caption then
     begin
       cdsLines.Edit;
       enc := True;
     end;
     if not enc then
           cdsLines.Next;
  end;
                                                                   //new line
  if not enc then
  begin
    cdsLines.Insert;
    cdsLines.FieldByName('linea').AsInteger := StrToInt(lb_id_line.caption);
    es_nueva := true;
  end;

  cdsLines.FieldByName('id_articulo').AsInteger := StrToInt(lb_id_art.caption);
  cdsLines.FieldByName('referencia').AsString   := lb_ref_art.caption;
  cdsLines.FieldByName('sku').AsString          := lb_sku.caption;
  cdsLines.FieldByName('nombre').AsString       := lb_nombre_art.caption;
  cdsLines.FieldByName('cantidad').AsInteger    := StrToInt(ed_cantidad.text);
  cdsLines.FieldByName('kgs').AsFloat           := RoundTo(StrToFloat(lbKgs.Caption),-2);
  if tiene_imei then
      cdsLines.FieldByName('imei').AsString := edIMEI.Text
  else if tiene_n_serie then
      cdsLines.FieldByName('n_serie').AsString := edIMEI.Text;

  cdsLines.Post;

  ActualizaKgs;
  cdsLines.Locate('linea',linea,[]);

  result := linea;

  bt_save_line.Enabled := True;
  btCancelLine.Enabled := True;

  InsertaLog(u_main.usuario.id,id_pedido_actual,0,PC.Nombre,PC.IP,log_app,'pedido','',
             'LineaGuardada','line='+inttoStr(linea)+'|id_art='+lb_id_art.caption+
             '|sku='+lb_sku.caption+
             '|ref='+lb_ref_art.caption+'|nom='+lb_nombre_art.caption+
             '|uds='+ed_cantidad.text+
             '|kgs='+lbKgs.Caption+'|nserie/imei='+edIMEI.Text);
end;


procedure Tf_detail.ActualizaKgs;
var
  i: integer;
  kgs: Double;
begin
  cdsLines.DisableControls;

  cdsLines.First;

  while not cdsLines.Eof do
  begin
      kgs := kgs + (RoundTo(cdsLines.FieldByName('kgs').AsFloat*cdsLines.FieldByName('cantidad').AsInteger,-2));
      cdsLines.Next;
  end;

  cdsLines.EnableControls;

   edKgs.Text := FloatToStr(kgs);
end;

{$ENDREGION}

{$REGION 'Print'}
procedure Tf_detail.bt_hoja_pickClick(Sender: TObject);
var
  i,j,ubi, id_lote:integer;
  agencia_txt, est, posi, alt, sub1, sub2: string;
  str_dyn:TStringDynArray;
  repe: TStringList;
  enc, es_devo: Boolean;
  serv, hora, ret, devo: integer;
begin

  if main_cli=7078 then
  begin
     with TpFIBDataSet.Create(self) do
      try
        Database:=dm.db;
        SQLs.SelectSQL.Clear;
        sqls.SelectSQL.Add('select valor from c_pedidos_extras where id_pedido=:pedido and descripcion=''PDF_PATH'' ');
        ParamByName('pedido').AsInteger := id_pedido_actual;
        Open;
        First;

        if FieldByName('valor').AsString<>'' then
          ShellExecute(Handle, nil, PChar(FieldByName('valor').asstring), nil,  nil, SW_SHOWNORMAL);

      finally
        free;
      end;


     Exit;
  end;


  if codalbaran_actual>0 then

       dm_pick.imprime_hoja_pick('v','',tiene_lotes,codalbaran_actual)
  else begin
    ar_pick_ds.Close;
    ar_pick_ds.Active:=true;
    ar_pick_ds.EmptyDataSet;

    repe := TStringList.Create;

    cdsLines.First;

    while not cdsLines.Eof do
    begin

      if not u_main.tiene_lotes then      //Clientes sin lotes
      begin

        BuscarUbicacionDeArticulo(cdsLines.FieldByName('id_articulo').AsInteger,id_almacen, ubi, est, posi, alt, sub1, sub2, id_lote);

        if rgTransporte.ItemIndex = 0 then
          agencia_txt := cb_repartidor.Text
        else
          agencia_txt := '';

        GetServHoraPedido(id_pedido_actual, serv, hora, ret);

        es_devo := EsDevo(id_pedido_actual);

        if es_devo then
          devo := 1
        else
          devo := 0;

        InsertLinePicking(cdsLines.FieldByName('id_articulo').AsInteger,       //id_art
                          UpperCase(cdsLines.FieldByName('referencia').AsString),        //ref_art
                          cdsLines.FieldByName('cantidad').AsInteger,       //uds
                          cdsLines.FieldByName('imei').AsString,        //imei
                          0,                                   //tiene_lotes
                          '','',0,                               //lote, caducidad, uds_lote
                          ubi,
                          est + '-' + posi + '-' + alt + '-' + sub1,  //ubicacion
                          UpperCase(cdsLines.FieldByName('nombre').AsString),   //artículo
                          ed_order_name.Text,             //pedido
                          ed_nombre.Text,                 //nombre
                          ed_dir_1.Text,                  //direccion
                          ed_poblacion.Text,              //poblacion
                          ed_provincia.Text,              //provincia
                          ed_cp.Text,                     //cp
                          ed_email.Text,                  //email
                          ed_telefono.Text,               //telefono
                          StrToInt(ed_codalbaran.Text),   //codalbaran
                          //cb_delivery.Text,             //deliv_time
                          edCodPais.Text,                 //cod_pais
                          UpperCase(lbTag.Caption),       //tag
                          devo,                           //es_devo
                          ed_obs.Text,                    //observaciones
                          agencia_txt,                    //agencia_txt
                          cb_delivery.Text,               //dt_txt
                          edContacto.Text,                //contacto
                          (ret=1),                        //con retorno
                          IntToStr(serv),                 //servicio
                          IntToStr(hora));                //horario

      end else begin         //Clientes con lotes
                  enc := False;
                  for j := 0 to repe.Count-1 do
                  begin
                      enc := (cdsLines.FieldByName('id_articulo').AsString=repe[j]);
                  end;

                  if not enc then
                  begin
                    repe.Add(cdsLines.FieldByName('id_articulo').AsString);

                    dm.ds_2.Close;                                                            //datos de lotes
                    dm.ds_2.SQLs.SelectSQL.Clear;
                    dm.ds_2.SQLs.SelectSQL.Add('SELECT l.id_pedido as id_pedido, lt.id_lote, lt.nombre as lote, lt.caducidad, a.codigo, a.nombre as nom_art, sum(l.cantidad) as cantidad  '+
                      ' from c_pedidos_lines_lotes l ' +
                      ' left outer join a_lotes lt on lt.id_lote=l.id_lote ' +
                      ' left outer join g_articulos a on a.id_articulo=l.id_articulo ' +
                      ' where id_pedido=:id_pedido and l.id_articulo=:articulo ' +
                      ' group by 1,2,3,4,5,6');
                    dm.ds_2.ParamByName('id_pedido').AsInteger := id_pedido_actual;
                    dm.ds_2.ParamByName('articulo').AsInteger  := cdsLines.FieldByName('id_articulo').AsInteger;
                    dm.ds_2.Open;

                    if dm.ds_2.Eof then
                    begin
                        ShowMessage('No se han actualizado los lotes de este pedido.');
                        Exit;
                    end;

                    dm.ds_2.First;
                     while not dm.ds_2.eof do
                     begin
                       { if ar_pick_ds.Locate('id_art',cdsLines.FieldByName('id_articulo').asinteger,[]) then
                        begin
                             ar_pick_ds.Edit;
                             ar_pick_ds.FieldByName('uds').AsInteger := ar_pick_ds.FieldByName('uds').AsInteger + dm.ds_2.FieldByName('cantidad').AsInteger;
                             ar_pick_ds.Post;
                        end;     }

                         if not ar_pick_ds.Locate('id_art;lote',VarArrayOf([cdsLines.FieldByName('id_articulo').asinteger,Trim(dm.ds_2.FieldByName('lote').asstring)]),[]) then
                        begin

                          ar_pick_ds.insert;
                          ar_pick_ds.FieldByName('id_art').AsInteger := cdsLines.FieldByName('id_articulo').AsInteger;
                          ar_pick_ds.FieldByName('ref_art').AsString := cdsLines.FieldByName('referencia').AsString;
                          ar_pick_ds.FieldByName('uds').Asinteger := suma_cantidad_art_en_pedido(id_pedido_actual,cdsLines.FieldByName('id_articulo').AsInteger);
                          ar_pick_ds.FieldByName('imei').AsString    := cdsLines.FieldByName('imei').AsString;

                          BuscarUbicacionDeArticulo(cdsLines.FieldByName('id_articulo').AsInteger,id_almacen, ubi, est, posi, alt, sub1, sub2, id_lote);

                          ar_pick_ds.FieldByName('id_ubic').Asinteger  := ubi;
                          ar_pick_ds.FieldByName('ubicacion').Asstring := est + '-' + posi + '-' + alt + '-' + sub1;
                          ar_pick_ds.FieldByName('articulo').Asstring  := cdsLines.FieldByName('nombre').AsString;
                          ar_pick_ds.FieldByName('pedido').asstring    := ed_order_name.Text;
                          ar_pick_ds.FieldByName('nomape').asstring    := ed_nombre.Text;
                          ar_pick_ds.FieldByName('direccion').asstring := ed_dir_1.Text;
                          ar_pick_ds.FieldByName('poblacion').asstring := ed_poblacion.Text;
                          ar_pick_ds.FieldByName('provincia').asstring := ed_provincia.Text;
                          ar_pick_ds.FieldByName('cp').asstring        := ed_cp.Text;
                          ar_pick_ds.FieldByName('mail').asstring      := ed_email.Text;
                          ar_pick_ds.FieldByName('telefono').asstring:=ed_telefono.Text;
                          ar_pick_ds.FieldByName('codalbaran').AsInteger:=StrToInt(ed_codalbaran.Text);
                          ar_pick_ds.FieldByName('deliv_time').Asstring:=cb_delivery.Text;
                          ar_pick_ds.FieldByName('CodPais').Asstring:=edCodPais.Text;
                          ar_pick_ds.FieldByName('Tag').asstring:=UpperCase(lbTag.Caption);
                          ar_pick_ds.FieldByName('tiene_lotes').Asinteger := 1;
                          ar_pick_ds.FieldByName('observaciones').asstring:=ed_obs.Text;
                          ar_pick_ds.FieldByName('agencia_txt').asstring:= cb_repartidor.Text;
                          ar_pick_ds.FieldByName('dt_txt').asstring:= cb_delivery.Text;

                          ar_pick_ds.FieldByName('lote').asstring   := Trim(dm.ds_2.FieldByName('lote').asstring);
                          ar_pick_ds.FieldByName('caducidad').asstring   := dm.ds_2.FieldByName('caducidad').asstring;
                          ar_pick_ds.FieldByName('cantidad').AsInteger   := dm.ds_2.FieldByName('cantidad').AsInteger;

                          ar_pick_ds.FieldByName('con_retorno').AsBoolean := chRetorno.Checked;

                          ar_pick_ds.FieldByName('contacto').asstring   := edContacto.Text;

                          ar_pick_ds.FieldByName('servicio').asstring   := cbServicio.Text;
                          ar_pick_ds.FieldByName('horario').asstring   := cbHorario.Text;
                          ar_pick_ds.FieldByName('pie_hoja_pick').asstring   := pie_hoja_pick;
                          ar_pick_ds.Post;
                        end;

                        dm.ds_2.Next;
                     end;
                  end;
      end;

      //ar_pick_ds.Post;
      cdsLines.Next;
    end;

    if ar_pick_ds.RecordCount>0 then
        LanzaImpresion;

  repe.Free;
  end;

end;

procedure Tf_detail.bt_pdfClick(Sender: TObject);
begin

  if not FileExists(pdf_act) then
      ShowMessage('No se encuentra el fichero ' + pdf_act)
  else
      ShellExecute(Handle, nil, PChar(pdf_act), nil,  nil, SW_SHOWNORMAL);
end;

procedure Tf_detail.bt_print_etiClick(Sender: TObject);
begin
if dm.q_peds.FieldByName('origen_web').AsInteger=1 then
   begin
      try
          if dmLabels.GetFormatoEtiqueta(codalbaran_actual)='ETI_LOGINSER' then
          begin
             dmLabels.imp_eti := u_globals.imp_eti;
             dmLabels.imprime_etiqueta_loginser(codalbaran_actual,gestdest_actual, u_main.logo_cli_etiq);
             InsertaLog(u_main.usuario.id,id_pedido_actual,0,PC.Nombre,PC.IP,log_app,'pedido','',
                       'Et.Lgs. ' + IntToStr(codalbaran_actual),'');
          end
          else begin
             imprime_etiqueta_x_api(codalbaran_actual);
             InsertaLog(u_main.usuario.id,id_pedido_actual,0,PC.Nombre,PC.IP,log_app,'pedido','',
                       'Et.API ' + IntToStr(codalbaran_actual),'');
          end;

         f_main.CambiaEstadoPedido(IntToStr(id_pedido_actual), 'G', 'E');

         if gestion_cola and (estado_actual<>cb_estado.Text[1]) then
         begin
             dmEstadoPedido.estadopedido(id_pedido_actual);
             InsertaLog(u_main.usuario.id,id_pedido_actual,0,PC.Nombre,PC.IP,log_app,'pedido','',
                       'BtEt.EnvColaEst.','');
         end;

      except

      end;

   end else begin
              with TpFIBDataSet.Create(self) do
              try
                Database:=dm.db;
                SQLs.SelectSQL.Clear;
                sqls.SelectSQL.Add('select * from c_pedidos_etiquetas where id_pedido=:pedido');
                ParamByName('pedido').AsInteger := id_pedido_actual;
                Open;
                First;

                while not Eof do
                begin
                  if FieldByName('cod_envio').AsString<>'' then
                  begin
                   if ((pais_code_act = 'ES') or (pais_code_act='PT')) then
                       f_main.ImprimeEtiqueta(FieldByName('cod_envio').AsString + '.pdf','H');
                   {else
                       f_main.ImprimeEtiqueta(FieldByName('cod_envio').AsString + '.pdf','V'); }
                  end;
                   Next;
                end;

              finally
                free;
              end;
            end;
end;


procedure Tf_detail.imprime_etiqueta_x_api(codalbaran:integer);
var
    tracking, error:string;
    texto: string;

begin
        try
            if get_albaran_data('expedicion_age',codalbaran)='' then
            begin
              if codalbaran>0 then
              begin
                //DMCreaBultos.GeneraBultos(codalbaran_actual,gestdest_actual);
                dm.t_write_gestoras.StartTransaction;
                try
                  u_cam_gl.inserta_etiq_tmp(id_usuario,codalbaran);
                  dm.t_write_gestoras.Commit;
                except
                  dm.t_write_gestoras.Rollback;
                end;

                If ValidaAlbaran(IntToStr(codalbaran),texto)  then
                begin
                  DMLstEtiquetas.ObtenEtiquetas('A',IntToStr(codalbaran),True);
                  lbExpAgencia.Caption := get_albaran_data('expedicion_age',codalbaran);
                  if texto<>'' then
                     raise Exception.Create(texto);
                     // ShowMessage(texto);
                end;
              end;
            end else
                    DMLstEtiquetas.ObtenEtiquetas('A',IntToStr(codalbaran),True);

          //Imprimir más de una
          {  DMCreaBultos.GeneraBultos(dm.q_peds.FieldByName('codalbaran').AsInteger,dm.q_peds.FieldByName('gestoras_dest').AsInteger);

            error := u_cam_gl.inserta_etiq_tmp(id_usuario,dm.q_peds.FieldByName('codalbaran').AsInteger);

            if error<>'' then
            begin
               imprime_etiq_tmp(u_main.id_usuario);
            end;      }
        except
             raise Exception.Create('Error generando bultos. ' + texto);
        end;
end;

{$ENDREGION 'Print'}

procedure Tf_detail.RellenaRepartidores;
begin
    with TpFIBDataSet.Create(self) do
    try
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select * from g_agencias order by id_agencia');
      Open;
      First;
      cb_repartidor.Items.Clear;
      cb_repartidor.Items.Add('NO DEFINIDO');
      while not Eof do
      begin
         cb_repartidor.Items.Insert(FieldByName('ID_AGENCIA').AsInteger,FieldByName('NOMBRE').AsString);
         Next;
      end;

    finally
      free;
    end;
end;

procedure Tf_detail.filter_lotes;
begin

    with dm.q_peds_lines_lotes do
    begin
       Close;
       ParamByName('id_pedido').AsInteger := id_pedido_actual;
       ParamByName('id_articulo').AsInteger := StrToInt(lb_id_art.Caption);
       Open;
    end;

    with dm.qStockLotes do
    begin
       Close;
       ParamByName('id_articulo').AsInteger := StrToInt(lb_id_art.Caption);
       ParamByName('id_almacen').AsInteger := u_main.id_almacen;
       Open;
    end;

end;

procedure Tf_detail.filter_relaciones;
begin

    with dm.q_arts_relacionados do
    begin
       Close;
       ParamByName('id_articulo').AsInteger := StrToInt(lb_id_art.Caption);
       Open;
    end;

end;

procedure Tf_detail.filter_extras;
begin
    with dm.q_peds_lines_extras do
    begin
       Close;
       ParamByName('id_pedido').AsInteger := id_pedido_actual;
       ParamByName('line').AsInteger := StrToInt(lb_id_line.Caption);
       Open;
    end;

end;

{$REGION 'Interfaz'}
procedure Tf_detail.edClienteChange(Sender: TObject);
begin
  If edCliente.Text<>'' then
     begin
        lbCli.Caption := f_main.BuscaClienteGesFile(StrToInt(edCliente.Text));
        //filter;
     end;

     if lbCli.Caption='' then
               lbCli.Caption := '(Seleccione un cliente)';
end;

procedure Tf_detail.edIMEIKeyPress(Sender: TObject; var Key: Char);
var  linea:integer;
  order_name: string;
begin
  if Key=chr(13) then begin
    if tiene_n_serie then
    begin
      {if (Copy(edIMEI.Text,0,length(cdsLines.fieldbyname('sku').AsString))<>cdsLines.fieldbyname('sku').AsString) then
        if MessageDlg('PATRON INCORRECTO (sku + ...),¿desea continuar?',mtWarning,mbYesNo,0,mbNo)=mrNo then
          Exit;
       }

       linea:=guarda_line+1;

       cdsLines.DisableControls;

       if edIMEI.Text<>'' then
        begin

          dm.t_write.StartTransaction;

          try
            dm.q_1.Close;
            dm.q_1.sql.Clear;
            dm.q_1.sql.Add('update c_pedidos_lines set n_serie=:n_serie where id_pedido=:id_pedido and id_line=:linea');

            dm.q_1.ParamByName('id_pedido').AsInteger := id_pedido_actual;
            dm.q_1.ParamByName('linea').AsInteger := linea-1;
            dm.q_1.ParamByName('n_serie').AsString := edIMEI.Text;
            dm.q_1.ExecQuery;

            dm.t_write.Commit;

            {cdsLines.Edit;
            cdsLines.FieldByName('n_serie').AsString := edNSerie.Text;
            cdsLines.Post;   }

            InsertaLog(u_main.usuario.id,id_pedido_actual,0,PC.Nombre,PC.IP,log_app,'pedido','',
                       'DetalleLinea.Pistoleado NSerie ' + edIMEI.Text,'L. ' + IntToStr(linea-1) + ' Art. ' + edIdArtNSerie.Text);
          except
            dm.t_write.rollback;
          end;
        end else
              raise exception.Create('Nº Serie Vacío');

       actualiza_pistoleo;

       dm.q_peds_lines.Close;
       dm.q_peds_lines.Open;

       cdsLines.EnableControls;

       if (linea<=cdsLines.RecordCount) then
       begin
           cdsLines.Locate('linea',linea,[]);
           while (linea<cdsLines.RecordCount) and not art_tiene_n_serie(cdsLines.FieldByName('id_articulo').AsInteger) do
           begin
              Inc(linea);
              cdsLines.Next;
           end;

           if (linea<=cdsLines.RecordCount) then
           begin
             cdsLines.Locate('linea',linea,[]);

             get_line_data;
             edIMEI.Setfocus;
           end;
       end;

    end else if tiene_imei then
        begin
          if (Length(edIMEI.Text)<>15) then
              raise Exception.Create('Longitud de IMEI incorrecta.');

          with tpfibdataset.Create(dm) do begin
              database:=dm.db;
              SQLs.SelectSQL.Clear;
              SQLs.SelectSQL.Add('SELECT * FROM A_IMEIS WHERE IMEI=:imei ');
              Params.ParamByName('imei').asString := edImei.Text;
              Open;

              if not IsEmpty then
              begin
                 If EsOtroArticulo(edImei.Text) then
                 begin
                    raise Exception.Create('El IMEI pertenece a otro artículo.');
                    edImei.SelectAll;
                    Exit;
                 end;

                if IMEIUtilizado(edIMEI.Text, order_name)>-1 then
                begin
                    raise Exception.Create('IMEI utilizado anteriormente (Pedido ' + order_name + ').');
                    Exit;
                 end;

                if lb_id_line.Caption<>'' then
                  if not(check_nserie(edIMEI.text,StrToInt(lb_id_line.Caption)-1)) then raise exception.Create('IMEI Ya Pistoleado En Esta Expedición');

                linea:=guarda_line+1;

                if linea<cdsLines.RecordCount then
                begin
                     cdsLines.Locate('linea',linea,[]);

                     get_line_data;
                     edIMEI.Setfocus;
                end;
              end else
                    raise Exception.Create('El IMEI no existe para ninguna matrícula.');
              Free;
          end;
        end;
  end;
end;

procedure Tf_detail.edNSerieKeyPress(Sender: TObject; var Key: Char);
var
  enc: Boolean;
  linea: integer;
begin
   if Key=chr(13) then begin

      if edIdArtNSerie.Value>=0 then begin

        {if (Copy(edNSerie.Text,0,length(cdsLines.fieldbyname('sku').AsString))<>cdsLines.fieldbyname('sku').AsString) then
        if MessageDlg('PATRON INCORRECTO (sku + ...),¿desea continuar?',mtWarning,mbYesNo,0,mbNo)=mrNo then
          Exit;  }

        enc := False;

        linea := cdsLines.fieldbyname('linea').AsInteger;

        cdsLines.DisableControls;

        if ((edNSerie.Text<>'') and  not(check_nserie(edNSerie.text,cdsLines.FieldByName('linea').AsInteger))) then
        begin
          edNSerie.Text := '';
          cdsLines.EnableControls;
          cdsLines.Locate('linea',linea,[]);
          raise exception.Create('Nº Serie Ya Pistoleado En Esta Expedición');
        end;

        if edNSerie.Text<>'' then
        begin

          dm.t_write.StartTransaction;

          try
            dm.q_1.Close;
            dm.q_1.sql.Clear;
            dm.q_1.sql.Add('update c_pedidos_lines set n_serie=:n_serie where id_pedido=:id_pedido and id_line=:linea');

            dm.q_1.ParamByName('id_pedido').AsInteger := id_pedido_actual;
            dm.q_1.ParamByName('linea').AsInteger := linea;
            dm.q_1.ParamByName('n_serie').AsString := edNSerie.Text;
            dm.q_1.ExecQuery;

            dm.t_write.Commit;

            {cdsLines.Edit;
            cdsLines.FieldByName('n_serie').AsString := edNSerie.Text;
            cdsLines.Post;   }

            InsertaLog(u_main.usuario.id,id_pedido_actual,0,PC.Nombre,PC.IP,log_app,'pedido','',
                       'Pistoleado NSerie ' + edNSerie.Text,'L. ' + IntToStr(linea) + ' Art. ' + edIdArtNSerie.Text);
          except
            dm.t_write.rollback;
          end;
        end else
              raise exception.Create('Nº Serie Vacío');


        edNSerie.Text := '';
        //edNSerie.Enabled := False;
        //edEanNSerie.Enabled :=  True;
        //edEanNSerie.SetFocus;

        dm.q_peds_lines.Close;
        dm.q_peds_lines.Open;

        cdsLines.EnableControls;
        read_lines;

        //cdslines.Locate('linea',linea,[]);

        Inc(linea);

        if linea<cdsLines.RecordCount then
        begin
             cdsLines.Locate('linea',linea,[]);

             get_line_data;
             edNSerie.Setfocus;
        end;
      end
      else begin
          if FileExists(ruta_exe+'Audio\Error.wav') then sndPlaySound(PChar(ruta_exe+'Audio\Error.wav'),SND_NODEFAULT Or SND_ASYNC);
          edNSerie.SetFocus;
      end;

      edNSerie.Text := '';
      edEanNSerie.Enabled := PedidoFaltaNSerie(id_pedido_actual);

      If not edEanNSerie.Enabled then
           gbNSList.Caption := 'Informe pistoleados';

      actualiza_pistoleo;

      if (lines_n_serie_pistoleadas_x_art=lines_n_serie_total_x_art) and edEanNSerie.Enabled then
         edEanNSerie.SetFocus;
   end;

end;

procedure Tf_detail.edEanNSerieKeyPress(Sender: TObject; var Key: Char);
var
  id_articulo: Integer;

begin
  if Key=chr(13) then begin

    InsertaLog(u_main.usuario.id,id_pedido_actual,0,PC.Nombre,PC.IP,log_app,'pedido','',
    'Leido EAN ' + edEanNSerie.Text,'');

    gbNSList.Visible := True;

    if length(edEanNSerie.Text)>20 then
    begin
      lbEan.Caption:='MAX. 20 LARGO';
      lbEan.Font.Color := clRed;
      id_articulo := -1;
      sndPlaySound(PChar(ruta_exe+'Audio\Error.wav'),SND_NODEFAULT Or SND_ASYNC);
      edIdArtNSerie.Value := id_articulo;
      edEanNSerie.Text := '';
      InsertaLog(u_main.usuario.id,id_pedido_actual,0,PC.Nombre,PC.IP,log_app,'pedido','',
      'Largo EAN ' + edEanNSerie.Text,'');
      Exit;
    end;

    id_articulo := get_art_x_bc(edEanNSerie.Text,main_cli);

    if id_articulo=-1 then begin
      //EAN not found
      lbEan.Caption:='NO ENCONTRADO';
      lbEan.Font.Color := clRed;

      if FileExists(ruta_exe+'Audio\Error.wav') then sndPlaySound(PChar(ruta_exe+'Audio\Error.wav'),SND_NODEFAULT Or SND_ASYNC);

      InsertaLog(u_main.usuario.id,id_pedido_actual,0,PC.Nombre,PC.IP,log_app,'pedido','',
      'No encontrado EAN ' + edEanNSerie.Text,'Art.-1');

      edNSerie.Enabled := False;
      edEanNSerie.Setfocus;

    end else if id_articulo=-2 then begin
                //EAN duplicado
                lbEan.Caption:='EAN DUPLICADO';
                lbEan.Font.Color := clRed;

                if FileExists(ruta_exe+'Audio\Error.wav') then sndPlaySound(PChar(ruta_exe+'Audio\Error.wav'),SND_NODEFAULT Or SND_ASYNC);

                InsertaLog(u_main.usuario.id,id_pedido_actual,0,PC.Nombre,PC.IP,log_app,'pedido','',
                'Duplicado EAN ' + edEanNSerie.Text,'Art.-2');

                //edNSerie.Enabled := False;
                edEanNSerie.Setfocus;

              end else begin

                    If existe_art_en_pedido(id_pedido_actual,id_articulo) then
                    begin
                        ejecuta_comprobacion_articulo(0,id_articulo); //modo 0 ean

                        // Todo este código esta dentro de ejecuta_compro..., eliminar si funciona
                        {if art_tiene_n_serie(id_articulo) then
                        begin
                          If not cdsLines.Locate('id_articulo;n_serie',VarArrayOf([id_articulo,'']),[]) then
                          begin
                            //EAN duplicado
                                lbEan.Caption:='ART. COMPLETO';
                                lbEan.Font.Color := clRed;

                                InsertaLog(u_main.usuario.id,id_pedido_actual,0,PC.Nombre,PC.IP,log_app,'pedido','',
                                    'Art.Completo EAN ' + edEanNSerie.Text,'Art.'+ IntToStr(id_articulo));

                                id_articulo := -1;

                                edNSerie.Enabled := False;
                                edEanNSerie.SetFocus;
                          end else begin

                                     //lbNSerieArt.Caption := get

                                    lbEan.Caption:='OK';
                                    lbEan.Font.Color := clGreen;

                                    get_line_data;

                                    gbNSList.Caption := 'ESCANEANDO...';
                                    lbNSerieArt.Caption := cdsLines.FieldByName('sku').AsString + #13#10 + cdsLines.FieldByName('nombre').AsString;
                                    actualiza_pistoleo;

                                    InsertaLog(u_main.usuario.id,id_pedido_actual,0,PC.Nombre,PC.IP,log_app,'pedido','',
                                    'Ok EAN ' + edEanNSerie.Text,'L.' + cdsLines.FieldByName('linea').AsString + ' Art.'+ IntToStr(id_articulo));

                                    edNSerie.Enabled := True;
                                    edNSerie.Setfocus;
                                   end;

                        end else begin

                              lbEan.Caption:='ART. SIN Nº SERIE';
                              lbEan.Font.Color := clRed;

                              if FileExists(ruta_exe+'Audio\Error.wav') then sndPlaySound(PChar(ruta_exe+'Audio\Error.wav'),SND_NODEFAULT Or SND_ASYNC);

                              InsertaLog(u_main.usuario.id,id_pedido_actual,0,PC.Nombre,PC.IP,log_app,'pedido','',
                              'ArtSinNSerie EAN ' + edEanNSerie.Text,'');

                              edNSerie.Enabled := False;
                              edEanNSerie.Setfocus;
                        end;     }

                    end else begin
                                //EAN duplicado
                                lbEan.Caption:='ART. NO EXISTE EN PED.';
                                lbEan.Font.Color := clRed;

                                InsertaLog(u_main.usuario.id,id_pedido_actual,0,PC.Nombre,PC.IP,log_app,'pedido','',
                                    'ArtNoExisteEnPed. EAN ' + edEanNSerie.Text,'Art.'+ IntToStr(id_articulo));

                                if FileExists(ruta_exe+'Audio\Error.wav') then sndPlaySound(PChar(ruta_exe+'Audio\Error.wav'),SND_NODEFAULT Or SND_ASYNC);
                                edNSerie.Enabled := False;
                                edEanNSerie.Setfocus;
                        end;
                  end;

    edIdArtNSerie.Value := id_articulo;
    edEanNSerie.Text := '';
  end;
end;

procedure Tf_detail.edReembolsoExit(Sender: TObject);
begin
  imgReemb.Visible := (edReembolso.Value>0);
end;

procedure Tf_detail.cbHorarioClick(Sender: TObject);
begin
  if (BuscaGrupoCliente(StrToInt(edCliente.Text))=6) and (cbHorario.ItemIndex>0) then
    BuscaHorarioGestoras(Integer(cbHorario.Items.Objects[cbHorario.ItemIndex]),StrToInt(edCliente.Text),id_repartidor_actual);
end;

procedure Tf_detail.cbServicioClick(Sender: TObject);
begin
     RellenaHorario(Integer(cbServicio.Items.Objects[cbServicio.ItemIndex]));
     cbHorario.ItemIndex := 0;
end;

procedure Tf_detail.cb_deliveryClick(Sender: TObject);
begin
  if (((main_cli=5105) or
       (main_cli=5106) or
       (main_cli=5110)) and
       (cb_delivery.Text <> 'ENTREGA MERYDEIS')) then
       begin
         rgTransporte.ItemIndex := 1;
         cb_repartidor.ItemIndex := cb_repartidor.IndexOf('NO DEFINIDO');
       end else if (cb_delivery.Text = 'ENTREGA MERYDEIS') then
                begin
                    rgTransporte.ItemIndex := 1;
                    cb_repartidor.ItemIndex := cb_repartidor.IndexOf('LOGINSER');
                end
                else
                begin
                  rgTransporte.ItemIndex := 0;
                  cb_repartidor.ItemIndex := id_repartidor_actual;
                end;

end;

procedure Tf_detail.cb_repartidorClick(Sender: TObject);
var
  texto: string;
begin
//  RellenaDeliveryTime(rgTransporte.ItemIndex,
//                      main_cli,
//                      cb_repartidor.ItemIndex);
  Texto := cb_repartidor.Text;

  if mode=1 then
  begin
            cb_delivery.Items.Clear;
            cb_delivery.Items.Add('10');
            cb_delivery.Items.Add('24');
            cb_delivery.Items.Add('48');
            cb_delivery.Items.Add('72');
            if txt_tpropio <> '' then
                   cb_delivery.Items.Add(txt_tpropio);
  end else
  begin
      case cb_delivery.IndexOf(dm.q_peds.FieldByName('deliv_time_txt').AsString) of
         -1: if rgTransporte.ItemIndex=0 then cb_delivery.ItemIndex := 0 else cb_delivery.ItemIndex := cb_delivery.IndexOf(txt_tpropio);
         0..100: cb_delivery.ItemIndex := cb_delivery.IndexOf(dm.q_peds.FieldByName('deliv_time_txt').AsString);
      end;
  end;

  id_repartidor_actual := cb_repartidor.ItemIndex;
  id_agencia_en_gestoras := GetRelacionAgencia(cb_repartidor.ItemIndex);

  RellenaTipoServicio;
    cbServicio.ItemIndex := Integer(cbServicio.Items.IndexOfObject(TObject(dm.q_peds.fieldbyname('tipo_servicio').AsInteger)));
    if cbServicio.ItemIndex=-1 then cbServicio.ItemIndex := 0;

    RellenaHorario(dm.q_peds.fieldbyname('tipo_servicio').asinteger);
    cbHorario.ItemIndex := Integer(cbHorario.Items.IndexOfObject(TObject(dm.q_peds.fieldbyname('horario').AsInteger)));
    if cbHorario.ItemIndex=-1 then cbHorario.ItemIndex := 0;

  if texto<>cb_repartidor.Text then
    sShowMessage('Ha modificado el repartidor. Por favor, revise SERVICIO y HORARIO antes de guardar.');
end;

procedure Tf_detail.chRetornoClick(Sender: TObject);
begin
  imgRetorno.Visible := chRetorno.Checked;
end;

procedure Tf_detail.bt_guardarClick(Sender: TObject);
begin

 { if cuenta_lineas_pedido(id_pedido_actual)>max_ln_det then
  begin
    ShowMessage('Pedido con muchas lineas. Guardado deshabilitado.');
    Exit;
  end;
      }

  If ed_dir_1.Text='' then
  begin
    ShowMessage('Por favor, introduzca una dirección de destino válida.');
    Exit;
  end;

  If ed_poblacion.Text='' then
  begin
    ShowMessage('Por favor, introduzca una población válida.');
    Exit;
  end;

  If ed_provincia.Text='' then
  begin
    ShowMessage('Por favor, introduzca una provincia válida.');
    Exit;
  end;

  If edCodPais.Text='' then
  begin
    ShowMessage('Por favor, introduzca un código de pais válido.');
    Exit;
  end;

  If ed_nombre.Text='' then
  begin
    ShowMessage('Por favor, introduzca el nombre del destinatario.');
    Exit;
  end;

  If ed_CP.Text='' then
  begin
    ShowMessage('Por favor, introduzca un código postal válido.');
    Exit;
  end;

  If ((cbServicio.ItemIndex=0) or (cbHorario.ItemIndex=0)) then
  begin
    ShowMessage('Por favor, revise servicio y horario.');
    Exit;
  end;

  If not (StrToInt(ed_bultos.Text)>0) then
  begin
    ShowMessage('Por favor, revise la cantidad de bultos.');
    Exit;
  end;

  if BuscaGrupoCliente(StrToInt(edCliente.Text))=6 then
     if not VerificaHorarioGestoras(Integer(cbHorario.Items.Objects[cbHorario.ItemIndex]),StrToInt(edCliente.Text),dm.q_peds.fieldbyname('id_repartidor').AsInteger,cb_delivery.Text) then
        If MessageDlg('El Delivery Time seleccionado no corresponde con Servicio y Horario. ¿Desea continuar?',mtWarning,mbYesNo,0,mbNo)=mrNo then
            Exit;

  InsertaLog(u_main.usuario.id,id_pedido_actual,0,PC.Nombre,PC.IP,log_app,'pedido','','Bt.Guardar Pedido','');
  //ShowMessage('ini guardar');
  save_exp;
  //ShowMessage('fin guardar');

  {if (main_cli<>7078) then
     close;  }
end;

procedure Tf_detail.habilitar_botones_detalle(estado:Boolean);
begin
  //bt_guardar.enabled := estado;
  bt_new.enabled := estado;
  bt_delete.enabled := estado;
  bt_save_line.enabled := estado;
  btCancelLine.enabled := estado;
  if estado=true then
      lbEstadoGest.Font.Color := 32768
  else
      lbEstadoGest.Font.Color := 255;

end;
{$ENDREGION 'Interfaz'}

{$REGION 'Buscadores'}

procedure Tf_detail.RellenaDeliveryTime(t,cliente,agencia:Integer);
var
  str_agencia:TStringList;
  i: integer;
begin
   cb_delivery.Clear;

   str_agencia := TStringList.Create;
   str_agencia.Delimiter := '|';
   //str_agencia.QuoteChar := '|';

   str_agencia.DelimitedText := f_main.CargarDatosAgencia('delivery_time',cliente,agencia);

   i := 0;
   for i:=0 to str_agencia.Count-1 do
   begin
     cb_delivery.Items.Add(str_agencia[i]);
   end;
   str_agencia.Free;

   if cb_delivery.Items.Count = 0 then
       cb_delivery.Items.Add(IntToStr(delivery_time));

  if mode=1 then  //Es nuevo
  begin
      cb_delivery.Items.Clear;
      cb_delivery.Items.Add('10');
      cb_delivery.Items.Add('24');
      cb_delivery.Items.Add('48');
      cb_delivery.Items.Add('72');
  end;

   if txt_tpropio <> '' then
          cb_delivery.Items.Add(txt_tpropio);

end;


procedure Tf_detail.RellenaTipoServicio;
var
  str_agencia:TStringList;
begin
   cbServicio.Clear;
   cbServicio.AddItem('NO DETERMINADO',TObject(0));

   with tpfibdataset.Create(dm) do begin
    try
      database:=dm.db_gestoras;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select distinct s.* ' +
                         'from servicios s ' +
                         'inner join servicios_agencia sa on sa.codigo=s.codigo ' +
                         'where s.baja=0 and sa.agencia=:agencia and sa.retorno=0 ');
      ParamByName('agencia').AsInteger := id_agencia_en_gestoras;
      Open;
      First;

      if not(IsEmpty) then
      begin
        while not Eof do
        begin
          //cbServicio.AddItem(fieldbyname('titulo_agencia').asString, TObject(fieldbyname('codigo').asinteger));
          cbServicio.AddItem(fieldbyname('descripcion').asString, TObject(fieldbyname('codigo').asinteger));
          Next;
        end;
      end;
    finally
        free;
    end;
   end;
end;

procedure Tf_detail.RellenaHorario(servicio:Integer);
var
  str_agencia:TStringList;
begin
   cbHorario.Clear;
   cbHorario.AddItem('NO DETERMINADO',Tobject(0));

   with tpfibdataset.Create(dm) do begin
    try
      database:=dm.db_gestoras;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select distinct h.* ' +
                         'from servicios_horarios sh ' +
                         'inner join horarios h on h.horario=sh.horario ' +
                         'inner join horarios_agencia ha on ha.horario=h.horario ' +
                         'where sh.servicio=:servicio and h.baja=0 and ' +
                         'ha.agencia=:agencia and ha.retorno=0 ');
      ParamByName('servicio').AsInteger := servicio;
      ParamByName('agencia').AsInteger := id_agencia_en_gestoras;
      Open;

      if not(IsEmpty) then
      begin
        while not Eof do
        begin
          cbHorario.AddItem(fieldbyname('descripcion').asString, TObject(fieldbyname('horario').asinteger));
          Next;
        end;
      end;
    finally
        free;
    end;
   end;
end;


function Tf_detail.BuscaHorarioGestoras(horario,cliente,agencia:integer):string;
var
  str_horarios, str_dt, str_horario:TStringList;
  i,j: integer;
  enc: Boolean;
begin

   str_dt := TStringList.Create;
   str_dt.Delimiter := '|';
   str_dt.DelimitedText := f_main.CargarDatosAgencia('delivery_time',cliente,agencia);

   str_horarios := TStringList.Create;
   str_horarios.Delimiter := '|';
   str_horarios.DelimitedText := f_main.CargarDatosAgencia('horario_gestoras',cliente,agencia);

   str_horario := TStringList.Create;
   str_horario.Delimiter := ',';

   i := 0;
   j := 0;
   enc := False;

   for j:=0 to str_horarios.Count-1 do
   begin
     str_horario.DelimitedText := str_horarios[j];
     for i:=0 to str_horario.Count-1 do
     begin
       if str_horario[i]=IntToStr(horario) then
       begin
           cb_delivery.ItemIndex := cb_delivery.IndexOf(str_dt[j]);
           enc := True;
       end;
     end;
   end;

   if (txt_tpropio<>'') then
   begin
      If (not enc) then
       cb_delivery.ItemIndex := cb_delivery.IndexOf(txt_tpropio)
   end else
          cb_delivery.ItemIndex := 0;

   str_horario.Free;
   str_dt.Free;
   str_horarios.Free;

end;

function Tf_detail.VerificaHorarioGestoras(horario,cliente,agencia:integer; dt:string):Boolean;
var
  str_horarios, str_dt, str_horario:TStringList;
  i,j: integer;
  enc: Boolean;
begin

   str_dt := TStringList.Create;
   str_dt.Delimiter := '|';
   str_dt.DelimitedText := f_main.CargarDatosAgencia('delivery_time',cliente,agencia);

   str_horarios := TStringList.Create;
   str_horarios.Delimiter := '|';
   str_horarios.DelimitedText := f_main.CargarDatosAgencia('horario_gestoras',cliente,agencia);

   str_horario := TStringList.Create;
   str_horario.Delimiter := ',';

   i := 0;
   j := 0;
   enc := False;
   result := False;

   for j:=0 to str_horarios.Count-1 do
   begin
     str_horario.DelimitedText := str_horarios[j];
     for i:=0 to str_horario.Count-1 do
     begin
       if str_horario[i]=IntToStr(horario) then
           Result := (str_dt[j]=dt);
     end;
   end;

   str_horario.Free;
   str_dt.Free;
   str_horarios.Free;

end;

{$ENDREGION 'Buscadores'}

function Tf_detail.check_nserie(nserie:string; nline:integer):Boolean;                  //true=ok false=error or repeated
var
  i:Integer;
  enc: Boolean;
  resultado: string;
begin
  Result:=true;

  enc := False;
  i := 0;

  cdsLines.First;
  while (not enc) and (not cdsLines.eof) do
  begin
    Inc(i);
    if ((i<>nline) and (cdsLines.FieldByName('n_serie').AsString=nserie)) then begin
      result:=false;
      enc := True;
    end;
    cdsLines.Next;
  end;

end;


procedure Tf_detail.chNSerieSeleccClick(Sender: TObject);
begin
   edEanNSerie.Enabled := not chNSerieSelecc.Checked;
   if edEanNSerie.Enabled then
   begin
        edIdArtNSerie.Value := -1;
        edEanNSerie.Text := '';
        lbEan.Caption := '';
        edEanNSerie.SetFocus;
   end else begin
              edIdArtNSerie.Value := cdsLines.FieldByName('id_articulo').AsInteger;
              ejecuta_comprobacion_articulo(1,cdsLines.FieldByName('id_articulo').AsInteger);  //modo 1 click en detalle
       end;

end;

function Tf_detail.EsOtroArticulo(imei:string):Boolean;
var
  f_ultima_matricula: tdatetime;
begin
  with tpfibdataset.Create(dm) do begin
      database:=dm.db;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('SELECT * FROM A_MATRICULAS M ' +
                         'INNER JOIN A_IMEIS I ON I.ID_MATRICULA=M.ID_MATRICULA ' +
                         'INNER JOIN G_ARTICULOS A ON A.ID_ARTICULO=M.ID_ARTICULO ' +
                         'WHERE I.IMEI=:imei and m.id_articulo<>:id_articulo');
      Params.ParamByName('imei').asString := imei;
      Params.ParamByName('id_articulo').AsInteger := StrToInt(lb_id_art.Caption);
      Open;

      result := not IsEmpty;

      Free;
   end;
end;

function Tf_detail.IMEIUtilizado(imei: string; out order_name:string):integer;
var
  f_ultima_matricula: TDateTime;
begin
  order_name := '';
  result := -1;

  with tpfibdataset.Create(dm) do begin
      database:=dm.db;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('SELECT max(m.fecha) as fecha FROM A_MATRICULAS M ' +
                         'INNER JOIN A_IMEIS I ON I.ID_MATRICULA=M.ID_MATRICULA ' +
                         'WHERE I.IMEI=:imei');
      Params.ParamByName('imei').asString := imei;
      Open;

      f_ultima_matricula := FieldByName('fecha').AsDateTime;

      Free;
   end;

   with tpfibdataset.Create(dm) do begin
      database:=dm.db;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('SELECT L.ID_PEDIDO, P.ORDER_NAME FROM C_PEDIDOS_LINES L ' +
                         'INNER JOIN C_PEDIDOS P ON P.ID_PEDIDO=L.ID_PEDIDO ' +
                         'WHERE L.IMEI=:imei AND P.FECHA_GEN<=CURRENT_TIMESTAMP ' +
                         'AND L.ID_PEDIDO<>:id_pedido ' +
                         'AND P.FECHA_GEN>=:f_ult_matricula');
      Params.ParamByName('imei').asString := imei;
      Params.ParamByName('id_pedido').asinteger := StrToInt(ed_id_pedido.Text);
      Params.ParamByName('f_ult_matricula').AsDateTime := f_ultima_matricula;

      Open;

      if FieldByName('id_pedido').AsInteger>0 then
      Result := FieldByName('id_pedido').AsInteger;
      order_name := FieldByName('order_name').AsString;

      Free;
   end;
end;


 procedure Tf_detail.InsertLinePicking(id_art:Integer; ref_art:string; uds:Integer; imei:string; tiene_lotes:Integer; lote, caducidad:string; uds_lote,id_ubic: Integer;
                        ubic,articulo,pedido,nomape,direccion,poblacion,provincia,cp,mail,telefono:string; codalbaran:Integer;
                        cod_pais, tag:string; es_devo: Integer; observaciones, agencia_txt, dt_txt, contacto: string; con_retorno:Boolean;
                        servicio, horario:string);
begin
  ar_pick_ds.insert;
  ar_pick_ds.FieldByName('id_art').AsInteger := id_art;
  ar_pick_ds.FieldByName('ref_art').AsString := ref_art;
  ar_pick_ds.FieldByName('uds').Asinteger := uds;
  ar_pick_ds.FieldByName('imei').AsString := imei;
  ar_pick_ds.FieldByName('tiene_lotes').Asinteger := tiene_lotes;
  ar_pick_ds.FieldByName('lote').AsString := lote;
  ar_pick_ds.FieldByName('caducidad').AsString := caducidad;
  ar_pick_ds.FieldByName('cantidad').Asinteger := uds_lote;
  ar_pick_ds.FieldByName('id_ubic').Asinteger := id_ubic;
  ar_pick_ds.FieldByName('ubicacion').Asstring := ubic;
  ar_pick_ds.FieldByName('articulo').Asstring := articulo;
  ar_pick_ds.FieldByName('pedido').asstring := pedido;
  ar_pick_ds.FieldByName('nomape').asstring := nomape;
  ar_pick_ds.FieldByName('direccion').asstring := direccion;
  ar_pick_ds.FieldByName('poblacion').asstring := poblacion;
  ar_pick_ds.FieldByName('provincia').asstring := provincia;
  ar_pick_ds.FieldByName('cp').asstring := cp;
  ar_pick_ds.FieldByName('mail').asstring := mail;
  ar_pick_ds.FieldByName('telefono').asstring := telefono;
  ar_pick_ds.FieldByName('codalbaran').AsInteger := codalbaran;
  //ar_pick_ds.FieldByName('deliv_time').Asstring := deliv_time;
  ar_pick_ds.FieldByName('CodPais').Asstring := cod_pais;
  ar_pick_ds.FieldByName('Tag').asstring := tag;
  ar_pick_ds.FieldByName('EsDevo').AsInteger := es_devo;
  ar_pick_ds.FieldByName('observaciones').asstring := observaciones;
  ar_pick_ds.FieldByName('agencia_txt').asstring := agencia_txt;
  ar_pick_ds.FieldByName('dt_txt').asstring := dt_txt;
  ar_pick_ds.FieldByName('con_retorno').AsBoolean := con_retorno;
  ar_pick_ds.FieldByName('contacto').asstring   := contacto;
  ar_pick_ds.FieldByName('servicio').asstring   := servicio;
  ar_pick_ds.FieldByName('horario').asstring   := horario;
  ar_pick_ds.FieldByName('pie_hoja_pick').asstring   := pie_hoja_pick;
  if servicio<>'' then
      ar_pick_ds.FieldByName('serv_txt').AsString := CargarDatosTablaGestoras('servicios','descripcion','codigo='+servicio);
  if horario<>'' then
      ar_pick_ds.FieldByName('hora_txt').AsString := CargarDatosTablaGestoras('horarios','descripcion','horario='+horario);
  ar_pick_ds.Post;
end;




function Tf_detail.CreaJsonImei:TstringList;
var
  json: TStringList;
  i: integer;
  ref_act, linea_imei: string;
begin
     with TpFIBDataSet.Create(self) do
      try
        Database:=dm.db;
        SQLs.SelectSQL.Clear;
        sqls.SelectSQL.Add('select * from c_pedidos_lines where id_pedido=:pedido and imei<>'''' and imei is not null order by sku');
        ParamByName('pedido').AsInteger := id_pedido_actual;
        Open;
        First;

        if not IsEmpty then
        begin
          json := TStringlist.Create;

          json.Text := '{';
          json.Append('"id_order" : ' + dm.q_peds.FieldByName('id_order').AsString + ',');

          ref_act := '';
          linea_imei := '';

          while not Eof do
          begin
             if FieldByName('sku').AsString<>ref_act then
             begin
                 ref_act := FieldByName('sku').AsString;

                 if linea_imei<>'' then
                     json.Append(Copy(linea_imei,0,Length(linea_imei)-1)+'}},');

                 json.Append('"lineas" : {');
                 json.Append('"ref_art" : "' + FieldByName('sku').AsString + '","imei_list":{');
                 linea_imei := '"imei" : "' + FieldByName('imei').AsString + '",';
             end else begin
                         json.Append(linea_imei);
                         linea_imei := '"imei" : "' + FieldByName('imei').AsString + '",';
                      end;

             Next;
          end;
          json.Append(Copy(linea_imei,0,Length(linea_imei)-1)+'}}}');
        end;

        Result := json;
      finally
        free;
      end;


end;

procedure Tf_detail.EnviarIMEIaWeb;

begin
    SendIMEI(CreaCadenaIMEI);

    //ShowMessage(htmldevuelto);
    if Pos('Ok',htmldevuelto)>0 then
    begin
        ShowMessage('IMEI/s enviado/s correctamente.');
    end
    else
        ShowMessage('No se ha podido realizar el envío de IMEI.');
end;


function Tf_detail.CreaCadenaIMEI:string;
var
  cadena: string;
  i: integer;
  ref_act, linea_imei: string;
begin
     with TpFIBDataSet.Create(self) do
      try
        Database:=dm.db;
        SQLs.SelectSQL.Clear;
        sqls.SelectSQL.Add('select * from c_pedidos_lines where id_pedido=:pedido and imei<>'''' and imei is not null order by sku');
        ParamByName('pedido').AsInteger := id_pedido_actual;
        Open;
        First;

        if not IsEmpty then
        begin
          cadena := '';
          cadena := cadena + dm.q_peds.FieldByName('id_order').AsString + '|';

          ref_act := '';
          linea_imei := '';

          while not Eof do
          begin
             if FieldByName('sku').AsString<>ref_act then
             begin
                 ref_act := FieldByName('sku').AsString;

                 if linea_imei<>'' then
                     cadena := cadena + (Copy(linea_imei,0,Length(linea_imei)-1) + '|');

                 cadena := cadena + (FieldByName('sku').AsString + '|');
                 linea_imei := FieldByName('imei').AsString + '*';
             end else begin
                         cadena := cadena + (linea_imei);
                         linea_imei := FieldByName('imei').AsString + '*';
                      end;

             Next;
          end;
          cadena := cadena + (Copy(linea_imei,0,Length(linea_imei)-1));
        end;

        Result := cadena;
      finally
        free;
      end;
end;

function Tf_detail.CreaCadenaEstado:string;
var
  cadena: string;
  i: integer;
  ref_act, linea_imei: string;
begin
     with TpFIBDataSet.Create(self) do
      try
        Database:=dm.db;
        SQLs.SelectSQL.Clear;
        sqls.SelectSQL.Add('select * from c_pedidos where id_pedido=:pedido and codalbaran<>0 and codalbaran is not null');
        ParamByName('pedido').AsInteger := id_pedido_actual;
        Open;
        First;

        if not IsEmpty then
        begin
          cadena := '';
          cadena := cadena + dm.q_peds.FieldByName('id_order').AsString + '|' +
                             IntToStr(codalbaran_actual) + '|' +
                             dm.q_peds.FieldByName('estado').AsString;


          cadena := cadena + (Copy(linea_imei,0,Length(linea_imei)-1));
        end;

        Result := cadena;
      finally
        free;
      end;
end;

function Tf_detail.JSONPostIMEI(text:string):string;
var
  HTTP: TIdHTTP;
  RequestBody: TStream;
  ResponseBody: string;
begin
  HTTP := TIdHTTP.Create;
  try
    try
      RequestBody := TStringStream.Create(text, TEncoding.UTF8);
      try
        HTTP.Request.Accept := 'application/json';
        HTTP.Request.ContentType := 'application/json';
        ResponseBody := HTTP.Post('http://www.loginser.com/sync/sync_insert_imei.php', RequestBody);
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

procedure Tf_detail.grLinesCellClick(Column: TColumn);
begin
  gbLine.Visible := not (cdsLines.IsEmpty) and not modo_historico;

  if cdsLines.recordcount>0 then
  begin
    get_line_data;
    filter_lotes;
    filter_relaciones;
    filter_extras;

    if chNSerieSelecc.Checked then
    begin
          edIdArtNSerie.Value := cdsLines.FieldByName('id_articulo').AsInteger;
          ejecuta_comprobacion_articulo(1,cdsLines.FieldByName('id_articulo').AsInteger);  //modo 1 click en detalle
    end;
  end;

end;

procedure Tf_detail.grLinesDblClick(Sender: TObject);
begin
   if tiene_n_serie and art_tiene_n_serie(cdsLines.FieldByName('id_articulo').AsInteger) then
       btAddNSerie.Click;

end;

procedure Tf_detail.grLinesDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (Column.FieldName='referencia') and (dm.q_peds.FieldByName('estado').AsString = 'X') then
  begin
     If (f_main.get_stock_x_art(Column.Field.DataSet.FieldByName('id_articulo').AsInteger)<f_main.get_total_x_art_y_ped(Column.Field.DataSet.FieldByName('id_articulo').AsInteger,id_pedido_actual)) then
         (Sender as TDBGrid).canvas.Font.Color := clRed
     else
         (Sender as TDBGrid).canvas.Font.Color := clBlack;
  end else
         (Sender as TDBGrid).canvas.Font.Color := clBlack;


  if Column.FieldName='n_serie' then
  begin
        Column.Visible := tiene_n_serie;
        if (tiene_n_serie and art_tiene_n_serie(cdsLines.FieldByName('id_articulo').AsInteger)) then
        begin
          if cdsLines.FieldByName('n_serie').AsString<>'' then
           (Sender as TDBGrid).Canvas.Brush.Color := $F0CAA6 //azul
        else
          (Sender as TDBGrid).Canvas.Brush.Color := clRed;
        end
        else (Sender as TDBGrid).Canvas.Brush.Color := clGray;
  end;

  if Column.FieldName='imei' then
       Column.Visible := tiene_imei;

  if Column.FieldName='item_id' then
      Column.Visible := (main_cli=6830);

  if Column.FieldName='lote' then
  begin
    Column.Visible := u_main.tiene_lotes;
  end;

    if Column.FieldName='id_lote' then
  begin
    Column.Visible := u_main.tiene_lotes;
  end;

    if Column.FieldName='caducidad' then
  begin
    Column.Visible := u_main.tiene_lotes;
  end;

  grLines.DefaultDrawColumnCell(Rect,DataCol,Column,State);

end;

function Tf_detail.SendIMEI(text:string):string;
var
  SendText:ThSendTextHilo;

begin
  SendText:=ThSendTextHilo.create(true);
  SendText.launcher:=0;
  SendText.freeonterminate:=true;
  SendText.varname:='cadena';
  SendText.cadena:=text;
  SendText.url:=httpweb;
  SendText.nomphp:='sync_insert_imei.php';
  u_main.hiloactivo:=true;
  SendText.Resume;
  while u_main.hiloactivo do Application.ProcessMessages;

  Result := u_main.htmldevuelto;
end;


procedure Tf_detail.SendEstado(id_order, albaran,estado:string);
var
  Http1: TIdHTTP;
  datosPost: TIdMultiPartFormDataStream;
  strRead: string;
  resultado:Boolean;
begin
  resultado:=False;
  Http1 := TIdHTTP.Create (nil);
  datosPost := TIdMultiPartFormDataStream.Create;
  try
    datosPost.AddFormField('pedido', id_order);
    datosPost.AddFormField('albaran', albaran);
    datosPost.AddFormField('estado', estado);
    Http1 := TIdHTTP.Create(nil);
    try
      try
        strRead := Http1.Post(httpweb+'shopcart/put.albaran.php', datosPost);
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


function Tf_detail.art_tiene_imei(id:integer):boolean;
begin                                       //devuelve si el articulo tiene lotes
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select tiene_imei from g_articulos where id_articulo='+inttostr(id)+
      ' and id_empresa=1');
    Open;

    if not(IsEmpty) then Result := FieldByName('tiene_imei').asinteger = 1
    else result:=false;

    Free;
  end;
end;

procedure Tf_detail.ActualizaAlbaranGestoras(codalbaran: Integer);
var
  serv, hora:string;
  serv_ped, hora_ped, con_retorno: Integer;

begin

  GetServHoraPedido(id_pedido_actual,serv_ped,hora_ped,con_retorno);

  serv := '';
  hora := '';


  dame_servicio_horario_age(id_agencia_en_gestoras,
                            serv_ped,
                            hora_ped,
                            con_retorno,
                            serv,hora);

  with dm.stpGrabaAlb do
  begin
   Database := dm.db_gestoras;
   Close;
   SQL.Clear;
   SQL.Text := 'update albaranes set ' +
               'bultos=:bultos,' +
               'peso=:kgs,' +
               'agencia=:agencia, ' +
               'tipo_servicio=:servicio, ' +
               'horario=:horario ';

   if edReembolso.Value>0 then
        SQL.Text := SQL.Text + ',reembolso=1, importe_reembolso=' + FloatToStr(edReembolso.Value)
   else
        SQL.Text := SQL.Text + ',reembolso=0, importe_reembolso=0';

   if (serv<>'') and (hora<>'') then
   begin
        SQL.Text := SQL.Text + ',tipo_servicio_age=:serv, horario_age=:hora ';
        ParamByName('serv').AsString := serv;
        ParamByName('hora').AsString := hora;
   end;

   SQL.Text := SQL.Text + 'where id_albaran=:albaran ';

   ParamByName('albaran').Value := codalbaran;
   ParamByName('bultos').Value := ed_bultos.Text;
   ParamByName('kgs').Value := StrTofloat(edKgs.Text);
   ParamByName('agencia').Value := id_agencia_en_gestoras;
   ParamByName('servicio').AsInteger := serv_ped;
   ParamByName('horario').AsInteger := hora_ped;
   ExecQuery;

   Close;
   SQL.Clear;
   SQL.Text := 'update albaran_dest set ' +
               'nombre=:dst_nombre,' +
               'calle=:dst_calle,' +
               'cod_postal=:dst_cp,' +
               'localidad=:dst_localidad,' +
               'provincia=:dst_provincia,' +
               'pais=:pais,' +
               'contacto=:dst_persona,' +
               'telefono=:dst_tfno,' +
               'email=:dst_mail, ' +
               'observaciones=:observaciones ' +
               'where id_albaran=:albaran ';

   ParamByName('albaran').Value := codalbaran;
   ParamByName('dst_nombre').Value := ed_nombre.Text;
   ParamByName('dst_calle').Value := ed_dir_1.Text;
   ParamByName('dst_cp').Value := ed_cp.Text;
   ParamByName('dst_localidad').Value := ed_poblacion.Text;
   ParamByName('dst_provincia').Value := ed_provincia.Text;
   ParamByName('dst_persona').Value := edContacto.Text;
   ParamByName('dst_tfno').Value := ed_telefono.Text;
   ParamByName('dst_mail').Value := ed_email.Text;
   ParamByName('pais').Value := calcula_pais(edCodPais.Text);
   ParamByName('observaciones').Value := ed_obs.Text;
   ExecQuery;
  end;

  end;

procedure Tf_detail.LanzaImpresion;
var
  pic: TfrxPictureView;
begin
  frdevo.PrintOptions.Printer := imp_def;
  rep_pick_imei.PrintOptions.Printer := imp_def;
  rep_pick_lotes.PrintOptions.Printer := imp_def;
  rep_pick.PrintOptions.Printer := imp_def;

  if f_main.edCliente.Text = '9000' then
  begin
     if rep_todos.PrepareReport(True) then rep_todos.ShowPreparedReport;
  end
  else
    //Para Flamingos se saca en la hoja de picking el texto de devolución.
      if f_main.edCliente.Text = '7252' then
      begin
        dm.ds_1.Close;
        dm.ds_1.SQLs.SelectSQL.Clear;
        dm.ds_1.SQLs.SelectSQL.Add('SELECT * from g_clientes_config where id_cliente=7252');
        dm.ds_1.Open;
        dm.ds_1.First;

        pic := frdevo.FindObject('txtNac') as TfrxPictureView;
        if Assigned(pic) then
          pic.Picture.Assign(dm.ds_1.FieldByName('img_1'));

        pic := frdevo.FindObject('txtInt') as TfrxPictureView;
        if Assigned(pic) then
          pic.Picture.Assign(dm.ds_1.FieldByName('img_2'));

        if frdevo.PrepareReport(True) then frdevo.ShowPreparedReport;
      end
      else //Grupo Merydeis saca las hojas mostrando el IMEI
          if u_main.tiene_imei then
          begin
            if rep_pick_imei.PrepareReport(True) then rep_pick_imei.ShowPreparedReport;
          end
          else if u_main.tiene_lotes then
               begin
                  if rep_pick_lotes.PrepareReport(True) then rep_pick_lotes.ShowPreparedReport;
               end else
                      if rep_pick.PrepareReport(True) then rep_pick.ShowPreparedReport;
                      //if r2.PrepareReport(True) then r2.ShowPreparedReport;


end;

procedure Tf_detail.lbExpAgenciaDblClick(Sender: TObject);
begin
  Clipboard.SetTextBuf(pWideChar(lbexpagencia.Caption));
  lbExpAgencia.Hint := 'Texto copiado al portapapeles';
  lbExpAgencia.ShowHint := True;
end;

procedure Tf_detail.nav_art_relBeforeAction(Sender: TObject;
  Button: TNavigateBtn);
begin
   if not(button in [nbpost,nbcancel]) then
      u_globals.ver_estado_actualizacion(dm.q_arts_relacionados);

     edArtRel.Visible := (button in [nbInsert]);
     lbArtRel.Visible := (button in [nbInsert]);
     bpArtRel.Visible := (button in [nbInsert]);
end;

procedure Tf_detail.pcDetailChange(Sender: TObject);

begin
   if pcDetail.Pages[pcDetail.ActivePageIndex].Enabled then
        pos_tabc := pcDetail.ActivePageIndex
   else
        pcDetail.ActivePageIndex := pos_tabc;
end;

procedure Tf_detail.empty_data_lines;
begin
  lb_sku.caption := '';
  lb_id_art.Caption := '';
  lb_nombre_art.Caption := '';
  ed_cantidad.text := '';
  lb_id_line.caption := '';
  lb_ref_art.caption := '';
  lbKgs.Caption := '';
end;

{
procedure Tf_detail.imprime_etiqueta_loginser(codalbaran, id_dest:Integer);
var
  texto: string;
begin
 DMCreaBultos.GeneraBultos(codalbaran,id_dest);

  If ValidaAlbaran(IntToStr(codalbaran),texto)  then
  begin
    eti_lgs.PrintOptions.Printer := imp_eti;
    eti_lgs.PrintOptions.ShowDialog := False;

    with dm.lgs_dame_datos_etiquetas do
      begin
         Close;
         ParamByName('id_albaran').AsInteger := codalbaran;
         Open;

         if eti_lgs.PrepareReport(True) then eti_lgs.Print;

         if texto<>'' then
                      ShowMessage(texto);

      end;
  end;
end; }

procedure Tf_detail.btAddNSerieClick(Sender: TObject);
var
  n_serie: string;
begin

  n_serie := InputBox(cdsLines.FieldByName('nombre').AsString,'Introduzca Número de Serie','');

  if existe_n_serie(n_serie) then
    if MessageDlg('N Serie utilizado anteriormente, ¿desea insertarlo de todos modos?',mtWarning,[mbYes,mbNo],0,mbNo)=mrNo then
        Exit;

  if n_serie<>'' then
  begin
    inserta_pedido_lines_extra(id_pedido_actual,cdsLines.FieldByName('linea').AsInteger,'N_SERIE',n_serie);
    dm.q_peds_lines_extras.Close;
    dm.q_peds_lines_extras.Open;
  end;

end;

procedure Tf_detail.btAsignaLoteClick(Sender: TObject);
var
  mensaje: string;
begin

  if dm.qStockLotes.IsEmpty then
    raise Exception.Create('No existe lote disponible para asignar.');

  mensaje :=
  'Va a forzar el lote ' + ln +
  dm.qStockLotes.FieldByName('lote').AsString + '   ' +
  FormatDateTime('dd/mm/yyyy',dm.qStockLotes.FieldByName('caducidad').AsDateTime) + ln +
  'para el artículo ' + ln +
  lb_ref_art.Caption + '  ' + lb_nombre_art.Caption + ln +
  'Uds.: ' + ed_cantidad.Text + ' Linea: ' + lb_id_line.Caption + ln + Ln +
  '¿Desea continuar?';

  if MessageDlg(mensaje,mtWarning,mbYesNo,0,mbNo)=mrYes then
  begin
     dm.t_write.StartTransaction;
      try
        dm.q_1.Close;
        dm.q_1.sql.Clear;
        dm.q_1.sql.Add('update c_pedidos_lines set id_lote=:id_lote where id_pedido=:id_pedido and id_line=:linea');

        if dm.qStockLotes.FieldByName('id_lote').AsInteger >1 then
        begin
          dm.q_1.ParamByName('id_pedido').AsInteger := id_pedido_actual;
          dm.q_1.ParamByName('linea').AsInteger := StrToInt(lb_id_line.Caption);
          dm.q_1.ParamByName('id_lote').AsInteger := dm.qStockLotes.FieldByName('id_lote').AsInteger;
          dm.q_1.ExecQuery;
        end;

        dm.t_write.Commit;

        InsertaLog(u_main.usuario.id,id_pedido_actual,0,PC.Nombre,PC.IP,log_app,'pedido','',
                       'Update lote c_pedidos_lines','L.' + lb_id_line.Caption + ' Lt.' + dm.qStockLotes.FieldByName('id_lote').AsString);
      except on e:Exception do begin
                dm.t_write.rollback;
                InsertaLog(u_main.usuario.id,id_pedido_actual,0,PC.Nombre,PC.IP,log_app,'pedido','',
                       'Error Update lote c_pedidos_lines','L.' + lb_id_line.Caption + ' Lt.' + dm.qStockLotes.FieldByName('id_lote').AsString);
              end;
      end;
  end;
end;

procedure Tf_detail.btDelNSerieClick(Sender: TObject);
begin
  if (dm.q_peds_lines_extras.FieldByName('extra').AsString='N_SERIE') and (dm.q_peds_lines_extras.FieldByName('valor').AsString<>'') then
  begin
    elimina_pedido_lines_extra(id_pedido_actual,
    cdsLines.FieldByName('linea').AsInteger,'N_SERIE',dm.q_peds_lines_extras.FieldByName('valor').AsString,u_main.usuario.id,PC.IP,PC.Nombre, log_app);
    dm.q_peds_lines_extras.Close;
    dm.q_peds_lines_extras.Open;
  end;
end;

procedure Tf_detail.btFicheroMuzyClick(Sender: TObject);
begin
    if lines_n_serie_total<>lines_n_serie_pistoleadas then
      if MessageDlg('Faltan nºs de serie por pistolear,¿enviar de todas formas?',mtWarning,mbYesNo,0,mbNo)=mrNo then
          Exit;

    Screen.Cursor := crHourglass;

    with TpFIBDataSet.Create(nil) do
    try
      try
        Database:=dm.db;
        SQLs.SelectSQL.Clear;
        sqls.SelectSQL.Add('select * from c_pedidos_lines l ' +
                           'inner join g_articulos ar on ar.id_articulo=l.id_articulo ' +
                           ' where l.id_pedido=:id_pedido and ar.tiene_n_serie=1 and ((l.n_serie is null) or (l.n_serie='''')) ');
        ParamByName('id_pedido').AsInteger := id_pedido_actual;
        Open;

        if isempty then begin
            status.Panels[0].Text := 'Enviando fichero Muzybar...';

            u_muzybar.send_file_muzybar(id_pedido_actual,chSoloFichero.Checked);

            {InsertaLog(u_main.usuario.id,id_pedido_actual,0,PC.Nombre,PC.IP,log_app,'pedido','',
                         'Fichero Muzybar Enviado','Ped. ' + IntToStr(id_pedido_actual));  }

            dm.t_write.StartTransaction;
            try
              dm.q_1.Close;
              dm.q_1.sql.Clear;
              dm.q_1.sql.Add('insert into c_pedidos_extras ' + '(ID_PEDIDO,DESCRIPCION,VALOR) ' +
                             'values (:ID_PEDIDO,:DESCRIPCION,:VALOR)');
              dm.q_1.ParamByName('ID_PEDIDO').AsInteger := id_pedido_actual;
              dm.q_1.ParamByName('DESCRIPCION').AsString := 'DATE_FILE_SEND';
              dm.q_1.ParamByName('VALOR').asstring := FormatDateTime('dd.mm.yyyy hh:nn:ss',Now);
              dm.q_1.ExecQuery;

              dm.t_write.Commit;

              lbFileSend.Caption := FormatDateTime('dd.mm.yyyy hh:nn:ss',Now);
            except
               dm.t_write.Rollback;
            end;

            if not chSoloFichero.Checked then
            begin
              status.Panels[0].Text := 'Imprimiendo etiqueta ...';
              dm.q_peds.Locate('id_pedido',VarArrayOf([id_pedido_actual]),[]);
              bt_print_etiClick(Self);
            end;

        end
        else begin
                ShowMessage('Existen lineas de pedido sin N SERIE');
                Screen.Cursor := crDefault;
                Exit;
             end;

      except on e:Exception do begin
                  InsertaLog(u_main.usuario.id,id_pedido_actual,0,PC.Nombre,PC.IP,log_app,'pedido','',
                         'Error Fichero Muzybar','Ped. ' + IntToStr(id_pedido_actual) + ' ' + e.Message);
             end;

      end;

    finally
      free;
    end;

    Screen.Cursor := crDefault;

    showmessage('Proceso Finalizado.');
end;

function Tf_detail.suma_cantidad_art_en_pedido(id_pedido,id_articulo: integer):integer;
begin
    result  := -1;
    with TpFIBDataSet.Create(nil) do
    try
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select sum(cantidad) as uds from c_pedidos_lines_lotes ' +
                         ' where id_pedido=:id_pedido and id_articulo=:id_articulo');
      ParamByName('id_pedido').AsInteger := id_pedido;
      ParamByName('id_articulo').AsInteger := id_articulo;
      Open;

      if not isempty then
          result := FieldByName('uds').asinteger;

    finally
      free;
    end;
end;

function Tf_detail.tiene_lote_forzado(id_pedido:integer):Boolean;
begin
    with TpFIBDataSet.Create(dm) do
    begin
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select * from c_pedidos_lines where id_pedido=:id_pedido and id_lote>1 ');
      ParamByName('id_pedido').AsInteger := id_pedido;
      Open;

     result := not IsEmpty;

     free;
    end;
end;

procedure Tf_detail.actualiza_pistoleo;
var
  j: Integer;
begin
    lbNSerieArt.Caption := cdsLines.FieldByName('sku').AsString + #13#10 + cdsLines.FieldByName('nombre').AsString;

    lines_n_serie_total_x_art := cuenta_lineas_con_n_serie_x_art(id_pedido_actual,cdsLines.FieldByName('id_articulo').AsInteger);
    lines_n_serie_pistoleadas_x_art := cuenta_lineas_con_n_serie_pistoleado_x_art(id_pedido_actual,cdsLines.FieldByName('id_articulo').AsInteger);
    lines_n_serie_total := cuenta_lineas_con_n_serie(id_pedido_actual);
    lines_n_serie_pistoleadas := cuenta_lineas_con_n_serie_pistoleado(id_pedido_actual);

    lbNSCont.Caption := IntToStr(lines_n_serie_pistoleadas_x_art) + '/' + IntToStr(lines_n_serie_total_x_art);
    lbNSContTotal.Caption := 'Nºs Serie: ' + IntToStr(lines_n_serie_pistoleadas) + '/' + IntToStr(lines_n_serie_total);

    get_nserie_lines_x_art(id_pedido_actual,cdsLines.FieldByName('id_articulo').AsInteger);

end;

procedure Tf_detail.RellenaAlmacenes;
begin
    with TpFIBDataSet.Create(self) do
    try
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select * from a_almacenes where estado=''A'' order by id_almacen');
      Open;
      First;
      cbAlmacen.Items.Clear;
      cbAlmacen.Items.Add('NO DEFINIDO');
      while not Eof do
      begin
         cbAlmacen.Items.Insert(FieldByName('id_almacen').AsInteger,FieldByName('nombre').AsString);
         Next;
      end;

    finally
      free;
    end;
end;

procedure Tf_detail.ejecuta_comprobacion_articulo(modo,id_articulo:Integer);  //modo=0 EAN modo=1 click en detalle
begin

  if art_tiene_n_serie(id_articulo) then
  begin
    If not cdsLines.Locate('id_articulo;n_serie',VarArrayOf([id_articulo,'']),[]) then
    begin
      //EAN duplicado
          lbEan.Caption:='ART. COMPLETO';
          lbEan.Font.Color := clRed;

          if modo=0 then
              InsertaLog(u_main.usuario.id,id_pedido_actual,0,PC.Nombre,PC.IP,log_app,'pedido','',
              'Art.Completo EAN ' + edEanNSerie.Text,'Art.'+ IntToStr(id_articulo))
          else
              InsertaLog(u_main.usuario.id,id_pedido_actual,0,PC.Nombre,PC.IP,log_app,'pedido','',
              'Art.Completo ClickDetalle ','Art.'+ IntToStr(id_articulo));

          if modo=0 then
          begin
            id_articulo := -1;

            edNSerie.Enabled := False;
            edEanNSerie.SetFocus;
          end;
    end else begin

               //lbNSerieArt.Caption := get

              lbEan.Caption:='OK';
              lbEan.Font.Color := clGreen;

              if modo=0 then
                  get_line_data;

              gbNSList.Caption := 'ESCANEANDO...';
              lbNSerieArt.Caption := cdsLines.FieldByName('sku').AsString + #13#10 + cdsLines.FieldByName('nombre').AsString;

              if modo=0 then
                   actualiza_pistoleo;

              if modo=0 then
                InsertaLog(u_main.usuario.id,id_pedido_actual,0,PC.Nombre,PC.IP,log_app,'pedido','',
                'Ok EAN ' + edEanNSerie.Text,'L.' + cdsLines.FieldByName('linea').AsString + ' Art.'+ IntToStr(id_articulo))
              else
                InsertaLog(u_main.usuario.id,id_pedido_actual,0,PC.Nombre,PC.IP,log_app,'pedido','',
              'Ok ClickDetalle','L.' + cdsLines.FieldByName('linea').AsString + ' Art.'+ IntToStr(id_articulo));

              edNSerie.Enabled := True;
              edNSerie.Setfocus;
             end;

  end else begin

        lbEan.Caption:='ART. SIN Nº SERIE';
        lbEan.Font.Color := clRed;

        if FileExists(ruta_exe+'Audio\Error.wav') then sndPlaySound(PChar(ruta_exe+'Audio\Error.wav'),SND_NODEFAULT Or SND_ASYNC);

        InsertaLog(u_main.usuario.id,id_pedido_actual,0,PC.Nombre,PC.IP,log_app,'pedido','',
        'ArtSinNSerie EAN ' + edEanNSerie.Text,'');

        edNSerie.Enabled := False;

        if modo=0 then
             edEanNSerie.Setfocus;
  end;

end;

procedure Tf_detail.carga_datasets(modo_historico: Boolean);
begin
  with dm.q_peds_lines_lotes do
    begin
       Close;
       SelectSQL.Clear;
       SelectSQL.Add('select * ' );

       if not modo_historico then
           SelectSQL.Add('from c_pedidos_lines_lotes l ')
       else
           SelectSQL.Add('from c_pedidos_lines_lotes_hist l ');

       SelectSQL.Add('inner join a_lotes lt on (l.id_lote=lt.id_lote) ' +
                     'where l.id_pedido=:id_pedido and l.id_articulo=:id_articulo ');
    end;

end;

end.
