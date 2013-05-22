-- Function: gpComplete_Movement_Income()

-- DROP FUNCTION gpComplete_Movement_Income(Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpComplete_Movement_Income(
   IN inMovementId        Integer,   	/* ���� ������� <��������� ���������> */
   IN inSession           TVarChar       /* ������� ������������ */
)                              
  RETURNS void AS
$BODY$
  DECLARE AccountId Integer;
  DECLARE UnitId Integer;
BEGIN
  -- PERFORM lpCheckRight(inSession, zc_Enum_Process_Measure());
  
  -- ������ �������� ��������

  -- ������ �������� �� ����� ����� �������
  -- ����� ���� ������
  AccountId := lpFind_Object_Account(zc_Object_AccountGroup_Inventory(),
                            zc_Object_AccountPlace_Store(),
                            zc_Object_AccountReference_MeatByProduct());

  -- ���������� �������������
  SELECT 
    MovementLink_To.ObjectId INTO UnitId
  FROM MovementLinkObject AS MovementLink_To 
 WHERE MovementLink_To.DescId = zc_MovementLink_To();
      

  
  -- ������ �������� �� ����� �������������


  -- ����������� ������ ������ ���������
  UPDATE Movement SET StatusId = zc_Object_Status_Complete() WHERE Id = inMovementId;

END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
  
                            