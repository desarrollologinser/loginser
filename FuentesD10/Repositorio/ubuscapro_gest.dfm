object fbuscapro_gest: Tfbuscapro_gest
  Left = 156
  Top = 133
  Caption = 'Aluminium (internal)'
  ClientHeight = 346
  ClientWidth = 586
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object grid: TJvDBGrid
    Left = 0
    Top = 88
    Width = 586
    Height = 201
    Align = alClient
    Ctl3D = True
    FixedColor = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgRowLines, dgRowSelect, dgTitleClick, dgTitleHotTrack]
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = gridCellClick
    OnDblClick = gridDblClick
    TitleButtons = True
    OnGetBtnParams = gridGetBtnParams
    OnTitleBtnClick = gridTitleBtnClick
    SelectColumn = scGrid
    TitleArrow = True
    AutoSizeColumns = True
    SelectColumnsDialogStrings.Caption = 'Select columns'
    SelectColumnsDialogStrings.OK = '&OK'
    SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
    EditControls = <>
    RowsHeight = 17
    TitleRowHeight = 17
  end
  object pn_1: TsPanel
    AlignWithMargins = True
    Left = 3
    Top = 292
    Width = 580
    Height = 51
    Align = alBottom
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    DesignSize = (
      580
      51)
    object Bevel2: TsBevel
      Left = 1
      Top = 25
      Width = 578
      Height = 24
      Align = alTop
      ExplicitWidth = 666
    end
    object Bevel1: TsBevel
      Left = 1
      Top = 1
      Width = 578
      Height = 24
      Align = alTop
      ExplicitWidth = 666
    end
    object lblLabel3: TsLabel
      Left = 8
      Top = 29
      Width = 30
      Height = 13
      Caption = 'Orden'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object lb_orden: TsLabel
      Left = 51
      Top = 29
      Width = 42
      Height = 13
      Caption = 'lb_orden'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object lblLabel5: TsLabel
      Left = 8
      Top = 6
      Width = 24
      Height = 13
      Caption = 'Filtro'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object lb_filtro: TsLabel
      Left = 51
      Top = 6
      Width = 36
      Height = 13
      Caption = 'lb_filtro'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object Bevel3: TsBevel
      Left = 44
      Top = 1
      Width = 10
      Height = 47
      Shape = bsLeftLine
      Style = bsRaised
    end
    object sb_SpeedButton4: TsSpeedButton
      Left = 475
      Top = 3
      Width = 102
      Height = 20
      Anchors = [akTop, akRight]
      Caption = 'Limpiar'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FFFFFF00FFFF
        FF000000000000000000000000000000000B0101011F0707072C0808082D0202
        02220000000F00000000000000000000000000000000FFFFFF00FFFFFF00FFFF
        FF0000000004050606294749489E8B8E8CDBADB1AEF2B9BDBBFAADB1AFFA9DA1
        9FF37B7F7DDF464947AC0A0B0A380000000800000001FFFFFF00FFFFFF00FFFF
        FF0000000016767978D7C2C7C5FFC7CDCAFFDBE0DDFFCAD0CDFFCED3D0FFACB1
        AEFFA9AEABFF9A9F9CFF6C706EEB0303032B00000001FFFFFF00FFFFFF00FFFF
        FF0002020210999D9BF0BEC2C1FFC6CAC8FFD9DDDBFFBCC1BEFFCACECBFF9599
        97FF989C9AFF808482FF7E8280FF0D0E0D2800000000FFFFFF00FFFFFF00FFFF
        FF00434645089CA09EEEC0C3C2FFC7CBC9FFD6DAD8FFBCC1BEFFC5CAC7FF9499
        96FF959A97FF797D7BFF717573FF474A481E3A3D3B00FFFFFF00FFFFFF00FFFF
        FF004E525008999D9BEEBEC1C0FFC6CAC8FFD5D9D7FFBBC0BDFFC2C6C3FF9498
        95FF959A97FF797C7AFF6C706EFF5458561E575B5900FFFFFF00FFFFFF00FFFF
        FF004C504E08989C9AEEBCC0BEFFC4C8C6FFD5D9D7FFBBC0BDFFBFC4C1FF9397
        95FF959A97FF797C7AFF6D716EFF5256541E53575500FFFFFF00FFFFFF00FFFF
        FF004C504E08989C9AEEBDC0BFFFC6CBC9FFDADEDCFFBBC1BDFFBFC4C1FF9297
        94FF979C99FF7A7D7BFF6D716EFF5256541E53575500FFFFFF00FFFFFF00FFFF
        FF004C514E089A9E9CEEAEB2B0FF9EA3A0FF9CA09EFF929694FF939794FF7579
        76FF787C7AFF6E7270FF6C706EFF5257541E53585500FFFFFF00FFFFFF00FFFF
        FF004B4E4C09848785EEA6A9A8FFB6BAB8FFCFD2D1FFD6D8D7FFC7CAC9FFB3B6
        B5FF999D9BFF828685FF696C6BFF4F52501F50535100FFFFFF00FFFFFF00FFFF
        FF004F52512DADB1AFFFD4D7D5FFE9EBEBFFF4F5F5FFEFF1F0FFE4E7E5FFD5D8
        D7FFC0C4C3FFAAAFADFF8D918FFF5255544B4C4F4E00FFFFFF00FFFFFF00FFFF
        FF005E62603EEDEFEEFFF7F8F8FFEEEFEFFFE0E3E2FFCFD2D1FFC3C8C6FFBDC3
        C1FFBAC0BEFFBAC1BEFFB7BDBBFF5E62605F50545200FFFFFF00FFFFFF00FFFF
        FF002D2E2E10ADAFAED2EAECEBFFE8EBEAFFE2E4E3FF939795FF868B89FFC4C8
        C7FFBDC3C1FFB7BEBBFF909593E45557562354555400FFFFFF00FFFFFF00FFFF
        FF00000000004A4E4B076A6D6B698C908FB6B3B6B4E4ECEEEDFFDCDEDDFFA0A5
        A3EB7A7E7CBA5C605E763F42410D5657570055555500FFFFFF00FFFFFF00FFFF
        FF000000000053565300585B5900474948004E514F16818382A0888C8AAD4549
        47273B3E3C004C4F4E00424443005758580055555500FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
      OnClick = sb_SpeedButton4Click
      SkinData.SkinSection = 'SPEEDBUTTON'
      ExplicitLeft = 563
    end
    object sb_SpeedButton5: TsSpeedButton
      Left = 475
      Top = 27
      Width = 102
      Height = 20
      Anchors = [akTop, akRight]
      Caption = 'Limpiar'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FFFFFF00FFFF
        FF000000000000000000000000000000000B0101011F0707072C0808082D0202
        02220000000F00000000000000000000000000000000FFFFFF00FFFFFF00FFFF
        FF0000000004050606294749489E8B8E8CDBADB1AEF2B9BDBBFAADB1AFFA9DA1
        9FF37B7F7DDF464947AC0A0B0A380000000800000001FFFFFF00FFFFFF00FFFF
        FF0000000016767978D7C2C7C5FFC7CDCAFFDBE0DDFFCAD0CDFFCED3D0FFACB1
        AEFFA9AEABFF9A9F9CFF6C706EEB0303032B00000001FFFFFF00FFFFFF00FFFF
        FF0002020210999D9BF0BEC2C1FFC6CAC8FFD9DDDBFFBCC1BEFFCACECBFF9599
        97FF989C9AFF808482FF7E8280FF0D0E0D2800000000FFFFFF00FFFFFF00FFFF
        FF00434645089CA09EEEC0C3C2FFC7CBC9FFD6DAD8FFBCC1BEFFC5CAC7FF9499
        96FF959A97FF797D7BFF717573FF474A481E3A3D3B00FFFFFF00FFFFFF00FFFF
        FF004E525008999D9BEEBEC1C0FFC6CAC8FFD5D9D7FFBBC0BDFFC2C6C3FF9498
        95FF959A97FF797C7AFF6C706EFF5458561E575B5900FFFFFF00FFFFFF00FFFF
        FF004C504E08989C9AEEBCC0BEFFC4C8C6FFD5D9D7FFBBC0BDFFBFC4C1FF9397
        95FF959A97FF797C7AFF6D716EFF5256541E53575500FFFFFF00FFFFFF00FFFF
        FF004C504E08989C9AEEBDC0BFFFC6CBC9FFDADEDCFFBBC1BDFFBFC4C1FF9297
        94FF979C99FF7A7D7BFF6D716EFF5256541E53575500FFFFFF00FFFFFF00FFFF
        FF004C514E089A9E9CEEAEB2B0FF9EA3A0FF9CA09EFF929694FF939794FF7579
        76FF787C7AFF6E7270FF6C706EFF5257541E53585500FFFFFF00FFFFFF00FFFF
        FF004B4E4C09848785EEA6A9A8FFB6BAB8FFCFD2D1FFD6D8D7FFC7CAC9FFB3B6
        B5FF999D9BFF828685FF696C6BFF4F52501F50535100FFFFFF00FFFFFF00FFFF
        FF004F52512DADB1AFFFD4D7D5FFE9EBEBFFF4F5F5FFEFF1F0FFE4E7E5FFD5D8
        D7FFC0C4C3FFAAAFADFF8D918FFF5255544B4C4F4E00FFFFFF00FFFFFF00FFFF
        FF005E62603EEDEFEEFFF7F8F8FFEEEFEFFFE0E3E2FFCFD2D1FFC3C8C6FFBDC3
        C1FFBAC0BEFFBAC1BEFFB7BDBBFF5E62605F50545200FFFFFF00FFFFFF00FFFF
        FF002D2E2E10ADAFAED2EAECEBFFE8EBEAFFE2E4E3FF939795FF868B89FFC4C8
        C7FFBDC3C1FFB7BEBBFF909593E45557562354555400FFFFFF00FFFFFF00FFFF
        FF00000000004A4E4B076A6D6B698C908FB6B3B6B4E4ECEEEDFFDCDEDDFFA0A5
        A3EB7A7E7CBA5C605E763F42410D5657570055555500FFFFFF00FFFFFF00FFFF
        FF000000000053565300585B5900474948004E514F16818382A0888C8AAD4549
        47273B3E3C004C4F4E00424443005758580055555500FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
      OnClick = sb_SpeedButton5Click
      SkinData.SkinSection = 'SPEEDBUTTON'
      ExplicitLeft = 563
    end
  end
  object pn_2: TsPanel
    Left = 0
    Top = 0
    Width = 586
    Height = 88
    Align = alTop
    TabOrder = 0
    SkinData.SkinSection = 'BARPANEL'
    DesignSize = (
      586
      88)
    object lb_Label1: TsLabel
      Left = 15
      Top = 13
      Width = 90
      Height = 13
      Caption = 'Campo Busqueda -'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object lb_busca: TsLabel
      Left = 111
      Top = 13
      Width = 42
      Height = 13
      Caption = 'lb_busca'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object sb_busca: TsSpeedButton
      Left = 33
      Top = 52
      Width = 103
      Height = 27
      Caption = 'Buscar'
      Flat = True
      Glyph.Data = {
        C6070000424DC607000000000000360000002800000016000000160000000100
        2000000000009007000000000000000000000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF0098989801686868025050500240404003363636043030
        30052D2D2D0530303005353535043F3F3F034B4B4B036464640293939301FAFA
        FA00FFFFFF00FFFFFF00FFFFFF00FFFFFF002B2B2B051616160A0E0E0E100A0A
        0A160808081C06060621060606260505052B0404042F04040433040404340404
        0433040404300404042C06060628060606220808081D0A0A0A170D0D0D111515
        150B262626066868680130303004191919091010100E0B0B0B140909091A0707
        071F06060624060606280404042C0404042F04040430040404300404042D0505
        052906060625070707200808081B0B0B0B150A0A0A231515150B2A2A2A056E6E
        6E01FFFFFF00FFFFFF00FFFFFF00FFFFFF00ABABAB018B8B8B015E5E5E024F4F
        4F0243434303414141034040400341414103434343034C4C4C035D5D5D028181
        8101A4A4A401131313324E4E4EEA42424291C0C0C000FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF001111112E4C4C
        4CEAABABABFF8585859786868601FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF001212122C3E3E3EE99B9B9BFE7D7D7D8A4545
        4502FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF001414142B343434E8898989FD6B6B6B7867676701FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF001616162A303030E67575
        75FA5E5E5E66BDBDBD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00161616292E2E2EE4656565F653535352FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00C6C6C600191818213231316B413F3F8E3E3D3C8439393850404040071A1A
        1A282D2D2DE3565656F04B4B4B44FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00121212093B39398D837F
        7EF6B6B0B0FFC5BFBEFFBFB9B8FE9C9796F5555353CC505050E84B4B4BEC4444
        4436FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF001B1B1B064D4B4BACC2BDBCFFE3DEDDFFE2DDDCFFE2DC
        DBFFE1DCDBFFE1DBDAFFD8D2D2FB727070E64040405CFFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF0035333362BEBABAFEEBE7E6FFEAE6E6FFE9E5E4FFE8E3E3FFE7E2E1FFE6E2
        E1FFE6E1E0FFE0DBDAF5646262C028282806FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF006F6F6F01737171C6EFED
        ECFFEDEAE9FFEAE6E5FFEAE6E6FFEDE9E9FFEFECEBFFEFECECFFEFECEBFFECE8
        E8FFB1AEAEEB4241413AFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF003C3C3C0C9D9C9BE8EEEBEBFFEDE9E9FFF1EF
        EEFFF4F2F1FFF3F1F1FFF3F1F1FFF3F1F1FFF3F1F1FFF3F1F1FFDBD9D9E6605F
        5F66FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF006361610DA19F9FDFF1EEEEFFF4F1F1FFF7F6F5FFF7F5F5FFF7F5
        F5FFF7F5F5FFF7F5F5FFF7F5F5FFF7F5F5FFDEDCDBC174747468FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B6B1
        B1017F7E7EA7F4F3F2F8F8F6F6FFFAF9F9FFF9F9F9FFF9F9F8FFF9F9F8FFF9F8
        F8FFF9F8F8FFF4F3F2FFB1AFAFA395949441FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0083828264BCBB
        BBADF9F7F7FFFAFAFAFFFBFBFBFFFBFBFAFFFAFAF9FFF8F7F7FFF5F3F3FFECEA
        E9D086868694CECECE09FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C5C3C30A84838391C3C3C3A6FBFB
        FBF8FAFAFAFFFAF9F9FFF9F8F8FFF8F7F7FFEDECECC981818199C6C6C63DFFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00DEDEDE129D9D9D858080809AB4B4B4AAD5D5
        D5B3C6C6C6AE9190909D85858599D4D4D43FFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FEFEFE02EDEDED2DBCBCBC679F9F9F7EAAAAAA75DBDB
        DB49FCFCFC0DFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00}
      OnClick = sb_buscaClick
      SkinData.SkinSection = 'SPEEDBUTTON'
    end
    object sb_ok: TsSpeedButton
      Left = 473
      Top = 18
      Width = 107
      Height = 28
      Anchors = [akTop, akRight]
      Caption = 'Aceptar (F1)'
      Flat = True
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
      OnClick = sb_okClick
      SkinData.SkinSection = 'SPEEDBUTTON'
      ExplicitLeft = 518
    end
    object sb_SpeedButton3: TsSpeedButton
      Left = 473
      Top = 46
      Width = 107
      Height = 28
      Anchors = [akTop, akRight]
      Caption = 'Cancelar (ESC)'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        00261D1D84A90505395C00000000000000000000000000000000000000000000
        00000000000000000000090944691C1C7EA50000001C00000000000015290000
        9CCF4949F3FF1313D1F700004267000000000000000000000000000000000000
        00000000000100004F781818D4FC4141EEFF00008CC20000001D000077990F0F
        E5FF5B5BF7FF5F5FF3FF0505D0FC00004D780000000000000000000000000000
        000600005E8B0A0AD5FF6D6DF2FF6D6DF6FF1111DFFF00006081090998AD3131
        FEFF4949FFFF6C6CFFFF5D5DF0FF0A0AD0FF00005888000000020000000B0000
        6A9D0F0FD6FF6D6DF0FF8585FFFF6868FFFF4848FDFF0C0C7D950D0D846B2B2B
        FFFF3B3BFFFF4B4BFFFF6969FFFF5858EFFF0A0ACEFF00005F99000070AA1111
        D4FF6767F0FF7C7CFFFF6363FFFF5353FFFF4444FFFE15156854000000001111
        8A702C2CFFFF3B3BFFFF4747FFFF5D5DFFFF4949ECFF0303C6FF0C0CCAFF5656
        F0FF6B6BFFFF5A5AFFFF5050FFFF4040FAF61818745900000000000000000000
        00000F0F7A5F2727FCF94040FFFF4E4EFFFF6161FFFF4242ECFF4949F0FF5E5E
        FFFF4A4AFFFF4343FFFF3737F3EC12125F460000000000000000000000000000
        0000000000000C0C66494F4FEFEA7474FFFF7373FFFF7373FFFF7575FFFF7575
        FFFF6E6EFFFF3939E4D90A0A4B31000000000000000000000000000000000000
        0000000000000000001D09099AD74F4FF6FF7676FFFF7676FFFF7777FFFF7777
        FFFF4848F0FF090979B700000008000000000000000000000000000000000000
        000000000029000070D00000B3FF4242F4FF7D7DFFFF7C7CFFFF7C7CFFFF7B7B
        FFFF3030EAFF0000A7FF000055AD0000000F0000000000000000000000000000
        0A2B00006AD40000B2FF4949F5FF8B8BFFFF8A8AFFFF8B8BFFFF8B8BFFFF8A8A
        FFFF8686FFFF3636EAFF0000A2FF00004FAD00000010000000000000001B0000
        64D20000ABFF5454F4FF9A9AFFFF9999FFFF9898FFFF4141CABC5B5BE0D49D9D
        FFFF9898FFFF9595FFFF3A3AE8FF00009BFF00004BA400000005000025490000
        ABFF5C5CF4FFAAAAFFFFA8A8FFFFA8A8FFFF4949C5B200000006000036216969
        E5DBACACFFFFA8A8FFFFA3A3FFFF4040EAFF00008CF20000001900003D456868
        FEFFBBBBFFFFB6B6FFFFB5B5FFFF4E4EC3B20000000900000000000000000000
        39257272E5DBBBBBFFFFB6B6FFFFB6B6FFFF4444E2F4000000160000000D5656
        C5AEC6C6FFFFC6C6FFFF5151C4B0000000090000000000000000000000000000
        0000000039257B7BE5DBD1D1FFFFB2B2FFFF3333987800000002000000000000
        00064F4FC6A95454CCAD00000007000000000000000000000000000000000000
        000000000000000039256B6BE6CC2B2B8E720000000000000000}
      OnClick = sb_SpeedButton3Click
      SkinData.SkinSection = 'SPEEDBUTTON'
      ExplicitLeft = 518
    end
    object rg_int: TsRadioGroup
      Left = 347
      Top = 5
      Width = 110
      Height = 77
      Caption = 'Condiciones'
      ParentBackground = False
      TabOrder = 5
      SkinData.SkinSection = 'GROUPBOX'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        '='
        '>'
        '<'
        '>='
        '<='
        '<>')
    end
    object rg_ord: TsRadioGroup
      Left = 160
      Top = 5
      Width = 100
      Height = 77
      Caption = 'Orden'
      ParentBackground = False
      TabOrder = 2
      SkinData.SkinSection = 'GROUPBOX'
      ItemIndex = 0
      Items.Strings = (
        'Ascendente'
        'Descendente')
    end
    object ed_busca: TsEdit
      Left = 13
      Top = 28
      Width = 141
      Height = 21
      ParentFont = False
      TabOrder = 0
      OnKeyPress = ed_buscaKeyPress
      OnKeyUp = ed_buscaKeyUp
      SkinData.SkinSection = 'EDIT'
    end
    object rg_str: TsRadioGroup
      Left = 347
      Top = 5
      Width = 110
      Height = 77
      Caption = 'Condiciones'
      ParentBackground = False
      TabOrder = 4
      SkinData.SkinSection = 'GROUPBOX'
      ItemIndex = 1
      Items.Strings = (
        'Empieza Por'
        'Contiene A'
        'Acaba Por')
    end
    object rg_con: TsRadioGroup
      Left = 266
      Top = 5
      Width = 75
      Height = 77
      Caption = 'Concat'
      ParentBackground = False
      TabOrder = 3
      SkinData.SkinSection = 'GROUPBOX'
      ItemIndex = 0
      Items.Strings = (
        'Nuevo'
        'Y'
        'O')
    end
    object ed_date: TsDateEdit
      Left = 39
      Top = 28
      Width = 92
      Height = 21
      AutoSize = False
      EditMask = '!99/99/9999;1; '
      MaxLength = 10
      ParentFont = False
      TabOrder = 1
      Text = '27/04/2004'
      SkinData.SkinSection = 'EDIT'
      Date = 38104.000000000000000000
    end
  end
end
