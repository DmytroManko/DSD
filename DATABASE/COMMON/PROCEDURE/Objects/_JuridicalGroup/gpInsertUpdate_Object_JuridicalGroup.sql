-- Function: gpInsertUpdate_Object_JuridicalGroup()

-- DROP FUNCTION gpInsertUpdate_Object_JuridicalGroup();

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_JuridicalGroup(
INOUT ioId	         Integer   ,   	-- ���� ������� <������ �� ���>
IN inCode                Integer   ,    -- ��� ������� <������ �� ���>
IN inName                TVarChar  ,    -- �������� ������� <������ �� ���>
IN inJuridicalGroupId    Integer   ,    -- ������ �� ������ �� ���
IN inSession             TVarChar       -- ������� ������������
)
  RETURNS integer AS
$BODY$BEGIN
--   PERFORM lpCheckRight(inSession, zc_Enum_Process_JuridicalGroup());

   -- �������� ������������ �����
   PERFORM lpCheckUnique_Object_ValueData(ioId, zc_Object_JuridicalGroup(), inName);
   -- �������� ���� � ������
   PERFORM lpCheck_Object_CycleLink(ioId, zc_ObjectLink_JuridicalGroup_Parent(), inJuridicalGroupId);

   -- ��������� ������
   ioId := lpInsertUpdate_Object(ioId, zc_Object_JuridicalGroup(), inCode, inName);
   -- ��������� ������
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_JuridicalGroup_Parent(), ioId, inJuridicalGroupId);

END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION gpInsertUpdate_Object_JuridicalGroup(Integer, Integer, TVarChar, Integer, tvarchar)
  OWNER TO postgres;


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 14.05.13                                        * Code Pages

*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_JuridicalGroup()
