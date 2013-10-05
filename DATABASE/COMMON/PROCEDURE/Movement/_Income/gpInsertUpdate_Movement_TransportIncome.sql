-- Function: gpInsertUpdate_Movement_TransportIncome()

-- DROP FUNCTION gpInsertUpdate_Movement_TransportIncome();

CREATE OR REPLACE FUNCTION gpInsertUpdate_Movement_TransportIncome(
    IN inParentId            Integer   , -- ���� Master <��������>
 INOUT ioMovementId          Integer   , -- ���� ������� <��������>
   OUT outInvNumber          TVarChar  , -- ����� ���������
    IN inOperDate            TDateTime , -- ���� ���������
 INOUT ioPriceWithVAT        Boolean   , -- ���� � ��� (��/���)
 INOUT ioVATPercent          TFloat    , -- % ���
    IN inFromId              Integer   , -- �� ���� (� ���������)
    IN inToId                Integer   , -- ���� (� ���������)
 INOUT ioPaidKindId          Integer   , -- ���� ���� ������ 
 INOUT ioContractId          Integer   , -- ��������
 INOUT ioRouteId             Integer   , -- �������
    IN inPersonalDriverId    Integer   , -- ��������� (��������)
    IN inSession             TVarChar    -- ������ ������������
)                              
RETURNS RECORD
AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN


     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_Movement_Income());
     vbUserId := inSession;



     -- ��������� ����� ��������
     IF COALESCE (ioMovementId, 0) = 0 


     -- ��� ������ ��������� ���� ��������� � ������� ��������
     IF COALESCE (ioMovementId, 0) = 0 
     THEN
         -- ��������� �������� <����� ���������>
         outInvNumber := lfGet_InvNumber (0, zc_Movement_Income()
     END IF;

     -- ��������� <��������>
     ioId := lpInsertUpdate_Movement_IncomeFuel (ioId               := ioMovementId
                                               , inParentId         := inParentId
                                               , inInvNumber        := inInvNumber
                                               , inOperDate         := inOperDate
                                               , inPriceWithVAT     := inPriceWithVAT
                                               , inVATPercent       := inVATPercent
                                               , inFromId           := inFromId
                                               , inToId             := inToId
                                               , inPaidKindId       := inPaidKindId
                                               , inContractId       := inContractId
                                               , inRouteId          := inRouteId
                                               , inPersonalDriverId := inPersonalDriverId
                                               , inUserId           := vbUserId 
                                                );
END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 05.10.13                                        *
*/

-- ����
-- SELECT * FROM gpInsertUpdate_Movement_TransportIncome (ioId:= 0, inInvNumber:= '-1', inOperDate:= '01.01.2013', inOperDatePartner:= '01.01.2013', inInvNumberPartner:= 'xxx', inPriceWithVAT:= true, inVATPercent:= 20, inChangePercent:= 0, inFromId:= 1, inToId:= 2, inPaidKindId:= 1, inContractId:= 0, inCarId:= 0, inPersonalDriverId:= 0, inPersonalPackerId:= 0, inSession:= '2')
