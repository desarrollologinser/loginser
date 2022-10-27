unit u_globals;

interface

uses inifiles,sysutils,FIBDataSet,pFIBDataSet,classes,Grids, JvStringGrid,
      math,graphics,sdialogs,dialogs,controls,forms, DB, pFIBQuery, sDBEdit,registry,
      Windows,fib, Vcl.StdCtrls, Winapi.ShellAPI, Winapi.WinSock;

procedure leer_ini;
procedure ini_bd;
procedure leer_ini_bbdd(id_usuario:Integer);
procedure guarda_ini_bbdd(id_usuario:integer;campo,valor_str:string;valor_int:Integer);
procedure nuevo_usuario_ini(id_usuario:Integer);
procedure ini_bd_simple;
procedure guardar_ini;
procedure guardar_ini_skin;
procedure guardar_pos;
procedure graba_log(data:string);
procedure ErrorBaseDatos(E: EDatabaseError);
procedure dimensionasg(sg: tjvstringgrid; maxw:integer= -1; minw:integer=-1);
procedure ver_estado_actualizacion(Dataset: TDataset) overload;
procedure ver_estado_actualizacion(Dataset1,Dataset2: TDataset) overload;
procedure check_color_estado(estado:char; form:tform);
function ruta_escritorio:string;  //devuelve la ruta del escritorio
function GetComputerName : String;  //devuelve nombre del PC
function get_id_almacen_def(cent_lect:Integer):integer;
procedure log(Mensaje, ruta_log: String);
function MyMessageDialog(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; Captions: array of string): Integer;
function obtenerUsuarioRed : Ansistring;
function LocalIP : string;
function ComputerName():String;
procedure leer_ini_red;

const
  def_ed_color=$00E1E1FF;      //color de los edits blokeados/suprimidos
  ruta_ini_red = '\\192.168.0.6:\Lgs App\Exes\config.ini';

var
  id_usuario,id_empresa,id_grupo,x,y,w,h,hue,saturation,scanner_id,tactil,cent_lect,voice_id,id_almacen_def:integer;
  password,usuario,empresa,exe,ruta_exe,permiso,dbname,skinname,resdir,hint,ruta_upd,ruta_ini,ruta_m, db_gestoras,
  imp_def,imp_eti,imp_eti2,imp_eti_chrono,pc_name,email_global_disc, imp_eti_italiaPEQ, imp_eti_italiaGRA, db_sql,
  api, desktop, xls_seur, db_lgsp, imp_doc, alm_usuario, usuario_nom:string;

implementation

uses u_dm;

{$REGION 'Inis'}
procedure leer_ini;
var ini:tinifile;
begin
  exe:=ExtractFileName(ParamStr(0));
  exe:=Copy(exe,1,Length(exe)-4);

  ruta_exe:=ExtractFilePath(ParamStr(0));
  IncludeTrailingPathDelimiter(ruta_exe);

  if FileExists(ruta_exe+'config.ini') then ruta_ini:=ruta_exe+'config.ini'          //al lado del exe o en C
    else if FileExists('C:\config.ini') then ruta_ini:='C:\config.ini'
      else raise exception.Create('No Encontrado Config.ini');


  ini:=TIniFile.Create(ruta_ini);
  try
    id_usuario:=strtoint(ini.readstring('Datos','id_usuario',''));
    id_empresa:=strtoint(ini.readstring('Datos','id_empresa',''));
    dbname:=ini.readstring('Datos','dbname','');
    resdir:=ini.ReadString('Datos','resdir','Resources\');
    skinname:=ini.ReadString('Datos','skinname','WLM');
    scanner_id:=strtoint(ini.readstring('Datos','scanner_id','0'));
    ruta_upd:=ini.ReadString('Datos','ruta_upd','\\Anubis\LGS App\Exes\');
    ruta_m:=ini.ReadString('Datos','ruta_m','C:\');
    tactil:=StrToInt(ini.ReadString('Datos','tactil','0'));
    imp_def:=ini.readstring('Datos','imp_def','');
    imp_eti:=ini.readstring('Datos','imp_eti','');
    imp_eti2:=ini.readstring('Datos','imp_eti2','');
    imp_eti_chrono:=ini.readstring('Datos','imp_eti_chrono','');
    imp_eti_italiaPEQ:=ini.readstring('Datos','imp_eti_italiaPEQ','');
    imp_eti_italiaGRA:=ini.readstring('Datos','imp_eti_italiaGRA','');
    imp_doc:=ini.readstring('Datos','imp_doc','');
    cent_lect:=StrToInt(ini.ReadString('Datos','cent_lect','1'));
    voice_id:=StrToInt(ini.ReadString('Datos','voice_id','1'));
    email_global_disc:=ini.readstring('Datos','email_global_disc','sys@loginser.com');
    x:=StrToInt(ini.ReadString('Posiciones',exe+'_x','-1'));
    y:=StrToInt(ini.ReadString('Posiciones',exe+'_y','-1'));
    w:=StrToInt(ini.ReadString('Posiciones',exe+'_w','-1'));
    h:=StrToInt(ini.ReadString('Posiciones',exe+'_h','-1'));

    db_sql := ini.readstring('Datos','db_sql','');
    api := ini.readstring('Datos','api','');
    desktop := ini.readstring('Datos','desktop','');

    usuario_nom := ini.readstring('Datos','usuario_nom','');

  finally
    ini.free;
  end;

end;

procedure guardar_ini;
var ini:tinifile;
begin                     //Guarda datos al ini
  ini:=tinifile.create(ruta_ini);
  try
    ini.writestring('Datos','id_usuario',inttostr(id_usuario));
    ini.WriteString('Datos','id_empresa',IntToStr(id_empresa));
    ini.WriteString('Datos','usuario_nom',usuario_nom);
  finally
    ini.free;
  end;
end;

procedure guardar_ini_skin;
var ini:tinifile;
begin                     //Guarda datos al ini
  ini:=tinifile.create(ruta_ini);
  try
    ini.writestring('Datos','skinname',skinname);
  finally
    ini.free;
  end;
end;
  
procedure guardar_pos;
var ini:tinifile;
begin                     //Guarda POSICION al ini
  ini:=tinifile.create(ruta_ini);
  try
    ini.writestring('Posiciones',exe+'_x',inttostr(x));
    ini.writestring('Posiciones',exe+'_y',inttostr(y));
    ini.writestring('Posiciones',exe+'_w',inttostr(w));
    ini.writestring('Posiciones',exe+'_h',inttostr(h));
  finally
    ini.free;
  end;
end;


procedure leer_ini_bbdd(id_usuario:Integer);
begin
       with tpfibdataset.Create(dm) do
       try
          database:=dm.db;

          Close;
          SelectSQL.Clear;
          selectsql.Add('select * from s_inis where ((id_usuario=:id_usuario) or (id_usuario=0)) ' +
                        'order by id_usuario desc');
          ParamByName('id_usuario').AsInteger := id_usuario;
          open;


          if not eof then
          begin
            xls_seur := fieldbyname('xls_seur').asstring;
            if fieldbyname('api').asstring<>'' then
               api := fieldbyname('api').AsString;
            alm_usuario := fieldbyname('almacenes').AsString;
          end
          else
          begin
             nuevo_usuario_ini(id_usuario);
             xls_seur := '';
          end;

       finally
          Free;
       end;
end;


procedure guarda_ini_bbdd(id_usuario:integer;campo,valor_str:string;valor_int:Integer);
begin
  with tpFIBQuery.Create(dm) do
  try
    database:= dm.db;
    Transaction:=dm.t_write;
    sql.Add('update s_inis set ' + campo + '=');

    if valor_int<0 then
        sql.Add(QuotedStr(valor_str))
    else
        SQL.Add(IntToStr(valor_int));

    SQL.Add(' where id_usuario=:id_usuario');
    ParamByName('id_usuario').AsInteger:=id_usuario;

    dm.t_write.StartTransaction;

    ExecQuery;

    dm.t_write.Commit;
  finally
    Free;
  end;
end;

procedure nuevo_usuario_ini(id_usuario:integer);
begin
  with tpFIBQuery.Create(dm) do
  try
    database:= dm.db;
    Transaction:=dm.t_write;
    sql.Add('insert into s_inis (id_usuario) values (:id_usuario)');

    ParamByName('id_usuario').AsInteger:=id_usuario;

    dm.t_write.StartTransaction;

    ExecQuery;

    dm.t_write.Commit;
  finally
    Free;
  end;
end;

procedure leer_ini_red;
begin
  exe:=ExtractFileName(ParamStr(0));
  exe:=Copy(exe,1,Length(exe)-4);

  ruta_exe:=ExtractFilePath(ParamStr(0));
  IncludeTrailingPathDelimiter(ruta_exe);

  if FileExists(ruta_ini_red) then ruta_ini:=ruta_ini_red;

end;


{$ENDREGION}

{$REGION 'Bd'}
procedure ini_bd_simple;
begin
  if dm.db.Connected then dm.db.Connected:=false;

  dm.db.DBName:=dbname;                                             //conecta la BD
  dm.db.Connected:=true;


    with tpfibdataset.Create(dm) do
  try
    database:=dm.db;
                                                                    //Lee Empresa
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select nombre from g_empresas where id_empresa='+inttostr(id_empresa));
    Open;

    if not(IsEmpty) then empresa:=FieldByName('nombre').asstring
     else begin
       smessagedlg('Empresa No Encontrada, Error De Inicialización',mterror,[mbOk],0);
       application.terminate;
     end;
                                                                    //Lee usuario
    close;
    SQLs.SelectSQL.clear;
    SQLs.selectsql.add('select id_grupo,usuario,contrasena from g_usuarios where id_usuario='+inttostr(id_usuario)+
                       ' and id_empresa='+inttostr(id_empresa));
    Open;

    if (isempty) then begin
          smessagedlg('Usuario No Encontrado, Error De Inicialización',mterror,[mbOk],0);
          application.terminate;
    end;

    if cent_lect>=0 then
    begin
      Close;
      SelectSQL.Clear;
      selectsql.Add('select id_almacen from get_almacen(:centro_lectura)');
      ParamByName('centro_lectura').AsInteger:=cent_lect;
      open;
      id_almacen_def := fieldbyname('id_almacen').asinteger;
    end;

  finally
    Free;
  end;

end;


function get_id_almacen_def(cent_lect:Integer):Integer;
begin
  if cent_lect>=0 then
  begin
       with tpfibdataset.Create(dm) do
       try
        database:=dm.db;

        Close;
        SelectSQL.Clear;
        selectsql.Add('select id_almacen from get_almacen(:centro_lectura)');
        ParamByName('centro_lectura').AsInteger:=cent_lect;
        open;
        if not eof then
          id_almacen_def := fieldbyname('id_almacen').asinteger
          else id_almacen_def:=1;
       finally
          Free;
       end;
      Result:= id_almacen_def
  end
  else Result:= 1;
end;

procedure ini_bd;
var
  Component:TComponent;  i:integer;
begin
  if dm.db.Connected then
      dm.db.Connected:=false;

  dm.db.DBName:=dbname;                                             //conecta la BD
  dm.db.Connected:=true;

  {if db_sql<>'' then
  begin
    if dm.con1.Connected then dm.con1.Connected:=false;
    dm.con1.ConnectionString := db_sql;
    dm.con1.Connected := True;
  end;
  }

  with tpfibdataset.Create(dm) do
  try
    database:=dm.db;
                                                                    //Lee Empresa
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select nombre from g_empresas where id_empresa='+inttostr(id_empresa));
    Open;

    if not(IsEmpty) then empresa:=FieldByName('nombre').asstring
     else begin
       smessagedlg('Empresa No Encontrada, Error De Inicialización',mterror,[mbOk],0);
       application.terminate;
     end;
                                                                    //Lee usuario
    close;
    SQLs.SelectSQL.clear;
    SQLs.selectsql.add('select id_grupo,usuario,contrasena from g_usuarios where id_usuario='+inttostr(id_usuario)+
                       ' and id_empresa='+inttostr(id_empresa));
    Open;

    if not(isempty) then begin
      if FieldByName('contrasena').asstring<>password then begin
           smessagedlg('Password Incorrecto, Error De Inicialización',mterror,[mbOk],0);
           application.terminate;
        end else begin
          usuario:=fieldbyname('usuario').asstring;
          id_grupo:=FieldByName('id_grupo').asinteger;
        end;
    end
    else begin
          smessagedlg('Usuario No Encontrado, Error De Inicialización',mterror,[mbOk],0);
          application.terminate;
    end;

                                                                    //Comprueba permisos
    close;
    SQLs.SelectSQL.clear;
    SQLs.selectsql.add( 'select p.permiso,m.saturacion,m.hue,m.hint '+
                        'from g_permisos p '+
                        'inner join g_menu m on (p.id_menu=m.id_menu) '+
                        'where p.id_grupo='+inttostr(id_grupo)+' and m.nom_exe='+quotedstr(exe)+
                        ' and p.permiso in (''E'',''L'',''T'')');
    open;

    if not(IsEmpty) then begin
      permiso:=FieldByName('permiso').asstring;
      saturation:=FieldByName('saturacion').AsInteger;
      hue:=FieldByName('hue').asinteger;
      hint:=FieldByName('hint').asstring;
    end else begin
      smessagedlg('Usuario Sin Permisos En Este Área, Error De Inicialización',mterror,[mbOk],0);
      application.terminate;
    end;

    if cent_lect>=0 then
    begin
      Close;
      SelectSQL.Clear;
      selectsql.Add('select id_almacen from get_almacen(:centro_lectura)');
      ParamByName('centro_lectura').AsInteger:=cent_lect;
      open;
      id_almacen_def := fieldbyname('id_almacen').asinteger;
    end;

  finally
    Free;
  end;
  
  //graba_log('0-'+exe+'-Acceso Correcto');                     //graba cada acceso correcto
                                                                //deberia grabar los accesos incorrectos con datos de pc,usuario,etc

  for i := 0 to dm.ComponentCount-1 do begin                    //cambia permisos en los tdataset del dm
    Component:=dm.Components[i];
    if Component is TpFIBDataSet then
     with Component as TpFIBDataSet do begin
       if ((UpperCase(u_globals.permiso)='E') or (uppercase(u_globals.permiso)='T')) then
         AllowedUpdateKinds:=[ukModify,ukInsert,ukDelete]
       else AllowedUpdateKinds:=[];
     end;
  end;
end;

//0-acceso correcto 1-acceso incorrecto
//2-operacion

procedure graba_log(data:string);
begin
  with tpFIBQuery.Create(dm) do
  try
    database:= dm.db;
    Transaction:=dm.t_write;
    sql.Add('insert into g_log (id_usuario,fecha,hora,datos) values '+
      '(:id_usuario,:fecha,:hora,:datos)');
    ParamByName('id_usuario').AsInteger:=id_usuario;
    ParamByName('fecha').AsDate:=Date;
    ParamByName('hora').AsTime:=Time;
    ParamByName('datos').AsString:=data;

    dm.t_write.StartTransaction;

    ExecQuery;

    dm.t_write.Commit;
  finally
    Free;
  end;
end;

procedure ver_estado_actualizacion(Dataset: TDataset);
begin
   if dataset.state in [dsedit,dsinsert] then begin
     if messagedlg('Existen actualizaciones pendientes ¿Desea actualizarlas?',mtconfirmation,[mbyes,mbno],0)=mryes then
         dataset.post
      else
         dataset.cancel;
   end;
end;

procedure ver_estado_actualizacion(Dataset1,Dataset2: TDataset);
begin
   if ((dataset1.state in [dsedit,dsinsert]) or (dataset2.state in [dsedit,dsinsert])) then begin
     if messagedlg('Existen actualizaciones pendientes ¿Desea actualizarlas?',mtconfirmation,[mbyes,mbno],0)=mryes then begin
        if dataset1.state in [dsedit,dsinsert] then dataset1.post;
        if dataset2.state in [dsedit,dsinsert] then dataset2.post;
     end else begin
        if dataset1.state in [dsedit,dsinsert] then dataset1.cancel;
        if dataset2.state in [dsedit,dsinsert] then dataset2.cancel;
     end;
   end;
end;

procedure ErrorBaseDatos(E: EDatabaseError);
begin                        //Captura mensajes de error de las excepciones de Firebird desde el OnPostError de los dm.datasets
  if E is EFIBError then begin
    case EFIBError(E).IBErrorCode of
      335544349: smessagedlg('Valor Duplicado. Ya Existe Un Registro Igual Al Selecionado.'+#13+#13+#13+
                             'Except: (' + E.Message + ')',mtError,[mbok],0);
      335544569: smessagedlg('Clave Primaria Duplicada. Ya Existe Un Registro Igual Al Selecionado (Con El Mismo ID).'+#13+#13+#13+
                             'Except: (' + E.Message + ')',mtError,[mbok],0);
      else smessagedlg('Except: '+IntToStr(EFIBError(E).IBErrorCode)+#13#10#13#10+E.Message,mterror,[mbok],0);
    end;
    SysUtils.Abort;
  end;
end;
{$ENDREGION}

{$REGION 'Visuals'}
procedure check_color_estado(estado:char; form:tform);
var  i:integer;    Component:TComponent;   ed_color:tcolor;   customcolor:Boolean;
begin                                            //cambia color de edits del form (tag=0) si bloqueado o suprimido
  if estado='A' then begin
    CustomColor:=true;
    ed_color:=clWindow;
  end;
  if ((estado='B') or (estado='S')) then begin
    CustomColor:=false;
    ed_color:=def_ed_color;
  end;

  for i := 0 to form.ComponentCount-1 do begin
    Component:=form.Components[i];
    if ((Component is tsdbedit) and (Component.Tag=0)) then
     with Component as tsdbedit do begin
      skindata.customcolor:=customcolor;
      color:=ed_color;
     end;
  end;
end;
{$ENDREGION}

{$REGION 'Procesos'}
function ruta_escritorio:string;
var
  sEscritorio: String;
  Registro: TRegistry;
begin
  sEscritorio:='';
  Registro := TRegistry.Create;

  // Leemos la ruta del escritorio
  try
    Registro.RootKey := HKEY_CURRENT_USER;

    if Registro.OpenKey( '\Software\Microsoft\Windows\CurrentVersion\explorer\Shell Folders', True ) then
      sEscritorio := Registro.ReadString( 'Desktop' );
  finally
    Registro.CloseKey;
    Registro.Free;
  end;

  result:=sEscritorio;
end;

function GetComputerName : String;
var
   pcComputer : PChar;
   dwCSize    : DWORD;
begin
   dwCSize := MAX_COMPUTERNAME_LENGTH + 1;
   GetMem( pcComputer, dwCSize );
   try
      if Windows.GetComputerName( pcComputer, dwCSize ) then
         Result := pcComputer;
   finally
      FreeMem( pcComputer );
   end;
end;


function LocalIP : string;
type
  TaPInAddr = array [0..10] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  phe : PHostEnt;
  pptr : PaPInAddr;
  Buffer : array [0..63] of ansichar;
  I : Integer;
  GInitData : TWSADATA;
begin
  WSAStartup($101, GInitData);
  Result := '';
  GetHostName(Buffer, SizeOf(Buffer));
  phe := GetHostByName(buffer);
  if phe = nil then Exit;
    pptr := PaPInAddr(Phe^.h_addr_list);
  I := 0;
  while pptr^[I] <> nil do
  begin
    result:=StrPas(inet_ntoa(pptr^[I]^));
    Inc(I);
  end;
  WSACleanup;
end;

function ComputerName():String;
var
  ComputerName: Array [0 .. 256] of ansichar;
begin
  GetHostName(ComputerName, SizeOf(ComputerName));
  Result := ComputerName;
end;

function obtenerUsuarioRed : Ansistring;
var
  dwI : DWord;
begin
  dwI := MAX_PATH;
  SetLength (Result, dwI + 1);
  if WNetGetUser (Nil, PChar (Result), dwI) = NO_ERROR then
   Result := PChar (Result)
  else
    SetLength (Result, 0)
end;

procedure log(Mensaje, ruta_log: String);
var
  F: TextFile;
  Filename: String;
  Mutex: THandle;
begin
  // Insertamos la fecha y la hora
  Mensaje:= FormatDateTime('[ddd dd mmm, hh:nn] ', Now) + ' ' + IntToStr(id_usuario) + '' + Mensaje;
  // El nombre del archivo es igual al del ejecutable, pero con la extension .log
  //Filename:= ChangeFileExt(ParamStr(0),'.log');
  if not FileExists(ruta_log) then
     FileCreate(ruta_log);
  Filename:= ChangeFileExt(ruta_log,'.log');
  // Creamos un mutex, usando como identificador unico la ruta completa del ejecutable
  Mutex:= CreateMutex(nil,FALSE,
    PChar(StringReplace(ParamStr(0),'\','/',[rfReplaceAll])));

  if Mutex <> 0 then
  begin
    // Esperamos nuestro turno para escribir
    WaitForSingleObject(Mutex, INFINITE);
    try
      // Comprobamos el tamaño del archivo
     { if FindFirst(Filename,faAnyFile,SearchRec) = 0 then
      begin
        // Si es mayor de un mega lo copiamos a (nombre).log.1
        if SearchRec.Size > (1024*1024) then
          MoveFileEx(PChar(Filename),PChar(Filename + '.1'),
            MOVEFILE_REPLACE_EXISTING);
        FindClose(SearchRec);
      end;    }
      try
        AssignFile(F, Filename);
        {$I-}
          Append(F);
        if IOResult <> 0 then
          Rewrite(F);
        {$I+}
        if IOResult = 0 then
        begin
          // Escribimos el mensaje
          Writeln(F,Mensaje);
          CloseFile(F);
        end;
      except
        //
      end;
    finally
      ReleaseMutex(Mutex);
      CloseHandle(Mutex);
    end;
  end;
end;

function MyMessageDialog(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; Captions: array of string): Integer;
var
  aMsgDlg: TForm;
  i: Integer;
  dlgButton: TButton;
  CaptionIndex: Integer;
begin
  { Create the Dialog }
  { Dialog erzeugen }
  aMsgDlg := CreateMessageDialog(Msg, DlgType, Buttons);
  captionIndex := 0;
  { Loop through Objects in Dialog }
  { Über alle Objekte auf dem Dialog iterieren}
  for i := 0 to aMsgDlg.ComponentCount - 1 do
  begin
   { If the object is of type TButton, then }
   { Wenn es ein Button ist, dann...}
    if (aMsgDlg.Components[i] is TButton) then
    begin
      dlgButton := TButton(aMsgDlg.Components[i]);
      if CaptionIndex > High(Captions) then Break;
      { Give a new caption from our Captions array}
      { Schreibe Beschriftung entsprechend Captions array}
      dlgButton.Caption := Captions[CaptionIndex];
      Inc(CaptionIndex);
    end;
  end;
  Result := aMsgDlg.ShowModal;
end;
{$ENDREGION}

{$REGION 'Grids'}
procedure dimensionasg(sg: tjvstringgrid; maxw:integer= -1; minw:integer=-1);
var
  colw: integer;    r,c: integer;       s: ansistring;
begin
  with sg do for c:=0 to ColCount -1 do begin
    colw:= 0;
    if ColWidths[c]>0 then for r:= 0 to RowCount -1 do begin
      if RowHeights[r]>0 then begin
        s:= cells[c,r];
        if (c=colcount-1) or (r=RowCount-1) {or (c=2) or (r=2)} then canvas.Font.Style:= [fsBold] else canvas.Font.Style:= [];
        colw:= math.Max(colw,Canvas.TextWidth(s));
      end;
    end;
    if colw>0 then colw:= colw+5;
    ColWidths[c]:= colw;
  end;
end;
{$ENDREGION}

end.
