/*
  �������� 
    - ������� MovementItemReport - "�������� ��� ������"
    - ������
    - ��������
*/
/*-------------------------------------------------------------------------------*/

CREATE TABLE MovementItemReport(
   Id                 SERIAL NOT NULL PRIMARY KEY, 
   MovementId         Integer,
   MovementItemId     Integer,
   ReportContainerId  Integer,
   Amount             TFloat, 
   OperDate           TDateTime,

   CONSTRAINT fk_MovementItemReport_MovementId FOREIGN KEY (MovementId) REFERENCES Movement (Id),
   CONSTRAINT fk_MovementItemReport_MovementItemId FOREIGN KEY (MovementItemId) REFERENCES MovementItem (Id)
);

/*-------------------------------------------------------------------------------*/
/*                                  �������                                      */
CREATE INDEX Idx_MovementItemReport_MovementId ON MovementItemReport (MovementId);
CREATE INDEX Idx_MovementItemReport_ReportContainerId_OperDate_Amount ON MovementItemReport (ReportContainerId, OperDate, Amount);

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 30.08.13                                        *
*/
