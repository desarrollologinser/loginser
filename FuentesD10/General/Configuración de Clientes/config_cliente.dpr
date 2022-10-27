program config_cliente;

uses
  Vcl.Forms,
  u_main in 'u_main.pas' {Form1},
  u_dm in 'u_dm.pas' {dm: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(Tdm, dm);
  Application.Run;
end.
