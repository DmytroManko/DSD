-- Function: lpInsertUpdate_Object_Enum() - ������ �� �� ....

-- DROP FUNCTION lpInsertUpdate_Object_Enum (IN inId Integer, IN inDescId Integer, IN inObjectCode Integer, IN inValueData TVarChar, IN inEnumName TVarChar);

CREATE OR REPLACE FUNCTION lpInsertUpdate_Object_Enum(
    IN inId           Integer   ,    -- <���� �������>
    IN inDescId       Integer   , 
    IN inCode         Integer   , 
    IN inName         TVarChar  ,
    IN inEnumName     TVarChar
)
RETURNS VOID AS
$BODY$
   DECLARE vbCode Integer;   
BEGIN

   -- ���� ��� �� ����������, ���������� ��� ��� ��������� + 1
   vbCode:= lfGet_ObjectCode (inCode, inDescId);

   -- ��������� <������>
   inId := lpInsertUpdate_Object (inId, inDescId, vbCode, inName);

   -- ��������� �������� <Enum>
   PERFORM lpInsertUpdate_ObjectString (zc_ObjectString_Enum(), inId, inEnumName);

END;$BODY$ LANGUAGE plpgsql;
ALTER FUNCTION lpInsertUpdate_Object_Enum (Integer, Integer, Integer, TVarChar, TVarChar) OWNER TO postgres; 


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 28.06.13                                        *

*/

-- ����
-- SELECT * FROM lpInsertUpdate_Object_Enum (0, zc_Object_Goods(), -1, 'test-goods');
