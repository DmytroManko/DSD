unit LoadFormTest;

interface

uses
  TestFramework, Forms;

type

  TLoadFormTest = class (TTestCase)
  private
    function GetForm(FormClass: string): TForm;
  protected
    // �������������� ������ ��� ������������
    procedure SetUp; override;
    // ���������� ������ ��� ������������
    procedure TearDown; override;
  published
    procedure UserFormSettingsTest;
    procedure LoadBankFormTest;
    procedure LoadBankAccountFormTest;
    procedure LoadJuridicalGroupFormTest;
    procedure LoadJuridicalFormTest;
    procedure LoadPartnerFormTest;
    procedure LoadPaidKindFormTest;
    procedure LoadContractKindFormTest;
    procedure LoadContractFormTest;
    procedure LoadBusinessFormTest;
    procedure LoadBranchFormTest;
    procedure LoadUnitGroupFormTest;
    procedure LoadUnitFormTest;
    procedure LoadGoodsGroupFormTest;
    procedure LoadGoodsFormTest;
    procedure LoadGoodsKindFormTest;
    procedure LoadMeasureFormTest;
    procedure LoadPriceListFormTest;
    procedure LoadGoodsPropertyFormTest;
    procedure LoadGoodsPropertyValueFormTest;
    procedure LoadCashFormTest;
    procedure LoadCurrencyFormTest;
    procedure LoadIncomeFormTest;
    procedure LoadReportFormTest;
    procedure LoadInfoMoneyGroupFormTest;
    procedure LoadInfoMoneyDestinationFormTest;
    procedure LoadInfoMoneyFormTest;
    procedure LoadAccountFormTest;
    procedure LoadAccountGroupFormTest;
    procedure LoadAccountDirectionFormTest;
    procedure LoadProfitLossFormTest;
    procedure LoadProfitLossGroupFormTest;
    procedure LoadProfitLossDirectionFormTest;
    procedure LoadTradeMarkFormTest;
    procedure LoadAssetFormTest;
    procedure LoadRouteFormTest;
    procedure LoadRouteSortingFormTest;
    procedure LoadMemberFormTest;
    procedure LoadPositionFormTest;
    procedure LoadPersonalFormTest;
    procedure LoadCarFormTest;
    procedure LoadCarModelFormTest;
  end;

implementation

uses CommonData, Storage, FormStorage, Classes,
     Authentication, SysUtils, cxPropertiesStore, cxStorage;

{ TLoadFormTest }

function TLoadFormTest.GetForm(FormClass: string): TForm;
begin
  if GetClass(FormClass) = nil then
     raise Exception.Create('�� ��������������� �����: ' + FormClass);
  Application.CreateForm(TComponentClass(GetClass(FormClass)), Result);
end;

procedure TLoadFormTest.LoadBankAccountFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TBankAccountForm'));
  TdsdFormStorageFactory.GetStorage.Load('TBankAccountForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TBankAccountEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TBankAccountEditForm');
end;

procedure TLoadFormTest.LoadBankFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TBankForm'));
  TdsdFormStorageFactory.GetStorage.Load('TBankForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TBankEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TBankEditForm');
end;

procedure TLoadFormTest.LoadBranchFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TBranchForm'));
  TdsdFormStorageFactory.GetStorage.Load('TBranchForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TBranchEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TBranchEditForm');
end;

procedure TLoadFormTest.LoadBusinessFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TBusinessForm'));
  TdsdFormStorageFactory.GetStorage.Load('TBusinessForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TBusinessEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TBusinessEditForm');
end;

procedure TLoadFormTest.LoadCashFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TCashForm'));
  TdsdFormStorageFactory.GetStorage.Load('TCashForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TCashEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TCashEditForm');
end;

procedure TLoadFormTest.LoadContractFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TContractForm'));
  TdsdFormStorageFactory.GetStorage.Load('TContractForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TContractEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TContractEditForm');
end;

procedure TLoadFormTest.LoadContractKindFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TContractKindForm'));
  TdsdFormStorageFactory.GetStorage.Load('TContractKindForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TContractKindEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TContractKindEditForm');
end;

procedure TLoadFormTest.LoadCurrencyFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TCurrencyForm'));
  TdsdFormStorageFactory.GetStorage.Load('TCurrencyForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TCurrencyEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TCurrencyEditForm');
end;

procedure TLoadFormTest.LoadGoodsFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TGoodsForm'));
  TdsdFormStorageFactory.GetStorage.Load('TGoodsForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TGoodsEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TGoodsEditForm');
end;

procedure TLoadFormTest.LoadGoodsGroupFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TGoodsGroupForm'));
  TdsdFormStorageFactory.GetStorage.Load('TGoodsGroupForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TGoodsGroupEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TGoodsGroupEditForm');
end;

procedure TLoadFormTest.LoadGoodsKindFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TGoodsKindForm'));
  TdsdFormStorageFactory.GetStorage.Load('TGoodsKindForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TGoodsKindEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TGoodsKindEditForm');
end;

procedure TLoadFormTest.LoadGoodsPropertyFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TGoodsPropertyForm'));
  TdsdFormStorageFactory.GetStorage.Load('TGoodsPropertyForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TGoodsPropertyEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TGoodsPropertyEditForm');
end;

procedure TLoadFormTest.LoadGoodsPropertyValueFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TGoodsPropertyValueForm'));
  TdsdFormStorageFactory.GetStorage.Load('TGoodsPropertyValueForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TGoodsPropertyValueEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TGoodsPropertyValueEditForm');
end;

procedure TLoadFormTest.LoadIncomeFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TIncomeForm'));
  TdsdFormStorageFactory.GetStorage.Load('TIncomeForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TIncomeJournalForm'));
  TdsdFormStorageFactory.GetStorage.Load('TIncomeJournalForm');
end;

procedure TLoadFormTest.LoadJuridicalFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TJuridicalForm'));
  TdsdFormStorageFactory.GetStorage.Load('TJuridicalForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TJuridicalEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TJuridicalEditForm');
end;

procedure TLoadFormTest.LoadJuridicalGroupFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TJuridicalGroupForm'));
  TdsdFormStorageFactory.GetStorage.Load('TJuridicalGroupForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TJuridicalGroupEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TJuridicalGroupEditForm');
end;

procedure TLoadFormTest.LoadMeasureFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMeasureForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMeasureForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMeasureEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMeasureEditForm');
end;

procedure TLoadFormTest.LoadPaidKindFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPaidKindForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPaidKindForm');
end;

procedure TLoadFormTest.LoadPartnerFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPartnerForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPartnerForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPartnerEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPartnerEditForm');
end;

procedure TLoadFormTest.LoadPriceListFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPriceListForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPriceListForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPriceListEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPriceListEditForm');
end;

procedure TLoadFormTest.LoadReportFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TBalanceForm'));
  TdsdFormStorageFactory.GetStorage.Load('TBalanceForm');
end;

procedure TLoadFormTest.LoadUnitFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TUnitForm'));
  TdsdFormStorageFactory.GetStorage.Load('TUnitForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TUnitEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TUnitEditForm');
end;

procedure TLoadFormTest.LoadUnitGroupFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TUnitGroupForm'));
  TdsdFormStorageFactory.GetStorage.Load('TUnitGroupForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TUnitGroupEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TUnitGroupEditForm');
end;


procedure TLoadFormTest.LoadInfoMoneyGroupFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TInfoMoneyGroupForm'));
  TdsdFormStorageFactory.GetStorage.Load('TInfoMoneyGroupForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TInfoMoneyGroupEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TInfoMoneyGroupEditForm');
end;


procedure TLoadFormTest.LoadInfoMoneyDestinationFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TInfoMoneyDestinationForm'));
  TdsdFormStorageFactory.GetStorage.Load('TInfoMoneyDestinationForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TInfoMoneyDestinationEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TInfoMoneyDestinationEditForm');
end;

   procedure TLoadFormTest.LoadInfoMoneyFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TInfoMoneyForm'));
  TdsdFormStorageFactory.GetStorage.Load('TInfoMoneyForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TInfoMoneyEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TInfoMoneyEditForm');
end;

procedure TLoadFormTest.LoadAccountGroupFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TAccountGroupForm'));
  TdsdFormStorageFactory.GetStorage.Load('TAccountGroupForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TAccountGroupEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TAccountGroupEditForm');
end;


procedure TLoadFormTest.LoadAccountDirectionFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TAccountDirectionForm'));
  TdsdFormStorageFactory.GetStorage.Load('TAccountDirectionForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TAccountDirectionEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TAccountDirectionEditForm');
end;

procedure TLoadFormTest.LoadAccountFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TAccountForm'));
  TdsdFormStorageFactory.GetStorage.Load('TAccountForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TAccountEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TAccountEditForm');
end;

procedure TLoadFormTest.LoadProfitLossGroupFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TProfitLossGroupForm'));
  TdsdFormStorageFactory.GetStorage.Load('TProfitLossGroupForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TProfitLossGroupEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TProfitLossGroupEditForm');
end;

procedure TLoadFormTest.LoadProfitLossDirectionFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TProfitLossDirectionForm'));
  TdsdFormStorageFactory.GetStorage.Load('TProfitLossDirectionForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TProfitLossDirectionEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TProfitLossDirectionEditForm');
end;

procedure TLoadFormTest.LoadProfitLossFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TProfitLossForm'));
  TdsdFormStorageFactory.GetStorage.Load('TProfitLossForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TProfitLossEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TProfitLossEditForm');
end;
procedure TLoadFormTest.LoadTradeMarkFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TTradeMarkForm'));
  TdsdFormStorageFactory.GetStorage.Load('TTradeMarkForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TTradeMarkEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TTradeMarkEditForm');
end;
procedure TLoadFormTest.LoadAssetFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TAssetForm'));
  TdsdFormStorageFactory.GetStorage.Load('TAssetForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TAssetEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TAssetEditForm');
end;

procedure TLoadFormTest.LoadRouteFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TRouteForm'));
  TdsdFormStorageFactory.GetStorage.Load('TRouteForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TRouteEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TRouteEditForm');
end;

procedure TLoadFormTest.LoadRouteSortingFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TRouteSortingForm'));
  TdsdFormStorageFactory.GetStorage.Load('TRouteSortingForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TRouteSortingEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TRouteSortingEditForm');
end;

procedure TLoadFormTest.LoadMemberFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMemberForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMemberForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMemberEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMemberEditForm');
end;

procedure TLoadFormTest.LoadPositionFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPositionForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPositionForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPositionEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPositionEditForm');
end;

procedure TLoadFormTest.LoadPersonalFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPersonalForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPersonalForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPersonalEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPersonalEditForm');
end;
procedure TLoadFormTest.LoadCarFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TCarForm'));
  TdsdFormStorageFactory.GetStorage.Load('TCarForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TCarEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TCarEditForm');
end;

procedure TLoadFormTest.LoadCarModelFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TCarModelForm'));
  TdsdFormStorageFactory.GetStorage.Load('TCarModelForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TCarModelEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TCarModelEditForm');
end;


procedure TLoadFormTest.SetUp;
begin
  inherited;
  TAuthentication.CheckLogin(TStorageFactory.GetStorage, '�����', '�����', gc_User);
end;

procedure TLoadFormTest.TearDown;
begin
  inherited;

end;


procedure TLoadFormTest.UserFormSettingsTest;
var Form: TForm;
begin


end;

initialization
  TestFramework.RegisterTest('�������� ����', TLoadFormTest.Suite);


end.
