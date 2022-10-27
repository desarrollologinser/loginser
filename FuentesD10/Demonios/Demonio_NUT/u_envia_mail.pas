unit u_envia_mail;

interface

uses
  classes,IdMessage,IdText,strutils,IdSMTP,IdAttachmentFile;

procedure envia_email(tipo:Integer; email,log,desc:string; err:Boolean);  //tipo 1=bakup 2=script 3=proceso
procedure envia_email_adjunto(email,log,asunto,ruta:string; err:Boolean);

implementation

uses u_globals;

procedure envia_email(tipo:Integer; email,log,desc:string; err:Boolean);
var   cuerpo:TStrings;    destino,filePath,desc_err:string;   msg_1:TIdMessage;   smtp_1:tidsmtp;
begin
  if err then desc_err:='ERROR'
    else desc_err:='OK';

  try
    msg_1:=TIdMessage.Create();
    with msg_1 do begin
      cuerpo:=TStringList.Create;                                        //Cuerpo del mensaje
      cuerpo.Clear;
      cuerpo.Add(log);

      with TIdText.Create(MessageParts, nil) do begin
        Body.assign(cuerpo);
        ContentType:='text/html';
      end;

      cuerpo.Free;

      From.Text:=u_globals.email;
      ReplyTo.EMailAddresses:=u_globals.email;

      destino:=email;
      Recipients.EMailAddresses:=destino;
      case tipo of
       1:Subject:='BakUp '+desc+' - '+desc_err;
       2:Subject:='Script '+desc+' - '+desc_err;
       3:Subject:='Sync '+desc+' - '+desc_err;
       4:Subject:='Pick '+desc+' - '+desc_err;
       6:Subject:='CheckBB '+desc+' - '+desc_err;
       7:Subject:='ALbJPG '+desc+' - '+desc_err;
       8:Subject:='SendMPS '+desc+' - '+desc_err;
       9:Subject:='Vodafone '+desc+' - '+desc_err;
       10:Subject:='Chrono '+desc+' - '+desc_err;
       11:Subject:='MultiAlbarán '+desc+' - '+desc_err;
      end;
    end;

    try
      smtp_1:=TIdSMTP.Create();

      smtp_1.Username:=u_globals.user;
      smtp_1.Password:=u_globals.pass;
      smtp_1.Host:=u_globals.smtp;
      smtp_1.Port:=u_globals.smtp_port;

      smtp_1.Connect;
      try
        smtp_1.Send(msg_1);
      finally
        smtp_1.Disconnect;
      end;
    finally
      smtp_1.Free;
    end;
  finally
    msg_1.free;
  end;
  //http://www.indyproject.org/Sockets/Blogs/RLebeau/2005_08_17_A.EN.aspx
end;

procedure envia_email_adjunto(email,log,asunto,ruta:string; err:Boolean);
var   cuerpo:TStrings;    destino,filePath,desc_err:string;   msg_1:TIdMessage;   smtp_1:tidsmtp;
begin
  if err then desc_err:='ERROR'
    else desc_err:='OK';

  try
    msg_1:=TIdMessage.Create();
    with msg_1 do begin
      cuerpo:=TStringList.Create;                                        //Cuerpo del mensaje
      cuerpo.Clear;
      cuerpo.Add(log);

      with TIdText.Create(MessageParts, nil) do begin
        Body.assign(cuerpo);
        ContentType:='text/html';
      end;

      cuerpo.Free;

      From.Text:=u_globals.email;
      ReplyTo.EMailAddresses:=u_globals.email;

      destino:=email;
      Recipients.EMailAddresses:=destino;
      Subject:=asunto;
      with TIdAttachmentFile.Create(MessageParts,ruta) do begin
          ContentID:='xls';
          ContentType:='application/vnd.ms-excel';
          FileName:=ruta;
      end;

      ContentType := 'multipart/related; type="text/html"';
    end;

    try
      smtp_1:=TIdSMTP.Create();

      smtp_1.Username:=u_globals.user;
      smtp_1.Password:=u_globals.pass;
      smtp_1.Host:=u_globals.smtp;
      smtp_1.Port:=u_globals.smtp_port;

      smtp_1.Connect;
      try
        smtp_1.Send(msg_1);
      finally
        smtp_1.Disconnect;
      end;
    finally
      smtp_1.Free;
    end;
  finally
    msg_1.free;
  end;
  //http://www.indyproject.org/Sockets/Blogs/RLebeau/2005_08_17_A.EN.aspx
end;
end.
