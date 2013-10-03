-- Function: gpInsertUpdate_MovementItem_PersonalSendCash()

DROP FUNCTION IF EXISTS gpInsertUpdate_MovementItem_PersonalSendCash(Integer, Integer, TFloat, TFloat, Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_MovementItem_PersonalSendCash(
 INOUT inPersonalId          Integer   , -- ���������
    IN inMovementId          Integer   , -- ���� ���������
    IN inAmount_20401        TFloat    , -- ����� - ������ ���������� ���
    IN inAmount_21201        TFloat    , -- ����� - ������ ���������� ����������������
    IN inRouteId             Integer   , -- �������
    IN inCarId               Integer   , -- ����������
    IN inSession             TVarChar    -- ������ ������������
)                              
RETURNS Integer AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbId_20401 Integer;
   DECLARE vbId_21201 Integer;
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_MovementItem_PersonalSendCash());
     vbUserId := inSession;

     -- ����� �������� ������ ���������� ���
     vbId_20401 := (SELECT MovementItem.Id
                    FROM MovementItem
                         JOIN MovementItemLinkObject AS MILinkObject_InfoMoney
                                                     ON MILinkObject_InfoMoney.MovementItemId = MovementItem.Id
                                                    AND MILinkObject_InfoMoney.DescId = zc_MILinkObject_InfoMoney()
                                                    AND MILinkObject_InfoMoney.ObjectId = zc_Enum_InfoMoney_20401()
                    WHERE MovementItem.MovementId = inMovementId
                      AND MovementItem.ObjectId = inPersonalId
                      AND MovementItem.DescId =  zc_MI_Master()
                   );
     -- ����� �������� ������ ���������� ����������������
     vbId_21201 := (SELECT MovementItem.Id
                    FROM MovementItem
                         JOIN MovementItemLinkObject AS MILinkObject_InfoMoney
                                                     ON MILinkObject_InfoMoney.MovementItemId = MovementItem.Id
                                                    AND MILinkObject_InfoMoney.DescId = zc_MILinkObject_InfoMoney()
                                                    AND MILinkObject_InfoMoney.ObjectId = zc_Enum_InfoMoney_21201()
                    WHERE MovementItem.MovementId = inMovementId
                      AND MovementItem.ObjectId = inPersonalId
                      AND MovementItem.DescId =  zc_MI_Master()
                   );

     -- ��������� ������� ��� ������ ���������� ���
     vbId_20401 := lpInsertUpdate_MovementItem_PersonalSendCash (ioId          := vbId_20401
                                                               , inMovementId  := inMovementId
                                                               , inPersonalId  := inPersonalId
                                                               , inAmount      := inAmount_20401
                                                               , inRouteId     := inRouteId
                                                               , inCarId       := inCarId
                                                               , inInfoMoneyId := zc_Enum_InfoMoney_20401()
                                                                );
   
     -- ��������� ������� ��� ������ ���������� ����������������
     vbId_21201 := lpInsertUpdate_MovementItem_PersonalSendCash (ioId          := vbId_21201
                                                               , inMovementId  := inMovementId
                                                               , inPersonalId  := inPersonalId
                                                               , inAmount      := inAmount_21201
                                                               , inRouteId     := inRouteId
                                                               , inCarId       := inCarId
                                                               , inInfoMoneyId := zc_Enum_InfoMoney_21201()
                                                                );
     -- ����������� �������� ����� �� ���������
     PERFORM lpInsertUpdate_MovementFloat_TotalSumm (inMovementId);


     -- ��������� ��������
     -- PERFORM lpInsert_MovementItemProtocol (ioId, vbUserId);

END;
$BODY$
LANGUAGE PLPGSQL VOLATILE;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 03.10.13                                        * err
 30.09.13                                        * 
*/

-- ����
-- SELECT * FROM gpInsertUpdate_MovementItem_PersonalSendCash (ioPersonalId:= 0, inMovementId:= 10, inGoodsId:= 1, inAmount:= 0, inAmountPartner:= 0, inPrice:= 1, inCountForPrice:= 1, inLiveWeight:= 0, inHeadCount:= 0, inPartionGoods:= '', inGoodsKindId:= 0, inSession:= '2')
