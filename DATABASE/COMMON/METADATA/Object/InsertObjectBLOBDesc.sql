INSERT INTO ObjectBLOBDesc (id, DescId, Code ,itemname)
SELECT zc_objectBlob_form_Data(), zc_object_Form(), 'FormData','������ �����' WHERE NOT EXISTS (SELECT * FROM ObjectBlobDesc WHERE Id = zc_objectBlob_form_Data());

INSERT INTO ObjectBLOBDesc (id, DescId, Code ,itemname)
SELECT zc_ObjectBlob_UserFormSettings_Data(), zc_object_UserFormSettings(), 'UserFormSettings_Data','���������������� ������ �����' WHERE NOT EXISTS (SELECT * FROM ObjectBlobDesc WHERE Id = zc_objectBlob_UserFormSettings_Data());


--------------------------- !!!!!!!!!!!!!!!!!!!
--------------------------- !!! ����� ����� !!!
--------------------------- !!!!!!!!!!!!!!!!!!!
/*
INSERT INTO ObjectBLOBDesc (DescId, Code ,itemname)
  SELECT zc_object_Form(), 'zc_objectBlob_form_Data','������ �����' WHERE NOT EXISTS (SELECT * FROM ObjectBlobDesc WHERE Code = 'zc_objectBlob_form_Data');

INSERT INTO ObjectBLOBDesc (DescId, Code ,itemname)
  SELECT zc_object_UserFormSettings(), 'zc_ObjectBlob_UserFormSettings_Data','���������������� ������ �����' WHERE NOT EXISTS (SELECT * FROM ObjectBlobDesc WHERE Code = 'zc_ObjectBlob_UserFormSettings_Data');
*/

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 07.07.13         * ����� �����   
 28.06.13                                        * ����� �����
*/
