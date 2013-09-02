-- Function: gpComplete_Movement_Income()

-- DROP FUNCTION gpComplete_Movement_Income (Integer, TVarChar);
-- DROP FUNCTION gpComplete_Movement_Income (Integer, Boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpComplete_Movement_Income(
    IN inMovementId        Integer               , -- ���� ���������
    IN inIsLastComplete    Boolean  DEFAULT False, -- ��� ��������� ���������� ����� ������� �/� (��� ������� �������� !!!�� ��������������!!!)
    IN inSession           TVarChar DEFAULT ''     -- ������ ������������
)                              
RETURNS VOID
--  RETURNS TABLE (MovementItemId Integer, MovementId Integer, OperDate TDateTime, JuridicalId_From Integer, isCorporate Boolean, PersonalId_From Integer, UnitId Integer, BranchId_Unit Integer, PersonalId_Packer Integer, PaidKindId Integer, ContractId Integer, ContainerId_Goods Integer, GoodsId Integer, GoodsKindId Integer, AssetId Integer, PartionGoods TVarChar, OperCount TFloat, tmpOperSumm_Partner TFloat, OperSumm_Partner TFloat, tmpOperSumm_Packer TFloat, OperSumm_Packer TFloat, AccountDirectionId Integer, InfoMoneyDestinationId Integer, InfoMoneyId Integer, InfoMoneyDestinationId_isCorporate Integer, InfoMoneyId_isCorporate Integer, JuridicalId_basis Integer, BusinessId Integer, isPartionCount Boolean, isPartionSumm Boolean, PartionMovementId Integer, PartionGoodsId Integer)
AS
$BODY$
  DECLARE vbUserId Integer;

  DECLARE vbOperSumm_Partner_byItem TFloat;
  DECLARE vbOperSumm_Packer_byItem TFloat;

  DECLARE vbOperSumm_Partner TFloat;
  DECLARE vbOperSumm_Packer TFloat;

  DECLARE vbPriceWithVAT Boolean;
  DECLARE vbVATPercent TFloat;
  DECLARE vbDiscountPercent TFloat;
  DECLARE vbExtraChargesPercent TFloat;
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Complete_Movement_Income());
     vbUserId:=2; -- CAST (inSession AS Integer);


     -- ����������� ������ ��� �����
     PERFORM lpInsertUpdate_MovementItemString (inDescId:= zc_MIString_PartionGoodsCalc()
                                              , inMovementItemId:= MovementItem.Id
                                              , inValueData:= CAST (COALESCE (Object_Goods.ObjectCode, 0) AS TVarChar)
                                                    || '-' || CAST (COALESCE (Object_Partner.ObjectCode, 0) AS TVarChar)
                                                    || '-' || TO_CHAR (Movement.OperDate, 'DD.MM.YYYY')
                                               )
     FROM MovementItem
          LEFT JOIN Object AS Object_Goods ON Object_Goods.Id = MovementItem.ObjectId
          LEFT JOIN Movement ON Movement.Id = MovementItem.MovementId
          LEFT JOIN MovementLinkObject AS MovementLinkObject_To
                                       ON MovementLinkObject_To.MovementId = MovementItem.MovementId
                                      AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
          LEFT JOIN Object AS Object_Partner ON Object_Partner.Id = MovementLinkObject_To.ObjectId

          LEFT JOIN ObjectLink AS ObjectLink_Goods_InfoMoney
                               ON ObjectLink_Goods_InfoMoney.ObjectId = MovementItem.ObjectId
                              AND ObjectLink_Goods_InfoMoney.DescId = zc_ObjectLink_Goods_InfoMoney()
          LEFT JOIN lfSelect_Object_InfoMoney() AS lfObject_InfoMoney ON lfObject_InfoMoney.InfoMoneyId = ObjectLink_Goods_InfoMoney.ChildObjectId
     WHERE MovementItem.MovementId = inMovementId
       AND lfObject_InfoMoney.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10100() -- ������ ����� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10100()
     ;

     -- ��� ��������� ����� ��� ������� �������� ���� �� ����������� � ������������
     SELECT
           COALESCE (MovementBoolean_PriceWithVAT.ValueData, TRUE)
         , COALESCE (MovementFloat_VATPercent.ValueData, 0)
         , CASE WHEN COALESCE (MovementFloat_ChangePercent.ValueData, 0) < 0 THEN -MovementFloat_ChangePercent.ValueData ELSE 0 END
         , CASE WHEN COALESCE (MovementFloat_ChangePercent.ValueData, 0) > 0 THEN MovementFloat_ChangePercent.ValueData ELSE 0 END
           INTO vbPriceWithVAT, vbVATPercent, vbDiscountPercent, vbExtraChargesPercent
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
     WHERE Movement.Id = inMovementId
       AND Movement.DescId = zc_Movement_Income()
       AND Movement.StatusId = zc_Enum_Status_UnComplete();


     -- ������� - ��������� �������
     CREATE TEMP TABLE _tmpContainer (DescId Integer, ObjectId Integer) ON COMMIT DROP;
     -- ������� - ��������� <������� �/�>
     CREATE TEMP TABLE _tmpObjectCost (DescId Integer, ObjectId Integer) ON COMMIT DROP;
     -- ������� - ��������� <�������� ��� ������>
     CREATE TEMP TABLE _tmpReportContainer (isActive Boolean, ContainerId Integer) ON COMMIT DROP;

     -- ������� - �������� �� �����������, �� ����� ���������� ��� ������������ �������� � ���������
     CREATE TEMP TABLE _tmpItem_SummPartner (MovementId Integer, OperDate TDateTime, JuridicalId_From Integer, isCorporate Boolean, PersonalId_From Integer
                                           , PaidKindId Integer, ContractId Integer
                                           , ContainerId Integer
                                           , OperSumm_Partner TFloat
                                           , InfoMoneyDestinationId Integer, InfoMoneyId Integer, InfoMoneyDestinationId_isCorporate Integer, InfoMoneyId_isCorporate Integer
                                           , JuridicalId_basis Integer, BusinessId Integer
                                           , PartionMovementId Integer) ON COMMIT DROP;

     -- ������� - �������� �� ������������, �� ����� ���������� ��� ������������ �������� � ���������
     CREATE TEMP TABLE _tmpItem_SummPacker (MovementId Integer, OperDate TDateTime, PersonalId_Packer Integer
                                          , ContainerId Integer
                                          , OperSumm_Packer TFloat
                                          , InfoMoneyDestinationId Integer, InfoMoneyId Integer
                                          , JuridicalId_basis Integer, BusinessId Integer
                                           ) ON COMMIT DROP;

     -- ������� - �������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     CREATE TEMP TABLE _tmpItem (MovementItemId Integer, MovementId Integer, OperDate TDateTime, JuridicalId_From Integer, isCorporate Boolean, PersonalId_From Integer
                               , UnitId Integer, BranchId_Unit Integer, PersonalId_Packer Integer, PaidKindId Integer, ContractId Integer
                               , ContainerId_Summ Integer, ContainerId_Goods Integer, GoodsId Integer, GoodsKindId Integer, AssetId Integer, PartionGoods TVarChar, PartionGoodsDate TDateTime
                               , OperCount TFloat, tmpOperSumm_Partner TFloat, OperSumm_Partner TFloat, tmpOperSumm_Packer TFloat, OperSumm_Packer TFloat
                               , AccountDirectionId Integer, InfoMoneyDestinationId Integer, InfoMoneyId Integer, InfoMoneyDestinationId_isCorporate Integer, InfoMoneyId_isCorporate Integer
                               , JuridicalId_basis Integer, BusinessId Integer
                               , isPartionCount Boolean, isPartionSumm Boolean, isPartionDate Boolean
                               , PartionMovementId Integer, PartionGoodsId Integer) ON COMMIT DROP;
     -- ��������� ������� - �������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     INSERT INTO _tmpItem (MovementItemId, MovementId, OperDate, JuridicalId_From, isCorporate, PersonalId_From, UnitId, BranchId_Unit, PersonalId_Packer, PaidKindId, ContractId
                         , ContainerId_Summ, ContainerId_Goods, GoodsId, GoodsKindId, AssetId, PartionGoods, PartionGoodsDate
                         , OperCount, tmpOperSumm_Partner, OperSumm_Partner, tmpOperSumm_Packer, OperSumm_Packer
                         , AccountDirectionId, InfoMoneyDestinationId, InfoMoneyId, InfoMoneyDestinationId_isCorporate, InfoMoneyId_isCorporate
                         , JuridicalId_basis, BusinessId
                         , isPartionCount, isPartionSumm, isPartionDate
                         , PartionMovementId, PartionGoodsId)
        SELECT
              _tmp.MovementItemId
            , _tmp.MovementId
            , _tmp.OperDate
            , _tmp.JuridicalId_From
            , _tmp.isCorporate
            , _tmp.PersonalId_From
            , _tmp.UnitId
            , _tmp.BranchId_Unit
            , _tmp.PersonalId_Packer
            , _tmp.PaidKindId
            , _tmp.ContractId

            , 0 AS ContainerId_Summ
            , 0 AS ContainerId_Goods
            , _tmp.GoodsId
            , _tmp.GoodsKindId
            , _tmp.AssetId
            , _tmp.PartionGoods
            , _tmp.PartionGoodsDate

            , _tmp.OperCount

              -- ������������� ����� �� ����������� - � ����������� �� 2-� ������
            , _tmp.tmpOperSumm_Partner
              -- �������� ����� �� �����������
            , CASE WHEN vbPriceWithVAT OR vbVATPercent = 0
                      -- ���� ���� � ��� ��� %���=0, ����� ��������� ��� % ������ ��� % �������
                      THEN CASE WHEN vbDiscountPercent > 0 THEN CAST ( (1 - vbDiscountPercent / 100) * (tmpOperSumm_Partner) AS NUMERIC (16, 2))
                                WHEN vbExtraChargesPercent > 0 THEN CAST ( (1 + vbExtraChargesPercent / 100) * (tmpOperSumm_Partner) AS NUMERIC (16, 2))
                                ELSE (tmpOperSumm_Partner)
                           END
                   WHEN vbVATPercent > 0
                      -- ���� ���� ��� ���, ����� ��������� ��� % ������ ��� % ������� ��� ����� � ��� (���� ������� ����� � ��� ��� � ��� ��)
                      THEN CASE WHEN vbDiscountPercent > 0 THEN CAST ( (1 + vbVATPercent / 100) * (1 - vbDiscountPercent/100) * (tmpOperSumm_Partner) AS NUMERIC (16, 2))
                                WHEN vbExtraChargesPercent > 0 THEN CAST ( (1 + vbVATPercent / 100) * (1 + vbExtraChargesPercent/100) * (tmpOperSumm_Partner) AS NUMERIC (16, 2))
                                ELSE CAST ( (1 + vbVATPercent / 100) * (tmpOperSumm_Partner) AS NUMERIC (16, 2))
                           END
                   WHEN vbVATPercent > 0
                      -- ���� ���� ��� ���, ����� ��������� ��� % ������ ��� % ������� ��� ����� ��� ���, ��������� �� 2-� ������, � ����� ��������� ��� (���� ������� ����� ������������ ��� ��)
                      THEN CASE WHEN vbDiscountPercent > 0 THEN CAST ( (1 + vbVATPercent / 100) * CAST ( (1 - vbDiscountPercent/100) * (tmpOperSumm_Partner) AS NUMERIC (16, 2)) AS NUMERIC (16, 2))
                                WHEN vbExtraChargesPercent > 0 THEN CAST ( (1 + vbVATPercent / 100) * CAST ( (1 + vbExtraChargesPercent/100) * (tmpOperSumm_Partner) AS NUMERIC (16, 2)) AS NUMERIC (16, 2))
                                ELSE CAST ( (1 + vbVATPercent / 100) * (tmpOperSumm_Partner) AS NUMERIC (16, 2))
                           END
              END AS OperSumm_Partner

              -- ������������� ����� �� ������������ - � ����������� �� 2-� ������
            , _tmp.tmpOperSumm_Packer
              -- �������� ����� �� ������������
            , CASE WHEN vbPriceWithVAT OR vbVATPercent = 0
                      -- ���� ���� � ��� ��� %���=0, ����� ��������� ��� % ������ ��� % �������
                      THEN CASE WHEN vbDiscountPercent > 0 THEN CAST ( (1 - vbDiscountPercent / 100) * (tmpOperSumm_Packer) AS NUMERIC (16, 2))
                                WHEN vbExtraChargesPercent > 0 THEN CAST ( (1 + vbExtraChargesPercent / 100) * (tmpOperSumm_Packer) AS NUMERIC (16, 2))
                                ELSE (tmpOperSumm_Packer)
                           END
                   WHEN vbVATPercent > 0
                      -- ���� ���� ��� ���, ����� ��������� ��� % ������ ��� % ������� ��� ����� � ��� (���� ������� ����� � ��� ��� � ��� ��)
                      THEN CASE WHEN vbDiscountPercent > 0 THEN CAST ( (1 + vbVATPercent / 100) * (1 - vbDiscountPercent/100) * (tmpOperSumm_Packer) AS NUMERIC (16, 2))
                                WHEN vbExtraChargesPercent > 0 THEN CAST ( (1 + vbVATPercent / 100) * (1 + vbExtraChargesPercent/100) * (tmpOperSumm_Packer) AS NUMERIC (16, 2))
                                ELSE CAST ( (1 + vbVATPercent / 100) * (tmpOperSumm_Packer) AS NUMERIC (16, 2))
                           END
                   WHEN vbVATPercent > 0
                      -- ���� ���� ��� ���, ����� ��������� ��� % ������ ��� % ������� ��� ����� ��� ���, ��������� �� 2-� ������, � ����� ��������� ��� (���� ������� ����� ������������ ��� ��)
                      THEN CASE WHEN vbDiscountPercent > 0 THEN CAST ( (1 + vbVATPercent / 100) * CAST ( (1 - vbDiscountPercent/100) * (tmpOperSumm_Packer) AS NUMERIC (16, 2)) AS NUMERIC (16, 2))
                                WHEN vbExtraChargesPercent > 0 THEN CAST ( (1 + vbVATPercent / 100) * CAST ( (1 + vbExtraChargesPercent/100) * (tmpOperSumm_Packer) AS NUMERIC (16, 2)) AS NUMERIC (16, 2))
                                ELSE CAST ( (1 + vbVATPercent / 100) * (tmpOperSumm_Packer) AS NUMERIC (16, 2))
                           END
              END AS OperSumm_Packer

              -- ��������� ������ - �����������
            , _tmp.AccountDirectionId
              -- �������������� ����������
            , _tmp.InfoMoneyDestinationId
              -- ������ ����������
            , _tmp.InfoMoneyId
              -- �������������� ���������� (���� ���� ��������)
            , _tmp.InfoMoneyDestinationId_isCorporate
              -- ������ ���������� (���� ���� ��������)
            , _tmp.InfoMoneyId_isCorporate

            , _tmp.JuridicalId_basis
            , _tmp.BusinessId

            , _tmp.isPartionCount
            , _tmp.isPartionSumm 
            , _tmp.isPartionDate
              -- ������ ���������, ���������� �����
            , 0 AS PartionMovementId
              -- ������ ������, ���������� �����
            , 0 AS PartionGoodsId
        FROM 
             (SELECT
                    MovementItem.Id AS MovementItemId
                  , MovementItem.MovementId
                  , Movement.OperDate
                  , COALESCE (CASE WHEN Object_From.DescId <> zc_Object_Member() THEN ObjectLink_Partner_Juridical.ChildObjectId ELSE 0 END, 0) AS JuridicalId_From
                  , COALESCE (ObjectBoolean_isCorporate.ValueData, FALSE) AS isCorporate
                  , COALESCE (CASE WHEN Object_From.DescId = zc_Object_Member() THEN Object_From.Id ELSE 0 END, 0) AS PersonalId_From
                  , COALESCE (MovementLinkObject_To.ObjectId, 0) AS UnitId
                  , COALESCE (ObjectLink_Unit_Branch.ChildObjectId, 0) AS BranchId_Unit
                  , COALESCE (MovementLinkObject_PersonalPacker.ObjectId, 0) AS PersonalId_Packer
                  , COALESCE (MovementLinkObject_PaidKind.ObjectId, 0) AS PaidKindId
                  , COALESCE (MovementLinkObject_Contract.ObjectId, 0) AS ContractId

                  , MovementItem.ObjectId AS GoodsId
                  , COALESCE (MILinkObject_GoodsKind.ObjectId, 0) AS GoodsKindId
                  , COALESCE (MILinkObject_Asset.ObjectId, 0) AS AssetId
                  , CASE WHEN COALESCE (MIString_PartionGoods.ValueData, '') <> '' THEN MIString_PartionGoods.ValueData
                         WHEN COALESCE (MIString_PartionGoodsCalc.ValueData, '') <> '' THEN MIString_PartionGoodsCalc.ValueData
                         ELSE ''
                    END AS PartionGoods
                  , COALESCE (MIDate_PartionGoods.ValueData, zc_DateEnd()) AS PartionGoodsDate
 
                  , MovementItem.Amount AS OperCount

                    -- ������������� ����� �� ����������� - � ����������� �� 2-� ������
                  , CASE WHEN COALESCE (MIFloat_CountForPrice.ValueData, 0) <> 0 THEN COALESCE (CAST (MIFloat_AmountPartner.ValueData * MIFloat_Price.ValueData / MIFloat_CountForPrice.ValueData AS NUMERIC (16, 2)), 0)
                                                                                 ELSE COALESCE (CAST (MIFloat_AmountPartner.ValueData * MIFloat_Price.ValueData AS NUMERIC (16, 2)), 0)
                    END AS tmpOperSumm_Partner

                    -- ������������� ����� �� ������������ - � ����������� �� 2-� ������
                  , CASE WHEN COALESCE (MIFloat_CountForPrice.ValueData, 0) <> 0 THEN COALESCE (CAST (MIFloat_AmountPacker.ValueData * MIFloat_Price.ValueData / MIFloat_CountForPrice.ValueData AS NUMERIC (16, 2)), 0)
                                                                                 ELSE COALESCE (CAST (MIFloat_AmountPacker.ValueData * MIFloat_Price.ValueData AS NUMERIC (16, 2)), 0)
                    END AS tmpOperSumm_Packer

                    -- ��������� ������ - �����������
                  , COALESCE (ObjectLink_Unit_AccountDirection.ChildObjectId, 0) AS AccountDirectionId
                    -- �������������� ����������
                  , COALESCE (lfObject_InfoMoney.InfoMoneyDestinationId, 0) AS InfoMoneyDestinationId
                    -- ������ ����������
                  , COALESCE (lfObject_InfoMoney.InfoMoneyId, 0) AS InfoMoneyId
                    -- �������������� ���������� (���� ���� ��������)
                  , COALESCE (lfObject_InfoMoney_isCorporate.InfoMoneyDestinationId, 0) AS InfoMoneyDestinationId_isCorporate
                    -- ������ ���������� (���� ���� ��������)
                  , COALESCE (lfObject_InfoMoney_isCorporate.InfoMoneyId, 0) AS InfoMoneyId_isCorporate

                  , COALESCE (ObjectLink_Unit_Juridical.ChildObjectId, 0) AS JuridicalId_basis
                  , COALESCE (ObjectLink_Unit_Business.ChildObjectId, 0) AS BusinessId

                  , COALESCE (ObjectBoolean_PartionCount.ValueData, FALSE) AS isPartionCount
                  , COALESCE (ObjectBoolean_PartionSumm.ValueData, FALSE)  AS isPartionSumm
                  , COALESCE (ObjectBoolean_PartionDate.ValueData, FALSE)  AS isPartionDate

              FROM Movement
                   JOIN MovementItem ON MovementItem.MovementId = Movement.Id AND MovementItem.DescId = zc_MI_Master() AND MovementItem.isErased = FALSE

                   LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                                    ON MILinkObject_GoodsKind.MovementItemId = MovementItem.Id
                                                   AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()
                   LEFT JOIN MovementItemLinkObject AS MILinkObject_Asset
                                                    ON MILinkObject_Asset.MovementItemId = MovementItem.Id
                                                   AND MILinkObject_Asset.DescId = zc_MILinkObject_Asset()

                   LEFT JOIN MovementItemFloat AS MIFloat_AmountPartner
                                               ON MIFloat_AmountPartner.MovementItemId = MovementItem.Id
                                              AND MIFloat_AmountPartner.DescId = zc_MIFloat_AmountPartner()
                   LEFT JOIN MovementItemFloat AS MIFloat_AmountPacker
                                               ON MIFloat_AmountPacker.MovementItemId = MovementItem.Id
                                              AND MIFloat_AmountPacker.DescId = zc_MIFloat_AmountPacker()

                   LEFT JOIN MovementItemFloat AS MIFloat_Price
                                               ON MIFloat_Price.MovementItemId = MovementItem.Id
                                              AND MIFloat_Price.DescId = zc_MIFloat_Price()
                   LEFT JOIN MovementItemFloat AS MIFloat_CountForPrice
                                               ON MIFloat_CountForPrice.MovementItemId = MovementItem.Id
                                              AND MIFloat_CountForPrice.DescId = zc_MIFloat_CountForPrice()

                   LEFT JOIN MovementItemString AS MIString_PartionGoods
                                                ON MIString_PartionGoods.MovementItemId = MovementItem.Id
                                               AND MIString_PartionGoods.DescId = zc_MIString_PartionGoods()
                   LEFT JOIN MovementItemString AS MIString_PartionGoodsCalc
                                                ON MIString_PartionGoodsCalc.MovementItemId = MovementItem.Id
                                               AND MIString_PartionGoodsCalc.DescId = zc_MIString_PartionGoodsCalc()
                   LEFT JOIN MovementItemDate AS MIDate_PartionGoods
                                              ON MIDate_PartionGoods.MovementItemId = MovementItem.Id
                                             AND MIDate_PartionGoods.DescId = zc_MIDate_PartionGoods()

                   LEFT JOIN MovementLinkObject AS MovementLinkObject_From
                                                ON MovementLinkObject_From.MovementId = MovementItem.MovementId
                                               AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()
                   LEFT JOIN Object AS Object_From ON Object_From.Id = MovementLinkObject_From.ObjectId

                   LEFT JOIN MovementLinkObject AS MovementLinkObject_To
                                                ON MovementLinkObject_To.MovementId = MovementItem.MovementId
                                               AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
                   LEFT JOIN MovementLinkObject AS MovementLinkObject_PersonalPacker
                                                ON MovementLinkObject_PersonalPacker.MovementId = MovementItem.MovementId
                                               AND MovementLinkObject_PersonalPacker.DescId = zc_MovementLinkObject_PersonalPacker()
                   LEFT JOIN MovementLinkObject AS MovementLinkObject_PaidKind
                                                ON MovementLinkObject_PaidKind.MovementId = MovementItem.MovementId
                                               AND MovementLinkObject_PaidKind.DescId = zc_MovementLinkObject_PaidKind()
                   LEFT JOIN MovementLinkObject AS MovementLinkObject_Contract
                                                ON MovementLinkObject_Contract.MovementId = MovementItem.MovementId
                                               AND MovementLinkObject_Contract.DescId = zc_MovementLinkObject_Contract()

                   LEFT JOIN ObjectLink AS ObjectLink_Unit_Branch
                                        ON ObjectLink_Unit_Branch.ObjectId = MovementLinkObject_To.ObjectId
                                       AND ObjectLink_Unit_Branch.DescId = zc_ObjectLink_Unit_Branch()
                   LEFT JOIN ObjectLink AS ObjectLink_Partner_Juridical
                                        ON ObjectLink_Partner_Juridical.ObjectId = MovementLinkObject_From.ObjectId
                                       AND ObjectLink_Partner_Juridical.DescId = zc_ObjectLink_Partner_Juridical()
                   LEFT JOIN ObjectLink AS ObjectLink_Juridical_InfoMoney
                                        ON ObjectLink_Juridical_InfoMoney.ObjectId = ObjectLink_Partner_Juridical.ChildObjectId
                                       AND ObjectLink_Juridical_InfoMoney.DescId = zc_ObjectLink_Juridical_InfoMoney()
                   LEFT JOIN ObjectBoolean AS ObjectBoolean_isCorporate
                                           ON ObjectBoolean_isCorporate.ObjectId = ObjectLink_Partner_Juridical.ChildObjectId
                                          AND ObjectBoolean_isCorporate.DescId = zc_ObjectBoolean_Juridical_isCorporate()

                   LEFT JOIN ObjectLink AS ObjectLink_Unit_AccountDirection
                                        ON ObjectLink_Unit_AccountDirection.ObjectId = MovementLinkObject_To.ObjectId
                                       AND ObjectLink_Unit_AccountDirection.DescId = zc_ObjectLink_Unit_AccountDirection()
                   LEFT JOIN ObjectLink AS ObjectLink_Unit_Juridical
                                        ON ObjectLink_Unit_Juridical.ObjectId = MovementLinkObject_To.ObjectId
                                       AND ObjectLink_Unit_Juridical.DescId = zc_ObjectLink_Unit_Juridical()
                   LEFT JOIN ObjectLink AS ObjectLink_Unit_Business
                                        ON ObjectLink_Unit_Business.ObjectId = MovementLinkObject_To.ObjectId
                                       AND ObjectLink_Unit_Business.DescId = zc_ObjectLink_Unit_Business()

                   LEFT JOIN ObjectBoolean AS ObjectBoolean_PartionDate
                                           ON ObjectBoolean_PartionDate.ObjectId = MovementLinkObject_To.ObjectId
                                          AND ObjectBoolean_PartionDate.DescId = zc_ObjectBoolean_Unit_PartionDate()
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
                   LEFT JOIN lfSelect_Object_InfoMoney() AS lfObject_InfoMoney_isCorporate ON lfObject_InfoMoney_isCorporate.InfoMoneyId = ObjectLink_Juridical_InfoMoney.ChildObjectId

              WHERE Movement.Id = inMovementId
                AND Movement.DescId = zc_Movement_Income()
                AND Movement.StatusId = zc_Enum_Status_UnComplete()
             ) AS _tmp;

     -- !!!
     -- IF NOT EXISTS (SELECT MovementItemId FROM _tmpItem) THEN RETURN; END IF:


     -- ������ �������� ����� �� �����������
     SELECT CASE WHEN vbPriceWithVAT OR vbVATPercent = 0
                    -- ���� ���� � ��� ��� %���=0, ����� ��������� ��� % ������ ��� % �������
                    THEN CASE WHEN vbDiscountPercent > 0 THEN CAST ( (1 - vbDiscountPercent / 100) * SUM (tmpOperSumm_Partner) AS NUMERIC (16, 2))
                              WHEN vbExtraChargesPercent > 0 THEN CAST ( (1 + vbExtraChargesPercent / 100) * SUM (tmpOperSumm_Partner) AS NUMERIC (16, 2))
                              ELSE SUM (tmpOperSumm_Partner)
                         END
                 WHEN vbVATPercent > 0
                    -- ���� ���� ��� ���, ����� ��������� ��� % ������ ��� % ������� ��� ����� � ��� (���� ������� ����� � ��� ��� � ��� ��)
                    THEN CASE WHEN vbDiscountPercent > 0 THEN CAST ( (1 + vbVATPercent / 100) * (1 - vbDiscountPercent/100) * SUM (tmpOperSumm_Partner) AS NUMERIC (16, 2))
                              WHEN vbExtraChargesPercent > 0 THEN CAST ( (1 + vbVATPercent / 100) * (1 + vbExtraChargesPercent/100) * SUM (tmpOperSumm_Partner) AS NUMERIC (16, 2))
                              ELSE CAST ( (1 + vbVATPercent / 100) * SUM (tmpOperSumm_Partner) AS NUMERIC (16, 2))
                         END
                 WHEN vbVATPercent > 0
                    -- ���� ���� ��� ���, ����� ��������� ��� % ������ ��� % ������� ��� ����� ��� ���, ��������� �� 2-� ������, � ����� ��������� ��� (���� ������� ����� ������������ ��� ��)
                    THEN CASE WHEN vbDiscountPercent > 0 THEN CAST ( (1 + vbVATPercent / 100) * CAST ( (1 - vbDiscountPercent/100) * SUM (tmpOperSumm_Partner) AS NUMERIC (16, 2)) AS NUMERIC (16, 2))
                              WHEN vbExtraChargesPercent > 0 THEN CAST ( (1 + vbVATPercent / 100) * CAST ( (1 + vbExtraChargesPercent/100) * SUM (tmpOperSumm_Partner) AS NUMERIC (16, 2)) AS NUMERIC (16, 2))
                              ELSE CAST ( (1 + vbVATPercent / 100) * SUM (tmpOperSumm_Partner) AS NUMERIC (16, 2))
                         END
            END
            INTO vbOperSumm_Partner
     FROM _tmpItem;

     -- ������ �������� ����� �� ������������ (����� ��� �� ��� � ��� �������)
     SELECT CASE WHEN vbPriceWithVAT OR vbVATPercent = 0
                    -- ���� ���� � ��� ��� %���=0, ����� ��������� ��� % ������ ��� % �������
                    THEN CASE WHEN vbDiscountPercent > 0 THEN CAST ( (1 - vbDiscountPercent / 100) * SUM (tmpOperSumm_Packer) AS NUMERIC (16, 2))
                              WHEN vbExtraChargesPercent > 0 THEN CAST ( (1 + vbExtraChargesPercent / 100) * SUM (tmpOperSumm_Packer) AS NUMERIC (16, 2))
                              ELSE SUM (tmpOperSumm_Packer)
                         END
                 WHEN vbVATPercent > 0
                    -- ���� ���� ��� ���, ����� ��������� ��� % ������ ��� % ������� ��� ����� � ��� (���� ������� ����� � ��� ��� � ��� ��)
                    THEN CASE WHEN vbDiscountPercent > 0 THEN CAST ( (1 + vbVATPercent / 100) * (1 - vbDiscountPercent/100) * SUM (tmpOperSumm_Packer) AS NUMERIC (16, 2))
                              WHEN vbExtraChargesPercent > 0 THEN CAST ( (1 + vbVATPercent / 100) * (1 + vbExtraChargesPercent/100) * SUM (tmpOperSumm_Packer) AS NUMERIC (16, 2))
                              ELSE CAST ( (1 + vbVATPercent / 100) * SUM (tmpOperSumm_Packer) AS NUMERIC (16, 2))
                         END
                 WHEN vbVATPercent > 0
                    -- ���� ���� ��� ���, ����� ��������� ��� % ������ ��� % ������� ��� ����� ��� ���, ��������� �� 2-� ������, � ����� ��������� ��� (���� ������� ����� ������������ ��� ��)
                    THEN CASE WHEN vbDiscountPercent > 0 THEN CAST ( (1 + vbVATPercent / 100) * CAST ( (1 - vbDiscountPercent/100) * SUM (tmpOperSumm_Packer) AS NUMERIC (16, 2)) AS NUMERIC (16, 2))
                              WHEN vbExtraChargesPercent > 0 THEN CAST ( (1 + vbVATPercent / 100) * CAST ( (1 + vbExtraChargesPercent/100) * SUM (tmpOperSumm_Packer) AS NUMERIC (16, 2)) AS NUMERIC (16, 2))
                              ELSE CAST ( (1 + vbVATPercent / 100) * SUM (tmpOperSumm_Packer) AS NUMERIC (16, 2))
                         END
            END
            INTO vbOperSumm_Packer
     FROM _tmpItem;

     -- ������ �������� ����� �� ����������� (�� ���������)
     SELECT SUM (OperSumm_Partner) INTO vbOperSumm_Partner_byItem FROM _tmpItem;
     -- ������ �������� ����� �� ������������ (�� ���������)
     SELECT SUM (OperSumm_Packer) INTO vbOperSumm_Packer_byItem FROM _tmpItem;


     -- ���� �� ����� ��� �������� ����� �� �����������
     IF COALESCE (vbOperSumm_Partner, 0) <> COALESCE (vbOperSumm_Partner_byItem, 0)
     THEN
         -- �� ������� ������������ ����� ������� ����� (������������ ����� ���������� �������� < 0, �� ��� ������ �� ������������)
         UPDATE _tmpItem SET OperSumm_Partner = OperSumm_Partner - (vbOperSumm_Partner_byItem - vbOperSumm_Partner)
         WHERE MovementItemId IN (SELECT MAX (MovementItemId) FROM _tmpItem WHERE OperSumm_Partner IN (SELECT MAX (OperSumm_Partner) FROM _tmpItem)
                                 );
     END IF;

     -- ���� �� ����� ��� �������� ����� �� ������������
     IF COALESCE (vbOperSumm_Packer, 0) <> COALESCE (vbOperSumm_Packer_byItem, 0)
     THEN
         -- �� ������� ������������ ����� ������� ����� (������������ ����� ���������� �������� < 0, �� ��� ������ �� ������������)
         UPDATE _tmpItem SET OperSumm_Packer = OperSumm_Packer - (vbOperSumm_Packer_byItem - vbOperSumm_Packer)
         WHERE MovementItemId IN (SELECT MAX (MovementItemId) FROM _tmpItem WHERE OperSumm_Packer IN (SELECT MAX (OperSumm_Packer) FROM _tmpItem)
                                 );
     END IF;

     -- ����������� ������ ���������, ���� �� ���� � NOT isCorporate � �������������� ���������� = 10100; "������ �����" -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10100()
     UPDATE _tmpItem SET PartionMovementId = lpInsertFind_Object_PartionMovement (MovementId) WHERE PersonalId_From = 0
                                                                                                AND InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10100()
                                                                                                AND NOT isCorporate;

     -- ����������� ������ ������, ���� ���� ...
     UPDATE _tmpItem SET PartionGoodsId = CASE WHEN OperDate >= zc_DateStart_PartionGoods()
                                                AND AccountDirectionId = zc_Enum_AccountDirection_20200() -- "������"; 20200; "�� �������"
                                                AND (isPartionCount OR isPartionSumm)
                                                   THEN lpInsertFind_Object_PartionGoods (PartionGoods)
                                               WHEN isPartionDate
                                                AND InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30100() -- "������"; 30100; "���������"
                                                   THEN lpInsertFind_Object_PartionGoods (PartionGoodsDate)
                                               ELSE lpInsertFind_Object_PartionGoods ('')
                                          END
     WHERE InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10100() -- "�������� �����"; 10100; "������ �����"
        OR InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30100() -- "������"; 30100; "���������"
     ;

     -- ��������� ������� - �������� �� �����������, �� ����� ���������� ��� ������������ �������� � ���������
     INSERT INTO _tmpItem_SummPartner (MovementId, OperDate, JuridicalId_From, isCorporate, PersonalId_From, PaidKindId, ContractId, ContainerId, OperSumm_Partner, InfoMoneyDestinationId, InfoMoneyId, InfoMoneyDestinationId_isCorporate, InfoMoneyId_isCorporate, JuridicalId_basis, BusinessId, PartionMovementId)
        SELECT MovementId, OperDate, JuridicalId_From, isCorporate, PersonalId_From, PaidKindId, ContractId, 0 AS ContainerId, SUM (OperSumm_Partner), InfoMoneyDestinationId, InfoMoneyId, InfoMoneyDestinationId_isCorporate, InfoMoneyId_isCorporate, JuridicalId_basis, BusinessId, PartionMovementId FROM _tmpItem WHERE OperSumm_Partner <> 0 GROUP BY MovementId, OperDate, JuridicalId_From, isCorporate, PersonalId_From, PaidKindId, ContractId, InfoMoneyDestinationId, InfoMoneyId, InfoMoneyDestinationId_isCorporate, InfoMoneyId_isCorporate, JuridicalId_basis, BusinessId, PartionMovementId;

     -- ��������� ������� - �������� �� ������������, �� ����� ���������� ��� ������������ �������� � ���������
     INSERT INTO _tmpItem_SummPacker (MovementId, OperDate, PersonalId_Packer, ContainerId, OperSumm_Packer, InfoMoneyDestinationId, InfoMoneyId, JuridicalId_basis, BusinessId)
        SELECT MovementId, OperDate, PersonalId_Packer, 0 AS ContainerId, SUM (OperSumm_Packer), InfoMoneyDestinationId, InfoMoneyId, JuridicalId_basis, BusinessId FROM _tmpItem WHERE OperSumm_Packer <> 0 GROUP BY MovementId, OperDate, PersonalId_Packer, InfoMoneyDestinationId, InfoMoneyId, JuridicalId_basis, BusinessId;


     -- ��� �����
     -- RETURN QUERY SELECT _tmpItem.MovementItemId, _tmpItem.MovementId, _tmpItem.OperDate, _tmpItem.JuridicalId_From, _tmpItem.isCorporate, _tmpItem.PersonalId_From, _tmpItem.UnitId, _tmpItem.BranchId_Unit, _tmpItem.PersonalId_Packer, _tmpItem.PaidKindId, _tmpItem.ContractId, _tmpItem.ContainerId_Goods, _tmpItem.GoodsId, _tmpItem.GoodsKindId, _tmpItem.AssetId, _tmpItem.PartionGoods, _tmpItem.OperCount, _tmpItem.tmpOperSumm_Partner, _tmpItem.OperSumm_Partner, _tmpItem.tmpOperSumm_Packer, _tmpItem.OperSumm_Packer, _tmpItem.AccountDirectionId, _tmpItem.InfoMoneyDestinationId, _tmpItem.InfoMoneyId, _tmpItem.InfoMoneyDestinationId_isCorporate, _tmpItem.InfoMoneyId_isCorporate, _tmpItem.JuridicalId_basis, _tmpItem.BusinessId                         , _tmpItem.isPartionCount, _tmpItem.isPartionSumm, _tmpItem.PartionMovementId, _tmpItem.PartionGoodsId FROM _tmpItem;


     -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
     -- !!! �� � ������ - �������� !!!
     -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


     -- 1.1.1. ������������ ContainerId_Goods ��� �������� �� ��������������� �����
     UPDATE _tmpItem SET ContainerId_Goods = CASE WHEN InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10100() -- ������ ����� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10100()
                                                          -- 0)����� 1)������������� 2)!������ ������!
                                                     THEN lpInsertFind_Container (inContainerDescId:= zc_Container_Count()
                                                                                , inParentId:= NULL
                                                                                , inObjectId:= GoodsId
                                                                                , inJuridicalId_basis:= NULL
                                                                                , inBusinessId       := NULL
                                                                                , inObjectCostDescId := NULL
                                                                                , inObjectCostId     := NULL
                                                                                , inDescId_1   := zc_ContainerLinkObject_Unit()
                                                                                , inObjectId_1 := UnitId
                                                                                , inDescId_2   := zc_ContainerLinkObject_PartionGoods()
                                                                                , inObjectId_2 := CASE WHEN isPartionCount THEN PartionGoodsId ELSE NULL END
                                                                                 )
                                                  WHEN InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20100() -- �������� � ������� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20100()
                                                          -- 0)����� 1)������������� 2)�������� ��������(��� �������� ��������� ���)
                                                     THEN lpInsertFind_Container (inContainerDescId:= zc_Container_Count()
                                                                                , inParentId:= NULL
                                                                                , inObjectId:= GoodsId
                                                                                , inJuridicalId_basis:= NULL
                                                                                , inBusinessId       := NULL
                                                                                , inObjectCostDescId := NULL
                                                                                , inObjectCostId     := NULL
                                                                                , inDescId_1   := zc_ContainerLinkObject_Unit()
                                                                                , inObjectId_1 := UnitId
                                                                                , inDescId_2   := zc_ContainerLinkObject_AssetTo()
                                                                                , inObjectId_2 := AssetId
                                                                                 )
                                                  WHEN InfoMoneyDestinationId IN (zc_Enum_InfoMoneyDestination_20700()  -- ������    -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20700()
                                                                                , zc_Enum_InfoMoneyDestination_20900()  -- ����      -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20900()
                                                                                , zc_Enum_InfoMoneyDestination_21000()  -- �����     -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_21000()
                                                                                , zc_Enum_InfoMoneyDestination_21100()  -- �������   -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_21100()
                                                                                , zc_Enum_InfoMoneyDestination_30100()) -- ��������� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30100()
                                                          -- 0)����� 1)������������� 2)��� ������ 3)!!!������ ������!!!
                                                     THEN lpInsertFind_Container (inContainerDescId:= zc_Container_Count()
                                                                                , inParentId:= NULL
                                                                                , inObjectId:= GoodsId
                                                                                , inJuridicalId_basis:= NULL
                                                                                , inBusinessId       := NULL
                                                                                , inObjectCostDescId := NULL
                                                                                , inObjectCostId     := NULL
                                                                                , inDescId_1   := zc_ContainerLinkObject_Unit()
                                                                                , inObjectId_1 := UnitId
                                                                                , inDescId_2   := zc_ContainerLinkObject_GoodsKind()
                                                                                , inObjectId_2 := GoodsKindId
                                                                                , inDescId_3   := CASE WHEN PartionGoodsId <> 0 THEN zc_ContainerLinkObject_PartionGoods() ELSE NULL END
                                                                                , inObjectId_3 := CASE WHEN PartionGoodsId <> 0 THEN PartionGoodsId ELSE NULL END
                                                                                 )
                                                          -- 0)����� 1)�������������
                                                     ELSE lpInsertFind_Container (inContainerDescId:= zc_Container_Count()
                                                                                , inParentId:= NULL
                                                                                , inObjectId:= GoodsId
                                                                                , inJuridicalId_basis:= NULL
                                                                                , inBusinessId       := NULL
                                                                                , inObjectCostDescId := NULL
                                                                                , inObjectCostId     := NULL
                                                                                , inDescId_1   := zc_ContainerLinkObject_Unit()
                                                                                , inObjectId_1 := UnitId
                                                                                 )
                                             END;

     -- 1.1.2. ����������� �������� ��� ��������������� �����
     PERFORM lpInsertUpdate_MovementItemContainer (ioId:= 0
                                                 , inDescId:= zc_MIContainer_Count()
                                                 , inMovementId:= MovementId
                                                 , inMovementItemId:= MovementItemId
                                                 , inParentId:= NULL
                                                 , inContainerId:= ContainerId_Goods -- ��� ���������� ����
                                                 , inAmount:= OperCount
                                                 , inOperDate:= OperDate
                                                 , inIsActive:= TRUE
                                                  )
     FROM _tmpItem;

     -- 1.2.1. ������������ ContainerId_Summ ��� �������� �� ��������� ����� + ����������� ��������� <������� �/�>
     UPDATE _tmpItem SET ContainerId_Summ =                        CASE WHEN InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10100() -- ������ ����� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10100()
                                                                                -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)������������� 2)����� 3)!������ ������! 4)������ ���������� 5)������ ����������(����������� �/�)
                                                                           THEN lpInsertFind_Container (inContainerDescId:= zc_Container_Summ()
                                                                                                      , inParentId:= ContainerId_Goods
                                                                                                      , inObjectId:= lpInsertFind_Object_Account (inAccountGroupId         := zc_Enum_AccountGroup_20000() -- ������ -- select * from gpSelect_Object_AccountGroup ('2') where Id = zc_Enum_AccountGroup_20000()
                                                                                                                                                , inAccountDirectionId     := AccountDirectionId
                                                                                                                                                , inInfoMoneyDestinationId := InfoMoneyDestinationId
                                                                                                                                                , inInfoMoneyId            := NULL
                                                                                                                                                , inUserId                 := vbUserId
                                                                                                                                                 )
                                                                                                      , inJuridicalId_basis:= JuridicalId_basis
                                                                                                      , inBusinessId       := BusinessId
                                                                                                      , inObjectCostDescId := zc_ObjectCost_Basis()
                                                                                                                              -- <������� �/�>: 1.)������� �� ���� 2.)������ 3)������ 4)!�������������! 5)����� 6)!������ ������! 7)������ ���������� 8)������ ����������(����������� �/�)
                                                                                                      , inObjectCostId     := lpInsertFind_ObjectCost (inObjectCostDescId:= zc_ObjectCost_Basis()
                                                                                                                                                     , inDescId_1   := zc_ObjectCostLink_JuridicalBasis()
                                                                                                                                                     , inObjectId_1 := JuridicalId_basis
                                                                                                                                                     , inDescId_2   := zc_ObjectCostLink_Business()
                                                                                                                                                     , inObjectId_2 := BusinessId
                                                                                                                                                     , inDescId_3   := zc_ObjectCostLink_Branch()
                                                                                                                                                     , inObjectId_3 := BranchId_Unit
                                                                                                                                                     , inDescId_4   := zc_ObjectCostLink_Unit()
                                                                                                                                                     , inObjectId_4 := CASE WHEN OperDate >= zc_DateStart_ObjectCostOnUnit() THEN UnitId ELSE NULL END
                                                                                                                                                     , inDescId_5   := zc_ObjectCostLink_Goods()
                                                                                                                                                     , inObjectId_5 := GoodsId
                                                                                                                                                     , inDescId_6   := zc_ObjectCostLink_PartionGoods()
                                                                                                                                                     , inObjectId_6 := CASE WHEN isPartionSumm THEN PartionGoodsId ELSE NULL END
                                                                                                                                                     , inDescId_7   := zc_ObjectCostLink_InfoMoney()
                                                                                                                                                     , inObjectId_7 := InfoMoneyId
                                                                                                                                                     , inDescId_8   := zc_ObjectCostLink_InfoMoneyDetail()
                                                                                                                                                     , inObjectId_8 := CASE WHEN zc_isHistoryCost_byInfoMoneyDetail() THEN InfoMoneyId ELSE 0 END -- CASE WHEN isCorporate THEN InfoMoneyId_isCorporate ELSE InfoMoneyId END
                                                                                                                                                      )
                                                                                                      , inDescId_1   := zc_ContainerLinkObject_Unit()
                                                                                                      , inObjectId_1 := UnitId
                                                                                                      , inDescId_2   := zc_ContainerLinkObject_Goods()
                                                                                                      , inObjectId_2 := GoodsId
                                                                                                      , inDescId_3   := zc_ContainerLinkObject_PartionGoods()
                                                                                                      , inObjectId_3 := CASE WHEN isPartionSumm THEN PartionGoodsId ELSE NULL END
                                                                                                      , inDescId_4   := zc_ContainerLinkObject_InfoMoney()
                                                                                                      , inObjectId_4 := InfoMoneyId
                                                                                                      , inDescId_5   := zc_ContainerLinkObject_InfoMoneyDetail()
                                                                                                      , inObjectId_5 := CASE WHEN zc_isHistoryCost_byInfoMoneyDetail() THEN InfoMoneyId ELSE 0 END -- CASE WHEN isCorporate THEN InfoMoneyId_isCorporate ELSE InfoMoneyId END
                                                                                                       )
                                                                        WHEN InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20100() -- �������� � ������� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20100()
                                                                                -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)������������� 2)����� 3)�������� ��������(��� �������� ��������� ���) 4)������ ���������� 5)������ ����������(����������� �/�)
                                                                           THEN lpInsertFind_Container (inContainerDescId:= zc_Container_Summ()
                                                                                                      , inParentId:= ContainerId_Goods
                                                                                                      , inObjectId:= lpInsertFind_Object_Account (inAccountGroupId         := zc_Enum_AccountGroup_20000() -- ������ -- select * from gpSelect_Object_AccountGroup ('2') where Id = zc_Enum_AccountGroup_20000()
                                                                                                                                                , inAccountDirectionId     := AccountDirectionId
                                                                                                                                                , inInfoMoneyDestinationId := InfoMoneyDestinationId
                                                                                                                                                , inInfoMoneyId            := NULL
                                                                                                                                                , inUserId                 := vbUserId
                                                                                                                                                 )
                                                                                                      , inJuridicalId_basis:= JuridicalId_basis
                                                                                                      , inBusinessId       := BusinessId
                                                                                                      , inObjectCostDescId := zc_ObjectCost_Basis()
                                                                                                                              -- <������� �/�>: 1.)������� �� ���� 2.)������ 3)������ 4)!�������������! 5)����� 6)�������� ��������(��� �������� ��������� ���) 7)������ ���������� 8)������ ����������(����������� �/�)
                                                                                                      , inObjectCostId     := lpInsertFind_ObjectCost (inObjectCostDescId:= zc_ObjectCost_Basis()
                                                                                                                                                     , inDescId_1   := zc_ObjectCostLink_JuridicalBasis()
                                                                                                                                                     , inObjectId_1 := JuridicalId_basis
                                                                                                                                                     , inDescId_2   := zc_ObjectCostLink_Business()
                                                                                                                                                     , inObjectId_2 := BusinessId
                                                                                                                                                     , inDescId_3   := zc_ObjectCostLink_Branch()
                                                                                                                                                     , inObjectId_3 := BranchId_Unit
                                                                                                                                                     , inDescId_4   := zc_ObjectCostLink_Unit()
                                                                                                                                                     , inObjectId_4 := CASE WHEN OperDate >= zc_DateStart_ObjectCostOnUnit() THEN UnitId ELSE NULL END
                                                                                                                                                     , inDescId_5   := zc_ObjectCostLink_Goods()
                                                                                                                                                     , inObjectId_5 := GoodsId
                                                                                                                                                     , inDescId_6   := zc_ObjectCostLink_AssetTo()
                                                                                                                                                     , inObjectId_6 := AssetId
                                                                                                                                                     , inDescId_7   := zc_ObjectCostLink_InfoMoney()
                                                                                                                                                     , inObjectId_7 := InfoMoneyId
                                                                                                                                                     , inDescId_8   := zc_ObjectCostLink_InfoMoneyDetail()
                                                                                                                                                     , inObjectId_8 := CASE WHEN zc_isHistoryCost_byInfoMoneyDetail() THEN InfoMoneyId ELSE 0 END -- CASE WHEN isCorporate THEN InfoMoneyId_isCorporate ELSE InfoMoneyId END
                                                                                                                                                      )
                                                                                                      , inDescId_1   := zc_ContainerLinkObject_Unit()
                                                                                                      , inObjectId_1 := UnitId
                                                                                                      , inDescId_2   := zc_ContainerLinkObject_Goods()
                                                                                                      , inObjectId_2 := GoodsId
                                                                                                      , inDescId_3   := zc_ContainerLinkObject_AssetTo()
                                                                                                      , inObjectId_3 := AssetId
                                                                                                      , inDescId_4   := zc_ContainerLinkObject_InfoMoney()
                                                                                                      , inObjectId_4 := InfoMoneyId
                                                                                                      , inDescId_5   := zc_ContainerLinkObject_InfoMoneyDetail()
                                                                                                      , inObjectId_5 := CASE WHEN zc_isHistoryCost_byInfoMoneyDetail() THEN InfoMoneyId ELSE 0 END -- CASE WHEN isCorporate THEN InfoMoneyId_isCorporate ELSE InfoMoneyId END
                                                                                                       )
                                                                        WHEN InfoMoneyDestinationId IN (zc_Enum_InfoMoneyDestination_20700()  -- ������    -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20700()
                                                                                                      , zc_Enum_InfoMoneyDestination_20900()  -- ����      -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20900()
                                                                                                      , zc_Enum_InfoMoneyDestination_21000()  -- �����     -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_21000()
                                                                                                      , zc_Enum_InfoMoneyDestination_21100()  -- �������   -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_21100()
                                                                                                      , zc_Enum_InfoMoneyDestination_30100()) -- ��������� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30100()
                                                                                -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)������������� 2)����� 3)!!!������ ������!!! 4)���� ������� 5)������ ���������� 6)������ ����������(����������� �/�)
                                                                           THEN lpInsertFind_Container (inContainerDescId:= zc_Container_Summ()
                                                                                                      , inParentId:= ContainerId_Goods
                                                                                                      , inObjectId:= lpInsertFind_Object_Account (inAccountGroupId         := zc_Enum_AccountGroup_20000() -- ������ -- select * from gpSelect_Object_AccountGroup ('2') where Id = zc_Enum_AccountGroup_20000()
                                                                                                                                                , inAccountDirectionId     := AccountDirectionId
                                                                                                                                                , inInfoMoneyDestinationId := InfoMoneyDestinationId
                                                                                                                                                , inInfoMoneyId            := NULL
                                                                                                                                                , inUserId                 := vbUserId
                                                                                                                                                 )
                                                                                                      , inJuridicalId_basis:= JuridicalId_basis
                                                                                                      , inBusinessId       := BusinessId
                                                                                                      , inObjectCostDescId := zc_ObjectCost_Basis()
                                                                                                                              -- <������� �/�>: 1.)������� �� ���� 2.)������ 3)������ 4)������������� 5)����� 6)!!!������ ������!!! 7)���� ������� 8)������ ���������� 9)������ ����������(����������� �/�)
                                                                                                      , inObjectCostId     := lpInsertFind_ObjectCost (inObjectCostDescId:= zc_ObjectCost_Basis()
                                                                                                                                                     , inDescId_1   := zc_ObjectCostLink_JuridicalBasis()
                                                                                                                                                     , inObjectId_1 := JuridicalId_basis
                                                                                                                                                     , inDescId_2   := zc_ObjectCostLink_Business()
                                                                                                                                                     , inObjectId_2 := BusinessId
                                                                                                                                                     , inDescId_3   := zc_ObjectCostLink_Branch()
                                                                                                                                                     , inObjectId_3 := BranchId_Unit
                                                                                                                                                     , inDescId_4   := zc_ObjectCostLink_Unit()
                                                                                                                                                     , inObjectId_4 := UnitId
                                                                                                                                                     , inDescId_5   := zc_ObjectCostLink_Goods()
                                                                                                                                                     , inObjectId_5 := GoodsId
                                                                                                                                                     , inDescId_6   := CASE WHEN PartionGoodsId <> 0 THEN zc_ObjectCostLink_PartionGoods() ELSE NULL END
                                                                                                                                                     , inObjectId_6 := CASE WHEN PartionGoodsId <> 0 THEN PartionGoodsId ELSE NULL END
                                                                                                                                                     , inDescId_7   := zc_ObjectCostLink_GoodsKind()
                                                                                                                                                     , inObjectId_7 := GoodsKindId
                                                                                                                                                     , inDescId_8   := zc_ObjectCostLink_InfoMoney()
                                                                                                                                                     , inObjectId_8 := InfoMoneyId
                                                                                                                                                     , inDescId_9   := zc_ObjectCostLink_InfoMoneyDetail()
                                                                                                                                                     , inObjectId_9 := CASE WHEN zc_isHistoryCost_byInfoMoneyDetail() THEN InfoMoneyId ELSE 0 END -- CASE WHEN isCorporate THEN InfoMoneyId_isCorporate ELSE InfoMoneyId END
                                                                                                                                                      )
                                                                                                      , inDescId_1   := zc_ContainerLinkObject_Unit()
                                                                                                      , inObjectId_1 := UnitId
                                                                                                      , inDescId_2   := zc_ContainerLinkObject_Goods()
                                                                                                      , inObjectId_2 := GoodsId
                                                                                                      , inDescId_3   := CASE WHEN PartionGoodsId <> 0 THEN zc_ContainerLinkObject_PartionGoods() ELSE NULL END
                                                                                                      , inObjectId_3 := CASE WHEN PartionGoodsId <> 0 THEN PartionGoodsId ELSE NULL END
                                                                                                      , inDescId_4   := zc_ContainerLinkObject_GoodsKind()
                                                                                                      , inObjectId_4 := GoodsKindId
                                                                                                      , inDescId_5   := zc_ContainerLinkObject_InfoMoney()
                                                                                                      , inObjectId_5 := InfoMoneyId
                                                                                                      , inDescId_6   := zc_ContainerLinkObject_InfoMoneyDetail()
                                                                                                      , inObjectId_6 := CASE WHEN zc_isHistoryCost_byInfoMoneyDetail() THEN InfoMoneyId ELSE 0 END -- CASE WHEN isCorporate THEN InfoMoneyId_isCorporate ELSE InfoMoneyId END
                                                                                                       )
                                                                                -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)������������� 2)����� 3)������ ���������� 4)������ ����������(����������� �/�)
                                                                           ELSE lpInsertFind_Container (inContainerDescId:= zc_Container_Summ()
                                                                                                      , inParentId:= ContainerId_Goods
                                                                                                      , inObjectId:= lpInsertFind_Object_Account (inAccountGroupId         := zc_Enum_AccountGroup_20000() -- ������ -- select * from gpSelect_Object_AccountGroup ('2') where Id = zc_Enum_AccountGroup_20000()
                                                                                                                                                , inAccountDirectionId     := AccountDirectionId
                                                                                                                                                , inInfoMoneyDestinationId := InfoMoneyDestinationId
                                                                                                                                                , inInfoMoneyId            := NULL
                                                                                                                                                , inUserId                 := vbUserId
                                                                                                                                                 )
                                                                                                      , inJuridicalId_basis:= JuridicalId_basis
                                                                                                      , inBusinessId       := BusinessId
                                                                                                      , inObjectCostDescId := zc_ObjectCost_Basis()
                                                                                                                              -- <������� �/�>: 1.)������� �� ���� 2.)������ 3)������ 4)!!!�������������!!! 5)����� 6)������ ���������� 7)������ ����������(����������� �/�)
                                                                                                      , inObjectCostId     := lpInsertFind_ObjectCost (inObjectCostDescId:= zc_ObjectCost_Basis()
                                                                                                                                                     , inDescId_1   := zc_ObjectCostLink_JuridicalBasis()
                                                                                                                                                     , inObjectId_1 := JuridicalId_basis
                                                                                                                                                     , inDescId_2   := zc_ObjectCostLink_Business()
                                                                                                                                                     , inObjectId_2 := BusinessId
                                                                                                                                                     , inDescId_3   := zc_ObjectCostLink_Branch()
                                                                                                                                                     , inObjectId_3 := BranchId_Unit
                                                                                                                                                     , inDescId_4   := zc_ObjectCostLink_Unit()
                                                                                                                                                     , inObjectId_4 := CASE WHEN OperDate >= zc_DateStart_ObjectCostOnUnit() THEN UnitId ELSE NULL END
                                                                                                                                                     , inDescId_5   := zc_ObjectCostLink_Goods()
                                                                                                                                                     , inObjectId_5 := GoodsId
                                                                                                                                                     , inDescId_6   := zc_ObjectCostLink_InfoMoney()
                                                                                                                                                     , inObjectId_6 := InfoMoneyId
                                                                                                                                                     , inDescId_7   := zc_ObjectCostLink_InfoMoneyDetail()
                                                                                                                                                     , inObjectId_7 := CASE WHEN zc_isHistoryCost_byInfoMoneyDetail() THEN InfoMoneyId ELSE 0 END -- CASE WHEN isCorporate THEN InfoMoneyId_isCorporate ELSE InfoMoneyId END
                                                                                                                                                      )
                                                                                                      , inDescId_1   := zc_ContainerLinkObject_Unit()
                                                                                                      , inObjectId_1 := UnitId
                                                                                                      , inDescId_2   := zc_ContainerLinkObject_Goods()
                                                                                                      , inObjectId_2 := GoodsId
                                                                                                      , inDescId_3   := zc_ContainerLinkObject_InfoMoney()
                                                                                                      , inObjectId_3 := InfoMoneyId
                                                                                                      , inDescId_4   := zc_ContainerLinkObject_InfoMoneyDetail()
                                                                                                      , inObjectId_4 := CASE WHEN zc_isHistoryCost_byInfoMoneyDetail() THEN InfoMoneyId ELSE 0 END -- CASE WHEN isCorporate THEN InfoMoneyId_isCorporate ELSE InfoMoneyId END
                                                                                                       )
                                                                   END
     WHERE zc_isHistoryCost() = TRUE;

     -- 1.2.2. ����������� �������� ��� ��������� �����
     PERFORM lpInsertUpdate_MovementItemContainer (ioId:= 0
                                                 , inDescId:= zc_MIContainer_Summ()
                                                 , inMovementId:= MovementId
                                                 , inMovementItemId:= MovementItemId
                                                 , inParentId:= NULL
                                                 , inContainerId:= ContainerId_Summ
                                                 , inAmount:= OperSumm_Partner + OperSumm_Packer
                                                 , inOperDate:= OperDate
                                                 , inIsActive:= TRUE
                                                  )
     FROM _tmpItem
     WHERE zc_isHistoryCost() = TRUE;


     -- 2.1. ������������ ContainerId ��� �������� �� ���� ���������� ��� ���������� (����������� ����)
     UPDATE _tmpItem_SummPartner SET ContainerId =                 CASE WHEN InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10100() -- ������ ����� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10100()
                                                                         AND PersonalId_From = 0
                                                                         AND NOT isCorporate
                                                                                -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)����������� ���� 2)���� ���� ������ 3)�������� 4)������ ���������� 5)������ ���������
                                                                           THEN lpInsertFind_Container (inContainerDescId:= zc_Container_Summ()
                                                                                                      , inParentId:= NULL
                                                                                                      , inObjectId:= lpInsertFind_Object_Account (inAccountGroupId         := zc_Enum_AccountGroup_70000() -- ��������� -- select * from gpSelect_Object_AccountGroup ('2') where Id in (zc_Enum_AccountGroup_70000())
                                                                                                                                                , inAccountDirectionId     := zc_Enum_AccountDirection_70100() -- ���������� -- select * from gpSelect_Object_AccountDirection ('2') where Id in (zc_Enum_AccountDirection_70100())
                                                                                                                                                , inInfoMoneyDestinationId := InfoMoneyDestinationId
                                                                                                                                                , inInfoMoneyId            := NULL
                                                                                                                                                , inUserId                 := vbUserId
                                                                                                                                                 )
                                                                                                      , inJuridicalId_basis:= JuridicalId_basis
                                                                                                      , inBusinessId       := BusinessId
                                                                                                      , inObjectCostDescId := NULL
                                                                                                      , inObjectCostId     := NULL
                                                                                                      , inDescId_1   := zc_ContainerLinkObject_Juridical()
                                                                                                      , inObjectId_1 := JuridicalId_From
                                                                                                      , inDescId_2   := zc_ContainerLinkObject_PaidKind()
                                                                                                      , inObjectId_2 := PaidKindId
                                                                                                      , inDescId_3   := zc_ContainerLinkObject_Contract()
                                                                                                      , inObjectId_3 := ContractId
                                                                                                      , inDescId_4   := zc_ContainerLinkObject_InfoMoney()
                                                                                                      , inObjectId_4 := InfoMoneyId
                                                                                                      , inDescId_5   := zc_ContainerLinkObject_PartionMovement()
                                                                                                      , inObjectId_5 := PartionMovementId
                                                                                                       )
                                                                                -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)����������� ���� 2)���� ���� ������ 3)�������� 4)������ ����������
                                                                                -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)����������(����������� ����) 2)NULL 3)NULL 4)������ ����������
                                                                           ELSE lpInsertFind_Container (inContainerDescId:= zc_Container_Summ()
                                                                                                      , inParentId:= NULL
                                                                                                      , inObjectId:= lpInsertFind_Object_Account (inAccountGroupId         := CASE WHEN PersonalId_From <> 0 THEN zc_Enum_AccountGroup_30000() WHEN isCorporate THEN zc_Enum_AccountGroup_30000() ELSE zc_Enum_AccountGroup_70000() END -- then �������� then �������� else ��������� -- select * from gpSelect_Object_AccountGroup ('2') where Id in (zc_Enum_AccountGroup_30000(), zc_Enum_AccountGroup_30000(), zc_Enum_AccountGroup_70000())
                                                                                                                                                , inAccountDirectionId     := CASE WHEN PersonalId_From <> 0 THEN zc_Enum_AccountDirection_30500() WHEN isCorporate THEN zc_Enum_AccountDirection_30200() ELSE zc_Enum_AccountDirection_70100() END -- then ���������� (����������� ����) then ���� �������� else ���������� -- select * from gpSelect_Object_AccountDirection ('2') where Id in (zc_Enum_AccountDirection_30500(), zc_Enum_AccountDirection_30200(), zc_Enum_AccountDirection_70100())
                                                                                                                                                , inInfoMoneyDestinationId := CASE WHEN isCorporate THEN InfoMoneyDestinationId_isCorporate ELSE InfoMoneyDestinationId END
                                                                                                                                                , inInfoMoneyId            := NULL
                                                                                                                                                , inUserId                 := vbUserId
                                                                                                                                                 )
                                                                                                      , inJuridicalId_basis:= JuridicalId_basis
                                                                                                      , inBusinessId       := BusinessId
                                                                                                      , inObjectCostDescId := NULL
                                                                                                      , inObjectCostId     := NULL
                                                                                                      , inDescId_1   := CASE WHEN PersonalId_From <> 0 THEN zc_ContainerLinkObject_Personal() ELSE zc_ContainerLinkObject_Juridical() END
                                                                                                      , inObjectId_1 := CASE WHEN PersonalId_From <> 0 THEN PersonalId_From ELSE JuridicalId_From END
                                                                                                      , inDescId_2   := CASE WHEN PersonalId_From <> 0 THEN NULL ELSE zc_ContainerLinkObject_PaidKind() END
                                                                                                      , inObjectId_2 := PaidKindId
                                                                                                      , inDescId_3   := CASE WHEN PersonalId_From <> 0 THEN NULL ELSE zc_ContainerLinkObject_Contract() END
                                                                                                      , inObjectId_3 := ContractId
                                                                                                      , inDescId_4   := zc_ContainerLinkObject_InfoMoney()
                                                                                                      , inObjectId_4 := InfoMoneyId -- CASE WHEN isCorporate THEN InfoMoneyId_isCorporate ELSE InfoMoneyId END
                                                                                                       )
                                                                   END
     ;

     -- 2.2. ����������� �������� - ���� ���������� ��� ���������� (����������� ����)
     PERFORM lpInsertUpdate_MovementItemContainer (ioId:= 0
                                                 , inDescId:= zc_MIContainer_Summ()
                                                 , inMovementId:= MovementId
                                                 , inMovementItemId:= NULL
                                                 , inParentId:= NULL
                                                 , inContainerId:= ContainerId
                                                 , inAmount:= -1 * OperSumm_Partner
                                                 , inOperDate:= OperDate
                                                 , inIsActive:= FALSE
                                                  )
     FROM _tmpItem_SummPartner;


     -- 3.1. ������������ ContainerId ��� �������� �� ������� ������������
     UPDATE _tmpItem_SummPacker SET ContainerId = 
                                                  -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1) ����������(����������) 3)������ ����������
                                                  lpInsertFind_Container (inContainerDescId:= zc_Container_Summ()
                                                                        , inParentId:= NULL
                                                                        , inObjectId:= lpInsertFind_Object_Account (inAccountGroupId         := zc_Enum_AccountGroup_70000() -- ��������� -- select * from gpSelect_Object_AccountGroup ('2') where Id in (zc_Enum_AccountGroup_70000())
                                                                                                                  , inAccountDirectionId     := zc_Enum_AccountDirection_70600() -- ���������� (������������) -- select * from gpSelect_Object_AccountDirection ('2') where Id in (zc_Enum_AccountDirection_70600())
                                                                                                                  , inInfoMoneyDestinationId := InfoMoneyDestinationId
                                                                                                                  , inInfoMoneyId            := NULL
                                                                                                                  , inUserId                 := vbUserId
                                                                                                                   )
                                                                        , inJuridicalId_basis:= JuridicalId_basis
                                                                        , inBusinessId       := BusinessId
                                                                        , inObjectCostDescId := NULL
                                                                        , inObjectCostId     := NULL
                                                                        , inDescId_1   := zc_ContainerLinkObject_Personal()
                                                                        , inObjectId_1 := PersonalId_Packer
                                                                        , inDescId_2   := zc_ContainerLinkObject_InfoMoney()
                                                                        , inObjectId_2 := InfoMoneyId
                                                                        );

     -- 3.2. ����������� �������� - ������� ������������
     PERFORM lpInsertUpdate_MovementItemContainer (ioId:= 0
                                                 , inDescId:= zc_MIContainer_Summ()
                                                 , inMovementId:= MovementId
                                                 , inMovementItemId:= NULL -- MovementItemId
                                                 , inParentId:= NULL
                                                 , inContainerId:= ContainerId
                                                 , inAmount:= -1 * OperSumm_Packer
                                                 , inOperDate:= OperDate
                                                 , inIsActive:= FALSE
                                                  )
     FROM _tmpItem_SummPacker;


     -- 4.1. ����������� �������� ��� ������ (���������: ����� � ��������� ��� ��������� (����������� ����))
     PERFORM lpInsertUpdate_MovementItemReport (inMovementId := _tmpItem.MovementId
                                              , inMovementItemId := _tmpItem.MovementItemId
                                              , inReportContainerId := lpInsertFind_ReportContainer (inContainerId_Active  := _tmpItem.ContainerId_Summ
                                                                                                   , inContainerId_Passive := _tmpItem_SummPartner.ContainerId
                                                                                                   , inIsActive_1          := NULL
                                                                                                   , inContainerId_1       := NULL
                                                                                                    )
                                              , inAmount := _tmpItem.OperSumm_Partner
                                              , inOperDate := _tmpItem.OperDate
                                               )
     FROM _tmpItem
          LEFT JOIN _tmpItem_SummPartner ON _tmpItem_SummPartner.MovementId = _tmpItem.MovementId
                                        AND _tmpItem_SummPartner.OperDate = _tmpItem.OperDate
                                        AND _tmpItem_SummPartner.JuridicalId_From = _tmpItem.JuridicalId_From
                                        AND _tmpItem_SummPartner.isCorporate = _tmpItem.isCorporate
                                        AND _tmpItem_SummPartner.PersonalId_From = _tmpItem.PersonalId_From
                                        AND _tmpItem_SummPartner.PaidKindId = _tmpItem.PaidKindId
                                        AND _tmpItem_SummPartner.ContractId = _tmpItem.ContractId
                                        AND _tmpItem_SummPartner.InfoMoneyDestinationId = _tmpItem.InfoMoneyDestinationId
                                        AND _tmpItem_SummPartner.InfoMoneyId = _tmpItem.InfoMoneyId
                                        AND _tmpItem_SummPartner.InfoMoneyDestinationId_isCorporate = _tmpItem.InfoMoneyDestinationId_isCorporate
                                        AND _tmpItem_SummPartner.InfoMoneyId_isCorporate = _tmpItem.InfoMoneyId_isCorporate
                                        AND _tmpItem_SummPartner.JuridicalId_basis = _tmpItem.JuridicalId_basis
                                        AND _tmpItem_SummPartner.BusinessId = _tmpItem.BusinessId
                                        AND _tmpItem_SummPartner.PartionMovementId = _tmpItem.PartionMovementId
     WHERE _tmpItem.OperSumm_Partner <> 0 OR _tmpItem.OperSumm_Packer <> 0;

     -- 4.2. ����������� �������� ��� ������ (���������: ����� � ������������)
     PERFORM lpInsertUpdate_MovementItemReport (inMovementId := _tmpItem.MovementId
                                              , inMovementItemId := _tmpItem.MovementItemId
                                              , inReportContainerId := lpInsertFind_ReportContainer (inContainerId_Active  := _tmpItem.ContainerId_Summ
                                                                                                   , inContainerId_Passive := _tmpItem_SummPacker.ContainerId
                                                                                                   , inIsActive_1          := NULL
                                                                                                   , inContainerId_1       := NULL
                                                                                                    )
                                              , inAmount := _tmpItem.OperSumm_Packer
                                              , inOperDate := _tmpItem.OperDate
                                               )
     FROM _tmpItem
          LEFT JOIN _tmpItem_SummPacker ON _tmpItem_SummPacker.MovementId = _tmpItem.MovementId
                                       AND _tmpItem_SummPacker.OperDate = _tmpItem.OperDate
                                       AND _tmpItem_SummPacker.PersonalId_Packer = _tmpItem.PersonalId_Packer
                                       AND _tmpItem_SummPacker.InfoMoneyDestinationId = _tmpItem.InfoMoneyDestinationId
                                       AND _tmpItem_SummPacker.InfoMoneyId = _tmpItem.InfoMoneyId
                                       AND _tmpItem_SummPacker.JuridicalId_basis = _tmpItem.JuridicalId_basis
                                       AND _tmpItem_SummPacker.BusinessId = _tmpItem.BusinessId
     WHERE _tmpItem.OperSumm_Packer <> 0;


     -- 5. ����� - ����������� ������ ������ ���������
     UPDATE Movement SET StatusId = zc_Enum_Status_Complete() WHERE Id = inMovementId AND DescId = zc_Movement_Income() AND StatusId = zc_Enum_Status_UnComplete();


END;
$BODY$
LANGUAGE PLPGSQL VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 29.08.13                                        * add lpInsertUpdate_MovementItemReport
 09.08.13                                        * add zc_isHistoryCost and zc_isHistoryCost_byInfoMoneyDetail
 07.08.13                                        * add inParentId and inIsActive
 05.08.13                                        * no InfoMoneyId_isCorporate
 20.07.13                                        * add MovementItemId
 20.07.13                                        * all ������ ������, ���� ���� ...
 19.07.13                                        * all
 12.07.13                                        * add PartionGoods
 11.07.13                                        * add ObjectCost
 04.07.13                                        * ! finich !
 02.07.13                                        *
*/

-- ����
-- SELECT * FROM gpUnComplete_Movement (inMovementId:= 55, inSession:= '2')
-- SELECT * FROM gpComplete_Movement_Income (inMovementId:= 55, inIsLastComplete:= FALSE, inSession:= '2')
-- SELECT * FROM gpSelect_MovementItemContainer_Movement (inMovementId:= 55, inSession:= '2')
