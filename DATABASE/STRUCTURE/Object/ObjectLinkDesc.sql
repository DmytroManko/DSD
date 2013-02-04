/*
  �������� 
    - ������� ObjectLinkDesc (����� ������� o�������)
    - �����
    - ��������
*/

/*-------------------------------------------------------------------------------*/
CREATE TABLE ObjectLinkDesc(
   Id                 INTEGER NOT NULL PRIMARY KEY,
   Code               TVarChar NOT NULL UNIQUE,
   ItemName           TVarChar,
   ParentObjectDescId Integer NOT NULL,
   ChildObjectDescId  Integer,
   isObligate         TVarChar,
   isManyLink         TVarChar,
   isErased           TVarChar,

   CONSTRAINT ObjectLinkDesc_ParentObjectDescId_ObjectDesc FOREIGN KEY(ParentObjectDescId) REFERENCES ObjectDesc(Id),
   CONSTRAINT ObjectLinkDesc_ChildObjectDescId_ObjectDesc FOREIGN KEY(ChildObjectDescId) REFERENCES ObjectDesc(Id));

/*-------------------------------------------------------------------------------*/

/*                                  �������                                      */



CREATE UNIQUE INDEX ObjectLinkDesc_Code ON ObjectLinkDesc(Code); 
CREATE INDEX ObjectLinkDesc_ParentObjectDescId ON ObjectLinkDesc(ParentObjectDescId); 
CREATE INDEX ObjectLinkDesc_ChildObjectDescId ON ObjectLinkDesc(ChildObjectDescId); 

/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.
14.06.02                                      
*/
