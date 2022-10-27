object dm: Tdm
  OldCreateOrder = False
  Height = 388
  Width = 405
  object db: TpFIBDatabase
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
    Left = 32
    Top = 23
  end
  object t_read: TpFIBTransaction
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
    Left = 268
    Top = 29
  end
  object qry: TpFIBDataSet
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
    Left = 231
    Top = 29
    object qryID: TFIBIntegerField
      FieldName = 'ID'
    end
    object qryGRUPO: TFIBIntegerField
      FieldName = 'GRUPO'
    end
    object qryDESCRIPCION: TFIBStringField
      FieldName = 'DESCRIPCION'
      Size = 100
      EmptyStrToNull = True
    end
    object qryQUERY: TFIBBlobField
      FieldName = 'QUERY'
      Size = 8
    end
    object qryCOL: TFIBIntegerField
      FieldName = 'COL'
    end
    object qryESTADO: TFIBWideStringField
      FieldName = 'ESTADO'
      Size = 1
      EmptyStrToNull = True
    end
    object qryVARIABLES: TFIBStringField
      FieldName = 'VARIABLES'
      Size = 200
      EmptyStrToNull = True
    end
    object qryCONEXION: TFIBStringField
      FieldName = 'CONEXION'
      Size = 3000
      EmptyStrToNull = True
    end
  end
  object spPtes: TpFIBStoredProc
    Transaction = t_write
    Database = db
    SQL.Strings = (
      'EXECUTE PROCEDURE BANKIA_PENDIENTES (?INI, ?FIN)')
    StoredProcName = 'BANKIA_PENDIENTES'
    Left = 220
    Top = 94
  end
  object qDelete: TpFIBQuery
    Transaction = t_write
    Database = db
    SQL.Strings = (
      'delete from e_temp_ptes')
    Left = 268
    Top = 96
  end
  object client: TRESTClient
    Authenticator = auth
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    Left = 336
    Top = 31
  end
  object request: TRESTRequest
    Client = client
    Method = rmPOST
    Params = <>
    Response = response
    SynchronizedEvents = False
    Left = 336
    Top = 87
  end
  object response: TRESTResponse
    Left = 336
    Top = 143
  end
  object auth: THTTPBasicAuthenticator
    Username = 'admin@belike.com'
    Password = 'password'
    Left = 336
    Top = 188
  end
  object q1: TpFIBDataSet
    SelectSQL.Strings = (
      '')
    Transaction = t_read_gestoras
    Database = db_gestoras
    UpdateTransaction = t_write_gestoras
    AutoCommit = True
    Left = 47
    Top = 165
  end
  object qry1: TpFIBQuery
    Transaction = t_write_gestoras
    Database = db_gestoras
    Left = 128
    Top = 168
  end
  object db_gestoras: TpFIBDatabase
    Connected = True
    DBName = '192.168.0.13:e:\bbdd\gestoras\lgs_gestoras_pro.fdb'
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
    Top = 95
  end
  object t_read_gestoras: TpFIBTransaction
    Active = True
    DefaultDatabase = db_gestoras
    Left = 94
    Top = 94
  end
  object t_write_gestoras: TpFIBTransaction
    DefaultDatabase = db_gestoras
    Left = 167
    Top = 94
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
    Left = 29
    Top = 224
  end
  object q: TADOQuery
    Connection = con1
    Parameters = <>
    Left = 73
    Top = 224
  end
  object qry_db: TpFIBQuery
    Transaction = t_write
    Database = db
    Left = 216
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
    Left = 279
    Top = 181
  end
  object qry_fib_art: TpFIBQuery
    Transaction = t_write
    Database = db
    Left = 216
    Top = 240
  end
  object q_sql_art: TADOQuery
    Connection = con1
    Parameters = <>
    Left = 73
    Top = 280
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
    Left = 279
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
    Left = 271
    Top = 301
  end
end
