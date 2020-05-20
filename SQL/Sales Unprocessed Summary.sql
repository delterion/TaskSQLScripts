-- This will output for you if there are any sales errors in the DB
USE Task_PROD

--select TerminalSalesProcessTable.TerminalNo, COUNT(*) as 'Check#', SUM(TerminalSales.SaleTotal) as Amount from TerminalSalesProcessTable
--  join TerminalSales on TerminalSalesProcessTable.TerminalNo = TerminalSales.TerminalNo
--where HasError = 1
--GROUP BY TerminalSalesProcessTable.TerminalNo


select count(*) from TerminalSalesProcessTable

Select TerminalNo, count(TerminalNo) from TerminalSalesProcessTable
  group by TerminalNo

select * from TerminalSalesProcessTable --where Received < DATEADD(day,-7,GETDATE())


