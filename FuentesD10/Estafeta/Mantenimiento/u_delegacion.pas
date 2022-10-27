unit u_delegacion;

interface

uses
  Winapi.Windows, System.SysUtils, System.Variants, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,types,
  sTooledit, Vcl.StdCtrls, sComboBox, Vcl.Buttons, sBitBtn, sEdit, sGroupBox,
  system.AnsiStrings, sLabel,
  sSpeedButton, pFIBDataSet,Winapi.ShellAPI,sdialogs, Vcl.Mask, sMaskEdit, sCustomComboEdit,System.StrUtils,
  sCheckBox;

type
  Tf_delegacion = class(TForm)
    sGroupBox4: TsGroupBox;
    bt_guardar: TsBitBtn;
    cb_estado: TsComboBox;
    ed_id_deleg: TsEdit;
    ed_nombre: TsEdit;
    ed_dir_1: TsEdit;
    ed_poblacion: TsEdit;
    ed_provincia: TsEdit;
    ed_cp: TsEdit;
    ed_telefono: TsEdit;
    ed_cod_ent: TsEdit;
    ed_cod_deleg: TsEdit;
    ed_fax: TsEdit;
    ed_email: TsEdit;
    cb_org_rec: TsCheckBox;
    cb_dest_rec: TsCheckBox;
    cb_pedir_sobres: TsCheckBox;
    cb_enviar_incidencia_est: TsCheckBox;
    cb_enviar_incidencia_precinto: TsCheckBox;
    ed_dir_zona: TsEdit;
    lb_dir_zona: TsLabel;
    bt_search_dir_zona: TsSpeedButton;
    ed_dir_terr: TsEdit;
    bt_search_dir_terr: TsSpeedButton;
    lb_dir_terr: TsLabel;
    ed_tipologia: TsEdit;
    bt_search_tipologia: TsSpeedButton;
    lb_tipologia: TsLabel;
    cb_pedir_traza: TsCheckBox;
    sGroupBox1: TsGroupBox;
    sLabel4: TsLabel;
    edCodCaixa: TsEdit;
    chConvCaixa: TCheckBox;
    ed_dir_com: TsEdit;
    sSpeedButton1: TsSpeedButton;
    lb_dir_com: TsLabel;
    bt_clean_dir_terr: TsSpeedButton;
    bt_clean_dir_zona: TsSpeedButton;
    bt_clean_tipo: TsSpeedButton;
    bt_clean_dir_com: TsSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure bt_guardarClick(Sender: TObject);
    procedure save_exp;
    procedure bt_search_dir_zonaClick(Sender: TObject);
    procedure bt_search_dir_terrClick(Sender: TObject);
    procedure bt_search_tipologiaClick(Sender: TObject);
    procedure cb_enviar_incidencia_estClick(Sender: TObject);
    procedure sSpeedButton1Click(Sender: TObject);
    procedure bt_clean_dir_terrClick(Sender: TObject);
    procedure bt_clean_dir_zonaClick(Sender: TObject);
    procedure bt_clean_tipoClick(Sender: TObject);
    procedure bt_clean_dir_comClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_delegacion: Tf_delegacion;
  mode:integer;              //0 = modo edicion    1 = modo nueva

implementation

uses
  u_dm, u_main, ubuscapro;

{$R *.dfm}

{$REGION 'Ini-Close'}
procedure Tf_delegacion.FormShow(Sender: TObject);
begin
  if mode=0 then begin                                         //modo edicion
    ed_id_deleg.Text:=dm.q_delegaciones.fieldbyname('id_delegacion').asstring;
    ed_cod_ent.Text:=dm.q_delegaciones.fieldbyname('cod_entidad').asstring;
    ed_cod_deleg.Text:=dm.q_delegaciones.fieldbyname('cod_delegacion').asstring;
    ed_nombre.Text:=dm.q_delegaciones.fieldbyname('nombre').asstring;
    ed_dir_1.Text:=dm.q_delegaciones.fieldbyname('direccion').asstring;
    ed_poblacion.Text:=dm.q_delegaciones.fieldbyname('poblacion').asstring;
    ed_provincia.Text:=dm.q_delegaciones.fieldbyname('provincia').asstring;
    ed_cp.Text:=dm.q_delegaciones.fieldbyname('cp').asstring;
    ed_fax.Text:=dm.q_delegaciones.fieldbyname('fax').asstring;
    ed_email.text:=dm.q_delegaciones.FieldByName('email').asstring;
    ed_telefono.Text:=dm.q_delegaciones.fieldbyname('telefono').asstring;
    cb_org_rec.Checked:=dm.q_delegaciones.FieldByName('org_recurrente').AsString='1';
    cb_dest_rec.Checked:=dm.q_delegaciones.FieldByName('dest_recurrente').AsString='1';
    cb_pedir_sobres.Checked:=dm.q_delegaciones.FieldByName('pedir_sobres').AsString='1';
    cb_pedir_traza.checked:=dm.q_delegaciones.FieldByName('pedir_traza').AsString='1';
    cb_enviar_incidencia_est.Checked:=dm.q_delegaciones.FieldByName('enviar_incidencia_est').AsString='1';
    cb_enviar_incidencia_precinto.Checked:=dm.q_delegaciones.FieldByName('enviar_incidencia_precinto').AsString='1';
    ed_dir_zona.Text:=dm.q_delegaciones.FieldByName('id_direccion_zona').AsString;
    lb_dir_zona.Caption:=dm.q_delegaciones.FieldByName('nombre_dir_zona').AsString;
    ed_dir_terr.Text:=dm.q_delegaciones.FieldByName('id_direccion_territorial').AsString;
    lb_dir_terr.Caption:=dm.q_delegaciones.FieldByName('nombre_dir_terr').AsString;
    ed_tipologia.Text:=dm.q_delegaciones.FieldByName('id_tipologia').AsString;
    lb_tipologia.Caption:=dm.q_delegaciones.FieldByName('nombre_tipologia').AsString;

    case indexstr(dm.q_delegaciones.fieldbyname('estado').asstring,['A','B']) of
      0:cb_estado.ItemIndex:=0;
      1:cb_estado.ItemIndex:=1;
    end;

    edCodCaixa.Text := dm.q_delegaciones.FieldByName('cod_caixa').AsString;
    chConvCaixa.Checked := (dm.q_delegaciones.FieldByName('convierte_caixa').AsInteger=1);
    ed_dir_com.Text:=dm.q_delegaciones.FieldByName('id_direccion_comercial').AsString;
    lb_dir_com.Caption:=dm.q_delegaciones.FieldByName('nombre_dir_com').AsString;
  end;

  if mode=1 then begin                                         //modo nuevo
    ed_id_deleg.Text:='';
    ed_cod_ent.Text:='0900';
    ed_cod_deleg.Text:='';
    ed_nombre.Text:='';
    ed_dir_1.Text:='';
    ed_poblacion.Text:='';
    ed_provincia.Text:='';
    ed_cp.Text:='';
    ed_fax.Text:='';
    ed_email.text:='';
    ed_telefono.Text:='';
    cb_estado.ItemIndex:=0;
    cb_org_rec.Checked:=false;
    cb_dest_rec.Checked:=false;
    cb_pedir_sobres.Checked:=false;
    cb_pedir_traza.Checked:=false;
    cb_enviar_incidencia_est.Checked:=true;
    cb_enviar_incidencia_precinto.Checked:=true;
    ed_dir_zona.Text:='';
    lb_dir_zona.Caption:='';
    ed_dir_terr.Text:='';
    lb_dir_terr.Caption:='';
    ed_tipologia.Text:='';
    lb_tipologia.Caption:='';
    ed_dir_com.Text:='';
    lb_dir_com.Caption:='';
    edCodCaixa.Text := '';
    chConvCaixa.Checked := False;
  end;
end;

procedure Tf_delegacion.bt_clean_dir_comClick(Sender: TObject);
begin
  ed_dir_com.Text:='';
  lb_dir_com.Caption:='';
end;

procedure Tf_delegacion.bt_clean_dir_terrClick(Sender: TObject);
begin
  ed_dir_terr.Text:='';
  lb_dir_terr.Caption:='';
end;

procedure Tf_delegacion.bt_clean_dir_zonaClick(Sender: TObject);
begin
  ed_dir_zona.Text:='';
  lb_dir_zona.Caption:='';
end;

procedure Tf_delegacion.bt_guardarClick(Sender: TObject);
begin
  save_exp;
  close;
end;
{$ENDREGION}

{$REGION 'Process'}
procedure Tf_delegacion.save_exp;
var id_deleg,i:integer;
begin
 if trystrtoint(ed_cp.Text,i) then begin
    if ((i=0) or (i>99999)) then raise exception.create('CP Inválido');
  end else raise exception.create('CP Requerido');

  if trystrtoint(ed_cod_ent.Text,i) then begin
    if ((i<0) or (i>9999)) then raise exception.create('Código de Entidad Inválido');
  end else raise exception.create('Código de Entidad Requerido');

  if trystrtoint(ed_cod_deleg.Text,i) then begin
    if ((i<0) or (i>9999)) then raise exception.create('Código de Delegación Inválido');
  end else raise exception.create('Código de Delegación Requerido');

  if ed_nombre.Text='' then raise exception.create('Nombre Requerido');

  if ed_dir_zona.text='' then raise exception.Create('Dirección de Zona Requerida');
  if ed_dir_terr.text='' then raise exception.Create('Dirección Territorial Requerida');
  if ed_tipologia.text='' then raise exception.Create('Tipologia Requerida');
  //if ed_dir_com.text='' then raise exception.Create('Dirección Comercial Requerida');


  if mode=0 then begin                                  //modo edicion
    id_deleg:=StrToInt(ed_id_deleg.Text);

    dm.t_write.StartTransaction;
    try
      dm.qr_update.Close;
      dm.qr_update.sql.Clear;
      dm.qr_update.sql.Add('update e_delegaciones set cod_entidad=:cod_entidad,cod_delegacion=:cod_delegacion,nombre=:nombre,direccion=:direccion,poblacion=:poblacion, '+
        'provincia=:provincia,cp=:cp,telefono=:telefono,fax=:fax,email=:email,estado=:estado,org_recurrente=:org_recurrente,dest_recurrente=:dest_recurrente, '+
        'pedir_sobres=:pedir_sobres,enviar_incidencia_est=:enviar_incidencia_est,enviar_incidencia_precinto=:enviar_incidencia_precinto, '+
        'id_direccion_zona=:id_direccion_zona,id_direccion_territorial=:id_direccion_territorial,id_tipologia=:id_tipologia,pedir_traza=:pedir_traza, '+
        'id_direccion_comercial=:id_direccion_comercial, cod_caixa=:cod_caixa, convierte_caixa=:convierte_caixa ' +
        'where id_delegacion=:id_delegacion');
      dm.qr_update.ParamByName('id_delegacion').AsInteger:=id_deleg;
      dm.qr_update.ParamByName('cod_entidad').AsInteger:=StrToInt(ed_cod_ent.Text);
      dm.qr_update.ParamByName('cod_delegacion').asinteger:=StrToInt(ed_cod_deleg.Text);
      dm.qr_update.ParamByName('nombre').asstring:=ed_nombre.Text;
      dm.qr_update.ParamByName('direccion').asstring:=ed_dir_1.Text;
      dm.qr_update.ParamByName('poblacion').asstring:=ed_poblacion.Text;
      dm.qr_update.ParamByName('provincia').asstring:=ed_provincia.Text;
      dm.qr_update.ParamByName('cp').asstring:=ed_cp.Text;
      dm.qr_update.ParamByName('telefono').asstring:=ed_telefono.Text;
      dm.qr_update.ParamByName('fax').asstring:=ed_fax.Text;
      dm.qr_update.ParamByName('email').asstring:=ed_email.Text;
      dm.qr_update.ParamByName('estado').AsString:=cb_estado.Text[1];
      if cb_org_rec.checked then dm.qr_update.ParamByName('org_recurrente').asinteger:=1
        else dm.qr_update.ParamByName('org_recurrente').asinteger:=0;
      if cb_dest_rec.checked then dm.qr_update.ParamByName('dest_recurrente').asinteger:=1
        else dm.qr_update.ParamByName('dest_recurrente').asinteger:=0;
      if cb_pedir_sobres.checked then dm.qr_update.ParamByName('pedir_sobres').asinteger:=1
        else dm.qr_update.ParamByName('pedir_sobres').asinteger:=0;
      if cb_pedir_traza.checked then dm.qr_update.ParamByName('pedir_traza').asinteger:=1
        else dm.qr_update.ParamByName('pedir_traza').asinteger:=0;
      if cb_enviar_incidencia_est.checked then dm.qr_update.ParamByName('enviar_incidencia_est').asinteger:=1
        else dm.qr_update.ParamByName('enviar_incidencia_est').asinteger:=0;
      if cb_enviar_incidencia_precinto.checked then dm.qr_update.ParamByName('enviar_incidencia_precinto').asinteger:=1
        else dm.qr_update.ParamByName('enviar_incidencia_precinto').asinteger:=0;

      if ed_dir_zona.Text<>'' then
            dm.qr_update.ParamByName('id_direccion_zona').asstring:=ed_dir_zona.Text
      else
            dm.qr_update.ParamByName('id_direccion_zona').Clear;

      if ed_dir_terr.Text<>'' then
            dm.qr_update.ParamByName('id_direccion_territorial').asstring:=ed_dir_terr.Text
      else
            dm.qr_update.ParamByName('id_direccion_territorial').Clear;

      if ed_tipologia.Text<>'' then
            dm.qr_update.ParamByName('id_tipologia').asstring:=ed_tipologia.Text
      else
            dm.qr_update.ParamByName('id_tipologia').Clear;

      if chConvCaixa.checked then dm.qr_update.ParamByName('convierte_caixa').asinteger:=1
        else dm.qr_update.ParamByName('convierte_caixa').asinteger:=0;

      if StrToIntDef(edCodCaixa.Text,-1)>0 then
          dm.qr_update.ParamByName('cod_caixa').AsInteger:=StrToInt(edCodCaixa.Text)
      else begin
             dm.qr_update.ParamByName('cod_caixa').Clear;
      end;

      if StrToIntDef(ed_dir_com.Text,-1)>0 then
          dm.qr_update.ParamByName('id_direccion_comercial').AsInteger:=StrToInt(ed_dir_com.Text)
      else begin
          dm.qr_update.ParamByName('id_direccion_comercial').Clear;
      end;

      dm.qr_update.ExecQuery;

      dm.t_write.Commitretaining;
    except
      dm.t_write.rollbackretaining;
    end;
  end;

  if (mode=1) then begin                                  //modo new
    with tpfibdataset.Create(dm) do begin
      database:=dm.db;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('SELECT GEN_ID(GEN_E_DELEGACIONES_ID, 1) from RDB$DATABASE');
      Open;

      id_deleg:=FieldByName('gen_id').AsInteger;

      Free;
    end;

    dm.t_write.StartTransaction;
    try
      dm.qr_update.Close;
      dm.qr_update.sql.Clear;
      dm.qr_update.sql.Add('insert into e_delegaciones (id_delegacion,id_cliente,cod_entidad,cod_delegacion,nombre,direccion,poblacion, '+
        'provincia,cp,telefono,fax,email,estado,org_recurrente,dest_recurrente,pedir_sobres,enviar_incidencia_est,enviar_incidencia_precinto,' +
        'id_direccion_zona,id_direccion_territorial,id_tipologia,pedir_traza,id_direccion_comercial,cod_caixa,convierte_caixa) ' +
        'values (:id_delegacion,:id_cliente,:cod_entidad,:cod_delegacion,:nombre,:direccion,:poblacion, '+
        ':provincia,:cp,:telefono,:fax,:email,:estado,:org_recurrente,:dest_recurrente,:pedir_sobres, ' +
        ':enviar_incidencia_est,:enviar_incidencia_precinto,:id_direccion_zona,:id_direccion_territorial,:id_tipologia,:pedir_traza, ' +
        ':id_direccion_comercial,:cod_caixa,:convierte_caixa)');
      dm.qr_update.ParamByName('id_delegacion').AsInteger:=id_deleg;
      //dm.qr_update.ParamByName('id_cliente').AsInteger:=2038;
      dm.qr_update.ParamByName('id_cliente').AsInteger:= cliente;
      dm.qr_update.ParamByName('cod_entidad').AsInteger:=StrToInt(ed_cod_ent.Text);
      dm.qr_update.ParamByName('cod_delegacion').AsInteger:=StrToInt(ed_cod_deleg.Text);
      dm.qr_update.ParamByName('nombre').asstring:=ed_nombre.Text;
      dm.qr_update.ParamByName('direccion').asstring:=ed_dir_1.Text;
      dm.qr_update.ParamByName('poblacion').asstring:=ed_poblacion.Text;
      dm.qr_update.ParamByName('provincia').asstring:=ed_provincia.Text;
      dm.qr_update.ParamByName('cp').asstring:=ed_cp.Text;
      dm.qr_update.ParamByName('telefono').asstring:=ed_telefono.Text;
      dm.qr_update.ParamByName('fax').asstring:=ed_fax.Text;
      dm.qr_update.ParamByName('email').asstring:=ed_email.Text;
      dm.qr_update.ParamByName('estado').AsString:=cb_estado.Text[1];
      if cb_org_rec.checked then dm.qr_update.ParamByName('org_recurrente').asinteger:=1
        else dm.qr_update.ParamByName('org_recurrente').asinteger:=0;
      if cb_dest_rec.checked then dm.qr_update.ParamByName('dest_recurrente').asinteger:=1
        else dm.qr_update.ParamByName('dest_recurrente').asinteger:=0;
      if cb_pedir_sobres.checked then dm.qr_update.ParamByName('pedir_sobres').asinteger:=1
        else dm.qr_update.ParamByName('pedir_sobres').asinteger:=0;
      if cb_pedir_traza.checked then dm.qr_update.ParamByName('pedir_traza').asinteger:=1
        else dm.qr_update.ParamByName('pedir_traza').asinteger:=0;
      if cb_enviar_incidencia_est.checked then dm.qr_update.ParamByName('enviar_incidencia_est').asinteger:=1
        else dm.qr_update.ParamByName('enviar_incidencia_est').asinteger:=0;
      if cb_enviar_incidencia_precinto.checked then dm.qr_update.ParamByName('enviar_incidencia_precinto').asinteger:=1
        else dm.qr_update.ParamByName('enviar_incidencia_precinto').asinteger:=0;
        dm.qr_update.ParamByName('id_direccion_zona').asstring:=ed_dir_zona.Text;
      dm.qr_update.ParamByName('id_direccion_territorial').asstring:=ed_dir_terr.Text;
      dm.qr_update.ParamByName('id_tipologia').asstring:=ed_tipologia.Text;

      if StrToIntDef(ed_dir_com.Text,-1)>0 then
        dm.qr_update.ParamByName('id_direccion_comercial').AsString:=ed_dir_com.Text
      else
        dm.qr_update.ParamByName('id_direccion_comercial').Clear;

      if chConvCaixa.checked then dm.qr_update.ParamByName('convierte_caixa').asinteger:=1
        else dm.qr_update.ParamByName('convierte_caixa').asinteger:=0;

      if StrToIntDef(edCodCaixa.Text,-1)>0 then
          dm.qr_update.ParamByName('cod_caixa').AsInteger:=StrToInt(edCodCaixa.Text)
      else begin
             dm.qr_update.ParamByName('cod_caixa').Clear;
      end;


      dm.qr_update.ExecQuery;

      dm.t_write.CommitRetaining;

      f_main.refresh_all_data;
      dm.q_delegaciones.Locate('id_delegacion',id_deleg,[]);
    except on e:Exception do begin
              dm.t_write.rollbackretaining;
              ShowMessage('Error al guardar delegación.' + #13#10 + e.message);
            end;
    end;
  end;
end;
procedure Tf_delegacion.sSpeedButton1Click(Sender: TObject);
begin
    with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='id_direccion_comercial,nombre';
    titulos.commatext:='Id, Nombre';
    from:='e_direcciones_comercial';
    where:='estado<''B''';
    orden[1]:=1; busca:=2;   distinct:=1;   fillimpio:=True;

    showmodal;

    if resultado then begin
      ed_dir_com.Text:=valor[1];
      lb_dir_com.Caption:=valor[2];
    end;
  end;
end;

procedure Tf_delegacion.bt_clean_tipoClick(Sender: TObject);
begin
  ed_tipologia.Text:='';
  lb_tipologia.Caption:='';
end;

{$ENDREGION}

{$REGION 'Search'}
procedure Tf_delegacion.bt_search_dir_terrClick(Sender: TObject);
begin
  with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='id_direccion_territorial,nombre';
    titulos.commatext:='Id, Nombre';
    from:='e_direcciones_territorial';
    where:='estado<''B''';
    orden[1]:=1; busca:=2;   distinct:=1;   fillimpio:=True;

    showmodal;

    if resultado then begin
      ed_dir_terr.Text:=valor[1];
      lb_dir_terr.Caption:=valor[2];
    end;
  end;
end;

procedure Tf_delegacion.bt_search_dir_zonaClick(Sender: TObject);
begin
  with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='id_direccion_zona,nombre';
    titulos.commatext:='Id, Nombre';
    from:='e_direcciones_zona';
    where:='estado<''B''';
    orden[1]:=1; busca:=2;   distinct:=1;   fillimpio:=True;

    showmodal;

    if resultado then begin
      ed_dir_zona.Text:=valor[1];
      lb_dir_zona.Caption:=valor[2];
    end;
  end;
end;


procedure Tf_delegacion.bt_search_tipologiaClick(Sender: TObject);
begin
  with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='id_tipologia,nombre';
    titulos.commatext:='Id, Nombre';
    from:='e_tipologias ';
    where:='estado<''B''';
    orden[1]:=1; busca:=2;   distinct:=1;   fillimpio:=True;

    showmodal;

    if resultado then begin
      ed_tipologia.Text:=valor[1];
      lb_tipologia.Caption:=valor[2];
    end;
  end;
end;

procedure Tf_delegacion.cb_enviar_incidencia_estClick(Sender: TObject);
begin

end;

{$ENDREGION}
end.
