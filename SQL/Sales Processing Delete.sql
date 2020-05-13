-- This script deletes all sales in the sales processing table where the termional number equals the setting below.

-- delete from TerminalSalesProcessTable where TerminalNo = 28321

use Task_PROD
delete from TerminalSalesProcessTable
  where TerminalNo in(28321, 28322, 28381)
