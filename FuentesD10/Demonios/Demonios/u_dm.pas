unit u_dm;

interface

uses
  System.SysUtils, System.Classes, FIBDatabase, pFIBDatabase, FIBQuery,
  pFIBQuery, pFIBStoredProc, Data.DB, FIBDataSet, pFIBDataSet, IPPeerClient,
  REST.Client, REST.Authenticator.Basic, Data.Bind.Components,
  Data.Bind.ObjectScope, Data.Win.ADODB;

type
  Tdm = class(TDataModule)
    db: TpFIBDatabase;
    t_read: TpFIBTransaction;
    t_write: TpFIBTransaction;
    qlistado: TpFIBDataSet;
    q_aux: TpFIBDataSet;
    spPtes: TpFIBStoredProc;
    qDelete: TpFIBQuery;
    client: TRESTClient;
    request: TRESTRequest;
    response: TRESTResponse;
    auth: THTTPBasicAuthenticator;
    q_1: TpFIBQuery;
    db_gestoras: TpFIBDatabase;
    t_read_gestoras: TpFIBTransaction;
    t_write_gestoras: TpFIBTransaction;
    q: TADOQuery;
    qry_db: TpFIBQuery;
    q_db: TpFIBDataSet;
    qry_fib_art: TpFIBQuery;
    q_sql: TADOQuery;
    q_fib_art: TpFIBDataSet;
    q_fib_stock: TpFIBDataSet;
    qDemonios: TpFIBDataSet;
    dsDemonios: TDataSource;
    lgsDemoniosID_DEMONIO: TFIBIntegerField;
    lgsDemoniosID_CLIENTE: TFIBIntegerField;
    qDemoniosDESCRIPCION: TFIBStringField;
    qDemoniosNOMBRE: TFIBStringField;
    lgsDemoniosTIPO: TFIBIntegerField;
    lgsDemoniosREPETICION: TFIBIntegerField;
    lgsDemoniosSIG_EJEC: TFIBDateTimeField;
    lgsDemoniosINTERVALO: TFIBIntegerField;
    qDemoniosESTADO: TFIBStringField;
    q_picks_lotes: TpFIBDataSet;
    lgs_picks_lotesCANTIDAD: TFIBIntegerField;
    lgs_picks_lotesID_LOTE: TFIBIntegerField;
    lgs_picks_lotesID_PICKCAB: TFIBIntegerField;
    lgs_picks_lotesLINEA: TFIBIntegerField;
    qTempGest: TpFIBDataSet;
    qrytemp: TpFIBDataSet;
    con1: TADOConnection;
    q_fib: TpFIBDataSet;
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
