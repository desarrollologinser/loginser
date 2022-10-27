object f_envia_mail: Tf_envia_mail
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Enviando Email'
  ClientHeight = 133
  ClientWidth = 213
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
  object lb_2: TsLabel
    Left = 52
    Top = 18
    Width = 109
    Height = 13
    Caption = 'Direcciones De Destino'
  end
  object lb_1: TsLabel
    Left = 57
    Top = 113
    Width = 99
    Height = 13
    Caption = 'Espere, Por Favor...'
  end
  object lb_dest: TsListBox
    Left = 8
    Top = 37
    Width = 196
    Height = 70
    ItemHeight = 13
    ParentFont = False
    TabOrder = 0
    SkinData.SkinSection = 'EDIT'
  end
  object smtp_1: TIdSMTP
    SASLMechanisms = <>
    Left = 168
    Top = 45
  end
  object sknprvdr1: TsSkinProvider
    MakeSkinMenu = True
    TitleSkin = 'FORMTITLE'
    AddedTitle.Font.Charset = DEFAULT_CHARSET
    AddedTitle.Font.Color = clNone
    AddedTitle.Font.Height = -11
    AddedTitle.Font.Name = 'Tahoma'
    AddedTitle.Font.Style = []
    SkinData.SkinSection = 'FORM'
    TitleButtons = <>
    Left = 111
    Top = 45
  end
end
