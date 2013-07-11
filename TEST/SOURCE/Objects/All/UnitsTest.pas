unit UnitsTest;

interface

uses dbTest, dbObjectTest;

type

  TUnitTest = class (TdbTest)
  published
    procedure ProcedureLoad; override;
    procedure Test; override;
  end;

  TUnit = class(TObjectTest)
    function InsertDefault: integer; override;
  public
    // ��������� ������ � ��� �����������
    procedure Delete(Id: Integer); override;
    function InsertUpdateUnit(Id, Code: Integer; Name: String;
                              ParentId, BranchId, BusinessId, JuridicalId,
                              AccountDirectionId, ProfitLossDirectionId: integer): integer;
    constructor Create; override;
  end;


implementation

uses DB, UtilConst, TestFramework, SysUtils;

{ TdbUnitTest }

procedure TUnitTest.ProcedureLoad;
begin
  ScriptDirectory := ProcedurePath + 'OBJECTS\_Unit\';
  inherited;
end;

procedure TUnitTest.Test;
var Id, Id2, Id3: integer;
    RecordCount: Integer;
    ObjectTest: TUnit;
begin
 // ��� ���� ������ ��������� ������������ ������ � �������.
 // � ������ ������������.
  ObjectTest := TUnit.Create;
  // ������� ������ ��������
  RecordCount := ObjectTest.GetDataSet.RecordCount;
  // ������� �������
 // ��������� ������ 1
  Id := ObjectTest.InsertDefault;
  try
    // ��������� ������ � �������������
    with ObjectTest.GetRecord(Id) do begin
         Check((FieldByName('Name').AsString = '�������������'), '�� �������� ������ Id = ' + IntToStr(Id));
         Check((FieldByName('isLeaf').AsBoolean ), '�� ��������� ����������� �������� isLeaf Id = ' + IntToStr(Id));
    end;
    // ������ ������ ������ �� ���� � ��������� ������
    try
      ObjectTest.InsertUpdateUnit(Id, -1, '������ 1 - ����', Id, 0, 0, 0, 0, 0);
      Check(false, '��� ��������� �� ������');
    except

    end;
    // ��������� ��� ������ 2
    // ������ � ������ 2 ������ �� ������ 1
    Id2 := ObjectTest.InsertUpdateUnit(0, -2, '������ 2 - ����', Id, 0, 0, 0, 0, 0);
    try
      with ObjectTest.GetRecord(Id) do begin
           Check(FieldByName('isLeaf').AsBoolean = false, '�� ��������� ����������� �������� isLeaf Id = ' + IntToStr(Id));
      end;
      with ObjectTest.GetRecord(Id2) do begin
          Check(FieldByName('isLeaf').AsBoolean, '�� ��������� ����������� �������� isLeaf Id = ' + IntToStr(Id2));
      end;
      // ������ ������ ������ � ������ 1 �� ������ 2 � ��������� ������
      try
        ObjectTest.InsertUpdateUnit(Id, -1, '������ 1 - ����', Id2, 0, 0, 0, 0, 0);
        Check(false, '��� ��������� �� ������');
      except

      end;
      // ��������� ��� ������ 3
      // ������ � ������ 3 ������ �� ������ 2
      Id3 := ObjectTest.InsertUpdateUnit(0, -3, '������ 3 - ����', Id2, 0, 0, 0, 0, 0);
      try
        with ObjectTest.GetRecord(Id2) do begin
           Check(FieldByName('isLeaf').AsBoolean = false, '�� ��������� ����������� �������� isLeaf Id = ' + IntToStr(Id2));
        end;
        with ObjectTest.GetRecord(Id3) do begin
           Check(FieldByName('isLeaf').AsBoolean, '�� ��������� ����������� �������� isLeaf Id = ' + IntToStr(Id3));
        end;
        // ������ 2 ��� ������ �� ������ 1
        // ������ � ������ 1 ������ �� ������ 3 � ��������� ������
        try
          ObjectTest.InsertUpdateUnit(Id, -1, '������ 1 - ����', Id3, 0, 0, 0, 0, 0);
          Check(false, '��� ��������� �� ������');
        except

        end;
        Check((ObjectTest.GetDataSet.RecordCount = RecordCount + 3), '���������� ������� �� ����������');
      finally
        ObjectTest.Delete(Id3);
        with ObjectTest.GetRecord(Id2) do begin
           Check(FieldByName('isLeaf').AsBoolean, '�� ��������� ����������� �������� isLeaf Id = ' + IntToStr(Id2));
        end;
      end;
    finally
      ObjectTest.Delete(Id2);
      with ObjectTest.GetRecord(Id) do begin
         Check(FieldByName('isLeaf').AsBoolean, '�� ��������� ����������� �������� isLeaf Id = ' + IntToStr(Id));
      end;
    end;
  finally
    ObjectTest.Delete(Id);
  end;
end;

{ TUnitTest }

constructor TUnit.Create;
begin
  inherited;
  spInsertUpdate := 'gpInsertUpdate_Object_Unit';
  spSelect := 'gpSelect_Object_Unit';
  spGet := 'gpGet_Object_Unit';
end;

procedure TUnit.Delete(Id: Integer);
begin
  inherited;
  with TBranchTest.Create do
  try
    Delete(GetDefault);
  finally
    Free;
  end;
end;

function TUnit.InsertDefault: integer;
var
  BranchId: Integer;
begin
  BranchId := TBranchTest.Create.GetDefault;
  result := InsertUpdateUnit(0, 1, '�������������', 0, BranchId, 0, 0, 0, 0);
end;

function TUnit.InsertUpdateUnit(Id, Code: Integer; Name: String;
                                    ParentId, BranchId, BusinessId, JuridicalId,
                                    AccountDirectionId, ProfitLossDirectionId: integer): integer;
begin
  FParams.Clear;
  FParams.AddParam('ioId', ftInteger, ptInputOutput, Id);
  FParams.AddParam('inCode', ftInteger, ptInput, Code);
  FParams.AddParam('inName', ftString, ptInput, Name);
  FParams.AddParam('inParentId', ftInteger, ptInput, ParentId);
  FParams.AddParam('inBranchId', ftInteger, ptInput, BranchId);

  FParams.AddParam('inBusinessId', ftInteger, ptInput, BusinessId);
  FParams.AddParam('inJuridicalId', ftInteger, ptInput, JuridicalId);
  FParams.AddParam('inAccountDirectionId', ftInteger, ptInput, AccountDirectionId);
  FParams.AddParam('inProfitLossDirectionId', ftInteger, ptInput, ProfitLossDirectionId);

  result := InsertUpdate(FParams);
end;


initialization
  TestFramework.RegisterTest('�������', TUnitTest.Suite);

end.
