unit BankAccountEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxPropertiesStore,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, Vcl.Menus, Vcl.StdCtrls, cxButtons, cxLabel, cxTextEdit, Vcl.ActnList,
  Vcl.StdActns, cxCurrencyEdit, cxCheckBox,
  Data.DB, Datasnap.DBClient, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, ParentForm, dsdGuides,
  dsdDB, dsdAction, dsdAddOn, cxButtonEdit;

type
  TBankAccountEditForm = class(TParentForm)
    edName: TcxTextEdit;
    cxLabel1: TcxLabel;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    ActionList: TActionList;
    spInsertUpdate: TdsdStoredProc;
    dsdFormParams: TdsdFormParams;
    spGet: TdsdStoredProc;
    dsdDataSetRefresh: TdsdDataSetRefresh;
    dsdExecStoredProc: TdsdInsertUpdateGuides;
    dsdFormClose: TdsdFormClose;
    ���: TcxLabel;
    ceCode: TcxCurrencyEdit;
    cxLabel3: TcxLabel;
    dsdJuridicalGuides: TdsdGuides;
    cxLabel2: TcxLabel;
    cxLabel4: TcxLabel;
    dsdBankGuides: TdsdGuides;
    dsdCurrencyGuides: TdsdGuides;
    dsdUserSettingsStorageAddOn: TdsdUserSettingsStorageAddOn;
    edJuridical: TcxButtonEdit;
    edBank: TcxButtonEdit;
    edCurrency: TcxButtonEdit;
    cxPropertiesStore: TcxPropertiesStore;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

initialization
  RegisterClass(TBankAccountEditForm);

end.
