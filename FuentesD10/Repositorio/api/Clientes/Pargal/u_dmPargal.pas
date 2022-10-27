unit u_dmPargal;

interface

uses
  System.SysUtils, System.Classes, IPPeerClient, REST.Client,
  REST.Authenticator.Basic, Data.Bind.Components, Data.Bind.ObjectScope,
  System.json, Vcl.Dialogs, REST.Types, System.JSON.Readers,
  System.json.types, pFIBDataSet;

type
  TdmPargal = class(TDataModule)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    auth: THTTPBasicAuthenticator;
  private
    { Private declarations }
    jsbody:TJSONObject;
    procedure GeneraBodyLogin(user,pass:string);
    procedure GeneraBodyEnviaPedido(id_pedido, id_cliente:integer);
    function GetLinkAgencia(id_albaran: string; var exp:string):string;
  public
    { Public declarations }
    function Login(url,user,pass:string):string;
    function EnviaPedido(token,url:string; id_pedido,cl_padre: integer; out log:string):string;
    procedure GeneraUrl(url,llamada:string);
    procedure DameRespuesta(var texto:string);

  end;

const
    ln = #13#10;

var
  dmPargal: TdmPargal;
  api_url: string;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
    u_dm, u_globals;

function TdmPargal.Login(url,user,pass:string):string;
var
  estado:integer;
  texto: string;
begin
    result := '';

    jsbody:=TJSONObject.Create();

    try
      GeneraBodyLogin(user,pass);
      GeneraUrl(url,'login');

      if RESTClient1.BaseURL<>'' then
      begin
         RESTRequest1.ClearBody;
         RESTRequest1.addbody(jsbody);
         RESTRequest1.Timeout:=20000;
         RESTRequest1.Execute;
         estado:=RESTResponse1.StatusCode;
         if (estado<>200) and (estado<>201) then
         begin
           showmessage('Han ocurrido errores al conectar con API Pargal. ' + RESTResponse1.Content);
         end
         else
         begin
           DameRespuesta(texto);
           Result := texto;
         end;
      end else
          begin
              begin
                ShowMessage('Error en URL destino.');
                result := '';
              end
          end;
    except
      //
    end;

    jsbody.Free;

end;

procedure TdmPargal.GeneraBodyLogin(user: string; pass: string);
begin
    jsbody.AddPair('username', user);
    jsbody.AddPair('password', pass);
end;

function TdmPargal.EnviaPedido(token,url:string;id_pedido, cl_padre: integer; out log:string):string;
var
  estado:integer;
  texto: string;
begin
    result := '';

    //auth.Password := token;

    jsbody:=TJSONObject.Create();

    GeneraBodyEnviaPedido(id_pedido, cl_padre);
    GeneraUrl(url,'pedidos');

     //RESTClient1.SetHTTPHeader('AuthToken',token);
     //RESTRequest1.Params.AddItem('Headers', 'AuthToken='+token, pkHTTPHEADER, [poDoNotEncode]);
     RESTRequest1.Params.AddItem('AuthToken', token,
      TRESTRequestParameterKind.pkHTTPHEADER, [poAutoCreated]);
     RESTRequest1.ClearBody;
     RESTRequest1.addbody(jsbody);
     RESTRequest1.Timeout:=20000;
     RESTRequest1.Execute;
     estado:=RESTResponse1.StatusCode;
     DameRespuesta(texto);
     {if (estado<>200) and (estado<>201) then
     begin
       result := texto + '. (' + IntToStr(estado) + ')' + RESTResponse1.Content;
     end
     else
     begin
       Result := texto + '(' + IntToStr(estado) + ')';
     end;  }

     Result := texto + ' (' + IntToStr(estado) + ')';

     log := 'response=' + result + '|' +
            FormatDateTime('dd.mm.yyyy hh:mm',now) + '|' +
            'body=' + jsbody.ToString + '|' +
            'url=' + RESTClient1.BaseURL + '|' +
            'Token=' + token;
    jsbody.Free;
end;

procedure TdmPargal.GeneraBodyEnviaPedido(id_pedido, id_cliente:integer);
var
  jslinea,jsDatoEnvio:TJSONObject;
  jslineas, jsDatosEnvio:TJSONArray;
  link, exp: string;
begin
   jslineas:=TJSONArray.Create();


    with TpFIBDataSet.Create(self) do
    try
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select * from c_pedidos where id_pedido=:id_pedido');
      ParamByName('id_pedido').AsInteger := id_pedido;
      Open;
      First;

      if not IsEmpty then
      begin
           link := GetLinkAgencia(FieldByName('codalbaran').AsString,exp);

           jsbody.AddPair('clienteID',FieldByName('id_cliente').AsString);
           jsbody.AddPair('pedidoid',FieldByName('id_pedido').AsString);
           jsbody.AddPair('fechapedido',FormatDateTime('yyyymmddhhnnss',FieldByName('fecha_ped').AsDateTime));
           //jsbody.AddPair('fechaenvio',FormatDateTime('yyyymmddhhnnss',FieldByName('fecha_fin').AsDateTime));
           jsbody.AddPair('fechaenvio',FormatDateTime('yyyymmddhhnnss',Now));
           //jsbody.AddPair('trackingnumber',exp);
           jsbody.AddPair('trackingnumber',FieldByName('codalbaran').AsString);
           jsbody.AddPair('estado',FieldByName('estado').AsString);

           jsDatoEnvio:=TJSONObject.Create();

           jsDatoEnvio.AddPair('nombre',FieldByName('nombre').AsString);
           jsDatoEnvio.AddPair('dir1',FieldByName('dir_1').AsString);
           jsDatoEnvio.AddPair('poblacion',FieldByName('poblacion').AsString);
           jsDatoEnvio.AddPair('provincia',FieldByName('provincia').AsString);
           jsDatoEnvio.AddPair('cp',FieldByName('cp').AsString);
           jsDatoEnvio.AddPair('paiscode',FieldByName('pais_code').AsString);
           jsDatoEnvio.AddPair('provincia',FieldByName('provincia').AsString);
           jsDatoEnvio.AddPair('telefono',FieldByName('telefono').AsString);
           jsDatoEnvio.AddPair('email',FieldByName('email').AsString);
           jsDatoEnvio.AddPair('observaciones',FieldByName('observaciones').AsString);
           jsDatoEnvio.AddPair('urltracking',link);

           jsbody.addPair('datosenvio', jsDatoEnvio);

           jslineas:=TJSONArray.Create();

           //Lineas con lote
           Close;
           SQLs.SelectSQL.Clear;
           sqls.SelectSQL.Add('select ar.codigo_cli,ll.cantidad, lt.nombre, lt.caducidad ' +
                              'from c_pedidos_lines_lotes ll ' +
                              'inner join g_articulos ar on ar.id_articulo=ll.id_articulo ' +
                              'inner join a_lotes lt on lt.id_lote=ll.id_lote ' +
                              'where id_pedido=:id_pedido '
                                {and ar.codigo in (' +
                                'select ar2.codigo from g_articulos ar2 ' +
                                'where ar2.codigo=ar.codigo and ' +
                                'ar2.id_cliente=:id_cliente)' }
                              );
           ParamByName('id_pedido').AsInteger := id_pedido;
           //ParamByName('id_cliente').AsInteger := id_cliente;
           Open;
           First;

           if not IsEmpty then
           begin
             while not eof do
             begin
                     jslinea:=TJSONObject.Create();
                     jslinea.AddPair('referencia',FieldByName('codigo_cli').AsString);
                     jslinea.AddPair('unidades',FieldByName('cantidad').AsString);
                     jslinea.AddPair('loteproductofinal',FieldByName('nombre').AsString);
                     jslinea.AddPair('caducidad',FormatDateTime('yyyymmdd',FieldByName('caducidad').AsDateTime));

                     jslineas.Add(jslinea);
                     Next;
             end;
           end;

           //Lineas sin lote
                 Close;
                 SQLs.SelectSQL.Clear;
                 sqls.SelectSQL.Add('select ar.codigo_cli,l.cantidad ' +
                                    'from c_pedidos_lines l ' +
                                    'left outer join c_pedidos_lines_lotes ll on ll.id_pedido=l.id_pedido and l.id_articulo=ll.id_articulo ' +
                                    'inner join g_articulos ar on ar.id_articulo=l.id_articulo ' +
                                    'where l.id_pedido=:id_pedido and ll.id_lote is null ');
                 ParamByName('id_pedido').AsInteger := id_pedido;
                 Open;
                 First;

                 if not IsEmpty then
                 begin
                   while not eof do
                   begin
                           jslinea:=TJSONObject.Create();
                           jslinea.AddPair('referencia',FieldByName('codigo_cli').AsString);
                           jslinea.AddPair('unidades',FieldByName('cantidad').AsString);
                           jslinea.AddPair('loteproductofinal','SIN LOTE');
                           jslinea.AddPair('caducidad','');

                           jslineas.Add(jslinea);
                           Next;
                   end;
                 end;

                jsbody.addPair('lineas', jslineas);
      end;

    finally
      free;
    end;
end;

procedure TdmPargal.GeneraUrl(url,llamada:string);
var
  BaseUrl:string;
begin
  if url<>'' then
     begin
        BaseUrl := url + llamada;
     end
     else
          BaseUrl := '';

  RESTRequest1.Method := rmPOST;
  RESTClient1.BaseURL:=BaseUrl;
end;

procedure TdmPargal.DameRespuesta(var texto:string);
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
          if Reader.Path='AuthToken' then
             texto:=Reader.Value.ToString;
          if Reader.Path='msg' then
             texto:=Reader.Value.ToString;
       end
      end;
     end;
     reader.Free;
     sr.Free;
  end;

end;

function TdmPargal.GetLinkAgencia(id_albaran: string; var exp:string):string;
begin
  with TpFIBDataSet.Create(self) do
    try
      Database:=dm.db;
      SQLs.SelectSQL.Clear;
      sqls.SelectSQL.Add('select * from get_link_agencia(' + id_albaran + ')');
      Open;
      First;

      if not IsEmpty then
      begin
        Result := FieldByName('link').AsString;
        exp := FieldByName('exp').AsString;
      end else begin
                  Result := '';
                  exp := '';
                end


    finally
      free;
    end;
end;
end.
