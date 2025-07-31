CREATE TABLE IF NOT EXISTS Employee (
    id INT PRIMARY KEY,
    salary INT
);

INSERT INTO Employee (id, salary) VALUES 
(1, 100),
(2, 200),
(3, 300)
ON CONFLICT (id) DO NOTHING; 

SELECT * FROM Employee;

SELECT SecondHighestSalary FROM (
    SELECT salary as SecondHighestSalary
    FROM Employee
    ORDER BY salary DESC
    LIMIT 2
) AS emp 
ORDER BY SecondHighestSalary
LIMIT 1;

SELECT 
    (SELECT DISTINCT salary 
     FROM Employee 
     ORDER BY salary DESC 
     LIMIT 1 OFFSET 1) AS SecondHighestSalary;

SELECT MAX(salary) AS SecondHighestSalary
FROM Employee
WHERE salary < (SELECT MAX(salary) FROM Employee);