-- Function: gpInsertUpdate_MI_Transport_Child()

-- DROP FUNCTION gpInsertUpdate_MI_Transport_Child();

CREATE OR REPLACE FUNCTION gpInsertUpdate_MI_Transport_Child(
 INOUT ioId                  Integer   , -- ���� ������� <������� ���������>
    IN inMovementId          Integer   , -- ���� ������� <��������>
    IN inParentId            Integer   , -- ������� ������� ���������
    IN inFuelId              Integer   , -- ��� �������
    IN inCalculated          Boolean   , -- ���������� �� ����� �������������� �� ����� ��� ���������
    IN inAmount              TFloat    , -- ���������� �� �����
    IN inColdHour            TFloat    , -- �����, ���-�� ���� ����� 
    IN inColdDistance        TFloat    , -- �����, ���-�� ���� �� 
    IN inAmountColdHour      TFloat    , -- �����, ���-�� ����� � ���  
    IN inAmountColdDistance  TFloat    , -- �����, ���-�� ����� �� 100 �� 
    IN inAmountFuel          TFloat    , -- ���-�� ����� �� 100 �� 
    IN inRateFuelKindId      Integer   , -- ���� ���� ��� �������          
    IN inSession             TVarChar    -- ������ ������������
)                              
RETURNS Integer AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN

   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_MI_Transport());
   vbUserId := inSession;

   PERFORM lpInsertUpdate_MI_Transport_Child (ioId                 = ioId
                                            , inMovementId         = inMovementId
                                            , inParentId           = inParentId
                                            , inFuelId             = inFuelId
                                            , inCalculated         = inCalculated
                                            , inAmount             = inAmount
                                            , inColdHour           = inColdHour
                                            , inColdDistance       = inColdDistance
                                            , inAmountColdHour     = inAmountColdHour
                                            , inAmountColdDistance = inAmountColdDistance
                                            , inAmountFuel         = inAmountFuel
                                            , inRateFuelKindId     = inRateFuelKindId
                                             );

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 29.07.13                                        *
*/

-- ����
-- SELECT * FROM gpInsertUpdate_MI_Transport_Child (ioId:= 0, inMovementId:= 10, inGoodsId:= 1, inAmount:= 0, inParentId:= NULL, inAmountReceipt:= 1, inComment:= '', inSession:= '2')
