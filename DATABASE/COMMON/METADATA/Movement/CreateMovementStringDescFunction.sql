--------------------------- !!!!!!!!!!!!!!!!!!!
--------------------------- !!! ����� ����� !!!
--------------------------- !!!!!!!!!!!!!!!!!!!

CREATE OR REPLACE FUNCTION zc_MovementString_InvNumberPartner() RETURNS Integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementStringDesc WHERE Code = 'zc_MovementString_InvNumberPartner'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.

 30.06.13                                        * ����� �����
*/
