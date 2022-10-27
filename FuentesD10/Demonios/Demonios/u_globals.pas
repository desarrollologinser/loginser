unit u_globals;

interface

uses inifiles,sysutils,FIBDataSet,pFIBDataSet,classes,Grids, JvExGrids, JvStringGrid,
      math,graphics,sdialogs,dialogs,controls,forms, DB, pFIBQuery;

procedure leer_ini;
procedure ListaArchivos(dir,ext:string; Lista:TStringList);
procedure leer_ini_bbdd(id_usuario:Integer);

var
  libname,smtp,email,user,pass:string;
  smtp_port, id_usuario:integer;
  db_name, db_gestoras: string;


implementation

uses u_dm;

{$REGION 'Inis'}
procedure leer_ini;
var ini:tinifile;
begin                                                               //Cargar datos del ini
  ini:=tinifile.create(ExtractFilePath(ParamStr(0))+'demonios.ini');
  try
    libname     := ini.readstring('Datos','libname','fbclient.dll');
    db_name     := ini.readstring('Datos','dbname','');
    db_gestoras := ini.readstring('Datos','db_gestoras','');
    id_usuario  := StrToInt(ini.readstring('Datos','id_usuario',''));
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
          selectsql.Add('select * from s_inis where id_usuario=:id_usuario');
          ParamByName('id_usuario').AsInteger := id_usuario;
          open;
          first;

          if not IsEmpty then
          begin
            while not eof do
            begin
             if fieldByname('item').asstring='email' then
                  email := fieldByname('valor').asstring
             else if fieldByname('item').asstring='pass' then
                      pass := fieldByname('valor').asstring
                  else if fieldByname('item').asstring='smtp' then
                            smtp := fieldByname('valor').asstring
                       else if fieldByname('item').asstring='smtp_port' then
                                smtp_port := fieldByname('valor').AsInteger
                            else if fieldByname('item').asstring='user' then
                                      user := fieldByname('valor').asstring;
              Next;
            end;
          end;

       finally
          Free;
       end;
end;
{$ENDREGION}

procedure ListaArchivos(dir,ext:string; Lista:TStringList);
var
  sr: TSearchRec;  extension:string;
begin
  if ext<>'' then extension:='*.'+ext
    else extension:='*';
  if FindFirst(dir + extension, faAnyFile, sr) = 0 then
    repeat
      if (sr.Attr and faDirectory = 0) or (sr.Name<>'.') and (sr.Name<>'..') then
       Lista.Add(dir + sr.Name);
    until FindNext(sr) <> 0;
  FindClose(sr);
end;

end.
