unit CommonObjectProcedureTest;

interface

uses dbTest;

type

  ���������������������� = class (TdbTest)
  published
    procedure ����������������; override;
  end;

implementation

uses UtilConst, TestFramework;

{ ���������������������� }

procedure ����������������������.����������������;
begin
  ScriptDirectory := ProcedurePath + 'OBJECTS\Common';
  inherited;
end;

initialization
  TestFramework.RegisterTest('�������', ����������������������.Suite);
  TestFramework.RegisterTest('���������', ����������������������.Suite);

end.
