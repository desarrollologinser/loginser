program demonios;

uses
  Vcl.Forms,
  u_main in 'u_main.pas' {f_main},
  u_dm in 'u_dm.pas' {dm: TDataModule},
  u_backup in 'u_backup.pas' {f_backup},
  u_envia_mail in 'u_envia_mail.pas',
  u_globals in 'u_globals.pas',
  u_attachment in '..\..\Repositorio\api\u_attachment.pas',
  u_dmPargal in '..\..\Repositorio\api\Clientes\Pargal\u_dmPargal.pas' {dmPargal: TDataModule},
  u_env_lotes in 'u_env_lotes.pas',
  u_functions in '..\..\Repositorio\u_functions.pas',
  u_globals_gestoras in '..\..\Repositorio\u_globals_gestoras.pas',
  u_env_estados in 'u_env_estados.pas',
  u_EstadoPedido in '..\..\Repositorio\api\u_EstadoPedido.pas' {dmEstadoPedido: TDataModule},
  u_sync in 'u_sync.pas',
  u_peds_finalizados in 'u_peds_finalizados.pas',
  u_c_ontinyent in 'u_c_ontinyent.pas',
  u_old_web in 'u_old_web.pas',
  USendText in '..\..\Repositorio\USendText.pas',
  UGetText in '..\..\Repositorio\UGetText.pas',
  USendFile in '..\..\Repositorio\USendFile.pas',
  u_dmBiocan in '..\..\Repositorio\api\Clientes\Biocan\u_dmBiocan.pas' {dmBiocan: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tf_main, f_main);
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TdmPargal, dmPargal);
  Application.CreateForm(TdmEstadoPedido, dmEstadoPedido);
  Application.CreateForm(TdmBiocan, dmBiocan);
  Application.Run;
end.
