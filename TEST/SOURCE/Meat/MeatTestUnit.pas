unit MeatTestUnit;

interface

uses TestFramework, Db;

type
  TMeatTest = class (TTestCase)
  protected
    // �������������� ������ ��� ������������
    procedure SetUp; override;
    // ���������� ������ ��� ������������
    procedure TearDown; override;
  published
    procedure Test;
  end;

implementation

end.
