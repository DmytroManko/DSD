/*insert into ContainerDesc(Id, Code, ItemName)
SELECT zc_Container_Count(), 'Count', '����� ��������� ����� ����������' WHERE NOT EXISTS (SELECT * FROM ContainerDesc WHERE Id = zc_Container_Count());

insert into ContainerDesc(Id, Code, ItemName)
SELECT zc_Container_Summ(), 'Summ', '����� ���������� ����� ����' WHERE NOT EXISTS (SELECT * FROM ContainerDesc WHERE Id = zc_Container_Summ());
*/
--------------------------- !!!!!!!!!!!!!!!!!!!
--------------------------- !!! ����� ����� !!!
--------------------------- !!!!!!!!!!!!!!!!!!!
insert into ContainerDesc(Code, ItemName)
  SELECT 'zc_Container_Count', '����� ��������� ����� ����������' WHERE NOT EXISTS (SELECT * FROM ContainerDesc WHERE Code = 'zc_Container_Count');

insert into ContainerDesc(Code, ItemName)
  SELECT 'zc_Container_Summ', '����� ���������� ����� ����' WHERE NOT EXISTS (SELECT * FROM ContainerDesc WHERE Code = 'zc_Container_Summ');

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 05.07.13         * ����� �����
*/
