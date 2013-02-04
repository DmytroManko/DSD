/*
  �������� 
    - ������� Object (o������)
    - ������
    - ��������
*/


/*-------------------------------------------------------------------------------*/

CREATE TABLE Object(
   Id         SERIAL NOT NULL PRIMARY KEY, 
   DescId     INTEGER NOT NULL,
   ObjectCode INTEGER,
   ValueData  TVarChar,
   IsErased   boolean NOT NULL DEFAULT false,

   /* ����� � �������� <ObjectDesc> - ����� ������� */
   CONSTRAINT Object_DescId_ObjectDesc FOREIGN KEY(DescId) REFERENCES ObjectDesc(Id));

/*-------------------------------------------------------------------------------*/

/*                                  �������                                      */


CREATE INDEX Object_DescId ON Object(DescId);

CLUSTER Object_DescId ON Object; 


/*-------------------------------------------------------------------------------*/


/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.   
13.06.02              *                *
*/
