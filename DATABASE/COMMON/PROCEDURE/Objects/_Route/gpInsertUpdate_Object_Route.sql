-- Function: gpInsertUpdate_Object_Route()

-- DROP FUNCTION gpInsertUpdate_Object_Route (Integer, TVarChar, TVarChar, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_Route(
 INOUT ioId             Integer,       -- ���� ������� <�������>
    IN inCode           Integer,       -- �������� <��� ��������>
    IN inName           TVarChar,      -- �������� <������������ ��������>
    IN inSession        TVarChar       -- ������ ������������
)
RETURNS Integer AS
$BODY$
   DECLARE UserId Integer;
BEGIN


   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Route());
   UserId := inSession;

   -- �������� ���� ������������ ��� �������� <�������>
   PERFORM lpCheckUnique_ObjectString_ValueData (ioId, zc_Object_Route(), inName);

   -- ��������� <������>
   ioId := lpInsertUpdate_Object (ioId, zc_Object_Route(), inCode, inName);
   
      -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (ioId, UserId);

END;$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpInsertUpdate_Object_Route (Integer, Integer, TVarChar, TVarChar) OWNER TO postgres;


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 03.06.13          *

*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_Route()
