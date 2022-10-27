object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 450
  Width = 490
  object db: TpFIBDatabase
    DBName = '192.168.0.220:D:\FB\LOGINSER_ALMACEN.FDB'
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
    Left = 20
    Top = 16
  end
  object t_read: TpFIBTransaction
    DefaultDatabase = db
    Left = 71
    Top = 16
  end
  object t_write: TpFIBTransaction
    DefaultDatabase = db
    Left = 126
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
    Left = 181
    Top = 16
  end
  object dsbusqueda: TDataSource
    DataSet = busqueda
    Left = 235
    Top = 16
  end
  object q_pack: TpFIBDataSet
    SelectSQL.Strings = (
      
        'select b.codalbaran,b.id_caja,b.tipo_caja,a.codigo,a.nombre,lo.n' +
        'ombre as n_lote,'
      
        '    sum(l.cantidad) as total,sum(l.cantidad)-sum(l.cantidad_i) p' +
        'dtes'
      'from a_packlin l'
      'inner join g_articulos a on (l.id_articulo=a.id_articulo)'
      
        'inner join a_packlin_bulto b on (b.id_packlin_bulto=l.id_packlin' +
        '_bulto)'
      'inner join a_lotes lo on (l.id_lote=lo.id_lote)'
      
        'where l.id_packcab=5138 and l.id_agrupa=126 and l.nivel_agr=1 an' +
        'd l.cantidad_i<l.cantidad'
      'group by 1,2,3,4,5,6 order by 2,4')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 226
    Top = 90
  end
  object ds_pack: TDataSource
    DataSet = q_pack
    Left = 269
    Top = 91
  end
  object q_packagr: TpFIBDataSet
    SelectSQL.Strings = (
      
        'select b.id_caja,b.codalbaran,b.tipo_caja,l.codrepartidor,l.id_r' +
        'uta,l.id_packlin_bulto,'
      
        '  sum(l.cantidad) as total,sum(l.cantidad)-sum(l.cantidad_i) as ' +
        'pendiente'
      'from a_packlin l'
      
        'inner join a_packlin_bulto b on (l.id_packlin_bulto=b.id_packlin' +
        '_bulto)'
      'where l.id_packcab=5188 and l.id_agrupa=126 and l.nivel_agr=1'
      'group by 1,2,3,4,5,6 order by 1,2')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 33
    Top = 94
  end
  object ds_packagr: TDataSource
    DataSet = q_packagr
    Left = 97
    Top = 95
  end
  object q_fib: TpFIBDataSet
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 369
    Top = 18
  end
  object q_fib2: TpFIBDataSet
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 410
    Top = 16
  end
  object q_pack_leido: TpFIBDataSet
    SelectSQL.Strings = (
      
        'select b.codalbaran,b.id_caja,b.tipo_caja,a.codigo,a.nombre,lo.n' +
        'ombre as n_lote,'
      '    sum(l.cantidad) as total,sum(l.cantidad_i) as leidos'
      'from a_packlin l'
      'inner join g_articulos a on (l.id_articulo=a.id_articulo)'
      
        'inner join a_packlin_bulto b on (b.id_packlin_bulto=l.id_packlin' +
        '_bulto)'
      'inner join a_lotes lo on (l.id_lote=lo.id_lote)'
      
        'where l.id_packcab=5138 and l.id_agrupa=126 and l.nivel_agr=1 an' +
        'd l.cantidad_i>0'
      'group by 1,2,3,4,5,6 order by 2,4'
      '')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 321
    Top = 90
  end
  object ds_pack_leido: TDataSource
    DataSet = q_pack_leido
    Left = 389
    Top = 92
  end
  object qu_1: TpFIBQuery
    Transaction = t_write
    Database = db
    Left = 28
    Top = 166
  end
  object q_etiq_indiv: TpFIBDataSet
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
    Left = 224
    Top = 159
  end
  object q_etiq_bulto: TpFIBDataSet
    SelectSQL.Strings = (
      
        'select l.sulinea,l.id_ruta as codruta,l.codalbaran,l.att,b.dst_n' +
        'ombre,b.dst_calle,b.dst_localidad,b.dst_provincia,b.dst_cp,'
      
        '    a.codigo as referencia,a.nombre as articulo,b.paquetes as nt' +
        'ot,l.n_parcial as n,l.id_packcab, l.id_agrupa,l.nivel_agr,l.line' +
        'a,c.logo_ind'
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
    Left = 283
    Top = 165
  end
  object cds_bultos: TClientDataSet
    PersistDataPacket.Data = {
      160500009619E0BD01000000180000002F000000000003000000160506636F64
      636C6904000100000000000A636F64616C626172616E04000100000000000875
      6E6964616465730400010000000000056665636861080008000000000007636F
      6472757461040001000000000006636F64647374010049000000010005574944
      5448020002000C000A6473745F6E6F6D62726501004900000001000557494454
      48020002003C00096473745F63616C6C65010049000000010005574944544802
      0002003C00066473745F63700100490000000100055749445448020002000A00
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
      000A6368726F6E6F5F6578700100490000000100055749445448020002001400
      0A6368726F6E6F5F726566010049000000010005574944544802000200140008
      636F6462756C746F0100490000000100055749445448020002001E0006706466
      343137020049000000010005574944544802000200E803046C6F676F04004B00
      0000010007535542545950450200490009004772617068696373000769645F63
      616A610400010000000000097469706F5F63616A610100490000000100055749
      4454480200020001000D6F72675F70726F76696E636961010049000000010005
      5749445448020002003C000A61736D5F636F7272656F01004900000001000557
      494454480200020064000A61736D5F636F64636C690100490000000100055749
      4454480200020014000B61736D5F686F726172696F0100490000000100055749
      4454480200020064000961736D5F6D6E656D6F01004900000001000557494454
      48020002000A000961736D5F706F626C61010049000000010005574944544802
      00020064000C61736D5F62635F68756D616E0100490000000100055749445448
      0200020032000C61736D5F747261636B696E6701004900000001000557494454
      480200020032000661736D5F6263010049000000010005574944544802000200
      3200086473745F70616973010049000000010005574944544802000200140003
      617762010049000000010005574944544802000200140006616475616E610400
      01000000000009636F64616C6265746904000100000000000000}
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
        Size = 10
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
        Size = 20
      end
      item
        Name = 'chrono_ref'
        DataType = ftString
        Size = 20
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
        Name = 'asm_correo'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'asm_codcli'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'asm_horario'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'asm_mnemo'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'asm_pobla'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'asm_bc_human'
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
        Name = 'dst_pais'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'awb'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'aduana'
        DataType = ftInteger
      end
      item
        Name = 'codalbeti'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    OnCalcFields = cds_bultosCalcFields
    Left = 348
    Top = 167
    object intgrfld_bultoscodcli: TIntegerField
      FieldName = 'codcli'
    end
    object intgrfld_bultoscodalbaran: TIntegerField
      FieldName = 'codalbaran'
    end
    object intgrfld_bultoscodalbeti: TIntegerField
      FieldName = 'codalbeti'
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
      Size = 10
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
    end
    object strngfld_bultoschrono_ref: TStringField
      FieldName = 'chrono_ref'
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
      Size = 100
    end
    object strngfld_bultosasm_codcli: TStringField
      FieldName = 'asm_codcli'
    end
    object strngfld_bultosasm_horario: TStringField
      FieldName = 'asm_horario'
      Size = 100
    end
    object strngfld_bultosasm_mnemo: TStringField
      FieldName = 'asm_mnemo'
      Size = 10
    end
    object strngfld_bultosasm_pobla: TStringField
      FieldName = 'asm_pobla'
      Size = 100
    end
    object strngfld_bultosasm_bc_human: TStringField
      FieldName = 'asm_bc_human'
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
    object strngfld_bultosdst_pais: TStringField
      FieldName = 'dst_pais'
    end
    object strngfld_bultosawb: TStringField
      FieldName = 'awb'
    end
    object intgrfld_bultosaduana: TIntegerField
      FieldName = 'aduana'
    end
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
    Left = 40
    Top = 290
  end
  object q_hoja_pick: TpFIBDataSet
    SelectSQL.Strings = (
      'select b.codalbaran,b.fecha_alb,b.dst_codcli,b.dst_coddel,'
      
        '      b.cod_ruta,b.tipo_caja,b.id_caja,b.dst_nombre,b.dst_calle,' +
        'b.dst_cp,'
      
        '      b.dst_localidad,b.dst_provincia,iif(a.id_cliente=7004,subs' +
        'tring(a.codigo from 7 for 6),a.codigo) as codigo,'
      
        '      iif(a.id_cliente=7004,l.sulinea,0) as bc,a.nombre,l.att,l.' +
        'sulinea,b.codcli, lo.id_lote, lo.nombre as n_lote, lo.caducidad,' +
        ' '
      '      sum(l.cantidad) as cantidad'
      '    from a_packlin l'
      
        '    inner join a_packlin_bulto b on (l.id_packlin_bulto=b.id_pac' +
        'klin_bulto)'
      '    inner join g_articulos a on (l.id_articulo=a.id_articulo)'
      '    inner join a_lotes lo on (lo.id_lote = l.id_lote)'
      
        '    where l.id_packcab=6358 and l.id_agrupa=121 and l.nivel_agr=' +
        '1 and l.codalbaran=462424'
      
        '    group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,' +
        '21'
      '    order by 16,17')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 222
    Top = 218
  end
  object qry_sql2: TADOQuery
    Connection = con1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      '')
    Left = 115
    Top = 293
  end
  object qrytemp: TADOQuery
    Connection = con1
    CursorType = ctStatic
    LockType = ltReadOnly
    Parameters = <>
    Left = 189
    Top = 298
  end
  object qDHL: TpFIBDataSet
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 323
    Top = 255
  end
  object qu_dhl: TpFIBQuery
    Transaction = t_write
    Database = db
    Left = 366
    Top = 256
  end
  object q_aux: TpFIBDataSet
    SelectSQL.Strings = (
      
        'select b.codalbaran,b.id_caja,b.tipo_caja,a.codigo,a.nombre,lo.n' +
        'ombre as n_lote,'
      
        '    sum(l.cantidad) as total,sum(l.cantidad)-sum(l.cantidad_i) p' +
        'dtes'
      'from a_packlin l'
      'inner join g_articulos a on (l.id_articulo=a.id_articulo)'
      
        'inner join a_packlin_bulto b on (b.id_packlin_bulto=l.id_packlin' +
        '_bulto)'
      'inner join a_lotes lo on (l.id_lote=lo.id_lote)'
      
        'where l.id_packcab=5138 and l.id_agrupa=126 and l.nivel_agr=1 an' +
        'd l.cantidad_i<l.cantidad'
      'group by 1,2,3,4,5,6 order by 2,4')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 140
    Top = 138
  end
  object qry_kgs: TpFIBDataSet
    SelectSQL.Strings = (
      
        'select b.codalbaran,b.id_caja,b.tipo_caja,a.codigo,a.nombre,lo.n' +
        'ombre as n_lote,'
      
        '    sum(l.cantidad) as total,sum(l.cantidad)-sum(l.cantidad_i) p' +
        'dtes'
      'from a_packlin l'
      'inner join g_articulos a on (l.id_articulo=a.id_articulo)'
      
        'inner join a_packlin_bulto b on (b.id_packlin_bulto=l.id_packlin' +
        '_bulto)'
      'inner join a_lotes lo on (l.id_lote=lo.id_lote)'
      
        'where l.id_packcab=5138 and l.id_agrupa=126 and l.nivel_agr=1 an' +
        'd l.cantidad_i<l.cantidad'
      'group by 1,2,3,4,5,6 order by 2,4')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 263
    Top = 283
  end
  object q_DHL_PAISES: TpFIBDataSet
    SelectSQL.Strings = (
      
        'select b.codalbaran,b.id_caja,b.tipo_caja,a.codigo,a.nombre,lo.n' +
        'ombre as n_lote,'
      
        '    sum(l.cantidad) as total,sum(l.cantidad)-sum(l.cantidad_i) p' +
        'dtes'
      'from a_packlin l'
      'inner join g_articulos a on (l.id_articulo=a.id_articulo)'
      
        'inner join a_packlin_bulto b on (b.id_packlin_bulto=l.id_packlin' +
        '_bulto)'
      'inner join a_lotes lo on (l.id_lote=lo.id_lote)'
      
        'where l.id_packcab=5138 and l.id_agrupa=126 and l.nivel_agr=1 an' +
        'd l.cantidad_i<l.cantidad'
      'group by 1,2,3,4,5,6 order by 2,4')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 326
    Top = 302
  end
  object qry_tmp: TpFIBDataSet
    SelectSQL.Strings = (
      
        'select b.codalbaran,b.id_caja,b.tipo_caja,a.codigo,a.nombre,lo.n' +
        'ombre as n_lote,'
      
        '    sum(l.cantidad) as total,sum(l.cantidad)-sum(l.cantidad_i) p' +
        'dtes'
      'from a_packlin l'
      'inner join g_articulos a on (l.id_articulo=a.id_articulo)'
      
        'inner join a_packlin_bulto b on (b.id_packlin_bulto=l.id_packlin' +
        '_bulto)'
      'inner join a_lotes lo on (l.id_lote=lo.id_lote)'
      
        'where l.id_packcab=5138 and l.id_agrupa=126 and l.nivel_agr=1 an' +
        'd l.cantidad_i<l.cantidad'
      'group by 1,2,3,4,5,6 order by 2,4')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 410
    Top = 300
  end
  object qry_sql3: TpFIBDataSet
    SelectSQL.Strings = (
      
        'select b.codalbaran,b.id_caja,b.tipo_caja,a.codigo,a.nombre,lo.n' +
        'ombre as n_lote,'
      
        '    sum(l.cantidad) as total,sum(l.cantidad)-sum(l.cantidad_i) p' +
        'dtes'
      'from a_packlin l'
      'inner join g_articulos a on (l.id_articulo=a.id_articulo)'
      
        'inner join a_packlin_bulto b on (b.id_packlin_bulto=l.id_packlin' +
        '_bulto)'
      'inner join a_lotes lo on (l.id_lote=lo.id_lote)'
      
        'where l.id_packcab=5138 and l.id_agrupa=126 and l.nivel_agr=1 an' +
        'd l.cantidad_i<l.cantidad'
      'group by 1,2,3,4,5,6 order by 2,4')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 103
    Top = 194
  end
  object qry_Traduccion: TpFIBDataSet
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 406
    Top = 149
    poSupportUnicodeBlobs = True
  end
  object qry_EtiquetaNec: TpFIBDataSet
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 404
    Top = 205
    poSupportUnicodeBlobs = True
  end
  object qRemPor: TpFIBDataSet
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 275
    Top = 231
  end
  object xEtiquetas: TpFIBDataSet
    SelectSQL.Strings = (
      'select * from tmp_lst_etiquetas'
      'where usuario=:usuario'
      '')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 41
    Top = 375
    object xEtiquetasUSUARIO: TFIBIntegerField
      FieldName = 'USUARIO'
    end
    object xEtiquetasID_ALBARAN: TFIBIntegerField
      FieldName = 'ID_ALBARAN'
    end
  end
  object xAlbaran: TpFIBDataSet
    SelectSQL.Strings = (
      'select bultos,peso'
      'from albaranes '
      'where id_albaran=:id_albaran'
      '')
    Left = 113
    Top = 375
    object xAlbaranBULTOS: TFIBSmallIntField
      FieldName = 'BULTOS'
    end
    object xAlbaranPESO: TFIBFloatField
      FieldName = 'PESO'
    end
  end
  object xBultos: TpFIBDataSet
    SelectSQL.Strings = (
      'select count(*) as bultos from albaran_bultos'
      'where id_albaran=:id_albaran')
    Left = 177
    Top = 375
    object xBultosBULTOS: TFIBIntegerField
      FieldName = 'BULTOS'
    end
  end
  object xSigBulto: TpFIBDataSet
    SelectSQL.Strings = (
      'select max(bulto) max_bulto from albaran_bultos'
      'where id_albaran=:id_albaran')
    Left = 233
    Top = 375
    object xSigBultoMAX_BULTO: TFIBSmallIntField
      FieldName = 'MAX_BULTO'
    end
  end
  object xPedidoLines: TpFIBDataSet
    SelectSQL.Strings = (
      'select id_articulo, cantidad, kgs, nombre_art, imei'
      'from c_pedidos_lines'
      'where id_pedido=:id_pedido')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 297
    Top = 375
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
  object dxcmpntprntrdxprinter: TdxComponentPrinter
    CurrentLink = dxpdfvwrprtlnkdxcmpntprntrdxprinterlink
    PreviewOptions.PreviewBoundsRect = {74010000DB0000007205000026030000}
    Version = 0
    Left = 378
    Top = 378
    PixelsPerInch = 96
    object dxpdfvwrprtlnkdxcmpntprntrdxprinterlink: TdxPDFViewerReportLink
      PrinterPage.CenterOnPageH = True
      PrinterPage.CenterOnPageV = True
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 4242
      PrinterPage.Header = 4242
      PrinterPage.Margins.Bottom = 4242
      PrinterPage.Margins.Left = 4242
      PrinterPage.Margins.Right = 4242
      PrinterPage.Margins.Top = 4242
      PrinterPage.Orientation = poAuto
      PrinterPage.PageSize.X = 210000
      PrinterPage.PageSize.Y = 297000
      PrinterPage.ScaleMode = smFit
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.CreationDate = 43613.529339537040000000
      ShrinkToPageWidth = True
      PixelsPerInch = 96
      BuiltInReportLink = True
    end
  end
  object q_1: TpFIBQuery
    Transaction = t_write
    Database = db
    Left = 440
    Top = 360
  end
end
