unit dbObjectTest;

interface
uses TestFramework, Authentication, ZConnection, ZDataset, ZStoredProcedure,
     Db, XMLIntf, dsdDB;

type

  TObjectTest = class
  private
    FspInsertUpdate: string;
    FspSelect: string;
    FspGet: string;
    FdsdStoredProc: TdsdStoredProc;
  protected
    FParams: TdsdParams;
    property spGet: string read FspGet write FspGet;
    property spSelect: string read FspSelect write FspSelect;
    property spInsertUpdate: string read FspInsertUpdate write FspInsertUpdate;
    function InsertUpdate(dsdParams: TdsdParams): Integer;
    function InsertDefault: integer; virtual; abstract;
  public
    function GetDefault: integer;
    function GetDataSet: TDataSet;
    function GetRecord(Id: integer): TDataSet;
    constructor Create; virtual;
    destructor Destoy;
  end;

  TdbObjectTest = class (TTestCase)
  protected
    // �������� �������
    procedure DeleteObject(Id: integer);
    // ��������� ���������� �������
    function GetRecordCount(ObjectTest: TObjectTest): integer;
    // �������������� ������ ��� ������������
    procedure SetUp; override;
    // ���������� ������ ��� ������������
    procedure TearDown; override;
  published
    procedure User_Test;
    procedure Cash_Test;
    procedure JuridicalGroup_Test;
    procedure Juridical_Test;
    procedure Contract_Test;
    procedure Goods_Test;
  end;

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

  TCurrencyTest = class(TObjectTest)
  private
    function InsertDefault: integer; override;
  public
    constructor Create; override;
  end;

  TUserTest = class(TObjectTest)
  private
    function InsertDefault: integer; override;
  public
    function InsertUpdateUser(const Id: integer; UserName, Login, Password: string): integer;
    constructor Create; override;
  end;

  TCashTest = class(TObjectTest)
    function InsertDefault: integer; override;
  public
    function InsertUpdateCash(const Id: integer; CashName: string; CurrencyId: Integer; BranchId: integer): integer;
    constructor Create; override;
  end;

  TGoodsTest = class(TObjectTest)
    function InsertDefault: integer; override;
  public
    function InsertUpdateGoods(Id, Code: Integer; Name: String;
                               GoodsGroupId, MeasureId: Integer; Weight: Double): integer;
    constructor Create; override;
  end;

implementation

uses ZDbcIntfs, SysUtils, Storage, DBClient, XMLDoc, CommonData, Forms,
     Classes, UtilConvert, ZLibEx;


{ TObjectTest }

constructor TObjectTest.Create;
begin
  FdsdStoredProc := TdsdStoredProc.Create(nil);
  FParams := TdsdParams.Create(TdsdParam);
end;

destructor TObjectTest.Destoy;
begin
  FdsdStoredProc.Free
end;

function TObjectTest.GetDataSet: TDataSet;
begin
  with FdsdStoredProc do begin
    if (DataSets.Count = 0) or not Assigned(DataSets[0].DataSet) then
       DataSets.Add.DataSet := TClientDataSet.Create(nil);
    StoredProcName := FspSelect;
    OutputType := otDataSet;
    Params.Clear;
    Execute;
    result := DataSets[0].DataSet;
  end;
end;

function TObjectTest.GetDefault: integer;
begin
  if GetDataSet.RecordCount > 0 then
     result := GetDataSet.FieldByName('Id').AsInteger
  else
     result := InsertDefault;
end;

function TObjectTest.GetRecord(Id: integer): TDataSet;
begin
  with FdsdStoredProc do begin
    DataSets.Add.DataSet := TClientDataSet.Create(nil);
    StoredProcName := FspGet;
    OutputType := otDataSet;
    Params.Clear;
    Params.AddParam('ioId', ftInteger, ptInputOutput, Id);
    Execute;
    result := DataSets[0].DataSet;
  end;
end;

function TObjectTest.InsertUpdate(dsdParams: TdsdParams): Integer;
begin
  with FdsdStoredProc do begin
    StoredProcName := FspInsertUpdate;
    OutputType := otResult;
    Params.Assign(dsdParams);
    Execute;
    Result := StrToInt(ParamByName('ioId').Value);
  end;
end;

{ TDataBaseObjectTest }
{------------------------------------------------------------------------------}
procedure TdbObjectTest.Cash_Test;
var Id: integer;
    RecordCount: Integer;
    ObjectTest: TCashTest;
begin
  ObjectTest := TCashTest.Create;
  // ������� ������
  RecordCount := GetRecordCount(ObjectTest);
  // ������� �����
  Id := ObjectTest.InsertDefault;
  try
    // ��������� ������ � �����
    with ObjectTest.GetRecord(Id) do
      Check((FieldByName('name').AsString = '������� �����'), '�� �������� ������ Id = ' + FieldByName('id').AsString);

    // ������� ������ ����
    Check((GetRecordCount(ObjectTest) = RecordCount + 1), '���������� ������� �� ����������');
  finally
    DeleteObject(Id);
  end;
end;

procedure TdbObjectTest.DeleteObject(Id: integer);
const
   pXML =
  '<xml Session = "">' +
    '<lpDelete_Object OutputType="otResult">' +
       '<inId DataType="ftInteger" Value="%d"/>' +
    '</lpDelete_Object>' +
  '</xml>';
begin
  TStorageFactory.GetStorage.ExecuteProc(Format(pXML, [Id]))
end;
{------------------------------------------------------------------------------}
function TdbObjectTest.GetRecordCount(ObjectTest: TObjectTest): integer;
begin
  Result := ObjectTest.GetDataSet.RecordCount;
end;
{------------------------------------------------------------------------------}
procedure TdbObjectTest.Goods_Test;
var Id: integer;
    RecordCount: Integer;
    ObjectTest: TGoodsTest;
begin
  ObjectTest := TGoodsTest.Create;
  // ������� ������
  RecordCount := GetRecordCount(ObjectTest);
  // ������� �������
  Id := ObjectTest.InsertDefault;
  try
    // ��������� ������ � �� ����
    with ObjectTest.GetRecord(Id) do
      Check((FieldByName('Name').AsString = '����� 1'), '�� �������� ������ Id = ' + FieldByName('id').AsString);

  finally
    DeleteObject(Id);
  end;
end;
{------------------------------------------------------------------------------}
procedure TdbObjectTest.User_Test;
var Id: integer;
    RecordCount: Integer;
    ObjectTest: TUserTest;
begin
  ObjectTest := TUserTest.Create;
  // ������� ������ �������������
  RecordCount := GetRecordCount(ObjectTest);
  // ������� ������������
  Id := ObjectTest.InsertDefault;
  try
    // ��������� ������ � ������������
    with ObjectTest.GetRecord(Id) do
      Check((FieldByName('name').AsString = 'UserName'), '�� �������� ������ Id = ' + FieldByName('id').AsString);
    // �������� �� �������������
    try
      ObjectTest.InsertUpdateUser(0, 'UserName', 'Login', 'Password');
      Check(false, '��� ��������� �� ������ InsertUpdate_Object_User Id=0');
    except

    end;
    // ��������� ������������

    // ������� ������ �������������
    Check((GetRecordCount(ObjectTest) = RecordCount + 1), '���������� ������� �� ����������');
  finally
    DeleteObject(Id);
  end;
end;
{------------------------------------------------------------------------------}
procedure TdbObjectTest.TearDown;
begin
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TdbObjectTest.SetUp;
begin
  inherited;
  TAuthentication.CheckLogin(TStorageFactory.GetStorage, '�����', '�����', gc_User);
end;
{------------------------------------------------------------------------------}

{ TCurrencyTest }

constructor TCurrencyTest.Create;
begin
  inherited;
  spInsertUpdate := 'gpInsertUpdate_Object_Currency';
  spSelect := 'gpSelect_Object_Currency';
  spGet := 'gpGet_Object_Currency';
end;

function TCurrencyTest.InsertDefault: integer;
begin
  FParams.Clear;
  FParams.AddParam('ioId', ftInteger, ptInputOutput, 0);
  FParams.AddParam('inCurrencyCode', ftInteger, ptInput, 920);
  FParams.AddParam('inCurrencyName', ftString, ptInput, 'GRN');
  FParams.AddParam('inFullName', ftString, ptInput, '������');
  result := InsertUpdate(FParams);
end;

{ TUserTest }

constructor TUserTest.Create;
begin
  inherited Create;
  spInsertUpdate := 'gpInsertUpdate_Object_User';
  spSelect := 'gpSelect_Object_User';
  spGet := 'gpGet_Object_User';
end;

function TUserTest.InsertDefault: integer;
begin
  result := InsertUpdateUser(0, 'UserName', 'Login', 'Password');
end;

function TUserTest.InsertUpdateUser(const Id: integer; UserName, Login, Password: string): integer;
begin
  FParams.Clear;
  FParams.AddParam('ioId', ftInteger, ptInputOutput, Id);
  FParams.AddParam('inUserName', ftString, ptInput, UserName);
  FParams.AddParam('inLogin', ftString, ptInput, Login);
  FParams.AddParam('inPassword', ftString, ptInput, Password);
  result := InsertUpdate(FParams);
end;

{ TCashTest }

constructor TCashTest.Create;
begin
  inherited Create;
  spInsertUpdate := 'gpInsertUpdate_Object_Cash';
  spSelect := 'gpSelect_Object_Cash';
  spGet := 'gpGet_Object_Cash';
end;

function TCashTest.InsertDefault: integer;
var CurrencyId: Integer;
begin
  with TCurrencyTest.Create do
  try
    CurrencyId := GetDefault
  finally
    Free;
  end;
  result := InsertUpdateCash(0, '������� �����', CurrencyId, 0);
end;

function TCashTest.InsertUpdateCash(const Id: integer; CashName: string;
  CurrencyId, BranchId: Integer): integer;
begin
  FParams.Clear;
  FParams.AddParam('ioId', ftInteger, ptInputOutput, Id);
  FParams.AddParam('inCashName', ftString, ptInput, CashName);
  FParams.AddParam('inCurrencyId', ftInteger, ptInput, CurrencyId);
  FParams.AddParam('inCurrencyId', ftInteger, ptInput, BranchId);
  result := InsertUpdate(FParams);


end;


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

procedure TdbObjectTest.JuridicalGroup_Test;
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

procedure TdbObjectTest.Juridical_Test;
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
    DeleteObject(TJuridicalGroupTest.Create.GetDefault);
  end;
end;

procedure TdbObjectTest.Contract_Test;
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


{ TGoodsTest }

constructor TGoodsTest.Create;
begin
  inherited;
  spInsertUpdate := 'gpInsertUpdate_Object_Goods';
  spSelect := 'gpSelect_Object_Goods';
  spGet := 'gpGet_Object_Goods';
end;

function TGoodsTest.InsertDefault: integer;
begin
  result := InsertUpdateGoods(0, 1, '����� 1 ', 0, 0, 1.0)
end;

function TGoodsTest.InsertUpdateGoods(Id, Code: Integer; Name: String;
  GoodsGroupId, MeasureId: Integer; Weight: Double): integer;
begin
  FParams.Clear;
  FParams.AddParam('ioId', ftInteger, ptInputOutput, Id);
  FParams.AddParam('inCode', ftInteger, ptInput, Code);
  FParams.AddParam('inName', ftString, ptInput, Name);
  FParams.AddParam('inGoodsGroupId', ftInteger, ptInput, GoodsGroupId);
  FParams.AddParam('inMeasureId', ftInteger, ptInput, MeasureId);
  FParams.AddParam('inWeight', ftFloat, ptInput, Weight);
  result := InsertUpdate(FParams);
end;

initialization
  TestFramework.RegisterTest('�����������', TdbObjectTest.Suite);

end.
