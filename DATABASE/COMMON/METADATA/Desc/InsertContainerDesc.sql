insert into ContainerDesc(Id, Code, ItemName)
SELECT zc_Container_Money(), 'Money', '������� ����� �� ���������' WHERE NOT EXISTS (SELECT * FROM ContainerDesc WHERE Id = zc_Container_Money());
