-- insert into MovementItemLinkObjectDesc(Id, Code, ItemName)
-- SELECT zc_MovementItemLink_Partion(), 'Partion', '�������� c ������� ���� ������ ������' 
--       WHERE NOT EXISTS (SELECT * FROM MovementItemLinkObjectDesc WHERE Id = zc_MovementItemLink_Partion());

--------------------------- !!!!!!!!!!!!!!!!!!!
--------------------------- !!! ����� ����� !!!
--------------------------- !!!!!!!!!!!!!!!!!!!

INSERT INTO MovementItemLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementItemLink_GoodsKind', '���� �������' WHERE NOT EXISTS (SELECT * FROM MovementItemLinkObjectDesc WHERE Code = 'zc_MovementItemLink_GoodsKind');

INSERT INTO MovementItemLinkObjectDesc (Code, ItemName)
  SELECT 'MovementItemLink_Asset', '�������� �������� (��� ������� ���������� ���)' WHERE NOT EXISTS (SELECT * FROM MovementItemLinkObjectDesc WHERE Code = 'MovementItemLink_Asset');

INSERT INTO MovementItemLinkObjectDesc (Code, ItemName)
  SELECT 'zc_MovementItemLink_Receipt', '���������' WHERE NOT EXISTS (SELECT * FROM MovementItemLinkObjectDesc WHERE Code = 'zc_MovementItemLink_Receipt');


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.

 29.06.13                                        * ����� �����
 29.06.13                                        * MovementItemLink_Asset
*/
