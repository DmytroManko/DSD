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
   isActive              Boolean NOT NULL,

   CONSTRAINT pk_ReportContainerLink              PRIMARY KEY (ContainerId, ReportContainerId, isActive),
   CONSTRAINT fk_ReportContainerLink_ContainerId  FOREIGN KEY (ContainerId) REFERENCES Container (Id)
);

/*-------------------------------------------------------------------------------*/
/*                                  �������                                      */
CREATE INDEX idx_ReportContainerLink_ReportContainerId  ON ReportContainerLink (ReportContainerId);

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 30.08.13                                        *
*/
