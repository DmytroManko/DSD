-- Function: gpReport_Fuel()

DROP FUNCTION IF EXISTS gpReport_Fuel (TDateTime, TDateTime, Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpReport_Fuel(
    IN inStartDate     TDateTime , -- 
    IN inEndDate       TDateTime , --
    IN inFuelId        Integer,    -- �������  
    IN inCarId         Integer,    -- ������
     
    IN inSession     TVarChar    -- ������ ������������
)
RETURNS TABLE (CarId Integer, CarCode Integer, CarName TVarChar
             , FuelId Integer, FuelCode Integer, FuelName TVarChar

             , StartAmount TFloat, IncomeAmount TFloat, RateAmount TFloat, EndAmount TFloat
             , StartSumm TFloat, IncomeSumm TFloat, RateSumm TFloat, EndSumm TFloat
             )
AS
$BODY$BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Report_Fuel());

     -- ���� ������, ������� ������� ������� � ��������. 
     -- ������� ������ - ����� ����������

     -- ������� - 
RETURN QUERY 
       SELECT cast (1 as integer) as  CarId, cast (1 as integer) as CarCode, cast ('������' as TVarChar) as CarName
            , cast (1 as integer) as FuelId, cast (1 as integer) as FuelCode, cast('������' as TVarChar) as FuelName
            , cast (120 as Tfloat), cast (150 as Tfloat), cast (140 as Tfloat), cast (130 as Tfloat)
            , cast (400 as Tfloat), cast (500 as Tfloat), cast (450 as Tfloat), cast (480 as Tfloat) 
  ;   

END;
$BODY$

LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION gpReport_Fuel (TDateTime, TDateTime, Integer, Integer, TVarChar) OWNER TO postgres;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 11.11.13                        * 
 05.10.13         *
*/

-- ����
-- SELECT * FROM gpReport_Fuel (inStartDate:= '01.01.2013', inEndDate:= '01.02.2013', inFuelId:= null, inCarId:= null, inSession:= '2'); 