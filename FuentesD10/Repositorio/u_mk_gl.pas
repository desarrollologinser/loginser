unit u_mk_gl;

interface

uses pfibdataset,sysutils,pfibquery, system.IniFiles, System.IOUtils;

function busca_cli(id:integer):string;                //devuelve nombre de cliente a partir de id
function busca_serv_ref(ref:string):string;           //devuelve nombre de servicio a partir de ref
function busca_serv_ref_id(ref:string):integer;       //devuelve id de servicio a partir de ref
function busca_tarea_ref_id(ref:string):integer;       //devuelve id de tarea a partir de ref (Is)
function busca_tarea_ref(ref:string):string;          //devuelve nombre de tarea a partir de ref (Is)

procedure leer_ini_manipulado;

var
    dbmanip, resdir, skinname,
    dir_correos, dir_xls_correos, dir_remoto, tarea_correos,
    dir_save: string;
    id_usuario, id_empresa, id_recogida, x, y, w, z: Integer;

implementation

uses u_globals, u_dm;

{$REGION 'INI'}

procedure leer_ini_manipulado;
var ini:tinifile;
begin
  exe:=ExtractFileName(ParamStr(0));
  exe:=Copy(exe,1,Length(exe)-4);

  ruta_exe:=ExtractFilePath(ParamStr(0));
  IncludeTrailingPathDelimiter(ruta_exe);

  if FileExists(ruta_exe+'lgs.ini') then ruta_ini:=ruta_exe+'lgs.ini'          //al lado del exe o en C
    else if FileExists('C:\lgs.ini') then ruta_ini:='C:\lgs.ini'
              else if FileExists(Copy(ruta_exe,0,Pos('Documents\',ruta_exe)+9)+'lgs.ini') then ruta_ini:=Copy(ruta_exe,0,Pos('Documents\',ruta_exe)+9)+'lgs.ini'
                    else raise exception.Create('No Encontrado lgs.ini');


  ini:=TIniFile.Create(ruta_ini);
  try
    id_usuario:=strtoint(ini.readstring('User','id_usuario',''));
    id_empresa:=strtoint(ini.readstring('User','id_empresa',''));
    dbmanip:=ini.readstring('BD','dbname','');
    resdir:=ini.ReadString('Resources','res_dir','Resources\');
    skinname:=ini.ReadString('Resources','skinname','WLM');
//    scanner_id:=strtoint(ini.readstring('Datos','scanner_id','0'));
//    ruta_upd:=ini.ReadString('Datos','ruta_upd','\\Anubis\LGS App\Exes\');
//    ruta_m:=ini.ReadString('Datos','ruta_m','C:\');
//    tactil:=StrToInt(ini.ReadString('Datos','tactil','0'));
//    imp_def:=ini.readstring('Datos','imp_def','');
//    imp_eti:=ini.readstring('Datos','imp_eti','');
//    imp_eti2:=ini.readstring('Datos','imp_eti2','');
//    imp_eti_chrono:=ini.readstring('Datos','imp_eti_chrono','');
//    cent_lect:=StrToInt(ini.ReadString('Datos','cent_lect','0'));
//    voice_id:=StrToInt(ini.ReadString('Datos','voice_id','1'));
//    email_global_disc:=ini.readstring('Datos','email_global_disc','sys@loginser.com');

    dir_correos := ini.ReadString('Manipulados', 'dir_correos', 'C:\');
    dir_xls_correos := ini.ReadString('Manipulados', 'dir_xls_correos', 'C:\');
    dir_remoto := ini.ReadString('Manipulados', 'dir_remoto','\\seth\SysFiles\Correos\');
    tarea_correos := ini.ReadString('Manipulados', 'tarea_correos', '54');
    id_recogida := StrToInt(ini.ReadString('Manipulados', 'id_recogida', '280'));
    dir_save := ini.ReadString('Manipulados', 'dir_save', 'C:\');
    x:=StrToInt(ini.ReadString('Posiciones',exe+'_x','-1'));
    y:=StrToInt(ini.ReadString('Posiciones',exe+'_y','-1'));
    w:=StrToInt(ini.ReadString('Posiciones',exe+'_w','-1'));
    h:=StrToInt(ini.ReadString('Posiciones',exe+'_h','-1'));
  finally
    ini.free;
  end;

end;

{$ENDREGION 'INI'}

{$REGION 'Busquedas'}

function busca_cli(id:integer):string;
begin                                       //devuelve nombre de cliente a partir de id
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select nombre from g_clientes where id_cliente='+inttostr(id)+
      ' and id_empresa='+inttostr(u_globals.id_empresa));
    Open;
    if not(IsEmpty) then Result:=FieldByName('nombre').asstring
      else Result:='ERR';
    Free;
  end;
end;

function busca_serv_ref(ref:string):string;
begin                                       //devuelve nombre de servicio a partir de ref
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select nombre from m_servicios where referencia='+quotedstr(ref)+
      ' and id_empresa='+inttostr(u_globals.id_empresa));
    Open;
    if not(IsEmpty) then Result:=FieldByName('nombre').asstring
      else Result:='ERR';
    Free;
  end;
end;

function busca_serv_ref_id(ref:string):integer;
begin                                       //devuelve id de servicio a partir de ref
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select id_servicio from m_servicios where referencia='+quotedstr(ref)+
      ' and id_empresa='+inttostr(u_globals.id_empresa));
    Open;
    if not(IsEmpty) then Result:=FieldByName('id_servicio').asinteger
      else Result:=-1;
    Free;
  end;
end;

function busca_tarea_ref(ref:string):string;
begin
     with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select descripcion from m_tareas_clientes ' +
                       'where referencia='+quotedstr(ref) +
                       ' and id_empresa='+inttostr(u_globals.id_empresa));
    Open;
    if not(IsEmpty) then Result:=FieldByName('descripcion').asstring
      else Result:='ERR';
    Free;
  end;
end;

function busca_tarea_ref_id(ref:string):integer;
begin
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select id_tarea from m_tareas_clientes where referencia='+quotedstr(ref)+
      ' and id_empresa='+inttostr(u_globals.id_empresa));
    Open;
    if not(IsEmpty) then Result:=FieldByName('id_tarea').asinteger
      else Result:=-1;
    Free;
  end;
end;


{$ENDREGION}

end.
