-- Function: gpInsertUpdate_Object_Car(Integer,Integer,TVarChar,TVarChar,TDateTime,TDateTime,Integer,Integer,Integer,Integer,Integer,Integer,TVarChar)

-- DROP FUNCTION gpInsertUpdate_Object_Car(Integer,Integer,TVarChar,TVarChar,TDateTime,TDateTime,Integer,Integer,Integer,Integer,Integer,Integer,TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_Car(
 INOUT ioId                       Integer   ,    -- ���� ������� <����������> 
    IN inCode                     Integer   ,    -- ��� ������� <����������>
    IN inName                     TVarChar  ,    -- �������� ������� <����������>
    IN inRegistrationCertificate  TVarChar  ,    -- ���������� ������� <����������>
    IN inStartDateRate            TDateTime ,    -- ��������� ���� ��� ���� �����
    IN inEndDateRate              TDateTime ,    -- �������� ���� ��� ���� �����
    IN inCarModelId               Integer   ,    -- ������ ����          
    IN inUnitId                   Integer   ,    -- �������������
    IN inPersonalDriverId         Integer   ,    -- ��������� (��������)
    IN inFuelMasterId             Integer   ,    -- ��� ������� (��������)
    IN inFuelChildId              Integer   ,    -- ��� ������� (��������������)
    IN inRateFuelKindId           Integer   ,    -- ���� ���� ��� �������
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
   -- ��������� ��-�� <����������>
   PERFORM lpInsertUpdate_ObjectString(zc_ObjectString_Car_RegistrationCertificate(), ioId, inRegistrationCertificate);

   -- ��������� �������� <��������� ���� ��� ���� �����>
   PERFORM lpInsertUpdate_ObjectDate (zc_ObjectDate_Car_StartDateRate(), ioId, inStartDateRate);
   -- ��������� �������� <�������� ���� ��� ���� �����>
   PERFORM lpInsertUpdate_ObjectDate (zc_ObjectDate_Car_EndDateRate(), ioId, inEndDateRate);

   -- ��������� ����� � <������ ����>
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Car_CarModel(), ioId, inCarModelId);
   -- ��������� ����� � <��������������>
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Car_Unit(), ioId, inUnitId);
   -- ��������� ����� � <��������� (��������)>
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Car_PersonalDriver(), ioId, inPersonalDriverId);
   -- ��������� ����� � <��� ������� (��������)>
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Car_FuelMaster(), ioId, inFuelMasterId);
   -- ��������� ����� � <��� ������� (��������������)>
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Car_FuelChild(), ioId, inFuelChildId);
   -- ��������� ����� � <���� ���� ��� �������>
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Car_RateFuelKind(), ioId, inRateFuelKindId);

   -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (ioId, vbUserId);

END;$BODY$ LANGUAGE plpgsql;
ALTER FUNCTION gpInsertUpdate_Object_Car(Integer,Integer,TVarChar,TVarChar,TDateTime,TDateTime,Integer,Integer,Integer,Integer,Integer,Integer,TVarChar) OWNER TO postgres;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 24.09.13          * add StartDateRate, EndDateRate, Unit, PersonalDriver, FuelMaster, FuelChild, RateFuelKind
 10.06.13          *
 05.06.13          

*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_Car()
