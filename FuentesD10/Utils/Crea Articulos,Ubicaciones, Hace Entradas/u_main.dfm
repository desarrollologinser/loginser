object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Crea Ubics., Arts. y Matr'#237'culas'
  ClientHeight = 154
  ClientWidth = 655
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lb_1: TsLabel
    Left = 8
    Top = 35
    Width = 20
    Height = 13
    Caption = 'lb_1'
    ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object fe_1: TsFilenameEdit
    Left = 8
    Top = 8
    Width = 445
    Height = 21
    AutoSize = False
    MaxLength = 255
    ParentFont = False
    TabOrder = 0
    Text = ''
    CheckOnExit = True
    SkinData.SkinSection = 'EDIT'
    Filter = 'XLSX files (*.xlsx)|*.xlsx|XLS files (*.xls)|*.xls'
  end
  object bt_1: TsButton
    Left = 32
    Top = 155
    Width = 250
    Height = 25
    Caption = 'Formato 6131'
    TabOrder = 1
    Visible = False
    OnClick = bt_1Click
    SkinData.SkinSection = 'BUTTON'
  end
  object btn1: TsButton
    Left = 32
    Top = 186
    Width = 250
    Height = 25
    Caption = 'Formato standard'
    TabOrder = 2
    Visible = False
    OnClick = btn1Click
    SkinData.SkinSection = 'BUTTON'
  end
  object btn_aseval: TsButton
    Left = 32
    Top = 217
    Width = 250
    Height = 25
    Caption = 'Formato Aseval'
    TabOrder = 3
    Visible = False
    OnClick = btn_asevalClick
    SkinData.SkinSection = 'BUTTON'
  end
  object btn_aseval_2: TsButton
    Left = 32
    Top = 248
    Width = 250
    Height = 25
    Caption = 'Formato Aseval 2'
    TabOrder = 4
    Visible = False
    OnClick = btn_aseval_2Click
    SkinData.SkinSection = 'BUTTON'
  end
  object bt_2: TsButton
    Left = 32
    Top = 284
    Width = 250
    Height = 25
    Caption = 'Formato Nuevas Cajas Aseval'
    TabOrder = 5
    Visible = False
    OnClick = bt_2Click
    SkinData.SkinSection = 'BUTTON'
  end
  object btTodo: TsButton
    Left = 293
    Top = 35
    Width = 160
    Height = 25
    Caption = 'Formato standard XLS'
    TabOrder = 6
    OnClick = btTodoClick
    SkinData.SkinSection = 'BUTTON'
  end
  object brStatus: TsStatusBar
    Left = 0
    Top = 135
    Width = 655
    Height = 19
    Panels = <>
    object lbBbdd: TsLabel
      Left = 14
      Top = 4
      Width = 3
      Height = 15
    end
  end
  object btUbicaciones: TsButton
    Left = 293
    Top = 66
    Width = 160
    Height = 25
    Caption = 'Crear Ubicaciones'
    TabOrder = 8
    OnClick = btUbicacionesClick
  end
  object btArticulos: TsButton
    Left = 293
    Top = 97
    Width = 160
    Height = 25
    Caption = 'Crear Art'#237'culos'
    TabOrder = 9
    OnClick = btArticulosClick
  end
  object de_1: TsDirectoryEdit
    Left = 38
    Top = 315
    Width = 121
    Height = 21
    MaxLength = 255
    TabOrder = 10
    Text = ''
    Visible = False
    CheckOnExit = True
    Root = 'rfDesktop'
  end
  object b_1: TsButton
    Left = 38
    Top = 342
    Width = 147
    Height = 25
    TabOrder = 11
    Visible = False
    OnClick = bt_1Click
    SkinData.SkinSection = 'BUTTON'
  end
  object b_2: TsButton
    Left = 191
    Top = 342
    Width = 114
    Height = 25
    TabOrder = 12
    Visible = False
    OnClick = bt_1Click
    SkinData.SkinSection = 'BUTTON'
  end
  object chArticulo: TCheckBox
    Left = 14
    Top = 70
    Width = 233
    Height = 17
    Caption = 'Actualizar art'#237'culo si existe'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 13
  end
  object gb1: TGroupBox
    Left = 459
    Top = 8
    Width = 185
    Height = 114
    Caption = 'Columnas en Excel'
    TabOrder = 14
    object mm: TMemo
      Left = 5
      Top = 19
      Width = 172
      Height = 89
      BorderStyle = bsNone
      Color = clBtnFace
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object db: TpFIBDatabase
    DBParams.Strings = (
      'password=masterkey'
      'user_name=SYSDBA')
    DefaultTransaction = read
    DefaultUpdateTransaction = write
    SQLDialect = 3
    Timeout = 0
    LibraryName = 'fbclient.dll'
    WaitForRestoreConnect = 0
    Left = 282
    Top = 169
  end
  object read: TpFIBTransaction
    DefaultDatabase = db
    Left = 314
    Top = 169
  end
  object write: TpFIBTransaction
    DefaultDatabase = db
    Left = 348
    Top = 169
  end
  object q_1: TpFIBQuery
    Transaction = write
    Database = db
    Left = 435
    Top = 170
  end
  object q_0: TpFIBDataSet
    Transaction = read
    Database = db
    UpdateTransaction = write
    Left = 401
    Top = 169
  end
  object ds1: TClientDataSet
    PersistDataPacket.Data = {
      500200009619E0BD01000000180000001C0000000000030000005002056C696E
      6561040001000000000006436F64436C69040001000000000006436F64417274
      0100490000000100055749445448020002001400064E6F6D4172740200490000
      0001000557494454480200020090010346616D0400010000000000045065736F
      080004000000000004416C746F0800040000000000054C6172676F0800040000
      00000005416E63686F0800040000000000064B6773566F6C0800040000000000
      06526566436C6901004900000001000557494454480200020014000655647345
      6D62040001000000000003556473040001000000000002424301004900000001
      00055749445448020002001400054964416C6D04000100000000000A45737461
      6E7465726961010049000000010005574944544802000200030008506F736963
      696F6E040001000000000006416C747572610400010000000000045375623101
      0049000000010005574944544802000200020004537562320100490000000100
      0557494454480200020002000543756269630800040000000000094E6F6D436C
      69417274010049000000010005574944544802000200FA000650726563696F08
      0004000000000004496D65690100490000000100055749445448020002001400
      094361647563696461640400060000000000046C6F7465010049000000010005
      5749445448020002001400086361645F6C6F746504000600000000000B616C62
      5F636C69656E7465010049000000010005574944544802000200190001000D44
      454641554C545F4F524445520200820000000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'linea'
        DataType = ftInteger
      end
      item
        Name = 'CodCli'
        DataType = ftInteger
      end
      item
        Name = 'CodArt'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'NomArt'
        DataType = ftString
        Size = 400
      end
      item
        Name = 'Fam'
        DataType = ftInteger
      end
      item
        Name = 'Peso'
        DataType = ftFloat
      end
      item
        Name = 'Alto'
        DataType = ftFloat
      end
      item
        Name = 'Largo'
        DataType = ftFloat
      end
      item
        Name = 'Ancho'
        DataType = ftFloat
      end
      item
        Name = 'KgsVol'
        DataType = ftFloat
      end
      item
        Name = 'RefCli'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'UdsEmb'
        DataType = ftInteger
      end
      item
        Name = 'Uds'
        DataType = ftInteger
      end
      item
        Name = 'BC'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'IdAlm'
        DataType = ftInteger
      end
      item
        Name = 'Estanteria'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'Posicion'
        DataType = ftInteger
      end
      item
        Name = 'Altura'
        DataType = ftInteger
      end
      item
        Name = 'Sub1'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'Sub2'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'Cubic'
        DataType = ftFloat
      end
      item
        Name = 'NomCliArt'
        DataType = ftString
        Size = 250
      end
      item
        Name = 'Precio'
        DataType = ftFloat
      end
      item
        Name = 'Imei'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Caducidad'
        DataType = ftDate
      end
      item
        Name = 'lote'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'cad_lote'
        DataType = ftDate
      end
      item
        Name = 'alb_cliente'
        DataType = ftString
        Size = 25
      end>
    IndexDefs = <
      item
        Name = 'DEFAULT_ORDER'
      end
      item
        Name = 'CHANGEINDEX'
      end
      item
        Name = 'idx'
        Fields = 'CodCli;CodArt;Estanteria;Posicion;Altura;Sub1;Sub2;lote'
      end>
    IndexName = 'idx'
    Params = <>
    StoreDefs = True
    Left = 320
    Top = 224
    object cdsds1linea: TIntegerField
      FieldName = 'linea'
    end
    object cdsds1CodCli: TIntegerField
      FieldName = 'CodCli'
    end
    object ds1CodArt: TStringField
      FieldName = 'CodArt'
    end
    object ds1NomArt: TStringField
      FieldName = 'NomArt'
      Size = 400
    end
    object cdsds1Fam: TIntegerField
      FieldName = 'Fam'
    end
    object ds1Peso: TFloatField
      FieldName = 'Peso'
    end
    object ds1Alto: TFloatField
      FieldName = 'Alto'
    end
    object ds1Largo: TFloatField
      FieldName = 'Largo'
    end
    object ds1Ancho: TFloatField
      FieldName = 'Ancho'
    end
    object ds1KgsVol: TFloatField
      FieldName = 'KgsVol'
    end
    object ds1RefCli: TStringField
      FieldName = 'RefCli'
    end
    object cdsds1UdsEmb: TIntegerField
      FieldName = 'UdsEmb'
    end
    object cdsds1Uds: TIntegerField
      FieldName = 'Uds'
    end
    object ds1BC: TStringField
      FieldName = 'BC'
    end
    object cdsds1IdAlm: TIntegerField
      FieldName = 'IdAlm'
    end
    object ds1Estanteria: TStringField
      FieldName = 'Estanteria'
      Size = 3
    end
    object cdsds1Posicion: TIntegerField
      FieldName = 'Posicion'
    end
    object cdsds1Altura: TIntegerField
      FieldName = 'Altura'
    end
    object ds1Sub1: TStringField
      FieldName = 'Sub1'
      Size = 2
    end
    object ds1Sub2: TStringField
      FieldName = 'Sub2'
      Size = 2
    end
    object ds1Cubic: TFloatField
      FieldName = 'Cubic'
    end
    object ds1NomCliArt: TStringField
      FieldName = 'NomCliArt'
      Size = 250
    end
    object ds1Precio: TFloatField
      FieldName = 'Precio'
    end
    object ds1Imei: TStringField
      FieldName = 'Imei'
    end
    object ds1Caducidad: TDateField
      FieldName = 'Caducidad'
    end
    object strngfldds1lote: TStringField
      FieldName = 'lote'
    end
    object ds1cad_lote: TDateField
      FieldName = 'cad_lote'
    end
    object strngfldds1alb_cliente: TStringField
      FieldName = 'alb_cliente'
      Size = 25
    end
  end
end
