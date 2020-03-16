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


-- Finds duplicate staff members by matching names and logon
SELECT 
    --ClerkName, 
    --ClerkSurname,
    ClerkLogon, 
    COUNT(*) occurrences
FROM TerminalClerkTable
WHERE PayrollIDNumber IS NOT NULL
GROUP BY
    ClerkName,
    ClerkSurname,
    ClerkLogon
HAVING 
    COUNT(*) > 1;


