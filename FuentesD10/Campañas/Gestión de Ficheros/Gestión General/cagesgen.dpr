program cagesgen;

uses
  MidasLib,
  Forms,
  u_main in 'u_main.pas' {f_main},
  u_dm in 'u_dm.pas' {dm: TDataModule},
  UGetText in 'UGetText.pas',
  u_detail in 'u_detail.pas' {f_detail},
  u_correos in 'u_correos.pas',
  u_devos in 'u_devos.pas' {frmDevos},
  u_orders in 'u_orders.pas',
  u_privalia in 'u_privalia.pas',
  USendText in 'USendText.pas',
  Windows,
  dialogs,
  System.UITypes,
  u_arts_relaciones in 'u_arts_relaciones.pas' {f_arts_relaciones},
  UServerUpdate in '..\..\..\Repositorio\ServerUpdate\UServerUpdate.pas',
  u_AlbaranValidate in '..\..\..\Repositorio\api\u_AlbaranValidate.pas',
  u_LogoCli in '..\..\..\Repositorio\api\u_LogoCli.pas',
  u_UpdatePedido in '..\..\..\Repositorio\api\u_UpdatePedido.pas' {dmUpdatePedido: TDataModule},
  UDMCreaBultos in '..\..\..\Repositorio\api\UDMCreaBultos.pas' {DMCreaBultos: TDataModule},
  u_cam_gl in '..\..\..\Repositorio\u_cam_gl.pas',
  u_envia_mail in '..\..\..\Repositorio\u_envia_mail.pas' {f_envia_mail},
  u_functions in '..\..\..\Repositorio\u_functions.pas',
  u_gen_gl in '..\..\..\Repositorio\u_gen_gl.pas',
  u_globals in '..\..\..\Repositorio\u_globals.pas',
  u_globals_gestoras in '..\..\..\Repositorio\u_globals_gestoras.pas',
  ubuscapro in '..\..\..\Repositorio\ubuscapro.pas' {fbuscapro},
  Documento in 'Documento.pas',
  u_muzybar in 'u_muzybar.pas',
  u_LstEtiquetas in '..\..\..\Repositorio\api\u_LstEtiquetas.pas' {DMLstEtiquetas: TDataModule},
  u_ftp in 'u_ftp.pas',
  u_seur in 'u_seur.pas',
  u_pedidos in 'u_pedidos.pas',
  u_llaves in 'u_llaves.pas' {f_llaves},
  u_picking in '..\..\..\Repositorio\u_picking.pas' {dm_pick: TDataModule},
  u_CreateExpedicion in '..\..\..\Repositorio\api\u_CreateExpedicion.pas' {dmCreateExpedicion: TDataModule},
  u_login in '..\..\..\Repositorio\u_login.pas' {frmLogin},
  u_dmLabels in '..\..\..\Repositorio\u_dmLabels.pas' {dmLabels: TDataModule},
  u_cli_config in '..\..\..\Repositorio\u_cli_config.pas' {fCliConfig},
  u_flams in 'u_flams.pas' {dm_flam: TDataModule},
  u_dmPargal in '..\..\..\Repositorio\api\Clientes\Pargal\u_dmPargal.pas' {dmPargal: TDataModule},
  u_lotes in '..\..\..\Repositorio\u_lotes.pas' {frmLotes},
  Vcl.Themes,
  Vcl.Styles,
  u_DescargaAttach in '..\..\..\Repositorio\api\u_DescargaAttach.pas' {dmDescargaAttach: TDataModule},
  u_EstadoPedido in '..\..\..\Repositorio\api\u_EstadoPedido.pas' {dmEstadoPedido: TDataModule},
  u_ontinyent in 'u_ontinyent.pas',
  UGetText_ontinyent in 'UGetText_ontinyent.pas',
  USendText_ontinyent in 'USendText_ontinyent.pas';

Const
NombreMutex='cagesgen_10';

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
  Application.CreateForm(TdmCreateExpedicion, dmCreateExpedicion);
  Application.CreateForm(TdmUpdatePedido, dmUpdatePedido);
  Application.CreateForm(Tdm_pick, dm_pick);
  Application.CreateForm(Tf_main, f_main);
  Application.CreateForm(Tf_arts_relaciones, f_arts_relaciones);
  Application.CreateForm(TDMCreaBultos, DMCreaBultos);
  Application.CreateForm(TDMLstEtiquetas, DMLstEtiquetas);
  Application.CreateForm(Tfbuscapro, fbuscapro);
  Application.CreateForm(Tf_detail, f_detail);
  Application.CreateForm(TdmLabels, dmLabels);
  Application.CreateForm(TfCliConfig, fCliConfig);
  Application.CreateForm(Tdm_flam, dm_flam);
  Application.CreateForm(TdmPargal, dmPargal);
  Application.CreateForm(TfrmLotes, frmLotes);
  Application.CreateForm(TfrmDevos, frmDevos);
  Application.CreateForm(Tf_envia_mail, f_envia_mail);
  Application.CreateForm(TdmDescargaAttach, dmDescargaAttach);
  Application.CreateForm(TdmDescargaAttach, dmDescargaAttach);
  Application.CreateForm(TdmEstadoPedido, dmEstadoPedido);
  Application.Title := 'Gestión de Almacén';
  Application.Run;
end.
