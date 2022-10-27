object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 582
  Width = 847
  object db: TpFIBDatabase
    AutoReconnect = True
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
    BeforeConnect = dbBeforeConnect
    AfterConnect = dbAfterConnect
    Left = 30
    Top = 26
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
  object q_peds: TpFIBDataSet
    SelectSQL.Strings = (
      'select * from c_pedidos')
    AutoUpdateOptions.AutoReWriteSqls = True
    AfterScroll = q_pedsAfterScroll
    OnCalcFields = q_pedsCalcFields
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 28
    Top = 77
    oCacheCalcFields = True
    object q_pedsID_PEDIDO: TFIBIntegerField
      FieldName = 'ID_PEDIDO'
    end
    object q_pedsID_CLIENTE: TFIBIntegerField
      FieldName = 'ID_CLIENTE'
    end
    object q_pedsID_ORDER: TFIBStringField
      FieldName = 'ID_ORDER'
      EmptyStrToNull = True
    end
    object q_pedsORDER_NAME: TFIBStringField
      FieldName = 'ORDER_NAME'
      EmptyStrToNull = True
    end
    object q_pedsNOMBRE: TFIBStringField
      FieldName = 'NOMBRE'
      Size = 100
      EmptyStrToNull = True
    end
    object q_pedsDIR_1: TFIBStringField
      FieldName = 'DIR_1'
      Size = 500
      EmptyStrToNull = True
    end
    object q_pedsPOBLACION: TFIBStringField
      FieldName = 'POBLACION'
      Size = 100
      EmptyStrToNull = True
    end
    object q_pedsPROVINCIA: TFIBStringField
      FieldName = 'PROVINCIA'
      Size = 100
      EmptyStrToNull = True
    end
    object q_pedsCP: TFIBStringField
      FieldName = 'CP'
      EmptyStrToNull = True
    end
    object q_pedsPAIS: TFIBStringField
      FieldName = 'PAIS'
      Size = 100
      EmptyStrToNull = True
    end
    object q_pedsPAIS_CODE: TFIBStringField
      FieldName = 'PAIS_CODE'
      Size = 2
      EmptyStrToNull = True
    end
    object q_pedsDELEGACION_DST: TFIBIntegerField
      FieldName = 'DELEGACION_DST'
    end
    object q_pedsFECHA_PED: TFIBDateTimeField
      FieldName = 'FECHA_PED'
      DisplayFormat = 'dd.mm.yyyy HH:mm'
    end
    object q_pedsTELEFONO: TFIBStringField
      FieldName = 'TELEFONO'
      EmptyStrToNull = True
    end
    object q_pedsEMAIL: TFIBStringField
      FieldName = 'EMAIL'
      Size = 200
      EmptyStrToNull = True
    end
    object q_pedsDELIVERY_TIME: TFIBIntegerField
      FieldName = 'DELIVERY_TIME'
    end
    object q_pedsDELIV_TIME_TXT: TFIBStringField
      FieldName = 'DELIV_TIME_TXT'
      EmptyStrToNull = True
    end
    object q_pedsTEXT: TFIBStringField
      FieldName = 'TEXT'
      Size = 255
      EmptyStrToNull = True
    end
    object q_pedsFECHA_IMP: TFIBDateTimeField
      DefaultExpression = 'NOW'
      FieldName = 'FECHA_IMP'
      DisplayFormat = 'dd.mm.yyyy HH:mm'
    end
    object q_pedsFECHA_GEN: TFIBDateTimeField
      FieldName = 'FECHA_GEN'
      DisplayFormat = 'dd.mm.yyyy HH:mm'
    end
    object q_pedsFECHA_FIN: TFIBDateTimeField
      FieldName = 'FECHA_FIN'
      DisplayFormat = 'dd.mm.yyyy HH:mm'
    end
    object q_pedsESTADO: TFIBStringField
      DefaultExpression = #39'P'#39
      FieldName = 'ESTADO'
      Size = 1
      EmptyStrToNull = True
    end
    object q_pedsCODALBARAN: TFIBIntegerField
      DefaultExpression = '0'
      FieldName = 'CODALBARAN'
    end
    object q_pedsOBSERVACIONES: TFIBStringField
      FieldName = 'OBSERVACIONES'
      Size = 355
      EmptyStrToNull = True
    end
    object q_pedsTRANSPORTE: TFIBIntegerField
      DefaultExpression = '0'
      FieldName = 'TRANSPORTE'
    end
    object q_pedsID_REPARTIDOR: TFIBIntegerField
      DefaultExpression = '3'
      FieldName = 'ID_REPARTIDOR'
    end
    object q_pedsENVIADO: TFIBStringField
      DefaultExpression = #39'N'#39
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
      DefaultExpression = '1'
      FieldName = 'BULTOS'
    end
    object q_pedsPDF: TFIBStringField
      FieldName = 'PDF'
      Size = 100
      EmptyStrToNull = True
    end
    object q_pedsFINANCIAL_STATUS: TFIBStringField
      FieldName = 'FINANCIAL_STATUS'
      EmptyStrToNull = True
    end
    object q_pedsFULFILLMENT_STATUS: TFIBStringField
      FieldName = 'FULFILLMENT_STATUS'
      EmptyStrToNull = True
    end
    object q_pedsGATEWAY: TFIBStringField
      FieldName = 'GATEWAY'
      EmptyStrToNull = True
    end
    object q_pedsCOMPANY: TFIBStringField
      FieldName = 'COMPANY'
      Size = 100
      EmptyStrToNull = True
    end
    object q_pedsTAGS: TFIBStringField
      FieldName = 'TAGS'
      Size = 15
      EmptyStrToNull = True
    end
    object q_pedsCANCELLED_AT: TFIBDateTimeField
      FieldName = 'CANCELLED_AT'
      DisplayFormat = 'dd.mm.yyyy HH:mm'
    end
    object q_pedsCANCEL_REASON: TFIBStringField
      FieldName = 'CANCEL_REASON'
      EmptyStrToNull = True
    end
    object q_pedsDATE_UPDT: TFIBDateTimeField
      FieldName = 'DATE_UPDT'
      DisplayFormat = 'dd.mm.yyyy HH:mm'
    end
    object q_pedsES_DEVO: TFIBSmallIntField
      DefaultExpression = '0'
      FieldName = 'ES_DEVO'
    end
    object q_pedsID_ORDER_2: TFIBStringField
      FieldName = 'ID_ORDER_2'
      EmptyStrToNull = True
    end
    object q_pedsNOTE: TFIBStringField
      FieldName = 'NOTE'
      Size = 50
      EmptyStrToNull = True
    end
    object q_pedsREEMBOLSO: TFIBFloatField
      FieldName = 'REEMBOLSO'
    end
    object q_pedsALBARAN_R: TFIBIntegerField
      DefaultExpression = '0'
      FieldName = 'ALBARAN_R'
    end
    object q_pedsPESO: TFIBFloatField
      DefaultExpression = '1'
      FieldName = 'PESO'
    end
    object q_pedsSERVICE_REF: TFIBIntegerField
      FieldName = 'SERVICE_REF'
    end
    object q_pedsSYNC_WEB: TFIBSmallIntField
      DefaultExpression = '0'
      FieldName = 'SYNC_WEB'
    end
    object q_pedsCON_RETORNO: TFIBSmallIntField
      DefaultExpression = '0'
      FieldName = 'CON_RETORNO'
    end
    object q_pedsCECO: TFIBStringField
      FieldName = 'CECO'
      Size = 255
      EmptyStrToNull = True
    end
    object q_pedsREF_CLIENTE: TFIBStringField
      FieldName = 'REF_CLIENTE'
      Size = 255
      EmptyStrToNull = True
    end
    object q_pedsACTIVO: TFIBIntegerField
      DefaultExpression = '1'
      FieldName = 'ACTIVO'
    end
    object q_pedsCONTACTO: TFIBStringField
      FieldName = 'CONTACTO'
      Size = 100
      EmptyStrToNull = True
    end
    object q_pedsTIPO_SERVICIO: TFIBIntegerField
      FieldName = 'TIPO_SERVICIO'
    end
    object q_pedsHORARIO: TFIBIntegerField
      FieldName = 'HORARIO'
    end
    object q_pedsGEST_NUEVO: TFIBSmallIntField
      DefaultExpression = '0'
      FieldName = 'GEST_NUEVO'
    end
    object q_pedsORIGEN_WEB: TFIBIntegerField
      DefaultExpression = '0'
      FieldName = 'ORIGEN_WEB'
    end
    object q_pedsGESTORAS_DEST: TFIBIntegerField
      FieldName = 'GESTORAS_DEST'
    end
    object q_pedsAGENCIA: TStringField
      DisplayWidth = 30
      FieldKind = fkCalculated
      FieldName = 'AGENCIA'
      Size = 50
      Calculated = True
    end
    object q_pedsPICKING: TFIBIntegerField
      FieldName = 'PICKING'
    end
    object q_pedsPACK_AB: TFIBIntegerField
      FieldName = 'PACK_AB'
    end
    object q_pedsPROV_CODE: TFIBStringField
      FieldName = 'PROV_CODE'
      Size = 4
      EmptyStrToNull = True
    end
    object q_pedsPLUGIN_CODE: TFIBStringField
      FieldName = 'PLUGIN_CODE'
      Size = 100
      EmptyStrToNull = True
    end
    object lgs_pedsID_ALMACEN: TFIBIntegerField
      DefaultExpression = '1'
      FieldName = 'ID_ALMACEN'
    end
    object lgs_pedsENVIADO_FICH: TFIBSmallIntField
      DefaultExpression = '0'
      FieldName = 'ENVIADO_FICH'
    end
    object lgs_pedsIMPORTE_ASEGURADO: TFIBFloatField
      DefaultExpression = '0'
      FieldName = 'IMPORTE_ASEGURADO'
    end
    object lgs_pedsDATE_MAIL_DEST: TFIBDateTimeField
      FieldName = 'DATE_MAIL_DEST'
    end
    object smlntfld_pedsINCIDENCIA: TSmallintField
      FieldKind = fkCalculated
      FieldName = 'INCIDENCIA'
      Calculated = True
    end
  end
  object ds_peds: TDataSource
    DataSet = q_peds
    Left = 27
    Top = 149
  end
  object q_1: TpFIBQuery
    Transaction = t_write
    Database = db
    Left = 240
    Top = 304
  end
  object ds_1: TpFIBDataSet
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 284
    Top = 306
  end
  object ds_2: TpFIBDataSet
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 347
    Top = 309
  end
  object q_peds_count: TpFIBDataSet
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 85
    Top = 92
  end
  object q_sql5: TADOQuery
    Connection = con1
    Parameters = <>
    Left = 217
    Top = 243
  end
  object qryAlbEdit: TADOQuery
    Connection = con1
    CursorType = ctStatic
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
    Left = 151
    Top = 241
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
    object blnfldAlbEditfact_retorno: TBooleanField
      FieldName = 'fact_retorno'
    end
  end
  object q_peds_lines: TpFIBDataSet
    SelectSQL.Strings = (
      
        'select l.*,a.codigo,l.nombre_art as nombre,l.sku as codigo_cli, ' +
        'lt.nombre as lote, lt.caducidad'
      'from c_pedidos_lines l'
      'left outer join g_articulos a on (l.id_articulo=a.id_articulo) '
      'left outer join a_lotes lt on (lt.id_lote=l.id_lote) '
      'where l.id_pedido=:id_pedido')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    DataSource = ds_peds
    Left = 158
    Top = 92
    poApplyRepositary = True
    object q_peds_linesID_PEDIDO: TFIBIntegerField
      FieldName = 'ID_PEDIDO'
    end
    object q_peds_linesID_LINE: TFIBIntegerField
      FieldName = 'ID_LINE'
    end
    object q_peds_linesID_ARTICULO: TFIBIntegerField
      FieldName = 'ID_ARTICULO'
    end
    object q_peds_linesCANTIDAD: TFIBIntegerField
      FieldName = 'CANTIDAD'
    end
    object q_peds_linesSKU: TFIBStringField
      FieldName = 'SKU'
      Size = 22
      EmptyStrToNull = True
    end
    object q_peds_linesNOMBRE_ART: TFIBStringField
      FieldName = 'NOMBRE_ART'
      Size = 100
      EmptyStrToNull = True
    end
    object q_peds_linesITEM_ID: TFIBIntegerField
      FieldName = 'ITEM_ID'
    end
    object q_peds_linesKGS: TFIBFloatField
      DefaultExpression = '0'
      FieldName = 'KGS'
    end
    object q_peds_linesID_LOTE: TFIBIntegerField
      DefaultExpression = '1'
      FieldName = 'ID_LOTE'
    end
    object q_peds_linesID_IMEI: TFIBIntegerField
      FieldName = 'ID_IMEI'
    end
    object q_peds_linesID_DEPARTAMENTO: TFIBIntegerField
      DefaultExpression = '0'
      FieldName = 'ID_DEPARTAMENTO'
    end
    object q_peds_linesCODIGO: TFIBStringField
      FieldName = 'CODIGO'
      EmptyStrToNull = True
    end
    object q_peds_linesNOMBRE: TFIBStringField
      FieldName = 'NOMBRE'
      Size = 100
      EmptyStrToNull = True
    end
    object q_peds_linesCODIGO_CLI: TFIBStringField
      FieldName = 'CODIGO_CLI'
      Size = 22
      EmptyStrToNull = True
    end
    object q_peds_linesIMEI: TFIBStringField
      FieldName = 'IMEI'
      Size = 15
      EmptyStrToNull = True
    end
    object q_peds_linesN_SERIE: TFIBStringField
      FieldName = 'N_SERIE'
      Size = 50
      EmptyStrToNull = True
    end
    object q_peds_linesLOTE: TFIBStringField
      FieldName = 'LOTE'
      EmptyStrToNull = True
    end
    object q_peds_linesCADUCIDAD: TFIBDateField
      FieldName = 'CADUCIDAD'
    end
  end
  object dsbusqueda: TDataSource
    DataSet = busqueda
    Left = 308
    Top = 9
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
  object cds_bultos: TClientDataSet
    PersistDataPacket.Data = {
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
    Left = 400
    Top = 26
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
    Left = 333
    Top = 242
  end
  object q_detail: TpFIBDataSet
    SelectSQL.Strings = (
      'select a.nombre, a.imagen, l.cantidad , e.cod_envio, p.pais_code'
      'from c_pedidos p'
      'inner join c_pedidos_lines l on l.id_pedido=p.id_pedido'
      'left outer join c_pedidos_etiquetas e on e.id_pedido=l.id_pedido'
      'inner join g_articulos a on a.id_articulo=l.id_articulo'
      'where  l.id_pedido=:id_pedido and e.cod_envio not like '#39'LI%'#39)
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 24
    Top = 302
  end
  object q_2: TpFIBDataSet
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 85
    Top = 301
  end
  object ds_devs: TDataSource
    DataSet = q_devs
    Left = 408
    Top = 143
  end
  object q_devs: TpFIBDataSet
    UpdateSQL.Strings = (
      'update c_pedidos_devos'
      'set'
      'CONTROL = :CONTROL,'
      'MOTIVO_KO = :MOTIVO,'
      'FOTO = :FOTO'
      'where '
      'id_pedido_devo = :id_pedido_devo'
      '')
    SelectSQL.Strings = (
      'select d.*, ar.id_articulo'
      'from c_pedidos_devos d'
      'inner join c_pedidos p on p.id_pedido=d.id_pedido'
      
        'inner join c_pedidos_lines l on l.id_pedido=d.id_pedido and l.id' +
        '_line=d.id_pedido_line'
      'inner join g_clientes cl on cl.id_cliente=p.id_cliente'
      'left outer join g_articulos ar on ar.id_articulo=l.id_articulo')
    AutoCalcFields = False
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 398
    Top = 92
    object fbntgrfld_devsID_PEDIDO_DEVO: TFIBIntegerField
      FieldName = 'ID_PEDIDO_DEVO'
    end
    object fbntgrfld_devsID_PEDIDO: TFIBIntegerField
      FieldName = 'ID_PEDIDO'
    end
    object fbntgrfld_devsID_PEDIDO_LINE: TFIBIntegerField
      FieldName = 'ID_PEDIDO_LINE'
    end
    object fbntgrfld_devsID_PEDIDO_NUEVO: TFIBIntegerField
      FieldName = 'ID_PEDIDO_NUEVO'
    end
    object fbdtmfld_devsFECHA_DEVO: TFIBDateTimeField
      FieldName = 'FECHA_DEVO'
    end
    object fbstrngfld_devsTIPO: TFIBStringField
      FieldName = 'TIPO'
      Size = 1
      EmptyStrToNull = True
    end
    object fbstrngfld_devsESTADO_DEVO: TFIBStringField
      FieldName = 'ESTADO_DEVO'
      Size = 1
      EmptyStrToNull = True
    end
    object fbntgrfld_devsID_ARTICULO_OUT: TFIBIntegerField
      FieldName = 'ID_ARTICULO_OUT'
    end
    object fbstrngfld_devsTIPO_IMPORT: TFIBStringField
      FieldName = 'TIPO_IMPORT'
      Size = 1
      EmptyStrToNull = True
    end
    object fbstrngfld_devsERROR_IMPORT: TFIBStringField
      FieldName = 'ERROR_IMPORT'
      Size = 100
      EmptyStrToNull = True
    end
    object fbstrngfld_devsFILE_NAME: TFIBStringField
      FieldName = 'FILE_NAME'
      Size = 100
      EmptyStrToNull = True
    end
    object fbntgrfld_devsFILE_LINE: TFIBIntegerField
      FieldName = 'FILE_LINE'
    end
    object fbdtmfld_devsMODIF_FECHA: TFIBDateTimeField
      FieldName = 'MODIF_FECHA'
    end
    object fbstrngfld_devsOBSERVACIONES: TFIBStringField
      FieldName = 'OBSERVACIONES'
      Size = 200
      EmptyStrToNull = True
    end
    object fbstrngfld_devsLINEA_DATOS: TFIBStringField
      FieldName = 'LINEA_DATOS'
      Size = 500
      EmptyStrToNull = True
    end
    object fbdtmfld_devsFILE_DATE_IMP: TFIBDateTimeField
      FieldName = 'FILE_DATE_IMP'
    end
    object fbdtmfld_devsFILE_DATE_GEN: TFIBDateTimeField
      FieldName = 'FILE_DATE_GEN'
    end
    object fbstrngfld_devsORDER_NAME: TFIBStringField
      FieldName = 'ORDER_NAME'
      EmptyStrToNull = True
    end
    object fbntgrfld_devsID_CLIENTE: TFIBIntegerField
      FieldName = 'ID_CLIENTE'
    end
    object fbntgrfld_devsID_ARTICULO: TFIBIntegerField
      FieldName = 'ID_ARTICULO'
    end
    object fbstrngfld_devsCONTROL: TFIBStringField
      FieldName = 'CONTROL'
      Size = 2
      EmptyStrToNull = True
    end
    object fbstrngfld_devsMOTIVO_KO: TFIBStringField
      FieldName = 'MOTIVO_KO'
      Size = 100
      EmptyStrToNull = True
    end
    object fbmfld_devsFOTO: TFIBMemoField
      FieldName = 'FOTO'
      BlobType = ftMemo
      Size = 8
    end
    object fbstrngfld_devsART_IN: TFIBStringField
      FieldName = 'ART_IN'
      EmptyStrToNull = True
    end
    object fbstrngfld_devsART_OUT: TFIBStringField
      FieldName = 'ART_OUT'
      EmptyStrToNull = True
    end
  end
  object q_devs_count: TpFIBDataSet
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 456
    Top = 89
  end
  object q_3: TpFIBDataSet
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 139
    Top = 301
  end
  object q_4: TpFIBQuery
    Transaction = t_write
    Database = db
    Left = 413
    Top = 225
  end
  object q_picks_lotes: TpFIBDataSet
    SelectSQL.Strings = (
      'select l.cantidad, l.id_lote, l.id_pickcab, l.linea'
      'from a_picklin l'
      
        'where l.codalbaran=:albaran and l.id_articulo=:articulo and l.si' +
        'tuacion='#39'A'#39)
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 332
    Top = 90
    object fbntgrfld_picks_lotesCANTIDAD: TFIBIntegerField
      FieldName = 'CANTIDAD'
    end
    object fbntgrfld_picks_lotesID_LOTE: TFIBIntegerField
      FieldName = 'ID_LOTE'
    end
    object fbntgrfld_picks_lotesID_PICKCAB: TFIBIntegerField
      FieldName = 'ID_PICKCAB'
    end
    object fbntgrfld_picks_lotesLINEA: TFIBIntegerField
      FieldName = 'LINEA'
    end
  end
  object ds_peds_lines: TDataSource
    DataSet = q_peds_lines
    Left = 158
    Top = 144
  end
  object q_peds_lines_lotes: TpFIBDataSet
    SelectSQL.Strings = (
      'select *'
      'from c_pedidos_lines_lotes l'
      'inner join a_lotes lt on (l.id_lote=lt.id_lote) '
      'where l.id_pedido=:id_pedido and l.id_articulo=:id_articulo ')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 234
    Top = 91
    object fbntgrfld_peds_lines_lotesID_PEDIDO: TFIBIntegerField
      FieldName = 'ID_PEDIDO'
    end
    object fbntgrfld_peds_lines_lotesID_LOTE: TFIBIntegerField
      FieldName = 'ID_LOTE'
    end
    object fbntgrfld_peds_lines_lotesCANTIDAD: TFIBIntegerField
      FieldName = 'CANTIDAD'
    end
    object fbntgrfld_peds_lines_lotesID_LOTE1: TFIBIntegerField
      FieldName = 'ID_LOTE1'
    end
    object fbstrngfld_peds_lines_lotesNOMBRE: TFIBStringField
      FieldName = 'NOMBRE'
      EmptyStrToNull = True
    end
    object fbdtfld_peds_lines_lotesCADUCIDAD: TFIBDateField
      DefaultExpression = 'TODAY'
      FieldName = 'CADUCIDAD'
      DisplayFormat = 'dd.mm.yyyy'
    end
    object fbstrngfld_peds_lines_lotesESTADO: TFIBStringField
      DefaultExpression = #39'A'#39
      FieldName = 'ESTADO'
      Size = 1
      EmptyStrToNull = True
    end
    object fbntgrfld_peds_lines_lotesID_ARTICULO: TFIBIntegerField
      FieldName = 'ID_ARTICULO'
    end
    object fbntgrfld_peds_lines_lotesID_PICKING: TFIBIntegerField
      FieldName = 'ID_PICKING'
    end
    object fbntgrfld_peds_lines_lotesLINEA_PICK: TFIBIntegerField
      FieldName = 'LINEA_PICK'
    end
  end
  object ds_peds_lines_lotes: TDataSource
    DataSet = q_peds_lines_lotes
    Left = 242
    Top = 141
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
    Left = 29
    Top = 231
  end
  object ds_3: TpFIBDataSet
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 403
    Top = 309
  end
  object ds_4: TpFIBDataSet
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 449
    Top = 309
  end
  object q2: TpFIBQuery
    Transaction = t_write
    Database = db
    Left = 199
    Top = 305
  end
  object q_fib: TpFIBDataSet
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 162
    Top = 360
  end
  object qu_1: TpFIBQuery
    Transaction = t_write
    Database = db
    Left = 218
    Top = 358
  end
  object db_gestoras: TpFIBDatabase
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
    BeforeConnect = dbBeforeConnect
    Left = 512
    Top = 22
  end
  object t_read_gestoras: TpFIBTransaction
    DefaultDatabase = db_gestoras
    Left = 586
    Top = 22
  end
  object t_write_gestoras: TpFIBTransaction
    DefaultDatabase = db_gestoras
    Left = 585
    Top = 75
  end
  object client: TRESTClient
    Authenticator = auth
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    Left = 584
    Top = 159
  end
  object response: TRESTResponse
    Left = 584
    Top = 271
  end
  object request: TRESTRequest
    Client = client
    Method = rmPOST
    Params = <>
    Response = response
    SynchronizedEvents = False
    Left = 584
    Top = 215
  end
  object qrytemp: TpFIBDataSet
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 656
    Top = 73
  end
  object stpGrabaAlb: TpFIBQuery
    Transaction = t_write_gestoras
    Database = db_gestoras
    Left = 664
    Top = 136
  end
  object xEtiquetas: TpFIBDataSet
    SelectSQL.Strings = (
      'select * from tmp_lst_etiquetas'
      'where usuario=:usuario'
      '')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 17
    Top = 501
    object xEtiquetasUSUARIO: TFIBIntegerField
      FieldName = 'USUARIO'
    end
    object xEtiquetasID_ALBARAN: TFIBIntegerField
      FieldName = 'ID_ALBARAN'
    end
  end
  object auth: THTTPBasicAuthenticator
    Username = 'admin@belike.com'
    Password = 'password'
    Left = 576
    Top = 352
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
    Left = 376
    Top = 408
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
    Left = 488
    Top = 408
  end
  object RESTResponse1: TRESTResponse
    ContentType = 'text/html'
    Left = 568
    Top = 416
  end
  object xBultos: TpFIBDataSet
    SelectSQL.Strings = (
      'select count(*) as bultos from albaran_bultos'
      'where id_albaran=:id_albaran')
    Transaction = t_read_gestoras
    Database = db_gestoras
    UpdateTransaction = t_write_gestoras
    Left = 153
    Top = 501
    object xBultosBULTOS: TFIBIntegerField
      FieldName = 'BULTOS'
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
    Top = 501
    object xAlbaranBULTOS: TFIBSmallIntField
      FieldName = 'BULTOS'
    end
    object xAlbaranPESO: TFIBFloatField
      FieldName = 'PESO'
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
    Top = 501
    object xSigBultoMAX_BULTO: TFIBSmallIntField
      FieldName = 'MAX_BULTO'
    end
  end
  object qTempGest: TpFIBDataSet
    Transaction = t_read_gestoras
    Database = db_gestoras
    UpdateTransaction = t_write_gestoras
    Left = 664
    Top = 25
  end
  object xPedidoLines: TpFIBDataSet
    SelectSQL.Strings = (
      'select id_articulo, cantidad, kgs, nombre_art, imei'
      'from c_pedidos_lines'
      'where id_pedido=:id_pedido')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 273
    Top = 501
    object xPedidoLinesID_ARTICULO: TFIBIntegerField
      FieldName = 'ID_ARTICULO'
    end
    object xPedidoLinesCANTIDAD: TFIBIntegerField
      FieldName = 'CANTIDAD'
    end
    object xPedidoLinesKGS: TFIBFloatField
      FieldName = 'KGS'
    end
    object xPedidoLinesNOMBRE_ART: TFIBStringField
      FieldName = 'NOMBRE_ART'
      Size = 100
      EmptyStrToNull = True
    end
    object xPedidoLinesIMEI: TFIBWideStringField
      FieldName = 'IMEI'
      Size = 15
      EmptyStrToNull = True
    end
  end
  object dsArtsRelacionados: TDataSource
    Left = 548
    Top = 497
  end
  object q_arts_relacionados: TpFIBDataSet
    DeleteSQL.Strings = (
      'update g_articulos_relaciones'
      'set estado='#39'B'#39
      
        'where id_articulo=:id_articulo and id_art_relacionado=:id_art_re' +
        'lacionado')
    InsertSQL.Strings = (
      'insert into g_articulos_relaciones'
      '(id_articulo, id_art_relacionado)'
      'values'
      '(:id_articulo,:id_art_relacionado)')
    RefreshSQL.Strings = (
      'select *'
      'from g_articulos_relaciones'
      'where id_articulo=:id_articulo and estado='#39'A'#39)
    SelectSQL.Strings = (
      'select *'
      'from g_articulos_relaciones'
      'where id_articulo=:id_articulo and estado='#39'A'#39
      '')
    OnCalcFields = q_arts_relacionadosCalcFields
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    AutoCommit = True
    Left = 498
    Top = 155
    object q_arts_relacionadosCOD_ART_RELACIONADO: TStringField
      FieldKind = fkCalculated
      FieldName = 'COD_ART_REL'
      Calculated = True
    end
    object q_arts_relacionadosNOM_ART_REL: TStringField
      FieldKind = fkCalculated
      FieldName = 'NOM_ART_REL'
      Size = 100
      Calculated = True
    end
    object q_arts_relacionadosFECHA_CREACION: TFIBDateTimeField
      DefaultExpression = 'NOW'
      FieldName = 'FECHA_CREACION'
      DisplayFormat = 'dd.mm.yyyy HH:mm'
    end
    object q_arts_relacionadosESTADO: TFIBStringField
      DefaultExpression = #39'A'#39
      FieldName = 'ESTADO'
      Size = 1
      EmptyStrToNull = True
    end
    object q_arts_relacionadosFECHA_BAJA: TFIBDateTimeField
      FieldName = 'FECHA_BAJA'
      DisplayFormat = 'dd.mm.yyyy HH:mm'
    end
    object q_arts_relacionadosID_ART_RELACIONADO: TFIBIntegerField
      FieldName = 'ID_ART_RELACIONADO'
    end
    object q_arts_relacionadosID_ARTICULO: TFIBIntegerField
      FieldName = 'ID_ARTICULO'
    end
  end
  object ds_arts_rel: TDataSource
    DataSet = q_arts_relacionados
    Left = 496
    Top = 207
  end
  object q_pendientes: TpFIBDataSet
    SelectSQL.Strings = (
      '')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 96
    Top = 201
  end
  object q_packs_lotes: TpFIBDataSet
    SelectSQL.Strings = (
      'select l.cantidad, l.id_lote, l.id_pickcab, l.linea'
      'from a_packlin l'
      
        'where l.id_packcab=:id_packcab and l.codalbaran=:albaran and l.i' +
        'd_articulo=:articulo'
      
        'and l.cantidad_i=:cantidad and l.linea=:linea and l.id_lote<>:id' +
        '_lote')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 332
    Top = 154
    object FIBIntegerField1: TFIBIntegerField
      FieldName = 'CANTIDAD'
    end
    object FIBIntegerField2: TFIBIntegerField
      FieldName = 'ID_LOTE'
    end
    object FIBIntegerField3: TFIBIntegerField
      FieldName = 'ID_PICKCAB'
    end
    object FIBIntegerField4: TFIBIntegerField
      FieldName = 'LINEA'
    end
  end
  object q_aux: TpFIBDataSet
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 93
    Top = 149
  end
  object DataSource1: TDataSource
    Left = 368
    Top = 232
  end
  object genera_pick_abierto: TpFIBQuery
    Transaction = t_write
    Database = db
    Left = 88
    Top = 432
  end
  object tmpGest: TpFIBQuery
    Transaction = t_write_gestoras
    Database = db_gestoras
    Left = 664
    Top = 184
  end
  object dsPedirEtiqueta: TpFIBDataSet
    SelectSQL.Strings = (
      'select ok from pedir_etiqueta(:id_pedido)')
    AutoCalcFields = False
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    AutoCommit = True
    Left = 508
    Top = 282
    object lgsPedirEtiquetaOK: TFIBSmallIntField
      FieldName = 'OK'
    end
  end
  object q_ped: TpFIBDataSet
    SelectSQL.Strings = (
      'select * from c_pedidos where id_pedido=:id_pedido')
    AutoUpdateOptions.AutoReWriteSqls = True
    AfterScroll = q_pedsAfterScroll
    OnCalcFields = q_pedsCalcFields
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 28
    Top = 357
    oCacheCalcFields = True
    object lgs1: TFIBIntegerField
      FieldName = 'ID_PEDIDO'
    end
    object lgs2: TFIBIntegerField
      FieldName = 'ID_CLIENTE'
    end
    object FIBStringField1: TFIBStringField
      FieldName = 'ID_ORDER'
      EmptyStrToNull = True
    end
    object FIBStringField2: TFIBStringField
      FieldName = 'ORDER_NAME'
      EmptyStrToNull = True
    end
    object FIBStringField3: TFIBStringField
      FieldName = 'NOMBRE'
      Size = 100
      EmptyStrToNull = True
    end
    object FIBStringField4: TFIBStringField
      FieldName = 'DIR_1'
      Size = 500
      EmptyStrToNull = True
    end
    object FIBStringField5: TFIBStringField
      FieldName = 'POBLACION'
      Size = 100
      EmptyStrToNull = True
    end
    object FIBStringField6: TFIBStringField
      FieldName = 'PROVINCIA'
      Size = 100
      EmptyStrToNull = True
    end
    object FIBStringField7: TFIBStringField
      FieldName = 'CP'
      EmptyStrToNull = True
    end
    object FIBStringField8: TFIBStringField
      FieldName = 'PAIS'
      Size = 100
      EmptyStrToNull = True
    end
    object FIBStringField9: TFIBStringField
      FieldName = 'PAIS_CODE'
      Size = 2
      EmptyStrToNull = True
    end
    object lgs3: TFIBIntegerField
      FieldName = 'DELEGACION_DST'
    end
    object lgs4: TFIBDateTimeField
      FieldName = 'FECHA_PED'
    end
    object FIBStringField10: TFIBStringField
      FieldName = 'TELEFONO'
      EmptyStrToNull = True
    end
    object FIBStringField11: TFIBStringField
      FieldName = 'EMAIL'
      Size = 200
      EmptyStrToNull = True
    end
    object lgs5: TFIBIntegerField
      FieldName = 'DELIVERY_TIME'
    end
    object FIBStringField12: TFIBStringField
      FieldName = 'DELIV_TIME_TXT'
      EmptyStrToNull = True
    end
    object FIBStringField13: TFIBStringField
      FieldName = 'TEXT'
      Size = 255
      EmptyStrToNull = True
    end
    object lgs6: TFIBDateTimeField
      FieldName = 'FECHA_IMP'
    end
    object lgs7: TFIBDateTimeField
      FieldName = 'FECHA_GEN'
    end
    object lgs8: TFIBDateTimeField
      FieldName = 'FECHA_FIN'
    end
    object FIBStringField14: TFIBStringField
      FieldName = 'ESTADO'
      Size = 1
      EmptyStrToNull = True
    end
    object lgs9: TFIBIntegerField
      FieldName = 'CODALBARAN'
    end
    object FIBStringField15: TFIBStringField
      FieldName = 'OBSERVACIONES'
      Size = 255
      EmptyStrToNull = True
    end
    object lgs10: TFIBIntegerField
      FieldName = 'TRANSPORTE'
    end
    object lgs11: TFIBIntegerField
      FieldName = 'ID_REPARTIDOR'
    end
    object FIBStringField16: TFIBStringField
      FieldName = 'ENVIADO'
      Size = 1
      EmptyStrToNull = True
    end
    object FIBStringField17: TFIBStringField
      FieldName = 'TRACKING_NUMBER'
      Size = 50
      EmptyStrToNull = True
    end
    object lgs12: TFIBIntegerField
      FieldName = 'BULTOS'
    end
    object FIBStringField18: TFIBStringField
      FieldName = 'PDF'
      Size = 100
      EmptyStrToNull = True
    end
    object FIBStringField19: TFIBStringField
      FieldName = 'FINANCIAL_STATUS'
      EmptyStrToNull = True
    end
    object FIBStringField20: TFIBStringField
      FieldName = 'FULFILLMENT_STATUS'
      EmptyStrToNull = True
    end
    object FIBStringField21: TFIBStringField
      FieldName = 'GATEWAY'
      EmptyStrToNull = True
    end
    object FIBStringField22: TFIBStringField
      FieldName = 'COMPANY'
      Size = 100
      EmptyStrToNull = True
    end
    object FIBStringField23: TFIBStringField
      FieldName = 'TAGS'
      Size = 15
      EmptyStrToNull = True
    end
    object lgs13: TFIBDateTimeField
      FieldName = 'CANCELLED_AT'
    end
    object FIBStringField24: TFIBStringField
      FieldName = 'CANCEL_REASON'
      EmptyStrToNull = True
    end
    object lgs14: TFIBDateTimeField
      FieldName = 'DATE_UPDT'
    end
    object lgs15: TFIBSmallIntField
      FieldName = 'ES_DEVO'
    end
    object FIBStringField25: TFIBStringField
      FieldName = 'ID_ORDER_2'
      EmptyStrToNull = True
    end
    object FIBStringField26: TFIBStringField
      FieldName = 'NOTE'
      Size = 50
      EmptyStrToNull = True
    end
    object lgs16: TFIBFloatField
      FieldName = 'REEMBOLSO'
    end
    object lgs17: TFIBIntegerField
      FieldName = 'ALBARAN_R'
    end
    object lgs18: TFIBFloatField
      FieldName = 'PESO'
    end
    object lgs19: TFIBIntegerField
      FieldName = 'SERVICE_REF'
    end
    object lgs20: TFIBSmallIntField
      FieldName = 'SYNC_WEB'
    end
    object lgs21: TFIBSmallIntField
      FieldName = 'CON_RETORNO'
    end
    object FIBStringField27: TFIBStringField
      FieldName = 'CECO'
      Size = 255
      EmptyStrToNull = True
    end
    object FIBStringField28: TFIBStringField
      FieldName = 'REF_CLIENTE'
      Size = 255
      EmptyStrToNull = True
    end
    object lgs22: TFIBIntegerField
      FieldName = 'ACTIVO'
    end
    object FIBStringField29: TFIBStringField
      FieldName = 'CONTACTO'
      Size = 100
      EmptyStrToNull = True
    end
    object lgs23: TFIBIntegerField
      FieldName = 'TIPO_SERVICIO'
    end
    object lgs24: TFIBIntegerField
      FieldName = 'HORARIO'
    end
    object lgs25: TFIBSmallIntField
      FieldName = 'GEST_NUEVO'
    end
    object lgs26: TFIBIntegerField
      FieldName = 'ORIGEN_WEB'
    end
    object lgs27: TFIBIntegerField
      FieldName = 'GESTORAS_DEST'
    end
    object strngfld1: TStringField
      DisplayWidth = 30
      FieldKind = fkCalculated
      FieldName = 'AGENCIA'
      Size = 50
      Calculated = True
    end
    object lgs28: TFIBIntegerField
      FieldName = 'PICKING'
    end
    object lgs29: TFIBIntegerField
      FieldName = 'PACK_AB'
    end
    object q_pedPLUGIN_CODE: TFIBStringField
      FieldName = 'PLUGIN_CODE'
      Size = 100
      EmptyStrToNull = True
    end
    object lgs_pedID_ALMACEN: TFIBIntegerField
      FieldName = 'ID_ALMACEN'
    end
  end
  object spGetEmail: TpFIBStoredProc
    Transaction = t_read
    Database = db
    SQL.Strings = (
      'EXECUTE PROCEDURE GET_EMAIL_PEDIDO (?ID_PEDIDO)')
    StoredProcName = 'GET_EMAIL_PEDIDO'
    Left = 88
    Top = 368
  end
  object qUnPedido: TpFIBDataSet
    SelectSQL.Strings = (
      'select * from c_pedidos where id_pedido=:id_pedido')
    AutoUpdateOptions.AutoReWriteSqls = True
    AfterScroll = q_pedsAfterScroll
    OnCalcFields = q_pedsCalcFields
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 644
    Top = 269
    oCacheCalcFields = True
    object lgs30: TFIBIntegerField
      FieldName = 'ID_PEDIDO'
    end
    object lgs31: TFIBIntegerField
      FieldName = 'ID_CLIENTE'
    end
    object FIBStringField30: TFIBStringField
      FieldName = 'ID_ORDER'
      EmptyStrToNull = True
    end
    object FIBStringField31: TFIBStringField
      FieldName = 'ORDER_NAME'
      EmptyStrToNull = True
    end
    object FIBStringField32: TFIBStringField
      FieldName = 'NOMBRE'
      Size = 100
      EmptyStrToNull = True
    end
    object FIBStringField33: TFIBStringField
      FieldName = 'DIR_1'
      Size = 500
      EmptyStrToNull = True
    end
    object FIBStringField34: TFIBStringField
      FieldName = 'POBLACION'
      Size = 100
      EmptyStrToNull = True
    end
    object FIBStringField35: TFIBStringField
      FieldName = 'PROVINCIA'
      Size = 100
      EmptyStrToNull = True
    end
    object FIBStringField36: TFIBStringField
      FieldName = 'CP'
      EmptyStrToNull = True
    end
    object FIBStringField37: TFIBStringField
      FieldName = 'PAIS'
      Size = 100
      EmptyStrToNull = True
    end
    object FIBStringField38: TFIBStringField
      FieldName = 'PAIS_CODE'
      Size = 2
      EmptyStrToNull = True
    end
    object lgs32: TFIBIntegerField
      FieldName = 'DELEGACION_DST'
    end
    object lgs33: TFIBDateTimeField
      FieldName = 'FECHA_PED'
    end
    object FIBStringField39: TFIBStringField
      FieldName = 'TELEFONO'
      EmptyStrToNull = True
    end
    object FIBStringField40: TFIBStringField
      FieldName = 'EMAIL'
      Size = 200
      EmptyStrToNull = True
    end
    object lgs34: TFIBIntegerField
      FieldName = 'DELIVERY_TIME'
    end
    object FIBStringField41: TFIBStringField
      FieldName = 'DELIV_TIME_TXT'
      EmptyStrToNull = True
    end
    object FIBStringField42: TFIBStringField
      FieldName = 'TEXT'
      Size = 255
      EmptyStrToNull = True
    end
    object lgs35: TFIBDateTimeField
      FieldName = 'FECHA_IMP'
    end
    object lgs36: TFIBDateTimeField
      FieldName = 'FECHA_GEN'
    end
    object lgs37: TFIBDateTimeField
      FieldName = 'FECHA_FIN'
    end
    object FIBStringField43: TFIBStringField
      FieldName = 'ESTADO'
      Size = 1
      EmptyStrToNull = True
    end
    object lgs38: TFIBIntegerField
      FieldName = 'CODALBARAN'
    end
    object FIBStringField44: TFIBStringField
      FieldName = 'OBSERVACIONES'
      Size = 255
      EmptyStrToNull = True
    end
    object lgs39: TFIBIntegerField
      FieldName = 'TRANSPORTE'
    end
    object lgs40: TFIBIntegerField
      FieldName = 'ID_REPARTIDOR'
    end
    object FIBStringField45: TFIBStringField
      FieldName = 'ENVIADO'
      Size = 1
      EmptyStrToNull = True
    end
    object FIBStringField46: TFIBStringField
      FieldName = 'TRACKING_NUMBER'
      Size = 50
      EmptyStrToNull = True
    end
    object lgs41: TFIBIntegerField
      FieldName = 'BULTOS'
    end
    object FIBStringField47: TFIBStringField
      FieldName = 'PDF'
      Size = 100
      EmptyStrToNull = True
    end
    object FIBStringField48: TFIBStringField
      FieldName = 'FINANCIAL_STATUS'
      EmptyStrToNull = True
    end
    object FIBStringField49: TFIBStringField
      FieldName = 'FULFILLMENT_STATUS'
      EmptyStrToNull = True
    end
    object FIBStringField50: TFIBStringField
      FieldName = 'GATEWAY'
      EmptyStrToNull = True
    end
    object FIBStringField51: TFIBStringField
      FieldName = 'COMPANY'
      Size = 100
      EmptyStrToNull = True
    end
    object FIBStringField52: TFIBStringField
      FieldName = 'TAGS'
      Size = 15
      EmptyStrToNull = True
    end
    object lgs42: TFIBDateTimeField
      FieldName = 'CANCELLED_AT'
    end
    object FIBStringField53: TFIBStringField
      FieldName = 'CANCEL_REASON'
      EmptyStrToNull = True
    end
    object lgs43: TFIBDateTimeField
      FieldName = 'DATE_UPDT'
    end
    object lgs44: TFIBSmallIntField
      FieldName = 'ES_DEVO'
    end
    object FIBStringField54: TFIBStringField
      FieldName = 'ID_ORDER_2'
      EmptyStrToNull = True
    end
    object FIBStringField55: TFIBStringField
      FieldName = 'NOTE'
      Size = 50
      EmptyStrToNull = True
    end
    object lgs45: TFIBFloatField
      FieldName = 'REEMBOLSO'
    end
    object lgs46: TFIBIntegerField
      FieldName = 'ALBARAN_R'
    end
    object lgs47: TFIBFloatField
      FieldName = 'PESO'
    end
    object lgs48: TFIBIntegerField
      FieldName = 'SERVICE_REF'
    end
    object lgs49: TFIBSmallIntField
      FieldName = 'SYNC_WEB'
    end
    object lgs50: TFIBSmallIntField
      FieldName = 'CON_RETORNO'
    end
    object FIBStringField56: TFIBStringField
      FieldName = 'CECO'
      Size = 255
      EmptyStrToNull = True
    end
    object FIBStringField57: TFIBStringField
      FieldName = 'REF_CLIENTE'
      Size = 255
      EmptyStrToNull = True
    end
    object lgs51: TFIBIntegerField
      FieldName = 'ACTIVO'
    end
    object FIBStringField58: TFIBStringField
      FieldName = 'CONTACTO'
      Size = 100
      EmptyStrToNull = True
    end
    object lgs52: TFIBIntegerField
      FieldName = 'TIPO_SERVICIO'
    end
    object lgs53: TFIBIntegerField
      FieldName = 'HORARIO'
    end
    object lgs54: TFIBSmallIntField
      FieldName = 'GEST_NUEVO'
    end
    object lgs55: TFIBIntegerField
      FieldName = 'ORIGEN_WEB'
    end
    object lgs56: TFIBIntegerField
      FieldName = 'GESTORAS_DEST'
    end
    object strngfld2: TStringField
      DisplayWidth = 30
      FieldKind = fkCalculated
      FieldName = 'AGENCIA'
      Size = 50
      Calculated = True
    end
    object lgs57: TFIBIntegerField
      FieldName = 'PICKING'
    end
    object lgs58: TFIBIntegerField
      FieldName = 'PACK_AB'
    end
    object qUnPedidoPROV_CODE: TFIBStringField
      FieldName = 'PROV_CODE'
      Size = 4
      EmptyStrToNull = True
    end
    object qUnPedidoPLUGIN_CODE: TFIBStringField
      FieldName = 'PLUGIN_CODE'
      Size = 100
      EmptyStrToNull = True
    end
    object lgsUnPedidoID_ALMACEN: TFIBIntegerField
      FieldName = 'ID_ALMACEN'
    end
    object lgsUnPedidoENVIADO_FICH: TFIBSmallIntField
      FieldName = 'ENVIADO_FICH'
    end
    object lgsUnPedidoIMPORTE_ASEGURADO: TFIBFloatField
      FieldName = 'IMPORTE_ASEGURADO'
    end
  end
  object xml_1: TXMLDocument
    Left = 656
    Top = 352
  end
  object ftp_1: TIdFTP
    IPVersion = Id_IPv4
    Host = 'home361541350.1and1-data.host'
    Passive = True
    ConnectTimeout = 0
    Password = 'xzj2004MN4+'
    Username = 'u62588198'
    NATKeepAlive.UseKeepAlive = False
    NATKeepAlive.IdleTimeMS = 0
    NATKeepAlive.IntervalMS = 0
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 727
    Top = 31
  end
  object qAgencias: TpFIBDataSet
    SelectSQL.Strings = (
      'select *'
      'from g_agencias')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 291
    Top = 365
  end
  object qExtras: TpFIBDataSet
    SelectSQL.Strings = (
      
        'select descripcion, valor from c_pedidos_extras where id_pedido=' +
        ':id_pedido')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    DataSource = ds_peds
    Left = 197
    Top = 197
    object qExtrasDESCRIPCION: TFIBStringField
      FieldName = 'DESCRIPCION'
      Size = 50
      EmptyStrToNull = True
    end
    object qExtrasVALOR: TFIBStringField
      FieldName = 'VALOR'
      Size = 200
      EmptyStrToNull = True
    end
  end
  object dsExtras: TDataSource
    DataSet = qExtras
    Left = 235
    Top = 197
  end
  object q_peds_lines_count: TpFIBDataSet
    SelectSQL.Strings = (
      'select count(*) as tot'
      'from c_pedidos_lines l'
      'where l.id_pedido=:id_pedido')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    DataSource = ds_peds
    Left = 286
    Top = 68
    poApplyRepositary = True
  end
  object cl: TScSSHClient
    HostKeyAlgorithms = <
      item
        Algorithm = aaRSA
      end
      item
        Algorithm = aaEC
      end
      item
        Algorithm = aaDSA
      end>
    HostName = '217.160.230.152'
    User = 'u62588198'
    Password = 'xzj2004MN4+'
    KeyStorage = st
    Left = 733
    Top = 104
  end
  object st: TScFileStorage
    Left = 733
    Top = 168
  end
  object f: TScSFTPClient
    SSHClient = cl
    Left = 733
    Top = 232
  end
  object q_peds_lines_extras: TpFIBDataSet
    SelectSQL.Strings = (
      'select *'
      'from c_pedidos_lines_extras l'
      'where l.id_pedido=:id_pedido and l.line=:line ')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 730
    Top = 299
    object lgs_peds_lines_extrasID_PEDIDO: TFIBIntegerField
      FieldName = 'ID_PEDIDO'
    end
    object lgs_peds_lines_extrasLINE: TFIBIntegerField
      FieldName = 'LINE'
    end
    object q_peds_lines_extrasEXTRA: TFIBStringField
      FieldName = 'EXTRA'
      Size = 50
      EmptyStrToNull = True
    end
    object q_peds_lines_extrasVALOR: TFIBStringField
      FieldName = 'VALOR'
      Size = 100
      EmptyStrToNull = True
    end
  end
  object ds_peds_lines_extras: TDataSource
    DataSet = q_peds_lines_extras
    Left = 730
    Top = 357
  end
  object q_usuario: TpFIBDataSet
    Left = 392
    Top = 520
  end
  object q_pick_lotes: TpFIBDataSet
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 680
    Top = 496
  end
  object qStockLotes: TpFIBDataSet
    SelectSQL.Strings = (
      
        'select id_estanteria || '#39'-'#39' || id_posicion || '#39'-'#39' || id_altura a' +
        's ubicacion, uds as cantidad, s.lote as id_lote, l.nombre as lot' +
        'e, l.caducidad '
      'from ubics_con_stock s '
      'inner join a_lotes l on l.id_lote=s.lote'
      'where id_articulo=:id_articulo and id_almacen=:id_almacen')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 675
    Top = 421
    object qStockLotesUBICACION: TFIBStringField
      DisplayWidth = 12
      FieldName = 'UBICACION'
      Size = 27
      EmptyStrToNull = True
    end
    object qStockLotesLOTE: TFIBStringField
      FieldName = 'LOTE'
      EmptyStrToNull = True
    end
    object qStockLotesCADUCIDAD: TFIBDateField
      DefaultExpression = 'TODAY'
      FieldName = 'CADUCIDAD'
      DisplayFormat = 'dd.mm.yyyy'
    end
    object lgsStockLotesCANTIDAD: TFIBIntegerField
      DisplayWidth = 5
      FieldName = 'CANTIDAD'
    end
    object lgsStockLotesID_LOTE: TFIBIntegerField
      FieldName = 'ID_LOTE'
    end
  end
  object dsStockLotes: TDataSource
    DataSet = qStockLotes
    Left = 739
    Top = 421
  end
  object q_lines_nserie: TpFIBDataSet
    SelectSQL.Strings = (
      
        'select n_serie from c_pedidos_lines l inner join g_articulos ar ' +
        'on ar.id_articulo=l.id_articulo'
      
        'where l.id_pedido=:id_pedido and l.id_articulo=:id_articulo and ' +
        'ar.tiene_n_serie=1 and l.n_serie<>'#39#39)
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 752
    Top = 496
    object q_lines_nserieN_SERIE: TFIBStringField
      FieldName = 'N_SERIE'
      Size = 50
      EmptyStrToNull = True
    end
  end
  object ds_lines_nserie: TDataSource
    DataSet = q_lines_nserie
    Left = 752
    Top = 544
  end
  object qStockSinPedidos: TpFIBDataSet
    SelectSQL.Strings = (
      '  select'
      '    sum(stock.stock) - sum(stock.stock1) as stock'
      'from'
      '    ('
      '    select'
      '        coalesce(sum(stock.cantidad), null, 0) as stock,'
      '        0 as stock1,'
      '        0 as stock2'
      '    from'
      '        a_stock stock'
      '    where'
      '        (stock.id_departamento = 0'
      '        or stock.id_departamento is null)'
      '        and stock.id_articulo = :id_articulo'
      
        '        AND stock.id_ubicacion NOT IN (SELECT aa.ubic_entrada FR' +
        'OM A_ALMACENES aa WHERE aa.ubic_entrada IS NOT null)'
      
        '        AND stock.id_ubicacion NOT IN (select uu.id_ubicacion fr' +
        'om a_ubicaciones uu where id_zona<>0)'
      '        and stock.id_almacen=:id_almacen_art'
      'union all'
      '    select'
      '        0 as stock,'
      '        coalesce(sum(pick.cantidad), null, 0) as stock1 ,'
      '        0 as stock2'
      '    from'
      '        a_picklin pick'
      
        '    inner join a_ubicaciones ubi on ubi.id_ubicacion = pick.id_u' +
        'bicacion'
      
        '    inner join a_pickcab pickcab on pickcab.id_pickcab=pick.id_p' +
        'ickcab'
      '    where'
      '        pick.id_articulo = :id_articulo'
      '        and lower(pick.situacion) = '#39'p'#39
      '        and pickcab.id_almacen=:id_almacen_art'
      ') as stock')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 283
    Top = 429
    object qStockSinPedidosSTOCK: TFIBBCDField
      FieldName = 'STOCK'
      Size = 0
    end
  end
  object q_ped_extra: TpFIBDataSet
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    DataSource = ds_peds
    Left = 309
    Top = 205
  end
end
