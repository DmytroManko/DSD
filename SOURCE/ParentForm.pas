unit ParentForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.ActnList, Vcl.Forms, Vcl.Dialogs, dsdDB, cxPropertiesStore, frxClass;

const
  MY_MESSAGE = WM_USER + 1;

type
  TParentForm = class(TForm)
  private
    FChoiceAction: TCustomAction;
    FParams: TdsdParams;
    // �����, ������� ������ ������ �����
    FSender: TComponent;
    FFormClassName: string;
    FonAfterShow: TNotifyEvent;
    FisAfterShow: boolean;
    FisFree: boolean;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure SetSender(const Value: TComponent);
    procedure SetisFree(const Value: boolean);
    property FormSender: TComponent read FSender write SetSender;
    procedure AfterShow(var a : TWMSHOWWINDOW); message MY_MESSAGE;
  public
    { Public declarations }
    constructor CreateNew(AOwner: TComponent; Dummy: Integer = 0); override;
    function Execute(Sender: TComponent; Params: TdsdParams): boolean;
    procedure Close(Sender: TObject);
    property FormClassName: string read FFormClassName write FFormClassName;
    property onAfterShow: TNotifyEvent read FonAfterShow write FonAfterShow;
    // � ��������� ���������� ������������ ������ �������� ��� �� �� ������������
    // ������� ��� ��������� ������!!!
    property isAfterShow: boolean read FisAfterShow default false;
  published
    property isFree: boolean read FisFree write SetisFree default true;
    property Params: TdsdParams read FParams write FParams;
  end;

implementation

uses
  cxControls, cxContainer, cxEdit, UtilConst,
  cxGroupBox, dxBevel, cxButtons, cxGridDBTableView, cxGrid, DB, DBClient,
  dxBar, cxTextEdit, cxLabel,
  StdActns, cxDBTL, cxCurrencyEdit, cxDropDownEdit, dsdGuides,
  cxDBLookupComboBox, DBGrids, cxCheckBox, cxCalendar, ExtCtrls, dsdAddOn,
  cxButtonEdit, cxSplitter, Vcl.Menus, cxPC, dsdAction, frxDBSet, dxBarExtItems,
  cxDBPivotGrid, ChoicePeriod, cxGridDBBandedTableView;

{$R *.dfm}

procedure TParentForm.AfterShow(var a : TWMSHOWWINDOW);
var
  i: integer;
begin
  if not FisAfterShow then
    try
      for I := 0 to ComponentCount - 1 do begin
        // ������������ ������� ����������
        if Components[i] is TdsdDataSetRefresh then
           (Components[i] as TdsdDataSetRefresh).Execute;
      end;
      if Assigned(FonAfterShow) then
         FonAfterShow(Self);
    finally
      // ����� ���������� � �������� � ��� ������ ���������
      FisAfterShow := true;
    end;
end;

procedure TParentForm.Close(Sender: TObject);
var FormAction: IFormAction;
begin
  // ���������� ������� �� �������� �����, �������� ��� ������������ ��� �������������
  if Sender is TdsdInsertUpdateGuides then
     if Assigned(FSender) then
        if FSender.GetInterface(IFormAction, FormAction) then
           FormAction.OnFormClose(Params);
  inherited Close;
end;

constructor TParentForm.CreateNew(AOwner: TComponent; Dummy: Integer = 0);
begin
  inherited;
  onKeyDown := FormKeyDown;
  onClose := FormClose;
  onShow := FormShow;
  KeyPreview := true;
end;

function TParentForm.Execute(Sender: TComponent; Params: TdsdParams): boolean;
var
  i: integer;
  ExecuteDialog: TExecuteDialog;
begin
  result := true;
  // ��������� ��������� ����� ����������� �����������
  for I := 0 to ComponentCount - 1 do begin
    if Components[i] is TdsdFormParams then begin
       FParams := (Components[i] as TdsdFormParams).Params;
       FParams.AssignParams(Params);
    end;
    if Components[i] is TdsdChoiceGuides then
       FChoiceAction := Components[i] as TdsdChoiceGuides;
    if Components[i] is TExecuteDialog then
       ExecuteDialog := Components[i] as TExecuteDialog;
  end;
  if Assigned(ExecuteDialog) and ExecuteDialog.OpenBeforeShow then begin
     ExecuteDialog.RefreshAllow := false; // ��� �� �� ���� ���� �������������.
     result := ExecuteDialog.Execute;
  end;
  FormSender := Sender;
end;

procedure TParentForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  // ����� ��� �� ������ ������� OnExit �� ��������� ����������
  ActiveControl := nil;
  if isFree then
     Action := caFree;
end;

procedure TParentForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // Ctrl + Shift + S
  if ShortCut(Key, Shift) = 24659 then begin
     gc_isDebugMode := not gc_isDebugMode;
     if gc_isDebugMode then
        ShowMessage('���������� ����� �������')
      else
        ShowMessage('���� ����� �������');
  end;
  // Ctrl + Shift + T
  if ShortCut(Key, Shift) = 24660 then begin
     gc_isShowTimeMode := not gc_isShowTimeMode;
     if gc_isShowTimeMode then
        ShowMessage('���������� ����� �������� �������')
      else
        ShowMessage('���� ����� �������� �������');
  end;
  // Ctrl + Shift + D
  if ShortCut(Key, Shift) = 24644 then begin
     gc_isSetDefault := not gc_isSetDefault;
     if gc_isSetDefault then
        ShowMessage('��������� ������������ �� �����������')
      else
        ShowMessage('��������� ������������ �����������');
  end;
end;

procedure TParentForm.FormShow(Sender: TObject);
begin
  PostMessage(Handle, MY_MESSAGE, 0, 0);
end;

procedure TParentForm.SetisFree(const Value: boolean);
begin
  FisFree := Value;
end;

procedure TParentForm.SetSender(const Value: TComponent);
begin
  FSender := Value;
  // � ����������� �� ����, ��� ���� ������� ����� �������� ��������� ���������

  // ���� �������� ��� ������, �� ������ ������� ������ ������
  if Assigned(FChoiceAction) then begin
     FChoiceAction.Visible := Assigned(FSender) and Supports(FSender, IChoiceCaller);
     FChoiceAction.Enabled := FChoiceAction.Visible;
     if Supports(FSender, IChoiceCaller) then
        // ���������� ���������� ���������� � ������ ������!!!
        TdsdChoiceGuides(FChoiceAction).ChoiceCaller := FSender as IChoiceCaller;
  end;
end;

initialization
  // ����������� ����������
  RegisterClass (TActionList);
  RegisterClass (TClientDataSet);
  RegisterClass (TDataSource);
  RegisterClass (TDBGrid);
  RegisterClass (TFileExit);
  RegisterClass (TPopupMenu);
  RegisterClass (TPanel);
  // ���������� DevExpress

  RegisterClass (TcxButton);
  RegisterClass (TcxButtonEdit);
  RegisterClass (TcxCheckBox);
  RegisterClass (TcxCurrencyEdit);
  RegisterClass (TcxDateEdit);
  RegisterClass (TcxDBPivotGrid);
  RegisterClass (TcxDBPivotGridField);
  RegisterClass (TcxDBTreeList);
  RegisterClass (TcxDBTreeListColumn);
  RegisterClass (TcxGroupBox);
  RegisterClass (TcxGridDBBandedTableView);
  RegisterClass (TcxGridDBTableView);
  RegisterClass (TcxGrid);
  RegisterClass (TcxLabel);
  RegisterClass (TcxLookupComboBox);
  RegisterClass (TcxPageControl);
  RegisterClass (TcxPopupEdit);
  RegisterClass (TcxPropertiesStore);
  RegisterClass (TcxSplitter);
  RegisterClass (TcxTabSheet);
  RegisterClass (TcxTextEdit);

  RegisterClass (TdxBarManager);
  RegisterClass (TdxBarStatic);
  RegisterClass (TdxBevel);

  // FastReport
  RegisterClass (TfrxDBDataset);

  // ������������ ����������
  RegisterClass (TBooleanStoredProcAction);
  RegisterClass (TChangeStatus);
  RegisterClass (TChangeGuidesStatus);
  RegisterClass (TCrossDBViewAddOn);
  RegisterClass (TdsdChangeMovementStatus);
  RegisterClass (TdsdChoiceGuides);
  RegisterClass (TdsdDataSetRefresh);
  RegisterClass (TdsdDBViewAddOn);
  RegisterClass (TdsdDBTreeAddOn);
  RegisterClass (TdsdExecStoredProc);
  RegisterClass (TdsdFormClose);
  RegisterClass (TdsdFormParams);
  RegisterClass (TdsdGridToExcel);
  RegisterClass (TdsdGuides);
  RegisterClass (TdsdInsertUpdateAction);
  RegisterClass (TdsdInsertUpdateGuides);
  RegisterClass (TdsdOpenForm);
  RegisterClass (TdsdPrintAction);
  RegisterClass (TdsdStoredProc);
  RegisterClass (TdsdUpdateDataSet);
  RegisterClass (TdsdUpdateErased);
  RegisterClass (TdsdUserSettingsStorageAddOn);
  RegisterClass (TExecuteDialog);
  RegisterClass (TGuidesFiller);
  RegisterClass (THeaderSaver);
  RegisterClass (TInsertRecord);
  RegisterClass (TOpenChoiceForm);
  RegisterClass (TPeriodChoice);
  RegisterClass (TRefreshAddOn);
  RegisterClass (TRefreshDispatcher);
  RegisterClass (TUpdateRecord);

// ��� �����

  RegisterClass (TDBGrid);

end.
