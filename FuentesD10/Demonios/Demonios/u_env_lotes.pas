unit u_env_lotes;

interface

uses
    System.Classes, system.SysUtils, pFIBDataSet, pFIBQuery;

function EnviaLotes(id_cliente:Integer; url,user,pass,mail_error:string; log_app,pc_ip,pc_nom:string; usu_id:Integer):string;

const
  ln = #13#10;
implementation

uses
    u_dm,u_dmPargal, u_envia_mail, u_functions, u_globals_gestoras, u_dmBiocan;

function EnviaLotes(id_cliente:Integer; url,user,pass,mail_error:string; log_app,pc_ip,pc_nom:string; usu_id:Integer):string;
var
  token,log, sentencia, sql_aux: string;
  i, art_actual, alb_actual: integer;
  resultado, body, peds_act, pedidos, result_envio: string;
  peds,cuerpo, log_error:TStringList;
  fecha_aux: TDateTime;
begin

   resultado := '';
   result_envio := '';
   fecha_aux := now;
   sql_aux := '';

   /// REVISAR ESTADOS
   try
      peds_act := '';

      with TpFIBDataSet.Create(dm) do
      begin
        close;
        Database := dm.db;
        Transaction := dm.t_read;
        SelectSQL.Clear;
       { SelectSQL.Add('select distinct p.id_pedido, codalbaran ' +
                      'from c_pedidos p ' +
                      'inner join c_pedidos_lines l on p.id_pedido=l.id_pedido ' +
                      'left outer join c_pedidos_lines_lotes lt on l.id_pedido=lt.id_pedido and ' +
                      'l.id_articulo=lt.id_articulo ' +
                      'where p.id_clientean>0 and ' +
                      'p.estado in (''G'') and lt.id_lote is not null=:id_cliente and p.codalbar ');
        ParamByName('id_cliente').AsInteger := id_cliente;          }
        //SelectSQL.Add('select query from g_queries where id=154');    //test
        SelectSQL.Add('select query from g_queries where id=160');    //pro
        Open;

        if not IsEmpty then
        begin
            sentencia := FieldByName('query').AsString;

            if sentencia<>'' then
            begin
              Close;
              SelectSQL.Clear;
              SelectSQL.Add(sentencia);
              ParamByName('id_cliente').AsInteger := id_cliente;
              Open;
            end;

          if not IsEmpty then
          begin
            First;

            while not Eof do
            begin
              If get_albaran_data('expedicion_age',FieldByName('codalbaran').AsInteger)<>'' then
              begin
                peds_act := peds_act + FieldByName('id_pedido').AsString + ',';
              end;
              Next;
            end;
          end else begin
                resultado := resultado + 'No existen estados G->E para actualizar.' + ln;
                InsertaLog(usu_id,0,0,pc_nom,pc_ip,log_app,'','','Demon.NoExistenEstG->EParaActualizar','ActG->E');
              end;
        end;

        Free;
      end;

      if peds_act<>'' then
      begin
          peds_act := Copy(peds_act, 0, Length(peds_act) - 1);
          fecha_aux := Now;

          sql_aux := 'update c_pedidos set estado=:estado, fecha_fin=:fecha_fin where id_pedido in (' + peds_act + ')';

          dm.t_write.StartTransaction;

            with TpFIBQuery.Create(dm) do
            begin
               try
                Close;
                Database := dm.db;
                transaction := dm.t_write;
                sql.Clear;
                SQL.Add(sql_aux);
                ParamByName('estado').AsString := 'E';
                ParamByName('fecha_fin').AsDateTime := fecha_aux;

                try
                 ExecQuery;
                 dm.t_write.Commit;
                except
                 dm.t_write.Rollback;
                end;
               finally
                 free;
               end;
            end;

            if peds_act <> '' then
            begin
              InsertaLog(usu_id, 0, 0, pc_nom, pc_ip, log_app, '', '', 'Demon.ActEstG->E.UpdateCPedidos.' , sql_aux + '|E|' + FormatDateTime('dd/mm/yyyy hh:nn:ss',fecha_aux));
              InsertaLog(usu_id,0,0,pc_nom,pc_ip,log_app,'','','Demon.ActEstG->E=OK',Copy(peds_act, 0, Length(peds_act) - 1));
              resultado := resultado + 'Estado G->E: ' + peds_act + ln;
            end;

      end;

   except on e:exception do begin
                resultado := resultado + 'Error actualizando estados G->E.' + ln;
             end;
   end;

   ///  ACTUALIZACION
   try
      with TpFIBDataSet.Create(dm) do
      begin
        close;
        Database := dm.db;
        Transaction := dm.t_read;
        SelectSQL.Clear;
        SelectSQL.Add('select distinct p.id_pedido, p.codalbaran, l.id_articulo ' +
                      'from c_pedidos p ' +
                      'inner join c_pedidos_lines l on p.id_pedido=l.id_pedido ' +
                      'left outer join c_pedidos_lines_lotes lt on l.id_pedido=lt.id_pedido and ' +
                      'l.id_articulo=lt.id_articulo ' +
                      'where p.id_cliente=:id_cliente and p.codalbaran>0 and ' +
                      'p.estado in (''E'') and ' +
                      'lt.id_pedido is null and lt.id_articulo is null ');
        ParamByName('id_cliente').AsInteger := id_cliente;
        Open;

        peds_act := '';
        art_actual := -1;
        alb_actual := -1;

        if not IsEmpty then
        begin
          dm.t_write.StartTransaction;

          First;

          while not Eof do
          begin
            if ((art_actual <> FieldByName('id_articulo').AsInteger) or (alb_actual <> FieldByName('codalbaran').AsInteger)) then
            begin
              art_actual := FieldByName('id_articulo').AsInteger;
              alb_actual := FieldByName('codalbaran').AsInteger;

              if FieldByName('codalbaran').AsInteger > 0 then
              begin
                peds_act := CopiaLoteDePicking(FieldByName('id_pedido').AsInteger,FieldByName('codalbaran').AsInteger,FieldByName('id_articulo').AsInteger);
              end;
            end;
            Next;
          end;

          dm.t_write.Commit;

          if peds_act <> '' then
          begin
            InsertaLog(usu_id,0,0,pc_nom,pc_ip,log_app,'','','Demon.ActLts=OK',Copy(peds_act, 0, Length(peds_act) - 1));
            resultado := resultado + 'Lotes actualizados: ' + Copy(peds_act, 0, Length(peds_act) - 1) + ln;
          end
          else begin
            InsertaLog(usu_id,0,0,pc_nom,pc_ip,log_app,'','','Demon.NoExistenLtParaActualizar','');
          end;
        end
        else begin
          resultado := resultado + 'No existen pedidos con lotes por actualizar.' + ln;
          InsertaLog(usu_id,0,0,pc_nom,pc_ip,log_app,'','','Demon.NoExistenPedsParaActualizar','');
        end;
      end;

   except on e:exception do begin
                dm.t_write.Rollback;
                resultado := resultado + 'Error actualizando lotes.' + ln;
             end;

   end;


   //// ENVIO

   try
      with TpFIBDataSet.Create(dm) do
      begin
        close;
        Database := dm.db;
        Transaction := dm.t_write;
        SelectSQL.Clear;
        SelectSQL.Add('select distinct id_pedido from c_pedidos p ' +
                      'where id_cliente=:id_cliente and estado in (''E'') and ' +
                      'p.id_pedido>=476000 and ' +
                      'not exists (select * from c_pedidos_extras e ' +
                                  'where p.id_pedido=e.id_pedido and upper(e.descripcion)=upper(:extra) ' +
                                   ' and upper(e.valor) containing ' + QuotedStr('(200)') + ')' );
        ParamByName('id_cliente').AsInteger := id_cliente;
        ParamByName('extra').AsString := 'LOG_LOTE';
        Open;

        pedidos := '';

        if not IsEmpty then
        begin
          dm.t_write.StartTransaction;

          First;

          while not Eof do
          begin
            pedidos := pedidos + FieldByName('id_pedido').AsString + ',';
            Next;
          end;

        end
        else begin
          resultado := resultado + 'No existen pedidos con lotes sin enviar.' + ln;
          InsertaLog(usu_id,0,0,pc_nom,pc_ip,log_app,'','','Demon.NoExistenPedsParaEnviar','');
        end;
      end;

   except on e:exception do begin
                dm.t_write.Rollback;
                resultado := resultado + 'Error en lotes.' + ln;
             end;

   end;

   if pedidos<>'' then
   begin
      resultado := resultado + 'Enviando lotes pedidos ' + Copy(peds_act, 0, Length(peds_act) - 1) + ln;

      peds := TStringList.Create;
      peds.Delimiter := ',';
      peds.DelimitedText := Copy(pedidos, 0, Length(pedidos) - 1);

      if id_cliente<>7871 then
            token := dmPargal.Login(url,user,pass);

      log_error := TStringList.Create;
      log_error.Delimiter := '|';

      for I := 0 to peds.Count-1 do
      begin
         log := '';

          try
            if id_cliente<>7871 then
                result_envio := dmPargal.EnviaPedido(token,url,StrToInt(peds[i]),-1,log)
            else
                result_envio := dmBiocan.EnviaPedido(url,StrToInt(peds[i]),-1,log);
          except on e:Exception do begin
             resultado := resultado + peds[i] +  ' SYS ' + e.message + ln;

              body := '<html><head><link rel="stylesheet" href="((imgs_ftp))estilos.css"></head>'+
                    '<body><table border=0> ' +
                    '<tr><td>Intento fallido de envío de lotes al cliente. Por favor, revisar pedido ' + peds[i] +'.</td></tr>'+
                    '<tr><td>Por favor, contactar con el cliente en caso necesario. Gracias.</td></tr> '+
                    '<tr><td>ERROR DE SISTEMA.</td></tr>'+
                    '<tr><td>' + e.Message + '</td></tr>'+
                    '</table></body><html>';

              cuerpo:=tstringlist.Create;
              cuerpo.Add(body);
              envia_email(1,mail_error, body,'Dem. Envio lotes ' + IntToStr(id_cliente),True);
              cuerpo.Free;
            end;
          end;

          if Pos('(409)',result_envio)>0 then
          begin
            log_error.DelimitedText := log;

            body := '<html><head><link rel="stylesheet" href="((imgs_ftp))estilos.css"></head>'+
                    '<body><table border=0> ' +
                    '<tr><td>Intento fallido de envío de lotes al cliente. Por favor, revisar pedido ' + peds[i] +'.</td></tr>'+
                    '<tr><td>El cliente indica que el pedido ya se ha pasado a factura y no permite modificar el pedido.</td></tr>'+
                    '<tr><td>Por favor, contactar con el cliente en caso necesario. Gracias.</td></tr> '+
                    '<tr><td>Respuesta automática desde el sistema del cliente:' + result_envio +'</td></tr>'+
                    '</table></body><html>';

            cuerpo:=tstringlist.Create;
            cuerpo.Add(body);

            envia_email(1,mail_error, body,'Dem.Envio lotes ' + IntToStr(id_cliente),true);
            cuerpo.Free;
          end else if Pos('(404)',result_envio)>0 then
                   begin
                      body := '<html><head><link rel="stylesheet" href="((imgs_ftp))estilos.css"></head>'+
                              '<body><table border=0> ' +
                              '<tr><td>Intento fallido de envío de lotes al cliente. Por favor, revisar pedido ' + peds[i] +'.</td></tr>'+
                              '<tr><td>El cliente indica que el pedido no existe en su sistema.</td></tr>'+
                              '<tr><td>Por favor, contactar con el cliente en caso necesario. Gracias.</td></tr> '+
                              '<tr><td>Respuesta automática desde el sistema del cliente:' + resultado +'</td></tr>'+
                              '</table></body><html>';

                      cuerpo:=tstringlist.Create;
                      cuerpo.Add(body);
                      envia_email(1,mail_error, body,'Dem.Envio lotes ' + IntToStr(id_cliente),true);
                      u_functions.insertalog(usu_id,0,0,pc_nom,pc_ip,'','','','Dem.Envio email aviso error a ' + mail_error, body);
                      cuerpo.Free;
                   end;

          if Log<>'' then
             u_functions.insertalog(usu_id,0,0,pc_nom,pc_ip,'','','','Demon.Envio lotes a cliente',log);

          if ((Pos('(409)',result_envio)>0) or (Pos('(404)',result_envio)>0) or (Pos('SYS',result_envio)>0)) then
              inserta_pedido_extra(StrToInt(peds[i]),'LOG_LOTE_ERROR',FormatDateTime('dd.mm.yy hh:mm:ss',now)+' '+result_envio)
          else
              inserta_pedido_extra(StrToInt(peds[i]),'LOG_LOTE',FormatDateTime('dd.mm.yy hh:mm:ss',now)+' '+result_envio);

      end;

      peds.Free;

   end;

   Result := resultado;
end;

end.
