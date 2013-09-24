-- Function: gpSelect_Object_Fuel()

--DROP FUNCTION gpSelect_Object_Fuel();

CREATE OR REPLACE FUNCTION gpSelect_Object_Fuel(
    IN inSession     TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer, Code Integer, Name TVarChar 
             , Ratio TFloat
             , isErased boolean
             ) AS
$BODY$BEGIN
   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight(inSession, zc_Enum_Process_Select_Object_Fuel());

     RETURN QUERY 
       SELECT 
             Object_Fuel.Id          AS Id
           , Object_Fuel.ObjectCode  AS Code
           , Object_Fuel.ValueData   AS Name
           
           , ObjectFloat_Ratio.ValueData AS Ratio
 
           , Object.isErased AS isErased
           
       FROM Object AS Object_Fuel
       
           LEFT JOIN ObjectFloat AS ObjectFloat_Ratio ON ObjectFloat_Ratio.ObjectId = Object_Fuel.Id 
                                                     AND ObjectFloat_Ratio.DescId = zc_ObjectFloat_Fuel_Ratio()
       
     WHERE Object_Fuel.DescId = zc_Object_Fuel();
  
END;
$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpSelect_Object_Fuel(TVarChar) OWNER TO postgres;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 24.09.13          *
*/

-- ����
-- SELECT * FROM gpSelect_Object_Fuel('2')