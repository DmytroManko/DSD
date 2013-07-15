﻿-- Function: gpInsertUpdate_Movement_SendPrice()

-- DROP FUNCTION gpInsertUpdate_Movement_SendPrice();

CREATE OR REPLACE FUNCTION gpInsertUpdate_Movement_SendPrice(
 INOUT ioId                  Integer   , -- Ключ объекта <Документ Перемещение>
    IN inInvNumber           TVarChar  , -- Номер документа
    IN inOperDate            TDateTime , -- Дата документа

    IN inOperDatePartner     TDateTime , -- Дата накладной у контрагента

    IN inPriceWithVAT        Boolean   , -- Цена с НДС (да/нет)
    IN inVATPercent          TFloat    , -- % НДС
    IN inChangePercent       TFloat    , -- (-)% Скидки (+)% Наценки 
    IN inFromId              Integer   , -- От кого (в документе)
    IN inToId                Integer   , -- Кому (в документе)
    IN inCarId               Integer   , -- Автомобили
    IN inPersonalDriverId    Integer   , -- Сотрудник (водитель)
    IN inRouteId             Integer   , -- Маршрут
    IN inRouteSortingId      Integer   , -- Сортировки маршрутов
    IN inSession             TVarChar    -- сессия пользователя
)                              
RETURNS Integer AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN

     -- проверка прав пользователя на вызов процедуры
     -- PERFORM lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_Movement_Send());
     vbUserId := inSession;

     -- сохранили <Документ>
     ioId := lpInsertUpdate_Movement (ioId, zc_Movement_Send(), inInvNumber, inOperDate, NULL);

     -- сохранили свойство <Дата накладной у контрагента>
     PERFORM lpInsertUpdate_MovementDate (zc_MovementDate_OperDatePartner(), ioId, inOperDatePartner);

     -- сохранили свойство <Цена с НДС (да/нет)>
     PERFORM lpInsertUpdate_MovementBoolean (zc_MovementBoolean_PriceWithVAT(), ioId, inPriceWithVAT);
     -- сохранили свойство <% НДС>
     PERFORM lpInsertUpdate_MovementFloat (zc_MovementFloat_VATPercent(), ioId, inVATPercent);
     -- сохранили свойство <(-)% Скидки (+)% Наценки >
     PERFORM lpInsertUpdate_MovementFloat (zc_MovementFloat_ChangePercent(), ioId, inChangePercent);

     -- сохранили связь с <От кого (в документе)>
     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_From(), ioId, inFromId);
     -- сохранили связь с <Кому (в документе)>
     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_To(), ioId, inToId);

     -- сохранили связь с <Автомобили>
     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_Car(), ioId, inCarId);

     -- сохранили связь с <Сотрудник (водитель)>
     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_PersonalDriver(), ioId, inPersonalDriverId);

     -- сохранили связь с <Маршруты>
     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_Route(), ioId, inRouteId);
     -- сохранили связь с <Сортировки маршрутов>
     PERFORM lpInsertUpdate_MovementLinkObject (zc_MovementLinkObject_RouteSorting(), ioId, inRouteSortingId);

     -- пересчитали Итоговые суммы по накладной
     PERFORM lpInsertUpdate_MovementFloat_TotalSumm (ioId);
   
     -- сохранили протокол
     -- PERFORM lpInsert_MovementProtocol (ioId, vbUserId);

END;
$BODY$
LANGUAGE PLPGSQL VOLATILE;


/*
 ИСТОРИЯ РАЗРАБОТКИ: ДАТА, АВТОР
               Фелонюк И.В.   Кухтин И.В.   Климентьев К.И.
 12.07.13         *

*/

-- тест
-- SELECT * FROM gpInsertUpdate_Movement_SendPrice (ioId:= 0, inInvNumber:= '-1', inOperDate:= '01.01.2013', inOperDatePartner:= '01.01.2013', inInvNumberPartner:= 'xxx', inPriceWithVAT:= true, inVATPercent:= 20, inChangePercent:= 0, inFromId:= 1, inToId:= 2, inPaidKindId:= 1, inContractId:= 0, inCarId:= 0, inPersonalDriverId:= 0, inPersonalPackerId:= 0, inSession:= '2')
