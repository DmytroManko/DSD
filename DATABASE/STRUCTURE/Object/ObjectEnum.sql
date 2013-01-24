/*
  �������� 
    - ������� ObjectEnum (����� �������� � ������������� ������)
    - �����
    - ��������
*/

/*-------------------------------------------------------------------------------*/

CREATE TABLE ObjectEnum(
   DescId         INTEGER NOT NULL,
   ObjectId       INTEGER NOT NULL,
   EnumId         INTEGER NOT NULL,

   CONSTRAINT ObjectEnum_DescId_ObjectEnumDesc FOREIGN KEY(DescId) REFERENCES ObjectEnumDesc(Id),
   CONSTRAINT ObjectEnum_ObjectId_Object FOREIGN KEY(ObjectId) REFERENCES Object(Id),
   CONSTRAINT ObjectEnum_EnumId_Enum FOREIGN KEY(EnumId) REFERENCES Enum(Id));


/*-------------------------------------------------------------------------------*/
/*                                  �������                                      */


CREATE UNIQUE INDEX ObjectEnum_DescId_EnumId_ObjectId ON ObjectEnum(DescId, EnumId, ObjectId); 
CLUSTER ObjectEnum_DescId_EnumId_ObjectId ON ObjectEnum; 

/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.   
14.06.02                                         
*/
