unit u_UpdatePedido;

interface

uses
  System.SysUtils, System.Classes, system.types, IPPeerClient, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope,FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,System.json,
  FireDAC.Stan.StorageJSON, REST.Authenticator.Basic,
  pFIBdataset, System.JSON.Readers, System.json.types, REST.Types,
  System.strUtils, Vcl.Dialogs, Vcl.Controls, Datasnap.DBClient;

type
  TdmUpdatePedido = class(TDataModule)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    xPedido: TFDQuery;
    TLocal: TFDTransaction;
    TUpdate: TFDTransaction;
    xBultos: TFDQuery;
    xSigBulto: TFDQuery;
    auth: THTTPBasicAuthenticator;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    jsbody:TJSONObject;
    procedure GeneraUrl(id_pedido: integer);
    procedure GeneraBody(tipo,id_pedido:integer);
    procedure GeneraBodyCabecera(tipo,id_pedido: integer);
    procedure GeneraBodyLines(tipo,id_pedido: integer);
    procedure DameRespuesta(var texto:string);
    procedure DameRespuestaSimple(etiqueta:string; var texto:string);
    procedure GeneraBodyCabeceraOnline;
    procedure GeneraBodyLinesOnline;
  public
    { Public declarations }
    lgs_api_url,lgs_api_user, lgs_api_pass,lgs_api_llamada:string;
    peds_en_cadena: integer;
    function UpdatePedido(tipo,id_pedido:integer; var json,resultado:string):string;
    function PedirArtRelacionado(todos, id_articulo:Integer):Integer;
  end;

var
  dmUpdatePedido: TdmUpdatePedido;


implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses u_main, u_dm, u_detail, u_gen_gl, u_arts_relaciones, u_globals;

{$R *.dfm}

procedure TdmUpdatePedido.DataModuleCreate(Sender: TObject);
begin
   //u_main.ActivaConfigApp;
end;

                                             //0 new, 1 update, 2 encandenado
procedure TdmUpdatePedido.GeneraBodyCabecera(tipo,id_pedido: integer);
var
    datos: TStringDynArray;
begin
   If (tipo<>0) and (tipo<>2) then                 //no es pedido nuevo ni en cadena
     jsbody.AddPair('orderId',        f_detail.ed_id_order.text);

   if (tipo<>2) then              //pedido nuevo o modificado
   begin
     jsbody.AddPair('fechaImp',         FormatDateTime('yyyymmddhhnnss',f_detail.de_fecha_imp.Date));
     jsbody.AddPair('fechaPedido',      FormatDateTime('yyyymmddhhnnss',f_detail.de_fecha_ped.Date));
     jsbody.AddPair('fechaGen',         FormatDateTime('yyyymmddhhnnss',f_detail.de_fecha_gen.Date));
     jsbody.AddPair('fechaFin',         FormatDateTime('yyyymmddhhnnss',f_detail.de_fecha_env.Date));
     jsbody.AddPair('nombreOrder',      f_detail.ed_order_name.text);
     jsbody.AddPair('nombre',           f_detail.ed_nombre.text);
     jsbody.AddPair('dir1',             f_detail.ed_dir_1.text);
     jsbody.AddPair('poblacion',        f_detail.ed_poblacion.Text);
     jsbody.AddPair('provincia',        f_detail.ed_provincia.text);
     jsbody.AddPair('cp',               f_detail.ed_cp.text);
     jsbody.AddPair('pais',             f_detail.edPais.Text);
     jsbody.AddPair('paisCode',         f_detail.edCodPais.Text);
     jsbody.AddPair('telefono',         f_detail.ed_telefono.Text);
     jsbody.AddPair('email',            f_detail.ed_email.Text);
     jsbody.AddPair('company',          f_detail.edCompany.Text);
     jsbody.AddPair('observaciones',    StringReplace(f_detail.ed_obs.Text,'€','e',[]));
     //jsbody.AddPair('observaciones',    f_detail.ed_obs.Text);
     jsbody.AddPair('clienteId',        f_detail.edCliente.Text);
     jsbody.AddPair('ceco',             f_detail.edCeco.Text);
     jsbody.AddPair('refCliente',       f_detail.edRefCliente.Text);
     jsbody.AddPair('delegacionDestino',f_detail.edDeleg.Text);
     jsbody.AddPair('tipoServicioId',   IntToStr(integer(f_detail.cbServicio.Items.Objects[f_detail.cbServicio.ItemIndex])));
     jsbody.AddPair('horarioId',        IntToStr(integer(f_detail.cbHorario.Items.Objects[f_detail.cbHorario.ItemIndex])));
     jsbody.AddPair('bultos',           f_detail.ed_bultos.text);
     jsbody.AddPair('peso',             StringReplace(f_detail.edKgs.text,',','.',[]));
     jsbody.AddPair('codAlbaran',       f_detail.ed_codalbaran.text);
     jsbody.AddPair('estado',           f_detail.cb_estado.Text[1]);
     jsbody.AddPair('transporte',       IntToStr(f_detail.rgTransporte.ItemIndex));
     jsbody.AddPair('repartidorId',     IntToStr(f_detail.cb_repartidor.ItemIndex));
     jsbody.AddPair('contacto',         f_detail.edContacto.text);
     jsbody.AddPair('reembolso',        StringReplace(f_detail.edReembolso.text,',','.',[]));
     If f_detail.chRetorno.Checked then
        jsbody.AddPair('retorno',          '1')
     else
        jsbody.AddPair('retorno',          '0');

     {if StrToIntDef(f_detail.cb_delivery.Text, -1)=-1 then
            jsbody.AddPair('deliveryTime', '-1')
        else
            jsbody.AddPair('deliveryTime', f_detail.cb_delivery.Text);

     jsbody.AddPair('deliveryTimeText',    f_detail.cb_delivery.Text); }

     jsbody.AddPair('text',             f_detail.ed_text.text);
   end else begin       //pedido en cadena
              with TpFIBDataSet.Create(self) do
              try
                Database:=dm.db;
                SQLs.SelectSQL.Clear;
                sqls.SelectSQL.Add('select * from get_clientes_config(:id_cliente)');
                ParamByName('id_cliente').AsInteger := peds_en_cadena;
                Open;
                First;

                //if not IsEmpty then
               // begin
                   //jsbody.AddPair('nombreOrder',      datos[0]);
                   jsbody.AddPair('clienteId',      IntToStr(peds_en_cadena));
                   jsbody.AddPair('nombre',         FieldByName('nombre').AsString);
                   jsbody.AddPair('dir1',           FieldByName('direccion').AsString);
                   jsbody.AddPair('poblacion',      FieldByName('poblacion').AsString);
                   jsbody.AddPair('provincia',      FieldByName('provincia').AsString);
                   jsbody.AddPair('cp',             FieldByName('cp').AsString);
                   jsbody.AddPair('pais',           FieldByName('pais').AsString);
                   jsbody.AddPair('paisCode',       FieldByName('pais_code').AsString);
                   jsbody.AddPair('telefono',       FieldByName('telefono').AsString);
                   jsbody.AddPair('email',          FieldByName('email').AsString);
                   jsbody.AddPair('tipoServicioId', FieldByName('servicio').AsString);
                   jsbody.AddPair('horarioId',      FieldByName('horario').AsString);
                   jsbody.AddPair('bultos',         '1');
                   jsbody.AddPair('estado',         'P');
                   jsbody.AddPair('text',           FieldByName('prefijo_peds_enc').AsString+IntToStr(id_pedido));
                //end;

              finally
                free;
              end;
            end;

   jsbody.AddPair('origenWeb',        '1');
end;

procedure TdmUpdatePedido.GeneraBodyLines(tipo,id_pedido: integer);
var
  jslinea:TJSONObject;
  jslineas:TJSONArray;
  linea, art_relacionado, i: Integer;
  arts_relacionados : TStringDynArray;
  codigo: string;
begin
   jslineas:=TJSONArray.Create();

   if (tipo=0) or (tipo=1) then
   begin
     with f_detail.cdsLines do
     begin
        if not isempty then
        begin
          linea := FieldByName('linea').AsInteger;

          DisableControls;
          First;

          while not EOF do
          begin
             jslinea:=TJSONObject.Create();
             jslinea.AddPair('articuloId',fieldByName('id_articulo').AsString);
             jslinea.AddPair('cantidad',fieldByName('cantidad').AsString);
             jslinea.AddPair('kgs',StringReplace(fieldByName('kgs').AsString,',','.',[]));
             jslinea.AddPair('nombreArticulo',fieldByName('nombre').AsString);
             jslinea.AddPair('imeiId',fieldByName('imei').AsString);
             jslinea.AddPair('sku',fieldByName('sku').AsString);
             ///jslinea.AddPair('nserie',fieldByName('n_serie').AsString); ??????

             jslineas.Add(jslinea);
             Next;
          end;

          Locate('linea',linea,[]);
          EnableControls;
        end;
     end;
   end else begin        //tipo 2, encadenado
                with TpFIBDataSet.Create(self) do
                try
                  Database:=dm.db;
                  sqls.SelectSQL.Add('select l.id_articulo, ar.nombre, ar.kgs, sum(l.cantidad) as uds ' +
                    'from c_pedidos_lines l ' +
                    ' inner join g_articulos ar on ar.id_articulo=l.id_articulo ' +
                    'where l.id_pedido=:id_pedido and l.cantidad>0 ' +
                    'group by l.id_articulo, ar.nombre, ar.kgs');
                  parambyname('id_pedido').AsInteger:=id_pedido;
                  Open;

                  first;

                  while not Eof do
                  begin
                     if f_main.get_stock_x_art(FieldByName('id_articulo').AsInteger)<=0 then
                     begin
                       arts_relacionados := SplitString(ArtsRelacionados(FieldByName('id_articulo').AsInteger),'#');

                       if ((High(arts_relacionados)<0) or
                          ((High(arts_relacionados)>=0) and
                           (MyMessageDialog('Existe/n ' + IntToStr(High(arts_relacionados)+1) + ' artículo/s relacionado/s.' + #10#13 +
                                          '¿Desea insertar o modificar las relaciones?', mtConfirmation, mbOKCancel,
                                          ['Insertar', 'Modificar']) = mrCancel))) then
                       begin

                           dm.q_arts_relacionados.Close;
                           dm.q_arts_relacionados.ParamByName('id_articulo').AsInteger := FieldByName('id_articulo').AsInteger;
                           dm.q_arts_relacionados.Open;

                        u_arts_relaciones.id_articulo := FieldByName('id_articulo').AsInteger;
                        f_arts_relaciones.lbArtRel.Caption := FieldByName('nombre').AsString;
                        f_arts_relaciones.ShowModal;

                        arts_relacionados := SplitString(ArtsRelacionados(FieldByName('id_articulo').AsInteger),'#');
                       end;


                       for i := 0 to High(arts_relacionados) do
                       begin
                          jslinea:=TJSONObject.Create();
                          jslinea.AddPair('articuloId',arts_relacionados[0]);
                          jslinea.AddPair('cantidad','1');
                          //jslinea.AddPair('kgs',StringReplace(fieldByName('kgs').AsString,',','.',[]));
                          jslinea.AddPair('nombreArticulo', BuscaArticulo(StrToInt(arts_relacionados[i]),codigo));
                          jslinea.AddPair('sku', codigo);
                          jslinea.AddPair('imeiId','');

                          jslineas.Add(jslinea);
                       end;
                     end;

                     Next;
                  end;
                finally
                   //
                end;

                end;

   jsbody.addPair('pedidoLineCreations', jslineas);

   //jslineas.free;
   //jslinea.Free;
end;

procedure TdmUpdatePedido.GeneraBodyCabeceraOnline;
           { fechaImp,fechaPedido,nombreOrder,nombre,dir1,poblacion,provincia,cp,pais,paisCode,telefono,email,
            company,observaciones,clienteId,ceco,refCliente,delegDst,tipoServ,horario,bultos,peso,codAlb,estado,
            transporte,repartidor,contacto,reembolso:string}
begin
     jsbody.AddPair('fechaImp',         u_main.PedCab.fechaImp);
     jsbody.AddPair('fechaPedido',      u_main.PedCab.fechaPedido);
     jsbody.AddPair('nombreOrder',      u_main.PedCab.nombreOrder);
     jsbody.AddPair('nombre',           u_main.PedCab.nombre);
     jsbody.AddPair('dir1',             u_main.PedCab.dir1);
     jsbody.AddPair('poblacion',        u_main.PedCab.poblacion);
     jsbody.AddPair('provincia',        u_main.PedCab.provincia);
     jsbody.AddPair('cp',               u_main.PedCab.cp);
     jsbody.AddPair('pais',             u_main.PedCab.pais);
     jsbody.AddPair('paisCode',         u_main.PedCab.paisCode);
     jsbody.AddPair('telefono',         u_main.PedCab.telefono);
     jsbody.AddPair('email',            u_main.PedCab.email);
     jsbody.AddPair('company',          u_main.PedCab.company);
     jsbody.AddPair('observaciones',    u_main.PedCab.observaciones);
     jsbody.AddPair('clienteId',        u_main.PedCab.clienteId);
     jsbody.AddPair('ceco',             u_main.PedCab.ceco);
     jsbody.AddPair('refCliente',       u_main.PedCab.refCliente);
     jsbody.AddPair('delegacionDestino',u_main.PedCab.delegDst);
     jsbody.AddPair('tipoServicioId',   u_main.PedCab.tipoServ);
     jsbody.AddPair('horarioId',        u_main.PedCab.horario);
     jsbody.AddPair('bultos',           u_main.PedCab.bultos);
     jsbody.AddPair('peso',             u_main.PedCab.peso);
     jsbody.AddPair('codAlbaran',       u_main.PedCab.codAlb);
     //jsbody.AddPair('estado',           u_main.PedCab.estado);
     jsbody.AddPair('transporte',       u_main.PedCab.transporte);
     jsbody.AddPair('repartidorId',     u_main.PedCab.repartidor);
     jsbody.AddPair('contacto',         u_main.PedCab.contacto);
     jsbody.AddPair('reembolso',        u_main.PedCab.reembolso);
     jsbody.AddPair('origenWeb',        '1');
     jsbody.AddPair('estado',           'P');
     jsbody.AddPair('text',             u_main.PedCab.remitente);

end;


procedure TdmUpdatePedido.GeneraBodyLinesOnline;
var
  jslinea:TJSONObject;
  jslineas:TJSONArray;
  i: Integer;
begin
   jslineas:=TJSONArray.Create();

   for i := 0 to Length(u_main.PedLines)-1 do
   begin
       if (u_main.PedLines[i].id_articulo>0) then
       begin
           jslinea:=TJSONObject.Create();
           jslinea.AddPair('articuloId',IntToStr(u_main.PedLines[i].id_articulo));
           jslinea.AddPair('cantidad',IntToStr(u_main.PedLines[i].cantidad));
           //jslinea.AddPair('kgs',StringReplace(fieldByName('kgs').AsString,',','.',[]));
           jslinea.AddPair('nombreArticulo',u_main.PedLines[i].nombre_art);
           jslinea.AddPair('imeiId','');
           jslinea.AddPair('sku',u_main.PedLines[i].sku);

           jslineas.Add(jslinea);
       end;
   end;


   jsbody.addPair('pedidoLineCreations', jslineas);

   //jslineas.free;
   //jslinea.Free;
end;

function TdmUpdatePedido.PedirArtRelacionado(todos, id_articulo:Integer):Integer;
begin
   u_arts_relaciones.todos := todos;
   u_arts_relaciones.id_articulo := id_articulo;
   f_arts_relaciones.Showmodal;

   result := u_arts_relaciones.id_art_relacionado;
end;


procedure TdmUpdatePedido.GeneraBody(tipo,id_pedido: integer);
begin

   if tipo=3 then
   begin
      GeneraBodyCabeceraOnline;
      GeneraBodyLinesOnline;
   end else begin
       GeneraBodyCabecera(tipo,id_pedido);
       GeneraBodyLines(tipo,id_pedido);
   end;
end;

                                      //0 new, 1 update, 2 encandenado, 3 online (no están los datos en form, vienen de ftp, fichero, ...)
function TdmUpdatePedido.UpdatePedido(tipo,id_pedido: integer; var json,resultado:string):string;
var
  estado:integer;
  texto: string;
  F: TextFile;
begin
    result := '';

    jsbody:=TJSONObject.Create();

    try
      GeneraBody(tipo,id_pedido);
      if tipo<>1 then
        GeneraUrl(0)
      else
        GeneraUrl(id_pedido);

       json := jsbody.ToString;

      {ShowMessage('ini guarda json');
        if True then

        AssignFile( F, 'c:\lgs\json.txt' );
        Rewrite( F );
        WriteLn( F, json );
        CloseFile( F );
        ShowMessage('fin guarda json'); }

       RESTRequest1.ClearBody;
       RESTRequest1.addbody(jsbody);
       RESTRequest1.Timeout:=20000;
       //ShowMessage('ini execute api');
       RESTRequest1.Execute;
       //ShowMessage('fin execute api');
       estado:=RESTResponse1.StatusCode;
       //ShowMessage('devuelto ' + IntToStr(estado));
       if (estado<>200) and (estado<>201) then
       begin
         if id_pedido=0 then
              //showmessage('Han ocurrido errores al crear el pedido ' + IntToStr(id_pedido) + '. ' + RESTResponse1.Content)
              resultado := 'Han ocurrido errores al crear el pedido ' + IntToStr(id_pedido) + '. ' + RESTResponse1.Content
         else if id_pedido=-1 then
                  //showmessage('Han ocurrido errores al crear pedido encadenado. ' + RESTResponse1.Content)
                  resultado := 'Han ocurrido errores al crear pedido encadenado. ' + RESTResponse1.Content
              else
                    //showmessage('Han ocurrido errores al guardar el pedido ' + IntToStr(id_pedido) + '. ' + RESTResponse1.Content);
                    resultado := 'Han ocurrido errores al guardar el pedido ' + IntToStr(id_pedido) + '. ' + RESTResponse1.Content;
       end
       else
       begin
         DameRespuesta(texto);
         Result := texto;

         if (tipo<>3) then
         begin
            if (tipo=0) or (tipo=2) then
            begin
                DameRespuesta(texto);

                Result := texto;

                if id_pedido=0 then
                     //showmessage('Pedido creado correctamente.')
                     resultado := 'Pedido creado correctamente.'
                else begin
                     //showmessage('Pedido encadenado creado correctamente.');
                     resultado := 'Pedido encadenado creado correctamente.';
                end;
            end else
                        //showmessage('Pedido guardado correctamente.');
                        resultado := 'Pedido guardado correctamente.';
          end;

       end;
    except on e:Exception do begin
      if id_pedido=0 then
              //showmessage('Han ocurrido errores al crear el pedido ' + IntToStr(id_pedido) + '. ' + RESTResponse1.Content)
              resultado := 'Error al crear el pedido ' + IntToStr(id_pedido) + '. ' + e.message
         else if id_pedido=-1 then
                  //showmessage('Han ocurrido errores al crear pedido encadenado. ' + RESTResponse1.Content)
                  resultado := 'Error al crear pedido encadenado. ' + e.message
              else
                    //showmessage('Han ocurrido errores al guardar el pedido ' + IntToStr(id_pedido) + '. ' + RESTResponse1.Content);
                    resultado := 'Error al guardar el pedido ' + IntToStr(id_pedido) + '. ' + e.message;
     end;
    end;

    jsbody.Free;

end;

procedure TdmUpdatePedido.GeneraUrl(id_pedido:integer);
var
  BaseUrl:string;
begin
  if ((lgs_api_url='') or (lgs_api_llamada='')) then
        BaseUrl := 'https://server.loginser.com/loginser-back/api/pedido'
  else
        BaseUrl := lgs_api_url + lgs_api_pedido;

  if id_pedido=0 then
  begin
     //BaseURL:='https://server.loginser.com/loginser-back/api/pedido';
     RESTRequest1.Method := rmPOST;
  end
  else begin
     BaseURL:= BaseUrl + '/' + inttostr(id_pedido);
     RESTRequest1.Method := rmPUT;
  end;
  RESTClient1.BaseURL:=BaseUrl;
end;


procedure TdmUpdatePedido.DameRespuesta(var texto:string);
var
  Sr: TStringReader;
  Reader: TJsonTextReader;
begin
  texto:='';
  if restResponse1.Content<>'' then
  begin
      Sr := TStringReader.Create(restResponse1.Content);
      Reader := TJsonTextReader.Create(Sr);
      while reader.read do
      begin
       case Reader.TokenType of
        TJsonToken.String: begin
          if Reader.Path='orderId' then
             texto:=Reader.Value.ToString;
       end
      end;
     end;
     reader.Free;
     sr.Free;
  end;

end;

procedure TdmUpdatePedido.DameRespuestaSimple(etiqueta:string; var texto:string);
var
  respuesta: TJsonValue;

begin

   if restResponse1.Content<>'' then
  begin

  end;
end;

end.
