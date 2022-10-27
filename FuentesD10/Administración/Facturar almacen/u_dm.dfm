object dm: Tdm
  OldCreateOrder = False
  Height = 383
  Width = 818
  object db: TpFIBDatabase
    AutoReconnect = True
    Connected = True
    DBName = 'nut:lgs'
    DBParams.Strings = (
      'password=masterkey'
      'user_name=SYSDBA'
      'lc_ctype=ISO8859_1')
    DefaultTransaction = t_read
    DefaultUpdateTransaction = t_write
    SQLDialect = 3
    Timeout = 0
    AliasName = 'LGS_buena'
    WaitForRestoreConnect = 0
    Left = 40
    Top = 24
  end
  object t_read: TpFIBTransaction
    Active = True
    DefaultDatabase = db
    TimeoutAction = TARollback
    Left = 86
    Top = 24
  end
  object t_write: TpFIBTransaction
    DefaultDatabase = db
    TimeoutAction = TARollback
    Left = 133
    Top = 23
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
    Left = 201
    Top = 24
  end
  object dsbusqueda: TDataSource
    DataSet = busqueda
    Left = 275
    Top = 24
  end
  object qry_tmp: TpFIBDataSet
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
    Left = 41
    Top = 104
  end
  object qry_tmp2: TpFIBDataSet
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
    Left = 41
    Top = 152
  end
  object qry_tmp4: TpFIBDataSet
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
    Left = 41
    Top = 248
  end
  object qry_tmp3: TpFIBDataSet
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
    Left = 41
    Top = 200
  end
  object qry_contador: TpFIBDataSet
    Transaction = t_read
    Database = db
    Left = 113
    Top = 104
  end
  object dbF: TpFIBDatabase
    AutoReconnect = True
    Connected = True
    DBName = 'nut:c:\FB\LGSF_TEST\LGSF.FDB'
    DBParams.Strings = (
      'password=masterkey'
      'user_name=SYSDBA'
      'lc_ctype=UTF8')
    DefaultTransaction = t_readF
    DefaultUpdateTransaction = t_writeF
    SQLDialect = 3
    Timeout = 0
    AliasName = 'lgsf'
    WaitForRestoreConnect = 0
    Left = 616
    Top = 24
  end
  object t_readF: TpFIBTransaction
    Active = True
    DefaultDatabase = dbF
    TimeoutAction = TARollback
    Left = 686
    Top = 24
  end
  object t_writeF: TpFIBTransaction
    DefaultDatabase = dbF
    TimeoutAction = TARollback
    Left = 741
    Top = 31
  end
  object calcula: TpFIBStoredProc
    Transaction = t_readF
    Database = dbF
    Left = 304
    Top = 160
  end
  object qry_sql: TADOQuery
    Connection = con_sql
    Parameters = <>
    Left = 562
    Top = 215
  end
  object con_sql: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=xzj2004MN4;Persist Security Info=Tr' +
      'ue;User ID=sa;Initial Catalog=loginser;Data Source=NUT'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 197
    Top = 206
  end
  object qryF_tmp: TpFIBDataSet
    Transaction = t_readF
    Database = dbF
    UpdateTransaction = t_writeF
    Left = 641
    Top = 112
  end
  object qryF_tmp2: TpFIBDataSet
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
    Transaction = t_readF
    Database = dbF
    UpdateTransaction = t_writeF
    Left = 705
    Top = 176
  end
  object qryf_tmp3: TpFIBDataSet
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
    Transaction = t_readF
    Database = dbF
    UpdateTransaction = t_writeF
    Left = 705
    Top = 248
  end
  object qryF_sql: TpFIBDataSet
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
    Transaction = t_readF
    Database = dbF
    UpdateTransaction = t_writeF
    Left = 561
    Top = 296
  end
  object qryF_tmp4: TpFIBDataSet
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
    Transaction = t_readF
    Database = dbF
    UpdateTransaction = t_writeF
    Left = 713
    Top = 120
  end
  object qry_aux: TpFIBDataSet
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
    Left = 113
    Top = 224
  end
  object qry_Entradas: TpFIBDataSet
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
    Left = 185
    Top = 112
  end
  object qry_EntradasAlm: TpFIBDataSet
    SelectSQL.Strings = (
      '--select * from a_recepcion_material '
      
        '--where id_cliente=:cliente and fecha between :ini and :fin and ' +
        'lineas between :min and :max'
      '--group by fecha'
      '--order by fecha'
      
        'select fecha, count(distinct(alb_cliente)) as Albaranes, count(l' +
        'ineas) as Lineas,sum(pales) as Pales, sum(imeis) as Imeis from a' +
        '_recepcion_material '
      
        'where id_cliente=:cliente and fecha between :ini and :fin and li' +
        'neas between :min and :max'
      'group by fecha'
      'order by fecha'
      ''
      ''
      '')
    Transaction = t_read
    Database = db
    Left = 33
    Top = 328
    object qry_EntradasAlmFECHA: TFIBDateField
      FieldName = 'FECHA'
    end
    object qry_EntradasAlmALBARANES: TFIBIntegerField
      FieldName = 'ALBARANES'
    end
    object qry_EntradasAlmLINEAS: TFIBIntegerField
      FieldName = 'LINEAS'
    end
    object qry_EntradasAlmPALES: TFIBBCDField
      FieldName = 'PALES'
      Size = 0
    end
  end
  object qry_EntradasUnidades: TpFIBDataSet
    SelectSQL.Strings = (
      
        'select fecha,alb_cliente, sum(uds_ini) from a_matriculas mat inn' +
        'er join g_articulos art on art.id_articulo=mat.id_articulo'
      
        'where art.id_cliente=:id and mat.estado='#39'A'#39' and fecha between :i' +
        'ni and :fin'
      'group by fecha,alb_cliente'
      'order by fecha asc')
    Transaction = t_read
    Database = db
    Left = 281
    Top = 328
  end
  object qryEntradasLineasExtra: TpFIBDataSet
    SelectSQL.Strings = (
      '--select * from a_recepcion_material '
      
        '--where id_cliente=:cliente and fecha between :ini and :fin and ' +
        'lineas between :min and :max'
      '--group by fecha'
      '--order by fecha'
      
        'select fecha, sum(lineas) as Lineas, count(fecha) as dias from a' +
        '_recepcion_material '
      
        'where id_cliente=:cliente and fecha between :ini and :fin and li' +
        'neas >= :min '
      'group by fecha'
      'order by fecha'
      ''
      ''
      '')
    Transaction = t_read
    Database = db
    Left = 145
    Top = 328
  end
  object qryF_exceso: TpFIBDataSet
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
    Transaction = t_readF
    Database = dbF
    UpdateTransaction = t_writeF
    Left = 641
    Top = 184
  end
  object qryextras: TpFIBDataSet
    SelectSQL.Strings = (
      'select servicio,descripcion,unidades,total,fecha,se_repite '
      
        'from a_servicios_extras where (id_cliente=:cli and estado='#39'A'#39' an' +
        'd ((fecha between :ini and :fin+1 and se_repite=0 )) or ( id_cli' +
        'ente=:cli and estado='#39'A'#39' and se_repite=1))')
    Transaction = t_readF
    Database = dbF
    Left = 385
    Top = 328
    object qGridCor1: TFIBStringField
      FieldName = 'SERVICIO'
      Size = 100
      EmptyStrToNull = True
    end
    object qGridCor2: TFIBStringField
      FieldName = 'DESCRIPCION'
      Size = 250
      EmptyStrToNull = True
    end
    object fbfltfld1: TFIBFloatField
      FieldName = 'UNIDADES'
    end
    object fbcdfld1: TFIBBCDField
      DefaultExpression = '0'
      FieldName = 'TOTAL'
      DisplayFormat = '#,##0.000'
      EditFormat = '0.000'
      Size = 3
    end
    object fbdtmfld1: TFIBDateTimeField
      FieldName = 'FECHA'
      DisplayFormat = 'dd.mm.yyyy hh:mm AMPM'
    end
    object fblnfld1: TFIBBooleanField
      DefaultExpression = 'False'
      FieldName = 'SE_REPITE'
    end
  end
  object qry_Devoluciones: TpFIBDataSet
    SelectSQL.Strings = (
      
        'select  cast (fecha_devo as date) as fecha, count(order_name) as' +
        ' order_name ,count(order_name) as uds  from ('
      
        ' select d.*, p.order_name as nombre, ar.id_articulo as id_articu' +
        'lo'
      ' from c_pedidos_devos d'
      ' left outer join c_pedidos p on p.id_pedido=d.id_pedido'
      
        ' left outer join c_pedidos_lines l on l.id_pedido=d.id_pedido an' +
        'd l.id_line=d.id_pedido_line'
      ' left outer join g_clientes cl on cl.id_cliente=p.id_cliente'
      ' left outer join g_articulos ar on ar.id_articulo=l.id_articulo'
      
        '-- where cast(file_date_imp as date) between :f1 and :f2 and d.e' +
        'stado_devo<>'#39'P'#39' and cl.id_cliente=:id'
      
        '  where cast(fecha_devo as date) between :f1 and :f2 and d.estad' +
        'o_devo<>'#39'P'#39' and cl.id_cliente=:id'
      ' )'
      ' group by fecha'
      ' order by fecha asc')
    Transaction = t_read
    Database = db
    Left = 113
    Top = 160
    object fbdtfld_DevolucionesFECHA: TFIBDateField
      FieldName = 'FECHA'
    end
    object qry_DevolucionesORDER_NAME: TFIBIntegerField
      FieldName = 'ORDER_NAME'
    end
    object fbntgrfld_DevolucionesUDS: TFIBIntegerField
      FieldName = 'UDS'
    end
  end
  object qryPreparacionPedidos: TpFIBDataSet
    Transaction = t_read
    Database = db
    Left = 305
    Top = 272
  end
  object qryF_limite: TpFIBDataSet
    Transaction = t_readF
    Database = dbF
    UpdateTransaction = t_writeF
    Left = 577
    Top = 112
  end
  object qryTiposPreparacion: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT'
      ' PED.ID_CLIENTE,'
      ' sum(imei) as IMEIS,'
      ' count(PED.id_cliente) as CANTIDAD '
      'FROM'
      '    A_PREPARACION_PEDIDOS ped'
      'WHERE'
      '  PED.fecha between :ini and :fin'
      '  and PED.ID_CLIENTE=:cli'
      'GROUP BY id_cliente')
    Transaction = t_read
    Database = db
    Left = 193
    Top = 272
    object fbntgrfldTiposPreparacionID_CLIENTE: TFIBIntegerField
      FieldName = 'ID_CLIENTE'
    end
    object fbcdfldTiposPreparacionIMEIS: TFIBBCDField
      FieldName = 'IMEIS'
      Size = 0
    end
    object fbntgrfldTiposPreparacionCANTIDAD: TFIBIntegerField
      FieldName = 'CANTIDAD'
    end
  end
  object qry_EntradasAlmMer: TpFIBDataSet
    SelectSQL.Strings = (
      ''
      
        'select fecha, count(distinct(alb_cliente)) as Albaranes, count(l' +
        'ineas) as Lineas,sum(pales) as Pales, sum(imeis) as Imeis from a' +
        '_recepcion_material '
      'where id_cliente=:cliente and fecha between :ini and :fin'
      'group by fecha'
      'order by fecha'
      ''
      ''
      '')
    Transaction = t_read
    Database = db
    Left = 305
    Top = 104
    object FIBDateField1: TFIBDateField
      FieldName = 'FECHA'
    end
    object FIBIntegerField1: TFIBIntegerField
      FieldName = 'ALBARANES'
    end
    object FIBIntegerField2: TFIBIntegerField
      FieldName = 'LINEAS'
    end
    object FIBBCDField1: TFIBBCDField
      FieldName = 'PALES'
      Size = 0
    end
    object fbcdfld_EntradasAlmMerIMEIS: TFIBBCDField
      FieldName = 'IMEIS'
      Size = 0
    end
  end
  object qry_numImeiPedido: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT'
      ' PED.ID_CLIENTE,'
      ' sum(cantidad) as cantidadImei'
      'FROM'
      '    A_PREPARACION_PEDIDOS ped'
      'WHERE'
      '  PED.fecha =:fecha'
      '  and PED.ID_CLIENTE=:cliente'
      '  and imei=1'
      'GROUP BY id_cliente')
    Transaction = t_read
    Database = db
    Left = 305
    Top = 216
    object fbntgrfld_numImeiPedidoID_CLIENTE: TFIBIntegerField
      FieldName = 'ID_CLIENTE'
    end
    object fbcdfld_numImeiPedidoCANTIDADIMEI: TFIBBCDField
      FieldName = 'CANTIDADIMEI'
      Size = 0
    end
  end
  object qry_grupoCliente: TpFIBDataSet
    Transaction = t_readF
    Database = dbF
    UpdateTransaction = t_writeF
    Left = 489
    Top = 112
  end
  object spInsertaMerydeis: TpFIBStoredProc
    Transaction = t_writeF
    Database = dbF
    SQL.Strings = (
      
        'EXECUTE PROCEDURE INSERTA_A_FACT_GRUPOS (?ID_GRUPO, ?COD_CLIENTE' +
        ', ?FECHA_FACT, ?ALMACEN, ?ENTRADAS, ?SALIDAS, ?EXTRAS, ?MODIF_FE' +
        'CHA, ?MODIF_USUARIO)')
    StoredProcName = 'INSERTA_A_FACT_GRUPOS'
    Left = 488
    Top = 168
  end
end
