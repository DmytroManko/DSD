CREATE OR REPLACE FUNCTION zc_Enum_Process_InsertUpdate_Object_User() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_InsertUpdate_Object_User' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION zc_Enum_Process_Get_Object_User() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_Get_Object_User' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION zc_Enum_Process_Select_Object_User() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_Select_Object_User' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql;

DO $$
BEGIN

PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_InsertUpdate_Object_User()
                                  , inDescId:= zc_Object_Process()
                                  , inCode:= 1
                                  , inName:= '���������� <������������> - ���������� ������.'
                                  , inEnumName:= 'zc_Enum_Process_InsertUpdate_Object_User');

PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_Get_Object_User()
                                  , inDescId:= zc_Object_Process()
                                  , inCode:= 2
                                  , inName:= '���������� <������������> - ����� ������.'
                                  , inEnumName:= 'zc_Enum_Process_Get_Object_User');

PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_Select_Object_User()
                                  , inDescId:= zc_Object_Process()
                                  , inCode:= 3
                                  , inName:= '���������� <������������> - ��������� ������.'
                                  , inEnumName:= 'zc_Enum_Process_Select_Object_User');

END $$;


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 07.10.13                                        *
*/
