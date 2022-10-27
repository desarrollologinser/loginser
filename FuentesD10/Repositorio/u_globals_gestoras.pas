unit u_globals_gestoras;

interface

uses inifiles, SysUtils, System.types,pfibdataset, pFIBQuery;

procedure ini_bd_gestoras;
procedure leer_ini_gestoras;
function calcula_pais(code:string):string;
function get_estado_albaran(id_albaran:integer):string;
function get_estado_valor(estado:string):integer;
function get_albaran_data(data:string;id_albaran:integer):string;
function get_serv_hor_cliente(id_cliente:integer):string;
function CargarDatosTablaGestoras(tabla,campos,criterios: string):string;
function CargarDatosTablaGestorasArray(tabla,campos,criterios: string):string;
function get_agencia(id_cliente:Integer; peso: Double; pais, provincia, cod_postal:string):integer;
function calcula_pais_lgs_x_titulo(tit:string):string;
function get_nombre_servicio(id:integer):string;
function get_nombre_horario(id:integer):string;
function get_nombre_usuario(id:integer):string;
function get_nombre_agencia(id:integer):string;
function get_email_albaran(id:integer):string;
function existe_albaran(id:Integer):Boolean;
procedure dame_servicio_horario_age(agencia,serv,hora,retorno:integer; out servicio_agencia, horario_agencia:string);
function inserta_estado_albaran(albaran,usuario,estado:Integer; obs:string):string;
function get_nombre_estado(id:integer):string;
function get_agrup_agencia(agencia:Integer):integer;
function get_direccion_completa(cli,dir:integer):string;
procedure update_exp_age_albaran(albaran: Integer; exp:string);
function get_nombre_cliente(id:integer):string;
procedure inserta_adjunto_albaran(albaran,attach_id: Integer; tipo, tipo_doc, doc, tit, nom_ape:string);
function get_ruta_logo(id:integer):string;
function existe_cod_postal(cp:string):Boolean;
var
  db_gestoras,exe,ruta_exe, ruta_ini:string;

implementation

uses u_dm;

procedure leer_ini_gestoras;
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
    db_gestoras := ini.readstring('Datos','db_gestoras','');
  finally
    ini.free;
  end;

end;
procedure ini_bd_gestoras;
begin
  if dm.db_gestoras.Connected then dm.db_gestoras.Connected:=false;

  dm.db_gestoras.DBName:=db_gestoras;                                             //conecta la BD Gestoras
  dm.db_gestoras.Connected:=true;
end;

function calcula_pais(code:string):string;
begin
    Result := '';

    with dm.qTempGest do
    begin
      Close;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select pais from sys_paises where pais_c2=:code');
      ParamByName('code').AsString := code;
      Open;

      if not IsEmpty then
          Result := FieldByName('pais').AsString;
    end;
end;

function calcula_pais_lgs_x_titulo(tit:string):string;
begin
    Result := '';

    with dm.qrytemp do
    begin
      Close;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select codigo_pais from get_pais_x_tit_cliente(:tit)');
      ParamByName('tit').AsString := tit;
      Open;

      if not IsEmpty then
          Result := FieldByName('codigo_pais').AsString;
    end;
end;

function get_estado_albaran(id_albaran:integer):string;
begin
    Result := '';

    with dm.qTempGest do
    begin
      Close;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select e.estado, e.titulo, e.cambios_manuales from albaranes a ' +
                         'inner join estados e on e.estado=a.estado ' +
                         'where id_albaran=:id_albaran');
      ParamByName('id_albaran').asinteger := id_albaran;
      Open;

      if not IsEmpty then
          Result := FieldByName('titulo').AsString+'|'+FieldByName('estado').AsString+'|'+FieldByName('cambios_manuales').AsString;


    end;
end;

function get_estado_valor(estado:string):integer;
begin
    Result := -1000000;

    with dm.qTempGest do
    begin
      Close;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select ' + estado + ' from estados_config');
      Open;

      if not IsEmpty then
          Result := FieldByName(estado).AsInteger;
    end;
end;

function get_albaran_data(data:string;id_albaran:integer):string;
begin
    Result := '';

    with dm.qTempGest do
    begin
      Close;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select ' + data + ' from albaranes a ' +
                         'where id_albaran=:id_albaran');
      ParamByName('id_albaran').asinteger := id_albaran;
      Open;

      if not IsEmpty then
          Result := FieldByName(data).AsString;
    end;
end;

function get_serv_hor_cliente(id_cliente:integer):string;
begin
    Result := '';

    with dm.qTempGest do
    begin
      Close;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select tipo_servicio,horario from clientes ' +
                         'where cliente=:id_cliente');
      ParamByName('id_cliente').asinteger := id_cliente;
      Open;

      if not IsEmpty then
          Result := FieldByName('tipo_servicio').AsString + '|' + FieldByName('horario').AsString ;
    end;
end;


function CargarDatosTablaGestoras(tabla,campos,criterios: string):string;
var
  i: integer;
begin

   Result := '';
   with tpfibdataset.Create(dm) do begin
    try
      database:=dm.db_gestoras;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select ' + campos +
                         ' from ' + tabla);
      if criterios<>'' then
         SQLs.SelectSQL.Add(' where ' + criterios);
      Open;

      if not(IsEmpty) then
      begin
        for i:=0 to fields.Count-1 do
        begin
          result := Result + fields[i].Text + '#';
        end;
      end;

      Result := Copy(Result,0,Length(result)-1);
    finally
        free;
    end;
   end;
end;

function CargarDatosTablaGestorasArray(tabla,campos,criterios: string):string;
var
  i: integer;
begin

   Result := '';
   with tpfibdataset.Create(dm) do begin
    try
      database:=dm.db_gestoras;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select ' + campos +
                         ' from ' + tabla);
      if criterios<>'' then
         SQLs.SelectSQL.Add(' where ' + criterios);
      Open;

      if not(IsEmpty) then
      begin
       First;
       while not eof do
       begin
          for i:=0 to fields.Count-1 do
          begin
            result := Result + fields[i].Text + '#';
          end;

          Result := Copy(Result,0,Length(result)-1) + '*';
          Next;
       end;
      end;

      Result := Copy(Result,0,Length(result)-1);
    finally
        free;
    end;
   end;
end;

function get_agencia(id_cliente:Integer; peso: Double; pais, provincia, cod_postal:string):integer;
var
  id_cl_gest:integer;
begin
   Result := -1;
   id_cl_gest := -1;

   with tpfibdataset.Create(dm) do begin
    try
      database:=dm.db_gestoras;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select id_cliente from clientes where cliente=:id_cliente');
      ParamByName('id_cliente').AsInteger := id_cliente;
      Open;
      if not(IsEmpty) then
          id_cl_gest := FieldByName('id_cliente').AsInteger;

      if id_cliente>=0 then
      begin
        Close;
        SQLs.SelectSQL.Clear;
        SQLs.SelectSQL.Add('select agencia from dame_agencia_def(:id_cliente,:peso,:pais,:provincia,:cod_postal)');
        ParamByName('id_cliente').AsInteger := id_cl_gest;
        ParamByName('peso').AsFloat := peso;
        ParamByName('pais').AsString := pais;
        ParamByName('provincia').AsString := provincia;
        ParamByName('cod_postal').AsString := cod_postal;
        Open;

        if not(IsEmpty) then
            result := FieldByName('agencia').AsInteger;
      end;

    finally
        free;
    end;
   end;
end;

function get_nombre_servicio(id:Integer):string;
begin
    Result := '';

    with dm.qTempGest do
    begin
      Close;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select descripcion from servicios ' +
                         'where codigo=:id');
      ParamByName('id').asinteger := id;
      Open;

      if not IsEmpty then
          Result := FieldByName('descripcion').AsString;
    end;
end;

function get_nombre_horario(id:Integer):string;
begin
    Result := '';

    with dm.qTempGest do
    begin
      Close;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select descripcion from horarios ' +
                         'where horario=:id');
      ParamByName('id').asinteger := id;
      Open;

      if not IsEmpty then
          Result := FieldByName('descripcion').AsString;
    end;
end;

function get_nombre_usuario(id:Integer):string;
begin
    Result := '';

    with dm.qTempGest do
    begin
      Close;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select nombre from sys_usuarios ' +
                         'where usuario=:id');
      ParamByName('id').asinteger := id;
      Open;

      if not IsEmpty then
          Result := FieldByName('nombre').AsString;
    end;
end;

function get_nombre_agencia(id:Integer):string;
begin
    Result := '';

    with dm.qTempGest do
    begin
      Close;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select nombre from agencias ' +
                         'where agencia=:id');
      ParamByName('id').asinteger := id;
      Open;

      if not IsEmpty then
          Result := FieldByName('nombre').AsString;
    end;
end;

procedure dame_servicio_horario_age(agencia,serv,hora,retorno:integer; out servicio_agencia, horario_agencia:string);
begin
   with dm.qTempGest do
    begin
      Close;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select tipo_servicio_age,horario_age ' +
                         'from dame_servicio_horario_age(:agencia,:servicio,:horario,:retorno) ');
      ParamByName('agencia').asinteger := agencia;
      ParamByName('servicio').asinteger := serv;
      ParamByName('horario').asinteger := hora;
      ParamByName('retorno').asinteger := retorno;

      Open;

      if not IsEmpty then
      begin
          servicio_agencia := FieldByName('tipo_servicio_age').AsString;
          horario_agencia := FieldByName('horario_age').AsString;
      end;
    end;
end;

function get_email_albaran(id:Integer):string;
begin
    Result := '';

    with dm.qTempGest do
    begin
      Close;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select first 1 email from albaran_dest ' +
                         'where id_albaran=:id');
      ParamByName('id').asinteger := id;
      Open;

      if not IsEmpty then
          Result := FieldByName('email').AsString;
    end;
end;

function existe_albaran(id:Integer):boolean;
begin
    with dm.qTempGest do
    begin
      Close;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select * from albaranes where id_albaran=:id');
      ParamByName('id').asinteger := id;
      Open;

      Result := not IsEmpty;
    end;
end;

function inserta_estado_albaran(albaran,usuario,estado: Integer; obs:string):string;
begin
    result := '';
    with TpFIBQuery.Create(nil) do
    try
       try
        Database := dm.db_gestoras;
        Transaction := dm.t_write_gestoras;

        sql.Add('insert into alb_tracking (id_albaran,usuario,estado,observaciones,descripcion) ');
        SQL.Add('values (:id_albaran, :usuario, :estado,:obs,:descr)');
        ParamByName('id_albaran').AsInteger := albaran;
        ParamByName('usuario').AsInteger := usuario;
        ParamByName('estado').AsInteger := estado;
        ParamByName('obs').AsString := obs;
        ParamByName('descr').AsString := get_nombre_estado(estado);

        dm.t_write_gestoras.StartTransaction;
        execquery;
        dm.t_write_gestoras.commit;
       except on e:exception do
              begin
                dm.t_write_gestoras.Rollback;
                result := e.Message;
              end;
       end;

    finally
       Free;
    end;

end;

function get_nombre_estado(id:Integer):string;
begin
    Result := '';

    with dm.qTempGest do
    begin
      Close;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select titulo from estados ' +
                         'where estado=:id');
      ParamByName('id').asinteger := id;
      Open;

      if not IsEmpty then
          Result := FieldByName('titulo').AsString;
    end;
end;

 function get_agrup_agencia(agencia:Integer):integer;
begin
   Result := -1;
   with tpfibdataset.Create(dm) do begin
    try
      database:=dm.db_gestoras;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select agrup_pack from agencias where agencia=:agencia');
      ParamByName('agencia').AsInteger := agencia;
      Open;

      if not(IsEmpty) then
          result := FieldByName('agrup_pack').AsInteger;
    finally
        free;
    end;
   end;
end;

 function get_direccion_completa(cli,dir:Integer):string;
begin

   with tpfibdataset.Create(dm) do begin
    try
      database:=dm.db_gestoras;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select d.* from cli_direcciones_def d ' +
                         'inner join clientes cl on cl.id_cliente=d.id_cliente ' +
                         'where cl.cliente=:cli and d.codigo=:dir');
      ParamByName('cli').AsInteger := cli;
      ParamByName('dir').AsInteger := dir;
      Open;

      if not(IsEmpty) then
          result := FieldByName('nombre').AsString        + '|' +
                    FieldByName('calle').AsString         + '|' +
                    FieldByName('cod_postal').AsString    + '|' +
                    FieldByName('localidad').AsString     + '|' +
                    FieldByName('provincia').AsString     + '|' +
                    FieldByName('telefono01').AsString    + '|' +
                    FieldByName('telefono02').AsString    + '|' +
                    FieldByName('email').AsString         + '|' +
                    FieldByName('contacto').AsString      + '|' +
                    FieldByName('pais').AsString          + '|' +
                    FieldByName('cod_provincia').AsString + '|';
    finally
        free;
    end;
   end;
end;

procedure update_exp_age_albaran(albaran: Integer; exp:string);
begin
    with TpFIBQuery.Create(nil) do
    try
       try
        Database := dm.db_gestoras;
        Transaction := dm.t_write_gestoras;

        sql.Add('update albaranes '  +
               'set expedicion_age=:exp ' +
                'where id_albaran=:id_albaran' );
        ParamByName('id_albaran').AsInteger := albaran;
        ParamByName('exp').AsString := exp;

        dm.t_write_gestoras.StartTransaction;
        execquery;
        dm.t_write_gestoras.commit;
       except
         dm.t_write_gestoras.Rollback;
       end;

    finally
       Free;
    end;

end;

function get_nombre_cliente(id:Integer):string;
begin
    Result := '';

    with dm.qTempGest do
    begin
      Close;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select nombre_r_social from clientes ' +
                         'where cliente=:id');
      ParamByName('id').asinteger := id;
      Open;

      if not IsEmpty then
          Result := FieldByName('nombre_r_social').AsString;
    end;
end;


function get_ruta_logo(id:Integer):string;
begin
    Result := '';

    with dm.qTempGest do
    begin
      Close;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select ruta_logo from clientes ' +
                         'where cliente=:id');
      ParamByName('id').asinteger := id;
      Open;

      if not IsEmpty then
          Result := FieldByName('ruta_logo').AsString;
    end;
end;

procedure inserta_adjunto_albaran(albaran,attach_id: Integer; tipo, tipo_doc, doc, tit, nom_ape:string);
begin
    with TpFIBQuery.Create(nil) do
    try
       try
        Database := dm.db_gestoras;
        Transaction := dm.t_write_gestoras;

        sql.Add('insert into albaran_adjuntos (id_albaran,attachment_id,tipo,tipo_documento, documento, ' +
                'titulo, nombre_apellidos) ');
        SQL.Add('values (:id_albaran,:attachment_id,:tipo,:tipo_documento, :documento :titulo, :nombre_apellidos)');
        ParamByName('id_albaran').AsInteger := albaran;
        ParamByName('attachment_id').AsInteger := attach_id;
        ParamByName('tipo').AsString := tipo;
        //ParamByName('tipo_documento').AsString := tipo_doc;
        ParamByName('tipo_documento').Clear;
        ParamByName('documento').AsString := doc;
        ParamByName('titulo').AsString := tit;
        ParamByName('nombre_apellidos').AsString := nom_ape;

        dm.t_write_gestoras.StartTransaction;
        execquery;
        dm.t_write_gestoras.commit;
       except
         dm.t_write_gestoras.Rollback;
       end;

    finally
       Free;
    end;

end;

function existe_cod_postal(cp:string):Boolean;
begin
    with dm.qTempGest do
    begin
      Close;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select * from sys_localidades where codigo_postal=:cp');
      ParamByName('cp').AsString := cp;
      Open;

      Result := not IsEmpty;
    end;
end;

end.
