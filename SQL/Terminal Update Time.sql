-- Change the Update Check Time for the Terminals.
USE Task_PROD

DECLARE @UpdateTime float

-- Change these as required
SET @UpdateTime = 240

UPDATE TerminalSetupTable
  SET CUI = @UpdateTime
WHERE CUI = 60

