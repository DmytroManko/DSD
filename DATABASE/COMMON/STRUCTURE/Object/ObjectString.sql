/*
  �������� 
    - ������� ObjectString (�������� �������� ���� TVarChar)
    - �����
    - ��������
*/

/*-------------------------------------------------------------------------------*/

CREATE TABLE ObjectString(
   DescId     INTEGER NOT NULL,
   ObjectId   INTEGER NOT NULL,
   ValueData  TVarChar,

   CONSTRAINT ObjectString_PKey PRIMARY KEY (ObjectId, DescId),
   CONSTRAINT ObjectString_DescId_ObjectStringDesc FOREIGN KEY(DescId) REFERENCES ObjectStringDesc(Id),
   CONSTRAINT ObjectString_ObjectId_Object FOREIGN KEY(ObjectId) REFERENCES Object(Id) );

/*-------------------------------------------------------------------------------*/
/*                                  �������                                      */


CREATE INDEX ObjectString_Claster ON ObjectString
  (ObjectId, DescId, ValueData);
CLUSTER ObjectString_Claster ON ObjectString; 

/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.
14.06.02
*/