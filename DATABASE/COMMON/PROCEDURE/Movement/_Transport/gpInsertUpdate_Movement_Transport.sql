-- Function: gpInsertUpdate_Movement_Transport (Integer, TVarChar, TDateTime, TDateTime, TDateTime, TDateTime, TDateTime, TFloat, TFloat, TVarChar, Integer, Integer, Integer, Integer, Integer, TVarChar)

-- DROP FUNCTION gpInsertUpdate_Movement_Transport (Integer, TVarChar, TDateTime, TDateTime, TDateTime, TDateTime, TDateTime, TFloat, TFloat, TVarChar, Integer, Integer, Integer, Integer, Integer, TVarChar);

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
RETURNS RECORD AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN


     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_Movement_Transport());
     vbUserId := inSession;

     -- ��������
     IF inHoursAdd > 0
     THEN
         RAISE EXCEPTION '������.��������� ���� ��� <���-�� ����������� ������� �����>.';
     END IF;


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
     outHoursWork := EXTRACT (DAY FROM (inEndRun - inStartRun)) * 24 + EXTRACT (HOUR FROM (inEndRun - inStartRun));
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


     -- �������� �������� � ����������� ����������
     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_To(), Movement.Id, inCarId)
           , lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_PersonalDriver(), Movement.Id, inPersonalDriverId)
     FROM Movement
     WHERE Movement.ParentId = ioId
       AND Movement.DescId   = zc_Movement_Income();



     -- ��������� ��������
     -- PERFORM lpInsert_MovementProtocol (ioId, vbUserId);

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 12.10.13                                        * add IF inHoursAdd > 0
 06.10.13                                        * add zc_Movement_Income
 26.09.13                                        * changes in wiki                 
 25.09.13         * changes in wiki                 
 20.08.13         *
*/

-- ����
-- SELECT * FROM gpInsertUpdate_Movement_Transport (ioId:= 149691, inInvNumber:= '1', inOperDate:= '01.10.2013 3:00:00', inStartRunPlan:= '30.09.2013 3:00:00', inEndRunPlan:= '30.09.2013 3:00:00', inStartRun:= '30.09.2013 3:00:00', inEndRun:= '30.09.2013 3:00:00', inHoursAdd:= 0, inComment:= ''    , inCarId:= 67657, inCarTrailerId:= 0, inPersonalDriverId:= 19476, inPersonalDriverMoreId:= 19476, inUnitForwardingId:= 1000, inSession:= '2')
