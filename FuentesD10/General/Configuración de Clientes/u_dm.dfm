object dm: Tdm
  OldCreateOrder = False
  Height = 536
  Width = 649
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
    Active = True
    DefaultDatabase = db
    TRParams.Strings = (
      'write'
      'isc_tpb_nowait'
      'read_committed'
      'rec_version')
    TPBMode = tpbDefault
    Left = 87
    Top = 17
  end
  object t_write: TpFIBTransaction
    DefaultDatabase = db
    Left = 135
    Top = 16
  end
  object spGetClienteConfig: TpFIBStoredProc
    Transaction = t_read
    Database = db
    SQL.Strings = (
      'EXECUTE PROCEDURE GET_CLIENTES_CONFIG (?ID_CLIENTE)')
    StoredProcName = 'GET_CLIENTES_CONFIG'
    Left = 208
    Top = 32
  end
end
