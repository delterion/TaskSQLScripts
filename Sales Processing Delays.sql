-- Lists all sales in the database since a specific date and time that have a processing delay of x hours.

DECLARE @SaleDate date
DECLARE @Age int
DECLARE @AgeMeasure varchar(2)

-- Change these as required
SET @SaleDate = DATEADD(day,-1,GETDATE())
SET @Age = 3
SET @AgeMeasure = hh -- hours

SELECT TransactionID, SaleDate, ProcessedDate, tl.LocationDescription, TerminalNo, DATEDIFF(hh, SaleDate, ProcessedDate) AS ProcessingDelay, SaleTotal from terminalsales 
  join TerminalLocationTable tl on tl.LocationNo = terminalsales.LocationNo
  where SaleDate > @SaleDate and SaleType in (0,8) and DATEDIFF(@AgeMeasure, SaleDate, ProcessedDate) > @Age order by SaleDate DESC