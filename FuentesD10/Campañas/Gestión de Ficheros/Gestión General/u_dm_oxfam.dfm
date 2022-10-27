object dm_oxf: Tdm_oxf
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 382
  Width = 500
  object db: TpFIBDatabase
    DBName = 'nut:lgs'
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
    BeforeConnect = dbBeforeConnect
    Left = 30
    Top = 18
  end
  object t_read: TpFIBTransaction
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
  object q_peds: TpFIBDataSet
    SelectSQL.Strings = (
      'select * from c_pedidos_oxfam')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 28
    Top = 121
    object fbntgrfld_pedsID_OXFAM: TFIBIntegerField
      FieldName = 'ID_OXFAM'
    end
    object fbntgrfld_pedsID_ORDER: TFIBIntegerField
      FieldName = 'ID_ORDER'
    end
    object fbstrngfld_pedsORDER_NAME: TFIBStringField
      FieldName = 'ORDER_NAME'
      EmptyStrToNull = True
    end
    object fbstrngfld_pedsNOMBRE: TFIBStringField
      FieldName = 'NOMBRE'
      Size = 100
      EmptyStrToNull = True
    end
    object fbstrngfld_pedsDIR_1: TFIBStringField
      FieldName = 'DIR_1'
      Size = 255
      EmptyStrToNull = True
    end
    object fbstrngfld_pedsDIR_2: TFIBStringField
      FieldName = 'DIR_2'
      Size = 255
      EmptyStrToNull = True
    end
    object fbstrngfld_pedsPOBLACION: TFIBStringField
      FieldName = 'POBLACION'
      Size = 100
      EmptyStrToNull = True
    end
    object fbstrngfld_pedsPROVINCIA: TFIBStringField
      FieldName = 'PROVINCIA'
      Size = 100
      EmptyStrToNull = True
    end
    object fbstrngfld_pedsCP: TFIBStringField
      FieldName = 'CP'
      EmptyStrToNull = True
    end
    object fbstrngfld_pedsPAIS: TFIBStringField
      FieldName = 'PAIS'
      Size = 100
      EmptyStrToNull = True
    end
    object fbstrngfld_pedsPAIS_ID: TFIBStringField
      FieldName = 'PAIS_ID'
      Size = 4
      EmptyStrToNull = True
    end
    object fbdtmfld_pedsFECHA_PED: TFIBDateTimeField
      FieldName = 'FECHA_PED'
    end
    object fbstrngfld_pedsTELEFONO: TFIBStringField
      FieldName = 'TELEFONO'
      EmptyStrToNull = True
    end
    object fbstrngfld_pedsEMAIL: TFIBStringField
      FieldName = 'EMAIL'
      Size = 200
      EmptyStrToNull = True
    end
    object fbntgrfld_pedsDELIVERY_TIME: TFIBIntegerField
      FieldName = 'DELIVERY_TIME'
    end
    object fbstrngfld_pedsTEXT: TFIBStringField
      FieldName = 'TEXT'
      Size = 255
      EmptyStrToNull = True
    end
    object fbdtmfld_pedsFECHA_IMP: TFIBDateTimeField
      FieldName = 'FECHA_IMP'
    end
    object fbdtmfld_pedsFECHA_GEN: TFIBDateTimeField
      FieldName = 'FECHA_GEN'
    end
    object fbdtmfld_pedsFECHA_FIN: TFIBDateTimeField
      FieldName = 'FECHA_FIN'
    end
    object fbstrngfld_pedsESTADO: TFIBStringField
      FieldName = 'ESTADO'
      Size = 1
      EmptyStrToNull = True
    end
    object fbntgrfld_pedsCODALBARAN: TFIBIntegerField
      FieldName = 'CODALBARAN'
    end
    object fbstrngfld_pedsOBSERVACIONES: TFIBStringField
      FieldName = 'OBSERVACIONES'
      Size = 255
      EmptyStrToNull = True
    end
    object q_pedsID_REPARTIDOR: TFIBIntegerField
      FieldName = 'ID_REPARTIDOR'
    end
    object q_pedsENVIADO: TFIBStringField
      FieldName = 'ENVIADO'
      Size = 1
      EmptyStrToNull = True
    end
    object q_pedsTRACKING_NUMBER: TFIBStringField
      FieldName = 'TRACKING_NUMBER'
      Size = 50
      EmptyStrToNull = True
    end
    object q_pedsBULTOS: TFIBIntegerField
      FieldName = 'BULTOS'
    end
  end
  object ds_peds: TDataSource
    DataSet = q_peds
    Left = 80
    Top = 119
  end
  object q_1: TpFIBQuery
    Transaction = t_write
    Database = db
    Left = 324
    Top = 135
  end
  object ds_1: TpFIBDataSet
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 368
    Top = 137
  end
  object ds_2: TpFIBDataSet
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 431
    Top = 140
  end
  object q_peds_count: TpFIBDataSet
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 34
    Top = 191
  end
  object con1: TADOConnection
    CommandTimeout = 120
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=xzj2004MN4;Persist Security Info=Tr' +
      'ue;User ID=sa;Initial Catalog=loginser;Data Source=NUT;Use Proce' +
      'dure for Prepare=1;Auto Translate=True;Packet Size=4096;Workstat' +
      'ion ID=INF004;Use Encryption for Data=False;Tag with column coll' +
      'ation when possible=False'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 196
    Top = 235
  end
  object qrytemp: TADOQuery
    Connection = con1
    CursorType = ctStatic
    LockType = ltReadOnly
    Parameters = <>
    Left = 251
    Top = 189
  end
  object stpGrabaSrv: TADOStoredProc
    Connection = con1
    ProcedureName = 'lgGrabaServicio_2;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@codservicio'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end
      item
        Name = '@tipo_servicio'
        Attributes = [paNullable]
        DataType = ftString
        Size = 2
        Value = Null
      end
      item
        Name = '@codcli'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@falta'
        Attributes = [paNullable]
        DataType = ftDateTime
        Value = Null
      end
      item
        Name = '@sureferencia'
        Attributes = [paNullable]
        DataType = ftString
        Size = 15
        Value = Null
      end
      item
        Name = '@codremitente'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 10
        Value = Null
      end
      item
        Name = '@org_nombre'
        Attributes = [paNullable]
        DataType = ftString
        Size = 60
        Value = Null
      end
      item
        Name = '@org_calle'
        Attributes = [paNullable]
        DataType = ftString
        Size = 60
        Value = Null
      end
      item
        Name = '@org_cp'
        Attributes = [paNullable]
        DataType = ftString
        Size = 5
        Value = Null
      end
      item
        Name = '@org_localidad'
        Attributes = [paNullable]
        DataType = ftString
        Size = 60
        Value = Null
      end
      item
        Name = '@org_provincia'
        Attributes = [paNullable]
        DataType = ftString
        Size = 60
        Value = Null
      end
      item
        Name = '@org_persona'
        Attributes = [paNullable]
        DataType = ftString
        Size = 60
        Value = Null
      end
      item
        Name = '@org_tfno'
        Attributes = [paNullable]
        DataType = ftString
        Size = 30
        Value = Null
      end
      item
        Name = '@coddestinatario'
        Attributes = [paNullable]
        DataType = ftBCD
        Precision = 10
        Value = Null
      end
      item
        Name = '@dst_nombre'
        Attributes = [paNullable]
        DataType = ftString
        Size = 60
        Value = Null
      end
      item
        Name = '@dst_calle'
        Attributes = [paNullable]
        DataType = ftString
        Size = 60
        Value = Null
      end
      item
        Name = '@dst_cp'
        Attributes = [paNullable]
        DataType = ftString
        Size = 5
        Value = Null
      end
      item
        Name = '@dst_localidad'
        Attributes = [paNullable]
        DataType = ftString
        Size = 60
        Value = Null
      end
      item
        Name = '@dst_provincia'
        Attributes = [paNullable]
        DataType = ftString
        Size = 60
        Value = Null
      end
      item
        Name = '@dst_persona'
        Attributes = [paNullable]
        DataType = ftString
        Size = 60
        Value = Null
      end
      item
        Name = '@dst_tfno'
        Attributes = [paNullable]
        DataType = ftString
        Size = 30
        Value = Null
      end
      item
        Name = '@observaciones'
        Attributes = [paNullable]
        DataType = ftString
        Size = 255
        Value = Null
      end
      item
        Name = '@codcli_paga'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@e_s_r'
        Attributes = [paNullable]
        DataType = ftString
        Size = 1
        Value = Null
      end
      item
        Name = '@codalbaran'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@codarticulo'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@refarticulo'
        Attributes = [paNullable]
        DataType = ftString
        Size = 15
        Value = Null
      end
      item
        Name = '@unidades'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@sulinea'
        Attributes = [paNullable]
        DataType = ftString
        Size = 20
        Value = Null
      end
      item
        Name = '@att'
        Attributes = [paNullable]
        DataType = ftString
        Size = 60
        Value = Null
      end
      item
        Name = '@org_codcli'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@org_coddel'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@dst_codcli'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@dst_coddel'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@kgs'
        Attributes = [paNullable]
        DataType = ftFloat
        Precision = 15
        Value = Null
      end
      item
        Name = '@DatosVAERSA'
        Attributes = [paNullable]
        DataType = ftString
        Size = 250
        Value = Null
      end
      item
        Name = '@CIFVAERSA'
        Attributes = [paNullable]
        DataType = ftString
        Size = 15
        Value = Null
      end
      item
        Name = '@TelVAERSA'
        Attributes = [paNullable]
        DataType = ftString
        Size = 15
        Value = Null
      end
      item
        Name = '@VAsegurado'
        Attributes = [paNullable]
        DataType = ftFloat
        Precision = 7
        Value = Null
      end
      item
        Name = '@Reembolso'
        Attributes = [paNullable]
        DataType = ftFloat
        Precision = 7
        Value = Null
      end
      item
        Name = '@codmovimiento'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end>
    Left = 252
    Top = 300
  end
  object q_sql5: TADOQuery
    Connection = con1
    Parameters = <>
    Left = 305
    Top = 192
  end
  object qryAlbEdit: TADOQuery
    Connection = con1
    Parameters = <
      item
        Name = 'codAlbaran'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      
        'select a.*,dbo.getUltimoEstado(a.codalbaran) Estado, dbo.getColo' +
        'rAlbaran(a.codalbaran) Color'
      'from Albaranes a'
      'where a.codAlbaran = :codAlbaran')
    Left = 257
    Top = 243
    object intgrfldAlbEditcodalbaran: TIntegerField
      FieldName = 'codalbaran'
    end
    object str_AlbEditserie: TStringField
      FieldName = 'serie'
      FixedChar = True
      Size = 2
    end
    object dtmfldAlbEditfecha: TDateTimeField
      FieldName = 'fecha'
    end
    object intgrfldAlbEditcodcli: TIntegerField
      FieldName = 'codcli'
    end
    object intgrfldAlbEditpaquetes: TIntegerField
      FieldName = 'paquetes'
    end
    object intgrfldAlbEditbultos: TIntegerField
      FieldName = 'bultos'
    end
    object bcdfldAlbEditkgs: TBCDField
      FieldName = 'kgs'
      Precision = 8
      Size = 1
    end
    object bcdfldAlbEditcodremitente: TBCDField
      FieldName = 'codremitente'
      Precision = 10
      Size = 0
    end
    object str_AlbEditorg_nombre: TStringField
      FieldName = 'org_nombre'
      Size = 60
    end
    object str_AlbEditorg_calle: TStringField
      FieldName = 'org_calle'
      Size = 60
    end
    object str_AlbEditorg_cp: TStringField
      FieldName = 'org_cp'
      FixedChar = True
      Size = 5
    end
    object str_AlbEditorg_localidad: TStringField
      FieldName = 'org_localidad'
      Size = 60
    end
    object str_AlbEditorg_provincia: TStringField
      FieldName = 'org_provincia'
      Size = 60
    end
    object str_AlbEditorg_persona: TStringField
      FieldName = 'org_persona'
      Size = 60
    end
    object str_AlbEditorg_tfno: TStringField
      FieldName = 'org_tfno'
      Size = 30
    end
    object bcdfldAlbEditcoddestinatario: TBCDField
      FieldName = 'coddestinatario'
      Precision = 10
      Size = 0
    end
    object str_AlbEditdst_nombre: TStringField
      FieldName = 'dst_nombre'
      Size = 60
    end
    object str_AlbEditdst_calle: TStringField
      FieldName = 'dst_calle'
      Size = 60
    end
    object str_AlbEditdst_cp: TStringField
      FieldName = 'dst_cp'
      FixedChar = True
      Size = 5
    end
    object str_AlbEditdst_localidad: TStringField
      FieldName = 'dst_localidad'
      Size = 60
    end
    object str_AlbEditdst_provincia: TStringField
      FieldName = 'dst_provincia'
      Size = 60
    end
    object str_AlbEditdst_persona: TStringField
      FieldName = 'dst_persona'
      Size = 60
    end
    object str_AlbEditdst_tfno: TStringField
      FieldName = 'dst_tfno'
      Size = 30
    end
    object bcdfldAlbEditasegurado: TBCDField
      FieldName = 'asegurado'
      Precision = 19
    end
    object bcdfldAlbEditpdebido: TBCDField
      FieldName = 'pdebido'
      Precision = 19
    end
    object bcdfldAlbEditreembolso: TBCDField
      FieldName = 'reembolso'
      Precision = 19
    end
    object intgrfldAlbEditEstado: TIntegerField
      FieldName = 'Estado'
      ReadOnly = True
    end
    object str_AlbEditColor: TStringField
      FieldName = 'Color'
      ReadOnly = True
      Size = 9
    end
    object str_AlbEditobservaciones: TStringField
      FieldName = 'observaciones'
      Size = 255
    end
    object smlntfldAlbEditkm: TSmallintField
      FieldName = 'km'
    end
    object dtmfldAlbEditarchivo: TDateTimeField
      FieldName = 'archivo'
    end
    object str_AlbEdite_s_r: TStringField
      FieldName = 'e_s_r'
      FixedChar = True
      Size = 1
    end
    object smlntfldAlbEditcodruta: TSmallintField
      FieldName = 'codruta'
    end
    object intgrfldAlbEditcodrepartidor: TIntegerField
      FieldName = 'codrepartidor'
    end
    object intgrfldAlbEditorg_codcli: TIntegerField
      FieldName = 'org_codcli'
    end
    object intgrfldAlbEditorg_coddel: TIntegerField
      FieldName = 'org_coddel'
    end
    object intgrfldAlbEditdst_codcli: TIntegerField
      FieldName = 'dst_codcli'
    end
    object intgrfldAlbEditdst_coddel: TIntegerField
      FieldName = 'dst_coddel'
    end
    object bcdfldAlbEditKgsVol: TBCDField
      FieldName = 'KgsVol'
      Precision = 8
      Size = 2
    end
  end
  object q_peds_lines: TpFIBDataSet
    SelectSQL.Strings = (
      'select l.*,a.codigo,l.nombre_art as nombre,l.sku as codigo_cli'
      'from c_pedidos_oxfam_lines l'
      'left outer join g_articulos a on (l.id_articulo=a.id_articulo) '
      'where l.id_oxfam=:id_oxfam')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    DataSource = ds_peds
    Left = 149
    Top = 120
    object fbntgrfld_peds_linesID_OXFAM: TFIBIntegerField
      FieldName = 'ID_OXFAM'
    end
    object fbntgrfld_peds_linesID_LINE: TFIBIntegerField
      FieldName = 'ID_LINE'
    end
    object fbntgrfld_peds_linesID_ARTICULO: TFIBIntegerField
      FieldName = 'ID_ARTICULO'
    end
    object fbntgrfld_peds_linesCANTIDAD: TFIBIntegerField
      FieldName = 'CANTIDAD'
    end
    object fbstrngfld_peds_linesSKU: TFIBStringField
      FieldName = 'SKU'
      EmptyStrToNull = True
    end
    object fbstrngfld_peds_linesNOMBRE_ART: TFIBStringField
      FieldName = 'NOMBRE_ART'
      Size = 100
      EmptyStrToNull = True
    end
    object fbntgrfld_peds_linesITEM_ID: TFIBIntegerField
      FieldName = 'ITEM_ID'
    end
    object fbstrngfld_peds_linesCODIGO: TFIBStringField
      FieldName = 'CODIGO'
      EmptyStrToNull = True
    end
    object fbstrngfld_peds_linesNOMBRE: TFIBStringField
      FieldName = 'NOMBRE'
      Size = 400
      EmptyStrToNull = True
    end
    object fbstrngfld_peds_linesCODIGO_CLI: TFIBStringField
      FieldName = 'CODIGO_CLI'
      EmptyStrToNull = True
    end
  end
  object dsbusqueda: TDataSource
    DataSet = busqueda
    Left = 278
    Top = 30
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
    Left = 208
    Top = 29
  end
  object cds_bultos: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'codcli'
        DataType = ftInteger
      end
      item
        Name = 'codalbaran'
        DataType = ftInteger
      end
      item
        Name = 'unidades'
        DataType = ftInteger
      end
      item
        Name = 'fecha'
        DataType = ftDateTime
      end
      item
        Name = 'codruta'
        DataType = ftInteger
      end
      item
        Name = 'coddst'
        DataType = ftString
        Size = 12
      end
      item
        Name = 'dst_nombre'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'dst_calle'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'dst_cp'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'dst_localidad'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'dst_provincia'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'bultos'
        DataType = ftInteger
      end
      item
        Name = 'observaciones'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'dst_tfno'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'dst_coddel'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'dst_persona'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'ordenbulto'
        DataType = ftInteger
      end
      item
        Name = 'codrepartidor'
        DataType = ftInteger
      end
      item
        Name = 'org_nombre'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'org_calle'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'org_cp'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'org_localidad'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'org_tfno'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'reembolso'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'referencia'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'kgs'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'sempor'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'chrono_exp'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'chrono_ref'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'codbulto'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'pdf417'
        DataType = ftString
        Size = 1000
      end
      item
        Name = 'logo'
        DataType = ftGraphic
      end
      item
        Name = 'id_caja'
        DataType = ftInteger
      end
      item
        Name = 'tipo_caja'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'org_provincia'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'asm_Correo'
        DataType = ftString
        Size = 25
      end
      item
        Name = 'asm_horario'
        DataType = ftString
        Size = 25
      end
      item
        Name = 'asm_codcli'
        DataType = ftString
        Size = 25
      end
      item
        Name = 'asm_mnemo'
        DataType = ftString
        Size = 25
      end
      item
        Name = 'asm_pobla'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'asm_tracking'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'asm_bc'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'asm_bc_human'
        DataType = ftString
        Size = 50
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 383
    Top = 39
    Data = {
      C00400009619E0BD01000000180000002B000000000003000000C00406636F64
      636C6904000100000000000A636F64616C626172616E04000100000000000875
      6E6964616465730400010000000000056665636861080008000000000007636F
      6472757461040001000000000006636F64647374010049000000010005574944
      5448020002000C000A6473745F6E6F6D62726501004900000001000557494454
      48020002003C00096473745F63616C6C65010049000000010005574944544802
      0002003C00066473745F63700100490000000100055749445448020002000500
      0D6473745F6C6F63616C69646164010049000000010005574944544802000200
      3C000D6473745F70726F76696E63696101004900000001000557494454480200
      02003C000662756C746F7304000100000000000D6F62736572766163696F6E65
      73020049000000010005574944544802000200FF00086473745F74666E6F0100
      490000000100055749445448020002001E000A6473745F636F6464656C010049
      0000000100055749445448020002000A000B6473745F706572736F6E61010049
      0000000100055749445448020002003C000A6F7264656E62756C746F04000100
      000000000D636F6472657061727469646F7204000100000000000A6F72675F6E
      6F6D6272650100490000000100055749445448020002003C00096F72675F6361
      6C6C650100490000000100055749445448020002003C00066F72675F63700100
      4900000001000557494454480200020005000D6F72675F6C6F63616C69646164
      0100490000000100055749445448020002003C00086F72675F74666E6F010049
      0000000100055749445448020002001E00097265656D626F6C736F0100490000
      000100055749445448020002000A000A7265666572656E636961010049000000
      0100055749445448020002000F00036B67730100490000000100055749445448
      020002000F000673656D706F720100490000000100055749445448020002000A
      000A6368726F6E6F5F6578700100490000000100055749445448020002000F00
      0A6368726F6E6F5F7265660100490000000100055749445448020002000F0008
      636F6462756C746F0100490000000100055749445448020002001E0006706466
      343137020049000000010005574944544802000200E803046C6F676F04004B00
      0000010007535542545950450200490009004772617068696373000769645F63
      616A610400010000000000097469706F5F63616A610100490000000100055749
      4454480200020001000D6F72675F70726F76696E636961010049000000010005
      5749445448020002003C000A61736D5F436F7272656F01004900000001000557
      494454480200020019000B61736D5F686F726172696F01004900000001000557
      494454480200020019000A61736D5F636F64636C690100490000000100055749
      4454480200020019000961736D5F6D6E656D6F01004900000001000557494454
      480200020019000961736D5F706F626C61010049000000010005574944544802
      00020032000C61736D5F747261636B696E670100490000000100055749445448
      0200020032000661736D5F626301004900000001000557494454480200020032
      000C61736D5F62635F68756D616E010049000000010005574944544802000200
      32000000}
    object intgrfld_bultoscodcli: TIntegerField
      FieldName = 'codcli'
    end
    object intgrfld_bultoscodalbaran: TIntegerField
      FieldName = 'codalbaran'
    end
    object intgrfld_bultosunidades: TIntegerField
      FieldName = 'unidades'
    end
    object dtmfld_bultosfecha: TDateTimeField
      FieldName = 'fecha'
    end
    object intgrfld_bultoscodruta: TIntegerField
      FieldName = 'codruta'
    end
    object strngfld_bultoscoddst: TStringField
      FieldName = 'coddst'
      Size = 12
    end
    object strngfld_bultosdst_nombre: TStringField
      FieldName = 'dst_nombre'
      Size = 60
    end
    object strngfld_bultosdst_calle: TStringField
      FieldName = 'dst_calle'
      Size = 60
    end
    object strngfld_bultosdst_cp: TStringField
      FieldName = 'dst_cp'
      Size = 5
    end
    object strngfld_bultosdst_localidad: TStringField
      FieldName = 'dst_localidad'
      Size = 60
    end
    object strngfld_bultosdst_provincia: TStringField
      FieldName = 'dst_provincia'
      Size = 60
    end
    object intgrfld_bultosbultos: TIntegerField
      FieldName = 'bultos'
    end
    object strngfld_bultosobservaciones: TStringField
      FieldName = 'observaciones'
      Size = 255
    end
    object strngfld_bultosdst_tfno: TStringField
      FieldName = 'dst_tfno'
      Size = 30
    end
    object strngfld_bultosdst_coddel: TStringField
      FieldName = 'dst_coddel'
      Size = 10
    end
    object strngfld_bultosdst_persona: TStringField
      FieldName = 'dst_persona'
      Size = 60
    end
    object intgrfld_bultosordenbulto: TIntegerField
      FieldName = 'ordenbulto'
    end
    object intgrfld_bultoscodrepartidor: TIntegerField
      FieldName = 'codrepartidor'
    end
    object strngfld_bultosorg_nombre: TStringField
      FieldName = 'org_nombre'
      Size = 60
    end
    object strngfld_bultosorg_calle: TStringField
      FieldName = 'org_calle'
      Size = 60
    end
    object strngfld_bultosorg_cp: TStringField
      FieldName = 'org_cp'
      Size = 5
    end
    object strngfld_bultosorg_localidad: TStringField
      FieldName = 'org_localidad'
      Size = 60
    end
    object strngfld_bultosorg_tfno: TStringField
      FieldName = 'org_tfno'
      Size = 30
    end
    object strngfld_bultosreembolso: TStringField
      FieldName = 'reembolso'
      Size = 10
    end
    object strngfld_bultosreferencia: TStringField
      FieldName = 'referencia'
      Size = 15
    end
    object strngfld_bultoskgs: TStringField
      FieldName = 'kgs'
      Size = 15
    end
    object strngfld_bultossempor: TStringField
      FieldName = 'sempor'
      Size = 10
    end
    object strngfld_bultoschrono_exp: TStringField
      FieldName = 'chrono_exp'
      Size = 15
    end
    object strngfld_bultoschrono_ref: TStringField
      FieldName = 'chrono_ref'
      Size = 15
    end
    object strngfld_bultoscodbulto: TStringField
      FieldName = 'codbulto'
      Size = 30
    end
    object strngfld_bultospdf417: TStringField
      FieldName = 'pdf417'
      Size = 1000
    end
    object grphcfld_bultoslogo: TGraphicField
      FieldName = 'logo'
      BlobType = ftGraphic
    end
    object intgrfld_bultosid_caja: TIntegerField
      FieldName = 'id_caja'
    end
    object strngfld_bultostipo_caja: TStringField
      FieldName = 'tipo_caja'
      Size = 1
    end
    object strngfld_bultoscodexpedicion: TStringField
      FieldKind = fkCalculated
      FieldName = 'codexpedicion'
      Size = 16
      Calculated = True
    end
    object cds_bultosorg_provincia: TStringField
      FieldName = 'org_provincia'
      Size = 60
    end
    object strngfld_bultosasm_correo: TStringField
      FieldName = 'asm_correo'
      Size = 25
    end
    object strngfld_bultosasm_horario: TStringField
      FieldName = 'asm_horario'
      Size = 25
    end
    object strngfld_bultosasm_codcli: TStringField
      FieldName = 'asm_codcli'
      Size = 25
    end
    object strngfld_bultosasm_mnemo: TStringField
      FieldName = 'asm_mnemo'
      Size = 25
    end
    object strngfld_bultosasm_pobla: TStringField
      FieldName = 'asm_pobla'
      Size = 50
    end
    object strngfld_bultosasm_tracking: TStringField
      FieldName = 'asm_tracking'
      Size = 50
    end
    object strngfld_bultosasm_bc: TStringField
      FieldName = 'asm_bc'
      Size = 50
    end
    object strngfld_bultosasm_bc_human: TStringField
      FieldName = 'asm_bc_human'
      Size = 50
    end
  end
  object q_sql2: TADOQuery
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      '')
    Left = 322
    Top = 280
  end
end
