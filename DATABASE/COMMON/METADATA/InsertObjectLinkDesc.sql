insert into ObjectLinkDesc(Id, Code, ItemName, ObjectDescId, ChildObjectDescId)
values (zc_ObjectLink_RoleRight_Role(), 'RoleRight_Role', '������ �� ���� � ����������� �������� �����', zc_Object_RoleRight(), zc_Object_Role());

insert into ObjectLinkDesc(Id, Code, ItemName, ObjectDescId, ChildObjectDescId)
values (zc_ObjectLink_RoleRight_Process(), 'RoleRight_Process', '������ �� ������� � ����������� �������� �����', zc_Object_RoleRight(), zc_Object_Process());

insert into ObjectLinkDesc(Id, Code, ItemName, ObjectDescId, ChildObjectDescId)
values (zc_ObjectLink_UserRole_Role(), 'UserRole_Role', '������ �� ���� � ����������� ����� ������������� � �����', zc_Object_UserRole(), zc_Object_Role());

insert into ObjectLinkDesc(Id, Code, ItemName, ObjectDescId, ChildObjectDescId)
values (zc_ObjectLink_UserRole_User(), 'UserRole_User', '����� � ������������� � ����������� ����� ������������', zc_Object_UserRole(), zc_Object_User());

insert into ObjectLinkDesc(Id, Code, ItemName, ObjectDescId, ChildObjectDescId)
values (zc_ObjectLink_Cash_Currency(), 'Cash_Currency', '����� ����� � �������', zc_Object_Cash(), zc_Object_Currency());

insert into ObjectLinkDesc(Id, Code, ItemName, ObjectDescId, ChildObjectDescId)
values (zc_ObjectLink_Cash_Branch(), 'Cash_Branch', '����� ����� � ��������', zc_Object_Cash(), zc_Object_Branch());
