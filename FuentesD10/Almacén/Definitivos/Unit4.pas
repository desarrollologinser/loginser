unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dm, NxColumns, NxColumnClasses,
  NxScrollControl, NxCustomGridControl, NxCustomGrid, NxGrid, Vcl.StdCtrls, MidasLib, IdHTTP;

type
  TForm4 = class(TForm)
    btn1: TButton;
    gridentregados: TNextGrid;
    nxnmbrclmn1: TNxNumberColumn;
    nxtxtclmn1: TNxTextColumn;
    nxtxtclmn7: TNxTextColumn;
    nxtxtclmn2: TNxTextColumn;
    nxtxtclmn3: TNxTextColumn;
    nxtxtclmn4: TNxTextColumn;
    nxtxtclmn8: TNxTextColumn;
    nxtxtclmn5: TNxTextColumn;
    nxnmbrclmn2: TNxNumberColumn;
    btn2: TButton;
    procedure CargaEntregados();
    procedure btn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

const
  httpweb='http://www.loginser.com/bankia/operadorlogistico/sync/';

implementation

{$R *.dfm}

procedure TForm4.FormActivate(Sender: TObject);
begin
  CargaEntregados();
end;

procedure TForm4.btn1Click(Sender: TObject);
var i, registros, id :Integer;
  cadenaSql: string;
  function ServicioHttp(StrUrl, servicio: string):String;
  var
    Http1: TIdHTTP;
    strRead:string;
  begin
    Http1 := TIdHTTP.Create (nil);
    try
      strRead := Http1.Get(httpweb+StrUrl);
      Result := StrRead;
    except
     on e:Exception do
     begin
      Result := 'Err';
     end;
    end;
  end;
  function MarcaDevuelto(solicitud:string):string;
  var Url, http_rec: string;
  begin
    Result:='';
    try
      Url:='sync_marca_devuelto.php?id='+solicitud;
      http_rec:=ServicioHttp(Url,'PUT');
    except
     on e:Exception do
     begin
      Result := 'Err';
     end;
    end;
  end;
begin
// Devolver
try
    dm1.db.Close;
    dm1.db.Connected := True;

    try
      id:=0;
      cadenaSql:='update a_stock set cantidad=1 where id_articulo=:id and id_empresa=1';
      registros:=gridentregados.RowCount-1;
      for i := 0 to registros do
      begin
        if gridentregados.Row[i].Selected then
        begin
          dm1.write.Active:=True;
          id:=gridentregados.Cell[0,i].AsInteger;
          with dm1.qrydevolver do
          begin
            Params.ParamByName('id').AsInteger := id;
            Params.ParamByName('f').AsDate := Now;
            ExecQuery;
          end;
        // Actualiza stock
          with dm1.stock do
          begin
            SQL.Clear;
            SQL.Add(cadenaSql);
            Params.ParamByName('id').AsInteger := gridentregados.Cell[8,i].AsInteger;
            ExecQuery;
          end;
          dm1.write.Commit;
        end;
      end;

      if id<>0 then
      begin
        if not (MarcaDevuelto(IntToStr(id))='Err') then
          ShowMessage('Devolución procesada.')
        else ShowMessage('No se ha podido marcar en la WEB');
      end
    except on e: Exception do begin
        dm1.write.Rollback;
        ShowMessage('error '+e.Message);
      end;
    end;
    finally
      dm1.write.Active:=False;
      dm1.qrydevolver.Close;
      dm1.stock.Close;
      dm1.db.Close;
      CargaEntregados();
    end;
end;

procedure TForm4.btn2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm4.CargaEntregados;
begin
  Screen.Cursor:=crHourGlass;
  dm1.db.Close;
  dm1.db.Connected := True;
  dm1.read.Active:=True;
  dm1.qryentregados.ExecQuery;
  gridentregados.ClearRows;
  while not dm1.qryentregados.Eof do
  begin
    with gridentregados do
    begin
      AddRow();
      Cell[0,RowCount-1].AsString:=dm1.qryentregados.FieldByName('ID_SOLICITUD_WEB').AsString;
      Cell[1,RowCount-1].AsString:=dm1.qryentregados.FieldByName('TIPO_CAJA').AsString;
      Cell[2,RowCount-1].AsString:=dm1.qryentregados.FieldByName('CAJA').AsString;
      Cell[3,RowCount-1].AsString:=dm1.qryentregados.FieldByName('LOTE').AsString;
      Cell[4,RowCount-1].AsString:=dm1.qryentregados.FieldByName('CARPETA').AsString;
      Cell[5,RowCount-1].AsString:=dm1.qryentregados.FieldByName('PAGINA').AsString;
      Cell[6,RowCount-1].AsString:=dm1.qryentregados.FieldByName('SOLICITANTE').AsString;
      Cell[7,RowCount-1].AsString:=dm1.qryentregados.FieldByName('FECHA_ENTREGA').AsString;
      Cell[8,RowCount-1].AsInteger:=dm1.qryentregados.FieldByName('ID_ARTICULO').AsInteger;
    end;
    dm1.qryentregados.Next;
  end;
  dm1.read.Active:=False;
  dm1.qryentregados.Close;
  dm1.db.Close;
  Screen.Cursor:=crDefault;
end;
end.
