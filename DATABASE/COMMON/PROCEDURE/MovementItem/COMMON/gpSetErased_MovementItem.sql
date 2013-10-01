-- Function: gpSetErased_MovementItem (Integer, TVarChar)

-- DROP FUNCTION gpSetErased_MovementItem (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpSetErased_MovementItem(
    IN inMovementItemId      Integer              , -- ���� ������� <������� ���������>
    IN inSession             TVarChar               -- ������� ������������
)                              
  RETURNS void AS
$BODY$
BEGIN

  -- PERFORM lpCheckRight(inSession, zc_Enum_Process_SetErased_MovementItem());

  -- ����������� ������ 
  UPDATE MovementItem SET isErased = TRUE WHERE Id = inMovementItemId;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpSetErased_MovementItem (Integer, TVarChar) OWNER TO postgres;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 01.10.13                                        *
*/

-- ����
-- SELECT * FROM gpSetErased_MovementItem (inMovementItemId:= 55, inSession:= '2')