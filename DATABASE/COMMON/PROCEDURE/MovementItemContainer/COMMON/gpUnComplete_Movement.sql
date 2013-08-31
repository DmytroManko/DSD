-- Function: gpUnComplete_Movement (Integer, TVarChar)

-- DROP FUNCTION gpUnComplete_Movement (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpUnComplete_Movement(
    IN inMovementId          Integer              , -- ���� ������� <��������>
    IN inSession             TVarChar               -- ������� ������������
)                              
  RETURNS void AS
$BODY$
BEGIN

--   PERFORM lpCheckRight(inSession, zc_Enum_Process_Measure());

  -- ������� ��� ��������
  PERFORM lpDelete_MovementItemContainer (inMovementId);

  -- ������� ��� �������� ��� ������
  PERFORM lpDelete_MovementItemReport (inMovementId);

  -- ����������� ������ ������ ���������
  UPDATE Movement SET StatusId = zc_Enum_Status_UnComplete() WHERE Id = inMovementId;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpUnComplete_Movement (Integer, TVarChar) OWNER TO postgres;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 29.08.13                                        * add lpDelete_MovementItemReport
 08.07.13                                        * rename to zc_Enum_Status_UnComplete
*/

-- ����
-- SELECT * FROM gpUnComplete_Movement (inMovementId:= 55, inSession:= '2')
