/*
  �������� 
    - ������� MovementDate (�������� ����������� ���� TDateTime)
    - ������
    - ��������
*/


      /* ���� ���� ����� ������� - ������� �� */
      IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'MovementDate')
      DROP TABLE MovementDate


/*-------------------------------------------------------------------------------*/

CREATE TABLE MovementDate(
   Id           INTEGER NOT NULL PRIMARY KEY NONCLUSTERED IDENTITY (1,1),
   DescId       INTEGER NOT NULL,
   MovementId   INTEGER NOT NULL,
   ValueData    TDateTime,
               
   CONSTRAINT MovementDate_DescId_MovementDateDesc FOREIGN KEY(DescId) REFERENCES MovementDateDesc(Id),
   CONSTRAINT MovementDate_MovementId_Movement FOREIGN KEY(MovementId) REFERENCES Movement(Id) )


/*-------------------------------------------------------------------------------*/

/*                                  �������                                      */


CREATE NONCLUSTERED INDEX MovementDate_DescId ON MovementDate(DescId) 
CREATE NONCLUSTERED INDEX MovementDate_MovementId ON MovementDate(MovementId) 


/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.   ��������� �.�.   ��������� �.�.
18.06.02                                               *                
*/
