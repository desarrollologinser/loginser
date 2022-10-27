unit u_main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, sSpeedButton, StdCtrls, sLabel, sGroupBox, sEdit,
  sSkinProvider, sSkinManager, frxClass, frxDBSet, sCheckBox,
  pFIBDataSet,pFIBQuery, frxBarcode, sComboBox, sListBox, sCheckListBox,
  Vcl.ExtCtrls, sPanel, Data.DB, Datasnap.DBClient, sButton;

type
  Tf_main = class(TForm)
    sk_manager: TsSkinManager;
    sSkinProvider1: TsSkinProvider;
    rep_db: TfrxDBDataset;
    rep_eti: TfrxReport;
    rep_2: TfrxReport;
    rep_eti_2: TfrxReport;
    rep_indiv: TfrxReport;
    pnImprimir: TsPanel;
    pnCodigo: TsPanel;
    edCliente: TsEdit;
    edArticulo: TsEdit;
    chkMostrar: TsCheckListBox;
    btCrearCodigo: TsSpeedButton;
    lbCliente: TsLabel;
    lbArticulo: TsLabel;
    btCliente: TsSpeedButton;
    btArticulo: TsSpeedButton;
    btImpIndiv: TsSpeedButton;
    sSpeedButton1: TsSpeedButton;
    sSpeedButton2: TsSpeedButton;
    edClienteImprimir: TsEdit;
    edArticuloImprimir: TsEdit;
    btClienteImprimir: TsSpeedButton;
    btArticuloImprimir: TsSpeedButton;
    lbClienteImprimir: TsLabel;
    lbArticuloImprimir: TsLabel;
    edIdArticulo: TsEdit;
    edIdArticuloImprimir: TsEdit;
    cds: TClientDataSet;
    strngfldcdsestanteria: TStringField;
    strngfldcdsposicion: TStringField;
    strngfldcdsaltura: TStringField;
    strngfldcdsreferencia: TStringField;
    strngfldcdsnombre: TStringField;
    strngfldcdsean: TStringField;
    btn1: TsButton;
    btEtiquetasclientes: TsSpeedButton;
    procedure bt_printClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sSkinProvider1TitleButtons0MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure sSkinProvider1TitleButtons1MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ed_estanteriaKeyPress(Sender: TObject; var Key: Char);
    procedure ch_arribaClick(Sender: TObject);
    procedure ch_abajoClick(Sender: TObject);
    procedure btImpIndivClick(Sender: TObject);
    procedure btCrearCodigoClick(Sender: TObject);
    procedure btClienteClick(Sender: TObject);
    procedure btArticuloClick(Sender: TObject);
    procedure edClienteChange(Sender: TObject);
    procedure edArticuloChange(Sender: TObject);
    procedure btArticuloImprimirClick(Sender: TObject);
    procedure btClienteImprimirClick(Sender: TObject);
    procedure edClienteImprimirChange(Sender: TObject);
    procedure edArticuloImprimirChange(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btEtiquetasclientesClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure impresion;
    procedure impresion2;
    procedure ImpresionIndividual;
    procedure ImpresionIndividual2;
    procedure prepara_informe(informe:tfrxreport);
    procedure prepara_informe_indiv(informe:tfrxreport);
  end;

var
  f_main: Tf_main;

implementation

uses  u_dm, u_globals,ubuscapro;

{$R *.dfm}

{$REGION 'IMPRESION'}
procedure Tf_main.impresion;
begin
//  with dm.ds do begin
//    Close;
//    SQLs.SelectSQL.Clear;
//    sqls.selectsql.Add('select u.id_estanteria as estanteria, u.id_posicion as posicion '+
//    ', max(u.id_altura) as altura '+
//    'from a_ubicaciones u '+
//    'where u.id_estanteria = '''+ed_estanteria.text+''' '+
//    'and u.id_posicion >= '+ed_posini.Text+' '+
//    'and u.id_posicion <= '+ed_posfin.text+' '+
//    'group by 1,2 '+
//    'order by u.id_posicion');
//    open;
//    if RecordCount = 0 then raise Exception.Create('Ninguna Ubicacion seleccionada');
//  end;
//  rep_db.DataSet:=dm.ds;
//  prepara_informe(rep_eti);
//  if rep_eti.PrepareReport(true) then rep_eti.ShowPreparedReport;
end;

procedure Tf_main.impresion2;
begin
//  with dm.ds do begin
//    Close;
//    SQLs.SelectSQL.Clear;
//    sqls.selectsql.Add('select u.id_estanteria as estanteria, u.id_posicion as posicion '+
//    ', max(u.id_altura) as altura '+
//    'from a_ubicaciones u '+
//    'where u.id_estanteria = '''+ed_estanteria.text+''' '+
//    'and u.id_posicion >= '+ed_posini.Text+' '+
//    'and u.id_posicion <= '+ed_posfin.text+' '+
//    'group by 1,2 '+
//    'order by u.id_posicion');
//    open;
//    if RecordCount = 0 then raise Exception.Create('Ninguna Ubicacion seleccionada');
//  end;
//  rep_db.DataSet:=dm.ds;
//  prepara_informe(rep_eti_2);
//  if rep_eti_2.PrepareReport(true) then rep_eti_2.ShowPreparedReport;
end;

procedure Tf_main.prepara_informe(informe:tfrxreport);
var memo:TfrxMemoView;

begin
//  memo:=informe.FindObject('memo1') as TfrxMemoView;
//  memo.Memo.Clear ;
//  memo.Memo.Add('[rep_db."estanteria"]-[rep_db."posicion"]-'+ed_printaltura.text);
//
//  memo:=informe.FindObject('memo2') as TfrxMemoView;
//  memo.Visible:=True;
//  if ch_arriba.Checked=false then memo.Visible:=False;
//  memo:=informe.FindObject('memo5') as TfrxMemoView;
//  memo.Visible:=True;
//  if ch_arriba.Checked=false then memo.Visible:=False;
//
//  memo:=informe.FindObject('memo3') as TfrxMemoView;
//  memo.Visible:=True;
//  if ch_abajo.Checked=false then memo.Visible:=False;
//  memo:=informe.FindObject('memo6') as TfrxMemoView;
//  memo.Visible:=True;
//  if ch_abajo.Checked=false then memo.Visible:=False;

end;

procedure Tf_main.prepara_informe_indiv(informe:tfrxreport);
var memo:TfrxMemoView;
bc: TfrxBarCodeView;
memo1:TfrxMemoView;
memo2:TfrxMemoView;
begin
  memo:=informe.FindObject('memo') as TfrxMemoView;
  memo1:=informe.FindObject('memo1') as TfrxMemoView;
  memo2:=informe.FindObject('memo2') as TfrxMemoView;
  memo.Memo.Clear ;
  memo.Visible:=True;
  memo.Text:='';
  memo1.Text:='';
  memo2.Text:='';
 // memo.Memo.Add('[rep_db."estanteria"]-[rep_db."posicion"]-'+ed_printaltura.text);
  bc:=informe.FindObject('bc') as TfrxBarCodeView;
  bc.Visible:=True;
  //formula del codigo de barras
  bc.Expression:=  '<rep_db."EAN">';
 // bc.Expression := '<rep_db."estanteria">+' + QuotedStr('-') +inttostr(<rep_db."posicion">)+' + QuotedStr('-') + '+' + ed_printaltura.text;
 // memo.Text:='[rep_db."estanteria"]-[rep_db."posicion"]';
  if(chkMostrar.Checked[0])=True then memo1.Text:='[rep_db."referencia"]';
  if(chkMostrar.Checked[1])=True then memo2.Text:='[rep_db."nombre"]';
  if(chkMostrar.Checked[2])=True then memo.Text:=memo.text+'[rep_db."estanteria"]-[rep_db."posicion"]-[rep_db."altura"]';

 // bc.Expression := '<rep_db."estanteria">+' + QuotedStr('-') + '+inttostr(<rep_db."posicion">)+' + QuotedStr('-') + '+inttostr(<rep_db."altura">)';
//  bc.Expression := '<rep_db."referencia">+' + QuotedStr('-') + '[rep_db."nombre"]>+'+ QuotedStr('-') +'<rep_db."estanteria">+' + QuotedStr('-') +'+inttostr(<rep_db."posicion">)+';

end;

procedure Tf_main.impresionIndividual;
var
  i: TpFIBDataSet;
  x:Integer;
begin
cds.EmptyDataSet;
 with dm.ds do
  begin
    Close;
    SQLs.SelectSQL.Clear;
    sqls.selectsql.Add('select u.id_estanteria as estanteria, u.id_posicion as posicion, '+
    'max(u.id_altura) as altura, a.codigo as Referencia, a.nombre as Nombre,abc.bc as EAN,s.cantidad'+
    ' from a_ubicaciones u '+
    'inner join a_stock s on s.id_ubicacion=u.id_ubicacion '+
    'inner join g_articulos a on a.id_articulo=s.id_articulo '+
    'inner join g_articulos_bc abc on abc.id_articulo=a.id_articulo '+
    'where abc.estado='+quotedstr('A') + ' and a.id_articulo='+edIDArticuloImprimir.Text +' '+
    //'where a.id_cliente between 5100 and 5200 '+
    'group by 1,2,4,5,6,7 '+
    'order by estanteria,posicion,altura desc');
    open;
    First;
    if RecordCount = 0 then raise Exception.Create('El articulo no tiene código de barras. Puedes crearlo arriba.')
    else
    while not eof do
     begin
      for x := 0 to fieldbyname('cantidad').asInteger-1 do
       begin
        cds.Insert;
        cds.FieldByName('estanteria').AsString:=fieldbyname('estanteria').asString;
        cds.FieldByName('posicion').AsString:=fieldbyname('posicion').asString;
        cds.FieldByName('altura').AsString:=fieldbyname('altura').asString;
        cds.FieldByName('referencia').AsString:=fieldbyname('referencia').asString;
        cds.FieldByName('nombre').AsString:=fieldbyname('nombre').asString;
        cds.FieldByName('ean').AsString:=fieldbyname('ean').asString;
        cds.Post;
       end;
       Next;
     end;
  end;
  //rep_db.DataSet:=dm.ds;
  rep_db.DataSet:=cds;
  prepara_informe_indiv(rep_indiv);
  if rep_indiv.PrepareReport(true) then rep_indiv.ShowPreparedReport;
end;

procedure Tf_main.impresionIndividual2;
var
  i: TpFIBDataSet;
  x:Integer;
begin
cds.EmptyDataSet;
 with dm.ds do
  begin
    Close;
    SQLs.SelectSQL.Clear;
    sqls.selectsql.Add('select u.id_estanteria as estanteria, u.id_posicion as posicion, '+
    'max(u.id_altura) as altura, a.codigo as Referencia, a.nombre as Nombre,abc.bc as EAN,s.cantidad'+
    ' from a_ubicaciones u '+
    'inner join a_stock s on s.id_ubicacion=u.id_ubicacion '+
    'inner join g_articulos a on a.id_articulo=s.id_articulo '+
    'inner join g_articulos_bc abc on abc.id_articulo=a.id_articulo '+
    'where a.id_cliente='+quotedstr(edclienteimprimir.text) + ' and abc.estado='+quotedstr('A') +
    'group by 1,2,4,5,6,7 '+
//    'order by u.id_posicion');
    'order by estanteria,posicion,altura desc');
    open;
    First;
    if RecordCount = 0 then raise Exception.Create('El articulo no tiene código de barras. Puedes crearlo arriba.')
    else
    while not eof do
     begin
      for x := 0 to fieldbyname('cantidad').asInteger-1 do
       begin
        cds.Insert;
        cds.FieldByName('estanteria').AsString:=fieldbyname('estanteria').asString;
        cds.FieldByName('posicion').AsString:=fieldbyname('posicion').asString;
        cds.FieldByName('altura').AsString:=fieldbyname('altura').asString;
        cds.FieldByName('referencia').AsString:=fieldbyname('referencia').asString;
        cds.FieldByName('nombre').AsString:=fieldbyname('nombre').asString;
        cds.FieldByName('ean').AsString:=fieldbyname('ean').asString;
        cds.Post;
       end;
       Next;
     end;
  end;
  //rep_db.DataSet:=dm.ds;
  rep_db.DataSet:=cds;
  prepara_informe_indiv(rep_indiv);
  if rep_indiv.PrepareReport(true) then rep_indiv.ShowPreparedReport;
end;

{$ENDREGION}

procedure Tf_main.btArticuloClick(Sender: TObject);
begin
if(edcliente.Text<>'') then
  with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='a.codigo,a.nombre ';
    titulos.commatext:='Codigo,Nombre';
    //from:='g_articulos a inner join g_clientes g on g.id_cliente=a.id_cliente';
    from:='g_articulos a ';
    where:='a.estado='+quotedStr('A')+ 'and a.id_cliente='+edcliente.Text;
    orden[1]:=1;  busca:=1;   distinct:=1;   fillimpio:=True;
    ShowModal;
    if resultado then begin
      with Sender as TsSpeedButton do begin
        edArticulo.Text:=valor[1];
        lbArticulo.Caption:=valor[2];
        end;
    end;
  end
  else ShowMessage('No ha seleccionado un cliente');

end;

procedure Tf_main.btArticuloImprimirClick(Sender: TObject);
begin
begin
if(edclienteImprimir.Text<>'') then
  with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='a.codigo,a.nombre ';
    titulos.commatext:='Codigo,Nombre';
    //from:='g_articulos a inner join g_clientes g on g.id_cliente=a.id_cliente';
    from:='g_articulos a ';
    where:='a.estado='+quotedStr('A')+ 'and a.id_cliente='+edclienteImprimir.Text;
    orden[1]:=1;  busca:=1;   distinct:=1;   fillimpio:=True;
    ShowModal;
    if resultado then begin
      with Sender as TsSpeedButton do begin
        edArticuloImprimir.Text:=valor[1];
        lbArticuloImprimir.Caption:=valor[2];
        end;
    end;
  end
  else ShowMessage('No ha seleccionado un cliente');

end;
end;

procedure Tf_main.btClienteClick(Sender: TObject);
begin
  with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='g.id_cliente,g.nombre ';
    titulos.commatext:='Codigo,Nombre';
    from:='g_articulos a inner join g_clientes g on g.id_cliente=a.id_cliente ';
    where:='a.estado='+quotedStr('A');
    orden[1]:=1;  busca:=1;   distinct:=1;   fillimpio:=True;
    ShowModal;
    if resultado then begin
      with Sender as TsSpeedButton do begin
        edCliente.Text:=valor[1];
        lbCliente.Caption:=valor[2];
        end;
    end
    else
     begin
      edCliente.Text:='';
      lbCliente.Caption:='El cliente no existe';
     end;
  end;
end;

procedure Tf_main.btClienteImprimirClick(Sender: TObject);
begin
 with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='g.id_cliente,g.nombre ';
    titulos.commatext:='Codigo,Nombre';
    from:='g_articulos a inner join g_clientes g on g.id_cliente=a.id_cliente ';
    where:='a.estado='+quotedStr('A');
    orden[1]:=1;  busca:=1;   distinct:=1;   fillimpio:=True;
    ShowModal;
    if resultado then begin
      with Sender as TsSpeedButton do begin
        edClienteImprimir.Text:=valor[1];
        lbClienteImprimir.Caption:=valor[2];
        end;
    end
    else
     begin
      edClienteImprimir.Text:='';
      lbClienteImprimir.Caption:='El cliente no existe';
     end;
  end;
end;

procedure Tf_main.btCrearCodigoClick(Sender: TObject);
var
ean:string;
existe:Integer;
begin
ean:=edCliente.Text+edIdArticulo.Text;
try
with dm.qry_existe do
 begin
  Close;
  SelectSQL.Text:='Select count(*) as contador from g_articulos_bc where id_articulo='+quotedstr(edIdArticulo.Text)+' and bc='+quotedstr(ean);
  Open;
  existe:=FieldByName('contador').AsInteger;
 end;
 if(existe<=0) then
 begin
 dm.t_write.StartTransaction;
  with dm.qry_insertaBC do
   begin
    ParamByName('id_articulo').AsInteger:=StrToInt(edIdArticulo.Text);
    ParamByName('bc').AsString:=ean;
    ExecQuery;
    dm.t_write.Commit;
    ShowMessage('Creado el código de barras');
   end;
 end
 else ShowMessage('El articulo seleccionado ya tiene un código de barras asociado');
except
  dm.t_write.Rollback;
  ShowMessage('Ocurrió un error. NO se ha creado el código de barras');
end;

end;

procedure Tf_main.btEtiquetasclientesClick(Sender: TObject);
begin
   if edclienteImprimir.Text = '' then  raise Exception.Create('Indique Cliente');
  ImpresionIndividual2;
end;

procedure Tf_main.btImpIndivClick(Sender: TObject);
begin
 if edclienteImprimir.Text = '' then  raise Exception.Create('Indique Cliente');
 if edArticuloImprimir.Text = '' then raise Exception.Create('Indique Articulo');
//  if StrToInt(ed_posfin.Text) < StrToInt(ed_posini.Text) then
//    raise Exception.Create('Verifice Posiciones');
  ImpresionIndividual;
end;

procedure Tf_main.btn1Click(Sender: TObject);
begin
   dm.t_write.StartTransaction;
with dm.qry_aux do
begin
  Close;
  SelectSQL.Text:='select a.id_articulo,a.id_cliente from g_articulos a where a.id_cliente between 5100 and 5159 and a.id_articulo not in (62494,62495,62750,66454,69295,68639,71013,71014,71016,71017,71019,71026,71027,7102,71147,71148,71149,71150,71383,71384,71965)';
  Open;
  First;
  while not eof do
   begin

     with dm.qry_insertaBC do
      begin
       ParamByName('id_articulo').AsInteger:= dm.qry_aux.FieldByName('id_articulo').AsInteger;
       ParamByName('bc').AsString:= dm.qry_aux.FieldByName('id_cliente').AsString+ dm.qry_aux.FieldByName('id_articulo').AsString;
       ExecQuery;
       end;
    dm.qry_aux.Next;
   end;
      dm.t_write.Commit;
end;
end;

procedure Tf_main.bt_printClick(Sender: TObject);
begin
//  if ed_estanteria.Text = '' then  raise Exception.Create('Indique Estanteria');
//  if ed_printaltura.Text = '' then raise Exception.Create('Indique Altura');
//  if StrToInt(ed_posfin.Text) < StrToInt(ed_posini.Text) then
//    raise Exception.Create('Verifice Posiciones');
//  if cb 1.Checked then impresion
//  else impresion2;
end;

{$REGION 'INI-CLOSE'}
procedure Tf_main.ch_abajoClick(Sender: TObject);
begin
//  if ch_abajo.Checked=true then ch_arriba.Checked:=False;

end;

procedure Tf_main.ch_arribaClick(Sender: TObject);
begin
//  if ch_arriba.Checked=true then ch_abajo.Checked:=False;

end;

procedure Tf_main.edArticuloChange(Sender: TObject);
begin
if edCliente.Text<>'' then
  begin
   with dm.busqueda do
    begin
      Close;
      sqls.SelectSQL.clear;
      SQLs.SelectSQL.Add('SELECT id_articulo,nombre,codigo FROM G_articulos ' +
                         'WHERE ESTADO=''A'' AND codigo=' + QuotedStr(edArticulo.Text));
      Open;
      if(not Eof) then
       begin
        edArticulo.Text:=fieldbyname('codigo').AsString;;
        lbArticulo.Caption:=FieldByName('nombre').AsString;
        edIdArticulo.Text:=FieldByName('id_articulo').AsString;
       end
      else
       begin
        lbArticulo.Caption:='No existe el articulo';
        edIdArticulo.Text:='';
       end;

      end;
  end
  else
   begin
    lbArticulo.Caption:='No ha seleccionado un articulo';
    edIdArticulo.Text:='';
   end;
end;

procedure Tf_main.edArticuloImprimirChange(Sender: TObject);
begin
if edArticuloImprimir.Text<>'' then
  begin
   with dm.busqueda do
    begin
      Close;
      sqls.SelectSQL.clear;
      SQLs.SelectSQL.Add('SELECT replace(id_articulo,'' '' , '''')AS ID_ARTICULO,nombre,codigo FROM G_articulos ' +
                         'WHERE ESTADO=''A'' AND codigo LIKE ' + QuotedStr('%'+edArticuloImprimir.Text));
      Open;
      if(not Eof) then
       begin
        //edArticuloImprimir.Text:=fieldbyname('codigo').AsString;;
        lbArticuloImprimir.Caption:=FieldByName('nombre').AsString;
        edIdArticuloImprimir.Text:=FieldByName('id_articulo').AsString;
       end
      else
       begin
        lbArticuloImprimir.Caption:='No existe el articulo';
        edIdArticuloImprimir.Text:='';
       end;

      end;
  end
  else
   begin
    lbArticuloImprimir.Caption:='No ha seleccionado un articulo';
    edIdArticuloImprimir.Text:='';
   end;
end;

procedure Tf_main.edClienteChange(Sender: TObject);
begin
 if edCliente.Text<>'' then
  begin
   with dm.busqueda do
    begin
      Close;
      sqls.SelectSQL.clear;
      SQLs.SelectSQL.Add('SELECT ID_CLIENTE, NOMBRE FROM G_CLIENTES ' +
                         'WHERE ESTADO=''A'' AND id_cliente=' + edCliente.Text);
      Open;
      if(not Eof) then
       begin
        edcliente.Text:=fieldbyname('id_cliente').Text;
        lbCliente.Caption:=FieldByName('nombre').AsString;
       end
      else
       begin
        lbCliente.Caption:='No existe el cliente';
       end;

      end;
  end
  else lbCliente.Caption:='No ha seleccionado un cliente';
end;

procedure Tf_main.edClienteImprimirChange(Sender: TObject);
begin
 if edClienteImprimir.Text<>'' then
  begin
   with dm.busqueda do
    begin
      Close;
      sqls.SelectSQL.clear;
      SQLs.SelectSQL.Add('SELECT ID_CLIENTE, NOMBRE FROM G_CLIENTES ' +
                         'WHERE ESTADO=''A'' AND id_cliente=' + edClienteImprimir.Text);
      Open;
      if(not Eof) then
       begin
        edClienteImprimir.Text:=fieldbyname('id_cliente').Text;
        lbClienteImprimir.Caption:=FieldByName('nombre').AsString;
       end
      else
       begin
        lbClienteImprimir.Caption:='No existe el cliente';
       end;

      end;
  end
  else lbClienteImprimir.Caption:='No ha seleccionado un cliente';
end;

procedure Tf_main.ed_estanteriaKeyPress(Sender: TObject; var Key: Char);
begin
 key := UpperCase(Key)[1];
end;

procedure Tf_main.FormCreate(Sender: TObject);
begin
 // u_globals.password:=ParamStr(1);                            //El password llega como primer parametro

  u_globals.leer_ini;                                         //carga ini

  sk_manager.SkinDirectory:=u_globals.resdir+'Skins\';     //Activa el skin
  sk_manager.SkinName:=u_globals.skinname;
  sk_manager.Active:=true;

  u_globals.ini_bd_simple;                                          //inicializa acceso a datos

  sk_manager.HueOffset:=u_globals.hue;                       //aplica colores a la piel
  sk_manager.Saturation:=u_globals.saturation;
                                                             //si no tiene posicion por defecto
  if u_globals.x<0 then u_globals.x:=(Screen.width-width) div 2;
  if u_globals.y<0 then u_globals.y:=(Screen.height-height) div 2;
  {if u_globals.w<0 then u_globals.w:=Width;
  if u_globals.h<0 then u_globals.h:=height;   }

  left:=u_globals.x;                                          //asigna posicion
  top:=u_globals.y;
 { Width:=u_globals.w;
  Height:=u_globals.h;   }

  caption:=u_globals.hint+' - '+u_globals.usuario+' ('+u_globals.permiso+')'+' - '+u_globals.empresa;
end;

procedure Tf_main.FormDestroy(Sender: TObject);
begin
  u_globals.x:=left;                                          //guardar posicion actual
  u_globals.y:=top;
 { u_globals.w:=Width;                                        //guardar tamaño (si procede)
  u_globals.h:=Height;       }
  u_globals.guardar_pos;
end;

procedure Tf_main.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then begin                         { if it's an enter key }
       Key := #0;                                 { eat enter key }
       Perform(WM_NEXTDLGCTL, 0, 0);              { move to next control }
  end
end;

procedure Tf_main.sSkinProvider1TitleButtons0MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Application.Terminate;
end;

procedure Tf_main.sSkinProvider1TitleButtons1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Application.Minimize;
end;

{$ENDREGION}

end.
