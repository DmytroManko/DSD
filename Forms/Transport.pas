unit Transport;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ParentForm, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, Data.DB, cxDBData, dsdDB, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, Datasnap.DBClient, Vcl.ActnList, dsdAction,
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
  cxSplitter, cxCurrencyEdit;

type
  TTransportForm = class(TParentForm)
    FormParams: TdsdFormParams;
    spSelectMovementItem: TdsdStoredProc;
    dxBarManager: TdxBarManager;
    dxBarManagerBar: TdxBar;
    bbRefresh: TdxBarButton;
    cxPropertiesStore: TcxPropertiesStore;
    ActionList: TActionList;
    actRefresh: TdsdDataSetRefresh;
    MasterDS: TDataSource;
    MasterCDS: TClientDataSet;
    DataPanel: TPanel;
    edInvNumber: TcxTextEdit;
    cxLabel1: TcxLabel;
    edOperDate: TcxDateEdit;
    cxLabel2: TcxLabel;
    edUnitForwarding: TcxButtonEdit;
    edCar: TcxButtonEdit;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    GuidesCar: TdsdGuides;
    GuidesPersonalDriver: TdsdGuides;
    spGet: TdsdStoredProc;
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
    colPartionClose: TcxGridDBColumn;
    cxGridLevel: TcxGridLevel;
    spSelectMIContainer: TdsdStoredProc;
    cxGridEntryDBTableView: TcxGridDBTableView;
    cxGridEntryLevel: TcxGridLevel;
    cxGridEntry: TcxGrid;
    colDebetAccountName: TcxGridDBColumn;
    colDebetAmount: TcxGridDBColumn;
    EntryCDS: TClientDataSet;
    EntryDS: TDataSource;
    colKreditAccountName: TcxGridDBColumn;
    colKreditAmount: TcxGridDBColumn;
    actUpdateDataSet: TdsdUpdateDataSet;
    spInsertUpdateMI: TdsdStoredProc;
    actPrint: TdsdPrintAction;
    bbPrint: TdxBarButton;
    frxDBDataset: TfrxDBDataset;
    colDebetAccountGroupCode: TcxGridDBColumn;
    colDebetAccountGroupName: TcxGridDBColumn;
    colDebetAccountDirectionCode: TcxGridDBColumn;
    colDebetAccountDirectionName: TcxGridDBColumn;
    colDebetAccountCode: TcxGridDBColumn;
    colKreditAccountGroupCode: TcxGridDBColumn;
    colKreditAccountGroupName: TcxGridDBColumn;
    colKreditAccountDirectionCode: TcxGridDBColumn;
    colKreditAccountDirectionName: TcxGridDBColumn;
    colKreditAccountCode: TcxGridDBColumn;
    colGoodsGroupName: TcxGridDBColumn;
    colByObjectCode: TcxGridDBColumn;
    colByObjectName: TcxGridDBColumn;
    colGoodsName: TcxGridDBColumn;
    col�uterCount: TcxGridDBColumn;
    colComment: TcxGridDBColumn;
    colCount: TcxGridDBColumn;
    colPartionGoods: TcxGridDBColumn;
    colGoodsKindName: TcxGridDBColumn;
    colGoodsKindName_comlete: TcxGridDBColumn;
    colAccountOnComplete: TcxGridDBColumn;
    colReceiptName: TcxGridDBColumn;
    colRealWeight: TcxGridDBColumn;
    colGoodsCode: TcxGridDBColumn;
    colInfoMoneyCode: TcxGridDBColumn;
    colInfoMoneyName: TcxGridDBColumn;
    colInfoMoneyCode_Detail: TcxGridDBColumn;
    colInfoMoneyName_Detail: TcxGridDBColumn;
    colGoodsCode_Parent: TcxGridDBColumn;
    colGoodsName_Parent: TcxGridDBColumn;
    colGoodsKindName_Parent: TcxGridDBColumn;
    cxGridChild: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    colChildGoodsCode: TcxGridDBColumn;
    colChildGoodsName: TcxGridDBColumn;
    colChildAmount: TcxGridDBColumn;
    colChildAmountReceipt: TcxGridDBColumn;
    colChildPartionGoods: TcxGridDBColumn;
    colChildGoodsKindName: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    ChildCDS: TClientDataSet;
    ChildDS: TDataSource;
    cxSplitterChild: TcxSplitter;
    colChildComment: TcxGridDBColumn;
    colId: TcxGridDBColumn;
    colMIId_Parent: TcxGridDBColumn;
    colObjectCostId: TcxGridDBColumn;
    colPrice_comlete: TcxGridDBColumn;
    dsdGridToExcel: TdsdGridToExcel;
    bbGridToExcel: TdxBarButton;
    edPersonalDriver: TcxButtonEdit;
    cxLabel5: TcxLabel;
    edPersonalDriverMore: TcxButtonEdit;
    cxLabel6: TcxLabel;
    edCarTrailer: TcxButtonEdit;
    cxLabel7: TcxLabel;
    edStartRunPlan: TcxDateEdit;
    cxLabel8: TcxLabel;
    edEndRunPlan: TcxDateEdit;
    cxLabel9: TcxLabel;
    cxLabel10: TcxLabel;
    edStartRun: TcxDateEdit;
    cxLabel11: TcxLabel;
    edEndRun: TcxDateEdit;
    edComment: TcxTextEdit;
    cxLabel12: TcxLabel;
    GuidesPersonalDriverMore: TdsdGuides;
    GuidesCarTrailer: TdsdGuides;
    GuidesUnitForwarding: TdsdGuides;
    edHoursWork: TcxCurrencyEdit;
    cxLabel13: TcxLabel;
    edHoursAdd: TcxCurrencyEdit;
    cxLabel14: TcxLabel;
    spInsertUpdateMovement: TdsdStoredProc;
  private
  public
  end;

implementation

{$R *.dfm}

initialization
  RegisterClass(TTransportForm);

end.
