program alpacabi;

uses
  Vcl.Forms,
  u_main in 'u_main.pas' {form1},
  u_dm in 'u_dm.pas' {dm: TDataModule},
  UServerUpdate in '..\..\Repositorio\ServerUpdate\UServerUpdate.pas',
  u_gen_gl in '..\..\Repositorio\u_gen_gl.pas',
  u_globals in '..\..\Repositorio\u_globals.pas',
  u_envia_mail in '..\..\Repositorio\u_envia_mail.pas' {f_envia_mail},
  u_globals_gestoras in '..\..\Repositorio\u_globals_gestoras.pas',
  ubuscapro in '..\..\Repositorio\ubuscapro.pas' {fbuscapro};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tform1, form1);
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(Tf_envia_mail, f_envia_mail);
  Application.CreateForm(Tfbuscapro, fbuscapro);
  Application.Run;
end.
