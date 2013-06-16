-- Function: gpInsertUpdate_Object_InfoMoney()

-- DROP FUNCTION gpInsertUpdate_Object_InfoMoney();

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_InfoMoney(
 INOUT ioId                     Integer   ,    -- ���� ������� <������ ����������>
    IN inCode                   Integer   ,    -- ��� ������� <������ ����������>
    IN inName                   TVarChar  ,    -- �������� ������� <������ ����������>
    IN inInfoMoneyGroupId       Integer   ,    -- ������ �� <������ �������������� ����������>
    IN inInfoMoneyDestinationId Integer   ,    -- ������ �� <�������������� ����������>
    IN inSession                TVarChar       -- ������ ������������
)
  RETURNS integer AS
$BODY$
   DECLARE UserId Integer;
   DECLARE Code_max Integer; 
BEGIN

   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight(inSession, zc_Enum_Process_InfoMoney());
   UserId := inSession;

   -- ���� ��� �� ����������, ���������� ��� ��� ���������+1
   IF COALESCE (inCode, 0) = 0
   THEN 
       SELECT COALESCE (MAX (ObjectCode), 0) + 1 INTO Code_max FROM Object WHERE Object.DescId = zc_Object_InfoMoney();
   ELSE
       Code_max := inCode;
   END IF; 

   -- !!! �������� ���� ������������ <������������>
   -- !!! PERFORM lpCheckUnique_Object_ValueData(ioId, zc_Object_InfoMoney(), inName);

   -- �������� ������������ <���>
   PERFORM lpCheckUnique_Object_ObjectCode (ioId, zc_Object_InfoMoney(), Code_max);

   -- ��������� ������
   ioId := lpInsertUpdate_Object( ioId, zc_Object_InfoMoney(), inCode, inName);
   -- ��������� ����� � <������ �������������� ����������>
   PERFORM lpInsertUpdate_ObjectLink( zc_ObjectLink_InfoMoney_InfoMoneyGroup(), ioId, inInfoMoneyGroupId);
   -- ��������� ����� � <�������������� ����������>
   PERFORM lpInsertUpdate_ObjectLink( zc_ObjectLink_InfoMoney_InfoMoneyDestination(), ioId, inInfoMoneyDestinationId);

END;$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpInsertUpdate_Object_InfoMoney (Integer, Integer, TVarChar, Integer, Integer, TVarChar) OWNER TO postgres;


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 16.06.13                                        * rem lpCheckUnique_Object_ValueData

*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_Contract()
