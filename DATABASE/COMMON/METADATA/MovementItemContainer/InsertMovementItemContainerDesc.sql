insert into MovementItemContainerDesc(Id, Code, ItemName)
SELECT zc_MovementItemContainer_Count(), 'Count', '�������� ��� ��������� ����� � ����������' WHERE NOT EXISTS (SELECT * FROM MovementItemContainerDesc WHERE Id = zc_MovementItemContainer_Count());

insert into MovementItemContainerDesc(Id, Code, ItemName)
SELECT zc_MovementItemContainer_Summ(), 'Summ', '�������� ��� ���������� ����� � ������' WHERE NOT EXISTS (SELECT * FROM MovementItemContainerDesc WHERE Id = zc_MovementItemContainer_Summ());



--------------------------- !!!!!!!!!!!!!!!!!!!
--------------------------- !!! ����� ����� !!!
--------------------------- !!!!!!!!!!!!!!!!!!!
