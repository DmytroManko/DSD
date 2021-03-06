-- Function: gpSelect_MovementItem_PersonalAccount (Integer, Boolean, Boolean, TVarChar)

DROP FUNCTION IF EXISTS gpSelect_MovementItem_PersonalAccount (Integer, Boolean, Boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_MovementItem_PersonalAccount(
    IN inMovementId  Integer      , -- ���� ���������
    IN inShowAll     Boolean      , -- 
    IN inIsErased    Boolean      , -- 
    IN inSession     TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer, OperDate TDateTime
             , InfoMoneyId Integer, InfoMoneyName TVarChar
             , ContractId Integer, ContractName TVarChar
             , JuridicalId Integer, JuridicalName TVarChar
             , RouteId Integer, RouteName TVarChar
             , CarId Integer, CarName TVarChar, CarModelName TVarChar
             , Amount TFloat
             , isErased Boolean
              )
AS
$BODY$
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Select_MI_PersonalAccount());

     RETURN QUERY 
       SELECT MovementItem.Id
            , MIDate_OperDate.ValueData   AS OperDate
           
            , View_InfoMoney.InfoMoneyId
            , View_InfoMoney.InfoMoneyName
            
            , Object_Contract.Id          AS ContractId
            , Object_Contract.ValueData   AS ContractName           
            
            , Object_Juridical.Id         AS JuridicalId
            , Object_Juridical.ValueData  AS JuridicalName
                  
            , Object_Route.Id             AS RouteId
            , Object_Route.ValueData      AS RouteName

            , Object_Car.Id               AS CarId
            , Object_Car.ValueData        AS CarName
            , Object_CarModel.ValueData   AS CarModelName

            
            , MovementItem.Amount         AS Amount
            , MovementItem.isErased       AS isErased
                  
       FROM (SELECT FALSE AS isErased UNION ALL SELECT inIsErased AS isErased WHERE inIsErased = TRUE) AS tmpIsErased
       
             JOIN MovementItem ON MovementItem.MovementId = inMovementId
                              AND MovementItem.DescId     = zc_MI_Master()
                              AND MovementItem.isErased   = tmpIsErased.isErased
                 
             LEFT JOIN MovementItemDate AS MIDate_OperDate
                                        ON MIDate_OperDate.MovementItemId = MovementItem.Id
                                       AND MIDate_OperDate.DescId = zc_MIDate_OperDate()
                 
             LEFT JOIN MovementItemLinkObject AS MILinkObject_InfoMoney
                                              ON MILinkObject_InfoMoney.MovementItemId = MovementItem.Id
                                             AND MILinkObject_InfoMoney.DescId = zc_MILinkObject_InfoMoney()
             LEFT JOIN Object_InfoMoney_View AS View_InfoMoney ON View_InfoMoney.InfoMoneyId = MILinkObject_InfoMoney.ObjectId
             
             LEFT JOIN MovementItemLinkObject AS MILinkObject_Contract
                                              ON MILinkObject_Contract.MovementItemId = MovementItem.Id
                                             AND MILinkObject_Contract.DescId = zc_MILinkObject_Contract()
             LEFT JOIN Object AS Object_Contract ON Object_Contract.Id = MILinkObject_Contract.ObjectId
                 
             LEFT JOIN MovementItemLinkObject AS MILinkObject_Route
                                              ON MILinkObject_Route.MovementItemId = MovementItem.Id
                                             AND MILinkObject_Route.DescId = zc_MILinkObject_Route()
             LEFT JOIN Object AS Object_Route ON Object_Route.Id = MILinkObject_Route.ObjectId
                 
             LEFT JOIN MovementItemLinkObject AS MILinkObject_Car
                                              ON MILinkObject_Car.MovementItemId = MovementItem.Id
                                             AND MILinkObject_Car.DescId = zc_MILinkObject_Car()
             LEFT JOIN Object AS Object_Car ON Object_Car.Id = MILinkObject_Car.ObjectId
                                                  
             LEFT JOIN Object AS Object_Juridical ON Object_Juridical.Id =MovementItem.ObjectId

             LEFT JOIN ObjectLink AS Car_CarModel ON Car_CarModel.ObjectId = Object_Car.Id
                                                 AND Car_CarModel.DescId = zc_ObjectLink_Car_CarModel()
             LEFT JOIN Object AS Object_CarModel ON Object_CarModel.Id = Car_CarModel.ChildObjectId

      ;

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION gpSelect_MovementItem_PersonalAccount (Integer, Boolean, Boolean, TVarChar) OWNER TO postgres;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 19.12.13         *
*/

-- ����
-- SELECT * FROM gpSelect_MovementItem_PersonalAccount (inMovementId:= 25173, inShowAll:= TRUE, inIsErased:= TRUE, inSession:= '2')
-- SELECT * FROM gpSelect_MovementItem_PersonalAccount (inMovementId:= 25173, inShowAll:= FALSE, inIsErased:= FALSE, inSession:= '2')
