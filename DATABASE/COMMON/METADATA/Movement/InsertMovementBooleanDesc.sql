INSERT INTO MovementBooleanDesc (id, Code ,itemname)
SELECT zc_MovementBoolean_PriceWithVAT(), 'PriceWithVAT','���� � ��� (��/���)'  WHERE NOT EXISTS (SELECT * FROM MovementBooleanDesc WHERE Id = zc_MovementBoolean_PriceWithVAT());

	
--------------------------- !!!!!!!!!!!!!!!!!!!
--------------------------- !!! ����� ����� !!!
--------------------------- !!!!!!!!!!!!!!!!!!!
