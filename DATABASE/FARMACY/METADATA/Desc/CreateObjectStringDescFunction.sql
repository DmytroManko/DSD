CREATE OR REPLACE FUNCTION zc_ObjectString_user_password()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 1;
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION zc_ObjectString_User_password()
  OWNER TO postgres;

CREATE OR REPLACE FUNCTION zc_ObjectString_user_login()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 2;
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION zc_ObjectString_User_login()
  OWNER TO postgres;

CREATE OR REPLACE FUNCTION zc_ObjectString_Currency_InternalName()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 3;
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 1;
ALTER FUNCTION zc_ObjectString_Currency_InternalName()
  OWNER TO postgres;

CREATE OR REPLACE FUNCTION zc_ObjectString_Juridical_GLNCode()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 8;
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 1;
ALTER FUNCTION zc_ObjectString_Juridical_GLNCode()
  OWNER TO postgres;

CREATE OR REPLACE FUNCTION zc_ObjectString_Partner_GLNCode()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 9;
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 1;
ALTER FUNCTION zc_ObjectString_Partner_GLNCode()
  OWNER TO postgres;

CREATE OR REPLACE FUNCTION zc_ObjectString_Bank_MFO()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 10;
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 1;
ALTER FUNCTION zc_ObjectString_Bank_MFO()
  OWNER TO postgres;


CREATE OR REPLACE FUNCTION zc_ObjectString_Contract_InvNumber()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 11;
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 1;
ALTER FUNCTION zc_ObjectString_Contract_InvNumber()
  OWNER TO postgres;

CREATE OR REPLACE FUNCTION zc_ObjectString_Contract_Comment()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 12;
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 1;
ALTER FUNCTION zc_ObjectString_Contract_Comment()
  OWNER TO postgres;

CREATE OR REPLACE FUNCTION zc_ObjectString_Goods_CashName()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 13;
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 1;
ALTER FUNCTION zc_ObjectString_Goods_CashName()
  OWNER TO postgres;
  
  
CREATE OR REPLACE FUNCTION zc_ObjectString_RegistrationCertificate()
  RETURNS integer AS
$BODY$BEGIN
  RETURN 17;
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 1;
ALTER FUNCTION zc_ObjectString_RegistrationCertificate()
  OWNER TO postgres;

