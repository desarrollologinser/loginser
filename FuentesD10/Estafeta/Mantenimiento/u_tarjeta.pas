unit u_tarjeta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sComboBox, sEdit,
  Vcl.Buttons, sBitBtn, sGroupBox,System.StrUtils,pFIBDataSet;

type
  Tf_tarjeta = class(TForm)
    sGroupBox4: TsGroupBox;
    bt_guardar: TsBitBtn;
    ed_id_tjta: TsEdit;
    ed_ean: TsEdit;
    ed_rfid: TsEdit;
    ed_ntjta: TsEdit;
    cb_estado: TsComboBox;
    ed_ntjta_alt: TsEdit;
    ed_ean_alt: TsEdit;
    ed_ean_old1: TsEdit;
    ed_ean_old2: TsEdit;
    procedure FormShow(Sender: TObject);
    procedure bt_guardarClick(Sender: TObject);
    procedure save_exp;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_tarjeta: Tf_tarjeta;
    mode:integer;              //0 = modo edicion    1 = modo nueva

implementation

uses
  u_dm;

{$R *.dfm}

{$REGION 'Ini-Close'}
procedure Tf_tarjeta.FormShow(Sender: TObject);
begin
  if mode=0 then begin                                         //modo edicion
    ed_id_tjta.Text:=dm.q_valijas_tarjetas.fieldbyname('id_valija_tarjeta').asstring;
    ed_ean.Text:=dm.q_valijas_tarjetas.fieldbyname('ean').asstring;
    ed_rfid.Text:=dm.q_valijas_tarjetas.fieldbyname('rfid').asstring;
    ed_ntjta.Text:=dm.q_valijas_tarjetas.fieldbyname('n_tarjeta').asstring;
    ed_ean_alt.Text:=dm.q_valijas_tarjetas.fieldbyname('ean_alt').asstring;
    ed_ntjta_alt.Text:=dm.q_valijas_tarjetas.fieldbyname('n_tarjeta_alt').asstring;
    ed_ean_old1.Text:=dm.q_valijas_tarjetas.fieldbyname('ean_old').asstring;
    ed_ean_old2.Text:=dm.q_valijas_tarjetas.fieldbyname('ean_old2').asstring;
    case indexstr(dm.q_valijas_tarjetas.fieldbyname('estado').asstring,['A','B']) of
      0:cb_estado.ItemIndex:=0;
      1:cb_estado.ItemIndex:=1;
    end;
  end;

  if mode=1 then begin                                         //modo nuevo
    ed_id_tjta.Text:='';
    ed_ean.Text:='';
    ed_rfid.Text:='';
    ed_ntjta.Text:='';
    ed_ean_alt.Text:='';
    ed_ntjta_alt.Text:='';
    ed_ean_old1.Text:='';
    ed_ean_old2.Text:='';
    cb_estado.ItemIndex:=0;
  end;
end;

procedure Tf_tarjeta.bt_guardarClick(Sender: TObject);
begin
  save_exp;
  close;
end;
{$ENDREGION}

procedure Tf_tarjeta.save_exp;
var id_tjta:integer;
begin
  if Length(ed_ean.Text)>16 then raise exception.create('EAN Inválido');
  if Length(ed_ean_alt.Text)>16 then raise exception.create('EAN Alt Inválido');
  if Length(ed_ean_old1.Text)>16 then raise exception.create('EAN Viejo Inválido');
  if Length(ed_ean_old2.Text)>16 then raise exception.create('EAN Viejo 2 Inválido');
  if Length(ed_rfid.Text)>16 then raise exception.create('RFID Inválido');

  if mode=0 then begin                                  //modo edicion
    id_tjta:=StrToInt(ed_id_tjta.Text);

    dm.t_write.StartTransaction;
    try
      dm.qr_update.Close;
      dm.qr_update.sql.Clear;
      dm.qr_update.sql.Add('update e_valijas_tarjetas set ean=:ean,rfid=:rfid,n_tarjeta=:n_tarjeta,estado=:estado,ean_alt=:ean_alt,n_tarjeta_alt=:n_tarjeta_alt, '+
        'ean_old=:ean_old,ean_old2=:ean_old2 where id_valija_tarjeta=:id_valija_tarjeta');
      dm.qr_update.ParamByName('id_valija_tarjeta').AsInteger:=id_tjta;
      dm.qr_update.ParamByName('ean').asstring:=ed_ean.Text;
      if ed_rfid.Text='' then dm.qr_update.ParamByName('rfid').clear
      else dm.qr_update.ParamByName('rfid').asstring:=ed_rfid.Text;
      dm.qr_update.ParamByName('n_tarjeta').asinteger:=strtoint(ed_ntjta.Text);
      dm.qr_update.ParamByName('n_tarjeta_alt').asinteger:=strtoint(ed_ntjta_alt.Text);
      dm.qr_update.ParamByName('ean_alt').asstring:=ed_ean_alt.Text;
      dm.qr_update.ParamByName('ean_old').asstring:=ed_ean_old1.Text;
      dm.qr_update.ParamByName('ean_old2').asstring:=ed_ean_old2.Text;
      dm.qr_update.ParamByName('estado').AsString:=cb_estado.Text[1];
      dm.qr_update.ExecQuery;

      dm.t_write.Commitretaining;
    except
      dm.t_write.rollbackretaining;
    end;
  end;

  if (mode=1) then begin                                  //modo new

  end;
end;


end.
