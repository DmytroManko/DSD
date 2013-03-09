/*
  �������� 
    - ������� MovementEnum ()
    - ������
    - ��������
*/


      /* ���� ���� ����� ������� - ������� �� */
      IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'MovementEnum')
      DROP TABLE MovementEnum
 
/*-------------------------------------------------------------------------------*/

CREATE TABLE MovementEnum(
   Id                    INTEGER NOT NULL PRIMARY KEY NONCLUSTERED IDENTITY (1,1), 
   DescId                INTEGER,
   MovementId            INTEGER,
   EnumId                INTEGER,
 
   CONSTRAINT MovementEnum_DescId_MovementEnumDesc FOREIGN KEY(DescId) REFERENCES MovementEnumDesc(Id),
   CONSTRAINT MovementEnum_MovementId_Movement FOREIGN KEY(MovementId) REFERENCES Movement(Id),
   CONSTRAINT MovementEnum_EnumId_Enum FOREIGN KEY(EnumId) REFERENCES Enum(Id))


/*-------------------------------------------------------------------------------*/

/*                                  �������                                      */


CREATE NONCLUSTERED INDEX MovementEnum_DescId ON MovementEnum(DescId) 
CREATE NONCLUSTERED INDEX MovementEnum_MovementId ON MovementEnum(MovementId) 
CREATE NONCLUSTERED INDEX MovementEnum_EnumId ON MovementEnum(EnumId) 


/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.   ��������� �.�.   ��������� �.�.
18.06.02                                              *
*/
