-- Function: gpSelect_Object_Car()

--DROP FUNCTION gpSelect_Object_Car();

CREATE OR REPLACE FUNCTION gpSelect_Object_Car(
    IN inSession     TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer, Code Integer, Name TVarChar, isErased boolean) AS
$BODY$BEGIN
   -- �������� ���� ������������ �� ����� ���������
   --PERFORM lpCheckRight(inSession, zc_Enum_Process_Select_Object_Car());

     RETURN QUERY 
     SELECT 
       Object.Id         AS Id 
     , Object.ObjectCode AS Code
     , Object.ValueData  AS Name
     , Object.isErased   AS isErased
     FROM Object
     WHERE Object.DescId = zc_Object_Car();
  
END;
$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpSelect_Object_Car(TVarChar) OWNER TO postgres;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 10.06.13          * 
 03.06.13          

*/

-- ����
-- SELECT * FROM gpSelect_Object_Car('2')