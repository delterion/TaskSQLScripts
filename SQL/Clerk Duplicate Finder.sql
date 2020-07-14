
SELECT a.ClerkID, a.ClerkName, a.ClerkSurname, a.ClerkLogon, a.PayrollIDNumber, a.IsActive, a.SalesTotal
FROM TerminalClerkTable a
JOIN (SELECT PayrollIDNumber, COUNT(*) as Count
FROM TerminalClerkTable
WHERE IsActive = 1
GROUP BY PayrollIDNumber
HAVING count(*) > 1 ) b
ON a.PayrollIDNumber = b.PayrollIDNumber
ORDER BY a.PayrollIDNumber


