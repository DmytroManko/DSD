-- Function: gpGet_Object_Fuel()

-- DROP FUNCTION gpGet_Object_Fuel();

CREATE OR REPLACE FUNCTION gpGet_Object_Fuel(
    IN inId          Integer,       -- ���� ������� <����������>
    IN inSession     TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer, Code Integer, Name TVarChar 
             , Ratio TFloat
             , isErased boolean
             ) AS
$BODY$
BEGIN

  -- �������� ���� ������������ �� ����� ���������
  -- PERFORM lpCheckRight(inSession, zc_Enum_Process_Get_Object_Fuel());

   IF COALESCE (inId, 0) = 0
   THEN
       RETURN QUERY 
       SELECT
             CAST (0 as Integer)    AS Id
           , COALESCE (MAX (Object_Fuel.ObjectCode), 0) + 1 AS Code
           , CAST ('' as TVarChar)  AS NAME
           
           , CAST (0 as TFloat)     AS Ratio

           , CAST (NULL AS Boolean) AS isErased

       FROM Object AS Object_Fuel
       WHERE Object_Fuel.DescId = zc_Object_Fuel();
   ELSE
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

       WHERE Object_Fuel.Id = inId;
      
   END IF;
  
END;
$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpGet_Object_Fuel(integer, TVarChar) OWNER TO postgres;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 24.09.13          * 

*/

-- ����
-- SELECT * FROM gpGet_Object_Fuel (2, '')
