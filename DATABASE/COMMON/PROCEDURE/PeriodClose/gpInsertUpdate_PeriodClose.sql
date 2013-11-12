-- Function: gpInsertUpdate_PeriodClose (Integer, Integer, Integer, TVarChar)

DROP FUNCTION IF EXISTS gpInsertUpdate_PeriodClose (Integer, Integer, Integer, Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_PeriodClose(
 INOUT ioId	        Integer   ,     -- ���� ������� ����� 
    IN inUserId         Integer   ,     -- ������������
    IN inRoleId         Integer   ,     -- ����
    IN inUnitId         Integer   ,     -- �������������
    IN inPeriod         Integer   ,     -- ���
    IN inSession        TVarChar        -- ������ ������������
)
  RETURNS Integer AS
$BODY$
   DECLARE UserId Integer;
   DECLARE vbInterval Interval;
BEGIN
   
   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight(inSession, zc_Enum_Process_UserRole());

   UserId := inSession;
   vbInterval := (to_char(inPeriod, '999')||' day')::interval;
   IF inRoleId = 0 THEN
      inRoleId := NULL;
   END IF;
   IF inUnitId = 0 THEN
      inUnitId := NULL;
   END IF;

   IF COALESCE (ioId, 0) = 0 THEN
      -- �������� ����� ������� ����������� � ������� �������� <���� �������>
      INSERT INTO PeriodClose (UserId, RoleId, UnitId, Period)
                  VALUES (inUserId, inRoleId, inUnitId, vbInterval) RETURNING Id INTO ioId;
   ELSE
       -- �������� ������� ����������� �� �������� <���� �������>
       UPDATE Object SET UserId = inUserId, RoleId = inRoleId, UnitId = inUnitId, Period = vbPeriod WHERE Id = ioId;
       -- ���� ����� ������� �� ��� ������
       IF NOT FOUND THEN
          -- �������� ����� ������� ����������� �� ��������� <���� �������>
          INSERT INTO PeriodClose (Id, UserId, RoleId, UnitId, Period)
               VALUES (ioId, inUserId, inRoleId, inUnitId, vbInterval) RETURNING Id INTO ioId;
       END IF; -- if NOT FOUND

   END IF; -- if COALESCE (ioId, 0) = 0
  
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpInsertUpdate_PeriodClose (Integer, Integer, Integer, Integer, Integer, TVarChar) OWNER TO postgres;


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 23.09.13                         *

*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_UserRole()