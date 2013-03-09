/*
  �������� 
    - ������� MovementEnumDesc (������ ������ ����� �������� ����������� � �������� ��������)
    - ������
    - ��������
*/


      /* ���� ���� ����� ������� - ������� �� */
      IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'MovementEnumDesc')
      DROP TABLE MovementEnumDesc
 
/*-------------------------------------------------------------------------------*/

CREATE TABLE MovementEnumDesc(
   Id                    INTEGER NOT NULL PRIMARY KEY NONCLUSTERED IDENTITY (1,1), 
   Code                  TVarChar NOT NULL UNIQUE,
   ItemName              TVarChar,
   MovementDescId        INTEGER,
   EnumDescId            INTEGER,
   isManyEnum            TVarChar,
 

   CONSTRAINT MovementEnumDesc_MovementDescId_MovementDesc FOREIGN KEY(MovementDescId) REFERENCES MovementDesc(Id),
   CONSTRAINT MovementEnumDesc_EnumDescId_EnumDesc FOREIGN KEY(EnumDescId) REFERENCES EnumDesc(Id))


/*-------------------------------------------------------------------------------*/

/*                                  �������                                      */



CREATE UNIQUE CLUSTERED INDEX MovementEnumDesc_Code ON MovementEnumDesc(Code) 

/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.   ��������� �.�.   ��������� �.�.
18.06.02                                              *
*/
