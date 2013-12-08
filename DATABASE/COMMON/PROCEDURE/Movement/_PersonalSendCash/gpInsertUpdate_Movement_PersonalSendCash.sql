-- Function: gpInsertUpdate_Movement_PersonalSendCash()

-- DROP FUNCTION gpInsertUpdate_Movement_PersonalSendCash();

CREATE OR REPLACE FUNCTION gpInsertUpdate_Movement_PersonalSendCash(
 INOUT ioId                  Integer   , -- ���� ������� <��������>
    IN inInvNumber           TVarChar  , -- ����� ���������
    IN inOperDate            TDateTime , -- ���� ���������
    IN inPersonalId          Integer   , -- ���������
    IN inSession             TVarChar    -- ������ ������������
)                              
RETURNS Integer AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbAccessKeyId Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     vbUserId:= lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_Movement_PersonalSendCash());
     -- ���������� ���� �������
     vbAccessKeyId:= lpGetAccessKey (vbUserId, zc_Enum_Process_InsertUpdate_Movement_PersonalSendCash());

     -- ��������� <��������>
     ioId := lpInsertUpdate_Movement (ioId, zc_Movement_PersonalSendCash(), inInvNumber, inOperDate, NULL, vbAccessKeyId);

     -- ��������� ����� � <���������>
     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_Personal(), ioId, inPersonalId);
     
     -- ����������� �������� ����� �� ���������
     PERFORM lpInsertUpdate_MovementFloat_TotalSumm (ioId);

     -- ��������� ��������
     -- PERFORM lpInsert_MovementProtocol (ioId, vbUserId);

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 07.12.13                                        * add lpGetAccessKey
 30.09.13                                        *
*/

-- ����
-- SELECT * FROM gpInsertUpdate_Movement_PersonalSendCash (ioId:= 0, inInvNumber:= '-1', inOperDate:= '01.01.2013', inAmount:= 20, inFromId:= 1, inToId:= 1, inPaidKindId:= 1,  inInfoMoneyId:= 0, inUnitId:= 0, inServiceDate:= '01.01.2013', inSession:= '2')
