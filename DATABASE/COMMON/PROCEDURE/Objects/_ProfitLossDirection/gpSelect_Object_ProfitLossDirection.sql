-- Function: gpSelect_Object_ProfitLossDirection (TVarChar)

-- DROP FUNCTION gpSelect_Object_ProfitLossDirection (TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Object_ProfitLossDirection(
    IN inSession        TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer, Code Integer, Name TVarChar, isErased Boolean) AS
$BODY$BEGIN

   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight (inSession, zc_Enum_Process_ProfitLossDirection());

   RETURN QUERY 
   SELECT
         Object.Id         AS Id 
       , Object.ObjectCode AS Code
       , Object.ValueData  AS Name
       , Object.isErased   AS isErased
   FROM Object
   WHERE Object.DescId = zc_Object_ProfitLossDirection();
  
END;$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpSelect_Object_ProfitLossDirection (TVarChar) OWNER TO postgres;


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 18.06.13          *

*/

-- ����
-- SELECT * FROM gpSelect_Object_ProfitLossDirection('2')
