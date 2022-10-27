program alprotra;

uses
  Forms,
  u_main in 'u_main.pas' {f_main},
  u_globals in '..\..\Repositorio\u_globals.pas',
  u_dm in 'u_dm.pas' {dm: TDataModule},
  ubuscapro in '..\..\Repositorio\ubuscapro.pas' {fbuscapro},
  u_gen_gl in '..\..\Repositorio\u_gen_gl.pas',
  u_webcam in 'u_webcam.pas' {f_webcam},
  u_lotes in 'u_lotes.pas' {f_lotes},
  u_alm_aux in '..\..\Repositorio\u_alm_aux.pas',
  RestRequest in 'RestRequest.pas',
  UServerUpdate in '..\..\Repositorio\ServerUpdate\UServerUpdate.pas',
  u_LogoCli in '..\..\Repositorio\api\u_LogoCli.pas',
  u_functions in '..\..\Repositorio\u_functions.pas';

{$R *.res}

begin
  Application.Initialize;
  CheckActServer(Application.ExeName);
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Proceso Principal Del Traslado';
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(Tf_main, f_main);
  Application.CreateForm(Tfbuscapro, fbuscapro);
  Application.CreateForm(Tf_webcam, f_webcam);
  Application.CreateForm(Tf_lotes, f_lotes);
  Application.CreateForm(Tf_lotes, f_lotes);
  Application.Run;
end.
