-- Function: lpInsertUpdate_ContainerCount_Goods (TDateTime, Integer, Integer, Integer, Integer, Integer, Boolean, Integer, Integer)

-- DROP FUNCTION lpInsertUpdate_ContainerCount_Goods (TDateTime, Integer, Integer, Integer, Integer, Integer, Boolean, Integer, Integer);

CREATE OR REPLACE FUNCTION lpInsertUpdate_ContainerCount_Goods (
    IN inOperDate               TDateTime, 
    IN inUnitId                 Integer , 
    IN inPersonalId             Integer , 
    IN inInfoMoneyDestinationId Integer , 
    IN inGoodsId                Integer , 
    IN inGoodsKindId            Integer , 
    IN inIsPartionCount         Boolean , 
    IN inPartionGoodsId         Integer , 
    IN inAssetId                Integer
)
  RETURNS Integer
AS
$BODY$
   DECLARE vbContainerId Integer;
BEGIN

     SELECT CASE WHEN inInfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10100() -- ������ ����� -- select * from lfSelect_Object_InfoMoney() where inInfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10100()
                           -- 0)����� 1)������������� 2)!������ ������!
                           -- 0)����� 1)��������� (��) 2)!������ ������!
                      THEN lpInsertFind_Container (inContainerDescId   := zc_Container_Count()
                                                 , inParentId          := NULL
                                                 , inObjectId          := inGoodsId
                                                 , inJuridicalId_basis := NULL
                                                 , inBusinessId        := NULL
                                                 , inObjectCostDescId  := NULL
                                                 , inObjectCostId      := NULL
                                                 , inDescId_1          := CASE WHEN COALESCE (inPersonalId, 0) <> 0 THEN zc_ContainerLinkObject_Personal() ELSE zc_ContainerLinkObject_Unit() END
                                                 , inObjectId_1        := CASE WHEN COALESCE (inPersonalId, 0) <> 0 THEN inPersonalId ELSE COALESCE (inUnitId, 0) END
                                                 , inDescId_2          := zc_ContainerLinkObject_PartionGoods()
                                                 , inObjectId_2        := CASE WHEN inIsPartionCount THEN inPartionGoodsId ELSE NULL END
                                                  )
                 WHEN inInfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20100() -- �������� � ������� -- select * from lfSelect_Object_InfoMoney() where inInfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20100()
                           -- 0)����� 1)������������� 2)�������� ��������(��� �������� ��������� ���)
                           -- 0)����� 1)��������� (��) 2)�������� ��������(��� �������� ��������� ���)
                      THEN lpInsertFind_Container (inContainerDescId   := zc_Container_Count()
                                                 , inParentId          := NULL
                                                 , inObjectId          := inGoodsId
                                                 , inJuridicalId_basis := NULL
                                                 , inBusinessId        := NULL
                                                 , inObjectCostDescId  := NULL
                                                 , inObjectCostId      := NULL
                                                 , inDescId_1          := CASE WHEN COALESCE (inPersonalId, 0) <> 0 THEN zc_ContainerLinkObject_Personal() ELSE zc_ContainerLinkObject_Unit() END
                                                 , inObjectId_1        := CASE WHEN COALESCE (inPersonalId, 0) <> 0 THEN inPersonalId ELSE COALESCE (inUnitId, 0) END
                                                 , inDescId_2          := zc_ContainerLinkObject_AssetTo()
                                                 , inObjectId_2        := inAssetId
                                                  )
                  WHEN inInfoMoneyDestinationId IN (zc_Enum_InfoMoneyDestination_20700()  -- ������    -- select * from lfSelect_Object_InfoMoney() where inInfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20700()
                                                  , zc_Enum_InfoMoneyDestination_20900()  -- ����      -- select * from lfSelect_Object_InfoMoney() where inInfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20900()
                                                  , zc_Enum_InfoMoneyDestination_30100()) -- ��������� -- select * from lfSelect_Object_InfoMoney() where inInfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30100()
                            -- 0)����� 1)������������� 2)��� ������ 3)!!!������ ������!!!
                            -- 0)����� 1)��������� (��) 2)��� ������ 3)!!!������ ������!!!
                       THEN lpInsertFind_Container (inContainerDescId   := zc_Container_Count()
                                                  , inParentId          := NULL
                                                  , inObjectId          := inGoodsId
                                                  , inJuridicalId_basis := NULL
                                                  , inBusinessId        := NULL
                                                  , inObjectCostDescId  := NULL
                                                  , inObjectCostId      := NULL
                                                  , inDescId_1          := CASE WHEN COALESCE (inPersonalId, 0) <> 0 THEN zc_ContainerLinkObject_Personal() ELSE zc_ContainerLinkObject_Unit() END
                                                  , inObjectId_1        := CASE WHEN COALESCE (inPersonalId, 0) <> 0 THEN inPersonalId ELSE COALESCE (inUnitId, 0) END
                                                  , inDescId_2          := zc_ContainerLinkObject_GoodsKind()
                                                  , inObjectId_2        := inGoodsKindId
                                                  , inDescId_3          := CASE WHEN inPartionGoodsId <> 0 THEN zc_ContainerLinkObject_PartionGoods() ELSE NULL END
                                                  , inObjectId_3        := CASE WHEN inPartionGoodsId <> 0 THEN inPartionGoodsId ELSE NULL END
                                                   )
                      -- 0)����� 1)�������������
                      -- 0)����� 1)��������� (��)
                 ELSE lpInsertFind_Container (inContainerDescId   := zc_Container_Count()
                                            , inParentId          := NULL
                                            , inObjectId          := inGoodsId
                                            , inJuridicalId_basis := NULL
                                            , inBusinessId        := NULL
                                            , inObjectCostDescId  := NULL
                                            , inObjectCostId      := NULL
                                            , inDescId_1          := CASE WHEN COALESCE (inPersonalId, 0) <> 0 THEN zc_ContainerLinkObject_Personal() ELSE zc_ContainerLinkObject_Unit() END
                                            , inObjectId_1        := CASE WHEN COALESCE (inPersonalId, 0) <> 0 THEN inPersonalId ELSE COALESCE (inUnitId, 0) END
                                             )
            END
            INTO vbContainerId;


     -- ���������� ��������
     RETURN (vbContainerId);

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION lpInsertUpdate_ContainerCount_Goods (TDateTime, Integer, Integer, Integer, Integer, Integer, Boolean, Integer, Integer) OWNER TO postgres;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 16.09.13                                        *
*/

-- ����
-- SELECT * FROM lpInsertUpdate_ContainerCount_Goods ()