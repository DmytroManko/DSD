-- Function: gpGet_Movement_IncomeFuel (Integer, TVarChar)

DROP FUNCTION IF EXISTS gpGet_Movement_IncomeFuel (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpGet_Movement_IncomeFuel(
    IN inMovementId        Integer  , -- ���� ���������
    IN inSession           TVarChar   -- ������ ������������
)
RETURNS TABLE (Id Integer, InvNumber TVarChar, OperDate TDateTime, StatusCode Integer, StatusName TVarChar
             , OperDatePartner TDateTime, InvNumberPartner TVarChar
             , PriceWithVAT Boolean, VATPercent TFloat, ChangePrice TFloat
             , FromId Integer, FromName TVarChar, ToId Integer, ToName TVarChar, ToParentId Integer
             , PaidKindId Integer, PaidKindName TVarChar, ContractId Integer, ContractName TVarChar
             , RouteId Integer, RouteName TVarChar
             , PersonalDriverId Integer, PersonalDriverName TVarChar
              )
AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     vbUserId := lpCheckRight (inSession, zc_Enum_Process_Get_Movement_IncomeFuel());


     IF COALESCE (inMovementId, 0) = 0
     THEN
         RETURN QUERY 
         SELECT
               0 AS Id
             , CAST (NEXTVAL ('Movement_Income_seq') AS TVarChar) AS InvNumber
             , CAST (CURRENT_DATE AS TDateTime) AS OperDate
             , Object_Status.Code               AS StatusCode
             , Object_Status.Name               AS StatusName

             , CAST (CURRENT_DATE AS TDateTime) AS OperDatePartner
             , CAST ('' AS TVarChar) AS InvNumberPartner

             , CAST (TRUE AS Boolean) AS PriceWithVAT
             , CAST (20 AS TFloat)     AS VATPercent
             , CAST (0 AS TFloat)      AS ChangePrice

             , 0                     AS FromId
             , CAST ('' AS TVarChar) AS FromName
             , 0                     AS ToId
             , CAST ('' AS TVarChar) AS ToName
             , 0                     AS ToParentId
             , 0                     AS PaidKindId
             , CAST ('' AS TVarChar) AS PaidKindName
             , 0                     AS ContractId
             , CAST ('' AS TVarChar) AS ContractName
             , 0                     AS RouteId
             , CAST ('' AS TVarChar) AS RouteName
             , 0                     AS PersonalDriverId
             , CAST ('' AS TVarChar) AS PersonalDriverName
          FROM lfGet_Object_Status(zc_Enum_Status_UnComplete()) AS Object_Status;
     ELSE
       RETURN QUERY 
         SELECT
               Movement.Id
             , Movement.InvNumber
             , Movement.OperDate
             , Object_Status.ObjectCode          AS StatusCode
             , Object_Status.ValueData           AS StatusName

             , MovementDate_OperDatePartner.ValueData    AS OperDatePartner
             , MovementString_InvNumberPartner.ValueData AS InvNumberPartner

             , MovementBoolean_PriceWithVAT.ValueData      AS PriceWithVAT
             , MovementFloat_VATPercent.ValueData          AS VATPercent
             , MovementFloat_ChangePrice.ValueData         AS ChangePrice

             , Object_From.Id                    AS FromId
             , Object_From.ValueData             AS FromName
             , Object_To.Id                      AS ToId
             , Object_To.ValueData               AS ToName
             , 0                                 AS ToParentId
             , Object_PaidKind.Id                AS PaidKindId
             , Object_PaidKind.ValueData         AS PaidKindName
             , Object_Contract.Id                AS ContractId
             , Object_Contract.ValueData         AS ContractName
             , Object_Route.Id                   AS RouteId
             , Object_Route.ValueData            AS RouteName
             , View_PersonalDriver.PersonalId    AS PersonalDriverId
             , View_PersonalDriver.PersonalName  AS PersonalDriverName
       FROM Movement
            LEFT JOIN Object AS Object_Status ON Object_Status.Id = Movement.StatusId

            LEFT JOIN MovementDate AS MovementDate_OperDatePartner
                                   ON MovementDate_OperDatePartner.MovementId =  Movement.Id
                                  AND MovementDate_OperDatePartner.DescId = zc_MovementDate_OperDatePartner()
            LEFT JOIN MovementString AS MovementString_InvNumberPartner
                                     ON MovementString_InvNumberPartner.MovementId =  Movement.Id
                                    AND MovementString_InvNumberPartner.DescId = zc_MovementString_InvNumberPartner()

            LEFT JOIN MovementBoolean AS MovementBoolean_PriceWithVAT
                                      ON MovementBoolean_PriceWithVAT.MovementId =  Movement.Id
                                     AND MovementBoolean_PriceWithVAT.DescId = zc_MovementBoolean_PriceWithVAT()
            LEFT JOIN MovementFloat AS MovementFloat_VATPercent
                                    ON MovementFloat_VATPercent.MovementId =  Movement.Id
                                   AND MovementFloat_VATPercent.DescId = zc_MovementFloat_VATPercent()
            LEFT JOIN MovementFloat AS MovementFloat_ChangePrice
                                    ON MovementFloat_ChangePrice.MovementId =  Movement.Id
                                   AND MovementFloat_ChangePrice.DescId = zc_MovementFloat_ChangePrice()

            LEFT JOIN MovementLinkObject AS MovementLinkObject_From
                                         ON MovementLinkObject_From.MovementId = Movement.Id
                                        AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()
            LEFT JOIN Object AS Object_From ON Object_From.Id = MovementLinkObject_From.ObjectId
            LEFT JOIN MovementLinkObject AS MovementLinkObject_To
                                         ON MovementLinkObject_To.MovementId = Movement.Id
                                        AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
            LEFT JOIN Object AS Object_To ON Object_To.Id = MovementLinkObject_To.ObjectId

            LEFT JOIN MovementLinkObject AS MovementLinkObject_PaidKind
                                         ON MovementLinkObject_PaidKind.MovementId = Movement.Id
                                        AND MovementLinkObject_PaidKind.DescId = zc_MovementLinkObject_PaidKind()
            LEFT JOIN Object AS Object_PaidKind ON Object_PaidKind.Id = MovementLinkObject_PaidKind.ObjectId

            LEFT JOIN MovementLinkObject AS MovementLinkObject_Contract
                                         ON MovementLinkObject_Contract.MovementId = Movement.Id
                                        AND MovementLinkObject_Contract.DescId = zc_MovementLinkObject_Contract()
            LEFT JOIN Object AS Object_Contract ON Object_Contract.Id = MovementLinkObject_Contract.ObjectId

            LEFT JOIN MovementLinkObject AS MovementLinkObject_Route
                                         ON MovementLinkObject_Route.MovementId = Movement.Id
                                        AND MovementLinkObject_Route.DescId = zc_MovementLinkObject_Route()
            LEFT JOIN Object AS Object_Route ON Object_Route.Id = MovementLinkObject_Route.ObjectId

            LEFT JOIN MovementLinkObject AS MovementLinkObject_PersonalDriver
                                         ON MovementLinkObject_PersonalDriver.MovementId = Movement.Id
                                        AND MovementLinkObject_PersonalDriver.DescId = zc_MovementLinkObject_PersonalDriver()
            LEFT JOIN Object_Personal_View AS View_PersonalDriver ON View_PersonalDriver.PersonalId = MovementLinkObject_PersonalDriver.ObjectId

       WHERE Movement.Id =  inMovementId
         AND Movement.DescId = zc_Movement_Income();
     END IF;

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION gpGet_Movement_IncomeFuel (Integer, TVarChar) OWNER TO postgres;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 31.10.13                                        * add OperDatePartner
 23.10.13                                        * add NEXTVAL
 20.10.13                                        * CURRENT_TIMESTAMP -> CURRENT_DATE
 19.10.13                                        * add ChangePrice
 07.10.13                                        * add lpCheckRight
 05.10.13                                        * add InvNumberPartner
 04.10.13                                        * add Route
 30.09.13                                        * add Object_Personal_View
 29.09.13                                        * add lfGet_InvNumber
 27.09.13                                        *
*/

-- ����
-- SELECT * FROM gpGet_Movement_IncomeFuel (inMovementId := 0, inSession:= zfCalc_UserAdmin())
