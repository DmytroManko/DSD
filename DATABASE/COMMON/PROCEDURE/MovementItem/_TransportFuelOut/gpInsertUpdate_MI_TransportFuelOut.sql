-- Function: gpInsertUpdate_MI_TransportFuelOut()

-- DROP FUNCTION gpInsertUpdate_MI_TransportFuelOut();

CREATE OR REPLACE FUNCTION gpInsertUpdate_MI_TransportFuelOut(
 INOUT ioId                  Integer   , -- ���� ������� <������� ���������>
    IN inMovementId          Integer   , -- ���� ������� <��������>
    IN inFuelId              Integer   , -- �������
    IN inAmount              TFloat    , -- ����������
    IN inAmountNorm          TFloat    , -- ���������� �� �����
    IN inSession             TVarChar    -- ������ ������������
)                              
RETURNS Integer AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_MI_TransportFuelOut());
     vbUserId := inSession;

     -- ��������� <������� ���������>
     ioId := lpInsertUpdate_MovementItem (ioId, zc_MI_Master(), inFuelId, inMovementId, inAmount, NULL);
  
     -- ��������� ����� � <������ ���� ��������>
     PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_AmountNorm(), ioId, inAmountNorm); 

     -- ��������� ��������
     -- PERFORM lpInsert_MovementItemProtocol (ioId, vbUserId);

END;
$BODY$
LANGUAGE PLPGSQL VOLATILE;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 20.08.13         * 
 
*/

-- ����
-- SELECT * FROM gpInsertUpdate_MI_TransportFuelOut (ioId:= 0, inMovementId:= 10, inGoodsId:= 1, inAmount:= 0, inHeadCount:= 0, inPartionGoods:= '', inGoodsKindId:= 0, inSession:= '2')
