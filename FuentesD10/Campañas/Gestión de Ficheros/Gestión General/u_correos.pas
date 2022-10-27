unit u_correos;

interface

uses
   Winapi.Windows, System.SysUtils, System.Classes, FIBDataSet, IdHTTP, Vcl.Dialogs;

  function CreaPreRegistroEnvio(qry:TFIBDataSet;li:boolean; producto:string):TStringList;
  function CreaSolicitudEtiquetaCorreos(fecha:TDateTime; envio:string):TStringList;
  function JSONPostCorreos(op:Integer;text:string):string;

implementation

uses
   u_dm, u_main;

function CreaPreRegistroEnvio(qry:TFIBDataSet; li:boolean; producto:string):TStringList;
var
  json: TStringList;
begin
   try
    json := TStringlist.Create;

    json.Text := '{';

    json.Append('"FechaOperacion" : "' + FormatDateTime('dd-mm-yyyy hh:nn:ss',Now) + '",');

    json.Append('"CodEtiquetador" : "' + u_main.correos_etiquetador + '",');
    json.Append('"NumContrato" : "' + u_main.correos_contrato + '",');
    json.Append('"NumCliente" : "' + u_main.correos_cliente + '",');

    json.Append('"Care" : "000000",');
    json.Append('"TotalBultos" : 1,');
    json.Append('"ModDevEtiqueta" : 2,');
    // ******************************************************** REMITENTE
    json.Append('"Remitente" : { ');
         json.Append('"Identificacion" : { ');
              json.Append('"Nombre" : "",');
              json.Append('"Apellido1" : "",');
              json.Append('"Apellido2" : "",');
              json.Append('"Nif" : "B54822887",');

              //17/01/2017 Si el pedido es para El Corte Inglés el remitente solo ha de mostrar este nombre (pedido 20/11/2017)
              if qry.fieldbyname('tags').asstring='ECI' then
              begin
                json.Append('"Empresa" : "El Corte Inglés",');
                json.Append('"PersonaContacto" : ""');
              end {else if qry.fieldbyname('tags').asstring='PRIVALIA' then
                       begin
                         json.Append('"Empresa" : "Privalia",');
                         json.Append('"PersonaContacto" : ""');
                       end} else begin
                                   json.Append('"Empresa" : "Flamingos Life",');
                                   json.Append('"PersonaContacto" : "Almacén Loginser"');
                                end;

         json.Append('},');  //end Identificacion
         json.Append('"DatosDireccion" : { ');
              json.Append('"TipoDireccion" : "C/",');
              json.Append('"Direccion" : "Poniente",');
              json.Append('"Numero" : "10",');
              json.Append('"Portal" : "",');
              json.Append('"Bloque" : "",');
              json.Append('"Escalera" : "",');
              json.Append('"Piso" : "",');
              json.Append('"Puerta" : "",');
              json.Append('"Localidad" : "Riba-Roja del Túria",');
              json.Append('"Provincia" : "Valencia"');
         json.Append('},');  //end DatosDireccion
         json.Append('"CP" : "46394",');
         //Se pone la referencia en el teléfono del remitente para que salga en la de LI.
         //Correos comunicó que solucionarian que no aparece la referencia del cliente en L
         json.Append('"Telefonocontacto" : "' + qry.FieldByName('ORDER_NAME').AsString + '",');
         json.Append('"Email" : "",');
         json.Append('"DatosSMS" : {');
              json.Append('"NumeroSMS" : "",');
              json.Append('"Idioma" : ""');
         json.Append('}');  //end DatosSMS
    json.Append('},');  //end Remitente

    // ******************************************************** DESTINATARIO
    json.Append('"Destinatario" : { ');
         json.Append('"Identificacion" : { ');
              json.Append('"Nombre" : "' + qry.FieldByName('Nombre').AsString + '",');
              json.Append('"Apellido1" : "",');
              json.Append('"Apellido2" : "",');
              json.Append('"Nif" : "",');

              if qry.FieldByName('COMPANY').AsString='' then
              begin
                json.Append('"Empresa" : "",');
                json.Append('"PersonaContacto" : ""');
              end else begin
                        json.Append('"Empresa" : "' + qry.FieldByName('COMPANY').AsString + '",');
                        json.Append('"PersonaContacto" : "' + qry.FieldByName('Nombre').AsString + '"');
                  end;

         json.Append('},');  //end Identificacion
         json.Append('"DatosDireccion" : { ');
              json.Append('"TipoDireccion" : "",');
              json.Append('"Direccion" : "' + qry.FieldByName('DIR_1').AsString + '",');
              json.Append('"Numero" : "",');
              json.Append('"Portal" : "",');
              json.Append('"Bloque" : "",');
              json.Append('"Escalera" : "",');
              json.Append('"Piso" : "",');
              json.Append('"Puerta" : "",');
              json.Append('"Localidad" : "' + qry.FieldByName('POBLACION').AsString + '",');
              json.Append('"Provincia" : "' + qry.FieldByName('PROVINCIA').AsString + '"');
         json.Append('},');  //end DatosDireccion
         json.Append('"DatosDireccion2" : { ');
              json.Append('"TipoDireccion" : "",');
              json.Append('"Direccion" : "",');
              json.Append('"Numero" : "",');
              json.Append('"Portal" : "",');
              json.Append('"Bloque" : "",');
              json.Append('"Escalera" : "",');
              json.Append('"Piso" : "",');
              json.Append('"Puerta" : "",');
              json.Append('"Localidad" : "",');
              json.Append('"Provincia" : ""');
         json.Append('},');  //end DatosDireccion2

         If qry.FieldByName('PAIS_CODE').AsString<>'PT' then
            json.Append('"CP" : "' + qry.FieldByName('CP').AsString + '",')
         else
            json.Append('"CP" : "",');

         json.Append('"ZIP" : "' + qry.FieldByName('CP').AsString + '",');
//         if qry.FieldByName('PAIS').AsString='Spain' then
//             json.Append('"Pais" : "ES",')
//         else
             json.Append('"Pais" : "' + qry.FieldByName('PAIS_CODE').AsString + '",');
         json.Append('"DestinoApartadoPostalInternacional" : "",');
         json.Append('"ApartadoPostalDestino" : "",');
         json.Append('"Telefonocontacto" : "' + qry.FieldByName('TELEFONO').AsString + '",');
         json.Append('"Email" : "' + qry.FieldByName('EMAIL').AsString + '",');
         json.Append('"DatosSMS" : {');
              json.Append('"NumeroSMS" : "' + qry.FieldByName('TELEFONO').AsString + '",');
              json.Append('"Idioma" : "1"');
         json.Append('}');  //end DatosSMS
    json.Append('},');  //end Destinatario

    // ******************************************************** ENVIO
    json.Append('"Envio" : { ');
         json.Append('"NumBulto" : 1,');
         json.Append('"CodProducto" : "' + producto + '",');
         json.Append('"ReferenciaCliente" : "' + qry.FieldByName('ORDER_NAME').AsString + '",');
         json.Append('"ReferenciaCliente2" : "",');
         json.Append('"ReferenciaCliente3" : "",');
         //If qry.FieldByName('PAIS_CODE').AsString = 'ES' then
            json.Append('"TipoFranqueo" : "FP",');
         //else
            //json.Append('"TipoFranqueo" : "ES",');
         json.Append('"NumMaquinaFranquear" : "",');
         json.Append('"ImporteFranqueado" : "",');
         json.Append('"CodPromocion" : "",');
         json.Append('"ModalidadEntrega" : "ST",');
         json.Append('"OficinaElegida" : "",');
         json.Append('"Pesos" : { ');
              json.Append('"Peso" : { ');
                   json.Append('"TipoPeso" : "R",');
                   json.Append('"Valor" : ' + FloatToStr(qry.FieldByName('PESO').AsFloat*1000));
              json.Append('}');  //end Peso
         json.Append('},');  //end Pesos
         json.Append('"Largo" : 1,');
         json.Append('"Alto" : 0,');
         json.Append('"Ancho" : 0,');
         json.Append('"ValoresAnadidos" : { ');
              json.Append('"ImporteSeguro" : "",');
              json.Append('"Reembolso" : { ');
                   json.Append('"TipoReembolso" : "",');
                   json.Append('"Importe" : "",');
                   json.Append('"NumeroCuenta" : "",');
                   json.Append('"TransferAgrupada" : ""');
              json.Append('},'); //end Reembolso
              json.Append('"EntregaExclusivaDestinatario" : "",');
              json.Append('"PruebaEntrega" : { ');
                   json.Append('"Formato" : "",');
                   json.Append('"ReferenciaeAR" : "",');
                   json.Append('"InfRemitenteEAr" : ""');
              json.Append('},'); //end PruebaEntrega
              json.Append('"RecogidaADomicilio" : "",');
              json.Append('"DevolucionAlbaran" : "",');
              json.Append('"RepartoEnSabado" : "",');
              json.Append('"EntregaConcertada" : "",');   //AAAAMMDD
              json.Append('"FranjaHorariaConcertada" : "",');
              json.Append('"EntregaConRecogida" : "",');
              json.Append('"IndImprimirEtiqueta" : "",');
              json.Append('"TextoAdicional" : ""');
         json.Append('},');  //end ValoresAnadidos
         json.Append('"CodigoEmbalajePrepago" : "",');
         json.Append('"CodigoPuntoAdmision" : "",');
         json.Append('"FechaDepositoPrevista" : "",');
         json.Append('"Observaciones1" : "' + qry.FieldByName('COMPANY').AsString + '",');
         //json.Append('"Observaciones1" : "' + qry.FieldByName('ORDER_NAME').AsString + '",');
         json.Append('"Observaciones2" : "' + qry.FieldByName('NOTE').AsString + '",');
         json.Append('"InstruccionesDevolucion" : "D",');
         json.Append('"Documento1" : 0,');
         json.Append('"AccDocumento1" : 0,');
         json.Append('"ObsDocumento1" : "",');
         json.Append('"Documento2" : "",');
         json.Append('"AccDocumento2" : 0,');
         json.Append('"ObsDocumento2" : "",');
         json.Append('"Documento3" : 0,');
         json.Append('"AccDocumento3" :0,');
         json.Append('"ObsDocumento3" : "",');
         json.Append('"Aduana" : { ');
              json.Append('"TipoEnvio" : "",');
              json.Append('"EnvioComercial" : "",');
              json.Append('"FacturaSuperiora500" : "",');
              json.Append('"DUAConCorreos" : "",');
              json.Append('"DescAduanera" : "",');
              json.Append('"Factura" : "",');
              json.Append('"Licencia" : ""');
         json.Append('},');  //end Aduana
         json.Append('"CodigoIda" : "",');        //*****
         json.Append('"PermiteEmbalaje" : "",');
         json.Append('"FechaCaducidad" : "",');
         json.Append('"ReferenciaExpedicion" : "",');
         json.Append('"CodigoHomePaq" : "",');
         json.Append('"ToquenIdCorPaq" : "",');
         json.Append('"AdmisionHomePaq" : "",');
         json.Append('"OperadorPostal" : "",');
         json.Append('"CodigoEnvioOriginal" : ""');
         if li then  //Si tiene logística inversa añadimos los campos solicitados
         begin
             json.Append(',"ExisteEnvioVueltaLI" : "S",');    //Obligatorio
             json.Append('"SeguroLI" : "",');                //Opcional
             json.Append('"ImporteSeguroLI" : "",');         //Opcional
             json.Append('"ReembolsoLI" : "",');             //Opcional
             json.Append('"ImporteReembolsoLI" : "",');      //Opcional
             json.Append('"TipoReembolsoLI" : "",');         //Opcional
             json.Append('"NumeroCuentaLI" : ""');           //Opcional
         end;
    json.Append('},');  //end Envio

    json.Append('"EntregaParcial" : "",');
    json.Append('"CodExpedicion" : ""'); // + qry.FieldByName('ORDER_NAME').AsString + '"');
    json.Append('}'); //end json

    Result := json;
   finally

   end;

end;

function CreaPreRegistroEnvioIdaVuelta(qry:TFIBDataSet):TStringList;        //NO SE USA
var
  json: TStringList;
begin
   try
    json := TStringlist.Create;

    json.Text := '{';

    json.Append('"FechaOperacion" : "' + FormatDateTime('dd-mm-yyyy hh:nn:ss',Now) + '",');
    json.Append('"CodEtiquetador" : "",');
    json.Append('"NumContrato" : "",');
    json.Append('"NumCliente" : "",');
    json.Append('"Care" : "000000",');
    json.Append('"TotalBultos" : 1,');
    json.Append('"ModDevEtiqueta" : 2,');
    // ******************************************************** REMITENTE
    json.Append('"Remitente" : { ');
         json.Append('"Identificacion" : { ');
              json.Append('"Nombre" : "",');
              json.Append('"Apellido1" : "",');
              json.Append('"Apellido2" : "",');
              json.Append('"Nif" : "B123456789",');
              json.Append('"Empresa" : "Flamingos Life",');
              json.Append('"PersonaContacto" : "Almacén Loginser"');
         json.Append('},');  //end Identificacion
         json.Append('"DatosDireccion" : { ');
              json.Append('"TipoDireccion" : "C/",');
              json.Append('"Direccion" : "Poniente",');
              json.Append('"Numero" : "10",');
              json.Append('"Portal" : "",');
              json.Append('"Bloque" : "",');
              json.Append('"Escalera" : "",');
              json.Append('"Piso" : "",');
              json.Append('"Puerta" : "",');
              json.Append('"Localidad" : "Riba-Roja del Túria",');
              json.Append('"Provincia" : "Valencia"');
         json.Append('},');  //end DatosDireccion
         json.Append('"CP" : "46394",');
         json.Append('"Telefonocontacto" : "",');
         json.Append('"Email" : "",');
         json.Append('"DatosSMS" : {');
              json.Append('"NumeroSMS" : "",');
              json.Append('"Idioma" : ""');
         json.Append('}');  //end DatosSMS
    json.Append('},');  //end Remitente

    // ******************************************************** DESTINATARIO
    json.Append('"Destinatario" : { ');
         json.Append('"Identificacion" : { ');
              json.Append('"Nombre" : "' + qry.FieldByName('Nombre').AsString + '",');
              json.Append('"Apellido1" : "",');
              json.Append('"Apellido2" : "",');
              json.Append('"Nif" : "",');
              json.Append('"Empresa" : "",');
              json.Append('"PersonaContacto" : ""');
         json.Append('},');  //end Identificacion
         json.Append('"DatosDireccion" : { ');
              json.Append('"TipoDireccion" : "",');
              json.Append('"Direccion" : "' + qry.FieldByName('DIR_1').AsString + '",');
              json.Append('"Numero" : "",');
              json.Append('"Portal" : "",');
              json.Append('"Bloque" : "",');
              json.Append('"Escalera" : "",');
              json.Append('"Piso" : "",');
              json.Append('"Puerta" : "",');
              json.Append('"Localidad" : "' + qry.FieldByName('POBLACION').AsString + '",');
              json.Append('"Provincia" : "' + qry.FieldByName('PROVINCIA').AsString + '"');
         json.Append('},');  //end DatosDireccion
         json.Append('"DatosDireccion2" : { ');
              json.Append('"TipoDireccion" : "",');
              json.Append('"Direccion" : "",');
              json.Append('"Numero" : "",');
              json.Append('"Portal" : "",');
              json.Append('"Bloque" : "",');
              json.Append('"Escalera" : "",');
              json.Append('"Piso" : "",');
              json.Append('"Puerta" : "",');
              json.Append('"Localidad" : "",');
              json.Append('"Provincia" : ""');
         json.Append('},');  //end DatosDireccion2
         json.Append('"CP" : "' + qry.FieldByName('CP').AsString + '",');
         json.Append('"ZIP" : "",');
         if qry.FieldByName('PAIS').AsString='Spain' then
             json.Append('"Pais" : "ES",')
         else
             json.Append('"Pais" : "' + qry.FieldByName('PAIS').AsString + '",');
         json.Append('"DestinoApartadoPostalInternacional" : "",');
         json.Append('"ApartadoPostalDestino" : "",');
         json.Append('"Telefonocontacto" : "' + qry.FieldByName('TELEFONO').AsString + '",');
         json.Append('"Email" : "' + qry.FieldByName('EMAIL').AsString + '",');
         json.Append('"DatosSMS" : {');
              json.Append('"NumeroSMS" : "' + qry.FieldByName('TELEFONO').AsString + '",');
              json.Append('"Idioma" : "1"');
         json.Append('}');  //end DatosSMS
    json.Append('},');  //end Destinatario

    // ******************************************************** ENVIO
    json.Append('"Envio" : { ');
         json.Append('"NumBulto" : 1,');
         if qry.FieldByName('Pais').AsString='Spain' then  //CodProducto ESTA HECHO PARA FLAMINGOS!!!!!
           json.Append('"CodProducto" : "S0235",')
         else
           json.Append('"CodProducto" : "S0030",');
         json.Append('"ReferenciaCliente" : "' + qry.FieldByName('ORDER_NAME').AsString + '",');
         json.Append('"ReferenciaCliente2" : "",');
         json.Append('"ReferenciaCliente3" : "",');
         json.Append('"TipoFranqueo" : "FP",');
         json.Append('"NumMaquinaFranquear" : "",');
         json.Append('"ImporteFranqueado" : "",');
         json.Append('"CodPromocion" : "",');
         json.Append('"ModalidadEntrega" : "ST",');
         json.Append('"OficinaElegida" : "",');
         json.Append('"Pesos" : { ');
              json.Append('"Peso" : { ');
                   json.Append('"TipoPeso" : "R",');
                   json.Append('"Valor" : 1');
              json.Append('}');  //end Peso
         json.Append('},');  //end Pesos
         json.Append('"Largo" : 0,');
         json.Append('"Alto" : 0,');
         json.Append('"Ancho" : 0,');
         json.Append('"ValoresAnadidos" : { ');
              json.Append('"ImporteSeguro" : "",');
              json.Append('"Reembolso" : { ');
                   json.Append('"TipoReembolso" : "",');
                   json.Append('"Importe" : "",');
                   json.Append('"NumeroCuenta" : "",');
                   json.Append('"TransferAgrupada" : ""');
              json.Append('},'); //end Reembolso
              json.Append('"EntregaExclusivaDestinatario" : "",');
              json.Append('"PruebaEntrega" : { ');
                   json.Append('"Formato" : "",');
                   json.Append('"ReferenciaeAR" : "",');
                   json.Append('"InfRemitenteEAr" : ""');
              json.Append('},'); //end PruebaEntrega
              json.Append('"RecogidaADomicilio" : "",');
              json.Append('"DevolucionAlbaran" : "",');
              json.Append('"RepartoEnSabado" : "",');
              json.Append('"EntregaConcertada" : "",');   //AAAAMMDD
              json.Append('"FranjaHorariaConcertada" : "",');
              json.Append('"EntregaConRecogida" : "",');
              json.Append('"IndImprimirEtiqueta" : "",');
              json.Append('"TextoAdicional" : ""');
         json.Append('},');  //end ValoresAnadidos
         json.Append('"CodigoEmbalajePrepago" : "",');
         json.Append('"CodigoPuntoAdmision" : "",');
         json.Append('"FechaDepositoPrevista" : "",');
         json.Append('"Observaciones1" : "' + qry.FieldByName('COMPANY').AsString + '",');
         json.Append('"Observaciones2" : "' + qry.FieldByName('NOTE').AsString + '",');
         json.Append('"InstruccionesDevolucion" : "",');
         json.Append('"Documento1" : 0,');
         json.Append('"AccDocumento1" : 0,');
         json.Append('"ObsDocumento1" : "",');
         json.Append('"Documento2" : "",');
         json.Append('"AccDocumento2" : 0,');
         json.Append('"ObsDocumento2" : "",');
         json.Append('"Documento3" : 0,');
         json.Append('"AccDocumento3" :0,');
         json.Append('"ObsDocumento3" : "",');
         json.Append('"Aduana" : { ');
              json.Append('"TipoEnvio" : "",');
              json.Append('"EnvioComercial" : "",');
              json.Append('"FacturaSuperiora500" : "",');
              json.Append('"DUAConCorreos" : "",');
              json.Append('"DescAduanera" : "",');
              json.Append('"Factura" : "",');
              json.Append('"Licencia" : ""');
         json.Append('},');  //end Aduana
         json.Append('"CodigoIda" : "",');
         json.Append('"PermiteEmbalaje" : "",');
         json.Append('"FechaCaducidad" : "",');
         json.Append('"ReferenciaExpedicion" : "",');
         json.Append('"CodigoHomePaq" : "",');
         json.Append('"ToquenIdCorPaq" : "",');
         json.Append('"AdmisionHomePaq" : "",');
         json.Append('"OperadorPostal" : "",');
         json.Append('"CodigoEnvioOriginal" : "",');
         json.Append('"ExisteEnvioVueltaLI" : "S",');
         json.Append('"SeguroLI" : "",');
         json.Append('"ImporteSeguroLI" : "",');
         json.Append('"ReembolsoLI" : "",');
         json.Append('"ImporteReembolsoLI" : "",');
         json.Append('"TipoReembolsoLI" : "",');
         json.Append('"NumeroCuentaLI" : ""');
    json.Append('},');  //end Envio

    json.Append('"EntregaParcial" : "",');
    json.Append('"CodExpedicion" : ""'); // + qry.FieldByName('ORDER_NAME').AsString + '"');
    json.Append('}'); //end json

    Result := json;
   finally

   end;

end;

function CreaSolicitudEtiquetaCorreos(fecha:TDateTime; envio:string):TStringList;
var
  json: TStringList;
begin
   try
    json := TStringlist.Create;

    json.Text := '{';

    json.Append('"FechaOperacion" : "' + FormatDateTime('dd-mm-yyyy hh:nn:ss',fecha) + '",');
    json.Append('"CodEtiquetador" : "' + u_main.correos_etiquetador + '",');
    json.Append('"NumContrato" : "' + u_main.correos_contrato + '",');
    json.Append('"NumCliente" : "' + u_main.correos_cliente + '",');
    json.Append('"CodEnvio" : "' + envio + '",');
    json.Append('"Care" : "00000",');
    json.Append('"ModDevEtiqueta" : 2');

    json.Append('}'); //end json

    Result := json;
   finally

   end;
end;



function JSONPostCorreos(op:Integer;text:string):string;
var
  HTTP: TIdHTTP;
  RequestBody: TStream;
  ResponseBody: string;
begin
  HTTP := TIdHTTP.Create;
  try
    try
      //RequestBody := TStringStream.Create('{"FechaOperacion":'25-09-2017 12:00'}', TEncoding.UTF8);
      RequestBody := TStringStream.Create(text, TEncoding.UTF8);
      try
        HTTP.Request.Accept := 'application/json';
        HTTP.Request.ContentType := 'application/json';
        case op of
          0: ResponseBody := HTTP.Post('http://www.loginser.com/sync/Operadores/Correos/ws/ws.registerLI.php', RequestBody);
          1: ResponseBody := HTTP.Post('http://www.loginser.com/sync/Operadores/Correos/ws/ws.register.php', RequestBody);
          2: ResponseBody := HTTP.Post('http://www.loginser.com/sync/Operadores/Correos/ws/ws.request.php', RequestBody);
        end;

        result:= ResponseBody;
      finally
        RequestBody.Free;
      end;
    except
      on E: EIdHTTPProtocolException do
      begin
        showmessage(E.Message);
        showmessage(E.ErrorMessage);
      end;
      on E: Exception do
      begin
        showmessage(E.Message);
      end;
    end;
  finally
    HTTP.Free;
  end;
  //ReadLn;
  ReportMemoryLeaksOnShutdown := True;
end;

end.