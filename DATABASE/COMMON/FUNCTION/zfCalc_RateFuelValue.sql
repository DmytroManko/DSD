-- Function: zfCalc_RateFuelValue

-- DROP FUNCTION zfCalc_RateFuelValue (TFloat, TFloat, TFloat, TFloat, TFloat, TFloat, TFloat);

CREATE OR REPLACE FUNCTION zfCalc_RateFuelValue(
    IN inDistance            TFloat    , -- ���������� ���� ��
    IN inAmountFuel          TFloat    , -- ���-�� ����� �� 100 ��
    IN inColdHour            TFloat    , -- �����, ���-�� ���� �����
    IN inAmountColdHour      TFloat    , -- �����, ���-�� ����� � ���
    IN inColdDistance        TFloat    , -- �����, ���-�� ���� ��
    IN inAmountColdDistance  TFloat    , -- �����, ���-�� ����� �� 100 ��
    IN inRateFuelKindTax     TFloat      -- % ��������������� ������� � ����� � �������/������������
)
RETURNS TFloat AS
$BODY$
  DECLARE vbValue TFloat;
BEGIN

     vbValue := (-- ��� ���������� / 100
                 (COALESCE (inDistance, 0) / 100) * COALESCE (inAmountFuel, 0)
                 -- ��� �����, �����
               + COALESCE (inColdHour, 0) * COALESCE (inAmountColdHour, 0)
                 -- ��� �����, �� / 100
               + (COALESCE (inColdDistance, 0) / 100) * COALESCE (inAmountColdDistance, 0)
                )
                 -- ��������� % ��������������� ������� � ����� � �������/������������
              * (1 + COALESCE (inRateFuelKindTax, 0) / 100)
     ;
     
     RETURN (vbValue);

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION zfCalc_RateFuelValue (TFloat, TFloat, TFloat, TFloat, TFloat, TFloat, TFloat) OWNER TO postgres;


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 01.10.13                                        *
*/
/*
-- ����
SELECT * FROM zfCalc_RateFuelValue (inDistance           := 100
                                  , inAmountFuel         := 10
                                  , inColdHour           := 20
                                  , inAmountColdHour     := 10
                                  , inColdDistance       := 100
                                  , inAmountColdDistance := 30
                                  , inRateFuelKindTax    := 10)
*/