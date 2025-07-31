-- Write a solution to find the employees who earn more than their managers.

CREATE TABLE Employee_02 (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT,
    managerId INT
);

INSERT INTO Employee_02 (id, name, salary, managerId) VALUES
(1, 'Alice', 70000, NULL),
(2, 'Bob', 60000, 1),
(3, 'Charlie', 80000, 1),
(4, 'David', 50000, 2),
(5, 'Eve', 90000, 3);

-- Find employees who earn more than their managers

SELECT 
    e1.id AS employee_id,
    e1.name AS employee_name,
    e2.name AS manager_name,
    e1.salary AS employee_salary,
    e2.salary AS manager_salary
FROM 
    Employee_02 e1
JOIN 
    Employee_02 e2 ON e1.managerId = e2.id
WHERE 
    e1.salary > e2.salary;
