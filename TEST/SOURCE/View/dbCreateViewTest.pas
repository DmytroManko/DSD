unit dbCreateViewTest;

interface

uses dbTest;

type

  TView = class (TdbTest)
  published
    procedure ProcedureLoad; override;
  end;

implementation

uses UtilConst, TestFramework;

{ ���������������������� }

procedure TView.ProcedureLoad;
begin
  ScriptDirectory := ViewPath;
  inherited;
end;

initialization
  TestFramework.RegisterTest('VIEW', TView.Suite);

end.
