CREATE OR REPLACE FUNCTION zc_MIDate_PartionGoods() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementItemDateDesc WHERE Code = 'zc_MIDate_PartionGoods'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementItemDateDesc (Code, ItemName)
  SELECT 'zc_MIDate_PartionGoods', '������ ������' WHERE NOT EXISTS (SELECT * FROM MovementItemDateDesc WHERE Code = 'zc_MIDate_PartionGoods');

CREATE OR REPLACE FUNCTION zc_MIDate_OperDate() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementItemDateDesc WHERE Code = 'zc_MIDate_OperDate'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementItemDateDesc (Code, ItemName)
  SELECT 'zc_MIDate_OperDate', '���� ������' WHERE NOT EXISTS (SELECT * FROM MovementItemDateDesc WHERE Code = 'zc_MIDate_OperDate');

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 04.11.13                                        *
 19.07.13         *
*/
