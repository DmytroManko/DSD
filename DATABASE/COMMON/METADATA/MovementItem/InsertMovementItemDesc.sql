insert into MovementItemDesc(Id, Code, ItemName)
SELECT zc_MovementItem_Goods(), 'Goods', '�������� �������' 
       WHERE NOT EXISTS (SELECT * FROM MovementItemDesc WHERE Id = zc_MovementItem_Goods());

insert into MovementItemDesc(Id, Code, ItemName)
SELECT zc_MovementItem_In(), 'In', '������ �� ������������' 
       WHERE NOT EXISTS (SELECT * FROM MovementItemDesc WHERE Id = zc_MovementItem_In());

insert into MovementItemDesc(Id, Code, ItemName)
SELECT zc_MovementItem_Out(), 'Out', '������ �� ������������' 
       WHERE NOT EXISTS (SELECT * FROM MovementItemDesc WHERE Id = zc_MovementItem_Out());



--------------------------- !!!!!!!!!!!!!!!!!!!
--------------------------- !!! ����� ����� !!!
--------------------------- !!!!!!!!!!!!!!!!!!!
