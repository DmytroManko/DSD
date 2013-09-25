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
CREATE INDEX idx_Object_DescId_ValueData ON Object(DescId, ValueData);
CREATE INDEX idx_Object_DescId_ObjectCode ON Object(DescId, ObjectCode);

CLUSTER idx_Object_DescId ON Object; 

/*-------------------------------------------------------------------------------*/
/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.   
27.06.13              *

*/
