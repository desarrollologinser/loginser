unit u_c_ontinyent;

interface

uses
  System.SysUtils, System.StrUtils, system.classes, vcl.forms, pFIBDataSet;

function ActualizaArtsCOnt(id_cliente, usuario:Integer; httpweb,log_app,ip,pc_nom:string; var mail_txt:string):string;
function ActualizaEntsCOnt(id_cliente, usuario:Integer; httpweb,log_app,ip,pc_nom:string; var mail_txt:string):string;
function ActualizaStockCOnt(id_cliente, usuario:Integer; httpweb,log_app,ip,pc_nom:string; var mail_txt:string):string;

const
  p='|';
  ln = #13#10;
var
  hiloactivo: Boolean;
  htmldevuelto: string;

implementation

uses
  u_dm, USendText, u_functions;

function ActualizaArtsCOnt(id_cliente, usuario:Integer; httpweb,log_app,ip,pc_nom:string; var mail_txt:string):string;
var
  resultado, nomfile, tx, cadena, log_art, codigo_cli, isfolleto, memo: string;
  f:textfile;
  something_to_send:Boolean;
  SendText:ThSendTextHilo;
begin

  resultado := '';
  mail_txt := '';

  resultado := 'Generar Fichero de Artículos C.Ontinyent ';

  mail_txt := 'Generando Fichero de Artículos C.Ontinyent <br>';

  nomfile:=ExtractFilePath( Application.ExeName )+ '\files\send_articulos_ont_'+formatdatetime('yyyymmddhhmmss',Now)+'.txt';
  assignfile(f, nomfile);
  Rewrite(f);
  tx:='';
  something_to_send:=false;
  cadena:='';
  log_art:='Por Favor, pase por la web http://wwww.loginser.com/CaixaOntinyent para actualizar y completar los datos de la ficha de articulo de los siguientes:<br><br>';

  with TpFIBDataSet.Create(dm) do try
    Database:=dm.db;
    SelectSQL.Clear;
    SelectSQL.Add('select distinct a.* '+
      ' from g_articulos a '+
      ' where a.id_cliente=2045 and a.sync_web=0 ');
    Open;

    if RecordCount <> 0  then begin

      something_to_send:=true;
      First;
      while not eof do begin
        codigo_cli:=FieldByName('codigo_cli').AsString;
        if ((codigo_cli<>'') and ((codigo_cli[1]='C') or (codigo_cli[1]='F'))) then isfolleto:='1'
        else isfolleto:='0';

        tx:=fieldbyname('id_articulo').AsString+p+
          fieldbyname('codigo').AsString+p+
          fieldbyname('codigo_cli').Asstring+p+
          fieldbyname('nombre').AsString+p+
          replacestr(fieldbyname('largo').AsString,',','.')+p+
          replacestr(fieldbyname('ancho').AsString,',','.')+p+
          replacestr(fieldbyname('alto').AsString,',','.')+p+
          replacestr(fieldbyname('kgsvol').AsString,',','.')+p+
          replacestr(fieldbyname('kgs').AsString,',','.')+p+
          formatfloat('#0',fieldbyname('uni_embalaje').AsInteger)+p+
          isfolleto+'#';
        Writeln(f,tx);
        cadena:=cadena+tx;

        log_art := log_art + 'Codigo:'+fieldbyname('codigo').AsString+' - '+fieldbyname('codigo_cli').AsString+
                   '<br>Nombre:'+fieldbyname('nombre').AsString+
                   '<br>Medidas:'+fieldbyname('largo').AsString+' x '+fieldbyname('ancho').AsString+' x '+fieldbyname('alto').AsString+
                   '<br>Peso:'+fieldbyname('kgs').AsString+
                   '<br><br>';

        Next;
      end;
      SetLength(cadena, Length(cadena) - 1);
      CloseFile(f);

      resultado := resultado + ' Ok' + ln;
      mail_txt := mail_txt + 'Ok<br>';
    end;
  finally
    Free;
  end;

  if something_to_send then begin
    resultado := resultado + 'Subida Fichero de Artículos C.Ontinyent ';
    mail_txt := mail_txt + 'Uploading Fichero de Artículos C.Ontinyent <br>';

    try
      SendText:=ThSendTextHilo.create(true);
      SendText.launcher:=0;
      SendText.freeonterminate:=true;
      SendText.varname:='cadena';
      SendText.cadena:=cadena;
      SendText.url:=httpweb;
      SendText.nomphp:='put_articulo.php';
      hiloactivo:=true;
      SendText.Resume;
      while hiloactivo do Application.ProcessMessages;

      resultado := resultado + ' Ok' + ln;
      mail_txt := mail_txt + 'Ok<br>';
    except
      resultado := resultado + ' Error' + ln;
      mail_txt := mail_txt + 'Error<br>';
    end;

    if htmldevuelto='1' then begin                     //Han subido ok se marcan

      mail_txt := mail_txt + 'Art&iacute;culos C.Ontinyent Actualizados Correctamente'+' <br><br>';
      mail_txt := mail_txt + 'Marcando Art&iacute;culos C.Ontinyent <br>';

      resultado := resultado + 'Marcando Artículos C.Ontinyent ' + ln;

      dm.t_write.StartTransaction;
      try
        dm.q_1.Close;
        dm.q_1.SQL.Clear;
        dm.q_1.SQL.Add('update g_articulos set sync_web=1 where id_cliente=2045 and sync_web=0');
        dm.q_1.ExecQuery;

        dm.t_write.CommitRetaining;
        resultado := resultado + ' Ok' + ln;
      except
        resultado := resultado + ' Error' + ln;
        dm.t_write.RollbackRetaining;
      end;

    end else mail_txt := mail_txt + 'Error Actualizando Web Art&iacute;culos C.Ontinyent <br><br>';
  end else
           resultado := resultado + 'No encontrados artículos para subir.' + ln;

  DeleteFile(nomfile);

  Result := resultado;
end;

function ActualizaEntsCOnt(id_cliente, usuario:Integer; httpweb,log_app,ip,pc_nom:string; var mail_txt:string):string;
var
  resultado, nomfile, tx, cadena, codigo_cli, isfolleto, memo, matriculas: string;
  f:textfile;
  SendText:ThSendTextHilo;
  str_list:tstringlist;
begin
  str_list:=tstringlist.Create;
  cadena:='';
  matriculas := '';

  resultado := '';
  mail_txt := '';

  resultado := 'Generar Fichero de Entradas C.Ontinyent ' + ln;

  mail_txt := 'Generando Fichero de Entradas C.Ontinyent <br>';

  nomfile:=ExtractFilePath( Application.ExeName )+ '\files\send_entradas_ont_'+formatdatetime('yyyymmddhhmmss',Now)+'.txt';
  assignfile(f, nomfile);
  Rewrite(f);
  tx:='';

  with TpFIBDataSet.Create(dm) do try
    Database:=dm.db;
    SelectSQL.Clear;
    SelectSQL.Add('select a.id_articulo,m.fecha,m.hora,m.uds_ini,m.id_matricula, a.codigo_cli '+
      'from a_matriculas m '+
      'inner join g_articulos a on (a.id_articulo=m.id_articulo) '+
      'where a.id_cliente=2045 and m.sync_web=0 and m.tipo in (''R'',''E'') ' +
      'order by fecha,hora');
    Open;

    if RecordCount <> 0  then begin

      First;
      while not eof do begin

        codigo_cli:=FieldByName('codigo_cli').AsString;
        if ((codigo_cli<>'') and ((codigo_cli[1]='C') or (codigo_cli[1]='F'))) then isfolleto:='1'
        else isfolleto:='0';

         str_list.Add(FieldByName('id_matricula').AsString);
         tx:=FieldByName('id_articulo').AsString+p+
          FormatDateTime('yyyy-mm-dd',FieldByName('fecha').AsDateTime)+p+
          FormatDateTime('hh:nn:ss',FieldByName('hora').Asdatetime)+p+
          FieldByName('uds_ini').AsString+p+
          FieldByName('id_matricula').AsString+p+
          isfolleto+'#';
         Writeln(f,tx);
         cadena:=cadena+tx;

         matriculas := matriculas + FieldByName('id_matricula').AsString + ',';
        Next;
      end;
      SetLength(cadena, Length(cadena) - 1);
      CloseFile(f);

      resultado := resultado + ' Ok' + ln;

      if (matriculas<>'') then
           matriculas := Copy(matriculas, 0, Length(matriculas) - 1)
      else
          matriculas := '-1';

      resultado := resultado + 'Subida Fichero Entradas C.Ontinyent ' + ln;
      mail_txt := mail_txt + 'Uploading Fichero de Entradas C.Ontinyent <br>';

      SendText:=ThSendTextHilo.create(true);
      SendText.launcher:=0;
      SendText.freeonterminate:=true;
      SendText.varname:='cadena';
      SendText.cadena:=cadena;
      SendText.url:=httpweb;
      SendText.nomphp:='put_entradas.php';
      hiloactivo:=true;
      SendText.Resume;
      while hiloactivo do Application.ProcessMessages;

      mail_txt := mail_txt + htmldevuelto + ' <br><br>';

      if htmldevuelto='1' then begin                     //Han subido ok se marcan
        mail_txt := mail_txt + 'Entradas C.Ontinyent Actualizados Correctamente'+' <br><br>';
        mail_txt := mail_txt + 'Marcando Entradas C.Ontinyent <br>';

        dm.t_write.StartTransaction;
        try

          dm.q_1.Close;
          dm.q_1.SQL.Clear;
          dm.q_1.SQL.Add('update a_matriculas set sync_web=1 where id_matricula in (' + matriculas + ')');
          dm.q_1.ExecQuery;

          dm.t_write.CommitRetaining;
        except
          dm.t_write.RollbackRetaining;
        end;

        //u_envia_mail.envia_email(11,email_ont,log_art,'',false);

      end else begin
           resultado := resultado + 'Error Actualizando Entradas C.Ontinyent ' + ln;
           mail_txt := mail_txt + 'Error Actualizando Entradas C.Ontinyent '+' <br><br>';
      end;

    end else
          resultado := 'No existen matriculas para subir.' + ln;
  finally
    Free;
  end;

  DeleteFile(nomfile);

  InsertaLog(usuario,0,0,pc_nom,ip,log_app,'','','Demon.EntradasCOntinyent',resultado);

  Result := resultado;
end;

function ActualizaStockCOnt(id_cliente, usuario:Integer; httpweb,log_app,ip,pc_nom:string; var mail_txt:string):string;
var
  cadena, resultado, nomfile, tx: string;
  f:textfile;
  SendText:ThSendTextHilo;
begin
  cadena := '';

  resultado := 'Generando Fichero de Stocks C.Ontinyent ' + ln;

  mail_txt := mail_txt + 'Generando Fichero de Stocks C.Ontinyent <br>';

  nomfile:=ExtractFilePath( Application.ExeName )+ '\files\send_stocks_ont_'+formatdatetime('yyyymmddhhmmss',Now)+'.txt';
  assignfile(f, nomfile);
  Rewrite(f);
  tx:='';
  with TpFIBDataSet.Create(dm) do try
    Database:=dm.db;
    SelectSQL.Clear;
    SelectSQL.Add('select a.id_articulo,s.id_matricula,sum(s.cantidad) as uds '+
      'from g_articulos a '+
      'inner join a_stock s on (a.id_articulo=s.id_articulo) '+
      'left outer join a_ubicaciones u on (s.id_ubicacion=u.id_ubicacion) '+
      'where u.id_zona=0 and u.id_almacen=1 and a.id_cliente=2045  '+   //and a.id_Articulo=42167
      'group by 1,2 order by 1,2');
    Open;
    if RecordCount <> 0  then begin
      First;
      while not eof do begin
         tx:=FieldByName('id_articulo').AsString+p+
          FieldByName('uds').AsString+p+
          FieldByName('id_matricula').AsString+'#';
         Writeln(f,tx);
         cadena:=cadena+tx;
        Next;
      end;
      SetLength(cadena, Length(cadena) - 1);
      CloseFile(f);
    end;
  finally
    Free;
  end;

 resultado := resultado + 'Uploading Fichero de Stocks C.Ontinyent ' + ln;

  mail_txt := mail_txt + 'Subiendo Fichero de Stocks C.Ontinyent <br>';

  SendText:=ThSendTextHilo.create(true);
  SendText.launcher:=0;
  SendText.freeonterminate:=true;
  SendText.varname:='cadena';
  SendText.cadena:=cadena;
  SendText.url:=httpweb;
  SendText.nomphp:='put_stock.php';
  hiloactivo:=true;
  SendText.Resume;
  while hiloactivo do Application.ProcessMessages;

  mail_txt := mail_txt + htmldevuelto+' <br><br>';

  if htmldevuelto='1' then                     //Han subido ok
    mail_txt := mail_txt + 'Stocks C.Ontinyent Actualizados Correctamente'+' <br><br>'
  else mail_txt := mail_txt + 'Error Actualizando Stocks C.Ontinyent'+' <br><br>';

  DeleteFile(nomfile);

  Result := resultado;
end;

end.
