unit DefaultsTest;

interface

uses dbTest, dsdDB;

type

  TDefaults = class (TdbTest)
  private
    FStoredProc: TdsdStoredProc;
  published
    procedure ProcedureLoad; override;
    procedure Test; virtual;
  end;

implementation

uses UtilConst, TestFramework;

{ TDefaults }

procedure TDefaults.ProcedureLoad;
begin
  ScriptDirectory := ProcedurePath + 'Default\';
  inherited;
end;

procedure TDefaults.Test;
begin
  FStoredProc := TdsdStoredProc.Create(nil);
  // �� ��������� ����� ���� � ����
  // ����� ��������� �������� ������� ����� ��� ������������ ����
  // � ��������� �������� ������ ��� ������� ������������
  // � ����� ������� ����
end;

initialization

  TestFramework.RegisterTest('Defaults', TDefaults.Suite);

end.
