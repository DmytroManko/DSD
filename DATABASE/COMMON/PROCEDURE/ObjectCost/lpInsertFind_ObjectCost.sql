-- Function: lpInsertFind_ObjectCost

-- DROP FUNCTION lpInsertFind_ObjectCost (Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer);

CREATE OR REPLACE FUNCTION lpInsertFind_ObjectCost(
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
   DECLARE vbObjectCostId Integer;
   DECLARE vbRecordCount Integer;
BEGIN

     -- ������� ����������
     DELETE FROM _tmpObjectCost;

     -- ���������
     INSERT INTO _tmpObjectCost (DescId, ObjectId)
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
     SELECT COUNT(*) INTO vbRecordCount FROM _tmpObjectCost;

     -- �������
     vbObjectCostId:=(SELECT ObjectCost.ObjectCostId
                      FROM _tmpObjectCost
                           JOIN ObjectCost ON ObjectCost.ObjectId = _tmpObjectCost.ObjectId
                                          AND ObjectCost.DescId = _tmpObjectCost.DescId
                      GROUP BY ObjectCost.ObjectCostId
                      HAVING COUNT(*) = vbRecordCount);

     -- ���� �� �����, ���������
     IF NOT FOUND
     THEN
         -- ���������� ����� ObjectCostId
         SELECT NEXTVAL ('objectcost_id_seq') INTO vbObjectCostId;

         -- �������� ���������
         INSERT INTO ObjectCost (DescId, ObjectCostId, ObjectId)
            SELECT DescId, vbObjectCostId, ObjectId FROM _tmpObjectCost;

     END IF;  

     -- ���������� ��������
     RETURN (vbObjectCostId);


END;
$BODY$
LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION lpInsertFind_ObjectCost (Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer)  OWNER TO postgres;

  
/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.

 10.07.13                                        *
*/

-- ����
/*
SELECT * FROM lpInsertFind_ObjectCost (inObjectCostDescId:= zc_ObjectCost_Summ()
                                    , inParentId:= 0
                                    , inObjectId:= lpInsertFind_Object_Account (inAccountGroupId:= zc_Enum_AccountGroup_20000() -- 20000; "������" -- select * from gpSelect_Object_AccountGroup ('2') where Id = zc_Enum_AccountGroup_20000()
                                                                              , inAccountDirectionId:= 23581
                                                                              , inInfoMoneyDestinationId:= zc_Enum_InfoMoneyDestination_10100()
                                                                              , inInfoMoneyId:= NULL
                                                                              , inUserId:= 2
                                                                               )
                                    , inJuridicalId_basis:= 23966
                                    , inBusinessId       := 21709
                                    , inDescId_1   := zc_ObjectCostLinkObject_Unit()
                                    , inObjectId_1 := 21720
                                    , inDescId_2   := zc_ObjectCostLinkObject_Goods()
                                    , inObjectId_2 := 4341
                                    , inDescId_3   := NULL
                                    , inObjectId_3 := NULL
                                    , inDescId_4   := zc_ObjectCostLinkObject_InfoMoney()
                                    , inObjectId_4 := 23463
                                    , inDescId_5   := zc_ObjectCostLinkObject_InfoMoneyDetail()
                                    , inObjectId_5 := 23463
                                    , inDescId_6:= NULL, inObjectId_6:=NULL, inDescId_7:= NULL, inObjectId_7:=NULL, inDescId_8:= NULL, inObjectId_8:=NULL, inDescId_9:= NULL, inObjectId_9:=NULL, inDescId_10:= NULL, inObjectId_10:=NULL
                                     )

*/