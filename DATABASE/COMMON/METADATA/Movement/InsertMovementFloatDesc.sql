--------------------------- !!!!!!!!!!!!!!!!!!!
--------------------------- !!! ����� ����� !!!
--------------------------- !!!!!!!!!!!!!!!!!!!
INSERT INTO MovementFloatDesc(Code, ItemName)
  SELECT 'zc_MovementFloat_TotalSumm', '����� ����� �� ��������� (� ������ ��� � ������)' WHERE NOT EXISTS (SELECT * FROM MovementFloatDesc WHERE Code = 'zc_MovementFloat_TotalSumm'); 

INSERT INTO MovementFloatDesc(Code, ItemName)
  SELECT 'zc_MovementFloat_VATPercent', '% ���' WHERE NOT EXISTS (SELECT * FROM MovementFloatDesc WHERE Code = 'zc_MovementFloat_VATPercent'); 

INSERT INTO MovementFloatDesc(Code, ItemName)
  SELECT 'zc_MovementFloat_DiscountPercent', '% ������' WHERE NOT EXISTS (SELECT * FROM MovementFloatDesc WHERE Code = 'zc_MovementFloat_DiscountPercent'); 

INSERT INTO MovementFloatDesc(Code, ItemName)
  SELECT 'zc_MovementFloat_ExtraChargesPercent', '% �������' WHERE NOT EXISTS (SELECT * FROM MovementFloatDesc WHERE Code = 'zc_MovementFloat_ExtraChargesPercent'); 

INSERT INTO MovementFloatDesc(Code, ItemName)
 SELECT 'zc_MovementFloat_TotalCountKg', '����� ����������, ��' WHERE NOT EXISTS (SELECT * FROM MovementFloatDesc WHERE Code = 'zc_MovementFloat_TotalCountKg'); 

INSERT INTO MovementFloatDesc(Code, ItemName)
  SELECT 'zc_MovementFloat_TotalCountSh', '����� ����������, ��' WHERE NOT EXISTS (SELECT * FROM MovementFloatDesc WHERE Code = 'zc_MovementFloat_TotalCountSh'); 

INSERT INTO MovementFloatDesc(Code, ItemName)
  SELECT 'zc_MovementFloat_TotalCountTare', '����� ����������, ����' WHERE NOT EXISTS (SELECT * FROM MovementFloatDesc WHERE Code = 'zc_MovementFloat_TotalCountTare'); 

INSERT INTO MovementFloatDesc(Code, ItemName)
  SELECT 'zc_MovementFloat_TotalCount', '����� ����������' WHERE NOT EXISTS (SELECT * FROM MovementFloatDesc WHERE Code = 'zc_MovementFloat_TotalCount'); 

INSERT INTO MovementFloatDesc(Code, ItemName)
  SELECT 'TotalSummMVAT', '����� ����� �� ��������� (��� ���)' WHERE NOT EXISTS (SELECT * FROM MovementFloatDesc WHERE Code = 'zc_MovementFloat_TotalSummMVAT'); 

INSERT INTO MovementFloatDesc(Code, ItemName)
  SELECT 'zc_MovementFloat_TotalSummPVAT', '����� ����� �� ��������� (� ���)' WHERE NOT EXISTS (SELECT * FROM MovementFloatDesc WHERE Code = 'zc_MovementFloat_TotalSummPVAT'); 

INSERT INTO MovementFloatDesc(Code, ItemName)
  SELECT 'zc_MovementFloat_TotalSpending', '����� ����� ������ �� ��������� (� ������ ���)' WHERE NOT EXISTS (SELECT * FROM MovementFloatDesc WHERE Code = 'zc_MovementFloat_TotalSpending');


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.

 07.07.13         * ����� �����
*/
