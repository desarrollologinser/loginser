object f_arts_relaciones: Tf_arts_relaciones
  Left = 0
  Top = 0
  Caption = 'Relaci'#243'n de Art'#237'culos'
  ClientHeight = 287
  ClientWidth = 823
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  DesignSize = (
    823
    287)
  PixelsPerInch = 96
  TextHeight = 13
  object sGroupBox1: TsGroupBox
    Left = 8
    Top = 8
    Width = 809
    Height = 271
    Anchors = [akLeft]
    TabOrder = 0
    SkinData.SkinSection = 'GROUPBOX'
    object lbArtRel: TsLabel
      Left = 15
      Top = 20
      Width = 578
      Height = 13
      AutoSize = False
      Caption = 'Art'#237'culo'
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      UseSkinColor = False
    end
    object bpArtRel: TsSpeedButton
      Left = 132
      Top = 38
      Width = 30
      Height = 24
      Hint = 'Busca Y Asigna'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000262626020E0E
        0E0412121200535353053E3C3D1F2C2B2B102424251021212111242424112C2C
        2C0E3737370D6060600A30303007060606031919190258585801252728050B0F
        0B031502052C561316A059151AB00000002B000000270000002C0000002C0000
        002700000029000000220404041708080810171717065B5B5B02322E2E0A5E03
        0873901117E2BB1B1AFFA42025E688252CCD88252ACF88252ACA88252ACB852A
        2CBA414641205E5C5D0034343429414141C33B3B3B485F5F5F006350381BB012
        16B6AD3035FFA93F47FFA92C34F7AC2D34FFAD2E34FFAD2E34FFAD2E34FFB12F
        36F43F494217393B3D194E4E4ED3969696E27A7A7A35888888003D845500AC1A
        1709B82C295EB45B5CDCA14446D9A82A2F5CAC2C3252AC2D3350AC2D33539B3E
        404224201725353739D6848484D2616161265D5D5D008B8B8B004C955B007C56
        3E00BB332D00BB56511FA85749388741380073473F00754D43004E4339001918
        180E3B3A3AD86B6B6BCA6868681E5B5B5B00616161008B8B8B00505533004657
        3A004E6042005B6D5100506346152F302E3B2726282A2C2B2D001112131C2E2F
        30D4585859BB57575714686868005D5D5D00616161008B8B8B00090E14000A0F
        150003080E0B3C3D428A7A7A7FD8A59FA0EE969190E15D5B5BA53C3C3DCC4849
        49AB4C4C4C0C585858006D6D6D00606060006464640090909000333333002020
        20085E5C5CA7D6D1D1FFEBE6E5FFEAE3E3FFE7E2E1FFDBD6D5FF7F7C7CDF3939
        39293E3E3E0048484800565656004D4D4D00505050006F6F6F00797979005E5D
        5D51C7C4C4FCF4F0EFFFEAE6E5FFEBE7E7FFECE8E7FFF1EEECFFDCD8D7FE5655
        55752B2B2B00323131003030300031313100313030002E2E2E003C3C3C007170
        7086E9E7E6FFF1EEEEFFF2EFEEFFF3F0F0FFF3F1F1FFF4F2F2FFF8F6F6FF9594
        94A4525252075D5C5C005D5C5C005D5C5C005D5C5C005D5C5C007D7A7A008785
        8575E7E5E5FFFAF8F7FFF8F7F7FFF8F7F6FFF8F7F6FFFAF8F8FFF4F3F2F6A1A0
        A087767676097D7C7C007D7C7C007D7C7C007D7C7C007D7C7C00C1BCBC009693
        933DBFBEBECDFFFEFEFFFEFEFEFFFCFCFBFFFCFCFBFFFFFEFEFFD2D0CFDCA3A2
        A250C0BFBF01BCBCBC00BCBCBC00BCBCBC00BCBCBC00BCBCBC00C4C2C200C2BF
        BF029E9D9D69C4C4C4CDEAEAEAF6F9F8F8F6EBEBEAF5D0CFCFDCA3A3A27FCACA
        CA13D4D4D400D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200C5C3C300C5C3
        C300DBDBDB08BDBDBD50AFAFAF83BBBBBBA2B2B2B28CB5B5B55DD0D0D016CACA
        CA00CFCFCF00CECECE00CECECE00CECECE00CECECE00CECECE00C5C3C300C3C1
        C100E2E2E200E9E9E918BFBFBF4FA2A2A271B6B6B65AE0E0E022D6D6D601C9C9
        C900CFCFCF00CECECE00CECECE00CECECE00CECECE00CECECE00}
      ParentShowHint = False
      ShowHint = True
      Visible = False
      OnClick = bpArtRelClick
      SkinData.SkinSection = 'SPEEDBUTTON'
    end
    object lb_art_rel: TsLabel
      Left = 168
      Top = 45
      Width = 633
      Height = 13
      AutoSize = False
      Caption = 'Art'#237'culo'
      ParentFont = False
      Visible = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      UseSkinColor = False
    end
    object JvDBGrid1: TJvDBGrid
      Left = 15
      Top = 66
      Width = 786
      Height = 197
      DataSource = dm.ds_arts_rel
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      SelectColumnsDialogStrings.Caption = 'Select columns'
      SelectColumnsDialogStrings.OK = '&OK'
      SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
      EditControls = <>
      RowsHeight = 17
      TitleRowHeight = 17
      Columns = <
        item
          Expanded = False
          FieldName = 'COD_ART_REL'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOM_ART_REL'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ID_ART_RELACIONADO'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FECHA_CREACION'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ESTADO'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FECHA_BAJA'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ID_ARTICULO'
          Visible = True
        end>
    end
    object nav_art_rel: TJvDBNavigator
      Left = 636
      Top = 19
      Width = 165
      Height = 25
      DataSource = dm.ds_arts_rel
      VisibleButtons = [nbInsert, nbDelete, nbPost, nbCancel, nbRefresh]
      TabOrder = 1
      BeforeAction = nav_art_relBeforeAction
    end
    object edArtRel: TsEdit
      Left = 15
      Top = 40
      Width = 111
      Height = 21
      NumbersOnly = True
      ParentFont = False
      TabOrder = 2
      Visible = False
      SkinData.SkinSection = 'EDIT'
      BoundLabel.ParentFont = False
      BoundLabel.Caption = 'Cantidad'
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clBlack
      BoundLabel.Font.Height = -11
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = []
      BoundLabel.Layout = sclTopLeft
    end
  end
end
