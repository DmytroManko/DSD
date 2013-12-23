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
     CREATE TEMP TABLE _tmpItem (myId Integer, OperDate TDateTime, ObjectId Integer, ObjectDescId Integer, OperSumm TFloat
                               , ContainerId Integer
                               , AccountGroupId Integer, AccountDirectionId Integer, AccountId Integer
                               , ProfitLossGroupId Integer, ProfitLossDirectionId Integer
                               , InfoMoneyGroupId Integer, InfoMoneyDestinationId Integer, InfoMoneyId Integer
                               , BusinessId Integer, JuridicalId_Basis Integer
                               , UnitId Integer, ContractId Integer, PaidKindId Integer
                               , IsActive Boolean
                                ) ON COMMIT DROP;


     -- ��������� ������� - �������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     INSERT INTO _tmpItem (myId, OperDate, ObjectId, ObjectDescId, OperSumm
                         , ContainerId
                         , AccountGroupId, AccountDirectionId, AccountId
                         , ProfitLossGroupId, ProfitLossDirectionId
                         , InfoMoneyGroupId, InfoMoneyDestinationId, InfoMoneyId
                         , BusinessId, JuridicalId_Basis
                         , UnitId, ContractId, PaidKindId
                         , IsActive
                          )
        SELECT 1 AS myId
             , Movement.OperDate
             , COALESCE (MovementLinkObject_From.ObjectId, 0) AS ObjectId
             , COALESCE (Object.DescId, 0) AS ObjectDescId
             , COALESCE (MovementFloat_Amount.ValueData, 0) AS OperSumm
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
               -- ������: ���� ��� �����, ����� �� ����� ��� �� ��-�� ���������, ����� �� ��-�� ���������
             , COALESCE (CASE WHEN Object.DescId = zc_Object_Cash()
                                   THEN COALESCE (ObjectLink_Cash_Business.ChildObjectId, MovementLinkObject_Business.ObjectId)
                              ELSE MovementLinkObject_Business.ObjectId
                         END, 0) AS BusinessId
               -- ������� ��.���� ������ �� �����
             , COALESCE (ObjectLink_Cash_MainJuridical.ChildObjectId, 0) AS JuridicalId_Basis
             , COALESCE (MovementLinkObject_Unit.ObjectId, 0) AS UnitId
             , COALESCE (MovementLinkObject_Contract.ObjectId, 0) AS ContractId
             , zc_Enum_PaidKind_SecondForm() AS PaidKindId
             , FALSE
        FROM Movement
             LEFT JOIN MovementFloat AS MovementFloat_Amount 
                                     ON MovementFloat_Amount.MovementId = Movement.Id
                                    AND MovementFloat_Amount.DescId = zc_MovementFloat_Amount()
             LEFT JOIN MovementLinkObject AS MovementLinkObject_From
                                          ON MovementLinkObject_From.MovementId = Movement.Id
                                         AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()
             LEFT JOIN MovementLinkObject AS MovementLinkObject_To
                                          ON MovementLinkObject_To.MovementId = Movement.Id
                                         AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
             LEFT JOIN MovementLinkObject AS MovementLinkObject_InfoMoney
                                          ON MovementLinkObject_InfoMoney.MovementId = Movement.Id
                                         AND MovementLinkObject_InfoMoney.DescId = zc_MovementLinkObject_InfoMoney()
             LEFT JOIN MovementLinkObject AS MovementLinkObject_Unit
                                          ON MovementLinkObject_Unit.MovementId = Movement.Id
                                         AND MovementLinkObject_Unit.DescId = zc_MovementLinkObject_Unit()
             LEFT JOIN MovementLinkObject AS MovementLinkObject_Contract
                                          ON MovementLinkObject_Contract.MovementId = Movement.Id
                                         AND MovementLinkObject_Contract.DescId = zc_MovementLinkObject_Contract()
             LEFT JOIN MovementLinkObject AS MovementLinkObject_Business
                                          ON MovementLinkObject_Business.MovementId = Movement.Id
                                         AND MovementLinkObject_Business.DescId = zc_MovementLinkObject_Business()

             LEFT JOIN Object ON Object.Id = MovementLinkObject_From.ObjectId
             LEFT JOIN ObjectLink AS ObjectLink_Cash_Business ON ObjectLink_Cash_Business.ObjectId = CASE WHEN Object.DescId = zc_Object_Cash() THEN Object.Id ELSE MovementLinkObject_To.ObjectId END
                                                             AND ObjectLink_Cash_Business.DescId = zc_ObjectLink_Cash_Business()
             LEFT JOIN ObjectLink AS ObjectLink_Cash_MainJuridical ON ObjectLink_Cash_MainJuridical.ObjectId = CASE WHEN Object.DescId = zc_Object_Cash() THEN Object.Id ELSE MovementLinkObject_To.ObjectId END
                                                                  AND ObjectLink_Cash_MainJuridical.DescId = zc_ObjectLink_Cash_MainJuridical()

             LEFT JOIN Object_InfoMoney_View AS View_InfoMoney ON View_InfoMoney.InfoMoneyId = MovementLinkObject_InfoMoney.ObjectId
             LEFT JOIN lfSelect_Object_Unit_byProfitLossDirection() AS lfObject_Unit_byProfitLossDirection ON lfObject_Unit_byProfitLossDirection.UnitId = MovementLinkObject_Unit.ObjectId
        WHERE Movement.Id = inMovementId
          AND Movement.DescId = zc_Movement_Cash()
          AND Movement.StatusId IN (zc_Enum_Status_UnComplete(), zc_Enum_Status_Erased())
       ;

     -- ��������� ������� - �������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     INSERT INTO _tmpItem (myId, OperDate, ObjectId, ObjectDescId, OperSumm
                         , ContainerId
                         , AccountGroupId, AccountDirectionId, AccountId
                         , ProfitLossGroupId, ProfitLossDirectionId
                         , InfoMoneyGroupId, InfoMoneyDestinationId, InfoMoneyId
                         , BusinessId, JuridicalId_Basis
                         , UnitId, ContractId, PaidKindId
                         , IsActive
                          )
        SELECT 2 AS myId
             , _tmpItem.OperDate
             , COALESCE (MovementLinkObject_To.ObjectId, 0) AS ObjectId
             , Object.DescId AS ObjectDescId
             , _tmpItem.OperSumm
             , _tmpItem.ContainerId
             , _tmpItem.AccountGroupId, _tmpItem.AccountDirectionId, _tmpItem.AccountId
             , _tmpItem.ProfitLossGroupId, _tmpItem.ProfitLossDirectionId
             , _tmpItem.InfoMoneyGroupId, _tmpItem.InfoMoneyDestinationId, _tmpItem.InfoMoneyId
               -- ������: ���� ��� �����, ����� �� �����, ����� �� ��-�� ���������
             , COALESCE (ObjectLink_Cash_Business.ChildObjectId, MovementLinkObject_Business.ObjectId) AS BusinessId
               -- ������� ��.���� ������ �� �����
             , COALESCE (ObjectLink_Cash_MainJuridical.ChildObjectId, _tmpItem.JuridicalId_Basis) AS JuridicalId_Basis
             , _tmpItem.UnitId, _tmpItem.ContractId, _tmpItem.PaidKindId
             , TRUE AS IsActive
        FROM _tmpItem
             LEFT JOIN MovementLinkObject AS MovementLinkObject_To
                                          ON MovementLinkObject_To.MovementId = inMovementId
                                         AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
             LEFT JOIN MovementLinkObject AS MovementLinkObject_Business
                                          ON MovementLinkObject_Business.MovementId = inMovementId
                                         AND MovementLinkObject_Business.DescId = zc_MovementLinkObject_Business()
             LEFT JOIN Object ON Object.Id = MovementLinkObject_To.ObjectId
             LEFT JOIN ObjectLink AS ObjectLink_Cash_Business ON ObjectLink_Cash_Business.ObjectId = Object.Id
                                                             AND ObjectLink_Cash_Business.DescId = zc_ObjectLink_Cash_Business()
             LEFT JOIN ObjectLink AS ObjectLink_Cash_MainJuridical ON ObjectLink_Cash_MainJuridical.ObjectId = Object.Id
                                                                  AND ObjectLink_Cash_MainJuridical.DescId = zc_ObjectLink_Cash_MainJuridical()
       ;

/*
     -- ��������
     IF COALESCE (vbFromDescId, 0) = zc_Object_Cash()  
         RAISE EXCEPTION '� ��������� �� ���������� �����. ���������� ����������';
     END IF;
   
     -- ��������
     IF COALESCE (vbMainJuridicalId, 0) = 0 
     THEN
         RAISE EXCEPTION '� ����� �� ����������� ������� �� ����. ���������� ����������';
     END IF;
*/


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

     -- 1.1.2. ������������ ���� ��� �������� ��������� �����
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
       -- ��� ������� ��������
       SELECT 0, zc_MIContainer_Summ() AS DescId, inMovementId, 0 AS MovementItemId, _tmpItem.ContainerId, 0 AS ParentId
            , CASE WHEN _tmpItem.myId = 1 THEN -1 ELSE 1 END * _tmpItem.OperSumm
            , _tmpItem.OperDate
            , _tmpItem.IsActive
       FROM _tmpItem;

/*
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
     FROM (SELECT NULL :: Integer AS MovementItemId
                , _tmpItem_Passive.OperSumm, _tmpItem_Passive.OperDate
                , _tmpItem_Active.ContainerId AS ActiveContainerId, _tmpItem_Active.AccountId AS ActiveAccountId
                , _tmpItem_Passive.ContainerId AS PassiveContainerId, _tmpItem_Passive.AccountId AS PassiveAccountId
           FROM _tmpItem AS _tmpItem_Passive
                LEFT JOIN _tmpItem AS _tmpItem_Active ON _tmpItem_Active.myId = 2
           WHERE _tmpItem_Passive.myId = 1 
          ) AS _tmpItem
    ;*/


     -- ��� �����
     RETURN QUERY SELECT _tmpItem.OperDate, _tmpItem.ObjectId, _tmpItem.ObjectDescId, _tmpItem.OperSumm, _tmpItem.ContainerId, _tmpItem.AccountGroupId, _tmpItem.AccountDirectionId, _tmpItem.AccountId, _tmpItem.ProfitLossGroupId, _tmpItem.ProfitLossDirectionId, _tmpItem.InfoMoneyGroupId, _tmpItem.InfoMoneyDestinationId, _tmpItem.InfoMoneyId, _tmpItem.BusinessId, _tmpItem.JuridicalId_Basis, _tmpItem.UnitId, _tmpItem.ContractId, _tmpItem.PaidKindId, _tmpItem.IsActive FROM _tmpItem;

     -- 5.1. ����� - ����������� ��������� ��������
     PERFORM lpInsertUpdate_MovementItemContainer_byTable ();

     -- 5.2. ����� - ����������� ������ ������ ���������
     UPDATE Movement SET StatusId = zc_Enum_Status_Complete() WHERE Id = inMovementId AND DescId = zc_Movement_Income() AND StatusId IN (zc_Enum_Status_UnComplete(), zc_Enum_Status_Erased());


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
-- SELECT * FROM gpComplete_Movement_Cash (inMovementId:= 3538, inSession:= zfCalc_UserAdmin())
-- SELECT * FROM gpSelect_MovementItemContainer_Movement (inMovementId:= 3538 , inSession:= zfCalc_UserAdmin())
