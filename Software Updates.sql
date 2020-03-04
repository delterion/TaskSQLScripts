-- ## Disable Software Updates on Terminals in specific Location
-- Need to get LocationNo from Terminal Location Table
update TerminalGlobalChanges
  set ChangeDate = '01/01/2099', Activated = 0
  where TerminalNo in (select terminalno from terminalsetuptable where LocationNo = 79)


-- Enable Software Updates on Terminals in Specific Location
update TerminalGlobalChanges
  set ChangeDate = DATEADD(day,-1,GETDATE())  , Activated = 1
  where TerminalNo in (select terminalno from terminalsetuptable where LocationNo = 79)


