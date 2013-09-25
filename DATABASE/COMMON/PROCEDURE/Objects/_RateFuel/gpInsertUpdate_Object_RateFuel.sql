-- Function: gpInsertUpdate_Object_RateFuel (Integer, TFloat, TFloat, TFloat, Integer, Integer, Integer, TVarChar)

-- DROP FUNCTION gpInsertUpdate_Object_RateFuel (Integer, TFloat, TFloat, TFloat, Integer, Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_RateFuel(
 INOUT ioId                    Integer   ,    -- ���� ������� <����� �������>
    IN inAmount                TFloat    ,    -- ���-�� ����� �� 100 ��
    IN inAmount�oldHour        TFloat    ,    -- �����, ���-�� ����� � ���
    IN inAmount�oldDistance    TFloat    ,    -- �����, ���-�� ����� �� 100 ��
    IN inCarId                 Integer   ,    -- ����������
    IN inRouteKindId           Integer   ,    -- ��� ��������
    IN inRateFuelKindId        Integer   ,    -- ���� ���� �������
    IN inSession               TVarChar       -- ������ ������������
)
 RETURNS Integer AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN
   
   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight (inSession, zc_Enum_Process_RateFuel());
   vbUserId := inSession;
 
   -- ��������� <������>
   ioId := lpInsertUpdate_Object(ioId, zc_Object_RateFuel(), 0, '');

   -- ��������� �������� <>
   PERFORM lpInsertUpdate_ObjectFloat (zc_ObjectFloat_RateFuel_Amount(), ioId, inAmount);
   -- ��������� �������� <>
   PERFORM lpInsertUpdate_ObjectFloat (zc_ObjectFloat_RateFuel_Amount�oldHour(), ioId, inAmount�oldHour);
   -- ��������� �������� <>
   PERFORM lpInsertUpdate_ObjectFloat (zc_ObjectFloat_RateFuel_Amount�oldDistance(), ioId, inAmount�oldDistance);

   -- ��������� ����� � <>
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_RateFuel_Car(), ioId, inCarId);
   -- ��������� ����� � <>
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_RateFuel_RouteKind(), ioId, inRouteKindId);
   -- ��������� ����� � <>
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_RateFuel_RateFuelKind(), ioId, inRateFuelKindId);

   -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (ioId, vbUserId);

END;$BODY$ LANGUAGE plpgsql;
ALTER FUNCTION gpInsertUpdate_Object_RateFuel(Integer, TFloat, TFloat, TFloat, Integer, Integer, Integer, TVarChar) OWNER TO postgres;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 24.09.13          * 

*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_RateFuel()
