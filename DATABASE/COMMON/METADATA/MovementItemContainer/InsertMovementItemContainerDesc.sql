--------------------------- !!!!!!!!!!!!!!!!!!!
--------------------------- !!! ����� ����� !!!
--------------------------- !!!!!!!!!!!!!!!!!!!
insert into MovementItemContainerDesc(Code, ItemName)
  SELECT 'zc_MovementItemContainer_Count', '�������� ��� ��������� ����� � ����������' WHERE NOT EXISTS (SELECT * FROM MovementItemContainerDesc WHERE Code = 'zc_MovementItemContainer_Count');

insert into MovementItemContainerDesc(Code, ItemName)
  SELECT 'zc_MovementItemContainer_Summ', '�������� ��� ���������� ����� � ������' WHERE NOT EXISTS (SELECT * FROM MovementItemContainerDesc WHERE Code = 'zc_MovementItemContainer_Summ');


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.

 07.07.13         * ����� �����
*/