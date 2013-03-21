﻿-- Function: gpInsertUpdate_Object_Currency()

-- DROP FUNCTION gpInsertUpdate_Object_Currency();

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_Currency(
INOUT ioId               Integer   ,   	/* ключ объекта <Валюта> */
IN inCurrencyCode        Integer   ,    /* Международный код объекта <Валюта> */
IN inCurrencyName        TVarChar  ,    /* Международное название объекта <Валюта> */
IN inFullName            TVarChar  ,    /* Полное объекта <Валюта> */
IN inSession             TVarChar       /* текущий пользователь */
)
  RETURNS integer AS
$BODY$BEGIN
--   PERFORM lpCheckRight(inSession, zc_Enum_Process_Currency());

   PERFORM lpCheckUnique_Object_ValueData(ioId, zc_Object_Currency(), inCurrencyName);

   ioId := lpInsertUpdate_Object(ioId, zc_Object_Currency(), inCurrencyCode, inCurrencyName);
   
   PERFORM lpInsertUpdate_ObjectString(zc_objectString_Currency_FullName(), ioId, inFullName);


END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION gpInsertUpdate_Object_Currency(Integer, Integer, TVarChar, TVarChar, tvarchar)
  OWNER TO postgres;

  
                            