object dm1: Tdm1
  OldCreateOrder = False
  Height = 374
  Width = 408
  object db: TpFIBDatabase
    DBName = '192.168.0.7:lgs'
    DBParams.Strings = (
      'user_name=SYSDBA'
      'password=masterkey'
      'lc_ctype=ISO8859_1')
    SQLDialect = 3
    Timeout = 0
    LibraryName = 'fbclient.dll'
    WaitForRestoreConnect = 0
    Left = 187
    Top = 22
  end
  object qry: TpFIBQuery
    Transaction = read
    Database = db
    Left = 128
    Top = 24
  end
  object read: TpFIBTransaction
    DefaultDatabase = db
    Left = 288
    Top = 96
  end
  object qryIndice: TpFIBQuery
    Transaction = read
    Database = db
    Left = 24
    Top = 24
  end
  object qrydesubicados: TpFIBQuery
    Transaction = read
    Database = db
    SQL.Strings = (
      'SELECT CODIGO_CLI'
      'FROM G_ARTICULOS '
      'where not Exists(select * from a_stock '
      'inner join a_ubicaciones '
      'on a_ubicaciones.id_ubicacion=a_stock.id_ubicacion'
      'where a_stock.id_articulo=g_articulos.id_articulo)'
      'and id_empresa=1 '
      'and codigo like '#39'613107%'#39' '
      'and codigo_cli is not null')
    Left = 128
    Top = 80
  end
  object qrybusca: TpFIBQuery
    Transaction = read
    Database = db
    SQL.Strings = (
      'SELECT ID_ARTICULO'
      'FROM G_ARTICULOS '
      'where CODIGO_CLI=:cod and id_cliente=6131'
      'and id_empresa=1')
    Left = 208
    Top = 88
  end
  object qry_una_etiqueta: TpFIBQuery
    SQL.Strings = (
      'SELECT *'
      'FROM G_ARTICULOS '
      'where id_articulo=:id')
    Left = 48
    Top = 264
  end
  object qryarticulo: TpFIBQuery
    Transaction = read
    Database = db
    SQL.Strings = (
      'SELECT *'
      'FROM G_ARTICULOS '
      'where id_articulo=:id')
    Left = 24
    Top = 152
  end
  object qrymatriculas: TpFIBQuery
    Transaction = read
    Database = db
    SQL.Strings = (
      'SELECT *'
      'FROM A_matriculas'
      'where id_articulo=:id')
    Left = 32
    Top = 104
  end
  object qrycajas: TpFIBQuery
    Transaction = read
    Database = db
    SQL.Strings = (
      'SELECT *'
      'FROM A_cajas_aseval'
      'where etiqueta_caja=:id')
    Left = 72
    Top = 24
  end
  object qryentregados: TpFIBQuery
    Transaction = read
    Database = db
    SQL.Strings = (
      'SELECT *'
      'FROM A_cajas_solicitudes'
      'where entregado = 1 and devuelto is null')
    Left = 272
    Top = 24
  end
  object qrydevolver: TpFIBQuery
    Transaction = write
    Database = db
    SQL.Strings = (
      'update a_cajas_solicitudes '
      'set devuelto=1, fecha_devolucion=:f '
      'where id_solicitud_web=:id')
    Left = 112
    Top = 152
  end
  object write: TpFIBTransaction
    DefaultDatabase = db
    Left = 288
    Top = 160
  end
  object qrysolicitados: TpFIBQuery
    Transaction = read
    Database = db
    SQL.Strings = (
      'SELECT *'
      'FROM A_cajas_solicitudes'
      'where entregado is null or entregado=0')
    Left = 192
    Top = 152
  end
  object qryentregar: TpFIBQuery
    Transaction = write
    Database = db
    SQL.Strings = (
      'update a_cajas_solicitudes'
      'set entregado=1, fecha_entrega=:f'
      'where id_solicitud_web=:id')
    Left = 24
    Top = 208
  end
  object qryescribe: TpFIBQuery
    Transaction = write
    Database = db
    Left = 288
    Top = 216
  end
  object qrydevolverweb: TpFIBQuery
    Transaction = write
    Database = db
    SQL.Strings = (
      'select * from a_cajas_aseval '
      'where devolver=1')
    Left = 152
    Top = 232
  end
  object stock: TpFIBQuery
    Transaction = write
    Database = db
    Left = 232
    Top = 256
  end
  object existencias: TpFIBQuery
    Transaction = read
    Database = db
    Left = 312
    Top = 280
  end
end
