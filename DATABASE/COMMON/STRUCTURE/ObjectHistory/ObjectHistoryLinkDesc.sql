/*
  �������� 
    - ������� ObjectHistoryLinkDesc (����� ������� o�������)
    - �����
    - ��������
*/

/*-------------------------------------------------------------------------------*/
CREATE TABLE ObjectHistoryLinkDesc(
   Id                    INTEGER NOT NULL PRIMARY KEY,
   Code                  TVarChar NOT NULL UNIQUE,
   ItemName              TVarChar,
   DescId                Integer NOT NULL,
   ObjectDescId          Integer,

   CONSTRAINT fk_ObjectHistoryLinkDesc_DescId       FOREIGN KEY(DescId) REFERENCES ObjectHistoryDesc(Id),
   CONSTRAINT fk_ObjectHistoryLinkDesc_ObjectDescId  FOREIGN KEY(ObjectDescId)  REFERENCES ObjectDesc(Id));

/*-------------------------------------------------------------------------------*/

/*                                  �������                                      */

/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.
14.06.02                                      
*/
