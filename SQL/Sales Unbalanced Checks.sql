USE Task_PROD

DECLARE @GST MONEY
DECLARE @total money
DECLARE @totalex money
DECLARE @items money
DECLARE @diff money
DECLARE @transactionid int
DECLARE @member BIGINT
DECLARE @amount FLOAT
DECLARE @tablenumber money
DECLARE @siblings int
DECLARE @tableuuid uniqueidentifier
DECLARE @parentuuid uniqueidentifier
DECLARE @mergedtransaction int
DECLARE @ignore varchar(6)
DECLARE @location varchar(100)
declare @locationid int
DECLARE @sales FLOAT
DECLARE @clerkid INT
DECLARE @terminalid INT
declare @rounding float
DECLARE @date datetime
DECLARE @fix int
DECLARE @tip money
DECLARE @filter int

set @ignore = NULL
set @siblings = NULL
set @tableuuid = NULL
set @parentuuid = NULL
set @mergedtransaction = NULL

CREATE Table #mytransaction 
   (transactionid int, date datetime,
    total money,
    itemtotal money,
    diff money,
	tip money,
	quantity float,
	rounding float,
    tablenumber varchar(50),
    siblings int,
	tableuuid uniqueidentifier,
    parentuuid uniqueidentifier,
    mergedtransaction int,
	location varchar(100),
    ignore varchar(6))

set ROWCOUNT 0
--select TransactionID into #mytemp from TerminalSales where TransactionID in (2847155 ,2847154 ,2845644 ,2845643 ,2843992 ,2843991 ,2842593 ,2842592 ,2842591 ,2842333 ,2842316 ,2839335 ,2839334 ,2837911)
--select TransactionID into #mytemp from TerminalSales where TransactionID in (2367438,2390093,2391736,2216112,2330022,2335646,2262963,2253938,2383998,2125747,2168720,2228710,2228717,2115542,2356760,2341285,2386732,2259019,2383847,2192845,2383222,2308775,2334040,2239512,2262094,2206905,2335473,2317935,2319506,2247431,2383514,2350911,2380592,2295837,2278962,2278940,2390608,2391061,2391390,2391401,2391482,2305570,2126094,2377772,2246341,2121474,2300222,2383134,2372440,2385555,2359182,2257160,2098834,2257874,2338229,2193665,2377984,2380432,2377837,2318321,2083086,2241727,2272463,2102192,2369581,2327083,2315881,2278613,2242909,2378797,2357535,2243627,2332097,2247439,2286695,2212209,2235929,2390664,2300801,2216393,2065005,2286697,2382542,2346888,2385947,2247444,2139795,2313858,2258397,2131543,2389466,2303186,2354867,2354880,2262514,2354876,2313996,2357323,2082064,2384752,2357722,2246365,2356388,2262352,2357051,2115863,2382676,2121034,2130105,2134166,2283457,2285324,2304656,2320703,2331461,2336650,2338130,2340853,2344692,2344932,2346966,2201710,2217395,2219340,2227530,2229151,2236155,2250658,2378346,2360582,2134494,2285983,2380695,2196864,2246941,2131924,2236993,2370875,2346804,2324074,2390122,2383556,2364928,2258294,2288509,2106594,2326797,2306863,2101263,2275301,2233005,2360382,2371775,2254082,2284794,2315496,2321119,2344907,2228467,2387238,2378258,2360005,2218755,2368924,2291163,2264488,2372171,2384464)
--select TransactionID into #mytemp from TerminalSales where saletype=0 and TransactionID in (2367438,2216112,2330022,2335646,2262963,2253938,2228717,2228710,2168720,2125747,2115542,2356760,2341285,2259019,2192845,2334040,2308775,2262094,2239512,2206905,2335473,2317935,2247431,2350911,2295837,2278962,2278940,2305570,2126094,2246341,2300222,2372440,2359182,2257160,2098834,2338229,2193665,2318321,2083086,2241727,2272463,2369581,2102192,2327083,2315881,2278613,2242909,2357535,2243627,2332097,2247439,2286695,2212209,2300801,2216393,2065005,2286697,2346888,2247444,2139795,2313858,2258397,2131543,2354867,2303186,2354880,2262514,2354876,2313996,2357323,2082064,2357722,2246365,2356388,2262352,2357051,2121034,2340853,2338130,2336650,2331461,2320703,2304656,2285324,2283457,2250658,2236155,2229151,2227530,2219340,2217395,2201710,2134166,2130105,2346966,2344932,2344692,2360582,2285983,2134494,2246941,2196864,2131924,2370875,2346804,2324074,2258294,2288509,2106594,2326797,2306863,2101263,2275301,2233005,2360382,2371775,2254082,2284794,2321119,2315496,2228467,2344907,2360005,2218755,2291163,2264488,2372171)
--select transactionID into #mytemp from TerminalSales where TransactionID in (2034692,2043710,2048737,2061223,2070445,2088951,2090258,2090259,2091471,2091472,2092173,2092174,2098310,2133940,2144195,2160181,2162852,2162855,2162942,2167747,2171333,2172009,2173789,2177224,2178079,2184936,2186986,2191322,2191851,2192295,2192296,2193508,2193531,2201704,2205653,2208658,2226789,2229370,2233043,2233044,2234247,2235510,2236770,2238911,2238920,2241235,2243627,2245787,2247431,2247439,2247444,2249027,2254601,2257859,2258158,2259630,2259881,2263160,2265574,2274378,2274424,2275335,2277756,2280303,2281689,2283810,2284634,2287625,2291972,2291973,2292376,2292906,2292989,2294646,2295129,2295733,2295956,2296005,2298316)
--select TransactionID into #mytemp from TerminalSales where TransactionID >= 2033463
select TransactionID into #mytemp from TerminalSales where SaleDate > '2020-03-01 00:00:00' and SaleType in (0,8)
--select TransactionID into #mytemp from TerminalSales where SaleDate > DATEADD(day,-7,GETDATE()) and SaleType in (0,8)

set ROWCOUNT 1
select @transactionid = transactionid from #mytemp

while @@rowcount <> 0
  BEGIN
    SET ROWCOUNT 0
    --select @GST = ROUND(CONVERT(MONEY,sum(MediaValue*3/23)),2) from terminalsalesmedia where MediaType NOT IN (497,200,95) and TransactionID = @transactionid
  	SELECT @total = ROUND(CONVERT(MONEY,sum(MediaValue)),2) from TerminalSalesMedia where MediaType NOT IN (497,200) and TransactionID = @transactionid
  	--SELECT @totalex = sum(@total-@GST)
  	SELECT @items = ROUND(CONVERT(MONEY,sum(Sales)),2) from TerminalSalesItems where TransactionID = @transactionid
  	SELECT @diff = sum(@total-@items)
	SELECT @tip = ROUND(CONVERT(MONEY,sum(MediaValue)),2) from TerminalSalesMedia where MediaType IN (95,96,97) and TransactionID = @transactionid
	
	--IF @diff = 0 GOTO Next_transaction --GOTO Next Transaction

  	select @tablenumber = tablenumber from TerminalSales where TransactionID = @transactionid
    select @tableuuid = TableChargeHistoryTableGUID from TerminalSales where TransactionID = @transactionid
    select @parentuuid = PreSplitTableGUID from TerminalTableChargeHistoryTableStart where TableChargeHistoryTableGUID = @tableuuid
    select @mergedtransaction = FinalisingTransactionID from TerminalTableChargeHistoryTableStart where PreSplitTableGUID = @parentuuid
	  select @clerkid = ClerkID from TerminalSales where TransactionID = @transactionid
  	select @terminalid = TerminalNo from TerminalSales where TransactionID = @transactionid
  	select @locationid = locationno from TerminalSales where transactionid = @transactionid
  	select @location = LocationDescription from TerminalLocationTable where LocationNo = @locationid
  	select @rounding = sales from terminalsalesitems where transactionid = @transactionid and productid = -99999
  	select @date = saledate from terminalsales where transactionid = @transactionid

	if @tablenumber <> 0 
    BEGIN
		SELECT @siblings = count(ID) from TerminalTableChargeHistoryTableStart where PreSplitTableGUID = @parentuuid
  	END

	set @fix = 0
	IF @fix = 1
	BEGIN
		-- Add $0.01 Rounding Product
		If (@diff = 0.01 and @rounding = 0) or (@diff = 0.01 and @rounding IS NULL)
		BEGIN
			INSERT INTO TerminalSalesItems (TransactionID, ProductID, Qty, Sales, SalesEx, Tax, Cost,PriceLevel, ClerkID, DiscountType, DiscountValue,DiscountOrgValue,PLU,SaleSourcedFrom,DiscountNetOriginalValue)
			VALUES (@transactionid,-99999,1,0.01,0.01,0,0,31,@clerkid,-1,0,0,-99999,@terminalid,0.01)
			SELECT @total = ROUND(CONVERT(MONEY,sum(MediaValue)),2) from TerminalSalesMedia where MediaType NOT IN (497,200) and TransactionID = @transactionid
  			SELECT @items = ROUND(CONVERT(MONEY,sum(Sales)),2) from TerminalSalesItems where TransactionID = @transactionid
  			SELECT @diff = sum(@total-@items)
		END
		
		IF @diff = -0.01 and @rounding = 0.01
		BEGIN
			Update TerminalSalesItems
				SET Sales = 0, SalesEx = 0, Tax = 0
			WHERE TransactionID = @transactionid and ProductID = -99999;
			select @rounding = sales from terminalsalesitems where transactionid = @transactionid and productid = -99999
			SELECT @total = ROUND(CONVERT(MONEY,sum(MediaValue)),2) from TerminalSalesMedia where MediaType NOT IN (497,200) and TransactionID = @transactionid
  			SELECT @items = ROUND(CONVERT(MONEY,sum(Sales)),2) from TerminalSalesItems where TransactionID = @transactionid
  			SELECT @diff = sum(@total-@items)
		END

		IF @diff = 0.02 and @rounding = 0
		BEGIN
			Update TerminalSalesItems
				SET Sales = 0.02, SalesEx = 0.02, Tax = 0
			WHERE TransactionID = @transactionid and ProductID = -99999;
			select @rounding = sales from terminalsalesitems where transactionid = @transactionid and productid = -99999
			SELECT @total = ROUND(CONVERT(MONEY,sum(MediaValue)),2) from TerminalSalesMedia where MediaType NOT IN (497,200) and TransactionID = @transactionid
  			SELECT @items = ROUND(CONVERT(MONEY,sum(Sales)),2) from TerminalSalesItems where TransactionID = @transactionid
  			SELECT @diff = sum(@total-@items)
		END

	END

	-- Total of Quantities of sale to easily identify splits
	DECLARE @quantity money
	Select @quantity = SUM(qty) from terminalsalesitems where TransactionID = @transactionid

	
	SET @filter = 1

	IF @filter = 1
	BEGIN
		IF @total = 0 AND @items = 0
		BEGIN
		  SET @ignore = 'ignore'
		END

		IF @total = 0 AND @items IS NULL
		BEGIN
		  SET @ignore = 'ignore'
		END

		IF @total IS NULL AND @items IS NULL
		BEGIN
		  SET @ignore = 'ignore'
		END

		IF @mergedtransaction IS NOT NULL
		BEGIN
		  SET @ignore = 'ignore'
		END

 		IF @diff = 0
  		BEGIN
  			SET @ignore = 'ignore'
  		END

		IF @tip = @total
		BEGIN
			SET @ignore = 'ignore'
  		END
	END

	IF @diff = 0 and (ROUND(@quantity ,0) = @quantity)
		BEGIN
			SET @ignore = 'ignore'
  		END

	IF @ignore IS NULL
	BEGIN
		INSERT into #mytransaction values (@transactionid, @date, @total, @items, @diff, @tip, @quantity, @rounding, @tablenumber, @siblings, @tableuuid, @parentuuid, @mergedtransaction, @location, @ignore)
	END
    
	Next_transaction:

    set @ignore = NULL
    set @siblings = NULL
    set @tableuuid = NULL
    set @parentuuid = NULL
    set @mergedtransaction = NULL
	  set @rounding = NULL
  	set @date = NULL
  	set @quantity = NULL
  	set @tip = NULL
    
  	delete #mytemp where TransactionID = @transactionid
	  
    set ROWCOUNT 1
    select @transactionid = transactionid from #mytemp
  END

set ROWCOUNT 0

select * from #mytransaction order by transactionid

DROP TABLE #mytemp;
DROP TABLE #mytransaction;