unit u_bakup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, sButton, IB_Services,inifiles,FlexCompress,jclfileutils;

type
  Tf_bakup = class(TForm)
    bt_2: TButton;
    ed_1: TEdit;
    lbl_1: TLabel;
    me_1: TMemo;
    lbl_2: TLabel;
    procedure bt_2Click(Sender: TObject);
    procedure leer_bakup_ini(idx:Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure lanza_bakup(idx:Integer; verbose:boolean);
  end;

var
  f_bakup: Tf_bakup;
  server_name,db_name,bakupdir,bakupdir_rem,email:string;

implementation

uses u_globals, u_envia_mail, u_main;

{$R *.dfm}

procedure Tf_bakup.bt_2Click(Sender: TObject);
begin
  f_main.tm_1.Enabled:=false;
  lanza_bakup(StrToInt(ed_1.text),true);
  f_main.tm_1.Enabled:=true;
end;

procedure Tf_bakup.lanza_bakup(idx:Integer; verbose:boolean);
var   err,err_compress:boolean;   memo:tstrings;   bakupfilename:string;
begin
  leer_bakup_ini(idx);

  memo:=TStringList.Create;
  memo.Clear;

  with TpFIBBackupService.Create(nil) do try                     //crea el FBK
    ServerName:=server_name;
    DatabaseName:=db_name;
    //libname:=u_globals.libname;
    Protocol:=TCP;

    params.Clear;
    params.Add('user_name=SYSDBA');
    params.Add('password=masterkey');
    LoginPrompt:=false;

    BackupFile.Clear;
    bakupfilename:=db_name+'_'+formatdatetime('yymmdd_hhnnss',now);
    BackupFile.Add(bakupdir+bakupfilename+'.fbk');

    active:=true;
    Verbose:=true;
    servicestart;
    while not Eof do memo.Add(GetNextLine);
    Active:=False;
  finally
    Free;
  end;

  err_compress:=False;                                        //Comprime FBK a FXC
  with TFlexCompress.create(nil) do
  try
    try
      FileName:=bakupdir+bakupfilename+'.fxc';
      OpenArchive(fmCreate);
      BaseDir:=bakupdir;
      AddFiles(bakupfilename+'.fbk');
      CloseArchive;
    except
      err_compress:=true;
    end;
  finally
    free;
  end;

  if not(err_compress) then DeleteFile(bakupdir+bakupfilename+'.fbk');            //Borra FBK

  FileCopy(bakupdir+bakupfilename+'.fxc',bakupdir_rem+bakupfilename+'.fxc',true); //Copia el backup al dir remoto

  if pos('closing file, committing, and finishing',LowerCase(memo.text))=0 then err:=true   //Ha finalizado correctamente
    else err:=false;   //se ha producido un error

  try
    if email<>'' then u_envia_mail.envia_email(1,email,memo.text,server_name+':'+db_name,err);
  finally

  end;

  if verbose then begin
    me_1.Clear;
    me_1.Text:=memo.Text;
  end;
  memo.Free;

  if verbose then ShowMessage('Finished');
end;

procedure Tf_bakup.leer_bakup_ini(idx:Integer);
var ini:tinifile;
begin                                                               //Cargar datos del ini
  ini:=tinifile.create(ExtractFilePath(ParamStr(0))+'demon_nut.ini');
  try
    server_name:=ini.readstring('BakUp_'+inttostr(idx),'servername','');
    db_name:=ini.readstring('BakUp_'+inttostr(idx),'dbname','');
    bakupdir:=ini.readstring('BakUp_'+inttostr(idx),'bakupdir','');
    bakupdir_rem:=ini.readstring('BakUp_'+inttostr(idx),'bakupdir_rem','');
    email:=ini.readstring('BakUp_'+inttostr(idx),'email','');
  finally
    ini.free;
  end;
end;

end.
