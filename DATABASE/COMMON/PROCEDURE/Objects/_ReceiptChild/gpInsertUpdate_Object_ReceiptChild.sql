-- Function: gpInsertUpdate_Object_ReceiptChild()

-- DROP FUNCTION gpInsertUpdate_Object_ReceiptChild();

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_ReceiptChild(
 INOUT ioId              Integer   , -- ���� ������� <������������ ��������>
    IN inValue           TFloat    , -- �������� ������� 
    IN inWeight          Boolean   , -- ������ � ����� ��� ������ 
    IN inTaxExit         Boolean   , -- ������� �� % ������
    IN inStartDate       TDateTime , -- ��������� ����
    IN inEndDate         TDateTime , -- �������� ����
    IN inComment         TVarChar  , -- �����������
    IN inReceiptId       Integer   , -- ������ �� ���������
    IN inGoodsId         Integer   , -- ������ �� ������
    IN inGoodsKindId     Integer   , -- ������ �� ���� �������
    IN inSession         TVarChar    -- ������ ������������
)
RETURNS Integer AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN

   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight(inSession, zc_Enum_Process_InsertUpdate_Object_ReceiptChild()());
   vbUserId := inSession;
   
   -- ��������� <������>
   ioId := lpInsertUpdate_Object (ioId, zc_Object_ReceiptChild(), 0, '');
   
   -- ��������� ����� � <����������>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_ReceiptChild_Receipt(), ioId, inReceiptId);
   -- ��������� ����� � <�������>
   PERFORM lpInsertUpdate_ObjectLink (c_ObjectLink_ReceiptChild_Goods(), ioId, inGoodsId);
   -- ��������� ����� � <����� �������>
   PERFORM lpInsertUpdate_ObjectLink (c_ObjectLink_ReceiptChild_GoodsKind(), ioId, inGoodsKindId);
   
   -- ��������� �������� <��������>
   PERFORM lpInsertUpdate_ObjectFloat (zc_ObjectFloat_ReceiptChild_Value(), ioId, inValue);
   -- ��������� �������� <������ � ����� ��� ������>
   PERFORM lpInsertUpdate_ObjectBoolean (c_ObjectBoolean_ReceiptChild_Weight(), ioId, inWeight);
   -- ��������� �������� <������� �� % ������>
   PERFORM lpInsertUpdate_ObjectBoolean (c_ObjectBoolean_ReceiptChild_TaxExit(), ioId, inTaxExit);
   -- ��������� �������� <��������� ����>
   PERFORM lpInsertUpdate_ObjectDate (zc_ObjectDate_ReceiptChild_StartDate(), ioId, inStartDate);
   -- ��������� �������� <�������� ����>
   PERFORM lpInsertUpdate_ObjectDate (zc_ObjectDate_ReceiptChild_EndDate(), ioId, inEndDate);

   -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (ioId, vbUserId);

END;
$BODY$

LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION gpInsertUpdate_Object_ReceiptChild (Integer, TFloat, Boolean, Boolean, TDateTime, TDateTime, TVarChar, Integer, Integer, Integer, TVarChar) OWNER TO postgres;

  
/*---------------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
               
 09.07.13          * 

*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_ReceiptChild ()
    