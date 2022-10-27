unit u_dm;

interface

uses
  System.Classes, Data.DB, FIBDataSet, pFIBDataSet,
  pFIBDatabase ,pFIBQuery, FIBQuery, FIBDatabase, Data.Win.ADODB,
  Datasnap.DBClient, IPPeerClient, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, REST.Authenticator.Basic, Vcl.Dialogs, pFIBStoredProc, System.StrUtils,
  Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc, ScSFTPClient, ScSSHClient, ScBridge,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdFTP, System.SysUtils;

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
    q_devs_count: TpFIBDataSet;
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
    xSigBulto: TpFIBDataSet;
    xSigBultoMAX_BULTO: TFIBSmallIntField;
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
    q_pendientes: TpFIBDataSet;
    q_packs_lotes: TpFIBDataSet;
    FIBIntegerField1: TFIBIntegerField;
    FIBIntegerField2: TFIBIntegerField;
    FIBIntegerField3: TFIBIntegerField;
    FIBIntegerField4: TFIBIntegerField;
    q_aux: TpFIBDataSet;
    DataSource1: TDataSource;
    genera_pick_abierto: TpFIBQuery;
    tmpGest: TpFIBQuery;
    dsPedirEtiqueta: TpFIBDataSet;
    lgsPedirEtiquetaOK: TFIBSmallIntField;
    q_ped: TpFIBDataSet;
    lgs1: TFIBIntegerField;
    lgs2: TFIBIntegerField;
    FIBStringField1: TFIBStringField;
    FIBStringField2: TFIBStringField;
    FIBStringField3: TFIBStringField;
    FIBStringField4: TFIBStringField;
    FIBStringField5: TFIBStringField;
    FIBStringField6: TFIBStringField;
    FIBStringField7: TFIBStringField;
    FIBStringField8: TFIBStringField;
    FIBStringField9: TFIBStringField;
    lgs3: TFIBIntegerField;
    lgs4: TFIBDateTimeField;
    FIBStringField10: TFIBStringField;
    FIBStringField11: TFIBStringField;
    lgs5: TFIBIntegerField;
    FIBStringField12: TFIBStringField;
    FIBStringField13: TFIBStringField;
    lgs6: TFIBDateTimeField;
    lgs7: TFIBDateTimeField;
    lgs8: TFIBDateTimeField;
    FIBStringField14: TFIBStringField;
    lgs9: TFIBIntegerField;
    FIBStringField15: TFIBStringField;
    lgs10: TFIBIntegerField;
    lgs11: TFIBIntegerField;
    FIBStringField16: TFIBStringField;
    FIBStringField17: TFIBStringField;
    lgs12: TFIBIntegerField;
    FIBStringField18: TFIBStringField;
    FIBStringField19: TFIBStringField;
    FIBStringField20: TFIBStringField;
    FIBStringField21: TFIBStringField;
    FIBStringField22: TFIBStringField;
    FIBStringField23: TFIBStringField;
    lgs13: TFIBDateTimeField;
    FIBStringField24: TFIBStringField;
    lgs14: TFIBDateTimeField;
    lgs15: TFIBSmallIntField;
    FIBStringField25: TFIBStringField;
    FIBStringField26: TFIBStringField;
    lgs16: TFIBFloatField;
    lgs17: TFIBIntegerField;
    lgs18: TFIBFloatField;
    lgs19: TFIBIntegerField;
    lgs20: TFIBSmallIntField;
    lgs21: TFIBSmallIntField;
    FIBStringField27: TFIBStringField;
    FIBStringField28: TFIBStringField;
    lgs22: TFIBIntegerField;
    FIBStringField29: TFIBStringField;
    lgs23: TFIBIntegerField;
    lgs24: TFIBIntegerField;
    lgs25: TFIBSmallIntField;
    lgs26: TFIBIntegerField;
    lgs27: TFIBIntegerField;
    strngfld1: TStringField;
    lgs28: TFIBIntegerField;
    lgs29: TFIBIntegerField;
    q_pedPLUGIN_CODE: TFIBStringField;
    lgs_pedID_ALMACEN: TFIBIntegerField;
    spGetEmail: TpFIBStoredProc;
    qUnPedido: TpFIBDataSet;
    lgs30: TFIBIntegerField;
    lgs31: TFIBIntegerField;
    FIBStringField30: TFIBStringField;
    FIBStringField31: TFIBStringField;
    FIBStringField32: TFIBStringField;
    FIBStringField33: TFIBStringField;
    FIBStringField34: TFIBStringField;
    FIBStringField35: TFIBStringField;
    FIBStringField36: TFIBStringField;
    FIBStringField37: TFIBStringField;
    FIBStringField38: TFIBStringField;
    lgs32: TFIBIntegerField;
    lgs33: TFIBDateTimeField;
    FIBStringField39: TFIBStringField;
    FIBStringField40: TFIBStringField;
    lgs34: TFIBIntegerField;
    FIBStringField41: TFIBStringField;
    FIBStringField42: TFIBStringField;
    lgs35: TFIBDateTimeField;
    lgs36: TFIBDateTimeField;
    lgs37: TFIBDateTimeField;
    FIBStringField43: TFIBStringField;
    lgs38: TFIBIntegerField;
    FIBStringField44: TFIBStringField;
    lgs39: TFIBIntegerField;
    lgs40: TFIBIntegerField;
    FIBStringField45: TFIBStringField;
    FIBStringField46: TFIBStringField;
    lgs41: TFIBIntegerField;
    FIBStringField47: TFIBStringField;
    FIBStringField48: TFIBStringField;
    FIBStringField49: TFIBStringField;
    FIBStringField50: TFIBStringField;
    FIBStringField51: TFIBStringField;
    FIBStringField52: TFIBStringField;
    lgs42: TFIBDateTimeField;
    FIBStringField53: TFIBStringField;
    lgs43: TFIBDateTimeField;
    lgs44: TFIBSmallIntField;
    FIBStringField54: TFIBStringField;
    FIBStringField55: TFIBStringField;
    lgs45: TFIBFloatField;
    lgs46: TFIBIntegerField;
    lgs47: TFIBFloatField;
    lgs48: TFIBIntegerField;
    lgs49: TFIBSmallIntField;
    lgs50: TFIBSmallIntField;
    FIBStringField56: TFIBStringField;
    FIBStringField57: TFIBStringField;
    lgs51: TFIBIntegerField;
    FIBStringField58: TFIBStringField;
    lgs52: TFIBIntegerField;
    lgs53: TFIBIntegerField;
    lgs54: TFIBSmallIntField;
    lgs55: TFIBIntegerField;
    lgs56: TFIBIntegerField;
    strngfld2: TStringField;
    lgs57: TFIBIntegerField;
    lgs58: TFIBIntegerField;
    qUnPedidoPROV_CODE: TFIBStringField;
    qUnPedidoPLUGIN_CODE: TFIBStringField;
    lgsUnPedidoID_ALMACEN: TFIBIntegerField;
    lgsUnPedidoENVIADO_FICH: TFIBSmallIntField;
    lgsUnPedidoIMPORTE_ASEGURADO: TFIBFloatField;
    q_pedsPROV_CODE: TFIBStringField;
    q_pedsPLUGIN_CODE: TFIBStringField;
    lgs_pedsID_ALMACEN: TFIBIntegerField;
    lgs_pedsENVIADO_FICH: TFIBSmallIntField;
    lgs_pedsIMPORTE_ASEGURADO: TFIBFloatField;
    xml_1: TXMLDocument;
    ftp_1: TIdFTP;
    qAgencias: TpFIBDataSet;
    qExtras: TpFIBDataSet;
    qExtrasDESCRIPCION: TFIBStringField;
    qExtrasVALOR: TFIBStringField;
    dsExtras: TDataSource;
    q_peds_lines_count: TpFIBDataSet;
    cl: TScSSHClient;
    st: TScFileStorage;
    f: TScSFTPClient;
    q_peds_lines_extras: TpFIBDataSet;
    lgs_peds_lines_extrasID_PEDIDO: TFIBIntegerField;
    lgs_peds_lines_extrasLINE: TFIBIntegerField;
    q_peds_lines_extrasEXTRA: TFIBStringField;
    q_peds_lines_extrasVALOR: TFIBStringField;
    ds_peds_lines_extras: TDataSource;
    q_peds_linesN_SERIE: TFIBStringField;
    q_usuario: TpFIBDataSet;
    q_pick_lotes: TpFIBDataSet;
    q_peds_linesLOTE: TFIBStringField;
    qStockLotes: TpFIBDataSet;
    dsStockLotes: TDataSource;
    qStockLotesUBICACION: TFIBStringField;
    lgsStockLotesCANTIDAD: TFIBIntegerField;
    lgsStockLotesID_LOTE: TFIBIntegerField;
    qStockLotesLOTE: TFIBStringField;
    qStockLotesCADUCIDAD: TFIBDateField;
    q_peds_linesCADUCIDAD: TFIBDateField;
    q_lines_nserie: TpFIBDataSet;
    q_lines_nserieN_SERIE: TFIBStringField;
    ds_lines_nserie: TDataSource;
    qStockSinPedidos: TpFIBDataSet;
    qStockSinPedidosSTOCK: TFIBBCDField;
    q_ped_extra: TpFIBDataSet;
    lgs_pedsDATE_MAIL_DEST: TFIBDateTimeField;
    smlntfld_pedsINCIDENCIA: TSmallintField;
    procedure DataModuleCreate(Sender: TObject);
    procedure dbBeforeConnect(Database: TFIBDatabase; LoginParams: TStrings;
      var DoConnect: Boolean);
    procedure q_pedsAfterScroll(DataSet: TDataSet);
    procedure dbAfterConnect(Sender: TObject);
    procedure q_arts_relacionadosCalcFields(DataSet: TDataSet);
    procedure q_pedsCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    function tiene_etiquetas(pedido: integer): Boolean;
  public
    { Public declarations }
    procedure cargar_lineas_pedido;
    function GetExtraPedido(id_pedido:integer; extra:string):integer;
  end;

var
  dm: Tdm;
  firstConnect:Boolean=True;

implementation

uses   u_main, u_gen_gl, u_globals, u_globals_gestoras;

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

procedure Tdm.q_pedsAfterScroll(DataSet: TDataSet);
begin
    // SI SE MODIFICA, MODIFICAR TAMBIEN EN btCorreosClick DEL MAIN
    f_main.btCorreos.Enabled := ( (q_peds.FieldByName('estado').asstring = 'G') and
                                  (q_peds.FieldByName('id_repartidor').AsInteger = u_main.agencia_correos) and

                                  (not tiene_etiquetas(q_peds.FieldByName('id_pedido').AsInteger)) {and    //No se han sacado las etiquetas anteriormente

                                  (
                                    //22/12/2017 Vegaffinity sale por Correos
                                    //((q_peds.FieldByName('tags').asstring<>'AMAZON') and (q_peds.FieldByName('tags').asstring<>'RETAIL') and (q_peds.FieldByName('tags').asstring<>'VEGAFFINITY')) //EXTRA
                                    //02/01/2018 Vegaffinity vuelve a salir por SEUR
                                    //((q_peds.FieldByName('tags').asstring<>'AMAZON') and (q_peds.FieldByName('tags').asstring<>'RETAIL')) //EXTRA
                                    ((q_peds.FieldByName('id_cliente').AsInteger = 7252) and (q_peds.FieldByName('tags').asstring<>'AMAZON') and (q_peds.FieldByName('tags').asstring<>'RETAIL') and (q_peds.FieldByName('tags').asstring<>'VEGAFFINITY')) //EXTRA
                                    or
                                    ((q_peds.FieldByName('id_cliente').AsInteger = 7252) and (q_peds.FieldByName('tags').asstring='RETAIL') and (q_peds.FieldByName('pais_code').asstring='ES'))  //RETAIL nacionales
                                    or
                                     (q_peds.FieldByName('id_cliente').AsInteger <> 7252)
                                  )  }
                                )  ;

    dsPedirEtiqueta.Close;
    dsPedirEtiqueta.ParamByName('id_pedido').AsInteger := q_peds.FieldByName('id_pedido').AsInteger;
    dsPedirEtiqueta.Open;
    f_main.btSeur.Enabled := (dsPedirEtiqueta.FieldByName('ok').AsInteger=2);

    if f_main.rgTipoGes.ItemIndex=1 then
    begin
       f_main.lb_cli.Caption := u_gen_gl.BuscaCliente(q_peds.FieldByName('id_cliente').AsString);
    end;

    f_main.pm1.Items.Items[0].Enabled := (dm.q_peds.FieldByName('id_repartidor').AsInteger=8);
   { f_main.pm1.Items.Items[1].Enabled := ((dm.q_peds.FieldByName('id_cliente').AsInteger=7252) and
                                          (dm.q_peds.FieldByName('pais_code').AsString='US') and
                                          (IndexStr(dm.q_peds.FieldByName('estado').AsString,['G'])>=0));}
    f_main.pm1.Items.Items[1].Enabled := False;

   // cargar_lineas_pedido;

   //dm.q_peds_lines_count.Close;
   //dm.q_peds_lines_count.Open;

  // f_main.lb_n_detalle.Caption := dm.q_peds_lines_count.FieldByName('tot').Asstring + ' lineas detalle';
  // f_main.lb_n.Caption := IntToStr(f_main.gr_envs.SelectedRows.Count) + ' / ' + q_peds_count.FieldByName('tot').asstring + ' pedido/s';
end;

procedure Tdm.q_pedsCalcFields(DataSet: TDataSet);
begin
   DataSet.FieldByName('agencia').AsString := GetNombreAgencia(DataSet.FieldByName('ID_REPARTIDOR').AsInteger);
   if u_main.revisa_lotes then
      DataSet.FieldByName('incidencia').AsInteger := GetExtraPedido(DataSet.FieldByName('ID_pedido').AsInteger,'LOG_LOTE');
end;

function Tdm.tiene_etiquetas(pedido: integer): Boolean;
begin
  Result := False;

  with TpFIBDataSet.Create(self) do
  try
    Database := dm.db;
    SQLs.SelectSQL.Clear;
    sqls.SelectSQL.Add('select * from c_pedidos_etiquetas where id_pedido=:pedido and estado=''A'' ');
    ParamByName('pedido').AsInteger := pedido;
    Open;

    Result := (RecordCount > 0);
  finally
    free;
  end;
end;

procedure Tdm.cargar_lineas_pedido;
begin
  if not modo_historico then
  begin
      with q_peds_lines do
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

      with q_peds_lines_count do
      begin
         close;
         SelectSQL.Clear;
         SelectSQL.Add('select count(*) as tot ' +
                       'from c_pedidos_lines l ' +
                       'where l.id_pedido=:id_pedido');
         Open;
      end;
  end else begin
              with q_peds_lines do
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

function Tdm.GetExtraPedido(id_pedido:integer; extra:string):integer;
begin

  result := 1;
  with dm.q_ped_extra do
  try
    close;
    sqls.SelectSQL.Clear;
    sqls.selectsql.Add('select count(*) as cuenta from c_pedidos_extras where id_pedido=:id_pedido and upper(descripcion)=upper(:extra)');
    ParamByName('id_pedido').AsInteger := id_pedido;
    ParamByName('extra').AsString := extra;
    open;

    if not(isempty) then begin
      result := fieldbyname('cuenta').asinteger;
    end;

  finally

  end;
end;
end.
