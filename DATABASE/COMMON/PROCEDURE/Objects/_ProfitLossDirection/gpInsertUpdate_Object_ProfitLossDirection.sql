-- Function: gpInsertUpdate_Object_ProfitLossDirection(Integer, Integer, TVarChar, TVarChar)

-- DROP FUNCTION gpInsertUpdate_Object_ProfitLossDirection (Integer, Integer, TVarChar, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_ProfitLossDirection(
 INOUT ioId             Integer,       -- ���� ������� <��������� ������ ������ � �������� � ������� - �����������>
    IN inCode           Integer,       -- �������� <���>
    IN inName           TVarChar,      -- �������� <������������>
    IN inSession        TVarChar       -- ������ ������������
)
RETURNS Integer AS
$BODY$
   DECLARE UserId Integer;
   DECLARE Code_max Integer;   
 
BEGIN
 
   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight (inSession, zc_Enum_Process_ProfitLossDirection());
   UserId := inSession;

   -- ���� ��� �� ����������, ���������� ��� ��� ���������+1
   IF COALESCE (inCode, 0) = 0
   THEN 
       SELECT COALESCE (MAX (ObjectCode), 0) + 1 INTO Code_max FROM Object WHERE Object.DescId = zc_Object_ProfitLossDirection();
   ELSE
       Code_max := inCode;
   END IF; 
   
   -- !!! �������� ������������ ��� �������� <������������>
   -- !!! PERFORM lpCheckUnique_Object_ValueData (ioId, zc_Object_ProfitLossDirection(), inName);

   -- �������� ������������ ��� �������� <���>
   PERFORM lpCheckUnique_Object_ObjectCode (ioId, zc_Object_ProfitLossDirection(), Code_max);

   -- ��������� <������>
   ioId := lpInsertUpdate_Object (ioId, zc_Object_ProfitLossDirection(), Code_max, inName);
   
   -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (ioId, UserId);

END;$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpInsertUpdate_Object_ProfitLossDirection (Integer, Integer, TVarChar, TVarChar) OWNER TO postgres;


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 19.06.13                                        * rem lpCheckUnique_Object_ValueData
 18.06.13          *

*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_ProfitLossDirection()
