--------------------------- !!!!!!!!!!!!!!!!!!!
--------------------------- !!! ����� ����� !!!
--------------------------- !!!!!!!!!!!!!!!!!!!

CREATE OR REPLACE FUNCTION zc_MovementItemString_Comment() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementItemStringDesc WHERE Code = 'zc_MovementItemString_Comment'); END; $BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION zc_MovementItemString_PartionGoods() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementItemStringDesc WHERE Code = 'zc_MovementItemString_PartionGoods'); END; $BODY$ LANGUAGE plpgsql;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.

 29.06.13                                        * ����� �����
 29.06.13                                        * zc_MovementItemString_PartionGoods
*/
