insert into ContainerLinkObjectDesc(Id, Code, ItemName)
SELECT zc_ContainerLinkObject_Goods(), 'Goods', '��������� "�����"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Id = zc_ContainerLinkObject_Goods());

insert into ContainerLinkObjectDesc(Id, Code, ItemName)
SELECT zc_ContainerLinkObject_Unit(), 'Unit', '��������� "�������������"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Id = zc_ContainerLinkObject_Unit());

insert into ContainerLinkObjectDesc(Id, Code, ItemName)
SELECT zc_ContainerLinkObject_Cash(), 'Cash', '��������� "�����"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Id = zc_ContainerLinkObject_Cash());

insert into ContainerLinkObjectDesc(Id, Code, ItemName)
SELECT zc_ContainerLinkObject_Account(), 'Account', '��������� "�����"' WHERE NOT EXISTS (SELECT * FROM ContainerLinkObjectDesc WHERE Id = zc_ContainerLinkObject_Account());
