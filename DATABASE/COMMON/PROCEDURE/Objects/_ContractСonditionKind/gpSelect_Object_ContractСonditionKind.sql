-- Function: gpSelect_Object_Contract�onditionKind (TVarChar)

DROP FUNCTION IF EXISTS gpSelect_Object_Contract�onditionKind (TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Object_Contract�onditionKind(
    IN inSession        TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer, Code Integer, Name TVarChar
             , isErased Boolean) AS
$BODY$BEGIN

   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Select_Object_Contract�onditionKind());

   RETURN QUERY 
   SELECT
        Object_Contract�onditionKind.Id           AS Id 
      , Object_Contract�onditionKind.ObjectCode   AS Code
      , Object_Contract�onditionKind.ValueData    AS NAME
      
      , Object_Contract�onditionKind.isErased     AS isErased
      
   FROM OBJECT AS Object_Contract�onditionKind
                              
   WHERE Object_Contract�onditionKind.DescId = zc_Object_Contract�onditionKind();
  
END;$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpSelect_Object_Contract�onditionKind (TVarChar) OWNER TO postgres;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 16.11.13         *

*/

-- ����
-- SELECT * FROM gpSelect_Object_Contract�onditionKind('2')
