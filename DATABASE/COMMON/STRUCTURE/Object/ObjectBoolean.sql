/*
  �������� 
    - ������� ObjectBoolean (�������� �������� ���� TVarChar)
    - �����
    - ��������
*/

/*-------------------------------------------------------------------------------*/

CREATE TABLE ObjectBoolean(
   DescId                INTEGER NOT NULL,
   ObjectId              INTEGER NOT NULL,
   ValueData             Boolean,

   CONSTRAINT pk_ObjectBoolean          PRIMARY KEY (ObjectId, DescId),
   CONSTRAINT pk_ObjectBoolean_DescId   FOREIGN KEY(DescId) REFERENCES ObjectBooleanDesc(Id),
   CONSTRAINT pk_ObjectBoolean_ObjectId FOREIGN KEY(ObjectId) REFERENCES Object(Id) );

/*-------------------------------------------------------------------------------*/
/*                                  �������                                      */


CREATE INDEX idx_ObjectBoolean_ObjectId_DescId_ValueData ON ObjectBoolean (ObjectId, DescId, ValueData);

/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.
14.06.02
*/