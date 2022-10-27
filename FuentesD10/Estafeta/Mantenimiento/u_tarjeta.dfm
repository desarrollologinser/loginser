object f_tarjeta: Tf_tarjeta
  Left = 0
  Top = 0
  Caption = 'Detalle de Tarjeta de Valija'
  ClientHeight = 166
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object sGroupBox4: TsGroupBox
    Left = 8
    Top = 8
    Width = 607
    Height = 150
    Caption = 'Datos de la Tarjeta'
    TabOrder = 0
    SkinData.SkinSection = 'GROUPBOX'
    object bt_guardar: TsBitBtn
      Left = 444
      Top = 105
      Width = 143
      Height = 30
      Caption = 'Guardar Cambios'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000009E203D00AD43F300B34CEE00B651F20F8E329C00000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000003A22DA961E5AAFF6FEEB7FF6FEEB8FF32CA7AFF0D8F32AD000000000000
        000000000000000000000000000000000000000000000000000000000000008B
        15151DBF62F078FFD5FF7AFFD2FF68FFCDFF5CFDC3FF25D07DFF0D8E2FAF0000
        0001000000000000000000000000000000000000000000000000000000000093
        206222E594FF40FFC1FF3EFFBBFF2CFFB7FF07FFAEFF1CFBABFF15C870FF0C8F
        2DC000680003000000000000000000000000000000000000000000000000009F
        2FBB00F9A2FF03FEABFF12FEAEFF1DFCADFF36FBB3FF42F4AEFF59EEABFF21C2
        6AFF05972CB600900008000000000000000000000000000000000085001F00B8
        4EF80DF5A0FF3EF5AEFF5BF5B8FF1CB35BA163E9AAE782F3C2FF80EDB9FF78E5
        ABFF2AB65DFF079326C80087000D000000000000000000000000008B006B1DD3
        78FF62EFB0FF78F3BEFF4ECE80DE00680003138F32575EC685EB92ECBEFF93E6
        B7FF92DEABFF3EB561FF00981DC0008A00110000000000000000039A198169E3
        A4FF82EBB8FF81EDBAFF20A1317000000000000000000A96132E6BBD80EBA6E8
        C1FFA5E3BAFFABDFB7FF4EB567FF009319D30087001A0000000000900012248F
        2D814EB165CF59BB75F0008C001D0000000000000000000000000A8B0A2C6DB8
        78E1BAE6C6FFB7E1BFFFC1E1C1FF67BB78FF008F13D5008D0029000000000000
        0000006800030090001A0000000100000000000000000000000000000000008C
        001F78B87BE0CDE9CFFFC9E5C9FFD6EAD4FF80C38CFF0391158D000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000089001E78B477D5E0F0E0FFE9F4E9FFABD4ABE0187B1357000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000008400146AA568D481B881CD15700F3F00000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      TabOrder = 0
      OnClick = bt_guardarClick
      SkinData.SkinSection = 'BUTTON'
    end
    object ed_id_tjta: TsEdit
      Left = 56
      Top = 28
      Width = 67
      Height = 21
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      SkinData.SkinSection = 'EDIT'
      BoundLabel.Active = True
      BoundLabel.Caption = 'Id'
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clBlack
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = []
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
    end
    object ed_ean: TsEdit
      Left = 308
      Top = 28
      Width = 116
      Height = 21
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      NumbersOnly = True
      ParentFont = False
      TabOrder = 2
      SkinData.SkinSection = 'EDIT'
      BoundLabel.Active = True
      BoundLabel.Caption = 'EAN'
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clBlack
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = []
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
    end
    object ed_rfid: TsEdit
      Left = 469
      Top = 28
      Width = 118
      Height = 21
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      SkinData.SkinSection = 'EDIT'
      BoundLabel.Active = True
      BoundLabel.Caption = 'RFID'
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clBlack
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = []
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
    end
    object ed_ntjta: TsEdit
      Left = 221
      Top = 28
      Width = 43
      Height = 21
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      NumbersOnly = True
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
      SkinData.SkinSection = 'EDIT'
      BoundLabel.Active = True
      BoundLabel.Caption = 'N'#186' Tarjeta'
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clBlack
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = []
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
    end
    object cb_estado: TsComboBox
      Left = 56
      Top = 109
      Width = 145
      Height = 21
      Alignment = taLeftJustify
      BoundLabel.Active = True
      BoundLabel.Caption = 'Estado'
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clBlack
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = []
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
      SkinData.SkinSection = 'COMBOBOX'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemIndex = -1
      ParentFont = False
      TabOrder = 5
      Items.Strings = (
        'A Activo'
        'B Bloqueado/Suprimido')
    end
    object ed_ntjta_alt: TsEdit
      Left = 221
      Top = 55
      Width = 43
      Height = 21
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      NumbersOnly = True
      ParentFont = False
      ReadOnly = True
      TabOrder = 6
      SkinData.SkinSection = 'EDIT'
      BoundLabel.Active = True
      BoundLabel.Caption = 'N'#186' Tarjeta Alt'
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clBlack
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = []
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
    end
    object ed_ean_alt: TsEdit
      Left = 308
      Top = 55
      Width = 116
      Height = 21
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      NumbersOnly = True
      ParentFont = False
      TabOrder = 7
      SkinData.SkinSection = 'EDIT'
      BoundLabel.Active = True
      BoundLabel.Caption = 'EAN Alt'
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clBlack
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = []
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
    end
    object ed_ean_old1: TsEdit
      Left = 308
      Top = 82
      Width = 116
      Height = 21
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      NumbersOnly = True
      ParentFont = False
      TabOrder = 8
      SkinData.SkinSection = 'EDIT'
      BoundLabel.Active = True
      BoundLabel.Caption = 'EAN Viejo'
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clBlack
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = []
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
    end
    object ed_ean_old2: TsEdit
      Left = 308
      Top = 109
      Width = 116
      Height = 21
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      NumbersOnly = True
      ParentFont = False
      TabOrder = 9
      SkinData.SkinSection = 'EDIT'
      BoundLabel.Active = True
      BoundLabel.Caption = 'EAN Viejo 2'
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clBlack
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = []
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
    end
  end
end
