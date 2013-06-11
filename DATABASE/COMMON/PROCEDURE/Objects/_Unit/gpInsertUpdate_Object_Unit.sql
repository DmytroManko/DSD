-- Function: gpInsertUpdate_Object_Unit()

-- DROP FUNCTION gpInsertUpdate_Object_Unit();

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_Unit(
INOUT ioId	         Integer   ,   	-- ���� ������� <�������������>
IN inCode                Integer   ,    -- ��� ������� <�������������>
IN inName                TVarChar  ,    -- �������� ������� <�������������>
IN inParentId            Integer   ,    -- ������ �� �������������
IN inBranchId            Integer   ,    -- ������ �� ������
IN inBusinessId          Integer   ,    -- ������ �� ������
IN inJuridicalId         Integer   ,    -- ������ �� ����������� ����
IN inAccountDirectionId  Integer   ,    -- ������ �� ��������� �������������� ������
IN inProfitLossDirectionId Integer ,    -- ������ �� ��������� ������ ������ ���
IN inSession             TVarChar       -- ������� ������������
)
  RETURNS integer AS
$BODY$BEGIN
--   PERFORM lpCheckRight(inSession, zc_Enum_Process_UnitGroup());

   -- !!! -- �������� ������������ �����
   -- !!! PERFORM lpCheckUnique_Object_ValueData(ioId, zc_Object_Unit(), inName);

   -- �������� ���� � ������
   PERFORM lpCheck_Object_CycleLink(ioId, zc_ObjectLink_Unit_Parent(), inParentId);

   -- ��������� ������
   ioId := lpInsertUpdate_Object(ioId, zc_Object_Unit(), inCode, inName);
   -- ��������� ������
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Unit_Parent(), ioId, inParentId);
   -- ��������� ������
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Unit_Branch(), ioId, inBranchId);
   -- ��������� ������
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Unit_Business(), ioId, inBusinessId);
   -- ��������� ������
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Unit_Juridical(), ioId, inJuridicalId);
   -- ��������� ������
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Unit_AccountDirection(), ioId, inAccountDirectionId);
   -- ��������� ������
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Unit_ProfitLossDirection(), ioId, inProfitLossDirectionId);

END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION gpInsertUpdate_Object_Unit(Integer, Integer, TVarChar, Integer, Integer, Integer, Integer, Integer, Integer, tvarchar)
  OWNER TO postgres;


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 13.05.13                                        * rem lpCheckUnique_Object_ValueData

*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_Unit ()                            
