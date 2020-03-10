DECLARE @MenuFlowID int
DECLARE @MenuFlowDataID int
DECLARE @MenuFlowSettingsID int

SET @MenuFlowID  = 1132
SET @MenuFlowDataID = (SELECT ID from TerminalMenuFlowData where MenuFlowID = @MenuFlowID)
SET @MenuFlowSettingsID = (SELECT MenuFlowSettingsId from TerminalMenuFlowData where MenuFlowID = @MenuFlowID)

SELECT * FROM TerminalMenuFlow where MenuFlowID = @MenuFlowID

SELECT * from TerminalMenuFlowData where MenuFlowID = @MenuFlowID

-- ## List out the menu flow windows
select * from TerminalMenuFlowDataOnly where MenuFlowDataId = @MenuFlowDataID

-- ## Find the Family Settings within the Menu Flow
select * from TerminalMenuFlowDataOnlyFamilySettings where TMFDataId = @MenuFlowDataID

-- ## List the settings for the part of the menu flow.
select * from TerminalMenuFlowMenuSettings where id = @MenuFlowSettingsID
