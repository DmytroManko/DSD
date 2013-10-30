-- Function: gpSelect_Object_StaffListSummKind (TVarChar)

DROP FUNCTION IF EXISTS gpSelect_Object_StaffListSummKind (TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Object_StaffListSummKind(
    IN inSession        TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer, Code Integer, Name TVarChar
             , isErased Boolean) AS
$BODY$BEGIN

   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Select_Object_StaffListSummKind());

   RETURN QUERY 
   SELECT
        Object_StaffListSummKind.Id           AS Id 
      , Object_StaffListSummKind.ObjectCode   AS Code
      , Object_StaffListSummKind.ValueData    AS NAME
      
      , Object_StaffListSummKind.isErased     AS isErased
      
   FROM OBJECT AS Object_StaffListSummKind
                              
   WHERE Object_StaffListSummKind.DescId = zc_Object_StaffListSummKind();
  
END;$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpSelect_Object_StaffListSummKind (TVarChar) OWNER TO postgres;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 30.10.13         *

*/

-- ����
-- SELECT * FROM gpSelect_Object_StaffListSummKind('2')
