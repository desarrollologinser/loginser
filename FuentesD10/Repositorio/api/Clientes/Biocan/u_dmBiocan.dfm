object dmBiocan: TdmBiocan
  OldCreateOrder = False
  Height = 115
  Width = 378
  object RESTClient1: TRESTClient
    Authenticator = auth
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    ContentType = 'application/json'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    Left = 96
    Top = 24
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
    Left = 168
    Top = 24
  end
  object RESTResponse1: TRESTResponse
    ContentType = 'application/json'
    Left = 280
    Top = 24
  end
  object auth: THTTPBasicAuthenticator
    Username = 'info@biocanpets.es'
    Password = 'bcp78lgs*71'
    Left = 37
    Top = 24
  end
end
