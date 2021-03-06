-- Function: gpInsertUpdate_Object_Juridical()

-- DROP FUNCTION gpInsertUpdate_Object_Juridical();

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_Juridical(
 INOUT ioId                  Integer   ,    -- ���� ������� <����������� ����>
    IN inCode                Integer   ,    -- �������� <��� ������������ ����>
    IN inName                TVarChar  ,    -- �������� ������� <����������� ����>
    IN inGLNCode             TVarChar  ,    -- ��� GLN
    IN inisCorporate         Boolean   ,    -- ������� ���� �� ������������� ��� ����������� ����
    IN inJuridicalGroupId    Integer   ,    -- ������ ����������� ���
    IN inGoodsPropertyId     Integer   ,    -- �������������� ������� �������
    IN inInfoMoneyId         Integer   ,    -- ������ ����������
    IN inSession             TVarChar       -- ������� ������������
)
  RETURNS integer AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbCode_calc Integer;  
BEGIN
   
   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight(inSession, zc_Enum_Process_InsertUpdate_Object_Juridical());
   vbUserId := inSession;

   -- !!! ���� ��� �� ����������, ���������� ��� ��� ���������+1 (!!! ����� ���� ����� ��� �������� !!!)
   -- !!! vbCode_calc:=lfGet_ObjectCode (inCode, zc_Object_Juridical());
   IF COALESCE (inCode, 0) = 0  THEN vbCode_calc := 0; ELSE vbCode_calc := inCode; END IF; -- !!! � ��� ������ !!!
   
   -- !!! �������� ������������ <������������>
   -- !!! PERFORM lpCheckUnique_Object_ValueData(ioId, zc_Object_Juridical(), inName);
   -- !!! �������� ������������ <���>
   -- !!! PERFORM lpCheckUnique_Object_ObjectCode (ioId, zc_Object_Juridical(), Code_max);

   -- ��������� <������>
   ioId := lpInsertUpdate_Object(ioId, zc_Object_Juridical(), vbCode_calc, inName);
   -- ��������� �������� <>
   PERFORM lpInsertUpdate_ObjectString(zc_objectString_Juridical_GLNCode(), ioId, inGLNCode);
   -- ��������� �������� <>
   PERFORM lpInsertUpdate_ObjectBoolean(zc_ObjectBoolean_Juridical_isCorporate(), ioId, inisCorporate);
   -- ��������� ����� � <>
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Juridical_JuridicalGroup(), ioId, inJuridicalGroupId);
   -- ��������� ����� � <>
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Juridical_GoodsProperty(), ioId, inGoodsPropertyId);
   -- ��������� ����� � <>
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Juridical_InfoMoney(), ioId, inInfoMoneyId);

   -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (ioId, vbUserId);
   
END;
$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpInsertUpdate_Object_Juridical(Integer, Integer, TVarChar, TVarChar, Boolean, Integer, Integer, Integer, TVarChar) OWNER TO postgres;

  
/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 20.10.13                                        * vbCode_calc:=0
 03.07.13          * + InfoMoney              
 12.05.13                                        * rem lpCheckUnique_Object_ValueData
 12.06.13          *    
 16.06.13                                        * rem lpCheckUnique_Object_ObjectCode
*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_Juridical()
