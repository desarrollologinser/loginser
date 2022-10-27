unit u_sync;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, FIBDataSet, pFIBDataSet, FIBDatabase,
  pFIBDatabase,inifiles,dateutils;

function sincronizar:string;

var
  server_name,db_name,email:string;

const
  ln=#13#10;

implementation

uses u_dm, u_globals, u_envia_mail, u_main;


function sincronizar:string;
var   memo:string;  cod_art,cod_alm,n,uds_buenas,uds_roturas:integer;
begin

  memo:='';
                                                            //conecta la BD
  dm.db.Connected:=true;

  dm.con1.Connected:=true;

  memo := memo + 'Borrando Stock En SqlServer. ';

  try
    dm.q.Close;                                           //Borra unidades viejas (por si las flies) de articulos con stock
    dm.q.SQL.Clear;
    dm.q.SQL.Add('update articulos_stock set stock=0,roturas=0 '+
      'from articulos_stock '+
      'inner join articulos on (articulos.codarticulo=articulos_stock.codarticulo) '+
      'where articulos.stock=1');
    dm.q.ExecSQL;
    memo := memo + 'Ok' + ln;
  except on e:exception do
    memo := memo + 'Error ' + e.message + ln;
  end;

  memo := memo + 'Stock=9999 En SqlServer De Articulos Sin Stock. ';

  try
    dm.q.Close;                                           //Llena unidades viejas (por si las flies) de articulos sin stock
    dm.q.SQL.Clear;
    dm.q.SQL.Add('update articulos_stock set stock=9999,roturas=0 '+
      'from articulos_stock '+
      'inner join articulos on (articulos.codarticulo=articulos_stock.codarticulo) '+
      'where articulos.stock=0');
    dm.q.ExecSQL;
    memo := memo + 'Ok' + ln;
  except on e:exception do
    memo := memo + 'Error ' + e.message + ln;
  end;

  memo := memo + ' Recopilando Stock En Firebird. ';

  dm.q_aux.Close;                                                        //todos los articulos que tienen algo de stock
  dm.q_aux.SQLs.SelectSQL.Clear;
  dm.q_aux.SQLs.SelectSQL.Add('select distinct a.id_articulo,a.codigo, a.id_cliente '+
    'from a_stock s '+
    'inner join g_articulos a on (s.id_articulo=a.id_articulo) ' +
    'where a.id_cliente is not null and a.estado=''A''');
  dm.q_aux.Open;

  memo := memo + 'Ok' + ln;

  memo := memo + 'Traspasando Arts/Stock ' + ln;

  n:=0;

  dm.q_aux.First;

  try
   while not(dm.q_aux.Eof) do begin

   { memo := memo + dm.q_aux.FieldByName('id_articulo').asstring  + ' ' +
                   dm.q_aux.FieldByName('codigo').asstring  + ' ' +
                   dm.q_aux.FieldByName('id_cliente').asstring;}
                                                                                        //busca art en lgs viejo
    dm.q_sql.Close;
    dm.q_sql.SQL.Clear;
    dm.q_sql.SQL.Add('select codarticulo,referencia from articulos where codcli=' +  dm.q_aux.FieldByName('id_cliente').AsString +
                     ' and referencia='+quotedstr(dm.q_aux.FieldByName('codigo').AsString));
    dm.q_sql.Open;

    cod_art:=dm.q_sql.FieldByName('codarticulo').AsInteger;


    if dm.q_sql.IsEmpty then begin                                     //si no existe lo crea en sql server
      dm.q_fib.Close;
      dm.q_fib.SQLs.SelectSQL.Clear;                                                         //ficha del articulo
      dm.q_fib.SQLs.SelectSQL.Add('select * '+
        'from g_articulos '+
        'where id_articulo='+dm.q_aux.FieldByName('id_articulo').asstring);
      dm.q_fib.Open;

      dm.q_sql.Close;
      dm.q_sql.SQL.Clear;
      dm.q_sql.SQL.Add('insert into articulos (referencia,articulo,codfamilia,codcli,falta,kgs,kgsvol,largo,ancho,alto,uni_p_embalaje,stock) '+
          ' values (:referencia,:articulo,:codfamilia,:codcli,:falta,:kgs,:kgsvol,:largo,:ancho,:alto,:uni_p_embalaje,:stock)');
      dm.q_sql.Parameters.ParamByName('referencia').value:=dm.q_fib.FieldByName('codigo').asstring;
      dm.q_sql.Parameters.ParamByName('articulo').value:=Copy(dm.q_fib.FieldByName('nombre').asstring,1,60);
      dm.q_sql.Parameters.ParamByName('codfamilia').value:=dm.q_fib.FieldByName('id_familia').asinteger;
      dm.q_sql.Parameters.ParamByName('codcli').value:=dm.q_fib.FieldByName('id_cliente').asinteger;
      dm.q_sql.Parameters.ParamByName('falta').value:=dm.q_fib.FieldByName('fecha_alta').asdatetime;
      dm.q_sql.Parameters.ParamByName('kgs').value:=dm.q_fib.FieldByName('kgs').asfloat;
      dm.q_sql.Parameters.ParamByName('kgsvol').value:=dm.q_fib.FieldByName('kgsvol').asfloat;
      dm.q_sql.Parameters.ParamByName('largo').value:=dm.q_fib.FieldByName('largo').asfloat;
      dm.q_sql.Parameters.ParamByName('ancho').value:=dm.q_fib.FieldByName('ancho').asfloat;
      dm.q_sql.Parameters.ParamByName('alto').value:=dm.q_fib.FieldByName('alto').asfloat;
      dm.q_sql.Parameters.ParamByName('uni_p_embalaje').value:=dm.q_fib.FieldByName('uni_embalaje').asinteger;
      dm.q_sql.Parameters.ParamByName('stock').value:=True;
      dm.q_sql.ExecSQL;

      //memo := memo + ' New' + ln;

      dm.q_sql.Close;                                               //busca el codigo nuevo en sql server
      dm.q_sql.SQL.Clear;
      dm.q_sql.SQL.Add('select codarticulo,referencia from articulos where codcli=' +  dm.q_aux.FieldByName('id_cliente').AsString +
                       ' and referencia='+quotedstr(dm.q_aux.FieldByName('codigo').AsString));
      dm.q_sql.Open;
      cod_art:=dm.q_sql.FieldByName('codarticulo').AsInteger;
    end else begin                                                                           //si existe lo actualiza segun FB
      dm.q_fib.Close;
      dm.q_fib.SQLs.SelectSQL.Clear;                                                         //ficha del articulo
      dm.q_fib.SQLs.SelectSQL.Add('select * '+
        'from g_articulos '+
        'where id_articulo='+dm.q_aux.FieldByName('id_articulo').asstring);
      dm.q_fib.Open;

      dm.q_sql.Close;
      dm.q_sql.SQL.Clear;
      dm.q_sql.SQL.Add('update articulos set referencia=:referencia,articulo=:articulo,codfamilia=:codfamilia,codcli=:codcli,falta=:falta,kgs=:kgs,kgsvol=:kgsvol,'+
          'largo=:largo,ancho=:ancho,alto=:alto,uni_p_embalaje=:uni_p_embalaje,stock=:stock where codarticulo=:codarticulo');
      dm.q_sql.Parameters.ParamByName('codarticulo').value:=cod_art;
      dm.q_sql.Parameters.ParamByName('referencia').value:=dm.q_fib.FieldByName('codigo').asstring;
      dm.q_sql.Parameters.ParamByName('articulo').value:=Copy(dm.q_fib.FieldByName('nombre').asstring,1,60);
      dm.q_sql.Parameters.ParamByName('codfamilia').value:=dm.q_fib.FieldByName('id_familia').asinteger;
      dm.q_sql.Parameters.ParamByName('codcli').value:=dm.q_fib.FieldByName('id_cliente').asinteger;
      dm.q_sql.Parameters.ParamByName('falta').value:=dm.q_fib.FieldByName('fecha_alta').asdatetime;
      dm.q_sql.Parameters.ParamByName('kgs').value:=dm.q_fib.FieldByName('kgs').asfloat;
      dm.q_sql.Parameters.ParamByName('kgsvol').value:=dm.q_fib.FieldByName('kgsvol').asfloat;
      dm.q_sql.Parameters.ParamByName('largo').value:=dm.q_fib.FieldByName('largo').asfloat;
      dm.q_sql.Parameters.ParamByName('ancho').value:=dm.q_fib.FieldByName('ancho').asfloat;
      dm.q_sql.Parameters.ParamByName('alto').value:=dm.q_fib.FieldByName('alto').asfloat;
      dm.q_sql.Parameters.ParamByName('uni_p_embalaje').value:=dm.q_fib.FieldByName('uni_embalaje').asinteger;
      dm.q_sql.Parameters.ParamByName('stock').value:=True;
      dm.q_sql.ExecSQL;

      //memo := memo + ' Upd' + ln;
 end;


    dm.q_fib.Close;
    dm.q_fib.SQLs.SelectSQL.Clear;                                                       //uds buenas del articulo
    dm.q_fib.SQLs.SelectSQL.Add('select sum(s.cantidad) as uds_buenas, u.id_almacen '+
      'from a_stock s '+
      'left outer join a_ubicaciones u on (s.id_ubicacion=u.id_ubicacion) '+
      'where u.id_zona=0 and s.id_articulo='+dm.q_aux.FieldByName('id_articulo').asstring+
      ' group by u.id_almacen');
    dm.q_fib.Open;

    dm.q_fib.First;
    while not(dm.q_fib.Eof) do begin
      dm.q_sql.Close;
      dm.q_sql.SQL.Clear;
      dm.q_sql.SQL.Add('select codarticulo,codalmacen from articulos_stock where codarticulo='+inttostr(cod_art) +
                       ' and codalmacen='+dm.q_fib.FieldByName('id_almacen').asstring);
      dm.q_sql.Open;

      if dm.q_sql.isempty then begin
        dm.q_sql.Close;                                                                //si no existe crea el stock
        dm.q_sql.SQL.Clear;
        dm.q_sql.SQL.Add('insert into articulos_stock (codarticulo,codalmacen,stock,stock_min,stock_max,salidas,entradas,por_iva,por_receq,roturas) '+
          ' values ('+inttostr(cod_art)+','+dm.q_fib.FieldByName('id_almacen').asstring+','+inttostr(dm.q_fib.FieldByName('uds_buenas').AsInteger)+',0,0,0,0,0,0,0)');
        dm.q_sql.ExecSQL;
      end else begin
        try
        dm.q_sql.Close;                                                                //si existe lo actualiza
        dm.q_sql.SQL.Clear;
        dm.q_sql.SQL.Add('update articulos_stock set stock='+inttostr(dm.q_fib.FieldByName('uds_buenas').AsInteger)+
          ' where codarticulo='+inttostr(cod_art) +' and codalmacen='+dm.q_fib.FieldByName('id_almacen').asstring);
        dm.q_sql.ExecSQL;
        except on e:Exception do
            ShowMessage(dm.q_aux.FieldByName('id_articulo').asstring + ' ' +
                     dm.q_fib.FieldByName('uds_buenas').AsString +
                     ' (' + dm.q_fib.FieldByName('id_almacen').asstring + ')' + e.Message + ln);
        end;
      end;

      {memo := memo + dm.q_aux.FieldByName('id_articulo').asstring + ' ' +
                     dm.q_fib.FieldByName('uds_buenas').AsString +
                     ' (' + dm.q_fib.FieldByName('id_almacen').asstring + ')' + ln;
       }
      dm.q_fib.Next;
    end;

    dm.q_fib.Close;
    dm.q_fib.SQLs.SelectSQL.Clear;                                                         //uds roturas del articulo
    dm.q_fib.SQLs.SelectSQL.Add('select sum(s.cantidad) as uds_roturas,u.id_almacen '+
      'from a_stock s '+
      'left outer join a_ubicaciones u on (s.id_ubicacion=u.id_ubicacion) '+
      'where u.id_zona=1 and s.id_articulo='+dm.q_aux.FieldByName('id_articulo').asstring+
      ' group by u.id_almacen');
    dm.q_fib.Open;

    dm.q_fib.First;
    while not(dm.q_fib.Eof) do begin
      dm.q_sql.Close;
      dm.q_sql.SQL.Clear;
      dm.q_sql.SQL.Add('select codarticulo,codalmacen from articulos_stock where codarticulo='+inttostr(cod_art)+' and codalmacen='+dm.q_fib.FieldByName('id_almacen').asstring);
      dm.q_sql.Open;

      if dm.q_sql.isempty then begin
        dm.q_sql.Close;                                                                //si no existe crea el stock
        dm.q_sql.SQL.Clear;
        dm.q_sql.SQL.Add('insert into articulos_stock (codarticulo,codalmacen,stock,stock_min,stock_max,salidas,entradas,por_iva,por_receq,roturas) '+
          ' values ('+inttostr(cod_art)+','+dm.q_fib.FieldByName('id_almacen').asstring+',0,0,0,0,0,0,0,'+inttostr(dm.q_fib.FieldByName('uds_roturas').AsInteger)+')');
        dm.q_sql.ExecSQL;
      end else begin
        try
        dm.q_sql.Close;                                                                //si existe lo actualiza
        dm.q_sql.SQL.Clear;
        dm.q_sql.SQL.Add('update articulos_stock set roturas='+inttostr(dm.q_fib.FieldByName('uds_roturas').AsInteger)+
          ' where codarticulo='+inttostr(cod_art) +' and codalmacen='+dm.q_fib.FieldByName('id_almacen').asstring);
        dm.q_sql.ExecSQL;
        except on e:Exception do
            memo := memo + dm.q_aux.FieldByName('id_articulo').asstring + ' ' +
                     dm.q_fib.FieldByName('uds_roturas').AsString +
                     ' (R.' + dm.q_fib.FieldByName('id_almacen').asstring + ')' + e.Message + ln;

        end;
      end;

     { memo := memo + dm.q_aux.FieldByName('id_articulo').asstring + ' ' +
                     dm.q_fib.FieldByName('uds_roturas').AsString +
                     ' (R.' + dm.q_fib.FieldByName('id_almacen').asstring + ')' + ln;
       }

      dm.q_fib.Next;
    end;


    dm.q_aux.Next;

    Inc(n);

  end;


  except on e:Exception do
            memo := memo + dm.q_aux.FieldByName('id_articulo').asstring + ' ' + e.Message + ln;

        end;


  memo := memo + IntToStr(n) + ' Articulos Con Stock Traspasados' + ln + 'Proceso finalizado.';

  dm.con1.Connected:=false;

  {try
    if email<>'' then u_envia_mail.envia_email(3,email,memo,'Sync Stock -'+server_name+':'+db_name,false);
  finally

  end;
  }

  result := memo;
end;

end.
