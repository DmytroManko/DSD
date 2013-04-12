unit DataBaseUsersObjectTest;

interface

uses DataBaseObjectTestUnit;

type

  TJuridicalGroupTest = class(TObjectTest)
  private
    function InsertDefault: integer; override;
  public
    function InsertUpdateJuridicalGroup(const Id, Code: Integer; Name: string; JuridicalGroupId: integer): integer;
    constructor Create; override;
  end;

  TGoodsPropertyTest = class(TObjectTest)
  private
    function InsertDefault: integer; override;
  public
    function InsertUpdateGoodsProperty(const Id, Code: Integer; Name: string): integer;
    constructor Create; override;
  end;

  TJuridicalTest = class(TObjectTest)
  private
    function InsertDefault: integer; override;
  public
    function InsertUpdateJuridical(const Id: integer; Code: Integer;
        Name, GLNCode: string; isCorporate: boolean; JuridicalGroupId, GoodsPropertyId: integer): integer;
    constructor Create; override;
  end;

  TContractTest = class(TObjectTest)
  private
    function InsertDefault: integer; override;
  public
    function InsertUpdateContract(const Id: integer; InvNumber, Comment: string): integer;
    constructor Create; override;
  end;


  TDataBaseUsersObjectTest = class (TCustomDataBaseObjectTest)
  published
    procedure JuridicalGroup_Test;
    procedure Juridical_Test;
    procedure Contract_Test;
  end;

implementation

uses TestFramework, DB;

{ TJuridicalGroupTest }

constructor TJuridicalGroupTest.Create;
begin
  inherited;
  spInsertUpdate := 'gpInsertUpdate_Object_JuridicalGroup';
  spSelect := 'gpSelect_Object_JuridicalGroup';
  spGet := 'gpGet_Object_JuridicalGroup';
end;

function TJuridicalGroupTest.InsertDefault: integer;
begin
  result := InsertUpdateJuridicalGroup(0, 1, '������ �� ��� 1', 0);
end;

function TJuridicalGroupTest.InsertUpdateJuridicalGroup(const Id, Code: Integer;
  Name: string; JuridicalGroupId: integer): integer;
begin
  FParams.Clear;
  FParams.AddParam('ioId', ftInteger, ptInputOutput, Id);
  FParams.AddParam('inCode', ftInteger, ptInput, Code);
  FParams.AddParam('inName', ftString, ptInput, Name);
  FParams.AddParam('inJuridicalGroupId', ftInteger, ptInput, JuridicalGroupId);
  result := InsertUpdate(FParams);
end;

{ TGoodsPropertyTest }

constructor TGoodsPropertyTest.Create;
begin
  inherited;
  spInsertUpdate := 'gpInsertUpdate_Object_GoodsProperty';
  spSelect := 'gpSelect_Object_GoodsProperty';
  spGet := 'gpGet_Object_GoodsProperty';
end;

function TGoodsPropertyTest.InsertDefault: integer;
begin
  result := InsertUpdateGoodsProperty(0, 1, '������������� ������� �������');
end;

function TGoodsPropertyTest.InsertUpdateGoodsProperty(const Id, Code: Integer;
  Name: string): integer;
begin
  FParams.Clear;
  FParams.AddParam('ioId', ftInteger, ptInputOutput, Id);
  FParams.AddParam('inCode', ftInteger, ptInput, Code);
  FParams.AddParam('inName', ftString, ptInput, Name);
  result := InsertUpdate(FParams);
end;

{ TJuridicalTest }

constructor TJuridicalTest.Create;
begin
  inherited;
  spInsertUpdate := 'gpInsertUpdate_Object_Juridical';
  spSelect := 'gpSelect_Object_Juridical';
  spGet := 'gpGet_Object_Juridical';
end;

function TJuridicalTest.InsertDefault: integer;
var
  JuridicalGroupId, GoodsPropertyId: Integer;
begin
  JuridicalGroupId := TJuridicalGroupTest.Create.GetDefault;
  GoodsPropertyId := TGoodsPropertyTest.Create.GetDefault;
  result := InsertUpdateJuridical(0, 1, '��. ����', 'GLNCode', true, JuridicalGroupId, GoodsPropertyId)
end;

function TJuridicalTest.InsertUpdateJuridical;
begin
  FParams.Clear;
  FParams.AddParam('ioId', ftInteger, ptInputOutput, Id);
  FParams.AddParam('inCode', ftInteger, ptInput, Code);
  FParams.AddParam('inName', ftString, ptInput, Name);
  FParams.AddParam('inGLNCode', ftString, ptInput, GLNCode);
  FParams.AddParam('isCorporate', ftBoolean, ptInput, isCorporate);
  FParams.AddParam('inJuridicalGroupId', ftInteger, ptInput, JuridicalGroupId);
  FParams.AddParam('inGoodsPropertyId', ftInteger, ptInput, GoodsPropertyId);
  result := InsertUpdate(FParams);
end;

{ TDataBaseUsersObjectTest }

procedure TDataBaseUsersObjectTest.JuridicalGroup_Test;
var Id, Id2, Id3: integer;
    RecordCount: Integer;
    ObjectTest: TJuridicalGroupTest;
begin
 // ��� ���� ������ ��������� ������������ ������ � �������.
 // � ������ ������������.
  ObjectTest := TJuridicalGroupTest.Create;
  // ������� ������ ��������
  RecordCount := GetRecordCount(ObjectTest);
  // ������� �������
 // ��������� ������ 1
  Id := ObjectTest.InsertDefault;
  try
    // ������ ������ ������ �� ���� � ��������� ������
    try
      ObjectTest.InsertUpdateJuridicalGroup(Id, 1, '������ 1', Id);
      Check(false, '��� ��������� �� ������');
    except

    end;
    // ��������� ��� ������ 2
    // ������ � ������ 2 ������ �� ������ 1
    Id2 := ObjectTest.InsertUpdateJuridicalGroup(0, 2, '������ 2', Id);
    try
      // ������ ������ ������ � ������ 1 �� ������ 2 � ��������� ������
      try
        ObjectTest.InsertUpdateJuridicalGroup(Id, 1, '������ 1', Id2);
        Check(false, '��� ��������� �� ������');
      except

      end;
      // ��������� ��� ������ 3
      // ������ � ������ 3 ������ �� ������ 2
      Id3 := ObjectTest.InsertUpdateJuridicalGroup(0, 3, '������ 3', Id2);
      try
        // ������ 2 ��� ������ �� ������ 1
        // ������ � ������ 1 ������ �� ������ 3 � ��������� ������
        try
          ObjectTest.InsertUpdateJuridicalGroup(Id, 1, '������ 1', Id3);
          Check(false, '��� ��������� �� ������');
        except

        end;
        Check((GetRecordCount(ObjectTest) = RecordCount + 3), '���������� ������� �� ����������');
      finally
        DeleteObject(Id3);
      end;
    finally
      DeleteObject(Id2);
    end;
  finally
    DeleteObject(Id);
  end;
end;

procedure TDataBaseUsersObjectTest.Juridical_Test;
var Id: integer;
    RecordCount: Integer;
    ObjectTest: TJuridicalTest;
begin
  ObjectTest := TJuridicalTest.Create;
  // ������� ������
  RecordCount := GetRecordCount(ObjectTest);
  // ������� �� ����
  Id := ObjectTest.InsertDefault;
  try
    // ��������� ������ � �� ����
    with ObjectTest.GetRecord(Id) do
      Check((FieldByName('GLNCode').AsString = 'GLNCode'), '�� �������� ������ Id = ' + FieldByName('id').AsString);

  finally
    DeleteObject(Id);
  end;
end;

procedure TDataBaseUsersObjectTest.Contract_Test;
var Id: integer;
    RecordCount: Integer;
    ObjectTest: TContractTest;
begin
  ObjectTest := TContractTest.Create;
  // ������� ������
  RecordCount := GetRecordCount(ObjectTest);
  // ������� �� ����
  Id := ObjectTest.InsertDefault;
  try
    // ��������� ������ � �� ����
    with ObjectTest.GetRecord(Id) do
      Check((FieldByName('InvNumber').AsString = '123456'), '�� �������� ������ Id = ' + FieldByName('id').AsString);

  finally
    DeleteObject(Id);
  end;
end;

{ TContractTest }

constructor TContractTest.Create;
begin
  inherited;
  spInsertUpdate := 'gpInsertUpdate_Object_Contract';
  spSelect := 'gpSelect_Object_Contract';
  spGet := 'gpGet_Object_Contract';
end;

function TContractTest.InsertDefault: integer;
begin
  result := InsertUpdateContract(0, '123456', 'comment');
end;

function TContractTest.InsertUpdateContract(const Id: integer; InvNumber,
  Comment: string): integer;
begin
  FParams.Clear;
  FParams.AddParam('ioId', ftInteger, ptInputOutput, Id);
  FParams.AddParam('inInvNumber', ftString, ptInput, InvNumber);
  FParams.AddParam('inComment', ftString, ptInput, Comment);
  result := InsertUpdate(FParams);
end;

initialization
  TestFramework.RegisterTest('DataBaseUsersObjectTest', TDataBaseUsersObjectTest.Suite);

end.
