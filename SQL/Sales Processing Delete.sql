-- This script deletes all sales in the sales processing table where the terminal sales are disabled.

-- The first select is the summary of disabled sales in the db.
-- The second select shows that they are deleted.


select tsp.terminalno, count(tsp.terminalno) from TerminalSalesProcessTable tsp
    join TerminalSetupTable tst on tsp.TerminalNo = tst.TerminalNo
    where tst.DisableSales = 1
    GROUP by tsp.TerminalNo

  delete from TerminalSalesProcessTable
  where TerminalNo in(select tsp.terminalno from TerminalSalesProcessTable tsp join TerminalSetupTable tst on tsp.TerminalNo = tst.TerminalNo where tst.DisableSales = 1)

 select tsp.terminalno, count(tsp.terminalno) from TerminalSalesProcessTable tsp
      join TerminalSetupTable tst on tsp.TerminalNo = tst.TerminalNo
      where tst.DisableSales = 1
      GROUP by tsp.TerminalNo