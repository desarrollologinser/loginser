unit u_articulos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, FIBDataSet, pFIBDataSet, FIBDatabase,
  pFIBDatabase,inifiles,dateutils;

type
  Tf_articulos = class(TForm)
    bt_1: TButton;
    lbl_1: TLabel;
    lbl_3: TLabel;
    lbl_11: TLabel;
    ed_1: TEdit;
    lbl_2: TLabel;
    me_1: TMemo;
    procedure bt_1Click(Sender: TObject);
    procedure leer_proc_ini(idx:Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure lanza_sync(idx:Integer; verbose:Boolean);
  end;

var
  f_articulos: Tf_articulos;
  server_name,db_name,email:string;

implementation

uses u_dm, u_globals, u_envia_mail, u_main;

{$R *.dfm}

procedure Tf_articulos.bt_1Click(Sender: TObject);
begin
  f_main.tm_1.Enabled:=false;
  lanza_sync(StrToInt(ed_1.text),true);
  f_main.tm_1.Enabled:=true;
end;

procedure Tf_articulos.lanza_sync(idx:Integer; verbose:boolean);
var   memo:string;  cod_art,cod_alm,n,uds_buenas,uds_roturas,insertados,actualizados:integer;
begin
  leer_proc_ini(idx);
  insertados:=0;
  actualizados:=0;
  memo:='';

  //dm.db_fib.DBName:=server_name+':'+db_name;                                             //conecta la BD
  //dm.db_fib.LibraryName:=u_globals.libname;
  dm.db.Connected:=true;

  dm.con1.Connected:=true;

    if verbose then begin
    lbl_1.Caption:='Borrando Stock En SqlServer';
    application.ProcessMessages;
  end;

 { dm.q_sql_art.Close;                                           //Borra unidades viejas (por si las flies) de articulos con stock
  dm.q_sql_art.SQL.Clear;
  dm.q_sql_art.SQL.Add('update articulos_stock set stock=0,roturas=0 '+
    'from articulos_stock '+
    'inner join articulos on (articulos.codarticulo=articulos_stock.codarticulo) '+
    'where articulos.stock=1');
  dm.q_sql_art.ExecSQL;     }

  memo:=memo+'Stock En SqlServer Borrado<br><br>';

  dm.q_sql_art.Close;                                           //Llena unidades viejas (por si las flies) de articulos sin stock
  dm.q_sql_art.SQL.Clear;
  dm.q_sql_art.SQL.Add('update articulos_stock set stock=9999,roturas=0 '+
    'from articulos_stock '+
    'inner join articulos on (articulos.codarticulo=articulos_stock.codarticulo) '+
    'where articulos.stock=0');
  dm.q_sql_art.ExecSQL;

  memo:=memo+'Stock=9999 En SqlServer De Articulos Sin Stock<br><br>';

  if verbose then begin
    lbl_1.Caption:='Recopilando Stock En Firebird';
    application.ProcessMessages;
  end;

  dm.q_fib_stock.Close;                                                        //todos los articulos que tienen algo de stock
  dm.q_fib_stock.SelectSQL.Clear;
  dm.q_fib_stock.SelectSQL.Add('select distinct a.* '+
    'from a_stock s '+
    'inner join g_articulos a on (s.id_articulo=a.id_articulo)');
  dm.q_fib_stock.Open;

  memo:=memo+'Stock en Firebird Recopilado<br><br>';

  if verbose then begin
    lbl_1.Caption:='Traspasando Stock';
    application.ProcessMessages;
  end;
  memo:=memo+'Traspasando Stock<br><br>';

  n:=0;

  dm.q_fib_stock.First;
  while not(dm.q_fib_stock.Eof) do begin
    lbl_2.Caption:=dm.q_fib_stock.FieldByName('id_articulo').asstring;
    application.ProcessMessages;
                                                                                        //busca art en lgs viejo
    dm.q_sql_art.Close;
    dm.q_sql_art.SQL.Clear;
    dm.q_sql_art.SQL.Add('select codarticulo,referencia from articulos where referencia='+quotedstr(dm.q_fib_stock.FieldByName('codigo').AsString));
    dm.q_sql_art.SQL.Add(' and codcli='+dm.q_fib_stock.FieldByName('id_cliente').AsString);
    dm.q_sql_art.Open;

    cod_art:=dm.q_sql_art.FieldByName('codarticulo').AsInteger;

    if dm.q_sql_art.IsEmpty then begin                                     //si no existe lo crea en sql server
      dm.q_fib_art.Close;
      dm.q_fib_art.SQLs.SelectSQL.Clear;                                                         //ficha del articulo
      dm.q_fib_art.SQLs.SelectSQL.Add('select * '+
        'from g_articulos '+
        'where id_articulo='+dm.q_fib_stock.FieldByName('id_articulo').asstring);
      dm.q_fib_art.Open;

      dm.q_sql_art.Close;
      dm.q_sql_art.SQL.Clear;
      dm.q_sql_art.SQL.Add('insert into articulos (referencia,articulo,codfamilia,codcli,falta,kgs,kgsvol,largo,ancho,alto,uni_p_embalaje,stock) '+
          ' values (:referencia,:articulo,:codfamilia,:codcli,:falta,:kgs,:kgsvol,:largo,:ancho,:alto,:uni_p_embalaje,:stock)');
      dm.q_sql_art.Parameters.ParamByName('referencia').value:=dm.q_fib_art.FieldByName('codigo').asstring;
      dm.q_sql_art.Parameters.ParamByName('articulo').value:=Copy(dm.q_fib_art.FieldByName('nombre').asstring,1,60);
      dm.q_sql_art.Parameters.ParamByName('codfamilia').value:=dm.q_fib_art.FieldByName('id_familia').asinteger;
      dm.q_sql_art.Parameters.ParamByName('codcli').value:=dm.q_fib_art.FieldByName('id_cliente').asinteger;
      dm.q_sql_art.Parameters.ParamByName('falta').value:=dm.q_fib_art.FieldByName('fecha_alta').asdatetime;
      dm.q_sql_art.Parameters.ParamByName('kgs').value:=dm.q_fib_art.FieldByName('kgs').asfloat;
      dm.q_sql_art.Parameters.ParamByName('kgsvol').value:=dm.q_fib_art.FieldByName('kgsvol').asfloat;
      dm.q_sql_art.Parameters.ParamByName('largo').value:=dm.q_fib_art.FieldByName('largo').asfloat;
      dm.q_sql_art.Parameters.ParamByName('ancho').value:=dm.q_fib_art.FieldByName('ancho').asfloat;
      dm.q_sql_art.Parameters.ParamByName('alto').value:=dm.q_fib_art.FieldByName('alto').asfloat;
      dm.q_sql_art.Parameters.ParamByName('uni_p_embalaje').value:=dm.q_fib_art.FieldByName('uni_embalaje').asinteger;
      dm.q_sql_art.Parameters.ParamByName('stock').value:=True;
      dm.q_sql_art.ExecSQL;
      memo:=memo+'Articulo Creado En SQL Server '+dm.q_fib_art.FieldByName('codigo').AsString+'<br>';

      dm.q_sql_art.Close;                                               //busca el codigo nuevo en sql server
      dm.q_sql_art.SQL.Clear;
      dm.q_sql_art.SQL.Add('select codarticulo,referencia from articulos where referencia='+quotedstr(dm.q_fib_art.FieldByName('codigo').AsString));
      dm.q_sql_art.SQL.Add(' and codcli='+dm.q_fib_art.FieldByName('id_cliente').AsString);
      dm.q_sql_art.Open;
      cod_art:=dm.q_sql_art.FieldByName('codarticulo').AsInteger;
    end else begin                                                                           //si existe lo actualiza segun FB

              dm.q_sql_art.Close;
              dm.q_sql_art.SQL.Clear;
              dm.q_sql_art.SQL.Add('update articulos set referencia=:referencia,articulo=:articulo,codfamilia=:codfamilia,codcli=:codcli,falta=:falta,kgs=:kgs,kgsvol=:kgsvol,'+
                  'largo=:largo,ancho=:ancho,alto=:alto,uni_p_embalaje=:uni_p_embalaje,stock=:stock where codarticulo=:codarticulo');
              dm.q_sql_art.Parameters.ParamByName('codarticulo').value:=cod_art;
              dm.q_sql_art.Parameters.ParamByName('referencia').value:=dm.q_fib_stock.FieldByName('codigo').asstring;
              dm.q_sql_art.Parameters.ParamByName('articulo').value:=Copy(dm.q_fib_stock.FieldByName('nombre').asstring,1,60);
              dm.q_sql_art.Parameters.ParamByName('codfamilia').value:=dm.q_fib_stock.FieldByName('id_familia').asinteger;
              dm.q_sql_art.Parameters.ParamByName('codcli').value:=dm.q_fib_stock.FieldByName('id_cliente').asinteger;
              dm.q_sql_art.Parameters.ParamByName('falta').value:=dm.q_fib_stock.FieldByName('fecha_alta').asdatetime;
              dm.q_sql_art.Parameters.ParamByName('kgs').value:=dm.q_fib_stock.FieldByName('kgs').asfloat;
              dm.q_sql_art.Parameters.ParamByName('kgsvol').value:=dm.q_fib_stock.FieldByName('kgsvol').asfloat;
              dm.q_sql_art.Parameters.ParamByName('largo').value:=dm.q_fib_stock.FieldByName('largo').asfloat;
              dm.q_sql_art.Parameters.ParamByName('ancho').value:=dm.q_fib_stock.FieldByName('ancho').asfloat;
              dm.q_sql_art.Parameters.ParamByName('alto').value:=dm.q_fib_stock.FieldByName('alto').asfloat;
              dm.q_sql_art.Parameters.ParamByName('uni_p_embalaje').value:=dm.q_fib_stock.FieldByName('uni_embalaje').asinteger;
              dm.q_sql_art.Parameters.ParamByName('stock').value:=True;
              dm.q_sql_art.ExecSQL;
              memo:=memo+'Articulo Actualizado En SQL Server ' + dm.q_fib_stock.FieldByName('codigo').AsString + '<br>';
         end;

    dm.q_fib_art.Close;
    dm.q_fib_art.SQLs.SelectSQL.Clear;                                                       //uds buenas del articulo
    dm.q_fib_art.SQLs.SelectSQL.Add('select sum(s.cantidad) as uds_buenas, u.id_almacen '+
      'from a_stock s '+
      'left outer join a_ubicaciones u on (s.id_ubicacion=u.id_ubicacion) '+
      'where u.id_zona=0 and s.id_articulo='+dm.q_fib_stock.FieldByName('id_articulo').asstring+
      ' group by u.id_almacen');
    dm.q_fib_art.Open;

    dm.q_fib_art.First;
    while not(dm.q_fib_art.Eof) do begin
      dm.q_sql_art.Close;
      dm.q_sql_art.SQL.Clear;
      dm.q_sql_art.SQL.Add('select codarticulo,codalmacen from articulos_stock where codarticulo='+inttostr(cod_art)+
                           ' and codalmacen='+dm.q_fib_art.FieldByName('id_almacen').asstring);
      dm.q_sql_art.Open;

      if dm.q_sql_art.isempty then begin
        dm.q_sql_art.Close;                                                                //si no existe crea el stock
        dm.q_sql_art.SQL.Clear;
        dm.q_sql_art.SQL.Add('insert into articulos_stock (codarticulo,codalmacen,stock,stock_min,stock_max,salidas,entradas,por_iva,por_receq,roturas) '+
          ' values ('+inttostr(cod_art)+','+dm.q_fib_art.FieldByName('id_almacen').asstring+','+inttostr(dm.q_fib_art.FieldByName('uds_buenas').AsInteger)+
          ',0,0,0,0,0,0,0)');
        dm.q_sql_art.ExecSQL;
      end else begin
        dm.q_sql_art.Close;                                                                //si existe lo actualiza
        dm.q_sql_art.SQL.Clear;
        dm.q_sql_art.SQL.Add('update articulos_stock set stock='+inttostr(dm.q_fib_art.FieldByName('uds_buenas').AsInteger)+
          ' where codarticulo='+inttostr(cod_art) +' and codalmacen='+dm.q_fib_art.FieldByName('id_almacen').asstring);
        dm.q_sql_art.ExecSQL;
      end;

      dm.q_fib_art.Next;
    end;

    dm.q_fib_art.Close;
    dm.q_fib_art.SQLs.SelectSQL.Clear;                                                         //uds roturas del articulo
    dm.q_fib_art.SQLs.SelectSQL.Add('select sum(s.cantidad) as uds_roturas,u.id_almacen '+
      'from a_stock s '+
      'left outer join a_ubicaciones u on (s.id_ubicacion=u.id_ubicacion) '+
      'where u.id_zona=1 and s.id_articulo='+dm.q_fib_stock.FieldByName('id_articulo').asstring+
      ' group by u.id_almacen');
    dm.q_fib_art.Open;

    dm.q_fib_art.First;
    while not(dm.q_fib_art.Eof) do begin
      dm.q_sql_art.Close;
      dm.q_sql_art.SQL.Clear;
      dm.q_sql_art.SQL.Add('select codarticulo,codalmacen from articulos_stock where codarticulo='+inttostr(cod_art)+
                           ' and codalmacen='+dm.q_fib_art.FieldByName('id_almacen').asstring);
      dm.q_sql_art.Open;

      if dm.q_sql_art.isempty then begin
        dm.q_sql_art.Close;                                                                //si no existe crea el stock
        dm.q_sql_art.SQL.Clear;
        dm.q_sql_art.SQL.Add('insert into articulos_stock (codarticulo,codalmacen,stock,stock_min,stock_max,salidas,entradas,por_iva,por_receq,roturas) '+
          ' values ('+inttostr(cod_art)+','+dm.q_fib_art.FieldByName('id_almacen').asstring+',0,0,0,0,0,0,0,'+inttostr(dm.q_fib_art.FieldByName('uds_roturas').AsInteger)+')');
        dm.q_sql_art.ExecSQL;
      end else begin
        dm.q_sql_art.Close;                                                                //si existe lo actualiza
        dm.q_sql_art.SQL.Clear;
        dm.q_sql_art.SQL.Add('update articulos_stock set roturas='+inttostr(dm.q_fib_art.FieldByName('uds_roturas').AsInteger)+
          ' where codarticulo='+inttostr(cod_art) +' and codalmacen='+dm.q_fib_art.FieldByName('id_almacen').asstring);
        dm.q_sql_art.ExecSQL;
      end;

      dm.q_fib_art.Next;
    end;


    dm.q_fib_stock.Next;
    Inc(n);
    if verbose then begin
      lbl_3.Caption:=IntToStr(n);
      Application.ProcessMessages;
    end;
  end;

  memo:=memo+IntToStr(n)+' Articulos Con Stock Traspasados';

  //Actualizar datos de articulos de SQL server a Firebird

  if verbose then begin
    lbl_1.Caption:='Actualizando Articulos en FB';
    application.ProcessMessages;
  end;

  n:=0;
  memo:=memo+'Actualizando Articulos en FB<br><br>';

  dm.q_sql_art.Close;
  dm.q_sql_art.SQL.Clear;
  dm.q_sql_art.SQL.Add('select * from articulos where falta>:fecha');
  dm.q_sql_art.Parameters.ParamByName('fecha').Value:=incweek(date,-1);
  dm.q_sql_art.Open;

  try
    dm.t_write.StartTransaction;
    dm.q_sql_art.First;
    while not(dm.q_sql_art.Eof) do begin
      dm.q_fib_art.Close;
      dm.q_fib_art.SQLs.SelectSQL.Clear;                                                         //ficha del articulo
      dm.q_fib_art.SQLs.SelectSQL.Add('select * '+
          'from g_articulos '+
          'where codigo=:codigo and id_cliente=:codcli');
      dm.q_fib_art.ParamByName('codigo').AsString:=trim(dm.q_sql_art.FieldByName('referencia').asstring);
      dm.q_fib_art.ParamByName('codcli').AsInteger:=dm.q_sql_art.FieldByName('codcli').AsInteger;
      dm.q_fib_art.Open;

      if dm.q_fib_art.IsEmpty then begin                                      //no existe en FIB se crea
        dm.qry_fib_art.Close;
        dm.qry_fib_art.SQL.Clear;
        dm.qry_fib_art.SQL.Add('insert into g_articulos (codigo,nombre,id_cliente,id_familia,kgs,kgsvol,largo,ancho,alto) '+
          'values (:codigo,:nombre,:id_cliente,:id_familia,:kgs,:kgsvol,:largo,:ancho,:alto)');
        dm.qry_fib_art.ParamByName('nombre').AsString:=Trim(dm.q_sql_art.FieldByName('articulo').AsString);
        dm.qry_fib_art.ParamByName('codigo').AsString:=dm.q_sql_art.FieldByName('referencia').AsString;
        dm.qry_fib_art.ParamByName('id_cliente').asinteger:=dm.q_sql_art.FieldByName('codcli').asinteger;
        dm.qry_fib_art.ParamByName('id_familia').asinteger:=dm.q_sql_art.FieldByName('codfamilia').asinteger;
        dm.qry_fib_art.ParamByName('kgs').asfloat:=dm.q_sql_art.FieldByName('kgs').asfloat;
        dm.qry_fib_art.ParamByName('kgsvol').asfloat:=dm.q_sql_art.FieldByName('kgsvol').asfloat;
        dm.qry_fib_art.ParamByName('largo').asfloat:=dm.q_sql_art.FieldByName('largo').asfloat;
        dm.qry_fib_art.ParamByName('ancho').asfloat:=dm.q_sql_art.FieldByName('ancho').asfloat;
        dm.qry_fib_art.ParamByName('alto').asfloat:=dm.q_sql_art.FieldByName('alto').asfloat;
        dm.qry_fib_art.ExecQuery;
      end else begin                                                      //si existe en FIB se actualiza
        {dm.qu_1.Close;
        dm.qu_1.SQL.Clear;
        dm.qu_1.SQL.Add('update g_articulos set nombre=:nombre,id_cliente=:id_cliente,id_familia=:id_familia,kgs=:kgs,kgsvol=:kgsvol,largo=:largo'+
          ',ancho=:ancho,alto=:alto where codigo=:codigo');
        dm.qu_1.ParamByName('nombre').AsString:=Trim(dm.q_sql.FieldByName('articulo').AsString);
        dm.qu_1.ParamByName('codigo').AsString:=dm.q_sql.FieldByName('referencia').AsString;
        dm.qu_1.ParamByName('id_cliente').asinteger:=dm.q_sql.FieldByName('codcli').asinteger;
        dm.qu_1.ParamByName('id_familia').asinteger:=dm.q_sql.FieldByName('codfamilia').asinteger;
        dm.qu_1.ParamByName('kgs').asfloat:=dm.q_sql.FieldByName('kgs').asfloat;
        dm.qu_1.ParamByName('kgsvol').asfloat:=dm.q_sql.FieldByName('kgsvol').asfloat;
        dm.qu_1.ParamByName('largo').asfloat:=dm.q_sql.FieldByName('largo').asfloat;
        dm.qu_1.ParamByName('ancho').asfloat:=dm.q_sql.FieldByName('ancho').asfloat;
        dm.qu_1.ParamByName('alto').asfloat:=dm.q_sql.FieldByName('alto').asfloat;
        dm.qu_1.ExecQuery;  }
      end;
      dm.q_sql_art.Next;
      Inc(n);
      if verbose then begin
        lbl_3.Caption:=IntToStr(n);
        Application.ProcessMessages;
      end;
    end;
    dm.t_write.CommitRetaining;
  except
    dm.t_write.rollback;
  end;

  memo:=memo+IntToStr(n)+' Articulos Verificados<br><br>';

  dm.db.Connected:=False;
  dm.con1.Connected:=false;

  if verbose then begin
    me_1.Clear;
    me_1.Text:=memo;
  end;

  if verbose then ShowMessage('Finished');
end;

procedure Tf_articulos.leer_proc_ini(idx:Integer);
var ini:tinifile;
begin                                                               //Cargar datos del ini
  ini:=tinifile.create(ExtractFilePath(ParamStr(0))+'demon.ini');
  try
   server_name:=ini.readstring('Sync_'+inttostr(idx),'servername','');
   db_name:=ini.readstring('Sync_'+inttostr(idx),'dbname','');
   email:=ini.readstring('Sync_'+inttostr(idx),'email','');
  finally
   ini.free;
  end;
end;

end.
