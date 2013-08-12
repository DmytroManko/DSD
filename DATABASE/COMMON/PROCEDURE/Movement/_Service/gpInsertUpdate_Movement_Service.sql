-- Function: gpInsertUpdate_Movement_Service()

-- DROP FUNCTION gpInsertUpdate_Movement_Service();

CREATE OR REPLACE FUNCTION gpInsertUpdate_Movement_Service(
 INOUT ioId                  Integer   , -- ���� ������� <��������>
    IN inInvNumber           TVarChar  , -- ����� ���������
    IN inOperDate            TDateTime , -- ���� ���������
    IN inAmount              TFloat    , -- ����� �������� 
    IN inJuridicalId         Integer   , -- ��. ����	
    IN inMainJuridicalId     Integer   , -- ������� ��. ����	
    IN inBusinessId          Integer   , -- ������    
    IN inPaidKindId          Integer   , -- ���� ���� ������
    IN inInfoMoneyId         Integer   , -- ������ ���������� 
    IN inUnitId              Integer   , -- �������������
    IN inSession             TVarChar    -- ������ ������������
)                              
RETURNS Integer AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_Movement_Service());
     vbUserId := inSession;

     -- ��������� <��������>
     ioId := lpInsertUpdate_Movement (ioId, zc_Movement_Service(), inInvNumber, inOperDate, NULL);

     -- ��������� �������� <����� ��������>
     PERFORM lpInsertUpdate_MovementFloat (zc_MovementFloat_Amount(), ioId, inAmount);

     -- ��������� ����� � <��. ����>
     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_Juridical(), ioId, inJuridicalId);
     -- ��������� ����� � <������� ��. ����>
     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_MainJuridical(), ioId, inMainJuridicalId);

     -- ��������� ����� � <������>
     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_Business(), ioId, inBusinessId);
     -- ��������� ����� � <���� ���� ������ >
     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_PaidKind(), ioId, inPaidKindId);

     -- ��������� ����� � <������ ����������>
     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_InfoMoney(), ioId, inInfoMoneyId);
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
 11.08.13         *

*/

-- ����
-- SELECT * FROM gpInsertUpdate_Movement_Service (ioId:= 0, inInvNumber:= '-1', inOperDate:= '01.01.2013', inAmount:= 20, inJuridicalId:= 1, inMainJuridicalId:= 1, inBusinessId:= 2, inPaidKindId:= 1,  inInfoMoneyId:= 0, inUnitId:= 0, inSession:= '2')