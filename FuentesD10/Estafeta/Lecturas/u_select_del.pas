unit u_select_del;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, sBitBtn,
  sLabel, Data.DB, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid;

type
  Tf_select_del = class(TForm)
    lb_1: TsLabel;
    bt_ok: TsBitBtn;
    bt_cancel: TsBitBtn;
    ng_del: TJvDBGrid;
    procedure FormShow(Sender: TObject);
    procedure bt_cancelClick(Sender: TObject);
    procedure bt_okClick(Sender: TObject);
    procedure ng_delDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    cod_entidad,id_delegacion:integer;
    nombre,direccion,poblacion,cp,provincia:string;
    pedir_sobres:Boolean;
  end;

var
  f_select_del: Tf_select_del;

implementation

uses
  u_dm;

{$R *.dfm}

procedure Tf_select_del.bt_cancelClick(Sender: TObject);
begin
  id_delegacion:=-1;
  cod_entidad:=-1;
  nombre:='';
  direccion:='';
  poblacion:='';
  cp:='';
  provincia:='';
  pedir_Sobres:=false;
  close;
end;

procedure Tf_select_del.bt_okClick(Sender: TObject);
begin
  if dm.q_delegs.FieldByName('id_delegacion').AsInteger>=0 then begin
    id_delegacion := dm.q_delegs.FieldByName('id_delegacion').AsInteger;
    cod_entidad   := dm.q_delegs.FieldByName('cod_entidad').AsInteger;
    nombre        := dm.q_delegs.FieldByName('nombre').AsString;
    direccion     := dm.q_delegs.FieldByName('direccion').AsString;
    poblacion     := dm.q_delegs.FieldByName('poblacion').AsString;
    cp            := dm.q_delegs.FieldByName('cp').AsString;
    provincia     := dm.q_delegs.FieldByName('provincia').AsString;
    pedir_sobres  := (dm.q_delegs.FieldByName('pedir_sobres').AsInteger=1);
  end else begin
    id_delegacion:=-1;
    cod_entidad:=-1;
    nombre:='';
    direccion:='';
    poblacion:='';
    cp:='';
    provincia:='';
    pedir_Sobres:=false;
  end;
  close;
end;

procedure Tf_select_del.FormShow(Sender: TObject);
begin
  id_delegacion:=-1;
  cod_entidad:=-1;
  nombre:='';
  direccion:='';
  poblacion:='';
  cp:='';
  provincia:='';
  pedir_Sobres:=false;
end;

procedure Tf_select_del.ng_delDblClick(Sender: TObject);
begin
  bt_okClick(Self);
end;

end.
