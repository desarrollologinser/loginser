unit u_camp_aux;

interface

uses  pfibdataset,SysUtils,pfibquery,pFIBStoredProc;

function busca_cp(id:Integer):string;
function busca_id_pobla(nombre:string):Integer;
function busca_prov(id:Integer):string;
function busca_pobla(id:Integer):string;


implementation

uses udm,u_globals;

function busca_cp(id:Integer):string;
begin                                         // devuelve codigo postal
  with TpFIBDataSet.Create(dm) do begin
    Database:=dm.db;
    SQLs.SelectSQL.Clear;
    Sqls.SelectSQL.Add('select cp from g_cp where id_cp ='+inttostr(id));
    Open;
    if not(IsEmpty) then result:=FieldByName('cp').AsString else Result:='';
  end;
end;

function busca_id_pobla(nombre:string):integer;
begin                                         // devuelve id poblacion segun nombre
  with TpFIBDataSet.Create(dm) do begin
    Database:=dm.db;
    SQLs.SelectSQL.Clear;
    Sqls.SelectSQL.Add('select id_poblacion from g_poblaciones where nombre ='+nombre);
    Open;
    if not(IsEmpty) then result:=FieldByName('id_poblacion').asinteger else Result:=0;
  end;
end;

function busca_prov(id:Integer):string;
begin                                         // devuelve nombre provincia
  with TpFIBDataSet.Create(dm) do begin
    Database:=dm.db;
    SQLs.SelectSQL.Clear;
    Sqls.SelectSQL.Add('select nombre from g_provincias where id_provincia ='+inttostr(id));
    Open;
    if not(IsEmpty) then result:=FieldByName('nombre').AsString else Result:='';
  end;
end;

function busca_pobla(id:Integer):string;
begin                                         // devuelve nombre provincia
  with TpFIBDataSet.Create(dm) do begin
    Database:=dm.db;
    SQLs.SelectSQL.Clear;
    Sqls.SelectSQL.Add('select nombre from g_poblaciones where id_poblacion ='+inttostr(id));
    Open;
    if not(IsEmpty) then result:=FieldByName('nombre').AsString else Result:='';
  end;
end;
end.
