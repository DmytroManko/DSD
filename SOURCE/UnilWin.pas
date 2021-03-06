(*
     ��������:
     ���� �������� ��� ��������� ������.

     ������� ���������:

     �����         ���� ��������      �������            ���� �����������
     ������ �.�.   24.01.2008
���������
    {��������� ���������� � ������ ���������}
    Function GetFileVersion(const FileName:String):TVersionInfo;
    {��������� ���������� � ������ � ���� ������}
    Function GetFileVersionString(const FileName:String):String;
    {��������� ���� � ���� ������}
    function FileReadString(const FileName: String): String;
    {�������� ������ � ����}
    procedure FileWriteString(const FileName: String; Data: String);
    {��������� ����������}
    function Execute(const CommandLine, WorkingDirectory : string) : integer;



*)
unit UnilWin;

interface
uses Windows;

type

  TVersionInfo = Record
    VerHigh, VerLow: Integer;
  End;

{��������� ���������� � ������ ���������}
Function GetFileVersion(const FileName:String):TVersionInfo;
{��������� ���������� � ������ � ���� ������}
Function GetFileVersionString(const FileName:String):String;
{��������� ���� � ���� ������}
function FileReadString(const FileName: String): AnsiString;
{�������� ������ � ����}
procedure FileWriteString(const FileName: String; Data: AnsiString);
{��������� ����������}
function Execute(const CommandLine, WorkingDirectory : string) : integer;

implementation

uses SysUtils;

function Execute(const CommandLine, WorkingDirectory : string) : integer;
var
  R : boolean;
  ProcessInformation : TProcessInformation;
  StartupInfo : TStartupInfo;
  S: string;
//  ExCode : integer;
begin
  Result := 0;
  FillChar(StartupInfo, sizeof(TStartupInfo), 0);
  with StartupInfo do begin
    cb := sizeof(TStartupInfo);
    dwFlags := STARTF_USESHOWWINDOW;
    wShowWindow := SW_SHOW;
  end;
  R := CreateProcess(
    nil, // pointer to name of executable module
    PChar(CommandLine), // pointer to command line string
    nil,// pointer to process security attributes
    nil,// pointer to thread security attributes
    false, // handle inheritance flag
    0, // creation flags
    nil,// pointer to new environment block
    PChar(WorkingDirectory), // pointer to current directory name
    StartupInfo, // pointer to STARTUPINFO
    ProcessInformation // pointer to PROCESS_INFORMATION
   );
  if not R then
    begin
           SetLength(S, 256);
           FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM, nil, GetLastError, LOCALE_USER_DEFAULT, PChar(S), Length(S), nil);
           raise Exception.Create(S);
   end
end;


procedure FileWriteString(const FileName: String; Data: AnsiString);
var
  FileHandle: hFile;
  FileSize, Dummy: DWord;
  S: AnsiString;
  Buffer: PChar;
begin
  FileHandle := CreateFile(PChar(FileName), GENERIC_WRITE, FILE_SHARE_READ or FILE_SHARE_WRITE, nil,
                           CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
  if FileHandle <> INVALID_HANDLE_VALUE then
   begin
    try
      FileSize := Length(Data);
      GetMem(Buffer, FileSize);
      Move(Data[1], Buffer^, FileSize);
      if not WriteFile(FileHandle, Buffer^, FileSize, Dummy, nil) then begin
         SetLength(S, 256);
         FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM, nil, GetLastError, LOCALE_USER_DEFAULT, PChar(S), Length(S), nil);
         raise Exception.Create(S);
      end;
    finally
      CloseHandle(FileHandle);
    end
   end;
end;


function FileReadString(const FileName: String): AnsiString;
var
  FileHandle: hFile;
  FileSize, Dummy: DWord;
  Buffer: PChar;
begin
  Result := '';
  FileHandle := CreateFile(PChar(FileName), GENERIC_READ, FILE_SHARE_READ or FILE_SHARE_WRITE, nil,
                           OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  if FileHandle <> INVALID_HANDLE_VALUE then
   begin
    FileSize := GetFileSize(FileHandle, @Dummy);
    GetMem(Buffer, FileSize);
    try
      if ReadFile(FileHandle, Buffer^, FileSize, Dummy, nil) then
       begin
        SetLength(Result, FileSize);
        Move(Buffer^, Result[1], FileSize);
       end;
    finally
      FreeMEM(Buffer);
    end;
    CloseHandle(FileHandle);
   end;
end;

Function GetFileVersionString(const FileName:String):String;
begin
  result:='';
  with GetFileVersion(FileName) do begin
    result:= IntToStr(VerHigh shr 16)+'.'+IntToStr((VerHigh shl 16) shr 16)+'.'+
             IntToStr(VerLow shr 16)+'.'+IntToStr((VerLow shl 16) shr 16)
  end
end;

Function GetFileVersion(const FileName:String):TVersionInfo;
Var
  Dummy:DWord;
  Data:Pointer;
  VersionInfo:PVSFixedFileInfo;
  Size:Integer;
Begin
  Size:=GetFileVersionInfoSize(PChar(FileName),Dummy);
  If Size=0 Then
  Begin
    Result.VerHigh:=0;                     
    Result.VerLow:=0;
  End;
   GetMem(Data,Size);
  Try
    If Not GetFileVersionInfo(PChar(FileName),0,Size,Data) Then
    Begin
      Result.VerHigh:=0;
      Result.VerLow:=0;
      Exit;
    End;
    VerQueryValue(Data,'\',Pointer(VersionInfo),Dummy);
    With Result,VersionInfo^ Do
    Begin
      VerHigh:=dwFileVersionMS;          
      VerLow:=dwFileVersionLS;
    End;
  Finally
    FreeMem(Data);
  End;
End;

end.
