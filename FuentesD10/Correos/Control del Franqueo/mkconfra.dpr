program mkconfra;

uses
  Vcl.Forms,
  Vcl.Dialogs,
  u_dm in 'u_dm.pas' {dm: TDataModule},
  u_main in 'u_main.pas' {f_main},
  u_envia_mail in '..\..\Repositorio\u_envia_mail.pas' {f_envia_mail},
  ubuscapro in '..\..\Repositorio\ubuscapro.pas' {fbuscapro},
  ubuscapro_ss in '..\..\Repositorio\ubuscapro_ss.pas' {fbuscapro_ss},
  u_globals in '..\..\Repositorio\u_globals.pas',
  u_hashes in '..\..\Repositorio\u_hashes.pas',
  UServerUpdate in '..\..\Repositorio\ServerUpdate\UServerUpdate.pas',
  u_globals_gestoras in '..\..\Repositorio\u_globals_gestoras.pas',
  u_gen_gl in '..\..\Repositorio\u_gen_gl.pas',
  ubuscapro_gest in '..\..\Repositorio\ubuscapro_gest.pas' {fbuscapro_gest},
  u_cam_gl in '..\..\Repositorio\u_cam_gl.pas',
  u_LstEtiquetas in '..\..\Repositorio\api\u_LstEtiquetas.pas' {DMLstEtiquetas: TDataModule},
  u_AlbaranValidate in '..\..\Repositorio\api\u_AlbaranValidate.pas',
  u_functions in '..\..\Repositorio\u_functions.pas',
  UDMCreaBultos in '..\..\Repositorio\api\UDMCreaBultos.pas' {DMCreaBultos: TDataModule};

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
  CheckActServer(Application.ExeName);
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Control de Franqueo';
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(Tf_main, f_main);
  Application.CreateForm(Tf_envia_mail, f_envia_mail);
  Application.CreateForm(Tfbuscapro, fbuscapro);
  Application.CreateForm(Tfbuscapro_ss, fbuscapro_ss);
  Application.CreateForm(Tfbuscapro_gest, fbuscapro_gest);
  Application.CreateForm(TDMLstEtiquetas, DMLstEtiquetas);
  Application.CreateForm(TDMCreaBultos, DMCreaBultos);
  Application.Run;
end.
