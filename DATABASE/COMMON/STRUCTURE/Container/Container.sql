/*
  �������� 
    - ������� Container ()
    - ������
    - ��������
*/

/*-------------------------------------------------------------------------------*/

CREATE TABLE Container(
   Id                    SERIAL NOT NULL PRIMARY KEY, 
   DescId                INTEGER, 
   AccountId             Integer, -- ����
   Amount                TFloat,

   CONSTRAINT fk_Container_DescId_ContainerDesc FOREIGN KEY(DescId) REFERENCES ContainerDesc(Id),
   CONSTRAINT fk_Container_AccountId_Object FOREIGN KEY(AccountId) REFERENCES Object(Id)
);


/*-------------------------------------------------------------------------------*/
/*                                  �������                                      */


CREATE INDEX idx_Container_DescId ON Container(DescId); 
CREATE INDEX idx_Container_AccountId_DescId_Id ON Container(AccountId, DescId, Id); 

/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.   
18.06.02                                         
11.07.02                                         
*/
