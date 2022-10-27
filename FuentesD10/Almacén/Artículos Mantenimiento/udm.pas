unit udm;

interface

uses
  SysUtils, Classes, DB, FIBDataSet, pFIBDataSet, FIBDatabase, pFIBDatabase,
  FIBQuery, pFIBQuery, pFIBErrorHandler,sdialogs, fib, Data.Win.ADODB;

type
  Tdm = class(TDataModule)
    db: TpFIBDatabase;
    t_read: TpFIBTransaction;
    t_write: TpFIBTransaction;
    busqueda: TpFIBDataSet;
    dsbusqueda: TDataSource;
    q_art: TpFIBDataSet;
    ds_art: TDataSource;
    q_ean: TpFIBDataSet;
    ds_ean: TDataSource;
    q_artID_ARTICULO: TFIBIntegerField;
    q_artCODIGO: TFIBStringField;
    q_artNOMBRE: TFIBStringField;
    q_artFECHA_ALTA: TFIBDateField;
    q_artFECHA_BAJA: TFIBDateField;
    q_artESTADO: TFIBStringField;
    q_artID_EMPRESA: TFIBIntegerField;
    q_artKGS: TFIBFloatField;
    q_artKGSVOL: TFIBFloatField;
    q_artLARGO: TFIBFloatField;
    q_artANCHO: TFIBFloatField;
    q_artALTO: TFIBFloatField;
    q_artUNI_EMBALAJE: TFIBIntegerField;
    q_artID_CLIENTE: TFIBIntegerField;
    q_artID_FAMILIA: TFIBIntegerField;
    q_artCODIGO_CLI: TFIBStringField;
    q_artNOM_CLI: TFIBStringField;
    q_artUDS_PALET: TFIBIntegerField;
    q_artIMAGEN: TFIBBlobField;
    q_artWEB: TFIBStringField;
    q_artWEB_JPG: TFIBStringField;
    q_artCODIGO_PROMOTORA: TFIBStringField;
    q_artSTOCK_MINIMO: TFIBIntegerField;
    q_artBC: TFIBStringField;
    q_artCUBIC: TFIBFloatField;
    q_artPRECIO: TFIBFloatField;
    strngfld_artCLIENTE: TStringField;
    strngfld_artFAMILIA_NOM: TStringField;
    fbntgrfld_eanID_ARTICULO_BC: TFIBIntegerField;
    fbntgrfld_eanID_ARTICULO: TFIBIntegerField;
    fbstrngfld_eanBC: TFIBStringField;
    fbstrngfld_eanESTADO: TFIBStringField;
    fbntgrfld_eanID_EMPRESA: TFIBIntegerField;
    fbstrngfld_artTIENE_LOTE: TFIBStringField;
    fbsmlntfld_artTIENE_IMEI: TFIBSmallIntField;
    con1: TADOConnection;
    procedure dbAfterConnect(Sender: TObject);
    procedure q_artPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure q_artCalcFields(DataSet: TDataSet);
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

uses u_globals, dialogs;

{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  firstconnect:=false;
end;

procedure Tdm.dbAfterConnect(Sender: TObject);               //conecta las tablas (db ya viene configurada y conectada de globals)
begin
  q_art.Active:=True;
  q_ean.Active:=True;
end;

procedure Tdm.dbBeforeConnect(Database: TFIBDatabase; LoginParams: TStrings;
  var DoConnect: Boolean);
begin
  if (firstconnect) then begin
    doconnect:=false;
    firstconnect:=false;
  end;
end;

procedure Tdm.q_artCalcFields(DataSet: TDataSet);
begin
  with tpfibdataset.Create(dm) do begin
    database:=db;
    close;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select nombre from g_clientes where id_cliente=:id_cliente');
    ParamByName('id_cliente').asinteger:=dataset.FieldByName('id_cliente').AsInteger;
    Open;

    if not(IsEmpty) then dataset.FieldByName('cliente_nom').asstring:=FieldByName('nombre').asstring
    else dataset.FieldByName('cliente_nom').asstring:='NOT FOUND';

    close;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select nombre from g_familias where id_familia=:id_familia');
    ParamByName('id_familia').asinteger:=dataset.FieldByName('id_familia').AsInteger;
    Open;

    if not(IsEmpty) then dataset.FieldByName('familia_nom').asstring:=FieldByName('nombre').asstring
    else dataset.FieldByName('familia_nom').asstring:='NOT FOUND';

    Free;
  end;
end;

procedure Tdm.q_artPostError(DataSet: TDataSet; E: EDatabaseError;
  var Action: TDataAction);
begin
  Action := daAbort;
  u_globals.ErrorBaseDatos(E);
end;

end.


