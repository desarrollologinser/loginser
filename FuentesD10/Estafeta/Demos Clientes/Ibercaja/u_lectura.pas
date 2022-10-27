unit u_lectura;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sCheckBox, sGroupBox,pFIBDataSet,strutils,
  Vcl.Buttons, sSpeedButton, Vcl.ExtCtrls, sPanel, sEdit, sLabel, sComboBox,sdialogs,mmsystem,pFIBProps,
  frxClass,frxBarcode, OverbyteIcsWndControl, OverbyteIcsWSocket,
  OverbyteIcsWSocketS, sMemo, DBXJSON, system.Json, Vcl.DBCtrls, sDBComboBox;

type
  Tf_lectura = class(TForm)
    gb_org: TsGroupBox;
    ed_origen: TsEdit;
    gb_dst: TsGroupBox;
    ed_destino: TsEdit;
    gb_1: TsGroupBox;
    lb_org_nombre: TsLabel;
    lb_org_direccion: TsLabel;
    lb_org_poblacion: TsLabel;
    lb_org_coddel: TsLabel;
    gb_11: TsGroupBox;
    lb_dst_nombre: TsLabel;
    lb_dst_direccion: TsLabel;
    lb_dst_poblacion: TsLabel;
    lb_coddel_dst: TsLabel;
    lb_dst_coddel: TsLabel;
    bt_search_org: TsSpeedButton;
    bt_incidencia: TsSpeedButton;
    bt_search_coddel: TsSpeedButton;
    lb_org: TsLabel;
    lb_dst: TsLabel;
    bt_sin_sello: TsSpeedButton;
    cb_origenes: TsComboBox;
    cb_destinos_rec: TsComboBox;
    lb_mod: TsLabel;
    lb_sinsello: TsLabel;
    bt_lleno: TsSpeedButton;
    lb_lleno: TsLabel;
    bt_recall_ean: TsSpeedButton;
    sSpeedButton1: TsSpeedButton;
    fr_eti: TfrxReport;
    ws_1: TWSocketServer;
    b_connect_voice: TsSpeedButton;
    m_tcp_messages: TsMemo;
    b_disconnect: TsSpeedButton;
    grp1: TGroupBox;
    chEtiq: TCheckBox;
    frxEtiqCaixa: TfrxReport;
    frxEtiqInd: TfrxReport;
    cbFmt: TsComboBox;
    btPedirTraza: TsSpeedButton;
    lbPideTraza: TsLabel;
    lb_traza: TsLabel;
    procedure FormShow(Sender: TObject);
    procedure ed_origenKeyPress(Sender: TObject; var Key: Char);
    procedure play_sound(tipo:Integer);
    procedure lectura_origen(ean:string);
    procedure bt_sin_selloClick(Sender: TObject);
    procedure lectura_llegada(id_valija,id_valija_tarjeta:Integer; ean:string);
    procedure gen_incid(id_Valija,tipo:integer; obs:string='');
    procedure ed_destinoKeyPress(Sender: TObject; var Key: Char);
    function lectura_destino(ean:string; isVoice:Boolean = false; const entidad : string = ''):TJSONObject;
    procedure insert_sobre(id_Valija:Integer; traza:string='');
    function get_valija(id_valija:Integer; var redir:boolean; var modulo:string):integer;
    procedure bt_incidenciaClick(Sender: TObject);
    procedure cb_destinos_recChange(Sender: TObject);
    procedure bt_search_orgClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bt_search_coddelClick(Sender: TObject);
    procedure cb_origenesChange(Sender: TObject);
    procedure bt_genera_incidencia(id_Valija_tarjeta,tipo_inc:Integer; ean,obs:string);
    procedure bt_llenoClick(Sender: TObject);
    procedure bt_recall_eanClick(Sender: TObject);
    procedure sSpeedButton1Click(Sender: TObject);
    function dc_ean13(i: int64): String;
    procedure b_connect_voiceClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ws_1ClientConnect(Sender: TObject; Client: TWSocketClient;
      Error: Word);
    procedure ws_1ClientDisconnect(Sender: TObject; Client: TWSocketClient;
      Error: Word);
    procedure dataAvailable(Sender : TObject; Error  : Word);
    function destino_entered(const isVoice : Boolean = False; const entidad : string = ''):TJSONObject;
    procedure b_disconnectClick(Sender: TObject);
    function ExisteEAN(ean:string):Boolean;
    procedure chEtiqClick(Sender: TObject);
    procedure btPedirTrazaClick(Sender: TObject);
  private
    { Private declarations }
    function processJSON(const s:string):string;
    function existe_deleg_bankia(codigo:string): Boolean;
    procedure error_deleg_no_encontrada(var response: TJSONObject);

    //function get_ean_delegacion(deleg:string): string;
  public
    { Public declarations }
    function convierte_caixa(ean:string): boolean;
    function existe_deleg_caixa(codigo:string): Boolean;
    function convierte_caixa_a_bankia(cod_caixa:string): string;
    procedure update_lectura(id_lectura_estafeta: Integer; traza:string);
  end;

var
  f_lectura: Tf_lectura;
  id_valija_tarjeta_act,id_delegacion_dest_act,cod_ent_org_act,cod_del_org_act,uds_act,sello,lleno_act:integer;
  ean_act:string;
  pedir_traza:boolean = false;
  enviar_traza:Boolean = false;
  email_traza, subject_traza:string;
  fecha:tdate;
  cod_deleg_temp:Integer;
  ultima_lectura:Integer = -1;
  es_origen_caixa: Boolean = false;
  es_destino_caixa: Boolean = false;
  idx_fmt: Integer;

const
    ean_caixa = '700001210012';
    ent_caixa = '001';
    deleg_caixa = '2100';

implementation

uses
  u_dm, u_globals, u_select_del, u_incidencia, ubuscapro, u_envia_mail,
  u_lleno, u_recall, u_main;

{$R *.dfm}

{$REGION 'Ini-Close'}
procedure Tf_lectura.FormShow(Sender: TObject);
begin
  ed_origen.Text:='';
  ed_destino.Text:='';
  lb_org.Caption:='';
  lb_dst.Caption:='';
  lb_mod.Caption:='';
  lb_traza.Caption:='';
  lb_sinsello.visible:=false;
  lb_org_coddel.caption:='';
  lb_org.caption:='';
  lb_org_nombre.Caption:='';
  lb_org_direccion.Caption:='';
  lb_org_poblacion.Caption:='';
  lb_dst_coddel.caption:='';
  lb_dst_nombre.Caption:='';
  lb_dst_direccion.Caption:='';
  lb_dst_poblacion.Caption:='';
  lb_lleno.caption:='LLENO';
  lleno_act:=1;

  cbFmt.ItemIndex := idx_fmt;

  with TpFIBDataSet.Create(self) do begin
    database:=dm.db;
    close;
    selectsql.Clear;
    SelectSQL.Add('select cod_delegacion,nombre from e_delegaciones where dest_recurrente=1 and estado=''A''');
    open;

    cb_destinos_rec.Clear;
    while not(eof) do begin
      cb_destinos_rec.additem(formatfloat('0000',FieldByName('cod_delegacion').AsInteger)+'-'+FieldByName('nombre').AsString,TObject(FieldByName('cod_delegacion').AsInteger));
      next;
    end;

    close;
    selectsql.Clear;
    SelectSQL.Add('select d.nombre, d.convierte_caixa, '+
      '(select first 1 vt.id_Valija_tarjeta from e_valijas_tarjetas vt inner join e_valijas v on (vt.id_valija=v.id_valija) where v.id_delegacion=d.id_delegacion) as id '+
      'from e_delegaciones d '+
      'where d.org_recurrente=1 and d.estado=''A''');
    open;

    cb_origenes.Clear;
    while not(eof) do begin

      if FieldByName('convierte_caixa').asinteger=1 then
        cb_origenes.additem(FieldByName('nombre').AsString + ' (C)',TObject(FieldByName('id').asinteger))
      else
        cb_origenes.additem(FieldByName('nombre').AsString,TObject(FieldByName('id').asinteger));
      next;
    end;

    Free;
  end;

  ed_origen.SetFocus;
end;

procedure Tf_lectura.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ws_1.Close;
end;

procedure Tf_lectura.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_F1 then bt_search_orgClick(self);
  if ((Key=VK_F2) and (id_valija_tarjeta_act<>-1)) then bt_sin_selloClick(self);
  if ((Key=VK_F3) and (id_valija_tarjeta_act<>-1)) then bt_search_coddelClick(self);
  if ((Key=VK_F4) and (id_valija_tarjeta_act<>-1)) then bt_incidenciaClick(self);
end;
{$ENDREGION}

{$REGION 'Lectura Origen'}
procedure Tf_lectura.bt_sin_selloClick(Sender: TObject);
var cuerpo:TStringList;
begin
  if sello=1 then begin
    sello:=0;
    lb_sinsello.visible:=true;

    bt_genera_incidencia(id_valija_tarjeta_act,4, ean_act,'');
  end else begin
    sello:=1;
    lb_sinsello.visible:=false;
  end;
end;

procedure Tf_lectura.bt_llenoClick(Sender: TObject);
begin
  if lleno_act=0 then begin
    lleno_act:=1;
    lb_lleno.Caption:='LLENO';
  end else begin
    lleno_act:=0;
    lb_lleno.Caption:='VACIO';
  end;
end;

procedure Tf_lectura.bt_recall_eanClick(Sender: TObject);
begin
  u_recall.fecha:=fecha;
  f_recall.ShowModal;
end;

procedure Tf_lectura.ed_origenKeyPress(Sender: TObject; var Key: Char);
var  ean:string;     tipo:integer;
begin
  if ((Key=chr(13)) and (ed_origen.Text<>'')) then begin
    ean:=ed_origen.Text;

    //es_origen_caixa := (ean = ean_caixa);
    es_origen_caixa := convierte_caixa(ean);

    if Length(ean)=13 then ean:=Copy(ean,2,12);
    //if ((length(ean)=12) or (length(ean)=16) or (length(ean)=21)) then begin
    if ExisteEAN(ean) then
    begin
      if Length(ean)=12 then begin
        tipo:=strtoint(Copy(ean,1,2));
        if tipo=60 then begin                    //financiacion especializada
          lectura_origen('609999561311');
          lectura_destino(Copy(ean,7,4));
          Exit;
        end else if tipo=62 then begin                    //talones servinform
          lectura_origen('009999566252');
          lectura_destino(Copy(ean,7,4));
        end else if tipo=63 then begin                    //talones a2
          lectura_origen('009999566313');
          lectura_destino(Copy(ean,7,4));
        end else lectura_origen(ean);
      end else lectura_origen(ean);
    end else begin
      id_valija_tarjeta_act:=-1;
      ean_act:='-1';

      lb_org_coddel.caption:='Not Found';
      lb_org.caption:='EAN Incorrecto';
      lb_org_nombre.Caption:='';
      lb_org_direccion.Caption:='';
      lb_org_poblacion.Caption:='';

      play_sound(1);
      ed_origen.SetFocus;
    end;
    ed_origen.Text:='';
  end;
end;

procedure Tf_lectura.lectura_origen(ean:string);                                //Es una lectura de una valija de origen
begin
   if (ean<>'') then
   begin
    with tpfibdataset.Create(dm) do begin                                   //Busca la valija del EAN
      database:=dm.db;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select vt.id_valija_tarjeta,v.id_valija,v.id_modulo,d.cod_entidad,d.cod_delegacion,d.nombre,d.direccion,d.poblacion,d.cp,d.provincia,d.pedir_traza,d.enviar_aviso_traza, d.email_traza, d.email_subject_traza '+
        'from e_valijas_tarjetas vt '+
        'inner join e_valijas v on (vt.id_valija=v.id_valija) '+
        'inner join e_delegaciones d on (v.id_delegacion=d.id_delegacion) '+
        'where ((vt.ean=:ean) or (vt.ean_alt=:ean) or (vt.ean_old=:ean) or (vt.ean_old2=:ean)) and v.estado=''A'' '+
        'order by vt.id_valija_tarjeta');
      ParamByName('ean').AsString:=ean;
      Open;

      if not(isempty) then begin                                                          //EAN Correcto
        sello:=1;
        lb_sinsello.visible:=false;
        id_valija_tarjeta_act:=FieldByName('id_valija_tarjeta').AsInteger;
        ean_act:=ean;
        cod_ent_org_act:=FieldByName('cod_entidad').AsInteger;
        cod_del_org_act:=FieldByName('cod_delegacion').AsInteger;
        pedir_traza:=fieldbyname('pedir_traza').AsInteger = 1;
        enviar_traza:=FieldByName('enviar_aviso_traza').AsInteger = 1;
        email_traza:=FieldByName('email_traza').AsString;
        subject_traza:=FieldByName('email_subject_traza').AsString;

        lectura_llegada(FieldByName('id_valija').AsInteger,FieldByName('id_valija_tarjeta').AsInteger,ean);

        lb_org_coddel.caption:=rightstr('0000'+FieldByName('cod_entidad').AsString,4)+'-'+rightstr('0000'+FieldByName('cod_delegacion').AsString,4);
        lb_org.caption:=rightstr('0000'+FieldByName('cod_entidad').AsString,4)+'-'+rightstr('0000'+FieldByName('cod_delegacion').AsString,4)+' M-'+fieldbyname('id_modulo').asstring;
        lb_org_nombre.Caption:=FieldByName('nombre').AsString;
        lb_org_direccion.Caption:=FieldByName('direccion').AsString;
        lb_org_poblacion.Caption:=FieldByName('poblacion').AsString+' - '+FieldByName('cp').AsString+' - '+FieldByName('provincia').AsString;

        //btPedirTraza.Enabled := pedir_traza;
        //lbPideTraza.Visible := pedir_traza;

        ed_destino.Text:='';
        ed_destino.SetFocus;
      end else begin                                                                 //EAN Desconocido
        id_valija_tarjeta_act:=-1;
        ean_act:='-1';
        cod_del_org_act:=-1;

        lb_org_coddel.caption:='Not Found';
        lb_org.caption:='EAN Desconocido';
        lb_org_nombre.Caption:='';
        lb_org_direccion.Caption:='';
        lb_org_poblacion.Caption:='';

        btPedirTraza.Enabled := False;

        play_sound(1);
        ed_origen.SetFocus;
      end;

      Free;
    end;
   end;
end;

procedure Tf_lectura.lectura_llegada(id_valija,id_valija_tarjeta:Integer; ean:string);
var  id_agencia:integer;
begin
  with TpFIBDataSet.Create(dm) do begin
    database:=dm.db;                                              //no se ha leido en la llegada
    close;
    SelectSQL.Clear;
    SelectSQL.Add('select ean from e_lecturas where id_Valija_tarjeta=:id_Valija_tarjeta '+
            ' and fecha=:fecha and tipo_lectura=0 and id_empresa=:empresa');
    ParamByName('id_Valija_tarjeta').asinteger:=id_Valija_tarjeta;
    ParamByName('fecha').AsDate:=fecha;
    ParamByName('empresa').AsInteger:=u_globals.id_empresa;
    Open;

    if isempty then begin
      close;                                                                //no tiene incidencia
      SelectSQL.Clear;
      SelectSQL.Add('select i.id_valija '+
        'from e_incidencias i '+
        'where i.fecha=:fecha and i.tipo_lectura=0 and i.id_valija=:id_Valija ');
      ParamByName('id_Valija').asinteger:=id_Valija;
      ParamByName('fecha').AsDate:=fecha;
      Open;

      if isempty then begin
        close;                                                                //a que agencia corresponde
        SelectSQL.Clear;
        SelectSQL.Add('select v.id_agencia '+
          'from e_valijas v '+
          'where v.id_Valija=:id_Valija');
        ParamByName('id_Valija').asinteger:=id_Valija;
        Open;

        if not(isempty) then begin                                                 //le corresponde venir hoy
          id_Agencia:=fieldbyname('id_Agencia').AsInteger;

          close;
          SelectSQL.Clear;
          SelectSQL.Add('select v.id_valija '+
            'from e_valijas v '+
            'where v.id_Valija=:id_Valija and v.estado=''A'' '+
            ' and v.dias_semana like ''%''||(select * from dia_semana_disp(:fecha,v.disp_llegada))||''%'' ');
          ParamByName('id_Valija').asinteger:=id_Valija;
          ParamByName('fecha').AsDate:=fecha;
          Open;

          if not(isempty) then begin                                            //Inserta Lectura
            dm.t_write.StartTransaction;
            try
              dm.qr_update.Close;
              dm.qr_update.SQL.Clear;
              dm.qr_update.SQL.Add('insert into e_lecturas (id_valija_tarjeta,fecha,ean,tipo_lectura,manual,id_centro_lectura) values ' +
                                   '(:id_valija_tarjeta,:fecha,:ean,:tipo_lectura,:manual,:id_centro_lectura)');
              dm.qr_update.ParamByName('id_valija_tarjeta').AsInteger:=id_valija_tarjeta;
              dm.qr_update.ParamByName('fecha').Asdate:=fecha;
              dm.qr_update.ParamByName('ean').AsString:=ean;
              dm.qr_update.ParamByName('tipo_lectura').AsInteger:=0;
              dm.qr_update.ParamByName('manual').AsInteger:=2;
              dm.qr_update.ParamByName('id_centro_lectura').AsInteger:=u_globals.cent_lect;
              dm.qr_update.ExecQuery;

              dm.t_write.CommitRetaining;
            except
              dm.t_write.RollbackRetaining;
            end;
          end else begin
            gen_incid(id_valija,11,'Aut=Valija No Esperada Este Día');            //no le corresponde venir hoy
          end;
        end;
      end;
    end;

    Free;
  end;
end;

procedure Tf_lectura.gen_incid(id_Valija,tipo:integer; obs:string='');
begin
  dm.t_write.StartTransaction;
  try
    dm.qr_update.Close;
    dm.qr_update.SQL.Clear;
    dm.qr_update.SQL.Add('insert into e_incidencias (id_valija,id_tipo_incidencia,fecha,tipo_lectura,id_centro_lectura,observaciones) '+
                         'values (:id_valija,:id_tipo_incidencia,:fecha,:tipo_lectura,:id_centro_lectura,:observaciones)');
    dm.qr_update.ParamByName('id_valija').AsInteger:=id_valija;
    dm.qr_update.ParamByName('id_tipo_incidencia').AsInteger:=tipo;
    dm.qr_update.ParamByName('fecha').Asdate:=fecha;
    dm.qr_update.ParamByName('tipo_lectura').AsInteger:=0;
    dm.qr_update.ParamByName('id_centro_lectura').AsInteger:=u_globals.cent_lect;
    dm.qr_update.ParamByName('observaciones').Asstring:=Copy(obs,1,100);
    dm.qr_update.ExecQuery;
    dm.t_write.CommitRetaining;
  except
    dm.t_write.RollbackRetaining;
  end;
end;

procedure Tf_lectura.bt_search_orgClick(Sender: TObject);
var c:char;
begin
  with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='d.cod_entidad,d.cod_delegacion,d.nombre,d.direccion,d.cp,d.poblacion,d.id_delegacion';
    titulos.commatext:='Entidad,Deleg,Nombre,Dirección,CP,Localidad,Id';
    from:='e_delegaciones d';
    where:='d.estado<''B''';
    orden[1]:=1;  orden[2]:=2;
    busca:=2;   distinct:=0;   fillimpio:=True;
    wide[1]:=35;   wide[2]:=35;   wide[3]:=135;   wide[4]:=135;   wide[5]:=35; //Anchuras de columnas

    showmodal;

    if resultado then begin
      with tpfibdataset.Create(dm) do begin                                   //Busca la valija
        database:=dm.db;
        SQLs.SelectSQL.Clear;
        SQLs.SelectSQL.Add('select vt.id_valija_tarjeta,vt.ean '+
          'from e_delegaciones d '+
          'inner join e_valijas v on (d.id_delegacion=v.id_delegacion) '+
          'inner join e_valijas_tarjetas vt on (vt.id_valija=v.id_Valija) '+
          'where d.cod_entidad=:cod_entidad and d.cod_delegacion=:coddel and vt.estado=''A'' '+
          'order by vt.n_tarjeta');
        ParamByName('cod_entidad').AsInteger:=valor[1];
        ParamByName('coddel').AsInteger:=valor[2];
        Open;

        ed_origen.Text:=FieldByName('ean').AsString;
        c:=chr(13);
        ed_origenKeyPress(ed_origen,c);

        Free;
      end;
    end;
  end;
end;

procedure Tf_lectura.cb_origenesChange(Sender: TObject);                   //Selecciona origen recurrente
var c:char;     id:integer;
begin
  id:=Integer(cb_origenes.Items.objects[cb_origenes.ItemIndex]);

  with tpfibdataset.Create(self) do begin
    database:=dm.db;
    close;
    SelectSQL.clear;
    SelectSQL.Add('select ean from e_valijas_tarjetas where id_valija_tarjeta=:id');
    ParamByName('id').AsInteger:=id;
    open;

    ed_origen.Text:=FieldByName('ean').asstring;
    free;
  end;

  c:=chr(13);
  ed_origenKeyPress(ed_origen,c);
end;
procedure Tf_lectura.chEtiqClick(Sender: TObject);
begin
  cbFmt.Visible := chEtiq.Checked;
end;

{$ENDREGION}

{$REGION 'Lectura Destino'}
procedure Tf_lectura.ed_destinoKeyPress(Sender: TObject; var Key: Char);
begin
  if ((Key=chr(13)) and (ed_destino.Text<>'')) then
  begin
    if id_valija_tarjeta_act<=0 then
    begin
      sShowMessage('Error de lectura','Debe seleccionar un orígen válido.');
      Exit;
    end;
    destino_entered();
  end;
end;

function Tf_lectura.destino_entered(const isVoice : Boolean = False; const entidad : string = ''):TJsonObject;
var  ean:string;   c:char;    tipo:integer;    response: TJSONObject;
     cod_bankia, cod_caixa, ean_bankia: string; existe_bankia:Boolean;
begin
  ean:=ed_destino.Text;

  if Length(ean)=13 then ean:=Copy(ean,2,12);

  es_destino_caixa := False;
  existe_bankia := False;
  if not es_origen_caixa then
  begin
    //if (Length(ean)=16) or (Length(ean)=21) then begin           //es un ean de valija chrono -> se lo pasa al de arriba
    if ExisteEAN(ean) and (ean<>ean_caixa) then begin
      ed_origen.Text:=ed_destino.text;
      c:=chr(13);
      ed_origenKeyPress(ed_origen,c);
    end else if (length(ean)=12) then begin          //es ean lgs o mensy
      tipo:=StrToInt(Copy(ean,1,2));
      if (tipo<60) then begin     //es una valija de lgs/mensy -> se lo pasa al de arriba
        ed_origen.Text:=ed_destino.text;
        c:=chr(13);
        ed_origenKeyPress(ed_origen,c);
      end else begin
        if tipo=60 then begin                //es financiación especializada
          ean:='5613';
          response := lectura_destino(ean, isVoice, entidad);
        end else if tipo=62 then begin                //es talones servinform
          ean:=Copy(ean,7,4);
          ed_origen.Text:='009999566214';
          c:=chr(13);
          ed_origenKeyPress(ed_origen,c);
          response := lectura_destino(ean, isVoice, entidad);
        end else if tipo=63 then begin                //es talones a2
          ean:=Copy(ean,7,4);
          ed_origen.Text:='009999566313';
          c:=chr(13);
          ed_origenKeyPress(ed_origen,c);
          response := lectura_destino(ean, isVoice, entidad);
        end else response := lectura_destino(ean, isVoice, entidad);
      end;
    end else if (Length(ean)=4) OR (Length(ean)=21) then begin               //es un codigo de delegacion
        if (Length(ean)=4) then
        begin
          es_destino_caixa := ((ed_destino.Text=deleg_caixa) or ((not existe_deleg_bankia(ean)) and (existe_deleg_caixa(ean))));
          if not es_destino_caixa then
              response := lectura_destino(ean, isVoice, entidad)
          else
              response := lectura_destino(deleg_caixa, isVoice, entidad);
        end else
            response := lectura_destino(ean, isVoice, entidad);
    end else if Length(ean)=26 then begin
        response := lectura_destino(Copy(ean,23,4), isVoice, entidad);
    end else if (Copy(ean,0,3)=ent_caixa) then begin                     //destino Caixa
           es_destino_caixa := True;
           cod_bankia := '';
           if Pos('-',ean)>0 then
                cod_caixa := Copy(ean,Pos('-',ean)+1,Length(ean)-1)
           else
                cod_caixa := Copy(ean,3,Length(ean)-1);
           //cod_bankia := convierte_caixa_a_bankia(cod_caixa);
           cod_bankia := deleg_caixa;
           response := lectura_destino(deleg_caixa, isVoice, entidad);
    end else begin
      error_deleg_no_encontrada(response);
    end;
  end else begin   //es origen caixa
    es_destino_caixa := True;
    if (Copy(ean,0,3)=ent_caixa) then begin
       if Pos('-',ean)>0 then
                cod_caixa := Copy(ean,Pos('-',ean)+1,Length(ean)-1)
           else
                cod_caixa := Copy(ean,3,Length(ean)-1);

       if existe_deleg_caixa(cod_caixa) then
       begin
          cod_bankia := convierte_caixa_a_bankia(cod_caixa);
          response := lectura_destino(cod_bankia, isVoice, entidad);
       end
       else
            error_deleg_no_encontrada(response);
    end else if ean=ean_caixa then
             begin
               response := lectura_destino(ean, isVoice, entidad);
             end else if (Length(ean)=4) then
                      begin
                         cod_caixa := ean;
                         if existe_deleg_caixa(cod_caixa) then
                         begin
                            cod_bankia := convierte_caixa_a_bankia(cod_caixa);
                            response := lectura_destino(cod_bankia, isVoice, entidad);
                         end
                         else
                              error_deleg_no_encontrada(response);
                      end;
  end;

  ed_destino.Text:='';
  Result := response;
end;

procedure Tf_lectura.cb_destinos_recChange(Sender: TObject);            //Selecciona destino recurrente
var c:char;
begin
  ed_destino.Text:=RightStr('0000'+IntToStr(integer(cb_destinos_rec.Items.objects[cb_destinos_rec.ItemIndex])),4);
  c:=chr(13);
  ed_destinoKeyPress(ed_destino,c);
end;


function Tf_lectura.lectura_destino(ean:string; isVoice:Boolean = false; const entidad : string = ''):TJSONObject;                                //Es una lectura de una valija de destino
var cod_del,cod_ent,id_valija,id_valija_redir,dest_especial:integer;    nombre,direccion,poblacion,cp,provincia,uds,traza,email,modulo:string;    redir,pedir_sobres,dos_digitos:Boolean;
cuerpo:tstringlist;   response:TJSONObject;   jar: TJSONArray;    obj: TJSONObject;
deleg, delegC: TfrxMemoView; bc:TfrxBarCodeView;
begin
  if Length(ean)=21 then
  begin
    with dm.q_1 do
    begin
      Close;
      SelectSQL.Add('select cod_delegacion from e_delegaciones d ' +
                    'inner join e_valijas v on v.id_delegacion=d.id_delegacion ' +
                    'inner join e_valijas_tarjetas t on t.id_valija=v.id_valija ' +
                    'where t.ean=:ean and t.estado=''A'' ');
      ParamByName('ean').AsString := ean;
      Open;
      cod_del := FieldByName('cod_delegacion').AsInteger;
    end;
  end
  else
    cod_del:=strtoint(Copy(ean,1,4));

  with dm.q_delegs do begin                                   //Busca la valija del EAN
    Close;
    database:=dm.db;
    Options:=[potrimcharfields,porefreshafterpost,postarttransaction,poautoformatfields,pofetchall];
    SelectSQL.Clear;
    SelectSQL.Add('select d.id_delegacion,d.cod_entidad,d.cod_delegacion,d.nombre,d.direccion,d.poblacion,d.cp,d.provincia,d.pedir_sobres '+
      'from e_delegaciones d '+
      'where d.cod_delegacion=:coddel and d.estado=''A'' ');
    ParamByName('coddel').Asinteger:=cod_del;
    Open;

    First;
    if isempty then begin                                          //no encontrada
      id_delegacion_dest_act:=-1;
      uds_act:=-1;

      lb_dst_coddel.caption:='Not Found';
      lb_dst.caption:='Delegación No Encontrada';
      lb_dst_nombre.Caption:='';
      lb_dst_direccion.Caption:='';
      lb_dst_poblacion.Caption:='';

      play_sound(1);
      ed_destino.SetFocus;

      response := TJSONObject.Create;
      response.addpair('mensaje','DELEGACION');
      jar := TJSONArray.Create;
      obj := TJSONObject.Create;
      obj.AddPair('tipo', 'numero');
      obj.AddPair('longitud', '4');
      obj.AddPair('prompt', 'delegacion incorrecta');
      obj.AddPair('ayuda', 'lea la siguiente delegacion');
      jar.AddElement(obj);
      response.addPair('input',jar);
    end else begin
      uds_Act:=1;
      if RecordCount>1 then begin                     //mas de una delegacion
        if (isVoice) then begin
          if (entidad = '') then begin
            response := TJSONObject.Create;
            response.addpair('mensaje','ENTIDAD');
            jar := TJSONArray.Create;
            obj := TJSONObject.Create;
            obj.AddPair('tipo', 'numero');
            obj.AddPair('longitud', '4');
            obj.AddPair('prompt', 'entidad');
            obj.AddPair('ayuda', 'delegacion duplicada, lea entidad');
            jar.AddElement(obj);
            response.addPair('input',jar);

            result := response;

            Exit;
          end else begin
            dm.q_1.close;
            dm.q_1.selectsql.clear;
            dm.q_1.selectsql.add('select d.id_delegacion,d.cod_entidad,d.cod_delegacion,d.nombre,d.direccion,d.poblacion,d.cp,d.provincia,d.pedir_sobres '+
              'from e_delegaciones d '+
              'where d.cod_delegacion=:coddel and d.estado=''A'' and d.cod_entidad=:codent ');
            dm.q_1.ParamByName('coddel').Asinteger:=cod_del;
            dm.q_1.ParamByName('codent').Asinteger:=strtoint(entidad);
            dm.q_1.Open;

            if dm.q_1.isempty then begin
              response := TJSONObject.Create;
              response.addpair('mensaje','ENTIDAD');
              jar := TJSONArray.Create;
              obj := TJSONObject.Create;
              obj.AddPair('tipo', 'numero');
              obj.AddPair('longitud', '4');
              obj.AddPair('prompt', 'entidad incorrecta');
              obj.AddPair('ayuda', 'delegacion duplicada, lea entidad');
              jar.AddElement(obj);
              response.addPair('input',jar);

              result := response;

              Exit;
            end else begin
              id_delegacion_dest_act:=dm.q_1.fieldbyname('id_delegacion').asinteger;
              cod_ent:=dm.q_1.fieldbyname('cod_entidad').asinteger;
              nombre:=dm.q_1.fieldbyname('nombre').asstring;
              direccion:=dm.q_1.fieldbyname('direccion').asstring;
              poblacion:=dm.q_1.fieldbyname('poblacion').asstring;
              cp:=dm.q_1.fieldbyname('cp').asstring;
              provincia:=dm.q_1.fieldbyname('provincia').asstring;
              pedir_sobres:=dm.q_1.fieldbyname('pedir_sobres').asinteger = 1;
            end;
          end;
        end else begin
          {f_select_del.ng_del.ClearRows;
          f_select_del.ng_del.beginupdate;
          while not(eof) do begin
            f_select_del.ng_del.AddRow;
            f_select_del.ng_del.Cell[0,f_select_del.ng_del.RowCount-1].asinteger:=FieldByName('id_delegacion').asinteger;
            f_select_del.ng_del.Cell[1,f_select_del.ng_del.RowCount-1].asinteger:=FieldByName('cod_entidad').asinteger;
            f_select_del.ng_del.Cell[2,f_select_del.ng_del.RowCount-1].asinteger:=FieldByName('cod_delegacion').asinteger;
            f_select_del.ng_del.Cell[3,f_select_del.ng_del.RowCount-1].AsString:=FieldByName('nombre').asstring;
            f_select_del.ng_del.Cell[4,f_select_del.ng_del.RowCount-1].AsString:=FieldByName('direccion').asstring;
            f_select_del.ng_del.Cell[5,f_select_del.ng_del.RowCount-1].AsString:=FieldByName('poblacion').asstring;
            f_select_del.ng_del.Cell[6,f_select_del.ng_del.RowCount-1].AsString:=FieldByName('cp').asstring;
            f_select_del.ng_del.Cell[7,f_select_del.ng_del.RowCount-1].AsString:=FieldByName('provincia').asstring;
            f_select_del.ng_del.Cell[8,f_select_del.ng_del.RowCount-1].asinteger:=FieldByName('pedir_sobres').asinteger;
            next;
          end;
          f_select_del.ng_del.endupdate;   }

          f_select_del.ShowModal;
          if f_select_del.id_delegacion<>-1 then begin
            id_delegacion_dest_act:=f_select_del.id_delegacion;
            cod_ent:=f_select_del.cod_entidad;
            nombre:=f_select_del.nombre;
            direccion:=f_select_del.direccion;
            poblacion:=f_select_del.poblacion;
            cp:=f_select_del.cp;
            provincia:=f_select_del.provincia;
            pedir_sobres:=f_select_del.pedir_sobres;
          end else begin
            id_delegacion_dest_act:=-1;
            uds_act:=-1;

            lb_dst_coddel.caption:='Not Found';
            lb_dst.caption:='Cancelado';
            lb_dst_nombre.Caption:='';
            lb_dst_direccion.Caption:='';
            lb_dst_poblacion.Caption:='';
            pedir_sobres:=False;

            play_sound(1);
            ed_destino.SetFocus;
            Exit;
          end;
        end;
      end else begin                                      //solo una delegacion
        id_delegacion_dest_act:=FieldByName('id_delegacion').asinteger;
        cod_ent:=FieldByName('cod_entidad').asinteger;
        nombre:=FieldByName('nombre').asstring;
        direccion:=FieldByName('direccion').asstring;
        poblacion:=FieldByName('poblacion').asstring;
        cp:=FieldByName('cp').asstring;
        provincia:=FieldByName('provincia').asstring;
        pedir_sobres:=FieldByName('pedir_sobres').AsInteger=1;
      end;

      close;
      SelectSQL.Clear;
      SelectSQL.Add('select * '+
        'from e_valijas '+
        'where id_delegacion=:id_del '+
        'and estado=''A'' ');
      ParamByName('id_del').AsInteger:=id_delegacion_dest_act;
      Open;

      if not(IsEmpty) then begin
        redir:=False;
        id_Valija:=get_valija(FieldByName('id_valija').asinteger,redir, modulo);
      end else begin                            //destino no tiene valija
        lb_mod.Caption:=nombre;
        id_valija:=-1;
        modulo := '0';
      end;

      lb_dst_coddel.caption:=rightstr('0000'+inttostr(cod_ent),4)+'-'+rightstr('0000'+inttostr(cod_del),4);
      lb_dst.caption:=rightstr('0000'+inttostr(cod_ent),4)+'-'+rightstr('0000'+inttostr(cod_del),4);
      lb_dst_nombre.Caption:=nombre;
      lb_dst_direccion.Caption:=direccion;
      lb_dst_poblacion.Caption:=poblacion+' - '+cp+' - '+provincia;


      if (pedir_sobres) then begin
        dos_digitos := False;
        while not dos_digitos do
        begin
          uds:=InputBox('Unidades A Leer','Unidades A Leer','1');
          dos_digitos := (Length(uds)<=u_main.dig_sobres);
          if not dos_digitos then sMessageDlg('Longitud Incorrecta (máx. ' + IntToStr(u_main.dig_sobres) + ' dígitos).',mtError,[mbok],0);
        end;
        if not(TryStrToInt(uds,uds_act)) then uds_act:=1;
      end else uds_act:=1;


      if (pedir_traza) then begin
        traza:=InputBox('Traza','Traza','');

        dm.q_2.close;
        dm.q_2.selectsql.clear;
        dm.q_2.selectsql.add('select email from e_delegaciones where id_delegacion=:id_delegacion');
        dm.q_2.parambyname('id_delegacion').asinteger:=id_delegacion_dest_act;
        dm.q_2.open;

        if (enviar_traza) then begin
          email:=dm.q_2.fieldbyname('email').asstring;

          cuerpo:=tstringlist.create();
          cuerpo.Add(Format(email_traza,[traza]));

          f_envia_mail.Show;
          f_envia_mail.envia_email(email,'distribucionbankia@loginser.com',
          //f_envia_mail.envia_email('gerencia@loginser.com','informatica@loginser.com',
            Format(subject_traza,[traza]),
            '','',
            cuerpo,
            2);
          f_envia_mail.close;
        end;
      end else traza:='';

      insert_sobre(id_valija,traza);

      response := TJSONObject.Create;
      response.addpair('mensaje','DELEGACION');
      jar := TJSONArray.Create;
      obj := TJSONObject.Create;
      obj.AddPair('tipo', 'numero');
      obj.AddPair('longitud', '4');
      obj.AddPair('prompt', 'Modulo '+modulo);
      obj.AddPair('ayuda', 'lea la siguiente delegacion');
      jar.AddElement(obj);
      response.addPair('input',jar);

      ed_destino.SetFocus;
    end;
  end;
  Result := response;

  if es_origen_caixa and chEtiq.Checked then
  begin

      case cbFmt.ItemIndex of
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
                delegC.Text := Trim(ed_destino.Text + ' Centro Caixa')
           else
                delegC.Text := Trim(ent_caixa + '-' + ed_destino.Text + ' Centro Caixa');

        if Assigned(deleg) then
          deleg.Text := Trim('OF.' + IntToStr(cod_del) + ' BANKIA');

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
                   bc.Text := FieldByName('ean').AsString;
            end else
                    if Assigned(bc) then
                        bc.Text := ean;
          end;
        end
        else begin
               if Assigned(bc) then
                   bc.Text := ean;
        end;

      case cbFmt.ItemIndex of
        0: begin
              frxEtiqCaixa.printoptions.printer := u_globals.imp_eti;
              frxEtiqCaixa.PrintOptions.ShowDialog := False;
              if frxEtiqCaixa.PrepareReport(true) then
                   frxEtiqCaixa.Print;
        end;

        1: begin
              frxEtiqInd.printoptions.printer := u_globals.imp_eti;
              frxEtiqInd.PrintOptions.ShowDialog := False;
              if frxEtiqInd.PrepareReport(true) then
                   frxEtiqInd.Print;
        end;
      end;


  end;
end;

function Tf_lectura.get_valija(id_valija:Integer; var redir:boolean; var modulo:string):integer;
var dest_especial,id_valija_res,id_valija_redir:integer;     prefix:string;
begin
  id_valija_redir:=-1;
  if redir then begin
    with TpFIBDataSet.Create(dm) do begin
      Database:=dm.db;
      close;
      SelectSQL.Clear;
      SelectSQL.Add('select d.cod_delegacion '+
        'from e_delegaciones d '+
        'inner join e_valijas v on (d.id_delegacion=v.id_delegacion) '+
        'where v.id_valija=:id_val '+
        'and v.estado=''A'' ');
      ParamByName('id_val').AsInteger:=id_valija;
      Open;

      prefix:='REDIR('+fieldbyname('cod_delegacion').asstring+') ';

      free;
    end;
  end else prefix:='';

  with TpFIBDataSet.Create(dm) do begin
    Database:=dm.db;
    close;
    SelectSQL.Clear;
    SelectSQL.Add('select * '+
      'from e_valijas '+
      'where id_valija=:id_val '+
      'and estado=''A'' ');
    ParamByName('id_val').AsInteger:=id_valija;
    Open;

    modulo := '0';
    if not(IsEmpty) then begin
      modulo := fieldbyname('id_modulo').asstring;
      id_valija_redir:=FieldByName('id_valija_redir').AsInteger;
      if id_valija_redir>0 then begin                                     //destino redirigido
        redir:=true;
        id_valija_res:=get_valija(id_Valija_redir,redir, modulo);
      end else begin
        dest_especial:=FieldByName('dest_especiales').AsInteger;

        if dest_especial>0 then begin
          case dest_especial of
            1: lb_mod.Caption:=prefix+'Canarias';
            2: lb_mod.Caption:=prefix+'Baleares';
            3: lb_mod.Caption:=prefix+'BPO';
            4: lb_mod.Caption:=prefix+'Archivo';
            5: lb_mod.Caption:=prefix+'Accenture';
            else lb_mod.Caption:=prefix+'Especial Desconocido';
          end
        end else begin
          lb_mod.Caption:=prefix+'M'+fieldbyname('id_modulo').AsString+'-C'+fieldbyname('id_casillero').AsString+'-H'+fieldbyname('id_hueco').AsString+'  '+fieldbyname('mnemonico').AsString;
        end;
        id_Valija_res:=FieldByName('id_valija').AsInteger;
      end;
      Result:=id_valija_res;
    end else begin                                  //destino no tiene valija
      lb_mod.Caption:=prefix+'No Val. Destino';
      result:=-1;
    end;

    free;
  end;
end;

procedure Tf_lectura.bt_search_coddelClick(Sender: TObject);
var c:char;
begin
  with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='d.cod_entidad,d.cod_delegacion,d.nombre,d.direccion,d.cp,d.poblacion,d.id_delegacion';
    titulos.commatext:='Entidad,Deleg,Nombre,Dirección,CP,Localidad,Id';
    from:='e_delegaciones d';
    where:='d.estado<''B''';
    orden[1]:=1;  orden[2]:=2;
    busca:=2;   distinct:=0;   fillimpio:=True;
    wide[1]:=35;   wide[2]:=35;   wide[3]:=135;   wide[4]:=135;   wide[5]:=35; //Anchuras de columnas

    showmodal;

    if resultado then begin
      with tpfibdataset.Create(dm) do begin
        ed_destino.Text:=valor[2];
        c:=chr(13);
        ed_destinoKeyPress(ed_destino,c);

        Free;
      end;
    end;
  end;
end;
{$ENDREGION}

{$REGION 'Incidencia'}
procedure Tf_lectura.bt_incidenciaClick(Sender: TObject);
begin
  f_incidencia.id_valija_tarjeta:=id_valija_tarjeta_act;
  f_incidencia.fecha:=fecha;
  f_incidencia.ean:=ean_act;
  f_incidencia.ShowModal;
end;

procedure Tf_lectura.bt_genera_incidencia(id_Valija_tarjeta,tipo_inc:Integer; ean,obs:string);
begin
  dm.t_write.StartTransaction;
  try
    dm.qr_update.Close;
    dm.qr_update.SQL.Clear;
    dm.qr_update.SQL.Add('insert into e_incidencias_estafeta (ID_VALIJA_TARJETA,FECHA,HORA,EAN,ID_TIPO_INCIDENCIA_EST,OBSERVACIONES,ID_CENTRO_LECTURA) '+
      'values (:ID_VALIJA_TARJETA,:FECHA,:HORA,:EAN,:ID_TIPO_INCIDENCIA_EST,:OBSERVACIONES,:ID_CENTRO_LECTURA)');
    dm.qr_update.ParamByName('ID_VALIJA_TARJETA').AsInteger:=id_Valija_tarjeta;
    dm.qr_update.ParamByName('fecha').Asdate:=fecha;
    dm.qr_update.ParamByName('hora').Astime:=Now;
    dm.qr_update.ParamByName('ean').asstring:=ean;
    dm.qr_update.ParamByName('ID_TIPO_INCIDENCIA_EST').asinteger:=tipo_inc;
    dm.qr_update.ParamByName('OBSERVACIONES').asstring:=obs;
    dm.qr_update.ParamByName('ID_CENTRO_LECTURA').asinteger:=u_globals.cent_lect;
    dm.qr_update.ExecQuery;

    dm.t_write.CommitRetaining;
  except
    dm.t_write.RollbackRetaining;
    sMessageDlg('Error Grabando Datos',mtError,[mbok],0);
  end;
end;
{$ENDREGION}

{$REGION 'Insert'}
procedure Tf_lectura.insert_sobre(id_Valija:Integer; traza:string='');
var  id_lectura:integer;
begin
  dm.t_write.StartTransaction;
  try
    with tpfibdataset.create(self) do begin
      database := dm.db;
      sqls.selectsql.clear;
      sqls.selectsql.add('select gen_id(gen_e_lecturas_estafeta_id,1) from rdb$database');
      open;

      id_lectura := fieldbyname('gen_id').asinteger;
      free;
    end;

    dm.qr_update.Close;
    dm.qr_update.SQL.Clear;
    dm.qr_update.SQL.Add('insert into e_lecturas_estafeta (ID_LECTURA_ESTAFETA,ID_VALIJA_TARJETA,FECHA,HORA,EAN,BULTOS,ID_DELEGACION_DESTINO,ID_VALIJA_DESTINO,ID_CENTRO_LECTURA,SELLO,LLENO,TRAZA,COD_CAIXA) '+
      'values (:ID_LECTURA_ESTAFETA,:ID_VALIJA_TARJETA,:FECHA,:HORA,:EAN,:BULTOS,:ID_DELEGACION_DESTINO,:ID_VALIJA_DESTINO,:ID_CENTRO_LECTURA,:SELLO,:LLENO,:TRAZA,:COD_CAIXA)');
    dm.qr_update.parambyname('id_lectura_estafeta').asinteger := id_lectura;
    dm.qr_update.ParamByName('ID_VALIJA_TARJETA').AsInteger:=id_valija_tarjeta_act;
    dm.qr_update.ParamByName('fecha').Asdate:=fecha;
    dm.qr_update.ParamByName('hora').Astime:=Now;
    dm.qr_update.ParamByName('ean').asstring:=ean_act;
    dm.qr_update.ParamByName('BULTOS').asinteger:=uds_act;
    dm.qr_update.ParamByName('ID_DELEGACION_DESTINO').asinteger:=id_delegacion_dest_act;
    if id_Valija<>-1 then dm.qr_update.ParamByName('ID_VALIJA_DESTINO').asinteger:=id_valija;
    dm.qr_update.ParamByName('ID_CENTRO_LECTURA').asinteger:=u_globals.cent_lect;
    dm.qr_update.ParamByName('SELLO').asinteger:=sello;
    dm.qr_update.ParamByName('LLENO').asinteger:=lleno_act;
    dm.qr_update.ParamByName('TRAZA').AsString:=traza;
    if not es_destino_caixa then
        dm.qr_update.ParamByName('COD_CAIXA').Clear
    else
        dm.qr_update.ParamByName('COD_CAIXA').AsString := ed_destino.Text;
    dm.qr_update.ExecQuery;

    ultima_lectura := id_lectura;

    lb_traza.Caption := traza;

    dm.t_write.CommitRetaining;
  except
    dm.t_write.RollbackRetaining;
    sMessageDlg('Error Grabando Datos',mtError,[mbok],0);
  end;
end;
{$ENDREGION}

{$REGION 'Aux'}
procedure Tf_lectura.play_sound(tipo:Integer);                                     //Reproduce sonido 0=OK 1=Error
begin
  if tipo=0 then sndPlaySound('Audio\OK.wav',SND_NODEFAULT Or SND_ASYNC)
    else sndPlaySound('Audio\Mal.wav',SND_NODEFAULT Or SND_ASYNC)
end;

function Tf_lectura.dc_ean13(i: int64): String;
var
  j: Integer;
begin
  Result:= Format('%12.12d',[i]);
  j:= 0;
  while i > 0 do
  begin
    inc(j,(i mod 10) * 3);
    i:= i div 10;
    inc(j,i mod 10);
    i:= i div 10;
  end;
  Result:= Result + IntToStr((10 - (j mod 10)) mod 10);
end;
{$ENDREGION}

{$REGION 'Imprimir'}
procedure Tf_lectura.sSpeedButton1Click(Sender: TObject);
var bc:tfrxbarcodeview;     code:string;
begin
  bc := fr_eti.FindObject('barcode') as tfrxbarcodeview;
  code:='60'+formatfloat('0000',cod_ent_org_act)+formatfloat('0000',cod_del_org_act)+'1';
  bc.Text:=dc_ean13(StrToInt64(code));
  fr_eti.PrintOptions.Printer:=u_globals.imp_eti;
  if fr_eti.PrepareReport(True) then fr_eti.ShowPreparedReport;
end;


procedure Tf_lectura.btPedirTrazaClick(Sender: TObject);
var
  traza: string;
begin
  if ultima_lectura<=0 then
  begin
    sShowMessage('Error traza', 'Última lectura desconocida.');
    Exit;
  end;

   if lb_traza.Caption<>'' then
  begin
     if sMessageDlg('La lectura ya tiene traza, ¿sobreescribir?',mtWarning, mbYesNo,mrNo)=mrNo then
          Exit;
  end;

 { if (pedir_traza) then
    traza:=InputBox('Traza','Traza','')
  else
    traza:=''; }

  traza := InputBox('Traza','Traza','');

    if traza='' then
  begin
     if sMessageDlg('Traza vacía, ¿desea continuar?',mtWarning, mbYesNo,mrNo)=mrNo then
          Exit;
  end;

  if (ultima_lectura>0) then
    update_lectura(ultima_lectura,traza)
  else
      sShowMessage('Error traza', 'Última lectura desconocida.');

  lb_traza.Caption := traza;
end;

{$ENDREGION}

{$REGION 'TCP Server'}
procedure Tf_lectura.b_connect_voiceClick(Sender: TObject);
begin
  m_tcp_messages.clear;
  ws_1.Port := '5532';
  ws_1.LocalAddr := '127.0.0.1';
  ws_1.Addr := '0.0.0.0';
  ws_1.listen;
  m_tcp_messages.Lines.Add('Esperando Conexiones....');
end;

procedure Tf_lectura.b_disconnectClick(Sender: TObject);
begin
  ws_1.DisconnectAll;
  ws_1.Close;
  m_tcp_messages.Lines.Add('Desconectado....');
end;

procedure Tf_lectura.ws_1ClientConnect(Sender: TObject; Client: TWSocketClient;
  Error: Word);
begin
  with client do begin
    m_tcp_messages.Lines.Add(FormatDateTime('hh:nn:ss',Now) + '  Cliente Conectado');
    m_tcp_messages.Lines.Add('    Remoto '+PeerAddr+':'+PeerPort);
    m_tcp_messages.Lines.Add('    Local '+GetXAddr+':'+GetXPort);
    LineMode := False;
    LineEdit := True;
    OnDataAvailable := dataAvailable;
  end;
end;

procedure Tf_lectura.dataAvailable(Sender : TObject; Error  : Word);
var s, response:string;
begin
  with Sender as TWSocketClient do begin
    s := ReceiveStr;
    m_tcp_messages.Lines.Add(FormatDateTime('hh:nn:ss',Now) + '  Message Received');
    if (s<>'') then begin
      m_tcp_messages.Lines.Add(s);
      response := processJSON(s);
      m_tcp_messages.Lines.Add('Response =');
      m_tcp_messages.Lines.Add(response);
      SendStr(response+ #13#10);
    end;
  end;
end;

procedure Tf_lectura.ws_1ClientDisconnect(Sender: TObject;
  Client: TWSocketClient; Error: Word);
begin
  m_tcp_messages.Lines.Add(FormatDateTime('hh:nn:ss',Now) + '  Cliente Descconectado');
  m_tcp_messages.Lines.Add('     Remoto '+Client.PeerAddr+':'+client.PeerPort);
end;

function Tf_lectura.processJSON(const s:string):string;
var JsonIn, JsonOut,obj, response : TJSONObject;   JsonA : TJSONValue; jar:TJSONArray;     serial, usuario, mensaje, operation, comando :string;
begin
  JsonIn := TJSONObject.ParseJSONValue(s) as TJSONObject;

  serial := JsonIn.Get('serial').JsonValue.ToString;
  serial := UpperCase(StringReplace(serial,'"','',[rfReplaceAll]));

  usuario := JsonIn.Get('usuario').JsonValue.ToString;
  usuario := UpperCase(StringReplace(usuario,'"','',[rfReplaceAll]));

  mensaje := JsonIn.Get('mensaje').JsonValue.ToString;
  mensaje := UpperCase(StringReplace(mensaje,'"','',[rfReplaceAll]));

  operation := JsonIn.Get('operacion').JsonValue.ToString;
  operation := UpperCase(StringReplace(operation,'"','',[rfReplaceAll]));

  comando := JsonIn.Get('comando').JsonValue.ToString;
  comando := uppercase(StringReplace(comando,'"','',[rfReplaceAll]));

  m_tcp_messages.Lines.Add('Operacion = ' + operation + ' Comando = ' + comando);

  case indexstr(operation, ['INICIO', 'PRECLASIFICACION']) of
    0 : begin
      response := TJSONObject.Create;
      response.addPair('mensaje','DELEGACION');
      jar := TJSONArray.Create;
      obj := TJSONObject.Create;
      obj.AddPair('tipo', 'numero');
      obj.AddPair('longitud', '4');
      obj.AddPair('prompt', 'delegacion');
      obj.AddPair('ayuda', 'lea la siguiente delegacion');
      jar.AddElement(obj);
      response.addpair('input',jar);
    end;
    1 : begin
      case indexstr(mensaje, ['DELEGACION', 'ENTIDAD']) of
        0: begin
          if comando = 'BORRAR' then begin
            if (ultima_lectura >= 0) then begin
              dm.t_write.StartTransaction;
              try
                dm.qr_update.Close;
                dm.qr_update.SQL.Clear;
                dm.qr_update.SQL.Add('delete from e_lecturas_estafeta where ID_LECTURA_ESTAFETA=:ID_LECTURA_ESTAFETA');
                dm.qr_update.parambyname('id_lectura_estafeta').asinteger := ultima_lectura;
                dm.qr_update.ExecQuery;

                ultima_lectura := -1;

                dm.t_write.CommitRetaining;
              except
                dm.t_write.RollbackRetaining;
                sMessageDlg('Error Borrando Datos',mtError,[mbok],0);
              end;
            end;

            response := TJSONObject.Create;
            response.addpair('mensaje','DELEGACION');
            jar := TJSONArray.Create;
            obj := TJSONObject.Create;
            obj.AddPair('tipo', 'numero');
            obj.AddPair('longitud', '4');
            obj.AddPair('prompt', 'delegacion');
            obj.AddPair('ayuda', 'lea la siguiente delegacion');
            jar.AddElement(obj);
            response.addPair('input',jar);
          end else begin
            cod_deleg_temp := StrToInt(comando);
            ed_destino.Text := RightStr(StringOfChar('0',4) + comando,4);
            response := destino_entered(True);
          end;
        end;
        1:begin
          if comando = 'CANCELAR' then begin
            cod_deleg_temp := -1;
            ed_destino.text :='';

            response := TJSONObject.Create;
            response.addpair('mensaje','DELEGACION');
            jar := TJSONArray.Create;
            obj := TJSONObject.Create;
            obj.AddPair('tipo', 'numero');
            obj.AddPair('longitud', '4');
            obj.AddPair('prompt', 'delegacion');
            obj.AddPair('ayuda', 'lea la siguiente delegacion');
            jar.AddElement(obj);
            response.addPair('input',jar);
          end else begin
            ed_destino.Text := RightStr(StringOfChar('0',4) + IntToStr(cod_deleg_temp),4);
            response := destino_entered(true, comando);
          end;
        end;
      end;
    end;
  end;

  response.AddPair('serial', serial);
  response.AddPair('usuario', usuario);
  response.AddPair('operacion', 'PreClasificacion');
  Result := response.ToString;
end;
{$ENDREGION}

function Tf_lectura.ExisteEAN(ean:string):Boolean;
begin
 with tpfibdataset.Create(dm) do begin                                     //Verifica EAN Leido previamente
          database:=dm.db;
          SQLs.SelectSQL.Clear;
          SQLs.SelectSQL.Add('select * from e_valijas_tarjetas t ' +
                             'inner join e_valijas v on v.id_valija=t.id_valija ' +
                             'inner join e_delegaciones d on d.id_delegacion=v.id_delegacion ' +
                             'where ean=:ean and ((t.estado=''A'') or (t.estado=''B'' and d.org_recurrente=1))');
          ParamByName('ean').AsString:=ean;
          Open;

          result := not(isempty);
          Free;
 end;
end;

function Tf_lectura.convierte_caixa_a_bankia(cod_caixa:string): string;
begin
    with tpfibdataset.Create(dm) do begin                                     //Verifica EAN Leido previamente
          database:=dm.db;
          SQLs.SelectSQL.Clear;
          SQLs.SelectSQL.Add('select cod_delegacion from e_delegaciones d ' +
                             'where cod_caixa=:cod and d.estado=''A''');
          ParamByName('cod').AsString:=cod_caixa;
          Open;

          if not IsEmpty then
               result := FieldByName('cod_delegacion').AsString
          else
               Result := '';
          Free;
 end;
end;

function Tf_lectura.existe_deleg_bankia(codigo:string): Boolean;
begin
    with tpfibdataset.Create(dm) do begin
          database:=dm.db;
          SQLs.SelectSQL.Clear;
          SQLs.SelectSQL.Add('select cod_delegacion from e_delegaciones d ' +
                             'where cod_delegacion=:cod and d.estado=''A'' and cod_delegacion<>:deleg_caixa');
          ParamByName('cod').AsString:=codigo;
          ParamByName('deleg_caixa').AsString:=deleg_caixa;
          Open;

          result := not IsEmpty;

          Free;
 end;
end;

function Tf_lectura.existe_deleg_caixa(codigo:string): Boolean;
begin
    with tpfibdataset.Create(dm) do begin
          database:=dm.db;
          SQLs.SelectSQL.Clear;
          SQLs.SelectSQL.Add('select cod_caixa from e_delegaciones d ' +
                             'where cod_caixa=:cod and d.estado=''A''');
          ParamByName('cod').AsString:=codigo;
          Open;

          result := not IsEmpty;

          Free;
 end;
end;

function Tf_lectura.convierte_caixa(ean:string): boolean;
begin
   if (ean<>'') then
   begin
    with tpfibdataset.Create(dm) do begin                                   //Busca la valija del EAN
      database:=dm.db;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select vt.id_valija_tarjeta,v.id_valija,v.id_modulo,d.cod_entidad,d.cod_delegacion,d.nombre,d.direccion,d.poblacion,d.cp,d.provincia,d.pedir_traza,d.enviar_aviso_traza, d.email_traza, d.email_subject_traza '+
        'from e_valijas_tarjetas vt '+
        'inner join e_valijas v on (vt.id_valija=v.id_valija) '+
        'inner join e_delegaciones d on (v.id_delegacion=d.id_delegacion) '+
        'where ((vt.ean=:ean) or (vt.ean_alt=:ean) or (vt.ean_old=:ean) or (vt.ean_old2=:ean)) and v.estado=''A'' and convierte_caixa=1 '+
        'order by vt.id_valija_tarjeta');
      ParamByName('ean').AsString:=ean;
      Open;

      Result := not IsEmpty;
      Free;
    end;
   end;
end;

procedure Tf_lectura.error_deleg_no_encontrada(var response: TJSONObject);
var
  jar: TJSONArray;
  obj: TJSONObject;
begin
  id_delegacion_dest_act := -1;
  uds_act := -1;
  lb_dst_coddel.caption := 'Not Found';
  lb_dst.caption := 'Código Incorrecto';
  lb_dst_nombre.Caption := '';
  lb_dst_direccion.Caption := '';
  lb_dst_poblacion.Caption := '';
  play_sound(1);
  ed_destino.SetFocus;
  response := TJSONObject.Create;
  response.addpair('mensaje', 'DELEGACION');
  jar := TJSONArray.Create;
  obj := TJSONObject.Create;
  obj.AddPair('tipo', 'numero');
  obj.AddPair('longitud', '4');
  obj.AddPair('prompt', 'delegacion incorrecta');
  obj.AddPair('ayuda', 'lea la siguiente delegacion');
  jar.AddElement(obj);
  response.addPair('input', jar);
end;

procedure Tf_lectura.update_lectura(id_lectura_estafeta: Integer; traza:string);
begin
        dm.t_write.StartTransaction;
    try
      dm.qr_update.Close;
      dm.qr_update.SQL.Clear;
      dm.qr_update.SQL.Add('update e_lecturas_estafeta set traza=:traza where ID_LECTURA_ESTAFETA=:ID_LECTURA_ESTAFETA');
      dm.qr_update.parambyname('id_lectura_estafeta').asinteger := id_lectura_estafeta;
      dm.qr_update.parambyname('traza').AsString := traza;

      dm.qr_update.ExecQuery;

      dm.t_write.CommitRetaining;
    except
      dm.t_write.RollbackRetaining;
      sMessageDlg('Error guardando traza. ',mtError,[mbok],0);
    end;
end;

end.
