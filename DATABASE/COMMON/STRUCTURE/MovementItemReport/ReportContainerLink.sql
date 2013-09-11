/*
  �������� 
    - ������� ReportContainerLink (��������� �������� "�������� ��� ������")
    - �����
    - ��������
*/

/*-------------------------------------------------------------------------------*/
CREATE TABLE ReportContainerLink(
   Id                    SERIAL NOT NULL, 
   ReportContainerId     Integer NOT NULL,
   ContainerId           Integer NOT NULL,
   AccountId             Integer NOT NULL,
   AccountKindId         Integer NOT NULL,

   CONSTRAINT pk_ReportContainerLink               PRIMARY KEY (ContainerId, ReportContainerId, AccountKindId),
   CONSTRAINT fk_ReportContainerLink_ContainerId   FOREIGN KEY (ContainerId) REFERENCES Container (Id),
   CONSTRAINT fk_ReportContainerLink_AccountId     FOREIGN KEY (AccountId) REFERENCES Object (Id),
   CONSTRAINT fk_ReportContainerLink_AccountKindId FOREIGN KEY (AccountKindId) REFERENCES Object (Id)
);

/*-------------------------------------------------------------------------------*/
/*                                  �������                                      */
CREATE INDEX idx_ReportContainerLink_ReportContainerId  ON ReportContainerLink (ReportContainerId);
CREATE INDEX idx_ReportContainerLink_AccountId_AccountKindId ON ReportContainerLink (AccountId, AccountKindId);
CREATE INDEX idx_ReportContainerLink_ContainerId_AccountKindId  ON ReportContainerLink (ContainerId, AccountKindId);

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 03.09.13                                        *
*/
