﻿-- Function: gpGet_Object_Branch(Integer,TVarChar)

--DROP FUNCTION gpGet_Object_Branch(Integer,TVarChar);

CREATE OR REPLACE FUNCTION gpGet_Object_Branch(
    IN inId          Integer,       -- ключ объекта <Бизнесы>
    IN inSession     TVarChar       -- сессия пользователя
)
RETURNS TABLE (Id Integer, Code Integer, Name TVarChar, isErased boolean) AS
$BODY$BEGIN

   -- проверка прав пользователя на вызов процедуры
   -- PERFORM lpCheckRight(inSession, zc_Enum_Process_User());
  
   IF COALESCE (inId, 0) = 0
   THEN
       RETURN QUERY 
       SELECT
             CAST (0 as Integer)    AS Id
           , lfGet_ObjectCode(0, zc_Object_Branch()) AS Code
           , CAST ('' as TVarChar)  AS Name
           , CAST (NULL AS Boolean) AS isErased;
   ELSE
       RETURN QUERY 
       SELECT 
             Object.Id
           , Object.ObjectCode
           , Object.ValueData
           , Object.isErased
       FROM Object
      WHERE Object.Id = inId;
   END IF;
     
END;$BODY$

LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION gpGet_Object_Branch (integer, TVarChar)
  OWNER TO postgres;


/*-------------------------------------------------------------------------------*/
/*
 ИСТОРИЯ РАЗРАБОТКИ: ДАТА, АВТОР
               Фелонюк И.В.   Кухтин И.В.   Климентьев К.И.
 10.06.13          *
 05.06.13           
*/

-- тест
-- SELECT * FROM gpGet_Object_Branch(1,'2')