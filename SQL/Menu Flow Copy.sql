-- This script copies the menu flows from one terminal to another

DECLARE @terminalsource int
DECLARE @terminaltarget int
SET @terminalsource = 28755
SET @terminaltarget = 28708

select * from TerminalMenuFlowSchedulesTerminals WHERE TerminalNo = @terminalsource

INSERT INTO TerminalMenuFlowSchedulesTerminals (ScheduleId, TerminalNo, TMFDataId, uid, GUID_ScheduleId)
SELECT ScheduleId, @terminaltarget, TMFDataId, uid, GUID_ScheduleId
FROM TerminalMenuFlowSchedulesTerminals
WHERE TerminalNo = @terminalsource; 


select * from TerminalMenuFlowSchedulesTerminals WHERE TerminalNo = @terminaltarget