/*
  �������� 
    - ������� ObjectDesc (������ o�������)
    - ��������
*/

/*-------------------------------------------------------------------------------*/

CREATE TABLE ObjectDesc(
   Id                    INTEGER NOT NULL PRIMARY KEY, 
   Code                  TVarChar NOT NULL UNIQUE,
   ItemName              TVarChar,
   MainCode              TVarChar,
   MainCodeItemName      TVarChar,
   ValueDataCode         TVarChar,
   ValueDataItemName     TVarChar,
   isErased              TVarChar);


/*-------------------------------------------------------------------------------*/

/*                                  �������                                      */


CREATE UNIQUE INDEX ObjectDesc_Code ON ObjectDesc(Code);

CLUSTER ObjectDesc_Code ON ObjectDesc; 


/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.   
13.06.02                                         
*/
