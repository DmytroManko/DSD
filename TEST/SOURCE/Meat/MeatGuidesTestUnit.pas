unit MeatGuidesTestUnit;

interface

uses TestFramework, dsdDataSetWrapperUnit;

type

  TMeatGuidesTest = class (TTestCase)
  protected
    // �������������� ������ ��� ������������
    procedure SetUp; override;
    // ���������� ������ ��� ������������
    procedure TearDown; override;
  published
    procedure CurrencyTest;
    procedure CashTest;
  end;

implementation

{ TMeatGuidesTest }

procedure TMeatGuidesTest.SetUp;
begin
  inherited;

end;

procedure TMeatGuidesTest.TearDown;
begin
  inherited;

end;

procedure TMeatGuidesTest.CashTest;
begin

end;

procedure TMeatGuidesTest.CurrencyTest;
begin

end;

end.
