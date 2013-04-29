INSERT INTO MovementItemFloatDesc(Id, Code, ItemName)
SELECT zc_MovementItemFloat_AmountPartner(), 'AmountPartner', '���������� � �����������' 
       WHERE NOT EXISTS (SELECT * FROM MovementItemFloatDesc WHERE Id = zc_MovementItemFloat_AmountPartner()); 

INSERT INTO MovementItemFloatDesc(Id, Code, ItemName)
SELECT zc_MovementItemFloat_Price(), 'Price', '����' 
       WHERE NOT EXISTS (SELECT * FROM MovementItemFloatDesc WHERE Id = zc_MovementItemFloat_Price()); 

INSERT INTO MovementItemFloatDesc(Id, Code, ItemName)
SELECT zc_MovementItemFloat_CountForPrice(), 'CountForPrice', '���� �� ����������' 
       WHERE NOT EXISTS (SELECT * FROM MovementItemFloatDesc WHERE Id = zc_MovementItemFloat_CountForPrice()); 

INSERT INTO MovementItemFloatDesc(Id, Code, ItemName)
SELECT zc_MovementItemFloat_LiveWeight(), 'LiveWeight', '����� ���' 
       WHERE NOT EXISTS (SELECT * FROM MovementItemFloatDesc WHERE Id = zc_MovementItemFloat_LiveWeight()); 

INSERT INTO MovementItemFloatDesc(Id, Code, ItemName)
SELECT zc_MovementItemFloat_HeadCount(), 'HeadCount', '���������� �����' 
       WHERE NOT EXISTS (SELECT * FROM MovementItemFloatDesc WHERE Id = zc_MovementItemFloat_HeadCount()); 

