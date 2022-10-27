unit u_dm;

interface

uses
  SysUtils, Classes, FIBDatabase, pFIBDatabase, DB, FIBDataSet, pFIBDataSet,
  FIBQuery, pFIBQuery;

type
  Tdm = class(TDataModule)
    db: TpFIBDatabase;
    t_write: TpFIBTransaction;
    t_read: TpFIBTransaction;
    ds: TpFIBDataSet;
    qry_existe: TpFIBDataSet;
    busqueda: TpFIBDataSet;
    dsbusqueda: TDataSource;
    qry_insertaBC: TpFIBQuery;
    qry_aux: TpFIBDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{$R *.dfm}

end.
