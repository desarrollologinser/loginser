unit u_listados;

interface

uses
  Windows, Messages, System.SysUtils, Graphics, Controls, Forms,
  Dialogs, StdCtrls, sButton, IB_Services,inifiles,FlexCompress,jclfileutils,
  System.Generics.Collections, IdFTP, IdFTPCommon, System.Classes, system.Variants,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase;

type
  Tf_listados = class(TForm)
    bt_2: TButton;
    ed_1: TEdit;
    lbl_1: TLabel;
    me_1: TMemo;
    lbl_2: TLabel;
    ftp: TIdFTP;
    procedure bt_2Click(Sender: TObject);
    procedure leer_listados_ini(idx:Integer);
  private
    { Private declarations }
    procedure CreaListado;
    procedure CalculaPendientes;
    procedure DeletePendientes;
    procedure LibExit(Reason: Integer);
    procedure conectaFTP;
  public
    { Public declarations }
    procedure lanza_listados(idx:Integer; verbose:boolean);

  end;

var
  f_listados: Tf_listados;
  server_name,db_name,bakupdir,bakupdir_rem,email, servername, dbname:string;
  ClientesFTP : TDictionary<Integer, TIdFTP>;
  grupo, directorio, directorioFTP, servidorFTP, usuario, contrasenya,
  descripcion,programacion,separador,asunto: string;
  dias_atras, activa,grupoQry: integer;
  ClienteFTP: TIdFTP;

const
  tab = #9;
  sl = #10#13;

implementation

uses u_globals, u_envia_mail, u_main, u_dm;

{$R *.dfm}

procedure Tf_listados.bt_2Click(Sender: TObject);
begin
  f_main.tm_1.Enabled:=false;
  lanza_listados(StrToInt(ed_1.text),true);
  f_main.tm_1.Enabled:=true;
end;

procedure Tf_listados.lanza_listados(idx:Integer; verbose:boolean);
var

   i: Integer;
   s: string;
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
           ///Tarea.Log(nlInfo, 'Calculando Listados');

           dm.qry.Close;
           dm.qry.ParamByName('grupo').AsInteger := grupoQry;
           dm.qry.Open;

            if not dm.qry.IsEmpty then begin

              me_1.Lines.Add('Calculando pendientes' + sl);
              CalculaPendientes;

              dm.qry.First;
              while not dm.qry.eof do begin
                 me_1.Lines.Add('Creando ' + Copy(dm.qry.FieldByName('descripcion').AsString,0,Pos('-',dm.qry.FieldByName('descripcion').AsString)-1)+sl);
                  CreaListado;
                  dm.qry.Next;
              end;
            end;


           f_main.mm1.Lines.Add(FormatDateTime('hh:mm',now)+ ' ' + 'Listados OK');
          // EnviaEmail('web@loginser.com','desarrollo@loginser.com,desarrollo2@loginser.com','Copiar ficheros a ftp Bankia',nil,tcTexto);
        except
          on e:Exception do begin
            me_1.Lines.Add('Error: '+e.Message);
            f_main.mm1.Lines.Add(FormatDateTime('hh:mm',now)+ ' ' + 'Listados ERROR');
          end;
        end;
      finally
         dm.qry.Close;
      end;

      me_1.Lines.Add('Proceso finalizado.');
  finally
     ClienteFTP.Free;
  end;
end;

procedure Tf_listados.conectaFTP;
begin
  ClienteFTP := TIdFTP.Create(nil);
  with ClienteFTP do
  begin
    Passive := True;
    TransferType := ftBinary;
    Host := servidorFTP;
    Username := usuario;
    Password := contrasenya;
  end;
  // ClientesFTP.AddOrSetValue(Tarea.Id, ClienteFTP);
  // ClienteFTP := ClientesFTP[Tarea.Id];
  if ClienteFTP.Connected then
    ClienteFTP.Disconnect;
  // Conectamos al FTP y obtenemos la lista de ficheros pendientes
  ClienteFTP.Connect;
  ClienteFTP.ChangeDir('/sync/Bankia/');
  ClienteFTP.DirectoryListing.DirectoryName := '/sync/Bankia/';
end;



procedure Tf_listados.leer_listados_ini(idx:Integer);
var ini:tinifile;
begin                                                               //Cargar datos del ini
  ini:=tinifile.create(ExtractFilePath(ParamStr(0))+'demon_list_bankia.ini');
  try
    servername:=ini.readstring('Listados_1','servername','nut');
    dbname:=ini.readstring('Listados_1','dbname','lgs');
    ServidorFTP:=ini.readstring('Listados_1','ServidorFTP','home361541350.1and1-data.host');
    DirectorioFTP:=ini.readstring('Listados_1','DirectorioFTP','/');
    Directorio:=ini.readstring('Listados_1','Directorio','\\Seth\SysFiles\Exportacion\Bankia\Adjuntos Albaranes\');
    Usuario:=ini.readstring('Listados_1','Usuario','LOGINSER');
    contrasenya:=ini.readstring('Listados_1','Password','ElpcU0206');
    descripcion:=ini.readstring('Listados_1','descripcion','Adjuntos Albaranes Bankia');
    Activa:=StrToInt(ini.readstring('Listados_1','Activa','1'));
    Programacion:=ini.readstring('Listados_1','Programacion','* * 4 * * * *');
    Asunto:=ini.readstring('Listados_1','Asunto','Adjuntos Albaranes.');
    Separador:=ini.readstring('Listados_1','Separador','|');
    GrupoQry:=StrToInt(ini.readstring('Listados_1','GrupoQry','8'));
    dias_atras:=StrToInt(ini.readstring('Listados_1','dias_atras','14'));
  finally
    ini.free;
  end;
end;



procedure Tf_listados.CreaListado;
var
  i, fila: integer;
  nombre, linea, txt_nom: string;
  txt: TextFile;
begin
  try
   nombre := Copy(dm.qry.FieldByName('descripcion').AsString,Pos('-',dm.qry.FieldByName('descripcion').AsString)+1,Length(dm.qry.FieldByName('descripcion').AsString));

   txt_nom := directorio + nombre;

   //System.Assign(txt, txt_nom);
  //System.Assign(txt, 'C:\lgs\' + nombre + FormatDateTime('yymmdd',now) + '.txt');
   AssignfILE(txt, 'C:\lgs\' + nombre +'.txt');

   Rewrite(txt);

   with dm.qlistado do
   begin
      Close;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add(dm.qry.FieldByName('query').AsString);
      ParamByName('f_ini').AsDate := StrToDate(FormatDateTime('dd/mm/yyyy',Now-2-dias_atras));
      ParamByName('f_fin').AsDate := StrToDate(FormatDateTime('dd/mm/yyyy',Now-2));
      //ParamByName('f_ini').AsDate := StrToDate('01/04/2020');
      //ParamByName('f_fin').AsDate := StrToDate('20/04/2020');
      Open;

      if not IsEmpty then
      begin
        First;
        fila := 0;
        linea := '';

        for i := 0 to Fields.Count-1 do
        begin
          //dm.xls.Sheets[0].AsString[i,fila] := FieldName(i);
          linea := linea + FieldName(i) + tab;
        end;

        Writeln(txt,linea);

        Inc(fila);

        while not Eof do
        begin
           linea := '';

           for i := 0 to Fields.Count-1 do
           begin
               //dm.xls.Sheets[0].AsVariant[i,fila] := FieldValues[FieldName(i)];
               linea := linea + string(FieldValues[FieldName(i)]) + tab;
           end;

           Writeln(txt,linea);

           Next;
           Inc(fila);
        end;
      end;

     //dm.xls.Write;
     //ClienteFTP.Put( dm.xls.filename, nombre + '_test.xlsx', False );
     CloseFile(txt);
     ClienteFTP.Put('C:\lgs\' + nombre +'.txt', nombre + '.txt', False );

   end;
  except
     FreeAndNil(txt);
     raise Exception.Create('Error Creando Listado ' + txt_nom);
  end;

end;

procedure Tf_listados.DeletePendientes;
begin
  dm.t_write.StartTransaction;
  try
    with dm.qDelete do
    begin
       ExecQuery;
       dm.t_write.CommitRetaining;
    end;
  except
    dm.t_write.RollbackRetaining;
  end;
end;


procedure Tf_listados.CalculaPendientes;
begin
  DeletePendientes;

  dm.t_write.StartTransaction;
  try
    with dm.spPtes do
    begin
       Close;
       ParamByName('ini').AsDate := StrToDate(FormatDateTime('dd/mm/yyyy',Now-1-dias_atras));
       ParamByName('fin').AsDate := StrToDate(FormatDateTime('dd/mm/yyyy',Now-1));
       //ParamByName('ini').AsDate := StrToDate('01/04/2020');
       //ParamByName('fin').AsDate := StrToDate('20/04/2020');
       ExecProc;
       dm.t_write.CommitRetaining;
    end;
  except
    dm.t_write.RollbackRetaining;
  end;
end;


procedure Tf_listados.LibExit(Reason: Integer);
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

end.
