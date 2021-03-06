-- Function: gpUnComplete_Movement_TransportIncome (Integer, TVarChar)

DROP FUNCTION IF EXISTS gpUnComplete_Movement_TransportIncome (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpUnComplete_Movement_TransportIncome(
    IN inMovementId        Integer               , -- ���� ���������
    IN inSession           TVarChar DEFAULT ''     -- ������ ������������
)                              
RETURNS VOID
AS
$BODY$
  DECLARE vbUserId Integer;
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId:= PERFORM lpCheckRight(inSession, zc_Enum_Process_UnComplete_TransportIncome());
     vbUserId:=2;


     -- �������� - ���� <Master> ������, �� <������>
     PERFORM lfCheck_Movement_ParentStatus (inMovementId:= inMovementId, inNewStatusId:= zc_Enum_Status_UnComplete(), inComment:= '�����������');


     -- ����������� ��������
     PERFORM lpUnComplete_Movement (inMovementId := inMovementId
                                  , inUserId     := vbUserId);


END;
$BODY$
LANGUAGE PLPGSQL VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 30.10.13         *
*/

-- ����
-- SELECT * FROM gpUnComplete_Movement_TransportIncome (inMovementId:= 149639, inSession:= zfCalc_UserAdmin())
