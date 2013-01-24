/*
  �������� 
    - ������� ObjectEnumDesc (����� ������� �������� � �������� ������������ �����)
    - �����
    - ��������
*/

/*-------------------------------------------------------------------------------*/
CREATE TABLE ObjectEnumDesc(
   Id                 INTEGER NOT NULL PRIMARY KEY,
   Code               TVarChar NOT NULL UNIQUE,
   ItemName           TVarChar,
   ObjectDescId       Integer NOT NULL,
   EnumDescId         Integer NOT NULL,
   isManyEnum         TVarChar,

   CONSTRAINT ObjectEnumDesc_ObjectDescId_ObjectDesc FOREIGN KEY(ObjectDescId) REFERENCES ObjectDesc(Id),
   CONSTRAINT ObjectEnumDesc_EnumDescId_EnumDesc FOREIGN KEY(EnumDescId) REFERENCES EnumDesc(Id));

/*-------------------------------------------------------------------------------*/

/*                                  �������                                      */

CREATE UNIQUE INDEX ObjectEnumDesc_Code ON ObjectEnumDesc(Code);
CREATE INDEX ObjectEnumDesc_ObjectDescId ON ObjectEnumDesc(ObjectDescId); 
CREATE INDEX ObjectEnumDesc_EnumDescId ON ObjectEnumDesc(EnumDescId); 

/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.  
14.06.02                                        
*/
