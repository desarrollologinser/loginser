object f_estados: Tf_estados
  Left = 0
  Top = 0
  Caption = 'Estados'
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
    Left = 148
    Top = 8
    Width = 92
    Height = 25
    Caption = 'Estados'
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
    ServerHOST = 'www.loginser.com'
    Left = 176
    Top = 48
  end
  object FileStore: TScFileStorage
    Left = 152
    Top = 176
  end
  object ssh: TScSSHClient
    HostName = 'ftpst.lqs.es'
    User = 'LOGINSER'
    Password = 'ElpcU0206'
    KeyStorage = FileStore
    Left = 104
    Top = 184
  end
  object client: TScSFTPClient
    SSHClient = ssh
    Left = 48
    Top = 176
  end
  object ScSSLClient1: TScSSLClient
    Storage = FileStore
    Left = 80
    Top = 120
  end
end
