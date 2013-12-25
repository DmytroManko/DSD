-- Function: gpComplete_Movement_Cash()

DROP FUNCTION IF EXISTS gpComplete_Movement_Cash (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpComplete_Movement_Cash(
    IN inMovementId        Integer              , -- ���� ���������
    IN inSession           TVarChar               -- ������ ������������
)                              
--  RETURNS void
  RETURNS TABLE (OperDate TDateTime, ObjectId Integer, ObjectDescId Integer, OperSumm TFloat, ContainerId Integer, AccountGroupId Integer, AccountDirectionId Integer, AccountId Integer, ProfitLossGroupId Integer, ProfitLossDirectionId Integer, InfoMoneyGroupId Integer, InfoMoneyDestinationId Integer, InfoMoneyId Integer, BusinessId Integer, JuridicalId_Basis Integer, UnitId Integer, ContractId Integer, PaidKindId Integer, IsActive Boolean)
AS
$BODY$
  DECLARE vbUserId Integer;
BEGIN
--   PERFORM lpCheckRight(inSession, zc_Enum_Process_Measure());
     vbUserId := 2; -- CAST (inSession AS Integer);


     -- ������� - ��������
     CREATE TEMP TABLE _tmpMIContainer_insert (Id Integer, DescId Integer, MovementId Integer, MovementItemId Integer, ContainerId Integer, ParentId Integer, Amount TFloat, OperDate TDateTime, IsActive Boolean) ON COMMIT DROP;

     -- ������� - �������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     CREATE TEMP TABLE _tmpItem (OperDate TDateTime, ObjectId Integer, ObjectDescId Integer, OperSumm TFloat
                               , MovementItemId Integer, ContainerId Integer
                               , AccountGroupId Integer, AccountDirectionId Integer, AccountId Integer
                               , ProfitLossGroupId Integer, ProfitLossDirectionId Integer
                               , InfoMoneyGroupId Integer, InfoMoneyDestinationId Integer, InfoMoneyId Integer
                               , BusinessId Integer, JuridicalId_Basis Integer
                               , UnitId Integer, ContractId Integer, PaidKindId Integer
                               , IsActive Boolean
                                ) ON COMMIT DROP;


     -- ��������� ������� - �������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     INSERT INTO _tmpItem (OperDate, ObjectId, ObjectDescId, OperSumm
                         , MovementItemId, ContainerId
                         , AccountGroupId, AccountDirectionId, AccountId
                         , ProfitLossGroupId, ProfitLossDirectionId
                         , InfoMoneyGroupId, InfoMoneyDestinationId, InfoMoneyId
                         , BusinessId, JuridicalId_Basis
                         , UnitId, ContractId, PaidKindId
                         , IsActive
                          )
        SELECT Movement.OperDate
             , COALESCE (MovementItem.ObjectId, 0) AS ObjectId
             , COALESCE (Object.DescId, 0) AS ObjectDescId
             , MovementItem.Amount AS OperSumm
             , MovementItem.Id AS MovementItemId
             , 0 AS ContainerId                                               -- ���������� �����
             , 0 AS AccountGroupId, 0 AS AccountDirectionId, 0 AS AccountId   -- ���������� �����
               -- ������ ����
             , COALESCE (lfObject_Unit_byProfitLossDirection.ProfitLossGroupId, 0) AS ProfitLossGroupId
               -- ��������� ���� - �����������
             , COALESCE (lfObject_Unit_byProfitLossDirection.ProfitLossDirectionId, 0) AS ProfitLossDirectionId
               -- �������������� ������ ����������
             , COALESCE (View_InfoMoney.InfoMoneyGroupId, 0) AS InfoMoneyGroupId
               -- �������������� ����������
             , COALESCE (View_InfoMoney.InfoMoneyDestinationId, 0) AS InfoMoneyDestinationId
               -- �������������� ������ ����������
             , COALESCE (View_InfoMoney.InfoMoneyId, 0) AS InfoMoneyId
               -- ������: �� ����� ��� �� ��-�� ObjectLink_Unit_Business
             , COALESCE (ObjectLink_Cash_Business.ChildObjectId, COALESCE (ObjectLink_Unit_Business.ChildObjectId, 0)) AS BusinessId
               -- ������� ��.���� ������ �� �����
             , COALESCE (ObjectLink_Cash_MainJuridical.ChildObjectId, 0) AS JuridicalId_Basis
             , COALESCE (MILinkObject_Unit.ObjectId, 0) AS UnitId
             , COALESCE (MILinkObject_Contract.ObjectId, 0) AS ContractId
             , zc_Enum_PaidKind_SecondForm() AS PaidKindId
             , CASE WHEN MovementItem.Amount >= 0 THEN TRUE ELSE FALSE END
        FROM Movement
             JOIN MovementItem ON MovementItem.MovementId = Movement.Id AND MovementItem.DescId = zc_MI_Master()

             LEFT JOIN MovementItemLinkObject AS MILinkObject_InfoMoney
                                              ON MILinkObject_InfoMoney.MovementItemId = MovementItem.Id
                                             AND MILinkObject_InfoMoney.DescId = zc_MILinkObject_InfoMoney()
             LEFT JOIN MovementItemLinkObject AS MILinkObject_Unit
                                              ON MILinkObject_Unit.MovementItemId = MovementItem.Id
                                             AND MILinkObject_Unit.DescId = zc_MILinkObject_Unit()
             LEFT JOIN MovementItemLinkObject AS MILinkObject_Contract
                                              ON MILinkObject_Contract.MovementItemId = MovementItem.Id
                                             AND MILinkObject_Contract.DescId = zc_MILinkObject_Contract()

             LEFT JOIN Object ON Object.Id = MovementItem.ObjectId
             LEFT JOIN ObjectLink AS ObjectLink_Cash_MainJuridical ON ObjectLink_Cash_MainJuridical.ObjectId = MovementItem.ObjectId
                                                                  AND ObjectLink_Cash_MainJuridical.DescId = zc_ObjectLink_Cash_MainJuridical()
             LEFT JOIN ObjectLink AS ObjectLink_Cash_Business ON ObjectLink_Cash_Business.ObjectId = MovementItem.ObjectId
                                                             AND ObjectLink_Cash_Business.DescId = zc_ObjectLink_Cash_Business()
             LEFT JOIN ObjectLink AS ObjectLink_Unit_Business ON ObjectLink_Unit_Business.ObjectId = MILinkObject_Unit.ObjectId
                                                             AND ObjectLink_Unit_Business.DescId = zc_ObjectLink_Unit_Business()
             LEFT JOIN lfSelect_Object_Unit_byProfitLossDirection() AS lfObject_Unit_byProfitLossDirection ON lfObject_Unit_byProfitLossDirection.UnitId = MILinkObject_Unit.ObjectId
             LEFT JOIN Object_InfoMoney_View AS View_InfoMoney ON View_InfoMoney.InfoMoneyId = MILinkObject_InfoMoney.ObjectId
        WHERE Movement.Id = inMovementId
          AND Movement.DescId = zc_Movement_Cash()
          AND Movement.StatusId IN (zc_Enum_Status_UnComplete(), zc_Enum_Status_Erased())
       ;


     -- ��������
     IF EXISTS (SELECT _tmpItem.ObjectId FROM _tmpItem WHERE _tmpItem.ObjectId = 0)
     THEN
         RAISE EXCEPTION '� ��������� �� ���������� �����. ���������� ����������.';
     END IF;
   
     -- ��������
     IF EXISTS (SELECT _tmpItem.JuridicalId_Basis FROM _tmpItem WHERE _tmpItem.JuridicalId_Basis = 0)
     THEN
         RAISE EXCEPTION '� ����� �� ����������� ������� �� ����. ���������� ����������.';
     END IF;


     -- ��������� ������� - �������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     INSERT INTO _tmpItem (OperDate, ObjectId, ObjectDescId, OperSumm
                         , MovementItemId, ContainerId
                         , AccountGroupId, AccountDirectionId, AccountId
                         , ProfitLossGroupId, ProfitLossDirectionId
                         , InfoMoneyGroupId, InfoMoneyDestinationId, InfoMoneyId
                         , BusinessId, JuridicalId_Basis
                         , UnitId, ContractId, PaidKindId
                         , IsActive
                          )
        SELECT _tmpItem.OperDate
             , COALESCE (MILinkObject_MoneyPlace.ObjectId, 0) AS ObjectId
             , COALESCE (Object.DescId, 0) AS ObjectDescId
             , -1 * _tmpItem.OperSumm
             , _tmpItem.MovementItemId
             , 0 AS ContainerId                                               -- ���������� �����
             , 0 AS AccountGroupId, 0 AS AccountDirectionId, 0 AS AccountId   -- ���������� �����
             , _tmpItem.ProfitLossGroupId, _tmpItem.ProfitLossDirectionId
             , _tmpItem.InfoMoneyGroupId, _tmpItem.InfoMoneyDestinationId, _tmpItem.InfoMoneyId
               -- ������: ���� ��� ����, ����� �� ObjectLink_Unit_Business, ����� �� �����
             , CASE WHEN Object.Id IS NULL THEN COALESCE (ObjectLink_Unit_Business.ChildObjectId, 0) ELSE _tmpItem.BusinessId END AS BusinessId
               -- ������� ��.���� ������ �� �����
             , _tmpItem.JuridicalId_Basis
             , _tmpItem.UnitId, _tmpItem.ContractId, _tmpItem.PaidKindId
             , NOT _tmpItem.IsActive
        FROM _tmpItem
             LEFT JOIN MovementItemLinkObject AS MILinkObject_MoneyPlace
                                              ON MILinkObject_MoneyPlace.MovementItemId = _tmpItem.MovementItemId
                                             AND MILinkObject_MoneyPlace.DescId = zc_MILinkObject_MoneyPlace()
             LEFT JOIN Object ON Object.Id = MILinkObject_MoneyPlace.ObjectId
             LEFT JOIN ObjectLink AS ObjectLink_Unit_Business ON ObjectLink_Unit_Business.ObjectId = _tmpItem.UnitId
                                                             AND ObjectLink_Unit_Business.DescId = zc_ObjectLink_Unit_Business()
       ;



     -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
     -- !!! �� � ������ - �������� !!!
     -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

     -- 1.1.1 ������������ AccountDirectionId ��� �������� ��������� �����
     UPDATE _tmpItem SET AccountDirectionId =    CASE WHEN _tmpItem.ObjectDescId = zc_Object_BankAccount()
                                                           THEN zc_Enum_AccountDirection_40300() -- ���������� ����
                                                      WHEN _tmpItem.ObjectDescId = zc_Object_Cash() AND ObjectLink_Cash_Branch.ChildObjectId IS NOT NULL
                                                           THEN zc_Enum_AccountDirection_40200() -- ����� ��������
                                                      WHEN _tmpItem.ObjectDescId = zc_Object_Cash() AND ObjectLink_Cash_Branch.ChildObjectId IS NULL
                                                           THEN zc_Enum_AccountDirection_40100() -- �����

                                                      WHEN _tmpItem.ObjectDescId = zc_Object_Member() AND _tmpItem.InfoMoneyGroupId = zc_Enum_InfoMoneyGroup_40000() -- ���������� ������������
                                                           THEN zc_Enum_AccountDirection_30400() -- ������ ��������
                                                      WHEN _tmpItem.ObjectDescId = zc_Object_Member() AND _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_80300() -- ������� � �����������
                                                           THEN zc_Enum_AccountDirection_100400() -- ������� � �����������
                                                      WHEN _tmpItem.ObjectDescId = zc_Object_Member()
                                                           THEN zc_Enum_AccountDirection_30500() -- ���������� (����������� ����)
                                                      WHEN _tmpItem.ObjectDescId = zc_Object_Personal()
                                                           THEN zc_Enum_AccountDirection_70500() -- ���������� �����

                                                      WHEN COALESCE (ObjectBoolean_isCorporate.ValueData, FALSE) = TRUE
                                                           THEN zc_Enum_AccountDirection_30200() -- ���� ��������
                                                      WHEN _tmpItem.ObjectDescId = zc_Object_Juridical() AND _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30400() -- ������ ���������������
                                                           THEN zc_Enum_AccountDirection_30300() -- ������ ���������������
                                                      WHEN _tmpItem.ObjectDescId = zc_Object_Juridical() AND _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30500() -- ������ ������
                                                           THEN zc_Enum_AccountDirection_30400() -- ������ ��������
                                                      WHEN _tmpItem.ObjectDescId = zc_Object_Juridical() AND _tmpItem.InfoMoneyGroupId = zc_Enum_InfoMoneyGroup_30000() -- ������
                                                           THEN zc_Enum_AccountDirection_30100() -- ����������

                                                      WHEN _tmpItem.ObjectDescId = zc_Object_Juridical() AND _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_21400() -- ������ ����������
                                                           THEN zc_Enum_AccountDirection_70200() -- ������ ����������
                                                      WHEN _tmpItem.ObjectDescId = zc_Object_Juridical() AND _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_21500() -- ���������
                                                           THEN zc_Enum_AccountDirection_70300() -- ���������
                                                      WHEN _tmpItem.ObjectDescId = zc_Object_Juridical() AND _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_21600() -- ������������ ������
                                                           THEN zc_Enum_AccountDirection_70400() -- ������������ ������
                                                      WHEN _tmpItem.ObjectDescId = zc_Object_Juridical() AND _tmpItem.InfoMoneyGroupId IN (zc_Enum_InfoMoneyGroup_10000(), zc_Enum_InfoMoneyGroup_20000()) -- �������� �����; �������������
                                                           THEN zc_Enum_AccountDirection_70100() -- ����������

                                                      WHEN _tmpItem.ObjectDescId = zc_Object_Juridical() AND _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_70500() -- ���
                                                           THEN zc_Enum_AccountDirection_70900() -- ���
                                                      WHEN _tmpItem.ObjectDescId = zc_Object_Juridical() AND _tmpItem.InfoMoneyGroupId = zc_Enum_InfoMoneyGroup_70000() -- ����������
                                                           THEN zc_Enum_AccountDirection_70800() -- ���������������� ��

                                                      WHEN _tmpItem.ObjectDescId = zc_Object_Juridical() AND _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_40100() -- ������� ������
                                                           THEN zc_Enum_AccountDirection_80100() -- ������� ������
                                                      WHEN _tmpItem.ObjectDescId = zc_Object_Juridical() AND _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_40200() -- ������ �������
                                                           THEN zc_Enum_AccountDirection_80200() -- ������ �������
                                                      WHEN _tmpItem.ObjectDescId = zc_Object_Juridical() AND _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_40400() -- �������� �� ��������
                                                           THEN zc_Enum_AccountDirection_80400() -- �������� �� ��������
                                                      WHEN _tmpItem.ObjectDescId = zc_Object_Juridical() AND _tmpItem.InfoMoneyGroupId = zc_Enum_InfoMoneyGroup_40000() -- ���������� ������������
                                                           THEN zc_Enum_AccountDirection_30400() -- ������ ��������

                                                      WHEN _tmpItem.ObjectDescId = zc_Object_Juridical() AND _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_50200() -- ��������� �������
                                                           THEN zc_Enum_AccountDirection_90100() -- ��������� �������
                                                      WHEN _tmpItem.ObjectDescId = zc_Object_Juridical() AND _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_50300() -- ��������� ������� (������)
                                                           THEN zc_Enum_AccountDirection_90200() -- ��������� ������� (������)
                                                      WHEN _tmpItem.ObjectDescId = zc_Object_Juridical() AND _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_50100() -- ��������� ������� �� ��
                                                           THEN zc_Enum_AccountDirection_90300() -- ��������� ������� �� ��
                                                      WHEN _tmpItem.ObjectDescId = zc_Object_Juridical() AND _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_50400() -- ������ � ������*
                                                          THEN zc_Enum_AccountDirection_90400() -- ������ � ������*
                                                 END
     FROM Object
          LEFT JOIN ObjectLink AS ObjectLink_Cash_Branch
                               ON ObjectLink_Cash_Branch.ObjectId = Object.Id
                              AND ObjectLink_Cash_Branch.DescId = zc_ObjectLink_Cash_Branch()
                              AND ObjectLink_Cash_Branch.ChildObjectId <> zc_Branch_Basis()
          LEFT JOIN ObjectBoolean AS ObjectBoolean_isCorporate
                                  ON ObjectBoolean_isCorporate.ObjectId = Object.Id
                                 AND ObjectBoolean_isCorporate.DescId = zc_ObjectBoolean_Juridical_isCorporate()
     WHERE Object.Id = _tmpItem.ObjectId;

     -- 1.1.2. ������������ AccountGroupId ��� �������� ��������� �����
     UPDATE _tmpItem SET AccountGroupId = View_AccountDirection.AccountGroupId
     FROM Object_AccountDirection_View AS View_AccountDirection
     WHERE View_AccountDirection.AccountDirectionId = _tmpItem.AccountDirectionId;

     -- 1.1.3. ������������ ���� ��� �������� ��������� �����
     UPDATE _tmpItem SET AccountId = CASE WHEN _tmpItem.ObjectDescId = 0
                                               THEN zc_Enum_Account_100301() -- ������� �������� �������
                                          WHEN _tmpItem.AccountDirectionId = zc_Enum_AccountDirection_40300() -- ���������� ����
                                               THEN zc_Enum_Account_40301() -- ���������� ����
                                          WHEN _tmpItem.AccountDirectionId = zc_Enum_AccountDirection_40200() -- ����� ��������
                                               THEN zc_Enum_Account_40201() -- ����� ��������
                                          WHEN _tmpItem.AccountDirectionId = zc_Enum_AccountDirection_40100() -- �����
                                               THEN zc_Enum_Account_40101() -- �����
                                          ELSE lpInsertFind_Object_Account (inAccountGroupId         := _tmpItem.AccountGroupId
                                                                          , inAccountDirectionId     := _tmpItem.AccountDirectionId
                                                                          , inInfoMoneyDestinationId := _tmpItem.InfoMoneyDestinationId
                                                                          , inInfoMoneyId            := NULL
                                                                          , inInsert                 := FALSE
                                                                          , inUserId                 := vbUserId
                                                                           )
                                     END;

     -- 1.2. ������������ ObjectId ��� �������� ��������� ����� �� ����� �������
     UPDATE _tmpItem SET ObjectId = lpInsertFind_Object_ProfitLoss (inProfitLossGroupId      := _tmpItem.ProfitLossGroupId
                                                                  , inProfitLossDirectionId  := _tmpItem.ProfitLossDirectionId
                                                                  , inInfoMoneyDestinationId := _tmpItem.InfoMoneyDestinationId
                                                                  , inInfoMoneyId            := NULL
                                                                  , inInsert                 := FALSE
                                                                  , inUserId                 := vbUserId
                                                                   )
                      , OperSumm = CASE WHEN _tmpItem.IsActive = TRUE THEN -1 ELSE 1 END * _tmpItem.OperSumm
                      , IsActive = FALSE -- !!!������ �� �������!!!
     WHERE _tmpItem.AccountId = zc_Enum_Account_100301(); -- ������� �������� �������


     -- 2. ������������ ContainerId ��� �������� ��������� �����
     UPDATE _tmpItem SET ContainerId = CASE WHEN _tmpItem.AccountGroupId = zc_Enum_AccountGroup_40000() -- �������� ��������
                                                 THEN lpInsertFind_Container (inContainerDescId   := zc_Container_Summ()
                                                                            , inParentId          := NULL
                                                                            , inObjectId          := _tmpItem.AccountId
                                                                            , inJuridicalId_basis := _tmpItem.JuridicalId_Basis
                                                                            , inBusinessId        := _tmpItem.BusinessId
                                                                            , inObjectCostDescId  := NULL
                                                                            , inObjectCostId      := NULL
                                                                            , inDescId_1          := CASE WHEN _tmpItem.AccountId = zc_Enum_AccountDirection_40300() THEN zc_ContainerLinkObject_BankAccount () ELSE zc_ContainerLinkObject_Cash() END
                                                                            , inObjectId_1        := _tmpItem.ObjectId
                                                                             )
                                            WHEN _tmpItem.AccountId = zc_Enum_Account_100301() -- ������� �������� �������
                                                 THEN lpInsertFind_Container (inContainerDescId   := zc_Container_Summ()
                                                                            , inParentId          := NULL
                                                                            , inObjectId          := _tmpItem.AccountId
                                                                            , inJuridicalId_basis := _tmpItem.JuridicalId_Basis
                                                                            , inBusinessId        := _tmpItem.BusinessId
                                                                            , inObjectCostDescId  := NULL
                                                                            , inObjectCostId      := NULL
                                                                            , inDescId_1          := zc_ContainerLinkObject_ProfitLoss()
                                                                            , inObjectId_1        := _tmpItem.ObjectId
                                                                             )
                                            WHEN _tmpItem.ObjectDescId = zc_Object_Member()
                                                 THEN lpInsertFind_Container (inContainerDescId   := zc_Container_Summ()
                                                                            , inParentId          := NULL
                                                                            , inObjectId          := _tmpItem.AccountId
                                                                            , inJuridicalId_basis := _tmpItem.JuridicalId_Basis
                                                                            , inBusinessId        := _tmpItem.BusinessId
                                                                            , inObjectCostDescId  := NULL
                                                                            , inObjectCostId      := NULL
                                                                            , inDescId_1          := zc_ContainerLinkObject_Member()
                                                                            , inObjectId_1        := _tmpItem.ObjectId
                                                                            , inDescId_2          := zc_ContainerLinkObject_InfoMoney()
                                                                            , inObjectId_2        := _tmpItem.InfoMoneyId
                                                                            , inDescId_3          := zc_ContainerLinkObject_Car()
                                                                            , inObjectId_3        := 0 -- ��� ����������(����������� ����) !!!������ ����� ��������� ��������� ������ �������� = 0!!!
                                                                             )
                                            WHEN _tmpItem.ObjectDescId = zc_Object_Juridical()
                                             AND _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10100() -- ������ �����
                                                      -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)����������� ���� 2)���� ���� ������ 3)�������� 4)������ ���������� 5)������ ���������
                                                 THEN lpInsertFind_Container (inContainerDescId   := zc_Container_Summ()
                                                                            , inParentId          := NULL
                                                                            , inObjectId          := _tmpItem.AccountId
                                                                            , inJuridicalId_basis := _tmpItem.JuridicalId_Basis
                                                                            , inBusinessId        := _tmpItem.BusinessId
                                                                            , inObjectCostDescId  := NULL
                                                                            , inObjectCostId      := NULL
                                                                            , inDescId_1          := zc_ContainerLinkObject_Juridical()
                                                                            , inObjectId_1        := _tmpItem.ObjectId
                                                                            , inDescId_2          := zc_ContainerLinkObject_PaidKind()
                                                                            , inObjectId_2        := _tmpItem.PaidKindId
                                                                            , inDescId_3          := zc_ContainerLinkObject_Contract()
                                                                            , inObjectId_3        := _tmpItem.ContractId
                                                                            , inDescId_4          := zc_ContainerLinkObject_InfoMoney()
                                                                            , inObjectId_4        := _tmpItem.InfoMoneyId
                                                                            , inDescId_5          := zc_ContainerLinkObject_PartionMovement()
                                                                            , inObjectId_5        := 0 -- !!!�� ���� ��������� ���� ���� �� �����!!!
                                                                             )
                                            WHEN _tmpItem.ObjectDescId = zc_Object_Juridical()
                                                      -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)����������� ���� 2)���� ���� ������ 3)�������� 4)������ ����������
                                                 THEN lpInsertFind_Container (inContainerDescId   := zc_Container_Summ()
                                                                            , inParentId          := NULL
                                                                            , inObjectId          := _tmpItem.AccountId
                                                                            , inJuridicalId_basis := _tmpItem.JuridicalId_Basis
                                                                            , inBusinessId        := _tmpItem.BusinessId
                                                                            , inObjectCostDescId  := NULL
                                                                            , inObjectCostId      := NULL
                                                                            , inDescId_1          := zc_ContainerLinkObject_Juridical()
                                                                            , inObjectId_1        := _tmpItem.ObjectId
                                                                            , inDescId_2          := zc_ContainerLinkObject_PaidKind()
                                                                            , inObjectId_2        := _tmpItem.PaidKindId
                                                                            , inDescId_3          := zc_ContainerLinkObject_Contract()
                                                                            , inObjectId_3        := _tmpItem.ContractId
                                                                            , inDescId_4          := zc_ContainerLinkObject_InfoMoney()
                                                                            , inObjectId_4        := _tmpItem.InfoMoneyId
                                                                             )
                                       END;


     -- 3. ����������� �������� 
     INSERT INTO _tmpMIContainer_insert (Id, DescId, MovementId, MovementItemId, ContainerId, ParentId, Amount, OperDate, IsActive)
       SELECT 0, zc_MIContainer_Summ() AS DescId, inMovementId, _tmpItem.MovementItemId, _tmpItem.ContainerId, 0 AS ParentId
            , _tmpItem.OperSumm
            , _tmpItem.OperDate
            , _tmpItem.IsActive
       FROM _tmpItem;


     -- 4. ����������� �������� ��� ������
     PERFORM lpInsertUpdate_MovementItemReport (inMovementId         := inMovementId
                                              , inMovementItemId     := _tmpItem.MovementItemId
                                              , inActiveContainerId  := _tmpItem.ActiveContainerId
                                              , inPassiveContainerId := _tmpItem.PassiveContainerId
                                              , inActiveAccountId    := _tmpItem.ActiveAccountId
                                              , inPassiveAccountId   := _tmpItem.PassiveAccountId
                                              , inReportContainerId  := lpInsertFind_ReportContainer (inActiveContainerId  := _tmpItem.ActiveContainerId
                                                                                                    , inPassiveContainerId := _tmpItem.PassiveContainerId
                                                                                                    , inActiveAccountId    := _tmpItem.ActiveAccountId
                                                                                                    , inPassiveAccountId   := _tmpItem.PassiveAccountId
                                                                                                     )
                                              , inChildReportContainerId := lpInsertFind_ChildReportContainer (inActiveContainerId  := _tmpItem.ActiveContainerId
                                                                                                             , inPassiveContainerId := _tmpItem.PassiveContainerId
                                                                                                             , inActiveAccountId    := _tmpItem.ActiveAccountId
                                                                                                             , inPassiveAccountId   := _tmpItem.PassiveAccountId
                                                                                                             , inAccountKindId_1    := NULL
                                                                                                             , inContainerId_1      := NULL
                                                                                                             , inAccountId_1        := NULL
                                                                                                              )
                                              , inAmount   := _tmpItem.OperSumm
                                              , inOperDate := _tmpItem.OperDate
                                               )
     FROM (SELECT _tmpItem_Active.MovementItemId
                , _tmpItem_Active.OperSumm, _tmpItem_Active.OperDate
                , _tmpItem_Active.ContainerId AS ActiveContainerId, _tmpItem_Active.AccountId AS ActiveAccountId
                , _tmpItem_Passive.ContainerId AS PassiveContainerId, _tmpItem_Passive.AccountId AS PassiveAccountId
           FROM _tmpItem AS _tmpItem_Active
                LEFT JOIN _tmpItem AS _tmpItem_Passive ON _tmpItem_Passive.IsActive = FALSE AND _tmpItem_Passive.MovementItemId = _tmpItem_Active.MovementItemId
           WHERE _tmpItem_Active.IsActive = TRUE
          ) AS _tmpItem
    ;


     -- ��� �����
     -- RETURN QUERY SELECT _tmpItem.OperDate, _tmpItem.ObjectId, _tmpItem.ObjectDescId, _tmpItem.OperSumm, _tmpItem.ContainerId, _tmpItem.AccountGroupId, _tmpItem.AccountDirectionId, _tmpItem.AccountId, _tmpItem.ProfitLossGroupId, _tmpItem.ProfitLossDirectionId, _tmpItem.InfoMoneyGroupId, _tmpItem.InfoMoneyDestinationId, _tmpItem.InfoMoneyId, _tmpItem.BusinessId, _tmpItem.JuridicalId_Basis, _tmpItem.UnitId, _tmpItem.ContractId, _tmpItem.PaidKindId, _tmpItem.IsActive FROM _tmpItem;

     -- 5.1. ����� - ����������� ��������� ��������
     PERFORM lpInsertUpdate_MovementItemContainer_byTable ();

     -- 5.2. ����� - ����������� ������ ������ ���������
     UPDATE Movement SET StatusId = zc_Enum_Status_Complete() WHERE Id = inMovementId AND DescId = zc_Movement_Cash() AND StatusId IN (zc_Enum_Status_UnComplete(), zc_Enum_Status_Erased());


END;$BODY$
  LANGUAGE plpgsql VOLATILE;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 23.12.13                                        * all
 24.11.13                                        * add View_InfoMoney
 13.08.13                        *                
*/

-- ����
-- SELECT * FROM lpUnComplete_Movement (inMovementId:= 3581, inUserId:= zfCalc_UserAdmin() :: Integer)
-- SELECT * FROM gpComplete_Movement_Cash (inMovementId:= 3581, inSession:= zfCalc_UserAdmin())
-- SELECT * FROM gpSelect_MovementItemContainer_Movement (inMovementId:= 3581, inSession:= zfCalc_UserAdmin())
