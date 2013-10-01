-- Function: gpGet_Movement_SheetWorkTime()

-- DROP FUNCTION gpGet_Movement_SheetWorkTime (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpGet_Movement_SheetWorkTime(
    IN inMovementId        Integer  , -- ���� ���������
    IN inSession           TVarChar   -- ������ ������������
)
RETURNS TABLE (Id Integer, InvNumber TVarChar, OperDate TDateTime
             , StatusCode Integer, StatusName TVarChar
             , UnitId Integer, UnitName TVarChar
             )
AS
$BODY$
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Get_Movement_SheetWorkTime());

     RETURN QUERY 
       SELECT
             Movement.Id
           , Movement.InvNumber
           , Movement.OperDate
           
           , Object_Status.ObjectCode    AS StatusCode
           , Object_Status.ValueData     AS StatusName

           , Object_Unit.Id                    AS UnitId
           , Object_Unit.ValueData             AS UnitName

       From Movement
            LEFT JOIN Object AS Object_Status ON Object_Status.Id = Movement.StatusId

            LEFT JOIN MovementLinkObject AS MovementLinkObject_Unit
                                         ON MovementLinkObject_Unit.MovementId = Movement.Id
                                        AND MovementLinkObject_Unit.DescId = zc_MovementLinkObject_Unit()
            LEFT JOIN Object AS Object_Unit ON Object_Unit.Id = MovementLinkObject_Unit.ObjectId
           
       WHERE Movement.Id =  inMovementId
         AND Movement.DescId = zc_Movement_SheetWorkTime();
  
END;
$BODY$
LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION gpGet_Movement_SheetWorkTime (Integer, TVarChar) OWNER TO postgres;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 01.10.13         *

*/

-- ����
-- SELECT * from gpGet_Movement_SheetWorkTime (inMovementId:= 1, inSession:= '2')
