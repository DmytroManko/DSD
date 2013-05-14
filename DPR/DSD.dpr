program DSD;

uses
  Vcl.Forms,
  Controls,
  Classes,
  LoginForm in '..\SOURCE\LoginForm.pas' {LoginForm},
  Storage in '..\SOURCE\Storage.pas',
  Authentication in '..\SOURCE\Authentication.pas',
  UtilConst in '..\SOURCE\UtilConst.pas',
  CommonData in '..\SOURCE\CommonData.pas',
  MainForm in '..\SOURCE\MainForm.pas' {MainForm},
  ParentForm in '..\SOURCE\ParentForm.pas' {ParentForm},
  dsdDB in '..\SOURCE\COMPONENT\dsdDB.pas',
  UtilConvert in '..\SOURCE\UtilConvert.pas',
  dsdAction in '..\SOURCE\COMPONENT\dsdAction.pas',
  DataModul in '..\SOURCE\DataModul.pas' {dmMain: TDataModule},
  dsdGuides in '..\SOURCE\COMPONENT\dsdGuides.pas',
  FormStorage in '..\SOURCE\FormStorage.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
         // ������� ��������������
 // with TLoginForm.Create(Application) do
    //���� ��� ������ ������� ������� ����� Application.CreateForm();
   // if ShowModal = mrOk then
   TAuthentication.CheckLogin(TStorageFactory.GetStorage, '�����', '�����', gc_User);

   Application.CreateForm(TMainForm, MainFormInstance);
  Application.CreateForm(TdmMain, dmMain);
  Application.Run;
end.