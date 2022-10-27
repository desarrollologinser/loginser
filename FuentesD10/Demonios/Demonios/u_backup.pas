unit u_backup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, sButton, IB_Services,inifiles,FlexCompress,jclfileutils;

  function backup(idx:Integer; serv,db,dir,dirrem:string; verbose:boolean):string;
  procedure leer_backup_ini(idx:Integer);
var
  server_name,db_name,bakupdir,bakupdir_rem,email:string;

implementation

uses u_globals, u_envia_mail, u_main;

function backup(idx:Integer; serv,db,dir,dirrem:string;  verbose:boolean):string;
var   err,err_compress:boolean;   memo:tstrings;   bakupfilename:string;
begin
  leer_backup_ini(idx);

  memo:=TStringList.Create;
  memo.Clear;

  with TpFIBBackupService.Create(nil) do try                     //crea el FBK
    ServerName:=serv;
    DatabaseName:=db;
    //libname:=u_globals.libname;
    Protocol:=TCP;

    params.Clear;
    params.Add('user_name=SYSDBA');
    params.Add('password=masterkey');
    LoginPrompt:=false;

    BackupFile.Clear;
    bakupfilename:=db+'_'+formatdatetime('yymmdd_hhnnss',now);
    BackupFile.Add(dir+bakupfilename+'.fbk');

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
      FileName:=dir+bakupfilename+'.fxc';
      OpenArchive(fmCreate);
      BaseDir:=dir;
      AddFiles(bakupfilename+'.fbk');
      CloseArchive;
    except
      err_compress:=true;
    end;
  finally
    free;
  end;

  if not(err_compress) then DeleteFile(dir+bakupfilename+'.fbk');            //Borra FBK

  FileCopy(dir+bakupfilename+'.fxc',dirrem+bakupfilename+'.fxc',true); //Copia el backup al dir remoto

  if pos('closing file, committing, and finishing',LowerCase(memo.text))=0 then err:=true   //Ha finalizado correctamente
    else err:=false;   //se ha producido un error

  try
    if email<>'' then u_envia_mail.envia_email(1,email,memo.text,server_name+':'+db_name,err);
  finally

  end;

 { if verbose then begin
    me_1.Clear;
    me_1.Text:=memo.Text;
  end;
  memo.Free;
  }

  if verbose then ShowMessage('Finished');
end;

procedure leer_backup_ini(idx:Integer);
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
