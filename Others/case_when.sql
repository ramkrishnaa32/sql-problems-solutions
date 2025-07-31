-- This SQL script creates a table for employee performance reviews and inserts sample data.
CREATE TABLE employee_performance (
    employee_id INT,
    department VARCHAR(50),
    manager_id INT,
    rating INT,
    bonus DECIMAL(10, 2),
    review_date DATE
);

-- Inserting sample data into employee_performance table
INSERT INTO employee_performance (employee_id, department, manager_id, rating, bonus, review_date) VALUES
(1, 'Sales', 101, 5, 1000.00, '2024-01-15'),
(2, 'Sales', 101, 4, NULL, '2024-02-10'),
(3, 'Engineering', 102, 3, 500.00, '2024-01-20'),
(4, 'Engineering', 102, NULL, NULL, '2024-03-05'),
(5, 'HR', 103, 2, 200.00, '2024-01-25'),
(6, 'HR', 103, 4, NULL, '2024-03-10'),
(7, 'Sales', 101, 1, 100.00, '2024-02-25');

-- Exact duplicate of employee_id 3
INSERT INTO employee_performance (employee_id, department, manager_id, rating, bonus, review_date) VALUES
(3, 'Engineering', 102, 3, 500.00, '2024-01-20');


-- Query to select employee performance with case_when logic
SELECT * FROM employee_performance;

-- Using CASE WHEN to categorize performance ratings
SELECT 
    employee_id,
    department,
    manager_id,
    rating,
    bonus,
    review_date,
    CASE 
        WHEN rating IS NULL THEN 'No Rating'
        WHEN rating = 5 THEN 'Outstanding'
        WHEN rating = 4 THEN 'Exceeds Expectations'
        WHEN rating = 3 THEN 'Meets Expectations'
        WHEN rating = 2 THEN 'Needs Improvement'
        WHEN rating = 1 THEN 'Unsatisfactory'
        ELSE 'Unknown Rating'
    END AS performance_category
    FROM employee_performance;

-- Coalescing to handle NULL values in bonus
SELECT 
    employee_id,
    department,
    manager_id,
    rating,
    COALESCE(bonus, 0.00) AS bonus_amount
FROM employee_performance;

--
SELECT employee_id,
    department,
    manager_id,
    rating,
    bonus,
    review_date,
    row_number() OVER (PARTITION BY employee_id, department, manager_id) AS review_rank
FROM employee_performance;

-- Removing duplicates based on employee_id, department, and manager_id
-- Adding a row_id column to uniquely identify each row

ALTER TABLE employee_performance 
ADD COLUMN row_id SERIAL PRIMARY KEY;

SELECT * FROM employee_performance;

WITH row_ranked AS (
    SELECT row_id,
           ROW_NUMBER() OVER (PARTITION BY employee_id, department, manager_id ORDER BY row_id) AS review_rank
    FROM employee_performance
)
DELETE FROM employee_performance
WHERE row_id IN (
    SELECT row_id
    FROM row_ranked
    WHERE review_rank > 1
);

ALTER TABLE employee_performance 
DROP COLUMN row_id;

-- INCREEMENTAL AGGREGATION: Cumulative bonus by department
-- This query calculates the cumulative bonus for each department, ordered by review date.
SELECT 
    employee_id,
    department,
    bonus,
    review_date,
    SUM(COALESCE(bonus, 0)) OVER (
        PARTITION BY department
        ORDER BY review_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_bonus
FROM employee_performance
ORDER BY department, review_date;


SELECT
    department,
    SUM(CASE WHEN rating = 5 THEN COALESCE(bonus, 0) ELSE 0 END) AS rating_5_bonus,
    SUM(CASE WHEN rating = 4 THEN COALESCE(bonus, 0) ELSE 0 END) AS rating_4_bonus,
    SUM(CASE WHEN rating = 3 THEN COALESCE(bonus, 0) ELSE 0 END) AS rating_3_bonus,
    SUM(CASE WHEN rating = 2 THEN COALESCE(bonus, 0) ELSE 0 END) AS rating_2_bonus,
    SUM(CASE WHEN rating = 1 THEN COALESCE(bonus, 0) ELSE 0 END) AS rating_1_bonus
FROM employee_performance
GROUP BY department
ORDER BY department;

SELECT *,
    CASE 
        WHEN department = 'Engineering' THEN 0
        ELSE 1
    END AS department_order
FROM employee_performance
ORDER BY department_order;


