/*
Symmetric Pairs
Problem:

You are given a table, Functions, containing two columns: X and Y.


Two pairs (X1, Y1) and (X2, Y2) are said to be symmetric pairs if X1 = Y2 and X2 = Y1.

Write a query to output all such symmetric pairs in ascending order by the value of X.

Sample Input


Sample Output

20 20
20 21
22 23

*/

SELECT f1.X,f1.Y
FROM Functions f1, Functions f2
WHERE f1.X=f2.Y AND f1.Y=f2.X
GROUP BY f1.X,f1.Y
HAVING COUNT(f1.X)>1 OR f1.X<f1.Y
ORDER BY f1.X;