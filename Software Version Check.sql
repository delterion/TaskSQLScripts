-- ## Check Software Version on Terminals assigned to a Location
select TerminalNo, VenueNo, SoftwareVersion from TerminalSetupTable
  where TerminalNo in (select terminalno from terminalsetuptable where LocationNo = 6)

-- ## Count of Terminals with Version
select SoftwareVersion, count(*) as Count from TerminalSetupTable
  group by SoftwareVersion

-- ## Count of Terminals with Version by Outlet
select TerminalLocationTable.LocationDescription, SoftwareVersion, count(*) as Count from TerminalSetupTable JOIN TerminalLocationTable on TerminalSetupTable.LocationNo = TerminalLocationTable.LocationNo
  where SoftwareVersion like '19.1.213%'
  group by TerminalLocationTable.LocationDescription, SoftwareVersion
  Order by TerminalLocationTable.LocationDescription
  
-- ## Get terminals with specific version
select TerminalNo, SoftwareVersion from TerminalSetupTable JOIN TerminalLocationTable on TerminalSetupTable.LocationNo = TerminalLocationTable.LocationNo
  where SoftwareVersion like '19.1.213%'