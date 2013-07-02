-- Function: lpInsertFind_Object_PartionGoods()

-- DROP FUNCTION lpInsertFind_Object_PartionGoods();

CREATE OR REPLACE FUNCTION lpInsertFind_Object_PartionGoods(
 INOUT ioId                  Integer   , -- ���� ������� <������ �������>
    IN inCode                Integer   , -- ��� ������� 
    IN inName                TVarChar  , -- �������� ������� 
    IN inDate                TDateTime , -- ���� ������
    IN inPartnerId           Integer   , -- ������ �� ������������
    IN inGoodsId             Integer     -- ������ �� ������
)
  RETURNS Integer AS
$BODY$
BEGIN
   
   -- ��������� <������>
   ioId := lpInsertUpdate_Object(ioId, zc_Object_PartionGoods(), 0, inName);

   PERFORM lpInsertUpdate_ObjectDate (zc_ObjectDate_PartionGoods_Date(), ioId, inDate);

   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_PartionGoods_Partner(), ioId, inPartnerId);
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_PartionGoods_Goods(), ioId, inGoodsId);

END;
$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION lpInsertFind_Object_PartionGoods (Integer, Integer, TVarChar, TDateTime, Integer, Integer) OWNER TO postgres;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 02.07.13          *
*/

-- ����
-- SELECT * FROM lpInsertFind_Object_PartionGoods (ioId:= 1111, inCode:=2 , inName:= 'Test_PartionGoods', inDate:= '31.01.2013', inPartnerId:= 4, inGoodsId:=2)