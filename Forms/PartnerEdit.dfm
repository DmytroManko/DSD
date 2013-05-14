﻿inherited PartnerEditForm: TPartnerEditForm
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1082#1086#1085#1090#1088#1072#1075#1077#1085#1090#1072
  ClientHeight = 230
  ClientWidth = 346
  ExplicitWidth = 354
  ExplicitHeight = 257
  PixelsPerInch = 96
  TextHeight = 13
  object edName: TcxTextEdit
    Left = 40
    Top = 71
    TabOrder = 0
    Width = 273
  end
  object cxLabel1: TcxLabel
    Left = 40
    Top = 48
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
  end
  object cxButton1: TcxButton
    Left = 72
    Top = 169
    Width = 75
    Height = 25
    Action = dsdExecStoredProc
    Default = True
    ModalResult = 8
    TabOrder = 2
  end
  object cxButton2: TcxButton
    Left = 216
    Top = 169
    Width = 75
    Height = 25
    Action = dsdFormClose1
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 8
    TabOrder = 3
  end
  object Код: TcxLabel
    Left = 40
    Top = 3
    Caption = #1050#1086#1076
  end
  object ceCode: TcxCurrencyEdit
    Left = 40
    Top = 26
    Properties.DecimalPlaces = 0
    Properties.DisplayFormat = '0'
    TabOrder = 5
    Width = 273
  end
  object cxLabel2: TcxLabel
    Left = 40
    Top = 104
    Caption = #1050#1086#1076' GLN'
  end
  object edGLNCode: TcxTextEdit
    Left = 40
    Top = 127
    TabOrder = 7
    Width = 107
  end
  object cxLabel3: TcxLabel
    Left = 153
    Top = 104
    Caption = #1070#1088'. '#1083#1080#1094#1086
  end
  object ceJuridical: TcxLookupComboBox
    Left = 153
    Top = 127
    Properties.KeyFieldNames = 'Id'
    Properties.ListColumns = <
      item
        FieldName = 'Name'
      end>
    Properties.ListSource = JuridicalDS
    TabOrder = 9
    Width = 160
  end
  object ActionList: TActionList
    Left = 296
    Top = 72
    object dsdDataSetRefresh: TdsdDataSetRefresh
      Category = 'DSDLib'
      StoredProc = spGet
      StoredProcList = <
        item
          StoredProc = spGet
        end
        item
          StoredProc = spGetJuridical
        end>
      Caption = #1055#1077#1088#1077#1095#1080#1090#1072#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      ShortCut = 116
    end
    object dsdExecStoredProc: TdsdExecStoredProc
      Category = 'DSDLib'
      StoredProc = spInsertUpdate
      StoredProcList = <
        item
          StoredProc = spInsertUpdate
        end>
      Caption = 'Ok'
    end
    object dsdFormClose1: TdsdFormClose
    end
  end
  object spInsertUpdate: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_Object_Juridical'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'ioId'
        Component = dsdFormParams
        ComponentItem = 'Id'
        DataType = ftInteger
        ParamType = ptInputOutput
        Value = '0'
      end
      item
        Name = 'inCode'
        Component = ceCode
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'inName'
        Component = edName
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'inGLNCode'
        Component = edGLNCode
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'inJuridicalId'
        Component = dsdJuridicalGuides
        DataType = ftInteger
        ParamType = ptInput
        Value = '0'
      end>
    Left = 240
    Top = 48
  end
  object dsdFormParams: TdsdFormParams
    Params = <
      item
        Name = 'Id'
        DataType = ftInteger
        ParamType = ptInputOutput
        Value = '0'
      end>
    Left = 240
    Top = 8
  end
  object spGet: TdsdStoredProc
    StoredProcName = 'gpGet_Object_Juridical'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'Id'
        Component = dsdFormParams
        ComponentItem = 'Id'
        DataType = ftInteger
        ParamType = ptInput
        Value = '0'
      end
      item
        Name = 'Name'
        Component = edName
        DataType = ftString
        ParamType = ptOutput
      end
      item
        Name = 'Code'
        Component = ceCode
        DataType = ftInteger
        ParamType = ptOutput
      end
      item
        Name = 'GLNCode'
        Component = edGLNCode
        DataType = ftString
        ParamType = ptOutput
      end
      item
        Name = 'JuridicalId'
        Component = dsdJuridicalGuides
        ComponentItem = 'Id'
        DataType = ftInteger
        ParamType = ptOutput
        Value = '0'
      end
      item
        Name = 'JuridicalName'
        Component = dsdJuridicalGuides
        ComponentItem = 'Name'
        DataType = ftString
        ParamType = ptOutput
        Value = '0'
      end>
    Left = 192
    Top = 88
  end
  object JuridicalDataSet: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 176
    Top = 176
  end
  object spGetJuridical: TdsdStoredProc
    StoredProcName = 'gpSelect_Object_Juridical'
    DataSet = JuridicalDataSet
    DataSets = <
      item
        DataSet = JuridicalDataSet
      end>
    Params = <>
    Left = 216
    Top = 176
  end
  object JuridicalDS: TDataSource
    DataSet = JuridicalDataSet
    Left = 256
    Top = 176
  end
  object dsdJuridicalGuides: TdsdGuides
    LookupControl = ceJuridical
    Left = 312
    Top = 184
  end
end