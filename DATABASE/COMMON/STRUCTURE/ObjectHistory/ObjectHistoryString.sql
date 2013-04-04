/*
  �������� 
    - ������� ObjectHistoryString (�������� o������� ���� TString)
    - �����
    - ��������
*/

/*-------------------------------------------------------------------------------*/
CREATE TABLE ObjectHistoryString(
   DescId                INTEGER NOT NULL,
   ObjectHistoryId       INTEGER NOT NULL,
   ValueData             TVarChar,

   CONSTRAINT pk_ObjectHistoryString          PRIMARY KEY (ObjectHistoryId, DescId),
   CONSTRAINT fk_ObjectHistoryString_DescId   FOREIGN KEY(DescId)   REFERENCES ObjectHistoryStringDesc(Id),
   CONSTRAINT fk_ObjectHistoryString_ObjectHistoryId FOREIGN KEY(ObjectHistoryId) REFERENCES ObjectHistory(Id) );

/*-------------------------------------------------------------------------------*/
/*                                  �������                                      */


CREATE INDEX idx_ObjectHistoryString_ObjectHistoryId_DescId_ValueData ON ObjectHistoryString(ObjectHistoryId, DescId, ValueData); 

/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�. 
14.06.02                                       
*/