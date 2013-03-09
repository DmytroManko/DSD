/*
  �������� 
    - ������� ObjectStringDesc (�������� ������� o������� ���� TVarChar)
    - �����
    - ��������
*/

/*-------------------------------------------------------------------------------*/

CREATE TABLE ObjectStringDesc(
   Id         INTEGER NOT NULL PRIMARY KEY,
   ObjectDescId  INTEGER NOT NULL,
   Code       TVarChar,
   ItemName   TVarChar,
   isErased   TVarChar,
   CONSTRAINT ObjectStringDesc_ObjectDescId_ObjectDesc FOREIGN KEY(ObjectDescId) REFERENCES ObjectDesc(Id) );

/*-------------------------------------------------------------------------------*/
/*                                  �������                                      */

CREATE UNIQUE INDEX ObjectStringDesc_Code ON ObjectStringDesc(Code);
CLUSTER ObjectStringDesc_Code ON ObjectStringDesc;


/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.   ��������� �.�.   ��������� �.�.
14.06.02                                              *
*/
