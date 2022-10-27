unit u_labels;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, FIBDataSet,
    pFIBDataSet;

type
  TdmLabels = class(TDataModule)

  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  u_dm;

function tiene_etiquetas(pedido:integer):Boolean;
var fiesta:Boolean;
begin
      Result := False;

      with TpFIBDataSet.Create(dm) do
      try
        Database:=dm.db;
        SQLs.SelectSQL.Clear;
        sqls.SelectSQL.Add('select * from c_pedidos_etiquetas where id_pedido=:pedido and estado=''A'' ');
        ParamByName('pedido').AsInteger := pedido;
        Open;

        Result :=  (RecordCount>0);

      finally
        free;
      end;
end;

end.
