CREATE OR REPLACE FUNCTION zc_ObjectCostLink_Unit() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id AS Id FROM ObjectCostLinkDesc WHERE Code = 'zc_ObjectCostLink_Unit'); END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO ObjectCostLinkDesc (Code, ItemName, ObjectDescId)
  SELECT 'zc_ObjectCostLink_Unit', '�������������', zc_Object_Unit() WHERE NOT EXISTS (SELECT * FROM ObjectCostLinkDesc WHERE Code = 'zc_ObjectCostLink_Unit');

CREATE OR REPLACE FUNCTION zc_ObjectCostLink_Goods() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id AS Id FROM ObjectCostLinkDesc WHERE Code = 'zc_ObjectCostLink_Goods'); END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO ObjectCostLinkDesc (Code, ItemName, ObjectDescId)
  SELECT 'zc_ObjectCostLink_Goods', '������', zc_Object_Goods() WHERE NOT EXISTS (SELECT * FROM ObjectCostLinkDesc WHERE Code = 'zc_ObjectCostLink_Goods');

CREATE OR REPLACE FUNCTION zc_ObjectCostLink_GoodsKind() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id AS Id FROM ObjectCostLinkDesc WHERE Code = 'zc_ObjectCostLink_GoodsKind'); END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO ObjectCostLinkDesc (Code, ItemName, ObjectDescId)
  SELECT 'zc_ObjectCostLink_GoodsKind', '���� �������', zc_Object_GoodsKind() WHERE NOT EXISTS (SELECT * FROM ObjectCostLinkDesc WHERE Code = 'zc_ObjectCostLink_GoodsKind');

CREATE OR REPLACE FUNCTION zc_ObjectCostLink_InfoMoney() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id AS Id FROM ObjectCostLinkDesc WHERE Code = 'zc_ObjectCostLink_InfoMoney'); END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO ObjectCostLinkDesc (Code, ItemName, ObjectDescId)
  SELECT 'zc_ObjectCostLink_InfoMoney', '������ ����������', zc_Object_InfoMoney() WHERE NOT EXISTS (SELECT * FROM ObjectCostLinkDesc WHERE Code = 'zc_ObjectCostLink_InfoMoney');

CREATE OR REPLACE FUNCTION zc_ObjectCostLink_InfoMoneyDetail() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id AS Id FROM ObjectCostLinkDesc WHERE Code = 'zc_ObjectCostLink_InfoMoneyDetail'); END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO ObjectCostLinkDesc (Code, ItemName, ObjectDescId)
 SELECT 'zc_ObjectCostLink_InfoMoneyDetail', '������ ����������(����������� �/�)', zc_Object_InfoMoney() WHERE NOT EXISTS (SELECT * FROM ObjectCostLinkDesc WHERE Code = 'zc_ObjectCostLink_InfoMoneyDetail');

CREATE OR REPLACE FUNCTION zc_ObjectCostLink_PartionGoods() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id AS Id FROM ObjectCostLinkDesc WHERE Code = 'zc_ObjectCostLink_PartionGoods'); END;  $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO ObjectCostLinkDesc (Code, ItemName, ObjectDescId)
  SELECT 'zc_ObjectCostLink_PartionGoods', '������ ������', zc_Object_PartionGoods() WHERE NOT EXISTS (SELECT * FROM ObjectCostLinkDesc WHERE Code = 'zc_ObjectCostLink_PartionGoods');

CREATE OR REPLACE FUNCTION zc_ObjectCostLink_Business() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id AS Id FROM ObjectCostLinkDesc WHERE Code = 'zc_ObjectCostLink_Business'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO ObjectCostLinkDesc (Code, ItemName, ObjectDescId)
  SELECT 'zc_ObjectCostLink_Business', '�������', zc_Object_Business() WHERE NOT EXISTS (SELECT * FROM ObjectCostLinkDesc WHERE Code = 'zc_ObjectCostLink_Business');

CREATE OR REPLACE FUNCTION zc_ObjectCostLink_JuridicalBasis() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id AS Id FROM ObjectCostLinkDesc WHERE Code = 'zc_ObjectCostLink_JuridicalBasis'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO ObjectCostLinkDesc (Code, ItemName, ObjectDescId)
  SELECT 'zc_ObjectCostLink_JuridicalBasis', '������� ����������� ����', zc_Object_Juridical() WHERE NOT EXISTS (SELECT * FROM ObjectCostLinkDesc WHERE Code = 'zc_ObjectCostLink_JuridicalBasis');

CREATE OR REPLACE FUNCTION zc_ObjectCostLink_Branch() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id AS Id FROM ObjectCostLinkDesc WHERE Code = 'zc_ObjectCostLink_JuridicalBasis'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO ObjectCostLinkDesc (Code, ItemName, ObjectDescId)
  SELECT 'zc_ObjectCostLink_Branch', '�������', zc_Object_Branch() WHERE NOT EXISTS (SELECT * FROM ObjectCostLinkDesc WHERE Code = 'zc_ObjectCostLink_Branch');


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 11.07.13                                        *
*/
