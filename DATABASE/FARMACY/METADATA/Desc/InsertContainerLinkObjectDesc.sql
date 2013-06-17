insert into ContainerLinkObjectDesc(Id, Code, ItemName)
SELECT zc_ContainerLinkObject_Account(), 'Account', '��������� "�������������� �����"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Id = zc_ContainerLinkObject_Account());

insert into ContainerLinkObjectDesc(Id, Code, ItemName)
SELECT zc_ContainerLinkObject_ProfitLoss(), 'ProfitLoss', '��������� "������ ������ � �������� � �������"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Id = zc_ContainerLinkObject_ProfitLoss());

insert into ContainerLinkObjectDesc(Id, Code, ItemName)
SELECT zc_ContainerLinkObject_Business(), 'Business', '��������� "�������"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Id = zc_ContainerLinkObject_Business());

insert into ContainerLinkObjectDesc(Id, Code, ItemName)
SELECT zc_ContainerLinkObject_JuridicalBasis(), 'JuridicalBasis', '��������� "������� ����������� ����"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Id = zc_ContainerLinkObject_JuridicalBasis());

insert into ContainerLinkObjectDesc(Id, Code, ItemName)
SELECT zc_ContainerLinkObject_InfoMoney(), 'InfoMoney', '��������� "�������������� ���������"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Id = zc_ContainerLinkObject_InfoMoney());

insert into ContainerLinkObjectDesc(Id, Code, ItemName)
SELECT zc_ContainerLinkObject_Unit(), 'Unit', '��������� "�������������"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Id = zc_ContainerLinkObject_Unit());

insert into ContainerLinkObjectDesc(Id, Code, ItemName)
SELECT zc_ContainerLinkObject_Goods(), 'Goods', '��������� "������"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Id = zc_ContainerLinkObject_Goods());

insert into ContainerLinkObjectDesc(Id, Code, ItemName)
SELECT zc_ContainerLinkObject_GoodsKind(), 'GoodsKind', '��������� "���� �������"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Id = zc_ContainerLinkObject_GoodsKind());

insert into ContainerLinkObjectDesc(Id, Code, ItemName)
SELECT zc_ContainerLinkObject_InfoMoneyDetail(), 'InfoMoneyDetail', '��������� "�������������� ���������(����������� �/�)"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Id = zc_ContainerLinkObject_InfoMoneyDetail());

insert into ContainerLinkObjectDesc(Id, Code, ItemName)
SELECT zc_ContainerLinkObject_InfoMoneyDetail(), 'InfoMoneyDetail', '��������� "�������������� ���������(����������� �/�)"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Id = zc_ContainerLinkObject_InfoMoneyDetail());

insert into ContainerLinkObjectDesc(Id, Code, ItemName)
SELECT zc_ContainerLinkObject_Contract(), 'Contract', '��������� "��������"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Id = zc_ContainerLinkObject_Contract());

insert into ContainerLinkObjectDesc(Id, Code, ItemName)
SELECT zc_ContainerLinkObject_PaidKind(), 'PaidKind', '��������� "���� ���� ������"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Id = zc_ContainerLinkObject_PaidKind());

insert into ContainerLinkObjectDesc(Id, Code, ItemName)
SELECT zc_ContainerLinkObject_Juridical(), 'Juridical', '��������� "����������� ����"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Id = zc_ContainerLinkObject_Juridical());

insert into ContainerLinkObjectDesc(Id, Code, ItemName)
SELECT zc_ContainerLinkObject_Juridical(), 'Juridical', '��������� "����������� ����"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Id = zc_ContainerLinkObject_Juridical());

insert into ContainerLinkObjectDesc(Id, Code, ItemName)
SELECT zc_ContainerLinkObject_Car(), 'Car', '��������� "����������"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Id = zc_ContainerLinkObject_Car());

insert into ContainerLinkObjectDesc(Id, Code, ItemName)
SELECT zc_ContainerLinkObject_Position(), 'Position', '��������� "���������"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Id = zc_ContainerLinkObject_Position());

insert into ContainerLinkObjectDesc(Id, Code, ItemName)
SELECT zc_ContainerLinkObject_Personal(), 'Personal', '��������� "����������"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Id = zc_ContainerLinkObject_Personal());

insert into ContainerLinkObjectDesc(Id, Code, ItemName)
SELECT zc_ContainerLinkObject_PersonalStore(), 'PersonalStore', '��������� "����������(�����������)"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Id = zc_ContainerLinkObject_PersonalStore());

insert into ContainerLinkObjectDesc(Id, Code, ItemName)
SELECT zc_ContainerLinkObject_PersonalBuyer(), 'PersonalBuyer', '��������� "����������(����������)"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Id = zc_ContainerLinkObject_PersonalBuyer());

insert into ContainerLinkObjectDesc(Id, Code, ItemName)
SELECT zc_ContainerLinkObject_PersonalGoods(), 'PersonalGoods', '��������� "����������(����������� �������������)"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Id = zc_ContainerLinkObject_PersonalGoods());

insert into ContainerLinkObjectDesc(Id, Code, ItemName)
SELECT zc_ContainerLinkObject_PersonalCash(), 'PersonalCash', '��������� "����������(����������� ����)"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Id = zc_ContainerLinkObject_PersonalCash());

insert into ContainerLinkObjectDesc(Id, Code, ItemName)
SELECT zc_ContainerLinkObject_AssetTo(), 'AssetTo', '��������� "�������� ��������(��� �������� ��������� ���)"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Id = zc_ContainerLinkObject_AssetTo());

insert into ContainerLinkObjectDesc(Id, Code, ItemName)
SELECT zc_ContainerLinkObject_PartionGoods(), 'PartionGoods', '��������� "������ ������"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Id = zc_ContainerLinkObject_PartionGoods());

insert into ContainerLinkObjectDesc(Id, Code, ItemName)
SELECT zc_ContainerLinkObject_PartionMovement(), 'PartionMovement', '��������� "������ ���������"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Id = zc_ContainerLinkObject_PartionMovement());
