unit StorageUnit;

interface

uses UtilType, IdHTTP;

type

  ///	<summary>
  /// ����� - ���� ����� ����������� � ������� �������.
  ///	</summary>
  ///	<remarks>
  /// ������������ ������ ����� ��� ������ ������� �� ������� ���� ������
  ///	</remarks>
  TStorage = class
  private
    FConnection: String;
    IdHTTP: TIdHTTP;
  public
    ///	<summary>
    /// ��������� ������ ����������� XML �������� �� ������� ������.
    ///	</summary>
    ///	<remarks>
    /// ���������� XML ��� ��������� ������
    ///	</remarks>
    ///	<param name="pData">
    ///	  XML ���������, �������� ������ ��� ��������� �� �������
    ///	</param>
    function ExecuteProc(var pData: TXML): TXML;
    ///	<param name="pConnection">
    ///	  ������� ���������� � �������� �������� ������
    ///	</param>
    constructor Create(pConnection: string);
  end;

  TStorageFactory = class
     class function GetStorage: TStorage;
  end;

implementation

uses Classes;

class function TStorageFactory.GetStorage: TStorage;
begin
  result := TStorage.Create('http://localhost/dsd/index.php');
end;

constructor TStorage.Create(pConnection: string);
begin
  IdHTTP := TIdHTTP.Create(nil);
  FConnection := pConnection
end;

function TStorage.ExecuteProc(var pData: TXML): TXML;
begin
  result := IdHTTP.Post(FConnection, TStringList.Create)
end;


end.
