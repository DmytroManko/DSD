-- Function: gpInsertUpdate_Object_Personal()

-- DROP FUNCTION gpInsertUpdate_Object_Personal (Integer, Integer, Integer, Integer,Integer,Integer, TDateTime, TDateTime, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_Personal(
 INOUT ioId                  Integer   , -- ���� ������� <����������>
    IN inCode                Integer   , -- ��� ������� 
    IN inMemberId            Integer   , -- ������ �� ���.���� 
    IN inPositionId          Integer   , -- ������ �� ���������
    IN inUnitId              Integer   , -- ������ �� �������������
    IN inPersonalGroupId     Integer   , -- ����������� �����������
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
   ioId := lpInsertUpdate_Object (ioId, zc_Object_Personal(), vbCode, '');
   -- ��������� ����� � <���.�����>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Personal_Member(), ioId, inMemberId);
   -- ��������� ����� � <����������>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Personal_Position(), ioId, inPositionId);
   -- ��������� ����� � <��������������>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Personal_Unit(), ioId, inUnitId);
      -- ��������� ����� � <����������� �����������>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Personal_PersonalGroup(), ioId, inPersonalGroupId);
   -- ��������� �������� <���� ��������>
   PERFORM lpInsertUpdate_ObjectDate (zc_ObjectDate_Personal_In(), ioId, inDateIn);
   -- ��������� �������� <���� ����������>
   PERFORM lpInsertUpdate_ObjectDate (zc_ObjectDate_Personal_Out(), ioId, inDateOut);

   -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (ioId, vbUserId);

END;
$BODY$

LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION gpInsertUpdate_Object_Personal (Integer, Integer, Integer, Integer,Integer,Integer, TDateTime, TDateTime, TVarChar) OWNER TO postgres;

  
/*---------------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 25.09.13         * add _PersonalGroup; remove _Juridical, _Business              
 06.09.13                         * inName - �����. �� ����� ��� ���� ����������
 24.07.13                                        * inName - ���� !!! ��� ���� �� vbMemberName
 01.07.13          * 
 19.07.13                         * 
 19.07.13         *    rename zc_ObjectDate...

*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_Personal (ioId:=0, inCode:=0, inName:='����� ������������', inMemberId:=26622, inPositionId:=0, inUnitId:=21778, inJuridicalId:=23966, inBusinessId:=0, inDateIn:=null, inDateOut:=null, inSession:='2')
