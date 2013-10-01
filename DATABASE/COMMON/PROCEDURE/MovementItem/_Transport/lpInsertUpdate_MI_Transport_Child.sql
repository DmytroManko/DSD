-- Function: lpInsertUpdate_MI_Transport_Child()

-- DROP FUNCTION lpInsertUpdate_MI_Transport_Child();

CREATE OR REPLACE FUNCTION lpInsertUpdate_MI_Transport_Child(
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
    IN inNumber              TFloat    , -- � �� �������
    IN inRateFuelKindTax     TFloat    , -- % ��������������� ������� � ����� � �������/������������
    IN inRateFuelKindId      Integer     -- ���� ���� ��� �������
)                              
RETURNS Integer AS
$BODY$
BEGIN

   -- ��������
   IF COALESCE (inParentId, 0) = 0
   THEN
       RAISE EXCEPTION '������.������� �� ����������.';
   END IF;


   IF inCalculated = TRUE
   THEN
       -- ��� ������������ ��������, ����������� inAmount - ���������� �� �����
       inAmount := (SELECT -- ��� "���������" ���� ������� ����������� �����
                           CASE WHEN inFuelId = ObjectLink_Car_FuelMaster.ChildObjectId
                                     THEN zfCalc_RateFuelValue (inDistance           := MovementItem_Master.Amount
                                                              , inAmountFuel         := inAmountFuel
                                                              , inColdHour           := inColdHour
                                                              , inAmountColdHour     := inAmountColdHour
                                                              , inColdDistance       := inColdDistance
                                                              , inAmountColdDistance := inAmountColdDistance
                                                              , inRateFuelKindTax    := ObjectFloat_RateFuelKind_Tax.ValueData
                                                               )
                                          -- !!!����������� �������� �����!!!
                                          -- * COALESCE (ObjectFloat_Ratio.ValueData, 0)
                                ELSE 0
                           END
                    FROM MovementItem AS MovementItem_Master
                         LEFT JOIN MovementLinkObject AS MovementLinkObject_Car
                                                      ON MovementLinkObject_Car.MovementId = inMovementId
                                                     AND MovementLinkObject_Car.DescId = zc_MovementLinkObject_Car()
                         LEFT JOIN ObjectLink AS ObjectLink_Car_FuelMaster ON ObjectLink_Car_FuelMaster.ObjectId = MovementLinkObject_Car.ObjectId
                                                                          AND ObjectLink_Car_FuelMaster.DescId = zc_ObjectLink_Car_FuelMaster()
                         LEFT JOIN ObjectFloat AS ObjectFloat_RateFuelKind_Tax ON ObjectFloat_RateFuelKind_Tax.ObjectId =inRateFuelKindId
                                                                              AND ObjectFloat_RateFuelKind_Tax.DescId = zc_ObjectFloat_RateFuelKind_Tax()
                         -- LEFT JOIN ObjectFloat AS ObjectFloat_Ratio ON ObjectFloat_Ratio.ObjectId = inFuelId
                         --                                           AND ObjectFloat_Ratio.DescId = zc_ObjectFloat_Fuel_Ratio()
                    WHERE MovementItem_Master.Id = inParentId
                   );
   END IF;


   -- ��������� <������� ���������>
   ioId := lpInsertUpdate_MovementItem (ioId, zc_MI_Child(), inFuelId, inMovementId, inAmount, inParentId);

   -- ��������� �������� <���������� �� ����� �������������� �� ����� ��� ���������>
   PERFORM lpInsertUpdate_MovementItemBoolean (zc_MIBoolean_Calculated(), ioId, inCalculated);
   
   -- ��������� �������� <�����, ���-�� ���� ����� >
   PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_ColdHour(), ioId, inColdHour);
   -- ��������� �������� <�����, ���-�� ���� �� >
   PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_ColdDistance(), ioId, inColdDistance);
   -- ��������� �������� <�����, ���-�� ����� � ���  >
   PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_AmountColdHour(), ioId, inAmountColdHour);
   -- ��������� �������� <�����, ���-�� ����� �� 100 �� >
   PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_AmountColdDistance(), ioId, inAmountColdDistance);
   -- ��������� �������� <���-�� ����� �� 100 ��>
   PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_AmountFuel(), ioId, inAmountFuel);
   -- ��������� �������� <� �� �������>
   PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_Number(), ioId, inNumber);
   -- ��������� �������� <% ��������������� ������� � ����� � �������/������������>
   PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_RateFuelKindTax(), ioId, inRateFuelKindTax);
   
   -- ��������� ����� � <���� ���� ��� �������>
   PERFORM lpInsertUpdate_MovementItemLinkObject(zc_MILinkObject_RateFuelKind(), ioId, inRateFuelKindId);


END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 01.10.13                                        * add inRateFuelKindTax and zfCalc_RateFuelValue
 29.09.13                                        *
*/

-- ����
-- SELECT * FROM lpInsertUpdate_MI_Transport_Child (ioId:= 0, inMovementId:= 10, inGoodsId:= 1, inAmount:= 0, inParentId:= NULL, inAmountReceipt:= 1, inComment:= '', inSession:= '2')
