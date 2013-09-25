-- Function: gpInsertUpdate_MI_Transport_Child()

-- DROP FUNCTION gpInsertUpdate_MI_Transport_Child();

CREATE OR REPLACE FUNCTION gpInsertUpdate_MI_Transport_Child(
 INOUT ioId                  Integer   , -- ���� ������� <������� ���������>
    IN inMovementId          Integer   , -- ���� ������� <�������� ������������ - ����������>
    IN inFuelId              Integer   , -- ��� �������
    IN inAmount              TFloat    , -- ���������� �� �����
    IN inParentId            Integer   , -- ������� ������� ���������
    IN inCalculated          Boolean   , -- ���������� �� ����� �������������� �� ����� ��� ���������
    
    IN in�oldHour            TFloat    , -- �����, ���-�� ���� ����� 
    IN in�oldDistance        TFloat    , -- �����, ���-�� ���� �� 
    IN inAmount�oldHour      TFloat    , -- �����, ���-�� ����� � ���  
    IN inAmount�oldDistance  TFloat    , -- �����, ���-�� ����� �� 100 �� 
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

   -- ��������� <������� ���������>
   ioId := lpInsertUpdate_MovementItem (ioId, zc_MI_Child(), inFuelId, inMovementId, inAmount, inParentId);

   -- ��������� �������� <����������>
   PERFORM lpInsertUpdate_MovementItemBoolean (zc_MIBoolean_Calculated(), ioId, inCalculated);
   
   -- ��������� �������� <>
   PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_�oldHour(), ioId, in�oldHour);
   -- ��������� �������� <>
   PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_�oldDistance(), ioId, in�oldDistance);
   -- ��������� �������� <>
   PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_Amount�oldHour(), ioId, inAmount�oldHour);
   -- ��������� �������� <>
   PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_Amount�oldDistance(), ioId, inAmount�oldDistance);
   -- ��������� �������� <>
   PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_AmountFuel(), ioId, inAmountFuel);

   
   -- ��������� ����� � <���� ���� ��� �������>
   PERFORM lpInsertUpdate_MovementItemLinkObject(zc_MILinkObject_RateFuelKind(), ioId, inRateFuelKindId);
   
END;
$BODY$
LANGUAGE PLPGSQL VOLATILE;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 24.07.13                                        * ����� ������� �����
 15.07.13         *     
 30.06.13                                        *

*/

-- ����
-- SELECT * FROM gpInsertUpdate_MI_Transport_Child (ioId:= 0, inMovementId:= 10, inGoodsId:= 1, inAmount:= 0, inParentId:= NULL, inAmountReceipt:= 1, inComment:= '', inSession:= '2')
