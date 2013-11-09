-- View: UserRole_View

-- DROP VIEW IF EXISTS UserRole_View;

CREATE OR REPLACE VIEW UserRole_View AS 
   SELECT ObjectLink_UserRole_Role.ChildObjectId AS RoleId
        , ObjectLink_UserRole_User.ChildObjectId AS UserId
   FROM ObjectLink AS ObjectLink_UserRole_Role
        JOIN ObjectLink AS ObjectLink_UserRole_User
                        ON ObjectLink_UserRole_User.ObjectId = ObjectLink_UserRole_Role.ObjectId
                       AND ObjectLink_UserRole_User.DescId = zc_ObjectLink_UserRole_User()
   WHERE ObjectLink_UserRole_Role.DescId = zc_ObjectLink_UserRole_Role()
  ;

ALTER TABLE UserRole_View OWNER TO postgres;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 09.11.13                                        *
*/

-- ����
-- SELECT * FROM UserRole_View
