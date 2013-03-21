unit FarmacyTestUnit;

interface

uses TestFramework, Db;

type
  TFarmacyTest = class (TTestCase)
  private
    function InsertUpdate_Movement_FoundationCash
          (ioId: Integer; inOperDate: TDateTime; inCashId: integer; inSumm: double): string;
    procedure Update_Movement_FoundationCash_Complete(inMovementId: Integer);
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

uses dsdDataSetWrapperUnit, UtilType, DBClient, SysUtils, DataBaseObjectTestUnit;

procedure TFarmacyTest.CashFoundationTest;
var
  MovementId: String;
  CashId: Integer;
begin
  with TCurrencyTest.Create do
  try
    CashId := GetDefault
  finally
    Free;
  end;
  // ������� �������� "������� � ������������"
  MovementId := InsertUpdate_Movement_FoundationCash(0, Date, CashId, 123.45);
  // �������� ��������
  Update_Movement_FoundationCash_Complete(StrToInt(MovementId));
  // ��������� ������������ �������
end;

function TFarmacyTest.InsertUpdate_Movement_FoundationCash(ioId: Integer;
  inOperDate: TDateTime; inCashId: integer; inSumm: double): string;
begin
  with TdsdStoredProc.Create(nil) do
  try
    StoredProcName := 'gpInsertUpdate_Movement_FoundationCash';
    OutputType := otResult;
    Params.AddParam('ioId', ftInteger, ptInputOutput, 0);
    Params.AddParam('inOperDate', ftDateTime, ptInput, inOperDate);
    Params.AddParam('inCashId', ftInteger, ptInput, inCashId);
    Params.AddParam('inSumm', ftFloat, ptInput, inSumm);
    Execute;
    result := ParamByName('ioid').Value
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

procedure TFarmacyTest.Update_Movement_FoundationCash_Complete(
  inMovementId: Integer);
begin
  with TdsdStoredProc.Create(nil) do
  try
    StoredProcName := 'gpUpdate_Movement_FoundationCash_Complete';
    Params.AddParam('inMovementId', ftInteger, ptInputOutput, inMovementId);
    OutputType := otResult;
    Execute;
  finally
    Free;
  end;
end;

initialization
  TestFramework.RegisterTest('FarmacyTest', TFarmacyTest.Suite);

end.
