-- Function: gpSelect_Object_ModelServiceKind (TVarChar)

DROP FUNCTION IF EXISTS gpSelect_Object_ModelServiceKind (TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Object_ModelServiceKind(
    IN inSession        TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer, Code Integer, Name TVarChar
             , isErased Boolean) AS
$BODY$BEGIN

   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Select_Object_ModelServiceKind());

   RETURN QUERY 
   SELECT
        Object_ModelServiceKind.Id           AS Id 
      , Object_ModelServiceKind.ObjectCode   AS Code
      , Object_ModelServiceKind.ValueData    AS NAME
      
      , Object_ModelServiceKind.isErased     AS isErased
      
   FROM OBJECT AS Object_ModelServiceKind
                              
   WHERE Object_ModelServiceKind.DescId = zc_Object_ModelServiceKind();
  
END;$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpSelect_Object_ModelServiceKind (TVarChar) OWNER TO postgres;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 18.10.13         *

*/

-- ����
-- SELECT * FROM gpSelect_Object_ModelServiceKind('2')
