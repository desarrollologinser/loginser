program demon_nut;

uses
  Vcl.Forms,
  u_main in 'u_main.pas' {f_main},
  u_dm in 'u_dm.pas' {dm: TDataModule},
  u_bakup in 'u_bakup.pas' {f_bakup},
  u_envia_mail in 'u_envia_mail.pas',
  u_globals in 'u_globals.pas',
  u_listados in 'u_listados.pas' {f_listados},
  u_attachment in '..\..\Repositorio\api\u_attachment.pas',
  u_clientes in 'u_clientes.pas' {fClientes},
  u_adjuntos in 'u_adjuntos.pas' {f_adjuntos},
  u_articulos in 'u_articulos.pas' {f_articulos},
  u_controles in 'u_controles.pas' {f_controles};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tf_main, f_main);
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(Tf_bakup, f_bakup);
  Application.CreateForm(Tf_listados, f_listados);
  Application.CreateForm(TfClientes, fClientes);
  Application.CreateForm(Tf_adjuntos, f_adjuntos);
  Application.CreateForm(Tf_articulos, f_articulos);
  Application.CreateForm(Tf_controles, f_controles);
  Application.Run;
end.
