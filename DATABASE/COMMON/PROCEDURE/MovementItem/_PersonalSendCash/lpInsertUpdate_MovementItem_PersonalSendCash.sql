-- Function: lpInsertUpdate_MovementItem_PersonalSendCash ()

-- DROP FUNCTION lpInsertUpdate_MovementItem_PersonalSendCash ();

CREATE OR REPLACE FUNCTION lpInsertUpdate_MovementItem_PersonalSendCash(
 INOUT ioId                  Integer   , -- ���� ������� <������� ���������>
    IN inMovementId          Integer   , -- ���� ���������
    IN inPersonalId          Integer   , -- ���������
    IN inAmount              TFloat    , -- �����
    IN inRouteId             Integer   , -- �������
    IN inCarId               Integer   , -- ����������
    IN inInfoMoneyId         Integer     -- ������ ����������
)                              
RETURNS Integer AS
$BODY$
BEGIN

     -- ��������� <������� ���������>
     ioId := lpInsertUpdate_MovementItem (ioId, zc_MI_Master(), inPersonalId, inMovementId, inAmount, NULL);

     -- ��������� ����� � <�������>
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_Route(), ioId, inRouteId);

     -- ��������� ����� � <����������>
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_Car(), ioId, inCarId);

     -- ��������� ����� � <������ ����������>
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_InfoMoney(), ioId, inInfoMoneyId);

END;
$BODY$
LANGUAGE PLPGSQL VOLATILE;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 30.09.13                                        * 
*/

-- ����
-- SELECT * FROM lpInsertUpdate_MovementItem_PersonalSendCash (ioId:= 0, inMovementId:= 10, inGoodsId:= 1, inAmount:= 0, inAmountPartner:= 0, inPrice:= 1, inCountForPrice:= 1, inLiveWeight:= 0, inHeadCount:= 0, inPartionGoods:= '', inGoodsKindId:= 0, inSession:= '2')
