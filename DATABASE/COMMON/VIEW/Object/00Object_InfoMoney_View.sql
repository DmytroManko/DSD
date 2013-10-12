-- View: Object_InfoMoney_View

-- DROP VIEW IF EXISTS Object_InfoMoney_View;

CREATE OR REPLACE VIEW Object_InfoMoney_View AS
  SELECT Object_InfoMoneyGroup.Id               AS InfoMoneyGroupId
       , Object_InfoMoneyGroup.ObjectCode       AS InfoMoneyGroupCode
       , Object_InfoMoneyGroup.ValueData        AS InfoMoneyGroupName
       , Object_InfoMoneyDestination.Id         AS InfoMoneyDestinationId
       , Object_InfoMoneyDestination.ObjectCode AS InfoMoneyDestinationCode
       , Object_InfoMoneyDestination.ValueData  AS InfoMoneyDestinationName
       , Object_InfoMoney.Id                    AS InfoMoneyId
       , Object_InfoMoney.ObjectCode            AS InfoMoneyCode
       , Object_InfoMoney.ValueData             AS InfoMoneyName
       , Object_InfoMoney.isErased              AS isErased
  FROM Object AS Object_InfoMoney
       LEFT JOIN ObjectLink AS ObjectLink_InfoMoney_InfoMoneyDestination
                            ON ObjectLink_InfoMoney_InfoMoneyDestination.ObjectId = Object_InfoMoney.Id
                           AND ObjectLink_InfoMoney_InfoMoneyDestination.DescId = zc_ObjectLink_InfoMoney_InfoMoneyDestination()
       LEFT JOIN Object AS Object_InfoMoneyDestination ON Object_InfoMoneyDestination.Id = ObjectLink_InfoMoney_InfoMoneyDestination.ChildObjectId
 
       LEFT JOIN ObjectLink AS ObjectLink_InfoMoney_InfoMoneyGroup
                            ON ObjectLink_InfoMoney_InfoMoneyGroup.ObjectId = Object_InfoMoney.Id
                           AND ObjectLink_InfoMoney_InfoMoneyGroup.DescId = zc_ObjectLink_InfoMoney_InfoMoneyGroup()
       LEFT JOIN Object AS Object_InfoMoneyGroup ON Object_InfoMoneyGroup.Id = ObjectLink_InfoMoney_InfoMoneyGroup.ChildObjectId

 WHERE Object_InfoMoney.DescId = zc_Object_InfoMoney();


ALTER TABLE Object_InfoMoney_View  OWNER TO postgres;


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 30.09.13                                        *
*/

-- ����
-- SELECT * FROM Object_InfoMoney_View