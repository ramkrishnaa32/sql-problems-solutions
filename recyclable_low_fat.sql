"""
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| product_id  | int     |
| low_fats    | enum    |
| recyclable  | enum    |
+-------------+---------+
product_id is the primary key (column with unique values) for this table.
low_fats is an ENUM (category) of type ('Y', 'N') where 'Y' means this product is low fat and 'N' means it is not.
recyclable is an ENUM (category) of types ('Y', 'N') where 'Y' means this product is recyclable and 'N' means it is not.
"""

CREATE TYPE fat_status AS ENUM ('Y', 'N');
CREATE TYPE recyclable_status AS ENUM ('Y', 'N');

CREATE TABLE IF NOT EXISTS Products (
    product_id INT PRIMARY KEY,
    low_fats fat_status NOT NULL,
    recyclable recyclable_status NOT NULL
);

INSERT INTO Products (product_id, low_fats, recyclable) VALUES
(0, 'Y', 'N'),
(1, 'Y', 'Y'),
(2, 'N', 'Y'),
(3, 'Y', 'Y'),
(4, 'N', 'N')
ON CONFLICT (product_id) DO NOTHING;

SELECT * FROM Products;

-- Write a solution to find the ids of products that are both low fat and recyclable.

SELECT product_id
FROM Products
WHERE low_fats = 'Y' AND recyclable = 'Y';