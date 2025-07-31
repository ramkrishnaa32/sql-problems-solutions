CREATE TABLE orders (
 order_id INT,
 customer_name VARCHAR(50)
);

INSERT INTO orders VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'David'),
(5, 'Emma');

CREATE TABLE invoices (
 invoice_id INT,
 order_id INT,
 status VARCHAR(20)
);

INSERT INTO invoices VALUES
(101, 1, 'Paid'),
(102, 2, 'Pending'),
(103, 4, 'Paid');

SELECT * FROM orders;
SELECT * FROM invoices;

-- Query to find orders without a paid invoice
SELECT o.order_id, o.customer_name, COALESCE(i.status, 'No Invoice') AS status
from orders o
LEFT JOIN invoices i 
ON o.order_id = i.order_id
WHERE i.status IS NULL OR i.status != 'Paid';

WITH temp as (
    SELECT o.order_id, o.customer_name, COALESCE(i.status, 'No Invoice') AS status
    FROM orders o
    LEFT JOIN invoices i
    ON o.order_id = i.order_id
)
SELECT * FROM temp
WHERE status != 'Paid';