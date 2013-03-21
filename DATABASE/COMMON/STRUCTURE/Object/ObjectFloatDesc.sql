/*
  �������� 
    - ������� ObjectFloatDesc (�������� ������� o������� ���� TFloat)
    - �����
    - ��������
*/

/*-------------------------------------------------------------------------------*/

CREATE TABLE ObjectFloatDesc(
   Id                    INTEGER NOT NULL PRIMARY KEY,
   ObjectDescId          INTEGER NOT NULL,
   Code                  TVarChar,
   ItemName              TVarChar,

   CONSTRAINT fk_ObjectFloatDesc_DescId FOREIGN KEY(ObjectDescId) REFERENCES ObjectDesc(Id) );



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
