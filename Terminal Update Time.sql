-- Change the Update Check Time for the Terminals.
USE Task_PROD

DECLARE @UpdateTime float

-- Change these as required
SET @UpdateTime = 60

UPDATE TerminalSetupTable
  SET CUI = @UpdateTime
WHERE CUI = 1440

