unit u_env_estados;

interface

uses
    System.Classes, system.SysUtils, pFIBDataSet, pFIBQuery;

function EnviaEstados(qry, id_cliente, dias_atras:Integer; url,user,pass,llamada,extra_est, extra_ent, ok_est, dem_estados:string;
                      log_app,pc_ip,pc_nom:string; usu_id:Integer; f_ini, f_fin:TDateTime;
                      cli_api_url,cli_api_user,cli_api_pass:string):string;

const
  ln = #13#10;

var
    lanzar_todo:Boolean=False;
    qry_est, qry_ent: Integer;
implementation

uses
    u_dm, u_functions, u_globals_gestoras, u_EstadoPedido, u_dmPargal;

procedure cola_entregados(qry,usu_id,id_cliente,dias_atras:integer; resul_temp, sentencia, ok_est, pc_nom,pc_ip,log_app,extra_ent: string; fecha_ini, fecha_fin:TDateTime; var cont_peds_ent: Integer; var cont_ent: Integer; var resultado: string);
var
  est_gest: TStringList;
  estado_alb: string;
begin
  //COLA ENTREGADOS
  try
    with TpFIBDataSet.Create(dm) do
    begin
      close;
      Database := dm.db;
      Transaction := dm.t_read;
      SelectSQL.Clear;
      SelectSQL.Add('select query from g_queries where id=:qry');
      ParamByName('qry').AsInteger := qry;
      Open;

      if not IsEmpty then
      begin
        sentencia := FieldByName('query').AsString;
        if sentencia <> '' then
        begin
          Close;
          SelectSQL.Clear;
          SelectSQL.Add(sentencia);
          ParamByName('id_cliente').AsInteger := id_cliente;
          if qry=qry_ent then
          begin
            ParamByName('fecha').AsDateTime := Now - dias_atras;
            //ParamByName('dias_atras').AsInteger := dias_atras;
            ParamByName('extra').AsString := extra_ent;
            ParamByName('ok').AsString := ok_est;
          end else begin
                      ParamByName('fecha_ini').AsDateTime := fecha_ini;
                      ParamByName('fecha_fin').AsDateTime := fecha_fin+1;
                   end;

          Open;
        end;
        if not IsEmpty then
        begin
          est_gest := TStringList.Create;
          est_gest.Delimiter := '|';
          First;
          while not Eof do
          begin
            try
              estado_alb := get_estado_albaran(fieldbyname('codalbaran').AsInteger);
              estado_alb := StringReplace(estado_alb, ' ', '', []);
            except
              on e: exception do
              begin
                raise ;
              end;
            end;
            if estado_alb <> '' then
            begin
              est_gest.Clear;
              est_gest.DelimitedText := estado_alb;
              Inc(cont_peds_ent);
              if est_gest[1] = '2' then
              begin
                if FieldByName('id_pedido').AsInteger>0 then
                begin
                  resul_temp := dmEstadoPedido.EstadoPedido(FieldByName('id_pedido').AsInteger);

                  //resultado := resultado + 'Entregado ' + resul_temp + ln;
                  if ((qry=qry_ent) and (Pos('Ok', resul_temp) > 0)) then
                  begin
                    InsertaLog(usu_id, FieldByName('id_pedido').AsInteger, 0, pc_nom, pc_ip, log_app, 'pedido', '', 'Demon.EnviadoEntACola Alb.' + fieldbyname('codalbaran').AsString + ' P.' + FieldByName('id_pedido').AsString, resul_temp);
                    inserta_pedido_extra(FieldByName('id_pedido').AsInteger, extra_ent, ok_est + ' ' + FormatDateTime('dd.mm.yy hh:nn:ss', Now));
                    Inc(cont_ent);
                  end
                  else if ((qry=164) and (Pos('Ok', resul_temp) > 0)) then
                  begin
                    InsertaLog(usu_id, FieldByName('id_pedido').AsInteger, 0, pc_nom, pc_ip, log_app, 'pedido', '', 'Demon.EnviadoManualEntACola Alb.' + fieldbyname('codalbaran').AsString + ' P.' + FieldByName('id_pedido').AsString, resul_temp);
                    inserta_pedido_extra(FieldByName('id_pedido').AsInteger, 'ENT_MANUAL', ok_est + ' ' + FormatDateTime('dd.mm.yy hh:nn:ss', Now));
                    Inc(cont_ent);
                  end else
                    resultado := resultado + 'Entregado ' + resul_temp + ln;

                end else begin
                       resultado := resultado + 'Pedido no enviado ' + FieldByName('id_pedido').AsString + ln;
                       InsertaLog(usu_id, FieldByName('id_pedido').AsInteger, 0, pc_nom, pc_ip, log_app, 'pedido', '', 'Demon.NOEnviadoEntACola Alb.' + fieldbyname('codalbaran').AsString + ' P.' + FieldByName('id_pedido').AsString,'Ped.NO>0');
                end;
              end;
            end;
            Next;
          end;
          est_gest.Free;
        end;

      end
      else
      begin
        //resultado := resultado + 'No existen entregados para enviar a cola.' + ln;
        InsertaLog(usu_id, 0, 0, pc_nom, pc_ip, log_app, '', '', 'Demon.NoExistenEntParaEnviarCola', '');
      end;
      Free;
    end;
  except
    on e: exception do
    begin
      resultado := resultado + 'Error enviando cola entregados. ' + e.ClassName + ' ' + e.Message + ln;
    end;
  end;
end;

function EnviaEstados(qry,id_cliente, dias_atras:Integer; url,user,pass,llamada,extra_est,extra_ent,ok_est,dem_estados:string;
                      log_app,pc_ip,pc_nom:string; usu_id:Integer; f_ini,f_fin:TDateTime;
                      cli_api_url,cli_api_user,cli_api_pass:string):string;
var
  token,log, sentencia: string;
  i, cont_peds_est, cont_est, cont_peds_ent, cont_ent: integer;
  resultado, pedidos, resul_temp: string;
  estados: TStringList;
begin

   estados := TStringList.Create;
   estados.Delimiter := ',';
   estados.DelimitedText := dem_estados;

   if estados.Count=0 then
   begin
       result := 'No existen estados programados para este cliente.' + ln;
       estados.Free;
       Exit;
   end;

   dmEstadoPedido.lgs_api_url := url;
   dmEstadoPedido.lgs_api_user := user;
   dmEstadoPedido.lgs_api_pass := pass;
   dmEstadoPedido.lgs_api_llamada := llamada;

   resultado := '';
   resul_temp := '';
   cont_peds_est := 0;
   cont_peds_ent := 0;
   cont_est := 0;
   cont_ent := 0;

   //COLA ESTADOS

   if qry=qry_ent then  //Si es esta query se está lanzando el demonio completo (estados almacen y entregado gest)
   begin
     try
        with TpFIBDataSet.Create(dm) do
        begin
          close;
          Database := dm.db;
          Transaction := dm.t_read;
          SelectSQL.Clear;
          SelectSQL.Add('select query from g_queries where id=:qry_est');    //qry estados pro
          //SelectSQL.Add('select query from g_queries where id=150');    //qry estados test
          ParamByName('qry_est').AsInteger := qry_est;
          Open;

          if not IsEmpty then
          begin
              sentencia := FieldByName('query').AsString;

              if id_cliente=7890 then //Maxivital
                    token := dmPargal.Login(cli_api_url,cli_api_user,cli_api_pass);

              for I := 0 to estados.Count-1 do
              begin
                if sentencia<>'' then
                begin
                  Close;
                  SelectSQL.Clear;
                  SelectSQL.Add(sentencia);
                  ParamByName('id_cliente').AsInteger := id_cliente;
                  ParamByName('fecha').AsDateTime := Now-dias_atras;
                  //ParamByName('dias_atras').AsInteger := dias_atras;
                  ParamByName('extra').AsString := extra_est;
                  ParamByName('ok').AsString := ok_est;
                  ParamByName('estado').AsString := estados[i];
                  Open;
                end;

                if not IsEmpty then
                begin
                  First;

                  while not Eof do
                  begin
                      if id_cliente=7890 then     //Maxivital
                          resul_temp := 'Est.' + FieldByName('estado').AsString + ' ' + dmPargal.EnviaPedido(token,cli_api_url,FieldByName('id_pedido').AsInteger,-1,log)
                      else
                          resul_temp := 'Est.' + FieldByName('estado').AsString + ' ' + dmEstadoPedido.EstadoPedido(FieldByName('id_pedido').AsInteger);
                      //resultado := resultado + FieldByName('estado').AsString + ' ' + resul_temp + ln;

                      InsertaLog(usu_id,FieldByName('id_pedido').AsInteger,0,pc_nom,pc_ip,log_app,'pedido','','Demon.EnviadoEstadoACola ' + FieldByName('id_pedido').AsString,resul_temp);

                      Inc(cont_peds_est);

                      if ((Pos('Ok',resul_temp)>0) or (Pos('(200)',resul_temp)>0))  then
                      begin
                          inserta_pedido_extra(FieldByName('id_pedido').AsInteger,extra_est,ok_est+ ' ' + FieldByName('estado').AsString + ' ' + FormatDateTime('dd.mm.yy hh:nn:ss',Now));
                          Inc(cont_est);
                      end else
                            resultado := resultado + FieldByName('estado').AsString + ' ' + resul_temp + ln;
                      Next;
                  end;
                end else begin
                      //resultado := resultado + 'No existen estados para enviar a cola.' + ln;
                      InsertaLog(usu_id,0,0,pc_nom,pc_ip,log_app,'','','Demon.NoExistenEstParaEnviarCola',estados[i]);
                    end;
              end;
          end;

          Free;
        end;
     except on e:exception do begin
                  resultado := resultado + 'Error enviando cola estados. ' + e.Message + ln;
               end;
     end;

   end;

   cola_entregados(qry,usu_id,id_cliente,dias_atras,resul_temp,sentencia,ok_est,pc_nom,pc_ip,log_app,extra_ent,f_ini,f_fin,cont_peds_ent, cont_ent, resultado);

   resultado := resultado + 'Estados: ' + IntToStr(cont_est) + '/' + IntToStr(cont_peds_est) + ln + 'Entregados: ' + IntToStr(cont_ent)+ '/' + IntToStr(cont_peds_ent);
   Result := resultado;
   estados.Free;
end;

end.
