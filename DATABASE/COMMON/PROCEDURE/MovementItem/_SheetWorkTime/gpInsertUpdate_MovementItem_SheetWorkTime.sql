-- Function: gpInsertUpdate_MovementItem_SheetWorkTime()

DROP FUNCTION IF EXISTS gpInsertUpdate_MovementItem_SheetWorkTime(INTEGER, INTEGER, INTEGER, INTEGER, TDateTime, TVarChar, INTEGER, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_MovementItem_SheetWorkTime(
 INOUT ioPersonalId          Integer   , -- ���� ���������
    IN inPositionId          Integer   , -- ���������
    IN inUnitId              Integer   , -- �������������
    IN inPersonalGroupId     Integer   , -- ����������� ����������
    IN inOperDate            TDateTime , -- ���� ��������� �����
 INOUT ioValue               TVarChar  , -- ����
    IN inTypeId              Integer   , 
    IN inSession             TVarChar    -- ������ ������������
)                              
RETURNS RECORD
AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbMovementId Integer;
   DECLARE vbMovementItemId_1 Integer;

BEGIN
	-- �������� ���� ������������ �� ����� ���������
    -- PERFORM lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_MovementItem_SheetWorkTime());
    vbUserId := inSession;

    ioValue := '8/����������'::TVarChar;

    -- ��� ������ ��������� ID Movement, ���� ������� �������. ������ ����� OperDate � UnitId
    vbMovementId := (SELECT Movement_SheetWorkTime.Id FROM Movement AS Movement_SheetWorkTime
                               JOIN MovementLinkObject AS MovementLinkObject_Unit 
                                 ON MovementLinkObject_Unit.DescId = zc_MovementLinkObject_Unit()
                                AND MovementLinkObject_Unit.MovementId = Movement_SheetWorkTime.Id  
                           WHERE Movement_SheetWorkTime.DescId = zc_Movement_SheetWorkTime() AND Movement_SheetWorkTime.OperDate::Date = inOperDate::Date);
 
     -- ��������� <��������>
     vbMovementId := lpInsertUpdate_Movement_SheetWorkTime(vbMovementId, '', inOperDate::DATE, inUnitId);

    -- 

     -- ��������� <������� ���������>
     --ioId := lpInsertUpdate_MovementItem (vbMovementItemId_1, zc_MI_Master(), ioPersonalId, vbMovementId_1, inAmount_1, NULL);
     -- ��������� ����� � <���� �������� �������>
     --PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_WorkTimeKind(), vbMovementItemId_1, inWorkTimeKindId_1);

--     PERFORM lpInsertUpdate_MovementItem_SheetWorkTime (InMovementItemId:= vbMovementItemId_1, inOperDate = inStartDate, inMovementId:= vbMovementId_1
  --                                                    , inPersonalId:= ioPersonalId, inPositionId:= inPositionId, inPersonalGroupId=inPersonalGroupId, inUnitId=inUnitId
    --                                                  , inAmount:= inAmount_1, inWorkTimeKindId:= inWorkTimeKindId_1);

     -- ��������� ��������
     -- PERFORM lpInsert_MovementItemProtocol (ioId, vbUserId);

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 17.10.13                         *
 03.10.13         *

*/

-- ����
-- SELECT * FROM gpInsertUpdate_MovementItem_SheetWorkTime (, inSession:= '2')
