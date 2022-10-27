unit u_adjuntos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent, System.IOUtils,
  IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase, IdFTP,
  Vcl.StdCtrls, inifiles,System.Generics.Collections, IdFTPCommon, Jpeg,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, System.AnsiStrings,
  ScSFTPClient, ScSSHClient, ScBridge, ScSSLClient, ScFTPClient;

type
  Tf_adjuntos = class(TForm)
    lbl_1: TLabel;
    lbl_2: TLabel;
    btn_2: TButton;
    ed_1: TEdit;
    mm_1: TMemo;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    IdFTP1: TIdFTP;
    ssh: TScSSHClient;
    FileStore: TScFileStorage;
    ScSSLClient1: TScSSLClient;
    ScFTPClient1: TScFTPClient;
    procedure btn_2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure procesa_adjuntos(idx:Integer; verbose:boolean);
    procedure procesa_adjuntos_ini(idx:Integer);
    procedure conectaFTP;
    function DescargaFichero(ClienteFTP : TIdFTP; Nombre:string; out temp : string) : string;
    function ExisteAdjunto(id_albaran:Integer;adjunto:string):Boolean;
    function ExtraeAlbaran(adjunto:string):integer;
    function ActualizaAttachmentAlbaran(attach, alb:Integer; nombre:string):string;

    function CryptBinaryToString(pbBinary: PByte; cbBinary: DWORD; dwFlags: DWORD;
                                 pszString: PChar; var pcchString: DWORD): BOOL; stdcall;
    function  BinToStr(Binary: PByte; Len: Cardinal): String;

    procedure ScSSHClientServerKeyValidate(Sender: TObject; NewServerKey: TScKey; var Accept: Boolean);
  end;

const
  tab = #9;
  sl = #10#13;
  CRYPT_STRING_BASE64 = $00000001; //Base64, without headers.

var
  f_adjuntos: Tf_adjuntos;
  server_name,db_name,bakupdir,bakupdir_rem,email, servername, dbname, dir_temp:string;
  ClientesFTP : TDictionary<Integer, TIdFTP>;
  grupo, directorio, directorioFTP, servidorFTP, usuario, contrasenya,
  descripcion,programacion,separador,asunto: string;
  dias_atras, activa,grupoQry: integer;
  ClienteFTP: TIdFTP;
  ssl: TIdSSLIOHandlerSocketOpenSSL;

implementation

uses
  u_main, u_dm, u_attachment;

{$R *.dfm}

procedure Tf_adjuntos.btn_2Click(Sender: TObject);
begin
  f_main.tm_1.Enabled:=false;
  procesa_adjuntos(StrToInt(ed_1.text),true);
  f_main.tm_1.Enabled:=true;
end;


procedure Tf_adjuntos.procesa_adjuntos(idx:Integer; verbose:boolean);
var

   i, id, id_albaran: Integer;
   s, nombre, url, nombre_fichero: string;
   Jpeg: TJpegImage;
  Stream: TStream;
  Lista: TStringList;
begin

    mm_1.Lines.Add('Inicializando' + sl);
    procesa_adjuntos_ini(idx);

    if not DirectoryExists(dir_temp) then
        CreateDirectory(PChar(dir_temp),0);

    try
        dm.db_gestoras.Close;
        dm.db_gestoras.DBName := servername+':'+dbname;
        dm.db_gestoras.Connected := True;
    except
			on e : Exception do
      begin
        mm_1.Lines.Add(e.Message);
        Exit;
      end;
    end;

  try
     mm_1.Lines.Add('Conectando a ftp... ' + sl);
     conectaFTP;
     mm_1.Lines.Add('FTP conectado ' + sl);

        Screen.Cursor := crHourGlass;
        Jpeg := TJPEGImage.Create;


        try
          ClienteFTP.ChangeDir(DirectorioFTP);
          //ClienteFTP.List;
          ClienteFTP.List(Lista,'*.*',False);

          dm.t_write_gestoras.StartTransaction;

          for i := 0 to ClienteFTP.DirectoryListing.Count - 1 do
          begin

             //ShowMessage(ExtractFileExt(ClienteFTP.DirectoryListing[i].FileName));
             if IndexStr(ExtractFileExt(ClienteFTP.DirectoryListing[i].FileName),['.jpg','.jpeg'])>=0 then
             begin
               DescargaFichero(ClienteFTP,ClienteFTP.DirectoryListing[i].FileName,nombre);
               mm_1.Lines.Add('Descargando ' + ClienteFTP.DirectoryListing[i].FileName + sl);
               jpeg.LoadFromFile(nombre);
               Jpeg.SaveToFile(nombre);

               id_albaran := ExtraeAlbaran(TPath.GetFileNameWithoutExtension(nombre));
               nombre_fichero := ExtractFileName(nombre);

              if not ExisteAdjunto(id_albaran,nombre_fichero) then
               begin
                 SubeAdjunto(nombre,nombre,'albaran_adjunto','image/jpeg',id,url);
                 ActualizaAttachmentAlbaran(id,id_albaran,nombre_fichero);
                 mm_1.Lines.Add('Adjuntado ' + ClienteFTP.DirectoryListing[i].FileName + sl);
               end else
                      mm_1.Lines.Add('Ya existe adjunto ' + ClienteFTP.DirectoryListing[i].FileName + sl);

               DeleteFile(dir_temp+nombre);
             end;

             Next;
          end;

          dm.t_write_gestoras.Commit;
          f_main.mm1.Lines.Add(FormatDateTime('hh:mm',now)+ ' ' + 'Adjuntos OK');
        except
           on e:Exception do begin
              dm.t_write_gestoras.Rollback;
              mm_1.Lines.Add('Error ' + ClienteFTP.DirectoryListing[i].FileName + ' ' + e.Message + sl);
              f_main.mm1.Lines.Add(FormatDateTime('hh:mm',now)+ ' ' + 'Adjuntos ERROR');
           end;
        end;

        Screen.Cursor := crDefault;
        Jpeg.Free;

        mm_1.Lines.Add('Proceso finalizado.');

  finally
     ClienteFTP.Free;
     //ssl.Free;
  end;
end;


function Tf_adjuntos.ActualizaAttachmentAlbaran(attach, alb:Integer; nombre:string):string;
begin
   with dm.qry1 do begin
     try
      database:=dm.db_gestoras;
      Transaction := dm.t_write_gestoras;
      sql.Clear;
      sql.add('insert into albaran_adjuntos (id_albaran,attachment_id,tipo,tipo_documento,documento,titulo,nombre_apellidos)');
      sql.add('values (:id_albaran,:attachment_id,:tipo,:tipo_documento,:documento,:titulo,:nombre_apellidos)');
      ParamByName('id_albaran').asinteger := alb;
      ParamByName('attachment_id').asinteger := attach;
      ParamByName('tipo').AsString := 'POD';
      ParamByName('tipo_documento').AsString := 'FOTO';
      ParamByName('documento').AsString := nombre;
      ParamByName('titulo').AsString := nombre;
      ParamByName('nombre_apellidos').asstring := 'FTP BANKIA';
      ExecQuery;
     except on E:Exception do
            begin
             result := e.Message;
             raise;
            end;
     end;
   end;
end;

function Tf_adjuntos.ExtraeAlbaran(adjunto:string):integer;
begin
    If Pos('_',adjunto)>0 then
      Result := StrToInt(Copy(adjunto,0,Pos('_',adjunto)-1))    //xxxxxx_y  devuelve xxxxxx
    else
      Result := StrToInt(adjunto);
end;

function Tf_adjuntos.ExisteAdjunto(id_albaran:Integer;adjunto:string):Boolean;
begin
    with dm.q1 do
    begin
      Close;
      SelectSQL.Clear;
      SelectSQL.Add('select * from albaran_adjuntos where id_albaran=:id_albaran and documento=:adjunto ');
      ParamByName('id_albaran').AsInteger := id_albaran;
      ParamByName('adjunto').AsString := adjunto;
      Open;

      Result := not IsEmpty;
    end;
end;


procedure Tf_adjuntos.conectaFTP;
begin
  ClienteFTP := TIdFTP.Create(nil);
  ssl := TIdSSLIOHandlerSocketOpenSSL.Create(ClienteFTP);

  with ClienteFTP do
  begin

    Passive := True;
    TransferType := ftBinary;
    Host := servidorFTP;
    Username := Usuario;
    Password := contrasenya;
    //IOHandler := ssl;
    //UseTLS := utUseImplicitTLS;
    //Port := 990;

  end;
  // ClientesFTP.AddOrSetValue(Tarea.Id, ClienteFTP);
  // ClienteFTP := ClientesFTP[Tarea.Id];
  if ClienteFTP.Connected then
    ClienteFTP.Disconnect;
  // Conectamos al FTP y obtenemos la lista de ficheros pendientes
  ClienteFTP.Connect;

end;


 {
procedure Tf_adjuntos.conectaFTP;
var
 ScSSHClient: TScSSHClient;
 ScFileStorage: TScFileStorage;
 ScSFTPClient: TScSFTPClient;
 ssl: TScSSLClient;
 lista: TStringList;
begin

 //ssh.Connect;
 ScSSLClient1.Connect;
 ScFTPClient1.Connect;
 ScFTPClient1.Login;
 ScFTPClient1.ChangeDir('/');
 ScFTPClient1.Dowload('/','c:\temp\',False,0);

 ssl:= TScSSLClient.Create(nil);
 ssl.Storage := ScFileStorage;
 ssl.HostName := 'ftpst.lqs.es';
 ssl.HttpOptions.Username := 'LOGINSER';
 ssl.HttpOptions.Password := 'ElpcU0206';
 ssl.Port := 990;
 ssl.Connect;

 ScFileStorage := TScFileStorage.Create(nil);
 ScSSHClient := TScSSHClient.Create(nil);
 ScSSHClient.KeyStorage := ScFileStorage;
 ScSSHClient.HostName := 'ftpst.lqs.es';
 ScSSHClient.HostKeyAlgorithms.Add;
 ScSSHClient.OnServerKeyValidate := ScSSHClientServerKeyValidate;
 ScSSHClient.User := 'LOGINSER';
 ScSSHClient.Password := 'ElpcU0206';
 ScSSHClient.Port := 990;
 ScSSHClient.Connect;

 ScSFTPClient := TScSFTPClient.Create(nil);
 ScSFTPClient.SSHClient := ScSSHClient;
 ScSFTPClient.Initialize;
 scSFTPClient.Active;
 ScSFTPClient.OpenDirectory('.');
 ScSFTPClient.DownloadFile('.','c:\tmp\',False,0);
 //ScSFTPClient.UploadFile(ruta, './in/work/'+fichero, False);
 //ScSFTPClient.RenameFile('./in/work/'+fichero,'./in/build/'+fichero);
 ScSSHClient.Disconnect;
end;     }

procedure Tf_adjuntos.ScSSHClientServerKeyValidate(Sender: TObject; NewServerKey: TScKey; var Accept: Boolean);
begin
  Accept := True;
end;

function Tf_adjuntos.DescargaFichero(ClienteFTP : TIdFTP; Nombre:string; out temp : string) : string;
var
  NombreNuevo : string;

begin
  NombreNuevo := FormatDateTime('yyyymmddhhnn',Now) + '_' + Nombre;
  Result := '';
  temp := dir_temp + nombre;
  try
    //ClienteFTP.Rename(Nombre, NombreNuevo);
    //ClienteFTP.Get(NombreNuevo, Datos, False);
    ClienteFTP.Get(Nombre, temp, True);
    //Result := NombreNuevo;
    Result := temp;
  except
    on e: Exception do
      mm_1.Lines.Add('ERROR: ' + e.Message);
  end;
end;

procedure Tf_adjuntos.procesa_adjuntos_ini(idx:Integer);
var ini:tinifile;
begin                                                               //Cargar datos del ini
  ini:=tinifile.create(ExtractFilePath(ParamStr(0))+'demon_list_bankia.ini');
  try
    servername:=ini.readstring('Adjuntos_'+inttostr(idx),'servername','nut');
    dbname:=ini.readstring('Adjuntos_'+inttostr(idx),'dbname','lgs');
    ServidorFTP:=ini.readstring('Adjuntos_'+inttostr(idx),'ServidorFTP','www.loginser.com');
    DirectorioFTP:=ini.readstring('Adjuntos_'+inttostr(idx),'DirectorioFTP','/');
    Directorio:=ini.readstring('Adjuntos_'+inttostr(idx),'Directorio','\\Seth\SysFiles\Exportacion\Bankia\Listados Diarios\');
    Usuario:=ini.readstring('Adjuntos_'+inttostr(idx),'Usuario','u62588198-app');
    contrasenya:=ini.readstring('Adjuntos_'+inttostr(idx),'Password','xzj2004MN4+');
    dir_temp := ini.readstring('Adjuntos_'+inttostr(idx),'dir_temp','C:\temp\');


    descripcion:=ini.readstring('Adjuntos_'+inttostr(idx),'descripcion','Adjuntos Albaranes');
    Activa:=StrToInt(ini.readstring('Adjuntos_'+inttostr(idx),'Activa','1'));
    Programacion:=ini.readstring('Adjuntos_'+inttostr(idx),'Programacion','* * 4 * * * *');

  finally
    ini.free;
  end;
end;


function Tf_adjuntos.CryptBinaryToString(pbBinary: PByte; cbBinary: DWORD; dwFlags: DWORD;
  pszString: PChar; var pcchString: DWORD): BOOL; stdcall;
  external 'Crypt32.dll' name 'CryptBinaryToStringA';

function  Tf_adjuntos.BinToStr(Binary: PByte; Len: Cardinal): String;
var
  Count: DWORD;
begin
  Count:= 0;
  if CryptBinaryToString(Binary,Len,CRYPT_STRING_BASE64,nil,Count) then
  begin
    SetLength(Result,Count);
    if not CryptBinaryToString(Binary,Len,CRYPT_STRING_BASE64,PChar(Result),
      Count) then
      Result:= EmptyStr;
  end;
end;
end.
