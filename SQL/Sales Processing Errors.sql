-- This will output for you if there are any sales errors in the DB
USE Task_PROD

select * from TerminalSalesProcessTable
where HasError = 1

