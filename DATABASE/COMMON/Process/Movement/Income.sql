-- �������� <������>
CREATE OR REPLACE FUNCTION zc_Enum_Process_InsertUpdate_Movement_Income() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_InsertUpdate_Movement_Income' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_Process_Get_Movement_Income() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_Get_Movement_Income' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_Process_Select_Movement_Income() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_Select_Movement_Income' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql IMMUTABLE;

-- �������� <������ (�������� ����)>
CREATE OR REPLACE FUNCTION zc_Enum_Process_InsertUpdate_Movement_IncomeFuel() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_InsertUpdate_Movement_IncomeFuel' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_Process_Get_Movement_IncomeFuel() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_Get_Movement_IncomeFuel' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_Process_Select_Movement_IncomeFuel() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_Select_Movement_IncomeFuel' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql IMMUTABLE;

-- �������� <������ (�������� ����) - ������� ����>
CREATE OR REPLACE FUNCTION zc_Enum_Process_InsertUpdate_Movement_TransportIncome() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_InsertUpdate_Movement_TransportIncome' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_Process_Select_Movement_TransportIncome() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_Select_Movement_TransportIncome' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql IMMUTABLE;

-- Status
CREATE OR REPLACE FUNCTION zc_Enum_Process_Update_Status_Income_UnComplete() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_Update_Status_Income_UnComplete' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_Process_Update_Status_Income_Complete() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_Update_Status_Income_Complete' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql IMMUTABLE;
CREATE OR REPLACE FUNCTION zc_Enum_Process_Update_Status_Income_Erased() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_Update_Status_Income_Erased' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql IMMUTABLE;

DO $$
BEGIN

-- �������� <������>
PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_InsertUpdate_Movement_Income()
                                  , inDescId:= zc_Object_Process()
                                  , inCode:= 1
                                  , inName:= '�������� <������> - ���������� ������.'
                                  , inEnumName:= 'zc_Enum_Process_InsertUpdate_Movement_Income');

PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_Get_Movement_Income()
                                  , inDescId:= zc_Object_Process()
                                  , inCode:= 2
                                  , inName:= '�������� <������> - ����� ������.'
                                  , inEnumName:= 'zc_Enum_Process_Get_Movement_Income');

PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_Select_Movement_Income()
                                  , inDescId:= zc_Object_Process()
                                  , inCode:= 3
                                  , inName:= '�������� <������> - ��������� ������.'
                                  , inEnumName:= 'zc_Enum_Process_Select_Movement_Income');
                                  
-- �������� <������ (�������� ����)>
PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_InsertUpdate_Movement_IncomeFuel()
                                  , inDescId:= zc_Object_Process()
                                  , inCode:= 1
                                  , inName:= '�������� <������ (�������� ����)> - ���������� ������.'
                                  , inEnumName:= 'zc_Enum_Process_InsertUpdate_Movement_IncomeFuel');

PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_Get_Movement_IncomeFuel()
                                  , inDescId:= zc_Object_Process()
                                  , inCode:= 2
                                  , inName:= '�������� <������ (�������� ����)> - ����� ������.'
                                  , inEnumName:= 'zc_Enum_Process_Get_Movement_IncomeFuel');

PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_Select_Movement_IncomeFuel()
                                  , inDescId:= zc_Object_Process()
                                  , inCode:= 3
                                  , inName:= '�������� <������ (�������� ����)> - ��������� ������.'
                                  , inEnumName:= 'zc_Enum_Process_Select_Movement_IncomeFuel');

-- �������� <������ (�������� ����) - ������� ����>
PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_InsertUpdate_Movement_TransportIncome()
                                  , inDescId:= zc_Object_Process()
                                  , inCode:= 1
                                  , inName:= '�������� <������ (�������� ����)> - ���������� ������.'
                                  , inEnumName:= 'zc_Enum_Process_InsertUpdate_Movement_TransportIncome');

PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_Select_Movement_TransportIncome()
                                  , inDescId:= zc_Object_Process()
                                  , inCode:= 3
                                  , inName:= '�������� <������ (�������� ����)> - ��������� ������.'
                                  , inEnumName:= 'zc_Enum_Process_Select_Movement_TransportIncome');

-- Status
PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_Update_Status_Income_UnComplete()
                                  , inDescId:= zc_Object_Process()
                                  , inCode:= 1
                                  , inName:= '�������� <������> - �������������.'
                                  , inEnumName:= 'zc_Enum_Process_Update_Status_Income_UnComplete');

PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_Update_Status_Income_Complete()
                                  , inDescId:= zc_Object_Process()
                                  , inCode:= 1
                                  , inName:= '�������� <������> - ����������.'
                                  , inEnumName:= 'zc_Enum_Process_Update_Status_Income_Complete');

PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_Update_Status_Income_Erased()
                                  , inDescId:= zc_Object_Process()
                                  , inCode:= 1
                                  , inName:= '�������� <������> - ��������.'
                                  , inEnumName:= 'zc_Enum_Process_Update_Status_Income_Erased');

END $$;


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 07.10.13                                        *
*/
