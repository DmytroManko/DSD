CREATE OR REPLACE FUNCTION zc_DateEnd() RETURNS TDateTime AS $BODY$BEGIN RETURN ('01.01.2100'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_DateStart_PartionGoods() RETURNS TDateTime AS $BODY$BEGIN RETURN ('18.03.2013'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_DateStart_ObjectCostOnUnit() RETURNS TDateTime AS $BODY$BEGIN RETURN ('01.09.2013'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 16.07.13                                        *
 12.07.13                                        *
*/
