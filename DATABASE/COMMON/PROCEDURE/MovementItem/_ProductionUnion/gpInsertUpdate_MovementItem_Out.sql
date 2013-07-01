-- Function: gpInsertUpdate_MovementItem_Out()

-- DROP FUNCTION gpInsertUpdate_MovementItem_Out();

CREATE OR REPLACE FUNCTION gpInsertUpdate_MovementItem_Out(
 INOUT ioId                  Integer   , -- ���� ������� <������� ���������>
    IN inMovementId          Integer   , -- ���� ������� <��������>
    IN inGoodsId             Integer   , -- ������
    IN inAmount              TFloat    , -- ����������
    IN inParentId          Integer,
    IN inAmountReceipt     TFloat,        /* ���������� �� ��������� �� 1 ����� */
    IN inComment	         TVarChar,      /* �����������	                   */
    IN inSession             TVarChar    -- ������ ������������
)                              
RETURNS Integer AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN

   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_MovementItem_Income());
   vbUserId := inSession;

   -- ��������� <������� ���������>
   ioId := lpInsertUpdate_MovementItem (ioId, zc_MI_Child(), inGoodsId, inMovementId, inAmount, inParentId);
   
   PERFORM lpInsertUpdate_MovementItemString (zc_MIString_Comment(), ioId, inComment);

   PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_AmountReceipt(), ioId, inAmountReceipt);

END;
$BODY$
LANGUAGE PLPGSQL VOLATILE;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
               
 30.06.13                                        *

*/

-- ����
-- SELECT * FROM gpInsertUpdate_MovementItem_Out (ioId:= 0, inMovementId:= 10, inGoodsId:= 1, inAmount:= 0, inParentId:= NULL, inAmountReceipt:= 1, inComment:= '', inSession:= '2')
