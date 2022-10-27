program esmanval;

uses
  EMapWin32,
  Forms, Dialogs,
  u_main in 'u_main.pas' {f_main},
  u_dm in 'u_dm.pas' {dm: TDataModule},
  u_delegacion in 'u_delegacion.pas' {f_delegacion},
  u_tarjeta in 'u_tarjeta.pas' {f_tarjeta},
  u_envia_mail in '..\..\Repositorio\u_envia_mail.pas' {f_envia_mail},
  ubuscapro in '..\..\Repositorio\ubuscapro.pas' {fbuscapro},
  u_gen_gl in '..\..\Repositorio\u_gen_gl.pas',
  u_globals in '..\..\Repositorio\u_globals.pas',
  UServerUpdate in '..\..\Repositorio\ServerUpdate\UServerUpdate.pas';


{$R *.res}

const
  NombreMutex='esmanval';

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
  Application.CreateForm(Tf_delegacion, f_delegacion);
  Application.CreateForm(Tf_tarjeta, f_tarjeta);
  Application.CreateForm(Tf_tarjeta, f_tarjeta);
  Application.CreateForm(Tf_envia_mail, f_envia_mail);
  Application.CreateForm(Tfbuscapro, fbuscapro);
  Application.Run;
end.
