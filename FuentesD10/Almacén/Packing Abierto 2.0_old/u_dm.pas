unit u_dm;

interface

uses
  System.Classes, Data.DB, FIBDataSet, pFIBDataSet,
  pFIBDatabase ,pFIBQuery, FIBQuery, FIBDatabase, Data.Win.ADODB,
  Datasnap.DBClient, IPPeerClient, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, REST.Authenticator.Basic, Vcl.Dialogs;

type
  Tdm = class(TDataModule)
    db: TpFIBDatabase;
    t_read: TpFIBTransaction;
    t_write: TpFIBTransaction;
    q_peds: TpFIBDataSet;
    ds_peds: TDataSource;
    q_1: TpFIBQuery;
    ds_1: TpFIBDataSet;
    ds_2: TpFIBDataSet;
    q_peds_count: TpFIBDataSet;
    q_sql5: TADOQuery;
    qryAlbEdit: TADOQuery;
    intgrfldAlbEditcodalbaran: TIntegerField;
    str_AlbEditserie: TStringField;
    dtmfldAlbEditfecha: TDateTimeField;
    intgrfldAlbEditcodcli: TIntegerField;
    intgrfldAlbEditpaquetes: TIntegerField;
    intgrfldAlbEditbultos: TIntegerField;
    bcdfldAlbEditkgs: TBCDField;
    bcdfldAlbEditcodremitente: TBCDField;
    str_AlbEditorg_nombre: TStringField;
    str_AlbEditorg_calle: TStringField;
    str_AlbEditorg_cp: TStringField;
    str_AlbEditorg_localidad: TStringField;
    str_AlbEditorg_provincia: TStringField;
    str_AlbEditorg_persona: TStringField;
    str_AlbEditorg_tfno: TStringField;
    bcdfldAlbEditcoddestinatario: TBCDField;
    str_AlbEditdst_nombre: TStringField;
    str_AlbEditdst_calle: TStringField;
    str_AlbEditdst_cp: TStringField;
    str_AlbEditdst_localidad: TStringField;
    str_AlbEditdst_provincia: TStringField;
    str_AlbEditdst_persona: TStringField;
    str_AlbEditdst_tfno: TStringField;
    bcdfldAlbEditasegurado: TBCDField;
    bcdfldAlbEditpdebido: TBCDField;
    bcdfldAlbEditreembolso: TBCDField;
    intgrfldAlbEditEstado: TIntegerField;
    str_AlbEditColor: TStringField;
    str_AlbEditobservaciones: TStringField;
    smlntfldAlbEditkm: TSmallintField;
    dtmfldAlbEditarchivo: TDateTimeField;
    str_AlbEdite_s_r: TStringField;
    smlntfldAlbEditcodruta: TSmallintField;
    intgrfldAlbEditcodrepartidor: TIntegerField;
    intgrfldAlbEditorg_codcli: TIntegerField;
    intgrfldAlbEditorg_coddel: TIntegerField;
    intgrfldAlbEditdst_codcli: TIntegerField;
    intgrfldAlbEditdst_coddel: TIntegerField;
    bcdfldAlbEditKgsVol: TBCDField;
    q_peds_lines: TpFIBDataSet;
    dsbusqueda: TDataSource;
    busqueda: TpFIBDataSet;
    cds_bultos: TClientDataSet;
    intgrfld_bultoscodcli: TIntegerField;
    intgrfld_bultoscodalbaran: TIntegerField;
    intgrfld_bultosunidades: TIntegerField;
    dtmfld_bultosfecha: TDateTimeField;
    intgrfld_bultoscodruta: TIntegerField;
    strngfld_bultoscoddst: TStringField;
    strngfld_bultosdst_nombre: TStringField;
    strngfld_bultosdst_calle: TStringField;
    strngfld_bultosdst_cp: TStringField;
    strngfld_bultosdst_localidad: TStringField;
    strngfld_bultosdst_provincia: TStringField;
    intgrfld_bultosbultos: TIntegerField;
    strngfld_bultosobservaciones: TStringField;
    strngfld_bultosdst_tfno: TStringField;
    strngfld_bultosdst_coddel: TStringField;
    strngfld_bultosdst_persona: TStringField;
    intgrfld_bultosordenbulto: TIntegerField;
    intgrfld_bultoscodrepartidor: TIntegerField;
    strngfld_bultosorg_nombre: TStringField;
    strngfld_bultosorg_calle: TStringField;
    strngfld_bultosorg_cp: TStringField;
    strngfld_bultosorg_localidad: TStringField;
    strngfld_bultosorg_tfno: TStringField;
    strngfld_bultosreembolso: TStringField;
    strngfld_bultosreferencia: TStringField;
    strngfld_bultoskgs: TStringField;
    strngfld_bultossempor: TStringField;
    strngfld_bultoschrono_exp: TStringField;
    strngfld_bultoschrono_ref: TStringField;
    strngfld_bultoscodbulto: TStringField;
    strngfld_bultospdf417: TStringField;
    grphcfld_bultoslogo: TGraphicField;
    intgrfld_bultosid_caja: TIntegerField;
    strngfld_bultostipo_caja: TStringField;
    strngfld_bultoscodexpedicion: TStringField;
    cds_bultosorg_provincia: TStringField;
    q_sql2: TADOQuery;
    strngfld_bultosasm_correo: TStringField;
    strngfld_bultosasm_horario: TStringField;
    strngfld_bultosasm_codcli: TStringField;
    strngfld_bultosasm_mnemo: TStringField;
    strngfld_bultosasm_pobla: TStringField;
    strngfld_bultosasm_tracking: TStringField;
    strngfld_bultosasm_bc: TStringField;
    strngfld_bultosasm_bc_human: TStringField;
    q_detail: TpFIBDataSet;
    q_2: TpFIBDataSet;
    ds_devs: TDataSource;
    q_devs: TpFIBDataSet;
    q_cons: TpFIBDataSet;
    fbntgrfld_devsID_PEDIDO_DEVO: TFIBIntegerField;
    fbntgrfld_devsID_PEDIDO: TFIBIntegerField;
    fbntgrfld_devsID_PEDIDO_LINE: TFIBIntegerField;
    fbntgrfld_devsID_PEDIDO_NUEVO: TFIBIntegerField;
    fbdtmfld_devsFECHA_DEVO: TFIBDateTimeField;
    fbstrngfld_devsTIPO: TFIBStringField;
    fbstrngfld_devsESTADO_DEVO: TFIBStringField;
    fbntgrfld_devsID_ARTICULO_OUT: TFIBIntegerField;
    fbstrngfld_devsTIPO_IMPORT: TFIBStringField;
    fbstrngfld_devsERROR_IMPORT: TFIBStringField;
    fbstrngfld_devsFILE_NAME: TFIBStringField;
    fbntgrfld_devsFILE_LINE: TFIBIntegerField;
    fbdtmfld_devsMODIF_FECHA: TFIBDateTimeField;
    fbstrngfld_devsOBSERVACIONES: TFIBStringField;
    fbstrngfld_devsLINEA_DATOS: TFIBStringField;
    fbdtmfld_devsFILE_DATE_IMP: TFIBDateTimeField;
    fbdtmfld_devsFILE_DATE_GEN: TFIBDateTimeField;
    fbstrngfld_devsORDER_NAME: TFIBStringField;
    fbntgrfld_devsID_CLIENTE: TFIBIntegerField;
    fbntgrfld_devsID_ARTICULO: TFIBIntegerField;
    fbstrngfld_devsCONTROL: TFIBStringField;
    fbstrngfld_devsMOTIVO_KO: TFIBStringField;
    fbmfld_devsFOTO: TFIBMemoField;
    fbstrngfld_devsART_IN: TFIBStringField;
    fbstrngfld_devsART_OUT: TFIBStringField;
    q_3: TpFIBDataSet;
    q_4: TpFIBQuery;
    q_picks_lotes: TpFIBDataSet;
    ds_peds_lines: TDataSource;
    fbntgrfld_picks_lotesCANTIDAD: TFIBIntegerField;
    fbntgrfld_picks_lotesID_LOTE: TFIBIntegerField;
    q_peds_lines_lotes: TpFIBDataSet;
    ds_peds_lines_lotes: TDataSource;
    fbntgrfld_peds_lines_lotesID_PEDIDO: TFIBIntegerField;
    fbntgrfld_peds_lines_lotesID_LOTE: TFIBIntegerField;
    fbntgrfld_peds_lines_lotesCANTIDAD: TFIBIntegerField;
    fbntgrfld_peds_lines_lotesID_LOTE1: TFIBIntegerField;
    fbstrngfld_peds_lines_lotesNOMBRE: TFIBStringField;
    fbdtfld_peds_lines_lotesCADUCIDAD: TFIBDateField;
    fbstrngfld_peds_lines_lotesESTADO: TFIBStringField;
    fbntgrfld_picks_lotesID_PICKCAB: TFIBIntegerField;
    fbntgrfld_picks_lotesLINEA: TFIBIntegerField;
    fbntgrfld_peds_lines_lotesID_ARTICULO: TFIBIntegerField;
    fbntgrfld_peds_lines_lotesID_PICKING: TFIBIntegerField;
    fbntgrfld_peds_lines_lotesLINEA_PICK: TFIBIntegerField;
    con1: TADOConnection;
    ds_3: TpFIBDataSet;
    ds_4: TpFIBDataSet;
    q2: TpFIBQuery;
    q_fib: TpFIBDataSet;
    qu_1: TpFIBQuery;
    blnfldAlbEditfact_retorno: TBooleanField;
    q_aux: TpFIBDataSet;
    db_gestoras: TpFIBDatabase;
    t_read_gestoras: TpFIBTransaction;
    t_write_gestoras: TpFIBTransaction;
    client: TRESTClient;
    response: TRESTResponse;
    request: TRESTRequest;
    qrytemp: TpFIBDataSet;
    stpGrabaAlb: TpFIBQuery;
    xEtiquetas: TpFIBDataSet;
    xEtiquetasUSUARIO: TFIBIntegerField;
    xEtiquetasID_ALBARAN: TFIBIntegerField;
    auth: THTTPBasicAuthenticator;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    xBultos: TpFIBDataSet;
    xAlbaran: TpFIBDataSet;
    xAlbaranBULTOS: TFIBSmallIntField;
    xAlbaranPESO: TFIBFloatField;
    xBultosBULTOS: TFIBIntegerField;
    qTempGest: TpFIBDataSet;
    q_peds_linesID_PEDIDO: TFIBIntegerField;
    q_peds_linesID_LINE: TFIBIntegerField;
    q_peds_linesID_ARTICULO: TFIBIntegerField;
    q_peds_linesCANTIDAD: TFIBIntegerField;
    q_peds_linesSKU: TFIBStringField;
    q_peds_linesNOMBRE_ART: TFIBStringField;
    q_peds_linesITEM_ID: TFIBIntegerField;
    q_peds_linesKGS: TFIBFloatField;
    q_peds_linesID_LOTE: TFIBIntegerField;
    q_peds_linesID_IMEI: TFIBIntegerField;
    q_peds_linesID_DEPARTAMENTO: TFIBIntegerField;
    q_peds_linesCODIGO: TFIBStringField;
    q_peds_linesNOMBRE: TFIBStringField;
    q_peds_linesCODIGO_CLI: TFIBStringField;
    xPedidoLines: TpFIBDataSet;
    xPedidoLinesID_ARTICULO: TFIBIntegerField;
    xPedidoLinesCANTIDAD: TFIBIntegerField;
    xPedidoLinesKGS: TFIBFloatField;
    xPedidoLinesNOMBRE_ART: TFIBStringField;
    xPedidoLinesIMEI: TFIBWideStringField;
    dsArtsRelacionados: TDataSource;
    q_arts_relacionados: TpFIBDataSet;
    ds_arts_rel: TDataSource;
    q_arts_relacionadosID_ARTICULO: TFIBIntegerField;
    q_arts_relacionadosID_ART_RELACIONADO: TFIBIntegerField;
    q_arts_relacionadosFECHA_CREACION: TFIBDateTimeField;
    q_arts_relacionadosESTADO: TFIBStringField;
    q_arts_relacionadosFECHA_BAJA: TFIBDateTimeField;
    q_arts_relacionadosNOM_ART_REL: TStringField;
    q_arts_relacionadosCOD_ART_RELACIONADO: TStringField;
    q_pedsID_PEDIDO: TFIBIntegerField;
    q_pedsID_CLIENTE: TFIBIntegerField;
    q_pedsID_ORDER: TFIBStringField;
    q_pedsORDER_NAME: TFIBStringField;
    q_pedsNOMBRE: TFIBStringField;
    q_pedsDIR_1: TFIBStringField;
    q_pedsPOBLACION: TFIBStringField;
    q_pedsPROVINCIA: TFIBStringField;
    q_pedsCP: TFIBStringField;
    q_pedsPAIS: TFIBStringField;
    q_pedsPAIS_CODE: TFIBStringField;
    q_pedsDELEGACION_DST: TFIBIntegerField;
    q_pedsFECHA_PED: TFIBDateTimeField;
    q_pedsTELEFONO: TFIBStringField;
    q_pedsEMAIL: TFIBStringField;
    q_pedsDELIVERY_TIME: TFIBIntegerField;
    q_pedsDELIV_TIME_TXT: TFIBStringField;
    q_pedsTEXT: TFIBStringField;
    q_pedsFECHA_IMP: TFIBDateTimeField;
    q_pedsFECHA_GEN: TFIBDateTimeField;
    q_pedsFECHA_FIN: TFIBDateTimeField;
    q_pedsESTADO: TFIBStringField;
    q_pedsCODALBARAN: TFIBIntegerField;
    q_pedsOBSERVACIONES: TFIBStringField;
    q_pedsTRANSPORTE: TFIBIntegerField;
    q_pedsID_REPARTIDOR: TFIBIntegerField;
    q_pedsENVIADO: TFIBStringField;
    q_pedsTRACKING_NUMBER: TFIBStringField;
    q_pedsBULTOS: TFIBIntegerField;
    q_pedsPDF: TFIBStringField;
    q_pedsFINANCIAL_STATUS: TFIBStringField;
    q_pedsFULFILLMENT_STATUS: TFIBStringField;
    q_pedsGATEWAY: TFIBStringField;
    q_pedsCOMPANY: TFIBStringField;
    q_pedsTAGS: TFIBStringField;
    q_pedsCANCELLED_AT: TFIBDateTimeField;
    q_pedsCANCEL_REASON: TFIBStringField;
    q_pedsDATE_UPDT: TFIBDateTimeField;
    q_pedsES_DEVO: TFIBSmallIntField;
    q_pedsID_ORDER_2: TFIBStringField;
    q_pedsNOTE: TFIBStringField;
    q_pedsREEMBOLSO: TFIBFloatField;
    q_pedsALBARAN_R: TFIBIntegerField;
    q_pedsPESO: TFIBFloatField;
    q_pedsSERVICE_REF: TFIBIntegerField;
    q_pedsSYNC_WEB: TFIBSmallIntField;
    q_pedsCON_RETORNO: TFIBSmallIntField;
    q_pedsCECO: TFIBStringField;
    q_pedsREF_CLIENTE: TFIBStringField;
    q_pedsACTIVO: TFIBIntegerField;
    q_pedsCONTACTO: TFIBStringField;
    q_pedsTIPO_SERVICIO: TFIBIntegerField;
    q_pedsHORARIO: TFIBIntegerField;
    q_pedsGEST_NUEVO: TFIBSmallIntField;
    q_pedsORIGEN_WEB: TFIBIntegerField;
    q_pedsGESTORAS_DEST: TFIBIntegerField;
    q_peds_linesIMEI: TFIBStringField;
    q_pedsAGENCIA: TStringField;
    q_pedsPICKING: TFIBIntegerField;
    q_pedsPACK_AB: TFIBIntegerField;
    xSigBulto: TpFIBDataSet;
    FIBIntegerField1: TFIBIntegerField;
    q_consCONEXION: TFIBSmallIntField;
    q_consNOMBRE: TFIBStringField;
    q_consBASEDATOS: TFIBStringField;
    q_consACTIVA: TFIBSmallIntField;
    procedure DataModuleCreate(Sender: TObject);
    procedure dbBeforeConnect(Database: TFIBDatabase; LoginParams: TStrings;
      var DoConnect: Boolean);
    procedure dbAfterConnect(Sender: TObject);
    procedure q_arts_relacionadosCalcFields(DataSet: TDataSet);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;
  firstConnect:Boolean=True;

implementation

uses   u_main, u_gen_gl, u_globals;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
begin

  firstconnect:=false;
end;


procedure Tdm.dbAfterConnect(Sender: TObject);
begin
  t_read.StartTransaction;
end;

procedure Tdm.dbBeforeConnect(Database: TFIBDatabase; LoginParams: TStrings;
  var DoConnect: Boolean);
begin
  if (firstconnect) then begin
    doconnect:=false;
    firstconnect:=false;
  end;
end;


procedure Tdm.q_arts_relacionadosCalcFields(DataSet: TDataSet);
begin
    with tpfibdataset.Create(dm) do begin
    database:=db;
    close;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select codigo, nombre from g_articulos where id_articulo=:id_articulo');
    ParamByName('id_articulo').asinteger:=dataset.FieldByName('id_art_relacionado').AsInteger;
    Open;

    if not(IsEmpty) then
    begin
      dataset.FieldByName('nom_art_rel').asstring:=FieldByName('nombre').asstring;
      dataset.FieldByName('cod_art_rel').asstring:=FieldByName('codigo').asstring;
    end
    else
    begin
      dataset.FieldByName('nom_art_rel').asstring:='NOT FOUND';
      dataset.FieldByName('cod_art_rel').asstring:='NOT FOUND';
    end;

    Free;
  end;
end;



end.
