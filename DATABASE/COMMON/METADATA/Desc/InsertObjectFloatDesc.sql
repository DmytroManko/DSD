﻿INSERT INTO ObjectFloatDesc (id, DescId, Code ,itemname)
SELECT zc_ObjectFloat_Goods_Weight(), zc_Object_Goods(), 'Goods_Weight','Вес товара' WHERE NOT EXISTS (SELECT * FROM ObjectFloatDesc WHERE Id = zc_ObjectFloat_Goods_Weight());
