/*
  �������� 
    - ������� MovementString (�������� ����������� ���� TVarChar)
    - �����
    - ��������
*/


      /* ���� ���� ����� ������� - ������� �� */
      IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'MovementString')
      DROP TABLE MovementString

/*-------------------------------------------------------------------------------*/

CREATE TABLE MovementString(
   Id         INTEGER NOT NULL PRIMARY KEY NONCLUSTERED IDENTITY (1,1),
   DescId     INTEGER NOT NULL,
   MovementId INTEGER NOT NULL,
   ValueData  TVarChar,

   CONSTRAINT MovementString_DescId_MovementStringDesc FOREIGN KEY(DescId) REFERENCES MovementStringDesc(Id),
   CONSTRAINT MovementString_MovementId_Movement FOREIGN KEY(MovementId) REFERENCES Movement(Id) )

/*-------------------------------------------------------------------------------*/

/*                                  �������                                      */

CREATE NONCLUSTERED INDEX MovementString_DescId ON MovementString(DescId) 
CREATE NONCLUSTERED INDEX MovementString_MovementId ON MovementString(MovementId) 

/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.   ��������� �.�.   ��������� �.�.
18.06.02                                              *
*/
