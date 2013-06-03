-- Function: gpGet_Object_Route()

-- DROP FUNCTION gpGet_Object_Route (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpGet_Object_Route(
    IN inId             Integer,       -- ���� ������� <�������>
    IN inSession        TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer, Code Integer, Name TVarChar, isErased Boolean) AS
$BODY$BEGIN

   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Route());

   RETURN QUERY
   SELECT
      Object.Id
    , Object.ObjectCode
    , Object.ValueData AS Name
    , Object.isErased
   FROM Object 
   WHERE Object.Id = inId;
  
END;$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpGet_Object_Route (Integer, TVarChar) OWNER TO postgres;


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 03.06.13          *

*/

-- ����
-- SELECT * FROM gpGet_Object_Route (2, '')
