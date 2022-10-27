unit u_dm;

interface

uses
  System.SysUtils, System.Classes, Data.DB, FIBDataSet, pFIBDataSet,
  FIBDatabase, pFIBDatabase, FIBQuery, pFIBQuery, pFIBStoredProc, Data.Win.ADODB;

type
  Tdm = class(TDataModule)
    db: TpFIBDatabase;
    t_read: TpFIBTransaction;
    t_write: TpFIBTransaction;
    busqueda: TpFIBDataSet;
    dsbusqueda: TDataSource;
    qry_tmp: TpFIBDataSet;
    qry_tmp2: TpFIBDataSet;
    qry_tmp4: TpFIBDataSet;
    qry_tmp3: TpFIBDataSet;
    qry_contador: TpFIBDataSet;
    dbF: TpFIBDatabase;
    t_readF: TpFIBTransaction;
    t_writeF: TpFIBTransaction;
    calcula: TpFIBStoredProc;
    qry_sql: TADOQuery;
    con_sql: TADOConnection;
    qryF_tmp: TpFIBDataSet;
    qryF_tmp2: TpFIBDataSet;
    qryf_tmp3: TpFIBDataSet;
    qryF_sql: TpFIBDataSet;
    qryF_tmp4: TpFIBDataSet;
    qry_aux: TpFIBDataSet;
    qry_Entradas: TpFIBDataSet;
    qry_EntradasAlm: TpFIBDataSet;
    qry_EntradasUnidades: TpFIBDataSet;
    qryEntradasLineasExtra: TpFIBDataSet;
    qryF_exceso: TpFIBDataSet;
    qryextras: TpFIBDataSet;
    qGridCor1: TFIBStringField;
    qGridCor2: TFIBStringField;
    fbfltfld1: TFIBFloatField;
    fbcdfld1: TFIBBCDField;
    fbdtmfld1: TFIBDateTimeField;
    fblnfld1: TFIBBooleanField;
    qry_Devoluciones: TpFIBDataSet;
    fbdtfld_DevolucionesFECHA: TFIBDateField;
    fbntgrfld_DevolucionesUDS: TFIBIntegerField;
    qryPreparacionPedidos: TpFIBDataSet;
    qryF_limite: TpFIBDataSet;
    qryTiposPreparacion: TpFIBDataSet;
    fbntgrfldTiposPreparacionID_CLIENTE: TFIBIntegerField;
    fbcdfldTiposPreparacionIMEIS: TFIBBCDField;
    fbntgrfldTiposPreparacionCANTIDAD: TFIBIntegerField;
    qry_EntradasAlmFECHA: TFIBDateField;
    qry_EntradasAlmALBARANES: TFIBIntegerField;
    qry_EntradasAlmLINEAS: TFIBIntegerField;
    qry_EntradasAlmPALES: TFIBBCDField;
    qry_DevolucionesORDER_NAME: TFIBIntegerField;
    qry_EntradasAlmMer: TpFIBDataSet;
    FIBDateField1: TFIBDateField;
    FIBIntegerField1: TFIBIntegerField;
    FIBIntegerField2: TFIBIntegerField;
    FIBBCDField1: TFIBBCDField;
    fbcdfld_EntradasAlmMerIMEIS: TFIBBCDField;
    qry_numImeiPedido: TpFIBDataSet;
    fbntgrfld_numImeiPedidoID_CLIENTE: TFIBIntegerField;
    fbcdfld_numImeiPedidoCANTIDADIMEI: TFIBBCDField;
    qry_grupoCliente: TpFIBDataSet;
    spInsertaMerydeis: TpFIBStoredProc;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

end.
