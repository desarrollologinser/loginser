object dm_flam: Tdm_flam
  OldCreateOrder = False
  Height = 131
  Width = 198
  object cl: TScSSHClient
    HostKeyAlgorithms = <
      item
        Algorithm = aaRSA
      end
      item
        Algorithm = aaEC
      end
      item
        Algorithm = aaDSA
      end>
    HostName = '217.160.230.152'
    User = 'u62588198-flamingos'
    Password = 'Flamingos2020*+'
    KeyStorage = st
    OnServerKeyValidate = clServerKeyValidate
    Left = 15
    Top = 16
  end
  object st: TScFileStorage
    Left = 47
    Top = 16
  end
  object f: TScSFTPClient
    SSHClient = cl
    OnDirectoryList = fDirectoryList
    Left = 79
    Top = 16
  end
end
