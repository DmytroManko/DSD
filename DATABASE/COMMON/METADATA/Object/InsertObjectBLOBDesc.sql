INSERT INTO ObjectBLOBDesc (DescId, Code ,itemname)
SELECT zc_object_Form(), 'zc_objectBlob_form_Data','������ �����' WHERE NOT EXISTS (SELECT * FROM ObjectBlobDesc WHERE Code = 'zc_objectBlob_form_Data');

INSERT INTO ObjectBLOBDesc (DescId, Code ,itemname)
SELECT zc_object_UserFormSettings(), 'zc_objectBlob_UserFormSettings_Data','���������������� ������ �����' WHERE NOT EXISTS (SELECT * FROM ObjectBlobDesc WHERE Code = 'zc_objectBlob_UserFormSettings_Data');


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 07.07.13         ���-�� � ���� �� ���������� ��������� �� ����� ����� 
 28.06.13                                        * ����� �����
*/
