unit u_main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, math, sSkinProvider, sSkinManager, Buttons, types,strutils,
  sTooledit, MidasLib,
  sSpeedButton,pfibdataset, Vcl.ExtCtrls, sPanel, sLabel,sdialogs,
  sEdit, sGroupBox, sPageControl, Vcl.ComCtrls, sMaskEdit, sCustomComboEdit,frxClass, frxDBSet,frxGradient,
  sCheckBox, sRadioButton, sBitBtn,
  sComboBox,frxBarcode, sBevel, acPNG, acImage, Data.DB, Vcl.Grids, Vcl.DBGrids,
  JvExDBGrids, JvDBGrid, acDBGrid;

type
  Tf_main = class(TForm)
    sk_manager: TsSkinManager;
    sknprvdr1: TsSkinProvider;
    bt_update: TsBitBtn;
    bt_new: TsBitBtn;
    bt_delete: TsBitBtn;
    bt_search: TsBitBtn;
    gb_valija: TsGroupBox;
    bt_crea_valija: TsBitBtn;
    gb_tarjetas: TsGroupBox;
    bt_print_all: TsBitBtn;
    bt_print_one: TsBitBtn;
    bt_print_map: TsBitBtn;
    lb_1: TsLabel;
    b_act_tjta: TsBitBtn;
    b_new_tjta: TsBitBtn;
    b_elim_tjta: TsBitBtn;
    bt_gen_all: TsBitBtn;
    frdb_tjta: TfrxDBDataset;
    fr_tjta: TfrxReport;
    bt_search_ruta: TsSpeedButton;
    lb_ruta: TsLabel;
    bt_search_agencia: TsSpeedButton;
    lb_agencia: TsLabel;
    bt_search_prev: TsSpeedButton;
    lb_prev: TsLabel;
    bt_clean_prev: TsSpeedButton;
    bt_discard: TsBitBtn;
    bt_guardar: TsBitBtn;
    ed_modulo: TsEdit;
    ed_casillero: TsEdit;
    ed_hueco: TsEdit;
    cb_dest_especial: TsComboBox;
    cb_mnemo: TsComboBox;
    gb_dias: TsGroupBox;
    cb_lunes: TsCheckBox;
    cb_martes: TsCheckBox;
    cb_miercoles: TsCheckBox;
    cb_jueves: TsCheckBox;
    cb_viernes: TsCheckBox;
    cb_estado: TsComboBox;
    ed_ruta: TsEdit;
    ed_agencia: TsEdit;
    ed_prev: TsEdit;
    bt_print_cartel: TsBitBtn;
    bv_1: TsBevel;
    rg_disp_llegada: TsRadioGroup;
    rg_disp_salida: TsRadioGroup;
    ed_agrupacion: TsEdit;
    bt_search_agrupacion: TsSpeedButton;
    lb_agrupacion: TsLabel;
    cb_logo_bkia: TsCheckBox;
    chRfid: TsCheckBox;
    fr_1: TfrxReport;
    sImage1: TsImage;
    Button1: TButton;
    sGroupBox2: TsGroupBox;
    sLabel2: TsLabel;
    ed_caixa_filt: TsEdit;
    gb_oficina_org: TsGroupBox;
    sb_ofi_org: TsSpeedButton;
    lb_ofi_filt: TsLabel;
    ed_ofi_filt: TsEdit;
    ed_ent_filt: TsEdit;
    sGroupBox1: TsGroupBox;
    sLabel1: TsLabel;
    ed_ag_filt: TsEdit;
    sSpeedButton1: TsSpeedButton;
    JvDBGrid1: TJvDBGrid;
    lb_ag_filt: TsLabel;
    grp1: TGroupBox;
    chEsDstRec_filt: TCheckBox;
    chEsOrgRec_filt: TCheckBox;
    chConvierteFilt: TCheckBox;
    chPedirTraza_filt: TCheckBox;
    chBaja_filt: TCheckBox;
    chValBaja_filt: TCheckBox;
    chPrev_filt: TCheckBox;
    btResetarFiltros: TsSpeedButton;
    sGroupBox3: TsGroupBox;
    sLabel3: TsLabel;
    sSpeedButton3: TsSpeedButton;
    lb_agr_filt: TsLabel;
    edAgrFilt: TsEdit;
    s1: TStatusBar;
    JvDBGrid2: TJvDBGrid;
    gbDirecciones: TsGroupBox;
    ed_dir_zona_filt: TsEdit;
    lb_dir_zona_filt: TsLabel;
    ed_dir_terr_filt: TsEdit;
    lb_dir_terr_filt: TsLabel;
    sSpeedButton4: TsSpeedButton;
    sSpeedButton5: TsSpeedButton;
    lb_dir_com_filt: TsLabel;
    ed_dir_com_filt: TsEdit;
    sSpeedButton6: TsSpeedButton;
    ed_tipologia_filt: TsEdit;
    lb_tipologia_filt: TsLabel;
    sSpeedButton7: TsSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure init;
    procedure bt_searchClick(Sender: TObject);
    procedure bt_updateClick(Sender: TObject);
    procedure bt_newClick(Sender: TObject);
    procedure bt_deleteClick(Sender: TObject);
    procedure refresh_all_data;
    procedure refresh_valija_data;
    procedure refresh_tjta_data;
    procedure change_deleg;
    procedure llena_valija;
    procedure bt_search_rutaClick(Sender: TObject);
    procedure bt_search_agenciaClick(Sender: TObject);
    procedure bt_search_prevClick(Sender: TObject);
    procedure bt_discardClick(Sender: TObject);
    procedure bt_guardarClick(Sender: TObject);
    procedure bt_clean_prevClick(Sender: TObject);
    procedure bt_crea_valijaClick(Sender: TObject);
    procedure b_new_tjtaClick(Sender: TObject);
    procedure b_elim_tjtaClick(Sender: TObject);
    procedure b_act_tjtaClick(Sender: TObject);
    procedure bt_gen_allClick(Sender: TObject);
    procedure bt_print_oneClick(Sender: TObject);
    procedure bt_print_allClick(Sender: TObject);
    procedure log_print(id_valija_tarjeta:Integer);
    procedure bt_search_agrupacionClick(Sender: TObject);
    procedure logo_bankia;
    procedure Button1Click(Sender: TObject);
    procedure sSpeedButton1Click(Sender: TObject);
    procedure sb_ofi_orgClick(Sender: TObject);
    procedure JvDBGrid1DrawColumnTitle(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; AColumn: TColumn; var ASortMarker: TJvDBGridBitmap;
      IsDown: Boolean; var Offset: Integer; var DefaultDrawText,
      DefaultDrawSortMarker: Boolean);
    procedure JvDBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure ed_ent_filtKeyPress(Sender: TObject; var Key: Char);
    procedure ed_ofi_filtKeyPress(Sender: TObject; var Key: Char);
    procedure ed_caixa_filtKeyPress(Sender: TObject; var Key: Char);
    procedure ed_ag_filtKeyPress(Sender: TObject; var Key: Char);
    procedure chEsDstRec_filtClick(Sender: TObject);
    procedure chEsOrgRec_filtClick(Sender: TObject);
    procedure chPedirTraza_filtClick(Sender: TObject);
    procedure chBaja_filtClick(Sender: TObject);
    procedure chValBaja_filtClick(Sender: TObject);
    procedure chPrev_filtClick(Sender: TObject);
    procedure btResetarFiltrosClick(Sender: TObject);
    procedure chConvierteFiltClick(Sender: TObject);
    procedure sSpeedButton3Click(Sender: TObject);
    procedure edAgrFiltKeyPress(Sender: TObject; var Key: Char);
    procedure JvDBGrid1DblClick(Sender: TObject);
    procedure JvDBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure JvDBGrid2DblClick(Sender: TObject);
    procedure sSpeedButton4Click(Sender: TObject);
    procedure sSpeedButton5Click(Sender: TObject);
    procedure sSpeedButton6Click(Sender: TObject);
    procedure sSpeedButton7Click(Sender: TObject);
    procedure ed_dir_zona_filtKeyPress(Sender: TObject; var Key: Char);
    procedure ed_dir_terr_filtKeyPress(Sender: TObject; var Key: Char);
    procedure ed_dir_com_filtKeyPress(Sender: TObject; var Key: Char);
    procedure ed_tipologia_filtKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure LoadConfigCliente(items: string);
    procedure get_cliente_config(id_cliente:integer);
    procedure refresh_data;
    procedure RellenaMnemos;
  public
    { Public declarations }
  end;

var
  f_main: Tf_main;
  hiloactivo:Boolean;
  htmldevuelto:string;
  main_cli: integer;
  mnemos: TStringList;

const
  //cliente=182;
  //cliente=2038;
  cliente=2045;

  ALERTA = 'LISTO';
  {Listo: puede crearse exe
   Beta: en pruebas
   Vacio: hay algo en desarrollo y no se puede crear exe}

  v = '[2]';

  //[2] Delphi 10


implementation

uses u_globals, u_dm, ubuscapro,u_envia_mail, u_gen_gl, u_delegacion,
  u_tarjeta;

{$R *.dfm}

{$REGION 'Ini-Close'}
procedure Tf_main.FormCreate(Sender: TObject);
begin
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

  //caption:='Mantenimiento de Delegaciones/Valijas de Estafeta ' + v;
  caption:='Mantenimiento de Delegaciones/Valijas de Estafeta ' + v + ' 2045 CAIXA ONTINYENT';

  u_gen_gl.lee_inis_def;

  get_cliente_config(cliente);

  if (ALERTA='') then
      sMessageDlg('CUIDADO!!!!! PROYECTO EN DESARROLLO!!!! AVISA A INFORMATICA!!!',mtwarning,[mbOk],0)
    else if (ALERTA='BETA') then
      sMessageDlg('PROYECTO EN PRUEBAS. ' + #10#13 + 'POR FAVOR, INFORMAR A SISTEMAS DE POSIBLES ERRORES Y MODIFICACIONES.' + #10#13 + 'GRACIAS POR SU COLABORACIÓN.',mtInformation,[mbOk],0);

  mnemos := TStringList.Create;
  RellenaMnemos;
  btResetarFiltrosClick(self);
  refresh_data;

  init;
end;

procedure Tf_main.FormDestroy(Sender: TObject);
begin
  u_globals.x:=left;                                          //guardar posicion actual
  u_globals.y:=top;
 { u_globals.w:=Width;                                         //guardar tamaño (si procede)
  u_globals.h:=Height;     }
  u_globals.guardar_pos;
  mnemos.Free;
end;

procedure Tf_main.init;
begin
  if not(dm.q_delegaciones.Active) then
  begin
      dm.q_delegaciones.ParamByName('cliente').AsInteger := main_cli;
      dm.q_delegaciones.Open;
  end;
  if not(dm.q_valijas.Active) then dm.q_valijas.Open;
  if not(dm.q_valijas_tarjetas.Active) then dm.q_valijas_tarjetas.Open;
  change_deleg;
end;

procedure Tf_main.JvDBGrid1DblClick(Sender: TObject);
begin
  bt_updateClick(Self);
end;

procedure Tf_main.JvDBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
grid : TDBGrid;
row : integer;
color1,color2:TColor;
const
   CtrlState: array[Boolean] of integer = (DFCS_BUTTONCHECK, DFCS_BUTTONCHECK or DFCS_CHECKED) ;
begin


  if dm.q_delegaciones.FieldByName('estado').AsString='A' then begin
    color1:=RGB(255,255,255);
    color2:=RGB(245,245,245);
  end else begin
    color1:=RGB(255,200,200);
    color2:=RGB(245,180,180);
  end;

  grid := sender as TDBGrid;

  row := grid.DataSource.DataSet.RecNo;

  if Odd(row) then
    grid.Canvas.Brush.Color := color1
  else
    grid.Canvas.Brush.Color := color2;

  grid.DefaultDrawColumnCell(Rect, DataCol, Column, State) ;

  if (Column.Field.DataType=ftSmallint) then
  begin
    grid.Canvas.FillRect(Rect) ;
    if (VarIsNull(Column.Field.Value)) then
      DrawFrameControl(grid.Canvas.Handle,Rect, DFC_BUTTON, DFCS_BUTTONCHECK or DFCS_INACTIVE)
    else
      DrawFrameControl(grid.Canvas.Handle,Rect, DFC_BUTTON, CtrlState[Column.Field.AsBoolean]);
  end;
end;

procedure Tf_main.JvDBGrid1DrawColumnTitle(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; AColumn: TColumn; var ASortMarker: TJvDBGridBitmap;
  IsDown: Boolean; var Offset: Integer; var DefaultDrawText,
  DefaultDrawSortMarker: Boolean);
var color1,color2:TColor;
begin

end;

procedure Tf_main.JvDBGrid2DblClick(Sender: TObject);
begin
  b_act_tjtaClick(Self);
end;

procedure Tf_main.JvDBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
grid : TDBGrid;
row : integer;
color1,color2:TColor;

begin

  if dm.q_valijas_tarjetas.FieldByName('estado').AsString='A' then begin
    color1:=RGB(255,255,255);
    color2:=RGB(245,245,245);
  end else begin
    color1:=RGB(255,200,200);
    color2:=RGB(245,180,180);
  end;

  grid := sender as TDBGrid;

  row := grid.DataSource.DataSet.RecNo;

  if Odd(row) then
    grid.Canvas.Brush.Color := color1
  else
    grid.Canvas.Brush.Color := color2;

  grid.DefaultDrawColumnCell(Rect, DataCol, Column, State) ;

end;

procedure Tf_main.refresh_all_data;
begin
  dm.q_delegaciones.Close;
  dm.q_delegaciones.ParamByName('cliente').AsInteger := main_cli;
  dm.q_delegaciones.Open;

  refresh_valija_data;
end;

procedure Tf_main.refresh_valija_data;
begin
  dm.q_valijas.Close;
  dm.q_valijas.Open;

  refresh_tjta_data;

  change_deleg;
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
        ed_ofi_filt.text:=valor[3];
        ed_ent_filt.Text:=valor[2];
        lb_ofi_filt.caption:=valor[4];
        refresh_data;
      end;
    end;
  end;

end;

procedure Tf_main.sSpeedButton1Click(Sender: TObject);
begin
    with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='id_agencia,nombre';
    titulos.commatext:='Agencia, Nombre';
    from:='e_agencias ';
    where:='estado<''B''';
    orden[1]:=1; busca:=2;   distinct:=1;   fillimpio:=True;

    showmodal;

    if resultado then begin
      ed_ag_filt.Text:=valor[1];
      lb_ag_filt.Caption:=valor[2];
      refresh_data;
    end;
  end;
end;

procedure Tf_main.btResetarFiltrosClick(Sender: TObject);
begin
     ed_ent_filt.Text := '';
     ed_ofi_filt.Text := '';
     ed_caixa_filt.Text := '';
     ed_ag_filt.Text := '';
     edAgrFilt.Text := '';

     lb_ofi_filt.Caption := '';
     lb_agr_filt.Caption := '';
     lb_ag_filt.Caption := '';

     chConvierteFilt.Checked := False;
     chEsDstRec_filt.Checked := False;
     chEsOrgRec_filt.Checked := False;
     chPedirTraza_filt.Checked := False;
     chBaja_filt.Checked := False;
     chValBaja_filt.Checked := False;
     chBaja_filt.Checked := False;

     ed_dir_zona_filt.Text := '';
     ed_dir_terr_filt.Text := '';
     ed_dir_com_filt.Text := '';
     lb_dir_zona_filt.Caption := '';
     lb_dir_terr_filt.Caption := '';
     lb_dir_com_filt.Caption := '';

     ed_tipologia_filt.Text := '';
     lb_tipologia_filt.Caption := '';

     refresh_data;
end;

procedure Tf_main.sSpeedButton3Click(Sender: TObject);
begin
  with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='id_agrupacion,nombre';
    titulos.commatext:='Agrupacion, Nombre';
    from:='e_agrupaciones ';
    where:='estado<''B''';
    orden[1]:=1; busca:=2;   distinct:=1;   fillimpio:=True;

    showmodal;

    if resultado then begin
      edAgrFilt.Text:=valor[1];
      lb_agr_filt.Caption:=valor[2];
      refresh_data;
    end;
  end;
end;

procedure Tf_main.sSpeedButton4Click(Sender: TObject);
begin
    with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='id_direccion_zona,nombre';
    titulos.commatext:='Código, Nombre';
    from:='e_direcciones_zona ';
    where:='estado<''B''';
    orden[1]:=1; busca:=2;   distinct:=1;   fillimpio:=True;

    showmodal;

    if resultado then begin
      ed_dir_zona_filt.Text:=valor[1];
      lb_dir_zona_filt.Caption:=valor[2];
      refresh_data;
    end;
  end;
end;

procedure Tf_main.sSpeedButton5Click(Sender: TObject);
begin
      with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='id_direccion_territorial,nombre';
    titulos.commatext:='Código, Nombre';
    from:='e_direcciones_territorial ';
    where:='estado<''B''';
    orden[1]:=1; busca:=2;   distinct:=1;   fillimpio:=True;

    showmodal;

    if resultado then begin
      ed_dir_terr_filt.Text:=valor[1];
      lb_dir_terr_filt.Caption:=valor[2];
      refresh_data;
    end;
  end;
end;

procedure Tf_main.sSpeedButton6Click(Sender: TObject);
begin
  with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='id_direccion_comercial,nombre';
    titulos.commatext:='Código, Nombre';
    from:='e_direcciones_comercial ';
    where:='estado<''B''';
    orden[1]:=1; busca:=2;   distinct:=1;   fillimpio:=True;

    showmodal;

    if resultado then begin
      ed_dir_com_filt.Text:=valor[1];
      lb_dir_com_filt.Caption:=valor[2];
      refresh_data;
    end;
  end;
end;

procedure Tf_main.sSpeedButton7Click(Sender: TObject);
begin
     with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='id_tipologia,nombre';
    titulos.commatext:='Código, Nombre';
    from:='e_tipologias ';
    where:='estado<''B''';
    orden[1]:=1; busca:=2;   distinct:=1;   fillimpio:=True;

    showmodal;

    if resultado then begin
      ed_tipologia_filt.Text:=valor[1];
      lb_tipologia_filt.Caption:=valor[2];
      refresh_data;
    end;
  end;
end;

procedure Tf_main.refresh_tjta_data;
begin
  dm.q_valijas_tarjetas.Close;
  dm.q_valijas_tarjetas.Open;
end;

procedure Tf_main.refresh_data;
begin

  with dm.q_delegaciones do
  begin
    Close;
    SelectSQL.Clear;
    SelectSQL.Add('select d.*,dz.nombre as nombre_dir_zona,dt.nombre as nombre_dir_terr, t.nombre as nombre_tipologia, ' +
                  'd.cod_caixa, d.convierte_caixa, dc.nombre as nombre_dir_com ' +
                  'from e_delegaciones d ' +
                  'left outer join e_valijas v on v.id_delegacion=d.id_delegacion ' +
                  'left outer join e_direcciones_zona dz on (d.id_direccion_zona=dz.id_direccion_zona) '+
                  'left outer join e_direcciones_territorial dt on (d.id_direccion_territorial=dt.id_direccion_territorial) ' +
                  'left outer join e_direcciones_comercial dc on (d.id_direccion_comercial=dc.id_direccion_comercial) ' +
                  'left outer join e_tipologias t on (d.id_tipologia=t.id_tipologia) ' +
                  'where d.id_cliente=:cliente ');

    if (ed_ent_filt.Text<>'') and (StrToIntDef(ed_ent_filt.Text,-1)>=0) then
       SelectSQL.Add(' and d.cod_entidad=' + ed_ent_filt.Text);

    if (ed_ofi_filt.Text<>'') and (StrToIntDef(ed_ofi_filt.Text,-1)>=0) then
       SelectSQL.Add(' and d.cod_delegacion=' + ed_ofi_filt.Text);

    if (ed_caixa_filt.Text<>'') and (StrToIntDef(ed_caixa_filt.Text,-1)>=0) then
       SelectSQL.Add(' and d.cod_caixa=' + ed_caixa_filt.Text);

    if (ed_ag_filt.Text<>'') and (StrToIntDef(ed_ag_filt.Text,-1)>=0) then
       SelectSQL.Add(' and v.id_agencia=' + (ed_ag_filt.Text));

    if (edAgrFilt.Text<>'') and (StrToIntDef(edAgrFilt.Text,-1)>=0) then
       SelectSQL.Add(' and v.id_agrupacion=' + (edAgrFilt.Text));

    if chConvierteFilt.Checked then
        SelectSQL.Add(' and d.convierte_caixa=1');

    if chEsDstRec_filt.Checked then
        SelectSQL.Add(' and d.dest_recurrente=1');

    if chEsOrgRec_filt.Checked then
        SelectSQL.Add(' and d.org_recurrente=1');

    if chPedirTraza_filt.Checked then
        SelectSQL.Add(' and d.pedir_traza=1');

    if chBaja_filt.Checked then
        SelectSQL.Add(' and d.estado=''B''');

    if chValBaja_filt.Checked then
        SelectSQL.Add(' and v.estado=''B''');

    if chPrev_filt.Checked then
        SelectSQL.Add(' and v.id_valija_redir is not null');

    if (ed_dir_zona_filt.Text<>'') and (StrToIntDef(ed_dir_zona_filt.Text,-1)>=0) then
       SelectSQL.Add(' and d.id_direccion_zona=' + (ed_dir_zona_filt.Text));

    if (ed_dir_terr_filt.Text<>'') and (StrToIntDef(ed_dir_terr_filt.Text,-1)>=0) then
       SelectSQL.Add(' and d.id_direccion_territorial=' + (ed_dir_terr_filt.Text));

    if (ed_dir_com_filt.Text<>'') and (StrToIntDef(ed_dir_com_filt.Text,-1)>=0) then
       SelectSQL.Add(' and d.id_direccion_comercial=' + (ed_dir_com_filt.Text));

    if (ed_tipologia_filt.Text<>'') and (StrToIntDef(ed_tipologia_filt.Text,-1)>=0) then
       SelectSQL.Add(' and d.id_tipologia=' + (ed_tipologia_filt.Text));

    SelectSQL.Add(' order by cod_entidad,cod_delegacion ');

    ParamByName('cliente').AsInteger := main_cli;
    Open;
  end;


  with dm.q_delegs_count do
  begin
    Close;
    SelectSQL.Clear;
    SelectSQL.Add('select count(*) as cuenta ' +
                  'from e_delegaciones d ' +
                  'left outer join e_valijas v on v.id_delegacion=d.id_delegacion ' +
                  'left outer join e_direcciones_zona dz on (d.id_direccion_zona=dz.id_direccion_zona) '+
                  'left outer join e_direcciones_territorial dt on (d.id_direccion_territorial=dt.id_direccion_territorial) ' +
                  'left outer join e_direcciones_comercial dc on (d.id_direccion_comercial=dc.id_direccion_comercial) ' +
                  'left outer join e_tipologias t on (d.id_tipologia=t.id_tipologia) ' +
                  'where d.id_cliente=:cliente ');

    if (ed_ent_filt.Text<>'') and (StrToIntDef(ed_ent_filt.Text,-1)>=0) then
       SelectSQL.Add(' and d.cod_entidad=' + ed_ent_filt.Text);

    if (ed_ofi_filt.Text<>'') and (StrToIntDef(ed_ofi_filt.Text,-1)>=0) then
       SelectSQL.Add(' and d.cod_delegacion=' + ed_ofi_filt.Text);

    if (ed_caixa_filt.Text<>'') and (StrToIntDef(ed_caixa_filt.Text,-1)>=0) then
       SelectSQL.Add(' and d.cod_caixa=' + ed_caixa_filt.Text);

    if (ed_ag_filt.Text<>'') and (StrToIntDef(ed_ag_filt.Text,-1)>=0) then
       SelectSQL.Add(' and v.id_agencia=' + (ed_ag_filt.Text));

    if (edAgrFilt.Text<>'') and (StrToIntDef(edAgrFilt.Text,-1)>=0) then
       SelectSQL.Add(' and v.id_agrupacion=' + (edAgrFilt.Text));

    if chConvierteFilt.Checked then
        SelectSQL.Add(' and d.convierte_caixa=1');

    if chEsDstRec_filt.Checked then
        SelectSQL.Add(' and d.dest_recurrente=1');

    if chEsOrgRec_filt.Checked then
        SelectSQL.Add(' and d.org_recurrente=1');

    if chPedirTraza_filt.Checked then
        SelectSQL.Add(' and d.pedir_traza=1');

    if chBaja_filt.Checked then
        SelectSQL.Add(' and d.estado=''B''');

    if chValBaja_filt.Checked then
        SelectSQL.Add(' and v.estado=''B''');

    if chPrev_filt.Checked then
        SelectSQL.Add(' and v.id_valija_redir is not null');

    if (ed_dir_zona_filt.Text<>'') and (StrToIntDef(ed_dir_zona_filt.Text,-1)>=0) then
       SelectSQL.Add(' and d.id_direccion_zona=' + (ed_dir_zona_filt.Text));

    if (ed_dir_terr_filt.Text<>'') and (StrToIntDef(ed_dir_terr_filt.Text,-1)>=0) then
       SelectSQL.Add(' and d.id_direccion_territorial=' + (ed_dir_terr_filt.Text));

    if (ed_dir_com_filt.Text<>'') and (StrToIntDef(ed_dir_com_filt.Text,-1)>=0) then
       SelectSQL.Add(' and d.id_direccion_comercial=' + (ed_dir_com_filt.Text));

    if (ed_tipologia_filt.Text<>'') and (StrToIntDef(ed_tipologia_filt.Text,-1)>=0) then
       SelectSQL.Add(' and d.id_tipologia=' + (ed_tipologia_filt.Text));

    ParamByName('cliente').AsInteger := main_cli;
    Open;

    if FieldByName('cuenta').asinteger=1 then
      lb_1.Caption := FieldByName('cuenta').AsString + ' delegación'
    else
      lb_1.Caption := FieldByName('cuenta').AsString + ' delegaciones';

  end;

  if not(dm.q_valijas.Active) then dm.q_valijas.Open;
  if not(dm.q_valijas_tarjetas.Active) then dm.q_valijas_tarjetas.Open;
  change_deleg;

end;

{$ENDREGION}

{$REGION 'Delegaciones'}
procedure Tf_main.bt_searchClick(Sender: TObject);
begin
  with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='id_delegacion,cod_entidad,cod_delegacion,nombre,direccion,cp,poblacion,provincia';
    titulos.commatext:='Oficina, Entidad, Codigo,Nombre,Direccion,CP,Poblacion,Provincia';
    from:='e_delegaciones';
    where:='id_cliente='+IntToStr(main_cli);
    orden[1]:=2; orden[2]:=3;  busca:=3;   distinct:=1;   fillimpio:=True;

    showmodal;

    if resultado then begin
      dm.q_delegaciones.Locate('ID_DELEGACION',valor[1],[]);
    end;
  end;
end;

procedure Tf_main.bt_updateClick(Sender: TObject);
var id_del:integer;
begin
  u_delegacion.mode:=0;
  f_delegacion.ShowModal;
  id_del:=dm.q_delegaciones.FieldByName('id_delegacion').AsInteger;
  refresh_all_data;
  refresh_data;
  dm.q_delegaciones.Locate('id_delegacion',id_del,[]);
end;

procedure Tf_main.Button1Click(Sender: TObject);
var
   i:Integer;
   delegs: array of Integer;
begin
  dm.cds_tjta.Active:=true;
  dm.cds_tjta.EmptyDataSet;

  delegs := [1025,1028,1066,1106,1127,1138,1146,1174,1197,1301,1302,1303,1304,1305,1306,1307,1308,1311,1312,1313,1314,1317,1318,1319,1320,1321,1322,1323,1324,1325,1326,1327,1328,1329,1330,1332,1333,1335,1337,1338,1339,1340,1341,1342,1343,1344,1345,1349,1350,1351,1352,1353,1354,1355,1357,1358,1359,1360,1709,1720,1725,1727,1735,1741,1762,1775,1778,1779,1782,1799,1830,1869,1880,1915,1917,1937,1953,2256,2472,2797,2807,2841,2847,2852,2855,2901,2902,2985,2993,3085,3112,3429,3506,4430,5751,5753,5778,5850,6155,6156,6163,6272,6310,6318,6400,6441,6448,6521,6526,6565,6685,6779,7004,7147,7148,7149,7150,7223,7515,9675,9877,9934];

  for i := Low(delegs) to High(delegs) do
   begin
    dm.q_delegaciones.Locate('cod_delegacion',delegs[i],[]);

    dm.q_valijas_tarjetas.First;

    while not(dm.q_valijas_tarjetas.eof) do begin
     if dm.q_valijas_tarjetas.FieldByName('estado').AsString='A' then
     begin
      dm.cds_tjta.Insert;
      dm.cds_tjta.FieldByName('tipo').AsInteger:=strtoint(ed_agencia.Text);
      dm.cds_tjta.FieldByName('delegacion').asstring:=rightstr('0000'+dm.q_delegaciones.fieldbyname('cod_entidad').asstring,4)+'-'+rightstr('0000'+dm.q_delegaciones.fieldbyname('cod_delegacion').asstring,4);
      dm.cds_tjta.FieldByName('direccion').asstring:=dm.q_delegaciones.fieldbyname('direccion').asstring;
      dm.cds_tjta.FieldByName('nombre').asstring:=dm.q_delegaciones.fieldbyname('nombre').asstring;
      dm.cds_tjta.FieldByName('direccion2').asstring:=dm.q_delegaciones.fieldbyname('cp').asstring+' '+dm.q_delegaciones.fieldbyname('poblacion').asstring;
      dm.cds_tjta.FieldByName('provincia').asstring:=dm.q_delegaciones.fieldbyname('provincia').asstring;
      dm.cds_tjta.FieldByName('frecuencia').asstring:=dm.q_valijas.fieldbyname('dias_semana').asstring;
      dm.cds_tjta.FieldByName('modulo').asstring:='M'+dm.q_valijas.fieldbyname('id_modulo').asstring+'-'+dm.q_valijas.fieldbyname('id_casillero').asstring+'-'+dm.q_valijas.fieldbyname('id_hueco').asstring;
      dm.cds_tjta.FieldByName('ean').asstring:=dm.q_valijas_tarjetas.fieldbyname('ean').asstring;
      dm.cds_tjta.FieldByName('rfid').asstring:=dm.q_valijas_tarjetas.fieldbyname('rfid').asstring;
      dm.cds_tjta.Post;
     end;

      dm.q_valijas_tarjetas.next;
    end;

   end;
  logo_bankia;
  if fr_tjta.preparereport(true) then fr_tjta.ShowPreparedReport;

end;

procedure Tf_main.bt_newClick(Sender: TObject);
begin
  u_delegacion.mode:=1;
  f_delegacion.ShowModal;
end;

procedure Tf_main.bt_deleteClick(Sender: TObject);
var id_del:integer;
begin
  if sMessageDlg('Está seguro de Eliminar la Delegación?',mtconfirmation,[mbyes,mbno],0)=mrYes then begin
    dm.t_write.StartTransaction;
    try
      dm.qr_update.Close;
      dm.qr_update.SQL.Clear;
      dm.qr_update.SQL.Add('update e_delegaciones set estado=''B'' where id_delegacion=:id_delegacion');
      dm.qr_update.ParamByName('id_delegacion').AsInteger:=dm.q_delegaciones.FieldByName('id_delegacion').AsInteger;;
      dm.qr_update.ExecQuery;

      dm.qr_update.Close;
      dm.qr_update.SQL.Clear;
      dm.qr_update.SQL.Add('update e_valijas set estado=''B'' where id_delegacion=:id_delegacion');
      dm.qr_update.ParamByName('id_delegacion').AsInteger:=dm.q_delegaciones.FieldByName('id_delegacion').AsInteger;;
      dm.qr_update.ExecQuery;

      dm.t_write.CommitRetaining;
      id_del:=dm.q_delegaciones.FieldByName('id_delegacion').AsInteger;
      refresh_all_data;
      refresh_data;
      dm.q_delegaciones.Locate('id_delegacion',id_del,[]);
    except
      dm.t_write.RollbackRetaining;
      sMessageDlg('Error Grabando Datos',mtError,[mbok],0);
    end;
  end;
end;
{$ENDREGION}

{$REGION 'Grid'}
{
procedure Tf_main.nb_delegacionesCellColoring(Sender: TObject; ACol, ARow: Integer;    //Filas alternas coloreadas
  var CellColor, GridColor: TColor; CellState: TCellState);
var color1,color2:TColor;
begin
  if dm.q_delegaciones.FieldByName('estado').AsString='A' then begin
    color1:=RGB(255,255,255);
    color2:=RGB(245,245,245);
  end else begin
    color1:=RGB(255,200,200);
    color2:=RGB(245,180,180);
  end;

  with sender as TNextDBGrid do begin
    if (ARow < RowCount) then begin
      if (not (csSelected in CellState)) then begin
        if (ARow mod 2 = 0) then CellColor := color2
        else cellcolor:=color1;
      end;
    end;
  end;
end;

procedure Tf_main.nb_tarjetasCellColoring(Sender: TObject; ACol, ARow: Integer;
  var CellColor, GridColor: TColor; CellState: TCellState);
var color1,color2:TColor;
begin
  if dm.q_valijas_tarjetas.FieldByName('estado').AsString='A' then begin
    color1:=RGB(255,255,255);
    color2:=RGB(245,245,245);
  end else begin
    color1:=RGB(255,200,200);
    color2:=RGB(245,180,180);
  end;

  with sender as TNextDBGrid do begin
    if (ARow < RowCount) then begin
      if (not (csSelected in CellState)) then begin
        if (ARow mod 2 = 0) then CellColor := color2
        else cellcolor:=color1;
      end;
    end;
  end;
end;  }
{$ENDREGION}

{$REGION 'Valija'}
procedure Tf_main.change_deleg;
begin
  if dm.q_valijas.IsEmpty then begin
    gb_valija.Visible:=false;
    bt_crea_valija.Visible:=true;
  end else begin
    llena_valija;
    gb_valija.Visible:=true;
    bt_crea_valija.Visible:=false;
  end;
end;

procedure Tf_main.chBaja_filtClick(Sender: TObject);
begin
  refresh_data;
end;

procedure Tf_main.chConvierteFiltClick(Sender: TObject);
begin
  refresh_data;
end;

procedure Tf_main.chEsDstRec_filtClick(Sender: TObject);
begin
    refresh_data;
end;

procedure Tf_main.chEsOrgRec_filtClick(Sender: TObject);
begin
  refresh_data;
end;

procedure Tf_main.chPedirTraza_filtClick(Sender: TObject);
begin
  refresh_data;
end;

procedure Tf_main.chPrev_filtClick(Sender: TObject);
begin
  refresh_data;
end;

procedure Tf_main.chValBaja_filtClick(Sender: TObject);
begin
  refresh_data;
end;

procedure Tf_main.edAgrFiltKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
  begin
       if edAgrFilt.Text='' then
            lb_agr_filt.caption := ''
       else
           lb_agr_filt.Caption := CargarDatosTabla('e_agrupaciones','nombre','id_agrupacion='+edAgrFilt.Text);

       refresh_data;
  end;
end;

procedure Tf_main.ed_ag_filtKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
  begin
       if ed_ag_filt.Text='' then
            lb_ag_filt.caption := ''
       else
           lb_ag_filt.Caption := CargarDatosTabla('e_agencias','nombre','id_agencia='+ed_ag_filt.Text);

       refresh_data;
  end;
end;

procedure Tf_main.ed_caixa_filtKeyPress(Sender: TObject; var Key: Char);
begin

  if StrToIntDef(ed_caixa_filt.Text,-1)<0 then
  begin
    ed_caixa_filt.Font.Color := clRed;
  end else
       ed_caixa_filt.Font.Color := clBlack;

  if Key=#13 then refresh_data;

  end;

procedure Tf_main.ed_dir_com_filtKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
  begin
       if ed_dir_com_filt.Text='' then
            lb_dir_com_filt.caption := ''
       else
           lb_dir_com_filt.Caption := CargarDatosTabla('e_direcciones_comercial','nombre','id_direccion_comercial='+ed_dir_com_filt.Text);

       refresh_data;
  end;
end;

procedure Tf_main.ed_dir_terr_filtKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
  begin
       if ed_dir_terr_filt.Text='' then
            lb_dir_terr_filt.caption := ''
       else
           lb_dir_terr_filt.Caption := CargarDatosTabla('e_direcciones_territorial','nombre','id_direccion_territorial='+ed_dir_terr_filt.Text);

       refresh_data;
  end;
end;

procedure Tf_main.ed_dir_zona_filtKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
  begin
       if ed_dir_zona_filt.Text='' then
            lb_dir_zona_filt.caption := ''
       else
           lb_dir_zona_filt.Caption := CargarDatosTabla('e_direcciones_zona','nombre','id_direccion_zona='+ed_dir_zona_filt.Text);

       refresh_data;
  end;
end;

procedure Tf_main.ed_ent_filtKeyPress(Sender: TObject; var Key: Char);
begin
  if StrToIntDef(ed_ent_filt.Text,-1)<0 then
  begin
    ed_ent_filt.Font.Color := clRed;
  end else
       ed_ent_filt.Font.Color := clBlack;

  if Key=#13 then refresh_data;
end;

procedure Tf_main.ed_ofi_filtKeyPress(Sender: TObject; var Key: Char);
var
  criterios:string;
begin
  if StrToIntDef(ed_ofi_filt.Text,-1)<0 then
  begin
    ed_ofi_filt.Font.Color := clRed;
  end else
       ed_ofi_filt.Font.Color := clBlack;

  if Key=#13 then
  begin
   if ed_ofi_filt.Text='' then
            lb_ofi_filt.caption := ''
   else begin
      if ed_ofi_filt.Text<>'' then
           criterios := ' and cod_entidad=' + ed_ofi_filt.Text
      else
           criterios := '';
      lb_ofi_filt.Caption := CargarDatosTabla('e_delegaciones','nombre','cod_delegacion='+ed_ofi_filt.Text + criterios);
   end;

   refresh_data;
  end;

end;

procedure Tf_main.ed_tipologia_filtKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
  begin
       if ed_tipologia_filt.Text='' then
            lb_tipologia_filt.caption := ''
       else
           lb_tipologia_filt.Caption := CargarDatosTabla('e_tipologias','nombre','id_tipologia='+ed_tipologia_filt.Text);

       refresh_data;
  end;
end;

procedure Tf_main.llena_valija;
begin
  ed_modulo.Text:=dm.q_valijas.FieldByName('id_modulo').AsString;
  ed_casillero.Text:=dm.q_valijas.FieldByName('id_casillero').AsString;
  ed_hueco.Text:=dm.q_valijas.FieldByName('id_hueco').AsString;
  case indexstr(dm.q_valijas.fieldbyname('dest_especiales').asstring,['1','2','3','4','5']) of
    0:cb_dest_especial.ItemIndex:=1;
    1:cb_dest_especial.ItemIndex:=2;
    2:cb_dest_especial.ItemIndex:=3;
    3:cb_dest_especial.ItemIndex:=4;
    4:cb_dest_especial.ItemIndex:=5;
    else cb_dest_especial.ItemIndex:=0;
  end;
//  case indexstr(dm.q_valijas.fieldbyname('mnemonico').asstring,['K','R','F','B']) of
//    0:cb_mnemo.ItemIndex:=1;
//    1:cb_mnemo.ItemIndex:=2;
//    2:cb_mnemo.ItemIndex:=3;
//    3:cb_mnemo.ItemIndex:=4;
//    else cb_mnemo.ItemIndex:=0;
//  end;

    if dm.q_valijas.fieldbyname('mnemonico').asstring='' then
     cb_mnemo.ItemIndex := 0
    else
    cb_mnemo.ItemIndex := mnemos.IndexOf(dm.q_valijas.fieldbyname('mnemonico').asstring)+1;

   { If dm.q_valijas.fieldbyname('mnemonico').asstring='' then
        cb_mnemo.ItemIndex:=0
    else If dm.q_valijas.fieldbyname('mnemonico').asstring='LPA' then
        cb_mnemo.ItemIndex:=1
    else If dm.q_valijas.fieldbyname('mnemonico').asstring='TFN' then
        cb_mnemo.ItemIndex:=2
    else If dm.q_valijas.fieldbyname('mnemonico').asstring='LNZ' then
        cb_mnemo.ItemIndex:=3
    else  If dm.q_valijas.fieldbyname('mnemonico').asstring='FUE' then
        cb_mnemo.ItemIndex:=4
    else If dm.q_valijas.fieldbyname('mnemonico').asstring='HIE' then
        cb_mnemo.ItemIndex:=5
    else If dm.q_valijas.fieldbyname('mnemonico').asstring='GOM' then
        cb_mnemo.ItemIndex:=6;   }

  case indexstr(dm.q_valijas.fieldbyname('estado').asstring,['A','B']) of
    0:cb_estado.ItemIndex:=0;
    1:cb_estado.ItemIndex:=1;
  end;
  cb_lunes.Checked:=Pos('L',dm.q_valijas.FieldByName('dias_semana').AsString)>0;
  cb_martes.Checked:=Pos('M',dm.q_valijas.FieldByName('dias_semana').AsString)>0;
  cb_miercoles.Checked:=Pos('X',dm.q_valijas.FieldByName('dias_semana').AsString)>0;
  cb_jueves.Checked:=Pos('J',dm.q_valijas.FieldByName('dias_semana').AsString)>0;
  cb_viernes.Checked:=Pos('V',dm.q_valijas.FieldByName('dias_semana').AsString)>0;

  with TpFIBDataSet.Create(dm) do begin
    Database:=dm.db;
    close;
    SelectSQL.Clear;
    SelectSQL.Add('select id_agencia,nombre from e_agencias where id_agencia=:id_agencia');
    ParamByName('id_agencia').AsInteger:=dm.q_valijas.FieldByName('id_agencia').AsInteger;
    Open;

    if not(IsEmpty) then begin
      ed_agencia.Text:=FieldByName('id_agencia').AsString;
      lb_agencia.Caption:=FieldByName('nombre').AsString;
    end else begin
      ed_agencia.Text:='';
      lb_agencia.Caption:='Error, No Encontrada';
    end;

    close;
    SelectSQL.Clear;
    SelectSQL.Add('select id_ruta,nombre from e_rutas where id_ruta=:id_ruta');
    ParamByName('id_ruta').AsInteger:=dm.q_valijas.FieldByName('id_ruta').AsInteger;
    Open;

    if not(IsEmpty) then begin
      ed_ruta.Text:=FieldByName('id_ruta').AsString;
      lb_ruta.Caption:=FieldByName('nombre').AsString;
    end else begin
      ed_ruta.Text:='';
      lb_ruta.Caption:='Error, No Encontrada';
    end;

    close;
    SelectSQL.Clear;
    SelectSQL.Add('select v.id_valija,d.cod_entidad,d.cod_delegacion,d.nombre '+
      'from e_valijas v '+
      'inner join e_delegaciones d on (v.id_delegacion=d.id_delegacion) '+
      'where v.id_valija=:id_valija and d.id_cliente='+IntToStr(main_cli));
    ParamByName('id_valija').AsInteger:=dm.q_valijas.FieldByName('id_valija_redir').AsInteger;
    Open;

    if not(IsEmpty) then begin
      ed_prev.Text:=FieldByName('id_valija').AsString;
      lb_prev.Caption:=FieldByName('cod_entidad').AsString+'-'+FieldByName('cod_delegacion').AsString+'-'+FieldByName('nombre').AsString;
    end else begin
      ed_prev.Text:='';
      lb_prev.Caption:='Sin Prevalente';
    end;

    close;
    SelectSQL.Clear;
    SelectSQL.Add('select id_agrupacion,nombre from e_agrupaciones where id_agrupacion=:id_agrupacion');
    ParamByName('id_agrupacion').AsInteger:=dm.q_valijas.FieldByName('id_agrupacion').AsInteger;
    Open;

    if not(IsEmpty) then begin
      ed_agrupacion.Text:=FieldByName('id_agrupacion').AsString;
      lb_agrupacion.Caption:=FieldByName('nombre').AsString;
    end else begin
      ed_agrupacion.Text:='';
      lb_agrupacion.Caption:='Error, No Encontrada';
    end;

    if (dm.q_valijas.FieldByName('disp_llegada').Asinteger=0) then rg_disp_llegada.itemindex:=1
    else rg_disp_llegada.itemindex:=0;

    if (dm.q_valijas.FieldByName('disp_salida').Asinteger=0) then rg_disp_salida.itemindex:=0
    else rg_disp_salida.itemindex:=1;

    free;
  end;
end;

procedure Tf_main.bt_crea_valijaClick(Sender: TObject);
begin
  dm.t_write.StartTransaction;
  try
    dm.qr_update.Close;
    dm.qr_update.SQL.Clear;
    dm.qr_update.SQL.Add('insert into e_valijas (id_delegacion,id_ruta,id_agencia,id_modulo,id_casillero,id_hueco,dias_semana,id_agrupacion) '+
      'values (:id_delegacion,:id_ruta,:id_agencia,:id_modulo,:id_casillero,:id_hueco,:dias_semana,:id_agrupacion)');
    dm.qr_update.ParamByName('id_delegacion').asinteger:=dm.q_delegaciones.FieldByName('id_delegacion').AsInteger;
    dm.qr_update.ParamByName('id_ruta').asinteger:=1;
    dm.qr_update.ParamByName('id_agencia').asinteger:=1;
    dm.qr_update.ParamByName('id_modulo').asinteger:=1;
    dm.qr_update.ParamByName('id_casillero').asinteger:=1;
    dm.qr_update.ParamByName('id_hueco').asinteger:=1;
    dm.qr_update.ParamByName('id_agrupacion').asinteger:=1;
    dm.qr_update.ParamByName('dias_semana').asstring:='LMXJV';
    dm.qr_update.ExecQuery;

    dm.t_write.CommitRetaining;
    refresh_valija_data;
  except
    dm.t_write.RollbackRetaining;
    sMessageDlg('Error Grabando Datos',mtError,[mbok],0);
  end;
end;

procedure Tf_main.bt_discardClick(Sender: TObject);
begin
  llena_valija;
end;

procedure Tf_main.bt_guardarClick(Sender: TObject);
var dest_esp,id_prev:Integer;   mnemo,dias:string;
begin
  dm.t_write.StartTransaction;
  try
    dm.qr_update.Close;
    dm.qr_update.SQL.Clear;
    dm.qr_update.SQL.Add('update e_valijas set id_ruta=:id_ruta,id_agencia=:id_agencia,id_modulo=:id_modulo,id_casillero=:id_casillero,id_hueco=:id_hueco, '+
      'dest_especiales=:dest_especiales,mnemonico=:mnemonico,id_valija_redir=:id_valija_redir,dias_semana=:dias_semana,estado=:estado,disp_llegada=:disp_llegada, '+
      'disp_salida=:disp_salida,id_agrupacion=:id_agrupacion where id_valija=:id_valija');
    dm.qr_update.ParamByName('id_valija').asinteger:=dm.q_valijas.FieldByName('id_valija').AsInteger;
    dm.qr_update.ParamByName('id_ruta').asinteger:=strtoint(ed_ruta.Text);
    dm.qr_update.ParamByName('id_agencia').asinteger:=strtoint(ed_agencia.Text);
    dm.qr_update.ParamByName('id_modulo').asinteger:=strtoint(ed_modulo.Text);
    dm.qr_update.ParamByName('id_casillero').asinteger:=strtoint(ed_casillero.Text);
    dm.qr_update.ParamByName('id_hueco').asinteger:=strtoint(ed_hueco.Text);
    dest_esp:=cb_dest_especial.ItemIndex;
    dm.qr_update.ParamByName('dest_especiales').asinteger:=dest_esp;

//    if cb_mnemo.ItemIndex=0 then mnemo:=''
//    else mnemo:=cb_mnemo.Text[1];
//    dm.qr_update.ParamByName('mnemonico').AsString:=mnemo;

       {  K=TORRE KIO
          R=LAS ROZAS
          F=TORRE FOSTER
          B=BITOQUE
          DZ= DIRECCION DE ZONA
          MM= MARIA DE MOLINA }

     { case cb_mnemo.ItemIndex of
         0: mnemo:='';
         1: mnemo:='LPA';
         2: mnemo:='TFN';
         3: mnemo:='LNZ';
         4: mnemo:='FUE';
         5: mnemo:='HIE';
         6: mnemo:='GOM';
      END;   }

      if cb_mnemo.ItemIndex>0 then
        dm.qr_update.ParamByName('mnemonico').AsString := mnemos[cb_mnemo.ItemIndex-1]
      else
        dm.qr_update.ParamByName('mnemonico').Clear;

      //dm.qr_update.ParamByName('mnemonico').AsString:=mnemo;

    if ed_prev.Text='' then dm.qr_update.ParamByName('id_valija_redir').clear
    else dm.qr_update.ParamByName('id_valija_redir').asinteger:=StrToInt(ed_prev.text);
    dm.qr_update.ParamByName('id_agrupacion').asinteger:=strtoint(ed_agrupacion.Text);

    dias:='';
    if cb_lunes.Checked then dias:=dias+'L';
    if cb_martes.Checked then dias:=dias+'M';
    if cb_miercoles.Checked then dias:=dias+'X';
    if cb_jueves.Checked then dias:=dias+'J';
    if cb_viernes.Checked then dias:=dias+'V';
    dm.qr_update.ParamByName('dias_semana').asstring:=dias;

    dm.qr_update.ParamByName('estado').asstring:=cb_estado.Text[1];

    if rg_disp_llegada.itemindex=0 then dm.qr_update.ParamByName('disp_llegada').asinteger:=-1
      else dm.qr_update.ParamByName('disp_llegada').asinteger:=0;

    if rg_disp_salida.itemindex=0 then dm.qr_update.ParamByName('disp_salida').asinteger:=0
      else dm.qr_update.ParamByName('disp_salida').asinteger:=1;

    dm.qr_update.ExecQuery;

    dm.t_write.CommitRetaining;
  except on e:exception do  begin
            dm.t_write.RollbackRetaining;
            sMessageDlg('Error Grabando Datos' + #13#10 + e.Message ,mtError,[mbok],0);
         end;
  end;

end;

procedure Tf_main.bt_search_agenciaClick(Sender: TObject);
begin
  with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='id_agencia,nombre';
    titulos.commatext:='Agencia, Nombre';
    from:='e_agencias ';
    where:='estado<''B''';
    orden[1]:=1; busca:=2;   distinct:=1;   fillimpio:=True;

    showmodal;

    if resultado then begin
      ed_agencia.Text:=valor[1];
      lb_agencia.Caption:=valor[2];
    end;
  end;
end;

procedure Tf_main.bt_search_agrupacionClick(Sender: TObject);
begin
  with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='id_agrupacion,nombre';
    titulos.commatext:='Agrupacion, Nombre';
    from:='e_agrupaciones ';
    where:='estado<''B''';
    orden[1]:=1; busca:=2;   distinct:=1;   fillimpio:=True;

    showmodal;

    if resultado then begin
      ed_agrupacion.Text:=valor[1];
      lb_agrupacion.Caption:=valor[2];
    end;
  end;
end;

procedure Tf_main.bt_search_rutaClick(Sender: TObject);
begin
  with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='id_ruta,nombre';
    titulos.commatext:='Ruta, Nombre';
    from:='e_rutas ';
    where:='estado<''B''';
    orden[1]:=1; busca:=2;   distinct:=1;   fillimpio:=True;

    showmodal;

    if resultado then begin
      ed_ruta.Text:=valor[1];
      lb_ruta.Caption:=valor[2];
    end;
  end;
end;

procedure Tf_main.bt_search_prevClick(Sender: TObject);
begin
  with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='d.id_delegacion,d.cod_entidad,d.cod_delegacion,d.nombre,d.direccion,d.cp,d.poblacion,d.provincia,v.id_valija';
    titulos.commatext:='Oficina, Entidad, Codigo,Nombre,Direccion,CP,Poblacion,Provincia';
    from:='e_delegaciones d inner join e_valijas v on (v.id_delegacion=d.id_delegacion) ';
    where:='v.estado<''B'' and d.estado<''B'' and d.id_cliente='+ IntToStr(main_cli);
    orden[1]:=2; orden[2]:=3;  busca:=3;   distinct:=1;   fillimpio:=True;

    showmodal;

    if resultado then begin
      ed_prev.Text:=valor[9];
      lb_prev.Caption:=valor[2]+'-'+valor[3]+'-'+valor[4];
    end;
  end;
end;

procedure Tf_main.bt_clean_prevClick(Sender: TObject);
begin
  ed_prev.Text:='';
  lb_prev.Caption:='Sin Prevalente';
end;
{$ENDREGION}

{$REGION 'Tarjetas'}
procedure Tf_main.b_new_tjtaClick(Sender: TObject);
var s:string;   n_tjta:Integer;
begin
  if sInputQuery('Nueva Tarjeta','Número de Tarjeta Nueva',s) then begin
    if TryStrToInt(s,n_tjta) then begin
      if ((n_tjta<1) or (n_tjta>9)) then raise exception.Create('Número de Tarjeta No Valido');

      with TpFIBDataSet.Create(dm) do begin
        database:=dm.db;
        SelectSQL.Add('select n_tarjeta from e_valijas_tarjetas where n_tarjeta=:n_tarjeta and id_valija=:id_valija');
        ParamByName('n_tarjeta').AsInteger:=n_tjta;
        ParamByName('id_valija').AsInteger:=dm.q_valijas.FieldByName('id_valija').asinteger;
        Open;

        if not(isempty) then begin
          if sMessageDlg('Número de Tarjeta Ya Existe, Crearla de Todas Maneras?',mtConfirmation,[mbYes,mbNo],0)=mrNo then
            raise exception.Create('Número de Tarjeta Ya Existe');
        end;

        dm.t_write.StartTransaction;
        try
          dm.qr_update.Close;
          dm.qr_update.SQL.Clear;
          dm.qr_update.SQL.Add('insert into e_valijas_tarjetas (id_valija,n_tarjeta) values (:id_valija,:n_tarjeta)');
          dm.qr_update.ParamByName('id_valija').asinteger:=dm.q_valijas.FieldByName('id_valija').AsInteger;
          dm.qr_update.ParamByName('n_tarjeta').asinteger:=n_tjta;
          dm.qr_update.ExecQuery;

          dm.t_write.CommitRetaining;
          refresh_tjta_data;
        except
          dm.t_write.RollbackRetaining;
          sMessageDlg('Error Grabando Datos',mtError,[mbok],0);
        end;

        free;
      end;
    end else raise exception.Create('Número de Tarjeta No Valido');
  end;
end;

procedure Tf_main.b_act_tjtaClick(Sender: TObject);
begin
  u_tarjeta.mode:=0;
  f_tarjeta.ShowModal;
  refresh_tjta_data;
end;

procedure Tf_main.b_elim_tjtaClick(Sender: TObject);
begin
  if sMessageDlg('Está seguro de Eliminar la Tarjeta?',mtconfirmation,[mbyes,mbno],0)=mrYes then begin
    dm.t_write.StartTransaction;
    try
      dm.qr_update.Close;
      dm.qr_update.SQL.Clear;
      dm.qr_update.SQL.Add('update e_valijas_tarjetas set estado=''B'' where id_valija_tarjeta=:id_valija_tarjeta');
      dm.qr_update.ParamByName('id_valija_tarjeta').AsInteger:=dm.q_valijas_tarjetas.FieldByName('id_valija_tarjeta').AsInteger;;
      dm.qr_update.ExecQuery;

      dm.t_write.CommitRetaining;
      refresh_tjta_data;
    except
      dm.t_write.RollbackRetaining;
      sMessageDlg('Error Grabando Datos',mtError,[mbok],0);
    end;
  end;
end;

procedure Tf_main.bt_gen_allClick(Sender: TObject);
var i:integer;
begin
  for i:=1 to 4 do begin
    with TpFIBDataSet.Create(dm) do begin
      database:=dm.db;
      close;
      SelectSQL.Clear;
      SelectSQL.Add('select n_tarjeta from e_valijas_tarjetas where n_tarjeta=:n_tarjeta and id_valija=:id_valija');
      ParamByName('n_tarjeta').AsInteger:=i;
      ParamByName('id_valija').AsInteger:=dm.q_valijas_tarjetas.FieldByName('id_valija').asinteger;
      Open;

      if isempty then begin
        dm.t_write.StartTransaction;
        try
          dm.qr_update.Close;
          dm.qr_update.SQL.Clear;
          dm.qr_update.SQL.Add('insert into e_valijas_tarjetas (id_valija,n_tarjeta) values (:id_valija,:n_tarjeta)');
          dm.qr_update.ParamByName('id_valija').asinteger:=dm.q_valijas.FieldByName('id_valija').AsInteger;
          dm.qr_update.ParamByName('n_tarjeta').asinteger:=i;
          dm.qr_update.ExecQuery;

          dm.t_write.CommitRetaining;
        except
          dm.t_write.RollbackRetaining;
          sMessageDlg('Error Grabando Datos',mtError,[mbok],0);
        end;
      end;
      free;
    end;
  end;
  refresh_tjta_data;
end;

procedure Tf_main.bt_print_allClick(Sender: TObject);
var  i:integer;
begin
  dm.cds_tjta.Active:=true;
  dm.cds_tjta.EmptyDataSet;

  dm.q_valijas_tarjetas.First;

  while not(dm.q_valijas_tarjetas.eof) do begin
    if dm.q_valijas_tarjetas.fieldbyname('estado').asstring='A' then
    begin
      dm.cds_tjta.Insert;
      dm.cds_tjta.FieldByName('tipo').AsInteger:=strtoint(ed_agencia.Text);
      dm.cds_tjta.FieldByName('delegacion').asstring:=rightstr('0000'+dm.q_delegaciones.fieldbyname('cod_entidad').asstring,4)+'-'+rightstr('0000'+dm.q_delegaciones.fieldbyname('cod_delegacion').asstring,4);
      dm.cds_tjta.FieldByName('direccion').asstring:=dm.q_delegaciones.fieldbyname('direccion').asstring;
      dm.cds_tjta.FieldByName('nombre').asstring:=dm.q_delegaciones.fieldbyname('nombre').asstring;
      dm.cds_tjta.FieldByName('direccion2').asstring:=dm.q_delegaciones.fieldbyname('cp').asstring+' '+dm.q_delegaciones.fieldbyname('poblacion').asstring;
      dm.cds_tjta.FieldByName('provincia').asstring:=dm.q_delegaciones.fieldbyname('provincia').asstring;
      dm.cds_tjta.FieldByName('frecuencia').asstring:=dm.q_valijas.fieldbyname('dias_semana').asstring;
      dm.cds_tjta.FieldByName('modulo').asstring:='M'+dm.q_valijas.fieldbyname('id_modulo').asstring+'-'+dm.q_valijas.fieldbyname('id_casillero').asstring+'-'+dm.q_valijas.fieldbyname('id_hueco').asstring;
      dm.cds_tjta.FieldByName('ean').asstring:=dm.q_valijas_tarjetas.fieldbyname('ean').asstring;
      dm.cds_tjta.FieldByName('rfid').asstring:=dm.q_valijas_tarjetas.fieldbyname('rfid').asstring;
      dm.cds_tjta.Post;

      log_print(dm.q_valijas_tarjetas.FieldByName('id_valija_tarjeta').asinteger);
    end;

    dm.q_valijas_tarjetas.next;
  end;

  logo_bankia;
  if fr_tjta.preparereport(true) then fr_tjta.ShowPreparedReport;
end;

procedure Tf_main.logo_bankia;
var
	pic : TfrxPictureView;
  memo: TfrxMemoView;
begin
  pic := fr_tjta.FindObject('logo') as TfrxPictureView;
  memo := fr_tjta.FindObject('memo7') as TfrxMemoView;

  if Assigned(pic) then pic.Visible:=cb_logo_bkia.Checked;
  if Assigned(memo) then memo.Visible := chRfid.Checked;

  pic := fr_1.FindObject('logo') as TfrxPictureView;
  memo := fr_1.FindObject('memo4') as TfrxMemoView;

  if Assigned(pic) then pic.Visible:=cb_logo_bkia.Checked;
  if Assigned(memo) then memo.Visible := chRfid.Checked;
  
end;

procedure Tf_main.bt_print_oneClick(Sender: TObject);
var  i:integer;
begin
  //dm.q_valijas_tarjetas.First;

  if not(dm.q_valijas_tarjetas.IsEmpty) then begin
    dm.cds_tjta.Active:=true;
    dm.cds_tjta.EmptyDataSet;

    while dm.q_valijas_tarjetas.fieldbyname('estado').asstring='B' do
      dm.q_valijas_tarjetas.Next;

    if not dm.q_valijas_tarjetas.Eof then
    begin
      dm.cds_tjta.Insert;
      dm.cds_tjta.FieldByName('tipo').AsInteger:=strtoint(ed_agencia.Text);
      dm.cds_tjta.FieldByName('delegacion').asstring:=rightstr('0000'+dm.q_delegaciones.fieldbyname('cod_entidad').asstring,4)+'-'+rightstr('0000'+dm.q_delegaciones.fieldbyname('cod_delegacion').asstring,4);
      dm.cds_tjta.FieldByName('direccion').asstring:=dm.q_delegaciones.fieldbyname('direccion').asstring;
      dm.cds_tjta.FieldByName('nombre').asstring:=dm.q_delegaciones.fieldbyname('nombre').asstring;
      dm.cds_tjta.FieldByName('direccion2').asstring:=dm.q_delegaciones.fieldbyname('cp').asstring+' '+dm.q_delegaciones.fieldbyname('poblacion').asstring;
      dm.cds_tjta.FieldByName('provincia').asstring:=dm.q_delegaciones.fieldbyname('provincia').asstring;
      dm.cds_tjta.FieldByName('frecuencia').asstring:=dm.q_valijas.fieldbyname('dias_semana').asstring;
      dm.cds_tjta.FieldByName('modulo').asstring:='M'+dm.q_valijas.fieldbyname('id_modulo').asstring+'-'+dm.q_valijas.fieldbyname('id_casillero').asstring+'-'+dm.q_valijas.fieldbyname('id_hueco').asstring;
      dm.cds_tjta.FieldByName('ean').asstring:=dm.q_valijas_tarjetas.fieldbyname('ean').asstring;
      dm.cds_tjta.FieldByName('rfid').asstring:=dm.q_valijas_tarjetas.fieldbyname('rfid').asstring;
      dm.cds_tjta.Post;

      log_print(dm.q_valijas_tarjetas.FieldByName('id_valija_tarjeta').asinteger);

      logo_bankia;
      //if fr_tjta.preparereport(true) then fr_tjta.ShowPreparedReport;
      if fr_1.preparereport(true) then fr_1.ShowPreparedReport;
    end;
  end;
end;

procedure Tf_main.log_print(id_valija_tarjeta:Integer);
begin
  dm.t_write.StartTransaction;
  try
    dm.qr_update.Close;
    dm.qr_update.SQL.Clear;
    dm.qr_update.SQL.Add('insert into e_valijas_tarjetas_printlog (id_valija_tarjeta,usuario) values (:id_valija_tarjeta,:usuario)');
    dm.qr_update.ParamByName('id_valija_tarjeta').asinteger:=id_valija_tarjeta;
    dm.qr_update.ParamByName('usuario').asinteger:=u_globals.id_usuario;
    dm.qr_update.ExecQuery;

    dm.t_write.CommitRetaining;
  except
    dm.t_write.RollbackRetaining;
    sMessageDlg('Error Grabando Datos',mtError,[mbok],0);
  end;
end;
{$ENDREGION}


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
  item_name, item_value: string;
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
    end;
  end;
end;

procedure Tf_main.RellenaMnemos;
begin
   with TpFIBDataSet.Create(self) do
      try
        Database:=dm.db;
        SQLs.SelectSQL.Clear;
        sqls.SelectSQL.Add('select * from e_valijas_mnemos where estado=''A''');
        Open;

        if not IsEmpty then
        begin
           First;
           while not eof do
           begin
             mnemos.Add(fieldbyname('CODIGO').AsString);
             cb_mnemo.Items.Add(fieldbyname('CODIGO').AsString + '-' + FieldByName('DESCRIPCION').AsString);
             Next;
           end;
        end;
      finally
        free;
      end;
end;
end.



