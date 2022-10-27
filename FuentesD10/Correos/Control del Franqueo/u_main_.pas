unit u_main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, XLSSheetData5, XLSReadWriteII5, sDialogs,
  sToolEdit, sSkinProvider, sSkinManager, Vcl.ImgList, Vcl.StdCtrls, sButton,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls, acImage, Vcl.Grids, sSpinEdit, sEdit,
  Vcl.Mask, sMaskEdit, sCustomComboEdit, sGroupBox, sLabel, Vcl.Buttons,
  sSpeedButton, sPanel, Vcl.ComCtrls, sPageControl, frxClass, frxDBSet, Data.DB,
  Datasnap.DBClient, pFIBDataSet, Vcl.DBGrids, acDBGrid, sCheckBox, psBarcode, frxBarcode,
  sStatusBar,Xc12Utils5, XLSFormattedObj5, XLSUtils5, Xc12DataStyleSheet5,
  Vcl.DBCtrls, sDBComboBox, sComboBox,Shlobj, System.Types, system.StrUtils;

type
  Tfmain = class(TForm)
    pg_1: TsPageControl;
    tsFranqueo: TsTabSheet;
    tsPaqueteria: TsTabSheet;
    pnFiltro: TsPanel;
    btGuardar: TsSpeedButton;
    btLimpiar: TsSpeedButton;
    btCancel: TsSpeedButton;
    rgProducto: TsRadioGroup;
    grData: TStringGrid;
    il1: TImageList;
    sknmngr1: TsSkinManager;
    sknprvdr1: TsSkinProvider;
    xls: TXLSReadWriteII5;
    ar_bonificacion: TClientDataSet;
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
    rep_db_bonificacion: TfrxDBDataset;
    repBonificacion: TfrxReport;
    pnCliente: TsPanel;
    btCliente: TsSpeedButton;
    lbCliente: TsLabel;
    btLock: TsSpeedButton;
    edCliente: TsEdit;
    bt2: TsButton;
    edIdCliente: TsSpinEdit;
    pnCECO: TsPanel;
    edCeco: TsEdit;
    bpCeco: TsSpeedButton;
    lbCeco: TsLabel;
    edIdCeco: TsSpinEdit;
    pnBts: TsPanel;
    btAdd: TsSpeedButton;
    btUpdate: TsSpeedButton;
    btDelete: TsSpeedButton;
    lbModo: TsLabel;
    btConsulta: TsSpeedButton;
    edFecha: TsDateEdit;
    lbLineas: TsLabel;
    gb1: TsGroupBox;
    chTodosCl: TsCheckBox;
    chTodosCC: TsCheckBox;
    edTXT: TsDirectoryEdit;
    btTXT: TsSpeedButton;
    grCertificadas: TsDBGrid;
    gbDetalle: TsGroupBox;
    edEmpresa: TsEdit;
    edDireccion: TsEdit;
    edLocalidad: TsEdit;
    edProvincia: TsEdit;
    edCP: TsEdit;
    edPais: TsEdit;
    edReferencia: TsEdit;
    edPeso: TsDecimalSpinEdit;
    rgSobre: TsRadioGroup;
    edAlto: TsDecimalSpinEdit;
    edAncho: TsDecimalSpinEdit;
    edLargo: TsDecimalSpinEdit;
    btCancelPaq: TsSpeedButton;
    btGuardaCert: TsSpeedButton;
    edIdCert: TsSpinEdit;
    rgProdCert: TsRadioGroup;
    rgPeso: TsRadioGroup;
    gbInformes: TsGroupBox;
    btXls: TsSpeedButton;
    btReport: TsSpeedButton;
    edFDesde: TsDateEdit;
    edFHasta: TsDateEdit;
    rgCliente: TsRadioGroup;
    rgCeco: TsRadioGroup;
    edXls: TsDirectoryEdit;
    rgTipo: TsRadioGroup;
    btCertif: TsSpeedButton;
    repCert: TfrxReport;
    rep_cert: TfrxDBDataset;
    btCP: TsSpeedButton;
    tsConfig: TsTabSheet;
    edCtoRmt: TsEdit;
    gb2: TsGroupBox;
    edMinCert: TsSpinEdit;
    edMaxCert: TsSpinEdit;
    rgZona: TsRadioGroup;
    bc: TpsBarcode;
    lbFrEnc: TsLabel;
    ar_resumen: TClientDataSet;
    rep_db_resumen: TfrxDBDataset;
    represumen: TfrxReport;
    intgrfld_resumenid_cliente1: TIntegerField;
    strngfld_resumennombre1: TStringField;
    strngfld_resumenceco: TStringField;
    strngfld_resumenfecha_desde1: TStringField;
    strngfld_resumenfecha_hasta1: TStringField;
    intgrfld_resumenuds_20: TIntegerField;
    intgrfld_resumenuds_50: TIntegerField;
    intgrfld_resumenuds_100: TIntegerField;
    intgrfld_resumenuds_500: TIntegerField;
    intgrfld_resumenuds_1000: TIntegerField;
    intgrfld_resumenuds_2000: TIntegerField;
    fltfld_resumenimp_20: TFloatField;
    fltfld_resumenimp_50: TFloatField;
    fltfld_resumenimp_100: TFloatField;
    fltfld_resumenimp_500: TFloatField;
    fltfld_resumenimp_1000: TFloatField;
    fltfld_resumenimp_2000: TFloatField;
    rep_db_detalle: TfrxDBDataset;
    ar_detalle: TClientDataSet;
    intgrfld1: TIntegerField;
    strngfld1: TStringField;
    strngfld2: TStringField;
    strngfld3: TStringField;
    strngfld4: TStringField;
    intgrfld2: TIntegerField;
    intgrfld3: TIntegerField;
    intgrfld4: TIntegerField;
    intgrfld5: TIntegerField;
    intgrfld6: TIntegerField;
    intgrfld7: TIntegerField;
    fltfld1: TFloatField;
    fltfld2: TFloatField;
    fltfld3: TFloatField;
    fltfld4: TFloatField;
    fltfld5: TFloatField;
    fltfld6: TFloatField;
    repDetalle: TfrxReport;
    gbTCliente: TsGroupBox;
    lb4: TsLabel;
    lb5: TsLabel;
    lb3: TsLabel;
    pnl1: TPanel;
    pnl2: TPanel;
    pnl3: TPanel;
    pnl4: TPanel;
    pnl5: TPanel;
    pnl6: TPanel;
    pnl7: TPanel;
    pnl8: TPanel;
    pnl9: TPanel;
    pnl10: TPanel;
    pnl11: TPanel;
    pnl12: TPanel;
    lb1: TsLabel;
    lb6: TsLabel;
    lb7: TsLabel;
    lb8: TsLabel;
    pnl13: TPanel;
    pnl14: TPanel;
    lb9: TsLabel;
    lb10: TsLabel;
    pnl15: TPanel;
    pnl16: TPanel;
    pnl17: TPanel;
    pnl18: TPanel;
    lbTClienteUds: TsLabel;
    lbTClienteImp: TsLabel;
    lbT20Uds: TsLabel;
    lbT50Imp: TsLabel;
    lbT50Uds: TsLabel;
    lbT100Imp: TsLabel;
    lbT20Imp: TsLabel;
    lbT500Uds: TsLabel;
    lbT1000Uds: TsLabel;
    lbT500Imp: TsLabel;
    lbT1000Imp: TsLabel;
    lbT2000Imp: TsLabel;
    lbT100Uds: TsLabel;
    lbT2000Uds: TsLabel;
    lb18: TsLabel;
    gb3: TsGroupBox;
    lbTotal: TsLabel;
    cbCP: TsComboBox;
    btCambiaCl: TsSpeedButton;
    pn1: TsPanel;
    gbClCambia: TsGroupBox;
    edClCambia: TsEdit;
    btClCambia: TsSpeedButton;
    lbClCambia: TsLabel;
    edIdClCambia: TsSpinEdit;
    ts1: TsTabSheet;
    gr1: TsDBGrid;
    gbRetorno: TsGroupBox;
    bt3: TsSpeedButton;
    ed_file: TsFilenameEdit;
    ed1: TsEdit;
    gb4: TsGroupBox;
    edFiltroEstado: TsEdit;
    chEstClTodos: TsCheckBox;
    chEstCCTodos: TsCheckBox;
    edEstFDesde: TsDateEdit;
    edEstFHasta: TsDateEdit;
    chEstFTodas: TsCheckBox;
    lbCertEstado: TsLabel;
    pn2: TsPanel;
    edFiltroTexto: TsEdit;
    bt1: TsSpeedButton;
    procedure bpCecoClick(Sender: TObject);
    procedure btLimpiarClick(Sender: TObject);
    procedure btReportClick(Sender: TObject);
    procedure btUpdateClick(Sender: TObject);
    procedure btConsultaClick(Sender: TObject);
    procedure btAddClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure btGuardarClick(Sender: TObject);
    procedure btClienteClick(Sender: TObject);
    procedure edClienteChange(Sender: TObject);
    procedure edCecoChange(Sender: TObject);
    procedure edFechaChange(Sender: TObject);
    procedure edFechaClick(Sender: TObject);
    procedure btLockClick(Sender: TObject);
    procedure btXlsClick(Sender: TObject);
    procedure rgClienteChange(Sender: TObject);
    procedure rgProductoChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pg_1Change(Sender: TObject);
    procedure btGuardaCertClick(Sender: TObject);
    procedure grCertificadasCellClick(Column: TColumn);
    procedure btCancelPaqClick(Sender: TObject);
    procedure rgSobreChange(Sender: TObject);
    procedure grCertificadasAfterScroll(Sender: TObject; ScrollBar: Cardinal);
    procedure btTXTClick(Sender: TObject);
    procedure btCertifClick(Sender: TObject);
    procedure btCPClick(Sender: TObject);
    procedure lbFrRestClick(Sender: TObject);
    procedure rgProdCertClick(Sender: TObject);
    procedure edCPExit(Sender: TObject);
    procedure sknprvdr1AfterAnimation(AnimType: TacAnimEvent);
    procedure rgZonaChange(Sender: TObject);
    procedure rgZonaClick(Sender: TObject);
    procedure rgPesoClick(Sender: TObject);
    procedure btDeleteClick(Sender: TObject);
    procedure grDataKeyPress(Sender: TObject; var Key: Char);
    procedure cbCPClick(Sender: TObject);
    procedure rgTipoClick(Sender: TObject);
    procedure btCambiaClClick(Sender: TObject);
    procedure btClCambiaClick(Sender: TObject);
    procedure bt3Click(Sender: TObject);
    procedure chEstFTodasClick(Sender: TObject);
    procedure edFiltroEstadoChange(Sender: TObject);
    procedure chEstClTodosClick(Sender: TObject);
    procedure chEstCCTodosClick(Sender: TObject);
    procedure edEstFDesdeChange(Sender: TObject);
    procedure edEstFHastaChange(Sender: TObject);
    procedure rgEstOrdenChange(Sender: TObject);
    procedure gr1TitleClick(Column: TColumn);
    procedure edFiltroTextoChange(Sender: TObject);
    procedure bt1Click(Sender: TObject);
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
    procedure ReportBonificacion;
    procedure ReportResumen;
    procedure XLSResumen;
    procedure XLSBonificacion;
    procedure XLSDetalle;
    procedure XLSDestinatarios;
    function RellenaCabecerasDetalle(fila:Integer):integer;
    function RellenaCabecerasDestinatarios(fila:integer):integer;
    function RellenaCabecerasResumen(col,fila:Integer):integer;
    procedure RellenaCabecerasBonificacion(fila:Integer);
    function BuscaFranqueoPorFechas(cliente, ceco, peso, producto, zona:integer; f1,f2:TDateTime; out importe:Double):Integer;
    function BuscaFranqueo(cliente, ceco, peso, producto, zona:integer; fecha:TDateTime):Integer;
    function ExisteFranqueo(cliente, ceco, peso, producto, zona:integer; fecha:TDateTime; out uds:Integer):Integer;
    function ExisteEstado(id:integer; fecha:TDateTime; estado: string):Integer;
    procedure AddFranqueo(cliente, ceco, peso, producto, zona, cantidad, suma:integer; fecha:TDateTime);
    function BuscaTarifa(cliente, ceco, peso, producto, zona:integer):Double;
    procedure HabilitaDatos(habilitar:Boolean);
    function GetTotalCliente(cliente:Integer; out uds:integer):Double;
    function GetTotalClientePeso(cliente, peso:Integer; out uds:integer):Double;
    function CreaTXT:string;
    procedure filter_certificadas;
    procedure filter_estados;
    procedure VaciaCertificada;
    procedure GetMedidasSobre;
    procedure ActualizaLogFile(ids,nombre:string);
    function CalculaBarcode:string;
    function CalculaCol(peso:Integer):integer;
    procedure RellenaComboCP(cp:string);
    function SpecialFolder(Folder: Integer): String;
    function BuscaId(ref:string):integer;
  public
    { Public declarations }
    procedure RellenaCertificada;
    procedure GetCertEstado(id:Integer);
  end;

var
  fmain: Tfmain;
  locked:Boolean=True;
  modo: Integer=0; //0-consulta 1-edición 2-inserción
  txt: TextFile;
  col_estado: integer;

const
    tab = #9;
    bc_ini = 3247512001;
    bc_fin = 3247512500;

implementation

uses
  ubuscapro, u_dm, u_globals, ubuscapro_ss;

{$R *.dfm}

{$REGION 'INTERFAZ'}

procedure Tfmain.FormCreate(Sender: TObject);
begin
  //u_globals.leer_ini;

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

  edTXT.Text := SpecialFolder(CSIDL_DESKTOP);
  edXls.Text := SpecialFolder(CSIDL_DESKTOP);

  lbModo.Caption := '';
  lbTotal.Caption := '';
  modo := 0;

  pg_1.ActivePageIndex := 0;
  Width := 1178;
  Height := 698;

  filter_estados;

end;

function Tfmain.SpecialFolder(Folder: Integer): String;
var
  SFolder : pItemIDList;
  SpecialPath : Array[0..MAX_PATH] Of Char;
begin
  SHGetSpecialFolderLocation(fmain.Handle, Folder, SFolder);
  SHGetPathFromIDList(SFolder, SpecialPath);
  Result := StrPas(SpecialPath);
end;

procedure Tfmain.CargaInterfaz;
var
  f_type, order_ok: string;
  i, uds: integer;
  total : Double;
  stream: TStream;
begin
  btLock.ImageIndex := Integer(locked);
  //edCliente.Enabled := not locked;
  //btCliente.Enabled := not locked;
  pnFiltro.Enabled := locked;
  pnCECO.Enabled := locked;
  //grData.Enabled := locked;
  //btGuardar.Enabled := locked;
  if pg_1.ActivePageIndex = 1 then
      pnBts.Enabled := locked
  else
      pnBts.Enabled := False;

  lbCeco.Caption := '(Seleccione un CECO válido)';
  rgCeco.Items.Strings[1] := 'CECO por seleccionar';
  edCeco.Text := '';
  lbTotal.Caption := '';

 // if modo=0 then
 // begin
      filter;
      filter_certificadas;
      filter_estados;
 // end;

  if locked then
  begin
      uds := 0;
      total := GetTotalCliente(StrToInt(edIdCliente.Text),uds);
      lbTClienteUds.Caption := IntToStr(uds);
      lbTClienteImp.Caption := formatfloat('#,##0.00', total);
      total := GetTotalClientePeso(StrToInt(edIdCliente.Text),20,uds);
      lbT20Uds.Caption := IntToStr(uds);
      lbT20Imp.Caption := formatfloat('#,##0.00', total);
      total := GetTotalClientePeso(StrToInt(edIdCliente.Text),50,uds);
      lbT50Uds.Caption := IntToStr(uds);
      lbT50Imp.Caption := formatfloat('#,##0.00', total);
      total := GetTotalClientePeso(StrToInt(edIdCliente.Text),100,uds);
      lbT100Uds.Caption := IntToStr(uds);
      lbT100Imp.Caption := formatfloat('#,##0.00', total);
      total := GetTotalClientePeso(StrToInt(edIdCliente.Text),500,uds);
      lbT500Uds.Caption := IntToStr(uds);
      lbT500Imp.Caption := formatfloat('#,##0.00', total);
      total := GetTotalClientePeso(StrToInt(edIdCliente.Text),1000,uds);
      lbT1000Uds.Caption := IntToStr(uds);
      lbT1000Imp.Caption := formatfloat('#,##0.00', total);
      total := GetTotalClientePeso(StrToInt(edIdCliente.Text),2000,uds);
      lbT2000Uds.Caption := IntToStr(uds);
      lbT2000Imp.Caption := formatfloat('#,##0.00', total);
  end else begin
         lbTClienteUds.Caption := '0';
         lbTClienteImp.Caption := '0,00';
         lbT20Uds.Caption := '0';
         lbT20Imp.Caption := '0,00';
         lbT50Uds.Caption := '0';
         lbT50Imp.Caption := '0,00';
         lbT100Uds.Caption := '0';
         lbT100Imp.Caption := '0,00';
         lbT500Uds.Caption := '0';
         lbT500Imp.Caption := '0,00';
         lbT1000Uds.Caption := '0';
         lbT1000Imp.Caption := '0,00';
         lbT2000Uds.Caption := '0';
         lbT2000Imp.Caption := '0,00';
  end;


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

procedure Tfmain.cbCPClick(Sender: TObject);
begin
  edProvincia.Text := String(cbCP.Items.Objects[cbCP.ItemIndex]);
end;

procedure Tfmain.chEstCCTodosClick(Sender: TObject);
begin
   filter_estados;
end;

procedure Tfmain.chEstClTodosClick(Sender: TObject);
begin
  filter_estados;
end;

procedure Tfmain.chEstFTodasClick(Sender: TObject);
begin
    edEstFDesde.Enabled := not chEstFTodas.Checked;
    edEstFHasta.Enabled := not chEstFTodas.Checked;
    filter_estados;
end;

procedure Tfmain.pg_1Change(Sender: TObject);
begin
  case pg_1.ActivePageIndex of
     0: begin
          fmain.Width := 1178;
          fmain.Height := 698;
          pnBts.Enabled := False;
          btAdd.Grayed := True;
          btDelete.Grayed := True;
          btUpdate.Grayed := True;
        end;
     1: begin
          fmain.Width := 1603;
          fmain.Height := 856;
          pnBts.Enabled := locked;
          btAdd.Grayed := False;
          btDelete.Grayed := False;
          btUpdate.Grayed := False;
        end;
     2: begin
          fmain.Width := 1152;
          fmain.Height := 856;
          pnBts.Enabled := False;
          btAdd.Grayed := True;
          btDelete.Grayed := True;
          btUpdate.Grayed := True;
        end;
  end;
end;

procedure Tfmain.HabilitaDatos(habilitar:Boolean);
begin
 { grData.Enabled := habilitar;
  btLimpiar.Enabled := habilitar;
  btGuardar.Enabled := habilitar;
  btCancel.Enabled := habilitar;  }
  btLock.Enabled := not habilitar;
  //btConsulta.Enabled := not habilitar;

  grCertificadas.Enabled := not habilitar;
  gbDetalle.Enabled := habilitar;
  btCambiaCl.Enabled := habilitar;
  //btGuardaCert.Enabled := habilitar;
  //btCancelPaq.Enabled := habilitar;

  btAdd.Enabled := not habilitar;
  btDelete.Enabled := not habilitar;
  btUpdate.Enabled := not habilitar;


 { rgProdCert.Enabled := habilitar;
  rgPeso.Enabled := habilitar;
  rgZona.Enabled := habilitar;    }

end;

procedure Tfmain.bpCecoClick(Sender: TObject);
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
        if modo=0 then
        begin
          filter;
          filter_certificadas;
          if not chEstCCTodos.Checked then
            filter_estados;
        end;
      end;
    end;
  end;

end;

procedure Tfmain.btUpdateClick(Sender: TObject);
begin
  if not (edIdCert.Value>0) then
     raise Exception.Create('No existe registro a modificar.');

  HabilitaDatos(true);
  btAdd.Enabled := False;
  btDelete.Enabled := False;
  btUpdate.Enabled := False;
  btLimpiar.Enabled := False;
  lbModo.Caption := 'Modificando registro ...';

  modo := 1;
end;


procedure Tfmain.btConsultaClick(Sender: TObject);
begin
  modo := 0;
  HabilitaDatos(false);
  btAdd.Visible := True;
  btUpdate.Visible := True;
  btAdd.Enabled := True;
  btUpdate.Enabled := True;
  lbModo.Caption := '';
  grCertificadas.Enabled := True;

  rgProducto.Items.Clear;
  rgProducto.Items.Add('Ordinarias');
  rgProducto.Items.Add('Certificadas');
  rgProducto.Items.Add('Cert. con A.R.');
  rgProducto.ItemIndex := 0;

  filter;
  filter_certificadas;
  filter_estados;
end;


procedure Tfmain.btCPClick(Sender: TObject);
begin
  with fbuscapro_ss do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    titulos.commatext:='C.Postal, Localidad, Provincia';
    fields.commatext:='l.codigo_postal,l.titulo,p.titulo ';
    from:='sys_localidades l inner join sys_provincias p on p.provincia=l.provincia and p.pais=l.pais ';
    where:='';
    orden[1]:=1;  busca:=1;   distinct:=0;   fillimpio:=True;   row_height:=17;

    showmodal;

    if resultado then begin
      with Sender as TsSpeedButton do begin
        edCP.Text:=valor[1];
        edLocalidad.Text:=valor[2];
        edProvincia.Text := valor[3];
      end;
    end;
  end;
end;


procedure Tfmain.RellenaComboCP(cp: string);
begin
    with dm.qCP do
      begin
           Close;
           ParamByName('cp').AsString := cp;
           Open;
           First;

           cbCP.Clear;
           while not eof do
           begin
             cbCP.AddItem(FieldByName('titulo').AsString,TObject(FieldByName('titulo1').AsString));
             Next;
           end;
           cbCP.ItemIndex := 0;
           edProvincia.Text := String(cbCP.Items.Objects[cbCP.ItemIndex]);
      end;
end;

procedure Tfmain.btDeleteClick(Sender: TObject);
begin
  if dm.qfiltro_certif.IsEmpty then
    raise Exception.Create('No existen registros a eliminar.');

  if edIdCert.Value<=0 then
    raise Exception.Create('Debe seleccionar un registro.');

  if MessageDlg('Va a eliminar el registro seleccionado, ¿desea continuar?',mtWarning,mbYesNo,mrNo)=mrYes then
  begin
      with dm.q_1 do
      begin
        try
           dm.t_write.StartTransaction;

           Close;
           SQL.Clear;
           sql.add('update m_correos_certificadas set ' +
                   'estado=:estado ' +
                   'where id_correos_certificadas=:id_correos_certificada');

           ParamByName('id_correos_certificada').asinteger := edIdCert.Value;
           ParamByName('estado').AsString := 'B';

           ExecQuery;

           dm.t_write.CommitRetaining;
           filter;
           filter_certificadas;
           filter_estados;
           ShowMessage('Registro eliminado correctamente.');
        except
           dm.t_write.RollbackRetaining;
           ShowMessage('Error al eliminar el registro seleccionado.');
        end;
      end;
  end;
end;

procedure Tfmain.bt1Click(Sender: TObject);
begin
  pg_1.ActivePageIndex := 2;
end;

procedure Tfmain.bt3Click(Sender: TObject);
var
  fic: TStringList;
  str_dyn:TStringDynArray;
  n,i, id: integer;
  fecha: string;
begin
  if FileExists(ed_file.filename) then begin
    fic:=tstringlist.create();
    fic.LoadFromFile(ed_file.filename);

    n:=0;

    try

      for i:=0 to fic.Count-1 do begin

        str_dyn:=splitstring(fic[i],#9);

        fecha := Copy(Trim(str_dyn[6]),7,2) + '/' + Copy(Trim(str_dyn[6]),5,2) + '/' + Copy(Trim(str_dyn[6]),0,4);
        id := BuscaId(str_dyn[3]);

        if (id>0) and (ExisteEstado(id,StrToDateTime(fecha + ' ' + str_dyn[7]),str_dyn[5])=-1) then
        begin              //new cabecera

          dm.t_write.StartTransaction;
          dm.q_1.Close;
          dm.q_1.sql.Clear;
          dm.q_1.sql.Add('insert into m_correos_certificadas_estados '+
            '(id_correos_certificada, referencia, fecha, estado, linea) '+
            'values (:id_correos_certificada, :referencia, :fecha, :estado, :linea)');
          dm.q_1.ParamByName('id_correos_certificada').AsInteger:=id;
          dm.q_1.ParamByName('referencia').AsString:= Copy(str_dyn[3],0,Pos('*',str_dyn[3])-2);
          dm.q_1.ParamByName('fecha').AsDateTime := StrToDateTime(fecha + ' ' + str_dyn[7]);
          dm.q_1.ParamByName('estado').asstring:=str_dyn[5];
          dm.q_1.ParamByName('linea').asstring:= fic[i];
          dm.q_1.ExecQuery;

          dm.t_write.Commit;

          Inc(n);
        end;
       end;

    except
      on ed_file:Exception do begin
        sMessageDlg('Error Importando Fichero '+ed_file.message, mtError,[mbok],0);
        dm.t_write.Rollback;
        exit;
      end;
    end;

    ShowMessage('Importación Finalizada Correctamente. Actualizado/s ' + IntToStr(n) + ' estado/s.');
    //filter_certificadas;
  end;
end;


function Tfmain.ExisteEstado(id:integer; fecha:TDateTime; estado:string):Integer;
begin
  result  := -1;
   with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select id_correos_cert_estado from m_correos_certificadas_estados ' +
                       'where id_correos_certificada=:id and fecha=:fecha and ' +
                       'estado=:estado');
    ParamByName('id').AsInteger := id;
    ParamByName('fecha').AsDateTime := fecha;
    ParamByName('estado').AsString := estado;
    Open;

    if not(IsEmpty) then
    begin
      Result :=FieldByName('id_correos_cert_estado').AsInteger;
    end;

    Free;
  end;
end;

function Tfmain.BuscaId(ref: string):Integer;
var
  i: integer;
  id: string;
begin
   Result := -1;
   if Pos('*',ref)>0 then
     for i := Pos('*',ref)+1 to Length(ref) do
        if (Copy(ref,i,1)='*') then
        begin
            Result := StrToIntDef(id,-1);
            Exit;
        end
        else
            id := id + Copy(ref,i,1);
end;

procedure Tfmain.btAddClick(Sender: TObject);
begin
  HabilitaDatos(true);
  btUpdate.Enabled := False;
  btAdd.Enabled := False;
  btDelete.Enabled := False;
  lbModo.Caption := 'Insertando nuevo registro ...';

  //btLimpiarClick(Self);
  VaciaCertificada;
  grCertificadas.Enabled := False;

  modo := 2;

//  rgProducto.Items.Clear;
//  rgProducto.Items.Add('Ordinarias');
//  rgProducto.ItemIndex := 0;
end;

procedure Tfmain.btCambiaClClick(Sender: TObject);
begin
  gbClCambia.Visible := not gbClCambia.Visible;
end;

procedure Tfmain.btCancelClick(Sender: TObject);
begin
  HabilitaDatos(false);
  filter;
end;


procedure Tfmain.btCancelPaqClick(Sender: TObject);
var
  id:integer;
begin
   id := dm.qfiltro_certif.FieldByName('id_correos_certificadas').AsInteger;
   filter_certificadas;
   HabilitaDatos(false);
   if not  dm.qfiltro_certif.IsEmpty then
   begin
     dm.qfiltro_certif.Locate('id_correos_certificadas',id,[]);
     RellenaCertificada;
   end;
   modo := 0;
   lbModo.Caption := '';

   filter_estados;
end;

procedure Tfmain.btCertifClick(Sender: TObject);
begin
  if ((not chTodosCl.Checked) and ( not (edIdCliente.Value>0))) then
      raise Exception.Create('Debe indicar un cliente o seleccionar todos.');

  if ((not chTodosCC.Checked) and ( not (edIdCeco.Value>0))) then
      raise Exception.Create('Debe indicar un CECO o seleccionar todos.');

  try
    with dm.qRepCert do
    begin
      Close;
      SelectSQL.Clear;
      SelectSQL.Add('select c.*, cl.codigo as cod_cli, cc.codigo as ceco ' +
                    'from mv_correos_certificadas c ' +
                    'inner join g_clientes cl on cl.id_cliente=c.id_cliente ' +
                    'inner join g_clientes_cecos cc on cc.id_cliente_ceco=c.id_ceco ' +
                    'where c.barcode<>'''' and c.fecha=:fecha ' +
                    'and c.id_cliente in (460877) ');   //Solo Santa Lucia

      if not chTodosCl.checked then
           SelectSQL.Add(' and id_cliente=' + edIdcliente.Text);
      if not chTodosCC.Checked then
           SelectSQL.Add(' and id_ceco=' + edIdCeco.Text);

      ParamByName('fecha').AsDate := edFecha.Date;
      Open;

      If not IsEmpty then
      begin
        if repCert.PrepareReport then repCert.ShowPreparedReport;
      end else
            showmessage('No existen datos a mostrar.');
    end;

  except
      on e:Exception do
          ShowMessage('Error al crear fichero. ' + e.Message);
  end;


end;

procedure Tfmain.btClCambiaClick(Sender: TObject);
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
        edClCambia.text:=valor[1];
        lbClCambia.caption:=valor[2];
        edIdClCambia.Value :=  valor[3];
        //filter;
      end;
    end;
  end;

  btLock.Enabled := (lbCliente.Caption<>'(Seleccione un cliente)');
end;

procedure Tfmain.btClienteClick(Sender: TObject);
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
        if modo=0 then
        begin
          filter;
          filter_certificadas;
          if not chEstClTodos.Checked then
              filter_estados;
        end;
        end;
    end;
  end;

  btLock.Enabled := (lbCliente.Caption<>'(Seleccione un cliente)');
  btLockClick(self);
end;

procedure Tfmain.btGuardaCertClick(Sender: TObject);
var
  producto, zona, id, id_actual: integer;
begin
 // if ((modo=2) or (modo=1)) then
 // begin
     { if (modo=1) and (edIdCert.Text='') then
         raise Exception.Create('No existe registro a guardar.');  }
      if edIdCliente.Value<=0 then
        raise Exception.Create('Cliente Inválido');

      if edIdCeco.Value<=0 then
        raise Exception.Create('CECO Inválido');

      if edEmpresa.Text='' then
        raise Exception.Create('Dato Empresa Vacío.');

      if edDireccion.Text='' then
        raise Exception.Create('Dato Dirección Vacío.');

      if edLocalidad.Text='' then
        raise Exception.Create('Dato Localidad Vacío.');

      if edProvincia.Text='' then
        raise Exception.Create('Dato Provincia Vacío.');

      if edCP.Text='' then
        raise Exception.Create('Dato C. Postal Vacío.');

      if edPais.Text='' then
        raise Exception.Create('Dato Pais Vacío.');

      with dm.q_1 do
      begin
        try
           dm.t_write.StartTransaction;

           Close;
           SQL.Clear;

           if modo=2 then
               sql.add('insert into m_correos_certificadas ' +
                       '(id_cliente, id_ceco, id_producto, fecha, empresa, direccion, ' +
                       'localidad, provincia, cp, pais, referencia, peso, alto, ancho, largo, idx_sobre, ' +
                       'barcode, acuse, tipo, cto_rmt, id_zona) values ' +
                       '(:cliente, :ceco, :producto, :fecha, :empresa, :direccion, :localidad, :provincia, ' +
                       ':cp, :pais, :referencia, :peso, :alto, :ancho, :largo, :idx_sobre, ' +
                       ':barcode, :acuse , :tipo, :cto_rmt, :zona) returning id_correos_certificadas')
           else
               sql.add('update m_correos_certificadas set ' +
                     'id_cliente=:cliente, id_ceco=:ceco, id_producto=:producto, fecha=:fecha, empresa=:empresa, ' +
                     'direccion=:direccion, localidad=:localidad, provincia=:provincia, ' +
                     'cp=:cp, pais=:pais, referencia=:referencia, peso=:peso, alto=:alto, ' +
                     'ancho=:ancho, largo=:largo, idx_sobre=:idx_sobre, acuse=:acuse, tipo=:tipo, ' +
                     'cto_rmt=:cto_rmt, id_zona=:zona ' +
                     'where id_correos_certificadas=:id_correos_certificadas');

           ParamByName('cliente').asinteger := edIdCliente.Value;
           ParamByName('fecha').AsDateTime := edFecha.Date;
           ParamByName('ceco').asinteger := edIdCeco.Value;

           case rgProdCert.ItemIndex of
              0: begin
                  producto := 240;
                  ParamByName('producto').asinteger := 240;
                  ParamByName('acuse').AsString := '';
                 end;
              1: begin
                  producto := 325;
                  ParamByName('producto').asinteger := 325;
                  ParamByName('acuse').asstring:= 'A/R';
                 end;
           end;

           case rgZona.ItemIndex of
            0: zona := 1;     //Nacional
            1: zona := 4;     //Nacional D1
            2: zona := 5;     //Nacional D2
            3: zona := 2;     //Int. Europa
            4: zona := 3;     //Int. Resto
            end;
           ParamByName('zona').asinteger := zona;

           ParamByName('empresa').AsString := edEmpresa.Text;
           ParamByName('direccion').AsString := edDireccion.Text;
           ParamByName('localidad').AsString := edLocalidad.Text;
           ParamByName('provincia').AsString := edProvincia.Text;
           ParamByName('cp').AsString := edCP.Text;
           ParamByName('pais').AsString := edPais.Text;
           ParamByName('referencia').AsString := edReferencia.Text;
           ParamByName('cto_rmt').AsString := edCtoRmt.Text;
           ParamByName('peso').AsInteger := StrToInt(rgPeso.Items[rgPeso.ItemIndex]);
           ParamByName('alto').AsFloat := edAlto.Value;
           ParamByName('ancho').AsFloat := edAncho.Value;
           ParamByName('largo').AsFloat := edLargo.Value;
           ParamByName('idx_sobre').asinteger := rgSobre.ItemIndex;
           if (modo=2) then
              if (edCliente.Text='3203') then
                ParamByName('barcode').AsString := 'CD' + CalculaBarcode
              else
                ParamByName('barcode').AsString := '';

           case StrToInt(edCliente.Text) of
              3203: ParamByName('tipo').AsString := 'C';
              else ParamByName('tipo').AsString := 'P';
           end;

           if modo<>2 then
              ParamByName('id_correos_certificadas').AsInteger := edIdCert.Value;
           execquery;

           if modo<>2 then
                id_actual := edIdCert.Value
           else
                id_actual := FieldByName('id_correos_certificadas').AsInteger;

          dm.t_write.CommitRetaining;

         { if modo=1 then   //editando
          begin      }
              //HabilitaDatos(false);
              filter;
              filter_certificadas;
              filter_estados;
              dm.qfiltro_certif.Locate('id_correos_certificadas',id_actual,[]);
              RellenaCertificada;
         { end
          else if modo=2 then begin   //insertando, borramos para seguir con otro CECO

              //Si ya existe franqueo en la bbdd con estos criterios se modificará, sino, se insertará un nuevo registro
              AddFranqueo(StrToInt(edIdCliente.Text),
                          StrToInt(edIdCeco.Text),
                          StrToInt(edPeso.Text),
                          producto,
                          zona,
                          1,0,
                          edFecha.Date);

              lbFrEnc.Caption := 'Encontrado ' +  IntToStr(BuscaFranqueo(edIdCliente.Value,edIdCeco.Value,StrToInt(rgPeso.Items[rgPeso.ItemIndex]),
                                                   producto, zona, edFecha.Date)) + ' franqueos.';

              VaciaCertificada;
              dm.qfiltro_certif.Close;
              dm.qfiltro_certif.Open;

              edEmpresa.SetFocus;
          end;     }
          modo := 0;
          lbModo.Caption := '';
          ShowMessage('Datos guardados correctamente.');
          HabilitaDatos(false);
        except
           dm.t_write.RollbackRetaining;
           ShowMessage('Error al guardar datos.');
        end;
      end;
 // end;
end;

procedure Tfmain.btGuardarClick(Sender: TObject);
var
  x, y, total, uds, producto, zona, id: integer;
  total_cl: Double;
begin
    if edIdCeco.Value<=0 then
    raise Exception.Create('CECO Inválido');

    with dm.q_1 do
    begin
      try
         dm.t_write.StartTransaction;

         SQL.Clear;

        total := 0;

        case rgProducto.ItemIndex of
                      0: producto := 239;   //Carta Ordinaria
                      1: producto := 240;   //Carta Certificada
                      2: producto := 325;   //Carta Certificada con AR
        end;

        for x := 1 to grData.RowCount-1 do
          for y := 1 to grData.ColCount-1 do
          begin
               case x of
                    1: zona := 1;     //Nacional
                    2: zona := 4;     //Nacional D1
                    3: zona := 5;     //Nacional D2
                    4: zona := 2;     //Int. Europa
                    5: zona := 3;     //Int. Resto
               end;

               id := ExisteFranqueo(edIdCliente.Value,edIdCeco.Value,StrToInt(grData.Cells[y,0]),producto,zona,edFecha.Date,uds);
               sql.Clear;
               if id>0 then
                    sql.add('update m_correos_reports set uds=:uds ' +
                   'where id_correos_report=:id')
               else
                    sql.add('insert into m_correos_reports (id_cliente, fecha, id_ceco, id_producto, id_zona, peso, uds) values ' +
                   '(:cliente, :fecha, :ceco, :producto, :zona, :peso, :uds)');

               if ((grData.Cells[y,x]<>'')  or ((grData.Cells[y,x]='') and (id>0))) then
               begin
                   Close;

                   if id>0 then
                       ParamByName('id').asinteger := id
                   else begin
                       ParamByName('cliente').asinteger := edIdCliente.Value;
                       ParamByName('fecha').AsDateTime := edFecha.Date;
                       ParamByName('ceco').asinteger := edIdCeco.Value;
                       ParamByName('producto').asinteger := producto;
                       ParamByName('zona').asinteger := zona;
                       ParamByName('peso').asinteger := StrToInt(grData.Cells[y,0]);
                   end;

                   if grData.Cells[y,x]='' then
                       ParamByName('uds').asinteger := 0
                   else
                       ParamByName('uds').asinteger := StrToInt(grData.Cells[y,x]);
                   execquery;

                   if grData.Cells[y,x]<>'' then
                      total := total + StrToInt(grData.Cells[y,x]);
               end;
          end;

        dm.t_write.CommitRetaining;
        ShowMessage('Datos guardados correctamente.');

      {  if modo=1 then   //editando
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
                  filter;     }
                  edCeco.SetFocus;

                  //bpCeco.Click;
                  uds := 0;
                  total_cl := GetTotalCliente(StrToInt(edIdCliente.Text),uds);
                  lbTClienteUds.Caption := IntToStr(uds);
                  lbTClienteImp.Caption := formatfloat('#,##0.00', total_cl);
                  total_cl := GetTotalClientePeso(StrToInt(edIdCliente.Text),20,uds);
                  lbT20Uds.Caption := IntToStr(uds);
                  lbT20Imp.Caption := formatfloat('#,##0.00', total_cl);
                  total_cl := GetTotalClientePeso(StrToInt(edIdCliente.Text),50,uds);
                  lbT50Uds.Caption := IntToStr(uds);
                  lbT50Imp.Caption := formatfloat('#,##0.00', total_cl);
                  total_cl := GetTotalClientePeso(StrToInt(edIdCliente.Text),100,uds);
                  lbT100Uds.Caption := IntToStr(uds);
                  lbT100Imp.Caption := formatfloat('#,##0.00', total_cl);
                  total_cl := GetTotalClientePeso(StrToInt(edIdCliente.Text),500,uds);
                  lbT500Uds.Caption := IntToStr(uds);
                  lbT500Imp.Caption := formatfloat('#,##0.00', total_cl);
                  total_cl := GetTotalClientePeso(StrToInt(edIdCliente.Text),1000,uds);
                  lbT1000Uds.Caption := IntToStr(uds);
                  lbT1000Imp.Caption := formatfloat('#,##0.00', total_cl);
                  total_cl := GetTotalClientePeso(StrToInt(edIdCliente.Text),2000,uds);
                  lbT2000Uds.Caption := IntToStr(uds);
                  lbT2000Imp.Caption := formatfloat('#,##0.00', total_cl);
       // end;

      except
         dm.t_write.RollbackRetaining;
         ShowMessage('Error al guardar datos.');
      end;
    end;
end;


procedure Tfmain.edCecoChange(Sender: TObject);
begin
   If edCeco.Text<>'' then
     begin
        lbCeco.Caption := BuscaCeco(edCeco.Text);
        rgCeco.Items.Strings[1] := lbCeco.Caption;
        edIdCeco.Value := BuscaCecoId(edCeco.Text);
        if modo=0 then
        begin
          filter;
          filter_certificadas;
          if not chEstCCTodos.Checked then
            filter_estados;
        end;
     end;

     if lbCeco.Caption='' then
     begin
         lbCeco.Caption := '(Seleccione un CECO válido)';
         rgCeco.Items.Strings[1] := 'CECO por seleccionar';
     end;
end;


procedure Tfmain.edClienteChange(Sender: TObject);
begin
  If edCliente.Text<>'' then
     begin
        lbCliente.Caption := BuscaCliente(edCliente.Text);
        rgCliente.Items.Strings[1] := lbCliente.Caption;
        edIdCliente.Value := BuscaClienteId(edCliente.Text);
        btLockClick(self);
        if modo=0 then
        begin
          filter;
          filter_certificadas;
          if not chEstClTodos.Checked then
              filter_estados;
        end;
        //filter;
     end;

     if lbCliente.Caption='' then
     begin
               lbCliente.Caption := '(Seleccione un cliente)';
               rgCliente.Items.Strings[1] := 'Cliente por seleccionar';
     end;

  btLock.Enabled := (lbCliente.Caption<>'(Seleccione un cliente)');

end;


procedure Tfmain.edCPExit(Sender: TObject);
begin
  //  RellenaComboCP(edCP.Text);

   with fbuscapro_ss do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    titulos.commatext:='C.Postal, Localidad, Provincia';
    fields.commatext:='l.codigo_postal,l.titulo,p.titulo ';
    from:='sys_localidades l inner join sys_provincias p on p.provincia=l.provincia and p.pais=l.pais ';
    where:='';
    orden[1]:=1;  busca:=2;   distinct:=0;   fillimpio:=True;   row_height:=17;

    showmodal;

    if resultado then begin
      with Sender as TsSpeedButton do begin
        edCP.Text:=valor[1];
        edLocalidad.Text:=valor[2];
        edProvincia.Text := valor[3];
      end;
    end;
  end;
end;

procedure Tfmain.edEstFDesdeChange(Sender: TObject);
begin
 filter_estados;
end;

procedure Tfmain.edEstFHastaChange(Sender: TObject);
begin
  filter_estados;
end;

procedure Tfmain.edFechaChange(Sender: TObject);
begin
  if modo=0 then
  begin
    filter;
    filter_certificadas;
    if not chEstFTodas.Checked then
        filter_estados;
  end;
end;


procedure Tfmain.edFechaClick(Sender: TObject);
begin
  if modo=0 then
  begin
    filter;
    filter_certificadas;
    if not chEstFTodas.Checked then
        filter_estados;
  end;
end;

procedure Tfmain.edFiltroEstadoChange(Sender: TObject);
begin
  filter_estados;
end;

procedure Tfmain.edFiltroTextoChange(Sender: TObject);
begin
  if modo=0 then
  begin
    filter_certificadas;
    filter_estados;
  end;
end;

procedure Tfmain.btLockClick(Sender: TObject);
begin
  //locked := not locked;

 { if locked then
  begin
    lbCliente.Font.Color := 16;
    //CargaInterfaz;

    //filter;
  end
  else begin
        lbCliente.Font.Color := 255;
        //edCliente.SetFocus;
        //dm.q_peds.Close;
       end;   }

  CargaInterfaz;
end;

procedure Tfmain.btLimpiarClick(Sender: TObject);
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

procedure Tfmain.rgClienteChange(Sender: TObject);
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

              fila_tit := RellenaCabecerasDetalle(fila);
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

procedure Tfmain.rgEstOrdenChange(Sender: TObject);
begin
    filter_estados;
end;

procedure Tfmain.rgPesoClick(Sender: TObject);
begin
  edPeso.Value := StrToFloat(rgPeso.Items[rgPeso.ItemIndex]);
  if modo=0 then
     filter_certificadas;
end;

procedure Tfmain.rgProdCertClick(Sender: TObject);
var
    producto, zona:Integer;
begin
  lbFrEnc.Caption := 'Encontrado ' +  IntToStr(BuscaFranqueo(edIdCliente.Value,edIdCeco.Value,StrToInt(rgPeso.Items[rgPeso.ItemIndex]),
                                                   producto, zona, edFecha.Date)) + ' franqueos.';
  if modo=0 then
     filter_certificadas;
end;

procedure Tfmain.rgProductoChange(Sender: TObject);
begin
  btLimpiar.Enabled := (rgProducto.ItemIndex=0);
  btGuardar.Enabled := (rgProducto.ItemIndex=0);
  btCancel.Enabled :=  (rgProducto.ItemIndex=0);
  filter;
end;

procedure Tfmain.rgSobreChange(Sender: TObject);
begin
  GetMedidasSobre;
end;

procedure Tfmain.rgTipoClick(Sender: TObject);
begin
  btReport.Enabled := not (rgTipo.ItemIndex=4);

end;

procedure Tfmain.rgZonaChange(Sender: TObject);
begin
  if modo=0 then
     filter_certificadas;
end;

procedure Tfmain.rgZonaClick(Sender: TObject);
begin
  if modo=0 then
     filter_certificadas;
end;

procedure Tfmain.sknprvdr1AfterAnimation(AnimType: TacAnimEvent);
begin

end;

{$ENDREGION 'INTERFAZ'}

{$REGION 'FRANQUEO'}

function CountFranqueo(cli,cc,prod,peso:integer):Integer;
begin

end;

procedure Tfmain.AddFranqueo(cliente, ceco, peso, producto, zona, cantidad, suma:integer; fecha:TDateTime);
var
  id_franqueo, existen:integer;
begin
  try
    id_franqueo := -1;
    existen := 0;
    id_franqueo := ExisteFranqueo(cliente,ceco, peso, producto, zona,fecha, existen);

    with dm.q_1 do
    begin
       dm.t_write.StartTransaction;

       SQL.Clear;
       Close;

       if id_franqueo=-1 then
       begin
         sql.add('insert into m_correos_reports (id_cliente, fecha, id_ceco, id_producto, id_zona, peso, uds) values ' +
                 '(:cliente, :fecha, :ceco, :producto, :zona, :peso, :uds)');
         ParamByName('cliente').asinteger := edIdCliente.Value;
         ParamByName('fecha').AsDateTime := edFecha.Date;
         ParamByName('ceco').asinteger := edIdCeco.Value;
         ParamByName('producto').asinteger := producto;
         ParamByName('zona').asinteger := zona;
         ParamByName('peso').asinteger := peso;
         ParamByName('uds').asinteger := cantidad;
       end
       else begin
         sql.add('update m_correos_reports set uds=:uds ' +
                 'where id_correos_report=:id');
         ParamByName('id').asinteger := id_franqueo;
         if suma=0 then
              ParamByName('uds').asinteger := cantidad
         else
              ParamByName('uds').asinteger := existen + cantidad;
       end;

       execquery;

      dm.t_write.CommitRetaining;
      //ShowMessage('Datos guardados correctamente.');

    end;

  except
     dm.t_write.RollbackRetaining;
     //ShowMessage('Error al guardar datos.');
  end;
end;


function Tfmain.ExisteFranqueo(cliente, ceco, peso, producto, zona:integer; fecha:TDateTime; out uds:Integer):Integer;
begin
   with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select id_correos_report, uds from m_correos_reports ' +
                       'where id_cliente=:cliente and peso=:peso and id_producto=:producto and ' +
                             'id_ceco=:ceco and fecha=:fecha and id_zona=:zona and estado=''A''');
    ParamByName('cliente').AsInteger := cliente;
    ParamByName('ceco').AsInteger := ceco;
    ParamByName('fecha').AsDateTime := fecha;
    ParamByName('peso').AsInteger := peso;
    ParamByName('producto').AsInteger := producto;
    ParamByName('zona').AsInteger := zona;
    Open;

    if not(IsEmpty) then
    begin
      uds := FieldByName('uds').AsInteger;
      Result :=FieldByName('id_correos_report').AsInteger;
    end
    else result:=-1;

    Free;
  end;
end;

{$ENDREGION 'FRANQUEO'}

{$REGION 'INFORMES'}

function TfMain.CreaTXT:string;
var
  nom: string;
begin
   if edTXT.Text='' then
   begin
          MessageDlg('Debe introducir un directorio destino.', mtInformation, [mbOK],0);
          Exit;
   end;

   if not DirectoryExists(edTXT.text) then
   begin
          MessageDlg('No existe el directorio destino.', mtInformation, [mbOK],0);
          Exit;
   end;

   nom := edTXT.Text+ '\paqueteria_' + FormatDateTime('yyyymmdd',edFecha.Date) + '.txt';

   AssignFile(txt,nom);
   Rewrite(txt);

   result := nom;
end;

procedure Tfmain.btReportClick(Sender: TObject);
begin
    case rgTipo.ItemIndex of
       0: ReportBonificacion;
       1: ReportResumen;
       2,3: ReportDetalle;
    end;
end;

procedure Tfmain.ReportResumen;
var
  ceco_act, fila, col, fila_tit, zona_act, uds_total, fila_prod, cli_actual, uds_total_fila, uds_total_20, uds_total_50, uds_total_100, uds_total_500, uds_total_1000, uds_total_2000: integer;
  imp_total_fila, imp_total: Double;
begin
  if ((rgCliente.ItemIndex=1) and not (edIdCliente.Value>0)) then
       raise Exception.Create('Debe seleccionar un cliente o cambiar filtro.');

  ceco_act := -1;
  zona_act := -1;
  cli_actual := -1;
  fila := 0;
  fila_tit := 0;
  fila_prod := 0;

  uds_total_fila := 0;
  uds_total_20 := 0;
  uds_total_50 := 0;
  uds_total_100 := 0;
  uds_total_500 := 0;
  uds_total_1000 := 0;
  uds_total_2000 := 0;

  imp_total_fila := 0;
  imp_total := 0;

  with dm.qReportResumen do
  try
    Close;
    SelectSQL.Clear;

    SelectSQL.Add('SELECT id_cliente,cli_nom, id_ceco, ceco_nom, peso, sum(uds) as uds, sum(uds*tarifa) as subtotal ' +
                  'FROM mv_correos_reports r WHERE ');

    case rgCliente.ItemIndex of
      0: SelectSQL.Add('');
      1: SelectSQL.Add(' r.id_cliente=' + edIdCliente.Text + ' and ');
      2: SelectSQL.Add(' r.id_cliente<>460877 and ');
    end;

    SelectSQL.Add(' ((r.id_ceco=:ceco) or (:todo_cc=1)) and ' +
                  ' r.fecha between :f1 and :f2 ' +
                  ' group by id_cliente,cli_nom, id_ceco, ceco_nom, peso ' +
                  ' order by id_cliente, id_ceco');

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

          if ar_resumen.Locate('id_cliente;ceco',VarArrayOf([FieldByName('id_cliente').AsString,FieldByName('ceco_nom').AsString]),[]) then
          begin
              ar_resumen.Edit;

              case FieldByName('peso').AsInteger of
                 20: begin
                      ar_resumen.FieldByName('uds_20').AsInteger := ar_resumen.FieldByName('uds_20').AsInteger + FieldByName('uds').AsInteger;
                      ar_resumen.FieldByName('imp_20').AsFloat := ar_resumen.FieldByName('imp_20').AsFloat + FieldByName('subtotal').AsFloat;
                     end;
                 50: begin
                      ar_resumen.FieldByName('uds_50').AsInteger := ar_resumen.FieldByName('uds_50').AsInteger +  FieldByName('uds').AsInteger;
                      ar_resumen.FieldByName('imp_20').AsFloat := ar_resumen.FieldByName('imp_50').AsFloat + FieldByName('subtotal').AsFloat;
                     end;
                 100: begin
                      ar_resumen.FieldByName('uds_100').AsInteger := ar_resumen.FieldByName('uds_100').AsInteger +  FieldByName('uds').AsInteger;
                      ar_resumen.FieldByName('imp_100').AsFloat := ar_resumen.FieldByName('imp_100').AsFloat + FieldByName('subtotal').AsFloat;
                     end;
                 500: begin
                      ar_resumen.FieldByName('uds_500').AsInteger :=  ar_resumen.FieldByName('uds_500').AsInteger + FieldByName('uds').AsInteger;
                      ar_resumen.FieldByName('imp_500').AsFloat := ar_resumen.FieldByName('imp_500').AsFloat + FieldByName('subtotal').AsFloat;
                     end;
                 1000: begin
                      ar_resumen.FieldByName('uds_1000').AsInteger := ar_resumen.FieldByName('uds_1000').AsInteger +  FieldByName('uds').AsInteger;
                      ar_resumen.FieldByName('imp_1000').AsFloat := ar_resumen.FieldByName('imp_1000').AsFloat + FieldByName('subtotal').AsFloat;
                     end;
                 2000: begin
                      ar_resumen.FieldByName('uds_2000').AsInteger := ar_resumen.FieldByName('uds_2000').AsInteger +  FieldByName('uds').AsInteger;
                      ar_resumen.FieldByName('imp_2000').AsFloat := ar_resumen.FieldByName('imp_2000').AsFloat +  FieldByName('subtotal').AsFloat;
                     end;
              end;

          end else
          begin
              ar_resumen.Insert;
              ar_resumen.FieldByName('id_cliente').AsInteger := FieldByName('id_cliente').AsInteger;
              ar_resumen.FieldByName('nombre').AsString := FieldByName('cli_nom').AsString;
              ar_resumen.FieldByName('ceco').AsString := FieldByName('ceco_nom').AsString;
              ar_resumen.FieldByName('fecha_desde').AsString := FormatDateTime('dd/mm/yyyy', edFDesde.Date);
              ar_resumen.FieldByName('fecha_hasta').AsString := FormatDateTime('dd/mm/yyyy', edFHasta.Date);

              case FieldByName('peso').AsInteger of
                 20: begin
                      ar_resumen.FieldByName('uds_20').AsInteger := FieldByName('uds').AsInteger;
                      ar_resumen.FieldByName('imp_20').AsFloat := FieldByName('subtotal').AsFloat;
                     end;
                 50: begin
                      ar_resumen.FieldByName('uds_50').AsInteger := FieldByName('uds').AsInteger;
                      ar_resumen.FieldByName('imp_20').AsFloat := FieldByName('subtotal').AsFloat;
                     end;
                 100: begin
                      ar_resumen.FieldByName('uds_100').AsInteger := FieldByName('uds').AsInteger;
                      ar_resumen.FieldByName('imp_100').AsFloat := FieldByName('subtotal').AsFloat;
                     end;
                 500: begin
                      ar_resumen.FieldByName('uds_500').AsInteger := FieldByName('uds').AsInteger;
                      ar_resumen.FieldByName('imp_500').AsFloat := FieldByName('subtotal').AsFloat;
                     end;
                 1000: begin
                      ar_resumen.FieldByName('uds_1000').AsInteger := FieldByName('uds').AsInteger;
                      ar_resumen.FieldByName('imp_1000').AsFloat := FieldByName('subtotal').AsFloat;
                     end;
                 2000: begin
                      ar_resumen.FieldByName('uds_2000').AsInteger := FieldByName('uds').AsInteger;
                      ar_resumen.FieldByName('imp_2000').AsFloat := FieldByName('subtotal').AsFloat;
                     end;
              end;


          end;

          ar_resumen.Post;
          Next;
        end;

        if repResumen.PrepareReport then repResumen.ShowPreparedReport;
    end else
          raise Exception.Create('No existen datos a mostrar.');

  except
     ShowMessage('Error Generando Documento.');
  end;

end;


procedure Tfmain.btTXTClick(Sender: TObject);
const
  tab = Char(9);

var
  n_linea: integer;
  linea, posicion, ids, nom_file: string;
begin
  if ((not chTodosCl.Checked) and ( not (edIdCliente.Value>0))) then
      raise Exception.Create('Debe indicar un cliente o seleccionar todos.');

  if ((not chTodosCC.Checked) and ( not (edIdCeco.Value>0))) then
      raise Exception.Create('Debe indicar un CECO o seleccionar todos.');

  if edTXT.Text='' then
       raise Exception.Create('Debe indicar una carpeta destino.');

  if not DirectoryExists(edTXT.Text) then
       raise Exception.Create('La carpeta indicada no existe.');

  try
    with dm.qfile do
    begin
      Close;
      SelectSQL.Clear;
      SelectSQL.Add('select * from mv_correos_certificadas where fecha=:fecha ' +
                    ' and id_cliente in (461097,461098,461099,461100,461101,461102,461106)');   //Solo GIH (3205 a 3211)

      if not chTodosCl.checked then
           SelectSQL.Add(' and id_cliente=' + edIdcliente.Text);
      if not chTodosCC.Checked then
           SelectSQL.Add(' and id_ceco=' + edIdCeco.Text);

      ParamByName('fecha').AsDate := edFecha.Date;
      Open;

      If not IsEmpty then
      begin
        nom_file := CreaTXT;

        n_linea := 1;
        linea := '';
        ids := '';

        Last;
        First;

        while not eof do
        begin
            if RecordCount=1 then
                posicion := 'U'
            else if RecNo=1 then
                     posicion := 'C'
                  else if RecNo=RecordCount then
                          posicion := 'F'
                        else
                            posicion := 'R';


           { linea := posicion + tab +
                     FieldByName('version').AsString + tab +
                     FieldByName('producto_paq').AsString + tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + tab +
                     FieldByName('bultos').AsString + tab + tab + tab + tab + tab + tab + tab + tab + tab +
                     FieldByName('empresa').AsString + tab + tab + tab +
                     FieldByName('direccion').AsString + tab + tab + tab + tab + tab + tab + tab +
                     FieldByName('localidad').AsString + tab +
                     FieldByName('provincia').AsString + tab +
                     FieldByName('cp').AsString + tab + tab +
                     FieldByName('pais').AsString + tab + tab + tab + tab + tab + tab + tab +
                     FieldByName('modalidad').AsString + tab +
                     FieldByName('referencia').AsString + tab +
                     FieldByName('modalidad').AsString + tab +
                     FieldByName('peso').AsString + tab +
                     FieldByName('alto').AsString + tab +
                     FieldByName('ancho').AsString + tab +
                     FieldByName('largo').AsString + tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + tab +
                     FieldByName('referencia').AsString + tab + tab + tab + tab + tab + tab + tab + tab + tab + tab +
                     FieldByName('intentos').AsString + tab +
                     FieldByName('en_lista').AsString + tab + tab + tab + tab + tab + tab + tab + tab +
                     FieldByName('pto_admision').AsString + tab + tab + tab + tab + tab + tab + tab + tab +
                     tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + tab +
                     tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + tab +
                     FieldByName('emp_rmt').AsString + tab +
                     FieldByName('cto_rmt').AsString + tab +
                     FieldByName('via_rmt').AsString + tab +
                     FieldByName('dir_rmt').AsString + tab + tab + tab + tab + tab + tab + tab +
                     FieldByName('loc_rmt').AsString + tab +
                     FieldByName('prv_rmt').AsString + tab +
                     FieldByName('cp_rmt').AsString + tab + tab + tab + tab + tab +
                     'E'; //fin de linea }

           linea := posicion + tab +                                             //1
                     FieldByName('version').AsString + tab +                     //2
                     FieldByName('producto_paq').AsString + tab +                //3
                     tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + //4-13
                     FieldByName('bultos').AsString + tab +                      //14
                     '1' + tab +                                                 //15
                     tab + tab + tab + tab + tab + tab + tab +                   //16-22
                     FieldByName('empresa').AsString + tab +                     //23
                     tab + tab +                                                 //24-25
                     FieldByName('direccion').AsString + tab +                   //26
                     tab + tab + tab + tab + tab + tab + tab +                   //27-33
                     FieldByName('localidad').AsString + tab +                   //34
                     FieldByName('provincia').AsString + tab +                   //35
                     FieldByName('cp').AsString + tab +                          //36
                     tab +                                                       //37
                     FieldByName('pais').AsString + tab +                        //38
                     tab + tab + tab + tab + tab + tab + tab +                   //39-45
                     FieldByName('referencia').AsString + ' *'+ FieldByName('id_correos_certificadas').AsString + '*' + tab + //46
                     tab +                                                       //47
                     tab +                                                       //48
                     FieldByName('modalidad').AsString + tab +                   //49
                     FieldByName('peso').AsString + tab +                        //50
                     FieldByName('largo').AsString + tab +                       //51
                     FieldByName('alto').AsString + tab +                        //52
                     FieldByName('ancho').AsString + tab +                       //53
                     tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + //  54-89
                     tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + //
                     tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + //
                     tab + tab + tab + tab + tab + tab +                         //
                     FieldByName('pto_admision').AsString + tab +                //90
                     tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + //91-162
                     tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + //
                     tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + //
                     tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + //
                     tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + //
                     tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + //
                     tab + tab + tab + tab + tab + tab + tab + tab + tab + tab + //
                     tab + tab +                                                 //
                     FieldByName('cto_rmt').AsString + tab +                     //163
                     tab + tab + tab +                                           //164-166
                     FieldByName('emp_rmt').AsString + tab +                     //167
                     FieldByName('cto_rmt').AsString + tab +                     //168
                     FieldByName('via_rmt').AsString + tab +                     //169
                     FieldByName('dir_rmt').AsString + tab +                     //170
                     tab + tab + tab + tab + tab + tab +                         //171-176
                     FieldByName('loc_rmt').AsString + tab +                     //177
                     FieldByName('prv_rmt').AsString + tab +                     //178
                     FieldByName('cp_rmt').AsString + tab +                      //179
                     tab + tab + tab + tab + tab + tab +                         //180-185
                     'E'; //fin de linea

            Writeln(txt,linea);

            ids := ids + fieldbyname('id_correos_certificadas').AsString + ',';
            Next;
        end;

        CloseFile(txt);

        ActualizaLogFile(ids, nom_file);

        ShowMessage('Fichero creado correctamente.');
      end else
             ShowMessage('No existen datos a mostrar.');
    end;
  except
      on e:Exception do
          ShowMessage('Error al crear fichero. ' + e.Message);
  end;
end;

procedure Tfmain.btXlsClick(Sender: TObject);
begin
    case rgTipo.ItemIndex of
       0: XLSBonificacion;
       1: XLSResumen;
       2,3: XLSDetalle;
       4: XLSDestinatarios;
    end;

end;

procedure Tfmain.XLSBonificacion;
var
  id_ceco_act, fila, col, fila_tit, prod_act, uds_total, uds_total_fila, fila_prod, prod: integer;
  imp_total_fila, imp_total, importe: Double;
begin
  if ((rgCliente.ItemIndex=1) and not (edIdCliente.Value>0)) then
       raise Exception.Create('Debe seleccionar un cliente o cambiar filtro.');

    if edXls.Text='' then
      raise Exception.Create('Debe especificar una ruta de destino.');

  if not DirectoryExists(edXls.Text) then
      raise Exception.Create('Destino especificado no válido.');

  id_ceco_act := -1;
  prod_act := -1;
  fila := 0;
  fila_tit := 0;
  fila_prod := 0;

  with dm.qReportBonificacion do
  try
    Close;
    SelectSQL.Clear;

    SelectSQL.Add('SELECT distinct id_cliente FROM mv_correos_reports r WHERE ' +
                  '((r.id_ceco=:ceco) or (:todo_cc=1)) and ' +
                  'r.fecha between :f1 and :f2 ');

    case rgCliente.ItemIndex of
      0: SelectSQL.Add('');
      1: SelectSQL.Add('and r.id_cliente=' + edIdCliente.Text);
      2: SelectSQL.Add('and r.id_cliente<>460877 and r.id_producto=239 ');
    end;

    SelectSQL.Add(' order by id_ceco,id_producto, fecha');

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

        xls.clear;
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

          if rgCliente.ItemIndex=2 then
              prod := 239
          else
              prod := -1;

          for col := 1 to 6 do
          begin
             case col of
                1: xls.Sheets[0].AsInteger[col, fila] := BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,-1,
                                                                                -1,prod,1,edFDesde.Date, edFHasta.Date, importe);
                2: xls.Sheets[0].AsInteger[col, fila] := BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,-1,
                                                                                -1,prod,4,edFDesde.Date, edFHasta.Date, importe);
                3: xls.Sheets[0].AsInteger[col, fila] := BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,-1,
                                                                                -1,prod,5,edFDesde.Date, edFHasta.Date, importe);
                4: xls.Sheets[0].AsInteger[col, fila] := BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,-1,
                                                                                -1,prod,2,edFDesde.Date, edFHasta.Date, importe);
                5: xls.Sheets[0].AsInteger[col, fila] := BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,-1,
                                                                                -1,prod,3,edFDesde.Date, edFHasta.Date, importe);
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
          xls.Sheets[0].AsFloat[6, fila] := imp_total + (imp_total * 0.21);

          Inc(fila);

          Next;
        end;
        xls.Write;
        ShowMessage('XLS Generado Correctamente.');
    end;

  except
     ShowMessage('Error Generando XLS.');
  end;
end;

{procedure Tfmain.XLSDetalle;
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

              fila_tit := RellenaCabecerasDetalle(fila);
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

    ShowMessage('Generado XLS correctamente.');
  except
     ShowMessage('Error Generando XLS.');
  end;

end;   }

procedure Tfmain.XLSDetalle;
var
  id_ceco_act, fila, col, fila_tit, prod_act, uds_total, fila_prod: integer;
begin

  if ((rgCliente.ItemIndex=1) and not (edIdCliente.Value>0)) then
       raise Exception.Create('Debe seleccionar un cliente o cambiar filtro.');

    if edXls.Text='' then
      raise Exception.Create('Debe especificar una ruta de destino.');

  if not DirectoryExists(edXls.Text) then
      raise Exception.Create('Destino especificado no válido.');

  id_ceco_act := -1;
  prod_act := -1;
  fila := 0;
  fila_tit := 0;
  fila_prod := 0;
  xls.Clear;

  with dm.qReportDetalle do
  try
    Close;
    SelectSQL.Clear;
    SelectSQL.Add('SELECT * FROM mv_correos_reports r ' +
                  'WHERE ((r.id_ceco=:ceco) or (:todo_cc=1)) and ' +
                  'r.fecha between :f1 and :f2 ');

    case rgTipo.ItemIndex of
      2: SelectSQL.Add('and id_producto=239');
      3: SelectSQL.Add('and id_producto<>239');
    end;

    case rgCliente.ItemIndex of
      0: SelectSQL.Add('');
      1: SelectSQL.Add(' and r.id_cliente=' + edIdCliente.Text);
      2: SelectSQL.Add(' and r.id_cliente<>460877 ');
    end;

    SelectSQL.Add('order by id_ceco,id_producto, fecha');

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

        xls.clear;

        case rgTipo.ItemIndex of
          2: xls.Filename := edXls.Text + '\detalle_Ord_' + FormatDateTime('yyyymmddhhnnss',Now) + '.xlsx';
          3: xls.Filename := edXls.Text + '\detalle_Cerf_' + FormatDateTime('yyyymmddhhnnss',Now) + '.xlsx';
        end;


        fila := RellenaCabecerasDetalle(fila);
        case rgTipo.ItemIndex of
          2: xls.Sheets[0].Name := 'DETALLE ORDINARIAS';
          3: xls.Sheets[0].Name := 'DETALLE CERTIFICADAS';
        end;

        Inc(fila);

        while not Eof do
        begin
          xls.Sheets[0].AsDateTime[0, fila] := StrToDate(FormatDateTime('dd/mm/yyyy',FieldByName('FECHA').AsDateTime));
          xls.Sheets[0].AsInteger[1, fila] := FieldByName('CLI_COD').AsInteger;
          xls.Sheets[0].AsString[2, fila]  := FieldByName('CLI_NOM').AsString;
          xls.Sheets[0].AsString[3, fila]  := FieldByName('CECO_COD').AsString;
          xls.Sheets[0].AsString[4, fila]  := FieldByName('CECO_NOM').AsString;
          xls.Sheets[0].AsString[5, fila]  := FieldByName('PROD_NOM').AsString;
          xls.Sheets[0].AsString[6, fila]  := FieldByName('ZONA_NOM').AsString;
          xls.Sheets[0].AsInteger[7, fila] := FieldByName('PESO').AsInteger;
          xls.Sheets[0].AsFloat[8, fila] := FieldByName('TARIFA').AsCurrency;
          xls.Sheets[0].cell[8,fila].Items[8,fila].NumberFormat := '#,##0.00 €';
          xls.Sheets[0].AsInteger[9, fila] := FieldByName('UDS').AsInteger;
          xls.Sheets[0].AsFloat[10, fila] := FieldByName('SUBTOTAL').AsCurrency;
          xls.Sheets[0].cell[10,fila].Items[10,fila].NumberFormat := '#,##0.00 €';
          Inc(fila);
          Next;
        end;
    end;

    xls.Sheets[0].AutoWidthCol(0);
    xls.Sheets[0].AutoWidthCol(1);
    xls.Sheets[0].AutoWidthCol(2);
    xls.Sheets[0].AutoWidthCol(3);
    xls.Sheets[0].AutoWidthCol(4);
    xls.Sheets[0].AutoWidthCol(5);
    xls.Sheets[0].AutoWidthCol(6);

    xls.Write;

    ShowMessage('Generado XLS correctamente.');
  except
     ShowMessage('Error Generando XLS.');
  end;

end;


procedure Tfmain.XLSDestinatarios;
var
  id_ceco_act, fila, col, fila_tit, prod_act, uds_total, fila_prod: integer;
begin

  if ((rgCliente.ItemIndex=1) and not (edIdCliente.Value>0)) then
       raise Exception.Create('Debe seleccionar un cliente o cambiar filtro.');

    if edXls.Text='' then
      raise Exception.Create('Debe especificar una ruta de destino.');

  if not DirectoryExists(edXls.Text) then
      raise Exception.Create('Destino especificado no válido.');

  id_ceco_act := -1;
  prod_act := -1;
  fila := 0;
  fila_tit := 0;
  fila_prod := 0;
  xls.Clear;

  with dm.qReportDestinatario do
  try
    Close;
    SelectSQL.Clear;
    SelectSQL.Add('SELECT * FROM mv_correos_certificadas r ' +
                  'WHERE ((r.id_ceco=:ceco) or (:todo_cc=1)) and ' +
                  'r.fecha between :f1 and :f2 ');

    case rgTipo.ItemIndex of
      2: SelectSQL.Add('and id_producto=239');
      3: SelectSQL.Add('and id_producto<>239');
    end;

    case rgCliente.ItemIndex of
      0: SelectSQL.Add('');
      1: SelectSQL.Add(' and r.id_cliente=' + edIdCliente.Text);
      2: SelectSQL.Add(' and r.id_cliente<>460877 ');
    end;

    SelectSQL.Add('order by id_ceco,id_producto, fecha');

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

        xls.clear;

        case rgTipo.ItemIndex of
          2: xls.Filename := edXls.Text + '\detalle_Ord_' + FormatDateTime('yyyymmddhhnnss',Now) + '.xlsx';
          3: xls.Filename := edXls.Text + '\detalle_Cerf_' + FormatDateTime('yyyymmddhhnnss',Now) + '.xlsx';
          4: xls.Filename := edXls.Text + '\destinatarios_' + FormatDateTime('yyyymmddhhnnss',Now) + '.xlsx';
        end;


        fila := RellenaCabecerasDestinatarios(fila);
        case rgTipo.ItemIndex of
          2: xls.Sheets[0].Name := 'DETALLE ORDINARIAS';
          3: xls.Sheets[0].Name := 'DETALLE CERTIFICADAS';
          4: xls.Sheets[0].Name := 'DESTINATARIOS';
        end;

        Inc(fila);

        while not Eof do
        begin
          xls.Sheets[0].AsDateTime[0, fila] := StrToDate(FormatDateTime('dd/mm/yyyy',FieldByName('FECHA').AsDateTime));
          xls.Sheets[0].AsInteger[1, fila] := FieldByName('CLI_COD').AsInteger;
          xls.Sheets[0].AsString[2, fila]  := FieldByName('CLI_NOM').AsString;
          xls.Sheets[0].AsString[3, fila]  := FieldByName('CECO_COD').AsString;
          xls.Sheets[0].AsString[4, fila]  := FieldByName('CECO_NOM').AsString;
          xls.Sheets[0].AsString[5, fila]  := FieldByName('PROD_NOM').AsString;
          xls.Sheets[0].AsString[6, fila]  := FieldByName('ZONA_NOM').AsString;
          xls.Sheets[0].AsInteger[7, fila] := FieldByName('PESO').AsInteger;
          xls.Sheets[0].AsString[8, fila]  := FieldByName('ALTO').AsString +'-'+FieldByName('ancho').AsString +'-'+FieldByName('LARGO').AsString;
          //xls.Sheets[0].AsFloat[9, fila] := FieldByName('TARIFA').AsCurrency;
          xls.Sheets[0].AsString[9, fila]  := FieldByName('EMPRESA').AsString;
          xls.Sheets[0].AsString[10, fila]  := FieldByName('DIRECCION').AsString;
          xls.Sheets[0].AsString[11, fila]  := FieldByName('LOCALIDAD').AsString;
          xls.Sheets[0].AsString[12, fila]  := FieldByName('PROVINCIA').AsString;
          xls.Sheets[0].AsString[13, fila]  := FieldByName('CP').AsString;
          xls.Sheets[0].AsString[14, fila]  := FieldByName('PAIS').AsString;
          xls.Sheets[0].AsString[15, fila]  := FieldByName('REFERENCIA').AsString;
          xls.Sheets[0].AsString[16, fila]  := FieldByName('CTO_RMT').AsString;
          xls.Sheets[0].AsString[17, fila]  := FieldByName('BARCODE').AsString;

          Inc(fila);
          Next;
        end;
    end;

    xls.Sheets[0].AutoWidthCol(0);
    xls.Sheets[0].AutoWidthCol(1);
    xls.Sheets[0].AutoWidthCol(2);
    xls.Sheets[0].AutoWidthCol(3);
    xls.Sheets[0].AutoWidthCol(4);
    xls.Sheets[0].AutoWidthCol(5);
    xls.Sheets[0].AutoWidthCol(6);
    xls.Sheets[0].AutoWidthCol(7);
    xls.Sheets[0].AutoWidthCol(8);
    xls.Sheets[0].AutoWidthCol(9);
    xls.Sheets[0].AutoWidthCol(10);
    xls.Sheets[0].AutoWidthCol(11);
    xls.Sheets[0].AutoWidthCol(12);
    xls.Sheets[0].AutoWidthCol(13);
    xls.Sheets[0].AutoWidthCol(14);
    xls.Sheets[0].AutoWidthCol(15);
    xls.Sheets[0].AutoWidthCol(16);
    xls.Sheets[0].AutoWidthCol(17);


    xls.Write;

    ShowMessage('Generado XLS correctamente.');
  except
     ShowMessage('Error Generando XLS.');
  end;

end;

{procedure Tfmain.XLSResumen;
var
  id_ceco_act, fila, col, fila_tit, prod_act, uds_total, fila_prod, cli_actual: integer;
  importe,imp_total_nac, imp_total_int: Double;
begin
  id_ceco_act := -1;
  prod_act := -1;
  cli_actual := -1;
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
    ShowMessage('XLS Generado Correctamente.');
  except
     ShowMessage('Error Generando XLS.');
  end;

end;   }


procedure Tfmain.XLSResumen;
var
  ceco_act, fila, col, fila_tit, zona_act, uds_total, fila_prod, cli_actual, uds_total_fila, uds_total_20, uds_total_50, uds_total_100, uds_total_500, uds_total_1000, uds_total_2000: integer;
  imp_total_fila, imp_total: Double;
begin
  if ((rgCliente.ItemIndex=1) and not (edIdCliente.Value>0)) then
       raise Exception.Create('Debe seleccionar un cliente o cambiar filtro.');

  if edXls.Text='' then
      raise Exception.Create('Debe especificar una ruta de destino.');

  if not DirectoryExists(edXls.Text) then
      raise Exception.Create('Destino especificado no válido.');


  ceco_act := -1;
  zona_act := -1;
  cli_actual := -1;
  fila := 0;
  fila_tit := 0;
  fila_prod := 0;

  uds_total_fila := 0;
  uds_total_20 := 0;
  uds_total_50 := 0;
  uds_total_100 := 0;
  uds_total_500 := 0;
  uds_total_1000 := 0;
  uds_total_2000 := 0;

  imp_total_fila := 0;
  imp_total := 0;

  with dm.qReportResumen do
  try
    Close;
    SelectSQL.Clear;

    SelectSQL.Add('SELECT id_cliente,cli_nom, id_ceco, ceco_nom, peso, sum(uds) as uds, sum(uds*tarifa) as subtotal ' +
                  'FROM mv_correos_reports r WHERE ');

    case rgCliente.ItemIndex of
      0: SelectSQL.Add('');
      1: SelectSQL.Add(' r.id_cliente=' + edIdCliente.Text + ' and ');
      2: SelectSQL.Add(' r.id_cliente<>460877 and ');
    end;

    SelectSQL.Add(' ((r.id_ceco=:ceco) or (:todo_cc=1)) and ' +
                  ' r.fecha between :f1 and :f2 ' +
                  ' group by id_cliente,cli_nom, id_ceco, ceco_nom, peso ' +
                  ' order by id_cliente, id_ceco');

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

        xls.Clear;

        xls.Filename := edXls.Text + '\resumen' + FormatDateTime('yyyymmddhhnnss',Now) + '.xlsx';

        fila := RellenaCabecerasResumen(0,fila);

        //Inc(fila);

        while not Eof do
        begin
          if cli_actual<>FieldByName('id_cliente').AsInteger then
          begin
              cli_actual := FieldByName('id_cliente').AsInteger;
              if uds_total_fila>0 then
                       xls.Sheets[0].AsInteger[8,fila] := uds_total_fila;
               if imp_total_fila>0 then
               begin
                       xls.Sheets[0].AsFloat[9,fila] := imp_total_fila;
                       xls.Sheets[0].cell[9,fila].Items[9,fila].NumberFormat := '#,##0.00 €';
               end;
               uds_total_fila := 0;
               imp_total_fila := 0;
               Inc(fila);
              xls.Sheets[0].AsString[0,fila] := FieldByName('cli_nom').AsString;
          end;

          if ceco_act<>FieldByName('id_ceco').AsInteger then
          begin
              ceco_act := FieldByName('id_ceco').AsInteger;
              if uds_total_fila>0 then
                       xls.Sheets[0].AsInteger[8,fila] := uds_total_fila;
               if imp_total_fila>0 then
               begin
                       xls.Sheets[0].AsFloat[9,fila] := imp_total_fila;
                       xls.Sheets[0].cell[9,fila].Items[9,fila].NumberFormat := '#,##0.00 €';
               end;
              uds_total_fila := 0;
              imp_total_fila := 0;
              zona_act := -1;
              Inc(fila);
              xls.Sheets[0].AsString[1,fila] := FieldByName('ceco_nom').AsString;
              xls.Sheets[0].AsInteger[CalculaCol(FieldByName('peso').AsInteger),fila] := FieldByName('uds').AsInteger;
               case FieldByName('peso').AsInteger of
                  20: uds_total_20 := uds_total_20 + FieldByName('uds').AsInteger;
                  50: uds_total_50 := uds_total_50 + FieldByName('uds').AsInteger;
                  100: uds_total_100 := uds_total_100 + FieldByName('uds').AsInteger;
                  500: uds_total_500 := uds_total_500 + FieldByName('uds').AsInteger;
                  1000: uds_total_1000 := uds_total_1000 + FieldByName('uds').AsInteger;
                  2000: uds_total_2000 := uds_total_2000 + FieldByName('uds').AsInteger;
               end;
               uds_total_fila := uds_total_fila + FieldByName('uds').AsInteger;
               imp_total_fila := imp_total_fila + FieldByName('subtotal').AsFloat;
               imp_total := imp_total + FieldByName('subtotal').AsFloat;
          end else begin
                       xls.Sheets[0].AsInteger[CalculaCol(FieldByName('peso').AsInteger),fila] := FieldByName('uds').AsInteger;
                       case FieldByName('peso').AsInteger of
                          20: uds_total_20 := uds_total_20 + FieldByName('uds').AsInteger;
                          50: uds_total_50 := uds_total_50 + FieldByName('uds').AsInteger;
                          100: uds_total_100 := uds_total_100 + FieldByName('uds').AsInteger;
                          500: uds_total_500 := uds_total_500 + FieldByName('uds').AsInteger;
                          1000: uds_total_1000 := uds_total_1000 + FieldByName('uds').AsInteger;
                          2000: uds_total_2000 := uds_total_2000 + FieldByName('uds').AsInteger;
                       end;
                       uds_total_fila := uds_total_fila + FieldByName('uds').AsInteger;
                       imp_total_fila := imp_total_fila + FieldByName('subtotal').AsFloat;
                       imp_total := imp_total + FieldByName('subtotal').AsFloat;
                   end;

         { if zona_act<>FieldByName('id_zona').AsInteger then
          begin
               zona_act := FieldByName('id_zona').AsInteger;
               if uds_total_fila>0 then
                       xls.Sheets[0].AsInteger[9,fila] := uds_total_fila;
               if imp_total_fila>0 then
                       xls.Sheets[0].AsFloat[10,fila] := imp_total_fila;
               uds_total_fila := 0;
               imp_total_fila := 0;

               Inc(fila);
               xls.Sheets[0].AsString[2,fila] := FieldByName('zona_nom').AsString;
               xls.Sheets[0].AsInteger[CalculaCol(FieldByName('peso').AsInteger),fila] := FieldByName('uds').AsInteger;
               case FieldByName('peso').AsInteger of
                  20: uds_total_20 := uds_total_20 + FieldByName('uds').AsInteger;
                  50: uds_total_50 := uds_total_50 + FieldByName('uds').AsInteger;
                  100: uds_total_100 := uds_total_100 + FieldByName('uds').AsInteger;
                  500: uds_total_500 := uds_total_500 + FieldByName('uds').AsInteger;
                  1000: uds_total_1000 := uds_total_1000 + FieldByName('uds').AsInteger;
                  2000: uds_total_2000 := uds_total_2000 + FieldByName('uds').AsInteger;
               end;
               uds_total_fila := uds_total_fila + FieldByName('uds').AsInteger;
               imp_total_fila := imp_total_fila + FieldByName('subtotal').AsFloat;
               imp_total := imp_total + FieldByName('subtotal').AsFloat;
          end else begin
                       xls.Sheets[0].AsInteger[CalculaCol(FieldByName('peso').AsInteger),fila] := FieldByName('uds').AsInteger;
                       case FieldByName('peso').AsInteger of
                          20: uds_total_20 := uds_total_20 + FieldByName('uds').AsInteger;
                          50: uds_total_50 := uds_total_50 + FieldByName('uds').AsInteger;
                          100: uds_total_100 := uds_total_100 + FieldByName('uds').AsInteger;
                          500: uds_total_500 := uds_total_500 + FieldByName('uds').AsInteger;
                          1000: uds_total_1000 := uds_total_1000 + FieldByName('uds').AsInteger;
                          2000: uds_total_2000 := uds_total_2000 + FieldByName('uds').AsInteger;
                       end;
                       uds_total_fila := uds_total_fila + FieldByName('uds').AsInteger;
                       imp_total_fila := imp_total_fila + FieldByName('subtotal').AsFloat;
                       imp_total := imp_total + FieldByName('subtotal').AsFloat;
                   end;    }

          //Inc(fila);
          Next;
        end;

        if uds_total_fila>0 then
                       xls.Sheets[0].AsInteger[8,fila] := uds_total_fila;
               if imp_total_fila>0 then
                       xls.Sheets[0].AsFloat[9,fila] := imp_total_fila;

        Inc(fila);
        xls.Sheets[0].AsString[0,fila] := 'Total General';
        xls.Sheets[0].AsInteger[2,fila] := uds_total_20;
        xls.Sheets[0].AsInteger[3,fila] := uds_total_50;
        xls.Sheets[0].AsInteger[4,fila] := uds_total_100;
        xls.Sheets[0].AsInteger[5,fila] := uds_total_500;
        xls.Sheets[0].AsInteger[6,fila] := uds_total_1000;
        xls.Sheets[0].AsInteger[7,fila] := uds_total_2000;
        xls.Sheets[0].AsInteger[8,fila] := uds_total_20 + uds_total_50 + uds_total_100 + uds_total_500 + uds_total_1000 + uds_total_2000;
        xls.Sheets[0].AsFloat[9,fila] := imp_total;
        xls.Sheets[0].cell[9,fila].Items[9,fila].NumberFormat := '#,##0.00 €';
    end;

    xls.Sheets[0].AutoWidthCol(0);
    xls.Sheets[0].AutoWidthCol(1);
    xls.Sheets[0].AutoWidthCol(2);
    xls.Sheets[0].AutoWidthCol(3);
    xls.Sheets[0].AutoWidthCol(4);
    xls.Sheets[0].AutoWidthCol(5);
    xls.Sheets[0].AutoWidthCol(6);
    xls.Sheets[0].AutoWidthCol(7);
    xls.Sheets[0].AutoWidthCol(8);
    xls.Sheets[0].AutoWidthCol(9);
    xls.Sheets[0].AutoWidthCol(10);

    xls.Write;
    ShowMessage('XLS Generado Correctamente.');
  except
     ShowMessage('Error Generando XLS.');
  end;

end;


function  Tfmain.CalculaCol(peso: Integer):integer;
begin
   case peso of
      20: Result := 2;
      50: Result := 3;
      100: Result := 4;
      500: Result := 5;
      1000: Result := 6;
      2000: Result := 7;
   end;
end;

procedure Tfmain.ReportBonificacion;
var
  id_ceco_act, fila, col, fila_tit, prod_act, uds_total, uds_total_fila, fila_prod, prod: integer;
  imp_total_fila, imp_total, importe: Double;
begin
  if ((rgCliente.ItemIndex=1) and not (edIdCliente.Value>0)) then
       raise Exception.Create('Debe seleccionar un cliente o cambiar filtro.');

  id_ceco_act := -1;
  prod_act := -1;
  fila := 0;
  fila_tit := 0;
  fila_prod := 0;

  ar_bonificacion.EmptyDataSet;

  with dm.qReportBonificacion do
  try
    Close;
    SelectSQL.Clear;

    SelectSQL.Add('SELECT distinct id_cliente FROM mv_correos_reports r WHERE ' +
                  '((r.id_ceco=:ceco) or (:todo_cc=1)) and ' +
                  'r.fecha between :f1 and :f2 ');

    case rgCliente.ItemIndex of
      0: SelectSQL.Add('');
      1: SelectSQL.Add('and r.id_cliente=' + edIdCliente.Text);
      2: SelectSQL.Add('and r.id_cliente<>460877 and r.id_producto=239 ');
    end;

    SelectSQL.Add(' order by id_ceco,id_producto, fecha');

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

          ar_bonificacion.Insert;
          ar_bonificacion.FieldByName('id_cliente').AsInteger := FieldByName('id_cliente').AsInteger;
          ar_bonificacion.FieldByName('nombre').AsString := BuscaClientePorId(FieldByName('id_cliente').AsInteger);
          ar_bonificacion.FieldByName('fecha_desde').AsString := FormatDateTime('dd/mm/yyyy', edFDesde.Date);
          ar_bonificacion.FieldByName('fecha_hasta').AsString := FormatDateTime('dd/mm/yyyy', edFHasta.Date);

          uds_total_fila:= 0;
          imp_total_fila := 0;

          if rgCliente.ItemIndex=2 then
              prod := 239
          else
              prod := -1;

          ar_bonificacion.FieldByName('uds_local').AsInteger := BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,-1,-1,prod,1,edFDesde.Date, edFHasta.Date, importe);
          ar_bonificacion.FieldByName('imp_local').AsFloat := importe;
          ar_bonificacion.FieldByName('uds_int_eur').AsInteger := BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,-1,-1,prod,2,edFDesde.Date, edFHasta.Date, importe);
          ar_bonificacion.FieldByName('imp_int_eur').AsFloat := importe;
          ar_bonificacion.FieldByName('uds_int_resto').AsInteger := BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,-1,-1,prod,3,edFDesde.Date, edFHasta.Date, importe);
          ar_bonificacion.FieldByName('imp_int_resto').AsFloat := importe;
          ar_bonificacion.FieldByName('uds_d1').AsInteger := BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,-1,-1,prod,4,edFDesde.Date, edFHasta.Date, importe);
          ar_bonificacion.FieldByName('imp_d1').AsFloat := importe;
          ar_bonificacion.FieldByName('uds_d2').AsInteger := BuscaFranqueoPorFechas(FieldByName('id_cliente').AsInteger,-1,-1,prod,5,edFDesde.Date, edFHasta.Date, importe);
          ar_bonificacion.FieldByName('imp_d2').AsFloat := importe;


          Next;
        end;
        ar_bonificacion.Post;

        if repBonificacion.PrepareReport then repBonificacion.ShowPreparedReport;

    end;
  except
       ShowMessage('Error Generando Documento.');
  end;
end;

procedure Tfmain.ReportDetalle;
var
  id_ceco_act, fila, col, fila_tit, prod_act, uds_total, fila_prod: integer;
  importe: Double;
begin
  if ((rgCliente.ItemIndex=1) and not (edIdCliente.Value>0)) then
       raise Exception.Create('Debe seleccionar un cliente o cambiar filtro.');

  id_ceco_act := -1;
  prod_act := -1;
  fila := 0;
  fila_tit := 0;
  fila_prod := 0;

  with dm.qReportDetalle do
  try
    Close;
    SelectSQL.Clear;
    SelectSQL.Add('SELECT * FROM mv_correos_reports r ' +
                  'WHERE ((r.id_ceco=:ceco) or (:todo_cc=1)) and ' +
                  'r.fecha between :f1 and :f2 ');

    case rgTipo.ItemIndex of
      2: SelectSQL.Add('and id_producto=239');
      3: SelectSQL.Add('and id_producto<>239');
    end;

    case rgCliente.ItemIndex of
      0: SelectSQL.Add('');
      1: SelectSQL.Add(' and r.id_cliente=' + edIdCliente.Text);
      2: SelectSQL.Add(' and r.id_cliente<>460877 ');
    end;

    SelectSQL.Add('order by id_ceco,id_producto, fecha');


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
      {  First;

        while not Eof do
        begin

          if ar_detalle.Locate('id_cliente;ceco',VarArrayOf([FieldByName('id_cliente').AsString,FieldByName('ceco_nom').AsString]),[]) then
          begin
              ar_detalle.Edit;

              case FieldByName('peso').AsInteger of
                 20: begin
                      ar_detalle.FieldByName('uds_20').AsInteger := ar_detalle.FieldByName('uds_20').AsInteger + FieldByName('uds').AsInteger;
                      ar_detalle.FieldByName('imp_20').AsFloat := ar_detalle.FieldByName('imp_20').AsFloat + FieldByName('subtotal').AsFloat;
                     end;
                 50: begin
                      ar_detalle.FieldByName('uds_50').AsInteger := ar_detalle.FieldByName('uds_50').AsInteger +  FieldByName('uds').AsInteger;
                      ar_detalle.FieldByName('imp_20').AsFloat := ar_detalle.FieldByName('imp_50').AsFloat + FieldByName('subtotal').AsFloat;
                     end;
                 100: begin
                      ar_detalle.FieldByName('uds_100').AsInteger := ar_detalle.FieldByName('uds_100').AsInteger +  FieldByName('uds').AsInteger;
                      ar_detalle.FieldByName('imp_100').AsFloat := ar_detalle.FieldByName('imp_100').AsFloat + FieldByName('subtotal').AsFloat;
                     end;
                 500: begin
                      ar_detalle.FieldByName('uds_500').AsInteger :=  ar_detalle.FieldByName('uds_500').AsInteger + FieldByName('uds').AsInteger;
                      ar_detalle.FieldByName('imp_500').AsFloat := ar_detalle.FieldByName('imp_500').AsFloat + FieldByName('subtotal').AsFloat;
                     end;
                 1000: begin
                      ar_detalle.FieldByName('uds_1000').AsInteger := ar_detalle.FieldByName('uds_1000').AsInteger +  FieldByName('uds').AsInteger;
                      ar_detalle.FieldByName('imp_1000').AsFloat := ar_detalle.FieldByName('imp_1000').AsFloat + FieldByName('subtotal').AsFloat;
                     end;
                 2000: begin
                      ar_detalle.FieldByName('uds_2000').AsInteger := ar_detalle.FieldByName('uds_2000').AsInteger +  FieldByName('uds').AsInteger;
                      ar_detalle.FieldByName('imp_2000').AsFloat := ar_detalle.FieldByName('imp_2000').AsFloat +  FieldByName('subtotal').AsFloat;
                     end;
              end;

          end else
          begin
              ar_detalle.Insert;
              ar_detalle.FieldByName('id_cliente').AsInteger := FieldByName('id_cliente').AsInteger;
              ar_detalle.FieldByName('nombre').AsString := FieldByName('cli_nom').AsString;
              ar_detalle.FieldByName('ceco').AsString := FieldByName('ceco_nom').AsString;
              ar_detalle.FieldByName('fecha_desde').AsString := FormatDateTime('dd/mm/yyyy', edFDesde.Date);
              ar_detalle.FieldByName('fecha_hasta').AsString := FormatDateTime('dd/mm/yyyy', edFHasta.Date);

              case FieldByName('peso').AsInteger of
                 20: begin
                      ar_detalle.FieldByName('uds_20').AsInteger := FieldByName('uds').AsInteger;
                      ar_detalle.FieldByName('imp_20').AsFloat := FieldByName('subtotal').AsFloat;
                     end;
                 50: begin
                      ar_detalle.FieldByName('uds_50').AsInteger := FieldByName('uds').AsInteger;
                      ar_detalle.FieldByName('imp_20').AsFloat := FieldByName('subtotal').AsFloat;
                     end;
                 100: begin
                      ar_detalle.FieldByName('uds_100').AsInteger := FieldByName('uds').AsInteger;
                      ar_detalle.FieldByName('imp_100').AsFloat := FieldByName('subtotal').AsFloat;
                     end;
                 500: begin
                      ar_detalle.FieldByName('uds_500').AsInteger := FieldByName('uds').AsInteger;
                      ar_detalle.FieldByName('imp_500').AsFloat := FieldByName('subtotal').AsFloat;
                     end;
                 1000: begin
                      ar_detalle.FieldByName('uds_1000').AsInteger := FieldByName('uds').AsInteger;
                      ar_detalle.FieldByName('imp_1000').AsFloat := FieldByName('subtotal').AsFloat;
                     end;
                 2000: begin
                      ar_detalle.FieldByName('uds_2000').AsInteger := FieldByName('uds').AsInteger;
                      ar_detalle.FieldByName('imp_2000').AsFloat := FieldByName('subtotal').AsFloat;
                     end;
              end;


         // end;

          ar_detalle.Post;
          Next;
        end;       }

        if repDetalle.PrepareReport then repDetalle.ShowPreparedReport;
    end;

  except
       ShowMessage('Error Generando Documento.');
  end;
end;

{function Tfmain.RellenaCabecerasDetalle(fila:integer):integer;
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

    result := fila;
end; }


function Tfmain.RellenaCabecerasDetalle(fila:integer):integer;
begin
    xls.Sheets[0].AsString[0, fila] := 'FECHA';
    xls.Sheets[0].AsString[1, fila] := 'COD';
    xls.Sheets[0].AsString[2, fila] := 'CLIENTE';
    xls.Sheets[0].AsString[3, fila] := 'CECO';
    xls.Sheets[0].AsString[4, fila] := 'CC_NOMBRE';
    xls.Sheets[0].AsString[5, fila] := 'PRODUCTO';
    xls.Sheets[0].AsString[6, fila] := 'ZONA';
    xls.Sheets[0].AsString[7, fila] := 'PESO';
    xls.Sheets[0].AsString[8, fila] := 'TARIFA';
    xls.Sheets[0].AsString[9, fila] := 'UDS';
    xls.Sheets[0].AsString[10, fila] := 'TOTAL';

    result := fila;
end;

function Tfmain.RellenaCabecerasDestinatarios(fila:integer):integer;
begin
    xls.Sheets[0].AsString[0, fila] := 'FECHA';
    xls.Sheets[0].AsString[1, fila] := 'COD';
    xls.Sheets[0].AsString[2, fila] := 'CLIENTE';
    xls.Sheets[0].AsString[3, fila] := 'CECO';
    xls.Sheets[0].AsString[4, fila] := 'CC_NOMBRE';
    xls.Sheets[0].AsString[5, fila] := 'PRODUCTO';
    xls.Sheets[0].AsString[6, fila] := 'ZONA';
    xls.Sheets[0].AsString[7, fila] := 'PESO';
    xls.Sheets[0].AsString[8, fila] := 'ALTO-ANCHO-LARGO';
    //xls.Sheets[0].AsString[9, fila] := 'TARIFA';
    xls.Sheets[0].AsString[9, fila] := 'EMPRESA';
    xls.Sheets[0].AsString[10, fila] := 'DIRECCION';
    xls.Sheets[0].AsString[11, fila] := 'LOCALIDAD';
    xls.Sheets[0].AsString[12, fila] := 'PROVINCIA';
    xls.Sheets[0].AsString[13, fila] := 'C. POSTAL';
    xls.Sheets[0].AsString[14, fila] := 'PAIS';
    xls.Sheets[0].AsString[15, fila] := 'REFERENCIA';
    xls.Sheets[0].AsString[16, fila] := 'CONTACTO';
    xls.Sheets[0].AsString[17, fila] := 'BARCODE';
    result := fila;
end;


function Tfmain.RellenaCabecerasResumen(col,fila:integer):integer;
begin
    xls.Sheets[0].AsString[col+2, fila] := 'PESO';
    //xls.Sheets[0].Cell[3, fila].FontColor := xcBlue;
    //xls.Sheets[0].Cell[3, fila].FontStyle := Xc12DataStyleSheet5.tXc12FontStyles(xfsBold);
    //xls.Sheets[0].Cell[3,fila].FillPatternBackColor := xcBlue;

    Inc(fila);

    xls.Sheets[0].AsString[col+2, fila] := '20';
    xls.Sheets[0].AsString[col+3, fila] := '50';
    xls.Sheets[0].AsString[col+4, fila] := '100';
    xls.Sheets[0].AsString[col+5, fila] := '500';
    xls.Sheets[0].AsString[col+6, fila] := '1000';
    xls.Sheets[0].AsString[col+7, fila] := '2000';
    xls.Sheets[0].AsString[col+8, fila] := 'Total UNIDADES';
    xls.Sheets[0].AsString[col+9, fila] := 'Total IMPORTE';


    Inc(fila);
    xls.Sheets[0].AsString[col, fila] := 'CLIENTE';
    xls.Sheets[0].AsString[col+1, fila] := 'CC_NOMBRE';
    //xls.Sheets[0].AsString[col+2, fila] := 'ZONA';
    xls.Sheets[0].AsString[col+2, fila] := 'UNIDADES';
    xls.Sheets[0].AsString[col+3, fila] := 'UNIDADES';
    xls.Sheets[0].AsString[col+4, fila] := 'UNIDADES';
    xls.Sheets[0].AsString[col+5, fila] := 'UNIDADES';
    xls.Sheets[0].AsString[col+6, fila] := 'UNIDADES';
    xls.Sheets[0].AsString[col+7, fila] := 'UNIDADES';

    result := fila;
end;

procedure Tfmain.RellenaCabecerasBonificacion(fila:integer);
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
{$ENDREGION 'INFORMES'}

{$REGION 'DATOS'}

function Tfmain.GetTotalCliente(cliente:Integer; out uds:integer):Double;
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

function Tfmain.GetTotalClientePeso(cliente, peso:Integer; out uds:integer):Double;
begin
   with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select sum(uds) as uds,sum(uds*tarifa) as total ' +
                       'from m_correos_reports r ' +
                       'where id_cliente=:cliente and peso=:peso and fecha=:fecha and estado=''A'' ');
    ParamByName('cliente').AsInteger := cliente;
    ParamByName('peso').AsInteger := peso;
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

function Tfmain.BuscaCliente(codigo:string):string;
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


function Tfmain.BuscaClientePorId(id:integer):string;
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

function Tfmain.BuscaClienteId(codigo:string):Integer;
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


function Tfmain.BuscaCeco(codigo:string):string;
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

function Tfmain.BuscaCecoPorId(id:integer):string;
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

function Tfmain.BuscaCecoId(codigo:string):Integer;
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

procedure Tfmain.filter;
var
  x, y, total, uds: Integer;
  total_cl: Double;
begin

     uds := 0;
     total_cl := GetTotalCliente(StrToInt(edIdCliente.Text),uds);
      lbTClienteUds.Caption := IntToStr(uds);
      lbTClienteImp.Caption := formatfloat('#,##0.00', total_cl);
      total_cl := GetTotalClientePeso(StrToInt(edIdCliente.Text),20,uds);
      lbT20Uds.Caption := IntToStr(uds);
      lbT20Imp.Caption := formatfloat('#,##0.00', total_cl);
      total_cl := GetTotalClientePeso(StrToInt(edIdCliente.Text),50,uds);
      lbT50Uds.Caption := IntToStr(uds);
      lbT50Imp.Caption := formatfloat('#,##0.00', total_cl);
      total_cl := GetTotalClientePeso(StrToInt(edIdCliente.Text),100,uds);
      lbT100Uds.Caption := IntToStr(uds);
      lbT100Imp.Caption := formatfloat('#,##0.00', total_cl);
      total_cl := GetTotalClientePeso(StrToInt(edIdCliente.Text),500,uds);
      lbT500Uds.Caption := IntToStr(uds);
      lbT500Imp.Caption := formatfloat('#,##0.00', total_cl);
      total_cl := GetTotalClientePeso(StrToInt(edIdCliente.Text),1000,uds);
      lbT1000Uds.Caption := IntToStr(uds);
      lbT1000Imp.Caption := formatfloat('#,##0.00', total_cl);
      total_cl := GetTotalClientePeso(StrToInt(edIdCliente.Text),2000,uds);
      lbT2000Uds.Caption := IntToStr(uds);
      lbT2000Imp.Caption := formatfloat('#,##0.00', total_cl);

     if ((rgTipo.ItemIndex=-1) or (edCeco.Text='') or (edIdCliente.Text='') or (edIdCeco.Text='') {or (modo=2)})  then
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

function Tfmain.BuscaFranqueoPorFechas(cliente, ceco, peso, producto, zona:integer; f1,f2:TDateTime; out importe:Double):Integer;
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

function Tfmain.BuscaFranqueo(cliente, ceco, peso, producto, zona:integer; fecha:TDateTime):Integer;
begin
   with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select sum(uds) as uds from mv_correos_reports ' +
                       'where id_cliente=:cliente and peso=:peso and id_producto=:producto and ' +
                             'id_ceco=:ceco and fecha=:fecha and id_zona=:zona ');
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


function Tfmain.BuscaTarifa(cliente, ceco, peso, producto, zona:integer):Double;
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

{$ENDREGION 'DATOS'}


procedure Tfmain.lbFrRestClick(Sender: TObject);
begin

end;


{$REGION 'CERTIFICADA'}

procedure Tfmain.gr1TitleClick(Column: TColumn);
var
  i: integer;
begin
      col_estado := Column.Index;
      filter_estados;
      for I := 0 to gr1.Columns.Count-1 do
        If Column.Index=i then
              gr1.Columns[i].Title.Font.Color := clPurple
        else
              gr1.Columns[i].Title.Font.Color := clBlack;

end;

procedure Tfmain.grCertificadasAfterScroll(Sender: TObject;
  ScrollBar: Cardinal);
begin
   if modo=0 then
   if edIdCert.Value>0 then
   begin
       RellenaCertificada;
       GetCertEstado(edIdCert.Value);
   end;

end;

procedure Tfmain.grCertificadasCellClick(Column: TColumn);
begin
   if modo=0 then
     RellenaCertificada;
end;

procedure Tfmain.grDataKeyPress(Sender: TObject; var Key: Char);
begin
  if ((Key<>Char(48)) and (Key<>Char(49)) and (Key<>Char(50)) and (Key<>Char(51)) and (Key<>Char(52)) and
      (Key<>Char(53)) and (Key<>Char(54)) and (Key<>Char(55)) and (Key<>Char(56)) and (Key<>Char(57)) and (Key<>Char(8))) then
     raise Exception.Create('Carácter no permitido');
end;

procedure Tfmain.filter_certificadas;
var
  producto, zona: Integer;
begin
   if ((rgTipo.ItemIndex=-1) or (edCeco.Text='') or (edIdCliente.Text='') or (edIdCeco.Text='') {or (modo=2)})  then
          Exit;

    with dm.qfiltro_certif do
    begin
      try
         Close;
         SelectSQL.Clear;
         SelectSQL.add('select c.*, cl.codigo as cod_cli, cc.codigo as ceco ' +
                       'from mv_correos_certificadas c ' +
                       'inner join g_clientes cl on cl.id_cliente=c.id_cliente ' +
                       'inner join g_clientes_cecos cc on cc.id_cliente_ceco=c.id_ceco ' +
                       'where fecha=:fecha and c.id_producto=:producto and c.id_zona=:zona and c.peso=:peso ');

         if edIdCliente.Value>0 then
             SelectSQL.Add(' and c.id_cliente=' + edIdcliente.Text);
         if edIdCeco.Value>0 then
             SelectSQL.Add(' and c.id_ceco=' + edIdCeco.Text);

         if edFiltroTexto.Text<>'' then
            SelectSQL.Add(' and ((c.empresa like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.direccion like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.localidad like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.provincia like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.cp like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.referencia like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.barcode like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.cto_rmt like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.acuse like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.cli_nom like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.cli_cod like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.ceco_cod like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.ceco_nom like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.prod_nom like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.zona_nom like ''%' +  edFiltroTexto.Text + '%'' ) ' +
                                ')');

         case rgProdCert.ItemIndex of
                    0: ParamByName('producto').asinteger := 240;   //Carta Certificada
                    1: ParamByName('producto').asinteger := 325;   //Carta Certificada con AR
                 end;

         case rgZona.ItemIndex of
            0: ParamByName('zona').asinteger := 1;     //Nacional
            1: ParamByName('zona').asinteger := 4;     //Nacional D1
            2: ParamByName('zona').asinteger := 5;     //Nacional D2
            3: ParamByName('zona').asinteger := 2;     //Int. Europa
            4: ParamByName('zona').asinteger := 3;     //Int. Resto
         end;

         ParamByName('peso').asinteger := StrToInt(rgPeso.Items[rgPeso.ItemIndex]);
         ParamByName('fecha').AsDateTime := edFecha.Date;

         Open;

         First;
         if not eof then
          RellenaCertificada
         else
          VaciaCertificada;

         lbLineas.Caption := IntToStr(RecordCount) + ' líneas.';

         lbFrEnc.Caption := 'Encontrado ' +  IntToStr(BuscaFranqueo(edIdCliente.Value,edIdCeco.Value,StrToInt(rgPeso.Items[rgPeso.ItemIndex]),
                                                      FieldByName('id_producto').AsInteger, FieldByName('id_zona').AsInteger, edFecha.Date)) + ' franqueos.';

         lbFrEnc.font.Color := clRed;
      except
         ShowMessage('Error al cargar datos.');
      end;
    end;
end;

procedure Tfmain.RellenaCertificada;
begin
    edIdCert.Text := dm.qfiltro_certif.FieldByName('id_correos_certificadas').AsString;
    edEmpresa.Text := dm.qfiltro_certif.FieldByName('empresa').AsString;
    edDireccion.Text := dm.qfiltro_certif.FieldByName('direccion').AsString;
    edLocalidad.Text := dm.qfiltro_certif.FieldByName('localidad').AsString;
    edProvincia.Text := dm.qfiltro_certif.FieldByName('provincia').AsString;
    edCP.Text := dm.qfiltro_certif.FieldByName('cp').AsString;
    edPais.Text := dm.qfiltro_certif.FieldByName('pais').AsString;
    edReferencia.Text := dm.qfiltro_certif.FieldByName('referencia').AsString;
    edCtoRmt.Text := dm.qfiltro_certif.FieldByName('cto_rmt').AsString;

    if not dm.qfiltro_certif.IsEmpty then
    begin
      edAlto.Text := dm.qfiltro_certif.FieldByName('alto').AsString;
      edAncho.Text := dm.qfiltro_certif.FieldByName('ancho').AsString;
      edLargo.Text := dm.qfiltro_certif.FieldByName('largo').AsString;
      rgSobre.ItemIndex := dm.qfiltro_certif.FieldByName('idx_sobre').AsInteger;
    end;

    if dm.qfiltro_certif.FieldByName('barcode').AsString<>'' then
         bc.BarCode := dm.qfiltro_certif.FieldByName('barcode').AsString
    else
         bc.Barcode := 'CD00000000000';

    bc.Visible := not (bc.Barcode = 'CD00000000000');

    if dm.qfiltro_certif.FieldByName('peso').AsString<>'' then
    begin
        rgPeso.ItemIndex := rgPeso.Items.IndexOf(dm.qfiltro_certif.FieldByName('peso').AsString);
        edPeso.Text := dm.qfiltro_certif.FieldByName('peso').AsString;
    end;
   { else begin
        rgPeso.ItemIndex := 0;
        edPeso.Text := '20';
    end;    }

    case dm.qfiltro_certif.FieldByName('id_producto').AsInteger of
         240: rgProdCert.ItemIndex := 0;
         325: rgProdCert.ItemIndex := 1;
    end;

    GetCertEstado(dm.qfiltro_certif.FieldByName('id_correos_certificadas').AsInteger);
end;


procedure Tfmain.filter_estados;
var
  producto, zona: Integer;
begin
    with dm.qfiltro_estados do
    begin
      try
         Close;
         SelectSQL.Clear;
         SelectSQL.add('select e.* ' +
                       'from m_correos_certificadas_estados e ' +
                       'inner join mv_correos_certificadas c on e.id_correos_certificada=c.id_correos_certificadas ' +
                       'where 1=1 ');

         if not chEstFTodas.Checked then
         begin
            SelectSQL.Add('and e.fecha between :ini and :fin ');
            ParamByName('ini').AsDateTime := edEstFDesde.Date;
            ParamByName('fin').AsDateTime := edEstFHasta.Date;
         end;

         if not chEstClTodos.Checked then
                 SelectSQL.Add(' and c.id_cliente=' + edIdcliente.Text);

         if not chEstCCTodos.Checked then
                 SelectSQL.Add(' and c.id_ceco=' + edIdCeco.Text);

         if edFiltroTexto.Text<>'' then
            SelectSQL.Add(' and ((e.referencia like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(e.estado like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(e.linea like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.empresa like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.direccion like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.localidad like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.provincia like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.cp like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.referencia like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.barcode like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.cto_rmt like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.acuse like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.cli_nom like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.cli_cod like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.ceco_cod like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.ceco_nom like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.prod_nom like ''%' +  edFiltroTexto.Text + '%'' ) or ' +
                                '(c.zona_nom like ''%' +  edFiltroTexto.Text + '%'' ) ' +
                                ')');

        { case col_estado of
            0: SelectSQL.Add(' order by e.'+ gr1.Columns[col_estado].Title.Caption );
            1: SelectSQL.Add(' order by e.referencia');
            2: SelectSQL.Add(' order by e.estado');
         end;                  }

         SelectSQL.Add(' order by e.'+ gr1.Columns[col_estado].Title.Caption );

         Open;

      except
         ShowMessage('Error al cargar datos.');
      end;
    end;
end;


procedure Tfmain.VaciaCertificada;
begin
    edIdCert.Text := '';
    //edCeco.text:='';
    //lbCeco.caption:='(Seleccione un CECO válido)';
    //edIdCeco.Text := '';

    edEmpresa.Text := '';
    edDireccion.Text := '';
    edLocalidad.Text := '';
    edProvincia.Text := '';
    edCP.Text := '';
    edPais.Text := 'ES';
    edReferencia.Text := '';
    edCtoRmt.Text := '';
    //edPeso.Text := '';
     if rgSobre.ItemIndex=3 then
     begin
         edAlto.Text := '';
         edAncho.Text := '';
         edLargo.Text := '';
     end;
    bc.Visible := False;
    lbCertEstado.Caption := '(Sin estado)';
end;

procedure Tfmain.GetMedidasSobre;
begin
  with TpFIBDataSet.Create(dm) do
  try
     Database := dm.db;
     Close;
     SelectSQL.Add('select * from m_correos_sobres(' + IntToStr(rgSobre.ItemIndex) + ')');
     Open;

     edAlto.Value := FieldByName('alto').AsFloat;
     edAncho.Value := FieldByName('ancho').AsFloat;
     edLargo.Value := FieldByName('largo').AsFloat;

  finally
     Free;
  end;
end;

procedure Tfmain.GetCertEstado(id:Integer);
begin
  with TpFIBDataSet.Create(dm) do
  try
     Database := dm.db;
     Close;
     SelectSQL.Add('select first 1 estado from m_correos_certificadas_estados where id_correos_certificada=:id order by fecha desc ');
     ParamByName('id').AsInteger := id;
     Open;

     if not IsEmpty then
          lbCertEstado.Caption := FieldByName('estado').AsString
     else
          lbCertEstado.Caption := '(Sin estado)';
  finally
     Free;
  end;
end;

procedure Tfmain.ActualizaLogFile(ids, nombre:string);
begin
    with dm.q_1 do
      begin
        try
           dm.t_write.StartTransaction;

           Close;
           SQL.Clear;

           sql.add('update m_correos_certificadas set ' +
                   'file_date=:fecha, file_name=:nombre, file_path=:path ' +
                   'where id_correos_certificadas in (' + Copy(ids,0, Length(ids)-1) + ')');

           Close;

           ParamByName('fecha').AsDateTime := Now;
           ParamByName('nombre').AsString := ExtractFileName(nombre);
           ParamByName('path').AsString := ExtractFilePath(nombre);

           execquery;

           dm.t_write.CommitRetaining;
           //ShowMessage('Datos guardados correctamente.');

        except
           dm.t_write.RollbackRetaining;
           raise Exception.Create('Error al actualizar log del fichero.');
        end;
      end;


end;

function Tfmain.CalculaBarcode:string;
begin
  with TpFIBDataSet.Create(dm) do
  try
     Database := dm.db;
     Close;
     SelectSQL.Add('select * from m_get_cont_cert ');

     //ParamByName('ini').AsInt64 := bc_ini;
    // ParamByName('fin').AsInt64 := bc_fin;
     Open;

     if FieldByName('dif').AsInteger<=100 then
         ShowMessage('Quedan ' + IntToStr(FieldByName('dif').AsInteger) + ' etiquetas.');

     if FieldByName('cont').AsString='' then
          result := StringOfChar('0',11-length(IntToStr(bc_ini))) + IntToStr(bc_ini)
     else
          result := StringOfChar('0',11-length(FieldByName('cont').AsString)) + FieldByName('cont').AsString;


  finally
     Free;
  end;
end;

{$ENDREGION 'CERTIFICADA'}
end.

