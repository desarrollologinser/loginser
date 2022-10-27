
unit u_main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, sPanel, Vcl.StdCtrls,
  sLabel, Vcl.ComCtrls, sStatusBar, NxScrollControl, NxCustomGridControl,
  NxCustomGrid, NxDBGrid, sListBox, sCheckListBox, sComboBox, Vcl.Buttons,
  sSpeedButton, sEdit, sSkinProvider, sSkinManager, sButton, Vcl.Mask,
  sMaskEdit, sCustomComboEdit, sToolEdit, XLSSheetData5, XLSReadWriteII5,System.DateUtils,
  acPathDialog, sGroupBox, sCheckBox,Xc12Utils5, Data.DB, FIBDataSet,
  pFIBDataSet;

type
  TMain = class(TForm)
    status: TsStatusBar;
    lgsdb: TsLabel;
    pnlPrin: TsPanel;
    chkAlmacen: TsCheckListBox;
    chkEstanteria: TCheckBox;
    edtCliente: TsEdit;
    btnCliente: TsSpeedButton;
    sk_manager: TsSkinManager;
    sknprvdr1: TsSkinProvider;
    dtDesde: TsDateEdit;
    dtHasta: TsDateEdit;
    btnGenerar: TsButton;
    xExcel: TXLSReadWriteII5;
    ruta: TsPathDialog;
    lblCliente: TsLabel;
    btnLineas: TsButton;
    btnDoble: TsButton;
    btnPrueba: TsButton;
    btnprocesarTodo: TsButton;
    chkTodos: TsCheckBox;
    btnProcesaTodo: TsButton;
    edtIDCliente: TsEdit;
    xExcelResumen: TXLSReadWriteII5;
    btnMerydeis: TsButton;
    xExcelGrupo: TXLSReadWriteII5;
    btnResumen: TsButton;
    qry_1: TpFIBDataSet;
    procedure ProcesaAlmacen;
    procedure btnGenerarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtClienteChange(Sender: TObject);
    procedure btnClienteClick(Sender: TObject);
    procedure compruebaCondicionGeneral;
    function CalculaTarifa(cliente,servicio:string;min,max,cantidad:Double;id_unidad:Integer;fecha:tdate):double;
    function CalculaExceso(cliente,servicio: string):double;
    procedure btnLineasClick(Sender: TObject);
   // function LineasDePedidos(posicion,codCliente:Integer):Integer ;
    procedure btnDobleClick(Sender: TObject);
  //  procedure btnPruebaClick(Sender: TObject);
    procedure btnprocesarTodoClick(Sender: TObject);
    procedure btnProcesaTodoClick(Sender: TObject);
    procedure btnMerydeisClick(Sender: TObject);
    procedure btnResumenClick(Sender: TObject);
  private
    { Private declarations }
    procedure GeneraCabeceraXLS(altura_cabecera:integer);
    function GeneraXLS(altura_columna:Integer;servicio:string):Integer;
    function reemplazar(tex:string):string;
    function comprobar:Boolean;
    procedure iniciarFechas;
    function GeneraCabeceraCliente:integer;  //hecho
    function GeneraFijoMensual:integer;     //hecho
    function LineasDePedidos(fila,columna,codCliente:Integer;servicio:string;out col:integer):Integer ;   //hecho pero faltan hacer casos particulares
    function LineasDePedidosIMEI(fila,columna,codCliente:Integer;servicio:string;out col:integer):Integer ;
    function RecepcionDeMaterial(fila,columna,codCliente:Integer;servicio:string;out col:integer):Integer ; //hecho
    //function DescargasMasivas(fila,columna,codCliente:Integer;servicio:string;out col:integer):Integer ;  //esperando reunion
    //function Grupajes(fila,columna,codCliente:Integer;servicio:string;out col:integer):Integer ;          // esperando reunion
    function DistribucionDeValijas(fila,columna,codCliente:Integer;servicio:string;out col:integer):Integer ; //en curso
    function HuecosDeEstafeta(fila,columna,codCliente:Integer;servicio:string;out col:integer):Integer ; //en curso
    //function DestruccionControlada(fila,columna,codCliente:Integer;servicio:string;out col:integer):Integer ; //esperando reunion
    function devoluciones(fila,columna,codCliente:Integer;servicio:string;out col:integer):Integer ; //en curso
    function serviciosExtras(fila,columna,codCliente:Integer;servicio:string;out col:Integer):Integer;
    function precioTotalFactura(fila,columna:Integer):integer;
    procedure procesaAlmacenClientes;
    function quePedidosTiene:Integer;
    function LimpiarFilas(fila:Integer):Integer;
    procedure resumenPorGrupo(id_grupo:integer);
   // procedure insertarFacturaMerydeis(codcliente:Integer;total_almacenaje,total_entradas,total_salidas,total_extras:Double);
   // procedure crearInformeGrupo(grupo:integer);
  public
    { Public declarations }
    var dias:Integer;
    fechaini,fechafin:string;
    semaforo_skin:boolean;
    almacen,comparacion:string;
    contador:Integer;
    log: TStrings;
    txt: TextFile;
    errores:Integer;
    total_factura:Double;
    total_mer_almacen:double;
    total_mer_entradas:Double;
    total_mer_salidas_imei:Double;
    total_mer_salidas:Double;
    total_mer_extras:Double;
    total_almacen:double;
    total_entradas:Double;
    total_salidas_imei:Double;
    total_salidas:Double;
    total_extras:Double;
    posicion_resumen:Integer;
    total_estafeta:Double;
    total_fijo:Double;
    const
    arrayLetras: array[1..26] of string = ('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'); ///Array necesario para Excel
    arraymeses: array[1..12] of string = ('ENERO','FEBRERO','MARZO','ABRIL','MAYO','JUNIO','JULIO','AGOSTO','SEPTIEMBRE','OCTUBRE','NOVIEMBRE','DICIEMBRE'); ///Array necesario para el arbol de carpetas
    tabladentro: Integer= 192192192;
    tablafuera: Integer= 808080;
 end;

var
  Main: TMain;

implementation

{$R *.dfm}
uses u_dm,ubuscapro,u_globals;

{$REGION 'Eventos'}
{*------------------------------------------------------------------------------
  Genera la ventan del buscador Buscapro
  @sender Objeto que lanza el evento
-------------------------------------------------------------------------------}
procedure TMain.btnClienteClick(Sender: TObject);
begin
  with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='a.id_cliente,g.nombre ';
    titulos.commatext:='ID,Nombre';
    from:='g_articulos a inner join g_clientes g on (a.id_cliente=g.id_cliente) ';
    where:='a.estado='+quotedStr('A');
    orden[1]:=1;  busca:=1;   distinct:=1;   fillimpio:=True;
    ShowModal;
    if resultado then begin
      with Sender as TsSpeedButton do begin
        edtCliente.Text:=valor[1];
        end;
    end;
  end;
end;
{*------------------------------------------------------------------------------
 Realiza un cambio en el formato de las fechas, comprueba los datos y, de ser correctos, lanza
 el procedimiento GeneraXLS
   @sender Objeto que lanza el evento
-------------------------------------------------------------------------------}

procedure TMain.btnDobleClick(Sender: TObject);
var col : Integer;
begin
col:=2;
  fechaINI:=FormatDateTime('mm/dd/yyyy', dtDesde.Date);
  fechaFIN:=FormatDateTime('mm/dd/yyyy', dtHasta.Date);
  LineasDePedidos(generaXLS(col,'ALMACENAJE DE PALÉS')+2,0,StrToInt(edtCliente.Text),'Lineas de pedido',col)
end;

procedure TMain.btnGenerarClick(Sender: TObject);
var Pos:Integer;
begin
 If MessageDlg('¿Estás seguro?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    Dias:=DaysBetween(dtDesde.Date,dtHasta.Date);
    fechaINI:=FormatDateTime('mm/dd/yyyy', dtDesde.Date);
    fechaFIN:=FormatDateTime('mm/dd/yyyy', dtHasta.Date);
    Screen.Cursor:=crHourGlass;
  //  if(comprobar) then
      GeneraCabeceraXLS(0);
      Pos:=GeneraXLS(2,'ALMACENAJE DE PALETS');
  end;
end;

procedure TMain.btnLineasClick(Sender: TObject);
var
anyo,mes,dia:word;i,x,z,resultado,col:Integer; fechaq,fechafin:TDate;dd,mm,yyyy,min,max,max_ant,id_unidad,codservicio:string;
total:Double;
arrayTotalDia :array of Double;
auxiliar:string;
begin
 LineasDePedidos(1,2,2045,'Lineas de pedidos',col);
//ruta.Execute;
//if(ruta.path='') then
//   begin
//    Screen.Cursor:=crDefault;
//    exit;
//   end;
//xExcel.Filename:= ruta.Path + '\Salidas '+edtCliente.Text+'.xlsx';
////nuevo:=xExcel.Filename;
//codServicio:='MN1';
//i:=1;
//x:=0;
//xExcel.Sheets[0].AsString[i,x] := 'Fecha';
//DecodeDate(dtDesde.Date,anyo,mes,dia);
//for x:=0 to daysinmonth(mes)-1 do
// begin
//  if(x<9) then xExcel.Sheets[0].AsString[i,x+1] := IntToStr(ANYO) +'-'+IntToStr(mes)+'-0'+ IntToStr(X+1)
//  else xExcel.Sheets[0].AsString[i,x+1] := IntToStr(ANYO) +'-'+IntToStr(mes)+'-'+ IntToStr(X+1)
// end;
// SetLength(arrayTotalDia,DaysInMonth(mes));
//x:=0;
//
//
//with dm.qryF_tmp do
// begin
//  CLOSE;
//  SelectSQL.Text:='select peso_min,peso_max,id_unidad from t_tarifas tar inner join g_clientes cli on cli.id_cliente=tar.id_cliente inner join t_servicios ser on ser.id_servicio=tar.id_servicio where cli.codigo='+edtcliente.Text+' and ser.codigo='+quotedstr(codservicio)+' and tar.estado=''A'' order by id_unidad asc';
//  Open;
//  First;
//  max_ant:='';
//  while not eof do
//   begin
//    id_unidad:=fieldbyname('id_unidad').AsString ;
//    min:=FieldByName('peso_min').AsString;
//    max:=FieldByName('peso_max').AsString;
//    if((max='0') and (id_unidad='2')) then
//     begin
//      min:=max_ant;
//      max:='9999';
//
//     end;
//    x:=0;
//     if((id_unidad='1')) then
//     xExcel.Sheets[0].AsString[i+1,x] := 'Lineas de '+min+' a '+max
//     //crear array
//     else if(id_unidad='2') then xExcel.Sheets[0].AsString[i+1,x] := 'Lineas extra'
//       else if(id_unidad='4')  then xExcel.Sheets[0].AsString[i+1,x] := 'Lineas';
//     xExcel.Sheets[0].AutoSizeCell(i+1,x,true,true);
//     //autowidth
//     Inc(x);
//    with dm.qry_sql do
//     begin
//     if(id_unidad='1') then
//      begin
//       SQL.Text:='select fecha,count(distinct codalbaran) as contador '+
//                 'from LineasAlmacen ' +
//                 'where codcliente='+edtcliente.Text+' and fecha between '+quotedstr(datetostr(dtdesde.date)) +' and '+quotedstr(datetostr(dthasta.date))+' and lineas between '+min+' and '+max+ '' +
//                 ' group by fecha '+
//                 'order by fecha asc';
//       Open;
//       First;
//       x:=1;
//       while (not Eof) do
//        begin
//         // resultado:=FieldByName('contador').AsInteger;
//         //CalculaTarifa( edtcliente.Text,'AL1', resultado, fechaQ);
//        //guarda en xls
//        //  xExcel.Sheets[0].AsString[i,x] := dm.qry_sql.FieldByName('fecha').AsString;
//         while (xExcel.Sheets[0].AsString[1,x]<>dm.qry_sql.FieldByName('fecha').AsString) do
//               inc(x);
//         xExcel.Sheets[0].AsInteger[i+1,x] := dm.qry_sql.FieldByName('contador').AsInteger;
//         auxiliar:=dm.qry_sql.FieldByName('fecha').AsString;
//         dd:=copy(auxiliar, 9, 2);
//         mm:=copy(auxiliar, 6, 2);
//         yyyy:=copy(auxiliar, 0, 4);
//         fechaq:=StrToDate(dd+'/'+mm+'/'+yyyy);
//         //total:=total+CalculaTarifa( edtcliente.Text,codServicio, dm.qry_sql.FieldByName('contador').AsInteger,fechaq);
//         arrayTotalDia[x]:=arrayTotalDia[x]+CalculaTarifa( edtcliente.Text,codServicio,StrToInt(min),StrToInt(max), dm.qry_sql.FieldByName('contador').AsInteger,StrToInt(id_unidad),fechaq);
//         Inc(x);
//         max_ant:=max;
//         dm.qry_sql.Next;
//        end;
//      end
//      else if id_unidad='4' then
//            begin
//             SQL.Text:='select fecha,sum(lineas) as contador '+
//                 'from LineasAlmacen ' +
//                 'where codcliente='+edtcliente.Text+' and fecha between '+quotedstr(datetostr(dtdesde.date)) +' and '+quotedstr(datetostr(dthasta.date))+' and lineas between '+min+' and '+max+ '' +
//                 ' group by fecha '+
//                 'order by fecha asc';
//             Open;
//             First;
//             x:=1;
//             while (not Eof) do
//             begin
//              while (xExcel.Sheets[0].AsString[1,x]<>dm.qry_sql.FieldByName('fecha').AsString) do
//               inc(x);
//              xExcel.Sheets[0].AsInteger[i+1,x] := dm.qry_sql.FieldByName('contador').AsInteger;
//              auxiliar:=dm.qry_sql.FieldByName('fecha').AsString;
//              dd:=copy(auxiliar, 9, 2);
//              mm:=copy(auxiliar, 6, 2);
//              yyyy:=copy(auxiliar, 0, 4);
//              fechaq:=StrToDate(dd+'/'+mm+'/'+yyyy);
//              //total:=total+CalculaTarifa( edtcliente.Text,codServicio, dm.qry_sql.FieldByName('contador').AsInteger,fechaq);
//              arrayTotalDia[x]:=arrayTotalDia[x]+CalculaTarifa( edtcliente.Text,codServicio,StrToInt(min),StrToInt(max), dm.qry_sql.FieldByName('contador').AsInteger,StrToInt(id_unidad),fechaq);
//              Inc(x);
//              max_ant:=max;
//               dm.qry_sql.Next;
//             end;
//            end
//
//     else if (id_unidad='2') then //por exceso de lineas
//      begin
//      SQL.Text:='select fecha,sum(lineas) as contador,count(distinct codalbaran) as contador2 '+
//                 'from LineasAlmacen ' +
//                 'where codcliente='+edtcliente.Text+' and fecha between '+quotedstr(datetostr(dtdesde.date)) +' and '+quotedstr(datetostr(dthasta.date))+' and lineas between '+inttostr(strtoint(min)+1)+' and '+max+ '' +
//                 'group by fecha '+
//                 'order by fecha asc';
//       Open;
//       First;
//       x:=1;
//       while (not Eof) do
//        begin
//         // resultado:=FieldByName('contador').AsInteger;
//         //CalculaTarifa( edtcliente.Text,'AL1', resultado, fechaQ);
//        //guarda en xls
//        //  xExcel.Sheets[0].AsString[i,x] := dm.qry_sql.FieldByName('fecha').AsString;
//         while (xExcel.Sheets[0].AsString[1,x]<>dm.qry_sql.FieldByName('fecha').AsString) do
//               inc(x);
//         resultado:=dm.qry_sql.FieldByName('contador').AsInteger-(strtoint(max_ant)*fieldbyname('contador2').asinteger);
//         xExcel.Sheets[0].AsInteger[i+1,x] := resultado;
//         auxiliar:=dm.qry_sql.FieldByName('fecha').AsString;
//         dd:=copy(auxiliar, 9, 2);
//         mm:=copy(auxiliar, 6, 2);
//         yyyy:=copy(auxiliar, 0, 4);
//         fechaq:=StrToDate(dd+'/'+mm+'/'+yyyy);
//        // total:=total+CalculaTarifa( edtcliente.Text,codServicio, resultado, fechaq);
//        arrayTotalDia[x]:=arrayTotalDia[x]+CalculaTarifa( edtcliente.Text,codServicio,0,0, resultado,StrToInt(id_unidad),fechaq);
//         Inc(x);
//        // max_ant:=max;
//         dm.qry_sql.Next;
//        end
//      end;
//     end;
//     Inc(i);
//     dm.qryF_tmp.Next;
//   end;
//
//   if(( id_unidad='1') or (id_unidad='2')) then
//   begin
//    xExcel.Sheets[0].asString[i+1,0] := 'Total Día';
//   for  x:=1 to Length(arrayTotalDia) do
//    begin
//     xExcel.Sheets[0].asfloat[i+1,x] := arrayTotalDia[x];
//     total:=total+arrayTotalDia[x];
//    end;
//    xExcel.Sheets[0].AsFloat[i+1,x] := total;
//   end
// end;
// //showmessage(FloatToStr(total));
// xExcel.Write;
// xExcel.CleanupInstance;
// Screen.Cursor:=crDefault;
// Showmessage('Fichero creado correctamente');
// //fechafin:=IncDay(dtHasta.date);
 end;

procedure TMain.resumenPorGrupo(id_grupo:integer);
var i:Integer;
Fecha : TDate;
Dia, Mes, Anio : Word;
raiz,nombre:string;
begin
 i:=2;
//crea el excel
 DecodeDate(dtdesde.date, Anio, Mes, Dia);
 with dm.qryF_sql do
  begin
   Close;
   SelectSQL.Text:=' select nombre from g_clientes_grupos where id_cliente_grupo='+inttostr(id_grupo);
   Open;
   nombre:=FieldByName('nombre').AsString;
  end;

 xExcelGrupo.Sheets[0].AsString[0,0] := 'FACTURACIÓN LOGÍSTICA '+ arraymeses[MonthOf(dtDesde.Date)]+'. Cliente: '+nombre;
 //xExcelGrupo.Sheets[0].AutoSizeCell(0,0,true,true);
 Inc(posicion_resumen,2);
 if(ruta.path='') then
  begin
   ruta.execute;
  // exit;
  end;
 raiz:=ruta.Path +'\ANYO '+INTTOSTR(YEARoF(dtDesde.Date))+'\'+arrayMeses[MonthOf(dtDesde.Date)]+'-'+IntToStr(YearOf(dtDesde.Date))+'\Almacen\por revisar\';
 if not DirectoryExists(raiz) then
  ForceDirectories(raiz);
 xExcelGrupo.Filename:= raiz+nombre+'-'+IntToStr(dia)+'-'+IntToStr(mes)+'-'+IntToStr(anio)+'POR_GRUPO.xlsx';

 //cabecera de la tabla
  xExcelGrupo.Sheets[0].AsString[0,1] := 'CODIGO';
  xExcelGrupo.Sheets[0].AsString[1,1] := 'NOMBRE CLIENTE';
  xExcelGrupo.Sheets[0].AsString[2,1] := 'ALMACENAJE';
  xExcelGrupo.Sheets[0].AsString[3,1] := 'ENTRADAS';
  xExcelGrupo.Sheets[0].AsString[4,1] := 'SALIDAS';
  xExcelGrupo.Sheets[0].AsString[5,1] := 'SERV. EXTRAS';
  xExcelGrupo.Sheets[0].AsString[6,1] := 'TOTAL';

 //rellenar datos
 with dm.qryF_sql do
  begin
   Close;
   SelectSQL.Text:='select cli.nombre as nombre,cli.codigo as codigo,almacen,entradas,salidas,extras from a_fact_grupos fact inner join g_clientes cli on cli.id_cliente=fact.id_cliente where fact.id_grupo='+inttostr(id_grupo)+ ' and fecha between '+quotedstr(formatdatetime('dd.mm.yyyy',dtdesde.date))+' and '+quotedstr(formatdatetime('dd.mm.yyyy',dthasta.Date))+' and fact.estado=''A'' order by codigo asc';
   Open;
   first;
   while not eof do
    begin
     xExcelGrupo.Sheets[0].asString[0,i] := FieldByName('codigo').AsString;
     xExcelGrupo.Sheets[0].asString[1,i] := FieldByName('nombre').AsString;
     xExcelGrupo.Sheets[0].AsFloat[2,i] :=  FieldByName('almacen').AsCurrency;
     xExcelGrupo.Sheets[0]. Cell[2,i].NumberFormat := '#,##0.00 €';
     xExcelGrupo.Sheets[0].AsFloat[3,i] :=  FieldByName('entradas').AsCurrency;
     xExcelGrupo.Sheets[0]. Cell[3,i].NumberFormat := '#,##0.00 €';
     xExcelGrupo.Sheets[0].AsFloat[4,i] :=  FieldByName('salidas').AsCurrency;
     xExcelGrupo.Sheets[0]. Cell[4,i].NumberFormat := '#,##0.00 €';
     xExcelGrupo.Sheets[0].AsFloat[5,i] :=  FieldByName('extras').AsCurrency;
     xExcelGrupo.Sheets[0]. Cell[5,i].NumberFormat := '#,##0.00 €';
     xExcelGrupo.Sheets[0].asFormula[6,i] := 'SUM('+Arrayletras[3]+''+inttostr(i+1)+':'+arrayLetras[6]+''+inttostr(i+1)+')';
     xExcelGrupo.Sheets[0]. Cell[6,i].NumberFormat := '#,##0.00 €';
     Inc(i);
     Next;
   end;
  end;
 xExcelGrupo.Sheets[0].asFormula[2,i] := 'SUM('+Arrayletras[3]+''+inttostr(3)+':'+arrayLetras[3]+''+inttostr(i)+')';
 xExcelGrupo.Sheets[0]. Cell[2,i].NumberFormat := '#,##0.00 €';
 xExcelGrupo.Sheets[0].asFormula[3,i] := 'SUM('+Arrayletras[4]+''+inttostr(3)+':'+arrayLetras[4]+''+inttostr(i)+')';
 xExcelGrupo.Sheets[0]. Cell[3,i].NumberFormat := '#,##0.00 €';
 xExcelGrupo.Sheets[0].asFormula[4,i] := 'SUM('+Arrayletras[5]+''+inttostr(3)+':'+arrayLetras[5]+''+inttostr(i)+')';
 xExcelGrupo.Sheets[0]. Cell[4,i].NumberFormat := '#,##0.00 €';
 xExcelGrupo.Sheets[0].asFormula[5,i] := 'SUM('+Arrayletras[6]+''+inttostr(3)+':'+arrayLetras[6]+''+inttostr(i)+')';
 xExcelGrupo.Sheets[0]. Cell[5,i].NumberFormat := '#,##0.00 €';
 xExcelGrupo.Sheets[0].asFormula[6,i] := 'SUM('+Arrayletras[7]+''+inttostr(3)+':'+arrayLetras[7]+''+inttostr(i)+')';
 xExcelGrupo.Sheets[0]. Cell[6,i].NumberFormat := '#,##0.00 €';
 xExcelGrupo.Sheets[0].AutoWidthCol(1);
 xExcelGrupo.Sheets[0].AutoWidthCol(2);
 xExcelGrupo.Sheets[0].AutoWidthCol(3);
 xExcelGrupo.Sheets[0].AutoWidthCol(4);
 xExcelGrupo.Sheets[0].AutoWidthCol(5);
 xExcelGrupo.Sheets[0].AutoWidthCol(6);
 xExcelgrupo.write;
 xExcelGrupo.CleanupInstance;
end;
procedure TMain.btnMerydeisClick(Sender: TObject);
begin
 try
    ruta.Execute;
    if(ruta.Path<>'') then
     with dm.qryF_tmp3 do
      begin
       Close;
//       SelectSQL.Text:='Select distinct(cli.codigo) as codi  from g_clientes_servicios cliser '+
//                       'inner join g_clientes cli on cli.id_cliente=cliser.id_cliente '+
//                       'inner join t_servicios ser on ser.id_servicio=cliser.id_servicio '+
//                       'inner join g_conceptos_facturables cf on cf.id_CONCEPTO_F=ser.id_CONCEPTO_F '+
//                       'inner join g_departamentos_sub sub on cf.id_departamento_sub= sub.id_departamento_sub '+
//                       'inner join g_departamentos dep on dep.id_departamento=sub.id_departamento '+
//                       'where cliser.estado=''A'' and dep.nombre=''ALMACEN'' '+
//                       'order by codi asc';
       SelectSQL.Text:='Select distinct(cli.codigo) as codi  from g_clientes_conceptos cliser '+
                       'inner join g_clientes cli on cli.id_cliente=cliser.id_cliente '+
                       'inner join g_conceptos_facturables cf on cf.id_CONCEPTO_F=cliser.id_CONCEPTO_F '+
                       'inner join t_servicios ser on ser.id_concepto_f=cf.id_concepto_f '+
                       'inner join g_departamentos_sub sub on cf.id_departamento_sub= sub.id_departamento_sub '+
                       'inner join g_departamentos dep on dep.id_departamento=sub.id_departamento '+
                       'where cli.id_cliente_grupo=6 and cliser.estado=''A'' and dep.nombre=''ALMACEN'' '+
                       'order by codi asc';
       Open;
       First;
       if(edtCliente.Text<>'') then Locate('codi',edtCliente.Text,[]);
       while not eof do
        begin
         edtCliente.Text:=dm.qryF_tmp3.FieldByName('codi').AsString;
         xExcel.Clear(1);
         xExcelResumen.Clear(1);
         xExcelGrupo.Clear(1);
         procesaAlmacenClientes;
         xExcel.Clear(1);
         xExcelResumen.Clear(1);
         xExcel.CleanupInstance;
         xExcelResumen.CleanupInstance;
         xExcelGrupo.CleanupInstance;
         Next;
        end;
      end;
    if(errores>0) then Showmessage('Ficheros creados. Hubo algún error en la ejecución, revise el LOG creado.')
    else Showmessage('Ficheros creados.');
   finally
    if(log.Count>0) then
     begin
      //raiz:=ruta.Path +'\ANYO '+INTTOSTR(YEARoF(dtDesde.Date))+'\'+arrayMeses[MonthOf(dtDesde.Date)]+'-'+IntToStr(YearOf(dtDesde.Date))+'\Almacen\';
      //if not DirectoryExists(raiz) then
      //  ForceDirectories(raiz);
      //log.SaveToFile(raiz+'LOG_INCIDENCIAS.txt');
      //AssignFile(txt,raiz+'LOG_INCIDENCIAS.txt');
     end;
    log.Free;
   end;
  end;
procedure TMain.btnprocesarTodoClick(Sender: TObject);
begin
ProcesaAlmacen;
errores:=0;
try
if(chkTodos.Checked=True) then
 begin
  ruta.Execute;
 end;
with dm.qryF_tmp3 do
 begin
  Close;
  SelectSQL.Text:='Select distinct(cli.codigo) as cod  from g_clientes_servicios cliser '+
  'inner join g_clientes cli on cli.id_cliente=cliser.id_cliente '+
  'inner join t_servicios ser on ser.id_servicio=cliser.id_servicio '+
  'inner join g_conceptos_facturables cf on cf.id_CONCEPTO_F=ser.id_CONCEPTO_F '+
  'inner join g_departamentos_sub sub on cf.id_departamento_sub= sub.id_departamento_sub '+
  'inner join g_departamentos dep on dep.id_departamento=sub.id_departamento '+
  'where cliser.estado=''A'' and dep.nombre=''ALMACEN'' '+
  'order by cod asc';
  Open;
  //if (edtcliente.text<>'') then locate
  while not eof do
   begin
    edtCliente.Text:=dm.qryF_tmp3.FieldByName('cod').AsString;
    procesaAlmacenClientes;
    //procesa;
    Next;
    //edtCliente.Text:= FieldByName('codigo').AsString;
   end;
 end;
if(chkTodos.Checked=True) then
 begin
  if(ERRORES>0) then Showmessage('Ficheros creados. Hubo algún error en la ejecución, revise el LOG creado.')
  else Showmessage('Ficheros creados.');
end;
except
 on e: exception do
  begin
   Screen.Cursor := crDefault;
   //E.Message := 'Error al crear ficheros.' + chr(13) + 'Mensaje del error: (' + e.Message + '-' + e.ClassName + ')';
   if(chktodos.Checked=True) and (e.classname<>'EOleException') then raise Exception.Create(E.Message)
   else
    if((chktodos.Checked=True) and (e.classname='EOleException')) then
     begin
      Free;
      Sleep(1000);
      xExcel.clear(1);
      xExcelResumen.clear(1);
      procesaAlmacenClientes
     end
  end;
end;
end;

procedure TMain.btnProcesaTodoClick(Sender: TObject);
begin
 Dias:=DaysBetween(dtDesde.Date,dtHasta.Date);
 ProcesaAlmacen;
end;

procedure TMain.btnResumenClick(Sender: TObject);
begin
resumenPorGrupo(6);
resumenPorGrupo(7);
end;
{*------------------------------------------------------------------------------
 Busca los servicios de almacen que tiene dado de alta el cliente y va lanzando
 los procesos que calculan la factura.
   @sender Objeto que lanza el evento
-------------------------------------------------------------------------------}
procedure TMain.procesaAlmacenClientes;
 var servicio :string;
 posicion,tipo: Integer;
 col : Integer;
 primero,errores: Integer;
begin
 //si este falla por timeout vuelve a ejecutarse, sino pasa al siguiente.
 fechaINI:=FormatDateTime('mm/dd/yyyy', dtDesde.Date);
 fechaFIN:=FormatDateTime('mm/dd/yyyy', dtHasta.Date);
 posicion_resumen:=0;
 col:=0;
 posicion:=0;
 errores:=0;
 total_factura:=0;
 total_mer_almacen:=0;
 total_mer_salidas:=0;
 total_mer_salidas_imei:=0;
 total_mer_entradas:=0;
 total_mer_extras:=0;
 total_almacen:=0;
 total_salidas:=0;
 total_salidas_imei:=0;
 total_entradas:=0;
 total_extras:=0;
 total_fijo:=0;

 tipo:=0;
 try
  xExcel.Clear(1);
  xExcelResumen.Clear(1);
  xExcelGrupo.Clear(1);
  with dm.qryF_tmp do
   begin
    Close;
   //Anterior
//   SelectSQL.Text:='select ser.codigo,ser.nombre from g_clientes_servicios cliser '+
//                   'inner join g_clientes cli on cli.id_cliente=cliser.id_cliente '+
//                   'inner join t_servicios ser on ser.id_servicio=cliser.id_servicio '+
//                   'inner join g_conceptos_facturables cf on cf.id_CONCEPTO_F=ser.id_CONCEPTO_F '+
//                   'inner join g_departamentos_sub sub on cf.id_departamento_sub= sub.id_departamento_sub '+
//                   'inner join g_departamentos dep on dep.id_departamento=sub.id_departamento '+
//                   'where cliser.estado=''A'' and dep.nombre=''ALMACEN'' and cli.codigo='+edtcliente.Text;
    SelectSQL.Text:=  'select ser.codigo,ser.nombre '+
                      'from g_clientes_conceptos cliser '+
                      ' inner join g_clientes cli on cli.id_cliente=cliser.id_cliente '+
                      ' inner join g_conceptos_facturables cf on cf.id_CONCEPTO_F=cliser.id_CONCEPTO_F '+
                      ' inner join t_servicios ser on ser.id_concepto_f=cf.id_concepto_f '+
                      ' inner join g_departamentos_sub sub on cf.id_departamento_sub= sub.id_departamento_sub  '+
                      ' inner join g_departamentos dep on dep.id_departamento=sub.id_departamento '+
                      ' where cliser.estado=''A'' and dep.nombre=''ALMACEN'' and cli.codigo='+edtcliente.Text+ ''+
                      ' order by orden ASC';
    Open;
    First;
    primero:=0;
    while not eof do
     begin
      servicio:=FieldByName('codigo').AsString;
      if(primero=0) then
       begin
        generaCabeceraCliente;
        posicion :=generaFijoMensual;
        xExcelResumen.Sheets[0].AsString[0,posicion_resumen] := 'Servicio';
        xExcelResumen.Sheets[0].AsString[1,posicion_resumen] := 'Unidades';
        //xExcelResumen.Sheets[0].Cell[2,posicion_resumen].CellColorRGB:= tablafuera ;
        xExcelResumen.Sheets[0].AsString[2,posicion_resumen] := 'Precio/Unidad';
//        xExcelResumen.Sheets[0].Cell[3,posicion_resumen].CellColorRGB:= tablafuera ;
        xExcelResumen.Sheets[0].AsString[3,posicion_resumen] := 'Precio total';
//        xExcelResumen.Sheets[0].Cell[4,posicion_resumen].CellColorRGB:= tablafuera ;
        xExcelResumen.Sheets[0].AutoSizeCell(1,posicion_resumen,true,true);
        xExcelResumen.Sheets[0].AutoSizeCell(2,posicion_resumen,true,true);
        xExcelResumen.Sheets[0].AutoSizeCell(3,posicion_resumen,true,true);
        Inc(posicion_resumen,1);
        primero:=1;
        xExcel.Write;
        xExcelResumen.Write;
        xExcel.CleanupInstance;
        xExcelResumen.CleanupInstance;
       end;
      if(servicio='AL1') then //almacenaje de pales
       begin
        Posicion:=generaXLS(posicion+4,FieldByName('nombre').Asstring);
        Next;
        xExcel.Write;
        xExcelResumen.Write;
        xExcel.CleanupInstance;
        xExcelResumen.CleanupInstance;
       end
      else if((servicio='MN1') or (servicio='MN2')) then  //preparacion de pedidos
       begin
        tipo:=quePedidosTiene;
        if((tipo=0) or (tipo=-1)) then
         LineasDePedidos(posicion+4,0,StrToInt(edtCliente.Text),FieldByName('nombre').Asstring,col)
        else if(tipo=1) then LineasDePedidosIMEI(posicion+4,0,StrToInt(edtCliente.Text),FieldByName('nombre').Asstring,col)
             else
              begin
               LineasDePedidos(posicion+4,0,StrToInt(edtCliente.Text),FieldByName('nombre').Asstring,col);
               posicion:=col;
               LineasDePedidosIMEI(posicion+4,0,StrToInt(edtCliente.Text),FieldByName('nombre').Asstring,col);
              end;
        posicion:=col;
        Next;
        xExcel.Write;
        xExcelResumen.Write;
        xExcel.CleanupInstance;
        xExcelResumen.CleanupInstance;
       end
      else if(servicio='DEV') then  //cuando sepamos el codigo, actualizar la linea.devoluciones
       begin
        Devoluciones(posicion+4,0,StrToInt(edtCliente.Text),FieldByName('nombre').Asstring,col);
        posicion:=col;
        Next;
        xExcel.Write;
        xExcelResumen.Write;
        xExcel.CleanupInstance;
        xExcelResumen.CleanupInstance;
       end
      else if(servicio='700') then  //cuando sepamos el codigo, actualizar la linea.
       begin
        DistribucionDeValijas (posicion+4,0,StrToInt(edtCliente.Text),'700',col);
        posicion:=col;
        Next;
        xExcel.Write;
        xExcelResumen.Write;
        xExcel.CleanupInstance;
        xExcelResumen.CleanupInstance;
       end
      else if(servicio='600') then
       begin
        HuecosDeEstafeta(posicion+4,0,StrToInt(edtCliente.Text),'600',col);
        posicion:=col;
        Next;
        xExcel.Write;
        xExcelResumen.Write;
        xExcel.CleanupInstance;
        xExcelResumen.CleanupInstance;
       end
      else if(servicio='3000') then  //cuando sepamos el codigo, actualizar la linea.
       begin
        RecepcionDeMaterial(posicion+4,0,StrToInt(edtCliente.Text),FieldByName('nombre').Asstring,col);
        posicion:=col;
        Next;
        xExcel.Write;
        xExcelResumen.Write;
        xExcel.CleanupInstance;
        xExcelResumen.CleanupInstance;
       end
      else
       begin
        Next;
        if(servicio<>'2013.99') then
        begin
         log.Add('El servicio '+servicio+' no se ha podido valorar porque no está implementado');
        end;
       end;
    end;
    if(primero=0) then
    begin
      generaCabeceraCliente;
      posicion :=generaFijoMensual;
      primero:=1;
      xExcel.Write;
      xExcelResumen.Write;
      xExcel.CleanupInstance;
      xExcelResumen.CleanupInstance;
    end;
   posicion:=ServiciosExtras(posicion+4,0,StrToInt(edtCliente.text),FieldByName('nombre').AsString,col);
   PrecioTotalFactura(posicion+4,0);
   if((xexcel.Filename<>'') or (xExcelResumen.Filename<>'')) then
    begin
 //  LimpiarFilas(posicion+5);
     xexcel.DefaultPaperSize:= psA4;
     xExcel.Write;
     xExcelResumen.Write;
    end;
   xExcel.CleanupInstance;
   xExcelResumen.CleanupInstance;
   if(chkTodos.Checked=False) then ShowMessage('Fichero creado');
  end;
 except
   on e: exception do
   begin
    Screen.Cursor := crDefault;
    //E.Message := 'Error al crear ficheros.' + chr(13) + 'Mensaje del error: (' + e.Message + '-' + e.ClassName + ')';
    if(chktodos.Checked=True) and (e.classname<>'EOleException') then raise Exception.Create(E.Message)
    else
     if((chktodos.Checked=True) and (e.classname='EOleException')) then
      begin
       Sleep(500);
       procesaAlmacenClientes;
      end
      else
     if(e.classname<>'EFIBClientError') then
      begin
       dm.qryF_tmp.Next;
       ProcesaAlmacen;
       end
     else
      begin
       Showmessage('reinicie el programa');
       exit;
       end;
   end;
 end;
end;
{*------------------------------------------------------------------------------
 Ejecuta una búsqueda cuando el texto del edtCliente cambia
   @sender Objeto que lanza el evento
-------------------------------------------------------------------------------}
procedure TMain.edtClienteChange(Sender: TObject);
begin
if edtCliente.Text<>'' then
 begin
  with dm.busqueda do
   begin
    Close;
    sqls.SelectSQL.clear;
    SQLs.SelectSQL.Add('SELECT ID_CLIENTE, NOMBRE FROM G_CLIENTES ' +
                       'WHERE ESTADO=''A'' AND ID_Cliente=' + edtCliente.Text);
    Open;
    lblCliente.Caption:=FieldByName('Nombre').Asstring;
    compruebaCondicionGeneral;
   end;
 end;
end;
{*------------------------------------------------------------------------------
 Al iniciar la aplicación, lanza el procedimiento leer_ini y actualiza la posición
 de la ventana respecto a la última posición registrada, además de cargar el skin.
   @sender Objeto que lanza el evento
-------------------------------------------------------------------------------}
procedure TMain.FormCreate(Sender: TObject);
begin
 leer_ini;
 semaforo_skin:=true;
 sk_manager.SkinDirectory:='C:\LGS\RESOURCES\Skins\';     //Activa el skin
 sk_manager.SkinName:=skinname;
 sk_manager.Active:=true;
 semaforo_skin:=false;
 if u_globals.x<0 then
   u_globals.x:=(Screen.width-width) div 2;
 if u_globals.y<0 then
   u_globals.y:=(Screen.height-height) div 2;
 if u_globals.w<0 then
   u_globals.w:=Width;
 if u_globals.h<0 then
   u_globals.h:=height;
 //asigna posicion
 left:=u_globals.x;
 top:=u_globals.y;
 Width:=u_globals.w;
 Height:=u_globals.h;
 lgsdb.Caption:=dm.db.DatabaseName;
 iniciarFechas;
 log:=TStringList.Create;
end;
{*------------------------------------------------------------------------------
Al cerrar la aplicación, actualiza los datos que figuran en el ini relativos a la posición de la ventana
   @sender Objeto que lanza el evento
-------------------------------------------------------------------------------}
procedure TMain.FormDestroy(Sender: TObject);
begin
 u_globals.x:=left;                                          //guardar posicion actual
 u_globals.y:=top;
 u_globals.w:=Width;                                        //guardar tamaño (si procede)
 u_globals.h:=Height;
 guardar_pos;
 u_globals.skinname:=sk_manager.SkinName;
 guardar_ini_skin;
end;
{$ENDREGION}
{$REGION 'Procedures'}
{*------------------------------------------------------------------------------
 Lanza el procedimiento GeneraCabeceras y rellena el archivo XLS con los datos extraidos de la base de datos.
@i Variable multiuso
@x Variable multiuso
@nuevo Almacena la dirección y nombre del archivo XLS
@FechaQ Fecha que aparece en el resultado de la query
@Dia Dia usado para nombre del fichero
@Mes Mes usado para nombre del fichero
@Anyo Año usado para el nombre del fichero
@di  Fecha utilizada para la posición del resultado de la query en el fichero
@cabecera Almacena el texto relativo a la cabecera vinculada a los datos de la columna del archivo XLS
@contador Contador utilizado para diferenciar los clientes
-------------------------------------------------------------------------------}
function TMain.GeneraXLS(altura_columna:Integer;servicio:string):Integer;
var
i,y,x,c,t,totexc:Integer;
nuevo:string;
exceso,totpal,precio:Double;
FechaQ:TDate;
Dia, Mes, Anyo,Anio,an,me,di:Word;
cabecera:string;
contador:integer;
almacenes:TStringList;
total_pal :array of integer;
cantidad_pales:integer;
cliente:string;
tiene,palesexceso:Integer;
begin
tiene:=0;
cantidad_pales:=0;
 setLength(total_pal,MonthDays[IsLeapYear(anyo)][mes]);
 totpal:=0;
 totexc:=0;
 result:=3+dias+altura_columna ;
 fechaINI:=FormatDateTime('mm/dd/yyyy', dtDesde.Date);
 fechaFIN:=FormatDateTime('mm/dd/yyyy', dtHasta.Date);
 DecodeDate(dtDesde.Date, Anio, Mes, Dia);
 xExcel.Sheets[0].AsString[0,altura_columna+1] := 'Fecha';
// xExcel.Sheets[0].Cell[1,altura_columna+1].CellColorRGB:= tablafuera ;
 dias:=daysbetween(dtDesde.Date,dtHasta.Date);
 cliente:=edtCliente.Text;
 if((StrToInt(cliente)>=5100) and (StrToInt(cliente)<=5200)) then cliente:='5100';
 for i := 0 to Dias do
  begin
  //Fechas
  if(i<9) then xExcel.Sheets[0].AsString[0,2+i+altura_columna] := IntToStr(Anio)+'-'+IntToStr(Mes)+'-0'+IntToStr(Dia+i)
  else xExcel.Sheets[0].AsString[0,2+i+altura_columna] := IntToStr(Anio)+'-'+IntToStr(Mes)+'-'+IntToStr(Dia+i);
  //xExcel.Sheets[0].cell[1,2+i+altura_columna].CellColorRGB:= tablafuera ;
 end;
 xExcel.Sheets[0].AsString[0,2+dias+1+altura_columna] := 'Total:';
 i:=0;
 t:=1;
 almacenes:=tstringlist.create;
 DecodeDate(dtDesde.Date,anyo,mes,dia);
 xExcel.Sheets[0].AsString[0,altura_columna] := servicio;
 if(ruta.path='') then
  begin
   Screen.Cursor:=crDefault;
   exit;
  end;
 nuevo:=xExcel.Filename;
 comparacion:='<>';
 //select de almacenes activos para el cliente dado
 with dm.qryF_tmp2 do
  begin
   Close;
   SelectSQL.Text:='select alm.codigo from g_almacenes alm inner join g_clientes_almacenes clialm on alm.id_almacen=clialm.id_almacen inner join g_clientes cli on cli.id_cliente=clialm.id_cliente where clialm.estado=''A'' and cli.codigo='+quotedstr(cliente);
   Open;
   while (not Eof) do
    begin
     almacenes.Add(FieldByName('codigo').AsString);
     next;
    end;
  end;
 i:=0;
 x:=0;
 //Buscamos si es cliente general o tiene particularidades
 with dm.qry_contador do
  begin
   Close;
   SelectSQL.Clear;
   SelectSQL.Text:=('Select count(*) as cont from g_queries where grupo=11 and estado=''A'' and descripcion like '+quotedStr(cliente+'-%'));
   Open;
   First;
   contador:=FieldByName('cont').AsInteger;
  end;
 with dm.qry_tmp do
  begin
   Close;
   SelectSQL.Text:=('Select * from g_queries where grupo=11 and estado=''A'' and descripcion like '+quotedStr('%'+cliente+'%')+ ' order by id');
   Open;
   First;
   //Si no está vacio, tiene particularidades
   if(contador>0) then
    begin
    //para cada una de los resultados, ejecutamos la query que hay.
    while not eof do
     begin
      with dm.qry_tmp2 do
       begin
        Close;
        SelectSQL.Clear;
        SelectSQL.Text:= reemplazar(dm.qry_tmp.FieldByName('query').AsString);
        cabecera:= dm.qry_tmp.FieldByName('descripcion').AsString;
        cabecera:=Copy(cabecera,Pos('-',cabecera)+1,Length(cabecera)-1);
        Open;
        First;
        x:=0;
        if(IsEmpty) then
        begin
         while(x<(Dias+1)) do
          begin
          //todo era i+2
           xExcel.Sheets[0].AsString[i+1,1+altura_columna] := cabecera;
           //xExcel.Sheets[0].Cell[i+2,1+altura_columna].CellColorRGB:= tablafuera;
           xExcel.Sheets[0].AsInteger[i+1,2+x+altura_columna] := 0;
           //xExcel.Sheets[0].Cell[i+2,2+x+altura_columna].CellColorRGB := tablafuera;
           Inc(x)
          end;
        end;
        while not EOF do
         begin
          FechaQ:=dm.qry_tmp2.FieldByName('fecha').AsDateTime;
          DecodeDate(FechaQ, an,me,di);
          xExcel.Sheets[0].AsInteger[i+1,1+di+altura_columna] := dm.qry_tmp2.FieldByName('res').AsInteger;
          //xExcel.Sheets[0].Cell[i+2,1+di+altura_columna].CellColorRGB :=tabladentro;
          inc(cantidad_pales,dm.qry_tmp2.FieldByName('res').AsInteger);
         { with tpfibdataset.create(self) do
           try
            database:=dm.dbF;
            sqls.SelectSQL.Clear;
            sqls.selectsql.Add('select peso_min,peso_max '+
                              'from t_tarifas t'+
                              'inner join g_clientes c on c.id_cliente=t.id_cliente '+
                              'where id_extra=25 and id_servicio=123 and id_unidad=1 '+
                              'and c.codigo=:cliente and t.estado=''A'' and t.fecha_ini<=:fecha_ini and t.fecha_fin>=:fecha_fin');
            parambyname('cliente').AsInteger:=StrToInt(cliente);
            parambyname('fecha_ini').AsDate:=dtDesde.Date;
            ParamByName('fecha_fin').AsDate:=dtHasta.Date;
            open;
            if not(isempty) then begin
               palesExceso:=fieldbyname('peso_max').asInteger;
               tiene:=1;
            end;
           except
            //
           end;
           }
          if(tiene=0) then
           begin
            precio:= CalculaTarifa(edtCliente.Text,'AL1',0,0,dm.qry_tmp2.FieldByName('res').AsInteger,2,fechaq);
            xExcel.Sheets[0].AsFloat[contador+2,1+di+altura_columna] :=  precio;
            xExcel.Sheets[0]. Cell[contador+2,1+di+altura_columna].NumberFormat := '#,##0.00 €';
            //xExcel.Sheets[0].cell[contador+3,1+di+altura_columna].CellColorRGB :=tabladentro;
            xExcel.Sheets[0].AsString[i+1,1+altura_columna] := cabecera;
            //xExcel.Sheets[0].cell[i+2,1+altura_columna].CellColorRGB :=tabladentro;
            totpal:=totpal+precio;
   //       total_factura:=total_factura+precio;
           end
          else
           begin
            precio:= CalculaTarifa(edtCliente.Text,'AL1',0,0,dm.qry_tmp2.FieldByName('res').AsInteger-palesExceso,2,fechaq);
            xExcel.Sheets[0].AsFloat[contador+2,1+di+altura_columna] :=  precio;
            xExcel.Sheets[0]. Cell[contador+2,1+di+altura_columna].NumberFormat := '#,##0.00 €';
            //xExcel.Sheets[0].cell[contador+3,1+di+altura_columna].CellColorRGB :=tabladentro;
            xExcel.Sheets[0].AsString[i+1,1+altura_columna] := cabecera;
            //xExcel.Sheets[0].AsString[i+2,1+altura_columna] := 'Exceso';
            //xExcel.Sheets[0].cell[i+2,1+altura_columna].CellColorRGB :=tabladentro;
            totpal:=totpal+precio;
   //       total_factura:=total_factura+precio;
           end;
          Next;
         end;
        inc(i);
        dm.qry_tmp.Next;
       end;
      //
      y:=0;
      while (y<(Dias+1)) do
       begin
        xExcel.Sheets[0].asString[contador+1,1+altura_columna] := 'Total Almacen';
        //xExcel.Sheets[0].Cell[contador+2,1+altura_columna].CellColorRGB:= tablafuera;
        xExcel.Sheets[0].asString[contador+2,1+altura_columna] := 'Precio';
        //xExcel.Sheets[0].Cell[contador+3,1+altura_columna].CellColorRGB:= tablafuera;
        xExcel.Sheets[0].asFormula[contador+1,2+y+altura_columna] := 'SUM('+Arrayletras[2]+''+inttostr(altura_columna+y+3)+':'+arrayLetras[contador]+''+inttostr(altura_columna+y+3)+')';
        //xExcel.Sheets[0].Cell[contador+2,2+y+altura_columna].CellColorRGB:= tabladentro;
        inc(y);
       end;
       //xExcel.Sheets[0].asString[contador,2+y+altura_columna] := 'Total:';
       xExcel.Sheets[0].asFormula[contador,2+y+altura_columna] := 'SUM('+Arrayletras[contador+1]+''+inttostr(3+altura_columna)+':'+arrayLetras[contador+1]+''+inttostr(2+altura_columna+y)+')';
       xExcel.Sheets[0]. Cell[contador,2+y+altura_columna].NumberFormat := '#,##0';
       xExcel.Sheets[0].asFormula[contador+1,2+y+altura_columna] := 'SUM('+Arrayletras[contador+2]+''+inttostr(3+altura_columna)+':'+arrayLetras[contador+2]+''+inttostr(2+altura_columna+y)+')';
       xExcel.Sheets[0]. Cell[contador+1,2+y+altura_columna].NumberFormat := '#,##0';
       xExcel.Sheets[0].asFormula[contador+2,2+y+altura_columna] := 'SUM('+Arrayletras[contador+3]+''+inttostr(3+altura_columna)+':'+arrayLetras[contador+3]+''+inttostr(2+altura_columna+y)+')';
       xExcel.Sheets[0]. Cell[contador+2,2+y+altura_columna].NumberFormat := '#,##0.00 €';
      end;
   end
  else
   begin
    with dm.qry_tmp3 do
     begin
      Close;
      SelectSQL.Clear;
      SelectSQL.Text:=('Select * from g_queries where grupo=11 and estado=''A'' and descripcion='+quotedStr('GENERAL'));
      Open;
      First;
     end;
    if almacenes.Count-1=0 then
     begin
      with dm.qry_tmp3 do
       begin
        Close;
        SelectSQL.Clear;
        SelectSQL.Text:=('Select * from g_queries where grupo=11 and estado=''A'' and descripcion='+quotedStr('GENERALALMACENES'));
        Open;
        First;
       end;
      with dm.qry_tmp4 do
       begin
        Close;
        SelectSQL.Clear;
        SelectSQL.Text:=reemplazar(dm.qry_tmp3.FieldByName('query').AsString);
        Open;
        First;
        x:=0;
        xExcel.Sheets[0].AsString[c*t+t,1+altura_columna] := 'Alm'+almacen;
        xExcel.Sheets[0].AsFormula[c*t+t,t+2+dias+altura_columna-c] := 'SUM('+arrayLetras[c*t+t+1]+''+inttostr(altura_columna+3)+':'+arrayLetras[c*t+t+1]+''+inttostr(altura_columna+3+dias)+')';
        xExcel.Sheets[0]. Cell[c*t+t,t+2+dias+altura_columna-c].NumberFormat := '#,##0';
        xExcel.Sheets[0].AsString[c*t+1+t,1+altura_columna] := 'EXCESO';
        //suma exceso
        xExcel.Sheets[0].AsFormula[c*t+1+t,t+2+dias+altura_columna-c] := 'SUM('+arrayLetras[c*t+1+t+1]+''+inttostr(altura_columna+3)+':'+arrayLetras[c*t+1+t+1]+''+inttostr(altura_columna+3+dias)+')';
        xExcel.Sheets[0]. Cell[c*t+1+t,t+2+dias+altura_columna-c].NumberFormat :=  '#,##0';
        xExcel.Sheets[0].AsString[c*t+2+t,1+altura_columna] := 'IMP. EXCESO';
        //suma dinero
        xExcel.Sheets[0].AsFormula[c*t+2+t,t+2+dias+altura_columna-c] := 'SUM('+arrayLetras[c*t+2+t+1]+''+inttostr(altura_columna+3)+':'+arrayLetras[c*t+2+t+1]+''+inttostr(altura_columna+3+dias)+')';
        xExcel.Sheets[0]. Cell[c*t+2+t,t+2+dias+altura_columna-c].NumberFormat := '#,##0.00 €';
        xExcel.Sheets[0].AutoSizeCell(c*t+t,1+altura_columna,true,true);
        xExcel.Sheets[0].AutoSizeCell(c*t+2+t+altura_columna,1,true,true);
        result:=altura_columna+3+dias;
        di:=1;
        if(IsEmpty) then
         begin
          while(x<(Dias+1)) do
           begin
            //xExcel.Sheets[0].AsInteger[c+1*t+t,2+x+altura_columna] := 0;
            Inc(x)
           end;
         end;
        while not EOF do
         begin
          xExcel.Sheets[0].AutoWidthCol(1);
          FechaQ:=dm.qry_tmp4.FieldByName('fecha').AsDateTime;
          xExcel.Sheets[0].AsInteger[c*t+t,1+di+altura_columna] := dm.qry_tmp4.FieldByName('res').AsInteger;
          //el servicio será el que se le asigne a "almacen de palets"
          inc(cantidad_pales,dm.qry_tmp4.FieldByName('res').AsInteger);
          exceso:=dm.qry_tmp4.FieldByName('res').AsInteger-CalculaExceso(edtCliente.Text,'AL1');
          inc(totexc,round(exceso));
          if(exceso>0) then
           begin
            xExcel.Sheets[0].AsFloat[c*t+1+t,1+di+altura_columna]:=exceso;
           end
          else //xExcel.Sheets[0].AsFloat[c+1*t+1+t,1+di+altura_columna]:=0;
           xExcel.Sheets[0].AsFloat[c*t+1+t,1+di+altura_columna]:=0;
          xExcel.Sheets[0].AsFloat[c*t+2+t,1+di+altura_columna]:=CalculaTarifa(edtCliente.Text,'AL1',0,0,dm.qry_tmp4.FieldByName('res').AsInteger,2,fechaq);
          xExcel.Sheets[0]. Cell[c*t+2+t,1+di+altura_columna].NumberFormat := '#,##0.00 €';
          totpal:=totpal+CalculaTarifa(edtCliente.Text,'AL1',0,0,dm.qry_tmp4.FieldByName('res').AsInteger,2,fechaq);
          Next;
          Inc(DI);
         end;
        inc(t);
        result:=3+dias+altura_columna ;
        //xExcel.Sheets[0].asFormula[c+1*t+2+t,1+di+altura_columna-1] := 'SUM('+Arrayletras[c+1*t+2]+''+inttostr(2+altura_columna)+':'+arrayLetras[c+1*t+2+t]+''+inttostr(2+altura_columna+y)+')';
       end;
     end
    else
      for c := 0 to almacenes.Count-1 do
       begin
        almacen:=almacenes[c];
         with dm.qry_tmp4 do
          begin
           Close;
           SelectSQL.Clear;
           SelectSQL.Text:=reemplazar(dm.qry_tmp3.FieldByName('query').AsString);
           Open;
           First;
           x:=0;
           xExcel.Sheets[0].AsString[c*t+t,1+altura_columna] := 'Alm'+almacen;
           xExcel.Sheets[0].AsFormula[c*t+t,t+2+dias+altura_columna-c] := 'SUM('+arrayLetras[c*t+t+1]+''+inttostr(altura_columna+3)+':'+arrayLetras[c*t+t+1]+''+inttostr(altura_columna+3+dias)+')';
           xExcel.Sheets[0]. Cell[c*t+t,t+2+dias+altura_columna-c].NumberFormat := '#,##0';
           xExcel.Sheets[0].AsString[c*t+1+t,1+altura_columna] := 'EXCESO';
           //suma exceso
           xExcel.Sheets[0].AsFormula[c*t+1+t,t+2+dias+altura_columna-c] := 'SUM('+arrayLetras[c*t+1+t+1]+''+inttostr(altura_columna+3)+':'+arrayLetras[c*t+1+t+1]+''+inttostr(altura_columna+3+dias)+')';
           xExcel.Sheets[0]. Cell[c*t+1+t,t+2+dias+altura_columna-c].NumberFormat :=  '#,##0';
           xExcel.Sheets[0].AsString[c*t+2+t,1+altura_columna] := 'IMP. EXCESO';
           //suma dinero
           xExcel.Sheets[0].AsFormula[c*t+2+t,t+2+dias+altura_columna-c] := 'SUM('+arrayLetras[c*t+2+t+1]+''+inttostr(altura_columna+3)+':'+arrayLetras[c*t+2+t+1]+''+inttostr(altura_columna+3+dias)+')';
           xExcel.Sheets[0]. Cell[c*t+2+t,t+2+dias+altura_columna-c].NumberFormat := '#,##0.00 €';
           xExcel.Sheets[0].AutoSizeCell(c*t+t,1+altura_columna,true,true);
           xExcel.Sheets[0].AutoSizeCell(c*t+2+t+altura_columna,1,true,true);
           result:=altura_columna+3+dias;
           di:=1;
           if(IsEmpty) then
            begin
             while(x<(Dias+1)) do
              begin
               //xExcel.Sheets[0].AsInteger[c+1*t+t,2+x+altura_columna] := 0;
               Inc(x)
              end;
            end;
           while not EOF do
            begin
             xExcel.Sheets[0].AutoWidthCol(1);
             FechaQ:=dm.qry_tmp4.FieldByName('fecha').AsDateTime;
             xExcel.Sheets[0].AsInteger[c*t+t,1+di+altura_columna] := dm.qry_tmp4.FieldByName('res').AsInteger;
             //el servicio será el que se le asigne a "almacen de palets"
             inc(cantidad_pales,dm.qry_tmp4.FieldByName('res').AsInteger);
             exceso:=dm.qry_tmp4.FieldByName('res').AsInteger-CalculaExceso(edtCliente.Text,'AL1');
             inc(totexc,round(exceso));
              if(exceso>0) then
               begin
                xExcel.Sheets[0].AsFloat[c*t+1+t,1+di+altura_columna]:=exceso;
               end
              else //xExcel.Sheets[0].AsFloat[c+1*t+1+t,1+di+altura_columna]:=0;
                xExcel.Sheets[0].AsFloat[c*t+1+t,1+di+altura_columna]:=0;
             xExcel.Sheets[0].AsFloat[c*t+2+t,1+di+altura_columna]:=CalculaTarifa(edtCliente.Text,'AL1',0,0,dm.qry_tmp4.FieldByName('res').AsInteger,2,fechaq);
             xExcel.Sheets[0]. Cell[c*t+2+t,1+di+altura_columna].NumberFormat := '#,##0.00 €';
             totpal:=totpal+CalculaTarifa(edtCliente.Text,'AL1',0,0,dm.qry_tmp4.FieldByName('res').AsInteger,2,fechaq);
             Next;
             Inc(DI);
            end;
           inc(t);
           result:=3+dias+altura_columna ;
           //xExcel.Sheets[0].asFormula[c+1*t+2+t,1+di+altura_columna-1] := 'SUM('+Arrayletras[c+1*t+2]+''+inttostr(2+altura_columna)+':'+arrayLetras[c+1*t+2+t]+''+inttostr(2+altura_columna+y)+')';
          end;
       end;
   end;
  if(totpal<>0) and (cantidad_pales<>0) then
   begin
    xExcelResumen.Sheets[0].AsString[0,posicion_resumen]:='Almacenaje de palés';
    //xExcelResumen.Sheets[0].Cell[1,posicion_resumen].CellColorRGB:= tablafuera ;
    xExcel.Sheets[0].AutoSizeCell(0,posicion_resumen,true,true);
    xExcelResumen.Sheets[0].AutoSizeCell(0,posicion_resumen,true,true);
    if contador>0 then xExcelResumen.Sheets[0].AsFloat[1,posicion_resumen]:= cantidad_pales
    else xExcelResumen.Sheets[0].AsFloat[1,posicion_resumen]:= totexc;
    //xExcelResumen.Sheets[0].Cell[2,posicion_resumen].CellColorRGB:= tabladentro ;
    xExcelResumen.Sheets[0].AsFloat[2,posicion_resumen]:= totpal/cantidad_pales;
    xExcelResumen.Sheets[0]. Cell[2,posicion_resumen].NumberFormat := '#,##0.00 €';
   //xExcelResumen.Sheets[0].Cell[3,posicion_resumen].CellColorRGB:= tabladentro ;
    xExcelResumen.Sheets[0].asFloat[3,posicion_resumen]:= totpal;
    xExcelResumen.Sheets[0]. Cell[3,posicion_resumen].NumberFormat := '#,##0.00 €';
   // xExcelResumen.Sheets[0].Cell[4,posicion_resumen].BorderTopStyle:= cbsMedium;
   // xExcelResumen.Sheets[0].Cell[4,posicion_resumen].BorderTopStyle.cbsDouble:=True;
   //xExcelResumen.Sheets[0].Cell[4,posicion_resumen].CellColorRGB:= tabladentro ;
    Inc(posicion_resumen,1);
    total_mer_almacen:=totpal;
    total_almacen:=totpal;
    total_factura:=total_factura+totpal;
   end;
  //xExcel.Write;
  //xExcelResumen.Write;
  almacenes.Destroy;
  Screen.Cursor:=crDefault;
 end;
end;
{*------------------------------------------------------------------------------
 Ejecuta la valoración de servicios de almacen
-------------------------------------------------------------------------------}
procedure Tmain.ProcesaAlmacen;
var raiz:string;
begin
if(chkTodos.Checked=False) then
 begin
  try
   ruta.Execute;
   if(ruta.Path<>'') then
    begin
     procesaAlmacenClientes;
     xExcel.clear(1);
     xExcelResumen.Clear(1);
    end;
   if(errores>0) then Showmessage('No se ha creado el fichero.Hubo algún error en la ejecución, revise el LOG creado.') ;
   finally
   if(log.Count>0) then
    begin
      raiz:=ruta.Path +'\ANYO '+INTTOSTR(YEARoF(dtDesde.Date))+'\'+arrayMeses[MonthOf(dtDesde.Date)]+'-'+IntToStr(YearOf(dtDesde.Date))+'\Almacen\';
      if not DirectoryExists(raiz) then
        ForceDirectories(raiz);
     log.SaveToFile(raiz+'LOG_INCIDENCIAS.txt');
     AssignFile(txt,raiz+'LOG_INCIDENCIAS.txt');
    end;
   log.Free;
  end;
 end
 else
  begin
   try
    ruta.Execute;
    if(ruta.Path<>'') then
     with dm.qryF_tmp3 do
      begin
       Close;
//       SelectSQL.Text:='Select distinct(cli.codigo) as codi  from g_clientes_servicios cliser '+
//                       'inner join g_clientes cli on cli.id_cliente=cliser.id_cliente '+
//                       'inner join t_servicios ser on ser.id_servicio=cliser.id_servicio '+
//                       'inner join g_conceptos_facturables cf on cf.id_CONCEPTO_F=ser.id_CONCEPTO_F '+
//                       'inner join g_departamentos_sub sub on cf.id_departamento_sub= sub.id_departamento_sub '+
//                       'inner join g_departamentos dep on dep.id_departamento=sub.id_departamento '+
//                       'where cliser.estado=''A'' and dep.nombre=''ALMACEN'' '+
//                       'order by codi asc';
       SelectSQL.Text:='Select distinct(cli.codigo) as codi  from g_clientes_conceptos cliser '+
                       'inner join g_clientes cli on cli.id_cliente=cliser.id_cliente '+
                       'inner join g_conceptos_facturables cf on cf.id_CONCEPTO_F=cliser.id_CONCEPTO_F '+
                       'inner join t_servicios ser on ser.id_concepto_f=cf.id_concepto_f '+
                       'inner join g_departamentos_sub sub on cf.id_departamento_sub= sub.id_departamento_sub '+
                       'inner join g_departamentos dep on dep.id_departamento=sub.id_departamento '+
                       'where cliser.estado=''A'' and dep.nombre=''ALMACEN'' and cli.codigo not between 200 and 300 '+
                       'order by codi asc';
       Open;
       First;
       if(edtCliente.Text<>'') then Locate('codi',edtCliente.Text,[]);
       while not eof do
        begin
         edtCliente.Text:=dm.qryF_tmp3.FieldByName('codi').AsString;
         xExcel.Clear(1);
         xExcelResumen.Clear(1);
         procesaAlmacenClientes;
         xExcel.Clear(1);
         xExcelResumen.Clear(1);
         xExcel.CleanupInstance;
         xExcelResumen.CleanupInstance;
         Next;
        end;
      end;
    if(errores>0) then Showmessage('Ficheros creados. Hubo algún error en la ejecución, revise el LOG creado.')
     else Showmessage('Ficheros creados.');
   finally
    if(log.Count>0) then
     begin
      raiz:=ruta.Path +'\ANYO '+INTTOSTR(YEARoF(dtDesde.Date))+'\'+arrayMeses[MonthOf(dtDesde.Date)]+'-'+IntToStr(YearOf(dtDesde.Date))+'\Almacen\';
      if not DirectoryExists(raiz) then
        ForceDirectories(raiz);
      log.SaveToFile(raiz+'LOG_INCIDENCIAS.txt');
      AssignFile(txt,raiz+'LOG_INCIDENCIAS.txt');
     end;
    log.Free;
   end;
  end;
end;
{*------------------------------------------------------------------------------
  Calcula la tarifa para el servicio dado según la tarifa del cliente
-------------------------------------------------------------------------------}
function TMain.precioTotalFactura(fila: Integer; columna: Integer):integer;
var grupo:Integer;
begin
grupo:=0;
 xExcel.Sheets[0].asString[columna,fila] := 'TOTAL FACTURA:'+(FormatFloat('#,##0.00',total_factura))+'€';
 //xExcel.Sheets[0].Cell[columna,fila].CellColorRGB:= 808000 ;
 xExcelResumen.Sheets[0].asString[0,posicion_resumen] := 'TOTAL FACTURA:'+(FormatFloat('#,##0.00',total_factura))+'€';
 //xExcelResumen.Sheets[0].Cell[1,posicion_resumen].CellColorRGB:= 808000 ;
 Inc(posicion_resumen,1);
 xExcel.write;
 xExcelResumen.write;
 xExcel.CleanupInstance;
 xExcelResumen.CleanupInstance;
//una vez esta toda la factura hecha, si es de grupo merydeis se inserta en la tabla para sacar, después, una hoja con todos los subclientes.
 dm.qry_grupoCliente.close;
 dm.qry_grupoCliente.selectsql.text:=' select id_cliente_grupo from g_clientes where codigo='+edtcliente.text;
 dm.qry_grupoCliente.open;
 grupo:= dm.qry_grupoCliente.fieldbyname('id_cliente_grupo').asInteger;

 if (grupo=6)then
 begin
  dm.t_writeF.StartTransaction;
  try
  if total_factura>0 then
   with dm.spInsertaMerydeis do
    begin
     Close;
     ParamByName('id_grupo').AsInteger:=grupo;
     ParamByName('cod_cliente').AsInteger:=StrToInt(edtCliente.Text);
     ParamByName('fecha_fact').AsDate:=dtHasta.Date;
     ParamByName('almacen').AsCurrency:= total_mer_almacen;
     ParamByName('entradas').AsCurrency:= total_mer_entradas;
     ParamByName('salidas').AsCurrency:= total_mer_salidas_imei+total_mer_salidas;
     ParamByName('extras').AsCurrency:= total_mer_extras ;
     ParamByName('modif_fecha').AsDateTime:= now ;
     ParamByName('modif_usuario').asInteger:= id_usuario;
     ExecProc;
     dm.t_writeF.Commit;
    end;
  except
   dm.t_writeF.rollbackretaining;
  end;
 end
 else begin
   dm.t_writeF.StartTransaction;
  try
  if total_factura>0 then
   with dm.spInsertaMerydeis do
    begin
     Close;
     ParamByName('id_grupo').AsInteger:=grupo;
     ParamByName('cod_cliente').AsInteger:=StrToInt(edtCliente.Text);
     ParamByName('fecha_fact').AsDate:=dtHasta.Date;
     ParamByName('almacen').AsCurrency:= total_almacen;
     ParamByName('entradas').AsCurrency:= total_entradas;
     ParamByName('salidas').AsCurrency:= total_salidas_imei+total_salidas;
     ParamByName('extras').AsCurrency:= total_extras ;
     ParamByName('modif_fecha').AsDateTime:= now ;
     ParamByName('modif_usuario').asInteger:= id_usuario;
     ExecProc;
     dm.t_writeF.Commit;
    end;
  except
   dm.t_writeF.rollbackretaining;
  end;
 end;
end;

function TMain.CalculaTarifa(cliente: string; servicio: string; min,max, cantidad: Double;id_unidad:Integer; fecha:TDate):double;
begin
with dm.Calcula do
 begin
  StoredProcName := 'C_GET_TARIFA_ALMACEN';
  ParamByName('cliente').AsInteger:=StrToInt(cliente);
  ParamByName('servicio').AsString:=servicio;
  ParamByName('concepto').AsInteger:=25;
  ParamByName('fecha').AsDateTime:=fecha;
  ParamByName('mini').AsDouble:=min;
  ParamByName('maxi').AsDouble:=max;
  ParamByName('unidades_a_valorar').AsDouble:=cantidad;
  ParamByName('ID_UNI').AsInteger:= id_unidad;
  ExecProc;
  if(FieldByName('tarificado').AsFloat>0) then
   result:= ParamByName('tarificado').AsFloat
  else result:=0.00;
 end;
end;
{*------------------------------------------------------------------------------
Calcula las unidades maximas para el cliente y servicios pasadas por parametro
@cliente identificador de cliente
@servicio codigo del servicio
@return unidades
-------------------------------------------------------------------------------}
function TMain.CalculaExceso(cliente: string; servicio: string):double;
begin
 with dm.Calcula do
  begin
   StoredProcName := 'C_TAR_GET_MAX_UNIDADES';
   ParamByName('cli').AsInteger:=StrToInt(cliente);
   ParamByName('servicio').AsString:=servicio;
   ParamByName('fecha').AsDate:=dtDesde.Date;
   ExecProc;
   if(FieldByName('maximo').AsFloat>0) then
   result:= ParamByName('maximo').AsFloat;
  end;
end;
{*------------------------------------------------------------------------------
Inicializa los valores de las fechas por defecto a mes anterior
-------------------------------------------------------------------------------}
procedure TMain.iniciarFechas;
begin
 if(MonthOf(now)=1) then
  begin
    dtDesde.Date:=EncodeDate(YearOf(now)-1,12,1);
    dthasta.Date:=EndOfAMonth(YearOf(now)-1,12);
  end
 else begin
  dtdesde.date:=EncodeDate(YearOf(now), MonthOf(now)-1, 1);
  dthasta.Date:=EndOfAMonth(YearOf(Now),(MonthOf(Now)-1));
 end;
end;
{*------------------------------------------------------------------------------
  Genera la cabecera básica del fichero XLS
  @i Variable multiuso
  @fecha Fecha inicial
  @dia Dia
  @mes Mes
  @anio Anyo
-------------------------------------------------------------------------------}
procedure TMain.GeneraCabeceraXLS(altura_cabecera:integer);
var i:Integer;
Fecha : TDate;
Dia, Mes, Anio : Word;
begin
 xExcel.Sheets[0].AsString[0,0] := 'Facturación logística '+uppercase(arrayMeses[MonthOf(dtDesde.Date)]);
 xExcel.Sheets[0].AsString[1,0] := 'Cliente';
 xExcel.Sheets[0].AsString[2,0] := edtcliente.Text+'-'+lblcliente.caption;
 end;
{*------------------------------------------------------------------------------
  Genera la cabecera básica del fichero XLS
  @i   Variable multiuso
  @fecha Fecha inicial
  @dia Dia
  @mes Mes
  @anio Anyo
-------------------------------------------------------------------------------}
function TMain.GeneraCabeceraCliente:integer;
var i:Integer;
Fecha : TDate;
Dia, Mes, Anio : Word;
raiz:string;
begin
 DecodeDate(dtdesde.date, Anio, Mes, Dia);
 xExcel.Sheets[0].AsString[0,0] := 'FACTURACIÓN LOGÍSTICA '+ arraymeses[MonthOf(dtDesde.Date)]+'. Cliente: '+edtcliente.Text+'-'+lblcliente.caption;
 //xExcel.Sheets[0].AsString[1,0] := lblcliente.caption;
 xExcel.Sheets[0].AutoSizeCell(0,0,true,true);
 xExcelResumen.Sheets[0].AsString[0,0] := 'FACTURACIÓN LOGÍSTICA '+ arraymeses[MonthOf(dtDesde.Date)]+'. Cliente: '+edtcliente.Text+'-'+lblcliente.caption;
// xExcelResumen.Sheets[0].AsString[0,1] := 'Cliente :';
 xExcelResumen.Sheets[0].AutoSizeCell(0,0,true,true);
 Inc(posicion_resumen,2);
 if(ruta.path='') then
  begin
   Screen.Cursor:=crDefault;
   exit;
  end;
 raiz:=ruta.Path +'\ANYO '+INTTOSTR(YEARoF(dtDesde.Date))+'\'+arrayMeses[MonthOf(dtDesde.Date)]+'-'+IntToStr(YearOf(dtDesde.Date))+'\Almacen\por revisar\';
 if not DirectoryExists(raiz) then
  ForceDirectories(raiz);
 xExcel.Filename:= raiz+edtCliente.Text+'-'+lblcliente.caption+'-'+IntToStr(dia)+'-'+IntToStr(mes)+'-'+IntToStr(anio)+'.xlsx';
 xExcelResumen.Filename:= raiz+edtCliente.Text+'-'+lblcliente.caption+'-'+IntToStr(dia)+'-'+IntToStr(mes)+'-'+IntToStr(anio)+'Res.xlsx';
end;
{*------------------------------------------------------------------------------
  Genera , si tiene, la cabecera con la descripción de lo que incluye el fijo
  mensual del cliente y el precio fijo que tiene contratado.
  @i   Variable multiuso
  @fechai Fecha inicial
  @fechaf Fecha final
  @id variable para guardar el numero identificador de la tarifa
  @descripcion variable para guardar la descripcion del fijo mensual
  @nota tstringlist para poder separar la descripcion por el simbolo *
-------------------------------------------------------------------------------}
function Tmain.GeneraFijoMensual:integer;
var i:integer; descripcion,id,fechai,fechaf:string;nota:tstringlist;
begin
 fechai:=stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase]);
 fechaf:=stringreplace(datetostr(dthasta.date),  '/', '.',[rfReplaceAll, rfIgnoreCase]);
with dm.qryF_tmp4 do
 begin
  Close;
  SelectSQL.Text:='select descripcion,tafi.id_tarifa from t_tarifas_fijos tafi inner join t_tarifas tar on tar.id_tarifa=tafi.id_tarifa inner join g_clientes cli on cli.id_cliente=tar.id_cliente where cli.codigo='+edtcliente.Text+' and fecha_ini<='+quotedstr(fechai)+' and fecha_fin>='+quotedstr(fechaf)+' and tafi.estado=''A'' and tar.estado=''A''';
  Open;
  if not eof then
   begin
    descripcion:=FieldByName('descripcion').AsString;
    id:=FieldByName('id_tarifa').AsString;
    nota := TStringList.Create;
    ExtractStrings(['*'], [' '], PChar(descripcion), nota);
    for i := 0 to nota.Count-1 do
     begin
      xExcel.Sheets[0].AsString[0,i+2] := nota[i];
      xExcelResumen.Sheets[0].AsString[0,posicion_resumen] := nota[i];
      //xExcel.Sheets[0].Cell[1,i+2].CellColorRGB:= tablafuera ;
      //xExcelResumen.Sheets[0].Cell[1,posicion_resumen].CellColorRGB:= tablafuera ;
      Inc(posicion_resumen,1);
     end;
    Result := i;
   end
  else
   Result:= 1;
 end;
 if(Result>1) then
  begin
   with dm.qryF_tmp4 do
    begin
     Close;
     SelectSQL.Text:='select tarifa from t_tarifas tar where id_tarifa='+id;
     Open;
     if not eof then
      begin
       xExcel.Sheets[0].AsString[0,result+2] := 'Precio fijo :' +FormatFloat('0.00', FieldByName('tarifa').AsFloat )+ '€';
       total_factura:=total_factura+fieldbyname('tarifa').AsFloat;
       xExcelResumen.Sheets[0].AsString[0,posicion_resumen]:='Servicio fijo'+FormatFloat('#,##0.00', FieldByName('tarifa').AsFloat )+ '€' ;
// xExcelResumen.Sheets[0].Cell[1,posicion_resumen].CellColorRGB:= tablafuera ;
       xExcelResumen.Sheets[0].AutoSizeCell(0,posicion_resumen,true,true);
      //xExcelResumen.Sheets[0].AsString[1,posicion_resumen]:=FormatFloat('#,##0.00', FieldByName('tarifa').AsFloat )+ '€';
//xExcel.Sheets[0].Cell[1,result+2].CellColorRGB:= tablafuera ;
       Inc(posicion_resumen,1);
       total_fijo:= fieldbyname('tarifa').AsFloat;
      end;
     Result := result+1;
    end
  end;
end;
{*------------------------------------------------------------------------------
  Comprueba si cumple ser un cliente general. Si no lo es, bloquea el checkpanel
-------------------------------------------------------------------------------}
procedure TMain.compruebaCondicionGeneral;
begin
with dm.qry_contador do
 begin
  Close;
  SelectSQL.Clear;
  SelectSQL.Text:=('Select count(*) as cont from g_queries where grupo=11 and estado=''A'' and descripcion like '+quotedStr(''+edtcliente.Text+'-%'));
  Open;
  First;
  contador:=FieldByName('cont').AsInteger;
 end;
if contador>0 then
 chkAlmacen.Enabled:=False
else chkAlmacen.Enabled:=True;
Refresh;
end;
{$ENDREGION}
{$REGION 'Funciones'}
{*------------------------------------------------------------------------------
  Genera la estructura y rellena los datos del cliente con las devoluciones que se han creado en el mes a facturar
-------------------------------------------------------------------------------}
function tmain.devoluciones(fila: Integer; columna: Integer; codCliente: Integer; servicio: string; out col: Integer):Integer;
var i,m,f,c,inicio,contador:integer;codservicio:string;
precio:Double;
suma_precio:Double;
begin
 try
  codServicio:='DEV';
  contador:=0;
  c:=columna;
  f:=fila;
  xExcel.Sheets[0].AsString[c,f] := servicio;
  //Inc(c);
  inc(f);
  xExcel.Sheets[0].AsString[c,f] := 'Fecha';
//  xExcel.Sheets[0].Cell[c,f].CellColorRGB:= tablafuera ;
  Inc(c);
//  xExcel.Sheets[0].AsString[c,f] := 'Pedido';
//  xExcel.Sheets[0].Cell[c,f].CellColorRGB:= tablafuera ;
//  Inc(c);
  xExcel.Sheets[0].AsString[c,f] := 'Unidades';
//  xExcel.Sheets[0].Cell[c,f].CellColorRGB:= tablafuera ;
  Inc(c);
  xExcel.Sheets[0].AsString[c,f] := 'Importe';
  //xExcel.Sheets[0].Cell[c,f].CellColorRGB:= tablafuera ;
  Inc(f);
  inicio:=f;
  with dm.qry_Devoluciones do
   begin
    Close;
    ParamByName('f1').AsDate := dtDesde.Date;
    ParamByName('f2').AsDate := dtHasta.Date;
    ParamByName('id').AsInteger := StrToInt(edtCliente.Text);
    Open;
    First;
    while not eof do
     begin
      xExcel.Sheets[0].AsString[c-2,f] := dm.qry_Devoluciones.FieldByName('fecha').asString;//fecha;
      //xExcel.Sheets[0].AsFloat[c-2,f] :=dm.qry_Devoluciones.FieldByName('order_name').AsFloat;//expedicion esto es order name?;
      contador:=contador+dm.qry_Devoluciones.FieldByName('uds').AsInteger;//Unidades
      xExcel.Sheets[0].AsFloat[c-1,f] := dm.qry_Devoluciones.FieldByName('uds').AsFloat;//Unidades
      precio:=CalculaTarifa(IntToStr(codcliente),codservicio,0,0,dm.qry_Devoluciones.FieldByName('uds').AsInteger,1,dtdesde.Date);
      xExcel.Sheets[0].AsFloat[c,f] :=precio;
      xExcel.Sheets[0]. Cell[c,f].NumberFormat := '#,##0.00 €';
      total_factura:=total_factura+precio;
      suma_precio:=suma_precio+precio;
      Next;
      Inc(f);
     end;
    xExcel.Sheets[0].AsString[c-2,f] := 'Total:';
    //xExcel.Sheets[0].AsFormula[c-2,f] := 'SUM('+arrayLetras[c-1]+''+inttostr(inicio)+':'+arrayLetras[c-1]+''+inttostr(f)+')';
    xExcel.Sheets[0].AsFormula[c-1,f] := 'SUM('+arrayLetras[c]+''+inttostr(inicio)+':'+arrayLetras[c]+''+inttostr(f)+')';
    xExcel.Sheets[0].AsFormula[c,f] := 'SUM('+arrayLetras[c+1]+''+inttostr(inicio)+':'+arrayLetras[c+1]+''+inttostr(f)+')';
    xExcelResumen.Sheets[0].AsString[0,posicion_resumen]:='Total devoluciones';
//    xExcelResumen.Sheets[0].Cell[1,posicion_resumen].CellColorRGB:= tablafuera ;
  // xExcelResumen.Sheets[0].AutoSizeCell(1,posicion_resumen,true,true);
    xExcelResumen.Sheets[0].AsFloat[1,posicion_resumen]:= contador;
//    xExcelResumen.Sheets[0].Cell[2,posicion_resumen].CellColorRGB:= tabladentro ;
    xExcelResumen.Sheets[0].AsString[2,posicion_resumen]:= '';
//    xExcelResumen.Sheets[0].Cell[3,posicion_resumen].CellColorRGB:= tabladentro ;
    xExcelResumen.Sheets[0].asFloat[3,posicion_resumen]:= suma_precio;
    xExcelResumen.Sheets[0]. Cell[3,posicion_resumen].NumberFormat := '#,##0.00 €';
//    xExcelResumen.Sheets[0].Cell[4,posicion_resumen].CellColorRGB:= tabladentro ;
    inc(posicion_resumen,1);
    Result:=f;
    col:=f;
   end;
  except
   on e:exception do
    begin
     log.Add('Las devoluciones del cliente '+edtcliente.text+ '-'+lblcliente.Caption+' no se han calculado por algún problema.('+e.message+')');
     Inc(errores);
    end;
 end;
end;
{*------------------------------------------------------------------------------
  Genera la estructura (y rellena los datos) del cliente pasado por parametro, del servicio "Distribucion de valijas".
 -------------------------------------------------------------------------------}
function TMain.DistribucionDeValijas(fila: Integer; columna: Integer; codCliente: Integer; servicio: string; out col: Integer):integer;
var i,m,id_unidad,contador:integer;
precio:Double;
begin
try
 i:=fila;
 m:=columna;
 contador:=0;
 xExcel.Sheets[0].AsString[m,i] := 'Distribución de valijas';
 Inc(i);
 xExcel.Sheets[0].AsString[m+1,i] := 'Tipo de Valija';
 xExcel.Sheets[0].AsString[m+2,i] := 'Cantidad';
 xExcel.Sheets[0].AsString[m+3,i] := 'Precio Total';
 inc(i);
 //Caixa ontinyent huecos estafeta
 with dm.qry_aux do
  begin
   Close;
   //query de valijas contratadas por el cliente caixa popular. id_cliente puede tomarse como parametro para los distintos clientes que usen estafeta
   SQLs.SelectSQL.Text:= 'select char_length (dias_semana) as dias, tip.nombre,count(distinct(id_valija)) as contador ' +
                         'from g_clientes cli ' +
                         'inner join g_delegaciones del on del.id_cliente=cli.id_cliente ' +
                         'inner join v_valijas val on val.id_delegacion=del.id_delegacion ' +
                         'inner join v_tipos_valijas tip on val.id_tipo_valija=tip.id_tipo_valija ' +
                         'where del.id_cliente='+inttostr(codcliente)+' and del.estado=''A'' and val.estado=''A'' '+
                         'group by dias,nombre';
   Open;
   while not eof do
    begin
    //guardar descripcion (dias a la semana)
    //calcular precio (calculaTarifa)
     xExcel.Sheets[0].AsString[m,i] := 'Valijas de '+dm.qry_aux.FieldByName('dias').asString+ ' dias';
     xExcel.Sheets[0].AsString[m+1,i] := dm.qry_aux.FieldByName('nombre').AsString;
     xExcel.Sheets[0].AsInteger[m+2,i] := dm.qry_aux.FieldByName('contador').asInteger;
     if(dm.qry_aux.FieldByName('dias').asString='2') then id_unidad:=11
     else if(dm.qry_aux.FieldByName('dias').asString='4') then id_unidad:=16
      else if(dm.qry_aux.FieldByName('dias').asString='5') then id_unidad:=12;
     precio:=CalculaTarifa(IntToStr(codcliente),servicio,0,0,dm.qry_aux.FieldByName('contador').AsInteger,id_unidad,dtdesde.Date);
     xExcel.Sheets[0].AsFloat[m+3,i] :=precio;
     xExcel.Sheets[0]. Cell[m+3,i].NumberFormat := '#,##0.00 €';
     Next;
     inc(contador);
     Inc(i);
     total_estafeta:=total_estafeta+precio;
    end;
   xExcel.Sheets[0].asString[m+1,i] := 'Total';
   xExcel.Sheets[0].AsFormula[m+2,i] := 'SUM('+Arrayletras[m+3]+''+inttostr(i-contador+1)+':'+arrayLetras[m+3]+''+inttostr(i)+')';      //total de valijas
   xExcel.Sheets[0].AsFormula[m+3,i] := 'SUM('+Arrayletras[m+4]+''+inttostr(i-contador+1)+':'+arrayLetras[m+4]+''+inttostr(i)+')';      //total de importe
   xExcel.Sheets[0]. Cell[m+3,i].NumberFormat := '#,##0.00 €';
   total_factura:=total_factura+total_estafeta;
   Result:=i;
   col:=i;
 end;
except
 on e:Exception do
  begin
   log.Add('La distribución de valijas del cliente '+edtcliente.text+ '-'+lblcliente.Caption+' no se ha calculado por algún problema('+e.message+')');
   Inc(errores);
  end;
end;
end;
{*------------------------------------------------------------------------------
  Genera la estructura (y rellena los datos) del cliente pasado por parametro, del servicio "Huecos de estafeta".
 -------------------------------------------------------------------------------}
function TMain.HuecosDeEstafeta(fila: Integer; columna: Integer; codCliente: Integer; servicio: string; out col: Integer): integer;
var i,m:Integer;
tarifa:Double;
begin
 try
  i:=fila;
  m:=columna;
  xExcel.Sheets[0].AsString[m,i] := 'Servicio de estafeta';
  Inc(i);
  with dm.qry_aux do
   begin
    //query de huecos estafeta para otra funcion
    Close;
    SQLs.SelectSQL.Text:='select count (id_valija) as contador '+
                         'from g_clientes cli  '+
                         'inner join g_delegaciones del on del.id_cliente=cli.id_cliente '+
                         'inner join v_valijas val on val.id_delegacion=del.id_delegacion '+
                         'where del.id_cliente='+INTTOSTR(CODCLIENTE)+' and del.estado=''A'' and val.estado=''A''';
    Open;
    if not eof then
     begin
      tarifa:=CalculaTarifa(IntToStr(codcliente),servicio,0,0,dm.qry_aux.FieldByName('contador').AsInteger,11,dtdesde.Date);
      xExcel.Sheets[0].AsString[m,i] := 'Total de huecos';
      xExcel.Sheets[0].AsInteger[m+1,i] := dm.qry_aux.FieldByName('contador').AsInteger;
      xExcel.Sheets[0].AsString[m,i+1] := 'Precio Hueco/Mes';
      xExcel.Sheets[0].AsFloat[m+1,i+1] :=  tarifa/dm.qry_aux.FieldByName('contador').AsInteger;
      xExcel.Sheets[0]. Cell[m+1,i+1].NumberFormat := '#,##0.00 €';
      xExcel.Sheets[0].AsString[m,i+2] := 'Total Estafeta';
      xExcel.Sheets[0].AsFloat[m+1,i+2] := tarifa;
      xExcel.Sheets[0]. Cell[m+1,i+2].NumberFormat := '#,##0.00 €';
      Inc(i);
     end;
    Result:=m;
    col:=i+2;
   end;
 except
  on e:Exception do
   begin
    log.Add('Los huecos de estafeta del cliente '+edtcliente.text+ '-'+lblcliente.Caption+' no se han calculado por algún problema.('+e.message+')');
    Inc(errores);
   end;
 end;
end;
//MODIFICADO
{*------------------------------------------------------------------------------
  Genera la estructura (y rellena los datos) del cliente pasado por parametro, del servicio "Lineas de pedidos".
 -------------------------------------------------------------------------------}
function TMain.LineasDePedidos(fila,columna,codCliente:Integer;servicio:string;out col:integer):Integer ;
var
 anyo,mes,dia:word;
 i,j,x,z,m,resultado,altura_cabecera,anchura_cabecera:Integer; fechaq,fechafin:TDate;
 dd,mm,yyyy,id_unidad_ant,min,min_ant,max,max_ant,id_unidad,codservicio:string;
 total,total_linea_ped:Double;
 contexceso:Integer;
 arrayTotalDia :array of Double;
 cont_ant :array of integer;
 auxiliar,mesString:string;
 fecha,limit:string;
 tot4:Double;
 cantidad_lineas:Integer;
begin
 try
  total_linea_ped:=0;
  cantidad_lineas:=0;
  //hay que ver si el cliente es caixa popular, calcular los costes imputables, porcentaje de coste y promedio de lineas al dia
  fechaINI:=FormatDateTime('dd.mm.yyyy', dtDesde.Date);
  if(ruta.path='') then
   begin
    ruta.Execute;
    Screen.Cursor:=crDefault;
    xExcel.Filename:= ruta.Path + '\Salidas '+edtCliente.Text+'.xlsx';
    //exit;
   end;
  altura_cabecera:=fila;
  anchura_cabecera:=columna;
  codServicio:='MN1';
  i:=anchura_cabecera;
  j:=altura_cabecera;
  xExcel.Sheets[0].AsString[i,j] := servicio;
  //Inc(i);
  inc(j);
  xExcel.Sheets[0].AsString[i,j] := 'Fecha';
//  xExcel.Sheets[0].Cell[i,j].CellColorRGB:= tablafuera ;
  DecodeDate(dtDesde.Date,anyo,mes,dia);
  if(mes<10) then mesString:='0'+inttostr(mes)
  else mesString:=inttostr(mes);
  for z:=0 to MonthDays[IsLeapYear(anyo)][mes]-1 do
   begin
    if(z<9) then xExcel.Sheets[0].AsString[i,j+z+1] := IntToStr(ANYO) +'-'+mesString+'-0'+ IntToStr(z+1)
    else xExcel.Sheets[0].AsString[i,j+z+1] := IntToStr(ANYO) +'-'+mesString+'-'+ IntToStr(z+1);
    inc(x);
    xExcel.Sheets[0].AutoSizeCell(i,j+z+1,true,true);
//    xExcel.Sheets[0].cell[i,j+z+1].CellColorRGB:= tablafuera ;
   end;
  xExcel.Sheets[0].AsString[i,j+z+1] :=' Total:';
  i:=anchura_cabecera+1;
  j:=altura_cabecera+1;
  SetLength(arrayTotalDia,MonthDays[IsLeapYear(anyo)][mes]);
  SetLength(cont_ant,MonthDays[IsLeapYear(anyo)][mes]);
  with dm.qryF_tmp2 do
   begin
    CLOSE;
    SelectSQL.Text:='select peso_min,peso_max,id_unidad from t_tarifas tar inner join g_clientes cli on cli.id_cliente=tar.id_cliente inner join t_servicios ser on ser.id_servicio=tar.id_servicio where ID_UNIDAD<>2 and cli.codigo='+edtcliente.Text+' and ser.codigo='+quotedstr(codservicio)+' and tar.estado=''A'' and tar.fecha_fin>='+quotedstr(StringReplace(fechaINI,'/','.',[rfReplaceAll, rfIgnoreCase]))+' and tar.fecha_ini<='+quotedstr(StringReplace(fechaINI,'/','.',[rfReplaceAll, rfIgnoreCase]))+' order by id_unidad,peso_min asc';
    Open;
    First;
    max_ant:='';
    min_ant:='';
    while not eof do
     begin
      id_unidad:=dm.qryF_tmp2.Fieldbyname('id_unidad').AsString ;
      min:=dm.qryF_tmp2.fieldByName('peso_min').AsString;
      max:=dm.qryF_tmp2.FieldByName('peso_max').AsString;
      if((id_unidad='1')) then
       begin
        xExcel.Sheets[0].AsString[i,j] := 'Lineas de '+min+' a '+max;      //Lineas de x a y
        xExcel.Sheets[0].AsFormula[i,j+z+1] := 'SUM('+Arrayletras[i+1]+''+inttostr(altura_cabecera+3)+':'+arrayLetras[i+1]+''+inttostr(altura_cabecera+dias+3)+')';   //total de pedidos
       end
      else if(id_unidad='4')  then xExcel.Sheets[0].AsString[i,j] := 'Lineas'  //Lineas a cascoporro
       else if(id_unidad='8') then
        begin
         xExcel.Sheets[0].AsString[i,j] := 'Pedidos';          //pedidos a cascoporro
         xExcel.Sheets[0].AsFormula[i,j+z+1] := 'SUM('+Arrayletras[i+1]+''+inttostr(altura_cabecera+3)+':'+arrayLetras[i+1]+''+inttostr(altura_cabecera+dias+3)+')';   //total de pedidos
         xExcel.Sheets[0].AsFormula[i+1,j+z+1] := 'SUM('+Arrayletras[i+2]+''+inttostr(altura_cabecera+3)+':'+arrayLetras[i+2]+''+inttostr(altura_cabecera+dias+3)+')';      //total de importe
         xExcel.Sheets[0].Cell[i+1,j+z+1].NumberFormat := '#,##0.00 €';
        end
       else if(id_unidad='7') then
        begin
         xExcel.Sheets[0].AsString[i,j] := 'Unidades de '+min+' a '+max;  //unidades de x a y
         xExcel.Sheets[0].AsFormula[i,j+z+1] := 'SUM('+Arrayletras[i+1]+''+inttostr(altura_cabecera+3)+':'+arrayLetras[i+1]+''+inttostr(altura_cabecera+dias+3)+')';   //total de pedidos
        end
       else if(id_unidad='9') then    //utiliza el id_unidad 9 para diferenciarlos, en la tabla de tarifas usa los otros id para sacar la tarifa
        begin
         xExcel.Sheets[0].AsString[i,j] := 'Pedidos';
         xExcel.Sheets[0].AsString[i+1,j] := 'Palés';
         xExcel.Sheets[0].AsString[i+2,j] := 'Total';
         xExcel.Sheets[0].AsFormula[i,j+z+1] := 'SUM('+Arrayletras[i+1]+''+inttostr(altura_cabecera+3)+':'+arrayLetras[i+1]+''+inttostr(altura_cabecera+dias+3)+')';   //total de pedidos
         xExcel.Sheets[0].AsFormula[i+1,j+z+1] := 'SUM('+Arrayletras[i+2]+''+inttostr(altura_cabecera+3)+':'+arrayLetras[i+2]+''+inttostr(altura_cabecera+dias+3)+')';   //total de pedidos
         xExcel.Sheets[0].AsFormula[i+2,j+z+1] := 'SUM('+Arrayletras[i+3]+''+inttostr(altura_cabecera+3)+':'+arrayLetras[i+3]+''+inttostr(altura_cabecera+dias+3)+')';
         xExcel.Sheets[0]. Cell[i+2,j+z+1].NumberFormat := '#,##0.00 €';
        end;
      xExcel.Sheets[0].AutoSizeCell(i,j,true,true);
      //xExcel.Sheets[0].Cell[i,j].CellColorRGB:= tablafuera ;
//      with dm.qry_sql do
//       begin
//        if(id_unidad='1') then
//         begin
//          CLOSE;
//          fecha:=Copy(datetostr(dthasta.date),0,10);
//          SQL.Text:='select fecha,count(distinct codalbaran) as contador '+
//                    'from LineasAlmacen ' +
//                    'where codcliente='+edtcliente.Text+' and fecha between '+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and '+quotedstr(stringreplace(datetostr(dtHasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]))+' and lineas between '+min+' and '+max+ ' ' +
//                  //' where codcliente=6830 and fecha between ''29/04/2018'' and ''30/04/2018'' and lineas between 1 and 3' +
//                    ' group by fecha '+
//                    ' order by fecha asc';
//          Open;
//          First;
//          m:=altura_cabecera+2;
//          while (not Eof) do
//           begin
//            while (xExcel.Sheets[0].AsString[anchura_cabecera+1,m]<>dm.qry_sql.FieldByName('fecha').AsString) do
//             begin
//              xExcel.Sheets[0].AsInteger[i,m] := 0;
//              cont_ant[m-j-1]:=0;
//              inc(m);
//             end;
//            xExcel.Sheets[0].AsInteger[i,m] := dm.qry_sql.FieldByName('contador').AsInteger;
//            auxiliar:=dm.qry_sql.FieldByName('fecha').AsString;
//            dd:=copy(auxiliar, 9, 2);
//            mm:=copy(auxiliar, 6, 2);
//            yyyy:=copy(auxiliar, 0, 4);
//            fechaq:=StrToDate(dd+'/'+mm+'/'+yyyy);
//            if(m<Length(arraytotaldia)-1) then
//             begin
//              arrayTotalDia[m-j-1]:=arrayTotalDia[m-j-1]+CalculaTarifa( edtcliente.Text,codServicio,StrToInt(min),StrToInt(max), dm.qry_sql.FieldByName('contador').AsInteger,StrToInt(id_unidad),fechaq);
//             end
//            else
//             begin
//              arrayTotalDia[m-j-1]:=arrayTotalDia[m-j-1]+CalculaTarifa( edtcliente.Text,codServicio,StrToInt(min),StrToInt(max), dm.qry_sql.FieldByName('contador').AsInteger,StrToInt(id_unidad),fechaq);
//             end;
//            cont_ant[m-j-1]:=dm.qry_sql.FieldByName('contador').AsInteger;
//            //arrayTotalDia[m-j-daysinmonth(mes)]:=arrayTotalDia[m-j-daysinmonth(mes)]+CalculaTarifa( edtcliente.Text,codServicio,StrToInt(min),StrToInt(max), dm.qry_sql.FieldByName('contador').AsInteger,StrToInt(id_unidad),fechaq);
//            Inc(col);Inc(m);
//            //Inc(x);
//            id_unidad_ant:=id_unidad;
//            min_ant:=min;
//            max_ant:=max;
//            dm.qry_sql.Next;
//           end;
//         end
//        else if id_unidad='4' then
//         begin
//          try
//           CLOSE;
//           m:=j+1;
//           SQL.Text:='select fecha,sum(lineas) as contador '+
//                     'from LineasAlmacen ' +
//                     'where codcliente='+edtcliente.Text+' and fecha between '+quotedstr(datetostr(dtdesde.date)) +' and '+quotedstr(datetostr(dthasta.date))+
//                     ' group by fecha '+
//                     'order by fecha asc';
//           Open;
//           First;
//           while (not Eof) do
//            begin
//             while (xExcel.Sheets[0].AsString[anchura_cabecera+1,m]<>dm.qry_sql.FieldByName('fecha').AsString) do
//              begin
//               inc(m);
//              end;
//             xExcel.Sheets[0].AsInteger[i,m] := dm.qry_sql.FieldByName('contador').AsInteger;
//             auxiliar:=dm.qry_sql.FieldByName('fecha').AsString;
//             total:=total+dm.qry_sql.FieldByName('contador').AsInteger;
//             dd:=copy(auxiliar, 9, 2);
//             mm:=copy(auxiliar, 6, 2);
//             yyyy:=copy(auxiliar, 0, 4);
//             fechaq:=StrToDate(dd+'/'+mm+'/'+yyyy);
//             //total:=total+CalculaTarifa( edtcliente.Text,codServicio, dm.qry_sql.FieldByName('contador').AsInteger,fechaq);
//             arrayTotalDia[m-j-1]:=arrayTotalDia[m-j-1]+CalculaTarifa( edtcliente.Text,codServicio,StrToInt(min),StrToInt(max), dm.qry_sql.FieldByName('contador').AsInteger,StrToInt(id_unidad),fechaq);
//             //total_factura:=total_factura++CalculaTarifa( edtcliente.Text,codServicio,StrToInt(min),StrToInt(max), dm.qry_sql.FieldByName('contador').AsInteger,StrToInt(id_unidad),fechaq);
//             cont_ant[m-j-1]:=dm.qry_sql.FieldByName('contador').AsInteger;
//             Inc(x);Inc(col);
//             id_unidad_ant:=id_unidad;
//             min_ant:=min;
//             max_ant:=max;
//             dm.qry_sql.Next;
//            end;
//          except
//           on e:Exception do
//            begin
//             log.Add('Las lineas de pedidos del cliente '+edtcliente.text+ '-'+lblcliente.Caption+' no se han calculado por algún problema.('+e.message+')');
//             Inc(errores);
//            end;
//          end;
//         end;
//       end;
     with dm.qryPreparacionPedidos do
       begin
        if(id_unidad='1') then
         begin
          close;
          fecha:=Copy(datetostr(dthasta.date),0,10);
          dm.qryF_limite.Close;
          dm.qryF_limite.SelectSQL.Text:=' select peso_max '+
                                         ' from t_tarifas t inner join g_clientes c on c.id_cliente=t.id_cliente '+
                                         ' where id_extra=25 and id_servicio=124 and id_unidad=2 and peso_max>0 and codigo='+edtcliente.Text+' and fecha_ini<='+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and  fecha_fin>='+quotedstr(stringreplace(datetostr(dtHasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]));
          dm.qryF_limite.Open;
          if(dm.qryF_limite.fieldbyname('peso_max').AsString<>'') then
           begin
            SelectSQL.Text:='select fecha,count(distinct alb_cliente) as contador '+
                            'from A_PREPARACION_PEDIDOS ' +
                            'where id_cliente='+edtcliente.Text+' and fecha between '+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and '+quotedstr(stringreplace(datetostr(dtHasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]))+' and lineas between '+min+' and '+max+ ' ' +
                            ' and alb_cliente not in (select first 75 alb_cliente from A_PREPARACION_PEDIDOS WHERE id_cliente='+edtcliente.Text+' and fecha between '+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and '+quotedstr(stringreplace(datetostr(dtHasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]))+')'+
                            ' group by fecha '+
                            ' order by fecha asc';
           end
          else begin
                 SelectSQL.Text:='select fecha,count(distinct alb_cliente) as contador '+
                                 'from A_PREPARACION_PEDIDOS ' +
                                 'where id_cliente='+edtcliente.Text+' and fecha between '+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and '+quotedstr(stringreplace(datetostr(dtHasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]))+' and lineas between '+min+' and '+max+ ' ' +
                                 ' group by fecha '+
                                 ' order by fecha asc';
          end;
          Open;
          First;
          m:=altura_cabecera+2;
          while (not Eof) do
           begin
           //anchura cabecera+1
            while (xExcel.Sheets[0].AsString[anchura_cabecera,m]<>FormatDateTime('yyyy-mm-dd',dm.qryPreparacionPedidos.FieldByName('fecha').asDateTime)) do
             begin
             // xExcel.Sheets[0].AsFloat[i,m] := 0.00;
              cont_ant[m-j-1]:=0;
              inc(m);
             end;

            xExcel.Sheets[0].AsInteger[i,m] := dm.qryPreparacionPedidos.FieldByName('contador').AsInteger;
            if(m<Length(arraytotaldia)-1) then
             begin
              arrayTotalDia[m-j-1]:=arrayTotalDia[m-j-1]+CalculaTarifa( edtcliente.Text,codServicio,StrToInt(min),StrToInt(max), dm.qryPreparacionPedidos.FieldByName('contador').AsInteger,StrToInt(id_unidad),dm.qryPreparacionPedidos.FieldByName('fecha').AsDateTime);
             end
            else
             begin
              arrayTotalDia[m-j-1]:=arrayTotalDia[m-j-1]+CalculaTarifa( edtcliente.Text,codServicio,StrToInt(min),StrToInt(max), dm.qryPreparacionPedidos.FieldByName('contador').AsInteger,StrToInt(id_unidad),dm.qryPreparacionPedidos.FieldByName('fecha').AsDateTime);
             end;
            Inc(cantidad_lineas,dm.qryPreparacionPedidos.FieldByName('contador').AsInteger);
            cont_ant[m-j-1]:=dm.qryPreparacionPedidos.FieldByName('contador').AsInteger;
            //arrayTotalDia[m-j-daysinmonth(mes)]:=arrayTotalDia[m-j-daysinmonth(mes)]+CalculaTarifa( edtcliente.Text,codServicio,StrToInt(min),StrToInt(max), dm.qry_sql.FieldByName('contador').AsInteger,StrToInt(id_unidad),fechaq);
            Inc(col);Inc(m);
            //Inc(x);
          //  xExcel.Sheets[0].AsFormula[i,m] := 'SUM('+Arrayletras[i-1]+''+inttostr(2+altura_cabecera)+':'+arrayLetras[i-1]+''+inttostr(2+altura_cabecera+m)+')';
            id_unidad_ant:=id_unidad;
            min_ant:=min;
            max_ant:=max;
            dm.qryPreparacionPedidos.Next;
           end;
         end
        else if id_unidad='4' then
         begin
          try
           CLOSE;
           m:=j+1;
           dm.qryF_limite.Close;
           dm.qryF_limite.SelectSQL.Text:=' select peso_max '+
                                          ' from t_tarifas t inner join g_clientes c on c.id_cliente=t.id_cliente '+
                                          ' where id_extra=25 and id_servicio=124 and id_unidad=2 and peso_max>0 and codigo='+edtcliente.Text+' and fecha_ini<='+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and  fecha_fin>='+quotedstr(stringreplace(datetostr(dtHasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]));
           dm.qryF_limite.Open;
           if(dm.qryF_limite.fieldbyname('peso_max').AsString<>'') then
            begin
             SelectSQL.Text:='select fecha,SUM(lineas) as contador '+
                             'from A_PREPARACION_PEDIDOS ' +
                             'where ID_Cliente='+edtcliente.Text+' and fecha between '+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and '+quotedstr(stringreplace(datetostr(dthasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]))+
                             ' and imei=0 '+
                             ' and alb_cliente not in (select first 75 alb_cliente from A_PREPARACION_PEDIDOS WHERE id_cliente='+edtcliente.Text+' and fecha between '+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and '+quotedstr(stringreplace(datetostr(dtHasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]))+' order by fecha asc)'+
                             ' group by fecha '+
                             ' order by fecha asc';
            end
           else begin
                 SelectSQL.Text:='select fecha,SUM(lineas) as contador '+
                                 'from A_PREPARACION_PEDIDOS ' +
                                 'where ID_Cliente='+edtcliente.Text+' and fecha between '+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and '+quotedstr(stringreplace(datetostr(dthasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]))+
                                 ' and imei=0 '+
                                 ' group by fecha '+
                                 ' order by fecha asc';
           end;
           Open;
           First;
           while (not Eof) do
            begin
            //anchura_cabecera+1
             while (xExcel.Sheets[0].AsString[anchura_cabecera,m]<>FormatDateTime('yyyy-mm-dd',dm.qryPreparacionPedidos.FieldByName('fecha').asDateTime)) do
              begin
              // xExcel.Sheets[0].AsInteger[i,m] := dm.qryPreparacionPedidos.FieldByName('contador').AsInteger;
               inc(m);
              end;
             xExcel.Sheets[0].AsInteger[i,m] := dm.qryPreparacionPedidos.FieldByName('contador').AsInteger;
             total:=total+dm.qryPreparacionPedidos.FieldByName('contador').AsInteger;
             Inc(cantidad_lineas,dm.qryPreparacionPedidos.FieldByName('contador').AsInteger);
             arrayTotalDia[m-j-1]:=arrayTotalDia[m-j-1]+CalculaTarifa( edtcliente.Text,codServicio,StrToInt(min),StrToInt(max), dm.qryPreparacionPedidos.FieldByName('contador').AsInteger+1,StrToInt(id_unidad),dm.qryPreparacionPedidos.FieldByName('fecha').AsDateTime);
             cont_ant[m-j-1]:=dm.qryPreparacionPedidos.FieldByName('contador').AsInteger;
             Inc(x);Inc(col);
             id_unidad_ant:=id_unidad;
             min_ant:=min;
             max_ant:=max;
             dm.qryPreparacionPedidos.Next;
            end;
          except
           on e:Exception do
            begin
             log.Add('Las lineas de pedidos del cliente '+edtcliente.text+ '-'+lblcliente.Caption+' no se han calculado por algún problema.('+e.message+')');
             Inc(errores);
            end;
          end;
         end
        else if(id_unidad='8') then
         begin
          close;
          fecha:=Copy(datetostr(dthasta.date),0,10);
          dm.qryF_limite.Close;
          dm.qryF_limite.SelectSQL.Text:=' select peso_max '+
                                         ' from t_tarifas t inner join g_clientes c on c.id_cliente=t.id_cliente '+
                                         ' where id_extra=25 and id_servicio=124 and id_unidad=2 and peso_max>0 and codigo='+edtcliente.Text+' and fecha_ini<='+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and  fecha_fin>='+quotedstr(stringreplace(datetostr(dtHasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]));
          dm.qryF_limite.Open;
          if(dm.qryF_limite.fieldbyname('peso_max').AsString<>'') then
           begin
            SelectSQL.Text:='select fecha,count(distinct alb_cliente) as contador '+
                            'from A_PREPARACION_PEDIDOS ' +
                            'where id_cliente='+edtcliente.Text+' and fecha between '+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and '+quotedstr(stringreplace(datetostr(dtHasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]))+' ' +
                            ' and alb_cliente not in (select first 75 alb_cliente from A_PREPARACION_PEDIDOS WHERE id_cliente='+edtcliente.Text+' and fecha between '+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and '+quotedstr(stringreplace(datetostr(dtHasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]))+' order by fecha asc)'+
                            ' group by fecha '+
                            ' order by fecha asc';
           end
          else
           begin
             SelectSQL.Text:='select fecha,count(distinct alb_cliente) as contador '+
                            'from A_PREPARACION_PEDIDOS ' +
                            'where id_cliente='+edtcliente.Text+' and fecha between '+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and '+quotedstr(stringreplace(datetostr(dtHasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]))+' ' +
                            ' group by fecha '+
                            ' order by fecha asc';
           end;
          Open;
          First;
          m:=altura_cabecera+2;
          while (not Eof) do
           begin
           //anchura cabecera+1
            while (xExcel.Sheets[0].AsString[anchura_cabecera,m]<>FormatDateTime('yyyy-mm-dd',dm.qryPreparacionPedidos.FieldByName('fecha').asDateTime)) do
             begin
             // xExcel.Sheets[0].AsFloat[i,m] := 0.00;
              //cont_ant[m-j-1]:=0;
              inc(m);
             end;

            xExcel.Sheets[0].AsInteger[i,m] := dm.qryPreparacionPedidos.FieldByName('contador').AsInteger;

            if(m<Length(arraytotaldia)-1) then
             begin
              arrayTotalDia[m-j-1]:=arrayTotalDia[m-j-1]+CalculaTarifa( edtcliente.Text,codServicio,StrToInt(min),StrToInt(max), dm.qryPreparacionPedidos.FieldByName('contador').AsInteger,StrToInt(id_unidad),dm.qryPreparacionPedidos.FieldByName('fecha').AsDateTime);
             end
            else
             begin
              arrayTotalDia[m-j-1]:=arrayTotalDia[m-j-1]+CalculaTarifa( edtcliente.Text,codServicio,StrToInt(min),StrToInt(max), dm.qryPreparacionPedidos.FieldByName('contador').AsInteger,StrToInt(id_unidad),dm.qryPreparacionPedidos.FieldByName('fecha').AsDateTime);
             end;
             xExcel.Sheets[0].AsFloat[i+1,m] := arrayTotalDia[m-j-1];
            Inc(cantidad_lineas,dm.qryPreparacionPedidos.FieldByName('contador').AsInteger);
            cont_ant[m-j-1]:=dm.qryPreparacionPedidos.FieldByName('contador').AsInteger;
            //arrayTotalDia[m-j-daysinmonth(mes)]:=arrayTotalDia[m-j-daysinmonth(mes)]+CalculaTarifa( edtcliente.Text,codServicio,StrToInt(min),StrToInt(max), dm.qry_sql.FieldByName('contador').AsInteger,StrToInt(id_unidad),fechaq);
            Inc(col);Inc(m);
            //Inc(x);
            //xExcel.Sheets[0].AsFormula[i,m] := 'SUM('+Arrayletras[i-1]+''+inttostr(2+altura_cabecera)+':'+arrayLetras[i-1]+''+inttostr(2+altura_cabecera+m)+')';

            id_unidad_ant:=id_unidad;
            min_ant:=min;
            max_ant:=max;
            dm.qryPreparacionPedidos.Next;
           end;
         end
        else if (id_unidad='7') then
          begin
           Close;
           fecha:=Copy(datetostr(dthasta.date),0,10);
           dm.qryF_limite.Close;
           dm.qryF_limite.SelectSQL.Text:=' select peso_max '+
                                          ' from t_tarifas t inner join g_clientes c on c.id_cliente=t.id_cliente '+
                                          ' where id_extra=25 and id_servicio=124 and id_unidad=2 and peso_max>0 and codigo='+edtcliente.Text+' and fecha_ini<='+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and  fecha_fin>='+quotedstr(stringreplace(datetostr(dtHasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]));
           dm.qryF_limite.Open;
           if(dm.qryF_limite.fieldbyname('peso_max').AsString<>'') then
            begin
           //   SelectSQL.Text:='select fecha,count(distinct alb_cliente) as contador '+
             SelectSQL.Text:='select fecha,count(cantidad) as contador '+
                             'from A_PREPARACION_PEDIDOS ' +
                             'where id_cliente='+edtcliente.Text+' and fecha between '+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and '+quotedstr(stringreplace(datetostr(dtHasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]))+' and cantidad between '+min+' and '+max+ ' ' +
                             ' and alb_cliente not in (select first 75 alb_cliente from A_PREPARACION_PEDIDOS WHERE id_cliente='+edtcliente.Text+' and fecha between '+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and '+quotedstr(stringreplace(datetostr(dtHasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]))+' order by fecha asc)'+
                             ' group by fecha '+
                             ' order by fecha asc';
            end
           else
            begin //si es por unidades, no se cuentan los albaranes, se cuentan las cantidades de casa cosa
             SelectSQL.Text:='select fecha,count(cantidad) as contador '+
                             'from A_PREPARACION_PEDIDOS ' +
                             'where id_cliente='+edtcliente.Text+' and fecha between '+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and '+quotedstr(stringreplace(datetostr(dtHasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]))+' and cantidad between '+min+' and '+max+ ' ' +
                             ' group by fecha '+
                             ' order by fecha asc';
//                 SelectSQL.Text:='select fecha,count(distinct alb_cliente) as contador '+
//                                 'from A_PREPARACION_PEDIDOS ' +
//                                 'where id_cliente='+edtcliente.Text+' and fecha between '+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and '+quotedstr(stringreplace(datetostr(dtHasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]))+' and cantidad between '+min+' and '+max+ ' ' +
//                                 ' group by fecha '+
//                                 ' order by fecha asc';
            end;
           Open;
           First;
           m:=altura_cabecera+2;
           while (not Eof) do
            begin
            //anchura cabecera+1
             while (xExcel.Sheets[0].AsString[anchura_cabecera,m]<>FormatDateTime('yyyy-mm-dd',dm.qryPreparacionPedidos.FieldByName('fecha').asDateTime)) do
              begin
              // xExcel.Sheets[0].AsFloat[i,m] := 0.00;
               cont_ant[m-j-1]:=0;
               inc(m);
              end;
             xExcel.Sheets[0].AsInteger[i,m] := dm.qryPreparacionPedidos.FieldByName('contador').AsInteger;
             if(m<Length(arraytotaldia)-1) then
              begin
               arrayTotalDia[m-j-1]:=arrayTotalDia[m-j-1]+CalculaTarifa( edtcliente.Text,codServicio,StrToInt(min),StrToInt(max), dm.qryPreparacionPedidos.FieldByName('contador').AsInteger,StrToInt(id_unidad),dm.qryPreparacionPedidos.FieldByName('fecha').AsDateTime);
              end
             else
             begin
              arrayTotalDia[m-j-1]:=arrayTotalDia[m-j-1]+CalculaTarifa( edtcliente.Text,codServicio,StrToInt(min),StrToInt(max), dm.qryPreparacionPedidos.FieldByName('contador').AsInteger,StrToInt(id_unidad),dm.qryPreparacionPedidos.FieldByName('fecha').AsDateTime);
             end;
            Inc(cantidad_lineas,dm.qryPreparacionPedidos.FieldByName('contador').AsInteger);
            //Inc(cantidad_lineas,1);
            cont_ant[m-j-1]:=dm.qryPreparacionPedidos.FieldByName('contador').AsInteger;
            //arrayTotalDia[m-j-daysinmonth(mes)]:=arrayTotalDia[m-j-daysinmonth(mes)]+CalculaTarifa( edtcliente.Text,codServicio,StrToInt(min),StrToInt(max), dm.qry_sql.FieldByName('contador').AsInteger,StrToInt(id_unidad),fechaq);
            Inc(col);Inc(m);
            //Inc(x);
            //  xExcel.Sheets[0].AsFormula[i,m] := 'SUM('+Arrayletras[i-1]+''+inttostr(2+altura_cabecera)+':'+arrayLetras[i-1]+''+inttostr(2+altura_cabecera+m)+')';
            id_unidad_ant:=id_unidad;
            min_ant:=min;
            max_ant:=max;
            dm.qryPreparacionPedidos.Next;
           end;
         end
        else
         if id_unidad='9' then
          begin
           close;
           fecha:=Copy(datetostr(dthasta.date),0,10);
           dm.qryF_limite.Close;
           dm.qryF_limite.SelectSQL.Text:=' select peso_max '+
                                          ' from t_tarifas t inner join g_clientes c on c.id_cliente=t.id_cliente '+
                                          ' where id_extra=25 and id_servicio=124 and id_unidad=2 and peso_max>0 and codigo='+edtcliente.Text+' and fecha_ini<='+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and  fecha_fin>='+quotedstr(stringreplace(datetostr(dtHasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]));
           dm.qryF_limite.Open;
           if(dm.qryF_limite.fieldbyname('peso_max').AsString<>'') then
            begin
             SelectSQL.Text:='select fecha,sum(pales) as contador '+
                             'from A_PREPARACION_PEDIDOS ' +
                             'where id_cliente='+edtcliente.Text+' and fecha between '+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and '+quotedstr(stringreplace(datetostr(dtHasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]))+' and cantidad between '+min+' and '+max+ ' ' +
                             ' and alb_cliente not in (select first 75 alb_cliente from A_PREPARACION_PEDIDOS WHERE id_cliente='+edtcliente.Text+' and fecha between '+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and '+quotedstr(stringreplace(datetostr(dtHasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]))+')'+
                             ' group by fecha '+
                             ' order by fecha asc';
            end
           else
            begin
             //si es por unidades, no se cuentan los albaranes, se cuentan las cantidades de casa cosa
             SelectSQL.Text:='select fecha,count(distinct alb_cliente) as alb,SUM(PALES) as contador '+
                             'from A_PREPARACION_PEDIDOS ' +
                             'where id_cliente='+edtcliente.Text+' and fecha between '+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and '+quotedstr(stringreplace(datetostr(dtHasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]))+' '+
                             ' group by fecha '+
                             ' order by fecha asc';
            end;
           Open;
           First;
           m:=altura_cabecera+2;
           while (not Eof) do
            begin
             //anchura cabecera+1
             while (xExcel.Sheets[0].AsString[anchura_cabecera,m]<>FormatDateTime('yyyy-mm-dd',dm.qryPreparacionPedidos.FieldByName('fecha').asDateTime)) do
              begin
               cont_ant[m-j-1]:=0;
               inc(m);
              end;
             xExcel.Sheets[0].AsInteger[i,m] := dm.qryPreparacionPedidos.FieldByName('ALB').AsInteger;
             xExcel.Sheets[0].AsInteger[i+1,m] := dm.qryPreparacionPedidos.FieldByName('CONTADOR').AsInteger;
             if(m<Length(arraytotaldia)-1) then
              begin
               arrayTotalDia[m-j-1]:=arrayTotalDia[m-j-1]+CalculaTarifa( edtcliente.Text,codServicio,0,0, dm.qryPreparacionPedidos.FieldByName('contador').AsInteger,StrToInt(id_unidad),dm.qryPreparacionPedidos.FieldByName('fecha').AsDateTime);
               //   arrayTotalDia[m-j-1]:=arrayTotalDia[m-j-1]+CalculaTarifa( edtcliente.Text,codServicio,0,0, dm.qryPreparacionPedidos.FieldByName('alb').AsInteger,StrToInt(id_unidad),dm.qryPreparacionPedidos.FieldByName('fecha').AsDateTime);
              end
             else
              begin
               arrayTotalDia[m-j-1]:=arrayTotalDia[m-j-1]+CalculaTarifa( edtcliente.Text,codServicio,0,0, dm.qryPreparacionPedidos.FieldByName('contador').AsInteger,StrToInt(id_unidad),dm.qryPreparacionPedidos.FieldByName('fecha').AsDateTime);
               //     arrayTotalDia[m-j-1]:=arrayTotalDia[m-j-1]+CalculaTarifa( edtcliente.Text,codServicio,0,0, dm.qryPreparacionPedidos.FieldByName('alb').AsInteger,StrToInt(id_unidad),dm.qryPreparacionPedidos.FieldByName('fecha').AsDateTime);
              end;
             xExcel.Sheets[0].asFloat[i+2,m] := arrayTotalDia[m-j-1];
             xExcel.Sheets[0]. Cell[i+2,m].NumberFormat := '#,##0.00 €';
             Inc(cantidad_lineas,dm.qryPreparacionPedidos.FieldByName('contador').AsInteger);
             cont_ant[m-j-1]:=dm.qryPreparacionPedidos.FieldByName('contador').AsInteger;
             total_linea_ped:=total_linea_ped+ arrayTotalDia[m-j-1];
             Inc(col);Inc(m);
             id_unidad_ant:=id_unidad;
             min_ant:=min;
             max_ant:=max;
             dm.qryPreparacionPedidos.Next;
            end;
           total_factura:=total_factura+total_linea_ped;
           xExcelResumen.Sheets[0].AsString[0,posicion_resumen]:='Lineas de pedidos';
           xExcelResumen.Sheets[0].asInteger[1,posicion_resumen]:=(cantidad_lineas);
           xExcelResumen.Sheets[0].AsString[2,posicion_resumen]:= '';
           xExcelResumen.Sheets[0].asFloat[3,posicion_resumen]:=total_linea_ped;
           xExcelResumen.Sheets[0]. Cell[3,posicion_resumen].NumberFormat := '#,##0.00 €';
           Inc(posicion_resumen,1);
          end
         else if id_unidad='20' then //por lineas de pedidos acumulables
          begin

          end;
       end;
      id_unidad_ant:=id_unidad;
      //   xExcel.Sheets[0].AsFormula[i,m] := 'SUM('+Arrayletras[i-1]+''+inttostr(2+altura_cabecera)+':'+arrayLetras[i-1]+''+inttostr(2+altura_cabecera+dias+1)+')';
      min_ant:=min;
      max_ant:=max;
      Inc(i);
      dm.qryF_tmp2.Next;
     end;
    with dm.qryF_tmp2 do
     begin
      CLOSE;
      SelectSQL.Text:='select peso_min,peso_max,id_unidad from t_tarifas tar inner join g_clientes cli on cli.id_cliente=tar.id_cliente inner join t_servicios ser on ser.id_servicio=tar.id_servicio where ID_UNIDAD=2 and peso_max=0 and peso_min=0 and cli.codigo='+edtcliente.Text+' and ser.codigo='+quotedstr(codservicio)+' and tar.estado=''A'' and tar.fecha_fin>='+quotedstr(fechaINI)+' and tar.fecha_ini<='+quotedstr(fechaINI)+'order by id_unidad asc';
      Open;
      First;
      j:=altura_cabecera+1;
      while not eof do
       begin
        id_unidad:='2';
        min:=max;
        //max:='9999';
        if id_unidad_ant='7' then
         xExcel.Sheets[0].AsString[i,j] := 'Unidades extra'
        else xExcel.Sheets[0].AsString[i,j] := 'Lineas extra';
        xExcel.Sheets[0].AutoSizeCell(i,j,true,true);
        //xExcel.Sheets[0].Cell[i,j].CellColorRGB:= tablafuera ;
        with dm.qryPreparacionPedidos do
         begin
          CLOSE;
          dm.qryF_limite.Close;
          dm.qryF_limite.SelectSQL.Text:=' select peso_max '+
                                         ' from t_tarifas t inner join g_clientes c on c.id_cliente=t.id_cliente '+
                                         ' where id_extra=25 and id_servicio=124 and id_unidad=2 and peso_max>0 and codigo='+edtcliente.Text+' and fecha_ini<='+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and  fecha_fin>='+quotedstr(stringreplace(datetostr(dtHasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]));
          dm.qryF_limite.Open;
          if((dm.qryF_limite.fieldbyname('peso_max').AsString<>'') and (id_unidad_ant<>'7')) then  //agregado id_unidad_ant
           begin
           // SelectSQL.Text:='select fecha,MAX(lineas) as contador,count(distinct alb_cliente) as contador2 '+
            SelectSQL.Text:='select fecha,SUM(lineas) as contador,count(distinct alb_cliente) as contador2 '+
                            'from A_PREPARACION_PEDIDOS ' +
                            'where ID_cliente='+edtcliente.Text+' and fecha between '+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and '+quotedstr(stringreplace(datetostr(dthasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]))+
                            ' and lineas > '+inttostr(strtoint(min))+ '' +
                            ' and imei=0 '+
                            ' and alb_cliente not in (select first 75 alb_cliente from A_PREPARACION_PEDIDOS WHERE id_cliente='+edtcliente.Text+' and fecha between '+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and '+quotedstr(stringreplace(datetostr(dtHasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]))+' order by fecha asc)'+
                            ' group by fecha '+
                            ' order by fecha asc';
            end
          else
           begin
            // SelectSQL.Text:='select fecha,MAX(lineas) as contador,count(distinct alb_cliente) as contador2 '+
            if(id_unidad_ant='7')then
             begin
              SelectSQL.Text:='select fecha,SUM(cantidad) as contador,count(distinct alb_cliente) as contador2 '+
                              'from A_PREPARACION_PEDIDOS ' +
                              'where ID_cliente='+edtcliente.Text+' and fecha between '+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and '+quotedstr(stringreplace(datetostr(dthasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]))+
                              ' and imei=0 '+
                              ' and cantidad > '+inttostr(strtoint(min))+ '' +
                              ' and alb_cliente not in (select first 75 alb_cliente from A_PREPARACION_PEDIDOS WHERE id_cliente='+edtcliente.Text+' and fecha between '+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and '+quotedstr(stringreplace(datetostr(dtHasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]))+' order by fecha asc)'+
                              ' group by fecha '+
                              ' order by fecha asc';
             end
            else SelectSQL.Text:='select fecha,SUM(lineas) as contador,count(distinct alb_cliente) as contador2 '+
                                 'from A_PREPARACION_PEDIDOS ' +
                                 'where ID_cliente='+edtcliente.Text+' and fecha between '+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and '+quotedstr(stringreplace(datetostr(dthasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]))+
                                 ' and imei=0 '+
                                 ' and lineas > '+inttostr(strtoint(min))+ '' +
                                 ' group by fecha '+
                                 ' order by fecha asc';
           end;
          Open;
          First;
          m:=j;
          while (not Eof) do
           begin
           //guarda en xls    anchura_cabecera+1
            while (xExcel.Sheets[0].AsString[anchura_cabecera,m]<>FormatDateTime('yyyy-mm-dd',dm.qryPreparacionPedidos.FieldByName('fecha').asDateTime)) do
             begin
              inc(m);
             end;
            resultado:=dm.qryPreparacionPedidos.FieldByName('contador').AsInteger-(strtoint(max_ant)*fieldbyname('contador2').asinteger);
            xExcel.Sheets[0].AsInteger[i,m] := resultado;
            //xExcel.Sheets[0].Cell[i,m].CellColorRGB :=tablafuera;
            xExcel.Sheets[0].AsInteger[i-1,m] := cont_ant[m-j-1] + fieldbyname('contador2').asinteger ;
            //fechaq:=dm.qryPreparacionPedidos.FieldByName('fecha').AsDateTime;
            if (id_unidad_ant='4') then
             //arrayTotalDia[m-j-1]:=CalculaTarifa( edtcliente.Text,codServicio,0,0, resultado,StrToInt(id_unidad),fechaq)
               arrayTotalDia[m-j-1]:=CalculaTarifa( edtcliente.Text,codServicio,0,0, resultado,StrToInt(id_unidad),dm.qryPreparacionPedidos.FieldByName('fecha').AsDateTime)
            else //arrayTotalDia[m-j-1]:=arrayTotalDia[m-j-1]+CalculaTarifa( edtcliente.Text,codServicio,0,0, resultado,StrToInt(id_unidad),fechaq)+CalculaTarifa( edtcliente.Text,codServicio,strtoint(min_ant),StrToInt(max_ant), fieldbyname('contador2').asinteger ,StrToInt(id_unidad_ant),fechaq);
                arrayTotalDia[m-j-1]:=arrayTotalDia[m-j-1]+CalculaTarifa( edtcliente.Text,codServicio,0,0, resultado,StrToInt(id_unidad),dm.qryPreparacionPedidos.FieldByName('fecha').AsDateTime)+CalculaTarifa( edtcliente.Text,codServicio,strtoint(min_ant),StrToInt(max_ant), fieldbyname('contador2').asinteger ,StrToInt(id_unidad_ant),dm.qryPreparacionPedidos.FieldByName('fecha').AsDateTime);
            Inc(x);
            dm.qryPreparacionPedidos.Next;
           end;
          dm.qryF_tmp2.next;
         end;
        inc(i);
       end;
      if(( id_unidad='1') or (id_unidad='2') or (id_unidad='7')) then
       begin
        m:=j;
        xExcel.Sheets[0].asString[i,m] := 'Total Día';
        //xExcel.Sheets[0].Cell[i,m].CellColorRGB:= tablafuera ;
        inc(m);
        for z:=0 to Length(arrayTotalDia)-1 do
         begin
          xExcel.Sheets[0].asfloat[i,m] := StrToFloat(formatfloat('##0.00',arrayTotalDia[z]));
          xExcel.Sheets[0]. Cell[i,m].NumberFormat := '#,##0.00 €';
          total_linea_ped:=total_linea_ped+ arrayTotalDia[z];
          total:=total+arrayTotalDia[z];
          Inc(m);
         end;
        total_factura:=total_factura+total;
        total_mer_salidas:=total;
        total_salidas:=total;
        xExcel.Sheets[0].AsFormula[i,m] := 'SUM('+arrayLetras[i+1]+''+inttostr(m)+':'+arrayLetras[i+1]+''+inttostr(m-dias)+')';
        xExcel.Sheets[0]. Cell[i,m].NumberFormat := '#,##0.00 €';
        xExcel.Sheets[0].AsFormula[i-1,m] := 'SUM('+arrayLetras[i]+''+inttostr(m)+':'+arrayLetras[i]+''+inttostr(m-dias)+')';
        xExcel.Sheets[0]. Cell[i-1,m].NumberFormat := '#,##0';
        xExcel.Sheets[0].AsFormula[i-2,m] := 'SUM('+arrayLetras[i-1]+''+inttostr(m)+':'+arrayLetras[i-1]+''+inttostr(m-dias)+')';
        xExcel.Sheets[0]. Cell[i-2,m].NumberFormat := '#,##0';
        //xExcel.Sheets[0].AsString[i-1,m] := 'Total:';
        if cantidad_lineas>0 then
         begin
          xExcelResumen.Sheets[0].AsString[0,posicion_resumen]:='Lineas de pedidos';
          //xExcelResumen.Sheets[0].Cell[1,posicion_resumen].CellColorRGB:= tablafuera ;
          xExcelResumen.Sheets[0].asInteger[1,posicion_resumen]:=cantidad_lineas;
          //xExcelResumen.Sheets[0].Cell[2,posicion_resumen].CellColorRGB:= tabladentro ;
          xExcelResumen.Sheets[0].AsString[2,posicion_resumen]:= '';
          //xExcelResumen.Sheets[0].Cell[3,posicion_resumen].CellColorRGB:= tabladentro ;
          xExcelResumen.Sheets[0].asFloat[3,posicion_resumen]:=total_linea_ped;
          xExcelResumen.Sheets[0]. Cell[3,posicion_resumen].NumberFormat := '#,##0.00 €';
          //xExcelResumen.Sheets[0].Cell[4,posicion_resumen].CellColorRGB:= tabladentro ;
          Inc(posicion_resumen,1);
         end;
        col:=m;
       end;
      tot4:=0;
      if( id_unidad='4') then
       begin
        m:=j;
        xExcel.Sheets[0].asFloat[i-1,m+MonthDays[IsLeapYear(anyo)][mes]+1] :=total;
        //query que busque el maximo de lineas al mes contratadas, se resta del total
        // with dm.qryF_exceso do
        //  begin
        //   close;
        //   selectsql.text:= ' select peso_max from t_tarifas tar inner join g_clientes cli on cli.id_cliente=tar.id_cliente where tar.estado=''A'' and tar.fecha_ini<= fecha and tar.fecha_fin>= fecha and id_unidad= unidad and servicio= servicio';
        //   open;
        //   if not eof then xExcel.Sheets[0].asFloat[i,m+MonthDays[IsLeapYear(anyo)][mes]+1] :=CalculaTarifa(edtcliente.Text,codServicio,0,0, total,StrToInt(id_unidad),fechaq)
        //   else xExcel.Sheets[0].asFloat[i,m+MonthDays[IsLeapYear(anyo)][mes]+1] :=CalculaTarifa(edtcliente.Text,codServicio,0,0, total-fieldbyname('peso').asInteger,StrToInt(id_unidad),fechaq);
        //  end;

        //xExcel.Sheets[0].Cell[i,m+MonthDays[IsLeapYear(anyo)][mes]+1].CellColorRGB :=tablafuera;
        //CAMBIO 14/11/18

        IF((edtcliente.text='3213') or (edtcliente.text='3214') or (edtcliente.text='3217') or (edtcliente.text='3220') or (edtcliente.text='3221') or (edtcliente.text='3223') or (edtcliente.text='3225') or (edtcliente.text='3226') or(edtcliente.text='7151')) then
        begin
         total_factura:=total_factura+CalculaTarifa(edtcliente.Text,codServicio,1,strtofloat(max), total+1,StrToInt(id_unidad),dm.qryPreparacionPedidos.FieldByName('fecha').AsDateTime);
         total_mer_salidas:=CalculaTarifa(edtcliente.Text,codServicio,1,strtofloat(max), total+1,StrToInt(id_unidad),dm.qryPreparacionPedidos.FieldByName('fecha').AsDateTime);
         total_salidas:=total_mer_salidas;
        end
        else
         begin
          total_factura:=total_factura+CalculaTarifa(edtcliente.Text,codServicio,1,strtofloat(max), total-strtofloat(max),StrToInt(id_unidad),dm.qryPreparacionPedidos.FieldByName('fecha').AsDateTime);
          total_mer_salidas:=CalculaTarifa(edtcliente.Text,codServicio,1,strtofloat(max), total-strtofloat(max),StrToInt(id_unidad),dm.qryPreparacionPedidos.FieldByName('fecha').AsDateTime);
          total_salidas:=total_mer_salidas;
         end;
        xExcel.Sheets[0].asFloat[i,m+MonthDays[IsLeapYear(anyo)][mes]+1] :=total_salidas;
        xExcel.Sheets[0]. Cell[i,m+MonthDays[IsLeapYear(anyo)][mes]+1].NumberFormat := '#,##0.00 €';
        col:=m+MonthDays[IsLeapYear(anyo)][mes]+1;
        if(total>0) then
         begin
          xExcelResumen.Sheets[0].AsString[0,posicion_resumen]:='Lineas de pedidos';
          //xExcelResumen.Sheets[0].Cell[1,posicion_resumen].CellColorRGB:= tablafuera ;
          xExcelResumen.Sheets[0].AutoSizeCell(0,posicion_resumen,true,true);
          xExcelResumen.Sheets[0].AsString[1,posicion_resumen]:= '';
          //xExcelResumen.Sheets[0].Cell[2,posicion_resumen].CellColorRGB:= tabladentro ;
          xExcelResumen.Sheets[0].AsString[2,posicion_resumen]:= '';
          //xExcelResumen.Sheets[0].Cell[3,posicion_resumen].CellColorRGB:= tabladentro ;
          //CAMBIO 14/11/18
          //xExcelResumen.Sheets[0].AsString[3,posicion_resumen]:=floattostr(CalculaTarifa(edtcliente.Text,codServicio,1,strtofloat(max), total-strtofloat(max),StrToInt(id_unidad),fechaq)) + '€';
          xExcelResumen.Sheets[0].AsString[3,posicion_resumen]:=floattostr(total_salidas)+ '€';
          Inc(posicion_resumen,1);
         end;
       end
     end;
    Result:=m;
    //xExcel.Write;
    col:=fila+MonthDays[IsLeapYear(anyo)][mes]+1;
    //Result:=fila+MonthDays[IsLeapYear(anyo)][mes]+1;
    Screen.Cursor:=crDefault;
   end
 except
  on e2:Exception do
   begin
    log.Add('Las lineas de pedido del cliente  '+edtcliente.text+ '-'+lblcliente.Caption+' no se han calculado por algún problema.('+e2.message+')');
    Inc(errores);
   end;
 end;
end;

function TMain.LineasDePedidosIMEI(fila: Integer; columna: Integer; codCliente: Integer; servicio: string; out col: Integer):integer ;
var
 anyo,mes,dia:word;
 i,j,x,z,m,resultado,altura_cabecera,anchura_cabecera:Integer; fechaq,fechafin:TDate;
 dd,mm,yyyy,id_unidad_ant,min,min_ant,max,max_ant,id_unidad,codservicio:string;
 total,total_linea_ped_imei:Double;
 contexceso:Integer;
 arrayTotalDia :array of Double;
 cont_ant :array of integer;
 auxiliar,mesString:string;
 fecha,limit:string;
 tot4:Double;
begin
 try
  total_linea_ped_imei:=0;
  //hay que ver si el cliente es caixa popular, calcular los costes imputables, porcentaje de coste y promedio de lineas al dia
  fechaINI:=FormatDateTime('dd.mm.yyyy', dtDesde.Date);
  if(ruta.path='') then
   begin
    ruta.Execute;
    Screen.Cursor:=crDefault;
    xExcel.Filename:= ruta.Path + '\Salidas '+edtCliente.Text+'.xlsx';
    //exit;
   end;
  altura_cabecera:=fila;
  anchura_cabecera:=columna;
  codServicio:='MN2';
  i:=anchura_cabecera;
  j:=altura_cabecera;
  xExcel.Sheets[0].AsString[i,j] := 'PREPARACION DE PEDIDOS TLF.';
  //Inc(i);
  inc(j);
  xExcel.Sheets[0].AsString[i,j] := 'Fecha';
  //xExcel.Sheets[0].Cell[i,j].CellColorRGB:= tablafuera ;
  DecodeDate(dtDesde.Date,anyo,mes,dia);
  if(mes<10) then mesString:='0'+inttostr(mes)
  else mesString:=inttostr(mes);
  for z:=0 to MonthDays[IsLeapYear(anyo)][mes]-1 do
   begin
    if(z<9) then xExcel.Sheets[0].AsString[i,j+z+1] := IntToStr(ANYO) +'-'+mesString+'-0'+ IntToStr(z+1)
    else xExcel.Sheets[0].AsString[i,j+z+1] := IntToStr(ANYO) +'-'+mesString+'-'+ IntToStr(z+1);
    inc(x);
    xExcel.Sheets[0].AutoSizeCell(i,j+z,true,true);
   end;
   xExcel.Sheets[0].AsString[i,j+z+1] := 'Total:';
  i:=anchura_cabecera+1;
  j:=altura_cabecera+1;
  SetLength(arrayTotalDia,MonthDays[IsLeapYear(anyo)][mes]);
  SetLength(cont_ant,MonthDays[IsLeapYear(anyo)][mes]);
  with dm.qryF_tmp2 do
   begin
    CLOSE;
    SelectSQL.Text:='select peso_min,peso_max,id_unidad from t_tarifas tar inner join g_clientes cli on cli.id_cliente=tar.id_cliente inner join t_servicios ser on ser.id_servicio=tar.id_servicio where ID_UNIDAD<>2 and id_unidad<>10 and cli.codigo='+edtcliente.Text+' and ser.codigo='+quotedstr(codservicio)+' and tar.estado=''A'' and tar.fecha_fin>='+quotedstr(StringReplace(fechaINI,'/','.',[rfReplaceAll, rfIgnoreCase]))+' and tar.fecha_ini<='+quotedstr(StringReplace(fechaINI,'/','.',[rfReplaceAll, rfIgnoreCase]))+' order by id_unidad,peso_min asc';
    Open;
    First;
    max_ant:='';
    min_ant:='';
    while not eof do
     begin
      id_unidad:=dm.qryF_tmp2.Fieldbyname('id_unidad').AsString ;
      min:=dm.qryF_tmp2.fieldByName('peso_min').AsString;
      max:=dm.qryF_tmp2.FieldByName('peso_max').AsString;
      if((id_unidad='1')) then
       begin
        xExcel.Sheets[0].AsString[i,j] := 'Unidades de '+min+' a '+max;
        xExcel.Sheets[0].asFormula[i,j+MonthDays[IsLeapYear(anyo)][mes]+1] := 'SUM('+Arrayletras[i+1]+''+inttostr(j+2)+':'+arrayLetras[i+1]+''+inttostr(j+MonthDays[IsLeapYear(anyo)][mes]+1)+')';
        xExcel.Sheets[0]. Cell[i,j+MonthDays[IsLeapYear(anyo)][mes]+1].NumberFormat := '#,##0';
        end
      else if(id_unidad='4')  then
      begin
       xExcel.Sheets[0].AsString[i,j] := 'Lineas';
       xExcel.Sheets[0].asFormula[i,j+MonthDays[IsLeapYear(anyo)][mes]+1] := 'SUM('+Arrayletras[i+1]+''+inttostr(j+2)+':'+arrayLetras[i+1]+''+inttostr(j+MonthDays[IsLeapYear(anyo)][mes]+1)+')';
       xExcel.Sheets[0]. Cell[i,j+MonthDays[IsLeapYear(anyo)][mes]+1].NumberFormat := '#,##0';
      end;
      // else if(id_unidad='10')  then xExcel.Sheets[0].AsString[i,j] := 'IMEIS';
      xExcel.Sheets[0].AutoSizeCell(i,j,true,true);
      //xExcel.Sheets[0].Cell[i,j].CellColorRGB:= tablafuera ;
      with dm.qryPreparacionPedidos do
       begin
        if(id_unidad='1') then
         begin
          close;
          fecha:=Copy(datetostr(dthasta.date),0,10);
          dm.qryF_limite.Close;
          dm.qryF_limite.SelectSQL.Text:=' select peso_max '+
                                         ' from t_tarifas t inner join g_clientes c on c.id_cliente=t.id_cliente '+
                                         ' where id_extra=25 and id_servicio=124 and id_unidad=2 and peso_max>0 and codigo='+edtcliente.Text+' and fecha_ini<='+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and  fecha_fin>='+quotedstr(stringreplace(datetostr(dtHasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]));
          dm.qryF_limite.Open;
          if(dm.qryF_limite.fieldbyname('peso_max').AsString<>'') then
           begin
            SelectSQL.Text:='select fecha,count(distinct alb_cliente) as contador '+
                            'from A_PREPARACION_PEDIDOS ' +
                            'where id_cliente='+edtcliente.Text+' and fecha between '+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and '+quotedstr(stringreplace(datetostr(dtHasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]))+' and cantidad between '+min+' and '+max+ ' ' +
                            ' and imei=1 and alb_cliente not in (select first 75 alb_cliente from A_PREPARACION_PEDIDOS WHERE id_cliente='+edtcliente.Text+' and fecha between '+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and '+quotedstr(stringreplace(datetostr(dtHasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]))+')'+
                            ' group by fecha '+
                            ' order by fecha asc';
           end
          else
           begin
           //cuando son pedidos con imei se valoran por unidades en lugar de por lineas, novedad 11/09/2018
            SelectSQL.Text:='select fecha,count(distinct alb_cliente) as contador '+
                            'from A_PREPARACION_PEDIDOS ' +
                            //'where id_cliente='+edtcliente.Text+' and fecha between '+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and '+quotedstr(stringreplace(datetostr(dtHasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]))+' and lineas between '+min+' and '+max+ ' ' +
                            'where imei=1 and id_cliente='+edtcliente.Text+' and fecha between '+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and '+quotedstr(stringreplace(datetostr(dtHasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]))+' and cantidad between '+min+' and '+max+ ' ' +
                            ' group by fecha '+
                            ' order by fecha asc';
           end;
          Open;
          First;
          m:=altura_cabecera+2;
          while (not Eof) do
           begin
            while (xExcel.Sheets[0].AsString[anchura_cabecera,m]<>FormatDateTime('yyyy-mm-dd',dm.qryPreparacionPedidos.FieldByName('fecha').asDateTime)) do
             begin
              //xExcel.Sheets[0].AsInteger[i,m] := 0;
              cont_ant[m-j-1]:=0;
              inc(m);
             end;
            xExcel.Sheets[0].AsInteger[i,m] := dm.qryPreparacionPedidos.FieldByName('contador').AsInteger;
            if(m<Length(arraytotaldia)-1) then
             begin
              arrayTotalDia[m-j-1]:=arrayTotalDia[m-j-1]+CalculaTarifa( edtcliente.Text,codServicio,StrToInt(min),StrToInt(max), dm.qryPreparacionPedidos.FieldByName('contador').AsInteger,StrToInt(id_unidad),dm.qryPreparacionPedidos.FieldByName('fecha').AsDateTime);
             end
            else
             begin
              arrayTotalDia[m-j-1]:=arrayTotalDia[m-j-1]+CalculaTarifa( edtcliente.Text,codServicio,StrToInt(min),StrToInt(max), dm.qryPreparacionPedidos.FieldByName('contador').AsInteger,StrToInt(id_unidad),dm.qryPreparacionPedidos.FieldByName('fecha').AsDateTime);
             end;
            cont_ant[m-j-1]:=dm.qryPreparacionPedidos.FieldByName('contador').AsInteger;
            Inc(col);Inc(m);
            id_unidad_ant:=id_unidad;
            min_ant:=min;
            max_ant:=max;
            dm.qryPreparacionPedidos.Next;
           end;
         end
        else if id_unidad='4' then
         begin
          try
           CLOSE;
           m:=j+1;
           dm.qryF_limite.Close;
           dm.qryF_limite.SelectSQL.Text:=' select peso_max '+
                                          ' from t_tarifas t inner join g_clientes c on c.id_cliente=t.id_cliente '+
                                          ' where id_extra=25 and id_servicio=132 and id_unidad=2 and peso_max>0 and codigo='+edtcliente.Text+' and fecha_ini<='+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and  fecha_fin>='+quotedstr(stringreplace(datetostr(dtHasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]));
           dm.qryF_limite.Open;
           if(dm.qryF_limite.fieldbyname('peso_max').AsString<>'') then
            begin
             SelectSQL.Text:='select fecha,count(lineas) as contador '+
                             'from A_PREPARACION_PEDIDOS ' +
                             'where ID_Cliente='+edtcliente.Text+' and fecha between '+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and '+quotedstr(stringreplace(datetostr(dthasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]))+
                             ' and imei=1 and alb_cliente not in (select first 75 alb_cliente from A_PREPARACION_PEDIDOS WHERE id_cliente='+edtcliente.Text+' and fecha between '+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and '+quotedstr(stringreplace(datetostr(dtHasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]))+')'+
                             ' group by fecha '+
                             ' order by fecha asc';
            end
           else
            begin
             SelectSQL.Text:='select fecha,count(lineas) as contador '+
                             'from A_PREPARACION_PEDIDOS ' +
                             'where imei=1 and ID_Cliente='+edtcliente.Text+' and fecha between '+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and '+quotedstr(stringreplace(datetostr(dthasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]))+
                             ' group by fecha '+
                             ' order by fecha asc';
            end;
           Open;
           First;
           while (not Eof) do
            begin
             while (xExcel.Sheets[0].AsString[anchura_cabecera+1,m]<>FormatDateTime('yyyy-mm-dd',dm.qryPreparacionPedidos.FieldByName('fecha').asDateTime)) do
              begin
               inc(m);
              end;
             xExcel.Sheets[0].AsInteger[i,m] := dm.qryPreparacionPedidos.FieldByName('contador').AsInteger;
             auxiliar:=dm.qryPreparacionPedidos.FieldByName('fecha').AsString;
             total:=total+dm.qryPreparacionPedidos.FieldByName('contador').AsInteger;
             arrayTotalDia[m-j-1]:=arrayTotalDia[m-j-1]+CalculaTarifa( edtcliente.Text,codServicio,StrToInt(min),StrToInt(max), dm.qryPreparacionPedidos.FieldByName('contador').AsInteger,StrToInt(id_unidad),dm.qryPreparacionPedidos.FieldByName('fecha').AsDateTime);
             cont_ant[m-j-1]:=dm.qryPreparacionPedidos.FieldByName('contador').AsInteger;
             Inc(x);Inc(col);
             id_unidad_ant:=id_unidad;
             min_ant:=min;
             max_ant:=max;
             dm.qryPreparacionPedidos.Next;
            end;
          except
           on e:Exception do
            begin
             log.Add('Las lineas de pedidos con imei del cliente '+edtcliente.text+ '-'+lblcliente.Caption+' no se han calculado por algún problema.('+e.message+')');
             Inc(errores);
            end;
          end;
         end
       end;
      id_unidad_ant:=id_unidad;
      min_ant:=min;
      max_ant:=max;
      xExcel.Sheets[0].asFormula[i,m+1] := 'SUM('+Arrayletras[i+1]+''+inttostr(altura_cabecera+3)+':'+arrayLetras[i+1]+''+inttostr(m)+')';
      xExcel.Sheets[0]. Cell[i,m+1].NumberFormat := '#,##0';

      Inc(i);
      dm.qryF_tmp2.Next;
     end;
    with dm.qryF_tmp2 do
     begin
      CLOSE;
      SelectSQL.Text:='select peso_min,peso_max,id_unidad from t_tarifas tar inner join g_clientes cli on cli.id_cliente=tar.id_cliente inner join t_servicios ser on ser.id_servicio=tar.id_servicio where ID_UNIDAD=2 and peso_max=0 and peso_min=0 and cli.codigo='+edtcliente.Text+' and ser.codigo='+quotedstr(codservicio)+' and tar.estado=''A'' and tar.fecha_fin>='+quotedstr(fechaINI)+' and tar.fecha_ini<='+quotedstr(fechaINI)+'order by id_unidad asc';
      Open;
      First;
      j:=altura_cabecera+1;
      while not eof do
       begin
        id_unidad:='2';
        min:=max;
        //max:='9999';
        xExcel.Sheets[0].AsString[i,j] := 'Extras';
        xExcel.Sheets[0].AsString[i+1,j] := 'IMEI';
        xExcel.Sheets[0].asFormula[i,j+MonthDays[IsLeapYear(anyo)][mes]+1] := 'SUM('+Arrayletras[i+1]+''+inttostr(j+2)+':'+arrayLetras[i+1]+''+inttostr(j+MonthDays[IsLeapYear(anyo)][mes]+1)+')';
        xExcel.Sheets[0]. Cell[i,j+MonthDays[IsLeapYear(anyo)][mes]+1].NumberFormat := '#,##0';
        xExcel.Sheets[0].asFormula[i+1,j+MonthDays[IsLeapYear(anyo)][mes]+1] := 'SUM('+Arrayletras[i+2]+''+inttostr(j+2)+':'+arrayLetras[i+2]+''+inttostr(j+MonthDays[IsLeapYear(anyo)][mes]+1)+')';
        xExcel.Sheets[0]. Cell[i+1,j+MonthDays[IsLeapYear(anyo)][mes]+1].NumberFormat := '#,##0';

        xExcel.Sheets[0].AutoSizeCell(i,j,true,true);
        //xExcel.Sheets[0].Cell[i,j].CellColorRGB:= tablafuera ;
        xExcel.Sheets[0].AutoSizeCell(i+1,j,true,true);
        //xExcel.Sheets[0].Cell[i+1,j].CellColorRGB:= tablafuera ;
        with dm.qryPreparacionPedidos do
         begin
          CLOSE;
          dm.qryF_limite.Close;
          dm.qryF_limite.SelectSQL.Text:=' select peso_max '+
                                         ' from t_tarifas t inner join g_clientes c on c.id_cliente=t.id_cliente '+
                                         ' where id_extra=25 and id_servicio=124 and id_unidad=2 and peso_max>0 and codigo='+edtcliente.Text+' and fecha_ini<='+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and  fecha_fin>='+quotedstr(stringreplace(datetostr(dtHasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]));
          dm.qryF_limite.Open;
          if(dm.qryF_limite.fieldbyname('peso_max').AsString<>'') then
           begin
            SelectSQL.Text:='select fecha,MAX(lineas) as contador,count(distinct alb_cliente) as contador2 '+
                            'from A_PREPARACION_PEDIDOS ' +
                            'where ID_cliente='+edtcliente.Text+' and fecha between '+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and '+quotedstr(stringreplace(datetostr(dthasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]))+
                            ' and lineas > '+inttostr(strtoint(min))+ '' +
                            ' and imei=1 and alb_cliente not in (select first 75 alb_cliente from A_PREPARACION_PEDIDOS WHERE id_cliente='+edtcliente.Text+' and fecha between '+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and '+quotedstr(stringreplace(datetostr(dtHasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]))+')'+
                            ' group by fecha '+
                            ' order by fecha asc';
            end
          else
          if((strtoint(edtcliente.text)>=5100) and (strtoint(edtcliente.text)<=5200))then
           begin
            SelectSQL.Text:='select fecha,sum(cantidad) as contador,count(distinct alb_cliente) as contador2 '+
                            'from A_PREPARACION_PEDIDOS ' +
                            'where imei=1 and ID_cliente='+edtcliente.Text+' and fecha between '+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and '+quotedstr(stringreplace(datetostr(dthasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]))+
                            ' and cantidad > '+inttostr(strtoint(min))+ '' +
                            ' group by fecha '+
                            ' order by fecha asc';
           end
          else
           begin
            SelectSQL.Text:='select fecha,MAX(lineas) as contador,count(distinct alb_cliente) as contador2 '+
                            'from A_PREPARACION_PEDIDOS ' +
                            'where imei=1 and ID_cliente='+edtcliente.Text+' and fecha between '+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and '+quotedstr(stringreplace(datetostr(dthasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]))+
                            ' and lineas > '+inttostr(strtoint(min))+ '' +
                            ' group by fecha '+
                            ' order by fecha asc';
           end;
          Open;
          First;
          m:=j;
          while (not Eof) do
           begin
           //guarda en xls
            while (xExcel.Sheets[0].AsString[anchura_cabecera,m]<>FormatDateTime('yyyy-mm-dd',dm.qryPreparacionPedidos.FieldByName('fecha').asDateTime)) do
             begin
              inc(m);
             end;
            resultado:=dm.qryPreparacionPedidos.FieldByName('contador').AsInteger-(strtoint(max_ant)*fieldbyname('contador2').asinteger);
            dm.qry_numImeiPedido.close;
            dm.qry_numImeiPedido.ParamByName('fecha').AsDateTime:= dm.qryPreparacionPedidos.FieldByName('fecha').asDateTime;
            dm.qry_numImeiPedido.ParamByName('cliente').AsInteger:=StrToInt(edtCliente.Text);
            dm.qry_numImeiPedido.Open;
            xExcel.Sheets[0].AsInteger[i+1,m] := dm.qry_numImeiPedido.FieldByName('cantidadImei').AsInteger;
            //calcular la cantidad de imeis que hay en el albaran
            //xExcel.Sheets[0].AsInteger[i+1,m] := dm.qryPreparacionPedidos.FieldByName('imei').AsInteger;
            xExcel.Sheets[0].AsInteger[i,m] := resultado;
            xExcel.Sheets[0].AsInteger[i-1,m] := cont_ant[m-j-1] + fieldbyname('contador2').asinteger ;
            fechaq:=dm.qryPreparacionPedidos.FieldByName('fecha').AsDateTime;
            if (id_unidad_ant='4') then
             arrayTotalDia[m-j-1]:=CalculaTarifa( edtcliente.Text,codServicio,0,0, resultado,StrToInt(id_unidad),fechaq)
            else arrayTotalDia[m-j-1]:=arrayTotalDia[m-j-1]+CalculaTarifa( edtcliente.Text,codServicio,0,0, resultado,StrToInt(id_unidad),fechaq)+CalculaTarifa( edtcliente.Text,codServicio,strtoint(min_ant),StrToInt(max_ant), fieldbyname('contador2').asinteger ,StrToInt(id_unidad_ant),fechaq);
            Inc(x);
            dm.qryPreparacionPedidos.Next;
           end;
          dm.qryF_tmp2.next;
         end;
        inc(i);
       end;
       //IMEIS
       //xExcel.Sheets[0].AsString[i,j] := 'IMEIS';
      with dm.qryPreparacionPedidos do
       begin
        CLOSE;
        m:=j+1;
        SelectSQL.Text:='select fecha,SUM(CANTIDAD) as contador '+
                        'from A_PREPARACION_PEDIDOS ' +
                        'where ID_Cliente='+edtcliente.Text+' and fecha between '+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and '+quotedstr(stringreplace(datetostr(dthasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]))+
                        ' and imei=1 '+
                        ' group by fecha '+
                        ' order by fecha asc';
        Open;
        First;
        while (not Eof) do
         begin
          while (xExcel.Sheets[0].AsString[anchura_cabecera,m]<>FormatDateTime('yyyy-mm-dd',dm.qryPreparacionPedidos.FieldByName('fecha').asDateTime)) do
           begin
            inc(m);
           end;
          xExcel.Sheets[0].AsInteger[i,m] := dm.qryPreparacionPedidos.FieldByName('contador').AsInteger;
          auxiliar:=dm.qryPreparacionPedidos.FieldByName('fecha').AsString;
          //total:=total+dm.qryPreparacionPedidos.FieldByName('contador').AsInteger;
          arrayTotalDia[m-j-1]:=arrayTotalDia[m-j-1]+CalculaTarifa( edtcliente.Text,codServicio,0,0, dm.qryPreparacionPedidos.FieldByName('contador').AsInteger,10,dm.qryPreparacionPedidos.FieldByName('fecha').asDatetime);
          cont_ant[m-j-1]:=dm.qryPreparacionPedidos.FieldByName('contador').AsInteger;
          Inc(x);Inc(col);
          //id_unidad_ant:=id_unidad;
          //min_ant:=min;
          //max_ant:=max;
          dm.qryPreparacionPedidos.Next;
         end;
        inc(i);
       end;
      if(( id_unidad='1') or (id_unidad='2')) then
       begin
        m:=j;
        xExcel.Sheets[0].asString[i,m] := 'Total Día';
        //xExcel.Sheets[0].Cell[i,m].CellColorRGB:= tablafuera ;
        inc(m);
        for z:=0 to Length(arrayTotalDia)-1 do
         begin
          xExcel.Sheets[0].asfloat[i,m] := arrayTotalDia[z];
          xExcel.Sheets[0]. Cell[i,m].NumberFormat := '#,##0.00 €';
          total_linea_ped_imei:=total_linea_ped_imei+ arrayTotalDia[z];
          total:=total+arrayTotalDia[z];
          Inc(m);
         end;
        total_factura:=total_factura+total_linea_ped_imei;
        total_mer_salidas_imei:=total_linea_ped_imei;
        total_salidas_imei:=total_linea_ped_imei;
        xExcel.Sheets[0].AsFormula[i,m] := 'SUM('+arrayLetras[i+1]+''+inttostr(m)+':'+arrayLetras[i+1]+''+inttostr(m-dias)+')';
        xExcel.Sheets[0]. Cell[i,m].NumberFormat := '#,##0.00 €';
        if(total_linea_ped_imei>0) then
         begin
          xExcelResumen.Sheets[0].AsString[0,posicion_resumen]:='Total lineas de pedidos telefonia';
          //xExcelResumen.Sheets[0].Cell[1,posicion_resumen].CellColorRGB:= tablafuera ;
          xExcelResumen.Sheets[0].AutoSizeCell(0,posicion_resumen,true,true);
          xExcelResumen.Sheets[0].AsString[1,posicion_resumen]:= '';
          //xExcelResumen.Sheets[0].Cell[2,posicion_resumen].CellColorRGB:= tabladentro ;
          xExcelResumen.Sheets[0].AsString[2,posicion_resumen]:= '';
          //xExcelResumen.Sheets[0].Cell[3,posicion_resumen].CellColorRGB:= tabladentro ;
          xExcelResumen.Sheets[0].asFloat[3,posicion_resumen]:=total_linea_ped_imei;
          xExcelResumen.Sheets[0]. Cell[3,posicion_resumen].NumberFormat := '#,##0.00 €';
          Inc(posicion_resumen,1);
         end;
        col:=m;
       end;
      tot4:=0;
      if( id_unidad='4') then
       begin
        m:=j;
        xExcel.Sheets[0].asFloat[i-1,m+MonthDays[IsLeapYear(anyo)][mes]+1] :=total;
        xExcel.Sheets[0]. Cell[i-1,m+MonthDays[IsLeapYear(anyo)][mes]+1].NumberFormat := '#,##0.00 €';
        xExcel.Sheets[0].asFloat[i,m+MonthDays[IsLeapYear(anyo)][mes]+1] :=CalculaTarifa(edtcliente.Text,codServicio,1,strtofloat(max), total-strtofloat(max),StrToInt(id_unidad),fechaq);
        xExcel.Sheets[0]. Cell[i,m+MonthDays[IsLeapYear(anyo)][mes]+1].NumberFormat:= '#,##0.00 €';
        total_factura:=total_factura+CalculaTarifa(edtcliente.Text,codServicio,1,strtofloat(max), total-strtofloat(max),StrToInt(id_unidad),fechaq);
        col:=m+MonthDays[IsLeapYear(anyo)][mes]+1;
        if(total>0) then
         begin
          xExcelResumen.Sheets[0].AsString[0,posicion_resumen]:='Total lineas de pedidos telefonia';
          //xExcelResumen.Sheets[0].Cell[1,posicion_resumen].CellColorRGB:= tablafuera ;
          //xExcelResumen.Sheets[0].AutoSizeCell(1,posicion_resumen,true,true);
          xExcelResumen.Sheets[0].AsString[1,posicion_resumen]:= '';
          //xExcelResumen.Sheets[0].Cell[2,posicion_resumen].CellColorRGB:= tabladentro ;
          xExcelResumen.Sheets[0].AsString[2,posicion_resumen]:= '';
          //xExcelResumen.Sheets[0].Cell[3,posicion_resumen].CellColorRGB:= tabladentro ;
          xExcelResumen.Sheets[0].asFloat[3,posicion_resumen]:=CalculaTarifa(edtcliente.Text,codServicio,1,strtofloat(max), total-strtofloat(max),StrToInt(id_unidad),fechaq);
          xExcelResumen.Sheets[0].Cell[3,posicion_resumen].NumberFormat := '#,##0.00 €';
          //xExcelResumen.Sheets[0].Cell[4,posicion_resumen].CellColorRGB:= tabladentro ;
          Inc(posicion_resumen,1);
         end;
       end
     end;
    Result:=m;
    col:=fila+MonthDays[IsLeapYear(anyo)][mes]+1;
    Screen.Cursor:=crDefault;
   end
 except
  on e2:Exception do
   begin
    log.Add('Las lineas de pedido del cliente  '+edtcliente.text+ '-'+lblcliente.Caption+' no se han calculado por algún problema.('+e2.message+')');
    Inc(errores);
   end;
 end;
end;
{*------------------------------------------------------------------------------
  Genera la estructura (y rellena los datos) del cliente pasado por parametro, del servicio "Recepcion de material".
 -------------------------------------------------------------------------------}
function TMain.RecepcionDeMaterial(fila,columna,codCliente:Integer;servicio:string;out col:integer):Integer ;
var
 anyo,mes,dia:word;i,j,x,z,m,resultado,altura_cabecera,anchura_cabecera:Integer; fechaq,fechafin:TDate;dd,mm,yyyy,id_unidad_ant,min,min_ant,max,max_ant,id_unidad,codservicio:string;
 total,total_entrada,totalLineas:Double;
 arrayTotalDia :array of Double;
 cont_ant :array of integer;
 auxiliar,mesString,comparaFecha:string;
 lineasGratis,contador:integer;
 primera_pasada:Boolean;
 lin,alb,pal,imei:Integer;
 anyoMer,mesMer,diaMer:word;
begin
 IF(strtoint(edtcliente.Text)<5100) or (strtoint(edtcliente.Text)>5200) then
 begin
 try
  lineasGratis:=0;
  contador:=0;
  primera_pasada:=True;
  fechaINI:=FormatDateTime('mm/dd/yyyy', dtDesde.Date);
  FormatDateTime('mm/dd/yyyy', dtDesde.Date);
  DecodeDate(dtDesde.date,anyo,Mes,Dia);
  if(ruta.path='') then
   begin
    ruta.Execute;
    Screen.Cursor:=crDefault;
    xExcel.Filename:= ruta.Path + '\Recepcion de material '+edtCliente.Text+'.xlsx';
   end;
  altura_cabecera:=fila;
  anchura_cabecera:=columna;
  codServicio:='3000';
  i:=anchura_cabecera;
  j:=altura_cabecera;
  xExcel.Sheets[0].AsString[i,j] := 'RECEPCIÓN DE MATERIAL';
  //Inc(i);
  inc(j);
  xExcel.Sheets[0].AsString[i,j] := 'Fecha';
  //xExcel.Sheets[0].Cell[i,j].CellColorRGB:= tablafuera ;
  DecodeDate(dtDesde.Date,anyo,mes,dia);
  if(mes<10) then mesString:='0'+inttostr(mes)
  else mesString:=inttostr(mes);
  for z:=0 to MonthDays[IsLeapYear(anyo)][mes]-1 do
   begin
    if(z<9) then xExcel.Sheets[0].AsString[i,j+z+1] := IntToStr(ANYO) +'-'+mesString+'-0'+ IntToStr(z+1)
    else xExcel.Sheets[0].AsString[i,j+z+1] := IntToStr(ANYO) +'-'+mesString+'-'+ IntToStr(z+1);
    inc(x);
    xExcel.Sheets[0].AutoSizeCell(i,j+z,true,true);
    //xExcel.Sheets[0].Cell[i,j+z].CellColorRGB:= tablafuera ;
   end;
  xExcel.Sheets[0].AsString[i,j+z+1] :='Total:';
  //X:=RESULTADO;
  i:=anchura_cabecera+1;
  j:=altura_cabecera+1;
  SetLength(arrayTotalDia,MonthDays[IsLeapYear(anyo)][mes]);
  SetLength(cont_ant,MonthDays[IsLeapYear(anyo)][mes]);
  if(servicio='GRUPAJES') then
   begin
   // if(id_unidad='6') then
    dm.qryF_limite.Close;
    dm.qryF_limite.SelectSQL.Text:=' select peso_max '+
                                   ' from t_tarifas t inner join g_clientes c on c.id_cliente=t.id_cliente '+
                                   ' where id_extra=25 and id_servicio=120 and id_unidad=2 and peso_max>0 and codigo='+edtcliente.Text+' and fecha_ini<='+quotedstr(stringreplace(datetostr(dtdesde.date), '/', '.',[rfReplaceAll, rfIgnoreCase])) +' and  fecha_fin>='+quotedstr(stringreplace(datetostr(dtHasta.date), '/', '.',[rfReplaceAll, rfIgnoreCase]));
    dm.qryF_limite.Open;
    if(dm.qryF_limite.fieldbyname('peso_max').AsString<>'') then
     lineasGratis:=dm.qryF_limite.fieldbyname('peso_max').AsInteger;
     begin
      //aqui vamos a tener que diferenciar las descargas convencionales (que posiblemente sean las que ya están programadas, con las entradas masivas) también las entradas por kilos como en caixa ontinyent
      with dm.qryF_tmp2 do
       begin
        CLOSE;
        SelectSQL.Text:='select peso_min,peso_max,id_unidad from t_tarifas tar inner join g_clientes cli on cli.id_cliente=tar.id_cliente inner join t_servicios ser on ser.id_servicio=tar.id_servicio where cli.codigo='+edtcliente.Text+' and ser.codigo='+quotedstr(codservicio)+' and tar.estado=''A'' and tar.fecha_fin>='+quotedstr(fechaINI)+' and tar.fecha_ini<='+quotedstr(fechaINI)+' and (id_unidad<>8 and not (id_unidad=2 and peso_max<>0)) order by id_unidad desc';
        Open;
        First;
        max_ant:='';
        while not eof do
         begin
          id_unidad:=dm.qryF_tmp2.Fieldbyname('id_unidad').AsString ;
          min:=dm.qryF_tmp2.fieldByName('peso_min').AsString;
          max:=dm.qryF_tmp2.FieldByName('peso_max').AsString;
          if((max='0') and (id_unidad='2')) then
           begin
            min:=max_ant;
            max:='9999';
           end;
          if((id_unidad='6')) then
           begin
            xExcel.Sheets[0].AsString[i,j] := 'Lineas de '+min+' a '+max;
            xExcel.Sheets[0].AsFormula[i,j+(MonthDays[IsLeapYear(anyo)][mes])+1]  := 'SUM('+Arrayletras[i+1]+''+inttostr(j+2)+':'+arrayLetras[i+1]+''+inttostr(j+1+MonthDays[IsLeapYear(anyo)][mes])+')';
           end
          else
           if(id_unidad='2') then
            begin
             xExcel.Sheets[0].AsString[i,j] := 'Lineas extra';
             xExcel.Sheets[0].AsFormula[i,j+(MonthDays[IsLeapYear(anyo)][mes])+1]  := 'SUM('+Arrayletras[i+1]+''+inttostr(j+2)+':'+arrayLetras[i+1]+''+inttostr(j+1+MonthDays[IsLeapYear(anyo)][mes])+')';
            end
           else
             if(id_unidad='4')  then
              begin
               xExcel.Sheets[0].AsString[i,j] := 'Lineas';
               xExcel.Sheets[0].AsFormula[i,j+(MonthDays[IsLeapYear(anyo)][mes])+1] := 'SUM('+Arrayletras[i+1]+''+inttostr(i+1)+':'+arrayLetras[i+1]+''+inttostr(i+1+MonthDays[IsLeapYear(anyo)][mes])+')';
               xExcel.Sheets[0].AsString[i+1,j] := 'Albaranes';
               xExcel.Sheets[0].AsFormula[i+1,j+(MonthDays[IsLeapYear(anyo)][mes])+1] := 'SUM('+Arrayletras[i+2]+''+inttostr(i+1)+':'+arrayLetras[i+2]+''+inttostr(i+1+MonthDays[IsLeapYear(anyo)][mes])+')';
               xExcel.Sheets[0].AsString[i+2,j] := 'Total';
               xExcel.Sheets[0].AsFormula[i+2,j+(MonthDays[IsLeapYear(anyo)][mes])+1]  := 'SUM('+Arrayletras[i+3]+''+inttostr(i+1)+':'+arrayLetras[i+3]+''+inttostr(i+1+MonthDays[IsLeapYear(anyo)][mes])+')';
               xExcel.Sheets[0]. Cell[i+2,j+(MonthDays[IsLeapYear(anyo)][mes])+1].NumberFormat := '#,##0.00 €';
               //xExcel.Sheets[0].Cell[i+1,j].CellColorRGB:= tablafuera ;
              end
             else
              if (id_unidad='8')then
                begin
                 xExcel.Sheets[0].AsString[i,j] := 'Albaranes';
                 xExcel.Sheets[0].AsString[i+1,j] := 'Palés';    //antes ponia lineas
                 xExcel.Sheets[0].AsString[i+2,j] := 'Total';
                 xExcel.Sheets[0].asFormula[i,j+1+(MonthDays[IsLeapYear(anyo)][mes])] :='SUM('+Arrayletras[i+1]+''+inttostr(j+1)+':'+arrayLetras[i+1]+''+inttostr(j+(MonthDays[IsLeapYear(anyo)][mes])+1)+')';
                 xExcel.Sheets[0].asFormula[i+1,j+1+(MonthDays[IsLeapYear(anyo)][mes])] :='SUM('+Arrayletras[i+2]+''+inttostr(j+1)+':'+arrayLetras[i+2]+''+inttostr(j+(MonthDays[IsLeapYear(anyo)][mes])+1)+')';
                 xExcel.Sheets[0].asFormula[i+2,j+1+(MonthDays[IsLeapYear(anyo)][mes])]:='SUM('+Arrayletras[i+3]+''+inttostr(j+1)+':'+arrayLetras[i+3]+''+inttostr(j+(MonthDays[IsLeapYear(anyo)][mes])+1)+')';
                 xExcel.Sheets[0]. Cell[i+2,j+(MonthDays[IsLeapYear(anyo)][mes])+1].NumberFormat := '#,##0.00 €';
                end
              else
               if(id_unidad='9') then
                    begin
                     xExcel.Sheets[0].AsString[i,j] := 'Palés' ;
                     xExcel.Sheets[0].AsString[i+1,j] := 'Albaranes';
                     xExcel.Sheets[0].AsString[i+2,j] := 'Lineas';
                     xExcel.Sheets[0].AsString[i+3,j] := 'Total';
                     //xExcel.Sheets[0].asFormula[i,(MonthDays[IsLeapYear(anyo)][mes])] :='SUM('+Arrayletras[i+1]+''+inttostr(j+z+1)+':'+arrayLetras[i+1]+''+inttostr(j+(MonthDays[IsLeapYear(anyo)][mes])+1)+')';
                     xExcel.Sheets[0].asFormula[i,j+1+(MonthDays[IsLeapYear(anyo)][mes])] :='SUM('+Arrayletras[i+1]+''+inttostr(j+1)+':'+arrayLetras[i+1]+''+inttostr(j+(MonthDays[IsLeapYear(anyo)][mes])+1)+')';
                     xExcel.Sheets[0].asFormula[i+1,j+1+(MonthDays[IsLeapYear(anyo)][mes])] :='SUM('+Arrayletras[i+2]+''+inttostr(j+1)+':'+arrayLetras[i+2]+''+inttostr(j+(MonthDays[IsLeapYear(anyo)][mes])+1)+')';
                     xExcel.Sheets[0].asFormula[i+2,j+1+(MonthDays[IsLeapYear(anyo)][mes])] :='SUM('+Arrayletras[i+3]+''+inttostr(j+1)+':'+arrayLetras[i+3]+''+inttostr(j+(MonthDays[IsLeapYear(anyo)][mes])+1)+')';
                     xExcel.Sheets[0].asFormula[i+3,j+1+(MonthDays[IsLeapYear(anyo)][mes])]:='SUM('+Arrayletras[i+4]+''+inttostr(j+1)+':'+arrayLetras[i+4]+''+inttostr(j+(MonthDays[IsLeapYear(anyo)][mes])+1)+')';
                     // xExcel.Sheets[0].asFormula[i+2,j+(MonthDays[IsLeapYear(anyo)][mes])+1] :='SUM('+Arrayletras[i+3]+''+inttostr(j+z+1)+':'+arrayLetras[i+3]+''+inttostr(j+z+1+MonthDays[IsLeapYear(anyo)][mes])+')';
                     xExcel.Sheets[0]. Cell[i+3,j+(MonthDays[IsLeapYear(anyo)][mes])+1].NumberFormat := '#,##0.00 €';
                     //format number de los tres
                     end;
         xExcel.Sheets[0].AutoSizeCell(i,j,true,true);
         //autowidth
         //xExcel.Sheets[0].Cell[i,j].CellColorRGB:= tablafuera ;
         with dm.qry_EntradasAlm do
          begin
           if(id_unidad='6') then
            begin
             CLOSE;
             ParamByName('cliente').AsString:=edtCliente.Text;
             ParamByName('ini').AsDate:= dtDesde.Date;
             ParamByName('fin'). AsDate:= dtHasta.Date;
             ParamByName('min').AsString:= min;
             ParamByName('max').AsString:= max;
             Open;
             First;
             m:=altura_cabecera+2;
             while (not Eof) do
              begin
               //qry_EntradasAlm
               while ((xExcel.Sheets[0].AsString[anchura_cabecera,m]<>FormatDateTime('yyyy-mm-dd',dm.qry_EntradasAlm.FieldByName('fecha').AsDateTime))) do
                begin
                 inc(m);
                end;
               xExcel.Sheets[0].AsInteger[i,m] := dm.qry_EntradasAlm.FieldByName('lineas').AsInteger;
               inc(contador,dm.qry_EntradasAlm.FieldByName('lineas').AsInteger);
               if((contador<LineasGratis) and (primera_pasada))
                then
                 begin
                  fechaq:=StrToDate(FormatDateTime('dd/mm/yyyy',dm.qry_EntradasAlm.FieldByName('fecha').AsDateTime));
                  if (m<Length(arraytotaldia)-1) then
                   begin
                    arrayTotalDia[m-j-1]:=arrayTotalDia[m-j-1]+CalculaTarifa( edtcliente.Text,codServicio,StrToInt(min),StrToInt(max),contador-lineasGratis,StrToInt(id_unidad),fechaq);
                    arrayTotalDia[m-j-1]:=arrayTotalDia[m-j-1]+CalculaTarifa( edtcliente.Text,codServicio,0,0, dm.qry_EntradasAlm.FieldByName('albaranes').AsInteger,8,fechaq);
                   //prueba
                    arrayTotalDia[m-j-1]:=arrayTotalDia[m-j-1]+CalculaTarifa( edtcliente.Text,codServicio,0,0, dm.qry_EntradasAlm.FieldByName('lineas').AsInteger,8,fechaq);
                   // arrayTotalDia[m-j-1]:=arrayTotalDia[m-j-1]+CalculaTarifa( edtcliente.Text,codServicio,0,0, dm.qry_EntradasAlm.FieldByName('pales').AsInteger,8,fechaq);
                   // arrayTotalDia[m-j-1]:=arrayTotalDia[m-j-1]+CalculaTarifa( edtcliente.Text,codServicio,0,0, dm.qry_EntradasAlm.FieldByName('imeis').AsInteger,8,fechaq);
                   end
                  else
                   begin
                    arrayTotalDia[m-j-1]:=arrayTotalDia[m-j-1]+CalculaTarifa( edtcliente.Text,codServicio,StrToInt(min),StrToInt(max), dm.qry_EntradasAlm.FieldByName('lineas').AsInteger,StrToInt(id_unidad),fechaq);
                    arrayTotalDia[m-j-1]:=arrayTotalDia[m-j-1]+CalculaTarifa( edtcliente.Text,codServicio,0,0, dm.qry_EntradasAlm.FieldByName('albaranes').AsInteger,8,fechaq);
                   end;
                  primera_pasada:=False;
                 end
               else
                if((contador>LineasGratis)) then
                 begin
                  fechaq:=StrToDate(FormatDateTime('dd/mm/yyyy',dm.qry_EntradasAlm.FieldByName('fecha').AsDateTime));
                  if (m<Length(arraytotaldia)-1) then
                   begin
                    arrayTotalDia[m-j-1]:=arrayTotalDia[m-j-1]+CalculaTarifa( edtcliente.Text,codServicio,StrToInt(min),StrToInt(max), dm.qry_EntradasAlm.FieldByName('lineas').AsInteger,StrToInt(id_unidad),fechaq);
                    arrayTotalDia[m-j-1]:=arrayTotalDia[m-j-1]+CalculaTarifa( edtcliente.Text,codServicio,0,0, dm.qry_EntradasAlm.FieldByName('albaranes').AsInteger,8,fechaq);
                   end
                  else
                  begin
                   arrayTotalDia[m-j-1]:=arrayTotalDia[m-j-1]+CalculaTarifa( edtcliente.Text,codServicio,StrToInt(min),StrToInt(max), dm.qry_EntradasAlm.FieldByName('lineas').AsInteger,StrToInt(id_unidad),fechaq);
                   arrayTotalDia[m-j-1]:=arrayTotalDia[m-j-1]+CalculaTarifa( edtcliente.Text,codServicio,0,0, dm.qry_EntradasAlm.FieldByName('albaranes').AsInteger,8,fechaq);
                  end;
                  cont_ant[m-j-1]:= dm.qry_EntradasAlm.FieldByName('lineas').AsInteger;
                  Inc(col);Inc(m);
                  max_ant:=max;
                  min_ant:=min;
                  id_unidad_ant:=id_unidad;
                  dm.qry_EntradasAlm.Next;
                 end
                else
                 begin
                  Inc(col);Inc(m);
                  max_ant:=max;
                  min_ant:=min;
                  id_unidad_ant:=id_unidad;
                  dm.qry_EntradasAlm.Next;
                 end;
              end
            end
           else
            if id_unidad='4' then
             begin
              try
               CLOSE;
               m:=j+1;
               //modificar con query que diga iván
               dm.qry_EntradasAlm.ParamByName('cliente').AsString:=edtCliente.Text;
               dm.qry_EntradasAlm.ParamByName('ini').AsDate:= dtDesde.Date;
               dm.qry_EntradasAlm.ParamByName('fin'). AsDate:= dtHasta.Date;
               dm.qry_EntradasAlm.ParamByName('min').AsString:= min;
               dm.qry_EntradasAlm.ParamByName('max').AsString:= max;
               Open;
               First;
               //x:=1;
               while (not Eof) do
                begin
                 //while (xExcel.Sheets[0].AsString[anchura_cabecera+1,m]<>dm.qry_sql.FieldByName('fecha').AsString) do
                 while (xExcel.Sheets[0].AsString[anchura_cabecera,m]<>FormatDateTime('yyyy-mm-dd',dm.qry_EntradasAlm.FieldByName('fecha').AsDateTime)) do
                  begin
                   //xExcel.Sheets[0].AsInteger[i,m] := 0;
                   inc(m);
                  end;
                 xExcel.Sheets[0].AsInteger[i,m] := dm.qry_EntradasAlm.FieldByName('lineas').AsInteger;
                 xExcel.Sheets[0].AsInteger[i+1,m] := dm.qry_EntradasAlm.FieldByName('Albaranes').AsInteger;
                 inc(contador,dm.qry_EntradasAlm.FieldByName('lineas').AsInteger);
                 total:=total+dm.qry_EntradasAlm.FieldByName('lineas').AsInteger;
                 fechaq:=StrToDate(FormatDateTime('dd/mm/yyyy',dm.qry_EntradasAlm.FieldByName('fecha').AsDateTime));
                 if((contador<LineasGratis) and (primera_pasada)) then
                  begin
                    arrayTotalDia[m-j-1]:=arrayTotalDia[m-j-1]+CalculaTarifa( edtcliente.Text,codServicio,StrToInt(min),StrToInt(max),contador-lineasGratis,StrToInt(id_unidad),fechaq);
                    arrayTotalDia[m-j-1]:=arrayTotalDia[m-j-1]+CalculaTarifa( edtcliente.Text,codServicio,0,0, dm.qry_EntradasAlm.FieldByName('albaranes').AsInteger,8,fechaq);
                    primera_pasada:=False;
                  Inc(x);inc(col);Inc(m);
                   cont_ant[m-j]:=  dm.qry_EntradasAlm.FieldByName('lineas').AsInteger;
                   dm.qry_EntradasAlm.Next;
                  end
                 else
                 if((contador>LineasGratis)) then
                  begin
                   arrayTotalDia[m-j]:=arrayTotalDia[m-j]+CalculaTarifa( edtcliente.Text,codServicio,StrToInt(min),StrToInt(max), dm.qry_EntradasAlm.FieldByName('lineas').AsInteger,StrToInt(id_unidad),fechaq);
                   arrayTotalDia[m-j]:=arrayTotalDia[m-j]+CalculaTarifa( edtcliente.Text,codServicio,0,0, dm.qry_EntradasAlm.FieldByName('albaranes').AsInteger,StrToInt(id_unidad),fechaq);
                   Inc(x);inc(col);Inc(m);
                   cont_ant[m-j]:=  dm.qry_EntradasAlm.FieldByName('lineas').AsInteger;
                   dm.qry_EntradasAlm.Next;
                  end
                 else
                  begin
                  total_entrada:=total_entrada+arrayTotalDia[m-j];
                   max_ant:=max;
                   min_ant:=min;
                   id_unidad_ant:=id_unidad;
                   xExcel.Sheets[0].asFloat[i+2,m] := arrayTotalDia[m-j];
                   xExcel.Sheets[0]. Cell[i+2,m].NumberFormat := '#,##0.00 €';
                   Inc(x);inc(col);Inc(m);
                   cont_ant[m-j]:=  dm.qry_EntradasAlm.FieldByName('lineas').AsInteger;
                   dm.qry_EntradasAlm.Next;
                 end;
                end;
              except

              end;
             end
           else
            if (id_unidad='8') then
             begin
              CLOSE;
              m:=j+1;
              //modificar con query que diga iván
              dm.qry_EntradasAlm.ParamByName('cliente').AsString:=edtCliente.Text;
              dm.qry_EntradasAlm.ParamByName('ini').AsDate:= dtDesde.Date;
              dm.qry_EntradasAlm.ParamByName('fin'). AsDate:= dtHasta.Date;
              dm.qry_EntradasAlm.ParamByName('min').AsString:= min;
              dm.qry_EntradasAlm.ParamByName('max').AsString:= max;
              Open;
              First;
              while (not Eof) do
               begin
                while (xExcel.Sheets[0].AsString[anchura_cabecera,m]<>FormatDateTime('yyyy-mm-dd',dm.qry_EntradasAlm.FieldByName('fecha').AsDateTime)) do
                 begin
                  inc(m);
                 end;
                xExcel.Sheets[0].AsInteger[i,m] := dm.qry_EntradasAlm.FieldByName('albaranes').AsInteger;
                xExcel.Sheets[0].AsInteger[i+1,m] := dm.qry_EntradasAlm.FieldByName('pales').AsInteger;
                //auxiliar:=dm.qry_sql.FieldByName('fecha').AsString;
                //total:=total+dm.qry_EntradasAlm.FieldByName('albaranes').AsInteger;
                arrayTotalDia[m-j]:=arrayTotalDia[m-j]+CalculaTarifa( edtcliente.Text,codServicio,StrToInt(min),StrToInt(max), dm.qry_EntradasAlm.FieldByName('albaranes').AsInteger,StrToInt(id_unidad),dm.qry_EntradasAlm.FieldByName('fecha').AsDateTime);
                arrayTotalDia[m-j]:=arrayTotalDia[m-j]+CalculaTarifa( edtcliente.Text,codServicio,0,0, dm.qry_EntradasAlm.FieldByName('pales').AsInteger,9,fechaq);
                //total_entrada:=total_entrada+CalculaTarifa(edtcliente.Text,codServicio,StrToInt(min),StrToInt(max), dm.qry_EntradasAlm.FieldByName('lineas').AsInteger,StrToInt(id_unidad),fechaq)+CalculaTarifa( edtcliente.Text,codServicio,0,0, dm.qry_EntradasAlm.FieldByName('pales').AsInteger,StrToInt(id_unidad),fechaq);;
                total_entrada:=total_entrada+arrayTotalDia[m-j];
                //total_factura:=total_factura+CalculaTarifa(edtcliente.Text,codServicio,StrToInt(min),StrToInt(max), dm.qry_EntradasAlm.FieldByName('lineas').AsInteger,StrToInt(id_unidad),fechaq);
                Inc(x);Inc(col);
                //cont_ant[m-j]:=  dm.qry_EntradasAlm.FieldByName('lineas').AsInteger;
                max_ant:=max;
                dm.qry_EntradasAlm.Next;
               end;
             end
            else
            if(id_unidad='9') then
            begin
              CLOSE;
              m:=j+1;
              //modificar con query que diga iván
              dm.qry_EntradasAlm.ParamByName('cliente').AsString:=edtCliente.Text;
              dm.qry_EntradasAlm.ParamByName('ini').AsDate:= dtDesde.Date;
              dm.qry_EntradasAlm.ParamByName('fin'). AsDate:= dtHasta.Date;
              dm.qry_EntradasAlm.ParamByName('min').AsString:= '0';
              dm.qry_EntradasAlm.ParamByName('max').AsString:= '10000000';
              Open;
              First;
              while (not Eof) do
               begin
                while (xExcel.Sheets[0].AsString[anchura_cabecera,m]<>FormatDateTime('yyyy-mm-dd',dm.qry_EntradasAlm.FieldByName('fecha').AsDateTime)) do
                 begin
                  inc(m);
                 end;
               // xExcel.Sheets[0].AsInteger[i+1,m] := dm.qry_EntradasAlm.FieldByName('albaranes').AsInteger;
                xExcel.Sheets[0].AsInteger[i+2,m] := dm.qry_EntradasAlm.FieldByName('Lineas').AsInteger;
                xExcel.Sheets[0].AsInteger[i+1,m] := dm.qry_EntradasAlm.FieldByName('Albaranes').AsInteger;
                xExcel.Sheets[0].AsInteger[i,m] := dm.qry_EntradasAlm.FieldByName('pales').AsInteger;
                contador:=contador+ dm.qry_EntradasAlm.FieldByName('pales').AsInteger;
                arrayTotalDia[m-j]:=arrayTotalDia[m-j]+CalculaTarifa( edtcliente.Text,codServicio,0,0, dm.qry_EntradasAlm.FieldByName('albaranes').AsInteger,15,dm.qry_EntradasAlm.FieldByName('fecha').AsDateTime);
                arrayTotalDia[m-j]:=arrayTotalDia[m-j]+CalculaTarifa( edtcliente.Text,codServicio,0,0, dm.qry_EntradasAlm.FieldByName('pales').AsInteger,13,dm.qry_EntradasAlm.FieldByName('fecha').AsDateTime);
                arrayTotalDia[m-j]:=arrayTotalDia[m-j]+CalculaTarifa( edtcliente.Text,codServicio,0,0, dm.qry_EntradasAlm.FieldByName('lineas').AsInteger,14,dm.qry_EntradasAlm.FieldByName('fecha').AsDateTime);
                total_entrada:=total_entrada+arrayTotalDia[m-j];
                xExcel.Sheets[0].asFloat[i+3,m] := arrayTotalDia[m-j];
                xExcel.Sheets[0]. Cell[i+3,m].NumberFormat := '#,##0.00 €';
                total_factura:=total_factura+arrayTotalDia[m-j]; //voy sumando el precio de las entradas
                //total_factura:=total_factura+CalculaTarifa(edtcliente.Text,codServicio,StrToInt(min),StrToInt(max), dm.qry_EntradasAlm.FieldByName('lineas').AsInteger,StrToInt(id_unidad),fechaq);
                Inc(x);Inc(col);
                //cont_ant[m-j]:=  dm.qry_EntradasAlm.FieldByName('lineas').AsInteger;
                max_ant:=max;
                dm.qry_EntradasAlm.Next;
               end;
              xExcelResumen.Sheets[0].AsString[0,posicion_resumen]:='Total entradas';
              xExcelResumen.Sheets[0].asInteger[1,posicion_resumen]:= contador;
              xExcelResumen.Sheets[0].AsString[2,posicion_resumen]:= '';
              xExcelResumen.Sheets[0].asFloat[3,posicion_resumen]:=total_entrada;
              xExcelResumen.Sheets[0]. Cell[3,posicion_resumen].NumberFormat := '#,##0.00 €';
              Inc(posicion_resumen,1);
            end
            else if ((id_unidad='2') and (max='9999')) then //por exceso de lineas
              begin
               with dm.qryEntradasLineasExtra do
                begin
                 CLOSE;
                 //modificar con query que diga iván
                 ParamByName('cliente').AsString:=edtCliente.Text;
                 ParamByName('ini').AsDate:= dtDesde.Date;
                 ParamByName('fin'). AsDate:= dtHasta.Date;
                 ParamByName('min').AsString:= min;
                 //ParamByName('max').AsString:= '999999';
                 Open;
                 First;
                 //m:=j+1;
                 m:=altura_cabecera+2;
                 //revisar esta parte
                 while (not Eof) do
                  begin
//                 while ((xExcel.Sheets[0].AsString[anchura_cabecera+1,m]<>FormatDateTime('yyyy-mm-dd',dm.qryEntradasLineasExtra.FieldByName('fecha').AsDateTime)) and (m<=MonthDays[IsLeapYear(anyo)][mes])) do
                   while ((xExcel.Sheets[0].AsString[anchura_cabecera,m]<>FormatDateTime('yyyy-mm-dd',dm.qryEntradasLineasExtra.FieldByName('fecha').AsDateTime))) do
                    begin
                     inc(m);
                    end;
                   resultado:=dm.qryEntradasLineasExtra.FieldByName('lineas').AsInteger-strtoint(min)*dm.qryEntradasLineasExtra.FieldByName('dias').AsInteger;
                   xExcel.Sheets[0].AsInteger[i,m] := resultado;
                   xExcel.Sheets[0].AsInteger[i-1,m] := cont_ant[m-j-1] + dm.qryEntradasLineasExtra.FieldByName('dias').AsInteger;
                   fechaq:=StrToDate(FormatDateTime('dd/mm/yyyy',dm.qryEntradasLineasExtra.FieldByName('fecha').AsDateTime));
                   arrayTotalDia[m-j-1]:=arrayTotalDia[m-j-1]+CalculaTarifa( edtcliente.Text,codServicio,0,0, resultado,StrToInt(id_unidad),fechaq)+CalculaTarifa( edtcliente.Text,codServicio,StrToInt(min_ant),strtoint(max_ant), dm.qryEntradasLineasExtra.FieldByName('dias').AsInteger,StrToInt(id_unidad_ant),fechaq);
                   Inc(x);
                   dm.qryEntradasLineasExtra.Next;
                  end
                end;
              end;
          end;
         if((id_unidad='13') or (id_unidad='14') or (id_unidad='15')) then
            i:=i
         else  Inc(i);
         dm.qryF_tmp2.Next;
         x:=j;
        end;
       if(( id_unidad='1') or ((id_unidad='2'))) then
        begin
         m:=j;
         xExcel.Sheets[0].asString[i,m] := 'Total Día';
         //xExcel.Sheets[0].Cell[i,m].CellColorRGB:= tablafuera ;
         inc(m);
         for  z:=0 to Length(arrayTotalDia)-1 do
          begin
           xExcel.Sheets[0].asfloat[i,m] := arrayTotalDia[z];
           xExcel.Sheets[0]. Cell[i,m].NumberFormat := '#,##0.00 €';
           total:=total+arrayTotalDia[z];
           Inc(m);
          end;
         if(contador>=LineasGratis) then
          total_factura:=total_factura+total;
         xExcel.Sheets[0].AsFormula[i,m] := 'SUM('+arrayLetras[i+1]+''+inttostr(m)+':'+arrayLetras[i+1]+''+inttostr(m-dias)+')';
         xExcel.Sheets[0]. Cell[i,m].NumberFormat := '#,##0.00 €';
         //xExcel.Sheets[0].AsString[i-1,m] := 'Total:';
         xExcelResumen.Sheets[0].AsString[0,posicion_resumen]:='Total entradas';
         //xExcelResumen.Sheets[0].Cell[1,posicion_resumen].CellColorRGB:= tablafuera ;
         xExcelResumen.Sheets[0].AsString[1,posicion_resumen]:= IntToStr(contador);
         //xExcelResumen.Sheets[0].Cell[2,posicion_resumen].CellColorRGB:= tabladentro ;
         xExcelResumen.Sheets[0].AsString[2,posicion_resumen]:= '';
         //xExcelResumen.Sheets[0].Cell[3,posicion_resumen].CellColorRGB:= tabladentro ;
         xExcelResumen.Sheets[0].asFloat[3,posicion_resumen]:=total;
         xExcelResumen.Sheets[0]. Cell[3,posicion_resumen].NumberFormat := '#,##0.00 €';
         //xExcelResumen.Sheets[0].Cell[4,posicion_resumen].CellColorRGB:= tabladentro ;
         total_entradas:=total;
         Inc(posicion_resumen,1);
        end;
       if( id_unidad='4') then //por lineas
        begin
         m:=j;
         //total_factura:=total_factura+CalculaTarifa(edtcliente.Text,codServicio,0,0, total,StrToInt(id_unidad),fechaq);
         total_factura:=total_factura+total_entrada;
         total_mer_entradas:=total_entrada;
        //comento xExcel.Sheets[0].asFloat[i-1,m+MonthDays[IsLeapYear(anyo)][mes]+1] :=total;
         //xExcel.Sheets[0]. Cell[i-1,m+MonthDays[IsLeapYear(anyo)][mes]+1].NumberFormat := '#,##0';
         //--nuevo--
         xExcel.Sheets[0].asFormula[i-1,m+MonthDays[IsLeapYear(anyo)][mes]+1] := 'SUM('+Arrayletras[i]+''+inttostr(m+2)+':'+arrayLetras[i]+''+inttostr(m+MonthDays[IsLeapYear(anyo)][mes]+1)+')';
         xExcel.Sheets[0].asFormula[i,m+MonthDays[IsLeapYear(anyo)][mes]+1] := 'SUM('+Arrayletras[i+1]+''+inttostr(m+2)+':'+arrayLetras[i+1]+''+inttostr(m+MonthDays[IsLeapYear(anyo)][mes]+1)+')';
         xExcel.Sheets[0].asFormula[i+1,m+MonthDays[IsLeapYear(anyo)][mes]+1] := 'SUM('+Arrayletras[i+2]+''+inttostr(m+2)+':'+arrayLetras[i+2]+''+inttostr(m+MonthDays[IsLeapYear(anyo)][mes]+1)+')';
        // xExcel.Sheets[0].asFloat[i,m+MonthDays[IsLeapYear(anyo)][mes]+1] :=CalculaTarifa(edtcliente.Text,codServicio,0,0, total,StrToInt(id_unidad),fechaq);
         //xExcel.Sheets[0]. Cell[i,m+MonthDays[IsLeapYear(anyo)][mes]+1].NumberFormat := '#,##0.00';
         xExcelResumen.Sheets[0].AsString[0,posicion_resumen]:='Total entradas';
         //xExcelResumen.Sheets[0].Cell[1,posicion_resumen].CellColorRGB:= tablafuera ;
         xExcelResumen.Sheets[0].AsString[1,posicion_resumen]:=floatToStr(total);
         //xExcelResumen.Sheets[0].Cell[2,posicion_resumen].CellColorRGB:= tabladentro ;
       //  xExcelResumen.Sheets[0].AsString[3,posicion_resumen]:='';
         //xExcelResumen.Sheets[0].Cell[3,posicion_resumen].CellColorRGB:= tabladentro ;
         //xExcelResumen.Sheets[0].asFloat[3,posicion_resumen]:=CalculaTarifa(edtcliente.Text,codServicio,0,0, total,StrToInt(id_unidad),fechaq);
         //xExcelResumen.Sheets[0]. Cell[3,posicion_resumen].NumberFormat := '#,##0.00 €';
         //xExcelResumen.Sheets[0].Cell[4,posicion_resumen].CellColorRGB:= tabladentro ;
            total_entradas:=total_entrada;
         Inc(posicion_resumen,1);
         //Hay que ver si tiene fijo con lineas de entrada o si al final a partir de las tarifas (poniendo lineas de fijo en min/max por expedición y el precio en exceso lo coge bien
        end
      end;
      total_mer_entradas:=total_entrada;
     Result:=m;
     //xExcel.Write;
     col:=m+MonthDays[IsLeapYear(anyo)][mes]+1;
     Screen.Cursor:=crDefault;
     end
   end
  else
   if(id_unidad='unidades') then
    begin
     //contabilizo unidades por matricula
     with dm.qry_EntradasUnidades do
      begin
       Close;
       ParamByName('id').AsInteger:= StrToInt(edtCliente.Text);
       ParamByName('ini').AsDate:= dtDesde.Date;
       ParamByName('fin').AsDate:= dtHasta.Date;
       Open;
       while not eof do
        begin
         while (xExcel.Sheets[0].AsString[anchura_cabecera+1,m]<>dm.qry_EntradasUnidades.FieldByName('fecha').AsString) do
          begin
           inc(m);
          end;
        xExcel.Sheets[0].AsInteger[i,m] := dm.qry_EntradasUnidades.FieldByName('lineas').AsInteger;
        xExcelResumen.Sheets[0].AsInteger[i,m] := dm.qry_EntradasUnidades.FieldByName('lineas').AsInteger;
        auxiliar:=dm.qry_EntradasUnidades.FieldByName('fecha').AsString;
        total:=total+dm.qry_EntradasUnidades.FieldByName('lineas').AsInteger;
        dd:=copy(auxiliar, 9, 2);
        mm:=copy(auxiliar, 6, 2);
        yyyy:=copy(auxiliar, 0, 4);
        fechaq:=StrToDate(dd+'/'+mm+'/'+yyyy);
        //total:=total+CalculaTarifa( edtcliente.Text,codServicio, dm.qry_sql.FieldByName('contador').AsInteger,fechaq);
        arrayTotalDia[m-j]:=arrayTotalDia[m-j]+CalculaTarifa( edtcliente.Text,codServicio,StrToInt(min),StrToInt(max), dm.qry_EntradasUnidades.FieldByName('uds').AsInteger,StrToInt(id_unidad),fechaq);
        total_factura:=total_factura+CalculaTarifa( edtcliente.Text,codServicio,StrToInt(min),StrToInt(max), dm.qry_EntradasUnidades.FieldByName('uds').AsInteger,StrToInt(id_unidad),fechaq);
        total_mer_salidas:=total_mer_salidas+CalculaTarifa( edtcliente.Text,codServicio,StrToInt(min),StrToInt(max), dm.qry_EntradasUnidades.FieldByName('uds').AsInteger,StrToInt(id_unidad),fechaq);
        total_entradas:=total_mer_salidas;
        Inc(x);Inc(col);
        max_ant:=max;
        dm.qry_EntradasUnidades.Next;
       end;
     end;
   end
  else if (servicio='masivo') then
   begin


   end
  else if(servicio='kgs') then //no se si esto forma parte de convencional
   begin


   end;
  col:=altura_cabecera+MonthDays[IsLeapYear(anyo)][mes];
 except
  on e:Exception do
   begin
    log.Add('Las recepciones de material del cliente '+edtcliente.text+ '-'+lblcliente.Caption+' no se han calculado por algún problema.('+e.message+')');
    Inc(errores);
   end;
 end;
 end
 else //solo para merydeis
 begin
 try
  lineasGratis:=0;
  contador:=0;
  primera_pasada:=True;
  fechaINI:=FormatDateTime('mm/dd/yyyy', dtDesde.Date);
  FormatDateTime('mm/dd/yyyy', dtDesde.Date);
  DecodeDate(dtDesde.date,anyo,Mes,Dia);
  if(ruta.path='') then
   begin
    ruta.Execute;
    Screen.Cursor:=crDefault;
    xExcel.Filename:= ruta.Path + '\Recepcion de material '+edtCliente.Text+'.xlsx';
   end;
  altura_cabecera:=fila;
  anchura_cabecera:=columna;
  codServicio:='3000';
  i:=anchura_cabecera;
  j:=altura_cabecera;
  xExcel.Sheets[0].AsString[i,j] := 'RECEPCIÓN DE MATERIAL';
  //Inc(i);
  inc(j);
  xExcel.Sheets[0].AsString[i,j] := 'Fecha';
  DecodeDate(dtDesde.Date,anyo,mes,dia);
  if(mes<10) then mesString:='0'+inttostr(mes)
  else mesString:=inttostr(mes);
  for z:=0 to MonthDays[IsLeapYear(anyo)][mes]-1 do
   begin
    if(z<9) then xExcel.Sheets[0].AsString[i,j+z+1] := IntToStr(ANYO) +'-'+mesString+'-0'+ IntToStr(z+1)
    else xExcel.Sheets[0].AsString[i,j+z+1] := IntToStr(ANYO) +'-'+mesString+'-'+ IntToStr(z+1);
    inc(x);
    xExcel.Sheets[0].AutoSizeCell(i,j+z,true,true);
   end;
  xExcel.Sheets[0].AsString[i,j+z+1] :='Total:';
  //X:=RESULTADO;
  i:=anchura_cabecera+1;
  j:=altura_cabecera+1;
  SetLength(arrayTotalDia,MonthDays[IsLeapYear(anyo)][mes]);
  SetLength(cont_ant,MonthDays[IsLeapYear(anyo)][mes]);
  xExcel.Sheets[0].AsString[i,j] := 'Albaranes';
  xExcel.Sheets[0].AsFormula[i,j+(MonthDays[IsLeapYear(anyo)][mes])+1]:= 'SUM('+Arrayletras[i+1]+''+inttostr(j+2)+':'+arrayLetras[i+1]+''+inttostr(j+1+MonthDays[IsLeapYear(anyo)][mes])+')';
  xExcel.Sheets[0].AsString[i+1,j] := 'Lineas';
  xExcel.Sheets[0].AsFormula[i+1,j+(MonthDays[IsLeapYear(anyo)][mes])+1]:= 'SUM('+Arrayletras[i+2]+''+inttostr(j+2)+':'+arrayLetras[i+2]+''+inttostr(j+1+MonthDays[IsLeapYear(anyo)][mes])+')';
  xExcel.Sheets[0].AsString[i+2,j] := 'Palés';
  xExcel.Sheets[0].AsFormula[i+2,j+(MonthDays[IsLeapYear(anyo)][mes])+1] := 'SUM('+Arrayletras[i+3]+''+inttostr(j+2)+':'+arrayLetras[i+3]+''+inttostr(j+1+MonthDays[IsLeapYear(anyo)][mes])+')';
  xExcel.Sheets[0].AsString[i+3,j] := 'IMEIS';
  xExcel.Sheets[0].AsFormula[i+3,j+(MonthDays[IsLeapYear(anyo)][mes])+1] := 'SUM('+Arrayletras[i+4]+''+inttostr(j+2)+':'+arrayLetras[i+4]+''+inttostr(j+1+MonthDays[IsLeapYear(anyo)][mes])+')';
  xExcel.Sheets[0].AsString[i+4,j] := 'Total';
  xExcel.Sheets[0].AsFormula[i+4,j+(MonthDays[IsLeapYear(anyo)][mes])+1] := 'SUM('+Arrayletras[i+5]+''+inttostr(j+2)+':'+arrayLetras[i+5]+''+inttostr(j+1+MonthDays[IsLeapYear(anyo)][mes])+')';
  xExcel.Sheets[0]. Cell[i+4,j+(MonthDays[IsLeapYear(anyo)][mes])+1].NumberFormat := '#,##0.00 €';
  xExcel.Sheets[0].AutoSizeCell(i,j,true,true);
    //autowidth
  with dm.qry_EntradasAlmMer do
   begin
    CLOSE;
    ParamByName('cliente').AsString:=edtCliente.Text;
    ParamByName('ini').AsDate:= dtDesde.Date;
    ParamByName('fin'). AsDate:= dtHasta.Date;
    Open;
    First;
    m:=altura_cabecera+2;
    j:=MonthDays[IsLeapYear(anyo)][mes];
    while (not Eof) do
     begin
      //qry_EntradasAlm
      while ((xExcel.Sheets[0].AsString[anchura_cabecera,m]<>FormatDateTime('yyyy-mm-dd',dm.qry_EntradasAlmMer.FieldByName('fecha').AsDateTime))) do
       begin
        inc(m);
       end;
      alb:=dm.qry_EntradasAlmMer.FieldByName('Albaranes').AsInteger;
      xExcel.Sheets[0].AsInteger[i,m] := alb;
      lin:=dm.qry_EntradasAlmMer.FieldByName('lineas').AsInteger;
      xExcel.Sheets[0].AsInteger[i+1,m] := lin ;
      Pal:=dm.qry_EntradasAlmMer.FieldByName('pales').AsInteger;
      xExcel.Sheets[0].AsInteger[i+2,m] := pal;
      imei:=dm.qry_EntradasAlmMer.FieldByName('imeis').AsInteger;
      xExcel.Sheets[0].AsInteger[i+3,m] := imei;
      //inc(contador,dm.qry_EntradasAlm.FieldByName('lineas').AsInteger);
      fechaq:=StrToDate(FormatDateTime('dd/mm/yyyy',dm.qry_EntradasAlmMer.FieldByName('fecha').AsDateTime));
      DecodeDate(dm.qry_EntradasAlmMer.FieldByName('fecha').AsDateTime,anyoMer,mesMer,diaMer);
      arrayTotalDia[diaMer-1]:=arrayTotalDia[diaMer-1]+CalculaTarifa( '5100',codServicio,0,0, alb,8,fechaq);
      arrayTotalDia[diaMer-1]:=arrayTotalDia[diaMer-1]+CalculaTarifa( '5100',codServicio,0,0, lin,6,fechaq);
      arrayTotalDia[diaMer-1]:=arrayTotalDia[diaMer-1]+CalculaTarifa( '5100',codServicio,0,0, pal,9,fechaq);
      arrayTotalDia[diaMer-1]:=arrayTotalDia[diaMer-1]+CalculaTarifa( '5100',codServicio,0,0, imei,10,fechaq);
      dm.qry_EntradasAlmMer.next;
      //inc(m);
     end;
     m:=altura_cabecera+2;
     for  z:=0 to Length(arrayTotalDia)-1 do
      begin
       xExcel.Sheets[0].asfloat[i+4,m] := arrayTotalDia[z];
       xExcel.Sheets[0]. Cell[i+4,m].NumberFormat := '#,##0.00 €';
       total:=total+arrayTotalDia[z];
       Inc(m);
      end;
     total_factura:=total_factura+total;
     total_mer_entradas:=total;
     Result:=m;
     col:=m;
     Screen.Cursor:=crDefault;
   end;
  col:=altura_cabecera+MonthDays[IsLeapYear(anyo)][mes];
 except
  on e:Exception do
   begin
    log.Add('Las recepciones de material del cliente '+edtcliente.text+ '-'+lblcliente.Caption+' no se han calculado por algún problema.('+e.message+')');
    Inc(errores);
   end;
 end;
 end;
end;

function TMain.serviciosExtras(fila: Integer; columna: Integer; codCliente: Integer; servicio: string; out col: Integer):integer;
var
 anyo,mes,dia:word;
 i,j,x,z,m,resultado,altura_cabecera,anchura_cabecera,pasa:Integer;
 fechaq,fechafin:TDate;
 dd,mm,yyyy,id_unidad_ant,min,min_ant,max,max_ant,id_unidad,codservicio:string;
 total,total_extras:Double;
 arrayTotalDia :array of Double;
 cont_ant :array of integer;
 auxiliar,mesString,comparaFecha:string;
 grupo:integer;
begin
 try
  total:=0;
  pasa:=0;
  fechaINI:=FormatDateTime('mm/dd/yyyy', dtDesde.Date);
  FormatDateTime('mm/dd/yyyy', dtDesde.Date);
  DecodeDate(dtDesde.date,anyo,Mes,Dia);
  if(ruta.path='') then
   begin
    ruta.Execute;
    Screen.Cursor:=crDefault;
    xExcel.Filename:= ruta.Path + '\Recepcion de material '+edtCliente.Text+'.xlsx';
   end;
  DecodeDate(dtDesde.Date,anyo,mes,dia);
  if(mes<10) then mesString:='0'+inttostr(mes)
  else mesString:=inttostr(mes);
  SetLength(arrayTotalDia,MonthDays[IsLeapYear(anyo)][mes]);
  SetLength(cont_ant,MonthDays[IsLeapYear(anyo)][mes]);
  m:=fila+1;
  with dm.qryExtras do
   begin
    Close;
    ParamByName('cli').AsInteger:=codCliente;
    ParamByName('ini').AsDate:=dtDesde.Date;
    ParamByName('fin').AsDate:=dtHasta.Date;
    Open;
    if not eof then
     while not eof do
      begin
       if(pasa=0) then
        begin
         altura_cabecera:=fila;
         anchura_cabecera:=columna;
         i:=anchura_cabecera;
         j:=altura_cabecera;
         xExcel.Sheets[0].AsString[i,m] := 'SERVICIOS EXTRAS';
         //Inc(i);
         inc(m,2);inc(pasa);
         xExcel.Sheets[0].AsString[i,m-1] := 'Fecha';
         //xExcel.Sheets[0].Cell[i,m-1].CellColorRGB:= tablafuera ;
         xExcel.Sheets[0].AsString[i+1,m-1] := 'Servicio';
         //xExcel.Sheets[0].Cell[i+1,m-1].CellColorRGB:= tablafuera ;
         xExcel.Sheets[0].AsString[i+2,m-1] := 'Descripcion';
         //xExcel.Sheets[0].Cell[i+2,m-1].CellColorRGB:= tablafuera ;
         xExcel.Sheets[0].AsString[i+3,m-1] := 'Unidades';
         //xExcel.Sheets[0].Cell[i+3,m-1].CellColorRGB:= tablafuera ;
         xExcel.Sheets[0].AsString[i+4,m-1] := 'Precio';
         //xExcel.Sheets[0].Cell[i+4,m-1].CellColorRGB:= tablafuera ;
        end;
       auxiliar:=FieldByName('fecha').AsString;
       //separar la fecha y recomponer como en el resto de servicios
       //si es merydeis y es un concepto de almacen no aparece pero se suma el total a total_mer_almacen;
       //query para sacar si es cliente con grupo
       dm.qry_grupoCliente.close;
       dm.qry_grupoCliente.selectsql.text:=' select id_cliente_grupo from g_clientes where codigo='+edtcliente.text;
       dm.qry_grupoCliente.open;
       grupo:= dm.qry_grupoCliente.fieldbyname('id_cliente_grupo').asInteger;
       if grupo=6 then
        begin
        if ((pos('28-',UpperCase(fieldbyname('servicio').asString))>0) or (pos('29-',UpperCase(fieldbyname('servicio').asString))>0) or (pos('RACK',UpperCase(fieldbyname('DESCRIPCION').asString))>0) or (pos('FIJO ESPACIO',UpperCase(fieldbyname('DESCRIPCION').asString))>0) or (pos('FIJO MENSUAL ALMACENAJE',UpperCase(fieldbyname('DESCRIPCION').asString))>0))
         then
          begin
           total_mer_almacen:=total_mer_almacen+FieldByName('total').asFloat;
           total_mer_extras:=total_mer_extras-FieldByName('total').asFloat;
           total_factura:=total_factura+ FieldByName('total').asFloat;
          end;
         if(FieldByName('se_repite').AsInteger=1) then
           xExcel.Sheets[0].AsString[i,m] := DateToStr(dtHasta.Date)
         else xExcel.Sheets[0].AsString[i,m] := FieldByName('fecha').AsString;
        xExcel.Sheets[0].AsString[i+1,m] := FieldByName('servicio').AsString;
        xExcel.Sheets[0].AsString[i+2,m] := FieldByName('descripcion').AsString ;
        xExcel.Sheets[0].AsFloat[i+3,m] := FieldByName('unidades').AsFloat ;
        xExcel.Sheets[0].AsFloat[i+4,m] := FieldByName('total').AsCurrency;
        xExcel.Sheets[0]. Cell[i+4,m].NumberFormat := '#,##0.00 €';
        total_mer_extras:=total_mer_extras+FieldByName('total').AsCurrency;
        total:=total_mer_extras;  //hago esto para en la ultima pasada no tener que crear condicion.
        //total_factura:=total_factura+FieldByName('total').AsFloat;
 //       total_factura:=total_factura+total;
        inc(m);
        next;
        end
       else begin
       if(FieldByName('se_repite').AsInteger=1) then
        xExcel.Sheets[0].AsString[i,m] := DateToStr(dtHasta.Date)
       else xExcel.Sheets[0].AsString[i,m] := FieldByName('fecha').AsString;

       xExcel.Sheets[0].AsString[i+1,m] := FieldByName('servicio').AsString;
       xExcel.Sheets[0].AsString[i+2,m] := FieldByName('descripcion').AsString ;
       xExcel.Sheets[0].AsFloat[i+3,m] := FieldByName('unidades').AsFloat ;
       xExcel.Sheets[0].AsFloat[i+4,m] := FieldByName('total').AsCurrency;
       xExcel.Sheets[0]. Cell[i+4,m].NumberFormat := '#,##0.00 €';
       total:=total+FieldByName('total').AsCurrency;
//       total_factura:=total_factura+FieldByName('total').AsFloat;
       inc(m);
       next;
       //end;
      end;
    end;
     if (pasa=1) then
      begin
       total_factura:=total_factura+total;
       total_extras:=total;
       xExcel.Sheets[0].AsString[i+3,m] :='Total';
       xExcel.Sheets[0].AsFormula[i+4,m] := 'SUM('+arrayLetras[i+5]+''+inttostr(j+4)+':'+arrayLetras[i+5]+''+inttostr(m)+')';
       xExcel.Sheets[0]. Cell[i+4,m].NumberFormat := '#,##0.00 €';
       xExcelResumen.Sheets[0].AsString[0,posicion_resumen] :='Total servicios extras';
       //xExcelResumen.Sheets[0].Cell[1,posicion_resumen].CellColorRGB:= tablafuera ;
       xExcelResumen.Sheets[0].AsString[1,posicion_resumen] :='';
       //xExcelResumen.Sheets[0].Cell[2,posicion_resumen].CellColorRGB:= tabladentro ;
       xExcelResumen.Sheets[0].AsString[2,posicion_resumen] :='';
       //xExcelResumen.Sheets[0].Cell[3,posicion_resumen].CellColorRGB:= tabladentro ;
       xExcelResumen.Sheets[0].asFloat[3,posicion_resumen] := total;
       xExcelResumen.Sheets[0]. Cell[3,posicion_resumen].NumberFormat := '#,##0.00 €';
       //xExcelResumen.Sheets[0].Cell[4,posicion_resumen].CellColorRGB:= tabladentro ;
       inc(posicion_resumen,1);

       total_mer_extras:=total;
      end;
   end;
  total_extras:=total+total_fijo;
  xExcel.Sheets[0].AutoWidthCol(i+2);
  Result:=m;
  xExcel.write;
  xExcelResumen.write;
  xExcel.CleanupInstance;
  xExcelResumen.CleanupInstance;
 except
  on e:Exception do
   begin
    log.Add('Los servicios extras del cliente '+edtcliente.text+ '-'+lblcliente.Caption+' no se han calculado por algún problema.('+e.message+')');
    Inc(errores);
   end;
 end;
end;
{*------------------------------------------------------------------------------
  Reemplaza las variables de la query general con los datos facilitados por el usuario
  @return Query final
-------------------------------------------------------------------------------}
function TMain.reemplazar(tex:string):string;
begin
tex:=StringReplace(tex, ':ini', ' '+quotedstr(fechaini) +' ',[rfReplaceAll, rfIgnoreCase]);
tex:=StringReplace(tex, ':fin', ' '+quotedstr(fechafin) +'',[rfReplaceAll, rfIgnoreCase]);
tex:=StringReplace(tex, ':cliente',edtCliente.Text,[rfReplaceAll, rfIgnoreCase]);
tex:=StringReplace(tex, ':almacen',almacen,[rfReplaceAll, rfIgnoreCase]);
tex:=StringReplace(tex, ':comparacion',comparacion,[rfReplaceAll, rfIgnoreCase]);
Result:=tex;
end;
{*------------------------------------------------------------------------------
  Comprueba que todos los campos han sido rellenados.
  @cont Contador de errores
  @return  Devuelve true en caso de ser válido, false en caso contrario
-------------------------------------------------------------------------------}
function TMain.comprobar:Boolean;
var cont:Integer;
begin
cont:=0;
Result:=True;
if(chkAlmacen.Enabled=True) then
 if(chkAlmacen.ItemIndex=-1) then inc(cont);
if(dthasta.date-dtdesde.Date)<0 then inc(cont);
if(edtCliente.Text='') then Inc(cont);
if(cont>0) then
 begin
  ShowMessage('Revise los datos introducidos. Existe alguno sin rellenar o rellenado incorrectamente');
  Screen.Cursor:=crDefault;
  Result:=False;
 end;
end;
{*------------------------------------------------------------------------------
  Devuelve 0 si solo tiene preparacion sin imei, 1 si solo tiene preparacion con imei y 2 si tiene ambos , -1 si no tiene nada
-------------------------------------------------------------------------------}
function TMain.quePedidosTiene:integer;
begin
 with dm.qryTiposPreparacion do
 begin
  Close;
  ParamByName('INI').AsDateTime:=dtDesde.Date;
  ParamByName('FIN').AsDateTime:=dtHasta.Date;
  ParamByName('CLI').AsInteger:=StrToInt(edtCliente.Text);
  Open;
  if (not Eof) then
   begin
     if(FieldByName('IMEIS').AsInteger<=0) then Result:=0
     else if(FieldByName('IMEIS').AsInteger=FieldByName('CANTIDAD').AsInteger) then Result:=1
          else Result:=2;
   end
  else Result:=-1
 end;
end;

function TMain.LimpiarFilas(fila:Integer):integer;
var
i: integer;
cont:integer;
begin
  i:=6;
  cont:=0;
 while (i<fila-cont) do
  begin
   if(xExcelResumen.Sheets[0].AsString[1,i]='') then
    begin
     xExcelResumen.Sheets[0].DeleteRows(i,i);
     inc(cont);
    end
   else Inc(i);
  end;
 result:= i;
end;
{$ENDREGION}
end.
