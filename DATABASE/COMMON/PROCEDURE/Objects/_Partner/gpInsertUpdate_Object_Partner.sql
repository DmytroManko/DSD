-- Function: gpInsertUpdate_Object_Partner()

DROP FUNCTION IF EXISTS gpInsertUpdate_Object_Partner (Integer, Integer, TVarChar, TVarChar, TFloat, TFloat, Integer, Integer, Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_Partner(
 INOUT ioId	                 Integer   ,   	-- ���� ������� <����������> 
    IN inCode                Integer   ,    -- ��� ������� <����������> 
    IN inName                TVarChar  ,    -- �������� ������� <����������>
    IN inGLNCode             TVarChar  ,    -- ��� GLN
    IN inPrepareDayCount     TFloat    ,    -- �� ������� ���� ����������� �����
    IN inDocumentDayCount    TFloat    ,    -- ����� ������� ���� ����������� �������������
    IN inJuridicalId         Integer   ,    -- ����������� ����
    IN inRouteId             Integer   ,    -- �������
    IN inRouteSortingId      Integer   ,    -- ���������� ���������
    IN inPersonalTakeId      Integer   ,    -- ��������� (����������)  
    IN inSession             TVarChar       -- ������ ������������
)
  RETURNS integer AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbCode_calc Integer;   
BEGIN
   
   -- �������� ���� ������������ �� ����� ���������
   -- vbUserId := PERFORM lpCheckRight(inSession, zc_Enum_Process_InsertUpdate_Object_Partner());
   vbUserId := inSession;

   -- �������� ��������� ��������
   IF COALESCE (inJuridicalId, 0) = 0  THEN
      RAISE EXCEPTION '�� ����������� ����������� ����!';
   END IF;
   
   -- !!! ���� ��� �� ����������, ���������� ��� ��� ���������+1 (!!! ����� ���� ����� ��� �������� !!!)
   -- !!! vbCode_calc:=lfGet_ObjectCode (inCode, zc_Object_Partner());
   IF COALESCE (inCode, 0) = 0  THEN vbCode_calc := 0; ELSE vbCode_calc := inCode; END IF; -- !!! � ��� ������ !!!
   
   -- !!! �������� ������������ <������������>
   -- !!! PERFORM lpCheckUnique_Object_ValueData(ioId, zc_Object_Partner(), inName);
   -- !!! �������� ������������ <���>
   -- !!! PERFORM lpCheckUnique_Object_ObjectCode (ioId, zc_Object_Partner(), vbCode_calc);

   -- ��������� <������>
   ioId := lpInsertUpdate_Object(ioId, zc_Object_Partner(), vbCode_calc, inName);
   -- ��������� �������� <��� GLN>
   PERFORM lpInsertUpdate_ObjectString( zc_ObjectString_Partner_GLNCode(), ioId, inGLNCode);
   -- ��������� �������� <�� ������� ���� ����������� �����>
   PERFORM lpInsertUpdate_ObjectFloat( zc_ObjectFloat_Partner_PrepareDayCount(), ioId, inPrepareDayCount);
   -- ��������� �������� <����� ������� ���� ����������� �������������>
   PERFORM lpInsertUpdate_ObjectFloat( zc_ObjectFloat_Partner_DocumentDayCount(), ioId, inDocumentDayCount);
   -- ��������� ����� � <����������� ����>
   PERFORM lpInsertUpdate_ObjectLink( zc_ObjectLink_Partner_Juridical(), ioId, inJuridicalId);
   -- ��������� ����� � <��������>
   PERFORM lpInsertUpdate_ObjectLink( zc_ObjectLink_Partner_Route(), ioId, inRouteId);
   -- ��������� ����� � <���������� ���������>
   PERFORM lpInsertUpdate_ObjectLink( zc_ObjectLink_Partner_RouteSorting(), ioId, inRouteSortingId);
   -- ��������� ����� � <��������� (����������)>
   PERFORM lpInsertUpdate_ObjectLink( zc_ObjectLink_Partner_PersonalTake(), ioId, inPersonalTakeId);


   -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (ioId, vbUserId);
   
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpInsertUpdate_Object_Partner(Integer, Integer, TVarChar, TVarChar, TFloat, TFloat, Integer, Integer, Integer, Integer, TVarChar) OWNER TO postgres;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 20.10.13                                        * vbCode_calc:=0
 29.07.13          *  + PersonalTakeId, PrepareDayCount, DocumentDayCount                
 03.07.13          *  + Route, RouteSorting              
 16.06.13                                        * rem lpCheckUnique_Object_ObjectCode
 13.06.13          *
 14.05.13                                        * rem lpCheckUnique_Object_ValueData
*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_Partner()
