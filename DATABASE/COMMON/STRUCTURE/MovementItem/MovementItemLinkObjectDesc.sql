/*
  �������� 
    - ������� MovementItemLinkObjectDesc (������ ������ ����� �������� ����������� � �������� ��������)
    - ������
    - ��������
*/
-- Table: MovementItemLinkObjectDesc

-- DROP TABLE MovementItemLinkObjectDesc;

/*-------------------------------------------------------------------------------*/

CREATE TABLE MovementItemLinkObjectDesc
(
  Id                     Integer NOT NULL PRIMARY KEY,
  Code                   TVarChar NOT NULL UNIQUE,
  ItemName               TVarChar
)
WITH (
  OIDS=FALSE
);
ALTER TABLE MovementItemLinkObjectDesc
  OWNER TO postgres;

/*-------------------------------------------------------------------------------*/

/*                                  �������                                      */

/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.   
18.06.02                                         
*/
