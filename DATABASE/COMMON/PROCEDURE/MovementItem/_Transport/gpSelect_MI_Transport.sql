-- Function: gpSelect_MI_Transport (Integer, Boolean, Boolean, TVarChar)

DROP FUNCTION IF EXISTS gpSelect_MI_Transport (Integer, Boolean, TVarChar);
DROP FUNCTION IF EXISTS gpSelect_MI_Transport (Integer, Boolean, Boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_MI_Transport(
    IN inMovementId  Integer      , -- ���� ���������
    IN inShowAll     Boolean      , -- 
    IN inIsErased    Boolean      , -- 
    IN inSession     TVarChar       -- ������ ������������
)
RETURNS SETOF refcursor
AS
$BODY$
  DECLARE Cursor1 refcursor;
  DECLARE Cursor2 refcursor;
BEGIN

   --PERFORM lpCheckRight(inSession, zc_Enum_Process_Select_MI_Transport());

    OPEN Cursor1 FOR 
        SELECT 
              MovementItem.Id
            , MovementItem.ObjectId    AS RouteId
            , Object_Route.ObjectCode  AS RouteCode
            , Object_Route.ValueData   AS RouteName
          
            , MovementItem.Amount
            , MIFloat_DistanceFuelChild.ValueData AS DistanceFuelChild
            , MIFloat_Weight.ValueData            AS Weight
            , MIFloat_StartOdometre.ValueData     AS StartOdometre
            , MIFloat_EndOdometre.ValueData       AS EndOdometre
           
            , Object_Freight.Id           AS FreightId
            , Object_Freight.ValueData    AS FreightName
            , Object_RouteKind.Id         AS RouteKindId
            , Object_RouteKind.ValueData  AS RouteKindName
 
            , MovementItem.isErased     AS isErased
            
        FROM (SELECT FALSE AS isErased UNION ALL SELECT inIsErased AS isErased WHERE inIsErased = TRUE) AS tmpIsErased
             JOIN MovementItem ON MovementItem.MovementId = inMovementId
                              AND MovementItem.DescId     = zc_MI_Master()
                              AND MovementItem.isErased   = tmpIsErased.isErased
             LEFT JOIN Object AS Object_Route ON Object_Route.Id = MovementItem.ObjectId
             
             LEFT JOIN MovementItemFloat AS MIFloat_DistanceFuelChild
                                         ON MIFloat_DistanceFuelChild.MovementItemId = MovementItem.Id
                                        AND MIFloat_DistanceFuelChild.DescId = zc_MIFloat_DistanceFuelChild()

             LEFT JOIN MovementItemFloat AS MIFloat_Weight
                                         ON MIFloat_Weight.MovementItemId = MovementItem.Id
                                        AND MIFloat_Weight.DescId = zc_MIFloat_Weight()
             LEFT JOIN MovementItemFloat AS MIFloat_StartOdometre
                                         ON MIFloat_StartOdometre.MovementItemId = MovementItem.Id
                                        AND MIFloat_StartOdometre.DescId = zc_MIFloat_StartOdometre()
             LEFT JOIN MovementItemFloat AS MIFloat_EndOdometre
                                         ON MIFloat_EndOdometre.MovementItemId = MovementItem.Id
                                        AND MIFloat_EndOdometre.DescId = zc_MIFloat_EndOdometre()
             
             LEFT JOIN MovementItemLinkObject AS MILinkObject_Freight
                                              ON MILinkObject_Freight.MovementItemId = MovementItem.Id 
                                             AND MILinkObject_Freight.DescId = zc_MILinkObject_Freight()
             LEFT JOIN Object AS Object_Freight ON Object_Freight.Id = MILinkObject_Freight.ObjectId

             LEFT JOIN MovementItemLinkObject AS MILinkObject_RouteKind
                                              ON MILinkObject_RouteKind.MovementItemId = MovementItem.Id 
                                             AND MILinkObject_RouteKind.DescId = zc_MILinkObject_RouteKind()
             LEFT JOIN Object AS Object_RouteKind ON Object_RouteKind.Id = MILinkObject_RouteKind.ObjectId
      ;
    
    RETURN NEXT Cursor1;

--    IF inShowAll THEN

    OPEN Cursor2 FOR 
        SELECT 
              0 AS Id
            , CASE WHEN ObjectLink_Car_FuelAll.DescId = zc_ObjectLink_Car_FuelMaster()
                        THEN 1
                   ELSE 2
              END AS Number
            , Object_Fuel.Id            AS FuelId
            , Object_Fuel.ObjectCode    AS FuelCode
            , Object_Fuel.ValueData     AS FuelName

            , MovementItem_Master.Id     AS ParentId
            , 0                          AS Amount
              -- ����������� �����
            , CASE WHEN ObjectLink_Car_FuelAll.DescId = zc_ObjectLink_Car_FuelMaster()
                             -- ���� "��������" ��� �������
                        THEN zfCalc_RateFuelValue (inDistance           := MovementItem_Master.Amount
                                                 , inAmountFuel         := tmpRateFuel.AmountFuel * COALESCE (ObjectFloat_Fuel_Ratio.ValueData, 1) -- !!!� ������ ������������ �������� �����!!!
                                                 , inColdHour           := 0
                                                 , inAmountColdHour     := tmpRateFuel.AmountColdHour * COALESCE (ObjectFloat_Fuel_Ratio.ValueData, 1) -- !!!� ������ ������������ �������� �����!!!
                                                 , inColdDistance       := 0
                                                 , inAmountColdDistance := tmpRateFuel.AmountColdDistance * COALESCE (ObjectFloat_Fuel_Ratio.ValueData, 1) -- !!!� ������ ������������ �������� �����!!!
                                                 , inRateFuelKindTax    := ObjectFloat_RateFuelKind_Tax.ValueData
                                                  )
                   WHEN ObjectLink_Car_FuelAll.DescId = zc_ObjectLink_Car_FuelChild()
                             -- ���� "��������������" ��� �������
                        THEN zfCalc_RateFuelValue (inDistance           := MIFloat_DistanceFuelChild.ValueData
                                                 , inAmountFuel         := tmpRateFuel.AmountFuel * COALESCE (ObjectFloat_Fuel_Ratio.ValueData, 1) -- !!!� ������ ������������ �������� �����!!!
                                                 , inColdHour           := 0
                                                 , inAmountColdHour     := tmpRateFuel.AmountColdHour * COALESCE (ObjectFloat_Fuel_Ratio.ValueData, 1) -- !!!� ������ ������������ �������� �����!!!
                                                 , inColdDistance       := 0
                                                 , inAmountColdDistance := tmpRateFuel.AmountColdDistance * COALESCE (ObjectFloat_Fuel_Ratio.ValueData, 1) -- !!!� ������ ������������ �������� �����!!!
                                                 , inRateFuelKindTax    := ObjectFloat_RateFuelKind_Tax.ValueData
                                                  )
                   ELSE 0
              END AS Amount_calc


              -- ������������ �������� �����
            , ObjectFloat_Fuel_Ratio.ValueData AS RatioFuel

              -- ���� ����� ���, ����� ������� �� ��������� ������� FALSE
            , CASE WHEN (tmpRateFuel.AmountFuel = 0) AND (tmpRateFuel.AmountColdHour = 0) AND (tmpRateFuel.AmountColdDistance = 0) THEN FALSE ELSE TRUE END AS isCalculated
            , CASE WHEN ObjectLink_Car_FuelAll.DescId = zc_ObjectLink_Car_FuelMaster() THEN TRUE ELSE FALSE END AS isMasterFuel
            , 0 AS ColdHour
            , 0 AS ColdDistance
            , tmpRateFuel.AmountColdHour     * COALESCE (ObjectFloat_Fuel_Ratio.ValueData, 1) AS AmountColdHour      -- !!!� ������ ������������ �������� �����!!!
            , tmpRateFuel.AmountColdDistance * COALESCE (ObjectFloat_Fuel_Ratio.ValueData, 1) AS AmountColdDistance  -- !!!� ������ ������������ �������� �����!!!
            , tmpRateFuel.AmountFuel         * COALESCE (ObjectFloat_Fuel_Ratio.ValueData, 1) AS AmountFuel          -- !!!� ������ ������������ �������� �����!!!
            , COALESCE (ObjectFloat_RateFuelKind_Tax.ValueData, 0) AS RateFuelKindTax
            
            , Object_RateFuelKind.Id         AS RateFuelKindId
            , Object_RateFuelKind.ValueData  AS RateFuelKindName

            , FALSE isErased
            
        FROM (SELECT zc_ObjectLink_Car_FuelMaster() AS DescId UNION ALL SELECT zc_ObjectLink_Car_FuelChild() AS DescId) AS tmpDesc
             -- ������� ���������� (�� ����)
             JOIN MovementLinkObject AS MovementLinkObject_Car
                                     ON MovementLinkObject_Car.MovementId = inMovementId
                                    AND MovementLinkObject_Car.DescId = zc_MovementLinkObject_Car()
             -- ������� � ���������� - ��� ���� �������
             JOIN ObjectLink AS ObjectLink_Car_FuelAll ON ObjectLink_Car_FuelAll.ObjectId = MovementLinkObject_Car.ObjectId
                                                      AND ObjectLink_Car_FuelAll.DescId = tmpDesc.DescId
                                                      AND ObjectLink_Car_FuelAll.ChildObjectId IS NOT NULL
             LEFT JOIN Object AS Object_Fuel ON Object_Fuel.Id = ObjectLink_Car_FuelAll.ChildObjectId

             -- ������� � ���� ������� - ����������� �������� ����� 
             LEFT JOIN ObjectFloat AS ObjectFloat_Fuel_Ratio ON ObjectFloat_Fuel_Ratio.ObjectId = ObjectLink_Car_FuelAll.ChildObjectId
                                                            AND ObjectFloat_Fuel_Ratio.DescId = zc_ObjectFloat_Fuel_Ratio()
                                                            AND ObjectFloat_Fuel_Ratio.ValueData <> 0

             -- ������� � ���� ������� - ��� ���� ��� �������
             LEFT JOIN ObjectLink AS ObjectLink_Fuel_RateFuelKind ON ObjectLink_Fuel_RateFuelKind.ObjectId = ObjectLink_Car_FuelAll.ChildObjectId
                                                                 AND ObjectLink_Fuel_RateFuelKind.DescId = zc_ObjectLink_Fuel_RateFuelKind()
             LEFT JOIN Object AS Object_RateFuelKind ON Object_RateFuelKind.Id = ObjectLink_Fuel_RateFuelKind.ChildObjectId
             -- ������� � ����� ��� ������� - % ��������������� ������� � ����� � �������/������������
             LEFT JOIN ObjectFloat AS ObjectFloat_RateFuelKind_Tax ON ObjectFloat_RateFuelKind_Tax.ObjectId = ObjectLink_Fuel_RateFuelKind.ChildObjectId
                                                                  AND ObjectFloat_RateFuelKind_Tax.DescId = zc_ObjectFloat_RateFuelKind_Tax()
             -- ������� ��� �������� (����� ������, �� (�������� ��� �������))
             LEFT JOIN MovementItem AS MovementItem_Master ON MovementItem_Master.MovementId = inMovementId
                                                          AND MovementItem_Master.DescId = zc_MI_Master()
             -- ������� � �������� �������� - ������, �� (�������������� ��� �������)
             LEFT JOIN MovementItemFloat AS MIFloat_DistanceFuelChild
                                         ON MIFloat_DistanceFuelChild.MovementItemId = MovementItem_Master.Id
                                        AND MIFloat_DistanceFuelChild.DescId = zc_MIFloat_DistanceFuelChild()
             -- ���� ����� ��� � ��������� ��� ��������� ��� ������� (���� ������/�� ������)
             LEFT JOIN MovementItem AS MovementItem_Find ON MovementItem_Find.MovementId = inMovementId
                                                        AND MovementItem_Find.ParentId   = MovementItem_Master.Id
                                                        AND MovementItem_Find.ObjectId   = ObjectLink_Car_FuelAll.ChildObjectId
                                                        AND MovementItem_Find.DescId     = zc_MI_Child()
                                                        -- AND MovementItem_Find.isErased = FALSE

             -- ������� � �������� - ��� ��������
             LEFT JOIN MovementItemLinkObject AS MILinkObject_RouteKind
                                              ON MILinkObject_RouteKind.MovementItemId = MovementItem_Master.Id 
                                             AND MILinkObject_RouteKind.DescId = zc_MILinkObject_RouteKind()

             -- ������� ����� ��� ���������� + ��� ��������
             LEFT JOIN (SELECT ObjectLink_RateFuel_Car.ChildObjectId       AS CarId
                             , ObjectLink_RateFuel_RouteKind.ChildObjectId AS RouteKindId
                             , ObjectFloat_Amount.ValueData                AS AmountFuel
                             , ObjectFloat_AmountColdHour.ValueData        AS AmountColdHour
                             , ObjectFloat_AmountColdDistance.ValueData    AS AmountColdDistance
                        FROM ObjectLink AS ObjectLink_RateFuel_Car
                             LEFT JOIN ObjectLink AS ObjectLink_RateFuel_RouteKind
                                                  ON ObjectLink_RateFuel_RouteKind.ObjectId = ObjectLink_RateFuel_Car.ObjectId
                                                 AND ObjectLink_RateFuel_RouteKind.DescId = zc_ObjectLink_RateFuel_RouteKind()
                             LEFT JOIN ObjectFloat AS ObjectFloat_Amount
                                                   ON ObjectFloat_Amount.ObjectId = ObjectLink_RateFuel_Car.ObjectId
                                                  AND ObjectFloat_Amount.DescId = zc_ObjectFloat_RateFuel_Amount()
                             LEFT JOIN ObjectFloat AS ObjectFloat_AmountColdHour
                                                   ON ObjectFloat_AmountColdHour.ObjectId = ObjectLink_RateFuel_Car.ObjectId
                                                  AND ObjectFloat_AmountColdHour.DescId = zc_ObjectFloat_RateFuel_AmountColdHour()
                             LEFT JOIN ObjectFloat AS ObjectFloat_AmountColdDistance
                                                   ON ObjectFloat_AmountColdDistance.ObjectId = ObjectLink_RateFuel_Car.ObjectId
                                                  AND ObjectFloat_AmountColdDistance.DescId = zc_ObjectFloat_RateFuel_AmountColdDistance()
                        WHERE ObjectLink_RateFuel_Car.DescId = zc_ObjectLink_RateFuel_Car()
                       ) AS tmpRateFuel ON tmpRateFuel.CarId       = MovementLinkObject_Car.ObjectId
                                       AND tmpRateFuel.RouteKindId = MILinkObject_RouteKind.ObjectId

        WHERE MovementItem_Find.ObjectId IS NULL
      UNION ALL
        SELECT 
              MovementItem.Id
            , COALESCE (MIFloat_Number.ValueData, 0) AS Number
            , MovementItem.ObjectId     AS FuelId
            , Object_Fuel.ObjectCode    AS FuelCode
            , Object_Fuel.ValueData     AS FuelName

            , MovementItem.ParentId      AS ParentId
            , MovementItem.Amount        AS Amount
              -- ����������� �����
            , CASE WHEN COALESCE (MIBoolean_MasterFuel.ValueData, FALSE) = TRUE
                             -- ���� "��������" ��� �������
                        THEN zfCalc_RateFuelValue (inDistance           := MovementItem_Master.Amount
                                                 , inAmountFuel         := MIFloat_AmountFuel.ValueData -- !!!����������� �������� ����� ��� �����!!!
                                                 , inColdHour           := MIFloat_ColdHour.ValueData
                                                 , inAmountColdHour     := MIFloat_AmountColdHour.ValueData -- !!!����������� �������� ����� ��� �����!!!
                                                 , inColdDistance       := MIFloat_ColdDistance.ValueData
                                                 , inAmountColdDistance := MIFloat_AmountColdDistance.ValueData -- !!!����������� �������� ����� ��� �����!!!
                                                 , inRateFuelKindTax    := MIFloat_RateFuelKindTax.ValueData
                                                  )
                    WHEN COALESCE (MIBoolean_MasterFuel.ValueData, FALSE) = FALSE
                             -- ���� "��������������" ��� �������
                        THEN zfCalc_RateFuelValue (inDistance           := MIFloat_DistanceFuelChild.ValueData
                                                 , inAmountFuel         := MIFloat_AmountFuel.ValueData -- !!!����������� �������� ����� ��� �����!!!
                                                 , inColdHour           := MIFloat_ColdHour.ValueData
                                                 , inAmountColdHour     := MIFloat_AmountColdHour.ValueData -- !!!����������� �������� ����� ��� �����!!!
                                                 , inColdDistance       := MIFloat_ColdDistance.ValueData
                                                 , inAmountColdDistance := MIFloat_AmountColdDistance.ValueData -- !!!����������� �������� ����� ��� �����!!!
                                                 , inRateFuelKindTax    := MIFloat_RateFuelKindTax.ValueData
                                                  )
                   ELSE 0
              END AS Amount_calc
 
              -- ������������ �������� �����
            , ObjectFloat_Fuel_Ratio.ValueData AS RatioFuel

            , COALESCE (MIBoolean_Calculated.ValueData, TRUE)  AS isCalculated
            , COALESCE (MIBoolean_MasterFuel.ValueData, FALSE) AS isMasterFuel

            , MIFloat_ColdHour.ValueData            AS ColdHour
            , MIFloat_ColdDistance.ValueData        AS ColdDistance
            , MIFloat_AmountColdHour.ValueData      AS AmountColdHour     -- !!!����������� �������� ����� ��� �����!!!
            , MIFloat_AmountColdDistance.ValueData  AS AmountColdDistance -- !!!����������� �������� ����� ��� �����!!!
            , MIFloat_AmountFuel.ValueData          AS AmountFuel         -- !!!����������� �������� ����� ��� �����!!!
            , MIFloat_RateFuelKindTax.ValueData     AS RateFuelKindTax
            
            , Object_RateFuelKind.Id         AS RateFuelKindId
            , Object_RateFuelKind.ValueData  AS RateFuelKindName

            , MovementItem.isErased
            
        FROM (SELECT FALSE AS isErased UNION ALL SELECT TRUE AS isErased) AS tmpIsErased -- !!!���������� ���!!!
             JOIN MovementItem ON MovementItem.MovementId = inMovementId
                              AND MovementItem.DescId     = zc_MI_Child()
                              AND MovementItem.isErased   = tmpIsErased.isErased
             LEFT JOIN Object AS Object_Fuel ON Object_Fuel.Id = MovementItem.ObjectId

             -- ������� ���������� (�� ����)
             LEFT JOIN MovementLinkObject AS MovementLinkObject_Car
                                          ON MovementLinkObject_Car.MovementId = inMovementId
                                         AND MovementLinkObject_Car.DescId = zc_MovementLinkObject_Car()

             -- ������� � ���������� - ��� �������
             LEFT JOIN ObjectLink AS ObjectLink_Car_FuelAll ON ObjectLink_Car_FuelAll.ObjectId = MovementLinkObject_Car.ObjectId
                                                           AND ObjectLink_Car_FuelAll.ChildObjectId = MovementItem.ObjectId
                                                           AND ObjectLink_Car_FuelAll.DescId IN (zc_ObjectLink_Car_FuelMaster(), zc_ObjectLink_Car_FuelChild())

             LEFT JOIN MovementItemBoolean AS MIBoolean_Calculated
                                           ON MIBoolean_Calculated.MovementItemId = MovementItem.Id
                                          AND MIBoolean_Calculated.DescId = zc_MIBoolean_Calculated()
             LEFT JOIN MovementItemBoolean AS MIBoolean_MasterFuel
                                           ON MIBoolean_MasterFuel.MovementItemId = MovementItem.Id
                                          AND MIBoolean_MasterFuel.DescId = zc_MIBoolean_MasterFuel()

             LEFT JOIN MovementItemFloat AS MIFloat_ColdHour
                                         ON MIFloat_ColdHour.MovementItemId = MovementItem.Id
                                        AND MIFloat_ColdHour.DescId = zc_MIFloat_ColdHour()
             LEFT JOIN MovementItemFloat AS MIFloat_ColdDistance
                                         ON MIFloat_ColdDistance.MovementItemId = MovementItem.Id
                                        AND MIFloat_ColdDistance.DescId = zc_MIFloat_ColdDistance()

             LEFT JOIN MovementItemFloat AS MIFloat_AmountColdHour
                                         ON MIFloat_AmountColdHour.MovementItemId = MovementItem.Id
                                        AND MIFloat_AmountColdHour.DescId = zc_MIFloat_AmountColdHour()
                                        AND ObjectLink_Car_FuelAll.ChildObjectId IS NOT NULL
             LEFT JOIN MovementItemFloat AS MIFloat_AmountColdDistance
                                         ON MIFloat_AmountColdDistance.MovementItemId = MovementItem.Id
                                        AND MIFloat_AmountColdDistance.DescId = zc_MIFloat_AmountColdDistance()
                                        AND ObjectLink_Car_FuelAll.ChildObjectId IS NOT NULL
             LEFT JOIN MovementItemFloat AS MIFloat_AmountFuel
                                         ON MIFloat_AmountFuel.MovementItemId = MovementItem.Id
                                        AND MIFloat_AmountFuel.DescId = zc_MIFloat_AmountFuel()
                                        AND ObjectLink_Car_FuelAll.ChildObjectId IS NOT NULL
             LEFT JOIN MovementItemFloat AS MIFloat_RateFuelKindTax
                                         ON MIFloat_RateFuelKindTax.MovementItemId = MovementItem.Id
                                        AND MIFloat_RateFuelKindTax.DescId = zc_MIFloat_RateFuelKindTax()

             LEFT JOIN MovementItemFloat AS MIFloat_Number
                                         ON MIFloat_Number.MovementItemId = MovementItem.Id
                                        AND MIFloat_Number.DescId = zc_MIFloat_Number()

             LEFT JOIN MovementItemLinkObject AS MILinkObject_RateFuelKind
                                              ON MILinkObject_RateFuelKind.MovementItemId = MovementItem.Id
                                             AND MILinkObject_RateFuelKind.DescId = zc_MILinkObject_RateFuelKind()
             LEFT JOIN Object AS Object_RateFuelKind ON Object_RateFuelKind.Id = MILinkObject_RateFuelKind.ObjectId

             LEFT JOIN MovementItem AS MovementItem_Master ON MovementItem_Master.Id = MovementItem.ParentId
             -- ������� � �������� �������� - ������, �� (�������������� ��� �������)
             LEFT JOIN MovementItemFloat AS MIFloat_DistanceFuelChild
                                         ON MIFloat_DistanceFuelChild.MovementItemId = MovementItem_Master.Id
                                        AND MIFloat_DistanceFuelChild.DescId = zc_MIFloat_DistanceFuelChild()
             -- ������� � ���� ������� - ����������� �������� ����� 
             LEFT JOIN ObjectFloat AS ObjectFloat_Fuel_Ratio ON ObjectFloat_Fuel_Ratio.ObjectId = MovementItem.ObjectId
                                                            AND ObjectFloat_Fuel_Ratio.DescId = zc_ObjectFloat_Fuel_Ratio()
                                                            AND ObjectFloat_Fuel_Ratio.ValueData <> 0
      ;
       
    RETURN NEXT Cursor2;

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION gpSelect_MI_Transport (Integer, Boolean, Boolean, TVarChar) OWNER TO postgres;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 13.10.13                                        * add ObjectLink_Car_FuelAll.ChildObjectId IS NOT NULL
 12.10.13                                        * add zc_ObjectFloat_Fuel_Ratio
 07.10.13                                        * add DistanceFuelChild and isMasterFuel
 04.10.13                                        * inIsErased
 01.10.13                                        * add zc_MIFloat_RateFuelKindTax and zfCalc_RateFuelValue
 29.09.13                                        *
 25.09.13         * add Cursor...; rename  TransportFuelOut- Transport             
*/

-- ����
-- SELECT * FROM gpSelect_MI_Transport (inMovementId:= 25173, inShowAll:= TRUE, inIsErased:= TRUE, inSession:= '2')
-- SELECT * FROM gpSelect_MI_Transport (inMovementId:= 25173, inShowAll:= FALSE, inIsErased:= FALSE, inSession:= '2')
