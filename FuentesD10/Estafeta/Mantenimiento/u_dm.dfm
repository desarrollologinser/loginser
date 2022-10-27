object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 420
  Width = 437
  object db: TpFIBDatabase
    DBName = 'nut:lgs'
    DBParams.Strings = (
      'password=masterkey'
      'user_name=SYSDBA'
      'lc_ctype=ISO8859_1')
    DefaultTransaction = t_read
    DefaultUpdateTransaction = t_write
    SQLDialect = 3
    Timeout = 0
    LibraryName = 'fbclient.dll'
    WaitForRestoreConnect = 0
    BeforeConnect = dbBeforeConnect
    Left = 20
    Top = 13
  end
  object t_read: TpFIBTransaction
    DefaultDatabase = db
    Left = 71
    Top = 16
  end
  object t_write: TpFIBTransaction
    DefaultDatabase = db
    Left = 126
    Top = 16
  end
  object busqueda: TpFIBDataSet
    AllowedUpdateKinds = []
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 189
    Top = 19
  end
  object dsbusqueda: TDataSource
    DataSet = busqueda
    Left = 248
    Top = 18
  end
  object q_delegaciones: TpFIBDataSet
    SelectSQL.Strings = (
      
        'select d.*,dz.nombre as nombre_dir_zona,dt.nombre as nombre_dir_' +
        'terr,t.nombre as nombre_tipologia'
      'from e_delegaciones d'
      
        'left outer join e_direcciones_zona dz on (d.id_direccion_zona=dz' +
        '.id_direccion_zona)'
      
        'left outer join e_direcciones_territorial dt on (d.id_direccion_' +
        'territorial=dt.id_direccion_territorial)'
      
        'left outer join e_tipologias t on (d.id_tipologia=t.id_tipologia' +
        ')'
      'where d.id_cliente=:cliente'
      'order by cod_entidad,cod_delegacion')
    AutoCalcFields = False
    AfterScroll = q_delegacionesAfterScroll
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 36
    Top = 234
    oFetchAll = True
    object fbntgrfld_delegacionesID_DELEGACION: TFIBIntegerField
      FieldName = 'ID_DELEGACION'
    end
    object fbstrngfld_delegacionesNOMBRE: TFIBStringField
      FieldName = 'NOMBRE'
      Size = 80
      EmptyStrToNull = True
    end
    object fbntgrfld_delegacionesID_CLIENTE: TFIBIntegerField
      FieldName = 'ID_CLIENTE'
    end
    object fbntgrfld_delegacionesCOD_ENTIDAD: TFIBIntegerField
      FieldName = 'COD_ENTIDAD'
    end
    object fbntgrfld_delegacionesCOD_DELEGACION: TFIBIntegerField
      FieldName = 'COD_DELEGACION'
    end
    object fbstrngfld_delegacionesDIRECCION: TFIBStringField
      FieldName = 'DIRECCION'
      Size = 120
      EmptyStrToNull = True
    end
    object fbntgrfld_delegacionesID_CP: TFIBIntegerField
      FieldName = 'ID_CP'
    end
    object fbstrngfld_delegacionesCP: TFIBStringField
      FieldName = 'CP'
      Size = 5
      EmptyStrToNull = True
    end
    object fbntgrfld_delegacionesID_POBLACION: TFIBIntegerField
      FieldName = 'ID_POBLACION'
    end
    object fbstrngfld_delegacionesPOBLACION: TFIBStringField
      FieldName = 'POBLACION'
      Size = 60
      EmptyStrToNull = True
    end
    object fbntgrfld_delegacionesID_PROVINCIA: TFIBIntegerField
      FieldName = 'ID_PROVINCIA'
    end
    object fbstrngfld_delegacionesPROVINCIA: TFIBStringField
      FieldName = 'PROVINCIA'
      Size = 60
      EmptyStrToNull = True
    end
    object fbstrngfld_delegacionesTELEFONO: TFIBStringField
      FieldName = 'TELEFONO'
      Size = 30
      EmptyStrToNull = True
    end
    object fbstrngfld_delegacionesFAX: TFIBStringField
      FieldName = 'FAX'
      Size = 30
      EmptyStrToNull = True
    end
    object fbstrngfld_delegacionesEMAIL: TFIBStringField
      FieldName = 'EMAIL'
      Size = 80
      EmptyStrToNull = True
    end
    object fbstrngfld_delegacionesNIF: TFIBStringField
      FieldName = 'NIF'
      Size = 9
      EmptyStrToNull = True
    end
    object fbstrngfld_delegacionesESTADO: TFIBStringField
      DefaultExpression = #39'A'#39
      FieldName = 'ESTADO'
      Size = 1
      EmptyStrToNull = True
    end
    object fbsmlntfld_delegacionesID_EMPRESA: TFIBSmallIntField
      DefaultExpression = '1'
      FieldName = 'ID_EMPRESA'
    end
    object fbsmlntfld_delegacionesDEST_RECURRENTE: TFIBSmallIntField
      DefaultExpression = '0'
      FieldName = 'DEST_RECURRENTE'
    end
    object fbsmlntfld_delegacionesORG_RECURRENTE: TFIBSmallIntField
      DefaultExpression = '0'
      FieldName = 'ORG_RECURRENTE'
    end
    object fbntgrfld_delegacionesPEDIR_SOBRES: TFIBIntegerField
      DefaultExpression = '0'
      FieldName = 'PEDIR_SOBRES'
    end
    object fbsmlntfld_delegacionesENVIAR_INCIDENCIA_EST: TFIBSmallIntField
      DefaultExpression = '1'
      FieldName = 'ENVIAR_INCIDENCIA_EST'
    end
    object fbsmlntfld_delegacionesENVIAR_INCIDENCIA_PRECINTO: TFIBSmallIntField
      DefaultExpression = '1'
      FieldName = 'ENVIAR_INCIDENCIA_PRECINTO'
    end
    object fbntgrfld_delegacionesID_DIRECCION_ZONA: TFIBIntegerField
      FieldName = 'ID_DIRECCION_ZONA'
    end
    object fbntgrfld_delegacionesID_DIRECCION_TERRITORIAL: TFIBIntegerField
      FieldName = 'ID_DIRECCION_TERRITORIAL'
    end
    object fbntgrfld_delegacionesID_TIPOLOGIA: TFIBIntegerField
      FieldName = 'ID_TIPOLOGIA'
    end
    object fbstrngfld_delegacionesNOMBRE_DIR_ZONA: TFIBStringField
      FieldName = 'NOMBRE_DIR_ZONA'
      Size = 50
      EmptyStrToNull = True
    end
    object fbstrngfld_delegacionesNOMBRE_DIR_TERR: TFIBStringField
      FieldName = 'NOMBRE_DIR_TERR'
      Size = 40
      EmptyStrToNull = True
    end
    object fbstrngfld_delegacionesNOMBRE_TIPOLOGIA: TFIBStringField
      FieldName = 'NOMBRE_TIPOLOGIA'
      Size = 25
      EmptyStrToNull = True
    end
    object fbsmlntfld_delegacionesPEDIR_TRAZA: TFIBSmallIntField
      DefaultExpression = '0'
      FieldName = 'PEDIR_TRAZA'
    end
    object lgs_delegacionesENVIAR_AVISO_TRAZA: TFIBSmallIntField
      DefaultExpression = '1'
      FieldName = 'ENVIAR_AVISO_TRAZA'
    end
    object q_delegacionesEMAIL_TRAZA: TFIBStringField
      FieldName = 'EMAIL_TRAZA'
      Size = 1000
      EmptyStrToNull = True
    end
    object lgs_delegacionesID_TIPO_GRUPO: TFIBIntegerField
      FieldName = 'ID_TIPO_GRUPO'
    end
    object q_delegacionesEMAIL_SUBJECT_TRAZA: TFIBStringField
      FieldName = 'EMAIL_SUBJECT_TRAZA'
      Size = 255
      EmptyStrToNull = True
    end
    object lgs_delegacionesES_PILOTO: TFIBSmallIntField
      DefaultExpression = '0'
      FieldName = 'ES_PILOTO'
    end
    object lgs_delegacionesPAGO_VALIJA: TFIBSmallIntField
      DefaultExpression = '0'
      FieldName = 'PAGO_VALIJA'
    end
    object lgs_delegacionesPAGO_ESTAFETA: TFIBSmallIntField
      DefaultExpression = '0'
      FieldName = 'PAGO_ESTAFETA'
    end
    object lgs_delegacionesPAGO_OL: TFIBSmallIntField
      DefaultExpression = '0'
      FieldName = 'PAGO_OL'
    end
    object lgs_delegacionesSYNC_WEB: TFIBSmallIntField
      DefaultExpression = '0'
      FieldName = 'SYNC_WEB'
    end
    object lgs_delegacionesCOD_CAIXA: TFIBIntegerField
      FieldName = 'COD_CAIXA'
    end
    object lgs_delegacionesCONVIERTE_CAIXA: TFIBSmallIntField
      DefaultExpression = '0'
      FieldName = 'CONVIERTE_CAIXA'
    end
    object lgs_delegacionesID_DIRECCION_COMERCIAL: TFIBIntegerField
      FieldName = 'ID_DIRECCION_COMERCIAL'
    end
    object q_delegacionesNOMBRE_DIR_COM: TFIBStringField
      FieldName = 'NOMBRE_DIR_COM'
      Size = 40
      EmptyStrToNull = True
    end
  end
  object ds_delegaciones: TDataSource
    DataSet = q_delegaciones
    Left = 121
    Top = 214
  end
  object qr_update: TpFIBQuery
    Transaction = t_write
    Database = db
    Left = 361
    Top = 65
  end
  object q_1: TpFIBDataSet
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 327
    Top = 126
  end
  object q_2: TpFIBDataSet
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 377
    Top = 127
  end
  object q_valijas: TpFIBDataSet
    SelectSQL.Strings = (
      'select *'
      'from e_valijas'
      'where id_delegacion=:id_delegacion')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    DataSource = ds_delegaciones
    Left = 180
    Top = 243
    oFetchAll = True
    object q_valijasID_VALIJA: TFIBIntegerField
      FieldName = 'ID_VALIJA'
    end
    object q_valijasID_DELEGACION: TFIBIntegerField
      FieldName = 'ID_DELEGACION'
    end
    object q_valijasID_RUTA: TFIBIntegerField
      FieldName = 'ID_RUTA'
    end
    object q_valijasID_AGENCIA: TFIBIntegerField
      FieldName = 'ID_AGENCIA'
    end
    object q_valijasID_MODULO: TFIBIntegerField
      FieldName = 'ID_MODULO'
    end
    object q_valijasID_CASILLERO: TFIBIntegerField
      FieldName = 'ID_CASILLERO'
    end
    object q_valijasID_HUECO: TFIBIntegerField
      FieldName = 'ID_HUECO'
    end
    object q_valijasDEST_ESPECIALES: TFIBIntegerField
      DefaultExpression = '0'
      FieldName = 'DEST_ESPECIALES'
    end
    object q_valijasMNEMONICO: TFIBStringField
      FieldName = 'MNEMONICO'
      Size = 1
      EmptyStrToNull = True
    end
    object q_valijasID_VALIJA_REDIR: TFIBIntegerField
      FieldName = 'ID_VALIJA_REDIR'
    end
    object q_valijasHORA_ENT: TFIBTimeField
      FieldName = 'HORA_ENT'
      DisplayFormat = 'hh:mm AMPM'
    end
    object q_valijasHORA_REC: TFIBTimeField
      FieldName = 'HORA_REC'
      DisplayFormat = 'hh:mm AMPM'
    end
    object q_valijasDIAS_SEMANA: TFIBStringField
      FieldName = 'DIAS_SEMANA'
      Size = 7
      EmptyStrToNull = True
    end
    object q_valijasESTADO: TFIBStringField
      DefaultExpression = #39'A'#39
      FieldName = 'ESTADO'
      Size = 1
      EmptyStrToNull = True
    end
    object q_valijasID_EMPRESA: TFIBIntegerField
      DefaultExpression = '1'
      FieldName = 'ID_EMPRESA'
    end
    object fbntgrfld_valijasDISP_LLEGADA: TFIBIntegerField
      DefaultExpression = '0'
      FieldName = 'DISP_LLEGADA'
    end
    object fbntgrfld_valijasDISP_SALIDA: TFIBIntegerField
      DefaultExpression = '0'
      FieldName = 'DISP_SALIDA'
    end
    object fbntgrfld_valijasID_AGRUPACION: TFIBIntegerField
      DefaultExpression = '1'
      FieldName = 'ID_AGRUPACION'
    end
  end
  object ds_valijas: TDataSource
    DataSet = q_valijas
    Left = 231
    Top = 220
  end
  object q_valijas_tarjetas: TpFIBDataSet
    SelectSQL.Strings = (
      'select *'
      'from e_valijas_tarjetas'
      'where id_valija=:id_valija')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    DataSource = ds_valijas
    Left = 291
    Top = 247
    oFetchAll = True
    object fbntgrfld_valijas_tarjetasID_VALIJA_TARJETA: TFIBIntegerField
      FieldName = 'ID_VALIJA_TARJETA'
    end
    object fbntgrfld_valijas_tarjetasID_VALIJA: TFIBIntegerField
      FieldName = 'ID_VALIJA'
    end
    object fbstrngfld_valijas_tarjetasEAN: TFIBStringField
      FieldName = 'EAN'
      Size = 16
      EmptyStrToNull = True
    end
    object fbstrngfld_valijas_tarjetasRFID: TFIBStringField
      FieldName = 'RFID'
      Size = 16
      EmptyStrToNull = True
    end
    object fbntgrfld_valijas_tarjetasN_TARJETA: TFIBIntegerField
      FieldName = 'N_TARJETA'
    end
    object fbstrngfld_valijas_tarjetasESTADO: TFIBStringField
      FieldName = 'ESTADO'
      Size = 1
      EmptyStrToNull = True
    end
    object fbntgrfld_valijas_tarjetasID_EMPRESA: TFIBIntegerField
      FieldName = 'ID_EMPRESA'
    end
    object fbstrngfld_valijas_tarjetasEAN_ALT: TFIBStringField
      FieldName = 'EAN_ALT'
      Size = 16
      EmptyStrToNull = True
    end
    object fbntgrfld_valijas_tarjetasN_TARJETA_ALT: TFIBIntegerField
      FieldName = 'N_TARJETA_ALT'
    end
    object fbstrngfld_valijas_tarjetasEAN_OLD: TFIBStringField
      FieldName = 'EAN_OLD'
      Size = 16
      EmptyStrToNull = True
    end
    object fbstrngfld_valijas_tarjetasEAN_OLD2: TFIBStringField
      FieldName = 'EAN_OLD2'
      Size = 16
      EmptyStrToNull = True
    end
  end
  object ds_valijas_tarjetas: TDataSource
    DataSet = q_valijas_tarjetas
    Left = 355
    Top = 223
  end
  object cds_tjta: TClientDataSet
    PersistDataPacket.Data = {
      270100009619E0BD01000000180000000A000000000003000000270104746970
      6F04000100000000000A64656C65676163696F6E010049000000010005574944
      5448020002000A0009646972656363696F6E0100490000000100055749445448
      020002007800066E6F6D62726501004900000001000557494454480200020050
      000A646972656363696F6E320100490000000100055749445448020002005000
      0970726F76696E6369610100490000000100055749445448020002001E000A66
      72656375656E6369610100490000000100055749445448020002001400066D6F
      64756C6F01004900000001000557494454480200020014000365616E01004900
      0000010005574944544802000200140004726669640100490000000100055749
      4454480200020014000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'tipo'
        DataType = ftInteger
      end
      item
        Name = 'delegacion'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'direccion'
        DataType = ftString
        Size = 120
      end
      item
        Name = 'nombre'
        DataType = ftString
        Size = 80
      end
      item
        Name = 'direccion2'
        DataType = ftString
        Size = 80
      end
      item
        Name = 'provincia'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'frecuencia'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'modulo'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ean'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'rfid'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 51
    Top = 349
    object strngfld_tjtadelegacion: TStringField
      FieldName = 'delegacion'
      Size = 10
    end
    object intgrfld_tjtatipo: TIntegerField
      FieldName = 'tipo'
    end
    object strngfld_tjtadireccion: TStringField
      FieldName = 'direccion'
      Size = 120
    end
    object strngfld_tjtanombre: TStringField
      FieldName = 'nombre'
      Size = 80
    end
    object strngfld_tjtadireccion2: TStringField
      FieldName = 'direccion2'
      Size = 80
    end
    object strngfld_tjtaprovincia: TStringField
      FieldName = 'provincia'
      Size = 30
    end
    object strngfld_tjtafrecuencia: TStringField
      FieldName = 'frecuencia'
    end
    object strngfld_tjtamodulo: TStringField
      FieldName = 'modulo'
    end
    object strngfld_tjtaean: TStringField
      FieldName = 'ean'
    end
    object strngfld_tjtarfid: TStringField
      FieldName = 'rfid'
    end
  end
  object con1: TADOConnection
    Left = 232
    Top = 368
  end
  object q_aux: TpFIBDataSet
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 47
    Top = 102
  end
  object q_delegs_count: TpFIBDataSet
    SelectSQL.Strings = (
      'select count(*) as cuenta'
      'from e_delegaciones d'
      
        'left outer join e_direcciones_zona dz on (d.id_direccion_zona=dz' +
        '.id_direccion_zona)'
      
        'left outer join e_direcciones_territorial dt on (d.id_direccion_' +
        'territorial=dt.id_direccion_territorial)'
      
        'left outer join e_tipologias t on (d.id_tipologia=t.id_tipologia' +
        ')'
      'where d.id_cliente=:cliente'
      'order by cod_entidad,cod_delegacion')
    AutoCalcFields = False
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 36
    Top = 290
    oFetchAll = True
  end
end
