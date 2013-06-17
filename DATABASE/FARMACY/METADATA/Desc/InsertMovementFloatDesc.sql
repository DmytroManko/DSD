INSERT INTO MovementFloatDesc(Id, Code, ItemName)
SELECT zc_MovementFloat_TotalSumm(), 'TotalSumm', '����� ����� �� ��������� (� ������ ��� � ������)' 
       WHERE NOT EXISTS (SELECT * FROM MovementFloatDesc WHERE Id = zc_MovementFloat_TotalSumm()); 

INSERT INTO MovementFloatDesc(Id, Code, ItemName)
SELECT zc_MovementFloat_VATPercent(), 'VATPercent', '% ���' 
       WHERE NOT EXISTS (SELECT * FROM MovementFloatDesc WHERE Id = zc_MovementFloat_VATPercent()); 

INSERT INTO MovementFloatDesc(Id, Code, ItemName)
SELECT zc_MovementFloat_DiscountPercent(), 'DiscountPercent', '% ������' 
       WHERE NOT EXISTS (SELECT * FROM MovementFloatDesc WHERE Id = zc_MovementFloat_DiscountPercent()); 

INSERT INTO MovementFloatDesc(Id, Code, ItemName)
SELECT zc_MovementFloat_ExtraChargesPercent(), 'ExtraChargesPercent', '% �������' 
       WHERE NOT EXISTS (SELECT * FROM MovementFloatDesc WHERE Id = zc_MovementFloat_ExtraChargesPercent()); 

INSERT INTO MovementFloatDesc(Id, Code, ItemName)
SELECT zc_MovementFloat_TotalCountKg(), 'TotalCountKg', '����� ����������, ��' 
       WHERE NOT EXISTS (SELECT * FROM MovementFloatDesc WHERE Id = zc_MovementFloat_TotalCountKg()); 

INSERT INTO MovementFloatDesc(Id, Code, ItemName)
SELECT zc_MovementFloat_TotalCountSh(), 'TotalCountSh', '����� ����������, ��' 
       WHERE NOT EXISTS (SELECT * FROM MovementFloatDesc WHERE Id = zc_MovementFloat_TotalCountSh()); 

INSERT INTO MovementFloatDesc(Id, Code, ItemName)
SELECT zc_MovementFloat_TotalCountTare(), 'TotalCountTare', '����� ����������, ����' 
       WHERE NOT EXISTS (SELECT * FROM MovementFloatDesc WHERE Id = zc_MovementFloat_TotalCountTare()); 

INSERT INTO MovementFloatDesc(Id, Code, ItemName)
SELECT zc_MovementFloat_TotalCount(), 'TotalCount', '����� ����������' 
       WHERE NOT EXISTS (SELECT * FROM MovementFloatDesc WHERE Id = zc_MovementFloat_TotalCount()); 

INSERT INTO MovementFloatDesc(Id, Code, ItemName)
SELECT zc_MovementFloat_TotalSummMVAT(), 'TotalSummMVAT', '����� ����� �� ��������� (��� ���)' 
       WHERE NOT EXISTS (SELECT * FROM MovementFloatDesc WHERE Id = zc_MovementFloat_TotalSummMVAT()); 

INSERT INTO MovementFloatDesc(Id, Code, ItemName)
SELECT zc_MovementFloat_TotalSummPVAT(), 'TotalSummPVAT', '����� ����� �� ��������� (� ���)' 
       WHERE NOT EXISTS (SELECT * FROM MovementFloatDesc WHERE Id = zc_MovementFloat_TotalSummPVAT()); 

INSERT INTO MovementFloatDesc(Id, Code, ItemName)
SELECT zc_MovementFloat_TotalSpending(), 'TotalSpending', '����� ����� ������ �� ��������� (� ������ ���)' 
       WHERE NOT EXISTS (SELECT * FROM MovementFloatDesc WHERE Id = zc_MovementFloat_TotalSpending()); 
