﻿-- Function: gpGet_Object_User()

--DROP FUNCTION gpGet_Object_User();

CREATE OR REPLACE FUNCTION gpGet_Object_User(
IN inId          Integer,       /* пользователь */
IN inSession     TVarChar       /* текущий пользователь */)
RETURNS TABLE (Id Integer, Code Integer, Name TVarChar, Login TVarChar, Password TVarChar, isErased boolean) AS
$BODY$BEGIN

   PERFORM lpCheckRight(inSession, zc_Object_Process_User());

   RETURN QUERY 
   SELECT 
     Object.Id
   , Object.ObjectCode
   , Object.ValueData
   , ObjectString_UserLogin.ValueData
   , ObjectString_UserPassword.ValueData
   , Object.isErased
   FROM Object
   LEFT JOIN ObjectString AS ObjectString_UserLogin 
          ON ObjectString_UserLogin.DescId = zc_ObjectString_User_Login() 
         AND ObjectString_UserLogin.ObjectId = Object.Id
   LEFT JOIN ObjectString AS ObjectString_UserPassword 
          ON ObjectString_UserPassword.DescId = zc_ObjectString_User_Password() 
         AND ObjectString_UserPassword.ObjectId = Object.Id
   WHERE Object.Id = inId;
  
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION gpGet_Object_User(integer, TVarChar)
  OWNER TO postgres;

-- SELECT * FROM gpSelect_User('2')