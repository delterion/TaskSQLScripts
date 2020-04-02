-- This gets the last 100 sales from the sales table and tells you what location and what terminal processed it in decensing sale date order.

select top 100 TerminalLocationTable.LocationDescription, TerminalSales.TerminalNo, TerminalSales.TransactionID, TerminalSales.SaleTotal as Amount, SaleDate from TerminalSales
  join TerminalLocationTable on TerminalSales.LocationNo = TerminalLocationTable.LocationNo
where SaleType in (0,8) order BY SaleDate DESC
