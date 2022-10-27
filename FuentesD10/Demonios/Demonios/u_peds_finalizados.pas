unit u_peds_finalizados;

interface

uses
    System.Classes, system.SysUtils, pFIBDataSet, pFIBQuery;

function ControlFinalizados(id_cliente,dias_atras:Integer; log_app,pc_ip,pc_nom:string; usu_id:Integer):string;

const
  ln = #13#10;
implementation

uses
    u_dm,u_dmPargal, u_envia_mail, u_functions, u_globals_gestoras;

function ControlFinalizados(id_cliente, dias_atras:Integer; log_app,pc_ip,pc_nom:string; usu_id:Integer):string;
var
  sentencia, sql_aux: string;
  resultado, pedidos, peds_act: string;
  log_error:TStringList;
  cuenta, cuenta_total: integer;
  fecha_aux: TDateTime;
begin

   resultado := '';
   cuenta := 0;
   sql_aux := '';
   fecha_aux := Now;

   /// REVISAR ESTADOS G CON EXPEDICION EN GESTORAS
   try

      with TpFIBDataSet.Create(dm) do
      begin
        close;
        Database := dm.db;
        Transaction := dm.t_read;
        SelectSQL.Clear;
        SelectSQL.Add('select query from g_queries where id=163');
        Open;

        if not IsEmpty then
        begin
            sentencia := FieldByName('query').AsString;

            if sentencia<>'' then
            begin
              Close;
              SelectSQL.Clear;
              SelectSQL.Add(sentencia);

              if id_cliente>0 then
              begin
                SelectSQL.Add('and id_cliente=:id_cliente');
                ParamByName('id_cliente').AsInteger := id_cliente;
              end;

              ParamByName('fecha').AsDate := Now-dias_atras;
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
                Inc(cuenta);
              end;
              Next;
            end;
          end else begin
                resultado := resultado + 'No existen estados G con expedición.' + ln;
                InsertaLog(usu_id,0,0,pc_nom,pc_ip,log_app,'','','Demon.NoExistenEstGConExpedicion','ActG->E');
              end;
        end;

        Free;
      end;

      if peds_act<>'' then
      begin
          peds_act := Copy(peds_act, 0, Length(peds_act) - 1);

          dm.t_write.StartTransaction;

          sql_aux := 'update c_pedidos set estado=:estado, fecha_fin=:fecha_fin where id_pedido in (' + peds_act + ')';

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
              //resultado := resultado + 'Estado G->E: ' + peds_act + ln;
              resultado := 'Actualizados ' + IntToStr(cuenta) + ' pedidos.' + ln;
            end;

      end else begin
                resultado := resultado + 'No existen pedidos en G con expedición.' + ln;
                InsertaLog(usu_id,0,0,pc_nom,pc_ip,log_app,'','','Demon.NoExistenEstGConExpedicion','ActG->E');
              end;

   except on e:exception do begin
                resultado := resultado + 'Error actualizando estados G->E.' + ln;
             end;
   end;

   Result := resultado;
end;

end.
