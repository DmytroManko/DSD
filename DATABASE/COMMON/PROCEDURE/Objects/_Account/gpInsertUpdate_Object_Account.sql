-- Function: gpInsertUpdate_Object_Account (Integer, TVarChar)

-- DROP FUNCTION gpInsertUpdate_Object_Account (Integer, Integer, TVarChar, Integer, Integer, Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_Account(
 INOUT ioId                     Integer,    -- ���� ������� <����>
    IN inCode                   Integer,    -- ��� ������� <����>
    IN inName                   TVarChar,   -- �������� ������� <����>
    IN inAccountGroupId         Integer,    -- ������ ������
    IN inAccountDirectionId     Integer,    -- ��������� ����� (�����)
    IN inInfoMoneyDestinationId Integer,    -- ��������� ����� (����������)
    IN inInfoMoneyId            Integer,    -- �������������� ���������
    IN inIAccountKindId         Integer,    -- ���� ������
    IN inSession                TVarChar    -- ������ ������������
)
  RETURNS Integer AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbCode_calc Integer;   
BEGIN

   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_Object_Account());
    vbUserId := inSession;

   -- ���� ��� �� ����������, ���������� ��� ��� ��������� + 1
   vbCode_calc:=lfGet_ObjectCode (inCode, zc_Object_Account()); 

   -- �������� ������������ ��� �������� <���>
   PERFORM lpCheckUnique_Object_ObjectCode (ioId, zc_Object_Account(), vbCode_calc);

   -- ��������� <������>
   ioId := lpInsertUpdate_Object (ioId, zc_Object_Account(), vbCode_calc, inName);

   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Account_AccountGroup(), ioId, inAccountGroupId);
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Account_AccountDirection(), ioId, inAccountDirectionId);
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Account_InfoMoneyDestination(), ioId, inInfoMoneyDestinationId);
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Account_InfoMoney(), ioId, inInfoMoneyId);
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Account_AccountKind(), ioId, inIAccountKindId);

   -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (ioId, vbUserId);

END;
$BODY$

LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION gpInsertUpdate_Object_Account (Integer, Integer, TVarChar, Integer, Integer, Integer, Integer, Integer, TVarChar)  OWNER TO postgres;

  
/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 05.07.13          * + AccountKind
 02.07.13                                        * change CodePage
 17.06.13          *
*/
