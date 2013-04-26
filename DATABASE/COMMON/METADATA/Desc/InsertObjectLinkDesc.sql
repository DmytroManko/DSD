insert into ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_RoleRight_Role(), 'RoleRight_Role', '������ �� ���� � ����������� �������� �����', zc_Object_RoleRight(), zc_Object_Role() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_RoleRight_Role());

insert into ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_RoleRight_Process(), 'RoleRight_Process', '������ �� ������� � ����������� �������� �����', zc_Object_RoleRight(), zc_Object_Process() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_RoleRight_Process());

insert into ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_UserRole_Role(), 'UserRole_Role', '������ �� ���� � ����������� ����� ������������� � �����', zc_Object_UserRole(), zc_Object_Role() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_UserRole_Role());

insert into ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_UserRole_User(), 'UserRole_User', '����� � ������������� � ����������� ����� ������������', zc_Object_UserRole(), zc_Object_User() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_UserRole_User());

insert into ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_Cash_Currency(), 'Cash_Currency', '����� ����� � �������', zc_Object_Cash(), zc_Object_Currency() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_Cash_Currency());

insert into ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_Cash_Branch(), 'Cash_Branch', '����� ����� � ��������', zc_Object_Cash(), zc_Object_Branch() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_Cash_Branch());

insert into ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_JuridicalGroup_JuridicalGroup(), 'JuridicalGroup_JuridicalGroup', '����� ������ �� ��� � ������� �� ���', zc_Object_JuridicalGroup(), zc_Object_JuridicalGroup() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_JuridicalGroup_JuridicalGroup());

insert into ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_Juridical_JuridicalGroup(), 'Juridical_JuridicalGroup', '����� �� ���� � ������� �� ���', zc_Object_Juridical(), zc_Object_JuridicalGroup() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_Juridical_JuridicalGroup());

insert into ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_Juridical_GoodsProperty(), 'Juridical_GoodsProperty', '����� �� ���� � ��������������� ������� �������', zc_Object_Juridical(), zc_Object_GoodsProperty() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_Juridical_GoodsProperty());

insert into ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_Partner_Juridical(), 'Partner_Juridical', '����� ����������� � �� �����', zc_Object_Partner(), zc_Object_Juridical() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_Partner_Juridical());

insert into ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_Branch_Juridical(), 'Branch_Juridical', '����� ������� � �� �����', zc_Object_Branch(), zc_Object_Juridical() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_Branch_Juridical());

insert into ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_UnitGroup_UnitGroup(), 'UnitGroup_UnitGroup', '����� ������ ������������� � ������� �������������', zc_Object_UnitGroup(), zc_Object_UnitGroup() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_UnitGroup_UnitGroup());

insert into ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_Bank_Juridical(), 'Bank_Juridical', '����� ����� � �� �����', zc_Object_Bank(), zc_Object_Juridical() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_Bank_Juridical());

insert into ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_GoodsGroup_GoodsGroup(), 'GoodsGroup_GoodsGroup', '����� ������ ������� � ������� �������', zc_Object_GoodsGroup(), zc_Object_GoodsGroup() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_GoodsGroup_GoodsGroup());

insert into ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_Goods_GoodsGroup(), 'Goods_GoodsGroup', '����� ������� � ������� �������', zc_Object_Goods(), zc_Object_GoodsGroup() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_Goods_GoodsGroup());

insert into ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_Goods_Measure(), 'Goods_Measure', '����� ������� � �������� ���������', zc_Object_GoodsGroup(), zc_Object_GoodsGroup() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_Goods_Measure());

insert into ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_BankAccount_Juridical(), 'BankAccount_Juridical', '����� ����� � ��. �����', zc_Object_BankAccount(), zc_Object_Juridical() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_BankAccount_Juridical());

insert into ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_BankAccount_Bank(), 'BankAccount_Bank', '����� ����� ������', zc_Object_BankAccount(), zc_Object_Bank() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_BankAccount_Bank());

insert into ObjectLinkDesc(Id, Code, ItemName, DescId, ChildObjectDescId)
SELECT zc_ObjectLink_BankAccount_Currency(), 'BankAccount_Currency', '����� ����� � �������', zc_Object_BankAccount(), zc_Object_Currency() WHERE NOT EXISTS (SELECT * FROM ObjectLinkDesc WHERE Id = zc_ObjectLink_BankAccount_Currency());
