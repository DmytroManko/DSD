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

INSERT INTO MovementItemFloatDesc(Id, Code, ItemName)
SELECT zc_MovementItemFloat_Count(), 'Count', '���������� �����' 
       WHERE NOT EXISTS (SELECT * FROM MovementItemFloatDesc WHERE Id = zc_MovementItemFloat_Count()); 

INSERT INTO MovementItemFloatDesc(Id, Code, ItemName)
SELECT zc_MovementItemFloat_RealWeight(), 'RealWeight', '�������� ���' 
       WHERE NOT EXISTS (SELECT * FROM MovementItemFloatDesc WHERE Id = zc_MovementItemFloat_RealWeight()); 

INSERT INTO MovementItemFloatDesc(Id, Code, ItemName)
SELECT zc_MovementItemFloat_CuterCount(), 'CuterCount', '���������� �������' 
       WHERE NOT EXISTS (SELECT * FROM MovementItemFloatDesc WHERE Id = zc_MovementItemFloat_CuterCount()); 

INSERT INTO MovementItemFloatDesc(Id, Code, ItemName)
SELECT zc_MovementItemFloat_AmountReceipt(), 'AmountReceipt', '���������� �������' 
       WHERE NOT EXISTS (SELECT * FROM MovementItemFloatDesc WHERE Id = zc_MovementItemFloat_AmountReceipt()); 


--------------------------- !!!!!!!!!!!!!!!!!!!
--------------------------- !!! ����� ����� !!!
--------------------------- !!!!!!!!!!!!!!!!!!!
