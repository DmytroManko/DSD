﻿INSERT INTO ObjectBooleanDesc (id, DescId, Code ,itemname)
SELECT zc_ObjectBoolean_Juridical_isCorporate(), zc_Object_Juridical(), 'Juridical_isCorporate','Признак наша ли собственность это юридическое лицо'  WHERE NOT EXISTS (SELECT * FROM ObjectBooleanDesc WHERE Id = zc_ObjectBoolean_Juridical_isCorporate());

INSERT INTO ObjectBooleanDesc (id, DescId, Code ,itemname)
SELECT zc_ObjectBoolean_Goods_isReceiptNeed(), zc_Object_Goods(), 'Goods_isReceiptNeed','Признак нужен ли рецепт'  WHERE NOT EXISTS (SELECT * FROM ObjectBooleanDesc WHERE Id = zc_ObjectBoolean_Goods_isReceiptNeed());
