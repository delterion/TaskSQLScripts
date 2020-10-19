--select ProductID from TerminalProductPrices where PriceLevelID = 79 and price > 0

declare @customerNo nvarchar(20)
declare @legalEntity nvarchar(20)

select @customerNo = GLCode, @legalEntity = RIGHT(LocationCode, 4) from TerminalLocationTable where LocationDescription LIKE '%Tower%' --'%morr%'

select PLU, ProductID as TaskProductID, ProductDescription, ExternalProductID as ProductID, @customerno as MemberID, @legalEntity as CompanyName, s.SizeTypeDescription as UnitOfMeasure,t.SizeQty as UnitQuanity, t.IsINstruction, t.IsNonDiminishing, NULL as SiteID, NULL as CustomerSiteID, NULL as ShippingWarehouseID, NULL as WarehouseLocationID, NULL as Errors, t.productsizeid, t.productstyleid, t.productcolourid
from TerminalProductTable t
join TerminalRecipeSizeType s
on t.SizeType = s.SizeTypeID
where t.ProductID in (select ProductID from TerminalProductPrices where PriceLevelID = 79 and price > 0)