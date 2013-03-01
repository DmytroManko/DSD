/*
  �������� 
    - ������� MovementLinkObjectDesc (������ ������ ����� �������� ����������� � �������� ��������)
    - ������
    - ��������
*/
-- Table: MovementLinkObjectDesc

-- DROP TABLE MovementLinkObjectDesc;

/*-------------------------------------------------------------------------------*/

CREATE TABLE MovementLinkObjectDesc
(
  Id integer NOT NULL,
  Code tvarchar,
  ItemName tvarchar,
  CONSTRAINT MovementLinkObjectDesc_PKey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE MovementLinkObjectDesc
  OWNER TO postgres;

/*-------------------------------------------------------------------------------*/

/*                                  �������                                      */

CLUSTER MovementLinkObjectDesc_PKey ON MovementLinkObjectDesc 

/*
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.   ��������� �.�.   ��������� �.�.
18.06.02                                              *
*/
