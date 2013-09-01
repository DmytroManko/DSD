-- Function: lpInsertUpdate_MovementItemReport(Integer, Integer, Integer, TFloat, TDateTime)

-- DROP FUNCTION lpInsertUpdate_MovementItemReport(Integer, Integer, Integer, TFloat, TDateTime);

CREATE OR REPLACE FUNCTION lpInsertUpdate_MovementItemReport(
    IN inMovementId              Integer               , -- ���� ���������
    IN inMovementItemId          Integer               ,
    IN inReportContainerId       Integer               ,
    IN inAmount                  TFloat                ,
    IN inOperDate                TDateTime
)
  RETURNS void AS
$BODY$
BEGIN

     -- ��������
     IF inAmount < 0 
     THEN
         RAISE EXCEPTION '���������� ������������ �������� ��� ������ � inAmount<0 : "%", "%", "%", "%", "%"', inMovementId, inMovementItemId, inReportContainerId, inAmount, inOperDate;
     END IF;

     -- ��������� "�������� ��� ������"
     INSERT INTO MovementItemReport (MovementId, MovementItemId, ReportContainerId, Amount, OperDate)
                             VALUES (inMovementId, inMovementItemId, inReportContainerId, COALESCE (inAmount, 0), inOperDate);
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION lpInsertUpdate_MovementItemReport (Integer, Integer, Integer, TFloat, TDateTime) OWNER TO postgres;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 29.08.13                                        *
*/

-- ����
-- SELECT * FROM lpInsertUpdate_MovementItemReport (inMovementId  := 1, inMovementItemId := 2, )

