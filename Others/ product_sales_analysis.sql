"
Table: Sales
+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| sale_id     | int   |
| product_id  | int   |
| year        | int   |
| quantity    | int   |
| price       | int   |
+-------------+-------+
(sale_id, year) is the primary key (combination of columns with unique values) of this table.
product_id is a foreign key (reference column) to Product table.
Each row of this table shows a sale on the product product_id in a certain year.
Note that the price is per unit.
 
Table: Product
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| product_id   | int     |
| product_name | varchar |
+--------------+---------+
product_id is the primary key (column with unique values) of this table.
Each row of this table indicates the product name of each product.
"

-- Drop tables if they exist
DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS Product;

-- Create Product table
CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL
);

-- Create Sales table
CREATE TABLE Sales (
    sale_id INT,
    product_id INT,
    year INT,
    quantity INT,
    price INT,
    PRIMARY KEY (sale_id, year),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

-- Insert sample data into Product table
INSERT INTO Product (product_id, product_name) VALUES
(1, 'Laptop'),
(2, 'Smartphone'),
(3, 'Tablet'),
(4, 'Headphones');

-- Insert sample data into Sales table
INSERT INTO Sales (sale_id, product_id, year, quantity, price) VALUES
(101, 1, 2023, 5, 800),
(102, 2, 2023, 10, 500),
(103, 3, 2023, 7, 300),
(104, 4, 2023, 15, 100),
(105, 1, 2024, 3, 850),
(106, 2, 2024, 8, 550),
(107, 3, 2024, 6, 320),
(108, 4, 2024, 20, 120);

-- Verify inserted data
SELECT * FROM Product;
SELECT * FROM Sales;

"
Write a solution to report the product_name, year, and price for each sale_id in the Sales table.
"
SELECT p.product_name, s.year, s.price
FROM Product p
INNER JOIN Sales s
ON p.product_id = s.product_id;