-- Function: gpSelect_Object_Unit()

DROP FUNCTION IF EXISTS gpSelect_Object_Unit(TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Object_Unit(
    IN inSession     TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer, Code Integer, Name TVarChar, 
               ParentId Integer, ParentName TVarChar,
               BusinessId Integer, BusinessName TVarChar, 
               BranchId Integer, BranchName TVarChar,
               JuridicalId Integer, JuridicalName TVarChar,
               AccountDirectionId Integer, AccountDirectionName TVarChar,
               ProfitLossDirectionId Integer, ProfitLossDirectionName TVarChar,
               isErased boolean, isLeaf boolean) AS
$BODY$
BEGIN
   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight(inSession, zc_Enum_Process_Select_Object_Unit());

   RETURN QUERY 
       SELECT 
             Object_Unit_View.Id     
           , Object_Unit_View.Code   
           , Object_Unit_View.Name
         
           , Object_Unit_View.ParentId 
           , Object_Unit_View.ParentName 

           , Object_Unit_View.BusinessId
           , Object_Unit_View.BusinessName 
         
           , Object_Unit_View.BranchId
           , Object_Unit_View.BranchName
         
           , Object_Unit_View.JuridicalId
           , Object_Unit_View.JuridicalName
         
           , Object_Unit_View.AccountDirectionId
           , Object_Unit_View.AccountDirectionName
         
           , Object_Unit_View.ProfitLossDirectionId
           , Object_Unit_View.ProfitLossDirectionName
         
           , Object_Unit_View.isErased
           , Object_Unit_View.isLeaf
       FROM Object_Unit_View;
  
END;
$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpSelect_Object_Unit(TVarChar) OWNER TO postgres;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 28.10.13                         * ������� �� View              
 04.07.13          * ���������� ����� �����������              
 03.06.13          

*/

-- ����
-- SELECT * FROM gpSelect_Object_Unit ('2')