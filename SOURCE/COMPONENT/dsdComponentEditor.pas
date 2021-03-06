unit dsdComponentEditor;

interface

uses Classes, DesignEditors, DesignIntf, dsdAddOn;

type

  // �������� ��������� ��������� ���������� ������ ������������
  TdsdParamComponentProperty = class(TComponentProperty)
  public
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  // �������� ��������� ��������� ���������� ������ ������������
  TdsdGuidesComponentProperty = class(TComponentProperty)
  public
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  // �������� ��������� ��������� ��������� ����������
  // ��������� �������� ������� � ��������� TDataSet, TdsdFormParams, TdsdGuides

  TComponentItemTextProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  TDataTypeProperty = class(TEnumProperty)
  public
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  procedure Register;

implementation

uses dsdDB, TypInfo, Db, dsdGuides, cxTextEdit, cxCurrencyEdit, cxCheckBox,
     cxCalendar, cxButtonEdit, dsdAction, ChoicePeriod, ParentForm, Document, Defaults;

procedure Register;
begin
   RegisterCustomModule(TParentForm, TCustomModule);
   RegisterPropertyEditor(TypeInfo(String), TdsdParam, 'ComponentItem', TComponentItemTextProperty);
   RegisterPropertyEditor(TypeInfo(TFieldType), TdsdParam, 'DataType', TDataTypeProperty);
   RegisterPropertyEditor(TypeInfo(TComponent), TdsdParam, 'Component', TdsdParamComponentProperty);
   RegisterPropertyEditor(TypeInfo(TComponent), TComponentListItem, 'Component', TdsdParamComponentProperty);
   RegisterPropertyEditor(TypeInfo(boolean),TExecuteDialog,'isShowModal',nil);
end;


{ TdsdParamComponentProperty }

procedure TdsdParamComponentProperty.GetValues(Proc: TGetStrProc);
begin
  // ���������� ������ �� ����������, � �������� ����� �������� TdsdParam
  Designer.GetComponentNames(GetTypeData(TypeInfo(TcxTextEdit)), Proc);
  Designer.GetComponentNames(GetTypeData(TypeInfo(TcxDateEdit)), Proc);
  Designer.GetComponentNames(GetTypeData(TypeInfo(TcxCurrencyEdit)), Proc);
  Designer.GetComponentNames(GetTypeData(TypeInfo(TDataSet)), Proc);
  Designer.GetComponentNames(GetTypeData(TypeInfo(TdsdFormParams)), Proc);
  Designer.GetComponentNames(GetTypeData(TypeInfo(TdsdGuides)), Proc);
  Designer.GetComponentNames(GetTypeData(TypeInfo(TChangeStatus)), Proc);
  Designer.GetComponentNames(GetTypeData(TypeInfo(TPeriodChoice)), Proc);
  Designer.GetComponentNames(GetTypeData(TypeInfo(TcxCheckBox)), Proc);
  Designer.GetComponentNames(GetTypeData(TypeInfo(TBooleanStoredProcAction)), Proc);
  Designer.GetComponentNames(GetTypeData(TypeInfo(TDocument)), Proc);
  Designer.GetComponentNames(GetTypeData(TypeInfo(TDefaultKey)), Proc);
  // � ���� �����. ���������� ������������ ��� ������
  Designer.GetComponentNames(GetTypeData(TypeInfo(TCrossDBViewAddOn)), Proc);
end;

{ TComponentItemTextProperty }

function TComponentItemTextProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paReadOnly];
  if Assigned(GetComponent(0)) then
    with TdsdParam(GetComponent(0)) do
         if Component <> nil then
            if (Component is TDataSet) or (Component is TdsdFormParams)
               or (Component is TDocument) or (Component is TdsdGuides)
               or (Component is TDefaultKey) or (Component is TCrossDBViewAddOn) then
               Result := Result + [paValueList] - [paReadOnly];
end;

procedure TComponentItemTextProperty.GetValues(Proc: TGetStrProc);
var i: Integer;
begin
  inherited;
  if Assigned(GetComponent(0)) then
    with TdsdParam(GetComponent(0)) do
         if Component <> nil then begin
            if (Component is TDataSet) then;
            if (Component is TdsdFormParams) then
                with Component as TdsdFormParams do
                  for i := 0 to Params.Count - 1 do
                    Proc(Params[i].Name);
            if (Component is TCustomGuides) then
            begin
              Proc('Key');
              Proc('TextValue');
              Proc('ParentId');
            end;
            if (Component is TDocument) then
            begin
              Proc('Name');
              Proc('Data');
            end;
            if (Component is TDefaultKey) then
            begin
              Proc('Key');
              Proc('JSONKey');
            end;
         end
end;


{ TdsdGuidesComponentProperty }

procedure TdsdGuidesComponentProperty.GetValues(Proc: TGetStrProc);
begin
  inherited;
  // ���������� ������ �� ����������, � �������� ����� �������� TdsdGuides
  Designer.GetComponentNames(GetTypeData(TypeInfo(TcxButtonEdit)), Proc);
  Designer.GetComponentNames(GetTypeData(TypeInfo(TcxDateEdit)), Proc);
end;

{ TDataTypeProperty }

procedure TDataTypeProperty.GetValues(Proc: TGetStrProc);
begin
 // inherited;
  Proc('ftBoolean');
  Proc('ftDateTime');
  Proc('ftFloat');
  Proc('ftInteger');
  Proc('ftString');
end;

end.
