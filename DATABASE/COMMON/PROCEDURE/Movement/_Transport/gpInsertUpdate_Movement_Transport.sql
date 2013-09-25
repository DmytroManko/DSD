-- Function: gpInsertUpdate_Movement_Transport()

-- DROP FUNCTION gpInsertUpdate_Movement_Transport();

CREATE OR REPLACE FUNCTION gpInsertUpdate_Movement_Transport(
 INOUT ioId                  Integer   , -- ���� ������� <��������>
    IN inInvNumber           TVarChar  , -- ����� ���������
    IN inOperDate            TDateTime , -- ���� ���������
    
    IN inStartRunPlan        TDateTime , -- ����/����� ������ ����
    IN inEndRunPlan          TDateTime , -- ����/����� ����������� ����
    IN inStartRun            TDateTime , -- ����/����� ������ ����
    IN inEndRun              TDateTime , -- ����/����� ����������� ����

    IN inHoursAdd            TFloat    , -- ���-�� ����������� ������� �����
    IN inStartOdometre       TFloat    , -- ��������� ��������� ���������, ��
    IN inEndOdometre         TFloat    , -- ��������� �������� ���������, ��
    
    IN inComment             TVarChar  , -- ������� ������� �� ����������
    
    IN inCarId               Integer   , -- ���������� 	
    IN inCarTrailerId        Integer   , -- ���������� (������)
    IN inPersonalDriverId    Integer   , -- ��������� (��������)
    IN inUnitForwardingId    Integer   , -- ������������� (����� ��������)

    IN inSession             TVarChar    -- ������ ������������
)                              
RETURNS Integer AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbHoursWork TFloat;
   DECLARE vbDistance TFloat;
BEGIN


     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_Movement_Transport());
     vbUserId := inSession;

     -- ��������� <��������>
     ioId := lpInsertUpdate_Movement (ioId, zc_Movement_Transport(), inInvNumber, inOperDate, NULL);

     -- ��������� ����� � <���� >
     PERFORM lpInsertUpdate_MovementDate (zc_MovementDate_StartRunPlan(), ioId, inStartRunPlan);
     -- ��������� ����� � <���� >
     PERFORM lpInsertUpdate_MovementDate (zc_MovementDate_EndRunPlan(), ioId, inEndRunPlan);
     -- ��������� ����� � <���� >
     PERFORM lpInsertUpdate_MovementDate (zc_MovementDate_StartRun(), ioId, inStartRun);
     -- ��������� ����� � <���� >
     PERFORM lpInsertUpdate_MovementDate (zc_MovementDate_EndRun(), ioId, inEndRun);

     -- ��������� �������� <���-�� ������� �����>
     vbHoursWork:= round((inEndRun - inStartRun)*24));
     PERFORM lpInsertUpdate_MovementFloat (zc_MovementFloat_HoursWork(), ioId, vbHoursWork);

     -- ��������� �������� <���-�� ����������� ������� �����>
     PERFORM lpInsertUpdate_MovementFloat (zc_MovementFloat_HoursAdd(), ioId, inHoursAdd);

     -- ��������� �������� <������� ���.���������>
     PERFORM lpInsertUpdate_MovementFloat (zc_MovementFloat_StartOdometre(), ioId, inStartOdometre);

     -- ��������� �������� <������� ���.���������>
     PERFORM lpInsertUpdate_MovementFloat (zc_MovementFloat_EndOdometre(), ioId, inEndOdometre);
     
     -- ��������� �������� <������>
     vbDistance:= inEndOdometre-inStartOdometre;
     PERFORM lpInsertUpdate_MovementFloat (zc_MovementFloat_Distance(), ioId, vbDistance);

     -- ��������� �������� <����������>
     PERFORM lpInsertUpdate_MovementString (zc_MovementString_Comment(), ioId, inComment);


     -- ��������� ����� � <����������>
     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_Car(), ioId, inCarId);
     -- ��������� ����� � <���������� (������)>
     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_CarTrailer(), ioId, inCarTrailerId);

     -- ��������� ����� � <����������>
     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_PersonalDriver(), ioId, inPersonalDriverId);
     
     -- ��������� ����� � <������������� (����� ��������)>
     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_UnitForwarding(), ioId, inUnitForwardingId);
    
     -- ��������� ��������
     -- PERFORM lpInsert_MovementProtocol (ioId, vbUserId);

END;
$BODY$
LANGUAGE PLPGSQL VOLATILE;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 25.09.13         * changes in wiki                 
 20.08.13         *

*/

-- ����
-- SELECT * FROM gpInsertUpdate_Movement_Transport (ioId:= 0, inInvNumber:= '-1', inOperDate:= '01.01.2013', inAmount:= 20, inFromId:= 1, inToId:= 1, inPaidKindId:= 1,  inInfoMoneyId:= 0, inUnitId:= 0, inServiceDate:= '01.01.2013', inSession:= '2')
