-- Function: gpSetUnErased_MovementItem (Integer, TVarChar)

-- DROP FUNCTION gpSetUnErased_MovementItem (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpSetUnErased_MovementItem(
    IN inMovementItemId      Integer              , -- ���� ������� <������� ���������>
    IN inSession             TVarChar               -- ������� ������������
)                              
  RETURNS void AS
$BODY$
BEGIN

  -- PERFORM lpCheckRight(inSession, zc_Enum_Process_SetErased_MovementItem());

  -- ����������� ������ 
  UPDATE MovementItem SET isErased = FALSE WHERE Id = inMovementItemId;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpSetUnErased_MovementItem (Integer, TVarChar) OWNER TO postgres;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 01.10.13                                        *
*/

-- ����
-- SELECT * FROM gpSetUnErased_MovementItem (inMovementItemId:= 55, inSession:= '2')
