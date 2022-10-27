unit u_mk_orm;

interface

uses System.SysUtils, System.Classes,IdMessage,IdText,strutils,IdSMTP,IdAttachmentFile, Sistema.Sesion;

function BuscaTarea_Id(ref:string):integer;             //Devuelve id de tarea a partir de ref
function BuscaTarea_Ref(Id:Integer):string;             //Devuelve ref de tarea a partir de id
function BuscaTarea_Nombre(ref:string):string;          // Devuelve nombre de tarea a partir de ref
function BuscaCliente_Nombre(id:Integer):string;        //Devuelve nombre del cliente a partir de id
function BuscaServicio_Nombre(ref:string):string;       //Devuelve nombre del servicio a partir de ref
function BuscaServicio_Referencia(id:integer):string;   //Devuelve refrenecia del servicio a partir de id
function BuscaServicio_Id(ref:string):integer;          //Devuelve id del servicio a partir de ref
function BuscaTarifaCliente(cliente, servicio:Integer):Double;
function MesTexto(mes:integer) : string;
function LeerIni(seccion,dato, valor_defecto:string):TStringList;
procedure envia_email(asunto,texto:string);

implementation

uses
  mk_udm, ORM.General, System.IniFiles;

function BuscaTarea_Id(ref:string):integer;
begin
  If dm.TareaCliente.TareasClientes.LoadByWhere('REFERENCIA='+QuotedStr(ref)) then
      begin
        result := dm.TareaCliente.TareasClientes.IdTarea;
      end;
end;

function BuscaTarea_Ref(id:Integer):string;
begin
   If dm.TareaCliente.TareasClientes.LoadByWhere('ID_TAREA='+IntToStr(id)) then
      begin
        result := dm.TareaCliente.TareasClientes.Referencia;
      end;
end;

function BuscaTarea_Nombre(ref:string):string;
begin
  If dm.TareaCliente.TareasClientes.LoadByWhere('REFERENCIA='+QuotedStr(ref)) then
      begin
        result := dm.TareaCliente.TareasClientes.Descripcion;
      end;
end;

function BuscaCliente_Nombre(id:Integer):string;
begin
  if dm.Cliente.Cliente.LoadByWhere('CODIGO='+IntToStr(id)) then
  begin
     result := dm.Cliente.Cliente.Nombre;
  end;
end;

function BuscaServicio_Nombre(ref:string):string;
begin
   If dm.ServicioManipulado.Servicios.LoadByWhere('REFERENCIA='+QuotedStr(ref)) then
      begin
        result := dm.ServicioManipulado.Servicios.Nombre;
      end;
end;

function BuscaServicio_Referencia(id:integer):string;
begin
   If dm.ServicioManipulado.Servicios.LoadById(id) then
      begin
        result := dm.ServicioManipulado.Servicios.Referencia;
      end;
end;

function BuscaServicio_Id(ref:string):integer;
begin
  If dm.ServicioManipulado.Servicios.LoadByWhere('REFERENCIA='+QuotedStr(ref)) then
      begin
        result := dm.ServicioManipulado.Servicios.IdServicio;
      end;
end;

function BuscaTarifaCliente(cliente, servicio: Integer):Double;
begin
   if dm.TarifaCliente.TarifasClientes.LoadByWhere('ID_CLIENTE=' + IntToStr(cliente) + ' AND ID_SERVICIO=' + IntToStr(servicio)) then
        result := dm.TarifaCliente.TarifasClientes.PrecioUnitario;
end;

procedure envia_email(asunto,texto:string);
var
  cuerpo:TStrings;
  destino,filePath,desc_err:string;
  msg_1:TIdMessage;
  smtp_1:tidsmtp;
begin

  try
    msg_1:=TIdMessage.Create();
    with msg_1 do begin
      cuerpo:=TStringList.Create;
      cuerpo.Clear;
      cuerpo.Add(texto);

      with TIdText.Create(MessageParts, nil) do begin
        Body.assign(cuerpo);
        ContentType:='text/html';
      end;

      cuerpo.Free;

      From.Text:='desarrollo@loginser.com';
      ReplyTo.EMailAddresses:='desarrollo@loginser.com';

      destino:='desarrollo@loginser.com';
      Recipients.EMailAddresses:=destino;
      Subject:=asunto;
    end;

    try
      smtp_1:=TIdSMTP.Create();

      smtp_1.Username:='sys@loginser.com';
      smtp_1.Password:='Thot485';
      smtp_1.Host:='smtp.1and1.es';
      smtp_1.Port:=587;

      smtp_1.Connect;
      try
        smtp_1.Send(msg_1);
      finally
        smtp_1.Disconnect;
      end;
    finally
      smtp_1.Free;
    end;
  finally
    msg_1.free;
  end;
  //http://www.indyproject.org/Sockets/Blogs/RLebeau/2005_08_17_A.EN.aspx
end;

function LeerIni(seccion,dato, valor_defecto:string):TStringList;
var
  ini: TIniFile;
  Rutas: TStringList;
begin
  try
    ini := TIniFile.Create(Sesion.RutaIni);
    Rutas := TStringList.Create;

    Rutas.Add(ini.ReadString(seccion, dato, valor_defecto));

    Result := Rutas;
  finally
    ini.Free;
    // Rutas.Free;
  end;
end;

 function MesTexto(mes:integer) : string;
 begin
   case mes of
     1 : Result := 'ENERO';
     2 : Result := 'FEBRERO';
     3 : Result := 'MARZO';
     4 : Result := 'ABRIL';
     5 : Result := 'MAYO';
     6 : Result := 'JUNIO';
     7 : Result := 'JULIO';
     8 : Result := 'AGOSTO';
     9 : Result := 'SEPTIEMBRE';
     10 : Result := 'OCTUBRE';
     11 : Result := 'NOVIEMBRE';
     12 : Result := 'DICIEMBRE';
   else
     Result := 'Error';
   end;
 end;

end.
