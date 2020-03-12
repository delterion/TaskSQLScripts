## Copy to AKSPPOS02
robocopy \\aksppos01\c$\task \\aksppos02\c$\task /copyall /mir /xd "\\aksppos01\c$\task\API\AppData\Logs" "\\aksppos01\c$\task\XchangeNet\Services\Data\Cache" "\\aksppos01\c$\task\Sales" /xf web.config
## Copy to AKSPPOS03
robocopy \\aksppos01\c$\task \\aksppos03\c$\task /copyall /mir /xd "\\aksppos01\c$\task\API\AppData\Logs" "\\aksppos01\c$\task\XchangeNet\Services\Data\Cache" "\\aksppos01\c$\task\Sales" /xf web.config
## Copy to AKSPPOS04
robocopy \\aksppos01\c$\task \\aksppos04\c$\task /copyall /mir /xd "\\aksppos01\c$\task\API\AppData\Logs" "\\aksppos01\c$\task\XchangeNet\Services\Data\Cache" "\\aksppos01\c$\task\Sales" /xf web.config