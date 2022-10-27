unit u_dm;

interface

uses
  SysUtils, Classes, DB, FIBDataSet, pFIBDataSet, FIBDatabase, pFIBDatabase,
  Data.Win.ADODB, IPPeerClient, REST.Client, REST.Authenticator.Basic,
  Data.Bind.Components, Data.Bind.ObjectScope, FIBQuery, pFIBQuery;

type
  Tdm = class(TDataModule)
    db: TpFIBDatabase;
    t_read: TpFIBTransaction;
    t_write: TpFIBTransaction;
    busqueda: TpFIBDataSet;
    dsbusqueda: TDataSource;
    q_stock: TpFIBDataSet;
    ds_stock: TDataSource;
    fbntgrfld_stockID_ALMACEN: TFIBIntegerField;
    fbntgrfld_stockID_UBICACION: TFIBIntegerField;
    fbntgrfld_stockID_ARTICULO: TFIBIntegerField;
    fbntgrfld_stockID_MATRICULA: TFIBIntegerField;
    fbntgrfld_stockID_LOTE: TFIBIntegerField;
    fbntgrfld_stockCANTIDAD: TFIBIntegerField;
    fbntgrfld_stockID_EMPRESA: TFIBIntegerField;
    strngfld_stockN_ARTICULO: TStringField;
    strngfld_stockR_ARTICULO: TStringField;
    q_rep: TpFIBDataSet;
    q_stock_ubic: TpFIBDataSet;
    ds_stock_ubic: TDataSource;
    strngfld_stock_ubicn_articulo: TStringField;
    strngfld_stock_ubicr_articulo: TStringField;
    fbntgrfld_stock_ubicID_ALMACEN: TFIBIntegerField;
    fbntgrfld_stock_ubicID_UBICACION: TFIBIntegerField;
    fbntgrfld_stock_ubicID_ARTICULO: TFIBIntegerField;
    fbntgrfld_stock_ubicID_MATRICULA: TFIBIntegerField;
    fbntgrfld_stock_ubicID_LOTE: TFIBIntegerField;
    fbntgrfld_stock_ubicCANTIDAD: TFIBIntegerField;
    fbntgrfld_stock_ubicID_EMPRESA: TFIBIntegerField;
    fbwdstrngfld_stock_ubicID_ESTANTERIA: TFIBStringField;
    fbntgrfld_stock_ubicID_POSICION: TFIBIntegerField;
    fbntgrfld_stock_ubicID_ALTURA: TFIBIntegerField;
    fbntgrfld_repID_MATRICULA: TFIBIntegerField;
    fbwdstrngfld_repCODIGO: TFIBStringField;
    fbwdstrngfld_repNOMBRE: TFIBStringField;
    fbwdstrngfld_repID_ESTANTERIA: TFIBStringField;
    fbntgrfld_repID_POSICION: TFIBIntegerField;
    fbntgrfld_repID_ALTURA: TFIBIntegerField;
    fbntgrfld_repCANTIDAD: TFIBIntegerField;
    q_lotes: TpFIBDataSet;
    ds_lotes: TDataSource;
    fbntgrfld_lotesID_LOTE: TFIBIntegerField;
    fbstrngfld_lotesNOMBRE: TFIBStringField;
    fbdtfld_lotesCADUCIDAD: TFIBDateField;
    fbstrngfld_lotesESTADO: TFIBStringField;
    q_stockN_LOTE: TStringField;
    q_stock_ubicn_lote: TStringField;
    con1: TADOConnection;
    q_aux: TpFIBDataSet;
    client: TRESTClient;
    request: TRESTRequest;
    response: TRESTResponse;
    auth: THTTPBasicAuthenticator;
    db_gestoras: TpFIBDatabase;
    t_read_gestoras: TpFIBTransaction;
    t_write_gestoras: TpFIBTransaction;
    q_1: TpFIBQuery;
    q_picks_lotes: TpFIBDataSet;
    lgs1: TFIBIntegerField;
    FIBStringField1: TFIBStringField;
    FIBDateField1: TFIBDateField;
    FIBStringField2: TFIBStringField;
    q_lotes_filter: TpFIBDataSet;
    lgs2: TFIBIntegerField;
    FIBStringField3: TFIBStringField;
    FIBDateField2: TFIBDateField;
    FIBStringField4: TFIBStringField;
    dsLotesFilter: TDataSource;
    procedure dbAfterConnect(Sender: TObject);
    procedure q_stockCalcFields(DataSet: TDataSet);
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

uses u_globals, u_alm_aux, u_main;

{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
    firstconnect:=false;
end;

procedure Tdm.dbAfterConnect(Sender: TObject);               //conecta las tablas (db ya viene configurada y conectada de globlas)
var  s:string;
begin
 { q_ubic.ParamByName('id_empresa').asinteger:=u_globals.id_empresa;
  q_ubic.Active:=True; }
  
end;

procedure Tdm.dbBeforeConnect(Database: TFIBDatabase; LoginParams: TStrings;
  var DoConnect: Boolean);
begin
    if (firstconnect) then begin
    doconnect:=false;
    firstconnect:=false;
  end;
end;

procedure Tdm.q_stockCalcFields(DataSet: TDataSet);
begin
  if trim(dataset.fieldbyname('id_articulo').text)<>'' then begin
    dataset.fieldbyname('n_articulo').text:=u_alm_aux.busca_art(dataset.fieldbyname('id_articulo').asinteger);
  end else begin
    dataset.FieldByName('n_articulo').text:='';
  end;

  if trim(dataset.fieldbyname('id_articulo').text)<>'' then begin
    dataset.fieldbyname('r_articulo').text:=u_alm_aux.busca_art_ref(dataset.fieldbyname('id_articulo').asinteger);
  end else begin
    dataset.FieldByName('r_articulo').text:='';
  end;

  if ((trim(dataset.fieldbyname('id_lote').text)<>'') and (trim(dataset.fieldbyname('id_lote').text)<>'1')) then begin
    dataset.fieldbyname('n_lote').text:=u_alm_aux.busca_lote_nom(dataset.fieldbyname('id_lote').asinteger);
  end else begin
    dataset.FieldByName('n_lote').text:='';
  end;
end;

end.


