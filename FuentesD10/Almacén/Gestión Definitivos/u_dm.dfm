object dm: Tdm
  OldCreateOrder = False
  Height = 385
  Width = 657
  object db: TpFIBDatabase
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
    WaitForRestoreConnect = 0
    Left = 15
    Top = 22
  end
  object t_read: TpFIBTransaction
    Active = True
    DefaultDatabase = db
    Left = 55
    Top = 22
  end
  object t_write: TpFIBTransaction
    DefaultDatabase = db
    Left = 95
    Top = 22
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
    Left = 183
    Top = 25
  end
  object dsbusqueda: TDataSource
    DataSet = busqueda
    Left = 239
    Top = 25
  end
  object con1: TADOConnection
    Left = 24
    Top = 80
  end
  object db_gestoras: TpFIBDatabase
    DBName = '192.168.0.220:d:\fb\loginser_gestoras.fdb'
    DBParams.Strings = (
      'user_name=SYSDBA'
      'password=masterkey'
      'lc_ctype=ISO8859_1')
    DefaultTransaction = t_read_gestoras
    DefaultUpdateTransaction = t_write_gestoras
    SQLDialect = 1
    Timeout = 0
    LibraryName = 'fbclient.dll'
    WaitForRestoreConnect = 0
    Left = 315
    Top = 22
  end
  object t_read_gestoras: TpFIBTransaction
    DefaultDatabase = db_gestoras
    Left = 394
    Top = 22
  end
  object t_write_gestoras: TpFIBTransaction
    DefaultDatabase = db_gestoras
    Left = 465
    Top = 27
  end
  object qTempGest: TpFIBDataSet
    Transaction = t_read_gestoras
    Database = db_gestoras
    UpdateTransaction = t_write_gestoras
    Left = 337
    Top = 73
  end
  object qrytemp: TpFIBDataSet
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 425
    Top = 89
  end
end
