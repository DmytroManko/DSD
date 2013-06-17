insert into MovementLinkObjectDesc(Id, Code, ItemName)
SELECT zc_MovementLink_To(), 'To', '�������� �� ������� ���� ������ ������' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Id = zc_MovementLink_To());

insert into MovementLinkObjectDesc(Id, Code, ItemName)
SELECT zc_MovementLink_From(), 'From', '�������� c ������� ���� ������ ������' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Id = zc_MovementLink_From());

insert into MovementLinkObjectDesc(Id, Code, ItemName)
SELECT zc_MovementLink_DocumentKind(), 'DocumentKind', '��� ������������� ��������' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Id = zc_MovementLink_DocumentKind());

insert into MovementLinkObjectDesc(Id, Code, ItemName)
SELECT zc_MovementLink_PaidKind(), 'PaidKind', '���� ���� ������' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Id = zc_MovementLink_PaidKind());

insert into MovementLinkObjectDesc(Id, Code, ItemName)
SELECT zc_MovementLink_Contract(), 'Contract', '�������' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Id = zc_MovementLink_Contract());

insert into MovementLinkObjectDesc(Id, Code, ItemName)
SELECT zc_MovementLink_Car(), 'Car', '����������' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Id = zc_MovementLink_Car());

insert into MovementLinkObjectDesc(Id, Code, ItemName)
SELECT zc_MovementLink_PersonalDriver(), 'PersonalDriver', '��������� (��������)' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Id = zc_MovementLink_PersonalDriver());

insert into MovementLinkObjectDesc(Id, Code, ItemName)
SELECT zc_MovementLink_PersonalPacker(), 'PersonalPacker', '��������� (������������)' WHERE NOT EXISTS (SELECT * FROM MovementLinkObjectDesc WHERE Id = zc_MovementLink_PersonalPacker());
