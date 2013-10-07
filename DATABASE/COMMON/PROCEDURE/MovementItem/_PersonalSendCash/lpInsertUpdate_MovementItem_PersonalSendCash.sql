-- Function: lpInsertUpdate_MovementItem_PersonalSendCash ()

-- DROP FUNCTION lpInsertUpdate_MovementItem_PersonalSendCash ();

CREATE OR REPLACE FUNCTION lpInsertUpdate_MovementItem_PersonalSendCash(
 INOUT ioId                  Integer   , -- ���� ������� <������� ���������>
    IN inMovementId          Integer   , -- ���� ���������
    IN inPersonalId          Integer   , -- ���������
    IN inAmount              TFloat    , -- �����
    IN inRouteId             Integer   , -- �������
    IN inCarId               Integer   , -- ����������
    IN inInfoMoneyId         Integer   , -- ������ ����������
    IN inUserId              Integer     -- ������������
)                              
RETURNS Integer AS
$BODY$
BEGIN

     -- ��������
     IF COALESCE (inPersonalId, 0) = 0
     THEN
         RAISE EXCEPTION '������.�� ���������� <���������>.';
     END IF;
     -- ��������
     IF COALESCE (ioId, 0) = 0 AND EXISTS (SELECT MovementItem.ObjectId
                                           FROM MovementItem 
                                                JOIN MovementItemLinkObject AS MILinkObject_InfoMoney
                                                                            ON MILinkObject_InfoMoney.MovementItemId = MovementItem.Id
                                                                           AND MILinkObject_InfoMoney.DescId = zc_MILinkObject_InfoMoney()
                                                                           AND MILinkObject_InfoMoney.ObjectId = inInfoMoneyId
                                           WHERE MovementItem.MovementId = inMovementId
                                             AND MovementItem.ObjectId = inPersonalId
                                             AND MovementItem.DescId = zc_MI_Master())
     THEN
         RAISE EXCEPTION '������ ��� ����������.��������� <%> ��� ���� � ���������.', (SELECT ValueData FROM Object WHERE Id = inPersonalId);
     END IF;


     -- ��������� <������� ���������>
     ioId := lpInsertUpdate_MovementItem (ioId, zc_MI_Master(), inPersonalId, inMovementId, inAmount, NULL);

     -- ��������� ����� � <�������>
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_Route(), ioId, inRouteId);

     -- ��������� ����� � <����������>
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_Car(), ioId, inCarId);

     -- ��������� ����� � <������ ����������>
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_InfoMoney(), ioId, inInfoMoneyId);

     -- ��������� ��������
     -- PERFORM lpInsert_MovementItemProtocol (ioId, inUserId);

END;
$BODY$
LANGUAGE PLPGSQL VOLATILE;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 06.10.13                                        * add check
 30.09.13                                        * 
*/

-- ����
-- SELECT * FROM lpInsertUpdate_MovementItem_PersonalSendCash (ioId:= 0, inMovementId:= 10, inGoodsId:= 1, inAmount:= 0, inAmountPartner:= 0, inPrice:= 1, inCountForPrice:= 1, inLiveWeight:= 0, inHeadCount:= 0, inPartionGoods:= '', inGoodsKindId:= 0, inSession:= '2')
