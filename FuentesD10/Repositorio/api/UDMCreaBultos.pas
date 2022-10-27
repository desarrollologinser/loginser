unit UDMCreaBultos;

interface

uses
  System.SysUtils, System.Classes, IPPeerClient, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope,Dialogs, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,System.json,
  FireDAC.Stan.StorageJSON, REST.Authenticator.Basic;

type
  TDMCreaBultos = class(TDataModule)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    xAlbaran: TFDQuery;
    TLocal: TFDTransaction;
    TUpdate: TFDTransaction;
    xBultos: TFDQuery;
    auth: THTTPBasicAuthenticator;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    jsbody:TJSONObject;
    procedure GeneraUrl(id_albaran: integer);
    procedure GeneraUrlValidate(id_albaran: integer);

    procedure GeneraBody(id_albaran,id_destino,bultos:integer);
    function Num_bulto(id_albaran:integer):integer;
    procedure GeneraBodyUnBulto(id_albaran, id_destino, bultos: integer;peso,referencia,x,y,z,m3:String);

  public
    { Public declarations }
    procedure DameBultos(id_albaran,id_destino:integer; var bultos_alb:integer; var bultos_eti:integer);
    procedure GeneraBultos(id_albaran,id_Destino:integer);
    procedure GeneraBulto(id_albaran, id_destino: integer;peso,referencia,x,y,z,m3:String);
    procedure RegeneraBultos(id_albaran: integer);
    // Procesos de back-ground:
    procedure GeneraBultosBack(const id_albaran,id_destino, Bultos_Genera: integer; var Error:String);
    procedure RegeneraBultosBack(const id_albaran,total_bultos: integer; var Error:String);
  end;

var
  DMCreaBultos: TDMCreaBultos;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses u_main, u_dm, u_globals;

{$R *.dfm}

procedure TDMCreaBultos.DameBultos(id_albaran,id_destino: integer; var bultos_alb,
  bultos_eti: integer);
begin
   with dm.xAlbaran do
   begin
     close;
       Parambyname('id_albaran').AsInteger:=id_albaran;
     open;
   end;
   with dm.xBultos do
   begin
     close;
       Parambyname('id_albaran').AsInteger:=id_albaran;
     open;
   end;
   bultos_alb:=dm.xAlbaran.FieldByName('bultos').AsInteger;
   bultos_eti:=dm.xBultos.FieldByName('bultos').AsInteger;
end;

procedure TDMCreaBultos.DataModuleCreate(Sender: TObject);
begin
   //u_main.ActivaConfigApp;
end;

procedure TDMCreaBultos.GeneraBody(id_albaran,id_destino, bultos: integer);
var cont_bulto,i:integer;
  jsbulto:TJSONObject;
  jsbultos:TJSONArray;
begin
   cont_bulto:=Num_bulto(id_albaran);

   jsbody:=TJSONObject.Create();
   jsbultos:= TJSONArray.Create;

   for I := 1 to bultos do    //generamos los bultos que faltan
   begin
     jsbulto:=TJSONObject.Create();
     jsbulto.AddPair('numBulto',inttostr(cont_bulto));
     jsbulto.AddPair('peso','1');
     jsbulto.AddPair('referencia','null');
     jsbulto.AddPair('codBarras','null');
     jsbulto.AddPair('estadoId','0');
     jsbulto.AddPair('m3','0');
     jsbulto.AddPair('x','null');
     jsbulto.AddPair('y','null');
     jsbulto.AddPair('z','null');
     jsbulto.AddPair('albaranDestId',inttostr(id_destino));

     jsbultos.Add(jsbulto);
    // jsbulto.Free;
     inc(cont_bulto);
   end;

//   jsbody.addPair(TJSONPair.Create('bultos', jsbultos));
   jsbody.addPair('bultos', jsbultos);


//   jsbulto.Free;
//   jsbultos.free;
end;

procedure TDMCreaBultos.GeneraBultos(id_albaran,id_destino: integer);
var
  i,estado:integer;
  bultos_alb,bultos_eti:integer;
begin
  //showmessage ('voy a pedir bultos');
  DameBultos(id_albaran,id_destino,bultos_alb,bultos_eti);
  //showmessage (' bultos alb=' + inttostr(bultos_alb) + ' bultos eti=' + inttostr(bultos_eti));
  //si faltan etiquetas o bultos por crear, los generamos
  if bultos_alb>bultos_eti then
  begin
   //showmessage ('voy a generar bultos');
    GeneraBody(id_albaran,id_destino,(bultos_alb-bultos_eti));
    GeneraUrl(id_albaran);
    try
       RESTRequest1.ClearBody;
       RESTRequest1.addbody(jsbody);

      // showmessage (jsbody.tostring);

       RESTRequest1.Timeout:=20000;
       try
       RESTRequest1.Execute;
       except on E:Exception do
              ShowMessage(e.Message);
       end;
       estado:=RESTResponse1.StatusCode;

       //showmessage (IntToStr(estado));
       //GuardaLogApi(rentorno.Nombre, RESTClient1.BaseURL,inttostr(estado),RESTResponse1.StatusText,now);
       if estado<>200 then
       begin
         showmessage('Han ocurrido errores al generar los bultos');
       end
       else
       begin
            //
       end;
    except
       //
    end;
    jsbody.Free;
  end
  else begin
    //showmessage ('voy a regenerar bultos');
    RegeneraBultos(id_albaran);
  end;
end;

procedure TDMCreaBultos.GeneraUrl(id_albaran:integer);
var
  BaseUrl:string;
begin
  if api='' then
     begin
        BaseUrl := 'https://server.loginser.com/loginser-back/api/';
     end
     else
        BaseUrl := api;

  BaseURL:= BaseUrl + 'albaran/'+inttostr(id_albaran)+'/bulto';
  RESTClient1.BaseURL:=BaseUrl;
  //ShowMessage(RESTClient1.BaseURL);
end;


procedure TDMCreaBultos.GeneraUrlValidate(id_albaran:integer);
var
  BaseUrl:string;
begin
    if api='' then
     begin
        BaseUrl := 'https://server.loginser.com/loginser-back/api/';
     end
     else
        BaseUrl := api;

  BaseURL:= BaseUrl + 'albaran/'+inttostr(id_albaran)+'/validate';

  RESTClient1.BaseURL:=BaseUrl;
end;

function TDMCreaBultos.Num_bulto(id_albaran: integer): integer;
begin
  with dm.xSigBulto do
  begin
     close;
       Parambyname('id_albaran').AsInteger:=id_albaran;
     open;
  end;
  if dm.xSigBulto.FieldByName('max_bulto').IsNull  then result:=1
  else result:= dm.xSigBulto.FieldByName('max_bulto').AsInteger+1;
end;

procedure TDMCreaBultos.GeneraBulto(id_albaran,id_destino: integer;
  peso,referencia,x,y,z,m3:String);
var
  i,estado:integer;
  bultos_alb,bultos_eti:integer;
begin

    GeneraBodyUnBulto(id_albaran,id_destino,1,peso,referencia,x,y,z,m3);
    GeneraUrl(id_albaran);
    try
       RESTRequest1.ClearBody;
       RESTRequest1.addbody(jsbody);
       RESTRequest1.Execute;
       estado:=RESTResponse1.StatusCode;
       //GuardaLogApi(rentorno.Nombre, RESTClient1.BaseURL,inttostr(estado),RESTResponse1.StatusText,now);

       if estado<>200 then
       begin
         showmessage('Han ocurrido errores al generar los bultos');
       end
       else begin

       end;
      except

      end;
    jsbody.Free;
end;

procedure TDMCreaBultos.GeneraBodyUnBulto(id_albaran,id_destino, bultos: integer; peso,referencia,x,y,z,m3:String);
var cont_bulto,i:integer;
  jsbulto:TJSONObject;
  jsbultos:TJSONArray;
begin
   cont_bulto:=Num_bulto(id_albaran);
   jsbody:=TJSONObject.Create();
   jsbultos:= TJSONArray.Create;

   for I := 1 to bultos do
   begin
     jsbulto:=TJSONObject.Create();
     jsbulto.AddPair('numBulto',inttostr(cont_bulto));
     jsbulto.AddPair('peso',peso);
     jsbulto.AddPair('referencia',referencia);
     jsbulto.AddPair('codBarras','null');
     jsbulto.AddPair('estadoId','0');
     jsbulto.AddPair('m3',m3);
     jsbulto.AddPair('x',x);
     jsbulto.AddPair('y',y);
     jsbulto.AddPair('z',z);
     jsbulto.AddPair('albaranDestId',inttostr(id_destino));

     jsbultos.Add(jsbulto);
    // jsbulto.Free;
     inc(cont_bulto);
   end;

//   jsbody.addPair(TJSONPair.Create('bultos', jsbultos));
   jsbody.addPair('bultos', jsbultos);


//   jsbulto.Free;
//   jsbultos.free;
end;

procedure TDMCreaBultos.RegeneraBultos(id_albaran: integer);
var
  i,estado:integer;
  bultos_alb,bultos_eti:integer;
begin
    GeneraUrlValidate(id_albaran);
    try
       RESTRequest1.ClearBody;
       jsbody:=TJSONObject.Create();

      // showmessage (jsbody.ToString);

       RESTRequest1.addbody(jsbody);
       RESTRequest1.Execute;
       estado:=RESTResponse1.StatusCode;
       //GuardaLogApi(rentorno.Nombre, RESTClient1.BaseURL,inttostr(estado),RESTResponse1.StatusText,now);

      // showmessage (IntToStr(estado));

       if estado<>200 then
       begin
         showmessage('Han ocurrido errores al generar los bultos');
       end
       else begin

       end;
       jsbody.Free;
      except

      end;
end;


procedure TDMCreaBultos.RegeneraBultosBack(const id_albaran,total_bultos: integer; var Error:String);
var
  i,estado:integer;
  bultos_alb,bultos_eti:integer;
begin
    try
       try
           GeneraUrlValidate(id_albaran);
           RESTRequest1.ClearBody;
           jsbody:=TJSONObject.Create();
           RESTRequest1.addbody(jsbody);
           RESTRequest1.Timeout:=(total_bultos*4000)+20000;
           RESTRequest1.Execute;
           estado:=RESTResponse1.StatusCode;
           //GuardaLogApi(rentorno.Nombre, RESTClient1.BaseURL,inttostr(estado),RESTResponse1.StatusText,now);

           if estado<>200 then
             Error:='Han ocurrido errores regenerando los bultos (API) - Id. Albarán '+id_albaran.tostring+': ' + RESTResponse1.StatusText;
       finally
           jsbody.Free;
       end;
    except
       on e:exception do
         Error:='Error desconocido al regenerar los bultos - Id. Albarán '+id_albaran.tostring+': ' + e.Message;
    end;
end;

procedure TDMCreaBultos.GeneraBultosBack(const id_albaran,id_destino, Bultos_Genera: integer; var Error:String);
var
  i,estado:integer;
  bultos_alb:integer;
begin
  Error:='';
  try
     try
         GeneraBody(id_albaran, id_destino, Bultos_Genera);
         GeneraUrl(id_albaran);
         RESTRequest1.ClearBody;
         RESTRequest1.addbody(jsbody);
         RESTRequest1.Timeout:=(Bultos_Genera*4000)+20000;
         RESTRequest1.Execute;
         estado:=RESTResponse1.StatusCode;
         //GuardaLogApi(rentorno.Nombre, RESTClient1.BaseURL, inttostr(estado), RESTResponse1.StatusText,now);
         if estado<>200 then
             Error:='Han ocurrido errores creando los bultos (API) - Id. Albarán '+id_albaran.tostring+': ' + RESTResponse1.StatusText;
     finally
         jsbody.Free;
     end;
  except
      on e:exception do
         Error:='Error desconocido al crear los bultos - Id. Albarán '+id_albaran.tostring+': ' + e.Message;
  end;
end;

end.
