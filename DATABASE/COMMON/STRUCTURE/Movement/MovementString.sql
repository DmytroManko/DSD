/*
  �������� 
    - ������� MovementString (�������� �������� ���� TVarChar)
    - �����
    - ��������
*/

/*-------------------------------------------------------------------------------*/

CREATE TABLE MovementString(
   DescId                INTEGER NOT NULL,
   MovementId              INTEGER NOT NULL,
   ValueData             TVarChar,

   CONSTRAINT pk_MovementString          PRIMARY KEY (MovementId, DescId),
   CONSTRAINT pk_MovementString_DescId   FOREIGN KEY(DescId) REFERENCES MovementStringDesc(Id),
   CONSTRAINT pk_MovementString_MovementId FOREIGN KEY(MovementId) REFERENCES Movement(Id) );

/*-------------------------------------------------------------------------------*/
/*                                  �������                                      */


CREATE INDEX idx_MovementString_MovementId_DescId_ValueData ON MovementString (MovementId, DescId, ValueData);

/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.
14.06.02
*/