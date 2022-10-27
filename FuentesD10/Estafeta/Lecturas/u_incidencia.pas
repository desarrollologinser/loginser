unit u_incidencia;

interface

uses
  Winapi.Windows, System.SysUtils, System.Variants, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sLabel,
  sSpeedButton, sBitBtn, sEdit, sGroupBox, sdialogs,pFIBDataSet, Vcl.Buttons;

type
  Tf_incidencia = class(TForm)
    bt_genera_incidencia: TsBitBtn;
    sGroupBox1: TsGroupBox;
    bt__as_incid: TsSpeedButton;
    lb_incid: TsLabel;
    ed_obs: TsEdit;
    bt_cancel: TsBitBtn;
    bt_search_nombre: TsSpeedButton;
    procedure bt__as_incidClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bt_genera_incidenciaClick(Sender: TObject);
    procedure bt_cancelClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure bt_search_nombreClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id_valija_tarjeta:integer;
    fecha:TDate;
    ean:string;
  end;

var
  f_incidencia: Tf_incidencia;
  id_incidencia:integer;

implementation

uses
  ubuscapro, u_dm, u_globals;

{$R *.dfm}

procedure Tf_incidencia.bt_cancelClick(Sender: TObject);
begin
  close;
end;

procedure Tf_incidencia.bt__as_incidClick(Sender: TObject);
begin
  with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='id_tipo_incidencia_est,nombre,observaciones';
    titulos.commatext:='Id,Nombre,Observaciones';
    from:='e_tipos_incidencias_est';
    where:='estado<''B''';
    orden[1]:=1;  busca:=1;   distinct:=0;   fillimpio:=True;

    showmodal;

    if resultado then begin
      id_incidencia:=valor[1];
      lb_incid.Caption:=string(valor[1])+' - '+string(valor[2]);
      ed_obs.Text:=valor[3];
    end;
  end;
end;

procedure Tf_incidencia.bt_genera_incidenciaClick(Sender: TObject);
begin
  dm.t_write.StartTransaction;
  try
    dm.qr_update.Close;
    dm.qr_update.SQL.Clear;
    dm.qr_update.SQL.Add('insert into e_incidencias_estafeta (ID_VALIJA_TARJETA,FECHA,HORA,EAN,ID_TIPO_INCIDENCIA_EST,OBSERVACIONES,ID_CENTRO_LECTURA) '+
      'values (:ID_VALIJA_TARJETA,:FECHA,:HORA,:EAN,:ID_TIPO_INCIDENCIA_EST,:OBSERVACIONES,:ID_CENTRO_LECTURA)');
    dm.qr_update.ParamByName('ID_VALIJA_TARJETA').AsInteger:=id_valija_tarjeta;
    dm.qr_update.ParamByName('fecha').Asdate:=fecha;
    dm.qr_update.ParamByName('hora').Astime:=Now;
    dm.qr_update.ParamByName('ean').asstring:=ean;
    dm.qr_update.ParamByName('ID_TIPO_INCIDENCIA_EST').asinteger:=id_incidencia;
    dm.qr_update.ParamByName('OBSERVACIONES').asstring:=ed_obs.text;
    dm.qr_update.ParamByName('ID_CENTRO_LECTURA').asinteger:=u_globals.cent_lect;;
    dm.qr_update.ExecQuery;

    dm.t_write.CommitRetaining;
  except
    dm.t_write.RollbackRetaining;
    sMessageDlg('Error Grabando Datos',mtError,[mbok],0);
  end;

  Close;
end;

procedure Tf_incidencia.bt_search_nombreClick(Sender: TObject);
begin
  with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='d.cod_entidad,d.cod_delegacion,d.nombre,d.direccion,d.cp,d.poblacion,d.id_delegacion';
    titulos.commatext:='Entidad,Deleg,Nombre,Dirección,CP,Localidad,Id';
    from:='e_delegaciones d ';
    where:='d.estado<''B'' ';
    orden[1]:=1;  orden[2]:=2;
    busca:=2;   distinct:=0;   fillimpio:=True;
    wide[1]:=35;   wide[2]:=35;   wide[3]:=135;   wide[4]:=135;   wide[5]:=35; //Anchuras de columnas

    showmodal;

    if resultado then begin
      ed_obs.Text:=ed_obs.Text+' '+string(valor[1])+'-'+string(valor[2])+'-'+string(valor[3]);
    end;
  end;
end;

procedure Tf_incidencia.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_F4 then bt__as_incidClick(self);
  if Key=VK_ESCAPE then bt_cancelClick(self);
  if Key=VK_F1 then bt_genera_incidenciaClick(self);
  if Key=VK_F2 then bt_search_nombreClick(self);
end;

procedure Tf_incidencia.FormShow(Sender: TObject);
begin
  with tpfibdataset.Create(dm) do begin                                   //Busca la valija
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select nombre from e_TIPOS_INCIDENCIAS_EST where id_tipo_incidencia_est=:id_tipo');
    ParamByName('id_tipo').AsInteger:=1;
    Open;

    lb_incid.caption:=fieldbyname('nombre').AsString;

    Free;
  end;
  id_incidencia:=1;
  ed_obs.Text:='';
  ed_obs.SetFocus;
end;

end.
