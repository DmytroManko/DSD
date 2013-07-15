/*
  �������� 
    - ������� MovementItemFloat (�������� o������� ���� TFloat)
    - �����
    - ��������
*/

/*-------------------------------------------------------------------------------*/
CREATE TABLE MovementItemFloat(
   DescId                INTEGER NOT NULL,
   MovementItemId        INTEGER NOT NULL,
   ValueData             TFloat,

   CONSTRAINT pk_MovementItemFloat          PRIMARY KEY (MovementItemId, DescId),
   CONSTRAINT fk_MovementItemFloat_DescId   FOREIGN KEY(DescId)   REFERENCES MovementItemFloatDesc(Id),
   CONSTRAINT fk_MovementItemFloat_MovementItemId FOREIGN KEY(MovementItemId) REFERENCES MovementItem(Id) );

/*-------------------------------------------------------------------------------*/
/*                                  �������                                      */


CREATE UNIQUE INDEX idx_MovementItemFloat_MovementItemId_DescId_ValueData ON MovementItemFloat(MovementItemId, DescId, ValueData); 

/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�. 
14.06.02                                       
*/