object dm: Tdm
  OldCreateOrder = False
  Height = 519
  Width = 752
  object db: TpFIBDatabase
    AutoReconnect = True
    DBName = '192.168.0.7:lgs'
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
    DefaultDatabase = db
    Left = 87
    Top = 17
  end
  object t_write: TpFIBTransaction
    DefaultDatabase = db
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
      '')
    AllowedUpdateKinds = []
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 179
    Top = 214
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
    Left = 91
    Top = 128
    object fbntgrfld1: TFIBIntegerField
      FieldName = 'ID_CLIENTE'
    end
  end
  object qReportResumen: TpFIBDataSet
    SelectSQL.Strings = (
      
        'SELECT id_cliente,id_ceco, id_zona, zona_nom, peso, sum(uds) as ' +
        'uds, sum(uds*tarifa) as subtotal'
      'FROM mv_correos_reports r'
      'WHERE ((r.id_cliente=:cliente) or (:todo_cl=1)) and'
      '      ((r.id_ceco=:ceco) or (:todo_cc=1)) and'
      '      r.fecha between :f1 and :f2'
      'group by id_cliente, id_ceco, id_zona, zona_nom, peso'
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
      Size = 8
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
    object lgsID_ZONA: TFIBIntegerField
      FieldName = 'ID_ZONA'
    end
    object qfileESTADO: TFIBStringField
      FieldName = 'ESTADO'
      Size = 1
      EmptyStrToNull = True
    end
    object lgsGEST_ALBARAN: TFIBIntegerField
      FieldName = 'GEST_ALBARAN'
    end
    object lgsGEST_DEST: TFIBIntegerField
      FieldName = 'GEST_DEST'
    end
  end
  object qfiltro_certif: TpFIBDataSet
    SelectSQL.Strings = (
      'select c.*'
      'from mv_correos_certificadas c'
      '')
    AfterScroll = qfiltro_certifAfterScroll
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 35
    Top = 226
    object lgs_certifID_CORREOS_CERTIFICADAS: TFIBIntegerField
      FieldName = 'ID_CORREOS_CERTIFICADAS'
    end
    object lgs_certifID_CLIENTE: TFIBIntegerField
      FieldName = 'ID_CLIENTE'
    end
    object lgs_certifID_CECO: TFIBIntegerField
      FieldName = 'ID_CECO'
    end
    object lgs_certifID_PRODUCTO: TFIBIntegerField
      FieldName = 'ID_PRODUCTO'
    end
    object lgs_certifID_ZONA: TFIBIntegerField
      FieldName = 'ID_ZONA'
    end
    object qfiltro_certifFECHA: TFIBDateField
      FieldName = 'FECHA'
    end
    object qfiltro_certifVERSION: TFIBStringField
      FieldName = 'VERSION'
      Size = 8
      EmptyStrToNull = True
    end
    object qfiltro_certifPRODUCTO_PAQ: TFIBStringField
      FieldName = 'PRODUCTO_PAQ'
      Size = 5
      EmptyStrToNull = True
    end
    object lgs_certifBULTOS: TFIBIntegerField
      FieldName = 'BULTOS'
    end
    object qfiltro_certifEMPRESA: TFIBStringField
      FieldName = 'EMPRESA'
      Size = 150
      EmptyStrToNull = True
    end
    object qfiltro_certifDIRECCION: TFIBStringField
      FieldName = 'DIRECCION'
      Size = 100
      EmptyStrToNull = True
    end
    object qfiltro_certifLOCALIDAD: TFIBStringField
      FieldName = 'LOCALIDAD'
      Size = 100
      EmptyStrToNull = True
    end
    object qfiltro_certifPROVINCIA: TFIBStringField
      FieldName = 'PROVINCIA'
      Size = 40
      EmptyStrToNull = True
    end
    object qfiltro_certifCP: TFIBStringField
      FieldName = 'CP'
      Size = 8
      EmptyStrToNull = True
    end
    object qfiltro_certifPAIS: TFIBStringField
      FieldName = 'PAIS'
      Size = 2
      EmptyStrToNull = True
    end
    object qfiltro_certifMODALIDAD: TFIBStringField
      FieldName = 'MODALIDAD'
      Size = 2
      EmptyStrToNull = True
    end
    object qfiltro_certifREFERENCIA: TFIBStringField
      FieldName = 'REFERENCIA'
      Size = 100
      EmptyStrToNull = True
    end
    object lgs_certifPESO: TFIBFloatField
      FieldName = 'PESO'
    end
    object lgs_certifALTO: TFIBFloatField
      FieldName = 'ALTO'
    end
    object lgs_certifANCHO: TFIBFloatField
      FieldName = 'ANCHO'
    end
    object lgs_certifLARGO: TFIBFloatField
      FieldName = 'LARGO'
    end
    object lgs_certifINTENTOS: TFIBIntegerField
      FieldName = 'INTENTOS'
    end
    object lgs_certifEN_LISTA: TFIBIntegerField
      FieldName = 'EN_LISTA'
    end
    object qfiltro_certifPTO_ADMISION: TFIBStringField
      FieldName = 'PTO_ADMISION'
      Size = 7
      EmptyStrToNull = True
    end
    object lgs_certifFILE_DATE: TFIBDateTimeField
      FieldName = 'FILE_DATE'
    end
    object qfiltro_certifFILE_NAME: TFIBStringField
      FieldName = 'FILE_NAME'
      Size = 100
      EmptyStrToNull = True
    end
    object lgs_certifFILE_USUARIO: TFIBIntegerField
      FieldName = 'FILE_USUARIO'
    end
    object qfiltro_certifFILE_PATH: TFIBStringField
      FieldName = 'FILE_PATH'
      Size = 100
      EmptyStrToNull = True
    end
    object lgs_certifFECHA_INSERT: TFIBDateTimeField
      FieldName = 'FECHA_INSERT'
    end
    object lgs_certifUSUARIO_INSERT: TFIBIntegerField
      FieldName = 'USUARIO_INSERT'
    end
    object lgs_certifFECHA_UPDATE: TFIBDateTimeField
      FieldName = 'FECHA_UPDATE'
    end
    object lgs_certifUSUARIO_UPDATE: TFIBIntegerField
      FieldName = 'USUARIO_UPDATE'
    end
    object lgs_certifIDX_SOBRE: TFIBIntegerField
      FieldName = 'IDX_SOBRE'
    end
    object qfiltro_certifEMP_RMT: TFIBStringField
      FieldName = 'EMP_RMT'
      Size = 150
      EmptyStrToNull = True
    end
    object qfiltro_certifCTO_RMT: TFIBStringField
      FieldName = 'CTO_RMT'
      Size = 150
      EmptyStrToNull = True
    end
    object qfiltro_certifVIA_RMT: TFIBStringField
      FieldName = 'VIA_RMT'
      Size = 3
      EmptyStrToNull = True
    end
    object qfiltro_certifDIR_RMT: TFIBStringField
      FieldName = 'DIR_RMT'
      Size = 100
      EmptyStrToNull = True
    end
    object qfiltro_certifLOC_RMT: TFIBStringField
      FieldName = 'LOC_RMT'
      Size = 100
      EmptyStrToNull = True
    end
    object qfiltro_certifPRV_RMT: TFIBStringField
      FieldName = 'PRV_RMT'
      Size = 40
      EmptyStrToNull = True
    end
    object qfiltro_certifCP_RMT: TFIBStringField
      FieldName = 'CP_RMT'
      Size = 5
      EmptyStrToNull = True
    end
    object qfiltro_certifBARCODE: TFIBStringField
      FieldName = 'BARCODE'
      Size = 13
      EmptyStrToNull = True
    end
    object qfiltro_certifACUSE: TFIBStringField
      FieldName = 'ACUSE'
      Size = 3
      EmptyStrToNull = True
    end
    object qfiltro_certifTIPO: TFIBStringField
      FieldName = 'TIPO'
      Size = 1
      EmptyStrToNull = True
    end
    object qfiltro_certifESTADO: TFIBStringField
      FieldName = 'ESTADO'
      Size = 1
      EmptyStrToNull = True
    end
    object lgs_certifGEST_ALBARAN: TFIBIntegerField
      FieldName = 'GEST_ALBARAN'
    end
    object lgs_certifGEST_DEST: TFIBIntegerField
      FieldName = 'GEST_DEST'
    end
    object qfiltro_certifPROD_NOM: TFIBStringField
      FieldName = 'PROD_NOM'
      Size = 250
      EmptyStrToNull = True
    end
    object qfiltro_certifZONA_NOM: TFIBStringField
      FieldName = 'ZONA_NOM'
      Size = 50
      EmptyStrToNull = True
    end
  end
  object qRepCert: TpFIBDataSet
    SelectSQL.Strings = (
      '')
    AllowedUpdateKinds = []
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 103
    Top = 274
  end
  object db_ss: TpFIBDatabase
    AutoReconnect = True
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
    DefaultDatabase = db_ss
    Left = 382
    Top = 143
  end
  object t_write_ss: TpFIBTransaction
    DefaultDatabase = db_ss
    Left = 442
    Top = 142
  end
  object qCP: TpFIBDataSet
    SelectSQL.Strings = (
      ' select l.codigo_postal,l.titulo,p.titulo'
      ' from sys_localidades l'
      
        ' inner join sys_provincias p on p.provincia=l.provincia and p.pa' +
        'is=l.pais'
      ' where ( (l.codigo_postal like :cp||'#39'%'#39'))'
      ' order by l.codigo_postal Asc')
    AllowedUpdateKinds = []
    Transaction = t_read_gestoras
    Database = db_gestoras
    UpdateTransaction = t_write_gestoras
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
      '')
    AllowedUpdateKinds = []
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 180
    Top = 266
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
    Left = 29
    Top = 119
  end
  object qryCDS: TpFIBDataSet
    SelectSQL.Strings = (
      ' select l.codigo_postal,l.titulo,p.titulo'
      ' from sys_localidades l'
      
        ' inner join sys_provincias p on p.provincia=l.provincia and p.pa' +
        'is=l.pais'
      ' where ( (l.codigo_postal like '#39'%'#39' ||:cp||'#39'%'#39'))'
      ' order by l.codigo_postal Asc')
    AllowedUpdateKinds = []
    Transaction = t_read
    Database = db
    Left = 254
    Top = 187
  end
  object qryProdCorr: TpFIBDataSet
    SelectSQL.Strings = (
      ' select l.codigo_postal,l.titulo,p.titulo'
      ' from sys_localidades l'
      
        ' inner join sys_provincias p on p.provincia=l.provincia and p.pa' +
        'is=l.pais'
      ' where ( (l.codigo_postal like '#39'%'#39' ||:cp||'#39'%'#39'))'
      ' order by l.codigo_postal Asc')
    AllowedUpdateKinds = []
    Transaction = t_read
    Database = db
    Left = 310
    Top = 187
  end
  object q_aux: TpFIBDataSet
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
    Left = 363
    Top = 18
  end
  object qryTemp: TpFIBDataSet
    SelectSQL.Strings = (
      ' select l.codigo_postal,l.titulo,p.titulo'
      ' from sys_localidades l'
      
        ' inner join sys_provincias p on p.provincia=l.provincia and p.pa' +
        'is=l.pais'
      ' where ( (l.codigo_postal like '#39'%'#39' ||:cp||'#39'%'#39'))'
      ' order by l.codigo_postal Asc')
    AllowedUpdateKinds = []
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write_ss
    Left = 430
    Top = 307
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
    Left = 548
    Top = 86
  end
  object t_read_gestoras: TpFIBTransaction
    DefaultDatabase = db_gestoras
    Left = 548
    Top = 30
  end
  object t_write_gestoras: TpFIBTransaction
    DefaultDatabase = db_gestoras
    Left = 540
    Top = 139
  end
  object qTempGest: TpFIBDataSet
    Transaction = t_read_gestoras
    Database = db_gestoras
    UpdateTransaction = t_write_gestoras
    Left = 484
    Top = 25
  end
  object busqueda_gest: TpFIBDataSet
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
    Transaction = t_read_gestoras
    Database = db_gestoras
    UpdateTransaction = t_write_gestoras
    Left = 531
    Top = 202
  end
  object dsbusqueda_gest: TDataSource
    DataSet = busqueda_gest
    Left = 526
    Top = 249
  end
  object xEtiquetas: TpFIBDataSet
    SelectSQL.Strings = (
      'select * from tmp_lst_etiquetas'
      'where usuario=:usuario'
      '')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 265
    Top = 135
    object xEtiquetasUSUARIO: TFIBIntegerField
      FieldName = 'USUARIO'
    end
    object xEtiquetasID_ALBARAN: TFIBIntegerField
      FieldName = 'ID_ALBARAN'
    end
  end
  object RESTResponse1: TRESTResponse
    Left = 160
    Top = 63
  end
  object RESTRequest1: TRESTRequest
    Accept = 'application/json;q=0.9,text/plain;q=0.9,text/html'
    AcceptCharset = 'UTF-8, *; q=0.8'
    Client = RESTClient1
    Method = rmPUT
    Params = <>
    Response = RESTResponse1
    Timeout = 0
    SynchronizedEvents = False
    Left = 96
    Top = 71
  end
  object RESTClient1: TRESTClient
    Authenticator = auth
    Accept = 'application/json;q=0.9,text/plain;q=0.9,text/html'
    AcceptCharset = 'UTF-8, *;q=0.8'
    BaseURL = 
      'https://servertest.loginser.com:5443/loginser-back/api/albaran/1' +
      '8003103/validate'
    ContentType = 'application/json'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    Left = 24
    Top = 63
  end
  object auth: THTTPBasicAuthenticator
    Username = 'admin@belike.com'
    Password = 'password'
    Left = 176
    Top = 112
  end
  object stpGrabaAlb: TpFIBStoredProc
    Left = 40
    Top = 344
  end
  object q1: TpFIBDataSet
    SelectSQL.Strings = (
      'select * from tmp_lst_etiquetas'
      'where usuario=:usuario'
      '')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 17
    Top = 404
    object lgs1: TFIBIntegerField
      FieldName = 'USUARIO'
    end
    object lgs2: TFIBIntegerField
      FieldName = 'ID_ALBARAN'
    end
  end
  object xAlbaran: TpFIBDataSet
    SelectSQL.Strings = (
      'select bultos,peso'
      'from albaranes '
      'where id_albaran=:id_albaran'
      '')
    Transaction = t_read_gestoras
    Database = db_gestoras
    UpdateTransaction = t_write_gestoras
    Left = 89
    Top = 404
    object lgsAlbaranBULTOS: TFIBSmallIntField
      FieldName = 'BULTOS'
    end
    object lgsAlbaranPESO: TFIBFloatField
      FieldName = 'PESO'
    end
  end
  object xBultos: TpFIBDataSet
    SelectSQL.Strings = (
      'select count(*) as bultos from albaran_bultos'
      'where id_albaran=:id_albaran')
    Transaction = t_read_gestoras
    Database = db_gestoras
    UpdateTransaction = t_write_gestoras
    Left = 153
    Top = 404
    object lgsBultosBULTOS: TFIBIntegerField
      FieldName = 'BULTOS'
    end
  end
  object xSigBulto: TpFIBDataSet
    SelectSQL.Strings = (
      'select max(bulto) max_bulto from albaran_bultos'
      'where id_albaran=:id_albaran')
    Transaction = t_read_gestoras
    Database = db_gestoras
    UpdateTransaction = t_write_gestoras
    Left = 209
    Top = 404
    object lgsSigBultoMAX_BULTO: TFIBSmallIntField
      FieldName = 'MAX_BULTO'
    end
  end
  object qPedidoLines: TpFIBDataSet
    SelectSQL.Strings = (
      'select id_articulo, cantidad, kgs, nombre_art, imei'
      'from c_pedidos_lines'
      'where id_pedido=:id_pedido')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 273
    Top = 404
    object lgsPedidoLinesID_ARTICULO: TFIBIntegerField
      FieldName = 'ID_ARTICULO'
    end
    object lgsPedidoLinesCANTIDAD: TFIBIntegerField
      FieldName = 'CANTIDAD'
    end
    object lgsPedidoLinesKGS: TFIBFloatField
      FieldName = 'KGS'
    end
    object qPedidoLinesNOMBRE_ART: TFIBStringField
      FieldName = 'NOMBRE_ART'
      Size = 100
      EmptyStrToNull = True
    end
    object qPedidoLinesIMEI: TFIBWideStringField
      FieldName = 'IMEI'
      Size = 15
      EmptyStrToNull = True
    end
  end
  object q_ped_extra: TpFIBDataSet
    SelectSQL.Strings = (
      ' select l.codigo_postal,l.titulo,p.titulo'
      ' from sys_localidades l'
      
        ' inner join sys_provincias p on p.provincia=l.provincia and p.pa' +
        'is=l.pais'
      ' where ( (l.codigo_postal like '#39'%'#39' ||:cp||'#39'%'#39'))'
      ' order by l.codigo_postal Asc')
    AllowedUpdateKinds = []
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write_ss
    Left = 582
    Top = 395
  end
  object q_picks_lotes: TpFIBDataSet
    SelectSQL.Strings = (
      ' select l.codigo_postal,l.titulo,p.titulo'
      ' from sys_localidades l'
      
        ' inner join sys_provincias p on p.provincia=l.provincia and p.pa' +
        'is=l.pais'
      ' where ( (l.codigo_postal like '#39'%'#39' ||:cp||'#39'%'#39'))'
      ' order by l.codigo_postal Asc')
    AllowedUpdateKinds = []
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write_ss
    Left = 646
    Top = 403
  end
end
