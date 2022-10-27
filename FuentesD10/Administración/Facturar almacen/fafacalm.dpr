program fafacalm;

uses
  Vcl.Forms,
  u_dm in 'u_dm.pas' {dm: TDataModule},
  u_main in 'u_main.pas' {Main},
  u_globals in '..\..\Repositorio\u_globals.pas',
  ubuscapro in '..\..\Repositorio\ubuscapro.pas' {fbuscapro},
  UServerUpdate in '..\..\Repositorio\ServerUpdate\UServerUpdate.pas';

{$R *.res}

begin
  Application.Initialize;
  CheckActServer(Application.ExeName);
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TMain, Main);
  Application.CreateForm(Tfbuscapro, fbuscapro);
  Application.Run;
end.
