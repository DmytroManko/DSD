DO $$
DECLARE ioId integer;
BEGIN
   -- ��������� ���� ������
   PERFORM lpInsertUpdate_Object(zc_Object_AccountPlan_Foundation(), zc_Object_AccountPlan(), 0, '������� � ������������');
   PERFORM lpInsertUpdate_Object(zc_Object_AccountPlan_Cash(), zc_Object_AccountPlan(), 0, '�����');
   -- ����������� ������������������
   PERFORM setval('object_id_seq', (select max( id ) + 1 from Object));

END $$;
