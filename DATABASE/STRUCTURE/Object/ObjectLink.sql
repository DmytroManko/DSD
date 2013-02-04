/*
  �������� 
    - ������� ObjectLink (����� o�������)
    - �����
    - ��������
*/

/*-------------------------------------------------------------------------------*/
CREATE TABLE ObjectLink(
   DescId         INTEGER NOT NULL,
   ParentObjectId INTEGER NOT NULL,
   ChildObjectId  INTEGER,

   CONSTRAINT ObjectLink_DescId_ObjectLinkDesc FOREIGN KEY(DescId) REFERENCES ObjectLinkDesc(Id),
   CONSTRAINT ObjectLink_ParentObjectId_Object FOREIGN KEY(ParentObjectId) REFERENCES Object(Id),
   CONSTRAINT ObjectLink_ChildObjectId_Object FOREIGN KEY(ChildObjectId) REFERENCES Object(Id));
/*-------------------------------------------------------------------------------*/

/*                                  �������                                      */

CREATE UNIQUE INDEX ObjectLink_All ON ObjectLink(DescId, ParentObjectId, ChildObjectId);
CLUSTER ObjectLink_All ON ObjectLink;

/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.
13.06.02                                      
*/
