object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 163
  Width = 333
  object db: TpFIBDatabase
    AutoReconnect = True
    DBName = 'nut:lgs'
    DBParams.Strings = (
      'user_name=SYSDBA'
      'password=masterkey')
    DefaultTransaction = t_read
    DefaultUpdateTransaction = t_write
    SQLDialect = 3
    Timeout = 0
    LibraryName = 'fbclient.dll'
    AliasName = 'lgs'
    WaitForRestoreConnect = 0
    BeforeConnect = dbBeforeConnect
    AfterConnect = dbAfterConnect
    Left = 18
    Top = 16
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
    SelectSQL.Strings = (
      'SELECT s.ID_ARTICULO,a.codigo,a.nombre,s.ID_ALMACEN,l.nombre,'
      '  s.ID_UBICACION,s.CANTIDAD,s.ID_EMPRESA'
      'FROM A_STOCK s'
      '  left outer join g_articulos a on (a.id_articulo=s.id_articulo)'
      '  left outer join a_almacenes l on (l.id_almacen=s.id_almacen)'
      'where a.codigo between :ref1 and :ref2 and'
      '  s.id_almacen between :alm1 and :alm2'
      'order by s.id_almacen,a.codigo,s.id_ubicacion')
    AllowedUpdateKinds = []
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 180
    Top = 16
  end
  object dsbusqueda: TDataSource
    DataSet = busqueda
    Left = 235
    Top = 16
  end
  object q_art: TpFIBDataSet
    UpdateSQL.Strings = (
      'UPDATE G_ARTICULOS'
      'SET '
      '    CODIGO = :CODIGO,'
      '    NOMBRE = :NOMBRE,'
      '    FECHA_ALTA = :FECHA_ALTA,'
      '    FECHA_BAJA = :FECHA_BAJA,'
      '    ESTADO = :ESTADO,'
      '    ID_EMPRESA = :ID_EMPRESA,'
      '    KGS = :KGS,'
      '    KGSVOL = :KGSVOL,'
      '    LARGO = :LARGO,'
      '    ANCHO = :ANCHO,'
      '    ALTO = :ALTO,'
      '    UNI_EMBALAJE = :UNI_EMBALAJE,'
      '    ID_CLIENTE = :ID_CLIENTE,'
      '    ID_FAMILIA = :ID_FAMILIA,'
      '    CODIGO_CLI = :CODIGO_CLI,'
      '    NOM_CLI = :NOM_CLI,'
      '    UDS_PALET = :UDS_PALET,'
      '    IMAGEN = :IMAGEN,'
      '    WEB = :WEB,'
      '    WEB_JPG = :WEB_JPG,'
      '    CODIGO_PROMOTORA = :CODIGO_PROMOTORA,'
      '    STOCK_MINIMO = :STOCK_MINIMO,'
      '    BC = :BC,'
      '    CUBIC = :CUBIC,'
      '    PRECIO = :PRECIO'
      'WHERE'
      '    ID_ARTICULO = :OLD_ID_ARTICULO'
      '    ')
    DeleteSQL.Strings = (
      'DELETE FROM'
      '    G_ARTICULOS'
      'WHERE'
      '        ID_ARTICULO = :OLD_ID_ARTICULO'
      '    ')
    InsertSQL.Strings = (
      'INSERT INTO G_ARTICULOS('
      '    ID_ARTICULO,'
      '    CODIGO,'
      '    NOMBRE,'
      '    FECHA_ALTA,'
      '    FECHA_BAJA,'
      '    ESTADO,'
      '    ID_EMPRESA,'
      '    KGS,'
      '    KGSVOL,'
      '    LARGO,'
      '    ANCHO,'
      '    ALTO,'
      '    UNI_EMBALAJE,'
      '    ID_CLIENTE,'
      '    ID_FAMILIA,'
      '    CODIGO_CLI,'
      '    NOM_CLI,'
      '    UDS_PALET,'
      '    IMAGEN,'
      '    WEB,'
      '    WEB_JPG,'
      '    CODIGO_PROMOTORA,'
      '    STOCK_MINIMO,'
      '    BC,'
      '    CUBIC,'
      '    PRECIO'
      ')'
      'VALUES('
      '    :ID_ARTICULO,'
      '    :CODIGO,'
      '    :NOMBRE,'
      '    :FECHA_ALTA,'
      '    :FECHA_BAJA,'
      '    :ESTADO,'
      '    :ID_EMPRESA,'
      '    :KGS,'
      '    :KGSVOL,'
      '    :LARGO,'
      '    :ANCHO,'
      '    :ALTO,'
      '    :UNI_EMBALAJE,'
      '    :ID_CLIENTE,'
      '    :ID_FAMILIA,'
      '    :CODIGO_CLI,'
      '    :NOM_CLI,'
      '    :UDS_PALET,'
      '    :IMAGEN,'
      '    :WEB,'
      '    :WEB_JPG,'
      '    :CODIGO_PROMOTORA,'
      '    :STOCK_MINIMO,'
      '    :BC,'
      '    :CUBIC,'
      '    :PRECIO'
      ')')
    RefreshSQL.Strings = (
      'SELECT'
      '    ID_ARTICULO,'
      '    CODIGO,'
      '    NOMBRE,'
      '    FECHA_ALTA,'
      '    FECHA_BAJA,'
      '    ESTADO,'
      '    ID_EMPRESA,'
      '    KGS,'
      '    KGSVOL,'
      '    LARGO,'
      '    ANCHO,'
      '    ALTO,'
      '    UNI_EMBALAJE,'
      '    ID_CLIENTE,'
      '    ID_FAMILIA,'
      '    CODIGO_CLI,'
      '    NOM_CLI,'
      '    UDS_PALET,'
      '    IMAGEN,'
      '    WEB,'
      '    WEB_JPG,'
      '    CODIGO_PROMOTORA,'
      '    STOCK_MINIMO,'
      '    BC,'
      '    CUBIC,'
      '    PRECIO'
      'FROM'
      '    G_ARTICULOS '
      'WHERE(G_ARTICULOS.ID_ARTICULO = :OLD_ID_ARTICULO)'
      '    ')
    SelectSQL.Strings = (
      'SELECT'
      '    ID_ARTICULO,'
      '    CODIGO,'
      '    NOMBRE,'
      '    FECHA_ALTA,'
      '    FECHA_BAJA,'
      '    ESTADO,'
      '    ID_EMPRESA,'
      '    KGS,'
      '    KGSVOL,'
      '    LARGO,'
      '    ANCHO,'
      '    ALTO,'
      '    UNI_EMBALAJE,'
      '    ID_CLIENTE,'
      '    ID_FAMILIA,'
      '    CODIGO_CLI,'
      '    NOM_CLI,'
      '    UDS_PALET,'
      '    IMAGEN,'
      '    WEB,'
      '    WEB_JPG,'
      '    CODIGO_PROMOTORA,'
      '    STOCK_MINIMO,'
      '    BC,'
      '    CUBIC,'
      '    PRECIO,'
      '    TIENE_LOTE,'
      '    TIENE_IMEI'
      'FROM'
      '    G_ARTICULOS '
      'order by CODIGO')
    AutoUpdateOptions.UpdateTableName = 'G_ARTICULOS'
    AutoUpdateOptions.KeyFields = 'ID_ARTICULO'
    AutoUpdateOptions.GeneratorName = 'GEN_G_ARTICULOS_ID'
    AutoUpdateOptions.WhenGetGenID = wgOnNewRecord
    OnCalcFields = q_artCalcFields
    OnPostError = q_artPostError
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    AutoCommit = True
    Left = 72
    Top = 77
    object q_artID_ARTICULO: TFIBIntegerField
      FieldName = 'ID_ARTICULO'
    end
    object q_artCODIGO: TFIBStringField
      FieldName = 'CODIGO'
      EmptyStrToNull = True
    end
    object q_artNOMBRE: TFIBStringField
      FieldName = 'NOMBRE'
      Size = 400
      EmptyStrToNull = True
    end
    object q_artFECHA_ALTA: TFIBDateField
      DefaultExpression = 'TODAY'
      FieldName = 'FECHA_ALTA'
      DisplayFormat = 'dd.mm.yyyy'
    end
    object q_artFECHA_BAJA: TFIBDateField
      FieldName = 'FECHA_BAJA'
      DisplayFormat = 'dd.mm.yyyy'
    end
    object q_artESTADO: TFIBStringField
      DefaultExpression = #39'A'#39
      FieldName = 'ESTADO'
      Size = 1
      EmptyStrToNull = True
    end
    object q_artID_EMPRESA: TFIBIntegerField
      DefaultExpression = '1'
      FieldName = 'ID_EMPRESA'
    end
    object q_artKGS: TFIBFloatField
      DefaultExpression = '1'
      FieldName = 'KGS'
      DisplayFormat = '0.000'
      EditFormat = '0.000'
    end
    object q_artKGSVOL: TFIBFloatField
      DefaultExpression = '1'
      FieldName = 'KGSVOL'
      DisplayFormat = '0.000'
      EditFormat = '0.000'
    end
    object q_artLARGO: TFIBFloatField
      DefaultExpression = '1'
      FieldName = 'LARGO'
      DisplayFormat = '0.000'
      EditFormat = '0.000'
    end
    object q_artANCHO: TFIBFloatField
      DefaultExpression = '1'
      FieldName = 'ANCHO'
      DisplayFormat = '0.000'
      EditFormat = '0.000'
    end
    object q_artALTO: TFIBFloatField
      DefaultExpression = '1'
      FieldName = 'ALTO'
      DisplayFormat = '0.000'
      EditFormat = '0.000'
    end
    object q_artUNI_EMBALAJE: TFIBIntegerField
      DefaultExpression = '1'
      FieldName = 'UNI_EMBALAJE'
      DisplayFormat = '0'
      EditFormat = '0'
    end
    object q_artID_CLIENTE: TFIBIntegerField
      DefaultExpression = '0'
      FieldName = 'ID_CLIENTE'
    end
    object q_artID_FAMILIA: TFIBIntegerField
      DefaultExpression = '1'
      FieldName = 'ID_FAMILIA'
    end
    object q_artCODIGO_CLI: TFIBStringField
      FieldName = 'CODIGO_CLI'
      EmptyStrToNull = True
    end
    object q_artNOM_CLI: TFIBStringField
      FieldName = 'NOM_CLI'
      Size = 250
      EmptyStrToNull = True
    end
    object q_artUDS_PALET: TFIBIntegerField
      DefaultExpression = '1'
      FieldName = 'UDS_PALET'
      DisplayFormat = '0'
      EditFormat = '0'
    end
    object q_artIMAGEN: TFIBBlobField
      FieldName = 'IMAGEN'
      Size = 8
    end
    object q_artWEB: TFIBStringField
      DefaultExpression = #39'I'#39
      FieldName = 'WEB'
      Size = 2
      EmptyStrToNull = True
    end
    object q_artWEB_JPG: TFIBStringField
      DefaultExpression = #39'S'#39
      FieldName = 'WEB_JPG'
      Size = 2
      EmptyStrToNull = True
    end
    object q_artCODIGO_PROMOTORA: TFIBStringField
      FieldName = 'CODIGO_PROMOTORA'
      Size = 12
      EmptyStrToNull = True
    end
    object q_artSTOCK_MINIMO: TFIBIntegerField
      FieldName = 'STOCK_MINIMO'
    end
    object q_artBC: TFIBStringField
      FieldName = 'BC'
      EmptyStrToNull = True
    end
    object q_artCUBIC: TFIBFloatField
      DefaultExpression = '0'
      FieldName = 'CUBIC'
      DisplayFormat = '0.00'
      EditFormat = '0.00'
    end
    object q_artPRECIO: TFIBFloatField
      DefaultExpression = '0'
      FieldName = 'PRECIO'
      DisplayFormat = '#,##0.00000'
      EditFormat = '0.00000'
    end
    object strngfld_artCLIENTE: TStringField
      FieldKind = fkCalculated
      FieldName = 'CLIENTE_NOM'
      Size = 50
      Calculated = True
    end
    object strngfld_artFAMILIA_NOM: TStringField
      FieldKind = fkCalculated
      FieldName = 'FAMILIA_NOM'
      Size = 50
      Calculated = True
    end
    object fbstrngfld_artTIENE_LOTE: TFIBStringField
      FieldName = 'TIENE_LOTE'
      Size = 1
      EmptyStrToNull = True
    end
    object fbsmlntfld_artTIENE_IMEI: TFIBSmallIntField
      FieldName = 'TIENE_IMEI'
    end
  end
  object ds_art: TDataSource
    DataSet = q_art
    Left = 128
    Top = 76
  end
  object q_ean: TpFIBDataSet
    UpdateSQL.Strings = (
      'UPDATE G_ARTICULOS_BC'
      'SET '
      '    ID_ARTICULO = :ID_ARTICULO,'
      '    BC = :BC,'
      '    ESTADO = :ESTADO,'
      '    ID_EMPRESA = :ID_EMPRESA'
      'WHERE'
      '    ID_ARTICULO_BC = :OLD_ID_ARTICULO_BC'
      '    ')
    DeleteSQL.Strings = (
      'DELETE FROM'
      '    G_ARTICULOS_BC'
      'WHERE'
      '        ID_ARTICULO_BC = :OLD_ID_ARTICULO_BC'
      '    ')
    InsertSQL.Strings = (
      'INSERT INTO G_ARTICULOS_BC('
      '    ID_ARTICULO_BC,'
      '    ID_ARTICULO,'
      '    BC,'
      '    ESTADO,'
      '    ID_EMPRESA'
      ')'
      'VALUES('
      '    :ID_ARTICULO_BC,'
      '    :ID_ARTICULO,'
      '    :BC,'
      '    :ESTADO,'
      '    :ID_EMPRESA'
      ')')
    RefreshSQL.Strings = (
      'SELECT'
      '    ID_ARTICULO_BC,'
      '    ID_ARTICULO,'
      '    BC,'
      '    ESTADO,'
      '    ID_EMPRESA'
      'FROM'
      '    G_ARTICULOS_BC '
      'where(G_ARTICULOS_BC.ID_ARTICULO_BC = :OLD_ID_ARTICULO_BC)'
      '    ')
    SelectSQL.Strings = (
      'SELECT'
      '    ID_ARTICULO_BC,'
      '    ID_ARTICULO,'
      '    BC,'
      '    ESTADO,'
      '    ID_EMPRESA'
      'FROM'
      '    G_ARTICULOS_BC '
      'where id_articulo=:id_articulo'
      'order by bc'
      '')
    AutoUpdateOptions.UpdateTableName = 'G_ARTICULOS_BC'
    AutoUpdateOptions.KeyFields = 'ID_ARTICULO_BC'
    AutoUpdateOptions.GeneratorName = 'GEN_G_ARTICULOS_BC_ID'
    AutoUpdateOptions.WhenGetGenID = wgOnNewRecord
    OnPostError = q_artPostError
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    AutoCommit = True
    DataSource = ds_art
    Left = 181
    Top = 78
    oFetchAll = True
    object fbntgrfld_eanID_ARTICULO_BC: TFIBIntegerField
      FieldName = 'ID_ARTICULO_BC'
    end
    object fbntgrfld_eanID_ARTICULO: TFIBIntegerField
      FieldName = 'ID_ARTICULO'
    end
    object fbstrngfld_eanBC: TFIBStringField
      FieldName = 'BC'
      EmptyStrToNull = True
    end
    object fbstrngfld_eanESTADO: TFIBStringField
      DefaultExpression = #39'A'#39
      FieldName = 'ESTADO'
      Size = 1
      EmptyStrToNull = True
    end
    object fbntgrfld_eanID_EMPRESA: TFIBIntegerField
      DefaultExpression = '1'
      FieldName = 'ID_EMPRESA'
    end
  end
  object ds_ean: TDataSource
    DataSet = q_ean
    Left = 244
    Top = 77
  end
  object con1: TADOConnection
    CommandTimeout = 120
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=xzj2004MN4;Persist Security Info=Tr' +
      'ue;User ID=sa;Initial Catalog=loginser;Data Source=NUT;Use Proce' +
      'dure for Prepare=1;Auto Translate=True;Packet Size=4096;Workstat' +
      'ion ID=INF004;Use Encryption for Data=False;Tag with column coll' +
      'ation when possible=False'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 14
    Top = 82
  end
end
