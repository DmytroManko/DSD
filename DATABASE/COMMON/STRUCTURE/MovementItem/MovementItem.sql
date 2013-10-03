/*
  �������� 
    - ������� MovementItem
    - ������
    - ��������
*/

/*-------------------------------------------------------------------------------*/

CREATE TABLE MovementItem(
   Id           SERIAL NOT NULL PRIMARY KEY, 
   DescId       INTEGER NOT NULL,
   MovementId   INTEGER NOT NULL,
   ObjectId     INTEGER,
   Amount       TFloat, 
   isErased     Boolean NOT NULL DEFAULT false,
   ParentId     Integer,

   CONSTRAINT fk_MovementItem_DescId FOREIGN KEY(DescId) REFERENCES MovementItemDesc(Id),
   CONSTRAINT fk_MovementItem_MovementId FOREIGN KEY(MovementId) REFERENCES Movement(Id),
   CONSTRAINT fk_MovementItem_ObjectId FOREIGN KEY(ObjectId) REFERENCES Object(Id),
   CONSTRAINT fk_MovementItem_ParentId FOREIGN KEY(ParentId) REFERENCES MovementItem(Id)      
);

/*-------------------------------------------------------------------------------*/

/*                                  �������                                      */

CREATE INDEX idx_MovementItem_ParentId ON MovementItem (ParentId);
CREATE INDEX idx_MovementItem_MovementId ON MovementItem (MovementId);
CREATE INDEX idx_MovementItem_ObjectId ON MovementItem (ObjectId); -- ����������

CLUSTER idx_MovementItem_MovementId ON MovementItem;



/*-------------------------------------------------------------------------------
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.   
29.06.13              *

*/
