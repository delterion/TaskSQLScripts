﻿-- This script deletes all sales in the sales processing table where the termional number equals the setting below.

delete from TerminalSalesProcessTable
  where TerminalNo = 28321
