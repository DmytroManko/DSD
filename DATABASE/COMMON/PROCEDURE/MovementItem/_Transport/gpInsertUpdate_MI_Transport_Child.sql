-- Function: gpInsertUpdate_MI_Transport_Child()

-- DROP FUNCTION gpInsertUpdate_MI_Transport_Child (Integer, Integer, Integer, Integer, Boolean, TFloat, TFloat, TFloat, TFloat, TFloat, TFloat, TFloat, TFloat, TFloat, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_MI_Transport_Child(
 INOUT ioId                  Integer   , -- ���� ������� <������� ���������>
    IN inMovementId          Integer   , -- ���� ������� <��������>
    IN inParentId            Integer   , -- ������� ������� ���������
    IN inFuelId              Integer   , -- ��� �������
    IN inCalculated          Boolean   , -- ���������� �� ����� �������������� �� ����� ��� ���������
 INOUT ioAmount              TFloat    , -- ���������� �� �����
   OUT outAmount_calc        TFloat    , -- ���������� ��������� �� �����
    IN inColdHour            TFloat    , -- �����, ���-�� ���� ����� 
    IN inColdDistance        TFloat    , -- �����, ���-�� ���� �� 
    IN inAmountColdHour      TFloat    , -- �����, ���-�� ����� � ���  
    IN inAmountColdDistance  TFloat    , -- �����, ���-�� ����� �� 100 �� 
    IN inAmountFuel          TFloat    , -- ���-�� ����� �� 100 �� 
    IN inNumber              TFloat    , -- � �� �������
    IN inRateFuelKindTax     TFloat    , -- % ��������������� ������� � ����� � �������/������������
    IN inRateFuelKindId      Integer   , -- ���� ���� ��� �������          
    IN inSession             TVarChar    -- ������ ������������
)                              
RETURNS RECORD AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN

   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_MI_Transport());
   vbUserId := inSession;

   SELECT f.ioId, f.ioAmount, f.outAmount_calc into ioId, ioAmount, outAmount_calc
          FROM lpInsertUpdate_MI_Transport_Child (ioId                 := ioId
                                            , inMovementId         := inMovementId
                                            , inParentId           := inParentId
                                            , inFuelId             := inFuelId
                                            , inCalculated         := inCalculated
                                            , ioAmount             := ioAmount
                                            , inColdHour           := inColdHour
                                            , inColdDistance       := inColdDistance
                                            , inAmountColdHour     := inAmountColdHour
                                            , inAmountColdDistance := inAmountColdDistance
                                            , inAmountFuel         := inAmountFuel
                                            , inNumber             := inNumber
                                            , inRateFuelKindTax    := inRateFuelKindTax
                                            , inRateFuelKindId     := inRateFuelKindId
                                             ) as f;

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 01.10.13                                        * add inRateFuelKindTax
 29.09.13                                        *
*/

-- ����
-- SELECT * FROM gpInsertUpdate_MI_Transport_Child (ioId:= 0, inMovementId:= 10, inGoodsId:= 1, inAmount:= 0, inParentId:= NULL, inAmountReceipt:= 1, inComment:= '', inSession:= '2')
