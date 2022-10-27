unit u_dmBiocan;

interface

uses
  System.SysUtils, System.Classes, IPPeerClient, REST.Client,
  REST.Authenticator.Basic, Data.Bind.Components, Data.Bind.ObjectScope,
  System.json, Vcl.Dialogs, REST.Types, System.JSON.Readers,
  System.json.types, pFIBDataSet;

type
  TdmBiocan = class(TDataModule)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    auth: THTTPBasicAuthenticator;
  private
    { Private declarations }
    jsbody:TJSONObject;
    procedure GeneraBodyLogin(user,pass:string);
    procedure GeneraBodyEnviaPedido(id_pedido:integer);
    function GetLinkAgencia(id_albaran: string; var exp:string):string;
  public
    { Public declarations }
    function EnviaPedido(url:string; id_pedido,cl_padre: integer; out log:string):string;
    procedure GeneraUrl(url,llamada:string);
    procedure DameRespuesta(var texto:string);

  end;

const
    ln = #13#10;

var
  dmBiocan: TdmBiocan;
  api_url: string;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
    u_dm, u_globals;

procedure TdmBiocan.GeneraBodyLogin(user: string; pass: string);
begin
    jsbody.AddPair('username', user);
    jsbody.AddPair('password', pass);
end;

function TdmBiocan.EnviaPedido(url:string;id_pedido, cl_padre: integer; out log:string):string;
var
  estado:integer;
  texto: string;
begin
    result := '';

    //auth.Password := token;

    jsbody:=TJSONObject.Create();

    GeneraBodyEnviaPedido(id_pedido);
    GeneraUrl(url,'/api/notificacion');

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
            'url=' + RESTClient1.BaseURL;
    jsbody.Free;
end;

procedure TdmBiocan.GeneraBodyEnviaPedido(id_pedido:integer);
var
  jslinea,jsDatoEnvio:TJSONObject;
  jslineas, jsDatosEnvio:TJSONArray;
  link, exp, dir, tlf: string;
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
           dir := '';
           tlf := '';

           link := GetLinkAgencia(FieldByName('codalbaran').AsString,exp);

           jsbody.AddPair('pedidoid',FieldByName('id_pedido').AsString);
           //jsbody.AddPair('fechaenvio',FormatDateTime('yyyymmddhhnnss',FieldByName('fecha_fin').AsDateTime));
           jsbody.AddPair('fechaenvio',FormatDateTime('yyyymmddhhnnss',Now));
           //jsbody.AddPair('trackingnumber',exp);
           jsbody.AddPair('trackingnumber',FieldByName('codalbaran').AsString);
           jsbody.AddPair('estado','E');

           jsDatoEnvio:=TJSONObject.Create();

           jsDatoEnvio.AddPair('nombre',FieldByName('nombre').AsString);

           dir := StringReplace(FieldByName('dir_1').AsString,'/','',[rfReplaceAll]);
           jsDatoEnvio.AddPair('dir1',dir);
           jsDatoEnvio.AddPair('poblacion',FieldByName('poblacion').AsString);
           jsDatoEnvio.AddPair('provincia',FieldByName('provincia').AsString);
           jsDatoEnvio.AddPair('cp',FieldByName('cp').AsString);
           jsDatoEnvio.AddPair('paiscode',FieldByName('pais_code').AsString);
           tlf := StringReplace(FieldByName('telefono').AsString,' ','',[rfReplaceAll]);
           jsDatoEnvio.AddPair('telefono',tlf);
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
                              'where id_pedido=:id_pedido');
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

procedure TdmBiocan.GeneraUrl(url,llamada:string);
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

procedure TdmBiocan.DameRespuesta(var texto:string);
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

function TdmBiocan.GetLinkAgencia(id_albaran: string; var exp:string):string;
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
