unit dsdAction;

interface

uses VCL.ActnList, Forms, Classes, ParentForm, dsdDB, DB, DBClient, UtilConst,
     cxGrid, dsdGuides, ImgList, cxPC;

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
    procedure SetTabSheet(const Value: TcxTabSheet);
    procedure OnPageChanging(Sender: TObject; NewPage: TcxTabSheet; var AllowChange: Boolean);
  protected
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
  public
    constructor Create(AOwner: TComponent); override;
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

  TdsdChangeMovementStatus = class (TdsdCustomDataSetAction)
  private
    FStatus: TdsdMovementStatus;
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
    property Status: TdsdMovementStatus read FStatus write FStatus;
  end;

  TdsdUpdateErased = class;

  TdsdUpdateErased = class(TdsdCustomDataSetAction, IDataSetAction)
  private
    FActionDataLink: TDataSetDataLink;
    FisSetErased: boolean;
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
    property isSetErased: boolean read FisSetErased write SetisSetErased default true;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  end;

  TdsdOpenForm = class(TdsdCustomAction, IFormAction)
  private
    FParams: TdsdParams;
    FFormName: string;
    FisShowModal: boolean;
  protected
    procedure BeforeExecute(Form: TParentForm); virtual;
    procedure OnFormClose(Params: TdsdParams); virtual;
    function ShowForm: TParentForm;
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
    FGuides: TdsdGuides;
    function GetDataSource: TDataSource;
    procedure SetDataSource(const Value: TDataSource);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DataSetChanged;
    procedure UpdateData;
  public
    function Execute: boolean; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Guides: TdsdGuides read FGuides write FGuides;
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
     Vcl.Controls, Menus, cxGridExportLink, ShellApi, frxClass, frxDesgn, messages;

procedure Register;
begin
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
  RegisterActions('DSDLib', [TBooleanStoredProcAction], TBooleanStoredProcAction);
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

function TdsdOpenForm.ShowForm: TParentForm;
begin
  Result := TdsdFormStorageFactory.GetStorage.Load(FormName);
  BeforeExecute(Result);
  if Result.Execute(Self, FParams) then
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
  if DataSource.State = dsEdit then
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
              Enabled := not DataSource.DataSet.FieldByName('isErased').AsBoolean
           else
              Enabled := DataSource.DataSet.FieldByName('isErased').AsBoolean
end;

destructor TdsdUpdateErased.Destroy;
begin
  FActionDataLink.Free;
  inherited;
end;

function TdsdUpdateErased.Execute: boolean;
begin
  result := inherited Execute;
  if result and Assigned(DataSource) and Assigned(DataSource.DataSet) then begin
     DataSource.DataSet.Edit;
     DataSource.DataSet.FieldByName('isErased').AsBoolean := not DataSource.DataSet.FieldByName('isErased').AsBoolean;
     DataSource.DataSet.Post;
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
  if Assigned(DataSource) and Assigned(FGuides) then
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
     Guides.AfterChoice(FParams)
  else
     raise Exception.Create('�� ���������� ��������� �������� �������� ��� ������ �� �����������');
  TForm(Owner).Close;
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
  Status := mtUncomplete;
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
begin
  result := inherited Execute;
  if result and Assigned(DataSource) and Assigned(DataSource.DataSet) then begin
     DataSource.DataSet.Edit;
     DataSource.DataSet.FieldByName('StatusCode').AsInteger := Integer(Status) + 1;
     DataSource.DataSet.Post;
  end;
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
  Execute;
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
begin
  inherited;
  with TfrxReport.Create(nil) do begin
    LoadFromStream(TdsdFormStorageFactory.GetStorage.LoadReport(ReportName));
    for i := 0 to Params.Count - 1 do
        Variables[Params[i].Name] := chr(39) + Params[i].AsString + chr(39);
    if ShiftDown then
       DesignReport
    else begin
       PrepareReport;
       ShowReport;
    end;
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

end.
