object Form3: TForm3
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Asignar Cajas'
  ClientHeight = 665
  ClientWidth = 814
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 692
    Top = 38
    Width = 105
    Height = 13
    Caption = 'Cajas Desubicadas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ebuscar: TsEdit
    Left = 48
    Top = 35
    Width = 145
    Height = 21
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnChange = ebuscarChange
    OnMouseEnter = ebuscarMouseEnter
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Active = True
    BoundLabel.ParentFont = False
    BoundLabel.Caption = 'Buscar'
  end
  object cbbbuscar: TsComboBox
    Left = 48
    Top = 8
    Width = 145
    Height = 21
    BoundLabel.Active = True
    BoundLabel.ParentFont = False
    BoundLabel.Caption = 'Tipo'
    SkinData.SkinSection = 'COMBOBOX'
    ItemIndex = -1
    TabOrder = 1
    OnChange = cbbbuscarChange
    Items.Strings = (
      ''
      'ASEVAL'
      'ASEVAL - PENSIONES'
      'ASEVAL - SINIESTROS'
      'BANCO DE VALENCIA'
      'AVIVA')
  end
  object btn1: TsButton
    Left = 155
    Top = 326
    Width = 75
    Height = 25
    Caption = 'Obtener Caja'
    TabOrder = 2
    OnClick = btn1Click
    SkinData.SkinSection = 'BUTTON'
  end
  object editcaja: TsSpinEdit
    Left = 79
    Top = 328
    Width = 70
    Height = 21
    ReadOnly = True
    TabOrder = 3
    Text = '0'
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Active = True
    BoundLabel.ParentFont = False
    BoundLabel.Caption = 'C'#243'digo Caja'
    MaxValue = 0
    MinValue = 0
    Value = 0
  end
  object editcodcliente: TsEdit
    Left = 83
    Top = 537
    Width = 90
    Height = 21
    TabOrder = 7
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Active = True
    BoundLabel.ParentFont = False
    BoundLabel.Caption = 'Art'#237'culo'
  end
  object btn2: TsButton
    Left = 166
    Top = 593
    Width = 75
    Height = 27
    Caption = 'Introducir'
    TabOrder = 9
    OnClick = btn2Click
    SkinData.SkinSection = 'BUTTON'
  end
  object btn3: TsButton
    Left = 79
    Top = 593
    Width = 81
    Height = 27
    Caption = 'Quitar Art'#237'culo'
    TabOrder = 10
    OnClick = btn3Click
    SkinData.SkinSection = 'BUTTON'
  end
  object btn4: TsButton
    Left = 398
    Top = 519
    Width = 75
    Height = 25
    Caption = 'Guardar Caja'
    TabOrder = 11
    OnClick = btn4Click
    SkinData.SkinSection = 'BUTTON'
  end
  object btn5: TsButton
    Left = 217
    Top = 33
    Width = 75
    Height = 25
    Caption = 'Buscar'
    TabOrder = 12
    OnClick = btn5Click
    SkinData.SkinSection = 'BUTTON'
  end
  object rb1: TRadioButton
    Left = 217
    Top = 10
    Width = 73
    Height = 17
    Caption = 'Documento'
    TabOrder = 13
    OnClick = rb3Click
  end
  object rb2: TRadioButton
    Left = 296
    Top = 10
    Width = 113
    Height = 17
    Caption = 'Caja'
    TabOrder = 14
    OnClick = rb3Click
  end
  object editestanteria: TsEdit
    Left = 610
    Top = 519
    Width = 33
    Height = 21
    TabOrder = 4
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Active = True
    BoundLabel.ParentFont = False
    BoundLabel.Caption = 'Estant.'
  end
  object editposicion: TsSpinEdit
    Left = 674
    Top = 519
    Width = 49
    Height = 21
    TabOrder = 5
    Text = '0'
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Active = True
    BoundLabel.UseSkinColor = False
    BoundLabel.ParentFont = False
    BoundLabel.Caption = 'Pos.'
    MaxValue = 0
    MinValue = 0
    Value = 0
  end
  object editaltura: TsSpinEdit
    Left = 748
    Top = 519
    Width = 49
    Height = 21
    TabOrder = 6
    Text = '0'
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Active = True
    BoundLabel.UseSkinColor = False
    BoundLabel.ParentFont = False
    BoundLabel.Caption = 'Alt.'
    MaxValue = 0
    MinValue = 0
    Value = 0
  end
  object btn6: TsButton
    Left = 610
    Top = 566
    Width = 75
    Height = 25
    Caption = 'Ubicar Cajas'
    TabOrder = 16
    OnClick = btn6Click
    SkinData.SkinSection = 'BUTTON'
  end
  object rb3: TRadioButton
    Left = 352
    Top = 10
    Width = 113
    Height = 17
    Caption = 'Caja Antigua'
    TabOrder = 18
    OnClick = rb3Click
  end
  object btn7: TsButton
    Left = 504
    Top = 566
    Width = 97
    Height = 25
    Caption = 'Imprimir Etiqueta'
    Enabled = False
    TabOrder = 20
    OnClick = btn7Click
    SkinData.SkinSection = 'BUTTON'
  end
  object rb4: TRadioButton
    Left = 440
    Top = 10
    Width = 113
    Height = 17
    Caption = 'C'#243'digo LGS'
    TabOrder = 15
    OnClick = rb3Click
  end
  object btn8: TButton
    Left = 722
    Top = 565
    Width = 75
    Height = 25
    Caption = 'Salir'
    TabOrder = 17
    OnClick = btn8Click
  end
  object chk1: TCheckBox
    Left = 16
    Top = 635
    Width = 97
    Height = 17
    Caption = 'M'#233'todo antiguo'
    TabOrder = 19
  end
  object edtdescripcion: TsEdit
    Left = 83
    Top = 566
    Width = 390
    Height = 21
    TabOrder = 8
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Active = True
    BoundLabel.ParentFont = False
    BoundLabel.Caption = 'Descripci'#243'n'
  end
  object rp_etiqueta: TfrxReport
    Version = '5.6.1'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Por defecto'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42053.524331400500000000
    ReportOptions.LastChange = 42088.407042581000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 400
    Top = 344
    Datasets = <
      item
        DataSet = tabla
        DataSetName = 'frxDBDataset1'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 104.000000000000000000
      PaperHeight = 147.000000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object BarCode1: TfrxBarCodeView
        Align = baCenter
        Left = 118.240260000000000000
        Top = 132.283550000000000000
        Width = 64.000000000000000000
        Height = 75.590600000000000000
        BarType = bcCode_2_5_interleaved
        CalcCheckSum = True
        DataField = 'matricula'
        DataSet = tabla
        DataSetName = 'frxDBDataset1'
        Rotation = 0
        TestLine = False
        Text = '12345678'
        WideBarRatio = 4.000000000000000000
        Zoom = 1.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
      end
      object articulo: TfrxMemoView
        Align = baCenter
        Left = 51.023655000000010000
        Top = 37.795300000000000000
        Width = 215.433210000000000000
        Height = 30.236240000000000000
        DataField = 'articulo'
        DataSet = tabla
        DataSetName = 'frxDBDataset1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = []
        HAlign = haCenter
        Memo.UTF8W = (
          '[frxDBDataset1."articulo"]')
        ParentFont = False
      end
      object caja: TfrxMemoView
        Align = baCenter
        Left = 111.496135000000000000
        Top = 86.929190000000000000
        Width = 94.488250000000000000
        Height = 26.456710000000000000
        DataField = 'caja'
        DataSet = tabla
        DataSetName = 'frxDBDataset1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = []
        HAlign = haCenter
        Memo.UTF8W = (
          '[frxDBDataset1."caja"]')
        ParentFont = False
      end
      object matricula: TfrxMemoView
        Align = baLeft
        Top = 249.448980000000000000
        Width = 309.921460000000000000
        Height = 30.236240000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = []
        Memo.UTF8W = (
          'Matr'#237'cula - ')
        ParentFont = False
      end
      object Memo3: TfrxMemoView
        Top = 359.055350000000000000
        Width = 52.913420000000000000
        Height = 18.897650000000000000
        Memo.UTF8W = (
          'Fecha - ')
      end
      object frxDBDataset1caja1: TfrxMemoView
        Left = 147.401670000000000000
        Top = 359.055350000000000000
        Width = 158.740260000000000000
        Height = 18.897650000000000000
        DataField = 'caja1'
        DataSet = tabla
        DataSetName = 'frxDBDataset1'
        Memo.UTF8W = (
          '[frxDBDataset1."caja1"]')
      end
      object frxDBDataset1caja2: TfrxMemoView
        Left = 147.401670000000000000
        Top = 385.512060000000000000
        Width = 158.740260000000000000
        Height = 18.897650000000000000
        DataField = 'caja2'
        DataSet = tabla
        DataSetName = 'frxDBDataset1'
        Memo.UTF8W = (
          '[frxDBDataset1."caja2"]')
      end
      object frxDBDataset1caja3: TfrxMemoView
        Left = 147.401670000000000000
        Top = 408.189240000000000000
        Width = 158.740260000000000000
        Height = 18.897650000000000000
        DataField = 'caja3'
        DataSet = tabla
        DataSetName = 'frxDBDataset1'
        Memo.UTF8W = (
          '[frxDBDataset1."caja3"]')
      end
      object frxDBDataset1caja4: TfrxMemoView
        Left = 147.401670000000000000
        Top = 430.866420000000000000
        Width = 158.740260000000000000
        Height = 18.897650000000000000
        DataField = 'caja4'
        DataSet = tabla
        DataSetName = 'frxDBDataset1'
        Memo.UTF8W = (
          '[frxDBDataset1."caja4"]')
      end
      object frxDBDataset1matricula: TfrxMemoView
        Left = 124.724490000000000000
        Top = 249.448980000000000000
        Width = 158.740260000000000000
        Height = 26.456710000000000000
        DataField = 'matricula'
        DataSet = tabla
        DataSetName = 'frxDBDataset1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = []
        Memo.UTF8W = (
          '[frxDBDataset1."matricula"]')
        ParentFont = False
      end
      object frxDBDataset1articulo_cliente: TfrxMemoView
        Align = baLeft
        Top = 287.244280000000000000
        Width = 283.464750000000000000
        Height = 30.236240000000000000
        DataField = 'articulo_cliente'
        DataSet = tabla
        DataSetName = 'frxDBDataset1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = []
        Memo.UTF8W = (
          '[frxDBDataset1."articulo_cliente"]')
        ParentFont = False
      end
      object frxDBDataset1fecha: TfrxMemoView
        Left = 60.472480000000000000
        Top = 359.055350000000000000
        Width = 79.370130000000000000
        Height = 18.897650000000000000
        DataField = 'fecha'
        DataSet = tabla
        DataSetName = 'frxDBDataset1'
        Memo.UTF8W = (
          '[frxDBDataset1."fecha"]')
      end
      object frxDBDataset1caja5: TfrxMemoView
        Left = 143.622140000000000000
        Top = 449.764070000000000000
        Width = 158.740260000000000000
        Height = 18.897650000000000000
        DataField = 'caja5'
        DataSet = tabla
        DataSetName = 'frxDBDataset1'
        Memo.UTF8W = (
          '[frxDBDataset1."caja5"]')
      end
    end
  end
  object tabla: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    FieldAliases.Strings = (
      'articulo=articulo'
      'matricula=matricula'
      'articulo_cliente=articulo_cliente'
      'fecha=fecha'
      'caja1=caja1'
      'caja2=caja2'
      'caja3=caja3'
      'caja4=caja4'
      'caja=caja'
      'caja5=caja5')
    DataSet = ds1
    BCDToCurrency = False
    Left = 336
    Top = 344
  end
  object ds1: TClientDataSet
    PersistDataPacket.Data = {
      150100009619E0BD010000001800000009000000000003000000150108617274
      6963756C6F0100490000000100055749445448020002001400096D6174726963
      756C610100490000000100055749445448020002001400106172746963756C6F
      5F636C69656E7465010049000000010005574944544802000200140005666563
      686101004900000001000557494454480200020014000563616A613101004900
      000001000557494454480200020014000563616A613201004900000001000557
      494454480200020014000563616A613301004900000001000557494454480200
      020014000563616A613401004900000001000557494454480200020014000463
      616A6101004900000001000557494454480200020014000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'articulo'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'matricula'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'articulo_cliente'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'fecha'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'caja1'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'caja2'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'caja3'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'caja4'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'caja'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 400
    Top = 408
    object ds1articulo: TStringField
      FieldName = 'articulo'
    end
    object ds1matricula: TStringField
      FieldName = 'matricula'
    end
    object ds1articulo_cliente: TStringField
      FieldName = 'articulo_cliente'
    end
    object ds1fecha: TStringField
      FieldName = 'fecha'
    end
    object ds1caja1: TStringField
      FieldName = 'caja1'
    end
    object ds1caja2: TStringField
      FieldName = 'caja2'
    end
    object ds1caja3: TStringField
      FieldName = 'caja3'
    end
    object ds1caja4: TStringField
      FieldName = 'caja4'
    end
    object ds1caja: TStringField
      FieldName = 'caja'
    end
    object ds1caja5: TStringField
      FieldKind = fkCalculated
      FieldName = 'caja5'
      Calculated = True
    end
  end
end
