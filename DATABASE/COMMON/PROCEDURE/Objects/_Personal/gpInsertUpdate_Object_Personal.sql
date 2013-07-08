-- Function: gpInsertUpdate_Object_Personal()

-- DROP FUNCTION gpInsertUpdate_Object_Personal();

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_Personal(
 INOUT ioId                  Integer   , -- ���� ������� <����������>
    IN inCode                Integer   , -- ��� ������� 
    IN inName                TVarChar  , -- �������� ������� 
    IN inMemberId            Integer   , -- ������ �� ���.���� 
    IN inPositionId          Integer   , -- ������ �� ���������
    IN inUnitId              Integer   , -- ������ �� �������������
    IN inJuridicalId         Integer   , -- ������ �� ��.����
    IN inBusinessId          Integer   , -- ������ �� ������
    IN inDateIn              TDateTime , -- ���� ��������
    IN inDateOut             TDateTime , -- ���� ����������
    IN inSession             TVarChar    -- ������ ������������
)
RETURNS Integer AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbCode Integer;   
BEGIN

   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight(inSession, zc_Enum_Process_InsertUpdate_Object_Personal()());
   vbUserId := inSession;
   
   --  ���� ��� �� ����������, ���������� ��� ��� ���������+1 
   vbCode:=lfGet_ObjectCode (inCode, zc_Object_Personal());
   
   -- �������� ������������ <���>
   PERFORM lpCheckUnique_Object_ObjectCode (ioId, zc_Object_Personal(), vbCode);

   -- ��������� <������>
   ioId := lpInsertUpdate_Object (ioId, zc_Object_Personal(), vbCode, inName);
   -- ��������� ����� � <���.�����>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Personal_Member(), ioId, inMemberId);
   -- ��������� ����� � <����������>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Personal_Position(), ioId, inPositionId);
   -- ��������� ����� � <��������������>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Personal_Unit(), ioId, inUnitId);
      -- ��������� ����� � <��.�����>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Personal_Juridical(), ioId, inJuridicalId);
   -- ��������� ����� � <��������>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Personal_Business(), ioId, inBusinessId);
   -- ��������� �������� <���� ��������>
   PERFORM lpInsertUpdate_ObjectDate (zc_ObjectDate_Personal_DateIn(), ioId, inDateIn);
   -- ��������� �������� <���� ����������>
   PERFORM lpInsertUpdate_ObjectDate (zc_ObjectDate_Personal_DateOut(), ioId, inDateOut);

   -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (ioId, vbUserId);

END;
$BODY$

LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION gpInsertUpdate_Object_Personal (Integer, Integer, TVarChar, Integer, Integer,Integer,Integer,Integer, TDateTime, TDateTime, TVarChar) OWNER TO postgres;

  
/*---------------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
               
 01.07.13          * 

*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_Personal (ioId:=0, inCode:=0, inName:='����� ������������', inMemberId:=26622, inPositionId:=0, inUnitId:=21778, inJuridicalId:=23966, inBusinessId:=0, inDateIn:=null, inDateOut:=null, inSession:='2')
    