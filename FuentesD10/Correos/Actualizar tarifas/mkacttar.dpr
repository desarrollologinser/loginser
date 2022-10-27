program mkacttar;

uses
  Vcl.Forms, Dialogs,
  u_main in 'u_main.pas' {f_main},
  UServerUpdate in '..\..\Repositorio\ServerUpdate\UServerUpdate.pas';

Const
    NombreMutex='mkacttar';

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
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tf_main, f_main);
  Application.Run;
end.
