unit u_dm;

interface

uses
  System.SysUtils, System.Classes, FIBQuery, pFIBQuery, pFIBStoredProc,
  FIBDatabase, pFIBDatabase;

type
  Tdm = class(TDataModule)
    db: TpFIBDatabase;
    t_read: TpFIBTransaction;
    t_write: TpFIBTransaction;
    spGetClienteConfig: TpFIBStoredProc;
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
