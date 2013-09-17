inherited Report_MotionGoodsForm: TReport_MotionGoodsForm
  Caption = #1044#1074#1080#1078#1077#1085#1080#1077' '#1090#1086#1074#1072#1088#1072
  ClientHeight = 395
  ClientWidth = 1329
  ExplicitWidth = 1337
  ExplicitHeight = 422
  PixelsPerInch = 96
  TextHeight = 13
  object cxGrid: TcxGrid
    Left = 0
    Top = 113
    Width = 1329
    Height = 282
    Align = alClient
    TabOrder = 0
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
    object edGoodsGroup: TcxButtonEdit
      Left = 648
      Top = 9
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 0
      Width = 137
    end
    object deStart: TcxDateEdit
      Left = 16
      Top = 8
      EditValue = 41395d
      Properties.ShowTime = False
      TabOrder = 2
      Width = 121
    end
    object deEnd: TcxDateEdit
      Left = 176
      Top = 8
      EditValue = 41395d
      Properties.ShowTime = False
      TabOrder = 4
      Width = 121
    end
    object edUnitGroup: TcxButtonEdit
      Left = 422
      Top = 10
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 1
      Width = 137
    end
    object cxLabel3: TcxLabel
      Left = 316
      Top = 10
      Caption = #1043#1088'.'#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1103
    end
    object cxLabel1: TcxLabel
      Left = 578
      Top = 10
      Caption = #1043#1088'.'#1090#1086#1074#1072#1088#1072
    end
    object cxLabel2: TcxLabel
      Left = 600
      Top = 50
      Caption = #1058#1086#1074#1072#1088
    end
    object edGoods: TcxButtonEdit
      Left = 648
      Top = 50
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 7
      Width = 137
    end
    object edLocation: TcxButtonEdit
      Left = 422
      Top = 50
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 8
      Width = 137
    end
    object cxLabel4: TcxLabel
      Left = 332
      Top = 50
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
      DockedLeft = 2
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 671
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbDialogForm'
        end
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
    object bbDialogForm: TdxBarButton
      Action = ExecuteDialog
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
    object ExecuteDialog: TExecuteDialog
      Category = 'DSDLib'
      Caption = #1044#1080#1072#1083#1086#1075' '#1091#1089#1090#1072#1085#1086#1074#1082#1080' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074
      Hint = #1044#1080#1072#1083#1086#1075' '#1091#1089#1090#1072#1085#1086#1074#1082#1080' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074
      ImageIndex = 35
      FormName = 'TReport_MotionGoodsDialogForm'
      GuiParams = <
        item
          Name = 'StartDate'
          Component = deStart
          DataType = ftDateTime
          ParamType = ptInput
          Value = 41395d
        end
        item
          Name = 'EndDate'
          Component = deEnd
          DataType = ftDateTime
          ParamType = ptInput
          Value = 41395d
        end
        item
          Name = 'GoodsId'
          Component = GoodsGuides
          ComponentItem = 'Key'
          DataType = ftString
          ParamType = ptInput
          Value = ''
        end
        item
          Name = 'GoodsName'
          Component = GoodsGuides
          ComponentItem = 'TextValue'
          DataType = ftString
          ParamType = ptInput
          Value = ''
        end
        item
          Name = 'GoodsGroupId'
          Component = GoodsGroupGuides
          ComponentItem = 'Key'
          DataType = ftInteger
          ParamType = ptOutput
          Value = ''
        end
        item
          Name = 'GoodsGroupName'
          Component = GoodsGroupGuides
          ComponentItem = 'TextValue'
          DataType = ftString
          ParamType = ptOutput
          Value = ''
        end
        item
          Name = 'UnitGroupId'
          Component = UnitGroupGuides
          ComponentItem = 'Key'
          DataType = ftInteger
          ParamType = ptOutput
          Value = ''
        end
        item
          Name = 'UnitGroupName'
          Component = UnitGroupGuides
          ComponentItem = 'TextValue'
          DataType = ftString
          ParamType = ptOutput
          Value = ''
        end
        item
          Name = 'UnitId'
          Component = UnitGuides
          ComponentItem = 'Key'
          DataType = ftInteger
          ParamType = ptOutput
          Value = ''
        end
        item
          Name = 'UnitName'
          Component = UnitGuides
          ComponentItem = 'Key'
          DataType = ftString
          ParamType = ptOutput
          Value = ''
        end>
      isShowModal = True
      OpenBeforeShow = True
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
        DataType = ftDateTime
        ParamType = ptInput
        Value = 41395d
      end
      item
        Name = 'inEndDate'
        DataType = ftDateTime
        ParamType = ptInput
        Value = 41395d
      end
      item
        Name = 'inUnitGroupId'
        Component = UnitGroupGuides
        ComponentItem = 'Key'
        DataType = ftInteger
        ParamType = ptInput
        Value = ''
      end
      item
        Name = 'inLocationId'
        Component = UnitGuides
        ComponentItem = 'Key'
        DataType = ftInteger
        ParamType = ptInput
        Value = ''
      end
      item
        Name = 'inGoodsGroupId'
        Component = GoodsGroupGuides
        ComponentItem = 'Key'
        DataType = ftInteger
        ParamType = ptInput
        Value = ''
      end
      item
        Name = 'inGoodsId'
        Component = GoodsGuides
        ComponentItem = 'Key'
        DataType = ftInteger
        ParamType = ptInput
        Value = ''
      end>
    Left = 152
    Top = 176
  end
  object dsdDBViewAddOn: TdsdDBViewAddOn
    View = cxGridDBTableView
    OnDblClickActionList = <>
    ActionItemList = <>
    SortImages = dmMain.SortImageList
    Left = 232
    Top = 216
  end
  object dsdUserSettingsStorageAddOn: TdsdUserSettingsStorageAddOn
    Left = 264
    Top = 264
  end
  object GoodsGroupGuides: TdsdGuides
    LookupControl = edGoodsGroup
    FormName = 'TGoodsGroupForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Component = GoodsGroupGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
        Value = ''
      end
      item
        Name = 'TextValue'
        Component = GoodsGroupGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        Value = ''
      end>
    Left = 776
    Top = 32
  end
  object UnitGuides: TdsdGuides
    LookupControl = edLocation
    FormName = 'TUnitForm'
    PositionDataSet = 'GridDataSet'
    Params = <
      item
        Name = 'Key'
        Component = UnitGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
        Value = ''
      end
      item
        Name = 'TextValue'
        Component = UnitGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        Value = ''
      end>
    Left = 488
    Top = 88
  end
  object PeriodChoice: TPeriodChoice
    DateStart = deStart
    DateEnd = deEnd
    Left = 200
    Top = 64
  end
  object UnitGroupGuides: TdsdGuides
    LookupControl = edUnitGroup
    FormName = 'TUnitTreeForm'
    PositionDataSet = 'GridDataSet'
    ParentDataSet = 'TreeDataSet'
    Params = <
      item
        Name = 'Key'
        Component = UnitGroupGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
        Value = ''
      end
      item
        Name = 'TextValue'
        Component = UnitGroupGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        Value = ''
      end>
    Left = 464
    Top = 24
  end
  object GoodsGuides: TdsdGuides
    LookupControl = edGoods
    FormName = 'TGoodsForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Component = GoodsGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
        Value = ''
      end
      item
        Name = 'TextValue'
        Component = GoodsGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
        Value = ''
      end>
    Left = 792
    Top = 83
  end
  object RefreshDispatcher: TRefreshDispatcher
    RefreshAction = actRefresh
    ShowDialogAction = ExecuteDialog
    ComponentList = <
      item
        Component = PeriodChoice
      end
      item
        Component = UnitGroupGuides
      end
      item
        Component = UnitGuides
      end
      item
        Component = GoodsGroupGuides
      end
      item
        Component = GoodsGuides
      end>
    Left = 304
    Top = 64
  end
end