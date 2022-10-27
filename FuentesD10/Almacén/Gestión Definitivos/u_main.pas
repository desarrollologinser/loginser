unit u_main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sEdit, sLabel,
  Vcl.Buttons, sSpeedButton, Vcl.ExtCtrls, sPanel, pFIBDataSet, dxGDIPlusClasses,
  acImage, sDBNavigator, sComboBox, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinOffice2016Colorful, dxSkinOffice2016Dark,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid;

type

    TDatosPC   = record
    Nombre, IP, Usuario :String;
  end;

   TDatosUsuario  = record
    id: Integer;
    Nombre :String;
  end;

  Tf_main = class(TForm)
    pnCliente: TsPanel;
    lbCliente: TsLabel;
    edCliente: TsEdit;
    sPanel2: TsPanel;
    sImage1: TsImage;
    sPanel1: TsPanel;
    sImage2: TsImage;
    lbCaja: TLabel;
    lb2: TLabel;
    img2: TImage;
    lb3: TLabel;
    cbSeries: TsComboBox;
    sDBNavigator3: TsDBNavigator;
    grCajasDBTableView1: TcxGridDBTableView;
    grCajasLevel1: TcxGridLevel;
    grCajas: TcxGrid;
    grDefs: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    btCreaCaja: TsSpeedButton;
    btDelCaja: TsSpeedButton;
    btEditCaja: TsSpeedButton;
    btCreaDef: TsSpeedButton;
    btDelDef: TsSpeedButton;
    btEditDef: TsSpeedButton;
    btClientes: TsSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure btClientesClick(Sender: TObject);
    procedure edClienteChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure img1Click(Sender: TObject);
  private
    { Private declarations }
    procedure RellenaSeriesDoc;
  public
    { Public declarations }
  end;

var
  f_main: Tf_main;
  usuario: TDatosUsuario;
  PChar: TDatosPC;

const

  v = '[-1]';

implementation

uses
  u_dm, u_globals, ubuscapro, u_globals_gestoras, u_login;

{$R *.dfm}

procedure Tf_main.btClientesClick(Sender: TObject);
begin
    with fbuscapro do
  begin
    limpia_fields;
    multiselect := false;
    livekey := false;
    fields.commatext := 'cl.id_cliente,cl.nombre';
    titulos.commatext := 'Código,Nombre';
    from := 'g_clientes cl, g_clientes_config_ c ';
    where := 'cl.id_cliente=c.id_cliente and c.item=''tiene_definitivos'' and c.valor=''1''';
    orden[1] := 1;
    busca := 2;
    distinct := 0;
    fillimpio := True;
    row_height := 17;

    showmodal;

    if resultado then
    begin
      with Sender as TsSpeedButton do
      begin
        edCliente.text := valor[1];
        lbCliente.caption := UpperCase(valor[2]);
        //filter;
      end;
    end;
  end;
end;

procedure Tf_main.edClienteChange(Sender: TObject);
begin
  with tpfibdataset.Create(dm) do
  begin
    database := dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select nombre from g_clientes cl, g_clientes_config_ c ' +
                       'where cl.id_cliente=:id and cl.id_cliente=c.id_cliente and c.item=''tiene_definitivos'' and c.valor=''1''');
    ParambyName('id').AsInteger := StrToIntDef(edCliente.Text,-1);
    Open;

    if not (IsEmpty) then
    begin
      lbCliente.caption := FieldByName('nombre').asstring;
      edCliente.Color := clWhite;
      RellenaSeriesDoc;
    end
    else begin
      lbCliente.caption := '';
      edCliente.Color := clred;
    end;

    Free;
  end;
end;

procedure Tf_main.FormCreate(Sender: TObject);
begin
  leer_ini;

  imp_def := u_globals.imp_def;
  imp_eti := u_globals.imp_eti;

  if u_globals.x<0 then u_globals.x:=(Screen.width-width) div 2;
  if u_globals.y<0 then u_globals.y:=(Screen.height-height) div 2;
  left:=u_globals.x;                                          //asigna posicion
  top:=u_globals.y;


  leer_ini_gestoras;
  ini_bd_simple;
  ini_bd_gestoras;

end;

procedure Tf_main.FormShow(Sender: TObject);
var
  flog: TfrmLogin;
begin
  //leer_ini;

  //leer_ini_gestoras;

 { try
    flog := TfrmLogin.Create(Self);
    flog.edUsuario.Text := u_globals.usuario_nom;
    flog.Position := poDesktopCenter;
    flog.ShowModal;
    flog.Free;
  except
    flog.Free;
  end;

  if usuario.id=-1 then
        Close;    }

  u_globals.usuario_nom := usuario.Nombre;

   Caption := 'Gestión de Definitivos ' + v + ' - ' + IntToStr(usuario.id) + ' ' + usuario.Nombre ;
end;

procedure Tf_main.img1Click(Sender: TObject);
begin
      with fbuscapro do
  begin
    limpia_fields;
    multiselect := false;
    livekey := false;
    fields.commatext := 'cl.id_cliente,cl.nombre';
    titulos.commatext := 'Código,Nombre';
    from := 'g_clientes cl, g_clientes_config_ c ';
    where := 'cl.id_cliente=c.id_cliente and c.item=''tiene_definitivos'' and c.valor=''1''';
    orden[1] := 1;
    busca := 2;
    distinct := 0;
    fillimpio := True;
    row_height := 17;

    showmodal;

    if resultado then
    begin
        edCliente.text := valor[1];
        lbCliente.caption := UpperCase(valor[2]);
        //filter;
    end;
  end;
end;

procedure Tf_main.RellenaSeriesDoc;
begin

end;
end.
