--------------------------- !!!!!!!!!!!!!!!!!!!
--------------------------- !!! ����� ����� !!!
--------------------------- !!!!!!!!!!!!!!!!!!!

INSERT INTO MovementItemStringDesc (Code, ItemName)
  SELECT 'zc_MovementItemString_Comment', '�����������' WHERE NOT EXISTS (SELECT * FROM MovementItemStringDesc WHERE Code = 'zc_MovementItemString_Comment');

INSERT INTO MovementItemStringDesc (Code, ItemName)
  SELECT 'zc_MovementItemString_PartionGoods', '�����������' WHERE NOT EXISTS (SELECT * FROM MovementItemStringDesc WHERE Code = 'zc_MovementItemString_PartionGoods');


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.

 29.06.13                                        * ����� �����
 29.06.13                                        * zc_MovementItemString_PartionGoods
*/
