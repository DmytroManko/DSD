﻿-- Function: lpFind_Object_Account()

-- DROP FUNCTION lpFind_Object_Account();

CREATE OR REPLACE FUNCTION lpFind_Object_Account(
IN inAccountGroupId      Integer   ,    /* Группа счетов */
IN inAccountDirectionId  Integer   ,    /* Аналитика счета (место) */
IN inDestinationId       Integer           /* Аналитика счета (назначение) */
)
  RETURNS integer AS
$BODY$
DECLARE lObjectId integer;
BEGIN
--   PERFORM lpCheckRight(inSession, zc_Enum_Process_Account());

   SELECT  
        ObjectLink_Account_AccountGroup.ObjectId INTO lObjectId 
   FROM 
        ObjectLink AS ObjectLink_Account_AccountGroup
   JOIN ObjectLink AS ObjectLink_Account_AccountDirection
     ON ObjectLink_Account_AccountDirection.DescId = zc_ObjectLink_Account_AccountDirection()
    AND ObjectLink_Account_AccountDirection.ChildObjectId = inAccountDirectionId
    AND ObjectLink_Account_AccountDirection.ObjectId = ObjectLink_Account_AccountGroup.ObjectId
   JOIN ObjectLink AS ObjectLink_Account_Destination
     ON ObjectLink_Account_Destination.DescId = zc_ObjectLink_Account_Destination()
    AND ObjectLink_Account_Destination.ChildObjectId = inDestinationId
    AND ObjectLink_Account_Destination.ObjectId = ObjectLink_Account_AccountGroup.ObjectId
  WHERE ObjectLink_Account_AccountGroup.DescId = zc_ObjectLink_Account_AccountGroup()
    AND ObjectLink_Account_AccountGroup.ChildObjectId = inAccountGroupId;

  RETURN COALESCE(lObjectId, 0);

END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
  
                            