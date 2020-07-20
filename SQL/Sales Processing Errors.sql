-- This will output for you if there are any sales errors in the DB
USE Task_PROD

select * from TerminalSalesProcessTable
where HasError = 1

select tsp.terminalno, tlt.LocationDescription, qty = (select count(tsp1.terminalno) from terminalsalesprocesstable tsp1 where tsp1.TerminalNo = tsp.terminalno) from TerminalSalesProcessTable tsp
  join TerminalSetupTable tst on tsp.TerminalNo = tst.TerminalNo
  join TerminalLocationTable tlt on tst.LocationNo = tlt.LocationNo 
where tsp.HasError = 1
