unit Unit5;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, IdHTTP, MidasLib,
  System.StrUtils,
  System.SyncObjs,
  Winapi.Activex,
  System.DateUtils,
  types, dm;

type
  TForm5 = class(TForm)
    mmo1: TMemo;
    btn1: TButton;
    lbl1: TLabel;
    btn2: TButton;
    pb: TProgressBar;
    btn3: TButton;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  p='|';
  httpweb='http://www.loginser.com/bankia/operadorlogistico/sync/';

var
  Form5: TForm5;

implementation

{$R *.dfm}

procedure TForm5.btn1Click(Sender: TObject);
var Url, http_rec, estado, caja: string;
  n, registros:Integer;
  str_linea:TStringDynArray;
 {$REGION 'Funciones internas del procedimiento de sincronización'}
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
  function MarcaPedidos(solicitud:string):string;
  var Url, http_rec: string;
  begin
    Result:='';
    try
      Url:='sync_marca_pedidos.php?soli='+solicitud;
      http_rec:=ServicioHttp(Url,'PUT');
      mmo1.Lines.Add('Solicitud: '+solicitud+' marcanda.');
    except
     on e:Exception do
     begin
      Result := 'Err';
     end;
    end;
  end;
  function existeSolicitud(id_solicitud: Integer):Boolean;
  var cadenasql:string;
  begin
    Result:=False;
    cadenasql:='select * from A_Cajas_Solicitudes where id_solicitud_web=:id_soli';
    dm1.read.Active:=True;
    with dm1.qry do begin
      SQL.Clear;
      SQL.Add(cadenasql);
      ParamByName('id_soli').AsInteger:=id_solicitud;
      ExecQuery;
    end;
    if not dm1.qry.Eof then Result:=True;
    dm1.qry.Close;
  end;
  function SaveCaja(linea:string):string;
  var str_caja: TStringDynArray;
    cadenaSql, lafecha: string;
  begin
      Result:='';
      try
        try
          str_caja:=SplitString(linea,p);
          if not existeSolicitud(Strtoint(str_caja[6])) then
          begin
            cadenasql:='Insert into A_Cajas_Solicitudes (solicitante, fecha_solicitud, id_articulo, id_solicitud_web, tipo_caja, caja, lote, carpeta, pagina) '+
              'Values(:soli, :fecha, :id_a, :id_s, :tipo, :caj, :lot, :car, :pag)';

            mmo1.Lines.Add('Caja: '+str_caja[1]+' actualizando.');
            lafecha:=Copy(str_caja[8],9,2)+'/'+Copy(str_caja[8],6,2)+'/'+Copy(str_caja[8],1,4);
            dm1.write.Active:=True;
            with dm1.qryescribe do
            begin
              SQL.Clear;
              SQL.Add(cadenaSql);
              ParamByName('tipo').AsString := str_caja[0];
              ParamByName('caj').asinteger := Strtoint(str_caja[1]);
              ParamByName('lot').asinteger := Strtoint(str_caja[2]);
              ParamByName('car').asinteger := Strtoint(str_caja[3]);
              ParamByName('pag').asinteger := Strtoint(str_caja[4]);
              ParamByName('soli').asstring := System.UTF8ToString(str_caja[5]);
              ParamByName('id_s').asinteger := Strtoint(str_caja[6]);
              ParamByName('id_a').asinteger := Strtoint(str_caja[7]);
              ParamByName('fecha').AsDate := StrtoDate(lafecha);
              ExecQuery;
            end;
            dm1.qryescribe.Close;
            dm1.write.commit;
          end;
          Result:= str_caja[6];
        except
          on e: Exception do
          begin
            dm1.write.Rollback;
          end;
        end;
      except
       on e:Exception do
       begin
        Result := 'Err';
       end;
      end;

  end;
{$ENDREGION}
begin
// Sincronizar
  Screen.Cursor:=crHourGlass;
  try
    try
      dm1.db.Close;
      dm1.db.Connected := True;
      dm1.write.Active:=True;
      Url:='sync_get_pedidos.php?modo=1';
      http_rec:=ServicioHttp(Url, 'GET');
      mmo1.Lines.Add('Recepcionando peticiones ...');
      mmo1.Lines.Add('');
      if http_rec='Err' then ShowMessage('Tarea finalizada por error en la ejecución del servicio GET web.')
      else begin
        // Recepcionar
        if http_rec<>'' then
        begin
          str_linea:=splitstring(http_rec,'~');
          pb.Visible:=True;
          pb.Min:= Low(str_linea);                  //Separa lineas por ~
          pb.Max:= High(str_linea)-1;
          pb.Step:= 1;
          mmo1.Lines.Clear;
          for n:=Low(str_linea) to High(str_linea)-1 do begin
            estado:=SaveCaja(str_linea[n]);
            if estado='Err' then
            begin
              ShowMessage('Error: La solicitud no se ha podido actualizar.');
            end else MarcaPedidos(estado); // Aquí marcamos el pedido en la web como recibido en IB
            pb.StepIt;
          end;
        end;
        mmo1.Lines.Add('Recepciones finalizadas ...');
        mmo1.Lines.Add('');

        // Entregas
//        mmo1.Lines.Add('Enviando entregas ...');
//        mmo1.Lines.Add('');
//        Url:='sync_marca_entregados.php';
//        dm1.read.Active:=True;
//        dm1.qryentregados.ExecQuery;
//        registros:=dm1.qryentregados.RecordCount;
//        if registros>0 then
//        begin
//          pb.Min:= 0;
//          pb.Max:= registros;
//          pb.Step:= 1;
//          while not dm1.qryentregados.Eof do
//          begin
//            caja:= dm1.qryentregados.FieldByName('ID_CAJA_ASEVAL').AsString;
//            mmo1.Lines.Add('Entrega: '+dm1.qryentregados.FieldByName('codigo').AsString+' marcando.');
//            http_rec:=ServicioHttp(Url+'?id='+caja+'&valor=1','PUT');
//            dm1.qryentregados.Next;
//            pb.StepIt;
//          end;
//          mmo1.Lines.Add('Envios finalizados ...');
//          mmo1.Lines.Add('');
//        end;
//
//        // Devolver a web
//        mmo1.Lines.Add('Enviando devoluciones ...');
//        mmo1.Lines.Add('');
//        Url:='sync_marca_entregados.php';
//        dm1.read.Active:=True;
//        dm1.qrydevolverweb.ExecQuery;
//        registros:=dm1.qrydevolverweb.RecordCount;
//        if registros>0 then
//        begin
//
//          while not dm1.qrydevolverweb.Eof do
//          begin
//            caja:= dm1.qrydevolverweb.FieldByName('ID_CAJA_ASEVAL').AsString;
//            mmo1.Lines.Add('Marcando web: '+dm1.qrydevolverweb.FieldByName('codigo').AsString+' marcando.');
//            http_rec:=ServicioHttp(Url+'?id='+caja+'&valor=0','PUT');
//            dm1.qrydevolverweb.Next;
//          end;
//        end;
//        mmo1.Lines.Add('Devoluciones finalizadas ...');
      end;
    except
      on e:Exception do
        ShowMessage('Error: '+e.Message);
    end;
  finally
    dm1.db.Close;
    dm1.write.Active:=False;
    dm1.read.Active:=False;
    ShowMessage('Tarea finalizada');
    pb.Visible:=False;
    Screen.Cursor:=crDefault;
  end;

end;

procedure TForm5.btn2Click(Sender: TObject);
var cadena, http_rec, Url, estado:string;
 n, registros:Integer;
  str_linea:TStringDynArray;
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
  function existearti(arti: Integer):Boolean;
  var cadenasql:string;
  begin
    Result:=False;
    cadenasql:='select * from Cajas_Web where id_articulo=:id';
    dm1.read.Active:=True;
    with dm1.qry do begin
      SQL.Clear;
      SQL.Add(cadenasql);
      ParamByName('id').AsInteger:=arti;
      ExecQuery;
    end;
    if not dm1.qry.Eof then Result:=True;
    dm1.qry.close;
  end;
  function SaveArti(arti:integer):string;
  var str_caja: TStringDynArray;
    cadenaSql, lafecha: string;
  begin
      Result:='';
      try
        try

          if not existearti(arti) then
          begin
            cadenasql:='Insert into Cajas_Web (id_articulo) '+
              'Values(:id_a)';

            //mmo1.Lines.Add('Artículo: '+strtoint(arti)+' actualizando.');

            dm1.write.Active:=True;
            with dm1.qryescribe do
            begin
              SQL.Clear;
              SQL.Add(cadenaSql);
              ParamByName('id_a').asinteger := arti;
              ExecQuery;
            end;
            dm1.qryescribe.Close;
            dm1.write.commit;
          end;
          Result:= IntToStr(arti);
        except
          on e: Exception do
          begin
            dm1.write.Rollback;
          end;
        end;
      except
       on e:Exception do
       begin
        Result := 'Err';
       end;
      end;

  end;
begin
  //sOLO YO
  Url:='sync_get_cajas_todas.php';
  http_rec:=ServicioHttp(Url, 'GET');
  mmo1.Lines.Add('Recepcionando peticiones ...');
  mmo1.Lines.Add('');
  if http_rec='Err' then ShowMessage('Tarea finalizada por error en la ejecución del servicio GET web.')
      else begin
        // Recepcionar
        if http_rec<>'' then
        begin
          str_linea:=splitstring(http_rec,'~');
          pb.Visible:=True;
          pb.Min:= Low(str_linea);                  //Separa lineas por ~
          pb.Max:= High(str_linea)-1;
          pb.Step:= 1;
          mmo1.Lines.Clear;
          for n:=Low(str_linea) to High(str_linea)-1 do begin
            estado:=SaveArti(StrToInt(str_linea[n]));
            if estado='Err' then
            ShowMessage('Error: El artículo '+str_linea[n]+' no se ha podido inserta.');

            pb.StepIt;
          end;
        end;
        mmo1.Lines.Add('Recepciones finalizadas ...');
        mmo1.Lines.Add('');
      end;

end;

procedure TForm5.btn3Click(Sender: TObject);
begin
  Close;
end;

end.
