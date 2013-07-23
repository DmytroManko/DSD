-- Function: gpSelect_Object_Car()

--DROP FUNCTION gpSelect_Object_Car();

CREATE OR REPLACE FUNCTION gpSelect_Object_Car(
    IN inSession     TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer, Code Integer, Name TVarChar 
              ,CarModelId Integer, CarModelName TVarChar, RegistrationCertificate TVarChar
              ,isErased boolean) AS
$BODY$BEGIN
   -- �������� ���� ������������ �� ����� ���������
   --PERFORM lpCheckRight(inSession, zc_Enum_Process_Select_Object_Car());

     RETURN QUERY 
       SELECT 
             Object.Id          AS Id
           , Object.ObjectCode  AS Code
           , Object.ValueData   AS Name
           
           , CarModel.Id        AS CarModelId
           , CarModel.ValueData AS CarModelName
           , RegistrationCertificate.ValueData      AS RegistrationCertificate
           
           , Object.isErased    AS isErased
       FROM Object
            LEFT JOIN ObjectLink AS Car_CarModel
                   ON Car_CarModel.ObjectId = Object.Id AND Car_CarModel.DescId = zc_ObjectLink_Car_CarModel()
            LEFT JOIN Object AS CarModel
                   ON CarModel.Id = Car_CarModel.ChildObjectId
            LEFT JOIN ObjectString AS RegistrationCertificate 
                   ON RegistrationCertificate.ObjectId = Object.Id AND RegistrationCertificate.DescId = zc_ObjectString_Car_RegistrationCertificate()
     WHERE Object.DescId = zc_Object_Car();
  
END;
$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpSelect_Object_Car(TVarChar) OWNER TO postgres;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 10.06.13          * 
 03.06.13          

*/

-- ����
-- SELECT * FROM gpSelect_Object_Car('2')