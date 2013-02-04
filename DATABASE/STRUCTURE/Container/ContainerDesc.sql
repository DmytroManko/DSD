/*
  �������� 
    - ������� ContainerDesc ()
    - ������
    - ��������
*/

/*-------------------------------------------------------------------------------*/
CREATE TABLE ContainerDesc(
   Id                    INTEGER NOT NULL PRIMARY KEY, 
   Code                  TVarChar NOT NULL UNIQUE,
   ItemName              TVarChar);

/*-------------------------------------------------------------------------------*/

/*                                  �������                                      */


CREATE UNIQUE INDEX ContainerDesc_Code ON ContainerDesc(Code);
CLUSTER ContainerDesc_Code ON ContainerDesc;


/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.   
18.06.02                                         
01.07.02                                         
*/
