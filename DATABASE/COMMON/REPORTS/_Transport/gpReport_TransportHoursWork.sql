 -- Function: gpReport_TransportHoursWork()

-- DROP FUNCTION IF EXISTS gpReport_MovementTransport (TDateTime, TDateTime, Integer, TVarChar);
DROP FUNCTION IF EXISTS gpReport_TransportHoursWork (TDateTime, TDateTime, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpReport_TransportHoursWork(
    IN inStartDate    TDateTime , -- 
    IN inEndDate      TDateTime , --
    IN inPersonalId   Integer,    -- ��������
    
    IN inSession     TVarChar    -- ������ ������������
)
RETURNS TABLE (PersonalDriverName TVarChar
             , RouteName TVarChar
             , RouteKindName TVarChar
             , RouteKindFreightName TVarChar
             , Weight TFloat, HoursWork TFloat, HoursAdd TFloat
             , InvNumber Integer, OperDate TDateTime
              )
AS
$BODY$BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Report_Transport());
     
      RETURN QUERY 
         WITH tmpPersonal AS  (SELECT PersonalId FROM Object_Personal_View WHERE COALESCE (inPersonalId, 0) = 0 UNION SELECT COALESCE (inPersonalId, 0) AS PersonalId
                              )
            , tmpMovement AS (SELECT Movement.Id, Movement.OperDate, Movement.InvNumber FROM Movement WHERE Movement.DescId = zc_Movement_Transport() AND Movement.OperDate BETWEEN inStartDate AND inEndDate AND Movement.StatusId = zc_Enum_Status_Complete()
                              )

        SELECT 
	          View_PersonalDriver.PersonalName AS PersonalDriverName

            , Object_Route.ValueData  AS RouteName

            , Object_RouteKind.ValueData  AS RouteKindName

            , Object_RouteKindFreight.ValueData AS RouteKindFreightName

            , CAST (tmpMI.Weight AS TFloat) AS Weight
            
            , CAST (COALESCE (MovementFloat_HoursWork.ValueData, 0) + COALESCE (MovementFloat_HoursAdd.ValueData, 0) AS TFloat) AS HoursWork
            , MovementFloat_HoursAdd.ValueData      AS HoursAdd

           , zfConvert_StringToNumber (tmpMovement.InvNumber) AS InvNumber
           , tmpMovement.OperDate

        FROM tmpMovement
             LEFT JOIN (SELECT MIN(MovementItem.Id) AS MovementItemId
                             , SUM(MIFloat_Weight.ValueData) AS Weight
                             , MovementItem.MovementId
                        FROM tmpMovement
                             JOIN MovementItem ON MovementItem.MovementId = tmpMovement.Id
                                              AND MovementItem.DescId = zc_MI_Master()
                                              AND MovementItem.isErased = FALSE
                            LEFT JOIN MovementItemFloat AS MIFloat_Weight ON MIFloat_Weight.MovementItemId = MovementItem.Id
                                                                         AND MIFloat_Weight.DescId = zc_MIFloat_Weight()
                        GROUP BY MovementItem.MovementId
                        ) AS tmpMI ON tmpMI.MovementId = tmpMovement.Id 

              LEFT JOIN MovementItem AS MI ON MI.Id = tmpMI.MovementItemId
              LEFT JOIN Object AS Object_Route ON Object_Route.Id = MI.ObjectId      
                  
              LEFT JOIN MovementItemLinkObject AS MILinkObject_RouteKind ON MILinkObject_RouteKind.MovementItemId = tmpMI.MovementItemId
                                                                        AND MILinkObject_RouteKind.DescId = zc_MILinkObject_RouteKind()
              LEFT JOIN Object AS Object_RouteKind ON Object_RouteKind.Id = MILinkObject_RouteKind.ObjectId

              LEFT JOIN MovementItemLinkObject AS MILinkObject_RouteKindFreight ON MILinkObject_RouteKindFreight.MovementItemId = tmpMI.MovementItemId
                                                                               AND MILinkObject_RouteKindFreight.DescId = zc_MILinkObject_RouteKindFreight()
              LEFT JOIN Object AS Object_RouteKindFreight ON Object_RouteKindFreight.Id = MILinkObject_RouteKindFreight.ObjectId
              
              LEFT JOIN MovementLinkObject AS MovementLinkObject_PersonalDriver ON MovementLinkObject_PersonalDriver.MovementId = tmpMovement.Id
                                                                               AND MovementLinkObject_PersonalDriver.DescId = zc_MovementLinkObject_PersonalDriver()
              JOIN tmpPersonal ON tmpPersonal.PersonalId = MovementLinkObject_PersonalDriver.ObjectId

              LEFT JOIN Object_Personal_View AS View_PersonalDriver ON View_PersonalDriver.PersonalId = MovementLinkObject_PersonalDriver.ObjectId
              
              LEFT JOIN MovementFloat AS MovementFloat_HoursWork ON MovementFloat_HoursWork.MovementId =  tmpMovement.Id
                                                                AND MovementFloat_HoursWork.DescId = zc_MovementFloat_HoursWork()

              LEFT JOIN MovementFloat AS MovementFloat_HoursAdd ON MovementFloat_HoursAdd.MovementId =  tmpMovement.Id
                                                               AND MovementFloat_HoursAdd.DescId = zc_MovementFloat_HoursAdd()
;

END;
$BODY$

LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION gpReport_TransportHoursWork (TDateTime, TDateTime, Integer, TVarChar) OWNER TO postgres;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 27.10.13         *
*/

-- ����
-- SELECT * FROM gpReport_TransportHoursWork (inStartDate:= '01.01.2013', inEndDate:= '01.11.2013', inPersonalId:= 0, inSession:= '2') 