﻿object TransportForm: TTransportForm
  Left = 0
  Top = 0
  Caption = #1044#1086#1082#1091#1084#1077#1085#1090' <'#1055#1091#1090#1077#1074#1086#1081' '#1083#1080#1089#1090'>'
  ClientHeight = 455
  ClientWidth = 996
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  PopupMenu = PopupMenu
  isAlwaysRefresh = False
  isFree = True
  PixelsPerInch = 96
  TextHeight = 13
  object DataPanel: TPanel
    Left = 0
    Top = 0
    Width = 996
    Height = 100
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object edInvNumber: TcxTextEdit
      Left = 8
      Top = 23
      Enabled = False
      TabOrder = 0
      Width = 95
    end
    object cxLabel1: TcxLabel
      Left = 8
      Top = 5
      Caption = #8470' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
    end
    object edOperDate: TcxDateEdit
      Left = 108
      Top = 23
      Properties.SaveTime = False
      Properties.ShowTime = False
      TabOrder = 1
      Width = 88
    end
    object cxLabel2: TcxLabel
      Left = 110
      Top = 5
      Caption = #1044#1072#1090#1072
    end
    object edUnitForwarding: TcxButtonEdit
      Left = 844
      Top = 23
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 12
      Width = 150
    end
    object edCar: TcxButtonEdit
      Left = 201
      Top = 23
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 2
      Width = 100
    end
    object cxLabel3: TcxLabel
      Left = 844
      Top = 5
      Caption = #1052#1077#1089#1090#1086' '#1086#1090#1087#1088#1072#1074#1082#1080
    end
    object cxLabel4: TcxLabel
      Left = 201
      Top = 5
      Caption = #1040#1074#1090#1086#1084#1086#1073#1080#1083#1100' '
    end
    object edPersonalDriver: TcxButtonEdit
      Left = 182
      Top = 63
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 3
      Width = 119
    end
    object cxLabel5: TcxLabel
      Left = 182
      Top = 45
      Caption = #1042#1086#1076#1080#1090#1077#1083#1100
    end
    object edPersonalDriverMore: TcxButtonEdit
      Left = 691
      Top = 63
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 11
      Width = 147
    end
    object cxLabel6: TcxLabel
      Left = 691
      Top = 45
      Caption = #1042#1086#1076#1080#1090#1077#1083#1100', '#1076#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1081
    end
    object edCarTrailer: TcxButtonEdit
      Left = 691
      Top = 23
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      TabOrder = 10
      Width = 147
    end
    object cxLabel7: TcxLabel
      Left = 691
      Top = 5
      Caption = #1055#1088#1080#1094#1077#1087
    end
    object edStartRunPlan: TcxDateEdit
      Left = 307
      Top = 23
      Properties.DateButtons = [btnClear, btnToday]
      Properties.InputKind = ikMask
      Properties.Kind = ckDateTime
      TabOrder = 4
      Width = 145
    end
    object cxLabel8: TcxLabel
      Left = 307
      Top = 5
      Caption = #1044#1072#1090#1072'/'#1042#1088'.'#1074#1099#1077#1079#1076#1072' '#1087#1083#1072#1085' '
    end
    object edEndRunPlan: TcxDateEdit
      Left = 307
      Top = 63
      Properties.Kind = ckDateTime
      TabOrder = 5
      Width = 145
    end
    object cxLabel9: TcxLabel
      Left = 307
      Top = 45
      Caption = #1044#1072#1090#1072'/'#1042#1088'.'#1074#1086#1079#1074#1088#1072#1097#1077#1085#1080#1103' '#1087#1083#1072#1085
    end
    object cxLabel10: TcxLabel
      Left = 458
      Top = 5
      Caption = #1044#1072#1090#1072'/'#1042#1088'.'#1074#1099#1077#1079#1076#1072' '#1092#1072#1082#1090
    end
    object edStartRun: TcxDateEdit
      Left = 458
      Top = 23
      Properties.InputKind = ikMask
      Properties.Kind = ckDateTime
      TabOrder = 6
      Width = 147
    end
    object cxLabel11: TcxLabel
      Left = 458
      Top = 45
      Caption = #1044#1072#1090#1072'/'#1042#1088'.'#1074#1086#1079#1074#1088#1072#1097#1077#1085#1080#1103' '#1092#1072#1082#1090
    end
    object edEndRun: TcxDateEdit
      Left = 458
      Top = 63
      Properties.Kind = ckDateTime
      TabOrder = 7
      Width = 147
    end
    object edComment: TcxTextEdit
      Left = 844
      Top = 63
      TabOrder = 13
      Width = 150
    end
    object cxLabel12: TcxLabel
      Left = 844
      Top = 45
      Caption = ' '#1055#1088#1080#1084#1077#1095#1072#1085#1080#1077' '
    end
    object edHoursWork: TcxCurrencyEdit
      Left = 612
      Top = 23
      Enabled = False
      Properties.Alignment.Horz = taRightJustify
      Properties.Alignment.Vert = taVCenter
      Properties.DecimalPlaces = 0
      Properties.DisplayFormat = ',0'
      TabOrder = 8
      Width = 71
    end
    object cxLabel13: TcxLabel
      Left = 612
      Top = 5
      Caption = #1050#1086#1083'-'#1074#1086' '#1095#1072#1089#1086#1074
    end
    object edHoursAdd: TcxCurrencyEdit
      Left = 612
      Top = 63
      Properties.Alignment.Horz = taRightJustify
      Properties.Alignment.Vert = taVCenter
      Properties.DecimalPlaces = 0
      Properties.DisplayFormat = ',0'
      TabOrder = 9
      Width = 71
    end
    object cxLabel14: TcxLabel
      Left = 612
      Top = 45
      Caption = #1044#1086#1087'. '#1095#1072#1089#1099
    end
    object ceStatus: TcxButtonEdit
      Left = 9
      Top = 63
      Properties.Buttons = <
        item
          Action = CompleteMovement
          Kind = bkGlyph
        end
        item
          Action = UnCompleteMovement
          Default = True
          Kind = bkGlyph
        end
        item
          Action = DeleteMovement
          Kind = bkGlyph
        end>
      Properties.Images = dmMain.ImageList
      TabOrder = 28
      Width = 152
    end
    object cxLabel15: TcxLabel
      Left = 8
      Top = 45
      Caption = #1057#1090#1072#1090#1091#1089
    end
  end
  object cxPageControl: TcxPageControl
    Left = 0
    Top = 126
    Width = 996
    Height = 329
    Align = alClient
    TabOrder = 1
    Properties.ActivePage = cxTabSheetMain
    Properties.CustomButtons.Buttons = <>
    ClientRectBottom = 329
    ClientRectRight = 996
    ClientRectTop = 24
    object cxTabSheetMain: TcxTabSheet
      Caption = #1057#1090#1088#1086#1095#1085#1072#1103' '#1095#1072#1089#1090#1100
      ImageIndex = 0
      object cxGrid: TcxGrid
        Left = 0
        Top = 0
        Width = 996
        Height = 160
        Align = alClient
        TabOrder = 0
        object cxGridDBTableView: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = MasterDS
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <
            item
              Kind = skSum
              Position = spFooter
            end
            item
              Kind = skSum
              Position = spFooter
            end
            item
              Kind = skSum
              Position = spFooter
              Column = colWeight
            end
            item
              Kind = skSum
              Position = spFooter
              Column = colAmount
            end
            item
              Kind = skSum
              Position = spFooter
              Column = colEndOdometre
            end
            item
              Kind = skSum
              Position = spFooter
            end>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skSum
            end
            item
              Kind = skSum
            end
            item
              Kind = skSum
              Column = colWeight
            end
            item
              Kind = skSum
              Column = colAmount
            end
            item
              Kind = skSum
              Column = colEndOdometre
            end
            item
              Kind = skSum
            end>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsBehavior.FocusCellOnCycle = True
          OptionsCustomize.ColumnHiding = True
          OptionsCustomize.ColumnsQuickCustomization = True
          OptionsCustomize.DataRowSizing = True
          OptionsData.CancelOnExit = False
          OptionsData.Inserting = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          OptionsView.Indicator = True
          Styles.StyleSheet = dmMain.cxGridTableViewStyleSheet
          object colRouteCode: TcxGridDBColumn
            Caption = #1050#1086#1076
            DataBinding.FieldName = 'RouteCode'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 70
          end
          object colRouteName: TcxGridDBColumn
            Caption = #1052#1072#1088#1096#1088#1091#1090
            DataBinding.FieldName = 'RouteName'
            PropertiesClassName = 'TcxButtonEditProperties'
            Properties.Buttons = <
              item
                Action = RouteChoiceForm
                Default = True
                Kind = bkEllipsis
              end>
            Properties.ReadOnly = True
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 150
          end
          object colFreightName: TcxGridDBColumn
            Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1075#1088#1091#1079#1072
            DataBinding.FieldName = 'FreightName'
            PropertiesClassName = 'TcxButtonEditProperties'
            Properties.Buttons = <
              item
                Action = FreightChoiceForm
                Default = True
                Kind = bkEllipsis
              end>
            Properties.ReadOnly = True
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 90
          end
          object colAmount: TcxGridDBColumn
            Caption = #1055#1088#1086#1073#1077#1075', '#1082#1084' ('#1086#1089#1085#1086#1074#1085#1086#1081')'
            DataBinding.FieldName = 'Amount'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 100
          end
          object colDistanceFuelChild: TcxGridDBColumn
            Caption = #1055#1088#1086#1073#1077#1075', '#1082#1084' ('#1076#1086#1087#1086#1083#1085#1080#1090'.)'
            DataBinding.FieldName = 'DistanceFuelChild'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 100
          end
          object colStartOdometre: TcxGridDBColumn
            Caption = #1057#1087#1080#1076#1086#1084#1077#1090#1088' '#1085#1072#1095'. '#1087#1086#1082#1072#1079#1072#1085#1080#1077', '#1082#1084
            DataBinding.FieldName = 'StartOdometre'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 110
          end
          object colEndOdometre: TcxGridDBColumn
            Caption = #1057#1087#1080#1076#1086#1084#1077#1090#1088' '#1082#1086#1085#1077#1095'. '#1087#1086#1082#1072#1079#1072#1085#1080#1077', '#1082#1084
            DataBinding.FieldName = 'EndOdometre'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 110
          end
          object colWeight: TcxGridDBColumn
            Caption = #1042#1077#1089' '#1075#1088#1091#1079#1072', '#1082#1075
            DataBinding.FieldName = 'Weight'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 70
          end
          object colRouteKindName: TcxGridDBColumn
            Caption = #1058#1080#1087' '#1084#1072#1088#1096#1088#1091#1090#1072
            DataBinding.FieldName = 'RouteKindName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 70
          end
          object colIsErased: TcxGridDBColumn
            Caption = #1059#1076#1072#1083#1077#1085' ('#1076#1072'/'#1085#1077#1090')'
            DataBinding.FieldName = 'isErased'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 55
          end
        end
        object cxGridLevel: TcxGridLevel
          GridView = cxGridDBTableView
        end
      end
      object cxGridChild: TcxGrid
        Left = 0
        Top = 165
        Width = 996
        Height = 140
        Align = alBottom
        TabOrder = 1
        object cxGridChildDBTableView: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = ChildDS
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <
            item
              Kind = skSum
              Position = spFooter
            end
            item
              Kind = skSum
              Position = spFooter
            end
            item
              Kind = skSum
              Position = spFooter
            end
            item
              Kind = skSum
              Position = spFooter
              Column = colсhAmount
            end
            item
              Kind = skSum
              Position = spFooter
            end
            item
              Kind = skSum
              Position = spFooter
            end>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skSum
            end
            item
              Kind = skSum
            end
            item
              Kind = skSum
            end
            item
              Kind = skSum
              Column = colсhAmount
            end
            item
              Kind = skSum
            end
            item
              Kind = skSum
            end>
          DataController.Summary.SummaryGroups = <>
          Images = dmMain.SortImageList
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsCustomize.ColumnHiding = True
          OptionsCustomize.ColumnsQuickCustomization = True
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          OptionsView.Indicator = True
          Styles.StyleSheet = dmMain.cxGridTableViewStyleSheet
          object colchNumber: TcxGridDBColumn
            Caption = #8470' '#1087'/'#1087
            DataBinding.FieldName = 'Number'
            HeaderAlignmentHorz = taRightJustify
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 36
          end
          object colchIsMasterFuel: TcxGridDBColumn
            Caption = #1054#1089#1085#1086#1074#1085#1086#1081' ('#1076#1072'/'#1085#1077#1090')'
            DataBinding.FieldName = 'isMasterFuel'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 80
          end
          object colсhFuelCode: TcxGridDBColumn
            Caption = #1050#1086#1076
            DataBinding.FieldName = 'FuelCode'
            Visible = False
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 50
          end
          object colсhFuelName: TcxGridDBColumn
            Caption = #1042#1080#1076' '#1090#1086#1087#1083#1080#1074#1072
            DataBinding.FieldName = 'FuelName'
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 166
          end
          object colсhIsCalculated: TcxGridDBColumn
            Caption = #1060#1072#1082#1090' '#1088#1072#1089#1095#1077#1090' ('#1076#1072'/'#1085#1077#1090')'
            DataBinding.FieldName = 'isCalculated'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Width = 64
          end
          object colсhAmount: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086' '#1092#1072#1082#1090
            DataBinding.FieldName = 'Amount'
            HeaderAlignmentHorz = taRightJustify
            HeaderAlignmentVert = vaCenter
            Width = 75
          end
          object colсhAmount_calc: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086' '#1088#1072#1089#1095#1077#1090
            DataBinding.FieldName = 'Amount_calc'
            HeaderAlignmentHorz = taRightJustify
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 67
          end
          object colсhAmountFuel: TcxGridDBColumn
            Caption = #1053#1086#1088#1084#1072' '#1085#1072' 100 '#1082#1084
            DataBinding.FieldName = 'AmountFuel'
            HeaderAlignmentHorz = taRightJustify
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 74
          end
          object colсhColdHour: TcxGridDBColumn
            Caption = #1063#1072#1089#1086#1074' '#1092#1072#1082#1090', '#1093#1086#1083#1086#1076
            DataBinding.FieldName = 'ColdHour'
            HeaderAlignmentHorz = taRightJustify
            HeaderAlignmentVert = vaCenter
            Width = 60
          end
          object colсhColdDistance: TcxGridDBColumn
            Caption = #1050#1084'. '#1092#1072#1082#1090', '#1093#1086#1083#1086#1076
            DataBinding.FieldName = 'ColdDistance'
            HeaderAlignmentHorz = taRightJustify
            HeaderAlignmentVert = vaCenter
            Width = 60
          end
          object colсhAmountColdHour: TcxGridDBColumn
            Caption = #1053#1086#1088#1084#1072' '#1085#1072' '#1093#1086#1083#1086#1076', '#1074' '#1095#1072#1089
            DataBinding.FieldName = 'AmountColdHour'
            HeaderAlignmentHorz = taRightJustify
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 75
          end
          object colсhAmountColdDistance: TcxGridDBColumn
            Caption = #1053#1086#1088#1084#1072' '#1085#1072' '#1093#1086#1083#1086#1076', '#1079#1072' 100 '#1082#1084
            DataBinding.FieldName = 'AmountColdDistance'
            HeaderAlignmentHorz = taRightJustify
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 75
          end
          object colсhRateFuelKindName: TcxGridDBColumn
            Caption = #1042#1080#1076' '#1085#1086#1088#1084#1099
            DataBinding.FieldName = 'RateFuelKindName'
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 91
          end
          object colchRateFuelKindTax: TcxGridDBColumn
            Caption = '% '#1089#1077#1079#1086#1085', '#1090#1077#1084#1087'.'
            DataBinding.FieldName = 'RateFuelKindTax'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 59
          end
          object colchRatioFuel: TcxGridDBColumn
            Caption = #1050#1086#1101#1092#1092'. '#1087#1077#1088#1077#1074#1086#1076#1072' '#1085#1086#1088#1084#1099
            DataBinding.FieldName = 'RatioFuel'
            Width = 70
          end
        end
        object cxGridChildLevel: TcxGridLevel
          GridView = cxGridChildDBTableView
        end
      end
      object cxSplitterChild: TcxSplitter
        Left = 0
        Top = 160
        Width = 996
        Height = 5
        AlignSplitter = salBottom
        Control = cxGridChild
      end
    end
    object cxTabSheetIncome: TcxTabSheet
      Caption = #1055#1088#1080#1093#1086#1076
      ImageIndex = 2
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object cxGridIncome: TcxGrid
        Left = 0
        Top = 0
        Width = 996
        Height = 305
        Align = alClient
        TabOrder = 0
        object cxGridIncomeDBTableView: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = IncomeDS
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <
            item
              Kind = skSum
              Position = spFooter
            end
            item
              Kind = skSum
              Position = spFooter
            end
            item
              Kind = skSum
              Position = spFooter
            end
            item
              Kind = skSum
              Position = spFooter
              Column = clincAmount
            end
            item
              Kind = skSum
              Position = spFooter
              Column = clincAmountSumm
            end
            item
              Kind = skSum
              Position = spFooter
              Column = clincAmountSummTotal
            end>
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skSum
            end
            item
              Kind = skSum
            end
            item
              Kind = skSum
            end
            item
              Kind = skSum
              Column = clincAmount
            end
            item
              Kind = skSum
              Column = clincAmountSumm
            end
            item
              Kind = skSum
              Column = clincAmountSummTotal
            end>
          DataController.Summary.SummaryGroups = <>
          Images = dmMain.SortImageList
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsBehavior.FocusCellOnCycle = True
          OptionsCustomize.ColumnHiding = True
          OptionsCustomize.ColumnsQuickCustomization = True
          OptionsCustomize.DataRowSizing = True
          OptionsData.CancelOnExit = False
          OptionsData.Inserting = False
          OptionsView.ColumnAutoWidth = True
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          OptionsView.Indicator = True
          Styles.StyleSheet = dmMain.cxGridTableViewStyleSheet
          object clincStatusCode: TcxGridDBColumn
            Caption = #1057#1090#1072#1090#1091#1089
            DataBinding.FieldName = 'StatusCode'
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.Images = dmMain.ImageList
            Properties.Items = <
              item
                Description = #1053#1077' '#1087#1088#1086#1074#1077#1076#1077#1085
                ImageIndex = 11
                Value = 1
              end
              item
                Description = #1055#1088#1086#1074#1077#1076#1077#1085
                ImageIndex = 12
                Value = 2
              end
              item
                Description = #1059#1076#1072#1083#1077#1085
                ImageIndex = 13
                Value = 3
              end>
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 68
          end
          object clincInvNumber: TcxGridDBColumn
            Caption = #8470' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
            DataBinding.FieldName = 'InvNumber'
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 50
          end
          object clincInvNumberPartner: TcxGridDBColumn
            Caption = #8470' '#1095#1077#1082#1072
            DataBinding.FieldName = 'InvNumberPartner'
            HeaderAlignmentVert = vaCenter
            Width = 45
          end
          object clincOperDate: TcxGridDBColumn
            Caption = #1044#1072#1090#1072
            DataBinding.FieldName = 'OperDate'
            HeaderAlignmentVert = vaCenter
            Width = 60
          end
          object clincFromName: TcxGridDBColumn
            Caption = #1054#1090' '#1082#1086#1075#1086' ('#1050#1086#1085#1090#1088#1072#1075#1077#1085#1090')'
            DataBinding.FieldName = 'FromName'
            PropertiesClassName = 'TcxButtonEditProperties'
            Properties.Buttons = <
              item
                Action = PartnerChoiceForm
                Default = True
                Kind = bkEllipsis
              end>
            Properties.ReadOnly = True
            HeaderAlignmentVert = vaCenter
            Width = 100
          end
          object clincPaidKindName: TcxGridDBColumn
            Caption = #1060#1086#1088#1084#1072' '#1086#1087#1083#1072#1090#1099
            DataBinding.FieldName = 'PaidKindName'
            PropertiesClassName = 'TcxButtonEditProperties'
            Properties.Buttons = <
              item
                Action = PaidKindChoiceForm
                Default = True
                Kind = bkEllipsis
              end>
            Properties.ReadOnly = True
            HeaderAlignmentVert = vaCenter
            Width = 60
          end
          object clincRouteName: TcxGridDBColumn
            Caption = #1052#1072#1088#1096#1088#1091#1090
            DataBinding.FieldName = 'RouteName'
            PropertiesClassName = 'TcxButtonEditProperties'
            Properties.Buttons = <
              item
                Action = RouteIncomeChoiceForm
                Default = True
                Kind = bkEllipsis
              end>
            Properties.ReadOnly = True
            HeaderAlignmentVert = vaCenter
            Width = 70
          end
          object clincGoodsCode: TcxGridDBColumn
            Caption = #1050#1086#1076
            DataBinding.FieldName = 'GoodsCode'
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 45
          end
          object clincGoodsName: TcxGridDBColumn
            Caption = #1058#1086#1074#1072#1088
            DataBinding.FieldName = 'GoodsName'
            PropertiesClassName = 'TcxButtonEditProperties'
            Properties.Buttons = <
              item
                Action = GoodsChoiceForm
                Default = True
                Kind = bkEllipsis
              end>
            Properties.ReadOnly = True
            HeaderAlignmentVert = vaCenter
            Width = 100
          end
          object clincFuelName: TcxGridDBColumn
            Caption = #1042#1080#1076' '#1090#1086#1087#1083#1080#1074#1072
            DataBinding.FieldName = 'FuelName'
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 100
          end
          object clincAmount: TcxGridDBColumn
            Caption = #1050#1086#1083'-'#1074#1086
            DataBinding.FieldName = 'Amount'
            HeaderAlignmentVert = vaCenter
            Width = 50
          end
          object clincPrice: TcxGridDBColumn
            Caption = #1062#1077#1085#1072
            DataBinding.FieldName = 'Price'
            HeaderAlignmentVert = vaCenter
            Width = 50
          end
          object clincAmountSumm: TcxGridDBColumn
            Caption = #1057#1091#1084#1084#1072
            DataBinding.FieldName = 'AmountSumm'
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 55
          end
          object clincAmountSummTotal: TcxGridDBColumn
            Caption = #1057#1091#1084#1084#1072' '#1089' '#1053#1044#1057' ('#1080#1090#1086#1075')'
            DataBinding.FieldName = 'AmountSummTotal'
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 55
          end
          object clincPriceWithVAT: TcxGridDBColumn
            Caption = #1062#1077#1085#1099' '#1089' '#1053#1044#1057' ('#1076#1072'/'#1085#1077#1090')'
            DataBinding.FieldName = 'PriceWithVAT'
            HeaderAlignmentVert = vaCenter
            Width = 55
          end
          object clincVATPercent: TcxGridDBColumn
            Caption = '% '#1053#1044#1057
            DataBinding.FieldName = 'VATPercent'
            HeaderAlignmentVert = vaCenter
            Width = 40
          end
          object clincCountForPrice: TcxGridDBColumn
            Caption = #1050#1086#1083' '#1074' '#1094#1077#1085#1077
            DataBinding.FieldName = 'CountForPrice'
            Visible = False
            HeaderAlignmentVert = vaCenter
            Width = 50
          end
          object clincIsErased: TcxGridDBColumn
            Caption = #1059#1076#1072#1083#1077#1085' ('#1076#1072'/'#1085#1077#1090')'
            DataBinding.FieldName = 'isErased'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
          end
        end
        object cxGridIncomeLevel: TcxGridLevel
          GridView = cxGridIncomeDBTableView
        end
      end
    end
    object cxTabSheetEntry: TcxTabSheet
      Caption = #1055#1088#1086#1074#1086#1076#1082#1080
      ImageIndex = 1
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object cxGridEntry: TcxGrid
        Left = 0
        Top = 0
        Width = 996
        Height = 305
        Align = alClient
        TabOrder = 0
        object cxGridEntryDBTableView: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = EntryDS
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <
            item
              Format = ',0.00'
              Kind = skSum
              Column = colKreditAmount
            end
            item
              Format = ',0.00'
              Kind = skSum
              Column = colDebetAmount
            end>
          DataController.Summary.SummaryGroups = <>
          Images = dmMain.SortImageList
          OptionsCustomize.ColumnsQuickCustomization = True
          OptionsView.ColumnAutoWidth = True
          OptionsView.Footer = True
          OptionsView.HeaderAutoHeight = True
          Styles.StyleSheet = dmMain.cxGridTableViewStyleSheet
          object colAccountCode: TcxGridDBColumn
            Caption = #1050#1086#1076' '#1089#1095#1077#1090#1072
            DataBinding.FieldName = 'AccountCode'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 40
          end
          object colDebetAccountGroupName: TcxGridDBColumn
            Caption = #1057#1095#1077#1090' '#1044' '#1043#1088#1091#1087#1087#1072
            DataBinding.FieldName = 'DebetAccountGroupName'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 90
          end
          object colDebetAccountDirectionName: TcxGridDBColumn
            Caption = #1057#1095#1077#1090' '#1044' '#1053#1072#1087#1088#1072#1074#1083
            DataBinding.FieldName = 'DebetAccountDirectionName'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 90
          end
          object colDebetAccountName: TcxGridDBColumn
            Caption = #1057#1095#1077#1090' '#1044#1077#1073#1077#1090
            DataBinding.FieldName = 'DebetAccountName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 120
          end
          object colKreditAccountGroupName: TcxGridDBColumn
            Caption = #1057#1095#1077#1090' '#1050' '#1043#1088#1091#1087#1087#1072
            DataBinding.FieldName = 'KreditAccountGroupName'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 80
          end
          object colKreditAccountDirectionName: TcxGridDBColumn
            Caption = #1057#1095#1077#1090' '#1050' '#1053#1072#1087#1088#1072#1074#1083
            DataBinding.FieldName = 'KreditAccountDirectionName'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 80
          end
          object colKreditAccountName: TcxGridDBColumn
            Caption = #1057#1095#1077#1090' '#1050#1088#1077#1076#1080#1090
            DataBinding.FieldName = 'KreditAccountName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 120
          end
          object colDirectionObjectCode: TcxGridDBColumn
            Caption = #1050#1086#1076' '#1086#1073'.'#1085#1072#1087#1088'.'
            DataBinding.FieldName = 'DirectionObjectCode'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 40
          end
          object colDirectionObjectName: TcxGridDBColumn
            Caption = #1054#1073#1098#1077#1082#1090' '#1085#1072#1087#1088#1072#1074#1083#1077#1085#1080#1077
            DataBinding.FieldName = 'DirectionObjectName'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 80
          end
          object colDestinationObjectCode: TcxGridDBColumn
            Caption = #1050#1086#1076' '#1086#1073'.'#1085#1072#1079#1085'.'
            DataBinding.FieldName = 'DestinationObjectCode'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 40
          end
          object colDestinationObjectName: TcxGridDBColumn
            Caption = #1054#1073#1098#1077#1082#1090' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1077
            DataBinding.FieldName = 'DestinationObjectName'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 80
          end
          object colAccountOnComplete: TcxGridDBColumn
            Caption = '***'
            DataBinding.FieldName = 'AccountOnComplete'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 25
          end
          object colDebetAmount: TcxGridDBColumn
            Caption = #1057#1091#1084#1084#1072' '#1076#1077#1073#1077#1090
            DataBinding.FieldName = 'DebetAmount'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 70
          end
          object colKreditAmount: TcxGridDBColumn
            Caption = #1057#1091#1084#1084#1072' '#1082#1088#1077#1076#1080#1090
            DataBinding.FieldName = 'KreditAmount'
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 70
          end
          object colInfoMoneyName: TcxGridDBColumn
            Caption = #1057#1090#1072#1090#1100#1103' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1103
            DataBinding.FieldName = 'InfoMoneyName'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 55
          end
          object colInfoMoneyName_Detail: TcxGridDBColumn
            Caption = #1057#1090#1072#1090#1100#1103' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1103' '#1076#1077#1090#1072#1083#1100#1085#1086
            DataBinding.FieldName = 'InfoMoneyName_Detail'
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderAlignmentVert = vaCenter
            Options.Editing = False
            Width = 55
          end
        end
        object cxGridEntryLevel: TcxGridLevel
          GridView = cxGridEntryDBTableView
        end
      end
    end
  end
  object FormParams: TdsdFormParams
    Params = <
      item
        Name = 'Id'
        Value = Null
        ParamType = ptInputOutput
      end>
    Left = 208
    Top = 336
  end
  object spSelectMI: TdsdStoredProc
    StoredProcName = 'gpSelect_MI_Transport'
    DataSet = MasterCDS
    DataSets = <
      item
        DataSet = MasterCDS
      end
      item
        DataSet = ChildCDS
      end>
    OutputType = otMultiDataSet
    Params = <
      item
        Name = 'inMovementId'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
      end
      item
        Name = 'inShowAll'
        Value = False
        Component = BooleanStoredProcAction
        DataType = ftBoolean
        ParamType = ptInput
      end
      item
        Name = 'inIsErased'
        Value = False
        Component = ShowErasedAction
        DataType = ftBoolean
        ParamType = ptInput
      end>
    Left = 105
    Top = 226
  end
  object cxPropertiesStore: TcxPropertiesStore
    Components = <
      item
        Component = cxGrid
        Properties.Strings = (
          'Height')
      end
      item
        Component = cxGridChild
        Properties.Strings = (
          'Height')
      end
      item
        Component = cxSplitterChild
        Properties.Strings = (
          'Top')
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
    Left = 80
    Top = 182
  end
  object ActionList: TActionList
    Images = dmMain.ImageList
    Left = 53
    Top = 182
    object actInsertUpdateMovement: TdsdExecStoredProc
      Category = 'DSDLib'
      StoredProc = spInsertUpdateMovement
      StoredProcList = <
        item
          StoredProc = spInsertUpdateMovement
        end>
      Caption = #1057#1086#1093#1088#1072#1085#1077#1085#1080#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      Hint = #1057#1086#1093#1088#1072#1085#1077#1085#1080#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      ImageIndex = 14
      ShortCut = 113
    end
    object ShowErasedAction: TBooleanStoredProcAction
      Category = 'DSDLib'
      StoredProc = spSelectMI
      StoredProcList = <
        item
          StoredProc = spSelectMI
        end
        item
          StoredProc = spSelectMIIncome
        end>
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077
      ImageIndex = 64
      Value = False
      HintTrue = #1055#1086#1082#1072#1079#1072#1090#1100' '#1085#1077' '#1091#1076#1072#1083#1077#1085#1085#1099#1077
      HintFalse = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077
      CaptionTrue = #1055#1086#1082#1072#1079#1072#1090#1100' '#1085#1077' '#1091#1076#1072#1083#1077#1085#1085#1099#1077
      CaptionFalse = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077
      ImageIndexTrue = 65
      ImageIndexFalse = 64
    end
    object BooleanStoredProcAction: TBooleanStoredProcAction
      Category = 'DSDLib'
      TabSheet = cxTabSheetMain
      StoredProc = spSelectMI
      StoredProcList = <
        item
          StoredProc = spSelectMI
        end>
      Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1077#1089#1100' '#1089#1087#1080#1089#1086#1082
      Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1077#1089#1100' '#1089#1087#1080#1089#1086#1082
      ImageIndex = 63
      Value = False
      HintTrue = #1055#1086#1082#1072#1079#1072#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1080#1079' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      HintFalse = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1077#1089#1100' '#1089#1087#1080#1089#1086#1082
      CaptionTrue = #1055#1086#1082#1072#1079#1072#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1080#1079' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      CaptionFalse = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1077#1089#1100' '#1089#1087#1080#1089#1086#1082
      ImageIndexTrue = 62
      ImageIndexFalse = 63
    end
    object actRefresh: TdsdDataSetRefresh
      Category = 'DSDLib'
      StoredProc = spGet
      StoredProcList = <
        item
          StoredProc = spGet
        end
        item
          StoredProc = spSelectMI
        end
        item
          StoredProc = spSelectMIIncome
        end
        item
          StoredProc = spSelectMIContainer
        end>
      Caption = #1055#1077#1088#1077#1095#1080#1090#1072#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      ImageIndex = 4
      ShortCut = 116
    end
    object actPrint: TdsdPrintAction
      Category = 'DSDLib'
      StoredProcList = <>
      Caption = #1055#1077#1095#1072#1090#1100
      Hint = #1055#1077#1095#1072#1090#1100
      ImageIndex = 3
      ShortCut = 16464
      Params = <>
      ReportName = #1055#1091#1090#1077#1074#1086#1081' '#1083#1080#1089#1090
    end
    object GridToExcel: TdsdGridToExcel
      Category = 'DSDLib'
      Caption = #1042#1099#1075#1088#1091#1079#1082#1072' '#1074' Excel'
      Hint = #1042#1099#1075#1088#1091#1079#1082#1072' '#1074' Excel'
      ImageIndex = 6
      ShortCut = 16472
    end
    object actUpdateMasterDS: TdsdUpdateDataSet
      Category = 'DSDLib'
      StoredProc = spInsertUpdateMIMaster
      StoredProcList = <
        item
          StoredProc = spInsertUpdateMIMaster
        end
        item
          StoredProc = spSelectMI
        end>
      Caption = 'actUpdateMasterDS'
      DataSource = MasterDS
    end
    object actUpdateChildDS: TdsdUpdateDataSet
      Category = 'DSDLib'
      StoredProc = spInsertUpdateMIChild
      StoredProcList = <
        item
          StoredProc = spInsertUpdateMIChild
        end>
      Caption = 'actUpdateChildDS'
      DataSource = ChildDS
    end
    object actUpdateIncomeDS: TdsdUpdateDataSet
      Category = 'DSDLib'
      StoredProc = spInsertUpdateMIIncome
      StoredProcList = <
        item
          StoredProc = spInsertUpdateMIIncome
        end>
      Caption = 'actUpdateIncomeDS'
      DataSource = IncomeDS
    end
    object InsertRecord: TInsertRecord
      Category = 'DSDLib'
      TabSheet = cxTabSheetMain
      View = cxGridDBTableView
      Action = RouteChoiceForm
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' <'#1052#1072#1088#1096#1088#1091#1090'>'
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' <'#1052#1072#1088#1096#1088#1091#1090'>'
      ShortCut = 45
      ImageIndex = 0
    end
    object SetErased: TdsdUpdateErased
      Category = 'DSDLib'
      TabSheet = cxTabSheetMain
      StoredProc = spErasedMIMaster
      StoredProcList = <
        item
          StoredProc = spErasedMIMaster
        end>
      Caption = #1059#1076#1072#1083#1080#1090#1100' <'#1052#1072#1088#1096#1088#1091#1090'>'
      Hint = #1059#1076#1072#1083#1080#1090#1100' <'#1052#1072#1088#1096#1088#1091#1090'>'
      ImageIndex = 2
      ShortCut = 46
      ErasedFieldName = 'isErased'
      DataSource = MasterDS
    end
    object SetUnErased: TdsdUpdateErased
      Category = 'DSDLib'
      TabSheet = cxTabSheetMain
      StoredProc = spUnErasedMIMaster
      StoredProcList = <
        item
          StoredProc = spUnErasedMIMaster
        end>
      Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100
      Hint = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      ImageIndex = 8
      ShortCut = 46
      ErasedFieldName = 'isErased'
      isSetErased = False
      DataSource = MasterDS
    end
    object RouteChoiceForm: TOpenChoiceForm
      Category = 'DSDLib'
      Caption = 'RouteChoiceForm'
      FormName = 'TRouteForm'
      GuiParams = <
        item
          Name = 'Key'
          Component = MasterCDS
          ComponentItem = 'RouteId'
        end
        item
          Name = 'Code'
          Component = MasterCDS
          ComponentItem = 'RouteCode'
        end
        item
          Name = 'TextValue'
          Component = MasterCDS
          ComponentItem = 'RouteName'
          DataType = ftString
        end
        item
          Name = 'RouteKindId'
          Component = MasterCDS
          ComponentItem = 'RouteKindId'
        end
        item
          Name = 'RouteKindName'
          Component = MasterCDS
          ComponentItem = 'RouteKindName'
          DataType = ftString
        end
        item
          Name = 'FreightId'
          Component = MasterCDS
          ComponentItem = 'FreightId'
        end
        item
          Name = 'FreightName'
          Component = MasterCDS
          ComponentItem = 'FreightName'
          DataType = ftString
        end>
      isShowModal = True
    end
    object FreightChoiceForm: TOpenChoiceForm
      Category = 'DSDLib'
      Caption = 'FreightChoiceForm'
      FormName = 'TFreightForm'
      GuiParams = <
        item
          Name = 'Key'
          Component = MasterCDS
          ComponentItem = 'FreightId'
        end
        item
          Name = 'TextValue'
          Component = MasterCDS
          ComponentItem = 'FreightName'
        end>
      isShowModal = True
    end
    object InsertRecordIncome: TInsertRecord
      Category = 'DSDLib'
      TabSheet = cxTabSheetIncome
      View = cxGridIncomeDBTableView
      Action = PartnerChoiceForm
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' <'#1055#1088#1080#1093#1086#1076' ('#1047#1072#1087#1088#1072#1074#1082#1072' '#1072#1074#1090#1086')>'
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' <'#1055#1088#1080#1093#1086#1076' ('#1047#1072#1087#1088#1072#1074#1082#1072' '#1072#1074#1090#1086')>'
      ShortCut = 45
      ImageIndex = 0
    end
    object SetErasedIncome: TdsdUpdateErased
      Category = 'DSDLib'
      TabSheet = cxTabSheetIncome
      StoredProc = spErasedMIIncome
      StoredProcList = <
        item
          StoredProc = spErasedMIIncome
        end>
      Caption = #1059#1076#1072#1083#1080#1090#1100' <'#1055#1088#1080#1093#1086#1076' ('#1047#1072#1087#1088#1072#1074#1082#1072' '#1072#1074#1090#1086')>'
      Hint = #1059#1076#1072#1083#1080#1090#1100' <'#1055#1088#1080#1093#1086#1076' ('#1047#1072#1087#1088#1072#1074#1082#1072' '#1072#1074#1090#1086')>'
      ImageIndex = 2
      ShortCut = 46
      ErasedFieldName = 'isErased'
      DataSource = IncomeDS
    end
    object SetUnErasedIncome: TdsdUpdateErased
      Category = 'DSDLib'
      TabSheet = cxTabSheetIncome
      StoredProc = spUnErasedMIIncome
      StoredProcList = <
        item
          StoredProc = spUnErasedMIIncome
        end>
      Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100
      Hint = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      ImageIndex = 8
      ShortCut = 46
      ErasedFieldName = 'isErased'
      isSetErased = False
      DataSource = IncomeDS
    end
    object PartnerChoiceForm: TOpenChoiceForm
      Category = 'DSDLib'
      Caption = 'PartnerChoiceForm'
      FormName = 'TPartnerForm'
      GuiParams = <
        item
          Name = 'Key'
          Component = IncomeCDS
          ComponentItem = 'FromId'
        end
        item
          Name = 'Code'
          Component = IncomeCDS
          ComponentItem = 'FromCode'
        end
        item
          Name = 'TextValue'
          Component = IncomeCDS
          ComponentItem = 'FromName'
          DataType = ftString
        end>
      isShowModal = True
    end
    object PaidKindChoiceForm: TOpenChoiceForm
      Category = 'DSDLib'
      Caption = 'PaidKindChoiceForm'
      FormName = 'TPaidKindForm'
      GuiParams = <
        item
          Name = 'Key'
          Component = IncomeCDS
          ComponentItem = 'PaidKindId'
        end
        item
          Name = 'TextValue'
          Component = IncomeCDS
          ComponentItem = 'PaidKindName'
          DataType = ftString
        end>
      isShowModal = True
    end
    object GoodsChoiceForm: TOpenChoiceForm
      Category = 'DSDLib'
      Caption = 'GoodsChoiceForm'
      FormName = 'TGoodsForm'
      GuiParams = <
        item
          Name = 'Key'
          Component = IncomeCDS
          ComponentItem = 'GoodsId'
        end
        item
          Name = 'Code'
          Component = IncomeCDS
          ComponentItem = 'GoodsCode'
        end
        item
          Name = 'TextValue'
          Component = IncomeCDS
          ComponentItem = 'GoodsName'
          DataType = ftString
        end
        item
          Name = 'FuelName'
          Component = IncomeCDS
          ComponentItem = 'FuelName'
          DataType = ftString
        end>
      isShowModal = True
    end
    object RouteIncomeChoiceForm: TOpenChoiceForm
      Category = 'DSDLib'
      Caption = 'RouteChoiceForm'
      FormName = 'TRouteForm'
      GuiParams = <
        item
          Name = 'Key'
          Component = IncomeCDS
          ComponentItem = 'RouteId'
        end
        item
          Name = 'TextValue'
          Component = IncomeCDS
          ComponentItem = 'RouteName'
          DataType = ftString
        end>
      isShowModal = True
    end
    object actUnCompleteIncome: TdsdChangeMovementStatus
      Category = 'DSDLib'
      TabSheet = cxTabSheetIncome
      StoredProc = spMovementUnCompleteIncome
      StoredProcList = <
        item
          StoredProc = spMovementUnCompleteIncome
        end>
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100' '#1087#1088#1086#1074#1077#1076#1077#1085#1080#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      Hint = #1054#1090#1084#1077#1085#1080#1090#1100' '#1087#1088#1086#1074#1077#1076#1077#1085#1080#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      ImageIndex = 11
      Status = mtUncomplete
      DataSource = IncomeDS
    end
    object actCompleteIncome: TdsdChangeMovementStatus
      Category = 'DSDLib'
      TabSheet = cxTabSheetIncome
      StoredProc = spMovementCompleteIncome
      StoredProcList = <
        item
          StoredProc = spMovementCompleteIncome
        end>
      Caption = #1055#1088#1086#1074#1077#1089#1090#1080' '#1076#1086#1082#1091#1084#1077#1085#1090
      Hint = #1055#1088#1086#1074#1077#1089#1090#1080' '#1076#1086#1082#1091#1084#1077#1085#1090
      ImageIndex = 12
      Status = mtComplete
      DataSource = IncomeDS
    end
    object actSetErasedIncome: TdsdChangeMovementStatus
      Category = 'DSDLib'
      TabSheet = cxTabSheetIncome
      StoredProc = spMovementSetErasedIncome
      StoredProcList = <
        item
          StoredProc = spMovementSetErasedIncome
        end>
      Caption = #1057#1090#1072#1090#1091#1089' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '#1091#1076#1072#1083#1077#1085
      Hint = #1057#1090#1072#1090#1091#1089' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '#1091#1076#1072#1083#1077#1085
      ImageIndex = 13
      Status = mtDelete
      DataSource = IncomeDS
    end
    object UnCompleteMovement: TChangeGuidesStatus
      Category = 'DSDLib'
      StoredProc = StatusStoredProc
      StoredProcList = <
        item
          StoredProc = StatusStoredProc
        end
        item
          StoredProc = spSelectMIContainer
        end>
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100' '#1087#1088#1086#1074#1077#1076#1077#1085#1080#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      Hint = #1054#1090#1084#1077#1085#1080#1090#1100' '#1087#1088#1086#1074#1077#1076#1077#1085#1080#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      ImageIndex = 11
      Status = mtUncomplete
      Guides = StatusGuides
    end
    object CompleteMovement: TChangeGuidesStatus
      Category = 'DSDLib'
      StoredProc = StatusStoredProc
      StoredProcList = <
        item
          StoredProc = StatusStoredProc
        end
        item
          StoredProc = spSelectMIContainer
        end>
      Caption = #1055#1088#1086#1074#1077#1089#1090#1080' '#1076#1086#1082#1091#1084#1077#1085#1090
      Hint = #1055#1088#1086#1074#1077#1089#1090#1080' '#1076#1086#1082#1091#1084#1077#1085#1090
      ImageIndex = 12
      Status = mtComplete
      Guides = StatusGuides
    end
    object DeleteMovement: TChangeGuidesStatus
      Category = 'DSDLib'
      StoredProc = StatusStoredProc
      StoredProcList = <
        item
          StoredProc = StatusStoredProc
        end
        item
          StoredProc = spSelectMIContainer
        end>
      Caption = #1057#1090#1072#1090#1091#1089' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '#1091#1076#1072#1083#1077#1085
      Hint = #1057#1090#1072#1090#1091#1089' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '#1091#1076#1072#1083#1077#1085
      ImageIndex = 13
      Status = mtDelete
      Guides = StatusGuides
    end
  end
  object MasterDS: TDataSource
    DataSet = MasterCDS
    Left = 45
    Top = 226
  end
  object MasterCDS: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 16
    Top = 226
  end
  object GuidesCar: TdsdGuides
    KeyField = 'Id'
    LookupControl = edCar
    FormName = 'TCarForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = GuidesCar
        ComponentItem = 'Key'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = GuidesCar
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 250
    Top = 11
  end
  object spGet: TdsdStoredProc
    StoredProcName = 'gpGet_Movement_Transport'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inId'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
      end
      item
        Name = 'InvNumber'
        Value = ''
        Component = edInvNumber
      end
      item
        Name = 'OperDate'
        Value = 0d
        Component = edOperDate
      end
      item
        Name = 'CarId'
        Value = ''
        Component = GuidesCar
        ComponentItem = 'Key'
      end
      item
        Name = 'CarName'
        Value = ''
        Component = GuidesCar
        ComponentItem = 'TextValue'
      end
      item
        Name = 'CarTrailerId'
        Value = ''
        Component = GuidesCarTrailer
        ComponentItem = 'Key'
      end
      item
        Name = 'CarTrailerName'
        Value = ''
        Component = GuidesCarTrailer
        ComponentItem = 'TextValue'
      end
      item
        Name = 'PersonalDriverId'
        Value = ''
        Component = GuidesPersonalDriver
        ComponentItem = 'Key'
      end
      item
        Name = 'PersonalDriverName'
        Value = ''
        Component = GuidesPersonalDriver
        ComponentItem = 'TextValue'
      end
      item
        Name = 'PersonalDriverMoreId'
        Value = ''
        Component = GuidesPersonalDriverMore
        ComponentItem = 'Key'
      end
      item
        Name = 'PersonalDriverMoreName'
        Value = ''
        Component = GuidesPersonalDriverMore
        ComponentItem = 'TextValue'
      end
      item
        Name = 'UnitForwardingId'
        Value = ''
        Component = GuidesUnitForwarding
        ComponentItem = 'Key'
      end
      item
        Name = 'UnitForwardingName'
        Value = ''
        Component = GuidesUnitForwarding
        ComponentItem = 'TextValue'
      end
      item
        Name = 'StartRunPlan'
        Value = 0d
        Component = edStartRunPlan
        DataType = ftDateTime
      end
      item
        Name = 'EndRunPlan'
        Value = 0d
        Component = edEndRunPlan
        DataType = ftDateTime
      end
      item
        Name = 'StartRun'
        Value = 0d
        Component = edStartRun
        DataType = ftDateTime
      end
      item
        Name = 'EndRun'
        Value = 0d
        Component = edEndRun
        DataType = ftDateTime
      end
      item
        Name = 'HoursWork'
        Value = 0.000000000000000000
        Component = edHoursWork
        DataType = ftFloat
      end
      item
        Name = 'HoursAdd'
        Value = 0.000000000000000000
        Component = edHoursAdd
        DataType = ftFloat
      end
      item
        Name = 'Comment'
        Value = ''
        Component = edComment
        DataType = ftString
      end
      item
        Name = 'StatusCode'
        Value = ''
        Component = StatusGuides
        ComponentItem = 'Key'
        DataType = ftString
      end
      item
        Name = 'StatusName'
        Value = ''
        Component = StatusGuides
        ComponentItem = 'TextValue'
        DataType = ftString
      end>
    Left = 221
    Top = 182
  end
  object PopupMenu: TPopupMenu
    Images = dmMain.ImageList
    Left = 206
    Top = 286
    object N1: TMenuItem
      Action = actRefresh
    end
  end
  object spSelectMIContainer: TdsdStoredProc
    StoredProcName = 'gpSelect_MovementItemContainer_Movement'
    DataSet = EntryCDS
    DataSets = <
      item
        DataSet = EntryCDS
      end>
    Params = <
      item
        Name = 'inMovementId'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
      end>
    Left = 106
    Top = 357
  end
  object EntryCDS: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 17
    Top = 357
  end
  object EntryDS: TDataSource
    DataSet = EntryCDS
    Left = 46
    Top = 357
  end
  object spInsertUpdateMIMaster: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_MI_Transport_Master'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'ioId'
        Component = MasterCDS
        ComponentItem = 'Id'
        ParamType = ptInputOutput
      end
      item
        Name = 'inMovementId'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
      end
      item
        Name = 'inRouteId'
        Component = MasterCDS
        ComponentItem = 'RouteId'
        ParamType = ptInput
      end
      item
        Name = 'inAmount'
        Component = MasterCDS
        ComponentItem = 'Amount'
        DataType = ftFloat
        ParamType = ptInput
      end
      item
        Name = 'inDistanceFuelChild'
        Component = MasterCDS
        ComponentItem = 'DistanceFuelChild'
        DataType = ftFloat
        ParamType = ptInput
      end
      item
        Name = 'inWeight'
        Component = MasterCDS
        ComponentItem = 'Weight'
        DataType = ftFloat
        ParamType = ptInput
      end
      item
        Name = 'inStartOdometre'
        Component = MasterCDS
        ComponentItem = 'StartOdometre'
        DataType = ftFloat
        ParamType = ptInput
      end
      item
        Name = 'inEndOdometre'
        Component = MasterCDS
        ComponentItem = 'EndOdometre'
        DataType = ftFloat
        ParamType = ptInput
      end
      item
        Name = 'inFreightId'
        Component = MasterCDS
        ComponentItem = 'FreightId'
        ParamType = ptInput
      end
      item
        Name = 'inRouteKindId'
        Component = MasterCDS
        ComponentItem = 'RouteKindId'
        ParamType = ptInput
      end>
    Left = 75
    Top = 226
  end
  object frxDBDataset: TfrxDBDataset
    UserName = 'frxDBDataset'
    CloseDataSource = False
    DataSet = MasterCDS
    BCDToCurrency = False
    Left = 134
    Top = 226
  end
  object ChildCDS: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'ParentId'
    MasterFields = 'Id'
    MasterSource = MasterDS
    PacketRecords = 0
    Params = <>
    Left = 16
    Top = 270
  end
  object ChildDS: TDataSource
    DataSet = ChildCDS
    Left = 44
    Top = 270
  end
  object spInsertUpdateMovement: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_Movement_Transport'
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
        Name = 'inInvNumber'
        Value = ''
        Component = edInvNumber
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'inOperDate'
        Value = 0d
        Component = edOperDate
        DataType = ftDateTime
        ParamType = ptInput
      end
      item
        Name = 'inStartRunPlan'
        Value = 0d
        Component = edStartRunPlan
        DataType = ftDateTime
        ParamType = ptInput
      end
      item
        Name = 'inEndRunPlan'
        Value = 0d
        Component = edEndRunPlan
        DataType = ftDateTime
        ParamType = ptInput
      end
      item
        Name = 'inStartRun'
        Value = 0d
        Component = edStartRun
        DataType = ftDateTime
        ParamType = ptInput
      end
      item
        Name = 'inEndRun'
        Value = 0d
        Component = edEndRun
        DataType = ftDateTime
        ParamType = ptInput
      end
      item
        Name = 'inHoursAdd'
        Value = 0.000000000000000000
        Component = edHoursAdd
        DataType = ftFloat
        ParamType = ptInput
      end
      item
        Name = 'outHoursWork'
        Value = 0.000000000000000000
        Component = edHoursWork
        DataType = ftFloat
      end
      item
        Name = 'inComment'
        Value = ''
        Component = edComment
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'inCarId'
        Value = ''
        Component = GuidesCar
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'inCarTrailerId'
        Value = ''
        Component = GuidesCarTrailer
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'inPersonalDriverId'
        Value = ''
        Component = GuidesPersonalDriver
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'inPersonalDriverMoreId'
        Value = ''
        Component = GuidesPersonalDriverMore
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'inUnitForwardingId'
        Value = ''
        Component = GuidesUnitForwarding
        ComponentItem = 'Key'
        ParamType = ptInput
      end>
    Left = 348
    Top = 226
  end
  object GuidesCarTrailer: TdsdGuides
    KeyField = 'Id'
    LookupControl = edCarTrailer
    FormName = 'TCarForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = GuidesCarTrailer
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = GuidesCarTrailer
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 722
    Top = 91
  end
  object GuidesPersonalDriver: TdsdGuides
    KeyField = 'Id'
    LookupControl = edPersonalDriver
    FormName = 'TPersonalForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = GuidesPersonalDriver
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = GuidesPersonalDriver
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 418
    Top = 91
  end
  object GuidesPersonalDriverMore: TdsdGuides
    KeyField = 'Id'
    LookupControl = edPersonalDriverMore
    FormName = 'TPersonalForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = GuidesPersonalDriverMore
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = GuidesPersonalDriverMore
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 778
    Top = 91
  end
  object GuidesUnitForwarding: TdsdGuides
    KeyField = 'Id'
    LookupControl = edUnitForwarding
    FormName = 'TUnitForm'
    PositionDataSet = 'ClientDataSet'
    Params = <
      item
        Name = 'Key'
        Value = ''
        Component = GuidesUnitForwarding
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'TextValue'
        Value = ''
        Component = GuidesUnitForwarding
        ComponentItem = 'TextValue'
        DataType = ftString
        ParamType = ptInput
      end>
    Left = 898
    Top = 83
  end
  object spInsertUpdateMIChild: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_MI_Transport_Child'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'ioId'
        Component = ChildCDS
        ComponentItem = 'Id'
        ParamType = ptInputOutput
      end
      item
        Name = 'inMovementId'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
      end
      item
        Name = 'inParentId'
        Component = ChildCDS
        ComponentItem = 'ParentId'
        ParamType = ptInput
      end
      item
        Name = 'inFuelId'
        Component = ChildCDS
        ComponentItem = 'FuelId'
        ParamType = ptInput
      end
      item
        Name = 'inIsCalculated'
        Component = ChildCDS
        ComponentItem = 'isCalculated'
        DataType = ftBoolean
        ParamType = ptInput
      end
      item
        Name = 'inIsMasterFuel'
        Component = ChildCDS
        ComponentItem = 'isMasterFuel'
        DataType = ftBoolean
        ParamType = ptInput
      end
      item
        Name = 'ioAmount'
        Component = ChildCDS
        ComponentItem = 'Amount'
        DataType = ftFloat
        ParamType = ptInputOutput
      end
      item
        Name = 'outAmount_calc'
        Component = ChildCDS
        ComponentItem = 'Amount_calc'
        DataType = ftFloat
      end
      item
        Name = 'inColdHour'
        Component = ChildCDS
        ComponentItem = 'ColdHour'
        DataType = ftFloat
        ParamType = ptInput
      end
      item
        Name = 'inColdDistance'
        Component = ChildCDS
        ComponentItem = 'ColdDistance'
        DataType = ftFloat
        ParamType = ptInput
      end
      item
        Name = 'inAmountColdHour'
        Component = ChildCDS
        ComponentItem = 'AmountColdHour'
        DataType = ftFloat
        ParamType = ptInput
      end
      item
        Name = 'inAmountColdDistance'
        Component = ChildCDS
        ComponentItem = 'AmountColdDistance'
        DataType = ftFloat
        ParamType = ptInput
      end
      item
        Name = 'inAmountFuel'
        Component = ChildCDS
        ComponentItem = 'AmountFuel'
        DataType = ftFloat
        ParamType = ptInput
      end
      item
        Name = 'inNumber'
        Component = ChildCDS
        ComponentItem = 'Number'
        DataType = ftFloat
        ParamType = ptInput
      end
      item
        Name = 'inRateFuelKindTax'
        Component = ChildCDS
        ComponentItem = 'RateFuelKindTax'
        DataType = ftFloat
        ParamType = ptInput
      end
      item
        Name = 'inRateFuelKindId'
        Component = ChildCDS
        ComponentItem = 'RateFuelKindId'
        ParamType = ptInput
      end>
    Left = 74
    Top = 269
  end
  object GuidesFiller: TGuidesFiller
    IdParam.Value = Null
    IdParam.Component = FormParams
    IdParam.ComponentItem = 'Id'
    GuidesList = <
      item
        Guides = GuidesCar
      end
      item
        Guides = GuidesPersonalDriver
      end
      item
        Guides = GuidesUnitForwarding
      end>
    ActionItemList = <
      item
        Action = actInsertUpdateMovement
      end>
    Left = 256
    Top = 196
  end
  object HeaderSaver: THeaderSaver
    IdParam.Value = Null
    IdParam.Component = FormParams
    IdParam.ComponentItem = 'Id'
    StoredProc = spInsertUpdateMovement
    ControlList = <
      item
        Control = edOperDate
      end
      item
        Control = edCar
      end
      item
        Control = edPersonalDriver
      end
      item
        Control = edStartRun
      end
      item
        Control = edStartRunPlan
      end
      item
        Control = edEndRun
      end
      item
        Control = edEndRunPlan
      end
      item
        Control = edHoursAdd
      end
      item
        Control = edCarTrailer
      end
      item
        Control = edPersonalDriverMore
      end
      item
        Control = edUnitForwarding
      end
      item
        Control = edComment
      end>
    GetStoredProc = spGet
    Left = 299
    Top = 211
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
    Left = 25
    Top = 182
    DockControlHeights = (
      0
      0
      26
      0)
    object dxBarManagerBar: TdxBar
      AllowClose = False
      Caption = 'Custom'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 671
      FloatTop = 8
      FloatClientWidth = 51
      FloatClientHeight = 71
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bbInsertUpdateMovement'
        end
        item
          Visible = True
          ItemName = 'bbShowErased'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbStatic'
        end
        item
          Visible = True
          ItemName = 'bbAddRoute'
        end
        item
          Visible = True
          ItemName = 'bbErased'
        end
        item
          Visible = True
          ItemName = 'bbUnErased'
        end
        item
          Visible = True
          ItemName = 'bbStatic'
        end
        item
          Visible = True
          ItemName = 'bbAddIncome'
        end
        item
          Visible = True
          ItemName = 'bbErasedIncome'
        end
        item
          Visible = True
          ItemName = 'bbUnErasedIncome'
        end
        item
          Visible = True
          ItemName = 'bbStatic'
        end
        item
          Visible = True
          ItemName = 'bbCompleteIncome'
        end
        item
          Visible = True
          ItemName = 'bbUnCompleteIncome'
        end
        item
          Visible = True
          ItemName = 'bbSetErasedIncome'
        end
        item
          Visible = True
          ItemName = 'bbStatic'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bbRefresh'
        end
        item
          Visible = True
          ItemName = 'bbPrint'
        end
        item
          Visible = True
          ItemName = 'bbGridToExel'
        end
        item
          Visible = True
          ItemName = 'bbEntryToGrid'
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
    object bbPrint: TdxBarButton
      Action = actPrint
      Category = 0
    end
    object bbBooleanAction: TdxBarButton
      Action = BooleanStoredProcAction
      Category = 0
    end
    object bbStatic: TdxBarStatic
      Caption = '     '
      Category = 0
      Visible = ivAlways
    end
    object bbGridToExel: TdxBarButton
      Action = GridToExcel
      Category = 0
    end
    object bbEntryToGrid: TdxBarButton
      Category = 0
      Visible = ivAlways
    end
    object bbInsertUpdateMovement: TdxBarButton
      Action = actInsertUpdateMovement
      Category = 0
    end
    object bbAddRoute: TdxBarButton
      Action = InsertRecord
      Category = 0
    end
    object bbErased: TdxBarButton
      Action = SetErased
      Category = 0
    end
    object bbUnErased: TdxBarButton
      Action = SetUnErased
      Category = 0
    end
    object bbShowErased: TdxBarButton
      Action = ShowErasedAction
      Category = 0
    end
    object bbAddIncome: TdxBarButton
      Action = InsertRecordIncome
      Category = 0
    end
    object bbErasedIncome: TdxBarButton
      Action = SetErasedIncome
      Category = 0
    end
    object bbUnErasedIncome: TdxBarButton
      Action = SetUnErasedIncome
      Category = 0
    end
    object bbCompleteIncome: TdxBarButton
      Action = actCompleteIncome
      Category = 0
    end
    object bbUnCompleteIncome: TdxBarButton
      Action = actUnCompleteIncome
      Category = 0
    end
    object bbSetErasedIncome: TdxBarButton
      Action = actSetErasedIncome
      Category = 0
    end
  end
  object RefreshAddOn: TRefreshAddOn
    FormName = 'TransportJournalForm'
    DataSet = 'ClientDataSet'
    RefreshAction = 'actRefresh'
    FormParams = 'FormParams'
    Left = 442
    Top = 267
  end
  object UserSettingsStorageAddOn: TdsdUserSettingsStorageAddOn
    Left = 111
    Top = 182
  end
  object MasterViewAddOn: TdsdDBViewAddOn
    ErasedFieldName = 'isErased'
    View = cxGridDBTableView
    OnDblClickActionList = <
      item
        Action = RouteChoiceForm
      end>
    ActionItemList = <>
    SortImages = dmMain.SortImageList
    Left = 261
    Top = 320
  end
  object ChildViewAddOn: TdsdDBViewAddOn
    ErasedFieldName = 'isErased'
    View = cxGridChildDBTableView
    OnDblClickActionList = <>
    ActionItemList = <>
    SortImages = dmMain.SortImageList
    Left = 320
    Top = 304
  end
  object IncomeCDS: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 16
    Top = 314
  end
  object IncomeDS: TDataSource
    DataSet = IncomeCDS
    Left = 45
    Top = 314
  end
  object spSelectMIIncome: TdsdStoredProc
    StoredProcName = 'gpSelect_Movement_TransportIncome'
    DataSet = IncomeCDS
    DataSets = <
      item
        DataSet = IncomeCDS
      end>
    Params = <
      item
        Name = 'inMovementId'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
      end
      item
        Name = 'inShowAll'
        Value = False
        Component = BooleanStoredProcAction
        DataType = ftBoolean
        ParamType = ptInput
      end
      item
        Name = 'inIsErased'
        Value = False
        Component = ShowErasedAction
        DataType = ftBoolean
        ParamType = ptInput
      end>
    Left = 106
    Top = 314
  end
  object spInsertUpdateMIIncome: TdsdStoredProc
    StoredProcName = 'gpInsertUpdate_Movement_TransportIncome'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inParentId'
        Value = Null
        Component = FormParams
        ComponentItem = 'Id'
        ParamType = ptInput
      end
      item
        Name = 'ioMovementId'
        Component = IncomeCDS
        ComponentItem = 'MovementId'
        ParamType = ptInputOutput
      end
      item
        Name = 'ioInvNumber'
        Component = IncomeCDS
        ComponentItem = 'InvNumber'
        DataType = ftString
        ParamType = ptInputOutput
      end
      item
        Name = 'inInvNumberPartner'
        Component = IncomeCDS
        ComponentItem = 'InvNumberPartner'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'ioOperDate'
        Component = IncomeCDS
        ComponentItem = 'OperDate'
        DataType = ftDateTime
        ParamType = ptInputOutput
      end
      item
        Name = 'ioPriceWithVAT'
        Component = IncomeCDS
        ComponentItem = 'PriceWithVAT'
        DataType = ftBoolean
        ParamType = ptInputOutput
      end
      item
        Name = 'ioVATPercent'
        Component = IncomeCDS
        ComponentItem = 'VATPercent'
        DataType = ftFloat
        ParamType = ptInputOutput
      end
      item
        Name = 'inFromId'
        Component = IncomeCDS
        ComponentItem = 'FromId'
        ParamType = ptInput
      end
      item
        Name = 'inToId'
        Value = ''
        Component = GuidesCar
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'ioPaidKindId'
        Component = IncomeCDS
        ComponentItem = 'PaidKindId'
        ParamType = ptInputOutput
      end
      item
        Name = 'ioPaidKindName'
        Component = IncomeCDS
        ComponentItem = 'PaidKindName'
        DataType = ftString
        ParamType = ptInputOutput
      end
      item
        Name = 'ioContractId'
        Component = IncomeCDS
        ComponentItem = 'ContractId'
        ParamType = ptInputOutput
      end
      item
        Name = 'ioContractName'
        Component = IncomeCDS
        ComponentItem = 'ContractName'
        DataType = ftString
        ParamType = ptInputOutput
      end
      item
        Name = 'ioRouteId'
        Component = IncomeCDS
        ComponentItem = 'RouteId'
        ParamType = ptInputOutput
      end
      item
        Name = 'ioRouteName'
        Component = IncomeCDS
        ComponentItem = 'RouteName'
        DataType = ftString
        ParamType = ptInputOutput
      end
      item
        Name = 'inPersonalDriverId'
        Value = ''
        Component = GuidesPersonalDriver
        ComponentItem = 'Key'
        ParamType = ptInput
      end
      item
        Name = 'ioMovementItemId'
        Component = IncomeCDS
        ComponentItem = 'MovementItemId'
        ParamType = ptInputOutput
      end
      item
        Name = 'ioGoodsId'
        Component = IncomeCDS
        ComponentItem = 'GoodsId'
        ParamType = ptInputOutput
      end
      item
        Name = 'ioGoodsCode'
        Component = IncomeCDS
        ComponentItem = 'GoodsCode'
        ParamType = ptInputOutput
      end
      item
        Name = 'ioGoodsName'
        Component = IncomeCDS
        ComponentItem = 'GoodsName'
        DataType = ftString
        ParamType = ptInputOutput
      end
      item
        Name = 'ioFuelName'
        Component = IncomeCDS
        ComponentItem = 'FuelName'
        DataType = ftString
        ParamType = ptInputOutput
      end
      item
        Name = 'inAmount'
        Component = IncomeCDS
        ComponentItem = 'Amount'
        DataType = ftFloat
        ParamType = ptInput
      end
      item
        Name = 'inPrice'
        Component = IncomeCDS
        ComponentItem = 'Price'
        DataType = ftFloat
        ParamType = ptInput
      end
      item
        Name = 'ioCountForPrice'
        Component = IncomeCDS
        ComponentItem = 'CountForPrice'
        DataType = ftFloat
        ParamType = ptInputOutput
      end
      item
        Name = 'outAmountSumm'
        Component = IncomeCDS
        ComponentItem = 'AmountSumm'
        DataType = ftFloat
      end
      item
        Name = 'outAmountSummTotal'
        Component = IncomeCDS
        ComponentItem = 'AmountSummTotal'
        DataType = ftFloat
      end>
    Left = 75
    Top = 314
  end
  object spErasedMIMaster: TdsdStoredProc
    StoredProcName = 'gpSetErased_MovementItem'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inMovementItemId'
        Component = MasterCDS
        ComponentItem = 'Id'
        ParamType = ptInput
      end
      item
        Name = 'outIsErased'
        Component = MasterCDS
        ComponentItem = 'isErased'
        DataType = ftBoolean
      end>
    Left = 614
    Top = 185
  end
  object spUnErasedMIMaster: TdsdStoredProc
    StoredProcName = 'gpSetUnErased_MovementItem'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inMovementItemId'
        Component = MasterCDS
        ComponentItem = 'Id'
        ParamType = ptInput
      end
      item
        Name = 'outIsErased'
        Component = MasterCDS
        ComponentItem = 'isErased'
        DataType = ftBoolean
      end>
    Left = 678
    Top = 201
  end
  object spErasedMIIncome: TdsdStoredProc
    StoredProcName = 'gpSetErased_MovementItem'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inMovementItemId'
        Component = IncomeCDS
        ComponentItem = 'MovementItemId'
        ParamType = ptInput
      end
      item
        Name = 'outIsErased'
        Component = IncomeCDS
        ComponentItem = 'isErased'
        DataType = ftBoolean
      end>
    Left = 612
    Top = 244
  end
  object spUnErasedMIIncome: TdsdStoredProc
    StoredProcName = 'gpSetUnErased_MovementItem'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inMovementItemId'
        Component = IncomeCDS
        ComponentItem = 'MovementItemId'
        ParamType = ptInput
      end
      item
        Name = 'outIsErased'
        Component = IncomeCDS
        ComponentItem = 'isErased'
        DataType = ftBoolean
      end>
    Left = 684
    Top = 260
  end
  object IncomeViewAddOn: TdsdDBViewAddOn
    ErasedFieldName = 'isErased'
    View = cxGridIncomeDBTableView
    OnDblClickActionList = <
      item
        Action = PartnerChoiceForm
      end>
    ActionItemList = <>
    SortImages = dmMain.SortImageList
    Left = 263
    Top = 364
  end
  object EntryViewAddOn: TdsdDBViewAddOn
    ErasedFieldName = 'isErased'
    View = cxGridEntryDBTableView
    OnDblClickActionList = <>
    ActionItemList = <>
    SortImages = dmMain.SortImageList
    Left = 379
    Top = 282
  end
  object spMovementCompleteIncome: TdsdStoredProc
    StoredProcName = 'gpComplete_Movement_Income'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inMovementId'
        Component = IncomeCDS
        ComponentItem = 'MovementId'
        ParamType = ptInput
      end
      item
        Name = 'inIsLastComplete'
        Value = True
        DataType = ftBoolean
        ParamType = ptInput
      end>
    Left = 552
    Top = 384
  end
  object spMovementUnCompleteIncome: TdsdStoredProc
    StoredProcName = 'gpUnComplete_Movement'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inMovementId'
        Component = IncomeCDS
        ComponentItem = 'MovementId'
        ParamType = ptInput
      end>
    Left = 624
    Top = 400
  end
  object spMovementSetErasedIncome: TdsdStoredProc
    StoredProcName = 'gpSetErased_Movement'
    DataSets = <>
    OutputType = otResult
    Params = <
      item
        Name = 'inMovementId'
        Component = IncomeCDS
        ComponentItem = 'MovementId'
        ParamType = ptInput
      end>
    Left = 696
    Top = 384
  end
  object StatusGuides: TdsdGuides
    KeyField = 'Id'
    LookupControl = ceStatus
    PositionDataSet = 'ClientDataSet'
    Params = <>
    Left = 40
    Top = 16
  end
  object StatusStoredProc: TdsdStoredProc
    StoredProcName = 'gpUpdate_Status_Transport'
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
        Name = 'StatusCode'
        Value = ''
        Component = StatusGuides
        ComponentItem = 'Key'
        ParamType = ptInput
      end>
    Left = 64
    Top = 16
  end
end