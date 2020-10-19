
use Task_PROD
--Get customer no and legal entity
declare @customerNo nvarchar(20)
declare @legalEntity nvarchar(20)

select @customerNo = GLCode, @legalEntity = RIGHT(LocationCode, 4) from TerminalLocationTable where LocationDescription LIKE '%Tower%' --'%morr%'
--select LocationDescription from TerminalLocationTable where LocationDescription LIKE '%Central%'
declare @keypad int
--select @keypad = KeyPadID from TerminalKeyPads where keypadname LIKE '%Tower%'
select @keypad = KeyPadID from TerminalKeyPads where keypadID = 48
select keypadname from TerminalKeyPads where keypadid= @keypad
--select KeyPadID, Keypadname from TerminalKeyPads where keypadname like '%Tower%'


declare @keys table(id  int identity , plu nvarchar(100))

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


Update @keys set plu = right(plu,10)
where id in (397,
390,
389,
388,
391,
393,
395,
398,
399,
400,
402,
403,
404,
411,
412,
413,
415,
416,
417,
418,
419,
420,
421,
422,
423,
424,
425,
427,
428,
429,
430,
431,
433,
434,
435,
437,
438,
439,
440,
441,
442,
443,
444,
452,
453,
455,
456,
457,
460,
461,
462,
464,
465,
466,
467,
468,
469,
470,
471,
473,
474,
475,
478,
479,
481,
482,
484,
565,
566,
567,
568,
569,
570,
571,
572,
573,
574,
575,
576,
577,
578,
579,
580,
581,
582,
583,
584,
585,
586,
587,
591,
592,
593,
594,
595,
596,
597,
598,
599,
600,
601,
602,
603,
604,
605,
606,
607,
608,
609,
610,
611,
612,
613,
614,
615,
616,
617,
618,
619,
620,
621,
622,
624,
625,
626,
627,
628,
629,
634,
635,
636,
637,
638,
639,
640,
726,
727,
728,
729,
730,
731,
732,
735,
736,
738,
740,
741,
743,
744,
745,
746,
756,
757,
758,
759,
760,
761,
762,
763,
764,
765,
766,
775,
776,
777,
778,
779,
780,
835,
836,
837,
838,
840,
841,
842,
843,
844,
845,
846,
847,
848,
849,
850,
851,
852,
853,
854,
855,
856,
857,
858,
859,
860,
866,
867,
396,
394,
414,
436,
870,
871,
872,
873,
874,
875,
876,
877,
878,
879,
880,
881,
882,
883,
884,
885,
886,
887,
888,
889,
890,
891,
458,
454,
401,
767,
768,
769,
770,
771,
772,
773,
781,
782,
783,
784,
747,
748,
749,
750,
751,
785,
786,
752,
753,
477,
733,
485,
588,
589,
861,
862,
480,
476,
863,
868,
630,
631,
632,
864,
754)

Update @keys set plu = left(plu,8)
where id in (391,
404,
425,
431,
444,
462,
471,
482,
622,
640,
736,
738,
741,
838,
891,
458,
773,
786,
733,
485,
589,
868,
632,
864,
754)

Update @keys set plu = cast('12'+plu as nvarchar(100)) from @keys
where id in (391,
404,
425,
431,
444,
462,
471,
482,
622,
640,
736,
738,
741,
838,
891,
458,
773,
786,
733,
485,
589,
868,
632,
864,
754)


select k.plu, t.ProductID as TaskProductID,t.ProductDescription, t.ExternalProductID as ProductID, 
@customerNo as MemberID, @legalEntity as CompanyName,  s.SizeTypeDescription as UnitOfMeasure,t.SizeQty as UnitQuanity, t.IsINstruction, t.IsNonDiminishing,
NULL as SiteID, NULL as CustomerSiteID, NULL as ShippingWarehouseID, NULL as WarehouseLocationID, NULL as Errors, t.productsizeid, t.productstyleid, t.productcolourid
from (select distinct plu from @keys) k 
join TerminalProductTable t 
on k.plu = t.PLU
join TerminalRecipeSizeType s
on t.SizeType = s.SizeTypeID
order by t.ExternalProductID


