-- ## Check Software Version on Terminals assigned to a Location
select TerminalNo, VenueNo, SoftwareVersion from TerminalSetupTable
  where TerminalNo in (select terminalno from terminalsetuptable where LocationNo = 79)