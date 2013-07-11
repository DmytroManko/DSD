CREATE OR REPLACE FUNCTION zc_Container_Count() RETURNS integer AS $BODY$BEGIN RETURN (SELECT Id FROM ContainerDesc WHERE Code = 'zc_Container_Count'); END; $BODY$ LANGUAGE plpgsql IMMUTABLE;
INSERT INTO ContainerDesc(Code, ItemName)
  SELECT 'zc_Container_Count', '������� ��������������� �����' WHERE NOT EXISTS (SELECT * FROM ContainerDesc WHERE Code = 'zc_Container_Count');

CREATE OR REPLACE FUNCTION zc_Container_Summ() RETURNS integer AS $BODY$BEGIN RETURN (SELECT Id FROM ContainerDesc WHERE Code = 'zc_Container_Summ'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO ContainerDesc(Code, ItemName)
  SELECT 'zc_Container_Summ', '������� ��������� �����' WHERE NOT EXISTS (SELECT * FROM ContainerDesc WHERE Code = 'zc_Container_Summ');


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 11.07.13                                        * ����� �����2 - Create and Insert
 05.07.13         * ����� �����
*/
