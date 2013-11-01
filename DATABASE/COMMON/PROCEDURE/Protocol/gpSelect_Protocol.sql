-- Function: gpSelect_Protocol()

DROP FUNCTION IF EXISTS gpSelect_Protocol (TDateTime, TDateTime, Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Protocol(
    IN inStartDate     TDateTime , -- 
    IN inEndDate       TDateTime , --
    IN inUserId        Integer,    -- ������������  
    IN inObjectDescId  Integer,    -- ��� �������
    IN inSession       TVarChar    -- ������ ������������
)
RETURNS TABLE (OperDate TDateTime, ProtocolData, UserName)
AS
$BODY$
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Report_Fuel());

  RETURN QUERY 
  SELECT 
     OperDate,
     ProtocolData,
     Object_User.ValueData AS UserName
  FROM ObjectProtocol 
  JOIN Object AS Object_User ON Object_User.UserId = ObjectProtocol.UserId
 WHERE OperDate BETWEEN inStartDate AND inEndDate;

--inUserId        Integer,    -- ������������  
  --  IN inObjectDescId  Integer,    -- ��� �������

END;
$BODY$

LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION gpSelect_Protocol (TDateTime, TDateTime, Integer, Integer, TVarChar) OWNER TO postgres;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 01.11.13                        * 
*/

-- ����
-- SELECT * FROM gpReport_Fuel (inStartDate:= '01.01.2013', inEndDate:= '01.02.2013', inFuelId:= null, inCarId:= null, inSession:= '2'); 
                                                                
