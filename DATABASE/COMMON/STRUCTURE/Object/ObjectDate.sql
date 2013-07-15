/*
  �������� 
    - ������� ObjectDate (�������� o������� ���� TDate)
    - �����
    - ��������
*/

/*-------------------------------------------------------------------------------*/
CREATE TABLE ObjectDate(
   DescId     INTEGER NOT NULL,
   ObjectId   INTEGER NOT NULL,
   ValueData  TDateTime,

   CONSTRAINT pk_ObjectDate          PRIMARY KEY (ObjectId, DescId),
   CONSTRAINT fk_ObjectDate_DescId   FOREIGN KEY(DescId)   REFERENCES ObjectDateDesc(Id),
   CONSTRAINT fk_ObjectDate_ObjectId FOREIGN KEY(ObjectId) REFERENCES Object(Id) );

/*-------------------------------------------------------------------------------*/
/*                                  �������                                      */


CREATE UNIQUE INDEX idx_ObjectDate_ObjectId_DescId_ValueData ON ObjectDate(ObjectId, DescId, ValueData); 

/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�. 
14.06.02                                       
*/