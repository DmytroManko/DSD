insert into MovementDesc(Id, Code, ItemName)
SELECT zc_Movement_Income(), 'Income', '��������� ���������' WHERE NOT EXISTS (SELECT * FROM MovementDesc WHERE Id = zc_Movement_Income());

insert into MovementDesc(Id, Code, ItemName)
SELECT zc_Movement_Transfer(), 'Transfer', '��������� �����������' WHERE NOT EXISTS (SELECT * FROM MovementDesc WHERE Id = zc_Movement_Transfer());

