program alpacabi;

uses
  MidasLib,
  Forms,
  Windows,
  dialogs,
  System.UITypes,
  u_cam_gl in '..\..\Repositorio\u_cam_gl.pas',
  u_functions in '..\..\Repositorio\u_functions.pas',
  u_gen_gl in '..\..\Repositorio\u_gen_gl.pas',
  u_globals in '..\..\Repositorio\u_globals.pas',
  u_globals_gestoras in '..\..\Repositorio\u_globals_gestoras.pas',
  UServerUpdate in '..\..\Repositorio\ServerUpdate\UServerUpdate.pas',
  u_AlbaranValidate in '..\..\Repositorio\api\u_AlbaranValidate.pas',
  UGetText in 'UGetText.pas',
  u_picking in '..\..\Repositorio\u_picking.pas' {dm_pick: TDataModule},
  ubuscapro in '..\..\Repositorio\ubuscapro.pas' {fbuscapro},
  u_dmLabels in '..\..\Repositorio\u_dmLabels.pas' {dmLabels: TDataModule},
  u_LstEtiquetas in '..\..\Repositorio\api\u_LstEtiquetas.pas' {DMLstEtiquetas: TDataModule},
  UDMCreaBultos in '..\..\Repositorio\api\UDMCreaBultos.pas' {DMCreaBultos: TDataModule},
  u_login in '..\..\Repositorio\u_login.pas' {frmLogin},
  u_DescargaAttach in '..\..\Repositorio\api\u_DescargaAttach.pas' {dmDescargaAttach: TDataModule},
  u_lotes in '..\..\Repositorio\u_lotes.pas' {frmLotes},
  u_dmPargal in '..\..\Repositorio\api\Clientes\Pargal\u_dmPargal.pas' {dmPargal: TDataModule},
  u_envia_mail in '..\..\Repositorio\u_envia_mail.pas' {f_envia_mail},
  u_main in 'u_main.pas' {f_main},
  u_dm in 'u_dm.pas' {dm: TDataModule};

Const
NombreMutex='alpacabi';

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
  Application.Title := 'Gestión de Almacén';

  Application.CreateForm(TdmLabels, dmLabels);
  Application.CreateForm(Tdm_pick, dm_pick);
  Application.CreateForm(TDMCreaBultos, DMCreaBultos);
  Application.CreateForm(TDMLstEtiquetas, DMLstEtiquetas);
  Application.CreateForm(TdmDescargaAttach, dmDescargaAttach);
  Application.CreateForm(TdmPargal, dmPargal);
  Application.CreateForm(Tdm, dm);
  //Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(Tf_main, f_main);
  Application.CreateForm(TfrmLotes, frmLotes);
  Application.CreateForm(Tf_envia_mail, f_envia_mail);
    Application.CreateForm(Tfbuscapro, fbuscapro);
  Application.Run;
  {Si da error de access violation al arrancar sacar el u_dm del proyecto
   y volver a meterlo}


  {Application.Initialize;
  CheckActServer(Application.ExeName);
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Gestión de Almacén';


  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TdmLabels, dmLabels);
  Application.CreateForm(Tdm_pick, dm_pick);
  Application.CreateForm(TDMCreaBultos, DMCreaBultos);
  Application.CreateForm(TDMLstEtiquetas, DMLstEtiquetas);
  Application.CreateForm(TdmDescargaAttach, dmDescargaAttach);
  Application.CreateForm(Tf_main, f_main);
  Application.CreateForm(TdmPargal, dmPargal);
  Application.CreateForm(Tf_envia_mail, f_envia_mail);
   Application.CreateForm(TfrmLotes, frmLotes);
  Application.CreateForm(Tfbuscapro, fbuscapro);
  //Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;
  }end.
