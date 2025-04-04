"
Table: Employee
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| empId       | int     |
| name        | varchar |
| supervisor  | int     |
| salary      | int     |
+-------------+---------+
empId is the column with unique values for this table.
Each row of this table indicates the name and the ID of an employee in addition to their salary and the id of their manager.

Table: Bonus
+-------------+------+
| Column Name | Type |
+-------------+------+
| empId       | int  |
| bonus       | int  |
+-------------+------+
empId is the column of unique values for this table.
empId is a foreign key (reference column) to empId from the Employee table.
Each row of this table contains the id of an employee and their respective bonus.
"

-- Create Employee table if it doesn't exist
DROP TABLE Employee;
DROP TABLE Bonus;

CREATE TABLE IF NOT EXISTS Employee (
    empId INT PRIMARY KEY,
    name VARCHAR(100),
    supervisor INT,
    salary INT
);

-- Create Bonus table if it doesn't exist
CREATE TABLE IF NOT EXISTS Bonus (
    empId INT PRIMARY KEY,
    bonus INT
);

-- Insert data into Employee table
INSERT INTO Employee (empId, name, supervisor, salary) VALUES
(3, 'Brad', NULL, 4000),
(1, 'John', 3, 1000),
(2, 'Dan', 3, 2000),
(4, 'Thomas', 3, 4000);

-- Insert data into Bonus table
INSERT INTO Bonus (empId, bonus) VALUES
(2, 500),
(4, 2000);

"Write a solution to report the name and bonus amount of each employee with a bonus less than 1000."

SELECT e.name, b.bonus
FROM Employee e
LEFT JOIN Bonus b
ON e.empId = b.empId
WHERE b.bonus < 1000 OR b.bonus IS NULL;

-- cte table
WITH cte AS (
    SELECT e.name, b.bonus
    FROM Employee e
    LEFT JOIN Bonus b
    ON e.empId = b.empId
)
SELECT name, bonus
FROM cte
WHERE bonus < 1000 OR bonus IS NULL;     

-- subquery table
SELECT name, bonus
FROM (
    SELECT e.name, b.bonus
    FROM Employee e
    LEFT JOIN Bonus b
    ON e.empId = b.empId
) as subquery
WHERE bonus < 1000 OR bonus IS NULL;