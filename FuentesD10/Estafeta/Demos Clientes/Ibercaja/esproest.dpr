program esproest;

uses
  EMapWin32,
  Forms,
  u_main in 'u_main.pas' {f_main},
  u_dm in 'u_dm.pas' {dm: TDataModule},
  u_incidencia in 'u_incidencia.pas' {f_incidencia},
  u_destino in 'u_destino.pas' {f_destino},
  u_lectura in 'u_lectura.pas' {f_lectura},
  u_select_del in 'u_select_del.pas' {f_select_del},
  u_lleno in 'u_lleno.pas' {f_lleno},
  u_recall in 'u_recall.pas' {f_recall},
  USendText in 'USendText.pas',
  u_envia_mail in '..\..\..\Repositorio\u_envia_mail.pas' {f_envia_mail},
  ubuscapro in '..\..\..\Repositorio\ubuscapro.pas' {fbuscapro},
  u_gen_gl in '..\..\..\Repositorio\u_gen_gl.pas',
  u_globals in '..\..\..\Repositorio\u_globals.pas',
  UServerUpdate in '..\..\..\Repositorio\ServerUpdate\UServerUpdate.pas';

{$R *.res}

begin
  Application.Initialize;
  CheckActServer(Application.ExeName);
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(Tf_main, f_main);
  Application.CreateForm(Tf_incidencia, f_incidencia);
  Application.CreateForm(Tf_incidencia, f_incidencia);
  Application.CreateForm(Tf_destino, f_destino);
  Application.CreateForm(Tf_lectura, f_lectura);
  Application.CreateForm(Tf_select_del, f_select_del);
  Application.CreateForm(Tf_lleno, f_lleno);
  Application.CreateForm(Tf_recall, f_recall);
  Application.CreateForm(Tf_envia_mail, f_envia_mail);
  Application.CreateForm(Tfbuscapro, fbuscapro);
  Application.Run;
end.
