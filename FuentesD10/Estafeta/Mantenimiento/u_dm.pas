unit u_dm;

interface

uses
  SysUtils, Classes, DB, FIBDataSet, pFIBDataSet, pFIBDatabase,
  pFIBQuery, DBClient, FIBQuery, FIBDatabase, Data.Win.ADODB;

type
  Tdm = class(TDataModule)
    db: TpFIBDatabase;
    t_read: TpFIBTransaction;
    t_write: TpFIBTransaction;
    busqueda: TpFIBDataSet;
    dsbusqueda: TDataSource;
    q_delegaciones: TpFIBDataSet;
    ds_delegaciones: TDataSource;
    qr_update: TpFIBQuery;
    q_1: TpFIBDataSet;
    q_2: TpFIBDataSet;
    q_valijas: TpFIBDataSet;
    ds_valijas: TDataSource;
    q_valijas_tarjetas: TpFIBDataSet;
    q_valijasID_VALIJA: TFIBIntegerField;
    q_valijasID_DELEGACION: TFIBIntegerField;
    q_valijasID_RUTA: TFIBIntegerField;
    q_valijasID_AGENCIA: TFIBIntegerField;
    q_valijasID_MODULO: TFIBIntegerField;
    q_valijasID_CASILLERO: TFIBIntegerField;
    q_valijasID_HUECO: TFIBIntegerField;
    q_valijasDEST_ESPECIALES: TFIBIntegerField;
    q_valijasMNEMONICO: TFIBStringField;
    q_valijasID_VALIJA_REDIR: TFIBIntegerField;
    q_valijasHORA_ENT: TFIBTimeField;
    q_valijasHORA_REC: TFIBTimeField;
    q_valijasDIAS_SEMANA: TFIBStringField;
    q_valijasESTADO: TFIBStringField;
    q_valijasID_EMPRESA: TFIBIntegerField;
    ds_valijas_tarjetas: TDataSource;
    fbntgrfld_valijas_tarjetasID_VALIJA_TARJETA: TFIBIntegerField;
    fbntgrfld_valijas_tarjetasID_VALIJA: TFIBIntegerField;
    fbstrngfld_valijas_tarjetasEAN: TFIBStringField;
    fbstrngfld_valijas_tarjetasRFID: TFIBStringField;
    fbntgrfld_valijas_tarjetasN_TARJETA: TFIBIntegerField;
    fbstrngfld_valijas_tarjetasESTADO: TFIBStringField;
    fbntgrfld_valijas_tarjetasID_EMPRESA: TFIBIntegerField;
    fbstrngfld_valijas_tarjetasEAN_ALT: TFIBStringField;
    fbntgrfld_valijas_tarjetasN_TARJETA_ALT: TFIBIntegerField;
    fbstrngfld_valijas_tarjetasEAN_OLD: TFIBStringField;
    fbstrngfld_valijas_tarjetasEAN_OLD2: TFIBStringField;
    cds_tjta: TClientDataSet;
    strngfld_tjtadelegacion: TStringField;
    intgrfld_tjtatipo: TIntegerField;
    strngfld_tjtadireccion: TStringField;
    strngfld_tjtanombre: TStringField;
    strngfld_tjtadireccion2: TStringField;
    strngfld_tjtaprovincia: TStringField;
    strngfld_tjtafrecuencia: TStringField;
    strngfld_tjtamodulo: TStringField;
    strngfld_tjtaean: TStringField;
    strngfld_tjtarfid: TStringField;
    fbntgrfld_valijasDISP_LLEGADA: TFIBIntegerField;
    fbntgrfld_valijasDISP_SALIDA: TFIBIntegerField;
    fbntgrfld_valijasID_AGRUPACION: TFIBIntegerField;
    fbntgrfld_delegacionesID_DELEGACION: TFIBIntegerField;
    fbstrngfld_delegacionesNOMBRE: TFIBStringField;
    fbntgrfld_delegacionesID_CLIENTE: TFIBIntegerField;
    fbntgrfld_delegacionesCOD_ENTIDAD: TFIBIntegerField;
    fbntgrfld_delegacionesCOD_DELEGACION: TFIBIntegerField;
    fbstrngfld_delegacionesDIRECCION: TFIBStringField;
    fbntgrfld_delegacionesID_CP: TFIBIntegerField;
    fbstrngfld_delegacionesCP: TFIBStringField;
    fbntgrfld_delegacionesID_POBLACION: TFIBIntegerField;
    fbstrngfld_delegacionesPOBLACION: TFIBStringField;
    fbntgrfld_delegacionesID_PROVINCIA: TFIBIntegerField;
    fbstrngfld_delegacionesPROVINCIA: TFIBStringField;
    fbstrngfld_delegacionesTELEFONO: TFIBStringField;
    fbstrngfld_delegacionesFAX: TFIBStringField;
    fbstrngfld_delegacionesEMAIL: TFIBStringField;
    fbstrngfld_delegacionesNIF: TFIBStringField;
    fbstrngfld_delegacionesESTADO: TFIBStringField;
    fbsmlntfld_delegacionesID_EMPRESA: TFIBSmallIntField;
    fbsmlntfld_delegacionesDEST_RECURRENTE: TFIBSmallIntField;
    fbsmlntfld_delegacionesORG_RECURRENTE: TFIBSmallIntField;
    fbntgrfld_delegacionesPEDIR_SOBRES: TFIBIntegerField;
    fbsmlntfld_delegacionesENVIAR_INCIDENCIA_EST: TFIBSmallIntField;
    fbsmlntfld_delegacionesENVIAR_INCIDENCIA_PRECINTO: TFIBSmallIntField;
    fbntgrfld_delegacionesID_DIRECCION_ZONA: TFIBIntegerField;
    fbntgrfld_delegacionesID_DIRECCION_TERRITORIAL: TFIBIntegerField;
    fbntgrfld_delegacionesID_TIPOLOGIA: TFIBIntegerField;
    fbstrngfld_delegacionesNOMBRE_DIR_ZONA: TFIBStringField;
    fbstrngfld_delegacionesNOMBRE_DIR_TERR: TFIBStringField;
    fbstrngfld_delegacionesNOMBRE_TIPOLOGIA: TFIBStringField;
    fbsmlntfld_delegacionesPEDIR_TRAZA: TFIBSmallIntField;
    con1: TADOConnection;
    q_aux: TpFIBDataSet;
    lgs_delegacionesENVIAR_AVISO_TRAZA: TFIBSmallIntField;
    q_delegacionesEMAIL_TRAZA: TFIBStringField;
    lgs_delegacionesID_TIPO_GRUPO: TFIBIntegerField;
    q_delegacionesEMAIL_SUBJECT_TRAZA: TFIBStringField;
    lgs_delegacionesES_PILOTO: TFIBSmallIntField;
    lgs_delegacionesPAGO_VALIJA: TFIBSmallIntField;
    lgs_delegacionesPAGO_ESTAFETA: TFIBSmallIntField;
    lgs_delegacionesPAGO_OL: TFIBSmallIntField;
    lgs_delegacionesSYNC_WEB: TFIBSmallIntField;
    lgs_delegacionesCOD_CAIXA: TFIBIntegerField;
    lgs_delegacionesCONVIERTE_CAIXA: TFIBSmallIntField;
    lgs_delegacionesID_DIRECCION_COMERCIAL: TFIBIntegerField;
    q_delegacionesNOMBRE_DIR_COM: TFIBStringField;
    q_delegs_count: TpFIBDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure q_delegacionesAfterScroll(DataSet: TDataSet);
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
  //if db.Connected then db.Connected:=False;
end;

procedure Tdm.dbBeforeConnect(Database: TFIBDatabase; LoginParams: TStrings;
  var DoConnect: Boolean);
begin
  if (firstconnect) then begin
    doconnect:=false;
    firstconnect:=false;
  end;
end;

procedure Tdm.q_delegacionesAfterScroll(DataSet: TDataSet);
begin
  f_main.change_deleg;
end;

end.
