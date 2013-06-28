--------------------------- !!!!!!!!!!!!!!!!!!!
--------------------------- !!! ������ �����, ����� ������������ � ����� ����� ������� !!!
--------------------------- !!!!!!!!!!!!!!!!!!!

CREATE OR REPLACE FUNCTION zc_Enum_Process_Select_Object_Goods()
  RETURNS TVarChar AS
$BODY$BEGIN
  RETURN 'zc_Enum_Process_Select_Object_Goods';
END;$BODY$
LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION zc_Enum_Process_Select_Object_Goods() OWNER TO postgres;


CREATE OR REPLACE FUNCTION zc_Enum_Process_Get_Object_Goods()
  RETURNS TVarChar AS
$BODY$BEGIN
  RETURN 'zc_Enum_Process_Get_Object_Goods';
END;$BODY$
LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION zc_Enum_Process_Get_Object_Goods() OWNER TO postgres;


CREATE OR REPLACE FUNCTION zc_Enum_Process_InsertUpdate_Object_Goods()
  RETURNS TVarChar AS
$BODY$BEGIN
  RETURN 'zc_Enum_Process_InsertUpdate_Object_Goods';
END;$BODY$
LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION zc_Enum_Process_InsertUpdate_Object_Goods() OWNER TO postgres;

-- ��� ������� ��� � �� ������������
-- PERFORM lpInsertUpdate_Object_Process (zc_Enum_Process_Select_Object_Goods(), '�������� ��������� ������');
-- PERFORM lpInsertUpdate_Object_Process (zc_Enum_Process_Get_Object_Goods(), '�������� ������� ������');
-- PERFORM lpInsertUpdate_Object_Process (zc_Enum_Process_InsertUpdate_Object_Goods(), '�������� ���������� ������');

DROP FUNCTION zc_Enum_Process_Select_Object_Goods();
DROP FUNCTION zc_Enum_Process_Get_Object_Goods();
DROP FUNCTION zc_Enum_Process_InsertUpdate_Object_Goods();
--------------------------- !!!!!!!!!!!!!!!!!!!
--------------------------- !!! ����� ����� !!!
--------------------------- !!!!!!!!!!!!!!!!!!!

-- ��������� �������
CREATE OR REPLACE FUNCTION zc_Enum_Process_Select_Object_Goods() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_Select_Object_Goods' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION zc_Enum_Process_Get_Object_Goods() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_Get_Object_Goods' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION zc_Enum_Process_InsertUpdate_Object_Goods() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT ObjectId AS Id FROM ObjectString WHERE ValueData = 'zc_Enum_Process_InsertUpdate_Object_Goods' AND DescId = zc_ObjectString_Enum()); END; $BODY$ LANGUAGE plpgsql;

-- ����������� �������� ����������� (zc_Object_Process)
DO $$
BEGIN
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_Select_Object_Goods(), inDescId:= zc_Object_Process(), inCode:= lfGet_ObjectCode_byEnum ('zc_Enum_Process_Select_Object_Goods'), inName:= '�������� ��������� ������', inEnumName:= 'zc_Enum_Process_Select_Object_Goods');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_Get_Object_Goods(), inDescId:= zc_Object_Process(), inCode:= lfGet_ObjectCode_byEnum ('zc_Enum_Process_Get_Object_Goods'), inName:= '�������� ������� ������', inEnumName:= 'zc_Enum_Process_Get_Object_Goods');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Process_InsertUpdate_Object_Goods(), inDescId:= zc_Object_Process(), inCode:= lfGet_ObjectCode_byEnum ('zc_Enum_Process_InsertUpdate_Object_Goods'), inName:= '�������� ���������� ������', inEnumName:= 'zc_Enum_Process_InsertUpdate_Object_Goods');
END $$;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 28.06.13                                        *
 20.06.13          *                             *

*/