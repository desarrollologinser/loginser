object dm: Tdm
  OldCreateOrder = False
  Height = 638
  Width = 892
  object db: TpFIBDatabase
    AutoReconnect = True
    Connected = True
    DBName = '192.168.0.7:lgs'
    DBParams.Strings = (
      'user_name=SYSDBA'
      'password=masterkey'
      'sql_role_name=')
    DefaultTransaction = t_read
    DefaultUpdateTransaction = t_write
    SQLDialect = 3
    Timeout = 0
    LibraryName = 'fbclient.dll'
    WaitForRestoreConnect = 0
    Left = 24
    Top = 23
  end
  object t_read: TpFIBTransaction
    Active = True
    DefaultDatabase = db
    Left = 94
    Top = 22
  end
  object t_write: TpFIBTransaction
    DefaultDatabase = db
    Left = 159
    Top = 22
  end
  object qlistado: TpFIBDataSet
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    AutoCommit = True
    Left = 756
    Top = 29
  end
  object q_aux: TpFIBDataSet
    SelectSQL.Strings = (
      'select *'
      'from g_queries'
      'where grupo=:grupo and estado='#39'A'#39
      '/*where id=140*/'
      '')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    AutoCommit = True
    Left = 415
    Top = 21
  end
  object spPtes: TpFIBStoredProc
    Transaction = t_write
    Database = db
    SQL.Strings = (
      'EXECUTE PROCEDURE BANKIA_PENDIENTES (?INI, ?FIN)')
    StoredProcName = 'BANKIA_PENDIENTES'
    Left = 708
    Top = 94
  end
  object qDelete: TpFIBQuery
    Transaction = t_write
    Database = db
    SQL.Strings = (
      'delete from e_temp_ptes')
    Left = 756
    Top = 96
  end
  object client: TRESTClient
    Authenticator = auth
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    Left = 24
    Top = 143
  end
  object request: TRESTRequest
    Client = client
    Method = rmPOST
    Params = <>
    Response = response
    SynchronizedEvents = False
    Left = 24
    Top = 199
  end
  object response: TRESTResponse
    Left = 24
    Top = 255
  end
  object auth: THTTPBasicAuthenticator
    Username = 'admin@belike.com'
    Password = 'password'
    Left = 24
    Top = 300
  end
  object q_1: TpFIBQuery
    Transaction = t_write
    Database = db
    Left = 272
    Top = 72
  end
  object db_gestoras: TpFIBDatabase
    AutoReconnect = True
    Connected = True
    DBName = '192.168.0.248:/home/tecnico/sxxi/LGS_GESTORAS_PRO.FDB'
    DBParams.Strings = (
      'user_name=SYSDBA'
      'password=masterkey'
      'sql_role_name=')
    DefaultTransaction = t_read_gestoras
    DefaultUpdateTransaction = t_write_gestoras
    SQLDialect = 1
    Timeout = 0
    LibraryName = 'fbclient.dll'
    WaitForRestoreConnect = 0
    Left = 24
    Top = 79
  end
  object t_read_gestoras: TpFIBTransaction
    Active = True
    DefaultDatabase = db_gestoras
    Left = 94
    Top = 78
  end
  object t_write_gestoras: TpFIBTransaction
    DefaultDatabase = db_gestoras
    Left = 167
    Top = 78
  end
  object q: TADOQuery
    Connection = con1
    Parameters = <>
    Left = 65
    Top = 384
  end
  object qry_db: TpFIBQuery
    Transaction = t_write
    Database = db
    Left = 704
    Top = 176
  end
  object q_db: TpFIBDataSet
    SelectSQL.Strings = (
      'select *'
      'from g_queries'
      'where grupo=:grupo and estado='#39'A'#39
      '/*where id=140*/'
      '')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    AutoCommit = True
    Left = 767
    Top = 181
  end
  object qry_fib_art: TpFIBQuery
    Transaction = t_write
    Database = db
    Left = 704
    Top = 240
  end
  object q_sql: TADOQuery
    Connection = con1
    Parameters = <>
    Left = 113
    Top = 384
  end
  object q_fib_art: TpFIBDataSet
    SelectSQL.Strings = (
      'select *'
      'from g_queries'
      'where grupo=:grupo and estado='#39'A'#39
      '/*where id=140*/'
      '')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    AutoCommit = True
    Left = 767
    Top = 245
  end
  object q_fib_stock: TpFIBDataSet
    SelectSQL.Strings = (
      'select *'
      'from g_queries'
      'where grupo=:grupo and estado='#39'A'#39
      '/*where id=140*/'
      '')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    AutoCommit = True
    Left = 759
    Top = 301
  end
  object qDemonios: TpFIBDataSet
    SelectSQL.Strings = (
      'select * from s_demonios')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    AutoCommit = True
    Left = 279
    Top = 21
    object lgsDemoniosID_DEMONIO: TFIBIntegerField
      FieldName = 'ID_DEMONIO'
    end
    object lgsDemoniosID_CLIENTE: TFIBIntegerField
      FieldName = 'ID_CLIENTE'
    end
    object qDemoniosDESCRIPCION: TFIBStringField
      FieldName = 'DESCRIPCION'
      Size = 50
      EmptyStrToNull = True
    end
    object qDemoniosNOMBRE: TFIBStringField
      FieldName = 'NOMBRE'
      Size = 10
      EmptyStrToNull = True
    end
    object lgsDemoniosTIPO: TFIBIntegerField
      FieldName = 'TIPO'
    end
    object lgsDemoniosREPETICION: TFIBIntegerField
      FieldName = 'REPETICION'
    end
    object lgsDemoniosSIG_EJEC: TFIBDateTimeField
      FieldName = 'SIG_EJEC'
    end
    object lgsDemoniosINTERVALO: TFIBIntegerField
      FieldName = 'INTERVALO'
    end
    object qDemoniosESTADO: TFIBStringField
      FieldName = 'ESTADO'
      Size = 1
      EmptyStrToNull = True
    end
  end
  object dsDemonios: TDataSource
    DataSet = qDemonios
    Left = 344
    Top = 21
  end
  object q_picks_lotes: TpFIBDataSet
    SelectSQL.Strings = (
      'select l.cantidad, l.id_lote, l.id_pickcab, l.linea'
      'from a_picklin l'
      
        'where l.codalbaran=:albaran and l.id_articulo=:articulo and l.si' +
        'tuacion='#39'A'#39)
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    AutoCommit = True
    Left = 343
    Top = 77
    object lgs_picks_lotesCANTIDAD: TFIBIntegerField
      FieldName = 'CANTIDAD'
    end
    object lgs_picks_lotesID_LOTE: TFIBIntegerField
      FieldName = 'ID_LOTE'
    end
    object lgs_picks_lotesID_PICKCAB: TFIBIntegerField
      FieldName = 'ID_PICKCAB'
    end
    object lgs_picks_lotesLINEA: TFIBIntegerField
      FieldName = 'LINEA'
    end
  end
  object qTempGest: TpFIBDataSet
    Transaction = t_read_gestoras
    Database = db_gestoras
    UpdateTransaction = t_write_gestoras
    AutoCommit = True
    Left = 423
    Top = 85
  end
  object qrytemp: TpFIBDataSet
    Transaction = t_read_gestoras
    Database = db_gestoras
    UpdateTransaction = t_write_gestoras
    AutoCommit = True
    Left = 479
    Top = 85
  end
  object con1: TADOConnection
    CommandTimeout = 120
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=xzj2004MN4;Persist Security Info=Tr' +
      'ue;User ID=sa;Initial Catalog=loginser;Data Source=NUT;Use Proce' +
      'dure for Prepare=1;Auto Translate=True;Packet Size=4096;Workstat' +
      'ion ID=INF004;Use Encryption for Data=False;Tag with column coll' +
      'ation when possible=False'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 21
    Top = 383
  end
  object q_fib: TpFIBDataSet
    SelectSQL.Strings = (
      'select *'
      'from g_queries'
      'where grupo=:grupo and estado='#39'A'#39
      '/*where id=140*/'
      '')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    AutoCommit = True
    Left = 455
    Top = 21
  end
end
