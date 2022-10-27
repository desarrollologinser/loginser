unit u_dm_oxfam;

interface

uses
  System.Classes, Data.DB, FIBDataSet, pFIBDataSet,
  pFIBDatabase ,pFIBQuery, FIBQuery, FIBDatabase, Data.Win.ADODB,
  Datasnap.DBClient;

type
  Tdm_oxf = class(TDataModule)
    db: TpFIBDatabase;
    t_read: TpFIBTransaction;
    t_write: TpFIBTransaction;
    q_peds: TpFIBDataSet;
    ds_peds: TDataSource;
    q_1: TpFIBQuery;
    ds_1: TpFIBDataSet;
    ds_2: TpFIBDataSet;
    q_peds_count: TpFIBDataSet;
    fbntgrfld_pedsID_OXFAM: TFIBIntegerField;
    fbntgrfld_pedsID_ORDER: TFIBIntegerField;
    fbstrngfld_pedsORDER_NAME: TFIBStringField;
    fbstrngfld_pedsNOMBRE: TFIBStringField;
    fbstrngfld_pedsDIR_1: TFIBStringField;
    fbstrngfld_pedsDIR_2: TFIBStringField;
    fbstrngfld_pedsPOBLACION: TFIBStringField;
    fbstrngfld_pedsPROVINCIA: TFIBStringField;
    fbstrngfld_pedsCP: TFIBStringField;
    fbstrngfld_pedsPAIS: TFIBStringField;
    fbstrngfld_pedsPAIS_ID: TFIBStringField;
    fbdtmfld_pedsFECHA_PED: TFIBDateTimeField;
    fbstrngfld_pedsTELEFONO: TFIBStringField;
    fbstrngfld_pedsEMAIL: TFIBStringField;
    fbntgrfld_pedsDELIVERY_TIME: TFIBIntegerField;
    fbstrngfld_pedsTEXT: TFIBStringField;
    fbdtmfld_pedsFECHA_IMP: TFIBDateTimeField;
    fbdtmfld_pedsFECHA_GEN: TFIBDateTimeField;
    fbdtmfld_pedsFECHA_FIN: TFIBDateTimeField;
    fbstrngfld_pedsESTADO: TFIBStringField;
    fbntgrfld_pedsCODALBARAN: TFIBIntegerField;
    fbstrngfld_pedsOBSERVACIONES: TFIBStringField;
    con1: TADOConnection;
    qrytemp: TADOQuery;
    stpGrabaSrv: TADOStoredProc;
    q_sql5: TADOQuery;
    qryAlbEdit: TADOQuery;
    intgrfldAlbEditcodalbaran: TIntegerField;
    str_AlbEditserie: TStringField;
    dtmfldAlbEditfecha: TDateTimeField;
    intgrfldAlbEditcodcli: TIntegerField;
    intgrfldAlbEditpaquetes: TIntegerField;
    intgrfldAlbEditbultos: TIntegerField;
    bcdfldAlbEditkgs: TBCDField;
    bcdfldAlbEditcodremitente: TBCDField;
    str_AlbEditorg_nombre: TStringField;
    str_AlbEditorg_calle: TStringField;
    str_AlbEditorg_cp: TStringField;
    str_AlbEditorg_localidad: TStringField;
    str_AlbEditorg_provincia: TStringField;
    str_AlbEditorg_persona: TStringField;
    str_AlbEditorg_tfno: TStringField;
    bcdfldAlbEditcoddestinatario: TBCDField;
    str_AlbEditdst_nombre: TStringField;
    str_AlbEditdst_calle: TStringField;
    str_AlbEditdst_cp: TStringField;
    str_AlbEditdst_localidad: TStringField;
    str_AlbEditdst_provincia: TStringField;
    str_AlbEditdst_persona: TStringField;
    str_AlbEditdst_tfno: TStringField;
    bcdfldAlbEditasegurado: TBCDField;
    bcdfldAlbEditpdebido: TBCDField;
    bcdfldAlbEditreembolso: TBCDField;
    intgrfldAlbEditEstado: TIntegerField;
    str_AlbEditColor: TStringField;
    str_AlbEditobservaciones: TStringField;
    smlntfldAlbEditkm: TSmallintField;
    dtmfldAlbEditarchivo: TDateTimeField;
    str_AlbEdite_s_r: TStringField;
    smlntfldAlbEditcodruta: TSmallintField;
    intgrfldAlbEditcodrepartidor: TIntegerField;
    intgrfldAlbEditorg_codcli: TIntegerField;
    intgrfldAlbEditorg_coddel: TIntegerField;
    intgrfldAlbEditdst_codcli: TIntegerField;
    intgrfldAlbEditdst_coddel: TIntegerField;
    bcdfldAlbEditKgsVol: TBCDField;
    q_peds_lines: TpFIBDataSet;
    fbntgrfld_peds_linesID_OXFAM: TFIBIntegerField;
    fbntgrfld_peds_linesID_LINE: TFIBIntegerField;
    fbntgrfld_peds_linesID_ARTICULO: TFIBIntegerField;
    fbntgrfld_peds_linesCANTIDAD: TFIBIntegerField;
    fbstrngfld_peds_linesSKU: TFIBStringField;
    fbstrngfld_peds_linesNOMBRE_ART: TFIBStringField;
    fbntgrfld_peds_linesITEM_ID: TFIBIntegerField;
    fbstrngfld_peds_linesCODIGO: TFIBStringField;
    fbstrngfld_peds_linesNOMBRE: TFIBStringField;
    fbstrngfld_peds_linesCODIGO_CLI: TFIBStringField;
    dsbusqueda: TDataSource;
    busqueda: TpFIBDataSet;
    q_pedsID_REPARTIDOR: TFIBIntegerField;
    q_pedsENVIADO: TFIBStringField;
    q_pedsTRACKING_NUMBER: TFIBStringField;
    cds_bultos: TClientDataSet;
    intgrfld_bultoscodcli: TIntegerField;
    intgrfld_bultoscodalbaran: TIntegerField;
    intgrfld_bultosunidades: TIntegerField;
    dtmfld_bultosfecha: TDateTimeField;
    intgrfld_bultoscodruta: TIntegerField;
    strngfld_bultoscoddst: TStringField;
    strngfld_bultosdst_nombre: TStringField;
    strngfld_bultosdst_calle: TStringField;
    strngfld_bultosdst_cp: TStringField;
    strngfld_bultosdst_localidad: TStringField;
    strngfld_bultosdst_provincia: TStringField;
    intgrfld_bultosbultos: TIntegerField;
    strngfld_bultosobservaciones: TStringField;
    strngfld_bultosdst_tfno: TStringField;
    strngfld_bultosdst_coddel: TStringField;
    strngfld_bultosdst_persona: TStringField;
    intgrfld_bultosordenbulto: TIntegerField;
    intgrfld_bultoscodrepartidor: TIntegerField;
    strngfld_bultosorg_nombre: TStringField;
    strngfld_bultosorg_calle: TStringField;
    strngfld_bultosorg_cp: TStringField;
    strngfld_bultosorg_localidad: TStringField;
    strngfld_bultosorg_tfno: TStringField;
    strngfld_bultosreembolso: TStringField;
    strngfld_bultosreferencia: TStringField;
    strngfld_bultoskgs: TStringField;
    strngfld_bultossempor: TStringField;
    strngfld_bultoschrono_exp: TStringField;
    strngfld_bultoschrono_ref: TStringField;
    strngfld_bultoscodbulto: TStringField;
    strngfld_bultospdf417: TStringField;
    grphcfld_bultoslogo: TGraphicField;
    intgrfld_bultosid_caja: TIntegerField;
    strngfld_bultostipo_caja: TStringField;
    strngfld_bultoscodexpedicion: TStringField;
    cds_bultosorg_provincia: TStringField;
    q_sql2: TADOQuery;
    strngfld_bultosasm_correo: TStringField;
    strngfld_bultosasm_horario: TStringField;
    strngfld_bultosasm_codcli: TStringField;
    strngfld_bultosasm_mnemo: TStringField;
    strngfld_bultosasm_pobla: TStringField;
    strngfld_bultosasm_tracking: TStringField;
    strngfld_bultosasm_bc: TStringField;
    strngfld_bultosasm_bc_human: TStringField;
    q_pedsBULTOS: TFIBIntegerField;
    procedure DataModuleCreate(Sender: TObject);
    procedure dbBeforeConnect(Database: TFIBDatabase; LoginParams: TStrings;
      var DoConnect: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm_oxf: Tdm_oxf;
  firstConnect:Boolean=True;

implementation

uses   u_main;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure Tdm_oxf.DataModuleCreate(Sender: TObject);
begin
  firstconnect:=false;
end;

procedure Tdm_oxf.dbBeforeConnect(Database: TFIBDatabase; LoginParams: TStrings;
  var DoConnect: Boolean);
begin
  if (firstconnect) then begin
    doconnect:=false;
    firstconnect:=false;
  end;
end;

end.
