--------------------------- !!!!!!!!!!!!!!!!!!!
--------------------------- !!! ����� ����� !!!
--------------------------- !!!!!!!!!!!!!!!!!!!
CREATE OR REPLACE FUNCTION zc_MovementBoolean_PriceWithVAT() RETURNS integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementBooleanDesc WHERE Code = 'zc_MovementBoolean_PriceWithVAT'); END;  $BODY$ LANGUAGE plpgsql IMMUTABLE;
INSERT INTO MovementBooleanDesc (Code ,itemname)
  SELECT 'zc_MovementBoolean_PriceWithVAT','���� � ��� (��/���)'  WHERE NOT EXISTS (SELECT * FROM MovementBooleanDesc WHERE Code= 'zc_MovementBoolean_PriceWithVAT');

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.

 07.07.13         * ����� �����
*/

