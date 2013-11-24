-- Function: gpComplete_Movement_BankAccount()

-- DROP FUNCTION gpComplete_Movement_BankAccount(Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpComplete_Movement_BankAccount(
    IN inMovementId        Integer              , -- ���� ���������
    IN inSession           TVarChar               -- ������ ������������
)                              
  RETURNS void AS
$BODY$
  DECLARE vbSumm TFloat;
  DECLARE vbOperDate TDateTime;
  DECLARE vbFromId Integer;
  DECLARE vbToId Integer;
  DECLARE vbFromDescId Integer;
  DECLARE vbToDescId Integer;
  DECLARE vbInfoMoneyId Integer;
  DECLARE vbContractId Integer;

  DECLARE vbMainJuridicalId Integer;
  DECLARE vbBusinessId Integer;
  DECLARE vbBankAccountId Integer;
  DECLARE vbInfoMoneyGroupId Integer;
  DECLARE vbInfoMoneyDestinationId Integer;
  DECLARE vbObjectId Integer;
  DECLARE vbObjectDescId Integer;
  DECLARE vbAccountId Integer;
  DECLARE vbAccountGroupId Integer;
  DECLARE vbAccountDirectionId Integer;
  DECLARE vbUserId Integer;
BEGIN
--   PERFORM lpCheckRight(inSession, zc_Enum_Process_Measure());
     vbUserId := 2; -- CAST (inSession AS Integer);

   -- ���������� �������� ���������. 
      SELECT OperDate 
           , Object_From.Id 
           , Object_To.Id
           , Object_From.DescId
           , Object_To.DescId
           , MovementLinkObject_InfoMoney.ObjectId
           , MovementFloat_Amount.ValueData
           , View_InfoMoney.InfoMoneyGroupId 
           , View_InfoMoney.InfoMoneyDestinationId
           , MovementLinkObject_Contract.ObjectId
           , MovementLinkObject_Business.ObjectId
             INTO vbOperDate, vbFromId, vbToId, vbFromDescId, vbToDescId, vbInfoMoneyId, 
                  vbSumm, vbInfoMoneyGroupId, vbInfoMoneyDestinationId, vbContractId, vbBusinessId
        FROM Movement 
   LEFT JOIN MovementLinkObject AS MovementLinkObject_From
          ON MovementLinkObject_From.MovementId = Movement.Id
         AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()
   LEFT JOIN Object AS Object_From ON Object_From.Id = MovementLinkObject_From.ObjectId
   LEFT JOIN MovementLinkObject AS MovementLinkObject_To
          ON MovementLinkObject_To.MovementId = Movement.Id
         AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
   LEFT JOIN MovementFloat AS MovementFloat_Amount 
          ON MovementFloat_Amount.DescId = zc_MovementFloat_Amount()
         AND MovementFloat_Amount.MovementId = Movement.Id
   LEFT JOIN MovementLinkObject AS MovementLinkObject_InfoMoney
          ON MovementLinkObject_InfoMoney.MovementId = Movement.Id
         AND MovementLinkObject_InfoMoney.DescId = zc_MovementLinkObject_InfoMoney()
   LEFT JOIN MovementLinkObject AS MovementLinkObject_Contract
          ON MovementLinkObject_Contract.MovementId = Movement.Id
         AND MovementLinkObject_Contract.DescId = zc_MovementLinkObject_Contract()
   LEFT JOIN MovementLinkObject AS MovementLinkObject_Business
          ON MovementLinkObject_Business.MovementId = Movement.Id
         AND MovementLinkObject_Business.DescId = zc_MovementLinkObject_Business()
   
   LEFT JOIN Object_InfoMoney_View AS View_InfoMoney ON View_InfoMoney.InfoMoneyId = MovementLinkObject_InfoMoney.ObjectId
   LEFT JOIN Object AS Object_To ON Object_To.Id = MovementLinkObject_To.ObjectId

   WHERE Movement.Id = inMovementId;

   -- ��������
   IF COALESCE (vbFromDescId, 0) = zc_Object_BankAccount()  
   THEN
      vbBankAccountId := vbFromId;
      vbObjectId := vbToId;  
      vbObjectDescId := vbToDescId;
   ELSE 
      IF COALESCE (vbToDescId, 0) = zc_Object_BankAccount()
      THEN
        vbBankAccountId := vbToId;
        vbObjectId := vbFromId;
        vbObjectDescId := vbFromDescId;
      ELSE 
         RAISE EXCEPTION '� ��������� �� ��������� ��������� ����. ���������� ����������';
      END IF;
   END IF;

   IF COALESCE (vbBusinessId, 0) = 0 
   THEN
     RAISE EXCEPTION '� ��������� �� ����������� �������� "������". ���������� ����������';
   END IF;
   

   -- ���������� � ����� ������ 
   SELECT 
      BankAccount_Juridical.ChildObjectId INTO vbMainJuridicalId
   FROM ObjectLink AS BankAccount_Juridical
  WHERE BankAccount_Juridical.ObjectId = vbBankAccountId AND BankAccount_Juridical.DescId = zc_ObjectLink_BankAccount_Juridical();

   IF COALESCE (vbMainJuridicalId, 0) = 0 
   THEN
     RAISE EXCEPTION '� ���������� ����� �� ����������� ������� �� ����. ���������� ����������';
   END IF;

   -- ���� �� ������
   IF vbBankAccountId = vbFromId 
   THEN
       -- ���������� ����� �� �������������� ���������
       CASE vbObjectDescId 
            -- ��. ����
            WHEN zc_Object_Juridical() THEN
                 -- �������� �� �������������� ������
                 SELECT outAccountGroupId, outAccountDirectionId INTO vbAccountGroupId, vbAccountDirectionId FROM lfGet_Object_AccountForJuridical(vbInfoMoneyDestinationId, true);
       END CASE;
   ELSE -- ��� ������
       CASE vbObjectDescId 
            -- ��. ����
            WHEN zc_Object_Juridical() THEN
                 -- �������� �� �������������� ������
                 SELECT outAccountGroupId, outAccountDirectionId INTO vbAccountGroupId, vbAccountDirectionId FROM lfGet_Object_AccountForJuridical(vbInfoMoneyDestinationId, true);
       END CASE;
   END IF;

   vbAccountId := lpInsertFind_Object_Account (inAccountGroupId         := vbAccountGroupId
                                             , inAccountDirectionId     := vbAccountDirectionId
                                             , inInfoMoneyDestinationId := vbInfoMoneyDestinationId
                                             , inInfoMoneyId            := NULL
                                             , inUserId                 := vbUserId
                                               );
                                                                                                      

   -- ������� - ��������� �������
   CREATE TEMP TABLE _tmpContainer (DescId Integer, ObjectId Integer) ON COMMIT DROP;

   -- ����������� �������� ��� ��������� ����� �� ���������� �����
   PERFORM lpInsertUpdate_MovementItemContainer (ioId:= 0
                                               , inDescId:= zc_MIContainer_Summ()
                                               , inMovementId:= inMovementId
                                               , inMovementItemId:= NULL
                                               , inParentId:= NULL
                                               , inContainerId:=  -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 
                                                                 lpInsertFind_Container (inContainerDescId:= zc_Container_Summ()
                                                                                       , inParentId:= NULL
                                                                                       , inObjectId:= zc_Enum_Account_40301()
                                                                                       , inJuridicalId_basis:= vbMainJuridicalId
                                                                                       , inBusinessId       := vbBusinessId
                                                                                       , inObjectCostDescId := NULL
                                                                                       , inObjectCostId     := NULL
                                                                                       , inDescId_1   := zc_ContainerLinkObject_Cash()
                                                                                       , inObjectId_1 := vbBankAccountId
                                                                                         )
                                                , inAmount:= - vbSumm
                                                , inOperDate:= vbOperDate
                                                , inIsActive:= (vbBankAccountId = vbToId));

   -- ����������� �������� �� �� �����
     -- ����������� �������� - ���� ���������� ��� ���������� (����������� ����)
     PERFORM lpInsertUpdate_MovementItemContainer (ioId:= 0
                                                 , inDescId:= zc_MIContainer_Summ()
                                                 , inMovementId:= inMovementId
                                                 , inMovementItemId:= NULL
                                                 , inParentId:= NULL
                                                 , inContainerId:=   -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)����������� ���� 2)���� ���� ������ 3)�������� 4)������ ����������
                                                                   lpInsertFind_Container (inContainerDescId:= zc_Container_Summ()
                                                                                         , inParentId:= NULL
                                                                                         , inObjectId:= vbAccountId
                                                                                         , inJuridicalId_basis:= vbMainJuridicalId
                                                                                         , inBusinessId       := vbBusinessId
                                                                                         , inObjectCostDescId := NULL
                                                                                         , inObjectCostId     := NULL
                                                                                         , inDescId_1   := zc_ContainerLinkObject_Juridical()
                                                                                         , inObjectId_1 := vbObjectId
                                                                                         , inDescId_2   := zc_ContainerLinkObject_PaidKind()
                                                                                         , inObjectId_2 := zc_Enum_PaidKind_FirstForm()
                                                                                         , inDescId_3   := zc_ContainerLinkObject_Contract()
                                                                                         , inObjectId_3 := COALESCE(vbContractId, 0)
                                                                                         , inDescId_4   := zc_ContainerLinkObject_InfoMoney()
                                                                                         , inObjectId_4 := vbInfoMoneyId
                                                                                        )
                                                 , inAmount:= vbSumm
                                                 , inOperDate:= vbOperDate
                                                 , inIsActive:= (vbBankAccountId = vbFromId)
                                                  );



  -- ����������� ������ ������ ���������
  UPDATE Movement SET StatusId = zc_Enum_Status_Complete() WHERE Id = inMovementId;

END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 24.11.13                                        * add View_InfoMoney
 26.08.13                        *                
*/
