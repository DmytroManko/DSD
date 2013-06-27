-- Function: gpInsertUpdate_Object_Car()

-- DROP FUNCTION gpInsertUpdate_Object_Car();

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_Car(
 INOUT ioId                       Integer   ,    -- ���� ������� <����������> 
    IN inCode                     Integer   ,    -- ��� ������� <����������>
    IN inName                     TVarChar  ,    -- �������� ������� <����������>
    IN inRegistrationCertificate  TVarChar  ,    -- ���������� ������� <����������>
    IN inCarModelId               Integer   ,    -- ������ ����          
    IN inSession                  TVarChar       -- ������ ������������
)
  RETURNS integer AS
$BODY$
   DECLARE UserId Integer;
   DECLARE Code_max Integer;   

BEGIN
   
   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight(inSession, zc_Enum_Process_Car());
   UserId := inSession;

   -- ���� ��� �� ����������, ���������� ��� ��� ���������+1
   IF COALESCE (inCode, 0) = 0
   THEN 
       SELECT MAX (ObjectCode) + 1 INTO Code_max FROM Object WHERE Object.DescId = zc_Object_Car();
   ELSE
       Code_max := inCode;
   END IF; 
   
   -- �������� ���� ������������ ��� �������� <������������ ����������>
   PERFORM lpCheckUnique_Object_ValueData(ioId, zc_Object_Car(), inName);
   -- �������� ���� ������������ ��� �������� <��� ����������>
   PERFORM lpCheckUnique_Object_ObjectCode (ioId, zc_Object_Car(), Code_max);
   -- �������� ���� ������������ ��� �������� <����������> 
   PERFORM lpCheckUnique_ObjectString_ValueData(ioId, zc_ObjectString_Car_RegistrationCertificate(), inRegistrationCertificate);

   -- ��������� <������>
   ioId := lpInsertUpdate_Object(ioId, zc_Object_Car(), Code_max, inName);

   PERFORM lpInsertUpdate_ObjectString(zc_ObjectString_Car_RegistrationCertificate(), ioId, inRegistrationCertificate);
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Car_CarModel(), ioId, inCarModelId);

   -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (ioId, UserId);

END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION gpInsertUpdate_Object_Car(Integer, Integer, TVarChar, TVarChar, Integer, TVarChar)
  OWNER TO postgres;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 10.06.13          *
 05.06.13          

*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_Car()
                            