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
  acProgressBar, IdCustomTCPServer, IdMappedPortTCP, IdMappedFTP, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,
  frxExportPDF, System.AnsiStrings, mmsystem, MidasLib,Math;

type
  Tf_main = class(TForm)
    gb_1: TsGroupBox;
    b_picking: TsBitBtn;
    lb_picking: TsLabel;
    gb_12: TsGroupBox;
    lb_agrupa: TsLabel;
    sb_1: TsBitBtn;
    gb_cajas: TsGroupBox;
    lb_cajas: TsLabel;
    g_agr: TJvDBGrid;
    lb_caja_a: TsLabel;
    lb_caja_b: TsLabel;
    lb_caja_c: TsLabel;
    lb_3: TsLabel;
    lb_caja_d: TsLabel;
    gb_resto: TsGroupBox;
    bt_cerrar_caja: TsSpeedButton;
    bt_print_prev: TsSpeedButton;
    bt_cambio: TsSpeedButton;
    rg_caja: TsRadioGroup;
    cb_maxcubic: TsCheckBox;
    bt_cerrar_agrup: TsSpeedButton;
    bt_print_bultos: TsSpeedButton;
    rep_db_indiv: TfrxDBDataset;
    rep_eti: TfrxReport;
    rep_mensy: TfrxReport;
    rep_db_bultos: TfrxDBDataset;
    rep_log: TfrxReport;
    rep_pick: TfrxReport;
    rep_db_pick: TfrxDBDataset;
    bt_imp_pick: TsSpeedButton;
    cb_prev: TsCheckBox;
    lb_caja_e: TsLabel;
    rep_correos: TfrxReport;
    cb_one_read_marks_all: TsCheckBox;
    cb_art_un_bulto: TsCheckBox;
    rep_pick2: TfrxReport;
    pdf_export: TfrxPDFExport;
    cb_send_email: TsCheckBox;
    cb_indiv_2040: TsCheckBox;
    fr_asm: TfrxReport;
    sp_1: TsSkinProvider;
    sm_1: TsSkinManager;
    ar_lis_ds: TClientDataSet;
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
    strngfld_pick_dsdeliv_time: TStringField;
    intgrfld_pick_dsid_art: TIntegerField;
    strngfld_pick_dsean: TStringField;
    strngfld_pick_dsean2: TStringField;
    strngfld_pick_dsempresa: TStringField;
    strngfld_pick_dsrepartidor: TStringField;
    strngfld_pick_dsprecinto: TStringField;
    strngfld_pick_dsid_pais: TStringField;
    fltfld_pick_dsportes: TFloatField;
    fltfld_pick_dsreembolso: TFloatField;
    rep_db_lis: TfrxDBDataset;
    rep_lis: TfrxReport;
    intgrfld_lis_dsid_lote: TIntegerField;
    strngfld_lis_dsn_lote: TStringField;
    dtfld_lis_dscaducidad: TDateField;
    statusBar1: TsStatusBar;
    lbCon: TsLabel;
    lbCLAlm: TsLabel;
    btnHECTOR: TsButton;
    clienteFTP: TIdFTP;
    SSL: TIdSSLIOHandlerSocketOpenSSL;
    IdMappedFTP1: TIdMappedFTP;
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
    gr_grid2: TJvDBGrid;
    bt1: TsSpeedButton;
    rep_1: TfrxDBDataset;
    rep_etiq_peq: TfrxReport;
    rep_etiq_grande: TfrxReport;
    cdsTrad: TClientDataSet;
    strngfld1: TStringField;
   { scflstrg1: TScFileStorage;
    scshclnt1: TScSSHClient;
    scsftpclnt1: TScSFTPClient;    }
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sSkinProvider1TitleButtons1MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure sSkinProvider1TitleButtons0MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure b_pickingClick(Sender: TObject);
    procedure g_gridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    //procedure ScSSHClientServerKeyValidate(Sender: TObject; NewServerKey: TScKey; var Accept: Boolean);
    procedure lectura;
    procedure start;
    function procesa_cb(bc:string):integer;
    procedure bt_addClick(Sender: TObject);
    procedure ed_cbKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bt_cambioClick(Sender: TObject);
    procedure act_cajas;
    procedure bt_print_bultosClick(Sender: TObject);
    function WriteRawDataToPrinter(PrinterName: String; Str: String): Boolean;
    function cadLongitudFija (cadena : string; longitud : Integer; posicionIzquierda : boolean; valorRelleno : string) : string;
    Function calc_digcon_chrono(codbar:string):Integer;
    procedure bt_cerrar_cajaClick(Sender: TObject);
    procedure bt_cerrar_agrupClick(Sender: TObject);
    procedure cerrar_agrupa_error;
    procedure get_defaults;
    procedure print_etiq_pre(codalbaran,tipo_caja,codrepartidor,id_ruta:string; id_caja,id_packlin_bulto,n_bulto:integer);
    procedure bt_print_prevClick(Sender: TObject);
    procedure cerrar_caja_y_nueva(codalbaran,id_packlin_bulto_old:integer; etiq_prev:Boolean=True);
    procedure imprime_eti_indiv(id_packcab,id_agrupa,nivel_agr,linea:integer);
    procedure bt_print_indivClick(Sender: TObject);
    procedure imprime_eti_bulto(codalbaran:integer);
    function get_cp_ext(poblacion:string):string;
    function get_del_chrono(codigopostal: integer):string;
    function limpiachar(frase: string):string;
    procedure ejecuta_lectura(id_articulo:Integer; bc:string; codalbaran_p:integer; mark_all:boolean; id_lote:Integer = 1);
    procedure cerrar_albaran(codalbaran:integer);
    procedure ver_imagen(id_articulo:integer);
    function siguiente_laboral(fecha:TDateTime):tdate;
    function es_festivo(fecha:TDateTime):Boolean;
    procedure bt_lectura_manualClick(Sender: TObject);
    procedure imprime_hoja_pick(codalbaran:Integer);
    procedure imprime_eti_bulto_asm(codalbaran:integer);
    procedure bt_imp_pickClick(Sender: TObject);
    function mark_one(nombre,codigo,bc,tipo_caja:string;  id_caja,codalbaran,linea:Integer;  verbose, check_cierre_caja:boolean; id_lote:Integer; n_lote:string; caducidad:tdatetime):integer;
    procedure send_hoja_pick(codalbaran:Integer);
    procedure FormShow(Sender: TObject);
    procedure send_chrono_file;
    procedure send_dhl_file;
    function get_nombrefichero_chrono(fecha: TDateTime):string;
    function get_nombrefichero_dhl:string;
    procedure genera_fichero_abierto(filename:string);
    procedure genera_fichero_abierto_DHL(filename:string);
    procedure genera_fichero_agrupado_DHL(filename:string);
    function check_chrono:Boolean;
    function check_dhl:Boolean;
    function linea_chrono_abierto(codalbaran:Integer):string;
    function linea_dhl_abierto(codalbaran,id_packcab:Integer):string;
    function linea_dhl_agrupado(n_bulto_chrono:string):string;
    procedure marca_alb_abierto_enviado(codalb:Integer);
    procedure marca_alb_agrupado_enviado(n_bulto_chrono:string);
    procedure imprime_hoja_pick_lis(codalbaran:Integer; send_email:boolean=false);
    function get_chrono_exp(codalbaran:integer; codcli:string):string;
    procedure update_sqlserver_lotes(codalbaran:integer);
    procedure translate(lang:Integer=0);
    function pais_to_idx(pais:string):Integer;
    function GetPaisNombre(codigo:string):string;
    procedure btnHECTORClick(Sender: TObject);
    function esAduanero(Pais:string):boolean;
    function codigoProducto(Pais  :string):string;
    function  SoloNumeros(Texto : String) : String;
    procedure bt1Click(Sender: TObject);
    procedure imprime_etiquetasArticulos(etiqueta:string);
    function comprobar_si_etiquetaNecesaria(albaran,articulo:integer;out etiqueta:string):Boolean;
    procedure enviarFicheroSSH(ruta,fichero:string);
    procedure sb_1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  ALERTA = 'LISTO';
  {Listo: puede crearse exe
   Vacio: hay algo en desarrollo y no se puede crear exe}

  v = '1.0.6';
  //[1.0.6] Modificada forma de buscar bultos. Asociaba también el packlin_bulto de albaranes viejos.
  //[1.0.5] Imprime las etiquetas de DHL con kilos a 1 y con el numero de bultos a X (para poder agruparlas)
  //Genera un fichero diario con todos los envios que salen por DHL agrupados por el N_BULTO_CHRONO.
  //[1.0.4] Imprimir hojas de packing al cerrar agupación
  //[1.0.3] Los datos de las agencias salen de bbdd, antes estaban a pelo en el código.
  //Etiquetas italiano para artículos. Control de códigos postales.
  //Envío de fichero a DHL por SSH. Para LIS, no imprime hoja de picking con transporte propio.
  //Modificación Cerrar y Abrir Nueva Caja
  //No se imprimen las hojas de picking para LIS al cerrar agrupacion

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
  id_packcab,id_agrupa,nivel_agr,id_ruta,uds,modo,coddel,old_codalbaran,id_cliente:integer;
  cubic_a,cubic_b,cubic_c,cubic_d,cubic_e,percent_cubic:integer;
  only_one:boolean=false;
  sys_path,pick_path,pick_email:string;
  function LeerHexa(fichero: string) : string;
  function Espacios(cadena: string; l: Integer): string;
  function Zeros(c: string; l: Integer): string;
implementation

uses u_globals, ubuscapro, u_envia_mail, u_gen_gl, u_cam_gl, u_dm;

{$R *.dfm}

{$REGION 'Ini-Close'}
procedure Tf_main.FormCreate(Sender: TObject);
begin
  if (ALERTA<>'LISTO') then
      ShowMessage('CUIDADO!!!!! PROYECTO EN DESARROLLO!!!! AVISA A INFORMATICA!!!');

  u_globals.password:=ParamStr(1);                            //El password llega como primer parametro

  u_globals.leer_ini;                                         //carga ini

  //sk_manager.SkinDirectory:=u_globals.resdir+'Skins\';     //Activa el skin
  //sk_manager.SkinName:=u_globals.skinname;
  //sk_manager.Active:=true;

  //u_globals.ini_bd;                                          //inicializa acceso a datos

  //sk_manager.HueOffset:=u_globals.hue;                       //aplica colores a la piel
  //sk_manager.Saturation:=u_globals.saturation;
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
  //get_defaults;
  u_gen_gl.lee_inis_def;
  u_cam_gl.lee_inis_def;

  cb_maxcubic.Caption:='Cierre Automático Por Porcentaje Cúbico al '+inttostr(percent_cubic)+'%';
end;

procedure Tf_main.FormDestroy(Sender: TObject);
begin
  u_globals.x:=left;                                          //guardar posicion actual
  u_globals.y:=top;
 { u_globals.w:=Width;                                        //guardar tamaño (si procede)
  u_globals.h:=Height; }
  u_globals.guardar_pos;
end;

procedure Tf_main.FormShow(Sender: TObject);
begin
  gb_pack.Visible:=False;
  gb_cajas.Visible:=false;

  lbCon.Caption := u_globals.dbname;
  lbCLAlm.Caption := 'Centro L. ' + IntToStr(u_globals.cent_lect) + ' - Alm. ' +  IntToStr(u_globals.id_almacen_def);
end;

procedure Tf_main.sSkinProvider1TitleButtons0MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Application.Minimize;               //minimizar
end;

procedure Tf_main.sSkinProvider1TitleButtons1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  application.terminate;                     //cerrar
end;
{$ENDREGION}

{$REGION 'Busquedas'}
procedure Tf_main.b_pickingClick(Sender: TObject);                       //Selecciona PackCab
begin
  with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;   row_height:=40;
    fields.commatext:='cp.id_packcab,sum(lp.cantidad),cp.nombre,cp.id_cliente';
    titulos.commatext:='Packing,Cantidad,Nombre,Cliente';
    from:='a_packcab cp  '+
      'inner join a_packlin lp on (lp.id_packcab=cp.id_packcab)';
    where:='lp.cantidad_i<lp.cantidad and cp.modo=4 and cp.id_almacen='+inttostr(u_globals.id_almacen_def);
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
    end;
  end;
end;

procedure Tf_main.bt1Click(Sender: TObject);
begin
//   ShowMessage(IntToStr(calc_digcon_chrono('6370944709005270246013'))+ ' ' + IntToStr(calc_digcon_chrono('6370944709005250308720')) );
send_dhl_file;
end;


procedure Tf_main.btnHECTORClick(Sender: TObject);
begin
//send_dhl_file;
//genera_fichero_abierto_dhl('C:\pruebageneracionfichero.txt')
end;


{procedure Tf_main.ScSSHClientServerKeyValidate(Sender: TObject; NewServerKey: TScKey; var Accept: Boolean);
begin
  Accept := True;
end;        }


procedure Tf_main.bt_addClick(Sender: TObject);               //Añadir EAN a articulo
begin
  with fbuscapro do begin                                                      //picking normal
    limpia_fields;     multiselect:=false;    livekey:=false;    row_height:=40;
    fields.commatext:='id_articulo,codigo,nombre';
    titulos.commatext:='IdArticulo,Codigo,Nombre';
    from:='g_articulos';
    where:='estado=''A'' ';
    orden[1]:=2;  orden[2]:=1;  group:='';
    busca:=3;   distinct:=0;   fillimpio:=True;

    showmodal;

    if resultado then begin
      with tpfibquery.create(Self) do                         //añade ean a artículo
      try
        Database:=dm.db;
        Transaction:=dm.t_write;
        sql.Add('insert into g_articulos_bc (id_articulo,bc) values (:id_articulo,:bc)');
        parambyname('id_articulo').asinteger:=valor[1];
        ParamByName('bc').AsString:=lb_ean.Caption;

        dm.t_write.StartTransaction;
        execquery;
        dm.t_write.CommitRetaining;
      finally
        Free;
      end;

      gb_error.Visible:=false;
      ed_cb.Text:=lb_ean.Caption;
      lectura;
    end;
  end;
end;
{$ENDREGION}

{$REGION 'Procesos'}
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
  dm.q_packagr.sqls.SelectSQL.Add('select b.id_caja,b.codalbaran,b.tipo_caja,l.codrepartidor,l.id_ruta,l.id_packlin_bulto,b.n_bulto, '+
    '  sum(l.cantidad) as total,sum(l.cantidad)-sum(l.cantidad_i) as pendiente '+
    'from a_packlin l '+
    'inner join a_packlin_bulto b on (l.id_packlin_bulto=b.id_packlin_bulto) '+
    'where l.id_packcab=:id_packcab and l.id_agrupa=:id_agrupa and l.nivel_agr=:nivel_agr '+
    'group by 1,2,3,4,5,6,7 order by 1,2');
  dm.q_packagr.ParamByName('id_packcab').asinteger:=id_packcab;
  dm.q_packagr.ParamByName('id_agrupa').asinteger:=id_agrupa;
  dm.q_packagr.ParamByName('nivel_agr').asinteger:=nivel_agr;
  dm.q_packagr.Open;

  act_cajas;

  lb_cajas.Caption:=IntToStr(dm.q_packagr.RecordCount)+' Albarán/es';

  if id_agrupa=120 then
          orden := '2,4'
      else
          orden := '1,2,4';

  dm.q_pack.Close;
  dm.q_pack.SQLs.SelectSQL.Clear;
  dm.q_pack.SQLs.SelectSQL.Add('select b.codalbaran,b.id_caja,b.tipo_caja,a.codigo,a.nombre,lo.nombre as n_lote,lo.id_lote, '+
      '  sum(l.cantidad) as total,sum(l.cantidad)-sum(l.cantidad_i) as pdtes '+
      'from a_packlin l '+
      'inner join g_articulos a on (l.id_articulo=a.id_articulo) '+
      'inner join a_packlin_bulto b on (b.id_packlin_bulto=l.id_packlin_bulto) '+
      'inner join a_lotes lo on (l.id_lote=lo.id_lote) '+
      'where l.id_packcab=:id_packcab and l.id_agrupa=:id_agrupa and l.nivel_agr=:nivel_agr and l.cantidad_i<l.cantidad '+
//      'group by 1,2,3,4,5 order by 2,4');
      'group by 1,2,3,4,5,6,7 order by ' + orden);

  dm.q_pack.ParamByName('id_packcab').asinteger:=id_packcab;
  dm.q_pack.ParamByName('id_agrupa').asinteger:=id_agrupa;
  dm.q_pack.ParamByName('nivel_agr').asinteger:=nivel_agr;
  dm.q_pack.Open;

  dm.q_pack_leido.Close;
  dm.q_pack_leido.SQLs.SelectSQL.Clear;
  dm.q_pack_leido.SQLs.SelectSQL.Add('select b.codalbaran,b.id_caja,b.tipo_caja,a.codigo,a.nombre,l.linea,lo.nombre as n_lote, '+
      '  sum(l.cantidad) as total,sum(l.cantidad_i) as leidos '+
      'from a_packlin l '+
      'inner join g_articulos a on (l.id_articulo=a.id_articulo) '+
      'inner join a_packlin_bulto b on (b.id_packlin_bulto=l.id_packlin_bulto) '+
      'inner join a_lotes lo on (l.id_lote=lo.id_lote) '+      
      'where l.id_packcab=:id_packcab and l.id_agrupa=:id_agrupa and l.nivel_agr=:nivel_agr and l.cantidad_i>0 '+
 //     'group by 1,2,3,4,5,6 order by 2,4');
      'group by 1,2,3,4,5,6,7 order by ' + orden);

  dm.q_pack_leido.ParamByName('id_packcab').asinteger:=id_packcab;
  dm.q_pack_leido.ParamByName('id_agrupa').asinteger:=id_agrupa;
  dm.q_pack_leido.ParamByName('nivel_agr').asinteger:=nivel_agr;
  dm.q_pack_leido.Open;

  ed_cb.SetFocus;

  if ((not(only_one)) and (cb_prev.Checked)) then begin                      //Saca etiquetas previas automaticamente
    dm.q_packagr.First;
    while not(dm.q_packagr.eof) do begin
      print_etiq_pre(dm.q_packagr.FieldByName('codalbaran').Asstring, dm.q_packagr.FieldByName('tipo_caja').Asstring,
        dm.q_packagr.FieldByName('codrepartidor').AsString, dm.q_packagr.FieldByName('id_ruta').AsString,
        dm.q_packagr.FieldByName('id_caja').asinteger,dm.q_packagr.FieldByName('id_packlin_bulto').asinteger,
        dm.q_packagr.FieldByName('n_bulto').asinteger);

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
          fieldbyname('id_lote').asinteger,fieldbyname('n_lote').asstring,fieldbyname('caducidad').asdatetime);

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

procedure Tf_main.ed_cbKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=13 then lectura;
end;

procedure Tf_main.lectura;
var s:string;   id_articulo:integer;
begin
  s:=ed_cb.text;
  ed_cb.text:='';
  id_articulo:=procesa_cb(s);
  if id_articulo<>-1 then ejecuta_lectura(id_articulo,s,-1,cb_one_read_marks_all.Checked);
  ed_cb.SetFocus;
end;

function Tf_main.procesa_cb(bc:string):integer;
var i,j:integer;
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
        dm.q_fib.ParamByName('id_cliente').Asinteger:=id_cliente;
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

procedure Tf_main.sb_1Click(Sender: TObject);
begin
  with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;    row_height:=40;
    fields.commatext:='l.id_agrupa,a.nombre,l.nivel_agr,sum(l.cantidad)';
    titulos.commatext:='Agrupación,Nombre,Nivel,Cantidad';
    from:='a_packlin l  '+
      'inner join a_agrupaciones a on (l.id_agrupa=a.id_agrupa) ';
    where:='l.cantidad_i<l.cantidad and l.id_packcab='+inttostr(id_packcab);
    orden[1]:=1;  orden[2]:=2; orden_ini:=0; group:='l.id_agrupa,a.nombre,l.nivel_agr';
    busca:=1;   distinct:=0;   fillimpio:=True;

    showmodal;

    if resultado then begin
      lb_agrupa.Caption:=valor[1]+'-'+valor[2]+' N='+valor[3];
      id_agrupa:=valor[1];
      nivel_agr:=valor[3];

      gb_cajas.Visible:=true;

      if (id_agrupa=120) then begin
        gb_resto.visible:=False;
        only_one:=true;
      end else begin
        gb_resto.visible:=true;
        only_one:=false;
      end;

      start;
    end;
  end;
end;

procedure Tf_main.ejecuta_lectura(id_articulo:Integer; bc:string; codalbaran_p:integer; mark_all:boolean; id_lote:Integer = 1);
var  n_arts,linea:Integer;
  etiqueta, pais: string;
begin
  with tpfibdataset.create(Self) do
  try                               //Buscar EAN
    Database:=dm.db;
    close;
    SQLs.SelectSQL.Clear;
    sqls.SelectSQL.Add('select b.id_caja,l.codalbaran,b.tipo_caja,l.linea,a.codigo,a.nombre, l.codrepartidor, lo.id_lote, lo.nombre as n_lote, lo.caducidad '+
      'from a_packlin l '+
      'inner join a_packlin_bulto b on (l.id_packlin_bulto=b.id_packlin_bulto) '+
      'inner join g_articulos a on (l.id_articulo=a.id_articulo) '+
      'inner join a_lotes lo on (lo.id_lote = l.id_lote) '+
      'where l.id_packcab=:id_packcab and l.id_agrupa=:id_agrupa and l.nivel_agr=:nivel_agr and l.id_articulo=:id_articulo and l.cantidad_i<l.cantidad ');
    if codalbaran_p<>-1 then sqls.SelectSQL.Add('and l.codalbaran=:codalbaran ');
    if id_lote<>1 then       sqls.SelectSQL.Add('and l.id_lote=:id_lote ');

    sqls.SelectSQL.Add('group by 1,2,3,4,5,6,7,8,9,10');
    ParamByName('id_packcab').asinteger:=id_packcab;
    ParamByName('id_agrupa').asinteger:=id_agrupa;
    ParamByName('nivel_agr').asinteger:=nivel_agr;
    ParamByName('id_articulo').asinteger:=id_articulo;
    if codalbaran_p<>-1 then ParamByName('codalbaran').asinteger:=codalbaran_p;
    if id_lote<>1 then ParamByName('id_lote').asinteger:=id_lote;
    Open;

    if isempty then begin
      gb_asig.Visible:=false;
      gb_error.Visible:=true;
      bt_add.Visible:=false;
      lb_ean.Caption:=bc;
      lb_st.Caption:='ERROR !! EAN NO ESPERADO EN AGRUPACIÓN';
      if FileExists(ruta_exe+'Audio\Error.wav') then sndPlaySound(PChar(ruta_exe+'Audio\Error.wav'),SND_NODEFAULT Or SND_ASYNC);
    end else begin

      if only_one then begin                                                  //******************************************de 1 sola unidad
        gb_asig.Visible:=true;
        gb_error.Visible:=false;
        lb_asig.Caption:=FieldByName('nombre').AsString;
        lb_asig_art.Caption:='Código '+FieldByName('codigo').AsString+' - EAN '+bc;
        lb_asig_lote.caption:='Lote '+Fieldbyname('n_lote').asstring+' '+formatdatetime('dd/mm/yy', fieldbyname('caducidad').asdatetime);

        first;
        n_arts:=0;
        while not(eof) do begin
          inc(n_arts);
          next;
        end;
        lb_caja.Caption:='';
        lb_albaran.Caption:=IntToStr(n_arts)+' Albaranes';

        ver_imagen(id_articulo);

        First;
        while not(eof) do begin
          linea:=FieldByName('linea').AsInteger;
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
            ParamByName('fecha_i').AsDate:=date;
            ParamByName('hora_i').AsTime:=Time;
            ParamByName('id_usuario_i').AsInteger:=u_globals.id_usuario;
            ParamByName('pc').AsString:=u_globals.pc_name;

            dm.t_write.StartTransaction;
            execquery;
            dm.t_write.commit;
          finally
            Free;
          end;

          cerrar_albaran(FieldByName('codalbaran').asinteger);

          if FieldByName('codrepartidor').AsInteger=46120 then
                 imprime_eti_bulto_asm(FieldByName('codalbaran').asinteger)
          else
                 imprime_eti_bulto(FieldByName('codalbaran').asinteger);

          Next;
        end;
      end else begin                                                         //***********************albs de mas de una unidad

        gb_asig.Visible:=true;
        gb_error.Visible:=false;

        ver_imagen(id_articulo);

        if not(mark_all) then begin                        //***********************one read and marks only one
          first;

          mark_one(FieldByName('nombre').AsString,FieldByName('codigo').AsString,bc,FieldByName('tipo_caja').AsString,
            FieldByName('id_caja').Asinteger,FieldByName('codalbaran').Asinteger,FieldByName('linea').AsInteger,true,true,
            FieldByName('id_lote').Asinteger,FieldByName('n_lote').Asstring,FieldByName('caducidad').Asdatetime);

        end else begin                                                          //***********************one read and marks all
          first;
          n_arts:=0;
          while not(eof) do begin
            inc(n_arts);
            next;
          end;
          lb_caja.Caption:='';
          lb_albaran.Caption:=IntToStr(n_arts)+' Artículos';

          First;
          while not(eof) do begin
            mark_one(FieldByName('nombre').AsString,FieldByName('codigo').AsString,bc,FieldByName('tipo_caja').AsString,
              FieldByName('id_caja').Asinteger,FieldByName('codalbaran').Asinteger,FieldByName('linea').AsInteger,false,true,
              FieldByName('id_lote').Asinteger,FieldByName('n_lote').Asstring,FieldByName('caducidad').Asdatetime);
            next;
          end;
        end;
      end;

      //Nov'18 Almacén ha pedido que no salgan las etiquetas de italiano de momento
      //comprobar destino del albaran e imprimir si necesario la etiqueta
      {if(comprobar_si_etiquetaNecesaria(FieldByName('codalbaran').asinteger,id_articulo,etiqueta)) then
       begin
        imprime_etiquetasArticulos(etiqueta);
       end;}

      dm.q_packagr.Close;
      dm.q_packagr.Open;

      dm.q_pack.Close;
      dm.q_pack.Open;

      dm.q_pack_leido.Close;
      dm.q_pack_leido.Open;
    end;
  finally
    Free;
  end;
end;

function Tf_main.mark_one(nombre,codigo,bc,tipo_caja:string;  id_caja,codalbaran,linea:Integer;  verbose,check_cierre_caja:boolean; id_lote:Integer; n_lote:string; caducidad:tdatetime):integer;    //returns id_packlin_bulto de la linea
var   max_cubic:integer;  id_packlin_bulto:integer;
begin
  lb_asig.Caption:=nombre;
  lb_asig_art.Caption:='Código '+codigo+' - EAN '+bc;
  lb_asig_lote.caption:='Lote '+n_lote+' '+formatdatetime('dd/mm/yy', caducidad);

  if verbose then begin
    lb_caja.Caption:='Caja '+IntToStr(id_caja)+' - '+tipo_caja;
    lb_albaran.Caption:='Albarán '+IntToStr(codalbaran);
  end;

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
    sql.Add('update a_packlin set cantidad_i=cantidad_i+1, fecha_i=:fecha_i, hora_i=:hora_i, id_usuario_i=:id_usuario_i, pc=:pc, situacion=''A'' '+
      'where id_packcab=:id_packcab and id_agrupa=:id_agrupa and nivel_agr=:nivel_agr and linea=:linea');
    ParamByName('id_packcab').AsInteger:=id_packcab;
    ParamByName('id_agrupa').AsInteger:=id_agrupa;
    ParamByName('nivel_agr').AsInteger:=nivel_agr;
    ParamByName('linea').AsInteger:=linea;
    ParamByName('fecha_i').AsDate:=date;
    ParamByName('hora_i').AsTime:=Time;
    ParamByName('id_usuario_i').AsInteger:=u_globals.id_usuario;
    ParamByName('pc').AsString:=u_globals.pc_name;

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
      if FileExists(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+'-Albaran_Cerrado.wav') then
        sndPlaySound(PChar(ruta_exe+'Audio\'+inttostr(u_globals.voice_id)+'-Albaran_Cerrado.wav'),SND_NODEFAULT Or SND_ASYNC);
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

procedure Tf_main.cerrar_albaran(codalbaran:integer);
var n_fecha:tdate;     bultos:integer;
begin
  with tpfibdataset.create(Self) do begin                  //Buscar Bultos
    Database:=dm.db;
    sqls.SelectSQL.Add('select b.bultos '+
      'from a_packlin l '+
      'inner join a_packlin_bulto b on (l.id_packlin_bulto=b.id_packlin_bulto) '+
      'where l.id_packcab=:id_packcab and l.id_agrupa=:id_agrupa and l.nivel_agr=:nivel_agr and l.codalbaran=:codalbaran '+
      'group by 1');
    ParamByName('id_packcab').asinteger:=id_packcab;
    ParamByName('id_agrupa').asinteger:=id_agrupa;
    ParamByName('nivel_agr').asinteger:=nivel_agr;
    ParamByName('codalbaran').asinteger:=codalbaran;
    Open;

    if isempty then begin
      bultos:=0;
    end else  begin
      bultos:=FieldByName('bultos').AsInteger;
    end;
    Free;
  end;

  if id_cliente<>6702 then begin
    n_fecha:=siguiente_laboral(Date);                          //Fecha

    with TADOQuery.Create(Self) do try                                      //Cambia fecha y bultos en SQL SERVER
      Connection:=dm.con1;
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
    ParamByName('id_usuario').AsInteger:=u_globals.id_usuario;
    ParamByName('pc').AsString:=u_globals.pc_name;

    dm.t_write.StartTransaction;
    execquery;
    dm.t_write.commit;
  finally
    Free;
  end;
end;

procedure Tf_main.update_sqlserver_lotes;
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

{$ENDREGION}

{$REGION 'Imprimir Individual'}
procedure Tf_main.bt_print_indivClick(Sender: TObject);
begin
  imprime_eti_indiv(id_packcab,id_agrupa,nivel_agr,dm.q_pack_leido.FieldByName('linea').AsInteger);
end;

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
{$ENDREGION}

{$REGION 'Imprimir Bultos'}
procedure Tf_main.bt_print_bultosClick(Sender: TObject);
begin
  if dm.q_packagr.FieldByName('codrepartidor').AsInteger=46120 then
       imprime_eti_bulto_asm(dm.q_packagr.FieldByName('codalbaran').Asinteger)
  else
       imprime_eti_bulto(dm.q_packagr.FieldByName('codalbaran').Asinteger);
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
  dm.qrytemp.SQL.Clear;
  dm.qrytemp.SQL.Add('select top 1 d.id_del as id_del,d.nombre as nombre '+                    //qrym
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


function Zeros(c: string; l: Integer): string;
var i: Integer;
begin
  c:=Trim(c);
  l:=l-Length(c);
  for i := 1 to l do c:='0'+c;

  Result := c;
end;
function Espacios(cadena: string; l: Integer): string;
var longitud: Integer;
begin
  cadena:=Trim(cadena);
  longitud:=Length(cadena);
  if longitud<l then
  begin
    cadena:=cadena+System.StrUtils.DupeString(' ', (l-longitud));
  end;
  cadena:=Copy(cadena,1,l);

end;
function LeerHexa(fichero: string) : string;
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
{$ENDREGION}

{$REGION 'Imprimir Prev'}
procedure Tf_main.bt_print_prevClick(Sender: TObject);
begin
  print_etiq_pre(dm.q_packagr.FieldByName('codalbaran').Asstring, dm.q_packagr.FieldByName('tipo_caja').Asstring,
      dm.q_packagr.FieldByName('codrepartidor').AsString, dm.q_packagr.FieldByName('id_ruta').AsString,
      dm.q_packagr.FieldByName('id_caja').asinteger,dm.q_packagr.FieldByName('id_packlin_bulto').asinteger,
      dm.q_packagr.FieldByName('n_bulto').asinteger);
end;

procedure Tf_main.print_etiq_pre(codalbaran,tipo_caja,codrepartidor,id_ruta:string; id_caja,id_packlin_bulto,n_bulto:integer);   //etiqueta identificativa de caja
const cr=Chr(13);  lf=chr(10);
var s:string;
begin
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

  WriteRawDataToPrinter(u_globals.imp_eti,s);
end;
{$ENDREGION}


{$REGION 'Imprimir Etiquetas Traducidas') }
procedure Tf_main.imprime_etiquetasArticulos(etiqueta:string);
var memo1:TfrxMemoView;
 informe:tfrxreport;
 tipo_etiqueta:string;
begin
cdstrad.EmptyDataSet;
with dm.qry_Traduccion do
 begin
  Close;
  SelectSQL.Text:='select traduccion,medida from g_articulos_traducciones where tipo_etiqueta='+quotedstr(etiqueta);
  Open;
  if(FieldByName('medida').AsString='G') then
   begin
    informe:=rep_Etiq_Grande;
    cdsTrad.Insert;
    cdsTrad.FieldByName('texto').AsString := UTF8ToUnicodeString(fieldbyname('traduccion').AsString);
    informe.PrintOptions.Printer :=imp_eti_italiaGRA;
    if(rep_Etiq_Grande.PrepareReport(true)) then rep_Etiq_Grande.Print;
   end
  else if(FieldByName('medida').AsString='P') then
        begin
         informe:=rep_Etiq_Peq;
         cdsTrad.Insert;
         cdsTrad.FieldByName('texto').AsString := UTF8ToUnicodeString(fieldbyname('traduccion').AsString);
         cdsTrad.Post;
         informe.PrintOptions.Printer := imp_eti_italiaPEQ;
         if(rep_Etiq_Peq.PrepareReport(true)) then
             rep_Etiq_Peq.print;
        end
 end;
end;

function Tf_main.comprobar_si_etiquetaNecesaria(albaran,articulo:integer;out etiqueta:string):Boolean;
begin
result:=False;
etiqueta:='';
 with dm.qry_Traduccion do
  begin
    Close;
    SelectSQL.Text:='select id_pais from a_packlin where codalbaran='+quotedstr(inttostr(albaran));
    Open;
    //En principio las etiquetas en Castellano no se deberian imprimir, asi que se comentan
    if(FieldByName('id_pais').AsString='ES') then
     begin
      //dm.qry_etiquetaNec.Close;
      //dm.qry_etiquetaNec.SelectSQL.Text:='select etiq_nac as eti from g_articulos where id_articulo='+quotedstr(IntToStr(articulo));
      //dm.qry_etiquetaNec.Open;
      //if(dm.qry_etiquetaNec.FieldByName('eti').AsString<>'') then
      // begin
      //  result:=true;
      //  etiqueta:=dm.qry_etiquetaNec.FieldByName('eti').AsString;
      // end;
     end
    else if(FieldByName('id_pais').AsString='IT') then
          begin
           dm.qry_etiquetaNec.Close;
           dm.qry_etiquetaNec.SelectSQL.Text:='select etiq_intL as eti from g_articulos where id_articulo='+quotedstr(IntToStr(articulo));
           dm.qry_etiquetaNec.Open;
           if(dm.qry_etiquetaNec.FieldByName('eti').AsString<>'') then
            begin
             result:=true;
             etiqueta:=dm.qry_etiquetaNec.FieldByName('eti').AsString;
            end;
          end;
  end;
end;
{$ENDREGION}

{$REGION 'Hoja Pick'}
procedure Tf_main.bt_imp_pickClick(Sender: TObject);
var
  i:Integer;
begin
//
//
//  dm.q_packagr.First;
//  while not dm.q_packagr.eof do
//  begin

    imprime_hoja_pick(dm.q_packagr.FieldByName('codalbaran').Asinteger);
//    dm.q_packagr.Next;
//  end;

//  send_hoja_pick(dm.q_packagr.FieldByName('codalbaran').Asinteger);
end;

procedure Tf_main.imprime_hoja_pick(codalbaran:Integer);
begin
  if (id_cliente = 6702) then begin
    imprime_hoja_pick_lis(codalbaran);
  end else begin
    dm.q_hoja_pick.Close;
    dm.q_hoja_pick.SelectSQL.Clear;
    dm.q_hoja_pick.SelectSQL.Add('select b.codalbaran,b.fecha_alb,b.dst_codcli,b.dst_coddel, '+
      '  b.cod_ruta,b.tipo_caja,b.id_caja,b.dst_nombre,b.dst_calle,b.dst_cp, '+
      '  b.dst_localidad,b.dst_provincia,iif(a.id_cliente=7004,substring(a.codigo from 7 for 6),a.codigo) as codigo, '+
      '  iif(a.id_cliente=7004,l.sulinea,0) as bc,a.nombre,l.att,l.sulinea,b.codcli, lo.id_lote, lo.nombre as n_lote, lo.caducidad, '+
      '  sum(l.cantidad) as cantidad '+
      'from a_packlin l '+
      'inner join a_packlin_bulto b on (l.id_packlin_bulto=b.id_packlin_bulto) '+
      'inner join g_articulos a on (l.id_articulo=a.id_articulo) '+
      'inner join a_lotes lo on (lo.id_lote = l.id_lote) '+
      'where l.id_packcab=:id_packcab and l.id_agrupa=:id_agrupa and l.nivel_agr=:nivel_agr and l.codalbaran=:codalbaran '+
      'group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21 '+
      'order by 16,17');
    dm.q_hoja_pick.ParamByName('nivel_agr').asinteger:=nivel_agr;
    dm.q_hoja_pick.ParamByName('id_packcab').asinteger:=id_packcab;
    dm.q_hoja_pick.ParamByName('id_agrupa').asinteger:=id_agrupa;
    dm.q_hoja_pick.ParamByName('codalbaran').asinteger:=codalbaran;
    dm.q_hoja_pick.Open;

    rep_pick2.PrintOptions.Printer:=u_globals.imp_def;

    with rep_pick2.FindObject('memo4') as TfrxMemoView do begin
      if (dm.q_hoja_pick.FieldByName('codcli').asinteger=7004) then Visible:=true
      else Visible:=false;
    end;

    //if rep_pick2.PrepareReport(True) then rep_pick2.ShowPreparedReport;
    if rep_pick2.PrepareReport(True) then rep_pick2.print;
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

    f_envia_mail.Show;
    f_envia_mail.envia_email(email,'marta@thelifeisshort.com',
    //f_envia_mail.envia_email(email,'informatica@loginser.com',
        'Pedido Life Is Short '+dm.q_fib2.fieldbyname('id_order').asstring,
        filename,
        cuerpo,
        2);
    f_envia_mail.close;
   cuerpo.Free;
  end;

  if not(send_email) then begin
  //  if rep_lis.PrepareReport(True) then rep_lis.print;
  end;
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
    if (dm.q_hoja_pick.FieldByName('codcli').asinteger=7004) then Visible:=true
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

  f_envia_mail.Show;
  f_envia_mail.envia_email(email,pick_email,
      'Entrega Artículos Semanal '+formatdatetime('dd/mm/yyyy',date),
      filename,
      cuerpo,
      2);
  f_envia_mail.close;

  cuerpo.Free;
end;
{$ENDREGION}

{$REGION 'Imprimir Aux'}
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
{$ENDREGION}

{$REGION 'Aux'}
procedure Tf_main.get_defaults;
begin
  with TpFIBDataSet.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select * from a_aux');
    Open;

    cubic_a:=FieldByName('cubic_a').asinteger;
    cubic_b:=FieldByName('cubic_b').asinteger;
    cubic_c:=FieldByName('cubic_c').asinteger;
    cubic_d:=FieldByName('cubic_d').asinteger;
    cubic_e:=FieldByName('cubic_e').asinteger;
    percent_cubic:=fieldbyname('PERCENT_CERRAR').asinteger;

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
end;

procedure Tf_main.g_gridDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if DataCol=0 then
    with Sender as TJvDBGrid do begin
      if dm.q_packagr.fieldbyname('pendiente').AsInteger=0 then
        Canvas.Brush.Color:=$00FFBFBF
      else Canvas.Brush.Color:=clwhite;
      DefaultDrawColumnCell(rect,datacol,column,state);
    end;
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
{$ENDREGION}

{$REGION 'Chrono'}
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

function Tf_main.get_chrono_exp(codalbaran:integer; codcli:string):string;
begin
  result:= codcli + FormatFloat('0000000',codalbaran);   //16
end;

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

procedure Tf_main.send_chrono_file;
var   cuerpo:tstrings;    ruta:string;         email:Tf_envia_mail;
begin
  ruta:=u_globals.ruta_exe + 'bak\';
  ForceDirectories(ruta);
  //ruta:=u_gen_gl.sys_path+u_cam_gl.chrono_exp_path+get_nombrefichero_chrono(date);
  ruta:=ruta + get_nombrefichero_chrono(date);
  genera_fichero_abierto(ruta);
  lb_st.Caption:='Enviando Correo';

  cuerpo:=tstringlist.Create;
  cuerpo.Add('Se Adjunta Archivo de Expediciones de Loginser');

  email:=Tf_envia_mail.create(Self);
  email.Show;
  email.envia_email(u_cam_gl.chrono_exp_email,'','Fichero Life Is Short '+formatdatetime('yymmdd',Date)+'_'+formatdatetime('hhnnss',time),
    ruta,cuerpo);
  cuerpo.Free;
  email.close;
  email.Free;

  lb_st.Caption:='Proceso Finalizado';
  //sMessageDlg('Proceso Finalizado, Archivo de Respaldo en '+ruta,mtInformation,[mbok],0);
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
      dm.qu_1.sql.Clear;
      dm.qu_1.sql.Add('insert into C_CHRONO_FICENVALB (fecha,contador) values (:fecha,:contador) ');
      dm.qu_1.ParamByName('fecha').asdatetime:=fecha;
      dm.qu_1.ParamByName('contador').asinteger:=contador+1;
      dm.qu_1.execquery;

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
{$ENDREGION}

{$REGION 'DHL'}

procedure Tf_main.marca_alb_agrupado_enviado(n_bulto_chrono:string);
begin
  with tpfibquery.create(Self) do
  try
    Database:=dm.db;
    Transaction:=dm.t_write;
    sql.Add('update a_packlin_bulto set enviado=''S'' '+
        'where n_bulto_chrono=:n_bulto_chrono and cod_repartidor=46276');
    ParamByName('n_bulto_chrono').AsString:=n_bulto_chrono;
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
//esta debe ser la funcion a usar porque generará un único fichero
procedure tf_main.genera_fichero_agrupado_dhl(filename:string);//Genera Fichero
var  f:textfile; sl:TStrings; codrepartidor,linea:string;
begin
//aqui agrupamos por n_bulto_chrono (solo para dhl)
 sl:=TStringList.Create();
 codrepartidor:='46276';
 try   //agregado el try
  begin
  dm.t_write.StartTransaction;
  with tpfibdataset.Create(self) do
   begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
   SQLs.SelectSQL.Add('select distinct(n_bulto_chrono),count(id_packlin_bulto),count(fecha) '+
//                       ' from a_packlin_bulto b '+
//                       ' inner join a_packlin l on (b.id_packlin_bulto=l.id_packlin_bulto) '+
//                       ' inner join a_packcab c on (c.id_packcab=l.id_packcab) '+
//                       ' where codrepartidor=:codrepartidor  and b.enviado=''N'' and c.fecha>=:dia '+
//                       ' group by b.n_bulto_chrono '+
//                       ' order by  b.n_bulto_chrono');
//    ParamByName('dia').AsDate:=now-1;
      ' from a_packlin_bulto'+
      ' where cod_repartidor=:codrepartidor  and enviado=''N'' '+


      ' group by n_bulto_chrono  '+
      ' having count(id_packlin_bulto)=count(fecha)');

    ParamByName('codrepartidor').AsString:=codrepartidor;
    Open;
    First;
    if not(IsEmpty) then
     begin
      try
       while not(Eof) do
        begin
         linea:='';
         linea:=linea_dhl_agrupado(FieldByName('n_bulto_chrono').asString);
         marca_alb_agrupado_enviado(FieldByName('n_bulto_chrono').asString);
         if linea<>'' then begin
          sl.Add(AnsiString(linea));
         end;
         next;
        end;
      finally
       sl.SaveToFile(filename,TEncoding.ANSI);
       dm.t_write.CommitRetaining;
      end;
      Next;
    end else raise exception.Create('No Hay Expediciones Para Enviar');
   Free;
   end;
  end;
 except
  dm.t_write.RollbackRetaining;
  raise exception.Create('No Hay Expediciones Para Enviar');
 end;
end;
//este va a desaparecer
procedure tf_main.genera_fichero_abierto_dhl(filename:string);//Genera Fichero
var  f:textfile; sl:TStrings; codrepartidor,linea:string;
begin
 sl:=TStringList.Create();
 codrepartidor:='46276';                          //DHL
 //se va a enviar por pedidos del día agrupando por n_bulto_chrono
 //se envía por agrupación
  with tpfibdataset.Create(self) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select distinct(b.codalbaran),c.id_packcab '+
      ' from a_packlin_bulto b '+
      ' inner join a_packlin l on (b.id_packlin_bulto=l.id_packlin_bulto) '+
      ' inner join a_packcab c on (c.id_packcab=l.id_packcab) '+
      ' where c.id_packcab=:id_packcab and l.id_agrupa=:id_agrupa and l.nivel_agr=:nivel_agr '+
      ' group by b.codalbaran,c.id_packcab order by b.codalbaran');
    ParamByName('id_packcab').asinteger:=id_packcab;
    ParamByName('id_agrupa').asinteger:=id_agrupa;
    ParamByName('nivel_agr').asinteger:=nivel_agr;
    Open;

    First;
    if not(IsEmpty) then begin
      try
        //AssignFile(f,filename);
        //Rewrite(f);
        while not(Eof) do begin
          linea:='';
          linea:=linea_dhl_abierto(FieldByName('codalbaran').asinteger,FieldByName('id_packcab').asinteger);

          if linea<>'' then begin
            //Writeln(f,linea);
            sl.Add(AnsiString(linea));
           // marca_alb_agrupado_enviado(FieldByName('codalbaran').asinteger);
          end;

          next;
        end;
      finally
        sl.SaveToFile(filename,TEncoding.ANSI);
        //CloseFile(f);
      end;
    end else raise exception.Create('No Hay Expediciones Para Enviar');

    Free;
  end;
end;


procedure Tf_main.enviarFicheroSSH(ruta: string; fichero: string);
{var
 ScSSHClient: TScSSHClient;
 ScFileStorage: TScFileStorage;
 ScSFTPClient: TScSFTPClient;}
begin
 {ScFileStorage := TScFileStorage.Create(nil);
 ScSSHClient := TScSSHClient.Create(nil);
 ScSSHClient.KeyStorage := ScFileStorage;
 ScSSHClient.HostName := 'ftp3.dhl.com';
 ScSSHClient.HostKeyAlgorithms.Add;
 ScSSHClient.OnServerKeyValidate := ScSSHClientServerKeyValidate;
 ScSSHClient.User := 'nb43apym';
 ScSSHClient.Password := 'bd&L~c5p5:BV>S7F';
 ScSSHClient.Connect;
 ScSFTPClient := TScSFTPClient.Create(nil);
 ScSFTPClient.SSHClient := ScSSHClient;
 ScSFTPClient.Initialize;
 scSFTPClient.Active;
 ScSFTPClient.OpenDirectory('./in/work');
 ScSFTPClient.UploadFile(ruta, './in/work/'+fichero, False);
 ScSFTPClient.RenameFile('./in/work/'+fichero,'./in/build/'+fichero);
 ScSSHClient.Disconnect;   }
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

function Tf_main.linea_dhl_abierto(codalbaran,id_packcab:Integer):string;                   //Genera Linea para dhl
var bultos,cp:integer; cliente_dhl,producto_dhl,n_bulto_dhl_ini,n_bulto_dhl_fin:string;
COCODCLI,COANYOD,COEXPE_DDD,COCORR,COTLFDES,COBULTOS,COKILOS,COKILVOL,COREEMBO,
COVASEG,COFECSAL,COTLFREM,COPRODU,COIMPADU,COCLIAER,COAWB,COVOLUM,COPADE,COTSER,
CONSIG,CODIRDES,COPOBDES,COCPDES,COREFCLI,COMONREM,COPREEMB,COMONVAL,COPVASEG,
COALBFIR,COOBSER1,COOBSER2,COCLVADU,CONOMREM,CODIRREM,COPOBREM,COCPREM,COCLPINT,
CONOMCTO,CODESBIE,COMONADU,COTLFINT,COPAOR,COMAILREM,COCTOREM,COMAILDES,COPROFEAT:string;
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
      n_bulto_dhl_ini:=FieldByName('n_bulto_chrono').AsString;
      last;
      n_bulto_dhl_fin:=FieldByName('n_bulto_chrono').AsString;
    end else begin
      n_bulto_dhl_ini:='0';
      n_bulto_dhl_fin:='0';
    end;
  finally
    Free;
  end;

  with tpfibdataset.create(Self) do
  try
    Database:=dm.db;
    sqls.SelectSQL.Add('select distinct b.dst_cp,l.id_pais as dst_pais,b.dst_codcli,b.bultos,b.dst_nombre,b.dst_calle,b.dst_persona,b.dst_tfno,b.dst_localidad,b.kgs, '+
                       'b.observaciones,b.fecha_alb,b.dst_coddel,b.n_bulto_chrono,0 as asegurado, reembolso,b.pdebido,b.n_bulto_chrono,paw.awb  '+
                       ' from a_packlin_bulto b '+
                       ' inner join a_packlin l on (b.id_packlin_bulto=l.id_packlin_bulto) '+
                       ' inner join a_packcab c on (c.id_packcab=l.id_packcab) '+
                       ' left join a_packlin_bulto_awb paw on paw.codalbaran=b.codalbaran '+
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
        producto_dhl:='69';  //no es este producto en dhl Revisar
      end else begin
        producto_dhl:='63'; //no es este producto en dhl Revisar
      end;
     dm.qdhl.Close;
     dm.qdhl.SelectSQl.Clear;
     dm.qdhl.SelectSQL.Add('select * from C_DHL_MDISP where pais_origen=''ES'' and service_area_origen=''VLC'' and '+
                           ' cp_destino=:cp and pais_destino=:pais');
     dm.qdhl.ParamByName('cp').AsInteger:=fieldbyname('dst_cp').asinteger;
     dm.qdhl.ParamByName('pais').asstring:=fieldbyname('dst_pais').asstring;
     dm.qdhl.Open;
     dm.qry_kgs.close;
     //los kilos no van a ser necesarios porque va a ser un etiquetado con kgs a 1, dhl recalcula los kgs
     dm.qry_kgs.SelectSQL.Text:='select pack.id_packcab,sum(pack.cantidad*art.kgs) as Total from  '+
                                'a_packlin pack inner join g_articulos art on art.id_articulo=pack.id_articulo '+
                                'where pack.estado=''A'' and pack.id_packcab='+inttostr(id_packcab)+' and pack.codalbaran='+inttostr(codalbaran)+'' +
                                'group by id_packcab';
      dm.qry_kgs.Open;

     //esto va a ser variable, dependiendo del remitente
     cliente_dhl:='46-007641';
     COCODCLI:='007641';
     COPADE:=dm.qdhl.FieldByName('pais_destino').asstring;
     COANYOD:=Copy(FormatDateTime('ddmmyyyy',now),8,1);
     //COEXPE_DDD:=n_bulto_dhl_fin;
     COEXPE_DDD:=FieldByName('n_bulto_chrono').asstring;
     COCORR:='0';
     CONSIG:=FieldByName('dst_nombre').AsString;
     CODIRDES:=FieldByName('dst_calle').AsString;
     COPOBDES:=FieldByName('dst_localidad').AsString;;
     COCPDES:=FieldByName('dst_cp').AsString;
     COTLFDES:=SoloNumeros(FieldByName('dst_tfno').AsString);
     if (COPADE<>'ES') then COTLFINT:=SoloNumeros(FieldByName('dst_tfno').AsString);
     //COREFCLI;
     COBULTOS:=FieldByName('bultos').AsString;
     if(dm.qry_kgs.FieldByName('Total').AsString='0') or (dm.qry_kgs.FieldByName('Total').AsString='') then
       COKILOS:=FloatToStr(round(FieldByName('kgs').asFloat*FieldByName('bultos').asFloat))    //por si los kilos estan vacios
      else COKILOS:=FloatToStr(round(dm.qry_kgs.FieldByName('Total').AsFloat));

      if(StrToFloat(COKILOS)<1) then COKILOS:='1';
      // COKILVOL;
      if (FieldByName('reembolso').AsFloat>0) then
      begin
        COREEMBO:=ReplaceStr(FieldByName('reembolso').AsString,',','');
        if(FieldByName('pdebido').AsFloat>0 ) then
           COPREEMB:='D'
        else COPREEMB:='P';
        COMONREM:='EUR';
      end;

    // COPREEMB;
     COFECSAL:=FormatDateTime('DDMMYYYY',FieldByName('FECHA_ALB').AsDateTime);
     CONOMREM:='LIFE IS SHORT';
     CODIRREM:='C/DR FLEMING ,43';
     COPOBREM:='ALACUAS - SPAIN';
     COCPREM:='46970';
     COTLFREM:='902108957';
     COREFCLI:=IntToStr(CODALBARAN);
     if((COPADE<>'ES') and (COPADE<>'PT')) THEN
     begin
       COAWB:= FieldByName('awb').asstring;
       COCLIAER:='301922508'
      end;

     if((COPADE='ES') AND (length(COCPDES)=4)) then
      COCPDES:='0'+COCPDES;

     if (not esAduanero(copade)) then
      COCLPINT:='CPT'
     else
      begin
       COCLPINT:='DDP';
      end;
     COPRODU:=codigoProducto(COPADE);
     bultos:=FieldByName('bultos').AsInteger;
     Result:=
      cadLongitudFija(COCODCLI,6,TRUE,'0') +    //codigo cuenta DHL del pagador
      cadLongitudFija(COANYOD,1,TRUE,'0') +     //ultimo digito del año en curso
      cadLongitudFija(COPADE,2,FALSE,' ')+      //codigo ISO pais destino
      cadLongitudFija(COEXPE_DDD,8,TRUE,'0')+   //numero de expedicion
      cadLongitudFija(COCORR,1,TRUE,'0')+       //constante 0
      cadLongitudFija(' ',1,TRUE,' ')+          //relleno
      cadLongitudFija(COTSER,1,FALSE,' ')+      //clave del tipo de servicio a canarias,azores o madeira
      cadLongitudFija(CONSIG,40,FALSE,' ')+     //Nombre destinatario
      cadLongitudFija(CODIRDES,40,FALSE,' ')+   //Direccion destinatario
      cadLongitudFija(COPOBDES,20,FALSE,' ')+   //Poblacion destinatario
      cadLongitudFija(COCPDES,9,FALSE,' ')+     //CP destinatario
      cadLongitudFija(COTLFDES,9,TRUE,'0')+     //Teléfono destinatario
      cadLongitudFija(' ',1,TRUE,' ')+          //relleno
      cadLongitudFija(COREFCLI,35,FALSE,' ')+   //Referencia cliente
      cadLongitudFija(' ',2,TRUE,' ')+          //relleno
      cadLongitudFija(COBULTOS,3,TRUE,'0')+     //Total de bultos
      cadLongitudFija(COKILOS,5,TRUE,'0')+      //Total de kilos
      cadLongitudFija(COKILVOL,5,TRUE,'0')+     //Total de kilos volumen
      cadLongitudFija(COREEMBO,11,TRUE,'0')+    //Importe del reembolso .2 decimales
      cadLongitudFija(COMONREM,3,FALSE,' ')+    //Moneda del reembolso (€=EUR)
      cadLongitudFija(COPREEMB,1,FALSE,' ')+    //Clave del pagador de los gastos del reembolso
      cadLongitudFija(COVASEG,9,TRUE,'0')+      //Valor del seguro en caso de mercancia asegurada.2 decimales
      cadLongitudFija(COMONVAL,3,FALSE,' ')+    //Moneda del importe del seguro a todo riesgo
      cadLongitudFija(COPVASEG,1,FALSE,' ')+    //Clave del pagador de los gastos del seguro
      cadLongitudFija(COALBFIR,1,FALSE,' ')+    //Clave del servicio de devolución de albaranes firmados
      cadLongitudFija(' ',1,TRUE,' ')+          //relleno
      cadLongitudFija(COOBSER1,40,FALSE,' ')+   //Observaciones 1
      cadLongitudFija(COOBSER2,40,FALSE,' ')+   //Observaciones 2
      cadLongitudFija(COCLVADU,1,FALSE,' ')+    //Clave de pagador de los gastos de aduanas
      cadLongitudFija(COFECSAL,8,TRUE,'0')+     //Fecha de salida DDMMAAAA
      cadLongitudFija(CONOMREM,40,FALSE,' ')+   //Nombre remitente
      cadLongitudFija(CODIRREM,40,FALSE,' ')+   //Direccion remitente
      cadLongitudFija(COPOBREM,20,FALSE,' ')+   //Poblacion remitente
      cadLongitudFija(COCPREM,5,TRUE,' ')+      //CP remitente
      cadLongitudFija(COTLFREM,9,TRUE,'0')+     //Telefono remitente
      cadLongitudFija(' ',11,TRUE,' ')+         //relleno
      cadLongitudFija(COCLPINT,3,FALSE,' ')+    //Clave del pagador de los gastos de expedicion
      cadLongitudFija(COPRODU,3,TRUE,'0')+      //Clave del producto
      cadLongitudFija(CONOMCTO,25,FALSE,' ')+   //persona de contacto en destino (obligatorio en internacionales)
      cadLongitudFija(CODESBIE,70,FALSE,' ')+   //Descripcion de bienes (obligatorio en internacionales)
      cadLongitudFija(COIMPADU,15,TRUE,'0')+    //Valor declarado de bienes (obligatorio en internacionales).2 decimales
      cadLongitudFija(COMONADU,3,FALSE,' ')+    //Moneda del valor declarado
      cadLongitudFija(COTLFINT,15,FALSE,' ')+   //Telefono destinatario (en internacionales)
      cadLongitudFija(COCLIAER,9,TRUE,'0')+     //Codigo adicional de cuenta DHL del pagador para expediciones internacionales
      cadLongitudFija(COAWB,10,TRUE,'0')+       //Numero de AWB
      cadLongitudFija(COPAOR,2,FALSE,' ')+      //Codigo ISO del pais de origen
      cadLongitudFija(COMAILREM,50,FALSE,' ')+  //Email del remitente
      cadLongitudFija(COCTOREM,25,FALSE,' ')+   //Persona de contacto remitente
      cadLongitudFija(COMAILDES,50,FALSE,' ')+  //Email destinatario
      cadLongitudFija(COVOLUM,4,TRUE,'0')+      //Volumen total de la expedicion .2 decimales
      cadLongitudFija(COPROFEAT,90,FALSE,' ')   //Caracteristicas del producto
//        result:=cliente_dhl+     // Numero de cliente dhl

//        cadLongitudFija('Life Is Short',40,False,' ')+   // Nombre del Cliente de DHL Revisar
//        cadLongitudFija(n_bulto_dhl_ini,23,False,'0')+ // codigo de bulto inicial
//        cadLongitudFija(get_chrono_exp(codalbaran,cliente_dhl),20,False,' ') + //referencia del cliente
//        cadLongitudFija(FieldByName('dst_nombre').asstring,40,false,' ') + // nombre del consignatario
//        cadLongitudFija(FieldByName('dst_calle').asstring,40,false,' ') + // direccion del consignatario
//        cadLongitudFija(FieldByName('dst_persona').asstring,40,false,' ') + // atencion del consignatario
//        '  '+//por que piden 7 para el cp... relleno
//        cadLongitudFija(FieldByName('dst_cp').asstring,5,true,'0') + // cp del consignatario
//        cadLongitudFija(FieldByName('dst_tfno').asstring,15,false,' ') + // tfno del consignatario
//        cadLongitudFija(FieldByName('dst_localidad').asstring,40,false,' ') + // poblacion del consignatario
//        'P' + // portes pagados
//        producto_dhl+   // tipo de producto
//        FormatFloat('000000',bultos) +  // numero de bultos
//        FormatFloat('000000.000',FieldByName('Kgs').asfloat) + // peso
//        FormatFloat('000000000.00', FieldByName('reembolso').asfloat) +  //importe reembolso
//        cadLongitudFija(get_chrono_exp(codalbaran,cliente_dhl),16,false,'0')+
//        '    ' + // codigo pais  nacional en blanco
//        cadLongitudFija(n_bulto_dhl_fin,23,False,'0')+ // codigo de bulto inicial
//        cadLongitudFija(FieldByName('observaciones').AsString,40,false,' ') + // observa 1
//        cadLongitudFija(' ',40,false,' ')+   // observa 2
//        FormatDateTime('yyyymmdd',FieldByName('fecha_alb').AsDateTime)+ // fecha salida
//        '                              '+      //Numero de serie antiguo (Solo para producto Loinex)
//        '                    '+       //Modelo de Nuevo (Solo para producto Loinex)
//        '                    '+       //Modelo Viejo (Solo para producto Loinex)
//        '                '+          //Número de Envío de Retorno Loinex (Debe ser el estandar de ChronoExpres)
//        '                              '+      //Numero de serie nuevo (Solo para producto Loinex)
//        FormatFloat('000000000.00',FieldByName('asegurado').asfloat); // Valor asegurado de la mercancía
    end;
  finally
    Free;
  end;

end;

function Tf_main.linea_dhl_agrupado(n_bulto_chrono:string):string;                   //Genera Linea para dhl
var bultos,cp:integer; cliente_dhl,producto_dhl,n_bulto_dhl_ini,n_bulto_dhl_fin:string;
COCODCLI,COANYOD,COEXPE_DDD,COCORR,COTLFDES,COBULTOS,COKILOS,COKILVOL,COREEMBO,
COVASEG,COFECSAL,COTLFREM,COPRODU,COIMPADU,COCLIAER,COAWB,COVOLUM,COPADE,COTSER,
CONSIG,CODIRDES,COPOBDES,COCPDES,COREFCLI,COMONREM,COPREEMB,COMONVAL,COPVASEG,
COALBFIR,COOBSER1,COOBSER2,COCLVADU,CONOMREM,CODIRREM,COPOBREM,COCPREM,COCLPINT,
CONOMCTO,CODESBIE,COMONADU,COTLFINT,COPAOR,COMAILREM,COCTOREM,COMAILDES,COPROFEAT:string;
begin
//cuando crea el fichero antes de la recogida de DHL, los kilos ya los sabemos
 with tpfibdataset.create(Self) do
  try
   Database:=dm.db;
   sqls.SelectSQL.Add('select b.codalbaran,b.dst_cp,l.id_pais as dst_pais,b.dst_codcli,b.bultos,b.dst_nombre,b.dst_calle,b.dst_persona,b.dst_tfno,b.dst_localidad,b.kgs, '+
                      'b.observaciones,b.fecha_alb,b.dst_coddel,b.n_bulto_chrono,0 as asegurado,b.n_bulto_chrono,paw.awb,reembolso,b.pdebido'+
                      ' from a_packlin_bulto b '+
                      ' inner join a_packlin l on (b.id_packlin_bulto=l.id_packlin_bulto) '+
                      ' inner join a_packcab c on (c.id_packcab=l.id_packcab) '+
                      //' left join a_packlin_bulto_awb paw on paw.codalbaran=b.codalbaran '+
                      ' left join a_packlin_bulto_awb paw on paw.codalbaran in (select codalbaran from a_packlin_bulto where n_bulto_chrono=:n_bulto_chrono)'+
                      ' where b.n_bulto_chrono=:n_bulto_chrono ');
                      //' GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18 ');
    ParamByName('n_bulto_chrono').asString:=n_bulto_chrono;
    Open;

    if not(isempty) then begin
      cp:=fieldbyname('dst_cp').asinteger;
      if (((cp>=35000) and (cp<=35999)) or ((cp>=38000) and (cp<=38999))) then begin
        producto_dhl:='69';  //no es este producto en dhl Revisar
      end else begin
        producto_dhl:='63'; //no es este producto en dhl Revisar
      end;
     dm.qdhl.Close;
     dm.qdhl.SelectSQl.Clear;
     dm.qdhl.SelectSQL.Add('select * from C_DHL_MDISP where pais_origen=''ES'' and service_area_origen=''VLC'' and '+
                           ' cp_destino=:cp and pais_destino=:pais');
     dm.qdhl.ParamByName('cp').AsInteger:=fieldbyname('dst_cp').asinteger;
     dm.qdhl.ParamByName('pais').asstring:=fieldbyname('dst_pais').asstring;
     dm.qdhl.Open;

     dm.qRemPor.Close;
     dm.qRemPor.SelectSQl.Clear;
     dm.qRemPor.SelectSQL.Add('select n_bulto_chrono,sum(distinct(reembolso)) as reembolso,sum(distinct (pdebido)) as pdebido '+
                              'from a_packlin_bulto '+
                              'where n_bulto_chrono=:n_bulto_chrono '+
                              'group by 1');
     dm.qRemPor.ParamByName('n_bulto_chrono').AsString:=n_bulto_chrono;
     dm.qRemPor.Open;
     //mantenemos los kilos para el fichero
     {dm.qry_kgs.close;
     dm.qry_kgs.SelectSQL.Text:='select pack.id_packcab,sum(pack.cantidad*art.kgs) as Total from  '+
                                'a_packlin pack inner join g_articulos art on art.id_articulo=pack.id_articulo '+
                                'where pack.estado=''A'' and pack.id_packcab='+inttostr(id_packcab)+' and pack.codalbaran='+inttostr(codalbaran)+'' +
                                'group by id_packcab';
     }
     {dm.qry_kgs.SelectSQL.Text:='select pack.id_packcab,sum(pack.cantidad*art.kgs) as Total from  '+
                                'a_packlin pack inner join g_articulos art on art.id_articulo=pack.id_articulo '+
                                'inner join a_packlin_bulto bul on bul.codalbaran=pack.codalbaran '+
                                'where pack.estado=''A'' bul.n_bulto_chrono='+quotedstr(n_bulto_chrono)+'' +
                                'group by n_bulto_chrono';
     }
     dm.qry_kgs.close;
     dm.qry_kgs.SelectSQL.Text:='select bul.n_bulto_chrono,sum(pack.cantidad*art.kgs) as Total from  '+
                                'a_packlin pack inner join g_articulos art on art.id_articulo=pack.id_articulo '+
                                'inner join a_packlin_bulto bul on bul.codalbaran=pack.codalbaran '+
                                'where pack.estado=''A'' and bul.n_bulto_chrono='+quotedstr(n_bulto_chrono)+'' +
                                'group by n_bulto_chrono';


     dm.qry_kgs.Open;

     //esto va a ser variable, dependiendo del remitente
     cliente_dhl:='46-007641';
     COCODCLI:='007641';
     COPADE:=dm.qdhl.FieldByName('pais_destino').asstring;
     COANYOD:=Copy(FormatDateTime('ddmmyyyy',now),8,1);
     COEXPE_DDD:=FieldByName('n_bulto_chrono').asstring;
     COCORR:='0';
     CONSIG:=FieldByName('dst_nombre').AsString;
     CODIRDES:=FieldByName('dst_calle').AsString;
     COPOBDES:=FieldByName('dst_localidad').AsString;;
     COCPDES:=FieldByName('dst_cp').AsString;
     COTLFDES:=SoloNumeros(FieldByName('dst_tfno').AsString);
     if (COPADE<>'ES') then COTLFINT:=SoloNumeros(FieldByName('dst_tfno').AsString);
     //COREFCLI;
     COBULTOS:=FieldByName('bultos').AsString;
     if(dm.qry_kgs.FieldByName('Total').AsString='0') or (dm.qry_kgs.FieldByName('Total').AsString='') then
       COKILOS:=FloatToStr(round(FieldByName('kgs').asFloat*FieldByName('bultos').asFloat))    //por si los kilos estan vacios
      else COKILOS:=FloatToStr(round(dm.qry_kgs.FieldByName('Total').AsFloat));
     //COKILOS:='1';

      if(StrToFloat(COKILOS)<1) then COKILOS:='1';
      // COKILVOL;
      if (dm.qRemPor.FieldByName('reembolso').AsFloat>0) then
      begin
        COREEMBO:=ReplaceStr(formatfloat('0.00',dm.qRemPor.FieldByName('reembolso').asFloat),',','');
        if(dm.qRemPor.FieldByName('pdebido').AsFloat>0 ) then
           COPREEMB:='D'
        else COPREEMB:='P';
        COMONREM:='EUR';
      end;

    // COPREEMB;
     COFECSAL:=FormatDateTime('DDMMYYYY',FieldByName('FECHA_ALB').AsDateTime);
     CONOMREM:='LIFE IS SHORT';
     CODIRREM:='C/DR FLEMING ,43';
     COPOBREM:='ALACUAS - SPAIN';
     COCPREM:='46970';
     COTLFREM:='902108957';
     COREFCLI:=FieldByName('codalbaran').asString;
     if((COPADE<>'ES') and (COPADE<>'PT')) THEN
     begin
       COAWB:= FieldByName('awb').asstring;
       COCLIAER:='301922508'
     end;

     if((COPADE='ES') AND (length(COCPDES)=4)) then
      COCPDES:='0'+COCPDES;

     if (not esAduanero(copade)) then
      COCLPINT:='CPT'
     else
      begin
       COCLPINT:='DDP';
      end;
     COPRODU:=codigoProducto(COPADE);
     bultos:=FieldByName('bultos').AsInteger;
     Result:=
      cadLongitudFija(COCODCLI,6,TRUE,'0') +    //codigo cuenta DHL del pagador
      cadLongitudFija(COANYOD,1,TRUE,'0') +     //ultimo digito del año en curso
      cadLongitudFija(COPADE,2,FALSE,' ')+      //codigo ISO pais destino
      cadLongitudFija(COEXPE_DDD,8,TRUE,'0')+   //numero de expedicion
      cadLongitudFija(COCORR,1,TRUE,'0')+       //constante 0
      cadLongitudFija(' ',1,TRUE,' ')+          //relleno
      cadLongitudFija(COTSER,1,FALSE,' ')+      //clave del tipo de servicio a canarias,azores o madeira
      cadLongitudFija(CONSIG,40,FALSE,' ')+     //Nombre destinatario
      cadLongitudFija(CODIRDES,40,FALSE,' ')+   //Direccion destinatario
      cadLongitudFija(COPOBDES,20,FALSE,' ')+   //Poblacion destinatario
      cadLongitudFija(COCPDES,9,FALSE,' ')+     //CP destinatario
      cadLongitudFija(COTLFDES,9,TRUE,'0')+     //Teléfono destinatario
      cadLongitudFija(' ',1,TRUE,' ')+          //relleno
      cadLongitudFija(COREFCLI,35,FALSE,' ')+   //Referencia cliente
      cadLongitudFija(' ',2,TRUE,' ')+          //relleno
      cadLongitudFija(COBULTOS,3,TRUE,'0')+     //Total de bultos
      cadLongitudFija(COKILOS,5,TRUE,'0')+      //Total de kilos
      cadLongitudFija(COKILVOL,5,TRUE,'0')+     //Total de kilos volumen
      cadLongitudFija(COREEMBO,11,TRUE,'0')+    //Importe del reembolso .2 decimales
      cadLongitudFija(COMONREM,3,FALSE,' ')+    //Moneda del reembolso (€=EUR)
      cadLongitudFija(COPREEMB,1,FALSE,' ')+    //Clave del pagador de los gastos del reembolso
      cadLongitudFija(COVASEG,9,TRUE,'0')+      //Valor del seguro en caso de mercancia asegurada.2 decimales
      cadLongitudFija(COMONVAL,3,FALSE,' ')+    //Moneda del importe del seguro a todo riesgo
      cadLongitudFija(COPVASEG,1,FALSE,' ')+    //Clave del pagador de los gastos del seguro
      cadLongitudFija(COALBFIR,1,FALSE,' ')+    //Clave del servicio de devolución de albaranes firmados
      cadLongitudFija(' ',1,TRUE,' ')+          //relleno
      cadLongitudFija(COOBSER1,40,FALSE,' ')+   //Observaciones 1
      cadLongitudFija(COOBSER2,40,FALSE,' ')+   //Observaciones 2
      cadLongitudFija(COCLVADU,1,FALSE,' ')+    //Clave de pagador de los gastos de aduanas
      cadLongitudFija(COFECSAL,8,TRUE,'0')+     //Fecha de salida DDMMAAAA
      cadLongitudFija(CONOMREM,40,FALSE,' ')+   //Nombre remitente
      cadLongitudFija(CODIRREM,40,FALSE,' ')+   //Direccion remitente
      cadLongitudFija(COPOBREM,20,FALSE,' ')+   //Poblacion remitente
      cadLongitudFija(COCPREM,5,TRUE,' ')+      //CP remitente
      cadLongitudFija(COTLFREM,9,TRUE,'0')+     //Telefono remitente
      cadLongitudFija(' ',11,TRUE,' ')+         //relleno
      cadLongitudFija(COCLPINT,3,FALSE,' ')+    //Clave del pagador de los gastos de expedicion
      cadLongitudFija(COPRODU,3,TRUE,'0')+      //Clave del producto
      cadLongitudFija(CONOMCTO,25,FALSE,' ')+   //persona de contacto en destino (obligatorio en internacionales)
      cadLongitudFija(CODESBIE,70,FALSE,' ')+   //Descripcion de bienes (obligatorio en internacionales)
      cadLongitudFija(COIMPADU,15,TRUE,'0')+    //Valor declarado de bienes (obligatorio en internacionales).2 decimales
      cadLongitudFija(COMONADU,3,FALSE,' ')+    //Moneda del valor declarado
      cadLongitudFija(COTLFINT,15,FALSE,' ')+   //Telefono destinatario (en internacionales)
      cadLongitudFija(COCLIAER,9,TRUE,'0')+     //Codigo adicional de cuenta DHL del pagador para expediciones internacionales
      cadLongitudFija(COAWB,10,TRUE,'0')+       //Numero de AWB
      cadLongitudFija(COPAOR,2,FALSE,' ')+      //Codigo ISO del pais de origen
      cadLongitudFija(COMAILREM,50,FALSE,' ')+  //Email del remitente
      cadLongitudFija(COCTOREM,25,FALSE,' ')+   //Persona de contacto remitente
      cadLongitudFija(COMAILDES,50,FALSE,' ')+  //Email destinatario
      cadLongitudFija(COVOLUM,4,TRUE,'0')+      //Volumen total de la expedicion .2 decimales
      cadLongitudFija(COPROFEAT,90,FALSE,' ')   //Caracteristicas del producto
    end;
  finally
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
{$ENDREGION}

{$REGION 'Acciones'}
procedure Tf_main.bt_cambioClick(Sender: TObject);              //Cambiar Caja
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

procedure Tf_main.bt_cerrar_cajaClick(Sender: TObject);                           //Cerrar Caja
begin
  if sMessageDlg('Está Seguro de Querer Cerrar La Caja '+dm.q_packagr.fieldbyname('id_caja').asstring+', Albarán '+dm.q_packagr.fieldbyname('codalbaran').asstring+' Y Abrir Una Nueva?',mtconfirmation,[mbYes,mbno],0)=mrYes then begin
   if (dm.q_packagr.FieldByName('total').AsInteger=dm.q_packagr.FieldByName('pendiente').asinteger) then raise exception.Create('No Se Puede Cerrar Una Caja Vacia');
   cerrar_caja_y_nueva(dm.q_packagr.fieldbyname('codalbaran').asinteger,dm.q_packagr.fieldbyname('id_packlin_bulto').asinteger);
  end;
end;

procedure Tf_main.cerrar_caja_y_nueva(codalbaran,id_packlin_bulto_old:integer; etiq_prev:Boolean=True);                                                                  //Cerrar caja actual y generar una nueva
var  cubic:real;  id_packlin_bulto_new,bultos,n_bulto,n_uds_pend:integer;   caja,etiq_chrono,n_bulto_dhl,n_bulto_str:string;
begin
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
        cubic:=FieldByName('cubic').asfloat;
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
    {if dm.q_packagr.fieldbyname('codrepartidor').asinteger=46276 then begin         //Num bulto de DHL
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
    end;  }

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

    with tpfibquery.create(Self) do                         //Actualiza Datos de lineas de packing
    try
      Database:=dm.db;
      Transaction:=dm.t_write;
      sql.Add('update a_packlin l set l.id_packlin_bulto=:id_packlin_bulto_new '+
        'where l.id_packcab=:id_packcab and l.id_agrupa=:id_agrupa and l.nivel_agr=:nivel_agr '+
        '    and l.codalbaran=:codalbaran and cantidad<>cantidad_i');
      ParamByName('id_packlin_bulto_new').AsInteger:=id_packlin_bulto_new;
      ParamByName('id_packcab').AsInteger:=id_packcab;
      ParamByName('id_agrupa').AsInteger:=id_agrupa;
      ParamByName('nivel_agr').AsInteger:=nivel_agr;
      ParamByName('codalbaran').AsInteger:=codalbaran;

      dm.t_write.StartTransaction;
      execquery;
      dm.t_write.commit;
    finally
      Free;
    end;
                                                                                                         //Imprime etiq prev de caja nueva
    if etiq_prev then print_etiq_pre(IntToStr(codalbaran), caja,
                        dm.q_packagr.FieldByName('codrepartidor').AsString, dm.q_packagr.FieldByName('id_ruta').AsString,
                        dm.q_packagr.FieldByName('id_caja').asinteger,id_packlin_bulto_new,n_bulto);

    lb_cajas_st.Visible:=true;
    lb_cajas_st.Caption:='Nueva Caja - '+caja;

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

  dm.q_pack.Close;
  dm.q_pack.Open;

  dm.q_pack_leido.Close;
  dm.q_pack_leido.Open;

  act_cajas;

  ed_cb.SetFocus;
end;

procedure Tf_main.bt_cerrar_agrupClick(Sender: TObject);                            //Cerrar Agrupacion
begin
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

  if not(only_one) then begin
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
      while not(eof) do begin
        cerrar_albaran(FieldByName('codalbaran').asinteger);

        if FieldByName('codrepartidor').AsInteger=46120 then   //ASM
               imprime_eti_bulto_asm(FieldByName('codalbaran').AsInteger)
          else
                imprime_eti_bulto(FieldByName('codalbaran').AsInteger);

        imprime_hoja_pick(FieldByName('codalbaran').AsInteger);
        next;
      end;

      Free;
    end;
  end;

  if (id_cliente=6702) then begin    //si es life is short sacar fichero de chrono
    if check_chrono then send_chrono_file;
    if check_dhl then send_dhl_file;
  end;

  if ((cb_send_email.checked) and ((id_cliente=7004) or (id_cliente=6702))) then begin
    with tpfibdataset.Create(dm) do begin                                   //envia hoja picking
      database:=dm.db;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select l.codalbaran,b.id_caja '+
        'from a_packlin l '+
        'inner join a_packlin_bulto b on (l.id_packlin_bulto=b.id_packlin_bulto) '+
        'where l.id_packcab=:id_packcab and l.nivel_agr=:nivel_agr and l.id_agrupa=:id_agrupa '+
        'group by 1,2 order by b.id_caja');
      ParamByName('nivel_agr').asinteger:=nivel_agr;
      ParamByName('id_packcab').asinteger:=id_packcab;
      ParamByName('id_agrupa').asinteger:=id_agrupa;
      Open;

      First;
      while not(eof) do begin
        if (id_cliente=6702) then begin
          imprime_hoja_pick_lis(FieldByName('codalbaran').AsInteger, true);
        end else begin
          send_hoja_pick(FieldByName('codalbaran').AsInteger);        //envia hoja de picking para bankia
        end;
        next;
      end;
      Free;
    end;
  end;

  sMessageDlg('Proceso Finalizado....',mtInformation,[mbok],0);
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

procedure Tf_main.bt_lectura_manualClick(Sender: TObject);               //Lectura Manual
begin
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select id_articulo '+
      'from g_articulos '+
      'where codigo=:codigo');
    ParamByName('codigo').asstring:=dm.q_pack.FieldByName('codigo').asstring;
    Open;

    if not(IsEmpty) then begin
      if only_one then ejecuta_lectura(FieldByName('id_articulo').asinteger,'',-1,false)
      else ejecuta_lectura(FieldByName('id_articulo').asinteger,'',dm.q_pack.FieldByName('codalbaran').asinteger,false, dm.q_pack.FieldByName('id_lote').asinteger);
    end;

    Free;
  end;
end;
{$ENDREGION}

{$REGION 'Translation'}
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

{$ENDREGION}


end.
