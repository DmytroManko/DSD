CREATE OR REPLACE FUNCTION zc_ObjectHistoryString_JuridicalDetails_FullName() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM ObjectHistoryStringDesc WHERE Code = 'JuridicalDetails_FullName'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO ObjectHistoryStringDesc (DescId, Code ,itemname)
SELECT zc_ObjectHistory_JuridicalDetails(), 'JuridicalDetails_FullName','��. ���� ������ ��������' WHERE NOT EXISTS (SELECT * FROM ObjectHistoryStringDesc WHERE Id = zc_ObjectHistoryString_JuridicalDetails_FullName());

CREATE OR REPLACE FUNCTION zc_ObjectHistoryString_JuridicalDetails_JuridicalAddress() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM ObjectHistoryStringDesc WHERE Code = 'JuridicalDetails_JuridicalAddress'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO ObjectHistoryStringDesc (DescId, Code ,itemname)
SELECT zc_ObjectHistory_JuridicalDetails(), 'JuridicalDetails_JuridicalAddress','����������� �����' WHERE NOT EXISTS (SELECT * FROM ObjectHistoryStringDesc WHERE Id = zc_ObjectHistoryString_JuridicalDetails_JuridicalAddress());

CREATE OR REPLACE FUNCTION zc_ObjectHistoryString_JuridicalDetails_OKPO() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM ObjectHistoryStringDesc WHERE Code = 'JuridicalDetails_OKPO'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO ObjectHistoryStringDesc (DescId, Code ,itemname)
SELECT zc_ObjectHistory_JuridicalDetails(), 'JuridicalDetails_OKPO','����' WHERE NOT EXISTS (SELECT * FROM ObjectHistoryStringDesc WHERE Id = zc_ObjectHistoryString_JuridicalDetails_OKPO());

CREATE OR REPLACE FUNCTION zc_ObjectHistoryString_JuridicalDetails_INN() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM ObjectHistoryStringDesc WHERE Code = 'JuridicalDetails_INN'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO ObjectHistoryStringDesc (DescId, Code ,itemname)
SELECT zc_ObjectHistory_JuridicalDetails(), 'JuridicalDetails_INN','���' WHERE NOT EXISTS (SELECT * FROM ObjectHistoryStringDesc WHERE Id = zc_ObjectHistoryString_JuridicalDetails_INN());

CREATE OR REPLACE FUNCTION zc_ObjectHistoryString_JuridicalDetails_NumberVAT() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM ObjectHistoryStringDesc WHERE Code = 'JuridicalDetails_NumberVAT'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO ObjectHistoryStringDesc (DescId, Code ,itemname)
SELECT zc_ObjectHistory_JuridicalDetails(), 'JuridicalDetails_NumberVAT','����� ������������� ����������� ���' WHERE NOT EXISTS (SELECT * FROM ObjectHistoryStringDesc WHERE Id = zc_ObjectHistoryString_JuridicalDetails_NumberVAT());

CREATE OR REPLACE FUNCTION zc_ObjectHistoryString_JuridicalDetails_AccounterName() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM ObjectHistoryStringDesc WHERE Code = 'JuridicalDetails_AccounterName'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO ObjectHistoryStringDesc (DescId, Code ,itemname)
SELECT zc_ObjectHistory_JuridicalDetails(), 'JuridicalDetails_AccounterName','��� ����.' WHERE NOT EXISTS (SELECT * FROM ObjectHistoryStringDesc WHERE Id = zc_ObjectHistoryString_JuridicalDetails_AccounterName());

CREATE OR REPLACE FUNCTION zc_ObjectHistoryString_JuridicalDetails_BankAccount() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM ObjectHistoryStringDesc WHERE Code = 'JuridicalDetails_BankAccount'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO ObjectHistoryStringDesc (DescId, Code ,itemname)
SELECT zc_ObjectHistory_JuridicalDetails(), 'JuridicalDetails_BankAccount','�.����' WHERE NOT EXISTS (SELECT * FROM ObjectHistoryStringDesc WHERE Id = zc_ObjectHistoryString_JuridicalDetails_BankAccount());
