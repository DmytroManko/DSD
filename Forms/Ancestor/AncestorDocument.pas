unit AncestorDocument;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AncestorDBGrid, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, Data.DB, cxDBData, dsdAddOn, dxBarExtItems,
  dxBar, cxClasses, dsdDB, Datasnap.DBClient, dsdAction, Vcl.ActnList,
  cxPropertiesStore, cxGridLevel, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxContainer, Vcl.ComCtrls, dxCore,
  cxDateUtils, cxButtonEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxLabel,
  cxTextEdit, Vcl.ExtCtrls, cxPCdxBarPopupMenu, cxPC, dsdGuides, DataModul,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter, dxSkinsdxBarPainter;

type
  TAncestorDocumentForm = class(TAncestorDBGridForm)
    DataPanel: TPanel;
    edInvNumber: TcxTextEdit;
    cxLabel1: TcxLabel;
    edOperDate: TcxDateEdit;
    cxLabel2: TcxLabel;
    cxLabel15: TcxLabel;
    ceStatus: TcxButtonEdit;
    EntryCDS: TClientDataSet;
    EntryDS: TDataSource;
    spSelectMIContainer: TdsdStoredProc;
    FormParams: TdsdFormParams;
    StatusGuides: TdsdGuides;
    spChangeStatus: TdsdStoredProc;
    spGet: TdsdStoredProc;
    spInsertUpdateMovement: TdsdStoredProc;
    GuidesFiller: TGuidesFiller;
    HeaderSaver: THeaderSaver;
    RefreshAddOn: TRefreshAddOn;
    spErasedMIMaster: TdsdStoredProc;
    spUnErasedMIMaster: TdsdStoredProc;
    spInsertUpdateMIMaster: TdsdStoredProc;
    EntryViewAddOn: TdsdDBViewAddOn;
    colIsErased: TcxGridDBColumn;
    colInvNumber: TcxGridDBColumn;
    colOperDate: TcxGridDBColumn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
