/*
  �������� 
    - ������� MovementItemDesc (������ �����������)
    - c�����
    - ��������
*/

/*-------------------------------------------------------------------------------*/

CREATE TABLE MovementItemDesc(
   Id                    INTEGER NOT NULL PRIMARY KEY, 
   Code                  TVarChar NOT NULL UNIQUE,
   ItemName              TVarChar);


/*-------------------------------------------------------------------------------*/

/*                                  �������                                      */


CREATE UNIQUE INDEX MovementItemDesc_Code ON MovementItemDesc(Code);
CLUSTER MovementItemDesc_Code ON MovementItemDesc;  



/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.  
18.06.02                                        
19.09.02                                        
*/
