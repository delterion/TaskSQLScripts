Use Task_PROD;

--  CREATE table #terminalreport
--   (terminalno int, LocationDescription nvarchar(50), TerminalName nvarchar(50))

SELECT tlt.LocationDescription, tst.TerminalNo, tst.TerminalName into #terminalreport from TerminalSetupTable tst join TerminalLocationTable tlt on tst.LocationNo = tlt.LocationNo where tst.DisableSales = 0;

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

-- select * from #terminalreport

select LocationDescription, TerminalName, COUNT(TerminalNo) from #terminalreport group by LocationDescription, TerminalName order by LocationDescription

DROP TABLE #terminalreport;