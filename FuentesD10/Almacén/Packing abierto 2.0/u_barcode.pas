unit u_barcode;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sEdit;

type
  Tf_barcode = class(TForm)
    ed_cb: TsEdit;
    procedure ed_cbKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_barcode: Tf_barcode;

implementation

uses
    u_main;

{$R *.dfm}

procedure Tf_barcode.ed_cbKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=13 then
  begin
    u_main.barcode:= StrToIntDef(ed_cb.Text,-1);
    Close;
  end;
end;

procedure Tf_barcode.FormShow(Sender: TObject);
begin
  ed_cb.SetFocus;
end;

end.
