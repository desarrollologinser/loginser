program alpropab;

uses
  Forms,
  ubuscapro in '..\..\Repositorio\ubuscapro.pas' {fbuscapro},
  u_envia_mail in '..\..\Repositorio\u_envia_mail.pas' {f_envia_mail},
  u_gen_gl in '..\..\Repositorio\u_gen_gl.pas',
  u_cam_gl in '..\..\Repositorio\u_cam_gl.pas',
  u_globals in '..\..\Repositorio\u_globals.pas',
  u_LstEtiquetas in '..\..\Repositorio\api\u_LstEtiquetas.pas' {DMLstEtiquetas: TDataModule},
  UServerUpdate in '..\..\Repositorio\ServerUpdate\UServerUpdate.pas',
  u_dm in 'u_dm.pas' {dm: TDataModule},
  u_main in '..\Packing abierto 2.0\u_main.pas' {f_main},
  u_functions in '..\..\Repositorio\u_functions.pas';

{$R *.res}

begin
  Application.Initialize;
  CheckActServer(Application.ExeName);
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Proceso de Packing Abierto';

  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TDMLstEtiquetas, DMLstEtiquetas);
  Application.CreateForm(Tf_envia_mail, f_envia_mail);
  Application.CreateForm(Tfbuscapro, fbuscapro);
  Application.CreateForm(Tf_main, f_main);
  Application.Title := 'Gestión de Almacén';
  Application.Run;
end.
