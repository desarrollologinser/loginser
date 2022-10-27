unit u_dm;

interface

uses
  System.SysUtils, System.Classes, Data.DB, FIBDataSet, pFIBDataSet,
  FIBDatabase, pFIBDatabase, FIBQuery, pFIBQuery, Data.Win.ADODB, IPPeerClient,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  REST.Authenticator.Basic, pFIBStoredProc;

type
  Tdm = class(TDataModule)
    db: TpFIBDatabase;
    t_read: TpFIBTransaction;
    t_write: TpFIBTransaction;
    busqueda: TpFIBDataSet;
    dsbusqueda: TDataSource;
    b_1: TpFIBDataSet;
    q_1: TpFIBQuery;
    qReportDetalle: TpFIBDataSet;
    qReportBonificacion: TpFIBDataSet;
    fbntgrfld1: TFIBIntegerField;
    qReportResumen: TpFIBDataSet;
    qfiltro: TpFIBDataSet;
    fbntgrfldUDS: TFIBIntegerField;
    dsfiltro_cert: TDataSource;
    qfile: TpFIBDataSet;
    qfiltro_certif: TpFIBDataSet;
    qRepCert: TpFIBDataSet;
    fbntgrfldID_CORREOS_CERTIFICADAS: TFIBIntegerField;
    fbntgrfldID_CLIENTE: TFIBIntegerField;
    fbntgrfldID_CECO: TFIBIntegerField;
    fbntgrfldID_PRODUCTO: TFIBIntegerField;
    fbdtfldFECHA: TFIBDateField;
    fbstrngfldVERSION: TFIBStringField;
    fbstrngfldPRODUCTO_PAQ: TFIBStringField;
    fbntgrfldBULTOS: TFIBIntegerField;
    fbstrngfldEMPRESA: TFIBStringField;
    fbstrngfldDIRECCION: TFIBStringField;
    fbstrngfldLOCALIDAD: TFIBStringField;
    fbstrngfldPROVINCIA: TFIBStringField;
    fbstrngfldCP: TFIBStringField;
    fbstrngfldPAIS: TFIBStringField;
    fbstrngfldMODALIDAD: TFIBStringField;
    fbstrngfldREFERENCIA: TFIBStringField;
    fbfltfldPESO: TFIBFloatField;
    fbfltfldALTO: TFIBFloatField;
    fbfltfldANCHO: TFIBFloatField;
    fbfltfldLARGO: TFIBFloatField;
    fbntgrfldINTENTOS: TFIBIntegerField;
    fbntgrfldEN_LISTA: TFIBIntegerField;
    fbstrngfldPTO_ADMISION: TFIBStringField;
    fbdtmfldFILE_DATE: TFIBDateTimeField;
    fbstrngfldFILE_NAME: TFIBStringField;
    fbntgrfldFILE_USUARIO: TFIBIntegerField;
    fbstrngfldFILE_PATH: TFIBStringField;
    fbdtmfldFECHA_INSERT: TFIBDateTimeField;
    fbntgrfldUSUARIO_INSERT: TFIBIntegerField;
    fbdtmfldFECHA_UPDATE: TFIBDateTimeField;
    fbntgrfldUSUARIO_UPDATE: TFIBIntegerField;
    fbntgrfldIDX_SOBRE: TFIBIntegerField;
    fbstrngfldEMP_RMT: TFIBStringField;
    fbstrngfldVIA_RMT: TFIBStringField;
    fbstrngfldDIR_RMT: TFIBStringField;
    fbstrngfldLOC_RMT: TFIBStringField;
    fbstrngfldPRV_RMT: TFIBStringField;
    fbstrngfldCP_RMT: TFIBStringField;
    fbstrngfldBARCODE: TFIBStringField;
    fbstrngfldACUSE: TFIBStringField;
    fbstrngfldTIPO: TFIBStringField;
    db_ss: TpFIBDatabase;
    busqueda_ss: TpFIBDataSet;
    dsbusqueda_ss: TDataSource;
    t_read_ss: TpFIBTransaction;
    t_write_ss: TpFIBTransaction;
    fbstrngfldCTO_RMT: TFIBStringField;
    qCP: TpFIBDataSet;
    dsCP: TDataSource;
    qReportDestinatario: TpFIBDataSet;
    dsfiltro_estados: TDataSource;
    qfiltro_estados: TpFIBDataSet;
    fbntgrfld_estadosID_CORREOS_CERT_ESTADO: TFIBIntegerField;
    fbntgrfld_estadosID_CORREOS_CERTIFICADA: TFIBIntegerField;
    fbstrngfld_estadosREFERENCIA: TFIBStringField;
    fbdtmfld_estadosFECHA: TFIBDateTimeField;
    fbstrngfld_estadosESTADO: TFIBStringField;
    fbstrngfld_estadosLINEA: TFIBStringField;
    fbdtmfld_estadosFECHA_INSERT: TFIBDateTimeField;
    con1: TADOConnection;
    qryCDS: TpFIBDataSet;
    qryProdCorr: TpFIBDataSet;
    q_aux: TpFIBDataSet;
    qryTemp: TpFIBDataSet;
    db_gestoras: TpFIBDatabase;
    t_read_gestoras: TpFIBTransaction;
    t_write_gestoras: TpFIBTransaction;
    qTempGest: TpFIBDataSet;
    busqueda_gest: TpFIBDataSet;
    dsbusqueda_gest: TDataSource;
    xEtiquetas: TpFIBDataSet;
    xEtiquetasUSUARIO: TFIBIntegerField;
    xEtiquetasID_ALBARAN: TFIBIntegerField;
    RESTResponse1: TRESTResponse;
    RESTRequest1: TRESTRequest;
    RESTClient1: TRESTClient;
    auth: THTTPBasicAuthenticator;
    stpGrabaAlb: TpFIBStoredProc;
    lgs_certifID_CORREOS_CERTIFICADAS: TFIBIntegerField;
    lgs_certifID_CLIENTE: TFIBIntegerField;
    lgs_certifID_CECO: TFIBIntegerField;
    lgs_certifID_PRODUCTO: TFIBIntegerField;
    lgs_certifID_ZONA: TFIBIntegerField;
    qfiltro_certifFECHA: TFIBDateField;
    qfiltro_certifVERSION: TFIBStringField;
    qfiltro_certifPRODUCTO_PAQ: TFIBStringField;
    lgs_certifBULTOS: TFIBIntegerField;
    qfiltro_certifEMPRESA: TFIBStringField;
    qfiltro_certifDIRECCION: TFIBStringField;
    qfiltro_certifLOCALIDAD: TFIBStringField;
    qfiltro_certifPROVINCIA: TFIBStringField;
    qfiltro_certifCP: TFIBStringField;
    qfiltro_certifPAIS: TFIBStringField;
    qfiltro_certifMODALIDAD: TFIBStringField;
    qfiltro_certifREFERENCIA: TFIBStringField;
    lgs_certifPESO: TFIBFloatField;
    lgs_certifALTO: TFIBFloatField;
    lgs_certifANCHO: TFIBFloatField;
    lgs_certifLARGO: TFIBFloatField;
    lgs_certifINTENTOS: TFIBIntegerField;
    lgs_certifEN_LISTA: TFIBIntegerField;
    qfiltro_certifPTO_ADMISION: TFIBStringField;
    lgs_certifFILE_DATE: TFIBDateTimeField;
    qfiltro_certifFILE_NAME: TFIBStringField;
    lgs_certifFILE_USUARIO: TFIBIntegerField;
    qfiltro_certifFILE_PATH: TFIBStringField;
    lgs_certifFECHA_INSERT: TFIBDateTimeField;
    lgs_certifUSUARIO_INSERT: TFIBIntegerField;
    lgs_certifFECHA_UPDATE: TFIBDateTimeField;
    lgs_certifUSUARIO_UPDATE: TFIBIntegerField;
    lgs_certifIDX_SOBRE: TFIBIntegerField;
    qfiltro_certifEMP_RMT: TFIBStringField;
    qfiltro_certifCTO_RMT: TFIBStringField;
    qfiltro_certifVIA_RMT: TFIBStringField;
    qfiltro_certifDIR_RMT: TFIBStringField;
    qfiltro_certifLOC_RMT: TFIBStringField;
    qfiltro_certifPRV_RMT: TFIBStringField;
    qfiltro_certifCP_RMT: TFIBStringField;
    qfiltro_certifBARCODE: TFIBStringField;
    qfiltro_certifACUSE: TFIBStringField;
    qfiltro_certifTIPO: TFIBStringField;
    qfiltro_certifESTADO: TFIBStringField;
    lgs_certifGEST_ALBARAN: TFIBIntegerField;
    lgs_certifGEST_DEST: TFIBIntegerField;
    qfiltro_certifPROD_NOM: TFIBStringField;
    qfiltro_certifZONA_NOM: TFIBStringField;
    lgsID_ZONA: TFIBIntegerField;
    qfileESTADO: TFIBStringField;
    lgsGEST_ALBARAN: TFIBIntegerField;
    lgsGEST_DEST: TFIBIntegerField;
    q1: TpFIBDataSet;
    lgs1: TFIBIntegerField;
    lgs2: TFIBIntegerField;
    xAlbaran: TpFIBDataSet;
    lgsAlbaranBULTOS: TFIBSmallIntField;
    lgsAlbaranPESO: TFIBFloatField;
    xBultos: TpFIBDataSet;
    lgsBultosBULTOS: TFIBIntegerField;
    xSigBulto: TpFIBDataSet;
    lgsSigBultoMAX_BULTO: TFIBSmallIntField;
    qPedidoLines: TpFIBDataSet;
    lgsPedidoLinesID_ARTICULO: TFIBIntegerField;
    lgsPedidoLinesCANTIDAD: TFIBIntegerField;
    lgsPedidoLinesKGS: TFIBFloatField;
    qPedidoLinesNOMBRE_ART: TFIBStringField;
    qPedidoLinesIMEI: TFIBWideStringField;
    q_ped_extra: TpFIBDataSet;
    q_picks_lotes: TpFIBDataSet;
    procedure qfiltro_certifAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

uses
  u_main;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure Tdm.qfiltro_certifAfterScroll(DataSet: TDataSet);
begin
   if u_main.modo=0 then
   if f_main.edIdCert.Value>0 then
   begin
       f_main.RellenaCertificada;
       f_main.GetCertEstado(f_main.edIdCert.Value);
   end;
end;

end.
