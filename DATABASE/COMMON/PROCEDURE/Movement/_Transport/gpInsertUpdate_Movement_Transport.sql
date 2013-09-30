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
   OUT outHoursWork          TFloat    , -- ���-�� ������� �����

    IN inComment             TVarChar  , -- ����������
    
    IN inCarId                Integer   , -- ����������
    IN inCarTrailerId         Integer   , -- ���������� (������)
    IN inPersonalDriverId     Integer   , -- ��������� (��������)
    IN inPersonalDriverMoreId Integer   , -- ��������� (��������, ��������������)
    IN inUnitForwardingId     Integer   , -- ������������� (����� ��������)

    IN inSession              TVarChar    -- ������ ������������
)                              
RETURNS record AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN


     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_Movement_Transport());
     vbUserId := inSession;

     -- ��������� <��������>
     ioId := lpInsertUpdate_Movement (ioId, zc_Movement_Transport(), inInvNumber, inOperDate, NULL);

     -- ��������� ����� � <����/����� ������ ����>
     PERFORM lpInsertUpdate_MovementDate (zc_MovementDate_StartRunPlan(), ioId, inStartRunPlan);
     -- ��������� ����� � <����/����� ����������� ����>
     PERFORM lpInsertUpdate_MovementDate (zc_MovementDate_EndRunPlan(), ioId, inEndRunPlan);
     -- ��������� ����� � <����/����� ������ ����>
     PERFORM lpInsertUpdate_MovementDate (zc_MovementDate_StartRun(), ioId, inStartRun);
     -- ��������� ����� � <����/����� ����������� ����>
     PERFORM lpInsertUpdate_MovementDate (zc_MovementDate_EndRun(), ioId, inEndRun);

     -- ��������� �������� <���-�� ������� �����>
     outHoursWork := extract(day from (inEndRun - inStartRun)) * 24 + extract(hour from (inEndRun - inStartRun));
     -- ��������� �������� <���-�� ������� �����>
     PERFORM lpInsertUpdate_MovementFloat (zc_MovementFloat_HoursWork(), ioId, outHoursWork);

     -- ��������� �������� <���-�� ����������� ������� �����>
     PERFORM lpInsertUpdate_MovementFloat (zc_MovementFloat_HoursAdd(), ioId, inHoursAdd);

     -- ��������� �������� <����������>
     PERFORM lpInsertUpdate_MovementString (zc_MovementString_Comment(), ioId, inComment);

     -- ��������� ����� � <����������>
     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_Car(), ioId, inCarId);
     -- ��������� ����� � <���������� (������)>
     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_CarTrailer(), ioId, inCarTrailerId);

     -- ��������� ����� � <��������� (��������)>
     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_PersonalDriver(), ioId, inPersonalDriverId);
     -- ��������� ����� � <��������� (��������, ��������������)>
     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_PersonalDriverMore(), ioId, inPersonalDriverMoreId);
     
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
 26.09.13                                        * changes in wiki                 
 25.09.13         * changes in wiki                 
 20.08.13         *
*/

-- ����
-- SELECT * FROM gpInsertUpdate_Movement_Transport (ioId:= 0, inInvNumber:= '-1', inOperDate:= '01.01.2013', inAmount:= 20, inFromId:= 1, inToId:= 1, inPaidKindId:= 1,  inInfoMoneyId:= 0, inUnitId:= 0, inServiceDate:= '01.01.2013', inSession:= '2')
