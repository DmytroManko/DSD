unit CashOperationTest;

interface

uses dbTest, dbMovementTest;

type
  TCashOperationTest = class (TdbMovementTestNew)
  published
    procedure ProcedureLoad; override;
    procedure Test; override;
  end;

  TCashOperation = class(TMovementTest)
  private
    function InsertDefault: integer; override;
  public
    function InsertUpdateCashOperation(const Id: integer; InvNumber: String;
        OperDate: TDateTime; Amount: Double; Comment: string;
        CashId, ObjectId, ContractId, InfoMoneyId, UnitId: integer): integer;
    constructor Create; override;
  end;

implementation

uses UtilConst, JuridicalTest, dbObjectTest, SysUtils, Db, TestFramework,
     DBClient, dsdDB, CashTest;

{ TIncomeCashJuridical }

constructor TCashOperation.Create;
begin
  inherited;
  spInsertUpdate := 'gpInsertUpdate_Movement_Cash';
  spSelect := 'gpSelect_Movement_Cash';
  spGet := 'gpGet_Movement_Cash';
  spCompleteProcedure := 'gpComplete_Movement_Cash';
end;

function TCashOperation.InsertDefault: integer;
var Id: Integer;
    InvNumber: String;
    OperDate: TDateTime;
    Amount: Double;
    CashId, ObjectId, PaidKindId, InfoMoneyId, ContractId, UnitId, PositionId: Integer;
    AccrualsDate: TDateTime;
begin
  Id:=0;
  InvNumber:='1';
  OperDate:= Date;
  // �������� �����
  CashId := TCash.Create.GetDefault;
  // �������� �� ����
  ObjectId := TJuridical.Create.GetDefault;
  PaidKindId := 0;
  ContractId := 0;
  InfoMoneyId := 0;
  with TInfoMoneyTest.Create.GetDataSet do begin
     if Locate('Code', '10103', []) then
        InfoMoneyId := FieldByName('Id').AsInteger;
  end;
  UnitId := 0;
  Amount := 265.68;
  //
  PositionId := 0;
  AccrualsDate := Date;

  result := InsertUpdateCashOperation(Id, InvNumber,
        OperDate, Amount, '��� �����������',
        CashId, ObjectId, ContractId, InfoMoneyId, UnitId);
;
end;

function TCashOperation.InsertUpdateCashOperation(const Id: integer; InvNumber: String;
        OperDate: TDateTime; Amount: Double; Comment: string;
        CashId, ObjectId, ContractId, InfoMoneyId, UnitId: integer): integer;
begin
  FParams.Clear;
  FParams.AddParam('ioId', ftInteger, ptInputOutput, Id);
  FParams.AddParam('inInvNumber', ftString, ptInput, InvNumber);
  FParams.AddParam('inOperDate', ftDateTime, ptInput, OperDate);
  FParams.AddParam('inAmountIn', ftFloat, ptInput, Amount);
  FParams.AddParam('inAmountOut', ftFloat, ptInput, 0);
  FParams.AddParam('inComment', ftString, ptInput, Comment);
  FParams.AddParam('inCashId', ftInteger, ptInput, CashId);
  FParams.AddParam('inObjectId', ftInteger, ptInput, ObjectId);
  FParams.AddParam('inContractId', ftInteger, ptInput, ContractId);
  FParams.AddParam('inInfoMoneyId', ftInteger, ptInput, InfoMoneyId);
  FParams.AddParam('inUnitId', ftInteger, ptInput, UnitId);

  result := InsertUpdate(FParams);

end;

{ TIncomeCashJuridicalTest }

procedure TCashOperationTest.ProcedureLoad;
begin
  ScriptDirectory := ProcedurePath + 'Movement\_Cash\';
  inherited;
  ScriptDirectory := ProcedurePath + 'MovementItemContainer\_Cash\';
  inherited;
end;

procedure TCashOperationTest.Test;
var MovementCashOperation: TCashOperation;
    Id, RecordCount: Integer;
    StoredProc: TdsdStoredProc;
    AccountAmount, AccountAmountTwo: double;
begin
  inherited;
  AccountAmount := 0;
  AccountAmountTwo := 0;
  // ������� ������ ��������
  MovementCashOperation := TCashOperation.Create;

  RecordCount := MovementCashOperation.GetDataSet.RecordCount;

  // �������� ���������
  Id := MovementCashOperation.InsertDefault;
  // ��������� ������� �� ����� �����
  StoredProc := TdsdStoredProc.Create(nil);
  StoredProc.Params.AddParam('inStartDate', ftDateTime, ptInput, Date);
  StoredProc.Params.AddParam('inEndDate', ftDateTime, ptInput, TDateTime(Date));
  StoredProc.StoredProcName := 'gpReport_Balance';
  StoredProc.DataSet := TClientDataSet.Create(nil);
  StoredProc.OutputType := otDataSet;
  StoredProc.Execute;
  with StoredProc.DataSet do begin
     if Locate('AccountCode', '40101', []) then
        AccountAmount := FieldByName('AmountDebetEnd').AsFloat + FieldByName('AmountKreditEnd').AsFloat
  end;
  MovementCashOperation.GetRecord(Id);
  try
    // ����������
    MovementCashOperation.DocumentComplete(Id);
    StoredProc.Execute;
    with StoredProc.DataSet do begin
      if Locate('AccountCode', '40101', []) then
         AccountAmountTwo := FieldByName('AmountDebetEnd').AsFloat - FieldByName('AmountKreditEnd').AsFloat;
    end;
    Check(abs(AccountAmount - (AccountAmountTwo + 265.68)) < 0.01, '��������� �� ���������. ���� ' + FloatToStr(AccountAmount) + ' ����� ' + FloatToStr(AccountAmountTwo));
  finally
    // �������������
    MovementCashOperation.DocumentUnComplete(Id);
    StoredProc.Free;
  end;
end;

initialization

  TestFramework.RegisterTest('���������', TCashOperationTest.Suite);

end.
