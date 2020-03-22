-- This will output for you if there are any sales errors in the DB
USE Task_PROD

select TerminalLocationTable.LocationDescription, TerminalSalesProcessTable.TerminalNo, COUNT(*) as 'Check#', SUM(TerminalSales.SaleTotal) as Amount from TerminalSalesProcessTable
  join TerminalSales on TerminalSalesProcessTable.TerminalNo = TerminalSales.TerminalNo
  join TerminalLocationTable on TerminalSales.LocationNo = TerminalLocationTable.LocationNo
where HasError = 1
GROUP BY TerminalLocationTable.LocationDescription, TerminalSalesProcessTable.TerminalNo
