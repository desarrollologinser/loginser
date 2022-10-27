object Main: TMain
  Left = 0
  Top = 0
  Caption = 'Almacenaje v1.0'
  ClientHeight = 270
  ClientWidth = 401
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object status: TsStatusBar
    Left = 0
    Top = 251
    Width = 401
    Height = 19
    Panels = <>
    object lgsdb: TsLabel
      Left = 3
      Top = 0
      Width = 29
      Height = 15
      Caption = 'lgsdb'
    end
  end
  object pnlPrin: TsPanel
    Left = 0
    Top = 0
    Width = 401
    Height = 251
    Align = alClient
    TabOrder = 1
    object btnCliente: TsSpeedButton
      Left = 162
      Top = 24
      Width = 23
      Height = 22
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000003300000033000000330000000B00000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000334780ABFF487FAAFF4881ACFF0F1C255E00000000000000000000
        0000000000000000001A00000031000000330000003300000033000000300000
        00333E81B3FF739DBFFF1FADFFFF407C98AD4491C6FF00000000000000000000
        00000000002E4140409C797776F97B7A78FF7B7978FF7B7978FF787471F25B7D
        97FFA29A92FFAFA39BFFA0C2D8FFB0ECFFFF3F90C6FF00000000000000000000
        002E737270EA9C9D9DFFD1D3D5FFE3E5EAFFE2E4E9FFE3E4E9FFD1D1D3FF9C9A
        9AFF83807DFFC6C2BDFFF4EBE4FFBFDEEAFF3F92CAFF000000000000001A7473
        72EAB4B3B6FFE6E4DFFFE9CD9AFFF1CA7EFFF5D388FFF9DA8DFFF2E1ADFFE6E5
        E0FFB0AEB0FF908B8AFFEDE3DBFF368FCAFF00000000000000004544439BA2A1
        A2FFEBE6E2FFE9BB75FFECC47CFFF1D089FFF5DA94FFFAE39CFFFDE89EFFFBE3
        9BFFEBE8E3FFA09C9CFF5B87A5FF000000000000000000000000817F7EF9DCDF
        E1FFE6C28FFFEBC48AFFEED097FFF1D28EFFF5DD98FFFBEAA2FFFFF1A9FFFCE8
        9DFFF5E2AEFFDBDCDEFF7E7977F2000000000000000000000000858482FFF4F8
        FCFFE1A95DFFF3DBB7FFF1D9ACFFF2D9A0FFF5DC96FFF8E59EFFFBEAA2FFF9E3
        9CFFF7D98BFFF3F4FAFF858382FF000000000000000000000000888584FFF7FC
        FFFFDEA458FFF6E8D1FFF3DFBBFFF3DCADFFF4DCA3FFF5DC97FFF5DD98FFF4DA
        93FFF3D186FFF5F9FFFF888584FF0000000000000000000000008A8886FFFDFF
        FFFFDC9E53FFF6E7D4FFF6E6CDFFF4DFBAFFF3DCADFFF2D99FFFF1D28DFFF0CF
        89FFEEC87BFFFBFDFFFF8A8786FF000000000000000000000000898685F8EAED
        F1FFE5B988FFECCCA3FFF9F1E5FFF6E6CCFFF3DFBBFFF1D9ACFFEFD097FFEBC3
        7BFFF0D3A1FFE9EBF0FF888684F80000000000000000000000004C4A4983B3B2
        B2FFFEFAF5FFDBA058FFECCBA2FFF9ECDCFFF6E7D0FFF2DDBBFFECC995FFE7B9
        72FFFFFDF9FFB2B1B2FF4C4A4983000000000000000000000000000000008381
        80E5CDCDCFFFFFFDFAFFE7BC8AFFDA9C51FFDDA256FFDEA65AFFECC896FFFFFF
        FCFFCCCCCEFF838080E500000000000000000000000000000000000000000000
        0000858381E5B8B8B9FFF5F8FCFFFFFFFFFFFFFFFFFFFFFFFFFFF5F7FCFFB8B7
        B9FF858281E50000000000000000000000000000000000000000000000000000
        0000000000004F4D4C83918E8DF7959391FF959291FF959291FF918E8DF74F4D
        4C83000000000000000000000000000000000000000000000000}
      OnClick = btnClienteClick
      SkinData.SkinSection = 'SPEEDBUTTON'
    end
    object lblCliente: TsLabel
      Left = 200
      Top = 27
      Width = 84
      Height = 13
      Caption = 'Seleccione cliente'
    end
    object chkAlmacen: TsCheckListBox
      Left = 40
      Top = 67
      Width = 145
      Height = 78
      BorderStyle = bsSingle
      Columns = 2
      ExtendedSelect = False
      Items.Strings = (
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7')
      TabOrder = 0
      Visible = False
      BoundLabel.Active = True
      BoundLabel.Caption = 'Almac'#233'n'
      BoundLabel.Layout = sclTopLeft
      SkinData.SkinSection = 'EDIT'
    end
    object chkEstanteria: TCheckBox
      Left = 40
      Top = 151
      Width = 97
      Height = 17
      Caption = 'Estanteria Z'
      TabOrder = 1
      Visible = False
    end
    object edtCliente: TsEdit
      Left = 40
      Top = 24
      Width = 116
      Height = 21
      AutoSelect = False
      NumbersOnly = True
      TabOrder = 2
      OnChange = edtClienteChange
      BoundLabel.Active = True
      BoundLabel.Caption = 'Cliente'
      BoundLabel.Layout = sclTopLeft
    end
    object dtDesde: TsDateEdit
      Left = 252
      Top = 67
      Width = 116
      Height = 21
      AutoSize = False
      EditMask = '!99/99/9999;1; '
      MaxLength = 10
      TabOrder = 3
      BoundLabel.Active = True
      BoundLabel.Caption = 'Fecha Inicio'
      DefaultToday = True
    end
    object dtHasta: TsDateEdit
      Left = 252
      Top = 107
      Width = 116
      Height = 21
      AutoSize = False
      EditMask = '!99/99/9999;1; '
      MaxLength = 10
      TabOrder = 4
      BoundLabel.Active = True
      BoundLabel.Caption = 'Fecha Fin'
      DefaultToday = True
    end
    object btnGenerar: TsButton
      Left = 265
      Top = 147
      Width = 73
      Height = 25
      Caption = 'Generar'
      TabOrder = 5
      Visible = False
      OnClick = btnGenerarClick
    end
    object btnLineas: TsButton
      Left = 132
      Top = 226
      Width = 75
      Height = 25
      Caption = 'btnLineas'
      TabOrder = 6
      Visible = False
      OnClick = btnLineasClick
    end
    object btnDoble: TsButton
      Left = 3
      Top = 226
      Width = 75
      Height = 25
      Caption = 'btnDoble'
      TabOrder = 7
      Visible = False
      OnClick = btnDobleClick
    end
    object btnPrueba: TsButton
      Left = 91
      Top = 226
      Width = 75
      Height = 25
      Caption = 'prueba'
      TabOrder = 8
      Visible = False
    end
    object btnprocesarTodo: TsButton
      Left = 51
      Top = 226
      Width = 75
      Height = 25
      Caption = 'prueba todo'
      TabOrder = 9
      Visible = False
      OnClick = btnprocesarTodoClick
    end
    object chkTodos: TsCheckBox
      Left = 91
      Top = 47
      Width = 112
      Height = 17
      Caption = 'Todos los clientes'
      TabOrder = 10
    end
    object btnProcesaTodo: TsButton
      Left = 40
      Top = 79
      Width = 75
      Height = 35
      Caption = 'Boton para  Generar'
      TabOrder = 11
      OnClick = btnProcesaTodoClick
    end
    object edtIDCliente: TsEdit
      Left = 252
      Top = 24
      Width = 116
      Height = 21
      AutoSelect = False
      NumbersOnly = True
      TabOrder = 12
      Visible = False
      BoundLabel.Active = True
      BoundLabel.Caption = 'Cliente'
      BoundLabel.Layout = sclTopLeft
    end
    object btnMerydeis: TsButton
      Left = 40
      Top = 120
      Width = 75
      Height = 25
      Caption = 'Merydeis'
      TabOrder = 13
      OnClick = btnMerydeisClick
    end
    object btnResumen: TsButton
      Left = 40
      Top = 151
      Width = 75
      Height = 51
      Caption = 'Resumen por grupo Merydeis'
      TabOrder = 14
      OnClick = btnResumenClick
    end
  end
  object sk_manager: TsSkinManager
    ExtendedBorders = True
    InternalSkins = <>
    SkinDirectory = 'C:\LGS\Resources\Skins'
    SkinInfo = 'N/A'
    SkinningRules = [srStdForms, srStdDialogs]
    ThirdParty.ThirdEdits = ' '#13#10
    ThirdParty.ThirdButtons = 'TButton'#13#10
    ThirdParty.ThirdBitBtns = ' '#13#10
    ThirdParty.ThirdCheckBoxes = ' '#13#10
    ThirdParty.ThirdGroupBoxes = ' '#13#10
    ThirdParty.ThirdListViews = ' '#13#10
    ThirdParty.ThirdPanels = ' '#13#10
    ThirdParty.ThirdGrids = ' '#13#10
    ThirdParty.ThirdTreeViews = ' '#13#10
    ThirdParty.ThirdComboBoxes = ' '#13#10
    ThirdParty.ThirdWWEdits = ' '#13#10
    ThirdParty.ThirdVirtualTrees = ' '#13#10
    ThirdParty.ThirdGridEh = ' '#13#10
    ThirdParty.ThirdPageControl = ' '#13#10
    ThirdParty.ThirdTabControl = ' '#13#10
    ThirdParty.ThirdToolBar = ' '#13#10
    ThirdParty.ThirdStatusBar = ' '#13#10
    ThirdParty.ThirdSpeedButton = ' '#13#10
    ThirdParty.ThirdScrollControl = ' '#13#10
    ThirdParty.ThirdUpDown = ' '#13#10
    ThirdParty.ThirdScrollBar = ' '#13#10
    ThirdParty.ThirdStaticText = ' '#13#10
    ThirdParty.ThirdNativePaint = ' '#13#10
    Left = 120
    Top = 200
  end
  object sknprvdr1: TsSkinProvider
    MakeSkinMenu = True
    AddedTitle.Font.Charset = DEFAULT_CHARSET
    AddedTitle.Font.Color = clNone
    AddedTitle.Font.Height = -11
    AddedTitle.Font.Name = 'Tahoma'
    AddedTitle.Font.Style = []
    SkinData.SkinSection = 'FORM'
    TitleButtons = <>
    Left = 176
    Top = 200
  end
  object ruta: TsPathDialog
    Root = 'rfDesktop'
    Left = 352
    Top = 128
  end
  object qry_1: TpFIBDataSet
    Left = 392
    Top = 48
  end
end
