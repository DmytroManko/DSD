unit dsdGuides;

interface

uses Classes, Controls, dsdDB, VCL.Menus, VCL.ActnList, Forms;

type

  TAccessControl = class(Controls.TWinControl)
  public
    property OnDblClick;
  end;

  TActionItem = class(TCollectionItem)
  private
    FAction: TCustomAction;
    procedure SetAction(const Value: TCustomAction);
  protected
    function GetDisplayName: string; override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Action: TCustomAction read FAction write SetAction;
  end;

  TShortCutActionItem = class(TActionItem)
  private
    FSecondaryShortCuts: TShortCutList;
    FShortCut: TShortCut;
    procedure SetShortCut(const Value: TShortCut);
    function GetSecondaryShortCuts: TShortCutList;
    procedure SetSecondaryShortCuts(const Value: TShortCutList);
    function IsSecondaryShortCutsStored: Boolean;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property ShortCut: TShortCut read FShortCut write SetShortCut default 0;
    property SecondaryShortCuts: TShortCutList read GetSecondaryShortCuts
       write SetSecondaryShortCuts stored IsSecondaryShortCutsStored;
  end;

  TActionItemList = class(TOwnedCollection)
  private
    function GetItem(Index: Integer): TActionItem;
    procedure SetItem(Index: Integer; const Value: TActionItem);
  public
    function Add: TActionItem;
    property Items[Index: Integer]: TActionItem read GetItem write SetItem; default;
  end;

  // ���������������� ������ ����� �������� ����� ��� ������ �� �����������
  IChoiceCaller = interface
    ['{879D5206-590F-43CB-B992-26B096342EC2}']
    procedure SetOwner(Owner: TObject);
    procedure AfterChoice(Params: TdsdParams; Form: TForm);
    property Owner: TObject write SetOwner;
  end;

  TCustomGuides = class(TComponent, IChoiceCaller)
  private
    FParams: TdsdParams;
    FKey: String;
    FParentId: String;
    FTextValue: String;
    FPositionDataSet: string;
    FParentDataSet: string;
    FFormName: string;
    FLookupControl: TWinControl;
    FKeyField: string;
    FOnChange: TNotifyEvent;
    FChoiceAction: TObject;
    function GetKey: String;
    function GetTextValue: String;
    procedure SetKey(const Value: String);
    procedure SetTextValue(const Value: String);
    procedure SetLookupControl(const Value: TWinControl); virtual;
    procedure OnDblClick(Sender: TObject);
    procedure OpenGuides;
    procedure OnButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure SetOwner(Owner: TObject);
  protected
    // ��� �����
    property FormName: string read FFormName write FFormName;
    // ��� ��������������� �� ParentId
    property ParentDataSet: string read FParentDataSet write FParentDataSet;
    // ��� ��������������� �� ��
    property PositionDataSet: string read FPositionDataSet write FPositionDataSet;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    // ID ������
    property Key: String read GetKey write SetKey;
    // ��������� ��������
    property TextValue: String read GetTextValue write SetTextValue;
    // �������� ��� ����������� ������������
    property ParentId: String read FParentId write FParentId;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  protected
    // �������� ��������� ����� ������ �������� �� �����������
    procedure AfterChoice(Params: TdsdParams; Form: TForm); virtual; abstract;
    // ������, ���������� ����� ������ �� �����������. �������� ��� �������� � ������ ��������
    property Params: TdsdParams read FParams write FParams;
  published
    // �������� ����
    property KeyField: string read FKeyField write FKeyField;
    // ���������� ���������
    property LookupControl: TWinControl read FLookupControl write SetLookupControl;
  end;

  // ��������� �������� �� �������������. �������� �������� �� ��������� ���������� ��� ����
  TdsdGuides = class(TCustomGuides)
  private
    FOnAfterChoice: TNotifyEvent;
    FPopupMenu: TPopupMenu;
    procedure OnPopupClick(Sender: TObject);
    procedure SetLookupControl(const Value: TWinControl); override;
  protected
    // �������� ��������� ����� ������ �������� �� �����������
    procedure AfterChoice(Params: TdsdParams; Form: TForm); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Key;
    // ��������� ��������
    property TextValue;
    property FormName;
    // �������� ��� ����������� ������������
    property ParentId;
    // ��� ��������������� �� ��
    property PositionDataSet;
    // ��� ��������������� �� ParentId
    property ParentDataSet;
    property Params;
    property OnAfterChoice: TNotifyEvent read FOnAfterChoice write FOnAfterChoice;
  end;

  TChangeStatus = class(TCustomGuides)
  private
    FProcedure: TdsdStoredProc;
    FParam: TdsdParam;
    function GetStoredProcName: string;
    procedure SetStoredProcName(const Value: string);
  protected
    // �������� ��������� ����� ������ �������� �� �����������
    procedure AfterChoice(Params: TdsdParams; Form: TForm); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property IdParam: TdsdParam read FParam write FParam;
    property StoredProcName: string read GetStoredProcName write SetStoredProcName;
  end;

  TGuidesListItem = class(TCollectionItem)
  private
    FGuides: TdsdGuides;
    procedure SetGuides(const Value: TdsdGuides);
  protected
    function GetDisplayName: string; override;
  published
    property Guides: TdsdGuides read FGuides write SetGuides;
  end;

  TGuidesFiller = class;

  TGuidesList = class(TOwnedCollection)
  private
    function GetItem(Index: Integer): TGuidesListItem;
    procedure SetItem(Index: Integer; const Value: TGuidesListItem);
  public
    function Add: TGuidesListItem;
    property Items[Index: Integer]: TGuidesListItem read GetItem write SetItem; default;
  end;

  // �������� ���������� ������������ ��� �������� ���������
  TGuidesFiller = class(TComponent)
  private
    FGuidesList: TGuidesList;
    FParam: TdsdParam;
    FOnAfterShow: TNotifyEvent;
    FActionItemList: TActionItemList;
    procedure OnAfterShow(Sender: TObject);
    procedure OnAfterChoice(Sender: TObject);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property IdParam: TdsdParam read FParam write FParam;
    property GuidesList: TGuidesList read FGuidesList write FGuidesList;
    property ActionItemList: TActionItemList read FActionItemList write FActionItemList;
  end;

  procedure Register;

implementation

uses cxDBLookupComboBox, cxButtonEdit, Variants, ParentForm, FormStorage, DB,
     SysUtils, Dialogs, dsdAction, cxDBEdit;

procedure Register;
begin
   RegisterComponents('DSDComponent', [TdsdGuides]);
   RegisterComponents('DSDComponent', [TGuidesFiller]);
   RegisterComponents('DSDComponent', [TChangeStatus]);
end;

{ TdsdGuides }

procedure TdsdGuides.AfterChoice(Params: TdsdParams; Form: TForm);
begin
  // ����������� ��������� �� ������
  Self.Params.AssignParams(Params);
  if Assigned(FOnAfterChoice) then
     // ����� ����� �������
     FOnAfterChoice(Form)
  else
    // ���� ����� �� �������, �� ���������
    if Form.Visible then
       Form.Close;
end;

constructor TdsdGuides.Create(AOwner: TComponent);
var MenuItem: TMenuItem;
begin
  inherited;
  FParams := TdsdParams.Create(Self, TdsdParam);
  FPopupMenu := TPopupMenu.Create(nil);
  MenuItem := TMenuItem.Create(FPopupMenu);
  with MenuItem do begin
    Caption := '�������� ��������';
    ShortCut := 32776;  // Alt + BkSp
    OnClick := OnPopupClick;
  end;
  FPopupMenu.Items.Add(MenuItem);
end;

destructor TdsdGuides.Destroy;
begin
  FreeAndNil(FParams);
  FreeAndNil(FPopupMenu);
  inherited;
end;

procedure TdsdGuides.Notification(AComponent: TComponent;
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
    end;
end;

procedure TdsdGuides.OnPopupClick(Sender: TObject);
begin
  Key := '0';
  TextValue := '';
end;

procedure TdsdGuides.SetLookupControl(const Value: TWinControl);
begin
  inherited;
  if FLookupControl is TcxButtonEdit then
     (LookupControl as TcxButtonEdit).PopupMenu := FPopupMenu;
  if FLookupControl is TcxLookupComboBox then
     (LookupControl as TcxLookupComboBox).PopupMenu := FPopupMenu;
end;

{ TGuidesListItem }

function TGuidesListItem.GetDisplayName: string;
begin
  if Assigned(Guides) then
     result := Guides.Name
  else
     result := inherited;
end;

procedure TGuidesListItem.SetGuides(const Value: TdsdGuides);
begin
  if Assigned(Value) then begin
    if Assigned(Collection) then
        Value.FreeNotification(TComponent(Collection.Owner));
    if Collection.Owner is TGuidesFiller then
       Value.OnAfterChoice := TGuidesFiller(Self.Collection.Owner).OnAfterChoice;
  end;
  FGuides := Value;
end;

{ TGuidesList }

function TGuidesList.Add: TGuidesListItem;
begin
  result := TGuidesListItem(inherited Add);
end;

function TGuidesList.GetItem(Index: Integer): TGuidesListItem;
begin
  Result := TGuidesListItem(inherited GetItem(Index));
end;

procedure TGuidesList.SetItem(Index: Integer; const Value: TGuidesListItem);
begin
  inherited SetItem(Index, Value);
end;

{ TGuidesFiller }

constructor TGuidesFiller.Create(AOwner: TComponent);
begin
  inherited;
  GuidesList := TGuidesList.Create(Self, TGuidesListItem);
  FParam := TdsdParam.Create(nil);
  FActionItemList := TActionItemList.Create(Self, TActionItem);
  if AOwner is TCustomForm then begin
     FOnAfterShow := TParentForm(AOwner).OnAfterShow;
     TParentForm(AOwner).OnAfterShow := Self.OnAfterShow;
  end;
end;

destructor TGuidesFiller.Destroy;
begin
  FreeAndNil(FGuidesList);
  FreeAndNil(FParam);
  FreeAndNil(FActionItemList);
  if Owner is TCustomForm then
     TParentForm(Owner).OnAfterShow := FOnAfterShow;
  inherited;
end;

procedure TGuidesFiller.Notification(AComponent: TComponent;
  Operation: TOperation);
var i: integer;
begin
  inherited;
  if csDesigning in ComponentState then
    if (Operation = opRemove) then begin
      if (AComponent is TdsdGuides) and Assigned(GuidesList) then
         for i := 0 to GuidesList.Count - 1 do
            if GuidesList[i].Guides = AComponent then
               GuidesList[i].Guides := nil;
      if (AComponent is TCustomAction) and Assigned(ActionItemList) then
         for i := 0 to ActionItemList.Count - 1 do
            if ActionItemList[i].Action = AComponent then
               ActionItemList[i].Action := nil;
    end;
end;

procedure TGuidesFiller.OnAfterChoice(Sender: TObject);
var i: integer;
begin
  if Assigned(FParam) then
     if (FParam.Value = 0) or VarIsNull(FParam.Value) then begin
        for I := 0 to GuidesList.Count - 1 do
            if assigned(GuidesList[i].Guides) then
              if (GuidesList[i].Guides.Key = '0') or ((GuidesList[i].Guides.Key = '')) then begin
                 // ������� ����� �����������
                 if Sender is TForm then
                    TForm(Sender).Close;
                 GuidesList[i].Guides.OpenGuides;
                 exit;
              end;
       // ������ �� ���� ������������ � ��� ���������
       // ��������� ��� Action
       for I := 0 to FActionItemList.Count - 1 do
          if Assigned(FActionItemList[i].Action) then
               if FActionItemList[i].Action.Enabled then
                  FActionItemList[i].Action.Execute;
     end;
   // ���� �� �������� ������!!! ������� ����� �����������
   if Sender is TForm then
      TForm(Sender).Close;
end;

procedure TGuidesFiller.OnAfterShow(Sender: TObject);
begin
  if Assigned(FOnAfterShow) then
     FOnAfterShow(Sender);
  OnAfterChoice(Self);
end;

{ TActionItem }

procedure TActionItem.SetAction(const Value: TCustomAction);
begin
  if FAction <> Value then begin
     if Assigned(Collection) and Assigned(Value) then
        Value.FreeNotification(TComponent(Collection.Owner));
     FAction := Value;
  end;
end;

procedure TActionItem.Assign(Source: TPersistent);
begin
  if Source is TActionItem then
     Self.Action := TActionItem(Source).Action
  else
    inherited Assign(Source);
end;

function TActionItem.GetDisplayName: string;
begin
  if Assigned(Action) then
     result := Action.Name
  else
     result := inherited;
end;

procedure TShortCutActionItem.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  with TShortCutActionItem(Source) do begin
    Self.ShortCut := ShortCut;
    Self.SecondaryShortCuts.Assign(SecondaryShortCuts);
  end;
end;

function TShortCutActionItem.GetSecondaryShortCuts: TShortCutList;
begin
  if FSecondaryShortCuts = nil then
    FSecondaryShortCuts := TShortCutList.Create;
  Result := FSecondaryShortCuts;
end;

procedure TShortCutActionItem.SetSecondaryShortCuts(const Value: TShortCutList);
begin
  if FSecondaryShortCuts = nil then
    FSecondaryShortCuts := TShortCutList.Create;
  FSecondaryShortCuts.Assign(Value);
end;

function TShortCutActionItem.IsSecondaryShortCutsStored: Boolean;
begin
  Result := Assigned(FSecondaryShortCuts) and (FSecondaryShortCuts.Count > 0);
end;

procedure TShortCutActionItem.SetShortCut(const Value: TShortCut);
begin
  FShortCut := Value;
end;

{ TActionItemList }

function TActionItemList.Add: TActionItem;
begin
  result := TActionItem(inherited Add);
end;

function TActionItemList.GetItem(Index: Integer): TActionItem;
begin
  Result := TActionItem(inherited GetItem(Index));
end;

procedure TActionItemList.SetItem(Index: Integer; const Value: TActionItem);
begin
  inherited SetItem(Index, Value);
end;

{ TCustomGuides }

procedure TCustomGuides.OnDblClick(Sender: TObject);
begin
  OpenGuides;
end;

procedure TCustomGuides.SetLookupControl(const Value: TWinControl);
begin
  FLookupControl := Value;
  TAccessControl(FLookupControl).OnDblClick := OnDblClick;
  if FLookupControl is TcxButtonEdit then
     (LookupControl as TcxButtonEdit).Properties.OnButtonClick := OnButtonClick;
  if FLookupControl is TcxDBButtonEdit then
     (LookupControl as TcxDBButtonEdit).Properties.OnButtonClick := OnButtonClick;
end;

procedure TCustomGuides.SetOwner(Owner: TObject);
begin
  FChoiceAction := Owner;
end;

procedure TCustomGuides.OnButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  if Sender is TcxButtonEdit then
     if not Assigned(TcxButtonEdit(Sender).Properties.Buttons[AButtonIndex].Action) then
        OnDblClick(Sender);
  if Sender is TcxDBButtonEdit then
     if not Assigned(TcxDBButtonEdit(Sender).Properties.Buttons[AButtonIndex].Action) then
        OnDblClick(Sender);
end;

procedure TCustomGuides.OpenGuides;
var
  Form: TParentForm;
  DataSet: TDataSet;
begin
  if FormName = ''  then exit;
  Form := TdsdFormStorageFactory.GetStorage.Load(FormName);
  // ������� �����
  Form.Execute(Self, Params);
  // ������������������ �� ParentData ���� �� ����
  if ParentDataSet <> '' then begin
     DataSet := Form.FindComponent(ParentDataSet) as TDataSet;
     if not Assigned(DataSet) then
        raise Exception.Create('�� ��������� ����������� �������� ParentDataSet ��� ����� ' + FormName);
     if ParentId <> '' then
        DataSet.Locate('Id', ParentId, []);
  end;
  if not (Form.FindComponent(PositionDataSet) is TDataSet) then
     raise Exception.Create('��������� ' + Name + '. ����� ' + PositionDataSet + ' �� �������� TDataSet');
  // ������������������ �� ���� ����
  DataSet := Form.FindComponent(PositionDataSet) as TDataSet;
  if not Assigned(DataSet) then
     raise Exception.Create('�� ��������� ����������� �������� PositionDataSet ��� ����� ' + FormName);
  // �������� �����
  Form.Show;
  if Key <> '' then
     DataSet.Locate(KeyField, Key, []);
end;

constructor TCustomGuides.Create(AOwner: TComponent);
begin
  inherited;
  PositionDataSet := 'ClientDataSet';
  KeyField := 'Id';
end;

destructor TCustomGuides.Destroy;
begin
  // ���������� ������ �� ���� � ������ ����������!
  if Assigned(FChoiceAction) then
     if FChoiceAction is TdsdChoiceGuides then
        TdsdChoiceGuides(FChoiceAction).ChoiceCaller := nil;
  inherited;
end;

function TCustomGuides.GetKey: String;
begin
  if Assigned(LookupControl) then begin
     if LookupControl is TcxLookupComboBox then begin
        // �������� ������ �� �������
        if VarisNull((LookupControl as TcxLookupComboBox).EditValue) then
           Result := '0'
        else
           Result := (LookupControl as TcxLookupComboBox).EditValue;
     end
     else
       Result := FKey;
  end;
end;

function TCustomGuides.GetTextValue: String;
begin
  result := FTextValue
end;

procedure TCustomGuides.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if csDesigning in ComponentState then
    if (Operation = opRemove) then begin
      if (AComponent = FLookupControl) then
         FLookupControl := nil;
    end;
end;

procedure TCustomGuides.SetKey(const Value: String);
begin
  if Value = '' then
     FKey := '0'
  else
     FKey := Value;
  if Assigned(FOnChange) then
     FOnChange(Self);
  if Assigned(LookupControl) then begin
     if LookupControl is TcxLookupComboBox then
        (LookupControl as TcxLookupComboBox).EditValue := FKey
  end;
end;

procedure TCustomGuides.SetTextValue(const Value: String);
begin
  FTextValue := Value;
  if Assigned(LookupControl) then begin
     if LookupControl is TcxLookupComboBox then
        (LookupControl as TcxLookupComboBox).Text := Value;
     if LookupControl is TcxButtonEdit then
        (LookupControl as TcxButtonEdit).Text := Value;
     if LookupControl is TcxDBButtonEdit then
        (LookupControl as TcxDBButtonEdit).Text := Value;
  end;
end;

{ TChangeStatus }

procedure TChangeStatus.AfterChoice(Params: TdsdParams; Form: TForm);
begin
  // ��� ����� ��� �������� ��������� � ���� ����������,
  FProcedure.ParamByName('inMovementId').Value := IdParam.Value;
  FProcedure.ParamByName('inStatusCode').Value := Params.ParamByName('Key').Value;
  FProcedure.Execute;
  // �� ������ ������
  Key := Params.ParamByName('Key').Value;
  TextValue := Params.ParamByName('TextValue').Value;
end;

constructor TChangeStatus.Create(AOwner: TComponent);
begin
  inherited;
  FFormName := 'TStatusForm';
  FParam := TdsdParam.Create(nil);
  FProcedure := TdsdStoredProc.Create(Self);
  FProcedure.OutputType := otResult;
  FProcedure.Params.AddParam('inMovementId', ftInteger, ptInput, 0);
  FProcedure.Params.AddParam('inStatusCode', ftInteger, ptInput, 0);
end;

function TChangeStatus.GetStoredProcName: string;
begin
  result := FProcedure.StoredProcName;
end;

procedure TChangeStatus.SetStoredProcName(const Value: string);
begin
  FProcedure.StoredProcName := Value;
end;

initialization
  RegisterClass(TdsdGuides);

end.


