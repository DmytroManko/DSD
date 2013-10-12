-- Function: zfFormat_PartionGoods

-- DROP FUNCTION zfFormat_PartionGoods (TVarChar);

CREATE OR REPLACE FUNCTION zfFormat_PartionGoods(
    IN inPartionGoods TVarChar
)
RETURNS TVarChar AS
$BODY$
  DECLARE vbValue TVarChar;
BEGIN
     
     RETURN (SELECT MIN (Object_UserRole_User.ChildObjectId)
             FROM ObjectLink AS Object_UserRole_User -- ����� ������������ � �������� ���� ������������
                  JOIN ObjectLink AS Object_UserRole_Role -- ����� ����� � �������� ���� ������������
                                  ON Object_UserRole_Role.DescId = zc_ObjectLink_UserRole_Role()
                                 AND Object_UserRole_Role.ObjectId = Object_UserRole_User.ObjectId
                                 AND Object_UserRole_Role.ChildObjectId = zc_Enum_Role_Admin()
             WHERE Object_UserRole_User.DescId = zc_ObjectLink_UserRole_User());

END;
$BODY$
LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION zfFormat_PartionGoods (TVarChar) OWNER TO postgres;


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 24.07.13                        *
*/

-- ����
-- SELECT * FROM zfFormat_PartionGoods ('asasa12-12-22-44')
-- SELECT * FROM zfFormat_PartionGoods ('�����72121������')
