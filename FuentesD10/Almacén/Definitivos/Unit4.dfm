object Form4: TForm4
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Devolver Cajas'
  ClientHeight = 497
  ClientWidth = 779
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
    Left = 480
    Top = 464
    Width = 185
    Height = 25
    Caption = 'Efectuar devoluci'#243'n a almac'#233'n'
    TabOrder = 0
    OnClick = btn1Click
  end
  object gridentregados: TNextGrid
    Left = 8
    Top = 8
    Width = 761
    Height = 449
    AppearanceOptions = [aoBoldTextSelection, aoHighlightSlideCells]
    Options = [goHeader, goMultiSelect, goSelectFullRow]
    TabOrder = 1
    TabStop = True
    object nxnmbrclmn1: TNxNumberColumn
      DefaultValue = '0'
      DefaultWidth = 50
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'Solicitud'
      ParentFont = False
      Position = 0
      SortType = stNumeric
      Width = 50
      Increment = 1.000000000000000000
      Precision = 0
    end
    object nxtxtclmn1: TNxTextColumn
      DefaultWidth = 50
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'Tipo'
      ParentFont = False
      Position = 1
      SortType = stAlphabetic
      Width = 50
    end
    object nxtxtclmn7: TNxTextColumn
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'Caja'
      ParentFont = False
      Position = 2
      SortType = stAlphabetic
    end
    object nxtxtclmn2: TNxTextColumn
      DefaultWidth = 50
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'Lote'
      ParentFont = False
      Position = 3
      SortType = stAlphabetic
      Width = 50
    end
    object nxtxtclmn3: TNxTextColumn
      DefaultWidth = 60
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'Carpeta'
      ParentFont = False
      Position = 4
      SortType = stAlphabetic
      Width = 60
    end
    object nxtxtclmn4: TNxTextColumn
      DefaultWidth = 60
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'Pagina'
      ParentFont = False
      Position = 5
      SortType = stAlphabetic
      Width = 60
    end
    object nxtxtclmn8: TNxTextColumn
      DefaultWidth = 300
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'Solicitante'
      ParentFont = False
      Position = 6
      SortType = stAlphabetic
      Width = 300
    end
    object nxtxtclmn5: TNxTextColumn
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'Fecha Entrega'
      ParentFont = False
      Position = 7
      SortType = stAlphabetic
    end
    object nxnmbrclmn2: TNxNumberColumn
      DefaultValue = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'id_articulo'
      ParentFont = False
      Position = 8
      SortType = stNumeric
      Visible = False
      Increment = 1.000000000000000000
      Precision = 0
    end
  end
  object btn2: TButton
    Left = 688
    Top = 464
    Width = 75
    Height = 25
    Caption = 'Salir'
    TabOrder = 2
    OnClick = btn2Click
  end
end
