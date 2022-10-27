unit u_muzybar;

interface

uses
  System.SysUtils, System.StrUtils,ScDataHandler, ScSFTPUtils, vcl.dialogs;

function CalculaTransporteMuzybar(cod_muz:Integer; var tr_propio:Integer):integer;
procedure send_file_muzybar(id_pedido:integer;solo_fichero:Boolean);

implementation

uses
  u_globals_gestoras, u_dm, Documento, u_functions, u_main, u_globals;

function CalculaTransporteMuzybar(cod_muz:Integer; var tr_propio:Integer):integer;
begin
   Result := -1;

    with dm.qrytemp do
    begin
      Close;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select * from cl_muzy_params_envio(:cod_muz)');
      ParamByName('cod_muz').AsInteger := cod_muz;
      Open;

      if not IsEmpty then
      begin
          Result := FieldByName('repartidor').AsInteger;
          tr_propio := FieldByName('tr_propio').AsInteger;
      end;
    end;
end;

procedure send_file_muzybar(id_pedido:integer;solo_fichero:Boolean);
var   exp_xml:IXMLDocumento;         xml_path,n_serie:string;          i,line,id_order:integer;
  Handle:  TScSFTPFileHandle; fecha_aux:TDatetime;
begin
  dm.ds_2.Close;
  dm.ds_2.SQLs.SelectSQL.Clear;
  dm.ds_2.SQLs.SelectSQL.Add('SELECT * from c_pedidos where id_pedido=:id_pedido ');
  dm.ds_2.ParamByName('id_pedido').AsInteger:=id_pedido;
  dm.ds_2.Open;

  //xml_path := '';
  xml_path:= GetExtraPedido(id_pedido,'XML_PATH');
  //showmessage(IntToStr(id_pedido) + ' ' + xml_path);
  dm.xml_1.FileName:=xml_path;
  dm.xml_1.Active:=true;
  exp_xml:=GetDocumento(dm.xml_1);
  InsertaLog(u_main.usuario.id,id_pedido,0,PC.Nombre,PC.IP,log_app,'pedido','',
                 'FichMuz.xml_path='+xml_path,'');

  {if dm.ds_2.FieldByName('tracking_number').asstring='' then exp_xml.InfGeneral.InfAlb.Tracking:=dm.ds_2.FieldByName('codalbaran').asstring
  else exp_xml.InfGeneral.InfAlb.Tracking:=dm.ds_2.FieldByName('tracking_number').asstring;       }

  exp_xml.InfGeneral.InfAlb.Tracking:=dm.ds_2.FieldByName('codalbaran').asstring;

  dm.ds_1.Close;
  dm.ds_1.SQLs.SelectSQL.Clear;
  dm.ds_1.SQLs.SelectSQL.Add('SELECT * from c_pedidos_lines where id_pedido=:id_pedido order by id_line');
  dm.ds_1.ParamByName('id_pedido').AsInteger:=id_pedido;
  dm.ds_1.Open;

  dm.ds_1.First;
  while not(dm.ds_1.Eof) do begin
    line:=-1;
    for i:=0 to exp_xml.InfGeneral.InfAlb.InfDetAlb.NLinsAlb-1 do begin
      //if exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[i].IdLin=dm.ds_1.FieldByName('id_line').asinteger then begin
      //if (IntToStr(main_cli) + rightstr(StringOfChar('0', 5) + IntToStr(exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[i].IdArt), 5)=dm.ds_1.FieldByName('sku').asstring)
      if (IntToStr(exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[i].IdArt)=dm.ds_1.FieldByName('sku').asstring)
         and
         (exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[i].NSerie='')
      then begin
        line:=i;
        Break;
      end;
    end;

    //if line<>-1 then exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[line].NSerie:=RightStr(dm.ds_1.FieldByName('imei').asstring,15);  //longitud máxima del nserie para muzybar
    if line<>-1 then exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[line].NSerie:=RightStr(dm.ds_1.FieldByName('n_serie').AsString,20);  //longitud máxima del nserie para muzybar

    dm.ds_1.Next;
  end;

  id_order:=dm.ds_2.fieldbyname('order_name').asinteger;

  xml_path:= u_main.path_copy_out + 'Alb_'+inttostr(id_order)+'.xml';
  if FileExists(xml_path) then
  begin
      GetFileTimes(xml_path,'C',fecha_aux);
      RenameFile(xml_path, xml_path + '_' + FormatDateTime('ddmmyyhhmmss',fecha_aux));
  end;

  dm.xml_1.SaveToFile(xml_path);

  if not solo_fichero then
  begin

    if Pos('servertest',u_globals.api)<=0 then
    begin
      dm.ftp_1.Connect;
      dm.ftp_1.ChangeDir(u_main.ftp_out+GetExtraPedido(id_pedido,'sociedad'));
      dm.ftp_1.Put(xml_path,'Alb_'+inttostr(id_order)+'.xml',True,0);
      dm.ftp_1.Disconnect;
    end;


    dm.t_write.StartTransaction;
    try
      dm.q_1.Close;
      dm.q_1.sql.Clear;
      dm.q_1.sql.Add('insert into c_pedidos_extras ' + '(ID_PEDIDO,DESCRIPCION,VALOR) ' +
                     'values (:ID_PEDIDO,:DESCRIPCION,:VALOR)');
      dm.q_1.ParamByName('ID_PEDIDO').AsInteger := id_pedido;
      dm.q_1.ParamByName('DESCRIPCION').AsString := 'PATH_FILE_SEND';
      dm.q_1.ParamByName('VALOR').asstring := xml_path;
      dm.q_1.ExecQuery;

      dm.t_write.Commit;

      InsertaLog(u_main.usuario.id,id_pedido,0,PC.Nombre,PC.IP,log_app,'pedido','',
                 'Fichero Muzybar Enviado','Ped. ' + IntToStr(id_pedido));
    except
       dm.t_write.Rollback;
    end;

  end else begin
     dm.t_write.StartTransaction;
    try
      dm.q_1.Close;
      dm.q_1.sql.Clear;
      dm.q_1.sql.Add('insert into c_pedidos_extras ' + '(ID_PEDIDO,DESCRIPCION,VALOR) ' +
                     'values (:ID_PEDIDO,:DESCRIPCION,:VALOR)');
      dm.q_1.ParamByName('ID_PEDIDO').AsInteger := id_pedido;
      dm.q_1.ParamByName('DESCRIPCION').AsString := 'PATH_FILE';
      dm.q_1.ParamByName('VALOR').asstring := xml_path;
      dm.q_1.ExecQuery;

      dm.t_write.Commit;

      InsertaLog(u_main.usuario.id,id_pedido,0,PC.Nombre,PC.IP,log_app,'pedido','',
                 'FicheroMuzybarCreadoSinEnvio','Ped. ' + IntToStr(id_pedido));
    except
       dm.t_write.Rollback;
    end;
  end;
   {
  dm.t_write.StartTransaction;
  try
    dm.q_1.Close;
    dm.q_1.sql.Clear;
    dm.q_1.sql.Add('update c_pedidos set estado=''E'',fecha_env=:fecha where id_muzybar=:id_muzybar');
    dm.q_1.ParamByName('id_muzybar').AsInteger:=id_pedido;
    dm.q_1.ParamByName('fecha').AsDateTime:=now;
    dm.q_1.ExecQuery;
    dm.t_write.Commit;
  except
    dm.t_write.rollback;
  end; }
end;
end.
