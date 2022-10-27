object f_controles: Tf_controles
  Left = 0
  Top = 0
  Caption = 'Clientes'
  ClientHeight = 287
  ClientWidth = 327
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lbl_1: TLabel
    Left = 8
    Top = 39
    Width = 4
    Height = 13
    Caption = '-'
  end
  object lbl_3: TLabel
    Left = 8
    Top = 58
    Width = 4
    Height = 13
    Caption = '-'
  end
  object lbl_11: TLabel
    Left = 8
    Top = 13
    Width = 65
    Height = 13
    Caption = 'Proc Task Idx'
  end
  object lbl_2: TLabel
    Left = 8
    Top = 80
    Width = 30
    Height = 13
    Caption = 'Result'
  end
  object bt_1: TButton
    Left = 147
    Top = 8
    Width = 174
    Height = 25
    Caption = 'Sync Controles'
    TabOrder = 0
    OnClick = bt_1Click
  end
  object ed_1: TEdit
    Left = 88
    Top = 8
    Width = 53
    Height = 21
    TabOrder = 1
    Text = '1'
  end
  object me_1: TMemo
    Left = 8
    Top = 99
    Width = 311
    Height = 182
    TabOrder = 2
  end
end
