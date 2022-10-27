object f_listados: Tf_listados
  Left = 0
  Top = 0
  Caption = 'Listados'
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
    Width = 83
    Height = 13
    Caption = 'Listados Task Idx'
  end
  object lbl_2: TLabel
    Left = 8
    Top = 45
    Width = 30
    Height = 13
    Caption = 'Result'
  end
  object bt_2: TButton
    Left = 147
    Top = 8
    Width = 92
    Height = 25
    Caption = 'Listados'
    TabOrder = 0
    OnClick = bt_2Click
  end
  object ed_1: TEdit
    Left = 97
    Top = 8
    Width = 44
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
  object ftp: TIdFTP
    IPVersion = Id_IPv4
    ConnectTimeout = 0
    Password = 'xzj2004MN4+'
    Username = 'u62588198-app'
    NATKeepAlive.UseKeepAlive = False
    NATKeepAlive.IdleTimeMS = 0
    NATKeepAlive.IntervalMS = 0
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    ServerHOST = 'home361541350.1and1-data.host'
    Left = 176
    Top = 48
  end
end
