-- Function: zfCalc_AccessKey_GuideAll

DROP FUNCTION IF EXISTS zfCalc_AccessKey_GuideAll (Integer);

CREATE OR REPLACE FUNCTION zfCalc_AccessKey_GuideAll (IN inUserId Integer)
RETURNS Boolean AS
$BODY$
BEGIN
     RETURN COALESCE ((SELECT TRUE WHERE EXISTS (SELECT AccessKeyId FROM Object_RoleAccessKey_View WHERE UserId = inUserId AND AccessKeyId = zc_Enum_Process_AccessKey_GuideAll())), FALSE);
END;
$BODY$
  LANGUAGE PLPGSQL IMMUTABLE;
ALTER FUNCTION zfCalc_AccessKey_GuideAll (Integer) OWNER TO postgres;


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 14.12.13                                        *
*/

-- ����
-- SELECT * FROM zfCalc_AccessKey_GuideAll (zfCalc_UserAdmin()::Integer)

