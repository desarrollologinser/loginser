unit u_main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, math, sSkinProvider, sSkinManager, Buttons, types,strutils,
  sTooledit,Vcl.ExtCtrls, sPanel, sLabel,sdialogs,
  sEdit, sGroupBox, sPageControl, Vcl.ComCtrls, sMaskEdit, sCustomComboEdit,frxClass,
  frxDBSet,frxGradient,System.Win.ComObj,
  sCheckBox, sRadioButton, sComboBox, sStatusBar, acPNG, acImage,
  Data.DB, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, sSpeedButton,
  pFIBDatabase, pFIBDataSet, frxBarcode, JvBaseDlg, JvSelectDirectory,
  Datasnap.DBClient, pFIBClientDataSet, dxGDIPlusClasses;

type
  Tf_main = class(TForm)
    sk_manager: TsSkinManager;
    sknprvdr1: TsSkinProvider;
    pg_1: TsPageControl;
    ts_1: TsTabSheet;
    ts_2: TsTabSheet;
    bt_incidencia_send: TsSpeedButton;
    bt_print_resumen: TsSpeedButton;
    bt_elimina_incidencia: TsSpeedButton;
    bt_elimina_lectura: TsSpeedButton;
    lb_tot_lect: TsLabel;
    lb_tot_inc: TsLabel;
    fdb_1: TfrxDBDataset;
    fr_resumen: TfrxReport;
    bt_print_incid: TsSpeedButton;
    frdb_1: TfrxDBDataset;
    fr_incidencias: TfrxReport;
    bt_xls_resumen: TsSpeedButton;
    dl_save: TsSaveDialog;
    bt_xls_incid: TsSpeedButton;
    bt_leer: TsSpeedButton;
    ts_3: TsTabSheet;
    bt_elimina_digit: TsSpeedButton;
    lb_tot_digit: TsLabel;
    bt_xls_digit: TsSpeedButton;
    bt_print_digit: TsSpeedButton;
    frdb_digit: TfrxDBDataset;
    fr_digit: TfrxReport;
    bt_recall_ean: TsSpeedButton;
    bt_envia_digit: TsSpeedButton;
    gb_date: TsGroupBox;
    de_ini: TsDateEdit;
    gb_oficina_org: TsGroupBox;
    cb_ofi_org: TsCheckBox;
    ed_ofi_org: TsEdit;
    sb_ofi_org: TsSpeedButton;
    gb_oficina_dst: TsGroupBox;
    sb_ofi_dst: TsSpeedButton;
    cb_ofi_dst: TsCheckBox;
    ed_ofi_dst: TsEdit;
    lb_ofi_org: TsLabel;
    lb_ofi_dst: TsLabel;
    ed_ent_dst: TsEdit;
    ed_ent_org: TsEdit;
    gb_1: TsGroupBox;
    bt_import_xls: TsSpeedButton;
    cb_tipo_fichero: TsComboBox;
    dl_load: TsOpenDialog;
    Status: TsStatusBar;
    sImage1: TsImage;
    sGroupBox1: TsGroupBox;
    sLabel1: TsLabel;
    cb_traza: TsCheckBox;
    ed_traza: TsEdit;
    de_fin: TsDateEdit;
    nb_resumen: TJvDBGrid;
    nb_incidencias: TJvDBGrid;
    nb_resumen_digit: TJvDBGrid;
    lb1: TLabel;
    btn1: TButton;
    sGroupBox2: TsGroupBox;
    sLabel2: TsLabel;
    ch_caixa: TsCheckBox;
    ed_caixa: TsEdit;
    fopen: TJvSelectDirectory;
    lbImport: TLabel;
    btPedirTraza: TsSpeedButton;
    ch_pedir_traza_filt: TCheckBox;
    cds: TpFIBClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure init;
    procedure refresh_data;
    procedure bt_elimina_lecturaClick(Sender: TObject);
    procedure bt_elimina_incidenciaClick(Sender: TObject);
    procedure bt_incidencia_sendClick(Sender: TObject);
    procedure bt_print_resumenClick(Sender: TObject);
    procedure bt_print_incidClick(Sender: TObject);
    procedure bt_xls_resumenClick(Sender: TObject);
    procedure bt_xls_incidClick(Sender: TObject);
    procedure bt_leerClick(Sender: TObject);
    procedure nb_resumen_digitApplyCell(Sender: TObject; ACol, ARow: Integer;
      var Value: WideString);
    procedure bt_elimina_digitClick(Sender: TObject);
    procedure bt_xls_digitClick(Sender: TObject);
    procedure bt_print_digitClick(Sender: TObject);
    procedure bt_recall_eanClick(Sender: TObject);
    procedure bt_envia_digitClick(Sender: TObject);
    procedure rb_alldateClick(Sender: TObject);
    procedure sb_ofi_orgClick(Sender: TObject);
    procedure sb_ofi_dstClick(Sender: TObject);
    function busca_ofi_id(cod_ent,cod_ofi:integer):string;
    procedure ed_ent_orgExit(Sender: TObject);
    procedure ed_ent_dstExit(Sender: TObject);
    procedure cb_ofi_orgClick(Sender: TObject);
    function validate_org:Boolean;
    function validate_dst:Boolean;
    procedure cb_ofi_dstClick(Sender: TObject);
    procedure bt_import_xlsClick(Sender: TObject);
    procedure ed_trazaExit(Sender: TObject);
    procedure cb_trazaClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure ch_caixaClick(Sender: TObject);
    procedure btPedirTrazaClick(Sender: TObject);
    procedure pg_1Change(Sender: TObject);
    procedure ch_pedir_traza_filtClick(Sender: TObject);
  private
    { Private declarations }
    procedure creaExcel;
    procedure AbreFichero(ruta: string);
    procedure get_cliente_config(id_cliente:integer);
    procedure LoadConfigCliente(items: string);
    procedure rellena_tipo_fichero;
    function get_tarjeta(id_deleg:Integer;var id_val_tarj:integer):string;
  public
    { Public declarations }
    appCliente: integer;
  end;

var
  f_main: Tf_main;
  hiloactivo:Boolean  ;
  htmldevuelto:string;
  excel, xls, libro: Variant;
  hoja: OleVariant;
  main_cli,fmt_etiqueta:Integer;
  dig_sobres: integer;
  delegs_lect_especial, pos_ofi_lecturas: TStringDynArray;

const
//  Cliente = 182;
  Cliente = 2038;
  v = '[2]';

  ALERTA = 'LISTO';
  {Listo: puede crearse exe
   Vacio: hay algo en desarrollo y no se puede crear exe}

implementation

uses u_globals, u_dm, ubuscapro, u_incidencia,u_envia_mail, u_gen_gl, u_destino,
  u_lectura, u_recall, USendText;

{$R *.dfm}

{$REGION 'Ini-Close'}
procedure Tf_main.FormCreate(Sender: TObject);
begin
  if (ALERTA<>'LISTO') then
      ShowMessage('CUIDADO!!!!! PROYECTO EN DESARROLLO!!!! AVISA A INFORMATICA!!!');

  //u_globals.password:=ParamStr(1);                            //El password llega como primer parametro

  u_globals.leer_ini;                                         //carga ini

  sk_manager.SkinDirectory:=u_globals.resdir+'Skins\';     //Activa el skin
  sk_manager.SkinName:=u_globals.skinname;
  sk_manager.Active:=true;

  //u_globals.ini_bd;                                           //inicializa acceso a datos
  u_globals.ini_bd_simple;                                    //Para el REMOTO

  sk_manager.HueOffset:=u_globals.hue;                       //aplica colores a la piel
  sk_manager.Saturation:=u_globals.saturation;
                                                             //si no tiene posicion por defecto
  if u_globals.x<0 then u_globals.x:=(Screen.width-width) div 2;
  if u_globals.y<0 then u_globals.y:=(Screen.height-height) div 2;
 { if u_globals.w<0 then u_globals.w:=Width;
  if u_globals.h<0 then u_globals.h:=height;          }

  left:=u_globals.x;                                          //asigna posicion
  top:=u_globals.y;
 { Width:=u_globals.w;
  Height:=u_globals.h; }

  get_cliente_config(cliente);

  //caption:=u_globals.hint+' - '+u_globals.usuario+' ('+u_globals.permiso+')'+' - '+u_globals.empresa;
  //caption:='Proceso de Apertura de Valijas de Estafeta ' + v;                                              //Para el REMOTO
  caption:='BETA CAIXA-BANKIA';
  lb1.Caption := '';

  u_gen_gl.lee_inis_def;
  init;
  status.Panels[0].Text := dbname;

  rellena_tipo_fichero;

end;


procedure Tf_main.FormDblClick(Sender: TObject);
begin
   if HiWord(GetKeyState(VK_CONTROL)) <> 0 then
    btn1.Visible := not btn1.Visible;
end;

procedure Tf_main.FormDestroy(Sender: TObject);
begin
  u_globals.x:=left;                                          //guardar posicion actual
  u_globals.y:=top;
 { u_globals.w:=Width;                                         //guardar tamaño (si procede)
  u_globals.h:=Height;     }
  u_globals.guardar_pos;
end;

procedure Tf_main.init;
begin
  de_ini.Date:=Date;
  de_fin.Date:=Date;
  refresh_data;
end;

procedure Tf_main.ed_ent_dstExit(Sender: TObject);
begin
  validate_dst;
    if (cb_ofi_dst.Checked) then refresh_data;
end;

function Tf_main.validate_dst:Boolean;
var s:string;   i:Integer;
begin
  if ((TryStrToInt(ed_ent_dst.Text,i)) and (TryStrToInt(ed_ofi_dst.Text,i))) then begin
    s:=busca_ofi_id(strtoint(ed_ent_dst.Text),strtoint(ed_ofi_dst.Text));
    if s<>'' then lb_ofi_dst.caption:=s
    else lb_ofi_dst.Caption:='No Encontrado';
    Result:=true;
  end else begin
    lb_ofi_dst.Caption:='Tipo Erróneo';
    result:=False;
  end;
end;

procedure Tf_main.ed_ent_orgExit(Sender: TObject);
begin
  validate_org;
  if (cb_ofi_org.Checked) then refresh_data;

end;

procedure Tf_main.ed_trazaExit(Sender: TObject);
begin
  if ((ed_traza.Text<>'') and (cb_traza.checked)) then refresh_data;
end;

function Tf_main.validate_org:Boolean;
var s:string;   i:Integer;
begin
  if ((TryStrToInt(ed_ent_org.Text,i)) and (TryStrToInt(ed_ofi_org.Text,i))) then begin
    s:=busca_ofi_id(strtoint(ed_ent_org.Text),strtoint(ed_ofi_org.Text));
    if s<>'' then lb_ofi_org.caption:=s
    else lb_ofi_org.Caption:='No Encontrado';
    Result:=true;
  end else begin
    lb_ofi_org.Caption:='Tipo Erróneo';
    result:=False;
  end;
end;

procedure Tf_main.sb_ofi_dstClick(Sender: TObject);
begin
  with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='id_delegacion,cod_entidad,cod_delegacion,nombre,direccion,cp,poblacion,provincia';
    titulos.commatext:='Oficina, Entidad, Codigo,Nombre,Direccion,CP,Poblacion,Provincia';
    from:='e_delegaciones ';
    where:='estado=''A'' and id_cliente=' + IntToStr(main_cli);
    orden[1]:=2; orden[2]:=3;  busca:=3;   distinct:=1;   fillimpio:=True;

    showmodal;

    if resultado then begin
      with Sender as TsSpeedButton do begin
        ed_ofi_dst.text:=valor[3];
        ed_ent_dst.Text:=valor[2];
        lb_ofi_dst.caption:=valor[4];
      end;
    end;
  end;

  if cb_ofi_dst.Checked then refresh_data;
end;

procedure Tf_main.sb_ofi_orgClick(Sender: TObject);
begin
  with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='id_delegacion,cod_entidad,cod_delegacion,nombre,direccion,cp,poblacion,provincia';
    titulos.commatext:='Oficina, Entidad, Codigo,Nombre,Direccion,CP,Poblacion,Provincia';
    from:='e_delegaciones ';
    where:='estado=''A'' and id_cliente=' + IntToStr(main_cli);
    orden[1]:=2; orden[2]:=3;  busca:=3;   distinct:=1;   fillimpio:=True;

    showmodal;

    if resultado then begin
      with Sender as TsSpeedButton do begin
        ed_ofi_org.text:=valor[3];
        ed_ent_org.Text:=valor[2];
        lb_ofi_org.caption:=valor[4];
      end;
    end;
  end;

  if cb_ofi_org.Checked then refresh_data;
end;

procedure Tf_main.cb_ofi_dstClick(Sender: TObject);
begin
  if not(validate_dst) then raise exception.Create('Entidad/Oficina Destino Erronea');
  refresh_data;
end;

procedure Tf_main.cb_ofi_orgClick(Sender: TObject);
begin
  if not(validate_org) then raise exception.Create('Entidad/Oficina Origen Erronea');
  refresh_data;
end;

procedure Tf_main.cb_trazaClick(Sender: TObject);
begin
  refresh_data;
end;

procedure Tf_main.ch_caixaClick(Sender: TObject);
begin
  refresh_data;
end;

procedure Tf_main.ch_pedir_traza_filtClick(Sender: TObject);
begin
  refresh_data;
end;

procedure Tf_main.rb_alldateClick(Sender: TObject);
begin
 refresh_data;
end;

{$ENDREGION}

{$REGION 'Principal'}
procedure Tf_main.refresh_data;
begin
  nb_resumen.BeginUpdate;
  dm.q_resumen.Close;
  if cb_ofi_org.checked then begin
    if not(validate_org) then raise exception.Create('Entidad/Oficina Origen Erronea');
    dm.q_resumen.SelectSQL[17]:=' and d_org.cod_entidad=:org_cod_ent and d_org.cod_delegacion=:org_cod_del ';
    dm.q_resumen.ParamByName('org_cod_ent').Asinteger:=StrToInt(ed_ent_org.Text);
    dm.q_resumen.ParamByName('org_cod_del').Asinteger:=StrToInt(ed_ofi_org.Text);
  end else dm.q_resumen.SelectSQL[17]:='';

  if cb_ofi_dst.checked then begin
    if not(validate_dst) then raise exception.Create('Entidad/Oficina Destino Erronea');
    dm.q_resumen.SelectSQL[18]:=' and d_dst.cod_entidad=:dst_cod_ent and d_dst.cod_delegacion=:dst_cod_del ';
    dm.q_resumen.ParamByName('dst_cod_ent').Asinteger:=StrToInt(ed_ent_dst.Text);
    dm.q_resumen.ParamByName('dst_cod_del').Asinteger:=StrToInt(ed_ofi_dst.Text);
  end else dm.q_resumen.SelectSQL[18]:='';

  if ((cb_traza.Checked) and (ed_traza.Text<>'')) then begin
    dm.q_resumen.SelectSQL[19]:=' and traza=:traza ';
    dm.q_resumen.ParamByName('traza').Asstring:=ed_traza.Text;
  end else dm.q_resumen.SelectSQL[19]:='';

  if ((ch_caixa.Checked) and (ed_caixa.Text<>'')) then begin
    dm.q_resumen.SelectSQL[20]:=' and l.cod_caixa like (''%'  + ed_caixa.Text + '%'') ';
    //dm.q_resumen.ParamByName('caixa').Asstring:=;
  end else dm.q_resumen.SelectSQL[20]:='';

  if (ch_pedir_traza_filt.Checked) then begin
    dm.q_resumen.SelectSQL[21]:=' and d_org.pedir_traza=1 ';
  end else dm.q_resumen.SelectSQL[21]:='';


  dm.q_resumen.ParamByName('f_1').AsDate:=de_ini.Date;
  dm.q_resumen.ParamByName('f_2').AsDate:=de_fin.Date;
  dm.q_resumen.ParamByName('cliente').AsInteger:=main_cli;

  dm.q_resumen.Open;
  nb_resumen.EndUpdate;

  nb_incidencias.BeginUpdate;
  dm.q_incidencias.Close;
  if cb_ofi_org.checked then begin
    if not(validate_org) then raise exception.Create('Entidad/Oficina Origen Erronea');
    dm.q_incidencias.SelectSQL[8]:=' and d.cod_entidad=:org_cod_ent and d.cod_delegacion=:org_cod_del ';
    dm.q_incidencias.ParamByName('org_cod_ent').Asinteger:=StrToInt(ed_ent_org.Text);
    dm.q_incidencias.ParamByName('org_cod_del').Asinteger:=StrToInt(ed_ofi_org.Text);
  end else dm.q_incidencias.SelectSQL[8]:='';

  dm.q_incidencias.ParamByName('f_1').AsDate:=de_ini.Date;
  dm.q_incidencias.ParamByName('f_2').AsDate:=de_fin.Date;
  dm.q_incidencias.ParamByName('cliente').AsInteger:=main_cli;
  dm.q_incidencias.Open;
  nb_incidencias.EndUpdate;

  nb_resumen_digit.BeginUpdate;
  dm.q_resumen_digit.Close;
  if cb_ofi_org.checked then begin
    if not(validate_org) then raise exception.Create('Entidad/Oficina Origen Erronea');
    dm.q_resumen_digit.SelectSQL[16]:=' and d_org.cod_entidad=:org_cod_ent and d_org.cod_delegacion=:org_cod_del ';
    dm.q_resumen_digit.ParamByName('org_cod_ent').Asinteger:=StrToInt(ed_ent_org.Text);
    dm.q_resumen_digit.ParamByName('org_cod_del').Asinteger:=StrToInt(ed_ofi_org.Text);
  end else dm.q_resumen_digit.SelectSQL[16]:='';

  if cb_ofi_dst.checked then begin
    if not(validate_dst) then raise exception.Create('Entidad/Oficina Destino Erronea');
    dm.q_resumen_digit.SelectSQL[17]:=' and d_dst.cod_entidad=:dst_cod_ent and d_dst.cod_delegacion=:dst_cod_del ';
    dm.q_resumen_digit.ParamByName('dst_cod_ent').Asinteger:=StrToInt(ed_ent_dst.Text);
    dm.q_resumen_digit.ParamByName('dst_cod_del').Asinteger:=StrToInt(ed_ofi_dst.Text);
  end else dm.q_resumen_digit.SelectSQL[17]:='';

  dm.q_resumen_digit.ParamByName('f_1').AsDate:=de_ini.Date;
  dm.q_resumen_digit.ParamByName('f_2').AsDate:=de_fin.Date;
  dm.q_resumen_digit.ParamByName('cliente').AsInteger:=main_cli;
  dm.q_resumen_digit.Open;
  nb_resumen_digit.EndUpdate;

  dm.q_resumen_tot.Close;
  if cb_ofi_org.checked then begin
    if not(validate_org) then raise exception.Create('Entidad/Oficina Origen Erronea');
    dm.q_resumen_tot.SelectSQL[9]:=' and d_org.cod_entidad=:org_cod_ent and d_org.cod_delegacion=:org_cod_del ';
    dm.q_resumen_tot.ParamByName('org_cod_ent').Asinteger:=StrToInt(ed_ent_org.Text);
    dm.q_resumen_tot.ParamByName('org_cod_del').Asinteger:=StrToInt(ed_ofi_org.Text);
  end else dm.q_resumen_tot.SelectSQL[9]:='';

  if cb_ofi_dst.checked then begin
    if not(validate_dst) then raise exception.Create('Entidad/Oficina Destino Erronea');
    dm.q_resumen_tot.SelectSQL[10]:=' and d_dst.cod_entidad=:dst_cod_ent and d_dst.cod_delegacion=:dst_cod_del ';
    dm.q_resumen_tot.ParamByName('dst_cod_ent').Asinteger:=StrToInt(ed_ent_dst.Text);
    dm.q_resumen_tot.ParamByName('dst_cod_del').Asinteger:=StrToInt(ed_ofi_dst.Text);
  end else dm.q_resumen_tot.SelectSQL[10]:='';

  if ((cb_traza.Checked) and (ed_traza.Text<>'')) then begin
    dm.q_resumen_tot.SelectSQL[11]:=' and traza=:traza ';
    dm.q_resumen_tot.ParamByName('traza').Asstring:=ed_traza.Text;
  end else dm.q_resumen_tot.SelectSQL[11]:='';

  if ((ch_caixa.Checked) and (ed_caixa.Text<>'')) then begin
    dm.q_resumen_tot.SelectSQL[12]:=' and l.cod_caixa like (''%'  + ed_caixa.Text + '%'') ';
    //dm.q_resumen_tot.ParamByName('caixa').Asstring:=;
  end else dm.q_resumen_tot.SelectSQL[12]:='';

  if (ch_pedir_traza_filt.Checked) then begin
    dm.q_resumen_tot.SelectSQL[13]:=' and d_org.pedir_traza=1 ';
  end else dm.q_resumen_tot.SelectSQL[13]:='';

  dm.q_resumen_tot.ParamByName('f_1').AsDate:=de_ini.Date;
  dm.q_resumen_tot.ParamByName('f_2').AsDate:=de_fin.Date;
  dm.q_resumen_tot.ParamByName('cliente').AsInteger:=main_cli;
  dm.q_resumen_tot.Open;
  lb_tot_lect.Caption:='Total: '+dm.q_resumen_tot.FieldByName('total').asstring+' Lecturas, '+dm.q_resumen_tot.FieldByName('bultos').asstring+' Sobres';
  ts_1.Caption:='Resumen Lecturas ('+dm.q_resumen_tot.FieldByName('total').asstring+')';


  dm.q_incidencias_tot.Close;
  if cb_ofi_org.checked then begin
    if not(validate_org) then raise exception.Create('Entidad/Oficina Origen Erronea');
    dm.q_incidencias_tot.SelectSQL[7]:=' and d.cod_entidad=:org_cod_ent and d.cod_delegacion=:org_cod_del ';
    dm.q_incidencias_tot.ParamByName('org_cod_ent').Asinteger:=StrToInt(ed_ent_org.Text);
    dm.q_incidencias_tot.ParamByName('org_cod_del').Asinteger:=StrToInt(ed_ofi_org.Text);
  end else dm.q_incidencias_tot.SelectSQL[7]:='';

  dm.q_incidencias_tot.ParamByName('f_1').AsDate:=de_ini.Date;
  dm.q_incidencias_tot.ParamByName('f_2').AsDate:=de_fin.Date;
  dm.q_incidencias_tot.ParamByName('cliente').AsInteger:=main_cli;
  dm.q_incidencias_tot.Open;
  lb_tot_inc.Caption:='Total: '+dm.q_incidencias_tot.FieldByName('total').asstring+' Incidencias';
  ts_2.Caption:='Incidencias ('+dm.q_incidencias_tot.FieldByName('total').asstring+')';



  dm.q_resumen_digit_tot.Close;
  if cb_ofi_org.checked then begin
    if not(validate_org) then raise exception.Create('Entidad/Oficina Origen Erronea');
    dm.q_resumen_digit_tot.SelectSQL[8]:=' and d_org.cod_entidad=:org_cod_ent and d_org.cod_delegacion=:org_cod_del ';
    dm.q_resumen_digit_tot.ParamByName('org_cod_ent').Asinteger:=StrToInt(ed_ent_org.Text);
    dm.q_resumen_digit_tot.ParamByName('org_cod_del').Asinteger:=StrToInt(ed_ofi_org.Text);
  end else dm.q_resumen_digit_tot.SelectSQL[8]:='';

  if cb_ofi_dst.checked then begin
    if not(validate_dst) then raise exception.Create('Entidad/Oficina Destino Erronea');
    dm.q_resumen_digit_tot.SelectSQL[9]:=' and d_dst.cod_entidad=:dst_cod_ent and d_dst.cod_delegacion=:dst_cod_del ';
    dm.q_resumen_digit_tot.ParamByName('dst_cod_ent').Asinteger:=StrToInt(ed_ent_dst.Text);
    dm.q_resumen_digit_tot.ParamByName('dst_cod_del').Asinteger:=StrToInt(ed_ofi_dst.Text);
  end else dm.q_resumen_digit_tot.SelectSQL[9]:='';

  dm.q_resumen_digit_tot.ParamByName('f_1').AsDate:=de_ini.Date;
  dm.q_resumen_digit_tot.ParamByName('f_2').AsDate:=de_fin.Date;
  dm.q_resumen_digit_tot.ParamByName('cliente').AsInteger:=main_cli;
  dm.q_resumen_digit_tot.Open;
  lb_tot_digit.Caption:='Total: '+dm.q_resumen_digit_tot.FieldByName('total').asstring+' Lecturas, '+dm.q_resumen_digit_tot.FieldByName('bultos').asstring+' Sobres';
  ts_3.Caption:='Digitalizaciones ('+dm.q_resumen_digit_tot.FieldByName('total').asstring+')';
end;


procedure Tf_main.nb_resumen_digitApplyCell(Sender: TObject; ACol, ARow: Integer;
  var Value: WideString);
begin
  if ACol=8 then begin
    if Value='0' then Value:='No';
    if Value='1' then Value:='Sí';
  end;
end;

procedure Tf_main.pg_1Change(Sender: TObject);
begin
end;

{$ENDREGION}

{$REGION 'Lecturas'}
procedure Tf_main.bt_elimina_lecturaClick(Sender: TObject);
begin
  if sMessageDlg('Está seguro de Eliminar la Lectura?',mtconfirmation,[mbyes,mbno],0)=mrYes then begin
    dm.t_write.StartTransaction;
    try
      dm.qr_update.Close;
      dm.qr_update.SQL.Clear;
      dm.qr_update.SQL.Add('delete from e_lecturas_estafeta where id_lectura_estafeta=:id_lectura_estafeta');
      dm.qr_update.ParamByName('id_lectura_estafeta').AsInteger:=dm.q_resumen.FieldByName('id_lectura_estafeta').AsInteger;;
      dm.qr_update.ExecQuery;

      dm.t_write.CommitRetaining;
    except
      dm.t_write.RollbackRetaining;
      sMessageDlg('Error Grabando Datos',mtError,[mbok],0);
    end;

    refresh_data;
  end;
end;

procedure Tf_main.bt_xls_resumenClick(Sender: TObject);
var
  r, i: integer;
begin
 { if dl_save.Execute then begin
    xls_db.Dataset:=dm.q_resumen;
    xls_db.Read;
    xls_1.filename:=dl_save.FileName;
    xls_1.Write;
  end;   }

  //cds.SaveToFile('c:\temp\quecansino.xls',dfXMLUTF8);
 // dm.q_resumen.SaveToFile('c:\temp\quecansino.txt');

  if dl_save.Execute then
  begin
    if dm.q_resumen.RecordCount>0 then
    begin
       Screen.Cursor := crHourGlass;

       lb1.Caption := 'Creando fichero de lecturas ...';
       CreaExcel;
       r := 1;
       dm.q_resumen.First;

       excel.cells[r, 1] := 'ID_LECTURA_ESTAFETA';
       excel.cells[r, 2] := 'FECHA';
       excel.cells[r, 3] := 'HORA';
       excel.cells[r, 4] := 'BULTOS';
       excel.cells[r, 5] := 'LLENO';
       excel.cells[r, 6] := 'COD_DELEGACION_ORG';
       excel.cells[r, 7] := 'NOMBRE_ORG';
       excel.cells[r, 8] := 'DIRECCION_ORG';
       excel.cells[r, 9] := 'CP_ORG';
       excel.cells[r, 10] := 'POBLACION_ORG';
       excel.cells[r, 11] := 'PROVINCIA_ORG';
       excel.cells[r, 12] := 'COD_DELEGACION_DST';
       excel.cells[r, 13] := 'NOMBRE_DST';
       excel.cells[r, 14] := 'DIRECCION_DST';
       excel.cells[r, 15] := 'CP_DST';
       excel.cells[r, 16] := 'POBLACION_DST';
       excel.cells[r, 17] := 'PROVINCIA_DST';
       excel.cells[r, 18] := 'TRAZA';
       excel.cells[r, 19] := 'COD_CAIXA';
       excel.cells[r, 20] := 'COD_DELEG_VALIJA_DST';
       //excel.cells[r, 21] := 'NOMBRE_VALIJA_DST';
       //excel.cells[r, 22] := 'DIRECCION_VALIJA_DST';
       //excel.cells[r, 23] := 'CP_VALIJA_DST';
       //excel.cells[r, 24] := 'POBLACION_VALIJA_DST';
       //excel.cells[r, 25] := 'PROVINCIA_VALIJA_DST';
       Inc(r);

       while not dm.q_resumen.Eof do
       begin
         lb1.Caption := 'Exportando linea ' + IntToStr(r-1) + '/' + IntToStr(dm.q_resumen.RecordCount) + ' ...';
         excel.cells[r, 1] := dm.q_resumen.FieldByName('ID_LECTURA_ESTAFETA').AsInteger;
         excel.cells[r, 2] := FormatDateTime('dd/mm/yyyy',dm.q_resumen.FieldByName('FECHA').AsDateTime);
         excel.cells[r, 3] := FormatDateTime('hh:nn:ss',dm.q_resumen.FieldByName('HORA').AsDateTime);
         excel.cells[r, 4] := dm.q_resumen.FieldByName('BULTOS').AsInteger;
         excel.cells[r, 5] := dm.q_resumen.FieldByName('LLENO').AsInteger;
         excel.cells[r, 6] := dm.q_resumen.FieldByName('COD_DELEGACION_ORG').AsString;
         excel.cells[r, 7] := dm.q_resumen.FieldByName('NOMBRE_ORG').AsString;
         excel.cells[r, 8] := dm.q_resumen.FieldByName('DIRECCION_ORG').AsString;
         excel.cells[r, 9] := dm.q_resumen.FieldByName('CP_ORG').AsString;
         excel.cells[r, 10] := dm.q_resumen.FieldByName('POBLACION_ORG').AsString;
         excel.cells[r, 11] := dm.q_resumen.FieldByName('PROVINCIA_ORG').AsString;
         excel.cells[r, 12] := dm.q_resumen.FieldByName('COD_DELEGACION_DST').AsString;
         excel.cells[r, 13] := dm.q_resumen.FieldByName('NOMBRE_DST').AsString;
         excel.cells[r, 14] := dm.q_resumen.FieldByName('DIRECCION_DST').AsString;
         excel.cells[r, 15] := dm.q_resumen.FieldByName('CP_DST').AsString;
         excel.cells[r, 16] := dm.q_resumen.FieldByName('POBLACION_DST').AsString;
         excel.cells[r, 17] := dm.q_resumen.FieldByName('PROVINCIA_DST').AsString;
         excel.cells[r, 18] := dm.q_resumen.FieldByName('TRAZA').AsString;
         excel.cells[r, 19] := dm.q_resumen.FieldByName('COD_CAIXA').AsString;
         excel.cells[r, 20] := dm.q_resumen.FieldByName('COD_VLJ_DST').AsString;
        { if dm.q_resumen.FieldByName('COD_DELEGACION_DST').AsString=dm.q_resumen.FieldByName('COD_VLJ_DST').AsString then
         begin
             excel.cells[r, 20] := '';
             excel.cells[r, 21] := '';
             excel.cells[r, 22] := '';
             excel.cells[r, 23] := '';
             excel.cells[r, 24] := '';
             excel.cells[r, 25] := '';
         end else begin
                 excel.cells[r, 20] := dm.q_resumen.FieldByName('COD_VLJ_DST').AsString;
                 excel.cells[r, 21] := dm.q_resumen.FieldByName('NOM_VLJ_DST').AsString;
                 excel.cells[r, 22] := dm.q_resumen.FieldByName('DIR_VLJ_DST').AsString;
                 excel.cells[r, 23] := dm.q_resumen.FieldByName('CP_VLJ_DST').AsString;
                 excel.cells[r, 24] := dm.q_resumen.FieldByName('POBL_VLJ_DST').AsString;
                 excel.cells[r, 25] := dm.q_resumen.FieldByName('PROV_VLJ_DST').AsString;
             end;  }

         Inc(r);
         dm.q_resumen.Next;
       end;

       excel.activeworkbook.saveas(dl_save.FileName);
       excel.Quit;
       excel := Unassigned;

       Screen.Cursor := crDefault;

       lb1.Caption := 'Exportación de lecturas finalizada.';
       ShowMessage('Exportación de lecturas finalizada.');
    end else ShowMessage('No existen lecturas a exportar.');

  end;

  {if dl_save.Execute then begin
    xls_db.Dataset:=dm.q_resumen;
    xls_db.Read;
    xls_1.filename:=dl_save.FileName;
    xls_1.Write;
  end; }
  end;

procedure Tf_main.bt_print_resumenClick(Sender: TObject);
var  memo: TfrxMemoView;
begin
  memo := fr_resumen.FindObject('m_fecha') as TfrxMemoView;
  memo.Memo.clear;   memo.Memo.Add('Fecha Desde '+formatdatetime('dd/mm/yyyy',de_ini.date)+' Hasta '+formatdatetime('dd/mm/yyyy',de_fin.date));

  if fr_resumen.preparereport(true) then fr_resumen.ShowPreparedReport;
end;
{$ENDREGION}

{$REGION 'Incidencias'}
procedure Tf_main.bt_elimina_incidenciaClick(Sender: TObject);
begin
  if sMessageDlg('Está seguro de Eliminar la Incidencia?',mtconfirmation,[mbyes,mbno],0)=mrYes then begin
    dm.t_write.StartTransaction;
    try
      dm.qr_update.Close;
      dm.qr_update.SQL.Clear;
      dm.qr_update.SQL.Add('delete from e_incidencias_estafeta where id_incidencias_estafeta=:id_incidencias_estafeta');
      dm.qr_update.ParamByName('id_incidencias_estafeta').AsInteger:=dm.q_incidencias.FieldByName('id_incidencias_estafeta').AsInteger;
      dm.qr_update.ExecQuery;

      dm.t_write.CommitRetaining;
    except
      dm.t_write.RollbackRetaining;
      sMessageDlg('Error Grabando Datos',mtError,[mbok],0);
    end;

    refresh_data;
  end;
end;

procedure Tf_main.bt_xls_incidClick(Sender: TObject);
var
  r, i: integer;
begin
  if dl_save.Execute then begin
    if dm.q_incidencias.RecordCount>0 then
    begin
       Screen.Cursor := crHourGlass;
       lb1.Caption := 'Creando fichero de incidencias ...';

       CreaExcel;
       r := 1;
       dm.q_incidencias.First;

       excel.cells[r, 1] := 'ID_INCIDENCIAS_ESTAFETA';
       excel.cells[r, 2] := 'FECHA';
       excel.cells[r, 3] := 'HORA';
       excel.cells[r, 4] := 'INCID_NOMBRE';
       excel.cells[r, 5] := 'OBSERVACIONES';
       excel.cells[r, 6] := 'COD_DELEGACION';
       excel.cells[r, 7] := 'NOMBRE';
       excel.cells[r, 8] := 'DIRECCION';
       excel.cells[r, 9] := 'CP';
       excel.cells[r, 10] := 'POBLACION';
       excel.cells[r, 11] := 'PROVINCIA';
       excel.cells[r, 12] := 'ID_DELEGACION';
       excel.cells[r, 13] := 'ID_TIPO_INCIDENCIA_EST';
       excel.cells[r, 14] := 'COD_ENTIDAD';
       Inc(r);

       while not dm.q_incidencias.Eof do
       begin
         lb1.Caption := 'Exportando linea ' + IntToStr(r-1) + '/' + IntToStr(dm.q_incidencias.RecordCount) + ' ...';
         excel.cells[r, 1] := dm.q_incidencias.FieldByName('ID_INCIDENCIAS_ESTAFETA').AsInteger;
         excel.cells[r, 2] := FormatDateTime('dd/mm/yyyy',dm.q_incidencias.FieldByName('FECHA').AsDateTime);
         excel.cells[r, 3] := FormatDateTime('hh:nn:ss',dm.q_incidencias.FieldByName('HORA').AsDateTime);
         excel.cells[r, 4] := dm.q_incidencias.FieldByName('INCID_NOMBRE').AsString;
         excel.cells[r, 5] := dm.q_incidencias.FieldByName('OBSERVACIONES').AsString;
         excel.cells[r, 6] := dm.q_incidencias.FieldByName('COD_DELEGACION').AsString;
         excel.cells[r, 7] := dm.q_incidencias.FieldByName('NOMBRE').AsString;
         excel.cells[r, 8] := dm.q_incidencias.FieldByName('DIRECCION').AsString;
         excel.cells[r, 9] := dm.q_incidencias.FieldByName('CP').AsString;
         excel.cells[r, 10] := dm.q_incidencias.FieldByName('POBLACION').AsString;
         excel.cells[r, 11] := dm.q_incidencias.FieldByName('PROVINCIA').AsString;
         excel.cells[r, 12] := dm.q_incidencias.FieldByName('ID_DELEGACION').AsInteger;
         excel.cells[r, 13] := dm.q_incidencias.FieldByName('ID_TIPO_INCIDENCIA_EST').AsInteger;
         excel.cells[r, 14] := dm.q_incidencias.FieldByName('COD_ENTIDAD').AsInteger;
         Inc(r);
         dm.q_incidencias.Next;
       end;

       excel.activeworkbook.saveas(dl_save.FileName);
       excel.Quit;
       excel := Unassigned;

       Screen.Cursor := crDefault;

       lb1.Caption := 'Exportación de incidencias finalizada.';
       ShowMessage('Exportación de incidencias finalizada.');

    end else ShowMessage('No existen incidencias a exportar.');

   { xls_db.Dataset:=dm.q_incidencias;
    xls_db.Read;
    xls_1.filename:=dl_save.FileName;
    xls_1.Write;       }
  end;
end;

procedure Tf_main.bt_print_incidClick(Sender: TObject);
var  memo: TfrxMemoView;
begin
  memo := fr_incidencias.FindObject('m_fecha') as TfrxMemoView;
  memo.Memo.clear;   memo.Memo.Add('Fecha Desde '+formatdatetime('dd/mm/yyyy',de_ini.date)+' Hasta '+formatdatetime('dd/mm/yyyy',de_fin.date));

  if fr_incidencias.preparereport(true) then fr_incidencias.ShowPreparedReport;
end;

procedure Tf_main.bt_incidencia_sendClick(Sender: TObject);
var   cuerpo,cuerpo_global:tstringlist;   email:string;     ofics:tstringlist;    i,n_incids,n_incids_glob:integer;
begin
  nb_incidencias.beginupdate;

  ofics:=tstringlist.create();
  dm.q_incidencias.first;                                                //oficinas distintas
  while not(dm.q_incidencias.eof) do begin
    if dm.q_incidencias.fieldbyname('cod_entidad').asinteger=900 then begin
      if ofics.indexof(dm.q_incidencias.fieldbyname('id_delegacion').asstring)=-1 then ofics.add(dm.q_incidencias.fieldbyname('id_delegacion').asstring);
    end;
    dm.q_incidencias.next;
  end;

  for i:=0 to ofics.Count-1 do begin


  end;

  cuerpo_global:=tstringlist.create();
  cuerpo_global.Add('Estimado cliente<br><br><br>');
  cuerpo_global.Add('Le informamos que se han registrado una serie de incidencias con el servicio de valijas:<br><br>');
  for i:=0 to ofics.count-1 do begin
    n_incids:=0;  n_incids_glob:=0;
    cuerpo:=tstringlist.create();
    cuerpo.Add('Estimado cliente<br><br><br>');
    cuerpo.Add('Le informamos que se han registrado una serie de incidencias con el servicio de valijas:<br><br>');

    dm.q_incidencias.first;                                                //oficinas distintas
    while not(dm.q_incidencias.eof) do begin
      if ofics[i]=dm.q_incidencias.fieldbyname('id_delegacion').asstring then begin
        if (dm.q_incidencias.fieldbyname('id_tipo_incidencia_est').asinteger<9) then begin

          dm.q_1.Close;
          dm.q_1.SelectSQL.Clear;
          dm.q_1.SelectSQL.Add('select enviar_incidencia_est,enviar_incidencia_precinto from e_delegaciones '+
            'where id_delegacion=:id_delegacion');
          dm.q_1.ParamByName('id_delegacion').AsInteger:=dm.q_incidencias.fieldbyname('id_delegacion').AsInteger;
          dm.q_1.Open;

          if ((dm.q_incidencias.fieldbyname('id_tipo_incidencia_est').asinteger<>4) or         //no es incidencia de precinto o
            (dm.q_1.FieldByName('enviar_incidencia_precinto').asinteger=1)) then begin         //si hay que enviar incidencia de precinto
            Inc(n_incids);
            cuerpo.Add('<b>Tipo Incidencia:</b> '+dm.q_incidencias.FieldByName('incid_nombre').AsString+'<br>'+
              '<b>Origen:</b> '+dm.q_incidencias.FieldByName('nombre').AsString+' - '+dm.q_incidencias.FieldByName('direccion').AsString+' - '+dm.q_incidencias.FieldByName('cp').AsString+' - '+
              dm.q_incidencias.FieldByName('poblacion').AsString+' - '+dm.q_incidencias.FieldByName('provincia').AsString+'<br>'+
              '<b>Observaciones:</b> '+dm.q_incidencias.FieldByName('observaciones').AsString+'<br><br>');
            if (dm.q_1.FieldByName('enviar_incidencia_est').asinteger=1) then begin
              Inc(n_incids_glob);
              cuerpo_global.Add('<b>Tipo Incidencia:</b> '+dm.q_incidencias.FieldByName('incid_nombre').AsString+'<br>'+
                '<b>Origen:</b> '+dm.q_incidencias.FieldByName('nombre').AsString+' - '+dm.q_incidencias.FieldByName('direccion').AsString+' - '+dm.q_incidencias.FieldByName('cp').AsString+' - '+
                dm.q_incidencias.FieldByName('poblacion').AsString+' - '+dm.q_incidencias.FieldByName('provincia').AsString+'<br>'+
                '<b>Observaciones:</b> '+dm.q_incidencias.FieldByName('observaciones').AsString+'<br><br>');
            end;
          end;
        end;
      end;
      dm.q_incidencias.next;
    end;

//    if n_incids>0 then begin
//      cuerpo.Add('Por favor, NO responda a este correo, en caso de duda contacte con distribucionbankia@loginser.com.<br><br>');
//      cuerpo.Add('Un saludo');
//
//      dm.q_2.close;
//      dm.q_2.selectsql.clear;
//      dm.q_2.selectsql.add('select email from e_delegaciones where id_delegacion=:id_delegacion');
//      dm.q_2.parambyname('id_delegacion').asinteger:=strtoint(ofics[i]);
//      dm.q_2.open;
//
//      email:=dm.q_2.fieldbyname('email').asstring;
//
//      f_envia_mail.Show;
//      f_envia_mail.envia_email(email,'',
//      //f_envia_mail.envia_email('informatica@loginser.com','informatica@loginser.com',
//            'Loginser-Incidencias Valijas',
//            '',
//            cuerpo,
//            2);
//      f_envia_mail.close;
//    end;

    cuerpo.free;
  end;
  nb_incidencias.endupdate;

  cuerpo_global.Add('Por favor, NO responda a este correo, en caso de duda contacte con distribucionbankia@loginser.com.<br><br>');
  cuerpo_global.Add('Un saludo');

  if n_incids_glob>0 then begin
    f_envia_mail.Show;
    f_envia_mail.envia_email(u_globals.email_global_disc,'gerencia@loginser.com,informatica@loginser.com',
    //f_envia_mail.envia_email('gerencia@loginser.com','informatica@loginser.com',
          'Global Loginser-Incidencias Valijas',
          '','',
          cuerpo_global,
          2);
    f_envia_mail.close;
  end;
  cuerpo_global.Free;
end;
{$ENDREGION}

{$REGION 'Digitalización'}
procedure Tf_main.btn1Click(Sender: TObject);
var
  deleg, delegC: TfrxMemoView;
  bc: TfrxBarCodeView;
  ean: string; id_valija:integer;
begin
      ean := '300900381101001700000';
      id_valija:= 5643;

      if f_lectura.cbFmt.ItemIndex<0 then
          f_lectura.cbFmt.ItemIndex := fmt_etiqueta;

      case f_lectura.cbFmt.ItemIndex of
      0: begin
            delegC := f_lectura.frxEtiqCaixa.FindObject('Memo2') as TfrxMemoView;
            deleg := f_lectura.frxEtiqCaixa.FindObject('Memo1') as TfrxMemoView;
            bc := f_lectura.frxEtiqCaixa.FindObject('BarCode1') as TfrxBarCodeView;
         end;
      1: begin
               delegC := f_lectura.frxEtiqInd.FindObject('Memo2') as TfrxMemoView;
               deleg := f_lectura.frxEtiqInd.FindObject('Memo1') as TfrxMemoView;
               bc := f_lectura.frxEtiqInd.FindObject('BarCode1') as TfrxBarCodeView;
           end;
      end;

      if Assigned(delegC) then
          if Pos('-',ean)>0 then
                delegC.Text := Trim('001-XXXX Centro Caixa')
           else
                delegC.Text := Trim(ent_caixa + '-' + 'XXXX' + ' Centro Caixa');

        if Assigned(deleg) then
          deleg.Text := Trim('OF.XXXX BANKIA');

        if Length(ean)<21 then
        begin
          with dm.q_1 do
          begin
            Close;
            SelectSQL.Clear;
            SelectSQL.Add('select first 1 ean from e_valijas_tarjetas t ' +
                          'where t.id_valija=:id_valija ');
            ParamByName('id_valija').AsInteger := id_valija;
            Open;

            if not IsEmpty then
            begin
               if Assigned(bc) then
                   //bc.Text := FieldByName('ean').AsString;
                   bc.text := ean;
            end else
                    if Assigned(bc) then
                        bc.Text := ean;
          end;
        end
        else begin
               if Assigned(bc) then
                   bc.Text := ean;
        end;

      case f_lectura.cbFmt.ItemIndex of
        0: begin
              f_lectura.frxEtiqCaixa.printoptions.printer := u_globals.imp_eti;
              f_lectura.frxEtiqCaixa.PrintOptions.ShowDialog := False;
              if f_lectura.frxEtiqCaixa.PrepareReport(true) then
                   f_lectura.frxEtiqCaixa.Print;
        end;

        1: begin
              f_lectura.frxEtiqInd.printoptions.printer := u_globals.imp_eti;
              f_lectura.frxEtiqInd.PrintOptions.ShowDialog := False;
              if f_lectura.frxEtiqInd.PrepareReport(true) then
                   f_lectura.frxEtiqInd.Print;
        end;
      end;

end;

procedure Tf_main.btPedirTrazaClick(Sender: TObject);
var
  traza: string;
  id_lectura: integer;
begin
  if dm.q_resumen.FieldByName('id_lectura_estafeta').asinteger<=0 then
  begin
    sShowMessage('Error traza', 'Lectura desconocida.');
    Exit;
  end;

  if dm.q_resumen.FieldByName('traza').AsString<>'' then
  begin
     if sMessageDlg('La lectura ya tiene traza: ' + #13#10 + dm.q_resumen.FieldByName('traza').AsString + #13#10 + ' ¿Sobreescribir?',mtWarning, mbYesNo,mrNo)=mrNo then
          Exit;
  end;

  traza:=InputBox('Traza','Traza','');

  if traza='' then
  begin
     if sMessageDlg('Traza vacía, ¿desea continuar?',mtWarning, mbYesNo,mrNo)=mrNo then
          Exit;
  end;

  id_lectura := dm.q_resumen.FieldByName('id_lectura_estafeta').asinteger;
  if  (dm.q_resumen.FieldByName('id_lectura_estafeta').asinteger>0) then
    f_lectura.update_lectura(dm.q_resumen.FieldByName('id_lectura_estafeta').asinteger,traza)
  else
      sShowMessage('Error traza', 'Lectura desconocida.');

  refresh_data;
  dm.q_resumen.Locate('id_lectura_estafeta',id_lectura,[]);

end;

procedure Tf_main.bt_elimina_digitClick(Sender: TObject);
begin
  if sMessageDlg('Está seguro de Eliminar la Digitalización?',mtconfirmation,[mbyes,mbno],0)=mrYes then begin
    dm.t_write.StartTransaction;
    try
      dm.qr_update.Close;
      dm.qr_update.SQL.Clear;
      dm.qr_update.SQL.Add('delete from e_lecturas_estafeta where id_lectura_estafeta=:id_lectura_estafeta');
      dm.qr_update.ParamByName('id_lectura_estafeta').AsInteger:=dm.q_resumen_digit.FieldByName('id_lectura_estafeta').AsInteger;;
      dm.qr_update.ExecQuery;

      dm.t_write.CommitRetaining;
    except
      dm.t_write.RollbackRetaining;
      sMessageDlg('Error Grabando Datos',mtError,[mbok],0);
    end;

    refresh_data;
  end;
end;

procedure Tf_main.bt_xls_digitClick(Sender: TObject);
var
  r, i: integer;
begin
  if dl_save.Execute then
  begin
    if dm.q_resumen_digit.RecordCount>0 then
    begin
       Screen.Cursor := crHourGlass;
       lb1.Caption := 'Creando fichero de digitalizaciones ...';

       CreaExcel;
       r := 1;
       dm.q_resumen_digit.First;

       excel.cells[r, 1] := 'ID_LECTURA_ESTAFETA';
       excel.cells[r, 2] := 'FECHA';
       excel.cells[r, 3] := 'HORA';
       excel.cells[r, 4] := 'BULTOS';
       excel.cells[r, 5] := 'LLENO';
       excel.cells[r, 6] := 'COD_DELEGACION_ORG';
       excel.cells[r, 7] := 'NOMBRE_ORG';
       excel.cells[r, 8] := 'DIRECCION_ORG';
       excel.cells[r, 9] := 'CP_ORG';
       excel.cells[r, 10] := 'POBLACION_ORG';
       excel.cells[r, 11] := 'PROVINCIA_ORG';
       excel.cells[r, 12] := 'COD_DELEGACION_DST';
       excel.cells[r, 13] := 'NOMBRE_DST';
       excel.cells[r, 14] := 'DIRECCION_DST';
       excel.cells[r, 15] := 'CP_DST';
       excel.cells[r, 16] := 'POBLACION_DST';
       excel.cells[r, 17] := 'PROVINCIA_DST';
       excel.cells[r, 18] := 'ORG_COD_ENTIDAD';
       excel.cells[r, 19] := 'ORG_COD_DELEGACION';
       excel.cells[r, 20] := 'DST_COD_ENTIDAD';
       excel.cells[r, 21] := 'DST_COD_DELEGACION';
       excel.cells[r, 22] := 'EAN';
       Inc(r);

       while not dm.q_resumen_digit.Eof do
       begin
         lb1.Caption := 'Exportando linea ' + IntToStr(r-1) + '/' + IntToStr(dm.q_resumen_digit.RecordCount) + ' ...';
         excel.cells[r, 1] := dm.q_resumen_digit.FieldByName('ID_LECTURA_ESTAFETA').AsInteger;
         excel.cells[r, 2] := FormatDateTime('dd/mm/yyyy',dm.q_resumen_digit.FieldByName('FECHA').AsDateTime);
         excel.cells[r, 3] := FormatDateTime('hh:nn:ss',dm.q_resumen_digit.FieldByName('HORA').AsDateTime);
         excel.cells[r, 4] := dm.q_resumen_digit.FieldByName('BULTOS').AsInteger;
         excel.cells[r, 5] := dm.q_resumen_digit.FieldByName('LLENO').AsInteger;
         excel.cells[r, 6] := dm.q_resumen_digit.FieldByName('COD_DELEGACION_ORG').AsString;
         excel.cells[r, 7] := dm.q_resumen_digit.FieldByName('NOMBRE_ORG').AsString;
         excel.cells[r, 8] := dm.q_resumen_digit.FieldByName('DIRECCION_ORG').AsString;
         excel.cells[r, 9] := dm.q_resumen_digit.FieldByName('CP_ORG').AsString;
         excel.cells[r, 10] := dm.q_resumen_digit.FieldByName('POBLACION_ORG').AsString;
         excel.cells[r, 11] := dm.q_resumen_digit.FieldByName('PROVINCIA_ORG').AsString;
         excel.cells[r, 12] := dm.q_resumen_digit.FieldByName('COD_DELEGACION_DST').AsString;
         excel.cells[r, 13] := dm.q_resumen_digit.FieldByName('NOMBRE_DST').AsString;
         excel.cells[r, 14] := dm.q_resumen_digit.FieldByName('DIRECCION_DST').AsString;
         excel.cells[r, 15] := dm.q_resumen_digit.FieldByName('CP_DST').AsString;
         excel.cells[r, 16] := dm.q_resumen_digit.FieldByName('POBLACION_DST').AsString;
         excel.cells[r, 17] := dm.q_resumen_digit.FieldByName('PROVINCIA_DST').AsString;
         excel.cells[r, 18] := dm.q_resumen_digit.FieldByName('ORG_COD_ENTIDAD').AsInteger;
         excel.cells[r, 19] := dm.q_resumen_digit.FieldByName('ORG_COD_DELEGACION').AsInteger;
         excel.cells[r, 20] := dm.q_resumen_digit.FieldByName('DST_COD_ENTIDAD').AsInteger;
         excel.cells[r, 21] := dm.q_resumen_digit.FieldByName('DST_COD_DELEGACION').AsInteger;
         excel.cells[r, 22] := dm.q_resumen_digit.FieldByName('EAN').AsString;

         Inc(r);
         dm.q_resumen_digit.Next;
       end;

       excel.activeworkbook.saveas(dl_save.FileName);
       excel.Quit;
       excel := Unassigned;

       Screen.Cursor := crDefault;

       lb1.Caption := 'Exportación de digitalizaciones finalizada.';
       ShowMessage('Exportación de digitalizaciones finalizada.');

    end else ShowMessage('No existen digitalizaciones a exportar.');

  end;


 //CODIGO ANTIGUO
 { if dl_save.Execute then begin
    xls_db.Dataset:=dm.q_resumen_digit;
    xls_db.Read;
    xls_1.filename:=dl_save.FileName;
    xls_1.Write;}
  end;


procedure Tf_main.bt_print_digitClick(Sender: TObject);
var  memo: TfrxMemoView;
begin
  memo := fr_digit.FindObject('m_fecha') as TfrxMemoView;
  memo.Memo.clear;   memo.Memo.Add('Fecha Desde '+formatdatetime('dd/mm/yyyy',de_ini.Date)+' Hasta '+formatdatetime('dd/mm/yyyy',de_fin.date));

  if fr_digit.preparereport(true) then fr_digit.ShowPreparedReport;
end;

procedure Tf_main.bt_envia_digitClick(Sender: TObject);
var cadena,nomfile,tx,p,l:string;      f:textfile;     cod_entidad,cod_deleg,dir,fecha_l,hora_l:string;   SendText:ThSendTextHilo;
begin
  p:='|'; l:='#';

  cadena:='';
  ForceDirectories(ExtractFilePath( Application.ExeName )+ '\files\');
  nomfile:=ExtractFilePath( Application.ExeName )+ '\files\send_digit_'+formatdatetime('yyyymmddhhmmss',Now)+'.txt';
  assignfile(f, nomfile);
  Rewrite(f);
  tx:='';

  dm.q_resumen_digit.First;
  while not(dm.q_resumen_digit.eof) do begin
    if dm.q_resumen_digit.fieldbyname('org_cod_delegacion').asinteger=7 then begin  //va de recall a ofic
     cod_entidad:=dm.q_resumen_digit.fieldbyname('dst_cod_entidad').asstring;
     cod_deleg:=dm.q_resumen_digit.fieldbyname('dst_cod_delegacion').asstring;
     dir:='0';
    end else begin
     cod_entidad:=dm.q_resumen_digit.fieldbyname('org_cod_entidad').asstring;
     cod_deleg:=dm.q_resumen_digit.fieldbyname('org_cod_delegacion').asstring;
     dir:='1';
    end;

    fecha_l:=FormatDateTime('yyyy-mm-dd',dm.q_resumen_digit.fieldbyname('fecha').asdatetime);
    hora_l:=FormatDateTime('hh:nn:ss',dm.q_resumen_digit.fieldbyname('hora').asdatetime);

    tx:=dm.q_resumen_digit.FieldByName('id_lectura_estafeta').AsString+p+
      dm.q_resumen_digit.FieldByName('lleno').AsString+p+cod_entidad+p+cod_deleg+p+dir+p+
      dm.q_resumen_digit.fieldbyname('bultos').asstring+p+fecha_l+p+hora_l+p+dm.q_resumen_digit.fieldbyname('ean').asstring+l;
    Writeln(f,tx);
    cadena:=cadena+tx;
    dm.q_resumen_digit.Next;
  end;
  SetLength(cadena, Length(cadena) - 1);
  CloseFile(f);

  SendText:=ThSendTextHilo.create(true);
  SendText.freeonterminate:=true;
  SendText.varname:='cadena';
  SendText.cadena:=cadena;
  SendText.url:='http://www.loginser.com/bankia/operadorlogistico/sync/';
  SendText.nomphp:='put_digitalizacion.php';
  hiloactivo:=true;
  SendText.Resume;
  while hiloactivo do Application.ProcessMessages;


  if htmldevuelto='0' then                     //Han subido ok
    sMessageDlg('Listado de Digitalizaciones Subido Correctamente',mtInformation,[mbok],0)
  else sMessageDlg('Error = '+htmldevuelto,mterror,[mbok],0);

//  DeleteFile(nomfile);
end;
{$ENDREGION}

procedure Tf_main.bt_import_xlsClick(Sender: TObject);        //importar fichero excel de lecturas
var fila:Integer;  fin:boolean;   n_tarj,fecha,hora,ean, valor, str_error:string;
    n_ofic,id_valija_tarjeta,id_valija_dest,id_delegacion_dest, idx_aux, i, bultos, cod_bankia, leidos, totales:Integer;
    es_origen_caixa: Boolean;
    errores: TStringlist;
begin
  errores := TStringList.Create();

  ean := get_tarjeta(Integer(cb_tipo_fichero.Items.Objects[cb_tipo_fichero.itemindex]),id_valija_tarjeta);

  if ean<>'' then
  begin

    es_origen_caixa := f_lectura.convierte_caixa(ean);

    if es_origen_caixa then
      if (MessageDlg('Las oficinas del fichero se consideran de Caixa y serán convertidas a códigos de Bankia, ¿desea continuar?', mtWarning, [mbYes, mbNo], 0, mbNo) = mrNo) then
      begin
          Excel.Quit;
          Excel := Unassigned;
          errores.Free;
          Exit;
      end;

   // if Pos(string(cb_tipo_fichero.Items.Objects[cb_tipo_fichero.itemindex]),delegs_lect_especial)>0 then

      for I := Low(delegs_lect_especial) to High(delegs_lect_especial) do
        if delegs_lect_especial[i]=InttoStr(integer(cb_tipo_fichero.Items.Objects[cb_tipo_fichero.itemindex])) then
            idx_aux := i;

    if (dl_load.Execute) then begin
      AbreFichero(dl_load.FileName);
      Hoja := excel.Worksheets.Item[1];

      fila:=2;    fin:=false;
      leidos := 0;
      totales := 0;

      dm.t_write.StartTransaction;
      try

        while not(fin) do begin
          lbImport.Caption := 'Importanto fila ' + IntToStr(fila);

          valor := hoja.cells[fila, 1];
          if valor='' then fin:=true
          else begin
            if ((Pos('ERROR',hoja.cells[fila, 1])=0) and (Pos('%',hoja.cells[fila, 1])=0))  then begin

              fecha  := hoja.cells[fila, 2];
              hora   := hoja.cells[fila, 3];

              if Pos(IntToStr(Integer(cb_tipo_fichero.Items.Objects[cb_tipo_fichero.itemindex])),delegs_lect_especial[0])>0 then
              begin
                  n_tarj := hoja.cells[fila, 1];
                  n_ofic:=StrToInt(Copy(n_tarj,Length(n_tarj)+StrToint(pos_ofi_lecturas[idx_aux]),dig_sobres));
                  bultos := 1;
              end
              else begin
                  n_ofic := hoja.cells[fila, 1];
                  bultos := hoja.cells[fila, 4];
              end;

              cod_bankia := -1;
              if es_origen_caixa then
              begin
                 if f_lectura.existe_deleg_caixa(IntToStr(n_ofic)) then
                    cod_bankia := StrToInt(f_lectura.convierte_caixa_a_bankia(IntToStr(n_ofic)))
                 else
                     errores.Add('Fila ' + IntToStr(fila) + ': No existe cod. Caixa ' + IntToStr(n_ofic));
              end else
                    cod_bankia := n_ofic;

              if cod_bankia>=0 then
                with TpFIBDataSet.Create(dm) do begin
                  Database:=dm.db;
                  close;
                  SelectSQL.Clear;
                  SelectSQL.Add('select d.id_delegacion,v.id_valija '+
                    'from e_delegaciones d '+
                    'left outer join e_valijas v on (d.id_delegacion=v.id_delegacion) '+
                    'where d.cod_delegacion=:cod_del and d.cod_entidad=900');
                  ParamByName('cod_del').AsInteger := cod_bankia;

                  Open;

                  if not(IsEmpty) then begin
                    id_delegacion_dest:=FieldByName('id_delegacion').AsInteger;
                    if FieldByName('id_valija').IsNull then id_valija_dest:=-1
                    else id_valija_dest:=FieldByName('id_valija').AsInteger;

                    dm.qr_update.Close;
                    dm.qr_update.SQL.Clear;
                    dm.qr_update.SQL.Add('insert into e_lecturas_estafeta (ID_VALIJA_TARJETA,FECHA,HORA,EAN,BULTOS,ID_DELEGACION_DESTINO,ID_VALIJA_DESTINO,ID_CENTRO_LECTURA,SELLO,LLENO,COD_CAIXA) '+
                      'values (:ID_VALIJA_TARJETA,:FECHA,:HORA,:EAN,:BULTOS,:ID_DELEGACION_DESTINO,:ID_VALIJA_DESTINO,:ID_CENTRO_LECTURA,:SELLO,:LLENO, :COD_CAIXA) ');
                    dm.qr_update.ParamByName('ID_VALIJA_TARJETA').AsInteger:=id_valija_tarjeta;
                    dm.qr_update.ParamByName('fecha').Asdate:=StrToDate(fecha);
                    dm.qr_update.ParamByName('hora').Astime:=StrToTime(hora);
                    dm.qr_update.ParamByName('ean').asstring:=ean;
                    dm.qr_update.ParamByName('BULTOS').asinteger:=bultos;
                    dm.qr_update.ParamByName('ID_DELEGACION_DESTINO').asinteger:=id_delegacion_dest;
                    if id_valija_dest<>-1 then dm.qr_update.ParamByName('ID_VALIJA_DESTINO').asinteger:=id_valija_dest;
                    dm.qr_update.ParamByName('ID_CENTRO_LECTURA').asinteger:=u_globals.cent_lect;
                    dm.qr_update.ParamByName('SELLO').asinteger:=1;
                    dm.qr_update.ParamByName('LLENO').asinteger:=0;
                    if es_origen_caixa then
                            dm.qr_update.ParamByName('COD_CAIXA').asinteger := n_ofic
                    else
                            dm.qr_update.ParamByName('COD_CAIXA').Clear;
                    dm.qr_update.ExecQuery;

                    Inc(leidos);
                  end else
                     errores.Add('Fila ' + IntToStr(fila) + ': No existe cod. Bankia ' + IntToStr(cod_bankia));
                end;
            end else
                   errores.Add('Fila ' + IntToStr(fila) + ': Datos incorrectos.');

            Inc(totales);
          end;

          Inc(fila);

        end;
        dm.t_write.CommitRetaining;
        Excel.Quit;
        Excel := Unassigned;

      except
        on e:Exception do
        begin
          Excel.Quit;
          Excel := Unassigned;
          errores.Free;

          dm.t_write.RollbackRetaining;
          sMessageDlg('Error en el Proceso. ' + e.message ,mtError,[mbOk],0);
        end;
      end;

    end;
  end else
  begin
    errores.Add('No encontrado ean para el origen seleccionado. Active una tarjeta en la delegación correspondiente.');
  end;

  if errores.Count>0 then
  begin
    str_error := 'Importación con errores:' + #13#10 + #13#10;
    for I := 0 to errores.Count-1 do
      str_error := str_error + errores [i] + #13#10;

    if (MessageDlg(str_error + #13#10 + '¿Desea guardar esta información en un fichero?', mtInformation, [mbYes, mbNo], 0, mbNo) = mrYes) then
    begin
      errores.Add('');
      errores.Add(FormatDateTime('dd.mm.yy hh:mm',now));

      if fopen.Execute then
          errores.SaveToFile(fopen.Directory + 'error_import_' + cb_tipo_fichero.Text + '.txt');
    end;
  end;

  sMessageDlg('Proceso Finalizado. ' + #13#10 +
              'Leídos: ' + IntToStr(leidos) + #13#10 +
              'Errores: ' + IntToStr(errores.count) + #13#10 +
              'Filas xls: ' + IntToStr(totales),mtInformation,[mbok],0);

  lbImport.Caption := 'Proceso finalizado.';
  errores.Free;
end;

procedure Tf_main.bt_leerClick(Sender: TObject);
begin
  u_lectura.fecha:=Date;
  u_lectura.idx_fmt := fmt_etiqueta;
  f_lectura.ShowModal;
  refresh_data;
end;

procedure Tf_main.bt_recall_eanClick(Sender: TObject);
begin
  u_recall.fecha:=Date;
  f_recall.ShowModal;
  refresh_data;
end;

function Tf_main.busca_ofi_id(cod_ent,cod_ofi:integer):string;
begin
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select nombre from e_delegaciones where cod_entidad=:cod_ent and cod_delegacion=:cod_ofi');
    ParambyName('cod_ent').asinteger:=cod_ent;
    ParambyName('cod_ofi').asinteger:=cod_ofi;
    Open;

    if not(IsEmpty) then Result:=FieldByName('nombre').asstring
    else result:='';

    Free;
  end;
end;

procedure Tf_main.CreaExcel;
begin
  excel := CreateOleObject('Excel.Application');
  try
    excel.Visible := False;
    excel.DisplayAlerts := False;
    excel.WorkBooks.add;
  except
    excel.Quit;
    excel := Unassigned;
  end;
end;

procedure Tf_main.AbreFichero(ruta: string);
begin
  Excel := CreateOleObject('Excel.Application');
  try
    Excel.Visible := False;
    Excel.DisplayAlerts := False;
    Excel.WorkBooks.Open(ruta); //fichero que queremos leer
  except
    Excel.Quit;
    Excel := Unassigned;
  end;
end;

procedure Tf_main.get_cliente_config(id_cliente:integer);
begin

      with TpFIBDataSet.Create(self) do
      try
        Database:=dm.db;
        SQLs.SelectSQL.Clear;
        sqls.SelectSQL.Add('select * from get_clientes_config(:id_cliente)');
        ParamByName('id_cliente').AsInteger := id_cliente;
        Open;
        First;

        if not IsEmpty then
        begin
           //fmt_impresion := (FieldByName('envia_email').AsInteger=1);
           //copia_oculta := FieldByName('copia_oculta').AsString;
           LoadConfigCliente(FieldByName('items').AsString);
        end;
      finally
        free;
      end;
end;

procedure Tf_main.LoadConfigCliente(items: string);
var
  f_type, order_ok, datos_ag: string;
  i: integer;
  stream: TStream;
  str_agencia: TStringDynArray;
  item_list, par: TStringList;
begin

  item_list := TStringList.Create;
  item_list.Delimiter := '$';
  item_list.DelimitedText := items;

  if item_list.Count > 0 then
  begin
    par := TStringList.Create;
    par.Delimiter := '|';

    for i := 0 to item_list.Count - 1 do
    begin
      par.DelimitedText := item_list[i];

      if UpperCase(par[0]) = 'MAIN_CLI' then
        main_cli := StrToInt(par[1]);
      if UpperCase(par[0]) = 'FMT_ETIQUETA' then
        fmt_etiqueta := StrToInt(par[1]);
      if UpperCase(par[0]) = 'DIG_SOBRES' then
        dig_sobres := StrToInt(par[1]);
      if UpperCase(par[0]) = 'POS_OFI_LECTURAS' then
        pos_ofi_lecturas := splitstring(par[1], ',');
      if UpperCase(par[0]) = 'DELEGS_LECT_ESPECIAL' then
        delegs_lect_especial := splitstring(par[1], ',');
    end;
  end;
end;

procedure Tf_main.rellena_tipo_fichero;
begin
   cb_tipo_fichero.Clear;
   cb_tipo_fichero.AddItem('CORRESPONDENCIA',TObject(2505));


   with TpFIBDataSet.Create(self) do begin
    database:=dm.db;
    close;
    selectsql.Clear;
    SelectSQL.Add('select * '+
      'from e_delegaciones d '+
      'where org_recurrente=1 and estado=''A'' order by nombre');
    open;

    cb_tipo_fichero.Clear;
    while not(eof) do begin

      if FieldByName('convierte_caixa').asinteger=1 then
        cb_tipo_fichero.additem(FieldByName('nombre').AsString + ' (C)',TObject(FieldByName('id_delegacion').asinteger))
      else
        cb_tipo_fichero.additem(FieldByName('nombre').AsString,TObject(FieldByName('id_delegacion').asinteger));
      next;
    end;

    Free;
  end;
end;

function Tf_main.get_tarjeta(id_deleg:Integer;var id_val_tarj:integer):string;
begin
    with TpFIBDataSet.Create(self) do
      try
        Database:=dm.db;
        SQLs.SelectSQL.Clear;
        sqls.SelectSQL.Add('select first 1 ean, id_valija_tarjeta from e_valijas_tarjetas t ' +
                           'inner join e_valijas v on v.id_valija=t.id_valija ' +
                           'where v.id_delegacion=:id_deleg ' +
                           'order by 1');
        ParamByName('id_deleg').AsInteger := id_deleg;

        Open;
        First;

        if FieldByName('ean').AsString<>'' then
        begin
              Result := FieldByName('ean').AsString;
              id_val_tarj := FieldByName('id_valija_tarjeta').asinteger;
        end
        else
              Result := '';

      finally
        free;
      end;
end;
end.



