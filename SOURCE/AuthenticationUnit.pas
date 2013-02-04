unit AuthenticationUnit;

interface

uses StorageUnit;

type

  ///	<summary>
  /// ����� �������� ���������� � ������� ������������
  ///	</summary>
  ///	<remarks>
  ///	</remarks>
  TUser = class
  private
    FSession: String;
  public
    property Session: String read FSession;
    constructor Create(ASession: String);
  end;

  ///	<summary>
  /// ����� �������������� ������������
  ///	</summary>
  ///	<remarks>
  ///	</remarks>
  TAuthentication = class
    ///	<summary>
    /// �������� ������ � ������. � ������ ������ ���������� ������ � ������������.
    ///	</summary>
    class function CheckLogin(pStorage: TStorage; const pUserName, pPassword: string; var pUser: TUser): boolean;
  end;

implementation

uses UtilType, Xml.XMLDoc, UtilConst;

constructor TUser.Create(ASession: String);
begin
  FSession := ASession;
end;

class function TAuthentication.CheckLogin(pStorage: TStorage; const pUserName, pPassword: string; var pUser: TUser): boolean;
var pXML: TXML;
begin
  {������� XML ������ ��������� �� �������}
  pXML :=
  '<xml>' +
    '<gpCheckLogin>' +
      '<inUserLogin    ParamType="ptInput" DataType="ftString" Value="' + pUserName + '" />' +
      '<inUserPassword ParamType="ptInput" DataType="ftString" Value="' + pPassword + '" />' +
    '</gpCheckLogin>' +
  '</xml>';

  with LoadXMLData(pStorage.ExecuteProc(pXML)).DocumentElement do
       pUser := TUser.Create(GetAttribute(gcSession));
  result := pUser <> nil
 (* try
    {����� ��������� �������� ������������}
    gpExecuteInsertUpdateOnApplicationLevel(gcCurrentObjectName,gcCurrentComputerName,pXML);
    {��������� ������}
    gc_CurrentSession:=gfGetXMLAttribute(gfCreateLoadXML(pXML).DocumentElement,gcSession);
    {�������� ������ ������������� � ������������}
    gcUserGroup:=gfGetXMLAttribute(gfCreateLoadXML(pXML).DocumentElement,gcUserGroupName);
    gcUser:=gfGetXMLAttribute(gfCreateLoadXML(pXML).DocumentElement,gcUserName);
    AllowLogin:=true;
  except
    on E:Exception do begin
        gpProcessError(E,fShowSystemInformation, self);
      AllowLogin:=false;
    end;
  end;     *)
end;

end.
