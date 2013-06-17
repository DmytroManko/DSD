-- Function: gpInsertUpdate_Object_JuridicalGroup()

-- DROP FUNCTION gpInsertUpdate_Object_JuridicalGroup();

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_JuridicalGroup(
 INOUT ioId	                 Integer   ,   	-- ���� ������� <������ �� ���>
    IN inCode                Integer   ,    -- ��� ������� <������ �� ���>
    IN inName                TVarChar  ,    -- �������� ������� <������ �� ���>
    IN inParentId            Integer   ,    -- ������ �� ������ �� ���
    IN inSession             TVarChar       -- ������ ������������
)
  RETURNS integer AS
$BODY$
   DECLARE UserId Integer;
   DECLARE Code_max Integer;   
 
BEGIN
   
   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight(inSession, zc_Enum_Process_JuridicalGroup());
   UserId := inSession;

   -- ���� ��� �� ����������, ���������� ��� ��� ���������+1
   IF COALESCE (inCode, 0) = 0
   THEN 
       SELECT MAX (ObjectCode) + 1 INTO Code_max FROM Object WHERE Object.DescId = zc_Object_JuridicalGroup();
   ELSE
       Code_max := inCode;
   END IF; 
   
   -- �������� ������������ ��� �������� <�������� ������ �� ���>
   PERFORM lpCheckUnique_Object_ValueData(ioId, zc_Object_JuridicalGroup(), inName);
   -- �������� ���� ������������ ��� �������� <��� ������ �� ���>
   PERFORM lpCheckUnique_Object_ObjectCode (ioId, zc_Object_JuridicalGroup(), Code_max);
   -- �������� ���� � ������
   PERFORM lpCheck_Object_CycleLink(ioId, zc_ObjectLink_JuridicalGroup_Parent(), inParentId);

   -- ��������� ������
   ioId := lpInsertUpdate_Object(ioId, zc_Object_JuridicalGroup(), inCode, inName);
   -- ��������� ������
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_JuridicalGroup_Parent(), ioId, inParentId);
   
   -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (ioId, UserId);
 
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION gpInsertUpdate_Object_JuridicalGroup(Integer, Integer, TVarChar, Integer, tvarchar)
  OWNER TO postgres;


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 13.06.13          *
 14.05.13                                        * Code Pages

*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_JuridicalGroup()
