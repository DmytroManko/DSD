unit Report_MotionGoods;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, Data.DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, Datasnap.DBClient, dsdDB, cxPropertiesStore, dxBar,
  Vcl.ActnList, dsdAction, ParentForm, DataModul, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, dxSkinscxPCPainter, dxSkinsdxBarPainter, dsdAddOn,
  cxContainer, Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, Vcl.ExtCtrls, cxCurrencyEdit, dsdGuides,
  cxButtonEdit;

type
  TReport_MotionGoodsForm = class(TParentForm)
    cxGridDBTableView: TcxGridDBTableView;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    DataSource: TDataSource;
    ClientDataSet: TClientDataSet;
    cxPropertiesStore: TcxPropertiesStore;
    dxBarManager: TdxBarManager;
    dxBarManagerBar1: TdxBar;
    ActionList: TActionList;
    bbRefresh: TdxBarButton;
    actRefresh: TdsdDataSetRefresh;
    dsdStoredProc: TdsdStoredProc;
    StartCount: TcxGridDBColumn;
    actExportToExcel: TdsdGridToExcel;
    bbToExcel: TdxBarButton;
    IncomeCount: TcxGridDBColumn;
    dsdDBViewAddOn: TdsdDBViewAddOn;
    dsdUserSettingsStorageAddOn: TdsdUserSettingsStorageAddOn;
    Panel1: TPanel;
    deStart: TcxDateEdit;
    deEnd: TcxDateEdit;
    UnitName: TcxGridDBColumn;
    GoodsCode: TcxGridDBColumn;
    GoodsName: TcxGridDBColumn;
    GoodsKindName: TcxGridDBColumn;
    PartionGoodsName: TcxGridDBColumn;
    AssetName: TcxGridDBColumn;
    StartSumm: TcxGridDBColumn;
    IncomeSumm: TcxGridDBColumn;
    EndCount_calc: TcxGridDBColumn;
    EndSumm_calc: TcxGridDBColumn;
    SendInCount: TcxGridDBColumn;
    SendInSumm: TcxGridDBColumn;
    SendOutCount: TcxGridDBColumn;
    SendOutSumm: TcxGridDBColumn;
    SaleCount: TcxGridDBColumn;
    SaleSumm: TcxGridDBColumn;
    ReturnOutCount: TcxGridDBColumn;
    ReturnOutSumm: TcxGridDBColumn;
    ReturnInCount: TcxGridDBColumn;
    ReturnInSumm: TcxGridDBColumn;
    LossCount: TcxGridDBColumn;
    LossSumm: TcxGridDBColumn;
    InventoryCount: TcxGridDBColumn;
    InventorySumm: TcxGridDBColumn;
    StartWeight: TcxGridDBColumn;
    IncomeWeight: TcxGridDBColumn;
    SendInWeight: TcxGridDBColumn;
    SendOutWeight: TcxGridDBColumn;
    SaleWeight: TcxGridDBColumn;
    ReturnOutWeight: TcxGridDBColumn;
    ReturnInWeight: TcxGridDBColumn;
    LossWeight: TcxGridDBColumn;
    InventoryWeight: TcxGridDBColumn;
    EndWeight_calc: TcxGridDBColumn;
  private
  public
  end;

implementation

{$R *.dfm}

initialization
  RegisterClass(TReport_MotionGoodsForm);

end.
