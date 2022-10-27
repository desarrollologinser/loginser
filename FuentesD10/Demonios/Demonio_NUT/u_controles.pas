unit u_controles;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, FIBDataSet, pFIBDataSet, FIBDatabase,
  pFIBDatabase,inifiles,dateutils;

type
  Tf_controles = class(TForm)
    bt_1: TButton;
    lbl_1: TLabel;
    lbl_3: TLabel;
    lbl_11: TLabel;
    ed_1: TEdit;
    lbl_2: TLabel;
    me_1: TMemo;
    procedure bt_1Click(Sender: TObject);
    procedure leer_proc_ini(idx:Integer);
  private
    { Private declarations }
    function controlesCliente(cli:Integer; out resultado: string): Boolean;
  public
    { Public declarations }
    procedure lanza_sync(idx:Integer; verbose:Boolean);
  end;

var
  f_controles: Tf_controles;
  server_name,db_name,email:string;

implementation

uses u_dm, u_globals, u_envia_mail, u_main;

{$R *.dfm}

procedure Tf_controles.bt_1Click(Sender: TObject);
begin
  f_main.tm_1.Enabled:=false;
  lanza_sync(StrToInt(ed_1.text),true);
  f_main.tm_1.Enabled:=true;
end;

procedure Tf_controles.lanza_sync(idx:Integer; verbose:boolean);
var   memo:string;  cod_art,cod_alm,n,uds_buenas,uds_roturas,insertados,actualizados:integer;
begin
  leer_proc_ini(idx);
  insertados:=0;
  actualizados:=0;
  memo:='';

  //dm.db_fib.DBName:=server_name+':'+db_name;                                             //conecta la BD
  //dm.db_fib.LibraryName:=u_globals.libname;
  dm.db.Connected:=true;

  dm.con1.Connected:=true;

  n:=0;
  memo:=memo+'Actualizando Clientes en FB<br><br>';

  dm.q.Close;
  dm.q.SQL.Clear;
  dm.q.SQL.Add('select * from clientes');
  dm.q.Open;

  try
    dm.t_write.StartTransaction;
    dm.q.First;
    while not(dm.q.Eof) do begin
      dm.q_db.Close;
      dm.q_db.SQLs.SelectSQL.Clear;                                                         //ficha del cliente
      dm.q_db.SQLs.SelectSQL.Add('select * '+
          'from g_clientes '+
          'where id_cliente=:id_cliente');
      dm.q_db.ParamByName('id_cliente').asinteger:=dm.q.FieldByName('codcli').asinteger;
      dm.q_db.Open;

      if dm.q_db.IsEmpty then begin                                      //no existe en FIB se crea
        dm.qry_db.Close;
        dm.qry_db.SQL.Clear;
        dm.qry_db.SQL.Add('insert into g_clientes (id_cliente,nombre,direccion,cp,poblacion,provincia,telefono,fax,email,nif,id_grupo_cliente) '+
          'values (:id_cliente,:nombre,:direccion,:cp,:poblacion,:provincia,:telefono,:fax,:email,:nif, :id_grupo_cliente)');
        dm.qry_db.ParamByName('id_cliente').asinteger:=dm.q.FieldByName('codcli').asinteger;
        dm.qry_db.ParamByName('nombre').AsString:=Trim(dm.q.FieldByName('cliente').AsString);
        dm.qry_db.ParamByName('direccion').AsString:=dm.q.FieldByName('direccion').AsString;
        dm.qry_db.ParamByName('cp').AsString:=dm.q.FieldByName('cp').AsString;
        dm.qry_db.ParamByName('poblacion').AsString:=dm.q.FieldByName('poblacion').AsString;
        dm.qry_db.ParamByName('provincia').AsString:=dm.q.FieldByName('provincia').AsString;
        dm.qry_db.ParamByName('telefono').AsString:=dm.q.FieldByName('telefono').AsString;
        dm.qry_db.ParamByName('fax').AsString:=dm.q.FieldByName('fax').AsString;
        dm.qry_db.ParamByName('email').AsString:=dm.q.FieldByName('email').AsString;
        dm.qry_db.ParamByName('nif').AsString:=dm.q.FieldByName('nif').AsString;
        dm.qry_db.ParamByName('id_grupo_cliente').asinteger:=dm.q.FieldByName('grupocliente').asinteger;
        dm.qry_db.ExecQuery;
        Inc(insertados);
      end else begin                                                      //si existe en FIB se actualiza
        {dm.qry_db.Close;
        dm.qry_db.SQL.Clear;
        dm.qry_db.SQL.Add('update g_clientes set nombre=:nombre,direccion=:direccion,cp=:cp,poblacion=:poblacion,provincia=:provincia'+
          ',telefono=:telefono,fax=:fax,email=:email,nif=:nif, id_grupo_cliente=:id_grupo_cliente where id_cliente=:id_cliente');
        dm.qry_db.ParamByName('id_cliente').asinteger:=dm.q.FieldByName('codcli').asinteger;
        dm.qry_db.ParamByName('nombre').AsString:=Trim(dm.q.FieldByName('cliente').AsString);
        dm.qry_db.ParamByName('direccion').AsString:=Trim(dm.q.FieldByName('direccion').AsString);
        dm.qry_db.ParamByName('cp').AsString:=Trim(dm.q.FieldByName('cp').AsString);
        dm.qry_db.ParamByName('poblacion').AsString:=Trim(dm.q.FieldByName('poblacion').AsString);
        dm.qry_db.ParamByName('provincia').AsString:=Trim(dm.q.FieldByName('provincia').AsString);
        dm.qry_db.ParamByName('telefono').AsString:=Trim(dm.q.FieldByName('telefono').AsString);
        dm.qry_db.ParamByName('fax').AsString:=Trim(dm.q.FieldByName('fax').AsString);
        dm.qry_db.ParamByName('email').AsString:=Trim(dm.q.FieldByName('email').AsString);
        dm.qry_db.ParamByName('nif').AsString:=Trim(dm.q.FieldByName('nif').AsString);
        dm.qry_db.ParamByName('id_grupo_cliente').asinteger:=dm.q.FieldByName('grupocliente').asinteger;
        dm.qry_db.ExecQuery;
        Inc(actualizados);    }
      end;
      dm.q.Next;
      Inc(n);
      if verbose then begin
        lbl_3.Caption:=IntToStr(n);
        Application.ProcessMessages;
      end;
    end;
    dm.t_write.CommitRetaining;
    f_main.mm3.Lines.Add(FormatDateTime('hh:mm',now)+ ' ' + 'Clientes OK');

  except
         on e:Exception do begin
          dm.t_write.Rollback;
          me_1.Lines.Add('Error: '+e.Message);
          f_main.mm3.Lines.Add(FormatDateTime('hh:mm',now)+ ' ' + 'Clientes ERROR');
        end;
  end;

  memo:=memo+IntToStr(n)+' Clientes Verificados. '+chr(13)+ IntToStr(insertados)+' Clientes Nuevos.'+chr(13)+ InttoStr(actualizados)+' Clientes Actualizados';

  dm.db.Connected:=False;
  dm.con1.Connected:=false;

  if verbose then begin
    me_1.Clear;
    me_1.Text:=memo;
  end;

  if verbose then ShowMessage('Finished');
end;

procedure Tf_controles.leer_proc_ini(idx:Integer);
var ini:tinifile;
begin                                                               //Cargar datos del ini
  ini:=tinifile.create(ExtractFilePath(ParamStr(0))+'demon.ini');
  try
   server_name:=ini.readstring('Sync_'+inttostr(idx),'servername','');
   db_name:=ini.readstring('Sync_'+inttostr(idx),'dbname','');
   email:=ini.readstring('Sync_'+inttostr(idx),'email','');
  finally
   ini.free;
  end;
end;

function Tf_controles.controlesCliente(cli:Integer; out resultado: string): Boolean;
var
  i: integer;
  qry: string;
begin
  result := True;

  resultado := '';

  with TpFIBDataSet.Create(self) do
  try
    try
      Database := dm.db;
      sqls.SelectSQL.Add('select distinct qry, c.descripcion, q.query ' +
                         'from g_clientes_control c ' +
                         'inner join g_queries q on q.id=c.qry ' +
                         'where ((id_cliente=:id_cliente) or (id_cliente=-1000)) ' +
                         'order by id_cliente desc' );
      ParamByName('id_cliente').AsInteger := cli;
      Open;

      first;

      while (not (Eof)) do
      begin
        if resultado<>'' then
           resultado := resultado + #13#10;

        dm.ds_2.Close;
        dm.ds_2.SQLs.SelectSQL.Clear;
        dm.ds_2.SQLs.SelectSQL.Add(FieldByName('query').AsString);
        if Pos(':id_cliente',FieldByName('query').AsString)>0 then
            dm.ds_2.ParamByName('id_cliente').AsInteger := main_cli;
        dm.ds_2.Open;

        if not dm.ds_2.IsEmpty then
        begin
          resultado := resultado + FieldByName('descripcion').AsString + #13#10;

          dm.ds_2.First;

          for I := 0 to dm.ds_2.Fields.Count-1 do
              resultado := resultado + dm.ds_2.FieldName(i) + '_' ;

          resultado := Copy(resultado,0,Length(resultado)-1);
          resultado := resultado + #13#10;

          while not dm.ds_2.Eof do
          begin

            for I := 0 to dm.ds_2.Fields.Count-1 do
                 resultado := resultado + dm.ds_2.fields[i].Text + '_' ;

            resultado := Copy(resultado,0,Length(resultado)-1);
            resultado := resultado + #13#10;
            dm.ds_2.Next;
          end;
        end;

        Next;
      end;

    except
       Result := False;
    end;

  finally
     free;
  end;

  end;



end.
