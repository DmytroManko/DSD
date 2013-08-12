-- Function: gpInsertUpdate_MovementItem_BankStatement()

-- DROP FUNCTION gpInsertUpdate_MovementItem_BankStatement();

CREATE OR REPLACE FUNCTION gpInsertUpdate_MovementItem_BankStatement(
 INOUT ioId                  Integer   , -- ���� ������� <������� ���������>
    IN inMovementId          Integer   , -- ���� ������� <��������>
    IN inAmount              TFloat    , -- ����� ��������
    IN inOKPO                TVarChar  , -- ����
    IN inInfoMoneyId         Integer   , -- �������������� ������
    IN inContractId          Integer   , -- �������
    IN inUnitId              Integer   , -- ������������� 
    IN inSession             TVarChar    -- ������ ������������
)                              
RETURNS Integer AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_MovementItem_BankStatement());
     vbUserId := inSession;

     -- ��������� <������� ���������>
     ioId := lpInsertUpdate_MovementItem (ioId, zc_MI_Master(), inGoodsId, inMovementId, inAmount, NULL);
   
     -- ��������� �������� <����>
     PERFORM lpInsertUpdate_MovementItemString (zc_MIString_OKPO(), ioId, inOKPO);

     -- ��������� ����� � <�������������� ������>
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_InfoMoney(), ioId, inInfoMoneyId);
     -- ��������� ����� � <�������>
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_Contract(), ioId, inContractId);
     -- ��������� ����� � <�������������>
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_Unit(), ioId, inUnitId);     

     -- ��������� ��������
     -- PERFORM lpInsert_MovementItemProtocol (ioId, vbUserId);

END;
$BODY$
LANGUAGE PLPGSQL VOLATILE;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 12.08.13          *
*/

-- ����
-- SELECT * FROM gpInsertUpdate_MovementItem_BankStatement (ioId:= 0, inMovementId:= 10, inAmount:= 0, , inSession:= '2')
