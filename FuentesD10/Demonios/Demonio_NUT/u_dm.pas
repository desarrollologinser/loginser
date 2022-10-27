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
    qry: TpFIBDataSet;
    spPtes: TpFIBStoredProc;
    qDelete: TpFIBQuery;
    qryID: TFIBIntegerField;
    qryGRUPO: TFIBIntegerField;
    qryDESCRIPCION: TFIBStringField;
    qryQUERY: TFIBBlobField;
    qryCOL: TFIBIntegerField;
    qryESTADO: TFIBWideStringField;
    qryVARIABLES: TFIBStringField;
    qryCONEXION: TFIBStringField;
    client: TRESTClient;
    request: TRESTRequest;
    response: TRESTResponse;
    auth: THTTPBasicAuthenticator;
    q1: TpFIBDataSet;
    qry1: TpFIBQuery;
    db_gestoras: TpFIBDatabase;
    t_read_gestoras: TpFIBTransaction;
    t_write_gestoras: TpFIBTransaction;
    con1: TADOConnection;
    q: TADOQuery;
    qry_db: TpFIBQuery;
    q_db: TpFIBDataSet;
    qry_fib_art: TpFIBQuery;
    q_sql_art: TADOQuery;
    q_fib_art: TpFIBDataSet;
    q_fib_stock: TpFIBDataSet;
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
