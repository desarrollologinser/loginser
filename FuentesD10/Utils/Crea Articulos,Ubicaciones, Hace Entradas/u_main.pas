unit u_main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, FIBDataSet, pFIBDataSet, FIBQuery, pFIBQuery, FIBDatabase,
  pFIBDatabase, StdCtrls, sButton, Mask, sMaskEdit, sCustomComboEdit, sTooledit,
  sLabel, Vcl.ComCtrls, sStatusBar, System.Win.ComObj, Datasnap.DBClient, MidasLib,
  System.IniFiles;

type
  TLinea = record
      linea : Integer;
      art   : Integer;
      ubi   : Integer;
      mat   : Integer;
      imei  : String;
      cad   : TDate;
      stock : Integer;
      alm   : Integer;
      lote  : Integer;
      albCl : string;
  end;

  TfrmMain = class(TForm)
    fe_1: TsFilenameEdit;
    bt_1: TsButton;
    db: TpFIBDatabase;
    read: TpFIBTransaction;
    write: TpFIBTransaction;
    q_1: TpFIBQuery;
    q_0: TpFIBDataSet;
    lb_1: TsLabel;
    btn1: TsButton;
    btn_aseval: TsButton;
    btn_aseval_2: TsButton;
    bt_2: TsButton;
    btTodo: TsButton;
    brStatus: TsStatusBar;
    lbBbdd: TsLabel;
    btUbicaciones: TsButton;
    btArticulos: TsButton;
    de_1: TsDirectoryEdit;
    b_1: TsButton;
    b_2: TsButton;
    ds1: TClientDataSet;
    cdsds1CodCli: TIntegerField;
    ds1CodArt: TStringField;
    ds1NomArt: TStringField;
    cdsds1Fam: TIntegerField;
    ds1Peso: TFloatField;
    ds1Alto: TFloatField;
    ds1Largo: TFloatField;
    ds1Ancho: TFloatField;
    ds1KgsVol: TFloatField;
    ds1RefCli: TStringField;
    cdsds1UdsEmb: TIntegerField;
    cdsds1Uds: TIntegerField;
    ds1BC: TStringField;
    cdsds1IdAlm: TIntegerField;
    ds1Estanteria: TStringField;
    cdsds1Posicion: TIntegerField;
    cdsds1Altura: TIntegerField;
    ds1Sub1: TStringField;
    ds1Sub2: TStringField;
    ds1Cubic: TFloatField;
    ds1NomCliArt: TStringField;
    ds1Precio: TFloatField;
    ds1Imei: TStringField;
    cdsds1linea: TIntegerField;
    ds1Caducidad: TDateField;
    chArticulo: TCheckBox;
    strngfldds1lote: TStringField;
    ds1cad_lote: TDateField;
    gb1: TGroupBox;
    mm: TMemo;
    strngfldds1alb_cliente: TStringField;
    procedure btn1Click(Sender: TObject);
    procedure bt_1Click(Sender: TObject);
    procedure btn_asevalClick(Sender: TObject);
		procedure btn_aseval_2Click(Sender: TObject);
    procedure bt_2Click(Sender: TObject);
    procedure btTodoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btUbicacionesClick(Sender: TObject);
    procedure btArticulosClick(Sender: TObject);
    procedure b_1Click(Sender: TObject);
    procedure b_2Click(Sender: TObject);
  private
    { Private declarations }
    function Pop(var s : string) : string;
    function crea_ubicacion(id_alm: Integer; est: string; posi, alt: Integer; sub1: string) : Integer;
		function crea_articulo_aseval(id_cli: Integer; art: string; prefijo: string;
				caja: Integer): Integer; overload;
		function crea_articulo_aseval(id_cli: Integer; art, caja: string): Integer;
				overload;
    procedure entrada_aseval(id_art: Integer; uds: Integer; id_alm: Integer; id_ubic: Integer; var id_mat: Integer);
    procedure AbreFichero;
    procedure RecorreHojas;
    procedure InsertaBBDD;
    procedure InsertStock(id_ubic,id_art,id_mat, id_alm, stock, id_lote: Integer);
    procedure InsertMatricula(id_art, id_mat, id_alm, stock, id_lote: Integer; albCl:string);
    procedure InsertIMEI(imei: string; id_mat: Integer; cad:TDate);
    procedure InsertLote(lote: string; id_lote: Integer; cad:  TDate);
    function busca_lote(lote:string; caducidad:TDate):integer;
    procedure leer_ini_red;
  public
    { Public declarations }
    function busca_ubic(id_estant:string; id_alm,id_pos,id_alt:Integer; pic:string; id_zona:integer):integer;
    function busca_art_id(id_cliente,ref:string):integer;
    function busca_art_id_sku(id_cliente,sku:string):integer;
    procedure borra_stock(id_art,id_ubic:integer);
    function ubicado(id_art,id_ubic:integer):Boolean;
    procedure ListaArchivos(dir,ext:string; Lista:TStringList);
    function existe_almacen(id_almacen:integer):Boolean;
  end;

const
  fila_ini = 2;         //este excel cuenta desde 1 filas y columnas
  ln = #13#10;

  ALERTA = 'LISTO';
  {Listo: puede crearse exe
   Vacio: hay algo en desarrollo y no se puede crear exe}

  ruta_ini_red = '\\192.168.0.6\Sys\Lgs App\Exes\config.ini';
  ruta_db_default = '192.168.0.5:D:\FB\LGS_EXP\LGS.FDB';

  v = '[2.5]';
  //[2.5] Control almacén al importar
  //[2.4.1] Error al cargar fecha lote.
  //[2.4] Control de errores en botón standar
  //[2.3.1] Bug boton ubicaciones
  //[2.3] Inserción de lotes. Ruta db en ini.
  //[2.2.3.1] Bug ultima linea
  //[2.2.3] Bug al insetar la primera linea
  //[2.2.2] Bug cuando el peso es decimal
  //[2.2.1] Bug al importar fichero con varios clientes
  //[2.2] Parametro id_cliente en busqueda de articulo
  //[2.1] Error en botón Crear Artículos.
  //[2.0] ServerUpdate, Mutex, check para actualizar artículo si existe o no


var
  frmMain: TfrmMain;

  excel, libro: Variant;
  hoja, hoja2:OleVariant;
  x_datos, lineas_total: Integer;
  lineas: array of TLinea;
  mat1, mat2: integer;
  ruta_db:string;


implementation

uses
   System.StrUtils, System.Types;

{$R *.dfm}

procedure TfrmMain.bt_1Click(Sender: TObject);
var  f:textfile; ref,n_caj,est,sufijo,art,sub1,s:string;   posi,alt,n,tot,id_alm,id_ubic,id_art,id_mat,id_cli,i,uds:Integer;
begin
  AssignFile(f,fe_1.text);
  Reset(f);
  n:=0;
  tot:=0;
  mat1:=0;
  mat2:=0;

  while not Eof(f) do begin
    Readln(f,s);

    i:=pos(';',s);
    ref:=copy(s,1,i-1);
    s:=copy(s,i+1,length(s));

    i:=pos(';',s);
    n_caj:=FormatFloat('0000',strtoint(copy(s,1,i-1)));
    s:=copy(s,i+1,length(s));

    i:=pos(';',s);
    est:=copy(s,1,i-1);
    s:=copy(s,i+1,length(s));

    i:=pos(';',s);
    posi:=StrToInt(copy(s,1,i-1));
    s:=copy(s,i+1,length(s));

    i:=pos(';',s);
    alt:=StrToInt(copy(s,1,i-1));
    s:=copy(s,i+1,length(s));

    sufijo:=copy(s,1,i-1);              //(A,S,P)

    //****************************************************************VALORES FIJOS
    id_cli:=6131;
    id_alm:=2;
    sub1:='0';
    uds:=1;

    art:=ref+n_caj+sufijo;

    id_ubic:=busca_ubic(est,id_alm,posi,alt,sub1,0);
    id_art:=busca_art_id('6131',art);

    if not(ubicado(id_art,id_ubic)) then begin              //Verifica que ya esté ubicado el artículo

      try
        write.StartTransaction;

        if (id_ubic=-1) then begin                            //Crea ubicacion si no existe
          with tpfibdataset.Create(frmMain) do begin
            database:=db;
            SQLs.SelectSQL.Clear;
            SQLs.SelectSQL.Add('SELECT GEN_ID(GEN_A_UBICACIONES_ID, 1) from RDB$DATABASE');
            Open;
            id_ubic:=FieldByName('gen_id').AsInteger;
            Free;
          end;


          q_1.Close;
          q_1.SQL.Clear;
          q_1.SQL.Add('insert into a_ubicaciones(ID_UBICACION,ID_ALMACEN,ID_ESTANTERIA,ID_POSICION,ID_ALTURA,ID_SUB1) VALUES '+
            ' (:ID_UBICACION,:ID_ALMACEN,:ID_ESTANTERIA,:ID_POSICION,:ID_ALTURA,:ID_SUB1)');
          q_1.ParamByName('ID_UBICACION').AsInteger:=id_ubic;
          q_1.ParamByName('ID_ALMACEN').AsInteger:=id_alm;
          q_1.ParamByName('ID_ESTANTERIA').asstring:=est;
          q_1.ParamByName('ID_POSICION').AsInteger:=posi;
          q_1.ParamByName('ID_ALTURA').AsInteger:=alt;
          q_1.ParamByName('ID_SUB1').asstring:=sub1;
          q_1.ExecQuery;
        end;

        if (id_art=-1) then begin                                //Crea articulo si no existe
          with tpfibdataset.Create(frmMain) do begin
            database:=db;
            SQLs.SelectSQL.Clear;
            SQLs.SelectSQL.Add('SELECT GEN_ID(GEN_G_ARTICULOS_ID, 1) from RDB$DATABASE');
            Open;
            id_art:=FieldByName('gen_id').AsInteger;
            Free;
          end;


          q_1.Close;
          q_1.sql.Clear;
          q_1.SQL.Add('insert into g_articulos (id_articulo,CODIGO,NOMBRE,ID_CLIENTE) values '+
                      '(:id_articulo,:CODIGO,:NOMBRE,:ID_CLIENTE)');
          q_1.ParamByName('id_articulo').AsInteger:=id_art;
          q_1.ParamByName('codigo').asstring:=art;
          q_1.ParamByName('nombre').asstring:='CAJA '+n_caj+sufijo;
          q_1.ParamByName('id_cliente').AsInteger:=id_cli;
          q_1.ExecQuery;
        end;

        with tpfibdataset.Create(frmMain) do begin                       //Nueva matricula
          database:=db;
          SQLs.SelectSQL.Clear;
          SQLs.SelectSQL.Add('SELECT GEN_ID(GEN_A_MATRICULAS_ID, 1) from RDB$DATABASE');
          Open;

          id_mat:=FieldByName('gen_id').AsInteger;
          if n=1 then mat1:=id_mat
            else mat2:=id_mat;

          Free;
        end;

        q_1.Close;
        q_1.SQL.Clear;
        q_1.SQL.Add('insert into a_stock (ID_ALMACEN,ID_UBICACION,ID_ARTICULO,ID_MATRICULA,ID_LOTE,CANTIDAD,ID_EMPRESA) VALUES '+
          ' (:ID_ALMACEN,:ID_UBICACION,:ID_ARTICULO,:ID_MATRICULA,1,:ctdad,1)');
        q_1.ParamByName('id_almacen').AsInteger:=id_alm;
        q_1.ParamByName('id_ubicacion').AsInteger:=id_ubic;
        q_1.ParamByName('id_articulo').AsInteger:=id_art;
        q_1.ParamByName('id_matricula').AsInteger:=id_mat;
        q_1.ParamByName('ctdad').AsInteger:=uds;
        q_1.ExecQuery;

        q_1.Close;
        q_1.sql.Clear;
        q_1.sql.Add('insert into a_matriculas (id_matricula,id_articulo,uds_ini,tipo,alb_cliente,observaciones) '+
          ' values (:id_matricula,:id_articulo,:uds_ini,:tipo,:alb_cliente,:observaciones)');
        q_1.ParamByName('id_matricula').AsInteger:=id_mat;
        q_1.ParamByName('id_articulo').AsInteger:=id_art;
        q_1.ParamByName('uds_ini').AsInteger:=uds;
        q_1.ParamByName('tipo').asstring:='E';
        q_1.ParamByName('alb_cliente').asstring:='00000';
        q_1.ParamByName('observaciones').Asstring:='';
        q_1.ExecQuery;

        Inc(n);

        write.Commit;
      except
        write.Rollback;
      end;
    end;
    Inc(tot);

    lb_1.Caption:=IntToStr(n)+' / '+inttostr(tot);
    application.ProcessMessages;
  end;
  CloseFile(f);
  ShowMessage('Finished Mat1='+inttostr(mat1)+' Mat2='+inttostr(mat2)+' Lines='+inttostr(n));
end;

function TfrmMain.busca_ubic(id_estant:string; id_alm,id_pos,id_alt:Integer; pic:string; id_zona:integer):integer;
begin                                       //devuelve id_ubicacion,   existe=id_ubicacion     no existe=-1
  with tpfibdataset.Create(frmMain) do begin
    database:=frmMain.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select id_ubicacion from a_ubicaciones where '+
            'id_empresa=1 and id_almacen='+inttostr(id_alm)+'  and id_estanteria='''+id_estant+
            ''' and id_posicion='+inttostr(id_pos)+' and id_altura='+inttostr(id_alt)+' and id_zona='+inttostr(id_zona));
    if pic<>'' then SQLs.SelectSQL.Add(' and id_sub1='+quotedstr(pic)+' and id_sub2=''0''');
    Open;
    if not(IsEmpty) then Result:=FieldByName('id_ubicacion').AsInteger
      else Result:=-1;
    Free;
  end;
end;

function TfrmMain.Pop(var s: string): string;
var
  i: Integer;
begin
    i:=pos(';',s);
    if i=0 then i := Length(s) + 1;
    Result:=copy(s,1,i-1);
    s:=copy(s,i+1,length(s));
end;

function TfrmMain.busca_art_id(id_cliente, ref:string):integer;
begin                                       //devuelve id de articulo a partir de referencia
  with tpfibdataset.Create(frmMain) do
  begin
    database:=frmMain.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select id_articulo from g_articulos where codigo='+quotedstr(ref)+
      ' and id_cliente=' + id_cliente + ' and id_empresa=1');
    //  InputBox('','',SQLs.SelectSQL.Text);
    Open;

    if not(IsEmpty) then Result:=FieldByName('id_articulo').asinteger
    else result:=-1;

    Free;
  end;
end;

function TfrmMain.busca_art_id_sku(id_cliente,sku:string):integer;
begin                                       //devuelve id de articulo a partir de referencia
  with tpfibdataset.Create(frmMain) do begin
    database:=frmMain.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select id_articulo from g_articulos where codigo_cli='+quotedstr(sku)+
      ' and id_empresa=1 and id_cliente=' + id_cliente);
    Open;

    if not(IsEmpty) then Result:=FieldByName('id_articulo').asinteger
    else result:=-1;

    Free;
  end;
end;

procedure TfrmMain.borra_stock(id_art,id_ubic:integer);
begin
  q_1.Close;
  q_1.sql.Clear;
  q_1.sql.Add('delete from a_stock where id_articulo=:id_articulo and id_ubicacion=:id_ubicacion');
  q_1.ParamByName('id_articulo').AsInteger:=id_art;
  q_1.ParamByName('id_ubicacion').AsInteger:=id_ubic;
  q_1.ExecQuery;
end;

function TfrmMain.ubicado(id_art,id_ubic:integer):Boolean;      //verifica que el articulo esté ubicado
begin
  with tpfibdataset.Create(frmMain) do begin
    database:=frmMain.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select * from a_stock where id_articulo=:id_articulo and id_ubicacion=:id_ubicacion');
    ParamByName('id_articulo').AsInteger:=id_art;
    ParamByName('id_ubicacion').AsInteger:=id_ubic;
    Open;

    if not(IsEmpty) then Result:=true
    else result:=false;

    Free;
  end;
end;

procedure TfrmMain.entrada_aseval(id_art: Integer; uds: Integer; id_alm: Integer; id_ubic: Integer; var id_mat: Integer);
begin
  with tpfibdataset.Create(nil) do
  begin
    //Nueva matricula
    database := db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('SELECT GEN_ID(GEN_A_MATRICULAS_ID, 1) from RDB$DATABASE');
    Open;
    id_mat := FieldByName('gen_id').AsInteger;
    Free;
  end;
  q_1.Close;
  q_1.SQL.Clear;
  q_1.SQL.Add('insert into a_stock (ID_ALMACEN,ID_UBICACION,ID_ARTICULO,ID_MATRICULA,ID_LOTE,CANTIDAD,ID_EMPRESA) VALUES ' + ' (:ID_ALMACEN,:ID_UBICACION,:ID_ARTICULO,:ID_MATRICULA,1,:ctdad,1)');
  q_1.ParamByName('id_almacen').AsInteger := id_alm;
  q_1.ParamByName('id_ubicacion').AsInteger := id_ubic;
  q_1.ParamByName('id_articulo').AsInteger := id_art;
  q_1.ParamByName('id_matricula').AsInteger := id_mat;
  q_1.ParamByName('ctdad').AsInteger := uds;
  q_1.ExecQuery;
  q_1.Close;
  q_1.sql.Clear;
  q_1.sql.Add('insert into a_matriculas (id_matricula,id_articulo,uds_ini,tipo,alb_cliente,observaciones) ' + ' values (:id_matricula,:id_articulo,:uds_ini,:tipo,:alb_cliente,:observaciones)');
  q_1.ParamByName('id_matricula').AsInteger := id_mat;
  q_1.ParamByName('id_articulo').AsInteger := id_art;
  q_1.ParamByName('uds_ini').AsInteger := uds;
  q_1.ParamByName('tipo').asstring := 'E';
  q_1.ParamByName('alb_cliente').asstring := '00000';
  q_1.ParamByName('observaciones').Asstring := '';
  q_1.ExecQuery;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
    if (ALERTA<>'LISTO') then
      ShowMessage('CUIDADO!!!!! PROYECTO EN DESARROLLO!!!! AVISA A INFORMATICA!!!');

 { u_globals.password:=ParamStr(1);                            //El password llega como primer parametro

  u_globals.leer_ini;                                         //carga ini

  sk_manager.SkinDirectory:=u_globals.resdir+'Skins\';     //Activa el skin
  sk_manager.SkinName:=u_globals.skinname;
  sk_manager.Active:=true;

  u_globals.ini_bd;                                          //inicializa acceso a datos

  sk_manager.HueOffset:=u_globals.hue;                       //aplica colores a la piel
  sk_manager.Saturation:=u_globals.saturation;
                                                             //si no tiene posicion por defecto
  if u_globals.x<0 then u_globals.x:=(Screen.width-width) div 2;
  if u_globals.y<0 then u_globals.y:=(Screen.height-height) div 2;

  left:=u_globals.x;                                          //asigna posicion
  top:=u_globals.y; }

  Caption := 'Crea Ubics., Arts. y Matrículas ' + v;

  lb_1.Caption := '';
  //lbBbdd.Caption := db.DatabaseName;

  leer_ini_red;

  if ruta_db='' then
      ruta_db := ruta_db_default;

  if not db.Connected then
  begin
      db.DatabaseName := ruta_db;
      db.Connected := True;
  end;

  lbBbdd.caption := ruta_db;

    mm.Lines.Clear;

  mm.Lines.Add('Cliente=A');
  mm.Lines.Add('Ref.Art.=B');
  mm.Lines.Add('Nom.Art.=C');
  mm.Lines.Add('Familia=D');
  mm.Lines.Add('Peso=E');
  mm.Lines.Add('Alto=F');
  mm.Lines.Add('Largo=G');
  mm.Lines.Add('Ancho=H');
  mm.Lines.Add('KgsVol=I');
  mm.Lines.Add('Cod.Cli.Art.=J');
  mm.Lines.Add('Uds.Emb.=K');
  mm.Lines.Add('Uds.=L');
  mm.Lines.Add('Ean=M');
  mm.Lines.Add('Almacen=N');
  mm.Lines.Add('Estanteria=O');
  mm.Lines.Add('Posicion=P');
  mm.Lines.Add('Altura=Q');
  mm.Lines.Add('Sub1=R');
  mm.Lines.Add('Sub2=S');
  mm.Lines.Add('Cubic.=T');
  mm.Lines.Add('Nom.Art.Cli.=U');
  mm.Lines.Add('Precio=V');
  mm.Lines.Add('Imei=W');
  mm.Lines.Add('Caduc.Imei=X');
  mm.Lines.Add('Lote=Y');
  mm.Lines.Add('Caduc.Lote=Z');
  mm.Lines.Add('Alb.Cliente=AA');
  mm.Lines.Add('Columnas de Salida:');
  mm.Lines.Add('Id Ubic=AE');
  mm.Lines.Add('Id Art=AF');
  mm.Lines.Add('Id Matr=AG');
  mm.Lines.Add('Id Lote=AH');

end;

function TfrmMain.crea_articulo_aseval(id_cli: Integer; art: string; prefijo:
		string; caja: Integer): Integer;
begin
  crea_articulo_aseval(id_cli, art, Format('%s%.6d', [prefijo, caja]));
end;

function TfrmMain.crea_ubicacion(id_alm: Integer; est: string; posi, alt: Integer; sub1: string) : Integer;
begin
  with tpfibdataset.Create(frmMain) do
  begin
    database := db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('SELECT GEN_ID(GEN_A_UBICACIONES_ID, 1) from RDB$DATABASE');
    Open;
    Result := FieldByName('gen_id').AsInteger;
    Free;
  end;
  q_1.Close;
  q_1.SQL.Clear;
  q_1.SQL.Add('insert into a_ubicaciones(ID_UBICACION,ID_ALMACEN,ID_ESTANTERIA,ID_POSICION,ID_ALTURA,ID_SUB1) VALUES ' + ' (:ID_UBICACION,:ID_ALMACEN,:ID_ESTANTERIA,:ID_POSICION,:ID_ALTURA,:ID_SUB1)');
  q_1.ParamByName('ID_UBICACION').AsInteger := Result;
  q_1.ParamByName('ID_ALMACEN').AsInteger := id_alm;
  q_1.ParamByName('ID_ESTANTERIA').asstring := est;
  q_1.ParamByName('ID_POSICION').AsInteger := posi;
  q_1.ParamByName('ID_ALTURA').AsInteger := alt;
  q_1.ParamByName('ID_SUB1').asstring := sub1;
  q_1.ExecQuery;
end;

procedure TfrmMain.btUbicacionesClick(Sender: TObject);
var  f:textfile; nom_art,ref,n_caj,est,sufijo,art,sub1,sub2,s,ean,codigo_cli,nom_cli,old_ref:string;
    posi,alt,n,tot,id_alm,id_ubic,id_art,id_mat,mat1,mat2,id_cli,i,uds,familia,uds_emb, a, u, fila:Integer;
    peso,largo,ancho,alto,kgsvol,cubic:double;
    hist_arts, hist_ubic, hist_id_art, hist_id_ubi: TStringList;
    found_art, found_ubic: Boolean;
    enc:Boolean;
    errores: string;
begin

  AbreFichero;
  Hoja := excel.Worksheets.Item[1];

  //xls.Filename:=fe_1.Text;
  //xls.Read;
  fila := fila_ini;
  enc:=false;

    while not enc do
    if Trim(hoja.Cells[fila,1])='' then
          enc:=true
    else begin
            If Trim(hoja.Cells[fila,14])<>'' then
            begin
               if ((StrToIntDef(Trim(hoja.Cells[fila,14]),-1)<>-1) or
                   (Trim(hoja.Cells[fila,14])='-1')) then
                   if not existe_almacen(StrToInt(Trim(hoja.Cells[fila,14]))) then
                  errores := errores + 'Fila ' + IntToStr(fila) + ': almacén no válido' + ln;
            end else
                  errores := errores + 'Fila ' + IntToStr(fila) + ': almacén sin rellenar ' + ln;
            Inc(fila);
         end;

  if errores<>'' then
  begin
    Showmessage('Existen datos a revisar:' + ln + errores);

    excel.activeworkbook.save;
    Excel.Quit ;
    Excel := Unassigned;

    Screen.Cursor := crDefault;

    Exit;
  end;

  found_ubic := False;

  enc:=false;

  write.StartTransaction;
  try
    hist_ubic := TStringList.Create;
    hist_id_ubi := TStringList.Create;

    while not(Enc) do begin                                 //busca el final del excel
      lb_1.Caption:=IntToStr(fila);
      application.ProcessMessages;

      //if xls.sheets[0].asstring[13,fila]='' then enc:=true
       if Trim(hoja.Cells[fila,14])='' then  //col.14 Almacen
            enc:=true
       else begin
         {id_alm:=xls.sheets[0].asinteger[13,fila];
          est:=xls.Sheets[0].AsString[14,fila];
          posi:=xls.Sheets[0].asinteger[15,fila];
          alt:=xls.Sheets[0].asinteger[16,fila];
          sub1:=xls.Sheets[0].AsString[17,fila];
          sub2:=xls.Sheets[0].AsString[18,fila];}

          id_alm := hoja.Cells[fila,14];
          est    := hoja.Cells[fila,15];
          posi   := hoja.Cells[fila,16];
          alt    := hoja.Cells[fila,17];
          sub1   := hoja.Cells[fila,18];
          sub2   := hoja.Cells[fila,19];

          u := 0;
          found_ubic := False;
          while (u<hist_ubic.Count) and not found_ubic do
          begin
            If (IntToStr(id_alm)+'|'+est+'|'+IntToStr(posi)+'|'+IntToStr(alt)+'|'+sub1=hist_ubic[u]) then
                found_ubic := True
            else
                Inc(u);
          end;

          id_ubic:=busca_ubic(est,id_alm,posi,alt,sub1,0);

          if (id_ubic=-1) and not found_ubic then begin
            //Crea ubicacion si no existe
            with tpfibdataset.Create(frmMain) do
            begin
              database := db;
              SQLs.SelectSQL.Clear;
              SQLs.SelectSQL.Add('SELECT GEN_ID(GEN_A_UBICACIONES_ID, 1) from RDB$DATABASE');
              Open;
              id_ubic := FieldByName('gen_id').AsInteger;
              Free;
            end;
            q_1.Close;
            q_1.SQL.Clear;
            q_1.SQL.Add('insert into a_ubicaciones(ID_UBICACION,ID_ALMACEN,ID_ESTANTERIA,ID_POSICION,ID_ALTURA,ID_SUB1, ID_SUB2) VALUES ' + ' (:ID_UBICACION,:ID_ALMACEN,:ID_ESTANTERIA,:ID_POSICION,:ID_ALTURA,:ID_SUB1, :ID_SUB2)');
            q_1.ParamByName('ID_UBICACION').AsInteger := id_ubic;
            q_1.ParamByName('ID_ALMACEN').AsInteger := id_alm;
            q_1.ParamByName('ID_ESTANTERIA').asstring := est;
            q_1.ParamByName('ID_POSICION').AsInteger := posi;
            q_1.ParamByName('ID_ALTURA').AsInteger := alt;
            q_1.ParamByName('ID_SUB1').asstring := sub1;
            q_1.ParamByName('ID_SUB2').asstring := sub2;
            q_1.ExecQuery;
          end;

          if not found_ubic then
          begin
              hist_ubic.Add(IntToStr(id_alm)+'|'+est+'|'+IntToStr(posi)+'|'+IntToStr(alt)+'|'+sub1);
              hist_id_ubi.Add(IntToStr(id_ubic));
          end else if id_ubic=-1 then
                         id_ubic := StrToInt(hist_id_ubi[u]);


          lb_1.Caption:=IntToStr(n);
          application.ProcessMessages;

          Inc(fila);
       end;
    end;

    write.CommitRetaining;
  except
    on E:Exception do
    begin
      ShowMessage(e.Message);
      write.RollbackRetaining;
    end;

  end;

  //xls.Write;
  excel.activeworkbook.save;

  Excel.Quit ;
  Excel := Unassigned;

  hist_ubic.Free;
  hist_id_ubi.Free;

  ShowMessage('Finished. Lines='+inttostr(n));

end;

procedure TfrmMain.btArticulosClick(Sender: TObject);
var  f:textfile; nom_art,ref,n_caj,est,sufijo,art,sub1,sub2,s,ean,codigo_cli,nom_cli,old_ref:string;
    posi,alt,n,tot,id_alm,id_ubic,id_art,id_mat,mat1,mat2,id_cli,i,uds,familia,uds_emb, a, u, fila:Integer;
    peso,largo,ancho,alto,kgsvol,cubic, precio:double;
    hist_arts, hist_id_art: TStringList;
    found_art: Boolean;
    enc:Boolean;
    aux: string;
begin
  //xls.Filename:=fe_1.Text;
  //xls.Read;

  AbreFichero;
  //RecorreHojas;
  Hoja := excel.Worksheets.Item[1];

  n := 0;

  enc:=false;

  fila := fila_ini;

  //xls.sheets[0].asString[22,0] := 'ID_ARTICULO';
  hoja.Cells[1,30] := 'ID_ARTICULO';

  write.StartTransaction;
  try
    hist_arts := TStringList.Create;
    hist_id_art := TStringList.Create;

    while not(Enc) do begin                                 //busca el final del excel
      lb_1.Caption:=IntToStr(fila);
      application.ProcessMessages;

      //if xls.sheets[0].asstring[1,fila]='' then enc:=true
      aux :=  hoja.Cells[fila,1];

      if aux='' then
        enc:=true
       else begin
          a := 0;
          found_art  := False;
         {id_Cli     := xls.sheets[0].asinteger[0,fila];
          ref        := xls.Sheets[0].AsString[1,fila];
          codigo_cli := xls.Sheets[0].AsString[9,fila];
          nom_cli    := xls.Sheets[0].AsString[20,fila];
          nom_art    := xls.Sheets[0].AsString[2,fila];   }

          id_Cli     := hoja.Cells[fila,1];
          ref        := hoja.Cells[fila,2];
          codigo_cli := hoja.Cells[fila,10];
          nom_cli    := hoja.Cells[fila,21];
          nom_art    := hoja.Cells[fila,3];

          familia := Integer(hoja.Cells[fila,4]);
          if IntToStr(familia)='' then
            familia := 1;

          peso := Double(hoja.Cells[fila,5]);
          if FloatToStr(peso)='' then
            peso := 1;

         kgsvol := Double(hoja.Cells[fila,9]);
          if FloatToStr(kgsvol)='' then
            kgsvol := 1;

          alto := Double(hoja.Cells[fila,6]);
          if FloatToStr(alto)='' then
            alto := 1;

          largo := Double(hoja.Cells[fila,7]);
          if FloatToStr(largo)='' then
            largo := 1;

          ancho := Double(hoja.Cells[fila,8]);
          if FloatToStr(ancho)='' then
            ancho := 1;

          uds_emb := Integer(hoja.Cells[fila,11]);
          if FloatToStr(uds_emb)='' then
              uds_emb := 1;

          cubic := Double(hoja.Cells[fila,20]);
          if FloatToStr(cubic)='' then
            cubic := 0;

          ean:=hoja.Cells[fila,13];

          precio := hoja.Cells[fila,22];
          if FloatToStr(precio)='' then
            precio := 0;

          while (a<hist_arts.Count) and not found_art do
          begin
            If (ref=hist_arts[a]) then
              found_art := True
            else
              Inc(a);
          end;

          id_art:=busca_art_id(IntToStr(id_cli),ref);

          if (id_art=-1) and not found_art then begin                                //Crea articulo si no existe y no se ha creado previamente en este fichero
            if ref<>old_ref then begin
              old_ref:=ref;
              with tpfibdataset.Create(frmMain) do begin
                database:=db;
                SQLs.SelectSQL.Clear;
                SQLs.SelectSQL.Add('SELECT GEN_ID(GEN_G_ARTICULOS_ID, 1) from RDB$DATABASE');
                Open;
                id_art:=FieldByName('gen_id').AsInteger;
                Free;
              end;

              //xls.sheets[0].asinteger[22,fila]:=id_art;
              hoja.Cells[fila,30]:=id_art;

              q_1.Close;
              q_1.sql.Clear;
              q_1.SQL.Add('insert into g_articulos (id_articulo,CODIGO,NOMBRE,ID_CLIENTE,id_familia,kgs,kgsvol,largo,ancho,alto,cubic,uni_embalaje,codigo_cli,nom_cli,precio) values '+
                          '(:id_articulo,:CODIGO,:NOMBRE,:ID_CLIENTE,:id_familia,:kgs,:kgsvol,:largo,:ancho,:alto,:cubic,:uni_embalaje,:codigo_cli,:nom_cli,:precio)');
              q_1.ParamByName('id_articulo').AsInteger  := id_art;
              q_1.ParamByName('codigo').asstring        := ref;
              q_1.ParamByName('nombre').asstring        := nom_art;
              q_1.ParamByName('id_cliente').AsInteger   := id_cli;
              q_1.ParamByName('id_familia').AsInteger   := familia;
              q_1.ParamByName('kgs').asfloat            := peso;
              q_1.ParamByName('kgsvol').asfloat         := kgsvol;
              q_1.ParamByName('largo').asfloat          := largo;
              q_1.ParamByName('ancho').asfloat          := ancho;
              q_1.ParamByName('alto').asfloat           := alto;
              q_1.ParamByName('cubic').asfloat          := cubic;
              q_1.ParamByName('uni_embalaje').AsInteger := uds_emb;
              q_1.ParamByName('codigo_cli').asstring    := codigo_cli;
              q_1.ParamByName('nom_cli').asstring       := nom_cli;
              q_1.ParamByName('precio').asfloat         := precio;
              try
              q_1.ExecQuery;
              except on e:exception do
                  showmessage(e.message);

              end;

              if (ean<>'') then begin
                q_1.Close;
                q_1.sql.Clear;
                q_1.SQL.Add('insert into g_articulos_bc (id_articulo,bc) values '+
                            '(:id_articulo,:bc)');
                q_1.ParamByName('id_articulo').AsInteger:=id_art;
                q_1.ParamByName('bc').asstring:=ean;
                q_1.ExecQuery;
              end;
            end;
          end else if ((id_art>=0) and chArticulo.Checked) then
                   begin
                      q_1.Close;
                      q_1.sql.Clear;
                      q_1.SQL.Add('update g_articulos set ' +
                                  'NOMBRE=:NOMBRE,ID_CLIENTE=:ID_CLIENTE,id_familia=:id_familia,kgs=:kgs,kgsvol=:kgsvol, ' +
                                  'largo=:largo,ancho=:ancho,alto=:alto,cubic=:cubic,uni_embalaje=:uni_embalaje, ' +
                                  'codigo_cli=:codigo_cli,nom_cli=:nom_cli,precio=:precio '+
                                  'where id_articulo=:id_articulo');
                      q_1.ParamByName('id_articulo').AsInteger  := id_art;
                      q_1.ParamByName('nombre').asstring        := nom_art;
                      q_1.ParamByName('id_cliente').AsInteger   := id_cli;
                      q_1.ParamByName('id_familia').AsInteger   := familia;
                      q_1.ParamByName('kgs').asfloat            := peso;
                      q_1.ParamByName('kgsvol').asfloat         := kgsvol;
                      q_1.ParamByName('largo').asfloat          := largo;
                      q_1.ParamByName('ancho').asfloat          := ancho;
                      q_1.ParamByName('alto').asfloat           := alto;
                      q_1.ParamByName('cubic').asfloat          := cubic;
                      q_1.ParamByName('uni_embalaje').AsInteger := uds_emb;
                      q_1.ParamByName('codigo_cli').asstring    := codigo_cli;
                      q_1.ParamByName('nom_cli').asstring       := nom_cli;
                      q_1.ParamByName('precio').asfloat         := precio;
                      q_1.ExecQuery;
                   end;

          if not found_art then
          begin
            hist_arts.Add(ref);
            hist_id_art.Add(IntToStr(id_art));
          end else if id_art=-1 then
                        id_art := StrToInt(hist_id_art[a]);
       end;

       Inc(fila);
       Inc(n);
    end;

    write.CommitRetaining;

  except
    on E:Exception do
    begin
      ShowMessage(e.Message);
      write.RollbackRetaining;
    end;

  end;

  excel.activeworkbook.save;
  Excel.Quit ;
  Excel := Unassigned;

  hist_arts.Free;
  hist_id_art.Free;

  ShowMessage('Finished. Lines='+inttostr(n));

end;

procedure TfrmMain.btn1Click(Sender: TObject);
var  f:textfile; nom_art,ref,n_caj,est,sufijo,art,sub1,s,ean,codigo_cli:string;   posi,alt,n,tot,id_alm,id_ubic,id_art,id_mat,mat1,mat2,id_cli,i,uds,familia,uds_emb,id_zona:Integer;
    peso,largo,ancho,alto,kgsvol,cubic:double;
begin
  AssignFile(f,fe_1.text);
  Reset(f);
  n:=0;
  mat1:=0;
  mat2:=0;
  try
    write.StartTransaction;

    while not Eof(f) do begin
      Readln(f,s);

      i:=pos(';',s);
      ref:=copy(s,1,i-1);
      s:=copy(s,i+1,length(s));

      i:=pos(';',s);
      nom_art:=copy(s,1,i-1);
      s:=copy(s,i+1,length(s));

      i:=pos(';',s);
      familia:=strtoint(copy(s,1,i-1));
      s:=copy(s,i+1,length(s));

      i:=pos(';',s);
      peso:=strtofloat(copy(s,1,i-1));
      s:=copy(s,i+1,length(s));

      i:=pos(';',s);
      largo:=strtofloat(copy(s,1,i-1));
      s:=copy(s,i+1,length(s));

      i:=pos(';',s);
      ancho:=strtofloat(copy(s,1,i-1));
      s:=copy(s,i+1,length(s));

      i:=pos(';',s);
      alto:=strtofloat(copy(s,1,i-1));
      s:=copy(s,i+1,length(s));

      i:=pos(';',s);
      kgsvol:=strtofloat(copy(s,1,i-1));
      s:=copy(s,i+1,length(s));

      i:=pos(';',s);
      cubic:=strtofloat(copy(s,1,i-1));
      s:=copy(s,i+1,length(s));

      i:=pos(';',s);
      uds_emb:=strtoint(copy(s,1,i-1));
      s:=copy(s,i+1,length(s));

      i:=pos(';',s);
      ean:=copy(s,1,i-1);
      s:=copy(s,i+1,length(s));

      i:=pos(';',s);
      uds:=strtoint(copy(s,1,i-1));
      s:=copy(s,i+1,length(s));

      i:=pos(';',s);
      id_alm:=StrToInt(copy(s,1,i-1));
      s:=copy(s,i+1,length(s));

      i:=pos(';',s);
      id_zona:=StrToInt(copy(s,1,i-1));
      s:=copy(s,i+1,length(s));

      i:=pos(';',s);
      est:=copy(s,1,i-1);
      s:=copy(s,i+1,length(s));

      i:=pos(';',s);
      posi:=StrToInt(copy(s,1,i-1));
      s:=copy(s,i+1,length(s));

      i:=pos(';',s);
      alt:=StrToInt(copy(s,1,i-1));
      s:=copy(s,i+1,length(s));

      i:=pos(';',s);
      sub1:=copy(s,1,i-1);
      s:=copy(s,i+1,length(s));

      codigo_cli:=s;

      //****************************************************************VALORES FIJOS
      id_cli:=7004;
      //id_alm:=1;
      //sub1:='0';

      id_ubic:=busca_ubic(est,id_alm,posi,alt,sub1,id_zona);
      //id_ubic:=4800;
      id_art:=busca_art_id('7004',ref);

      if (id_ubic=-1) then begin
        //Crea ubicacion si no existe
        with tpfibdataset.Create(frmMain) do
        begin
          database := db;
          SQLs.SelectSQL.Clear;
          SQLs.SelectSQL.Add('SELECT GEN_ID(GEN_A_UBICACIONES_ID, 1) from RDB$DATABASE');
          Open;
          id_ubic := FieldByName('gen_id').AsInteger;
          Free;
        end;
        q_1.Close;
        q_1.SQL.Clear;
        q_1.SQL.Add('insert into a_ubicaciones(ID_UBICACION,ID_ALMACEN,ID_ESTANTERIA,ID_POSICION,ID_ALTURA,ID_SUB1,ID_ZONA) VALUES ' +
        ' (:ID_UBICACION,:ID_ALMACEN,:ID_ESTANTERIA,:ID_POSICION,:ID_ALTURA,:ID_SUB1,:ID_ZONA)');
        q_1.ParamByName('ID_UBICACION').AsInteger := id_ubic;
        q_1.ParamByName('ID_ALMACEN').AsInteger := id_alm;
        q_1.ParamByName('ID_ESTANTERIA').asstring := est;
        q_1.ParamByName('ID_POSICION').AsInteger := posi;
        q_1.ParamByName('ID_ALTURA').AsInteger := alt;
        q_1.ParamByName('ID_SUB1').asstring := sub1;
        q_1.ParamByName('ID_ZONA').AsInteger := id_zona;
        q_1.ExecQuery;
      end;

      //if (id_art=-1) then raise exception.Create('Articulo Desconocido');

      if (id_art=-1) then begin                                //Crea articulo si no existe
        with tpfibdataset.Create(frmMain) do begin
          database:=db;
          SQLs.SelectSQL.Clear;
          SQLs.SelectSQL.Add('SELECT GEN_ID(GEN_G_ARTICULOS_ID, 1) from RDB$DATABASE');
          Open;
          id_art:=FieldByName('gen_id').AsInteger;
          Free;
        end;


        q_1.Close;
        q_1.sql.Clear;
        q_1.SQL.Add('insert into g_articulos (id_articulo,CODIGO,NOMBRE,ID_CLIENTE,id_familia,kgs,kgsvol,largo,ancho,alto,cubic,uni_embalaje,codigo_cli) values '+
                    '(:id_articulo,:CODIGO,:NOMBRE,:ID_CLIENTE,:id_familia,:kgs,:kgsvol,:largo,:ancho,:alto,:cubic,:uni_embalaje,:codigo_cli)');
        q_1.ParamByName('id_articulo').AsInteger:=id_art;
        q_1.ParamByName('codigo').asstring:=ref;
        q_1.ParamByName('nombre').asstring:=nom_art;
        q_1.ParamByName('id_cliente').AsInteger:=id_cli;
        q_1.ParamByName('id_familia').AsInteger:=familia;
        q_1.ParamByName('kgs').asfloat:=peso;
        q_1.ParamByName('kgsvol').asfloat:=kgsvol;
        q_1.ParamByName('largo').asfloat:=largo;
        q_1.ParamByName('ancho').asfloat:=ancho;
        q_1.ParamByName('alto').asfloat:=alto;
        q_1.ParamByName('cubic').asfloat:=cubic;
        q_1.ParamByName('uni_embalaje').AsInteger:=uds_emb;
        q_1.ParamByName('codigo_cli').asstring:=codigo_cli;
        q_1.ExecQuery;

        if (ean<>'') then begin
          q_1.Close;
          q_1.sql.Clear;
          q_1.SQL.Add('insert into g_articulos_bc (id_articulo,bc) values '+
                      '(:id_articulo,:bc)');
          q_1.ParamByName('id_articulo').AsInteger:=id_art;
          q_1.ParamByName('bc').asstring:=ean;
          q_1.ExecQuery;
        end;
      end;

      with tpfibdataset.Create(frmMain) do begin                       //Nueva matricula
        database:=db;
        SQLs.SelectSQL.Clear;
        SQLs.SelectSQL.Add('SELECT GEN_ID(GEN_A_MATRICULAS_ID, 1) from RDB$DATABASE');
        Open;

        id_mat:=FieldByName('gen_id').AsInteger;
        if n=0 then mat1:=id_mat
          else mat2:=id_mat;

        Free;
      end;

      q_1.Close;
      q_1.SQL.Clear;
      q_1.SQL.Add('insert into a_stock (ID_ALMACEN,ID_UBICACION,ID_ARTICULO,ID_MATRICULA,ID_LOTE,CANTIDAD,ID_EMPRESA) VALUES '+
        ' (:ID_ALMACEN,:ID_UBICACION,:ID_ARTICULO,:ID_MATRICULA,1,:ctdad,1)');
      q_1.ParamByName('id_almacen').AsInteger:=id_alm;
      q_1.ParamByName('id_ubicacion').AsInteger:=id_ubic;
      q_1.ParamByName('id_articulo').AsInteger:=id_art;
      q_1.ParamByName('id_matricula').AsInteger:=id_mat;
      q_1.ParamByName('ctdad').AsInteger:=uds;
      q_1.ExecQuery;

      q_1.Close;
      q_1.sql.Clear;
      q_1.sql.Add('insert into a_matriculas (id_matricula,id_articulo,uds_ini,tipo,alb_cliente,observaciones) '+
        ' values (:id_matricula,:id_articulo,:uds_ini,:tipo,:alb_cliente,:observaciones)');
      q_1.ParamByName('id_matricula').AsInteger:=id_mat;
      q_1.ParamByName('id_articulo').AsInteger:=id_art;
      q_1.ParamByName('uds_ini').AsInteger:=uds;
      q_1.ParamByName('tipo').asstring:='E';
      q_1.ParamByName('alb_cliente').asstring:='Entrada Automática';
      q_1.ParamByName('observaciones').Asstring:='Entrada Automática';
      q_1.ExecQuery;

      Inc(n);

      lb_1.Caption:=IntToStr(n);
      application.ProcessMessages;
    end;

    write.Commit;
  except
    write.Rollback;
  end;

  CloseFile(f);
  ShowMessage('Finished Mat1='+inttostr(mat1)+' Mat2='+inttostr(mat2)+' Lines='+inttostr(n));
end;

procedure TfrmMain.btn_asevalClick(Sender: TObject);
var
	f:textfile;
  nom_art,ref,n_caj,est,sufijo,art,sub1,s, tipo, prefijo, dbg :string;
  posi,alt,n,tot,id_alm,id_ubic,id_art,id_mat,mat1,mat2,id_cli,i,uds, caja_d, caja_h:Integer;
begin
  AssignFile(f,fe_1.text);
  Reset(f);
  n:=0;
  tot:=0;
  mat1:=0;
  mat2:=0;

  //****************************************************************VALORES FIJOS
  id_cli:=6131;
  id_alm:=2;
  sub1:='0';
  uds:=1;

  while not Eof(f) do begin
  	Readln(f,s);

    // Leo el tipo
    tipo := AnsiUpperCase(Trim(Pop(s)));
    prefijo := '';
		if tipo = 'BANKIA SEGUROS' then prefijo := 'BS';
		if tipo = 'BANKIA PENSIONES' then prefijo := 'BP';
		if tipo = 'BANCO VALENCIA SEGUROS' then prefijo := 'VS';
    if tipo = 'BANCO VALENCIA PENSIONES' then prefijo := 'VP';
    if tipo = 'ASEVAL' then prefijo := 'AS';
    if tipo = 'AVIVA' then prefijo := 'AV';
    if prefijo = '' then Continue;

    // Cajas desde y hasta
    caja_d := StrToInt(Pop(s));
    caja_h := StrToInt(Pop(s));

    // Estantería, posición y altura
    est := Pop(s);
    posi := StrToInt(Pop(s));
    alt := StrToInt(Pop(s));

    // ShowMessage(Format('%d a %d: %s-%d-%d', [caja_d, caja_h, est, posi, alt]));

    // Localizo la ubicación
    id_ubic:=busca_ubic(est,id_alm,posi,alt,sub1,0);

    for i := caja_d to caja_h do
    begin
    	art := Format('%d07%s%.6d', [id_cli, prefijo, i]);
    	id_art:=busca_art_id('6131',art);

    	if not(ubicado(id_art,id_ubic)) then begin              //Verifica que ya esté ubicado el artículo
      	try
        	write.StartTransaction;

        	if id_ubic = -1 then
      			id_ubic := crea_ubicacion(id_alm, est, posi, alt, sub1);

          if id_art = -1 then
        		id_art := crea_articulo_aseval(id_cli, art, prefijo, i);

        	entrada_aseval(id_art, uds, id_alm, id_ubic, id_mat);

          if n=0 then mat1:=id_mat
            else mat2:=id_mat;

          Inc(n);
          write.Commit;
        except
        	write.Rollback;
        end;
      end;

      Inc(tot);

      lb_1.Caption:=IntToStr(n)+' / '+inttostr(tot);
      application.ProcessMessages;
    end;
  end;

  CloseFile(f);
  ShowMessage('Finished Mat1='+inttostr(mat1)+' Mat2='+inttostr(mat2)+' Lines='+inttostr(n));
end;

procedure TfrmMain.btn_aseval_2Click(Sender: TObject);
{var
  Hoja : TSheet;
  Fila: Integer;
  ubicacion: String;
  partes: TStringDynArray;
  estante: string;
  posicion: Integer;
  altura: Integer;
  id_ubicacion: Integer;
  Columna: Integer;
  id_cli: Integer;
  id_alm: Integer;
  sub1: string;
  uds: Integer;
  caja: WideString;
  art: string;
  id_articulo: Integer;
  Item: TCollectionItem;
  id_mat: Integer;
  mat1,mat2: Integer;
  n: Integer;
  tot: Integer;         }
begin
 { //****************************************************************VALORES FIJOS
  id_cli:=6131;
  id_alm:=2;
  sub1:='0';
  uds:=1;

	xls.Filename := fe_1.Text;
  xls.Read;

  n := 0;
  tot := 0;
  for Item in xls.Sheets do
  begin
  	Hoja := TSheet(Item);

    	//La columna con la ubicación definitiva es la B Buscamos el texto "DEF" que nos dice dónde está la cabecera

    Fila := -1;
    repeat
			Inc(Fila);
    until SameText(Trim(Hoja.AsString[1,Fila]), 'DEF');
    Inc(Fila);

    while Hoja.AsString[1,Fila] <> '' do
    begin
    	// troceo la ubicación por los guiones
			ubicacion := Hoja.AsString[1,Fila];
      partes := SplitString(ubicacion, '-');
      // sólo continúo si hay exactamente 3 partes
      if(Length(partes) = 3) then
      begin
      	estante := partes[0];
        posicion := StrToIntDef(partes[1], -1);
        altura := StrToIntDef(partes[2], -1);

        // Busco una ubicación en la BD que coincida con lo que acabo de obtener
        id_ubicacion := busca_ubic(estante, id_alm, posicion, altura, sub1,0);

        // Ahora recorremos las columnas y vemos qué cajas hay en esta fila
        Columna := 2;
        while Hoja.AsString[Columna, Fila] <> '' do
        begin
        	caja := Hoja.AsString[Columna, Fila];
        	art := Format('%d07%s', [id_cli, caja]);
          id_articulo := busca_art_id(art);

          if not ubicado(id_articulo, id_ubicacion) then
          begin
            write.StartTransaction;

            try
              if id_ubicacion = -1 then
                id_ubicacion := crea_ubicacion(id_alm, estante, posicion, altura, sub1);
              if id_articulo = -1 then
                id_articulo := crea_articulo_aseval(id_cli, art, caja);

              entrada_aseval(id_articulo, uds, id_alm, id_ubicacion, id_mat);
              if n=0 then mat1:=id_mat
                else mat2:=id_mat;

              Inc(n);
              write.Commit;
            except
              write.RollbackRetaining;
            end;
          end;

          Inc(Columna);
          inc(tot);
          lb_1.Caption:=Hoja.Name + ' :: ' + IntToStr(n)+' / '+inttostr(tot);
          application.ProcessMessages;
        end;
      end;
      Inc(Fila);
    end;
  end;
  ShowMessage('Finished Mat1='+inttostr(mat1)+' Mat2='+inttostr(mat2)+' Lines='+inttostr(n));  }
end;

function TfrmMain.crea_articulo_aseval(id_cli: Integer; art, caja: string):
		Integer;
begin
	Result := -1;
  with tpfibdataset.Create(nil) do
  begin
    database := db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('SELECT GEN_ID(GEN_G_ARTICULOS_ID, 1) from RDB$DATABASE');
    Open;
    Result := FieldByName('gen_id').AsInteger;
    Free;
  end;

  q_1.Close;
  q_1.sql.Clear;
  q_1.SQL.Add('insert into g_articulos (id_articulo,CODIGO,NOMBRE,ID_CLIENTE,CODIGO_CLI) values ' + '(:id_articulo,:CODIGO,:NOMBRE,:ID_CLIENTE, :CODIGO_CLI)');
  q_1.ParamByName('id_articulo').AsInteger := Result;
  q_1.ParamByName('codigo').asstring := art;
  q_1.ParamByName('nombre').asstring := 'CAJA ' + caja;
  q_1.ParamByName('id_cliente').AsInteger := id_cli;
  q_1.ParamByName('codigo_cli').asstring := caja;
  q_1.ExecQuery;
	// TODO -cMM: TForm1.crea_articulo_aseval default body inserted
end;

procedure TfrmMain.bt_2Click(Sender: TObject);
var  f:textfile; nom_art,ref,n_caj,est,sufijo,art,sub1,s,ean,codigo_cli:string;   posi,alt,n,tot,id_alm,id_ubic,id_art,id_mat,mat1,mat2,id_cli,i,uds,familia,uds_emb:Integer;
    peso,largo,ancho,alto,kgsvol,cubic:double;
begin
  AssignFile(f,fe_1.text);
  Reset(f);
  n:=0;
  mat1:=0;
  mat2:=0;
  try
    write.StartTransaction;

    while not Eof(f) do begin
      Readln(f,s);

      i:=pos(';',s);
      n_caj:=UpperCase(copy(s,1,i-1));
      s:=copy(s,i+1,length(s));

      i:=pos(';',s);
      est:=copy(s,1,i-1);
      s:=copy(s,i+1,length(s));

      i:=pos(';',s);
      posi:=StrToInt(copy(s,1,i-1));
      s:=copy(s,i+1,length(s));

      alt:=StrToInt(copy(s,1,i-1));

      //****************************************************************VALORES FIJOS
      id_cli:=6131;
      id_alm:=1;
      uds:=1;
      sub1:='0';
      ref:='613107'+n_caj;

      nom_art:='CAJA '+n_caj;
      familia:=1;
      peso:=1;
      kgsvol:=1;
      largo:=1;
      ancho:=1;
      alto:=1;
      cubic:=1;
      uds_emb:=1;
      codigo_cli:=n_caj;
      ean:='';

      id_ubic:=busca_ubic(est,id_alm,posi,alt,sub1,0);
      id_art:=busca_art_id('6131',ref);

      if (id_ubic=-1) then begin
        //Crea ubicacion si no existe
        with tpfibdataset.Create(frmMain) do
        begin
          database := db;
          SQLs.SelectSQL.Clear;
          SQLs.SelectSQL.Add('SELECT GEN_ID(GEN_A_UBICACIONES_ID, 1) from RDB$DATABASE');
          Open;
          id_ubic := FieldByName('gen_id').AsInteger;
          Free;
        end;
        q_1.Close;
        q_1.SQL.Clear;
        q_1.SQL.Add('insert into a_ubicaciones(ID_UBICACION,ID_ALMACEN,ID_ESTANTERIA,ID_POSICION,ID_ALTURA,ID_SUB1) VALUES ' + ' (:ID_UBICACION,:ID_ALMACEN,:ID_ESTANTERIA,:ID_POSICION,:ID_ALTURA,:ID_SUB1)');
        q_1.ParamByName('ID_UBICACION').AsInteger := id_ubic;
        q_1.ParamByName('ID_ALMACEN').AsInteger := id_alm;
        q_1.ParamByName('ID_ESTANTERIA').asstring := est;
        q_1.ParamByName('ID_POSICION').AsInteger := posi;
        q_1.ParamByName('ID_ALTURA').AsInteger := alt;
        q_1.ParamByName('ID_SUB1').asstring := sub1;
        q_1.ExecQuery;
      end;

      //if (id_art=-1) then raise exception.Create('Articulo Desconocido');

      if (id_art=-1) then begin                                //Crea articulo si no existe
        with tpfibdataset.Create(frmMain) do begin
          database:=db;
          SQLs.SelectSQL.Clear;
          SQLs.SelectSQL.Add('SELECT GEN_ID(GEN_G_ARTICULOS_ID, 1) from RDB$DATABASE');
          Open;
          id_art:=FieldByName('gen_id').AsInteger;
          Free;
        end;


        q_1.Close;
        q_1.sql.Clear;
        q_1.SQL.Add('insert into g_articulos (id_articulo,CODIGO,NOMBRE,ID_CLIENTE,id_familia,kgs,kgsvol,largo,ancho,alto,cubic,uni_embalaje,codigo_cli) values '+
                    '(:id_articulo,:CODIGO,:NOMBRE,:ID_CLIENTE,:id_familia,:kgs,:kgsvol,:largo,:ancho,:alto,:cubic,:uni_embalaje,:codigo_cli)');
        q_1.ParamByName('id_articulo').AsInteger:=id_art;
        q_1.ParamByName('codigo').asstring:=ref;
        q_1.ParamByName('nombre').asstring:=nom_art;
        q_1.ParamByName('id_cliente').AsInteger:=id_cli;
        q_1.ParamByName('id_familia').AsInteger:=familia;
        q_1.ParamByName('kgs').asfloat:=peso;
        q_1.ParamByName('kgsvol').asfloat:=kgsvol;
        q_1.ParamByName('largo').asfloat:=largo;
        q_1.ParamByName('ancho').asfloat:=ancho;
        q_1.ParamByName('alto').asfloat:=alto;
        q_1.ParamByName('cubic').asfloat:=cubic;
        q_1.ParamByName('uni_embalaje').AsInteger:=uds_emb;
        q_1.ParamByName('codigo_cli').asstring:=codigo_cli;
        q_1.ExecQuery;

        if (ean<>'') then begin
          q_1.Close;
          q_1.sql.Clear;
          q_1.SQL.Add('insert into g_articulos_bc (id_articulo,bc) values '+
                      '(:id_articulo,:bc)');
          q_1.ParamByName('id_articulo').AsInteger:=id_art;
          q_1.ParamByName('bc').asstring:=ean;
          q_1.ExecQuery;
        end;
      end;

      with tpfibdataset.Create(frmMain) do begin                       //Nueva matricula
        database:=db;
        SQLs.SelectSQL.Clear;
        SQLs.SelectSQL.Add('SELECT GEN_ID(GEN_A_MATRICULAS_ID, 1) from RDB$DATABASE');
        Open;

        id_mat:=FieldByName('gen_id').AsInteger;
        if n=0 then mat1:=id_mat
          else mat2:=id_mat;

        Free;
      end;

      q_1.Close;
      q_1.SQL.Clear;
      q_1.SQL.Add('insert into a_stock (ID_ALMACEN,ID_UBICACION,ID_ARTICULO,ID_MATRICULA,ID_LOTE,CANTIDAD,ID_EMPRESA) VALUES '+
        ' (:ID_ALMACEN,:ID_UBICACION,:ID_ARTICULO,:ID_MATRICULA,1,:ctdad,1)');
      q_1.ParamByName('id_almacen').AsInteger:=id_alm;
      q_1.ParamByName('id_ubicacion').AsInteger:=id_ubic;
      q_1.ParamByName('id_articulo').AsInteger:=id_art;
      q_1.ParamByName('id_matricula').AsInteger:=id_mat;
      q_1.ParamByName('ctdad').AsInteger:=uds;
      q_1.ExecQuery;

    {  q_1.Close;
      q_1.sql.Clear;
      q_1.sql.Add('insert into a_matriculas (id_matricula,id_articulo,uds_ini,tipo,alb_cliente,observaciones) '+
        ' values (:id_matricula,:id_articulo,:uds_ini,:tipo,:alb_cliente,:observaciones)');
      q_1.ParamByName('id_matricula').AsInteger:=id_mat;
      q_1.ParamByName('id_articulo').AsInteger:=id_art;
      q_1.ParamByName('uds_ini').AsInteger:=uds;
      q_1.ParamByName('tipo').asstring:='E';
      q_1.ParamByName('alb_cliente').asstring:='Entrada Automática';
      q_1.ParamByName('observaciones').Asstring:='Entrada Automática';
      q_1.ExecQuery;      }

      Inc(n);

      lb_1.Caption:=IntToStr(n);
      application.ProcessMessages;
    end;

    write.Commit;
  except
    write.Rollback;
  end;

  CloseFile(f);
  ShowMessage('Finished Mat1='+inttostr(mat1)+' Mat2='+inttostr(mat2)+' Lines='+inttostr(n));
end;

procedure TfrmMain.btTodoClick(Sender: TObject);
var f:textfile; nom_art,ref,n_caj,est,sufijo,art,sub1,sub2,s,ean,codigo_cli,nom_cli,old_ref, imei, lote, alb_cliente:string;
    posi,alt,n,tot,id_alm,id_ubic,id_art,id_mat,mat1,mat2,id_cli,i,uds,familia,uds_emb, a, u, fila, hoja_lotes, hoja_n_serie:Integer;
    peso,largo,ancho,alto,kgsvol,cubic, precio:double;
    found_art, found_ubic: Boolean;
    enc:Boolean;
    caducidad, cad_lote : TDate;
    errores: string;
    fecha_nula: TDate;
begin
  Screen.Cursor := crHourGlass;

  AbreFichero;
  //RecorreHojas;
  Hoja := excel.Worksheets.Item[1];

  errores := '';

  //Comprobar fechas correctas
  fecha_nula := StrToDate('01/01/1900');
  enc:=false;
  fila := fila_ini;

  while not enc do
    if Trim(hoja.Cells[fila,1])='' then
          enc:=true
    else begin
            If Trim(hoja.Cells[fila,26])<>'' then
               if (StrToDateDef(Trim(hoja.Cells[fila,26]),fecha_nula)=fecha_nula) then
                  errores := errores + 'Fila ' + IntToStr(fila) + ': caducidad lote fecha incorrecta' + ln;

            If Trim(hoja.Cells[fila,24])<>'' then
               if (StrToDateDef(Trim(hoja.Cells[fila,24]),fecha_nula)=fecha_nula) then
                  errores := errores + 'Fila ' + IntToStr(fila) + ': caducidad imei fecha incorrecta' + ln;

            If Trim(hoja.Cells[fila,12])<>'' then
               if (StrToIntDef(Trim(hoja.Cells[fila,12]),-1)=-1) then
                  errores := errores + 'Fila ' + IntToStr(fila) + ': unidades no es entero' + ln;

            If Trim(hoja.Cells[fila,14])<>'' then
            begin
               if ((StrToIntDef(Trim(hoja.Cells[fila,14]),-1)<>-1) or
                   (Trim(hoja.Cells[fila,14])='-1')) then
                   if not existe_almacen(StrToInt(Trim(hoja.Cells[fila,14]))) then
                  errores := errores + 'Fila ' + IntToStr(fila) + ': almacén no válido' + ln;
            end else
                  errores := errores + 'Fila ' + IntToStr(fila) + ': almacén sin rellenar ' + ln;
            Inc(fila);
         end;

  if errores<>'' then
  begin
    Showmessage('Existen datos a revisar:' + ln + errores);

    excel.activeworkbook.save;
    Excel.Quit ;
    Excel := Unassigned;

    Screen.Cursor := crDefault;

    Exit;
  end;

  n:=0;
  mat1:=0;
  mat2:=0;
  fila := fila_ini;

  found_art := False; found_ubic := False;

  enc:=false;
  old_ref:='99292929299292';   //random value

            //fila,columna
  hoja.Cells[1,30] := 'ID_UBICACION';
  hoja.Cells[1,31] := 'ID_ARTICULO';
  hoja.Cells[1,32] := 'ID_MATRICULA';
  hoja.Cells[1,33] := 'ID_LOTE';

    while not(Enc) do begin                                 //busca el final del hoja
      lb_1.Caption:='Cargando fila ' + IntToStr(fila);
      application.ProcessMessages;

      if Trim(hoja.Cells[fila,1])='' then
          enc:=true
       else begin
          id_Cli:=StrToInt(trim(hoja.Cells[fila,1]));
          ref:=hoja.Cells[fila,2];
          codigo_cli:=hoja.Cells[fila,10];

          nom_cli:=hoja.Cells[fila,21];

          nom_art:=hoja.Cells[fila,3];

          if Trim(hoja.Cells[fila,4])='' then
            familia := 1
          else
            familia:=StrToInt(trim(hoja.Cells[fila,4]));

          if Trim(hoja.Cells[fila,5])='' then
            peso := 0
          else
            peso:=StrToFloat(trim(hoja.Cells[fila,5]));

          if Trim(hoja.Cells[fila,9])='' then
            kgsvol := 0
          else
            kgsvol:=StrToFloat(trim(hoja.Cells[fila,9]));

          if Trim(hoja.Cells[fila,6])='' then
            alto := 0
          else
            alto:=StrToFloat(hoja.Cells[fila,6]);

          if Trim(hoja.Cells[fila,7])='' then
            largo := 0
          else
            largo:=StrToFloat(hoja.Cells[fila,7]);

          if Trim(hoja.Cells[fila,8])='' then
            ancho := 0
          else
            ancho:=StrToFloat(hoja.Cells[fila,8]);

          if Trim(hoja.Cells[fila,11])='' then
              uds_emb := 1
          else
              uds_emb:=hoja.Cells[fila,11];

          uds:=hoja.Cells[fila,12];
          id_alm:=hoja.Cells[fila,14];
          est:=hoja.Cells[fila,15];
          posi:=hoja.Cells[fila,16];
          alt:=hoja.Cells[fila,17];
          sub1:=hoja.Cells[fila,18];
          sub2:=hoja.Cells[fila,19];
          //sub1:='';
          if sub1='' then sub1:='0';
          if sub2='' then sub2:='0';

          if Trim(hoja.Cells[fila,20])='' then
              cubic := 0
          else
              cubic:=hoja.Cells[fila,20];

          if FloatToStr(cubic)='' then
              cubic := 0;

          ean:=hoja.Cells[fila,13];

          if Trim(hoja.Cells[fila,22])='' then
            precio := 0
          else
            precio := hoja.Cells[fila,22];

          imei := hoja.Cells[fila,23];
          caducidad := hoja.Cells[fila,24];

          lote := hoja.Cells[fila,25];
          if Trim(hoja.Cells[fila,26])<>'' then
              cad_lote := StrToDate(Trim(hoja.Cells[fila,26]))
          else
              cad_lote := hoja.Cells[fila,26];

          alb_cliente := hoja.Cells[fila,27];

          ds1.Insert;
          ds1.FieldByName('linea').AsInteger      := fila;
          ds1.FieldByName('CodCli').AsInteger     := id_cli;
          ds1.FieldByName('CodArt').AsString      := ref;
          ds1.FieldByName('NomArt').AsString      := nom_art;
          ds1.FieldByName('Fam').AsInteger        := familia;
          ds1.FieldByName('Peso').AsFloat         := peso;
          ds1.FieldByName('Alto').AsFloat         := alto;
          ds1.FieldByName('Largo').AsFloat        := largo;
          ds1.FieldByName('Ancho').AsFloat        := ancho;
          ds1.FieldByName('KgsVol').AsFloat       := kgsvol;
          ds1.FieldByName('RefCli').AsString      := codigo_cli;
          ds1.FieldByName('udsEmb').AsInteger     := uds_emb;
          ds1.FieldByName('Uds').AsInteger        := uds;
          ds1.FieldByName('BC').AsString          := ean;
          ds1.FieldByName('idAlm').AsInteger      := id_alm;
          ds1.FieldByName('Estanteria').AsString  := est;
          ds1.FieldByName('Posicion').AsInteger   := posi;
          ds1.FieldByName('Altura').AsInteger     := alt;
          ds1.FieldByName('Sub1').AsString        := sub1;
          ds1.FieldByName('Sub2').AsString        := sub2;
          ds1.FieldByName('Cubic').AsFloat        := cubic;
          ds1.FieldByName('NomcliArt').AsString   := nom_cli;
          ds1.FieldByName('Precio').AsFloat       := precio;
          ds1.FieldByName('Imei').AsString        := imei;
          ds1.FieldByName('Caducidad').AsDateTime := caducidad;
          ds1.FieldByName('lote').AsString        := lote;
          ds1.FieldByName('cad_lote').AsDateTime  := cad_lote;
          ds1.FieldByName('alb_cliente').AsString := alb_cliente;
          ds1.Post;

          Inc(n);

          //lb_1.Caption:=IntToStr(n);
          application.ProcessMessages;

          Inc(fila);
       end;
    end;

   lineas_total := n;

   write.StartTransaction;
   try
    InsertaBBDD;
    write.CommitRetaining;

    ShowMessage('Finished Mat1='+inttostr(mat1)+' Mat2='+inttostr(mat2)+' Lineas='+inttostr(n));

   except
      on E:Exception do
      begin
        ShowMessage(e.Message);
        write.RollbackRetaining;
      end;

   end;

  //xls.Write;
  excel.activeworkbook.save;
  Excel.Quit ;
  Excel := Unassigned;

  Screen.Cursor := crDefault;
end;

procedure TfrmMain.b_1Click(Sender: TObject);
var  f:textfile; nom_art,ref,n_caj,est,sufijo,art,sub1,s,ean,codigo_cli, nom_cli, etiq_int, etiq_nac:string;   posi,alt,n,tot,id_alm,id_ubic,id_art,id_mat,id_cli,i,uds,familia,uds_emb,id_zona:Integer;
    peso,largo,ancho,alto,kgsvol,cubic:double;
begin
  AssignFile(f,fe_1.text);
  Reset(f);
  n:=0;
  try
    write.StartTransaction;

    while not Eof(f) do begin
      Readln(f,s);

      i:=pos(';',s);
      ref:=copy(s,1,i-1);
      s:=copy(s,i+1,length(s));

      i:=pos(';',s);
      nom_art:=copy(s,1,i-1);
      s:=copy(s,i+1,length(s));

      i:=pos(';',s);
      codigo_cli:=copy(s,1,i-1);
      s:=copy(s,i+1,length(s));

      i:=pos(';',s);
      nom_cli:=copy(s,1,i-1);
      s:=copy(s,i+1,length(s));

      i:=pos(';',s);
      ean:=copy(s,1,i-1);
      s:=copy(s,i+1,length(s));

      i:=pos(';',s);
      peso:=strtofloat(copy(s,1,i-1));
      s:=copy(s,i+1,length(s));

      i:=pos(';',s);
      largo:=strtofloat(copy(s,1,i-1));
      s:=copy(s,i+1,length(s));

      i:=pos(';',s);
      ancho:=strtofloat(copy(s,1,i-1));
      s:=copy(s,i+1,length(s));

      i:=pos(';',s);
      alto:=strtofloat(copy(s,1,i-1));
      s:=copy(s,i+1,length(s));

      i:=pos(';',s);
      cubic:=strtofloat(copy(s,1,i-1));
      s:=copy(s,i+1,length(s));

      i:=pos(';',s);
      etiq_int:=copy(s,1,i-1);
      s:=copy(s,i+1,length(s));

      etiq_nac:=s;

      familia:=0;
      kgsvol:=0;
      uds_emb:=0;


      //****************************************************************VALORES FIJOS
      id_cli:=6702;

      id_art:=busca_art_id('6702',ref);

      if (id_art=-1) then begin                                //Crea articulo si no existe
        with tpfibdataset.Create(frmMain) do begin
          database:=db;
          SQLs.SelectSQL.Clear;
          SQLs.SelectSQL.Add('SELECT GEN_ID(GEN_G_ARTICULOS_ID, 1) from RDB$DATABASE');
          Open;
          id_art:=FieldByName('gen_id').AsInteger;
          Free;
        end;


        q_1.Close;
        q_1.sql.Clear;
        q_1.SQL.Add('insert into g_articulos (id_articulo,CODIGO,NOMBRE,ID_CLIENTE,id_familia,kgs,kgsvol,largo,ancho,alto,cubic,uni_embalaje,codigo_cli,nom_cli,etiq_intl,etiq_nac) values '+
                    '(:id_articulo,:CODIGO,:NOMBRE,:ID_CLIENTE,:id_familia,:kgs,:kgsvol,:largo,:ancho,:alto,:cubic,:uni_embalaje,:codigo_cli,:nom_cli,:etiq_intl,:etiq_nac)');
        q_1.ParamByName('id_articulo').AsInteger:=id_art;
        q_1.ParamByName('codigo').asstring:=ref;
        q_1.ParamByName('nombre').asstring:=nom_art;
        q_1.ParamByName('id_cliente').AsInteger:=id_cli;
        q_1.ParamByName('id_familia').AsInteger:=familia;
        q_1.ParamByName('kgs').asfloat:=peso;
        q_1.ParamByName('kgsvol').asfloat:=kgsvol;
        q_1.ParamByName('largo').asfloat:=largo;
        q_1.ParamByName('ancho').asfloat:=ancho;
        q_1.ParamByName('alto').asfloat:=alto;
        q_1.ParamByName('cubic').asfloat:=cubic;
        q_1.ParamByName('uni_embalaje').AsInteger:=uds_emb;
        q_1.ParamByName('codigo_cli').asstring:=codigo_cli;
        q_1.ParamByName('nom_cli').asstring:=nom_cli;
        q_1.ParamByName('etiq_intl').asstring:=etiq_int;
        q_1.ParamByName('etiq_nac').asstring:=etiq_nac;
        q_1.ExecQuery;

        if (ean<>'') then begin
          q_1.Close;
          q_1.sql.Clear;
          q_1.SQL.Add('update or insert into g_articulos_bc (id_articulo,bc) values '+
                      '(:id_articulo,:bc) matching (id_articulo, bc)');
          q_1.ParamByName('id_articulo').AsInteger:=id_art;
          q_1.ParamByName('bc').asstring:=ean;
          q_1.ExecQuery;
        end;
      end;

      Inc(n);

      lb_1.Caption:=IntToStr(n);
      application.ProcessMessages;
    end;

    write.Commit;
  except
    write.Rollback;
  end;

  CloseFile(f);
  ShowMessage('Finished Lines='+inttostr(n));
end;


procedure TfrmMain.b_2Click(Sender: TObject);
var  i:integer;     nombrefile:string;  lista_files:TStringlist;
begin
  lista_files:=tstringlist.Create;
  ListaArchivos(IncludeTrailingBackslash(de_1.text),'jpg',lista_files);
  try
    try
      write.StartTransaction;
      for i := 0 to lista_files.Count-1 do begin
        nombrefile:=ExtractFileName(lista_files[i]);
        nombrefile:=Copy(nombrefile,1,Length(nombrefile)-length(ExtractFileExt(nombrefile)));   //nombre del archivo sin extension

        q_0.Close;
        q_0.sqls.selectsql.Clear;
        q_0.SQLs.selectsql.Add('select id_articulo from g_articulos where id_cliente=:id_cliente and codigo=:codigo');
        q_0.ParamByName('id_cliente').AsInteger:=6702;
        q_0.ParamByName('codigo').AsString:=Trim(nombrefile);
        q_0.Open;

        if not(q_0.isempty) then begin
          q_1.Close;
          q_1.sql.Clear;
          q_1.SQL.Add('update g_articulos set imagen=:imagen where id_articulo=:id_articulo');
          q_1.ParamByName('id_articulo').AsInteger:=q_0.FieldByName('id_articulo').AsInteger;
          q_1.parambyname('imagen').LoadFromFile(lista_files[i]);
          q_1.ExecQuery;
        end;

        lb_1.Caption:=IntToStr(i);
        application.ProcessMessages;
      end;
      write.Commit;
    except
      write.Rollback;
    end;
  finally
    freeandnil(lista_files);
  end;
end;

procedure TfrmMain.ListaArchivos(dir,ext:string; Lista:TStringList);
var
  sr: TSearchRec;  extension:string;
begin
  if ext<>'' then extension:='*.'+ext
    else extension:='*';
  if FindFirst(dir + extension, faAnyFile, sr) = 0 then
    repeat
      if (sr.Attr and faDirectory = 0) or (sr.Name<>'.') and (sr.Name<>'..') then
       Lista.Add(dir + sr.Name);
    until FindNext(sr) <> 0;
  FindClose(sr);
end;


procedure TfrmMain.AbreFichero;
begin
   Excel:=CreateOleObject('Excel.Application');
   try
     Excel.Visible := False;
     Excel.DisplayAlerts:= False;
     Excel.WorkBooks.Open(fe_1.text);//fichero que queremos leer
   except
     Excel.Quit ;
     Excel := Unassigned;
   end;
end;


//recorremos las distintas hojas del fichero
procedure TfrmMain.RecorreHojas;
var
  h:integer;
begin
   for h:=1 to excel.worksheets.Count do
   begin
     Hoja := Excel.Worksheets.Item[h];

    { if h=1 then //los conceptos son iguales en todas las hojas
     begin
           procesa;
     end;       }

     //LeeDatos;
   end;
   //Excel.Quit ;
   //Excel := Unassigned;
end;


procedure TfrmMain.InsertaBBDD;
var
  found_ubic, found_art, found_imei, primer_insert, found_lote: Boolean;
  hist_arts, hist_ubic, hist_id_art, hist_id_ubi, hist_imei, hist_id_cli, hist_lote, hist_id_lote,hist_cad_lote: TStringList;
  a, u, i, cli_actual, id_ubic, id_art, id_mat, stock, linea, mat_ant, id_alm, n_linea, cli_ant, id_lote: integer;
  art_ant, ubic_ant, old_ref, imei, lote_ant,cad_lote_ant: string;
  caducidad: TDate;
begin

  SetLength(lineas,lineas_total);

  hist_arts := TStringList.Create;
  hist_ubic := TStringList.Create;
  hist_id_art := TStringList.Create;
  hist_id_ubi := TStringList.Create;
  hist_imei := TStringList.Create;
  hist_id_cli := TStringList.Create;
  hist_lote := TStringList.Create;
  hist_id_lote := TStringList.Create;
  hist_cad_lote := TStringList.Create;

  ds1.First;

  art_ant := '-1';
  ubic_ant := '-1';
  stock := 0;
  n_linea := 0;
  mat1 := 0;
  mat2 := 0;
  cli_ant := -1;
  primer_insert := True;
  lote_ant := '1';
  cad_lote_ant := '01011000';  //ddmmyyyy  01.01.1000

  while not ds1.Eof do
  begin
    lb_1.Caption := 'Insertando ' + IntToStr(n_linea+1) + '/' + IntToStr(lineas_total) ;

    if ((ds1.FieldByName('codArt').AsString<>art_ant) or (ds1.FieldByName('codCli').AsInteger<>cli_ant)) then    //artículo diferente al actual
    begin
          //Comprobar si el artículo ya se ha creado durante esta importacion o ya existia

          a := 0;
          found_art := False;

          while (a<hist_arts.Count) and not found_art do
          begin
            If (ds1.FieldByName('CodArt').AsString=hist_arts[a]) then
            begin
              if (ds1.FieldByName('CodCli').AsString=hist_id_cli[a]) then
                  found_art := True
              else
                Inc(a);
            end
            else
              Inc(a);
          end;

          id_art:=busca_art_id(ds1.FieldByName('CodCli').AsString,ds1.FieldByName('CodArt').AsString);

          if (id_art=-1) and not found_art then begin                                //Crea articulo si no existe y no se ha creado previamente en este fichero

              with tpfibdataset.Create(frmMain) do begin
                database:=db;
                SQLs.SelectSQL.Clear;
                SQLs.SelectSQL.Add('SELECT GEN_ID(GEN_G_ARTICULOS_ID, 1) from RDB$DATABASE');
                Open;
                id_art:=FieldByName('gen_id').AsInteger;
                Free;
              end;

              q_1.Close;
              q_1.sql.Clear;
              q_1.SQL.Add('insert into g_articulos (id_articulo,CODIGO,NOMBRE,ID_CLIENTE,id_familia,kgs,kgsvol,largo,ancho,alto,cubic,uni_embalaje,codigo_cli,nom_cli, precio) values '+
                          '(:id_articulo,:CODIGO,:NOMBRE,:ID_CLIENTE,:id_familia,:kgs,:kgsvol,:largo,:ancho,:alto,:cubic,:uni_embalaje,:codigo_cli,:nom_cli, :precio)');
              q_1.ParamByName('id_articulo').AsInteger  :=id_art;
              q_1.ParamByName('codigo').asstring        := ds1.FieldByName('CodArt').AsString;
              q_1.ParamByName('nombre').asstring        := ds1.FieldByName('NomArt').AsString;
              q_1.ParamByName('id_cliente').AsInteger   := ds1.FieldByName('CodCli').AsInteger;
              q_1.ParamByName('id_familia').AsInteger   := ds1.FieldByName('Fam').AsInteger;
              q_1.ParamByName('kgs').asfloat            := ds1.FieldByName('Peso').AsFloat;
              q_1.ParamByName('kgsvol').asfloat         := ds1.FieldByName('KgsVol').AsFloat;
              q_1.ParamByName('largo').asfloat          := ds1.FieldByName('Largo').AsFloat;
              q_1.ParamByName('ancho').asfloat          := ds1.FieldByName('Ancho').AsFloat;
              q_1.ParamByName('alto').asfloat           := ds1.FieldByName('Alto').AsFloat;
              q_1.ParamByName('cubic').asfloat          := ds1.FieldByName('Cubic').AsFloat;
              q_1.ParamByName('uni_embalaje').AsInteger := ds1.FieldByName('UdsEmb').AsInteger;
              q_1.ParamByName('codigo_cli').asstring    := ds1.FieldByName('RefCli').AsString;
              q_1.ParamByName('nom_cli').asstring       := ds1.FieldByName('NomCliArt').AsString;
              q_1.ParamByName('precio').asfloat         := ds1.FieldByName('Precio').AsFloat;
              q_1.ExecQuery;

              if (ds1.FieldByName('BC').AsString<>'') then begin
                q_1.Close;
                q_1.sql.Clear;
                q_1.SQL.Add('insert into g_articulos_bc (id_articulo,bc) values '+
                            '(:id_articulo,:bc)');
                q_1.ParamByName('id_articulo').AsInteger:=id_art;
                q_1.ParamByName('bc').asstring:=ds1.FieldByName('BC').AsString;
                q_1.ExecQuery;
              end;

          end else if ((id_art>=0) and chArticulo.Checked) then
                   begin
                      q_1.Close;
                      q_1.sql.Clear;
                      q_1.SQL.Add('update g_articulos set ' +
                                  'NOMBRE=:NOMBRE,ID_CLIENTE=:ID_CLIENTE,id_familia=:id_familia,kgs=:kgs,kgsvol=:kgsvol, ' +
                                  'largo=:largo,ancho=:ancho,alto=:alto,cubic=:cubic,uni_embalaje=:uni_embalaje, ' +
                                  'codigo_cli=:codigo_cli,nom_cli=:nom_cli,precio=:precio '+
                                  'where id_articulo=:id_articulo');
                      q_1.ParamByName('id_articulo').AsInteger  := id_art;
                      q_1.ParamByName('nombre').asstring        := ds1.FieldByName('NomArt').AsString;
                      q_1.ParamByName('id_cliente').AsInteger   := ds1.FieldByName('CodCli').AsInteger;
                      q_1.ParamByName('id_familia').AsInteger   := ds1.FieldByName('Fam').AsInteger;
                      q_1.ParamByName('kgs').asfloat            := ds1.FieldByName('Peso').AsFloat;
                      q_1.ParamByName('kgsvol').asfloat         := ds1.FieldByName('KgsVol').AsFloat;
                      q_1.ParamByName('largo').asfloat          := ds1.FieldByName('Largo').AsFloat;
                      q_1.ParamByName('ancho').asfloat          := ds1.FieldByName('Ancho').AsFloat;
                      q_1.ParamByName('alto').asfloat           := ds1.FieldByName('Alto').AsFloat;
                      q_1.ParamByName('cubic').asfloat          := ds1.FieldByName('Cubic').AsFloat;
                      q_1.ParamByName('uni_embalaje').AsInteger := ds1.FieldByName('UdsEmb').AsInteger;
                      q_1.ParamByName('codigo_cli').asstring    := ds1.FieldByName('RefCli').AsString;
                      q_1.ParamByName('nom_cli').asstring       := ds1.FieldByName('NomCliArt').AsString;
                      q_1.ParamByName('precio').asfloat         := ds1.FieldByName('Precio').AsFloat;
                      q_1.ExecQuery;
                   end;

          if not found_art then
          begin
            hist_arts.Add(ds1.FieldByName('CodArt').AsString);
            hist_id_art.Add(IntToStr(id_art));
            hist_id_cli.Add(IntToStr(ds1.FieldByName('CodCli').AsInteger));
          end else if id_art=-1 then
                        id_art := StrToInt(hist_id_art[a]);
    end;

    if (ds1.FieldByName('IdAlm').AsString      + '|' +
                ds1.FieldByName('Estanteria').AsString + '|' +
                ds1.FieldByName('Posicion').AsString   + '|' +
                ds1.FieldByName('Altura').AsString     + '|' +
                ds1.FieldByName('Sub1').AsString)
                <>ubic_ant then                                    //ubicación diferente a la actual
    begin
     //Comprobar si la ubic ya se ha creado o ya existía

          u := 0;
          found_ubic := False;
          while (u<hist_ubic.Count) and not found_ubic do
          begin
            If (ds1.FieldByName('IdAlm').AsString      + '|' +
                ds1.FieldByName('Estanteria').AsString + '|' +
                ds1.FieldByName('Posicion').AsString   + '|' +
                ds1.FieldByName('Altura').AsString     + '|' +
                ds1.FieldByName('Sub1').AsString
                =hist_ubic[u]) then
                found_ubic := True
            else
                Inc(u);
          end;

            id_ubic:=busca_ubic(ds1.FieldByName('Estanteria').AsString,
                                ds1.FieldByName('IdAlm').AsInteger,
                                ds1.FieldByName('Posicion').AsInteger,
                                ds1.FieldByName('Altura').AsInteger,
                                ds1.FieldByName('Sub1').AsString,0);

            if (id_ubic=-1) and not found_ubic then begin
              //Crea ubicacion si no existe
              with tpfibdataset.Create(frmMain) do
              begin
                database := db;
                SQLs.SelectSQL.Clear;
                SQLs.SelectSQL.Add('SELECT GEN_ID(GEN_A_UBICACIONES_ID, 1) from RDB$DATABASE');
                Open;
                id_ubic := FieldByName('gen_id').AsInteger;
                Free;
              end;

              q_1.Close;
              q_1.SQL.Clear;
              q_1.SQL.Add('insert into a_ubicaciones(ID_UBICACION,ID_ALMACEN,ID_ESTANTERIA,ID_POSICION, ' +
                          'ID_ALTURA,ID_SUB1, ID_SUB2) VALUES ' + ' (:ID_UBICACION,:ID_ALMACEN,:ID_ESTANTERIA, ' +
                          ':ID_POSICION,:ID_ALTURA,:ID_SUB1, :ID_SUB2)');
              q_1.ParamByName('ID_UBICACION').AsInteger := id_ubic;
              q_1.ParamByName('ID_ALMACEN').AsInteger   := ds1.FieldByName('IdAlm').AsInteger;
              q_1.ParamByName('ID_ESTANTERIA').asstring := ds1.FieldByName('Estanteria').AsString;
              q_1.ParamByName('ID_POSICION').AsInteger  := ds1.FieldByName('Posicion').AsInteger;
              q_1.ParamByName('ID_ALTURA').AsInteger    := ds1.FieldByName('Altura').AsInteger;
              q_1.ParamByName('ID_SUB1').asstring       := ds1.FieldByName('Sub1').AsString;
              q_1.ParamByName('ID_SUB2').asstring       := ds1.FieldByName('Sub2').AsString;
              q_1.ExecQuery;
            end;

            if not found_ubic then
            begin
                hist_ubic.Add(ds1.FieldByName('IdAlm').AsString      + '|' +
                              ds1.FieldByName('Estanteria').AsString + '|' +
                              ds1.FieldByName('Posicion').AsString   + '|' +
                              ds1.FieldByName('Altura').AsString     + '|' +
                              ds1.FieldByName('Sub1').AsString);
                hist_id_ubi.Add(IntToStr(id_ubic));
            end else if id_ubic=-1 then
                           id_ubic := StrToInt(hist_id_ubi[u]);
     end;

     a := 0;
     found_imei := False;

     while (a<hist_imei.Count) and not found_imei do
     begin
       If (ds1.FieldByName('imei').AsString=hist_imei[a]) then
        found_imei := True
       else
        Inc(a);
     end;


     if (ds1.FieldByName('lote').AsString<>'') and
        ((ds1.FieldByName('lote').AsString<>lote_ant) or
        (FormatDateTime('ddmmyyyy',ds1.FieldByName('cad_lote').AsDateTime)<>cad_lote_ant)) then                                    //lote diferente a la actual
    begin
     //Comprobar si el lote ya se ha creado o ya existía
          u := 0;
          found_lote := False;
          while (u<hist_lote.Count) and not found_lote do
          begin
            If ((ds1.FieldByName('lote').AsString=hist_lote[u]) and
               (ds1.FieldByName('cad_lote').AsString=hist_cad_lote[u]))
            then
                found_lote := True
            else
                Inc(u);
          end;

            id_lote:=busca_lote(ds1.FieldByName('lote').AsString,ds1.FieldByName('cad_lote').AsDateTime);

            if (id_lote=-1) and not found_lote then begin
              //Crea ubicacion si no existe
              with tpfibdataset.Create(frmMain) do
              begin
                database := db;
                SQLs.SelectSQL.Clear;
                SQLs.SelectSQL.Add('SELECT GEN_ID(GEN_A_LOTES_ID, 1) from RDB$DATABASE');
                Open;
                id_lote := FieldByName('gen_id').AsInteger;
                Free;
              end;

              InsertLote(ds1.FieldByName('lote').AsString,id_lote,ds1.FieldByName('cad_lote').AsDateTime);

            end;

            if not found_lote then
            begin
                hist_lote.Add(ds1.FieldByName('lote').AsString);
                hist_cad_lote.Add(FormatDateTime('yyyymmdd',ds1.FieldByName('cad_lote').AsDateTime));
                hist_id_lote.Add(IntToStr(id_ubic));
            end else if id_lote=-1 then
                           id_lote := StrToInt(hist_id_lote[u]);
     end;

     if (ds1.FieldByName('lote').AsString='') then
        id_lote := 1;

     stock := ds1.FieldByName('Uds').AsInteger;
     imei  := ds1.FieldByName('imei').AsString;
     linea := ds1.FieldByName('linea').AsInteger;
     caducidad := ds1.FieldByName('caducidad').AsDateTime;
     id_alm := ds1.FieldByName('IdAlm').AsInteger;
     lineas[n_linea].linea := linea;
     lineas[n_linea].art   := id_art;
     lineas[n_linea].alm   := id_alm;
     lineas[n_linea].ubi   := id_ubic;
     lineas[n_linea].imei  := imei;
     lineas[n_linea].stock := stock;
     lineas[n_linea].cad   := caducidad;
     if id_lote>0 then
        lineas[n_linea].lote := id_lote
     else
        lineas[n_linea].lote := 1;
     lineas[n_linea].albCl := ds1.FieldByName('alb_cliente').AsString;

     hoja.Cells[ds1.FieldByName('linea').AsInteger,30] := id_ubic;
     hoja.Cells[ds1.FieldByName('linea').AsInteger,31] := id_art;
     hoja.Cells[ds1.FieldByName('linea').AsInteger,33] := id_lote;

     //ds1.Next;

     if (   (ds1.FieldByName('CodArt').AsString<>art_ant)
          or
            ((ds1.FieldByName('IdAlm').AsString      + '|' +
              ds1.FieldByName('Estanteria').AsString + '|' +
              ds1.FieldByName('Posicion').AsString   + '|' +
              ds1.FieldByName('Altura').AsString     + '|' +
              ds1.FieldByName('Sub1').AsString)<>ubic_ant)
          or
            (cli_ant<>ds1.FieldByName('codCli').AsInteger)
          or
            ((ds1.FieldByName('lote').AsString<>'') and (ds1.FieldByName('lote').AsString<>lote_ant))
        ) then
     begin


        //lineas[n_linea].mat   := id_mat;

           with tpfibdataset.Create(frmMain) do begin                       //Nueva matricula
          database:=db;
          SQLs.SelectSQL.Clear;
          SQLs.SelectSQL.Add('SELECT GEN_ID(GEN_A_MATRICULAS_ID, 1) from RDB$DATABASE');
          Open;

          id_mat:=FieldByName('gen_id').AsInteger;

          {if linea = fila_ini then
              lineas[n_linea].mat   := id_mat;   }

          Free;
        end;

       // if primer_insert then
            lineas[n_linea].mat   := id_mat;

        primer_insert := False;

     end else
            lineas[n_linea].mat   := id_mat;

     hoja.Cells[linea,32] := id_mat;
     Inc(n_linea);

     art_ant := ds1.FieldByName('CodArt').AsString;
     cli_ant := ds1.FieldByName('codCli').AsInteger;
     ubic_ant := ds1.FieldByName('IdAlm').AsString      + '|' +
                         ds1.FieldByName('Estanteria').AsString + '|' +
                         ds1.FieldByName('Posicion').AsString   + '|' +
                         ds1.FieldByName('Altura').AsString     + '|' +
                         ds1.FieldByName('Sub1').AsString;
     lote_ant := ds1.FieldByName('lote').AsString;
     cad_lote_ant := FormatDateTime('ddmmyyyy',ds1.FieldByName('cad_lote').AsDateTime);
     ds1.Next;
  end;

  mat_ant := lineas[0].mat;
  stock := 0;

  for i := 0 to High(lineas) do
  begin
    if lineas[i].linea>0 then
    begin
      if lineas[i].mat<>mat_ant then
      begin
          InsertMatricula(lineas[i-1].art, lineas[i-1].mat, lineas[i-1].alm, stock,lineas[i-1].lote, lineas[i-1].albCl);
          InsertStock(lineas[i-1].ubi, lineas[i-1].art, lineas[i-1].mat, lineas[i-1].alm, stock,lineas[i-1].lote);
          stock := lineas[i].stock;
          mat_ant := lineas[i].mat;

          if i=0 then mat1:=id_mat;
      end
      else
          stock := stock + lineas[i].stock;
    end;
  end;

  //Insertar la última mat y stock
  mat2 := lineas[i-1].mat;
  InsertMatricula(lineas[i-1].art, lineas[i-1].mat, lineas[i-1].alm, stock,lineas[i-1].lote,lineas[i-1].albCl);
  InsertStock(lineas[i-1].ubi, lineas[i-1].art, lineas[i-1].mat, lineas[i-1].alm, stock,lineas[i-1].lote);
  hoja.Cells[lineas[i-1].linea,32] := lineas[i-1].mat;

  for i := 0 to High(lineas) do
      if (lineas[i].linea>0) and (lineas[i].imei<>'') then
           InsertIMEI(lineas[i].imei,lineas[i].mat,lineas[i].cad);

  hist_arts.Free;
  hist_ubic.Free;
  hist_imei.Free;
  hist_id_art.Free;
  hist_id_ubi.Free;
  hist_id_cli.Free;
  hist_lote.Free;
  hist_id_lote.Free;
  hist_cad_lote.Free;
end;


procedure TfrmMain.InsertMatricula(id_art, id_mat, id_alm, stock, id_lote: Integer; albCl:string);
begin
  q_1.Close;
  q_1.sql.Clear;
  q_1.sql.Add('insert into a_matriculas (id_matricula,id_articulo,uds_ini,tipo,alb_cliente,observaciones, id_almacen, id_lote) ' +
  ' values (:id_matricula,:id_articulo,:uds_ini,:tipo,:alb_cliente,:observaciones, :id_almacen, :id_lote)');
  q_1.ParamByName('id_matricula').AsInteger := id_mat;
  q_1.ParamByName('id_articulo').AsInteger := id_art;
  q_1.ParamByName('uds_ini').AsInteger := stock;
  q_1.ParamByName('tipo').asstring := 'E';
  q_1.ParamByName('alb_cliente').asstring := albCl;
  q_1.ParamByName('observaciones').Asstring := 'Entrada Automática';
  q_1.ParamByName('id_almacen').AsInteger := id_alm;
  q_1.ParamByName('id_lote').AsInteger := id_lote;
  q_1.ExecQuery;
end;

 procedure TfrmMain.InsertStock(id_ubic,id_art,id_mat, id_alm, stock, id_lote: Integer);
begin
  q_1.Close;
  q_1.SQL.Clear;
  q_1.SQL.Add('insert into a_stock (ID_ALMACEN,ID_UBICACION,ID_ARTICULO,ID_MATRICULA,ID_LOTE,CANTIDAD,ID_EMPRESA) VALUES ' +
              '(:ID_ALMACEN,:ID_UBICACION,:ID_ARTICULO,:ID_MATRICULA,:id_lote,:ctdad,1)');
  q_1.ParamByName('id_almacen').AsInteger := id_alm;
  q_1.ParamByName('id_ubicacion').AsInteger := id_ubic;
  q_1.ParamByName('id_articulo').AsInteger := id_art;
  q_1.ParamByName('id_matricula').AsInteger := id_mat;
  q_1.ParamByName('id_lote').AsInteger := id_lote;
  q_1.ParamByName('ctdad').AsInteger := stock;
  q_1.ExecQuery;
end;

procedure TfrmMain.InsertIMEI(imei: string; id_mat: Integer; cad:  TDate);
begin
  q_1.Close;
  q_1.sql.Clear;
  q_1.sql.Add('insert into a_imeis (id_matricula,imei,caducidad) ' +
              ' values (:id_matricula,:imei,:caducidad)');
  q_1.ParamByName('id_matricula').AsInteger := id_mat;
  q_1.ParamByName('imei').asstring := imei;
  q_1.ParamByName('caducidad').AsDate := cad;
  q_1.ExecQuery;
end;

function TfrmMain.busca_lote(lote:string; caducidad:TDate):integer;
begin                                       //devuelve id_ubicacion,   existe=id_ubicacion     no existe=-1
  with tpfibdataset.Create(frmMain) do begin
    database:=frmMain.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select id_lote from a_lotes where '+
            'estado=''A'' and nombre=:nombre and caducidad=:caducidad');
    ParamByName('nombre').AsString := lote;
    ParamByName('caducidad').AsDate := caducidad;
    Open;
    if not(IsEmpty) then Result:=FieldByName('id_lote').AsInteger
      else Result:=-1;
    Free;
  end;
end;

procedure TfrmMain.InsertLote(lote: string; id_lote: Integer; cad:  TDate);
begin
  q_1.Close;
  q_1.sql.Clear;
  q_1.sql.Add('insert into a_lotes(id_lote,nombre,caducidad) ' + ' values (:id_lote,:lote,:caducidad)');
  q_1.ParamByName('id_lote').AsInteger := id_lote;
  q_1.ParamByName('lote').asstring := lote;
  q_1.ParamByName('caducidad').AsDate := cad;
  q_1.ExecQuery;
end;


procedure TfrmMain.leer_ini_red;
var ini:tinifile;
begin

  if FileExists(ruta_ini_red) then
  begin
    ini:=TIniFile.Create(ruta_ini_red);
  try
    ruta_db:=ini.readstring('Datos','dbname','');

  finally
    ini.free;
  end;
  end;

end;

function TfrmMain.existe_almacen(id_almacen:integer):Boolean;
begin                                       //devuelve id_ubicacion,   existe=id_ubicacion     no existe=-1
  with tpfibdataset.Create(frmMain) do begin
    database:=frmMain.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select id_almacen from a_almacenes where '+
                       'id_almacen=:id_almacen');
    ParamByName('id_almacen').AsInteger := id_almacen;
    Open;

    Result := not (IsEmpty);

    Free;
  end;
end;

end.
