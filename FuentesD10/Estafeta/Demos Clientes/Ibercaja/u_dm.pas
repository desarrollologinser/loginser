unit u_dm;

interface

uses
  SysUtils, Classes, DB, FIBDataSet, pFIBDataSet, pFIBDatabase,
  pFIBQuery, DBClient, FIBQuery, FIBDatabase, Data.Win.ADODB;

type
  Tdm = class(TDataModule)
    t_read: TpFIBTransaction;
    t_write: TpFIBTransaction;
    busqueda: TpFIBDataSet;
    dsbusqueda: TDataSource;
    q_resumen: TpFIBDataSet;
    ds_resumen: TDataSource;
    q_incidencias: TpFIBDataSet;
    ds_incidencias: TDataSource;
    qr_update: TpFIBQuery;
    q_resumen_tot: TpFIBDataSet;
    q_incidencias_tot: TpFIBDataSet;
    fbntgrfld_incidencias_totTOTAL: TFIBIntegerField;
    q_1: TpFIBDataSet;
    q_2: TpFIBDataSet;
    fbntgrfld_resumen_totTOTAL: TFIBIntegerField;
    fbcdfld_resumen_totBULTOS: TFIBBCDField;
    q_incidencias_report: TpFIBDataSet;
    q_resumen_report: TpFIBDataSet;
    fbntgrfld_incidencias_reportID_INCIDENCIAS_ESTAFETA: TFIBIntegerField;
    fbdtfld_incidencias_reportFECHA: TFIBDateField;
    fbtmfld_incidencias_reportHORA: TFIBTimeField;
    fbstrngfld_incidencias_reportINCID_NOMBRE: TFIBStringField;
    fbstrngfld_incidencias_reportOBSERVACIONES: TFIBStringField;
    fbntgrfld_incidencias_reportID_CLIENTE: TFIBIntegerField;
    fbntgrfld_incidencias_reportCOD_DELEGACION: TFIBIntegerField;
    fbstrngfld_incidencias_reportNOMBRE: TFIBStringField;
    fbstrngfld_incidencias_reportDIRECCION: TFIBStringField;
    fbstrngfld_incidencias_reportCP: TFIBStringField;
    fbstrngfld_incidencias_reportPOBLACION: TFIBStringField;
    fbstrngfld_incidencias_reportPROVINCIA: TFIBStringField;
    fbstrngfld_incidencias_reportNOM_CLIENTE: TFIBStringField;
    fbntgrfld_resumen_reportID_LECTURA_ESTAFETA: TFIBIntegerField;
    fbdtfld_resumen_reportFECHA: TFIBDateField;
    fbtmfld_resumen_reportHORA: TFIBTimeField;
    fbntgrfld_resumen_reportBULTOS: TFIBIntegerField;
    fbstrngfld_resumen_reportCOD_DELEGACION_ORG: TFIBStringField;
    fbstrngfld_resumen_reportNOMBRE_ORG: TFIBStringField;
    fbstrngfld_resumen_reportDIRECCION_ORG: TFIBStringField;
    fbstrngfld_resumen_reportCP_ORG: TFIBStringField;
    fbstrngfld_resumen_reportPOBLACION_ORG: TFIBStringField;
    fbstrngfld_resumen_reportPROVINCIA_ORG: TFIBStringField;
    fbstrngfld_resumen_reportCOD_DELEGACION_DST: TFIBStringField;
    fbstrngfld_resumen_reportNOMBRE_DST: TFIBStringField;
    fbstrngfld_resumen_reportDIRECCION_DST: TFIBStringField;
    fbstrngfld_resumen_reportCP_DST: TFIBStringField;
    fbstrngfld_resumen_reportPOBLACION_DST: TFIBStringField;
    fbstrngfld_resumen_reportPROVINCIA_DST: TFIBStringField;
    q_resumen_digit: TpFIBDataSet;
    ds_resumen_digit: TDataSource;
    q_resumen_digit_tot: TpFIBDataSet;
    fbntgrfld3: TFIBIntegerField;
    fbcdfld1: TFIBBCDField;
    q_digit_report: TpFIBDataSet;
    FIBIntegerField1: TFIBIntegerField;
    FIBDateField1: TFIBDateField;
    FIBTimeField1: TFIBTimeField;
    FIBIntegerField2: TFIBIntegerField;
    FIBStringField1: TFIBStringField;
    FIBStringField2: TFIBStringField;
    FIBStringField3: TFIBStringField;
    FIBStringField4: TFIBStringField;
    FIBStringField5: TFIBStringField;
    FIBStringField6: TFIBStringField;
    FIBStringField7: TFIBStringField;
    FIBStringField8: TFIBStringField;
    FIBStringField9: TFIBStringField;
    FIBStringField10: TFIBStringField;
    FIBStringField11: TFIBStringField;
    FIBStringField12: TFIBStringField;
    q_aux: TpFIBDataSet;
    fbntgrfld_incidenciasID_INCIDENCIAS_ESTAFETA: TFIBIntegerField;
    fbdtfld_incidenciasFECHA: TFIBDateField;
    fbtmfld_incidenciasHORA: TFIBTimeField;
    fbstrngfld_incidenciasINCID_NOMBRE: TFIBStringField;
    fbstrngfld_incidenciasOBSERVACIONES: TFIBStringField;
    fbstrngfld_incidenciasCOD_DELEGACION: TFIBStringField;
    fbstrngfld_incidenciasNOMBRE: TFIBStringField;
    fbstrngfld_incidenciasDIRECCION: TFIBStringField;
    fbstrngfld_incidenciasCP: TFIBStringField;
    fbstrngfld_incidenciasPOBLACION: TFIBStringField;
    fbstrngfld_incidenciasPROVINCIA: TFIBStringField;
    fbntgrfld_incidenciasID_DELEGACION: TFIBIntegerField;
    fbntgrfld_incidenciasID_TIPO_INCIDENCIA_EST: TFIBIntegerField;
    fbntgrfld_incidenciasCOD_ENTIDAD: TFIBIntegerField;
    fbntgrfld_resumen_digitID_LECTURA_ESTAFETA: TFIBIntegerField;
    fbdtfld_resumen_digitFECHA: TFIBDateField;
    fbtmfld_resumen_digitHORA: TFIBTimeField;
    fbntgrfld_resumen_digitBULTOS: TFIBIntegerField;
    fbsmlntfld_resumen_digitLLENO: TFIBSmallIntField;
    fbstrngfld_resumen_digitCOD_DELEGACION_ORG: TFIBStringField;
    fbstrngfld_resumen_digitNOMBRE_ORG: TFIBStringField;
    fbstrngfld_resumen_digitDIRECCION_ORG: TFIBStringField;
    fbstrngfld_resumen_digitCP_ORG: TFIBStringField;
    fbstrngfld_resumen_digitPOBLACION_ORG: TFIBStringField;
    fbstrngfld_resumen_digitPROVINCIA_ORG: TFIBStringField;
    fbstrngfld_resumen_digitCOD_DELEGACION_DST: TFIBStringField;
    fbstrngfld_resumen_digitNOMBRE_DST: TFIBStringField;
    fbstrngfld_resumen_digitDIRECCION_DST: TFIBStringField;
    fbstrngfld_resumen_digitCP_DST: TFIBStringField;
    fbstrngfld_resumen_digitPOBLACION_DST: TFIBStringField;
    fbstrngfld_resumen_digitPROVINCIA_DST: TFIBStringField;
    fbntgrfld_resumen_digitORG_COD_ENTIDAD: TFIBIntegerField;
    fbntgrfld_resumen_digitORG_COD_DELEGACION: TFIBIntegerField;
    fbntgrfld_resumen_digitDST_COD_ENTIDAD: TFIBIntegerField;
    fbntgrfld_resumen_digitDST_COD_DELEGACION: TFIBIntegerField;
    fbstrngfld_resumen_digitEAN: TFIBStringField;
    con1: TADOConnection;
    q_delegs: TpFIBDataSet;
    ds_delegs: TDataSource;
    lgs_resumenID_LECTURA_ESTAFETA: TFIBIntegerField;
    q_resumenFECHA: TFIBDateField;
    q_resumenHORA: TFIBTimeField;
    lgs_resumenBULTOS: TFIBIntegerField;
    lgs_resumenLLENO: TFIBSmallIntField;
    q_resumenCOD_DELEGACION_ORG: TFIBStringField;
    q_resumenNOMBRE_ORG: TFIBStringField;
    q_resumenDIRECCION_ORG: TFIBStringField;
    q_resumenCP_ORG: TFIBStringField;
    q_resumenPOBLACION_ORG: TFIBStringField;
    q_resumenPROVINCIA_ORG: TFIBStringField;
    q_resumenCOD_DELEGACION_DST: TFIBStringField;
    q_resumenNOMBRE_DST: TFIBStringField;
    q_resumenDIRECCION_DST: TFIBStringField;
    q_resumenCP_DST: TFIBStringField;
    q_resumenPOBLACION_DST: TFIBStringField;
    q_resumenPROVINCIA_DST: TFIBStringField;
    q_resumenTRAZA: TFIBStringField;
    q_resumenCOD_CAIXA: TFIBStringField;
    qfile: TpFIBDataSet;
    lgsID_CORREOS_CERTIFICADAS: TFIBIntegerField;
    lgsID_CLIENTE: TFIBIntegerField;
    lgsID_CECO: TFIBIntegerField;
    lgsID_PRODUCTO: TFIBIntegerField;
    fbdtfldFECHA: TFIBDateField;
    fbstrngfldVERSION: TFIBStringField;
    fbstrngfldPRODUCTO_PAQ: TFIBStringField;
    lgsBULTOS: TFIBIntegerField;
    fbstrngfldEMPRESA: TFIBStringField;
    fbstrngfldDIRECCION: TFIBStringField;
    fbstrngfldLOCALIDAD: TFIBStringField;
    fbstrngfldPROVINCIA: TFIBStringField;
    fbstrngfldCP: TFIBStringField;
    fbstrngfldPAIS: TFIBStringField;
    fbstrngfldMODALIDAD: TFIBStringField;
    fbstrngfldREFERENCIA: TFIBStringField;
    lgsPESO: TFIBFloatField;
    lgsALTO: TFIBFloatField;
    lgsANCHO: TFIBFloatField;
    lgsLARGO: TFIBFloatField;
    lgsINTENTOS: TFIBIntegerField;
    lgsEN_LISTA: TFIBIntegerField;
    fbstrngfldPTO_ADMISION: TFIBStringField;
    lgsFILE_DATE: TFIBDateTimeField;
    fbstrngfldFILE_NAME: TFIBStringField;
    lgsFILE_USUARIO: TFIBIntegerField;
    fbstrngfldFILE_PATH: TFIBStringField;
    lgsFECHA_INSERT: TFIBDateTimeField;
    lgsUSUARIO_INSERT: TFIBIntegerField;
    lgsFECHA_UPDATE: TFIBDateTimeField;
    lgsUSUARIO_UPDATE: TFIBIntegerField;
    lgsIDX_SOBRE: TFIBIntegerField;
    fbstrngfldEMP_RMT: TFIBStringField;
    fbstrngfldVIA_RMT: TFIBStringField;
    fbstrngfldDIR_RMT: TFIBStringField;
    fbstrngfldLOC_RMT: TFIBStringField;
    fbstrngfldPRV_RMT: TFIBStringField;
    fbstrngfldCP_RMT: TFIBStringField;
    fbstrngfldBARCODE: TFIBStringField;
    fbstrngfldACUSE: TFIBStringField;
    fbstrngfldTIPO: TFIBStringField;
    fbstrngfldCTO_RMT: TFIBStringField;
    lgsID_ZONA: TFIBIntegerField;
    qfileESTADO: TFIBStringField;
    lgsGEST_ALBARAN: TFIBIntegerField;
    lgsGEST_DEST: TFIBIntegerField;
    strngfld_resumenCOD_VLJ_DST: TStringField;
    q_resumenNOM_VLJ_DST: TFIBStringField;
    q_resumenDIR_VLJ_DST: TFIBStringField;
    q_resumenCP_VLJ_DST: TFIBStringField;
    q_resumenPOBL_VLJ_DST: TFIBStringField;
    q_resumenPROV_VLJ_DST: TFIBStringField;
    lgs_resumenPEDIR_TRAZA: TFIBSmallIntField;
    db: TpFIBDatabase;
    procedure DataModuleCreate(Sender: TObject);
    procedure dbBeforeConnect(Database: TFIBDatabase; LoginParams: TStrings;
      var DoConnect: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;
  firstConnect:Boolean=True;

implementation

uses
  u_main;

{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  firstconnect:=false;
end;

procedure Tdm.dbBeforeConnect(Database: TFIBDatabase; LoginParams: TStrings;
  var DoConnect: Boolean);
begin
  if (firstconnect) then begin
    doconnect:=false;
    firstconnect:=false;
  end;
end;

end.


