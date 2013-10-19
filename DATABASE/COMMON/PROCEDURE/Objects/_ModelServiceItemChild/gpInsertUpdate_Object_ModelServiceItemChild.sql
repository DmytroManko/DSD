-- Function: gpInsertUpdate_Object_ModelServiceItemChild(Integer, TVarChar, Integer, Integer, TVarChar)

DROP FUNCTION IF EXISTS gpInsertUpdate_Object_ModelServiceItemChild(Integer, TVarChar, Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_ModelServiceItemChild(
 INOUT ioId                  Integer   , -- ���� ������� <����������� �������� ������ ����������>
    IN inComment             TVarChar  , -- ����������
    IN inFromId              Integer   , -- �����(�� ����)
    IN inToId                Integer   , -- �����(����) 	
    IN inSession             TVarChar    -- ������ ������������
)
RETURNS Integer AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN

   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight(inSession, zc_Enum_Process_InsertUpdate_Object_ModelServiceItemChild()());
   vbUserId := inSession;
   
   -- ��������� <������>
   ioId := lpInsertUpdate_Object (ioId, zc_Object_ModelServiceItemChild(), 0, '');
   
   -- ��������� �������� <>   
   PERFORM lpInsertUpdate_ObjectString (zc_ObjectString_ModelServiceItemChild_Comment(), ioId, inComment);
   
   -- ��������� ����� � <>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_ModelServiceItemChild_From(), ioId, inFromId);
   -- ��������� ����� � <>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_ModelServiceItemChild_To(), ioId, inToId);


   -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (ioId, vbUserId);

END;
$BODY$

LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION gpInsertUpdate_Object_ModelServiceItemChild (Integer, TVarChar, Integer, Integer, TVarChar) OWNER TO postgres;

  
/*---------------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
20.10.13         * 

*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_ModelServiceItemChild (0, '1000', 5, 6, '2')
    