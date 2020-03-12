-- This scripts results are designed for exporting all products associated with a keypad.  There are some variables that need adjusting for each time you run it to ensure you are getting the correct results.

use Task_PROD

--Get customer no and legal entity
declare @customerNo nvarchar(20)
declare @legalEntity nvarchar(20)

-- @## Make sure this is retuning the correct location.
select @customerNo = GLCode, @legalEntity = RIGHT(LocationCode, 4) from TerminalLocationTable where LocationDescription LIKE '%guardsman%' --'%morr%'

-- ## Make sure this is returning the correct keypad ID.  this is critical to the script.
declare @keypad int
 --select @keypad = KeyPadID from TerminalKeyPads where keypadname LIKE '%guardsman%'
 select @keypad = KeyPadID from TerminalKeyPads where keypadID = 120
 select keypadname from TerminalKeyPads where keypadid= @keypad
--select KeyPadID, Keypadname from TerminalKeyPads where keypadname like '%guardsman%'

declare @keys table(plu int)

--fast products
insert into @keys
select case when keyvalue like '%,%' then left(keyvalue,charindex(',', keyvalue)-1) else keyvalue end
from terminalkeypads k
inner join terminalkeypadkeysetup s on s.keypadid = k.keypadid
where k.keypadid = @keypad
and keytype = 1


--category key
declare @category table(id int, category int)

insert into @category
select x.*
from terminalkeypads k
inner join terminalkeypadkeysetup s on s.keypadid = k.keypadid
cross apply dbo.fn_xnsplitsalesfunction(substring(keyvalue,0,charindex(',',keyvalue,0)),';') as x
where k.keypadid = @keypad
and keytype = 74

insert into @keys
select plu
from terminalproducttable p
inner join @category c on c.category = p.categoryid


--multi plu
insert into @keys
select x.*
from terminalkeypads k
inner join terminalkeypadkeysetup s on s.keypadid = k.keypadid
cross apply dbo.fn_xnsplitstringfunction( replace(substring(keyvalue,0,charindex(',',keyvalue,0)),';',','),',') as x
where k.keypadid = @keypad
and keytype = 82


--Famliy key

Declare @family table (families nvarchar(100))
Insert into @family

Select substring(keyvalue,charindex('[',keyvalue)+1,charindex(']',keyvalue)-1-charindex('[',keyvalue)) from TerminalKeyPadKeySetup where KeyPadID = @keypad 
and KeyType = 75 and substring(keyvalue,charindex('[',keyvalue)+1,charindex(']',keyvalue)-1-charindex('[',keyvalue)) <> ']}'
and substring(keyvalue,charindex('[',keyvalue)+1,charindex(']',keyvalue)-1-charindex('[',keyvalue)) <> ''


Declare @familyIDs table (FID int)

Insert into @familyIDs

Select x.* from
@family
cross apply dbo.fn_xnsplitstringfunction(families,',') as x

Insert into @keys

Select p.PLU
from TerminalProductFamilyEntryTable f
inner join TerminalProductTable p on p.ProductID = f.ProductID
inner join @familyIDs ff on ff.FID = f.FamilyID


select k.plu, t.ProductID as TaskProductID,t.ProductDescription, t.ExternalProductID as ProductID, 
@customerNo as MemberID, @legalEntity as CompanyName,  s.SizeTypeDescription as UnitOfMeasure,t.SizeQty as UnitQuanity, t.IsINstruction, t.IsNonDiminishing,
NULL as SiteID, NULL as CustomerSiteID, NULL as ShippingWarehouseID, NULL as WarehouseLocationID, NULL as Errors
from (select distinct plu from @keys) k 
join TerminalProductTable t 
on k.plu = t.PLU
join TerminalRecipeSizeType s
on t.SizeType = s.SizeTypeID
order by t.ExternalProductID

