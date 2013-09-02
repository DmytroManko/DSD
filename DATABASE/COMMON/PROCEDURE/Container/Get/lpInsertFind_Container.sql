-- Function: lpInsertFind_Container 

-- DROP FUNCTION lpInsertFind_Container (Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer);

CREATE OR REPLACE FUNCTION lpInsertFind_Container(
    IN inContainerDescId         Integer  , -- DescId �������
    IN inParentId                Integer  , -- ������� Container
    IN inObjectId                Integer  , -- ������ (���� ��� ����� ��� ...)
    IN inJuridicalId_basis       Integer  , -- ������� ����������� ����
    IN inBusinessId              Integer  , -- �������
    IN inObjectCostDescId        Integer  , -- DescId ��� <������� �/�>
    IN inObjectCostId            Integer  , -- <������� �/�> - ��������� ��������� ����� 
    IN inDescId_1                Integer  DEFAULT NULL , -- DescId ��� 1-�� ���������
    IN inObjectId_1              Integer  DEFAULT NULL , -- ObjectId ��� 1-�� ���������
    IN inDescId_2                Integer  DEFAULT NULL , -- DescId ��� 2-�� ���������
    IN inObjectId_2              Integer  DEFAULT NULL , -- ObjectId ��� 2-�� ���������
    IN inDescId_3                Integer  DEFAULT NULL , -- DescId ��� 3-�� ���������
    IN inObjectId_3              Integer  DEFAULT NULL , -- ObjectId ��� 3-�� ���������
    IN inDescId_4                Integer  DEFAULT NULL , -- DescId ��� 4-�� ���������
    IN inObjectId_4              Integer  DEFAULT NULL , -- ObjectId ��� 4-�� ���������
    IN inDescId_5                Integer  DEFAULT NULL , -- DescId ��� 5-�� ���������
    IN inObjectId_5              Integer  DEFAULT NULL , -- ObjectId ��� 5-�� ���������
    IN inDescId_6                Integer  DEFAULT NULL , -- DescId ��� 6-�� ���������
    IN inObjectId_6              Integer  DEFAULT NULL , -- ObjectId ��� 6-�� ���������
    IN inDescId_7                Integer  DEFAULT NULL , -- DescId ��� 7-�� ���������
    IN inObjectId_7              Integer  DEFAULT NULL , -- ObjectId ��� 7-�� ���������
    IN inDescId_8                Integer  DEFAULT NULL , -- DescId ��� 8-�� ���������
    IN inObjectId_8              Integer  DEFAULT NULL , -- ObjectId ��� 8-�� ���������
    IN inDescId_9                Integer  DEFAULT NULL , -- DescId ��� 9-�� ���������
    IN inObjectId_9              Integer  DEFAULT NULL , -- ObjectId ��� 9-�� ���������
    IN inDescId_10               Integer  DEFAULT NULL , -- DescId ��� 10-�� ���������
    IN inObjectId_10             Integer  DEFAULT NULL   -- ObjectId ��� 10-�� ���������
)
RETURNS Integer AS
$BODY$
   DECLARE vbContainerId Integer;
   DECLARE vbRecordCount Integer;
BEGIN

     -- ������� ����������
     DELETE FROM _tmpContainer;

     -- ���������
     INSERT INTO _tmpContainer (DescId, ObjectId)
        SELECT zc_ContainerLinkObject_JuridicalBasis(), inJuridicalId_basis WHERE inContainerDescId = zc_Container_Summ()
       UNION ALL
        SELECT zc_ContainerLinkObject_Business(), inBusinessId WHERE inContainerDescId = zc_Container_Summ()

       UNION ALL
        SELECT inDescId_1, COALESCE (inObjectId_1, 0) WHERE inDescId_1 <> 0
       UNION ALL
        SELECT inDescId_2, COALESCE (inObjectId_2, 0) WHERE inDescId_2 <> 0
       UNION ALL
        SELECT inDescId_3, COALESCE (inObjectId_3, 0) WHERE inDescId_3 <> 0
       UNION ALL
        SELECT inDescId_4, COALESCE (inObjectId_4, 0) WHERE inDescId_4 <> 0
       UNION ALL
        SELECT inDescId_5, COALESCE (inObjectId_5, 0) WHERE inDescId_5 <> 0
       UNION ALL
        SELECT inDescId_6, COALESCE (inObjectId_6, 0) WHERE inDescId_6 <> 0
       UNION ALL
        SELECT inDescId_7, COALESCE (inObjectId_7, 0) WHERE inDescId_7 <> 0
       UNION ALL
        SELECT inDescId_8, COALESCE (inObjectId_8, 0) WHERE inDescId_8 <> 0
       UNION ALL
        SELECT inDescId_9, COALESCE (inObjectId_9, 0) WHERE inDescId_9 <> 0
       UNION ALL
        SELECT inDescId_10, COALESCE (inObjectId_10, 0) WHERE inDescId_10 <> 0
        ;

     -- ���������� ���������� ��������
     SELECT COUNT(*) INTO vbRecordCount FROM _tmpContainer;

     -- ��������
     IF EXISTS (SELECT COUNT(*)
                FROM (SELECT Container.Id
                      FROM Container
                           JOIN ContainerLinkObject ON ContainerLinkObject.ContainerId = Container.Id
                           JOIN _tmpContainer ON _tmpContainer.ObjectId = ContainerLinkObject.ObjectId
                                             AND _tmpContainer.DescId = ContainerLinkObject.DescId
                      WHERE Container.ObjectId = inObjectId
                        AND Container.DescId = inContainerDescId
                      GROUP BY Container.Id
                      HAVING COUNT(*) = vbRecordCount
                     ) AS _tmpCheck
                HAVING COUNT(*) > 1)
     THEN 
         RAISE EXCEPTION '���� �� �������� : vbRecordCount = "%", inContainerDescId = "%", inParentId = "%", inObjectId = "%", inJuridicalId_basis = "%", inBusinessId = "%", inObjectCostDescId = "%", inObjectCostId = "%", inDescId_1 = "%", inObjectId_1 = "%", inDescId_2 = "%", inObjectId_2 = "%", inDescId_3 = "%", inObjectId_3 = "%", inDescId_4 = "%", inObjectId_4 = "%", inDescId_5 = "%", inObjectId_5 = "%", inDescId_6 = "%", inObjectId_6 = "%", inDescId_7 = "%", inObjectId_7 = "%"', vbRecordCount, inContainerDescId, inParentId, inObjectId, inJuridicalId_basis, inBusinessId, inObjectCostDescId, inObjectCostId, inDescId_1, inObjectId_1, inDescId_2, inObjectId_2, inDescId_3, inObjectId_3, inDescId_4, inObjectId_4, inDescId_5, inObjectId_5, inDescId_6, inObjectId_6, inDescId_7, inObjectId_7;
     END IF;


     -- �������
     vbContainerId:= (SELECT Container.Id
                      FROM Container
                           JOIN ContainerLinkObject ON ContainerLinkObject.ContainerId = Container.Id
                           JOIN _tmpContainer ON _tmpContainer.ObjectId = ContainerLinkObject.ObjectId
                                             AND _tmpContainer.DescId = ContainerLinkObject.DescId
                      WHERE Container.ObjectId = inObjectId
                        AND Container.DescId = inContainerDescId
                      GROUP BY Container.Id
                      HAVING COUNT(*) = vbRecordCount);


     -- ������ ����
     -- drop TABLE _test CREATE TABLE _test(   DescId                INTEGER,    ObjectId Integer, inObjectId Integer, vbContainerId Integer)
     -- delete from _test
     -- insert into _test (DescId, ObjectId, inObjectId, vbContainerId)
     -- select DescId, ObjectId, inObjectId, vbContainerId from _tmpContainer;

     -- ���� �� �����, ���������
     IF COALESCE (vbContainerId, 0) = 0
     THEN
         -- �������� �������
         INSERT INTO Container (DescId, ObjectId, ParentId, Amount)
                        VALUES (inContainerDescId, inObjectId, CASE WHEN inParentId = 0 THEN NULL ELSE inParentId END, 0)
            RETURNING Id INTO vbContainerId;

         -- �������� ���������
         INSERT INTO ContainerLinkObject (DescId, ContainerId, ObjectId)
            SELECT DescId, vbContainerId, ObjectId FROM _tmpContainer;
     ELSE
         UPDATE Container SET ParentId = CASE WHEN COALESCE (inParentId, 0) = 0 THEN NULL ELSE inParentId END
         WHERE Id = vbContainerId AND COALESCE (ParentId, 0) <> COALESCE (inParentId, 0);
     END IF;  

     -- ���� ���� ��������� <������� �/�.>
     IF COALESCE (inObjectCostDescId, 0) <> 0
     THEN
         -- ������������� ����� ��������
         UPDATE ContainerObjectCost SET ObjectCostId = inObjectCostId WHERE ContainerId = vbContainerId AND ObjectCostDescId = inObjectCostDescId;
         -- ���� �� �����, ���������
         IF NOT FOUND
         THEN
             INSERT INTO ContainerObjectCost (ObjectCostDescId, ContainerId, ObjectCostId)
                                      VALUES (inObjectCostDescId, vbContainerId, inObjectCostId);
         END IF;  
     END IF;  


     -- ���������� ��������
     RETURN (vbContainerId);


END;
$BODY$
LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION lpInsertFind_Container (Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer) OWNER TO postgres;

  
/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 02.09.13                                        * add ��������
 11.07.13                                        * add inObjectCostDescId and inObjectCostId
 11.07.13                                        * add inParentId
 09.07.13                                        * !!! finich !!!
 08.07.13                                        * optimize
 04.07.13                                        * rename AccountId to ObjectId
 04.07.13                                        * Amount
 03.07.13                                        * �� ��� �������, �������� �� ��������� :)))
 02.07.13                                        * � ������� ����������
*/

-- ����
/*
CREATE TEMP TABLE _tmpContainer (DescId Integer, ObjectId Integer) ON COMMIT DROP;
SELECT * FROM lpInsertFind_Container (inContainerDescId:= zc_Container_Summ()
                                    , inParentId:= 0
                                    , inObjectId:= lpInsertFind_Object_Account (inAccountGroupId:= zc_Enum_AccountGroup_20000() -- 20000; "������" -- select * from gpSelect_Object_AccountGroup ('2') where Id = zc_Enum_AccountGroup_20000()
                                                                              , inAccountDirectionId:= 23581
                                                                              , inInfoMoneyDestinationId:= zc_Enum_InfoMoneyDestination_10100()
                                                                              , inInfoMoneyId:= NULL
                                                                              , inUserId:= 2
                                                                               )
                                    , inJuridicalId_basis:= 23966
                                    , inBusinessId       := 21709
                                    , inObjectCostDescId := NULL
                                    , inObjectCostId     := NULL
                                    , inDescId_1   := zc_ContainerLinkObject_Unit()
                                    , inObjectId_1 := 21720
                                    , inDescId_2   := zc_ContainerLinkObject_Goods()
                                    , inObjectId_2 := 4341
                                    , inDescId_3   := NULL
                                    , inObjectId_3 := NULL
                                    , inDescId_4   := zc_ContainerLinkObject_InfoMoney()
                                    , inObjectId_4 := 23463
                                    , inDescId_5   := zc_ContainerLinkObject_InfoMoneyDetail()
                                    , inObjectId_5 := 23463
                                    , inDescId_6:= NULL, inObjectId_6:=NULL, inDescId_7:= NULL, inObjectId_7:=NULL, inDescId_8:= NULL, inObjectId_8:=NULL, inDescId_9:= NULL, inObjectId_9:=NULL, inDescId_10:= NULL, inObjectId_10:=NULL
                                     )

*/