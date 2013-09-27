unit ComponentAddOnTest;

interface

uses
  TestFramework;

type

  TComponentAddOnTest = class (TTestCase)
  private
  protected
  published
    procedure DefaultsKeyTest;
  end;

implementation

uses dsdDB, DBXJSON, dsdAddOn, Forms;

{ TComponentAddOnTest }

procedure TComponentAddOnTest.DefaultsKeyTest;
var DefaultKeyAddOn: TDefaultKeyAddOn;
    Param: TdsdParam;
    KeyParam: TdsdParam;
    FJSONObject: TJSONObject;
begin
  DefaultKeyAddOn := TDefaultKeyAddOn.Create(TForm.Create(nil));
  // ��������� ��������� �������� ����� � JSON
  DefaultKeyAddOn.Param.Value := 'miIncome';

  KeyParam := TdsdParam.Create(nil);
  KeyParam.Component := DefaultKeyAddOn;

  Check(KeyParam.Value = 'TForm;miIncome', '�������� KeyParam.Value = "' + KeyParam.Value + '" ������ "TForm;miIncome"');

  FJSONObject := TJSONObject.ParseJSONValue(DefaultKeyAddOn.JSONKey) as TJSONObject;
  if not Assigned(FJSONObject) then
     Check(false, 'FJSONObject = nil');
  if not Assigned(FJSONObject.Get('FormClass')) then
     Check(false, 'FJSONObject.Get(''FormClass'') = nil');

  Check(FJSONObject.Get('FormClass').JSONValue.Value = 'TForm', FJSONObject.Get('FormClass').JSONString.Value + '   ������ TForm');

end;

initialization
  TestFramework.RegisterTest('AddOn', TComponentAddOnTest.Suite);

end.
