object Form5: TForm5
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Sincronizar'
  ClientHeight = 368
  ClientWidth = 349
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 16
    Top = 16
    Width = 91
    Height = 16
    Caption = 'Transmitiendo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object mmo1: TMemo
    Left = 16
    Top = 56
    Width = 313
    Height = 233
    TabOrder = 0
  end
  object btn1: TButton
    Left = 158
    Top = 328
    Width = 75
    Height = 25
    Caption = 'Sincronizar'
    TabOrder = 1
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 62
    Top = 328
    Width = 75
    Height = 25
    Caption = 'Tabla'
    Enabled = False
    TabOrder = 2
    Visible = False
    OnClick = btn2Click
  end
  object pb: TProgressBar
    Left = 36
    Top = 305
    Width = 277
    Height = 17
    TabOrder = 3
    Visible = False
  end
  object btn3: TButton
    Left = 266
    Top = 328
    Width = 75
    Height = 25
    Caption = 'Salir'
    TabOrder = 4
    OnClick = btn3Click
  end
end
