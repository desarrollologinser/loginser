unit UGetText;

interface

uses Classes, IdHTTP, IdMultipartFormData, Forms, AnsiStrings;

type ThSelectHilo = class(TThread)
  protected
    procedure execute; override;
    function enviartexto(strurl:string):String;
    function CambiarCaracter1Por2(cartochange,new2car,Cadena:string):string;
    function Cadena2URL(Cadena:String):String;
  published
    destructor destroy;override;
  public
    strurl:string;
    padre:integer;
end;


implementation

uses u_old_web;


destructor ThSelectHilo.Destroy;
begin
  if padre=0 then u_old_web.hiloactivo:=false;
  {if padre=1 then u_getpedidos.hiloactivo:=false;
  if padre=2 then u_getvalijas.hiloactivo:=false;
  if padre=3 then u_getPedidosLibros.hiloactivo:=false;
  if padre=4 then u_getsacaroja.hiloactivo:=false;
  if padre=5 then u_getEstadosDeleg.hiloactivo:=false;
  if padre=6 then u_getPedidosArchivo.hiloactivo:=false;
  }
  inherited Destroy;
end;


procedure ThSelectHilo.execute;
begin
  if padre=0 then u_old_web.htmldevuelto:= enviartexto(Cadena2URL(strurl));
  {if padre=1 then u_getpedidos.htmldevuelto:= enviartexto(Cadena2URL(strurl));
  if padre=2 then u_getvalijas.htmldevuelto:= enviartexto(Cadena2URL(strurl));
  if padre=3 then u_getPedidosLibros.htmldevuelto:= enviartexto(Cadena2URL(strurl));
  if padre=4 then u_getsacaroja.htmldevuelto:= enviartexto(Cadena2URL(strurl));
  if padre=5 then u_getEstadosDeleg.htmldevuelto:= enviartexto(Cadena2URL(strurl));
  if padre=6 then u_getPedidosArchivo.htmldevuelto:= enviartexto(Cadena2URL(strurl)); }
end;


function ThSelectHilo.enviartexto(strurl: string):String;
var
  Http1: TIdHTTP;
  strRead:string;
begin
  Http1 := TIdHTTP.Create (nil);
  try
    strRead := Http1.Get (StrUrl);
    Result := StrRead;
  except
    Result := 'Err';
  end;
end;

function ThSelectHilo.Cadena2URL(Cadena:String):String;
begin
     // Cambia los espacion por %20
     Cadena := CambiarCaracter1Por2(' ','%20',Cadena);
     // Cambia los # por *  (Caracter para separar campos)
     Cadena := CambiarCaracter1Por2('#','*',Cadena);
     Result := Cadena;
end;

function ThSelectHilo.CambiarCaracter1Por2(cartochange,new2car,Cadena:string):string;
begin
  Result:=replacetext(Cadena,cartochange,new2car);
end;

end.
