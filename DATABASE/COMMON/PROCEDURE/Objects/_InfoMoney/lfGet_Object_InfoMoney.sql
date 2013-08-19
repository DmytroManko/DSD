﻿-- Function: lfGet_Object_InfoMoney ()

-- DROP FUNCTION lfGet_Object_InfoMoney();

CREATE OR REPLACE FUNCTION lfGet_Object_InfoMoney(in inInfoMoneyId integer)

RETURNS TABLE (InfoMoneyGroupId Integer,  
               InfoMoneyDestinationId Integer) AS
   
$BODY$BEGIN

     -- Выбираем данные для справочника уп-назначения (на самом деле это три справочника)
     RETURN QUERY 
     SELECT 
           ObjectLink_InfoMoney_InfoMoneyGroup.ChildObjectId       AS InfoMoneyGroupId
          ,ObjectLink_InfoMoney_InfoMoneyDestination.ChildObjectId AS InfoMoneyDestinationId
          
     FROM (SELECT inInfoMoneyId AS Id) AS Object_InfoMoney
       
     LEFT JOIN ObjectLink AS ObjectLink_InfoMoney_InfoMoneyGroup
            ON ObjectLink_InfoMoney_InfoMoneyGroup.ObjectId = Object_InfoMoney.Id 
           AND ObjectLink_InfoMoney_InfoMoneyGroup.DescId = zc_ObjectLink_InfoMoney_InfoMoneyGroup()

     LEFT JOIN ObjectLink AS ObjectLink_InfoMoney_InfoMoneyDestination
            ON ObjectLink_InfoMoney_InfoMoneyDestination.ObjectId = Object_InfoMoney.Id 
           AND ObjectLink_InfoMoney_InfoMoneyDestination.DescId = zc_ObjectLink_InfoMoney_InfoMoneyDestination();
          
END;$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION lfGet_Object_InfoMoney (Integer) OWNER TO postgres;

/*-------------------------------------------------------------------------------*/
/*
 ИСТОРИЯ РАЗРАБОТКИ: ДАТА, АВТОР
               Фелонюк И.В.   Кухтин И.В.   Климентьев К.И.
 16.08.13                        *                            

*/

-- тест
-- SELECT * FROM lfGet_Object_InfoMoney()
