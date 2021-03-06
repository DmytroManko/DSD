-- Function: gpInsertUpdate_Object_Contract()

DROP FUNCTION IF EXISTS gpInsertUpdate_Object_Contract (Integer, Integer, TVarChar, TVarChar, TVarChar, TDateTime, TDateTime, TDateTime, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_Contract(
 INOUT ioId                  Integer,       -- ���� ������� <�������>
    IN inCode                Integer,       -- ���
    IN inInvNumber           TVarChar,      -- ����� ��������
    IN inInvNumberArchive    TVarChar,      -- ����� �������������
    IN inComment             TVarChar,      -- �����������
    
    IN inSigningDate         TDateTime,     -- �������� ���� ���������� ��������
    IN inStartDate           TDateTime,     -- �������� ���� � ������� ��������� �������
    IN inEndDate             TDateTime,     -- �������� ���� �� ������� ��������� �������    
    
    IN inJuridicalId         Integer  ,     -- ����������� ����
    IN inInfoMoneyId         Integer  ,     -- ������ ����������
    IN inContractKindId      Integer  ,     -- ���� ���������
    IN inPaidKindId          Integer  ,     -- ���� ���� ������
    
    IN inPersonalId          Integer  ,     -- ���������� (������������ ����)
    IN inAreaId              Integer  ,     -- ������
    IN inContractArticleId   Integer  ,     -- ������� ��������
    IN inContractStateKindId Integer  ,     -- ��������� ��������
    
    IN inSession          TVarChar       -- ������ ������������
)
RETURNS Integer AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbCode_calc Integer;   
BEGIN

   -- �������� ���� ������������ �� ����� ���������
   -- vbUserId := PERFORM lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_Object_Contract());
   vbUserId := inSession;

   IF ioId <> 0 
        -- �������� ����� ���
   THEN vbCode_calc := (SELECT ObjectCode FROM Object WHERE Id = ioId); 
        -- �����, ���������� ��� ��� ���������+1
   ELSE vbCode_calc:=lfGet_ObjectCode (vbCode_calc, zc_Object_Contract()); 
   END IF;


   -- �������� ������������ ��� �������� <����� ��������>
   PERFORM lpCheckUnique_Object_ValueData(ioId, zc_Object_Contract(), inInvNumber);

   -- ��������� <������>
   ioId := lpInsertUpdate_Object (ioId, zc_Object_Contract(), vbCode_calc, inInvNumber);

   -- ��������� �������� <����� ��������>
   -- PERFORM lpInsertUpdate_ObjectString (zc_ObjectString_Contract_InvNumber(), ioId, inInvNumber);

   -- ��������� �������� <>
   PERFORM lpInsertUpdate_ObjectDate (zc_ObjectDate_Contract_Signing(), ioId, inSigningDate);
   -- ��������� �������� <>
   PERFORM lpInsertUpdate_ObjectDate (zc_ObjectDate_Contract_Start(), ioId, inStartDate);
   -- ��������� �������� <>
   PERFORM lpInsertUpdate_ObjectDate (zc_ObjectDate_Contract_End(), ioId, inEndDate);

   -- ��������� �������� <����� �������������>
   PERFORM lpInsertUpdate_ObjectString (zc_ObjectString_Contract_InvNumberArchive(), ioId, inInvNumberArchive);

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

   -- ��������� ����� � <���������� (������������ ����)>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Contract_Personal(), ioId, inPersonalId);
   -- ��������� ����� � <������>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Contract_Area(), ioId, inAreaId);
   -- ��������� ����� � <������� ��������>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Contract_ContractArticle(), ioId, inContractArticleId);
   -- ��������� ����� � <��������� ��������>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Contract_ContractStateKind(), ioId, inContractStateKindId);   
   
   -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (ioId, vbUserId);

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 14.11.13         * add from redmaine               
 21.10.13                                        * add vbCode_calc
 20.10.13                                        * add from redmaine
 19.10.13                                        * del zc_ObjectString_Contract_InvNumber()
 22.07.13         * add  SigningDate, StartDate, EndDate              
 12.04.13                                        *
 16.06.13                                        * �������
*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_Contract ()
