--------------------------- !!!!!!!!!!!!!!!!!!!
--------------------------- !!! ����� ����� !!!
--------------------------- !!!!!!!!!!!!!!!!!!!

INSERT INTO MovementItemDesc (Code, ItemName)
  SELECT 'zc_MI_Master', '������� ������� ���������' WHERE NOT EXISTS (SELECT * FROM MovementItemDesc WHERE Code = 'zc_MI_Master');

INSERT INTO MovementItemDesc (Code, ItemName)
  SELECT 'zc_MI_Child', '����������� ������� ���������' WHERE NOT EXISTS (SELECT * FROM MovementItemDesc WHERE Code = 'zc_MI_Child');


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.

 30.06.13                                        * rename zc_MI...
 30.06.13                                        * ����� �����
*/
