/*
  �������� 
    - ������� MovementDesc (������ �����������)
    - c�����
    - ��������
*/


      /* ���� ���� ����� ������� - ������� �� */
      IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'MovementDesc')
      DROP TABLE MovementDesc
 
/*-------------------------------------------------------------------------------*/

CREATE TABLE MovementDesc(
   Id                    INTEGER NOT NULL PRIMARY KEY NONCLUSTERED IDENTITY (1,1), 
   Code                  TVarChar NOT NULL UNIQUE,
   ItemName              TVarChar,
   ParentDescId          Integer,

   CONSTRAINT MovementDesc_ParentDescId_MovementDesc FOREIGN KEY(ParentDescId) REFERENCES MovementDesc(Id))


/*-------------------------------------------------------------------------------*/

/*                                  �������                                      */


CREATE UNIQUE CLUSTERED INDEX MovementDesc_Code ON MovementDesc(Code) 



/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.   ��������� �.�.   ��������� �.�.
18.06.02                                              *
19.09.02                                              *
*/
