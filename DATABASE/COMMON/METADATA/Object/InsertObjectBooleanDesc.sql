--------------------------- !!!!!!!!!!!!!!!!!!!
--------------------------- !!! ����� ����� !!!
--------------------------- !!!!!!!!!!!!!!!!!!!
INSERT INTO ObjectBooleanDesc (DescId, Code, ItemName)
  SELECT zc_Object_Juridical(), 'zc_ObjectBoolean_Juridical_isCorporate', '������� ���� �� ������������� ��� ����������� ����' WHERE NOT EXISTS (SELECT * FROM ObjectBooleanDesc WHERE Code = 'zc_ObjectBoolean_Juridical_isCorporate');  
INSERT INTO ObjectBooleanDesc (DescId, Code, ItemName)
  SELECT zc_Object_ProfitLoss(), 'zc_ObjectBoolean_ProfitLoss_onComplete', '������� ������ ��� ����������' WHERE NOT EXISTS (SELECT * FROM ObjectBooleanDesc WHERE Code = 'zc_ObjectBoolean_ProfitLoss_onComplete');  
INSERT INTO ObjectBooleanDesc (DescId, Code, ItemName)
  SELECT zc_Object_Account(), 'zc_ObjectBoolean_Account_onComplete', '������� ������ ��� ����������' WHERE NOT EXISTS (SELECT * FROM ObjectBooleanDesc WHERE Code = 'zc_ObjectBoolean_Account_onComplete');  

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 28.06.13                                        * ����� �����
*/
