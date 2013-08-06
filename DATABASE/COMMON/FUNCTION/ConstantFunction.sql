CREATE OR REPLACE FUNCTION zc_DateEnd() RETURNS TDateTime AS $BODY$BEGIN RETURN ('01.01.2100'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_DateStart_PartionGoods() RETURNS TDateTime AS $BODY$BEGIN RETURN ('18.03.2013'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_DateStart_ObjectCostOnUnit() RETURNS TDateTime AS $BODY$BEGIN RETURN ('01.09.2013'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE OR REPLACE FUNCTION zc_PriceList_ProductionSeparate() RETURNS Integer AS $BODY$BEGIN RETURN (19183); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE; -- select Id_Postgres from PriceList_byHistory where Id = zc_def_PriceList_onRecalcProduction();

CREATE OR REPLACE FUNCTION zc_PriceList_Basis() RETURNS Integer AS $BODY$BEGIN RETURN (19134); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE; -- select Id_Postgres from PriceList_byHistory where Id = 2;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 06.08.13                                        * ? ��� ������� ��� � ��������� �-��� ������������ ����� �������� ������ (� �� ��� �������������� ��)
 21.07.13                                        * add zc_PriceList_ProductionSeparate and zc_PriceList_Basis
 16.07.13                                        *
 12.07.13                                        *
*/
