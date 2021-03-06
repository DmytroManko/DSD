-- Function: gpSelect_Object_Contract()

DROP FUNCTION IF EXISTS gpSelect_Object_ContractJuridical (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Object_ContractJuridical(
    IN inJuridicalId    Integer, 
    IN inSession        TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer, Code Integer
             , InvNumber TVarChar, StartDate TDateTime
             , ContractKindName TVarChar, ContractArticleName TVarChar, ContractStateKindName TVarChar
             , isErased Boolean 
              )
AS
$BODY$
BEGIN

   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Select_Object_Contract());

   RETURN QUERY 
   SELECT
         Object_Contract_View.ContractId AS Id
       , Object_Contract_View.ContractCode AS Code
       , Object_Contract_View.InvNumber
       
       , Object_Contract_View.StartDate
       
       , Object_ContractKind.ValueData AS ContractKindName
       , Object_ContractArticle.ValueData   AS ContractArticleName
       , Object_ContractStateKind.ValueData AS ContractStateKindName

       , Object_Contract_View.isErased
       
   FROM Object_Contract_View
        LEFT JOIN ObjectLink AS ObjectLink_Contract_ContractKind
                             ON ObjectLink_Contract_ContractKind.ObjectId = Object_Contract_View.ContractId
                            AND ObjectLink_Contract_ContractKind.DescId = zc_ObjectLink_Contract_ContractKind()
        LEFT JOIN Object AS Object_ContractKind ON Object_ContractKind.Id = ObjectLink_Contract_ContractKind.ChildObjectId
        
        LEFT JOIN ObjectLink AS ObjectLink_Contract_ContractArticle
                             ON ObjectLink_Contract_ContractArticle.ObjectId = Object_Contract_View.ContractId
                            AND ObjectLink_Contract_ContractArticle.DescId = zc_ObjectLink_Contract_ContractArticle()
        LEFT JOIN Object AS Object_ContractArticle ON Object_ContractArticle.Id = ObjectLink_Contract_ContractArticle.ChildObjectId                               
      
        LEFT JOIN ObjectLink AS ObjectLink_Contract_ContractStateKind
                             ON ObjectLink_Contract_ContractStateKind.ObjectId = Object_Contract_View.ContractId 
                            AND ObjectLink_Contract_ContractStateKind.DescId = zc_ObjectLink_Contract_ContractStateKind() 
        LEFT JOIN Object AS Object_ContractStateKind ON Object_ContractStateKind.Id = ObjectLink_Contract_ContractStateKind.ChildObjectId
   WHERE Object_Contract_View.JuridicalId = inJuridicalId;
  
END;
$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpSelect_Object_ContractJuridical (Integer, TVarChar) OWNER TO postgres;


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 26.11.13                         *
*/

-- ����
-- SELECT * FROM gpSelect_Object_Contract (inSession := zfCalc_UserAdmin())
