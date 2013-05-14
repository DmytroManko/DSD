-- Function: gpInsertUpdate_Object_UnitGroup()

-- DROP FUNCTION gpInsertUpdate_Object_UnitGroup();

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_UnitGroup(
INOUT ioId	         Integer   ,   	-- ���� ������� <������ �������������>
IN inCode                Integer   ,    -- ��� ������� <������ �������������>
IN inName                TVarChar  ,    -- �������� ������� <������ �������������>
IN inParentId            Integer   ,    -- ������ �� ������ �������������
IN inSession             TVarChar       -- ������� ������������
)
  RETURNS integer AS
$BODY$BEGIN
--   PERFORM lpCheckRight(inSession, zc_Enum_Process_UnitGroup());

   -- �������� ������������ �����
   PERFORM lpCheckUnique_Object_ValueData(ioId, zc_Object_UnitGroup(), inName);
   -- �������� ���� � ������
   PERFORM lpCheck_Object_CycleLink(ioId, zc_ObjectLink_UnitGroup_Parent(), inParentId);

   -- ��������� ������
   ioId := lpInsertUpdate_Object(ioId, zc_Object_UnitGroup(), inCode, inName);
   -- ��������� ������
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_UnitGroup_Parent(), ioId, inParentId);

END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION gpInsertUpdate_Object_UnitGroup(Integer, Integer, TVarChar, Integer, tvarchar)
  OWNER TO postgres;


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 14.05.13                                        * Code Pages

*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_UnitGroup()
