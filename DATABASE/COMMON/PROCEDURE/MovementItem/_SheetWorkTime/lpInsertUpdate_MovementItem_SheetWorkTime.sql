-- Function: lpInsertUpdate_MovementItem_SheetWorkTime ()

DROP FUNCTION IF EXISTS lpInsertUpdate_MovementItem_SheetWorkTime (Integer, Integer, Integer, TFloat,Integer);

CREATE OR REPLACE FUNCTION lpInsertUpdate_MovementItem_SheetWorkTime(
 INOUT InMovementItemId      Integer   , -- ���� ������� <������� ���������>
    IN inMovementId          Integer   , -- ���� ���������
    IN inPersonalId          Integer   , -- ���������
    IN inPositionId          Integer   , -- ���������
    IN inPersonalGroupId     Integer   , -- ����������� ����������
    IN inAmount              TFloat    , -- ���������� ����� ����
    IN inWorkTimeKindId      Integer     -- ���� �������� �������
)                              
RETURNS Integer AS
$BODY$
BEGIN
     
     -- ��������� <������� ���������>
     PERFORM lpInsertUpdate_MovementItem (InMovementItemId, zc_MI_Master(), inPersonalId, inMovementId, inAmount, NULL);
     
     -- ��������� ����� � <����������� �����������>
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_PersonalGroup(), InMovementItemId, inPersonalGroupId);
     -- ��������� ����� � <����������>
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_Position(), InMovementItemId, inPositionId);
     -- ��������� ����� � <���� �������� �������>
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_WorkTimeKind(), InMovementItemId, inWorkTimeKindId);

 END;
$BODY$
LANGUAGE PLPGSQL VOLATILE;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 03.10.13         * 

*/

-- ����
-- SELECT * FROM lpInsertUpdate_MovementItem_SheetWorkTime (InMovementItemId:= 0, inMovementId:= 10, inPersonalId:= 1, inAmount:= 0, inSession:= '2')
