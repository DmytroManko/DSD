-- Function: gpInsertUpdate_MI_Transport_Master()

-- DROP FUNCTION gpInsertUpdate_MI_Transport_Master();

CREATE OR REPLACE FUNCTION gpInsertUpdate_MI_Transport_Master(
 INOUT ioId                  Integer   , -- ���� ������� <������� ���������>
    IN inMovementId          Integer   , -- ���� ������� <��������>
    IN inRouteId             Integer   , -- �������
    IN inAmount	             TFloat    , -- ������, ��
    IN inWeight	             TFloat    , -- ��� �����
    IN inStartOdometre       TFloat    , -- ��������� ��������� ���������, ��
    IN inEndOdometre         TFloat    , -- ��������� �������� ���������, ��
--    IN inFreightId           Integer   , -- �������� �����
--    IN inRouteKindId         Integer   , -- ���� ���������
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

   -- ��� ������������ ��������, ����������� inAmount - ������, ��
   IF COALESCE (inStartOdometre, 0) <> 0 OR COALESCE (inEndOdometre, 0) <> 0
   THEN
       inAmount := ABS (COALESCE (inEndOdometre, 0) - COALESCE (inStartOdometre, 0));
   ELSE
       -- ����� ��������� ��������� ��������
       inAmount := ABS (inAmount);
   END IF;


   -- ��������� <������� ���������>
   ioId := lpInsertUpdate_MovementItem (ioId, zc_MI_Master(), inRouteId, inMovementId, inAmount, NULL);
  
   -- ��������� ����� � <�������� �����>
   -- PERFORM lpInsertUpdate_MovementItemLinkObject(zc_MILinkObject_Freight(), ioId, inFreightId);
   
   -- ��������� ����� � <���� ���������>
   -- PERFORM lpInsertUpdate_MovementItemLinkObject(zc_MILinkObject_RouteKind(), ioId, inRouteKindId);
  
   -- ��������� �������� <��� �����>
   PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_Weight(), ioId, inWeight);

   -- ��������� �������� <��������� ��������� ���������, ��>
   PERFORM lpInsertUpdate_MovementItemFloat(zc_MIFloat_Weight(), ioId, inStartOdometre);

   -- ��������� �������� <��������� �������� ���������, ��>
   PERFORM lpInsertUpdate_MovementItemFloat(zc_MIFloat_Weight(), ioId, inEndOdometre);

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 29.09.13                                        * 
 25.09.13         * 
*/

-- ����
-- SELECT * FROM gpInsertUpdate_MI_Transport_Master (ioId:= 0, inMovementId:= 10, inGoodsId:= 1, inAmount:= 0, inPartionClose:= FALSE, inComment:= '', inCount:= 1, inRealWeight:= 1, inCuterCount:= 0, inReceiptId:= 0, inSession:= '2')
