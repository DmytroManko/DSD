CREATE OR REPLACE FUNCTION zc_ObjectFloat_Goods_Weight()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 1;
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION zc_ObjectFloat_Goods_Weight()
  OWNER TO postgres;
