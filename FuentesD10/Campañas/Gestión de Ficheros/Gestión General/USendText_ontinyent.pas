unit USendText_ontinyent;

interface

uses Classes, IdHTTP, IdMultipartFormData, Forms, AnsiStrings;

type ThSendTextHilo = class(TThread)
  protected
    procedure execute; override;
    procedure subircadena(surl,snomphp,svarname,scadena:String);
    function CambiarCaracter1Por2(cartochange,new2car,Cadena:string):string;
    function Cadena2URL(Cadena:String):String;
  published
    destructor destroy; override;
  public
    url,nomphp,cadena,varname:string;
    launcher:Integer;     //0:sendstock  1:sendalbs
end;


implementation

uses u_ontinyent,IdGlobal;

destructor ThSendTextHilo.destroy;
begin
  if launcher=0 then u_ontinyent.hiloactivo:=false;
  inherited Destroy;
end;


procedure ThSendTextHilo.execute;
begin
  subircadena(url,nomphp,varname,cadena);
end;


procedure ThSendTextHilo.subircadena(surl,snomphp,svarname,scadena:String);
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
        data.AddFormField(svarname,scadena,'ISO-8859-1').ContentTransfer:='8bit';
        Application.ProcessMessages;
        IdHTTP.Request.ContentType := data.RequestContentType;

        if launcher=0 then u_ontinyent.htmldevuelto:=IdHTTP.Post(Cadena2URL(surl+snomphp),data);
        Application.ProcessMessages;
        data.Free;
        IdHTTP.Free;
     except
     end;
end;


function ThSendTextHilo.Cadena2URL(Cadena:String):String;
begin
     // Cambia los espacion por %20
     Cadena := CambiarCaracter1Por2(' ','%20',Cadena);
     // Cambia los # por *  (Caracter para separar campos)
     Cadena := CambiarCaracter1Por2('#','*',Cadena);
     Result := Cadena;
end;

function ThSendTextHilo.CambiarCaracter1Por2(cartochange,new2car,Cadena:string):string;
begin
  Result:=replacetext(Cadena,cartochange,new2car);
end;


end.
