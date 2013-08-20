-- Function: gpInsertUpdate_Movement_Transport()

-- DROP FUNCTION gpInsertUpdate_Movement_Transport();

CREATE OR REPLACE FUNCTION gpInsertUpdate_Movement_Transport(
 INOUT ioId                  Integer   , -- ���� ������� <��������>
    IN inInvNumber           TVarChar  , -- ����� ���������
    IN inOperDate            TDateTime , -- ���� ���������
    
    IN inWorkTime            TDateTime , -- ���� ����������

    IN inMorningOdometre     TFloat    , -- ������� ���� 
    IN inEveningOdometre     TFloat    , -- ������� �����
    IN inDistance            TFloat    , -- ������
    IN inCold                TFloat    , -- ������� ������� �� ����������
    IN inNorm                TFloat    , -- ����� ������� �������
    
    IN inCarId               Integer   , -- ���������� 	
    IN inMemberId            Integer   , -- ����������
    IN inRouteId             Integer   , -- ��������

    IN inSession             TVarChar    -- ������ ������������
)                              
RETURNS Integer AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_Movement_Transport());
     vbUserId := inSession;

     -- ��������� <��������>
     ioId := lpInsertUpdate_Movement (ioId, zc_Movement_Transport(), inInvNumber, inOperDate, NULL);

     -- ��������� ����� � <���� ����������>
     PERFORM lpInsertUpdate_MovementDate (zc_MovementDate_WorkTime(), ioId, inWorkTime);

     -- ��������� �������� <������� ����>
     PERFORM lpInsertUpdate_MovementFloat (zc_MovementFloat_MorningOdometre(), ioId, inMorningOdometre);

     -- ��������� �������� <������� �����>
     PERFORM lpInsertUpdate_MovementFloat (zc_MovementFloat_EveningOdometre(), ioId, inEveningOdometre);

     -- ��������� �������� <������>
     PERFORM lpInsertUpdate_MovementFloat (zc_MovementFloat_Distance(), ioId, inDistance);

     -- ��������� �������� <������� ������� �� ����������>
     PERFORM lpInsertUpdate_MovementFloat (zc_MovementFloat_Cold(), ioId, inCold);

     -- ��������� �������� <����� ������� �������>
     PERFORM lpInsertUpdate_MovementFloat (zc_MovementFloat_Norm(), ioId, inNorm);

     -- ��������� ����� � <����������>
     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_Car(), ioId, inCarId);
     -- ��������� ����� � <����������>
     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_Member(), ioId, inMemberId);
     
     -- ��������� ����� � <��������>
     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_Route(), ioId, inRouteId);
    
     -- ��������� ��������
     -- PERFORM lpInsert_MovementProtocol (ioId, vbUserId);

END;
$BODY$
LANGUAGE PLPGSQL VOLATILE;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 20.08.13         *

*/

-- ����
-- SELECT * FROM gpInsertUpdate_Movement_Transport (ioId:= 0, inInvNumber:= '-1', inOperDate:= '01.01.2013', inAmount:= 20, inFromId:= 1, inToId:= 1, inPaidKindId:= 1,  inInfoMoneyId:= 0, inUnitId:= 0, inServiceDate:= '01.01.2013', inSession:= '2')
