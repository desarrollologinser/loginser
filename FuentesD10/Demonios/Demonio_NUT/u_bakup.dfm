object f_bakup: Tf_bakup
  Left = 0
  Top = 0
  Caption = 'f_bakup'
  ClientHeight = 254
  ClientWidth = 248
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
    Top = 13
    Width = 74
    Height = 13
    Caption = 'BakUp Task Idx'
  end
  object lbl_2: TLabel
    Left = 8
    Top = 45
    Width = 30
    Height = 13
    Caption = 'Result'
  end
  object bt_2: TButton
    Left = 148
    Top = 8
    Width = 92
    Height = 25
    Caption = 'BakUp'
    TabOrder = 0
    OnClick = bt_2Click
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
    Top = 64
    Width = 232
    Height = 182
    TabOrder = 2
  end
end
