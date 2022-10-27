program algesdef;

uses
  Vcl.Forms,
  Dialogs,
  u_main in 'u_main.pas' {f_main},
  u_dm in 'u_dm.pas' {dm: TDataModule},
  u_globals in '..\..\Repositorio\u_globals.pas',
  UServerUpdate in '..\..\Repositorio\ServerUpdate\UServerUpdate.pas',
  ubuscapro in '..\..\Repositorio\ubuscapro.pas' {fbuscapro},
  u_login in '..\..\Repositorio\u_login.pas' {frmLogin},
  u_globals_gestoras in '..\..\Repositorio\u_globals_gestoras.pas';

const
  NombreMutex='algesdef';

{$R *.res}

begin
  if ejecutadaYa (NombreMutex) then
  begin
    messagedlg('La aplicación ya está abierta.', mtinformation,
        [mbok],0);
    application.Terminate;
    halt;
    exit;
  end;

  Application.Initialize;
  CheckActServer(Application.ExeName);
  Application.MainFormOnTaskbar := True;
    Application.CreateForm(Tdm, dm);
  Application.CreateForm(Tf_main, f_main);

  Application.CreateForm(Tfbuscapro, fbuscapro);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;
end.
