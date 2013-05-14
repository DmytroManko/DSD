-- Function: gpInsertUpdate_Object_Unit()

-- DROP FUNCTION gpInsertUpdate_Object_Unit();

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_Unit(
INOUT ioId	         Integer   ,   	-- ���� ������� <�������������>
IN inCode                Integer   ,    -- ��� ������� <�������������>
IN inName                TVarChar  ,    -- �������� ������� <�������������>
IN inUnitGroupId         Integer   ,    -- ������ �� ������ �������������
IN inBranchId            Integer   ,    -- ������ �� ������
IN inSession             TVarChar       -- ������� ������������
)
  RETURNS integer AS
$BODY$BEGIN
--   PERFORM lpCheckRight(inSession, zc_Enum_Process_UnitGroup());

   -- !!! -- �������� ������������ �����
   -- !!! PERFORM lpCheckUnique_Object_ValueData(ioId, zc_Object_Unit(), inName);

   -- ��������� ������
   ioId := lpInsertUpdate_Object(ioId, zc_Object_Unit(), inCode, inName);
   -- ��������� ������
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Unit_UnitGroup(), ioId, inUnitGroupId);
   -- ��������� ������
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Unit_Branch(), ioId, inBranchId);

END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION gpInsertUpdate_Object_Unit(Integer, Integer, TVarChar, Integer, Integer, tvarchar)
  OWNER TO postgres;


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 13.05.13                                        * rem lpCheckUnique_Object_ValueData

*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_Unit ()                            
