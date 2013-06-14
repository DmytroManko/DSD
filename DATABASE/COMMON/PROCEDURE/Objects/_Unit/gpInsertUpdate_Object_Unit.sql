-- Function: gpInsertUpdate_Object_Unit()

-- DROP FUNCTION gpInsertUpdate_Object_Unit();

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_Unit(
 INOUT ioId	                     Integer   ,   	-- ���� ������� <�������������>
    IN inCode                    Integer   ,    -- ��� ������� <�������������>
    IN inName                    TVarChar  ,    -- �������� ������� <�������������>
    IN inParentId                Integer   ,    -- ������ �� �������������
    IN inBranchId                Integer   ,    -- ������ �� ������
    IN inBusinessId              Integer   ,    -- ������ �� ������
    IN inJuridicalId             Integer   ,    -- ������ �� ����������� ����
    IN inAccountDirectionId      Integer   ,    -- ������ �� ��������� �������������� ������
    IN inProfitLossDirectionId   Integer ,      -- ������ �� ��������� ������ ������ ���
    IN inSession                 TVarChar       -- ������ ������������
)
  RETURNS integer AS
$BODY$
   DECLARE UserId Integer;
   DECLARE Code_max Integer;  
   
BEGIN
   
   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight(inSession, zc_Enum_Process_Unit());
   UserId := inSession;

   -- ���� ��� �� ����������, ���������� ��� ��� ���������+1
   IF COALESCE (inCode, 0) = 0
   THEN 
       SELECT MAX (ObjectCode) + 1 INTO Code_max FROM Object WHERE Object.DescId = zc_Object_Unit();
   ELSE
       Code_max := inCode;
   END IF; 
   
   -- !!! �������� ������������ ��� �������� <������������ �������������>
   -- !!! PERFORM lpCheckUnique_Object_ValueData(ioId, zc_Object_Unit(), inName);
  
   -- �������� ������������ ��� �������� <��� �������������>
   PERFORM lpCheckUnique_Object_ObjectCode (ioId, zc_Object_Unit(), Code_max);

   -- �������� ���� � ������
   PERFORM lpCheck_Object_CycleLink(ioId, zc_ObjectLink_Unit_Parent(), inParentId);

   -- ��������� ������
   ioId := lpInsertUpdate_Object(ioId, zc_Object_Unit(), Code_max, inName);
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

   -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (ioId, UserId);

END;$BODY$

LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION gpInsertUpdate_Object_Unit(Integer, Integer, TVarChar, Integer, Integer, Integer, Integer, Integer, Integer, tvarchar)
      OWNER TO postgres;


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 14.06.13          *              
 13.05.13                                        * rem lpCheckUnique_Object_ValueData

*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_Unit ()                            
