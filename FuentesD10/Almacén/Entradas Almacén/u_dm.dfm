object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 466
  Width = 388
  object db: TpFIBDatabase
    DBParams.Strings = (
      'user_name=SYSDBA'
      'password=masterkey'
      'lc_ctype=ISO8859_1')
    DefaultTransaction = t_read
    DefaultUpdateTransaction = t_write
    SQLDialect = 3
    Timeout = 0
    LibraryName = 'fbclient.dll'
    WaitForRestoreConnect = 0
    BeforeConnect = dbBeforeConnect
    AfterConnect = dbAfterConnect
    Left = 17
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
  object q_stock: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT'
      '    ID_ALMACEN,'
      '    ID_UBICACION,'
      '    ID_ARTICULO,'
      '    ID_MATRICULA,'
      '    ID_LOTE,'
      '    CANTIDAD,'
      '    ID_EMPRESA'
      'FROM'
      '    A_STOCK '
      
        'where id_almacen=:id_almacen and id_ubicacion in (SELECT aa.ubic' +
        '_entrada FROM A_ALMACENES aa WHERE aa.id_almacen=:id_almacen and' +
        ' aa.ubic_entrada IS NOT null)'
      'order by id_matricula;')
    OnCalcFields = q_stockCalcFields
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 21
    Top = 87
    object fbntgrfld_stockID_ALMACEN: TFIBIntegerField
      FieldName = 'ID_ALMACEN'
    end
    object fbntgrfld_stockID_UBICACION: TFIBIntegerField
      FieldName = 'ID_UBICACION'
    end
    object fbntgrfld_stockID_ARTICULO: TFIBIntegerField
      FieldName = 'ID_ARTICULO'
    end
    object fbntgrfld_stockID_MATRICULA: TFIBIntegerField
      FieldName = 'ID_MATRICULA'
    end
    object fbntgrfld_stockID_LOTE: TFIBIntegerField
      FieldName = 'ID_LOTE'
    end
    object fbntgrfld_stockCANTIDAD: TFIBIntegerField
      FieldName = 'CANTIDAD'
    end
    object fbntgrfld_stockID_EMPRESA: TFIBIntegerField
      FieldName = 'ID_EMPRESA'
    end
    object strngfld_stockN_ARTICULO: TStringField
      DisplayWidth = 300
      FieldKind = fkCalculated
      FieldName = 'N_ARTICULO'
      Size = 300
      Calculated = True
    end
    object strngfld_stockR_ARTICULO: TStringField
      DisplayWidth = 15
      FieldKind = fkCalculated
      FieldName = 'R_ARTICULO'
      Size = 15
      Calculated = True
    end
    object q_stockN_LOTE: TStringField
      FieldKind = fkCalculated
      FieldName = 'N_LOTE'
      Calculated = True
    end
  end
  object ds_stock: TDataSource
    DataSet = q_stock
    Left = 76
    Top = 87
  end
  object q_rep: TpFIBDataSet
    SelectSQL.Strings = (
      
        'select s.id_matricula,a.codigo,a.nombre,u.id_estanteria,u.id_pos' +
        'icion,u.id_altura,s.cantidad'
      'from a_stock s'
      
        'left outer join a_ubicaciones u on (u.id_ubicacion=s.id_ubicacio' +
        'n)'
      'left outer join g_articulos a on (a.id_articulo=s.id_articulo)'
      'where s.id_ubicacion not in (361,3758)')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 258
    Top = 88
    object fbntgrfld_repID_MATRICULA: TFIBIntegerField
      FieldName = 'ID_MATRICULA'
    end
    object fbwdstrngfld_repCODIGO: TFIBStringField
      FieldName = 'CODIGO'
      EmptyStrToNull = True
    end
    object fbwdstrngfld_repNOMBRE: TFIBStringField
      FieldName = 'NOMBRE'
      Size = 400
      EmptyStrToNull = True
    end
    object fbwdstrngfld_repID_ESTANTERIA: TFIBStringField
      FieldName = 'ID_ESTANTERIA'
      Size = 2
      EmptyStrToNull = True
    end
    object fbntgrfld_repID_POSICION: TFIBIntegerField
      FieldName = 'ID_POSICION'
    end
    object fbntgrfld_repID_ALTURA: TFIBIntegerField
      FieldName = 'ID_ALTURA'
    end
    object fbntgrfld_repCANTIDAD: TFIBIntegerField
      FieldName = 'CANTIDAD'
    end
  end
  object q_stock_ubic: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT'
      '    a.ID_ALMACEN,'
      '    a.ID_UBICACION,'
      '    a.ID_ARTICULO,'
      '    a.ID_MATRICULA,'
      '    a.ID_LOTE,'
      '    a.CANTIDAD,'
      '    a.ID_EMPRESA,'
      '    u.id_estanteria,u.id_posicion,u.id_altura'
      'FROM A_STOCK a'
      
        'left outer join a_ubicaciones u on (a.id_ubicacion=u.id_ubicacio' +
        'n)'
      
        'where a.id_ubicacion not in (SELECT aa.ubic_entrada FROM A_ALMAC' +
        'ENES aa WHERE aa.ubic_entrada IS NOT null) and a.id_almacen=:id_' +
        'almacen'
      'and ((a.id_articulo=:id_art) or (:todo=1))'
      'order by u.id_estanteria,u.id_posicion,u.id_altura;')
    OnCalcFields = q_stockCalcFields
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 128
    Top = 87
    object strngfld_stock_ubicr_articulo: TStringField
      FieldKind = fkCalculated
      FieldName = 'r_articulo'
      Calculated = True
    end
    object strngfld_stock_ubicn_articulo: TStringField
      FieldKind = fkCalculated
      FieldName = 'n_articulo'
      Size = 40
      Calculated = True
    end
    object fbntgrfld_stock_ubicID_ALMACEN: TFIBIntegerField
      FieldName = 'ID_ALMACEN'
    end
    object fbntgrfld_stock_ubicID_UBICACION: TFIBIntegerField
      DefaultExpression = '0'
      FieldName = 'ID_UBICACION'
    end
    object fbntgrfld_stock_ubicID_ARTICULO: TFIBIntegerField
      FieldName = 'ID_ARTICULO'
    end
    object fbntgrfld_stock_ubicID_MATRICULA: TFIBIntegerField
      FieldName = 'ID_MATRICULA'
    end
    object fbntgrfld_stock_ubicID_LOTE: TFIBIntegerField
      FieldName = 'ID_LOTE'
    end
    object fbntgrfld_stock_ubicCANTIDAD: TFIBIntegerField
      FieldName = 'CANTIDAD'
    end
    object fbntgrfld_stock_ubicID_EMPRESA: TFIBIntegerField
      FieldName = 'ID_EMPRESA'
    end
    object fbwdstrngfld_stock_ubicID_ESTANTERIA: TFIBStringField
      DefaultExpression = 'A'
      FieldName = 'ID_ESTANTERIA'
      Size = 3
      EmptyStrToNull = True
    end
    object fbntgrfld_stock_ubicID_POSICION: TFIBIntegerField
      DefaultExpression = '0'
      FieldName = 'ID_POSICION'
    end
    object fbntgrfld_stock_ubicID_ALTURA: TFIBIntegerField
      DefaultExpression = '0'
      FieldName = 'ID_ALTURA'
    end
    object q_stock_ubicn_lote: TStringField
      FieldKind = fkCalculated
      FieldName = 'n_lote'
      Calculated = True
    end
  end
  object ds_stock_ubic: TDataSource
    DataSet = q_stock_ubic
    Left = 199
    Top = 87
  end
  object q_lotes: TpFIBDataSet
    UpdateSQL.Strings = (
      'UPDATE A_LOTES'
      'SET '
      '    NOMBRE = :NOMBRE,'
      '    CADUCIDAD = :CADUCIDAD,'
      '    ESTADO = :ESTADO'
      'WHERE'
      '    ID_LOTE = :OLD_ID_LOTE'
      '    ')
    DeleteSQL.Strings = (
      'DELETE FROM'
      '    A_LOTES'
      'WHERE'
      '        ID_LOTE = :OLD_ID_LOTE'
      '    ')
    InsertSQL.Strings = (
      'INSERT INTO A_LOTES('
      '    ID_LOTE,'
      '    NOMBRE,'
      '    CADUCIDAD,'
      '    ESTADO'
      ')'
      'VALUES('
      '    :ID_LOTE,'
      '    :NOMBRE,'
      '    :CADUCIDAD,'
      '    :ESTADO'
      ')')
    RefreshSQL.Strings = (
      'SELECT'
      '    ID_LOTE,'
      '    NOMBRE,'
      '    CADUCIDAD,'
      '    ESTADO'
      'FROM'
      '    A_LOTES '
      ''
      ' WHERE '
      '        A_LOTES.ID_LOTE = :OLD_ID_LOTE'
      '    ')
    SelectSQL.Strings = (
      'SELECT'
      '    ID_LOTE,'
      '    NOMBRE,'
      '    CADUCIDAD,'
      '    ESTADO'
      'FROM'
      '    A_LOTES ')
    AutoUpdateOptions.UpdateTableName = 'A_LOTES'
    AutoUpdateOptions.KeyFields = 'ID_LOTE'
    AutoUpdateOptions.GeneratorName = 'GEN_A_LOTES_ID'
    AutoUpdateOptions.WhenGetGenID = wgOnNewRecord
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    AutoCommit = True
    Left = 67
    Top = 185
    object fbntgrfld_lotesID_LOTE: TFIBIntegerField
      FieldName = 'ID_LOTE'
    end
    object fbstrngfld_lotesNOMBRE: TFIBStringField
      FieldName = 'NOMBRE'
      EmptyStrToNull = True
    end
    object fbdtfld_lotesCADUCIDAD: TFIBDateField
      FieldName = 'CADUCIDAD'
    end
    object fbstrngfld_lotesESTADO: TFIBStringField
      FieldName = 'ESTADO'
      Size = 1
      EmptyStrToNull = True
    end
  end
  object ds_lotes: TDataSource
    DataSet = q_lotes
    Left = 127
    Top = 179
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
    Left = 206
    Top = 170
  end
  object q_aux: TpFIBDataSet
    SelectSQL.Strings = (
      
        'select s.id_matricula,a.codigo,a.nombre,u.id_estanteria,u.id_pos' +
        'icion,u.id_altura,s.cantidad'
      'from a_stock s'
      
        'left outer join a_ubicaciones u on (u.id_ubicacion=s.id_ubicacio' +
        'n)'
      'left outer join g_articulos a on (a.id_articulo=s.id_articulo)'
      'where s.id_ubicacion not in (361,3758)')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 266
    Top = 192
  end
  object client: TRESTClient
    Authenticator = auth
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    Left = 320
    Top = 15
  end
  object request: TRESTRequest
    Client = client
    Method = rmPOST
    Params = <>
    Response = response
    SynchronizedEvents = False
    Left = 312
    Top = 71
  end
  object response: TRESTResponse
    Left = 312
    Top = 127
  end
  object auth: THTTPBasicAuthenticator
    Username = 'admin@belike.com'
    Password = 'password'
    Left = 312
    Top = 192
  end
  object db_gestoras: TpFIBDatabase
    DBName = '192.168.0.220:d:\fb\loginser_gestoras.fdb'
    DBParams.Strings = (
      'user_name=SYSDBA'
      'password=masterkey')
    DefaultTransaction = t_read_gestoras
    SQLDialect = 1
    Timeout = 0
    LibraryName = 'fbclient.dll'
    AliasName = 'gestoras'
    WaitForRestoreConnect = 0
    BeforeConnect = dbBeforeConnect
    AfterConnect = dbAfterConnect
    Left = 42
    Top = 222
  end
  object t_read_gestoras: TpFIBTransaction
    DefaultDatabase = db_gestoras
    Left = 135
    Top = 222
  end
  object t_write_gestoras: TpFIBTransaction
    DefaultDatabase = db
    Left = 222
    Top = 222
  end
  object q_1: TpFIBQuery
    Left = 104
    Top = 144
  end
  object q_picks_lotes: TpFIBDataSet
    UpdateSQL.Strings = (
      'UPDATE A_LOTES'
      'SET '
      '    NOMBRE = :NOMBRE,'
      '    CADUCIDAD = :CADUCIDAD,'
      '    ESTADO = :ESTADO'
      'WHERE'
      '    ID_LOTE = :OLD_ID_LOTE'
      '    ')
    DeleteSQL.Strings = (
      'DELETE FROM'
      '    A_LOTES'
      'WHERE'
      '        ID_LOTE = :OLD_ID_LOTE'
      '    ')
    InsertSQL.Strings = (
      'INSERT INTO A_LOTES('
      '    ID_LOTE,'
      '    NOMBRE,'
      '    CADUCIDAD,'
      '    ESTADO'
      ')'
      'VALUES('
      '    :ID_LOTE,'
      '    :NOMBRE,'
      '    :CADUCIDAD,'
      '    :ESTADO'
      ')')
    RefreshSQL.Strings = (
      'SELECT'
      '    ID_LOTE,'
      '    NOMBRE,'
      '    CADUCIDAD,'
      '    ESTADO'
      'FROM'
      '    A_LOTES '
      ''
      ' WHERE '
      '        A_LOTES.ID_LOTE = :OLD_ID_LOTE'
      '    ')
    SelectSQL.Strings = (
      'SELECT'
      '    ID_LOTE,'
      '    NOMBRE,'
      '    CADUCIDAD,'
      '    ESTADO'
      'FROM'
      '    A_LOTES ')
    AutoUpdateOptions.UpdateTableName = 'A_LOTES'
    AutoUpdateOptions.KeyFields = 'ID_LOTE'
    AutoUpdateOptions.GeneratorName = 'GEN_A_LOTES_ID'
    AutoUpdateOptions.WhenGetGenID = wgOnNewRecord
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    AutoCommit = True
    Left = 27
    Top = 137
    object lgs1: TFIBIntegerField
      FieldName = 'ID_LOTE'
    end
    object FIBStringField1: TFIBStringField
      FieldName = 'NOMBRE'
      EmptyStrToNull = True
    end
    object FIBDateField1: TFIBDateField
      FieldName = 'CADUCIDAD'
    end
    object FIBStringField2: TFIBStringField
      FieldName = 'ESTADO'
      Size = 1
      EmptyStrToNull = True
    end
  end
  object q_lotes_filter: TpFIBDataSet
    UpdateSQL.Strings = (
      'UPDATE A_LOTES'
      'SET '
      '    NOMBRE = :NOMBRE,'
      '    CADUCIDAD = :CADUCIDAD,'
      '    ESTADO = :ESTADO'
      'WHERE'
      '    ID_LOTE = :OLD_ID_LOTE'
      '    ')
    DeleteSQL.Strings = (
      '')
    RefreshSQL.Strings = (
      '')
    SelectSQL.Strings = (
      'SELECT'
      '    ID_LOTE,'
      '    NOMBRE,'
      '    CADUCIDAD,'
      '    ESTADO'
      'FROM'
      '    A_LOTES ')
    AutoUpdateOptions.UpdateTableName = 'A_LOTES'
    AutoUpdateOptions.KeyFields = 'ID_LOTE'
    AutoUpdateOptions.GeneratorName = 'GEN_A_LOTES_ID'
    AutoUpdateOptions.WhenGetGenID = wgOnNewRecord
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    AutoCommit = True
    Left = 51
    Top = 289
    object lgs2: TFIBIntegerField
      FieldName = 'ID_LOTE'
    end
    object FIBStringField3: TFIBStringField
      FieldName = 'NOMBRE'
      EmptyStrToNull = True
    end
    object FIBDateField2: TFIBDateField
      FieldName = 'CADUCIDAD'
    end
    object FIBStringField4: TFIBStringField
      FieldName = 'ESTADO'
      Size = 1
      EmptyStrToNull = True
    end
  end
  object dsLotesFilter: TDataSource
    DataSet = q_lotes_filter
    Left = 135
    Top = 291
  end
end
