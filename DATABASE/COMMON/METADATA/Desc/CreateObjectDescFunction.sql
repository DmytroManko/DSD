CREATE OR REPLACE FUNCTION zc_Object_Process()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 1;
END;  $BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION zc_Object_Role()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 2;
END;  $BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION zc_Object_User()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 3;
END;  $BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION zc_Object_RoleRight()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 4;
END;  $BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION zc_Object_UserRole()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 5;
END;  $BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION zc_Object_Goods()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 6;
END;  $BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION zc_Object_Unit()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 7;
END;  $BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION zc_Object_Form()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 8;
END;  $BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION zc_Object_Measure()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 9;
END;  $BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION zc_Object_Cash()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 10;
END;  $BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION zc_Object_AccountPlan()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 11;
END;  $BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION zc_Object_Status()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 12;
END;  $BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION zc_Object_Currency()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 13;
END;  $BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION zc_Object_PaidKind()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 14;
END;  $BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION zc_Object_Branch()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 15;
END;  $BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION zc_Object_Juridical()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 16;
END;  $BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION zc_Object_JuridicalGroup()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 17;
END;  $BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION zc_Object_GoodsProperty()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 18;
END;  $BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION zc_Object_Partner()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 19;
END;  $BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION zc_Object_ContractKind()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 20;
END;  $BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION zc_Object_Business()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 21;
END;  $BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION zc_Object_UnitGroup()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 22;
END;  $BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION zc_Object_GoodsGroup()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 23;
END;  $BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION zc_Object_Bank()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 24;
END;  $BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION zc_Object_GoodsKind()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 25;
END;  $BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION zc_Object_BankAccount()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 26;
END;  $BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION zc_Object_PriceList()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 27;
END;  $BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION zc_Object_Contract()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 28;
END;  $BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION zc_Object_Car()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 29;
END;  $BODY$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION zc_Object_CarModel()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 30;
END;  $BODY$ LANGUAGE plpgsql;