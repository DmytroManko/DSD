-- Function: gpSelect_Object_StoragePlace()

DROP FUNCTION IF EXISTS gpSelect_Object_StoragePlace (TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Object_StoragePlace(
    IN inSession           TVarChar     -- ������ ������������
)
RETURNS TABLE (Id Integer, Code Integer, Name TVarChar, ItemName TVarChar, isErased Boolean
              )
AS
$BODY$
  DECLARE vbUserId Integer;
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId := PERFORM lpCheckRight (inSession, zc_Enum_Process_Select_Object_StoragePlace());
     vbUserId := inSession;

     RETURN QUERY
       WITH tmpUserTransport AS (SELECT UserId FROM ObjectLink_UserRole_View WHERE RoleId = zc_Enum_Role_Transport())
     SELECT Object_Unit_View.Id
          , Object_Unit_View.Code     
          , Object_Unit_View.Name
          , ObjectDesc.ItemName
          , Object_Unit_View.isErased
     FROM Object_Unit_View
          LEFT JOIN ObjectDesc ON ObjectDesc.Id = Object_Unit_View.DescId
     WHERE vbUserId NOT IN (SELECT UserId FROM tmpUserTransport)
    UNION ALL
     SELECT View_Personal.PersonalId AS Id       
          , View_Personal.PersonalCode     
          , View_Personal.PersonalName
          , ObjectDesc.ItemName
          , View_Personal.isErased
     FROM Object_Personal_View AS View_Personal
          LEFT JOIN ObjectDesc ON ObjectDesc.Id = View_Personal.DescId
     WHERE vbUserId NOT IN (SELECT UserId FROM tmpUserTransport)
    UNION ALL
     SELECT View_Personal.PersonalId AS Id       
          , View_Personal.PersonalCode     
          , View_Personal.PersonalName
          , ObjectDesc.ItemName
          , View_Personal.isErased
     FROM lfSelect_Object_Unit_byProfitLossDirection() AS lfObject_Unit_byProfitLossDirection
          JOIN Object_Personal_View AS View_Personal ON View_Personal.UnitId = lfObject_Unit_byProfitLossDirection.UnitId
          LEFT JOIN ObjectDesc ON ObjectDesc.Id = View_Personal.DescId
     WHERE vbUserId IN (SELECT UserId FROM tmpUserTransport)
       AND (lfObject_Unit_byProfitLossDirection.ProfitLossDirectionId = zc_Enum_ProfitDirection_40100() -- ���������� ����������
         OR lfObject_Unit_byProfitLossDirection.UnitCode IN (23020)) -- ����� ���������
    ;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpSelect_Object_StoragePlace (TVarChar) OWNER TO postgres;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 07.12.13                                        * rename UserRole_View -> ObjectLink_UserRole_View
 09.11.13                                        * add tmpUserTransport
 09.11.13                                        * add ItemName
 28.10.13                         *
*/

-- ����
-- SELECT * FROM gpSelect_Object_StoragePlace (inSession := zfCalc_UserAdmin())
-- SELECT * FROM gpSelect_Object_StoragePlace (inSession := '9818')
