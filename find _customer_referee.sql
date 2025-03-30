"""
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| referee_id  | int     |
+-------------+---------+
In SQL, id is the primary key column for this table.
Each row of this table indicates the id of a customer, their name, and the id of the customer who referred them.
 
"""

DROP TABLE IF EXISTS Customer;

CREATE TABLE IF NOT EXISTS Customer (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    referee_id INT NULL
);

INSERT INTO Customer (id, name, referee_id) VALUES
(1, 'Will', NULL),
(2, 'Jane', NULL),
(3, 'Alex', 2),
(4, 'Bill', NULL),
(5, 'Zack', 1),
(6, 'Mark', 2)
ON CONFLICT (id) DO NOTHING;

SELECT * FROM Customer;

-- Find the names of the customer that are not referred by the customer with id = 2.

SELECT name 
FROM Customer c
WHERE NOT EXISTS (
    SELECT 1 
    FROM Customer 
    WHERE referee_id = 2 AND c.id = id
);

SELECT name 
FROM Customer 
WHERE referee_id != 2 OR referee_id IS NULL;

SELECT name 
FROM Customer 
WHERE referee_id IS DISTINCT FROM 2;
