-- Function: gpGet_Object_RouteSorting (Integer, TVarChar)

-- DROP FUNCTION gpGet_Object_RouteSorting (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpGet_Object_RouteSorting(
    IN inId             Integer,       -- ���� ������� <���������� ���������>
    IN inSession        TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer, Code Integer, Name TVarChar, isErased Boolean) AS
$BODY$BEGIN

   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight (inSession, zc_Enum_Process_RouteSorting());

   RETURN QUERY
   SELECT
      Object.Id
    , Object.ObjectCode AS Code
    , Object.ValueData AS Name
    , Object.isErased
   FROM Object 
   WHERE Object.Id = inId;
  
END;$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpGet_Object_RouteSorting (Integer, TVarChar) OWNER TO postgres;


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 04.06.13          *

*/

-- ����
-- SELECT * FROM gpGet_Object_RouteSorting (2, '')
