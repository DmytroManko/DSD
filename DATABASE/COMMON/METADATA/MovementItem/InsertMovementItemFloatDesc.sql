--------------------------- !!!!!!!!!!!!!!!!!!!
--------------------------- !!! ����� ����� !!!
--------------------------- !!!!!!!!!!!!!!!!!!!


INSERT INTO MovementItemFloatDesc (Code, ItemName)
  SELECT 'zc_MovementItemFloat_AmountPartner', '���������� � �����������'  WHERE NOT EXISTS (SELECT * FROM MovementItemFloatDesc WHERE Code = 'zc_MovementItemFloat_AmountPartner'); 
INSERT INTO MovementItemFloatDesc (Code, ItemName)
  SELECT 'zc_MovementItemFloat_AmountPacker', '���������� � ������������'  WHERE NOT EXISTS (SELECT * FROM MovementItemFloatDesc WHERE Code = 'zc_MovementItemFloat_AmountPacker');

INSERT INTO MovementItemFloatDesc (Code, ItemName)
  SELECT 'zc_MovementItemFloat_Price', '����' WHERE NOT EXISTS (SELECT * FROM MovementItemFloatDesc WHERE Code = 'zc_MovementItemFloat_Price'); 
INSERT INTO MovementItemFloatDesc (Code, ItemName)
  SELECT 'zc_MovementItemFloat_CountForPrice', '���� �� ����������' WHERE NOT EXISTS (SELECT * FROM MovementItemFloatDesc WHERE Code = 'zc_MovementItemFloat_CountForPrice'); 


INSERT INTO MovementItemFloatDesc (Code, ItemName)
  SELECT 'zc_MovementItemFloat_LiveWeight', '����� ���' WHERE NOT EXISTS (SELECT * FROM MovementItemFloatDesc WHERE Code = 'zc_MovementItemFloat_LiveWeight');
INSERT INTO MovementItemFloatDesc (Code, ItemName)
  SELECT 'zc_MovementItemFloat_HeadCount', '���������� �����' WHERE NOT EXISTS (SELECT * FROM MovementItemFloatDesc WHERE Code = 'zc_MovementItemFloat_HeadCount');
INSERT INTO MovementItemFloatDesc (Code, ItemName)
  SELECT 'zc_MovementItemFloat_RealWeight', '�������� ���' WHERE NOT EXISTS (SELECT * FROM MovementItemFloatDesc WHERE Code = 'zc_MovementItemFloat_RealWeight');

INSERT INTO MovementItemFloatDesc (Code, ItemName)
  SELECT 'zc_MovementItemFloat_Count', '���������� ������� ��� ��������' WHERE NOT EXISTS (SELECT * FROM MovementItemFloatDesc WHERE Code = 'zc_MovementItemFloat_Count');

INSERT INTO MovementItemFloatDesc (Code, ItemName)
  SELECT 'zc_MovementItemFloat_CuterCount', '���������� �������' WHERE NOT EXISTS (SELECT * FROM MovementItemFloatDesc WHERE Code = 'zc_MovementItemFloat_CuterCount');
INSERT INTO MovementItemFloatDesc (Code, ItemName)
  SELECT 'zc_MovementItemFloat_AmountReceipt', '���������� �� ��������� �� 1 �����' WHERE NOT EXISTS (SELECT * FROM MovementItemFloatDesc WHERE Code = 'zc_MovementItemFloat_AmountReceipt');



/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 29.06.13                                        * ����� �����
 29.06.13                                        * zc_MovementItemFloat_AmountPacker
*/
