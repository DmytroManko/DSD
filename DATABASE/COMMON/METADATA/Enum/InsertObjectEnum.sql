DO $$
BEGIN
   -- ��������� ��������
   PERFORM lpInsertUpdate_Object(zc_Object_Process_User(), zc_Object_Process(), 0, '��������� �������������');

   -- ��������� ����
   PERFORM lpInsertUpdate_Object(zc_Object_Role_Admin(), zc_Object_Role(), 0, '���� ��������������');

   -- ��������� ����� ������
   PERFORM lpInsertUpdate_Object(zc_Object_PaidKind_FirstForm(),  zc_Object_PaidKind(), 1, '������ �����');
   PERFORM lpInsertUpdate_Object(zc_Object_PaidKind_SecondForm(), zc_Object_PaidKind(), 2, '������ �����');

   -- ��������� ������� !!! ��� ���� � ����� �����, ���� ����� ����� ������� !!!
   PERFORM lpInsertUpdate_Object(zc_Object_Status_UnComplete(), zc_Object_Status(), 0, '�� ��������');
   PERFORM lpInsertUpdate_Object(zc_Object_Status_Complete(), zc_Object_Status(), 1, '��������');
   PERFORM lpInsertUpdate_Object(zc_Object_Status_Erased(), zc_Object_Status(), 2, '������');

   -- ��������� ������ ������
   PERFORM lpInsertUpdate_Object(zc_Object_AccountGroup_Inventory(), zc_Object_AccountGroup(), 1, '������');
   
   -- ��������� ��������� ������ (�����)
   PERFORM lpInsertUpdate_Object(zc_Object_AccountDirection_Store(), zc_Object_AccountDirection(), 1, '�� �������');
   
   -- ����� ��������� �����   
   PERFORM lpInsertUpdate_Object(zc_Object_Account_InventoryStoreEmpties(), zc_Object_Account(), 1, '������ - �� ��������� - ��������� ����');
   PERFORM lpInsertUpdate_Object(zc_Object_Account_CreditorsSupplierMeat(), zc_Object_Account(), 1, '��������� - ���������� - ������ �����');

   -- ����������� ������������������
   PERFORM setval('object_id_seq', (select max( id ) + 1 from Object));

END $$;

DO $$
DECLARE ioId integer;
BEGIN
   
   IF NOT EXISTS(SELECT * FROM OBJECT 
   JOIN ObjectLink AS RoleRight_Role 
     ON RoleRight_Role.descid = zc_ObjectLink_RoleRight_Role() 
    AND RoleRight_Role.childobjectid = zc_Object_Role_Admin()
    AND RoleRight_Role.objectid = OBJECT.id 
 
   JOIN ObjectLink AS RoleRight_Process 
     ON RoleRight_Process.descid = zc_ObjectLink_RoleRight_Process() 
    AND RoleRight_Process.childobjectid = zc_Object_Process_User()
    AND RoleRight_Process.objectid = OBJECT.id 
  WHERE OBJECT.descid = zc_Object_RoleRight()) THEN
     -- ������� ����� ���� ��������������
     ioId := lpInsertUpdate_Object(ioId, zc_Object_RoleRight(), 0, '');
     PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_RoleRight_Role(), ioId, zc_Object_Role_Admin());
     PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_RoleRight_Process(), ioId, zc_Object_Process_User());
   END IF;
END $$;

DO $$
DECLARE ioId integer;
DECLARE UserId integer;
BEGIN
   -- ������ �������� �������� ���������� ������ ��� �� ��������� �������� ����!!!

   SELECT Id INTO UserId FROM Object WHERE DescId = zc_Object_User() AND ValueData = '�����';

   IF COALESCE(UserId, 0) = 0 THEN
   -- ������� ��������������
     UserId := lpInsertUpdate_Object(0, zc_Object_User(), 0, '�����');

     PERFORM lpInsertUpdate_ObjectString(zc_ObjectString_User_Login(), UserId, '�����');

     PERFORM lpInsertUpdate_ObjectString(zc_ObjectString_User_Password(), UserId, '�����');
   END IF;

   IF NOT EXISTS(SELECT * FROM OBJECT 

     JOIN ObjectLink AS UserRole_Role 
       ON UserRole_Role.descid = zc_ObjectLink_UserRole_Role() 
      AND UserRole_Role.childobjectid = zc_Object_Role_Admin()
      AND UserRole_Role.objectid = OBJECT.id 
 
     JOIN ObjectLink AS UserRole_User 
       ON UserRole_User.descid = zc_ObjectLink_UserRole_User() 
      AND UserRole_User.childobjectid = UserId
      AND UserRole_User.objectid = OBJECT.id 
  WHERE OBJECT.descid = zc_Object_UserRole()) THEN

     -- ��������� ������������ � �����
     ioId := lpInsertUpdate_Object(ioId, zc_Object_UserRole(), 0, '');

     PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_UserRole_Role(), ioId, zc_Object_Role_Admin());

     PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_UserRole_User(), ioId, UserId);
   END IF;
END $$;


--------------------------- !!!!!!!!!!!!!!!!!!!
--------------------------- !!! ����� ����� !!!
--------------------------- !!!!!!!!!!!!!!!!!!!

-- !!! ������ ���������������� ���� !!!
DO $$
BEGIN
PERFORM setval('object_id_seq', (select max (id) + 1 from Object));
END $$;

DO $$
BEGIN
     -- !!! ����������� ���� �������� zc_Object_Status_UnComplete -> zc_Enum_Status_UnComplete
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Object_Status_UnComplete(), inDescId:= zc_Object_Status(), inCode:= 1, inName:= '�� ��������', inEnumName:= 'zc_Enum_Status_UnComplete');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Object_Status_Complete(), inDescId:= zc_Object_Status(), inCode:= 2, inName:= '��������', inEnumName:= 'zc_Enum_Status_Complete');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Object_Status_Erased(), inDescId:= zc_Object_Status(), inCode:= 3, inName:= '������', inEnumName:= 'zc_Enum_Status_Erased');
END $$;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 28.06.13                                        *

*/
