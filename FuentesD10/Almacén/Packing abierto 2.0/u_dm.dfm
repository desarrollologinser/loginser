object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 592
  Width = 746
  object db: TpFIBDatabase
    AutoReconnect = True
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
    Left = 30
    Top = 18
  end
  object t_read: TpFIBTransaction
    Active = True
    DefaultDatabase = db
    TRParams.Strings = (
      'write'
      'isc_tpb_nowait'
      'read_committed'
      'rec_version')
    TPBMode = tpbDefault
    Left = 87
    Top = 17
  end
  object t_write: TpFIBTransaction
    DefaultDatabase = db
    Left = 135
    Top = 16
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
    object cds_bultoscodcli: TIntegerField
      FieldName = 'codcli'
    end
    object cds_bultoscodalbaran: TIntegerField
      FieldName = 'codalbaran'
    end
    object cds_bultosunidades: TIntegerField
      FieldName = 'unidades'
    end
    object dtmfld_bultosfecha: TDateTimeField
      FieldName = 'fecha'
    end
    object cds_bultoscodruta: TIntegerField
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
    object cds_bultosbultos: TIntegerField
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
    object cds_bultosordenbulto: TIntegerField
      FieldName = 'ordenbulto'
    end
    object cds_bultoscodrepartidor: TIntegerField
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
    object cds_bultosid_caja: TIntegerField
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
    object strngfld_bultosorg_provincia: TStringField
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
  object q_albaranes: TpFIBDataSet
    SelectSQL.Strings = (
      
        'select * from albaranes a inner join albaran_dest d on d.id_alba' +
        'ran=a.id_albaran')
    Transaction = t_read_gestoras
    Database = db_gestoras
    UpdateTransaction = t_write_gestoras
    Left = 666
    Top = 187
    object lgs_albaranesID_ALBARAN: TFIBIntegerField
      FieldName = 'ID_ALBARAN'
    end
    object lgs_albaranesSEDE: TFIBSmallIntField
      FieldName = 'SEDE'
    end
    object lgs_albaranesFECHA_ALBARAN: TFIBDateTimeField
      FieldName = 'FECHA_ALBARAN'
    end
    object lgs_albaranesTIPO_ALBARAN: TFIBSmallIntField
      FieldName = 'TIPO_ALBARAN'
    end
    object lgs_albaranesESTADO: TFIBSmallIntField
      FieldName = 'ESTADO'
    end
    object lgs_albaranesAGENCIA: TFIBSmallIntField
      FieldName = 'AGENCIA'
    end
    object q_albaranesEXPEDICION_AGE: TFIBStringField
      FieldName = 'EXPEDICION_AGE'
      Size = 60
      EmptyStrToNull = True
    end
    object lgs_albaranesORIGEN_WEB: TFIBSmallIntField
      FieldName = 'ORIGEN_WEB'
    end
    object lgs_albaranesEMPRESA: TFIBSmallIntField
      FieldName = 'EMPRESA'
    end
    object lgs_albaranesCLIENTE: TFIBIntegerField
      FieldName = 'CLIENTE'
    end
    object lgs_albaranesID_CLIENTE: TFIBIntegerField
      FieldName = 'ID_CLIENTE'
    end
    object q_albaranesALBARAN_CLIENTE: TFIBStringField
      FieldName = 'ALBARAN_CLIENTE'
      Size = 60
      EmptyStrToNull = True
    end
    object lgs_albaranesTIPO_SERVICIO: TFIBSmallIntField
      FieldName = 'TIPO_SERVICIO'
    end
    object lgs_albaranesHORARIO: TFIBSmallIntField
      FieldName = 'HORARIO'
    end
    object q_albaranesARCHIVO_RESGUARDO: TFIBStringField
      FieldName = 'ARCHIVO_RESGUARDO'
      Size = 250
      EmptyStrToNull = True
    end
    object lgs_albaranesPAQUETES: TFIBFloatField
      FieldName = 'PAQUETES'
    end
    object lgs_albaranesBULTOS: TFIBIntegerField
      FieldName = 'BULTOS'
    end
    object lgs_albaranesPESO: TFIBFloatField
      FieldName = 'PESO'
    end
    object lgs_albaranesKGS_VOL: TFIBFloatField
      FieldName = 'KGS_VOL'
    end
    object lgs_albaranesZONA: TFIBIntegerField
      FieldName = 'ZONA'
    end
    object lgs_albaranesREPARTIDOR: TFIBSmallIntField
      FieldName = 'REPARTIDOR'
    end
    object lgs_albaranesPORTES_DEBIDOS: TFIBSmallIntField
      FieldName = 'PORTES_DEBIDOS'
    end
    object lgs_albaranesIMPORTE_PORTES: TFIBFloatField
      FieldName = 'IMPORTE_PORTES'
    end
    object lgs_albaranesREEMBOLSO: TFIBSmallIntField
      FieldName = 'REEMBOLSO'
    end
    object lgs_albaranesIMPORTE_REEMBOLSO: TFIBFloatField
      FieldName = 'IMPORTE_REEMBOLSO'
    end
    object lgs_albaranesASEGURADO: TFIBSmallIntField
      FieldName = 'ASEGURADO'
    end
    object lgs_albaranesIMPORTE_ASEGURADO: TFIBFloatField
      FieldName = 'IMPORTE_ASEGURADO'
    end
    object lgs_albaranesRETORNO: TFIBSmallIntField
      FieldName = 'RETORNO'
    end
    object q_albaranesOBSERVACIONES: TFIBMemoField
      FieldName = 'OBSERVACIONES'
      BlobType = ftMemo
      Size = 8
    end
    object q_albaranesNOTAS_INTERNAS: TFIBMemoField
      FieldName = 'NOTAS_INTERNAS'
      BlobType = ftMemo
      Size = 8
    end
    object q_albaranesORIG_NOMBRE: TFIBStringField
      FieldName = 'ORIG_NOMBRE'
      Size = 60
      EmptyStrToNull = True
    end
    object q_albaranesORIG_CALLE: TFIBStringField
      FieldName = 'ORIG_CALLE'
      Size = 150
      EmptyStrToNull = True
    end
    object lgs_albaranesORIG_ID_LOCAL: TFIBIntegerField
      FieldName = 'ORIG_ID_LOCAL'
    end
    object q_albaranesORIG_COD_POSTAL: TFIBStringField
      FieldName = 'ORIG_COD_POSTAL'
      Size = 10
      EmptyStrToNull = True
    end
    object q_albaranesORIG_LOCALIDAD: TFIBStringField
      FieldName = 'ORIG_LOCALIDAD'
      Size = 60
      EmptyStrToNull = True
    end
    object q_albaranesORIG_PROVINCIA: TFIBStringField
      FieldName = 'ORIG_PROVINCIA'
      Size = 60
      EmptyStrToNull = True
    end
    object q_albaranesORIG_PAIS: TFIBStringField
      FieldName = 'ORIG_PAIS'
      Size = 3
      EmptyStrToNull = True
    end
    object q_albaranesORIG_TELEFONO: TFIBStringField
      FieldName = 'ORIG_TELEFONO'
      Size = 15
      EmptyStrToNull = True
    end
    object q_albaranesORIG_TELEFONO2: TFIBStringField
      FieldName = 'ORIG_TELEFONO2'
      Size = 15
      EmptyStrToNull = True
    end
    object q_albaranesORIG_CONTACTO: TFIBStringField
      FieldName = 'ORIG_CONTACTO'
      Size = 60
      EmptyStrToNull = True
    end
    object q_albaranesORIG_NOTAS: TFIBMemoField
      FieldName = 'ORIG_NOTAS'
      BlobType = ftMemo
      Size = 8
    end
    object q_albaranesORIG_EMAIL: TFIBStringField
      FieldName = 'ORIG_EMAIL'
      Size = 100
      EmptyStrToNull = True
    end
    object lgs_albaranesVEHICULO: TFIBSmallIntField
      FieldName = 'VEHICULO'
    end
    object lgs_albaranesDNI_NOMBRE: TFIBSmallIntField
      FieldName = 'DNI_NOMBRE'
    end
    object lgs_albaranesRCS: TFIBSmallIntField
      FieldName = 'RCS'
    end
    object lgs_albaranesDIGITALIZADO: TFIBSmallIntField
      FieldName = 'DIGITALIZADO'
    end
    object q_albaranesCAMPO_STR1: TFIBStringField
      FieldName = 'CAMPO_STR1'
      Size = 100
      EmptyStrToNull = True
    end
    object q_albaranesCAMPO_STR2: TFIBStringField
      FieldName = 'CAMPO_STR2'
      Size = 100
      EmptyStrToNull = True
    end
    object q_albaranesCAMPO_STR3: TFIBStringField
      FieldName = 'CAMPO_STR3'
      Size = 100
      EmptyStrToNull = True
    end
    object lgs_albaranesCAMPO_CANT1: TFIBFloatField
      FieldName = 'CAMPO_CANT1'
    end
    object lgs_albaranesCAMPO_CANT2: TFIBFloatField
      FieldName = 'CAMPO_CANT2'
    end
    object lgs_albaranesCAMPO_CANT3: TFIBFloatField
      FieldName = 'CAMPO_CANT3'
    end
    object lgs_albaranesENTRADA: TFIBIntegerField
      FieldName = 'ENTRADA'
    end
    object lgs_albaranesVALIJA: TFIBSmallIntField
      FieldName = 'VALIJA'
    end
    object lgs_albaranesRECOGIDA_PROPIA: TFIBSmallIntField
      FieldName = 'RECOGIDA_PROPIA'
    end
    object lgs_albaranesRECOGIDA_NACIONAL: TFIBSmallIntField
      FieldName = 'RECOGIDA_NACIONAL'
    end
    object lgs_albaranesAUTOMATICO: TFIBSmallIntField
      FieldName = 'AUTOMATICO'
    end
    object lgs_albaranesSEGUIMIENTO: TFIBSmallIntField
      FieldName = 'SEGUIMIENTO'
    end
    object q_albaranesALBARAN_AGENCIA: TFIBStringField
      FieldName = 'ALBARAN_AGENCIA'
      Size = 60
      EmptyStrToNull = True
    end
    object lgs_albaranesFACTURABLE: TFIBSmallIntField
      FieldName = 'FACTURABLE'
    end
    object lgs_albaranesCAMPO_CK1: TFIBSmallIntField
      FieldName = 'CAMPO_CK1'
    end
    object lgs_albaranesCAMPO_CK2: TFIBSmallIntField
      FieldName = 'CAMPO_CK2'
    end
    object lgs_albaranesCAMPO_CK3: TFIBSmallIntField
      FieldName = 'CAMPO_CK3'
    end
    object lgs_albaranesFECHA_SERVICIO: TFIBDateTimeField
      FieldName = 'FECHA_SERVICIO'
    end
    object lgs_albaranesORIG_H_DESDE: TFIBDateTimeField
      FieldName = 'ORIG_H_DESDE'
    end
    object lgs_albaranesORIG_H_HASTA: TFIBDateTimeField
      FieldName = 'ORIG_H_HASTA'
    end
    object lgs_albaranesAYUDANTE: TFIBSmallIntField
      FieldName = 'AYUDANTE'
    end
    object lgs_albaranesDESEMBOLSO: TFIBSmallIntField
      FieldName = 'DESEMBOLSO'
    end
    object lgs_albaranesIMPORTE_DESEMBOLSO: TFIBFloatField
      FieldName = 'IMPORTE_DESEMBOLSO'
    end
    object lgs_albaranesSEGUNDA_ENTREGA: TFIBSmallIntField
      FieldName = 'SEGUNDA_ENTREGA'
    end
    object lgs_albaranesDUA_IMPORT: TFIBSmallIntField
      FieldName = 'DUA_IMPORT'
    end
    object lgs_albaranesDUA_EXPORT: TFIBSmallIntField
      FieldName = 'DUA_EXPORT'
    end
    object lgs_albaranesMINUTOS_ESPERA: TFIBSmallIntField
      FieldName = 'MINUTOS_ESPERA'
    end
    object q_albaranesORIG_CODIGO: TFIBStringField
      FieldName = 'ORIG_CODIGO'
      EmptyStrToNull = True
    end
    object lgs_albaranesORIG_H_DESDE2: TFIBDateTimeField
      FieldName = 'ORIG_H_DESDE2'
    end
    object lgs_albaranesORIG_H_HASTA2: TFIBDateTimeField
      FieldName = 'ORIG_H_HASTA2'
    end
    object lgs_albaranesPESO_EXPEDICION: TFIBFloatField
      FieldName = 'PESO_EXPEDICION'
    end
    object lgs_albaranesBULTOS_TOTALES: TFIBSmallIntField
      FieldName = 'BULTOS_TOTALES'
    end
    object q_albaranesORIG_COD_PROVINCIA: TFIBStringField
      FieldName = 'ORIG_COD_PROVINCIA'
      Size = 2
      EmptyStrToNull = True
    end
    object q_albaranesORIG_NIF: TFIBStringField
      FieldName = 'ORIG_NIF'
      EmptyStrToNull = True
    end
    object q_albaranesORIG_DEPARTAMENTO: TFIBStringField
      FieldName = 'ORIG_DEPARTAMENTO'
      Size = 60
      EmptyStrToNull = True
    end
    object lgs_albaranesDAC: TFIBSmallIntField
      FieldName = 'DAC'
    end
    object lgs_albaranesPOD: TFIBSmallIntField
      FieldName = 'POD'
    end
    object q_albaranesREF_CLIENTE: TFIBStringField
      FieldName = 'REF_CLIENTE'
      Size = 100
      EmptyStrToNull = True
    end
    object q_albaranesREF_CLIENTE_2: TFIBStringField
      FieldName = 'REF_CLIENTE_2'
      Size = 100
      EmptyStrToNull = True
    end
    object q_albaranesCONTENIDO: TFIBStringField
      FieldName = 'CONTENIDO'
      Size = 255
      EmptyStrToNull = True
    end
    object lgs_albaranesFECHA_PREVISTA: TFIBDateTimeField
      FieldName = 'FECHA_PREVISTA'
    end
    object lgs_albaranesSOLICITUD: TFIBIntegerField
      FieldName = 'SOLICITUD'
    end
    object lgs_albaranesFACT_DEVOLUCION: TFIBSmallIntField
      FieldName = 'FACT_DEVOLUCION'
    end
    object lgs_albaranesFACT_RCS: TFIBSmallIntField
      FieldName = 'FACT_RCS'
    end
    object lgs_albaranesFACT_RETORNO: TFIBSmallIntField
      FieldName = 'FACT_RETORNO'
    end
    object lgs_albaranesSEDE_DESTINO: TFIBSmallIntField
      FieldName = 'SEDE_DESTINO'
    end
    object lgs_albaranesSEDE_ORIGEN: TFIBSmallIntField
      FieldName = 'SEDE_ORIGEN'
    end
    object lgs_albaranesTIENE_INCIDENCIA: TFIBSmallIntField
      FieldName = 'TIENE_INCIDENCIA'
    end
    object q_albaranesTIPO_SERVICIO_AGE: TFIBStringField
      FieldName = 'TIPO_SERVICIO_AGE'
      EmptyStrToNull = True
    end
    object q_albaranesHORARIO_AGE: TFIBStringField
      FieldName = 'HORARIO_AGE'
      EmptyStrToNull = True
    end
    object lgs_albaranesKGS_VOL_EXPEDICION: TFIBFloatField
      FieldName = 'KGS_VOL_EXPEDICION'
    end
    object lgs_albaranesTOTAL_ALBARAN_TARIF: TFIBFloatField
      FieldName = 'TOTAL_ALBARAN_TARIF'
    end
    object lgs_albaranesTOTAL_COBRAR: TFIBFloatField
      FieldName = 'TOTAL_COBRAR'
    end
    object lgs_albaranesFACTURADO: TFIBSmallIntField
      FieldName = 'FACTURADO'
    end
    object lgs_albaranesKGS_FACTURADOS: TFIBFloatField
      FieldName = 'KGS_FACTURADOS'
    end
    object lgs_albaranesKMS: TFIBFloatField
      FieldName = 'KMS'
    end
    object lgs_albaranesVOLVER_A_FACTURAR: TFIBSmallIntField
      FieldName = 'VOLVER_A_FACTURAR'
    end
    object lgs_albaranesTIENE_PICKING: TFIBSmallIntField
      FieldName = 'TIENE_PICKING'
    end
    object lgs_albaranesSOLICITUD_RETORNO: TFIBIntegerField
      FieldName = 'SOLICITUD_RETORNO'
    end
    object lgs_albaranesTOTAL_COSTE: TFIBFloatField
      FieldName = 'TOTAL_COSTE'
    end
    object q_albaranesORIG_OBSERVACIONES: TFIBMemoField
      FieldName = 'ORIG_OBSERVACIONES'
      BlobType = ftMemo
      Size = 8
    end
    object lgs_albaranesCREATOR_ID: TFIBIntegerField
      FieldName = 'CREATOR_ID'
    end
    object lgs_albaranesENVIADO_AGENCIA: TFIBSmallIntField
      FieldName = 'ENVIADO_AGENCIA'
    end
    object lgs_albaranesALBARAN_RETORNO: TFIBIntegerField
      FieldName = 'ALBARAN_RETORNO'
    end
    object lgs_albaranesVUELVE_A_ZONA: TFIBSmallIntField
      FieldName = 'VUELVE_A_ZONA'
    end
    object lgs_albaranesHORAS_AYUD: TFIBFloatField
      FieldName = 'HORAS_AYUD'
    end
    object lgs_albaranesREEMBOLSO_LIQUIDADO: TFIBSmallIntField
      FieldName = 'REEMBOLSO_LIQUIDADO'
    end
    object lgs_albaranesFECHA_LIQUID_REEMBOLSO: TFIBDateTimeField
      FieldName = 'FECHA_LIQUID_REEMBOLSO'
    end
    object lgs_albaranesREEMBOLSO_ABONADO: TFIBSmallIntField
      FieldName = 'REEMBOLSO_ABONADO'
    end
    object lgs_albaranesFECHA_ABONO_REEMBOLSO: TFIBDateTimeField
      FieldName = 'FECHA_ABONO_REEMBOLSO'
    end
    object lgs_albaranesDOC_REEMBOLSO: TFIBIntegerField
      FieldName = 'DOC_REEMBOLSO'
    end
    object lgs_albaranesID_ALBARAN_DET: TFIBIntegerField
      FieldName = 'ID_ALBARAN_DET'
    end
    object lgs_albaranesID_ALBARAN1: TFIBIntegerField
      FieldName = 'ID_ALBARAN1'
    end
    object lgs_albaranesLINEA: TFIBSmallIntField
      FieldName = 'LINEA'
    end
    object q_albaranesNOMBRE: TFIBStringField
      FieldName = 'NOMBRE'
      Size = 60
      EmptyStrToNull = True
    end
    object q_albaranesCALLE: TFIBStringField
      FieldName = 'CALLE'
      Size = 150
      EmptyStrToNull = True
    end
    object q_albaranesCOD_POSTAL: TFIBStringField
      FieldName = 'COD_POSTAL'
      Size = 10
      EmptyStrToNull = True
    end
    object q_albaranesLOCALIDAD: TFIBStringField
      FieldName = 'LOCALIDAD'
      Size = 60
      EmptyStrToNull = True
    end
    object q_albaranesPROVINCIA: TFIBStringField
      FieldName = 'PROVINCIA'
      Size = 60
      EmptyStrToNull = True
    end
    object q_albaranesPAIS: TFIBStringField
      FieldName = 'PAIS'
      Size = 3
      EmptyStrToNull = True
    end
    object q_albaranesTELEFONO: TFIBStringField
      FieldName = 'TELEFONO'
      Size = 15
      EmptyStrToNull = True
    end
    object q_albaranesTELEFONO2: TFIBStringField
      FieldName = 'TELEFONO2'
      Size = 15
      EmptyStrToNull = True
    end
    object q_albaranesEMAIL: TFIBStringField
      FieldName = 'EMAIL'
      Size = 100
      EmptyStrToNull = True
    end
    object q_albaranesCONTACTO: TFIBStringField
      FieldName = 'CONTACTO'
      Size = 60
      EmptyStrToNull = True
    end
    object q_albaranesOBSERVACIONES1: TFIBMemoField
      FieldName = 'OBSERVACIONES1'
      BlobType = ftMemo
      Size = 8
    end
    object lgs_albaranesENTRADA1: TFIBIntegerField
      FieldName = 'ENTRADA1'
    end
    object lgs_albaranesID_LOCAL: TFIBIntegerField
      FieldName = 'ID_LOCAL'
    end
    object lgs_albaranesPRINCIPAL: TFIBSmallIntField
      FieldName = 'PRINCIPAL'
    end
    object lgs_albaranesH_DESDE: TFIBDateTimeField
      FieldName = 'H_DESDE'
    end
    object lgs_albaranesH_HASTA: TFIBDateTimeField
      FieldName = 'H_HASTA'
    end
    object q_albaranesCODIGO: TFIBStringField
      FieldName = 'CODIGO'
      EmptyStrToNull = True
    end
    object lgs_albaranesH_DESDE2: TFIBDateTimeField
      FieldName = 'H_DESDE2'
    end
    object lgs_albaranesH_HASTA2: TFIBDateTimeField
      FieldName = 'H_HASTA2'
    end
    object q_albaranesCOD_PROVINCIA: TFIBStringField
      FieldName = 'COD_PROVINCIA'
      Size = 2
      EmptyStrToNull = True
    end
    object q_albaranesNIF: TFIBStringField
      FieldName = 'NIF'
      EmptyStrToNull = True
    end
    object q_albaranesDEPARTAMENTO: TFIBStringField
      FieldName = 'DEPARTAMENTO'
      Size = 60
      EmptyStrToNull = True
    end
    object lgs_albaranesRECIBIR: TFIBSmallIntField
      FieldName = 'RECIBIR'
    end
  end
  object db_gestoras: TpFIBDatabase
    AutoReconnect = True
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
    Left = 592
    Top = 135
  end
  object response: TRESTResponse
    Left = 592
    Top = 247
  end
  object request: TRESTRequest
    Client = client
    Method = rmPOST
    Params = <>
    Response = response
    SynchronizedEvents = False
    Left = 592
    Top = 191
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
    Left = 656
    Top = 256
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
    Left = 592
    Top = 328
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
    Left = 600
    Top = 440
  end
  object RESTResponse1: TRESTResponse
    ContentType = 'text/html'
    Left = 600
    Top = 384
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
    Left = 596
    Top = 505
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
    Top = 78
  end
  object ds_packagr: TDataSource
    DataSet = q_packagr
    Left = 97
    Top = 79
  end
  object ds_pack: TDataSource
    DataSet = q_pack
    Left = 349
    Top = 83
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
    Left = 306
    Top = 82
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
    Left = 401
    Top = 82
  end
  object ds_pack_leido: TDataSource
    DataSet = q_pack_leido
    Left = 469
    Top = 84
  end
  object pFIBDataSet1: TpFIBDataSet
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
    Left = 161
    Top = 86
  end
  object DataSource1: TDataSource
    DataSet = pFIBDataSet1
    Left = 241
    Top = 87
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
    Left = 304
    Top = 135
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
    Left = 366
    Top = 138
  end
  object q_fib2: TpFIBDataSet
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 450
    Top = 16
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
    Left = 39
    Top = 138
  end
  object qry_sql2: TADOQuery
    Connection = con2
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      '')
    Left = 147
    Top = 141
  end
  object con2: TADOConnection
    CommandTimeout = 120
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=xzj2004MN4;Persist Security Info=Tr' +
      'ue;User ID=sa;Initial Catalog=loginser;Data Source=NUT;Use Proce' +
      'dure for Prepare=1;Auto Translate=True;Packet Size=4096;Workstat' +
      'ion ID=INF004;Use Encryption for Data=False;Tag with column coll' +
      'ation when possible=False'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 96
    Top = 146
  end
  object q1: TADOQuery
    Connection = con1
    CursorType = ctStatic
    LockType = ltReadOnly
    Parameters = <>
    Left = 77
    Top = 354
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
    Left = 435
    Top = 141
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
    Left = 495
    Top = 139
  end
  object qDHL: TpFIBDataSet
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 539
    Top = 135
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
    Left = 542
    Top = 182
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
    Left = 474
    Top = 188
  end
  object ds_hoja_pick: TDataSource
    DataSet = q_hoja_pick
    Left = 357
    Top = 195
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
    Top = 351
  end
  object q_fib: TpFIBDataSet
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
    Left = 208
    Top = 199
  end
  object qu_1: TpFIBQuery
    Transaction = t_write
    Database = db
    Left = 96
    Top = 200
  end
  object q_1: TpFIBQuery
    Transaction = t_write
    Database = db
    Left = 144
    Top = 208
  end
  object q_reparto: TpFIBDataSet
    SelectSQL.Strings = (
      'select l.codalbaran,b.id_caja, b.tipo_caja, l.cantidad'
      'from a_packlin l'
      
        'inner join a_packlin_bulto b on (l.id_packlin_bulto=b.id_packlin' +
        '_bulto)'
      'where l.id_packcab=:id_packcab and l.id_agrupa=:id_agrupa and'
      'l.nivel_agr=:nivel_agr and l.id_articulo=:id_articulo')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 41
    Top = 262
  end
  object ds_reparto: TDataSource
    DataSet = q_reparto
    Left = 105
    Top = 263
  end
  object qLineaPackOld: TpFIBDataSet
    SelectSQL.Strings = (
      '')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 466
    Top = 258
  end
  object qTempGestUpd: TpFIBQuery
    Transaction = t_write_gestoras
    Database = db_gestoras
    Left = 472
    Top = 328
  end
  object q_aux: TpFIBDataSet
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
    Left = 280
    Top = 231
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
    Left = 292
    Top = 17
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
    Left = 216
    Top = 303
  end
  object q_dame_datos_etiquetas: TpFIBDataSet
    SelectSQL.Strings = (
      'select * from lgs_dame_datos_etiquetas(:id_albaran)')
    Transaction = t_read_gestoras
    Database = db_gestoras
    UpdateTransaction = t_write_gestoras
    Left = 280
    Top = 409
    object fbsmlntfld_dame_datos_etiquetasSEDE: TFIBSmallIntField
      FieldName = 'SEDE'
    end
    object lgs_dame_datos_etiquetasFECHA_ALBARAN: TFIBDateTimeField
      FieldName = 'FECHA_ALBARAN'
      DisplayFormat = 'dd.mm.yyyy HH:mm'
    end
    object fbsmlntfld_dame_datos_etiquetasTIPO_ALBARAN: TFIBSmallIntField
      FieldName = 'TIPO_ALBARAN'
    end
    object fbsmlntfld_dame_datos_etiquetasESTADO: TFIBSmallIntField
      FieldName = 'ESTADO'
    end
    object fbsmlntfld_dame_datos_etiquetasAGENCIA: TFIBSmallIntField
      FieldName = 'AGENCIA'
    end
    object q_dame_datos_etiquetasEXPEDICION_AGE: TFIBStringField
      FieldName = 'EXPEDICION_AGE'
      Size = 60
      EmptyStrToNull = True
    end
    object fbsmlntfld_dame_datos_etiquetasORIGEN_WEB: TFIBSmallIntField
      FieldName = 'ORIGEN_WEB'
    end
    object fbsmlntfld_dame_datos_etiquetasEMPRESA: TFIBSmallIntField
      FieldName = 'EMPRESA'
    end
    object lgs_dame_datos_etiquetasCLIENTE: TFIBIntegerField
      FieldName = 'CLIENTE'
    end
    object lgs_dame_datos_etiquetasID_CLIENTE: TFIBIntegerField
      FieldName = 'ID_CLIENTE'
    end
    object q_dame_datos_etiquetasALBARAN_CLIENTE: TFIBStringField
      FieldName = 'ALBARAN_CLIENTE'
      Size = 60
      EmptyStrToNull = True
    end
    object fbsmlntfld_dame_datos_etiquetasTIPO_SERVICIO: TFIBSmallIntField
      FieldName = 'TIPO_SERVICIO'
    end
    object fbsmlntfld_dame_datos_etiquetasHORARIO: TFIBSmallIntField
      FieldName = 'HORARIO'
    end
    object q_dame_datos_etiquetasARCHIVO_RESGUARDO: TFIBStringField
      FieldName = 'ARCHIVO_RESGUARDO'
      Size = 250
      EmptyStrToNull = True
    end
    object lgs_dame_datos_etiquetasPAQUETES: TFIBFloatField
      FieldName = 'PAQUETES'
    end
    object lgs_dame_datos_etiquetasBULTOS: TFIBIntegerField
      FieldName = 'BULTOS'
    end
    object lgs_dame_datos_etiquetasPESO: TFIBFloatField
      FieldName = 'PESO'
    end
    object lgs_dame_datos_etiquetasKGS_VOL: TFIBFloatField
      FieldName = 'KGS_VOL'
    end
    object lgs_dame_datos_etiquetasZONA: TFIBIntegerField
      FieldName = 'ZONA'
    end
    object fbsmlntfld_dame_datos_etiquetasREPARTIDOR: TFIBSmallIntField
      FieldName = 'REPARTIDOR'
    end
    object fbsmlntfld_dame_datos_etiquetasPORTES_DEBIDOS: TFIBSmallIntField
      FieldName = 'PORTES_DEBIDOS'
    end
    object lgs_dame_datos_etiquetasIMPORTE_PORTES: TFIBFloatField
      FieldName = 'IMPORTE_PORTES'
      LookupDataSet = busqueda
    end
    object fbsmlntfld_dame_datos_etiquetasREEMBOLSO: TFIBSmallIntField
      FieldName = 'REEMBOLSO'
    end
    object lgs_dame_datos_etiquetasIMPORTE_REEMBOLSO: TFIBFloatField
      FieldName = 'IMPORTE_REEMBOLSO'
    end
    object fbsmlntfld_dame_datos_etiquetasASEGURADO: TFIBSmallIntField
      FieldName = 'ASEGURADO'
    end
    object lgs_dame_datos_etiquetasIMPORTE_ASEGURADO: TFIBFloatField
      FieldName = 'IMPORTE_ASEGURADO'
    end
    object fbsmlntfld_dame_datos_etiquetasRETORNO: TFIBSmallIntField
      FieldName = 'RETORNO'
    end
    object q_dame_datos_etiquetasOBSERVACIONES: TFIBMemoField
      FieldName = 'OBSERVACIONES'
      BlobType = ftMemo
      Size = 8
    end
    object q_dame_datos_etiquetasNOTAS_INTERNAS: TFIBMemoField
      FieldName = 'NOTAS_INTERNAS'
      BlobType = ftMemo
      Size = 8
    end
    object q_dame_datos_etiquetasORIG_NOMBRE: TFIBStringField
      FieldName = 'ORIG_NOMBRE'
      Size = 60
      EmptyStrToNull = True
    end
    object q_dame_datos_etiquetasORIG_CALLE: TFIBStringField
      FieldName = 'ORIG_CALLE'
      Size = 150
      EmptyStrToNull = True
    end
    object lgs_dame_datos_etiquetasORIG_ID_LOCAL: TFIBIntegerField
      FieldName = 'ORIG_ID_LOCAL'
    end
    object q_dame_datos_etiquetasORIG_COD_POSTAL: TFIBStringField
      FieldName = 'ORIG_COD_POSTAL'
      Size = 10
      EmptyStrToNull = True
    end
    object q_dame_datos_etiquetasORIG_LOCALIDAD: TFIBStringField
      FieldName = 'ORIG_LOCALIDAD'
      Size = 60
      EmptyStrToNull = True
    end
    object q_dame_datos_etiquetasORIG_PROVINCIA: TFIBStringField
      FieldName = 'ORIG_PROVINCIA'
      Size = 60
      EmptyStrToNull = True
    end
    object q_dame_datos_etiquetasORIG_PAIS: TFIBStringField
      FieldName = 'ORIG_PAIS'
      Size = 3
      EmptyStrToNull = True
    end
    object q_dame_datos_etiquetasORIG_TELEFONO: TFIBStringField
      FieldName = 'ORIG_TELEFONO'
      Size = 15
      EmptyStrToNull = True
    end
    object q_dame_datos_etiquetasORIG_TELEFONO2: TFIBStringField
      FieldName = 'ORIG_TELEFONO2'
      Size = 15
      EmptyStrToNull = True
    end
    object q_dame_datos_etiquetasORIG_CONTACTO: TFIBStringField
      FieldName = 'ORIG_CONTACTO'
      Size = 60
      EmptyStrToNull = True
    end
    object q_dame_datos_etiquetasORIG_NOTAS: TFIBMemoField
      FieldName = 'ORIG_NOTAS'
      BlobType = ftMemo
      Size = 8
    end
    object q_dame_datos_etiquetasORIG_EMAIL: TFIBStringField
      FieldName = 'ORIG_EMAIL'
      Size = 100
      EmptyStrToNull = True
    end
    object fbsmlntfld_dame_datos_etiquetasVEHICULO: TFIBSmallIntField
      FieldName = 'VEHICULO'
    end
    object fbsmlntfld_dame_datos_etiquetasDNI_NOMBRE: TFIBSmallIntField
      FieldName = 'DNI_NOMBRE'
    end
    object fbsmlntfld_dame_datos_etiquetasRCS: TFIBSmallIntField
      FieldName = 'RCS'
    end
    object fbsmlntfld_dame_datos_etiquetasDIGITALIZADO: TFIBSmallIntField
      FieldName = 'DIGITALIZADO'
      LookupDataSet = busqueda
    end
    object q_dame_datos_etiquetasCAMPO_STR1: TFIBStringField
      FieldName = 'CAMPO_STR1'
      Size = 100
      EmptyStrToNull = True
    end
    object q_dame_datos_etiquetasCAMPO_STR2: TFIBStringField
      FieldName = 'CAMPO_STR2'
      Size = 100
      EmptyStrToNull = True
    end
    object q_dame_datos_etiquetasCAMPO_STR3: TFIBStringField
      FieldName = 'CAMPO_STR3'
      Size = 100
      EmptyStrToNull = True
    end
    object lgs_dame_datos_etiquetasCAMPO_CANT1: TFIBFloatField
      FieldName = 'CAMPO_CANT1'
    end
    object lgs_dame_datos_etiquetasCAMPO_CANT2: TFIBFloatField
      FieldName = 'CAMPO_CANT2'
    end
    object lgs_dame_datos_etiquetasCAMPO_CANT3: TFIBFloatField
      FieldName = 'CAMPO_CANT3'
    end
    object lgs_dame_datos_etiquetasENTRADA: TFIBIntegerField
      FieldName = 'ENTRADA'
    end
    object fbsmlntfld_dame_datos_etiquetasVALIJA: TFIBSmallIntField
      FieldName = 'VALIJA'
    end
    object fbsmlntfld_dame_datos_etiquetasRECOGIDA_PROPIA: TFIBSmallIntField
      FieldName = 'RECOGIDA_PROPIA'
    end
    object fbsmlntfld_dame_datos_etiquetasRECOGIDA_NACIONAL: TFIBSmallIntField
      FieldName = 'RECOGIDA_NACIONAL'
    end
    object fbsmlntfld_dame_datos_etiquetasAUTOMATICO: TFIBSmallIntField
      FieldName = 'AUTOMATICO'
    end
    object fbsmlntfld_dame_datos_etiquetasSEGUIMIENTO: TFIBSmallIntField
      FieldName = 'SEGUIMIENTO'
    end
    object q_dame_datos_etiquetasALBARAN_AGENCIA: TFIBStringField
      FieldName = 'ALBARAN_AGENCIA'
      Size = 60
      EmptyStrToNull = True
    end
    object fbsmlntfld_dame_datos_etiquetasFACTURABLE: TFIBSmallIntField
      FieldName = 'FACTURABLE'
    end
    object fbsmlntfld_dame_datos_etiquetasCAMPO_CK1: TFIBSmallIntField
      FieldName = 'CAMPO_CK1'
    end
    object fbsmlntfld_dame_datos_etiquetasCAMPO_CK2: TFIBSmallIntField
      FieldName = 'CAMPO_CK2'
    end
    object fbsmlntfld_dame_datos_etiquetasCAMPO_CK3: TFIBSmallIntField
      FieldName = 'CAMPO_CK3'
    end
    object lgs_dame_datos_etiquetasFECHA_SERVICIO: TFIBDateTimeField
      FieldName = 'FECHA_SERVICIO'
      DisplayFormat = 'dd.mm.yyyy HH:mm'
    end
    object lgs_dame_datos_etiquetasORIG_H_DESDE: TFIBDateTimeField
      FieldName = 'ORIG_H_DESDE'
      DisplayFormat = 'dd.mm.yyyy HH:mm'
    end
    object lgs_dame_datos_etiquetasORIG_H_HASTA: TFIBDateTimeField
      FieldName = 'ORIG_H_HASTA'
      DisplayFormat = 'dd.mm.yyyy HH:mm'
    end
    object fbsmlntfld_dame_datos_etiquetasAYUDANTE: TFIBSmallIntField
      FieldName = 'AYUDANTE'
    end
    object fbsmlntfld_dame_datos_etiquetasDESEMBOLSO: TFIBSmallIntField
      FieldName = 'DESEMBOLSO'
    end
    object lgs_dame_datos_etiquetasIMPORTE_DESEMBOLSO: TFIBFloatField
      FieldName = 'IMPORTE_DESEMBOLSO'
    end
    object fbsmlntfld_dame_datos_etiquetasSEGUNDA_ENTREGA: TFIBSmallIntField
      FieldName = 'SEGUNDA_ENTREGA'
    end
    object fbsmlntfld_dame_datos_etiquetasDUA_IMPORT: TFIBSmallIntField
      FieldName = 'DUA_IMPORT'
    end
    object fbsmlntfld_dame_datos_etiquetasDUA_EXPORT: TFIBSmallIntField
      FieldName = 'DUA_EXPORT'
    end
    object fbsmlntfld_dame_datos_etiquetasMINUTOS_ESPERA: TFIBSmallIntField
      FieldName = 'MINUTOS_ESPERA'
    end
    object q_dame_datos_etiquetasORIG_CODIGO: TFIBStringField
      FieldName = 'ORIG_CODIGO'
      EmptyStrToNull = True
    end
    object lgs_dame_datos_etiquetasORIG_H_DESDE2: TFIBDateTimeField
      FieldName = 'ORIG_H_DESDE2'
      DisplayFormat = 'dd.mm.yyyy HH:mm'
    end
    object lgs_dame_datos_etiquetasORIG_H_HASTA2: TFIBDateTimeField
      FieldName = 'ORIG_H_HASTA2'
      DisplayFormat = 'dd.mm.yyyy HH:mm'
    end
    object lgs_dame_datos_etiquetasPESO_EXPEDICION: TFIBFloatField
      FieldName = 'PESO_EXPEDICION'
    end
    object lgs_dame_datos_etiquetasBULTOS_TOTALES: TFIBIntegerField
      FieldName = 'BULTOS_TOTALES'
    end
    object q_dame_datos_etiquetasORIG_COD_PROVINCIA: TFIBStringField
      FieldName = 'ORIG_COD_PROVINCIA'
      Size = 2
      EmptyStrToNull = True
    end
    object q_dame_datos_etiquetasORIG_NIF: TFIBStringField
      FieldName = 'ORIG_NIF'
      EmptyStrToNull = True
    end
    object q_dame_datos_etiquetasORIG_DEPARTAMENTO: TFIBStringField
      FieldName = 'ORIG_DEPARTAMENTO'
      Size = 60
      EmptyStrToNull = True
    end
    object fbsmlntfld_dame_datos_etiquetasDAC: TFIBSmallIntField
      FieldName = 'DAC'
    end
    object fbsmlntfld_dame_datos_etiquetasPOD: TFIBSmallIntField
      FieldName = 'POD'
    end
    object q_dame_datos_etiquetasREF_CLIENTE: TFIBStringField
      FieldName = 'REF_CLIENTE'
      Size = 100
      EmptyStrToNull = True
    end
    object q_dame_datos_etiquetasREF_CLIENTE_2: TFIBStringField
      FieldName = 'REF_CLIENTE_2'
      Size = 100
      EmptyStrToNull = True
    end
    object q_dame_datos_etiquetasCONTENIDO: TFIBStringField
      FieldName = 'CONTENIDO'
      Size = 255
      EmptyStrToNull = True
    end
    object lgs_dame_datos_etiquetasFECHA_PREVISTA: TFIBDateTimeField
      FieldName = 'FECHA_PREVISTA'
      DisplayFormat = 'dd.mm.yyyy HH:mm'
    end
    object lgs_dame_datos_etiquetasSOLICITUD: TFIBIntegerField
      FieldName = 'SOLICITUD'
    end
    object fbsmlntfld_dame_datos_etiquetasFACT_DEVOLUCION: TFIBSmallIntField
      FieldName = 'FACT_DEVOLUCION'
    end
    object fbsmlntfld_dame_datos_etiquetasFACT_RCS: TFIBSmallIntField
      FieldName = 'FACT_RCS'
    end
    object fbsmlntfld_dame_datos_etiquetasFACT_RETORNO: TFIBSmallIntField
      FieldName = 'FACT_RETORNO'
    end
    object fbsmlntfld_dame_datos_etiquetasSEDE_DESTINO: TFIBSmallIntField
      FieldName = 'SEDE_DESTINO'
    end
    object fbsmlntfld_dame_datos_etiquetasSEDE_ORIGEN: TFIBSmallIntField
      FieldName = 'SEDE_ORIGEN'
    end
    object fbsmlntfld_dame_datos_etiquetasTIENE_INCIDENCIA: TFIBSmallIntField
      FieldName = 'TIENE_INCIDENCIA'
    end
    object q_dame_datos_etiquetasTITULO_HORARIO: TFIBStringField
      FieldName = 'TITULO_HORARIO'
      Size = 60
      EmptyStrToNull = True
    end
    object q_dame_datos_etiquetasCODIGO_CLIENTE_EXP: TFIBStringField
      FieldName = 'CODIGO_CLIENTE_EXP'
      Size = 40
      EmptyStrToNull = True
    end
    object lgs_dame_datos_etiquetasID_ALBARAN_DET: TFIBIntegerField
      FieldName = 'ID_ALBARAN_DET'
    end
    object fbsmlntfld_dame_datos_etiquetasLINEA: TFIBSmallIntField
      FieldName = 'LINEA'
    end
    object q_dame_datos_etiquetasDEST_NOMBRE: TFIBStringField
      FieldName = 'DEST_NOMBRE'
      Size = 60
      EmptyStrToNull = True
    end
    object q_dame_datos_etiquetasDEST_CALLE: TFIBStringField
      FieldName = 'DEST_CALLE'
      Size = 150
      EmptyStrToNull = True
    end
    object q_dame_datos_etiquetasDEST_CODPOSTAL: TFIBStringField
      FieldName = 'DEST_CODPOSTAL'
      Size = 10
      EmptyStrToNull = True
    end
    object q_dame_datos_etiquetasDEST_LOCALIDAD: TFIBStringField
      FieldName = 'DEST_LOCALIDAD'
      Size = 60
      EmptyStrToNull = True
    end
    object q_dame_datos_etiquetasDEST_PROVINCIA: TFIBStringField
      FieldName = 'DEST_PROVINCIA'
      Size = 60
      EmptyStrToNull = True
    end
    object q_dame_datos_etiquetasDEST_PAIS: TFIBStringField
      FieldName = 'DEST_PAIS'
      Size = 3
      EmptyStrToNull = True
    end
    object q_dame_datos_etiquetasDEST_TELEFONO01: TFIBStringField
      FieldName = 'DEST_TELEFONO01'
      Size = 15
      EmptyStrToNull = True
    end
    object q_dame_datos_etiquetasDEST_TELEFONO02: TFIBStringField
      FieldName = 'DEST_TELEFONO02'
      Size = 15
      EmptyStrToNull = True
    end
    object q_dame_datos_etiquetasDEST_EMAIL: TFIBStringField
      FieldName = 'DEST_EMAIL'
      Size = 100
      EmptyStrToNull = True
    end
    object q_dame_datos_etiquetasDEST_CONTACTO: TFIBStringField
      FieldName = 'DEST_CONTACTO'
      Size = 60
      EmptyStrToNull = True
    end
    object q_dame_datos_etiquetasDEST_OBSERVACIONES: TFIBMemoField
      FieldName = 'DEST_OBSERVACIONES'
      BlobType = ftMemo
      Size = 8
    end
    object lgs_dame_datos_etiquetasDEST_ID_LOCAL: TFIBIntegerField
      FieldName = 'DEST_ID_LOCAL'
    end
    object fbsmlntfld_dame_datos_etiquetasDEST_PRINCIPAL: TFIBSmallIntField
      FieldName = 'DEST_PRINCIPAL'
    end
    object lgs_dame_datos_etiquetasDEST_HDESDE: TFIBDateTimeField
      FieldName = 'DEST_HDESDE'
      DisplayFormat = 'dd.mm.yyyy HH:mm'
    end
    object lgs_dame_datos_etiquetasDEST_HHASTA: TFIBDateTimeField
      FieldName = 'DEST_HHASTA'
      DisplayFormat = 'dd.mm.yyyy HH:mm'
    end
    object q_dame_datos_etiquetasDEST_CODIGO: TFIBStringField
      FieldName = 'DEST_CODIGO'
      EmptyStrToNull = True
    end
    object q_dame_datos_etiquetasDEST_CODPROVINCIA: TFIBStringField
      FieldName = 'DEST_CODPROVINCIA'
      Size = 2
      EmptyStrToNull = True
    end
    object q_dame_datos_etiquetasDEST_NIF: TFIBStringField
      FieldName = 'DEST_NIF'
      EmptyStrToNull = True
    end
    object q_dame_datos_etiquetasDEST_DEPARTAMENTO: TFIBStringField
      FieldName = 'DEST_DEPARTAMENTO'
      Size = 60
      EmptyStrToNull = True
    end
    object fbsmlntfld_dame_datos_etiquetasDEST_RECIBIR: TFIBSmallIntField
      FieldName = 'DEST_RECIBIR'
    end
    object fbsmlntfld_dame_datos_etiquetasBULTO: TFIBSmallIntField
      FieldName = 'BULTO'
    end
    object lgs_dame_datos_etiquetasID_BULTO: TFIBIntegerField
      FieldName = 'ID_BULTO'
    end
    object lgs_dame_datos_etiquetasPESO_BULTO: TFIBFloatField
      FieldName = 'PESO_BULTO'
    end
    object lgs_dame_datos_etiquetasX: TFIBFloatField
      FieldName = 'X'
    end
    object lgs_dame_datos_etiquetasY: TFIBFloatField
      FieldName = 'Y'
    end
    object lgs_dame_datos_etiquetasZ: TFIBFloatField
      FieldName = 'Z'
    end
    object q_dame_datos_etiquetasREFERENCIA: TFIBStringField
      FieldName = 'REFERENCIA'
      EmptyStrToNull = True
    end
    object q_dame_datos_etiquetasCOD_BARRAS: TFIBStringField
      FieldName = 'COD_BARRAS'
      Size = 255
      EmptyStrToNull = True
    end
    object lgs_dame_datos_etiquetasID_ALB: TFIBIntegerField
      FieldName = 'ID_ALB'
    end
    object q_dame_datos_etiquetasTITULO_ZONA: TFIBStringField
      FieldName = 'TITULO_ZONA'
      Size = 60
      EmptyStrToNull = True
    end
    object q_dame_datos_etiquetasTIT_AGENCIA: TFIBStringField
      FieldName = 'TIT_AGENCIA'
      Size = 60
      EmptyStrToNull = True
    end
    object q_dame_datos_etiquetasTIT_SEDE: TFIBStringField
      FieldName = 'TIT_SEDE'
      Size = 60
      EmptyStrToNull = True
    end
    object strngfld_dame_datos_etiquetasTIT_SEDE_DESTINO: TStringField
      FieldName = 'TIT_SEDE_DESTINO'
      Size = 60
    end
    object strngfld_dame_datos_etiquetasTIT_SEDE_ORIGEN: TStringField
      FieldName = 'TIT_SEDE_ORIGEN'
      Size = 60
    end
    object cds_dame_datos_etiquetasGRUPO_CL: TIntegerField
      FieldName = 'GRUPO_CL'
    end
  end
  object ds_lgs_dame_datos_etiquetas: TDataSource
    DataSet = q_dame_datos_etiquetas
    Left = 448
    Top = 408
  end
  object q_etiq_impresa: TpFIBDataSet
    SelectSQL.Strings = (
      'select *'
      'from a_packlin_bulto'
      'where codalbaran=:codalbaran and impreso='#39'S'#39)
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 41
    Top = 198
  end
  object spGetEmail: TpFIBStoredProc
    Transaction = t_read
    Database = db
    SQL.Strings = (
      'EXECUTE PROCEDURE GET_EMAIL_PEDIDO (?ID_PEDIDO)')
    StoredProcName = 'GET_EMAIL_PEDIDO'
    Left = 136
    Top = 344
  end
  object spGetEmailAlbaran: TpFIBStoredProc
    Transaction = t_read_gestoras
    Database = db_gestoras
    SQL.Strings = (
      'EXECUTE PROCEDURE LGS_GET_EMAIL_ALBARAN (?ID_ALBARAN)')
    StoredProcName = 'LGS_GET_EMAIL_ALBARAN'
    Left = 128
    Top = 400
  end
  object q_pick_lotes: TpFIBDataSet
    SelectSQL.Strings = (
      'select l.cantidad, l.id_lote, l.id_pickcab, l.linea'
      'from a_picklin l'
      
        'where l.codalbaran=:albaran and l.id_articulo=:articulo and l.si' +
        'tuacion in ('#39'A'#39')')
    Transaction = t_read
    Database = db
    UpdateTransaction = t_write
    Left = 388
    Top = 506
    object lgs_picks_lotesCANTIDAD: TFIBIntegerField
      FieldName = 'CANTIDAD'
    end
    object lgs_picks_lotesID_LOTE: TFIBIntegerField
      FieldName = 'ID_LOTE'
    end
    object lgs_picks_lotesID_PICKCAB: TFIBIntegerField
      FieldName = 'ID_PICKCAB'
    end
    object lgs_picks_lotesLINEA: TFIBIntegerField
      FieldName = 'LINEA'
    end
  end
  object q_usuario: TpFIBDataSet
    Left = 488
    Top = 504
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
    Left = 356
    Top = 322
    object lgs_picks_lotesCANTIDAD1: TFIBIntegerField
      FieldName = 'CANTIDAD'
    end
    object lgs_picks_lotesID_LOTE1: TFIBIntegerField
      FieldName = 'ID_LOTE'
    end
    object lgs_picks_lotesID_PICKCAB1: TFIBIntegerField
      FieldName = 'ID_PICKCAB'
    end
    object lgs_picks_lotesLINEA1: TFIBIntegerField
      FieldName = 'LINEA'
    end
  end
  object q_ped_extra: TpFIBDataSet
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
    Left = 280
    Top = 311
  end
end
