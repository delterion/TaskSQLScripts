Use Task_PROD;

--  CREATE table #terminalreport
--   (terminalno int, LocationDescription nvarchar(50), TerminalName nvarchar(50))

SELECT tvt.VenueDescription, tlt.LocationDescription, tst.TerminalNo, tst.TerminalName into #terminalreport from TerminalSetupTable tst join TerminalLocationTable tlt on tst.LocationNo = tlt.LocationNo JOIN TerminalVenueTable tvt on tst.VenueNo = tvt.VenueNo where tst.DisableSales = 0;

UPDATE #terminalreport
   SET TerminalName = 'Swing' 
 where #terminalreport.TerminalName LIKE '%Swing%';

UPDATE #terminalreport
   SET TerminalName = 'Nino' 
 where #terminalreport.TerminalName LIKE '%Nino%';

UPDATE #terminalreport
   SET TerminalName = 'Yuno' 
 where #terminalreport.TerminalName LIKE '%Yuno%';

UPDATE #terminalreport
   SET TerminalName = 'iRuggy' 
 where #terminalreport.TerminalName LIKE '%iRuggy%';

UPDATE #terminalreport
   SET TerminalName = 'TMC7000' 
 where #terminalreport.TerminalName LIKE '%TMC7000%';

-- Uncomment this to get a full list of terminals
-- select * from #terminalreport order by TerminalNo

select VenueDescription, LocationDescription, TerminalName, COUNT(TerminalNo) as Total from #terminalreport group by VenueDescription, LocationDescription, TerminalName order by LocationDescription

DROP TABLE #terminalreport;
