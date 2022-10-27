unit u_old_web;

interface

uses
    System.SysUtils, Vcl.Forms, pFIBDataSet, jpeg;

function ActualizaFotosArtsWeb(id_cliente, usuario:Integer; httpweb,destjpg,php_down, php_up,log_app,ip,pc_nom:string; mail_txt:string):string;

const
  ln = #13#10;
var
  hiloactivo: Boolean;
  htmldevuelto: string;

implementation

uses
  u_dm, USendText, UGetText, USendFile;

function ActualizaFotosArtsWeb(id_cliente, usuario:Integer; httpweb,destjpg,php_down,php_up,log_app,ip,pc_nom:string; mail_txt:string):string;
var
    resultado, s, id_art, codarticulo, orijpg,desjpg: string;
    GetText:ThSelecthilo;
    SendFile:ThSendFileHilo;
    Jpeg:TjpegImage;
    n: integer;
begin
  resultado := 'Recogiendo Listado de Fotos de Artículos ' + ln;
  mail_txt := mail_txt+'Recogiendo Listado de Fotos de Artículos <br>';

  GetText:=ThSelectHilo.Create(true);
  GetText.FreeOnTerminate:=True;
  GetText.padre:=0;
  GetText.strurl:= httpweb+php_down;
  hiloactivo:=True;
  GetText.Resume;
  while hiloactivo do Application.ProcessMessages;

  with TpFIBDataSet.Create(dm) do try
    Database:=dm.db;
    s:=htmldevuelto;
    n:=Pos(',',s);
    while n > 0 do begin
      id_art:=Copy(s,1,n-1);
      s:=Copy(s,n+1,Length(s));
      n:=Pos(',',s);

      resultado := resultado + 'Verif Art '+id_art + ln;
      mail_txt := mail_txt+'Verif Art '+id_art+' <br>';

      close;
      SelectSQL.Clear;
      SelectSQL.Add('select * from g_articulos where id_articulo=:id_art');
      if id_cliente>0 then
      begin
         SelectSQL.Add(' and id_cliente=:id_cliente');
         ParamByName('id_cliente').AsInteger := id_cliente;
      end;
      ParamByName('id_art').AsString := id_art;
      Open;

      if RecordCount > 0 then begin
        codarticulo:=FieldByName('codigo').AsString;
        if FieldByName('imagen').IsNull then continue;
        if Pos('/',codarticulo)>0 then continue;
        Jpeg := TJpegImage.Create;
        try
          Jpeg.Assign(FieldByName('imagen'));
          orijpg:=ExtractFilePath(ParamStr(0))+'\files\'+codarticulo+'.jpg';
          desjpg := destjpg+'/'+codarticulo+'.jpg';
          Jpeg.SaveToFile(orijpg);
          if FileExists(orijpg) then begin
            resultado := resultado + 'Subiendo JPG '+id_art + ln;
            mail_txt := mail_txt + 'Subiendo JPG ' + codarticulo + ' <br>';

            SendFile:=ThSendFileHilo.create(true);                 //Envia JPG
            SendFile.launcher:=0;
            SendFile.freeonterminate:=true;
            SendFile.ruta_origen:= orijpg ;
            SendFile.ruta_destino:= desjpg;
            SendFile.url := httpweb ;
            //SendFile.nomphp := 'sync_subir_jpg_art.php';
            SendFile.nomphp := php_up;
            hiloactivo:=True;
            SendFile.Resume;
            while hiloactivo do application.ProcessMessages;

            DeleteFile(orijpg);
          end
        finally
          Jpeg.Free;
        end;
      end;
    end;
  finally
    Free;
  end;

  dm.db.Connected:=false;

  result := resultado;

end;

end.
