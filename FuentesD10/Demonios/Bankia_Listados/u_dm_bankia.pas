unit u_dm_bankia;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB, IdBaseComponent,
	IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  IdHeaderList, OverbyteIcsWndControl, OverbyteIcsHttpProt,
  FIBQuery, pFIBQuery, FIBDatabase, pFIBDatabase, System.TypInfo,
  Soap.WebServExp, Soap.WSDLBind, Xml.XMLSchema, Soap.WSDLPub,
  Datasnap.DBClient, Datasnap.Win.MConnect, Datasnap.Win.SConnect,
  XLSSheetData5, XLSReadWriteII5, FIBDataSet, pFIBDataSet, pFIBStoredProc;

type
  Tdm = class(TDataModule)
    db_bankia: TpFIBDatabase;
    t_read: TpFIBTransaction;
    t_write: TpFIBTransaction;
    qry: TpFIBDataSet;
    fbntgrfldID: TFIBIntegerField;
    fbntgrfldGRUPO: TFIBIntegerField;
    fbstrngfldDESCRIPCION: TFIBStringField;
    fblbfldQUERY: TFIBBlobField;
    fbntgrfldCOL: TFIBIntegerField;
    fbstrngfldESTADO: TFIBStringField;
    fbstrngfldVARIABLES: TFIBStringField;
    fbstrngfldCONEXION: TFIBStringField;
    qlistado: TpFIBDataSet;
    xls: TXLSReadWriteII5;
    spPtes: TpFIBStoredProc;
    qDelete: TpFIBQuery;
    procedure DataModuleCreate(Sender: TObject);
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

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
	xls := TXLSReadWriteII5.Create(Self);
end;

end.
