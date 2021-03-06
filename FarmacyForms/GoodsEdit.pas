unit GoodsEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxPropertiesStore,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, Vcl.Menus, Vcl.StdCtrls, cxButtons, cxLabel, cxTextEdit, Vcl.ActnList,
  Vcl.StdActns, cxCurrencyEdit, cxCheckBox,
  Data.DB, Datasnap.DBClient, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, ParentForm, dsdGuides,
  dsdDB, dsdAction;

type
  TGoodsEditForm = class(TParentForm)
    edName: TcxTextEdit;
    cxLabel1: TcxLabel;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    ActionList: TActionList;
    spInsertUpdate: TdsdStoredProc;
    dsdFormParams: TdsdFormParams;
    spGet: TdsdStoredProc;
    dsdDataSetRefresh: TdsdDataSetRefresh;
    dsdExecStoredProc: TdsdExecStoredProc;
    dsdFormClose1: TdsdFormClose;
    ���: TcxLabel;
    ceCode: TcxCurrencyEdit;
    cxLabel3: TcxLabel;
    ceExtraChargeCategories: TcxLookupComboBox;
    ExtraChargeCategoriesDataSet: TClientDataSet;
    spGetExtraChargeCategories: TdsdStoredProc;
    ExtraChargeCategoriesDS: TDataSource;
    dsdExtraChargeCategoriesGuides: TdsdGuides;
    cxLabel4: TcxLabel;
    ceMeasure: TcxLookupComboBox;
    MeasureDataSet: TClientDataSet;
    spGetMeasure: TdsdStoredProc;
    MeasureDS: TDataSource;
    dsdMeasureGuides: TdsdGuides;
    cxLabel2: TcxLabel;
    cePrice: TcxCurrencyEdit;
    cxLabel5: TcxLabel;
    edCashName: TcxTextEdit;
    cxLabel6: TcxLabel;
    ceNDS: TcxCurrencyEdit;
    cxLabel7: TcxLabel;
    cePercentReprice: TcxCurrencyEdit;
    cxLabel8: TcxLabel;
    cePartyCount: TcxCurrencyEdit;
    cbisReceiptNeed: TcxCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

initialization
  RegisterClass(TGoodsEditForm);

end.
