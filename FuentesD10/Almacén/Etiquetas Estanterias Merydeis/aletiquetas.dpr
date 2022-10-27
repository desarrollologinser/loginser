program aletiquetas;

uses
  Forms,
  u_main in 'u_main.pas' {f_main},
  u_dm in 'u_dm.pas' {dm: TDataModule},
  ubuscapro in '..\..\..\Repositorio\ubuscapro.pas' {fbuscapro},
  u_globals in '..\..\..\..\..\v03_Crash_Bandicoot\trunk\00 Sys\00.01 Repositorio\00.01.00 Sys\u_globals.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(Tf_main, f_main);
  Application.CreateForm(Tfbuscapro, fbuscapro);
  Application.Run;
end.
