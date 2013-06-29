/*
  �������� 
    - ������� ContainerLinkObjectDesc ()
    - ������
    - ��������
*/

/*-------------------------------------------------------------------------------*/

-- Table: ContainerLinkObjectDesc

-- DROP TABLE ContainerLinkObjectDesc;

CREATE TABLE ContainerLinkObjectDesc
(
   Id                    SERIAL NOT NULL PRIMARY KEY, 
   Code                  TVarChar NOT NULL UNIQUE,
   ItemName              TVarChar
)
WITH (
  OIDS=FALSE
);
ALTER TABLE ContainerLinkObjectDesc
  OWNER TO postgres;

/*-------------------------------------------------------------------------------*/
/*                                  �������                                      */



/*-------------------------------------------------------------------------------
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.   
 29.06.13             * SERIAL
*/
