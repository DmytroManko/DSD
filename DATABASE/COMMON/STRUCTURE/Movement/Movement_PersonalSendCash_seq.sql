-- Sequence: Movement_PersonalSendCash_seq

-- DROP SEQUENCE Movement_PersonalSendCash_seq;

CREATE SEQUENCE Movement_PersonalSendCash_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE Movement_PersonalSendCash_seq
  OWNER TO postgres;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 23.10.13                                        *
*/
