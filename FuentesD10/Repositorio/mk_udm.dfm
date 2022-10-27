object dm: Tdm
  OldCreateOrder = False
  Height = 324
  Width = 513
  object QTipoRecogida: TMdConsultaDataSet
    SQL = 
      'SELECT FIRST 1 T.TIPO'#13#10'FROM MV_TARIFAS_CLIENTES T'#13#10'INNER JOIN GV' +
      '_CLIENTES C ON C.ID_CLIENTE=T.ID_CLIENTE AND C.CODIGO=:CLIENTE'#13#10 +
      'WHERE ((T.ID_CLIENTE =C.ID_CLIENTE) OR (T.ID_CLIENTE IS NULL)) A' +
      'ND T.ID_SERVICIO=:SERVICIO AND T.ESTADO='#39'A'#39#13#10'ORDER BY T.ID_CLIEN' +
      'TE DESC'
    Params = <
      item
        DataType = ftUnknown
        Name = 'CLIENTE'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'SERVICIO'
        ParamType = ptUnknown
      end>
    Left = 360
    Top = 24
    object QTipoRecogidaTIPO: TWideStringField
      FieldName = 'TIPO'
      FixedChar = True
      Size = 1
    end
  end
  object TareaCliente: TTareaClienteComponente
    Left = 136
    Top = 72
  end
  object Correo: TCorreoComponente
    Left = 40
    Top = 136
  end
  object ServicioManipulado: TServicioManipuladoComponente
    Left = 136
    Top = 136
  end
  object CorreoServicio: TCorreoServicioComponente
    Left = 240
    Top = 88
  end
  object TareaManipulado: TTareaManipuladoComponente
    Left = 48
    Top = 16
  end
  object CorreoCliente: TCorreoClienteComponente
    Left = 240
    Top = 24
  end
  object Manipulado: TManipuladoComponente
    Left = 48
    Top = 80
  end
  object TarifaCliente: TTarifaClienteComponente
    Left = 152
    Top = 216
  end
  object Cliente: TClientepComponente
    Left = 40
    Top = 216
  end
end
