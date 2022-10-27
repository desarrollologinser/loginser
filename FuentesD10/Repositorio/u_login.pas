unit u_login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sButton, sEdit,
  dxGDIPlusClasses, Vcl.ExtCtrls, pFIBDataSet, System.StrUtils;

type
  TfrmLogin = class(TForm)
    img1: TImage;
    edUsuario: TsEdit;
    edtPass: TsEdit;
    btAceptar: TsButton;
    sButton2: TsButton;
    lb1: TLabel;
    lb2: TLabel;
    procedure sButton2Click(Sender: TObject);
    procedure edtPassKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btAceptarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function UsuarioValido:Integer;

  end;

var
  frmLogin: TfrmLogin;

  pass: string;
  intento: Integer;

implementation

uses
  u_dm, u_main;

{$R *.dfm}

procedure TfrmLogin.edtPassKeyPress(Sender: TObject; var Key: Char);
begin

  if key = #13  then
      btAceptarClick(Self)
  else
      pass := pass + Char(Key);

  //edtPass.Text := edtPass.Text + Char(Key);
  {edtPass.Text := '';
  edtPass.Text := DupeString('*', Length(UTF8ToString(pass))); }
end;

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action:=caFree;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  pass := '';
  edtPass.Text := '';
  intento := 1;
  lb2.Visible := False;
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin

  if edUsuario.Text='' then
     edUsuario.SetFocus
  else
      edtPass.SetFocus;
end;

function TfrmLogin.UsuarioValido:integer;
var
   clave:string;
begin

  result := -1;

  if ((edUsuario.Text='') or (edtPass.Text='')) then
  begin
     Exit;
  end;

  //with TpFIBDataSet.Create(self) do
  with dm.q_usuario do
  try
    Close;
    Database:=dm.db_gestoras;
    sqls.SelectSQL.Clear;
    sqls.SelectSQL.Add('SELECT * from SYS_USUARIOS where nombre=:nombre');
    ParamByName('nombre').AsString := edUsuario.Text;
    Open;
    clave:= FieldByName('clave').AsString;

    if clave=pass then
       result := fieldbyName('usuario').asinteger;
  finally
    //free;
  end;

end;

procedure TfrmLogin.btAceptarClick(Sender: TObject);
begin
   if ((edUsuario.Text='') or (edtPass.Text='')) then
  begin
    ShowMessage('Revise usuario y/o contraseña.');
    edtPass.SetFocus;
    Exit;
  end;

 u_main.usuario.id := UsuarioValido;

 if (intento<3) and (u_main.usuario.id=-1) then
 begin
     u_main.usuario.id := UsuarioValido;
     Inc(intento);
     if intento<=3 then
          lb1.Caption := 'Intento ' + IntToStr(intento) + '/3';
     lb2.Visible := (u_main.usuario.id=-1);
     pass := '';
     edtPass.Text := '';
     edtPass.SetFocus;
 end else if (u_main.usuario.id>-1) and  (u_main.usuario.Nombre<>edUsuario.Text) then
          begin
                  u_main.usuario.Nombre := edUsuario.Text;
                  close;
          end
          else
                  Close;
end;

procedure TfrmLogin.sButton2Click(Sender: TObject);
begin
   Close;
end;

end.
