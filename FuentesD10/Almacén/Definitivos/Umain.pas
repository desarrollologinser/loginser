unit Umain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sComboBox, sEdit, sButton, dm,
  sSpinEdit, sMemo, frxClass, FIBQuery, pFIBQuery, FIBDatabase,
  pFIBDatabase, frxDBSet, Data.DB, Datasnap.DBClient, frxBarcode, inifiles, MidasLib;

type
  TForm3 = class(TForm)
    ebuscar: TsEdit;
    cbbbuscar: TsComboBox;
    btn1: TsButton;
    editcaja: TsSpinEdit;
    /////////////////grid: TNextGrid;
    //////////////articulo: TNxTextColumn;
    editcodcliente: TsEdit;
    btn2: TsButton;
    btn3: TsButton;
    btn4: TsButton;
    btn5: TsButton;
   { gridbusca: TNextGrid;
    nxtxtclmn1: TNxTextColumn;
    nxtxtclmn2: TNxTextColumn;
    nxtxtclmn3: TNxTextColumn;
    nxtxtclmn4: TNxTextColumn;
    nxtxtclmn5: TNxTextColumn;   }
    rb1: TRadioButton;
    rb2: TRadioButton;
    editestanteria: TsEdit;
    editposicion: TsSpinEdit;
    editaltura: TsSpinEdit;
  {  gridcajas: TNextGrid;
    nxtxtclmn7: TNxTextColumn;
    nxtxtclmn8: TNxTextColumn;
    nxnmbrclmn5: TNxNumberColumn;
    nxnmbrclmn6: TNxNumberColumn;    }
    btn6: TsButton;
    lbl1: TLabel;
    rp_etiqueta: TfrxReport;
    tabla: TfrxDBDataset;
    ds1: TClientDataSet;
    ds1articulo: TStringField;
    ds1matricula: TStringField;
    ds1articulo_cliente: TStringField;
    ds1fecha: TStringField;
    ds1caja1: TStringField;
    ds1caja2: TStringField;
    ds1caja3: TStringField;
    ds1caja4: TStringField;
    ds1caja: TStringField;
    rb3: TRadioButton;
    btn7: TsButton;
    ds1caja5: TStringField;
    rb4: TRadioButton;
    ///////////////////nxtxtclmn6: TNxTextColumn;
    btn8: TButton;
    chk1: TCheckBox;
    edtdescripcion: TsEdit;
    ////////////////nxtxtclmn9: TNxTextColumn;
    procedure btn1Click(Sender: TObject);
    
    procedure FormActivate(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    function Get_Ubicacion(id_estant:string; id_pos,id_alt:Integer; out id_ubicacion:Integer): Boolean;
    function CreaUbicacion(id_estant:string; id_pos,id_alt:Integer; out id_ubicacion:Integer): Boolean;
    function NuevaCaja(Tipo: string) : Integer;
    function CreaArticulo(art, prefijo, tipo, letra: string; out id_articulo:integer): Boolean;
    function CreaCaja_Articulos(art, prefijo, tipo, letra: string; out id_articulo:integer): Boolean;
    function UbicaArticulo(id_art, id_ubic, uds, id_alm: Integer): Boolean;
    function CreaCaja(id_articulo, orden, pale: Integer;  codigo, prefijo, tipo, letra, descripcion: string): Boolean;
    function QueArticulo(codigo:string):Integer;
    function QueMatricula(id:Integer):String;
    function QueCaja(caja:string; cual:Integer):string;
    procedure cbbbuscarChange(Sender: TObject);
    procedure leer_ini();
    procedure CompruebaActivar();
    procedure activa();
    procedure CargaDesubicados();
    procedure desactiva();
    procedure ImprimirCaja(id_articulo: Integer);
    procedure btn6Click(Sender: TObject);
    procedure ebuscarChange(Sender: TObject);
    procedure gridcajasClick(Sender: TObject);
    procedure rb3Click(Sender: TObject);
    procedure btn7Click(Sender: TObject);
    procedure ebuscarMouseEnter(Sender: TObject);
    procedure btn8Click(Sender: TObject);
  private
    function GetPrefijos(out prefijo, tipo, letra: string): Boolean;
    { Private declarations }
  public

    { Public declarations }
  end;

var
  Form3: TForm3; imp_eti:string;

implementation

{$R *.dfm}
procedure TForm3.CompruebaActivar();
begin
  btn4.Enabled:=False;
  btn3.Enabled:=False;
 ///////////// if (editcaja.Text<>'') and (grid.RowCount>0) then
    btn4.Enabled:=True;
 //////////////////// if grid.RowCount>0 then btn3.Enabled:=True;

end;
procedure TForm3.leer_ini;
var ini:tinifile;
  ruta_ini, exe, ruta_exe:string;
begin
  exe:=ExtractFileName(ParamStr(0));
  exe:=Copy(exe,1,Length(exe)-4);

  ruta_exe:=ExtractFilePath(ParamStr(0));
  IncludeTrailingPathDelimiter(ruta_exe);

  if FileExists(ruta_exe+'config.ini') then ruta_ini:=ruta_exe+'config.ini'          //al lado del exe o en C
    else if FileExists('C:\config.ini') then ruta_ini:='C:\config.ini'
      else raise exception.Create('No Encontrado Config.ini');

  ini:=TIniFile.Create(ruta_ini);
  try
    imp_eti:=ini.readstring('Datos','imp_eti','');
  finally
    ini.free;
  end;
end;
function TForm3.QueCaja(caja:string; cual:Integer):string;
var x:Integer;
begin
  Result:='';
  with dm1.qrycajas do
  begin
    Params.ParamByName('id').AsString := caja;
    ExecQuery;
  end;
  x:=1;
  while not dm1.qrycajas.Eof do
  begin
    if x=cual then
    begin
      Result:=dm1.qrycajas.FieldByName('codigo_cli').AsString;
    end;
    dm1.qrycajas.Next;
    Inc(x);
  end;
  dm1.qrycajas.close;
end;
function TForm3.QueMatricula(id:Integer): String;
begin
  with dm1.qrymatriculas do
  begin
    Params.ParamByName('id').AsInteger := id;
    ExecQuery;
  end;
  Result:=dm1.qrymatriculas.FieldByName('id_matricula').AsString;
  dm1.qrymatriculas.close;
end;
procedure TForm3.rb3Click(Sender: TObject);
begin
  ebuscar.Enabled:=False;
  if (rb3.Checked) or (cbbbuscar.Text<>'') or (rb4.Checked) then ebuscar.Enabled:=True;
end;

procedure TForm3.ImprimirCaja(id_articulo: Integer);
var cadenaSql:string;
begin
  dm1.qryarticulo.Prepare;
  with dm1.qryarticulo do
  begin
    Params.ParamByName('id').AsInteger := id_articulo;
    ExecQuery;
  end;
  if not dm1.qryarticulo.Eof then
  begin
    ds1.EmptyDataSet;
    ds1.Open;
    ds1.Insert;
    ds1.FieldByName('articulo').AsString:=dm1.qryarticulo.FieldByName('codigo').AsString;
    ds1.FieldByName('matricula').AsString:=QueMatricula(dm1.qryarticulo.FieldByName('id_articulo').AsInteger);
    ds1.FieldByName('articulo_cliente').AsString:=dm1.qryarticulo.FieldByName('codigo_cli').AsString;
    ds1.FieldByName('fecha').AsString:=DateToStr(date());
    ds1.FieldByName('caja1').AsString:=QueCaja(dm1.qryarticulo.FieldByName('codigo_cli').AsString,1);
    ds1.FieldByName('caja2').AsString:=QueCaja(dm1.qryarticulo.FieldByName('codigo_cli').AsString,2);
    ds1.FieldByName('caja3').AsString:=QueCaja(dm1.qryarticulo.FieldByName('codigo_cli').AsString,3);
    ds1.FieldByName('caja4').AsString:=QueCaja(dm1.qryarticulo.FieldByName('codigo_cli').AsString,4);
    ds1.FieldByName('caja5').AsString:=QueCaja(dm1.qryarticulo.FieldByName('codigo_cli').AsString,5);
    ds1.FieldByName('caja').AsString:=dm1.qryarticulo.FieldByName('nombre').AsString;
    ds1.Post;
  end;
  rp_etiqueta.PrintOptions.Printer:=imp_eti;
  if rp_etiqueta.PrepareReport(True) then rp_etiqueta.Print;
  dm1.qryarticulo.Close;
end;
procedure TForm3.CargaDesubicados;
begin
  Screen.Cursor:=crHourGlass;
  dm1.db.Close;
  dm1.db.Connected := True;
  dm1.read.Active:=True;
  dm1.qrydesubicados.ExecQuery;
  ///////////////gridcajas.ClearRows;
  while not dm1.qrydesubicados.Eof do
  begin
   {/////////////////// with gridcajas do
    begin
      AddRow();
      Cell[0,RowCount-1].AsString:=dm1.qrydesubicados.FieldByName('CODIGO_CLI').AsString;
    end;}
    dm1.qrydesubicados.Next;
  end;
  dm1.read.Active:=False;
  dm1.qrydesubicados.Close;
  dm1.db.Close;
  Screen.Cursor:=crDefault;
end;
procedure TForm3.btn1Click(Sender: TObject);
var x:Integer;
  tipo, prefijo, letra :string;
begin
  if GetPrefijos(prefijo, tipo, letra) then
  begin
    x:=NuevaCaja(prefijo);
    editcaja.Value:=x;
    editcodcliente.SetFocus();
    CompruebaActivar();
    chk1.Checked:=False;
  end;
end;

procedure TForm3.btn2Click(Sender: TObject);
begin
  if editcodcliente.Text<>'' then
  begin
   {////////////////// with grid do
    begin
        AddRow();
        Cell[0,RowCount-1].AsString:=editcodcliente.Text;
        Cell[1,RowCount-1].AsString:=edtdescripcion.Text;
    end; }
    editcodcliente.Text:='';
    edtdescripcion.Text:='';
    editcodcliente.SetFocus();
    CompruebaActivar();
  end;
end;

procedure TForm3.btn3Click(Sender: TObject);
begin
// Quitar registro
  try
   {////////////////////// with grid do
    begin
      DeleteRow(SelectedRow);
    end; }
    CompruebaActivar();
  except on e: Exception do begin
    if Copy(Trim(e.Message),1,10)='List index' then
      ShowMessage('Debe seleccionar un documento para borrar.')
    else ShowMessage('error '+e.Message);
    end;
  end;
end;

procedure TForm3.btn4Click(Sender: TObject);
var id_ubicacion, registros, i, posicion, altura, id_articulo, pale, id_caja, X :Integer;
  articulo_cliente, estanteria, prefijo, tipo, letra: string;
  hecho: Boolean;
begin
  //Guardar documentos de Aseval incluidos en el grid
  if (editcaja.Text<>'') {and ///////////// (grid.RowCount>0)} then
  begin
    btn3.Enabled:=False;
    if GetPrefijos(prefijo, tipo, letra) then
    begin
    try
      dm1.db.Close;
      dm1.db.Connected := True;
      dm1.read.Active:=True;
      try
        if GetPrefijos(prefijo, tipo, letra) then
        begin
          x:=NuevaCaja(prefijo);
          editcaja.Value:=x;
        end;
        dm1.db.Close;
        dm1.db.Connected := True;
        dm1.read.Active:=True;
        if CreaCaja_Articulos(editcaja.Text, prefijo, tipo, letra, id_articulo) then
        begin
          id_caja:=id_articulo;
          hecho:=True;
         ///////////////////// registros:=grid.RowCount-1;
          for i := 0 to registros do
          begin
            //////////////////articulo_cliente := grid.Cell[0,i].AsString;
              if CreaArticulo(articulo_cliente, prefijo, tipo, letra, id_articulo) then
              // Crear en cajas_aseval
              ///////////////  if not CreaCaja(id_articulo, i+1, pale, articulo_cliente, prefijo, tipo, letra, grid.Cell[1,i].AsString) then
                  hecho:=False;
          end;

          if Hecho then
          begin
            ShowMessage('Caja '+inttostr(id_caja)+' creada con éxito.');
            dm1.read.Commit;
            dm1.read.Active:=True;
            ImprimirCaja(id_caja);
          end
          else
          begin
            ShowMessage('No se ha podido crear la caja.');
            dm1.read.Rollback;
          end;

        end;
      except on e: Exception do begin
        dm1.read.Rollback;
        ShowMessage('Error: '+e.Message);
        end;
      end;
      finally
      //////////////////  grid.ClearRows();
        dm1.read.Active:=False;
        dm1.qryIndice.Close;
        dm1.qry.Close;
        dm1.db.Close;
        editcaja.Text:='';
        CargaDesubicados;
      end;
    end;
  end else ShowMessage('Debe obtener primero el número de Caja y haber introducido al menos un documento.');
end;

procedure TForm3.btn5Click(Sender: TObject);
var abuscar, cadenaSql, tipo, prefijo, where, letra:string;
  function stock(id_articulo:Integer):string;
  var cadena:string;
  begin
    Result:='';
    cadena:='select * from a_cajas_solicitudes where id_articulo=:cod and entregado=1 and devuelto is null';
    with dm1.existencias do
    begin
      SQL.Clear;
      SQL.Add(cadena);
      Params.ParamByName('cod').AsInteger := id_articulo;
      ExecQuery;
    end;
    if dm1.existencias.Eof then Result:='SI';
  end;
begin
// Buscar codigo de cliente
  abuscar:='';
  cadenaSql:='select id_articulo, codigo, codigo_cli, etiqueta_caja, etiqueta_definitivo from A_CAJAS_ASEVAL where';
  if rb3.Checked then
  begin
    abuscar := ebuscar.Text;
    where := ' codigo_cli = :cod';
  end
  else
  if GetPrefijos(prefijo, tipo, letra) then
  begin
    if rb1.Checked then
    begin
      abuscar:='0000'+ebuscar.Text;
      abuscar:=tipo+Copy(abuscar,Length(abuscar)-3,4);
      where:=' codigo_cli = :cod';
    end else if rb2.Checked then
    begin
      abuscar:='000000'+ebuscar.Text;
      abuscar:=prefijo+Copy(abuscar,Length(abuscar)-5,6);
      where:=' etiqueta_caja = :cod';
    end;
  end;
  if rb4.Checked then
  begin
    abuscar := ebuscar.Text;
    where := ' codigo = :cod';
  end;
  if abuscar<>'' then
  begin
    cadenaSql:=cadenaSql+where;
    dm1.db.Close;
    dm1.db.Connected := True;
    dm1.read.Active:=True;

    with dm1.qry do
    begin
      SQL.Clear;
      SQL.Add(cadenaSql);
      Params.ParamByName('cod').AsString := abuscar;
      ExecQuery;
    end;

    //////////////////////gridbusca.ClearRows();

    while not dm1.qry.Eof do
    begin
     {///////////////////////////  with gridbusca do
      begin
       AddRow();
        Cell[0,RowCount-1].AsString:=dm1.qry.FieldByName('id_articulo').AsString;
        Cell[1,RowCount-1].AsString:=dm1.qry.FieldByName('codigo').AsString;
        Cell[2,RowCount-1].AsString:=dm1.qry.FieldByName('codigo_cli').AsString;
        Cell[3,RowCount-1].AsString:=dm1.qry.FieldByName('etiqueta_caja').AsString;
        Cell[4,RowCount-1].AsString:=dm1.qry.FieldByName('etiqueta_definitivo').AsString;
        Cell[5,RowCount-1].AsString:=stock(dm1.qry.FieldByName('id_articulo').AsInteger);
      end;   }
      dm1.qry.Next;
    end;

   /////////////////// if gridbusca.RowCount=0 then ShowMessage('El código '+abuscar+' no se ha encontrado.');

    dm1.read.Active:=False;
    dm1.qry.Close;
    dm1.db.Close;
  end;
end;
function TForm3.QueArticulo(codigo: string):Integer;
begin
  Result:=-1;
  with dm1.qrybusca do
  begin
    Params.ParamByName('cod').AsString:=codigo;
    ExecQuery;
  end;
  if not dm1.qrybusca.Eof then Result:=dm1.qrybusca.FieldByName('ID_ARTICULO').AsInteger;
  dm1.qrybusca.Close;
end;
procedure TForm3.btn6Click(Sender: TObject);
var id_ubicacion, registros, i, posicion, altura, id_articulo:Integer;
  articulo_cliente, estanteria, prefijo, tipo, letra: string;
  hecho: Boolean;
begin
  //UBICA CAJAS
  try
    dm1.db.Close;
    dm1.db.Connected := True;
    dm1.read.Active:=True;

    try
      hecho:=True;
      ///////////////////registros:=gridcajas.RowCount-1;

      estanteria:= editestanteria.Text;
      posicion:= editposicion.Value;
      altura:= editaltura.Value;

      for i := 0 to registros do
      begin
       {///////////////////////////  if gridcajas.Row[i].Selected then
        begin
          articulo_cliente := gridcajas.Cell[0,i].AsString;
          id_articulo:=QueArticulo(articulo_cliente);
          if not Get_Ubicacion(estanteria, posicion, altura, id_ubicacion) then
            if CreaUbicacion(estanteria,posicion,altura,id_ubicacion) then
              if not UbicaArticulo(id_articulo,id_ubicacion,1,1) then
                hecho:=False;
        end;  }
      end;
      if Hecho then
      begin
        dm1.read.Commit;
        ShowMessage('Ubicación efectuada.');
      end
      else
      begin
        dm1.read.Rollback;
        ShowMessage('No se ha podido finalizar la ubicación.');
      end;

    except on e: Exception do begin

      dm1.read.Rollback;
      ShowMessage('error '+e.Message);
      end;
    end;
    finally
      dm1.read.Active:=False;
      dm1.qryIndice.Close;
      dm1.qry.Close;
      dm1.db.Close;
      CargaDesubicados();
      editestanteria.Text:='';
      editposicion.Text:='';
      editaltura.Text:='';
      btn6.Enabled:=False;
    end;
end;

procedure TForm3.btn7Click(Sender: TObject);
var registros, i, id_articulo: Integer;
  articulo_cliente: string;
begin
  // Imprimir caja
  try
    dm1.db.Close;
    dm1.db.Connected := True;
    dm1.read.Active:=True;

    try

      ///////////////////////registros:=gridcajas.RowCount-1;

      for i := 0 to registros do
      begin
       {///////////////////////////  if gridcajas.Row[i].Selected then
        begin
          articulo_cliente := gridcajas.Cell[0,i].AsString;
          id_articulo:=QueArticulo(articulo_cliente);
          ImprimirCaja(id_articulo);
        end;     }
      end;

    except on e: Exception do begin
      ShowMessage('error '+e.Message);
      end;
    end;
    finally

      dm1.read.Active:=False;
      dm1.db.Close;
      btn7.Enabled:=False;
    end;
end;

procedure TForm3.btn8Click(Sender: TObject);
begin
  Close;
end;

function TForm3.CreaCaja(id_articulo, orden, pale: Integer; codigo, prefijo, tipo, letra, descripcion: string): Boolean;
var cadenaSql,form4, form6, form3, ordenstring, codigocli, codart:string;
begin
  Result:=True;
  ordenstring:=Trim(IntToStr(orden));
  form3:='000'+ordenstring;
  form3:=Copy(form3,Length(form3)-2,3);
  form4:='0000'+codigo;
  form4:=tipo+Copy(form4,Length(form4)-3,4);
  codigocli:=tipo+form4;
  codart:='613106'+form4+letra;
  if chk1.Checked then
  begin
    codart:='613103'+codigo;
    codigocli:=codigo;
  end;

  form6:='000000'+editcaja.Text;
  form6:=Copy(form6,Length(form6)-5,6);
  try

    cadenaSql:='insert into a_cajas_aseval '+
      '(id_articulo, codigo, codigo_cli, tipo_caja, palet, caja, '+
      'definitivo, carpeta_nueva, etiqueta_caja, etiqueta_definitivo, contenido, descripcion) '+
      'VALUES '+
      '(:ida,:cod,:cli,:tip,:pal,:caj,:def,:car,:eti,:edef,:con, :des)';

    with dm1.qry do
    begin
      SQL.Clear;
      SQL.Add(cadenaSql);
      Params.ParamByName('ida').AsInteger := id_articulo;
      Params.ParamByName('cod').AsString := codart;
      Params.ParamByName('cli').AsString := codigocli;
      Params.ParamByName('tip').AsString := prefijo;
      Params.ParamByName('pal').AsInteger := 1;
      Params.ParamByName('caj').AsInteger := editcaja.Value;
      Params.ParamByName('def').AsInteger := orden;
      Params.ParamByName('car').AsInteger := 1;
      Params.ParamByName('eti').AsString := prefijo+form6;
      Params.ParamByName('edef').AsString := prefijo+form6+'-'+form3;
      Params.ParamByName('con').AsString := 'I';
      Params.ParamByName('des').AsString := descripcion;
      ExecQuery;
    end;
   
  except
    Result:=False;
  end;
end;
function TForm3.CreaUbicacion(id_estant:string; id_pos,id_alt:Integer; out id_ubicacion:Integer): Boolean;
var cadenaSql, cadenaIndice:string;
  MyClass: TObject;
begin
  Result:=True;
  try

    cadenaIndice:='SELECT GEN_ID(GEN_A_UBICACIONES_ID, 1) from RDB$DATABASE';
    dm1.qryIndice.Close;
    with dm1.qryIndice do
    begin
      SQL.Clear;
      SQL.Add(cadenaIndice);
      ExecQuery;
    end;
    id_ubicacion:=dm1.qryIndice.FieldByName('gen_id').AsInteger;

    cadenaSql:='insert into a_ubicaciones (ID_UBICACION,ID_ALMACEN,ID_ESTANTERIA,ID_POSICION,ID_ALTURA,ID_SUB1) '+
      'VALUES '+
      '(:ubi,1,:est,:pos,:alt,:sub1)';
    dm1.qry.Close;
    with dm1.qry do
    begin
      SQL.Clear;
      SQL.Add(cadenaSql);
      Params.ParamByName('ubi').AsInteger := id_ubicacion;
      Params.ParamByName('est').AsString := id_estant;
      Params.ParamByName('pos').AsInteger := id_pos;
      Params.ParamByName('alt').AsInteger := id_alt;
      Params.ParamByName('sub1').AsString := '0';
      ExecQuery;
    end;

  except
    Result:=False;
  end;
end;
function TForm3.Get_Ubicacion(id_estant:string; id_pos,id_alt:Integer; out id_ubicacion:Integer): Boolean;
var cadenaSql:string;
begin                                       //devuelve id_ubicacion
  Result:=False;
  id_ubicacion:=-1;
  cadenaSql:='select id_ubicacion from a_ubicaciones where '+
    'id_empresa=1 and id_almacen=1 and id_estanteria=:est and id_posicion=:pos and id_altura=:alt '+
    'and id_sub1=:su1 and id_sub2=:su2';

  with dm1.qry do
  begin
    SQL.Clear;
    SQL.Add(cadenaSql);
    ExecQuery;
  end;
  if not dm1.qry.Eof then
  begin
    Result:=True;
    id_ubicacion:=dm1.qry.FieldByName('id_ubicacion').AsInteger;
  end;
  dm1.qry.Close;
end;
procedure TForm3.gridcajasClick(Sender: TObject);
var i:Integer;
  sel: Boolean;
begin
  btn6.Enabled:=False;
  btn7.Enabled:=False;
  sel:=False;
{///////////////////////////   for i:=0 to gridcajas.RowCount-1 do
  begin
    if gridcajas.Row[i].Selected then sel:=True;
  end; }
  if sel then btn7.Enabled:=True;

  if sel and (editestanteria.Text<>'') and (editposicion.Text<>'') and (editaltura.Text<>'') then btn6.Enabled:=True;

end;

function TForm3.GetPrefijos(out prefijo, tipo, letra: string):	Boolean;
begin
	Result := True;
  if cbbbuscar.Text='ASEVAL' then
    begin
      tipo:='ASV-';
      prefijo:='AS';
      letra:='A';
    end
      else if cbbbuscar.Text='ASEVAL - PENSIONES' then
      begin
        tipo:='ASVPen-';
        prefijo:='BP';
        letra:='P';
      end
        else if cbbbuscar.Text='ASEVAL - SINIESTROS' then
        begin
          tipo:='ASVSini-';
          prefijo:='BS';
          letra:='S';
        end
          else if cbbbuscar.Text='AVIVA' then
          begin
            tipo:='AV-';
            prefijo:='AV';
            letra:='AV';
          end
            else if cbbbuscar.Text='BANCO DE VALENCIA' then
            begin
              tipo:='BV-';
              prefijo:='VS';
              letra:='V';
            end else Result:=False;
end;
procedure TForm3.activa;
begin
  if (cbbbuscar.Text<>'') or rb3.Checked then
  begin
    ebuscar.Enabled:=True;
    btn1.Enabled:=True;
  end;
end;
procedure TForm3.desactiva;
begin
  ebuscar.Enabled:=False;
  btn1.Enabled:=False;
  btn3.Enabled:=False;
  btn6.Enabled:=False;
  btn5.Enabled:=False;
  btn4.Enabled:=False;
end;
procedure TForm3.ebuscarChange(Sender: TObject);
begin
  btn5.Enabled:=False;
  if (ebuscar.Text<>'') or (rb3.Checked) then btn5.Enabled:=True;
end;

procedure TForm3.ebuscarMouseEnter(Sender: TObject);
begin
  with ebuscar do begin
  if rb1.Checked then
    Hint:='Sólo el código del clp, p.e. 423'
    else if rb2.Checked then
      Hint:='Número de caja BD de Loginser, p.e. 3220'
      else if rb3.Checked then
        Hint:='Número de caja antigua.'
        else if rb4.Checked then
          Hint:='Número de código BD de Loginser, p.e. 6131060797A'
          else Hint:='';
  end;
end;

procedure TForm3.FormActivate(Sender: TObject);
begin
  leer_ini;
  rb1.Checked:=True;
  desactiva();
  CargaDesubicados;
end;

procedure TForm3.cbbbuscarChange(Sender: TObject);
begin
  if (cbbbuscar.Text='') and not rb3.Checked then desactiva()
    else activa();
  if cbbbuscar.Text<>'' then btn1.Enabled:=True;
end;

function TForm3.NuevaCaja(Tipo: string) : Integer;
var cadenaSql:string;
begin
	Result := 0;
  dm1.db.Close;
  dm1.db.Connected := True;
  dm1.read.Active:=True;
  cadenaSql:='select coalesce(max(caja) + 1, 1) as num_caja from A_CAJAS_ASEVAL where tipo_caja = :tipo';
  with dm1.qry do
  begin
    SQL.Clear;
    SQL.Add(cadenaSql);
    Params.ParamByName('tipo').AsString := Tipo;
    ExecQuery;
  end;
 	Result := dm1.qry.FieldByName('num_caja').AsInteger;
  dm1.read.Active:=False;
  dm1.qry.Close;
  dm1.db.Close;
end;
function TForm3.UbicaArticulo(id_art, id_ubic, uds, id_alm: Integer): Boolean;
var
  id_mat: Integer;
  cadenaIndice, cadenaSql: string;
begin
  Result:=True;
  try
    dm1.qryIndice.Close;
    cadenaIndice:='SELECT ID_MATRICULA FROM A_MATRICULAS WHERE ID_ARTICULO=:ID';
    with dm1.qryIndice do
    begin
      SQL.Clear;
      SQL.Add(cadenaIndice);
      Params.ParamByName('ID').AsInteger := id_art;
      ExecQuery;
    end;
    id_mat:=dm1.qryIndice.FieldByName('id_matricula').AsInteger;
    dm1.qryIndice.Close;

    cadenaSql:='insert into a_stock (ID_ALMACEN,ID_UBICACION,ID_ARTICULO,ID_MATRICULA,ID_LOTE,CANTIDAD,ID_EMPRESA) '+
      'VALUES '+
      '(:ID_ALMACEN,:ID_UBICACION,:ID_ARTICULO,:ID_MATRICULA,1,:ctdad,1)';
    dm1.qry.Close;
    with dm1.qry do
    begin
      SQL.Clear;
      SQL.Add(cadenaSql);
      Params.ParamByName('ID_ALMACEN').AsInteger := id_alm;
      Params.ParamByName('ID_UBICACION').AsInteger := id_ubic;
      Params.ParamByName('ID_ARTICULO').AsInteger := id_art;
      Params.ParamByName('ID_MATRICULA').AsInteger := id_mat;
      Params.ParamByName('ctdad').AsInteger := uds;
      ExecQuery;
    end;
    dm1.qry.Close;

  except
    Result:=False;
  end;
end;

function TForm3.CreaCaja_Articulos(art, prefijo, tipo, letra: string; out id_articulo :integer): Boolean;
var
  codigo_cli, cadenaIndice, cadenaSql, codart: string;
  id_mat: Integer;
begin
  //Crea articulo si no existe
  Result:=True;
  try
    art:='000000'+art;
    art:=Copy(art,Length(art)-5,6);
    codart:='613107'+prefijo+art;

    cadenaIndice:='SELECT GEN_ID(GEN_G_ARTICULOS_ID, 1) from RDB$DATABASE';
    dm1.qryIndice.Close;
    with dm1.qryIndice do
    begin
      SQL.Clear;
      SQL.Add(cadenaIndice);
      ExecQuery;
    end;
    id_articulo:=dm1.qryIndice.FieldByName('gen_id').AsInteger;


    cadenaSql:='insert into g_articulos (id_articulo,CODIGO,NOMBRE,ID_CLIENTE,CODIGO_CLI, ID_EMPRESA) '+
      'VALUES '+
      '(:id_articulo,:COD,:NOM,6131,:codcli,1)';
    dm1.qry.Close;
    with dm1.qry do
    begin
      SQL.Clear;
      SQL.Add(cadenaSql);
      Params.ParamByName('id_articulo').AsInteger := id_articulo;
      Params.ParamByName('COD').AsString := codart;
      Params.ParamByName('NOM').AsString := 'Caja '+prefijo+art;
      Params.ParamByName('codcli').AsString := prefijo+art;
      ExecQuery;
    end;
    dm1.qry.Close;

    cadenaIndice:='SELECT GEN_ID(GEN_A_MATRICULAS_ID, 1) from RDB$DATABASE';

    dm1.qryIndice.Close;
    with dm1.qryIndice do
    begin
      SQL.Clear;
      SQL.Add(cadenaIndice);
      ExecQuery;
    end;
    id_mat:=dm1.qryIndice.FieldByName('gen_id').AsInteger;
    dm1.qryIndice.Close;
    cadenaSql:='insert into a_matriculas (id_matricula,id_articulo,uds_ini,tipo,alb_cliente,observaciones) '+
      'VALUES '+
      '(:id_matricula,:id_articulo,:uds_ini,:tipo,:alb_cliente,:observaciones)';
    dm1.qry.Close;
    with dm1.qry do
    begin
      SQL.Clear;
      SQL.Add(cadenaSql);
      Params.ParamByName('id_matricula').AsInteger := id_mat;
      Params.ParamByName('id_articulo').AsInteger := id_articulo;
      Params.ParamByName('uds_ini').AsInteger := 1;
      Params.ParamByName('tipo').asstring := 'E';
      Params.ParamByName('alb_cliente').asstring := '00000';
      ParamByName('observaciones').Asstring := '';
      ExecQuery;
    end;
    dm1.qry.Close;
  except
    Result:=False;
  end;
end;
function TForm3.CreaArticulo(art, prefijo, tipo, letra: string; out id_articulo:integer): Boolean;
var
  codigo_cli, cadenaIndice, cadenaSql, codart, codigocli, art2: string;
begin
  //Crea articulo si no existe
  Result:=True;
  try
    art2:='0000'+art;
    art2:=Copy(art2,Length(art2)-3,4);
    codart:='613106'+art+letra;
    codigocli:=art2;
    if chk1.Checked then
    begin
      codigocli:=art;
      codart:='613103'+art;
    end;

    cadenaIndice:='SELECT GEN_ID(GEN_G_ARTICULOS_ID, 1) from RDB$DATABASE';
    dm1.qryIndice.Close;
    with dm1.qryIndice do
    begin
      SQL.Clear;
      SQL.Add(cadenaIndice);
      ExecQuery;
    end;
    id_articulo:=dm1.qryIndice.FieldByName('gen_id').AsInteger;
    dm1.qryIndice.Close;

    cadenaSql:='insert into g_articulos (id_articulo,CODIGO,NOMBRE,ID_CLIENTE,CODIGO_CLI, ID_EMPRESA) '+
      'VALUES '+
      '(:id_articulo,:COD,:NOM,6131,:codcli,1)';
    codigocli:=tipo+art;

    dm1.qry.Close;
    with dm1.qry do
    begin
      SQL.Clear;
      SQL.Add(cadenaSql);
      Params.ParamByName('id_articulo').AsInteger := id_articulo;
      Params.ParamByName('COD').AsString := codart;
      Params.ParamByName('NOM').AsString := 'Caja '+art+letra;
      Params.ParamByName('codcli').AsString := codigocli;
      ExecQuery;
    end;
    dm1.qry.Close;
  except
    Result:=False;
  end;
end;

end.
