-- Function: gpComplete_Movement_ProductionSeparate()

-- DROP FUNCTION gpComplete_Movement_ProductionSeparate (Integer, TVarChar);
-- DROP FUNCTION gpComplete_Movement_ProductionSeparate (Integer, Boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpComplete_Movement_ProductionSeparate(
    IN inMovementId        Integer              , -- ���� ���������
    IN inIsLastComplete    Boolean DEFAULT False, -- ��� ��������� ���������� ����� ������� �/� (��� ������� �������� !!!�� ��������������!!!)
    IN inSession           TVarChar DEFAULT ''     -- ������ ������������
)                              
RETURNS VOID
-- RETURNS TABLE (MovementItemId Integer, MovementId Integer, OperDate TDateTime, UnitId_From Integer, PersonalId_From Integer, ContainerId_GoodsFrom Integer, GoodsId Integer, GoodsKindId Integer, AssetId Integer, PartionGoods TVarChar, PartionGoodsDate TDateTime, OperCount TFloat, AccountDirectionId_From Integer, InfoMoneyDestinationId Integer, InfoMoneyId Integer, isPartionCount Boolean, isPartionSumm Boolean, isPartionDate Boolean, PartionGoodsId Integer)
-- RETURNS TABLE (MovementItemId Integer, MovementId Integer, OperDate TDateTime, UnitId_To Integer, PersonalId_To Integer, BranchId_To Integer, ContainerId_GoodsTo Integer, GoodsId Integer, GoodsKindId Integer, AssetId Integer, PartionGoods TVarChar, PartionGoodsDate TDateTime, OperCount TFloat, tmpOperSumm TFloat, AccountDirectionId_To Integer, InfoMoneyDestinationId Integer, InfoMoneyId Integer, JuridicalId_basis_To Integer, BusinessId_To Integer, isPartionCount Boolean, isPartionSumm Boolean, isPartionDate Boolean, PartionGoodsId Integer)

-- RETURNS TABLE (MovementItemId Integer, ContainerId_From Integer, OperSumm TFloat, InfoMoneyId_Detail_From Integer)
-- RETURNS TABLE (MovementItemId Integer, OperSumm TFloat, InfoMoneyId_Detail_To Integer)
AS
$BODY$
  DECLARE vbUserId Integer;
  DECLARE vbOperDate TDateTime;
  DECLARE vbTotalSummChild TFloat;
  DECLARE vbOperSumm TFloat;
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Complete_Movement_Income());
     vbUserId:=2; -- CAST (inSession AS Integer);


     -- ��� ��������� ����� ��� ...
     vbOperDate := (SELECT Movement.OperDate FROM Movement WHERE Movement.Id = inMovementId);


     -- ������� - ��������� �������
     CREATE TEMP TABLE _tmpContainer (DescId Integer, ObjectId Integer) ON COMMIT DROP;
     -- ������� - ��������� <������� �/�>
     CREATE TEMP TABLE _tmpObjectCost (DescId Integer, ObjectId Integer) ON COMMIT DROP;

     -- ������� - �������������� Master-�������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     CREATE TEMP TABLE _tmpItem (MovementItemId Integer, MovementId Integer, OperDate TDateTime, UnitId_From Integer, PersonalId_From Integer
                               , ContainerId_GoodsFrom Integer, GoodsId Integer, GoodsKindId Integer, AssetId Integer, PartionGoods TVarChar, PartionGoodsDate TDateTime
                               , OperCount TFloat
                               , AccountDirectionId_From Integer, InfoMoneyDestinationId Integer, InfoMoneyId Integer
                               , isPartionCount Boolean, isPartionSumm Boolean, isPartionDate Boolean
                               , PartionGoodsId Integer) ON COMMIT DROP;
     -- ������� - �������� Master-�������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     CREATE TEMP TABLE _tmpItemSumm (MovementItemId Integer, ContainerId_From Integer, OperSumm TFloat, InfoMoneyId_Detail_From Integer) ON COMMIT DROP;
     -- ������� - ���������� �������� Master-�������� ���������
     CREATE TEMP TABLE _tmpItemSummTotal (MovementItemId Integer, InfoMoneyId_Detail_From Integer, OperSumm TFloat) ON COMMIT DROP;

     -- ������� - �������������� Child-�������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     CREATE TEMP TABLE _tmpItemChild (MovementItemId Integer, MovementId Integer, OperDate TDateTime, UnitId_To Integer, PersonalId_To Integer, BranchId_To Integer
                                    , ContainerId_GoodsTo Integer, GoodsId Integer, GoodsKindId Integer, AssetId Integer, PartionGoods TVarChar, PartionGoodsDate TDateTime
                                    , OperCount TFloat, tmpOperSumm TFloat
                                    , AccountDirectionId_To Integer, InfoMoneyDestinationId Integer, InfoMoneyId Integer
                                    , JuridicalId_basis_To Integer, BusinessId_To Integer
                                    , isPartionCount Boolean, isPartionSumm Boolean, isPartionDate Boolean
                                    , PartionGoodsId Integer) ON COMMIT DROP;
     -- ������� - �������� Child-�������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     CREATE TEMP TABLE _tmpItemSummChild (MovementItemId_Parent Integer, MovementItemId Integer, MIContainerId_To Integer, InfoMoneyId_Detail_To Integer, OperSumm TFloat) ON COMMIT DROP;
     -- ������� - ���������� �������� Child-�������� ���������
     CREATE TEMP TABLE _tmpItemSummChildTotal (MovementItemId_Parent Integer, InfoMoneyId_Detail_To Integer, OperSumm TFloat) ON COMMIT DROP;


     -- ��������� ������� - �������������� Child-�������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     INSERT INTO _tmpItemChild (MovementItemId, MovementId, OperDate, UnitId_To, PersonalId_To, BranchId_To
                              , ContainerId_GoodsTo, GoodsId, GoodsKindId, AssetId, PartionGoods, PartionGoodsDate
                              , OperCount, tmpOperSumm
                              , AccountDirectionId_To, InfoMoneyDestinationId, InfoMoneyId
                              , JuridicalId_basis_To, BusinessId_To
                              , isPartionCount, isPartionSumm, isPartionDate
                              , PartionGoodsId)
        SELECT
              _tmp.MovementItemId
            , _tmp.MovementId
            , _tmp.OperDate
            , _tmp.UnitId_To
            , _tmp.PersonalId_To
            , _tmp.BranchId_To

            , 0 AS ContainerId_GoodsTo
            , _tmp.GoodsId
            , _tmp.GoodsKindId
            , _tmp.AssetId
            , _tmp.PartionGoods
            , _tmp.PartionGoodsDate

            , _tmp.OperCount
            , _tmp.tmpOperSumm

              -- ��������� ������ - ����������� (����)
            , _tmp.AccountDirectionId_To
              -- �������������� ����������
            , _tmp.InfoMoneyDestinationId
              -- ������ ����������
            , _tmp.InfoMoneyId

            , _tmp.JuridicalId_basis_To
            , _tmp.BusinessId_To

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
                  , COALESCE (CASE WHEN Object_To.DescId = zc_Object_Unit() THEN MovementLinkObject_To.ObjectId ELSE 0 END, 0) AS UnitId_To
                  , COALESCE (CASE WHEN Object_To.DescId = zc_Object_Personal() THEN MovementLinkObject_To.ObjectId ELSE 0 END, 0) AS PersonalId_To
                  , COALESCE (CASE WHEN Object_To.DescId = zc_Object_Unit() THEN ObjectLink_UnitTo_Branch.ChildObjectId WHEN Object_To.DescId = zc_Object_Personal() THEN ObjectLink_UnitPersonalTo_Branch.ChildObjectId ELSE 0 END, 0) AS BranchId_To

                  , MovementItem.ObjectId AS GoodsId
                  , COALESCE (MILinkObject_GoodsKind.ObjectId, 0) AS GoodsKindId
                  , COALESCE (MILinkObject_Asset.ObjectId, 0) AS AssetId
                  , COALESCE (MovementString_PartionGoods.ValueData, '') AS PartionGoods
                  , COALESCE (MIDate_PartionGoods.ValueData, zc_DateEnd()) AS PartionGoodsDate

                  , MovementItem.Amount AS OperCount
                  , COALESCE (MovementItem.Amount * lfObjectHistory_PriceListItem.ValuePrice, 0) AS tmpOperSumm

                  -- ��������� ������ - ����������� (����)
                  , COALESCE (CASE WHEN Object_To.DescId = zc_Object_Unit()
                                       THEN ObjectLink_UnitTo_AccountDirection.ChildObjectId
                                   WHEN Object_To.DescId = zc_Object_Personal()
                                       THEN CASE WHEN lfObject_InfoMoney.InfoMoneyDestinationId IN (zc_Enum_InfoMoneyDestination_10100() -- "�������� �����"; 10100; "������ �����"
                                                                                                  , zc_Enum_InfoMoneyDestination_20700() -- "�������������"; 20700; "������"
                                                                                                  , zc_Enum_InfoMoneyDestination_30100() -- "������"; 30100; "���������"
                                                                                                   )
                                                     THEN 0 -- !!!�� ���� �� ����� �� ����� ����!!! zc_Enum_AccountDirection_20600() -- "������"; 20600; "���������� (�����������)"
                                                 ELSE zc_Enum_AccountDirection_20500() -- "������"; 20500; "���������� (��)"
                                            END
                              END, 0) AS AccountDirectionId_To
                  -- �������������� ����������
                  , COALESCE (lfObject_InfoMoney.InfoMoneyDestinationId, 0) AS InfoMoneyDestinationId
                  -- ������ ����������
                  , COALESCE (lfObject_InfoMoney.InfoMoneyId, 0) AS InfoMoneyId

                  , COALESCE (CASE WHEN Object_To.DescId = zc_Object_Unit() THEN ObjectLink_UnitTo_Juridical.ChildObjectId WHEN Object_To.DescId = zc_Object_Personal() THEN ObjectLink_UnitPersonalTo_Juridical.ChildObjectId ELSE 0 END, 0) AS JuridicalId_basis_To
                  , COALESCE (CASE WHEN Object_To.DescId = zc_Object_Unit() THEN ObjectLink_UnitTo_Business.ChildObjectId WHEN Object_To.DescId = zc_Object_Personal() THEN ObjectLink_UnitPersonalTo_Business.ChildObjectId ELSE 0 END, 0) AS BusinessId_To

                  , COALESCE (ObjectBoolean_PartionCount.ValueData, FALSE)     AS isPartionCount
                  , COALESCE (ObjectBoolean_PartionSumm.ValueData, FALSE)      AS isPartionSumm
                  , COALESCE (ObjectBoolean_PartionDate.ValueData, FALSE)      AS isPartionDate

              FROM Movement
                   JOIN MovementItem ON MovementItem.MovementId = Movement.Id AND MovementItem.DescId = zc_MI_Child() AND MovementItem.isErased = FALSE

                   LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                                    ON MILinkObject_GoodsKind.MovementItemId = MovementItem.Id
                                                   AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()
                   LEFT JOIN MovementItemLinkObject AS MILinkObject_Asset
                                                    ON MILinkObject_Asset.MovementItemId = MovementItem.Id
                                                   AND MILinkObject_Asset.DescId = zc_MILinkObject_Asset()

                   LEFT JOIN MovementItemDate AS MIDate_PartionGoods
                                              ON MIDate_PartionGoods.MovementItemId = MovementItem.Id
                                             AND MIDate_PartionGoods.DescId = zc_MIDate_PartionGoods()
                   LEFT JOIN MovementString AS MovementString_PartionGoods
                                            ON MovementString_PartionGoods.MovementId = MovementItem.MovementId
                                           AND MovementString_PartionGoods.DescId = zc_MovementString_PartionGoods()

                   LEFT JOIN MovementLinkObject AS MovementLinkObject_To
                                                ON MovementLinkObject_To.MovementId = MovementItem.MovementId
                                               AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
                   LEFT JOIN Object AS Object_To ON Object_To.Id = MovementLinkObject_To.ObjectId


                   LEFT JOIN ObjectLink AS ObjectLink_UnitTo_AccountDirection
                                        ON ObjectLink_UnitTo_AccountDirection.ObjectId = MovementLinkObject_To.ObjectId
                                       AND ObjectLink_UnitTo_AccountDirection.DescId = zc_ObjectLink_Unit_AccountDirection()
                                       AND Object_To.DescId = zc_Object_Unit()
                   LEFT JOIN ObjectLink AS ObjectLink_UnitTo_Branch
                                        ON ObjectLink_UnitTo_Branch.ObjectId = MovementLinkObject_To.ObjectId
                                       AND ObjectLink_UnitTo_Branch.DescId = zc_ObjectLink_Unit_Branch()
                                       AND Object_To.DescId = zc_Object_Unit()
                   LEFT JOIN ObjectLink AS ObjectLink_UnitTo_Juridical
                                        ON ObjectLink_UnitTo_Juridical.ObjectId = MovementLinkObject_To.ObjectId
                                       AND ObjectLink_UnitTo_Juridical.DescId = zc_ObjectLink_Unit_Juridical()
                                       AND Object_To.DescId = zc_Object_Unit()
                   LEFT JOIN ObjectLink AS ObjectLink_UnitTo_Business
                                        ON ObjectLink_UnitTo_Business.ObjectId = MovementLinkObject_To.ObjectId
                                       AND ObjectLink_UnitTo_Business.DescId = zc_ObjectLink_Unit_Business()
                                       AND Object_To.DescId = zc_Object_Unit()

                   LEFT JOIN ObjectLink AS ObjectLink_PersonalTo_Unit
                                        ON ObjectLink_PersonalTo_Unit.ObjectId = MovementLinkObject_To.ObjectId
                                       AND ObjectLink_PersonalTo_Unit.DescId = zc_ObjectLink_Personal_Unit()
                                       AND Object_To.DescId = zc_Object_Personal()
                   LEFT JOIN ObjectLink AS ObjectLink_UnitPersonalTo_Branch
                                        ON ObjectLink_UnitPersonalTo_Branch.ObjectId = ObjectLink_PersonalTo_Unit.ChildObjectId
                                       AND ObjectLink_UnitPersonalTo_Branch.DescId = zc_ObjectLink_Unit_Branch()
                                       AND Object_To.DescId = zc_Object_Personal()
                   LEFT JOIN ObjectLink AS ObjectLink_UnitPersonalTo_Juridical
                                        ON ObjectLink_UnitPersonalTo_Juridical.ObjectId = ObjectLink_PersonalTo_Unit.ChildObjectId
                                       AND ObjectLink_UnitPersonalTo_Juridical.DescId = zc_ObjectLink_Unit_Juridical()
                                       AND Object_To.DescId = zc_Object_Personal()
                   LEFT JOIN ObjectLink AS ObjectLink_UnitPersonalTo_Business
                                        ON ObjectLink_UnitPersonalTo_Business.ObjectId = ObjectLink_PersonalTo_Unit.ChildObjectId
                                       AND ObjectLink_UnitPersonalTo_Business.DescId = zc_ObjectLink_Unit_Business()
                                       AND Object_To.DescId = zc_Object_Personal()

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

                   LEFT JOIN lfSelect_ObjectHistory_PriceListItem (inPriceListId:= zc_PriceList_ProductionSeparate(), inOperDate:= vbOperDate)
                          AS lfObjectHistory_PriceListItem ON lfObjectHistory_PriceListItem.GoodsId = MovementItem.ObjectId

              WHERE Movement.Id = inMovementId
                AND Movement.DescId = zc_Movement_ProductionSeparate()
                AND Movement.StatusId = zc_Enum_Status_UnComplete()
             ) AS _tmp;


     -- ��������� ������� - �������������� Master-�������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     INSERT INTO _tmpItem (MovementItemId, MovementId, OperDate, UnitId_From, PersonalId_From
                         , ContainerId_GoodsFrom, GoodsId, GoodsKindId, AssetId, PartionGoods, PartionGoodsDate
                         , OperCount
                         , AccountDirectionId_From, InfoMoneyDestinationId, InfoMoneyId
                         , isPartionCount, isPartionSumm, isPartionDate
                         , PartionGoodsId)
        SELECT
              _tmp.MovementItemId
            , _tmp.MovementId
            , _tmp.OperDate
            , _tmp.UnitId_From
            , _tmp.PersonalId_From

            , 0 AS ContainerId_GoodsFrom
            , _tmp.GoodsId
            , _tmp.GoodsKindId
            , _tmp.AssetId
            , _tmp.PartionGoods
            , _tmp.PartionGoodsDate

            , _tmp.OperCount

              -- ��������� ������ - ����������� (�� ����)
            , _tmp.AccountDirectionId_From
              -- �������������� ����������
            , _tmp.InfoMoneyDestinationId
              -- ������ ����������
            , _tmp.InfoMoneyId

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
                  , COALESCE (CASE WHEN Object_From.DescId = zc_Object_Unit() THEN MovementLinkObject_From.ObjectId ELSE 0 END, 0) AS UnitId_From
                  , COALESCE (CASE WHEN Object_From.DescId = zc_Object_Personal() THEN MovementLinkObject_From.ObjectId ELSE 0 END, 0) AS PersonalId_From

                  , MovementItem.ObjectId AS GoodsId
                  , COALESCE (MILinkObject_GoodsKind.ObjectId, 0) AS GoodsKindId
                  , COALESCE (MILinkObject_Asset.ObjectId, 0) AS AssetId
                  , COALESCE (MovementString_PartionGoods.ValueData, '') AS PartionGoods
                  , COALESCE (MIDate_PartionGoods.ValueData, zc_DateEnd()) AS PartionGoodsDate

                  , MovementItem.Amount AS OperCount

                  -- ��������� ������ - ����������� (�� ����)
                  , COALESCE (CASE WHEN Object_From.DescId = zc_Object_Unit()
                                       THEN ObjectLink_UnitFrom_AccountDirection.ChildObjectId
                                   WHEN Object_From.DescId = zc_Object_Personal()
                                       THEN CASE WHEN lfObject_InfoMoney.InfoMoneyDestinationId IN (zc_Enum_InfoMoneyDestination_10100() -- "�������� �����"; 10100; "������ �����"
                                                                                                  , zc_Enum_InfoMoneyDestination_20700() -- "�������������"; 20700; "������"
                                                                                                  , zc_Enum_InfoMoneyDestination_30100() -- "������"; 30100; "���������"
                                                                                                   )
                                                     THEN 0 -- !!!�� ���� �� ����� �� ����� ����!!! zc_Enum_AccountDirection_20600() -- "������"; 20600; "���������� (�����������)"
                                                 ELSE zc_Enum_AccountDirection_20500() -- "������"; 20500; "���������� (��)"
                                            END
                              END, 0) AS AccountDirectionId_From
                  -- �������������� ����������
                  , COALESCE (lfObject_InfoMoney.InfoMoneyDestinationId, 0) AS InfoMoneyDestinationId
                  -- ������ ����������
                  , COALESCE (lfObject_InfoMoney.InfoMoneyId, 0) AS InfoMoneyId

                  , COALESCE (ObjectBoolean_PartionCount.ValueData, FALSE)     AS isPartionCount
                  , COALESCE (ObjectBoolean_PartionSumm.ValueData, FALSE)      AS isPartionSumm
                  , COALESCE (ObjectBoolean_PartionDate.ValueData, FALSE)      AS isPartionDate

              FROM Movement
                   JOIN MovementItem ON MovementItem.MovementId = Movement.Id AND MovementItem.DescId = zc_MI_Master() AND MovementItem.isErased = FALSE
              -- FROM _tmpItem
              --      JOIN MovementItem ON MovementItem.ParentId = _tmpItem.MovementItemId AND MovementItem.DescId = zc_MI_Child() AND MovementItem.isErased = FALSE

                   LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                                    ON MILinkObject_GoodsKind.MovementItemId = MovementItem.Id
                                                   AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()
                   LEFT JOIN MovementItemLinkObject AS MILinkObject_Asset
                                                    ON MILinkObject_Asset.MovementItemId = MovementItem.Id
                                                   AND MILinkObject_Asset.DescId = zc_MILinkObject_Asset()

                   LEFT JOIN MovementItemDate AS MIDate_PartionGoods
                                              ON MIDate_PartionGoods.MovementItemId = MovementItem.Id
                                             AND MIDate_PartionGoods.DescId = zc_MIDate_PartionGoods()
                   LEFT JOIN MovementString AS MovementString_PartionGoods
                                            ON MovementString_PartionGoods.MovementId = MovementItem.MovementId
                                           AND MovementString_PartionGoods.DescId = zc_MovementString_PartionGoods()

                   LEFT JOIN MovementLinkObject AS MovementLinkObject_From
                                                ON MovementLinkObject_From.MovementId = MovementItem.MovementId
                                               AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()
                   LEFT JOIN Object AS Object_From ON Object_From.Id = MovementLinkObject_From.ObjectId

                   LEFT JOIN ObjectLink AS ObjectLink_UnitFrom_AccountDirection
                                        ON ObjectLink_UnitFrom_AccountDirection.ObjectId = MovementLinkObject_From.ObjectId
                                       AND ObjectLink_UnitFrom_AccountDirection.DescId = zc_ObjectLink_Unit_AccountDirection()
                                       AND Object_From.DescId = zc_Object_Unit()

                   LEFT JOIN ObjectBoolean AS ObjectBoolean_PartionDate
                                           ON ObjectBoolean_PartionDate.ObjectId = MovementLinkObject_From.ObjectId
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

              WHERE Movement.Id = inMovementId
                AND Movement.DescId = zc_Movement_ProductionSeparate()
                AND Movement.StatusId = zc_Enum_Status_UnComplete()
             ) AS _tmp;



     -- ����������� ������ ������ ��� Child-��������, ���� ���� ...
     UPDATE _tmpItemChild SET PartionGoodsId = CASE WHEN OperDate >= zc_DateStart_PartionGoods()
                                                     AND AccountDirectionId_To = zc_Enum_AccountDirection_20200() -- "������"; 20200; "�� �������"
                                                     AND (isPartionCount OR isPartionSumm)
                                                        THEN lpInsertFind_Object_PartionGoods (zfFormat_PartionGoods (PartionGoods)) -- ������ �����, �.�. � ������ �������� �������
                                                    WHEN isPartionDate
                                                     AND InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30100() -- "������"; 30100; "���������"
                                                        THEN lpInsertFind_Object_PartionGoods (PartionGoodsDate)
                                                    ELSE lpInsertFind_Object_PartionGoods ('')
                                               END
     WHERE InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10100() -- "�������� �����"; 10100; "������ �����"
        OR InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30100() -- "������"; 30100; "���������"
     ;
     -- ����������� ������ ������ ��� Master-��������, ���� ���� ...
     UPDATE _tmpItem SET PartionGoodsId = CASE WHEN OperDate >= zc_DateStart_PartionGoods()
                                                AND AccountDirectionId_From = zc_Enum_AccountDirection_20200() -- "������"; 20200; "�� �������"
                                                AND (isPartionCount OR isPartionSumm)
                                                   THEN lpInsertFind_Object_PartionGoods (zfFormat_PartionGoods (PartionGoods)) -- ������ �����, �.�. � ������ �������� �������
                                               WHEN isPartionDate
                                                AND InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30100() -- "������"; 30100; "���������"
                                                   THEN lpInsertFind_Object_PartionGoods (PartionGoodsDate)
                                               ELSE lpInsertFind_Object_PartionGoods ('')
                                          END
     WHERE InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10100() -- "�������� �����"; 10100; "������ �����"
        OR InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30100() -- "������"; 30100; "���������"
     ;


     -- ��� ����� - Master
     -- RETURN QUERY SELECT _tmpItem.MovementItemId, _tmpItem.MovementId, _tmpItem.OperDate, _tmpItem.UnitId_From, _tmpItem.PersonalId_From, _tmpItem.ContainerId_GoodsFrom, _tmpItem.GoodsId, _tmpItem.GoodsKindId, _tmpItem.AssetId, _tmpItem.PartionGoods, _tmpItem.PartionGoodsDate, _tmpItem.OperCount, _tmpItem.AccountDirectionId_From, _tmpItem.InfoMoneyDestinationId, _tmpItem.InfoMoneyId, _tmpItem.isPartionCount, _tmpItem.isPartionSumm, _tmpItem.isPartionDate, _tmpItem.PartionGoodsId FROM _tmpItem;
     -- ��� ����� - Child
     -- RETURN QUERY SELECT _tmpItemChild.MovementItemId, _tmpItemChild.MovementId, _tmpItemChild.OperDate, _tmpItemChild.UnitId_To, _tmpItemChild.PersonalId_To, _tmpItemChild.BranchId_To, _tmpItemChild.ContainerId_GoodsTo, _tmpItemChild.GoodsId, _tmpItemChild.GoodsKindId, _tmpItemChild.AssetId, _tmpItemChild.PartionGoods, _tmpItemChild.PartionGoodsDate, _tmpItemChild.OperCount, _tmpItemChild.tmpOperSumm, _tmpItemChild.AccountDirectionId_To, _tmpItemChild.InfoMoneyDestinationId, _tmpItemChild.InfoMoneyId, _tmpItemChild.JuridicalId_basis_To, _tmpItemChild.BusinessId_To, _tmpItemChild.isPartionCount, _tmpItemChild.isPartionSumm, _tmpItemChild.isPartionDate, _tmpItemChild.PartionGoodsId FROM _tmpItemChild;


     -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
     -- !!! �� � ������ - �������� !!!
     -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


     -- ������������ ContainerId_GoodsFrom ��� Master-�������� ��������������� �����
     UPDATE _tmpItem SET ContainerId_GoodsFrom =
                                             CASE WHEN InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10100() -- ������ ����� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10100()
                                                          -- 0)����� 1)������������� 2)!������ ������!
                                                          -- 0)����� 1)��������� (��) 2)!������ ������!
                                                     THEN lpInsertFind_Container (inContainerDescId:= zc_Container_Count()
                                                                                , inParentId:= NULL
                                                                                , inObjectId:= GoodsId
                                                                                , inJuridicalId_basis:= NULL
                                                                                , inBusinessId       := NULL
                                                                                , inObjectCostDescId := NULL
                                                                                , inObjectCostId     := NULL
                                                                                , inDescId_1   := CASE WHEN PersonalId_From <> 0 THEN zc_ContainerLinkObject_Personal() ELSE zc_ContainerLinkObject_Unit() END
                                                                                , inObjectId_1 := CASE WHEN PersonalId_From <> 0 THEN PersonalId_From ELSE UnitId_From END
                                                                                , inDescId_2   := zc_ContainerLinkObject_PartionGoods()
                                                                                , inObjectId_2 := CASE WHEN isPartionCount THEN PartionGoodsId ELSE NULL END
                                                                                 )
                                                  WHEN InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20100() -- �������� � ������� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20100()
                                                          -- 0)����� 1)������������� 2)�������� ��������(��� �������� ��������� ���)
                                                          -- 0)����� 1)��������� (��) 2)�������� ��������(��� �������� ��������� ���)
                                                     THEN lpInsertFind_Container (inContainerDescId:= zc_Container_Count()
                                                                                , inParentId:= NULL
                                                                                , inObjectId:= GoodsId
                                                                                , inJuridicalId_basis:= NULL
                                                                                , inBusinessId       := NULL
                                                                                , inObjectCostDescId := NULL
                                                                                , inObjectCostId     := NULL
                                                                                , inDescId_1   := CASE WHEN PersonalId_From <> 0 THEN zc_ContainerLinkObject_Personal() ELSE zc_ContainerLinkObject_Unit() END
                                                                                , inObjectId_1 := CASE WHEN PersonalId_From <> 0 THEN PersonalId_From ELSE UnitId_From END
                                                                                , inDescId_2   := zc_ContainerLinkObject_AssetTo()
                                                                                , inObjectId_2 := AssetId
                                                                                 )
                                                  WHEN InfoMoneyDestinationId IN (zc_Enum_InfoMoneyDestination_20700()  -- ������    -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20700()
                                                                                , zc_Enum_InfoMoneyDestination_30100()) -- ��������� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30100()
                                                          -- 0)����� 1)������������� 2)��� ������ 3)!!!������ ������!!!
                                                          -- 0)����� 1)��������� (��) 2)��� ������ 3)!!!������ ������!!!
                                                     THEN lpInsertFind_Container (inContainerDescId:= zc_Container_Count()
                                                                                , inParentId:= NULL
                                                                                , inObjectId:= GoodsId
                                                                                , inJuridicalId_basis:= NULL
                                                                                , inBusinessId       := NULL
                                                                                , inObjectCostDescId := NULL
                                                                                , inObjectCostId     := NULL
                                                                                , inDescId_1   := CASE WHEN PersonalId_From <> 0 THEN zc_ContainerLinkObject_Personal() ELSE zc_ContainerLinkObject_Unit() END
                                                                                , inObjectId_1 := CASE WHEN PersonalId_From <> 0 THEN PersonalId_From ELSE UnitId_From END
                                                                                , inDescId_2   := zc_ContainerLinkObject_GoodsKind()
                                                                                , inObjectId_2 := GoodsKindId
                                                                                , inDescId_3   := CASE WHEN PartionGoodsId <> 0 THEN zc_ContainerLinkObject_PartionGoods() ELSE NULL END
                                                                                , inObjectId_3 := CASE WHEN PartionGoodsId <> 0 THEN PartionGoodsId ELSE NULL END
                                                                                 )
                                                          -- 0)����� 1)�������������
                                                          -- 0)����� 1)��������� (��)
                                                     ELSE lpInsertFind_Container (inContainerDescId:= zc_Container_Count()
                                                                                , inParentId:= NULL
                                                                                , inObjectId:= GoodsId
                                                                                , inJuridicalId_basis:= NULL
                                                                                , inBusinessId       := NULL
                                                                                , inObjectCostDescId := NULL
                                                                                , inObjectCostId     := NULL
                                                                                , inDescId_1   := CASE WHEN PersonalId_From <> 0 THEN zc_ContainerLinkObject_Personal() ELSE zc_ContainerLinkObject_Unit() END
                                                                                , inObjectId_1 := CASE WHEN PersonalId_From <> 0 THEN PersonalId_From ELSE UnitId_From END
                                                                                 )
                                             END;

     -- ������������ ContainerId_GoodsTo ��� Child-�������� ��������������� �����
     UPDATE _tmpItemChild SET ContainerId_GoodsTo =
                                             CASE WHEN InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10100() -- ������ ����� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10100()
                                                          -- 0)����� 1)������������� 2)!������ ������!
                                                          -- 0)����� 1)��������� (��) 2)!������ ������!
                                                     THEN lpInsertFind_Container (inContainerDescId:= zc_Container_Count()
                                                                                , inParentId:= NULL
                                                                                , inObjectId:= GoodsId
                                                                                , inJuridicalId_basis:= NULL
                                                                                , inBusinessId       := NULL
                                                                                , inObjectCostDescId := NULL
                                                                                , inObjectCostId     := NULL
                                                                                , inDescId_1   := CASE WHEN PersonalId_To <> 0 THEN zc_ContainerLinkObject_Personal() ELSE zc_ContainerLinkObject_Unit() END
                                                                                , inObjectId_1 := CASE WHEN PersonalId_To <> 0 THEN PersonalId_To ELSE UnitId_To END
                                                                                , inDescId_2   := zc_ContainerLinkObject_PartionGoods()
                                                                                , inObjectId_2 := CASE WHEN isPartionCount THEN PartionGoodsId ELSE NULL END
                                                                                 )
                                                  WHEN InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20100() -- �������� � ������� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20100()
                                                          -- 0)����� 1)������������� 2)�������� ��������(��� �������� ��������� ���)
                                                          -- 0)����� 1)��������� (��) 2)�������� ��������(��� �������� ��������� ���)
                                                     THEN lpInsertFind_Container (inContainerDescId:= zc_Container_Count()
                                                                                , inParentId:= NULL
                                                                                , inObjectId:= GoodsId
                                                                                , inJuridicalId_basis:= NULL
                                                                                , inBusinessId       := NULL
                                                                                , inObjectCostDescId := NULL
                                                                                , inObjectCostId     := NULL
                                                                                , inDescId_1   := CASE WHEN PersonalId_To <> 0 THEN zc_ContainerLinkObject_Personal() ELSE zc_ContainerLinkObject_Unit() END
                                                                                , inObjectId_1 := CASE WHEN PersonalId_To <> 0 THEN PersonalId_To ELSE UnitId_To END
                                                                                , inDescId_2   := zc_ContainerLinkObject_AssetTo()
                                                                                , inObjectId_2 := AssetId
                                                                                 )
                                                  WHEN InfoMoneyDestinationId IN (zc_Enum_InfoMoneyDestination_20700()  -- ������    -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20700()
                                                                                , zc_Enum_InfoMoneyDestination_30100()) -- ��������� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30100()
                                                          -- 0)����� 1)������������� 2)��� ������ 3)!!!������ ������!!!
                                                          -- 0)����� 1)��������� (��) 2)��� ������ 3)!!!������ ������!!!
                                                     THEN lpInsertFind_Container (inContainerDescId:= zc_Container_Count()
                                                                                , inParentId:= NULL
                                                                                , inObjectId:= GoodsId
                                                                                , inJuridicalId_basis:= NULL
                                                                                , inBusinessId       := NULL
                                                                                , inObjectCostDescId := NULL
                                                                                , inObjectCostId     := NULL
                                                                                , inDescId_1   := CASE WHEN PersonalId_To <> 0 THEN zc_ContainerLinkObject_Personal() ELSE zc_ContainerLinkObject_Unit() END
                                                                                , inObjectId_1 := CASE WHEN PersonalId_To <> 0 THEN PersonalId_To ELSE UnitId_To END
                                                                                , inDescId_2   := zc_ContainerLinkObject_GoodsKind()
                                                                                , inObjectId_2 := GoodsKindId
                                                                                , inDescId_3   := CASE WHEN PartionGoodsId <> 0 THEN zc_ContainerLinkObject_PartionGoods() ELSE NULL END
                                                                                , inObjectId_3 := CASE WHEN PartionGoodsId <> 0 THEN PartionGoodsId ELSE NULL END
                                                                                 )
                                                          -- 0)����� 1)�������������
                                                          -- 0)����� 1)��������� (��)
                                                     ELSE lpInsertFind_Container (inContainerDescId:= zc_Container_Count()
                                                                                , inParentId:= NULL
                                                                                , inObjectId:= GoodsId
                                                                                , inJuridicalId_basis:= NULL
                                                                                , inBusinessId       := NULL
                                                                                , inObjectCostDescId := NULL
                                                                                , inObjectCostId     := NULL
                                                                                , inDescId_1   := CASE WHEN PersonalId_To <> 0 THEN zc_ContainerLinkObject_Personal() ELSE zc_ContainerLinkObject_Unit() END
                                                                                , inObjectId_1 := CASE WHEN PersonalId_To <> 0 THEN PersonalId_To ELSE UnitId_To END
                                                                                 )
                                             END;


     -- ����� ����������: ��������� ������� - �������� Master-�������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     INSERT INTO _tmpItemSumm (MovementItemId, ContainerId_From, InfoMoneyId_Detail_From, OperSumm)
        SELECT
              _tmpItem.MovementItemId
            , Container_Summ.Id  AS ContainerId_From
            , ContainerLinkObject_InfoMoneyDetail.ObjectId AS InfoMoneyId_Detail_From
            , SUM (ABS (_tmpItem.OperCount * COALESCE (HistoryCost.Price, 0))) AS OperSumm
        FROM _tmpItem
             JOIN Container AS Container_Summ ON Container_Summ.ParentId = _tmpItem.ContainerId_GoodsFrom
                                             AND Container_Summ.DescId = zc_Container_Summ()
             JOIN ContainerLinkObject AS ContainerLinkObject_InfoMoneyDetail
                                      ON ContainerLinkObject_InfoMoneyDetail.ContainerId = Container_Summ.Id
                                     AND ContainerLinkObject_InfoMoneyDetail.DescId = zc_ContainerLinkObject_InfoMoneyDetail()
             JOIN ContainerObjectCost AS ContainerObjectCost_Basis
                                      ON ContainerObjectCost_Basis.ContainerId = Container_Summ.Id
                                     AND ContainerObjectCost_Basis.ObjectCostDescId = zc_ObjectCost_Basis()
             LEFT JOIN HistoryCost ON HistoryCost.ObjectCostId = ContainerObjectCost_Basis.ObjectCostId
                                  AND _tmpItem.OperDate BETWEEN HistoryCost.StartDate AND HistoryCost.EndDate
        WHERE zc_isHistoryCost() = TRUE AND (ContainerLinkObject_InfoMoneyDetail.ObjectId = 0 OR zc_isHistoryCost_byInfoMoneyDetail()= TRUE)
          AND (inIsLastComplete = FALSE OR (_tmpItem.OperCount * HistoryCost.Price) <> 0) -- !!!�����������!!! ��������� ���� ���� ��� �� ��������� ��� (��� ����� ��� ������� �/�)
        GROUP BY
                 _tmpItem.MovementItemId
               , Container_Summ.Id
               , ContainerLinkObject_InfoMoneyDetail.ObjectId
        ;

     -- ���������� �������� ����� �� ����� ��� Master-�������� ���������
     INSERT INTO _tmpItemSummTotal (MovementItemId, InfoMoneyId_Detail_From, OperSumm)
        SELECT _tmpItemSumm.MovementItemId, _tmpItemSumm.InfoMoneyId_Detail_From, SUM (_tmpItemSumm.OperSumm) FROM _tmpItemSumm GROUP BY _tmpItemSumm.MovementItemId, _tmpItemSumm.InfoMoneyId_Detail_From;
     -- ������ �������� ����� �� !!!������������!!! ������ ��� Child-�������� ���������
     SELECT SUM (tmpOperSumm) INTO vbTotalSummChild FROM _tmpItemChild;

     -- ������������ ����� �� ����� �� Child-��������� ���������, � ��������� �� ��� ������� Master-�������� (�.�. ��������� ��� ProductionUnion)
     INSERT INTO _tmpItemSummChild (MovementItemId_Parent, MovementItemId, MIContainerId_To, InfoMoneyId_Detail_To, OperSumm)
        SELECT _tmpItemSummTotal.MovementItemId
             , _tmpItemChild.MovementItemId
             , 0 AS MIContainerId_To
             , _tmpItemSummTotal.InfoMoneyId_Detail_From
             , CASE WHEN vbTotalSummChild <> 0 THEN _tmpItemSummTotal.OperSumm * _tmpItemChild.tmpOperSumm / vbTotalSummChild ELSE 0 END
        FROM _tmpItemChild
             JOIN _tmpItemSummTotal ON 1=1
        -- !�����������! ��������� ���� - WHERE vbTotalSummChild <> 0
        ;

     -- ����� ������������� ���������� �������� ����� �� ����� ��� Child-�������� ���������
     INSERT INTO _tmpItemSummChildTotal (MovementItemId_Parent, InfoMoneyId_Detail_To, OperSumm)
        SELECT _tmpItemSummChild.MovementItemId_Parent, _tmpItemSummChild.InfoMoneyId_Detail_To, SUM (_tmpItemSummChild.OperSumm) FROM _tmpItemSummChild GROUP BY _tmpItemSummChild.MovementItemId_Parent, _tmpItemSummChild.InfoMoneyId_Detail_To;

     -- ���� �� ����� ��� �����, ������ !!!�����������!!! � ������� MovementItemId_Parent � ��-�
     IF EXISTS (SELECT _tmpItemSummTotal.OperSumm
                FROM _tmpItemSummTotal
                     JOIN _tmpItemSummChildTotal ON _tmpItemSummChildTotal.MovementItemId_Parent = _tmpItemSummTotal.MovementItemId
                                                AND _tmpItemSummChildTotal.InfoMoneyId_Detail_To = _tmpItemSummTotal.InfoMoneyId_Detail_From
                WHERE _tmpItemSummTotal.OperSumm <> _tmpItemSummChildTotal.OperSumm
               )
     THEN
         -- �� ������� ������������ �������� � ����� ������� ������ (������������ ����� ���������� �������� < 0, �� ��� ������ �� ������������)
         UPDATE _tmpItemSummChild
            SET OperSumm = _tmpItemSummChild.OperSumm - _tmp_Total.SummDiff
         FROM (
               -- �������� ��� � ���� ���� ������� � � ������������� MovementItemId � !!!��-�!!!
               SELECT _tmp_Find.MovementItemId
                    , _tmpItemSummChildTotal.MovementItemId_Parent
                    , _tmpItemSummChildTotal.InfoMoneyId_Detail_To
                    , (_tmpItemSummChildTotal.OperSumm - _tmpItemSummTotal.OperSumm) AS SummDiff
               FROM _tmpItemSummTotal
                    JOIN _tmpItemSummChildTotal ON _tmpItemSummChildTotal.MovementItemId_Parent = _tmpItemSummTotal.MovementItemId
                                               AND _tmpItemSummChildTotal.InfoMoneyId_Detail_To = _tmpItemSummTotal.InfoMoneyId_Detail_From
                          -- �������� ������������ MovementItemId � ������� ������������ ���� � !!!��-�!!!
                    JOIN (SELECT MAX (_tmpItemSummChild.MovementItemId) AS MovementItemId, _tmpItemSummChild.MovementItemId_Parent, _tmpItemSummChild.InfoMoneyId_Detail_To
                          FROM _tmpItemSummChild
                                      -- �������� ������������ ����� � ������� MovementItemId_Parent � !!!��-�!!!
                               JOIN (SELECT MAX (_tmpItemSummChild.OperSumm) AS OperSumm, _tmpItemSummChild.MovementItemId_Parent, _tmpItemSummChild.InfoMoneyId_Detail_To
                                     FROM _tmpItemSummChild
                                     GROUP BY _tmpItemSummChild.MovementItemId_Parent, _tmpItemSummChild.InfoMoneyId_Detail_To
                                    ) AS _tmp_MaxSumm ON _tmp_MaxSumm.MovementItemId_Parent = _tmpItemSummChild.MovementItemId_Parent
                                                     AND _tmp_MaxSumm.InfoMoneyId_Detail_To = _tmpItemSummChild.InfoMoneyId_Detail_To
                                                     AND _tmp_MaxSumm.OperSumm = _tmpItemSummChild.OperSumm
                          GROUP BY _tmpItemSummChild.MovementItemId_Parent, _tmpItemSummChild.InfoMoneyId_Detail_To
                         ) AS _tmp_Find ON _tmp_Find.MovementItemId_Parent = _tmpItemSummTotal.MovementItemId
                                       AND _tmp_Find.InfoMoneyId_Detail_To = _tmpItemSummTotal.InfoMoneyId_Detail_From
               WHERE _tmpItemSummTotal.OperSumm <> _tmpItemSummChildTotal.OperSumm
              ) AS _tmp_Total
         WHERE _tmpItemSummChild.MovementItemId = _tmp_Total.MovementItemId
           AND _tmpItemSummChild.MovementItemId_Parent = _tmp_Total.MovementItemId_Parent
           AND _tmpItemSummChild.InfoMoneyId_Detail_To = _tmp_Total.InfoMoneyId_Detail_To
        ;
     END IF;


     -- ��� ����� - Master - Summ
     -- RETURN QUERY SELECT _tmpItemSumm.MovementItemId, _tmpItemSumm.ContainerId_From, _tmpItemSumm.InfoMoneyId_Detail_From, _tmpItemSumm.OperSumm FROM _tmpItemSumm;
     -- ��� ����� - Child - Summ
     -- RETURN QUERY SELECT _tmpItemSummChild.MovementItemId_Parent, _tmpItemSummChild.MovementItemId, _tmpItemSummChild.InfoMoneyId_Detail_To, _tmpItemSummChild.OperSumm FROM _tmpItemSummChild;


     -- ����������� �������� ��� ��������������� ����� - �� ����
     PERFORM lpInsertUpdate_MovementItemContainer (ioId:= 0
                                                 , inDescId:= zc_MIContainer_Count()
                                                 , inMovementId:= MovementId
                                                 , inMovementItemId:= MovementItemId
                                                 , inParentId:= NULL -- ��� ����� ����� ��������������� ����������
                                                 , inContainerId:= ContainerId_GoodsFrom -- ��� ���������� ����
                                                 , inAmount:= -1 * OperCount
                                                 , inOperDate:= OperDate
                                                 , inIsActive:= FALSE
                                                  )
     FROM _tmpItem;

     -- ����������� �������� ��� ��������������� ����� - ����
     PERFORM lpInsertUpdate_MovementItemContainer (ioId:= 0
                                                 , inDescId:= zc_MIContainer_Count()
                                                 , inMovementId:= MovementId
                                                 , inMovementItemId:= MovementItemId
                                                 , inParentId:= NULL -- ��� ����� ����� ��������������� ����������
                                                 , inContainerId:= ContainerId_GoodsTo -- ��� ���������� ����
                                                 , inAmount:= OperCount
                                                 , inOperDate:= OperDate
                                                 , inIsActive:= TRUE
                                                  )
     FROM _tmpItemChild;



     -- ����������� �������� ��� ��������� ����� + ��������� <������� �/�> - ���� + ������������ MIContainer.Id
     UPDATE _tmpItemSummChild SET MIContainerId_To =
             lpInsertUpdate_MovementItemContainer (ioId:= 0
                                                 , inDescId:= zc_MIContainer_Summ()
                                                 , inMovementId:= MovementId
                                                 , inMovementItemId:= _tmpItemChild.MovementItemId
                                                 , inParentId:= NULL
                                                 , inContainerId:= CASE WHEN InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10100() -- ������ ����� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10100()
                                                                                -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)������������� 2)����� 3)!������ ������! 4)������ ���������� 5)������ ����������(����������� �/�)
                                                                                -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)��������� (��) 2)����� 3)!������ ������! 4)������ ���������� 5)������ ����������(����������� �/�)
                                                                           THEN lpInsertFind_Container (inContainerDescId:= zc_Container_Summ()
                                                                                                      , inParentId:= ContainerId_GoodsTo
                                                                                                      , inObjectId:= lpInsertFind_Object_Account (inAccountGroupId         := zc_Enum_AccountGroup_20000() -- ������ -- select * from gpSelect_Object_AccountGroup ('2') where Id = zc_Enum_AccountGroup_20000()
                                                                                                                                                , inAccountDirectionId     := AccountDirectionId_To
                                                                                                                                                , inInfoMoneyDestinationId := InfoMoneyDestinationId
                                                                                                                                                , inInfoMoneyId            := NULL
                                                                                                                                                , inUserId                 := vbUserId
                                                                                                                                                 )
                                                                                                      , inJuridicalId_basis:= JuridicalId_basis_To
                                                                                                      , inBusinessId       := BusinessId_To
                                                                                                      , inObjectCostDescId := zc_ObjectCost_Basis()
                                                                                                                              -- <������� �/�>: 1.)������� �� ���� 2.)������ 3)������ 4)!�������������! 5)����� 6)!������ ������! 7)������ ���������� 8)������ ����������(����������� �/�)
                                                                                                                              -- <������� �/�>: 1.)������� �� ���� 2.)������ 3)������ 4)��������� (��) 5)����� 6)!������ ������! 7)������ ���������� 8)������ ����������(����������� �/�)
                                                                                                      , inObjectCostId     := lpInsertFind_ObjectCost (inObjectCostDescId:= zc_ObjectCost_Basis()
                                                                                                                                                     , inDescId_1   := zc_ObjectCostLink_JuridicalBasis()
                                                                                                                                                     , inObjectId_1 := JuridicalId_basis_To
                                                                                                                                                     , inDescId_2   := zc_ObjectCostLink_Business()
                                                                                                                                                     , inObjectId_2 := BusinessId_To
                                                                                                                                                     , inDescId_3   := zc_ObjectCostLink_Branch()
                                                                                                                                                     , inObjectId_3 := BranchId_To
                                                                                                                                                     , inDescId_4   := CASE WHEN PersonalId_To <> 0 THEN zc_ObjectCostLink_Personal() ELSE zc_ObjectCostLink_Unit() END
                                                                                                                                                     , inObjectId_4 := CASE WHEN PersonalId_To <> 0 AND OperDate >= zc_DateStart_ObjectCostOnUnit() THEN PersonalId_To WHEN OperDate >= zc_DateStart_ObjectCostOnUnit() THEN UnitId_To ELSE NULL END
                                                                                                                                                     , inDescId_5   := zc_ObjectCostLink_Goods()
                                                                                                                                                     , inObjectId_5 := GoodsId
                                                                                                                                                     , inDescId_6   := zc_ObjectCostLink_PartionGoods()
                                                                                                                                                     , inObjectId_6 := CASE WHEN isPartionSumm THEN PartionGoodsId ELSE NULL END
                                                                                                                                                     , inDescId_7   := zc_ObjectCostLink_InfoMoney()
                                                                                                                                                     , inObjectId_7 := InfoMoneyId
                                                                                                                                                     , inDescId_8   := zc_ObjectCostLink_InfoMoneyDetail()
                                                                                                                                                     , inObjectId_8 := InfoMoneyId_Detail_To
                                                                                                                                                      )
                                                                                                      , inDescId_1   := CASE WHEN PersonalId_To <> 0 THEN zc_ContainerLinkObject_Personal() ELSE zc_ContainerLinkObject_Unit() END
                                                                                                      , inObjectId_1 := CASE WHEN PersonalId_To <> 0 THEN PersonalId_To ELSE UnitId_To END
                                                                                                      , inDescId_2   := zc_ContainerLinkObject_Goods()
                                                                                                      , inObjectId_2 := GoodsId
                                                                                                      , inDescId_3   := zc_ContainerLinkObject_PartionGoods()
                                                                                                      , inObjectId_3 := CASE WHEN isPartionSumm THEN PartionGoodsId ELSE NULL END
                                                                                                      , inDescId_4   := zc_ContainerLinkObject_InfoMoney()
                                                                                                      , inObjectId_4 := InfoMoneyId
                                                                                                      , inDescId_5   := zc_ContainerLinkObject_InfoMoneyDetail()
                                                                                                      , inObjectId_5 := InfoMoneyId_Detail_To
                                                                                                       )
                                                                        WHEN InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20100() -- �������� � ������� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20100()
                                                                                -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)������������� 2)����� 3)�������� ��������(��� �������� ��������� ���) 4)������ ���������� 5)������ ����������(����������� �/�)
                                                                                -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)��������� (��) 2)����� 3)�������� ��������(��� �������� ��������� ���) 4)������ ���������� 5)������ ����������(����������� �/�)
                                                                           THEN lpInsertFind_Container (inContainerDescId:= zc_Container_Summ()
                                                                                                      , inParentId:= ContainerId_GoodsTo
                                                                                                      , inObjectId:= lpInsertFind_Object_Account (inAccountGroupId         := zc_Enum_AccountGroup_20000() -- ������ -- select * from gpSelect_Object_AccountGroup ('2') where Id = zc_Enum_AccountGroup_20000()
                                                                                                                                                , inAccountDirectionId     := AccountDirectionId_To
                                                                                                                                                , inInfoMoneyDestinationId := InfoMoneyDestinationId
                                                                                                                                                , inInfoMoneyId            := NULL
                                                                                                                                                , inUserId                 := vbUserId
                                                                                                                                                 )
                                                                                                      , inJuridicalId_basis:= JuridicalId_basis_To
                                                                                                      , inBusinessId       := BusinessId_To
                                                                                                      , inObjectCostDescId := zc_ObjectCost_Basis()
                                                                                                                              -- <������� �/�>: 1.)������� �� ���� 2.)������ 3)������ 4)!�������������! 5)����� 6)�������� ��������(��� �������� ��������� ���) 7)������ ���������� 8)������ ����������(����������� �/�)
                                                                                                                              -- <������� �/�>: 1.)������� �� ���� 2.)������ 3)������ 4)��������� (��) 5)����� 6)�������� ��������(��� �������� ��������� ���) 7)������ ���������� 8)������ ����������(����������� �/�)
                                                                                                      , inObjectCostId     := lpInsertFind_ObjectCost (inObjectCostDescId:= zc_ObjectCost_Basis()
                                                                                                                                                     , inDescId_1   := zc_ObjectCostLink_JuridicalBasis()
                                                                                                                                                     , inObjectId_1 := JuridicalId_basis_To
                                                                                                                                                     , inDescId_2   := zc_ObjectCostLink_Business()
                                                                                                                                                     , inObjectId_2 := BusinessId_To
                                                                                                                                                     , inDescId_3   := zc_ObjectCostLink_Branch()
                                                                                                                                                     , inObjectId_3 := BranchId_To
                                                                                                                                                     , inDescId_4   := CASE WHEN PersonalId_To <> 0 THEN zc_ObjectCostLink_Personal() ELSE zc_ObjectCostLink_Unit() END
                                                                                                                                                     , inObjectId_4 := CASE WHEN PersonalId_To <> 0 AND OperDate >= zc_DateStart_ObjectCostOnUnit() THEN PersonalId_To WHEN OperDate >= zc_DateStart_ObjectCostOnUnit() THEN UnitId_To ELSE NULL END
                                                                                                                                                     , inDescId_5   := zc_ObjectCostLink_Goods()
                                                                                                                                                     , inObjectId_5 := GoodsId
                                                                                                                                                     , inDescId_6   := zc_ObjectCostLink_AssetTo()
                                                                                                                                                     , inObjectId_6 := AssetId
                                                                                                                                                     , inDescId_7   := zc_ObjectCostLink_InfoMoney()
                                                                                                                                                     , inObjectId_7 := InfoMoneyId
                                                                                                                                                     , inDescId_8   := zc_ObjectCostLink_InfoMoneyDetail()
                                                                                                                                                     , inObjectId_8 := InfoMoneyId_Detail_To
                                                                                                                                                      )
                                                                                                      , inDescId_1   := CASE WHEN PersonalId_To <> 0 THEN zc_ContainerLinkObject_Personal() ELSE zc_ContainerLinkObject_Unit() END
                                                                                                      , inObjectId_1 := CASE WHEN PersonalId_To <> 0 THEN PersonalId_To ELSE UnitId_To END
                                                                                                      , inDescId_2   := zc_ContainerLinkObject_Goods()
                                                                                                      , inObjectId_2 := GoodsId
                                                                                                      , inDescId_3   := zc_ContainerLinkObject_AssetTo()
                                                                                                      , inObjectId_3 := AssetId
                                                                                                      , inDescId_4   := zc_ContainerLinkObject_InfoMoney()
                                                                                                      , inObjectId_4 := InfoMoneyId
                                                                                                      , inDescId_5   := zc_ContainerLinkObject_InfoMoneyDetail()
                                                                                                      , inObjectId_5 := InfoMoneyId_Detail_To
                                                                                                       )
                                                                        WHEN InfoMoneyDestinationId IN (zc_Enum_InfoMoneyDestination_20700()  -- ������    -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20700()
                                                                                                      , zc_Enum_InfoMoneyDestination_30100()) -- ��������� -- select * from lfSelect_Object_InfoMoney() where InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30100()
                                                                                -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)������������� 2)����� 3)!!!������ ������!!! 4)���� ������� 5)������ ���������� 6)������ ����������(����������� �/�)
                                                                                -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)��������� (��) 2)����� 3)!!!������ ������!!! 4)���� ������� 5)������ ���������� 6)������ ����������(����������� �/�)
                                                                           THEN lpInsertFind_Container (inContainerDescId:= zc_Container_Summ()
                                                                                                      , inParentId:= ContainerId_GoodsTo
                                                                                                      , inObjectId:= lpInsertFind_Object_Account (inAccountGroupId         := zc_Enum_AccountGroup_20000() -- ������ -- select * from gpSelect_Object_AccountGroup ('2') where Id = zc_Enum_AccountGroup_20000()
                                                                                                                                                , inAccountDirectionId     := AccountDirectionId_To
                                                                                                                                                , inInfoMoneyDestinationId := CASE WHEN GoodsKindId = zc_GoodsKind_WorkProgress() THEN zc_InfoMoneyDestination_WorkProgress() ELSE InfoMoneyDestinationId END
                                                                                                                                                , inInfoMoneyId            := NULL
                                                                                                                                                , inUserId                 := vbUserId
                                                                                                                                                 )
                                                                                                      , inJuridicalId_basis:= JuridicalId_basis_To
                                                                                                      , inBusinessId       := BusinessId_To
                                                                                                      , inObjectCostDescId := zc_ObjectCost_Basis()
                                                                                                                              -- <������� �/�>: 1.)������� �� ���� 2.)������ 3)������ 4)������������� 5)����� 6)!!!������ ������!!! 7)���� ������� 8)������ ���������� 9)������ ����������(����������� �/�)
                                                                                                                              -- <������� �/�>: 1.)������� �� ���� 2.)������ 3)������ 4)��������� (��) 5)����� 6)!!!������ ������!!! 7)���� ������� 8)������ ���������� 9)������ ����������(����������� �/�)
                                                                                                      , inObjectCostId     := lpInsertFind_ObjectCost (inObjectCostDescId:= zc_ObjectCost_Basis()
                                                                                                                                                     , inDescId_1   := zc_ObjectCostLink_JuridicalBasis()
                                                                                                                                                     , inObjectId_1 := JuridicalId_basis_To
                                                                                                                                                     , inDescId_2   := zc_ObjectCostLink_Business()
                                                                                                                                                     , inObjectId_2 := BusinessId_To
                                                                                                                                                     , inDescId_3   := zc_ObjectCostLink_Branch()
                                                                                                                                                     , inObjectId_3 := BranchId_To
                                                                                                                                                     , inDescId_4   := CASE WHEN PersonalId_To <> 0 THEN zc_ObjectCostLink_Personal() ELSE zc_ObjectCostLink_Unit() END
                                                                                                                                                     , inObjectId_4 := CASE WHEN PersonalId_To <> 0 THEN PersonalId_To ELSE UnitId_To END
                                                                                                                                                     , inDescId_5   := zc_ObjectCostLink_Goods()
                                                                                                                                                     , inObjectId_5 := GoodsId
                                                                                                                                                     , inDescId_6   := CASE WHEN PartionGoodsId <> 0 THEN zc_ObjectCostLink_PartionGoods() ELSE NULL END
                                                                                                                                                     , inObjectId_6 := CASE WHEN PartionGoodsId <> 0 THEN PartionGoodsId ELSE NULL END
                                                                                                                                                     , inDescId_7   := zc_ObjectCostLink_GoodsKind()
                                                                                                                                                     , inObjectId_7 := GoodsKindId
                                                                                                                                                     , inDescId_8   := zc_ObjectCostLink_InfoMoney()
                                                                                                                                                     , inObjectId_8 := InfoMoneyId
                                                                                                                                                     , inDescId_9   := zc_ObjectCostLink_InfoMoneyDetail()
                                                                                                                                                     , inObjectId_9 := InfoMoneyId_Detail_To
                                                                                                                                                      )
                                                                                                      , inDescId_1   := CASE WHEN PersonalId_To <> 0 THEN zc_ContainerLinkObject_Personal() ELSE zc_ContainerLinkObject_Unit() END
                                                                                                      , inObjectId_1 := CASE WHEN PersonalId_To <> 0 THEN PersonalId_To ELSE UnitId_To END
                                                                                                      , inDescId_2   := zc_ContainerLinkObject_Goods()
                                                                                                      , inObjectId_2 := GoodsId
                                                                                                      , inDescId_3   := CASE WHEN PartionGoodsId <> 0 THEN zc_ContainerLinkObject_PartionGoods() ELSE NULL END
                                                                                                      , inObjectId_3 := CASE WHEN PartionGoodsId <> 0 THEN PartionGoodsId ELSE NULL END
                                                                                                      , inDescId_4   := zc_ContainerLinkObject_GoodsKind()
                                                                                                      , inObjectId_4 := GoodsKindId
                                                                                                      , inDescId_5   := zc_ContainerLinkObject_InfoMoney()
                                                                                                      , inObjectId_5 := InfoMoneyId
                                                                                                      , inDescId_6   := zc_ContainerLinkObject_InfoMoneyDetail()
                                                                                                      , inObjectId_6 := InfoMoneyId_Detail_To
                                                                                                       )
                                                                                -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)������������� 2)����� 3)������ ���������� 4)������ ����������(����������� �/�)
                                                                                -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)��������� (��) 2)����� 3)������ ���������� 4)������ ����������(����������� �/�)
                                                                           ELSE lpInsertFind_Container (inContainerDescId:= zc_Container_Summ()
                                                                                                      , inParentId:= ContainerId_GoodsTo
                                                                                                      , inObjectId:= lpInsertFind_Object_Account (inAccountGroupId         := zc_Enum_AccountGroup_20000() -- ������ -- select * from gpSelect_Object_AccountGroup ('2') where Id = zc_Enum_AccountGroup_20000()
                                                                                                                                                , inAccountDirectionId     := AccountDirectionId_To
                                                                                                                                                , inInfoMoneyDestinationId := InfoMoneyDestinationId
                                                                                                                                                , inInfoMoneyId            := NULL
                                                                                                                                                , inUserId                 := vbUserId
                                                                                                                                                 )
                                                                                                      , inJuridicalId_basis:= JuridicalId_basis_To
                                                                                                      , inBusinessId       := BusinessId_To
                                                                                                      , inObjectCostDescId := zc_ObjectCost_Basis()
                                                                                                                              -- <������� �/�>: 1.)������� �� ���� 2.)������ 3)������ 4)!�������������! 5)����� 6)������ ���������� 7)������ ����������(����������� �/�)
                                                                                                                              -- <������� �/�>: 1.)������� �� ���� 2.)������ 3)������ 4)��������� (��) 5)����� 6)������ ���������� 7)������ ����������(����������� �/�)
                                                                                                      , inObjectCostId     := lpInsertFind_ObjectCost (inObjectCostDescId:= zc_ObjectCost_Basis()
                                                                                                                                                     , inDescId_1   := zc_ObjectCostLink_JuridicalBasis()
                                                                                                                                                     , inObjectId_1 := JuridicalId_basis_To
                                                                                                                                                     , inDescId_2   := zc_ObjectCostLink_Business()
                                                                                                                                                     , inObjectId_2 := BusinessId_To
                                                                                                                                                     , inDescId_3   := zc_ObjectCostLink_Branch()
                                                                                                                                                     , inObjectId_3 := BranchId_To
                                                                                                                                                     , inDescId_4   := CASE WHEN PersonalId_To <> 0 THEN zc_ObjectCostLink_Personal() ELSE zc_ObjectCostLink_Unit() END
                                                                                                                                                     , inObjectId_4 := CASE WHEN PersonalId_To <> 0 AND OperDate >= zc_DateStart_ObjectCostOnUnit() THEN PersonalId_To WHEN OperDate >= zc_DateStart_ObjectCostOnUnit() THEN UnitId_To ELSE NULL END
                                                                                                                                                     , inDescId_5   := zc_ObjectCostLink_Goods()
                                                                                                                                                     , inObjectId_5 := GoodsId
                                                                                                                                                     , inDescId_6   := zc_ObjectCostLink_InfoMoney()
                                                                                                                                                     , inObjectId_6 := InfoMoneyId
                                                                                                                                                     , inDescId_7   := zc_ObjectCostLink_InfoMoneyDetail()
                                                                                                                                                     , inObjectId_7 := InfoMoneyId_Detail_To
                                                                                                                                                      )
                                                                                                      , inDescId_1   := CASE WHEN PersonalId_To <> 0 THEN zc_ContainerLinkObject_Personal() ELSE zc_ContainerLinkObject_Unit() END
                                                                                                      , inObjectId_1 := CASE WHEN PersonalId_To <> 0 THEN PersonalId_To ELSE UnitId_To END
                                                                                                      , inDescId_2   := zc_ContainerLinkObject_Goods()
                                                                                                      , inObjectId_2 := GoodsId
                                                                                                      , inDescId_3   := zc_ContainerLinkObject_InfoMoney()
                                                                                                      , inObjectId_3 := InfoMoneyId
                                                                                                      , inDescId_4   := zc_ContainerLinkObject_InfoMoneyDetail()
                                                                                                      , inObjectId_4 := InfoMoneyId_Detail_To
                                                                                                       )
                                                                   END
                                                 , inAmount:= (OperSumm)
                                                 , inOperDate:= OperDate
                                                 , inIsActive:= TRUE
                                                  )
     FROM _tmpItemChild
     WHERE _tmpItemSummChild.MovementItemId = _tmpItemChild.MovementItemId;


     -- ����������� �������� ��� ��������� ����� - �� ����, ������ ��� !!!�������!! �������� ������� (������� � inAmount:= -1 * _tmpItemSummChild.OperSumm)
     PERFORM lpInsertUpdate_MovementItemContainer (ioId:= 0
                                                 , inDescId:= zc_MIContainer_Summ()
                                                 , inMovementId:= _tmpItem.MovementId
                                                 , inMovementItemId:= _tmpItem.MovementItemId
                                                 , inParentId:= _tmpItemSummChild.MIContainerId_To -- ��� ����� � �������� ��������� �������
                                                 , inContainerId:= _tmpItemSumm.ContainerId_From
                                                 , inAmount:= -1 * _tmpItemSummChild.OperSumm
                                                 , inOperDate:= _tmpItem.OperDate
                                                 , inIsActive:= FALSE
                                                  )
     FROM _tmpItem
          JOIN _tmpItemSumm ON _tmpItemSumm.MovementItemId = _tmpItem.MovementItemId
          JOIN _tmpItemSummChild ON _tmpItemSummChild.MovementItemId_Parent = _tmpItemSumm.MovementItemId
                                AND _tmpItemSummChild.InfoMoneyId_Detail_To = _tmpItemSumm.InfoMoneyId_Detail_From
     ;


     -- ����� - ����������� ������ ������ ���������
     UPDATE Movement SET StatusId = zc_Enum_Status_Complete() WHERE Id = inMovementId AND DescId = zc_Movement_ProductionSeparate() AND StatusId = zc_Enum_Status_UnComplete();


END;
$BODY$
LANGUAGE PLPGSQL VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 26.08.13                                        * add zc_InfoMoneyDestination_WorkProgress
 11.08.13                                        * add inIsLastComplete
 10.08.13                                        * � ��������� !!!������!! ��� ��������� �����: Master - ������, Child - ������ (�.�. !!!��������!!! ��� � MovementItem ���� ���������� ��� ProductionUnion)
 09.08.13                                        * add zc_isHistoryCost and zc_isHistoryCost_byInfoMoneyDetail
 07.08.13                                        * add inParentId and inIsActive
 06.08.13                                        * err on vbOperSumm
 24.07.13                                        * !�����������! ��������� ����
 21.07.13                                        *
*/

-- ����
-- SELECT * FROM gpUnComplete_Movement (inMovementId:= 8324, inSession:= '2')
-- SELECT * FROM gpComplete_Movement_ProductionSeparate (inMovementId:= 8324, inIsLastComplete:= FALSE, inSession:= '2')
-- SELECT * FROM gpSelect_MovementItemContainer_Movement (inMovementId:= 8324, inSession:= '2')
