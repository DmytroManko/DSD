/*
  �������� 
    - ������� MovementFloat (�������� o������� ���� TFloat)
    - �����
    - ��������
*/

/*-------------------------------------------------------------------------------*/
CREATE TABLE MovementFloat(
   DescId     INTEGER NOT NULL,
   MovementId   INTEGER NOT NULL,
   ValueData  TFloat,

   CONSTRAINT pk_MovementFloat          PRIMARY KEY (MovementId, DescId),
   CONSTRAINT fk_MovementFloat_DescId   FOREIGN KEY(DescId)   REFERENCES MovementFloatDesc(Id),
   CONSTRAINT fk_MovementFloat_MovementId FOREIGN KEY(MovementId) REFERENCES Movement(Id) );

/*-------------------------------------------------------------------------------*/
/*                                  �������                                      */


CREATE INDEX idx_MovementFloat_MovementId_DescId_ValueData ON MovementFloat(MovementId, DescId, ValueData); 

/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�. 
14.06.02                                       
*/