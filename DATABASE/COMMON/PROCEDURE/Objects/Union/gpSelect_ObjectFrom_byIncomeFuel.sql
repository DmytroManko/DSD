-- Function: gpSelect_ObjectFrom_byIncomeFuel()

DROP FUNCTION IF EXISTS gpSelect_ObjectFrom_byIncomeFuel (TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_ObjectFrom_byIncomeFuel(
    IN inSession           TVarChar            -- ������ ������������
)
RETURNS TABLE (Id Integer, Code Integer, Name TVarChar,
               JuridicalId Integer, JuridicalCode Integer, JuridicalName TVarChar, 
               isErased Boolean
              )
AS
$BODY$
BEGIN

   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight(inSession, zc_Enum_Process_Select_Object_Partner());

   RETURN QUERY 
     SELECT Object_Partner.Id             AS Id
          , Object_Partner.ObjectCode     AS Code
          , Object_Partner.ValueData      AS NAME

          , Object_Juridical.Id           AS JuridicalId
          , Object_Juridical.ObjectCode   AS JuridicalCode
          , Object_Juridical.ValueData    AS JuridicalName

          , Object_Partner.isErased   AS isErased

     FROM Object_InfoMoney_View
          JOIN ObjectLink AS ObjectLink_Juridical_InfoMoney
                          ON ObjectLink_Juridical_InfoMoney.DescId = zc_ObjectLink_Juridical_InfoMoney()
                         AND ObjectLink_Juridical_InfoMoney.ChildObjectId = Object_InfoMoney_View.InfoMoneyId
          LEFT JOIN Object AS Object_Juridical ON Object_Juridical.Id = ObjectLink_Juridical_InfoMoney.ObjectId

          JOIN ObjectLink AS ObjectLink_Partner_Juridical
                          ON ObjectLink_Partner_Juridical.ChildObjectId = ObjectLink_Juridical_InfoMoney.ObjectId
                         AND ObjectLink_Partner_Juridical.DescId = zc_ObjectLink_Partner_Juridical()
          LEFT JOIN Object AS Object_Partner ON Object_Partner.Id = ObjectLink_Partner_Juridical.ObjectId
          LEFT JOIN ObjectDesc AS ObjectDesc_Partner ON ObjectDesc_Partner.Id = Object_Partner.DescId

     WHERE Object_InfoMoney_View.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20400() -- ���
/*    UNION ALL
*/
    ;


END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpSelect_ObjectFrom_byIncomeFuel (TVarChar) OWNER TO postgres;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 14.10.13                                        *
*/

-- ����
-- SELECT * FROM gpSelect_ObjectFrom_byIncomeFuel ('2')