unit u_globals;

interface

uses inifiles,sysutils,FIBDataSet,pFIBDataSet,classes,Grids, JvExGrids, JvStringGrid,
      math,graphics,sdialogs,dialogs,controls,forms, DB, pFIBQuery;

procedure leer_ini;
procedure ListaArchivos(dir,ext:string; Lista:TStringList);

var
  libname,smtp,email,user,pass:string;
  smtp_port:integer;

implementation

uses u_dm;

{$REGION 'Inis'}
procedure leer_ini;
var ini:tinifile;
begin                                                               //Cargar datos del ini
  ini:=tinifile.create(ExtractFilePath(ParamStr(0))+'demon_list_bankia.ini');
  try
    libname:=ini.readstring('Datos','libname','fbclient.dll');
    smtp:=ini.readstring('Correo','smtp','');
    smtp_port:=StrToInt(ini.readstring('Correo','smtp_port',''));
    email:=ini.readstring('Correo','email','');
    user:=ini.readstring('Correo','user','');
    pass:=ini.readstring('Correo','pass','');
  finally
    ini.free;
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
