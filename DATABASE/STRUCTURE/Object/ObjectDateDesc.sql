/*
  �������� 
    - ������� ObjectDateDesc (�������� ������� o������� ���� TFloat)
    - �����
    - ��������
*/

/*-------------------------------------------------------------------------------*/

CREATE TABLE ObjectDateDesc(
   Id           INTEGER NOT NULL PRIMARY KEY,
   ObjectDescId INTEGER NOT NULL,
   Code         TVarChar,
   ItemName     TVarChar,
   isErased     TVarChar,

   CONSTRAINT ObjectDateDesc_ObjectDescId_ObjectDesc FOREIGN KEY(ObjectDescId) REFERENCES ObjectDesc(Id) );



/*-------------------------------------------------------------------------------*/

/*                                  �������                                      */


CREATE UNIQUE INDEX ObjectDateDesc_Code ON ObjectDateDesc(Code);
CLUSTER ObjectDateDesc_Code ON ObjectDateDesc;

/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.   
14.06.02                                         
*/
