object f_main: Tf_main
  Left = 0
  Top = 0
  Caption = 'Demonios'
  ClientHeight = 448
  ClientWidth = 670
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object grp1: TGroupBox
    Left = 454
    Top = 229
    Width = 217
    Height = 215
    Caption = 'Bankia'
    TabOrder = 0
    object mm1: TMemo
      Left = 16
      Top = 141
      Width = 186
      Height = 57
      Lines.Strings = (
        'mm1')
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object btEstados: TsButton
      Left = 16
      Top = 101
      Width = 187
      Height = 34
      Caption = 'Estados Albaranes'
      Enabled = False
      TabOrder = 1
      OnClick = btEstadosClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btAdjuntos: TsButton
      Left = 16
      Top = 61
      Width = 187
      Height = 34
      Caption = 'Adjuntos Albaranes'
      TabOrder = 2
      OnClick = btAdjuntosClick
      SkinData.SkinSection = 'BUTTON'
    end
    object bt_2: TsButton
      Left = 16
      Top = 21
      Width = 187
      Height = 34
      Caption = 'Enviar Listados'
      TabOrder = 3
      OnClick = bt_2Click
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object grp2: TGroupBox
    Left = 8
    Top = 229
    Width = 217
    Height = 215
    Caption = 'Ficheros Clientes'
    TabOrder = 1
    object mm2: TMemo
      Left = 16
      Top = 141
      Width = 186
      Height = 57
      Lines.Strings = (
        'mm1')
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object sButton2: TsButton
      Left = 17
      Top = 61
      Width = 187
      Height = 34
      Caption = 'Stock El Paeller'
      Enabled = False
      TabOrder = 1
      OnClick = btAdjuntosClick
      SkinData.SkinSection = 'BUTTON'
    end
    object sButton3: TsButton
      Left = 16
      Top = 21
      Width = 187
      Height = 34
      Caption = 'Sent/Delivered Oxfam'
      Enabled = False
      TabOrder = 2
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object grp3: TGroupBox
    Left = 8
    Top = 8
    Width = 217
    Height = 215
    Caption = 'Sistema'
    TabOrder = 2
    object mm3: TMemo
      Left = 16
      Top = 108
      Width = 186
      Height = 90
      Lines.Strings = (
        'mm1')
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object sButton4: TsButton
      Left = 16
      Top = 21
      Width = 187
      Height = 34
      Caption = 'Sync Clientes'
      TabOrder = 1
      OnClick = sButton4Click
      SkinData.SkinSection = 'BUTTON'
    end
    object sButton5: TsButton
      Left = 16
      Top = 61
      Width = 187
      Height = 34
      Caption = 'Sync Art'#237'culos'
      TabOrder = 2
      OnClick = sButton5Click
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object grp4: TGroupBox
    Left = 231
    Top = 229
    Width = 217
    Height = 215
    Caption = 'Almac'#233'n'
    TabOrder = 3
    object mm4: TMemo
      Left = 16
      Top = 141
      Width = 186
      Height = 57
      Lines.Strings = (
        'mm1')
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object sButton1: TsButton
      Left = 16
      Top = 21
      Width = 187
      Height = 34
      Caption = 'Revisar Stock Hist'#243'rico'
      TabOrder = 1
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object gbDemonios: TGroupBox
    Left = 231
    Top = 8
    Width = 440
    Height = 215
    Caption = 'Seleccionar demonio'
    TabOrder = 4
    object mmClientes: TMemo
      Left = 16
      Top = 108
      Width = 409
      Height = 90
      Lines.Strings = (
        'mm1')
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object sButton6: TsButton
      Left = 16
      Top = 61
      Width = 409
      Height = 34
      Caption = 'Controles Diarios'
      TabOrder = 1
      OnClick = sButton6Click
      SkinData.SkinSection = 'BUTTON'
    end
    object sComboBox1: TsComboBox
      Left = 16
      Top = 27
      Width = 409
      Height = 21
      ItemIndex = -1
      TabOrder = 2
      Text = 'sComboBox1'
    end
  end
  object tm_1: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = tm_1Timer
    Left = 166
    Top = 8
  end
end
