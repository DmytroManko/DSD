/*
  �������� 
    - ������� EnumDesc (������ ������������ ����)
    - �����
    - ��������
*/


/*-------------------------------------------------------------------------------*/

CREATE TABLE EnumDesc(
   Id                    INTEGER NOT NULL PRIMARY KEY, 
   Code                  TVarChar NOT NULL UNIQUE,
   ItemName              TVarChar);


/*-------------------------------------------------------------------------------*/

/*                                  �������                                      */


CREATE UNIQUE INDEX EnumDesc_Code ON EnumDesc(Code);

CLUSTER EnumDesc_Code ON EnumDesc 


/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.   
13.06.02                                              
*/
