unit u_destino;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, sSpeedButton, Vcl.StdCtrls, sEdit, pfibdataset,
  sdialogs, Vcl.ExtCtrls, sBevel, sLabel;

type
  Tf_destino = class(TForm)
    ed_destino: TsEdit;
    bt_cancel: TsSpeedButton;
    lb_st: TsLabel;
    bv_1: TsBevel;
    procedure ed_destinoKeyPress(Sender: TObject; var Key: Char);
    procedure lectura_destino(coddel:integer);
    procedure FormShow(Sender: TObject);
    procedure bt_cancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_destino: Tf_destino;

implementation

uses
  u_dm, u_main;

{$R *.dfm}

procedure Tf_destino.FormShow(Sender: TObject);
begin
  ed_destino.text:='';
  ed_destino.SetFocus;
end;

procedure Tf_destino.bt_cancelClick(Sender: TObject);
begin
  close;
end;

procedure Tf_destino.ed_destinoKeyPress(Sender: TObject; var Key: Char);
begin
  if length(ed_destino.Text)=4 then begin
    lectura_destino(StrToInt(ed_destino.text));
  end;
end;

procedure Tf_destino.lectura_destino(coddel:integer);                               //Es una lectura de un sobre de destino
var  codcli:integer;     s:string;
begin
 { with tpfibdataset.Create(dm) do begin                                   //Busca la valija del EAN
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select c.id_cliente,c.nombre as cliente,d.id_delegacion,d.cod_delegacion,d.nombre,d.direccion,d.poblacion,d.cp,d.provincia '+
      'from g_delegaciones d '+
      'inner join g_clientes c on (d.id_cliente=c.id_cliente) '+
      'where d.id_cliente between 200 and 299 and d.cod_delegacion=:coddel and d.estado=''A'' ');
    ParamByName('coddel').Asinteger:=coddel;
    Open;

    if not(isempty) then begin
      f_main.lb_dst_cliente.caption:=FieldByName('cliente').asstring;
      f_main.lb_coddel_dst.Caption:=IntToStr(codcli)+' '+inttostr(coddel);
      u_main.id_delegacion_dest_act:=FieldByName('id_delegacion').asinteger;
      f_main.lb_dst_nombre.caption:=FieldByName('nombre').asstring;
      f_main.lb_dst_direccion.Caption:=FieldByName('direccion').asstring;
      f_main.lb_dst_localidad.Caption:=FieldByName('poblacion').asstring+' - '+FieldByName('cp').asstring;
      u_main.uds_Act:=1;
      f_main.insert_sobre;
      f_main.refresh_data;
      ed_destino.Text:='';
      ed_destino.SetFocus;
    end else begin
      lb_st.caption:='EAN Delegación No Encontrado';
      f_main.lb_coddel_dst.Caption:='';
      f_main.lb_dst_cliente.caption:='';
      u_main.id_delegacion_dest_act:=-1;
      f_main.lb_dst_nombre.caption:='Not Found';
      f_main.lb_dst_direccion.Caption:='';
      f_main.lb_dst_localidad.Caption:='';
      u_main.uds_act:=-1;
      ed_destino.SetFocus;
    end;
    Free;
  end;        }
end;

end.
