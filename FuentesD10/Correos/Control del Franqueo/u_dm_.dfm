object dm: Tdm
  OldCreateOrder = False
  Height = 350
  Width = 524
  object db: TpFIBDatabase
    AutoReconnect = True
    Connected = True
    DBName = 'nut:lgsp'
    DBParams.Strings = (
      'user_name=SYSDBA'
      'password=masterkey'
      'lc_ctype=ISO8859_1')
    DefaultTransaction = t_read
    DefaultUpdateTransaction = t_write
    SQLDialect = 3
    Timeout = 0
    LibraryName = 'fbclient.dll'
    WaitForRestoreConnect = 0
    Left = 29
    Top = 18
  end
  object t_read: TpFIBTransaction
    Active = True
    DefaultDatabase = db
    TimeoutAction = TARollback
    Left = 87
    Top = 17
  end
  object t_write: TpFIBTransaction
    DefaultDatabase = db
    TimeoutAction = TARollback
    Left = 135
    Top = 16
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
    Left = 227
    Top = 18
  end
  object dsbusqueda: TDataSource
    DataSet = busqueda
    Left = 294
    Top = 17
  end
  object b_1: TpFIBDataSet
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 274
    Top = 74
  end
  object q_1: TpFIBQuery
    Transaction = t_write
    Database = db
    Left = 230
    Top = 73
  end
  object qReportDetalle: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT *'
      'FROM mv_correos_reports r'
      'WHERE ((r.id_cliente=:cliente) or (:todo_cl=1)) and'
      '      ((r.id_ceco=:ceco) or (:todo_cc=1)) and'
      '      r.fecha between :f1 and :f2 '
      'order by id_ceco,id_producto, fecha ')
    AllowedUpdateKinds = []
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 179
    Top = 214
    object fbntgrfldReportID_CLIENTE: TFIBIntegerField
      FieldName = 'ID_CLIENTE'
    end
    object fbntgrfldReportID_CECO: TFIBIntegerField
      FieldName = 'ID_CECO'
    end
    object fbntgrfldReportID_PRODUCTO: TFIBIntegerField
      FieldName = 'ID_PRODUCTO'
    end
    object fbdtmfldReportFECHA: TFIBDateTimeField
      FieldName = 'FECHA'
    end
    object fbntgrfldReportDetalleCLI_COD: TFIBIntegerField
      FieldName = 'CLI_COD'
    end
    object fbstrngfldReportDetalleCLI_NOM: TFIBStringField
      FieldName = 'CLI_NOM'
      Size = 100
      EmptyStrToNull = True
    end
    object fbstrngfldReportDetalleCECO_COD: TFIBStringField
      FieldName = 'CECO_COD'
      Size = 10
      EmptyStrToNull = True
    end
    object fbstrngfldReportDetalleCECO_NOM: TFIBStringField
      FieldName = 'CECO_NOM'
      Size = 50
      EmptyStrToNull = True
    end
    object fbstrngfldReportDetallePROD_NOM: TFIBStringField
      FieldName = 'PROD_NOM'
      Size = 250
      EmptyStrToNull = True
    end
    object fbntgrfldReportDetalleID_ZONA: TFIBIntegerField
      FieldName = 'ID_ZONA'
    end
    object fbstrngfldReportDetalleZONA_NOM: TFIBStringField
      FieldName = 'ZONA_NOM'
      Size = 50
      EmptyStrToNull = True
    end
    object fbntgrfldReportDetallePESO: TFIBIntegerField
      FieldName = 'PESO'
    end
    object fbcdfldReportDetalleTARIFA: TFIBBCDField
      FieldName = 'TARIFA'
      Size = 2
    end
    object fbcdfldReportDetalleUDS: TFIBBCDField
      FieldName = 'UDS'
      Size = 0
    end
    object fbcdfldReportDetalleSUBTOTAL: TFIBBCDField
      FieldName = 'SUBTOTAL'
      Size = 2
    end
  end
  object qReportBonificacion: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT distinct id_cliente'
      'FROM m_correos_reports r'
      'WHERE ((r.id_cliente=:cliente) or (:todo_cl=1)) and'
      '      ((r.id_ceco=:ceco) or (:todo_cc=1)) and'
      '      r.fecha between :f1 and :f2'
      'order by id_ceco,id_producto, fecha ')
    AllowedUpdateKinds = []
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 123
    Top = 96
    object fbntgrfld1: TFIBIntegerField
      FieldName = 'ID_CLIENTE'
    end
  end
  object qReportResumen: TpFIBDataSet
    SelectSQL.Strings = (
      
        'SELECT id_cliente,cli_nom, id_ceco, ceco_nom, id_zona, zona_nom,' +
        ' peso, sum(uds) as uds, sum(uds*tarifa) as subtotal'
      'FROM mv_correos_reports r'
      'WHERE ((r.id_cliente=:cliente) or (:todo_cl=1)) and'
      '      ((r.id_ceco=:ceco) or (:todo_cc=1)) and'
      '      r.fecha between :f1 and :f2'
      
        'group by id_cliente,cli_nom, id_ceco, ceco_nom, id_zona, zona_no' +
        'm, peso'
      'order by id_cliente, id_ceco, id_zona'
      ''
      ''
      ''
      ''
      '/*SELECT distinct id_cliente, id_ceco'
      'FROM m_correos_reports r'
      'WHERE ((r.id_cliente=:cliente) or (:todo_cl=1)) and'
      '      ((r.id_ceco=:ceco) or (:todo_cc=1)) and'
      '      r.fecha between :f1 and :f2'
      'order by id_ceco,id_producto, fecha*/')
    AllowedUpdateKinds = []
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 136
    Top = 155
    object fbntgrfldReportResumenID_CLIENTE: TFIBIntegerField
      FieldName = 'ID_CLIENTE'
    end
    object fbntgrfldReportResumenID_CECO: TFIBIntegerField
      FieldName = 'ID_CECO'
    end
    object fbcdfldReportResumenUDS: TFIBBCDField
      FieldName = 'UDS'
      Size = 0
    end
    object fbcdfldReportResumenSUBTOTAL: TFIBBCDField
      FieldName = 'SUBTOTAL'
      Size = 2
    end
    object fbstrngfldReportResumenCLI_NOM: TFIBStringField
      FieldName = 'CLI_NOM'
      Size = 100
      EmptyStrToNull = True
    end
    object fbstrngfldReportResumenCECO_NOM: TFIBStringField
      FieldName = 'CECO_NOM'
      Size = 50
      EmptyStrToNull = True
    end
    object fbntgrfldReportResumenPESO: TFIBIntegerField
      FieldName = 'PESO'
    end
  end
  object qfiltro: TpFIBDataSet
    SelectSQL.Strings = (
      'select uds from m_correos_reports '
      'where id_cliente=:cliente and fecha=:fecha and '
      'id_ceco=:ceco and id_producto=:producto and id_zona=:zona and '
      'peso=:peso')
    AllowedUpdateKinds = []
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 37
    Top = 166
    object fbntgrfldUDS: TFIBIntegerField
      FieldName = 'UDS'
    end
  end
  object dsfiltro_cert: TDataSource
    DataSet = qfiltro_certif
    Left = 104
    Top = 224
  end
  object qfile: TpFIBDataSet
    SelectSQL.Strings = (
      'select *'
      'from m_correos_certificadas c')
    AllowedUpdateKinds = []
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 36
    Top = 273
    object fbntgrfldID_CORREOS_CERTIFICADAS: TFIBIntegerField
      FieldName = 'ID_CORREOS_CERTIFICADAS'
    end
    object fbntgrfldID_CLIENTE: TFIBIntegerField
      FieldName = 'ID_CLIENTE'
    end
    object fbntgrfldID_CECO: TFIBIntegerField
      FieldName = 'ID_CECO'
    end
    object fbntgrfldID_PRODUCTO: TFIBIntegerField
      FieldName = 'ID_PRODUCTO'
    end
    object fbdtfldFECHA: TFIBDateField
      FieldName = 'FECHA'
    end
    object fbstrngfldVERSION: TFIBStringField
      FieldName = 'VERSION'
      Size = 8
      EmptyStrToNull = True
    end
    object fbstrngfldPRODUCTO_PAQ: TFIBStringField
      FieldName = 'PRODUCTO_PAQ'
      Size = 5
      EmptyStrToNull = True
    end
    object fbntgrfldBULTOS: TFIBIntegerField
      FieldName = 'BULTOS'
    end
    object fbstrngfldEMPRESA: TFIBStringField
      FieldName = 'EMPRESA'
      Size = 150
      EmptyStrToNull = True
    end
    object fbstrngfldDIRECCION: TFIBStringField
      FieldName = 'DIRECCION'
      Size = 100
      EmptyStrToNull = True
    end
    object fbstrngfldLOCALIDAD: TFIBStringField
      FieldName = 'LOCALIDAD'
      Size = 100
      EmptyStrToNull = True
    end
    object fbstrngfldPROVINCIA: TFIBStringField
      FieldName = 'PROVINCIA'
      Size = 40
      EmptyStrToNull = True
    end
    object fbstrngfldCP: TFIBStringField
      FieldName = 'CP'
      Size = 5
      EmptyStrToNull = True
    end
    object fbstrngfldPAIS: TFIBStringField
      FieldName = 'PAIS'
      Size = 2
      EmptyStrToNull = True
    end
    object fbstrngfldMODALIDAD: TFIBStringField
      FieldName = 'MODALIDAD'
      Size = 2
      EmptyStrToNull = True
    end
    object fbstrngfldREFERENCIA: TFIBStringField
      FieldName = 'REFERENCIA'
      Size = 100
      EmptyStrToNull = True
    end
    object fbfltfldPESO: TFIBFloatField
      FieldName = 'PESO'
    end
    object fbfltfldALTO: TFIBFloatField
      FieldName = 'ALTO'
    end
    object fbfltfldANCHO: TFIBFloatField
      FieldName = 'ANCHO'
    end
    object fbfltfldLARGO: TFIBFloatField
      FieldName = 'LARGO'
    end
    object fbntgrfldINTENTOS: TFIBIntegerField
      FieldName = 'INTENTOS'
    end
    object fbntgrfldEN_LISTA: TFIBIntegerField
      FieldName = 'EN_LISTA'
    end
    object fbstrngfldPTO_ADMISION: TFIBStringField
      FieldName = 'PTO_ADMISION'
      Size = 7
      EmptyStrToNull = True
    end
    object fbdtmfldFILE_DATE: TFIBDateTimeField
      FieldName = 'FILE_DATE'
    end
    object fbstrngfldFILE_NAME: TFIBStringField
      FieldName = 'FILE_NAME'
      Size = 100
      EmptyStrToNull = True
    end
    object fbntgrfldFILE_USUARIO: TFIBIntegerField
      FieldName = 'FILE_USUARIO'
    end
    object fbstrngfldFILE_PATH: TFIBStringField
      FieldName = 'FILE_PATH'
      Size = 100
      EmptyStrToNull = True
    end
    object fbdtmfldFECHA_INSERT: TFIBDateTimeField
      FieldName = 'FECHA_INSERT'
    end
    object fbntgrfldUSUARIO_INSERT: TFIBIntegerField
      FieldName = 'USUARIO_INSERT'
    end
    object fbdtmfldFECHA_UPDATE: TFIBDateTimeField
      FieldName = 'FECHA_UPDATE'
    end
    object fbntgrfldUSUARIO_UPDATE: TFIBIntegerField
      FieldName = 'USUARIO_UPDATE'
    end
    object fbntgrfldIDX_SOBRE: TFIBIntegerField
      FieldName = 'IDX_SOBRE'
    end
    object fbstrngfldEMP_RMT: TFIBStringField
      FieldName = 'EMP_RMT'
      Size = 150
      EmptyStrToNull = True
    end
    object fbstrngfldVIA_RMT: TFIBStringField
      FieldName = 'VIA_RMT'
      Size = 3
      EmptyStrToNull = True
    end
    object fbstrngfldDIR_RMT: TFIBStringField
      FieldName = 'DIR_RMT'
      Size = 100
      EmptyStrToNull = True
    end
    object fbstrngfldLOC_RMT: TFIBStringField
      FieldName = 'LOC_RMT'
      Size = 100
      EmptyStrToNull = True
    end
    object fbstrngfldPRV_RMT: TFIBStringField
      FieldName = 'PRV_RMT'
      Size = 40
      EmptyStrToNull = True
    end
    object fbstrngfldCP_RMT: TFIBStringField
      FieldName = 'CP_RMT'
      Size = 5
      EmptyStrToNull = True
    end
    object fbstrngfldBARCODE: TFIBStringField
      FieldName = 'BARCODE'
      Size = 13
      EmptyStrToNull = True
    end
    object fbstrngfldACUSE: TFIBStringField
      FieldName = 'ACUSE'
      Size = 3
      EmptyStrToNull = True
    end
    object fbstrngfldTIPO: TFIBStringField
      FieldName = 'TIPO'
      Size = 1
      EmptyStrToNull = True
    end
    object fbstrngfldCTO_RMT: TFIBStringField
      FieldName = 'CTO_RMT'
      Size = 150
      EmptyStrToNull = True
    end
  end
  object qfiltro_certif: TpFIBDataSet
    SelectSQL.Strings = (
      'select c.*, cl.codigo as cod_cli, cc.codigo as ceco'
      'from mv_correos_certificadas c'
      'inner join g_clientes cl on cl.id_cliente=c.id_cliente'
      'inner join g_clientes_cecos cc on cc.id_cliente_ceco=c.id_ceco')
    AfterScroll = qfiltro_certifAfterScroll
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 35
    Top = 226
    object fbntgrfld_certifID_CORREOS_CERTIFICADAS: TFIBIntegerField
      FieldName = 'ID_CORREOS_CERTIFICADAS'
    end
    object fbntgrfld_certifID_CLIENTE: TFIBIntegerField
      FieldName = 'ID_CLIENTE'
    end
    object fbntgrfld_certifID_CECO: TFIBIntegerField
      FieldName = 'ID_CECO'
    end
    object fbntgrfld_certifID_PRODUCTO: TFIBIntegerField
      FieldName = 'ID_PRODUCTO'
    end
    object fbdtfld_certifFECHA: TFIBDateField
      FieldName = 'FECHA'
    end
    object fbstrngfld_certifVERSION: TFIBStringField
      FieldName = 'VERSION'
      Size = 8
      EmptyStrToNull = True
    end
    object fbstrngfld_certifPRODUCTO_PAQ: TFIBStringField
      FieldName = 'PRODUCTO_PAQ'
      Size = 5
      EmptyStrToNull = True
    end
    object fbntgrfld_certifBULTOS: TFIBIntegerField
      FieldName = 'BULTOS'
    end
    object fbstrngfld_certifEMPRESA: TFIBStringField
      FieldName = 'EMPRESA'
      Size = 150
      EmptyStrToNull = True
    end
    object fbstrngfld_certifDIRECCION: TFIBStringField
      FieldName = 'DIRECCION'
      Size = 100
      EmptyStrToNull = True
    end
    object fbstrngfld_certifLOCALIDAD: TFIBStringField
      FieldName = 'LOCALIDAD'
      Size = 100
      EmptyStrToNull = True
    end
    object fbstrngfld_certifPROVINCIA: TFIBStringField
      FieldName = 'PROVINCIA'
      Size = 40
      EmptyStrToNull = True
    end
    object fbstrngfld_certifCP: TFIBStringField
      FieldName = 'CP'
      Size = 5
      EmptyStrToNull = True
    end
    object fbstrngfld_certifPAIS: TFIBStringField
      FieldName = 'PAIS'
      Size = 2
      EmptyStrToNull = True
    end
    object fbstrngfld_certifMODALIDAD: TFIBStringField
      FieldName = 'MODALIDAD'
      Size = 2
      EmptyStrToNull = True
    end
    object fbstrngfld_certifREFERENCIA: TFIBStringField
      FieldName = 'REFERENCIA'
      Size = 100
      EmptyStrToNull = True
    end
    object fbfltfld_certifPESO: TFIBFloatField
      FieldName = 'PESO'
    end
    object fbfltfld_certifALTO: TFIBFloatField
      FieldName = 'ALTO'
    end
    object fbfltfld_certifANCHO: TFIBFloatField
      FieldName = 'ANCHO'
    end
    object fbfltfld_certifLARGO: TFIBFloatField
      FieldName = 'LARGO'
    end
    object fbntgrfld_certifINTENTOS: TFIBIntegerField
      FieldName = 'INTENTOS'
    end
    object fbntgrfld_certifEN_LISTA: TFIBIntegerField
      FieldName = 'EN_LISTA'
    end
    object fbstrngfld_certifPTO_ADMISION: TFIBStringField
      FieldName = 'PTO_ADMISION'
      Size = 7
      EmptyStrToNull = True
    end
    object fbdtmfld_certifFILE_DATE: TFIBDateTimeField
      FieldName = 'FILE_DATE'
    end
    object fbstrngfld_certifFILE_NAME: TFIBStringField
      FieldName = 'FILE_NAME'
      Size = 100
      EmptyStrToNull = True
    end
    object fbntgrfld_certifFILE_USUARIO: TFIBIntegerField
      FieldName = 'FILE_USUARIO'
    end
    object fbstrngfld_certifFILE_PATH: TFIBStringField
      FieldName = 'FILE_PATH'
      Size = 100
      EmptyStrToNull = True
    end
    object fbdtmfld_certifFECHA_INSERT: TFIBDateTimeField
      FieldName = 'FECHA_INSERT'
    end
    object fbntgrfld_certifUSUARIO_INSERT: TFIBIntegerField
      FieldName = 'USUARIO_INSERT'
    end
    object fbdtmfld_certifFECHA_UPDATE: TFIBDateTimeField
      FieldName = 'FECHA_UPDATE'
    end
    object fbntgrfld_certifUSUARIO_UPDATE: TFIBIntegerField
      FieldName = 'USUARIO_UPDATE'
    end
    object fbntgrfld_certifIDX_SOBRE: TFIBIntegerField
      FieldName = 'IDX_SOBRE'
    end
    object fbstrngfld_certifEMP_RMT: TFIBStringField
      FieldName = 'EMP_RMT'
      Size = 150
      EmptyStrToNull = True
    end
    object fbstrngfld_certifVIA_RMT: TFIBStringField
      FieldName = 'VIA_RMT'
      Size = 3
      EmptyStrToNull = True
    end
    object fbstrngfld_certifDIR_RMT: TFIBStringField
      FieldName = 'DIR_RMT'
      Size = 100
      EmptyStrToNull = True
    end
    object fbstrngfld_certifLOC_RMT: TFIBStringField
      FieldName = 'LOC_RMT'
      Size = 100
      EmptyStrToNull = True
    end
    object fbstrngfld_certifPRV_RMT: TFIBStringField
      FieldName = 'PRV_RMT'
      Size = 40
      EmptyStrToNull = True
    end
    object fbstrngfld_certifCP_RMT: TFIBStringField
      FieldName = 'CP_RMT'
      Size = 5
      EmptyStrToNull = True
    end
    object fbstrngfld_certifBARCODE: TFIBStringField
      FieldName = 'BARCODE'
      Size = 13
      EmptyStrToNull = True
    end
    object fbstrngfld_certifACUSE: TFIBStringField
      FieldName = 'ACUSE'
      Size = 3
      EmptyStrToNull = True
    end
    object fbstrngfld_certifTIPO: TFIBStringField
      FieldName = 'TIPO'
      Size = 1
      EmptyStrToNull = True
    end
    object fbntgrfld_certifCOD_CLI: TFIBIntegerField
      FieldName = 'COD_CLI'
    end
    object fbstrngfld_certifCECO: TFIBStringField
      FieldName = 'CECO'
      Size = 10
      EmptyStrToNull = True
    end
    object fbstrngfld_certifCTO_RMT: TFIBStringField
      FieldName = 'CTO_RMT'
      Size = 150
      EmptyStrToNull = True
    end
    object fbntgrfld_certifID_ZONA: TFIBIntegerField
      FieldName = 'ID_ZONA'
    end
  end
  object qRepCert: TpFIBDataSet
    SelectSQL.Strings = (
      'select c.*, cl.codigo as cod_cli, cc.codigo as ceco '
      'from m_correos_certificadas c '
      'inner join g_clientes cl on cl.id_cliente=c.id_cliente '
      'inner join g_clientes_cecos cc on cc.id_cliente_ceco=c.id_ceco '
      'where fecha=:fecha')
    AllowedUpdateKinds = []
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 103
    Top = 274
    object fbntgrfldRepCertID_CORREOS_CERTIFICADAS: TFIBIntegerField
      FieldName = 'ID_CORREOS_CERTIFICADAS'
    end
    object fbntgrfldRepCertID_CLIENTE: TFIBIntegerField
      FieldName = 'ID_CLIENTE'
    end
    object fbntgrfldRepCertID_CECO: TFIBIntegerField
      FieldName = 'ID_CECO'
    end
    object fbntgrfldRepCertID_PRODUCTO: TFIBIntegerField
      FieldName = 'ID_PRODUCTO'
    end
    object fbdtfldRepCertFECHA: TFIBDateField
      FieldName = 'FECHA'
    end
    object fbstrngfldRepCertVERSION: TFIBStringField
      FieldName = 'VERSION'
      Size = 8
      EmptyStrToNull = True
    end
    object fbstrngfldRepCertPRODUCTO_PAQ: TFIBStringField
      FieldName = 'PRODUCTO_PAQ'
      Size = 5
      EmptyStrToNull = True
    end
    object fbntgrfldRepCertBULTOS: TFIBIntegerField
      FieldName = 'BULTOS'
    end
    object fbstrngfldRepCertEMPRESA: TFIBStringField
      FieldName = 'EMPRESA'
      Size = 150
      EmptyStrToNull = True
    end
    object fbstrngfldRepCertDIRECCION: TFIBStringField
      FieldName = 'DIRECCION'
      Size = 100
      EmptyStrToNull = True
    end
    object fbstrngfldRepCertLOCALIDAD: TFIBStringField
      FieldName = 'LOCALIDAD'
      Size = 100
      EmptyStrToNull = True
    end
    object fbstrngfldRepCertPROVINCIA: TFIBStringField
      FieldName = 'PROVINCIA'
      Size = 40
      EmptyStrToNull = True
    end
    object fbstrngfldRepCertCP: TFIBStringField
      FieldName = 'CP'
      Size = 5
      EmptyStrToNull = True
    end
    object fbstrngfldRepCertPAIS: TFIBStringField
      FieldName = 'PAIS'
      Size = 2
      EmptyStrToNull = True
    end
    object fbstrngfldRepCertMODALIDAD: TFIBStringField
      FieldName = 'MODALIDAD'
      Size = 2
      EmptyStrToNull = True
    end
    object fbstrngfldRepCertREFERENCIA: TFIBStringField
      FieldName = 'REFERENCIA'
      Size = 100
      EmptyStrToNull = True
    end
    object fbfltfldRepCertPESO: TFIBFloatField
      FieldName = 'PESO'
    end
    object fbfltfldRepCertALTO: TFIBFloatField
      FieldName = 'ALTO'
    end
    object fbfltfldRepCertANCHO: TFIBFloatField
      FieldName = 'ANCHO'
    end
    object fbfltfldRepCertLARGO: TFIBFloatField
      FieldName = 'LARGO'
    end
    object fbntgrfldRepCertINTENTOS: TFIBIntegerField
      FieldName = 'INTENTOS'
    end
    object fbntgrfldRepCertEN_LISTA: TFIBIntegerField
      FieldName = 'EN_LISTA'
    end
    object fbstrngfldRepCertPTO_ADMISION: TFIBStringField
      FieldName = 'PTO_ADMISION'
      Size = 7
      EmptyStrToNull = True
    end
    object fbdtmfldRepCertFILE_DATE: TFIBDateTimeField
      FieldName = 'FILE_DATE'
    end
    object fbstrngfldRepCertFILE_NAME: TFIBStringField
      FieldName = 'FILE_NAME'
      Size = 100
      EmptyStrToNull = True
    end
    object fbntgrfldRepCertFILE_USUARIO: TFIBIntegerField
      FieldName = 'FILE_USUARIO'
    end
    object fbstrngfldRepCertFILE_PATH: TFIBStringField
      FieldName = 'FILE_PATH'
      Size = 100
      EmptyStrToNull = True
    end
    object fbdtmfldRepCertFECHA_INSERT: TFIBDateTimeField
      FieldName = 'FECHA_INSERT'
    end
    object fbntgrfldRepCertUSUARIO_INSERT: TFIBIntegerField
      FieldName = 'USUARIO_INSERT'
    end
    object fbdtmfldRepCertFECHA_UPDATE: TFIBDateTimeField
      FieldName = 'FECHA_UPDATE'
    end
    object fbntgrfldRepCertUSUARIO_UPDATE: TFIBIntegerField
      FieldName = 'USUARIO_UPDATE'
    end
    object fbntgrfldRepCertIDX_SOBRE: TFIBIntegerField
      FieldName = 'IDX_SOBRE'
    end
    object fbstrngfldRepCertEMP_RMT: TFIBStringField
      FieldName = 'EMP_RMT'
      Size = 150
      EmptyStrToNull = True
    end
    object fbstrngfldRepCertVIA_RMT: TFIBStringField
      FieldName = 'VIA_RMT'
      Size = 3
      EmptyStrToNull = True
    end
    object fbstrngfldRepCertDIR_RMT: TFIBStringField
      FieldName = 'DIR_RMT'
      Size = 100
      EmptyStrToNull = True
    end
    object fbstrngfldRepCertLOC_RMT: TFIBStringField
      FieldName = 'LOC_RMT'
      Size = 100
      EmptyStrToNull = True
    end
    object fbstrngfldRepCertPRV_RMT: TFIBStringField
      FieldName = 'PRV_RMT'
      Size = 40
      EmptyStrToNull = True
    end
    object fbstrngfldRepCertCP_RMT: TFIBStringField
      FieldName = 'CP_RMT'
      Size = 5
      EmptyStrToNull = True
    end
    object fbstrngfldRepCertBARCODE: TFIBStringField
      FieldName = 'BARCODE'
      Size = 13
      EmptyStrToNull = True
    end
    object fbstrngfldRepCertACUSE: TFIBStringField
      FieldName = 'ACUSE'
      Size = 3
      EmptyStrToNull = True
    end
    object fbstrngfldRepCertTIPO: TFIBStringField
      FieldName = 'TIPO'
      Size = 1
      EmptyStrToNull = True
    end
    object fbntgrfldRepCertCOD_CLI: TFIBIntegerField
      FieldName = 'COD_CLI'
    end
    object fbstrngfldRepCertCECO: TFIBStringField
      FieldName = 'CECO'
      Size = 10
      EmptyStrToNull = True
    end
  end
  object db_ss: TpFIBDatabase
    AutoReconnect = True
    Connected = True
    DBName = '192.168.0.4:e:\bbdd\ss\loginser.fdb'
    DBParams.Strings = (
      'password=masterkey'
      'user_name=SYSDBA'
      'lc_ctype=UTF8')
    DefaultTransaction = t_read_ss
    DefaultUpdateTransaction = t_write_ss
    SQLDialect = 1
    Timeout = 0
    LibraryName = 'fbclient.dll'
    AliasName = 'ss'
    WaitForRestoreConnect = 0
    Left = 416
    Top = 23
  end
  object busqueda_ss: TpFIBDataSet
    AllowedUpdateKinds = []
    Transaction = t_read_ss
    Database = db_ss
    UpdateTransaction = t_write_ss
    Left = 372
    Top = 85
  end
  object dsbusqueda_ss: TDataSource
    DataSet = busqueda_ss
    Left = 453
    Top = 84
  end
  object t_read_ss: TpFIBTransaction
    Active = True
    DefaultDatabase = db_ss
    TimeoutAction = TARollback
    Left = 382
    Top = 143
  end
  object t_write_ss: TpFIBTransaction
    Active = True
    DefaultDatabase = db_ss
    TimeoutAction = TARollback
    Left = 442
    Top = 142
  end
  object qCP: TpFIBDataSet
    SelectSQL.Strings = (
      ' select l.codigo_postal,l.titulo,p.titulo'
      ' from sys_localidades l'
      
        ' inner join sys_provincias p on p.provincia=l.provincia and p.pa' +
        'is=l.pais'
      ' where ( (l.codigo_postal like '#39'%'#39' ||:cp||'#39'%'#39'))'
      ' order by l.codigo_postal Asc')
    AllowedUpdateKinds = []
    Transaction = t_read_ss
    Database = db_ss
    UpdateTransaction = t_write_ss
    Left = 406
    Top = 203
  end
  object dsCP: TDataSource
    DataSet = qCP
    Left = 451
    Top = 203
  end
  object qReportDestinatario: TpFIBDataSet
    SelectSQL.Strings = (
      'SELECT * FROM mv_correos_certificadas r')
    AllowedUpdateKinds = []
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 180
    Top = 266
    object fbntgrfldReportDestinatarioID_CORREOS_CERTIFICADAS: TFIBIntegerField
      FieldName = 'ID_CORREOS_CERTIFICADAS'
    end
    object fbntgrfldReportDestinatarioID_CLIENTE: TFIBIntegerField
      FieldName = 'ID_CLIENTE'
    end
    object fbntgrfldReportDestinatarioID_CECO: TFIBIntegerField
      FieldName = 'ID_CECO'
    end
    object fbntgrfldReportDestinatarioID_PRODUCTO: TFIBIntegerField
      FieldName = 'ID_PRODUCTO'
    end
    object fbntgrfldReportDestinatarioID_ZONA: TFIBIntegerField
      FieldName = 'ID_ZONA'
    end
    object fbdtfldReportDestinatarioFECHA: TFIBDateField
      FieldName = 'FECHA'
    end
    object fbstrngfldReportDestinatarioVERSION: TFIBStringField
      FieldName = 'VERSION'
      Size = 8
      EmptyStrToNull = True
    end
    object fbstrngfldReportDestinatarioPRODUCTO_PAQ: TFIBStringField
      FieldName = 'PRODUCTO_PAQ'
      Size = 5
      EmptyStrToNull = True
    end
    object fbntgrfldReportDestinatarioBULTOS: TFIBIntegerField
      FieldName = 'BULTOS'
    end
    object fbstrngfldReportDestinatarioEMPRESA: TFIBStringField
      FieldName = 'EMPRESA'
      Size = 150
      EmptyStrToNull = True
    end
    object fbstrngfldReportDestinatarioDIRECCION: TFIBStringField
      FieldName = 'DIRECCION'
      Size = 100
      EmptyStrToNull = True
    end
    object fbstrngfldReportDestinatarioLOCALIDAD: TFIBStringField
      FieldName = 'LOCALIDAD'
      Size = 100
      EmptyStrToNull = True
    end
    object fbstrngfldReportDestinatarioPROVINCIA: TFIBStringField
      FieldName = 'PROVINCIA'
      Size = 40
      EmptyStrToNull = True
    end
    object fbstrngfldReportDestinatarioCP: TFIBStringField
      FieldName = 'CP'
      Size = 5
      EmptyStrToNull = True
    end
    object fbstrngfldReportDestinatarioPAIS: TFIBStringField
      FieldName = 'PAIS'
      Size = 2
      EmptyStrToNull = True
    end
    object fbstrngfldReportDestinatarioMODALIDAD: TFIBStringField
      FieldName = 'MODALIDAD'
      Size = 2
      EmptyStrToNull = True
    end
    object fbstrngfldReportDestinatarioREFERENCIA: TFIBStringField
      FieldName = 'REFERENCIA'
      Size = 100
      EmptyStrToNull = True
    end
    object fbfltfldReportDestinatarioPESO: TFIBFloatField
      FieldName = 'PESO'
    end
    object fbfltfldReportDestinatarioALTO: TFIBFloatField
      FieldName = 'ALTO'
    end
    object fbfltfldReportDestinatarioANCHO: TFIBFloatField
      FieldName = 'ANCHO'
    end
    object fbfltfldReportDestinatarioLARGO: TFIBFloatField
      FieldName = 'LARGO'
    end
    object fbntgrfldReportDestinatarioINTENTOS: TFIBIntegerField
      FieldName = 'INTENTOS'
    end
    object fbntgrfldReportDestinatarioEN_LISTA: TFIBIntegerField
      FieldName = 'EN_LISTA'
    end
    object fbstrngfldReportDestinatarioPTO_ADMISION: TFIBStringField
      FieldName = 'PTO_ADMISION'
      Size = 7
      EmptyStrToNull = True
    end
    object fbdtmfldReportDestinatarioFILE_DATE: TFIBDateTimeField
      FieldName = 'FILE_DATE'
    end
    object fbstrngfldReportDestinatarioFILE_NAME: TFIBStringField
      FieldName = 'FILE_NAME'
      Size = 100
      EmptyStrToNull = True
    end
    object fbntgrfldReportDestinatarioFILE_USUARIO: TFIBIntegerField
      FieldName = 'FILE_USUARIO'
    end
    object fbstrngfldReportDestinatarioFILE_PATH: TFIBStringField
      FieldName = 'FILE_PATH'
      Size = 100
      EmptyStrToNull = True
    end
    object fbdtmfldReportDestinatarioFECHA_INSERT: TFIBDateTimeField
      FieldName = 'FECHA_INSERT'
    end
    object fbntgrfldReportDestinatarioUSUARIO_INSERT: TFIBIntegerField
      FieldName = 'USUARIO_INSERT'
    end
    object fbdtmfldReportDestinatarioFECHA_UPDATE: TFIBDateTimeField
      FieldName = 'FECHA_UPDATE'
    end
    object fbntgrfldReportDestinatarioUSUARIO_UPDATE: TFIBIntegerField
      FieldName = 'USUARIO_UPDATE'
    end
    object fbntgrfldReportDestinatarioIDX_SOBRE: TFIBIntegerField
      FieldName = 'IDX_SOBRE'
    end
    object fbstrngfldReportDestinatarioEMP_RMT: TFIBStringField
      FieldName = 'EMP_RMT'
      Size = 150
      EmptyStrToNull = True
    end
    object fbstrngfldReportDestinatarioCTO_RMT: TFIBStringField
      FieldName = 'CTO_RMT'
      Size = 150
      EmptyStrToNull = True
    end
    object fbstrngfldReportDestinatarioVIA_RMT: TFIBStringField
      FieldName = 'VIA_RMT'
      Size = 3
      EmptyStrToNull = True
    end
    object fbstrngfldReportDestinatarioDIR_RMT: TFIBStringField
      FieldName = 'DIR_RMT'
      Size = 100
      EmptyStrToNull = True
    end
    object fbstrngfldReportDestinatarioLOC_RMT: TFIBStringField
      FieldName = 'LOC_RMT'
      Size = 100
      EmptyStrToNull = True
    end
    object fbstrngfldReportDestinatarioPRV_RMT: TFIBStringField
      FieldName = 'PRV_RMT'
      Size = 40
      EmptyStrToNull = True
    end
    object fbstrngfldReportDestinatarioCP_RMT: TFIBStringField
      FieldName = 'CP_RMT'
      Size = 5
      EmptyStrToNull = True
    end
    object fbstrngfldReportDestinatarioBARCODE: TFIBStringField
      FieldName = 'BARCODE'
      Size = 13
      EmptyStrToNull = True
    end
    object fbstrngfldReportDestinatarioACUSE: TFIBStringField
      FieldName = 'ACUSE'
      Size = 3
      EmptyStrToNull = True
    end
    object fbstrngfldReportDestinatarioTIPO: TFIBStringField
      FieldName = 'TIPO'
      Size = 1
      EmptyStrToNull = True
    end
    object fbstrngfldReportDestinatarioESTADO: TFIBStringField
      FieldName = 'ESTADO'
      Size = 1
      EmptyStrToNull = True
    end
    object fbntgrfldReportDestinatarioCLI_COD: TFIBIntegerField
      FieldName = 'CLI_COD'
    end
    object fbstrngfldReportDestinatarioCLI_NOM: TFIBStringField
      FieldName = 'CLI_NOM'
      Size = 100
      EmptyStrToNull = True
    end
    object fbstrngfldReportDestinatarioCECO_COD: TFIBStringField
      FieldName = 'CECO_COD'
      Size = 10
      EmptyStrToNull = True
    end
    object fbstrngfldReportDestinatarioCECO_NOM: TFIBStringField
      FieldName = 'CECO_NOM'
      Size = 50
      EmptyStrToNull = True
    end
    object fbstrngfldReportDestinatarioPROD_NOM: TFIBStringField
      FieldName = 'PROD_NOM'
      Size = 250
      EmptyStrToNull = True
    end
    object fbstrngfldReportDestinatarioZONA_NOM: TFIBStringField
      FieldName = 'ZONA_NOM'
      Size = 50
      EmptyStrToNull = True
    end
  end
  object dsfiltro_estados: TDataSource
    DataSet = qfiltro_estados
    Left = 335
    Top = 272
  end
  object qfiltro_estados: TpFIBDataSet
    SelectSQL.Strings = (
      'select *'
      'from m_correos_certificadas_estados')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 266
    Top = 274
    object fbntgrfld_estadosID_CORREOS_CERT_ESTADO: TFIBIntegerField
      FieldName = 'ID_CORREOS_CERT_ESTADO'
    end
    object fbntgrfld_estadosID_CORREOS_CERTIFICADA: TFIBIntegerField
      FieldName = 'ID_CORREOS_CERTIFICADA'
    end
    object fbstrngfld_estadosREFERENCIA: TFIBStringField
      FieldName = 'REFERENCIA'
      Size = 100
      EmptyStrToNull = True
    end
    object fbdtmfld_estadosFECHA: TFIBDateTimeField
      FieldName = 'FECHA'
      DisplayFormat = 'dd/mm/yyyy hh:nn'
    end
    object fbstrngfld_estadosESTADO: TFIBStringField
      FieldName = 'ESTADO'
      Size = 50
      EmptyStrToNull = True
    end
    object fbstrngfld_estadosLINEA: TFIBStringField
      FieldName = 'LINEA'
      Size = 200
      EmptyStrToNull = True
    end
    object fbdtmfld_estadosFECHA_INSERT: TFIBDateTimeField
      FieldName = 'FECHA_INSERT'
    end
  end
  object con1: TADOConnection
    Left = 37
    Top = 103
  end
end
