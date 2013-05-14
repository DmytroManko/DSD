-- Function: gpInsertUpdate_Object_GoodsGroup()

-- DROP FUNCTION gpInsertUpdate_Object_GoodsGroup();

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_GoodsGroup(
INOUT ioId	         Integer   ,   	-- ���� ������� <������ �������������>
IN inCode                Integer   ,    -- ��� ������� <������ �������>
IN inName                TVarChar  ,    -- �������� ������� <������ �������>
IN inParentId            Integer   ,    -- ������ �� ������ �������
IN inSession             TVarChar       -- ������� ������������
)
  RETURNS integer AS
$BODY$BEGIN
--   PERFORM lpCheckRight(inSession, zc_Enum_Process_GoodsGroup());

   --!!! �������� ������������ �����
   --!!! PERFORM lpCheckUnique_Object_ValueData(ioId, zc_Object_GoodsGroup(), inName);

   -- �������� ���� � ������
   PERFORM lpCheck_Object_CycleLink(ioId, zc_ObjectLink_GoodsGroup_Parent(), inParentId);
   
   -- ��������� ������
   ioId := lpInsertUpdate_Object(ioId, zc_Object_GoodsGroup(), inCode, inName);
   -- ��������� ������
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_GoodsGroup_Parent(), ioId, inParentId);

END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION gpInsertUpdate_Object_GoodsGroup(Integer, Integer, TVarChar, Integer, tvarchar)
  OWNER TO postgres;


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 11.05.13                                        * rem lpCheckUnique_Object_ValueData
*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_GoodsGroup
