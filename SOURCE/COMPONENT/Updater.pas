unit Updater;

interface

type

  TUpdater = class
     class procedure AutomaticUpdateProgram;
     class procedure UpdateProgram;
  end;

implementation

uses UnilWin, Dialogs, Controls, StdCtrls, FormStorage, SysUtils, forms;

{ TUpdater }

class procedure TUpdater.AutomaticUpdateProgram;
var LocalVersionInfo, BaseVersionInfo: TVersionInfo;
begin
  try
    BaseVersionInfo := TdsdFormStorageFactory.GetStorage.LoadFileVersion(ExtractFileName(ParamStr(0)));
    LocalVersionInfo := UnilWin.GetFileVersion(ParamStr(0));
    if (BaseVersionInfo.VerHigh > LocalVersionInfo.VerHigh) or
       ((BaseVersionInfo.VerHigh = LocalVersionInfo.VerHigh) and (BaseVersionInfo.VerLow > LocalVersionInfo.VerLow))  then
        if MessageDlg('���������� ����� ������ ���������! ��������', mtInformation, mbOKCancel, 0) = mrOk then
           UpdateProgram;
  except
    ShowMessage('�� �������� �������������� ����������.'#13#10'���������� � ������������');
  end;
end;

class procedure TUpdater.UpdateProgram;
begin
  FileWriteString(ParamStr(0)+'.uTMP', TdsdFormStorageFactory.GetStorage.LoadFile(ExtractFileName(ParamStr(0))));
  if not FileExists(ExtractFileDir(ParamStr(0))+'\Upgrader4.exe') then
     FileWriteString(ExtractFileDir(ParamStr(0))+'\Upgrader4.exe', TdsdFormStorageFactory.GetStorage.LoadFile(ExtractFileName('Upgrader4.exe')));
  Execute(ExtractFileDir(ParamStr(0)) + '\Upgrader4.exe ' + ParamStr(0), ExtractFileDir(ParamStr(0)));
  ShowMessage('��������� ������� ���������. ������� ������ ��� �����������');
  Application.Terminate
end;

end.


