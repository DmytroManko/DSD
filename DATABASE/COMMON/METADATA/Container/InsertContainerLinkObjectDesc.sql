--------------------------- !!!!!!!!!!!!!!!!!!!
--------------------------- !!! ����� ����� !!!
--------------------------- !!!!!!!!!!!!!!!!!!!

-- !!! ������ ���������������� ���� !!!
/*
DO $$
BEGIN
PERFORM setval ('containerlinkobjectdesc_id_seq', (select max (id) + 1 from ContainerLinkObjectDesc));
END $$;
*/

insert into ContainerLinkObjectDesc(Code, ItemName)
  SELECT 'zc_ContainerLinkObject_Account', '��������� "�������������� �����"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Code = 'zc_ContainerLinkObject_Account');

insert into ContainerLinkObjectDesc(Code, ItemName)
  SELECT 'zc_ContainerLinkObject_ProfitLoss', '��������� "������ ������ � �������� � �������"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Code = 'zc_ContainerLinkObject_ProfitLoss');

insert into ContainerLinkObjectDesc(Code, ItemName)
  SELECT 'zc_ContainerLinkObject_InfoMoney', '��������� "�������������� ���������"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Code = 'zc_ContainerLinkObject_InfoMoney');

insert into ContainerLinkObjectDesc(Code, ItemName)
  SELECT 'zc_ContainerLinkObject_Unit', '��������� "�������������"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Code = 'zc_ContainerLinkObject_Unit');

insert into ContainerLinkObjectDesc(Code, ItemName)
  SELECT 'zc_ContainerLinkObject_Goods', '��������� "������"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Code = 'zc_ContainerLinkObject_Goods');

insert into ContainerLinkObjectDesc(Code, ItemName)
  SELECT 'zc_ContainerLinkObject_GoodsKind', '��������� "���� �������"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Code = 'zc_ContainerLinkObject_GoodsKind');

insert into ContainerLinkObjectDesc(Code, ItemName)
 SELECT 'zc_ContainerLinkObject_InfoMoneyDetail', '��������� "�������������� ���������(����������� �/�)"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Code = 'zc_ContainerLinkObject_InfoMoneyDetail');

insert into ContainerLinkObjectDesc(Code, ItemName)
  SELECT 'zc_ContainerLinkObject_Contract', '��������� "��������"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Code = 'zc_ContainerLinkObject_Contract');

insert into ContainerLinkObjectDesc(Code, ItemName)
  SELECT 'zc_ContainerLinkObject_PaidKind', '��������� "���� ���� ������"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Code = 'zc_ContainerLinkObject_PaidKind');

insert into ContainerLinkObjectDesc(Code, ItemName)
  SELECT 'zc_ContainerLinkObject_Juridical', '��������� "����������� ����"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Code = 'zc_ContainerLinkObject_Juridical');
 
insert into ContainerLinkObjectDesc(Code, ItemName)
  SELECT 'zc_ContainerLinkObject_Car', '��������� "����������"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Code = 'zc_ContainerLinkObject_Car');

insert into ContainerLinkObjectDesc(Code, ItemName)
  SELECT 'zc_ContainerLinkObject_Personal', '��������� "����������"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Code = 'zc_ContainerLinkObject_Personal');

insert into ContainerLinkObjectDesc(Code, ItemName)
  SELECT 'zc_ContainerLinkObject_PersonalStore', '��������� "����������(�����������)"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Code = 'zc_ContainerLinkObject_PersonalStore');

insert into ContainerLinkObjectDesc(Code, ItemName)
  SELECT 'zc_ContainerLinkObject_PersonalBuyer', '��������� "����������(����������)"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Code = 'zc_ContainerLinkObject_PersonalBuyer');

insert into ContainerLinkObjectDesc(Code, ItemName)
  SELECT 'zc_ContainerLinkObject_PersonalGoods', '��������� "����������(����������� �������������)"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Code = 'zc_ContainerLinkObject_PersonalGoods');

insert into ContainerLinkObjectDesc(Code, ItemName)
  SELECT 'zc_ContainerLinkObject_PersonalCash', '��������� "����������(����������� ����)"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Code = 'zc_ContainerLinkObject_PersonalCash');

insert into ContainerLinkObjectDesc(Code, ItemName)
  SELECT 'zc_ContainerLinkObject_AssetTo', '��������� "�������� ��������(��� �������� ��������� ���)"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Code = 'zc_ContainerLinkObject_AssetTo');

INSERT INTO ContainerLinkObjectDesc(Code, ItemName)
  SELECT 'zc_ContainerLinkObject_PartionGoods', '��������� "������ ������"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Code = 'zc_ContainerLinkObject_PartionGoods');

INSERT INTO ContainerLinkObjectDesc(Code, ItemName)
  SELECT 'zc_ContainerLinkObject_PartionMovement', '��������� "������ ���������"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Code = 'zc_ContainerLinkObject_PartionMovement');

INSERT INTO ContainerLinkObjectDesc (Code, ItemName)
  SELECT 'zc_ContainerLinkObject_Business', '��������� <�������>' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Code = 'zc_ContainerLinkObject_Business');

INSERT INTO ContainerLinkObjectDesc (Code, ItemName)
  SELECT 'zc_ContainerLinkObject_JuridicalBasis', '��������� <������� ����������� ����>' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Code = 'zc_ContainerLinkObject_JuridicalBasis');

INSERT INTO ContainerLinkObjectDesc (Code, ItemName)
  SELECT 'zc_ContainerLinkObject_PersonalSupplier', '��������� <����������(����������)>' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Code = 'zc_ContainerLinkObject_PersonalSupplier');


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 05.07.13          * ������� ����� �� ����� �����
 03.07.13                                        * ����� �����
*/
