object dm: Tdm
  OldCreateOrder = False
  Height = 407
  Width = 579
  object db: TpFIBDatabase
    AutoReconnect = True
    Connected = True
    DBName = '192.168.0.7:lgs'
    DBParams.Strings = (
      'password=masterkey'
      'user_name=SYSDBA'
      'lc_ctype=ISO8859_1')
    DefaultTransaction = t_read
    DefaultUpdateTransaction = t_write
    SQLDialect = 3
    Timeout = 0
    LibraryName = 'fbclient.dll'
    AliasName = 'lgs_exp'
    WaitForRestoreConnect = 0
    Left = 24
    Top = 16
  end
  object t_write: TpFIBTransaction
    DefaultDatabase = db
    TimeoutAction = TARollback
    Left = 108
    Top = 15
  end
  object t_read: TpFIBTransaction
    DefaultDatabase = db
    TimeoutAction = TARollback
    Left = 65
    Top = 15
  end
  object ds: TpFIBDataSet
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 74
    Top = 102
  end
  object qry_existe: TpFIBDataSet
    SelectSQL.Strings = (
      
        'select fecha,alb_cliente, count(distinct mat.id_articulo) from a' +
        '_matriculas mat inner join g_articulos art on art.id_articulo=ma' +
        't.id_articulo'
      
        'where art.id_cliente=:id and mat.estado='#39'A'#39' and fecha between :i' +
        'ni and :fin'
      'group by fecha,alb_cliente'
      'order by fecha asc')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 177
    Top = 144
  end
  object busqueda: TpFIBDataSet
    SelectSQL.Strings = (
      
        'SELECT CL.CODIGO, CL.NOMBRE, S.NOMBRE AS SERVICIO, C.DESCRIPCION' +
        ' AS CONCEPTO, ZN.DESCRIPCION AS ZONA, P.DESCRIPCION AS PESO,'
      'T.TARIFA, T.IMPORTE_FIJO, T.KM_EXTRA'
      'from c_tarifas t'
      'inner join g_clientes cl on cl.id_cliente=t.id_cliente'
      'inner join c_servicios s on s.id_servicio=t.id_servicio'
      
        'inner join c_tarifas_conceptos c on c.id_tarifa_concepto=t.id_co' +
        'ncepto'
      'inner join c_tarifas_zonas zn on zn.id_tarifa_zona=t.id_zona'
      'inner join c_tarifas_pesos p on p.id_tarifa_peso=t.id_peso'
      'where t.estado='#39'A'#39' and ((cl.codigo=:cod_cli) or (1= :todo))')
    Transaction = t_read
    Database = db
    Left = 193
    Top = 24
  end
  object dsbusqueda: TDataSource
    DataSet = busqueda
    Left = 275
    Top = 24
  end
  object qry_insertaBC: TpFIBQuery
    Transaction = t_write
    Database = db
    SQL.Strings = (
      
        'insert into g_articulos_bc (id_articulo,bc,estado,id_empresa) va' +
        'lues (?id_articulo,?bc,'#39'A'#39',1)')
    Left = 288
    Top = 120
  end
  object qry_aux: TpFIBDataSet
    SelectSQL.Strings = (
      
        'select fecha,alb_cliente, count(distinct mat.id_articulo) from a' +
        '_matriculas mat inner join g_articulos art on art.id_articulo=ma' +
        't.id_articulo'
      
        'where art.id_cliente=:id and mat.estado='#39'A'#39' and fecha between :i' +
        'ni and :fin'
      'group by fecha,alb_cliente'
      'order by fecha asc')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 121
    Top = 264
  end
end
