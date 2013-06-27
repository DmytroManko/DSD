insert into MovementItemLinkObjectDesc(Id, Code, ItemName)
SELECT zc_MovementItemLink_GoodsKind(), 'GoodsKind', '���� �������' 
       WHERE NOT EXISTS (SELECT * FROM MovementItemLinkObjectDesc WHERE Id = zc_MovementItemLink_GoodsKind());

insert into MovementItemLinkObjectDesc(Id, Code, ItemName)
SELECT zc_MovementItemLink_Partion(), 'Partion', '�������� c ������� ���� ������ ������' 
       WHERE NOT EXISTS (SELECT * FROM MovementItemLinkObjectDesc WHERE Id = zc_MovementItemLink_Partion());

insert into MovementItemLinkObjectDesc(Id, Code, ItemName)
SELECT zc_MovementItemLink_Receipt(), 'Receipt', '���������' 
       WHERE NOT EXISTS (SELECT * FROM MovementItemLinkObjectDesc WHERE Id = zc_MovementItemLink_Receipt());

--------------------------- !!!!!!!!!!!!!!!!!!!
--------------------------- !!! ����� ����� !!!
--------------------------- !!!!!!!!!!!!!!!!!!!

