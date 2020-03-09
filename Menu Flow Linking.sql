-- ## List out the menu flow windows
select * from TerminalMenuFlowDataOnly where MenuFlowDataId = 763

-- ## Find the Family Settings within the Menu Flow
select * from TerminalMenuFlowDataOnlyFamilySettings where TMFDataId = 763

-- ## List the settings for the part of the menu flow.
select * from TerminalMenuFlowMenuSettings where id = 2309