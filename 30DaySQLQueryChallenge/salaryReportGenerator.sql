-- ========================================
-- Salary Report Generator
-- Description:
-- This script creates sample salary, income, and deduction data,
-- calculates employee transactions, and generates a pivoted salary report
-- including gross, deductions, and net pay.
-- Database: PostgreSQL (requires tablefunc extension)
-- ========================================

-- ========================================
-- 1. Drop and recreate reference tables
-- ========================================

-- Income types with percentages (e.g., Basic salary, Allowance, etc.)
DROP TABLE IF EXISTS income;
CREATE TABLE income (
    id          INT,
    income      VARCHAR(20),
    percentage  INT
);

INSERT INTO income VALUES
(1, 'Basic', 100),
(2, 'Allowance', 4),
(3, 'Others', 6);

-- Deduction types with percentages (e.g., Insurance, Health, etc.)
DROP TABLE IF EXISTS deduction;
CREATE TABLE deduction (
    id          INT,
    deduction   VARCHAR(20),
    percentage  INT
);

INSERT INTO deduction VALUES
(1, 'Insurance', 5),
(2, 'Health', 6),
(3, 'House', 4);

-- ========================================
-- 2. Employee salary table (sample data)
-- ========================================
-- NOTE: The original script references a "salary" table but does not create it.
-- We'll define it here for completeness.

DROP TABLE IF EXISTS salary;
CREATE TABLE salary (
    emp_id       INT,
    emp_name     VARCHAR(50),
    base_salary  NUMERIC
);

INSERT INTO salary VALUES
(1, 'Alice', 5000),
(2, 'Bob',   6000),
(3, 'Charlie', 5500);

-- ========================================
-- 3. Create transactions from salary + percentages
-- ========================================

DROP TABLE IF EXISTS emp_transaction;
CREATE TABLE emp_transaction (
    emp_id      INT,
    emp_name    VARCHAR(50),
    trns_type   VARCHAR(20),
    amount      NUMERIC
);

INSERT INTO emp_transaction
SELECT 
    s.emp_id, 
    s.emp_name, 
    x.trns_type,
    ROUND(base_salary * (CAST(x.percentage AS DECIMAL) / 100), 2) AS amount
FROM salary s
CROSS JOIN (
    SELECT income AS trns_type, percentage FROM income
    UNION
    SELECT deduction AS trns_type, percentage FROM deduction
) x;

-- ========================================
-- 4. Data checks
-- ========================================
SELECT * FROM salary;
SELECT * FROM income;
SELECT * FROM deduction;
SELECT * FROM emp_transaction;

-- ========================================
-- 5. Enable tablefunc for crosstab
-- ========================================
CREATE EXTENSION IF NOT EXISTS tablefunc;

-- ========================================
-- 6. Pivot employee transactions into salary report
-- ========================================
WITH pivot_cte AS (
    SELECT 
        employee, 
        basic, 
        allowance, 
        others, 
        (basic + allowance + others) AS gross,
        insurance, 
        health, 
        house,
        (insurance + health + house) AS total_deduction,
        (basic + allowance + others) - (insurance + health + house) AS net_pay
    FROM crosstab(
        $$
        SELECT emp_name, trns_type, amount
        FROM emp_transaction
        ORDER BY emp_name, trns_type
        $$,
        $$
        SELECT DISTINCT trns_type
        FROM emp_transaction
        ORDER BY trns_type
        $$
    ) AS result(
        employee   VARCHAR,
        allowance  NUMERIC,
        basic      NUMERIC,
        health     NUMERIC,
        house      NUMERIC,
        insurance  NUMERIC,
        others     NUMERIC
    )
)
SELECT * FROM pivot_cte;

-- ========================================
-- 7. Debugging helpers
-- ========================================
-- Detailed transaction list
SELECT emp_name, trns_type, amount 
FROM emp_transaction
ORDER BY emp_name, trns_type;

-- Distinct transaction types
SELECT DISTINCT trns_type 
FROM emp_transaction
ORDER BY trns_type;
