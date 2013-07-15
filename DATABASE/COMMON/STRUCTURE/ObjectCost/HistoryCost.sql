/*
  �������� 
    - ������� HistoryCost (������� ���)
    - ������
    - ��������
*/


/*-------------------------------------------------------------------------------*/

CREATE TABLE HistoryCost(
   Id                    SERIAL NOT NULL PRIMARY KEY, 
   ObjectCostId          Integer NOT NULL,
   StartDate             TDateTime NOT NULL,
   EndDate               TDateTime NOT NULL,
   Price                 TFloat NOT NULL,
   StartCount            TFloat NOT NULL,
   StratSumm             TFloat NOT NULL,
   IncomeCount           TFloat NOT NULL,
   IncomeSumm            TFloat NOT NULL,
   CalcCount             TFloat NOT NULL,
   CalcSumm              TFloat NOT NULL
);

/*-------------------------------------------------------------------------------*/

/*                                  �������                                      */


CREATE UNIQUE INDEX idx_HistoryCost_ObjectCostId_StartDate_EndDate ON HistoryCost(ObjectCostId, StartDate, EndDate);

/*-------------------------------------------------------------------------------*/


/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.   
11.07.13                               *
*/
