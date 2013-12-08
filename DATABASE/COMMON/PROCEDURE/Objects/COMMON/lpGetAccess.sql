-- Function: lpGetAccessKey()

DROP FUNCTION IF EXISTS lpGetAccess (Integer, Integer);
DROP FUNCTION IF EXISTS lpGetAccessKey (Integer, Integer);

CREATE OR REPLACE FUNCTION lpGetAccessKey(
    IN inUserId      Integer      , -- 
    IN inProcessId   Integer        -- 
 )
RETURNS Integer
AS
$BODY$
  DECLARE vbValueId Integer;
BEGIN

  -- ��� ������  - ��� �����
  IF EXISTS (SELECT 1 FROM ObjectLink_UserRole_View WHERE RoleId = zc_Enum_Role_Admin() AND UserId = inUserId)
  THEN
      RAISE EXCEPTION '� ���� <%> ������ ���������� �������� ��� ������� ���������.', lfGet_Object_ValueData (zc_Enum_Role_Admin());
  ELSE

  -- �������� - ������ ���� ������ "����" ������� (������ ���������)
  IF EXISTS (SELECT 1 FROM Object_RoleAccessKey_View WHERE UserId = inUserId /*AND AccessKeyId <> zc_Enum_Process_AccessKey_TrasportDneprNot()*/ HAVING Count (*) = 1)
  THEN
      vbValueId := (SELECT AccessKeyId FROM Object_RoleAccessKey_View WHERE UserId = inUserId /*AND AccessKeyId <> zc_Enum_Process_AccessKey_TrasportDneprNot()*/);
  ELSE
      RAISE EXCEPTION '� ������������ <%> ������ ���������� �������� ��� ������� ���������.', lfGet_Object_ValueData (inUserId);
  END IF;  
  END IF;  
  

  IF COALESCE (vbValueId, 0) = 0
  THEN
      RAISE EXCEPTION '� ������������ <%> ������ ���������� �������� ��� ������� ���������.', lfGet_Object_ValueData (inUserId);
  ELSE RETURN vbValueId;
  END IF;  


END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION lpGetAccessKey (Integer, Integer)  OWNER TO postgres;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 07.12.13                                        *
*/
/*
UPDATE Movement SET AccessKeyId = zc_Enum_Process_AccessKey_TrasportDnepr()
*/
-- ����
-- SELECT * FROM lpGetAccessKey (zfCalc_UserAdmin() :: Integer, null)
