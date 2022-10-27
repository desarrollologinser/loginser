object dmUpdatePedido: TdmUpdatePedido
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 299
  Width = 319
  object RESTClient1: TRESTClient
    Authenticator = auth
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    BaseURL = 'https://servertest.loginser.com/loginser-back/api/pedido'
    ContentType = 'application/json'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    Left = 232
    Top = 32
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
    Left = 224
    Top = 160
  end
  object RESTResponse1: TRESTResponse
    ContentType = 'text/html'
    Left = 232
    Top = 96
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
    Left = 24
    Top = 80
    ParamData = <
      item
        Name = 'ID_PEDIDO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object TLocal: TFDTransaction
    Options.ReadOnly = True
    Left = 24
    Top = 24
  end
  object TUpdate: TFDTransaction
    Left = 72
    Top = 24
  end
  object xBultos: TFDQuery
    Transaction = TLocal
    SQL.Strings = (
      'select count(*) as bultos from albaran_bultos'
      'where id_albaran=:id_albaran')
    Left = 72
    Top = 80
    ParamData = <
      item
        Name = 'ID_ALBARAN'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object xSigBulto: TFDQuery
    Transaction = TLocal
    SQL.Strings = (
      'select max(bulto) max_bulto from albaran_bultos'
      'where id_albaran=:id_albaran')
    Left = 24
    Top = 136
    ParamData = <
      item
        Name = 'ID_ALBARAN'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object auth: THTTPBasicAuthenticator
    Username = 'admin@belike.com'
    Password = 'password'
    Left = 229
    Top = 224
  end
end
