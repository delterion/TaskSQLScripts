select top 100 TerminalLocationTable.LocationDescription, TerminalSales.TerminalNo, TerminalSales.SaleTotal as Amount, SaleDate from TerminalSales
  join TerminalLocationTable on TerminalSales.LocationNo = TerminalLocationTable.LocationNo
where SaleType in (0,8) order BY SaleDate DESC
