INSERT INTO ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_RoleRight_Role(), 'RoleRight_Role', '������ �� ���� � ����������� �������� �����', zc_Object_RoleRight(), zc_Object_Role() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_RoleRight_Role());

INSERT INTO ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_RoleRight_Process(), 'RoleRight_Process', '������ �� ������� � ����������� �������� �����', zc_Object_RoleRight(), zc_Object_Process() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_RoleRight_Process());

INSERT INTO ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_UserRole_Role(), 'UserRole_Role', '������ �� ���� � ����������� ����� ������������� � �����', zc_Object_UserRole(), zc_Object_Role() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_UserRole_Role());

INSERT INTO ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_UserRole_User(), 'UserRole_User', '����� � ������������� � ����������� ����� ������������', zc_Object_UserRole(), zc_Object_User() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_UserRole_User());

INSERT INTO ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_Cash_Currency(), 'Cash_Currency', '����� ����� � �������', zc_Object_Cash(), zc_Object_Currency() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_Cash_Currency());

INSERT INTO ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_Cash_Branch(), 'Cash_Branch', '����� ����� � ��������', zc_Object_Cash(), zc_Object_Branch() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_Cash_Branch());

INSERT INTO ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_JuridicalGroup_Parent(), 'JuridicalGroup_Parent', '����� ������ �� ��� � ������� �� ���', zc_Object_JuridicalGroup(), zc_Object_JuridicalGroup() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_JuridicalGroup_Parent());

INSERT INTO ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_Juridical_JuridicalGroup(), 'Juridical_JuridicalGroup', '����� �� ���� � ������� �� ���', zc_Object_Juridical(), zc_Object_JuridicalGroup() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_Juridical_JuridicalGroup());

INSERT INTO ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_Juridical_GoodsProperty(), 'Juridical_GoodsProperty', '����� �� ���� � ��������������� ������� �������', zc_Object_Juridical(), zc_Object_GoodsProperty() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_Juridical_GoodsProperty());

INSERT INTO ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_Partner_Juridical(), 'Partner_Juridical', '����� ����������� � �� �����', zc_Object_Partner(), zc_Object_Juridical() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_Partner_Juridical());

INSERT INTO ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_Branch_Juridical(), 'Branch_Juridical', '����� ������� � �� �����', zc_Object_Branch(), zc_Object_Juridical() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_Branch_Juridical());

INSERT INTO ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_Unit_Parent(), 'Unit_Parent', '����� ������������� � ��������������', zc_Object_Unit(), zc_Object_Unit() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_Unit_Parent());

INSERT INTO ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_Unit_Branch(), 'Unit_Branch', '����� ������������� � ��������', zc_Object_Unit(), zc_Object_Branch() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_Unit_Branch());

INSERT INTO ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_Bank_Juridical(), 'Bank_Juridical', '����� ����� � �� �����', zc_Object_Bank(), zc_Object_Juridical() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_Bank_Juridical());

INSERT INTO ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_GoodsGroup_Parent(), 'GoodsGroup_Parent', '����� ������ ������� � ������� �������', zc_Object_GoodsGroup(), zc_Object_GoodsGroup() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_GoodsGroup_Parent());

INSERT INTO ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_Goods_Measure(), 'Goods_Measure', '����� ������� � �������� ���������', zc_Object_Goods(), zc_Object_Measure() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_Goods_Measure());

INSERT INTO ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_BankAccount_Juridical(), 'BankAccount_Juridical', '����� ����� � ��. �����', zc_Object_BankAccount(), zc_Object_Juridical() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_BankAccount_Juridical());

INSERT INTO ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_BankAccount_Bank(), 'BankAccount_Bank', '����� ����� ������', zc_Object_BankAccount(), zc_Object_Bank() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_BankAccount_Bank());

INSERT INTO ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_BankAccount_Currency(), 'BankAccount_Currency', '����� ����� � �������', zc_Object_BankAccount(), zc_Object_Currency() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_BankAccount_Currency());

INSERT INTO ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_GoodsPropertyValue_GoodsProperty(), 'GoodsPropertyValue_GoodsProperty', '', zc_Object_GoodsPropertyValue(), zc_Object_GoodsProperty() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_GoodsPropertyValue_GoodsProperty());

INSERT INTO ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_GoodsPropertyValue_Goods(), 'GoodsPropertyValue_Goods', '', zc_Object_GoodsPropertyValue(), zc_Object_Goods() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_GoodsPropertyValue_Goods());

INSERT INTO ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_GoodsPropertyValue_GoodsKind(), 'GoodsPropertyValue_GoodsKind', '', zc_Object_GoodsPropertyValue(), zc_Object_GoodsKind() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_GoodsPropertyValue_GoodsKind());

INSERT INTO ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_Account_AccountGroup(), 'Account_AccountGroup', '', zc_Object_Account(), zc_Object_AccountGroup() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_Account_AccountGroup());

INSERT INTO ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_Account_AccountDirection(), 'Account_AccountDirection', '', zc_Object_Account(), zc_Object_AccountDirection() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_Account_AccountDirection());

INSERT INTO ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_Account_InfoMoneyDestination(), 'Account_InfoMoneyDestination', '', zc_Object_Account(), zc_Object_InfoMoneyDestination() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_Account_InfoMoneyDestination());

INSERT INTO ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_UserFormSettings_Form(), 'UserFormSettings_Form', '', zc_Object_UserFormSettings(), zc_Object_Form() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_UserFormSettings_Form());

INSERT INTO ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_UserFormSettings_User(), 'UserFormSettings_User', '', zc_Object_UserFormSettings(), zc_Object_User() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_UserFormSettings_User());

INSERT INTO ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_PriceListItem_PriceList(), 'PriceListItem_PriceList', '', zc_Object_PriceListItem(), zc_Object_PriceList() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_PriceListItem_PriceList());

INSERT INTO ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_PriceListItem_Goods(), 'PriceListItem_Goods', '', zc_Object_PriceListItem(), zc_Object_Goods() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_PriceListItem_Goods());

INSERT INTO ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_Unit_Business(), 'Unit_Business', '����� ������������� � ��������', zc_Object_Unit(), zc_Object_Business() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_Unit_Business());

INSERT INTO ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_Unit_Juridical(), 'Unit_Juridical', '����� ������������� � �� �����', zc_Object_Unit(), zc_Object_Juridical() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_Unit_Juridical());

INSERT INTO ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_Unit_AccountDirection(), 'Unit_AccountDirection', '����� ������������� � ���������� �������������� ������ - �����������', zc_Object_Unit(), zc_Object_AccountDirection() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_Unit_AccountDirection());

INSERT INTO ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_Unit_ProfitLossDirection(), 'Unit_ProfitLossDirection', '����� ������������� � ���������� �������������� ������ - �����������', zc_Object_Unit(), zc_Object_ProfitLossDirection() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_Unit_ProfitLossDirection());

INSERT INTO ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_Car_CarModel(), 'Car_CarModel', '', zc_Object_Car(), zc_Object_CarModel() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_Car_CarModel());

INSERT INTO ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_Account_InfoMoney(), 'Account_InfoMoney', '����� ����� � �������������� ����������', zc_Object_Account(), zc_Object_InfoMoney() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_Account_InfoMoney());


--------------------------- !!!!!!!!!!!!!!!!!!!
--------------------------- !!! ����� ����� !!!
--------------------------- !!!!!!!!!!!!!!!!!!!


-- !!! ������ ���������������� ���� !!!
DO $$
BEGIN
PERFORM setval('objectlinkdesc_id_seq', (select max (id) + 1 from ObjectLinkDesc));
END $$;

-- INSERT INTO ObjectLinkDesc (Code, ItemName, DescId, ChildObjectDescId)
--   SELECT 'zc_ObjectLink_UnitGroup_Parent', '����� ������ ������������� � ������� �������������', zc_Object_UnitGroup(), zc_Object_UnitGroup() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_UnitGroup_Parent');

INSERT INTO ObjectLinkDesc (Code, ItemName, DescId, ChildObjectDescId)
  SELECT 'zc_ObjectLink_Goods_GoodsGroup', '����� ������� � ������� �������', zc_Object_Goods(), zc_Object_GoodsGroup() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Goods_GoodsGroup');
INSERT INTO ObjectLinkDesc (Code, ItemName, DescId, ChildObjectDescId)
  SELECT 'zc_ObjectLink_Goods_InfoMoney', '����� ������� � �������������� �������', zc_Object_Goods(), zc_Object_InfoMoney() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Goods_InfoMoney');

INSERT INTO ObjectLinkDesc (Code, ItemName, DescId, ChildObjectDescId)
  SELECT 'zc_ObjectLink_InfoMoney_InfoMoneyGroup', '???', zc_Object_InfoMoney(), zc_Object_InfoMoneyGroup() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_InfoMoney_InfoMoneyGroup');
INSERT INTO ObjectLinkDesc (Code, ItemName, DescId, ChildObjectDescId)
  SELECT 'zc_ObjectLink_InfoMoney_InfoMoneyDestination', '???', zc_Object_InfoMoney(), zc_Object_InfoMoneyDestination() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_InfoMoney_InfoMoneyDestination');

INSERT INTO ObjectLinkDesc (Code, ItemName, DescId, ChildObjectDescId)
  SELECT 'zc_ObjectLink_ProfitLoss_ProfitLossGroup', '???', zc_Object_ProfitLoss(), zc_Object_ProfitLossGroup() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_ProfitLoss_ProfitLossGroup');
INSERT INTO ObjectLinkDesc (Code, ItemName, DescId, ChildObjectDescId)
  SELECT 'zc_ObjectLink_ProfitLoss_ProfitLossDirection', '???', zc_Object_ProfitLoss(), zc_Object_ProfitLossDirection() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_ProfitLoss_ProfitLossDirection');
INSERT INTO ObjectLinkDesc (Code, ItemName, DescId, ChildObjectDescId)
  SELECT 'zc_ObjectLink_ProfitLoss_InfoMoneyDestination', '???', zc_Object_ProfitLoss(), zc_Object_InfoMoneyDestination() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_ProfitLoss_InfoMoneyDestination');
INSERT INTO ObjectLinkDesc (Code, ItemName, DescId, ChildObjectDescId)
  SELECT 'zc_ObjectLink_ProfitLoss_InfoMoney', '����� ������ ������ � �������� � ������� � �������������� ����������', zc_Object_ProfitLoss(), zc_Object_InfoMoney() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_ProfitLoss_InfoMoney');


INSERT INTO ObjectLinkDesc (Code, ItemName, DescId, ChildObjectDescId)
  SELECT 'zc_ObjectLink_Personal_Member', '����� ���������� � ���.������', zc_Object_Personal(), zc_Object_Member() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Personal_Member');
INSERT INTO ObjectLinkDesc (Code, ItemName, DescId, ChildObjectDescId)
  SELECT 'zc_ObjectLink_Personal_Position', '����� ���������� � ����������', zc_Object_Personal(), zc_Object_Position() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Personal_Position');
INSERT INTO ObjectLinkDesc (Code, ItemName, DescId, ChildObjectDescId)
  SELECT 'zc_ObjectLink_Personal_Unit', '����� ���������� � ��������������', zc_Object_Personal(), zc_Object_Unit() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Personal_Unit');
INSERT INTO ObjectLinkDesc (Code, ItemName, DescId, ChildObjectDescId)
  SELECT 'zc_ObjectLink_Personal_Juridical', '����� ���������� � ��.�����', zc_Object_Personal(), zc_Object_Juridical() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Personal_Juridical');
INSERT INTO ObjectLinkDesc (Code, ItemName, DescId, ChildObjectDescId)
  SELECT 'zc_ObjectLink_Personal_Business', '����� ���������� � ��������', zc_Object_Personal(), zc_Object_Business() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Personal_Business');


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 28.06.13                                        * ����� �����
*/
