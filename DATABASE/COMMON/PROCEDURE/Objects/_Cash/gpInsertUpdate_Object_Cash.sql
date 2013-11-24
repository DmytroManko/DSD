-- Function: gpInsertUpdate_Object_Cash()

-- DROP FUNCTION gpInsertUpdate_Object_Cash();

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_Cash(
 INOUT ioId	         Integer   ,   	-- ���� ������� <�����> 
    IN inCode            Integer   ,    -- ��� ������� <�����> 
    IN inCashName        TVarChar  ,    -- �������� ������� <�����> 
    IN inCurrencyId      Integer   ,    -- ������ ������ ����� 
    IN inBranchId        Integer   ,    -- ������ ������� ����������� ����� 
    IN inMainJuridicalId Integer   ,    -- ������� �� ����
    IN inBusinessId      Integer   ,    -- ������
    IN inSession         TVarChar       -- ������ ������������
)
  RETURNS integer AS
$BODY$
   DECLARE UserId Integer;
 BEGIN
 
   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight(inSession, zc_Enum_Process_Cash());
   UserId := inSession;

   -- ���� ��� �� ����������, ���������� ��� ��� ���������+1
   inCode := lfGet_ObjectCode (inCode, zc_Object_Cash());
    
   -- �������� ���� ������������ ��� �������� <������������ �����>  
   PERFORM lpCheckUnique_Object_ValueData(ioId, zc_Object_Cash(), inCashName);
   -- �������� ���� ������������ ��� �������� <��� �����>
   PERFORM lpCheckUnique_Object_ObjectCode (ioId, zc_Object_Cash(), inCode);

   -- ��������� <������>
   ioId := lpInsertUpdate_Object(ioId, zc_Object_Cash(), inCode, inCashName);

   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Cash_Currency(), ioId, inCurrencyId);
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Cash_Branch(), ioId, inBranchId);
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Cash_MainJuridical(), ioId, inMainJuridicalId);
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Cash_Business(), ioId, inBusinessId);

   -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (ioId, UserId);
   
END;$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpInsertUpdate_Object_Cash(Integer, Integer, TVarChar, Integer, Integer, Integer, Integer, tvarchar)
  OWNER TO postgres;
  
  
 /*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 24.11.13                                        * err lfGet_ObjectCode (zc_Object_Cash(), inCode)
 24.11.13                                        * Cyr1251
 10.06.13          *
*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_Cash()
  

  
                            