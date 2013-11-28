unit JuridicalEdit;

interface

uses
  DataModul, AncestorDialog, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus,
  cxControls, cxContainer, cxEdit, dsdGuides, dsdDB, cxMaskEdit, cxButtonEdit,
  cxCheckBox, cxCurrencyEdit, cxLabel, Vcl.Controls, cxTextEdit, System.Classes,
  Vcl.ActnList, dsdAction, cxPropertiesStore, dsdAddOn, Vcl.StdCtrls, cxButtons,
  cxPCdxBarPopupMenu, cxPC, Vcl.ExtCtrls, dxBar, cxClasses, cxDBEdit, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, Data.DB, cxDBData, cxGridLevel,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, Datasnap.DBClient, dxBarExtItems;

type
  TJuridicalEditForm = class(TAncestorDialogForm)
    edName: TcxTextEdit;
    cxLabel1: TcxLabel;
    spInsertUpdate: TdsdStoredProc;
    spGet: TdsdStoredProc;
    ���: TcxLabel;
    ceCode: TcxCurrencyEdit;
    cxLabel2: TcxLabel;
    edGLNCode: TcxTextEdit;
    cbisCorporate: TcxCheckBox;
    cxLabel3: TcxLabel;
    JuridicalGroupGuides: TdsdGuides;
    cxLabel4: TcxLabel;
    GoodsPropertyGuides: TdsdGuides;
    ceJuridicalGroup: TcxButtonEdit;
    ceGoodsProperty: TcxButtonEdit;
    cxLabel5: TcxLabel;
    ceInfoMoney: TcxButtonEdit;
    InfoMoneyGuides: TdsdGuides;
    JuridicalDetailTS: TcxTabSheet;
    PartnerTS: TcxTabSheet;
    Panel: TPanel;
    dxBarManager: TdxBarManager;
    PartnerBar: TdxBar;
    PartnerDockControl: TdxBarDockControl;
    edFullName: TcxDBTextEdit;
    edJuridicalAddress: TcxDBTextEdit;
    edOKPO: TcxDBTextEdit;
    JuridicalDetailsGridDBTableView: TcxGridDBTableView;
    JuridicalDetailsGridLevel: TcxGridLevel;
    JuridicalDetailsGrid: TcxGrid;
    JuridicalDetailsDS: TDataSource;
    JuridicalDetailsCDS: TClientDataSet;
    colJDData: TcxGridDBColumn;
    PartnerDS: TDataSource;
    PartnerCDS: TClientDataSet;
    ContractDS: TDataSource;
    ContractCDS: TClientDataSet;
    PartnerGridDBTableView: TcxGridDBTableView;
    PartnerGridLevel: TcxGridLevel;
    PartnerGrid: TcxGrid;
    ContractGridDBTableView: TcxGridDBTableView;
    ContractGridLevel: TcxGridLevel;
    ContractGrid: TcxGrid;
    actPartnerRefresh: TdsdDataSetRefresh;
    actContractRefresh: TdsdDataSetRefresh;
    spJuridicalDetails: TdsdStoredProc;
    spPartner: TdsdStoredProc;
    spContract: TdsdStoredProc;
    JuridicalDetailsAddOn: TdsdDBViewAddOn;
    PartnerAddOn: TdsdDBViewAddOn;
    ContractAddOn: TdsdDBViewAddOn;
    PageControl: TcxPageControl;
    bbPartnerRefresh: TdxBarButton;
    bbContractRefresh: TdxBarButton;
    ContractBar: TdxBar;
    colPartnerCode: TcxGridDBColumn;
    colPartnerAddress: TcxGridDBColumn;
    colPartnerisErased: TcxGridDBColumn;
    spJuridicalDetailsIU: TdsdStoredProc;
    edINN: TcxDBTextEdit;
    edAccounterName: TcxDBTextEdit;
    edNumberVAT: TcxDBTextEdit;
    BankGuides: TdsdGuides;
    edBankAccount: TcxDBTextEdit;
    JuridicalDetailsUDS: TdsdUpdateDataSet;
    bbStatic: TdxBarStatic;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

initialization
  RegisterClass(TJuridicalEditForm);

end.
