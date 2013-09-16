inherited Report_MotionGoodsForm: TReport_MotionGoodsForm
  Caption = #1044#1074#1080#1078#1077#1085#1080#1077' '#1090#1086#1074#1072#1088#1072
  ClientHeight = 395
  ClientWidth = 1329
  ExplicitWidth = 1337
  ExplicitHeight = 429
  PixelsPerInch = 96
  TextHeight = 13
  object cxGrid: TcxGrid
    Left = 0
    Top = 113
    Width = 1329
    Height = 282
    Align = alClient
    TabOrder = 0
    ExplicitTop = 67
    ExplicitHeight = 328
    object cxGridDBTableView: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = DataSource
      DataController.Filter.Active = True
      DataController.Summary.DefaultGroupSummaryItems = <
        item
          Format = ',0.00'
          Kind = skSum
          Position = spFooter
        end
        item
          Format = ',0.00'
          Kind = skSum
          Position = spFooter
        end
        item
          Format = ',0.00'
          Kind = skSum
          Position = spFooter
          Column = StartCount
        end
        item
          Format = ',0.00'
          Kind = skSum
          Position = spFooter
        end
        item
          Format = ',0.00'
          Kind = skSum
          Position = spFooter
          Column = IncomeCount
        end
        item
          Format = ',0.00'
          Kind = skSum
          Position = spFooter
        end
        item
          Format = ',0.00'
          Kind = skSum
          Position = spFooter
          Column = StartSumm
        end
        item
          Format = ',0.00'
          Kind = skSum
          Position = spFooter
        end
        item
          Format = ',0.00'
          Kind = skSum
          Position = spFooter
          Column = IncomeSumm
        end
        item
          Format = ',0.00'
          Kind = skSum
          Position = spFooter
        end
        item
          Format = ',0.00'
          Kind = skSum
          Position = spFooter
        end
        item
          Format = ',0.00'
          Kind = skSum
          Position = spFooter
        end
        item
          Format = ',0.00'
          Kind = skSum
          Position = spFooter
          Column = EndCount
        end
        item
          Format = ',0.00'
          Kind = skSum
          Position = spFooter
          Column = EndSumm
        end
        item
          Format = ',0.00'
          Kind = skSum
          Position = spFooter
        end
        item
          Format = ',0.00'
          Kind = skSum
          Position = spFooter
        end
        item
          Format = ',0.00'
          Position = spFooter
        end
        item
          Format = ',0.00'
          Position = spFooter
        end>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = ',0.00'
          Kind = skSum
        end
        item
          Format = ',0.00'
          Kind = skSum
        end
        item
          Format = ',0.00'
          Kind = skSum
          Column = StartCount
        end
        item
          Format = ',0.00'
          Kind = skSum
        end
        item
          Format = ',0.00'
          Kind = skSum
          Column = EndCount
        end
        item
          Format = ',0.00'
          Kind = skSum
        end
        item
          Format = ',0.00'
          Kind = skSum
          Column = StartSumm
        end
        item
          Format = ',0.00'
          Kind = skSum
        end
        item
          Format = ',0.00'
          Kind = skSum
          Column = IncomeSumm
        end
        item
          Format = ',0.00'
          Kind = skSum
        end
        item
          Format = ',0.00'
          Kind = skSum
        end
        item
          Format = ',0.00'
          Kind = skSum
        end
        item
          Format = ',0.00'
          Kind = skSum
          Column = EndCount
        end
        item
          Format = ',0.00'
          Kind = skSum
          Column = EndSumm
        end
        item
          Format = ',0.00'
          Kind = skSum
        end
        item
          Format = ',0.00'
          Kind = skSum
        end
        item
          Format = ',0.00'
        end
        item
          Format = ',0.00'
        end>
      DataController.Summary.SummaryGroups = <>
      Images = dmMain.SortImageList
      OptionsBehavior.IncSearch = True
      OptionsCustomize.ColumnHiding = True
      OptionsCustomize.ColumnsQuickCustomization = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      OptionsView.GroupFooters = gfAlwaysVisible
      OptionsView.HeaderAutoHeight = True
      object UnitName: TcxGridDBColumn
        Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
        DataBinding.FieldName = 'UnitName'
        Width = 70
      end
      object GoodsCode: TcxGridDBColumn
        Caption = #1050#1086#1076
        DataBinding.FieldName = 'GoodsCode'
        Width = 30
      end
      object GoodsName: TcxGridDBColumn
        Caption = #1058#1086#1074#1072#1088
        DataBinding.FieldName = 'GoodsName'
        Width = 70
      end
      object GoodsKindName: TcxGridDBColumn
        Caption = #1042#1080#1076' '#1090#1086#1074#1072#1088#1072
        DataBinding.FieldName = 'GoodsKindName'
        Width = 40
      end
      object PartionGoodsName: TcxGridDBColumn
        Caption = #1055#1072#1088#1090#1080#1103' '#1090#1086#1074#1072#1088#1072
        DataBinding.FieldName = 'PartionGoodsName'
        Width = 50
      end
      object AssetName: TcxGridDBColumn
        Caption = #1054#1057' ('#1085#1072#1079#1085#1072#1095#1077#1085#1080#1077' '#1058#1052#1062')'
        DataBinding.FieldName = 'AssetName'
        Width = 75
      end
      object StartWeight: TcxGridDBColumn
        Caption = 'StartWeight'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        HeaderAlignmentHorz = taRightJustify
        Width = 75
      end
      object StartCount: TcxGridDBColumn
        DataBinding.FieldName = 'StartCount'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 75
      end
      object StartSumm: TcxGridDBColumn
        DataBinding.FieldName = 'StartSumm'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taRightJustify
        Width = 75
      end
      object IncomeCount_Sh: TcxGridDBColumn
        Caption = 'IncomeCount_Sh'
        HeaderAlignmentHorz = taRightJustify
        Width = 50
      end
      object IncomeCount: TcxGridDBColumn
        DataBinding.FieldName = 'IncomeCount'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taCenter
        Width = 50
      end
      object IncomeSumm: TcxGridDBColumn
        DataBinding.FieldName = 'IncomeSumm'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        Width = 75
      end
      object SendInCount_Sh: TcxGridDBColumn
        Caption = 'SendInCount_Sh'
        FooterAlignmentHorz = taRightJustify
      end
      object SendInCount: TcxGridDBColumn
        Caption = 'SendInCount'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.AssignedValues.DisplayFormat = True
        Width = 50
      end
      object SendInSumm: TcxGridDBColumn
        Caption = 'SendInSumm'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Width = 75
      end
      object SendOutCount_Sh: TcxGridDBColumn
        Caption = 'SendOutCount_Sh'
        HeaderAlignmentHorz = taRightJustify
        Width = 50
      end
      object SendOutCount: TcxGridDBColumn
        Caption = 'SendOutCount'
        Width = 50
      end
      object SendOutSumm: TcxGridDBColumn
        Caption = 'SendOutSumm'
        Width = 75
      end
      object SaleCount_Sh: TcxGridDBColumn
        Caption = 'SaleCount_Sh'
        Width = 50
      end
      object SaleCount: TcxGridDBColumn
        Caption = 'SaleCount'
        Width = 50
      end
      object SaleSumm: TcxGridDBColumn
        Caption = 'SaleSumm'
        Width = 75
      end
      object ReturnOutCount_Sh: TcxGridDBColumn
        Caption = 'ReturnOutCount_Sh'
        Width = 50
      end
      object ReturnOutCount: TcxGridDBColumn
        Caption = 'ReturnOutCount'
        Width = 50
      end
      object ReturnOutSumm: TcxGridDBColumn
        Caption = 'ReturnOutSumm'
        Width = 75
      end
      object ReturnInCount_Sh: TcxGridDBColumn
        Caption = 'ReturnInCount_Sh'
        Width = 50
      end
      object ReturnInCount: TcxGridDBColumn
        Caption = 'ReturnInCount'
        Width = 50
      end
      object ReturnInSumm: TcxGridDBColumn
        Caption = 'ReturnInSumm'
        Width = 75
      end
      object LossCount_Sh: TcxGridDBColumn
        Caption = 'LossCount_Sh'
        Width = 50
      end
      object LossCount: TcxGridDBColumn
        Caption = 'LossCount'
        Width = 50
      end
      object LossSumm: TcxGridDBColumn
        Caption = 'LossSumm'
        Width = 75
      end
      object InventoryCount_Sh: TcxGridDBColumn
        Caption = 'InventoryCount_Sh'
        Width = 50
      end
      object InventoryCount: TcxGridDBColumn
        Caption = 'InventoryCount'
        Width = 50
      end
      object InventorySumm: TcxGridDBColumn
        Caption = 'InventorySumm'
        Width = 75
      end
      object EndCount_Sh: TcxGridDBColumn
        Caption = 'EndCount_Sh'
        Width = 75
      end
      object EndCount: TcxGridDBColumn
        Caption = 'EndCount'
        DataBinding.FieldName = 'EndCount_calc'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        Width = 75
      end
      object EndSumm: TcxGridDBColumn
        Caption = 'EndSumm'
        DataBinding.FieldName = 'EndSumm_calc'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        Width = 75
      end
    end
    object cxGridLevel: TcxGridLevel
      GridView = cxGridDBTableView
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 26
    Width = 1329
    Height = 87
    Align = alTop
    TabOrder = 5
    object deStart: TcxDateEdit
      Left = 217
      Top = 8
      EditValue = 41395d
      TabOrder = 0
      Width = 121
    end
    object deEnd: TcxDateEdit
      Left = 352
      Top = 8
      EditValue = 41395d
      TabOrder = 1
      Width = 121
    end
    object edUnit: TcxButtonEdit
      Left = 610
      Top = 8
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 2
      Width = 137
    end
    object cxLabel3: TcxLabel
      Left = 504
      Top = 8
      Caption = #1043#1088'.'#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1103
    end
    object edGoodsGroup: TcxButtonEdit
      Left = 898
      Top = 7
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 4
      Width = 137
    end
    object cxLabel1: TcxLabel
      Left = 828
      Top = 8
      Caption = #1043#1088'.'#1090#1086#1074#1072#1088#1072
    end
    object cxLabel2: TcxLabel
      Left = 850
      Top = 48
      Caption = #1058#1086#1074#1072#1088
    end
    object edGoods: TcxButtonEdit
      Left = 898
      Top = 48
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 7
      Width = 137
    end
    object edLocation: TcxButtonEdit
      Left = 610
      Top = 48
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 8
      Width = 137
    end
    object cxLabel4: TcxLabel
      Left = 520
      Top = 48
      Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1103
    end
  end
  object DataSource: TDataSource
    DataSet = ClientDataSet
    Left = 88
    Top = 24
  end
  object ClientDataSet: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 88
    Top = 184
  end
  object cxPropertiesStore: TcxPropertiesStore
    Components = <
      item
        Component = deEnd
        Properties.Strings = (
          'Date')
      end
      item
        Component = deStart
        Properties.Strings = (
          'Date')
      end
      item
        Component = Owner
        Properties.Strings = (
          'Height'
          'Left'
          'Top'
          'Width')
      end>
    StorageName = 'cxPropertiesStore'
    StorageType = stStream
    Left = 296
    Top = 168
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = dmMain.ImageList
    PopupMenuLinks = <>
    ShowShortCutInHint = True
    UseSystemFont = True
    Left = 144
    Top = 24
    DockControlHeights = (
      0
      0
      26
      0)
    object dxBarManagerBar1: TdxBar
      Caption = 'Custom'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 671
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbRefresh'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbToExcel'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbRefresh: TdxBarButton
      Action = actRefresh
      Category = 0
    end
    object bbToExcel: TdxBarButton
      Action = actExportToExcel
      Category = 0
    end
  end
  object ActionList: TActionList
    Images = dmMain.ImageList
    Left = 232
    Top = 160
    object actRefresh: TdsdDataSetRefresh
      Category = 'DSDLib'
      StoredProc = dsdStoredProc
      StoredProcList = <
        item
          StoredProc = dsdStoredProc
        end>
      Caption = #1055#1077#1088#1077#1095#1080#1090#1072#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      ImageIndex = 4
      ShortCut = 116
    end
    object actExportToExcel: TdsdGridToExcel
      Category = 'DSDLib'
      Grid = cxGrid
      Caption = #1042#1099#1075#1088#1091#1079#1082#1072' '#1074' Excel'
      Hint = #1042#1099#1075#1088#1091#1079#1082#1072' '#1074' Excel'
      ImageIndex = 6
      ShortCut = 16472
    end
  end
  object dsdStoredProc: TdsdStoredProc
    StoredProcName = 'gpReport_MotionGoods'
    DataSet = ClientDataSet
    DataSets = <
      item
        DataSet = ClientDataSet
      end>
    Params = <
      item
        Name = 'inStartDate'
        Component = deStart
        DataType = ftDateTime
        ParamType = ptInput
        Value = 41395d
      end
      item
        Name = 'inEndDate'
        Component = deEnd
        DataType = ftDateTime
        ParamType = ptInput
        Value = 41395d
      end
      item
        Name = 'inUnitGroupId'
        Component = edUnit
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'inLocationId'
        Component = edLocation
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'inGoodsGroupId'
        Component = edGoodsGroup
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'inGoodsId'
        Component = edGoods
        DataType = ftInteger
        ParamType = ptInput
      end>
    Left = 152
    Top = 176
  end
  object dsdDBViewAddOn: TdsdDBViewAddOn
    OnDblClickActionList = <>
    View = cxGridDBTableView
    ActionItemList = <>
    Left = 232
    Top = 216
  end
  object dsdUserSettingsStorageAddOn: TdsdUserSettingsStorageAddOn
    Left = 264
    Top = 264
  end
  object dsdGuidesUnitGroup: TdsdGuides
    LookupControl = edUnit
    FormName = 'TUnitForm'
    PositionDataSet = 'GridDataSet'
    Params = <>
    Left = 672
    Top = 16
  end
  object dsdGuidesGoodsGroup: TdsdGuides
    LookupControl = edGoodsGroup
    FormName = 'TGoodsGroupForm'
    PositionDataSet = 'ClientDataSet'
    Params = <>
    Left = 952
    Top = 16
  end
  object dsdGuidesGoods: TdsdGuides
    LookupControl = edGoods
    FormName = 'TGoodsForm'
    PositionDataSet = 'ClientDataSet'
    Params = <>
    Left = 944
    Top = 64
  end
  object dsdGuidesUnit: TdsdGuides
    LookupControl = edLocation
    FormName = 'TUnitForm'
    PositionDataSet = 'GridDataSet'
    Params = <>
    Left = 664
    Top = 72
  end
end
