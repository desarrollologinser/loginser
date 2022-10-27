unit u_dm;

interface

uses
  SysUtils, Classes, DB, pFIBDataSet, pFIBDatabase,ADODB, DBClient, pFIBQuery,
  FIBQuery, FIBDataSet, FIBDatabase, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg,
  dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns,
  dxPSEdgePatterns, dxPSPDFExportCore, dxPSPDFExport, cxDrawTextUtils,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinOffice2016Colorful,
  dxSkinOffice2016Dark, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, dxPSPrVwStd, dxPSPrVwAdv, dxPSPrVwRibbon,
  dxPScxPageControlProducer, dxPSdxPDFViewerLnk, dxPScxEditorProducers,
  dxPScxExtEditorProducers, dxPSCore, cxClasses;

type
  Tdm = class(TDataModule)
    db: TpFIBDatabase;
    t_read: TpFIBTransaction;
    t_write: TpFIBTransaction;
    busqueda: TpFIBDataSet;
    dsbusqueda: TDataSource;
    q_pack: TpFIBDataSet;
    ds_pack: TDataSource;
    q_packagr: TpFIBDataSet;
    ds_packagr: TDataSource;
    q_fib: TpFIBDataSet;
    q_fib2: TpFIBDataSet;
    q_pack_leido: TpFIBDataSet;
    ds_pack_leido: TDataSource;
    qu_1: TpFIBQuery;
    q_etiq_indiv: TpFIBDataSet;
    q_etiq_bulto: TpFIBDataSet;
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
    con1: TADOConnection;
    q_hoja_pick: TpFIBDataSet;
    intgrfld_bultosid_caja: TIntegerField;
    strngfld_bultostipo_caja: TStringField;
    strngfld_bultoscodexpedicion: TStringField;
    cds_bultosorg_provincia: TStringField;
    qry_sql2: TADOQuery;
    qrytemp: TADOQuery;
    strngfld_bultosasm_correo: TStringField;
    strngfld_bultosasm_codcli: TStringField;
    strngfld_bultosasm_horario: TStringField;
    strngfld_bultosasm_mnemo: TStringField;
    strngfld_bultosasm_pobla: TStringField;
    strngfld_bultosasm_bc_human: TStringField;
    strngfld_bultosasm_tracking: TStringField;
    strngfld_bultosasm_bc: TStringField;
    qDHL: TpFIBDataSet;
    qu_dhl: TpFIBQuery;
    strngfld_bultosdst_pais: TStringField;
    q_aux: TpFIBDataSet;
    qry_kgs: TpFIBDataSet;
    q_DHL_PAISES: TpFIBDataSet;
    qry_tmp: TpFIBDataSet;
    qry_sql3: TpFIBDataSet;
    strngfld_bultosawb: TStringField;
    intgrfld_bultosaduana: TIntegerField;
    qry_Traduccion: TpFIBDataSet;
    qry_EtiquetaNec: TpFIBDataSet;
    intgrfld_bultoscodalbeti: TIntegerField;
    qRemPor: TpFIBDataSet;
    xEtiquetas: TpFIBDataSet;
    xEtiquetasUSUARIO: TFIBIntegerField;
    xEtiquetasID_ALBARAN: TFIBIntegerField;
    xAlbaran: TpFIBDataSet;
    xAlbaranBULTOS: TFIBSmallIntField;
    xAlbaranPESO: TFIBFloatField;
    xBultos: TpFIBDataSet;
    xBultosBULTOS: TFIBIntegerField;
    xSigBulto: TpFIBDataSet;
    xSigBultoMAX_BULTO: TFIBSmallIntField;
    xPedidoLines: TpFIBDataSet;
    xPedidoLinesID_ARTICULO: TFIBIntegerField;
    xPedidoLinesCANTIDAD: TFIBIntegerField;
    xPedidoLinesKGS: TFIBFloatField;
    xPedidoLinesNOMBRE_ART: TFIBStringField;
    xPedidoLinesIMEI: TFIBWideStringField;
    dxcmpntprntrdxprinter: TdxComponentPrinter;
    dxpdfvwrprtlnkdxcmpntprntrdxprinterlink: TdxPDFViewerReportLink;
    q_1: TpFIBQuery;
    procedure cds_bultosCalcFields(DataSet: TDataSet);
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

{$R *.dfm}

procedure Tdm.cds_bultosCalcFields(DataSet: TDataSet);
begin
 if cds_bultos.FieldByName('codrepartidor').asinteger = 46360 then //Correos
    begin
       with tpfibdataset.Create(dm) do                            //Codigo expedicion
        try
          database:=dm.db;


          Close;
          SQLs.SelectSQL.Clear;
          SQLs.SelectSQL.Add('select CODEXPEDICION from CORREOS_CODEXPEDICION(:codalbaran)');
          ParamByName('codalbaran').asstring:=cds_bultos.FieldByName('codalbaran').asstring;
          Open;


          if not(IsEmpty) then begin
            dm.cds_bultos.FieldByName('codexpedicion').asstring:=FieldByName('codexpedicion').asstring;
          end;

        finally
          free;
        end;

    end;
end;

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  firstconnect:=false;
end;

procedure Tdm.dbBeforeConnect(Database: TFIBDatabase; LoginParams: TStrings;
  var DoConnect: Boolean);
begin
  if (firstconnect) then begin
    doconnect:=false;
    firstconnect:=false;
  end;
end;

end.


