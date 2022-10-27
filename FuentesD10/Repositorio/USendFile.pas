unit USendFile;

interface

uses Classes, IdHTTP, IdMultipartFormData, Forms, AnsiStrings;

type ThSendFileHilo = class(TThread)
  protected
    procedure execute; override;
    procedure subirfichero(surl,snomphp,sruta_origen,sruta_destino:String);
    function CambiarCaracter1Por2(cartochange,new2car,Cadena:string):string;
    function Cadena2URL(Cadena:String):String;
  published
    destructor destroy; override;
  public
    url,nomphp,ruta_origen,ruta_destino:string;
    launcher:Integer;     //0:sendstock  1:sendalbs
end;


implementation

uses IdGlobal, u_old_web;

destructor ThSendFileHilo.destroy;
begin
  if launcher=0 then u_old_web.hiloactivo:=false;
  {if launcher=1 then u_sendalbs.hiloactivo:=false;
  if launcher=2 then u_sendpick.hiloactivo:=false;
  if launcher=3 then u_sendPedidosEstados.hiloactivo:=false;
  if launcher=4 then u_sendASEVAL.hiloactivo:=false;  }
  inherited Destroy;
end;


procedure ThSendFileHilo.execute;
begin
  subirfichero(url,nomphp,ruta_origen,ruta_destino);
end;


procedure ThSendFileHilo.SubirFichero(surl,snomphp,sruta_origen,sruta_destino:String);
var
   data: TIdMultiPartFormDataStream;
   IdHTTP : TIdHTTP;
begin
     try
        IdHTTP := TIdHTTP.Create(nil);
        IdHTTP.AllowCookies   := True;
        IdHTTP.ReadTimeout    := idTimeoutInfinite;
        IdHTTP.ConnectTimeout := 120000;
        data := TIdMultiPartFormDataStream.Create;
        data.AddFile('origen',sruta_origen,'file');
        data.AddFormField('destino',sruta_destino);
        Application.ProcessMessages;
        IdHTTP.Request.ContentType := data.RequestContentType;
        if launcher=0 then u_old_web.htmldevuelto:=IdHTTP.Post(Cadena2URL(surl+snomphp),data);
       { if launcher=1 then u_sendalbs.htmldevuelto:=IdHTTP.Post(Cadena2URL(surl+snomphp),data);
        if launcher=2 then u_sendpick.htmldevuelto:=IdHTTP.Post(Cadena2URL(surl+snomphp),data);
        if launcher=3 then u_sendPedidosEstados.htmldevuelto:=IdHTTP.Post(Cadena2URL(surl+snomphp),data);
        if launcher=4 then u_sendASEVAL.htmldevuelto:=IdHTTP.Post(Cadena2URL(surl+snomphp),data); }
        Application.ProcessMessages;
        data.Free;
        IdHTTP.Free;
     except
     end;
end;


function ThSendFileHilo.Cadena2URL(Cadena:String):String;
begin
     // Cambia los espacion por %20
     Cadena := CambiarCaracter1Por2(' ','%20',Cadena);
     // Cambia los # por *  (Caracter para separar campos)
     Cadena := CambiarCaracter1Por2('#','*',Cadena);
     Result := Cadena;
end;

function ThSendFileHilo.CambiarCaracter1Por2(cartochange,new2car,Cadena:string):string;
begin
  Result:=replacetext(Cadena,cartochange,new2car);
end;


end.
