program demon_list_bankia;

uses
  Vcl.Forms,
  u_main in 'u_main.pas' {f_main},
  u_dm in 'u_dm.pas' {dm: TDataModule},
  u_listados in 'u_listados.pas' {f_listados},
  u_envia_mail in 'u_envia_mail.pas',
  u_adjuntos in 'u_adjuntos.pas' {f_adjuntos},
  u_attachment in '..\..\Repositorio\api\u_attachment.pas',
  u_globals in 'u_globals.pas',
  u_estados in 'u_estados.pas' {f_estados};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tf_main, f_main);
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(Tf_listados, f_listados);
  Application.CreateForm(Tf_adjuntos, f_adjuntos);
  Application.CreateForm(Tf_estados, f_estados);
  Application.Run;
end.
