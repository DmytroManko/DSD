-- Function: gpInsertUpdate_Movement_BankStatementItem()

DROP FUNCTION IF EXISTS gpUpdate_Movement_BankStatementItem(Integer, Integer, Integer, Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpUpdate_Movement_BankStatementItem(
 INOUT ioId                  Integer   , -- ���� ������� <��������>
    IN inJuridicalId         Integer   , -- ��� 
    IN inInfoMoneyId         Integer   , -- �������������� ������ 
    IN inContractId          Integer   , -- �������  
    IN inUnitId              Integer   , -- �������������
    IN inSession             TVarChar    -- ������ ������������
)                              
RETURNS Integer AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_Movement_BankStatementItem());
     vbUserId := inSession;
      
     IF inJuridicalId = 0 THEN
        inJuridicalId := NULL;
     END IF; 
     IF inInfoMoneyId = 0 THEN
        inInfoMoneyId := NULL;
     END IF; 
     IF inContractId = 0 THEN
        inContractId := NULL;
     END IF; 
     IF inUnitId = 0 THEN
        inUnitId := NULL;
     END IF; 

     -- ��������� ����� � <��. ����>
     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_Juridical(), ioId, inJuridicalId);
     -- ��������� ����� � <�������������� ������>
     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_InfoMoney(), ioId, inInfoMoneyId);
     -- ��������� ����� � <�������>
     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_Contract(), ioId, inContractId);     
     -- ��������� ����� � <�������������>
     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_Unit(), ioId, inUnitId);

     -- ��������� ��������
     -- PERFORM lpInsert_MovementProtocol (ioId, vbUserId);

END;
$BODY$
LANGUAGE PLPGSQL VOLATILE;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
03.12.13                         *
13.08.13          *

*/

-- ����
-- SELECT * FROM gpUpdate_Movement_BankStatementItem (ioId:= 0, inInvNumber:= '-1', inOperDate:= '01.01.2013', inFileName:= 'xxx', inBankAccountId:= 1, inSession:= '2')
