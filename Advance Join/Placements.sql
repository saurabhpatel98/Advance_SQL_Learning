/*
You are given three tables: Students, Friends and Packages. Students contains two columns: ID and Name. Friends contains two columns: ID and Friend_ID (ID of the ONLY best friend). Packages contains two columns: ID and Salary (offered salary in $ thousands per month).



Write a query to output the names of those students whose best friends got offered a higher salary than them. Names must be ordered by the salary amount offered to the best friends. It is guaranteed that no two students got same salary offer.
*/
SELECT t.Name
FROM (
    SELECT s1.ID, s1.Name, p1.Salary, f.Friend_ID, s2.name as friend_name, p2.Salary as friend_salary
    FROM Students s1
    JOIN Packages p1 ON s1.ID = p1.ID
    JOIN Friends f ON s1.ID = f.ID
    JOIN Students s2 ON f.Friend_ID = s2.ID
    JOIN Packages p2 ON f.Friend_ID = p2.ID
    ) t
WHERE t.friend_salary > t.Salary
ORDER BY friend_salary;