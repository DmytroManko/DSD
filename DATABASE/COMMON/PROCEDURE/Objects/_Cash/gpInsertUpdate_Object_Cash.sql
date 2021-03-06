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
   DECLARE vbUserId Integer;
 BEGIN
   -- �������� ���� ������������ �� ����� ���������
   -- vbUserId:= lpCheckRight (inSession, zc_Enum_Process_Select_Object_Cash());
   vbUserId:= lpGetUserBySession (inSession);

   -- ���� ��� �� ����������, ���������� ��� ��� ���������+1
   inCode := lfGet_ObjectCode (inCode, zc_Object_Cash());
    
   -- �������� ���� ������������ ��� �������� <������������ �����>  
   PERFORM lpCheckUnique_Object_ValueData(ioId, zc_Object_Cash(), inCashName);
   -- �������� ���� ������������ ��� �������� <��� �����>
   PERFORM lpCheckUnique_Object_ObjectCode (ioId, zc_Object_Cash(), inCode);

   -- ��������� <������>
   ioId := lpInsertUpdate_Object (ioId, zc_Object_Cash(), inCode, inCashName
                                , inAccessKeyId:= CASE WHEN COALESCE (inBranchId, 0) = 0 THEN zc_Enum_Process_AccessKey_CashDnepr() ELSE (SELECT Object_Branch.AccessKeyId FROM Object AS Object_Branch WHERE Object_Branch.Id = inBranchId) END);

   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Cash_Currency(), ioId, inCurrencyId);
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Cash_Branch(), ioId, inBranchId);
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Cash_MainJuridical(), ioId, inMainJuridicalId);
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Cash_Business(), ioId, inBusinessId);

   -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (ioId, vbUserId);
   
END;$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpInsertUpdate_Object_Cash(Integer, Integer, TVarChar, Integer, Integer, Integer, Integer, tvarchar) OWNER TO postgres;
  
 /*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 26.12.13                                        * add inAccessKeyId
 24.11.13                                        * err lfGet_ObjectCode (zc_Object_Cash(), inCode)
 24.11.13                                        * Cyr1251
 10.06.13          *
*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_Cash()
