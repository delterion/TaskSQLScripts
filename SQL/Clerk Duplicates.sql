-- Find Clerks where the payroll id and the clerk logon are the same.  i.e. two of the same.

SELECT 
    PayrollIDNumber, 
    ClerkLogon, 
    COUNT(*) occurrences
FROM TerminalClerkTable
GROUP BY
    PayrollIDNumber, 
    ClerkLogon
HAVING 
    COUNT(*) > 1;
