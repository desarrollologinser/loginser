unit u_dm;

interface

uses
  System.Classes, Data.DB,  Data.Win.ADODB,
  Datasnap.DBClient, IPPeerClient, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, REST.Authenticator.Basic, Vcl.Dialogs, FIBDataSet,
  FIBQuery, pFIBQuery, pFIBDataSet, FIBDatabase, pFIBDatabase, pFIBStoredProc;

type
  Tdm = class(TDataModule)
    db: TpFIBDatabase;
    t_read: TpFIBTransaction;
    t_write: TpFIBTransaction;
    cds_bultos: TClientDataSet;
    cds_bultoscodcli: TIntegerField;
    cds_bultoscodalbaran: TIntegerField;
    cds_bultosunidades: TIntegerField;
    dtmfld_bultosfecha: TDateTimeField;
    cds_bultoscodruta: TIntegerField;
    strngfld_bultoscoddst: TStringField;
    strngfld_bultosdst_nombre: TStringField;
    strngfld_bultosdst_calle: TStringField;
    strngfld_bultosdst_cp: TStringField;
    strngfld_bultosdst_localidad: TStringField;
    strngfld_bultosdst_provincia: TStringField;
    cds_bultosbultos: TIntegerField;
    strngfld_bultosobservaciones: TStringField;
    strngfld_bultosdst_tfno: TStringField;
    strngfld_bultosdst_coddel: TStringField;
    strngfld_bultosdst_persona: TStringField;
    cds_bultosordenbulto: TIntegerField;
    cds_bultoscodrepartidor: TIntegerField;
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
    cds_bultosid_caja: TIntegerField;
    strngfld_bultostipo_caja: TStringField;
    strngfld_bultoscodexpedicion: TStringField;
    strngfld_bultosorg_provincia: TStringField;
    strngfld_bultosasm_correo: TStringField;
    strngfld_bultosasm_horario: TStringField;
    strngfld_bultosasm_codcli: TStringField;
    strngfld_bultosasm_mnemo: TStringField;
    strngfld_bultosasm_pobla: TStringField;
    strngfld_bultosasm_tracking: TStringField;
    strngfld_bultosasm_bc: TStringField;
    strngfld_bultosasm_bc_human: TStringField;
    q_albaranes: TpFIBDataSet;
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
    xBultosBULTOS: TFIBIntegerField;
    xAlbaran: TpFIBDataSet;
    xAlbaranBULTOS: TFIBSmallIntField;
    xAlbaranPESO: TFIBFloatField;
    xSigBulto: TpFIBDataSet;
    xSigBultoMAX_BULTO: TFIBSmallIntField;
    qTempGest: TpFIBDataSet;
    xPedidoLines: TpFIBDataSet;
    xPedidoLinesID_ARTICULO: TFIBIntegerField;
    xPedidoLinesCANTIDAD: TFIBIntegerField;
    xPedidoLinesKGS: TFIBFloatField;
    xPedidoLinesNOMBRE_ART: TFIBStringField;
    xPedidoLinesIMEI: TFIBWideStringField;
    dsArtsRelacionados: TDataSource;
    q_packagr: TpFIBDataSet;
    ds_packagr: TDataSource;
    ds_pack: TDataSource;
    q_pack: TpFIBDataSet;
    q_pack_leido: TpFIBDataSet;
    ds_pack_leido: TDataSource;
    pFIBDataSet1: TpFIBDataSet;
    DataSource1: TDataSource;
    q_etiq_indiv: TpFIBDataSet;
    q_hoja_pick: TpFIBDataSet;
    q_fib2: TpFIBDataSet;
    qry_sql3: TpFIBDataSet;
    qry_sql2: TADOQuery;
    con2: TADOConnection;
    q1: TADOQuery;
    q_etiq_bulto: TpFIBDataSet;
    qry_kgs: TpFIBDataSet;
    qDHL: TpFIBDataSet;
    q_DHL_PAISES: TpFIBDataSet;
    qry_tmp: TpFIBDataSet;
    ds_hoja_pick: TDataSource;
    con1: TADOConnection;
    q_fib: TpFIBDataSet;
    qu_1: TpFIBQuery;
    q_1: TpFIBQuery;
    q_reparto: TpFIBDataSet;
    ds_reparto: TDataSource;
    qLineaPackOld: TpFIBDataSet;
    qTempGestUpd: TpFIBQuery;
    q_aux: TpFIBDataSet;
    busqueda: TpFIBDataSet;
    dsbusqueda: TDataSource;
    q_con: TpFIBDataSet;
    q_dame_datos_etiquetas: TpFIBDataSet;
    fbsmlntfld_dame_datos_etiquetasSEDE: TFIBSmallIntField;
    lgs_dame_datos_etiquetasFECHA_ALBARAN: TFIBDateTimeField;
    fbsmlntfld_dame_datos_etiquetasTIPO_ALBARAN: TFIBSmallIntField;
    fbsmlntfld_dame_datos_etiquetasESTADO: TFIBSmallIntField;
    fbsmlntfld_dame_datos_etiquetasAGENCIA: TFIBSmallIntField;
    q_dame_datos_etiquetasEXPEDICION_AGE: TFIBStringField;
    fbsmlntfld_dame_datos_etiquetasORIGEN_WEB: TFIBSmallIntField;
    fbsmlntfld_dame_datos_etiquetasEMPRESA: TFIBSmallIntField;
    lgs_dame_datos_etiquetasCLIENTE: TFIBIntegerField;
    lgs_dame_datos_etiquetasID_CLIENTE: TFIBIntegerField;
    q_dame_datos_etiquetasALBARAN_CLIENTE: TFIBStringField;
    fbsmlntfld_dame_datos_etiquetasTIPO_SERVICIO: TFIBSmallIntField;
    fbsmlntfld_dame_datos_etiquetasHORARIO: TFIBSmallIntField;
    q_dame_datos_etiquetasARCHIVO_RESGUARDO: TFIBStringField;
    lgs_dame_datos_etiquetasPAQUETES: TFIBFloatField;
    lgs_dame_datos_etiquetasBULTOS: TFIBIntegerField;
    lgs_dame_datos_etiquetasPESO: TFIBFloatField;
    lgs_dame_datos_etiquetasKGS_VOL: TFIBFloatField;
    lgs_dame_datos_etiquetasZONA: TFIBIntegerField;
    fbsmlntfld_dame_datos_etiquetasREPARTIDOR: TFIBSmallIntField;
    fbsmlntfld_dame_datos_etiquetasPORTES_DEBIDOS: TFIBSmallIntField;
    lgs_dame_datos_etiquetasIMPORTE_PORTES: TFIBFloatField;
    fbsmlntfld_dame_datos_etiquetasREEMBOLSO: TFIBSmallIntField;
    lgs_dame_datos_etiquetasIMPORTE_REEMBOLSO: TFIBFloatField;
    fbsmlntfld_dame_datos_etiquetasASEGURADO: TFIBSmallIntField;
    lgs_dame_datos_etiquetasIMPORTE_ASEGURADO: TFIBFloatField;
    fbsmlntfld_dame_datos_etiquetasRETORNO: TFIBSmallIntField;
    q_dame_datos_etiquetasOBSERVACIONES: TFIBMemoField;
    q_dame_datos_etiquetasNOTAS_INTERNAS: TFIBMemoField;
    q_dame_datos_etiquetasORIG_NOMBRE: TFIBStringField;
    q_dame_datos_etiquetasORIG_CALLE: TFIBStringField;
    lgs_dame_datos_etiquetasORIG_ID_LOCAL: TFIBIntegerField;
    q_dame_datos_etiquetasORIG_COD_POSTAL: TFIBStringField;
    q_dame_datos_etiquetasORIG_LOCALIDAD: TFIBStringField;
    q_dame_datos_etiquetasORIG_PROVINCIA: TFIBStringField;
    q_dame_datos_etiquetasORIG_PAIS: TFIBStringField;
    q_dame_datos_etiquetasORIG_TELEFONO: TFIBStringField;
    q_dame_datos_etiquetasORIG_TELEFONO2: TFIBStringField;
    q_dame_datos_etiquetasORIG_CONTACTO: TFIBStringField;
    q_dame_datos_etiquetasORIG_NOTAS: TFIBMemoField;
    q_dame_datos_etiquetasORIG_EMAIL: TFIBStringField;
    fbsmlntfld_dame_datos_etiquetasVEHICULO: TFIBSmallIntField;
    fbsmlntfld_dame_datos_etiquetasDNI_NOMBRE: TFIBSmallIntField;
    fbsmlntfld_dame_datos_etiquetasRCS: TFIBSmallIntField;
    fbsmlntfld_dame_datos_etiquetasDIGITALIZADO: TFIBSmallIntField;
    q_dame_datos_etiquetasCAMPO_STR1: TFIBStringField;
    q_dame_datos_etiquetasCAMPO_STR2: TFIBStringField;
    q_dame_datos_etiquetasCAMPO_STR3: TFIBStringField;
    lgs_dame_datos_etiquetasCAMPO_CANT1: TFIBFloatField;
    lgs_dame_datos_etiquetasCAMPO_CANT2: TFIBFloatField;
    lgs_dame_datos_etiquetasCAMPO_CANT3: TFIBFloatField;
    lgs_dame_datos_etiquetasENTRADA: TFIBIntegerField;
    fbsmlntfld_dame_datos_etiquetasVALIJA: TFIBSmallIntField;
    fbsmlntfld_dame_datos_etiquetasRECOGIDA_PROPIA: TFIBSmallIntField;
    fbsmlntfld_dame_datos_etiquetasRECOGIDA_NACIONAL: TFIBSmallIntField;
    fbsmlntfld_dame_datos_etiquetasAUTOMATICO: TFIBSmallIntField;
    fbsmlntfld_dame_datos_etiquetasSEGUIMIENTO: TFIBSmallIntField;
    q_dame_datos_etiquetasALBARAN_AGENCIA: TFIBStringField;
    fbsmlntfld_dame_datos_etiquetasFACTURABLE: TFIBSmallIntField;
    fbsmlntfld_dame_datos_etiquetasCAMPO_CK1: TFIBSmallIntField;
    fbsmlntfld_dame_datos_etiquetasCAMPO_CK2: TFIBSmallIntField;
    fbsmlntfld_dame_datos_etiquetasCAMPO_CK3: TFIBSmallIntField;
    lgs_dame_datos_etiquetasFECHA_SERVICIO: TFIBDateTimeField;
    lgs_dame_datos_etiquetasORIG_H_DESDE: TFIBDateTimeField;
    lgs_dame_datos_etiquetasORIG_H_HASTA: TFIBDateTimeField;
    fbsmlntfld_dame_datos_etiquetasAYUDANTE: TFIBSmallIntField;
    fbsmlntfld_dame_datos_etiquetasDESEMBOLSO: TFIBSmallIntField;
    lgs_dame_datos_etiquetasIMPORTE_DESEMBOLSO: TFIBFloatField;
    fbsmlntfld_dame_datos_etiquetasSEGUNDA_ENTREGA: TFIBSmallIntField;
    fbsmlntfld_dame_datos_etiquetasDUA_IMPORT: TFIBSmallIntField;
    fbsmlntfld_dame_datos_etiquetasDUA_EXPORT: TFIBSmallIntField;
    fbsmlntfld_dame_datos_etiquetasMINUTOS_ESPERA: TFIBSmallIntField;
    q_dame_datos_etiquetasORIG_CODIGO: TFIBStringField;
    lgs_dame_datos_etiquetasORIG_H_DESDE2: TFIBDateTimeField;
    lgs_dame_datos_etiquetasORIG_H_HASTA2: TFIBDateTimeField;
    lgs_dame_datos_etiquetasPESO_EXPEDICION: TFIBFloatField;
    lgs_dame_datos_etiquetasBULTOS_TOTALES: TFIBIntegerField;
    q_dame_datos_etiquetasORIG_COD_PROVINCIA: TFIBStringField;
    q_dame_datos_etiquetasORIG_NIF: TFIBStringField;
    q_dame_datos_etiquetasORIG_DEPARTAMENTO: TFIBStringField;
    fbsmlntfld_dame_datos_etiquetasDAC: TFIBSmallIntField;
    fbsmlntfld_dame_datos_etiquetasPOD: TFIBSmallIntField;
    q_dame_datos_etiquetasREF_CLIENTE: TFIBStringField;
    q_dame_datos_etiquetasREF_CLIENTE_2: TFIBStringField;
    q_dame_datos_etiquetasCONTENIDO: TFIBStringField;
    lgs_dame_datos_etiquetasFECHA_PREVISTA: TFIBDateTimeField;
    lgs_dame_datos_etiquetasSOLICITUD: TFIBIntegerField;
    fbsmlntfld_dame_datos_etiquetasFACT_DEVOLUCION: TFIBSmallIntField;
    fbsmlntfld_dame_datos_etiquetasFACT_RCS: TFIBSmallIntField;
    fbsmlntfld_dame_datos_etiquetasFACT_RETORNO: TFIBSmallIntField;
    fbsmlntfld_dame_datos_etiquetasSEDE_DESTINO: TFIBSmallIntField;
    fbsmlntfld_dame_datos_etiquetasSEDE_ORIGEN: TFIBSmallIntField;
    fbsmlntfld_dame_datos_etiquetasTIENE_INCIDENCIA: TFIBSmallIntField;
    q_dame_datos_etiquetasTITULO_HORARIO: TFIBStringField;
    q_dame_datos_etiquetasCODIGO_CLIENTE_EXP: TFIBStringField;
    lgs_dame_datos_etiquetasID_ALBARAN_DET: TFIBIntegerField;
    fbsmlntfld_dame_datos_etiquetasLINEA: TFIBSmallIntField;
    q_dame_datos_etiquetasDEST_NOMBRE: TFIBStringField;
    q_dame_datos_etiquetasDEST_CALLE: TFIBStringField;
    q_dame_datos_etiquetasDEST_CODPOSTAL: TFIBStringField;
    q_dame_datos_etiquetasDEST_LOCALIDAD: TFIBStringField;
    q_dame_datos_etiquetasDEST_PROVINCIA: TFIBStringField;
    q_dame_datos_etiquetasDEST_PAIS: TFIBStringField;
    q_dame_datos_etiquetasDEST_TELEFONO01: TFIBStringField;
    q_dame_datos_etiquetasDEST_TELEFONO02: TFIBStringField;
    q_dame_datos_etiquetasDEST_EMAIL: TFIBStringField;
    q_dame_datos_etiquetasDEST_CONTACTO: TFIBStringField;
    q_dame_datos_etiquetasDEST_OBSERVACIONES: TFIBMemoField;
    lgs_dame_datos_etiquetasDEST_ID_LOCAL: TFIBIntegerField;
    fbsmlntfld_dame_datos_etiquetasDEST_PRINCIPAL: TFIBSmallIntField;
    lgs_dame_datos_etiquetasDEST_HDESDE: TFIBDateTimeField;
    lgs_dame_datos_etiquetasDEST_HHASTA: TFIBDateTimeField;
    q_dame_datos_etiquetasDEST_CODIGO: TFIBStringField;
    q_dame_datos_etiquetasDEST_CODPROVINCIA: TFIBStringField;
    q_dame_datos_etiquetasDEST_NIF: TFIBStringField;
    q_dame_datos_etiquetasDEST_DEPARTAMENTO: TFIBStringField;
    fbsmlntfld_dame_datos_etiquetasDEST_RECIBIR: TFIBSmallIntField;
    fbsmlntfld_dame_datos_etiquetasBULTO: TFIBSmallIntField;
    lgs_dame_datos_etiquetasID_BULTO: TFIBIntegerField;
    lgs_dame_datos_etiquetasPESO_BULTO: TFIBFloatField;
    lgs_dame_datos_etiquetasX: TFIBFloatField;
    lgs_dame_datos_etiquetasY: TFIBFloatField;
    lgs_dame_datos_etiquetasZ: TFIBFloatField;
    q_dame_datos_etiquetasREFERENCIA: TFIBStringField;
    q_dame_datos_etiquetasCOD_BARRAS: TFIBStringField;
    lgs_dame_datos_etiquetasID_ALB: TFIBIntegerField;
    q_dame_datos_etiquetasTITULO_ZONA: TFIBStringField;
    ds_lgs_dame_datos_etiquetas: TDataSource;
    lgs_albaranesID_ALBARAN: TFIBIntegerField;
    lgs_albaranesSEDE: TFIBSmallIntField;
    lgs_albaranesFECHA_ALBARAN: TFIBDateTimeField;
    lgs_albaranesTIPO_ALBARAN: TFIBSmallIntField;
    lgs_albaranesESTADO: TFIBSmallIntField;
    lgs_albaranesAGENCIA: TFIBSmallIntField;
    q_albaranesEXPEDICION_AGE: TFIBStringField;
    lgs_albaranesORIGEN_WEB: TFIBSmallIntField;
    lgs_albaranesEMPRESA: TFIBSmallIntField;
    lgs_albaranesCLIENTE: TFIBIntegerField;
    lgs_albaranesID_CLIENTE: TFIBIntegerField;
    q_albaranesALBARAN_CLIENTE: TFIBStringField;
    lgs_albaranesTIPO_SERVICIO: TFIBSmallIntField;
    lgs_albaranesHORARIO: TFIBSmallIntField;
    q_albaranesARCHIVO_RESGUARDO: TFIBStringField;
    lgs_albaranesPAQUETES: TFIBFloatField;
    lgs_albaranesBULTOS: TFIBIntegerField;
    lgs_albaranesPESO: TFIBFloatField;
    lgs_albaranesKGS_VOL: TFIBFloatField;
    lgs_albaranesZONA: TFIBIntegerField;
    lgs_albaranesREPARTIDOR: TFIBSmallIntField;
    lgs_albaranesPORTES_DEBIDOS: TFIBSmallIntField;
    lgs_albaranesIMPORTE_PORTES: TFIBFloatField;
    lgs_albaranesREEMBOLSO: TFIBSmallIntField;
    lgs_albaranesIMPORTE_REEMBOLSO: TFIBFloatField;
    lgs_albaranesASEGURADO: TFIBSmallIntField;
    lgs_albaranesIMPORTE_ASEGURADO: TFIBFloatField;
    lgs_albaranesRETORNO: TFIBSmallIntField;
    q_albaranesOBSERVACIONES: TFIBMemoField;
    q_albaranesNOTAS_INTERNAS: TFIBMemoField;
    q_albaranesORIG_NOMBRE: TFIBStringField;
    q_albaranesORIG_CALLE: TFIBStringField;
    lgs_albaranesORIG_ID_LOCAL: TFIBIntegerField;
    q_albaranesORIG_COD_POSTAL: TFIBStringField;
    q_albaranesORIG_LOCALIDAD: TFIBStringField;
    q_albaranesORIG_PROVINCIA: TFIBStringField;
    q_albaranesORIG_PAIS: TFIBStringField;
    q_albaranesORIG_TELEFONO: TFIBStringField;
    q_albaranesORIG_TELEFONO2: TFIBStringField;
    q_albaranesORIG_CONTACTO: TFIBStringField;
    q_albaranesORIG_NOTAS: TFIBMemoField;
    q_albaranesORIG_EMAIL: TFIBStringField;
    lgs_albaranesVEHICULO: TFIBSmallIntField;
    lgs_albaranesDNI_NOMBRE: TFIBSmallIntField;
    lgs_albaranesRCS: TFIBSmallIntField;
    lgs_albaranesDIGITALIZADO: TFIBSmallIntField;
    q_albaranesCAMPO_STR1: TFIBStringField;
    q_albaranesCAMPO_STR2: TFIBStringField;
    q_albaranesCAMPO_STR3: TFIBStringField;
    lgs_albaranesCAMPO_CANT1: TFIBFloatField;
    lgs_albaranesCAMPO_CANT2: TFIBFloatField;
    lgs_albaranesCAMPO_CANT3: TFIBFloatField;
    lgs_albaranesENTRADA: TFIBIntegerField;
    lgs_albaranesVALIJA: TFIBSmallIntField;
    lgs_albaranesRECOGIDA_PROPIA: TFIBSmallIntField;
    lgs_albaranesRECOGIDA_NACIONAL: TFIBSmallIntField;
    lgs_albaranesAUTOMATICO: TFIBSmallIntField;
    lgs_albaranesSEGUIMIENTO: TFIBSmallIntField;
    q_albaranesALBARAN_AGENCIA: TFIBStringField;
    lgs_albaranesFACTURABLE: TFIBSmallIntField;
    lgs_albaranesCAMPO_CK1: TFIBSmallIntField;
    lgs_albaranesCAMPO_CK2: TFIBSmallIntField;
    lgs_albaranesCAMPO_CK3: TFIBSmallIntField;
    lgs_albaranesFECHA_SERVICIO: TFIBDateTimeField;
    lgs_albaranesORIG_H_DESDE: TFIBDateTimeField;
    lgs_albaranesORIG_H_HASTA: TFIBDateTimeField;
    lgs_albaranesAYUDANTE: TFIBSmallIntField;
    lgs_albaranesDESEMBOLSO: TFIBSmallIntField;
    lgs_albaranesIMPORTE_DESEMBOLSO: TFIBFloatField;
    lgs_albaranesSEGUNDA_ENTREGA: TFIBSmallIntField;
    lgs_albaranesDUA_IMPORT: TFIBSmallIntField;
    lgs_albaranesDUA_EXPORT: TFIBSmallIntField;
    lgs_albaranesMINUTOS_ESPERA: TFIBSmallIntField;
    q_albaranesORIG_CODIGO: TFIBStringField;
    lgs_albaranesORIG_H_DESDE2: TFIBDateTimeField;
    lgs_albaranesORIG_H_HASTA2: TFIBDateTimeField;
    lgs_albaranesPESO_EXPEDICION: TFIBFloatField;
    lgs_albaranesBULTOS_TOTALES: TFIBSmallIntField;
    q_albaranesORIG_COD_PROVINCIA: TFIBStringField;
    q_albaranesORIG_NIF: TFIBStringField;
    q_albaranesORIG_DEPARTAMENTO: TFIBStringField;
    lgs_albaranesDAC: TFIBSmallIntField;
    lgs_albaranesPOD: TFIBSmallIntField;
    q_albaranesREF_CLIENTE: TFIBStringField;
    q_albaranesREF_CLIENTE_2: TFIBStringField;
    q_albaranesCONTENIDO: TFIBStringField;
    lgs_albaranesFECHA_PREVISTA: TFIBDateTimeField;
    lgs_albaranesSOLICITUD: TFIBIntegerField;
    lgs_albaranesFACT_DEVOLUCION: TFIBSmallIntField;
    lgs_albaranesFACT_RCS: TFIBSmallIntField;
    lgs_albaranesFACT_RETORNO: TFIBSmallIntField;
    lgs_albaranesSEDE_DESTINO: TFIBSmallIntField;
    lgs_albaranesSEDE_ORIGEN: TFIBSmallIntField;
    lgs_albaranesTIENE_INCIDENCIA: TFIBSmallIntField;
    q_albaranesTIPO_SERVICIO_AGE: TFIBStringField;
    q_albaranesHORARIO_AGE: TFIBStringField;
    lgs_albaranesKGS_VOL_EXPEDICION: TFIBFloatField;
    lgs_albaranesTOTAL_ALBARAN_TARIF: TFIBFloatField;
    lgs_albaranesTOTAL_COBRAR: TFIBFloatField;
    lgs_albaranesFACTURADO: TFIBSmallIntField;
    lgs_albaranesKGS_FACTURADOS: TFIBFloatField;
    lgs_albaranesKMS: TFIBFloatField;
    lgs_albaranesVOLVER_A_FACTURAR: TFIBSmallIntField;
    lgs_albaranesTIENE_PICKING: TFIBSmallIntField;
    lgs_albaranesSOLICITUD_RETORNO: TFIBIntegerField;
    lgs_albaranesTOTAL_COSTE: TFIBFloatField;
    q_albaranesORIG_OBSERVACIONES: TFIBMemoField;
    lgs_albaranesCREATOR_ID: TFIBIntegerField;
    lgs_albaranesENVIADO_AGENCIA: TFIBSmallIntField;
    lgs_albaranesALBARAN_RETORNO: TFIBIntegerField;
    lgs_albaranesVUELVE_A_ZONA: TFIBSmallIntField;
    lgs_albaranesHORAS_AYUD: TFIBFloatField;
    lgs_albaranesREEMBOLSO_LIQUIDADO: TFIBSmallIntField;
    lgs_albaranesFECHA_LIQUID_REEMBOLSO: TFIBDateTimeField;
    lgs_albaranesREEMBOLSO_ABONADO: TFIBSmallIntField;
    lgs_albaranesFECHA_ABONO_REEMBOLSO: TFIBDateTimeField;
    lgs_albaranesDOC_REEMBOLSO: TFIBIntegerField;
    lgs_albaranesID_ALBARAN_DET: TFIBIntegerField;
    lgs_albaranesID_ALBARAN1: TFIBIntegerField;
    lgs_albaranesLINEA: TFIBSmallIntField;
    q_albaranesNOMBRE: TFIBStringField;
    q_albaranesCALLE: TFIBStringField;
    q_albaranesCOD_POSTAL: TFIBStringField;
    q_albaranesLOCALIDAD: TFIBStringField;
    q_albaranesPROVINCIA: TFIBStringField;
    q_albaranesPAIS: TFIBStringField;
    q_albaranesTELEFONO: TFIBStringField;
    q_albaranesTELEFONO2: TFIBStringField;
    q_albaranesEMAIL: TFIBStringField;
    q_albaranesCONTACTO: TFIBStringField;
    q_albaranesOBSERVACIONES1: TFIBMemoField;
    lgs_albaranesENTRADA1: TFIBIntegerField;
    lgs_albaranesID_LOCAL: TFIBIntegerField;
    lgs_albaranesPRINCIPAL: TFIBSmallIntField;
    lgs_albaranesH_DESDE: TFIBDateTimeField;
    lgs_albaranesH_HASTA: TFIBDateTimeField;
    q_albaranesCODIGO: TFIBStringField;
    lgs_albaranesH_DESDE2: TFIBDateTimeField;
    lgs_albaranesH_HASTA2: TFIBDateTimeField;
    q_albaranesCOD_PROVINCIA: TFIBStringField;
    q_albaranesNIF: TFIBStringField;
    q_albaranesDEPARTAMENTO: TFIBStringField;
    lgs_albaranesRECIBIR: TFIBSmallIntField;
    q_dame_datos_etiquetasTIT_AGENCIA: TFIBStringField;
    q_dame_datos_etiquetasTIT_SEDE: TFIBStringField;
    q_etiq_impresa: TpFIBDataSet;
    spGetEmail: TpFIBStoredProc;
    strngfld_dame_datos_etiquetasTIT_SEDE_DESTINO: TStringField;
    strngfld_dame_datos_etiquetasTIT_SEDE_ORIGEN: TStringField;
    cds_dame_datos_etiquetasGRUPO_CL: TIntegerField;
    spGetEmailAlbaran: TpFIBStoredProc;
    q_pick_lotes: TpFIBDataSet;
    lgs_picks_lotesCANTIDAD: TFIBIntegerField;
    lgs_picks_lotesID_LOTE: TFIBIntegerField;
    lgs_picks_lotesID_PICKCAB: TFIBIntegerField;
    lgs_picks_lotesLINEA: TFIBIntegerField;
    q_usuario: TpFIBDataSet;
    q_picks_lotes: TpFIBDataSet;
    lgs_picks_lotesCANTIDAD1: TFIBIntegerField;
    lgs_picks_lotesID_LOTE1: TFIBIntegerField;
    lgs_picks_lotesID_PICKCAB1: TFIBIntegerField;
    lgs_picks_lotesLINEA1: TFIBIntegerField;
    q_ped_extra: TpFIBDataSet;
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

{uses   u_main, u_gen_gl, u_globals, u_globals_gestoras; }

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
