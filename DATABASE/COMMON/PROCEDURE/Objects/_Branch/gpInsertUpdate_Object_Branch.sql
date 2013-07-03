-- Function: gpInsertUpdate_Object_Branch(Integer, Integer, TVarChar, Integer, TVarChar)

-- DROP FUNCTION gpInsertUpdate_Object_Branch(Integer, Integer, TVarChar, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_Branch(
 INOUT ioId	                 Integer,       -- ���� ������� < ������>
    IN inCode                Integer,       -- ��� ������� <������> 
    IN inName                TVarChar,      -- �������� ������� <������>
    IN inSession             TVarChar       -- ������ ������������
)
RETURNS integer AS
$BODY$
   DECLARE UserId Integer;
BEGIN

   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight(inSession, zc_Enum_Process_Branch());
   UserId := inSession;

   -- ���� ��� �� ����������, ���������� ��� ��� ���������+1
   inCode := lfGet_ObjectCode(inCode, zc_Object_Branch());

   -- �������� ���� ������������ ��� �������� <������������ �������>
   PERFORM lpCheckUnique_Object_ValueData(ioId, zc_Object_Branch(), inName);
   -- �������� ���� ������������ ��� �������� <��� �������>
   PERFORM lpCheckUnique_Object_ObjectCode(ioId, zc_Object_Branch(), inCode);

   -- ��������� <������>
   ioId := lpInsertUpdate_Object(ioId, zc_Object_Branch(), inCode, inName);

   -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (ioId, UserId);

END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION gpInsertUpdate_Object_Branch (Integer, Integer, TVarChar, TVarChar) OWNER TO postgres;



/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 10.05.13          *
 05.06.13          
 02.07.13                        * ����� JuridicalId     
*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_Branch(1,1,'','')