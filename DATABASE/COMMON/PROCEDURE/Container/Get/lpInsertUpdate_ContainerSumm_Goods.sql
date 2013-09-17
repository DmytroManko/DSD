-- Function: lpInsertUpdate_ContainerSumm_Goods (TDateTime, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Boolean, Integer, Integer)

-- DROP FUNCTION lpInsertUpdate_ContainerSumm_Goods (TDateTime, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Boolean, Integer, Integer);

CREATE OR REPLACE FUNCTION lpInsertUpdate_ContainerSumm_Goods (
    IN inOperDate               TDateTime, 
    IN inUnitId                 Integer , 
    IN inPersonalId             Integer , 
    IN inBranchId               Integer , 
    IN inJuridicalId_basis      Integer , 
    IN inBusinessId             Integer , 
    IN inAccountId              Integer , 
    IN inInfoMoneyDestinationId Integer , 
    IN inInfoMoneyId            Integer , 
    IN inInfoMoneyId_Detail     Integer , 
    IN inContainerId_Goods      Integer , 
    IN inGoodsId                Integer , 
    IN inGoodsKindId            Integer , 
    IN inIsPartionSumm          Boolean , 
    IN inPartionGoodsId         Integer , 
    IN inAssetId                Integer
)
  RETURNS Integer
AS
$BODY$
   DECLARE vbContainerId Integer;
BEGIN

     SELECT CASE WHEN inInfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10100() -- ������ ����� -- select * from lfSelect_Object_InfoMoney() where inInfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10100()
                           -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)������������� 2)����� 3)!������ ������! 4)������ ���������� 5)������ ����������(����������� �/�)
                           -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)��������� (��) 2)����� 3)!������ ������! 4)������ ���������� 5)������ ����������(����������� �/�)
                      THEN lpInsertFind_Container (inContainerDescId   := zc_Container_Summ()
                                                 , inParentId          := inContainerId_Goods
                                                 , inObjectId          := inAccountId
                                                 , inJuridicalId_basis := inJuridicalId_basis
                                                 , inBusinessId        := inBusinessId
                                                 , inObjectCostDescId  := zc_ObjectCost_Basis()
                                                                          -- <������� �/�>: 1.)������� �� ���� 2.)������ 3)������ 4)!�������������! 5)����� 6)!������ ������! 7)������ ���������� 8)������ ����������(����������� �/�)
                                                                          -- <������� �/�>: 1.)������� �� ���� 2.)������ 3)������ 4)��������� (��) 5)����� 6)!������ ������! 7)������ ���������� 8)������ ����������(����������� �/�)
                                                 , inObjectCostId      := lpInsertFind_ObjectCost (inObjectCostDescId:= zc_ObjectCost_Basis()
                                                                                                 , inDescId_1   := zc_ObjectCostLink_JuridicalBasis()
                                                                                                 , inObjectId_1 := inJuridicalId_basis
                                                                                                 , inDescId_2   := zc_ObjectCostLink_Business()
                                                                                                 , inObjectId_2 := inBusinessId
                                                                                                 , inDescId_3   := zc_ObjectCostLink_Branch()
                                                                                                 , inObjectId_3 := inBranchId
                                                                                                 , inDescId_4   := CASE WHEN inPersonalId <> 0 THEN zc_ObjectCostLink_Personal() ELSE zc_ObjectCostLink_Unit() END
                                                                                                 , inObjectId_4 := CASE WHEN inPersonalId <> 0 AND inOperDate >= zc_DateStart_ObjectCostOnUnit() THEN inPersonalId WHEN inOperDate >= zc_DateStart_ObjectCostOnUnit() THEN inUnitId ELSE NULL END
                                                                                                 , inDescId_5   := zc_ObjectCostLink_Goods()
                                                                                                 , inObjectId_5 := inGoodsId
                                                                                                 , inDescId_6   := zc_ObjectCostLink_PartionGoods()
                                                                                                 , inObjectId_6 := CASE WHEN inIsPartionSumm THEN inPartionGoodsId ELSE NULL END
                                                                                                 , inDescId_7   := zc_ObjectCostLink_InfoMoney()
                                                                                                 , inObjectId_7 := inInfoMoneyId
                                                                                                 , inDescId_8   := zc_ObjectCostLink_InfoMoneyDetail()
                                                                                                 , inObjectId_8 := inInfoMoneyId_Detail
                                                                                                  )
                                                 , inDescId_1   := CASE WHEN inPersonalId <> 0 THEN zc_ContainerLinkObject_Personal() ELSE zc_ContainerLinkObject_Unit() END
                                                 , inObjectId_1 := CASE WHEN inPersonalId <> 0 THEN inPersonalId ELSE inUnitId END
                                                                                                      , inDescId_2   := zc_ContainerLinkObject_Goods()
                                                                                                      , inObjectId_2 := inGoodsId
                                                                                                      , inDescId_3   := zc_ContainerLinkObject_PartionGoods()
                                                                                                      , inObjectId_3 := CASE WHEN inIsPartionSumm THEN inPartionGoodsId ELSE NULL END
                                                                                                      , inDescId_4   := zc_ContainerLinkObject_InfoMoney()
                                                                                                      , inObjectId_4 := inInfoMoneyId
                                                                                                      , inDescId_5   := zc_ContainerLinkObject_InfoMoneyDetail()
                                                                                                      , inObjectId_5 := inInfoMoneyId_Detail
                                                                                                       )
                 WHEN inInfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20100() -- �������� � ������� -- select * from lfSelect_Object_InfoMoney() where inInfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20100()
                           -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)������������� 2)����� 3)�������� ��������(��� �������� ��������� ���) 4)������ ���������� 5)������ ����������(����������� �/�)
                           -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)��������� (��) 2)����� 3)�������� ��������(��� �������� ��������� ���) 4)������ ���������� 5)������ ����������(����������� �/�)
                      THEN lpInsertFind_Container (inContainerDescId   := zc_Container_Summ()
                                                 , inParentId          := inContainerId_Goods
                                                 , inObjectId          := inAccountId
                                                 , inJuridicalId_basis := inJuridicalId_basis
                                                 , inBusinessId        := inBusinessId
                                                 , inObjectCostDescId  := zc_ObjectCost_Basis()
                                                                          -- <������� �/�>: 1.)������� �� ���� 2.)������ 3)������ 4)!�������������! 5)����� 6)�������� ��������(��� �������� ��������� ���) 7)������ ���������� 8)������ ����������(����������� �/�)
                                                                          -- <������� �/�>: 1.)������� �� ���� 2.)������ 3)������ 4)��������� (��) 5)����� 6)�������� ��������(��� �������� ��������� ���) 7)������ ���������� 8)������ ����������(����������� �/�)
                                                 , inObjectCostId      := lpInsertFind_ObjectCost (inObjectCostDescId:= zc_ObjectCost_Basis()
                                                                                                 , inDescId_1   := zc_ObjectCostLink_JuridicalBasis()
                                                                                                 , inObjectId_1 := inJuridicalId_basis
                                                                                                 , inDescId_2   := zc_ObjectCostLink_Business()
                                                                                                 , inObjectId_2 := inBusinessId
                                                                                                 , inDescId_3   := zc_ObjectCostLink_Branch()
                                                                                                 , inObjectId_3 := inBranchId
                                                                                                 , inDescId_4   := CASE WHEN inPersonalId <> 0 THEN zc_ObjectCostLink_Personal() ELSE zc_ObjectCostLink_Unit() END
                                                                                                 , inObjectId_4 := CASE WHEN inPersonalId <> 0 AND inOperDate >= zc_DateStart_ObjectCostOnUnit() THEN inPersonalId WHEN inOperDate >= zc_DateStart_ObjectCostOnUnit() THEN inUnitId ELSE NULL END
                                                                                                 , inDescId_5   := zc_ObjectCostLink_Goods()
                                                                                                 , inObjectId_5 := inGoodsId
                                                                                                 , inDescId_6   := zc_ObjectCostLink_AssetTo()
                                                                                                 , inObjectId_6 := inAssetId
                                                                                                 , inDescId_7   := zc_ObjectCostLink_InfoMoney()
                                                                                                 , inObjectId_7 := inInfoMoneyId
                                                                                                 , inDescId_8   := zc_ObjectCostLink_InfoMoneyDetail()
                                                                                                 , inObjectId_8 := inInfoMoneyId_Detail
                                                                                                  )
                                                 , inDescId_1   := CASE WHEN inPersonalId <> 0 THEN zc_ContainerLinkObject_Personal() ELSE zc_ContainerLinkObject_Unit() END
                                                 , inObjectId_1 := CASE WHEN inPersonalId <> 0 THEN inPersonalId ELSE inUnitId END
                                                 , inDescId_2   := zc_ContainerLinkObject_Goods()
                                                 , inObjectId_2 := inGoodsId
                                                 , inDescId_3   := zc_ContainerLinkObject_AssetTo()
                                                 , inObjectId_3 := inAssetId
                                                 , inDescId_4   := zc_ContainerLinkObject_InfoMoney()
                                                 , inObjectId_4 := inInfoMoneyId
                                                 , inDescId_5   := zc_ContainerLinkObject_InfoMoneyDetail()
                                                 , inObjectId_5 := inInfoMoneyId_Detail
                                                  )
                 WHEN inInfoMoneyDestinationId IN (zc_Enum_InfoMoneyDestination_20700()  -- ������    -- select * from lfSelect_Object_InfoMoney() where inInfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20700()
                                                 , zc_Enum_InfoMoneyDestination_20900()  -- ����      -- select * from lfSelect_Object_InfoMoney() where inInfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20900()
                                                 , zc_Enum_InfoMoneyDestination_30100()) -- ��������� -- select * from lfSelect_Object_InfoMoney() where inInfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30100()
                                                                                -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)������������� 2)����� 3)!!!������ ������!!! 4)���� ������� 5)������ ���������� 6)������ ����������(����������� �/�)
                                                                                -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)��������� (��) 2)����� 3)!!!������ ������!!! 4)���� ������� 5)������ ���������� 6)������ ����������(����������� �/�)
                      THEN lpInsertFind_Container (inContainerDescId:= zc_Container_Summ()
                                                 , inParentId          := inContainerId_Goods
                                                 , inObjectId          := inAccountId
                                                 , inJuridicalId_basis := inJuridicalId_basis
                                                 , inBusinessId        := inBusinessId
                                                 , inObjectCostDescId  := zc_ObjectCost_Basis()
                                                                          -- <������� �/�>: 1.)������� �� ���� 2.)������ 3)������ 4)������������� 5)����� 6)!!!������ ������!!! 7)���� ������� 8)������ ���������� 9)������ ����������(����������� �/�)
                                                                          -- <������� �/�>: 1.)������� �� ���� 2.)������ 3)������ 4)��������� (��) 5)����� 6)!!!������ ������!!! 7)���� ������� 8)������ ���������� 9)������ ����������(����������� �/�)
                                                 , inObjectCostId      := lpInsertFind_ObjectCost (inObjectCostDescId:= zc_ObjectCost_Basis()
                                                                                                 , inDescId_1   := zc_ObjectCostLink_JuridicalBasis()
                                                                                                 , inObjectId_1 := inJuridicalId_basis
                                                                                                 , inDescId_2   := zc_ObjectCostLink_Business()
                                                                                                 , inObjectId_2 := inBusinessId
                                                                                                 , inDescId_3   := zc_ObjectCostLink_Branch()
                                                                                                 , inObjectId_3 := inBranchId
                                                                                                 , inDescId_4   := CASE WHEN inPersonalId <> 0 THEN zc_ObjectCostLink_Personal() ELSE zc_ObjectCostLink_Unit() END
                                                                                                 , inObjectId_4 := CASE WHEN inPersonalId <> 0 THEN inPersonalId ELSE inUnitId END
                                                                                                 , inDescId_5   := zc_ObjectCostLink_Goods()
                                                                                                 , inObjectId_5 := inGoodsId
                                                                                                 , inDescId_6   := CASE WHEN inPartionGoodsId <> 0 THEN zc_ObjectCostLink_PartionGoods() ELSE NULL END
                                                                                                 , inObjectId_6 := CASE WHEN inPartionGoodsId <> 0 THEN inPartionGoodsId ELSE NULL END
                                                                                                 , inDescId_7   := zc_ObjectCostLink_GoodsKind()
                                                                                                 , inObjectId_7 := inGoodsKindId
                                                                                                 , inDescId_8   := zc_ObjectCostLink_InfoMoney()
                                                                                                 , inObjectId_8 := inInfoMoneyId
                                                                                                 , inDescId_9   := zc_ObjectCostLink_InfoMoneyDetail()
                                                                                                 , inObjectId_9 := inInfoMoneyId_Detail
                                                                                                  )
                                                 , inDescId_1   := CASE WHEN inPersonalId <> 0 THEN zc_ContainerLinkObject_Personal() ELSE zc_ContainerLinkObject_Unit() END
                                                 , inObjectId_1 := CASE WHEN inPersonalId <> 0 THEN inPersonalId ELSE inUnitId END
                                                 , inDescId_2   := zc_ContainerLinkObject_Goods()
                                                 , inObjectId_2 := inGoodsId
                                                 , inDescId_3   := CASE WHEN inPartionGoodsId <> 0 THEN zc_ContainerLinkObject_PartionGoods() ELSE NULL END
                                                 , inObjectId_3 := CASE WHEN inPartionGoodsId <> 0 THEN inPartionGoodsId ELSE NULL END
                                                 , inDescId_4   := zc_ContainerLinkObject_GoodsKind()
                                                 , inObjectId_4 := inGoodsKindId
                                                 , inDescId_5   := zc_ContainerLinkObject_InfoMoney()
                                                 , inObjectId_5 := inInfoMoneyId
                                                 , inDescId_6   := zc_ContainerLinkObject_InfoMoneyDetail()
                                                 , inObjectId_6 := inInfoMoneyId_Detail
                                                  )
                 WHEN inInfoMoneyDestinationId IN (zc_Enum_InfoMoneyDestination_20500()) -- 20500; "��������� ����" -- select * from lfSelect_Object_InfoMoney() where inInfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20500()
                           -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)����� 2)������ ���������� 3)������ ����������(����������� �/�)
                      THEN lpInsertFind_Container (inContainerDescId   := zc_Container_Summ()
                                                 , inParentId          := NULL -- !!!�������� �������� �� ������� � ��������������!!!
                                                 , inObjectId          := inAccountId
                                                 , inJuridicalId_basis := inJuridicalId_basis
                                                 , inBusinessId        := inBusinessId
                                                 , inObjectCostDescId  := zc_ObjectCost_Basis()
                                                                          -- <������� �/�>: 1.)������� �� ���� 2.)������ 3)����� 4)������ ���������� 5)������ ����������(����������� �/�)
                                                 , inObjectCostId      := lpInsertFind_ObjectCost (inObjectCostDescId:= zc_ObjectCost_Basis()
                                                                                                 , inDescId_1   := zc_ObjectCostLink_JuridicalBasis()
                                                                                                 , inObjectId_1 := inJuridicalId_basis
                                                                                                 , inDescId_2   := zc_ObjectCostLink_Business()
                                                                                                 , inObjectId_2 := inBusinessId
                                                                                                 , inDescId_3   := zc_ObjectCostLink_Branch()
                                                                                                 , inObjectId_3 := NULL
                                                                                                 , inDescId_4   := zc_ObjectCostLink_Unit()
                                                                                                 , inObjectId_4 := NULL
                                                                                                 , inDescId_5   := zc_ObjectCostLink_Goods()
                                                                                                 , inObjectId_5 := inGoodsId
                                                                                                 , inDescId_6   := zc_ObjectCostLink_InfoMoney()
                                                                                                 , inObjectId_6 := inInfoMoneyId
                                                                                                 , inDescId_7   := zc_ObjectCostLink_InfoMoneyDetail()
                                                                                                 , inObjectId_7 := inInfoMoneyId_Detail
                                                                                                  )
                                                 , inDescId_1   := zc_ContainerLinkObject_Unit()
                                                 , inObjectId_1 := NULL
                                                 , inDescId_2   := zc_ContainerLinkObject_Goods()
                                                 , inObjectId_2 := inGoodsId
                                                 , inDescId_4   := zc_ContainerLinkObject_InfoMoney()
                                                 , inObjectId_4 := inInfoMoneyId
                                                 , inDescId_5   := zc_ContainerLinkObject_InfoMoneyDetail()
                                                 , inObjectId_5 := inInfoMoneyId_Detail
                                                  )
                      -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)������������� 2)����� 3)������ ���������� 4)������ ����������(����������� �/�)
                      -- 0.1.)���� 0.2.)������� �� ���� 0.3.)������ 1)��������� (��) 2)����� 3)������ ���������� 4)������ ����������(����������� �/�)
                 ELSE lpInsertFind_Container (inContainerDescId:= zc_Container_Summ()
                                            , inParentId          := inContainerId_Goods
                                            , inObjectId          := inAccountId
                                            , inJuridicalId_basis := inJuridicalId_basis
                                            , inBusinessId        := inBusinessId
                                            , inObjectCostDescId  := zc_ObjectCost_Basis()
                                                                     -- <������� �/�>: 1.)������� �� ���� 2.)������ 3)������ 4)!�������������! 5)����� 6)������ ���������� 7)������ ����������(����������� �/�)
                                                                     -- <������� �/�>: 1.)������� �� ���� 2.)������ 3)������ 4)��������� (��) 5)����� 6)������ ���������� 7)������ ����������(����������� �/�)
                                            , inObjectCostId      := lpInsertFind_ObjectCost (inObjectCostDescId:= zc_ObjectCost_Basis()
                                                                                            , inDescId_1   := zc_ObjectCostLink_JuridicalBasis()
                                                                                            , inObjectId_1 := inJuridicalId_basis
                                                                                            , inDescId_2   := zc_ObjectCostLink_Business()
                                                                                            , inObjectId_2 := inBusinessId
                                                                                            , inDescId_3   := zc_ObjectCostLink_Branch()
                                                                                            , inObjectId_3 := inBranchId
                                                                                            , inDescId_4   := CASE WHEN inPersonalId <> 0 THEN zc_ObjectCostLink_Personal() ELSE zc_ObjectCostLink_Unit() END
                                                                                            , inObjectId_4 := CASE WHEN inPersonalId <> 0 AND inOperDate >= zc_DateStart_ObjectCostOnUnit() THEN inPersonalId WHEN inOperDate >= zc_DateStart_ObjectCostOnUnit() THEN inUnitId ELSE NULL END
                                                                                            , inDescId_5   := zc_ObjectCostLink_Goods()
                                                                                            , inObjectId_5 := inGoodsId
                                                                                            , inDescId_6   := zc_ObjectCostLink_InfoMoney()
                                                                                            , inObjectId_6 := inInfoMoneyId
                                                                                            , inDescId_7   := zc_ObjectCostLink_InfoMoneyDetail()
                                                                                            , inObjectId_7 := inInfoMoneyId_Detail
                                                                                             )
                                            , inDescId_1   := CASE WHEN inPersonalId <> 0 THEN zc_ContainerLinkObject_Personal() ELSE zc_ContainerLinkObject_Unit() END
                                            , inObjectId_1 := CASE WHEN inPersonalId <> 0 THEN inPersonalId ELSE inUnitId END
                                            , inDescId_2   := zc_ContainerLinkObject_Goods()
                                            , inObjectId_2 := inGoodsId
                                            , inDescId_3   := zc_ContainerLinkObject_InfoMoney()
                                            , inObjectId_3 := inInfoMoneyId
                                            , inDescId_4   := zc_ContainerLinkObject_InfoMoneyDetail()
                                            , inObjectId_4 := inInfoMoneyId_Detail
                                             )
            END
            INTO vbContainerId;


     -- ���������� ��������
     RETURN (vbContainerId);

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION lpInsertUpdate_ContainerSumm_Goods (TDateTime, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Boolean, Integer, Integer) OWNER TO postgres;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 16.09.13                                        *
*/

-- ����
-- SELECT * FROM lpInsertUpdate_ContainerSumm_Goods ()