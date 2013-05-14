-- Function: gpInsertUpdate_Object_Contract()

-- DROP FUNCTION gpInsertUpdate_Object_Contract (Integer, TVarChar, TVarChar, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_Contract(
 INOUT ioId             Integer,       -- ���� ������� <�������>
    IN inInvNumber      TVarChar,      -- �������� <����� ��������>
    IN inComment        TVarChar,      -- �������� <�����������>
    IN inSession        TVarChar       -- ������ ������������
)
RETURNS Integer AS
$BODY$
   DECLARE UserId Integer;
BEGIN


   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Contract());
   UserId := inSession;

   -- �������� ���� ������������ ��� �������� <����� ��������>
   PERFORM lpCheckUnique_ObjectString_ValueData (ioId, zc_ObjectString_Contract_InvNumber(), inInvNumber);

   -- ��������� <������>
   ioId := lpInsertUpdate_Object (ioId, zc_Object_Contract(), 0, '');
   
   -- ��������� �������� <����� ��������>
   PERFORM lpInsertUpdate_ObjectString (zc_ObjectString_Contract_InvNumber(), ioId, inInvNumber);

   -- ��������� �������� <�����������>
   PERFORM lpInsertUpdate_ObjectString (zc_ObjectString_Contract_Comment(), ioId, inComment);

   -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (ioId, UserId);

END;$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpInsertUpdate_Object_Contract (Integer, TVarChar, TVarChar, TVarChar) OWNER TO postgres;


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 12.04.13                                        *

*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_Contract()
