INSERT INTO MovementItemStringDesc(Id, Code, ItemName)
SELECT zc_MovementItemString_Comment(), 'Comment', '�����������' 
       WHERE NOT EXISTS (SELECT * FROM MovementItemStringDesc WHERE Id = zc_MovementItemString_Comment()); 
