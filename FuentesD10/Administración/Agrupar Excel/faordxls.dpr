program faordxls;

uses
  Vcl.Forms,
  Vcl.Dialogs,
  u_main in 'u_main.pas' {f_main},
  UServerUpdate in '..\..\Repositorio\ServerUpdate\UServerUpdate.pas',
  u_globals in '..\..\Repositorio\u_globals.pas',
  u_dm in 'u_dm.pas' {dm: TDataModule};

Const
  NombreMutex='mkconfra';
  Var
  MiMutex:THandle;

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
  Application.CreateForm(Tdm, dm);
  Application.Run;
end.
