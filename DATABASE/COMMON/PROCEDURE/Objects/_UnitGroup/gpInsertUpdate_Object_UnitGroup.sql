-- Function: gpInsertUpdate_Object_UnitGroup()

-- DROP FUNCTION gpInsertUpdate_Object_UnitGroup();

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_UnitGroup(
 INOUT ioId	                 Integer   ,   	-- ���� ������� <������ �������������>
    IN inCode                Integer   ,    -- ��� ������� <������ �������������>
    IN inName                TVarChar  ,    -- �������� ������� <������ �������������>
    IN inParentId            Integer   ,    -- ������ �� ������ �������������
    IN inSession             TVarChar       -- ������ ������������
)
  RETURNS integer AS
$BODY$
  DECLARE UserId Integer;
  DECLARE Code_max Integer;   
 
BEGIN

   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight(inSession, zc_Enum_Process_UnitGroup());
   UserId := inSession;

   -- ���� ��� �� ����������, ���������� ��� ��� ���������+1
   IF COALESCE (inCode, 0) = 0
   THEN 
       SELECT MAX (ObjectCode) + 1 INTO Code_max FROM Object WHERE Object.DescId = zc_Object_UnitGroup();
   ELSE
       Code_max := inCode;
   END IF; 
   
   -- �������� ������������ �����
   PERFORM lpCheckUnique_Object_ValueData(ioId, zc_Object_UnitGroup(), inName);
   -- �������� ������������ ��� �������� <��� ������ �������������>
   PERFORM lpCheckUnique_Object_ObjectCode (ioId, zc_Object_UnitGroup(), Code_max);

   -- �������� ���� � ������
   PERFORM lpCheck_Object_CycleLink(ioId, zc_ObjectLink_UnitGroup_Parent(), inParentId);

   -- ��������� ������
   ioId := lpInsertUpdate_Object(ioId, zc_Object_UnitGroup(), Code_max, inName);
   -- ��������� ������
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_UnitGroup_Parent(), ioId, inParentId);

   -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (ioId, UserId);

END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION gpInsertUpdate_Object_UnitGroup(Integer, Integer, TVarChar, Integer, tvarchar)
  OWNER TO postgres;


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 14.06.13              
 14.05.13                                        * 1251Cyr

*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_UnitGroup()
