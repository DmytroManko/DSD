INSERT INTO ObjectDateDesc (DescId, Code, ItemName)
  SELECT zc_Object_Personal(), 'zc_ObjectDate_Personal_DateIn', '���� �������� � ����������' WHERE NOT EXISTS (SELECT * FROM ObjectDateDesc WHERE Code = 'zc_ObjectDate_Personal_DateIn');
INSERT INTO ObjectDateDesc (DescId, Code, ItemName)
  SELECT zc_Object_Personal(), 'zc_ObjectDate_Personal_DateOut', '���� ���������� � ����������' WHERE NOT EXISTS (SELECT * FROM ObjectDateDesc WHERE Code = 'zc_ObjectDate_Personal_DateOut');
INSERT INTO ObjectDateDesc (DescId, Code, ItemName)
  SELECT zc_Object_Personal(), 'zc_ObjectDate_PartionGoods_Date', '���� ������ ������' WHERE NOT EXISTS (SELECT * FROM ObjectDateDesc WHERE Code = 'zc_ObjectDate_PartionGoods_Date');


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 01.07.13         *
*/
