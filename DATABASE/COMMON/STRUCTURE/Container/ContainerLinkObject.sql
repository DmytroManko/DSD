/*
  �������� 
    - ������� ContainerLinkObject ()
    - ������
    - ��������
*/

/*-------------------------------------------------------------------------------*/

CREATE TABLE ContainerLinkObject(
   DescId                INTEGER NOT NULL,
   ContainerId           INTEGER NOT NULL,
   ObjectId              INTEGER NOT NULL,

   CONSTRAINT fk_ContainerLinkObject_PK PRIMARY KEY (ObjectId, DescId, ContainerId),
   CONSTRAINT fk_ContainerLinkObject_Container FOREIGN KEY (ContainerId)  REFERENCES Container (Id),
   CONSTRAINT fk_ContainerLinkObject_Object FOREIGN KEY (ObjectId) REFERENCES Object (Id),
   CONSTRAINT fk_ContainerLinkObject_Desc FOREIGN KEY (DescId) REFERENCES ContainerLinkObjectDesc (Id)
);

/*-------------------------------------------------------------------------------*/
/*                                  �������                                      */

CREATE INDEX idx_ContainerLinkObject_ContainerId_DescId_ObjectId ON ContainerLinkObject(ContainerId, DescId, ObjectId);

/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.   
18.06.02                                         
11.07.02                                         
*/