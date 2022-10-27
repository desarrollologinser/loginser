object DMLstEtiquetas: TDMLstEtiquetas
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 420
  Width = 786
  object TLocal: TFDTransaction
    Options.ReadOnly = True
    Connection = DMMain.Database
    Left = 32
    Top = 32
  end
  object TUpdate: TFDTransaction
    Connection = DMMain.Database
    Left = 112
    Top = 32
  end
  object xEtiquetas: TFDQuery
    Connection = DMMain.Database
    Transaction = TLocal
    SQL.Strings = (
      'select * from tmp_lst_etiquetas'
      'where usuario=:usuario')
    Left = 72
    Top = 176
    ParamData = <
      item
        Name = 'USUARIO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object xEtiquetasUSUARIO: TIntegerField
      FieldName = 'USUARIO'
      Origin = 'USUARIO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object xEtiquetasID_ALBARAN: TIntegerField
      FieldName = 'ID_ALBARAN'
      Origin = 'ID_ALBARAN'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
  end
  object RESTClient1: TRESTClient
    Authenticator = DMMain.HTTPBasicAuthenticator1
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    BaseURL = 
      'https://servertest.loginser.com/loginser-back/api/print/print-js' +
      'on'
    ContentType = 'application/json'
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
end
