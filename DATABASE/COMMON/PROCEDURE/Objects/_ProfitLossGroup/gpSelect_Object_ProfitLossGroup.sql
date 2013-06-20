-- Function: gpSelect_Object_ProfitLossGroup (TVarChar)

-- DROP FUNCTION gpSelect_Object_ProfitLossGroup (TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Object_ProfitLossGroup(
    IN inSession        TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer, Code Integer, Name TVarChar, isErased Boolean) AS
$BODY$BEGIN

   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight (inSession, zc_Enum_Process_ProfitLossGroup());

   RETURN QUERY 
   SELECT
         Object.Id         AS Id 
       , Object.ObjectCode AS Code
       , Object.ValueData  AS Name
       , Object.isErased   AS isErased
   FROM Object
   WHERE Object.DescId = zc_Object_ProfitLossGroup();
  
END;$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpSelect_Object_ProfitLossGroup (TVarChar) OWNER TO postgres;


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 18.06.13          *

*/

-- ����
-- SELECT * FROM gpSelect_Object_ProfitLossGroup('2')
