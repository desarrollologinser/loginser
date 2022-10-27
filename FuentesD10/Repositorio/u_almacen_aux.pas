unit u_almacen_aux;

interface

uses pfibdataset,SysUtils,pfibquery,pFIBStoredProc;

function busca_doc(doc:string):string;
function busca_doc_id(id:integer):string;
function busca_doc_doc(doc:string):integer;
function busca_doc_entra(doc:string):string;
function busca_provee(id:integer):string;
function busca_cli(id:integer):string;
function busca_art(id:string):string;
function busca_art_id(ref:string):integer;
function busca_alm(id:integer):string;
function busca_ubic(id:integer):string;
function busca_tipomov(id:integer):string;
function busca_art_cli(ref_art:string; id_cli:Integer):string;
function busca_ubic_alm(id_ubic,id_alm:Integer):string;
function busca_zona(id:integer):string;
function alm_tiene_ubic(id_alm:integer):Boolean;
procedure tipomov_det(id:integer; var signo,unidades:string);
procedure lee_inis_entrada;
function get_id_moacab:integer;
procedure graba_nuevo_moacab(var id_moacab:Integer; id_doc:Integer; fecha:tdatetime; hora:TdateTime; id_usuario,id_cliente,id_proveedor:Integer;
  albaran,transportista,matricula,observaciones,estado:string);
procedure graba_nuevo_moalin(id_moacab,linea,id_articulo,id_almacen_org,id_ubicacion_org,id_almacen_dst,id_ubicacion_dst,
  cantidad,id_tipomov,linea_org:Integer;  estado:string);
function verifica_moacab_stock(id_moacab:Integer):integer;
procedure elimina_moacab(id_moacab:Integer);
function actualiza_stock(id_moacab:Integer; desactualiza:string):integer;
procedure genera_lineas_relacionadas(id_moacab:integer);

var
  id_almacen_entra,id_tipomov_entra,id_ubic_entra,id_provee_entra:integer;    //Defaults para entrada
  doc_entra,mask_doc_entra,ruta_alb_entrada,email_alm_host,email_alm_user,email_alm_pass,email_alm_dir:AnsiString;

implementation

uses u_dm, u_globals;

{$REGION 'Ini'}
procedure lee_inis_entrada;                  //Lee inis de la tabla G_AUX para almacen
begin
  with tpfibdataset.create(dm) do
  try
    database:=dm.db;
    close;
    sqls.SelectSQL.Clear;
    sqls.selectsql.Add('select doc_entra,id_almacen_entra,id_ubic_entra,id_tipomov_entra,id_provee_entra,ruta_alb_entrada, '+
      'email_alm_host,email_alm_user,email_alm_pass,email_alm_dir,mask_doc_entra '+
      'from g_aux '+
      'where id_empresa='+inttostr(u_globals.id_empresa));
    open;

    if not(isempty) then begin
      doc_entra:=fieldbyname('doc_entra').Asstring;
      id_almacen_entra:=fieldbyname('id_almacen_entra').asinteger;
      id_ubic_entra:=fieldbyname('id_ubic_entra').asinteger;
      id_tipomov_entra:=fieldbyname('id_tipomov_entra').asinteger;
      id_provee_entra:=FieldByName('id_provee_entra').AsInteger;
      ruta_alb_entrada:=FieldByName('ruta_alb_entrada').asstring;
      email_alm_host:=fieldbyname('email_alm_host').AsString;
      email_alm_user:=FieldByName('email_alm_user').AsString;
      email_alm_pass:=FieldByName('email_alm_pass').AsString;
      email_alm_dir:=FieldByName('email_alm_dir').AsString;
      mask_doc_entra:=FieldByName('mask_doc_entra').AsString;
    end else raise exception.Create('Error Cargando Valores Iniciales De La BD');
  finally
    free;
  end;
end;
{$ENDREGION}

{$REGION 'Busquedas'}
function busca_doc(doc:string):string;
begin                                       //devuelve nombre de documento a partir del doc
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select nombre from g_documentos where documento='+quotedstr(doc)+
      ' and id_empresa='+inttostr(u_globals.id_empresa));
    Open;
    Result:=FieldByName('nombre').asstring;
    Free;
  end;
end;

function busca_doc_id(id:integer):string;
begin                                       //devuelve nombre de documento a partir del id_doc
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select documento from g_documentos where id_doc='+inttostr(id)+
      ' and id_empresa='+inttostr(u_globals.id_empresa));
    Open;
    Result:=FieldByName('documento').asstring;
    Free;
  end;
end;

function busca_doc_entra(doc:string):string;
begin                                       //devuelve nombre de documento a partir del doc y que sea de entrada
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select nombre from g_documentos where documento='+quotedstr(doc)+
      ' and documento like '''+mask_doc_entra+''' and id_empresa='+inttostr(u_globals.id_empresa));
    Open;
    Result:=FieldByName('nombre').asstring;
    Free;
  end;
end;

function busca_doc_doc(doc:string):integer;
begin                                       //devuelve id de documento a partir del doc
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select id_doc from g_documentos where documento='+quotedstr(doc)+
      ' and id_empresa='+inttostr(u_globals.id_empresa));
    Open;
    Result:=FieldByName('id_doc').asinteger;
    Free;
  end;
end;

function busca_provee(id:integer):string;
begin                                       //devuelve nombre de proveedor
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select nombre from g_proveedores where id_proveedor='+inttostr(id)+
      ' and id_empresa='+inttostr(u_globals.id_empresa));
    Open;
    Result:=FieldByName('nombre').asstring;
    Free;
  end;
end;

function busca_cli(id:integer):string;
begin                                       //devuelve nombre de cliente
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select nombre from g_clientes where id_cliente='+inttostr(id)+
      ' and id_empresa='+inttostr(u_globals.id_empresa));
    Open;
    Result:=FieldByName('nombre').asstring;
    Free;
  end;
end;

function busca_art(id:string):string;
begin                                       //devuelve nombre de articulo a partir de referencia
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select nombre from g_articulos where codigo='+quotedstr(id)+
      ' and id_empresa='+inttostr(u_globals.id_empresa));
    Open;
    Result:=FieldByName('nombre').asstring;
    Free;
  end;
end;

function busca_art_id(ref:string):integer;
begin                                       //devuelve id de articulo a partir de referencia
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select id_articulo from g_articulos where codigo='+quotedstr(ref)+
      ' and id_empresa='+inttostr(u_globals.id_empresa));
    Open;

    if not(IsEmpty) then Result:=FieldByName('id_articulo').asinteger
    else result:=0;
    
    Free;
  end;
end;

function busca_alm(id:integer):string;
begin                                     //devuelve nombre de almacen
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select nombre from a_almacenes where id_almacen='+inttostr(id)+
      ' and id_empresa='+inttostr(u_globals.id_empresa));
    Open;
    Result:=FieldByName('nombre').asstring;
    Free;
  end;
end;

function busca_ubic(id:integer):string;
begin                                      //devuelve nombre de ubicacion
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select id_calle,id_posicion,id_altura from a_ubicaciones where id_ubicacion='+inttostr(id)+
      ' and id_empresa='+inttostr(u_globals.id_empresa));
    Open;
    if not(IsEmpty) then Result:=FieldByName('id_calle').asstring+'-'+FieldByName('id_posicion').asstring+'-'+
      FieldByName('id_altura').asstring
    else result:='';
    Free;
  end;
end;

function busca_tipomov(id:integer):string;
begin                                      //devuelve nombre de tipo de movimiento
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select nombre from a_tipomov where id_tipomov='+inttostr(id)+
      ' and id_empresa='+inttostr(u_globals.id_empresa));
    Open;
    Result:=FieldByName('nombre').asstring;
    Free;
  end;
end;

function busca_art_cli(ref_art:string; id_cli:Integer):string;
begin                                       //comprueba que el articulo sea del cliente
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select nombre from g_articulos where codigo='+quotedstr(ref_art)+
      ' and id_cliente='+inttostr(id_cli)+
      ' and id_empresa='+inttostr(u_globals.id_empresa));
    Open;
    Result:=FieldByName('nombre').asstring;
    Free;
  end;
end;

function busca_ubic_alm(id_ubic,id_alm:Integer):string;
begin                                       //comprueba que la ubicacion sea del almacen
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select id_calle,id_posicion,id_altura from a_ubicaciones where id_ubicacion='+inttostr(id_ubic)+
      ' and id_almacen='+inttostr(id_alm)+
      ' and id_empresa='+inttostr(u_globals.id_empresa));
    Open;

    if not(isempty) then Result:=FieldByName('id_calle').asstring+'-'+FieldByName('id_posicion').asstring+'-'+
      FieldByName('id_altura').asstring
    else result:='';
    Free;
  end;
end;

function alm_tiene_ubic(id_alm:integer):Boolean;
begin                                     //devuelve nombre de almacen
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select tiene_ubic from a_almacenes where id_almacen='+inttostr(id_alm)+
      ' and id_empresa='+inttostr(u_globals.id_empresa));
    Open;
    Result:=UpperCase(FieldByName('tiene_ubic').asstring)='S';
    Free;
  end;
end;

procedure tipomov_det(id:integer; var signo,unidades:string);
begin                                    //devuelve signo y unidades de tipo de movimiento
  with TpFIBStoredProc.Create(dm) do
  try
    Database:=dm.db;
    Transaction:=dm.t_read;
    ExecProcedure('A_GET_TIPOMOV_DETALLE',[id,u_globals.id_empresa]);
    signo:=fieldbyname('signo').AsString;
    unidades:=FieldByName('afecta_unidades').AsString;
  finally
    free;
  end;
end;

function busca_zona(id:integer):string;
begin                                     //devuelve nombre de zona
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select nombre from a_zonas where id_zona='+inttostr(id)+
      ' and id_empresa='+inttostr(u_globals.id_empresa));
    Open;
    Result:=FieldByName('nombre').asstring;
    Free;
  end;
end;
{$ENDREGION}

{$REGION 'Procesos'}
function get_id_moacab:integer;                      //Obtiene nuevo numero de ID_MOACAB
begin
  with TpFIBStoredProc.Create(dm) do
  try
    Database:=dm.db;
    Transaction:=dm.t_read;
    ExecProcedure('A_GET_ID_MOACAB');
    result:=fieldbyname('id_moacab').AsInteger;
  finally
    free;
  end;
end;

procedure graba_nuevo_moacab(var id_moacab:integer; id_doc:Integer; fecha:tdatetime; hora:TdateTime; id_usuario,id_cliente,id_proveedor:Integer;
  albaran,transportista,matricula,observaciones,estado:string);
begin
  id_moacab:=get_id_moacab;                    //nuevo numero de moacab

  with TpFIBQuery.Create(dm) do                //graba cabecera de movimiento de almacen(y devuelve el id_moacab que ha generado)
  try
    database:=dm.db;
    Transaction:=dm.t_write;
    sql.add('insert into a_moacab (id_moacab,id_doc,fecha,hora,id_usuario,id_cliente,id_proveedor,albaran,transportista,matricula,observaciones,estado,id_empresa) '+
      ' values (:id_moacab,:id_doc,:fecha,:hora,:id_usuario,:id_cliente,:id_proveedor,:albaran,:transportista,:matricula,:observaciones,:estado,:id_empresa)');
    ParamByName('id_moacab').AsInteger:=id_moacab;
    ParamByName('id_doc').AsInteger:=id_doc;
    ParamByName('fecha').asstring:=formatdatetime('dd.mm.yyyy',fecha);
    ParamByName('hora').asstring:=formatdatetime('hh:nn:ss',hora);
    ParamByName('id_usuario').AsInteger:=id_usuario;
    ParamByName('id_cliente').AsInteger:=id_cliente;
    ParamByName('id_proveedor').AsInteger:=id_proveedor;
    ParamByName('albaran').Asstring:=albaran;
    ParamByName('transportista').Asstring:=transportista;
    ParamByName('matricula').Asstring:=matricula;
    ParamByName('observaciones').Asstring:=observaciones;
    ParamByName('estado').Asstring:=estado;
    ParamByName('id_empresa').AsInteger:=u_globals.id_empresa;

    ExecQuery;                                   //gestionar transaccion desde fuera
  finally
    free;
  end;
end;

procedure graba_nuevo_moalin(id_moacab,linea,id_articulo,id_almacen_org,id_ubicacion_org,id_almacen_dst,id_ubicacion_dst,
  cantidad,id_tipomov,linea_org:Integer;  estado:string);
begin
  with TpFIBQuery.Create(dm) do                //graba linea de movimiento de almacen
  try
    database:=dm.db;
    Transaction:=dm.t_write;
    sql.add('insert into a_moalin (id_moacab,linea,id_articulo,id_almacen_org,id_ubicacion_org,id_almacen_dst,id_ubicacion_dst,cantidad,id_tipomov,linea_org,id_empresa,estado) '+
      ' values (:id_moacab,:linea,:id_articulo,:id_almacen_org,:id_ubicacion_org,:id_almacen_dst,:id_ubicacion_dst,:cantidad,:id_tipomov,:linea_org,:id_empresa,:estado)');
    ParamByName('id_moacab').AsInteger:=id_moacab;
    ParamByName('linea').AsInteger:=linea;
    ParamByName('id_articulo').AsInteger:=id_articulo;
    ParamByName('id_almacen_org').AsInteger:=id_almacen_org;
    ParamByName('id_ubicacion_org').AsInteger:=id_ubicacion_org;
    ParamByName('id_almacen_dst').AsInteger:=id_almacen_dst;
    ParamByName('id_ubicacion_dst').AsInteger:=id_ubicacion_dst;
    ParamByName('cantidad').AsInteger:=cantidad;
    ParamByName('id_tipomov').AsInteger:=id_tipomov;
    ParamByName('linea_org').AsInteger:=linea_org;
    ParamByName('id_empresa').AsInteger:=u_globals.id_empresa;
    ParamByName('estado').Asstring:=estado;

    ExecQuery;                          //gestionar transaccion desde fuera
  finally
    free;
  end;
end;

function verifica_moacab_stock(id_moacab:Integer):integer;     //0=ok 1=error_fecha 2=error_stock
begin                                 //Verifica que los articulos de moacab sigan todos
                                      //en el mismo sitio en el stock y que sea de hoy o ayer
  with TpFIBStoredProc.Create(dm) do
  try
    Database:=dm.db;
    Transaction:=dm.t_read;
    ExecProcedure('A_VERIFICA_MOACAB_MODIF',[id_moacab,u_globals.id_empresa]);
    result:=fieldbyname('error').AsInteger;
  finally
    free;
  end;
end;

procedure elimina_moacab(id_moacab:Integer);      //Deshace Movimiento de almacen
begin
  dm.t_write.StartTransaction;
  try
    with TpFIBStoredProc.Create(dm) do
    try
      Database:=dm.db;
      Transaction:=dm.t_write;
      ExecProcedure('A_ELIMINA_MOACAB',[id_moacab,u_globals.id_empresa]);
      if fieldbyname('error').AsInteger<>0 then raise exception.Create('');
    finally
      free;
    end;
  except
    dm.t_write.Rollback;
    raise exception.Create('Error En El Proceso');
  end;
  dm.t_write.Commit;
end;
                                                                              //N-Normal S-Desactualiza
function actualiza_stock(id_moacab:Integer; desactualiza:string):integer;     //Error(0=ok,1=error tipomov,2=no_movs)
begin                                                                         //Actualiza el stock del movimiento
  with TpFIBStoredProc.Create(dm) do
  try
    Database:=dm.db;
    Transaction:=dm.t_write;
    ExecProcedure('A_ACTUALIZA_STOCK',[id_moacab,u_globals.id_empresa,desactualiza]);
    result:=fieldbyname('error').AsInteger;
  finally
    free;
  end;
end;

procedure genera_lineas_relacionadas(id_moacab:integer);      //Genera las lineas del movimiento que tienen tipos de mov relacionados
begin
              //verificar antes que la linea que genera no haya generado ya antes otra linea

end;
{$ENDREGION}

end.
