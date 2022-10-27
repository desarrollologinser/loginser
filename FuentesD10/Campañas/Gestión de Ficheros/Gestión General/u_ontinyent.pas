unit u_ontinyent;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, MidasLib,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, sSkinProvider, sSkinManager, sGroupBox, inifiles,jpeg,
  JvDBGrid, Vcl.StdCtrls, sTooledit, sEdit, sBitBtn, sLabel,
  sGauge, sPanel, sdialogs,strutils,types,System.DateUtils,
  Data.DB, pfibdataset, sRadioButton,registry, sCheckBox, System.Variants,
  IdFTP, frxClass, frxDBSet, Datasnap.DBClient, sSpeedButton,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, Vcl.Buttons, Vcl.Mask, sMaskEdit,
  sCustomComboEdit, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, Vcl.ExtCtrls,frxbarcode;

type
  Tstock = record
    id_art:Integer;
    uds:Integer;
  end;

    procedure ImportaCOntinyent;
    procedure informe_sin_stock;
    function genera_picking:integer;
    function SiguienteLaboral(fecha:tdate):TDate;
    procedure packing;
    procedure text_to_fr(fr:tfrxreport; memo_name,text:string);

const
  sep3='|';
  sep2='#';
  sep1='$';
  httpweb='http://www.loginser.com/CaixaOntinyent/sync/';

var

  ar_stock:array of Tstock;                    //stock
  idx_stock:Integer=0;

  hiloactivo:Boolean;
  htmldevuelto:string;

implementation

uses u_dm, u_main, UGetText_ontinyent, USendText_ontinyent,{** u_packing, u_informes, **} u_functions;


{$REGION 'Filters Importar'}


procedure bt_searchClick(Sender: TObject);
begin
  {**f_informes.ShowModal;**}
end;

{$ENDREGION}

{$REGION 'Importar'}
procedure ImportaCOntinyent;                //IMPORTAR PEDIDOS DESDE FTP
var
  id_line,n,i,j,id_order,id_pedido,id_articulo,entidad,oficina, id_deleg:integer;
  order_list:TStringList;
  codigo_art, nombre_art, nombre, direccion, poblacion, provincia, cp:string;
  GetText:thSelecthilo;
  SendText:ThSendTextHilo;
  str_lista, str_linea, str_det:TStringDynArray;
  fecha_ped:TDateTime;
begin
   n:=0;
  id_line:=1;
  order_list:=tstringlist.Create();

  application.ProcessMessages;

  GetText:=ThSelectHilo.Create(true);
  GetText.FreeOnTerminate:=True;
  GetText.strurl:= httpweb+'get_pedidos.php';
  hiloactivo:=True;
  GetText.Resume;
  while hiloactivo do Application.ProcessMessages;

  str_lista:=splitstring(htmldevuelto,sep1);                    //Separa lineas por sep1 $

  dm.t_write.StartTransaction;
  try
    for i:=Low(str_lista) to High(str_lista)-1 do begin

      str_linea:=splitstring(str_lista[i],sep2);

      str_det:=SplitString(str_linea[0],sep3);      //***************************************************cabecera

      with TpFIBDataSet.Create(dm) do
      try
        Database:=dm.db;
        sqls.SelectSQL.Add('SELECT GEN_ID(GEN_C_PEDIDOS_ID,1) FROM RDB$DATABASE');
        Open;
        id_pedido:=FieldByName('gen_id').AsInteger;
      finally
        free;
      end;

      order_list.Add(str_det[0]);

      entidad:=StrToInt(str_det[1]);
      oficina:=StrToInt(str_det[2]);

      dm.ds_1.Close;
      dm.ds_1.SelectSQL.Clear;
      dm.ds_1.SelectSQL.Add('select * from g_delegaciones where id_cliente=2045 and cod_delegacion=:cod_delegacion');
      dm.ds_1.ParamByName('cod_delegacion').AsInteger:=oficina;
      dm.ds_1.Open;

      nombre:=dm.ds_1.FieldByName('nombre').AsString;

      if entidad<>oficina then begin
        dm.ds_1.Close;
        dm.ds_1.SelectSQL.Clear;
        dm.ds_1.SelectSQL.Add('select * from g_delegaciones where id_cliente=2045 and cod_delegacion=:cod_delegacion');
        dm.ds_1.ParamByName('cod_delegacion').AsInteger:=entidad;
        dm.ds_1.Open;

        nombre   := dm.ds_1.FieldByName('nombre').AsString+' - '+nombre;
        id_deleg := dm.ds_1.FieldByName('id_delegacion').AsInteger;
      end;

      if not(dm.ds_1.IsEmpty) then begin
        direccion := dm.ds_1.FieldByName('direccion').AsString;
        poblacion := dm.ds_1.FieldByName('poblacion').AsString;
        provincia := dm.ds_1.FieldByName('provincia').AsString;
        cp        := dm.ds_1.FieldByName('cp').AsString;
      end else begin
        nombre    := 'NOT FOUND';
        direccion := '';
        poblacion := '';
        provincia := '';
        cp := '';
      end;

      fecha_ped:=encodedatetime(strtoint(Copy(str_det[3],1,4)),strtoint(Copy(str_det[3],6,2)),StrToInt(Copy(str_det[3],9,2)),
        strtoint(Copy(str_det[3],12,2)),strtoint(Copy(str_det[3],15,2)),strtoint(Copy(str_det[3],18,2)),0);

      f_main.InsertaPedido(id_pedido, 2045, -1, 0, 0, -1, 0, 0, str_det[0], str_det[0], nombre, direccion, poblacion, provincia,
                           '', cp, 'Espana', 'ES', '.', '', '', '', '', '', '', '', '', '', '', '', 'P', '', '', fecha_ped, StrToDate('30/12/1899'), 0);

      Inc(n);

      id_line:=1;                    //***************************************************Lineas

      for j:=Low(str_linea)+1 to High(str_linea)-1 do begin
        str_det:=SplitString(str_linea[j],sep3);

        codigo_art := get_codcli_art(StrToInt(str_det[1]));
        nombre_art := f_main.busca_art_nom(StrToInt(str_det[1]));

        if (codigo_art='') then
            id_articulo := -1
        else
            id_articulo:=StrToInt(str_det[1]);

        f_main.InsertaPedidoLine(id_pedido, id_line, StrToInt(str_det[1]), StrToInt(str_det[2]), StrToInt(str_det[0]), codigo_art, nombre_art);

        Inc(id_line);
      end;
    end;

    dm.t_write.Commit;
  except
    dm.t_write.Rollback;
  end;

  f_main.lb_st1.Caption:='Marcando Pedidos Como Recibidos en Web';
  f_main.ga_stat.MaxValue:=n;
  f_main.ga_stat.Progress:=0;
  application.ProcessMessages;

  for i:=0 to order_list.count-1 do begin
    SendText:=ThSendTextHilo.create(true);
    SendText.launcher:=0;
    SendText.freeonterminate:=true;
    SendText.varname:='cadena';
    SendText.cadena:=order_list[i]+'|0';
    SendText.url:=httpweb;
    SendText.nomphp:='put_recibido_pedido.php';
    hiloactivo:=true;
    SendText.Resume;
    while hiloactivo do Application.ProcessMessages;

    if (htmldevuelto<>'1') then raise exception.Create('Error Actualizando Pedidos.... Avise al Administrador del Sistema, Pedido Nº '+order_list[i]);

    f_main.ga_stat.Progress := f_main.ga_stat.Progress+1;
    Application.ProcessMessages;
  end;

  FreeAndNil(order_list);

  f_main.lb_st1.Caption:='Importación Finalizada, '+inttostr(n)+' Pedidos Importados';
  application.ProcessMessages;
  f_main.filter(u_main.modo_historico);
  sMessageDlg('Importación Finalizada, '+inttostr(n)+' Pedidos Importados',mtInformation,[mbok],0);

end;
{$ENDREGION}


{$REGION 'Aux'}
procedure text_to_fr(fr:tfrxreport; memo_name,text:string);
var  memo: TfrxMemoView;
begin
  memo := fr.FindObject(memo_name) as TfrxMemoView;
  if Assigned(memo) then begin
    memo.Memo.Clear;
    memo.Memo.Add(text);
  end;
end;

function SiguienteLaboral(fecha:tdate):TDate;
begin
  fecha:=incday(fecha);
  while ((DayOfWeek(fecha)=1) or (DayOfWeek(fecha)=7)) do fecha:=incday(fecha);
  Result:=fecha;
end;
{$ENDREGION}

{$REGION 'Verif Stock'}


procedure informe_sin_stock;
var line:integer;     exist:Boolean;
begin
 {** exist:=false;

  with TpFIBDataSet.Create(self) do
  try
    Database:=dm.db;
    sqls.SelectSQL.Add('select * '+
      'from c_pedidos_ontinyent '+
      'where estado=''X''');
    Open;

    first;
    line:=0;
    xls_1.Clear;
    xls_1.Sheets[0].AsString[0,line]:='PEDIDOS PENDIENTES SIN STOCK '+formatdatetime('dd/mm/yyyy hh:nn',Now);
    inc(line,2);
    while not(Eof) do begin
      exist:=true;
      xls_1.Sheets[0].AsString[0,line]:=fieldbyname('id_order').AsString;
      xls_1.Sheets[0].AsString[2,line]:=fieldbyname('nombre').AsString;
      xls_1.Sheets[0].AsString[3,line]:=fieldbyname('dir').AsString;
      xls_1.Sheets[0].AsString[5,line]:=fieldbyname('poblacion').AsString;
      xls_1.Sheets[0].AsString[6,line]:=fieldbyname('provincia').AsString;
      xls_1.Sheets[0].AsString[7,line]:=fieldbyname('cp').AsString;
      xls_1.Sheets[0].AsString[8,line]:=fieldbyname('pais').AsString;
      xls_1.Sheets[0].AsString[10,line]:=fieldbyname('fecha_ped').AsString;
      inc(line);

      dm.ds_1.close;
      dm.ds_1.SelectSQL.Clear;
      dm.ds_1.SelectSQL.Add('select l.*,a.codigo,a.nombre,a.codigo_cli '+
        'from c_pedidos_ontinyent_lines l '+
        'left outer join g_articulos a on (l.id_articulo=a.id_articulo) '+
        'where l.id_ontinyent=:id_ontinyent order by l.id_line');
      dm.ds_1.ParamByName('id_ontinyent').AsInteger:=FieldByName('id_ontinyent').AsInteger;
      dm.ds_1.Open;

      dm.ds_1.First;
      while not(dm.ds_1.Eof) do begin
        xls_1.Sheets[0].AsString[1,line]:=dm.ds_1.fieldbyname('codigo').AsString;
        xls_1.Sheets[0].AsString[2,line]:=dm.ds_1.fieldbyname('codigo_cli').AsString;
        xls_1.Sheets[0].AsString[3,line]:=dm.ds_1.fieldbyname('nombre').AsString;
        xls_1.Sheets[0].AsString[4,line]:=dm.ds_1.fieldbyname('cantidad').AsString;
        if not(verif_stock_x_art(dm.ds_1.fieldbyname('id_articulo').AsInteger,dm.ds_1.fieldbyname('cantidad').AsInteger)) then
          xls_1.Sheets[0].Cell[1,line].FillPatternForeColor:=xcRed;
        inc(line);

        dm.ds_1.Next;
      end;

      next;
    end;
  finally
    free;
  end;

  if exist then begin
    xls_1.Filename:=IncludeTrailingPathDelimiter(ruta_escritorio)+'ONTINYENT_NO_STOCK_'+formatdatetime('dd_mm_yyyy__hh_nn',Now)+'.xls';
    xls_1.Write;
    sMessageDlg('Fichero Sin Stock Guardado en '+xls_1.Filename,mtWarning,[mbok],0);
  end; **}
end;
{$ENDREGION}

{$REGION 'Picking'}
function genera_picking:integer;
var   pick_cab,id_articulo,id_ubicacion:integer;   nom_pick,old_order_name,filename,ubicacion_name:string;  linea:Integer;
begin
  {**ar_pick_ds.Close;
  ar_pick_ds.Active:=true;
  ar_pick_ds.EmptyDataSet;

  linea:=1;
  dm.t_write.StartTransaction;
  try
    dm.ds_1.Close;                                                            //id cabecera
    dm.ds_1.SQLs.SelectSQL.Clear;
    dm.ds_1.SQLs.SelectSQL.Add('SELECT GEN_ID(gen_a_pickcab_id,1) FROM RDB$DATABASE');
    dm.ds_1.Open;

    pick_cab:=dm.ds_1.FieldByName('gen_id').AsInteger;


    dm.q_1.Close;                                                                   //genera cabecera
    dm.q_1.SQL.Clear;
    dm.q_1.SQL.Add('insert into a_pickcab (ID_PICKCAB,ID_DOC,ID_CLIENTE,NOMBRE,FECHA,HORA,ID_USUARIO,ID_EMPRESA,ESTADO) '+
      ' values (:ID_PICKCAB,:ID_DOC,:ID_CLIENTE,:NOMBRE,:FECHA,:HORA,:ID_USUARIO,:ID_EMPRESA,:ESTADO)');
    dm.q_1.ParamByName('id_pickcab').AsInteger:=pick_cab;
    dm.q_1.ParamByName('id_doc').AsInteger:=1;
    dm.q_1.ParamByName('id_cliente').AsInteger:=2045;
    nom_pick:='Pick Caixa Ontinyent 2045-'+formatdatetime('dd/mm/yy',date);
    dm.q_1.ParamByName('nombre').asstring:=nom_pick;
    dm.q_1.ParamByName('fecha').asdate:=date;
    dm.q_1.ParamByName('hora').astime:=time;
    dm.q_1.ParamByName('id_usuario').AsInteger:=1;
    dm.q_1.ParamByName('id_empresa').AsInteger:=1;
    dm.q_1.ParamByName('estado').asstring:='A';
    dm.q_1.ExecQuery;
    dm.t_write.CommitRetaining;

    dm.ds_2.close;                                                 //recoge picking
    dm.ds_2.SelectSQL.clear;
    dm.ds_2.SelectSQL.Add('select c.id_ontinyent,l.id_articulo,a.codigo,a.nombre,sum(l.cantidad) as uds '+
      'from c_pedidos_ontinyent c '+
      'inner join c_pedidos_ontinyent_lines l on (c.id_ontinyent=l.id_ontinyent) '+
      'inner join g_Articulos a on (l.id_articulo=a.id_articulo) '+
      'where c.estado=''P'' '+
      'group by c.id_ontinyent,l.id_articulo,a.codigo,a.nombre');
    dm.ds_2.Open;

    while not(dm.ds_2.Eof) do begin           //para cada pedido
      id_articulo:=dm.ds_2.FieldByName('id_articulo').asinteger;

      dm.q_1.Close;
      dm.q_1.SQL.Clear;
      dm.q_1.SQL.Add('insert into a_picklin (ID_PICKCAB,ID_AGRUPA,NIVEL_AGR,LINEA,ID_RUTA,ID_ARTICULO,ID_UBICACION,CANTIDAD,ID_EMPRESA,ESTADO,CODALBARAN,CODMOVIMIENTO,SULINEA) '+
        ' values (:ID_PICKCAB,:ID_AGRUPA,:NIVEL_AGR,:LINEA,:ID_RUTA,:ID_ARTICULO,:ID_UBICACION,:CANTIDAD,:ID_EMPRESA,:ESTADO,:CODALBARAN,:CODMOVIMIENTO,:SULINEA)');
      dm.q_1.ParamByName('id_pickcab').AsInteger:=pick_cab;
      dm.q_1.ParamByName('id_agrupa').AsInteger:=0;
      dm.q_1.ParamByName('nivel_agr').AsInteger:=1;

      dm.q_1.ParamByName('linea').AsInteger:=linea;
      Inc(linea);
      dm.q_1.ParamByName('id_ruta').AsInteger:=0;
      dm.q_1.ParamByName('id_articulo').AsInteger:=id_articulo;

      dm.ds_1.Close;                                                            //ubicacion de picking
      dm.ds_1.SQLs.SelectSQL.Clear;
      dm.ds_1.SQLs.SelectSQL.Add('SELECT u.id_ubicacion,u.id_estanteria,u.id_posicion,u.id_altura,u.id_sub1,u.id_sub2 '+
        ' from a_stock s '+
        '   inner join a_ubicaciones u on (s.id_ubicacion=u.id_ubicacion) '+
        ' where s.id_articulo='+inttostr(id_articulo)+' and s.cantidad>0 and u.id_zona=0 and s.id_ubicacion<>361 and s.id_empresa=1 and s.id_almacen=1 '+
        ' order by 4,2,3');
      dm.ds_1.Open;

      id_ubicacion:=dm.ds_1.FieldByName('id_ubicacion').asinteger;
      ubicacion_name:=dm.ds_1.FieldByName('id_estanteria').asstring+'-'+dm.ds_1.FieldByName('id_posicion').asstring+'-'+dm.ds_1.FieldByName('id_altura').asstring
        +'-'+dm.ds_1.FieldByName('id_sub1').asstring;
      dm.q_1.ParamByName('id_ubicacion').AsInteger:=id_ubicacion;
      dm.q_1.ParamByName('cantidad').AsInteger:=dm.ds_2.FieldByName('uds').asinteger;
      dm.q_1.ParamByName('id_empresa').AsInteger:=1;
      dm.q_1.ParamByName('estado').asstring:='A';
      dm.q_1.ParamByName('codalbaran').AsInteger:=0;
      dm.q_1.ParamByName('codmovimiento').AsInteger:=0;
      dm.q_1.ParamByName('sulinea').AsString:='';
      dm.q_1.ExecQuery;



      ar_pick_ds.insert;
      ar_pick_ds.FieldByName('id_art').AsInteger:=id_articulo;
      ar_pick_ds.FieldByName('ref_art').AsString:=dm.ds_2.FieldByName('codigo').AsString;
      ar_pick_ds.FieldByName('uds').Asinteger:=dm.ds_2.FieldByName('uds').asinteger;
      ar_pick_ds.FieldByName('id_ubic').Asinteger:=id_ubicacion;
      ar_pick_ds.FieldByName('ubicacion').Asstring:=ubicacion_name;
      ar_pick_ds.FieldByName('articulo').Asstring:=dm.ds_2.FieldByName('nombre').AsString;

      dm.ds_1.Close;                                                            //datos de cabecera (es una burrada hacerlo por linea)
      dm.ds_1.SQLs.SelectSQL.Clear;
      dm.ds_1.SQLs.SelectSQL.Add('SELECT * '+
        ' from c_pedidos_ontinyent '+
        ' where id_ontinyent=:id_ontinyent');
      dm.ds_1.ParamByName('id_ontinyent').AsInteger:=dm.ds_2.FieldByName('id_ontinyent').asinteger;
      dm.ds_1.Open;

      ar_pick_ds.FieldByName('pedido').asstring:=dm.ds_1.FieldByName('id_order').asstring;
      ar_pick_ds.FieldByName('nomape').asstring:=dm.ds_1.FieldByName('nombre').asstring;
      ar_pick_ds.FieldByName('direccion').asstring:=dm.ds_1.FieldByName('dir').asstring;
      ar_pick_ds.FieldByName('poblacion').asstring:=dm.ds_1.FieldByName('poblacion').asstring;
      ar_pick_ds.FieldByName('provincia').asstring:=dm.ds_1.FieldByName('provincia').asstring;
      ar_pick_ds.FieldByName('cp').asstring:=dm.ds_1.FieldByName('cp').asstring;
      ar_pick_ds.FieldByName('oficina').AsInteger:=dm.ds_1.FieldByName('oficina').AsInteger;
      ar_pick_ds.FieldByName('entidad').AsInteger:=dm.ds_1.FieldByName('entidad').AsInteger;

      ar_pick_ds.Post;

      dm.ds_2.Next;
    end;
    dm.t_write.Commit;
  except
    dm.t_write.Rollback;
  end;

  lb_st1.Caption:='Picking Generado '+inttostr(pick_cab);
  application.ProcessMessages;

  if rep_pick.PrepareReport(True) then rep_pick.ShowPreparedReport;

  result:=pick_cab;    **}
end;
{$ENDREGION}

{$REGION 'Packing'}
procedure packing;
begin
  {** dm.q_pack.Open;
  dm.q_pack_lines.Open;
  f_packing.ShowModal;
  dm.q_pack.close;
  dm.q_pack_lines.close; **}
end;
{$ENDREGION}

end.
