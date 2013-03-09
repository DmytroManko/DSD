/*
  �������� 
    - ������� MovementDateDesc (�������� ������� ����������� ���� TDateTime)
    - ������
    - ��������
*/

        /* ���� ���� ����� ������� - ������� �� */
	IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'MovementDateDesc')
	DROP TABLE MovementDateDesc


/*-------------------------------------------------------------------------------*/

CREATE TABLE MovementDateDesc(
   Id              INTEGER NOT NULL PRIMARY KEY NONCLUSTERED IDENTITY (1,1),
   MovementDescId  INTEGER NOT NULL,
   Code            TVarChar NOT NULL UNIQUE,
   ItemName        TVarChar,

   CONSTRAINT MovementDateDesc_MovementDescId_MovementDesc FOREIGN KEY(MovementDescId) REFERENCES MovementDesc(Id) )


/*-------------------------------------------------------------------------------*/
/*                                  �������                                      */


CREATE UNIQUE CLUSTERED INDEX MovementDateDesc_Code ON MovementDateDesc(Code) 

/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.   ��������� �.�.   ��������� �.�.
18.06.02                                               *               
*/
