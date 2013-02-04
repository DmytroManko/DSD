unit AuthenticationTestUnit;

interface
uses TestFramework;

type
  TAuthenticationTest = class (TTestCase)
  private
  protected
    // �������������� ������ ��� ������������
    procedure SetUp; override;
    // ���������� ������ ��� ������������
    procedure TearDown; override;
  published
    procedure Authentication;
  end;

implementation

uses AuthenticationUnit, StorageUnit;

{ TAuthenticationTest }

procedure TAuthenticationTest.Authentication;
var lUser: TUser;
begin
  Check(TAuthentication.CheckLogin(TStorageFactory.GetStorage, 'Admin', 'Admin', lUser), '�������� ������������');
end;

procedure TAuthenticationTest.SetUp;
begin
  inherited;
end;

procedure TAuthenticationTest.TearDown;
begin
  inherited;

end;

initialization
  TestFramework.RegisterTest('AuthenticationTest', TAuthenticationTest.Suite);

end.
