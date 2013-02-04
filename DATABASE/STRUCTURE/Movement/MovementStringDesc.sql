/*
  �������� 
    - ������� MovementStringDesc (�������� ������� ����������� ���� TVarChar)
    - �����
    - ��������
*/


      /* ���� ���� ����� ������� - ������� �� */
      IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'MovementStringDesc')
      DROP TABLE MovementStringDesc

/*-------------------------------------------------------------------------------*/

CREATE TABLE MovementStringDesc(
   Id              INTEGER NOT NULL PRIMARY KEY NONCLUSTERED IDENTITY (1,1),
   MovementDescId  INTEGER NOT NULL,
   Code            TVarChar,
   ItemName        TVarChar,

   CONSTRAINT MovementStringDesc_MovementDescId_MovementDesc FOREIGN KEY(MovementDescId) REFERENCES MovementDesc(Id) )


/*-------------------------------------------------------------------------------*/

/*                                  �������                                      */



CREATE UNIQUE CLUSTERED INDEX MovementStringDesc_Code ON MovementStringDesc(Code) 


/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.   ��������� �.�.   ��������� �.�.
18.06.02                                              *
*/
