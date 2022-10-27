library Bankia_Listados;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }


uses
  System.SysUtils,
  System.SyncObjs,
  Winapi.Windows,
  Winapi.ActiveX,
  System.Classes,
  Tarea,
  Tipos,
  dateutils,
  vcl.Dialogs,
  Soap.EncdDecd,
  vcl.Graphics,
  System.Win.ComObj,
  Vcl.Imaging.jpeg,
  FuncionesEmail,
  System.Generics.Collections,
  IdFTP,
  IdFTPCommon,
  u_dm_bankia in 'u_dm_bankia.pas' {dm: TDataModule},
  u_hashes in '..\..\..\Repositorio\u_hashes.pas';

type
	TSetOfByte = set of Byte;

var
  SaveDllProc: TDLLProc;
	SeccionCritica : TCriticalSection;

  {Variables de Configuracion}
  grupo, directorio, directorioFTP: string;
  dias_atras: integer;
  ClientesFTP : TDictionary<Integer, TIdFTP>;

const
  tab = #9;

{$R *.res}

(*
	Inicializa las variables de la DLL (comunes a todas las tareas que usan
  esta librería), a partir de la configuración global de la tarea
*)
function Inicializa(Tarea : TTarea) : string; export;
var
  ClienteFTP: TIdFTP;
begin
	Result := '';

  grupo := Tarea.GetConfiguracion('Grupo', '8');
  directorioFTP := Tarea.GetConfiguracion('DirectorioFTP','sync\Bankia\');
  directorio := Tarea.GetConfiguracion('Directorio','\\seth\SysFiles\Exportacion\Bankia\Listados Diarios\');
  dias_atras := StrToInt(Tarea.GetConfiguracion('dias_atras','15'));

  SeccionCritica.Enter;
  if not Assigned(dm) then
  begin
    try
      try
        //CoInitialize(nil);
        dm := Tdm.Create(nil);
        dm.db_bankia.Close;
        dm.db_bankia.DBName := Tarea.GetConfiguracion('servername', 'nut')+
                           ':'+Tarea.GetConfiguracion('dbname', 'lgs');
        dm.db_bankia.Connected := True;
      finally
        SeccionCritica.Leave;
      end;
    except
			on e : Exception do
      begin
        Result := e.Message;
        Exit;
      end;
    end;
  end;

  if ClientesFTP.ContainsKey(Tarea.Id) then
  	ClienteFTP := ClientesFTP[Tarea.Id]
  else
  	ClienteFTP := TIdFTP.Create(nil);

  with ClienteFTP do
  begin
  	Passive := True;
    TransferType := ftBinary;
    Host := Tarea.GetConfiguracion('ServidorFTP', 'www.loginser.com');
    Username := Tarea.GetConfiguracion('usuario');
    Password := Tarea.GetConfiguracion('password');
    if (Username = '') or (Password = '') then
    begin
    	Result := 'No se han encontrado los datos de acceso en la configuración global de la tarea';
      Exit;
    end;
  end;
  ClientesFTP.AddOrSetValue(Tarea.Id, ClienteFTP);

end;

(*
	Función exportada que es llamada desde una tarea
		Tarea = Objeto de tipo TTarea con información de la tarea a ejecutar
*)function Ejecuta(Tarea : TTarea) : string; export;
var
  LogInterno : TStrings;
  ClienteFTP: TIdFTP;

procedure CreaListado;
var
  i, fila: integer;
  nombre, linea, txt_nom: string;
  txt: TextFile;
begin
  try
   nombre := Copy(dm.qry.FieldByName('descripcion').AsString,Pos('-',dm.qry.FieldByName('descripcion').AsString)+1,Length(dm.qry.FieldByName('descripcion').AsString));

   {dm.xls.Clear(1);
   dm.xls.Filename := directorio +
                      //'C:\Users\Ivan.LOGINSER\Desktop\'+
                      nombre  +
                      FormatDateTime('yymmdd',now) +
                      //'_test.xlsx';
                      '.xlsx'; }

   //txt_nom := directorio + nombre + FormatDateTime('yymmdd',now) + '.txt';
   txt_nom := directorio + nombre + '.txt';

   Assign(txt, txt_nom);
   //Assign(txt, 'C:\Users\Ivan.LOGINSER\Desktop\' + nombre + FormatDateTime('yymmdd',now) + '.txt');
   Rewrite(txt);

   with dm.qlistado do
   begin
      Close;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add(dm.qry.FieldByName('query').AsString);
      //ParamByName('f_ini').AsDate := StrToDate(FormatDateTime('dd/mm/yyyy',Now-2-dias_atras));
      //ParamByName('f_fin').AsDate := StrToDate(FormatDateTime('dd/mm/yyyy',Now-2));
      ParamByName('f_ini').AsDate := StrToDate('26/04/2019');
      ParamByName('f_fin').AsDate := StrToDate('26/04/2019');
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
     ClienteFTP.Put(txt_nom, nombre + '.txt', False );

   end;
  except
     FreeAndNil(txt);
     raise Exception.Create('Error Creando Listado ' + ExtractFileName(dm.xls.Filename));
  end;

end;

procedure DeletePendientes;
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


procedure CalculaPendientes;
begin
  DeletePendientes;

  dm.t_write.StartTransaction;
  try
    with dm.spPtes do
    begin
       Close;
       //ParamByName('ini').AsDate := StrToDate(FormatDateTime('dd/mm/yyyy',Now-1-dias_atras));
       //ParamByName('fin').AsDate := StrToDate(FormatDateTime('dd/mm/yyyy',Now-1));
       ParamByName('ini').AsDate := StrToDate('26/04/2019');
       ParamByName('fin').AsDate := StrToDate('26/04/2019');
       ExecProc;
       dm.t_write.CommitRetaining;
    end;
  except
    dm.t_write.RollbackRetaining;
  end;
end;



begin
  Result := '';

  ClienteFTP := ClientesFTP[Tarea.Id];

  if ClienteFTP.Connected then
    ClienteFTP.Disconnect;

  // Conectamos al FTP y obtenemos la lista de ficheros pendientes
  Tarea.Log(nlInfo, 'Conectando al servidor FTP');
  //ClienteFTP.Connect;
  Tarea.Log(nlInfo, 'Conectado al servidor FTP');
  //ClienteFTP.ChangeDir(DirectorioFTP);

  try
    try
       Tarea.Log(nlInfo, 'Calculando Listados');

       dm.qry.Close;
       //dm.qry.ParamByName('grupo').AsInteger := StrToInt(grupo);
       dm.qry.Open;

        if not dm.qry.IsEmpty then begin

          CalculaPendientes;

          dm.qry.First;
          while not dm.qry.eof do begin
              Tarea.Log(nlInfo, 'Creando ' + Copy(dm.qry.FieldByName('descripcion').AsString,0,Pos('-',dm.qry.FieldByName('descripcion').AsString)-1));
              CreaListado;
              dm.qry.Next;
          end;
        end;

       Tarea.Log(nlInfo, 'Proceso finalizado.');

      // EnviaEmail('web@loginser.com','desarrollo@loginser.com,desarrollo2@loginser.com','Copiar ficheros a ftp Bankia',nil,tcTexto);
    except
      on e:Exception do
        Tarea.Log(nlError, 'Error: 1 '+e.Message);
    end;
  finally
     dm.qry.Close;
  end;
end;

procedure LibExit(Reason: Integer);
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
    SeccionCritica.Free;
  end;
  // Llamo a la rutina de procesado por defecto
  if Assigned(SaveDllProc) then
  	SaveDllProc(Reason);
end;

(*
	Función exportada que es llamada desde el demonio para cerrar los
  recursos que se hayan podido utilizar.
  En este caso, cerramos las conexiones de la bd que se hayan quedado
  abiertas
*)
function Finaliza(Tarea : TTarea) : string; export;
begin
	Result := '';
  SeccionCritica.Leave;

end;

exports
	Inicializa,
	Ejecuta,
  Finaliza;

begin

  SeccionCritica := TCriticalSection.Create;
	// Me guardo la rutina de procesado por defecto

  ClientesFTP := TDictionary<Integer, TIdFTP>.Create;
  SaveDllProc := DllProc;
  DllProc := @LibExit;
end.
