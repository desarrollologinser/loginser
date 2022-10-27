object dm: Tdm
  OldCreateOrder = False
  Height = 208
  Width = 494
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
  object con1: TADOConnection
    Left = 400
    Top = 32
  end
  object t_read_gestoras: TpFIBTransaction
    DefaultDatabase = db_gestoras
    Left = 97
    Top = 78
  end
  object t_write_gestoras: TpFIBTransaction
    DefaultDatabase = db_gestoras
    Left = 184
    Top = 78
  end
  object db_gestoras: TpFIBDatabase
    AutoReconnect = True
    DBName = '192.168.0.13:E:\BBDD\GESTORAS\LGS_GESTORAS_PRO.FDB'
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
    Left = 22
    Top = 78
  end
  object qryTemp: TpFIBDataSet
    Left = 288
    Top = 80
  end
  object qTempGest: TpFIBDataSet
    Left = 344
    Top = 80
  end
  object q_con: TpFIBDataSet
    SelectSQL.Strings = (
      
        'select l.sulinea,l.id_ruta as codruta,l.codalbaran,l.att,b.dst_n' +
        'ombre,b.dst_calle,b.dst_localidad,b.dst_provincia,b.dst_cp,'
      
        '    a.codigo as referencia,a.nombre as articulo,b.paquetes as nt' +
        'ot,l.n_parcial as n,l.id_packcab, l.id_agrupa,l.nivel_agr,l.line' +
        'a,c.logo_ind,b.id_caja'
      '        from a_packlin l'
      
        '        inner join a_packlin_bulto b on (l.id_packlin_bulto=b.id' +
        '_packlin_bulto)'
      
        '        inner join g_articulos a on (l.id_articulo=a.id_articulo' +
        ')'
      
        '        left outer join g_clientes_logos c on (c.codcli=b.codcli' +
        ' and c.dst_codcli=b.dst_codcli)'
      
        '        where l.id_packcab=5174 and l.id_agrupa=126 and l.nivel_' +
        'agr=1 and l.linea=10')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 192
    Top = 24
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
    Left = 243
    Top = 26
  end
  object dsbusqueda: TDataSource
    DataSet = busqueda
    Left = 300
    Top = 25
  end
end
