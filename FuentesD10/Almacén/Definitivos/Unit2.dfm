object Form2: TForm2
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Entregar'
  ClientHeight = 500
  ClientWidth = 794
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
  object btn1: TButton
    Left = 520
    Top = 463
    Width = 161
    Height = 25
    Caption = 'Realizar entrega solicitada'
    TabOrder = 1
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 702
    Top = 463
    Width = 75
    Height = 25
    Caption = 'Salir'
    TabOrder = 0
    OnClick = btn2Click
  end
end
