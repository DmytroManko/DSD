﻿/*
  Создание 
    - таблицы ObjectBLOBDesc (свойства классов oбъектов типа TVarChar)
    - связи
    - индексов
*/

/*-------------------------------------------------------------------------------*/

CREATE TABLE ObjectBLOBDesc(
   Id                    INTEGER NOT NULL PRIMARY KEY,
   ObjectDescId          INTEGER NOT NULL,
   Code                  TVarChar NOT NULL UNIQUE,
   ItemName              TVarChar,
   CONSTRAINT fk_ObjectBLOBDesc_ObjectDescId FOREIGN KEY(ObjectDescId) REFERENCES ObjectDesc(Id));

/*-------------------------------------------------------------------------------*/
/*                                  Индексы                                      */


/*
 ПРИМЕЧАНИЯ:
 ИСТОРИЯ РАЗРАБОТКИ:
 ДАТА         АВТОР
 ----------------
                 Климентьев К.И.   Кухтин И.В.
14.06.02                                      
*/
