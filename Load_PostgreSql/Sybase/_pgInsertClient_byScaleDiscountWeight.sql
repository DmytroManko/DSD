create PROCEDURE DBA._pgInsertClient_byScaleDiscountWeight (in @inStartDate date, in @inEndDate date)
begin

  --
  delete dba._Client_byDiscountWeight;
  --
  insert into dba._Client_byDiscountWeight (ToId, GoodsPropertyId, KindPackageId, DiscountWeight)
     select Bill.ToId, BillItems.GoodsPropertyId, BillItems.KindPackageId, max (isnull(ScaleHistory.DiscountWeight,ScaleHistory_byObvalka.DiscountWeight)) as DiscountWeight
     from dba.Bill
           left outer join dba.isUnit as isUnit_to on isUnit_to.UnitId = Bill.ToID
           left outer join dba.BillItems on BillItems.BillId=Bill.Id
           left outer join dba.ScaleHistory on ScaleHistory.Id = BillItems.ScaleHistoryId
           left outer join dba.ScaleHistory_byObvalka on ScaleHistory_byObvalka.Id = BillItems.ScaleHistoryId_byObvalka
     where  Bill.BillDate between @inStartDate and @inEndDate + 1
           and Bill.BillKind in (zc_bkSaleToClient(), zc_bkSendUnitToUnit())
           and BillItems.OperCount <> 0
           and isnull(ScaleHistory.DiscountWeight,ScaleHistory_byObvalka.DiscountWeight) <> 0
           and isUnit_to.UnitId is null
     group by Bill.ToId, BillItems.GoodsPropertyId, BillItems.KindPackageId

end
//
-- call dba._pgInsertClient_byScaleDiscountWeight ('2013-01-01', '2013-01-31')
/*
CREATE TABLE "DBA"."_Client_byDiscountWeight"
(
	ToId        		integer NOT NULL ,
	GoodsPropertyId     		integer NOT NULL ,
        KindPackageId     		integer NOT NULL ,
        DiscountWeight     		TSumm NOT NULL ,
        PRIMARY KEY (GoodsPropertyId,KindPackageId,ToId)
)
*/