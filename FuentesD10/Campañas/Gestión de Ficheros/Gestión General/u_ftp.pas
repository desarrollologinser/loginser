unit u_ftp;

interface

uses
  Xml.XMLDoc, Xml.xmldom, Xml.XMLIntf, System.SysUtils, System.AnsiStrings;

  procedure send_file(id_pedido:integer);


implementation

uses
  u_main,u_dm, Documento;

{$REGION 'Send Files'}

procedure send_file(id_pedido:integer);
var   exp_xml:IXMLDocumento;         xml_path:string;          i,line,id_order:integer;
begin
  dm.ds_2.Close;
  dm.ds_2.SQLs.SelectSQL.Clear;
  dm.ds_2.SQLs.SelectSQL.Add('SELECT * from c_pedidos p inner join c_pedidos_extras e on p.id_pedido=e.id_pedido where p.id_pedido=:id_pedido ');
  dm.ds_2.ParamByName('id_pedido').AsInteger:=id_pedido;
  dm.ds_2.Open;

  xml_path:=dm.ds_2.FieldByName('xml_path').asstring;
  f_main.xml_1.FileName:=xml_path;
  f_main.xml_1.Active:=true;
  exp_xml:=GetDocumento(f_main.xml_1);

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
      if exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[i].IdLin=dm.ds_1.FieldByName('id_line').asinteger then begin
        line:=i;
        Break;
      end;
    end;

    if line<>-1 then exp_xml.InfGeneral.InfAlb.InfDetAlb.LinAlb[line].NSerie:=RightStr(dm.ds_1.FieldByName('n_serie').asstring,15);  //longitud máxima del nserie para muzybar

    dm.ds_1.Next;
  end;

  id_order:=dm.ds_2.fieldbyname('id_order').asinteger;

  xml_path:='\\seth\sysfiles\Importacion\Muzybar\Out\Alb_'+inttostr(id_order)+'.xml';
  f_main.xml_1.SaveToFile(xml_path);

  f_main.ftp_1.connect;
  try
    f_main.ftp_1.ChangeDir('/sync/muzybar/out/'+dm.ds_2.FieldByName('sociedad').AsString);
    f_main.ftp_1.Put(xml_path,'Alb_'+inttostr(id_order)+'.xml');
  finally
    f_main.ftp_1.Disconnect;
  end;

  dm.t_write.StartTransaction;
  try
    dm.q_1.Close;
    dm.q_1.sql.Clear;
    dm.q_1.sql.Add('update c_pedidos set estado=''E'',fecha_env=:fecha where id_pedido=:id_pedido');
    dm.q_1.ParamByName('id_pedido').AsInteger:=id_pedido;
    dm.q_1.ParamByName('fecha').AsDateTime:=now;
    dm.q_1.ExecQuery;
    dm.t_write.Commit;
  except
    dm.t_write.rollback;
  end;
end;
{$ENDREGION}

end.
