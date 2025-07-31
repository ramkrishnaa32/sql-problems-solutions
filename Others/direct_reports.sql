"
Table: Employee
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| department  | varchar |
| managerId   | int     |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table indicates the name of an employee, their department, and the id of their manager.
If managerId is null, then the employee does not have a manager.
No employee will be the manager of themself.
"
-- Drop the table if it already exists
DROP TABLE IF EXISTS Employee;

-- Create the Employee table
CREATE TABLE Employee (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50),
    managerId INT
);

-- Insert sample data
INSERT INTO Employee (id, name, department, managerId) VALUES
(101, 'John',  'A', NULL),
(102, 'Dan',   'A', 101),
(103, 'James', 'A', 101),
(104, 'Amy',   'A', 101),
(105, 'Anne',  'A', 101),
(106, 'Ron',   'B', 101);

SELECT * FROM Employee;

"
Write a solution to find managers with at least five direct reports.
Return the result table in any order.
"
SELECT e.name
FROM Employee e
INNER JOIN ( SELECT managerId, count(*) as totalReports
FROM Employee
GROUP BY managerId
HAVING count(*) >= 5 ) e2
ON e.id = e2.managerid;

SELECT e.name
FROM Employee e
WHERE e.id IN (
    SELECT managerId
    FROM Employee
    GROUP BY managerId
    HAVING COUNT(*) >= 5
);