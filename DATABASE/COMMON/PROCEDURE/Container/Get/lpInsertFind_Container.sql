-- Function: lpInsertFind_Container (Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer);

-- DROP FUNCTION lpInsertFind_Container (Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer);

CREATE OR REPLACE FUNCTION lpInsertFind_Container(
    IN inContainerDescId         Integer  , -- DescId �������
    IN inObjectId                Integer  , -- ����� 
    IN inJuridicalId_basis       Integer  , -- ������� ����������� ����
    IN inBusinessId              Integer  , -- �������
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
BEGIN

   -- ������� - ��������� �������
   -- CREATE TEMP TABLE _tmpContainer (DescId Integer, ObjectId Integer) ON COMMIT DROP;

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

   /* ����� ��� ����� ������ ������, � ��������� ��� ���� ������ ������ �� ����������...
   SELECT Container.Id INTO vbContainerId
   FROM Container
        JOIN _tmpContainer ON _tmpContainer.ObjectId = COALESCE (ContainerLinkObject.ObjectId, 0)
                          AND _tmpContainer.DescId = ContainerLinkObject.DescId
        JOIN ContainerLinkObject ON ContainerLinkObject.ContainerId = Container.Id
        JOIN _tmpContainer ON _tmpContainer.ObjectId = COALESCE (ContainerLinkObject.ObjectId, 0)
                          AND _tmpContainer.DescId = ContainerLinkObject.DescId
   WHERE Container.ObjectId = inObjectId
     AND Container.DescId = inContainerDescId;*/


   -- �������
   SELECT Container.Id INTO vbContainerId
   FROM Container
        LEFT JOIN ContainerLinkObject AS ContainerLinkObject_01
                                      ON ContainerLinkObject_01.ObjectId = inJuridicalId_basis
                                     AND ContainerLinkObject_01.DescId = zc_ContainerLinkObject_JuridicalBasis()
                                     AND ContainerLinkObject_01.ContainerId = Container.Id
        LEFT JOIN ContainerLinkObject AS ContainerLinkObject_02
                                      ON ContainerLinkObject_02.ObjectId = inBusinessId
                                     AND ContainerLinkObject_02.DescId = zc_ContainerLinkObject_Business()
                                     AND ContainerLinkObject_02.ContainerId = Container.Id
        LEFT JOIN ContainerLinkObject AS ContainerLinkObject_1
                                      ON ContainerLinkObject_1.ObjectId = inObjectId_1
                                     AND ContainerLinkObject_1.DescId = inDescId_1
                                     AND ContainerLinkObject_1.ContainerId = Container.Id
        LEFT JOIN ContainerLinkObject AS ContainerLinkObject_2
                                      ON ContainerLinkObject_2.ObjectId = inObjectId_2
                                     AND ContainerLinkObject_2.DescId = inDescId_2
                                     AND ContainerLinkObject_2.ContainerId = Container.Id
        LEFT JOIN ContainerLinkObject AS ContainerLinkObject_3
                                      ON ContainerLinkObject_3.ObjectId = inObjectId_3
                                     AND ContainerLinkObject_3.DescId = inDescId_3
                                     AND ContainerLinkObject_3.ContainerId = Container.Id
        LEFT JOIN ContainerLinkObject AS ContainerLinkObject_4
                                      ON ContainerLinkObject_4.ObjectId = inObjectId_4
                                     AND ContainerLinkObject_4.DescId = inDescId_4
                                     AND ContainerLinkObject_4.ContainerId = Container.Id
        LEFT JOIN ContainerLinkObject AS ContainerLinkObject_5
                                      ON ContainerLinkObject_5.ObjectId = inObjectId_5
                                     AND ContainerLinkObject_5.DescId = inDescId_5
                                     AND ContainerLinkObject_5.ContainerId = Container.Id
        LEFT JOIN ContainerLinkObject AS ContainerLinkObject_6
                                      ON ContainerLinkObject_6.ObjectId = inObjectId_6
                                     AND ContainerLinkObject_6.DescId = inDescId_6
                                     AND ContainerLinkObject_6.ContainerId = Container.Id
        LEFT JOIN ContainerLinkObject AS ContainerLinkObject_7
                                      ON ContainerLinkObject_7.ObjectId = inObjectId_7
                                     AND ContainerLinkObject_7.DescId = inDescId_7
                                     AND ContainerLinkObject_7.ContainerId = Container.Id
        LEFT JOIN ContainerLinkObject AS ContainerLinkObject_8
                                      ON ContainerLinkObject_8.ObjectId = inObjectId_8
                                     AND ContainerLinkObject_8.DescId = inDescId_8
                                     AND ContainerLinkObject_8.ContainerId = Container.Id
        LEFT JOIN ContainerLinkObject AS ContainerLinkObject_9
                                      ON ContainerLinkObject_9.ObjectId = inObjectId_9
                                     AND ContainerLinkObject_9.DescId = inDescId_9
                                     AND ContainerLinkObject_9.ContainerId = Container.Id
        LEFT JOIN ContainerLinkObject AS ContainerLinkObject_10
                                      ON ContainerLinkObject_10.ObjectId = inObjectId_10
                                     AND ContainerLinkObject_10.DescId = inDescId_10
                                     AND ContainerLinkObject_10.ContainerId = Container.Id
   WHERE Container.ObjectId = inObjectId
     AND Container.DescId = inContainerDescId
     AND (ContainerLinkObject_01.ObjectId IS NOT NULL OR inContainerDescId = zc_Container_Count())
     AND (ContainerLinkObject_02.ObjectId IS NOT NULL OR inContainerDescId = zc_Container_Count())
     AND (ContainerLinkObject_1.ObjectId IS NOT NULL OR COALESCE (inDescId_1, 0) = 0)
     AND (ContainerLinkObject_2.ObjectId IS NOT NULL OR COALESCE (inDescId_2, 0) = 0)
     AND (ContainerLinkObject_3.ObjectId IS NOT NULL OR COALESCE (inDescId_3, 0) = 0)
     AND (ContainerLinkObject_4.ObjectId IS NOT NULL OR COALESCE (inDescId_4, 0) = 0)
     AND (ContainerLinkObject_5.ObjectId IS NOT NULL OR COALESCE (inDescId_5, 0) = 0)
     AND (ContainerLinkObject_6.ObjectId IS NOT NULL OR COALESCE (inDescId_6, 0) = 0)
     AND (ContainerLinkObject_7.ObjectId IS NOT NULL OR COALESCE (inDescId_7, 0) = 0)
     AND (ContainerLinkObject_8.ObjectId IS NOT NULL OR COALESCE (inDescId_8, 0) = 0)
     AND (ContainerLinkObject_9.ObjectId IS NOT NULL OR COALESCE (inDescId_9, 0) = 0)
     AND (ContainerLinkObject_10.ObjectId IS NOT NULL OR COALESCE (inDescId_10, 0) = 0)
   ;


   -- ������ ����
   -- drop TABLE _test CREATE TABLE _test(   DescId                INTEGER,    ObjectId Integer, inObjectId Integer, vbContainerId Integer)
   -- delete from _test
   -- insert into _test (DescId, ObjectId, inObjectId, vbContainerId)
   -- select DescId, ObjectId, inObjectId, vbContainerId from _tmpContainer;

   -- ���� �� �����, ���������
   IF NOT FOUND
   THEN
       -- �������� �������
       INSERT INTO Container (DescId, ObjectId, Amount)
           VALUES (inContainerDescId, inObjectId, 0) RETURNING Id INTO  vbContainerId;

       -- �������� ���������
       INSERT INTO ContainerLinkObject (DescId, ContainerId, ObjectId)
          SELECT DescId, vbContainerId, ObjectId FROM _tmpContainer;

   END IF;  

   -- ���������� ��������
   RETURN (vbContainerId);


END;
$BODY$
LANGUAGE PLPGSQL VOLATILE;

ALTER FUNCTION lpInsertFind_Container (Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer)  OWNER TO postgres;

  
/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.


 04.07.13                                        * rename AccountId to ObjectId
 04.07.13                                        * Amount
 03.07.13                                        * �� ��� �������, �������� �� ��������� :)))
 02.07.13                                        * � ������� ����������
*/

-- ����
/*
SELECT * FROM lpInsertFind_Container (inContainerDescId:= zc_Container_Summ()
                                    , inObjectId:= lpInsertFind_Object_Account (inAccountGroupId:= zc_Enum_AccountGroup_20000() -- 20000; "������" -- select * from gpSelect_Object_AccountGroup ('2') where Id = zc_Enum_AccountGroup_20000()
                                                                              , inAccountDirectionId:= 23581
                                                                              , inInfoMoneyDestinationId:= zc_Enum_InfoMoneyDestination_10100()
                                                                              , inInfoMoneyId:= NULL
                                                                              , inUserId:= 2
                                                                               )
                                    , inJuridicalId_basis:= 23966
                                    , inBusinessId       := 21709
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