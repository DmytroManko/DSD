﻿-- Function: gpInsertUpdate_Object_InfoMoneyDestination()

-- DROP FUNCTION gpInsertUpdate_Object_InfoMoneyDestination();

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_InfoMoneyDestination(
 INOUT ioId	         Integer   ,   	-- ключ  Управленческие аналитики - назначение
    IN inCode        Integer   ,    -- код
    IN inName        TVarChar  ,    -- Наименование
    IN inSession     TVarChar       -- сессия пользователя
)
  RETURNS integer AS
$BODY$
   DECLARE UserId Integer;
   DECLARE Code_calc Integer;   

BEGIN

   -- проверка прав пользователя на вызов процедуры
   -- PERFORM lpCheckRight(inSession, zc_Enum_Process_InsertUpdate_Object_InfoMoneyDestination());
   UserId := inSession;

   -- Если код не установлен, определяем его как последний+1
   Code_calc:=lfGet_ObjectCode (inCode, zc_Object_InfoMoneyDestination()); 

   -- !!! проверка прав уникальности <Наименование>
   -- !!! PERFORM lpCheckUnique_Object_ValueData(ioId, zc_Object_InfoMoneyDestination(), inName);
   -- проверка уникальности для свойства <Код>
   PERFORM lpCheckUnique_Object_ObjectCode (ioId, zc_Object_InfoMoneyDestination(), Code_calc);

   -- сохранили <Объект>
   ioId := lpInsertUpdate_Object(ioId, zc_Object_InfoMoneyDestination(), Code_calc, inName);

   -- сохранили протокол
   PERFORM lpInsert_ObjectProtocol (ioId, UserId);

END;$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpInsertUpdate_Object_InfoMoneyDestination (Integer, Integer, TVarChar, TVarChar) OWNER TO postgres;


/*-------------------------------------------------------------------------------*/
/*
 ИСТОРИЯ РАЗРАБОТКИ: ДАТА, АВТОР
               Фелонюк И.В.   Кухтин И.В.   Климентьев К.И.
 21.06.13          * gpInsertUpdate_Object_InfoMoneyDestination(); Code_calc
 19.06.13                                        * rem lpCheckUnique_Object_ValueData

*/

-- тест
-- SELECT * FROM gpInsertUpdate_Object_Contract()
