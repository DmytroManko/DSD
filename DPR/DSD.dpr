program DSD;

uses
  Vcl.Forms,
  Controls,
  Classes,
  LoginFormUnit in '..\SOURCE\LoginFormUnit.pas' {LoginForm},
  StorageUnit in '..\SOURCE\StorageUnit.pas',
  AuthenticationUnit in '..\SOURCE\AuthenticationUnit.pas',
  UtilType in '..\SOURCE\UtilType.pas',
  UtilConst in '..\SOURCE\UtilConst.pas',
  CommonDataUnit in '..\SOURCE\CommonDataUnit.pas',
  MainFormUnit in '..\SOURCE\MainFormUnit.pas' {MainForm},
  FormUnit in '..\SOURCE\FormUnit.pas' {Form2},
  UnitTest in '..\Forms\UnitTest.pas' {Form3},
  dsdDataSetWrapperUnit in '..\SOURCE\COMPONENT\dsdDataSetWrapperUnit.pas',
  UtilConvert in '..\SOURCE\UtilConvert.pas',
  dsdActionUnit in '..\SOURCE\COMPONENT\dsdActionUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
         // ������� ��������������
 // with TLoginForm.Create(Application) do
    //���� ��� ������ ������� ������� ����� Application.CreateForm();
   // if ShowModal = mrOk then
   TAuthentication.CheckLogin(TStorageFactory.GetStorage, '�����', '�����', gc_User);

   Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
