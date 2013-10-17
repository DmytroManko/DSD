-- Function: gpInsertUpdate_Object_StaffList(Integer,  TFloat, TFloat, TFloat, Integer, Integer, Integer, TVarChar)

DROP FUNCTION IF EXISTS gpInsertUpdate_Object_StaffList(Integer,  TFloat, TFloat, TFloat, Integer, Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_StaffList(
 INOUT ioId                  Integer   , -- ���� ������� <������� ����������>
    IN inHoursPlan           TFloat    , -- ���� ������
    IN inPersonalCount       TFloat    , -- ���. �������
    IN inFundPay             TFloat    , -- ���� ������
    IN inUnitId              Integer   , -- �������������
    IN inPositionId          Integer   , -- ���������
    IN inPositionLevelId     Integer   , -- ������ ���������
    IN inSession             TVarChar    -- ������ ������������
)
RETURNS Integer AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN

   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight(inSession, zc_Enum_Process_InsertUpdate_Object_StaffList()());
   vbUserId := inSession;
   
   -- ��������� <������>
   ioId := lpInsertUpdate_Object (ioId, zc_Object_StaffList(), 0, '');
   
   -- ��������� ����� � <��������������>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_StaffList_Unit(), ioId, inUnitId);   
   -- ��������� ����� � <����������>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_StaffList_Position(), ioId, inPositionId);
   -- ��������� ����� � <�������� ���������)>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_StaffList_PositionLevel(), ioId, inPositionLevelId);

   -- ��������� �������� <>
   PERFORM lpInsertUpdate_ObjectFloat (zc_ObjectFloat_StaffList_HoursPlan(), ioId, inHoursPlan);
   -- ��������� �������� <>
   PERFORM lpInsertUpdate_ObjectFloat (zc_ObjectFloat_StaffList_PersonalCount(), ioId, inPersonalCount);
   -- ��������� �������� <>
   PERFORM lpInsertUpdate_ObjectFloat (zc_ObjectFloat_StaffList_FundPay(), ioId, inFundPay);

   -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (ioId, vbUserId);

END;
$BODY$

LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION gpInsertUpdate_Object_StaffList (Integer,  TFloat, TFloat, TFloat, Integer, Integer, Integer, TVarChar) OWNER TO postgres;

  
/*---------------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 17.10.13         * 

*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_StaffList (0,  198, 2, 1000, 1, 5, 6, '2')
    