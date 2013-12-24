-- Function: gpInsertUpdate_Movement_Cash()

DROP FUNCTION IF EXISTS 
   gpInsertUpdate_Movement_Cash(Integer, TVarChar, TdateTime, TFloat, TFloat, TVarChar, Integer, Integer, Integer, Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_Movement_Cash(
 INOUT ioId                  Integer   , -- ���� ������� <��������>
    IN inInvNumber           TVarChar  , -- ����� ���������
    IN inOperDate            TDateTime , -- ���� ���������
    IN inAmountIn            TFloat    , -- ����� �������
    IN inAmountOut           TFloat    , -- ����� �������
    IN inComment             TVarChar  , -- �����������
    IN inCashId              Integer   , -- �����
    IN inMoneyPlaceId        Integer   , -- ������� ������ � �������� 
    IN inContractId          Integer   , -- ��������
    IN inInfoMoneyId         Integer   , -- �������������� ������
    IN inUnitId              Integer   , -- �������������
    IN inSession             TVarChar    -- ������ ������������
)                              
RETURNS Integer AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbAmount TFloat;
   DECLARE vbMovementItemId Integer;
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_Movement_Cash());
     vbUserId := lpGetUserBySession(inSession);
   
     IF (COALESCE(inAmountIn, 0) = 0) AND (COALESCE(inAmountOut, 0) = 0) THEN
        RAISE EXCEPTION '������� ����� ������� ��� �������';
     END IF;

     IF (COALESCE(inAmountIn, 0) <> 0) AND (COALESCE(inAmountOut, 0) <> 0) THEN
        RAISE EXCEPTION '������� ����� ������� � �������. ������� ���-�� ����';
     END IF;

     IF inAmountIn > 0 THEN
        vbAmount := inAmountIn;
     ELSE
        vbAmount := - inAmountOut;
     END IF;

     -- ��������� <��������>
     ioId := lpInsertUpdate_Movement (ioId, zc_Movement_Cash(), inInvNumber, inOperDate, NULL);

     SELECT MovementItem.Id INTO vbMovementItemId FROM MovementItem 
      WHERE MovementItem.MovementId = ioId AND MovementItem.DescId = zc_MI_Master();

        -- ��������� <������� ���������>
     vbMovementItemId := lpInsertUpdate_MovementItem (vbMovementItemId, zc_MI_Master(), inCashId, ioId, vbAmount, NULL);


     -- ��������� ����� � <������>
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_MoneyPlace(), vbMovementItemId, inMoneyPlaceId);
    
     -- �����������
     PERFORM lpInsertUpdate_MovementItemString (zc_MIString_Comment(), vbMovementItemId, inComment);

     -- ��������� ����� � <�������������� ������ >
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_InfoMoney(), vbMovementItemId, inInfoMoneyId);
     -- ��������� ����� � <��������>
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_Contract(), vbMovementItemId, inContractId);
     -- ��������� ����� � <��������������>
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_Unit(), vbMovementItemId, inUnitId);

     -- ��������� ��������
     -- PERFORM lpInsert_MovementProtocol (ioId, vbUserId);

END;
$BODY$
LANGUAGE PLPGSQL VOLATILE;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 23.12.13                        *                
 19.11.13                        *                
 06.08.13                        *                

*/

-- ����
-- SELECT * FROM gpInsertUpdate_Movement_Cash (ioId:= 0, inInvNumber:= '-1', inOperDate:= '01.01.2013', inOperDatePartner:= '01.01.2013', inInvNumberPartner:= 'xxx', inPriceWithVAT:= true, inVATPercent:= 20, inChangePercent:= 0, inFromId:= 1, inToId:= 2, inPaidKindId:= 1, inContractId:= 0, inCarId:= 0, inPersonalDriverId:= 0, inPersonalPackerId:= 0, inSession:= '2')
