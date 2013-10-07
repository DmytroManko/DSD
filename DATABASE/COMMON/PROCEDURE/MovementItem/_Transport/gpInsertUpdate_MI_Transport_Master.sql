-- Function: gpInsertUpdate_MI_Transport_Master()

-- DROP FUNCTION gpInsertUpdate_MI_Transport_Master();

CREATE OR REPLACE FUNCTION gpInsertUpdate_MI_Transport_Master(
 INOUT ioId                  Integer   , -- ���� ������� <������� ���������>
    IN inMovementId          Integer   , -- ���� ������� <��������>
    IN inRouteId             Integer   , -- �������
    IN inAmount	             TFloat    , -- ������, �� (�������� ��� �������)
    IN inDistanceFuelChild   TFloat    , -- ������, �� (�������������� ��� �������)
    IN inWeight	             TFloat    , -- ��� �����
    IN inStartOdometre       TFloat    , -- ��������� ��������� ���������, ��
    IN inEndOdometre         TFloat    , -- ��������� �������� ���������, ��
    IN inFreightId           Integer   , -- �������� �����
    IN inRouteKindId         Integer   , -- ���� ���������
    IN inSession             TVarChar    -- ������ ������������
)                              
RETURNS Integer
AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN

   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_MI_Transport());
   vbUserId := inSession;

   IF COALESCE (inStartOdometre, 0) <> 0 OR COALESCE (inEndOdometre, 0) <> 0
   THEN
       -- ��� ������������ ��������, ����������� inAmount - ������, ��
       inAmount := ABS (COALESCE (inEndOdometre, 0) - COALESCE (inStartOdometre, 0));
       -- ��������� inAmount �� ������, �� (�������������� ��� �������)
       inAmount := inAmount - COALESCE (inDistanceFuelChild, 0);
   ELSE
       -- ����� ��������� ��������� ��������
       inAmount := ABS (inAmount);
   END IF;

   -- �������� 
   IF inAmount < 0
   THEN 
       RAISE EXCEPTION '������.�������� �������� <������, �� (�������� ��� �������)>.';
   END IF;

   -- ��������
   IF inDistanceFuelChild < 0
   THEN 
       RAISE EXCEPTION '������.�������� �������� <������, �� (�������������� ��� �������)>.';
   END IF;


   -- ��������� <������� ���������>
   ioId := lpInsertUpdate_MovementItem (ioId, zc_MI_Master(), inRouteId, inMovementId, inAmount, NULL);
  
   -- ��������� ����� � <�������� �����>
   PERFORM lpInsertUpdate_MovementItemLinkObject(zc_MILinkObject_Freight(), ioId, inFreightId);
   
   -- ��������� ����� � <���� ���������>
   PERFORM lpInsertUpdate_MovementItemLinkObject(zc_MILinkObject_RouteKind(), ioId, inRouteKindId);

   -- ��������� �������� <������, �� (�������������� ��� �������)>
   PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_DistanceFuelChild(), ioId, inDistanceFuelChild);

   -- ��������� �������� <��� �����>
   PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_Weight(), ioId, inWeight);

   -- ��������� �������� <��������� ��������� ���������, ��>
   PERFORM lpInsertUpdate_MovementItemFloat(zc_MIFloat_StartOdometre(), ioId, inStartOdometre);

   -- ��������� �������� <��������� �������� ���������, ��>
   PERFORM lpInsertUpdate_MovementItemFloat(zc_MIFloat_EndOdometre(), ioId, inEndOdometre);

   -- ����������� Child ��� ��� ���� ���� (MIBoolean_Calculated.ValueData = TRUE)
   PERFORM lpInsertUpdate_MI_Transport_Child (ioId                 := MovementItem.Id
                                            , inMovementId         := inMovementId
                                            , inParentId           := ioId
                                            , inFuelId             := MovementItem.ObjectId
                                            , inIsCalculated       := MIBoolean_Calculated.ValueData
                                            , inIsMasterFuel       := MIBoolean_MasterFuel.ValueData
                                            , ioAmount             := MovementItem.Amount
                                            , inColdHour           := MIFloat_ColdHour.ValueData
                                            , inColdDistance       := MIFloat_ColdDistance.ValueData
                                            , inAmountColdHour     := MIFloat_AmountColdHour.ValueData
                                            , inAmountColdDistance := MIFloat_AmountColdDistance.ValueData
                                            , inAmountFuel         := MIFloat_AmountFuel.ValueData
                                            , inNumber             := MIFloat_Number.ValueData
                                            , inRateFuelKindTax    := MIFloat_RateFuelKindTax.ValueData
                                            , inRateFuelKindId     := MILinkObject_RateFuelKind.ObjectId
                                            , inUserId             := vbUserId
                                             )
   FROM MovementItem
        JOIN MovementItemBoolean AS MIBoolean_Calculated
                                 ON MIBoolean_Calculated.MovementItemId = MovementItem.Id
                                AND MIBoolean_Calculated.DescId = zc_MIBoolean_Calculated()
                                AND MIBoolean_Calculated.ValueData = TRUE
             LEFT JOIN MovementItemBoolean AS MIBoolean_MasterFuel
                                           ON MIBoolean_MasterFuel.MovementItemId = MovementItem.Id
                                          AND MIBoolean_MasterFuel.DescId = zc_MIBoolean_MasterFuel()

             LEFT JOIN MovementItemFloat AS MIFloat_ColdHour
                                         ON MIFloat_ColdHour.MovementItemId = MovementItem.Id
                                        AND MIFloat_ColdHour.DescId = zc_MIFloat_ColdHour()
             LEFT JOIN MovementItemFloat AS MIFloat_ColdDistance
                                         ON MIFloat_ColdDistance.MovementItemId = MovementItem.Id
                                        AND MIFloat_ColdDistance.DescId = zc_MIFloat_ColdDistance()

             LEFT JOIN MovementItemFloat AS MIFloat_AmountColdHour
                                        ON MIFloat_AmountColdHour.MovementItemId = MovementItem.Id
                                        AND MIFloat_AmountColdHour.DescId = zc_MIFloat_AmountColdHour()
             LEFT JOIN MovementItemFloat AS MIFloat_AmountColdDistance
                                         ON MIFloat_AmountColdDistance.MovementItemId = MovementItem.Id
                                        AND MIFloat_AmountColdDistance.DescId = zc_MIFloat_AmountColdDistance()
             LEFT JOIN MovementItemFloat AS MIFloat_AmountFuel
                                         ON MIFloat_AmountFuel.MovementItemId = MovementItem.Id
                                        AND MIFloat_AmountFuel.DescId = zc_MIFloat_AmountFuel()
             LEFT JOIN MovementItemFloat AS MIFloat_RateFuelKindTax
                                         ON MIFloat_RateFuelKindTax.MovementItemId = MovementItem.Id
                                        AND MIFloat_RateFuelKindTax.DescId = zc_MIFloat_RateFuelKindTax()

             LEFT JOIN MovementItemFloat AS MIFloat_Number
                                         ON MIFloat_Number.MovementItemId = MovementItem.Id
                                        AND MIFloat_Number.DescId = zc_MIFloat_Number()

             LEFT JOIN MovementItemLinkObject AS MILinkObject_RateFuelKind
                                              ON MILinkObject_RateFuelKind.MovementItemId = MovementItem.Id
                                             AND MILinkObject_RateFuelKind.DescId = zc_MILinkObject_RateFuelKind()

   WHERE MovementItem.MovementId = inMovementId
     AND MovementItem.DescId = zc_MI_Child()
     AND MovementItem.ParentId = ioId;

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 07.10.13                                        * add inDistanceFuelChild and inIsMasterFuel
 29.09.13                                        * 
 25.09.13         * 
*/

-- ����
-- SELECT * FROM gpInsertUpdate_MI_Transport_Master (ioId:= 0, inMovementId:= 10, inGoodsId:= 1, inAmount:= 0, inPartionClose:= FALSE, inComment:= '', inCount:= 1, inRealWeight:= 1, inCuterCount:= 0, inReceiptId:= 0, inSession:= '2')
