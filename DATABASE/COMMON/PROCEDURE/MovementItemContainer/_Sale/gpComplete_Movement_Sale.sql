-- Function: gpComplete_Movement_Sale()

-- DROP FUNCTION gpComplete_Movement_Sale (Integer, TVarChar);
-- DROP FUNCTION gpComplete_Movement_Sale (Integer, Boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpComplete_Movement_Sale(
    IN inMovementId        Integer               , -- ���� ���������
    IN inIsLastComplete    Boolean  DEFAULT FALSE, -- ��� ��������� ���������� ����� ������� �/� (��� ������� �������� !!!�� ��������������!!!)
    IN inSession           TVarChar DEFAULT ''     -- ������ ������������
)                              
 RETURNS VOID
--  RETURNS TABLE (OperSumm_Partner_byItem TFloat, OperSumm_Partner TFloat, OperSumm_Partner_byChangePercent_byItem TFloat, OperSumm_Partner_byChangePercent TFloat, PriceWithVAT Boolean, VATPercent TFloat, DiscountPercent TFloat, ExtraChargesPercent TFloat, UnitId_From Integer, PersonalId_From Integer, BranchId_From Integer, JuridicalId_To Integer, IsCorporate Boolean, PersonalId_To Integer, InfoMoneyDestinationId_isCorporate Integer, InfoMoneyId_isCorporate Integer, PaidKindId Integer, ContractId Integer, JuridicalId_basis Integer, BusinessId Integer)
AS
$BODY$
  DECLARE vbUserId Integer;

  DECLARE vbOperSumm_byPriceList_byItem TFloat;
  DECLARE vbOperSumm_byPriceList TFloat;
  DECLARE vbOperSumm_Partner_byItem TFloat;
  DECLARE vbOperSumm_Partner TFloat;
  DECLARE vbOperSumm_Partner_byChangePercent_byItem TFloat;
  DECLARE vbOperSumm_Partner_byChangePercent TFloat;

  DECLARE vbPriceWithVAT Boolean;
  DECLARE vbVATPercent TFloat;
  DECLARE vbDiscountPercent TFloat;
  DECLARE vbExtraChargesPercent TFloat;

  DECLARE vbUnitId_From Integer;
  DECLARE vbPersonalId_From Integer;
  DECLARE vbBranchId_From Integer;

  DECLARE vbJuridicalId_To Integer;
  DECLARE vbIsCorporate Boolean;
  DECLARE vbPersonalId_To Integer;
  DECLARE vbInfoMoneyDestinationId_isCorporate Integer;
  DECLARE vbInfoMoneyId_isCorporate Integer;
  DECLARE vbInfoMoneyDestinationId_Contract Integer;
  DECLARE vbInfoMoneyId_Contract Integer;
  DECLARE vbPaidKindId Integer;
  DECLARE vbContractId Integer;
  DECLARE vbJuridicalId_basis Integer;
  DECLARE vbBusinessId Integer;

BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Complete_Movement_Sale());
     vbUserId:=2; -- CAST (inSession AS Integer);


     -- ��� ��������� ����� ��� ������� �������� ���� �� ����������� ��� ��������� � ��� ������������ �������� � ���������
     SELECT
           COALESCE (MovementBoolean_PriceWithVAT.ValueData, TRUE)
         , COALESCE (MovementFloat_VATPercent.ValueData, 0)
         , CASE WHEN COALESCE (MovementFloat_ChangePercent.ValueData, 0) < 0 THEN -MovementFloat_ChangePercent.ValueData ELSE 0 END
         , CASE WHEN COALESCE (MovementFloat_ChangePercent.ValueData, 0) > 0 THEN MovementFloat_ChangePercent.ValueData ELSE 0 END

         , COALESCE (CASE WHEN Object_From.DescId = zc_Object_Unit() THEN MovementLinkObject_From.ObjectId ELSE 0 END, 0) AS UnitId_From
         , COALESCE (CASE WHEN Object_From.DescId = zc_Object_Personal() THEN MovementLinkObject_From.ObjectId ELSE 0 END, 0) AS PersonalId_From
         , COALESCE (CASE WHEN Object_From.DescId = zc_Object_Unit() THEN ObjectLink_UnitFrom_Branch.ChildObjectId WHEN Object_From.DescId = zc_Object_Personal() THEN ObjectLink_UnitPersonalFrom_Branch.ChildObjectId ELSE 0 END, 0)

         , COALESCE (CASE WHEN Object_To.DescId <> zc_Object_Member() THEN ObjectLink_Partner_Juridical.ChildObjectId ELSE 0 END, 0)
         , COALESCE (ObjectBoolean_isCorporate.ValueData, FALSE) AS isCorporate
         , COALESCE (CASE WHEN Object_To.DescId = zc_Object_Member() THEN Object_To.Id ELSE 0 END, 0)

         , COALESCE (MovementLinkObject_PaidKind.ObjectId, 0)
         , COALESCE (MovementLinkObject_Contract.ObjectId, 0)

           -- ������ ���������� (���� ���� ��������)
         , COALESCE (ObjectLink_Juridical_InfoMoney.ObjectId, 0)
           -- ������ ���������� (���� �� ��������)
         , COALESCE (ObjectLink_Contract_InfoMoney.ObjectId, 0)

         , COALESCE (CASE WHEN Object_From.DescId = zc_Object_Unit() THEN ObjectLink_UnitFrom_Juridical.ChildObjectId WHEN Object_From.DescId = zc_Object_Personal() THEN ObjectLink_UnitPersonalFrom_Juridical.ChildObjectId ELSE 0 END, 0)
         , COALESCE (CASE WHEN Object_From.DescId = zc_Object_Unit() THEN ObjectLink_UnitFrom_Business.ChildObjectId WHEN Object_From.DescId = zc_Object_Personal() THEN ObjectLink_UnitPersonalFrom_Business.ChildObjectId ELSE 0 END, 0)

           INTO vbPriceWithVAT, vbVATPercent, vbDiscountPercent, vbExtraChargesPercent
              , vbUnitId_From, vbPersonalId_From, vbBranchId_From
              , vbJuridicalId_To, vbIsCorporate, vbPersonalId_To
              , vbPaidKindId, vbContractId
              , vbInfoMoneyId_isCorporate, vbInfoMoneyId_Contract
              , vbJuridicalId_basis, vbBusinessId
     FROM Movement
          LEFT JOIN MovementBoolean AS MovementBoolean_PriceWithVAT
                   ON MovementBoolean_PriceWithVAT.MovementId = Movement.Id
                  AND MovementBoolean_PriceWithVAT.DescId = zc_MovementBoolean_PriceWithVAT()
          LEFT JOIN MovementFloat AS MovementFloat_VATPercent
                   ON MovementFloat_VATPercent.MovementId = Movement.Id
                  AND MovementFloat_VATPercent.DescId = zc_MovementFloat_VATPercent()
          LEFT JOIN MovementFloat AS MovementFloat_ChangePercent
                 ON MovementFloat_ChangePercent.MovementId = Movement.Id
                AND MovementFloat_ChangePercent.DescId = zc_MovementFloat_ChangePercent()

          LEFT JOIN MovementLinkObject AS MovementLinkObject_From
                                       ON MovementLinkObject_From.MovementId = Movement.Id
                                      AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()
          LEFT JOIN Object AS Object_From ON Object_From.Id = MovementLinkObject_From.ObjectId

          LEFT JOIN MovementLinkObject AS MovementLinkObject_To
                                       ON MovementLinkObject_To.MovementId = Movement.Id
                                      AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
          LEFT JOIN Object AS Object_To ON Object_To.Id = MovementLinkObject_To.ObjectId

          LEFT JOIN ObjectLink AS ObjectLink_UnitFrom_Juridical
                               ON ObjectLink_UnitFrom_Juridical.ObjectId = MovementLinkObject_From.ObjectId
                              AND ObjectLink_UnitFrom_Juridical.DescId = zc_ObjectLink_Unit_Juridical()
                              AND Object_From.DescId = zc_Object_Unit()
          LEFT JOIN ObjectLink AS ObjectLink_UnitFrom_Business
                               ON ObjectLink_UnitFrom_Business.ObjectId = MovementLinkObject_From.ObjectId
                              AND ObjectLink_UnitFrom_Business.DescId = zc_ObjectLink_Unit_Business()
                              AND Object_From.DescId = zc_Object_Unit()
          LEFT JOIN ObjectLink AS ObjectLink_UnitFrom_Branch
                               ON ObjectLink_UnitFrom_Branch.ObjectId = MovementLinkObject_From.ObjectId
                              AND ObjectLink_UnitFrom_Branch.DescId = zc_ObjectLink_Unit_Branch()
                              AND Object_From.DescId = zc_Object_Unit()
          LEFT JOIN ObjectLink AS ObjectLink_PersonalFrom_Unit
                               ON ObjectLink_PersonalFrom_Unit.ObjectId = MovementLinkObject_From.ObjectId
                              AND ObjectLink_PersonalFrom_Unit.DescId = zc_ObjectLink_Personal_Unit()
                              AND Object_From.DescId = zc_Object_Personal()
          LEFT JOIN ObjectLink AS ObjectLink_UnitPersonalFrom_Juridical
                               ON ObjectLink_UnitPersonalFrom_Juridical.ObjectId = ObjectLink_PersonalFrom_Unit.ChildObjectId
                              AND ObjectLink_UnitPersonalFrom_Juridical.DescId = zc_ObjectLink_Unit_Juridical()
                              AND Object_From.DescId = zc_Object_Personal()
          LEFT JOIN ObjectLink AS ObjectLink_UnitPersonalFrom_Business
                               ON ObjectLink_UnitPersonalFrom_Business.ObjectId = ObjectLink_PersonalFrom_Unit.ChildObjectId
                              AND ObjectLink_UnitPersonalFrom_Business.DescId = zc_ObjectLink_Unit_Business()
                              AND Object_From.DescId = zc_Object_Personal()
          LEFT JOIN ObjectLink AS ObjectLink_UnitPersonalFrom_Branch
                               ON ObjectLink_UnitPersonalFrom_Branch.ObjectId = ObjectLink_PersonalFrom_Unit.ChildObjectId
                              AND ObjectLink_UnitPersonalFrom_Branch.DescId = zc_ObjectLink_Unit_Branch()
                              AND Object_From.DescId = zc_Object_Personal()

          LEFT JOIN ObjectLink AS ObjectLink_Partner_Juridical
                               ON ObjectLink_Partner_Juridical.ObjectId = MovementLinkObject_To.ObjectId
                              AND ObjectLink_Partner_Juridical.DescId = zc_ObjectLink_Partner_Juridical()
                              AND Object_To.DescId = zc_Object_Partner()
          LEFT JOIN ObjectLink AS ObjectLink_Juridical_InfoMoney
                               ON ObjectLink_Juridical_InfoMoney.ObjectId = ObjectLink_Partner_Juridical.ChildObjectId
                              AND ObjectLink_Juridical_InfoMoney.DescId = zc_ObjectLink_Juridical_InfoMoney()
         LEFT JOIN ObjectBoolean AS ObjectBoolean_isCorporate
                                 ON ObjectBoolean_isCorporate.ObjectId = ObjectLink_Partner_Juridical.ChildObjectId
                                AND ObjectBoolean_isCorporate.DescId = zc_ObjectBoolean_Juridical_isCorporate()

         LEFT JOIN MovementLinkObject AS MovementLinkObject_PaidKind
                                      ON MovementLinkObject_PaidKind.MovementId = Movement.Id
                                     AND MovementLinkObject_PaidKind.DescId = zc_MovementLinkObject_PaidKind()
         LEFT JOIN MovementLinkObject AS MovementLinkObject_Contract
                                      ON MovementLinkObject_Contract.MovementId = Movement.Id
                                     AND MovementLinkObject_Contract.DescId = zc_MovementLinkObject_Contract()

     WHERE Movement.Id = inMovementId
       AND Movement.DescId = zc_Movement_Sale()
       AND Movement.StatusId = zc_Enum_Status_UnComplete();


     -- ��� ��������� ����� ��� ��� ������������ �������� � ��������� (���� ���� ��������)
     SELECT
            -- �������������� ���������� (���� ���� ��������)
            COALESCE (lfObject_InfoMoney_isCorporate.InfoMoneyDestinationId, 0)
            INTO vbInfoMoneyDestinationId_isCorporate
     FROM lfGet_Object_InfoMoney (vbInfoMoneyId_isCorporate) AS lfObject_InfoMoney_isCorporate
     WHERE vbIsCorporate = TRUE;

(���� �� ��������)

     -- ��� ����� - ���������
     -- RETURN QUERY SELECT CAST (vbOperSumm_Partner_byItem AS TFloat) AS OperSumm_Partner_byItem, CAST (vbOperSumm_Partner AS TFloat) AS OperSumm_Partner, CAST (vbOperSumm_Partner_byChangePercent_byItem AS TFloat) AS OperSumm_Partner_byChangePercent_byItem, CAST (vbOperSumm_Partner_byChangePercent AS TFloat) AS OperSumm_Partner_byChangePercent, CAST (vbPriceWithVAT AS Boolean) AS PriceWithVAT, CAST (vbVATPercent AS TFloat) AS VATPercent, CAST (vbDiscountPercent AS TFloat) AS DiscountPercent, CAST (vbExtraChargesPercent AS TFloat) AS ExtraChargesPercent, CAST (vbUnitId_From AS Integer) AS UnitId_From, CAST (vbPersonalId_From AS Integer) AS PersonalId_From, CAST (vbBranchId_From AS Integer) AS BranchId_From, CAST (vbJuridicalId_To AS Integer) AS JuridicalId_To, CAST (vbIsCorporate AS Boolean) AS IsCorporate, CAST (vbPersonalId_To AS Integer) AS PersonalId_To, CAST (vbInfoMoneyDestinationId_isCorporate AS Integer) AS InfoMoneyDestinationId_isCorporate, CAST (vbInfoMoneyId_isCorporate AS Integer) AS InfoMoneyId_isCorporate, CAST (vbPaidKindId AS Integer) AS PaidKindId, CAST (vbContractId AS Integer) AS ContractId, CAST (vbJuridicalId_basis AS Integer) AS JuridicalId_basis, CAST (vbBusinessId AS Integer) AS BusinessId;
     -- return;
     

     -- ������� - ��������� �������
     CREATE TEMP TABLE _tmpContainer (DescId Integer, ObjectId Integer) ON COMMIT DROP;
     -- ������� - ��������� <������� �/�>
     CREATE TEMP TABLE _tmpObjectCost (DescId Integer, ObjectId Integer) ON COMMIT DROP;
     -- ������� - ��������� <�������� ��� ������>
     CREATE TEMP TABLE _tmpChildReportContainer (AccountKindId Integer, ContainerId Integer, AccountId Integer) ON COMMIT DROP;
     -- ������� - 
     CREATE TEMP TABLE _tmpMIContainer_insert (Id Integer, DescId Integer, MovementId Integer, MovementItemId Integer, ContainerId Integer, ParentId Integer, Amount TFloat, OperDate TDateTime, IsActive Boolean) ON COMMIT DROP;

     -- ������� - �������� �������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     CREATE TEMP TABLE _tmpItemSumm (MovementItemId Integer, ContainerId_ProfitLoss Integer, AccountId_ProfitLoss Integer, ContainerId Integer, AccountId Integer, OperSumm TFloat) ON COMMIT DROP;

     -- ������� - �������������� �������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     CREATE TEMP TABLE _tmpItem (MovementItemId Integer, MovementId Integer, OperDate TDateTime
                               , ContainerId_Goods Integer, GoodsId Integer, GoodsKindId Integer, AssetId Integer, PartionGoods TVarChar, PartionGoodsDate TDateTime
                               , OperCount TFloat, tmpOperSumm_byPriceList TFloat, OperSumm_byPriceList TFloat, tmpOperSumm_Partner TFloat, OperSumm_Partner TFloat, tmpOperSumm_Partner_byChangePercent TFloat, OperSumm_Partner_byChangePercent TFloat
                               , AccountId_Partner Integer, InfoMoneyDestinationId_Partner Integer, InfoMoneyId_Partner Integer
                               , isPartionCount Boolean, isPartionSumm Boolean, isPartionDate Boolean
                               , PartionGoodsId Integer) ON COMMIT DROP;
     -- ��������� ������� - �������������� �������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     INSERT INTO _tmpItem (MovementItemId, MovementId, OperDate
                         , ContainerId_Goods, GoodsId, GoodsKindId, AssetId, PartionGoods, PartionGoodsDate
                         , OperCount, tmpOperSumm_byPriceList, OperSumm_byPriceList, tmpOperSumm_Partner, OperSumm_Partner, tmpOperSumm_Partner_byChangePercent, OperSumm_Partner_byChangePercent
                         , AccountId_Partner, AccountDirectionId_Partner, InfoMoneyDestinationId_Partner, InfoMoneyId_Partner
                         , isPartionCount, isPartionSumm, isPartionDate
                         , PartionGoodsId)
        SELECT
              _tmp.MovementItemId
            , _tmp.MovementId
            , _tmp.OperDate
            , 0 AS ContainerId_Goods
            , _tmp.GoodsId
            , _tmp.GoodsKindId
            , _tmp.AssetId
            , _tmp.PartionGoods
            , _tmp.PartionGoodsDate

            , _tmp.OperCount
              -- ������������� ����� �����-����� �� ����������� !!! ��� ������ !!! - � ����������� �� 2-� ������
            , _tmp.tmpOperSumm_byPriceList
              -- �������� ����� �����-����� �� ����������� !!! ��� ������ !!!
            , CASE WHEN vbPriceWithVAT OR vbVATPercent = 0
                      -- ���� ���� � ��� ��� %���=0, ����� ������ �� ������
                      THEN _tmp.tmpOperSumm_byPriceList
                   WHEN vbVATPercent > 0
                      -- ���� ���� ��� ���, ����� �������� ����� � ���
                      THEN CAST ( (1 + vbVATPercent / 100) * _tmp.tmpOperSumm_byPriceList AS NUMERIC (16, 2))
              END AS OperSumm_byPriceList

              -- ������������� ����� �� ����������� !!! ��� ������ !!! - � ����������� �� 2-� ������
            , _tmp.tmpOperSumm_Partner
              -- �������� ����� �� ����������� !!! ��� ������ !!!
            , CASE WHEN vbPriceWithVAT OR vbVATPercent = 0
                      -- ���� ���� � ��� ��� %���=0, ����� ������ �� ������
                      THEN _tmp.tmpOperSumm_Partner
                   WHEN vbVATPercent > 0
                      -- ���� ���� ��� ���, ����� �������� ����� � ���
                      THEN CAST ( (1 + vbVATPercent / 100) * _tmp.tmpOperSumm_Partner AS NUMERIC (16, 2))
              END AS OperSumm_Partner

              -- ������������� ����� �� ����������� - � ����������� �� 2-� ������
            , _tmp.tmpOperSumm_Partner_byChangePercent
              -- �������� ����� �� �����������
            , CASE WHEN vbPriceWithVAT OR vbVATPercent = 0
                      -- ���� ���� � ��� ��� %���=0, ����� ��������� ��� % ������ ��� % �������
                      THEN CASE WHEN vbDiscountPercent > 0 THEN CAST ( (1 - vbDiscountPercent / 100) * _tmp.tmpOperSumm_Partner AS NUMERIC (16, 2))
                                WHEN vbExtraChargesPercent > 0 THEN CAST ( (1 + vbExtraChargesPercent / 100) * _tmp.tmpOperSumm_Partner AS NUMERIC (16, 2))
                                ELSE _tmp.tmpOperSumm_Partner
                           END
                   WHEN vbVATPercent > 0
                      -- ���� ���� ��� ���, ����� ��������� ��� % ������ ��� % ������� ��� ����� � ��� (���� ������� ����� � ��� ��� � ��� ��)
                      THEN CASE WHEN vbDiscountPercent > 0 THEN CAST ( (1 + vbVATPercent / 100) * (1 - vbDiscountPercent/100) * _tmp.tmpOperSumm_Partner AS NUMERIC (16, 2))
                                WHEN vbExtraChargesPercent > 0 THEN CAST ( (1 + vbVATPercent / 100) * (1 + vbExtraChargesPercent/100) * _tmp.tmpOperSumm_Partner AS NUMERIC (16, 2))
                                ELSE CAST ( (1 + vbVATPercent / 100) * _tmp.tmpOperSumm_Partner AS NUMERIC (16, 2))
                           END
                   WHEN vbVATPercent > 0
                      -- ���� ���� ��� ���, ����� ��������� ��� % ������ ��� % ������� ��� ����� ��� ���, ��������� �� 2-� ������, � ����� ��������� ��� (���� ������� ����� ������������ ��� ��)
                      THEN CASE WHEN vbDiscountPercent > 0 THEN CAST ( (1 + vbVATPercent / 100) * CAST ( (1 - vbDiscountPercent/100) * _tmp.tmpOperSumm_Partner AS NUMERIC (16, 2)) AS NUMERIC (16, 2))
                                WHEN vbExtraChargesPercent > 0 THEN CAST ( (1 + vbVATPercent / 100) * CAST ( (1 + vbExtraChargesPercent/100) * _tmp.tmpOperSumm_Partner AS NUMERIC (16, 2)) AS NUMERIC (16, 2))
                                ELSE CAST ( (1 + vbVATPercent / 100) * (tmpOperSumm_Partner) AS NUMERIC (16, 2))
                           END
              END AS OperSumm_Partner_byChangePercent


              -- ��������� ������ - �����������
            , 0 AS AccountId_Partner
              -- ��������� ������ - �����������
            , _tmp.AccountDirectionId_Partner
              -- �������������� ����������
            , _tmp.InfoMoneyDestinationId_Partner
              -- ������ ����������
            , _tmp.InfoMoneyId_Partner

            , _tmp.isPartionCount
            , _tmp.isPartionSumm 
            , _tmp.isPartionDate
              -- ������ ������, ���������� �����
            , 0 AS PartionGoodsId
        FROM 
             (SELECT
                    MovementItem.Id AS MovementItemId
                  , MovementItem.MovementId
                  , Movement.OperDate

                  , MovementItem.ObjectId AS GoodsId
                  , COALESCE (MILinkObject_GoodsKind.ObjectId, 0) AS GoodsKindId
                  , COALESCE (MILinkObject_Asset.ObjectId, 0) AS AssetId
                  , COALESCE (MIString_PartionGoods.ValueData, '') AS PartionGoods
                  , COALESCE (MIDate_PartionGoods.ValueData, zc_DateEnd()) AS PartionGoodsDate
 
                  , MovementItem.Amount AS OperCount
                    -- ������������� ����� �����-����� �� ����������� - � ����������� �� 2-� ������
                  , COALESCE (CAST (MovementItem.Amount * lfObjectHistory_PriceListItem.ValuePrice AS NUMERIC (16, 2), 0)) AS tmpOperSumm_byPriceList
                    -- ������������� ����� �� ����������� - � ����������� �� 2-� ������
                  , CASE WHEN COALESCE (MIFloat_CountForPrice.ValueData, 0) <> 0 THEN COALESCE (CAST (MIFloat_AmountPartner.ValueData * MIFloat_Price.ValueData / MIFloat_CountForPrice.ValueData AS NUMERIC (16, 2)), 0)
                                                                                 ELSE COALESCE (CAST (MIFloat_AmountPartner.ValueData * MIFloat_Price.ValueData AS NUMERIC (16, 2)), 0)
                    END AS tmpOperSumm_Partner

                    -- ��������� ������ - �����������
                  , lfObject_InfoMoney.InfoMoneyDestinationId IN (zc_Enum_InfoMoneyDestination_10100() -- "�������� �����"; 10100; "������ �����"
                                                                                                  , zc_Enum_InfoMoneyDestination_20700() -- "�������������"; 20700; "������"
                                                                                                  , zc_Enum_InfoMoneyDestination_20900() -- "�������������"; 20900; "����"
                                                                                                  , zc_Enum_InfoMoneyDestination_21000() -- "�������������"; 21000; "�����"
                                                                                                  , zc_Enum_InfoMoneyDestination_21100() -- "�������������"; 21100; "�������"
                                                                                                  , zc_Enum_InfoMoneyDestination_30100() -- "������"; 30100; "���������"
                                                                                                   )
                                                     THEN zc_Enum_AccountDirection_20600() -- "������"; 20600; "���������� (�����������)"
                                                 ELSE zc_Enum_AccountDirection_20500() -- "������"; 20500; "���������� (��)"
                                            END
                              END, 0) AS AccountDirectionId
                    -- �������������� ����������
                  , COALESCE (lfObject_InfoMoney.InfoMoneyDestinationId, 0) AS InfoMoneyDestinationId
                    -- ������ ����������
                  , COALESCE (lfObject_InfoMoney.InfoMoneyId, 0) AS InfoMoneyId

                  , COALESCE (ObjectBoolean_PartionCount.ValueData, FALSE)      AS isPartionCount
                  , COALESCE (ObjectBoolean_PartionSumm.ValueData, FALSE)       AS isPartionSumm
                  , COALESCE (ObjectBoolean_PartionDate_From.ValueData, FALSE)  AS isPartionDate

              FROM Movement
                   JOIN MovementItem ON MovementItem.MovementId = Movement.Id AND MovementItem.DescId = zc_MI_Master() AND MovementItem.isErased = FALSE

                   LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                                    ON MILinkObject_GoodsKind.MovementItemId = MovementItem.Id
                                                   AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()
                   LEFT JOIN MovementItemLinkObject AS MILinkObject_Asset
                                                    ON MILinkObject_Asset.MovementItemId = MovementItem.Id
                                                   AND MILinkObject_Asset.DescId = zc_MILinkObject_Asset()

                   LEFT JOIN MovementItemFloat AS MIFloat_Summ
                                               ON MIFloat_Summ.MovementItemId = MovementItem.Id
                                              AND MIFloat_Summ.DescId = zc_MIFloat_Summ()

                   LEFT JOIN MovementItemString AS MIString_PartionGoods
                                                ON MIString_PartionGoods.MovementItemId = MovementItem.Id
                                               AND MIString_PartionGoods.DescId = zc_MIString_PartionGoods()
                   LEFT JOIN MovementItemDate AS MIDate_PartionGoods
                                              ON MIDate_PartionGoods.MovementItemId = MovementItem.Id
                                             AND MIDate_PartionGoods.DescId = zc_MIDate_PartionGoods()

                   LEFT JOIN MovementLinkObject AS MovementLinkObject_From
                                                ON MovementLinkObject_From.MovementId = MovementItem.MovementId
                                               AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()
                   LEFT JOIN Object AS Object_From ON Object_From.Id = MovementLinkObject_From.ObjectId


                   LEFT JOIN ObjectLink AS ObjectLink_UnitFrom_AccountDirection
                                        ON ObjectLink_UnitFrom_AccountDirection.ObjectId = MovementLinkObject_From.ObjectId
                                       AND ObjectLink_UnitFrom_AccountDirection.DescId = zc_ObjectLink_Unit_AccountDirection()
                                       AND Object_From.DescId = zc_Object_Unit()
                   LEFT JOIN ObjectLink AS ObjectLink_UnitFrom_Branch
                                        ON ObjectLink_UnitFrom_Branch.ObjectId = MovementLinkObject_From.ObjectId
                                       AND ObjectLink_UnitFrom_Branch.DescId = zc_ObjectLink_Unit_Branch()
                   LEFT JOIN ObjectLink AS ObjectLink_UnitFrom_Juridical
                                        ON ObjectLink_UnitFrom_Juridical.ObjectId = MovementLinkObject_From.ObjectId
                                       AND ObjectLink_UnitFrom_Juridical.DescId = zc_ObjectLink_Unit_Juridical()
                                       AND Object_From.DescId = zc_Object_Unit()
                   LEFT JOIN ObjectLink AS ObjectLink_UnitFrom_Business
                                        ON ObjectLink_UnitFrom_Business.ObjectId = MovementLinkObject_From.ObjectId
                                       AND ObjectLink_UnitFrom_Business.DescId = zc_ObjectLink_Unit_Business()
                                       AND Object_From.DescId = zc_Object_Unit()

                   LEFT JOIN ObjectLink AS ObjectLink_PersonalFrom_Unit
                                        ON ObjectLink_PersonalFrom_Unit.ObjectId = MovementLinkObject_From.ObjectId
                                       AND ObjectLink_PersonalFrom_Unit.DescId = zc_ObjectLink_Personal_Unit()
                                       AND Object_From.DescId = zc_Object_Personal()
                   LEFT JOIN ObjectLink AS ObjectLink_UnitPersonalFrom_Branch
                                        ON ObjectLink_UnitPersonalFrom_Branch.ObjectId = ObjectLink_PersonalFrom_Unit.ChildObjectId
                                       AND ObjectLink_UnitPersonalFrom_Branch.DescId = zc_ObjectLink_Unit_Branch()
                                       AND Object_From.DescId = zc_Object_Personal()
                   LEFT JOIN ObjectLink AS ObjectLink_UnitPersonalFrom_Juridical
                                        ON ObjectLink_UnitPersonalFrom_Juridical.ObjectId = ObjectLink_PersonalFrom_Unit.ChildObjectId
                                       AND ObjectLink_UnitPersonalFrom_Juridical.DescId = zc_ObjectLink_Unit_Juridical()
                                       AND Object_From.DescId = zc_Object_Personal()
                   LEFT JOIN ObjectLink AS ObjectLink_UnitPersonalFrom_Business
                                        ON ObjectLink_UnitPersonalFrom_Business.ObjectId = ObjectLink_PersonalFrom_Unit.ChildObjectId
                                       AND ObjectLink_UnitPersonalFrom_Business.DescId = zc_ObjectLink_Unit_Business()
                                       AND Object_From.DescId = zc_Object_Personal()


                   LEFT JOIN ObjectBoolean AS ObjectBoolean_PartionDate_From
                                           ON ObjectBoolean_PartionDate_From.ObjectId = MovementLinkObject_From.ObjectId
                                          AND ObjectBoolean_PartionDate_From.DescId = zc_ObjectBoolean_Unit_PartionDate()
                   LEFT JOIN ObjectBoolean AS ObjectBoolean_PartionCount
                                           ON ObjectBoolean_PartionCount.ObjectId = MovementItem.ObjectId
                                          AND ObjectBoolean_PartionCount.DescId = zc_ObjectBoolean_Goods_PartionCount()
                   LEFT JOIN ObjectBoolean AS ObjectBoolean_PartionSumm
                                           ON ObjectBoolean_PartionSumm.ObjectId = MovementItem.ObjectId
                                          AND ObjectBoolean_PartionSumm.DescId = zc_ObjectBoolean_Goods_PartionSumm()

                   LEFT JOIN ObjectLink AS ObjectLink_Goods_InfoMoney
                                        ON ObjectLink_Goods_InfoMoney.ObjectId = MovementItem.ObjectId
                                       AND ObjectLink_Goods_InfoMoney.DescId = zc_ObjectLink_Goods_InfoMoney()
                   LEFT JOIN lfSelect_Object_InfoMoney() AS lfObject_InfoMoney ON lfObject_InfoMoney.InfoMoneyId = ObjectLink_Goods_InfoMoney.ChildObjectId

                   LEFT JOIN lfSelect_ObjectHistory_PriceListItem (inPriceListId:= zc_PriceList_ProductionSeparate(), inOperDate:= vbOperDate)
                          AS lfObjectHistory_PriceListItem ON lfObjectHistory_PriceListItem.GoodsId = MovementItem.ObjectId

              WHERE Movement.Id = inMovementId
                AND Movement.DescId = zc_Movement_Sale()
                AND Movement.StatusId = zc_Enum_Status_UnComplete()
             ) AS _tmp;


     -- ����������� ������ ������, ���� ���� ...
     UPDATE _tmpItem SET PartionGoodsId = CASE WHEN _tmpItem.OperDate >= zc_DateStart_PartionGoods()
                                                AND _tmpItem.AccountDirectionId = zc_Enum_AccountDirection_20200() -- "������"; 20200; "�� �������"
                                                AND (_tmpItem.isPartionCount OR _tmpItem.isPartionSumm)
                                                   THEN lpInsertFind_Object_PartionGoods (_tmpItem.PartionGoods)
                                               WHEN _tmpItem.isPartionDate
                                                AND _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30100() -- "������"; 30100; "���������"
                                                   THEN lpInsertFind_Object_PartionGoods (_tmpItem.PartionGoodsDate)
                                               ELSE lpInsertFind_Object_PartionGoods ('')
                                          END
     WHERE _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10100() -- "�������� �����"; 10100; "������ �����"
        OR _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30100() -- "������"; 30100; "���������"
     ;



     -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
     -- !!! �� � ������ - �������� !!!
     -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


     -- ������������ ContainerId_Goods ��� ��������������� �����
     UPDATE _tmpItem SET ContainerId_Goods = CASE WHEN _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10100() -- ������ ����� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10100()
                                                          -- 0)����� 1)������������� 2)!������ ������!
                                                          -- 0)����� 1)��������� (�� ��� ����.) 2)!������ ������!
                                                     THEN lpInsertFind_Container (inContainerDescId:= zc_Container_Count()
                                                                                , inParentId:= NULL
                                                                                , inObjectId:= _tmpItem.GoodsId
                                                                                , inJuridicalId_basis:= NULL
                                                                                , inBusinessId       := NULL
                                                                                , inObjectCostDescId := NULL
                                                                                , inObjectCostId     := NULL
                                                                                , inDescId_1   := CASE WHEN _tmpItem.PersonalId <> 0 THEN zc_ContainerLinkObject_Personal() ELSE zc_ContainerLinkObject_Unit() END
                                                                                , inObjectId_1 := CASE WHEN _tmpItem.PersonalId <> 0 THEN _tmpItem.PersonalId ELSE _tmpItem.UnitId END
                                                                                , inDescId_2   := zc_ContainerLinkObject_PartionGoods()
                                                                                , inObjectId_2 := CASE WHEN _tmpItem.isPartionCount THEN _tmpItem.PartionGoodsId ELSE NULL END
                                                                                 )
                                                  WHEN _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20100() -- �������� � ������� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20100()
                                                          -- 0)����� 1)������������� 2)�������� ��������(��� �������� ��������� ���)
                                                          -- 0)����� 1)��������� (�� ��� ����.) 2)�������� ��������(��� �������� ��������� ���)
                                                     THEN lpInsertFind_Container (inContainerDescId:= zc_Container_Count()
                                                                                , inParentId:= NULL
                                                                                , inObjectId:= _tmpItem.GoodsId
                                                                                , inJuridicalId_basis:= NULL
                                                                                , inBusinessId       := NULL
                                                                                , inObjectCostDescId := NULL
                                                                                , inObjectCostId     := NULL
                                                                                , inDescId_1   := CASE WHEN _tmpItem.PersonalId <> 0 THEN zc_ContainerLinkObject_Personal() ELSE zc_ContainerLinkObject_Unit() END
                                                                                , inObjectId_1 := CASE WHEN _tmpItem.PersonalId <> 0 THEN _tmpItem.PersonalId ELSE _tmpItem.UnitId END
                                                                                , inDescId_2   := zc_ContainerLinkObject_AssetTo()
                                                                                , inObjectId_2 := _tmpItem.AssetId
                                                                                 )
                                                  WHEN _tmpItem.InfoMoneyDestinationId IN (zc_Enum_InfoMoneyDestination_20700()  -- ������    -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20700()
                                                                                         , zc_Enum_InfoMoneyDestination_20900()  -- ����      -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20900()
                                                                                         , zc_Enum_InfoMoneyDestination_30100()) -- ��������� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30100()
                                                          -- 0)����� 1)������������� 2)��� ������ 3)!!!������ ������!!!
                                                          -- 0)����� 1)��������� (�� ��� ����.) 2)��� ������ 3)!!!������ ������!!!
                                                     THEN lpInsertFind_Container (inContainerDescId:= zc_Container_Count()
                                                                                , inParentId:= NULL
                                                                                , inObjectId:= _tmpItem.GoodsId
                                                                                , inJuridicalId_basis:= NULL
                                                                                , inBusinessId       := NULL
                                                                                , inObjectCostDescId := NULL
                                                                                , inObjectCostId     := NULL
                                                                                , inDescId_1   := CASE WHEN _tmpItem.PersonalId <> 0 THEN zc_ContainerLinkObject_Personal() ELSE zc_ContainerLinkObject_Unit() END
                                                                                , inObjectId_1 := CASE WHEN _tmpItem.PersonalId <> 0 THEN _tmpItem.PersonalId ELSE _tmpItem.UnitId END
                                                                                , inDescId_2   := zc_ContainerLinkObject_GoodsKind()
                                                                                , inObjectId_2 := _tmpItem.GoodsKindId
                                                                                , inDescId_3   := CASE WHEN _tmpItem.PartionGoodsId <> 0 THEN zc_ContainerLinkObject_PartionGoods() ELSE NULL END
                                                                                , inObjectId_3 := CASE WHEN _tmpItem.PartionGoodsId <> 0 THEN _tmpItem.PartionGoodsId ELSE NULL END
                                                                                 )
                                                          -- 0)����� 1)�������������
                                                     ELSE lpInsertFind_Container (inContainerDescId:= zc_Container_Count()
                                                                                , inParentId:= NULL
                                                                                , inObjectId:= _tmpItem.GoodsId
                                                                                , inJuridicalId_basis:= NULL
                                                                                , inBusinessId       := NULL
                                                                                , inObjectCostDescId := NULL
                                                                                , inObjectCostId     := NULL
                                                                                , inDescId_1   := CASE WHEN _tmpItem.PersonalId <> 0 THEN zc_ContainerLinkObject_Personal() ELSE zc_ContainerLinkObject_Unit() END
                                                                                , inObjectId_1 := CASE WHEN _tmpItem.PersonalId <> 0 THEN _tmpItem.PersonalId ELSE _tmpItem.UnitId END
                                                                                 )
                                             END;


     -- ��������� ������� - �������������� ��������� ������� �� ����� vbOperDate, � ������� ����� MovementItemId (��� �� ��������� ������� ������� � �����������), �.�. ���� � ��� �� ����� ����� ���� ������ ��������� ��� �� ������������� � MAX (_tmpItem.MovementItemId)
     INSERT INTO _tmpRemainsCount (MovementItemId, ContainerId_Goods, GoodsId, OperCount)
        SELECT COALESCE (_tmpItem_find.MovementItemId, 0) AS MovementItemId
             , _tmpContainer.ContainerId_Goods
             , _tmpContainer.GoodsId
             , _tmpContainer.OperCount
        FROM (SELECT _tmpContainerLinkObject_From.ContainerId AS ContainerId_Goods
                   , Container.ObjectId AS GoodsId
                   , Container.Amount - COALESCE (SUM (MIContainer.Amount), 0) AS OperCount
              FROM (SELECT ContainerLinkObject.ContainerId FROM ContainerLinkObject WHERE ContainerLinkObject.ObjectId =  vbUnitId AND ContainerLinkObject.DescId = zc_ContainerLinkObject_Unit() AND vbUnitId <> 0
                   UNION
                    SELECT ContainerLinkObject.ContainerId FROM ContainerLinkObject WHERE ContainerLinkObject.ObjectId =  vbPersonalId AND ContainerLinkObject.DescId = zc_ContainerLinkObject_Personal() AND vbPersonalId <> 0
                   ) AS _tmpContainerLinkObject_From
                   -- !!!����������� JOIN, ��� � "������������" ������ �������� ��������!!!
                   JOIN Container ON Container.Id = _tmpContainerLinkObject_From.ContainerId
                                 AND Container.DescId = zc_Container_Count()
                   LEFT JOIN MovementItemContainer AS MIContainer
                                                   ON MIContainer.Containerid = Container.Id
                                                  AND MIContainer.OperDate > vbOperDate
              GROUP BY _tmpContainerLinkObject_From.ContainerId
                     , Container.ObjectId
                     , Container.Amount
              HAVING (Container.Amount - COALESCE (SUM (MIContainer.Amount), 0) <> 0)
             ) AS _tmpContainer
             LEFT JOIN (SELECT MAX (_tmpItem.MovementItemId) AS MovementItemId, _tmpItem.ContainerId_Goods FROM _tmpItem GROUP BY _tmpItem.ContainerId_Goods
                       ) AS _tmpItem_find ON _tmpItem_find.ContainerId_Goods = _tmpContainer.ContainerId_Goods
     ;

     -- ��������� ������� - �������� ��������� ������� �� ����� vbOperDate (ContainerId_Goods - ������ � ������� �������� ��������)
     INSERT INTO _tmpRemainsSumm (ContainerId_Goods, ContainerId, AccountId, GoodsId, OperSumm)
        SELECT _tmpContainer.ContainerId_Goods
             , _tmpContainer.ContainerId
             , _tmpContainer.AccountId
             , Container_Count.ObjectId
             , _tmpContainer.OperSumm
        FROM (SELECT _tmpContainerLinkObject_From.ContainerId
                   , Container.ObjectId AS AccountId
                   , Container.ParentId AS ContainerId_Goods
                   , Container.Amount - COALESCE (SUM (MIContainer.Amount), 0) AS OperSumm
              FROM (SELECT ContainerLinkObject.ContainerId FROM ContainerLinkObject WHERE ContainerLinkObject.ObjectId =  vbUnitId AND ContainerLinkObject.DescId = zc_ContainerLinkObject_Unit() AND vbUnitId <> 0
                   UNION
                    SELECT ContainerLinkObject.ContainerId FROM ContainerLinkObject WHERE ContainerLinkObject.ObjectId =  vbPersonalId AND ContainerLinkObject.DescId = zc_ContainerLinkObject_Personal() AND vbPersonalId <> 0
                   ) AS _tmpContainerLinkObject_From
                   -- !!!����������� JOIN and ParentId, ��� � "������������" ������ �������� ��������!!!
                   JOIN Container ON Container.Id = _tmpContainerLinkObject_From.ContainerId
                                 AND Container.DescId = zc_Container_Summ()
                                 AND Container.ParentId IS NOT NULL
                   LEFT JOIN MovementItemContainer AS MIContainer
                                                   ON MIContainer.Containerid = Container.Id
                                                  AND MIContainer.OperDate > vbOperDate
              GROUP BY _tmpContainerLinkObject_From.ContainerId
                     , Container.ObjectId
                     , Container.ParentId
                     , Container.Amount
              HAVING (Container.Amount - COALESCE (SUM (MIContainer.Amount), 0) <> 0)
             ) AS _tmpContainer
             LEFT JOIN Container AS Container_Count ON Container_Count.Id = _tmpContainer.ContainerId_Goods
     ;

     -- ��������� �� �������� ��������� ������� � �������������� ��������� ������� �� ������ ������� ���, � ������� ����� MovementItemId (��� �� ��������� ������� ������� � �����������)
     INSERT INTO _tmpRemainsCount (MovementItemId, ContainerId_Goods, GoodsId, OperCount)
        SELECT COALESCE (_tmpItem_find.MovementItemId, 0) AS MovementItemId
             , _tmpRemainsSumm.ContainerId_Goods
             , _tmpRemainsSumm.GoodsId
             , 0 AS OperCount
        FROM _tmpRemainsSumm
             LEFT JOIN _tmpRemainsCount ON _tmpRemainsCount.ContainerId_Goods = _tmpRemainsSumm.ContainerId_Goods
             LEFT JOIN (SELECT MAX (_tmpItem.MovementItemId) AS MovementItemId, _tmpItem.ContainerId_Goods FROM _tmpItem GROUP BY _tmpItem.ContainerId_Goods
                       ) AS _tmpItem_find ON _tmpItem_find.ContainerId_Goods = _tmpRemainsSumm.ContainerId_Goods
        WHERE _tmpRemainsCount.ContainerId_Goods IS NULL
        GROUP BY _tmpItem_find.MovementItemId
               , _tmpRemainsSumm.ContainerId_Goods
               , _tmpRemainsSumm.GoodsId;

     -- ��������� ����� �������� ��������� (MovementItem) ��� ��� �������, �� ������� ���� ��������� ������� �� ��� �� ������� � �������� (ContainerId_Goods=0, ������ �� ��������� ������� = 0 � ��� �� ���������)
     UPDATE _tmpRemainsCount SET MovementItemId = lpInsertUpdate_MovementItem (ioId:= 0
                                                                             , inDescId:= zc_MI_Master()
                                                                             , inObjectId:= _tmpRemainsCount.GoodsId
                                                                             , inMovementId:= inMovementId
                                                                             , inAmount:= 0
                                                                             , inParentId:= NULL
                                                                              )
     WHERE _tmpRemainsCount.MovementItemId = 0;

     -- ��������� � ������ ��� �������� �� ������, ������� ������ ��� ���� ��������� � �������� ����� (MovementItem), ������ !!!���!!! �������� ��� �������� �������� (�.�. ��� �� �����)
     INSERT INTO _tmpItem (MovementItemId, MovementId, OperDate, UnitId, PersonalId, BranchId
                         , ContainerId_Goods, GoodsId, GoodsKindId, AssetId, PartionGoods, PartionGoodsDate
                         , OperCount, OperSumm
                         , AccountDirectionId, InfoMoneyDestinationId, InfoMoneyId
                         , JuridicalId_basis, BusinessId
                         , isPartionCount, isPartionSumm, isPartionDate
                         , PartionGoodsId)
        SELECT _tmpRemainsCount.MovementItemId
             , inMovementId
             , vbOperDate
             , vbUnitId
             , vbPersonalId
             , 0 AS BranchId
             , _tmpRemainsCount.ContainerId_Goods
             , _tmpRemainsCount.GoodsId
             , ContainerLinkObject_GoodsKind.ObjectId AS GoodsKindId
             , ContainerLinkObject_AssetTo.ObjectId AS AssetId
             , '' AS PartionGoods
             , zc_DateEnd() AS PartionGoodsDate
             , 0 AS OperCount
             , 0 AS OperSumm
             , 0 AS AccountDirectionId
             , 0 AS InfoMoneyDestinationId
             , 0 AS InfoMoneyId
             , 0 AS JuridicalId_basis
             , 0 AS BusinessId
             , FALSE AS isPartionCount -- ��� ��������� ����� ��� �� �����, �.�. ��� ���� ContainerId_Goods
             , FALSE AS isPartionSumm  -- ��� ��������� ����� ��� �� �����, �.�. ��� ���� ContainerId_Goods
             , FALSE AS isPartionDate  -- ��� ��������� ����� ��� �� �����, �.�. ��� ���� ContainerId_Goods
             , ContainerLinkObject_PartionGoods.ObjectId AS PartionGoodsId
        FROM _tmpRemainsCount
             LEFT JOIN _tmpItem ON _tmpItem.ContainerId_Goods = _tmpRemainsCount.ContainerId_Goods
             LEFT JOIN ContainerLinkObject AS ContainerLinkObject_GoodsKind
                                           ON ContainerLinkObject_GoodsKind.ContainerId = _tmpRemainsCount.ContainerId_Goods
                                          AND ContainerLinkObject_GoodsKind.DescId = zc_ContainerLinkObject_GoodsKind()
             LEFT JOIN ContainerLinkObject AS ContainerLinkObject_PartionGoods
                                           ON ContainerLinkObject_PartionGoods.ContainerId = _tmpRemainsCount.ContainerId_Goods
                                          AND ContainerLinkObject_PartionGoods.DescId = zc_ContainerLinkObject_PartionGoods()
             LEFT JOIN ContainerLinkObject AS ContainerLinkObject_AssetTo
                                           ON ContainerLinkObject_AssetTo.ContainerId = _tmpRemainsCount.ContainerId_Goods
                                          AND ContainerLinkObject_AssetTo.DescId = zc_ContainerLinkObject_AssetTo()
        WHERE _tmpItem.ContainerId_Goods IS NULL;


     -- ����������� �������� ��� ��������������� ����� !!!������!!! ���� ���� ������� �� �������
     INSERT INTO _tmpMIContainer_insert (Id, DescId, MovementId, MovementItemId, ContainerId, ParentId, Amount, OperDate, IsActive)
       SELECT 0, zc_MIContainer_Count() AS DescId, _tmpItem.MovementId, _tmpItem.MovementItemId, _tmpItem.ContainerId_Goods, 0 AS ParentId, _tmpItem.OperCount - COALESCE (_tmpRemainsCount.OperCount, 0), _tmpItem.OperDate, TRUE
       FROM _tmpItem
            LEFT JOIN _tmpRemainsCount ON _tmpRemainsCount.MovementItemId = _tmpItem.MovementItemId
       WHERE (_tmpItem.OperCount - COALESCE (_tmpRemainsCount.OperCount, 0)) <> 0;
     /*PERFORM lpInsertUpdate_MovementItemContainer (ioId:= 0
                                                 , inDescId:= zc_MIContainer_Count()
                                                 , inMovementId:= _tmpItem.MovementId
                                                 , inMovementItemId:= _tmpItem.MovementItemId
                                                 , inParentId:= NULL
                                                 , inContainerId:= _tmpItem.ContainerId_Goods -- ��� ���������� ����
                                                 , inAmount:= _tmpItem.OperCount - COALESCE (_tmpRemainsCount.OperCount, 0)
                                                 , inOperDate:= _tmpItem.OperDate
                                                 , inIsActive:= TRUE
                                                  )
     FROM _tmpItem
          LEFT JOIN _tmpRemainsCount ON _tmpRemainsCount.MovementItemId = _tmpItem.MovementItemId
     WHERE (_tmpItem.OperCount - COALESCE (_tmpRemainsCount.OperCount, 0)) <> 0
     ;*/


     -- ��� �����-1
     -- RETURN QUERY SELECT CAST (vbProfitLossGroupId AS Integer) AS ProfitLossGroupId, CAST (vbProfitLossDirectionId AS Integer) AS ProfitLossDirectionId, _tmpItem.MovementItemId, _tmpItem.MovementId, _tmpItem.OperDate, _tmpItem.UnitId, _tmpItem.PersonalId, _tmpItem.BranchId, _tmpItem.ContainerId_Goods, _tmpItem.GoodsId, _tmpItem.GoodsKindId, _tmpItem.AssetId, _tmpItem.PartionGoods, _tmpItem.PartionGoodsDate, _tmpItem.OperCount, _tmpItem.OperSumm, _tmpItem.AccountDirectionId, _tmpItem.InfoMoneyDestinationId, _tmpItem.InfoMoneyId, _tmpItem.JuridicalId_basis, _tmpItem.BusinessId, _tmpItem.isPartionCount, _tmpItem.isPartionSumm, _tmpItem.isPartionDate, _tmpItem.PartionGoodsId FROM _tmpItem;
     -- return;


     -- ��������� ������� - �������� �������� ���������, !!!���!!! ������� ��� ������������ �������� � ��������� (���� ContainerId=0 ����� ������� �� �� _tmpItem)
     INSERT INTO _tmpItemSumm (MovementItemId, ContainerId_ProfitLoss, ContainerId, AccountId, OperSumm)
        SELECT _tmp.MovementItemId
             , 0 AS ContainerId_ProfitLoss
             , _tmp.ContainerId
             , _tmp.AccountId
             , SUM (_tmp.OperSumm)
        FROM  -- ��� ��������� �������
             (SELECT _tmpItem.MovementItemId
                   , COALESCE (Container_Summ.Id, 0) AS ContainerId
                   , COALESCE (Container_Summ.ObjectId, 0) AS AccountId
                   , CASE WHEN Container_Summ.ParentId IS NULL THEN _tmpItem.OperSumm ELSE _tmpItem.OperCount * COALESCE (HistoryCost.Price, 0) END AS OperSumm -- ���� ������, ������ ������� �� ����� ������ ���� ��������� ���� ���, � ����� ������������� �� HistoryCost
              FROM _tmpItem
                   LEFT JOIN Container AS Container_Summ ON Container_Summ.ParentId = _tmpItem.ContainerId_Goods
                                                        AND Container_Summ.DescId = zc_Container_Summ()
                                                        AND 1=0
                   LEFT JOIN ContainerObjectCost AS ContainerObjectCost_Basis
                                                 ON ContainerObjectCost_Basis.ContainerId = Container_Summ.Id
                                                AND ContainerObjectCost_Basis.ObjectCostDescId = zc_ObjectCost_Basis()
                   LEFT JOIN HistoryCost ON HistoryCost.ObjectCostId = ContainerObjectCost_Basis.ObjectCostId
                                        AND _tmpItem.OperDate BETWEEN HistoryCost.StartDate AND HistoryCost.EndDate
            UNION ALL
              -- ��� ��������� ������� (�� ���� �������)
              SELECT _tmpRemainsCount.MovementItemId
                   , _tmpRemainsSumm.ContainerId
                   , _tmpRemainsSumm.AccountId
                   , -1 * _tmpRemainsSumm.OperSumm AS OperSumm
              FROM _tmpRemainsSumm
                   LEFT JOIN _tmpRemainsCount ON _tmpRemainsCount.ContainerId_Goods = _tmpRemainsSumm.ContainerId_Goods
             ) AS _tmp
        WHERE  zc_isHistoryCost() = TRUE
        GROUP BY _tmp.MovementItemId
               , _tmp.ContainerId
               , _tmp.AccountId;

     -- ��� �����-2
     -- RETURN QUERY SELECT CAST (vbProfitLossGroupId AS Integer) AS ProfitLossGroupId, CAST (vbProfitLossDirectionId AS Integer) AS ProfitLossDirectionId, _tmpItemSumm.MovementItemId, _tmpItemSumm.ContainerId_ProfitLoss, _tmpItemSumm.ContainerId, _tmpItemSumm.OperSumm, _tmpItem.InfoMoneyDestinationId FROM _tmpItemSumm LEFT JOIN _tmpItem ON _tmpItem.MovementItemId = _tmpItemSumm.MovementItemId;
     -- return;

     -- ������������ ���� ��� �������� �� ��������� �����
     UPDATE _tmpItemSumm SET AccountId = _tmpItem_byAccount.AccountId
     FROM _tmpItem
          JOIN (SELECT lpInsertFind_Object_Account (inAccountGroupId         := zc_Enum_AccountGroup_20000() -- ������ -- select * from gpSelect_Object_AccountGroup ('2') where Id = zc_Enum_AccountGroup_20000()
                                                  , inAccountDirectionId     := _tmpItem_group.AccountDirectionId
                                                  , inInfoMoneyDestinationId := _tmpItem_group.InfoMoneyDestinationId_calc
                                                  , inInfoMoneyId            := NULL
                                                  , inUserId                 := vbUserId
                                                   ) AS AccountId
                     , _tmpItem_group.AccountDirectionId
                     , _tmpItem_group.InfoMoneyDestinationId
                FROM (SELECT _tmpItem.AccountDirectionId
                           , _tmpItem.InfoMoneyDestinationId
                           , CASE WHEN _tmpItem.GoodsKindId = zc_GoodsKind_WorkProgress() THEN zc_InfoMoneyDestination_WorkProgress() ELSE _tmpItem.InfoMoneyDestinationId END AS InfoMoneyDestinationId_calc
                      FROM _tmpItem
                           JOIN _tmpItemSumm ON _tmpItemSumm.MovementItemId = _tmpItem.MovementItemId
                                            AND _tmpItemSumm.OperSumm <> 0 AND _tmpItemSumm.ContainerId = 0
                      GROUP BY _tmpItem.AccountDirectionId
                             , _tmpItem.InfoMoneyDestinationId
                             , CASE WHEN _tmpItem.GoodsKindId = zc_GoodsKind_WorkProgress() THEN zc_InfoMoneyDestination_WorkProgress() ELSE _tmpItem.InfoMoneyDestinationId END
                     ) AS _tmpItem_group
               ) AS _tmpItem_byAccount ON _tmpItem_byAccount.AccountDirectionId = _tmpItem.AccountDirectionId
                                      AND _tmpItem.InfoMoneyDestinationId = _tmpItem_byAccount.InfoMoneyDestinationId
     WHERE _tmpItemSumm.MovementItemId = _tmpItem.MovementItemId
       AND _tmpItemSumm.OperSumm <> 0
       AND _tmpItemSumm.ContainerId = 0;

     -- ������� ���������� ��� ��������� ����� + ��������� <������� �/�>, ������ !!!������!!! ����� ContainerId=0 � !!!����!!! ������� �� �������
     UPDATE _tmpItemSumm SET ContainerId                         = CASE WHEN _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10100() -- ������ ����� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10100()
                                                                                -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)������������� 2)����� 3)!������ ������! 4)������ ���������� 5)������ ����������(����������� �/�)
                                                                                -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)��������� (�� ��� ����.) 2)����� 3)!������ ������! 4)������ ���������� 5)������ ����������(����������� �/�)
                                                                           THEN lpInsertFind_Container (inContainerDescId:= zc_Container_Summ()
                                                                                                      , inParentId:= _tmpItem.ContainerId_Goods
                                                                                                      , inObjectId:= _tmpItemSumm.AccountId
                                                                                                      , inJuridicalId_basis:= _tmpItem.JuridicalId_basis
                                                                                                      , inBusinessId       := _tmpItem.BusinessId
                                                                                                      , inObjectCostDescId := zc_ObjectCost_Basis()
                                                                                                                              -- <������� �/�>: 1.)������� �� ���� 2.)������ 3)������ 4)!�������������! 5)����� 6)!������ ������! 7)������ ���������� 8)������ ����������(����������� �/�)
                                                                                                                              -- <������� �/�>: 1.)������� �� ���� 2.)������ 3)������ 4)��������� (�� ��� ����.) 5)����� 6)!������ ������! 7)������ ���������� 8)������ ����������(����������� �/�)
                                                                                                      , inObjectCostId     := lpInsertFind_ObjectCost (inObjectCostDescId:= zc_ObjectCost_Basis()
                                                                                                                                                     , inDescId_1   := zc_ObjectCostLink_JuridicalBasis()
                                                                                                                                                     , inObjectId_1 := _tmpItem.JuridicalId_basis
                                                                                                                                                     , inDescId_2   := zc_ObjectCostLink_Business()
                                                                                                                                                     , inObjectId_2 := _tmpItem.BusinessId
                                                                                                                                                     , inDescId_3   := zc_ObjectCostLink_Branch()
                                                                                                                                                     , inObjectId_3 := _tmpItem.BranchId
                                                                                                                                                     , inDescId_4   := CASE WHEN _tmpItem.PersonalId <> 0 THEN zc_ObjectCostLink_Personal() ELSE zc_ObjectCostLink_Unit() END
                                                                                                                                                     , inObjectId_4 := CASE WHEN _tmpItem.PersonalId <> 0 AND _tmpItem.OperDate >= zc_DateStart_ObjectCostOnUnit() THEN _tmpItem.PersonalId WHEN _tmpItem.OperDate >= zc_DateStart_ObjectCostOnUnit() THEN _tmpItem.UnitId ELSE NULL END
                                                                                                                                                     , inDescId_5   := zc_ObjectCostLink_Goods()
                                                                                                                                                     , inObjectId_5 := _tmpItem.GoodsId
                                                                                                                                                     , inDescId_6   := zc_ObjectCostLink_PartionGoods()
                                                                                                                                                     , inObjectId_6 := CASE WHEN _tmpItem.isPartionSumm THEN _tmpItem.PartionGoodsId ELSE NULL END
                                                                                                                                                     , inDescId_7   := zc_ObjectCostLink_InfoMoney()
                                                                                                                                                     , inObjectId_7 := _tmpItem.InfoMoneyId
                                                                                                                                                     , inDescId_8   := zc_ObjectCostLink_InfoMoneyDetail()
                                                                                                                                                     , inObjectId_8 := CASE WHEN zc_isHistoryCost_byInfoMoneyDetail() THEN _tmpItem.InfoMoneyId ELSE 0 END -- !!!��� ���������� ������� �� �� ����� InfoMoneyId_Detail!!!
                                                                                                                                                      )
                                                                                                      , inDescId_1   := CASE WHEN _tmpItem.PersonalId <> 0 THEN zc_ContainerLinkObject_Personal() ELSE zc_ContainerLinkObject_Unit() END
                                                                                                      , inObjectId_1 := CASE WHEN _tmpItem.PersonalId <> 0 THEN _tmpItem.PersonalId ELSE _tmpItem.UnitId END
                                                                                                      , inDescId_2   := zc_ContainerLinkObject_Goods()
                                                                                                      , inObjectId_2 := _tmpItem.GoodsId
                                                                                                      , inDescId_3   := zc_ContainerLinkObject_PartionGoods()
                                                                                                      , inObjectId_3 := CASE WHEN _tmpItem.isPartionSumm THEN _tmpItem.PartionGoodsId ELSE NULL END
                                                                                                      , inDescId_4   := zc_ContainerLinkObject_InfoMoney()
                                                                                                      , inObjectId_4 := _tmpItem.InfoMoneyId
                                                                                                      , inDescId_5   := zc_ContainerLinkObject_InfoMoneyDetail()
                                                                                                      , inObjectId_5 := CASE WHEN zc_isHistoryCost_byInfoMoneyDetail() THEN _tmpItem.InfoMoneyId ELSE 0 END -- !!!��� ���������� ������� �� �� ����� InfoMoneyId_Detail!!!
                                                                                                       )
                                                                        WHEN _tmpItem.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20100() -- �������� � ������� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20100()
                                                                                -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)������������� 2)����� 3)�������� ��������(��� �������� ��������� ���) 4)������ ���������� 5)������ ����������(����������� �/�)
                                                                                -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)��������� (�� ��� ����.) 2)����� 3)�������� ��������(��� �������� ��������� ���) 4)������ ���������� 5)������ ����������(����������� �/�)
                                                                           THEN lpInsertFind_Container (inContainerDescId:= zc_Container_Summ()
                                                                                                      , inParentId:= _tmpItem.ContainerId_Goods
                                                                                                      , inObjectId:= _tmpItemSumm.AccountId
                                                                                                      , inJuridicalId_basis:= _tmpItem.JuridicalId_basis
                                                                                                      , inBusinessId       := _tmpItem.BusinessId
                                                                                                      , inObjectCostDescId := zc_ObjectCost_Basis()
                                                                                                                              -- <������� �/�>: 1.)������� �� ���� 2.)������ 3)������ 4)!�������������! 5)����� 6)�������� ��������(��� �������� ��������� ���) 7)������ ���������� 8)������ ����������(����������� �/�)
                                                                                                                              -- <������� �/�>: 1.)������� �� ���� 2.)������ 3)������ 4)��������� (�� ��� ����.) 5)����� 6)�������� ��������(��� �������� ��������� ���) 7)������ ���������� 8)������ ����������(����������� �/�)
                                                                                                      , inObjectCostId     := lpInsertFind_ObjectCost (inObjectCostDescId:= zc_ObjectCost_Basis()
                                                                                                                                                     , inDescId_1   := zc_ObjectCostLink_JuridicalBasis()
                                                                                                                                                     , inObjectId_1 := _tmpItem.JuridicalId_basis
                                                                                                                                                     , inDescId_2   := zc_ObjectCostLink_Business()
                                                                                                                                                     , inObjectId_2 := _tmpItem.BusinessId
                                                                                                                                                     , inDescId_3   := zc_ObjectCostLink_Branch()
                                                                                                                                                     , inObjectId_3 := _tmpItem.BranchId
                                                                                                                                                     , inDescId_4   := CASE WHEN _tmpItem.PersonalId <> 0 THEN zc_ObjectCostLink_Personal() ELSE zc_ObjectCostLink_Unit() END
                                                                                                                                                     , inObjectId_4 := CASE WHEN _tmpItem.PersonalId <> 0 AND _tmpItem.OperDate >= zc_DateStart_ObjectCostOnUnit() THEN _tmpItem.PersonalId WHEN _tmpItem.OperDate >= zc_DateStart_ObjectCostOnUnit() THEN _tmpItem.UnitId ELSE NULL END
                                                                                                                                                     , inDescId_5   := zc_ObjectCostLink_Goods()
                                                                                                                                                     , inObjectId_5 := _tmpItem.GoodsId
                                                                                                                                                     , inDescId_6   := zc_ObjectCostLink_AssetTo()
                                                                                                                                                     , inObjectId_6 := _tmpItem.AssetId
                                                                                                                                                     , inDescId_7   := zc_ObjectCostLink_InfoMoney()
                                                                                                                                                     , inObjectId_7 := _tmpItem.InfoMoneyId
                                                                                                                                                     , inDescId_8   := zc_ObjectCostLink_InfoMoneyDetail()
                                                                                                                                                     , inObjectId_8 := CASE WHEN zc_isHistoryCost_byInfoMoneyDetail() THEN _tmpItem.InfoMoneyId ELSE 0 END -- !!!��� ���������� ������� �� �� ����� InfoMoneyId_Detail!!!
                                                                                                                                                      )
                                                                                                      , inDescId_1   := CASE WHEN _tmpItem.PersonalId <> 0 THEN zc_ContainerLinkObject_Personal() ELSE zc_ContainerLinkObject_Unit() END
                                                                                                      , inObjectId_1 := CASE WHEN _tmpItem.PersonalId <> 0 THEN _tmpItem.PersonalId ELSE _tmpItem.UnitId END
                                                                                                      , inDescId_2   := zc_ContainerLinkObject_Goods()
                                                                                                      , inObjectId_2 := _tmpItem.GoodsId
                                                                                                      , inDescId_3   := zc_ContainerLinkObject_AssetTo()
                                                                                                      , inObjectId_3 := _tmpItem.AssetId
                                                                                                      , inDescId_4   := zc_ContainerLinkObject_InfoMoney()
                                                                                                      , inObjectId_4 := _tmpItem.InfoMoneyId
                                                                                                      , inDescId_5   := zc_ContainerLinkObject_InfoMoneyDetail()
                                                                                                      , inObjectId_5 := CASE WHEN zc_isHistoryCost_byInfoMoneyDetail() THEN _tmpItem.InfoMoneyId ELSE 0 END -- !!!��� ���������� ������� �� �� ����� InfoMoneyId_Detail!!!
                                                                                                       )
                                                                        WHEN _tmpItem.InfoMoneyDestinationId IN (zc_Enum_InfoMoneyDestination_20700()  -- ������    -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20700()
                                                                                                               , zc_Enum_InfoMoneyDestination_20900()  -- ����      -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20900()
                                                                                                               , zc_Enum_InfoMoneyDestination_30100()) -- ��������� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30100()
                                                                                -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)������������� 2)����� 3)!!!������ ������!!! 4)���� ������� 5)������ ���������� 6)������ ����������(����������� �/�)
                                                                                -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)��������� (�� ��� ����.) 2)����� 3)!!!������ ������!!! 4)���� ������� 5)������ ���������� 6)������ ����������(����������� �/�)
                                                                           THEN lpInsertFind_Container (inContainerDescId:= zc_Container_Summ()
                                                                                                      , inParentId:= _tmpItem.ContainerId_Goods
                                                                                                      , inObjectId:= _tmpItemSumm.AccountId
                                                                                                      , inJuridicalId_basis:= _tmpItem.JuridicalId_basis
                                                                                                      , inBusinessId       := _tmpItem.BusinessId
                                                                                                      , inObjectCostDescId := zc_ObjectCost_Basis()
                                                                                                                              -- <������� �/�>: 1.)������� �� ���� 2.)������ 3)������ 4)������������� 5)����� 6)!!!������ ������!!! 7)���� ������� 8)������ ���������� 9)������ ����������(����������� �/�)
                                                                                                                              -- <������� �/�>: 1.)������� �� ���� 2.)������ 3)������ 4)��������� (�� ��� ����.) 5)����� 6)!!!������ ������!!! 7)���� ������� 8)������ ���������� 9)������ ����������(����������� �/�)
                                                                                                      , inObjectCostId     := lpInsertFind_ObjectCost (inObjectCostDescId:= zc_ObjectCost_Basis()
                                                                                                                                                     , inDescId_1   := zc_ObjectCostLink_JuridicalBasis()
                                                                                                                                                     , inObjectId_1 := _tmpItem.JuridicalId_basis
                                                                                                                                                     , inDescId_2   := zc_ObjectCostLink_Business()
                                                                                                                                                     , inObjectId_2 := _tmpItem.BusinessId
                                                                                                                                                     , inDescId_3   := zc_ObjectCostLink_Branch()
                                                                                                                                                     , inObjectId_3 := _tmpItem.BranchId
                                                                                                                                                     , inDescId_4   := zc_ObjectCostLink_Unit()
                                                                                                                                                     , inObjectId_4 := _tmpItem.UnitId
                                                                                                                                                     , inDescId_5   := zc_ObjectCostLink_Goods()
                                                                                                                                                     , inObjectId_5 := _tmpItem.GoodsId
                                                                                                                                                     , inDescId_6   := CASE WHEN _tmpItem.PartionGoodsId <> 0 THEN zc_ObjectCostLink_PartionGoods() ELSE NULL END
                                                                                                                                                     , inObjectId_6 := CASE WHEN _tmpItem.PartionGoodsId <> 0 THEN _tmpItem.PartionGoodsId ELSE NULL END
                                                                                                                                                     , inDescId_7   := zc_ObjectCostLink_GoodsKind()
                                                                                                                                                     , inObjectId_7 := _tmpItem.GoodsKindId
                                                                                                                                                     , inDescId_8   := zc_ObjectCostLink_InfoMoney()
                                                                                                                                                     , inObjectId_8 := _tmpItem.InfoMoneyId
                                                                                                                                                     , inDescId_9   := zc_ObjectCostLink_InfoMoneyDetail()
                                                                                                                                                     , inObjectId_9 := CASE WHEN zc_isHistoryCost_byInfoMoneyDetail() THEN _tmpItem.InfoMoneyId ELSE 0 END -- !!!��� ���������� ������� �� �� ����� InfoMoneyId_Detail!!!
                                                                                                                                                      )
                                                                                                      , inDescId_1   := CASE WHEN _tmpItem.PersonalId <> 0 THEN zc_ContainerLinkObject_Personal() ELSE zc_ContainerLinkObject_Unit() END
                                                                                                      , inObjectId_1 := CASE WHEN _tmpItem.PersonalId <> 0 THEN _tmpItem.PersonalId ELSE _tmpItem.UnitId END
                                                                                                      , inDescId_2   := zc_ContainerLinkObject_Goods()
                                                                                                      , inObjectId_2 := _tmpItem.GoodsId
                                                                                                      , inDescId_3   := CASE WHEN _tmpItem.PartionGoodsId <> 0 THEN zc_ContainerLinkObject_PartionGoods() ELSE NULL END
                                                                                                      , inObjectId_3 := CASE WHEN _tmpItem.PartionGoodsId <> 0 THEN _tmpItem.PartionGoodsId ELSE NULL END
                                                                                                      , inDescId_4   := zc_ContainerLinkObject_GoodsKind()
                                                                                                      , inObjectId_4 := _tmpItem.GoodsKindId
                                                                                                      , inDescId_5   := zc_ContainerLinkObject_InfoMoney()
                                                                                                      , inObjectId_5 := _tmpItem.InfoMoneyId
                                                                                                      , inDescId_6   := zc_ContainerLinkObject_InfoMoneyDetail()
                                                                                                      , inObjectId_6 := CASE WHEN zc_isHistoryCost_byInfoMoneyDetail() THEN _tmpItem.InfoMoneyId ELSE 0 END -- !!!��� ���������� ������� �� �� ����� InfoMoneyId_Detail!!!
                                                                                                       )
                                                                                -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)������������� 2)����� 3)������ ���������� 4)������ ����������(����������� �/�)
                                                                                -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)��������� (�� ��� ����.) 2)����� 3)������ ���������� 4)������ ����������(����������� �/�)
                                                                           ELSE lpInsertFind_Container (inContainerDescId:= zc_Container_Summ()
                                                                                                      , inParentId:= _tmpItem.ContainerId_Goods
                                                                                                      , inObjectId:= _tmpItemSumm.AccountId
                                                                                                      , inJuridicalId_basis:= _tmpItem.JuridicalId_basis
                                                                                                      , inBusinessId       := _tmpItem.BusinessId
                                                                                                      , inObjectCostDescId := zc_ObjectCost_Basis()
                                                                                                                              -- <������� �/�>: 1.)������� �� ���� 2.)������ 3)������ 4)!!!�������������!!! 5)����� 6)������ ���������� 7)������ ����������(����������� �/�)
                                                                                                                              -- <������� �/�>: 1.)������� �� ���� 2.)������ 3)������ 4)��������� (�� ��� ����.) 5)����� 6)������ ���������� 7)������ ����������(����������� �/�)
                                                                                                      , inObjectCostId     := lpInsertFind_ObjectCost (inObjectCostDescId:= zc_ObjectCost_Basis()
                                                                                                                                                     , inDescId_1   := zc_ObjectCostLink_JuridicalBasis()
                                                                                                                                                     , inObjectId_1 := _tmpItem.JuridicalId_basis
                                                                                                                                                     , inDescId_2   := zc_ObjectCostLink_Business()
                                                                                                                                                     , inObjectId_2 := _tmpItem.BusinessId
                                                                                                                                                     , inDescId_3   := zc_ObjectCostLink_Branch()
                                                                                                                                                     , inObjectId_3 := _tmpItem.BranchId
                                                                                                                                                     , inDescId_4   := CASE WHEN _tmpItem.PersonalId <> 0 THEN zc_ObjectCostLink_Personal() ELSE zc_ObjectCostLink_Unit() END
                                                                                                                                                     , inObjectId_4 := CASE WHEN _tmpItem.PersonalId <> 0 AND _tmpItem.OperDate >= zc_DateStart_ObjectCostOnUnit() THEN _tmpItem.PersonalId WHEN _tmpItem.OperDate >= zc_DateStart_ObjectCostOnUnit() THEN _tmpItem.UnitId ELSE NULL END
                                                                                                                                                     , inDescId_5   := zc_ObjectCostLink_Goods()
                                                                                                                                                     , inObjectId_5 := _tmpItem.GoodsId
                                                                                                                                                     , inDescId_6   := zc_ObjectCostLink_InfoMoney()
                                                                                                                                                     , inObjectId_6 := _tmpItem.InfoMoneyId
                                                                                                                                                     , inDescId_7   := zc_ObjectCostLink_InfoMoneyDetail()
                                                                                                                                                     , inObjectId_7 := CASE WHEN zc_isHistoryCost_byInfoMoneyDetail() THEN _tmpItem.InfoMoneyId ELSE 0 END -- !!!��� ���������� ������� �� �� ����� InfoMoneyId_Detail!!!
                                                                                                                                                      )
                                                                                                      , inDescId_1   := CASE WHEN _tmpItem.PersonalId <> 0 THEN zc_ContainerLinkObject_Personal() ELSE zc_ContainerLinkObject_Unit() END
                                                                                                      , inObjectId_1 := CASE WHEN _tmpItem.PersonalId <> 0 THEN _tmpItem.PersonalId ELSE _tmpItem.UnitId END
                                                                                                      , inDescId_2   := zc_ContainerLinkObject_Goods()
                                                                                                      , inObjectId_2 := _tmpItem.GoodsId
                                                                                                      , inDescId_3   := zc_ContainerLinkObject_InfoMoney()
                                                                                                      , inObjectId_3 := _tmpItem.InfoMoneyId
                                                                                                      , inDescId_4   := zc_ContainerLinkObject_InfoMoneyDetail()
                                                                                                      , inObjectId_4 := CASE WHEN zc_isHistoryCost_byInfoMoneyDetail() THEN _tmpItem.InfoMoneyId ELSE 0 END -- !!!��� ���������� ������� �� �� ����� InfoMoneyId_Detail!!!
                                                                                                       )
                                                                   END
     FROM _tmpItem
     WHERE _tmpItemSumm.MovementItemId = _tmpItem.MovementItemId
       AND _tmpItemSumm.OperSumm <> 0
       AND _tmpItemSumm.ContainerId = 0;

     -- ����������� �������� ��� ��������� ����� !!!������!!! ���� ���� ������� �� �������
     INSERT INTO _tmpMIContainer_insert (Id, DescId, MovementId, MovementItemId, ContainerId, ParentId, Amount, OperDate, IsActive)
       SELECT 0, zc_MIContainer_Summ() AS DescId, inMovementId, _tmpItemSumm.MovementItemId, _tmpItemSumm.ContainerId, 0 AS ParentId, _tmpItemSumm.OperSumm, vbOperDate, TRUE
       FROM _tmpItemSumm
       WHERE _tmpItemSumm.OperSumm <> 0;
     /*PERFORM lpInsertUpdate_MovementItemContainer (ioId:= 0
                                                 , inDescId:= zc_MIContainer_Summ()
                                                 , inMovementId:= inMovementId
                                                 , inMovementItemId:= _tmpItemSumm.MovementItemId
                                                 , inParentId:= NULL
                                                 , inContainerId:= _tmpItemSumm.ContainerId
                                                 , inAmount:= _tmpItemSumm.OperSumm
                                                 , inOperDate:= vbOperDate
                                                 , inIsActive:= TRUE
                                                  )
     FROM _tmpItemSumm
     WHERE _tmpItemSumm.OperSumm <> 0;*/


     -- ������� ���������� ��� �������� - ������� !!!������!!! ���� ���� ������� �� �������
     UPDATE _tmpItemSumm SET ContainerId_ProfitLoss = _tmpItem_byContainer.ContainerId_ProfitLoss
     FROM (SELECT lpInsertFind_Container (inContainerDescId:= zc_Container_Summ()
                                        , inParentId:= NULL
                                        , inObjectId:= zc_Enum_Account_100301 () -- 100301; "������� �������� �������"
                                        , inJuridicalId_basis:= _tmpItem_byProfitLoss.JuridicalId_basis
                                        , inBusinessId       := _tmpItem_byProfitLoss.BusinessId
                                        , inObjectCostDescId := NULL
                                        , inObjectCostId     := NULL
                                        , inDescId_1   := zc_ContainerLinkObject_ProfitLoss()
                                        , inObjectId_1 := _tmpItem_byProfitLoss.ProfitLossId
                                         ) AS ContainerId_ProfitLoss
                , _tmpItem_byProfitLoss.ContainerId
           FROM (SELECT lpInsertFind_Object_ProfitLoss (inProfitLossGroupId      := vbProfitLossGroupId
                                                      , inProfitLossDirectionId  := vbProfitLossDirectionId
                                                      , inInfoMoneyDestinationId := _tmpItem_group.InfoMoneyDestinationId
                                                      , inInfoMoneyId            := NULL
                                                      , inUserId                 := vbUserId
                                                       ) AS ProfitLossId
                      , _tmpItem_group.ContainerId
                      , _tmpItem_group.InfoMoneyDestinationId
                      , ContainerLinkObject_JuridicalBasis.ObjectId AS JuridicalId_basis
                      , ContainerLinkObject_Business.ObjectId AS BusinessId
                 FROM (SELECT lfObject_InfoMoney.InfoMoneyDestinationId
                            , _tmpItemSumm.ContainerId
                       FROM _tmpItemSumm
                            LEFT JOIN ContainerLinkObject AS ContainerLinkObject_InfoMoney
                                                          ON ContainerLinkObject_InfoMoney.ContainerId = _tmpItemSumm.ContainerId
                                                         AND ContainerLinkObject_InfoMoney.DescId = zc_ContainerLinkObject_InfoMoney()
                            LEFT JOIN lfSelect_Object_InfoMoney() AS lfObject_InfoMoney ON lfObject_InfoMoney.InfoMoneyId = ContainerLinkObject_InfoMoney.ObjectId
                       WHERE _tmpItemSumm.OperSumm <> 0
                       GROUP BY lfObject_InfoMoney.InfoMoneyDestinationId
                              , _tmpItemSumm.ContainerId
                      ) AS _tmpItem_group
                      LEFT JOIN ContainerLinkObject AS ContainerLinkObject_JuridicalBasis
                                                    ON ContainerLinkObject_JuridicalBasis.ContainerId = _tmpItem_group.ContainerId
                                                     AND ContainerLinkObject_JuridicalBasis.DescId = zc_ContainerLinkObject_JuridicalBasis()
                      LEFT JOIN ContainerLinkObject AS ContainerLinkObject_Business
                                                    ON ContainerLinkObject_Business.ContainerId = _tmpItem_group.ContainerId
                                                   AND ContainerLinkObject_Business.DescId = zc_ContainerLinkObject_Business()
                ) AS _tmpItem_byProfitLoss
          ) AS _tmpItem_byContainer
     WHERE _tmpItemSumm.ContainerId = _tmpItem_byContainer.ContainerId;

     -- ����������� �������� - ������� !!!������!!! ���� ���� ������� �� �������
     INSERT INTO _tmpMIContainer_insert (Id, DescId, MovementId, MovementItemId, ContainerId, ParentId, Amount, OperDate, IsActive)
       SELECT 0, zc_MIContainer_Summ() AS DescId, inMovementId, 0, _tmpItem_group.ContainerId_ProfitLoss, 0 AS ParentId, -1 * _tmpItem_group.OperSumm, vbOperDate, FALSE
       FROM (SELECT _tmpItemSumm.ContainerId_ProfitLoss
                  , SUM (_tmpItemSumm.OperSumm) AS OperSumm
             FROM _tmpItemSumm
             WHERE _tmpItemSumm.OperSumm <> 0
             GROUP BY _tmpItemSumm.ContainerId_ProfitLoss
            ) AS _tmpItem_group
       ;
     /*PERFORM lpInsertUpdate_MovementItemContainer (ioId:= 0
                                                 , inDescId:= zc_MIContainer_Summ()
                                                 , inMovementId:= inMovementId
                                                 , inMovementItemId:= NULL
                                                 , inParentId:= NULL
                                                 , inContainerId:= _tmpItem_group.ContainerId_ProfitLoss
                                                 , inAmount:= -1 * _tmpItem_group.OperSumm
                                                 , inOperDate:= vbOperDate
                                                 , inIsActive:= FALSE
                                                  )
     FROM (SELECT _tmpItemSumm.ContainerId_ProfitLoss
                , SUM (_tmpItemSumm.OperSumm) AS OperSumm
           FROM _tmpItemSumm
           WHERE _tmpItemSumm.OperSumm <> 0
           GROUP BY _tmpItemSumm.ContainerId_ProfitLoss
          ) AS _tmpItem_group;*/


     -- ����������� �������� ��� ������ (���������: ����� � ����)
     PERFORM lpInsertUpdate_MovementItemReport (inMovementId := inMovementId
                                              , inMovementItemId := _tmpItem_byProfitLoss.MovementItemId
                                              , inActiveContainerId  := _tmpItem_byProfitLoss.ActiveContainerId
                                              , inPassiveContainerId := _tmpItem_byProfitLoss.PassiveContainerId
                                              , inActiveAccountId    := _tmpItem_byProfitLoss.ActiveAccountId
                                              , inPassiveAccountId   := _tmpItem_byProfitLoss.PassiveAccountId
                                              , inReportContainerId  := lpInsertFind_ReportContainer (inActiveContainerId  := _tmpItem_byProfitLoss.ActiveContainerId
                                                                                                    , inPassiveContainerId := _tmpItem_byProfitLoss.PassiveContainerId
                                                                                                    , inActiveAccountId    := _tmpItem_byProfitLoss.ActiveAccountId
                                                                                                    , inPassiveAccountId   := _tmpItem_byProfitLoss.PassiveAccountId
                                                                                                     )
                                              , inChildReportContainerId := lpInsertFind_ChildReportContainer (inActiveContainerId  := _tmpItem_byProfitLoss.ActiveContainerId
                                                                                                             , inPassiveContainerId := _tmpItem_byProfitLoss.PassiveContainerId
                                                                                                             , inActiveAccountId    := _tmpItem_byProfitLoss.ActiveAccountId
                                                                                                             , inPassiveAccountId   := _tmpItem_byProfitLoss.PassiveAccountId
                                                                                                             , inAccountKindId_1    := NULL
                                                                                                             , inContainerId_1      := NULL
                                                                                                             , inAccountId_1        := NULL
                                                                                                     )
                                              , inAmount := _tmpItem_byProfitLoss.OperSumm
                                              , inOperDate := vbOperDate
                                               )
     FROM (SELECT ABS (_tmpItemSumm.OperSumm) AS OperSumm
                , CASE WHEN _tmpItemSumm.OperSumm > 0 THEN _tmpItemSumm.ContainerId            WHEN _tmpItemSumm.OperSumm < 0 THEN _tmpItemSumm.ContainerId_ProfitLoss END AS ActiveContainerId
                , CASE WHEN _tmpItemSumm.OperSumm > 0 THEN _tmpItemSumm.ContainerId_ProfitLoss WHEN _tmpItemSumm.OperSumm < 0 THEN _tmpItemSumm.ContainerId            END AS PassiveContainerId
                , CASE WHEN _tmpItemSumm.OperSumm > 0 THEN _tmpItemSumm.AccountId              WHEN _tmpItemSumm.OperSumm < 0 THEN zc_Enum_Account_100301 ()           END AS ActiveAccountId  -- 100301; "������� �������� �������"
                , CASE WHEN _tmpItemSumm.OperSumm > 0 THEN zc_Enum_Account_100301 ()           WHEN _tmpItemSumm.OperSumm < 0 THEN _tmpItemSumm.AccountId              END AS PassiveAccountId -- 100301; "������� �������� �������"
                , _tmpItemSumm.MovementItemId
           FROM _tmpItemSumm
           WHERE _tmpItemSumm.OperSumm <> 0
           ) AS _tmpItem_byProfitLoss
     ;


     -- 5.1. ����� - ����������� ��������� ��������
     PERFORM lpInsertUpdate_MovementItemContainer_byTable ();

     -- 5.2. ����� - ����������� ������ ������ ���������
     UPDATE Movement SET StatusId = zc_Enum_Status_Complete() WHERE Id = inMovementId AND DescId = zc_Movement_Sale() AND StatusId = zc_Enum_Status_UnComplete();


END;
$BODY$
LANGUAGE PLPGSQL VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 02.09.13                                        * add lpInsertUpdate_MovementItemContainer_byTable
 01.09.13                                        * change isActive
 26.08.13                                        * add zc_InfoMoneyDestination_WorkProgress
 23.08.13                                        *
*/

-- ����
-- SELECT * FROM gpUnComplete_Movement (inMovementId:= 9234, inSession:= '2')
-- SELECT * FROM gpComplete_Movement_Sale (inMovementId:= 9234, inIsLastComplete:= FALSE, inSession:= '2')
-- SELECT * FROM gpSelect_MovementItemContainer_Movement (inMovementId:= 9234, inSession:= '2')
