-- Function: gpComplete_Movement_PersonalSendCash (Integer, TVarChar)

DROP FUNCTION IF EXISTS gpComplete_Movement_PersonalSendCash (Integer, TVarChar);
DROP FUNCTION IF EXISTS gpComplete_Movement_PersonalSendCash (Integer, Boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpComplete_Movement_PersonalSendCash(
    IN inMovementId        Integer  , -- ���� ���������
    IN inSession           TVarChar   -- ������ ������������
)                              
RETURNS VOID
AS
$BODY$
  DECLARE vbUserId Integer;
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Complete_Movement_PersonalSendCash());
     vbUserId:=2; -- CAST (inSession AS Integer);


     -- �������� ��������
     PERFORM lpComplete_Movement_PersonalSendCash (inMovementId := inMovementId
                                                 , inUserId     := vbUserId);



END;
$BODY$
LANGUAGE PLPGSQL VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 06.10.13                                        *
*/

-- ����
-- SELECT * FROM gpUnComplete_Movement (inMovementId:= 149721, inSession:= '2')
-- SELECT * FROM gpComplete_Movement_PersonalSendCash (inMovementId:= 149721, inSession:= '2')
-- SELECT * FROM gpSelect_MovementItemContainer_Movement (inMovementId:= 149721, inSession:= '2')
