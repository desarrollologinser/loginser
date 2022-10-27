unit u_seur;

interface

uses
  System.SysUtils, system.strutils, vcl.dialogs, Vcl.Controls, Vcl.Forms, sDialogs, pFIBDataSet, Variants;

function crear_fichero:string;
function crear_fichero_uno: string;

implementation

uses
  u_main, u_dm;

function crear_fichero:string;
var
  strUrl, nombre, pedidos: string;
  resultado, envia_email, pedir_etiq:Boolean;
  line: integer;
begin

  pedidos := '';
  resultado:= True;

  f_main.lb_st1.Caption := 'Creando fichero Seur...';

  f_main.CreaExcel;

  Hoja := excel.Worksheets.Item[1];

  line := 1;

  u_main.excel.cells[line,1]  := 'ID_PEDIDO';
  u_main.excel.cells[line,2]  := 'ORDER_NAME';
  u_main.excel.cells[line,3]  := 'ID_CLIENTE';
  u_main.excel.cells[line,4]  := 'FECHA_PED';
  u_main.excel.cells[line,5]  := 'DEST_NOMBRE';
  u_main.excel.cells[line,6]  := 'DEST_EMPRESA';
  u_main.excel.cells[line,7]  := 'DEST_DIR';
  u_main.excel.cells[line,8]  := 'DEST_POBLACION';
  u_main.excel.cells[line,9]  := 'DEST_PROVINCIA';
  u_main.excel.cells[line,10]  := 'DEST_CP';
  u_main.excel.cells[line,11] := 'DEST_PAIS';
  u_main.excel.cells[line,12] := 'DEST_PAIS_CODE';
  u_main.excel.cells[line,13] := 'DEST_CONTACTO';
  u_main.excel.cells[line,14] := 'DEST_TELEFONO';
  u_main.excel.cells[line,15] := 'DEST_EMAIL';
  u_main.excel.cells[line,16] := 'OBSERVACIONES';
  u_main.excel.cells[line,17] := 'CODALBARAN';
  u_main.excel.cells[line,18] := 'BULTOS';
  u_main.excel.cells[line,19] := 'KGS';
  u_main.excel.cells[line,20] := 'TIPO_SERVICIO';
  u_main.excel.cells[line,21] := 'HORARIO';
  u_main.excel.cells[line,22] := 'PRODUCTO';
  Inc(line);

  if f_main.chTodos.Checked then
  begin
    if MessageDlg('Va a crear un fichero con los pedidos de Seur. ¿Está seguro?',mtWarning,mbYesNo,0)=mrNo then
        Exit
    else begin
           try
              Inc(line);
              with dm.q_peds do
              begin
                First;
                f_main.ga_stat.MaxValue := dm.q_peds.RecordCount;
                f_main.ga_stat.Progress:=0;
                application.ProcessMessages;

                while not Eof do
                begin
                    // SI SE MODIFICA, MODIFICAR TAMBIEN EN q_pedsAfterScroll DEL dm

                     {  if ( //(FieldByName('estado').asstring = 'G') and
                         (FieldByName('id_repartidor').AsInteger = agencia_seur) and
                         //(IndexStr(FieldByName('pais_code').asstring,['ES','PT'])<0) and
                         (not f_main.tiene_etiquetas(FieldByName('id_pedido').AsInteger))    //No se han sacado las etiquetas anteriormente
                       ) then}

                    dm.dsPedirEtiqueta.Close;
                    dm.dsPedirEtiqueta.ParamByName('id_pedido').AsInteger := FieldByName('id_pedido').AsInteger;
                    dm.dsPedirEtiqueta.Open;
                    pedir_etiq := (dm.dsPedirEtiqueta.FieldByName('ok').AsInteger=2);
                    if pedir_etiq then
                    begin
                                 u_main.excel.cells[line,1]  := fieldbyname('id_pedido').AsString;
                                 if u_main.mail_order_name<>'' then
                                      u_main.excel.cells[line,2]  := fieldbyname(u_main.mail_order_name).AsString
                                 else
                                      u_main.excel.cells[line,2]  := fieldbyname('order_name').AsString;
                                 u_main.excel.cells[line,3]  := fieldbyname('id_cliente').AsString;
                                 u_main.excel.cells[line,4]  := fieldbyname('fecha_ped').AsString;
                                 u_main.excel.cells[line,5]  := fieldbyname('nombre').AsString + ' ' + fieldbyname('company').AsString;
                                 u_main.excel.cells[line,6]  := fieldbyname('company').AsString;
                                 u_main.excel.cells[line,7]  := fieldbyname('dir_1').AsString;
                                 u_main.excel.cells[line,8]  := fieldbyname('poblacion').AsString;
                                 u_main.excel.cells[line,9]  :=fieldbyname('provincia').AsString;
                                 if fieldbyname('pais_code').AsString<>'PT' then
                                     u_main.excel.cells[line,10] :=fieldbyname('cp').AsString
                                 else
                                     u_main.excel.cells[line,10] := Copy(fieldbyname('cp').AsString,0,4);
                                 u_main.excel.cells[line,11]  :=fieldbyname('pais').AsString;
                                 u_main.excel.cells[line,12]  :=fieldbyname('pais_code').AsString;
                                 u_main.excel.cells[line,13]  :=fieldbyname('contacto').AsString;
                                 u_main.excel.cells[line,14]  :=fieldbyname('telefono').AsString;
                                 u_main.excel.cells[line,15] :=fieldbyname('email').AsString;
                                 u_main.excel.cells[line,16] :=fieldbyname('observaciones').AsString;
                                 u_main.excel.cells[line,17] :=fieldbyname('codalbaran').AsString;
                                 u_main.excel.cells[line,18]  :=fieldbyname('bultos').AsString;
                                 u_main.excel.cells[line,19] :=fieldbyname('peso').AsString;
                                 u_main.excel.cells[line,20] :=fieldbyname('tipo_servicio').AsString;
                                 u_main.excel.cells[line,21] :=fieldbyname('horario').AsString;
                                 u_main.excel.cells[line,22] := prod_seur;
                                 inc(line);
                                 pedidos := pedidos + fieldbyname('id_pedido').AsString + ',';
                              end;

                    f_main.ga_stat.Progress := f_main.ga_stat.Progress + 1;
                    application.ProcessMessages;

                    Next;
                end;
              end;
           except
              resultado := False;
              pedidos := 'error,';
           end;

    end;
  end else begin
              if MessageDlg('Va a crear un fichero con el pedido ' + dm.q_peds.FieldByName('order_name').AsString + '. ¿Está seguro?',mtWarning,mbYesNo,0)=mrNo then
                    Exit
              else begin

                     try
                       with dm.q_peds do
                       begin
                          { if ( //(FieldByName('estado').asstring = 'G') and
                           (FieldByName('id_repartidor').AsInteger = agencia_seur) and
                           //(IndexStr(FieldByName('pais_code').asstring,['ES','PT'])<0) and
                           (not f_main.tiene_etiquetas(FieldByName('id_pedido').AsInteger))    //No se han sacado las etiquetas anteriormente
                           ) then}

                           dm.dsPedirEtiqueta.Close;
                           dm.dsPedirEtiqueta.ParamByName('id_pedido').AsInteger := FieldByName('id_pedido').AsInteger;
                           dm.dsPedirEtiqueta.Open;
                           pedir_etiq := (dm.dsPedirEtiqueta.FieldByName('ok').AsInteger=2);
                           if pedir_etiq then
                           begin
                             u_main.excel.cells[line,1]  := fieldbyname('id_pedido').AsString;

                             if u_main.mail_order_name='' then
                                u_main.excel.cells[line,2]  := fieldbyname('order_name').AsString
                             else
                                u_main.excel.cells[line,2]  := fieldbyname(u_main.mail_order_name).AsString;
                             u_main.excel.cells[line,3]  := fieldbyname('id_cliente').AsString;
                             u_main.excel.cells[line,4]  := fieldbyname('fecha_ped').AsString;
                             u_main.excel.cells[line,5]  := fieldbyname('nombre').AsString + ' ' + fieldbyname('company').AsString;
                             u_main.excel.cells[line,6]  := fieldbyname('company').AsString;
                             u_main.excel.cells[line,7]  := fieldbyname('dir_1').AsString;
                             u_main.excel.cells[line,8]  := fieldbyname('poblacion').AsString;
                             u_main.excel.cells[line,9]  := fieldbyname('provincia').AsString;
                             if fieldbyname('pais_code').AsString<>'PT' then
                                     u_main.excel.cells[line,10] :=fieldbyname('cp').AsString
                                 else
                                     u_main.excel.cells[line,10] := Copy(fieldbyname('cp').AsString,0,4);
                             u_main.excel.cells[line,11] := fieldbyname('pais').AsString;
                             u_main.excel.cells[line,12] := fieldbyname('pais_code').AsString;
                             u_main.excel.cells[line,13] := fieldbyname('contacto').AsString;
                             u_main.excel.cells[line,14] := fieldbyname('telefono').AsString;
                             u_main.excel.cells[line,15] := fieldbyname('email').AsString;
                             u_main.excel.cells[line,16] := fieldbyname('observaciones').AsString;
                             u_main.excel.cells[line,17] := fieldbyname('codalbaran').AsString;
                             u_main.excel.cells[line,18] := fieldbyname('bultos').AsString;
                             u_main.excel.cells[line,19] := fieldbyname('peso').AsString;
                             u_main.excel.cells[line,20] := fieldbyname('tipo_servicio').AsString;
                             u_main.excel.cells[line,21] := fieldbyname('horario').AsString;
                             u_main.excel.cells[line,22] := prod_seur;

                             pedidos := dm.q_peds.fieldbyname('id_pedido').AsString +',';
                           end;

                       end;

                       resultado := (pedidos<>'');
                     except
                        resultado := False;
                        pedidos := 'error,';
                     end;

                   end;
       end;

  if resultado then
            begin
              nombre := 'seur_'+formatdatetime('dd_mm_yyyy_hh_nn',Now)+'.xlsx';
              excel.activeworkbook.saveas(f_main.deDir.Text + nombre);
              excel.activeworkbook.saveas(ruta_fichero_seur_copia + nombre);
            end else begin
                 if pedidos='' then
                    sMessageDlg('No existen pedidos a insertar en el fichero.',mtInformation,[mbok],0)
                 else
                    sMessageDlg('Error creando fichero de Seur.',mtError,[mbok],0);
            end;

  Excel.Quit ;
  Excel := Unassigned;

  f_main.btSeur.Enabled := False;
  if nombre<>'' then
      Result := nombre + '|' + Copy(pedidos,0, Length(pedidos)-1)
  else
      result := '';
end;

function crear_fichero_uno:string;
var
  strUrl, nombre, pedidos: string;
  resultado, envia_email, pedir_etiq:Boolean;
  line: integer;
begin

  pedidos := '';
  resultado:= True;

  f_main.lb_st1.Caption := 'Creando fichero Seur...';

  f_main.CreaExcel;

  Hoja := excel.Worksheets.Item[1];

  line := 1;

  u_main.excel.cells[line,1]  := 'ID_PEDIDO';
  u_main.excel.cells[line,2]  := 'ORDER_NAME';
  u_main.excel.cells[line,3]  := 'ID_CLIENTE';
  u_main.excel.cells[line,4]  := 'FECHA_PED';
  u_main.excel.cells[line,5]  := 'DEST_NOMBRE';
  u_main.excel.cells[line,6]  := 'DEST_EMPRESA';
  u_main.excel.cells[line,7]  := 'DEST_DIR';
  u_main.excel.cells[line,8]  := 'DEST_POBLACION';
  u_main.excel.cells[line,9]  := 'DEST_PROVINCIA';
  u_main.excel.cells[line,10]  := 'DEST_CP';
  u_main.excel.cells[line,11] := 'DEST_PAIS';
  u_main.excel.cells[line,12] := 'DEST_PAIS_CODE';
  u_main.excel.cells[line,13] := 'DEST_CONTACTO';
  u_main.excel.cells[line,14] := 'DEST_TELEFONO';
  u_main.excel.cells[line,15] := 'DEST_EMAIL';
  u_main.excel.cells[line,16] := 'OBSERVACIONES';
  u_main.excel.cells[line,17] := 'CODALBARAN';
  u_main.excel.cells[line,18] := 'BULTOS';
  u_main.excel.cells[line,19] := 'KGS';
  u_main.excel.cells[line,20] := 'TIPO_SERVICIO';
  u_main.excel.cells[line,21] := 'HORARIO';
  u_main.excel.cells[line,22] := 'PRODUCTO';
  Inc(line);


     try
       with dm.q_peds do
       begin

             u_main.excel.cells[line,1]  := fieldbyname('id_pedido').AsString;

             if u_main.mail_order_name='' then
                u_main.excel.cells[line,2]  := fieldbyname('order_name').AsString
             else
                u_main.excel.cells[line,2]  := fieldbyname(u_main.mail_order_name).AsString;
             u_main.excel.cells[line,3]  := fieldbyname('id_cliente').AsString;
             u_main.excel.cells[line,4]  := fieldbyname('fecha_ped').AsString;
             u_main.excel.cells[line,5]  := fieldbyname('nombre').AsString + ' ' + fieldbyname('company').AsString;
             u_main.excel.cells[line,6]  := fieldbyname('company').AsString;
             u_main.excel.cells[line,7]  := fieldbyname('dir_1').AsString;
             u_main.excel.cells[line,8]  := fieldbyname('poblacion').AsString;
             u_main.excel.cells[line,9]  := fieldbyname('provincia').AsString;
             if fieldbyname('pais_code').AsString<>'PT' then
                     u_main.excel.cells[line,10] :=fieldbyname('cp').AsString
                 else
                     u_main.excel.cells[line,10] := Copy(fieldbyname('cp').AsString,0,4);
             u_main.excel.cells[line,11] := fieldbyname('pais').AsString;
             u_main.excel.cells[line,12] := fieldbyname('pais_code').AsString;
             u_main.excel.cells[line,13] := fieldbyname('contacto').AsString;
             u_main.excel.cells[line,14] := fieldbyname('telefono').AsString;
             u_main.excel.cells[line,15] := fieldbyname('email').AsString;
             u_main.excel.cells[line,16] := fieldbyname('observaciones').AsString;
             u_main.excel.cells[line,17] := fieldbyname('codalbaran').AsString;
             u_main.excel.cells[line,18] := fieldbyname('bultos').AsString;
             u_main.excel.cells[line,19] := fieldbyname('peso').AsString;
             u_main.excel.cells[line,20] := fieldbyname('tipo_servicio').AsString;
             u_main.excel.cells[line,21] := fieldbyname('horario').AsString;
             u_main.excel.cells[line,22] := prod_seur;

             pedidos := dm.q_peds.fieldbyname('id_pedido').AsString +',';


       end;

       resultado := (pedidos<>'');
     except
        resultado := False;
        pedidos := 'error,';
     end;

  if resultado then
            begin
              nombre := 'seur_'+formatdatetime('dd_mm_yyyy_hh_nn_ss',Now)+'.xlsx';
              excel.activeworkbook.saveas(f_main.deDir.Text + nombre);
              excel.activeworkbook.saveas(ruta_fichero_seur_copia + nombre);
            end else begin
                 if pedidos='' then
                    sMessageDlg('No existen pedidos a insertar en el fichero.',mtInformation,[mbok],0)
                 else
                    sMessageDlg('Error creando fichero de Seur.',mtError,[mbok],0);
            end;

  Excel.Quit ;
  Excel := Unassigned;

  f_main.btSeur.Enabled := False;
  if nombre<>'' then
      Result := nombre + '|' + Copy(pedidos,0, Length(pedidos)-1)
  else
      result := '';
end;

end.
