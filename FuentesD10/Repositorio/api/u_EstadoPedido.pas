unit u_EstadoPedido;

interface

uses
  System.SysUtils, System.Classes, IPPeerClient, REST.Client,
  REST.Authenticator.Basic, Data.Bind.Components, Data.Bind.ObjectScope,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.Json, REST.Types;

type
  TdmEstadoPedido = class(TDataModule)
    RESTClient1: TRESTClient;
    RESTResponse1: TRESTResponse;
    RESTRequest1: TRESTRequest;
    auth: THTTPBasicAuthenticator;
    TLocal: TFDTransaction;
    TUpdate: TFDTransaction;
    xPedido: TFDQuery;
  private
    { Private declarations }
    jsbody:TJSONObject;
    procedure GeneraUrl(id_pedido, api_https:string);
    {procedure GeneraBody(tipo,id_pedido:integer);
    procedure GeneraBodyCabecera(tipo,id_pedido: integer);
    procedure GeneraBodyLines(tipo,id_pedido: integer);
    procedure DameRespuesta(var texto:string);
    procedure DameRespuestaSimple(etiqueta:string; var texto:string);
    procedure GeneraBodyCabeceraOnline;
    procedure GeneraBodyLinesOnline;
    }
  public
    { Public declarations }
    lgs_api_url,lgs_api_user, lgs_api_pass,lgs_api_llamada:string;
    function EstadoPedido(id_pedido:integer):string;

  end;

var
  dmEstadoPedido: TdmEstadoPedido;


implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TdmEstadoPedido.EstadoPedido(id_pedido: integer):string;
begin
    result := '';

    jsbody:=TJSONObject.Create();

    try
       //GeneraBody(tipo,id_pedido);

       GeneraUrl(IntToStr(id_pedido),lgs_api_url+lgs_api_llamada);

       RESTRequest1.ClearBody;
       RESTRequest1.addbody(jsbody);
       RESTRequest1.Timeout:=20000;
       //ShowMessage('ini execute api');
       RESTRequest1.Execute;
       //ShowMessage('fin execute api');
       result := 'Ok ' + IntToStr(id_pedido);
    except on E:Exception do
      result := 'Error ' + IntToStr(id_pedido) + ' ' + E.Message;
    end;

    jsbody.Free;

end;

procedure TdmEstadoPedido.GeneraUrl(id_pedido,api_https:string);
var
  BaseUrl:string;
begin
  if api_https='' then
        BaseUrl := 'https://servertest.loginser.com:5443/loginser-back/api/pedido/((id_pedido))/pedido-updated'
  else
        BaseUrl := api_https;

  BaseURL := StringReplace(BaseUrl,'((id_pedido))',id_pedido,[]);
  RESTRequest1.Method := rmPUT;

  RESTClient1.BaseURL:=BaseUrl;
end;

end.
