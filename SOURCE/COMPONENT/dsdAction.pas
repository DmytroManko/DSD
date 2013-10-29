unit dsdAction;

interface

uses VCL.ActnList, Forms, Classes, dsdDB, DB, DBClient, UtilConst,
     cxGrid, dsdGuides, ImgList, cxPC, cxGridDBTableView;

type
  TDataSetAcionType = (acInsert, acUpdate);

  TdsdStoredProcItem = class(TCollectionItem)
  private
    FStoredProc: TdsdStoredProc;
    procedure SetStoredProc(const Value: TdsdStoredProc);
  protected
    function GetDisplayName: string; override;
  published
    property StoredProc: TdsdStoredProc read FStoredProc write SetStoredProc;
  end;

  TdsdStoredProcList = class(TOwnedCollection)
  private
    function GetItem(Index: Integer): TdsdStoredProcItem;
    procedure SetItem(Index: Integer; const Value: TdsdStoredProcItem);
  public
    function Add: TdsdStoredProcItem;
    property Items[Index: Integer]: TdsdStoredProcItem read GetItem write SetItem; default;
  end;

  // �������� ������� ��� ��������� ����� ���������� ��������
  IDataSetAction = interface
    procedure DataSetChanged;
    procedure UpdateData;
  end;

  // �������� ������� � �����
  IFormAction = interface
    ['{9647E6F2-B61C-46FC-83E7-F3E1C69B8699}']
    procedure OnFormClose(Params: TdsdParams);
  end;

  TOnPageChanging = procedure (Sender: TObject; NewPage: TcxTabSheet; var AllowChange: Boolean) of object;

  // ����� ����� ����� ��� ����������� ����� ��������. �������� ��������� TabSheet
  TdsdCustomAction = class(TCustomAction)
  private
    FOnPageChanging: TOnPageChanging;
    FTabSheet: TcxTabSheet;
    procedure SetTabSheet(const Value: TcxTabSheet); virtual;
  protected
    procedure OnPageChanging(Sender: TObject; NewPage: TcxTabSheet; var AllowChange: Boolean); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  published
    // ��� ��������� ������� �������� Action ����� ����������� ������ ���� TabSheet �������
    property TabSheet: TcxTabSheet read FTabSheet write SetTabSheet;
  end;

  TDataSetDataLink = class(TDataLink)
  private
    FAction: IDataSetAction;
    // ������ ����, ������ ��� UpdateData ����������� ������!!!
    FModified: boolean;
  protected
    procedure EditingChanged; override;
    procedure DataSetChanged; override;
    procedure UpdateData; override;
  public
    constructor Create(Action: IDataSetAction);
  end;

  TdsdCustomDataSetAction = class(TdsdCustomAction, IDataSetAction)
  private
    FStoredProcList: TdsdStoredProcList;
    function GetStoredProc: TdsdStoredProc;
    procedure SetStoredProc(const Value: TdsdStoredProc);
  protected
    procedure DataSetChanged; virtual;
    procedure UpdateData;     virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    function Execute: boolean; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property StoredProc: TdsdStoredProc read GetStoredProc write SetStoredProc;
    property StoredProcList: TdsdStoredProcList read FStoredProcList write FStoredProcList;
    property Caption;
    property Hint;
    property ImageIndex;
    property ShortCut;
    property SecondaryShortCuts;
  end;

  TdsdDataSetRefresh = class(TdsdCustomDataSetAction)
  private
    FRefreshOnTabSetChanges: boolean;
  protected
    procedure OnPageChanging(Sender: TObject; NewPage: TcxTabSheet; var AllowChange: Boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property RefreshOnTabSetChanges: boolean read FRefreshOnTabSetChanges write FRefreshOnTabSetChanges;
  end;

  // ��������� ��� �������� �������� � ����������� � ��������� �����
  TdsdInsertUpdateGuides = class (TdsdCustomDataSetAction)
  private
    FInsertUpdateAction: TCustomAction;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    function Execute: boolean; override;
    property InsertUpdateAction: TCustomAction read FInsertUpdateAction write FInsertUpdateAction;
  end;

  TdsdExecStoredProc = class(TdsdCustomDataSetAction)

  end;

  TdsdUpdateDataSet = class(TdsdCustomDataSetAction)
  private
    FAlreadyRun: boolean;
    FDataSetDataLink: TDataSetDataLink;
    function GetDataSource: TDataSource;
    procedure SetDataSource(const Value: TDataSource);
  protected
    procedure UpdateData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  end;

  TCustomChangeStatus = class (TdsdCustomDataSetAction)
  private
    FStatus: TdsdMovementStatus;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Status: TdsdMovementStatus read FStatus write FStatus;
  end;

  // �������� ������ ���������
  TChangeGuidesStatus = class (TCustomChangeStatus)
  private
    FGuides: TdsdGuides;
    FOnChange: TNotifyEvent;
    procedure OnChange(Sender: TObject);
    procedure SetGuides(const Value: TdsdGuides);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    function Execute: boolean; override;
  published
    property Guides: TdsdGuides read FGuides write SetGuides;
  end;

  // �������� ������ ���������� � �����
  TdsdChangeMovementStatus = class (TCustomChangeStatus)
  private
    FActionDataLink: TDataSetDataLink;
    procedure SetDataSource(const Value: TDataSource);
    function GetDataSource: TDataSource;
  protected
    procedure DataSetChanged; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: boolean; override;
  published
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  end;

  TdsdUpdateErased = class(TdsdCustomDataSetAction, IDataSetAction)
  private
    FActionDataLink: TDataSetDataLink;
    FisSetErased: boolean;
    FErasedFieldName: string;
    function GetDataSource: TDataSource;
    procedure SetDataSource(const Value: TDataSource);
    procedure SetisSetErased(const Value: boolean);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    procedure DataSetChanged; override;
    function Execute: boolean; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property ErasedFieldName: string read FErasedFieldName write FErasedFieldName;
    property isSetErased: boolean read FisSetErased write SetisSetErased default true;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  end;

  TdsdOpenForm = class(TdsdCustomAction, IFormAction)
  private
    FParams: TdsdParams;
    FFormName: string;
    FisShowModal: boolean;
  protected
    procedure BeforeExecute(Form: TForm); virtual;
    procedure OnFormClose(Params: TdsdParams); virtual;
    function ShowForm: TForm;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    function Execute: boolean; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Caption;
    property Hint;
    property ShortCut;
    property ImageIndex;
    property SecondaryShortCuts;
    property FormName: string read FFormName write FFormName;
    property GuiParams: TdsdParams read FParams write FParams;
    property isShowModal: boolean read FisShowModal write FisShowModal;
  end;

  // �������� ����� ��� ������ �������� �� �����������
  TOpenChoiceForm = class(TdsdOpenForm, IChoiceCaller)
  private
    // �������� ��������� ����� ������ �������� �� �����������
    procedure SetOwner(Owner: TObject);
    procedure AfterChoice(Params: TdsdParams; Form: TForm);
  end;

  TDSAction = class(TdsdCustomAction)
  private
    FAction: TCustomAction;
    FView: TcxGridDBTableView;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ChangeDSState; virtual; abstract;
  public
    function Execute: boolean; override;
  published
    property View: TcxGridDBTableView read FView write FView;
    property Action: TCustomAction read FAction write FAction;
    property Caption;
    property Hint;
    property ShortCut;
    property ImageIndex;
    property SecondaryShortCuts;
  end;

  // ��������� ������
  TInsertRecord = class(TDSAction)
  protected
    procedure ChangeDSState; override;
  end;

  // ����������� ������
  TUpdateRecord = class(TDSAction)
  protected
    procedure ChangeDSState; override;
  end;

  // ������ ����� ��������� ��������� ������ TdsdOpenForm �� ������ �� �������������
  // � ��������� ������������ ����� ������� ����
  TdsdInsertUpdateAction = class (TdsdOpenForm, IDataSetAction, IFormAction)
  private
    FActionDataLink: TDataSetDataLink;
    FdsdDataSetRefresh: TdsdDataSetRefresh;
    FActionType: TDataSetAcionType;
    function GetDataSource: TDataSource;
    procedure SetDataSource(const Value: TDataSource);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DataSetChanged;
    procedure UpdateData; virtual;
    procedure OnFormClose(Params: TdsdParams); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property ActionType: TDataSetAcionType read FActionType write FActionType default acInsert;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DataSetRefresh: TdsdDataSetRefresh read FdsdDataSetRefresh write FdsdDataSetRefresh;
  end;


  TdsdFormClose = class(TdsdCustomAction)
  public
    function Execute: boolean; override;
  end;

  // �������� ������ �������� �� �����������
  // ��������� ��������� ����� ���������� �����������. ��������� ����������� �� �����
  // � ��������� �����
  TdsdChoiceGuides = class(TdsdCustomAction, IDataSetAction)
  private
    FActionDataLink: TDataSetDataLink;
    FParams: TdsdParams;
    FChoiceCaller: IChoiceCaller;
    function GetDataSource: TDataSource;
    procedure SetDataSource(const Value: TDataSource);
    procedure SetChoiceCaller(const Value: IChoiceCaller);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DataSetChanged;
    procedure UpdateData;
  public
    property ChoiceCaller: IChoiceCaller read FChoiceCaller write SetChoiceCaller;
    function Execute: boolean; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Params: TdsdParams read FParams write FParams;
    property Caption;
    property Hint;
    property ShortCut;
    property ImageIndex;
    property SecondaryShortCuts;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  end;

  TdsdGridToExcel = class (TdsdCustomAction)
  private
    FGrid: TcxGrid;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    function Execute: boolean; override;
    constructor Create(AOwner: TComponent); override;
  published
    property Grid: TcxGrid read FGrid write FGrid;
    property Caption;
    property Hint;
    property ImageIndex;
    property ShortCut;
  end;

  // �������� ������
  TdsdPrintAction = class(TdsdCustomDataSetAction)
  private
    FReportName: String;
    FParams: TdsdParams;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    function Execute: boolean; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Params: TdsdParams read FParams write FParams;
    property ReportName: String read FReportName write FReportName;
    property Caption;
    property Hint;
    property ImageIndex;
    property ShortCut;
  end;

  TBooleanStoredProcAction = class (TdsdCustomDataSetAction)
  private
    FImageIndexFalse: TImageIndex;
    FImageIndexTrue: TImageIndex;
    FValue: Boolean;
    FHintFalse: String;
    FHintTrue: String;
    FCaptionFalse: String;
    FCaptionTrue: String;
    procedure SetImageIndexFalse(const Value: TImageIndex);
    procedure SetImageIndexTrue(const Value: TImageIndex);
    procedure SetValue(const Value: Boolean);
    procedure SetCaptionFalse(const Value: String);
    procedure SetCaptionTrue(const Value: String);
    procedure SetHintFalse(const Value: String);
    procedure SetHintTrue(const Value: String);
  public
    function Execute: boolean; override;
    constructor Create(AOwner: TComponent); override;
  published
    property Value: Boolean read FValue write SetValue;
    property HintTrue: String read FHintTrue write SetHintTrue;
    property HintFalse: String read FHintFalse write SetHintFalse;
    property CaptionTrue: String read FCaptionTrue write SetCaptionTrue;
    property CaptionFalse: String read FCaptionFalse write SetCaptionFalse;
    property ImageIndexTrue: TImageIndex read FImageIndexTrue write SetImageIndexTrue;
    property ImageIndexFalse: TImageIndex read FImageIndexFalse write SetImageIndexFalse;
  end;

  procedure Register;

implementation

uses Windows, Storage, SysUtils, CommonData, UtilConvert, FormStorage,
     Vcl.Controls, Menus, cxGridExportLink, ShellApi, frxClass, frxDesgn,
     messages, ParentForm;

procedure Register;
begin
  RegisterActions('DSDLib', [TBooleanStoredProcAction], TBooleanStoredProcAction);
  RegisterActions('DSDLib', [TChangeGuidesStatus], TChangeGuidesStatus);
  RegisterActions('DSDLib', [TdsdChangeMovementStatus], TdsdChangeMovementStatus);
  RegisterActions('DSDLib', [TdsdChoiceGuides],   TdsdChoiceGuides);
  RegisterActions('DSDLib', [TdsdDataSetRefresh], TdsdDataSetRefresh);
  RegisterActions('DSDLib', [TdsdExecStoredProc], TdsdExecStoredProc);
  RegisterActions('DSDLib', [TdsdFormClose],      TdsdFormClose);
  RegisterActions('DSDLib', [TdsdGridToExcel],    TdsdGridToExcel);
  RegisterActions('DSDLib', [TdsdInsertUpdateAction], TdsdInsertUpdateAction);
  RegisterActions('DSDLib', [TdsdInsertUpdateGuides], TdsdInsertUpdateGuides);
  RegisterActions('DSDLib', [TdsdOpenForm],       TdsdOpenForm);
  RegisterActions('DSDLib', [TdsdPrintAction],    TdsdPrintAction);
  RegisterActions('DSDLib', [TdsdUpdateErased], TdsdUpdateErased);
  RegisterActions('DSDLib', [TdsdUpdateDataSet], TdsdUpdateDataSet);
  RegisterActions('DSDLib', [TInsertRecord], TInsertRecord);
  RegisterActions('DSDLib', [TOpenChoiceForm], TOpenChoiceForm);
  RegisterActions('DSDLib', [TUpdateRecord], TUpdateRecord);
end;

{ TdsdCustomDataSetAction }

constructor TdsdCustomDataSetAction.Create(AOwner: TComponent);
begin
  inherited;
  FStoredProcList := TdsdStoredProcList.Create(Self, TdsdStoredProcItem);
end;

procedure TdsdCustomDataSetAction.DataSetChanged;
begin

end;

destructor TdsdCustomDataSetAction.Destroy;
begin
  FStoredProcList.Free;
  FStoredProcList := nil;
  inherited;
end;

function TdsdCustomDataSetAction.Execute: boolean;
var i: integer;
begin
  result := true;
  for I := 0 to StoredProcList.Count - 1  do
      if Assigned(StoredProcList[i]) then
         if Assigned(StoredProcList[i].StoredProc) then
            StoredProcList[i].StoredProc.Execute
end;


function TdsdCustomDataSetAction.GetStoredProc: TdsdStoredProc;
begin
  if StoredProcList.Count > 0 then begin
     if Assigned(StoredProcList[0].StoredProc) then
        result := StoredProcList[0].StoredProc
     else
        result := nil
  end
  else
     result := nil
end;

procedure TdsdCustomDataSetAction.Notification(AComponent: TComponent;
  Operation: TOperation);
var i: integer;
begin
  inherited;
  if csDesigning in ComponentState then
    if (Operation = opRemove) and (AComponent is TdsdStoredProc) and Assigned(StoredProcList) then begin
       for i := 0 to StoredProcList.Count - 1 do
           if StoredProcList[i].StoredProc = AComponent then
              StoredProcList[i].StoredProc := nil;
       if StoredProc = AComponent then
          StoredProc := nil
    end;
end;

procedure TdsdCustomDataSetAction.SetStoredProc(const Value: TdsdStoredProc);
begin
  // ���� ��������������� ���
  if Value <> nil then begin
     if StoredProcList.Count > 0 then
        StoredProcList[0].StoredProc := Value
     else
        StoredProcList.Add.StoredProc := Value;
  end
  else begin
    //���� �������� � NIL
    if StoredProcList.Count > 0 then
       StoredProcList.Delete(0);
  end;
end;

procedure TdsdCustomDataSetAction.UpdateData;
begin

end;

{ TdsdDataSetRefresh }

constructor TdsdDataSetRefresh.Create(AOwner: TComponent);
begin
  inherited;
  Caption := '����������';
  Hint:='�������� ������';
  ShortCut:=VK_F5
end;

procedure TdsdDataSetRefresh.OnPageChanging(Sender: TObject;
  NewPage: TcxTabSheet; var AllowChange: Boolean);
begin
  inherited;
  if not(csDesigning in ComponentState) then
     if Enabled and RefreshOnTabSetChanges then
        Execute;
end;

{ TdsdOpenForm }

procedure TdsdOpenForm.BeforeExecute;
begin

end;

constructor TdsdOpenForm.Create(AOwner: TComponent);
begin
  inherited;
  FParams := TdsdParams.Create(Self, TdsdParam);
end;

destructor TdsdOpenForm.Destroy;
begin
  FParams.Free;
  FParams := nil;
  inherited;
end;

function TdsdOpenForm.Execute: boolean;
begin
  ShowForm
end;

procedure TdsdOpenForm.Notification(AComponent: TComponent;
  Operation: TOperation);
var i: integer;
begin
  inherited;
  if csDesigning in ComponentState then
    if (Operation = opRemove) and Assigned(FParams) then
       for i := 0 to GuiParams.Count - 1 do
           if GuiParams[i].Component = AComponent then
              GuiParams[i].Component := nil;
end;

procedure TdsdOpenForm.OnFormClose(Params: TdsdParams);
begin

end;

function TdsdOpenForm.ShowForm: TForm;
begin
  Result := TdsdFormStorageFactory.GetStorage.Load(FormName);
  BeforeExecute(Result);
  if TParentForm(Result).Execute(Self, FParams) then
    if isShowModal then
       Result.ShowModal
    else
       Result.Show
  else
    Result.Free
end;

{ TdsdFormClose }

function TdsdFormClose.Execute: boolean;
begin
  if Owner is TForm then
     (Owner as TForm).Close;
end;

{ TdsdInsertUpdateAction }

constructor TdsdInsertUpdateAction.Create(AOwner: TComponent);
begin
  inherited;
  FActionDataLink := TDataSetDataLink.Create(Self);
end;

procedure TdsdInsertUpdateAction.DataSetChanged;
begin
  Enabled := false;
  if Assigned(DataSource) then
     if Assigned(DataSource.DataSet) then
        Enabled := (ActionType = acInsert) or (DataSource.DataSet.RecordCount <> 0)
end;

destructor TdsdInsertUpdateAction.Destroy;
begin
  FActionDataLink.Free;
  inherited;
end;

function TdsdInsertUpdateAction.GetDataSource: TDataSource;
begin
  result := FActionDataLink.DataSource
end;

procedure TdsdInsertUpdateAction.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if csDesigning in ComponentState then
    if (Operation = opRemove) and (AComponent = DataSource) then
       DataSource := nil;
end;

procedure TdsdInsertUpdateAction.OnFormClose(Params: TdsdParams);
begin
  inherited;
  // ������� ���������� � ������ �������� ����� ���������� ��������� �����������.
  // ���������� � ����� ������ ���������� ������ � ������������������� � ���
  // ��� ���������� ������ � ���������������� �� ���
  DataSetRefresh.Execute;
  if Assigned(DataSource) then
     if Assigned(DataSource.DataSet) then
        if Assigned(Params) then
           DataSource.DataSet.Locate('Id', Params.ParamByName('Id').Value, []);
end;

procedure TdsdInsertUpdateAction.SetDataSource(const Value: TDataSource);
begin
  FActionDataLink.DataSource := Value;
end;

procedure TdsdInsertUpdateAction.UpdateData;
begin

end;

{ TActionDataLink }

constructor TDataSetDataLink.Create(Action: IDataSetAction);
begin
  inherited Create;
  FAction := Action;
end;

procedure TDataSetDataLink.DataSetChanged;
begin
  inherited;
  if Assigned(FAction) then
     FAction.DataSetChanged;
end;

procedure TDataSetDataLink.EditingChanged;
begin
  inherited;
  if Assigned(DataSource) and (DataSource.State in [dsEdit, dsInsert]) then
     FModified := true;
end;

procedure TDataSetDataLink.UpdateData;
begin
  inherited;
  if Assigned(FAction) and FModified then
     FAction.UpdateData;
  FModified := false;
end;

{ TdsdUpdateErased }

constructor TdsdUpdateErased.Create(AOwner: TComponent);
begin
  inherited;
  FErasedFieldName := gcisErased;
  FActionDataLink := TDataSetDataLink.Create(Self);
  isSetErased := true;
end;

procedure TdsdUpdateErased.DataSetChanged;
begin
  Enabled := false;
  if Assigned(DataSource) then
     if Assigned(DataSource.DataSet) then
        if DataSource.DataSet.RecordCount = 0 then
           Enabled := false
        else
           if FisSetErased then
              Enabled := not DataSource.DataSet.FieldByName(ErasedFieldName).AsBoolean
           else
              Enabled := DataSource.DataSet.FieldByName(ErasedFieldName).AsBoolean
end;

destructor TdsdUpdateErased.Destroy;
begin
  FActionDataLink.Free;
  inherited;
end;

function TdsdUpdateErased.Execute: boolean;
var lDataSet: TDataSet;
begin
  result := inherited Execute;
  if result and Assigned(DataSource) and Assigned(DataSource.DataSet) then begin
     lDataSet := DataSource.DataSet;
     // ��� �� �� ���������� ������� ����� �� Post
     DataSource.DataSet := nil;
     try
       lDataSet.Edit;
       lDataSet.FieldByName(ErasedFieldName).AsBoolean := isSetErased;
       lDataSet.Post;
     finally
       DataSource.DataSet := lDataSet;
     end;
  end;
end;

function TdsdUpdateErased.GetDataSource: TDataSource;
begin
  result := FActionDataLink.DataSource
end;

procedure TdsdUpdateErased.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if csDesigning in ComponentState then
    if (Operation = opRemove) and (AComponent = DataSource) then
       DataSource := nil;
end;

procedure TdsdUpdateErased.SetDataSource(const Value: TDataSource);
begin
  FActionDataLink.DataSource := Value
end;

procedure TdsdUpdateErased.SetisSetErased(const Value: boolean);
begin
  FisSetErased := Value;
  if csDesigning in ComponentState then
    if FisSetErased then
    begin
      Caption := '�������';
      Hint:='������� ������';
      ShortCut:=VK_DELETE
    end
    else
    begin
      Caption := '������������';
      Hint:='������������ ������';
    end;
end;

{ TdsdStoredProcList }

function TdsdStoredProcList.Add: TdsdStoredProcItem;
begin
  result := TdsdStoredProcItem(inherited Add)
end;

function TdsdStoredProcList.GetItem(Index: Integer): TdsdStoredProcItem;
begin
  Result := TdsdStoredProcItem(inherited GetItem(Index))
end;

procedure TdsdStoredProcList.SetItem(Index: Integer;
  const Value: TdsdStoredProcItem);
begin
  inherited SetItem(Index, Value);
end;

{ TdsdChoiceGuides }

constructor TdsdChoiceGuides.Create(AOwner: TComponent);
begin
  inherited;
  FActionDataLink := TDataSetDataLink.Create(Self);
  FParams := TdsdParams.Create(Self, TdsdParam);
  Caption := '����� �� �����������';
  Hint := '����� �� �����������';
end;

procedure TdsdChoiceGuides.DataSetChanged;
begin
  Enabled := false;
  // ���� ��������������� �����
  if Assigned(DataSource) and Assigned(FChoiceCaller) then
     if Assigned(DataSource.DataSet) then
        Enabled := (DataSource.DataSet.RecordCount <> 0)
end;

destructor TdsdChoiceGuides.Destroy;
begin
  FActionDataLink.Free;
  FreeAndNil(FParams);
  inherited;
end;

function TdsdChoiceGuides.Execute: boolean;
begin
  if Assigned(FParams.ParamByName('Key')) and Assigned(FParams.ParamByName('TextValue')) then
     FChoiceCaller.AfterChoice(FParams, TForm(Owner))
  else
     raise Exception.Create('�� ���������� ��������� �������� �������� ��� ������ �� �����������');
end;

function TdsdChoiceGuides.GetDataSource: TDataSource;
begin
  result := FActionDataLink.DataSource
end;

procedure TdsdChoiceGuides.Notification(AComponent: TComponent;
  Operation: TOperation);
var i: integer;
begin
  inherited;
  if csDesigning in ComponentState then
    if (Operation = opRemove) then begin
       if Assigned(Params) then
         for i := 0 to Params.Count - 1 do
             if Params[i].Component = AComponent then
                Params[i].Component := nil;
       if (AComponent = DataSource) then
           DataSource := nil;
    end;
end;

procedure TdsdChoiceGuides.SetChoiceCaller(const Value: IChoiceCaller);
begin
  FChoiceCaller := Value;
end;

procedure TdsdChoiceGuides.SetDataSource(const Value: TDataSource);
begin
  FActionDataLink.DataSource := Value;
end;

procedure TdsdChoiceGuides.UpdateData;
begin

end;

{ TdsdChangeMovementStatus }

constructor TdsdChangeMovementStatus.Create(AOwner: TComponent);
begin
  inherited;
  FActionDataLink := TDataSetDataLink.Create(Self);
end;

procedure TdsdChangeMovementStatus.DataSetChanged;
begin
  Enabled := (DataSource.DataSet.RecordCount > 0)
    and (DataSource.DataSet.FieldByName('StatusCode').AsInteger <> (Integer(Status) + 1));
end;

destructor TdsdChangeMovementStatus.Destroy;
begin
  FActionDataLink.Free;
  inherited;
end;

function TdsdChangeMovementStatus.Execute: boolean;
var lDataSet: TDataSet;
begin
  if result and Assigned(DataSource) and Assigned(DataSource.DataSet) then begin
     lDataSet := DataSource.DataSet;
     // ��� �� �� ���������� ������� ����� �� Post
     DataSource.DataSet := nil;
     try
       lDataSet.Edit;
       lDataSet.FieldByName('StatusCode').AsInteger := Integer(Status) + 1;
       lDataSet.Post;
     finally
       DataSource.DataSet := lDataSet;
     end;
  end;
  result := inherited Execute;
end;

function TdsdChangeMovementStatus.GetDataSource: TDataSource;
begin
  result := FActionDataLink.DataSource;
end;

procedure TdsdChangeMovementStatus.SetDataSource(const Value: TDataSource);
begin
  FActionDataLink.DataSource := Value;
end;

{ TdsdUpdateDataSet }

constructor TdsdUpdateDataSet.Create(AOwner: TComponent);
begin
  inherited;
  FAlreadyRun := false;
  FDataSetDataLink := TDataSetDataLink.Create(Self);
end;

destructor TdsdUpdateDataSet.Destroy;
begin
  FDataSetDataLink.Free;
  inherited;
end;

function TdsdUpdateDataSet.GetDataSource: TDataSource;
begin
  result := FDataSetDataLink.DataSource;
end;

procedure TdsdUpdateDataSet.SetDataSource(const Value: TDataSource);
begin
  FDataSetDataLink.DataSource := Value;
end;

procedure TdsdUpdateDataSet.UpdateData;
begin
  // ������� ����
  if FAlreadyRun then
     exit;
  FAlreadyRun := true;
  try
    Execute;
  finally
    FAlreadyRun := false;
  end;
end;

{ TdsdGridToExcel }

constructor TdsdGridToExcel.Create(AOwner: TComponent);
begin
  inherited;
  Caption := '�������� � Excel';
  Hint := '�������� � Excel';
  ShortCut := TextToShortCut('Ctrl+X');
end;

function TdsdGridToExcel.Execute: boolean;
begin
  ExportGridToExcel('#$#$#$.xls', FGrid);
  ShellExecute(Application.Handle, 'open', PWideChar('#$#$#$.xls'), nil, nil, SW_SHOWNORMAL);
end;

procedure TdsdGridToExcel.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if csDesigning in ComponentState then
    if (Operation = opRemove) and (AComponent = FGrid) then
       FGrid := nil;
end;

{ TdsdPrintAction }


constructor TdsdPrintAction.Create(AOwner: TComponent);
begin
  inherited;
  FParams := TdsdParams.Create(Self, TdsdParam);
end;

destructor TdsdPrintAction.Destroy;
begin
  FreeAndNil(FParams);
  inherited;
end;

function TdsdPrintAction.Execute: boolean;
var i: integer;
    Stream: TStringStream;
begin
  inherited;
  Stream := TStringStream.Create;
  try
    with TfrxReport.Create(nil) do begin
      if ShiftDown then begin
         try
           LoadFromStream(TdsdFormStorageFactory.GetStorage.LoadReport(ReportName));
         except
         end;
         for i := 0 to Params.Count - 1 do
             Variables[Params[i].Name] := chr(39) + Params[i].AsString + chr(39);
         DesignReport;
         Stream.Clear;
         SaveToStream(Stream);
         Stream.Position := 0;
         TdsdFormStorageFactory.GetStorage.SaveReport(Stream, ReportName);
      end
      else begin
         LoadFromStream(TdsdFormStorageFactory.GetStorage.LoadReport(ReportName));
         for i := 0 to Params.Count - 1 do
             Variables[Params[i].Name] := chr(39) + Params[i].AsString + chr(39);
         PrepareReport;
         ShowReport;
      end;
    end;
  finally
    Stream.Free
  end;
end;

procedure TdsdPrintAction.Notification(AComponent: TComponent;
  Operation: TOperation);
var i: integer;
begin
  inherited;
  if csDesigning in ComponentState then
    if (Operation = opRemove) and Assigned(Params) then
       for i := 0 to Params.Count - 1 do
           if Params[i].Component = AComponent then
              Params[i].Component := nil;
end;

{ TdsdInsertUpdateGuides }

function TdsdInsertUpdateGuides.Execute: boolean;
begin
  inherited;
  TParentForm(Owner).Close(Self);
end;

procedure TdsdInsertUpdateGuides.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if csDesigning in ComponentState then
    if (Operation = opRemove) and (FInsertUpdateAction = AComponent) then
       FInsertUpdateAction := nil
end;

{ TBooleanStoredProcAction }

constructor TBooleanStoredProcAction.Create(AOwner: TComponent);
begin
  inherited;
  FImageIndexTrue := -1;
  FImageIndexFalse := -1;
  FHintFalse := '�������� ���';
  FHintTrue := '�������� ������ � ���������';
  FCaptionFalse := '�������� ���';
  FCaptionTrue := '�������� ������ � ���������';
  FValue := false;
end;

function TBooleanStoredProcAction.Execute: boolean;
begin
  Value := not Value;
  result := inherited;
end;

procedure TBooleanStoredProcAction.SetCaptionFalse(const Value: String);
begin
  FCaptionFalse := Value;
  Self.Value := Self.Value;
end;

procedure TBooleanStoredProcAction.SetCaptionTrue(const Value: String);
begin
  FCaptionTrue := Value;
  Self.Value := Self.Value;
end;

procedure TBooleanStoredProcAction.SetHintFalse(const Value: String);
begin
  FHintFalse := Value;
  Self.Value := Self.Value;
end;

procedure TBooleanStoredProcAction.SetHintTrue(const Value: String);
begin
  FHintTrue := Value;
  Self.Value := Self.Value;
end;

procedure TBooleanStoredProcAction.SetImageIndexFalse(const Value: TImageIndex);
begin
  FImageIndexFalse := Value;
  Self.Value := Self.Value;
end;

procedure TBooleanStoredProcAction.SetImageIndexTrue(const Value: TImageIndex);
begin
  FImageIndexTrue := Value;
  Self.Value := Self.Value;
end;

procedure TBooleanStoredProcAction.SetValue(const Value: Boolean);
begin
  FValue := Value;
  if Value then begin
     ImageIndex := ImageIndexTrue;
     Caption := CaptionTrue;
     Hint := HintTrue;
  end
  else begin
     ImageIndex := ImageIndexFalse;
     Caption := CaptionFalse;
     Hint := HintFalse;
  end;
end;

{ TdsdCustomAction }

procedure TdsdCustomAction.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if csDesigning in ComponentState then
    if (Operation = opRemove) and (AComponent = TabSheet) then
       TabSheet := nil;
end;

procedure TdsdCustomAction.OnPageChanging(Sender: TObject; NewPage: TcxTabSheet;
  var AllowChange: Boolean);
begin
  if Assigned(FOnPageChanging) then
     FOnPageChanging(Sender, NewPage, AllowChange);
  Enabled := TabSheet = NewPage;
  Visible := Enabled;
end;

procedure TdsdCustomAction.SetTabSheet(const Value: TcxTabSheet);
begin
  FTabSheet := Value;
  if Assigned(FTabSheet) then begin
     FOnPageChanging := FTabSheet.PageControl.OnPageChanging;
     FTabSheet.PageControl.OnPageChanging := OnPageChanging;
     Enabled := TabSheet = FTabSheet.PageControl.ActivePage;
     Visible := Enabled
  end;
end;

{ TdsdStoredProcItem }

function TdsdStoredProcItem.GetDisplayName: string;
begin
  result := inherited;
  if Assigned(FStoredProc) then
     result := FStoredProc.Name + ' \ ' + FStoredProc.StoredProcName
end;

procedure TdsdStoredProcItem.SetStoredProc(const Value: TdsdStoredProc);
begin
  if FStoredProc <> Value then begin
     if Assigned(Collection) and Assigned(Value) then
        Value.FreeNotification(TComponent(Collection.Owner));
     FStoredProc := Value;
  end;
end;

{ TOpenChoiceForm }

procedure TOpenChoiceForm.AfterChoice(Params: TdsdParams; Form: TForm);
begin
  // ����������� ��������� �� ������
  Self.GuiParams.AssignParams(Params);
  Form.Close
end;

{ TDataSetAction }

function TDSAction.Execute: boolean;
var i: integer;
begin
  if Assigned(FView.Owner)
     and (FView.Owner is TForm) then
        TForm(FView.Owner).ActiveControl := FView.Control;
  if Assigned(FView) then
     if Assigned(FView.DataController.DataSource) then
        if FView.DataController.DataSource.State in [dsInsert, dsEdit] then
           FView.DataController.DataSource.DataSet.Post;
  inherited;
  ChangeDSState;
  // ���� ����� ���� ������� ��� ������� ���������! :-)
  for I := 0 to FView.ColumnCount - 1 do
      if FView.Columns[i].Visible and FView.Columns[i].Editable then begin
         FView.Columns[i].Focused := true;
         break;
      end;
  // ����� �������
  if Assigned(FAction) then
     FAction.Execute;
end;

procedure TDSAction.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) then begin
    if AComponent = FView then
       FView := nil;
    if AComponent = FAction then
       FAction := nil;
  end;
end;

procedure TOpenChoiceForm.SetOwner(Owner: TObject);
begin

end;

{ TInsertRecord }

procedure TInsertRecord.ChangeDSState;
begin
  if Assigned(FView) then
     if Assigned(FView.DataController.DataSource) then begin
        if FView.DataController.DataSource.State = dsInactive then
           raise Exception.Create('DataSet ' + FView.DataController.DataSource.DataSet.Name + ' �� ������. ���������� �� ��������');
        if FView.DataController.DataSource.State = dsBrowse then
           FView.DataController.DataSource.DataSet.Append;
     end;
end;

{ TUpdateRecord }

procedure TUpdateRecord.ChangeDSState;
begin
  if Assigned(FView) then
     if Assigned(FView.DataController.DataSource) then begin
        if FView.DataController.DataSource.State = dsInactive then
           raise Exception.Create('DataSet ' + FView.DataController.DataSource.DataSet.Name + ' �� ������. �������������� �� ��������');
        if FView.DataController.DataSource.State = dsBrowse then
           FView.DataController.DataSource.DataSet.Edit;
     end;
end;

{ TCustomChangeStatus }

constructor TCustomChangeStatus.Create(AOwner: TComponent);
begin
  inherited;
  Status := mtUncomplete;
end;

{ TChangeGuidesStatus }

function TChangeGuidesStatus.Execute: boolean;
var OldKey: string;
begin
  if Assigned(FGuides) then begin
     OldKey := FGuides.Key;
     FGuides.Key := IntToStr(Integer(Status) + 1);
  end;
  try
    result := inherited Execute;
    if Assigned(FGuides) then begin
       FGuides.Key := IntToStr(Integer(Status) + 1);
       FGuides.TextValue := MovementStatus[Status];
    end;
  except
    FGuides.Key := OldKey;
    raise;
  end;
end;

procedure TChangeGuidesStatus.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if csDesigning in ComponentState then
    if (Operation = opRemove) and (AComponent = FGuides) then
       FGuides := nil;
end;

procedure TChangeGuidesStatus.OnChange(Sender: TObject);
begin
  Enabled := StrToInt(TdsdGuides(Sender).Key) <> (Integer(Status) + 1);
  if Assigned(FOnChange) then
     FOnChange(Sender)
end;

procedure TChangeGuidesStatus.SetGuides(const Value: TdsdGuides);
begin
  FGuides := Value;
  if Assigned(FGuides) then begin
     FOnChange := FGuides.OnChange;
     FGuides.OnChange := OnChange;
  end;
end;

end.

