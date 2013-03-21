/*
  �������� 
    - ������� ObjectDateDesc (�������� ������� o������� ���� TDate)
    - �����
    - ��������
*/

/*-------------------------------------------------------------------------------*/

CREATE TABLE ObjectDateDesc(
   Id                    INTEGER NOT NULL PRIMARY KEY,
   ObjectDescId          INTEGER NOT NULL,
   Code                  TVarChar,
   ItemName              TVarChar,

   CONSTRAINT fk_ObjectDateDesc_ObjectDescId FOREIGN KEY(ObjectDescId) REFERENCES ObjectDesc(Id) );



/*-------------------------------------------------------------------------------*/

/*                                  �������                                      */

/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.   
14.06.02                                         
*/
