object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 399
  ClientWidth = 830
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GuidePanel: TPanel
    Left = 376
    Top = 0
    Width = 229
    Height = 343
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 0
    object cbAllGuide: TCheckBox
      Tag = 1
      Left = 15
      Top = 1
      Width = 225
      Height = 17
      Caption = #1042#1089#1077' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object cbGoods: TCheckBox
      Tag = 10
      Left = 14
      Top = 55
      Width = 225
      Height = 15
      Caption = '1.3. '#1058#1086#1074#1072#1088#1099
      TabOrder = 1
    end
    object cbMeasure: TCheckBox
      Tag = 10
      Left = 15
      Top = 21
      Width = 225
      Height = 17
      Caption = '1.1. '#1045#1076'.'#1080#1079#1084'.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object cbJuridical: TCheckBox
      Tag = 10
      Left = 15
      Top = 100
      Width = 225
      Height = 17
      Caption = '3.2. '#1070#1088#1080#1076#1080#1095#1077#1089#1082#1080#1077' '#1083#1080#1094#1072
      TabOrder = 3
    end
    object cbUnit: TCheckBox
      Tag = 10
      Left = 15
      Top = 159
      Width = 225
      Height = 17
      Caption = '4.4. '#1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1103' '
      TabOrder = 4
    end
    object cbPriceList: TCheckBox
      Tag = 10
      Left = 14
      Top = 186
      Width = 225
      Height = 17
      Caption = '5.1. '#1055#1088#1072#1081#1089' '#1083#1080#1089#1090#1099
      TabOrder = 5
    end
    object cbPriceListItems: TCheckBox
      Tag = 10
      Left = 15
      Top = 209
      Width = 225
      Height = 17
      Caption = '5.2. '#1055#1088#1072#1081#1089' '#1083#1080#1089#1090#1099' - '#1094#1077#1085#1099
      Enabled = False
      TabOrder = 6
    end
    object cbAccountGroup: TCheckBox
      Tag = 10
      Left = 15
      Top = 511
      Width = 289
      Height = 17
      Caption = '8.1. '#1043#1088#1091#1087#1087#1099' '#1091#1087#1088#1072#1074#1083#1077#1085#1095#1077#1089#1082#1080#1093' '#1089#1095#1077#1090#1086#1074
      TabOrder = 7
    end
    object cbAccountDirection: TCheckBox
      Tag = 10
      Left = 15
      Top = 531
      Width = 289
      Height = 17
      Caption = '8.2. '#1040#1085#1072#1083#1080#1090#1080#1082#1080' '#1091#1087#1088#1072#1074#1083#1077#1085#1095#1077#1089#1082#1080#1093' '#1089#1095#1077#1090#1086#1074' - '#1085#1072#1087#1088#1072#1074#1083#1077#1085#1080#1077
      TabOrder = 8
    end
    object cbAccount: TCheckBox
      Tag = 10
      Left = 15
      Top = 551
      Width = 289
      Height = 17
      Caption = '8.3. '#1059#1087#1088#1072#1074#1083#1077#1085#1095#1077#1089#1082#1080#1077' '#1089#1095#1077#1090#1072
      TabOrder = 9
    end
    object cbBank: TCheckBox
      Tag = 10
      Left = 14
      Top = 122
      Width = 225
      Height = 17
      Caption = '3.2. '#1041#1072#1085#1082#1080
      Enabled = False
      TabOrder = 10
    end
    object cbOwnedType: TCheckBox
      Tag = 10
      Left = 15
      Top = 77
      Width = 225
      Height = 17
      Caption = '3.1. '#1042#1080#1076#1099' '#1089#1086#1073#1089#1090#1074#1077#1085#1085#1086#1089#1090#1080
      Color = clBtnFace
      ParentColor = False
      TabOrder = 11
    end
    object CheckBox1: TCheckBox
      Tag = 10
      Left = 20
      Top = 245
      Width = 225
      Height = 17
      Caption = '3.1. '#1042#1080#1076#1099' '#1089#1086#1073#1089#1090#1074#1077#1085#1085#1086#1089#1090#1080
      Color = clBtnFace
      ParentColor = False
      TabOrder = 12
    end
    object CheckBox2: TCheckBox
      Tag = 10
      Left = 20
      Top = 268
      Width = 225
      Height = 17
      Caption = '3.2. '#1070#1088#1080#1076#1080#1095#1077#1089#1082#1080#1077' '#1083#1080#1094#1072
      TabOrder = 13
    end
    object CheckBox3: TCheckBox
      Tag = 10
      Left = 20
      Top = 290
      Width = 225
      Height = 17
      Caption = '3.2. '#1041#1072#1085#1082#1080
      Enabled = False
      TabOrder = 14
    end
    object cbExtraChargeCategories: TCheckBox
      Tag = 10
      Left = 15
      Top = 37
      Width = 225
      Height = 17
      Caption = '1.2. '#1042#1080#1076#1099' '#1085#1072#1094#1077#1085#1086#1082
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 15
    end
  end
  object DBGrid: TDBGrid
    Left = 0
    Top = 0
    Width = 376
    Height = 343
    Align = alClient
    DataSource = DataSource
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DocumentPanel: TPanel
    Left = 605
    Top = 0
    Width = 225
    Height = 343
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 2
    object Label1: TLabel
      Left = 6
      Top = 24
      Width = 5
      Height = 13
      Caption = #1089
    end
    object Label2: TLabel
      Left = 109
      Top = 27
      Width = 12
      Height = 13
      Caption = #1087#1086
    end
    object cbAllDocument: TCheckBox
      Tag = 2
      Left = 15
      Top = 1
      Width = 194
      Height = 17
      Caption = #1042#1089#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object cbIncome: TCheckBox
      Tag = 20
      Left = 15
      Top = 61
      Width = 194
      Height = 17
      Caption = '1. '#1055#1088#1080#1093#1086#1076' '#1086#1090' '#1087#1086#1089#1090#1072#1074#1097#1080#1082#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object StartDateEdit: TcxDateEdit
      Left = 14
      Top = 22
      TabOrder = 2
      Width = 90
    end
    object EndDateEdit: TcxDateEdit
      Left = 122
      Top = 22
      TabOrder = 3
      Width = 90
    end
  end
  object ButtonPanel: TPanel
    Left = 0
    Top = 343
    Width = 830
    Height = 56
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object Gauge: TGauge
      Left = 0
      Top = 0
      Width = 830
      Height = 19
      Align = alTop
      Progress = 50
      ExplicitWidth = 1307
    end
    object OKGuideButton: TButton
      Left = 56
      Top = 25
      Width = 171
      Height = 25
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      TabOrder = 0
      OnClick = OKGuideButtonClick
    end
    object StopButton: TButton
      Left = 489
      Top = 26
      Width = 137
      Height = 25
      Caption = #1054#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1079#1072#1075#1088#1091#1079#1082#1091
      TabOrder = 1
    end
    object CloseButton: TButton
      Left = 654
      Top = 27
      Width = 87
      Height = 25
      Caption = #1042#1099#1093#1086#1076
      TabOrder = 2
    end
    object cbSetNull_Id_Postgres: TCheckBox
      Left = 775
      Top = 20
      Width = 292
      Height = 17
      Caption = #1044#1083#1103' '#1087#1077#1088#1074#1086#1075#1086' '#1088#1072#1079#1072' set Sybase.'#1042#1057#1045#1052'.Id_Postgres = null'
      TabOrder = 3
    end
    object cbOnlyOpen: TCheckBox
      Left = 775
      Top = 39
      Width = 292
      Height = 17
      Caption = #1054#1090#1082#1083#1102#1095#1080#1090#1100' '#1079#1072#1075#1088#1091#1079#1082#1091' ('#1090#1086#1083#1100#1082#1086' '#1087#1086#1082#1072#1079#1072#1090#1100' '#1076#1072#1085#1085#1099#1077')'
      TabOrder = 4
    end
    object OKDocumentButton: TButton
      Left = 273
      Top = 25
      Width = 171
      Height = 25
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090#1099
      TabOrder = 5
    end
  end
  object DataSource: TDataSource
    DataSet = fromQuery
    Left = 256
    Top = 225
  end
  object fromADOConnection: TADOConnection
    ConnectionString = 
      'Provider=MSDASQL.1;Password=sql;Persist Security Info=True;User ' +
      'ID=dba;Data Source=HouseStoreDS'
    LoginPrompt = False
    Provider = 'MSDASQL.1'
    Left = 352
    Top = 281
  end
  object fromSqlQuery: TADOQuery
    Connection = fromADOConnection
    Parameters = <>
    Left = 392
    Top = 337
  end
  object fromQuery: TADOQuery
    Connection = fromADOConnection
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from Goods where HasChildren<>-1 order by 1 desc')
    Left = 304
    Top = 320
  end
  object toStoredProc: TdsdStoredProc
    DataSets = <>
    Params = <>
    Left = 120
    Top = 416
  end
end
