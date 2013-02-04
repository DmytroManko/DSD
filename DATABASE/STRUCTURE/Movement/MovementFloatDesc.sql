/*
  �������� 
    - ������� MovementFloatDesc (�������� ������� ����������� ���� TFloat)
    - ������
    - ��������
*/

        /* ���� ���� ����� ������� - ������� �� */
	IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'MovementFloatDesc')
	DROP TABLE MovementFloatDesc


/*-------------------------------------------------------------------------------*/

CREATE TABLE MovementFloatDesc(
   Id              INTEGER NOT NULL PRIMARY KEY NONCLUSTERED IDENTITY (1,1),
   MovementDescId  INTEGER,
   Code            TVarChar NOT NULL UNIQUE,
   ItemName        TVarChar,

   CONSTRAINT MovementFloatDesc_MovementDescId_MovementDesc FOREIGN KEY(MovementDescId) REFERENCES MovementDesc(Id) )


/*-------------------------------------------------------------------------------*/
/*                                  �������                                      */



CREATE UNIQUE CLUSTERED INDEX MovementFloatDesc_Code ON MovementFloatDesc(Code) 


/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.   ��������� �.�.   ��������� �.�.
18.06.02                                               *               
*/
