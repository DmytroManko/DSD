-- Function: gpSetErased_Movement (Integer, TVarChar)

-- DROP FUNCTION gpSetErased_Movement (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpSetErased_Movement(
    IN inMovementId          Integer              , -- ���� ������� <��������>
    IN inSession             TVarChar               -- ������� ������������
)                              
  RETURNS void AS
$BODY$
BEGIN

  -- PERFORM lpCheckRight(inSession, zc_Enum_Process_SetErased_Movement());

  -- ������� ��� ��������
  PERFORM lpDelete_MovementItemContainer (inMovementId);

  -- ������� ��� �������� ��� ������
  PERFORM lpDelete_MovementItemReport (inMovementId);

  -- ����������� ������ ������ ���������
  UPDATE Movement SET StatusId = zc_Enum_Status_Erased() WHERE Id = inMovementId;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpSetErased_Movement (Integer, TVarChar) OWNER TO postgres;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 01.09.13                                        * add lpDelete_MovementItemReport
*/

-- ����
-- SELECT * FROM gpSetErased_Movement (inMovementId:= 55, inSession:= '2')
