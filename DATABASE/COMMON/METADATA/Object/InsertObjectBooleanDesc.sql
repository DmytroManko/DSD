--INSERT INTO ObjectBooleanDesc (id, DescId, Code ,itemname)
--SELECT zc_ObjectBoolean_Juridical_isCorporate(), zc_Object_Juridical(), 'Juridical_isCorporate','������� ���� �� ������������� ��� ����������� ����'  WHERE NOT EXISTS (SELECT * FROM ObjectBooleanDesc WHERE Id = zc_ObjectBoolean_Juridical_isCorporate());


--------------------------- !!!!!!!!!!!!!!!!!!!
--------------------------- !!! ����� ����� !!!
--------------------------- !!!!!!!!!!!!!!!!!!!
INSERT INTO ObjectBooleanDesc (DescId, Code, ItemName)
  SELECT zc_Object_Juridical(), 'zc_ObjectBoolean_Juridical_isCorporate', '������� ���� �� ������������� ��� ����������� ����' WHERE NOT EXISTS (SELECT * FROM ObjectBooleanDesc WHERE Code = 'zc_ObjectBoolean_Juridical_isCorporate');  
INSERT INTO ObjectBooleanDesc (DescId, Code, ItemName)
  SELECT zc_Object_ProfitLoss(), 'zc_ObjectBoolean_ProfitLoss_onComplete', '������� ������ ��� ����������' WHERE NOT EXISTS (SELECT * FROM ObjectBooleanDesc WHERE Code = 'zc_ObjectBoolean_ProfitLoss_onComplete');  

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 28.06.13                                        * ����� �����
*/
