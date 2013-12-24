-- Function: gpInsertUpdate_Movement_Service()

DROP FUNCTION IF EXISTS gpinsertupdate_movement_service(integer, tvarchar, tdatetime, tfloat, integer, integer, integer, integer, integer, integer, tvarchar);
DROP FUNCTION IF EXISTS gpinsertupdate_movement_service(integer, tvarchar, tdatetime, tfloat, tvarchar, integer, integer, integer, integer, integer, integer, integer, tvarchar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_Movement_Service(
 INOUT ioId                  Integer   , -- ���� ������� <��������>
    IN inInvNumber           TVarChar  , -- ����� ���������
    IN inOperDate            TDateTime , -- ���� ���������
    IN inAmount              TFloat    , -- ����� �������� 
    IN inComment             TVarChar  , -- �����������
    IN inBusinessId          Integer   , -- ������    
    IN inContractId          Integer   , -- �������
    IN inInfoMoneyId         Integer   , -- ������ ���������� 
    IN inJuridicalId         Integer   , -- ��. ����	
    IN inJuridicalBasisId    Integer   , -- ������� ��. ����	
    IN inPaidKindId          Integer   , -- ���� ���� ������
    IN inUnitId              Integer   , -- �������������
    IN inSession             TVarChar    -- ������ ������������
)                              
RETURNS Integer AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbMovementItemId Integer;
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_Movement_Service());
     vbUserId := lpGetUserBySession(inSession);

     -- ��������� <��������>
     ioId := lpInsertUpdate_Movement (ioId, zc_Movement_Service(), inInvNumber, inOperDate, NULL);

     SELECT MovementItem.Id INTO vbMovementItemId FROM MovementItem 
      WHERE MovementItem.MovementId = ioId AND MovementItem.DescId = zc_MI_Master();

        -- ��������� <������� ���������>
     vbMovementItemId := lpInsertUpdate_MovementItem (vbMovementItemId, zc_MI_Master(), inJuridicalId, ioId, inAmount, NULL);
    
     -- �����������
     PERFORM lpInsertUpdate_MovementItemString (zc_MIString_Comment(), vbMovementItemId, inComment);

     -- ��������� ����� � <���� ���� ������>
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_PaidKind(), vbMovementItemId, inPaidKindId);
     -- ��������� ����� � <�������������� ������ >
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_InfoMoney(), vbMovementItemId, inInfoMoneyId);
     -- ��������� ����� � <��������>
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_Contract(), vbMovementItemId, inContractId);
     -- ��������� ����� � <��������������>
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_Unit(), vbMovementItemId, inUnitId);

     -- ��������� ��������
     -- PERFORM lpInsert_MovementProtocol (ioId, vbUserId);
     -- ��������� ����� � <������� ��. ����>
--     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_JuridicalBasis(), ioId, inJuridicalBasisId);

     -- ��������� ����� � <������>
--     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_Business(), ioId, inBusinessId);

END;
$BODY$
LANGUAGE PLPGSQL VOLATILE;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 24.12.13                        *
 11.08.13         *

*/

-- ����
-- SELECT * FROM gpInsertUpdate_Movement_Service (ioId:= 0, inInvNumber:= '-1', inOperDate:= '01.01.2013', inAmount:= 20, inJuridicalId:= 1, inMainJuridicalId:= 1, inBusinessId:= 2, inPaidKindId:= 1,  inInfoMoneyId:= 0, inUnitId:= 0, inSession:= '2')
