/*INSERT INTO ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
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
*/

INSERT INTO ObjectLinkDesc(Code, ItemName, DescId, ChildObjectDescId)
SELECT 'zc_ObjectLink_RoleRight_Role', '������ �� ���� � ����������� �������� �����', zc_Object_RoleRight(), zc_Object_Role() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_RoleRight_Role');

INSERT INTO ObjectLinkDesc(Code, ItemName, DescId, ChildObjectDescId)
SELECT 'zc_ObjectLink_RoleRight_Process', '������ �� ������� � ����������� �������� �����', zc_Object_RoleRight(), zc_Object_Process() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_RoleRight_Process');

INSERT INTO ObjectLinkDesc(Code, ItemName, DescId, ChildObjectDescId)
SELECT 'zc_ObjectLink_UserRole_Role', '������ �� ���� � ����������� ����� ������������� � �����', zc_Object_UserRole(), zc_Object_Role() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_UserRole_Role');

INSERT INTO ObjectLinkDesc(Code, ItemName, DescId, ChildObjectDescId)
SELECT 'zc_ObjectLink_UserRole_User', '����� � ������������� � ����������� ����� ������������', zc_Object_UserRole(), zc_Object_User() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_UserRole_User');

INSERT INTO ObjectLinkDesc(Code, ItemName, DescId, ChildObjectDescId)
SELECT 'zc_ObjectLink_Cash_Currency', '����� ����� � �������', zc_Object_Cash(), zc_Object_Currency() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Cash_Currency');

INSERT INTO ObjectLinkDesc(Code, ItemName, DescId, ChildObjectDescId)
SELECT 'zc_ObjectLink_Cash_Branch', '����� ����� � ��������', zc_Object_Cash(), zc_Object_Branch() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Cash_Branch');

INSERT INTO ObjectLinkDesc(Code, ItemName, DescId, ChildObjectDescId)
SELECT 'zc_ObjectLink_JuridicalGroup_Parent', '����� ������ �� ��� � ������� �� ���', zc_Object_JuridicalGroup(), zc_Object_JuridicalGroup() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_JuridicalGroup_Parent');

INSERT INTO ObjectLinkDesc(Code, ItemName, DescId, ChildObjectDescId)
SELECT 'zc_ObjectLink_Juridical_JuridicalGroup', '����� �� ���� � ������� �� ���', zc_Object_Juridical(), zc_Object_JuridicalGroup() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Juridical_JuridicalGroup');

INSERT INTO ObjectLinkDesc(Code, ItemName, DescId, ChildObjectDescId)
SELECT 'zc_ObjectLink_Juridical_GoodsProperty', '����� �� ���� � ��������������� ������� �������', zc_Object_Juridical(), zc_Object_GoodsProperty() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Juridical_GoodsProperty');

INSERT INTO ObjectLinkDesc(Code, ItemName, DescId, ChildObjectDescId)
SELECT 'zc_ObjectLink_Partner_Juridical', '����� ����������� � �� �����', zc_Object_Partner(), zc_Object_Juridical() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Partner_Juridical');

INSERT INTO ObjectLinkDesc(Code, ItemName, DescId, ChildObjectDescId)
SELECT 'zc_ObjectLink_Unit_Parent', '����� ������������� � ��������������', zc_Object_Unit(), zc_Object_Unit() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Unit_Parent');

INSERT INTO ObjectLinkDesc(Code, ItemName, DescId, ChildObjectDescId)
SELECT 'zc_ObjectLink_Unit_Branch', '����� ������������� � ��������', zc_Object_Unit(), zc_Object_Branch() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Unit_Branch');

INSERT INTO ObjectLinkDesc(Code, ItemName, DescId, ChildObjectDescId)
SELECT 'zc_ObjectLink_Bank_Juridical', '����� ����� � �� �����', zc_Object_Bank(), zc_Object_Juridical() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Bank_Juridical');

INSERT INTO ObjectLinkDesc(Code, ItemName, DescId, ChildObjectDescId)
SELECT 'zc_ObjectLink_GoodsGroup_Parent', '����� ������ ������� � ������� �������', zc_Object_GoodsGroup(), zc_Object_GoodsGroup() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_GoodsGroup_Parent');

INSERT INTO ObjectLinkDesc(Code, ItemName, DescId, ChildObjectDescId)
SELECT 'zc_ObjectLink_Goods_Measure', '����� ������� � �������� ���������', zc_Object_Goods(), zc_Object_Measure() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Goods_Measure');

INSERT INTO ObjectLinkDesc(Code, ItemName, DescId, ChildObjectDescId)
SELECT 'zc_ObjectLink_BankAccount_Juridical', '����� ����� � ��. �����', zc_Object_BankAccount(), zc_Object_Juridical() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_BankAccount_Juridical');

INSERT INTO ObjectLinkDesc(Code, ItemName, DescId, ChildObjectDescId)
SELECT 'zc_ObjectLink_BankAccount_Bank', '����� ����� ������', zc_Object_BankAccount(), zc_Object_Bank() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_BankAccount_Bank');

INSERT INTO ObjectLinkDesc(Code, ItemName, DescId, ChildObjectDescId)
SELECT 'zc_ObjectLink_BankAccount_Currency', '����� ����� � �������', zc_Object_BankAccount(), zc_Object_Currency() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_BankAccount_Currency');

INSERT INTO ObjectLinkDesc(Code, ItemName, DescId, ChildObjectDescId)
SELECT 'zc_ObjectLink_GoodsPropertyValue_GoodsProperty', '', zc_Object_GoodsPropertyValue(), zc_Object_GoodsProperty() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_GoodsPropertyValue_GoodsProperty');

INSERT INTO ObjectLinkDesc(Code, ItemName, DescId, ChildObjectDescId)
SELECT 'zc_ObjectLink_GoodsPropertyValue_Goods', '', zc_Object_GoodsPropertyValue(), zc_Object_Goods() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_GoodsPropertyValue_Goods');

INSERT INTO ObjectLinkDesc(Code, ItemName, DescId, ChildObjectDescId)
SELECT 'zc_ObjectLink_GoodsPropertyValue_GoodsKind', '', zc_Object_GoodsPropertyValue(), zc_Object_GoodsKind() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_GoodsPropertyValue_GoodsKind');

INSERT INTO ObjectLinkDesc(Code, ItemName, DescId, ChildObjectDescId)
SELECT 'zc_ObjectLink_Account_AccountGroup', '', zc_Object_Account(), zc_Object_AccountGroup() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Account_AccountGroup');

INSERT INTO ObjectLinkDesc(Code, ItemName, DescId, ChildObjectDescId)
SELECT 'zc_ObjectLink_Account_AccountDirection', '', zc_Object_Account(), zc_Object_AccountDirection() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Account_AccountDirection');

INSERT INTO ObjectLinkDesc(Code, ItemName, DescId, ChildObjectDescId)
SELECT 'zc_ObjectLink_Account_InfoMoneyDestination', '', zc_Object_Account(), zc_Object_InfoMoneyDestination() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Account_InfoMoneyDestination');

INSERT INTO ObjectLinkDesc(Code, ItemName, DescId, ChildObjectDescId)
SELECT 'zc_ObjectLink_UserFormSettings_Form', '', zc_Object_UserFormSettings(), zc_Object_Form() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_UserFormSettings_Form');

INSERT INTO ObjectLinkDesc(Code, ItemName, DescId, ChildObjectDescId)
SELECT 'zc_ObjectLink_UserFormSettings_User', '', zc_Object_UserFormSettings(), zc_Object_User() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_UserFormSettings_User');

INSERT INTO ObjectLinkDesc(Code, ItemName, DescId, ChildObjectDescId)
SELECT 'zc_ObjectLink_PriceListItem_PriceList', '', zc_Object_PriceListItem(), zc_Object_PriceList() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_PriceListItem_PriceList');

INSERT INTO ObjectLinkDesc(Code, ItemName, DescId, ChildObjectDescId)
SELECT 'zc_ObjectLink_PriceListItem_Goods', '', zc_Object_PriceListItem(), zc_Object_Goods() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_PriceListItem_Goods');

INSERT INTO ObjectLinkDesc(Code, ItemName, DescId, ChildObjectDescId)
SELECT 'zc_ObjectLink_Unit_Business', '����� ������������� � ��������', zc_Object_Unit(), zc_Object_Business() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Unit_Business');

INSERT INTO ObjectLinkDesc(Code, ItemName, DescId, ChildObjectDescId)
SELECT 'zc_ObjectLink_Unit_Juridical', '����� ������������� � �� �����', zc_Object_Unit(), zc_Object_Juridical() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Unit_Juridical');

INSERT INTO ObjectLinkDesc(Code, ItemName, DescId, ChildObjectDescId)
SELECT 'zc_ObjectLink_Unit_AccountDirection', '����� ������������� � ���������� �������������� ������ - �����������', zc_Object_Unit(), zc_Object_AccountDirection() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Unit_AccountDirection');

INSERT INTO ObjectLinkDesc(Code, ItemName, DescId, ChildObjectDescId)
SELECT 'zc_ObjectLink_Unit_ProfitLossDirection', '����� ������������� � ���������� �������������� ������ - �����������', zc_Object_Unit(), zc_Object_ProfitLossDirection() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Unit_ProfitLossDirection');

INSERT INTO ObjectLinkDesc(Code, ItemName, DescId, ChildObjectDescId)
SELECT 'zc_ObjectLink_Car_CarModel', '����� ������ � ������ ����������', zc_Object_Car(), zc_Object_CarModel() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Car_CarModel');

INSERT INTO ObjectLinkDesc(Code, ItemName, DescId, ChildObjectDescId)
SELECT 'zc_ObjectLink_Account_InfoMoney', '����� ����� � �������������� ����������', zc_Object_Account(), zc_Object_InfoMoney() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Account_InfoMoney');


-- INSERT INTO ObjectLinkDesc (Code, ItemName, DescId, ChildObjectDescId)
--   SELECT 'zc_ObjectLink_UnitGroup_Parent', '����� ������ ������������� � ������� �������������', zc_Object_UnitGroup(), zc_Object_UnitGroup() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_UnitGroup_Parent');

INSERT INTO ObjectLinkDesc (Code, ItemName, DescId, ChildObjectDescId)
  SELECT 'zc_ObjectLink_Goods_GoodsGroup', '����� ������� � ������� �������', zc_Object_Goods(), zc_Object_GoodsGroup() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Goods_GoodsGroup');
INSERT INTO ObjectLinkDesc (Code, ItemName, DescId, ChildObjectDescId)
  SELECT 'zc_ObjectLink_Goods_InfoMoney', '����� ������� � �������������� �������', zc_Object_Goods(), zc_Object_InfoMoney() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Goods_InfoMoney');
INSERT INTO ObjectLinkDesc (Code, ItemName, DescId, ChildObjectDescId)
  SELECT 'zc_ObjectLink_Goods_TradeMark', '����� ������� � �������� ������', zc_Object_Goods(), zc_Object_TradeMark() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Goods_TradeMark');


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
INSERT INTO ObjectLinkDesc (Code, ItemName, DescId, ChildObjectDescId)
  SELECT 'zc_ObjectLink_AssetGroup_Parent', '����� � �������  �������� �������', zc_Object_AssetGroup(), zc_Object_AssetGroup() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_AssetGroup_Parent');
INSERT INTO ObjectLinkDesc (Code, ItemName, DescId, ChildObjectDescId)
  SELECT 'zc_ObjectLink_Asset_AssetGroup', '����� �������� ������� � ������� �������� �������', zc_Object_Asset(), zc_Object_AssetGroup() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Asset_AssetGroup');
INSERT INTO ObjectLinkDesc (Code, ItemName, DescId, ChildObjectDescId)
  SELECT 'zc_ObjectLink_PartionGoods_Partner', '����� ������ � ������������', zc_Object_PartionGoods(), zc_Object_Partner() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_PartionGoods_Partner');
INSERT INTO ObjectLinkDesc (Code, ItemName, DescId, ChildObjectDescId)
  SELECT 'zc_ObjectLink_PartionGoods_Goods', '����� ������ � �������', zc_Object_PartionGoods(), zc_Object_Goods() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_PartionGoods_Goods');

INSERT INTO ObjectLinkDesc (Code, ItemName, DescId, ChildObjectDescId)
  SELECT 'zc_ObjectLink_Partner_Route', '����� ����������� � ���������', zc_Object_Partner(), zc_Object_Route() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Partner_Route');
INSERT INTO ObjectLinkDesc (Code, ItemName, DescId, ChildObjectDescId)
  SELECT 'zc_ObjectLink_Partner_RouteSorting', '����� ����������� � ����������� ��������', zc_Object_Partner(), zc_Object_RouteSorting() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Partner_RouteSorting');
INSERT INTO ObjectLinkDesc (Code, ItemName, DescId, ChildObjectDescId)
  SELECT 'zc_ObjectLink_Juridical_InfoMoney', '����� ����������� � ��������������� �����������', zc_Object_Juridical(), zc_Object_InfoMoney() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Juridical_InfoMoney');
INSERT INTO ObjectLinkDesc (Code, ItemName, DescId, ChildObjectDescId)
  SELECT 'zc_ObjectLink_Account_AccountKind', '����� ����� � ����� ������', zc_Object_Account(), zc_Object_AccountKind() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Code = 'zc_ObjectLink_Account_AccountKind');
  

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 07.07.13         * ������� �� ����� �����              
 28.06.13                                        * ����� �����
*/
