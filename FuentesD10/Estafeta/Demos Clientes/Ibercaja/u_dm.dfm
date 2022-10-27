object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 512
  Width = 437
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
    AllowedUpdateKinds = []
    Left = 189
    Top = 19
  end
  object dsbusqueda: TDataSource
    DataSet = busqueda
    Left = 248
    Top = 18
  end
  object q_resumen: TpFIBDataSet
    SelectSQL.Strings = (
      'select l.fecha,l.hora,l.bultos,l.lleno,'
      
        '    right('#39'0000'#39'||d_org.cod_entidad,4)||'#39'-'#39'||right('#39'0000'#39'||d_org' +
        '.cod_delegacion,4) as cod_delegacion_org,'
      '    d_org.nombre as nombre_org,d_org.direccion as direccion_org,'
      
        '    d_org.cp as cp_org,d_org.poblacion as poblacion_org,d_org.pr' +
        'ovincia as provincia_org,'
      
        '    right('#39'0000'#39'||d_dst.cod_entidad,4)||'#39'-'#39'||right('#39'0000'#39'||d_dst' +
        '.cod_delegacion,4) as cod_delegacion_dst,'
      '    d_dst.nombre as nombre_dst,d_dst.direccion as direccion_dst,'
      
        '    d_dst.cp as cp_dst,d_dst.poblacion as poblacion_dst,d_dst.pr' +
        'ovincia as provincia_dst,l.traza, l.cod_caixa,'
      
        '    right('#39'0000'#39'||d_vlj_dst.cod_entidad,4)||'#39'-'#39'||right('#39'0000'#39'||d' +
        '_vlj_dst.cod_delegacion,4) as cod_vlj_dst,d_vlj_dst.nombre as no' +
        'm_vlj_dst,'
      
        '   d_vlj_dst.direccion as dir_vlj_dst,d_vlj_dst.cp as cp_vlj_dst' +
        ',d_vlj_dst.poblacion as pobl_vlj_dst,d_vlj_dst.provincia as prov' +
        '_vlj_dst, d_org.pedir_traza as pedir_traza,l.id_lectura_estafeta'
      'from e_lecturas_estafeta l'
      
        'inner join e_valijas_tarjetas vt on (l.id_valija_tarjeta=vt.id_v' +
        'alija_tarjeta)'
      'inner join e_valijas v on (vt.id_valija=v.id_valija)'
      
        'inner join e_delegaciones d_org on (v.id_delegacion=d_org.id_del' +
        'egacion)'
      
        'inner join e_delegaciones d_dst on (l.id_delegacion_destino=d_ds' +
        't.id_delegacion)'
      
        'left outer join e_valijas vd on (l.id_valija_destino=vd.id_valij' +
        'a)'
      
        'left outer join e_delegaciones d_vlj_dst on (d_vlj_dst.id_delega' +
        'cion=vd.id_delegacion)'
      
        'where l.fecha between :f_1 and :f_2 and l.digitalizacion=0 and d' +
        '_org.id_cliente=:cliente and d_dst.id_cliente=:cliente'
      ''
      ''
      ''
      ''
      ''
      'order by l.fecha desc,l.hora desc')
    Left = 32
    Top = 150
    oFetchAll = True
    object q_resumenFECHA: TFIBDateField
      FieldName = 'FECHA'
    end
    object q_resumenHORA: TFIBTimeField
      DisplayWidth = 5
      FieldName = 'HORA'
    end
    object lgs_resumenBULTOS: TFIBIntegerField
      DisplayWidth = 5
      FieldName = 'BULTOS'
    end
    object lgs_resumenLLENO: TFIBSmallIntField
      DisplayWidth = 5
      FieldName = 'LLENO'
    end
    object q_resumenCOD_DELEGACION_ORG: TFIBStringField
      DisplayLabel = 'COD_ORG'
      DisplayWidth = 10
      FieldName = 'COD_DELEGACION_ORG'
      Size = 31
      EmptyStrToNull = True
    end
    object q_resumenNOMBRE_ORG: TFIBStringField
      DisplayWidth = 50
      FieldName = 'NOMBRE_ORG'
      Size = 80
      EmptyStrToNull = True
    end
    object q_resumenDIRECCION_ORG: TFIBStringField
      DisplayWidth = 40
      FieldName = 'DIRECCION_ORG'
      Size = 120
      EmptyStrToNull = True
    end
    object q_resumenCP_ORG: TFIBStringField
      FieldName = 'CP_ORG'
      Size = 5
      EmptyStrToNull = True
    end
    object q_resumenPOBLACION_ORG: TFIBStringField
      DisplayWidth = 20
      FieldName = 'POBLACION_ORG'
      Size = 60
      EmptyStrToNull = True
    end
    object q_resumenPROVINCIA_ORG: TFIBStringField
      DisplayWidth = 15
      FieldName = 'PROVINCIA_ORG'
      Size = 60
      EmptyStrToNull = True
    end
    object q_resumenCOD_DELEGACION_DST: TFIBStringField
      DisplayLabel = 'COD_DST'
      DisplayWidth = 10
      FieldName = 'COD_DELEGACION_DST'
      Size = 31
      EmptyStrToNull = True
    end
    object q_resumenNOMBRE_DST: TFIBStringField
      DisplayWidth = 50
      FieldName = 'NOMBRE_DST'
      Size = 80
      EmptyStrToNull = True
    end
    object q_resumenDIRECCION_DST: TFIBStringField
      DisplayWidth = 40
      FieldName = 'DIRECCION_DST'
      Size = 120
      EmptyStrToNull = True
    end
    object q_resumenCP_DST: TFIBStringField
      FieldName = 'CP_DST'
      Size = 5
      EmptyStrToNull = True
    end
    object q_resumenPOBLACION_DST: TFIBStringField
      DisplayWidth = 20
      FieldName = 'POBLACION_DST'
      Size = 60
      EmptyStrToNull = True
    end
    object q_resumenPROVINCIA_DST: TFIBStringField
      DisplayWidth = 15
      FieldName = 'PROVINCIA_DST'
      Size = 60
      EmptyStrToNull = True
    end
    object q_resumenTRAZA: TFIBStringField
      DisplayWidth = 30
      FieldName = 'TRAZA'
      Size = 100
      EmptyStrToNull = True
    end
    object q_resumenCOD_CAIXA: TFIBStringField
      DisplayWidth = 5
      FieldName = 'COD_CAIXA'
      Size = 15
      EmptyStrToNull = True
    end
    object strngfld_resumenCOD_VLJ_DST: TStringField
      DisplayWidth = 5
      FieldName = 'COD_VLJ_DST'
      Size = 31
    end
    object q_resumenNOM_VLJ_DST: TFIBStringField
      DisplayWidth = 50
      FieldName = 'NOM_VLJ_DST'
      Size = 80
      EmptyStrToNull = True
    end
    object q_resumenDIR_VLJ_DST: TFIBStringField
      DisplayWidth = 40
      FieldName = 'DIR_VLJ_DST'
      Size = 120
      EmptyStrToNull = True
    end
    object q_resumenCP_VLJ_DST: TFIBStringField
      FieldName = 'CP_VLJ_DST'
      Size = 5
      EmptyStrToNull = True
    end
    object q_resumenPOBL_VLJ_DST: TFIBStringField
      DisplayWidth = 20
      FieldName = 'POBL_VLJ_DST'
      Size = 60
      EmptyStrToNull = True
    end
    object q_resumenPROV_VLJ_DST: TFIBStringField
      DisplayWidth = 15
      FieldName = 'PROV_VLJ_DST'
      Size = 60
      EmptyStrToNull = True
    end
    object lgs_resumenPEDIR_TRAZA: TFIBSmallIntField
      DisplayWidth = 5
      FieldName = 'PEDIR_TRAZA'
    end
    object lgs_resumenID_LECTURA_ESTAFETA: TFIBIntegerField
      DisplayWidth = 5
      FieldName = 'ID_LECTURA_ESTAFETA'
    end
  end
  object ds_resumen: TDataSource
    DataSet = q_resumen
    Left = 94
    Top = 149
  end
  object q_incidencias: TpFIBDataSet
    SelectSQL.Strings = (
      
        'select l.id_incidencias_estafeta,l.fecha,l.hora,i.nombre as inci' +
        'd_nombre,l.observaciones,'
      
        '    right('#39'0000'#39'||d.cod_entidad,4)||'#39'-'#39'||right('#39'0000'#39'||d.cod_del' +
        'egacion,4) as cod_delegacion,d.nombre,d.direccion,d.cp,d.poblaci' +
        'on,d.provincia,d.id_delegacion,i.id_tipo_incidencia_est,d.cod_en' +
        'tidad'
      'from e_incidencias_estafeta l'
      
        'inner join e_valijas_tarjetas vt on (l.id_valija_tarjeta=vt.id_v' +
        'alija_tarjeta)'
      'inner join e_valijas v on (vt.id_valija=v.id_valija)'
      'inner join e_delegaciones d on (v.id_delegacion=d.id_delegacion)'
      
        'inner join e_tipos_incidencias_est i on (l.id_tipo_incidencia_es' +
        't=i.id_tipo_incidencia_est)'
      'where l.fecha between :f_1 and :f_2 and d.id_cliente=:cliente'
      ''
      'order by l.fecha desc,l.hora desc')
    Left = 38
    Top = 206
    oFetchAll = True
    object fbntgrfld_incidenciasID_INCIDENCIAS_ESTAFETA: TFIBIntegerField
      FieldName = 'ID_INCIDENCIAS_ESTAFETA'
    end
    object fbdtfld_incidenciasFECHA: TFIBDateField
      FieldName = 'FECHA'
    end
    object fbtmfld_incidenciasHORA: TFIBTimeField
      FieldName = 'HORA'
    end
    object fbstrngfld_incidenciasINCID_NOMBRE: TFIBStringField
      FieldName = 'INCID_NOMBRE'
      Size = 125
      EmptyStrToNull = True
    end
    object fbstrngfld_incidenciasOBSERVACIONES: TFIBStringField
      FieldName = 'OBSERVACIONES'
      Size = 255
      EmptyStrToNull = True
    end
    object fbstrngfld_incidenciasCOD_DELEGACION: TFIBStringField
      FieldName = 'COD_DELEGACION'
      Size = 31
      EmptyStrToNull = True
    end
    object fbstrngfld_incidenciasNOMBRE: TFIBStringField
      FieldName = 'NOMBRE'
      Size = 80
      EmptyStrToNull = True
    end
    object fbstrngfld_incidenciasDIRECCION: TFIBStringField
      FieldName = 'DIRECCION'
      Size = 120
      EmptyStrToNull = True
    end
    object fbstrngfld_incidenciasCP: TFIBStringField
      FieldName = 'CP'
      Size = 5
      EmptyStrToNull = True
    end
    object fbstrngfld_incidenciasPOBLACION: TFIBStringField
      FieldName = 'POBLACION'
      Size = 60
      EmptyStrToNull = True
    end
    object fbstrngfld_incidenciasPROVINCIA: TFIBStringField
      FieldName = 'PROVINCIA'
      Size = 60
      EmptyStrToNull = True
    end
    object fbntgrfld_incidenciasID_DELEGACION: TFIBIntegerField
      FieldName = 'ID_DELEGACION'
    end
    object fbntgrfld_incidenciasID_TIPO_INCIDENCIA_EST: TFIBIntegerField
      FieldName = 'ID_TIPO_INCIDENCIA_EST'
    end
    object fbntgrfld_incidenciasCOD_ENTIDAD: TFIBIntegerField
      FieldName = 'COD_ENTIDAD'
    end
  end
  object ds_incidencias: TDataSource
    DataSet = q_incidencias
    Left = 99
    Top = 206
  end
  object qr_update: TpFIBQuery
    Left = 361
    Top = 65
  end
  object q_resumen_tot: TpFIBDataSet
    SelectSQL.Strings = (
      'select count(*) as total,sum(l.bultos) as bultos'
      'from e_lecturas_estafeta l'
      
        'inner join e_valijas_tarjetas vt on (l.id_valija_tarjeta=vt.id_v' +
        'alija_tarjeta)'
      'inner join e_valijas v on (vt.id_valija=v.id_valija)'
      
        'inner join e_delegaciones d_org on (v.id_delegacion=d_org.id_del' +
        'egacion)'
      
        'inner join e_delegaciones d_dst on (l.id_delegacion_destino=d_ds' +
        't.id_delegacion)'
      
        'left outer join e_valijas vd on (l.id_valija_destino=vd.id_valij' +
        'a)'
      
        'left outer join e_delegaciones d_vlj_dst on (d_vlj_dst.id_delega' +
        'cion=vd.id_delegacion)'
      
        'where l.fecha between :f_1 and :f_2 and l.digitalizacion=0 and d' +
        '_org.id_cliente=:cliente and d_dst.id_cliente=:cliente'
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      '')
    Left = 202
    Top = 155
    oFetchAll = True
    object fbntgrfld_resumen_totTOTAL: TFIBIntegerField
      FieldName = 'TOTAL'
    end
    object fbcdfld_resumen_totBULTOS: TFIBBCDField
      FieldName = 'BULTOS'
      Size = 0
    end
  end
  object q_incidencias_tot: TpFIBDataSet
    SelectSQL.Strings = (
      'select count(*) as total'
      'from e_incidencias_estafeta l'
      
        'inner join e_valijas_tarjetas vt on (l.id_valija_tarjeta=vt.id_v' +
        'alija_tarjeta)'
      'inner join e_valijas v on (vt.id_valija=v.id_valija)'
      'inner join e_delegaciones d on (v.id_delegacion=d.id_delegacion)'
      
        'inner join e_tipos_incidencias_est i on (l.id_tipo_incidencia_es' +
        't=i.id_tipo_incidencia_est)'
      'where l.fecha between :f_1 and :f_2 and d.id_cliente=:cliente'
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      '')
    Left = 206
    Top = 212
    oFetchAll = True
    object fbntgrfld_incidencias_totTOTAL: TFIBIntegerField
      FieldName = 'TOTAL'
    end
  end
  object q_1: TpFIBDataSet
    Left = 327
    Top = 126
  end
  object q_2: TpFIBDataSet
    Left = 377
    Top = 127
  end
  object q_incidencias_report: TpFIBDataSet
    SelectSQL.Strings = (
      
        'select l.id_incidencias_estafeta,l.fecha,l.hora,i.nombre as inci' +
        'd_nombre,l.observaciones,'
      
        '    d.id_cliente,d.cod_delegacion,d.nombre,d.direccion,d.cp,d.po' +
        'blacion,d.provincia,c.nombre as nom_cliente'
      'from v_incidencias_estafeta l'
      
        'inner join v_valijas_tarjetas vt on (l.id_valija_tarjeta=vt.id_v' +
        'alija_tarjeta)'
      'inner join v_valijas v on (vt.id_valija=v.id_valija)'
      'inner join g_delegaciones d on (v.id_delegacion=d.id_delegacion)'
      'inner join g_clientes c on (d.id_cliente=c.id_cliente)'
      
        'inner join v_tipos_incidencias_est i on (l.id_tipo_incidencia_es' +
        't=i.id_tipo_incidencia_est)'
      'where l.fecha=:fecha and d.id_cliente=:cliente '
      'order by l.hora desc')
    Left = 62
    Top = 405
    oFetchAll = True
    object fbntgrfld_incidencias_reportID_INCIDENCIAS_ESTAFETA: TFIBIntegerField
      FieldName = 'ID_INCIDENCIAS_ESTAFETA'
    end
    object fbdtfld_incidencias_reportFECHA: TFIBDateField
      FieldName = 'FECHA'
    end
    object fbtmfld_incidencias_reportHORA: TFIBTimeField
      FieldName = 'HORA'
      DisplayFormat = 'HH:nn:ss'
    end
    object fbstrngfld_incidencias_reportINCID_NOMBRE: TFIBStringField
      FieldName = 'INCID_NOMBRE'
      Size = 125
      EmptyStrToNull = True
    end
    object fbstrngfld_incidencias_reportOBSERVACIONES: TFIBStringField
      FieldName = 'OBSERVACIONES'
      Size = 255
      EmptyStrToNull = True
    end
    object fbntgrfld_incidencias_reportID_CLIENTE: TFIBIntegerField
      FieldName = 'ID_CLIENTE'
    end
    object fbntgrfld_incidencias_reportCOD_DELEGACION: TFIBIntegerField
      FieldName = 'COD_DELEGACION'
    end
    object fbstrngfld_incidencias_reportNOMBRE: TFIBStringField
      FieldName = 'NOMBRE'
      Size = 80
      EmptyStrToNull = True
    end
    object fbstrngfld_incidencias_reportDIRECCION: TFIBStringField
      FieldName = 'DIRECCION'
      Size = 80
      EmptyStrToNull = True
    end
    object fbstrngfld_incidencias_reportCP: TFIBStringField
      FieldName = 'CP'
      Size = 5
      EmptyStrToNull = True
    end
    object fbstrngfld_incidencias_reportPOBLACION: TFIBStringField
      FieldName = 'POBLACION'
      Size = 60
      EmptyStrToNull = True
    end
    object fbstrngfld_incidencias_reportPROVINCIA: TFIBStringField
      FieldName = 'PROVINCIA'
      Size = 30
      EmptyStrToNull = True
    end
    object fbstrngfld_incidencias_reportNOM_CLIENTE: TFIBStringField
      FieldName = 'NOM_CLIENTE'
      Size = 50
      EmptyStrToNull = True
    end
  end
  object q_resumen_report: TpFIBDataSet
    SelectSQL.Strings = (
      'select l.id_lectura_estafeta,l.fecha,l.hora,l.bultos,'
      
        '    right('#39'0000'#39'||d_org.cod_entidad,4)||'#39'-'#39'||right('#39'0000'#39'||d_org' +
        '.cod_delegacion,4) as cod_delegacion_org,'
      '    d_org.nombre as nombre_org,d_org.direccion as direccion_org,'
      
        '    d_org.cp as cp_org,d_org.poblacion as poblacion_org,d_org.pr' +
        'ovincia as provincia_org,'
      
        '    right('#39'0000'#39'||d_dst.cod_entidad,4)||'#39'-'#39'||right('#39'0000'#39'||d_dst' +
        '.cod_delegacion,4) as cod_delegacion_dst,'
      '    d_dst.nombre as nombre_dst,d_dst.direccion as direccion_dst,'
      
        '    d_dst.cp as cp_dst,d_dst.poblacion as poblacion_dst,d_dst.pr' +
        'ovincia as provincia_dst'
      'from e_lecturas_estafeta l'
      
        'inner join e_valijas_tarjetas vt on (l.id_valija_tarjeta=vt.id_v' +
        'alija_tarjeta)'
      'inner join e_valijas v on (vt.id_valija=v.id_valija)'
      
        'inner join e_delegaciones d_org on (v.id_delegacion=d_org.id_del' +
        'egacion)'
      
        'inner join e_delegaciones d_dst on (l.id_delegacion_destino=d_ds' +
        't.id_delegacion)'
      
        'where l.fecha=:fecha and l.digitalizacion=0 and d_org.id_cliente' +
        '=:cliente and d_dst.id_cliente=:cliente'
      'order by l.hora desc'
      '')
    Left = 62
    Top = 350
    oFetchAll = True
    object fbntgrfld_resumen_reportID_LECTURA_ESTAFETA: TFIBIntegerField
      FieldName = 'ID_LECTURA_ESTAFETA'
    end
    object fbdtfld_resumen_reportFECHA: TFIBDateField
      FieldName = 'FECHA'
    end
    object fbtmfld_resumen_reportHORA: TFIBTimeField
      FieldName = 'HORA'
    end
    object fbntgrfld_resumen_reportBULTOS: TFIBIntegerField
      FieldName = 'BULTOS'
    end
    object fbstrngfld_resumen_reportCOD_DELEGACION_ORG: TFIBStringField
      FieldName = 'COD_DELEGACION_ORG'
      Size = 31
      EmptyStrToNull = True
    end
    object fbstrngfld_resumen_reportNOMBRE_ORG: TFIBStringField
      FieldName = 'NOMBRE_ORG'
      Size = 80
      EmptyStrToNull = True
    end
    object fbstrngfld_resumen_reportDIRECCION_ORG: TFIBStringField
      FieldName = 'DIRECCION_ORG'
      Size = 120
      EmptyStrToNull = True
    end
    object fbstrngfld_resumen_reportCP_ORG: TFIBStringField
      FieldName = 'CP_ORG'
      Size = 5
      EmptyStrToNull = True
    end
    object fbstrngfld_resumen_reportPOBLACION_ORG: TFIBStringField
      FieldName = 'POBLACION_ORG'
      Size = 60
      EmptyStrToNull = True
    end
    object fbstrngfld_resumen_reportPROVINCIA_ORG: TFIBStringField
      FieldName = 'PROVINCIA_ORG'
      Size = 60
      EmptyStrToNull = True
    end
    object fbstrngfld_resumen_reportCOD_DELEGACION_DST: TFIBStringField
      FieldName = 'COD_DELEGACION_DST'
      Size = 31
      EmptyStrToNull = True
    end
    object fbstrngfld_resumen_reportNOMBRE_DST: TFIBStringField
      FieldName = 'NOMBRE_DST'
      Size = 80
      EmptyStrToNull = True
    end
    object fbstrngfld_resumen_reportDIRECCION_DST: TFIBStringField
      FieldName = 'DIRECCION_DST'
      Size = 120
      EmptyStrToNull = True
    end
    object fbstrngfld_resumen_reportCP_DST: TFIBStringField
      FieldName = 'CP_DST'
      Size = 5
      EmptyStrToNull = True
    end
    object fbstrngfld_resumen_reportPOBLACION_DST: TFIBStringField
      FieldName = 'POBLACION_DST'
      Size = 60
      EmptyStrToNull = True
    end
    object fbstrngfld_resumen_reportPROVINCIA_DST: TFIBStringField
      FieldName = 'PROVINCIA_DST'
      Size = 60
      EmptyStrToNull = True
    end
  end
  object q_resumen_digit: TpFIBDataSet
    SelectSQL.Strings = (
      'select l.id_lectura_estafeta,l.fecha,l.hora,l.bultos,l.lleno,'
      
        '    right('#39'0000'#39'||d_org.cod_entidad,4)||'#39'-'#39'||right('#39'0000'#39'||d_org' +
        '.cod_delegacion,4) as cod_delegacion_org,'
      '    d_org.nombre as nombre_org,d_org.direccion as direccion_org,'
      
        '    d_org.cp as cp_org,d_org.poblacion as poblacion_org,d_org.pr' +
        'ovincia as provincia_org,'
      
        '    right('#39'0000'#39'||d_dst.cod_entidad,4)||'#39'-'#39'||right('#39'0000'#39'||d_dst' +
        '.cod_delegacion,4) as cod_delegacion_dst,'
      '    d_dst.nombre as nombre_dst,d_dst.direccion as direccion_dst,'
      
        '    d_dst.cp as cp_dst,d_dst.poblacion as poblacion_dst,d_dst.pr' +
        'ovincia as provincia_dst,'
      
        '    d_org.cod_entidad as org_cod_entidad,d_org.cod_delegacion as' +
        ' org_cod_delegacion,'
      
        '    d_dst.cod_entidad as dst_cod_entidad,d_dst.cod_delegacion as' +
        ' dst_cod_delegacion,'
      '    l.ean'
      'from e_lecturas_estafeta l'
      
        'inner join e_valijas_tarjetas vt on (l.id_valija_tarjeta=vt.id_v' +
        'alija_tarjeta)'
      'inner join e_valijas v on (vt.id_valija=v.id_valija)'
      
        'inner join e_delegaciones d_org on (v.id_delegacion=d_org.id_del' +
        'egacion)'
      
        'inner join e_delegaciones d_dst on (l.id_delegacion_destino=d_ds' +
        't.id_delegacion)'
      
        'where l.fecha between :f_1 and :f_2 and l.digitalizacion=1 and d' +
        '_org.id_cliente=:cliente and d_dst.id_cliente=:cliente'
      ''
      ''
      'order by l.fecha desc,l.hora desc')
    Left = 36
    Top = 259
    oFetchAll = True
    object fbntgrfld_resumen_digitID_LECTURA_ESTAFETA: TFIBIntegerField
      FieldName = 'ID_LECTURA_ESTAFETA'
    end
    object fbdtfld_resumen_digitFECHA: TFIBDateField
      FieldName = 'FECHA'
    end
    object fbtmfld_resumen_digitHORA: TFIBTimeField
      FieldName = 'HORA'
    end
    object fbntgrfld_resumen_digitBULTOS: TFIBIntegerField
      FieldName = 'BULTOS'
    end
    object fbsmlntfld_resumen_digitLLENO: TFIBSmallIntField
      FieldName = 'LLENO'
    end
    object fbstrngfld_resumen_digitCOD_DELEGACION_ORG: TFIBStringField
      FieldName = 'COD_DELEGACION_ORG'
      Size = 31
      EmptyStrToNull = True
    end
    object fbstrngfld_resumen_digitNOMBRE_ORG: TFIBStringField
      FieldName = 'NOMBRE_ORG'
      Size = 80
      EmptyStrToNull = True
    end
    object fbstrngfld_resumen_digitDIRECCION_ORG: TFIBStringField
      FieldName = 'DIRECCION_ORG'
      Size = 120
      EmptyStrToNull = True
    end
    object fbstrngfld_resumen_digitCP_ORG: TFIBStringField
      FieldName = 'CP_ORG'
      Size = 5
      EmptyStrToNull = True
    end
    object fbstrngfld_resumen_digitPOBLACION_ORG: TFIBStringField
      FieldName = 'POBLACION_ORG'
      Size = 60
      EmptyStrToNull = True
    end
    object fbstrngfld_resumen_digitPROVINCIA_ORG: TFIBStringField
      FieldName = 'PROVINCIA_ORG'
      Size = 60
      EmptyStrToNull = True
    end
    object fbstrngfld_resumen_digitCOD_DELEGACION_DST: TFIBStringField
      FieldName = 'COD_DELEGACION_DST'
      Size = 31
      EmptyStrToNull = True
    end
    object fbstrngfld_resumen_digitNOMBRE_DST: TFIBStringField
      FieldName = 'NOMBRE_DST'
      Size = 80
      EmptyStrToNull = True
    end
    object fbstrngfld_resumen_digitDIRECCION_DST: TFIBStringField
      FieldName = 'DIRECCION_DST'
      Size = 120
      EmptyStrToNull = True
    end
    object fbstrngfld_resumen_digitCP_DST: TFIBStringField
      FieldName = 'CP_DST'
      Size = 5
      EmptyStrToNull = True
    end
    object fbstrngfld_resumen_digitPOBLACION_DST: TFIBStringField
      FieldName = 'POBLACION_DST'
      Size = 60
      EmptyStrToNull = True
    end
    object fbstrngfld_resumen_digitPROVINCIA_DST: TFIBStringField
      FieldName = 'PROVINCIA_DST'
      Size = 60
      EmptyStrToNull = True
    end
    object fbntgrfld_resumen_digitORG_COD_ENTIDAD: TFIBIntegerField
      FieldName = 'ORG_COD_ENTIDAD'
    end
    object fbntgrfld_resumen_digitORG_COD_DELEGACION: TFIBIntegerField
      FieldName = 'ORG_COD_DELEGACION'
    end
    object fbntgrfld_resumen_digitDST_COD_ENTIDAD: TFIBIntegerField
      FieldName = 'DST_COD_ENTIDAD'
    end
    object fbntgrfld_resumen_digitDST_COD_DELEGACION: TFIBIntegerField
      FieldName = 'DST_COD_DELEGACION'
    end
    object fbstrngfld_resumen_digitEAN: TFIBStringField
      FieldName = 'EAN'
      Size = 16
      EmptyStrToNull = True
    end
  end
  object ds_resumen_digit: TDataSource
    DataSet = q_resumen_digit
    Left = 105
    Top = 258
  end
  object q_resumen_digit_tot: TpFIBDataSet
    SelectSQL.Strings = (
      'select count(*) as total,sum(bultos) as bultos'
      'from e_lecturas_estafeta l'
      
        'inner join e_valijas_tarjetas vt on (l.id_valija_tarjeta=vt.id_v' +
        'alija_tarjeta)'
      'inner join e_valijas v on (vt.id_valija=v.id_valija)'
      
        'inner join e_delegaciones d_org on (v.id_delegacion=d_org.id_del' +
        'egacion)'
      
        'inner join e_delegaciones d_dst on (l.id_delegacion_destino=d_ds' +
        't.id_delegacion)'
      
        'where l.fecha between :f_1 and :f_2 and l.digitalizacion=1 and d' +
        '_org.id_cliente=:cliente and d_dst.id_cliente=:cliente'
      ''
      ''
      '')
    Left = 215
    Top = 264
    oFetchAll = True
    object fbntgrfld3: TFIBIntegerField
      FieldName = 'TOTAL'
    end
    object fbcdfld1: TFIBBCDField
      FieldName = 'BULTOS'
      Size = 0
    end
  end
  object q_digit_report: TpFIBDataSet
    SelectSQL.Strings = (
      'select l.id_lectura_estafeta,l.fecha,l.hora,l.bultos,'
      
        '    right('#39'0000'#39'||d_org.cod_entidad,4)||'#39'-'#39'||right('#39'0000'#39'||d_org' +
        '.cod_delegacion,4) as cod_delegacion_org,'
      '    d_org.nombre as nombre_org,d_org.direccion as direccion_org,'
      
        '    d_org.cp as cp_org,d_org.poblacion as poblacion_org,d_org.pr' +
        'ovincia as provincia_org,'
      
        '    right('#39'0000'#39'||d_dst.cod_entidad,4)||'#39'-'#39'||right('#39'0000'#39'||d_dst' +
        '.cod_delegacion,4) as cod_delegacion_dst,'
      '    d_dst.nombre as nombre_dst,d_dst.direccion as direccion_dst,'
      
        '    d_dst.cp as cp_dst,d_dst.poblacion as poblacion_dst,d_dst.pr' +
        'ovincia as provincia_dst'
      'from e_lecturas_estafeta l'
      
        'inner join e_valijas_tarjetas vt on (l.id_valija_tarjeta=vt.id_v' +
        'alija_tarjeta)'
      'inner join e_valijas v on (vt.id_valija=v.id_valija)'
      
        'inner join e_delegaciones d_org on (v.id_delegacion=d_org.id_del' +
        'egacion)'
      
        'inner join e_delegaciones d_dst on (l.id_delegacion_destino=d_ds' +
        't.id_delegacion)'
      
        'where l.fecha=:fecha and l.digitalizacion=1 and d_org.id_cliente' +
        '=:cliente and d_dst.id_cliente=:cliente'
      'order by l.hora desc'
      '')
    Left = 59
    Top = 458
    oFetchAll = True
    object FIBIntegerField1: TFIBIntegerField
      FieldName = 'ID_LECTURA_ESTAFETA'
    end
    object FIBDateField1: TFIBDateField
      FieldName = 'FECHA'
    end
    object FIBTimeField1: TFIBTimeField
      FieldName = 'HORA'
    end
    object FIBIntegerField2: TFIBIntegerField
      FieldName = 'BULTOS'
    end
    object FIBStringField1: TFIBStringField
      FieldName = 'COD_DELEGACION_ORG'
      Size = 31
      EmptyStrToNull = True
    end
    object FIBStringField2: TFIBStringField
      FieldName = 'NOMBRE_ORG'
      Size = 80
      EmptyStrToNull = True
    end
    object FIBStringField3: TFIBStringField
      FieldName = 'DIRECCION_ORG'
      Size = 120
      EmptyStrToNull = True
    end
    object FIBStringField4: TFIBStringField
      FieldName = 'CP_ORG'
      Size = 5
      EmptyStrToNull = True
    end
    object FIBStringField5: TFIBStringField
      FieldName = 'POBLACION_ORG'
      Size = 60
      EmptyStrToNull = True
    end
    object FIBStringField6: TFIBStringField
      FieldName = 'PROVINCIA_ORG'
      Size = 60
      EmptyStrToNull = True
    end
    object FIBStringField7: TFIBStringField
      FieldName = 'COD_DELEGACION_DST'
      Size = 31
      EmptyStrToNull = True
    end
    object FIBStringField8: TFIBStringField
      FieldName = 'NOMBRE_DST'
      Size = 80
      EmptyStrToNull = True
    end
    object FIBStringField9: TFIBStringField
      FieldName = 'DIRECCION_DST'
      Size = 120
      EmptyStrToNull = True
    end
    object FIBStringField10: TFIBStringField
      FieldName = 'CP_DST'
      Size = 5
      EmptyStrToNull = True
    end
    object FIBStringField11: TFIBStringField
      FieldName = 'POBLACION_DST'
      Size = 60
      EmptyStrToNull = True
    end
    object FIBStringField12: TFIBStringField
      FieldName = 'PROVINCIA_DST'
      Size = 60
      EmptyStrToNull = True
    end
  end
  object q_aux: TpFIBDataSet
    Left = 352
    Top = 192
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
    Left = 31
    Top = 76
  end
  object q_delegs: TpFIBDataSet
    Left = 200
    Top = 352
  end
  object ds_delegs: TDataSource
    DataSet = q_delegs
    Left = 262
    Top = 357
  end
  object qfile: TpFIBDataSet
    SelectSQL.Strings = (
      'select *'
      'from m_correos_certificadas c')
    AllowedUpdateKinds = []
    Left = 140
    Top = 345
    object lgsID_CORREOS_CERTIFICADAS: TFIBIntegerField
      FieldName = 'ID_CORREOS_CERTIFICADAS'
    end
    object lgsID_CLIENTE: TFIBIntegerField
      FieldName = 'ID_CLIENTE'
    end
    object lgsID_CECO: TFIBIntegerField
      FieldName = 'ID_CECO'
    end
    object lgsID_PRODUCTO: TFIBIntegerField
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
    object lgsBULTOS: TFIBIntegerField
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
    object lgsPESO: TFIBFloatField
      FieldName = 'PESO'
    end
    object lgsALTO: TFIBFloatField
      FieldName = 'ALTO'
    end
    object lgsANCHO: TFIBFloatField
      FieldName = 'ANCHO'
    end
    object lgsLARGO: TFIBFloatField
      FieldName = 'LARGO'
    end
    object lgsINTENTOS: TFIBIntegerField
      FieldName = 'INTENTOS'
    end
    object lgsEN_LISTA: TFIBIntegerField
      FieldName = 'EN_LISTA'
    end
    object fbstrngfldPTO_ADMISION: TFIBStringField
      FieldName = 'PTO_ADMISION'
      Size = 7
      EmptyStrToNull = True
    end
    object lgsFILE_DATE: TFIBDateTimeField
      FieldName = 'FILE_DATE'
    end
    object fbstrngfldFILE_NAME: TFIBStringField
      FieldName = 'FILE_NAME'
      Size = 100
      EmptyStrToNull = True
    end
    object lgsFILE_USUARIO: TFIBIntegerField
      FieldName = 'FILE_USUARIO'
    end
    object fbstrngfldFILE_PATH: TFIBStringField
      FieldName = 'FILE_PATH'
      Size = 100
      EmptyStrToNull = True
    end
    object lgsFECHA_INSERT: TFIBDateTimeField
      FieldName = 'FECHA_INSERT'
    end
    object lgsUSUARIO_INSERT: TFIBIntegerField
      FieldName = 'USUARIO_INSERT'
    end
    object lgsFECHA_UPDATE: TFIBDateTimeField
      FieldName = 'FECHA_UPDATE'
    end
    object lgsUSUARIO_UPDATE: TFIBIntegerField
      FieldName = 'USUARIO_UPDATE'
    end
    object lgsIDX_SOBRE: TFIBIntegerField
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
    AliasName = 'lgs'
    WaitForRestoreConnect = 0
    BeforeConnect = dbBeforeConnect
    Left = 30
    Top = 18
  end
end
