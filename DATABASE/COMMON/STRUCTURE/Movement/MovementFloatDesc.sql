/*
  �������� 
    - ������� MovementFloatDesc (�������� ������� o������� ���� TFloat)
    - �����
    - ��������
*/

/*-------------------------------------------------------------------------------*/

CREATE TABLE MovementFloatDesc(
   Id                    SERIAL NOT NULL PRIMARY KEY, 
   Code                  TVarChar,
   ItemName              TVarChar
)

/*-------------------------------------------------------------------------------*/

/*                                  �������                                      */


/*-------------------------------------------------------------------------------
 ����������:
 ������� ����������:
 ����         �����
 ----------------
                 ���������� �.�.   ������ �.�.   
 29.06.13             * SERIAL
*/
