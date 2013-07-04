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
 RETURNS Integer AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbCode_calc Integer;   

BEGIN
   
   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Car());
   vbUserId := inSession;

   -- ���� ��� �� ����������, ���������� ��� ��� ���������+1
   vbCode_calc:=lfGet_ObjectCode (inCode, zc_Object_Car()); 
   
   -- �������� ���� ������������ ��� �������� <������������ ����������>
   PERFORM lpCheckUnique_Object_ValueData(ioId, zc_Object_Car(), inName);
   -- �������� ���� ������������ ��� �������� <��� ����������>
   PERFORM lpCheckUnique_Object_ObjectCode (ioId, zc_Object_Car(), vbCode_calc);
   -- �������� ���� ������������ ��� �������� <����������> 
   PERFORM lpCheckUnique_ObjectString_ValueData(ioId, zc_ObjectString_Car_RegistrationCertificate(), inRegistrationCertificate);

   -- ��������� <������>
   ioId := lpInsertUpdate_Object(ioId, zc_Object_Car(), vbCode_calc, inName);

   PERFORM lpInsertUpdate_ObjectString(zc_ObjectString_Car_RegistrationCertificate(), ioId, inRegistrationCertificate);
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Car_CarModel(), ioId, inCarModelId);

   -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (ioId, vbUserId);

END;$BODY$ LANGUAGE plpgsql;
ALTER FUNCTION gpInsertUpdate_Object_Car(Integer, Integer, TVarChar, TVarChar, Integer, TVarChar) OWNER TO postgres;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 10.06.13          *
 05.06.13          

*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_Car()
