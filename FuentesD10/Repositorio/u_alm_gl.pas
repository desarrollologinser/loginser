unit u_alm_gl;

interface

uses pfibdataset,sysutils,pfibquery;

procedure lee_inis_def;
  //lee datos iniciales por defecto para trabajar con almacen desde A_AUX
function busca_ubic(id_almacen:integer; id_estanteria:string; id_posicion,id_altura:Integer; id_sub1,id_sub2:string):integer;
  //Devuelve id_ubicacion buscando posiciones ,no existe=-1
function ubic_es_posicional(id_estanteria:string; id_posicion,id_altura:Integer; id_sub1,id_sub2:string):boolean;
  //True si ubicacion tiene posicion en estanteria, False si es ubicación virtual
function busca_nom_alm(id:integer):string;
  //devuelve nombre de almacen, ERR=not found
procedure nueva_ubicacion(id_alm:Integer; id_estant:string; id_pos,id_alt:Integer; id_sub1,id_sub2:string);
  //crea nueva ubicación

var
  id_alm_def:integer;       //almacen por defecto
  id_art_temp:integer;      //articulo temporal (para hacer entradas cuando el articulo es nuevo y aun no esta dado de alta)

implementation

uses udm,u_globals;

{$REGION 'Inis'}
procedure lee_inis_def;                  //Lee inis de la tabla A_AUX para almacen
begin
  with tpfibdataset.create(dm) do
  try
    database:=dm.db;
    close;
    sqls.SelectSQL.Clear;
    sqls.selectsql.Add('select id_alm_def,id_art_temp '+
      'from a_aux '+
      'where id_empresa='+inttostr(u_globals.id_empresa));
    open;

    if not(isempty) then begin
      id_alm_def:=fieldbyname('id_alm_def').asinteger;
      id_art_temp:=FieldByName('id_art_temp').AsInteger;
    end else raise exception.Create('Error Cargando Valores Iniciales Desde BD');
  finally
    free;
  end;
end;
{$ENDREGION}

{$REGION 'Busquedas'}
function busca_ubic(id_almacen:integer; id_estanteria:string; id_posicion,id_altura:Integer; id_sub1,id_sub2:string):integer;
var s:string;
begin                                       //devuelve id_ubicacion,   existe=id_ubicacion     no existe=-1
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select id_ubicacion from a_ubicaciones where '+
            'id_almacen='+inttostr(id_almacen)+' and id_estanteria='+quotedstr(id_estanteria)+
            ' and id_posicion='+inttostr(id_posicion)+' and id_altura='+inttostr(id_altura)+' and id_sub1='+quotedstr(id_sub1)+
            ' and id_sub2='+quotedstr(id_sub1)+' and id_empresa='+inttostr(u_globals.id_empresa));
    Open;
    if not(IsEmpty) then Result:=FieldByName('id_ubicacion').AsInteger
      else Result:=-1;
    Free;
  end;
end;

function ubic_es_posicional(id_estanteria:string; id_posicion,id_altura:Integer; id_sub1,id_sub2:string):boolean;
begin                                                      //true=posicional    false=virtual
  result:=True;
  if id_estanteria='0' then Result:=false;
end;

function busca_nom_alm(id:integer):string;
begin                                     //devuelve nombre de almacen, ERR=not found
  with tpfibdataset.Create(dm) do
  try
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select nombre from a_almacenes where id_almacen='+inttostr(id)+
      ' and id_empresa='+inttostr(u_globals.id_empresa));
    Open;
    if not(IsEmpty) then Result:=FieldByName('nombre').asstring
      else Result:='ERR';
  finally
    Free;
  end;
end;
{$ENDREGION}

{$REGION 'Procesos'}
procedure nueva_ubicacion(id_alm:Integer; id_estant:string; id_pos,id_alt:Integer; id_sub1,id_sub2:string);
begin                                                                        //crea nueva ubicación
  with TpFIBQuery.Create(dm) do
  try
    database:=dm.db;
    Transaction:=dm.t_write;
    sql.add('insert into a_ubicaciones(id_almacen,id_estanteria,id_posicion,id_altura,id_sub1,id_sub2,id_empresa) '+
      ' values (:id_almacen,:id_estanteria,:id_posicion,:id_altura,:id_sub1,:id_sub2,:id_empresa)');
    ParamByName('id_almacen').AsInteger:=id_alm;
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
