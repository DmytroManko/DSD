﻿object InfoMoneyEditForm: TInfoMoneyEditForm
  Left = 0
  Top = 0
  Caption = #1059#1087#1088#1072#1074#1083#1077#1085#1095#1077#1089#1082#1072#1103' '#1089#1090#1072#1090#1100#1103
  ClientHeight = 273
  ClientWidth = 306
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  AddOnFormData.RefreshAction = dsdDataSetRefresh
  AddOnFormData.Params = dsdFormParams
  PixelsPerInch = 96
  TextHeight = 13
  object edName: TcxTextEdit
    Left = 16
    Top = 71
    TabOrder = 0
    Width = 273
  end
  object cxLabel1: TcxLabel
    Left = 16
    Top = 48
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
  end
  object cxButton1: TcxButton
    Left = 40
    Top = 224
    Width = 75
    Height = 25
    Action = dsdInsertUpdateGuides
    Default = True
    TabOrder = 3
  end
  object cxButton2: TcxButton
    Left = 198
    Top = 224
    Width = 75
    Height = 25
    Action = dsdFormClose
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 4
  end
  object Код: TcxLabel
    Left = 16
    Top = 3
    Caption = #1050#1086#1076
  end
  object ceCode: TcxCurrencyEdit
    Left = 16
    Top = 26
    Properties.DecimalPlaces = 0
    Properties.DisplayFormat = '0'
    TabOrder = 5
    Width = 273
  end
  object cxLabel3: TcxLabel
    Left = 16
    Top = 103
    Caption = #1043#1088#1091#1087#1087#1099' '#1091#1087#1088#1072#1074#1083#1077#1085#1095#1077#1089#1082#1080#1093' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1081
  end
  object cxLabel2: TcxLabel
    Left = 16
    Top = 159
    Caption = #1059#1087#1088#1072#1074#1083#1077#1085#1095#1077#1089#1082#1080#1077' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1103
  end
  object ceInfoMoneyGroup: TcxButtonEdit
    Left = 16
    Top = 128
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    TabOrder = 1
    Width = 273
  end
  object ceInfoMoneyDestination: TcxButtonEdit
    Left = 16
    Top = 182
    Properties.Buttons = <
      item
        Default = True
        Kind = bkEllipsis
      end>
    TabOrder = 2
    Width = 273
  end
  object ActionList: TActionList
    Left = 232
    Top = 64
    object dsdDataSetRefresh: TdsdDataSetRefresh
      Category = 'DSDLib'
      StoredProc = spGet
      StoredProcList = <
        item
          StoredProc = spGet
        end
        item
        end>
      Caption = #1055#1077#1088#1077#1095#1080#1090#1072#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      ShortCut = 116
      RefreshOnTabSetChanges = False
    end
    object dsdInsertUpdateGuides: TdsdInsertUpdateGuides
      Category = 'DSDLib'
      StoredProc = spInsertUpdate
      StoredProcList = <
        item
          StoredProc = spInsertUpdate
        end>
      Caption = #1054#1082
    end
    object dsdFormClose: TdsdFormClose
      Category = 'DSDLib'
    end
  end
  object spInsertUpdate: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_Object_InfoMoney'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'ioId'
        Value = Null
        Component = dsdFormParams
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
        Name = 'inInfoMoneyGroupId'
        Value = ''
        Component = dsdInfoMoneyGroupGuides
        ParamType = ptInput
      end
      item
        Name = 'inInfoMoneyDestinationId'
        Value = ''
        Component = dsdInfoMoneyDestinationGuides
        ParamType = ptInput
      end>
    Left = 32
    Top = 120
  end
  object dsdFormParams: TdsdFormParams
    Params = <
      item
        Name = 'Id'
        Value = Null
        ParamType = ptInputOutput
      end>
    Left = 240
    Top = 8
  end
  object spGet: TdsdStoredProc
    StoredProcName = 'gpGet_Object_InfoMoney'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'Id'
        Value = Null
        Component = dsdFormParams
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
        Name = 'InfoMoneyGroupId'
        Value = ''
        Component = dsdInfoMoneyGroupGuides
        ComponentItem = 'Key'
      end
      item
        Name = 'InfoMoneyGroupName'
        Value = ''
        Component = dsdInfoMoneyGroupGuides
        ComponentItem = 'TextValue'
      end
      item
        Name = 'InfoMoneyDestinationId'
        Value = ''
        Component = dsdInfoMoneyDestinationGuides
        ComponentItem = 'Key'
      end
      item
        Name = 'InfoMoneyDestinationName'
        Value = ''
        Component = dsdInfoMoneyDestinationGuides
        ComponentItem = 'TextValue'
      end>
    Top = 120
  end
  object dsdInfoMoneyGroupGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = ceInfoMoneyGroup
    FormName = 'TInfoMoneyGroupForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = dsdInfoMoneyGroupGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = dsdInfoMoneyGroupGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 240
    Top = 117
  end
  object dsdInfoMoneyDestinationGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = ceInfoMoneyDestination
    FormName = 'TInfoMoneyDestinationForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = dsdInfoMoneyDestinationGuides
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = dsdInfoMoneyDestinationGuides
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 248
    Top = 173
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
    Left = 136
    Top = 40
  end
  object dsdUserSettingsStorageAddOn: TdsdUserSettingsStorageAddOn
    Left = 96
    Top = 184
  end
end
