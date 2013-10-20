-- Function: gpInsertUpdate_Object_Contract()

DROP FUNCTION IF EXISTS gpInsertUpdate_Object_Contract (Integer, TVarChar, TDateTime, TDateTime, TDateTime, TFloat, TFloat, TVarChar, Integer, Integer, Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_Contract(
 INOUT ioId             Integer,       -- ���� ������� <�������>
    IN inInvNumber      TVarChar,      -- ����� ��������
    IN inSigningDate    TDateTime,     -- �������� ���� ���������� ��������
    IN inStartDate      TDateTime,     -- �������� ���� � ������� ��������� �������
    IN inEndDate        TDateTime,     -- �������� ���� �� ������� ��������� �������    
    IN inChangePercent  TFloat   ,     -- (-)% ������ (+)% ������� 
    IN inChangePrice    TFloat   ,     -- ������ � ����
    IN inComment        TVarChar,      -- �����������
    IN inJuridicalId    Integer  ,     -- ����������� ����
    IN inInfoMoneyId    Integer  ,     -- ������ ����������
    IN inContractKindId Integer  ,     -- ���� ���������
    IN inPaidKindId     Integer  ,     -- ���� ���� ������
    IN inSession        TVarChar       -- ������ ������������
)
RETURNS Integer AS
$BODY$
   DECLARE UserId Integer;

BEGIN

   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Contract());
   UserId := inSession;

   -- �������� ������������ ��� �������� <����� ��������>
   PERFORM lpCheckUnique_ObjectString_ValueData (ioId, zc_ObjectString_Contract_InvNumber(), inInvNumber);

   -- ��������� <������>
   ioId := lpInsertUpdate_Object (ioId, zc_Object_Contract(), 0, inInvNumber);

   -- ��������� �������� <����� ��������>
   -- PERFORM lpInsertUpdate_ObjectString (zc_ObjectString_Contract_InvNumber(), ioId, inInvNumber);

   -- ��������� �������� <>
   PERFORM lpInsertUpdate_ObjectDate (zc_ObjectDate_Contract_Signing(), ioId, inSigningDate);
   -- ��������� �������� <>
   PERFORM lpInsertUpdate_ObjectDate (zc_ObjectDate_Contract_Start(), ioId, inStartDate);
   -- ��������� �������� <>
   PERFORM lpInsertUpdate_ObjectDate (zc_ObjectDate_Contract_End(), ioId, inEndDate);

   -- ��������� �������� <(-)% ������ (+)% ������� >
   PERFORM lpInsertUpdate_ObjectFloat (zc_ObjectFloat_Contract_ChangePercent(), ioId, inChangePercent);
   -- ��������� �������� <������ � ����>
   PERFORM lpInsertUpdate_ObjectFloat (zc_ObjectFloat_Contract_ChangePrice(), ioId, inChangePrice);

   -- ��������� �������� <�����������>
   PERFORM lpInsertUpdate_ObjectString (zc_ObjectString_Contract_Comment(), ioId, inComment);

   -- ��������� ����� � <����������� ����>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Contract_Juridical(), ioId, inJuridicalId);
   -- ��������� ����� � <������ ����������>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Contract_InfoMoney(), ioId, inInfoMoneyId);
   -- ��������� ����� � <���� ���������>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Contract_ContractKind(), ioId, inContractKindId);
   -- ��������� ����� � <���� ���� ������>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Contract_PaidKind(), ioId, inPaidKindId);


   -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (ioId, UserId);

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 20.10.13                                        * add from redmaine
 19.10.13                                        * del zc_ObjectString_Contract_InvNumber()
 22.07.13         * add  SigningDate, StartDate, EndDate              
 12.04.13                                        *
 16.06.13                                        * �������
*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_Contract ()
