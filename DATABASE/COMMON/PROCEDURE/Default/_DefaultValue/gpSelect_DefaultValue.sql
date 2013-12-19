-- Function: gpSelect_DefaultValue(TVarChar)

DROP FUNCTION IF EXISTS gpSelect_DefaultValue (TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_DefaultValue(
    IN inSession     TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer, Key TVarChar, FormClassName TVarChar, DescName TVarChar,
               UserName TVarChar, ObjectCode TVarChar, ObjectName TVarChar)
AS
$BODY$
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight(inSession, zc_Enum_Process_Select_Object_Account());
   
     RETURN QUERY 
       SELECT DefaultValue.Id,
              DefaultKeys.Key, 
              (DefaultKeys.KeyData::json)->>'FormClassName' AS FormClassName, 
              (DefaultKeys.KeyData::json)->>'DescName' AS DescName,
              Object_User.ValueData AS UserName, 
              Object.ObjectCode AS ObjectCode,
              Object.ValueData AS ObjectName 
         FROM DefaultValue
         JOIN DefaultKeys ON DefaultKeys.Id = DefaultValue.DefaultKeyId
         JOIN Object AS Object_User ON Object_User.Id = UserKeyId
         JOIN Object ON Object.Id = zfConvert_StringToNumber(DefaultValue.DefaultValue);

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION gpSelect_DefaultValue (TVarChar) OWNER TO postgres;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 18.12.13                        *
*/

-- ����
-- SELECT * FROM gpSelect_DefaultKey (zfCalc_UserAdmin())