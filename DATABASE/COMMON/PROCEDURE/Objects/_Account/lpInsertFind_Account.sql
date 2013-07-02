-- Function: lpInsertFind_Account (Integer, Integer, Integer, Integer, Integer)

--DROP FUNCTION lpInsertFind_Account (Integer, Integer, Integer, Integer, Integer);

CREATE OR REPLACE FUNCTION lpInsertFind_Account(
    IN inAccountGroupId         Integer  , -- ������ ������
    IN inAccountDirectionId     Integer  , -- ��������� ������ - �����������
    IN inInfoMoneyDestinationId Integer  , -- �������������� ����������
    IN inInfoMoneyId            Integer  , -- ������ ����������
    IN inUserId                 Integer    -- ������������
)
  RETURNS Integer AS
$BODY$
   DECLARE vbAccountDirectionId Integer;
   DECLARE vbAccountDirectionCode Integer;
   DECLARE vbAccountDirectionName TVarChar;
   DECLARE vbAccountId Integer;
   DECLARE vbAccountCode Integer;
   DECLARE vbAccountName TVarChar;
BEGIN

   -- ��������
   IF COALESCE (inAccountGroupId, 0) = 0
   THEN
       RAISE EXCEPTION '���������� ���������� ���� �.�. �� ����������� ������ ������';
   END IF;

   IF COALESCE (inAccountDirectionId, 0) = 0
   THEN
       RAISE EXCEPTION '���������� ���������� ���� �.�. �� ����������� ��������� ������ - �����������';
   END IF;

   IF COALESCE (inInfoMoneyDestinationId, 0) = 0 AND COALESCE (inInfoMoneyId, 0) = 0
   THEN
       RAISE EXCEPTION '���������� ���������� ���� �.�. �� ����������� �������������� ����������';
   END IF;

   -- ������� �������������� ����
   SELECT AccountId INTO vbAccountId FROM lfSelect_Object_Account WHERE AccountGroupId = inAccountGroupId AND AccountDirectionId = inAccountDirectionId AND InfoMoneyDestinationId = inInfoMoneyDestinationId;


   -- ������� ����� ����
   IF COALESCE (vbAccountId, 0) = 0 
   THEN
       -- ���������� Id 2-�� ������� �� <������ ������> � <��������� ������ - �����������>
       SELECT AccountDirectionId INTO vbAccountDirectionId FROM lfSelect_Object_AccountDirection WHERE AccountGroupId = inAccountGroupId AND AccountDirectionId = inAccountDirectionId;

       IF COALESCE (vbAccountDirectionId, 0) = 0
       THEN
            -- ���������� �������� 2-�� ������� �� <��������� ������ - �����������>
           SELECT AccountDirectionName INTO vbAccountDirectionName FROM lfSelect_Object_AccountDirection WHERE AccountDirectionId = inAccountDirectionId;

           -- ���������� Id 2-�� ������� �� <������ ������> � vbAccountDirectionName
           SELECT AccountDirectionId INTO vbAccountDirectionId FROM lfSelect_Object_AccountDirection WHERE AccountGroupId = inAccountGroupId AND AccountDirectionName = vbAccountDirectionName;

           -- ���� Id �� �����, ������ 2-�� �������
           IF COALESCE (vbAccountDirectionId, 0) = 0
           THEN
               -- ���������� ������� ���
               SELECT COALESCE (MAX (AccountDirectionCode), 0) + 100 INTO vbAccountDirectionCode FROM lfSelect_Object_AccountDirection WHERE AccountGroupId = inAccountGroupId;
               -- ������� 2-�� �������
               vbAccountDirectionId := lpInsertUpdate_Object (vbAccountDirectionId, zc_Object_AccountDirection(), vbAccountDirectionCode, vbAccountDirectionName);
               -- ��������� ��������
               PERFORM lpInsert_ObjectProtocol (vbAccountDirectionId, inUserId);
           END IF;

       END IF;


       -- ���������� �������� 3-�� ������� �� <�������������� ����������> ��� <������ ����������>
       IF inInfoMoneyId <> 0 THEN SELECT InfoMoneyName INTO vbAccountName FROM lfSelect_Object_InfoMoney WHERE InfoMoneyId = inInfoMoneyId;
                             ELSE SELECT InfoMoneyDestinationName INTO vbAccountName FROM lfSelect_Object_InfoMoneyDestination WHERE InfoMoneyDestinationId = inInfoMoneyDestinationId;
       END IF;

       -- ���������� ������� ���
       SELECT COALESCE (MAX (AccountCode), 0) + 1 INTO vbAccountCode FROM lfSelect_Object_Account WHERE AccountGroupId = inAccountGroupId AND AccountDirectionId = vbAccountDirectionId;

       IF vbAccountCode = 1 THEN
         -- ���������� ������� ���
         vbAccountCode:= vbAccountDirectionCode + 1;
       END IF;

       -- ������ 3-�� �������
       vbAccountId := lpInsertUpdate_Object (vbAccountId, zc_Object_Account(), vbAccountCode, vbAccountName);
       -- ��� �������� ��� 3-�� �������
       PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Account_AccountGroup(), ioId, inAccountGroupId);
       PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Account_AccountDirection(), ioId, vbAccountDirectionId);
       PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Account_InfoMoneyDestination(), ioId, inInfoMoneyDestinationId);
       PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Account_InfoMoney(), ioId, inInfoMoneyId);
       
       -- ��������� ��������
       PERFORM lpInsert_ObjectProtocol (vbAccountId, inUserId);
   END IF;


   -- ���������� ��������
   RETURN (vbAccountId);


END;
$BODY$
LANGUAGE PLPGSQL VOLATILE;

ALTER FUNCTION lpInsertFind_Account (Integer, Integer, Integer, Integer, Integer)  OWNER TO postgres;

  
/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.

 02.07.13                                        *
*/

-- ����
-- SELECT * FROM lpInsertFind_Account (inAccountGroupId:= zc_Enum_AccountGroup_100000(), inAccountDirectionId:= 23581, inInfoMoneyDestinationId:= zc_Enum_InfoMoneyDestination_10100(), inInfoMoneyId:= 0, inUserId:= 2)