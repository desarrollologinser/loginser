program camanart;

uses
  Forms,
  SysUtils,
  Dialogs,
  U_main in 'U_main.pas' {f_main},
  u_dm in 'u_dm.pas' {dm: TDataModule},
  UServerUpdate in '..\..\Repositorio\ServerUpdate\UServerUpdate.pas',
  u_LogoCli in '..\..\Repositorio\api\u_LogoCli.pas',
  ubuscapro in '..\..\Repositorio\ubuscapro.pas' {fbuscapro},
  u_alm_aux in '..\..\Repositorio\u_alm_aux.pas',
  u_functions in '..\..\Repositorio\u_functions.pas',
  u_globals in '..\..\Repositorio\u_globals.pas',
  u_gen_gl in '..\..\Repositorio\u_gen_gl.pas';

const
  NombreMutex = 'camanart';
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
  Application.Title:=u_globals.hint;
  Application.Run;
end.
