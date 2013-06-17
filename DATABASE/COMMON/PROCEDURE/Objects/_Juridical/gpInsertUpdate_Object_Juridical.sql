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
    IN inSession             TVarChar       -- ������� ������������
)
  RETURNS integer AS
$BODY$
   DECLARE UserId Integer;
   DECLARE Code_max Integer;  
BEGIN
   
   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight(inSession, zc_Enum_Process_Juridical());
   UserId := inSession;

   -- !!! ���� ��� �� ����������, ���������� ��� ��� ���������+1 (!!! ����� ���� ����� ��� �������� !!!)
   -- !!! IF COALESCE (inCode, 0) = 0
   -- !!! THEN 
   -- !!!     SELECT MAX (ObjectCode) + 1 INTO Code_max FROM Object WHERE Object.DescId = zc_Object_Juridical();
   -- !!! ELSE
   -- !!!     Code_max := inCode;
   -- !!! END IF; 
   IF COALESCE (inCode, 0) = 0  THEN Code_max := NULL; ELSE Code_max := inCode; END IF; -- !!! � ��� ������ !!!
   
   -- !!! �������� ������������ <������������>
   -- !!! PERFORM lpCheckUnique_Object_ValueData(ioId, zc_Object_Juridical(), inName);
   -- !!! �������� ������������ <���>
   -- !!! PERFORM lpCheckUnique_Object_ObjectCode (ioId, zc_Object_Juridical(), Code_max);

   -- ��������� <������>
   ioId := lpInsertUpdate_Object(ioId, zc_Object_Juridical(), inCode, inName);
   -- ��������� �������� <>
   PERFORM lpInsertUpdate_ObjectString(zc_objectString_Juridical_GLNCode(), ioId, inGLNCode);
   -- ��������� �������� <>
   PERFORM lpInsertUpdate_ObjectBoolean(zc_ObjectBoolean_Juridical_isCorporate(), ioId, inisCorporate);
   -- ��������� ����� � <>
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Juridical_JuridicalGroup(), ioId, inJuridicalGroupId);
   -- ��������� ����� � <>
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Juridical_GoodsProperty(), ioId, inGoodsPropertyId);

   -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (ioId, UserId);
   
END;$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpInsertUpdate_Object_Juridical(Integer, Integer, TVarChar, TVarChar, Boolean, Integer, Integer, TVarChar) OWNER TO postgres;

  
/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 12.05.13                                        * rem lpCheckUnique_Object_ValueData
 12.06.13          *    
 16.06.13                                        * rem lpCheckUnique_Object_ObjectCode
 
*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_Juridical()
