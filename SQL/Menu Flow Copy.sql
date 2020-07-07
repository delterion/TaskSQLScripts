
/**
INSERT INTO table2 (column1, column2, column3, ...)
SELECT column1, column2, column3, ...
FROM table1
WHERE condition; 
**/

DECLARE @terminalsource int
DECLARE @terminaltarget int
SET @terminalsource = 28396
SET @terminaltarget = 28314

select * from TerminalMenuFlowSchedulesTerminals WHERE TerminalNo = @terminalsource

INSERT INTO TerminalMenuFlowSchedulesTerminals (ScheduleId, TerminalNo, TMFDataId, uid, GUID_ScheduleId)
SELECT ScheduleId, @terminaltarget, TMFDataId, uid, GUID_ScheduleId
FROM TerminalMenuFlowSchedulesTerminals
WHERE TerminalNo = @terminalsource; 


select * from TerminalMenuFlowSchedulesTerminals WHERE TerminalNo = @terminaltarget