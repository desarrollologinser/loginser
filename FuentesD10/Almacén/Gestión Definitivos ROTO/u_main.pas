unit u_main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,  FIBDataSet, pFIBDataSet, FIBQuery, pFIBQuery, FIBDatabase,
  pFIBDatabase, sLabel, Vcl.StdCtrls, sEdit, Vcl.Buttons, sSpeedButton,
  Vcl.ExtCtrls, sPanel;

type

TDatosPC   = record
    Nombre, IP, Usuario :String;
  end;

   TDatosUsuario  = record
    id: Integer;
    Nombre :String;
  end;

  Tf_main = class(TForm)
    s1: TStatusBar;
    sPanel1: TsPanel;
    btClientes: TsSpeedButton;
    lb1: TLabel;
    edCliente: TsEdit;
    lbCliente: TsLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btClientesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_main: Tf_main;
  PC: TDatosPC;
  usuario: TDatosUsuario;

const
  ALERTA = 'LISTO';
  {Listo: puede crearse exe
   Vacio: hay algo en desarrollo y no se puede crear exe}

  v = '[-1]';

implementation

uses
  u_globals, u_globals_gestoras, u_login, u_dm, ubuscapro;

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
    from := 'g_clientes cl, g_clientes_config_ cf ';
    where := 'cl.id_cliente=cf.id_cliente and cf.tiene_definitivos=''1''';
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

 // btLock.Enabled := (lbGrupo.Caption <> '(Seleccione un grupo de clientes)');
end;

procedure Tf_main.FormActivate(Sender: TObject);
var
  flog: TfrmLogin;
begin

end;

procedure Tf_main.FormCreate(Sender: TObject);
begin
   Caption := 'Gestión de Definitivos ' + v;

   if (ALERTA<>'LISTO') then
      ShowMessage('CUIDADO!!!!! PROYECTO EN DESARROLLO!!!! AVISA A INFORMATICA!!!');

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
  //lee_inis_def;
  {if db_sql<>'' then
  begin
     // dm.con1.Connected := False;
      dm.con1.ConnectionString := db_sql;
      //dm.con1.Connected := True;
  end; }

  //get_defaults;

  leer_ini_bbdd(u_globals.id_usuario);

  PC.Nombre := GetComputerName;
  PC.IP := LocalIP;
  PC.Usuario := obtenerUsuarioRed;
  usuario.id := -1;
  usuario.Nombre := 'Usuario Desconocido';

end;

procedure Tf_main.FormShow(Sender: TObject);
var
  flog: TfrmLogin;
begin


  s1.Panels[0].Text := dbname + ' ** ' +
                   db_gestoras + ' ** ' +
                   api;


 { try
    flog := TfrmLogin.Create(Self);
    //flog.edUsuario.Text := u_globals.usuario_nom;
    //flog.Position := poDesktopCenter;
    flog.ShowModal;
  finally
    flog.Free;
  end;

  if usuario.id=-1 then
        Close;    }

  u_globals.usuario_nom := usuario.Nombre;

  f_main.Caption := 'Gestión de Definitivos ' + v + ' - ' + IntToStr(usuario.id) + ' ' + usuario.Nombre ;
end;

end.
