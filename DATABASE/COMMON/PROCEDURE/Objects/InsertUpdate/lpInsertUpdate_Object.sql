-- Function: lpInsertUpdate_Object() - ������ �� �� ....

-- DROP FUNCTION lpInsertUpdate_Object (INOUT ioId Integer, IN inDescId Integer, IN inObjectCode Integer, IN inValueData TVarChar);

CREATE OR REPLACE FUNCTION lpInsertUpdate_Object(
 INOUT ioId           Integer   ,    -- <���� �������>
    IN inDescId       Integer   , 
    IN inObjectCode   Integer   , 
    IN inValueData    TVarChar
)
AS
$BODY$
BEGIN
   IF COALESCE (ioId, 0) = 0 THEN
      -- �������� ����� ������� ����������� � ������� �������� <���� �������>
      INSERT INTO Object (DescId, ObjectCode, ValueData)
                  VALUES (inDescId, inObjectCode, inValueData) RETURNING Id INTO ioId;
   ELSE
       -- �������� ������� ����������� �� �������� <���� �������>
       UPDATE Object SET ObjectCode = inObjectCode, ValueData = inValueData WHERE Id = ioId AND DescId = inDescId;

       -- ���� ����� ������� �� ��� ������
       IF NOT FOUND THEN
          -- �������� ����� ������� ����������� �� ��������� <���� �������>
          INSERT INTO Object (Id, DescId, ObjectCode, ValueData)
                     VALUES (ioId, inDescId, inObjectCode, inValueData);
       END IF; -- if NOT FOUND

   END IF; -- if COALESCE (ioId, 0) = 0

END;$BODY$ LANGUAGE plpgsql;
ALTER FUNCTION lpInsertUpdate_Object (Integer, Integer, Integer, TVarChar) OWNER TO postgres; 


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 28.06.13                                        * add AND DescId = inDescId

*/

-- ����
-- SELECT * FROM lpInsertUpdate_Object (0, zc_Object_Goods(), -1, 'test-goods');
