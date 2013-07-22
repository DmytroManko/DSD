-- Function: gpInsertUpdate_HistoryCost()

-- DROP FUNCTION gpInsertUpdate_HistoryCost (TDateTime, TDateTime, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_HistoryCost(
    IN inStartDate   TDateTime , --
    IN inEndDate     TDateTime , --
    IN inSession     TVarChar    -- ������ ������������
)                              
--  RETURNS VOID AS
  RETURNS TABLE (vbItearation Integer, Price TFloat, PriceNext TFloat, FromObjectCostId Integer, ObjectCostId Integer, StartCount TFloat, StartSumm TFloat, IncomeCount TFloat, IncomeSumm TFloat, CalcCount TFloat, CalcSumm TFloat, CalcSummNext TFloat)
AS
$BODY$
   DECLARE vbItearation Integer;
   DECLARE vbCountDiff Integer;
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight (inSession, zc_Enum_InsertUpdate_HistoryCost());


     -- ������� - ������ ��������� ������� �������� ���������� �/�.
     CREATE TEMP TABLE _tmpMaster (ObjectCostId Integer, StartCount TFloat, StartSumm TFloat, IncomeCount TFloat, IncomeSumm TFloat, CalcCount TFloat, CalcSumm TFloat) ON COMMIT DROP;
     -- ������� - ������� ��� Master
     CREATE TEMP TABLE _tmpChild (MasterObjectCostId Integer, ObjectCostId Integer, OperCount TFloat) ON COMMIT DROP;

     -- ������� - �������� �� ������
     CREATE TEMP TABLE _tmpAll (MasterObjectCostId Integer, ObjectCostId Integer, StartCount TFloat, StartSumm TFloat, IncomeCount TFloat, IncomeSumm TFloat, OutCount TFloat, OutSumm TFloat) ON COMMIT DROP;
     -- ������� - ������� + �������� �� ������
     CREATE TEMP TABLE _tmpRemains (ObjectCostId Integer, AllCount TFloat, AllSumm TFloat, EndCount TFloat, EndSumm TFloat) ON COMMIT DROP;


     -- ��������� ������� - ��������
     INSERT INTO _tmpAll (MasterObjectCostId, ObjectCostId, StartCount, StartSumm, IncomeCount, IncomeSumm, OutCount, OutSumm)
        -- ���������� - ���, ������
        SELECT 0 AS MasterObjectCostId
             , COALESCE (ContainerObjectCost.ObjectCostId, 0) AS ObjectCostId
             , tmpContainer.StartCount
             , 0 AS StartSumm
             , tmpContainer.IncomeCount
             , 0 AS IncomeSumm
             , tmpContainer.OutCount
             , 0 AS OutSumm
        FROM (SELECT Container.Id AS ContainerId
                   , Container.Amount - COALESCE (SUM (MIContainer.Amount), 0) AS StartCount
                   , COALESCE (SUM (CASE WHEN MIContainer.OperDate BETWEEN inStartDate AND inEndDate AND MIContainer.Amount > 0 THEN  MIContainer.Amount ELSE 0 END), 0) AS IncomeCount
                   , 0 AS OutCount -- COALESCE (SUM (CASE WHEN MIContainer.OperDate BETWEEN inStartDate AND inEndDate AND MIContainer.Amount < 0 THEN -MIContainer.Amount ELSE 0 END), 0) AS OutCount
              FROM Container
                   LEFT JOIN MovementItemContainer AS MIContainer
                                                   ON MIContainer.Containerid = Container.Id
                                                  AND MIContainer.OperDate >= inStartDate
              WHERE Container.DescId = zc_Container_Count()
-- and 1=0
              GROUP BY Container.Id
                     , Container.Amount
              HAVING (Container.Amount - COALESCE (SUM (MIContainer.Amount), 0) <> 0)
                  OR (COALESCE (SUM (CASE WHEN MIContainer.OperDate BETWEEN inStartDate AND inEndDate AND MIContainer.Amount > 0 THEN MIContainer.Amount ELSE 0 END), 0) <> 0)
                  -- OR (COALESCE (SUM (CASE WHEN MIContainer.OperDate BETWEEN inStartDate AND inEndDate AND MIContainer.Amount < 0 THEN -MIContainer.Amount ELSE 0 END), 0) <> 0)
             ) AS tmpContainer
             LEFT JOIN Container AS Container_Summ
                                 ON Container_Summ.ParentId = tmpContainer.ContainerId
                                AND Container_Summ.DescId = zc_Container_Summ()
             LEFT JOIN ContainerObjectCost ON ContainerObjectCost.Containerid = Container_Summ.Id
                                          AND ContainerObjectCost.ObjectCostDescId = zc_ObjectCost_Basis()
       UNION ALL
        -- ����� - ���, ������
        SELECT 0 AS MasterObjectCostId
             , COALESCE (ContainerObjectCost.ObjectCostId, 0) AS ObjectCostId
             , 0 AS StartCount
             , Container.Amount - COALESCE (SUM (MIContainer.Amount), 0) AS StartSumm
             , 0 AS IncomeCount
             , COALESCE (SUM (CASE WHEN MIContainer.OperDate BETWEEN inStartDate AND inEndDate AND MIContainer.Amount > 0 THEN  MIContainer.Amount ELSE 0 END), 0) AS IncomeSumm
             , 0 AS OutCount
             , 0 AS OutSumm -- COALESCE (SUM (CASE WHEN MIContainer.OperDate BETWEEN inStartDate AND inEndDate AND MIContainer.Amount < 0 THEN -MIContainer.Amount ELSE 0 END), 0) AS OutSumm
        FROM Container AS Container_Count
             JOIN Container ON Container.ParentId = Container_Count.Id
                           AND Container.DescId = zc_Container_Summ()
             LEFT JOIN MovementItemContainer AS MIContainer
                                             ON MIContainer.Containerid = Container.Id
                                            AND MIContainer.OperDate >= inStartDate
             LEFT JOIN ContainerObjectCost ON ContainerObjectCost.Containerid = Container.Id
                                          AND ContainerObjectCost.ObjectCostDescId = zc_ObjectCost_Basis()
        WHERE Container_Count.DescId = zc_Container_Count()
-- and 1=0
        GROUP BY ContainerObjectCost.ObjectCostId
               , Container.Amount
        HAVING (Container.Amount - COALESCE (SUM (MIContainer.Amount), 0) <> 0)
            OR (COALESCE (SUM (CASE WHEN MIContainer.OperDate BETWEEN inStartDate AND inEndDate AND MIContainer.Amount > 0 THEN MIContainer.Amount ELSE 0 END), 0) <> 0)
            -- OR (COALESCE (SUM (CASE WHEN MIContainer.OperDate BETWEEN inStartDate AND inEndDate AND MIContainer.Amount < 0 THEN -MIContainer.Amount ELSE 0 END), 0) <> 0)
       UNION ALL
        -- ���������� - ������ �����������
        SELECT COALESCE (ContainerObjectCost_In.ObjectCostId, 0) AS MasterObjectCostId
             , COALESCE (ContainerObjectCost_Out.ObjectCostId, 0) AS ObjectCostId
             , 0 AS StartCount
             , 0 AS StartSumm
             , 0 AS IncomeCount
             , 0 AS IncomeSumm
             , - SUM (MIContainer_Count_Out.Amount)
             , 0 AS OutSumm
        FROM Movement
             JOIN MovementItemContainer AS MIContainer_Count_Out
                                        ON MIContainer_Count_Out.MovementId = Movement.Id
                                       AND MIContainer_Count_Out.Amount < 0
                                       AND MIContainer_Count_Out.DescId = zc_MIContainer_Count()
             JOIN MovementItemContainer AS MIContainer_Count_In
                                        ON MIContainer_Count_In.MovementItemId = MIContainer_Count_Out.MovementItemId
                                       AND MIContainer_Count_In.DescId = zc_MIContainer_Count()
                                       AND MIContainer_Count_In.Amount >= 0
             LEFT JOIN Container AS Container_Summ_Out
                                 ON Container_Summ_Out.ParentId = MIContainer_Count_Out.ContainerId
                                AND Container_Summ_Out.DescId = zc_Container_Summ()
             LEFT JOIN ContainerObjectCost AS ContainerObjectCost_Out
                                           ON ContainerObjectCost_Out.Containerid = Container_Summ_Out.Id
                                          AND ContainerObjectCost_Out.ObjectCostDescId = zc_ObjectCost_Basis()
             LEFT JOIN Container AS Container_Summ_In
                                 ON Container_Summ_In.ParentId = MIContainer_Count_In.ContainerId
                                AND Container_Summ_In.DescId = zc_Container_Summ()
             LEFT JOIN ContainerObjectCost AS ContainerObjectCost_In
                                           ON ContainerObjectCost_In.Containerid = Container_Summ_In.Id
                                          AND ContainerObjectCost_In.ObjectCostDescId = zc_ObjectCost_Basis()
        WHERE Movement.OperDate BETWEEN inStartDate AND inEndDate
          AND Movement.DescId = zc_Movement_Send()
          AND Movement.StatusId = zc_Enum_Status_Complete()
        GROUP BY ContainerObjectCost_In.ObjectCostId
               , ContainerObjectCost_Out.ObjectCostId
       UNION ALL
        -- ���������� - ������ ����������
        SELECT COALESCE (ContainerObjectCost_In.ObjectCostId, 0) AS MasterObjectCostId
             , COALESCE (ContainerObjectCost_Out.ObjectCostId, 0) AS ObjectCostId
             , 0 AS StartCount
             , 0 AS StartSumm
             , 0 AS IncomeCount
             , 0 AS IncomeSumm
             , - SUM (MIContainer_Count_Out.Amount)
             , 0 AS OutSumm
        FROM Movement
             JOIN MovementItemContainer AS MIContainer_Count_Out
                                        ON MIContainer_Count_Out.MovementId = Movement.Id
                                       AND MIContainer_Count_Out.Amount < 0
                                       AND MIContainer_Count_Out.DescId = zc_MIContainer_Count()
             JOIN MovementItem AS MI_Out ON MI_Out.Id = MIContainer_Count_Out.MovementItemId
             JOIN MovementItemContainer AS MIContainer_Count_In
                                        ON MIContainer_Count_In.MovementItemId = MI_Out.ParentId
                                       AND MIContainer_Count_In.DescId = zc_MIContainer_Count()
                                       AND MIContainer_Count_In.Amount >= 0
             LEFT JOIN Container AS Container_Summ_Out
                                 ON Container_Summ_Out.ParentId = MIContainer_Count_Out.ContainerId
                                AND Container_Summ_Out.DescId = zc_Container_Summ()
             LEFT JOIN ContainerObjectCost AS ContainerObjectCost_Out
                                           ON ContainerObjectCost_Out.Containerid = Container_Summ_Out.Id
                                          AND ContainerObjectCost_Out.ObjectCostDescId = zc_ObjectCost_Basis()
             LEFT JOIN Container AS Container_Summ_In
                                 ON Container_Summ_In.ParentId = MIContainer_Count_In.ContainerId
                                AND Container_Summ_In.DescId = zc_Container_Summ()
             LEFT JOIN ContainerObjectCost AS ContainerObjectCost_In
                                           ON ContainerObjectCost_In.Containerid = Container_Summ_In.Id
                                          AND ContainerObjectCost_In.ObjectCostDescId = zc_ObjectCost_Basis()
        WHERE Movement.OperDate BETWEEN inStartDate AND inEndDate
          AND Movement.DescId = zc_Movement_ProductionUnion()
          AND Movement.StatusId = zc_Enum_Status_Complete()
        GROUP BY ContainerObjectCost_In.ObjectCostId
               , ContainerObjectCost_Out.ObjectCostId
        ;

     INSERT INTO _tmpMaster (ObjectCostId, StartCount, StartSumm, IncomeCount, IncomeSumm , CalcCount, CalcSumm)
        SELECT _tmpAll.ObjectCostId, SUM (_tmpAll.StartCount), SUM (_tmpAll.StartSumm), SUM (_tmpAll.IncomeCount), SUM (_tmpAll.IncomeSumm), SUM (_tmpAll.OutCount), SUM (_tmpAll.OutSumm) FROM _tmpAll GROUP BY _tmpAll.ObjectCostId;

     INSERT INTO _tmpChild (MasterObjectCostId, ObjectCostId, OperCount)
        SELECT _tmpAll.MasterObjectCostId, _tmpAll.ObjectCostId, SUM (_tmpAll.OutCount) FROM _tmpAll WHERE _tmpAll.OutCount <> 0 GROUP BY _tmpAll.MasterObjectCostId, _tmpAll.ObjectCostId;


--     return;



     -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
     -- !!! �� � ������ - ���� �/� !!!
     -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

     vbItearation:=0;
     vbCountDiff:= 100000;
     WHILE vbItearation < 30 AND vbCountDiff > 0
     LOOP
         UPDATE _tmpMaster SET CalcSumm = _tmpSumm.CalcSumm
               -- ������ ����� ���� ������������
         FROM (SELECT _tmpChild.MasterObjectCostId AS ObjectCostId
                    , CAST (SUM (_tmpChild.OperCount * _tmpPrice.OperPrice) AS TFloat) AS CalcSumm
                      FROM 
                          -- ������ ����
                          (SELECT _tmpMaster.ObjectCostId
                                , CASE WHEN (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.CalcCount) > 0 AND (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) > 0
                                          THEN  (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) / (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.CalcCount)
                                       WHEN  (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.CalcCount) < 0 AND (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) < 0
                                          THEN  (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) / (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.CalcCount)
                                       ELSE 0
                                  END AS OperPrice
                           FROM _tmpMaster
                          ) AS _tmpPrice 
                          JOIN _tmpChild ON _tmpChild.ObjectCostId = _tmpPrice.ObjectCostId
                                            -- ����������� � ��� ������ ���� ��� � ����
                                        AND _tmpChild.MasterObjectCostId <> _tmpChild.ObjectCostId

                      GROUP BY _tmpChild.MasterObjectCostId
                     ) AS _tmpSumm 
         WHERE _tmpMaster.ObjectCostId = _tmpSumm.ObjectCostId;

         -- ���������� ��������
         vbItearation:= vbItearation + 1;
         -- ������� ������� ��� � ������������ �/�
         SELECT Count(*) INTO vbCountDiff
         FROM _tmpMaster
               -- ������ ����� ���� ������������
            , (SELECT _tmpChild.MasterObjectCostId AS ObjectCostId
                    , CAST (SUM (_tmpChild.OperCount * _tmpPrice.OperPrice) AS TFloat) AS CalcSumm
                      FROM 
                          -- ������ ����
                          (SELECT _tmpMaster.ObjectCostId
                                , CASE WHEN (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.CalcCount) > 0 AND (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) > 0
                                          THEN  (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) / (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.CalcCount)
                                       WHEN  (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.CalcCount) < 0 AND (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) < 0
                                          THEN  (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) / (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.CalcCount)
                                       ELSE 0
                                  END AS OperPrice
                           FROM _tmpMaster
                          ) AS _tmpPrice 
                          JOIN _tmpChild ON _tmpChild.ObjectCostId = _tmpPrice.ObjectCostId
                                            -- ����������� � ��� ������ ���� ��� � ����
                                        AND _tmpChild.MasterObjectCostId <> _tmpChild.ObjectCostId

                      GROUP BY _tmpChild.MasterObjectCostId
                     ) AS _tmpSumm 
         WHERE _tmpMaster.ObjectCostId = _tmpSumm.ObjectCostId
           AND _tmpMaster.CalcSumm <> _tmpSumm.CalcSumm;

     END LOOP;

     -- tmp return
     RETURN QUERY SELECT vbItearation
                       , CAST (CASE WHEN (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.CalcCount) <> 0
                                       THEN  (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) / (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.CalcCount)
                               END AS TFloat) AS Price
                       , CAST (CASE WHEN (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.CalcCount) <> 0
                                       THEN  (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + COALESCE (_tmpSumm.CalcSumm, 0)) / (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.CalcCount)
                               END AS TFloat) AS PriceNext
                       , CAST (0 AS Integer) AS FromObjectCostId
                       , _tmpSumm.FromObjectCostId
                       , _tmpMaster.ObjectCostId, _tmpMaster.StartCount, _tmpMaster.StartSumm, _tmpMaster.IncomeCount, _tmpMaster.IncomeSumm, _tmpMaster.CalcCount, _tmpMaster.CalcSumm, _tmpSumm.CalcSumm AS CalcSummNext
                  FROM _tmpMaster LEFT JOIN
               -- ������ ����� ���� ������������
              (SELECT _tmpChild.MasterObjectCostId AS ObjectCostId
                    , CAST (SUM (_tmpChild.OperCount * _tmpPrice.OperPrice) AS TFloat) AS CalcSumm
                      FROM 
                          -- ������ ����
                          (SELECT _tmpMaster.ObjectCostId
                                , CASE WHEN (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.CalcCount) > 0 AND (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) > 0
                                          THEN  (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) / (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.CalcCount)
                                       WHEN  (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.CalcCount) < 0 AND (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) < 0
                                          THEN  (_tmpMaster.StartSumm + _tmpMaster.IncomeSumm + _tmpMaster.CalcSumm) / (_tmpMaster.StartCount + _tmpMaster.IncomeCount + _tmpMaster.CalcCount)
                                       ELSE 0
                                  END AS OperPrice
                           FROM _tmpMaster
                          ) AS _tmpPrice 
                          JOIN _tmpChild ON _tmpChild.ObjectCostId = _tmpPrice.ObjectCostId
                                            -- ����������� � ��� ������ ���� ��� � ����
                                        AND _tmpChild.MasterObjectCostId <> _tmpChild.ObjectCostId

                      GROUP BY _tmpChild.MasterObjectCostId
                     ) AS _tmpSumm ON _tmpMaster.ObjectCostId = _tmpSumm.ObjectCostId
     ;

END;
$BODY$
LANGUAGE PLPGSQL VOLATILE;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 13.07.13                                        * add JOIN Container
 10.07.13                                        *
*/

/*
     INSERT INTO _tmpMaster (ObjectCostId, StartCount, StartSumm, IncomeCount, IncomeSumm , CalcCount, CalcSumm)
        SELECT CAST (1 AS Integer) AS ObjectCostId, CAST (30 AS TFloat) AS StartCount, CAST (280 AS TFloat) AS StartSumm, CAST (0 AS TFloat) AS IncomeCount, CAST (0 AS TFloat) AS IncomeSumm, CAST (0 AS TFloat) AS CalcCount, CAST (0 AS TFloat) AS CalcSumm
       UNION ALL
        SELECT CAST (2 AS Integer) AS ObjectCostId, CAST (50 AS TFloat) AS StartCount, CAST (340 AS TFloat) AS StartSumm, CAST (0 AS TFloat) AS IncomeCount, CAST (0 AS TFloat) AS IncomeSumm, CAST (0 AS TFloat) AS CalcCount, CAST (0 AS TFloat) AS CalcSumm
       UNION ALL
        SELECT CAST (3 AS Integer) AS ObjectCostId, CAST (20 AS TFloat) AS StartCount, CAST (0 AS TFloat) AS StartSumm, CAST (0 AS TFloat) AS IncomeCount, CAST (0 AS TFloat) AS IncomeSumm, CAST (0 AS TFloat) AS CalcCount, CAST (0 AS TFloat) AS CalcSumm
       UNION ALL
        SELECT CAST (4 AS Integer) AS ObjectCostId, CAST (13 AS TFloat) AS StartCount, CAST (14 AS TFloat) AS StartSumm, CAST (0 AS TFloat) AS IncomeCount, CAST (0 AS TFloat) AS IncomeSumm, CAST (0 AS TFloat) AS CalcCount, CAST (0 AS TFloat) AS CalcSumm
       UNION ALL
        SELECT CAST (5 AS Integer) AS ObjectCostId, CAST (20 AS TFloat) AS StartCount, CAST (20 AS TFloat) AS StartSumm, CAST (0 AS TFloat) AS IncomeCount, CAST (0 AS TFloat) AS IncomeSumm, CAST (0 AS TFloat) AS CalcCount, CAST (0 AS TFloat) AS CalcSumm
       ;
     -- ������� - ��� �������
     INSERT INTO _tmpChild (MasterObjectCostId, ObjectCostId, OperCount)
        SELECT 3 AS MasterObjectCostId, 1 AS ObjectCostId, 5 AS OperCount
       UNION ALL
        SELECT 3 AS MasterObjectCostId, 2 AS ObjectCostId, 7 AS OperCount
       UNION ALL
        SELECT 3 AS MasterObjectCostId, 5 AS ObjectCostId, 2 AS OperCount
       UNION ALL
        SELECT 5 AS MasterObjectCostId, 1 AS ObjectCostId, 4 AS OperCount
       UNION ALL
        SELECT 5 AS MasterObjectCostId, 2 AS ObjectCostId, 6 AS OperCount
       UNION ALL
        SELECT 5 AS MasterObjectCostId, 3 AS ObjectCostId, 2 AS OperCount
       UNION ALL
        SELECT 5 AS MasterObjectCostId, 4 AS ObjectCostId, 1 AS OperCount
       UNION ALL
        SELECT 4 AS MasterObjectCostId, 3 AS ObjectCostId, 10 AS OperCount
       ;
*/

-- ����
-- SELECT * FROM gpInsertUpdate_HistoryCost (inStartDate:= '01.01.2013', inEndDate:= '31.01.2013', inSession:= '2')
-- SELECT * FROM gpInsertUpdate_HistoryCost (inStartDate:= '01.02.2013', inEndDate:= '28.02.2013', inSession:= '2')