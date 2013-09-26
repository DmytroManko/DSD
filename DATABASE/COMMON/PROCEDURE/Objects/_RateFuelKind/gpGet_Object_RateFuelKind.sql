-- Function: gpGet_Object_RateFuelKind()

-- DROP FUNCTION gpGet_Object_RateFuelKind();

CREATE OR REPLACE FUNCTION gpGet_Object_RateFuelKind(
    IN inId          Integer,       -- ���� ������� <����������>
    IN inSession     TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer, Code Integer, Name TVarChar
             , Tax TFloat
             , isErased Boolean
             ) AS
$BODY$
BEGIN

  -- �������� ���� ������������ �� ����� ���������
  -- PERFORM lpCheckRight(inSession, zc_Enum_Process_Get_Object_RateFuelKind());

   IF COALESCE (inId, 0) = 0
   THEN
       RETURN QUERY 
       SELECT
             CAST (0 as Integer)    AS Id
           , COALESCE (MAX (Object_RateFuelKind.ObjectCode), 0) + 1 AS Code
           , CAST ('' as TVarChar)  AS NAME
           
           , CAST (0 as TFloat)     AS Tax

           , CAST (NULL AS Boolean) AS isErased

       FROM Object AS Object_RateFuelKind
       WHERE Object_RateFuelKind.DescId = zc_Object_RateFuelKind();
   ELSE
       RETURN QUERY 
       SELECT 
              Object_RateFuelKind.Id         AS Id 
            , Object_RateFuelKind.ObjectCode AS Code
            , Object_RateFuelKind.ValueData  AS NAME
      
            , ObjectFloat_Tax.ValueData      AS Tax
       
            , Object_RateFuelKind.isErased   AS isErased
      
        FROM OBJECT AS Object_RateFuelKind
             LEFT JOIN ObjectFloat AS ObjectFloat_Tax ON ObjectFloat_Tax.ObjectId = Object_RateFuelKind.Id 
                                                     AND ObjectFloat_Tax.DescId = zc_ObjectFloat_RateFuelKind_Tax()

       WHERE Object_Fuel.Id = inId;
      
   END IF;
  
END;
$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpGet_Object_RateFuelKind(integer, TVarChar) OWNER TO postgres;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 26.09.13          * 

*/

-- ����
-- SELECT * FROM gpGet_Object_RateFuelKind (2, '')
