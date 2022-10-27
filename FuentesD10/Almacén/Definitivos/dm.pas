unit dm;

interface

uses
  System.SysUtils, System.Classes, FIBDatabase, pFIBDatabase, FIBQuery,
  pFIBQuery;

type
  Tdm1 = class(TDataModule)
    db: TpFIBDatabase;
    qry: TpFIBQuery;
    read: TpFIBTransaction;
    qryIndice: TpFIBQuery;
    qrydesubicados: TpFIBQuery;
    qrybusca: TpFIBQuery;
    qry_una_etiqueta: TpFIBQuery;
    qryarticulo: TpFIBQuery;
    qrymatriculas: TpFIBQuery;
    qrycajas: TpFIBQuery;
    qryentregados: TpFIBQuery;
    qrydevolver: TpFIBQuery;
    write: TpFIBTransaction;
    qrysolicitados: TpFIBQuery;
    qryentregar: TpFIBQuery;
    qryescribe: TpFIBQuery;
    qrydevolverweb: TpFIBQuery;
    stock: TpFIBQuery;
    existencias: TpFIBQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm1: Tdm1;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

end.
