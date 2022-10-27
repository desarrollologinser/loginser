unit u_recall;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sLabel, sGroupBox, sEdit,pFIBDataSet,strutils,
  sdialogs, Vcl.Buttons, sSpeedButton;

type
  Tf_recall = class(TForm)
    ed_ean: TsEdit;
    gb_2: TsGroupBox;
    gb_1: TsGroupBox;
    lb_org_nombre: TsLabel;
    lb_org_direccion: TsLabel;
    lb_org_poblacion: TsLabel;
    lb_org_coddel: TsLabel;
    lb_org: TsLabel;
    gb_3: TsGroupBox;
    lb_dst: TsLabel;
    gb_11: TsGroupBox;
    lb_dst_nombre: TsLabel;
    lb_dst_direccion: TsLabel;
    lb_dst_poblacion: TsLabel;
    lb_coddel_dst: TsLabel;
    lb_dst_coddel: TsLabel;
    lb_mod: TsLabel;
    bt_lleno: TsSpeedButton;
    lb_lleno: TsLabel;
    procedure ed_eanKeyPress(Sender: TObject; var Key: Char);
    procedure lectura(ean:string);
    procedure FormShow(Sender: TObject);
    procedure insert_sobre(id_Valija:Integer);
    function get_valija(id_valija:Integer; var redir:boolean):integer;
    procedure bt_llenoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_recall: Tf_recall;
  id_valija_tarjeta_act,id_delegacion_dest_act,cod_del_org_act,uds_act,sello:integer;
  lleno_act:integer;      //0=vacio 1=lleno
  ean_act:string;
  fecha:tdate;

implementation

uses u_dm, u_lleno, u_globals, u_lectura;

{$R *.dfm}

procedure Tf_recall.FormShow(Sender: TObject);
begin
  ed_ean.Text:='';
  lb_org.Caption:='';
  lb_dst.Caption:='';
  lb_org_coddel.caption:='';
  lb_org.caption:='';
  lb_org_nombre.Caption:='';
  lb_org_direccion.Caption:='';
  lb_org_poblacion.Caption:='';
  lb_dst_coddel.caption:='';
  lb_dst_nombre.Caption:='';
  lb_dst_direccion.Caption:='';
  lb_dst_poblacion.Caption:='';
  lb_mod.Caption:='';
  lb_lleno.Caption:='LLENO';
  lleno_act:=1;
  ed_ean.SetFocus;
  uds_act:=1;
end;

procedure Tf_recall.bt_llenoClick(Sender: TObject);
begin
  if lleno_act=0 then begin
    lleno_act:=1;
    lb_lleno.Caption:='LLENO';
  end else begin
    lleno_act:=0;
    lb_lleno.Caption:='VACIO';
  end;
end;

procedure Tf_recall.ed_eanKeyPress(Sender: TObject; var Key: Char);
var  ean:string;
begin
  if Key=chr(13) then begin
    ean:=ed_ean.Text;
    if Length(ean)=13 then ean:=Copy(ean,2,12);
    if ((length(ean)=12) and ((Copy(ean,1,2)='00') or (Copy(ean,1,2)='01'))) then begin
      lectura(ean);
    end else begin
      lb_org_coddel.caption:='Not Found';
      lb_org.caption:='EAN Incorrecto';
      lb_org_nombre.Caption:='';
      lb_org_direccion.Caption:='';
      lb_org_poblacion.Caption:='';

      f_lectura.play_sound(1);
      ed_ean.SetFocus;
    end;
    ed_ean.Text:='';
  end;
end;

procedure Tf_recall.lectura(ean:string);                                //Es una lectura
var cod,cod_entidad,cod_deleg,n_sobre,id_valija:Integer;      redir:Boolean;
begin
  cod:=StrToInt(Copy(ean,1,2));
  cod_entidad:=StrToInt(Copy(ean,3,4));
  cod_deleg:=StrToInt(Copy(ean,7,4));
  n_sobre:=StrToInt(Copy(ean,11,1));

  if ( ((cod=1) and (lleno_act=1)) or ((cod=0) and (lleno_act=0)) ) then begin                  //de recall a oficina  (01 y lleno) o (00 y vacio)
    with tpfibdataset.Create(dm) do begin                                   //Busca la tarjeta de Recall
      database:=dm.db;
      Close;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select vt.id_valija_tarjeta,v.id_valija,v.id_modulo,d.cod_entidad,d.cod_delegacion,d.nombre,d.direccion,d.poblacion,d.cp,d.provincia '+
        'from e_valijas_tarjetas vt '+
        'inner join e_valijas v on (vt.id_valija=v.id_valija) '+
        'inner join e_delegaciones d on (v.id_delegacion=d.id_delegacion) '+
        'where d.cod_entidad=9999 and d.cod_delegacion=7 and v.estado=''A'' '+
        'order by vt.id_valija_tarjeta');
      Open;

      sello:=1;
      id_valija_tarjeta_act:=fieldbyname('id_valija_tarjeta').AsInteger;
      ean_act:=ean;
      cod_del_org_act:=FieldByName('cod_delegacion').AsInteger;

      lb_org_coddel.caption:=rightstr('0000'+FieldByName('cod_entidad').AsString,4)+'-'+rightstr('0000'+FieldByName('cod_delegacion').AsString,4);
      lb_org.caption:=rightstr('0000'+FieldByName('cod_entidad').AsString,4)+'-'+rightstr('0000'+FieldByName('cod_delegacion').AsString,4)+' M-'+fieldbyname('id_modulo').asstring;
      lb_org_nombre.Caption:=FieldByName('nombre').AsString;
      lb_org_direccion.Caption:=FieldByName('direccion').AsString;
      lb_org_poblacion.Caption:=FieldByName('poblacion').AsString+' - '+FieldByName('cp').AsString+' - '+FieldByName('provincia').AsString;

      close;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select v.id_valija,v.id_modulo,d.id_delegacion,d.cod_entidad,d.cod_delegacion,d.nombre,d.direccion,d.poblacion,d.cp,d.provincia '+
        'from e_valijas v '+
        'inner join e_delegaciones d on (v.id_delegacion=d.id_delegacion) '+
        'where  v.estado=''A'' '+
        ' and d.cod_entidad=:cod_entidad and d.cod_delegacion=:cod_deleg');
      ParamByName('cod_entidad').asinteger:=cod_entidad;
      ParamByName('cod_deleg').asinteger:=cod_deleg;
      Open;

      id_delegacion_dest_act:=FieldByName('id_delegacion').asinteger;
      lb_dst_coddel.caption:=rightstr('0000'+FieldByName('cod_entidad').AsString,4)+'-'+rightstr('0000'+FieldByName('cod_delegacion').AsString,4);
      lb_dst.caption:=rightstr('0000'+FieldByName('cod_entidad').AsString,4)+'-'+rightstr('0000'+FieldByName('cod_delegacion').AsString,4);
      lb_dst_nombre.Caption:=FieldByName('nombre').AsString;
      lb_dst_direccion.Caption:=FieldByName('direccion').AsString;
      lb_dst_poblacion.Caption:=FieldByName('poblacion').AsString+' - '+FieldByName('cp').AsString+' - '+FieldByName('provincia').AsString;

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
        id_Valija:=get_valija(FieldByName('id_valija').asinteger,redir);
      end else begin                            //destino no tiene valija
        lb_mod.Caption:='Sin Valija';
        id_valija:=-1;
      end;

     { f_lleno.ShowModal;
      lleno_act:=f_lleno.lleno;}

      insert_sobre(id_valija);

      ed_ean.SetFocus;

      Free;
    end;
  end;

  if ( ((cod=0) and (lleno_act=1)) or ((cod=1) and (lleno_act=0)) ) then begin                        //de oficina a recall  (00 y lleno) o (01 y vacio)
    with tpfibdataset.Create(dm) do begin                                   //Busca la tarjeta de Recall
      database:=dm.db;
      Close;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select vt.id_valija_tarjeta,v.id_valija,v.id_modulo,d.id_delegacion,d.cod_entidad,d.cod_delegacion,d.nombre,d.direccion,d.poblacion,d.cp,d.provincia '+
        'from e_valijas_tarjetas vt '+
        'inner join e_valijas v on (vt.id_valija=v.id_valija) '+
        'inner join e_delegaciones d on (v.id_delegacion=d.id_delegacion) '+
        'where  v.estado=''A'' '+
        ' and d.cod_entidad=:cod_entidad and d.cod_delegacion=:cod_deleg '+
        'order by vt.id_valija_tarjeta');
      ParamByName('cod_entidad').asinteger:=cod_entidad;
      ParamByName('cod_deleg').asinteger:=cod_deleg;
      Open;

      sello:=1;
      id_valija_tarjeta_act:=fieldbyname('id_valija_tarjeta').AsInteger;
      ean_act:=ean;
      cod_del_org_act:=FieldByName('cod_delegacion').AsInteger;

      lb_org_coddel.caption:=rightstr('0000'+FieldByName('cod_entidad').AsString,4)+'-'+rightstr('0000'+FieldByName('cod_delegacion').AsString,4);
      lb_org.caption:=rightstr('0000'+FieldByName('cod_entidad').AsString,4)+'-'+rightstr('0000'+FieldByName('cod_delegacion').AsString,4)+' M-'+fieldbyname('id_modulo').asstring;
      lb_org_nombre.Caption:=FieldByName('nombre').AsString;
      lb_org_direccion.Caption:=FieldByName('direccion').AsString;
      lb_org_poblacion.Caption:=FieldByName('poblacion').AsString+' - '+FieldByName('cp').AsString+' - '+FieldByName('provincia').AsString;

      close;
      SQLs.SelectSQL.Clear;
      SQLs.SelectSQL.Add('select v.id_valija,v.id_modulo,d.id_delegacion,d.cod_entidad,d.cod_delegacion,d.nombre,d.direccion,d.poblacion,d.cp,d.provincia '+
        'from e_valijas v '+
        'inner join e_delegaciones d on (v.id_delegacion=d.id_delegacion) '+
        'where d.cod_entidad=9999 and d.cod_delegacion=7 and v.estado=''A''');
      Open;

      id_delegacion_dest_act:=FieldByName('id_delegacion').asinteger;
      lb_dst_coddel.caption:=rightstr('0000'+FieldByName('cod_entidad').AsString,4)+'-'+rightstr('0000'+FieldByName('cod_delegacion').AsString,4);
      lb_dst.caption:=rightstr('0000'+FieldByName('cod_entidad').AsString,4)+'-'+rightstr('0000'+FieldByName('cod_delegacion').AsString,4);
      lb_dst_nombre.Caption:=FieldByName('nombre').AsString;
      lb_dst_direccion.Caption:=FieldByName('direccion').AsString;
      lb_dst_poblacion.Caption:=FieldByName('poblacion').AsString+' - '+FieldByName('cp').AsString+' - '+FieldByName('provincia').AsString;

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
        id_Valija:=get_valija(FieldByName('id_valija').asinteger,redir);
      end else begin                            //destino no tiene valija
        lb_mod.Caption:='Sin Valija';
        id_valija:=-1;
      end;

     { f_lleno.ShowModal;
      lleno_act:=f_lleno.lleno;}

      insert_sobre(id_valija);

      ed_ean.SetFocus;

      Free;
    end;
  end;
end;

function Tf_recall.get_valija(id_valija:Integer; var redir:boolean):integer;
var dest_especial,id_valija_res,id_valija_redir:integer;     prefix:string;
begin
  id_valija_redir:=-1;
  if redir then prefix:='REDIR-'
  else prefix:='';

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

    if not(IsEmpty) then begin
      id_valija_redir:=FieldByName('id_valija_redir').AsInteger;
      if id_valija_redir>0 then begin                                     //destino redirigido
        redir:=true;
        id_valija_res:=get_valija(id_Valija_redir,redir);
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

procedure Tf_recall.insert_sobre(id_Valija:Integer);
begin
  dm.t_write.StartTransaction;
  try
    dm.qr_update.Close;
    dm.qr_update.SQL.Clear;
    dm.qr_update.SQL.Add('insert into e_lecturas_estafeta (ID_VALIJA_TARJETA,FECHA,HORA,EAN,BULTOS,ID_DELEGACION_DESTINO,ID_VALIJA_DESTINO,ID_CENTRO_LECTURA,SELLO,LLENO,DIGITALIZACION) '+
      'values (:ID_VALIJA_TARJETA,:FECHA,:HORA,:EAN,:BULTOS,:ID_DELEGACION_DESTINO,:ID_VALIJA_DESTINO,:ID_CENTRO_LECTURA,:SELLO,:LLENO,:DIGITALIZACION)');
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
    dm.qr_update.ParamByName('DIGITALIZACION').asinteger:=1;
    dm.qr_update.ExecQuery;

    dm.t_write.CommitRetaining;
  except
    dm.t_write.RollbackRetaining;
    sMessageDlg('Error Grabando Datos',mtError,[mbok],0);
  end;
end;

end.
