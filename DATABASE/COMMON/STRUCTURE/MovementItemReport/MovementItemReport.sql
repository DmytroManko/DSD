/*
  �������� 
    - ������� MovementItemReport - "�������� ��� ������"
    - ������
    - ��������
*/
/*-------------------------------------------------------------------------------*/

CREATE TABLE MovementItemReport(
   Id                      SERIAL NOT NULL PRIMARY KEY, 
   MovementId              Integer,
   MovementItemId          Integer,
   ActiveContainerId       Integer,
   PassiveContainerId      Integer,
   ActiveAccountId         Integer,
   PassiveAccountId        Integer,
   ReportContainerId       Integer,
   ChildReportContainerId  Integer,
   Amount                  TFloat, 
   OperDate                TDateTime,

   CONSTRAINT fk_MovementItemReport_MovementId FOREIGN KEY (MovementId) REFERENCES Movement (Id),
   CONSTRAINT fk_MovementItemReport_MovementItemId FOREIGN KEY (MovementItemId) REFERENCES MovementItem (Id),
   CONSTRAINT fk_MovementItemReport_ActiveContainerId FOREIGN KEY (ActiveContainerId) REFERENCES Container (Id),
   CONSTRAINT fk_MovementItemReport_PassiveContainerId FOREIGN KEY (PassiveContainerId) REFERENCES Container (Id),
   CONSTRAINT fk_MovementItemReport_ActiveAccountId FOREIGN KEY (ActiveAccountId) REFERENCES Object (Id),
   CONSTRAINT fk_MovementItemReport_PassiveAccountId FOREIGN KEY (PassiveAccountId) REFERENCES Object (Id)
);

/*-------------------------------------------------------------------------------*/
/*                                  �������                                      */
CREATE INDEX Idx_MovementItemReport_MovementId  ON MovementItemReport (MovementId);
CREATE INDEX Idx_MovementItemReport_MovementItemId  ON MovementItemReport (MovementItemId);
CREATE INDEX Idx_MovementItemReport_ReportContainerId_OperDate_Amount ON MovementItemReport (ReportContainerId, OperDate, Amount);
CREATE INDEX Idx_MovementItemReport_ActiveAccountId_OperDate_Amount ON MovementItemReport (ActiveAccountId, OperDate, Amount);
CREATE INDEX Idx_MovementItemReport_PassiveAccountId_OperDate_Amount ON MovementItemReport (PassiveAccountId, OperDate, Amount);

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 03.09.13                                        *
*/
