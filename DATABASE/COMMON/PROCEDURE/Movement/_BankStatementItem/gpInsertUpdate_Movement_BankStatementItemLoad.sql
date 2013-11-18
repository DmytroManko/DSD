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
   DECLARE vbMainOKPO TVarChar;
   DECLARE vbMainJuridicalName TVarChar;
   DECLARE vbMovementId Integer;
   DECLARE vbMovementItemId Integer;
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

   -- 2. ���� ������ ����� ���, �� ������ ��������� �� ������ � �������� ���������� ��������
   IF (COALESCE(vbBankAccountFromId, 0) = 0) AND (COALESCE(vbBankAccountToId, 0) = 0) THEN
     -- vbMessage := ; 
      RAISE EXCEPTION '���� "%" � "%" �� ������� � ����������� ������.% �������� �� ��������', inBankAccountFrom, inBankAccountTo, chr(13);
   END IF;

--3. ���� ������ � ���� ���� � �� ����, �� "�������" ��������� ���� "�� ����".

   IF COALESCE(vbBankAccountFromId, 0) <> 0 THEN
      vbMainBankAccountId := vbBankAccountFromId;
      vbMainOKPO := inOKPOTo;
      vbMainJuridicalName := inJuridicalNameTo;
   ELSE
      vbMainBankAccountId := vbBankAccountToId;
      vbMainOKPO := inOKPOFrom;
      vbMainJuridicalName := inJuridicalNameFrom;
   END IF;

--  4. ����� �������� zc_Movement_BankStatement �� ���� � ���������� �����. 
   SELECT Movement.Id INTO vbMovementId 
     FROM Movement
     JOIN MovementLinkObject ON MovementLinkObject.MovementId = Movement.Id AND MovementLinkObject.ObjectId = vbMainBankAccountId
      AND MovementLinkObject.DescId = zc_MovementLinkObject_BankAccount()
    WHERE Movement.OperDate = inOperDate AND Movement.DescId = zc_Movement_BankStatement();

    IF COALESCE(vbMovementId, 0) = 0 THEN
       -- 5. ���� ������ ��������� ��� - ������� ���
       -- ��������� <��������>
       vbMovementId := lpInsertUpdate_Movement (0, zc_Movement_BankStatement(), NEXTVAL ('Movement_BankStatement_seq') :: TVarChar, inOperDate, NULL);              
       PERFORM lpInsertUpdate_MovementLinkObject(zc_MovementLinkObject_BankAccount(), vbMovementId, vbMainBankAccountId);
    END IF;

    --6. ����� �������� zc_Movement_BankStatementItem ������. 
    
    SELECT Movement.Id INTO vbMovementItemId 
     FROM Movement
    WHERE Movement.ParentId = vbMovementId AND 
          Movement.DescId = zc_Movement_BankStatementItem() AND Movement.InvNumber = inDocNumber;

    IF COALESCE(vbMovementItemId, 0) = 0 THEN
       -- 7. ���� ������ ��������� ��� - ������� ���
       -- ��������� <��������>
       vbMovementItemId := lpInsertUpdate_Movement (0, zc_Movement_BankStatementItem(), inDocNumber, inOperDate, vbMovementId);              
    END IF;

    -- ��������� �������� <����� ��������>
    PERFORM lpInsertUpdate_MovementFloat (zc_MovementFloat_Amount(), vbMovementItemId, inAmount);
     -- ��������� �������� <����>
    PERFORM lpInsertUpdate_MovementString (zc_MovementString_OKPO (), vbMovementItemId, vbMainOKPO);

   
/*
9. ���� ���� - �� ��������. */

/*      
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
