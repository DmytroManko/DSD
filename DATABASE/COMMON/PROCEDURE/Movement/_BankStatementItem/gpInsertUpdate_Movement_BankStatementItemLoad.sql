-- Function: gpInsertUpdate_Movement_BankStatementItemLoad()

DROP FUNCTION IF EXISTS gpInsertUpdate_Movement_BankStatementItemLoad();

CREATE OR REPLACE FUNCTION gpInsertUpdate_Movement_BankStatementItemLoad(
    IN inDocNumber           TVarChar  , -- ����� ���������
    IN inOperDate            TDateTime , -- ���� ���������
    IN inBankAccountFrom     TVarChar  , -- ��������� ����
    IN inBankMFOFrom         TVarChar  , -- ��� 
    IN inOKPOFrom            TVarChar  , -- ����
    IN inJuridicalNameFrom   TVarChar  , -- ����
    IN inBankAccountTo       TVarChar  , -- ��������� ����
    IN inBankMFOTo           TVarChar  , -- ��� 
    IN inOKPOTo              TVarChar  , -- ����
    IN inJuridicalNameTo     TVarChar  , -- ����
    IN inAmount              TFloat    , -- ����� �������� 
    IN inSession             TVarChar    -- ������ ������������
)                              
RETURNS Integer AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbBankAccountFromId Integer;
   DECLARE vbBankAccountToId Integer;
   DECLARE vbMainBankAccountId integer;
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_Movement_BankStatementItem());
    vbUserId := inSession;

   -- 1. ����� ���� �� ���� � ���� � ����������� ������. 
   SELECT Object_BankAccount.Id INTO vbBankAccountFromId 
     FROM Object AS Object_BankAccount 
    WHERE Object_BankAccount.DescId = zc_Object_BankAccount() AND Object_BankAccount.ValueData = inBankAccountFrom;

   SELECT Object_BankAccount.Id INTO vbBankAccountToId 
     FROM Object AS Object_BankAccount 
    WHERE Object_BankAccount.DescId = zc_Object_BankAccount() AND Object_BankAccount.ValueData = inBankAccountTo;

   -- 3. ���� ������ ����� ���, �� ������ ��������� �� ������ � �������� ���������� ��������
   IF (COALESCE(vbBankAccountFromId, 0) = 0) AND (COALESCE(vbBankAccountToId, 0) = 0) THEN
     -- vbMessage := ; 
      RAISE EXCEPTION '���� "%" � "%" �� ������� � ����������� ������.% �������� �� ��������', inBankAccountFrom, inBankAccountTo, chr(13);
   END IF;



/*
4. ���� ������ � ���� ���� � �� ����, �� "�������" ��������� ���� "�� ����".
5. ����� �������� zc_Movement_BankStatement �� ���� � ���������� �����. 
6. ���� ������ ��������� ��� - ������� ���
7. ����� �������� zc_Movement_BankStatementItem ������. 
8. ���� ��� ��� - �� �������
9. ���� ���� - �� ��������. */

/*      -- ��������� <��������>
     ioId := lpInsertUpdate_Movement (ioId, zc_Movement_BankStatementItem(), inInvNumber, inOperDate, NULL);

     -- ��������� �������� <����>
     PERFORM lpInsertUpdate_MovementString (zc_MovementString_OKPO (), ioId, inOKPO);
     -- ��������� �������� <����� ��������>
     PERFORM lpInsertUpdate_MovementFloat (zc_MovementFloat_Amount(), ioId, inAmount);

     -- ��������� ����� � <�������������� ������>
     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_InfoMoney(), ioId, inInfoMoneyId);
     
     -- ��������� ����� � <�������>
     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_Contract(), ioId, inContractId);     
     
     -- ��������� ����� � <�������������>
     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_Unit(), ioId, inUnitId);

     -- ��������� ��������
     -- PERFORM lpInsert_MovementProtocol (ioId, vbUserId);
  */
   RETURN 0;
END;
$BODY$
LANGUAGE PLPGSQL VOLATILE;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
13.11.13                          *

*/

-- ����
-- SELECT * FROM gpInsertUpdate_Movement_BankStatementItemLoad (ioId:= 0, inInvNumber:= '-1', inOperDate:= '01.01.2013', inFileName:= 'xxx', inBankAccountId:= 1, inSession:= '2')
