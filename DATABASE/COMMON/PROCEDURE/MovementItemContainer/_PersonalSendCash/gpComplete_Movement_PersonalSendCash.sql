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
     -- vbUserId:= PERFORM lpCheckRight (inSession, zc_Enum_Process_Complete_PersonalSendCash());
     vbUserId:=2; -- CAST (inSession AS Integer);


     -- ������� - ��������
     CREATE TEMP TABLE _tmpMIContainer_insert (Id Integer, DescId Integer, MovementId Integer, MovementItemId Integer, ContainerId Integer, ParentId Integer, Amount TFloat, OperDate TDateTime, IsActive Boolean) ON COMMIT DROP;
     -- ������� - �������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     CREATE TEMP TABLE _tmpItem (MovementItemId Integer, UnitId_ProfitLoss Integer
                               , ContainerId_From Integer, AccountId_From Integer, ContainerId_To Integer, AccountId_To Integer, PersonalId_To Integer, CarId_To Integer
                               , OperSumm TFloat
                               , ProfitLossGroupId Integer, ProfitLossDirectionId Integer, InfoMoneyDestinationId Integer, InfoMoneyId Integer
                               , BusinessId_Route Integer
                                ) ON COMMIT DROP;


     -- �������� ��������
     PERFORM lpComplete_Movement_PersonalSendCash (inMovementId := inMovementId
                                                 , inUserId     := vbUserId);



END;
$BODY$
LANGUAGE PLPGSQL VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 26.10.13                                        * add CREATE TEMP TABLE...
 06.10.13                                        *
*/

-- ����
-- SELECT * FROM gpUnComplete_Movement (inMovementId:= 149721, inSession:= zfCalc_UserAdmin())
-- SELECT * FROM gpComplete_Movement_PersonalSendCash (inMovementId:= 149721, inSession:= zfCalc_UserAdmin())
-- SELECT * FROM gpSelect_MovementItemContainer_Movement (inMovementId:= 149721, inSession:= zfCalc_UserAdmin())
