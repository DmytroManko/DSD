unit ReturnOut;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ParentForm, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, Data.DB, cxDBData, dsdDB, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, Datasnap.DBClient, Vcl.ActnList, DataModul, dsdAction,
  cxPropertiesStore, dxBar, Vcl.ExtCtrls, cxContainer, cxLabel, cxTextEdit,
  Vcl.ComCtrls, dxCore, cxDateUtils, cxButtonEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, dsdGuides, Vcl.Menus, cxPCdxBarPopupMenu, cxPC, frxClass, frxDBSet,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010,
  dxSkinWhiteprint, dxSkinXmas2008Blue, dxSkinscxPCPainter, dxSkinsdxBarPainter,
  cxCurrencyEdit, cxCheckBox, dxBarExtItems;

type
  TReturnOutForm = class(TParentForm)
    dsdFormParams: TdsdFormParams;
    spSelectMovementItem: TdsdStoredProc;
    cxPropertiesStore: TcxPropertiesStore;
    DataSource: TDataSource;
    MasterCDS: TClientDataSet;
    DataPanel: TPanel;
    edInvNumber: TcxTextEdit;
    cxLabel1: TcxLabel;
    edOperDate: TcxDateEdit;
    cxLabel2: TcxLabel;
    edFrom: TcxButtonEdit;
    edTo: TcxButtonEdit;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    dsdGuidesFrom: TdsdGuides;
    dsdGuidesTo: TdsdGuides;
    PopupMenu: TPopupMenu;
    N1: TMenuItem;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    cxTabSheet2: TcxTabSheet;
    cxGrid: TcxGrid;
    cxGridDBTableView: TcxGridDBTableView;
    colCode: TcxGridDBColumn;
    colName: TcxGridDBColumn;
    colAmount: TcxGridDBColumn;
    colPrice: TcxGridDBColumn;
    colAmountSumm: TcxGridDBColumn;
    cxGridLevel: TcxGridLevel;
    spSelectMovementContainerItem: TdsdStoredProc;
    EntryCDS: TClientDataSet;
    EntryDS: TDataSource;
    spInsertUpdateMovementItem: TdsdStoredProc;
    frxDBDataset: TfrxDBDataset;
    colAmountPartner: TcxGridDBColumn;
    colCountForPrice: TcxGridDBColumn;
    colHeadCount: TcxGridDBColumn;
    colPartionGoods: TcxGridDBColumn;
    colGoodsKindName: TcxGridDBColumn;
    colAssetName: TcxGridDBColumn;
    cxLabel5: TcxLabel;
    edInvNumberPartner: TcxTextEdit;
    edPaidKind: TcxButtonEdit;
    cxLabel6: TcxLabel;
    edPriceWithVAT: TcxCheckBox;
    edContract: TcxButtonEdit;
    cxLabel9: TcxLabel;
    ContractGuides: TdsdGuides;
    PaidKindGuides: TdsdGuides;
    edVATPercent: TcxCurrencyEdit;
    cxLabel7: TcxLabel;
    cxCurrencyEdit2: TcxCurrencyEdit;
    cxLabel8: TcxLabel;
    InsertUpdateMovement: TdsdStoredProc;
    spGet: TdsdStoredProc;
    dxBarManager: TdxBarManager;
    dxBarManagerBar: TdxBar;
    bbRefresh: TdxBarButton;
    bbPrint: TdxBarButton;
    bbBooleanAction: TdxBarButton;
    bbStatic: TdxBarStatic;
    bbGridToExel: TdxBarButton;
    bbEntryToGrid: TdxBarButton;
    bbInsertUpdateMovement: TdxBarButton;
    ActionList: TActionList;
    actRefresh: TdsdDataSetRefresh;
    actUpdateDataSet: TdsdUpdateDataSet;
    actPrint: TdsdPrintAction;
    BooleanStoredProcAction: TBooleanStoredProcAction;
    dsdGridToExcel: TdsdGridToExcel;
    dsdEntryToExcel: TdsdGridToExcel;
    actInsertUpdateMovement: TdsdExecStoredProc;
    cxGridEntry: TcxGrid;
    cxGridEntryDBTableView: TcxGridDBTableView;
    colAccountCode: TcxGridDBColumn;
    colDebetAccountGroupName: TcxGridDBColumn;
    colDebetAccountDirectionName: TcxGridDBColumn;
    colDebetAccountName: TcxGridDBColumn;
    colKreditAccountGroupName: TcxGridDBColumn;
    colKreditAccountDirectionName: TcxGridDBColumn;
    colKreditAccountName: TcxGridDBColumn;
    colByObjectCode: TcxGridDBColumn;
    colByObjectName: TcxGridDBColumn;
    colGoodsGroupName: TcxGridDBColumn;
    colGoodsCode: TcxGridDBColumn;
    colGoodsName: TcxGridDBColumn;
    colGoodsKindName_comlete: TcxGridDBColumn;
    colAccountOnComplete: TcxGridDBColumn;
    colDebetAmount: TcxGridDBColumn;
    colKreditAmount: TcxGridDBColumn;
    colPrice_comlete: TcxGridDBColumn;
    colInfoMoneyName: TcxGridDBColumn;
    colInfoMoneyName_Detail: TcxGridDBColumn;
    colObjectCostId: TcxGridDBColumn;
    cxGridEntryLevel: TcxGridLevel;
  private
  public
  end;

implementation

{$R *.dfm}

initialization
  RegisterClass(TReturnOutForm);

end.
