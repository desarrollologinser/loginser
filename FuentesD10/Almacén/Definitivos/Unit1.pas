unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Umain, Unit2, Unit4, Unit5, MidasLib, Unit6;

type
  TForm1 = class(TForm)
    mm1: TMainMenu;
    Asignar1: TMenuItem;
    Entregar1: TMenuItem;
    Devol1: TMenuItem;
    Devolver1: TMenuItem;
    Salir1: TMenuItem;
    Sincronizar1: TMenuItem;
    EstadoSolicitudes1: TMenuItem;
    procedure Salir1Click(Sender: TObject);
    procedure Entregar1Click(Sender: TObject);
    procedure Devol1Click(Sender: TObject);
    procedure Devolver1Click(Sender: TObject);
    procedure Sincronizar1Click(Sender: TObject);
    procedure EstadoSolicitudes1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Devol1Click(Sender: TObject);
begin
  //Entregar
  Form2.ShowModal();
end;

procedure TForm1.Devolver1Click(Sender: TObject);
begin
  //Devolver
  Form4.ShowModal();
end;

procedure TForm1.Entregar1Click(Sender: TObject);
begin
  // Asignar
  Form3.ShowModal();
end;

procedure TForm1.EstadoSolicitudes1Click(Sender: TObject);
begin
  Form6.ShowModal();
end;

procedure TForm1.Salir1Click(Sender: TObject);
begin
  Close();
end;

procedure TForm1.Sincronizar1Click(Sender: TObject);
begin
// Sincronizar web
   Form5.ShowModal();
end;

end.
