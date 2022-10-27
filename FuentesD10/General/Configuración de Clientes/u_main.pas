unit u_main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    btn1: TButton;
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  u_dm;

procedure TForm1.btn1Click(Sender: TObject);
var
  i, x, y:Integer;

  lbl: TLabel;
  ed: TEdit;
begin
  with dm.spGetClienteConfig do
  begin
     close;
     ParamByName('id_cliente').AsInteger := 66;
     ExecProc;


     x := 240;
     y := 45;
     for I := 0 to FieldCount-1 do
     begin
         if fields[i].Name<>'' then
         begin
          lbl := TLabel.Create(nil);
          lbl.Parent := Self;
          lbl.Name := 'lbl'+Fields[i].Name;
          lbl.Caption := lbl.name;

          y := y + 20;
          lbl.Top := y ;
          lbl.Left := x;
          lbl.Width :=  200;
          lbl.Height := 30;

          ed := TEdit.Create(nil);
          ed.Parent := Self;
          ed.Name := 'ed'+Fields[i].Name;

          if VarToStr(fields[i].value)<>'' then
                    ed.text:= fields[i].Value;
          ed.Top := y ;
          ed.Left := x+100;
          ed.Width :=  200;
          ed.Height := 30;

          //lbl.Free;
         end;
     end;


  end;
end;

end.
