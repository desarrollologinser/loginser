object dm_pdf: Tdm_pdf
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 420
  Width = 786
  object TLocal: TFDTransaction
    Options.ReadOnly = True
    Left = 32
    Top = 32
  end
  object TUpdate: TFDTransaction
    Left = 112
    Top = 32
  end
  object RESTClient1: TRESTClient
    Authenticator = auth
    Accept = 'application/json, text/plain, text/xml; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    BaseURL = 'https://www.dioxilife.com/api'
    ContentType = 'text/xml'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    Left = 464
    Top = 56
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Method = rmPOST
    Params = <
      item
        Kind = pkREQUESTBODY
        name = 'body'
        Options = [poDoNotEncode]
        ContentType = ctAPPLICATION_JSON
      end>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 568
    Top = 64
  end
  object RESTResponse1: TRESTResponse
    ContentType = 'application/json'
    Left = 672
    Top = 112
  end
  object dxPrintDialog1: TdxPrintDialog
    Left = 280
    Top = 192
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 616
    Top = 296
  end
  object auth: THTTPBasicAuthenticator
    Username = 'envios@dioxilife.com'
    Password = 'f#0DJgsAGFK'
    Left = 520
    Top = 192
  end
end
