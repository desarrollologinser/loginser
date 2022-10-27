unit UServerUpdate;

interface

uses
  Windows,Forms,IniFiles,SysUtils,DateUtils,Dialogs, ShellApi,Classes,sListBox;

  procedure CheckActServer(ApplicationFileName:String);
  function TieneQueActualizar(FichLocal,FichServer:String):BooleaN;
  // Funciones auxiliares:
  function DameRutaExeServerdeIni(Ini:String): String;
  function GetDefaultIniName(App:String): String;
  procedure AbreEnlaceConParametros(Str,Params:String);
  procedure CierraEnlace(Str:String; Params:String);
  function obtenerFechasFichero (const FileName: string; var Modified: TDateTime): Boolean;
  procedure FindFiles(StartDir, FileMask: string;
             recursively: boolean; var FilesList: TStringList);
  function CopyDirectory(const Directory, DestinationFolder: String; const GUI, SimpleGUI, CopyConfirmation,
             MkDirConfirmation, ErrorGUI: Boolean; var UserHasCancelled: Boolean): Boolean;
  procedure ActualizaFicherosDe(FileLocal,FileServer:String; ListaVCL:TsListBox);
  function ejecutadaYa (nombreAplicacion : string) : boolean;

Const
        AppUpdate:String='ServerUpdate.exe';
        _SecIni:String='Datos';
        _Varini:String='ServerApp';

implementation


procedure CierraEnlace(Str:String; Params:String);
begin
        shellexecute(Application.handle,'close',Pchar(Str),PChar(Params),nil,SW_HIDE);
end;

function DameRutaExeServerdeIni(Ini:String): String;
var
  oIni: TiniFile;
  IniStr:String;
begin
  IniStr:='';
  if(FIleexists(Ini))then
  begin
        try
                oIni := TInifile.Create(Ini);
                IniStr    :=  oIni.ReadString(_SecIni, _Varini, '');
        finally
                oIni.Free;
        end;
  end;
  Result:=IniStr;
end;

function GetDefaultIniName(App:String): String;
var
  pcadena: PChar;
  Lcodigo: DWORD;
  WinDir,AppIni: String;
begin
  AppIni:=Changefileext(App,'.ini');
  if not(Fileexists(Appini))then
  begin
        Appini:=Extractfilename(AppIni);
        // Seleccionamos directorio de Windoze
        Lcodigo := MAX_PATH; // Variable de WINDOWS.
        GetMem(pcadena, LCodigo + 1);
        GetWindowsDirectory(pcadena, Lcodigo);
        WinDir := StrPas(pcadena);
        FreeMem(pcadena);
        if (WinDir[Length(WinDir)] <> '\') then WinDir := WinDir + '\';
        AppIni:= WinDir + AppIni;
  end;
  Result :=AppIni;
end;

function obtenerFechasFichero (const FileName: string; var Modified: TDateTime): Boolean;
var
      h: THandle;
      Info1, Info2, Info3: TFileTime;
      SysTimeStruct: SYSTEMTIME;
      TimeZoneInfo: TTimeZoneInformation;
      Bias: Double;
begin
      Result := False;
      Bias   := 0;
      h      := FileOpen(FileName, fmOpenRead or fmShareDenyNone);
      if h > 0 then
      begin
        try
          if GetTimeZoneInformation(TimeZoneInfo) <> $FFFFFFFF then
            Bias := TimeZoneInfo.Bias / 1440; // 60x24
          GetFileTime(h, @Info1, @Info2, @Info3);
          if FileTimeToSystemTime(Info3, SysTimeStruct) then
            Modified := SystemTimeToDateTime(SysTimeStruct) - Bias;
          Result := True;
        finally
          FileClose(h);
        end;
      end;
end;

function TieneQueActualizar(FichLocal,FichServer:String):BooleaN;
var
        Actualizar:Boolean;
        FechaLocal,FechaServer:TDatetime;

begin
        Actualizar:=False;
        if(FichLocal<>'')and(FichServer<>'')then
        begin
              obtenerFechasFichero(FichServer,FechaServer);
              obtenerFechasFichero(FichLocal,FechaLocal);
              Actualizar:=(FechaLocal<FechaServer);
        end;
        Result:=Actualizar;
end;

procedure FindFiles(StartDir, FileMask: string;
                 recursively: boolean; var FilesList: TStringList);
const
  MASK_ALL_FILES = '*.*';
  CHAR_POINT = '.';
var
  SR: TSearchRec;
  DirList: TStringList;
  IsFound: Boolean;
  i: integer;
begin
  if (StartDir[length(StartDir)] <> '\') then
  begin
    StartDir := StartDir + '\';
  end;

  // Crear la lista de ficheos en el dir. StartDir (no directorios!)
  IsFound := FindFirst(StartDir + FileMask,
                  faAnyFile - faDirectory, SR) = 0;

  // MIentras encuentre
  while IsFound do begin
    FilesList.Add(StartDir + SR.Name);
    IsFound := FindNext(SR) = 0;
  end;

  FindClose(SR);

  // Recursivo?
  if (recursively) then begin
    // Build a list of subdirectories
    DirList := TStringList.Create;
    // proteccion
    try

    //IsFound := FindFirst(StartDir + MASK_ALL_FILES,
    IsFound := FindFirst(StartDir + FileMask,
                   faAnyFile, SR) = 0;
    while IsFound do
    begin
      if ((SR.Attr and faDirectory) <> 0) and
          (SR.Name[1] <>  CHAR_POINT) then
      begin
        DirList.Add(StartDir + SR.Name);
      end; // if
      IsFound := FindNext(SR) = 0;
    end; // while
    FindClose(SR);
    // Scan the list of subdirectories
    for i := 0 to DirList.Count - 1 do begin
      FindFiles(DirList[i], FileMask, recursively, FilesList);
    end;

    finally
      DirList.Free;
    end;
  end;
end;

function CopyDirectory(const Directory, DestinationFolder: String; const GUI,
  SimpleGUI, CopyConfirmation, MkDirConfirmation, ErrorGUI: Boolean; var UserHasCancelled: Boolean): Boolean;
var
        FOS : TSHFileOpStruct;
        Flags: Word;
begin
        Flags:= 0;
        if GUI then if SimpleGUI then Flags:= Flags or FOF_SIMPLEPROGRESS
        else Flags:= Flags or FOF_SILENT;

        if not CopyConfirmation then Flags:= Flags or FOF_NOCONFIRMATION;
        if not MkDirConfirmation then Flags:= Flags or FOF_NOCONFIRMMKDIR;
        if not ErrorGUI then Flags:= Flags or FOF_NOERRORUI;

        ZeroMemory(@FOS,SizeOf(FOS));
        with FOS do
        begin
              wFunc := FO_COPY;
              fFlags := Flags;
              pFrom := PChar(Directory + #0);
              pTo := PChar(DestinationFolder)
        end;
        RESULT := (0 = ShFileOperation(FOS));
        UserHasCancelled:= FOS.fAnyOperationsAborted;
end;

procedure AbreEnlaceConParametros(Str,Params:String);
begin
        shellexecute(Application.handle,'open',Pchar(Str),Pchar(Params),nil,sw_show);
end;

procedure FicherosAActualizar(DirLocal:String; var ListaFicherosServer:TStringList);
var
    i:Integer;
    FileLocal,FileServer:String;
begin
    for i:=ListaFicherosServer.Count-1 downto 0 do
    begin
        FileLocal:=DirLocal+extractfilename(ListaFicherosServer[i]);
        FileServer:=ListaFicherosServer[i];
        if not(TieneQueActualizar(FileLocal,FileServer))then
              ListaFicherosServer.Delete(i);
    end;
end;

procedure CheckActServer(ApplicationFileName:String);
var
        Enlace,FicheroLocal,FicheroServer:String;
        ListaFicheros:TStringList;
begin
        try
              ListaFicheros:=TStringList.create;

              // Aplicacion Local (Sxxi, Estandar, Etc...):
              FicheroLocal:=ApplicationFileName;

              // Aplicación Enlace (Server Update):
              Enlace:=Extractfilepath(FicheroLocal)+AppUpdate;

              // Fichero en el servidor de la aplicación obtenido del ini de configuración (Sxxi, Estandar, etc...):
              FicheroServer:=DameRutaExeServerdeIni(GetDefaultIniName(FicheroLocal));
        except
              Enlace:='';
              FicheroServer:='';
        end;

        try
              if((Enlace<>'')
              and(Fileexists(Enlace)))then
              begin
                      if((FicheroServer<>'')
                      and(DirectoryExists(extractfilepath(FicheroServer))))then
                      begin
                          FindFiles(extractfilepath(FicheroServer), extractfilename(Application.ExeName), True, ListaFicheros);
                          FicherosAActualizar(extractfilepath(FicheroLocal),ListaFicheros);
                          if(ListaFicheros.Count>0)then
                          begin
                                try
                                        try
                                             // Abrimos la aplicación local:
                                             AbreEnlaceConParametros(Enlace,FicheroLocal);
                                        finally
                                             Application.Terminate;
                                        end;
                                except
                                        //
                                end;
                          end;
                      end;
              end;
        except
              //
        end;
end;

procedure ActualizaFicherosDe(FileLocal,FileServer:String; ListaVCL:TsListBox);
var
  AActualizar:TStringList;
  indxfile:Integer;
  AFileLocal,AFileServer:String;
  CanceladoUser:Boolean;
begin
        try
              CanceladoUser:=False;
              AActualizar:=TStringList.Create;
              if((FileServer<>'')
              and(Fileexists(FileServer)))then
              begin
                      FindFiles(extractfilepath(FileServer), '*.*', True, AActualizar);
                      FicherosAActualizar(extractfilepath(FileLocal),AActualizar);
                      ListaVCL.Items.Clear;
                      ListaVCL.Items.AddStrings(AActualizar);
                      if(AActualizar.Count>0)then
                      begin
                            ListaVCL.visible:=true;
                            Application.ProcessMessages;
                            for indxfile := 0 to AActualizar.Count-1 do
                            begin
                                    try
                                            ListaVCL.ItemIndex:=indxfile;
                                            Application.ProcessMessages;
                                            AFileLocal:=extractfilepath(FileLocal)+extractfilename(AActualizar[indxfile]);
                                            AFileServer:=AActualizar[indxfile];
                                            if(TieneQueActualizar(AFileLocal,AFileServer))then
                                            begin
                                                  ListaVCL.Items[indxfile]:='[-] Actualizando '+ListaVCL.Items[indxfile];
                                                  Application.ProcessMessages;
                                                  if(uppercase(AFileLocal)=uppercase(FileLocal))then
                                                  begin
                                                        ListaVCL.Items[indxfile]:='[-] Renombrando '+ListaVCL.Items[indxfile];
                                                        Application.ProcessMessages;
                                                        if(FIleexists(FileLocal+'_old'))then
                                                              deletefile(FileLocal+'_old');
                                                        if not(Renamefile(FileLocal,FileLocal+'_old'))then
                                                        begin
                                                                CopyDirectory(FileLocal,FileLocal+'_old',false,false,false,false,true,CanceladoUser);
                                                                deletefile(FileLocal);
                                                                Application.ProcessMessages;
                                                        end;
                                                  end;
                                                  if(DeleteFile(AFileLocal))then
                                                  begin
                                                        CopyDirectory(AFileServer,AFileLocal,false,false,false,false,true,CanceladoUser);
                                                        ListaVCL.Items[indxfile]:='[+] Actualizado '+ListaVCL.Items[indxfile];
                                                        Application.ProcessMessages;
                                                  end;
                                            end;
                                    except
                                            //
                                    end;
                            end;
                      end;
              end;
        except
              //
        end;
        AActualizar.Clear;
        freeandnil(AActualizar);
end;

function ejecutadaYa (nombreAplicacion : string) : boolean;
var
  MiMutex : Thandle;
begin
  mimutex := CreateMutex(nil, true, pchar(nombreAplicacion));
  if MiMutex = 0 then
    result := false
  else
  begin
    if GetLastError = ERROR_ALREADY_EXISTS then
      result := true
    else
      result := false;
  end;
end;
end.
