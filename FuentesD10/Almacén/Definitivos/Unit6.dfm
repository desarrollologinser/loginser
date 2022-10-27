object Form6: TForm6
  Left = 0
  Top = 0
  Caption = 'Estado Solicitudes'
  ClientHeight = 479
  ClientWidth = 1008
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
  object lbl1: TLabel
    Left = 16
    Top = 448
    Width = 34
    Height = 13
    Caption = 'Filtrar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl2: TLabel
    Left = 216
    Top = 448
    Width = 60
    Height = 13
    Caption = 'solicitudes'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object grid: TNextGrid
    Left = 16
    Top = 16
    Width = 961
    Height = 409
    TabOrder = 0
    TabStop = True
    object nxnmbrclmn1: TNxNumberColumn
      DefaultValue = '0'
      DefaultWidth = 60
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'Solicitud'
      ParentFont = False
      Position = 0
      SortType = stNumeric
      Width = 60
      Increment = 1.000000000000000000
      Precision = 0
    end
    object nxtxtclmn2: TNxTextColumn
      DefaultWidth = 40
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'Tipo'
      ParentFont = False
      Position = 1
      SortType = stAlphabetic
      Width = 40
    end
    object nxtxtclmn3: TNxTextColumn
      DefaultWidth = 60
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'Caja'
      ParentFont = False
      Position = 2
      SortType = stAlphabetic
      Width = 60
    end
    object nxtxtclmn4: TNxTextColumn
      DefaultWidth = 40
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'Lote'
      ParentFont = False
      Position = 3
      SortType = stAlphabetic
      Width = 40
    end
    object nxtxtclmn5: TNxTextColumn
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
    object nxtxtclmn6: TNxTextColumn
      DefaultWidth = 50
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'P'#225'gina'
      ParentFont = False
      Position = 5
      SortType = stAlphabetic
      Width = 50
    end
    object nxtxtclmn7: TNxTextColumn
      DefaultWidth = 250
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'Solicitante'
      ParentFont = False
      Position = 6
      SortType = stAlphabetic
      Width = 250
    end
    object nxdtclmn1: TNxDateColumn
      DefaultValue = '30/03/2015'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'Fecha Solicitud'
      ParentFont = False
      Position = 7
      SortType = stDate
      HideWhenEmpty = True
      NoneCaption = 'None'
      TodayCaption = 'Today'
    end
    object nxtxtclmn9: TNxTextColumn
      DefaultWidth = 60
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'Entregado'
      ParentFont = False
      Position = 8
      SortType = stAlphabetic
      Width = 60
    end
    object nxdtclmn2: TNxDateColumn
      DefaultValue = '30/03/2015'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'Fecha Entrega'
      ParentFont = False
      Position = 9
      SortType = stDate
      HideWhenEmpty = True
      NoneCaption = 'None'
      TodayCaption = 'Today'
    end
    object nxtxtclmn11: TNxTextColumn
      DefaultWidth = 60
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'Devuelto'
      ParentFont = False
      Position = 10
      SortType = stAlphabetic
      Width = 60
    end
    object nxdtclmn3: TNxDateColumn
      DefaultValue = '30/03/2015'
      DefaultWidth = 100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Header.Caption = 'Fecha Devoluci'#243'n'
      ParentFont = False
      Position = 11
      SortType = stDate
      Width = 100
      HideWhenEmpty = True
      NoneCaption = 'None'
      TodayCaption = 'Today'
    end
  end
  object cbb1: TComboBox
    Left = 56
    Top = 444
    Width = 145
    Height = 21
    TabOrder = 1
    OnChange = cbb1Change
    Items.Strings = (
      'Todos'
      'Entregados'
      'Devueltos'
      'No Entregados'
      'No Devueltos')
  end
  object btn1: TButton
    Left = 902
    Top = 442
    Width = 75
    Height = 25
    Caption = 'Salir'
    TabOrder = 2
    OnClick = btn1Click
  end
end
