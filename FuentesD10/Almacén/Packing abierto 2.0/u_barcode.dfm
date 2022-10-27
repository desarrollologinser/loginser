object f_barcode: Tf_barcode
  Left = 0
  Top = 0
  Caption = 'Inserte c'#243'digo de barras'
  ClientHeight = 40
  ClientWidth = 411
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ed_cb: TsEdit
    Left = 109
    Top = 8
    Width = 284
    Height = 21
    NumbersOnly = True
    ParentFont = False
    TabOrder = 0
    OnKeyDown = ed_cbKeyDown
    SkinData.SkinSection = 'EDIT'
    BoundLabel.Active = True
    BoundLabel.ParentFont = False
    BoundLabel.Caption = 'C'#243'digo de Barras'
    BoundLabel.Font.Charset = DEFAULT_CHARSET
    BoundLabel.Font.Color = clBlack
    BoundLabel.Font.Height = -11
    BoundLabel.Font.Name = 'Tahoma'
    BoundLabel.Font.Style = []
  end
end
