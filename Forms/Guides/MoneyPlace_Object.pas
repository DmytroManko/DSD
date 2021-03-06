unit MoneyPlace_Object;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AncestorEnum, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxPCdxBarPopupMenu, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, Data.DB, cxDBData,
  dsdAddOn, dxBarExtItems, dxBar, cxClasses, dsdDB, Datasnap.DBClient,
  dsdAction, Vcl.ActnList, cxPropertiesStore, cxGridLevel, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxPC;

type
  TMoneyPlace_ObjectForm = class(TAncestorEnumForm)
    colItemName: TcxGridDBColumn;
    colCode: TcxGridDBColumn;
    colName: TcxGridDBColumn;
    colInfoMoneyName: TcxGridDBColumn;
    colContractNumber: TcxGridDBColumn;
    colStartDate: TcxGridDBColumn;
    colContractKindName: TcxGridDBColumn;
    colisErased: TcxGridDBColumn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

initialization
  RegisterClass(TMoneyPlace_ObjectForm);

end.
