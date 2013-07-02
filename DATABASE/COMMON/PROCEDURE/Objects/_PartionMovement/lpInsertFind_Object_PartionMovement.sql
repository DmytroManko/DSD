-- Function: lpInsertFind_Object_PartionMovement()

-- DROP FUNCTION lpInsertFind_Object_PartionMovement();

CREATE OR REPLACE FUNCTION lpInsertFind_Object_PartionMovement(
 INOUT ioId                  Integer   , -- ���� ������� <������ ���������>
    IN inCode                Integer   , -- ��� ������� 
    IN inName                TVarChar  , -- ������ �������� ������
    IN inMovementId          Integer     -- ������ �� �������� ������ �� ���������
)
  RETURNS Integer AS
$BODY$
BEGIN
   
   -- ��������� <������>
   ioId := lpInsertUpdate_Object(ioId, zc_Object_PartionMovement(), 0, inName);

   PERFORM lpInsertUpdate_ObjectFloat(zc_ObjectFloat_PartionMovement_MovementId(), ioId, inMovementId);

END;
$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION lpInsertFind_Object_PartionMovement (Integer, Integer, TVarChar, Integer) OWNER TO postgres;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 02.07.13          *
*/

-- ����
-- SELECT * FROM lpInsertFind_Object_PartionMovement (ioId:= -4, inCode:=6 , inName:= 'Test_PartionMovement', inMovementId:= 4)