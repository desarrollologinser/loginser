unit u_llaves;

interface

uses
  System.SysUtils, System.Variants, System.Classes, System.Math,
  Vcl.Controls, Vcl.Forms, system.Types,
  Vcl.StdCtrls, sComboBox, Vcl.Buttons, sBitBtn, sEdit, sGroupBox,
  system.AnsiStrings, sLabel,StrUtils, IdHTTP,
  sSpeedButton, IdMultipartFormData,
  NxGrid6,pFIBDataSet, system.json,
  Data.DB, Winapi.ShellAPI, Winapi.Windows, pFIBQuery,
  Datasnap.DBClient, frxClass, frxDBSet,  NxColumns6,
  NxCustomGrid6, Vcl.Mask, sMaskEdit, sCustomComboEdit,sdialogs,dialogs,
  Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, sMemo, sToolEdit, sButton,
  acPNG, Vcl.ExtCtrls, sCheckBox, NxGridView6, NxControls6,
  NxVirtualGrid6, dxGDIPlusClasses, Vcl.DBCtrls, JvDBControls, sDBEdit,
  Vcl.Clipbrd, sSpinEdit, Vcl.ComCtrls, Vcl.Graphics,
  frxChBox, acImage;

type
  Tf_llaves = class(TForm)
    cdsLines: TClientDataSet;
    cdsLineslinea: TIntegerField;
    cdsLinesid_articulo: TIntegerField;
    cdsLinesreferencia: TStringField;
    cdsLinessku: TStringField;
    cdsLinesnombre: TStringField;
    cdsLinescantidad: TIntegerField;
    cdsLineskgs: TFloatField;
    cdsLinesimei: TStringField;
    dslines: TDataSource;
    sGroupBox4: TsGroupBox;
    bt_guardar: TsBitBtn;
    cb_estado: TsComboBox;
    ed_id_pedido: TsEdit;
    ed_nombre: TsEdit;
    de_fecha_ped: TsDateEdit;
    btFinPedido: TsBitBtn;
    ed_obs: TsMemo;
    bt1: TsButton;
    edCeco: TsEdit;
    edRefCliente: TsEdit;
    edHora: TsEdit;
    de_fecha_gen: TsDateEdit;
    de_fecha_env: TsDateEdit;
    sGroupBox1: TsGroupBox;
    bt_delete: TsBitBtn;
    bt_new: TsBitBtn;
    gbLine: TsGroupBox;
    lb_id_line: TsLabel;
    sLabel2: TsLabel;
    bt_save_line: TsBitBtn;
    ed_cantidad: TsEdit;
    sGroupBox3: TsGroupBox;
    lb_sku: TsLabel;
    lb_nombre_art: TsLabel;
    lb_id_art: TsLabel;
    sLabel6: TsLabel;
    sLabel7: TsLabel;
    sLabel8: TsLabel;
    sLabel9: TsLabel;
    lb_ref_art: TsLabel;
    sLabel11: TsLabel;
    lbkgs: TsLabel;
    sSpeedButton1: TsSpeedButton;
    btCancelLine: TsBitBtn;
    grLines: TJvDBGrid;
    mmLog: TMemo;
    procedure FormShow(Sender: TObject);
    procedure bt_guardarClick(Sender: TObject);
    procedure bt__as_art_entraClick(Sender: TObject);
    procedure bt_save_lineClick(Sender: TObject);
    procedure bt_deleteClick(Sender: TObject);
    procedure read_lines;
    procedure bt_newClick(Sender: TObject);
    procedure save_exp;
    procedure get_line_data;
    function guarda_line:integer;
    procedure btFinPedidoClick(Sender: TObject);
    procedure bt1Click(Sender: TObject);
    procedure btIMEIClick(Sender: TObject);
    procedure grLinesCellClick(Column: TColumn);
    procedure btCancelLineClick(Sender: TObject);
    procedure grLinesDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lb_11Click(Sender: TObject);
    procedure sSpeedButton1Click(Sender: TObject);
  private
    function check_nserie(nserie:string; nline:integer):Boolean;
    procedure empty_data_lines;
    procedure habilitar_botones_detalle(estado:Boolean);

  public
    { Public declarations }
    function suma_cantidad_art_en_pedido(id_pedido,id_articulo:integer):integer;
  end;

const
  http_estado = '';

var
  f_llaves: Tf_llaves;
  mode:integer;              //0 = modo edicion    1 = modo nueva     2 = modo reexp
  max_line:integer;
  id_agencia_en_gestoras: integer;

implementation

uses
  u_dm, u_main, ubuscapro, u_orders, u_globals, u_correos, USendText, u_gen_gl,
  u_globals_gestoras,UDMCreaBultos, u_LstEtiquetas, u_cam_gl,
  u_UpdatePedido, u_AlbaranValidate;

{$R *.dfm}

{$REGION 'Ini-Close'}
procedure Tf_llaves.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure Tf_llaves.FormShow(Sender: TObject);
var
  i:Integer;
  serv_hora:TStringDynArray;
begin

  if mode=0 then begin                                         //modo edicion
    ed_id_pedido.Text:=dm.q_peds.fieldbyname('id_pedido').asstring;
    ed_nombre.Text:=dm.q_peds.fieldbyname('nombre').asstring;
    de_fecha_ped.Date:=dm.q_peds.FieldByName('fecha_ped').AsDateTime;
    edHora.Text := FormatDateTime('hh:nn',dm.q_peds.FieldByName('fecha_ped').AsDateTime);
    ed_obs.Text:=dm.q_peds.fieldbyname('observaciones').asstring;

    case indexstr(dm.q_peds.fieldbyname('estado').asstring,['P','E','A']) of
      0:cb_estado.ItemIndex:=0;
      1:cb_estado.ItemIndex:=1;
      2:cb_estado.ItemIndex:=2;
    end;


    read_lines;

    if cdsLines.RecordCount>0 then
    begin
       //ng_lines.SelectCell(0,0);
       //ng_linesCellClick(f_detail,0,1);
       //empty_data_lines;
       cdslines.Locate('linea',1,[]);
    end;


    edCeco.Text := dm.q_peds.fieldbyname('ceco').asstring;
    edRefCliente.Text := dm.q_peds.fieldbyname('ref_cliente').asstring;

    de_fecha_gen.Date:=dm.q_peds.FieldByName('fecha_gen').AsDateTime;
    de_fecha_env.Date:=dm.q_peds.FieldByName('fecha_fin').AsDateTime;

  end;

  if mode=1 then begin                                         //modo nuevo


    ed_id_pedido.Text:='0';
    ed_nombre.Text:='';
    de_fecha_ped.Date:=date;
    cb_estado.ItemIndex:=0;
    ed_obs.Text:='';

    max_line:=0;
    //ng_lines.ClearRows;

    cdsLines.EmptyDataSet;

    edCeco.Text := '';
    edRefCliente.Text := '';

    gbLine.Visible := True;
    habilitar_botones_detalle(true);

    de_fecha_gen.Text := '  /  /    ';
    de_fecha_env.Text := '  /  /    ';

    edRefCliente.SetFocus;

  end;

  if mode=2 then begin                                         //modo reexpedicion
    ed_id_pedido.Text:='0';
    ed_nombre.Text:=dm.q_peds.fieldbyname('nombre').asstring;
    ed_obs.Text:=dm.q_peds.fieldbyname('observaciones').asstring;
    edCeco.Text := dm.q_peds.fieldbyname('ceco').asstring;
    edRefCliente.Text := dm.q_peds.fieldbyname('ref_cliente').asstring;

    de_fecha_ped.Date:=date;

    cb_estado.ItemIndex:=0;

    read_lines;

    id_agencia_en_gestoras := GetRelacionAgencia(dm.q_peds.fieldbyname('id_repartidor').asinteger);

    de_fecha_gen.Text := '  /  /    ';
    de_fecha_env.Text := '  /  /    ';

    edRefCliente.SetFocus;
  end;

  if not (mode=0) then
  begin
    empty_data_lines;

    id_agencia_en_gestoras := -1;

    edRefCliente.SetFocus;
  end;

end;


{$ENDREGION}


{$REGION 'Process'}
{procedure Tf_llaves.save_exp;
var
    id_pedido,i, new_ped:integer;

begin

  if mode=0 then begin                                  //modo edicion

    dmupdatePedido.updatepedido(1,dm.q_peds.FieldByName('id_pedido').asinteger);

    f_main.filter;
    dm.q_peds.Locate('id_pedido',VarArrayOf([id_pedido]),[]);
  end;

  if ((mode=1) or (mode=2)) then begin                                  //modo new/reexpedicion

    new_ped := StrToInt(dmupdatePedido.updatepedido(0,0));

    f_main.filter;
    dm.q_peds.Locate('id_pedido',VarArrayOf([new_ped]),[]);
  end;

  
end;  }

procedure Tf_llaves.save_exp;
var
  id_pedido,i,line:integer;
begin

  if mode=0 then begin                                  //modo edicion

    id_pedido:=StrToInt(ed_id_pedido.Text);

    dm.t_write.StartTransaction;
    try
      dm.q_1.Close;
      dm.q_1.sql.Clear;
      dm.q_1.sql.Add('update c_pedidos set nombre=:nombre, ref_cliente=:ref_cliente, ceco=:ceco, ' +
        'fecha_ped=:fecha_ped, estado=:estado, codalbaran=:codalbaran, ' +
        'observaciones=:observaciones where id_pedido=:id_pedido');
      dm.q_1.ParamByName('id_pedido').AsInteger    := id_pedido;
      dm.q_1.ParamByName('nombre').asstring        := ed_nombre.Text;
      dm.q_1.ParamByName('ref_cliente').asstring   := edRefCliente.Text;
      dm.q_1.ParamByName('ceco').asstring          := edCeco.Text;
      dm.q_1.ParamByName('fecha_ped').asdate       := de_fecha_ped.Date;
      dm.q_1.ParamByName('estado').AsString        := cb_estado.Text[1];
      dm.q_1.ParamByName('observaciones').asstring := ed_obs.Text;

      dm.q_1.ExecQuery;

      dm.q_1.Close;
      dm.q_1.sql.Clear;
      dm.q_1.sql.Add('delete from c_pedidos_lines where id_pedido=:id_pedido');
      dm.q_1.ParamByName('id_pedido').AsInteger:=id_pedido;
      dm.q_1.ExecQuery;

      for i:=0 to cdsLines.RecordCount-1 do begin
        dm.q_1.Close;
        dm.q_1.sql.Clear;
        dm.q_1.sql.Add('insert into c_pedidos_lines (id_pedido,id_line,id_articulo,cantidad,sku,nombre_art, imei, kgs) '+
          'values (:id_pedido,:id_line,:id_articulo,:cantidad,:sku,:nombre_art, :imei, :kgs)');
        dm.q_1.ParamByName('id_pedido').AsInteger:=id_pedido;
        dm.q_1.ParamByName('id_line').AsInteger     := cdsLines.FieldByName('linea').AsInteger;
        dm.q_1.ParamByName('id_articulo').asinteger := cdsLines.FieldByName('id_articulo').AsInteger;
        dm.q_1.ParamByName('cantidad').asinteger    := cdsLines.FieldByName('cantidad').AsInteger;
        dm.q_1.ParamByName('sku').asstring          := cdsLines.FieldByName('sku').AsString;
        dm.q_1.ParamByName('nombre_art').asstring   := cdsLines.FieldByName('nombre').AsString;
        dm.q_1.ParamByName('imei').asstring         := cdsLines.FieldByName('imei').AsString;
        dm.q_1.ParamByName('kgs').asfloat           := cdsLines.FieldByName('kgs').AsFloat;

        dm.q_1.ExecQuery;

        cdsLines.Next;
      end;

      dm.t_write.CommitRetaining;

      ShowMessage('Pedido guardado correctamente.');
    except
      dm.t_write.rollback;

      ShowMessage('Error al guardar pedido.');
    end;

    f_main.filter(modo_historico);
    dm.q_peds.Locate('id_pedido',VarArrayOf([id_pedido]),[]);
  end;

  if ((mode=1) or (mode=2)) then begin                                  //modo new/reexpedicion
    with tpfibdataset.Create(dm) do begin
      database:=dm.db;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('SELECT GEN_ID(GEN_C_PEDIDOS_ID, 1) from RDB$DATABASE');
      Open;

      id_pedido:=FieldByName('gen_id').AsInteger;

      Free;
    end;

    dm.t_write.StartTransaction;
    try
      dm.q_1.Close;
      dm.q_1.sql.Clear;
      dm.q_1.sql.Add('insert into c_pedidos (id_pedido, id_cliente, id_order,order_name,nombre,fecha_ped,estado,observaciones,id_almacen,ref_cliente,ceco) values '+
        '(:id_pedido,:id_cliente,:id_order,:order_name,:nombre,:fecha_ped,:estado,:observaciones,:id_almacen,:ref,:ceco)');
      dm.q_1.ParamByName('id_pedido').AsInteger   := id_pedido;
      dm.q_1.ParamByName('id_order').AsString     := IntToStr(id_pedido);
      dm.q_1.ParamByName('id_cliente').AsInteger  := u_main.main_cli;
      dm.q_1.ParamByName('order_name').asstring   := IntToStr(id_pedido);
      dm.q_1.ParamByName('nombre').asstring       := ed_nombre.Text;
      dm.q_1.ParamByName('fecha_ped').asdate      := Now;
      dm.q_1.ParamByName('estado').AsString       := cb_estado.Text[1];
      dm.q_1.ParamByName('id_almacen').AsInteger := id_almacen;
      dm.q_1.ParamByName('ref').AsString       := edRefCliente.Text;
      dm.q_1.ParamByName('ceco').AsString       := edCeco.Text;

      dm.q_1.ExecQuery;

      cdsLines.First;

      dm.q_1.Close;
      dm.q_1.sql.Clear;
      dm.q_1.sql.Add('insert into c_pedidos_lines (id_pedido,id_line,id_articulo,cantidad,sku,nombre_art,imei,kgs) '+
          'values (:id_pedido,:id_line,:id_articulo,:cantidad,:sku,:nombre_art, :imei,:kgs)');

      for i:=0 to cdsLines.RecordCount-1 do begin

        dm.q_1.ParamByName('id_pedido').AsInteger:=id_pedido;
        dm.q_1.ParamByName('id_line').AsInteger     := cdsLines.FieldByName('linea').AsInteger;
        dm.q_1.ParamByName('id_articulo').asinteger := cdsLines.FieldByName('id_articulo').AsInteger;
        dm.q_1.ParamByName('cantidad').asinteger    := cdsLines.FieldByName('cantidad').AsInteger;
        dm.q_1.ParamByName('sku').asstring          := cdsLines.FieldByName('sku').AsString;
        dm.q_1.ParamByName('nombre_art').asstring   := cdsLines.FieldByName('nombre').AsString;
        dm.q_1.ParamByName('imei').asstring         := '';
        dm.q_1.ParamByName('kgs').asfloat           := cdsLines.FieldByName('kgs').AsFloat;

        dm.q_1.ExecQuery;
        cdsLines.Next;
      end;

      dm.t_write.Commit;

      ShowMessage('Pedido guardado correctamente.');

    except

      dm.t_write.rollback;
      ShowMessage('Error al guardar pedido.');
    end;

    f_main.filter(u_main.modo_historico);
    dm.q_peds.Locate('id_pedido',VarArrayOf([id_pedido]),[]);
  end;

end;


procedure Tf_llaves.sSpeedButton1Click(Sender: TObject);
begin
  with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;   row_height:=40;
    fields.commatext:='id_articulo,codigo,nombre, codigo_cli, kgs';
    titulos.commatext:='Id_Articulo,Referencia,Nombre,SKU, Kilos';
    from:='g_articulos ';

    where:=' id_cliente=' + IntToStr(u_main.main_cli) +  ' and estado=''A''';
    orden[1]:=4;   orden_ini:=0;  group:='';
    busca:=4;   distinct:=0;   fillimpio:=True;    row_height:=17;

    showmodal;

    if resultado then begin
      lb_sku.Caption := valor[4];
      lb_id_art.Caption := valor[1];
      lb_nombre_art.Caption := valor[3];
      lb_ref_art.Caption := valor[2];
      lbKgs.caption:=valor[5];
    end;
  end;
end;

procedure Tf_llaves.bt1Click(Sender: TObject);
begin
  //EnviarIMEIaWeb;
  //SendEstado('2755','391151','F');
  save_exp;
end;


{$ENDREGION}

{$REGION 'Lines'}
procedure Tf_llaves.read_lines;
begin
    dm.q_peds_lines.Open;
    max_line:=0;

   cdsLines.EmptyDataSet;

    dm.q_peds_lines.First;
    while not(dm.q_peds_lines.Eof) do begin

      if dm.q_peds_lines.FieldByName('id_line').AsInteger>max_line then
        max_line:=dm.q_peds_lines.FieldByName('id_line').AsInteger;

      cdsLines.Insert;
      cdsLines.FieldByName('linea').AsInteger := dm.q_peds_lines.FieldByName('id_line').AsInteger;
      cdsLines.FieldByName('id_articulo').AsInteger := dm.q_peds_lines.FieldByName('id_articulo').AsInteger;
      cdsLines.FieldByName('referencia').AsString := dm.q_peds_lines.FieldByName('codigo').AsString;
      cdsLines.FieldByName('sku').AsString := dm.q_peds_lines.FieldByName('codigo_cli').AsString;
      cdsLines.FieldByName('nombre').AsString := dm.q_peds_lines.FieldByName('nombre').AsString;
      cdsLines.FieldByName('cantidad').AsInteger := dm.q_peds_lines.FieldByName('cantidad').AsInteger;
      cdsLines.FieldByName('kgs').AsFloat := RoundTo(StrToFloat(dm.q_peds_lines.FieldByName('kgs').asstring),-2);
      cdsLines.FieldByName('imei').AsString := dm.q_peds_lines.FieldByName('imei').AsString;
      cdsLines.Post;

      dm.q_peds_lines.Next;
    end;
    dm.q_peds_lines.close;
    //ng_lines.endupdate;
end;


procedure Tf_llaves.bt_newClick(Sender: TObject);
begin
  gbLine.Visible := True;  //(mode=1);

  inc(max_line);
  lb_id_line.Caption:=IntToStr(max_line);
  lb_sku.caption:='';
  lb_id_art.caption:='';
  lb_nombre_art.caption:='';
  ed_cantidad.text:='1';
  lb_ref_art.caption:='';

  bt_save_line.Enabled := True;
  btCancelLine.Enabled := True;
  bt_delete.Enabled := False;
end;

procedure Tf_llaves.btCancelLineClick(Sender: TObject);
begin
  cdsLines.Locate('linea',1,[]);
  get_line_data;

  bt_delete.Enabled := False;
end;


procedure Tf_llaves.btFinPedidoClick(Sender: TObject);
begin
    dm.t_write.StartTransaction;
    try
      dm.q_1.Close;
      dm.q_1.sql.Clear;
      dm.q_1.sql.Add('update c_pedidos set estado=:estado where id_pedido=:id_pedido');
      dm.q_1.ParamByName('estado').asstring:='E';
      dm.q_1.ParamByName('id_pedido').asinteger:=StrToInt(ed_id_pedido.Text);
      dm.q_1.ExecQuery;
      dm.t_write.Commit;
    except
      dm.t_write.rollback;
    end;
end;

procedure Tf_llaves.btIMEIClick(Sender: TObject);
begin
    dm.t_write.StartTransaction;
    try
      with TpFIBQuery.Create(dm) do
      try
        database:=dm.db;
        Transaction:=dm.t_write;
        sql.add('update g_articulos set tiene_imei=:tiene_imei where id_articulo=:id_articulo');
        ParamByName('id_articulo').AsInteger:=StrToInt(lb_id_art.caption);
        ParamByName('tiene_imei').asinteger:=1;

        ExecQuery;
      finally
        free;
      end;
    except
      dm.t_write.Rollback;
      raise exception.Create('Error Actualizando');
    end;
    dm.t_write.Commit;

end;



procedure Tf_llaves.bt_deleteClick(Sender: TObject);
var i:Integer;
begin
  bt_save_line.Enabled := False;
  btCancelLine.Enabled := False;

  cdsLines.Delete;
  cdsLines.Locate('linea',1,[]);
  grLinesCellClick(grLines.columns[0]);

end;

procedure Tf_llaves.bt__as_art_entraClick(Sender: TObject);
begin
  with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;   row_height:=40;
    fields.commatext:='id_articulo,codigo,nombre, codigo_cli, kgs';
    titulos.commatext:='Id_Articulo,Referencia,Nombre,SKU, Kilos';
    from:='g_articulos ';

    where:=' id_cliente=' + IntToStr(u_main.main_cli) +  ' and estado=''A''';
    orden[1]:=4;   orden_ini:=0;  group:='';
    busca:=4;   distinct:=0;   fillimpio:=True;    row_height:=17;

    showmodal;

    if resultado then begin
      lb_sku.Caption := valor[4];
      lb_id_art.Caption := valor[1];
      lb_nombre_art.Caption := valor[3];
      lb_ref_art.Caption := valor[2];
      lbKgs.caption:=valor[5];
    end;
  end;
end;


procedure Tf_llaves.get_line_data;
begin

  lb_sku.caption := cdsLines.FieldByName('sku').AsString;
  lb_id_art.Caption := cdsLines.FieldByName('id_articulo').AsString;
  lb_nombre_art.Caption := cdsLines.FieldByName('nombre').AsString;
  ed_cantidad.text := cdsLines.FieldByName('cantidad').AsString;
  lb_id_line.caption := cdsLines.FieldByName('linea').AsString;
  lb_ref_art.Caption := cdsLines.FieldByName('referencia').AsString;
  lbKgs.Caption := cdsLines.FieldByName('kgs').AsString;

  bt_save_line.Enabled:=true;
  ed_cantidad.SetFocus;
end;

procedure Tf_llaves.bt_save_lineClick(Sender: TObject);
var
  linea: Integer;
begin
  cdsLines.DisableControls;
  linea := StrToInt(lb_id_line.Caption);
  guarda_line;
  cdsLines.Locate('linea',linea,[]);
  cdsLines.EnableControls;

  bt_delete.Enabled := True;
end;

function Tf_llaves.guarda_line:integer;
var
    kgs: Double;
    enc: Boolean;
begin

  bt_save_line.Enabled := False;
  btCancelLine.Enabled := False;

  enc := False;

  cdsLines.First;

  while (not enc) and (not cdsLines.Eof) do
  begin
     if cdsLines.FieldByName('linea').AsString=lb_id_line.Caption then
     begin
       cdsLines.Edit;
       enc := True;
     end;
     if not enc then
           cdsLines.Next;
  end;
                                                                   //new line
  if not enc then
  begin
    cdsLines.Insert;
    cdsLines.FieldByName('linea').AsInteger := StrToInt(lb_id_line.caption);
  end;

  cdsLines.FieldByName('id_articulo').AsInteger := StrToInt(lb_id_art.caption);
  cdsLines.FieldByName('referencia').AsString   := lb_ref_art.caption;
  cdsLines.FieldByName('sku').AsString          := lb_sku.caption;
  cdsLines.FieldByName('nombre').AsString       := lb_nombre_art.caption;
  cdsLines.FieldByName('cantidad').AsInteger    := StrToInt(ed_cantidad.text);
  cdsLines.FieldByName('kgs').AsFloat           := RoundTo(StrToFloat(lbKgs.Caption),-2);
  cdsLines.FieldByName('imei').AsString         := '';
  cdsLines.Post;

  result := cdsLines.RecordCount;

  bt_save_line.Enabled := True;
  btCancelLine.Enabled := True;
end;


{$ENDREGION}

{$REGION 'Interfaz'}

procedure Tf_llaves.bt_guardarClick(Sender: TObject);
begin
  If edRefCliente.Text='' then
  begin
    ShowMessage('Por favor, introduzca una referencia válida.');
    Exit;
  end;

  If edCeco.Text='' then
  begin
    ShowMessage('Por favor, introduzca un CECO válido.');
    Exit;
  end;

  If ed_nombre.Text='' then
  begin
    ShowMessage('Por favor, introduzca el nombre del destinatario.');
    Exit;
  end;

  save_exp;
  close;
end;

procedure Tf_llaves.habilitar_botones_detalle(estado:Boolean);
begin
  //bt_guardar.enabled := estado;
  bt_new.enabled := estado;
  bt_delete.enabled := estado;
  bt_save_line.enabled := estado;
  btCancelLine.enabled := estado;
end;
procedure Tf_llaves.lb_11Click(Sender: TObject);
begin

end;

{$ENDREGION 'Interfaz'}

function Tf_llaves.check_nserie(nserie:string; nline:integer):Boolean;                  //true=ok false=error or repeated
var
  i:Integer;
  enc: Boolean;
begin
  enc := False;

  cdsLines.First;
  while (not enc) and (not cdsLines.eof) do
  begin
    if ((i<>nline) and (cdsLines.FieldByName('imei').AsString=nserie)) then begin
      result:=false;
      enc := True;
    end;
  end;

  Result:=true;
end;


procedure Tf_llaves.grLinesCellClick(Column: TColumn);
begin
  gbLine.Visible := not (cdsLines.IsEmpty);
  get_line_data;
end;

procedure Tf_llaves.grLinesDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (Column.FieldName='referencia') and (dm.q_peds.FieldByName('estado').AsString = 'X') then
  begin
     If (f_main.get_stock_x_art(Column.Field.DataSet.FieldByName('id_articulo').AsInteger)<f_main.get_total_x_art_y_ped(Column.Field.DataSet.FieldByName('id_articulo').AsInteger,dm.q_peds.FieldByName('id_pedido').AsInteger)) then
         (Sender as TDBGrid).canvas.Font.Color := clRed
     else
         (Sender as TDBGrid).canvas.Font.Color := clBlack;
  end else
         (Sender as TDBGrid).canvas.Font.Color := clBlack;

     grLines.DefaultDrawColumnCell(Rect,DataCol,Column,State);

end;



procedure Tf_llaves.empty_data_lines;
begin
  lb_sku.caption := '';
  lb_id_art.Caption := '';
  lb_nombre_art.Caption := '';
  ed_cantidad.text := '';
  lb_id_line.caption := '';
  lb_ref_art.caption := '';
  lbKgs.Caption := '';
end;

function Tf_llaves.suma_cantidad_art_en_pedido(id_pedido,id_articulo: integer):integer;
begin
    result  := -1;
    with TpFIBDataSet.Create(nil) do
    try
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select sum(cantidad) as uds from c_pedidos_lines_lotes ' +
                         ' where id_pedido=:id_pedido and id_articulo=:id_articulo');
      ParamByName('id_pedido').AsInteger := id_pedido;
      ParamByName('id_articulo').AsInteger := id_articulo;
      Open;

      if not isempty then
          result := FieldByName('uds').asinteger;

    finally
      free;
    end;
end;

end.
