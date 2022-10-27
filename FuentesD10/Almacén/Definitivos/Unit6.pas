unit Unit6;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, NxScrollControl, NxCustomGridControl, dm,
  NxCustomGrid, NxGrid, NxColumns, NxColumnClasses, Vcl.StdCtrls;

type
  TForm6 = class(TForm)
    grid: TNextGrid;
    nxtxtclmn2: TNxTextColumn;
    nxtxtclmn3: TNxTextColumn;
    nxtxtclmn4: TNxTextColumn;
    nxtxtclmn5: TNxTextColumn;
    nxtxtclmn6: TNxTextColumn;
    nxtxtclmn7: TNxTextColumn;
    nxtxtclmn9: TNxTextColumn;
    nxtxtclmn11: TNxTextColumn;
    nxnmbrclmn1: TNxNumberColumn;
    nxdtclmn1: TNxDateColumn;
    nxdtclmn2: TNxDateColumn;
    nxdtclmn3: TNxDateColumn;
    lbl1: TLabel;
    cbb1: TComboBox;
    lbl2: TLabel;
    btn1: TButton;
    procedure FormActivate(Sender: TObject);
    procedure cbb1Change(Sender: TObject);
    procedure CambiaVista(cadenaSql:string);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

{$R *.dfm}
procedure TForm6.btn1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm6.CambiaVista(cadenaSql:string);
function cadena(i:Integer):string;
begin
  Result:='';
  if i=1 then Result:='SI';
end;
function iff(valor: Integer):string;
begin
  Result:=' soluciones.';
  if valor=1 then Result:=' solución.';
end;

begin
  Screen.Cursor:=crHourGlass;
  dm1.db.Close;
  dm1.db.Connected := True;
  dm1.read.Active:=True;
  with dm1.qry do
  begin
    sql.Clear;
    SQL.Add(cadenaSql);
    ExecQuery;
  end;
  grid.ClearRows;
  while not dm1.qry.Eof do
  begin
    with grid do
    begin
      AddRow();
      Cell[0,RowCount-1].AsInteger:=dm1.qry.FieldByName('ID_SOLICITUD_WEB').AsInteger;
      Cell[1,RowCount-1].AsString:=dm1.qry.FieldByName('TIPO_CAJA').AsString;
      Cell[2,RowCount-1].AsString:=dm1.qry.FieldByName('CAJA').AsString;
      Cell[3,RowCount-1].AsString:=dm1.qry.FieldByName('LOTE').AsString;
      Cell[4,RowCount-1].AsString:=dm1.qry.FieldByName('CARPETA').AsString;
      Cell[5,RowCount-1].AsString:=dm1.qry.FieldByName('PAGINA').AsString;
      Cell[6,RowCount-1].AsString:=dm1.qry.FieldByName('SOLICITANTE').AsString;
      Cell[7,RowCount-1].AsDateTime:=dm1.qry.FieldByName('FECHA_SOLICITUD').AsDate;
      Cell[8,RowCount-1].AsString:=cadena(dm1.qry.FieldByName('ENTREGADO').AsInteger);
      Cell[9,RowCount-1].AsDateTime:=dm1.qry.FieldByName('FECHA_ENTREGA').AsDate;
      Cell[10,RowCount-1].AsString:=cadena(dm1.qry.FieldByName('DEVUELTO').AsInteger);
      Cell[11,RowCount-1].AsDateTime:=dm1.qry.FieldByName('FECHA_DEVOLUCION').AsDate;
    end;
    dm1.qry.Next;
  end;
  lbl2.Caption:=IntToStr(dm1.qry.RecordCount)+ iff(dm1.qry.RecordCount);
  dm1.read.Active:=False;
  dm1.qry.Close;
  dm1.db.Close;
  cbb1.Text:='Todos';
  Screen.Cursor:=crDefault;
end;
procedure TForm6.cbb1Change(Sender: TObject);
var cadenaSql: string;
  i: Integer;
begin
  i:=cbb1.ItemIndex;
  cadenaSql:='Select * from A_Cajas_Solicitudes order by fecha_solicitud desc';
  case i of
    0: cadenaSql:='Select * from A_Cajas_Solicitudes order by fecha_solicitud desc';
    1: cadenaSql:='Select * from A_Cajas_Solicitudes where entregado=1 order by fecha_solicitud desc';
    2: cadenaSql:='Select * from A_Cajas_Solicitudes where devuelto=1 order by fecha_solicitud desc';
    3: cadenaSql:='Select * from A_Cajas_Solicitudes where entregado=0 or entregado is null order by fecha_solicitud desc';
    4: cadenaSql:='Select * from A_Cajas_Solicitudes where devuelto=0 or devuelto is null order by fecha_solicitud desc';
  end;
  CambiaVista(cadenaSql);
end;

procedure TForm6.FormActivate(Sender: TObject);
var cadenaSql: string;
begin
  cadenaSql:='Select * from A_Cajas_Solicitudes order by fecha_solicitud desc';
  CambiaVista(cadenaSql);
end;

end.
