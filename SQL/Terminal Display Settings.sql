-- This script copies the display settings from one terminal to another


DECLARE @terminalsource int
DECLARE @terminaltarget int
SET @terminalsource = 28755
SET @terminaltarget = 28708

select * from [TerminalCommsTable] WHERE TerminalNo = @terminalsource

INSERT INTO [TerminalCommsTable] (TerminalNo, DeviceName, DeviceType, PortName, CtsRts, DataBits, DsrDtr, enableDtr, enableRts, Parity, PortSpeed, RS485, StopBits, XonXoff, LastChanged, VGADisplayLayout, RemoteDevice, MemberDisplayID, CommPort, OPOSCompliant, TerminalDestinationID, DestinationIsActive, DontUseLocally, IsRemoteDisplay)

SELECT @terminaltarget,
  [DeviceName],
  [DeviceType],
  [PortName],
  [CtsRts],
  [DataBits],
  [DsrDtr],
  [enableDtr],
  [enableRts],
  [Parity],
  [PortSpeed],
  [RS485],
  [StopBits],
  [XonXoff],
  [LastChanged],
  [VGADisplayLayout],
  [RemoteDevice],
  [MemberDisplayID],
  [CommPort],
  [OPOSCompliant],
  [TerminalDestinationID],
  [DestinationIsActive],
  [DontUseLocally],
  [IsRemoteDisplay]
  FROM [Task_PROD].[dbo].[TerminalCommsTable]
  where TerminalNo = @terminalsource 
 
  select * from [TerminalCommsTable] WHERE TerminalNo = @terminaltarget
