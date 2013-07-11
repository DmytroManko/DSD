unit CommonObjectProcedureTest;

interface

uses dbTest;

type

  TCommonObjectProcedure = class (TdbTest)
  published
    procedure ProcedureLoad; override;
  end;

implementation

uses UtilConst, TestFramework;

{ ���������������������� }

procedure TCommonObjectProcedure.ProcedureLoad;
begin
  ScriptDirectory := ProcedurePath + 'OBJECTS\Common';
  inherited;
end;

initialization
  TestFramework.RegisterTest('�������', TCommonObjectProcedure.Suite);
  TestFramework.RegisterTest('���������', TCommonObjectProcedure.Suite);

end.
