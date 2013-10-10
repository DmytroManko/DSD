-- Function: gpInsertUpdate_MovementItem_SheetWorkTime()

DROP FUNCTION IF EXISTS gpInsertUpdate_MovementItem_SheetWorkTime();

CREATE OR REPLACE FUNCTION gpInsertUpdate_MovementItem_SheetWorkTime(
 INOUT ioPersonalId          Integer   , -- ���� ���������
    IN inPositionId          Integer   , -- ���������
    IN inUnitId              Integer   , -- �������������
    IN inPersonalGroupId     Integer   , -- ����������� ����������
    IN inStartDate           TDateTime , -- ��������� ����

    IN inSession             TVarChar    -- ������ ������������
)                              
RETURNS Integer
AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbMovementId_1 Integer;
   DECLARE vbMovementItemId_1 Integer;

BEGIN
	-- �������� ���� ������������ �� ����� ���������
    -- PERFORM lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_MovementItem_SheetWorkTime());
    vbUserId := inSession;
     
     -- ��������� <������� ���������>
     --ioId := lpInsertUpdate_MovementItem (vbMovementItemId_1, zc_MI_Master(), ioPersonalId, vbMovementId_1, inAmount_1, NULL);
     -- ��������� ����� � <���� �������� �������>
     --PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_WorkTimeKind(), vbMovementItemId_1, inWorkTimeKindId_1);

     PERFORM lpInsertUpdate_MovementItem_SheetWorkTime (InMovementItemId:= vbMovementItemId_1, inOperDate = inStartDate, inMovementId:= vbMovementId_1
                                                      , inPersonalId:= ioPersonalId, inPositionId:= inPositionId, inPersonalGroupId=inPersonalGroupId, inUnitId=inUnitId
                                                      , inAmount:= inAmount_1, inWorkTimeKindId:= inWorkTimeKindId_1);

     -- ��������� ��������
     -- PERFORM lpInsert_MovementItemProtocol (ioId, vbUserId);

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 03.10.13         *

*/

-- ����
-- SELECT * FROM gpInsertUpdate_MovementItem_SheetWorkTime (, inSession:= '2')
