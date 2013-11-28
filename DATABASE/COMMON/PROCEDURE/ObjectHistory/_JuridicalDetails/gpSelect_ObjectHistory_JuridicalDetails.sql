-- Function: gpSelect_ObjectHistory_JuridicalDetails ()

DROP FUNCTION IF EXISTS gpSelect_ObjectHistory_JuridicalDetails (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_ObjectHistory_JuridicalDetails(
    IN inJuridicalId        Integer   , -- ��.���� 
    IN inSession            TVarChar    -- ������ ������������
)                              
RETURNS TABLE (Id Integer, StartDate TDateTime, BankName TVarChar, BankId Integer,
               FullName TVarChar, JuridicalAddress TVarChar, OKPO TVarChar, INN TVarChar, 
               NumberVAT TVarChar, AccounterName TVarChar, BankAccount  TVarChar)
AS
$BODY$
BEGIN

     -- �������� ������
     RETURN QUERY 
       SELECT
             ObjectHistory_JuridicalDetails.Id
           , ObjectHistory_JuridicalDetails.StartDate
           , Object_Bank.ValueData AS BankName
           , Object_Bank.Id        AS BankId
           , ObjectHistoryString_JuridicalDetails_FullName.ValueData AS FullName
           , ObjectHistoryString_JuridicalDetails_JuridicalAddress.ValueData AS JuridicalAddress
           , ObjectHistoryString_JuridicalDetails_OKPO.ValueData AS OKPO
           , ObjectHistoryString_JuridicalDetails_INN.ValueData AS INN
           , ObjectHistoryString_JuridicalDetails_NumberVAT.ValueData AS NumberVAT
           , ObjectHistoryString_JuridicalDetails_AccounterName.ValueData AS AccounterName
           , ObjectHistoryString_JuridicalDetails_BankAccount.ValueData AS BankAccount

       FROM ObjectHistory AS ObjectHistory_JuridicalDetails

  LEFT JOIN ObjectHistoryLink AS ObjectHistoryLink_JuridicalDetails_Bank
         ON ObjectHistoryLink_JuridicalDetails_Bank.ObjectHistoryId = ObjectHistory_JuridicalDetails.Id
        AND ObjectHistoryLink_JuridicalDetails_Bank.DescId = zc_ObjectHistoryLink_JuridicalDetails_Bank()
  LEFT JOIN Object AS Object_Bank ON Object_Bank.Id = ObjectHistoryLink_JuridicalDetails_Bank.ObjectId
  LEFT JOIN ObjectHistoryString AS ObjectHistoryString_JuridicalDetails_FullName
         ON ObjectHistoryString_JuridicalDetails_FullName.ObjectHistoryId = ObjectHistory_JuridicalDetails.Id
        AND ObjectHistoryString_JuridicalDetails_FullName.DescId = zc_ObjectHistoryString_JuridicalDetails_FullName()
  LEFT JOIN ObjectHistoryString AS ObjectHistoryString_JuridicalDetails_JuridicalAddress
         ON ObjectHistoryString_JuridicalDetails_JuridicalAddress.ObjectHistoryId = ObjectHistory_JuridicalDetails.Id
        AND ObjectHistoryString_JuridicalDetails_JuridicalAddress.DescId = zc_ObjectHistoryString_JuridicalDetails_JuridicalAddress()
  LEFT JOIN ObjectHistoryString AS ObjectHistoryString_JuridicalDetails_OKPO
         ON ObjectHistoryString_JuridicalDetails_OKPO.ObjectHistoryId = ObjectHistory_JuridicalDetails.Id
        AND ObjectHistoryString_JuridicalDetails_OKPO.DescId = zc_ObjectHistoryString_JuridicalDetails_OKPO()
  LEFT JOIN ObjectHistoryString AS ObjectHistoryString_JuridicalDetails_INN
         ON ObjectHistoryString_JuridicalDetails_INN.ObjectHistoryId = ObjectHistory_JuridicalDetails.Id
        AND ObjectHistoryString_JuridicalDetails_INN.DescId = zc_ObjectHistoryString_JuridicalDetails_INN()
  LEFT JOIN ObjectHistoryString AS ObjectHistoryString_JuridicalDetails_NumberVAT
         ON ObjectHistoryString_JuridicalDetails_NumberVAT.ObjectHistoryId = ObjectHistory_JuridicalDetails.Id
        AND ObjectHistoryString_JuridicalDetails_NumberVAT.DescId = zc_ObjectHistoryString_JuridicalDetails_NumberVAT()
  LEFT JOIN ObjectHistoryString AS ObjectHistoryString_JuridicalDetails_AccounterName
         ON ObjectHistoryString_JuridicalDetails_AccounterName.ObjectHistoryId = ObjectHistory_JuridicalDetails.Id
        AND ObjectHistoryString_JuridicalDetails_AccounterName.DescId = zc_ObjectHistoryString_JuridicalDetails_AccounterName()
  LEFT JOIN ObjectHistoryString AS ObjectHistoryString_JuridicalDetails_BankAccount
         ON ObjectHistoryString_JuridicalDetails_BankAccount.ObjectHistoryId = ObjectHistory_JuridicalDetails.Id
        AND ObjectHistoryString_JuridicalDetails_BankAccount.DescId = zc_ObjectHistoryString_JuridicalDetails_BankAccount()

       WHERE ObjectHistory_JuridicalDetails.ObjectId = inJuridicalId
         AND ObjectHistory_JuridicalDetails.DescId = zc_ObjectHistory_JuridicalDetails()
;

END;
$BODY$

LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION gpSelect_ObjectHistory_JuridicalDetails (Integer, TVarChar) OWNER TO postgres;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 28.11.13                        *
*/

-- ����
-- SELECT * FROM gpSelect_ObjectHistory_JuridicalDetails (zc_PriceList_ProductionSeparate(), CURRENT_TIMESTAMP)