/*
  �������� 
    - ������� Enum (������������ ����)
    - �����
    - ��������
*/


/*-------------------------------------------------------------------------------*/

CREATE TABLE Enum(
   Id         SERIAL NOT NULL PRIMARY KEY, 
   DescId     INTEGER NOT NULL,
   Code       TVarChar UNIQUE,
   ItemName   TVarChar,

   CONSTRAINT Enum_DescId_EnumDesc FOREIGN KEY(DescId) REFERENCES EnumDesc(Id));

/*-------------------------------------------------------------------------------*/

/*                                  �������                                      */

CREATE INDEX Enum_DescId ON Enum(DescId);
CREATE UNIQUE INDEX Enum_Code ON Enum(Code); 
CLUSTER Enum_PKey ON Enum


/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.   
13.06.02                                              
*/
