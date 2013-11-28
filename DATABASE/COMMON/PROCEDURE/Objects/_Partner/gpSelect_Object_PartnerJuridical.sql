-- Function: gpSelect_Object_Partner()

DROP FUNCTION IF EXISTS gpSelect_Object_PartnerJuridical (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Object_PartnerJuridical(
    IN inJuridicalId       Integer,            --
    IN inSession           TVarChar            -- ������ ������������
)
RETURNS TABLE (Id Integer, Code Integer, Address TVarChar, isErased Boolean
              )
AS
$BODY$
BEGIN

   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight(inSession, zc_Enum_Process_Select_Object_Partner());

   RETURN QUERY 
     SELECT 
           Object_Partner.Id             AS Id
         , Object_Partner.ObjectCode     AS Code
         , Object_Partner.ValueData      AS Address
         , Object_Partner.isErased       AS isErased
         
     FROM Object AS Object_Partner
     JOIN ObjectLink AS ObjectLink_Partner_Juridical
                     ON ObjectLink_Partner_Juridical.ObjectId = Object_Partner.Id 
                    AND ObjectLink_Partner_Juridical.DescId = zc_ObjectLink_Partner_Juridical()
                    AND ObjectLink_Partner_Juridical.ChildObjectId = inJuridicalId
         
    WHERE Object_Partner.DescId = zc_Object_Partner();
  
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpSelect_Object_PartnerJuridical (Integer, TVarChar) OWNER TO postgres;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 27.11.13                          *  
*/

-- ����
-- SELECT * FROM gpSelect_Object_Partner ('2')