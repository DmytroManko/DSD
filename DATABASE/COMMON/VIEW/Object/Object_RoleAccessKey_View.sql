-- View: Object_RoleAccessKey_View

DROP VIEW IF EXISTS Object_RoleAccess_View;
-- DROP VIEW IF EXISTS Object_RoleAccessKey_View;

CREATE OR REPLACE VIEW Object_RoleAccessKey_View AS

   -- ���������, ���� ��� ��� ����� �������� ��� ����� � ���� ������ ��������� (������ ���������)
   SELECT Object_Role_AccessKey.AccessKeyId
        , Object_Role_AccessKey.RoleId
        , ObjectLink_UserRole_View.UserId
   FROM (SELECT Id AS RoleId
              , CASE WHEN ObjectCode = 4 -- ���������-����-���� ����������
                          THEN zc_Enum_Process_AccessKey_TrasportDnepr()
                     WHEN ObjectCode = 14 -- ���������-�����-���� ����������
                          THEN zc_Enum_Process_AccessKey_TrasportKiev()
                END AS AccessKeyId
         FROM Object
         WHERE DescId = zc_Object_Role() AND ObjectCode IN (4  -- ���������-�����-���� ����������
                                                          , 14 -- ���������-����-���� ����������
                                                           )
        UNION ALL
         -- !!!��� ������!!!
         SELECT Id AS RoleId
              , tmpAccessKey.AccessKeyId
         FROM (SELECT zc_Enum_Process_AccessKey_TrasportDnepr() AS AccessKeyId
              UNION ALL
               SELECT zc_Enum_Process_AccessKey_TrasportKiev() AS AccessKeyId
              ) AS tmpAccessKey
              LEFT JOIN Object ON DescId = zc_Object_Role() AND ObjectCode IN (1) -- ���� ��������������
        ) AS Object_Role_AccessKey
        LEFT JOIN ObjectLink_UserRole_View ON ObjectLink_UserRole_View.RoleId = Object_Role_AccessKey.RoleId
   ;

ALTER TABLE Object_RoleAccessKey_View OWNER TO postgres;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 07.12.13                                        *
*/

-- ����
-- SELECT * FROM Object_RoleAccessKey_View