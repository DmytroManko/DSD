-- Function: gpGet_Object_Contract()

-- DROP FUNCTION gpGet_Object_Contract (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpGet_Object_Contract(
    IN inId             Integer,       -- ���� ������� <�������>
    IN inSession        TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer, InvNumber TVarChar, Comment TVarChar
             , SigningDate TDateTime, StartDate TDateTime, EndDate TDateTime
             , isErased Boolean) AS
$BODY$
BEGIN

   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Contract());

   IF COALESCE (inId, 0) = 0
   THEN
       RETURN QUERY 
       SELECT
             CAST (0 as Integer)    AS Id
           , CAST ('' as TVarChar)  AS InvNumber
           , CAST ('' as TVarChar)  AS Comment
           , CAST ('' as TDateTime) AS SigningDate
           , CAST ('' as TDateTime) AS StartDate
           , CAST ('' as TDateTime) AS EndDate
           , CAST (NULL AS Boolean) AS isErased
       FROM Object 
       WHERE Object.DescId = zc_Object_Contract();
   ELSE
       RETURN QUERY
       SELECT
             Object_Contract.Id               AS Id
           , ObjectString_InvNumber.ValueData AS InvNumber
           , ObjectString_Comment.ValueData   AS Comment
           
           , ObjectDate_Signing.ValueData AS SigningDate
           , ObjectDate_Start.ValueData   AS StartDate
           , ObjectDate_End.ValueData     AS EndDate
           
           , Object_Contract.isErased         AS isErased
       FROM Object AS Object_Contract
           LEFT JOIN ObjectString AS ObjectString_InvNumber
                                  ON ObjectString_InvNumber.ObjectId = Object_Contract.Id
                                 AND ObjectString_InvNumber.DescId = zc_objectString_Contract_InvNumber()
       
           LEFT JOIN ObjectString AS ObjectString_Comment
                                  ON ObjectString_Comment.ObjectId = Object_Contract.Id
                                 AND ObjectString_Comment.DescId = zc_objectString_Contract_Comment()

           LEFT JOIN ObjectDate AS ObjectDate_Signing
                                ON ObjectDate_Signing.ObjectId = Object_Contract.Id
                               AND ObjectDate_Signing.DescId = zc_ObjectDate_Contract_Signing()
           LEFT JOIN ObjectDate AS ObjectDate_Start
                                ON ObjectDate_Start.ObjectId = Object_Contract.Id
                               AND ObjectDate_Start.DescId = zc_ObjectDate_Contract_Start()
           LEFT JOIN ObjectDate AS ObjectDate_End
                                ON ObjectDate_End.ObjectId = Object_Contract.Id
                               AND ObjectDate_End.DescId = zc_ObjectDate_Contract_End()                               

       WHERE Object_Contract.Id = inId;
   END IF;
     
END;
$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpGet_Object_Contract (Integer, TVarChar) OWNER TO postgres;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 22.07.13         * add  SigningDate, StartDate, EndDate 
 11.06.13         *
 12.04.13                                        *

*/

-- ����
-- SELECT * FROM gpGet_Object_Contract (2, '')
