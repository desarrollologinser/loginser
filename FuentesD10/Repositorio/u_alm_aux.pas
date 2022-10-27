unit u_alm_aux;

interface

uses pfibdataset,SysUtils,pfibquery,pFIBStoredProc;

function busca_art_id(ref:string):integer;
function busca_art_ref(id:integer):string;
function busca_art(id:integer):string;
function busca_art_nom(ref:string):string;
function busca_art_ref_cod_cli(cod_cli:string; id_cliente:integer):string;
function busca_art_cod_cli(id_art:integer):string;
function busca_art_cli(id:integer):integer;
function busca_alm(id:integer):string;
function busca_zona(id:integer):string;
function busca_cli(id:integer):string;
function busca_ubic(id_alm,id_zona:Integer; id_estant:string; id_pos,id_alt:Integer; id_sub1,id_sub2:string):integer;
function busca_lote_nom(id:integer):string;
function format_ubic(id_alm,id_zona:Integer; id_estant:string; id_pos,id_alt:Integer; id_sub1,id_sub2:string):string;
function format_ubic_id(id_ubic:Integer):string;
procedure nueva_ubicacion(id_alm,id_zona:Integer; id_estant:string; id_pos,id_alt:Integer; id_sub1,id_sub2:string);
function tiene_lote(id:Integer):Boolean;
function tiene_imei(id:Integer):Boolean;
function cuenta_refs_x_codigo(cod:string):integer;
function busca_attach_id(id_art:integer):integer;

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

function busca_art_ref(id:integer):string;
begin                                       //devuelve referencia de articulo a partir de id
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select codigo from g_articulos where id_articulo='+inttostr(id)+
      ' and id_empresa='+inttostr(u_globals.id_empresa));
    Open;

    if not(IsEmpty) then Result:=FieldByName('codigo').asstring
    else result:='ERR';

    Free;
  end;
end;

function busca_art_ref_cod_cli(cod_cli:string; id_cliente:integer):string;
begin                                       //devuelve referencia de articulo a partir de codigo de cliente y cliente
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select codigo from g_articulos where codigo_cli=:codigo_cli '+
      ' and id_cliente=:id_cliente');
    ParambyName('codigo_cli').asstring:=cod_cli;
    ParambyName('id_cliente').asinteger:=id_cliente;
    Open;

    if not(IsEmpty) then Result:=FieldByName('codigo').asstring
    else result:='ERR';

    Free;
  end;
end;

function busca_art_cod_cli(id_art:integer):string;
begin                                       //devuelve  codigo de cliente a partir de id
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select codigo_cli from g_articulos where id_articulo=:id_articulo');
    ParambyName('id_articulo').asinteger:=id_art;
    Open;

    if not(IsEmpty) then Result:=FieldByName('codigo_cli').asstring
    else result:='ERR';

    Free;
  end;
end;

function busca_art(id:integer):string;
begin                                       //devuelve nombre de articulo a partir de id
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select nombre from g_articulos where id_articulo='+inttostr(id)+
      ' and id_empresa='+inttostr(u_globals.id_empresa));
    Open;
    Result:=FieldByName('nombre').asstring;
    Free;
  end;
end;

function busca_art_nom(ref:string):string;
begin                                       //devuelve nombre de articulo a partir de referencia
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select nombre from g_articulos where codigo='''+ref+
      ''' and id_empresa='+inttostr(u_globals.id_empresa));
    Open;
    Result:=FieldByName('nombre').asstring;
    Free;
  end;
end;

function busca_art_cli(id:integer):integer;
begin                                       //devuelve id_cliente de articulo a partir de id_articulo
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select id_cliente from g_articulos where id_articulo='+inttostr(id)+
      ' and id_empresa='+inttostr(u_globals.id_empresa));
    Open;
    Result:=FieldByName('id_cliente').asinteger;
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
    if not(IsEmpty) then Result:=FieldByName('nombre').asstring
      else Result:='ERR';
    Free;
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
    if not(IsEmpty) then Result:=FieldByName('nombre').asstring
      else Result:='ERR';
    Free;
  end;
end;

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

function busca_ubic(id_alm,id_zona:Integer; id_estant:string; id_pos,id_alt:Integer; id_sub1,id_sub2:string):integer;
begin                                       //devuelve id_ubicacion,   existe=id_ubicacion     no existe=-1
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select id_ubicacion from a_ubicaciones where '+
            'id_almacen='+inttostr(id_alm)+' and id_estanteria='''+id_estant+
            ''' and id_posicion='+inttostr(id_pos)+' and id_altura='+inttostr(id_alt)+' and id_sub1='''+id_sub1+
            ''' and id_sub2='''+id_sub2+''' and id_empresa='+inttostr(u_globals.id_empresa));
    Open;
    if not(IsEmpty) then Result:=FieldByName('id_ubicacion').AsInteger
      else Result:=-1;
    Free;
  end;                                                      //{' and id_zona='+inttostr(id_zona)+}
end;

function format_ubic(id_alm,id_zona:Integer; id_estant:string; id_pos,id_alt:Integer; id_sub1,id_sub2:string):string;
var s:string;
begin                                         //Devuelve la ubicación formateada AA.ZZ.EE.PP.AA.SS.SS
  s:=FormatFloat('00',id_alm)+'.'+
    FormatFloat('00',id_zona)+'.'+
    id_estant+'.'+
    FormatFloat('00',id_pos)+'.'+
    FormatFloat('00',id_alt);

  if id_sub1<>'0' then s:=s+'.'+id_sub1;
  if id_sub2<>'0' then s:=s+'.'+id_sub2;

  result:=s;
end;

function format_ubic_id(id_ubic:Integer):string;
var s:string;
begin                                         //Devuelve la ubicación formateada AA.ZZ.EE.PP.AA.SS.SS
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select * from a_ubicaciones where id_ubicacion=:id_ubicacion');
    ParamByName('id_ubicacion').AsInteger:=id_ubic;
    Open;

    if not(IsEmpty) then begin
      s:=FieldByName('id_estanteria').AsString+'-'+
        FormatFloat('00',FieldByName('id_posicion').Asinteger)+'-'+
        FormatFloat('00',FieldByName('id_altura').Asinteger);

      if FieldByName('id_sub1').AsString<>'0' then s:=s+'.'+FieldByName('id_sub1').AsString;
      if FieldByName('id_sub2').AsString<>'0' then s:=s+'.'+FieldByName('id_sub2').AsString;
    end else s:='ERR';
    Free;
  end;

  result:=s;
end;

function busca_lote_nom(id:integer):string;
begin                                       //devuelve nombre de lote a partir de id
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select nombre, caducidad from a_lotes where id_lote='+inttostr(id));
    Open;

    if not(isempty) then begin
      Result:=FieldByName('nombre').asstring + ' ' + formatdatetime('dd.mm.yyyy', fieldbyname('caducidad').asdatetime);
    end else begin
      result:='ERR';
    end;

    Free;
  end;
end;

function tiene_lote(id:integer):boolean;
begin                                       //devuelve si el articulo tiene lotes
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select tiene_lote from g_articulos where id_articulo='+inttostr(id)+
      ' and id_empresa='+inttostr(u_globals.id_empresa));
    Open;

    if not(IsEmpty) then Result := FieldByName('tiene_lote').asinteger = 1
    else result:=false;

    Free;
  end;
end;

function tiene_imei(id:integer):boolean;
begin                                       //devuelve si el articulo tiene lotes
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select tiene_imei from g_articulos where id_articulo='+inttostr(id)+
      ' and id_empresa='+inttostr(u_globals.id_empresa));
    Open;

    if not(IsEmpty) then Result := FieldByName('tiene_imei').asinteger = 1
    else result:=false;

    Free;
  end;
end;

function cuenta_refs_x_codigo(cod:string):integer;
begin                                       //devuelve la cantidad de referencias con el mismo código
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select count(*) as cantidad from g_articulos where codigo='''+cod+
      ''' and id_empresa='+inttostr(u_globals.id_empresa));
    Open;
    Result:=FieldByName('cantidad').asinteger;
    Free;
  end;
end;

function busca_attach_id(id_art:integer):integer;
begin                                       //devuelve id de articulo a partir de referencia
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select attachment_id from g_articulos where id_articulo=:id_art');
    ParamByName('id_art').AsInteger := id_art;
    Open;

    if not(IsEmpty) then Result:=FieldByName('attachment_id').asinteger
    else result:=0;

    Free;
  end;
end;

{$ENDREGION}

{$REGION 'Procesos'}
procedure nueva_ubicacion(id_alm,id_zona:Integer; id_estant:string; id_pos,id_alt:Integer; id_sub1,id_sub2:string);
begin                                                                        //crea nueva ubicación
  with TpFIBQuery.Create(dm) do
  try
    database:=dm.db;
    Transaction:=dm.t_write;
    sql.add('insert into a_ubicaciones(id_almacen,id_zona,id_estanteria,id_posicion,id_altura,id_sub1,id_sub2,id_empresa) '+
      ' values (:id_almacen,:id_zona,:id_estanteria,:id_posicion,:id_altura,:id_sub1,:id_sub2,:id_empresa)');
    ParamByName('id_almacen').AsInteger:=id_alm;
    ParamByName('id_zona').AsInteger:=id_zona;
    ParamByName('id_estanteria').asstring:=id_estant;
    ParamByName('id_posicion').AsInteger:=id_pos;
    ParamByName('id_altura').AsInteger:=id_alt;
    ParamByName('id_sub1').asstring:=id_sub1;
    ParamByName('id_sub2').asstring:=id_sub2;
    ParamByName('id_empresa').AsInteger:=u_globals.id_empresa;

    ExecQuery;                                    //gestionar transaccion desde fuera
  finally
    free;
  end;
end;
{$ENDREGION}

end.
