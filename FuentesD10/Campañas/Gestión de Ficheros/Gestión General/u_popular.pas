unit u_popular;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes,midaslib,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, sSkinProvider, sSkinManager, sGroupBox, inifiles,jpeg,
  JvDBGrid, Vcl.StdCtrls, sTooledit, sEdit, sBitBtn, sLabel,
  sGauge, sPanel, sdialogs,strutils,types,System.DateUtils,
  Data.DB, pfibdataset, sRadioButton,registry, sCheckBox, System.Variants,
  frxClass, frxDBSet, Datasnap.DBClient, sSpeedButton, Vcl.Buttons,
  Vcl.Mask, sMaskEdit, sCustomComboEdit, Vcl.Grids, Vcl.DBGrids, JvExDBGrids,
  Vcl.ExtCtrls,frxBarcode,printers,Winapi.WinSpool;

type
  Tstock = record
    id_art:Integer;
    uds:Integer;
  end;
  Tfichero = record
    id_art:integer;
    coddel:Integer;
    uds:Integer;
    indiv:string;
  end;


    procedure rg_stateClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bt_generaClick(Sender: TObject);
    function busca_art(codigo:string):integer;
    procedure limpiar_stock;
    procedure get_stock;
    function verif_stock(pedido:Integer):boolean;
    procedure descuenta_stock(pedido:Integer);
    function ruta_escritorio:string;
    function genera_picking:integer;
    procedure bt_anularClick(Sender: TObject);
    procedure ed_search_orderClick(Sender: TObject);
    function verif_stock_x_art(id_art,uds:Integer):boolean;
    function busca_art_x_id(id_articulo:integer):string;
    function SiguienteLaboral(fecha:tdate):TDate;
    procedure bt_packingClick(Sender: TObject);
    procedure bt_searchClick(Sender: TObject);
    function busca_art_nom(codigo:string):string;
    procedure ed_artExit(Sender: TObject);
    procedure sb_art1Click(Sender: TObject);
    procedure limpiar_fichero;
    procedure add_fichero(id_art,uds,coddel:Integer; indiv:string);
    procedure ordena_fichero;
    function normaliza_ref_art(ref_art:string):string;
    procedure get_art_data(ref_art:string; var codigo,nombre:string; var id_articulo:Integer; id_cliente:Integer);
    function get_delegacion_data(codcli,coddel:integer):string;
    procedure print_indiv;
    function charEti(s: string): string;
    function WriteRawDataToPrinter(PrinterName: String; Str: String): Boolean;
    procedure bt_printClick(Sender: TObject);
    procedure leer_ini;
    procedure importa_fichero_popular(file_source:string);
    procedure text_to_fr(fr:tfrxreport; memo_name,text:string);


var

  ar_stock:array of Tstock;                    //stock
  idx_stock:Integer=0;

  ar_fichero:array of TFichero;                //fichero para cargar
  idx_fichero:Integer=0;

  imp_eti,imp_eti2:string;

implementation

uses u_dm, u_detail, ubuscapro, u_globals;

{$REGION 'Filters Importar'}
procedure Tf_main.rg_stateClick(Sender: TObject);                        //CAMBIA RADIOGROUP ESTADOS DE VISUALIZACION
begin
 //////////////filter;
end;

procedure Tf_main.ed_artExit(Sender: TObject);
var s:string;
begin
  if ed_art.Text<>'' then begin
    s:=busca_art_nom(ed_art.Text);
    if s<>'' then lb_art1.caption:=s
      else lb_art1.Caption:='No Encontrado';
  end else lb_art1.Caption:='Tipo Erróneo';
end;

procedure Tf_main.sb_art1Click(Sender: TObject);
begin
  with fbuscapro do begin
    limpia_fields;     multiselect:=false;    livekey:=false;
    fields.commatext:='a.id_articulo,a.codigo,a.nombre,a.codigo_cli';
    titulos.commatext:='Artículo,Referencia,Nombre,SKU';
    from:='g_articulos a ';
    where:='a.id_cliente=3159 and a.estado<''B''';
    orden[1]:=2;  busca:=3;   distinct:=0;   fillimpio:=True;

    showmodal;

    if resultado then begin
      with Sender as TsSpeedButton do begin
        ed_art.text:=valor[2];
        lb_art1.caption:=valor[3];
      end;
    end;
  end;

  //////////////if cb_articulo.Checked then filter;
end;



procedure Tf_main.bt_searchClick(Sender: TObject);
begin
  ///////////////f_informes.ShowModal;
end;

{$ENDREGION}

{$REGION 'Importar'}
procedure importa_fichero_popular(file_source:string);
var   fichero:tstringlist;      i,coddel,uds,id_art,old_coddel,id_popular,id_line,n:integer;           str_dyn:TStringDynArray;    ref_art,indiv,cod_art,nom_art:string;
begin
  if not fileexists(fichero) then raise exception.create('No existe el fichero ' + fichero);

  application.ProcessMessages;

  fichero:=tstringlist.Create;
  limpiar_fichero;
  n:=0;

  try
    fichero.LoadFromFile(file_source);
    for i:=0 to fichero.Count-1 do begin
      str_dyn:=splitstring(fichero[i],';');

      ref_art:=str_dyn[0];
      coddel:=StrToInt(str_dyn[1]);
      uds:=StrToInt(Trim(str_dyn[2]));
      if High(str_dyn)=3 then indiv:=str_dyn[3]
        else indiv:='';

      ref_art:=normaliza_ref_art(ref_art);

      get_art_data(ref_art,cod_art,nom_art,id_art,3159);
      if id_art=-1 then raise exception.Create('Error en linea '+inttostr(i+1)+', Artículo '+ref_art+' No Encontrado');

      if get_delegacion_data(3159,coddel)='ERR' then raise exception.Create('Error en linea '+inttostr(i+1)+', Delegación '+inttostr(coddel)+' No Encontrada');

      add_fichero(id_art,uds,coddel,indiv);
    end;
  finally
    FreeAndNil(fichero);
  end;

  ordena_fichero;

  dm.t_write.StartTransaction;
  try

    old_coddel:=9999999;                     //impossible value
    for i:= 0 to idx_fichero-1 do begin
      id_art:=ar_fichero[i].id_art;
      coddel:=ar_fichero[i].coddel;
      uds:=ar_fichero[i].uds;
      indiv:=ar_fichero[i].indiv;

      if coddel<>old_coddel then begin          //new pedido

        id_line:=1;
        Inc(n);

        with TpFIBDataSet.Create(dm) do
        try
          Database:=dm.db;
          sqls.SelectSQL.Add('SELECT GEN_ID(GEN_C_PEDIDOS_ID,1) FROM RDB$DATABASE');
          Open;
          id_popular:=FieldByName('gen_id').AsInteger;
        finally
          free;
        end;

        dm.q_1.Close;
        dm.q_1.sql.Clear;
        dm.q_1.sql.Add('insert into c_pedidos_popular '+
          '(id_popular,oficina, nombre, dir, poblacion, provincia, cp, fecha_ped, estado) '+
          'values (:id_popular,:oficina, :nombre, :dir, :poblacion, :provincia, :cp, :fecha_ped, :estado)');
        dm.q_1.ParamByName('id_popular').AsInteger:=id_popular;
        dm.q_1.ParamByName('oficina').asinteger:=coddel;

        dm.ds_1.Close;
        dm.ds_1.SelectSQL.Clear;
        dm.ds_1.SelectSQL.Add('select * from g_delegaciones where id_cliente=3159 and cod_delegacion=:cod_delegacion');
        dm.ds_1.ParamByName('cod_delegacion').AsInteger:=coddel;
        dm.ds_1.Open;

        if not(dm.ds_1.IsEmpty) then begin
          dm.q_1.ParamByName('nombre').asstring:=dm.ds_1.FieldByName('nombre').AsString;
          dm.q_1.ParamByName('dir').asstring:=dm.ds_1.FieldByName('direccion').AsString;
          dm.q_1.ParamByName('poblacion').asstring:=dm.ds_1.FieldByName('poblacion').AsString;
          dm.q_1.ParamByName('provincia').asstring:=dm.ds_1.FieldByName('provincia').AsString;
          dm.q_1.ParamByName('cp').asinteger:=dm.ds_1.FieldByName('cp').asinteger;
        end else begin
          dm.q_1.ParamByName('nombre').asstring:='NOT FOUND';
          dm.q_1.ParamByName('dir').asstring:='';
          dm.q_1.ParamByName('poblacion').asstring:='';
          dm.q_1.ParamByName('provincia').asstring:='';
          dm.q_1.ParamByName('cp').asinteger:=0;
        end;

        dm.q_1.ParamByName('fecha_ped').AsDateTime:=now;
        dm.q_1.ParamByName('estado').AsString:='P';
        dm.q_1.ExecQuery;

        old_coddel:=coddel;
      end;

      dm.q_1.Close;
      dm.q_1.sql.Clear;
      dm.q_1.sql.Add('insert into c_pedidos_popular_lines '+
        '(id_popular, id_line, id_articulo, cantidad, individual) '+
        'values (:id_popular, :id_line, :id_articulo, :cantidad, :individual)');
      dm.q_1.ParamByName('id_popular').AsInteger:=id_popular;
      dm.q_1.ParamByName('id_line').AsInteger:=id_line;
      dm.q_1.ParamByName('id_articulo').asinteger:=id_art;
      dm.q_1.ParamByName('cantidad').asinteger:=uds;
      dm.q_1.ParamByName('individual').asstring:=indiv;
      dm.q_1.ExecQuery;

      Inc(id_line);
    end;

    dm.t_write.CommitRetaining;
    sMessageDlg('Importación Finalizada, '+inttostr(n)+' Pedidos Importados',mtInformation,[mbok],0);
  except
    dm.t_write.RollbackRetaining;
  end;

  lb_st1.Caption:='Importación Finalizada, '+inttostr(n)+' Pedidos Importados';
  application.ProcessMessages;
  /////////////////filter;

end;
{$ENDREGION}

{$REGION 'Aux Importar'}
procedure Tf_main.limpiar_fichero;
begin
  idx_fichero:=0;
  setlength(ar_fichero,idx_fichero);
end;

procedure Tf_main.add_fichero(id_art,uds,coddel:Integer; indiv:string);
begin
    Inc(idx_fichero);                                                       //tal cual llega del fichero
    setlength(ar_fichero,idx_fichero);

    ar_fichero[idx_fichero-1].id_art:=id_art;
    ar_fichero[idx_fichero-1].coddel:=coddel;
    ar_fichero[idx_fichero-1].uds:=uds;
    ar_fichero[idx_fichero-1].indiv:=indiv;
end;

procedure Tf_main.ordena_fichero;           //Ordena fichero por delegacion
var  i,j:Integer;   tmp:Tfichero;      idx,idx_ini,old_del:Integer;
begin                                              //método burbujo
  for j:=0 to idx_fichero-2 do                          //ordena por delegación
    for i:=0 to idx_fichero-2 do
      if ar_fichero[i].coddel>ar_fichero[i+1].coddel then
      begin
        tmp:=ar_fichero[i];
        ar_fichero[i]:=ar_fichero[i+1];
        ar_fichero[i+1]:=tmp;
      end;

  idx_ini:=0;                                         //parte array en trozos por delegacion
  old_del:=ar_fichero[0].coddel;
  for idx:=0 to idx_fichero-1 do begin
    if old_del<>ar_fichero[idx].coddel then begin
      if idx-idx_ini>=2 then begin

        for j:=idx_ini to idx-2 do                                  //ordenar por id_art dentro de cada delegacion
          for i:=idx_ini to idx-2 do
            if ar_fichero[i].id_art>ar_fichero[i+1].id_art then
            begin
              tmp:=ar_fichero[i];
              ar_fichero[i]:=ar_fichero[i+1];
              ar_fichero[i+1]:=tmp;
            end;

      end;
      old_del:=ar_fichero[idx].coddel;
      idx_ini:=idx;
    end;
  end;
end;

function Tf_main.normaliza_ref_art(ref_art:string):string;     //quita 0's a la izquierda
var    s:string;   i:integer;  copia:Boolean;
begin
  copia:=false;
  s:='';
  for i:=1 to length(ref_art) do begin
    if copia then s:=s+ref_art[i]
      else if ref_art[i]<>'0' then begin
              s:=s+ref_art[i];
              copia:=True;
            end;
  end;
  result:=s;
end;

procedure Tf_main.get_art_data(ref_art:string; var codigo,nombre:string; var id_articulo:Integer; id_cliente:Integer);
begin
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select id_articulo,nombre,codigo from g_articulos where codigo_cli=:codigo_cli '+
      ' and id_cliente=:id_cliente ');
    ParamByName('codigo_cli').asstring:=ref_art;
    ParamByName('id_cliente').asinteger:=id_cliente;
    Open;

    if not(IsEmpty) then begin
      codigo:=FieldByName('codigo').AsString;
      nombre:=FieldByName('nombre').AsString;
      id_articulo:=FieldByName('id_articulo').Asinteger;
    end else begin
      codigo:='ERR';
      nombre:='Artículo No Encontrado';
      id_articulo:=-1;
    end;
    Free;
  end;
end;

function Tf_main.get_delegacion_data(codcli,coddel:integer):string;
begin
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select nombre from g_delegaciones where id_cliente=:id_cliente and cod_delegacion=:cod_delegacion');
    ParamByName('id_cliente').asinteger:=codcli;
    ParamByName('cod_delegacion').asinteger:=coddel;
    Open;

    if not(IsEmpty) then Result:=FieldByName('nombre').asstring
      else result:='ERR';
    Free;
  end;
end;
{$ENDREGION}

{$REGION 'Generar'}
procedure Tf_main.bt_generaClick(Sender: TObject);                //GENERA ENVIOS
var   id_pickcab:integer;
begin
  //*********************************************************************VERIFICA STOCK
  lb_st1.Caption:='Verificando Stock';
  application.ProcessMessages;

  get_stock;

  with TpFIBDataSet.Create(self) do
  try
    Database:=dm.db;
    sqls.SelectSQL.Add('select id_popular '+
      'from c_pedidos_popular '+
      'where estado in(''P'',''X'')');
    Open;

    first;
    while not(Eof) do begin
      if verif_stock(FieldByName('id_popular').asinteger) then begin                 //si tiene stock
        descuenta_stock(FieldByName('id_popular').asinteger);
        dm.t_write.StartTransaction;
        try
          dm.q_1.Close;
          dm.q_1.sql.Clear;
          dm.q_1.sql.Add('update c_pedidos_popular set estado=''P'' where id_popular=:id_popular');
          dm.q_1.ParamByName('id_popular').AsInteger:=FieldByName('id_popular').asinteger;
          dm.q_1.ExecQuery;
          dm.t_write.Commit;
        except
          dm.t_write.rollback;
        end;

      end else begin                                                   //no hay stock para este pedido
        dm.t_write.StartTransaction;
        try
          dm.q_1.Close;
          dm.q_1.sql.Clear;
          dm.q_1.sql.Add('update c_pedidos_popular set estado=''X'' where id_popular=:id_popular');
          dm.q_1.ParamByName('id_popular').AsInteger:=FieldByName('id_popular').asinteger;
          dm.q_1.ExecQuery;
          dm.t_write.Commit;
        except
          dm.t_write.rollback;
        end;
      end;
      next;
    end;
  finally
    free;
  end;

  lb_st1.Caption:='Generando Informe Sin Stock';
  application.ProcessMessages;

  ///////////////informe_sin_stock;

  //*******************************************************************PICKING
  lb_st1.Caption:='Generando Picking';
  application.ProcessMessages;

  id_pickcab:=genera_picking;

  //*******************************************************************ETIQUETAS INDIVIDUALES
  lb_st1.Caption:='Generando Etiq Individuales';
  application.ProcessMessages;

  print_indiv;

  //*******************************************************************MARCAR COMO GENERADOS
  dm.t_write.StartTransaction;
  try
    dm.q_1.Close;
    dm.q_1.sql.Clear;
    dm.q_1.sql.Add('update c_pedidos_popular set estado=''G'',fecha_gen=:f1 where estado=''P'' ');
    dm.q_1.ParamByName('f1').AsDateTime:=now;
    dm.q_1.ExecQuery;
    dm.t_write.Commit;
  except
    dm.t_write.rollback;
  end;

  //******************************************************************

  //////////////filter;

  sMessageDlg('Done!! Picking '+inttostr(id_pickcab),mtInformation,[mbok],0);
end;
{$ENDREGION}

{$REGION 'Aux'}
procedure Tf_main.leer_ini;
var ini:tinifile;  exe,ruta_exe,ruta_ini:string;
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
    imp_eti2:=ini.readstring('Datos','imp_eti2','');
  finally
    ini.free;
  end;
end;

procedure Tf_main.text_to_fr(fr:tfrxreport; memo_name,text:string);
var  memo: TfrxMemoView;
begin
  memo := fr.FindObject(memo_name) as TfrxMemoView;
  if Assigned(memo) then begin
    memo.Memo.Clear;
    memo.Memo.Add(text);
  end;
end;

function Tf_main.busca_art(codigo:string):integer;
begin                                       //devuelve id de articulo a partir de codigo
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select id_articulo from g_articulos where codigo=:codigo');
    ParambyName('codigo').asstring:=codigo;
    Open;

    if not(IsEmpty) then Result:=FieldByName('id_articulo').asinteger
    else result:=-1;

    Free;
  end;
end;

function Tf_main.busca_art_x_id(id_articulo:integer):string;
begin                                       //devuelve codigo de articulo a partir de id
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select codigo from g_articulos where id_articulo=:id_articulo');
    ParambyName('id_articulo').asinteger:=id_articulo;
    Open;

    if not(IsEmpty) then Result:=FieldByName('codigo').asstring
    else result:='ERR';

    Free;
  end;
end;

function Tf_main.busca_art_nom(codigo:string):string;
begin                                       //devuelve codigo de articulo a partir de id
  with tpfibdataset.Create(dm) do begin
    database:=dm.db;
    SQLs.SelectSQL.Clear;
    SQLs.SelectSQL.Add('select nombre from g_articulos where codigo=:codigo');
    ParambyName('codigo').asstring:=codigo;
    Open;

    if not(IsEmpty) then Result:=FieldByName('nombre').asstring
    else result:='';

    Free;
  end;
end;

function tf_main.ruta_escritorio:string;
var
  sEscritorio: String;
  Registro: TRegistry;
begin
  sEscritorio:='';
  Registro := TRegistry.Create;

  // Leemos la ruta del escritorio
  try
    Registro.RootKey := HKEY_CURRENT_USER;

    if Registro.OpenKey( '\Software\Microsoft\Windows\CurrentVersion\explorer\Shell Folders', True ) then
      sEscritorio := Registro.ReadString( 'Desktop' );
  finally
    Registro.CloseKey;
    Registro.Free;
  end;

  result:=sEscritorio;
end;

function Tf_main.SiguienteLaboral(fecha:tdate):TDate;
begin
  fecha:=incday(fecha);
  while ((DayOfWeek(fecha)=1) or (DayOfWeek(fecha)=7)) do fecha:=incday(fecha);
  Result:=fecha;
end;
{$ENDREGION}

{$REGION 'Verif Stock'}
procedure Tf_main.limpiar_stock;
begin
  idx_stock:=0;
  setlength(ar_stock,idx_stock);
end;

procedure Tf_main.get_stock;
begin
  limpiar_stock;

  with TpFIBDataSet.Create(self) do
  try
    Database:=dm.db;
    sqls.SelectSQL.Add('select s.id_articulo,sum(s.cantidad) as uds '+
      'from a_stock s '+
      'inner join g_articulos a on (s.id_articulo=a.id_articulo) '+
      'inner join a_ubicaciones u on (s.id_ubicacion=u.id_ubicacion) '+
      'where a.id_cliente=3159 and u.id_almacen=1 and u.id_zona=0 and u.id_ubicacion<>361 '+
      'group by s.id_articulo');
    Open;

    first;
    while not(Eof) do begin
      Inc(idx_stock);
      setlength(ar_stock,idx_stock);

      ar_stock[idx_stock-1].id_art:=FieldByName('id_articulo').asinteger;
      ar_stock[idx_stock-1].uds:=FieldByName('uds').asinteger;

      next;
    end;
  finally
    free;
  end;
end;

function Tf_main.verif_stock(pedido:Integer):boolean;
var    ok,enc:Boolean;    i:integer;
begin
  ok:=true;
  with TpFIBDataSet.Create(self) do
  try
    Database:=dm.db;
    sqls.SelectSQL.Add('select l.id_articulo,sum(l.cantidad) as uds '+
      'from c_pedidos_popular_lines l '+
      'where l.id_popular=:id_popular '+
      'group by l.id_articulo');
    parambyname('id_popular').AsInteger:=pedido;
    Open;

    first;
    while (not(Eof) and (ok)) do begin
      enc:=False;
      i:=0;
      while (not(enc) and (i<idx_stock)) do begin                                //se encuentra
        if (ar_stock[i].id_art=FieldByName('id_articulo').asinteger) then begin
          if ar_stock[i].uds<FieldByName('uds').asinteger then ok:=false;
          enc:=True;
        end;
        Inc(i);
      end;
      if not(enc) then ok:=false;        //art no encontrado

      next;
    end;
  finally
    free;
  end;

  result:=ok;
end;

function Tf_main.verif_stock_x_art(id_art,uds:Integer):boolean;     //true=si hay stock   false=no hay stock
var   enc:Boolean;    i:integer;
begin
  Result:=true;

  enc:=False;
  i:=0;
  while (not(enc) and (i<idx_stock)) do begin                                //se encuentra
    if (ar_stock[i].id_art=id_art) then begin
      if ar_stock[i].uds<uds then result:=false;
      enc:=True;
    end;
    Inc(i);
  end;
  if not(enc) then result:=false;        //art no encontrado
end;

procedure Tf_main.descuenta_stock(pedido:Integer);
var    enc:Boolean;    i:integer;
begin
  with TpFIBDataSet.Create(self) do
  try
    Database:=dm.db;
    sqls.SelectSQL.Add('select l.id_articulo,sum(l.cantidad) as uds '+
      'from c_pedidos_popular_lines l '+
      'where l.id_popular=:id_popular '+
      'group by l.id_articulo');
    parambyname('id_popular').AsInteger:=pedido;
    Open;

    first;
    while not(Eof) do begin
      enc:=False;
      i:=0;
      while (not(enc) and (i<idx_stock)) do begin                                //se encuentra
        if (ar_stock[i].id_art=FieldByName('id_articulo').asinteger) then begin
          ar_stock[i].uds := ar_stock[i].uds - FieldByName('uds').asinteger;
          enc:=True;
        end;
        Inc(i);
      end;

      next;
    end;
  finally
    free;
  end;
end;

{$ENDREGION}

{$REGION 'Picking'}
function Tf_main.genera_picking:integer;
var   pick_cab,id_articulo,id_ubicacion:integer;   nom_pick,old_order_name,filename,ubicacion_name:string;  linea:Integer;
begin
  ar_pick_ds.Close;
  ar_pick_ds.Active:=true;
  ar_pick_ds.EmptyDataSet;

  linea:=1;
  dm.t_write.StartTransaction;
  try
    dm.ds_1.Close;                                                            //id cabecera
    dm.ds_1.SQLs.SelectSQL.Clear;
    dm.ds_1.SQLs.SelectSQL.Add('SELECT GEN_ID(gen_a_pickcab_id,1) FROM RDB$DATABASE');
    dm.ds_1.Open;

    pick_cab:=dm.ds_1.FieldByName('gen_id').AsInteger;


    dm.q_1.Close;                                                                   //genera cabecera
    dm.q_1.SQL.Clear;
    dm.q_1.SQL.Add('insert into a_pickcab (ID_PICKCAB,ID_DOC,ID_CLIENTE,NOMBRE,FECHA,HORA,ID_USUARIO,ID_EMPRESA,ESTADO) '+
      ' values (:ID_PICKCAB,:ID_DOC,:ID_CLIENTE,:NOMBRE,:FECHA,:HORA,:ID_USUARIO,:ID_EMPRESA,:ESTADO)');
    dm.q_1.ParamByName('id_pickcab').AsInteger:=pick_cab;
    dm.q_1.ParamByName('id_doc').AsInteger:=1;
    dm.q_1.ParamByName('id_cliente').AsInteger:=3159;
    nom_pick:='Pick Caixa Popular 3159-'+formatdatetime('dd/mm/yy',date);
    dm.q_1.ParamByName('nombre').asstring:=nom_pick;
    dm.q_1.ParamByName('fecha').asdate:=date;
    dm.q_1.ParamByName('hora').astime:=time;
    dm.q_1.ParamByName('id_usuario').AsInteger:=1;
    dm.q_1.ParamByName('id_empresa').AsInteger:=1;
    dm.q_1.ParamByName('estado').asstring:='A';
    dm.q_1.ExecQuery;
    dm.t_write.CommitRetaining;

    dm.ds_2.close;                                                 //recoge picking
    dm.ds_2.SelectSQL.clear;
    dm.ds_2.SelectSQL.Add('select c.id_popular,l.id_articulo,a.codigo,a.nombre,sum(l.cantidad) as uds '+
      'from c_pedidos_popular c '+
      'inner join c_pedidos_popular_lines l on (c.id_popular=l.id_popular) '+
      'inner join g_Articulos a on (l.id_articulo=a.id_articulo) '+
      'where c.estado=''P'' '+
      'group by c.id_popular,l.id_articulo,a.codigo,a.nombre');
    dm.ds_2.Open;

    while not(dm.ds_2.Eof) do begin           //para cada pedido
      id_articulo:=dm.ds_2.FieldByName('id_articulo').asinteger;

      dm.q_1.Close;
      dm.q_1.SQL.Clear;
      dm.q_1.SQL.Add('insert into a_picklin (ID_PICKCAB,ID_AGRUPA,NIVEL_AGR,LINEA,ID_RUTA,ID_ARTICULO,ID_UBICACION,CANTIDAD,ID_EMPRESA,ESTADO,CODALBARAN,CODMOVIMIENTO,SULINEA) '+
        ' values (:ID_PICKCAB,:ID_AGRUPA,:NIVEL_AGR,:LINEA,:ID_RUTA,:ID_ARTICULO,:ID_UBICACION,:CANTIDAD,:ID_EMPRESA,:ESTADO,:CODALBARAN,:CODMOVIMIENTO,:SULINEA)');
      dm.q_1.ParamByName('id_pickcab').AsInteger:=pick_cab;
      dm.q_1.ParamByName('id_agrupa').AsInteger:=0;
      dm.q_1.ParamByName('nivel_agr').AsInteger:=1;

      dm.q_1.ParamByName('linea').AsInteger:=linea;
      Inc(linea);
      dm.q_1.ParamByName('id_ruta').AsInteger:=0;
      dm.q_1.ParamByName('id_articulo').AsInteger:=id_articulo;

      dm.ds_1.Close;                                                            //ubicacion de picking
      dm.ds_1.SQLs.SelectSQL.Clear;
      dm.ds_1.SQLs.SelectSQL.Add('SELECT u.id_ubicacion,u.id_estanteria,u.id_posicion,u.id_altura,u.id_sub1,u.id_sub2 '+
        ' from a_stock s '+
        '   inner join a_ubicaciones u on (s.id_ubicacion=u.id_ubicacion) '+
        ' where s.id_articulo='+inttostr(id_articulo)+' and s.cantidad>0 and u.id_zona=0 and s.id_ubicacion<>361 and s.id_empresa=1 and s.id_almacen=1 '+
        ' order by 4,2,3');
      dm.ds_1.Open;

      id_ubicacion:=dm.ds_1.FieldByName('id_ubicacion').asinteger;
      ubicacion_name:=dm.ds_1.FieldByName('id_estanteria').asstring+'-'+dm.ds_1.FieldByName('id_posicion').asstring+'-'+dm.ds_1.FieldByName('id_altura').asstring
        +'-'+dm.ds_1.FieldByName('id_sub1').asstring;
      dm.q_1.ParamByName('id_ubicacion').AsInteger:=id_ubicacion;
      dm.q_1.ParamByName('cantidad').AsInteger:=dm.ds_2.FieldByName('uds').asinteger;
      dm.q_1.ParamByName('id_empresa').AsInteger:=1;
      dm.q_1.ParamByName('estado').asstring:='A';
      dm.q_1.ParamByName('codalbaran').AsInteger:=0;
      dm.q_1.ParamByName('codmovimiento').AsInteger:=0;
      dm.q_1.ParamByName('sulinea').AsString:='';
      dm.q_1.ExecQuery;



      ar_pick_ds.insert;
      ar_pick_ds.FieldByName('id_art').AsInteger:=id_articulo;
      ar_pick_ds.FieldByName('ref_art').AsString:=dm.ds_2.FieldByName('codigo').AsString;
      ar_pick_ds.FieldByName('uds').Asinteger:=dm.ds_2.FieldByName('uds').asinteger;
      ar_pick_ds.FieldByName('id_ubic').Asinteger:=id_ubicacion;
      ar_pick_ds.FieldByName('ubicacion').Asstring:=ubicacion_name;
      ar_pick_ds.FieldByName('articulo').Asstring:=dm.ds_2.FieldByName('nombre').AsString;

      dm.ds_1.Close;                                                            //datos de cabecera (es una burrada hacerlo por linea)
      dm.ds_1.SQLs.SelectSQL.Clear;
      dm.ds_1.SQLs.SelectSQL.Add('SELECT * '+
        ' from c_pedidos_popular '+
        ' where id_popular=:id_popular');
      dm.ds_1.ParamByName('id_popular').AsInteger:=dm.ds_2.FieldByName('id_popular').asinteger;
      dm.ds_1.Open;

      ar_pick_ds.FieldByName('pedido').asstring:=dm.ds_1.FieldByName('id_popular').asstring;
      ar_pick_ds.FieldByName('nomape').asstring:=dm.ds_1.FieldByName('nombre').asstring;
      ar_pick_ds.FieldByName('direccion').asstring:=dm.ds_1.FieldByName('dir').asstring;
      ar_pick_ds.FieldByName('poblacion').asstring:=dm.ds_1.FieldByName('poblacion').asstring;
      ar_pick_ds.FieldByName('provincia').asstring:=dm.ds_1.FieldByName('provincia').asstring;
      ar_pick_ds.FieldByName('cp').asstring:=dm.ds_1.FieldByName('cp').asstring;
      ar_pick_ds.FieldByName('oficina').AsInteger:=dm.ds_1.FieldByName('oficina').AsInteger;

      ar_pick_ds.Post;

      dm.ds_2.Next;
    end;
    dm.t_write.Commit;
  except
    dm.t_write.Rollback;
  end;

  lb_st1.Caption:='Picking Generado '+inttostr(pick_cab);
  application.ProcessMessages;

  if rep_pick.PrepareReport(True) then rep_pick.ShowPreparedReport;

  result:=pick_cab;
end;
{$ENDREGION}

{$REGION 'Packing'}
procedure Tf_main.bt_packingClick(Sender: TObject);
begin

////////////////////////
  {dm.q_pack.Open;
  dm.q_pack_lines.Open;
  f_packing.ShowModal;
  dm.q_pack.close;
  dm.q_pack_lines.close; }
end;

{$ENDREGION}

{$REGION 'Print'}
procedure Tf_main.bt_printClick(Sender: TObject);
begin
  print_indiv;
end;

procedure Tf_main.print_indiv;
const cr=Chr(13);  lf=chr(10);
var    s:string;            f: textfile;
begin
  dm.ds_1.close;
  dm.ds_1.SelectSQL.Clear;
  dm.ds_1.SelectSQL.Add('select c.*,l.*,a.codigo,a.codigo_cli,a.nombre as nom_art '+
    'from c_pedidos_popular c '+
    'inner join c_pedidos_popular_lines l on (c.id_popular=l.id_popular) '+
    'inner join g_articulos a on (l.id_articulo=a.id_articulo) '+
    'where c.estado=''G'' '+
    'order by c.id_popular');
  dm.ds_1.Open;

  dm.ds_1.First;
  while not(dm.ds_1.Eof) do begin
    if dm.ds_1.FieldByName('individual').AsString<>'' then begin
      assignfile(f,imp_eti2);                      //new format
      rewrite(f);

      writeln(f,'e');
      writeln(f,'RN');
      writeln(f,'f260');
      writeln(f,'V0');
      writeln(f,'O0220');
      writeln(f,'M0500');
      writeln(f,'V0');
      writeln(f,'L');
      writeln(f,'A1');
      writeln(f,'D11');
      writeln(f,'z');
      writeln(f,'PK');
      writeln(f,'SK');
      writeln(f,'m');  //sistema metrico

      // 1-rotation
      // 9-smooth font
      // 1-width multiplier
      // 1-height multiplier
      // A12-Point size
      // 0430-Row in 10 mm = 43 mms
      // 0520-Col in 10 mm = 52 mms
      writeln(f,'1911A1003200040'+ charEti(dm.ds_1.FieldByName('individual').asstring));
      writeln(f,'U');
      writeln(f,'1911A1002700040'+ charEti(dm.ds_1.FieldByName('nombre').asstring));
      writeln(f,'U');
      writeln(f,'1911A1002200040'+ charEti(dm.ds_1.FieldByName('dir').asstring));
      writeln(f,'U');
      writeln(f,'1911A1001700040'+ charEti(dm.ds_1.FieldByName('cp').asstring));
      writeln(f,'U');
      writeln(f,'1911A1001700680'+ charEti(dm.ds_1.FieldByName('codigo_cli').asstring+' - '+dm.ds_1.FieldByName('codigo').asstring));
      writeln(f,'U');
      writeln(f,'FB+');  //pone negrita
      writeln(f,'1911A1001200040'+ charEti(dm.ds_1.FieldByName('nom_art').asstring));
      writeln(f,'FB-');  //quita negrita
      writeln(f,'FB+');  //pone negrita
      writeln(f,'1911A1000750840'+ 'Uds '+ formatfloat('000',dm.ds_1.FieldByName('cantidad').asinteger));
      writeln(f,'FB-');  //quita negrita
      writeln(f,'U');
      writeln(f,'1a0000000200040'+ dm.ds_1.FieldByName('codigo_cli').asstring+'$'+dm.ds_1.FieldByName('codigo').asstring+'$12');
      writeln(f,'U');

      writeln(f,'n');  //sistema ingles
      writeln(f,'^01');
      writeln(f,'Q0001');
      writeln(f,'E');

      closefile(f);
    end;

    dm.ds_1.Next;
  end;
end;

function Tf_main.charEti(s: string): string;
begin
  s:= stringreplace(s,'ñ',chr(164),[rfReplaceAll]);
  s:= stringreplace(s,'Ñ',chr(165),[rfReplaceAll]);

  s:= stringreplace(s,'á',chr(160),[rfReplaceAll]);
  s:= stringreplace(s,'é',chr(130),[rfReplaceAll]);
  s:= stringreplace(s,'í',chr(161),[rfReplaceAll]);
  s:= stringreplace(s,'ó',chr(162),[rfReplaceAll]);
  s:= stringreplace(s,'ú',chr(163),[rfReplaceAll]);

  s:= stringreplace(s,'Á',chr(160),[rfReplaceAll]);
  s:= stringreplace(s,'É',chr(130),[rfReplaceAll]);
  s:= stringreplace(s,'Í',chr(161),[rfReplaceAll]);
  s:= stringreplace(s,'Ó',chr(162),[rfReplaceAll]);
  s:= stringreplace(s,'Ú',chr(163),[rfReplaceAll]);

  result:= s;
end;

function Tf_main.WriteRawDataToPrinter(PrinterName: String; Str: String): Boolean;
var
  PrinterHandle: THandle;
  DocInfo: TDocInfo1;
  i: Integer;
  B: Byte;
  Escritos: DWORD;
begin
  Result:= FALSE;
  if OpenPrinter(PChar(PrinterName), PrinterHandle, nil) then
  try
    FillChar(DocInfo,Sizeof(DocInfo),#0);
    with DocInfo do
    begin
      pDocName:= PChar('Printer Test');
      pOutputFile:= nil;
      pDataType:= 'RAW';
    end;
    if StartDocPrinter(PrinterHandle, 1, @DocInfo) <> 0 then
    try
      if StartPagePrinter(PrinterHandle) then
      try
        while Length(Str) > 0 do
        begin
          if Copy(Str, 1, 1) = '\' then
          begin
            if Uppercase(Copy(Str, 2, 1)) = 'X' then
              Str[2]:= '$';
            if not TryStrToInt(Copy(Str, 2, 3),i) then
              Exit;
            B:= Byte(i);
            Delete(Str, 1, 3);
          end else B:= Byte(Str[1]);
          Delete(Str,1,1);
          WritePrinter(PrinterHandle, @B, 1, Escritos);
        end;
        Result:= TRUE;
      finally
        EndPagePrinter(PrinterHandle);
      end;
    finally
      EndDocPrinter(PrinterHandle);
    end;
  finally
    ClosePrinter(PrinterHandle);
  end;
end;
{$ENDREGION}

end.
