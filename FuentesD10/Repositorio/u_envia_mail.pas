unit u_envia_mail;

interface

uses
  SysUtils, Classes, Controls, Forms,
  sSkinProvider, IdTCPConnection,
  IdSMTP,
  IdMessage,IdAttachmentFile,
  StdCtrls, sLabel,idtext,sListBox,
  IdBaseComponent, IdComponent, IdTCPClient, IdExplicitTLSClientServerBase,
  IdMessageClient, IdSMTPBase;

type
  Tf_envia_mail = class(TForm)
    smtp_1: TIdSMTP;
    sknprvdr1: TsSkinProvider;
    lb_dest: TsListBox;
    lb_2: TsLabel;
    lb_1: TsLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure envia_email(email_destino,email_cco,asunto,ruta_adjunto, email_from:string; cuerpo:TStrings; cuenta:Integer=1);
    procedure envia_email_multiple(email_destino,email_cco,asunto:string; ruta_adjuntos:TStringList; cuerpo:TStrings; cuenta:Integer=1);
    procedure envia_email_feroz(email_destino,email_cco,asunto,ruta_adjunto, email_from:string; cuerpo:TStrings; cuenta:Integer=1);
  end;

var
  f_envia_mail: Tf_envia_mail;

implementation

uses u_gen_gl;

{$R *.dfm}

procedure Tf_envia_mail.envia_email(email_destino,email_cco,asunto,ruta_adjunto, email_from:string; cuerpo:TStrings; cuenta:Integer=1);          //envia correo electronico
var    email_dir,email_user,email_pass,email_host:string;  email_smtp_port:integer;      mess:tidmessage;
begin
  if cuenta=1 then begin
    email_dir:=u_gen_gl.sys_email_dir;
    email_user:=u_gen_gl.sys_email_user;
    email_pass:=u_gen_gl.sys_email_pass;
    email_host:=u_gen_gl.sys_email_host;
    email_smtp_port:=u_gen_gl.sys_email_smtp_port;
  end else begin
    email_dir:=u_gen_gl.noreply_email_dir;
    email_user:=u_gen_gl.noreply_email_user;
    email_pass:=u_gen_gl.noreply_email_pass;
    email_host:=u_gen_gl.noreply_email_host;
    email_smtp_port:=u_gen_gl.noreply_email_smtp_port;
  end;

  mess:=TIdMessage.Create();
  with mess do begin
    AttachmentEncoding:='UUE';
    charset:='us-ascii';
    //charset:='UTF-8';
    ContentType:='text/plain';

    with TIdText.Create(MessageParts, nil) do begin
      Body.assign(cuerpo);
      charset:='UTF-8';
      ContentType:='text/html';
    end;


    From.Text:=email_dir;
    From.name := email_from;
    ReplyTo.EMailAddresses:=email_dir;

    lb_dest.clear;
    lb_dest.Items.Add(email_destino);

    application.processmessages;

    Recipients.EMailAddresses:=email_destino;
    BccList.EMailAddresses:=email_cco;
    Subject:=asunto;

    if FileExists(ruta_adjunto) then begin
      with TIdAttachmentFile.Create(MessageParts,ruta_adjunto) do begin
        ContentType := 'text/plain';
        FileName:=ruta_adjunto;
      end;
    end;

    ContentType := 'multipart/mixed';
  end;

  smtp_1.Username:=email_user;
  smtp_1.Password:=email_pass;
  smtp_1.Host:=email_host;
  smtp_1.Port:=email_smtp_port;

  smtp_1.Connect;
  try
    smtp_1.Send(mess);
  finally
    smtp_1.Disconnect;
  end;

  FreeAndNil(mess);
  //http://www.indyproject.org/Sockets/Blogs/RLebeau/2005_08_17_A.EN.aspx
end;

procedure Tf_envia_mail.envia_email_multiple(email_destino,email_cco,asunto:string; ruta_adjuntos:TStringList; cuerpo:TStrings; cuenta:Integer=1);         //envia correo electronico
var    email_dir,email_user,email_pass,email_host:string;  email_smtp_port:integer;      mess:tidmessage;    i:integer;
begin
  if cuenta=1 then begin
    email_dir:=u_gen_gl.sys_email_dir;
    email_user:=u_gen_gl.sys_email_user;
    email_pass:=u_gen_gl.sys_email_pass;
    email_host:=u_gen_gl.sys_email_host;
    email_smtp_port:=u_gen_gl.sys_email_smtp_port;
  end else begin
    email_dir:=u_gen_gl.noreply_email_dir;
    email_user:=u_gen_gl.noreply_email_user;
    email_pass:=u_gen_gl.noreply_email_pass;
    email_host:=u_gen_gl.noreply_email_host;
    email_smtp_port:=u_gen_gl.noreply_email_smtp_port;
  end;

  mess:=TIdMessage.Create();
  with mess do begin
    AttachmentEncoding:='UUE';
    charset:='us-ascii';
    ContentType:='text/plain';

    with TIdText.Create(MessageParts, nil) do begin
      Body.assign(cuerpo);
      ContentType:='text/html';
    end;

    From.Text:=email_dir;
    ReplyTo.EMailAddresses:=email_dir;

    lb_dest.clear;
    lb_dest.Items.Add(email_destino);

    application.processmessages;

    Recipients.EMailAddresses:=email_destino;
    BccList.EMailAddresses:=email_cco;
    Subject:=asunto;

    if ruta_adjuntos.count>0 then begin
      for i:=0 to ruta_adjuntos.Count-1 do begin
        if FileExists(ruta_adjuntos[i]) then begin
          with TIdAttachmentFile.Create(MessageParts,ruta_adjuntos[i]) do begin
            ContentType := 'text/plain';
            FileName:=ruta_adjuntos[i];
          end;
        end;
      end;
    end;
    ContentType := 'multipart/mixed';
  end;

  smtp_1.Username:=email_user;
  smtp_1.Password:=email_pass;
  smtp_1.Host:=email_host;
  smtp_1.Port:=email_smtp_port;

  smtp_1.Connect;
  try
    smtp_1.Send(mess);
  finally
    smtp_1.Disconnect;
  end;

  FreeAndNil(mess);
  //http://www.indyproject.org/Sockets/Blogs/RLebeau/2005_08_17_A.EN.aspx
end;

procedure Tf_envia_mail.envia_email_feroz(email_destino,email_cco,asunto,ruta_adjunto, email_from:string; cuerpo:TStrings; cuenta:Integer=1);          //envia correo electronico
var    email_dir,email_user,email_pass,email_host:string;  email_smtp_port:integer;      mess:tidmessage;
begin
    email_dir:= 'hola@zapatoferoz.es';
    email_user:='hola@zapatoferoz.es';
    email_pass:='zapato+FEROZ=2019';
    email_host:='secure.emailsrvr.com';
    email_smtp_port:=465;


  mess:=TIdMessage.Create();
  with mess do begin
    AttachmentEncoding:='UUE';
    charset:='us-ascii';
    //charset:='UTF-8';
    ContentType:='text/plain';

    with TIdText.Create(MessageParts, nil) do begin
      Body.assign(cuerpo);
      charset:='UTF-8';
      ContentType:='text/html';
    end;


    From.Text:=email_dir;
    From.name := email_from;
    ReplyTo.EMailAddresses:=email_dir;

    lb_dest.clear;
    lb_dest.Items.Add(email_destino);

    application.processmessages;

    Recipients.EMailAddresses:=email_destino;
    BccList.EMailAddresses:=email_cco;
    Subject:=asunto;

    if FileExists(ruta_adjunto) then begin
      with TIdAttachmentFile.Create(MessageParts,ruta_adjunto) do begin
        ContentType := 'text/plain';
        FileName:=ruta_adjunto;
      end;
    end;

    ContentType := 'multipart/mixed';
  end;

  smtp_1.Username:=email_user;
  smtp_1.Password:=email_pass;
  smtp_1.Host:=email_host;
  smtp_1.Port:=email_smtp_port;

  smtp_1.Connect;
  try
    smtp_1.Send(mess);
  finally
    smtp_1.Disconnect;
  end;

  FreeAndNil(mess);
  //http://www.indyproject.org/Sockets/Blogs/RLebeau/2005_08_17_A.EN.aspx
end;

end.
