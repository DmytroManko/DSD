-- Function: gpInsertUpdate_Object_PriceList (Integer, Integer, TVarChar, Boolean, TFloat, TVarChar)

-- DROP FUNCTION gpInsertUpdate_Object_PriceList (Integer, Integer, TVarChar, Boolean, TFloat, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_PriceList(
 INOUT ioId            Integer   ,     -- ���� ������� <����� �����> 
    IN inCode          Integer   ,     -- ��� ������� <����� �����> 
    IN inName          TVarChar  ,     -- �������� ������� <����� �����> 
    IN inPriceWithVAT  Boolean   ,     -- ���� � ��� (��/���)
    IN inVATPercent    TFloat    ,     -- % ���
    IN inSession       TVarChar        -- ������ ������������
)
  RETURNS Integer AS
$BODY$
   DECLARE UserId Integer;
   DECLARE Code_max Integer;   
BEGIN
   
   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight(inSession, zc_Enum_Process_PriceList());
   UserId := inSession;

   -- ���� ��� �� ����������, ���������� ��� ��� ���������+1
   IF COALESCE (inCode, 0) = 0
   THEN 
       SELECT MAX (ObjectCode) + 1 INTO Code_max FROM Object WHERE Object.DescId = zc_Object_PriceList();
   ELSE
       Code_max := inCode;
   END IF; 
   
   -- �������� ���� ������������ ��� �������� <������������ ����� �����>
   PERFORM lpCheckUnique_Object_ValueData(ioId, zc_Object_PriceList(), inName);
   -- �������� ���� ������������ ��� �������� <��� ����� �����>
   PERFORM lpCheckUnique_Object_ObjectCode (ioId, zc_Object_PriceList(), Code_max);

   -- ��������� <������>
   ioId := lpInsertUpdate_Object (ioId, zc_Object_PriceList(), Code_max, inName);
   -- ��������� �������� <���� � ��� (��/���)>
   PERFORM lpInsertUpdate_ObjectBoolean (zc_ObjectFloat_Partner_PrepareDayCount(), ioId, inPriceWithVAT);
   -- ��������� �������� <% ���>
   PERFORM lpInsertUpdate_ObjectFloat (zc_ObjectFloat_PriceList_VATPercent(), ioId, inVATPercent);
   
   -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (ioId, UserId);
   
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpInsertUpdate_Object_PriceList (Integer, Integer, TVarChar, Boolean, TFloat, TVarChar) OWNER TO postgres;


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 07.09.13                                        * add PriceWithVAT and VATPercent
 14.06.13          *
*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_PriceList ()