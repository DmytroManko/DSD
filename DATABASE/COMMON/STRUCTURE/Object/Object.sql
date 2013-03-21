/*
  �������� 
    - ������� Object (o������)
    - ������
    - ��������
*/


/*-------------------------------------------------------------------------------*/

CREATE TABLE Object(
   Id                    SERIAL NOT NULL PRIMARY KEY, 
   DescId                Integer NOT NULL,
   ObjectCode            Integer,
   ValueData             TVarChar,
   IsErased              Boolean NOT NULL DEFAULT false,

   /* ����� � �������� <ObjectDesc> - ����� ������� */
   CONSTRAINT fk_Object_DescId FOREIGN KEY(DescId) REFERENCES ObjectDesc(Id));

/*-------------------------------------------------------------------------------*/

/*                                  �������                                      */


CREATE INDEX idx_Object_DescId ON Object(DescId);

CLUSTER idx_Object_DescId ON Object; 


/*-------------------------------------------------------------------------------*/


/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.   
13.06.02              *                *
*/
