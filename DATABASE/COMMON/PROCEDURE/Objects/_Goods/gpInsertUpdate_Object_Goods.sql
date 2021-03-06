-- Function: gpInsertUpdate_Object_Goods()

DROP FUNCTION IF EXISTS gpInsertUpdate_Object_Goods(Integer, Integer, TVarChar, TFloat Integer, Integer, Integer, Integer, Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_Goods(
 INOUT ioId                  Integer   , -- ���� ������� <�����>
    IN inCode                Integer   , -- ��� ������� <�����>
    IN inName                TVarChar  , -- �������� ������� <�����>
    IN inWeight              TFloat    , -- ���
    IN inGoodsGroupId        Integer   , -- ������ �� ������ �������
    IN inMeasureId           Integer   , -- ������ �� ������� ���������
    IN inTradeMarkId         Integer   , -- ������ �� �������� �����
    IN inInfoMoneyId         Integer   , -- �������������� ���������
    IN inBusinessId          Integer   , -- �������
    IN inFuelId              Integer   , -- ��� �������
    IN inSession             TVarChar    -- ������ ������������
)
RETURNS Integer AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbCode_calc Integer;   
BEGIN
   -- �������� ���� ������������ �� ����� ���������
   vbUserId := lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_Object_Goods());
   
   -- !!! ���� ��� �� ����������, ���������� ��� ��� ���������+1 (!!! ����� ���� ����� ��� �������� !!!)
   -- !!! vbCode_calc:=lfGet_ObjectCode (inCode, zc_Object_Goods());
   IF COALESCE (inCode, 0) = 0  THEN vbCode_calc := 0; ELSE vbCode_calc := inCode; END IF; -- !!! � ��� ������ !!!
   
   -- !!! �������� ������������ <������������>
   -- !!! PERFORM lpCheckUnique_Object_ValueData (ioId, zc_Object_Goods(), inName);

   -- �������� ������������ <���>
   PERFORM lpCheckUnique_Object_ObjectCode (ioId, zc_Object_Goods(), vbCode_calc);

   -- ��������� <������>
   ioId := lpInsertUpdate_Object (ioId, zc_Object_Goods(), vbCode_calc, inName
                                , inAccessKeyId:= CASE WHEN inFuelId <> 0 AND NOT EXISTS (SELECT 1 FROM ObjectLink WHERE DescId = zc_ObjectLink_TicketFuel_Goods() AND ChildObjectId = ioId)
                                                            THEN zc_Enum_Process_AccessKey_TrasportAll()
                                                  END);
   -- ��������� �������� <���>
   PERFORM lpInsertUpdate_ObjectFloat (zc_ObjectFloat_Goods_Weight(), ioId, inWeight);
   -- ��������� ����� � <������� ������>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Goods_GoodsGroup(), ioId, inGoodsGroupId);
   -- ��������� ����� � <�������� ���������>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Goods_Measure(), ioId, inMeasureId);
   -- ��������� ����� � <�������� �����>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Goods_TradeMark(), ioId, inTradeMarkId);   
   -- ��������� ����� � <�������������� ���������>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Goods_InfoMoney(), ioId, inInfoMoneyId);
   -- ��������� ����� � <�������>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Goods_Business(), ioId, inBusinessId);
   -- ��������� ����� � <��� �������>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Goods_Fuel(), ioId, inFuelId);

   -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (ioId, vbUserId);

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION gpInsertUpdate_Object_Goods (Integer, Integer, TVarChar, TFloat, Integer, Integer, Integer, Integer, Integer, Integer, TVarChar) OWNER TO postgres;
 
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 14.12.13                                        * add inAccessKeyId
 20.10.13                                        * vbCode_calc:=0
 29.09.13                                        * add zc_ObjectLink_Goods_Fuel
 01.09.13                                        * add zc_ObjectLink_Goods_Business
 30.06.13                                        * add vb
 20.06.13          * vbCode_calc:=lpGet_ObjectCode (inCode, zc_Object_Goods());
 16.06.13                                        * IF COALESCE (inCode, 0) = 0  THEN Code_max := NULL ...
 11.06.13          *
 11.05.13                                        * rem lpCheckUnique_Object_ValueData
*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_Goods (ioId:=0, inCode:=-1, inName:= 'TEST-GOODS', ... , inSession:= '2')
