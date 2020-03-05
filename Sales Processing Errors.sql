-- This will output for you if there are any sales errors in the DB
select * from TerminalSalesProcessTable
where HasError = 1
