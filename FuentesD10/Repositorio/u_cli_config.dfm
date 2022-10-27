object fCliConfig: TfCliConfig
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Configuraci'#243'n de Almac'#233'n para'
  ClientHeight = 514
  ClientWidth = 939
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  DesignSize = (
    939
    514)
  PixelsPerInch = 96
  TextHeight = 13
  object grParams: TJvDBGrid
    Left = 8
    Top = 8
    Width = 923
    Height = 361
    Anchors = [akLeft, akTop, akRight]
    DataSource = dsConfig
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = grParamsCellClick
    OnKeyDown = grParamsKeyDown
    OnKeyUp = grParamsKeyUp
    SelectColumnsDialogStrings.Caption = 'Select columns'
    SelectColumnsDialogStrings.OK = '&OK'
    SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
    EditControls = <>
    RowsHeight = 17
    TitleRowHeight = 17
    Columns = <
      item
        Expanded = False
        FieldName = 'ID_CLIENTE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITEM'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOR'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRIPCION'
        Width = 500
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TIPO'
        Visible = False
      end>
  end
  object pn1: TPanel
    Left = 8
    Top = 384
    Width = 923
    Height = 113
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    ExplicitWidth = 913
    object edEdit: TsEdit
      Left = 16
      Top = 24
      Width = 889
      Height = 21
      ParentFont = False
      TabOrder = 0
      Text = 'edEdit'
      BoundLabel.Active = True
      BoundLabel.Layout = sclTopLeft
    end
    object rgChk: TsRadioGroup
      Left = 16
      Top = 55
      Width = 889
      Height = 43
      Caption = 'rgChk'
      TabOrder = 1
      Columns = 15
      Items.Strings = (
        'No'
        'S'#237)
    end
  end
  object qConfig: TpFIBDataSet
    SelectSQL.Strings = (
      'select *'
      'from g_clientes_config_ c'
      'where (id_cliente=:id_cliente) or ((id_cliente=-1000) and '
      
        '                                                     (not exists' +
        ' (select * from g_clientes_config_ c2 where c2.id_cliente=:id_cl' +
        'iente and c2.item=c.item)))'
      'order by item')
    Transaction = dm.t_read
    Database = dm.db
    UpdateTransaction = dm.t_write
    Left = 533
    Top = 13
    object lgsConfigID_CLIENTE: TFIBIntegerField
      FieldName = 'ID_CLIENTE'
    end
    object qConfigITEM: TFIBStringField
      FieldName = 'ITEM'
      EmptyStrToNull = True
    end
    object qConfigVALOR: TFIBStringField
      FieldName = 'VALOR'
      Size = 255
      EmptyStrToNull = True
    end
    object qConfigDESCRIPCION: TFIBStringField
      FieldName = 'DESCRIPCION'
      Size = 100
      EmptyStrToNull = True
    end
    object qConfigTIPO: TFIBStringField
      FieldName = 'TIPO'
      Size = 10
      EmptyStrToNull = True
    end
  end
  object dsConfig: TDataSource
    DataSet = qConfig
    Left = 576
    Top = 16
  end
end
