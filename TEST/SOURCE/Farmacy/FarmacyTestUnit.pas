unit FarmacyTestUnit;

interface

uses TestFramework;

type
  TFarmacyTest = class (TTestCase)
  private
    function InsertCash(CashName: string): string;
  protected
    // �������������� ������ ��� ������������
    procedure SetUp; override;
    // ���������� ������ ��� ������������
    procedure TearDown; override;
  published
    procedure CashFoundationTest;
  end;


implementation

{ TFarmacyTest }

uses dsdDataSetWrapperUnit, Db, UtilType;

procedure TFarmacyTest.CashFoundationTest;
begin
  // ��������� �����
  // ������� �������� "������� � ������������"
  // �������� ��������
  // ��������� ������������ �������

end;

function TFarmacyTest.InsertCash(CashName: string): string;
begin
  with TdsdStoredProc.Create(nil) do
  try
    StoredProcName := 'gpInsertUpdate_Cash';
    OutputType := otResult;
    Params.AddParam('Id', ftInteger, ptInputOutput, 0);
    Params.AddParam('Name', ftString, ptInput, '������� �����');
    Execute;
    result := ParamByName('Id').Value
  finally
    Free;
  end;
end;

procedure TFarmacyTest.SetUp;
begin
  inherited;

end;

procedure TFarmacyTest.TearDown;
begin
  inherited;

end;

initialization
  TestFramework.RegisterTest('TFarmacyTest', TFarmacyTest.Suite);


end.
