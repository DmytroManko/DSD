unit CashTest;

interface

uses dbTest, dbObjectTest;

type

  TCashTest = class (TdbObjectTestNew)
  published
    procedure ProcedureLoad; override;
    procedure Test; override;
  end;

  TCash = class(TObjectTest)
    function InsertDefault: integer; override;
  public
    function InsertUpdateCash(const Id, Code : integer; CashName: string; CurrencyId: Integer;
                                     BranchId, MainJuridicalId, BusinessId: integer): integer;
    constructor Create; override;
  end;

implementation

uses DB, UtilConst, TestFramework, SysUtils, JuridicalTest;

{ TdbUnitTest }

procedure TCashTest.ProcedureLoad;
begin
  ScriptDirectory := ProcedurePath + 'OBJECTS\_Cash\';
  inherited;
end;

procedure TCashTest.Test;
var Id: integer;
    RecordCount: Integer;
    ObjectTest: TCash;
begin
  ObjectTest := TCash.Create;
  // ������� ������
  RecordCount := ObjectTest.GetDataSet.RecordCount;
  // ������� ��������������� �����
  Id := ObjectTest.InsertDefault;
  try
    // ��������� ������ � �����
    with ObjectTest.GetRecord(Id) do
      Check((FieldByName('name').AsString = '������� �����'), '�� �������� ������ Id = ' + FieldByName('id').AsString);
    // ������� ������ ����
    Check(ObjectTest.GetDataSet.RecordCount = (RecordCount + 1), '���������� ������� �� ����������');
  finally
    ObjectTest.Delete(Id);
  end;
end;

{ TCashTest }

constructor TCash.Create;
begin
  inherited Create;
  spInsertUpdate := 'gpInsertUpdate_Object_Cash';
  spSelect := 'gpSelect_Object_Cash';
  spGet := 'gpGet_Object_Cash';
end;

function TCash.InsertDefault: integer;
var CurrencyId, BranchId, MainJuridicalId, BusinessId: Integer;
begin
  CurrencyId := TCurrencyTest.Create.GetDefault;
  BranchId := TBranchTest.Create.GetDefault;
  MainJuridicalId := TJuridical.Create.GetDefault;
  BusinessId := TBranchTest.Create.GetDefault;

  result := InsertUpdateCash(0, -3, '������� �����', CurrencyId, BranchId, MainJuridicalId, BusinessId);
  inherited;
end;

function TCash.InsertUpdateCash(const Id, Code : integer; CashName: string; CurrencyId: Integer;
                                     BranchId, MainJuridicalId, BusinessId: integer): integer;
begin
  FParams.Clear;
  FParams.AddParam('ioId', ftInteger, ptInputOutput, Id);
  FParams.AddParam('inCode', ftInteger, ptInput, Code);
  FParams.AddParam('inCashName', ftString, ptInput, CashName);
  FParams.AddParam('inCurrencyId', ftInteger, ptInput, CurrencyId);
  FParams.AddParam('inBranchId', ftInteger, ptInput, BranchId);
  FParams.AddParam('inMainJuridicalId', ftInteger, ptInput, MainJuridicalId);
  FParams.AddParam('inBusinessId', ftInteger, ptInput, BusinessId);
  result := InsertUpdate(FParams);
end;

initialization
  TestFramework.RegisterTest('�������', TCashTest.Suite);

end.
