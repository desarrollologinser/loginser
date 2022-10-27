program alcreubi;

uses
  Forms,
  u_main in 'u_main.pas' {frmMain},
  dialogs,
  UServerUpdate in '..\..\Repositorio\ServerUpdate\UServerUpdate.pas';

{$R *.res}

const
  NombreMutex='alcreubi';

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
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
