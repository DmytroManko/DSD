-- Function: gpSelect_MI_ProductionUnion()

--DROP FUNCTION gpSelect_MI_ProductionUnion();

CREATE OR REPLACE FUNCTION gpSelect_MI_ProductionUnion(
    IN inMovementId          Integer,       
    IN inShowAll             Boolean,
    IN inSession             TVarChar       -- ������ ������������
)
RETURNS SETOF refcursor AS
$BODY$
  DECLARE Cursor1 refcursor;
  DECLARE Cursor2 refcursor;
BEGIN

   --PERFORM lpCheckRight(inSession, zc_Enum_Process_Select_MovementItem_ProductionUnion());

    OPEN Cursor1 FOR 
        SELECT 
              MovementItem.Id
            , MovementItem.ObjectId
            , Object_Goods.ObjectCode  AS GoodsCode
            , Object_Goods.ValueData   AS GoodsName
          
            , MovementItem.Amount      AS Amount
            , MIBoolean_PartionClose.ValueData AS PartionClose
            , MIString_Comment.ValueData AS Comment
            , MIFloat_Count.ValueData    AS COUNT
            , MIFloat_RealWeight.ValueData AS RealWeight
            , Object_Receipt.ValueData AS ReceiptName
          
            , MIFloat_Count.ValueData AS Count
            
            , MIFloat_CuterCount.ValueData AS CuterCount
          
            
            , MovementItem.isErased    AS isErased
            
        FROM MovementItem 
             LEFT JOIN Object AS Object_Goods ON Object_Goods.Id = MovementItem.ObjectId
             LEFT JOIN MovementItemLinkObject AS MILinkObject_Receipt
                                              ON MILinkObject_Receipt.MovementItemId = MovementItem.Id 
                                             AND MILinkObject_Receipt.DescId = zc_MILinkObject_Receipt()
                                             
             LEFT JOIN Object AS Object_Receipt ON Object_Receipt.Id = MILinkObject_Receipt.ObjectId

             LEFT JOIN MovementItemString AS MIString_PartionGoods
                                          ON MIString_PartionGoods.DescId = zc_MIString_PartionGoods()
                                         AND MIString_PartionGoods.MovementItemId =  MovementItem.Id

             LEFT JOIN MovementItemFloat AS MIFloat_Count
                                         ON MIFloat_Count.MovementItemId = MovementItem.Id 
                                        AND MIFloat_Count.DescId = zc_MIFloat_Count()
             LEFT JOIN MovementItemFloat AS MIFloat_RealWeight
                                         ON MIFloat_RealWeight.MovementItemId = MovementItem.Id 
                                        AND MIFloat_RealWeight.DescId = zc_MIFloat_RealWeight()
             LEFT JOIN MovementItemFloat AS MIFloat_CuterCount
                                         ON MIFloat_CuterCount.MovementItemId = MovementItem.Id 
                                        AND MIFloat_CuterCount.DescId = zc_MIFloat_CuterCount()
             LEFT JOIN MovementItemBoolean AS MIBoolean_PartionClose
                                           ON MIBoolean_PartionClose.MovementItemId = MovementItem.Id 
                                          AND MIBoolean_PartionClose.DescId = zc_MIBoolean_PartionClose()
             LEFT JOIN MovementItemString AS MIString_Comment
                                          ON MIString_Comment.MovementItemId = MovementItem.Id 
                                         AND MIString_Comment.DescId = zc_MIString_Comment()
                                         
       WHERE MovementItem.MovementId = inMovementId AND MovementItem.DescId = zc_MI_Master();
    
    RETURN NEXT Cursor1;

    OPEN Cursor2 FOR 
        SELECT 
          MovementItem.Id,
          MovementItem.ObjectId,
          Object_Goods.ObjectCode  AS GoodsCode,
          Object_Goods.ValueData   AS GoodsName,
          MovementItem.Amount,
          MovementItem.isErased,
          MovementItem.ParentId,
          MIString_PartionGoods.ValueData AS PartionName,
          MIFloat_AmountReceipt.ValueData AS AmountReceipt,
          MIString_Comment.ValueData AS Comment
        FROM MovementItem 
             LEFT JOIN Object AS Object_Goods ON Object_Goods.Id = MovementItem.ObjectId

             LEFT JOIN MovementItemString AS MIString_PartionGoods
                                          ON MIString_PartionGoods.DescId = zc_MIString_PartionGoods()
                                         AND MIString_PartionGoods.MovementItemId =  MovementItem.Id

             LEFT JOIN MovementItemFloat AS MIFloat_AmountReceipt
                                         ON MIFloat_AmountReceipt.MovementItemId = MovementItem.Id 
                                        AND MIFloat_AmountReceipt.DescId = zc_MIFloat_AmountReceipt()
             LEFT JOIN MovementItemString AS MIString_Comment
                                          ON MIString_Comment.MovementItemId = MovementItem.Id 
                                         AND MIString_Comment.DescId = zc_MIString_Comment()
       
       WHERE MovementItem.MovementId = inMovementId AND MovementItem.DescId = zc_MI_Child();
       
    RETURN NEXT Cursor2;
 
END;
$BODY$
LANGUAGE PLPGSQL VOLATILE;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
               
 30.06.13                                        *

*/

-- ����
-- SELECT * FROM gpSelect_MI_ProductionUnion (inMovementId:= 1, inShowAll:= TRUE, inSession:= '2')
