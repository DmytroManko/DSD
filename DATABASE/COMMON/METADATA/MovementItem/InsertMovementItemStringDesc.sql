--------------------------- !!!!!!!!!!!!!!!!!!!
--------------------------- !!! ����� ����� !!!
--------------------------- !!!!!!!!!!!!!!!!!!!

INSERT INTO MovementItemStringDesc (Code, ItemName)
  SELECT 'zc_MIString_Comment', '�����������' WHERE NOT EXISTS (SELECT * FROM MovementItemStringDesc WHERE Code = 'zc_MIString_Comment');

INSERT INTO MovementItemStringDesc (Code, ItemName)
  SELECT 'zc_MIString_PartionGoods', '�����������' WHERE NOT EXISTS (SELECT * FROM MovementItemStringDesc WHERE Code = 'zc_MIString_PartionGoods');


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.

 29.06.13                                        * ����� �����
 29.06.13                                        * zc_MIString_PartionGoods
*/
