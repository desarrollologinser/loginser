unit u_lleno;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, sSpeedButton, Vcl.StdCtrls,
  sGroupBox;

type
  Tf_lleno = class(TForm)
    gb_1: TsGroupBox;
    bt_lleno: TsSpeedButton;
    bt_vacio: TsSpeedButton;
    procedure bt_llenoClick(Sender: TObject);
    procedure bt_vacioClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    lleno:SmallInt;
  end;

var
  f_lleno: Tf_lleno;

implementation

{$R *.dfm}

procedure Tf_lleno.bt_llenoClick(Sender: TObject);
begin
  lleno:=1;
  close;
end;

procedure Tf_lleno.bt_vacioClick(Sender: TObject);
begin
  lleno:=0;
  close;
end;

end.
