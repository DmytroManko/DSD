unit dsdGuides;

interface

uses Classes, Controls, dsdDB, VCL.Menus;

type

  TAccessControl = class(Controls.TWinControl)
  public
    property OnDblClick;
  end;

  // ��������� �������� �� �������������. �������� �������� �� ��������� ���������� ��� ����
  TdsdGuides = class(TComponent)
  private
    FFormName: string;
    FLookupControl: TWinControl;
    FKey: String;
    FTextValue: String;
    FPositionDataSet: string;
    FParentDataSet: string;
    FParentId: String;
    FParams: TdsdParams;
    FPopupMenu: TPopupMenu;
    function GetKey: String;
    function GetTextValue: String;
    procedure SetKey(const Value: String);
    procedure SetTextValue(const Value: String);
    procedure SetLookupControl(const Value: TWinControl);
    procedure OpenGuides;
    procedure OnDblClick(Sender: TObject);
    procedure OnPopupClick(Sender: TObject);
    procedure OnButtonClick(Sender: TObject; AButtonIndex: Integer);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    // �������� ��������� ����� ������ �������� �� �����������
    procedure AfterChoice(AKey, ATextValue, AParentId: string);
  published
    // ID ������
    property Key: String read GetKey write SetKey;
    // ��������� ��������
    property TextValue: String read GetTextValue write SetTextValue;
    // �������� ��� ����������� ������������
    property ParentId: String read FParentId write FParentId;
    property LookupControl: TWinControl read FLookupControl write SetLookupControl;
    property FormName: string read FFormName write FFormName;
    // ��� ��������������� �� ��
    property PositionDataSet: string read FPositionDataSet write FPositionDataSet;
    // ��� ��������������� �� ParentId
    property ParentDataSet: string read FParentDataSet write FParentDataSet;
    // ������, ���������� ����� ������ �� �����������. �������� ��� �������� � ������ ��������
    property Params: TdsdParams read FParams write FParams;
  end;

  procedure Register;

implementation

uses cxDBLookupComboBox, cxButtonEdit, Variants, ParentForm, FormStorage, DB,
     SysUtils;

procedure Register;
begin
   RegisterComponents('DSDComponent', [TdsdGuides]);
end;

{ TdsdGuides }

procedure TdsdGuides.AfterChoice(AKey, ATextValue, AParentId: string);
begin
  // �������� ��������� �� ���� ����. ���
  Key := AKey;
  TextValue := ATextValue;
  ParentId := AParentId;
end;

constructor TdsdGuides.Create(AOwner: TComponent);
var MenuItem: TMenuItem;
begin
  inherited;
  FParams := TdsdParams.Create(TParam);
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
  FParams.Free;
  FPopupMenu.Free;
  inherited;
end;

function TdsdGuides.GetKey: String;
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

function TdsdGuides.GetTextValue: String;
begin
  result := FTextValue
end;

procedure TdsdGuides.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FLookupControl) then
     FLookupControl := nil;
end;

procedure TdsdGuides.OnButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  OnDblClick(Sender);
end;

procedure TdsdGuides.OnDblClick(Sender: TObject);
begin
  OpenGuides;
end;

procedure TdsdGuides.OnPopupClick(Sender: TObject);
begin
  Key := '0';
  TextValue := '';
end;

procedure TdsdGuides.OpenGuides;
var
  Form: TParentForm;
  DataSet: TDataSet;
begin
  Form := TdsdFormStorageFactory.GetStorage.Load(FormName);
  // ������� �����
  Form.Execute(Self, nil);
  // ������������������ �� ParentData ���� �� ����
  if ParentDataSet <> '' then begin
     DataSet := Form.FindComponent(ParentDataSet) as TDataSet;
     if not Assigned(DataSet) then
        raise Exception.Create('�� ��������� ����������� �������� ParentDataSet ��� ����� ' + FormName);
     if ParentId <> '' then
        DataSet.Locate('Id', ParentId, []);
  end;
  // ������������������ �� ���� ����
  DataSet := Form.FindComponent(PositionDataSet) as TDataSet;
  if not Assigned(DataSet) then
     raise Exception.Create('�� ��������� ����������� �������� PositionDataSet ��� ����� ' + FormName);
  Form.Show;
  if Key <> '' then
     DataSet.Locate('Id', Key, []);
end;

procedure TdsdGuides.SetKey(const Value: String);
begin
  if Value = '' then
     FKey := '0'
  else
     FKey := Value;
  if Assigned(LookupControl) then begin
     if LookupControl is TcxLookupComboBox then
        (LookupControl as TcxLookupComboBox).EditValue := FKey
  end;
end;

procedure TdsdGuides.SetLookupControl(const Value: TWinControl);
begin
  FLookupControl := Value;
  TAccessControl(FLookupControl).OnDblClick := OnDblClick;
  if FLookupControl is TcxButtonEdit then begin
     (LookupControl as TcxButtonEdit).Properties.OnButtonClick := OnButtonClick;
     (LookupControl as TcxButtonEdit).PopupMenu := FPopupMenu;
  end;
  if FLookupControl is TcxLookupComboBox then
     (LookupControl as TcxButtonEdit).PopupMenu := FPopupMenu;
end;

procedure TdsdGuides.SetTextValue(const Value: String);
begin
  FTextValue := Value;
  if Assigned(LookupControl) then begin
     if LookupControl is TcxLookupComboBox then
        (LookupControl as TcxLookupComboBox).Text := Value;
     if LookupControl is TcxButtonEdit then
        (LookupControl as TcxButtonEdit).Text := Value;
  end;
end;

initialization
  RegisterClass(TdsdGuides);

end.


