-- Function: gpUnComplete_Movement (Integer, TVarChar)

DROP FUNCTION IF EXISTS gpUnComplete_Movement (Integer, TVarChar);
DROP FUNCTION IF EXISTS gpUnComplete_Movement (Integer, Boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpUnComplete_Movement(
    IN inMovementId Integer               , -- ���� ������� <��������>
--    IN inIsChild    Boolean  DEFAULT TRUE , -- ���� �� � ����� ��������� ����������� ��������� !!!�� � ���� ������ �� ������� FALSE!!!
    IN inSession    TVarChar DEFAULT ''     -- ������� ������������
)                              
  RETURNS void
AS
$BODY$
  DECLARE vbUserId Integer;
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight(inSession, zc_Enum_Process_UnComplete_Movement());
     vbUserId:=2; -- CAST (inSession AS Integer);


     -- �������� - ��������� ��������� ������������ ������
     PERFORM lfCheck_Movement_Parent (inMovementId:= inMovementId, inComment:= '�����������');


     -- ����������� ��������
     PERFORM lpUnComplete_Movement (inMovementId := inMovementId
                                  , inUserId     := vbUserId);


     -- ����������� ����������� ���������
     PERFORM lpUnComplete_Movement (inMovementId := Movement.Id
                                  , inUserId     := vbUserId)
     FROM Movement
     WHERE ParentId = inMovementId;


END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpUnComplete_Movement (Integer, TVarChar) OWNER TO postgres;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 06.10.13                                        *
*/

-- ����
-- SELECT * FROM gpUnComplete_Movement (inMovementId:= 55, inIsChild := TRUE, inSession:= '2')
