unit UGetText_ontinyent;

interface

uses Classes, IdHTTP, Forms, AnsiStrings;

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
end;

implementation

uses u_ontinyent;

destructor ThSelectHilo.Destroy;
begin
  u_ontinyent.hiloactivo:=false;
  inherited Destroy;
end;


procedure ThSelectHilo.execute;
begin
  u_ontinyent.htmldevuelto:= enviartexto(Cadena2URL(strurl));
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
