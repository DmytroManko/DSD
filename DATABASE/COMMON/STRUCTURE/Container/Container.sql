/*
  �������� 
    - ������� Container ()
    - ������
    - ��������
*/

/*-------------------------------------------------------------------------------*/

CREATE TABLE Container(
   Id                    SERIAL NOT NULL PRIMARY KEY, 
   DescId                INTEGER, 
   Amount                TFloat,

   CONSTRAINT fk_Container_DescId_ContainerDesc FOREIGN KEY(DescId) REFERENCES ContainerDesc(Id));


/*-------------------------------------------------------------------------------*/
/*                                  �������                                      */


CREATE INDEX idx_Container_DescId ON Container(DescId); 

/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.   
18.06.02                                         
11.07.02                                         
*/
