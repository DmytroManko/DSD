INSERT INTO ObjectDateDesc (DescId, Code, ItemName)
  SELECT zc_Object_Personal(), 'zc_ObjectDate_Personal_DateIn', '���� �������� � ����������' WHERE NOT EXISTS (SELECT * FROM ObjectDateDesc WHERE Code = 'zc_ObjectDate_Personal_DateIn');
INSERT INTO ObjectDateDesc (DescId, Code, ItemName)
  SELECT zc_Object_Personal(), 'zc_ObjectDate_Personal_DateOut', '���� ���������� � ����������' WHERE NOT EXISTS (SELECT * FROM ObjectDateDesc WHERE Code = 'zc_ObjectDate_Personal_DateOut');


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 01.07.13         *
*/
