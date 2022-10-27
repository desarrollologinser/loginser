unit u_main_old;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, JvExDBGrids,
  JvDBGrid, Vcl.StdCtrls, sButton, sEdit, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  acImage, sLabel, Vcl.Buttons, sSpeedButton, sPanel, sCheckBox, Vcl.Mask,
  sMaskEdit, sCustomComboEdit, sToolEdit, sRadioButton, sGroupBox, pFIBDataSet,
  Vcl.ImgList, sSkinManager, sSkinProvider, NxScrollControl,
  NxCustomGridControl, NxCustomGrid, NxGrid, NxColumnClasses, NxColumns,
  sSpinEdit, XLSSheetData5, XLSReadWriteII5, Xc12DataStyleSheet5, XLSFormattedObj5,
  frxClass, Data.DB, Datasnap.DBClient, frxDBSet, System.ImageList;

type
  Tf_main_old = class(TForm)
    pnCliente: TsPanel;
    btCliente: TsSpeedButton;
    lbCliente: TsLabel;
    btLock: TsSpeedButton;
    sImage1: TsImage;
    edCliente: TsEdit;
    bt2: TsButton;
    pnFiltro: TsPanel;
    rgProducto: TsRadioGroup;
    il1: TImageList;
    sknprvdr1: TsSkinProvider;
    sknmngr1: TsSkinManager;
    edFecha: TsDateEdit;
    edCeco: TsEdit;
    bpCeco: TsSpeedButton;
    lbCeco: TsLabel;
    edIdCliente: TsSpinEdit;
    edIdCeco: TsSpinEdit;
    gbInformes: TsGroupBox;
    edFDesde: TsDateEdit;
    edFHasta: TsDateEdit;
    btXls: TsSpeedButton;
    btReport: TsSpeedButton;
    xls: TXLSReadWriteII5;
    rgCliente: TsRadioGroup;
    rgCeco: TsRadioGroup;
    edXls: TsDirectoryEdit;
    rgTipo: TsRadioGroup;
    repResumen: TfrxReport;
    rep_db_resumen: TfrxDBDataset;
    ar_resumen: TClientDataSet;
    intgrfld_resumenid_cliente: TIntegerField;
    strngfld_resumennombre: TStringField;
    strngfld_resumenfecha_desde: TStringField;
    strngfld_resumenfecha_hasta: TStringField;
    intgrfld_resumenuds_local: TIntegerField;
    intgrfld_resumenuds_d1: TIntegerField;
    intgrfld_resumenuds_d2: TIntegerField;
    intgrfld_resumenuds_int_eur: TIntegerField;
    intgrfld_resumenuds_int_resto: TIntegerField;
    fltfld_resumenimp_local: TFloatField;
    fltfld_resumenimp_d1: TFloatField;
    fltfld_resumenimp_d2: TFloatField;
    fltfld_resumenimp_int_eur: TFloatField;
    fltfld_resumenimp_int_resto: TFloatField;
    pnBts: TsPanel;
    btAdd: TsSpeedButton;
    btUpdate: TsSpeedButton;
    bt1: TsSpeedButton;
    btGuardar: TsSpeedButton;
    btLimpiar: TsSpeedButton;
    grData: TStringGrid;
    btCancel: TsSpeedButton;
    lbModo: TsLabel;
    btConsulta: TsSpeedButton;
    lbTotal: TsLabel;
    lbTCliente: TsLabel;
    lb2: TsLabel;
    lb3: TsLabel;
    bt3: TsSpeedButton;
    procedure btClienteClick(Sender: TObject);
    procedure edClienteChange(Sender: TObject);
    procedure btLockClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bpCecoClick(Sender: TObject);
    procedure edCecoChange(Sender: TObject);
    procedure btGuardarClick(Sender: TObject);
    procedure btLimpiarClick(Sender: TObject);
    procedure btXlsClick(Sender: TObject);
    procedure rgClienteChange(Sender: TObject);
    procedure btReportClick(Sender: TObject);
    procedure btAddClick(Sender: TObject);
    procedure btUpdateClick(Sender: TObject);
    procedure btConsultaClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure rgProductoChange(Sender: TObject);
    procedure edFechaClick(Sender: TObject);
    procedure edFechaChange(Sender: TObject);
  private
    { Private declarations }
    function BuscaCliente(codigo:string):string;
    function BuscaClientePorId(id:integer):string;
    function BuscaClienteId(codigo:string):Integer;
    function BuscaCeco(codigo:string):string;
    function BuscaCecoPorId(id:Integer):string;
    function BuscaCecoId(codigo:string):Integer;
    procedure filter;
    procedure CargaInterfaz;
    procedure ReportDetalle;
    procedure ReportResumen;
    procedure XLSResumen;
    procedure XLSBonificacion;
    procedure XLSDetalle;
    procedure RellenaCabeceras(fila:Integer);
    procedure RellenaCabecerasResumen(fila:Integer);
    procedure RellenaCabecerasBonificacion(fila:Integer);
    function BuscaFranqueoPorFechas(cliente, ceco, peso, producto, zona:integer; f1,f2:TDateTime; out importe:Double):Integer;
    function BuscaFranqueo(cliente, ceco, peso, producto, zona:integer; fecha:TDateTime):Integer;
    function BuscaTarifa(cliente, ceco, peso, producto, zona:integer):Double;
    procedure HabilitaDatos(habilitar:Boolean);
    function GetTotalCliente(cliente:Integer; out uds:integer):Double;
  public
    { Public declarations }
  end;

var
  f_main_old: Tf_main_old;
  locked:Boolean=False;
  modo: Integer=0; //0-consulta 1-edición 2-inserción


implementation

uses
  ubuscapro, u_dm;

{$R *.dfm}

procedure Tf_main_old.bpCecoClick(Sender: TObject);
begin
   with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='c.codigo,c.nombre,c.id_cliente_ceco';
    titulos.commatext:='Código,Nombre, Id';
    from:='g_clientes_cecos c ';
    where:='estado=''A'' and c.id_cliente=' + edIdCliente.Text;
    orden[1]:=1;  busca:=2;   distinct:=0;   fillimpio:=True;   row_height:=17;

    showmodal;

    if resultado then begin
      with Sender as TsSpeedButton do begin
        edCeco.text:=valor[1];
        lbCeco.caption:=valor[2];
        edIdCeco.Text := valor[3];
        filter;
      end;
    end;
  end;

end;

procedure Tf_main_old.btLimpiarClick(Sender: TObject);
var
  x, y: integer;
begin
  lbtotal.Caption := '';

  for x := 1 to grData.RowCount-1 do
    for y := 1 to grData.ColCount-1 do
    begin
        grData.Cells[y,x] := '';
    end;

    grData.Cells[1,1];

end;



procedure Tf_main_old.btReportClick(Sender: TObject);
begin
    case rgTipo.ItemIndex of
       0: ReportResumen;
       2: ReportDetalle;
    end;
end;

procedure Tf_main_old.btUpdateClick(Sender: TObject);
begin
  HabilitaDatos(true);
  btAdd.Visible := False;
  btUpdate.Enabled := False;
  btLimpiar.Enabled := False;
  lbModo.Caption := 'Modo Edición';

  modo := 1;
end;

procedure Tf_main_old.btConsultaClick(Sender: TObject);
begin
  modo := 0;
  HabilitaDatos(false);
  btAdd.Visible := True;
  btUpdate.Visible := True;
  btAdd.Enabled := True;
  btUpdate.Enabled := True;
  lbModo.Caption := 'Modo Consulta';

  filter;
end;

procedure Tf_main_old.btAddClick(Sender: TObject);
begin
  HabilitaDatos(true);
  btUpdate.Visible := False;
  btAdd.Enabled := False;
  lbModo.Caption := 'Modo Inserción';

  btLimpiarClick(Self);

  modo := 2;
end;

procedure Tf_main_old.btCancelClick(Sender: TObject);
begin
  //HabilitaDatos(false);
  filter;
end;

procedure Tf_main_old.btClienteClick(Sender: TObject);
begin
   with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='cl.codigo,cl.nombre,cl.id_cliente';
    titulos.commatext:='Código,Nombre, Id';
    from:='g_clientes cl ';
    where:='estado =''A'' and cl.id_cliente_grupo=7 ';
    orden[1]:=1;  busca:=2;   distinct:=0;   fillimpio:=True;   row_height:=17;

    showmodal;

    if resultado then begin
      with Sender as TsSpeedButton do begin
        edCliente.text:=valor[1];
        lbCliente.caption:=valor[2];
        edIdCliente.Value :=  valor[3];
        //filter;
      end;
    end;
  end;

  btLock.Enabled := (lbCliente.Caption<>'(Seleccione un cliente)');
end;

procedure Tf_main_old.btGuardarClick(Sender: TObject);
var
  x, y, total, uds: integer;
  enc: Boolean;
  total_cl: Double;
begin
    if edIdCeco.Value<=0 then
    raise Exception.Create('CECO Inválido');

    enc := False;
    for x := 1 to grData.RowCount-1 do
          for y := 1 to grData.ColCount-1 do
          begin
               if not enc and (grData.Cells[y,x]<>'') and (StrToInt(grData.Cells[y,x])>0) then
               begin
                  enc := True;
               end;
          end;

    if ((enc and (modo=2)) or (modo=1)) then
    begin
      with dm.q_1 do
      begin
        try
           dm.t_write.StartTransaction;

           SQL.Clear;

           if modo=2 then
             sql.add('insert into m_correos_reports (id_cliente, fecha, id_ceco, id_producto, id_zona, peso, uds) values ' +
                     '(:cliente, :fecha, :ceco, :producto, :zona, :peso, :uds)')
           else
             sql.add('update m_correos_reports set uds=:uds ' +
                     'where id_cliente=:cliente and fecha=:fecha and ' +
                     'id_ceco=:ceco and id_producto=:producto and ' +
                     'id_zona=:zona and peso=:peso');

          total := 0;

          for x := 1 to grData.RowCount-1 do
            for y := 1 to grData.ColCount-1 do
            begin
                 if (grData.Cells[y,x]<>'') then
                 begin
                     Close;

                     ParamByName('cliente').asinteger := edIdCliente.Value;
                     ParamByName('fecha').AsDateTime := edFecha.Date;
                     ParamByName('ceco').asinteger := edIdCeco.Value;
                     case rgProducto.ItemIndex of
                        0: ParamByName('producto').asinteger := 239;   //Carta Ordinaria
                        1: ParamByName('producto').asinteger := 240;   //Carta Certificada
                        2: ParamByName('producto').asinteger := 325;   //Carta Certificada con AR
                     end;
                     case x of
                        1: ParamByName('zona').asinteger := 1;     //Nacional
                        2: ParamByName('zona').asinteger := 4;     //Nacional D1
                        3: ParamByName('zona').asinteger := 5;     //Nacional D2
                        4: ParamByName('zona').asinteger := 2;     //Int. Europa
                        5: ParamByName('zona').asinteger := 3;     //Int. Resto
                     end;
                     ParamByName('peso').asinteger := StrToInt(grData.Cells[y,0]);
                     ParamByName('uds').asinteger := StrToInt(grData.Cells[y,x]);
                     execquery;

                     total := total + StrToInt(grData.Cells[y,x]);
                 end;
            end;

          dm.t_write.CommitRetaining;
          //ShowMessage('Datos guardados correctamente.');

          if modo=1 then   //editando
          begin
              lbTotal.Caption := IntToStr(total);
              //HabilitaDatos(false);
              filter;
          end
          else if modo=2 then begin   //insertando, borramos para seguir con otro CECO
                    for x := 1 to grData.RowCount-1 do
                    for y := 1 to grData.ColCount-1 do
                    begin
                        grData.Cells[y,x] := '';
                    end;

                    edCeco.text:='';
                    lbCeco.caption:='(Seleccione un CECO válido)';
                    edIdCeco.Text := '';
                    filter;
                    edCeco.SetFocus;

                    //bpCeco.Click;
                    uds := 0;
                    total_cl := GetTotalCliente(StrToInt(edIdCliente.Text),uds);
                    lbTCliente.Caption := IntToStr(uds) + ' uds. ' + FloatToStr(total_cl) + ' €.';
          end;

        except
           dm.t_write.RollbackRetaining;
           ShowMessage('Error al guardar datos.');
        end;
      end;
    end else
          ShowMessage('No existen datos a guardar.');
end;


procedure Tf_main_old.edCecoChange(Sender: TObject);
begin
   If edCeco.Text<>'' then
     begin
        lbCeco.Caption := BuscaCeco(edCeco.Text);
        rgCeco.Items.Strings[1] := lbCeco.Caption;
        edIdCeco.Value := BuscaCecoId(edCeco.Text);
        filter;
     end;

     if lbCeco.Caption='' then
     begin
         lbCeco.Caption := '(Seleccione un CECO válido)';
         rgCeco.Items.Strings[1] := 'CECO por seleccionar';
     end;
end;

procedure Tf_main_old.edClienteChange(Sender: TObject);
begin
  If edCliente.Text<>'' then
     begin
        lbCliente.Caption := BuscaCliente(edCliente.Text);
        rgCliente.Items.Strings[1] := lbCliente.Caption;
        edIdCliente.Value := BuscaClienteId(edCliente.Text)
        //filter;
     end;

     if lbCliente.Caption='' then
     begin
               lbCliente.Caption := '(Seleccione un cliente)';
               rgCliente.Items.Strings[1] := 'Cliente por seleccionar';
     end;

  btLock.Enabled := (lbCliente.Caption<>'(Seleccione un cliente)');
end;

procedure Tf_main_old.edFechaChange(Sender: TObject);
begin
  filter;
end;

procedure Tf_main_old.edFechaClick(Sender: TObject);
begin
    filter;
end;

procedure Tf_main_old.btLockClick(Sender: TObject);
begin
  locked := not locked;

  if locked then
  begin
    lbCliente.Font.Color := 16;
    //CargaInterfaz;

    //filter;
  end
  else begin
        lbCliente.Font.Color := 255;
        //edCliente.SetFocus;
        //dm.q_peds.Close;
       end;

  CargaInterfaz;
end;

procedure Tf_main_old.btXlsClick(Sender: TObject);
begin
    case rgTipo.ItemIndex of
       0: XLSBonificacion;
       1: XLSResumen;
       2: XLSDetalle;
    end;

end;

procedure Tf_main_old.XLSBonificacion;
var
  id_ceco_act, fila, col, fila_tit, prod_act, uds_total, uds_total_fila, fila_prod: integer;
  imp_total_fila, imp_total, importe: Double;
begin
  id_ceco_act := -1;
  prod_act := -1;
  fila := 0;
  fila_tit := 0;
  fila_prod := 0;

  with dm.qReportBonificacion do
  try
    Close;
    case rgCliente.ItemIndex of
      0: begin
          ParamByName('cliente').AsInteger:=edIdCliente.Value;
          ParamByName('todo_cl').AsInteger:=1;
      end;
      1: begin
          ParamByName('cliente').AsInteger:=edIdCliente.Value;
          ParamByName('todo_cl').AsInteger:=0;
      end;
    end;

    case rgCECO.ItemIndex of
      0: begin
          ParamByName('ceco').AsInteger:=edIdCeco.Value;
          ParamByName('todo_cc').AsInteger:=1;
      end;
      1: begin
          ParamByName('ceco').AsInteger:=edIdCeco.Value;
          ParamByName('todo_cc').AsInteger:=0;
      end;
    end;

    ParamByName('f1').AsDate:=edFDesde.Date;
    ParamByName('f2').AsDate:=edFHasta.Date;

    Open;

    if not IsEmpty then
    begin

        First;

        xls.Filename := edXls.Text + '\bonificacion' + FormatDateTime('yyyymmddhhnnss',Now) + '.xlsx';

        while not Eof do
        begin
          uds_total := 0;
          imp_total := 0;

          if FieldByName('id_cliente').AsInteger<>id_ceco_act then
          begin
              id_ceco_act := FieldByName('id_cliente').AsInteger;
              xls.Sheets[0].AsString[0, fila] := BuscaClientePorId(FieldByName('id_cliente').AsInteger);// + ' - ' + BuscaCecoPorId(FieldByName('id_ceco').AsInteger);
              //xls.Sheets[0].Cell[0,fila].CellColorRGB:= RGB(51,168,255) ;
              xls.Sheets[0].Cell[0,fila].FontColor := clBlue ;
              Inc(fila);

              RellenaCabecerasBonificacion(fila);
              fila_tit := fila;
              Inc(fila);
          end;

          uds_total_fila:= 0;
          imp_total_fila := 0;
          for col := 1 to 6 do
          begin
             case col of
                1: xls.Sheets[0].AsInteger[col, fila] := BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,-1,
                                                                                -1,-1,1,edFDesde.Date, edFHasta.Date, importe);
                2: xls.Sheets[0].AsInteger[col, fila] := BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,-1,
                                                                                -1,-1,4,edFDesde.Date, edFHasta.Date, importe);
                3: xls.Sheets[0].AsInteger[col, fila] := BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,-1,
                                                                                -1,-1,5,edFDesde.Date, edFHasta.Date, importe);
                4: xls.Sheets[0].AsInteger[col, fila] := BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,-1,
                                                                                -1,-1,2,edFDesde.Date, edFHasta.Date, importe);
                5: xls.Sheets[0].AsInteger[col, fila] := BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,-1,
                                                                                -1,-1,3,edFDesde.Date, edFHasta.Date, importe);
                6: begin
                      xls.Sheets[0].AsInteger[col, fila] := uds_total_fila;
                      xls.Sheets[0].AsFloat[col, fila+1] := imp_total_fila;
                   end;
             end;
               If col<6 then xls.Sheets[0].AsFloat[col, fila+1] := importe;
               uds_total_fila := uds_total_fila + xls.Sheets[0].AsInteger[col, fila];
               uds_total := uds_total + xls.Sheets[0].AsInteger[col, fila];
               imp_total_fila := imp_total_fila + importe;

          end;

          fila := fila + 3;

          for col := 1 to 5 do
          begin
                xls.Sheets[0].AsFloat[col, fila] :=  xls.Sheets[0].AsInteger[col, fila-2]*xls.Sheets[0].AsInteger[col, fila-1]/100;
                imp_total := imp_total + xls.Sheets[0].AsFloat[col, fila];
          end;
          Inc(fila);
          xls.Sheets[0].asfloat[6, fila] := imp_total;
          Inc(fila);
          xls.Sheets[0].AsFloat[6, fila] := imp_total * 0.21;
          Inc(fila);
          xls.Sheets[0].AsFloat[6, fila] := imp_total - (imp_total * 0.21);
          Inc(fila);

          Next;
        end;
        xls.Write;
    end;
  finally

  end;
end;

procedure Tf_main_old.XLSDetalle;
var
  id_ceco_act, fila, col, fila_tit, prod_act, uds_total, fila_prod: integer;
begin
  id_ceco_act := -1;
  prod_act := -1;
  fila := 0;
  fila_tit := 0;
  fila_prod := 0;

  with dm.qReportDetalle do
  try
    Close;
    case rgCliente.ItemIndex of
      0: begin
          ParamByName('cliente').AsInteger:=edIdCliente.Value;
          ParamByName('todo_cl').AsInteger:=1;
      end;
      1: begin
          ParamByName('cliente').AsInteger:=edIdCliente.Value;
          ParamByName('todo_cl').AsInteger:=0;
      end;
    end;

    case rgCECO.ItemIndex of
      0: begin
          ParamByName('ceco').AsInteger:=edIdCeco.Value;
          ParamByName('todo_cc').AsInteger:=1;
      end;
      1: begin
          ParamByName('ceco').AsInteger:=edIdCeco.Value;
          ParamByName('todo_cc').AsInteger:=0;
      end;
    end;

    ParamByName('f1').AsDate:=edFDesde.Date;
    ParamByName('f2').AsDate:=edFHasta.Date;

    Open;

    if not IsEmpty then
    begin
        First;

        xls.Filename := edXls.Text + '\detalle' + FormatDateTime('yyyymmddhhnnss',Now) + '.xlsx';

        while not Eof do
        begin

          if FieldByName('id_ceco').AsInteger<>id_ceco_act then
          begin
              id_ceco_act := FieldByName('id_ceco').AsInteger;
              xls.Sheets[0].AsString[0, fila] := BuscaClientePorId(FieldByName('id_cliente').AsInteger) + ' - ' + BuscaCecoPorId(FieldByName('id_ceco').AsInteger);
              Inc(fila);

              if FieldByName('id_producto').AsInteger<>prod_act then
              begin
                prod_act := FieldByName('id_producto').AsInteger;
                case prod_act of
                  239: xls.Sheets[0].AsString[0, fila] := 'CARTAS ORDINARIAS';
                  240: xls.Sheets[0].AsString[0, fila] := 'CARTAS CERTIFICADAS';
                  325: xls.Sheets[0].AsString[0, fila] := 'CARTAS CERTIFICADAS CON A.R.';
                end;
                Inc(fila);
              end;

              RellenaCabeceras(fila);
              fila_tit := fila;
              Inc(fila);
          end;

          if FieldByName('id_producto').AsInteger<>prod_act then
          begin
            prod_act := FieldByName('id_producto').AsInteger;
            case prod_act of
              239: xls.Sheets[0].AsString[0, fila] := 'CARTAS ORDINARIAS';
              240: xls.Sheets[0].AsString[0, fila] := 'CARTAS CERTIFICADAS';
              325: xls.Sheets[0].AsString[0, fila] := 'CARTAS CERTIFICADAS CON A.R.';
            end;
            Inc(fila);
          end;

          //fila := fila + 2;

          uds_total := 0;
          for col := 0 to 32 do
          begin
             case col of
                0: xls.Sheets[0].AsString[col, fila] := FieldByName('fecha').AsString;
                1..6: begin
                          xls.Sheets[0].AsInteger[col, fila] := BuscaFranqueo(FieldByName('id_cliente').AsInteger,FieldByName('id_ceco').AsInteger,
                                                               xls.Sheets[0].AsInteger[col, fila_tit],prod_act,
                                                               1,FieldByName('fecha').AsDateTime);
                          uds_total := uds_total + xls.Sheets[0].AsInteger[col, fila];
                      end;
                7..12: begin
                          xls.Sheets[0].AsInteger[col, fila] := BuscaFranqueo(FieldByName('id_cliente').AsInteger,FieldByName('id_ceco').AsInteger,
                                                               xls.Sheets[0].AsInteger[col, fila_tit],prod_act,
                                                               4,FieldByName('fecha').AsDateTime);
                          uds_total := uds_total + xls.Sheets[0].AsInteger[col, fila];
                       end;
                13..18: begin
                          xls.Sheets[0].AsInteger[col, fila] := BuscaFranqueo(FieldByName('id_cliente').AsInteger,FieldByName('id_ceco').AsInteger,
                                                               xls.Sheets[0].AsInteger[col, fila_tit],prod_act,
                                                               5,FieldByName('fecha').AsDateTime);
                          uds_total := uds_total + xls.Sheets[0].AsInteger[col, fila];
                        end;
                21: xls.Sheets[0].AsInteger[col, fila] := uds_total;
                22: xls.Sheets[0].AsFloat[col, fila] := 0;
             end;
          end;
          Inc(fila);
          Next;
        end;
    end;

    xls.Write;
  finally

  end;

end;


procedure Tf_main_old.XLSResumen;
var
  id_ceco_act, fila, col, fila_tit, prod_act, uds_total, fila_prod: integer;
  importe,imp_total_nac, imp_total_int: Double;
begin
  id_ceco_act := -1;
  prod_act := -1;
  fila := 0;
  fila_tit := 0;
  fila_prod := 0;

  with dm.qReportResumen do
  try
    Close;
    case rgCliente.ItemIndex of
      0: begin
          ParamByName('cliente').AsInteger:=edIdCliente.Value;
          ParamByName('todo_cl').AsInteger:=1;
      end;
      1: begin
          ParamByName('cliente').AsInteger:=edIdCliente.Value;
          ParamByName('todo_cl').AsInteger:=0;
      end;
    end;

    case rgCECO.ItemIndex of
      0: begin
          ParamByName('ceco').AsInteger:=edIdCeco.Value;
          ParamByName('todo_cc').AsInteger:=1;
      end;
      1: begin
          ParamByName('ceco').AsInteger:=edIdCeco.Value;
          ParamByName('todo_cc').AsInteger:=0;
      end;
    end;

    ParamByName('f1').AsDate:=edFDesde.Date;
    ParamByName('f2').AsDate:=edFHasta.Date;

    Open;

    if not IsEmpty then
    begin
        First;

        xls.Filename := edXls.Text + '\resumen' + FormatDateTime('yyyymmddhhnnss',Now) + '.xlsx';

        RellenaCabecerasResumen(fila);
        fila_tit := fila;
        Inc(fila);

        while not Eof do
        begin

          if FieldByName('id_ceco').AsInteger<>id_ceco_act then
          begin
              id_ceco_act := FieldByName('id_ceco').AsInteger;
              xls.Sheets[0].AsString[0, fila] := BuscaCecoPorId(FieldByName('id_ceco').AsInteger);
              xls.Sheets[0].AsString[1, fila] := 'NACIONAL';
              xls.Sheets[0].AsString[1, fila+1] := 'INTERNACIONAL';
          end;

          uds_total := 0;
          imp_total_nac := 0;
          imp_total_int := 0;
          importe := 0;

          for col := 2 to 8 do
          begin
             case col of
                0: xls.Sheets[0].AsString[col, fila] := FieldByName('fecha').AsString;
                2..7: begin
                          uds_total := uds_total + BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,FieldByName('id_ceco').AsInteger,
                                                               xls.Sheets[0].AsInteger[col, fila_tit],-1,
                                                               1,edFDesde.Date, edFHasta.Date, importe);
                          imp_total_nac := imp_total_nac + importe;
                          uds_total := uds_total + BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,FieldByName('id_ceco').AsInteger,
                                                               xls.Sheets[0].AsInteger[col, fila_tit],-1,
                                                               4,edFDesde.Date, edFHasta.Date, importe);
                          imp_total_nac := imp_total_nac + importe;
                          uds_total := uds_total + BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,FieldByName('id_ceco').AsInteger,
                                                               xls.Sheets[0].AsInteger[col, fila_tit],-1,
                                                               5,edFDesde.Date, edFHasta.Date, importe);
                          imp_total_nac := imp_total_nac + importe;

                          xls.Sheets[0].AsInteger[col, fila] := uds_total;
                          uds_total := 0;


                          uds_total := uds_total + BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,FieldByName('id_ceco').AsInteger,
                                                               xls.Sheets[0].AsInteger[col, fila_tit],-1,
                                                               2,edFDesde.Date, edFHasta.Date, importe);
                          imp_total_int := imp_total_int + importe;
                          uds_total := uds_total + BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,FieldByName('id_ceco').AsInteger,
                                                               xls.Sheets[0].AsInteger[col, fila_tit],-1,
                                                               3,edFDesde.Date, edFHasta.Date, importe);
                          imp_total_int := imp_total_int + importe;

                          xls.Sheets[0].AsInteger[col, fila+1] := uds_total;
                      end;
                8: begin
                      xls.Sheets[0].AsFloat[col, fila] := imp_total_nac;
                      xls.Sheets[0].AsFloat[col, fila+1] := imp_total_int;
                   end;
             end;
          end;
          fila := fila + 2;
          Next;
        end;
    end;

    xls.Write;
  finally

  end;

end;

procedure Tf_main_old.ReportResumen;
var
  id_ceco_act, fila, col, fila_tit, prod_act, uds_total, uds_total_fila, fila_prod: integer;
  imp_total_fila, imp_total, importe: Double;
begin
  id_ceco_act := -1;
  prod_act := -1;
  fila := 0;
  fila_tit := 0;
  fila_prod := 0;

  ar_resumen.EmptyDataSet;

  with dm.qReportBonificacion do
  try
    Close;
    case rgCliente.ItemIndex of
      0: begin
          ParamByName('cliente').AsInteger:=edIdCliente.Value;
          ParamByName('todo_cl').AsInteger:=1;
      end;
      1: begin
          ParamByName('cliente').AsInteger:=edIdCliente.Value;
          ParamByName('todo_cl').AsInteger:=0;
      end;
    end;

    case rgCECO.ItemIndex of
      0: begin
          ParamByName('ceco').AsInteger:=edIdCeco.Value;
          ParamByName('todo_cc').AsInteger:=1;
      end;
      1: begin
          ParamByName('ceco').AsInteger:=edIdCeco.Value;
          ParamByName('todo_cc').AsInteger:=0;
      end;
    end;

    ParamByName('f1').AsDate:=edFDesde.Date;
    ParamByName('f2').AsDate:=edFHasta.Date;

    Open;

    if not IsEmpty then
    begin

        First;

        while not Eof do
        begin
          uds_total := 0;
          imp_total := 0;

          ar_resumen.Insert;
          ar_resumen.FieldByName('id_cliente').AsInteger := FieldByName('id_cliente').AsInteger;
          ar_resumen.FieldByName('nombre').AsString := BuscaClientePorId(FieldByName('id_cliente').AsInteger);
          ar_resumen.FieldByName('fecha_desde').AsString := FormatDateTime('dd/mm/yyyy', edFDesde.Date);
          ar_resumen.FieldByName('fecha_hasta').AsString := FormatDateTime('dd/mm/yyyy', edFHasta.Date);

          uds_total_fila:= 0;
          imp_total_fila := 0;

          ar_resumen.FieldByName('uds_local').AsInteger := BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,-1,-1,-1,1,edFDesde.Date, edFHasta.Date, importe);
          ar_resumen.FieldByName('imp_local').AsFloat := importe;
          ar_resumen.FieldByName('uds_int_eur').AsInteger := BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,-1,-1,-1,2,edFDesde.Date, edFHasta.Date, importe);
          ar_resumen.FieldByName('imp_int_eur').AsFloat := importe;
          ar_resumen.FieldByName('uds_int_resto').AsInteger := BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,-1,-1,-1,3,edFDesde.Date, edFHasta.Date, importe);
          ar_resumen.FieldByName('imp_int_resto').AsFloat := importe;
          ar_resumen.FieldByName('uds_d1').AsInteger := BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,-1,-1,-1,4,edFDesde.Date, edFHasta.Date, importe);
          ar_resumen.FieldByName('imp_d1').AsFloat := importe;
          ar_resumen.FieldByName('uds_d2').AsInteger := BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,-1,-1,-1,5,edFDesde.Date, edFHasta.Date, importe);
          ar_resumen.FieldByName('imp_d2').AsFloat := importe;

          Next;
        end;
        ar_resumen.Post;

        if repResumen.PrepareReport then repResumen.ShowPreparedReport;

    end;
  finally

  end;
end;

procedure Tf_main_old.rgClienteChange(Sender: TObject);
var
  id_ceco_act, fila, col, fila_tit, prod_act, uds_total, fila_prod: integer;
begin
  id_ceco_act := -1;
  prod_act := -1;
  fila := 0;
  fila_tit := 0;
  fila_prod := 0;

  with dm.qReportResumen do
  try
    Close;
    case rgCliente.ItemIndex of
      0: begin
          ParamByName('cliente').AsInteger:=edIdCliente.Value;
          ParamByName('todo_cl').AsInteger:=1;
      end;
      1: begin
          ParamByName('cliente').AsInteger:=edIdCliente.Value;
          ParamByName('todo_cl').AsInteger:=0;
      end;
    end;

    case rgCECO.ItemIndex of
      0: begin
          ParamByName('ceco').AsInteger:=edIdCeco.Value;
          ParamByName('todo_cc').AsInteger:=1;
      end;
      1: begin
          ParamByName('ceco').AsInteger:=edIdCeco.Value;
          ParamByName('todo_cc').AsInteger:=0;
      end;
    end;

    ParamByName('f1').AsDate:=edFDesde.Date;
    ParamByName('f2').AsDate:=edFHasta.Date;

    Open;

    if not IsEmpty then
    begin
        First;

        xls.Filename := edXls.Text + '\resumen' + FormatDateTime('yyyymmddhhnnss',Now) + '.xlsx';

        while not Eof do
        begin

          if FieldByName('id_ceco').AsInteger<>id_ceco_act then
          begin
              id_ceco_act := FieldByName('id_ceco').AsInteger;
              xls.Sheets[0].AsString[0, fila] := BuscaClientePorId(FieldByName('id_cliente').AsInteger) + ' - ' + BuscaCecoPorId(FieldByName('id_ceco').AsInteger);
              Inc(fila);

              if FieldByName('id_producto').AsInteger<>prod_act then
              begin
                prod_act := FieldByName('id_producto').AsInteger;
                case prod_act of
                  239: xls.Sheets[0].AsString[0, fila] := 'CARTAS ORDINARIAS';
                  240: xls.Sheets[0].AsString[0, fila] := 'CARTAS CERTIFICADAS';
                  325: xls.Sheets[0].AsString[0, fila] := 'CARTAS CERTIFICADAS CON A.R.';
                end;
                Inc(fila);
              end;

              RellenaCabeceras(fila);
              fila_tit := fila;
              Inc(fila);
          end;

          if FieldByName('id_producto').AsInteger<>prod_act then
          begin
            prod_act := FieldByName('id_producto').AsInteger;
            case prod_act of
              239: xls.Sheets[0].AsString[0, fila] := 'CARTAS ORDINARIAS';
              240: xls.Sheets[0].AsString[0, fila] := 'CARTAS CERTIFICADAS';
              325: xls.Sheets[0].AsString[0, fila] := 'CARTAS CERTIFICADAS CON A.R.';
            end;
            Inc(fila);
          end;

          //fila := fila + 2;

          uds_total := 0;
          for col := 0 to 32 do
          begin
             case col of
                0: xls.Sheets[0].AsString[col, fila] := FieldByName('fecha').AsString;
                1..6: begin
                          xls.Sheets[0].AsInteger[col, fila] := BuscaFranqueo(FieldByName('id_cliente').AsInteger,FieldByName('id_ceco').AsInteger,
                                                               xls.Sheets[0].AsInteger[col, fila_tit],prod_act,
                                                               1,FieldByName('fecha').AsDateTime);
                          uds_total := uds_total + xls.Sheets[0].AsInteger[col, fila];
                      end;
                7..12: begin
                          xls.Sheets[0].AsInteger[col, fila] := BuscaFranqueo(FieldByName('id_cliente').AsInteger,FieldByName('id_ceco').AsInteger,
                                                               xls.Sheets[0].AsInteger[col, fila_tit],prod_act,
                                                               4,FieldByName('fecha').AsDateTime);
                          uds_total := uds_total + xls.Sheets[0].AsInteger[col, fila];
                       end;
                13..18: begin
                          xls.Sheets[0].AsInteger[col, fila] := BuscaFranqueo(FieldByName('id_cliente').AsInteger,FieldByName('id_ceco').AsInteger,
                                                               xls.Sheets[0].AsInteger[col, fila_tit],prod_act,
                                                               5,FieldByName('fecha').AsDateTime);
                          uds_total := uds_total + xls.Sheets[0].AsInteger[col, fila];
                        end;
                21: xls.Sheets[0].AsInteger[col, fila] := uds_total;
                22: xls.Sheets[0].AsFloat[col, fila] := 0;
             end;
          end;
          Inc(fila);
          Next;
        end;
    end;

    xls.Write;
  finally

  end;

end;

procedure Tf_main_old.rgProductoChange(Sender: TObject);
begin
  filter;
end;

procedure Tf_main_old.ReportDetalle;
var
  id_ceco_act, fila, col, fila_tit, prod_act, uds_total, fila_prod: integer;
  importe: Double;
begin
  id_ceco_act := -1;
  prod_act := -1;
  fila := 0;
  fila_tit := 0;
  fila_prod := 0;

  with dm.qReportDetalle do
  try
    Close;
    case rgCliente.ItemIndex of
      0: begin
          ParamByName('cliente').AsInteger:=edIdCliente.Value;
          ParamByName('todo_cl').AsInteger:=1;
      end;
      1: begin
          ParamByName('cliente').AsInteger:=edIdCliente.Value;
          ParamByName('todo_cl').AsInteger:=0;
      end;
    end;

    case rgCECO.ItemIndex of
      0: begin
          ParamByName('ceco').AsInteger:=edIdCeco.Value;
          ParamByName('todo_cc').AsInteger:=1;
      end;
      1: begin
          ParamByName('ceco').AsInteger:=edIdCeco.Value;
          ParamByName('todo_cc').AsInteger:=0;
      end;
    end;

    ParamByName('f1').AsDate:=edFDesde.Date;
    ParamByName('f2').AsDate:=edFHasta.Date;

    Open;

    if not IsEmpty then
    begin
        First;

        xls.Filename := edXls.Text + '\franqueo' + FormatDateTime('yyyymmddhhnnss',Now) + '.xlsx';

        while not Eof do
        begin

          if FieldByName('id_ceco').AsInteger<>id_ceco_act then
          begin
              id_ceco_act := FieldByName('id_ceco').AsInteger;
              xls.Sheets[0].AsString[0, fila] := BuscaClientePorId(FieldByName('id_cliente').AsInteger) + ' - ' + BuscaCecoPorId(FieldByName('id_ceco').AsInteger);
              Inc(fila);

              if FieldByName('id_producto').AsInteger<>prod_act then
              begin
                prod_act := FieldByName('id_producto').AsInteger;
                case prod_act of
                  239: xls.Sheets[0].AsString[0, fila] := 'CARTAS ORDINARIAS';
                  240: xls.Sheets[0].AsString[0, fila] := 'CARTAS CERTIFICADAS';
                  325: xls.Sheets[0].AsString[0, fila] := 'CARTAS CERTIFICADAS CON A.R.';
                end;
                Inc(fila);
              end;

              RellenaCabeceras(fila);
              fila_tit := fila;
              Inc(fila);
          end;

          if FieldByName('id_producto').AsInteger<>prod_act then
          begin
            prod_act := FieldByName('id_producto').AsInteger;
            case prod_act of
              239: xls.Sheets[0].AsString[0, fila] := 'CARTAS ORDINARIAS';
              240: xls.Sheets[0].AsString[0, fila] := 'CARTAS CERTIFICADAS';
              325: xls.Sheets[0].AsString[0, fila] := 'CARTAS CERTIFICADAS CON A.R.';
            end;
            Inc(fila);
          end;

          //fila := fila + 2;

          uds_total := 0;
          for col := 0 to 32 do
          begin
             case col of
                0: xls.Sheets[0].AsString[col, fila] := FieldByName('fecha').AsString;
                1..6: begin
                          xls.Sheets[0].AsInteger[col, fila] := BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,FieldByName('id_ceco').AsInteger,
                                                               xls.Sheets[0].AsInteger[col, fila_tit],prod_act,
                                                               1,edFDesde.Date, edFHasta.Date,importe);
                          uds_total := uds_total + xls.Sheets[0].AsInteger[col, fila];
                      end;
                7..12: begin
                          xls.Sheets[0].AsInteger[col, fila] := BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,FieldByName('id_ceco').AsInteger,
                                                               xls.Sheets[0].AsInteger[col, fila_tit],prod_act,
                                                               4,edFDesde.Date, edFHasta.Date, importe);
                          uds_total := uds_total + xls.Sheets[0].AsInteger[col, fila];
                       end;
                13..18: begin
                          xls.Sheets[0].AsInteger[col, fila] := BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,FieldByName('id_ceco').AsInteger,
                                                               xls.Sheets[0].AsInteger[col, fila_tit],prod_act,
                                                               5,edFDesde.Date, edFHasta.Date, importe);
                          uds_total := uds_total + xls.Sheets[0].AsInteger[col, fila];
                        end;
                21: xls.Sheets[0].AsInteger[col, fila] := uds_total;
                22: xls.Sheets[0].AsFloat[col, fila] := 0;
             end;
          end;
          Inc(fila);
          Next;
        end;
    end;

    xls.Write;
  finally

  end;
end;

procedure Tf_main_old.RellenaCabeceras(fila:integer);
begin
    xls.Sheets[0].AsString[1, fila] := 'LOCAL';
    xls.Sheets[0].AsString[7, fila] := 'D - 1';
    xls.Sheets[0].AsString[13, fila] := 'D - 2';
    xls.Sheets[0].AsString[19, fila] := 'INT. EUR.';
    xls.Sheets[0].AsString[20, fila] := 'INT. RESTO';
    xls.Sheets[0].AsString[31, fila] := 'TOTAL ENVIO';
    xls.Sheets[0].AsString[32, fila] := 'TOTAL €';
    Inc(fila);
    xls.Sheets[0].AsString[0, fila] := 'DIA';
    xls.Sheets[0].AsString[1, fila] := '20';    //Pesos Local
    xls.Sheets[0].AsString[2, fila] := '50';
    xls.Sheets[0].AsString[3, fila] := '100';
    xls.Sheets[0].AsString[4, fila] := '500';
    xls.Sheets[0].AsString[5, fila] := '1000';
    xls.Sheets[0].AsString[6, fila] := '2000';
    xls.Sheets[0].AsString[7, fila] := '20';     //Pesos D1
    xls.Sheets[0].AsString[8, fila] := '50';
    xls.Sheets[0].AsString[9, fila] := '100';
    xls.Sheets[0].AsString[10, fila] := '500';
    xls.Sheets[0].AsString[11, fila] := '1000';
    xls.Sheets[0].AsString[12, fila] := '2000';
    xls.Sheets[0].AsString[13, fila] := '20';     //Pesos D2
    xls.Sheets[0].AsString[14, fila] := '50';
    xls.Sheets[0].AsString[15, fila] := '100';
    xls.Sheets[0].AsString[16, fila] := '500';
    xls.Sheets[0].AsString[17, fila] := '1000';
    xls.Sheets[0].AsString[18, fila] := '2000';
    xls.Sheets[0].AsString[19, fila] := '20';     //Pesos Int. Europa
    xls.Sheets[0].AsString[20, fila] := '50';
    xls.Sheets[0].AsString[21, fila] := '100';
    xls.Sheets[0].AsString[22, fila] := '500';
    xls.Sheets[0].AsString[23, fila] := '1000';
    xls.Sheets[0].AsString[24, fila] := '2000';
    xls.Sheets[0].AsString[25, fila] := '20';     //Pesos Int. Resto
    xls.Sheets[0].AsString[26, fila] := '50';
    xls.Sheets[0].AsString[27, fila] := '100';
    xls.Sheets[0].AsString[28, fila] := '500';
    xls.Sheets[0].AsString[29, fila] := '1000';
    xls.Sheets[0].AsString[30, fila] := '2000';
end;


procedure Tf_main_old.RellenaCabecerasResumen(fila:integer);
begin
    xls.Sheets[0].AsString[0, fila] := 'CLIENTE';
    xls.Sheets[0].AsString[1, fila] := 'AMBITO';
    xls.Sheets[0].AsString[2, fila] := '20';
    xls.Sheets[0].AsString[3, fila] := '50';
    xls.Sheets[0].AsString[4, fila] := '100';
    xls.Sheets[0].AsString[5, fila] := '500';
    xls.Sheets[0].AsString[6, fila] := '1000';
    xls.Sheets[0].AsString[7, fila] := '2000';
    xls.Sheets[0].AsString[8, fila] := 'IMPORTE';
end;

procedure Tf_main_old.RellenaCabecerasBonificacion(fila:integer);
begin
    xls.Sheets[0].AsString[1, fila] := 'LOCAL';
    xls.Sheets[0].AsString[2, fila] := 'D - 1';
    xls.Sheets[0].AsString[3, fila] := 'D - 2';
    xls.Sheets[0].AsString[4, fila] := 'INT. EUR.';
    xls.Sheets[0].AsString[5, fila] := 'INT. RESTO';
    xls.Sheets[0].AsString[6, fila] := 'TOTAL';
    Inc(fila);
    xls.Sheets[0].AsString[0, fila] := 'Uds.';
    Inc(fila);
    xls.Sheets[0].AsString[0, fila] := 'Importe';
    Inc(fila);
    xls.Sheets[0].AsString[0, fila] := '% Dto.';
    xls.Sheets[0].AsInteger[1, fila] := 11;
    xls.Sheets[0].AsInteger[2, fila] := 11;
    xls.Sheets[0].AsInteger[3, fila] := 5;
    xls.Sheets[0].AsInteger[4, fila] := 5;
    xls.Sheets[0].AsInteger[5, fila] := 5;
    Inc(fila);
    xls.Sheets[0].AsString[0, fila] := 'Imp. Total';
    Inc(fila);
    xls.Sheets[0].AsString[5, fila] := 'Total';
    Inc(fila);
    xls.Sheets[0].AsString[5, fila] := 'I.V.A. 21%';
    Inc(fila);
    xls.Sheets[0].AsString[5, fila] := 'TOTAL';
end;

function Tf_main_old.BuscaFranqueoPorFechas(cliente, ceco, peso, producto, zona:integer; f1,f2:TDateTime; out importe:Double):Integer;
begin
  importe := 0;

  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('SELECT id_zona, sum(uds) as uds, sum(r.uds*r.tarifa) as importe FROM m_correos_reports r ' +
                       'WHERE ((r.id_cliente=:cliente) or (:todo_cl=1)) and ' +
                       '      ((r.id_ceco=:ceco) or (:todo_cc=1)) and ' +
                       '      ((r.id_producto=:producto) or (:todo_pr=1)) and ' +
                       '      ((r.id_zona=:zona) or (:todo_zn=1)) and ' +
                       '      ((r.peso=:peso) or (:todo_ps=1)) and ' +
                       '      r.fecha between :f1 and :f2 and estado=''A''' +
                       '      group by id_zona');

    if cliente=-1 then ParamByName('todo_cl').AsInteger := 1;
    if ceco=-1 then ParamByName('todo_cc').AsInteger := 1;
    if producto=-1 then ParamByName('todo_pr').AsInteger := 1;
    if peso=-1 then ParamByName('todo_ps').AsInteger := 1;
    if zona=-1 then ParamByName('todo_zn').AsInteger := 1;

    ParamByName('cliente').AsInteger := cliente;
    ParamByName('ceco').AsInteger := ceco;
    ParamByName('f1').AsDateTime := f1;
    ParamByName('f2').AsDateTime := f2;
    ParamByName('peso').AsInteger := peso;
    ParamByName('producto').AsInteger := producto;
    ParamByName('zona').AsInteger := zona;
    Open;

    if not(IsEmpty) then
    begin
        Result:=FieldByName('uds').AsInteger;
        importe := FieldByName('importe').AsFloat;
    end
    else result:=0;

    Free;
  end;
end;

function Tf_main_old.BuscaFranqueo(cliente, ceco, peso, producto, zona:integer; fecha:TDateTime):Integer;
begin
   with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select sum(uds) as uds from m_correos_reports ' +
                       'where id_cliente=:cliente and peso=:peso and id_producto=:producto and ' +
                             'id_ceco=:ceco and fecha=:fecha and id_zona=:zona and estado=''A''');
    ParamByName('cliente').AsInteger := cliente;
    ParamByName('ceco').AsInteger := ceco;
    ParamByName('fecha').AsDateTime := fecha;
    ParamByName('peso').AsInteger := peso;
    ParamByName('producto').AsInteger := producto;
    ParamByName('zona').AsInteger := zona;
    Open;

    if not(IsEmpty) then Result:=FieldByName('uds').AsInteger
    else result:=-1;

    Free;
  end;
end;

function Tf_main_old.BuscaTarifa(cliente, ceco, peso, producto, zona:integer):Double;
begin
   with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select sum(uds) from m_tarifas_clientes ' +
                       'where id_cliente=:cliente and peso=:peso and id_producto=:producto and ' +
                             'id_ceco=:ceco and fecha=:f1 and id_zona=:zona and estado=''A''');
    ParamByName('cliente').AsInteger := cliente;
    ParamByName('ceco').AsInteger := ceco;
    ParamByName('peso').AsInteger := peso;
    ParamByName('producto').AsInteger := producto;
    ParamByName('zona').AsInteger := zona;
    Open;

    if not(IsEmpty) then Result:=FieldByName('uds').AsInteger
    else result:=-1;

    Free;
  end;
end;

procedure Tf_main_old.HabilitaDatos(habilitar:Boolean);
begin
  grData.Enabled := habilitar;
  btLimpiar.Enabled := habilitar;
  btGuardar.Enabled := habilitar;
  btCancel.Enabled := habilitar;
  btLock.Enabled := not habilitar;
  //btConsulta.Enabled := not habilitar;
end;

function Tf_main_old.BuscaCliente(codigo:string):string;
begin                                       //devuelve nombre de cliente a partir de codigo
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select nombre from g_clientes cl where cl.id_cliente_grupo=7 and cl.codigo=:codigo');
    ParamByName('codigo').AsInteger := StrToInt(codigo);
    Open;

    if not(IsEmpty) then Result:=FieldByName('nombre').asstring
    else result:='';

    Free;
  end;
end;


function Tf_main_old.BuscaClientePorId(id:integer):string;
begin                                       //devuelve nombre de cliente a partir de id
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select nombre from g_clientes cl where cl.id_cliente_grupo=7 and cl.id_cliente=:id');
    ParamByName('id').AsInteger := id;
    Open;

    if not(IsEmpty) then Result:=FieldByName('nombre').asstring
    else result:='';

    Free;
  end;
end;

function Tf_main_old.BuscaClienteId(codigo:string):Integer;
begin                                       //devuelve id de cliente a partir de codigo
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select id_cliente from g_clientes cl where cl.id_cliente_grupo=7 and cl.codigo=:codigo');
    ParamByName('codigo').AsInteger := StrToInt(codigo);
    Open;

    if not(IsEmpty) then Result:=FieldByName('id_cliente').AsInteger
    else result:=-1;

    Free;
  end;
end;

function Tf_main_old.BuscaCeco(codigo:string):string;
begin                                       //devuelve nombre de ceco a partir de codigo
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select nombre from g_clientes_cecos c where c.codigo=:codigo and c.id_cliente=:cliente');
    ParamByName('codigo').AsString := codigo;
    ParamByName('cliente').AsInteger := edIdCliente.Value;
    Open;

    if not(IsEmpty) then Result:=FieldByName('nombre').asstring
    else result:='';

    Free;
  end;
end;

function Tf_main_old.BuscaCecoPorId(id:integer):string;
begin                                       //devuelve nombre de ceco a partir de id
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select nombre from g_clientes_cecos c where c.id_cliente_ceco=:id');
    ParamByName('id').AsInteger := id;
    Open;

    if not(IsEmpty) then Result:=FieldByName('nombre').asstring
    else result:='';

    Free;
  end;
end;

function Tf_main_old.BuscaCecoId(codigo:string):Integer;
begin                                       //devuelve id de cliente a partir de codigo
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select id_cliente_ceco from g_clientes_cecos c where c.codigo=:codigo and c.id_cliente=:cliente');
    ParamByName('codigo').AsString := codigo;
    ParamByName('cliente').AsInteger := edIdCliente.Value;
    Open;

    if not(IsEmpty) then Result:=FieldByName('id_cliente_ceco').AsInteger
    else result:=-1;

    Free;
  end;
end;

procedure Tf_main_old.filter;
var
  x, y, total, uds: Integer;
  total_cl: Double;
begin

     uds := 0;
     total_cl := GetTotalCliente(StrToInt(edIdCliente.Text),uds);
     lbTCliente.Caption :=  IntToStr(uds) + ' uds. ' + FormatCurr('0,##',total_cl) + ' €.';

     if ((rgTipo.ItemIndex=-1) or (edCeco.Text='') or (edIdCliente.Text='') or (edIdCeco.Text='') or (modo=2))  then
          Exit;

      btLimpiarClick(self);
      total := 0;

      with dm.qfiltro do
      begin
        try
           Close;
           SelectSQL.Clear;
           SelectSQL.add('select uds from m_correos_reports ' +
                         'where id_cliente=:cliente and fecha=:fecha and ' +
                         'id_ceco=:ceco and id_producto=:producto and id_zona=:zona and ' +
                         'peso=:peso');

          for x := 1 to grData.RowCount-1 do
            for y := 1 to grData.ColCount-1 do
            begin
                 Close;

                 ParamByName('cliente').asinteger := edIdCliente.Value;
                 ParamByName('fecha').AsDateTime := edFecha.Date;
                 ParamByName('ceco').asinteger := edIdCeco.Value;
                 case rgProducto.ItemIndex of
                    0: ParamByName('producto').asinteger := 239;   //Carta Ordinaria
                    1: ParamByName('producto').asinteger := 240;   //Carta Certificada
                    2: ParamByName('producto').asinteger := 325;   //Carta Certificada con AR
                 end;
                 case x of
                    1: ParamByName('zona').asinteger := 1;     //Nacional
                    2: ParamByName('zona').asinteger := 4;     //Nacional D1
                    3: ParamByName('zona').asinteger := 5;     //Nacional D2
                    4: ParamByName('zona').asinteger := 2;     //Int. Europa
                    5: ParamByName('zona').asinteger := 3;     //Int. Resto
                 end;
                 ParamByName('peso').asinteger := StrToInt(grData.Cells[y,0]);
                 open;

                 if not IsEmpty then
                 begin
                       grData.Cells[y,x] := FieldByName('uds').AsString;
                       total := total + FieldByName('uds').AsInteger;
                 end;
            end;

            lbTotal.Caption := IntToStr(total);

        except
           ShowMessage('Error al cargar datos.');
        end;
      end;

end;

procedure Tf_main_old.FormCreate(Sender: TObject);
begin
  grData.Rows[1].Text := 'Nacional Local';
  grData.Rows[2].Text := 'Nacional D1';
  grData.Rows[3].Text := 'Nacional D2';
  grData.Rows[4].Text := 'Int. Europa';
  grData.Rows[5].Text := 'Int. Resto Mundo';
  grData.Cols[1].Text := '20';
  grData.Cols[2].Text := '50';
  grData.Cols[3].Text := '100';
  grData.Cols[4].Text := '500';
  grData.Cols[5].Text := '1000';
  grData.Cols[6].Text := '2000';

  grData.ColWidths[0] := 100;

  lbModo.Caption := 'Modo Consulta';
  lbTotal.Caption := '';
  modo := 0;

end;

procedure Tf_main_old.CargaInterfaz;
var
  f_type, order_ok: string;
  i, uds: integer;
  total : Double;
  stream: TStream;
begin
  btLock.ImageIndex := Integer(locked);
  edCliente.Enabled := not locked;
  btCliente.Enabled := not locked;
  pnFiltro.Enabled := locked;
  //grData.Enabled := locked;
  //btGuardar.Enabled := locked;
  pnBts.Enabled := locked;


  lbCeco.Caption := '(Seleccione un CECO válido)';
  rgCeco.Items.Strings[1] := 'CECO por seleccionar';
  edCeco.Text := '';
  lbTotal.Caption := '';

  if modo=0 then
      filter;

  if locked then
  begin
      uds := 0;
      total := GetTotalCliente(StrToInt(edIdCliente.Text),uds);
      lbTCliente.Caption := IntToStr(uds) + ' uds. ' + FloatToStr(total) + ' €.';
  end else
         lbTCliente.Caption := '0 uds. 0 €.';


  //edCeco.SetFocus;

 { with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select file_type, delivery_time, logo, default_deleg, path_files_imp, ' +
                       'transporte_propio, order_ok, id_repartidor, email_reexp, path_files_reexp, ' +
                       'prefijo_reexp, estado_alb, logo, tiene_lotes ' +
                       'from g_clientes_config where id_cliente=:id ');
    ParambyName('id').asstring := edCliente.Text;
    Open;

    if not(IsEmpty) then
    begin
       f_type:=FieldByName('file_type').asstring;
       if FieldByName('delivery_time').AsInteger>=0 then
              delivery_time := FieldByName('delivery_time').AsInteger
       else
          delivery_time := 24;

       //u_detail.f_detail.rep_pick.FindObject('picture2') as TfrxPictureView;

       if FieldByName('default_deleg').AsString='' then
          default_deleg := edCliente.Text + '1'
       else
          default_deleg := FieldByName('default_deleg').AsString;

       path_files_imp := FieldByName('path_files_imp').AsString;
       transporte_propio := FieldByName('transporte_propio').AsInteger;
       repartidor := FieldByName('id_repartidor').AsInteger;

       if repartidor>0 then
          CargarDatosCorreos;

       order_ok := FieldByName('order_ok').AsString;
       email_reexp := FieldByName('email_reexp').AsString;
       path_reexp := FieldByName('path_files_reexp').AsString;
       prefijo_reexp := FieldByName('prefijo_reexp').AsString;

       if FieldByName('estado_alb').AsString='' then
          estado_alb := 0
       else
          estado_alb := FieldByName('estado_alb').AsInteger;

       tiene_lotes := (FieldByName('tiene_lotes').AsInteger=1);

      q1.Close;
      q1.ParamByName('id').AsInteger := StrToInt(edCliente.Text);
      q1.Open;

//      dbi_logo.DataSource := DataSource.DataSet;
//      dbi_logo.DataField := 'logo';
//      dbi_logo.LoadPicture;

    end
    else f_type:='';

    Free;
  end;    }

 { bt_import.Enabled := False;
  bt_import_mdb.Enabled := False;

  if locked then
  begin
    bt_import.Enabled := False;
    bt_import_mdb.Enabled := False;
    btDevos.Enabled := False;

    for i := 1 to Length(f_type) do
    begin
        If not bt_import.Enabled then
          bt_import.Enabled := (Copy(f_type,i,1)='C');
        If not bt_import.Enabled then
          bt_import.Enabled := (Copy(f_type,i,1)='X');
        if not bt_import_mdb.Enabled then
          bt_import_mdb.Enabled := (Copy(f_type,i,1)='W');
        if not btDevos.Enabled then
          btDevos.Enabled := (Copy(f_type,i,1)='D');

        if (Copy(f_type,i,1)='C') then
            ed_csv.FilterIndex := 1
        else if (Copy(f_type,i,1)='X') then
            ed_csv.FilterIndex := 2;

      //  if not edPDF.Enabled then
      //    edPDF.Enabled := (Copy(f_type,i,1)='P');
      end;

    ed_csv.Enabled := bt_import.Enabled;
    btLotes.Enabled := tiene_lotes;
    chPicking.Enabled := tiene_lotes;
  end; }
end;

function Tf_main_old.GetTotalCliente(cliente:Integer; out uds:integer):Double;
begin
   with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select sum(uds) as uds,sum(uds*tarifa) as total ' +
                       'from m_correos_reports r ' +
                       'where id_cliente=:cliente and fecha=:fecha and estado=''A'' ');
    ParamByName('cliente').AsInteger := cliente;
    ParamByName('fecha').AsDateTime := edFecha.Date;
    Open;

    if not(IsEmpty) then
    begin
        uds := FieldByName('uds').AsInteger;
        Result:=FieldByName('total').AsFloat;
    end
    else result:=0;

    Free;
  end;
end;

end.
