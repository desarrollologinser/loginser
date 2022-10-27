{**************************************************
*********** Requerimientos de fbuscapro ***********
***************************************************

uses udm  //datamodule udm - dm
dm.busqueda  //TbFIBDataset en udm
dm.dsbusqueda  //TDataSource en udm linked with dm.busqueda y linked con RxDbGrid1

{**************************************************
******* Procedimiento de Llamada a fbuscapro ******
***************************************************
procedure selec_docum(e:integer);                               //En caso de llamar a multiples edits
begin
with fbuscapro do begin
 limpia_fields;     multiselect:=false;    livekey:=false;      //Crea Strings, Multiselect,Evento KeyUp
// if con_con.items.count=3 then con_con.items.delete(2);       //Quitar condición 'Or' del radiogroup
// wide[1]:=70;   wide[2]:=80;   wide[3]:=65;   wide[4]:=65;    //Anchuras de columnas
// ancho:=600;    alto:=400;   row_height:=17                   //Anchura,altura de la pantalla, altura de fila
 fields.commatext:='ano_ejer,cod_apl,fec_ini,fec_fin';          //Campos del select
 titulos.commatext:='Ejercicio,Aplicación,FecIni,FecFin';       //Nombres de Campos para el DBGrid
 from:='ejercicios';                                            //Tablas del query
 where:='';                                                     //Condiciones iniciales del query
 group:='';                                                       //Group by
 orden[1]:=2;  orden[2]:=1;   orden_ini:=0;                     //Orden de los campos,order by orden[1],orden[2],....,orden inicial 0=asc 1=desc
 busca:=1;   distinct:=0;                                       //campo de busqueda inicial, y distinct (0 No, 1 Sí)
 fillimpio:=false;   fil:='(c.fecha='23.03.2009')';             //lleva filtro inicial si=false no=true, filtro
 fil_tit:='(Fecha='+formatdatetime('dd.mm.yyyy',Date)+')';      //nombre del filtro

 showmodal;                                                     //Devuelve en el array valor como variants la fila entera

 if ((resultado) and not(dm.ejer.locate('ano_ejer;cod_apl',     //Resultado para buscar en tabla
     vararrayof([valor[1],valor[2]]),[]))) then
        raise exception.create('Ejercicio No Encontrado');

 if resultado then begin                                        //Resultado para llenar edits de busqueda
        if e=1 then begin
           e_ejer1.text:=valor[1];
           e_apl1.text:=valor[2];
        end;
        if e=2 then begin
           e_ejer2.text:=valor[1];
           e_apl2.text:=valor[2];
        end;

  if resultado then begin
  if not(dm.ejer.state in [dsedit,dsinsert]) then dm.ejer.edit;
   dm.ejer.fieldbyname('serie').asstring:=valor[1];

 end else raise exception.create('Ejercicio No Encontrado');
end;  //with
end;

{******************************************************************
******* Procedimiento de Llamada a fbuscapro con Multiselect ******
*******************************************************************

var     i:integer;          error:boolean;
begin
error:=false;
with fbuscapro do begin
 limpia_fields;                  multiselect:=true;    livekey:=false;
 fields.commatext:='cod_art,des_art';
 titulos.commatext:='Artículo,Nombre';
 from:='articulos_a';
 where:='(estado<''B'')';
 orden[1]:=2;  orden[2]:=1;   orden_ini:=0;                     //Orden de los campos,order by orden[1],orden[2],....,orden inicial 0=asc 1=desc
 busca:=1;   distinct:=0;                                       //campo de busqueda inicial, y distinct (0 No, 1 Sí)
 fillimpio:=false;   fil:='(c.fecha='23.03.2009')';             //lleva filtro inicial si=false no=true, filtro
 fil_tit:='(Fecha='+formatdatetime('dd.mm.yyyy',Date)+')';      //nombre del filtro

 showmodal;
 for i:=0 to fbuscapro.dbgrid1.selectedrows.count-1 do begin
   dm.busqueda.bookmark:=fbuscapro.dbgrid1.selectedrows.items[i];
        dm.q.close;
        dm.q.sql.clear;
        dm.q.sql.add('select cod_ubic from ubicart_a where cod_art='+quotedstr(dm.busqueda.fieldbyname('cod_art').asstring));
        dm.q.open;
        if dm.q.isempty then begin
                dm.ubicart.append;
                dm.ubicart.fieldbyname('cod_art').asstring:=dm.busqueda.fieldbyname('cod_art').asstring;
                dm.ubicart.fieldbyname('estado').asstring:='A';
                dm.ubicart.post;
        end
        else error:=true;
 end;
 if error then raise exception.create('Algún Artículo Ya Estaba Predeterminado En Alguna Otra Ubicación');
end;  //with
end;

***************************************************}

unit ubuscapro;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons,Grids, db,ComCtrls,ExtCtrls,
   DBGrids, JvDBGrid,sLabel,
  sSpeedButton, sBevel, sEdit, sGroupBox, Mask, sCustomComboEdit,
  sTooledit, sPanel, sMaskEdit, JvExDBGrids, FIBDataSet;

const
    max=20;

type
  Tfbuscapro = class(TForm)
    RxDBGrid1: TJvDBGrid;
    pn_1: TsPanel;
    Bevel2: TsBevel;
    Bevel1: TsBevel;
    lblLabel3: TsLabel;
    lb_orden: TsLabel;
    lblLabel5: TsLabel;
    lb_filtro: TsLabel;
    Bevel3: TsBevel;
    sb_SpeedButton4: TsSpeedButton;
    sb_SpeedButton5: TsSpeedButton;
    pn_2: TsPanel;
    lb_Label1: TsLabel;
    lb_busca: TsLabel;
    sb_busca: TsSpeedButton;
    sb_ok: TsSpeedButton;
    sb_SpeedButton3: TsSpeedButton;
    ed_busca: TsEdit;
    rg_str: TsRadioGroup;
    rg_int: TsRadioGroup;
    rg_ord: TsRadioGroup;
    rg_con: TsRadioGroup;
    ed_date: TsDateEdit;
    procedure sb_buscaClick(Sender: TObject);
    procedure sb_okClick(Sender: TObject);
    procedure ed_buscaKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure sb_SpeedButton3Click(Sender: TObject);
    procedure limpia_wide;
    procedure aplica_wide;
    procedure limpia_valor;
    procedure limpia_fields;
    procedure limpia_orden;
    procedure asigna_columns;
    procedure asigna_busca_orden;
    procedure asigna_fil;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sb_SpeedButton4Click(Sender: TObject);
    procedure sb_SpeedButton5Click(Sender: TObject);
    procedure ed_buscaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RxDBGrid1CellClick(Column: TColumn);
    procedure RxDBGrid1DblClick(Sender: TObject);
    procedure RxDBGrid1GetBtnParams(Sender: TObject; Field: TField;
      AFont: TFont; var Background: TColor; var SortMarker: TSortMarker;
      IsDown: Boolean);
    procedure RxDBGrid1TitleBtnClick(Sender: TObject; ACol: Integer;
      Field: TField);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    from,where:ansistring;                          //from y where del query
    wide:array [1..max] of integer;             //anchuras de columnas
    valor:array [1..max] of variant;            //valores de la fila seleccionada de retorno
    orden:array [1..max] of integer;            //indices de campos para el order by
    busca,distinct,orden_ini:integer;           //campo de busqueda inicial, si lleva distinct,orden inicial 0=asc 1=desc
    fields:tstrings;                            //Campos del query
    titulos:tstrings;                           //Titulos del dbgrid
    sel,ord,fil,fil_tit,group:ansistring;                 //Select,Orden,Filtro,Filtro Titulos
    tip_field:integer;                          //Tipo Columna, 0-String,1-BCD, 2-Date
    resultado,ordenando,ordlimpio,fillimpio,multiselect,livekey,living:boolean;
    //True si encuentra, false si no encuentra, para evitar doble click en titulo,orden está limpio,
    //filtro está limpio,multiselect en la dbgrid,evento keyup activado,está en modo live en este momento
  end;

var
  fbuscapro: Tfbuscapro;
  ancho:integer=600;                          //anchura de pantalla
  alto:integer=405;                           //altura de pantalla
  row_height:integer=17;                         //altura de filas

implementation

uses
    u_dm;

{$R *.DFM}

procedure Tfbuscapro.limpia_wide;   //Limpia vector de anchuras al cerrar form
var     i:integer;
begin
for i:=1 to max do wide[i]:=0;
end;

procedure Tfbuscapro.aplica_wide;        //Aplica vector de anchuras al enseñar form
var     i:integer;
begin
for i:=1 to max do             //Si anchura > 0 -> asigna anchura
   if wide[i]>0 then rxdbgrid1.columns[i-1].width:=wide[i];
for i:=0 to rxdbgrid1.columns.count-1 do rxdbgrid1.columns[i].width:=rxdbgrid1.columns[i].width+14;

RxDBGrid1.RowsHeight:=row_height;                         //altura de filas
end;

procedure Tfbuscapro.limpia_valor;      //limpia vector de valores de retorno
var     i:integer;
begin
for i:=1 to max do valor[i]:=-1;
end;

procedure Tfbuscapro.limpia_fields;   //limpia vector de campos
begin
fields:=tstringlist.create;
titulos:=tstringlist.create;
fields.Clear;
titulos.clear;
limpia_orden;
end;

procedure Tfbuscapro.limpia_orden;      //limpia vector de orden
var     i:integer;
begin
for i:=1 to max do orden[i]:=0;
end;

procedure Tfbuscapro.sb_buscaClick(Sender: TObject);     //Aplica nuevo filtro
var     s,t:ansistring;             a:real;
begin
if not(living) then begin
if ((tip_field in [0,1]) and (ed_busca.text='')) then raise exception.create('Campo de Busqueda Vacio');
if not(tip_field in [0,1,2]) then raise exception.create('Tipo de Campo No Permite Busquedas');

if tip_field=1 then begin
  try
    a:=strtofloat(ed_busca.text);
  except
   on EConvertError do raise exception.create('Datos No Validos');
  end;  //try
end;  //if

dm.busqueda.close;
dm.busqueda.sqls.SelectSQL.clear;
if distinct=1 then dm.busqueda.sqls.SelectSQL.add('select distinct ')
        else dm.busqueda.sqls.SelectSQL.add('select ');
dm.busqueda.sqls.SelectSQL.add(sel+' from '+from+' where (');
if where<>'' then dm.busqueda.sqls.SelectSQL.add(where+' and ');

if tip_field=0 then begin             //Campo String
  s:='('+fields[busca-1]+' like ';
  t:='('+titulos[busca-1];
  case rg_str.itemindex of
    0:begin
                s:=s+quotedstr(ed_busca.text+'%')+')';
                t:=t+' Empieza Por '''+ed_busca.text+''')';
      end;
    1:begin
                s:=s+quotedstr('%'+ed_busca.text+'%')+')';
                t:=t+' Contiene A '''+ed_busca.text+''')';
      end;
    2:begin
                s:=s+quotedstr('%'+ed_busca.text)+')';
                t:=t+' Acaba Por '''+ed_busca.text+''')';
      end;
  end;
end;

if tip_field=1 then begin               //Campo BCD / Integer
  s:='('+fields[busca-1];
  t:='('+titulos[busca-1];
  case rg_int.itemindex of
    0:begin s:=s+'=';  t:=t+'=';  end;
    1:begin s:=s+'>';  t:=t+'>';  end;
    2:begin s:=s+'<';  t:=t+'<';  end;
    3:begin s:=s+'>='; t:=t+'>='; end;
    4:begin s:=s+'<='; t:=t+'<='; end;
    5:begin s:=s+'<>'; t:=t+'<>'; end;
  end;
  s:=s+ed_busca.text+')';
  t:=t+ed_busca.text+')';
end;

if tip_field=2 then begin               //Campo Date
  s:='('+fields[busca-1];
  t:='('+titulos[busca-1];
  case rg_int.itemindex of
    0:begin s:=s+'=';  t:=t+'=';  end;
    1:begin s:=s+'>';  t:=t+'>';  end;
    2:begin s:=s+'<';  t:=t+'<';  end;
    3:begin s:=s+'>='; t:=t+'>='; end;
    4:begin s:=s+'<='; t:=t+'<='; end;
    5:begin s:=s+'<>'; t:=t+'<>'; end;
  end;
  s:=s+quotedstr(datetostr(ed_date.date))+')';
  t:=t+quotedstr(datetostr(ed_date.date))+')';
end;

if fillimpio then begin fil:=s;             fil_tit:=t;                 end
 else begin case rg_con.itemindex of
        0:begin fil:=s;             fil_tit:=t;                 end;
        1:begin fil:=fil+' and '+s; fil_tit:=fil_tit+' Y '+t;   end;
        2:begin fil:=fil+' or '+s;  fil_tit:=fil_tit+' O '+t;   end;
        end;
 end;
dm.busqueda.sqls.SelectSQL.add(fil+') ');
if group<>'' then dm.busqueda.sqls.SelectSQL.add('group by '+group);
if ord<>'' then dm.busqueda.sqls.SelectSQL.add('order by '+ord);
dm.busqueda.open;
aplica_wide;
asigna_columns;
asigna_fil;
fillimpio:=false;
end;  //if not(living)
end;

procedure Tfbuscapro.sb_okClick(Sender: TObject);     //Devuelve el valor de la fila en valor[x]
var     i:integer;
begin
 if ((not(dm.busqueda.isempty)) and not(multiselect)) then begin
        limpia_valor;
        resultado:=true;
        i:=0;
        while i<fields.count do begin
                valor[i+1]:=dm.busqueda.fields[i].text;
                inc(i);
        end;
end;
limpia_wide;
close;
end;

procedure Tfbuscapro.ed_buscaKeyPress(Sender: TObject; var Key: Char);    //Pulsa el Enter
begin
if ((key=chr(13)) and not(living)) then sb_buscaClick(Sender);
end;

procedure Tfbuscapro.FormShow(Sender: TObject);       //Inicio
var    i:integer;
begin
  width:=ancho;
  height:=alto;
  if multiselect then rxdbgrid1.options:=[dgtitles,dgrowlines,dgindicator,dgMultiSelect]
          else rxdbgrid1.options:=[dgtitles,dgrowlines,dgindicator];
  ordenando:=false;
  if orden[1]=0 then ordlimpio:=true
          else ordlimpio:=false;
  ed_busca.text:='';
  resultado:=false;
  if fillimpio=true then begin
    fil:='';
    fil_tit:='';
  end;
  asigna_fil;
  sel:='';   i:=0;
  if fields.Count>0 then
  begin
    while i<fields.count do begin
            sel:=sel+fields[i];       //construye lista de fields para query
            inc(i);
            if i<fields.count then sel:=sel+',';
    end;
    rg_ord.itemindex:=orden_ini;
    ord:='';   i:=1;
    while orden[i]<>0 do begin
            ord:=ord+fields[orden[i]-1];       //construye lista de fields para order by
            if rg_ord.itemindex=0 then ord:=ord+' Asc'
                                           else ord:=ord+' Desc';
            inc(i);
            if orden[i]<>0 then ord:=ord+',';
    end;
  end;
  dm.busqueda.close;
  dm.busqueda.sqls.SelectSQL.clear;
  if distinct=1 then dm.busqueda.sqls.SelectSQL.add('select distinct ')
          else dm.busqueda.sqls.SelectSQL.add('select ');
  dm.busqueda.sqls.SelectSQL.add(sel+' from '+from);
  if where<>'' then dm.busqueda.sqls.SelectSQL.add(' where ('+where);
  if not(fillimpio) then begin
    if where<>'' then  dm.busqueda.sqls.SelectSQL.add(' and '+fil+')')
    else  dm.busqueda.sqls.SelectSQL.add(' ('+fil+')')
  end else if where<>'' then  dm.busqueda.sqls.SelectSQL.add(')');
  if group<>'' then dm.busqueda.sqls.SelectSQL.add(' group by '+group);
  if ord<>'' then dm.busqueda.sqls.SelectSQL.add(' order by '+ord);
  dm.busqueda.open;
  asigna_busca_orden;
  asigna_columns;
  limpia_valor;
  aplica_wide;
  if ((tip_field=0) and (livekey)) then living:=true
                  else living:=false;
  if ed_busca.visible then ed_busca.SetFocus;
  if ed_date.Visible then ed_date.SetFocus;
end;

procedure Tfbuscapro.asigna_fil;                 //Asigna Filtro
begin
lb_filtro.caption:=fil_tit;
end;

procedure Tfbuscapro.asigna_columns;           //Asigna titulos de columnas
var     i:integer;
begin
i:=0;
while i<titulos.count do begin
   rxdbgrid1.columns[i].title.caption:=titulos[i];
   inc(i);
end;
end;

procedure Tfbuscapro.asigna_busca_orden;         //Asigna Busca y Orden
var     o,s:ansistring;       i:integer;
begin
lb_busca.caption:=titulos[busca-1];

s:='';  o:='';                        //Construye titulos del orden segun ord del query
for i:=1 to length(ord) do begin
  if ord[i]=chr(32) then begin  //nombre del campo en s
     o:=o+titulos[fields.indexof(s)];
     s:='';
  end else if ord[i]=chr(44) then begin   //asc o desc en s
     o:=o+' '+s+',';
     s:='';
  end else s:=s+ord[i];
end;
o:=o+' '+s;
lb_orden.caption:=o;
if ((dm.busqueda.fields[busca-1] is TFIBIntegerField) or
    (dm.busqueda.fields[busca-1] is TFloatField) or
    (dm.busqueda.fields[busca-1] is TBCDField) or
    (dm.busqueda.fields[busca-1] is TSmallintField) or
    (dm.busqueda.fields[busca-1] is TIntegerField)) then begin
                                                        tip_field:=1;
                                                        rg_int.visible:=true;
                                                        rg_str.visible:=false;
                                                        ed_busca.visible:=true;
                                                        ed_date.visible:=false;
                                                        living:=false;
                                                end;
if ((dm.busqueda.fields[busca-1] is TFIBStringField) or
    (dm.busqueda.fields[busca-1] is TStringField)) then begin
                                                        tip_field:=0;
                                                        rg_str.visible:=true;
                                                        rg_int.visible:=false;
                                                        ed_busca.visible:=true;
                                                        ed_date.visible:=false;
                                                        if livekey then living:=true
                                                                else living:=false;
                                                end;
if ((dm.busqueda.fields[busca-1] is TDateField) or
    (dm.busqueda.fields[busca-1] is TDateTimeField)) then begin
                                                        tip_field:=2;
                                                        rg_str.visible:=false;
                                                        rg_int.visible:=true;
                                                        ed_busca.visible:=false;
                                                        ed_date.visible:=true;
                                                        if ed_date.date<>0 then
                                                          ed_date.date:=strtodate(dm.busqueda.fields[busca-1].text);
                                                        living:=false;
                                                end;
end;

procedure Tfbuscapro.sb_SpeedButton3Click(Sender: TObject);   //Cancela
begin
limpia_valor;
limpia_wide;
close;
end;

procedure Tfbuscapro.FormClose(Sender: TObject; var Action: TCloseAction);   //Cierra Form
begin
fields.free;
titulos.free;
end;

procedure Tfbuscapro.FormCreate(Sender: TObject);
begin
rxdbgrid1.datasource:=dm.dsbusqueda;
end;

procedure Tfbuscapro.sb_SpeedButton4Click(Sender: TObject);    //Limpia Filtro
begin
dm.busqueda.close;
dm.busqueda.sqls.SelectSQL.clear;
if distinct=1 then dm.busqueda.sqls.SelectSQL.add('select distinct ')
        else dm.busqueda.sqls.SelectSQL.add('select ');
dm.busqueda.sqls.SelectSQL.add(sel+' from '+from);
if where<>'' then dm.busqueda.sqls.SelectSQL.add(' where ('+where+') ');
if group<>'' then dm.busqueda.sqls.SelectSQL.add(' group by '+group);
if ord<>'' then dm.busqueda.sqls.SelectSQL.add(' order by '+ord);
dm.busqueda.open;
aplica_wide;
fil:='';
fil_tit:='';
asigna_fil;
asigna_columns;
fillimpio:=true;
end;

procedure Tfbuscapro.sb_SpeedButton5Click(Sender: TObject);       //Limpia Orden
begin
if not(ordlimpio) then begin
        limpia_orden;
        ord:='';
        dm.busqueda.close;
        dm.busqueda.sqls.SelectSQL.Delete(dm.busqueda.sqls.SelectSQL.Count-1);
        dm.busqueda.open;
        aplica_wide;
        asigna_columns;
        asigna_busca_orden;
        ordlimpio:=true;
end;
end;

procedure Tfbuscapro.ed_buscaKeyUp(Sender: TObject; var Key: Word;          //Pulsa tecla
  Shift: TShiftState);
var     s,t,s2:ansistring;            i,idx:integer;        enc:boolean;
begin
if ((tip_field=0) and (key<>13) and (living)) then begin           //Si es tipo String

dm.busqueda.close;
dm.busqueda.sqls.SelectSQL.clear;
if distinct=1 then dm.busqueda.sqls.SelectSQL.add('select distinct ')
        else dm.busqueda.sqls.SelectSQL.add('select ');
dm.busqueda.sqls.SelectSQL.add(sel+' from '+from+' where (');
if where<>'' then dm.busqueda.sqls.SelectSQL.add(where+' and ');

  s:='('+fields[busca-1]+' like ';
  t:='('+titulos[busca-1];
  case rg_str.itemindex of
    0:begin
                s:=s+quotedstr(ed_busca.text+'%')+')';
                t:=t+' Empieza Por '''+ed_busca.text+''')';
      end;
    1:begin
                s:=s+quotedstr('%'+ed_busca.text+'%')+')';
                t:=t+' Contiene A '''+ed_busca.text+''')';
      end;
    2:begin
                s:=s+quotedstr('%'+ed_busca.text)+')';
                t:=t+' Acaba Por '''+ed_busca.text+''')';
      end;
  end;

if fillimpio then begin fil:=s;             fil_tit:=t;                 end
else begin
  idx:=LastDelimiter('(',fil);
  s2:='';
  if idx>0 then begin
    i:=idx+1;
    enc:=false;
    while (not(enc) and (i<length(fil))) do begin
      if ((fil[i]>=chr(65)) or (fil[i]=chr(46))) then s2:=s2+fil[i]
        else enc:=true;
      inc(i);
    end;
    if s2=fields[busca-1] then begin            //Es el mismo campo
      idx:=LastDelimiter('(',fil);
      s2:='';
      if idx>1 then for i:=1 to idx-1 do s2:=s2+fil[i]
            else s2:='';
      fil:=s2+s;

      idx:=LastDelimiter('(',fil_tit);
      s2:='';
      if idx>1 then for i:=1 to idx-1 do s2:=s2+fil_tit[i]
            else s2:='';
      fil_tit:=s2+t;
    end else begin                              //Es campo diferente
     case rg_con.itemindex of
        0:begin fil:=s;             fil_tit:=t;                 end;
        1:begin fil:=fil+' and '+s; fil_tit:=fil_tit+' Y '+t;   end;
        2:begin fil:=fil+' or '+s;  fil_tit:=fil_tit+' O '+t;   end;
     end;
    end;
  end;
end;

dm.busqueda.sqls.SelectSQL.add(fil+') ');
if group<>'' then dm.busqueda.sqls.SelectSQL.add('group by '+group);
if ord<>'' then dm.busqueda.sqls.SelectSQL.add('order by '+ord);
dm.busqueda.open;
aplica_wide;
asigna_columns;
asigna_fil;
fillimpio:=false;
end;
end;

procedure Tfbuscapro.RxDBGrid1CellClick(Column: TColumn);
begin
ordenando:=false;
end;

procedure Tfbuscapro.RxDBGrid1DblClick(Sender: TObject);
begin
if not(ordenando) then sb_okclick(self);
end;

procedure Tfbuscapro.RxDBGrid1TitleBtnClick(Sender: TObject; ACol: Integer;
  Field: TField);
var     i,j:integer;      ordprev:boolean;      t:ansistring;
begin
ordenando:=true;             //Verifica que columna ya esté ordenada- en ese caso cambio el orden Asc<->Desc (comparestr)
ordprev:=false;
for i:=1 to max do if orden[i]=acol+1 then ordprev:=true;
if ordprev then begin               //Columna Ya Ordenada
  t:='';
  for i:=1 to pos(fields[acol],ord) do t:=t+ord[i];     //en t hasta el campo
  while not(ord[i]=chr(32)) do begin                            //en t hasta el space despues del campo
        t:=t+ord[i];
        inc(i);
  end;
  inc(i);
  if uppercase(ord[i])='A' then begin                           //era Ascendente
    t:=t+' Desc';
    i:=i+3;
  end else begin                                                //era Descendente
    t:=t+' Asc';
    i:=i+4;
  end;
  for j:=i to length(ord) do t:=t+ord[j];                       //acaba con ord
  ord:=t;
  busca:=acol+1;
end else begin                  //Columna No Ordenada previamente
  if hiword(getkeystate(VK_CONTROL)) <> 0 then begin      //Control Pulsado
        i:=1;
        while orden[i]<>0 do inc(i);
        orden[i]:=acol+1;
        ord:=ord+','+fields[acol];
        if rg_ord.itemindex=0 then ord:=ord+' Asc'
                               else ord:=ord+' Desc';

  end else begin                                          //Normal
        busca:=acol+1;
        limpia_orden;
        orden[1]:=acol+1;
        ord:=fields[acol];
        if rg_ord.itemindex=0 then ord:=ord+' Asc'
                               else ord:=ord+' Desc';
  end;
end;
dm.busqueda.close;
if not(ordlimpio) then dm.busqueda.sqls.SelectSQL.Delete(dm.busqueda.sqls.SelectSQL.Count-1);
if group<>'' then dm.busqueda.sqls.SelectSQL.add(' group by '+group);
if ord<>'' then dm.busqueda.sqls.SelectSQL.add(' order by '+ord);
dm.busqueda.open;
aplica_wide;
asigna_columns;
asigna_busca_orden;
ordlimpio:=false;
rxdbgrid1.refresh;
end;

procedure Tfbuscapro.RxDBGrid1GetBtnParams(Sender: TObject; Field: TField;
  AFont: TFont; var Background: TColor; var SortMarker: TSortMarker;
  IsDown: Boolean);
var     o,s:ansistring;       i:integer;      enc:boolean;
begin                   //buscar dentro de ord el campo y el orden
enc:=false;
s:='';  o:='';
for i:=1 to length(ord) do begin
  if ord[i]=chr(32) then begin  //nombre del campo en s
     if field.fieldname=s then enc:=true;
     s:='';
  end else if ord[i]=chr(44) then begin   //asc o desc en s
      if enc then begin
        if s='Asc' then sortmarker:=smup
                else sortmarker:=smdown;
        enc:=false;
      end;
      s:='';
     end else s:=s+ord[i];
end;
if enc then if s='Asc' then sortmarker:=smup  //por si el orden es la última fila
                else sortmarker:=smdown;
end;

procedure Tfbuscapro.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=VK_ESCAPE then sb_SpeedButton3Click(self);
  if Key=VK_F1 then sb_okClick(self);
  if Key=VK_UP then dm.busqueda.prior;
  if Key=VK_DOWN then dm.busqueda.next;
end;

end.
