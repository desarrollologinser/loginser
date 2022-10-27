unit u_privalia;

interface

uses
  System.SysUtils, System.Classes, strutils, types, pfibdataset, sDialogs,
  System.UITypes, Vcl.Dialogs, Vcl.Forms;

  procedure importa_fichero_privalia;

implementation

uses
  u_main, u_dm, u_functions;

procedure importa_fichero_privalia;
var  fic, list_peds:tstringlist;   i,id_articulo:integer;
     order_name_old,cp,telefono,nombre_art, pais, pais_code, observaciones:string;
     str_dyn:TStringDynArray;
     id_pedido,id_line,n, deliv_time, r, deleg:Integer;
     reembolso,reemb_value, pd_value: Double;
     fin: Boolean;
begin

  if FileExists(f_main.ed_csv.filename) then begin
    fic:=tstringlist.create();
    fic.LoadFromFile(f_main.ed_csv.filename);

    order_name_old:='9999999';
    n:=0;
    list_peds:=tstringlist.create();
    list_peds.Clear;

    dm.t_write.StartTransaction;
    try
      for i:=1 to fic.Count-1 do begin

        if ExtractFileExt(f_main.ed_csv.FileName)='.csv' then      //CSV
        begin
          str_dyn:=splitstring(fic[i],';');

          if Pos('Preparando',str_dyn[4])>0 then
          begin
              if order_name_old<>str_dyn[1] then begin              //new cabecera


                order_name_old:=str_dyn[1];

                with TpFIBDataSet.Create(f_main) do
                try
                  Database:=dm.db;
                  sqls.SelectSQL.Add('SELECT GEN_ID(GEN_C_PEDIDOS_ID,1) FROM RDB$DATABASE');
                  Open;
                  id_pedido:=FieldByName('gen_id').AsInteger;
                finally
                  free;
                end;

                id_line:=1;

                deleg := -1;
                deliv_time := u_main.delivery_time;
                pais := str_dyn[51];
                pais_code := 'ES';

                if pais_code='ES' then begin
                  if Length(str_dyn[37])>9 then telefono:=copy(str_dyn[51],Length(str_dyn[37])-8,9)
                  else telefono:=str_dyn[37];
                end else telefono:=str_dyn[37];

                if pais_code='ES' then
                      cp:=f_main.format_cp(str_dyn[33])
                  else
                      cp:=str_dyn[33];

                reembolso := 0;
                observaciones := '';

                f_main.InsertaPedido(id_pedido,StrToInt(f_main.edCliente.Text),deliv_time,transporte_propio,
                                     u_main.repartidor,deleg,0,0,IntToStr(id_pedido),str_dyn[1],  //order_name
                                     Trim(str_dyn[27]+' ' + str_dyn[28]), //nombre
                                     Trim(str_dyn[30]+' ' + str_dyn[32]),  //dir
                                     str_dyn[34], //poblacion
                                     GetProvinciaNombre(Copy(cp,0,2)), //provincia
                                     '',cp,pais,pais_code,telefono,'','',
                                     str_dyn[1],observaciones,'', '', '', '','PRIVALIA', '', '', 'P', '', '',
                                     StrToDate(FormatDateTime('dd/mm/yyyy',StrToDate(Copy(str_dyn[0],0,8)))),  //fecha_ped
                                     StrToDate('30/12/1899'),reembolso);

                Inc(n);
              end;

              id_articulo:=f_main.busca_art(str_dyn[6],StrToInt(f_main.edCliente.Text));

              if id_articulo<>-1 then
                  nombre_art:= f_main.busca_art_nom(id_articulo)
              else nombre_art:='';
                                                                       //cantidad   //sku
              f_main.InsertaPedidoLine(id_pedido,id_line,id_articulo,StrToInt(str_dyn[2]),-1,str_dyn[6],nombre_art);

              Inc(id_line);

              list_peds.Add(IntToStr(id_pedido));
           end;
        end else if ((ExtractFileExt(f_main.ed_csv.FileName)='.xls') or (ExtractFileExt(f_main.ed_csv.FileName)='.xlsx')) then      //XLS
                 begin

                   {{{{{{ fin := False;
                    r := 1; //Empezamos desde la fila 1, ignoramos las cabeceras

                    CopyFile(PWideChar(ed_csv.FileName),PWideChar(ChangeFileExt(ed_csv.FileName,'.xlsx')),False);

                    xls_1.Filename := ChangeFileExt(ed_csv.FileName,'.xlsx');
                    xls_1.Read;

                    while not (xls_1.Sheets[0].AsString[0,r]='') do
                    begin
                       if order_name_old<>xls_1.Sheets[0].AsString[col_pedido,r] then begin              //new cabecera

                          order_name_old := xls_1.Sheets[0].AsString[col_pedido,r];

                          with TpFIBDataSet.Create(self) do
                          try
                            Database:=dm.db;
                            sqls.SelectSQL.Add('SELECT GEN_ID(GEN_C_PEDIDOS_ID,1) FROM RDB$DATABASE');
                            Open;
                            id_pedido:=FieldByName('gen_id').AsInteger;
                          finally
                            free;
                          end;

                          id_line:=1;

                          if col_delivery_time=-1 then
                               deliv_time := delivery_default
                          else If xls_1.Sheets[0].AsString[col_delivery_time,r]<>'' then
                                    deliv_time := StrToInt(xls_1.Sheets[0].AsString[col_delivery_time,r])
                               else
                                    deliv_time := delivery_default;

                          if col_pais=-1 then
                              pais := 'ES'
                          else
                              pais := xls_1.Sheets[0].AsString[col_pais,r];

                          if pais='ES' then
                              cp:=format_cp(xls_1.Sheets[0].AsString[col_destino_cp,r])
                          else
                              cp:=xls_1.Sheets[0].AsString[col_destino_cp,r];

                          if pais='ES' then begin
                            if Length(xls_1.Sheets[0].AsString[col_destino_telefono,r])>9 then
                                telefono:=copy(xls_1.Sheets[0].AsString[col_destino_telefono,r],Length(xls_1.Sheets[0].AsString[col_destino_telefono,r])-8,9)
                            else
                                telefono:=xls_1.Sheets[0].AsString[col_destino_telefono,r];
                          end else
                                telefono:=xls_1.Sheets[0].AsString[col_destino_telefono,r];

                          if col_destino_delegacion=-1 then
                              deleg := -1
                          else if xls_1.Sheets[0].AsString[col_destino_delegacion,r]='' then
                                 deleg := -1
                               else
                                 deleg := xls_1.Sheets[0].AsInteger[col_destino_delegacion,r];

                          //Fanessi Reembolso= mayor entre reembolso y portes debidos
                          //        Observaciones= cobrar reembolso + observaciones
                          if edCliente.Text = '6695' then
                          begin
                              if xls_1.Sheets[0].AsString[col_reembolso,r]='' then
                                 reemb_value := 0
                              else
                                 reemb_value := xls_1.Sheets[0].AsFloat[col_reembolso,r];

                              if xls_1.Sheets[0].AsString[col_portes_debidos,r]='' then
                                 pd_value := 0
                              else
                                 pd_value := xls_1.Sheets[0].AsFloat[col_portes_debidos,r];

                              If reemb_value>pd_value then
                                    reembolso := reemb_value
                              else
                                    reembolso := pd_value;

                              if reembolso>0 then
                                observaciones := 'COBRAR ' + FloatToStr(reembolso) + '€. ' + xls_1.Sheets[0].AsString[col_observaciones,r]
                              else
                                observaciones := xls_1.Sheets[0].AsString[col_observaciones,r];

                          end else begin
                                      if col_reembolso<>-1 then
                                            reembolso := xls_1.Sheets[0].AsFloat[col_reembolso,r]
                                      else
                                            reembolso := 0;

                                      if col_observaciones=-1 then
                                          observaciones := ''
                                      else
                                          observaciones := xls_1.Sheets[0].AsString[col_observaciones,r];
                                   end;

                          { id_pedido,id_cliente, deliv_time, trans_propio, id_repartidor, deleg, service_ref:Integer;
                                id_order,order_name,nombre,dir,poblacion,provincia,cp,pais,pais_code,telefono,email,text,track,observaciones,
                                financial_status, fulfillment_status, gateway, company, tags, note, cancel_reason, estado:string;
                                fecha_ped, cancel_date:TDateTime; reemb:Double  }
                                                                                                                                     //order_name                          //nombre
                       {{{{{{{{   InsertaPedido(id_pedido,StrToInt(edCliente.Text),deliv_time,transporte_propio, repartidor, deleg,0 , '',xls_1.Sheets[0].AsString[col_pedido,r],xls_1.Sheets[0].AsString[col_destino_nombre,r],
                          //dir                                             //poblacion                                       //provincia
                          xls_1.Sheets[0].AsString[col_destino_direccion,r],xls_1.Sheets[0].AsString[col_destino_localidad,r],xls_1.Sheets[0].AsString[col_destino_provincia,r],cp,pais,'',telefono,
                          //email                                       //text //track                               //observaciones                                             //fecha_ped
                          xls_1.Sheets[0].AsString[col_destino_email,r],'',    xls_1.Sheets[0].AsString[col_pedido,r],observaciones,'', '', '', '','', '', '', '',Now,StrToDate('30/12/1899'),reembolso);

                          Inc(n);
                       end;

                        id_articulo:=busca_art(xls_1.Sheets[0].AsString[col_referencia_articulo,r]);

                        nombre_art:=busca_art_nom(id_articulo);
                                                                                 //cantidad                                //sku
                        InsertaPedidoLine(id_pedido,id_line,id_articulo,StrToInt(xls_1.Sheets[0].AsString[col_unidades,r]),xls_1.Sheets[0].AsString[col_referencia_articulo,r],nombre_art);

                        Inc(id_line);
                        Inc(r);
                    end;
                    DeleteFile(ChangeFileExt(ed_csv.FileName,'.xlsx'));   fin}
                 end;
      end;

      dm.t_write.Commit;

      f_main.lb_st1.Caption:='Enviando pedidos a web ...';
      for I := 0 to list_peds.Count-1 do
          f_main.send_order(StrToInt(list_peds[i]));

    except
      on e:Exception do begin
        sMessageDlg('Error Importando Fichero '+e.message, mtError,[mbok],0);
        dm.t_write.Rollback;
        if FileExists(ChangeFileExt(f_main.ed_csv.FileName,'.xlsx')) then
                 DeleteFile(ChangeFileExt(f_main.ed_csv.FileName,'.xlsx'));
        exit;
      end;
    end;

    f_main.lb_st1.Caption:='Importación Finalizada, '+inttostr(n)+' Pedidos Importados';
    application.ProcessMessages;

    f_main.filter(u_main.modo_historico);

    sMessageDlg('Importación Finalizada, '+inttostr(n)+' Pedidos Importados',mtInformation,[mbok],0);
  end else ShowMessage('Debe insertar un fichero válido.');
end;

end.
