-- Function: lpInsertFind_ObjectCost

-- DROP FUNCTION lpInsertFind_ObjectCost (Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer);

CREATE OR REPLACE FUNCTION lpInsertFind_ObjectCost(
    IN inObjectCostDescId        Integer               , -- DescId ��� <������� �/�>
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
     vbObjectCostId:=(SELECT ObjectCostLink.ObjectCostId
                      FROM _tmpObjectCost
                           JOIN ObjectCostLink ON ObjectCostLink.ObjectId = _tmpObjectCost.ObjectId
                                              AND ObjectCostLink.DescId = _tmpObjectCost.DescId
                                              AND ObjectCostLink.ObjectCostDescId = inObjectCostDescId
                      GROUP BY ObjectCostLink.ObjectCostId
                      HAVING COUNT(*) = vbRecordCount);

     -- ���� �� �����, ���������
     IF COALESCE (vbObjectCostId, 0) = 0
     THEN
         -- ���������� ����� ObjectCostId
         SELECT NEXTVAL ('objectcost_id_seq') INTO vbObjectCostId;

         -- �������� ���������
         INSERT INTO ObjectCostLink (DescId, ObjectCostDescId, ObjectCostId, ObjectId)
            SELECT DescId, inObjectCostDescId, vbObjectCostId, ObjectId FROM _tmpObjectCost;

     END IF;  

     -- ���������� ��������
     RETURN (vbObjectCostId);


END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION lpInsertFind_ObjectCost (Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer) OWNER TO postgres;

  
/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 10.07.13                                        *
*/

-- ����
/*
CREATE TEMP TABLE _tmpObjectCost (DescId Integer, ObjectId Integer) ON COMMIT DROP;
SELECT * FROM lpInsertFind_ObjectCost (inObjectCostDescId:= zc_ObjectCost_Basis()
                                     , inDescId_1   := zc_ObjectCostLink_Unit()
                                     , inObjectId_1 := 21720
                                     , inDescId_2   := zc_ObjectCostLink_Goods()
                                     , inObjectId_2 := 4341
                                     , inDescId_3   := NULL
                                     , inObjectId_3 := NULL
                                     , inDescId_4   := zc_ObjectCostLink_InfoMoney()
                                     , inObjectId_4 := 23463
                                     , inDescId_5   := zc_ObjectCostLink_InfoMoneyDetail()
                                     , inObjectId_5 := 23463
                                     , inDescId_6:= NULL, inObjectId_6:=NULL, inDescId_7:= NULL, inObjectId_7:=NULL, inDescId_8:= NULL, inObjectId_8:=NULL, inDescId_9:= NULL, inObjectId_9:=NULL, inDescId_10:= NULL, inObjectId_10:=NULL
                                     )
*/
