object dmEstadoPedido: TdmEstadoPedido
  OldCreateOrder = False
  Height = 327
  Width = 597
  object RESTClient1: TRESTClient
    Authenticator = auth
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    BaseURL = 'https://servertest.loginser.com/loginser-back/api/pedido'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    Left = 440
    Top = 56
  end
  object RESTResponse1: TRESTResponse
    Left = 440
    Top = 120
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Method = rmPUT
    Params = <
      item
        Kind = pkREQUESTBODY
        name = 'body'
        Options = [poDoNotEncode]
        ContentType = ctAPPLICATION_JSON
      end>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 432
    Top = 184
  end
  object auth: THTTPBasicAuthenticator
    Username = 'admin@belike.com'
    Password = 'password'
    Left = 437
    Top = 248
  end
  object TLocal: TFDTransaction
    Options.ReadOnly = True
    Left = 32
    Top = 32
  end
  object TUpdate: TFDTransaction
    Left = 112
    Top = 32
  end
  object xPedido: TFDQuery
    Transaction = TLocal
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    SQL.Strings = (
      'select *'
      'from c_pedidos'
      'where id_pedido=:id_pedido')
    Left = 32
    Top = 112
    ParamData = <
      item
        Name = 'ID_PEDIDO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
end
