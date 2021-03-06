unit CommonObjectProcedureTest;

interface

uses dbTest;

type

  TCommonObjectProcedure = class (TdbTest)
  published
    procedure ProcedureLoad; override;
    procedure AllProcedureLoad;
  end;

implementation

uses UtilConst, TestFramework;

{ ���������������������� }

procedure TCommonObjectProcedure.AllProcedureLoad;
begin
  DirectoryLoad(ProcedurePath + 'OBJECTS\')
end;

procedure TCommonObjectProcedure.ProcedureLoad;
begin
  ScriptDirectory := ProcedurePath + 'OBJECTS\Common\';
  inherited;
end;

initialization
  TestFramework.RegisterTest('�������', TCommonObjectProcedure.Suite);
  TestFramework.RegisterTest('���������', TCommonObjectProcedure.Suite);

end.
