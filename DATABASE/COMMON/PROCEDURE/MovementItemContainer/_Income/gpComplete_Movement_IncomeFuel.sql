-- Function: gpComplete_Movement_IncomeFuel()

DROP FUNCTION IF EXISTS gpComplete_Movement_IncomeFuel (Integer, Boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpComplete_Movement_IncomeFuel(
    IN inMovementId        Integer                , -- ���� ���������
    IN inIsLastComplete    Boolean  DEFAULT False , -- ��� ��������� ���������� ����� ������� �/� (��� ������� �������� !!!�� ��������������!!!)
    IN inSession           TVarChar DEFAULT ''      -- ������ ������������
)                              
RETURNS VOID
AS
$BODY$
  DECLARE vbUserId Integer;
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId:=PERFORM lpCheckRight (inSession, zc_Enum_Process_Complete_IncomeFueld());
     vbUserId:=2; -- CAST (inSession AS Integer);


END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 30.10.13                                        *
*/

-- ����
-- SELECT * FROM gpUnComplete_MovementFuel (inMovementId:= 149639, inSession:= '2')
-- SELECT * FROM gpComplete_Movement_IncomeFuel (inMovementId:= 149639, inIsLastComplete:= FALSE, inSession:= '2')
-- SELECT * FROM gpSelect_MovementItemContainer_MovementFuel (inMovementId:= 149639, inSession:= '2')
