﻿inherited JuridicalEditForm: TJuridicalEditForm
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1102#1088#1080#1076#1080#1095#1077#1089#1082#1086#1075#1086' '#1083#1080#1094#1072
  ClientHeight = 364
  ClientWidth = 851
  ExplicitWidth = 857
  ExplicitHeight = 389
  PixelsPerInch = 96
  TextHeight = 13
  inherited bbOk: TcxButton
    Left = 42
    Top = 301
    Action = InsertUpdateGuides
    TabOrder = 7
    ExplicitLeft = 42
    ExplicitTop = 301
  end
  inherited bbCancel: TcxButton
    Left = 153
    Top = 301
    Action = actFormClose
    TabOrder = 8
    ExplicitLeft = 153
    ExplicitTop = 301
  end
  object edName: TcxTextEdit [2]
    Left = 5
    Top = 67
    TabOrder = 0
    Width = 273
  end
  object cxLabel1: TcxLabel [3]
    Left = 5
    Top = 47
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
  end
  object Код: TcxLabel [4]
    Left = 5
    Top = 2
    Caption = #1050#1086#1076
  end
  object ceCode: TcxCurrencyEdit [5]
    Left = 5
    Top = 24
    Properties.DecimalPlaces = 0
    Properties.DisplayFormat = '0'
    TabOrder = 6
    Width = 273
  end
  object cxLabel2: TcxLabel [6]
    Left = 5
    Top = 91
    Caption = #1050#1086#1076' GLN'
  end
  object edGLNCode: TcxTextEdit [7]
    Left = 5
    Top = 114
    TabOrder = 1
    Width = 153
  end
  object cbisCorporate: TcxCheckBox [8]
    Left = 167
    Top = 114
    Caption = #1053#1072#1096#1077' '#1102#1088'. '#1083#1080#1094#1086
    TabOrder = 2
    Width = 111
  end
  object cxLabel3: TcxLabel [9]
    Left = 5
    Top = 138
    Caption = #1043#1088#1091#1087#1087#1072' '#1102#1088'. '#1083#1080#1094
  end
  object cxLabel4: TcxLabel [10]
    Left = 5
    Top = 183
    Caption = #1050#1083#1072#1089#1089#1080#1092#1080#1082#1072#1090#1086#1088' '#1089#1074#1086#1081#1089#1090#1074' '#1090#1086#1074#1072#1088#1072
  end
  object ceJuridicalGroup: TcxButtonEdit [11]
    Left = 5
    Top = 161
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.ReadOnly = True
    TabOrder = 3
    Width = 273
  end
  object ceGoodsProperty: TcxButtonEdit [12]
    Left = 5
    Top = 206
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.ReadOnly = True
    TabOrder = 4
    Width = 273
  end
  object cxLabel5: TcxLabel [13]
    Left = 5
    Top = 231
    Caption = #1059#1055' '#1089#1090#1072#1090#1100#1103' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1103
  end
  object ceInfoMoney: TcxButtonEdit [14]
    Left = 5
    Top = 254
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    Properties.ReadOnly = True
    TabOrder = 5
    Width = 273
  end
  object Panel: TPanel [15]
    Left = 284
    Top = 0
    Width = 567
    Height = 364
    Align = alRight
    BevelEdges = [beLeft]
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 15
    object PageControl: TcxPageControl
      Left = 0
      Top = 0
      Width = 565
      Height = 364
      Align = alClient
      TabOrder = 0
      Properties.ActivePage = JuridicalDetailTS
      Properties.CustomButtons.Buttons = <>
      ClientRectBottom = 364
      ClientRectRight = 565
      ClientRectTop = 24
      object JuridicalDetailTS: TcxTabSheet
        Caption = #1056#1077#1082#1074#1080#1079#1080#1090#1099
        ImageIndex = 0
        object edFullName: TcxDBTextEdit
          Left = 16
          Top = 19
          DataBinding.DataField = 'FullName'
          DataBinding.DataSource = JuridicalDetailsDS
          TabOrder = 0
          Width = 425
        end
        object edJuridicalAddress: TcxDBTextEdit
          Left = 16
          Top = 63
          DataBinding.DataField = 'JuridicalAddress'
          DataBinding.DataSource = JuridicalDetailsDS
          TabOrder = 1
          Width = 425
        end
        object edOKPO: TcxDBTextEdit
          Left = 16
          Top = 110
          DataBinding.DataField = 'OKPO'
          DataBinding.DataSource = JuridicalDetailsDS
          TabOrder = 2
          Width = 193
        end
        object JuridicalDetailsGrid: TcxGrid
          Left = 455
          Top = 0
          Width = 110
          Height = 340
          Align = alRight
          TabOrder = 8
          object JuridicalDetailsGridDBTableView: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = JuridicalDetailsDS
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsData.Appending = True
            OptionsView.GroupByBox = False
            Styles.StyleSheet = dmMain.cxGridTableViewStyleSheet
            object colJDData: TcxGridDBColumn
              Caption = #1044#1072#1090#1072
              DataBinding.FieldName = 'StartDate'
              PropertiesClassName = 'TcxDateEditProperties'
              Properties.InputKind = ikRegExpr
              Properties.SaveTime = False
              Properties.ShowTime = False
              Properties.WeekNumbers = True
              Width = 101
            end
          end
          object JuridicalDetailsGridLevel: TcxGridLevel
            GridView = JuridicalDetailsGridDBTableView
          end
        end
        object edINN: TcxDBTextEdit
          Left = 248
          Top = 110
          DataBinding.DataField = 'INN'
          DataBinding.DataSource = JuridicalDetailsDS
          TabOrder = 3
          Width = 193
        end
        object edAccounterName: TcxDBTextEdit
          Left = 248
          Top = 158
          DataBinding.DataField = 'AccounterName'
          DataBinding.DataSource = JuridicalDetailsDS
          TabOrder = 5
          Width = 193
        end
        object edNumberVAT: TcxDBTextEdit
          Left = 16
          Top = 158
          DataBinding.DataField = 'NumberVAT'
          DataBinding.DataSource = JuridicalDetailsDS
          TabOrder = 4
          Width = 193
        end
        object edBankAccount: TcxDBTextEdit
          Left = 248
          Top = 202
          DataBinding.DataField = 'BankAccount'
          DataBinding.DataSource = JuridicalDetailsDS
          TabOrder = 7
          Width = 193
        end
        object cxLabel6: TcxLabel
          Left = 16
          Top = -1
          Caption = #1055#1086#1083#1085#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        end
        object cxLabel7: TcxLabel
          Left = 16
          Top = 44
          Caption = #1070#1088#1080#1076#1080#1095#1077#1089#1082#1080#1081' '#1072#1076#1088#1077#1089
        end
        object cxLabel8: TcxLabel
          Left = 16
          Top = 88
          Caption = #1054#1050#1055#1054
        end
        object cxLabel9: TcxLabel
          Left = 248
          Top = 88
          Caption = #1048#1053#1053
        end
        object cxLabel10: TcxLabel
          Left = 16
          Top = 137
          Caption = #8470' '#1089#1074#1080#1076#1077#1090#1077#1083#1100#1089#1090#1074#1072' '#1053#1044#1057
        end
        object cxLabel11: TcxLabel
          Left = 248
          Top = 137
          Caption = #1060#1048#1054' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1072
        end
        object edBank: TcxDBButtonEdit
          Left = 16
          Top = 202
          DataBinding.DataField = 'BankName'
          DataBinding.DataSource = JuridicalDetailsDS
          Properties.Buttons = <
            item
              Action = actChoiceBank
              Default = True
              Kind = bkEllipsis
            end>
          TabOrder = 6
          Width = 193
        end
        object cxLabel12: TcxLabel
          Left = 16
          Top = 182
          Caption = #1041#1072#1085#1082
        end
        object cxLabel13: TcxLabel
          Left = 248
          Top = 182
          Caption = #1057#1095#1077#1090
        end
      end
      object PartnerTS: TcxTabSheet
        Caption = #1058#1086#1095#1082#1080' '#1076#1086#1089#1090#1072#1074#1082#1080
        ImageIndex = 1
        object PartnerDockControl: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 565
          Height = 26
          Align = dalTop
          BarManager = dxBarManager
        end
        object PartnerGrid: TcxGrid
          Left = 0
          Top = 26
          Width = 565
          Height = 314
          Align = alClient
          TabOrder = 0
          object PartnerGridDBTableView: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = PartnerDS
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            Styles.StyleSheet = dmMain.cxGridTableViewStyleSheet
            object colPartnerCode: TcxGridDBColumn
              Caption = #1050#1086#1076
              DataBinding.FieldName = 'Code'
              Options.Editing = False
            end
            object colPartnerAddress: TcxGridDBColumn
              Caption = #1040#1076#1088#1077#1089
              DataBinding.FieldName = 'Address'
              Options.Editing = False
              Width = 423
            end
            object colPartnerisErased: TcxGridDBColumn
              Caption = #1059#1076#1072#1083#1077#1085
              DataBinding.FieldName = 'isErased'
              Visible = False
              Options.Editing = False
            end
          end
          object PartnerGridLevel: TcxGridLevel
            GridView = PartnerGridDBTableView
          end
        end
      end
      object ContractTS: TcxTabSheet
        Caption = #1044#1086#1075#1086#1074#1086#1088#1072
        ImageIndex = 2
        object ContractDockControl: TdxBarDockControl
          Left = 0
          Top = 0
          Width = 565
          Height = 26
          Align = dalTop
          BarManager = dxBarManager
        end
        object ContractGrid: TcxGrid
          Left = 0
          Top = 26
          Width = 565
          Height = 314
          Align = alClient
          TabOrder = 0
          object ContractGridDBTableView: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = ContractDS
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            Styles.StyleSheet = dmMain.cxGridTableViewStyleSheet
            object clInvNumber: TcxGridDBColumn
              Caption = #1053#1086#1084#1077#1088' '#1076#1086#1075#1086#1074#1086#1088#1072
              DataBinding.FieldName = 'InvNumber'
              HeaderAlignmentHorz = taCenter
              HeaderAlignmentVert = vaCenter
              Options.Editing = False
              Width = 171
            end
            object clStartDate: TcxGridDBColumn
              Caption = #1044#1077#1081#1089#1090#1074'. '#1089
              DataBinding.FieldName = 'StartDate'
              HeaderAlignmentHorz = taCenter
              HeaderAlignmentVert = vaCenter
              Options.Editing = False
              Width = 129
            end
            object clContractKindName: TcxGridDBColumn
              Caption = #1042#1080#1076' '#1076#1086#1075#1086#1074#1086#1088#1072
              DataBinding.FieldName = 'ContractKindName'
              HeaderAlignmentHorz = taCenter
              HeaderAlignmentVert = vaCenter
              Options.Editing = False
              Width = 171
            end
            object clIsErased: TcxGridDBColumn
              Caption = #1059#1076#1072#1083#1077#1085
              DataBinding.FieldName = 'isErased'
              HeaderAlignmentHorz = taCenter
              HeaderAlignmentVert = vaCenter
              Options.Editing = False
              Width = 78
            end
          end
          object ContractGridLevel: TcxGridLevel
            GridView = ContractGridDBTableView
          end
        end
      end
    end
  end
  inherited ActionList: TActionList
    inherited actRefresh: TdsdDataSetRefresh
      StoredProc = spGet
      StoredProcList = <
        item
          StoredProc = spGet
        end
        item
          StoredProc = spJuridicalDetails
        end
        item
          StoredProc = spContract
        end
        item
          StoredProc = spPartner
        end>
    end
    object InsertUpdateGuides: TdsdInsertUpdateGuides
      Category = 'DSDLib'
      StoredProc = spInsertUpdate
      StoredProcList = <
        item
          StoredProc = spInsertUpdate
        end>
      Caption = 'Ok'
    end
    object actFormClose: TdsdFormClose
      Category = 'DSDLib'
    end
    object actContractInsert: TdsdInsertUpdateAction
      Category = 'DSDLib'
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ShortCut = 45
      ImageIndex = 0
      FormName = 'TContractEditForm'
      GuiParams = <
        item
          Name = 'Id'
          Value = Null
        end
        item
          Name = 'JuridicalId'
          Value = Null
          Component = FormParams
          ComponentItem = 'Id'
        end
        item
          Name = 'JuridicalName'
          Value = ''
          Component = edName
          DataType = ftString
        end>
      isShowModal = False
      DataSource = ContractDS
      DataSetRefresh = actContractRefresh
    end
    object actContractUpdate: TdsdInsertUpdateAction
      Category = 'DSDLib'
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      ShortCut = 115
      ImageIndex = 1
      FormName = 'TContractEditForm'
      GuiParams = <
        item
          Name = 'Id'
          Component = ContractCDS
          ComponentItem = 'Id'
          ParamType = ptInput
        end
        item
          Name = 'JuridicalId'
          Value = Null
          Component = FormParams
          ComponentItem = 'Id'
        end
        item
          Name = 'JuridicalName'
          Value = ''
          Component = edName
          DataType = ftString
        end>
      isShowModal = False
      ActionType = acUpdate
      DataSource = ContractDS
      DataSetRefresh = actContractRefresh
    end
    object actPartnerInsert: TdsdInsertUpdateAction
      Category = 'DSDLib'
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ShortCut = 45
      ImageIndex = 0
      FormName = 'TPartnerEditForm'
      GuiParams = <
        item
          Name = 'Id'
          Value = Null
        end
        item
          Name = 'JuridicalId'
          Value = Null
          Component = FormParams
          ComponentItem = 'Id'
        end
        item
          Name = 'JuridicalName'
          Value = ''
          Component = edName
          DataType = ftString
        end>
      isShowModal = False
      DataSource = PartnerDS
      DataSetRefresh = actPartnerRefresh
    end
    object actPartnerUpdate: TdsdInsertUpdateAction
      Category = 'DSDLib'
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      ShortCut = 115
      ImageIndex = 1
      FormName = 'TPartnerEditForm'
      GuiParams = <
        item
          Name = 'Id'
          Component = PartnerCDS
          ComponentItem = 'Id'
          ParamType = ptInput
        end
        item
          Name = 'JuridicalId'
          Value = Null
          Component = FormParams
          ComponentItem = 'Id'
        end
        item
          Name = 'JuridicalName'
          Value = ''
          Component = edName
          DataType = ftString
        end>
      isShowModal = False
      ActionType = acUpdate
      DataSource = PartnerDS
      DataSetRefresh = actPartnerRefresh
    end
    object actPartnerRefresh: TdsdDataSetRefresh
      Category = 'DSDLib'
      TabSheet = PartnerTS
      StoredProc = spPartner
      StoredProcList = <
        item
          StoredProc = spPartner
        end>
      Caption = #1055#1077#1088#1077#1095#1080#1090#1072#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      ImageIndex = 4
      ShortCut = 116
      RefreshOnTabSetChanges = False
    end
    object actContractRefresh: TdsdDataSetRefresh
      Category = 'DSDLib'
      TabSheet = ContractTS
      StoredProc = spContract
      StoredProcList = <
        item
          StoredProc = spContract
        end>
      Caption = #1055#1077#1088#1077#1095#1080#1090#1072#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      ImageIndex = 4
      ShortCut = 116
      RefreshOnTabSetChanges = False
    end
    object JuridicalDetailsUDS: TdsdUpdateDataSet
      Category = 'DSDLib'
      StoredProc = spJuridicalDetailsIU
      StoredProcList = <
        item
          StoredProc = spJuridicalDetailsIU
        end>
      DataSource = JuridicalDetailsDS
    end
    object actSave: TdsdExecStoredProc
      Category = 'DSDLib'
      StoredProc = spInsertUpdate
      StoredProcList = <
        item
          StoredProc = spInsertUpdate
        end>
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      ImageIndex = 14
      ShortCut = 113
    end
    object actChoiceBank: TOpenChoiceForm
      Category = 'DSDLib'
      Caption = 'actChoiceBank'
      FormName = 'TBankForm'
      GuiParams = <
        item
          Name = 'Key'
          Component = JuridicalDetailsCDS
          ComponentItem = 'BankId'
        end
        item
          Name = 'TextValue'
          Component = JuridicalDetailsCDS
          ComponentItem = 'BankName'
          DataType = ftString
        end>
      isShowModal = False
    end
    object actMultiContractInsert: TMultiAction
      Category = 'DSDLib'
      TabSheet = ContractTS
      ActionList = <
        item
          Action = actSave
        end
        item
          Action = actContractInsert
        end>
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ImageIndex = 0
      ShortCut = 45
    end
    object actMultiPartnerInsert: TMultiAction
      Category = 'DSDLib'
      TabSheet = PartnerTS
      ActionList = <
        item
          Action = actSave
        end
        item
          Action = actPartnerInsert
        end>
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ImageIndex = 0
      ShortCut = 45
    end
  end
  inherited FormParams: TdsdFormParams
    Params = <
      item
        Name = 'Id'
        Value = Null
        ParamType = ptInputOutput
      end
      item
        Name = 'GroupId'
        Value = ''
        Component = JuridicalGroupGuides
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'GroupName'
        Value = ''
        Component = JuridicalGroupGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 8
    Top = 224
  end
  object spInsertUpdate: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_Object_Juridical'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'ioId'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInputOutput
      end
      item
        Name = 'inCode'
        Value = 0.000000000000000000
        Component = ceCode
        ParamType = ptInput
      end
      item
        Name = 'inName'
        Value = ''
        Component = edName
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'inGLNCode'
        Value = ''
        Component = edGLNCode
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'inisCorporate'
        Value = 'False'
        Component = cbisCorporate
        DataType = ftBoolean
        ParamType = ptInput
      end
      item
        Name = 'inJuridicalGroupId'
        Value = ''
        Component = JuridicalGroupGuides
        ParamType = ptInput
      end
      item
        Name = 'inGoodsPropertyId'
        Value = ''
        Component = GoodsPropertyGuides
        ParamType = ptInput
      end
      item
        Name = 'inInfoMoneyId'
        Value = ''
        Component = InfoMoneyGuides
        ParamType = ptInput
      end>
    Left = 32
    Top = 320
  end
  object spGet: TdsdStoredProc
    StoredProcName = 'gpGet_Object_Juridical'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'Id'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
      end
      item
        Name = 'Name'
        Value = ''
        Component = edName
        DataType = ftString
      end
      item
        Name = 'Code'
        Value = 0.000000000000000000
        Component = ceCode
      end
      item
        Name = 'GLNCode'
        Value = ''
        Component = edGLNCode
        DataType = ftString
      end
      item
        Name = 'isCorporate'
        Value = 'False'
        Component = cbisCorporate
      end
      item
        Name = 'JuridicalGroupId'
        Value = ''
        Component = JuridicalGroupGuides
        ComponentItem = 'Key'
      end
      item
        Name = 'JuridicalGroupName'
        Value = ''
        Component = JuridicalGroupGuides
        ComponentItem = 'TextValue'
        DataType = ftString
      end
      item
        Name = 'GoodsPropertyId'
        Value = ''
        Component = GoodsPropertyGuides
        ComponentItem = 'Key'
      end
      item
        Name = 'GoodsPropertyName'
        Value = ''
        Component = GoodsPropertyGuides
        ComponentItem = 'TextValue'
        DataType = ftString
      end
      item
        Name = 'InfoMoneyId'
        Value = ''
        Component = InfoMoneyGuides
        ComponentItem = 'Key'
      end
      item
        Name = 'InfoMoneyName'
        Value = ''
        Component = InfoMoneyGuides
        ComponentItem = 'TextValue'
      end>
    Left = 64
    Top = 320
  end
  object JuridicalGroupGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = ceJuridicalGroup
    FormName = 'TJuridicalGroupForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = JuridicalGroupGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = JuridicalGroupGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 144
    Top = 144
  end
  object GoodsPropertyGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = ceGoodsProperty
    FormName = 'TGoodsPropertyForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = GoodsPropertyGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = GoodsPropertyGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 184
    Top = 192
  end
  object InfoMoneyGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = ceInfoMoney
    FormName = 'TInfoMoney_ObjectForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = InfoMoneyGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = InfoMoneyGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 184
    Top = 240
  end
  object dxBarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = dmMain.ImageList
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 104
    Top = 32
    DockControlHeights = (
      0
      0
      0
      0)
    object PartnerBar: TdxBar
      Caption = 'Custom'
      CaptionButtons = <>
      DockControl = PartnerDockControl
      DockedDockControl = PartnerDockControl
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 528
      FloatTop = 285
      FloatClientWidth = 51
      FloatClientHeight = 22
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbPartnerInsert'
        end
        item
          Visible = True
          ItemName = 'bbPartnerEdit'
        end
        item
          Visible = True
          ItemName = 'bbStatic'
        end
        item
          Visible = True
          ItemName = 'bbPartnerRefresh'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object ContractBar: TdxBar
      Caption = 'ContractBar'
      CaptionButtons = <>
      DockControl = ContractDockControl
      DockedDockControl = ContractDockControl
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 877
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbContractInsert'
        end
        item
          Visible = True
          ItemName = 'bbContractUpdate'
        end
        item
          Visible = True
          ItemName = 'bbStatic'
        end
        item
          Visible = True
          ItemName = 'bbContractRefresh'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object bbPartnerRefresh: TdxBarButton
      Action = actPartnerRefresh
      Category = 0
    end
    object bbPartnerInsert: TdxBarButton
      Action = actMultiPartnerInsert
      Category = 0
    end
    object bbPartnerEdit: TdxBarButton
      Action = actPartnerUpdate
      Category = 0
    end
    object bbContractRefresh: TdxBarButton
      Action = actContractRefresh
      Category = 0
    end
    object bbStatic: TdxBarStatic
      Caption = '   '
      Category = 0
      Hint = '   '
      Visible = ivAlways
    end
    object bbContractInsert: TdxBarButton
      Action = actMultiContractInsert
      Category = 0
    end
    object bbContractUpdate: TdxBarButton
      Action = actContractUpdate
      Category = 0
    end
  end
  object JuridicalDetailsDS: TDataSource
    DataSet = JuridicalDetailsCDS
    Left = 184
    Top = 336
  end
  object JuridicalDetailsCDS: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 200
    Top = 320
  end
  object PartnerDS: TDataSource
    DataSet = PartnerCDS
    Left = 360
    Top = 304
  end
  object PartnerCDS: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 352
    Top = 312
  end
  object ContractDS: TDataSource
    DataSet = ContractCDS
    Left = 448
    Top = 312
  end
  object ContractCDS: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 432
    Top = 312
  end
  object spJuridicalDetails: TdsdStoredProc
    StoredProcName = 'gpSelect_ObjectHistory_JuridicalDetails'
    DataSet = JuridicalDetailsCDS
    DataSets = <
      item
        DataSet = JuridicalDetailsCDS
      end>
    Params = <
      item
        Name = 'injuridicalid'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
      end>
    Left = 224
    Top = 304
  end
  object spPartner: TdsdStoredProc
    StoredProcName = 'gpSelect_Object_PartnerJuridical'
    DataSet = PartnerCDS
    DataSets = <
      item
        DataSet = PartnerCDS
      end>
    Params = <
      item
        Name = 'injuridicalid'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
      end>
    Left = 368
    Top = 296
  end
  object spContract: TdsdStoredProc
    StoredProcName = 'gpSelect_Object_ContractJuridical'
    DataSet = ContractCDS
    DataSets = <
      item
        DataSet = ContractCDS
      end>
    Params = <
      item
        Name = 'injuridicalid'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
      end>
    Left = 456
    Top = 256
  end
  object JuridicalDetailsAddOn: TdsdDBViewAddOn
    ErasedFieldName = 'isErased'
    View = JuridicalDetailsGridDBTableView
    OnDblClickActionList = <>
    ActionItemList = <>
    SortImages = dmMain.SortImageList
    OnlyEditingCellOnEnter = False
    Left = 256
    Top = 288
  end
  object PartnerAddOn: TdsdDBViewAddOn
    ErasedFieldName = 'isErased'
    View = PartnerGridDBTableView
    OnDblClickActionList = <
      item
        Action = actPartnerUpdate
      end>
    ActionItemList = <
      item
        Action = actPartnerUpdate
        ShortCut = 13
      end>
    SortImages = dmMain.SortImageList
    OnlyEditingCellOnEnter = False
    Left = 376
    Top = 288
  end
  object ContractAddOn: TdsdDBViewAddOn
    ErasedFieldName = 'isErased'
    View = ContractGridDBTableView
    OnDblClickActionList = <>
    ActionItemList = <>
    SortImages = dmMain.SortImageList
    OnlyEditingCellOnEnter = False
    Left = 480
    Top = 296
  end
  object spJuridicalDetailsIU: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_ObjectHistory_JuridicalDetails'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'ioid'
        Component = JuridicalDetailsCDS
        ComponentItem = 'Id'
        ParamType = ptInputOutput
      end
      item
        Name = 'injuridicalid'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
      end
      item
        Name = 'inoperdate'
        Component = JuridicalDetailsCDS
        ComponentItem = 'StartDate'
        DataType = ftDateTime
        ParamType = ptInput
      end
      item
        Name = 'inbankid'
        Component = JuridicalDetailsCDS
        ComponentItem = 'BankId'
        ParamType = ptInput
      end
      item
        Name = 'infullname'
        Component = JuridicalDetailsCDS
        ComponentItem = 'FullName'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'injuridicaladdress'
        Component = JuridicalDetailsCDS
        ComponentItem = 'JuridicalAddress'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'inokpo'
        Component = JuridicalDetailsCDS
        ComponentItem = 'OKPO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'ininn'
        Component = JuridicalDetailsCDS
        ComponentItem = 'INN'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'innumbervat'
        Component = JuridicalDetailsCDS
        ComponentItem = 'NumberVAT'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'inaccountername'
        Component = JuridicalDetailsCDS
        ComponentItem = 'AccounterName'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'inbankaccount'
        Component = JuridicalDetailsCDS
        ComponentItem = 'BankAccount'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 280
    Top = 216
  end
end
