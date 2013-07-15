-- Function: gpSetErased_Movement()

-- DROP FUNCTION gpSetErased_Movement(Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpSetErased_Movement(
   IN inMovementId        Integer,   	/* ���� ������� <��������> */
   IN inSession           TVarChar      /* ������� ������������ */
)                              
  RETURNS void AS
$BODY$BEGIN
--   PERFORM lpCheckRight(inSession, zc_Enum_Process_Measure());

  -- ������� ��� ��������
  PERFORM lpDelete_MovementItemContainer(inMovementId);

  -- ����������� ������ ������ ���������
  UPDATE Movement SET StatusId = zc_Object_Status_Erased() WHERE Id = inMovementId;

END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
  
                            