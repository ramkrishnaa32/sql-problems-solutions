CREATE TABLE sales_v1 (
    employee VARCHAR(50),
    quarter  VARCHAR(2),
    sales    INT
);

INSERT INTO sales_v1 (employee, quarter, sales) VALUES
('Alice', 'Q1', 1000),
('Alice', 'Q2', 1500),
('Bob',   'Q1', 2000),
('Bob',   'Q2', 2500);

SELECT * FROM sales_v1;

--
SELECT employee,
       SUM(CASE WHEN quarter = 'Q1' THEN sales ELSE 0 END) AS Q1,
       SUM(CASE WHEN quarter = 'Q2' THEN sales ELSE 0 END) AS Q2
FROM sales_v1
GROUP BY employee;

SELECT *
FROM
    (SELECT employee,
            quarter,
            sales
     FROM sales_v1) AS source_table
PIVOT
    (SUM(sales)
     FOR quarter IN ('Q1' AS Q1, 'Q2' AS Q2))
AS pivot_table;