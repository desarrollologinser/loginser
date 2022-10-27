object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Cajas Aseval'
  ClientHeight = 300
  ClientWidth = 394
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mm1
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object mm1: TMainMenu
    Left = 193
    Top = 153
    object Asignar1: TMenuItem
      Caption = 'Cajas'
      object Entregar1: TMenuItem
        Caption = 'Asignar'
        OnClick = Entregar1Click
      end
      object Devol1: TMenuItem
        Caption = 'Entregar'
        OnClick = Devol1Click
      end
      object Devolver1: TMenuItem
        Caption = 'Devolver'
        OnClick = Devolver1Click
      end
      object EstadoSolicitudes1: TMenuItem
        Caption = 'Estado Solicitudes'
        OnClick = EstadoSolicitudes1Click
      end
      object Sincronizar1: TMenuItem
        Caption = 'Sincronizar'
        OnClick = Sincronizar1Click
      end
      object Salir1: TMenuItem
        Caption = 'Salir'
        OnClick = Salir1Click
      end
    end
  end
end
