insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_Process(), 'Process', '��������' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_Process());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_Role(), 'Role', '����' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_Role());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_object_user(), 'User', '������������' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_object_user());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_RoleRight(), 'RoleRight', '��������� ���� �� ����' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_RoleRight());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_UserRole(), 'UserRole', '����� ������������� � �����' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_UserRole());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_Goods(), 'Goods', '���������� �������' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_Goods());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_Unit(), 'Unit', '���������� �������������' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_Unit());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_Form(), 'Form', '����� ����������' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_Form());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_Measure(), 'Measure', '������� ���������' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_Measure());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_Cash(), 'Cash', '�����' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_Cash());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_AccountPlan(), 'AccountPlan', '���� ������' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_AccountPlan());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_Status(), 'Status', '������� ����������' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_Status());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_Currency(), 'Currency', '������' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_Currency());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_PaidKind(), 'PaidKind', '����� �����' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_PaidKind());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_Branch(), 'Branch', '�������' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_Branch());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_JuridicalGroup(), 'JuridicalGroup', '������ ��. ���' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_JuridicalGroup());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_Juridical(), 'Juridical', '�� ����' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_Juridical());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_GoodsProperty(), 'GoodsProperty', '�������������� ������� �������' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_GoodsProperty());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_Partner(), 'Partner', '����������' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_Partner());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_ContractKind(), 'ContractKind', '���� ���������' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_ContractKind());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_Business(), 'Business', '�������' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_Business());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_UnitGroup(), 'UnitGroup', '������ ��������������' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_UnitGroup());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_GoodsGroup(), 'GoodsGroup', '������ �������' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_GoodsGroup());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_Bank(), 'Bank', '�����' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_Bank());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_GoodsKind(), 'GoodsKind', '��� ������' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_GoodsKind());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_BankAccount(), 'BankAccount', '��������� ����' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_BankAccount());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_PriceList(), 'PriceList', '�����-����' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_PriceList());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_Contract(), 'Contract', '��������' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_Contract());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_CarModel(), 'CarModel', '������ ����������' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_CarModel());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_Car(), 'Car', '����������' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_Car());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_GoodsPropertyValue(), 'GoodsPropertyValue', '' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_GoodsPropertyValue());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_AccountGroup(), 'AccountGroup', '������ ������' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_AccountGroup());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_AccountDirection(), 'AccountDirection', '��������� ����� (�����)' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_AccountDirection());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_Account(), 'Account', '����' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_Account());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_InfoMoneyGroup(), 'InfoMoneyGroup', '������ �������������� ������' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_InfoMoneyGroup());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_InfoMoneyDestination(), 'InfoMoneyDestination', '�����������' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_InfoMoneyDestination());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_InfoMoney(), 'InfoMoney', '�������������� ������' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_InfoMoney());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_ProfitLossGroup(), 'ProfitLossGroup', '������ ������ �� ��������' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_ProfitLossGroup());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_ProfitLossDirection(), 'ProfitLossDirection', '������ ������ �� ��������' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_ProfitLossDirection());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_ProfitLoss(), 'ProfitLoss', '������ �� ��������' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_ProfitLoss());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_Route(), 'Route', '��������' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_Route());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_RouteSorting(), 'RouteSorting', '���������� ���������' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_RouteSorting());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_UserFormSettings(), 'UserFormSettings', '���������������� ���������' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_UserFormSettings());

insert into ObjectDesc(Id, Code, ItemName)
SELECT zc_Object_PriceListItem(), 'PriceListItem', '����' WHERE NOT EXISTS (SELECT * FROM ObjectDesc WHERE Id = zc_Object_PriceListItem());
