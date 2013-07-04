-- Function: gpInsertUpdate_Object_Asset()

-- DROP FUNCTION gpInsertUpdate_Object_Asset();

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_Asset(
 INOUT ioId                  Integer   ,    -- ���� ������� < �������� ��������>
    IN inCode                Integer   ,    -- ��� ������� 
    IN inName                TVarChar  ,    -- �������� ������� 
    IN inInvNumber           TVarChar  ,    -- ����������� �����
    IN inAssetGroupId        Integer   ,    -- ������ �� ������ �������� �������
    IN inSession             TVarChar       -- ������ ������������
)
  RETURNS integer AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbCode_calc Integer; 
BEGIN
   
   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight(inSession, zc_Enum_Process_InsertUpdate_Object_Asset());
   vbUserId:= inSession;

    -- ���� ��� �� ����������, ���������� ��� ��� ���������+1
   vbCode_calc:=lfGet_ObjectCode (inCode, zc_Object_Asset()); 

   
   -- �������� ������������ ��� �������� <������������>
   PERFORM lpCheckUnique_Object_ValueData(ioId, zc_Object_Asset(), inName);
   -- �������� ������������ ��� �������� <���>
   PERFORM lpCheckUnique_Object_ObjectCode (ioId, zc_Object_Asset(), vbCode_calc);
   -- �������� ������������ ��� �������� <����������� �����> 
   PERFORM lpCheckUnique_ObjectString_ValueData(ioId, zc_ObjectString_Asset_InvNumber(), inInvNumber);

   -- ��������� <������>
   ioId := lpInsertUpdate_Object(ioId, zc_Object_Asset(), vbCode_calc, inName);

   PERFORM lpInsertUpdate_ObjectString(zc_ObjectString_Asset_InvNumber(), ioId, inInvNumber);
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Asset_AssetGroup(), ioId, inAssetGroupId);

   -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (ioId, vbUserId);

END;
$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpInsertUpdate_Object_Asset(Integer, Integer, TVarChar, TVarChar, Integer, tvarchar) OWNER TO postgres;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 02.07.13          *
*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_Asset()
