--  This script deletes the sales records for a given set of sales.

SELECT transactionid into #transaction
  from TerminalSales where TransactionID in(3848637, 3848635, 3848634, 3848631, 3848467)

-- select * from #transaction

DELETE from TerminalSalesMedia
  where TransactionID in(select * from #transaction)

DELETE from TerminalSalesItems
  where TransactionID in(select * from #transaction)

DELETE from TerminalSales
  where TransactionID in(select * from #transaction)

DROP table #transaction