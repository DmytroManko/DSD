insert into MovementItemDesc(Id, Code, ItemName)
SELECT zc_MovementItem_Goods(), 'Goods', '�������� �������' 
       WHERE NOT EXISTS (SELECT * FROM MovementItemDesc WHERE Id = zc_MovementItem_Goods());


