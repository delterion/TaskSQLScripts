-- Lists all sales in the database since a specific date and time that have a processing delay of x hours.
USE Task_PROD

DECLARE @DateFrom date 
DECLARE @ProcessingDelay int

-- Change these as required
SET @DateFrom = DATEADD(day,-7,GETDATE())  --Now minus 1 day
SET @ProcessingDelay = 3 -- Took longer than 3 hours

SELECT TransactionID, SaleDate, ProcessedDate, tl.LocationDescription, TerminalNo, DATEDIFF(hh, SaleDate, ProcessedDate) AS ProcessingDelay, SaleTotal from terminalsales 
  join TerminalLocationTable tl on tl.LocationNo = terminalsales.LocationNo
  where SaleDate > @DateFrom and SaleType in (0,8) and DATEDIFF(hh, SaleDate, ProcessedDate) > @ProcessingDelay order by SaleDate DESC