-- Function: lpInsertUpdate_MovementItemReport(Integer, Integer, Integer, TFloat, TDateTime)

-- DROP FUNCTION lpInsertUpdate_MovementItemReport(Integer, Integer, Integer, TFloat, TDateTime);

CREATE OR REPLACE FUNCTION lpInsertUpdate_MovementItemReport(
    IN inMovementId              Integer               , -- ���� ���������
    IN inMovementItemId          Integer               ,
    IN inActiveContainerId       Integer               ,
    IN inPassiveContainerId      Integer               ,
    IN inActiveAccountId         Integer               ,
    IN inPassiveAccountId        Integer               ,
    IN inReportContainerId       Integer               ,
    IN inChildReportContainerId  Integer               ,
    IN inAmount                  TFloat                ,
    IN inOperDate                TDateTime
)
  RETURNS void AS
$BODY$
BEGIN
     -- ������ ��������
     IF inChildReportContainerId = 0 THEN inChildReportContainerId := NULL; END IF;
     -- ������ ��������
     inAmount := COALESCE (inAmount, 0);

     -- ��������
     IF inAmount < 0 
     THEN
         RAISE EXCEPTION '���������� ������������ �������� ��� ������ � inAmount<0 : "%", "%", "%", "%", "%", "%", "%", "%", "%", "%"', inMovementId, inMovementItemId, inActiveContainerId, inPassiveContainerId, inActiveAccountId, inPassiveAccountId, inReportContainerId, inChildReportContainerId, inAmount, inOperDate;
     END IF;

     -- ��������� "�������� ��� ������"
     INSERT INTO MovementItemReport (MovementId, MovementItemId, ActiveContainerId, PassiveContainerId, ActiveAccountId, PassiveAccountId, ReportContainerId, ChildReportContainerId, Amount, OperDate)
                             VALUES (inMovementId, inMovementItemId, inActiveContainerId, inPassiveContainerId, inActiveAccountId, inPassiveAccountId, inReportContainerId, inChildReportContainerId, inAmount, inOperDate);
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION lpInsertUpdate_MovementItemReport (Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, TFloat, TDateTime) OWNER TO postgres;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 29.08.13                                        *
*/

-- ����
-- SELECT * FROM lpInsertUpdate_MovementItemReport (inMovementId  := 1, inMovementItemId := 2, )

