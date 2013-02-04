/*
  �������� 
    - ������� MovementLinkObject (����� ����� ������������� � ���������)
    - ������
    - ��������
*/


      /* ���� ���� ����� ������� - ������� �� */
      IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'MovementLinkObject')
      DROP TABLE MovementLinkObject
 
/*-------------------------------------------------------------------------------*/

CREATE TABLE MovementLinkObject(
   Id                    INTEGER NOT NULL PRIMARY KEY NONCLUSTERED IDENTITY (1,1), 
   DescId                INTEGER,
   ParentMovementId      INTEGER,
   ChildObjectId         INTEGER,
 
   CONSTRAINT MovementLinkObject_DescId_MovementLinkObjectDesc FOREIGN KEY(DescId) REFERENCES MovementLinkObjectDesc(Id),
   CONSTRAINT MovementLinkObject_ParentMovementId_Movement FOREIGN KEY(ParentMovementId) REFERENCES Movement(Id),
   CONSTRAINT MovementLinkObject_ChildObjectId_Object FOREIGN KEY(ChildObjectId) REFERENCES Object(Id))


/*-------------------------------------------------------------------------------*/

/*                                  �������                                      */


CREATE NONCLUSTERED INDEX MovementLinkObject_DescId ON MovementLinkObject(DescId) 
CREATE NONCLUSTERED INDEX MovementLinkObject_ParentMovementId ON MovementLinkObject(ParentMovementId) 
CREATE NONCLUSTERED INDEX MovementLinkObject_ChildObjectId ON MovementLinkObject(ChildObjectId) 


/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.   ��������� �.�.   ��������� �.�.
18.06.02                                              *
*/
