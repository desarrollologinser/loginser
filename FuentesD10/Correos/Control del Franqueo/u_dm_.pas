unit u_dm;

interface

uses
  System.SysUtils, System.Classes, Data.DB, FIBDataSet, pFIBDataSet,
  FIBDatabase, pFIBDatabase, FIBQuery, pFIBQuery, Data.Win.ADODB;

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
    fbntgrfldReportID_CLIENTE: TFIBIntegerField;
    fbntgrfldReportID_CECO: TFIBIntegerField;
    fbntgrfldReportID_PRODUCTO: TFIBIntegerField;
    fbdtmfldReportFECHA: TFIBDateTimeField;
    qReportBonificacion: TpFIBDataSet;
    fbntgrfld1: TFIBIntegerField;
    qReportResumen: TpFIBDataSet;
    qfiltro: TpFIBDataSet;
    fbntgrfldUDS: TFIBIntegerField;
    dsfiltro_cert: TDataSource;
    qfile: TpFIBDataSet;
    qfiltro_certif: TpFIBDataSet;
    fbntgrfld_certifID_CORREOS_CERTIFICADAS: TFIBIntegerField;
    fbntgrfld_certifID_CLIENTE: TFIBIntegerField;
    fbntgrfld_certifID_CECO: TFIBIntegerField;
    fbntgrfld_certifID_PRODUCTO: TFIBIntegerField;
    fbdtfld_certifFECHA: TFIBDateField;
    fbstrngfld_certifVERSION: TFIBStringField;
    fbstrngfld_certifPRODUCTO_PAQ: TFIBStringField;
    fbntgrfld_certifBULTOS: TFIBIntegerField;
    fbstrngfld_certifEMPRESA: TFIBStringField;
    fbstrngfld_certifDIRECCION: TFIBStringField;
    fbstrngfld_certifLOCALIDAD: TFIBStringField;
    fbstrngfld_certifPROVINCIA: TFIBStringField;
    fbstrngfld_certifCP: TFIBStringField;
    fbstrngfld_certifPAIS: TFIBStringField;
    fbstrngfld_certifMODALIDAD: TFIBStringField;
    fbstrngfld_certifREFERENCIA: TFIBStringField;
    fbfltfld_certifPESO: TFIBFloatField;
    fbfltfld_certifALTO: TFIBFloatField;
    fbfltfld_certifANCHO: TFIBFloatField;
    fbfltfld_certifLARGO: TFIBFloatField;
    fbntgrfld_certifINTENTOS: TFIBIntegerField;
    fbntgrfld_certifEN_LISTA: TFIBIntegerField;
    fbstrngfld_certifPTO_ADMISION: TFIBStringField;
    fbdtmfld_certifFILE_DATE: TFIBDateTimeField;
    fbstrngfld_certifFILE_NAME: TFIBStringField;
    fbntgrfld_certifFILE_USUARIO: TFIBIntegerField;
    fbstrngfld_certifFILE_PATH: TFIBStringField;
    fbdtmfld_certifFECHA_INSERT: TFIBDateTimeField;
    fbntgrfld_certifUSUARIO_INSERT: TFIBIntegerField;
    fbdtmfld_certifFECHA_UPDATE: TFIBDateTimeField;
    fbntgrfld_certifUSUARIO_UPDATE: TFIBIntegerField;
    fbntgrfld_certifIDX_SOBRE: TFIBIntegerField;
    fbstrngfld_certifEMP_RMT: TFIBStringField;
    fbstrngfld_certifVIA_RMT: TFIBStringField;
    fbstrngfld_certifDIR_RMT: TFIBStringField;
    fbstrngfld_certifLOC_RMT: TFIBStringField;
    fbstrngfld_certifPRV_RMT: TFIBStringField;
    fbstrngfld_certifCP_RMT: TFIBStringField;
    fbstrngfld_certifBARCODE: TFIBStringField;
    fbstrngfld_certifACUSE: TFIBStringField;
    fbstrngfld_certifTIPO: TFIBStringField;
    fbntgrfld_certifCOD_CLI: TFIBIntegerField;
    fbstrngfld_certifCECO: TFIBStringField;
    qRepCert: TpFIBDataSet;
    fbntgrfldRepCertID_CORREOS_CERTIFICADAS: TFIBIntegerField;
    fbntgrfldRepCertID_CLIENTE: TFIBIntegerField;
    fbntgrfldRepCertID_CECO: TFIBIntegerField;
    fbntgrfldRepCertID_PRODUCTO: TFIBIntegerField;
    fbdtfldRepCertFECHA: TFIBDateField;
    fbstrngfldRepCertVERSION: TFIBStringField;
    fbstrngfldRepCertPRODUCTO_PAQ: TFIBStringField;
    fbntgrfldRepCertBULTOS: TFIBIntegerField;
    fbstrngfldRepCertEMPRESA: TFIBStringField;
    fbstrngfldRepCertDIRECCION: TFIBStringField;
    fbstrngfldRepCertLOCALIDAD: TFIBStringField;
    fbstrngfldRepCertPROVINCIA: TFIBStringField;
    fbstrngfldRepCertCP: TFIBStringField;
    fbstrngfldRepCertPAIS: TFIBStringField;
    fbstrngfldRepCertMODALIDAD: TFIBStringField;
    fbstrngfldRepCertREFERENCIA: TFIBStringField;
    fbfltfldRepCertPESO: TFIBFloatField;
    fbfltfldRepCertALTO: TFIBFloatField;
    fbfltfldRepCertANCHO: TFIBFloatField;
    fbfltfldRepCertLARGO: TFIBFloatField;
    fbntgrfldRepCertINTENTOS: TFIBIntegerField;
    fbntgrfldRepCertEN_LISTA: TFIBIntegerField;
    fbstrngfldRepCertPTO_ADMISION: TFIBStringField;
    fbdtmfldRepCertFILE_DATE: TFIBDateTimeField;
    fbstrngfldRepCertFILE_NAME: TFIBStringField;
    fbntgrfldRepCertFILE_USUARIO: TFIBIntegerField;
    fbstrngfldRepCertFILE_PATH: TFIBStringField;
    fbdtmfldRepCertFECHA_INSERT: TFIBDateTimeField;
    fbntgrfldRepCertUSUARIO_INSERT: TFIBIntegerField;
    fbdtmfldRepCertFECHA_UPDATE: TFIBDateTimeField;
    fbntgrfldRepCertUSUARIO_UPDATE: TFIBIntegerField;
    fbntgrfldRepCertIDX_SOBRE: TFIBIntegerField;
    fbstrngfldRepCertEMP_RMT: TFIBStringField;
    fbstrngfldRepCertVIA_RMT: TFIBStringField;
    fbstrngfldRepCertDIR_RMT: TFIBStringField;
    fbstrngfldRepCertLOC_RMT: TFIBStringField;
    fbstrngfldRepCertPRV_RMT: TFIBStringField;
    fbstrngfldRepCertCP_RMT: TFIBStringField;
    fbstrngfldRepCertBARCODE: TFIBStringField;
    fbstrngfldRepCertACUSE: TFIBStringField;
    fbstrngfldRepCertTIPO: TFIBStringField;
    fbntgrfldRepCertCOD_CLI: TFIBIntegerField;
    fbstrngfldRepCertCECO: TFIBStringField;
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
    fbstrngfld_certifCTO_RMT: TFIBStringField;
    fbstrngfldCTO_RMT: TFIBStringField;
    qCP: TpFIBDataSet;
    fbntgrfld_certifID_ZONA: TFIBIntegerField;
    fbntgrfldReportDetalleCLI_COD: TFIBIntegerField;
    fbstrngfldReportDetalleCLI_NOM: TFIBStringField;
    fbstrngfldReportDetalleCECO_COD: TFIBStringField;
    fbstrngfldReportDetalleCECO_NOM: TFIBStringField;
    fbstrngfldReportDetallePROD_NOM: TFIBStringField;
    fbntgrfldReportDetalleID_ZONA: TFIBIntegerField;
    fbstrngfldReportDetalleZONA_NOM: TFIBStringField;
    fbntgrfldReportDetallePESO: TFIBIntegerField;
    fbcdfldReportDetalleTARIFA: TFIBBCDField;
    fbcdfldReportDetalleUDS: TFIBBCDField;
    fbcdfldReportDetalleSUBTOTAL: TFIBBCDField;
    fbntgrfldReportResumenID_CLIENTE: TFIBIntegerField;
    fbntgrfldReportResumenID_CECO: TFIBIntegerField;
    fbcdfldReportResumenUDS: TFIBBCDField;
    fbcdfldReportResumenSUBTOTAL: TFIBBCDField;
    fbstrngfldReportResumenCLI_NOM: TFIBStringField;
    fbstrngfldReportResumenCECO_NOM: TFIBStringField;
    fbntgrfldReportResumenPESO: TFIBIntegerField;
    dsCP: TDataSource;
    qReportDestinatario: TpFIBDataSet;
    fbntgrfldReportDestinatarioID_CORREOS_CERTIFICADAS: TFIBIntegerField;
    fbntgrfldReportDestinatarioID_CLIENTE: TFIBIntegerField;
    fbntgrfldReportDestinatarioID_CECO: TFIBIntegerField;
    fbntgrfldReportDestinatarioID_PRODUCTO: TFIBIntegerField;
    fbntgrfldReportDestinatarioID_ZONA: TFIBIntegerField;
    fbdtfldReportDestinatarioFECHA: TFIBDateField;
    fbstrngfldReportDestinatarioVERSION: TFIBStringField;
    fbstrngfldReportDestinatarioPRODUCTO_PAQ: TFIBStringField;
    fbntgrfldReportDestinatarioBULTOS: TFIBIntegerField;
    fbstrngfldReportDestinatarioEMPRESA: TFIBStringField;
    fbstrngfldReportDestinatarioDIRECCION: TFIBStringField;
    fbstrngfldReportDestinatarioLOCALIDAD: TFIBStringField;
    fbstrngfldReportDestinatarioPROVINCIA: TFIBStringField;
    fbstrngfldReportDestinatarioCP: TFIBStringField;
    fbstrngfldReportDestinatarioPAIS: TFIBStringField;
    fbstrngfldReportDestinatarioMODALIDAD: TFIBStringField;
    fbstrngfldReportDestinatarioREFERENCIA: TFIBStringField;
    fbfltfldReportDestinatarioPESO: TFIBFloatField;
    fbfltfldReportDestinatarioALTO: TFIBFloatField;
    fbfltfldReportDestinatarioANCHO: TFIBFloatField;
    fbfltfldReportDestinatarioLARGO: TFIBFloatField;
    fbntgrfldReportDestinatarioINTENTOS: TFIBIntegerField;
    fbntgrfldReportDestinatarioEN_LISTA: TFIBIntegerField;
    fbstrngfldReportDestinatarioPTO_ADMISION: TFIBStringField;
    fbdtmfldReportDestinatarioFILE_DATE: TFIBDateTimeField;
    fbstrngfldReportDestinatarioFILE_NAME: TFIBStringField;
    fbntgrfldReportDestinatarioFILE_USUARIO: TFIBIntegerField;
    fbstrngfldReportDestinatarioFILE_PATH: TFIBStringField;
    fbdtmfldReportDestinatarioFECHA_INSERT: TFIBDateTimeField;
    fbntgrfldReportDestinatarioUSUARIO_INSERT: TFIBIntegerField;
    fbdtmfldReportDestinatarioFECHA_UPDATE: TFIBDateTimeField;
    fbntgrfldReportDestinatarioUSUARIO_UPDATE: TFIBIntegerField;
    fbntgrfldReportDestinatarioIDX_SOBRE: TFIBIntegerField;
    fbstrngfldReportDestinatarioEMP_RMT: TFIBStringField;
    fbstrngfldReportDestinatarioCTO_RMT: TFIBStringField;
    fbstrngfldReportDestinatarioVIA_RMT: TFIBStringField;
    fbstrngfldReportDestinatarioDIR_RMT: TFIBStringField;
    fbstrngfldReportDestinatarioLOC_RMT: TFIBStringField;
    fbstrngfldReportDestinatarioPRV_RMT: TFIBStringField;
    fbstrngfldReportDestinatarioCP_RMT: TFIBStringField;
    fbstrngfldReportDestinatarioBARCODE: TFIBStringField;
    fbstrngfldReportDestinatarioACUSE: TFIBStringField;
    fbstrngfldReportDestinatarioTIPO: TFIBStringField;
    fbstrngfldReportDestinatarioESTADO: TFIBStringField;
    fbntgrfldReportDestinatarioCLI_COD: TFIBIntegerField;
    fbstrngfldReportDestinatarioCLI_NOM: TFIBStringField;
    fbstrngfldReportDestinatarioCECO_COD: TFIBStringField;
    fbstrngfldReportDestinatarioCECO_NOM: TFIBStringField;
    fbstrngfldReportDestinatarioPROD_NOM: TFIBStringField;
    fbstrngfldReportDestinatarioZONA_NOM: TFIBStringField;
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
   if fmain.edIdCert.Value>0 then
   begin
       fmain.RellenaCertificada;
       fmain.GetCertEstado(fmain.edIdCert.Value);
   end;
end;

end.
