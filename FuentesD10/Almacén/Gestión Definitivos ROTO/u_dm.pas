unit u_dm;

interface

uses
  System.SysUtils, System.Classes, FIBDatabase, pFIBDatabase, Data.DB,
  Data.Win.ADODB, FIBDataSet, pFIBDataSet;

type
  Tdm = class(TDataModule)
    db: TpFIBDatabase;
    t_read: TpFIBTransaction;
    t_write: TpFIBTransaction;
    con1: TADOConnection;
    t_read_gestoras: TpFIBTransaction;
    t_write_gestoras: TpFIBTransaction;
    db_gestoras: TpFIBDatabase;
    qryTemp: TpFIBDataSet;
    qTempGest: TpFIBDataSet;
    q_con: TpFIBDataSet;
    busqueda: TpFIBDataSet;
    dsbusqueda: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
