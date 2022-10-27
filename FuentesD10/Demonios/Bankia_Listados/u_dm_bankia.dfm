object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 275
  Width = 502
  object db_bankia: TpFIBDatabase
    Connected = True
    DBName = 'nut:lgs'
    DBParams.Strings = (
      'user_name=SYSDBA'
      'lc_ctype=ISO8859_1'
      'password=masterkey')
    DefaultTransaction = t_read
    DefaultUpdateTransaction = t_write
    SQLDialect = 3
    Timeout = 0
    LibraryName = 'fbclient.dll'
    WaitForRestoreConnect = 0
    Left = 34
    Top = 24
  end
  object t_read: TpFIBTransaction
    Active = True
    DefaultDatabase = db_bankia
    TimeoutAction = TARollback
    Left = 105
    Top = 24
  end
  object t_write: TpFIBTransaction
    DefaultDatabase = db_bankia
    TimeoutAction = TARollback
    Left = 166
    Top = 24
  end
  object qry: TpFIBDataSet
    SelectSQL.Strings = (
      'select *'
      'from g_queries'
      '/*where grupo=:grupo and estado='#39'A'#39'*/'
      'where id=140'
      '')
    Transaction = t_read
    Database = db_bankia
    UpdateTransaction = t_write
    AutoCommit = True
    Left = 239
    Top = 21
    object fbntgrfldID: TFIBIntegerField
      FieldName = 'ID'
    end
    object fbntgrfldGRUPO: TFIBIntegerField
      FieldName = 'GRUPO'
    end
    object fbstrngfldDESCRIPCION: TFIBStringField
      FieldName = 'DESCRIPCION'
      Size = 100
      EmptyStrToNull = True
    end
    object fblbfldQUERY: TFIBBlobField
      FieldName = 'QUERY'
      Size = 8
    end
    object fbntgrfldCOL: TFIBIntegerField
      FieldName = 'COL'
    end
    object fbstrngfldESTADO: TFIBStringField
      FieldName = 'ESTADO'
      Size = 1
      EmptyStrToNull = True
    end
    object fbstrngfldVARIABLES: TFIBStringField
      FieldName = 'VARIABLES'
      Size = 200
      EmptyStrToNull = True
    end
    object fbstrngfldCONEXION: TFIBStringField
      FieldName = 'CONEXION'
      Size = 3000
      EmptyStrToNull = True
    end
  end
  object qlistado: TpFIBDataSet
    Transaction = t_read
    Database = db_bankia
    UpdateTransaction = t_write
    AutoCommit = True
    Left = 319
    Top = 21
  end
  object xls: TXLSReadWriteII5
    ComponentVersion = '5.20.62'
    Version = xvExcel2007
    DirectRead = False
    DirectWrite = False
    Left = 85
    Top = 141
  end
  object spPtes: TpFIBStoredProc
    Transaction = t_write
    Database = db_bankia
    SQL.Strings = (
      'EXECUTE PROCEDURE BANKIA_PENDIENTES (?INI, ?FIN)')
    StoredProcName = 'BANKIA_PENDIENTES'
    Left = 402
    Top = 38
  end
  object qDelete: TpFIBQuery
    Transaction = t_write
    Database = db_bankia
    SQL.Strings = (
      'delete from e_temp_ptes')
    Left = 326
    Top = 88
  end
end
