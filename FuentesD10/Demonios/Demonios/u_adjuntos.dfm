object f_adjuntos: Tf_adjuntos
  Left = 0
  Top = 0
  Caption = 'FTP Adjuntos Albaran'
  ClientHeight = 261
  ClientWidth = 254
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
  object btn_2: TButton
    Left = 148
    Top = 8
    Width = 92
    Height = 25
    Caption = 'Procesar'
    TabOrder = 0
    OnClick = btn_2Click
  end
  object ed_1: TEdit
    Left = 97
    Top = 8
    Width = 44
    Height = 21
    TabOrder = 1
    Text = '1'
  end
  object mm_1: TMemo
    Left = 8
    Top = 64
    Width = 232
    Height = 182
    Lines.Strings = (
      ' ')
    TabOrder = 2
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    Destination = ':990'
    MaxLineAction = maException
    Port = 990
    DefaultPort = 0
    ReadTimeout = 60000
    SSLOptions.Method = sslvSSLv23
    SSLOptions.SSLVersions = []
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 136
    Top = 64
  end
  object IdFTP1: TIdFTP
    IOHandler = IdSSLIOHandlerSocketOpenSSL1
    IPVersion = Id_IPv4
    ConnectTimeout = 0
    Port = 990
    NATKeepAlive.UseKeepAlive = False
    NATKeepAlive.IdleTimeMS = 0
    NATKeepAlive.IntervalMS = 0
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    UseTLS = utUseImplicitTLS
    Left = 136
    Top = 120
  end
  object ssh: TScSSHClient
    HostName = 'ftpst.lqs.es'
    Port = 990
    User = 'LOGINSER'
    Password = 'ElpcU0206'
    HttpOptions.Url = 'ftpst.lqs.es'
    HttpOptions.Username = 'LOGINSER'
    HttpOptions.Password = 'ElpcU0206'
    KeyStorage = FileStore
    Left = 104
    Top = 312
  end
  object FileStore: TScFileStorage
    Password = 'ElpcU0206'
    Left = 152
    Top = 272
    UserExt = 'LOGINSER'
  end
  object ScSSLClient1: TScSSLClient
    HostName = 'ftpst.lqs.es'
    Port = 990
    HttpOptions.Username = 'LOGINSER'
    HttpOptions.Password = 'ElpcU0206'
    Storage = FileStore
    Left = 104
    Top = 264
  end
  object ScFTPClient1: TScFTPClient
    HostName = 'ftpst.lqs.es'
    Port = 990
    Username = 'LOGINSER'
    Password = 'ElpcU0206'
    TLSMode = tmImplicitTLS
    EncryptDataChannel = True
    SSLOptions.Storage = FileStore
    SSLOptions.TrustServerCertificate = True
    Left = 40
    Top = 264
  end
end
