program algesdef_roto;

uses
  Winapi.Windows,
  Vcl.Forms,
  dialogs,
  System.UITypes,
  UServerUpdate in '..\..\Repositorio\ServerUpdate\UServerUpdate.pas',
  u_dm in 'u_dm.pas' {dm: TDataModule},
  u_main in 'u_main.pas' {f_main},
  u_globals in '..\..\Repositorio\u_globals.pas',
  u_globals_gestoras in '..\..\Repositorio\u_globals_gestoras.pas',
  u_login in '..\..\Repositorio\u_login.pas' {frmLogin},
  ubuscapro in '..\..\Repositorio\ubuscapro.pas' {fbuscapro};

{$R *.res}

const
  NombreMutex='algesdef_roto';

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
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(Tf_main, f_main);

  Application.CreateForm(Tfbuscapro, fbuscapro);
  Application.Run;
end.
