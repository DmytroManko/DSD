-- Function: gpComplete_Movement_TransportIncome()

DROP FUNCTION IF EXISTS gpComplete_Movement_TransportIncome (Integer, Boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpComplete_Movement_TransportIncome(
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
     -- vbUserId:=PERFORM lpCheckRight (inSession, zc_Enum_Process_Complete_TransportIncome());
     vbUserId:=2; -- CAST (inSession AS Integer);


END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 30.10.13         *
*/

-- ����
-- SELECT * FROM gpUnComplete_Movement_TransportIncome (inMovementId:= 149639, inSession:= '2')
-- SELECT * FROM gpComplete_Movement_TransportIncome (inMovementId:= 149639, inIsLastComplete:= FALSE, inSession:= '2')
-- SELECT * FROM gpSelect_MovementItemContainer_TransportIncome (inMovementId:= 149639, inSession:= '2')
