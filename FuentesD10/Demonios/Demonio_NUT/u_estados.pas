unit u_estados;

interface

uses
  Windows, Messages, System.SysUtils, Graphics, Controls, Forms,
  Dialogs, StdCtrls, sButton, IB_Services,inifiles,FlexCompress,jclfileutils,
  System.Generics.Collections, IdFTP, IdFTPCommon, System.Classes, system.Variants,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, System.AnsiStrings,
  IdExplicitTLSClientServerBase, ScSFTPClient, ScSSHClient, ScBridge, ScSSLClient,
  IdSSL, IdSSLOpenSSL, system.types, System.StrUtils;

type
  Tf_estados = class(TForm)
    bt_2: TButton;
    ed_1: TEdit;
    lbl_1: TLabel;
    me_1: TMemo;
    lbl_2: TLabel;
    ftp: TIdFTP;
    FileStore: TScFileStorage;
    ssh: TScSSHClient;
    client: TScSFTPClient;
    ScSSLClient1: TScSSLClient;
    procedure bt_2Click(Sender: TObject);
    procedure leer_listados_ini(idx:Integer);
  private
    { Private declarations }
    procedure LibExit(Reason: Integer);
    procedure conectaFTP;
  public
    { Public declarations }
    procedure procesa_estados(idx:Integer; verbose:boolean);
    function DescargaFichero(ClienteFTP : TIdFTP; Nombre:string; out temp : string) : string;
    function MapeaEstado(estado:string):integer;
    procedure AbreFichero(ruta:string);
    function ExisteEstado(id_albaran,estado:Integer; fecha:tdate):Boolean;
    function InsertaEstado(id_albaran, estado:Integer; fecha:tdate; descripcion:string):string;
    function TituloEstado(estado:integer):string;
  end;

var
  f_estados: Tf_estados;
  server_name,db_name,bakupdir,bakupdir_rem,email, servername, dbname:string;
  ClientesFTP : TDictionary<Integer, TIdFTP>;
  grupo, directorio, directorioFTP, servidorFTP, usuario, contrasenya,
  descripcion,programacion,separador,asunto: string;
  activa,grupoQry, usuario_estado, agencia: integer;
  ClienteFTP: TIdFTP;
  ssl: TIdSSLIOHandlerSocketOpenSSL;

  excel, xls, libro: Variant;
  hoja:OleVariant;

const
  tab = #9;
  sl = #10#13;

implementation

uses u_globals, u_envia_mail, u_main, u_dm;

{$R *.dfm}

procedure Tf_estados.bt_2Click(Sender: TObject);
begin
  f_main.tm_1.Enabled:=false;
  procesa_estados(StrToInt(ed_1.text),true);
  f_main.tm_1.Enabled:=true;
end;

procedure Tf_estados.procesa_estados(idx:Integer; verbose:boolean);
var
   fic:tstringlist;
   str_dyn:TStringDynArray;
   i,j, estado: Integer;
   s, nombre, titulo: string;
   Lista: TStringList;
begin
    me_1.Lines.Add('Inicializando' + sl);
   leer_listados_ini(idx);

    try
        dm.db.Close;
        dm.db.DBName := servername+':'+dbname;
        dm.db.Connected := True;
    except
			on e : Exception do
      begin
        me_1.Lines.Add(e.Message);
        Exit;
      end;
    end;


  try
     conectaFTP;

      try
        try
          ClienteFTP.ChangeDir(DirectorioFTP);
          //ClienteFTP.List;
          ClienteFTP.List(Lista,'*.*',False);

          dm.t_write_gestoras.StartTransaction;

          for i := 0 to ClienteFTP.DirectoryListing.Count - 1 do
          begin

             //ShowMessage(ExtractFileExt(ClienteFTP.DirectoryListing[i].FileName));
             if IndexStr(ExtractFileExt(ClienteFTP.DirectoryListing[i].FileName),['.csv'])>=0 then
             begin
               try
                   DescargaFichero(ClienteFTP,ClienteFTP.DirectoryListing[i].FileName,nombre);
                   me_1.Lines.Add('Descargando ' + ClienteFTP.DirectoryListing[i].FileName + sl);

                  fic:=tstringlist.create();
                  fic.LoadFromFile(nombre);

                  //AbreFichero(nombre);
                  //Hoja := excel.Worksheets.Item[1];

                    for j:=1 to fic.Count-1 do begin
                         str_dyn:=splitstring(fic[j],';');

                         estado := -99;

                         if str_dyn[2]<>'' then
                          estado := MapeaEstado(str_dyn[2]);

                         if estado<>-99 then
                            titulo := TituloEstado(estado)
                         else
                            titulo := str_dyn[2];

                          if not ExisteEstado(StrToInt(str_dyn[0]),estado, StrToDate(str_dyn[4])) then
                          begin
                              InsertaEstado(StrToInt(str_dyn[0]),estado,StrToDate(str_dyn[4]),titulo);
                              me_1.Lines.Add('Actualizado ' + str_dyn[0] + ' a ' + titulo + sl);
                          end else
                                me_1.Lines.Add('Ya existe estado ' + titulo + ' en ' + str_dyn[0] + sl);
                    end;

                    if FileExists(nombre) then
                       DeleteFile(nombre);

                    fic.Free;

                except
                        on e:Exception do begin
                          me_1.Lines.Add('Error Importando Fichero '+e.message);

                          //excel.activeworkbook.save;
                          //Excel.Quit ;
                          //Excel := Unassigned;

                          exit;
                        end;
                      end;
             end;

             Next;
          end;

          dm.t_write_gestoras.Commit;
          f_main.mm1.Lines.Add(FormatDateTime('hh:mm',now)+ ' ' + 'Estados OK');

        except
           on e:Exception do begin
            dm.t_write_gestoras.Rollback;
            me_1.Lines.Add('Error: '+e.Message);
            f_main.mm1.Lines.Add(FormatDateTime('hh:mm',now)+ ' ' + 'Estados ERROR');
          end;
        end;

        Screen.Cursor := crDefault;

        //Excel.Quit ;
        //Excel := Unassigned;
        me_1.Lines.Add('Proceso finalizado.');
      finally
         dm.qry.Close;
      end;

  finally
     ClienteFTP.Free;
  end;
end;

procedure Tf_estados.conectaFTP;
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

{procedure Tf_estados.conectaFTP;
var
 ScSSHClient: TScSSHClient;
 ScFileStorage: TScFileStorage;
 ScSFTPClient: TScSFTPClient;
 ssl: TScSSLClient;
begin
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

 ssl:= TScSSLClient.Create(nil);
 ssl.Storage := ScFileStorage;
 ssl.HostName := 'ftpst.lqs.es';
 ssl.HttpOptions.Username := 'LOGINSER';
 ssl.HttpOptions.Password := 'ElpcU0206';
 ssl.Port := 990;
 ssl.Connect;


 ScSFTPClient := TScSFTPClient.Create(nil);
 ScSFTPClient.SSHClient := ScSSHClient;
 ScSFTPClient.Initialize;
 scSFTPClient.Active;
 ScSFTPClient.OpenDirectory('.');
 ScSFTPClient.DownloadFile('.','c:\tmp\',False,0);
 //ScSFTPClient.UploadFile(ruta, './in/work/'+fichero, False);
 //ScSFTPClient.RenameFile('./in/work/'+fichero,'./in/build/'+fichero);
 ScSSHClient.Disconnect;
end;
}


procedure Tf_estados.AbreFichero(ruta:string);
begin
   //Excel:=CreateOleObject('Excel.Application');
   try
     Excel.Visible := False;
     Excel.DisplayAlerts:= False;
     Excel.WorkBooks.Open(ruta);//fichero que queremos leer
   except
     Excel.Quit ;
     Excel := Unassigned;
   end;
end;


procedure Tf_estados.leer_listados_ini(idx:Integer);
var ini:tinifile;
begin                                                               //Cargar datos del ini
  ini:=tinifile.create(ExtractFilePath(ParamStr(0))+'demon_list_bankia.ini');
  try
    servername:=ini.readstring('Estados_'+inttostr(idx),'servername','nut');
    dbname:=ini.readstring('Estados_'+inttostr(idx),'dbname','lgs');
    ServidorFTP:=ini.readstring('Estados_'+inttostr(idx),'ServidorFTP','home361541350.1and1-data.host');
    DirectorioFTP:=ini.readstring('Estados_'+inttostr(idx),'DirectorioFTP','/');
    Directorio:=ini.readstring('Estados_'+inttostr(idx),'Directorio','\\Seth\SysFiles\Exportacion\Bankia\Listados Diarios\');
    Usuario:=ini.readstring('Estados_'+inttostr(idx),'Usuario','u62588198-app');
    contrasenya:=ini.readstring('Estados_'+inttostr(idx),'Password','xzj2004MN4+');
    usuario_estado:=StrToInt(ini.readstring('Estados_'+inttostr(idx),'usuario_estado','99'));
    agencia:=StrToInt(ini.readstring('Estados_'+inttostr(idx),'agencia','45'));

    Programacion:=ini.readstring('Estados_'+inttostr(idx),'Programacion','* * 4 * * * *');
  finally
    ini.free;
  end;
end;


procedure Tf_estados.LibExit(Reason: Integer);
var
  Cliente: TIdFTP;
begin
	// Si se está descargando la librería de la memoria
  if Reason = DLL_PROCESS_DETACH then
  begin
     // Elimino los clientes FTP
		for Cliente in ClientesFTP.Values do
    begin
    	if Cliente.Connected then
      	Cliente.Disconnect;
			Cliente.Free;
    end;
    FreeAndNil(ClientesFTP);


  	// Libero dm
  	FreeAndNil(dm);
  end;

end;

function Tf_estados.DescargaFichero(ClienteFTP : TIdFTP; Nombre:string; out temp : string) : string;
var
  NombreNuevo : string;

begin
  NombreNuevo := FormatDateTime('yyyymmddhhnn',Now) + '_' + Nombre;
  Result := '';
  temp := 'C:\temp\' + nombre;
  try
    //ClienteFTP.Rename(Nombre, NombreNuevo);
    //ClienteFTP.Get(NombreNuevo, Datos, False);
    ClienteFTP.Get(Nombre, temp, True);
    //Result := NombreNuevo;
    Result := temp;
  except
    on e: Exception do
      showmessage('ERROR: ' + e.Message);
  end;
end;


function Tf_estados.ExisteEstado(id_albaran,estado:Integer; fecha:tdate):Boolean;
begin
    with dm.q1 do
    begin
      Close;
      SelectSQL.Clear;
      SelectSQL.Add('select * from alb_tracking where id_albaran=:id_albaran and usuario=:usuario and estado=:estado and fecha=:fecha');
      ParamByName('id_albaran').AsInteger := id_albaran;
      ParamByName('usuario').AsInteger := usuario_estado;
      ParamByName('estado').AsInteger := estado;
      ParamByName('fecha').asdate := fecha;
      Open;

      Result := not IsEmpty;
    end;
end;


function Tf_estados.MapeaEstado(estado:string):integer;
begin
    with dm.q1 do
    begin
      Close;
      SelectSQL.Clear;
      SelectSQL.Add('select estado from estados_agencia where agencia=:agencia and upper(estado_age)=upper(:estado) ');
      ParamByName('estado').AsString := estado;
      ParamByName('agencia').AsInteger := agencia;
      Open;

      if not IsEmpty then
           Result := FieldByName('estado').AsInteger
      else
           result := -99;
    end;
end;

function Tf_estados.InsertaEstado(id_albaran, estado:Integer; fecha:tdate; descripcion:string):string;
begin
   with dm.qry1 do begin
     try
      database:=dm.db;
      Transaction := dm.t_write;
      sql.Clear;
      sql.add('insert into alb_tracking (id_albaran,estado,fecha,usuario,descripcion)');
      sql.add('values (:id_albaran,:estado,:fecha,:usuario,:descripcion)');
      ParamByName('id_albaran').asinteger := id_albaran;
      ParamByName('estado').asinteger := estado;
      ParamByName('fecha').AsDate := fecha;
      ParamByName('usuario').asinteger := usuario_estado;
      ParamByName('descripcion').asstring := descripcion;
      ExecQuery;


      sql.Clear;
      sql.add('update albaranes set estado=:estado where id_albaran=:id_albaran');
      ParamByName('id_albaran').asinteger := id_albaran;
      ParamByName('estado').asinteger := estado;
      ExecQuery;
     except on E:Exception do
            begin
             result := e.Message;
             raise;
            end;
     end;
   end;
end;

function Tf_estados.TituloEstado(estado:integer):string;
begin
    with dm.q1 do
    begin
      Close;
      SelectSQL.Clear;
      SelectSQL.Add('select titulo from estados where estado=:estado');
      ParamByName('estado').AsInteger := estado;
      Open;

      if not IsEmpty then
           Result := FieldByName('titulo').AsString
      else
           result := '';
    end;
end;

end.
