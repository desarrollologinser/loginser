object dm: Tdm
  OldCreateOrder = False
  Height = 126
  Width = 276
  object db: TpFIBDatabase
    AutoReconnect = True
    Connected = True
    DBName = '192.168.0.7:lgs'
    DBParams.Strings = (
      'password=masterkey'
      'user_name=SYSDBA')
    DefaultTransaction = t_read
    DefaultUpdateTransaction = t_write
    SQLDialect = 3
    Timeout = 0
    LibraryName = 'fbclient.dll'
    AliasName = 'lgs'
    WaitForRestoreConnect = 0
    Left = 30
    Top = 18
  end
  object t_read: TpFIBTransaction
    DefaultDatabase = db
    Left = 87
    Top = 17
  end
  object t_write: TpFIBTransaction
    DefaultDatabase = db
    Left = 135
    Top = 17
  end
  object q1: TpFIBDataSet
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 189
    Top = 17
  end
  object con1: TADOConnection
    Left = 32
    Top = 72
  end
end
