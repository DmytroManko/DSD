-- View: PersonalMember_View

DROP VIEW IF EXISTS PersonalMember_View;
/*
CREATE OR REPLACE VIEW PersonalMember_View AS 
      SELECT ObjectMember.*,
             ObjectLink_Personal_Member.ObjectId AS PersonalId
        FROM object AS ObjectMember
        JOIN ObjectLink AS ObjectLink_Personal_Member
          ON ObjectLink_Personal_Member.ChildObjectId = ObjectMember.Id
         AND ObjectLink_Personal_Member.DescId = zc_ObjectLink_Personal_Member()
       WHERE ObjectMember.descid = zc_object_Member();

ALTER TABLE PersonalMember_View
  OWNER TO postgres;
*/

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 30.09.13                                        *
*/

-- ����
-- SELECT * FROM PersonalMember_View