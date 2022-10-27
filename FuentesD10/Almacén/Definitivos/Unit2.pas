unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, dm, MidasLib, IdHTTP;

type
  TForm2 = class(TForm)
    {/////////////////////////// gridsolicitados: TNextGrid;
    nxnmbrclmn1: TNxNumberColumn;
    nxtxtclmn7: TNxTextColumn;
    nxtxtclmn8: TNxTextColumn;

    nxtxtclmn1: TNxTextColumn;
    nxtxtclmn2: TNxTextColumn;
    nxtxtclmn3: TNxTextColumn;
    nxtxtclmn4: TNxTextColumn;
    nxtxtclmn5: TNxTextColumn;
//    nxnmbrclmn2: TNxNumberColumn;  }
   btn1: TButton;
    btn2: TButton;
    procedure CargaSolicitados();
    procedure btn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

const
  httpweb='http://www.loginser.com/bankia/operadorlogistico/sync/';

implementation

{$R *.dfm}

procedure TForm2.FormActivate(Sender: TObject);
begin
  CargaSolicitados();
end;

procedure TForm2.btn1Click(Sender: TObject);
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
  function MarcaEntregados(solicitud:string):string;
  var Url, http_rec: string;
  begin
    Result:='';
    try
      Url:='sync_marca_entregados.php?id='+solicitud;
      http_rec:=ServicioHttp(Url,'PUT');
    except
     on e:Exception do
     begin
      Result := 'Err';
     end;
    end;
  end;
  function stock(id_articulo:Integer):integer;
  var cadena:string;
  begin
    dm1.read.Active:=True;
    Result:=0;
    cadena:='select * from a_cajas_solicitudes where id_articulo=:cod and entregado=1 and devuelto is null';
    with dm1.existencias do
    begin
      SQL.Clear;
      SQL.Add(cadena);
      Params.ParamByName('cod').AsInteger := id_articulo;
      ExecQuery;
    end;
    if dm1.existencias.Eof then Result:=1;
    dm1.read.Active:=False;
  end;
begin
// Entregar
 try
    dm1.db.Close;
    dm1.db.Connected := True;
    dm1.write.Active:=True;
    try
      cadenaSql:='update a_stock set cantidad=0 where id_articulo=:id and id_empresa=1';
      registros:=gridsolicitados.RowCount-1;
      id:=0;
      for i := 0 to registros do
      begin
        if gridsolicitados.Row[i].Selected then
        begin
          //if stock(gridsolicitados.Cell[8,i].AsInteger)=0 then  // comprobar stock por si hubiese habido algún fallo
            ShowMessage('El artículo no está en el almacén.');   // en el procedimiento de gestión de solicitudes.
          //else begin
            id:=gridsolicitados.Cell[0,i].AsInteger;
            with dm1.qryentregar do
            begin
              Params.ParamByName('id').AsInteger := id;
              Params.ParamByName('f').AsDate := Now;
              ExecQuery;
            end;
            // Actualiza stock
            dm1.write.Active:=True;
            with dm1.stock do
            begin
              SQL.Clear;
              SQL.Add(cadenaSql);
              Params.ParamByName('id').AsInteger := gridsolicitados.Cell[8,i].AsInteger;
              ExecQuery;
            end;
          //end;
        end;
      end;
      dm1.write.Commit;

      if id<>0 then
      begin
        if not (MarcaEntregados(IntToStr(id))='Err') then
          ShowMessage('Entrega procesada.')
        else ShowMessage('No se ha podido marcar en la WEB');
      end

    except on e: Exception do begin
      dm1.write.Rollback;
      ShowMessage('error '+e.Message);
      end;
    end;
    finally
      dm1.write.Active:=False;
      dm1.qryentregar.Close;
      dm1.db.Close;
      CargaSolicitados();
 end;
end;

procedure TForm2.btn2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm2.CargaSolicitados;
begin
  Screen.Cursor:=crHourGlass;
  dm1.db.Close;
  dm1.db.Connected := True;
  dm1.read.Active:=True;
  dm1.qrysolicitados.ExecQuery;
  gridsolicitados.ClearRows;
  while not dm1.qrysolicitados.Eof do
  begin
    with gridsolicitados do
    begin
      AddRow();
      Cell[0,RowCount-1].AsString:=dm1.qrysolicitados.FieldByName('ID_SOLICITUD_WEB').AsString;
      Cell[1,RowCount-1].AsString:=dm1.qrysolicitados.FieldByName('TIPO_CAJA').AsString;
      Cell[2,RowCount-1].AsString:=dm1.qrysolicitados.FieldByName('CAJA').AsString;
      Cell[3,RowCount-1].AsString:=dm1.qrysolicitados.FieldByName('LOTE').AsString;
      Cell[4,RowCount-1].AsString:=dm1.qrysolicitados.FieldByName('CARPETA').AsString;
      Cell[5,RowCount-1].AsString:=dm1.qrysolicitados.FieldByName('PAGINA').AsString;
      Cell[6,RowCount-1].AsString:=dm1.qrysolicitados.FieldByName('SOLICITANTE').AsString;
      Cell[7,RowCount-1].AsString:=dm1.qrysolicitados.FieldByName('FECHA_SOLICITUD').AsString;
      Cell[8,RowCount-1].AsString:=dm1.qrysolicitados.FieldByName('ID_ARTICULO').AsString;
    end;
    dm1.qrysolicitados.Next;
  end;
  dm1.read.Active:=False;
  dm1.qrysolicitados.Close;
  dm1.db.Close;
  Screen.Cursor:=crDefault;
end;
end.
