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
