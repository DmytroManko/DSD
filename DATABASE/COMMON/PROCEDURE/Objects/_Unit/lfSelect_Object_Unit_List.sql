-- Function: lfSelect_Object_Unit_List (Integer)

-- DROP FUNCTION lfSelect_Object_Unit_List (Integer);

CREATE OR REPLACE FUNCTION lfSelect_Object_Unit_List (IN inUnitId Integer)
RETURNS TABLE  (UnitId Integer)  
AS
$BODY$
BEGIN

    RETURN QUERY
    WITH RecurObjectLink (ObjectId, ChildObjectId, Code) AS
    (
    	SELECT sc.ObjectId, sc.ChildObjectId FROM ObjectLink sc 
    	UNION ALL
    	SELECT sc.ObjectId, sc.ChildObjectId FROM ObjectLink sc 
    		INNER JOIN RecurObjectLink rs ON rs.ChildObjectId = sc.ObjectId
    	WHERE sc.DescId = zc_ObjectLink_Unit_Parent()
    )
     SELECT ObjectLink_0.ObjectId AS UnitId 
     FROM ObjectLink 
        LEFT JOIN RecurObjectLink ON ObjectLink.ChildObjectId = RecurObjectLink.ObjectId  
                                 AND RecurObjectLink.ChildObjectId = inUnitId
     WHERE ObjectLink.DescId = zc_ObjectLink_Unit_Parent();

END;
$BODY$

LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION lfSelect_Object_Unit_List (Integer) OWNER TO postgres;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 12.09.13         *  add WITH RecurObjectLink
 09.09.13         *
*/

-- ����
-- SELECT * FROM lfSelect_Object_Unit_List (zc_Enum_UnitGroup_20000())