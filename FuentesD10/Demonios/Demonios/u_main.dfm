object f_main: Tf_main
  Left = 0
  Top = 0
  Caption = 'Demonios'
  ClientHeight = 365
  ClientWidth = 454
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
  object gbDemonios: TGroupBox
    Left = 8
    Top = 8
    Width = 440
    Height = 353
    Caption = 'Seleccionar demonio'
    TabOrder = 0
    object lbProx: TLabel
      Left = 16
      Top = 308
      Width = 35
      Height = 16
      Caption = 'lbProx'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbIntervalo: TLabel
      Left = 16
      Top = 325
      Width = 17
      Height = 16
      Caption = 'lb1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object mm: TMemo
      Left = 16
      Top = 101
      Width = 409
      Height = 191
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object btEjecuta: TsButton
      Left = 16
      Top = 60
      Width = 409
      Height = 34
      Caption = '&Ejecutar'
      Enabled = False
      TabOrder = 1
      OnClick = btEjecutaClick
      SkinData.SkinSection = 'BUTTON'
    end
    object cbLista: TDBLookupComboBox
      Left = 16
      Top = 33
      Width = 409
      Height = 21
      DropDownRows = 15
      KeyField = 'ID_DEMONIO'
      ListField = 'DESCRIPCION'
      ListSource = dm.dsDemonios
      TabOrder = 2
      OnClick = cbListaClick
    end
  end
  object gb_d10: TGroupBox
    Left = 8
    Top = 367
    Width = 440
    Height = 74
    Caption = 'Par'#225'metros'
    TabOrder = 1
    object lb1: TLabel
      Left = 16
      Top = 20
      Width = 44
      Height = 13
      Caption = 'Fecha Ini'
    end
    object lb2: TLabel
      Left = 16
      Top = 44
      Width = 46
      Height = 13
      Caption = 'Fecha Fin'
    end
    object edFIni: TDateTimePicker
      Left = 65
      Top = 16
      Width = 96
      Height = 21
      Date = 44641.631009155090000000
      Time = 44641.631009155090000000
      TabOrder = 0
    end
    object edFFin: TDateTimePicker
      Left = 65
      Top = 43
      Width = 96
      Height = 21
      Date = 44642.438809317130000000
      Time = 44642.438809317130000000
      ParentShowHint = False
      ShowHint = False
      TabOrder = 1
    end
  end
  object tm_1: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = tm_1Timer
    Left = 406
    Top = 16
  end
end
