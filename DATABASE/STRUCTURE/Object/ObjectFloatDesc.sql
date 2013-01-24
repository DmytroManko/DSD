/*
  �������� 
    - ������� ObjectFloatDesc (�������� ������� o������� ���� TFloat)
    - �����
    - ��������
*/

/*-------------------------------------------------------------------------------*/

CREATE TABLE ObjectFloatDesc(
   Id           INTEGER NOT NULL PRIMARY KEY,
   ObjectDescId INTEGER NOT NULL,
   Code         TVarChar,
   ItemName     TVarChar,
   isErased     TVarChar,

   CONSTRAINT ObjectFloatDesc_ObjectDescId_ObjectDesc FOREIGN KEY(ObjectDescId) REFERENCES ObjectDesc(Id) );



/*-------------------------------------------------------------------------------*/

/*                                  �������                                      */


CREATE UNIQUE INDEX ObjectFloatDesc_Code ON ObjectFloatDesc(Code);
CLUSTER ObjectFloatDesc_Code ON ObjectFloatDesc;

/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.   
14.06.02                                         
*/
