unit u_globals;

interface

uses inifiles,sysutils,FIBDataSet,pFIBDataSet,classes,Grids, JvStringGrid,
      math,graphics,sdialogs,dialogs,controls,forms, DB, pFIBQuery, sDBEdit,registry,
      Windows,fib;

procedure leer_ini;
procedure ini_bd;
procedure guardar_ini;
procedure guardar_ini_skin;
procedure guardar_pos;
procedure graba_log(data:string);
procedure ErrorBaseDatos(E: EDatabaseError);
procedure dimensionasg(sg: tjvstringgrid; maxw:integer= -1; minw:integer=-1);
procedure ver_estado_actualizacion(Dataset: TDataset);
procedure check_color_estado(estado:char; form:tform);
function ruta_escritorio:string;  //devuelve la ruta del escritorio

const
  def_ed_color=$00E1E1FF;      //color de los edits blokeados/suprimidos

var
  id_usuario,id_empresa,id_grupo,x,y,w,h,hue,saturation,scanner_id,tactil:integer;
  password,usuario,empresa,exe,ruta_exe,permiso,dbname,skinname,resdir,hint,ruta_upd,ruta_ini:string;
  imp_def,imp_eti:string;

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
    tactil:=StrToInt(ini.ReadString('Datos','tactil','0'));
    imp_def:=ini.readstring('Datos','imp_def','');
    imp_eti:=ini.readstring('Datos','imp_eti','');
    x:=StrToInt(ini.ReadString('Posiciones',exe+'_x','-1'));
    y:=StrToInt(ini.ReadString('Posiciones',exe+'_y','-1'));
    w:=StrToInt(ini.ReadString('Posiciones',exe+'_w','-1'));
    h:=StrToInt(ini.ReadString('Posiciones',exe+'_h','-1'));
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
{$ENDREGION}

{$REGION 'Bd'}
procedure ini_bd;
var
  Component:TComponent;  i:integer;
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
     //  application.terminate;
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
    database:=dm.db;
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
