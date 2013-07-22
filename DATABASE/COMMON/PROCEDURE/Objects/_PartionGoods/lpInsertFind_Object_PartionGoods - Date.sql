-- Function: lpInsertFind_Object_PartionGoods (TDateTime)

-- DROP FUNCTION lpInsertFind_Object_PartionGoods (TDateTime);

CREATE OR REPLACE FUNCTION lpInsertFind_Object_PartionGoods(
    IN inOperDate  TDateTime -- ���� ������
)
  RETURNS Integer AS
$BODY$
   DECLARE vbPartionGoodsId Integer;
   DECLARE vbOperDate TVarChar;
BEGIN

     -- ����������� � �������
     vbOperDate:= COALESCE (TO_CHAR (inOperDate, 'DD.MM.YYYY'), '');

     -- ������� 
     vbPartionGoodsId:= (SELECT Id FROM Object WHERE ValueData = vbOperDate AND DescId = zc_Object_PartionGoods());

     -- ���� �� �����
     IF COALESCE (vbPartionGoodsId, 0) = 0
     THEN
         -- ��������� <������>
         vbPartionGoodsId := lpInsertUpdate_Object (vbPartionGoodsId, zc_Object_PartionGoods(), 0, vbOperDate);
         -- ���������
         PERFORM lpInsertUpdate_ObjectDate (zc_ObjectDate_PartionGoods_Value(), vbPartionGoodsId, inOperDate);
     END IF;

     -- ���������� ��������
     RETURN (vbPartionGoodsId);

END;
$BODY$
LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION lpInsertFind_Object_PartionGoods (TDateTime) OWNER TO postgres;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 19.07.13         *  rename zc_ObjectDate_            
 12.07.13                                        * �������� �� 2 ����-��
 02.07.13                                        * ������� Find, ����� ���� ���� Insert
 02.07.13         *
*/

-- ����
-- SELECT * FROM lpInsertFind_Object_PartionGoods (inOperDate:= '31.01.2013');
-- SELECT * FROM lpInsertFind_Object_PartionGoods (inOperDate:= NULL);